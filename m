Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751796AbWFVOX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbWFVOX0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 10:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbWFVOX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 10:23:26 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:56969 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751796AbWFVOXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 10:23:25 -0400
Date: Thu, 22 Jun 2006 10:23:08 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Thomas Gleixner <tglx@linutronix.de>
cc: Esben Nielsen <nielsen.esben@googlemail.com>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Why can't I set the priority of softirq-hrt? (Re: 2.6.17-rt1)
In-Reply-To: <1150986041.25491.53.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0606221021410.15236@gandalf.stny.rr.com>
References: <20060618070641.GA6759@elte.hu>  <Pine.LNX.4.64.0606201656230.11643@localhost.localdomain>
  <1150816429.6780.222.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0606201725550.11643@localhost.localdomain> 
 <Pine.LNX.4.58.0606201229310.729@gandalf.stny.rr.com> 
 <Pine.LNX.4.64.0606201903030.11643@localhost.localdomain> 
 <1150824092.6780.255.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0606202217160.11643@localhost.localdomain> 
 <Pine.LNX.4.58.0606210418160.29673@gandalf.stny.rr.com> 
 <Pine.LNX.4.64.0606211204220.10723@localhost.localdomain> 
 <Pine.LNX.4.64.0606211638560.6572@localhost.localdomain> 
 <1150907165.25491.4.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0606220936290.15236@gandalf.stny.rr.com>
 <1150986041.25491.53.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Jun 2006, Thomas Gleixner wrote:

> On Thu, 2006-06-22 at 09:45 -0400, Steven Rostedt wrote:
> > > + * Recheck the pi chain, in case we got a priority setting
> > > + *
> > > + * Called from sched_setscheduler
> > > + */
> > > +void rt_mutex_adjust_pi(struct task_struct *task)
> > > +{
> > > +	struct rt_mutex_waiter *waiter = task->pi_blocked_on;
> > > +	unsigned long flags;
> >
> > Hmm, what if the process wakes up here and unblocks?  Since waiter is
> > on the stack, you could have a nasty race here.
>
> Thats fixed already. Moved into te pi_lock section

Yeah I saw that.

>
> > > +
> > > +	spin_lock_irqsave(&task->pi_lock, flags);
> > > +
> > > +	if (!waiter || waiter->list_entry.prio == task->prio) {
> > > +		spin_unlock_irqrestore(&task->pi_lock, flags);
> > > +		return;
> > > +	}
> > > +
> > > +	get_task_struct(task);
> > > +	spin_unlock_irqrestore(&task->pi_lock, flags);
> > > +
> > > +	rt_mutex_adjust_prio_chain(task, 0, NULL, NULL, task);
> >
> > Nasty nasty nasty!
>
> What's nasty ?
>

The fact that sched_setscheduler can never be called by interrupt context.
So I don't know how you're going to handle the high_res dynamic priority
now.

-- Steve

