Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269840AbUJWBuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269840AbUJWBuN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 21:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269347AbUJWBnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 21:43:00 -0400
Received: from gate.crashing.org ([63.228.1.57]:40892 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269805AbUJWBlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 21:41:09 -0400
Subject: [PATCH] ppc64: Fix pSeries secondary CPU setup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1098495585.6071.126.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 23 Oct 2004 11:39:45 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch fixes the setup of the secondary CPU(s) on pSeries,
on non-LPAR platforms, especially with 970 CPUs, we need to copy
some of the HID registers from CPU0 to the other ones as soon as
they reach the early asm code. The PowerMac SMP entry did it
already, but not the pSeries one.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


Index: linux-maple/arch/ppc64/kernel/smp.c
===================================================================
--- linux-maple.orig/arch/ppc64/kernel/smp.c	2004-10-19 13:37:56.000000000 +1000
+++ linux-maple/arch/ppc64/kernel/smp.c	2004-10-19 17:19:36.195512728 +1000
@@ -833,9 +833,6 @@
 
 	max_cpus = smp_ops->probe();
  
-	/* Backup CPU 0 state if necessary */
-	__save_cpu_setup();
-
 	smp_space_timers(max_cpus);
 
 	for_each_cpu(cpu)
Index: linux-maple/arch/ppc64/kernel/head.S
===================================================================
--- linux-maple.orig/arch/ppc64/kernel/head.S	2004-10-19 13:37:40.000000000 +1000
+++ linux-maple/arch/ppc64/kernel/head.S	2004-10-19 17:18:42.776512880 +1000
@@ -1195,18 +1195,20 @@
  * At entry, r3 = this processor's number (in Linux terms, not hardware).
  */
 _GLOBAL(pseries_secondary_smp_init)
+	mr	r24,r3
+	
 	/* turn on 64-bit mode */
 	bl	.enable_64b_mode
 	isync
 
-	/* Set up a paca value for this processor. */
-	LOADADDR(r24, paca) 		/* Get base vaddr of paca array	 */
-	mulli	r13,r3,PACA_SIZE	/* Calculate vaddr of right paca */
-	add	r13,r13,r24		/* for this processor.		 */
+	/* Copy some CPU settings from CPU 0 */
+	bl	.__restore_cpu_setup
 
+	/* Set up a paca value for this processor. */
+	LOADADDR(r5, paca) 		/* Get base vaddr of paca array	 */
+	mulli	r13,r24,PACA_SIZE	/* Calculate vaddr of right paca */
+	add	r13,r13,r5		/* for this processor.		 */
 	mtspr	SPRG3,r13		/* Save vaddr of paca in SPRG3	 */
-	mr	r24,r3			/* __secondary_start needs cpu#	 */
-
 1:
 	HMT_LOW
 	lbz	r23,PACAPROCSTART(r13)	/* Test if this processor should */
@@ -1886,19 +1888,6 @@
 91:
 #endif
 
-#ifdef CONFIG_SMP
-	/* All secondary cpus are now spinning on a common
-	 * spinloop, release them all now so they can start
-	 * to spin on their individual paca spinloops.
-	 * For non SMP kernels, the secondary cpus never
-	 * get out of the common spinloop.
-	 */
-	li	r3,1
-	LOADADDR(r5,__secondary_hold_spinloop)
-	tophys(r4,r5)
-	std	r3,0(r4)
-#endif
-
 	/* The following gets the stack and TOC set up with the regs */
 	/* pointing to the real addr of the kernel stack.  This is   */
 	/* all done to support the C function call below which sets  */
@@ -1913,7 +1902,7 @@
 	li	r0,0
 	stdu	r0,-STACK_FRAME_OVERHEAD(r1)
 
-		/* set up the TOC (physical address) */
+	/* set up the TOC (physical address) */
 	LOADADDR(r2,__toc_start)
 	addi	r2,r2,0x4000
 	addi	r2,r2,0x4000
@@ -1926,6 +1915,25 @@
 	mr	r5,r26
 	bl	.identify_cpu
 
+	/* Save some low level config HIDs of CPU0 to be copied to
+	 * other CPUs later on, or used for suspend/resume
+	 */
+	bl	.__save_cpu_setup
+	sync
+
+#ifdef CONFIG_SMP
+	/* All secondary cpus are now spinning on a common
+	 * spinloop, release them all now so they can start
+	 * to spin on their individual paca spinloops.
+	 * For non SMP kernels, the secondary cpus never
+	 * get out of the common spinloop.
+	 */
+	li	r3,1
+	LOADADDR(r5,__secondary_hold_spinloop)
+	tophys(r4,r5)
+	std	r3,0(r4)
+#endif
+
 	/* Setup a valid physical PACA pointer in SPRG3 for early_setup
 	 * note that boot_cpuid can always be 0 nowadays since there is
 	 * nowhere it can be initialized differently before we reach this
Index: linux-maple/arch/ppc64/kernel/cpu_setup_power4.S
===================================================================
--- linux-maple.orig/arch/ppc64/kernel/cpu_setup_power4.S	2004-10-19 13:37:20.000000000 +1000
+++ linux-maple/arch/ppc64/kernel/cpu_setup_power4.S	2004-10-19 17:37:11.624484848 +1000
@@ -156,6 +156,15 @@
 	cror	4*cr0+eq,4*cr0+eq,4*cr1+eq
 	bne	1f
 
+	/* Before accessing memory, we make sure rm_ci is clear */
+	li	r0,0
+	mfspr	r3,SPRN_HID4
+	rldimi	r3,r0,40,23	/* clear bit 23 (rm_ci) */
+	sync
+	mtspr	SPRN_HID4,r3
+	isync
+	sync
+
 	/* Clear interrupt prefix */
 	li	r0,0
 	sync

-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

