Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262258AbSJFX5i>; Sun, 6 Oct 2002 19:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262261AbSJFX5i>; Sun, 6 Oct 2002 19:57:38 -0400
Received: from franka.aracnet.com ([216.99.193.44]:62948 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262258AbSJFX5g>; Sun, 6 Oct 2002 19:57:36 -0400
Date: Sun, 06 Oct 2002 17:00:40 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>, Michael Hohnbaum <hohnbaum@us.ibm.com>
cc: Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>
Subject: Re: [RFC] NUMA schedulers benchmark results
Message-ID: <1312267641.1033923638@[10.10.2.3]>
In-Reply-To: <200210062224.50087.efocht@ess.nec.de>
References: <200210062224.50087.efocht@ess.nec.de>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Errm, your magic shellscript is too wierd (aka doesn't work).
Can you just send the files out as attatchments?

M.

--On Sunday, October 06, 2002 10:24 PM +0200 Erich Focht <efocht@ess.nec.de> wrote:

> Hi,
> 
> here comes the benchmark I used for the NUMA scheduler test. Would
> be interesting to know whether it is useful to any other NUMA
> developer...
> 
> Regards,
> Erich
> 
> PS: it uses a 'time' command that understands the --format option,
> e.g. GNU time 1.7. Change it in the main script, if it doesn't
> work for you.
> 
> 
> On Sunday 06 October 2002 18:51, Erich Focht wrote:
>> Hi,
>> 
>> here are some results from testing various versions and approaches
>> to a NUMA scheduler. I used the numa_test benchmark which I'll post
>> in a separate email. It runs in parallel N tasks doing the same job:
>> access randomly a large array. As the array is large enough not to
>> fit into cache, this is very memory latency sensitive. Also it is
>> memory bandwidth sensitive. To emulate a real multi-user environment, the
>> jobs are disturbed by a short load peak. This is simulated by a call
>> to "hackbench" 3 seconds after the tasks were started. The performance
>> of the user tasks is depending very much on where they are scheduled
>> and are CPU hoggers such that the user times are quite independent of
>> the non-scheduler part of the underlying kernel. The elapsed times
>> are depending on "hackbench" which actually blocks the machine for the
>> time it is running. Hackbench is depending on the underlying kernel
>> and one should compare "elapsed_time - hackbench_time".
>> 
>> The test machine is a 16 CPU NEC Azusa with Itanium processors and
>> four nodes. The tested schedulers are:
>> 
>> A: O(1) scheduler in 2.5.39
>> B: O(1) scheduler with task steal limited to only one task (node
>>    affine scheduler with CONFIG_NUMA_SCHED=n) under 2.4.18
>> C: Michael Hohnbaum's "simple NUMA scheduler" under 2.5.39
>> D: pooling NUMA scheduler, no initial load balancing, idle pool_delay
>>    set to 0, under 2.4.18
>> E: node affine scheduler with initial load balancing and static homenode
>> F: node affine scheduler without initial load balancing and dynamic
>>    homenode selection (homenode selected where most of the memory is
>>    allocated).
>> 
>> As I'm rewriting the node affine scheduler to be more modular, I'll
>> redo the tests for cases D, E, F on top of 2.5.X kernels soon.
>> 
>> The results are summarized in the tables below. A set of outputs (for
>> N=8, 16, 32) is attached. They show clearly why the node affine
>> scheduler beats them all: The initial load balancing is node-aware,
>> the task-stealing too. Sometimes the node affine force is not large
>> enough to bring the task back to the homenode, but it is almost always
>> good enough.
>> 
>> The (F) solution with dynamically determined homenode show that the
>> initial load balancing is crucial, as the equal node balance is not
>> strongly enforced dynamically. So the optimal solution is probably
>> (F) with initial load balancing.
>> 
>> 
>> Average user time (U) and total user time (TU). Minimum per row should
>> be considered.
>> ----------------------------------------------------------------------
>> Scheduler:	A	B	C	D	E	F
>> N=4	U	28.12	30.77	33.00	-	27.20	30.29
>> 	TU	112.55	123.13	132.08	-	108.88	121.25
>> N=8	U	30.47	31.39	31.65	30.76	28.67	30.08
>> 	TU	243.86	251.27	253.30	246.23	229.51	240.75
>> N=16	U	36.42	33.64	32.18	32.27	31.50	32.83
>> 	TU	582.91	538.49	515.11	516.53	504.17	525.59
>> N=32	U	38.69	34.83	34.05	33.76	33.89	34.11
>> 	TU	1238.4	1114.9	1090.1	1080.8	1084.9	1091.9
>> N=64	U	39.73	34.73	34.23	-	(33.32)	34.98
>> 	TU	2543.4	2223.4	2191.7	-	(2133)	2239.5
>> 
>> 
>> Elapsed time (E), hackbench time (H). Diferences between 2.4.18 and
>> 2.5.39 based kernels due to "hackbench", which performs differently.
>> Compare E-H within a row, but don't take it too seriously.
>> --------------------------------------------------------------------
>> Scheduler:	A	B	C	D	E	F
>> N=4	E	37.33	37.96	48.31	-	28.14	35.91
>> 	H	9.98	1.49	10.65	-	1.99	1.43
>> N=8	E	46.17	39.50	42.53	39.72	30.28	38.28
>> 	H	9.64	1.86	7.27	2.07	2.33	1.86
>> N=16	E	47.21	44.67	49.66	42.97	36.98	42.51
>> 	H	5.90	4.69	2.93	5.178	5.56	5.94
>> N=32	E	88.60	79.92	80.34	78.35	76.84	77.38
>> 	H	6.29	5.23	2.85	4.51	5.29	4.28
>> N=64	E	167.10	147.16	150.59	-	(133.9)	148.94
>> 	H	5.96	4.67	3.10	-	(-)	6.86
>> 
>> (The E:N=64 results are without hackbench disturbance.)
>> 
>> Best regards,
>> Erich


