Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbUDHUjp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 16:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbUDHUgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 16:36:45 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:28645 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262391AbUDHTuY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 15:50:24 -0400
Date: Thu, 8 Apr 2004 12:49:48 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Patch 11/23 - Bitmaps, Cpumasks and Nodemasks
Message-Id: <20040408124948.2e805e64.pj@sgi.com>
In-Reply-To: <20040408115050.2c67311a.pj@sgi.com>
References: <20040408115050.2c67311a.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P11.cpumask_sparc_simplify - Simplify some sparc64 cpumask loop code
        Make use of for_each_cpu_mask() macro to simplify and optimize
        a couple of sparc64 per-CPU loops.  This code change has _not_
        been tested or reviewed.  Feedback welcome.  There is non-trivial
        risk that I still don't understand the logic here.

Index: 2.6.5.bitmap/arch/sparc64/kernel/smp.c
===================================================================
--- 2.6.5.bitmap.orig/arch/sparc64/kernel/smp.c	2004-04-05 02:41:32.000000000 -0700
+++ 2.6.5.bitmap/arch/sparc64/kernel/smp.c	2004-04-08 04:18:02.000000000 -0700
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


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
