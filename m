Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbUB0OXb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 09:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbUB0OXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 09:23:31 -0500
Received: from dp.samba.org ([66.70.73.150]:51917 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261697AbUB0OX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 09:23:27 -0500
Date: Sat, 28 Feb 2004 01:22:26 +1100
From: Anton Blanchard <anton@samba.org>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] fix ppc64 kernel access of user pages
Message-ID: <20040227142225.GG5801@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Set the ks bit on userspace segments otherwise the kernel can read/write 
into userspace mprotected pages.

--

diff -Nru a/arch/ppc64/kernel/head.S b/arch/ppc64/kernel/head.S
--- a/arch/ppc64/kernel/head.S	Fri Feb 27 22:59:30 2004
+++ b/arch/ppc64/kernel/head.S	Fri Feb 27 22:59:30 2004
@@ -826,7 +826,14 @@
 _GLOBAL(do_hash_page_ISI)
 	li	r4,0
 _GLOBAL(do_hash_page_DSI)
-	rlwimi	r4,r23,32-13,30,30	/* Insert MSR_PR as _PAGE_USER */
+	/*
+	 * We need to set the _PAGE_USER bit if MSR_PR is set or if we are
+	 * accessing a userspace segment (even from the kernel). We assume
+	 * kernel addresses always have the high bit set.
+	 */
+	rotldi	r0,r3,15		/* Move high bit into MSR_PR position */
+	orc	r0,r23,r0
+	rlwimi	r4,r0,32-13,30,30	/* Insert into _PAGE_USER */
 	ori	r4,r4,1			/* add _PAGE_PRESENT */
 
 	mflr	r21			/* Save LR in r21 */
diff -Nru a/arch/ppc64/kernel/stab.c b/arch/ppc64/kernel/stab.c
--- a/arch/ppc64/kernel/stab.c	Fri Feb 27 22:59:30 2004
+++ b/arch/ppc64/kernel/stab.c	Fri Feb 27 22:59:30 2004
@@ -73,6 +73,8 @@
 	unsigned long entry, group, old_esid, castout_entry, i;
 	unsigned int global_entry;
 	STE *ste, *castout_ste;
+	unsigned long kernel_segment = (REGION_ID(esid << SID_SHIFT) != 
+					USER_REGION_ID);
 
 	/* Search the primary group first. */
 	global_entry = (esid & 0x1f) << 3;
@@ -85,6 +87,8 @@
 				ste->dw1.dw1.vsid = vsid;
 				ste->dw0.dw0.esid = esid;
 				ste->dw0.dw0.kp = 1;
+				if (!kernel_segment)
+					ste->dw0.dw0.ks = 1;
 				asm volatile("eieio":::"memory");
 				ste->dw0.dw0.v = 1;
 				return (global_entry | entry);
@@ -131,6 +135,8 @@
 	old_esid = castout_ste->dw0.dw0.esid;
 	castout_ste->dw0.dw0.esid = esid;
 	castout_ste->dw0.dw0.kp = 1;
+	if (!kernel_segment)
+		castout_ste->dw0.dw0.ks = 1;
 	asm volatile("eieio" : : : "memory");   /* Order update */
 	castout_ste->dw0.dw0.v  = 1;
 	asm volatile("slbie  %0" : : "r" (old_esid << SID_SHIFT)); 
@@ -340,6 +346,8 @@
 		vsid_data.data.l = 1;
 	if (kernel_segment)
 		vsid_data.data.c = 1;
+	else
+		vsid_data.data.ks = 1;
 
 	esid_data.word0 = 0;
 	esid_data.data.esid = esid;
