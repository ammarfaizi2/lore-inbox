Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267099AbSLDVfG>; Wed, 4 Dec 2002 16:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267101AbSLDVfF>; Wed, 4 Dec 2002 16:35:05 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:32442 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267099AbSLDVfF>; Wed, 4 Dec 2002 16:35:05 -0500
Date: Wed, 04 Dec 2002 13:36:35 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrew Morton <akpm@zip.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm mailing list <linux-mm@kvack.org>, haveblue@us.ibm.com
Subject: [PATCH] make sure all PMDs are allocated under PAE mode
Message-ID: <91490000.1039037795@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is a bugfix I found for a problem Dave Hansen was hitting
when using PAE mode on a 1Gb RAM box. Basically if we change
PAGE_OFFSET to have more than 1Gb of KVA in excess of the 
physical ram used, we forget to instantiate the upper PMDs.
(The PMDs for kernel space seem to be created only if there's
physical ram against them, but we also need them for the vmalloc
space).

The change below makes us walk from PAGE_OFFSET up to the top
of virtual address space (instead of up to the top of phys ram),
and ignores the rest of the loop apart from the PMD alloc for
that upper region (above the 1-1 phys-virt mapping region).

Thanks to Dave for doing the actual patch creation and testing.
It's designed to be minimally invasive, rather than desperately
efficient.

M.

diff -Nru a/arch/i386/mm/init.c b/arch/i386/mm/init.c
--- a/arch/i386/mm/init.c	Tue Dec  3 15:54:44 2002
+++ b/arch/i386/mm/init.c	Tue Dec  3 15:54:44 2002
@@ -134,8 +134,10 @@
 	pgd = pgd_base + pgd_ofs;
 	pfn = 0;
 
-	for (; pgd_ofs < PTRS_PER_PGD && pfn < max_low_pfn; pgd++, pgd_ofs++) {
+	for (; pgd_ofs < PTRS_PER_PGD; pgd++, pgd_ofs++) {
 		pmd = one_md_table_init(pgd);
+		if (pfn >= max_low_pfn)
+			continue;
 		for (pmd_ofs = 0; pmd_ofs < PTRS_PER_PMD && pfn < max_low_pfn; pmd++, pmd_ofs++) {
 			/* Map with big pages if possible, otherwise create normal page tables. */
 			if (cpu_has_pse) {

