Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbUCJFwQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 00:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262167AbUCJFwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 00:52:16 -0500
Received: from dp.samba.org ([66.70.73.150]:64414 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262192AbUCJFwJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 00:52:09 -0500
Date: Wed, 10 Mar 2004 16:50:28 +1100
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org
Subject: [PATCH] ppc64 POWER3 segment table fix
Message-ID: <20040310055028.GK13007@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The ppc64 fix last week (enforcing permissions on the kernel when
accessing userspace pages) uncovered a bug on POWER3/RS64. We werent
zeroing the segment table entry before overwriting it and it was possible
for the ks bit to be set on a kernel segment.

The VSID mask was also changed to match reality (we only use 13 bits).

Anton

===== arch/ppc64/kernel/head.S 1.48 vs edited =====
--- 1.48/arch/ppc64/kernel/head.S	Sat Feb 28 09:59:30 2004
+++ edited/arch/ppc64/kernel/head.S	Mon Mar  8 10:08:16 2004
@@ -904,12 +904,13 @@
 
 	/* (((ea >> 28) & 0x1fff) << 15) | (ea >> 60) */
 	mfspr	r21,DAR
-	rldicl  r20,r21,36,32   /* Permits a full 32b of ESID */
-	rldicr  r20,r20,15,48
-	rldicl  r21,r21,4,60
-	or      r20,r20,r21
+	rldicl	r20,r21,36,51
+	sldi	r20,r20,15
+	srdi	r21,r21,60
+	or	r20,r20,r21
 
-	li      r21,9           /* VSID_RANDOMIZER */
+	/* VSID_RANDOMIZER */
+	li      r21,9
 	sldi    r21,r21,32
 	oris    r21,r21,58231
 	ori     r21,r21,39831
@@ -933,11 +934,11 @@
 	rldicl  r23,r23,57,63
 	cmpwi   r23,0
 	bne     2f
-	ld      r23,8(r21)      /* Get the current vsid part of the ste */
+	li	r23,0
 	rldimi  r23,r20,12,0    /* Insert the new vsid value            */
 	std     r23,8(r21)      /* Put new entry back into the stab     */
 	eieio                  /* Order vsid update                    */
-	ld      r23,0(r21)      /* Get the esid part of the ste         */
+	li	r23,0
 	mfspr	r20,DAR        /* Get the new esid                     */
 	rldicl  r20,r20,36,28  /* Permits a full 36b of ESID           */
 	rldimi  r23,r20,28,0    /* Insert the new esid value            */
@@ -971,13 +972,13 @@
 	std     r23,0(r21)
 	sync
 
-	ld      r23,8(r21)
+	li	r23,0
 	rldimi  r23,r20,12,0
 	std     r23,8(r21)
 	eieio
 
-	ld      r23,0(r21)      /* Get the esid part of the ste         */
-	mr      r22,r23
+	ld	r22,0(r21)	/* Get the esid part of the ste         */
+	li	r23,0
 	mfspr	r20,DAR         /* Get the new esid                     */
 	rldicl  r20,r20,36,28   /* Permits a full 32b of ESID           */
 	rldimi  r23,r20,28,0    /* Insert the new esid value            */
===== include/asm-ppc64/mmu_context.h 1.13 vs edited =====
--- 1.13/include/asm-ppc64/mmu_context.h	Sun Mar  7 18:05:29 2004
+++ edited/include/asm-ppc64/mmu_context.h	Mon Mar  8 10:08:16 2004
@@ -186,7 +186,7 @@
 {
 	unsigned long ordinal, vsid;
 	
-	ordinal = (((ea >> 28) & 0x1fffff) * LAST_USER_CONTEXT) | (ea >> 60);
+	ordinal = (((ea >> 28) & 0x1fff) * LAST_USER_CONTEXT) | (ea >> 60);
 	vsid = (ordinal * VSID_RANDOMIZER) & VSID_MASK;
 
 	ifppcdebug(PPCDBG_HTABSTRESS) {
@@ -209,7 +209,7 @@
 {
 	unsigned long ordinal, vsid;
 
-	ordinal = (((ea >> 28) & 0x1fffff) * LAST_USER_CONTEXT) | context;
+	ordinal = (((ea >> 28) & 0x1fff) * LAST_USER_CONTEXT) | context;
 	vsid = (ordinal * VSID_RANDOMIZER) & VSID_MASK;
 
 	ifppcdebug(PPCDBG_HTABSTRESS) {
diff -p -purNX /suse/olh/kernel/kernel_exclude.txt /dev/shm/linuxppc64-2.5/arch/ppc64/kernel/stab.c linuxppc64-2.5/arch/ppc64/kernel/stab.c
--- /dev/shm/linuxppc64-2.5/arch/ppc64/kernel/stab.c	2004-03-03 05:23:10.000000000 +0100
+++ linuxppc64-2.5/arch/ppc64/kernel/stab.c	2004-03-04 10:06:53.000000000 +0100
@@ -88,6 +88,8 @@ static int make_ste(unsigned long stab, 
 	for (group = 0; group < 2; group++) {
 		for (entry = 0; entry < 8; entry++, ste++) {
 			if (!(ste->dw0.dw0.v)) {
+				ste->dw0.dword0 = 0;
+				ste->dw1.dword1 = 0;
 				ste->dw1.dw1.vsid = vsid;
 				ste->dw0.dw0.esid = esid;
 				ste->dw0.dw0.kp = 1;
@@ -135,6 +137,9 @@ static int make_ste(unsigned long stab, 
 
 	castout_ste->dw0.dw0.v = 0;
 	asm volatile("sync" : : : "memory");    /* Order update */
+
+	castout_ste->dw0.dword0 = 0;
+	castout_ste->dw1.dword1 = 0;
 	castout_ste->dw1.dw1.vsid = vsid;
 	old_esid = castout_ste->dw0.dw0.esid;
 	castout_ste->dw0.dw0.esid = esid;
