Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270122AbTGUOXt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 10:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270109AbTGUOXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 10:23:49 -0400
Received: from mailg.telia.com ([194.22.194.26]:44761 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id S270136AbTGUOXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 10:23:39 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Software suspend testing in 2.6.0-test1
References: <m2wueh2axz.fsf@telia.com> <20030717200039.GA227@elf.ucw.cz>
	<m2u19g9p2c.fsf@telia.com> <20030721125813.GA4775@zaurus.ucw.cz>
From: Peter Osterlund <petero2@telia.com>
Date: 21 Jul 2003 16:36:31 +0200
In-Reply-To: <20030721125813.GA4775@zaurus.ucw.cz>
Message-ID: <m21xwkvte8.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> > @@ -214,9 +218,12 @@
> >  		read_lock(&tasklist_lock);
> >  		do_each_thread(g, p) {
> >  			unsigned long flags;
> > -			INTERESTING(p);
> > +			if (!interesting_process(p))
> > +				continue;
> >  			if (p->flags & PF_FROZEN)
> >  				continue;
> > +			if (p->state == TASK_STOPPED)
> > +				continue;
> >  
> >  			/* FIXME: smp problem here: we may not access other process' flags
> >  			   without locking */
> 
> No need to handle TASK_STOPPED tasks, as they are "frozen" already. Ok.

If the process was stopped before swsusp was invoked, the process will
never reach refrigerator() and therefore never set the PF_FROZEN
flag. Without the test for TASK_STOPPED, swsusp gives up and claims
that it can't stop all processes.

> >  	read_lock(&tasklist_lock);
> >  	do_each_thread(g, p) {
> > -		INTERESTING(p);
> > -		
> > -		if (p->flags & PF_FROZEN) p->flags &= ~PF_FROZEN;
> > -		else
> > -			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
> > -		wake_up_process(p);
> > +		if (!interesting_process(p))
> > +			continue;
> > +
> > +		p->flags &= ~PF_FREEZE;
> > +		if (p->flags & PF_FROZEN) {
> > +			p->flags &= ~PF_FROZEN;
> > +			wake_up_process(p);
> > +		} else
> > +			
> But why do you touch PF_FROZEN here? Refrigerator should do that.
> And wake_up_process should not be needed...
> If it is in refrigerator, it polls PF_FREEZE...

Note that the old code always called wake_up_process(), which is
necessary to make the process run one more iteration in refrigerator()
and relize that it is time to unfreeze.

The patch changes things so that wake_up_process() is NOT called if
the process is stopped at some other place than in refrigerator().
This ensures that processes that were stopped before we invoked swsusp
are still stopped after resume.

I manually clear PF_FREEZE here in an attempt to handle a race
condition, but I realize I need to understand more of the scheduler
and signal code before I know for sure if this is necessary and/or
sufficient.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
