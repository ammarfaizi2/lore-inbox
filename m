Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263063AbTI3ApV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 20:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263064AbTI3ApV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 20:45:21 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:11693 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263063AbTI3ApP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 20:45:15 -0400
Message-Id: <200309300045.h8U0j6206171@owlet.beaverton.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Scheduling latency summary
Date: Mon, 29 Sep 2003 17:45:06 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I applied the schedstats patch to some recent releases and, with the help
of Steve Pratt, ran some benchmarks.  There's a lot of focus lately on
improving interactivity, and to me that seems directly related to how fast
a process can move from the run queue to the processor.  For this summary,
I'll call a "run slice" the period of time a task gets to run before it
voluntarily OR involuntarily leaves the processor.  "Latency" will be
the time between entering a runqueue and actually landing on a processor.

Using the schedstats patch, I took comparative measurements on -test5,
-test5-mm3, -test6, and -test6-mm1.  It's not only interesting to note
whether the benchmark improved, but how the scheduler behavior changed
(and differs between the different benchmarks).

High latency would usually indicate congested runqueues. High runslices
generally indicates workloads that were cpu-bound.  Different benchmarks
have different "normal" behavior, however.  Although results were
gathered, most benchmarks were run in an abbreviated manner to see trends
and characteristics rather than run full out, fully tuned, to get valid
test results.

Graphs can be viewed at http://eaglet.rain.com/rick/linux/schedstats/graphs/

Volanomark:
    test6-mm1 has, in general, about 15% higher latencies and about
    25% higher runslices than in test5.  Volanomark is known to
    be pathological with regards to repeatedly and quickly calling
    sched_yield at times with some implementations of Java.  The version
    I tested exhibits this spectacularly.  What's interesting to note is
    that it appears we're both waiting a bit longer to do the spinning
    as well as taking a bit longer to do it in test6-mm1.  Unlike most
    benchmarks, both run slices and latencies tend to live in the ns
    range, probably due to the rapid spinning.  These test results
    declined in test6 by over 5%.

SPECjbb
    As we move from small warehouses to larger warehouse
    runs we see us moving from low-latency/high-runslices to
    high-latency/low-runslices. Both test6 and test6-mm1 are showing
    about a 40% reduction in latency over test5, with only a slight
    reduction in runslice times (generally less than 5%).  Not surprisingly,
    test6 showed slightly better results when under heavier load.

SPECdets
    it's hard to see a pattern because the run utilized is generally short
    (under 5 minutes).  More frequent samples of the scheduler statistics
    might help.  In general, both test6 and test6-mm1 are comparable to
    test5 in terms of runslices and latencies.  Runslices are very small,
    generally less than 3ms, indicating these tasks do not run very long
    before leaving the processor. Test results showed slight degradation
    at the low end but slight improvement at the high end.

Kernbench
    We're all over the board, but basically no change. Both latencies and
    run slices tend to hover between 10 and 20 ms, suggesting moderate
    congestion but not major.  This can change depending on what -j you
    run make at.

Conclusion: test6 is generally as good as test5 unless you're running
Volanomark -- then it's definitely worse.

Rick
