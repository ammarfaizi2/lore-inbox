Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270756AbTGUXgQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 19:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270758AbTGUXgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 19:36:16 -0400
Received: from maild.telia.com ([194.22.190.101]:25054 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id S270756AbTGUXgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 19:36:15 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Software suspend testing in 2.6.0-test1
References: <m2wueh2axz.fsf@telia.com> <20030717200039.GA227@elf.ucw.cz>
	<m2u19g9p2c.fsf@telia.com> <20030721125813.GA4775@zaurus.ucw.cz>
	<m21xwkvte8.fsf@telia.com> <20030721212828.GE436@elf.ucw.cz>
From: Peter Osterlund <petero2@telia.com>
Date: 22 Jul 2003 01:46:01 +0200
In-Reply-To: <20030721212828.GE436@elf.ucw.cz>
Message-ID: <m2vftv4f5y.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Pavel Machek <pavel@ucw.cz> writes:

> > > But why do you touch PF_FROZEN here? Refrigerator should do that.
> > > And wake_up_process should not be needed...
> > > If it is in refrigerator, it polls PF_FREEZE...
> > 
> > Note that the old code always called wake_up_process(), which is
> > necessary to make the process run one more iteration in refrigerator()
> > and relize that it is time to unfreeze.
> > 
> > The patch changes things so that wake_up_process() is NOT called if
> > the process is stopped at some other place than in refrigerator().
> > This ensures that processes that were stopped before we invoked swsusp
> > are still stopped after resume.
> 
> Yes, but you still print warning for them. I hopefully killed that.
...
> +static inline int interesting_process(struct task_struct *p)
> +{
> +	if (p->flags & PF_IOTHREAD)
> +		return 0;
> +	if (p == current)
> +		return 0;
> +	if ((p->state == TASK_ZOMBIE) || (p->state == TASK_DEAD))
> +		return 0;
> +	if (p->state == TASK_STOPPED)
> +		return 0;
> +
> +
> +	return 1;
> +}

But this doesn't work. We can't skip stopped tasks in the
thaw_processes() function, because frozen tasks are also stopped
tasks. Therefore nothing will be woken up during resume.

It's probably best to just delete the printk("strange,...") line.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
