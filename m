Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268247AbTALHBx>; Sun, 12 Jan 2003 02:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267321AbTALHBx>; Sun, 12 Jan 2003 02:01:53 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:58245 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S268247AbTALHBs>; Sun, 12 Jan 2003 02:01:48 -0500
Message-ID: <3E21157D.30607@didntduck.org>
Date: Sun, 12 Jan 2003 02:13:01 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: 2.5.55/.56 instant reboot problem on 486
References: <200301120231.DAA14711@harpo.it.uu.se>
Content-Type: multipart/mixed;
 boundary="------------000509000002030104030808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000509000002030104030808
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Mikael Pettersson wrote:
> My '94 vintage 486 has problems booting 2.5.55 and 2.5.56.
> When it fails, the boot gets to loading the kernel and
> printing "Ok, booting the kernel.". Then there is a short
> pause (line a tenth of a second) and the machine reboots.
> 
> After doing a binary search with "for(;;);" statements
> (printk doesn't work this early) I found that the reboot
> occurs in arch/i386/mm/init.c:kernel_physical_mapping_init():
> (start_kernel() -> setup_arch() -> paging_init() ->
> pagetable_init() -> kernel_physical_mapping_init())
> 

The problem is that one_page_table_init() pulls the rug out from under 
the kernel by installing a new page table before setting it up.  A 486 
has a small TLB so any miss will cause a triple fault and reset.  Try 
this patch and see if it fixes it.

--
				Brian Gerst

--------------000509000002030104030808
Content-Type: text/plain;
 name="ptefix-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ptefix-1"

diff -urN linux-2.5.56/arch/i386/mm/init.c linux/arch/i386/mm/init.c
--- linux-2.5.56/arch/i386/mm/init.c	Sun Jan 12 00:16:22 2003
+++ linux/arch/i386/mm/init.c	Sun Jan 12 01:48:28 2003
@@ -71,12 +71,16 @@
  */
 static pte_t * __init one_page_table_init(pmd_t *pmd)
 {
-	pte_t *page_table = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
-	set_pmd(pmd, __pmd(__pa(page_table) | _PAGE_TABLE));
-	if (page_table != pte_offset_kernel(pmd, 0))
-		BUG();	
+	if (pmd_none(*pmd)) {
+		pte_t *page_table = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+		set_pmd(pmd, __pmd(__pa(page_table) | _PAGE_TABLE));
+		if (page_table != pte_offset_kernel(pmd, 0))
+			BUG();	
 
-	return page_table;
+		return page_table;
+	}
+	
+	return pte_offset_kernel(pmd, 0);
 }
 
 /*

--------------000509000002030104030808--

