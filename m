Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270637AbTGVKts (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 06:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270752AbTGVKts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 06:49:48 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:6834 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S270637AbTGVKtp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 06:49:45 -0400
Date: Tue, 22 Jul 2003 13:04:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Peter Osterlund <petero2@telia.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Software suspend testing in 2.6.0-test1
Message-ID: <20030722110428.GA170@elf.ucw.cz>
References: <m2wueh2axz.fsf@telia.com> <20030717200039.GA227@elf.ucw.cz> <m2u19g9p2c.fsf@telia.com> <20030721125813.GA4775@zaurus.ucw.cz> <m21xwkvte8.fsf@telia.com> <20030721212828.GE436@elf.ucw.cz> <m2vftv4f5y.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2vftv4f5y.fsf@telia.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > But why do you touch PF_FROZEN here? Refrigerator should do that.
> > > > And wake_up_process should not be needed...
> > > > If it is in refrigerator, it polls PF_FREEZE...
> > > 
> > > Note that the old code always called wake_up_process(), which is
> > > necessary to make the process run one more iteration in refrigerator()
> > > and relize that it is time to unfreeze.
> > > 
> > > The patch changes things so that wake_up_process() is NOT called if
> > > the process is stopped at some other place than in refrigerator().
> > > This ensures that processes that were stopped before we invoked swsusp
> > > are still stopped after resume.
> > 
> > Yes, but you still print warning for them. I hopefully killed that.
> ...
> > +static inline int interesting_process(struct task_struct *p)
> > +{
> > +	if (p->flags & PF_IOTHREAD)
> > +		return 0;
> > +	if (p == current)
> > +		return 0;
> > +	if ((p->state == TASK_ZOMBIE) || (p->state == TASK_DEAD))
> > +		return 0;
> > +	if (p->state == TASK_STOPPED)
> > +		return 0;
> > +
> > +
> > +	return 1;
> > +}
> 
> But this doesn't work. We can't skip stopped tasks in the
> thaw_processes() function, because frozen tasks are also stopped
> tasks. Therefore nothing will be woken up during resume.
> 
> It's probably best to just delete the printk("strange,...") line.

Okay, you are right, I'll stick with your solution for now.

I'd prefer to keep that "strange" line, so that we know if they are
some problems.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
