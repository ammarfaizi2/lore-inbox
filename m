Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbUJZUC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbUJZUC0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 16:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbUJZUCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 16:02:25 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:18140 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261438AbUJZT45
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 15:56:57 -0400
Subject: [RFC] remove highmem_start_page
From: Dave Hansen <haveblue@us.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-mm <linux-mm@kvack.org>
Content-Type: multipart/mixed; boundary="=-QiseMkRex7/rVSy8faXT"
Message-Id: <1098820614.5633.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 26 Oct 2004 12:56:54 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QiseMkRex7/rVSy8faXT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

People love to do comparisons with highmem_start_page.  However, where
CONFIG_HIGHMEM=y and there is no actual highmem, there's no real page
at *highmem_start_page.

That's usually not a problem, but CONFIG_NONLINEAR is a bit more strict
and catches the bogus address tranlations.

There are about a gillion different ways to find out of a 'struct page'
is highmem or not.  Why not just check page_flags?

Declare page_is_highmem() and use it wherever there used to be a
highmem_start_page comparison.  Then, kill off highmem_start_page.

 memhotplug-dave/arch/i386/mm/discontig.c    |    4 ----
 memhotplug-dave/arch/i386/mm/highmem.c      |    6 +++---
 memhotplug-dave/arch/i386/mm/init.c         |    1 -
 memhotplug-dave/arch/i386/mm/pageattr.c     |    5 +----
 memhotplug-dave/arch/mips/mm/highmem.c      |    6 +++---
 memhotplug-dave/arch/mips/mm/init.c         |    1 -
 memhotplug-dave/arch/ppc/mm/init.c          |    1 -
 memhotplug-dave/arch/sparc/mm/highmem.c     |    2 +-
 memhotplug-dave/arch/sparc/mm/init.c        |    2 --
 memhotplug-dave/arch/um/kernel/mem.c        |    5 -----
 memhotplug-dave/include/asm-ppc/highmem.h   |    6 +++---
 memhotplug-dave/include/asm-sparc/highmem.h |    4 ++--
 memhotplug-dave/include/linux/highmem.h     |   12 ++++++++++--
 memhotplug-dave/mm/memory.c                 |    2 --
 memhotplug-dave/net/core/dev.c              |    2 +-
 15 files changed, 24 insertions(+), 35 deletions(-)

-- Dave

--=-QiseMkRex7/rVSy8faXT
Content-Disposition: attachment; filename=A1-no-highmem-mess.patch
Content-Type: text/x-patch; name=A1-no-highmem-mess.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit


People love to do comparisons with highmem_start_page.  However, where
CONFIG_HIGHMEM=y and there is no actual highmem, there's no real page
at *highmem_start_page.

That's usually not a problem, but CONFIG_NONLINEAR is a bit more strict
and catches the bogus address tranlations.  

There are about a gillion different ways to find out of a 'struct page'
is highmem or not.  Why not just check page_flags?

Declare page_is_highmem() and use it wherever there used to be a 
highmem_start_page comparison.  Then, kill off highmem_start_page.

This removes more code than it adds, and gets rid of some nasty 
#ifdefs in .c files.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/arch/i386/mm/discontig.c    |    4 ----
 memhotplug-dave/arch/i386/mm/highmem.c      |    6 +++---
 memhotplug-dave/arch/i386/mm/init.c         |    1 -
 memhotplug-dave/arch/i386/mm/pageattr.c     |    5 +----
 memhotplug-dave/arch/mips/mm/highmem.c      |    6 +++---
 memhotplug-dave/arch/mips/mm/init.c         |    1 -
 memhotplug-dave/arch/ppc/mm/init.c          |    1 -
 memhotplug-dave/arch/sparc/mm/highmem.c     |    2 +-
 memhotplug-dave/arch/sparc/mm/init.c        |    2 --
 memhotplug-dave/arch/um/kernel/mem.c        |    5 -----
 memhotplug-dave/include/asm-ppc/highmem.h   |    6 +++---
 memhotplug-dave/include/asm-sparc/highmem.h |    4 ++--
 memhotplug-dave/include/linux/highmem.h     |   12 ++++++++++--
 memhotplug-dave/mm/memory.c                 |    2 --
 memhotplug-dave/net/core/dev.c              |    2 +-
 15 files changed, 24 insertions(+), 35 deletions(-)

diff -puN arch/i386/lib/kgdb_serial.c~A1-no-highmem-mess arch/i386/lib/kgdb_serial.c
diff -puN arch/i386/mm/discontig.c~A1-no-highmem-mess arch/i386/mm/discontig.c
--- memhotplug/arch/i386/mm/discontig.c~A1-no-highmem-mess	2004-10-26 12:50:02.000000000 -0700
+++ memhotplug-dave/arch/i386/mm/discontig.c	2004-10-26 12:50:02.000000000 -0700
@@ -465,10 +465,6 @@ void __init set_max_mapnr_init(void)
 {
 #ifdef CONFIG_HIGHMEM
 	struct zone *high0 = &NODE_DATA(0)->node_zones[ZONE_HIGHMEM];
-	if (high0->spanned_pages > 0)
-	      	highmem_start_page = high0->zone_mem_map;
-	else
-		highmem_start_page = pfn_to_page(max_low_pfn+1); 
 	num_physpages = highend_pfn;
 #else
 	num_physpages = max_low_pfn;
diff -puN arch/mips/mm/highmem.c~A1-no-highmem-mess arch/mips/mm/highmem.c
--- memhotplug/arch/mips/mm/highmem.c~A1-no-highmem-mess	2004-10-26 12:50:02.000000000 -0700
+++ memhotplug-dave/arch/mips/mm/highmem.c	2004-10-26 12:50:02.000000000 -0700
@@ -8,7 +8,7 @@ void *__kmap(struct page *page)
 	void *addr;
 
 	might_sleep();
-	if (page < highmem_start_page)
+	if (!page_is_highmem(page))
 		return page_address(page);
 	addr = kmap_high(page);
 	flush_tlb_one((unsigned long)addr);
@@ -20,7 +20,7 @@ void __kunmap(struct page *page)
 {
 	if (in_interrupt())
 		BUG();
-	if (page < highmem_start_page)
+	if (!page_is_highmem(page))
 		return;
 	kunmap_high(page);
 }
@@ -41,7 +41,7 @@ void *__kmap_atomic(struct page *page, e
 
 	/* even !CONFIG_PREEMPT needs this, for in_atomic in do_page_fault */
 	inc_preempt_count();
-	if (page < highmem_start_page)
+	if (!page_is_highmem(page))
 		return page_address(page);
 
 	idx = type + KM_TYPE_NR*smp_processor_id();
diff -puN arch/um/kernel/mem.c~A1-no-highmem-mess arch/um/kernel/mem.c
--- memhotplug/arch/um/kernel/mem.c~A1-no-highmem-mess	2004-10-26 12:50:02.000000000 -0700
+++ memhotplug-dave/arch/um/kernel/mem.c	2004-10-26 12:50:02.000000000 -0700
@@ -49,8 +49,6 @@ static void setup_highmem(unsigned long 
 	unsigned long highmem_pfn;
 	int i;
 
-	highmem_start_page = virt_to_page(highmem_start);
-
 	highmem_pfn = __pa(highmem_start) >> PAGE_SHIFT;
 	for(i = 0; i < highmem_len >> PAGE_SHIFT; i++){
 		page = &mem_map[highmem_pfn + i];
@@ -67,9 +65,6 @@ void mem_init(void)
 	unsigned long start;
 
 	max_low_pfn = (high_physmem - uml_physmem) >> PAGE_SHIFT;
-#ifdef CONFIG_HIGHMEM
-	highmem_start_page = phys_page(__pa(high_physmem));
-#endif
 
         /* clear the zero-page */
         memset((void *) empty_zero_page, 0, PAGE_SIZE);
diff -puN include/asm-sparc/highmem.h~A1-no-highmem-mess include/asm-sparc/highmem.h
--- memhotplug/include/asm-sparc/highmem.h~A1-no-highmem-mess	2004-10-26 12:50:02.000000000 -0700
+++ memhotplug-dave/include/asm-sparc/highmem.h	2004-10-26 12:50:02.000000000 -0700
@@ -57,7 +57,7 @@ extern void kunmap_high(struct page *pag
 static inline void *kmap(struct page *page)
 {
 	BUG_ON(in_interrupt());
-	if (page < highmem_start_page)
+	if (!page_is_highmem(page))
 		return page_address(page);
 	return kmap_high(page);
 }
@@ -65,7 +65,7 @@ static inline void *kmap(struct page *pa
 static inline void kunmap(struct page *page)
 {
 	BUG_ON(in_interrupt());
-	if (page < highmem_start_page)
+	if (!page_is_highmem(page))
 		return;
 	kunmap_high(page);
 }
diff -puN include/linux/highmem.h~A1-no-highmem-mess include/linux/highmem.h
--- memhotplug/include/linux/highmem.h~A1-no-highmem-mess	2004-10-26 12:50:02.000000000 -0700
+++ memhotplug-dave/include/linux/highmem.h	2004-10-26 12:53:28.000000000 -0700
@@ -9,13 +9,16 @@
 
 #ifdef CONFIG_HIGHMEM
 
-extern struct page *highmem_start_page;
-
 #include <asm/highmem.h>
 
 /* declarations for linux/mm/highmem.c */
 unsigned int nr_free_highpages(void);
 
+static inline int page_is_highmem(struct page *page)
+{
+	return PageHighMem(page);
+}
+
 #else /* CONFIG_HIGHMEM */
 
 static inline unsigned int nr_free_highpages(void) { return 0; }
@@ -33,6 +36,11 @@ static inline void *kmap(struct page *pa
 #define kmap_atomic_pfn(pfn, idx)	page_address(pfn_to_page(pfn))
 #define kmap_atomic_to_page(ptr)	virt_to_page(ptr)
 
+static inline int page_is_highmem(struct page *page)
+{
+	return 0;
+}
+
 #endif /* CONFIG_HIGHMEM */
 
 /* when CONFIG_HIGHMEM is not set these will be plain clear/copy_page */
diff -puN net/core/dev.c~A1-no-highmem-mess net/core/dev.c
--- memhotplug/net/core/dev.c~A1-no-highmem-mess	2004-10-26 12:50:02.000000000 -0700
+++ memhotplug-dave/net/core/dev.c	2004-10-26 12:50:02.000000000 -0700
@@ -1152,7 +1152,7 @@ static inline int illegal_highdma(struct
 		return 0;
 
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
-		if (skb_shinfo(skb)->frags[i].page >= highmem_start_page)
+		if (page_is_highmem(skb_shinfo(skb)->frags[i].page))
 			return 1;
 
 	return 0;
diff -puN arch/sparc/mm/highmem.c~A1-no-highmem-mess arch/sparc/mm/highmem.c
--- memhotplug/arch/sparc/mm/highmem.c~A1-no-highmem-mess	2004-10-26 12:50:02.000000000 -0700
+++ memhotplug-dave/arch/sparc/mm/highmem.c	2004-10-26 12:50:02.000000000 -0700
@@ -36,7 +36,7 @@ void *kmap_atomic(struct page *page, enu
 
 	/* even !CONFIG_PREEMPT needs this, for in_atomic in do_page_fault */
 	inc_preempt_count();
-	if (page < highmem_start_page)
+	if (!page_is_highmem(page))
 		return page_address(page);
 
 	idx = type + KM_TYPE_NR*smp_processor_id();
diff -puN arch/sparc/mm/init.c~A1-no-highmem-mess arch/sparc/mm/init.c
--- memhotplug/arch/sparc/mm/init.c~A1-no-highmem-mess	2004-10-26 12:50:02.000000000 -0700
+++ memhotplug-dave/arch/sparc/mm/init.c	2004-10-26 12:50:02.000000000 -0700
@@ -402,8 +402,6 @@ void __init mem_init(void)
 	int reservedpages = 0;
 	int i;
 
-	highmem_start_page = pfn_to_page(highstart_pfn);
-
 	if (PKMAP_BASE+LAST_PKMAP*PAGE_SIZE >= FIXADDR_START) {
 		prom_printf("BUG: fixmap and pkmap areas overlap\n");
 		prom_printf("pkbase: 0x%lx pkend: 0x%lx fixstart 0x%lx\n",
diff -puN arch/ppc/mm/init.c~A1-no-highmem-mess arch/ppc/mm/init.c
--- memhotplug/arch/ppc/mm/init.c~A1-no-highmem-mess	2004-10-26 12:50:02.000000000 -0700
+++ memhotplug-dave/arch/ppc/mm/init.c	2004-10-26 12:50:02.000000000 -0700
@@ -411,7 +411,6 @@ void __init mem_init(void)
 	unsigned long highmem_mapnr;
 
 	highmem_mapnr = total_lowmem >> PAGE_SHIFT;
-	highmem_start_page = mem_map + highmem_mapnr;
 #endif /* CONFIG_HIGHMEM */
 	max_mapnr = total_memory >> PAGE_SHIFT;
 
diff -puN arch/i386/mm/pageattr.c~A1-no-highmem-mess arch/i386/mm/pageattr.c
--- memhotplug/arch/i386/mm/pageattr.c~A1-no-highmem-mess	2004-10-26 12:50:02.000000000 -0700
+++ memhotplug-dave/arch/i386/mm/pageattr.c	2004-10-26 12:50:02.000000000 -0700
@@ -105,10 +105,7 @@ __change_page_attr(struct page *page, pg
 	unsigned long address;
 	struct page *kpte_page;
 
-#ifdef CONFIG_HIGHMEM
-	if (page >= highmem_start_page) 
-		BUG(); 
-#endif
+	BUG_ON(page_is_highmem(page));
 	address = (unsigned long)page_address(page);
 
 	kpte = lookup_address(address);
diff -puN arch/i386/mm/highmem.c~A1-no-highmem-mess arch/i386/mm/highmem.c
--- memhotplug/arch/i386/mm/highmem.c~A1-no-highmem-mess	2004-10-26 12:50:02.000000000 -0700
+++ memhotplug-dave/arch/i386/mm/highmem.c	2004-10-26 12:50:02.000000000 -0700
@@ -3,7 +3,7 @@
 void *kmap(struct page *page)
 {
 	might_sleep();
-	if (page < highmem_start_page)
+	if (!page_is_highmem(page))
 		return page_address(page);
 	return kmap_high(page);
 }
@@ -12,7 +12,7 @@ void kunmap(struct page *page)
 {
 	if (in_interrupt())
 		BUG();
-	if (page < highmem_start_page)
+	if (!page_is_highmem(page))
 		return;
 	kunmap_high(page);
 }
@@ -32,7 +32,7 @@ void *kmap_atomic(struct page *page, enu
 
 	/* even !CONFIG_PREEMPT needs this, for in_atomic in do_page_fault */
 	inc_preempt_count();
-	if (page < highmem_start_page)
+	if (!page_is_highmem(page))
 		return page_address(page);
 
 	idx = type + KM_TYPE_NR*smp_processor_id();
diff -puN arch/mips/mm/init.c~A1-no-highmem-mess arch/mips/mm/init.c
--- memhotplug/arch/mips/mm/init.c~A1-no-highmem-mess	2004-10-26 12:50:02.000000000 -0700
+++ memhotplug-dave/arch/mips/mm/init.c	2004-10-26 12:50:02.000000000 -0700
@@ -204,7 +204,6 @@ void __init mem_init(void)
 	unsigned long tmp, ram;
 
 #ifdef CONFIG_HIGHMEM
-	highmem_start_page = mem_map + highstart_pfn;
 #ifdef CONFIG_DISCONTIGMEM
 #error "CONFIG_HIGHMEM and CONFIG_DISCONTIGMEM dont work together yet"
 #endif
diff -puN include/asm-ppc/highmem.h~A1-no-highmem-mess include/asm-ppc/highmem.h
--- memhotplug/include/asm-ppc/highmem.h~A1-no-highmem-mess	2004-10-26 12:50:02.000000000 -0700
+++ memhotplug-dave/include/asm-ppc/highmem.h	2004-10-26 12:50:02.000000000 -0700
@@ -56,7 +56,7 @@ extern void kunmap_high(struct page *pag
 static inline void *kmap(struct page *page)
 {
 	might_sleep();
-	if (page < highmem_start_page)
+	if (!page_is_highmem(page))
 		return page_address(page);
 	return kmap_high(page);
 }
@@ -64,7 +64,7 @@ static inline void *kmap(struct page *pa
 static inline void kunmap(struct page *page)
 {
 	BUG_ON(in_interrupt());
-	if (page < highmem_start_page)
+	if (!page_is_highmem(page))
 		return;
 	kunmap_high(page);
 }
@@ -82,7 +82,7 @@ static inline void *kmap_atomic(struct p
 
 	/* even !CONFIG_PREEMPT needs this, for in_atomic in do_page_fault */
 	inc_preempt_count();
-	if (page < highmem_start_page)
+	if (!page_is_highmem(page))
 		return page_address(page);
 
 	idx = type + KM_TYPE_NR*smp_processor_id();
diff -puN mm/memory.c~A1-no-highmem-mess mm/memory.c
--- memhotplug/mm/memory.c~A1-no-highmem-mess	2004-10-26 12:50:02.000000000 -0700
+++ memhotplug-dave/mm/memory.c	2004-10-26 12:50:02.000000000 -0700
@@ -74,11 +74,9 @@ unsigned long num_physpages;
  * and ZONE_HIGHMEM.
  */
 void * high_memory;
-struct page *highmem_start_page;
 unsigned long vmalloc_earlyreserve;
 
 EXPORT_SYMBOL(num_physpages);
-EXPORT_SYMBOL(highmem_start_page);
 EXPORT_SYMBOL(high_memory);
 EXPORT_SYMBOL(vmalloc_earlyreserve);
 
diff -puN arch/i386/mm/init.c~A1-no-highmem-mess arch/i386/mm/init.c
--- memhotplug/arch/i386/mm/init.c~A1-no-highmem-mess	2004-10-26 12:50:02.000000000 -0700
+++ memhotplug-dave/arch/i386/mm/init.c	2004-10-26 12:50:02.000000000 -0700
@@ -568,7 +568,6 @@ void __init test_wp_bit(void)
 static void __init set_max_mapnr_init(void)
 {
 #ifdef CONFIG_HIGHMEM
-	highmem_start_page = pfn_to_page(highstart_pfn);
 	max_mapnr = num_physpages = highend_pfn;
 #else
 	max_mapnr = num_physpages = max_low_pfn;
_

--=-QiseMkRex7/rVSy8faXT--

