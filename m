Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317999AbSHDQhk>; Sun, 4 Aug 2002 12:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318135AbSHDQhk>; Sun, 4 Aug 2002 12:37:40 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:50603 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S317999AbSHDQhi>; Sun, 4 Aug 2002 12:37:38 -0400
Message-ID: <3D4D57FB.1070208@quark.didntduck.org>
Date: Sun, 04 Aug 2002 12:36:11 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix x86 page table init
Content-Type: multipart/mixed;
 boundary="------------090002090708030806050502"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090002090708030806050502
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The recent changes to the x86 page table init reintroduced a bug with
the 4k pagetables.  The page table must be filled with entries before it
is inserted into the pmd or else you risk a tlb miss on a kernel code
page causing an oops.  This is the third iteration of the patch and it 
goes back to the 2.4 method, which is compatabile with the boot 
pagetable changes I just sent in.

--
				Brian Gerst


--------------090002090708030806050502
Content-Type: text/plain;
 name="pte_init-3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pte_init-3"

diff -urN linux-bg1/arch/i386/mm/init.c linux/arch/i386/mm/init.c
--- linux-bg1/arch/i386/mm/init.c	Fri Aug  2 10:15:28 2002
+++ linux/arch/i386/mm/init.c	Sun Aug  4 12:14:42 2002
@@ -126,7 +126,7 @@
 	unsigned long pfn;
 	pgd_t *pgd;
 	pmd_t *pmd;
-	pte_t *pte;
+	pte_t *pte, *pte_base;
 	int pgd_ofs, pmd_ofs, pte_ofs;
 
 	pgd_ofs = __pgd_offset(PAGE_OFFSET);
@@ -141,10 +141,19 @@
 				set_pmd(pmd, pfn_pmd(pfn, PAGE_KERNEL_LARGE));
 				pfn += PTRS_PER_PTE;
 			} else {
-				pte = one_page_table_init(pmd);
+				/*
+				 * We cannot set the pmd until the page is full, since we are
+				 * changing the pte under running code and a tlb miss will
+				 * cause an oops.
+				 */
+				pte_base = pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
 
 				for (pte_ofs = 0; pte_ofs < PTRS_PER_PTE && pfn < max_low_pfn; pte++, pfn++, pte_ofs++)
 					set_pte(pte, pfn_pte(pfn, PAGE_KERNEL));
+
+				set_pmd(pmd, __pmd(__pa(pte_base) | _KERNPG_TABLE));
+				if (pte_base != pte_offset_kernel(pmd, 0))
+					BUG();	
 			}
 		}
 	}	

--------------090002090708030806050502--

