Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbVEDUYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbVEDUYT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 16:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVEDUXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 16:23:19 -0400
Received: from fire.osdl.org ([65.172.181.4]:59778 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261526AbVEDUWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 16:22:30 -0400
Date: Wed, 4 May 2005 13:23:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Soft lockup with -mm
Message-Id: <20050504132302.2ce4869b.akpm@osdl.org>
In-Reply-To: <42792BC8.9010005@ens-lyon.org>
References: <42792BC8.9010005@ens-lyon.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:
>
> I was seeing a lockup with several -mm releases since 2.6.12-rc2-mm1
> (IIRC). With 2.6.12-rc2-mm1, I remember getting the lockup a few minutes
> after boot time.
> With 2.6.12-rc3-mm1, I waited several days before getting it.
> But, I finally caught this one with netconsole. So here it is:
> 
> BUG: soft lockup detected on CPU#0!
> Pid: 0, comm:              swapper
> EIP: 0060:[<c02d40a5>] CPU: 0
> EIP is at _spin_unlock_irqrestore+0x5/0x30
>  EFLAGS: 00000286    Not tainted  (2.6.12-rc3-mm1=Pignouf)
> EAX: c18e8160 EBX: c18e8160 ECX: 00000001 EDX: 00000286
> ESI: c18e0160 EDI: dbf96c64 EBP: ffffffff DS: 007b ES: 007b
> CR0: 8005003b CR2: b6e43000 CR3: 0e912000 CR4: 00000690
>  [<c012a635>] __mod_timer+0xc5/0xf0

It could be the timer bug.  Can you try it with Oleg's fix?


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

