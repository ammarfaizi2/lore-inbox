Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265127AbUGSTG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUGSTG7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 15:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265139AbUGSTG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 15:06:58 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:44493 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S265127AbUGSTGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 15:06:55 -0400
Date: Mon, 19 Jul 2004 20:06:52 +0100
From: Colin Watson <cjwatson@flatline.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Thom May <thom@clearairturbulence.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc32 support for Apple Xserve G5s
Message-ID: <20040719190652.GB2943@riva.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch makes ppc32 work on Xserve G5 systems (ppc64 support
was already there, I just backported a few bits).

  http://powerpc.no-name-yet.com/patches/xserve-g5.diff

diff -ru kernel-source-2.6.7.orig/arch/ppc/kernel/cpu_setup_power4.S kernel-source-2.6.7/arch/ppc/kernel/cpu_setup_power4.S
--- kernel-source-2.6.7.orig/arch/ppc/kernel/cpu_setup_power4.S	2004-06-16 06:19:43.000000000 +0100
+++ kernel-source-2.6.7/arch/ppc/kernel/cpu_setup_power4.S	2004-07-15 13:16:44.000000000 +0100
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
diff -ru kernel-source-2.6.7.orig/arch/ppc/kernel/cputable.c kernel-source-2.6.7/arch/ppc/kernel/cputable.c
--- kernel-source-2.6.7.orig/arch/ppc/kernel/cputable.c	2004-06-16 06:19:26.000000000 +0100
+++ kernel-source-2.6.7/arch/ppc/kernel/cputable.c	2004-07-15 13:29:54.000000000 +0100
@@ -419,6 +419,15 @@
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
diff -ru kernel-source-2.6.7.orig/arch/ppc/platforms/pmac_feature.c kernel-source-2.6.7/arch/ppc/platforms/pmac_feature.c
--- kernel-source-2.6.7.orig/arch/ppc/platforms/pmac_feature.c	2004-06-16 06:20:03.000000000 +0100
+++ kernel-source-2.6.7/arch/ppc/platforms/pmac_feature.c	2004-07-15 11:23:44.000000000 +0100
@@ -2137,6 +2137,10 @@
 		PMAC_TYPE_POWERMAC_G5,		g5_features,
 		0,
 	},
+	{       "RackMac3,1",                   "XServe G5",
+		PMAC_TYPE_POWERMAC_G5,          g5_features,
+		0,
+	},
 #endif /* CONFIG_POWER4 */
 };
 

Our system didn't have a video card, only a serial console, so I had to
apply the following to get any feedback at all. Other people in a
similar situation might find it useful. However, I've no idea why it was
disabled in the first place, so I'm not asking for this to be applied,
merely curious ...

diff -ru kernel-source-2.6.7.orig/arch/ppc/kernel/head.S kernel-source-2.6.7/arch/ppc/kernel/head.S
--- kernel-source-2.6.7.orig/arch/ppc/kernel/head.S	2004-06-16 06:19:35.000000000 +0100
+++ kernel-source-2.6.7/arch/ppc/kernel/head.S	2004-07-15 14:02:22.000000000 +0100
@@ -1617,7 +1617,7 @@
 	lis	r4,0x2000		/* set pseudo-segment reg 12 */
 	ori	r5,r4,0x0ccc
 	mtsr	12,r5
-#if 0
+#if 1
 	ori	r5,r4,0x0888		/* set pseudo-segment reg 8 */
 	mtsr	8,r5			/* (for access to serial port) */
 #endif

Thanks,

-- 
Colin Watson                                  [cjwatson@flatline.org.uk]
