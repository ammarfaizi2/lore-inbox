Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268314AbUHYTJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268314AbUHYTJL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 15:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268308AbUHYTHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 15:07:53 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:33307 "EHLO
	kernel.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S268307AbUHYTG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 15:06:58 -0400
Subject: [patch 2/2] clean up types in pageattr code
To: ak@muc.de
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 25 Aug 2004 12:06:15 -0700
Message-Id: <E1C0368-0008AG-00@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's another one that started off chasing an "unsigned long" passed to __pa()
in lookup_adddress().  It's kinda like pulling a loose thread on a sweater.

A couple of functions in arch/i386/mm/pageattr.c pass around virtual addresses
as "unsigned long"s and pass them to __pa().  However, only lookup_address()
even gets close to doing any arithmetic on them.

I have the feeling these types were all cascaded because do_page_fault() keeps
the faulting address in an unsigned long and calls lookup_address().  But, 
do_page_fault() really is the oddball here because it does so much arithmetic
on that address.  So, push the cast in to there.

split_large_page() also gets some renamed variables.  Can I just point out
that I'd support any regulation to forcefully remove the keyboards from anyone
who declares 2 variables in the same function called address and addr? 

changes to split_large_page():
- rename the variables to more descriptive things than addr
- save some shifts by storing things in pfns to begin with.  
- use __get_free_pages() instead of calling alloc_pages() directly
- return virt_to_page() instead of keeping the struct page around
  (this effectively does a page_to_virt() in __get_free_pages(), and a 
   virt_to_page() later on, but this looks a lot nicer, and it't not any
   kind of hot path to begin with)

One nice end result is that set_kernel_exec() can take a void* like it wants to
naturally and avoid some casts.  

This patch depends on the unsigned long casts for the p*_index() functions 
patch that I just sent.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/arch/i386/kernel/smpboot.c |    4 +-
 memhotplug-dave/arch/i386/mm/fault.c       |    2 -
 memhotplug-dave/arch/i386/mm/init.c        |    2 -
 memhotplug-dave/arch/i386/mm/pageattr.c    |   41 +++++++++++++++--------------
 memhotplug-dave/include/asm-i386/pgtable.h |    6 ++--
 5 files changed, 29 insertions(+), 26 deletions(-)

diff -puN arch/i386/mm/fault.c~AA1-lookup_address-cousins-types arch/i386/mm/fault.c
--- memhotplug/arch/i386/mm/fault.c~AA1-lookup_address-cousins-types	2004-08-25 11:53:58.000000000 -0700
+++ memhotplug-dave/arch/i386/mm/fault.c	2004-08-25 11:53:58.000000000 -0700
@@ -442,7 +442,7 @@ no_context:
 
 #ifdef CONFIG_X86_PAE
 	if (error_code & 16) {
-		pte_t *pte = lookup_address(address);
+		pte_t *pte = lookup_address((void *)address);
 
 		if (pte && pte_present(*pte) && !pte_exec_kernel(*pte))
 			printk(KERN_CRIT "kernel tried to execute NX-protected page - exploit attempt? (uid: %d)\n", current->uid);
diff -puN arch/i386/mm/pgtable.c~AA1-lookup_address-cousins-types arch/i386/mm/pgtable.c
diff -puN arch/i386/mm/init.c~AA1-lookup_address-cousins-types arch/i386/mm/init.c
--- memhotplug/arch/i386/mm/init.c~AA1-lookup_address-cousins-types	2004-08-25 11:53:58.000000000 -0700
+++ memhotplug-dave/arch/i386/mm/init.c	2004-08-25 11:53:58.000000000 -0700
@@ -478,7 +478,7 @@ static void __init set_nx(void)
  * Enables/disables executability of a given kernel page and
  * returns the previous setting.
  */
-int __init set_kernel_exec(unsigned long vaddr, int enable)
+int __init set_kernel_exec(void *vaddr, int enable)
 {
 	pte_t *pte;
 	int ret = 1;
diff -puN arch/i386/mm/pageattr.c~AA1-lookup_address-cousins-types arch/i386/mm/pageattr.c
--- memhotplug/arch/i386/mm/pageattr.c~AA1-lookup_address-cousins-types	2004-08-25 11:53:58.000000000 -0700
+++ memhotplug-dave/arch/i386/mm/pageattr.c	2004-08-25 11:53:58.000000000 -0700
@@ -17,7 +17,7 @@ static spinlock_t cpa_lock = SPIN_LOCK_U
 static struct list_head df_list = LIST_HEAD_INIT(df_list);
 
 
-pte_t *lookup_address(unsigned long address) 
+pte_t *lookup_address(void *address)
 { 
 	pgd_t *pgd = pgd_offset_k(address); 
 	pmd_t *pmd;
@@ -31,27 +31,30 @@ pte_t *lookup_address(unsigned long addr
         return pte_offset_kernel(pmd, address);
 } 
 
-static struct page *split_large_page(unsigned long address, pgprot_t prot)
+static struct page *split_large_page(void *start_vaddr, pgprot_t prot)
 { 
-	int i; 
-	unsigned long addr;
-	struct page *base;
-	pte_t *pbase;
+	int i;
+	unsigned long start_pfn;
+	unsigned long small_page_pfn;
+	pte_t *pte_base;
 
 	spin_unlock_irq(&cpa_lock);
-	base = alloc_pages(GFP_KERNEL, 0);
+	pte_base = (pte_t *)__get_free_pages(GFP_KERNEL, 0);
 	spin_lock_irq(&cpa_lock);
-	if (!base) 
+	if (!pte_base)
 		return NULL;
 
-	address = __pa(address);
-	addr = address & LARGE_PAGE_MASK; 
-	pbase = (pte_t *)page_address(base);
-	for (i = 0; i < PTRS_PER_PTE; i++, addr += PAGE_SIZE) {
-		pbase[i] = pfn_pte(addr >> PAGE_SHIFT, 
-				   addr == address ? prot : PAGE_KERNEL);
+	start_pfn = __pa(start_vaddr) >> PAGE_SHIFT;
+	small_page_pfn = (start_pfn & (LARGE_PAGE_MASK >> PAGE_SHIFT));
+	for (i = 0; i < PTRS_PER_PTE; i++, small_page_pfn++) {
+		pgprot_t page_prot = PAGE_KERNEL;
+
+		if (small_page_pfn == start_pfn)
+			page_prot = prot;
+
+		pte_base[i] = pfn_pte(small_page_pfn, page_prot);
 	}
-	return base;
+	return virt_to_page(pte_base);
 } 
 
 static void flush_kernel_map(void *dummy) 
@@ -65,7 +68,7 @@ static void flush_kernel_map(void *dummy
 	__flush_tlb_all(); 	
 }
 
-static void set_pmd_pte(pte_t *kpte, unsigned long address, pte_t pte) 
+static void set_pmd_pte(pte_t *kpte, void *address, pte_t pte)
 { 
 	struct page *page;
 	unsigned long flags;
@@ -89,7 +92,7 @@ static void set_pmd_pte(pte_t *kpte, uns
  * No more special protections in this 2/4MB area - revert to a
  * large page again. 
  */
-static inline void revert_page(struct page *kpte_page, unsigned long address)
+static inline void revert_page(struct page *kpte_page, void *address)
 {
 	pte_t *linear = (pte_t *) 
 		pmd_offset(pgd_offset(&init_mm, address), address);
@@ -102,14 +105,14 @@ static int
 __change_page_attr(struct page *page, pgprot_t prot)
 { 
 	pte_t *kpte; 
-	unsigned long address;
+	void *address;
 	struct page *kpte_page;
 
 #ifdef CONFIG_HIGHMEM
 	if (page >= highmem_start_page) 
 		BUG(); 
 #endif
-	address = (unsigned long)page_address(page);
+	address = page_address(page);
 
 	kpte = lookup_address(address);
 	if (!kpte)
diff -puN arch/x86_64/kernel/early_printk.c~AA1-lookup_address-cousins-types arch/x86_64/kernel/early_printk.c
diff -L include/linux/nonlinear.h -puN /dev/null /dev/null
diff -puN include/asm-i386/pgtable.h~AA1-lookup_address-cousins-types include/asm-i386/pgtable.h
--- memhotplug/include/asm-i386/pgtable.h~AA1-lookup_address-cousins-types	2004-08-25 11:53:58.000000000 -0700
+++ memhotplug-dave/include/asm-i386/pgtable.h	2004-08-25 11:53:58.000000000 -0700
@@ -350,7 +350,7 @@ static inline pte_t pte_modify(pte_t pte
  * NOTE: the return type is pte_t but if the pmd is PSE then we return it
  * as a pte too.
  */
-extern pte_t *lookup_address(unsigned long address);
+extern pte_t *lookup_address(void *address);
 
 /*
  * Make a given kernel text page executable/non-executable.
@@ -359,9 +359,9 @@ extern pte_t *lookup_address(unsigned lo
  * NOTE: this is an __init function for security reasons.
  */
 #ifdef CONFIG_X86_PAE
- extern int set_kernel_exec(unsigned long vaddr, int enable);
+ extern int set_kernel_exec(void *vaddr, int enable);
 #else
- static inline int set_kernel_exec(unsigned long vaddr, int enable) { return 0;}
+ static inline int set_kernel_exec(void *vaddr, int enable) { return 0;}
 #endif
 
 #if defined(CONFIG_HIGHPTE)
diff -puN include/asm-i386/page.h~AA1-lookup_address-cousins-types include/asm-i386/page.h
diff -puN mm/slab.c~AA1-lookup_address-cousins-types mm/slab.c
diff -L mm/nonlinear.c -puN /dev/null /dev/null
diff -L mm/memory_hotplug.c -puN /dev/null /dev/null
diff -puN arch/i386/kernel/sysenter.c~AA1-lookup_address-cousins-types arch/i386/kernel/sysenter.c
diff -puN arch/i386/kernel/smpboot.c~AA1-lookup_address-cousins-types arch/i386/kernel/smpboot.c
--- memhotplug/arch/i386/kernel/smpboot.c~AA1-lookup_address-cousins-types	2004-08-25 11:53:58.000000000 -0700
+++ memhotplug-dave/arch/i386/kernel/smpboot.c	2004-08-25 11:53:58.000000000 -0700
@@ -122,7 +122,7 @@ void __init smp_alloc_memory(void)
 	/*
 	 * Make the SMP trampoline executable:
 	 */
-	trampoline_exec = set_kernel_exec((unsigned long)trampoline_base, 1);
+	trampoline_exec = set_kernel_exec(trampoline_base, 1);
 }
 
 /*
@@ -1249,7 +1249,7 @@ void __init smp_cpus_done(unsigned int m
 	/*
 	 * Disable executability of the SMP trampoline:
 	 */
-	set_kernel_exec((unsigned long)trampoline_base, trampoline_exec);
+	set_kernel_exec(trampoline_base, trampoline_exec);
 }
 
 void __init smp_intr_init(void)
_
