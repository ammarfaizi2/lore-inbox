Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264452AbTLGQnj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 11:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264454AbTLGQnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 11:43:39 -0500
Received: from dp.samba.org ([66.70.73.150]:38377 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264452AbTLGQnh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 11:43:37 -0500
Date: Mon, 8 Dec 2003 03:39:14 +1100
From: Anton Blanchard <anton@samba.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched-HT-2.6.0-test11-A5
Message-ID: <20031207163914.GB19412@krispykreme>
References: <1027750000.1069604762@[10.10.2.4]> <Pine.LNX.4.58.0312011102540.3323@earth> <392900000.1070737269@[10.10.2.4]> <Pine.LNX.4.58.0312061601400.1758@montezuma.fsmlabs.com> <Pine.LNX.4.58.0312071433300.28463@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312071433300.28463@earth>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> i've seen a similar crash once on a 2-way (4-way) HT box, so there some
> startup race going on most likely.

Im seeing bootup crashes every now and then on a ppc64 box too. A few
other things Ive noticed:

- nr_running looks to be wrong. On an idle machine just after booting:

00:07:20 up 14 min,  3 users,  load average: 8.00, 7.67, 4.95

Its a 4 core 8 thread machine, so perhaps we are counting idle threads.

- The printk had me confused, we are really mapping cpu2 onto cpu1s runqueue.
Patch below.

- I tried the HT scheduler with NUMA enabled. Same machine, 4 core 8
threads, each NUMA node has 2 cores, 4 threads. Its easy to end up in a sub
optimal state:

 Cpu0 :   0.0% user,   0.0% system,   0.0% nice, 100.0% idle,   0.0% IO-wait
 Cpu1 :   0.0% user,   0.0% system,   0.0% nice, 100.0% idle,   0.0% IO-wait
 Cpu2 : 100.0% user,   0.0% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
 Cpu3 : 100.0% user,   0.0% system,   0.0% nice,   0.0% idle,   0.0% IO-wait

 Cpu4 : 100.0% user,   0.0% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
 Cpu5 :   0.0% user,   0.0% system,   0.0% nice, 100.0% idle,   0.0% IO-wait
 Cpu6 : 100.0% user,   0.0% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
 Cpu7 :   0.7% user,   0.7% system,   0.0% nice,  98.6% idle,   0.0% IO-wait

cpu0/1 are an SMT pair, cpu 0-3 are a NUMA node. As you can see cpu0/1
is free and cpu2/3 is busy on both threads. So far we have noticed
nr_cpus_node should probably be nr_runqueues_node now, otherwise the 
inter node balancing code could make bad decisions. However in this case
the imbalance is within the node, so Im not sure why cpu0/1 runqueue
hasnt stolen a task from cpu2/3.

Anton

--- foo/kernel/sched.c.ff	2003-12-03 02:03:41.000000000 -0600
+++ foo/kernel/sched.c	2003-12-04 11:37:40.980022085 -0600
@@ -1452,7 +1452,7 @@
 	runqueue_t *rq2 = cpu_rq(cpu2);
 	int cpu2_idx_orig = cpu_idx(cpu2), cpu2_idx;
 
-	printk("mapping CPU#%d's runqueue to CPU#%d's runqueue.\n", cpu1, cpu2);
+	printk("mapping CPU#%d's runqueue to CPU#%d's runqueue.\n", cpu2, cpu1);
 	BUG_ON(rq1 == rq2 || rq2->nr_running || rq_idx(cpu1) != cpu1);
 	/*
 	 * At this point, we dont have anything in the runqueue yet. So,
