Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317742AbSGaEhS>; Wed, 31 Jul 2002 00:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317743AbSGaEhS>; Wed, 31 Jul 2002 00:37:18 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:5821 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S317742AbSGaEhR>; Wed, 31 Jul 2002 00:37:17 -0400
Message-ID: <3D4768F4.5080708@quark.didntduck.org>
Date: Wed, 31 Jul 2002 00:35:00 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dan Aloni <da-x@gmx.net>
CC: Brian Gerst <bgerst@didntduck.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix x86 page table init
References: <3D47412D.1060407@quark.didntduck.org> <20020731030519.GA27694@callisto.yi.org>
Content-Type: multipart/mixed;
 boundary="------------090304010106080804090406"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090304010106080804090406
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Dan Aloni wrote:
> On Tue, Jul 30, 2002 at 09:45:17PM -0400, Brian Gerst wrote:
> 
>>The recent changes to the x86 page table init reintroduced a bug with 
>>the 4k pagetables.  The page table must be filled with entries before it 
>>is inserted into the pmd or else you risk a tlb miss on a kernel code 
>>page causing an oops.  This patch takes a different approach than before 
>>- it allows for reuse of the boot pagetable pages instead of allocating 
>>new ones.
> 
> 
> In the patch below, isn't there a bootmem page leak in case !pmd_none(*pmd)?

Whoops.  That's what happens when one needs to recreate a patch from 
memory.  Revised patch attached.

--
				Brian Gerst

--------------090304010106080804090406
Content-Type: text/plain;
 name="pte_init-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pte_init-2"

diff -urN linux-bk/arch/i386/mm/init.c linux/arch/i386/mm/init.c
--- linux-bk/arch/i386/mm/init.c	Tue Jul 30 20:59:27 2002
+++ linux/arch/i386/mm/init.c	Wed Jul 31 00:32:37 2002
@@ -70,10 +70,14 @@
  */
 static pte_t * __init one_page_table_init(pmd_t *pmd)
 {
-	pte_t *page_table = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
-	set_pmd(pmd, __pmd(__pa(page_table) | _KERNPG_TABLE));
-	if (page_table != pte_offset_kernel(pmd, 0))
-		BUG();	
+	pte_t *page_table;
+	if (pmd_none(*pmd)) {
+		page_table = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
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

--------------090304010106080804090406--

