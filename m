Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267327AbUIJIys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267327AbUIJIys (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 04:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267324AbUIJIxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 04:53:03 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:11436 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S267323AbUIJIw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 04:52:26 -0400
Date: Fri, 10 Sep 2004 10:52:07 +0200 (CEST)
From: Simon Derr <simon.derr@bull.net>
X-X-Sender: derr@daphne.frec.bull.fr
To: simon.derr@bull.net, pj@sgi.com
cc: linux-kernel@vger.kernel.org
Subject: [rfc][patch] 1/2 Additional cpuset features
Message-ID: <Pine.LNX.4.58.0409101036090.2891@daphne.frec.bull.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm sending a series of two cpuset-related patches.
I'm not asking for their inclusion in the current kernel.
These are just feature proposals.

Actually, these patches aim to restore the "original" behaviour of the
cpusets, as it was one year from now or so. Since then, to ease the
acceptance of the cpusets, some 'contreversial' features have been
removed.

This first patch adds automatic process migration upon cpuset
modification. Whenever the list of CPUs of a cpuset changes, the kernel
will move tasks so they stay "inside" their cpuset.

Applies against 2.6.9-rc1-mm4.


Signed-Off-By: Simon Derr <simon.derr@bull.net>
Index: mm4/kernel/cpuset.c
===================================================================
--- mm4.orig/kernel/cpuset.c	2004-09-08 10:01:23.168151957 +0200
+++ mm4/kernel/cpuset.c	2004-09-08 10:13:30.335135237 +0200
@@ -534,6 +534,84 @@
 	return 0;
 }

+/**
+ *	migrate_cpuset_processes - re-place processes into their cpuset's cpus
+ *	@cs:	the cpusets whose processes we have to migrate.
+ *
+ *	When the list of CPUs of cpuset @cs changes, we have to update all the
+ *	attached processes' masks, and maybe even migrate them.
+ *	Should be called with the cpuset_sem hold
+ */
+static void migrate_cpuset_processes(struct cpuset * cs)
+{
+	struct task_struct *g, *p;
+	/* This should be a RARE use of the cpusets.
+	 * therefore we'll prefer an inefficient operation here
+	 * (searching the whole process list)
+	 * than adding another list_head in task_t
+	 * and locks and list_add for each fork()
+	 */
+
+	/* we need to lock tasklist_lock for reading the processes list
+	 * BUT we cannot call set_cpus_allowed with any spinlock held
+	 * => we need to store the list of task struct in an array
+	 */
+	struct task_struct ** array;
+	int first = 1;
+	int nb = 0;
+	int sz;
+
+retry:
+	/* at most cs->count - 1 processes to migrate */
+	/* keep some room in case some processes fork() during kmalloc() */
+	sz = atomic_read(&cs->count) + 10;
+	array = (struct task_struct **) kmalloc(sz * sizeof(struct task_struct *), GFP_ATOMIC);
+	if (!array) {
+		printk("Error allocating array in migrate_cpuset_processes !\n");
+		return;
+	}
+	/* see linux/sched.h for this nested for/do-while loop */
+	read_lock(&tasklist_lock);
+	do_each_thread(g, p) {
+		if (p->cpuset == cs) {
+			if (nb == sz) {
+				printk("migrate_cpuset_processes: array full !\n");
+				read_unlock(&tasklist_lock);
+				kfree(array);
+				goto retry;
+			}
+			get_task_struct(p);
+			array[nb++] = p;
+		}
+	} while_each_thread(g, p);
+	read_unlock(&tasklist_lock);
+
+	while(nb) {
+		struct task_struct * p = array[--nb];
+		cpumask_t cpus;
+		/*
+		 * If the tasks current CPU placement overlaps with its new cpuset,
+		 * then let it run in that overlap.  Otherwise fallback to simply
+		 * letting it have the run of the CPUs in the new cpuset.
+		 */
+		cpus_and(cpus, p->cpus_allowed, cs->cpus_allowed);
+		if (cpus_empty(cpus))
+			cpus = cs->cpus_allowed;
+		set_cpus_allowed(p, cpus);
+		put_task_struct(p);
+	}
+	kfree(array);
+	/* what happens if a task present in the array forks now ?
+	 * solution (ahem) -- do everything twice -- that way forked
+	 * tasks missed by the first pass will be taken by the second pass,
+	 * and the tasks missed by the second pass have their parent taken
+	 * by the first pass */
+	if (first) {
+		first = 0;
+		goto retry;
+	}
+}
+
 static int update_cpumask(struct cpuset *cs, char *buf)
 {
 	struct cpuset trialcs;
@@ -544,9 +622,13 @@
 	if (retval < 0)
 		return retval;
 	cpus_and(trialcs.cpus_allowed, trialcs.cpus_allowed, cpu_online_map);
-	retval = validate_change(cs, &trialcs);
-	if (retval == 0)
-		cs->cpus_allowed = trialcs.cpus_allowed;
+	if (!cpus_equal(cs->cpus_allowed, trialcs.cpus_allowed)) {
+		retval = validate_change(cs, &trialcs);
+		if (retval == 0) {
+			cs->cpus_allowed = trialcs.cpus_allowed;
+			migrate_cpuset_processes(cs);
+		}
+	}
 	return retval;
 }

