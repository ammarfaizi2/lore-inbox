Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262510AbUKEAEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262510AbUKEAEx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 19:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbUKEAEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 19:04:08 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:8702 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262510AbUKEACK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 19:02:10 -0500
Subject: Re: fix iounmap and a pageattr memleak (x86 and x86-64)
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20041103030558.GK3571@dualathlon.random>
References: <4187FA6D.3070604@us.ibm.com>
	 <20041102220720.GV3571@dualathlon.random> <41880E0A.3000805@us.ibm.com>
	 <4188118A.5050300@us.ibm.com> <20041103013511.GC3571@dualathlon.random>
	 <418837D1.402@us.ibm.com> <20041103022606.GI3571@dualathlon.random>
	 <418846E9.1060906@us.ibm.com>  <20041103030558.GK3571@dualathlon.random>
Content-Type: multipart/mixed; boundary="=-NWaoPp/NYxxXq1H0Ku84"
Message-Id: <1099612923.1022.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 04 Nov 2004 16:02:04 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NWaoPp/NYxxXq1H0Ku84
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andrea,

Are you sure that BUG_ON() should be for !page_count(kpte_page)?  I
noticed that I was getting some BUGs when the count went back to 0, but
the pte page was completely full with valid ptes.  I *think* it's
correct to make it:

       BUG_ON(page_count(kpte_page) < 0);

Or, I guess we could keep the old BUG_ON(), and put it inside the else
block with the __put_page().  

-- Dave

--=-NWaoPp/NYxxXq1H0Ku84
Content-Disposition: attachment; filename=Z3-page_debugging.patch
Content-Type: text/x-patch; name=Z3-page_debugging.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit



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

--=-NWaoPp/NYxxXq1H0Ku84--

