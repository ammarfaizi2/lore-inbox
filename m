Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263618AbUACR4a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 12:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbUACR4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 12:56:30 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:37267
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S263618AbUACR41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 12:56:27 -0500
Message-ID: <3FF70241.1030307@tmr.com>
Date: Sat, 03 Jan 2004 12:56:17 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Nick Piggin <piggin@cyberone.com.au>, Ingo Molnar <mingo@elte.hu>
Subject: Re: HT schedulers' performance on single HT processor
References: <200312130157.36843.kernel@kolivas.org>
In-Reply-To: <200312130157.36843.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> I set out to find how the hyper-thread schedulers would affect the all 
> important kernel compile benchmark on machines that most of us are likely to 
> encounter soon. The single processor HT machine.
> 
> Usual benchmark precautions taken; best of five runs (curiously the fastest 
> was almost always the second run). Although for confirmation I really did 
> this twice.
> 
> Tested a kernel compile with make vmlinux, make -j2 and make -j8. 
> 
> make vmlinux - tests to ensure the sequential single threaded make doesn't 
> suffer as a result of these tweaks
> 
> make -j2 vmlinux - tests to see how well wasted idle time is avoided
> 
> make -j8 vmlinux - maximum throughput test (4x nr_cpus seems to be ceiling for 
> this).
> 
> Hardware: P4 HT 3.066
> 
> Legend:
> UP - Uniprocessor 2.6.0-test11 kernel
> SMP - SMP kernel
> C1 - With Ingo's C1 hyperthread patch
> w26 - With Nick's w26 sched-rollup (hyperthread included)
> 
> make vmlinux
> kernel	time
> UP	65.96
> SMP	65.80
> C1	66.54
> w26	66.25
> 
> I was concerned this might happen and indeed the sequential single threaded 
> compile is slightly worse on both HT schedulers. (1)
> 
> make -j2 vmlinux
> kernel	time
> UP	65.17
> SMP	57.77
> C1	66.01
> w26	57.94
> 
> Shows the smp kernel nicely utilises HT whereas the UP kernel doesn't. The C1 
> result was very repeatable and I was unable to get it lower than this.(2)
> 
> make -j8 vmlinux
> kernel	time
> UP	65.00
> SMP	57.85
> C1	58.25
> w26	57.94

If you could make one more test, do the compile with -pipe set in the 
top level Makefile. I don't have play access to a HT uni, the only 
machines available to me at the moment are SMP and production at that.

I did try it just for grins on a non-HT uni and saw this:

opt		real	user	sys	idle
-j1		406.2	308.1	19.0	79.1
-j1 -pipe	398.6	308.2	19.0	71.4
-j3		391.6	308.3	19.0	64.3
-j3 -pipe	388.7	308.4	19.0	61.3

P4-2.4MHz, 256MB, compiling 2.5.47-ac6 with just "make." Using -pipe 
*may* allow both siblings to cooperate better.

I assume that CPU affinity should apply to all siblings in a package?

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
