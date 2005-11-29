Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbVK2BeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbVK2BeJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 20:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbVK2BeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 20:34:09 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:15806 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932295AbVK2BeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 20:34:08 -0500
Date: Tue, 29 Nov 2005 02:34:07 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] timer locking optimization
Message-ID: <Pine.LNX.4.61.0511290234010.2762@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This simplifies the work done lock_timer_base() and moves it to the less
common path at __mod_timer(). Instead of setting the base to NULL we
already set it to the new base there. If another __mod_timer() gets the
lock it can only move the base to another cpu, so it's enough to check
that base is still the same.
Only add_timer_on() could add timer on the current cpu, but this is not
legal, so we don't have to recheck that the timer has been reactivated
on the current cpu.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 kernel/timer.c |   33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

Index: linux-2.6-mm/kernel/timer.c
===================================================================
--- linux-2.6-mm.orig/kernel/timer.c	2005-11-28 22:32:47.000000000 +0100
+++ linux-2.6-mm/kernel/timer.c	2005-11-28 23:04:46.000000000 +0100
@@ -178,27 +178,22 @@ static inline void detach_timer(struct t
  *
  * So __run_timers/migrate_timers can safely modify all timers which could
  * be found on ->tvX lists.
- *
- * When the timer's base is locked, and the timer removed from list, it is
- * possible to set timer->base = NULL and drop the lock: the timer remains
- * locked.
  */
 static timer_base_t *lock_timer_base(struct timer_list *timer,
 					unsigned long *flags)
 {
 	timer_base_t *base;
 
-	for (;;) {
-		base = timer->base;
-		if (likely(base != NULL)) {
-			spin_lock_irqsave(&base->lock, *flags);
-			if (likely(base == timer->base))
-				return base;
-			/* The timer has migrated to another CPU */
-			spin_unlock_irqrestore(&base->lock, *flags);
-		}
+	base = timer->base;
+	spin_lock_irqsave(&base->lock, *flags);
+	while (unlikely(base != timer->base)) {
+		/* The timer has migrated to another CPU */
+		spin_unlock(&base->lock);
 		cpu_relax();
+		base = timer->base;
+		spin_lock(&base->lock);
 	}
+	return base;
 }
 
 int __mod_timer(struct timer_list *timer, unsigned long expires)
@@ -212,6 +207,7 @@ int __mod_timer(struct timer_list *timer
 
 	base = lock_timer_base(timer, &flags);
 
+restart:
 	if (timer_pending(timer)) {
 		detach_timer(timer, 0);
 		ret = 1;
@@ -231,11 +227,16 @@ int __mod_timer(struct timer_list *timer
 			/* The timer remains on a former base */
 			new_base = container_of(base, tvec_base_t, t_base);
 		} else {
-			/* See the comment in lock_timer_base() */
-			timer->base = NULL;
+			/*
+			 * We shortly release the timer and the timer can
+			 * migrate to another cpu, so recheck the base after
+			 * getting the lock.
+			 */
+			timer->base = &new_base->t_base;
 			spin_unlock(&base->lock);
 			spin_lock(&new_base->t_base.lock);
-			timer->base = &new_base->t_base;
+			if (unlikely(timer->base != &new_base->t_base))
+				goto restart;
 		}
 	}
 
