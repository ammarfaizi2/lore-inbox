Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269961AbTGUMrM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 08:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269987AbTGUMrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 08:47:11 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:5392 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S269961AbTGUMrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 08:47:07 -0400
Date: Mon, 21 Jul 2003 14:58:13 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Peter Osterlund <petero2@telia.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Software suspend testing in 2.6.0-test1
Message-ID: <20030721125813.GA4775@zaurus.ucw.cz>
References: <m2wueh2axz.fsf@telia.com> <20030717200039.GA227@elf.ucw.cz> <m2u19g9p2c.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2u19g9p2c.fsf@telia.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Thanks for a report. If it came with a patch it would be better
> > ;-). I'll take a look.
> 
> Here is a patch to make software suspend correctly handle stopped
> processes. It should apply cleanly on top of the patch you sent to
> Linus to decouple SOFTWARE_SUSPEND and ACPI_SLEEP.
> 
> @@ -164,14 +164,18 @@
>   * Refrigerator and related stuff
>   */
>  
> -#define INTERESTING(p) > -			/* We don't want to touch kernel_threads..*/ > -			if (p->flags & PF_IOTHREAD) > -				continue; > -			if (p == current) > -				continue; > -			if (p->state == TASK_ZOMBIE) > -				continue;
> +/* 0 = Ignore this process when freezing/thawing, 1 = freeze/thaw this process */
> +static inline int interesting_process(struct task_struct *p)
> +{
> +	if (p->flags & PF_IOTHREAD)
> +		return 0;
> +	if (p == current)
> +		return 0;
> +	if ((p->state == TASK_ZOMBIE) || (p->state == TASK_DEAD))
> +		return 0;
> +
> +	return 1;
> +}
>  

Simple cleanup, okay.

> @@ -214,9 +218,12 @@
>  		read_lock(&tasklist_lock);
>  		do_each_thread(g, p) {
>  			unsigned long flags;
> -			INTERESTING(p);
> +			if (!interesting_process(p))
> +				continue;
>  			if (p->flags & PF_FROZEN)
>  				continue;
> +			if (p->state == TASK_STOPPED)
> +				continue;
>  
>  			/* FIXME: smp problem here: we may not access other process' flags
>  			   without locking */

No need to handle TASK_STOPPED tasks, as they are "frozen" already. Ok.

>  	read_lock(&tasklist_lock);
>  	do_each_thread(g, p) {
> -		INTERESTING(p);
> -		
> -		if (p->flags & PF_FROZEN) p->flags &= ~PF_FROZEN;
> -		else
> -			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
> -		wake_up_process(p);
> +		if (!interesting_process(p))
> +			continue;
> +
> +		p->flags &= ~PF_FREEZE;
> +		if (p->flags & PF_FROZEN) {
> +			p->flags &= ~PF_FROZEN;
> +			wake_up_process(p);
> +		} else
> +			
But why do you touch PF_FROZEN here? Refrigerator should do that.
And wake_up_process should not be needed...
If it is in refrigerator, it polls PF_FREEZE...

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

