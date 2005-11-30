Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbVK3Ccr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbVK3Ccr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 21:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVK3Ccr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 21:32:47 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:44232 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750813AbVK3Ccq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 21:32:46 -0500
Date: Wed, 30 Nov 2005 03:32:45 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] timer locking optimization
In-Reply-To: <438C5057.A54AFA83@tv-sign.ru>
Message-ID: <Pine.LNX.4.61.0511300330130.1609@scrub.home>
References: <438C5057.A54AFA83@tv-sign.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 29 Nov 2005, Oleg Nesterov wrote:

> Also, you have wrong value of 'base' after 'goto restart'.

Here is the updated patch, which fixes this.

bye, Roman

Index: linux-2.6/kernel/timer.c
===================================================================
--- linux-2.6.orig/kernel/timer.c	2005-11-29 13:29:35.000000000 +0100
+++ linux-2.6/kernel/timer.c	2005-11-29 14:01:42.000000000 +0100
@@ -178,27 +178,20 @@ static inline void detach_timer(struct t
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
-		cpu_relax();
-	}
+again:
+	base = timer->base;
+	spin_lock_irqsave(&base->lock, *flags);
+	if (likely(base == timer->base))
+		return base;
+	/* The timer has migrated to another CPU */
+	spin_unlock_irqrestore(&base->lock, *flags);
+	goto again;
 }
 
 int __mod_timer(struct timer_list *timer, unsigned long expires)
@@ -210,6 +203,7 @@ int __mod_timer(struct timer_list *timer
 
 	BUG_ON(!timer->function);
 
+restart:
 	base = lock_timer_base(timer, &flags);
 
 	if (timer_pending(timer)) {
@@ -231,11 +225,18 @@ int __mod_timer(struct timer_list *timer
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
+			if (unlikely(timer->base != &new_base->t_base)) {
+				spin_unlock_irqrestore(&new_base->t_base.lock, flags);
+				goto restart;
+			}
 		}
 	}
 
