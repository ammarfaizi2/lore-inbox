Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUHJHl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUHJHl0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 03:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbUHJHlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 03:41:25 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:27581 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261451AbUHJHkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 03:40:55 -0400
Message-Id: <200408100740.i7A7e0N05113@owlet.beaverton.ibm.com>
To: Andrew Theurer <habanero@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com, mingo@elte.hu,
       akpm@osdl.org
Subject: Re: 2.6.8-rc2-mm2 performance improvements (scheduler?)
In-reply-to: Your message of "Mon, 09 Aug 2004 23:10:01 CDT."
	     <200408092308.56160.habanero@us.ibm.com>
Date: Tue, 10 Aug 2004 00:40:00 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    What's quite interesting is that there is a very noticeable surge in
    load_balance with staircase in the early stage of the test, but there
    appears to be -no- direct policy changes to load-balance at all in
    Con's patch (or at least I didn't notice it -please tell me if you
    did!).  You can see it in busy load_balance, sched_balance_exec, and
    pull_task.  The runslice and latency stats confirm this -no-staircase
    does not balance early on, and the tasks suffer, waiting on a cpu
    already loaded up.  I do not have an explanation for this; perhaps
    it has something to do with eliminating expired queue.

Possibly.  The other factor thrown in here is that this was on an SMT
machine, so it's possible that the balancing is no different but we are
seeing tasks initially assigned more poorly.  Or, perhaps we're drawing
too much from one data point.

    It would be nice to have per cpu runqueue lengths logged to see how
    this plays out -do the cpus on staircase obtain a runqueue length
    close to nr_running()/nr_online_cpus sooner than no-staircase?

The only difficulty there is do we know how long it normally takes for
this to balance out?  We're taking samples every five seconds; might this
not work itself out between one snapshot and the next?  Shrug.  It would
be easy enough to add another field to report nr_running at the moment
the statistics snapshot was taken, but on anything but compute-intensive
benchmarks I'm afraid we might miss all the interesting data.

    Also, one big change apparent to me, the elimination of
    TIMESLICE_GRANULARITY.  Do you have cswitch data?  I would not
    be surprised if it's a lot higher on -no-staircase, and cache is
    thrashed a lot more.  This may be something you can pull out of the
    -no-staircase kernel quite easily.

Yes, sar data was collected every five seconds so I do have context switch
data.  The bad news is that it was collected for each of 10 runs times
four different loads, and I don't have any handy dandy scripts to pretty
it up :)  (Pause.) A quick exercise with a calculator, though, suggests
you are right. cswitches were 10%-20% higher on the no staircase runs.

Rick
