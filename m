Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268251AbUIJGUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268251AbUIJGUu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 02:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268312AbUIJGUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 02:20:50 -0400
Received: from gate.crashing.org ([63.228.1.57]:21711 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268251AbUIJGUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 02:20:47 -0400
Subject: [PATCH] ppc32: Fix boot with ppc970fx CPU
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1094797176.2664.121.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 10 Sep 2004 16:19:37 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes boot on machines with a 970FX CPU, for PPC 32
bits kernels, please apply.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

===== arch/ppc/kernel/cputable.c 1.26 vs edited =====
--- 1.26/arch/ppc/kernel/cputable.c	2004-08-25 01:30:14 +10:00
+++ edited/arch/ppc/kernel/cputable.c	2004-09-10 13:24:08 +10:00
@@ -445,6 +445,15 @@
 	128, 128,
 	__setup_cpu_ppc970
     },
+    {	/* PPC970FX */
+	0xffff0000, 0x003c0000, "PPC970FX",
+	CPU_FTR_COMMON |
+	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE |
+	CPU_FTR_ALTIVEC_COMP | CPU_FTR_CAN_NAP,
+	COMMON_PPC | PPC_FEATURE_64 | PPC_FEATURE_ALTIVEC_COMP,
+	128, 128,
+	__setup_cpu_ppc970
+    },
 #endif /* CONFIG_POWER4 */
 #ifdef CONFIG_8xx
     {	/* 8xx */
===== arch/ppc/kernel/cpu_setup_power4.S 1.2 vs edited =====
--- 1.2/arch/ppc/kernel/cpu_setup_power4.S	2004-05-04 14:34:46 +10:00
+++ edited/arch/ppc/kernel/cpu_setup_power4.S	2004-09-10 13:24:55 +10:00
@@ -112,7 +112,9 @@
 	/* We only deal with 970 for now */
 	mfspr	r0,SPRN_PVR
 	srwi	r0,r0,16
-	cmpwi	r0,0x39
+	cmpwi	cr0,r0,0x39
+	cmpwi	cr1,r0,0x3c
+	cror	4*cr0+eq,4*cr0+eq,4*cr1+eq
 	bne	1f
 
 	/* Save HID0,1,4 and 5 */
@@ -144,7 +146,9 @@
 	/* We only deal with 970 for now */
 	mfspr	r0,SPRN_PVR
 	srwi	r0,r0,16
-	cmpwi	r0,0x39
+	cmpwi	cr0,r0,0x39
+	cmpwi	cr1,r0,0x3c
+	cror	4*cr0+eq,4*cr0+eq,4*cr1+eq
 	bne	1f
 
 	/* Clear interrupt prefix */


