Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbVCOQRC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVCOQRC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 11:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVCOQPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 11:15:47 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:23209 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261402AbVCOQOh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 11:14:37 -0500
Message-ID: <42371941.CCBAB134@tv-sign.ru>
Date: Tue, 15 Mar 2005 20:20:01 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org, Shai Fultheim <Shai@Scalex86.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH 2/2] del_timer_sync: proof of concept
References: <4231E959.141F7D85@tv-sign.ru> <Pine.LNX.4.58.0503111254270.25992@server.graphe.net>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New rules:
	->_base &  1	: is timer pending
	->_base & ~1	: timer's base

If ->_base == NULL, this timer is not running on any cpu.
Cleared only in del_timer_sync().

Note that now we don't need del_singleshot_timer_sync().

Here is the code of del_timer_sync:

int del_timer_sync(struct timer_list *timer)
{
	int ret = 0;

	for (;;) {
		unsigned long flags;
		tvec_base_t *_base, *base;

		_base = timer->_base;
		if (!_base)
			return ret;

		base = __timer_base(_base);
		spin_lock_irqsave(&base->lock, flags);

		if (timer->_base != _base)
			goto unlock;

		if (base->running_timer == timer)
			goto unlock;

		if (__timer_pending(_base)) {
			list_del(&timer->entry);
			ret = 1;
		}
		smp_wmb();
		timer->_base = NULL;
unlock:
		spin_unlock_irqrestore(&base->lock, flags);
	}
}

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.11/include/linux/timer.h~2_PEND	2005-03-15 17:49:19.000000000 +0300
+++ 2.6.11/include/linux/timer.h	2005-03-15 18:09:06.000000000 +0300
@@ -21,9 +21,11 @@ struct timer_list {
 	struct tvec_t_base_s *_base;
 };
 
+#define	__TIMER_PENDING	1
+
 static inline int __timer_pending(struct tvec_t_base_s *base)
 {
-	return base != NULL;
+	return ((unsigned long)base & __TIMER_PENDING) != 0;
 }
 
 #define TIMER_MAGIC	0x4b87ad6e
--- 2.6.11/kernel/timer.c~2_PEND	2005-03-15 17:55:00.000000000 +0300
+++ 2.6.11/kernel/timer.c	2005-03-15 19:52:48.000000000 +0300
@@ -86,16 +86,26 @@ static inline void set_running_timer(tve
 
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
+static inline tvec_base_t *__timer_base(tvec_base_t *base)
+{
+	return (tvec_base_t*)((unsigned long)base & ~__TIMER_PENDING);
 }
 
 /* Fake initialization */
@@ -356,29 +366,39 @@ EXPORT_SYMBOL(del_timer);
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
+		tvec_base_t *_base, *base;
+
+		_base = timer->_base;
+		if (!_base)
+			return ret;
 
-	for_each_online_cpu(i) {
-		base = &per_cpu(tvec_bases, i);
-		if (base->running_timer == timer) {
-			while (base->running_timer == timer) {
-				cpu_relax();
-				preempt_check_resched();
-			}
-			break;
+		base = __timer_base(_base);
+		spin_lock_irqsave(&base->lock, flags);
+
+		if (timer->_base != _base)
+			goto unlock;
+
+		if (base->running_timer == timer)
+			goto unlock;
+
+		if (__timer_pending(_base)) {
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
