Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbVCSRZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVCSRZs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 12:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbVCSRZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 12:25:47 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:30118 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261625AbVCSRYm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 12:24:42 -0500
Message-ID: <423C6FB9.29D0AEA3@tv-sign.ru>
Date: Sat, 19 Mar 2005 21:30:17 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Christoph Lameter <christoph@lameter.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/5] timers: prepare for del_timer_sync() changes
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are problems with del_timer_sync().

1. Scalability. All cpus are scanned to determine if the timer is
running on that cpu.

2. It is racy. The timer can be fired again after del_timer_sync
have checked all cpus and before it will recheck timer_pending().

This patch adds 'pending flag' to timer_list. This flag is encoded
in the least significant bit of timer->base. This way we do not
waste the space and can read/write base+pending atomically.

__run_timers(), del_timer() do not set ->base = NULL anymore, they
only clear pending flag, so that del_timer_sync can wait while
timer->base->running_timer == timer.

It works only if recurring timer do not use add_timer_on().

The following patch  renames ->base to ->_base. Now this field is
used directly only in __get_base/__set_base helpers.

No changes in kernel/timer.o.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.12-rc1/include/linux/timer.h~1_BASE	2005-03-19 14:54:58.000000000 +0300
+++ 2.6.12-rc1/include/linux/timer.h	2005-03-19 15:05:46.000000000 +0300
@@ -18,16 +18,21 @@ struct timer_list {
 	void (*function)(unsigned long);
 	unsigned long data;
 
-	struct tvec_t_base_s *base;
+	struct tvec_t_base_s *_base;
 };
 
+static inline int __timer_pending(struct tvec_t_base_s *base)
+{
+	return base != NULL;
+}
+
 #define TIMER_MAGIC	0x4b87ad6e
 
 #define TIMER_INITIALIZER(_function, _expires, _data) {		\
 		.function = (_function),			\
 		.expires = (_expires),				\
 		.data = (_data),				\
-		.base = NULL,					\
+		._base = NULL,					\
 		.magic = TIMER_MAGIC,				\
 		.lock = SPIN_LOCK_UNLOCKED,			\
 	}
@@ -41,7 +46,7 @@ struct timer_list {
  */
 static inline void init_timer(struct timer_list * timer)
 {
-	timer->base = NULL;
+	timer->_base = NULL;
 	timer->magic = TIMER_MAGIC;
 	spin_lock_init(&timer->lock);
 }
@@ -58,7 +63,7 @@ static inline void init_timer(struct tim
  */
 static inline int timer_pending(const struct timer_list * timer)
 {
-	return timer->base != NULL;
+	return __timer_pending(timer->_base);
 }
 
 extern void add_timer_on(struct timer_list *timer, int cpu);
--- 2.6.12-rc1/kernel/timer.c~1_BASE	2005-03-19 14:55:17.000000000 +0300
+++ 2.6.12-rc1/kernel/timer.c	2005-03-19 15:05:46.000000000 +0300
@@ -86,6 +86,20 @@ static inline void set_running_timer(tve
 #endif
 }
 
+static inline tvec_base_t *__get_base(struct timer_list *timer)
+{
+	return timer->_base;
+}
+
+static inline void __set_base(struct timer_list *timer,
+				tvec_base_t *base, int pending)
+{
+	if (pending)
+		timer->_base = base;
+	else
+		timer->_base = NULL;
+}
+
 /* Fake initialization */
 static DEFINE_PER_CPU(tvec_base_t, tvec_bases) = { SPIN_LOCK_UNLOCKED };
 
@@ -169,7 +183,7 @@ int __mod_timer(struct timer_list *timer
 	spin_lock_irqsave(&timer->lock, flags);
 	new_base = &__get_cpu_var(tvec_bases);
 repeat:
-	old_base = timer->base;
+	old_base = __get_base(timer);
 
 	/*
 	 * Prevent deadlocks via ordering by old_base < new_base.
@@ -186,14 +200,14 @@ repeat:
 		 * The timer base might have been cancelled while we were
 		 * trying to take the lock(s):
 		 */
-		if (timer->base != old_base) {
+		if (__get_base(timer) != old_base) {
 			spin_unlock(&new_base->lock);
 			spin_unlock(&old_base->lock);
 			goto repeat;
 		}
 	} else {
 		spin_lock(&new_base->lock);
-		if (timer->base != old_base) {
+		if (__get_base(timer) != old_base) {
 			spin_unlock(&new_base->lock);
 			goto repeat;
 		}
@@ -209,7 +223,7 @@ repeat:
 	}
 	timer->expires = expires;
 	internal_add_timer(new_base, timer);
-	timer->base = new_base;
+	__set_base(timer, new_base, 1);
 
 	if (old_base && (new_base != old_base))
 		spin_unlock(&old_base->lock);
@@ -239,7 +253,7 @@ void add_timer_on(struct timer_list *tim
 
 	spin_lock_irqsave(&base->lock, flags);
 	internal_add_timer(base, timer);
-	timer->base = base;
+	__set_base(timer, base, 1);
 	spin_unlock_irqrestore(&base->lock, flags);
 }
 
@@ -301,18 +315,18 @@ int del_timer(struct timer_list *timer)
 	check_timer(timer);
 
 repeat:
- 	base = timer->base;
+ 	base = __get_base(timer);
 	if (!base)
 		return 0;
 	spin_lock_irqsave(&base->lock, flags);
-	if (base != timer->base) {
+	if (base != __get_base(timer)) {
 		spin_unlock_irqrestore(&base->lock, flags);
 		goto repeat;
 	}
 	list_del(&timer->entry);
 	/* Need to make sure that anybody who sees a NULL base also sees the list ops */
 	smp_wmb();
-	timer->base = NULL;
+	__set_base(timer, base, 0);
 	spin_unlock_irqrestore(&base->lock, flags);
 
 	return 1;
@@ -415,7 +429,7 @@ static int cascade(tvec_base_t *base, tv
 		struct timer_list *tmp;
 
 		tmp = list_entry(curr, struct timer_list, entry);
-		BUG_ON(tmp->base != base);
+		BUG_ON(__get_base(tmp) != base);
 		curr = curr->next;
 		internal_add_timer(base, tmp);
 	}
@@ -465,7 +479,7 @@ repeat:
 			list_del(&timer->entry);
 			set_running_timer(base, timer);
 			smp_wmb();
-			timer->base = NULL;
+			__set_base(timer, base, 0);
 			spin_unlock_irq(&base->lock);
 			{
 				u32 preempt_count = preempt_count();
@@ -1314,7 +1328,7 @@ static int migrate_timer_list(tvec_base_
 			return 0;
 		list_del(&timer->entry);
 		internal_add_timer(new_base, timer);
-		timer->base = new_base;
+		__set_base(timer, new_base, 1);
 		spin_unlock(&timer->lock);
 	}
 	return 1;
