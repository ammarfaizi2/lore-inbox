Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268465AbUIQB0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268465AbUIQB0X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 21:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268467AbUIQB0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 21:26:23 -0400
Received: from ozlabs.org ([203.10.76.45]:23964 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268465AbUIQBZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 21:25:56 -0400
Date: Fri, 17 Sep 2004 11:13:20 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PPC64] Remove LARGE_PAGE_SHIFT constant
Message-ID: <20040917011320.GA6523@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
	Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply:

For historical reasons, ppc64 has ended up with two #defines for the
size of a large (16M) page: LARGE_PAGE_SHIFT and HPAGE_SHIFT.  This
patch removes LARGE_PAGE_SHIFT in favour of the more widely used
HPAGE_SHIFT.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/arch/ppc64/kernel/pSeries_htab.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/pSeries_htab.c	2004-08-09 09:51:38.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/pSeries_htab.c	2004-09-16 17:04:56.034685808 +1000
@@ -325,7 +325,7 @@
 		va = (vsid << 28) | (batch->addr[i] & 0x0fffffff);
 		batch->vaddr[j] = va;
 		if (large)
-			vpn = va >> LARGE_PAGE_SHIFT;
+			vpn = va >> HPAGE_SHIFT;
 		else
 			vpn = va >> PAGE_SHIFT;
 		hash = hpt_hash(vpn, large);
Index: working-2.6/include/asm-ppc64/mmu.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/mmu.h	2004-09-16 16:58:48.170699448 +1000
+++ working-2.6/include/asm-ppc64/mmu.h	2004-09-16 17:04:44.306603944 +1000
@@ -119,8 +119,6 @@
 #define PT_SHIFT (12)			/* Page Table */
 #define PT_MASK  0x02FF
 
-#define LARGE_PAGE_SHIFT 24
-
 static inline unsigned long hpt_hash(unsigned long vpn, int large)
 {
 	unsigned long vsid;
Index: working-2.6/arch/ppc64/mm/hash_utils.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/hash_utils.c	2004-09-15 10:53:53.000000000 +1000
+++ working-2.6/arch/ppc64/mm/hash_utils.c	2004-09-16 17:04:20.121686024 +1000
@@ -100,7 +100,7 @@
 		int ret;
 
 		if (large)
-			vpn = va >> LARGE_PAGE_SHIFT;
+			vpn = va >> HPAGE_SHIFT;
 		else
 			vpn = va >> PAGE_SHIFT;
 
@@ -332,7 +332,7 @@
 
 	va = (vsid << 28) | (ea & 0x0fffffff);
 	if (large)
-		vpn = va >> LARGE_PAGE_SHIFT;
+		vpn = va >> HPAGE_SHIFT;
 	else
 		vpn = va >> PAGE_SHIFT;
 	hash = hpt_hash(vpn, large);
Index: working-2.6/arch/ppc64/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/hugetlbpage.c	2004-09-07 10:38:00.000000000 +1000
+++ working-2.6/arch/ppc64/mm/hugetlbpage.c	2004-09-16 17:03:34.673672800 +1000
@@ -853,7 +853,7 @@
 	vsid = get_vsid(context.id, ea);
 
 	va = (vsid << 28) | (ea & 0x0fffffff);
-	vpn = va >> LARGE_PAGE_SHIFT;
+	vpn = va >> HPAGE_SHIFT;
 	hash = hpt_hash(vpn, 1);
 	if (hugepte_val(pte) & _HUGEPAGE_SECONDARY)
 		hash = ~hash;

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
