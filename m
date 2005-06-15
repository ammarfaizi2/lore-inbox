Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVFOShq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVFOShq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 14:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVFOShq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 14:37:46 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:43239 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261268AbVFOSh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 14:37:29 -0400
Subject: Re: [BUG] Race condition with it_real_fn in kernel/itimer.c
From: Steven Rostedt <rostedt@goodmis.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <42B067BD.F4526CD@tv-sign.ru>
References: <42B067BD.F4526CD@tv-sign.ru>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 15 Jun 2005 14:37:03 -0400
Message-Id: <1118860623.4508.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-15 at 21:39 +0400, Oleg Nesterov wrote:
> Steven Rostedt wrote:
> >
> > +	try_again:
> >  		spin_lock_irq(&tsk->sighand->siglock);
> >  		interval = tsk->signal->it_real_incr;
> >  		val = it_real_value(tsk->signal);
> > -		if (val)
> > +		if (val) {
> > +			spin_unlock_irq(&tsk->sighand->siglock);
> >  			del_timer_sync(&tsk->signal->real_timer);
> > +			goto try_again;
> 
> I think we don't need del_timer_sync() at all, just del_timer().
> 
> Because it_real_value() returns 0 when timer is not pending. And
> in this case the timer may still be running, but do_setitimer()
> doesn't call del_timer_sync().

OK, so is this the better patch?

[Andrew, do NOT use the following]

--- linux-2.6.12-rc6/kernel/itimer.c.orig	2005-06-15 12:14:13.000000000 -0400
+++ linux-2.6.12-rc6/kernel/itimer.c	2005-06-15 14:06:23.000000000 -0400
@@ -157,7 +157,7 @@
 		interval = tsk->signal->it_real_incr;
 		val = it_real_value(tsk->signal);
 		if (val)
-			del_timer_sync(&tsk->signal->real_timer);
+			del_timer(&tsk->signal->real_timer);
 		tsk->signal->it_real_incr =
 			timeval_to_jiffies(&value->it_interval);
 		it_real_arm(tsk, timeval_to_jiffies(&value->it_value));


I haven't played too much with the itimer, what harm can happen if the
timer is running while this is deleted?  [examines code here] This also
looks bad. Since the softirq function can be running and then call
it_real_arm unprotected! And you can see here that it_real_arm is also
called and they both call add_timer! This would not work, so far the
first patch seems to handle this. 


-- Steve

PS. Don't strip the CC list.

