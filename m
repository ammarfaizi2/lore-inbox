Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbVDCONM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbVDCONM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 10:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVDCONM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 10:13:12 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:33444 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261764AbVDCOM6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 10:12:58 -0400
Date: Sun, 3 Apr 2005 07:12:27 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: mingo@elte.hu
Cc: kenneth.w.chen@intel.com, torvalds@osdl.org, nickpiggin@yahoo.com.au,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: auto-tune migration costs [was: Re: Industry db
 benchmark result on recent 2.6 kernels]
Message-Id: <20050403071227.666ac33d.pj@engr.sgi.com>
In-Reply-To: <20050403043420.212290a8.pj@engr.sgi.com>
References: <200504020100.j3210fg04870@unix-os.sc.intel.com>
	<20050402145351.GA11601@elte.hu>
	<20050402215332.79ff56cc.pj@engr.sgi.com>
	<20050403070415.GA18893@elte.hu>
	<20050403043420.212290a8.pj@engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Three more observations.

 1) The slowest measure_one() calls are, not surprisingly, those for the
    largest sizes.  At least on my test system of the moment, the plot
    of cost versus size has one major maximum (a one hump camel, not two).
    
    Seems like if we computed from smallest size upward, instead of largest
    downward, and stopped whenever two consecutive measurements were less
    than say 70% of the max seen so far, then we could save a nice chunk
    of the time.

    Of course, if two hump systems exist, this is not reliable on them.

 2) Trivial warning fix for printf format mismatch:

=================================== begin ===================================
--- 2.6.12-rc1-mm4.orig/kernel/sched.c  2005-04-03 06:32:34.000000000 -0700
+++ 2.6.12-rc1-mm4/kernel/sched.c       2005-04-03 06:34:07.000000000 -0700
@@ -5211,7 +5211,7 @@ void __devinit calibrate_migration_costs
 #ifdef CONFIG_X86
                        cpu_khz/1000
 #else
-                       -1
+                       -1L
 #endif
                );
        printk("---------------------\n");
==================================== end ====================================


 3) I was noticing that my test system was only showing a couple of distinct
    values for cpu_distance, even though it has 4 distinct distances for
    values of node_distance.  So I coded up a variant of cpu_distance that
    converts the problem to a node_distance problem, and got the following
    cost matrix:

=================================== begin ===================================
Total of 8 processors activated (15515.64 BogoMIPS).
---------------------
migration cost matrix (max_cache_size: 0, cpu: -1 MHz):
---------------------
          [00]    [01]    [02]    [03]    [04]    [05]    [06]    [07]
[00]:     -     4.0(0) 21.7(1) 21.7(1) 25.2(2) 25.2(2) 25.3(3) 25.3(3)
[01]:   4.0(0)    -    21.7(1) 21.7(1) 25.2(2) 25.2(2) 25.3(3) 25.3(3)
[02]:  21.7(1) 21.7(1)    -     4.0(0) 25.3(3) 25.3(3) 25.2(2) 25.2(2)
[03]:  21.7(1) 21.7(1)  4.0(0)    -    25.3(3) 25.3(3) 25.2(2) 25.2(2)
[04]:  25.2(2) 25.2(2) 25.3(3) 25.3(3)    -     4.0(0) 21.7(1) 21.7(1)
[05]:  25.2(2) 25.2(2) 25.3(3) 25.3(3)  4.0(0)    -    21.7(1) 21.7(1)
[06]:  25.3(3) 25.3(3) 25.2(2) 25.2(2) 21.7(1) 21.7(1)    -     4.0(0)
[07]:  25.3(3) 25.3(3) 25.2(2) 25.2(2) 21.7(1) 21.7(1)  4.0(0)    -
---------------------
cacheflush times [4]: 4.0 (4080540) 21.7 (21781380) 25.2 (25259428) 25.3 (25372682)
---------------------
==================================== end ====================================


    The code (below) is twice as complicated, the runtime twice as long,
    and it's less intuitive - sched_domains seems more appropriate as
    the basis for migration costs than the node distances in SLIT tables.
    Finally, I don't know if distinguishing between costs of 21.7 and
    25.3 is worth much.

    So the case for switching to this node_distance base is less than
    persuasive, to put it politely.

    Perhaps it's only real value is in highlighting that perhaps the
    code to setup the sched_domain topology on our ia64 SN2 Altix systems
    is too coarse, given that it only found two distance values, not four.

    If that's the case, I will have to call in someone else to examine
    whether it's appropriate to refine the sched_domains setup for this
    kind of system.  I'm not competent to determine that, nor to code it.

    Here's the code that bases cpu_distance on node_distance:

=================================== begin ===================================
__init static int cmpint(const void *a, const void *b)
{
        return *(int *)a - *(int *)b;
}

/*
 * Estimate distance of two CPUs based on their node_distance,
 * mapping to sequential integers 0, 1, ... N-1, for the N
 * distinct values of distances (closest CPUs are distance 0,
 * farthest CPUs are distance N-1).  If there are more than
 * MAX_DOMAIN_DISTANCE distinct different distance values,
 * collapse the larger distances to one value.
 */

__init static unsigned long cpu_distance(int cpu1, int cpu2)
{
	static int num_dist_vals;
	static int node_distances[MAX_DOMAIN_DISTANCE];
	int dist = node_distance(cpu_to_node(cpu1), cpu_to_node(cpu2));
	int v;

	if (num_dist_vals == 0) {
		int i, j, k;

		/*
		 * For each dist not already in node_distances[], if there's
		 * room or it's less than an existing 'luser' entry, add it.
		 */
		for_each_online_node(i) {
			for_each_online_node(j) {
				int dist = node_distance(i, j);
				int luser = -1;

				for (k = 0; k < num_dist_vals; k++) {
					if (node_distances[k] == dist)
						break;
					if (dist < node_distances[k])
						luser = k;
				}
				if (node_distances[k] == dist)
					continue;
				else if (num_dist_vals < MAX_DOMAIN_DISTANCE)
					node_distances[num_dist_vals++] = dist;
				else if (luser >= 0)
					node_distances[luser] = dist;
			}
		}
		/*
		 * Now node_distances[] has the smallest num_dist_vals
		 * distinct node distance values.  Lets sort them.
		 */
		sort(node_distances, num_dist_vals, sizeof(int), cmpint, NULL);

		if (migration_debug) {
			printk("Sorted node_distances used for cpu distances\n");
			for(v = 0; v < num_dist_vals; v++)
				printk("  node_distances[%d] = %d\n",
						v, node_distances[v]);
		}
	}

	/* The "- 1" maps all larger sizes onto one */
	for (v = 0; v < num_dist_vals - 1; v++)
		if (dist == node_distances[v])
			break;
	return v;
}
==================================== end ====================================


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
