Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265051AbUETLo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265051AbUETLo0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 07:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265062AbUETLo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 07:44:26 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:49844 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S265051AbUETLoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 07:44:20 -0400
Message-ID: <40AC9823.6020709@colorfullife.com>
Date: Thu, 20 May 2004 13:36:03 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jack Steiner <steiner@sgi.com>
CC: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: RCU scaling on large systems
Content-Type: multipart/mixed;
 boundary="------------080506010808040600040809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080506010808040600040809
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jack Steiner wrote:

>On Sat, May 01, 2004 at 02:17:04PM -0700, William Lee Irwin III wrote:
>> On Sat, May 01, 2004 at 07:08:05AM -0500, Jack Steiner wrote:
>> > On a 512p idle 2.6.5 system, each cpu spends ~6% of the time in the kernel
>> > RCU code. The time is spent contending for shared cache lines.
>> 
>> Would something like this help cacheline contention? This uses the
>> per_cpu data areas to hold per-cpu booleans for needing switches.
>> Untested/uncompiled.
>  
>
> [snip]
>
>We use 64MB granules. The percpu data structures on the individual nodes 
>are separated by addresses that differ by many GB. A scan of all percpu 
>data structures requires a TLB entry for each node.  This is costly & 
>trashes the TLB.  (Our max system size is currently 256 nodes).
>  
>
rcu_cpu_mask serves two purposes:
- if a bit for a cpu is set, then the cpu must report quiescent states. Thus all cpus continuously poll their own bits.
- If a cpu notices that it completed a quiescent state, it clears it's own bit, checks all bits and completes the grace period. This happens under a global spinlock.

What about splitting that into two variables?
A global counter could be used to inform the cpus that they should look for quiescent states. The cacheline would be mostly read-only, it shouldn't cause trashing.

Attached is a patch - it boots uniprocessor i386. What do you think? It should remove the hotspot from scheduler_tick entirely.

--
	Manfred


--------------080506010808040600040809
Content-Type: text/plain;
 name="patch-rcu-simple"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-rcu-simple"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 6
//  SUBLEVEL = 6
//  EXTRAVERSION = -mm4
--- 2.6/kernel/rcupdate.c	2004-05-19 19:51:17.000000000 +0200
+++ build-2.6/kernel/rcupdate.c	2004-05-20 13:22:59.000000000 +0200
@@ -55,6 +55,7 @@
 static DEFINE_PER_CPU(struct tasklet_struct, rcu_tasklet) = {NULL};
 #define RCU_tasklet(cpu) (per_cpu(rcu_tasklet, cpu))
 
+long rcu_global_grace_num ____cacheline_aligned_in_smp;
 /**
  * call_rcu - Queue an RCU update request.
  * @head: structure to be used for queueing the RCU updates.
@@ -97,6 +98,23 @@
 }
 
 /*
+ * Grace period handling:
+ * The grace period handling consists out of two steps:
+ * - A new grace period is started.
+ *   This is done by rcu_start_batch. The start is not broadcasted to
+ *   all cpus, they must pick this up from rcu_global_grace_num. All cpus are
+ *   recorded  in the rcu_ctrlblk.rcu_cpu_mask bitmap.
+ * - All cpus must go through a quiescent state.
+ *   Since the start of the grace period is not broadcasted, at least two
+ *   calls to rcu_check_quiescent_state are required:
+ *   The first call just notices that a new grace period is running. The
+ *   following calls check if there was a quiescent state since the beginning
+ *   of the grace period. If so, it updates rcu_ctrlblk.rcu_cpu_mask. If
+ *   the bitmap is empty, then the grace period is completed. 
+ *   rcu_check_quiescent_state calls rcu_start_batch to start the next grace
+ *   period.
+ */
+/*
  * Register a new batch of callbacks, and start it up if there is currently no
  * active batch and the batch to be registered has not already occurred.
  * Caller must hold the rcu_ctrlblk lock.
@@ -116,6 +134,8 @@
 	active = nohz_cpu_mask;
 	cpus_complement(active);
 	cpus_and(rcu_ctrlblk.rcu_cpu_mask, cpu_online_map, active);
+	smp_wmb();
+	rcu_global_grace_num++;
 }
 
 /*
@@ -127,18 +147,28 @@
 {
 	int cpu = smp_processor_id();
 
-	if (!cpu_isset(cpu, rcu_ctrlblk.rcu_cpu_mask))
+	if (RCU_grace_num(cpu) != rcu_global_grace_num) {
+		/* new grace period: record qsctr value. */
+		BUG_ON(RCU_last_qsctr(cpu) != RCU_QSCTR_INVALID);
+		RCU_last_qsctr(cpu) = RCU_qsctr(cpu);
+		RCU_grace_num(cpu) = rcu_global_grace_num;
+		return;
+	}
+
+	/* grace period already completed for this cpu?
+	 * last_qsctr is checked instead of the actual bitmap to avoid
+	 * cacheline trashing
+	 */
+	if (RCU_last_qsctr(cpu) == RCU_QSCTR_INVALID) {
+		/* yes. Just leave. */
 		return;
+	}
 
 	/* 
 	 * Races with local timer interrupt - in the worst case
 	 * we may miss one quiescent state of that CPU. That is
 	 * tolerable. So no need to disable interrupts.
 	 */
-	if (RCU_last_qsctr(cpu) == RCU_QSCTR_INVALID) {
-		RCU_last_qsctr(cpu) = RCU_qsctr(cpu);
-		return;
-	}
 	if (RCU_qsctr(cpu) == RCU_last_qsctr(cpu))
 		return;
 
--- 2.6/include/linux/rcupdate.h	2004-05-19 19:42:16.000000000 +0200
+++ build-2.6/include/linux/rcupdate.h	2004-05-20 12:46:02.000000000 +0200
@@ -94,16 +94,19 @@
         long            last_qsctr;	 /* value of qsctr at beginning */
                                          /* of rcu grace period */
         long  	       	batch;           /* Batch # for current RCU batch */
+        long		grace_num;       /* grace period number */
         struct list_head  nxtlist;
         struct list_head  curlist;
 };
 
 DECLARE_PER_CPU(struct rcu_data, rcu_data);
 extern struct rcu_ctrlblk rcu_ctrlblk;
+extern long rcu_global_grace_num;
 
 #define RCU_qsctr(cpu) 		(per_cpu(rcu_data, (cpu)).qsctr)
 #define RCU_last_qsctr(cpu) 	(per_cpu(rcu_data, (cpu)).last_qsctr)
 #define RCU_batch(cpu) 		(per_cpu(rcu_data, (cpu)).batch)
+#define RCU_grace_num(cpu)	(per_cpu(rcu_data, (cpu)).grace_num)
 #define RCU_nxtlist(cpu) 	(per_cpu(rcu_data, (cpu)).nxtlist)
 #define RCU_curlist(cpu) 	(per_cpu(rcu_data, (cpu)).curlist)
 
@@ -115,7 +118,8 @@
 	     rcu_batch_before(RCU_batch(cpu), rcu_ctrlblk.curbatch)) ||
 	    (list_empty(&RCU_curlist(cpu)) &&
 			 !list_empty(&RCU_nxtlist(cpu))) ||
-	    cpu_isset(cpu, rcu_ctrlblk.rcu_cpu_mask))
+	    RCU_grace_num(cpu) != rcu_global_grace_num ||
+	    RCU_last_qsctr(cpu) != RCU_QSCTR_INVALID)
 		return 1;
 	else
 		return 0;

--------------080506010808040600040809--

