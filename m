Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbVGSVUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbVGSVUw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 17:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVGSVUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 17:20:52 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:41994 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S261634AbVGSVUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 17:20:50 -0400
X-IronPort-AV: i="3.94,209,1118034000"; 
   d="scan'208"; a="268789926:sNHT18549928"
Date: Tue, 19 Jul 2005 16:20:46 -0500
From: Stuart Hayes <Stuart_Hayes@dell.com>
To: ak@suse.de
Cc: ak@suse.de, riel@redhat.com, andrea@suse.de, linux-kernel@vger.kernel.org,
       mingo@elte.hu, stuart_hayes@dell.com
Subject: Re: page allocation/attributes question (i386/x86_64 specific)
Message-ID: <20050719212046.GB12089@humbolt.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi Kleen wrote:
> I personally wouldn't like doing this NX cleanup very late like you did but instead directly after the early NX setup.

I've thought about it more, and come up with another patch.  All it does is
sets up the PTEs correctly from the beginning, breaking up large pages if
necessary so that only pages that are actually executable kernel code will be
executable.

With this patch, no changes are required for change_page_attr() to work.  The
disadvantages to this patch are (1) it still relies on the fact that
change_page_attr() won't revert small pages to a large page if the page
containing the PTEs is reserved, and (2) if any init code is in a large page
that contains no non-init code, those PTEs won't be reverted to a large page
when the init memory is freed (though they will be changed to non-executable).

Once this patch is in place, it wouldn't take much to modify change_page_attr()
to use the new page_refprot() function to determine the "normal" setting for
pages.  That could eliminate the need for it to ignore reserved pages, but I
wanted to keep this patch simple.

Anyway, comments appreciated!

Stuart
----


--- 2.6.12-a/arch/i386/mm/init.c	2005-07-19 14:41:14.000000000 -0500
+++ 2.6.12-b/arch/i386/mm/init.c	2005-07-19 14:40:22.000000000 -0500
@@ -128,12 +128,7 @@ static void __init page_table_range_init
 	}
 }
 
-static inline int is_kernel_text(unsigned long addr)
-{
-	if (addr >= PAGE_OFFSET && addr <= (unsigned long)__init_end)
-		return 1;
-	return 0;
-}
+static pgprot_t page_refprot(unsigned int);
 
 /*
  * This maps the physical memory to kernel virtual address space, a total 
@@ -158,25 +153,18 @@ static void __init kernel_physical_mappi
 			continue;
 		for (pmd_idx = 0; pmd_idx < PTRS_PER_PMD && pfn < max_low_pfn; pmd++, pmd_idx++) {
 			unsigned int address = pfn * PAGE_SIZE + PAGE_OFFSET;
+			pgprot_t ref_prot = page_refprot(address);
 
 			/* Map with big pages if possible, otherwise create normal page tables. */
-			if (cpu_has_pse) {
-				unsigned int address2 = (pfn + PTRS_PER_PTE - 1) * PAGE_SIZE + PAGE_OFFSET + PAGE_SIZE-1;
-
-				if (is_kernel_text(address) || is_kernel_text(address2))
-					set_pmd(pmd, pfn_pmd(pfn, PAGE_KERNEL_LARGE_EXEC));
-				else
-					set_pmd(pmd, pfn_pmd(pfn, PAGE_KERNEL_LARGE));
+			if (pgprot_val(ref_prot) & _PAGE_PSE) { 
+				set_pmd(pmd, pfn_pmd(pfn, ref_prot));
 				pfn += PTRS_PER_PTE;
 			} else {
 				pte = one_page_table_init(pmd);
 
-				for (pte_ofs = 0; pte_ofs < PTRS_PER_PTE && pfn < max_low_pfn; pte++, pfn++, pte_ofs++) {
-						if (is_kernel_text(address))
-							set_pte(pte, pfn_pte(pfn, PAGE_KERNEL_EXEC));
-						else
-							set_pte(pte, pfn_pte(pfn, PAGE_KERNEL));
-				}
+				for (pte_ofs = 0; pte_ofs < PTRS_PER_PTE && pfn < max_low_pfn; 
+				     address += PAGE_SIZE, pte++, pfn++, pte_ofs++)
+						set_pte(pte, pfn_pte(pfn, page_refprot(address)));
 			}
 		}
 	}
@@ -229,6 +217,56 @@ static inline int page_is_ram(unsigned l
 	return 0;
 }
 
+/*
+ * page_refprot() returns PTE attributes used to set up the page tables
+ */
+
+static inline int is_kernel_text (unsigned int addr, unsigned int mask)
+{
+	addr &= mask;
+	if ((addr >= ((unsigned int)_text & mask)) &&
+	    (addr <= ((unsigned int)_etext)))
+		return 1;
+	return 0;
+}
+
+static inline int is_kernel_inittext (unsigned int addr, unsigned int mask)
+{
+	addr &= mask;
+	if ((addr >= ((unsigned int)_sinittext & mask)) &&
+	    (addr <= ((unsigned int)_einittext)))
+		return 1;
+	return 0;
+}
+
+static pgprot_t page_refprot(unsigned int addr)
+{
+	if (nx_enabled &&
+	    (is_kernel_text(addr, LARGE_PAGE_MASK) ||
+	     (is_kernel_inittext(addr, LARGE_PAGE_MASK)) ||
+	     ((addr & LARGE_PAGE_MASK) == 0))) {
+		/* big page area has executable stuff in it--use small pages */
+		if (is_kernel_text(addr, PAGE_MASK) ||
+		   (is_kernel_inittext(addr, PAGE_MASK)) ||
+		   ((__pa(addr) <= 0xfffff) && !page_is_ram(__pa(addr) >> PAGE_SHIFT)))
+			return PAGE_KERNEL_EXEC;
+		else
+			return PAGE_KERNEL;
+	}
+	/* big pages with no executable stuff in them */
+	return cpu_has_pse ? PAGE_KERNEL_LARGE : PAGE_KERNEL;
+}
+
+static inline void set_nx_in_initmem(void)
+{
+	unsigned int addr;
+
+	printk("_text=%p _etext=%p _sinittext=%p _einittext=%p\n",_text,_etext,_sinittext,_einittext);
+	addr = (unsigned long)(_sinittext) & PAGE_MASK;
+	for (; addr <= (unsigned long)(_einittext); addr += PAGE_SIZE)
+		set_kernel_exec(addr, 0);
+}
+
 #ifdef CONFIG_HIGHMEM
 pte_t *kmap_pte;
 pgprot_t kmap_prot;
@@ -436,7 +474,7 @@ static void __init set_nx(void)
  * Enables/disables executability of a given kernel page and
  * returns the previous setting.
  */
-int __init set_kernel_exec(unsigned long vaddr, int enable)
+int set_kernel_exec(unsigned long vaddr, int enable)
 {
 	pte_t *pte;
 	int ret = 1;
@@ -670,6 +708,9 @@ void free_initmem(void)
 {
 	unsigned long addr;
 
+	if (nx_enabled)
+		set_nx_in_initmem();
+
 	addr = (unsigned long)(&__init_begin);
 	for (; addr < (unsigned long)(&__init_end); addr += PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(addr));

----- End forwarded message -----
