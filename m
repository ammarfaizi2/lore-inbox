Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVEBMbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVEBMbf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 08:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbVEBMbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 08:31:35 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:44162 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261210AbVEBMb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 08:31:26 -0400
Message-ID: <42761F45.F01E6A41@tv-sign.ru>
Date: Mon, 02 May 2005 16:38:29 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] timers: comments update
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On top of "timers-fix-__mod_timer-vs-__run_timers-deadlock-tidy.patch"
in the -mm tree.

This patch tries to document new locking rules in kernel/timer.c.

Andrew, is it ok? I'll try to improve it if you think it is not
clear/complete enough.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.12-rc3-mm1/kernel/timer.c~	Mon May  2 11:39:36 2005
+++ 2.6.12-rc3-mm1/kernel/timer.c	Mon May  2 16:01:07 2005
@@ -159,6 +159,10 @@ static void internal_add_timer(tvec_base
 }
 
 typedef struct timer_base_s timer_base_t;
+/*
+ * Used by TIMER_INITIALIZER, we can't use per_cpu(tvec_bases)
+ * at compile time, and we need timer->base to lock the timer.
+ */
 timer_base_t __init_timer_base
 	____cacheline_aligned_in_smp = { .lock = SPIN_LOCK_UNLOCKED };
 EXPORT_SYMBOL(__init_timer_base);
@@ -189,6 +193,18 @@ static inline void detach_timer(struct t
 	entry->prev = LIST_POISON2;
 }
 
+/*
+ * We are using hashed locking: holding per_cpu(tvec_bases).t_base.lock
+ * means that all timers which are tied to this base via timer->base are
+ * locked, and the base itself is locked too.
+ *
+ * So __run_timers/migrate_timers can safely modify all timers which could
+ * be found on ->tvX lists.
+ *
+ * When the timer's base is locked, and the timer removed from list, it is
+ * possible to set timer->base = NULL and drop the lock: the timer remains
+ * locked.
+ */
 static timer_base_t *lock_timer_base(struct timer_list *timer,
 					unsigned long *flags)
 {
@@ -196,11 +212,11 @@ static timer_base_t *lock_timer_base(str
 
 	for (;;) {
 		base = timer->base;
-		/* Can be NULL while __mod_timer switches bases */
 		if (likely(base != NULL)) {
 			spin_lock_irqsave(&base->lock, *flags);
 			if (likely(base == timer->base))
 				return base;
+			/* The timer has migrated to another CPU */
 			spin_unlock_irqrestore(&base->lock, *flags);
 		}
 		cpu_relax();
@@ -227,18 +243,19 @@ int __mod_timer(struct timer_list *timer
 	new_base = &__get_cpu_var(tvec_bases);
 
 	if (base != &new_base->t_base) {
+		/*
+		 * We are trying to schedule the timer on the local CPU.
+		 * However we can't change timer's base while it is running,
+		 * otherwise del_timer_sync() can't detect that the timer's
+		 * handler yet has not finished. This also garantees that
+		 * the timer is serialized wrt itself.
+		 */
 		if (unlikely(base->running_timer == timer)) {
-			/*
-			 * Don't change timer's base while it is running.
-			 * Needed for serialization of timer wrt itself.
-			 */
+			/* The timer remains on a former base */
 			new_base = container_of(base, tvec_base_t, t_base);
 		} else {
+			/* See the comment in lock_timer_base() */
 			timer->base = NULL;
-			/*
-			 * Safe: the timer can't be seen via ->entry and
-			 * lock_timer_base() checks ->base != 0.
-			 */
 			spin_unlock(&base->lock);
 			spin_lock(&new_base->t_base.lock);
 			timer->base = &new_base->t_base;
