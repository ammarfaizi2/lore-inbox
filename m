Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264929AbUHHC3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264929AbUHHC3u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 22:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264937AbUHHC3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 22:29:50 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:25078 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S264929AbUHHC3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 22:29:47 -0400
Date: Sat, 7 Aug 2004 22:33:37 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Philippe Elie <phil.el@wanadoo.fr>, Andrew Morton <akpm@osdl.org>,
       Luca Rossato <l.rossato@tiscali.it>
Subject: [PATCH][2.6] OProfile/XScale fixes for PXA270/XScale2
Message-ID: <Pine.LNX.4.58.0408072017000.19619@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The incorrect mask was being used when writing back to PMNC
write-only-zero bits as well as only ticking the CCNT every 64 processor
cycles. Tested on IOP331 and PXA270, i'm still looking for XScale1 users...

Andrew please apply.

Signed-off-by: Luca Rossato <l.rossato@tiscali.it>
Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

Index: linux-2.6.8-rc3/arch/arm/oprofile/op_model_xscale.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc3/arch/arm/oprofile/op_model_xscale.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 op_model_xscale.c
--- linux-2.6.8-rc3/arch/arm/oprofile/op_model_xscale.c	4 Aug 2004 02:22:30 -0000	1.1.1.1
+++ linux-2.6.8-rc3/arch/arm/oprofile/op_model_xscale.c	8 Aug 2004 00:30:03 -0000
@@ -30,6 +30,7 @@
 #define PMN_RESET	0x002	/* Reset event counters */
 #define	CCNT_RESET	0x004	/* Reset clock counter */
 #define	PMU_RESET	(CCNT_RESET | PMN_RESET)
+#define PMU_CNT64	0x008	/* Make CCNT count every 64th cycle */

 /* TODO do runtime detection */
 #ifdef CONFIG_ARCH_IOP310
@@ -125,12 +126,15 @@ static struct pmu_type *pmu;

 static void write_pmnc(u32 val)
 {
-	/* upper 4bits and 7, 11 are write-as-0 */
-	val &= 0xffff77f;
-	if (pmu->id == PMU_XSC1)
+	if (pmu->id == PMU_XSC1) {
+		/* upper 4bits and 7, 11 are write-as-0 */
+		val &= 0xffff77f;
 		__asm__ __volatile__ ("mcr p14, 0, %0, c0, c0, 0" : : "r" (val));
-	else
+	} else {
+		/* bits 4-23 are write-as-0, 24-31 are write ignored */
+		val &= 0xf;
 		__asm__ __volatile__ ("mcr p14, 0, %0, c0, c1, 0" : : "r" (val));
+	}
 }

 static u32 read_pmnc(void)
@@ -139,8 +143,11 @@ static u32 read_pmnc(void)

 	if (pmu->id == PMU_XSC1)
 		__asm__ __volatile__ ("mrc p14, 0, %0, c0, c0, 0" : "=r" (val));
-	else
+	else {
 		__asm__ __volatile__ ("mrc p14, 0, %0, c0, c1, 0" : "=r" (val));
+		/* bits 1-2 and 4-23 are read-unpredictable */
+		val &= 0xff000009;
+	}

 	return val;
 }
@@ -386,8 +393,10 @@ static int xscale_pmu_start(void)

 	if (pmu->id == PMU_XSC1)
 		pmnc |= pmu->int_enable;
-	else
+	else {
 		__asm__ __volatile__ ("mcr p14, 0, %0, c4, c1, 0" : : "r" (pmu->int_enable));
+		pmnc &= ~PMU_CNT64;
+	}

 	pmnc |= PMU_ENABLE;
 	write_pmnc(pmnc);
