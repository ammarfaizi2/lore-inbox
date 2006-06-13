Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWFMXIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWFMXIV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 19:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWFMXIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 19:08:21 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:47298 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751185AbWFMXIV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 19:08:21 -0400
Subject: Re: [RFC][PATCH] Avoid race w/ posix-cpu-timer and exiting tasks
From: john stultz <johnstul@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Roland McGrath <roland@redhat.com>
In-Reply-To: <20060614024909.GA563@oleg>
References: <20060614024909.GA563@oleg>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 16:05:45 -0700
Message-Id: <1150239945.5799.14.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-14 at 06:49 +0400, Oleg Nesterov wrote:
> john stultz wrote:
> >
> > Hey Ingo,
> > 	We've occasionally come across OOPSes in posix-cpu-timer thread (as
> > well as tripping over the BUG_ON(tsk->exit_state there) where it appears
> > the task we're processing exits out on us while we're using it. 
> >
> > Thus this fix tries to avoid running the posix-cpu-timers on a task that
> > is exiting.
> >
> > --- 2.6-rt/kernel/posix-cpu-timers.c	2006-06-11 15:38:58.000000000 -0500
> > +++ devrt/kernel/posix-cpu-timers.c	2006-06-12 10:52:20.000000000 -0500
> > @@ -1290,12 +1290,15 @@
> >
> >  #undef	UNEXPIRED
> >
> > -	BUG_ON(tsk->exit_state);
> > -
> >  	/*
> >  	 * Double-check with locks held.
> >  	 */
> >  	read_lock(&tasklist_lock);
> > +	/* Make sure the task doesn't exit under us. */
> > +	if(unlikely(tsk->exit_state)) {
> > +		read_unlock(&tasklist_lock);
> > +		return;
> > +	}
> >  	spin_lock(&tsk->sighand->siglock);
> 
> I strongly believe this BUG_ON() is indeed wrong, and I did a similar patch
> a long ago:
> 
> 	[PATCH] posix-timers: remove false BUG_ON() from run_posix_cpu_timers()
> 	Commit 3de463c7d9d58f8cf3395268230cb20a4c15bffa

Thanks for the pointer! Hmm.  That patch is very similar to what I'm
trying to avoid. 

Just to be clear for everyone else, that commit id is for Linus' git
tree. The patch I'm proposing is against the -rt tree, where the
run_posix_timers() function has been converted to a kthread instead of
being run from the timer interrupt context.

This allows the possibility of the the run_posix_timers_thread racing
against the task its running on behalf and the task exiting, and I hope
that is what my patch resolves (although I'm not confident its 100%).

The tsk->signal check from the patch above looks like it would avoid
this as well. Is there a specific benefit to checking that over
exit_state?

If anyone has further feedback or info about why the above was reverted
it would be appreciated.

thanks
-john






