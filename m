Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbUEEF1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbUEEF1v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 01:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbUEEF1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 01:27:51 -0400
Received: from gate.crashing.org ([63.228.1.57]:18863 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262009AbUEEF1o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 01:27:44 -0400
Subject: [PATCH] ppc/ppc64: Cleanup PPC970 CPU initialization
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1083734580.29594.369.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 05 May 2004 15:23:01 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch cleans up the code used to initialize the 970 CPU, more
specifically, it adds support for the 970FX, makes sure we don't
touch registers we aren't supposed to when running in LPAR mode, and
stop blindly zeroing out HID4 and HID5, we just clear the bits we really
want clear in there and leave the rest to the firmware.

Ben.

diff -urN linux-2.5/arch/ppc/kernel/cpu_setup_power4.S linuxppc-2.5-benh/arch/ppc/kernel/cpu_setup_power4.S
--- linux-2.5/arch/ppc/kernel/cpu_setup_power4.S	2004-05-03 09:29:08.000000000 +1000
+++ linuxppc-2.5-benh/arch/ppc/kernel/cpu_setup_power4.S	2004-05-04 14:34:46.000000000 +1000
@@ -18,24 +18,37 @@
 #include <asm/offsets.h>
 #include <asm/cache.h>
 
-_GLOBAL(__power4_cpu_preinit)
+_GLOBAL(__970_cpu_preinit)
 	/*
-	 * On the PPC970, we have to turn off real-mode cache inhibit
-	 * early, before we first turn the MMU off.
+	 * Deal only with PPC970 and PPC970FX.
 	 */
 	mfspr	r0,SPRN_PVR
 	srwi	r0,r0,16
-	cmpwi	r0,0x39
+	cmpwi	cr0,r0,0x39
+	cmpwi	cr1,r0,0x3c
+	cror	4*cr0+eq,4*cr0+eq,4*cr1+eq
 	bnelr
 
+	/* Make sure HID4:rm_ci is off before MMU is turned off, that large
+	 * pages are enabled with HID4:61 and clear HID5:DCBZ_size and
+	 * HID5:DCBZ32_ill
+	 */
 	li	r0,0
+	mfspr	r11,SPRN_HID4
+	rldimi	r11,r0,40,23	/* clear bit 23 (rm_ci) */
+	rldimi	r11,r0,2,61	/* clear bit 61 (lg_pg_en) */
 	sync
-	mtspr	SPRN_HID4,r0
+	mtspr	SPRN_HID4,r11
 	isync
 	sync
-	mtspr	SPRN_HID5,r0
+	mfspr	r11,SPRN_HID5
+	rldimi	r11,r0,6,56	/* clear bits 56 & 57 (DCBZ*) */
+	sync
+	mtspr	SPRN_HID5,r11
 	isync
+	sync
 
+	/* Setup some basic HID1 features */
 	mfspr	r0,SPRN_HID1
 	li	r11,0x1200		/* enable i-fetch cacheability */
 	sldi	r11,r11,44		/* and prefetch */
@@ -43,6 +56,8 @@
 	mtspr	SPRN_HID1,r0
 	mtspr	SPRN_HID1,r0
 	isync
+
+	/* Clear HIOR */
 	li	r0,0
 	sync
 	mtspr	SPRN_HIOR,0		/* Clear interrupt prefix */
diff -urN linux-2.5/arch/ppc/kernel/head.S linuxppc-2.5-benh/arch/ppc/kernel/head.S
--- linux-2.5/arch/ppc/kernel/head.S	2004-05-03 09:29:08.000000000 +1000
+++ linuxppc-2.5-benh/arch/ppc/kernel/head.S	2004-05-04 14:34:46.000000000 +1000
@@ -153,7 +153,7 @@
  * like real mode cache inhibit or exception base
  */
 #ifdef CONFIG_POWER4
-	bl	__power4_cpu_preinit
+	bl	__970_cpu_preinit
 #endif /* CONFIG_POWER4 */
 
 #ifdef CONFIG_APUS
diff -urN linux-2.5/arch/ppc64/kernel/cpu_setup_power4.S linuxppc-2.5-benh/arch/ppc64/kernel/cpu_setup_power4.S
--- linux-2.5/arch/ppc64/kernel/cpu_setup_power4.S	2004-05-03 09:29:08.000000000 +1000
+++ linuxppc-2.5-benh/arch/ppc64/kernel/cpu_setup_power4.S	2004-05-05 14:54:35.000000000 +1000
@@ -18,31 +18,53 @@
 #include <asm/offsets.h>
 #include <asm/cache.h>
 
-_GLOBAL(__power4_cpu_preinit)
+_GLOBAL(__970_cpu_preinit)
 	/*
-	 * On the PPC970, we have to turn off real-mode cache inhibit
-	 * early, before we first turn the MMU off.
+	 * Do nothing if not running in HV mode
+	 */
+	mfmsr	r0
+	rldicl.	r0,r0,4,63
+	beqlr
+
+	/*
+	 * Deal only with PPC970 and PPC970FX.
 	 */
 	mfspr	r0,SPRN_PVR
 	srwi	r0,r0,16
-	cmpwi	r0,0x39
+	cmpwi	cr0,r0,0x39
+	cmpwi	cr1,r0,0x3c
+	cror	4*cr0+eq,4*cr0+eq,4*cr1+eq
 	bnelr
 
+	/* Make sure HID4:rm_ci is off before MMU is turned off, that large
+	 * pages are enabled with HID4:61 and clear HID5:DCBZ_size and
+	 * HID5:DCBZ32_ill
+	 */
 	li	r0,0
+	mfspr	r3,SPRN_HID4
+	rldimi	r3,r0,40,23	/* clear bit 23 (rm_ci) */
+	rldimi	r3,r0,2,61	/* clear bit 61 (lg_pg_en) */
 	sync
-	mtspr	SPRN_HID4,r0
+	mtspr	SPRN_HID4,r3
 	isync
 	sync
-	mtspr	SPRN_HID5,r0
+	mfspr	r3,SPRN_HID5
+	rldimi	r3,r0,6,56	/* clear bits 56 & 57 (DCBZ*) */
+	sync
+	mtspr	SPRN_HID5,r3
 	isync
+	sync
 
+	/* Setup some basic HID1 features */
 	mfspr	r0,SPRN_HID1
-	li	r11,0x1200		/* enable i-fetch cacheability */
-	sldi	r11,r11,44		/* and prefetch */
-	or	r0,r0,r11
+	li	r3,0x1200		/* enable i-fetch cacheability */
+	sldi	r3,r3,44		/* and prefetch */
+	or	r0,r0,r3
 	mtspr	SPRN_HID1,r0
 	mtspr	SPRN_HID1,r0
 	isync
+
+	/* Clear HIOR */
 	li	r0,0
 	sync
 	mtspr	SPRN_HIOR,0		/* Clear interrupt prefix */
diff -urN linux-2.5/arch/ppc64/kernel/head.S linuxppc-2.5-benh/arch/ppc64/kernel/head.S
--- linux-2.5/arch/ppc64/kernel/head.S	2004-05-03 09:29:08.000000000 +1000
+++ linuxppc-2.5-benh/arch/ppc64/kernel/head.S	2004-05-04 14:06:56.000000000 +1000
@@ -1469,7 +1469,7 @@
 	mr	r23,r3			/* Save phys address we are running at */
 
 	/* Setup some critical 970 SPRs before switching MMU off */
-	bl	.__power4_cpu_preinit
+	bl	.__970_cpu_preinit
 
 	li	r24,0			/* cpu # */
 


