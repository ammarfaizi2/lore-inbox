Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932503AbWGaHHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbWGaHHu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 03:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbWGaHHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 03:07:49 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:49306 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932503AbWGaHHt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 03:07:49 -0400
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       Suresh Siddha <suresh.b.siddha@intel.com>
Cc: Simon.Derr@bull.net, Jack Steiner <steiner@sgi.com>,
       Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
Date: Mon, 31 Jul 2006 00:07:34 -0700
Message-Id: <20060731070734.19126.40501.sendpatchset@v0>
Subject: [BUG] sched: big numa dynamic sched domain memory corruption
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have hit a bug in the dynamic sched domain setup.  It causes random
memory writes via a stale pointer.

I don't entirely understand the code yet, so my description of this
bug may be flawed.  I'll do the best I can.  Thanks to Jack Steiner
for figuring out what we know so far.

The three systems we are testing on have 128, 224 and 256 CPUs.
They are single core, ia64 SN2 itanium systems configured with:
  CONFIG_NUMA - enabled
  CONFIG_SCHED_MC - disabled
  CONFIG_SCHED_SMT - disabled

They are running approximately the 2.6.16.* kernel found in SLES10.

We first noticed the problem due to the memory clobbering, and
had to crank up the slab debug code a notch to backtrack to the
apparent original cause.  The bug does not cause an immediate
crash or kernel complaint.

In sum, it appears that the large array sched_group_allnodes is
free'd up by arch_destroy_sched_domains() when someone redefines
the cpu_exclusive portion of the cpuset configuration, but some
of the sd->groups are left pointing into the free'd array, causing
the assignment:
	sd->groups->cpu_power = power;
to write via a stale sd->groups pointer.

The build_sched_domains() code only rebuilds the sd->groups pointer
to the current sched_group_allnodes array for those cpus that are
in the specified cpu_map.  The remaining cpus seem to be left with
stale sd->groups pointers.

The above summary may be too inaccurate to be helpful.

I'll step through the failing scenario in more detail, and hopefully
with fewer inaccuracies.


    During the system boot, the initial call to build_sched_domains()
    sets up all encompasing sched_group_allnodes and the smaller
    child domains and groups.  So far, all is well.  Part of
    this initialization includes allocating a large array called
    sched_group_allnodes, and for each cpu in the system, initializing
    its sd->groups->cpu_power element in the sched_group_allnodes
    array.

    After boot, we run some commands that create a child cpuset,
    with, for this example, cpus 4-8, marked cpu_exclusive.

    This calls arch_destroy_sched_domains(), which frees
    sched_group_allnodes.

    Then this calls build_sched_domains() with a mask including
    *all-but* cpus 4-8 (in this example).  That call allocates a new
    sched_group_allnodes and in the first for_each_cpu_mask() loop,
    initializes the sched domain, including sd->groups, for *all-but*
    cpus 4-8.  The sd->groups for 4-8 are still pointing back at
    the now freed original sched_group_allnodes array.

    Then we call build_sched_domains() again, with a mask for just
    cpus 4-8.  It executes the line:
    	sd->groups->cpu_power = power;
    with a stale sd->groups pointer, clobbering the already freed
    memory that used to be in the sched_group_allnodes array.  For our
    situation, we are in the "#ifdef CONFIG_NUMA" variant of this line.


Aha - while writing the above, I had an idea for a possible fix.

The following patch seems to fix this problem, at least for the
above CONFIG on one of the test systems.  Though I have no particular
confidence that it is a good patch.

The idea of the patch is to -always- execute the code conditioned by
the "if (... > SD_NODES_PER_DOMAIN*...) {" test on big systems, even
if we happen to be calling build_sched_domains() with a small cpu_map.

---

 kernel/sched.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux.orig/kernel/sched.c	2006-07-30 23:42:12.182958555 -0700
+++ linux/kernel/sched.c	2006-07-30 23:45:12.513282355 -0700
@@ -5675,12 +5675,13 @@ void build_sched_domains(const cpumask_t
 		int group;
 		struct sched_domain *sd = NULL, *p;
 		cpumask_t nodemask = node_to_cpumask(cpu_to_node(i));
+		int cpus_per_node = cpus_weight(nodemask);
 
 		cpus_and(nodemask, nodemask, *cpu_map);
 
 #ifdef CONFIG_NUMA
-		if (cpus_weight(*cpu_map)
-				> SD_NODES_PER_DOMAIN*cpus_weight(nodemask)) {
+		if (cpus_weight(cpu_online_map)
+				> SD_NODES_PER_DOMAIN*cpus_per_node) {
 			if (!sched_group_allnodes) {
 				sched_group_allnodes
 					= kmalloc(sizeof(struct sched_group)


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
