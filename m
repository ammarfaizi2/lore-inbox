Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265619AbUFCR1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265619AbUFCR1A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 13:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263807AbUFCRSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 13:18:24 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:46819 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265624AbUFCRMk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 13:12:40 -0400
Date: Thu, 3 Jun 2004 10:11:15 -0700
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, Ashok Raj <ashok.raj@intel.com>,
       Christoph Hellwig <hch@infradead.org>, Jesse Barnes <jbarnes@sgi.com>,
       Joe Korty <joe.korty@ccur.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Mikael Pettersson <mikpe@csd.uu.se>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Paul Jackson <pj@sgi.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Simon Derr <Simon.Derr@bull.net>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: [PATCH] cpumask 10/10 optimize various uses of new cpumasks
Message-Id: <20040603101115.7f746d98.pj@sgi.com>
In-Reply-To: <20040603094339.03ddfd42.pj@sgi.com>
References: <20040603094339.03ddfd42.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cpumask 10/10 optimize various uses of new cpumasks

        Make use of for_each_cpu_mask() macro to simplify and optimize
        a couple of sparc64 per-CPU loops.

        Optimize a bit of cpumask code for asm-i386/mach-es7000

        Convert physids_complement() to use both args in the files
	include/asm-i386/mpspec.h, include/asm-x86_64/mpspec.h.

        Remove cpumask hack from asm-x86_64/topology.h routine
	pcibus_to_cpumask().

        Clarify and slightly optimize several cpumask manipulations
	in kernel/sched.c

 arch/sparc64/kernel/smp.c               |   66 +++-------
 include/asm-i386/mach-es7000/mach_ipi.h |    5 
 include/asm-i386/mpspec.h               |    2 
 include/asm-x86_64/mpspec.h             |    2 
 include/asm-x86_64/topology.h           |    6 
 kernel/sched.c                          |   18 +-
 6 files changed, 39 insertions(+), 60 deletions(-)

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 2.6.7-rc2-mm2/kernel/sched.c
===================================================================
--- 2.6.7-rc2-mm2.orig/kernel/sched.c	2004-06-03 06:42:03.000000000 -0700
+++ 2.6.7-rc2-mm2/kernel/sched.c	2004-06-03 07:08:09.000000000 -0700
@@ -802,10 +802,9 @@
 		return cpu;
 
 	cpus_and(tmp, sd->span, cpu_online_map);
-	for_each_cpu_mask(i, tmp) {
-		if (!cpu_isset(i, p->cpus_allowed))
-			continue;
+	cpus_and(tmp, tmp, p->cpus_allowed);
 
+	for_each_cpu_mask(i, tmp) {
 		if (idle_cpu(i))
 			return i;
 	}
@@ -3506,7 +3505,7 @@
 	perfctr_set_cpus_allowed(p, new_mask);
 
 	rq = task_rq_lock(p, &flags);
-	if (any_online_cpu(new_mask) == NR_CPUS) {
+	if (!cpus_intersects(new_mask, cpu_online_map)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -3682,8 +3681,7 @@
 		if (dest_cpu == NR_CPUS)
 			dest_cpu = any_online_cpu(tsk->cpus_allowed);
 		if (dest_cpu == NR_CPUS) {
-			cpus_clear(tsk->cpus_allowed);
-			cpus_complement(tsk->cpus_allowed);
+			cpus_setall(tsk->cpus_allowed);
 			dest_cpu = any_online_cpu(tsk->cpus_allowed);
 
 			/* Don't tell them about moving exiting tasks
@@ -3999,7 +3997,7 @@
 			int j;
 			char str[NR_CPUS];
 			struct sched_group *group = sd->groups;
-			cpumask_t groupmask, tmp;
+			cpumask_t groupmask;
 
 			cpumask_scnprintf(str, NR_CPUS, sd->span);
 			cpus_clear(groupmask);
@@ -4029,8 +4027,7 @@
 				if (!cpus_weight(group->cpumask))
 					printk(" ERROR empty group:");
 
-				cpus_and(tmp, groupmask, group->cpumask);
-				if (cpus_weight(tmp) > 0)
+				if (cpus_intersects(groupmask, group->cpumask))
 					printk(" ERROR repeated CPUs:");
 
 				cpus_or(groupmask, groupmask, group->cpumask);
@@ -4049,8 +4046,7 @@
 			sd = sd->parent;
 
 			if (sd) {
-				cpus_and(tmp, groupmask, sd->span);
-				if (!cpus_equal(tmp, groupmask))
+				if (!cpus_subset(groupmask, sd->span))
 					printk(KERN_DEBUG "ERROR parent span is not a superset of domain->span\n");
 			}
 
Index: 2.6.7-rc2-mm2/arch/sparc64/kernel/smp.c
===================================================================
--- 2.6.7-rc2-mm2.orig/arch/sparc64/kernel/smp.c	2004-06-03 06:42:03.000000000 -0700
+++ 2.6.7-rc2-mm2/arch/sparc64/kernel/smp.c	2004-06-03 07:08:09.000000000 -0700
@@ -406,14 +406,8 @@
 	int i;
 
 	__asm__ __volatile__("rdpr %%pstate, %0" : "=r" (pstate));
-	for (i = 0; i < NR_CPUS; i++) {
-		if (cpu_isset(i, mask)) {
-			spitfire_xcall_helper(data0, data1, data2, pstate, i);
-			cpu_clear(i, mask);
-			if (cpus_empty(mask))
-				break;
-		}
-	}
+	for_each_cpu_mask(i, mask)
+		spitfire_xcall_helper(data0, data1, data2, pstate, i);
 }
 
 /* Cheetah now allows to send the whole 64-bytes of data in the interrupt
@@ -456,25 +450,19 @@
 
 	nack_busy_id = 0;
 	{
-		cpumask_t work_mask = mask;
 		int i;
 
-		for (i = 0; i < NR_CPUS; i++) {
-			if (cpu_isset(i, work_mask)) {
-				u64 target = (i << 14) | 0x70;
-
-				if (!is_jalapeno)
-					target |= (nack_busy_id << 24);
-				__asm__ __volatile__(
-					"stxa	%%g0, [%0] %1\n\t"
-					"membar	#Sync\n\t"
-					: /* no outputs */
-					: "r" (target), "i" (ASI_INTR_W));
-				nack_busy_id++;
- 				cpu_clear(i, work_mask);
-				if (cpus_empty(work_mask))
-					break;
-			}
+		for_each_cpu_mask(i, mask) {
+			u64 target = (i << 14) | 0x70;
+
+			if (!is_jalapeno)
+				target |= (nack_busy_id << 24);
+			__asm__ __volatile__(
+				"stxa	%%g0, [%0] %1\n\t"
+				"membar	#Sync\n\t"
+				: /* no outputs */
+				: "r" (target), "i" (ASI_INTR_W));
+			nack_busy_id++;
 		}
 	}
 
@@ -507,7 +495,6 @@
 			printk("CPU[%d]: mondo stuckage result[%016lx]\n",
 			       smp_processor_id(), dispatch_stat);
 		} else {
-			cpumask_t work_mask = mask;
 			int i, this_busy_nack = 0;
 
 			/* Delay some random time with interrupts enabled
@@ -518,22 +505,17 @@
 			/* Clear out the mask bits for cpus which did not
 			 * NACK us.
 			 */
-			for (i = 0; i < NR_CPUS; i++) {
-				if (cpu_isset(i, work_mask)) {
-					u64 check_mask;
-
-					if (is_jalapeno)
-						check_mask = (0x2UL << (2*i));
-					else
-						check_mask = (0x2UL <<
-							      this_busy_nack);
-					if ((dispatch_stat & check_mask) == 0)
-						cpu_clear(i, mask);
-					this_busy_nack += 2;
-					cpu_clear(i, work_mask);
-					if (cpus_empty(work_mask))
-						break;
-				}
+			for_each_cpu_mask(i, mask) {
+				u64 check_mask;
+
+				if (is_jalapeno)
+					check_mask = (0x2UL << (2*i));
+				else
+					check_mask = (0x2UL <<
+						      this_busy_nack);
+				if ((dispatch_stat & check_mask) == 0)
+					cpu_clear(i, mask);
+				this_busy_nack += 2;
 			}
 
 			goto retry;
Index: 2.6.7-rc2-mm2/include/asm-i386/mach-es7000/mach_ipi.h
===================================================================
--- 2.6.7-rc2-mm2.orig/include/asm-i386/mach-es7000/mach_ipi.h	2004-06-03 06:42:03.000000000 -0700
+++ 2.6.7-rc2-mm2/include/asm-i386/mach-es7000/mach_ipi.h	2004-06-03 07:08:09.000000000 -0700
@@ -10,9 +10,8 @@
 
 static inline void send_IPI_allbutself(int vector)
 {
-	cpumask_t mask = cpumask_of_cpu(smp_processor_id());
-	cpus_complement(mask);
-	cpus_and(mask, mask, cpu_online_map);
+	cpumask_t mask = cpu_online_map;
+	cpu_clear(smp_processor_id(), mask);
 	if (!cpus_empty(mask))
 		send_IPI_mask(mask, vector);
 }
Index: 2.6.7-rc2-mm2/include/asm-i386/mpspec.h
===================================================================
--- 2.6.7-rc2-mm2.orig/include/asm-i386/mpspec.h	2004-06-03 06:42:03.000000000 -0700
+++ 2.6.7-rc2-mm2/include/asm-i386/mpspec.h	2004-06-03 07:08:09.000000000 -0700
@@ -53,7 +53,7 @@
 #define physids_and(dst, src1, src2)		bitmap_and((dst).mask, (src1).mask, (src2).mask, MAX_APICS)
 #define physids_or(dst, src1, src2)		bitmap_or((dst).mask, (src1).mask, (src2).mask, MAX_APICS)
 #define physids_clear(map)			bitmap_zero((map).mask, MAX_APICS)
-#define physids_complement(map)			bitmap_complement((map).mask, (map).mask, MAX_APICS)
+#define physids_complement(dst, src)		bitmap_complement((dst).mask,(src).mask, MAX_APICS)
 #define physids_empty(map)			bitmap_empty((map).mask, MAX_APICS)
 #define physids_equal(map1, map2)		bitmap_equal((map1).mask, (map2).mask, MAX_APICS)
 #define physids_weight(map)			bitmap_weight((map).mask, MAX_APICS)
Index: 2.6.7-rc2-mm2/include/asm-x86_64/mpspec.h
===================================================================
--- 2.6.7-rc2-mm2.orig/include/asm-x86_64/mpspec.h	2004-06-03 06:42:03.000000000 -0700
+++ 2.6.7-rc2-mm2/include/asm-x86_64/mpspec.h	2004-06-03 07:08:09.000000000 -0700
@@ -212,7 +212,7 @@
 #define physids_and(dst, src1, src2)		bitmap_and((dst).mask, (src1).mask, (src2).mask, MAX_APICS)
 #define physids_or(dst, src1, src2)		bitmap_or((dst).mask, (src1).mask, (src2).mask, MAX_APICS)
 #define physids_clear(map)			bitmap_zero((map).mask, MAX_APICS)
-#define physids_complement(map)			bitmap_complement((map).mask, (map).mask, MAX_APICS)
+#define physids_complement(dst, src)		bitmap_complement((dst).mask, (src).mask, MAX_APICS)
 #define physids_empty(map)			bitmap_empty((map).mask, MAX_APICS)
 #define physids_equal(map1, map2)		bitmap_equal((map1).mask, (map2).mask, MAX_APICS)
 #define physids_weight(map)			bitmap_weight((map).mask, MAX_APICS)
Index: 2.6.7-rc2-mm2/include/asm-x86_64/topology.h
===================================================================
--- 2.6.7-rc2-mm2.orig/include/asm-x86_64/topology.h	2004-06-03 06:42:03.000000000 -0700
+++ 2.6.7-rc2-mm2/include/asm-x86_64/topology.h	2004-06-03 07:08:09.000000000 -0700
@@ -20,9 +20,11 @@
 #define node_to_first_cpu(node) 	(__ffs(node_to_cpumask[node]))
 #define node_to_cpumask(node)		(node_to_cpumask[node])
 
-static inline unsigned long pcibus_to_cpumask(int bus)
+static inline cpumask_t pcibus_to_cpumask(int bus)
 {
-	return mp_bus_to_cpumask[bus] & cpu_online_map; 
+	cpumask_t tmp;
+	cpus_and(tmp, mp_bus_to_cpumask[bus], cpu_online_map);
+	return tmp;
 }
 
 #define NODE_BALANCE_RATE 30	/* CHECKME */ 


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
