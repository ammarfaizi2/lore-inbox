Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270711AbTHJVOq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 17:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270712AbTHJVOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 17:14:46 -0400
Received: from [66.212.224.118] ([66.212.224.118]:46349 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S270711AbTHJVOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 17:14:44 -0400
Date: Sun, 10 Aug 2003 17:02:55 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Dave Jones <davej@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH][2.6] Make MTRR init conform with recommended procedure
Message-ID: <Pine.LNX.4.53.0308101640060.31799@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,
	This is a patch to make the MTRR initialisation more conformant 
with what is stated in volume 3 of (10-36 Memory Cache Control). The most 
notable change is entering the no-fill cache mode before clearing the PGE 
bit in cr4. Intel also states that we should do the cache flush via the 
cr3 register shuffle. If there is a problem with the patch please don't 
hesitate to beat me vigorously with a clue-by-four.

It has been tested on a 3x Pentium 133, 8x PIII Xeon 700, 1x Celeron 550 and 32x 
PIII 500 NUMAQ (hardware courtesy of OSDL)

Index: linux-2.6.0-test3-huge_kpage/arch/i386/kernel/cpu/mtrr/generic.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test3/arch/i386/kernel/cpu/mtrr/generic.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 generic.c
--- linux-2.6.0-test3-huge_kpage/arch/i386/kernel/cpu/mtrr/generic.c	10 Aug 2003 08:41:39 -0000	1.1.1.1
+++ linux-2.6.0-test3-huge_kpage/arch/i386/kernel/cpu/mtrr/generic.c	10 Aug 2003 20:24:49 -0000
@@ -8,6 +8,7 @@
 #include <asm/msr.h>
 #include <asm/system.h>
 #include <asm/cpufeature.h>
+#include <asm/tlbflush.h>
 #include "mtrr.h"
 
 struct mtrr_state {
@@ -241,19 +242,21 @@ static void prepare_set(void)
 	   more invasive changes to the way the kernel boots  */
 	spin_lock(&set_atomicity_lock);
 
+	/*  Enter the no-fill (CD=1, NW=0) cache mode and flush caches. */
+	cr0 = read_cr0() | 0x40000000;	/* set CD flag */
+	wbinvd();
+	write_cr0(cr0);
+	wbinvd();
+
 	/*  Save value of CR4 and clear Page Global Enable (bit 7)  */
 	if ( cpu_has_pge ) {
 		cr4 = read_cr4();
 		write_cr4(cr4 & (unsigned char) ~(1 << 7));
 	}
 
-	/*  Disable and flush caches. Note that wbinvd flushes the TLBs as
-	    a side-effect  */
-	cr0 = read_cr0() | 0x40000000;
-	wbinvd();
-	write_cr0(cr0);
-	wbinvd();
-
+	/* Flush all TLBs via a mov %cr3, %reg; mov %reg, %cr3 */
+	__flush_tlb();
+	
 	/*  Save MTRR state */
 	rdmsr(MTRRdefType_MSR, deftype_lo, deftype_hi);
 
@@ -265,6 +268,7 @@ static void post_set(void)
 {
 	/*  Flush caches and TLBs  */
 	wbinvd();
+	__flush_tlb();
 
 	/* Intel (P6) standard MTRRs */
 	wrmsr(MTRRdefType_MSR, deftype_lo, deftype_hi);
