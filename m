Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbUCYAL2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 19:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbUCYAJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 19:09:11 -0500
Received: from bhhdoa.org.au ([216.17.101.199]:14344 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S262984AbUCYAHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 19:07:41 -0500
Message-ID: <1080174430.4062275e7273e@vds.kolivas.org>
Date: Thu, 25 Mar 2004 11:27:10 +1100
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Cc: zwane@linuxpower.ca, wli@holomorphy.com
Subject: [PATCH]Staircase scheduler - experimental
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a rewrite of the scheduler policy for 2.6, based on the current
O(1) scheduler.

Aims:

 - Making renicing processes actually matter for CPU distribution
   (nice 0 gets 20 times what nice +20 gets)
 - Interactive by design rather than have complicated interactivity algorithm
   bolted onto an existing design
 - Good scalability.
 - Simple predictable design.
 - Maintain appropriate cpu distribution and fairness.
 - Low scheduling latency for normal policy tasks.
 - Low overhead.

Summary of design:
 A descending multilevel single runqueue per cpu with deadline elevation of
 priorities.

Details:
 This patch takes advantage of the existing infrastructure but has no expired
 array. Real time tasks are treated the same as the current fixed priority &
 timeslice system. The details are in the management of normal policy tasks.

 Normal policy tasks have a dynamic priority that drops by one every
 RR_INTERVAL which equals 10ms * num_online_cpus(). Once they drop to zero
 they are requeued with 2 intervals at a lower priority and then drop back to
 one interval. If they drop to zero they are requeued with 3 intervals lower
 priority and so on. Every time a task sleeps it moves back up one priority.
 The sub-jiffy case is handled specially to prevent it fooling this system.

Use a fixed font to see clearly:

ie
RR_INTERVALs nice 0 task
20<-------------->40 PRI
11111111111111111111
02111111111111111111
00311111111111111111
and so on

nice +10 task
30<---->40 PRI
1111111111
0211111111
0031111111
and so on

 This is how cpu distribution is kept proportional while optimising latency
 for interactive tasks.

 The patch was made to be added to the sched_domains infrastructure since this
 is likely to be merged with mainline so all comparisons are made to a kernel
 with sched_domains patched in.

Subjective Performance:

 For the end desktop user they will find this performs much like the
 mainline 2.6 scheduler over a wide range of loads apart from the fact that
 applications start faster with this. 

 Some applications that misbehave with 2.6 mainline will behave better using
 less cpu time. At extreme loads the stock 2.6 scheduler feels better by
 being too unfair on cpu bound tasks which this one does not. Nice has more
 predictable and larger effects on cpu distribution (nice 0 gets 20 times
 what nice +20 gets).

Objective Performance:

 Note that there has been no "tuning" put into this scheduler at all; the cpu
 balancing on smp and so on is that used in mainline/sched_domains.

 The executive summary is that in most cases smp performance is equivalent and
 occasionally better, while maintaining interactivity and improving
 responsiveness. Detailed summary of benchmarks found at the end of the mail.

Known Problems:
 There is one minor interactivity issue I encountered during testing that I
 need to examine and adddress when time permits. There are no known bugs 
 per se.

Future Direction:
 I will be departing shortly for extended leave and will be unable to do any
 further coding till the end of May. This release, therefore, is to make the
 project known and to receive some testing in the interim.

Download:
 http://ck.kolivas.org/patches/2.6/2.6.4/experimental/staircase/

 Three patches are currently available:
 2.6.4-staircase5:
 A full patch against 2.6.4 which includes current sched_domains 
 2.6.4.domains2-staircase5:
 A patch against sched_domains which shows more clearly only my changes
 2.6.5-rc2-mm2-stair
 An incremental patch against 2.6.5-rc2-mm2.

Testing:
 Please feel free to test and use this patch extensively. I will be able
 to respond to emails only intermittently while away but unable to do any
 coding.

Thanks:
 Zwane Mwaikambo and William Lee Irwin III for help and ideas.


Con Kolivas
25th March 2004

-----------
Detailed benchmark results:
 2.6.4 is 2.6.4 patched with latest sched-domains
 2.6.4-s is 2.6.4 with sched-domains patched with staircase deadline sched

Reaim 8x (higher is better)
---------------------------

2.6.4 http://khack.osdl.org/stp/290462/
Peak load Test: Maximum Jobs per Minute 7482.37 (average of 3 runs)
Quick Convergence Test: Maximum Jobs per Minute 7351.78 (average of 3 runs)

2.6.4-s http://khack.osdl.org/stp/290536/
Peak load Test: Maximum Jobs per Minute 9492.30 (average of 3 runs)
Quick Convergence Test: Maximum Jobs per Minute 9037.34 (average of 3 runs)

kernbench 16x (lower is better)
-------------------------------

2.6.4 http://www.osdl.org/projects/kernbench/results/results.2.6.4-domains
Average Half Load Run:
Elapsed Time 112.084
Average Optimum Load Run:
Elapsed Time 79.07
Average Maximum Load Run:
Elapsed Time 80.926

2.6.4-s http://www.osdl.org/projects/kernbench/results/results.2.6.4-s4.2
Average Half Load -j 8 Run:
Elapsed Time 106.59
Average Optimal -j 64 Load Run:
Elapsed Time 78.6866
Average Maximal -j Load Run:
Elapsed Time 83.2134

Hackbench 8x (lower is better)
------------------------------

2.6.4 http://khack.osdl.org/stp/290460/
# Processes | Ave Time(sec)
20 		1.85
40 		2.7742
60 		3.754
80 		4.8018
100 		5.8758

2.6.4-s http://khack.osdl.org/stp/290542/
# Processes | Ave Time(sec)
20 		1.8894
40 		2.6808
60 		3.51853333333333
80 		4.40575
100 		5.365


Contest 1x (generally lower is better see http://contest.kolivas.org)
---------------------------------------------------------------------
 The osdl automated contest runs have been playing up and the averages posted
 here are wrong so I've tried to extract the meaningful runs from the logs
 and distill them here:

2.6.4 http://khack.osdl.org/stp/290453/
no_load:
Kernel[runs]	Time	CPU%	Loads	LCPU%	Ratio
2.6.4      4	103	96.1	0.0	0.0	1.00
cacherun:
2.6.4      4	100	99.0	0.0	0.0	0.97
process_load:
2.6.4      4	166	59.6	140.2	38.0	1.61
ctar_load:
2.6.4      4	148	68.2	17.2	17.6	1.44
xtar_load:
2.6.4      4	131	78.6	9.0	15.2	1.27
io_load:
2.6.4      4	147	70.7	36.2	20.4	1.43
io_other:
2.6.4      4	143	72.0	31.3	17.5	1.39
read_load:
2.6.4      3	140	XX	98.3	XX	1.36
list_load:
2.6.4      3	120	XX	2	XX	1.16
mem_load:
2.6.4      3	153	XX	121	XX	1.49

2.6.4-s http://khack.osdl.org/stp/290538/
no_load:
Kernel[runs]	Time	CPU%	Loads	LCPU%	Ratio
2.6.4      4	103	96.1	0.0	0.0	1.00
cacherun:
2.6.4      4	100	99.0	0.0	0.0	0.97
process_load:
2.6.4      4	103	97.1	3.8	1.0	1.00
ctar_load:
2.6.4      4	126	80.2	5.2	6.3	1.22
xtar_load:
2.6.4      4	111	91.9	2.0	2.7	1.08
io_load:
2.6.4      4	112	90.2	7.8	4.5	1.09
io_other:
2.6.4      4	117	86.3	8.3	5.1	1.14
read_load:
2.6.4      3	131	XX	76.3	XX	1.27
list_load:
2.6.4      3	113	XX	1	XX	1.10
mem_load:
2.6.4      3	105	XX	44.3	XX	1.02

-------------------------------------------------------

