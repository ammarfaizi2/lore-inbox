Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262235AbVAEDzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbVAEDzp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 22:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbVAEDzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 22:55:44 -0500
Received: from ozlabs.org ([203.10.76.45]:57794 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262235AbVAEDzW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 22:55:22 -0500
Date: Wed, 5 Jan 2005 14:54:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       Maynard Johnson <mpjohn@us.ibm.com>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: [PPC64] Add performance monitor register information to processor.h
Message-ID: <20050105035428.GC21259@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
	Paul Mackerras <paulus@samba.org>,
	Maynard Johnson <mpjohn@us.ibm.com>, linuxppc64-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply:

Most special purpose registers on the ppc64 have both the SPR number,
and the various fields within the register defined in
asm-ppc64/processor.h.  So far that's not true for the performance
counter control registers, MMCR0 and MMCRA.  They have the SPR numbers
defined, but the internal fields are defined in the oprofile code and
(just a few) in traps.c where they're actually used.

This patch moves all the MMCR0 and MMCRA definitions, plus the MSR
performance monitor bit, MSR_PMM, into processor.h.

Index: working-2.6/include/asm-ppc64/processor.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/processor.h	2005-01-05 14:46:10.557311664 +1100
+++ working-2.6/include/asm-ppc64/processor.h	2005-01-05 14:46:12.551274880 +1100
@@ -44,6 +44,7 @@
 #define MSR_DR_LG	4 		/* Data Relocate */
 #define MSR_PE_LG	3		/* Protection Enable */
 #define MSR_PX_LG	2		/* Protection Exclusive Mode */
+#define MSR_PMM_LG	2		/* Performance monitor */
 #define MSR_RI_LG	1		/* Recoverable Exception */
 #define MSR_LE_LG	0 		/* Little Endian */
 
@@ -76,6 +77,7 @@
 #define MSR_DR		__MASK(MSR_DR_LG)	/* Data Relocate */
 #define MSR_PE		__MASK(MSR_PE_LG)	/* Protection Enable */
 #define MSR_PX		__MASK(MSR_PX_LG)	/* Protection Exclusive Mode */
+#define MSR_PMM		__MASK(MSR_PMM_LG)	/* Performance monitor */
 #define MSR_RI		__MASK(MSR_RI_LG)	/* Recoverable Exception */
 #define MSR_LE		__MASK(MSR_LE_LG)	/* Little Endian */
 
@@ -305,6 +307,9 @@
 #define SPRN_SIAR	780
 #define SPRN_SDAR	781
 #define SPRN_MMCRA	786
+#define   MMCRA_SIHV	0x10000000UL /* state of MSR HV when SIAR set */
+#define   MMCRA_SIPR	0x08000000UL /* state of MSR PR when SIAR set */
+#define   MMCRA_SAMPLE_ENABLE 0x00000001UL /* enable sampling */
 #define SPRN_PMC1	787
 #define SPRN_PMC2	788
 #define SPRN_PMC3	789
@@ -314,6 +319,26 @@
 #define SPRN_PMC7	793
 #define SPRN_PMC8	794
 #define SPRN_MMCR0	795
+#define   MMCR0_FC	0x80000000UL /* freeze counters. set to 1 on a perfmon exception */
+#define   MMCR0_FCS	0x40000000UL /* freeze in supervisor state */
+#define   MMCR0_KERNEL_DISABLE MMCR0_FCS
+#define   MMCR0_FCP	0x20000000UL /* freeze in problem state */
+#define   MMCR0_PROBLEM_DISABLE MMCR0_FCP
+#define   MMCR0_FCM1	0x10000000UL /* freeze counters while MSR mark = 1 */
+#define   MMCR0_FCM0	0x08000000UL /* freeze counters while MSR mark = 0 */
+#define   MMCR0_PMXE	0x04000000UL /* performance monitor exception enable */
+#define   MMCR0_FCECE	0x02000000UL /* freeze counters on enabled condition or event */
+/* time base exception enable */
+#define   MMCR0_TBEE	0x00400000UL /* time base exception enable */
+#define   MMCR0_PMC1INTCONTROL	0x00008000UL /* PMC1 count enable*/
+#define   MMCR0_PMCNINTCONTROL	0x00004000UL /* PMCn count enable*/
+#define   MMCR0_TRIGGER	0x00002000UL /* TRIGGER enable */
+#define   MMCR0_PMAO	0x00000080UL /* performance monitor alert has occurred, set to 0 after handling exception */
+#define   MMCR0_SHRFC	0x00000040UL /* SHRre freeze conditions between threads */
+#define   MMCR0_FCTI	0x00000008UL /* freeze counters in tags inactive mode */
+#define   MMCR0_FCTA	0x00000004UL /* freeze counters in tags active mode */
+#define   MMCR0_FCWAIT	0x00000002UL /* freeze counter in WAIT state */
+#define   MMCR0_FCHV	0x00000001UL /* freeze conditions in hypervisor mode */
 #define SPRN_MMCR1	798
 
 /* Short-hand versions for a number of the above SPRNs */
Index: working-2.6/arch/ppc64/oprofile/op_impl.h
===================================================================
--- working-2.6.orig/arch/ppc64/oprofile/op_impl.h	2005-01-05 14:46:10.558311512 +1100
+++ working-2.6/arch/ppc64/oprofile/op_impl.h	2005-01-05 14:46:12.551274880 +1100
@@ -14,44 +14,6 @@
 
 #define OP_MAX_COUNTER 8
 
-#define MSR_PMM		(1UL << (63 - 61))
-
-/* freeze counters. set to 1 on a perfmon exception */
-#define MMCR0_FC	(1UL << (31 - 0))
-
-/* freeze in supervisor state */
-#define MMCR0_KERNEL_DISABLE (1UL << (31 - 1))
-
-/* freeze in problem state */
-#define MMCR0_PROBLEM_DISABLE (1UL << (31 - 2))
-
-/* freeze counters while MSR mark = 1 */
-#define MMCR0_FCM1	(1UL << (31 - 3))
-
-/* performance monitor exception enable */
-#define MMCR0_PMXE	(1UL << (31 - 5))
-
-/* freeze counters on enabled condition or event */
-#define MMCR0_FCECE	(1UL << (31 - 6))
-
-/* PMC1 count enable*/
-#define MMCR0_PMC1INTCONTROL	(1UL << (31 - 16))
-
-/* PMCn count enable*/
-#define MMCR0_PMCNINTCONTROL	(1UL << (31 - 17))
-
-/* performance monitor alert has occurred, set to 0 after handling exception */
-#define MMCR0_PMAO	(1UL << (31 - 24))
-
-/* state of MSR HV when SIAR set */
-#define MMCRA_SIHV	(1UL << (63 - 35))
-
-/* state of MSR PR when SIAR set */
-#define MMCRA_SIPR	(1UL << (63 - 36))
-
-/* enable sampling */
-#define MMCRA_SAMPLE_ENABLE	(1UL << (63 - 63))
-
 /* Per-counter configuration as set via oprofilefs.  */
 struct op_counter_config {
 	unsigned long valid;
Index: working-2.6/arch/ppc64/kernel/traps.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/traps.c	2005-01-05 14:46:10.558311512 +1100
+++ working-2.6/arch/ppc64/kernel/traps.c	2005-01-05 14:46:12.552274728 +1100
@@ -545,9 +545,6 @@
 }
 
 /* Ensure exceptions are disabled */
-#define MMCR0_PMXE      (1UL << (31 - 5))
-#define MMCR0_PMAO      (1UL << (31 - 24))
-
 static void dummy_perf(struct pt_regs *regs)
 {
 	unsigned int mmcr0 = mfspr(SPRN_MMCR0);


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist.  NOT _the_ _other_ _way_
				| _around_!
http://www.ozlabs.org/people/dgibson
