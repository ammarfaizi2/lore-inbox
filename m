Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbVECJIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVECJIL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 05:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVECJIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 05:08:10 -0400
Received: from fire.osdl.org ([65.172.181.4]:21915 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261430AbVECJHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 05:07:51 -0400
Date: Tue, 3 May 2005 02:07:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm1
Message-Id: <20050503020705.29bbffbd.akpm@osdl.org>
In-Reply-To: <42773DC0.4050803@reub.net>
References: <fa.gbejpad.1vj8f9r@ifi.uio.no>
	<42773DC0.4050803@reub.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reuben Farrelly <reuben-lkml@reub.net> wrote:
>
> Hi Andrew,
> 
> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc3/2.6.12-rc3-mm1/
> > 
> > - There's still a bug in the new timer code.  If you think you hit it,
> >   please revert 
> > 
> > 	timers-fixes-improvements-fix.patch			then
> > 	timers-fixes-improvements-smp_processor_id-fix.patch	then
> > 	timers-fixes-improvements.patch
> > 
> >   or, better, fix the bug.
> 
> FWIW, I can reproduce this timer bug fairly consistently, by simply 
> rebooting my cisco router.  That means that my linux box has no default 
> gateway, and hence the networking blows up within about 30s and dies 
> with a stack trace which has references to timers.
> 
> I'll back out those three patches and see if it continues, but hopefully 
> my little discovery is useful to someone in terms of coming up with a 
> fix....
> 

Rather than backing things out, please add this instead:


From: Oleg Nesterov <oleg@tv-sign.ru>

The bug was identified by Maneesh Soni.

When __mod_timer() changes timer's base it waits for the completion of
timer->function.  It is just stupid: the caller of __mod_timer() can held
locks which would prevent completion of the timer's handler.

Solution: do not change the base of the currently running timer.

Side effect: __mod_timer() doesn't garantees anymore that timer will run on
the local cpu.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 kernel/timer.c |   42 ++++++++++++++++++++----------------------
 1 files changed, 20 insertions(+), 22 deletions(-)

diff -puN kernel/timer.c~timers-fix-__mod_timer-vs-__run_timers-deadlock kernel/timer.c
--- 25/kernel/timer.c~timers-fix-__mod_timer-vs-__run_timers-deadlock	2005-05-01 02:20:28.415889280 -0700
+++ 25-akpm/kernel/timer.c	2005-05-01 02:20:28.420888520 -0700
@@ -211,41 +211,39 @@ int __mod_timer(struct timer_list *timer
 	timer_base_t *base;
 	tvec_base_t *new_base;
 	unsigned long flags;
-	int ret = -1;
+	int ret;
 
 	BUG_ON(!timer->function);
 	check_timer(timer);
 
-	do {
-		base = lock_timer_base(timer, &flags);
-		new_base = &__get_cpu_var(tvec_bases);
+	base = lock_timer_base(timer, &flags);
 
-		/* Ensure the timer is serialized. */
-		if (base != &new_base->t_base
-			&& base->running_timer == timer)
-			goto unlock;
+	ret = 0;
+	if (timer_pending(timer)) {
+		detach_timer(timer, 0);
+		ret = 1;
+	}
 
-		ret = 0;
-		if (timer_pending(timer)) {
-			detach_timer(timer, 0);
-			ret = 1;
-		}
+	new_base = &__get_cpu_var(tvec_bases);
 
-		if (base != &new_base->t_base) {
+	if (base != &new_base->t_base) {
+		if (unlikely(base->running_timer == timer))
+			/* Don't change timer's base while it is running.
+			 * Needed for serialization of timer wrt itself. */
+			new_base = container_of(base, tvec_base_t, t_base);
+		else {
 			timer->base = NULL;
 			/* Safe: the timer can't be seen via ->entry,
 			 * and lock_timer_base checks ->base != 0. */
 			spin_unlock(&base->lock);
-			base = &new_base->t_base;
-			spin_lock(&base->lock);
-			timer->base = base;
+			spin_lock(&new_base->t_base.lock);
+			timer->base = &new_base->t_base;
 		}
+	}
 
-		timer->expires = expires;
-		internal_add_timer(new_base, timer);
-unlock:
-		spin_unlock_irqrestore(&base->lock, flags);
-	} while (ret < 0);
+	timer->expires = expires;
+	internal_add_timer(new_base, timer);
+	spin_unlock_irqrestore(&new_base->t_base.lock, flags);
 
 	return ret;
 }
_



