Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbUB0HJA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 02:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbUB0HJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 02:09:00 -0500
Received: from gate.crashing.org ([63.228.1.57]:17850 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261755AbUB0HIv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 02:08:51 -0500
Subject: [PATCH] ppc64: fix a bug in iSeries MMU hash management
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1077865213.22232.211.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 27 Feb 2004 18:00:13 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

iSeries HyperVisor is doing some evilery when inserting PTEs
that I didn't properly account for when rewriting that code,
causing iSeries box to blow up regulary.

Here's a fix.

===== arch/ppc64/kernel/pSeries_htab.c 1.11 vs edited =====
--- 1.11/arch/ppc64/kernel/pSeries_htab.c	Mon Jan 19 17:28:25 2004
+++ edited/arch/ppc64/kernel/pSeries_htab.c	Fri Feb 27 17:05:05 2004
@@ -103,7 +103,7 @@
 
 	__asm__ __volatile__ ("ptesync" : : : "memory");
 
-	return i;
+	return i | (secondary << 3);
 }
 
 static long pSeries_hpte_remove(unsigned long hpte_group)
===== arch/ppc64/kernel/pSeries_lpar.c 1.29 vs edited =====
--- 1.29/arch/ppc64/kernel/pSeries_lpar.c	Mon Feb 16 18:30:46 2004
+++ edited/arch/ppc64/kernel/pSeries_lpar.c	Fri Feb 27 17:08:28 2004
@@ -369,7 +369,10 @@
 	if (lpar_rc != H_Success)
 		return -2;
 
-	return slot;
+	/* Because of iSeries, we have to pass down the secondary
+	 * bucket bit here as well
+	 */
+	return (slot & 7) | (secondary << 3);
 }
 
 static spinlock_t pSeries_lpar_tlbie_lock = SPIN_LOCK_UNLOCKED;
===== arch/ppc64/mm/hash_low.S 1.3 vs edited =====
--- 1.3/arch/ppc64/mm/hash_low.S	Thu Feb 12 15:32:56 2004
+++ edited/arch/ppc64/mm/hash_low.S	Fri Feb 27 17:08:49 2004
@@ -176,7 +176,6 @@
 	beq-	htab_pte_insert_failure
 
 	/* Now try secondary slot */
-	ori	r30,r30,_PAGE_SECONDARY
 	
 	/* page number in r5 */
 	rldicl	r5,r31,64-PTE_SHIFT,PTE_SHIFT
@@ -215,8 +214,8 @@
 	b	htab_insert_pte	
 
 htab_pte_insert_ok:
-	/* Insert slot number in PTE */
-	rldimi	r30,r3,12,63-14
+	/* Insert slot number & secondary bit in PTE */
+	rldimi	r30,r3,12,63-15
 		
 	/* Write out the PTE with a normal write
 	 * (maybe add eieio may be good still ?)


