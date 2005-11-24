Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030584AbVKXCfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030584AbVKXCfP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 21:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030585AbVKXCfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 21:35:14 -0500
Received: from ozlabs.org ([203.10.76.45]:4311 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030584AbVKXCfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 21:35:13 -0500
Date: Thu, 24 Nov 2005 13:34:56 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: powerpc: More hugepage boundary case fixes
Message-ID: <20051124023456.GA3024@localhost.localdomain>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, linuxppc64-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply,

Blah.  The patch [0] I recently sent fixing errors with
in_hugepage_area() and prepare_hugepage_range() for powerpc itself has
an off-by-one bug.  Furthermore, the related functions
touches_hugepage_*_range() and within_hugepage_*_range() are also
buggy.  Some of the bugs, like those addressed in [0] originated with
commit 7d24f0b8a53261709938ffabe3e00f88f6498df9 where we tweaked the
semantics of where hugepages are allowed.  Other bugs have been there
essentially forever, and are due to the undefined behaviour of '<<'
with shift counts greater than the type width (LOW_ESID_MASK could
return non-zero for high ranges with the right congruences).

The good news is that I now have a testsuite which should pick up
things like this if they creep in again.

[0] "powerpc-fix-for-hugepage-areas-straddling-4gb-boundary" in -mm

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/include/asm-powerpc/page_64.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/page_64.h	2005-11-24 11:15:38.000000000 +1100
+++ working-2.6/include/asm-powerpc/page_64.h	2005-11-24 13:09:28.000000000 +1100
@@ -103,8 +103,9 @@ extern unsigned int HPAGE_SHIFT;
 #define HTLB_AREA_SIZE		(1UL << HTLB_AREA_SHIFT)
 #define GET_HTLB_AREA(x)	((x) >> HTLB_AREA_SHIFT)
 
-#define LOW_ESID_MASK(addr, len)    (((1U << (GET_ESID(addr+len-1)+1)) \
-		                      - (1U << GET_ESID(addr))) & 0xffff)
+#define LOW_ESID_MASK(addr, len)    \
+	(((1U << (GET_ESID(min((addr)+(len)-1, 0x100000000UL))+1)) \
+	  - (1U << GET_ESID(min((addr), 0x100000000UL)))) & 0xffff)
 #define HTLB_AREA_MASK(addr, len)   (((1U << (GET_HTLB_AREA(addr+len-1)+1)) \
 		                      - (1U << GET_HTLB_AREA(addr))) & 0xffff)
 
@@ -113,17 +114,21 @@ extern unsigned int HPAGE_SHIFT;
 #define ARCH_HAS_SETCLEAR_HUGE_PTE
 
 #define touches_hugepage_low_range(mm, addr, len) \
-	(LOW_ESID_MASK((addr), (len)) & (mm)->context.low_htlb_areas)
+	(((addr) < 0x100000000UL) \
+	 && (LOW_ESID_MASK((addr), (len)) & (mm)->context.low_htlb_areas))
 #define touches_hugepage_high_range(mm, addr, len) \
-	(HTLB_AREA_MASK((addr), (len)) & (mm)->context.high_htlb_areas)
+	((((addr) + (len)) > 0x100000000UL) \
+	  && (HTLB_AREA_MASK((addr), (len)) & (mm)->context.high_htlb_areas))
 
 #define __within_hugepage_low_range(addr, len, segmask) \
-	((LOW_ESID_MASK((addr), (len)) | (segmask)) == (segmask))
+	( (((addr)+(len)) <= 0x100000000UL) \
+	  && ((LOW_ESID_MASK((addr), (len)) | (segmask)) == (segmask)))
 #define within_hugepage_low_range(addr, len) \
 	__within_hugepage_low_range((addr), (len), \
 				    current->mm->context.low_htlb_areas)
 #define __within_hugepage_high_range(addr, len, zonemask) \
-	((HTLB_AREA_MASK((addr), (len)) | (zonemask)) == (zonemask))
+	( ((addr) >= 0x100000000UL) \
+	  && ((HTLB_AREA_MASK((addr), (len)) | (zonemask)) == (zonemask)))
 #define within_hugepage_high_range(addr, len) \
 	__within_hugepage_high_range((addr), (len), \
 				    current->mm->context.high_htlb_areas)
Index: working-2.6/arch/powerpc/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/hugetlbpage.c	2005-11-24 11:15:38.000000000 +1100
+++ working-2.6/arch/powerpc/mm/hugetlbpage.c	2005-11-24 13:18:41.000000000 +1100
@@ -295,7 +295,7 @@ int prepare_hugepage_range(unsigned long
 	if (addr < 0x100000000UL)
 		err = open_low_hpage_areas(current->mm,
 					  LOW_ESID_MASK(addr, len));
-	if ((addr + len) >= 0x100000000UL)
+	if ((addr + len) > 0x100000000UL)
 		err = open_high_hpage_areas(current->mm,
 					    HTLB_AREA_MASK(addr, len));
 	if (err) {

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
