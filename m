Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317622AbSGaBrg>; Tue, 30 Jul 2002 21:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317632AbSGaBrg>; Tue, 30 Jul 2002 21:47:36 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:196 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S317622AbSGaBrf>; Tue, 30 Jul 2002 21:47:35 -0400
Message-ID: <3D47412D.1060407@quark.didntduck.org>
Date: Tue, 30 Jul 2002 21:45:17 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>, da-x@gmx.net
Subject: [PATCH] fix x86 page table init
Content-Type: multipart/mixed;
 boundary="------------080209050808070907090901"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080209050808070907090901
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The recent changes to the x86 page table init reintroduced a bug with 
the 4k pagetables.  The page table must be filled with entries before it 
is inserted into the pmd or else you risk a tlb miss on a kernel code 
page causing an oops.  This patch takes a different approach than before 
- it allows for reuse of the boot pagetable pages instead of allocating 
new ones.

--
				Brian Gerst

--------------080209050808070907090901
Content-Type: text/plain;
 name="pte_init-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pte_init-1"

diff -urN linux-bk/arch/i386/mm/init.c linux/arch/i386/mm/init.c
--- linux-bk/arch/i386/mm/init.c	Tue Jul 30 20:59:27 2002
+++ linux/arch/i386/mm/init.c	Tue Jul 30 21:02:41 2002
@@ -70,10 +70,14 @@
  */
 static pte_t * __init one_page_table_init(pmd_t *pmd)
 {
-	pte_t *page_table = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
-	set_pmd(pmd, __pmd(__pa(page_table) | _KERNPG_TABLE));
-	if (page_table != pte_offset_kernel(pmd, 0))
-		BUG();	
+	pte_t *page_table;
+	page_table = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+	if (pmd_none(*pmd)) {
+		set_pmd(pmd, __pmd(__pa(page_table) | _KERNPG_TABLE));
+		if (page_table != pte_offset_kernel(pmd, 0))
+			BUG();	
+	} else
+		page_table = pte_offset_kernel(pmd, 0);
 
 	return page_table;
 }
@@ -107,9 +111,7 @@
 
 		pmd = pmd_offset(pgd, vaddr);
 		for (; (pmd_ofs < PTRS_PER_PMD) && (vaddr != end); pmd++, pmd_ofs++) {
-			if (pmd_none(*pmd)) 
-				one_page_table_init(pmd);
-
+			one_page_table_init(pmd);
 			vaddr += PMD_SIZE;
 		}
 		pmd_ofs = 0;

--------------080209050808070907090901--

