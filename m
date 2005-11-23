Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030357AbVKWIHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030357AbVKWIHk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 03:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030358AbVKWIHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 03:07:39 -0500
Received: from ozlabs.org ([203.10.76.45]:9699 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030357AbVKWIHi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 03:07:38 -0500
Date: Wed, 23 Nov 2005 19:07:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: powerpc: Fix for hugepage areas straddling 4GB boundary
Message-ID: <20051123080720.GB26596@localhost.localdomain>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, linuxppc64-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew/Linus, please apply,

Commit 7d24f0b8a53261709938ffabe3e00f88f6498df9 fixed bugs in the
ppc64 SLB miss handler with respect to hugepage handling, and in the
process tweaked the semantics of the hugepage address masks in
mm_context_t.  Unfortunately, it left out a couple of necessary
changes to go with that change.  First, the in_hugepage_area() macro
was not updated to match, second prepare_hugepage_range() was not
updated to correctly handle hugepages regions which straddled the 4GB
point.

The latter appears only to cause process-hangs when attempting to map
such a region, but the former can cause oopses if a get_user_pages()
is triggered at the wrong point.  This patch addresses both bugs.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/arch/powerpc/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/hugetlbpage.c	2005-11-23 18:56:43.000000000 +1100
+++ working-2.6/arch/powerpc/mm/hugetlbpage.c	2005-11-23 18:57:43.000000000 +1100
@@ -287,15 +287,15 @@
 
 int prepare_hugepage_range(unsigned long addr, unsigned long len)
 {
-	int err;
+	int err = 0;
 
 	if ( (addr+len) < addr )
 		return -EINVAL;
 
-	if ((addr + len) < 0x100000000UL)
+	if (addr < 0x100000000UL)
 		err = open_low_hpage_areas(current->mm,
 					  LOW_ESID_MASK(addr, len));
-	else
+	if ((addr + len) >= 0x100000000UL)
 		err = open_high_hpage_areas(current->mm,
 					    HTLB_AREA_MASK(addr, len));
 	if (err) {
Index: working-2.6/include/asm-powerpc/page_64.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/page_64.h	2005-11-23 18:56:43.000000000 +1100
+++ working-2.6/include/asm-powerpc/page_64.h	2005-11-23 18:57:05.000000000 +1100
@@ -135,9 +135,9 @@
 
 #define in_hugepage_area(context, addr) \
 	(cpu_has_feature(CPU_FTR_16M_PAGE) && \
-	 ( ((1 << GET_HTLB_AREA(addr)) & (context).high_htlb_areas) || \
-	   ( ((addr) < 0x100000000L) && \
-	     ((1 << GET_ESID(addr)) & (context).low_htlb_areas) ) ) )
+	 ( ( (addr) >= 0x100000000UL) \
+	   ? ((1 << GET_HTLB_AREA(addr)) & (context).high_htlb_areas) \
+	   : ((1 << GET_ESID(addr)) & (context).low_htlb_areas) ) )
 
 #else /* !CONFIG_HUGETLB_PAGE */
 


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
