Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261940AbVC1Qpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbVC1Qpa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 11:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVC1Qpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 11:45:30 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:15508 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261940AbVC1Qog (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 11:44:36 -0500
Message-ID: <424835D5.99FDB1D5@tv-sign.ru>
Date: Mon, 28 Mar 2005 20:50:29 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Christoph Lameter <christoph@lameter.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH rc1-mm3] timers: simplify locking
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the last one, I promise.
On top of "[PATCH rc1-mm3] timers: kill timer_list->lock", see
http://marc.theaimsgroup.com/?l=linux-kernel&m=111193319932543

This patch adds lock_timer() helper, which locks timer's base,
and checks it is still the same and != NULL.

After the previous patch the timer's base is never NULL. With
this patch __mod_timer() temporaly sets ->_base = __TIMER_PENDING
after deletion of timer, so the timer is still pending and can't
be locked by lock_timer().

The result is that __mod_timer() does not need to lock both bases.
Now it can do:
	old_base = lock_timer()
	list_del(timer)
	__set_base(timer, NULL, 1)
	unlock(old_base)
		// The timer can't be seen by __run_timers(old_base).
		// Still pending, del_timer() will call lock_timer().
		// Nobody can modify it, lock_timer() will wait.
	lock_new(new_base)
	add timer
	unlock(new_base)

This slightly speedups __mod_timer(), and in my opinion simplifies
the code. I hope it may also improve scalability of timers.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- rc1-mm3/include/linux/timer.h~	2005-03-28 22:42:38.000000000 +0400
+++ rc1-mm3/include/linux/timer.h	2005-03-29 00:42:49.000000000 +0400
@@ -33,11 +33,6 @@ struct timer_list {
 
 #define	__TIMER_PENDING	1
 
-static inline int __timer_pending(struct tvec_t_base_s *base)
-{
-	return ((unsigned long)base & __TIMER_PENDING) != 0;
-}
-
 #define TIMER_MAGIC	0x4b87ad6e
 
 extern struct fake_timer_base fake_timer_base;
@@ -64,7 +59,7 @@ void fastcall init_timer(struct timer_li
  */
 static inline int timer_pending(const struct timer_list * timer)
 {
-	return __timer_pending(timer->_base);
+	return ((unsigned long)timer->_base & __TIMER_PENDING) != 0;
 }
 
 extern void add_timer_on(struct timer_list *timer, int cpu);
--- rc1-mm3/kernel/timer.c~	2005-03-27 21:07:29.000000000 +0400
+++ rc1-mm3/kernel/timer.c	2005-03-29 00:42:49.000000000 +0400
@@ -199,56 +199,59 @@ static void internal_add_timer(tvec_base
 	list_add_tail(&timer->entry, vec);
 }
 
+static tvec_base_t *lock_timer(struct timer_list *timer, unsigned long *flags)
+{
+	tvec_base_t *base;
+
+	for (;;) {
+		base = timer_base(timer);
+		/* Can be NULL when __mod_timer switches bases */
+		if (likely(base)) {
+			spin_lock_irqsave(&base->lock, *flags);
+			if (likely(base == timer_base(timer)))
+				return base;
+			spin_unlock_irqrestore(&base->lock, *flags);
+		}
+		cpu_relax();
+	}
+}
+
 int __mod_timer(struct timer_list *timer, unsigned long expires)
 {
-	tvec_base_t *old_base, *new_base;
+	tvec_base_t *base, *new_base;
 	unsigned long flags;
-	int new_lock;
 	int ret = -1;
 
 	BUG_ON(!timer->function);
 	check_timer(timer);
 
 	do {
-		local_irq_save(flags);
+		base = lock_timer(timer, &flags);
 		new_base = &__get_cpu_var(tvec_bases);
-		old_base = timer_base(timer);
 
-		/* Prevent AB-BA deadlocks.
-		 * NOTE: (old_base == new_base) => (new_lock == 0)
-		 */
-		new_lock = old_base < new_base;
-		if (new_lock)
-			spin_lock(&new_base->lock);
-		spin_lock(&old_base->lock);
-
-		if (timer_base(timer) != old_base)
+		if (base != new_base
+			&& base->running_timer == timer)
 			goto unlock;
 
-		if (old_base != new_base) {
-			/* Ensure the timer is serialized. */
-			if (old_base->running_timer == timer)
-				goto unlock;
-
-			if (!new_lock) {
-				spin_lock(&new_base->lock);
-				new_lock = 1;
-			}
-		}
-
 		ret = 0;
 		if (timer_pending(timer)) {
 			list_del(&timer->entry);
 			ret = 1;
 		}
 
+		if (base != new_base) {
+			__set_base(timer, NULL, 1);
+			/* Safe, lock_timer checks base != NULL */
+			spin_unlock(&base->lock);
+			base = new_base;
+			spin_lock(&base->lock);
+		}
+
 		timer->expires = expires;
-		internal_add_timer(new_base, timer);
-		__set_base(timer, new_base, 1);
+		internal_add_timer(base, timer);
+		__set_base(timer, base, 1);
 unlock:
-		if (new_lock)
-			spin_unlock(&new_base->lock);
-		spin_unlock_irqrestore(&old_base->lock, flags);
+		spin_unlock_irqrestore(&base->lock, flags);
 	} while (ret == -1);
 
 	return ret;
@@ -331,26 +334,22 @@ EXPORT_SYMBOL(mod_timer);
 int del_timer(struct timer_list *timer)
 {
 	unsigned long flags;
-	tvec_base_t *_base, *base;
+	tvec_base_t *base;
+	int ret = 0;
 
 	check_timer(timer);
 
-repeat:
-	_base = timer->_base;
-	if (!__timer_pending(_base))
-		return 0;
-
-	base = (void*)_base - __TIMER_PENDING;
-	spin_lock_irqsave(&base->lock, flags);
-	if (_base != timer->_base) {
+	if (timer_pending(timer)) {
+		base = lock_timer(timer, &flags);
+		if (timer_pending(timer)) {
+			list_del(&timer->entry);
+			__set_base(timer, base, 0);
+			ret = 1;
+		}
 		spin_unlock_irqrestore(&base->lock, flags);
-		goto repeat;
 	}
-	list_del(&timer->entry);
-	__set_base(timer, base, 0);
-	spin_unlock_irqrestore(&base->lock, flags);
 
-	return 1;
+	return ret;
 }
 
 EXPORT_SYMBOL(del_timer);
@@ -382,15 +381,11 @@ int del_timer_sync(struct timer_list *ti
 	check_timer(timer);
 
 	do {
-		base = timer_base(timer);
-		spin_lock_irqsave(&base->lock, flags);
+		base = lock_timer(timer, &flags);
 
 		if (base->running_timer == timer)
 			goto unlock;
 
-		if (timer_base(timer) != base)
-			goto unlock;
-
 		ret = 0;
 		if (timer_pending(timer)) {
 			list_del(&timer->entry);
@@ -1362,14 +1357,8 @@ static void __devinit migrate_timers(int
 	new_base = &get_cpu_var(tvec_bases);
 
 	local_irq_disable();
-	/* Prevent deadlocks via ordering by old_base < new_base. */
-	if (old_base < new_base) {
-		spin_lock(&new_base->lock);
-		spin_lock(&old_base->lock);
-	} else {
-		spin_lock(&old_base->lock);
-		spin_lock(&new_base->lock);
-	}
+	spin_lock(&new_base->lock);
+	spin_lock(&old_base->lock);
 
 	if (old_base->running_timer)
 		BUG();
