Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262394AbUKBWv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262394AbUKBWv2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 17:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbUKBWru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 17:47:50 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:16864 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262418AbUKBWqe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 17:46:34 -0500
Message-ID: <41880E0A.3000805@us.ibm.com>
Date: Tue, 02 Nov 2004 14:45:30 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@novell.com>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: fix iounmap and a pageattr memleak (x86 and x86-64)
References: <4187FA6D.3070604@us.ibm.com> <20041102220720.GV3571@dualathlon.random>
In-Reply-To: <20041102220720.GV3571@dualathlon.random>
Content-Type: multipart/mixed;
 boundary="------------040507060905090305070404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040507060905090305070404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrea Arcangeli wrote:
> Still I recommend investigating _why_ debug_pagealloc is violating the
> API. It might not be necessary to wait for the pageattr universal
> feature to make DEBUG_PAGEALLOC work safe.

This makes the DEBUG_PAGEALLOC stuff symmetric enough to boot for me, 
and it's pretty damn simple.  Any ideas for doing this without bloating 
'struct page', even in the debugging case?

--------------040507060905090305070404
Content-Type: text/plain;
 name="Z3-page_debugging.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Z3-page_debugging.patch"



---

 memhotplug1-dave/arch/i386/mm/pageattr.c |    7 +++++--
 memhotplug1-dave/include/linux/mm.h      |    3 +++
 memhotplug1-dave/mm/page_alloc.c         |    5 ++++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff -puN include/linux/mm.h~Z3-page_debugging include/linux/mm.h
--- memhotplug1/include/linux/mm.h~Z3-page_debugging	2004-11-02 14:29:51.000000000 -0800
+++ memhotplug1-dave/include/linux/mm.h	2004-11-02 14:37:08.000000000 -0800
@@ -245,6 +245,9 @@ struct page {
 	void *virtual;			/* Kernel virtual address (NULL if
 					   not kmapped, ie. highmem) */
 #endif /* WANT_PAGE_VIRTUAL */
+#ifdef CONFIG_DEBUG_PAGEALLOC
+	int mapped;
+#endif
 };
 
 #ifdef CONFIG_MEMORY_HOTPLUG
diff -puN arch/i386/mm/pageattr.c~Z3-page_debugging arch/i386/mm/pageattr.c
--- memhotplug1/arch/i386/mm/pageattr.c~Z3-page_debugging	2004-11-02 14:31:07.000000000 -0800
+++ memhotplug1-dave/arch/i386/mm/pageattr.c	2004-11-02 14:41:00.000000000 -0800
@@ -153,7 +153,7 @@ __change_page_attr(struct page *page, pg
 		printk("pgprot_val(PAGE_KERNEL): %08lx\n", pgprot_val(PAGE_KERNEL));
 		printk("(pte_val(*kpte) & _PAGE_PSE): %08lx\n", (pte_val(*kpte) & _PAGE_PSE)); 
 		printk("path: %d\n", path);
-		BUG();
+		WARN_ON(1);
 	}
 
 	if (cpu_has_pse && (page_count(kpte_page) == 1)) {
@@ -224,7 +224,10 @@ void kernel_map_pages(struct page *page,
 	/* the return value is ignored - the calls cannot fail,
 	 * large pages are disabled at boot time.
 	 */
-	change_page_attr(page, numpages, enable ? PAGE_KERNEL : __pgprot(0));
+	if (enable && !page->mapped)
+		change_page_attr(page, numpages, PAGE_KERNEL);
+	else if (!enable && page->mapped)
+		change_page_attr(page, numpages, __pgprot(0));
 	/* we should perform an IPI and flush all tlbs,
 	 * but that can deadlock->flush only current cpu.
 	 */
diff -puN mm/page_alloc.c~Z3-page_debugging mm/page_alloc.c
--- memhotplug1/mm/page_alloc.c~Z3-page_debugging	2004-11-02 14:37:53.000000000 -0800
+++ memhotplug1-dave/mm/page_alloc.c	2004-11-02 14:42:56.000000000 -0800
@@ -1840,8 +1840,11 @@ void __devinit memmap_init_zone(unsigned
 		INIT_LIST_HEAD(&page->lru);
 #ifdef WANT_PAGE_VIRTUAL
 		/* The shift won't overflow because ZONE_NORMAL is below 4G. */
-		if (!is_highmem_idx(zone))
+		if (!is_highmem_idx(zone)) {
 			set_page_address(page, __va(start_pfn << PAGE_SHIFT));
+			page->mapped = 1;
+		} else
+			page->mapped = 0;
 #endif
 		start_pfn++;
 	}
_

--------------040507060905090305070404--
