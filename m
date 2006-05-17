Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWEQTeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWEQTeI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 15:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbWEQTeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 15:34:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:654 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750991AbWEQTeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 15:34:07 -0400
Message-Id: <4t16i2$13uiu1@orsmga001.jf.intel.com>
X-IronPort-AV: i="4.05,138,1146466800"; 
   d="scan'208"; a="37702593:sNHT2751033768"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Con Kolivas'" <kernel@kolivas.org>, <tim.c.chen@linux.intel.com>
Cc: <linux-kernel@vger.kernel.org>, <mingo@elte.hu>,
       "Andrew Morton" <akpm@osdl.org>, "Mike Galbraith" <efault@gmx.de>
Subject: RE: Regression seen for patch "sched:dont decrease idle sleep avg"
Date: Wed, 17 May 2006 12:33:34 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZ5izUXH+TOC/oMQ/icRq+53D7FwgAW0wcA
In-Reply-To: <200605171823.24476.kernel@kolivas.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote on Wednesday, May 17, 2006 1:23 AM
> On Wednesday 17 May 2006 09:32, Tim Chen wrote:
> > It seems like just one sleep longer than INTERACTIVE_SLEEP is needed
> > kick the priority of a process all the way to MAX_BONUS-1 and boost the
> > sleep_avg, regardless of what the prior sleep_avg was.
> >
> > So if there is a cpu hog that has long sleeps occasionally, once it woke
> > up, its priority will get boosted close to maximum, likely starving out
> > other processes for a while till its sleep_avg gets reduced.  This
> > behavior seems like something to avoid according to the original code
> > comment.  Are we boosting the priority too quickly?
> 
> Two things strike me here. I'll explain them in the patch below.
> 
> How's this look?
> ---
> The relationship between INTERACTIVE_SLEEP and the ceiling is not perfect
> and not explicit enough. The sleep boost is not supposed to be any larger
> than without this code and the comment is not clear enough about what exactly
> it does, just the reason it does it.
> 
> There is a ceiling to the priority beyond which tasks that only ever sleep
> for very long periods cannot surpass.


It looks bad.  I don't like it. The priority boost is even more peculiar
in this patch.


> --- linux-2.6.17-rc4-mm1.orig/kernel/sched.c	2006-05-17 15:57:49.000000000 +1000
> +++ linux-2.6.17-rc4-mm1/kernel/sched.c	2006-05-17 18:19:29.000000000 +1000
> @@ -904,20 +904,14 @@ static int recalc_task_prio(task_t *p, u
>  	}
>  
>  	if (likely(sleep_time > 0)) {
> -		/*
> -		 * User tasks that sleep a long time are categorised as
> -		 * idle. They will only have their sleep_avg increased to a
> -		 * level that makes them just interactive priority to stay
> -		 * active yet prevent them suddenly becoming cpu hogs and
> -		 * starving other processes.
> -		 */
> -		if (p->mm && sleep_time > INTERACTIVE_SLEEP(p)) {
> -				unsigned long ceiling;
> +		unsigned long ceiling = INTERACTIVE_SLEEP(p);
>  
> -				ceiling = JIFFIES_TO_NS(MAX_SLEEP_AVG -
> -					DEF_TIMESLICE);
> -				if (p->sleep_avg < ceiling)
> -					p->sleep_avg = ceiling;
> +		if (p->mm && sleep_time > ceiling && p->sleep_avg < ceiling) {
> +			/*
> +			 * Prevents user tasks from achieving best priority
> +			 * with one single large enough sleep.
> +			 */
> +			p->sleep_avg = ceiling;


The assignment of p->sleep_avg = ceiling doesn't make much logical sense.
Because INTERACTIVE_SLEEP is scaled proportionally with nice value, e.g.
the lower the nice value, the lower the interactive_sleep.  However, priority
calculation is inverse of p->sleep_avg, e.g. the smaller the sleep_avg, the
smaller the bonus, thus the higher dynamic priority.

Take one concrete example: for a prolonged sleep, say 1 second, nice(-10)
will have a priority boost of 4 while nice(0) will have a priority boost of
9. The ceiling algorithm looks like is reversed. I would think kernel should
at least enforce same ceiling value independent of nice value.

- Ken
