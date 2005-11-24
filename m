Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030447AbVKXDQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030447AbVKXDQc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 22:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932620AbVKXDQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 22:16:32 -0500
Received: from ozlabs.org ([203.10.76.45]:19672 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932619AbVKXDQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 22:16:31 -0500
Date: Thu, 24 Nov 2005 14:16:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: powerpc: Make hugepage mappings resepect hint addresses
Message-ID: <20051124031615.GB3024@localhost.localdomain>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, linuxppc64-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply.

Currently, the powerpc version of hugetlb_get_unmapped_area() entirely
ignores the hint address.  The only way to get a hugepage mapping at a
specified address is with MAP_FIXED, in which case there's no way
(short of parsing /proc/self/maps) for userspace to tell if it will
clobber an existing mapping.  This is inconvenient, so the patch below
makes hugepage mappings use the given hint address if possible.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/arch/powerpc/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/hugetlbpage.c	2005-11-24 13:38:12.000000000 +1100
+++ working-2.6/arch/powerpc/mm/hugetlbpage.c	2005-11-24 14:09:42.000000000 +1100
@@ -524,6 +524,17 @@ fail:
 	return addr;
 }
 
+static int htlb_check_hinted_area(unsigned long addr, unsigned long len)
+{
+	struct vm_area_struct *vma;
+
+	vma = find_vma(current->mm, addr);
+	if (!vma || ((addr + len) <= vma->vm_start))
+		return 0;
+
+	return -ENOMEM;
+}
+
 static unsigned long htlb_get_low_area(unsigned long len, u16 segmask)
 {
 	unsigned long addr = 0;
@@ -584,6 +595,7 @@ unsigned long hugetlb_get_unmapped_area(
 {
 	int lastshift;
 	u16 areamask, curareas;
+	struct vm_area_struct *vma;
 
 	if (HPAGE_SHIFT == 0)
 		return -EINVAL;
@@ -593,15 +605,28 @@ unsigned long hugetlb_get_unmapped_area(
 	if (!cpu_has_feature(CPU_FTR_16M_PAGE))
 		return -EINVAL;
 
+	/* Paranoia, caller should have dealt with this */
+	BUG_ON((addr + len)  < addr);
+
 	if (test_thread_flag(TIF_32BIT)) {
+		/* Paranoia, caller should have dealt with this */
+		BUG_ON((addr + len) > 0x100000000UL);
+
 		curareas = current->mm->context.low_htlb_areas;
 
-		/* First see if we can do the mapping in the existing
-		 * low areas */
+		/* First see if we can use the hint address */
+		if (addr && (htlb_check_hinted_area(addr, len) == 0)) {
+			areamask = LOW_ESID_MASK(addr, len);
+			if (open_low_hpage_areas(current->mm, areamask) == 0)
+				return addr;
+		}
+
+		/* Next see if we can map in the existing low areas */
 		addr = htlb_get_low_area(len, curareas);
 		if (addr != -ENOMEM)
 			return addr;
 
+		/* Finally go looking for areas to open */
 		lastshift = 0;
 		for (areamask = LOW_ESID_MASK(0x100000000UL-len, len);
 		     ! lastshift; areamask >>=1) {
@@ -616,12 +641,22 @@ unsigned long hugetlb_get_unmapped_area(
 	} else {
 		curareas = current->mm->context.high_htlb_areas;
 
-		/* First see if we can do the mapping in the existing
-		 * high areas */
+		/* First see if we can use the hint address */
+		/* We discourage 64-bit processes from doing hugepage
+		 * mappings below 4GB (must use MAP_FIXED) */
+		if ((addr >= 0x100000000UL)
+		    && (htlb_check_hinted_area(addr, len) == 0)) {
+			areamask = HTLB_AREA_MASK(addr, len);
+			if (open_high_hpage_areas(current->mm, areamask) == 0)
+				return addr;
+		}
+
+		/* Next see if we can map in the existing high areas */
 		addr = htlb_get_high_area(len, curareas);
 		if (addr != -ENOMEM)
 			return addr;
 
+		/* Finally go looking for areas to open */
 		lastshift = 0;
 		for (areamask = HTLB_AREA_MASK(TASK_SIZE_USER64-len, len);
 		     ! lastshift; areamask >>=1) {

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
