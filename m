Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264915AbUHJPVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264915AbUHJPVx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 11:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264960AbUHJPVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 11:21:52 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:56800 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264915AbUHJPVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 11:21:46 -0400
From: Andrew Theurer <habanero@us.ibm.com>
To: Rick Lindsley <ricklind@us.ibm.com>
Subject: Re: 2.6.8-rc2-mm2 performance improvements (scheduler?)
Date: Tue, 10 Aug 2004 10:19:27 -0500
User-Agent: KMail/1.5
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       mbligh@aracnet.com, mingo@elte.hu, akpm@osdl.org
References: <200408100740.i7A7e0N05113@owlet.beaverton.ibm.com>
In-Reply-To: <200408100740.i7A7e0N05113@owlet.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408101019.27440.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 August 2004 02:40, Rick Lindsley wrote:
>     What's quite interesting is that there is a very noticeable surge in
>     load_balance with staircase in the early stage of the test, but there
>     appears to be -no- direct policy changes to load-balance at all in
>     Con's patch (or at least I didn't notice it -please tell me if you
>     did!).  You can see it in busy load_balance, sched_balance_exec, and
>     pull_task.  The runslice and latency stats confirm this -no-staircase
>     does not balance early on, and the tasks suffer, waiting on a cpu
>     already loaded up.  I do not have an explanation for this; perhaps
>     it has something to do with eliminating expired queue.
>
> Possibly.  The other factor thrown in here is that this was on an SMT
> machine, so it's possible that the balancing is no different but we are
> seeing tasks initially assigned more poorly.  Or, perhaps we're drawing
> too much from one data point.

Yes, my first guess was that sched_balance_exec was changed, and I guess it 
was, but earlier than Con's patch.  The first conditional we had used to 
have:

if (this_rq()->nr_running <= 2)
                goto out;

but the 2 is now a 1 for both -rc2 and -rc2-mm2, so we tend to find the best 
cpu in the system more often now.

>
>     It would be nice to have per cpu runqueue lengths logged to see how
>     this plays out -do the cpus on staircase obtain a runqueue length
>     close to nr_running()/nr_online_cpus sooner than no-staircase?
>
> The only difficulty there is do we know how long it normally takes for
> this to balance out?  We're taking samples every five seconds; might this
> not work itself out between one snapshot and the next?  Shrug.  It would
> be easy enough to add another field to report nr_running at the moment
> the statistics snapshot was taken, but on anything but compute-intensive
> benchmarks I'm afraid we might miss all the interesting data.

Actually if you have sar cpu util data, we might be able to extract this.  For 
example, if we have balance issues on 16 user sdet, we may see that very 
early on the staircase cpu util was near 100%, where the no-staircase may 
have been much lower for the first portion of the test (showing that some 
cpus were idle while others may have had more than one task).  If we can see 
this in sar, IMO that would confirm some sort of indirect load balance 
improvement in staircase.


>     Also, one big change apparent to me, the elimination of
>     TIMESLICE_GRANULARITY.  Do you have cswitch data?  I would not
>     be surprised if it's a lot higher on -no-staircase, and cache is
>     thrashed a lot more.  This may be something you can pull out of the
>     -no-staircase kernel quite easily.
>
> Yes, sar data was collected every five seconds so I do have context switch
> data.  The bad news is that it was collected for each of 10 runs times
> four different loads, and I don't have any handy dandy scripts to pretty
> it up :)  (Pause.) A quick exercise with a calculator, though, suggests
> you are right. cswitches were 10%-20% higher on the no staircase runs.

Interesting.  I wouldn't expect it to account for up to 20% performance, but 
maybe 1-2%.
>
> Rick

