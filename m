Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbWALBSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbWALBSU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 20:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbWALBSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 20:18:20 -0500
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:35989 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S964938AbWALBST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 20:18:19 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: -mm seems significanty slower than mainline on kernbench
Date: Thu, 12 Jan 2006 12:18:47 +1100
User-Agent: KMail/1.8.3
Cc: "Martin J. Bligh" <mbligh@google.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
References: <43C45BDC.1050402@google.com> <43C58117.9080706@bigpond.net.au> <43C5A8C6.1040305@bigpond.net.au>
In-Reply-To: <43C5A8C6.1040305@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601121218.47744.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2006 11:54 am, Peter Williams wrote:
> Peter Williams wrote:
> > Con Kolivas wrote:
> >> On Wednesday 11 January 2006 23:24, Peter Williams wrote:
> >>> Martin J. Bligh wrote:
> >>>> That seems broken to me ?
> >>>
> >>> But, yes, given that the problem goes away when the patch is removed
> >>> (which we're still waiting to see) it's broken.  I think the problem is
> >>> probably due to the changed metric (i.e. biased load instead of simple
> >>> load) causing idle_balance() to fail more often (i.e. it decides to not
> >>> bother moving any tasks more often than it otherwise would) which would
> >>> explain the increased idle time being seen.  This means that the fix
> >>> would be to review the criteria for deciding whether to move tasks in
> >>> idle_balance().
> >>
> >> Look back on my implementation. The problem as I saw it was that one
> >> task alone with a biased load would suddenly make a runqueue look much
> >> busier than it was supposed to so I special cased the runqueue that
> >> had precisely one task.
> >
> > OK.  I'll look at that.
>
> Addressed in a separate e-mail.
>
> > But I was thinking more about the code that (in the original) handled
> > the case where the number of tasks to be moved was less than 1 but more
> > than 0 (i.e. the cases where "imbalance" would have been reduced to zero
> > when divided by SCHED_LOAD_SCALE).  I think that I got that part wrong
> > and you can end up with a bias load to be moved which is less than any
> > of the bias_prio values for any queued tasks (in circumstances where the
> > original code would have rounded up to 1 and caused a move).  I think
> > that the way to handle this problem is to replace 1 with "average bias
> > prio" within that logic.  This would guarantee at least one task with a
> > bias_prio small enough to be moved.
> >
> > I think that this analysis is a strong argument for my original patch
> > being the cause of the problem so I'll go ahead and generate a fix. I'll
> > try to have a patch available later this morning.
>
> Attached is a patch that addresses this problem.  Unlike the description
> above it does not use "average bias prio" as that solution would be very
> complicated.  Instead it makes the assumption that NICE_TO_BIAS_PRIO(0)
> is a "good enough" for this purpose as this is highly likely to be the
> median bias prio and the median is probably better for this purpose than
> the average.

This is a shot in the dark. We haven't confirmed 1. there is a problem 2. that 
this is the problem nor 3. that this patch will fix the problem. I say we 
wait for the results of 1. If the improved smp nice handling patch ends up 
being responsible then it should not be merged upstream, and then this patch 
can be tested on top.

Martin I know your work move has made it not your responsibility to test 
backing out this change, but are you aware of anything being done to test 
this hypothesis?

Con
