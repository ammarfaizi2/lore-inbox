Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266465AbUHSBTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266465AbUHSBTM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 21:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267777AbUHSBTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 21:19:11 -0400
Received: from ozlabs.org ([203.10.76.45]:42885 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266465AbUHSBTF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 21:19:05 -0400
Date: Thu, 19 Aug 2004 11:08:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       linux-kernel@vger.kernel.org
Subject: [PPC64] Bolted SLB entry for iSeries
Message-ID: <20040819010838.GC13672@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply.

Tested, at least basically, on Power4 iSeries with shared processors,
on Power4 pSeries and RS64 (non-SLB) iSeries machines.

On pSeries SLB machines we "bolt" an SLB entry for the first segment
of the vmalloc() area into the SLB, to reduce the SLB miss rate.  This
caused problems, so was disabled, on iSeries because the bolted entry
was not restored properly on shared processor switch.  This patch adds
information about the bolted vmalloc segment to the lpar map, which
should be restored on shared processor switch.

Index: working-2.6/arch/ppc64/mm/slb.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/slb.c	2004-08-09 09:51:38.000000000 +1000
+++ working-2.6/arch/ppc64/mm/slb.c	2004-08-19 11:15:01.303548888 +1000
@@ -36,7 +36,6 @@
 
 static void slb_add_bolted(void)
 {
-#ifndef CONFIG_PPC_ISERIES
 	WARN_ON(!irqs_disabled());
 
 	/* If you change this make sure you change SLB_NUM_BOLTED
@@ -49,7 +48,6 @@
 		    SLB_VSID_KERNEL, 1);
 
 	asm volatile("isync":::"memory");
-#endif
 }
 
 /* Flush all user entries from the segment table of the current processor. */
Index: working-2.6/arch/ppc64/kernel/head.S
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/head.S	2004-08-09 09:51:38.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/head.S	2004-08-19 11:15:01.310547824 +1000
@@ -580,7 +580,7 @@
 	 * VSID generation algorithm.  See include/asm/mmu_context.h.
 	 */
 
-	.llong	1		/* # ESIDs to be mapped by hypervisor	 */
+	.llong	2		/* # ESIDs to be mapped by hypervisor	 */
 	.llong	1		/* # memory ranges to be mapped by hypervisor */
 	.llong	STAB0_PAGE	/* Page # of segment table within load area	*/
 	.llong	0		/* Reserved */
@@ -588,8 +588,12 @@
 	.llong	0		/* Reserved */
 	.llong	0		/* Reserved */
 	.llong	0		/* Reserved */
-	.llong	0x0c00000000	/* ESID to map (Kernel at EA = 0xC000000000000000) */
-	.llong	0x06a99b4b14	/* VSID to map (Kernel at VA = 0x6a99b4b140000000) */
+	.llong	0xc00000000	/* KERNELBASE ESID */
+	.llong	0x6a99b4b14	/* KERNELBASE VSID */
+	/* We have to list the bolted VMALLOC segment here, too, so that it
+	 * will be restored on shared processor switch */
+	.llong	0xd00000000	/* VMALLOCBASE ESID */
+	.llong	0x08d12e6ab	/* VMALLOCBASE VSID */
 	.llong	8192		/* # pages to map (32 MB) */
 	.llong	0		/* Offset from start of loadarea to start of map */
 	.llong	0x0006a99b4b140000	/* VPN of first page to map */


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
