Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030298AbWGaUrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbWGaUrx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 16:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbWGaUrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 16:47:52 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:35260 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030298AbWGaUrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 16:47:52 -0400
Subject: Re: rt_mutex_timed_lock() vs hrtimer_wakeup() race ?
From: Steven Rostedt <rostedt@goodmis.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Esben Nielsen <nielsen.esben@googlemail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060801001258.GA130@oleg>
References: <20060730043605.GA2894@oleg>
	 <1154298218.10074.33.camel@localhost.localdomain>
	 <20060801001258.GA130@oleg>
Content-Type: text/plain
Date: Mon, 31 Jul 2006 16:47:36 -0400
Message-Id: <1154378856.6897.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-01 at 04:12 +0400, Oleg Nesterov wrote:
> On 07/30, Steven Rostedt wrote:
> >
> > On Sun, 2006-07-30 at 08:36 +0400, Oleg Nesterov wrote:
> > > 
> > > Another question, task_blocks_on_rt_mutex() does get_task_struct() and checks
> > > owner->pi_blocked_on != NULL under owner->pi_lock. Why ? RT_MUTEX_HAS_WAITERS
> > > bit is set, we are holding ->wait_lock, so the 'owner' can't go away until
> > > we drop ->wait_lock.
> > 
> > That's probably true that the owner can't disappear before we let go of
> > the wait_lock, since the owner should not be disappearing while holding
> > locks.  But you are missing the point to why we are grabbing the
> > pi_lock.  We are preventing a race that can have us do unneeded work
> > (see below).
> 
> Yes, I see. But ...
> 
> > ===================================================================
> > --- linux-2.6.18-rc2.orig/kernel/rtmutex.c	2006-07-30 18:04:12.000000000 -0400
> > +++ linux-2.6.18-rc2/kernel/rtmutex.c	2006-07-30 18:07:08.000000000 -0400
> > @@ -433,25 +433,26 @@ static int task_blocks_on_rt_mutex(struc
> >	...
> >  	else if (debug_rt_mutex_detect_deadlock(waiter, detect_deadlock)) {
> >  		spin_lock_irqsave(&owner->pi_lock, flags);
> > -		if (owner->pi_blocked_on) {
> > +		if (owner->pi_blocked_on)
> >  			boost = 1;
> > -			/* gets dropped in rt_mutex_adjust_prio_chain()! */
> > -			get_task_struct(owner);
> > -		}
> >  		spin_unlock_irqrestore(&owner->pi_lock, flags);
> 
> In that case ->pi_lock can't buy anything. With or without ->pi_lock this
> check is equally racy, so spin_lock() only adds unneeded work?

crap! I just did a blind change there.  The first one does matter, but
this is for debugging.  Hmm actually I would just remove the owner
blocked check all together and do the boost = 1 to force the chain walk.
It's for debugging anyway.

So that probably could just look something like this:

	else if (debug_rt_mutex_detect_deadlock(waiter, detect_deadlock))
		boost = 1;

the "boost" here is a misnomer.  It probably would be better to call it
"walk" or "chain_walk".

-- Steve


