Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752040AbWFLPap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbWFLPap (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 11:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbWFLPap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 11:30:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:62385 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752038AbWFLPap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 11:30:45 -0400
Message-ID: <448D88A2.1060002@suse.de>
Date: Mon, 12 Jun 2006 17:30:42 +0200
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [RFC] scheduler issue & patch
Content-Type: multipart/mixed;
 boundary="------------070308070205030409010205"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070308070205030409010205
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

  Hi,

I'm looking into a scheduler issue with a NUMA box and scheduling
domains.  The machine is a dual-core opteron with with two nodes, i.e.
four cpus.  cpu0+1 build node0, cpu2+3 build node1.

Now I have an application (benchmark) with two threads which performs
best when the two threads are running on different nodes (probably
because the cpus on each node share the L2 cache).  The scheduler tends
to keep threads on the local node though, wihch probably makes sense on
most cases because local memory is faster.

Ok, we have tools to give hints to the scheduler (taskset, numactl).
The problem is it doesn't work well.  I can ask the scheduler to use
cpu1 (node0) and cpu3 (node1) only (via "taskset 0x0a").  But the
scheduler very often schedules both threads on the same cpu :-(

I think the reason is that the scheduler always checks the complete cpu
groups when calculation the group load, without looking at
task->cpus_allowed.  So we have the effect that the scheduler walks down
the scheduler domain tree, looks at the group for node0, looks at both
cpu0 and cpu1, finds node0 being not overloaded due to cpu0 being idle
and decides to keep the thread on the local node.  Next it walks down
the tree and finds it isn't allowed to use the idle cpu0.  So both
threads get scheduled to cpu1.  Oops.

The patch attached takes the sledgehammer approach to fix it:  In case
we have a non-default cpumask in task->cpus_allowed the scheduler
ignores all the fancy scheduling domains and simply spreads the load
equally over the cpus allowed by task->cpus_allowed.  Not exactly
elegant, but works.  Not each time, but very often.

Comments?  Ideas how to solve this better?  I've also tried to play with
the group load calculation, but it didn't work well.  I'm kida lost in
all those scheduler tuning knobs ...

cheers,

  Gerd


--------------070308070205030409010205
Content-Type: text/x-patch;
 name="sched.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched.diff"

--- kernel/sched.c.bug176738	2006-06-08 15:43:09.000000000 +0200
+++ kernel/sched.c	2006-06-12 14:56:51.000000000 +0200
@@ -1020,6 +1020,28 @@
 	return idlest;
 }
 
+static int
+find_idlest_cpu_nodomain(struct task_struct *p, int this_cpu)
+{
+	cpumask_t tmp;
+	unsigned long load, min_load = ULONG_MAX;
+	int idlest = -1;
+	int i;
+
+	/* Traverse only the allowed CPUs */
+	cpus_and(tmp, cpu_online_map, p->cpus_allowed);
+
+	for_each_cpu_mask(i, tmp) {
+		load = source_load(i, 0);
+
+		if (load < min_load || (load == min_load && i == this_cpu)) {
+			min_load = load;
+			idlest = i;
+		}
+	}
+	return idlest;
+}
+
 /*
  * sched_balance_self: balance the current task (running on cpu) in domains
  * that have the 'flag' flag set. In practice, this is SD_BALANCE_FORK and
@@ -1036,6 +1058,9 @@
 	struct task_struct *t = current;
 	struct sched_domain *tmp, *sd = NULL;
 
+	if (!cpus_full(t->cpus_allowed))
+		return find_idlest_cpu_nodomain(t, cpu);
+
 	for_each_domain(cpu, tmp)
 		if (tmp->flags & flag)
 			sd = tmp;

--------------070308070205030409010205--
