Return-Path: <linux-kernel-owner+w=401wt.eu-S1423097AbWLUWlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423097AbWLUWlv (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 17:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423026AbWLUWlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 17:41:51 -0500
Received: from ozlabs.org ([203.10.76.45]:39659 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423097AbWLUWlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 17:41:51 -0500
X-Greylist: delayed 1124 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Dec 2006 17:41:51 EST
Date: Fri, 22 Dec 2006 09:23:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: William Lee Irwin <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       libhugetlbfs-devel@lists.sourceforge.net,
       Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [powerpc] Fix bogus BUG_ON() in in hugetlb_get_unmapped_area()
Message-ID: <20061221222303.GA6418@localhost.localdomain>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	William Lee Irwin <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org,
	libhugetlbfs-devel@lists.sourceforge.net,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, Paulus, please apply

The powerpc specific version of hugetlb_get_unmapped_area() makes some
unwarranted assumptions about what checks have been made to its
parameters by its callers.  This will lead to a BUG_ON() if a 32-bit
process attempts to make a hugepage mapping which extends above
TASK_SIZE (4GB).

I'm not sure if these assumptions came about because they were valid
with earlier versions of the get_unmapped_area() path, or if it was
always broken.  Nonetheless this patch fixes the logic, and removes
the crash.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/arch/powerpc/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/hugetlbpage.c	2006-12-21 14:54:15.000000000 +1100
+++ working-2.6/arch/powerpc/mm/hugetlbpage.c	2006-12-21 14:57:35.000000000 +1100
@@ -744,7 +744,8 @@ static int htlb_check_hinted_area(unsign
 	struct vm_area_struct *vma;
 
 	vma = find_vma(current->mm, addr);
-	if (!vma || ((addr + len) <= vma->vm_start))
+	if (TASK_SIZE - len >= addr &&
+	    (!vma || ((addr + len) <= vma->vm_start)))
 		return 0;
 
 	return -ENOMEM;
@@ -815,6 +816,8 @@ unsigned long hugetlb_get_unmapped_area(
 		return -EINVAL;
 	if (len & ~HPAGE_MASK)
 		return -EINVAL;
+	if (len > TASK_SIZE)
+		return -ENOMEM;
 
 	if (!cpu_has_feature(CPU_FTR_16M_PAGE))
 		return -EINVAL;
@@ -823,9 +826,6 @@ unsigned long hugetlb_get_unmapped_area(
 	BUG_ON((addr + len)  < addr);
 
 	if (test_thread_flag(TIF_32BIT)) {
-		/* Paranoia, caller should have dealt with this */
-		BUG_ON((addr + len) > 0x100000000UL);
-
 		curareas = current->mm->context.low_htlb_areas;
 
 		/* First see if we can use the hint address */

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
