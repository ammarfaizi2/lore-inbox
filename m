Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbUBUDO4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 22:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbUBUDO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 22:14:56 -0500
Received: from gate.crashing.org ([63.228.1.57]:29868 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261493AbUBUDOu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 22:14:50 -0500
Subject: [PATCH] ppc32: rework l2 cache code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1077332936.857.2.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 21 Feb 2004 14:08:58 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch removes the code that tweaked the L1 cache when setting
up the L2 one. That was added a while ago in the intend of making
things more robust but ended up breaking earlier 750 CPU setup.

Also fix some crap in the L1 cache code that is only used for the
powermac sleep at this point.

Please apply.

Ben.

diff -urN linux-2.5/arch/ppc/kernel/l2cr.S linuxppc-2.5-benh/arch/ppc/kernel/l2cr.S
--- linux-2.5/arch/ppc/kernel/l2cr.S	2004-02-20 11:26:06.000000000 +1100
+++ linuxppc-2.5-benh/arch/ppc/kernel/l2cr.S	2004-02-21 12:30:29.000000000 +1100
@@ -130,11 +130,6 @@
 	mtspr	HID0,r4			/* Disable DPM */
 	sync
 
-	/* Flush & disable L1 */
-	mr	r5,r3
-	bl	__flush_disable_L1
-	mr	r3,r5
-
 	/* Get the current enable bit of the L2CR into r4 */
 	mfspr	r4,L2CR
 
@@ -236,7 +231,6 @@
 	sync
 
 4:
-	bl	__inval_enable_L1
 
 	/* Restore HID0[DPM] to whatever it was before */
 	sync
@@ -394,11 +388,10 @@
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
  	sync
 
-	/* Load counter to 0x1000 cache lines (128k) and
+	/* Load counter to 0x4000 cache lines (512k) and
 	 * load cache with datas
 	 */
-	lis	r3,0x0002
-//	li	r3,0x1000	/* 128kB / 32B */
+	li	r3,0x4000	/* 512kB / 32B */
 	mtctr	r3
 	li	r3, 0
 1:
@@ -409,8 +402,7 @@
 	sync
 
 	/* Now flush those cache lines */
-	lis	r3,0x0002
-//	li	r3,0x1000	/* 128kB / 32B */
+	li	r3,0x4000	/* 512kB / 32B */
 	mtctr	r3
 	li	r3, 0
 1:


