Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265640AbUBBGNW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 01:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265630AbUBBGNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 01:13:22 -0500
Received: from ozlabs.org ([203.10.76.45]:47775 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265640AbUBBGNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 01:13:20 -0500
Date: Mon, 2 Feb 2004 17:03:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: [PPC64] Remove useless argument from __ste_allocate()
Message-ID: <20040202060332.GA17234@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
	linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the current ppc64 code the function __ste_allocate() in
arch/ppc64/mm/stab.c takes a context parameter which is never used.
This patch removes it.

Index: working-2.6/arch/ppc64/kernel/stab.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/stab.c	2004-02-02 10:44:47.000000000 +1100
+++ working-2.6/arch/ppc64/kernel/stab.c	2004-02-02 14:10:56.755034224 +1100
@@ -142,8 +142,7 @@
 	return (global_entry | (castout_entry & 0x7));
 }
 
-static inline void __ste_allocate(unsigned long esid, unsigned long vsid,
-				  mm_context_t context)
+static inline void __ste_allocate(unsigned long esid, unsigned long vsid)
 {
 	unsigned char stab_entry; 
 	unsigned long *offset;
@@ -186,7 +185,7 @@
 	}
 
 	esid = GET_ESID(ea);
-	__ste_allocate(esid, vsid, context);
+	__ste_allocate(esid, vsid);
 	/* Order update */
 	asm volatile("sync":::"memory"); 
 
@@ -216,7 +215,7 @@
 	if (!IS_VALID_EA(pc) || (REGION_ID(pc) >= KERNEL_REGION_ID))
 		return;
 	vsid = get_vsid(mm->context, pc);
-	__ste_allocate(pc_esid, vsid, mm->context);
+	__ste_allocate(pc_esid, vsid);
 
 	if (pc_esid == stack_esid)
 		return;
@@ -224,7 +223,7 @@
 	if (!IS_VALID_EA(stack) || (REGION_ID(stack) >= KERNEL_REGION_ID))
 		return;
 	vsid = get_vsid(mm->context, stack);
-	__ste_allocate(stack_esid, vsid, mm->context);
+	__ste_allocate(stack_esid, vsid);
 
 	if (pc_esid == unmapped_base_esid || stack_esid == unmapped_base_esid)
 		return;
@@ -233,7 +232,7 @@
 	    (REGION_ID(unmapped_base) >= KERNEL_REGION_ID))
 		return;
 	vsid = get_vsid(mm->context, unmapped_base);
-	__ste_allocate(unmapped_base_esid, vsid, mm->context);
+	__ste_allocate(unmapped_base_esid, vsid);
 
 	/* Order update */
 	asm volatile("sync" : : : "memory");



-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
