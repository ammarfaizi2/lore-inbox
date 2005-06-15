Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVFOTeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVFOTeq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 15:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbVFOTeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 15:34:46 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:17891 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261519AbVFOTeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 15:34:36 -0400
Subject: [PATCH] Re: [BUG] Race condition with it_real_fn in kernel/itimer.c
From: Steven Rostedt <rostedt@goodmis.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1118860623.4508.70.camel@localhost.localdomain>
References: <42B067BD.F4526CD@tv-sign.ru>
	 <1118860623.4508.70.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 15 Jun 2005 15:34:03 -0400
Message-Id: <1118864043.4508.81.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-15 at 14:37 -0400, Steven Rostedt wrote:

> 
> I haven't played too much with the itimer, what harm can happen if the
> timer is running while this is deleted?  [examines code here] This also
> looks bad. Since the softirq function can be running and then call
> it_real_arm unprotected! And you can see here that it_real_arm is also
> called and they both call add_timer! This would not work, so far the
> first patch seems to handle this. 

Ha! There's even another problem that I just noticed.  it_real_value
could return zero while the function is running! So you don't get the
protection here either!  Take a look here to see what the problem is.

static unsigned long it_real_value(struct signal_struct *sig)
{
	unsigned long val = 0;
	if (timer_pending(&sig->real_timer)) {
		val = sig->real_timer.expires - jiffies;

		/* look out for negative/zero itimer.. */
		if ((long) val <= 0)
			val = 1;
	}
	return val;
}

and 

static inline int timer_pending(const struct timer_list * timer)
{
	return timer->base != NULL;
}

and

static inline void __run_timers(tvec_base_t *base)
{
  ...
			timer = list_entry(head->next,struct timer_list,entry);
 			fn = timer->function;
 			data = timer->data;

			list_del(&timer->entry);
			set_running_timer(base, timer);
			smp_wmb();
			timer->base = NULL;
			spin_unlock_irq(&base->lock);
			{
				u32 preempt_count = preempt_count();
				fn(data);
...
}


So, timer_pending tests if timer->base is NULL, but here we see that
timer->base IS NULL before the function is called, and as I have said
earlier, the it_real_arm can be called on two CPUS simultaneously. So
here's another patch that should fix this race condition too.


--- linux-2.6.12-rc6/kernel/itimer.c.orig	2005-06-15 12:14:13.000000000 -0400
+++ linux-2.6.12-rc6/kernel/itimer.c	2005-06-15 15:31:12.000000000 -0400
@@ -156,8 +156,15 @@
 		spin_lock_irq(&tsk->sighand->siglock);
 		interval = tsk->signal->it_real_incr;
 		val = it_real_value(tsk->signal);
-		if (val)
-			del_timer_sync(&tsk->signal->real_timer);
+		/*
+		 * Call del_timer_sync unconditionally, since we don't
+		 * know if it is running or not. We also need to unlock
+		 * the siglock so that the it_real_fn called by ksoftirqd
+		 * doesn't wait for us.
+		 */
+		spin_unlock(&tsk->sighand->siglock);
+		del_timer_sync(&tsk->signal->real_timer);
+		spin_lock(&tsk->sighand->siglock);
 		tsk->signal->it_real_incr =
 			timeval_to_jiffies(&value->it_interval);
 		it_real_arm(tsk, timeval_to_jiffies(&value->it_value));


-- Steve



