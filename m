Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262644AbVCSR1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262644AbVCSR1o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 12:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbVCSR03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 12:26:29 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:31910 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S262640AbVCSRYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 12:24:49 -0500
Message-ID: <423C6FC0.CA4F9EF3@tv-sign.ru>
Date: Sat, 19 Mar 2005 21:30:24 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Christoph Lameter <christoph@lameter.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/5] timers: rework del_timer_sync()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New rules:
	->_base &  1	: is timer pending
	->_base & ~1	: where the timer was last scheduled

->_base == NULL means that this timer is not running on any cpu.

del_timer_sync() clears ->_base, it is merely an optimization, so
that subsequent del_timer calls do not need locking.

del_timer_sync() assumes that the timer's base == (->_base & ~1)
can't be changed during execution of timer->function. It is achieved
by the next patch.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.12-rc1/include/linux/timer.h~2_SYNC	2005-03-19 15:05:46.000000000 +0300
+++ 2.6.12-rc1/include/linux/timer.h	2005-03-19 15:28:13.000000000 +0300
@@ -21,9 +21,26 @@ struct timer_list {
 	struct tvec_t_base_s *_base;
 };
 
+/*
+ * To save space, we play games with the least significant bit
+ * of timer_list->_base.
+ *
+ * If (_base & __TIMER_PENDING), the timer is pending. Implies
+ * (_base & ~__TIMER_PENDING) != NULL.
+ *
+ * (_base & ~__TIMER_PENDING), if != NULL, is the address of the
+ * timer's per-cpu tvec_t_base_s where it was last scheduled and
+ * where it may still be running.
+ *
+ * If (_base == NULL), the timer was not scheduled yet or it was
+ * cancelled by del_timer_sync(), so it is not running on any CPU.
+ */
+
+#define	__TIMER_PENDING	1
+
 static inline int __timer_pending(struct tvec_t_base_s *base)
 {
-	return base != NULL;
+	return ((unsigned long)base & __TIMER_PENDING) != 0;
 }
 
 #define TIMER_MAGIC	0x4b87ad6e
--- 2.6.12-rc1/kernel/timer.c~2_SYNC	2005-03-19 15:05:46.000000000 +0300
+++ 2.6.12-rc1/kernel/timer.c	2005-03-19 17:19:44.000000000 +0300
@@ -88,16 +88,26 @@ static inline void set_running_timer(tve
 
 static inline tvec_base_t *__get_base(struct timer_list *timer)
 {
-	return timer->_base;
+	tvec_base_t *base = timer->_base;
+
+	if (__timer_pending(base))
+		return (void*)base - __TIMER_PENDING;
+	else
+		return NULL;
 }
 
 static inline void __set_base(struct timer_list *timer,
 				tvec_base_t *base, int pending)
 {
 	if (pending)
-		timer->_base = base;
+		timer->_base = (void*)base + __TIMER_PENDING;
 	else
-		timer->_base = NULL;
+		timer->_base = base;
+}
+
+static inline tvec_base_t *timer_base(struct timer_list *timer)
+{
+	return (tvec_base_t*)((unsigned long)timer->_base & ~__TIMER_PENDING);
 }
 
 /* Fake initialization */
@@ -346,41 +356,46 @@ EXPORT_SYMBOL(del_timer);
  * Synchronization rules: callers must prevent restarting of the timer,
  * otherwise this function is meaningless. It must not be called from
  * interrupt contexts. The caller must not hold locks which would prevent
- * completion of the timer's handler.  Upon exit the timer is not queued and
- * the handler is not running on any CPU.
+ * completion of the timer's handler. The timer's handler must not call
+ * add_timer_on(). Upon exit the timer is not queued and the handler is
+ * not running on any CPU.
  *
  * The function returns whether it has deactivated a pending timer or not.
- *
- * del_timer_sync() is slow and complicated because it copes with timer
- * handlers which re-arm the timer (periodic timers).  If the timer handler
- * is known to not do this (a single shot timer) then use
- * del_singleshot_timer_sync() instead.
  */
 int del_timer_sync(struct timer_list *timer)
 {
-	tvec_base_t *base;
-	int i, ret = 0;
+	int ret;
 
 	check_timer(timer);
 
-del_again:
-	ret += del_timer(timer);
+	ret = 0;
+	for (;;) {
+		unsigned long flags;
+		tvec_base_t *base;
 
-	for_each_online_cpu(i) {
-		base = &per_cpu(tvec_bases, i);
-		if (base->running_timer == timer) {
-			while (base->running_timer == timer) {
-				cpu_relax();
-				preempt_check_resched();
-			}
-			break;
+		base = timer_base(timer);
+		if (!base)
+			return ret;
+
+		spin_lock_irqsave(&base->lock, flags);
+
+		if (base->running_timer == timer)
+			goto unlock;
+
+		if (timer_base(timer) != base)
+			goto unlock;
+
+		if (timer_pending(timer)) {
+			list_del(&timer->entry);
+			ret = 1;
 		}
+		/* Need to make sure that anybody who sees a NULL base
+		 * also sees the list ops */
+		smp_wmb();
+		timer->_base = NULL;
+unlock:
+		spin_unlock_irqrestore(&base->lock, flags);
 	}
-	smp_rmb();
-	if (timer_pending(timer))
-		goto del_again;
-
-	return ret;
 }
 EXPORT_SYMBOL(del_timer_sync);
