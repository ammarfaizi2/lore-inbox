Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbUC2Noj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 08:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262518AbUC2NnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 08:43:06 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:32954 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262885AbUC2MQ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 07:16:58 -0500
Date: Mon, 29 Mar 2004 04:15:50 -0800
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: mbligh@aracnet.com, akpm@osdl.org, wli@holomorphy.com, haveblue@us.ibm.com,
       colpatch@us.ibm.com
Subject: [PATCH] mask ADT: simplify sparc64 cpumask loops [17/22]
Message-Id: <20040329041550.37705733.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch_17_of_22 - Simplify some sparc64 cpumask loop code
	Make use of for_each_cpu_mask() macro to simplify and optimize
	a couple of sparc64 per-CPU loops.  This code change has _not_
	been tested or reviewed.  Feedback welcome.  There is non-trivial
	risk that I still don't understand the logic here.

diffstat Patch_17_of_22:
 smp.c |   66 ++++++++++++++++++++++++------------------------------------------
 1 files changed, 24 insertions(+), 42 deletions(-)

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1723  -> 1.1724 
#	arch/sparc64/kernel/smp.c	1.66    -> 1.67   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/03/29	pj@sgi.com	1.1724
# Make use of for_each_cpu_mask() macro to simplify and optimize
# a couple of sparc64 per-CPU loops.  This code change has _not_
# been tested or reviewed.  Feedback welcome.  There is non-trivial
# risk that I still don't understand the logic here.
# --------------------------------------------
#
diff -Nru a/arch/sparc64/kernel/smp.c b/arch/sparc64/kernel/smp.c
--- a/arch/sparc64/kernel/smp.c	Mon Mar 29 01:04:01 2004
+++ b/arch/sparc64/kernel/smp.c	Mon Mar 29 01:04:01 2004
@@ -409,14 +409,8 @@
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
@@ -459,25 +453,19 @@
 
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
 
@@ -510,7 +498,6 @@
 			printk("CPU[%d]: mondo stuckage result[%016lx]\n",
 			       smp_processor_id(), dispatch_stat);
 		} else {
-			cpumask_t work_mask = mask;
 			int i, this_busy_nack = 0;
 
 			/* Delay some random time with interrupts enabled
@@ -521,22 +508,17 @@
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


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
