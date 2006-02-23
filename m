Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751785AbWBWWHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbWBWWHw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 17:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbWBWWHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 17:07:52 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:15235 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1751785AbWBWWHv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 17:07:51 -0500
Date: Thu, 23 Feb 2006 23:07:37 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, Gautam H Thaker <gthaker@atl.lmco.com>,
       linux-kernel@vger.kernel.org
Subject: Re: ~5x greater CPU load for a networked application when using
 2.6.15-rt15-smp vs. 2.6.12-1.1390_FC4
In-Reply-To: <29495f1d0602231314m6ea84f85wc2792c1b6b7c4715@mail.gmail.com>
Message-Id: <Pine.OSF.4.05.10602232238560.19969-100000@da410>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When PREEMPT_RT is settled down I propose that many of the irq-handlers
are moved back to "raw" irq context. I am sure many of them are so short
that it wont increase latency. It is always a balance between needed
latency and performance. Basicly, the rule is that all irq handlers
running for less that the lower required latency and rare enough not 
to take a significant part of the CPU load, should run in irq context. 

Now the kernel hacker doesn't know for how long various irq handlers run
on a specific piece of hardware and which latencies the application need.
Therefore it has to be a config option per driver. The driver locks
ofcourse also need to be change from rt_lock to raw_spin_lock depending on
that option. Thus a macro framework for making the right choices of lock
type fitting the choosen irq-handler context it, is needed.

For the issue here, I am pretty sure changing the ethernet driver from
running in task context to raw irq context will improve the performance.
What you need to meassure as well, is how it influences latencies. There
is a good change you will see you can't meassure any difference because so
little work is actually done in irq context, must of the work is done
by the DMA controller.

Esben

On Thu, 23 Feb 2006, Nish Aravamudan wrote:

> On 2/23/06, Ingo Molnar <mingo@elte.hu> wrote:
> >
> > * Nish Aravamudan <nish.aravamudan@gmail.com> wrote:
> >
> > > Would it make more sense to compare 2.6.15 and 2.6.15-rt17, as opposed
> > > to 2.6.12-1.1390_FC4 and 2.6.15-rt17? Seems like the closer the two
> > > kernels are, the easier it will be to isolate the differences.
> >
> > good point. I'd expect there to be similar 'top' output, but still worth
> > doing for comparable results.
> 
> I'd also expect little difference (hopefully) -- although there's
> always an off-chance something big changed somewhere and the problem
> was fixed in mainline. Just makes the comparison clearer.
> 
> Thanks,
> Nish
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

