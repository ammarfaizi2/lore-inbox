Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUHJId6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUHJId6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 04:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUHJId6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 04:33:58 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:2438 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262085AbUHJIdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 04:33:43 -0400
Message-Id: <200408100834.i7A8Y7e06476@owlet.beaverton.ibm.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, mjbligh@us.ibm.com
Subject: Re: 2.6.8-rc3-mm2 
In-reply-to: Your message of "Sun, 08 Aug 2004 15:29:36 PDT."
             <20040808152936.1ce2eab8.akpm@osdl.org> 
Date: Tue, 10 Aug 2004 01:34:06 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    - Added a little patch to the CPU scheduler which disables its array
      switching.
    
      This is purely experimental and will cause high-priority tasks
      to starve lower-priority tasks indefinitely.  It is here to
      determine whether it is this aspect of the scheduler which caused
      the staircase scheduler to exhibit improved throughput in some
      tests on NUMAq.

Here's the results of tests with sdet.  The summary is that yes, we
did reach the peak we saw with the staircase scheduler (2.6.8-rc2-mm2).
Dropping the expired array does make a difference.  But it looks like
that wasn't all of it, though, because we see it fails to reach the same
scores in all *but* the peak run.

Schedstats helps show a couple of interesting things but no
smoking gun. rc3-mm2 both tried to move around more tasks (calls
to load_balance()), and succeeded in finding some to move (calls to
pull_task()).  But not a LOT more, in either case. And rc3-mm2 took 15%
longer to run, even if it did as well in the end. Graphs are at

    http://eaglet.rain.com/rick/linux/staircase/scase-vs-noscase-vs-1q.html

Overall, I'd say I still like the staircase patch as a whole.  Not only
did it increase the benchmark numbers, but I like the simplicity it
(re)introduces for interactive bonus calculations.

Rick

DISCLAIMER: SPEC(tm) and the benchmark name SDET(tm) are registered
trademarks of the Standard Performance Evaluation Corporation. This 
benchmarking was performed for research purposes only, and the run results
are non-compliant and not-comparable with any published results.

Sdet
Scripts                      1       4      16      64
        2.6.8-rc2-mm2     32.46%  58.58% 100.00%  74.20%
2.6.8-rc2-mm2-noscase     23.62%  43.95%  90.92%  74.16%
        2.6.8-rc3-mm2     16.44%  43.26% 102.95%  71.26%
