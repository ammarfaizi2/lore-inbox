Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030463AbWAGF1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030463AbWAGF1X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 00:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030466AbWAGF1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 00:27:23 -0500
Received: from mail.gmx.de ([213.165.64.21]:31445 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030463AbWAGF1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 00:27:22 -0500
X-Authenticated: #14349625
Message-Id: <5.2.1.1.2.20060107051229.00c42230@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Sat, 07 Jan 2006 06:27:04 +0100
To: Peter Williams <pwil3058@bigpond.net.au>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] sched: Fix adverse effects of NFS client   
  on	interactive response
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ingo Molnar <mingo@elte.hu>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <43BF152A.80509@bigpond.net.au>
References: <5.2.1.1.2.20060106074738.00bbaeb8@pop.gmx.net>
 <5.2.1.1.2.20060105143705.00be85c8@pop.gmx.net>
 <5.2.1.1.2.20060105070601.026b21f0@pop.gmx.net>
 <43BB2414.6060400@bigpond.net.au>
 <43A8EF87.1080108@bigpond.net.au>
 <1135145341.7910.17.camel@lade.trondhjem.org>
 <43A8F714.4020406@bigpond.net.au>
 <20060102110145.GA25624@aitel.hist.no>
 <43B9BD19.5050408@bigpond.net.au>
 <43BB2414.6060400@bigpond.net.au>
 <5.2.1.1.2.20060105070601.026b21f0@pop.gmx.net>
 <5.2.1.1.2.20060105143705.00be85c8@pop.gmx.net>
 <5.2.1.1.2.20060106074738.00bbaeb8@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Antivirus: avast! (VPS 0601-0, 01/02/2006), Outbound message
X-Antivirus-Status: Clean
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:11 PM 1/7/2006 +1100, Peter Williams wrote:

>Is that patch complete?  (This is all I got.)

Yes.

>--- linux-2.6.15/kernel/sched.c.org     Fri Jan  6 08:44:09 2006
>+++ linux-2.6.15/kernel/sched.c Fri Jan  6 08:51:03 2006
>@@ -1353,7 +1353,7 @@
>
>  out_activate:
>  #endif /* CONFIG_SMP */
>-       if (old_state == TASK_UNINTERRUPTIBLE) {
>+       if (old_state & TASK_UNINTERRUPTIBLE) {
>                 rq->nr_uninterruptible--;
>                 /*
>                 * Tasks on involuntary sleep don't earn
>@@ -3010,7 +3010,7 @@
>                                 unlikely(signal_pending(prev))))
>                         prev->state = TASK_RUNNING;
>                 else {
>-                       if (prev->state == TASK_UNINTERRUPTIBLE)
>+                       if (prev->state & TASK_UNINTERRUPTIBLE)
>                                 rq->nr_uninterruptible++;
>                         deactivate_task(prev, rq);
>                 }
>
>In the absence of any use of TASK_NONINTERACTIVE in conjunction with 
>TASK_UNINTERRUPTIBLE it will have no effect.

Exactly.  It's only life insurance.

>   Personally, I think that all TASK_UNINTERRUPTIBLE sleeps should be 
> treated as non interactive rather than just be heavily discounted (and 
> that TASK_NONINTERACTIVE shouldn't be needed in conjunction with it) BUT 
> I may be wrong especially w.r.t. media streamers such as audio and video 
> players and the mechanisms they use to do sleeps between cpu bursts.

Try it, you won't like it.  When I first examined sleep_avg woes, my 
reaction was to nuke uninterruptible sleep too... boy did that ever _suck_ :)

I'm trying to think of ways to quell the nasty side of sleep_avg without 
destroying the good.  One method I've tinkered with in the past with 
encouraging results is to compute a weighted slice_avg, which is a measure 
of how long it takes you to use your slice, and scale it to match 
MAX_SLEEPAVG for easy comparison.  A possible use thereof:  In order to be 
classified interactive, you need the sleep_avg, but that's not enough... 
you also have to have a record of sharing the cpu. When your slice_avg 
degrades enough as you burn cpu, you no longer get to loop in the active 
queue.  Being relegated to the expired array though will improve your 
slice_avg and let you regain your status.  Your priority remains, so you 
can still preempt, but you become mortal and have to share.  When there is 
a large disparity between sleep_avg and slice_avg, it can be used as a 
general purpose throttle to trigger TASK_NONINTERACTIVE flagging in 
schedule() as negative feedback for the ill behaved.  Thoughts?

         -Mike 

