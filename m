Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262441AbSI2KR0>; Sun, 29 Sep 2002 06:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262442AbSI2KRZ>; Sun, 29 Sep 2002 06:17:25 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:29458 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S262441AbSI2KRW>; Sun, 29 Sep 2002 06:17:22 -0400
Date: Sun, 29 Sep 2002 12:22:39 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "David S. Miller" <davem@redhat.com>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: sparc32 sunrpc.o
Message-ID: <20020929102238.GD4323@louise.pinerecords.com>
References: <20020926.142910.124086325.davem@redhat.com> <20020928122817.GV27082@louise.pinerecords.com> <20020928161316.GA4323@louise.pinerecords.com> <20020928.232350.33317317.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020928.232350.33317317.davem@redhat.com>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    From: Tomas Szepe <szepe@pinerecords.com>
>    Date: Sat, 28 Sep 2002 18:13:16 +0200
> 
>    > Ok, DaveM, could you have a look at this patch?
>    
>    Please disregard, highmem.c unreasonably included linux/highmem.h.
>    I'll be looking into this some more.
>    
> Let us know when new working patch is available :-)

Right.  :)
This took a bit longer cos I had to leave for the night.

Patch against 2.4.20-pre8.

T.


diff -urN 2.4.20-pre8.vanilla/arch/sparc/kernel/sparc_ksyms.c linux-2.4.20-pre8/arch/sparc/kernel/sparc_ksyms.c
--- 2.4.20-pre8.vanilla/arch/sparc/kernel/sparc_ksyms.c	2002-08-03 06:12:08.000000000 +0200
+++ linux-2.4.20-pre8/arch/sparc/kernel/sparc_ksyms.c	2002-09-29 11:45:33.000000000 +0200
@@ -46,6 +46,9 @@
 #include <asm/sbus.h>
 #include <asm/dma.h>
 #endif
+#ifdef CONFIG_HIGHMEM
+#include <asm/highmem.h>
+#endif
 #include <asm/a.out.h>
 #include <asm/io-unit.h>
 
@@ -204,6 +207,12 @@
 EXPORT_SYMBOL(pci_dma_sync_single);
 #endif
 
+/* in arch/sparc/mm/highmem.c */
+#ifdef CONFIG_HIGHMEM
+EXPORT_SYMBOL(kmap_atomic);
+EXPORT_SYMBOL(kunmap_atomic);
+#endif
+
 /* Solaris/SunOS binary compatibility */
 EXPORT_SYMBOL(svr4_setcontext);
 EXPORT_SYMBOL(svr4_getcontext);
diff -urN 2.4.20-pre8.vanilla/arch/sparc/mm/Makefile linux-2.4.20-pre8/arch/sparc/mm/Makefile
--- 2.4.20-pre8.vanilla/arch/sparc/mm/Makefile	2000-12-29 23:07:21.000000000 +0100
+++ linux-2.4.20-pre8/arch/sparc/mm/Makefile	2002-09-29 11:45:33.000000000 +0200
@@ -11,7 +11,7 @@
 	$(CC) $(AFLAGS) -ansi -c -o $*.o $<
 
 O_TARGET := mm.o
-obj-y    := fault.o init.o loadmmu.o generic.o extable.o btfixup.o
+obj-y    := fault.o init.o loadmmu.o generic.o extable.o highmem.o btfixup.o
 
 ifeq ($(CONFIG_SUN4),y)
 obj-y	 += nosrmmu.o
diff -urN 2.4.20-pre8.vanilla/arch/sparc/mm/highmem.c linux-2.4.20-pre8/arch/sparc/mm/highmem.c
--- 2.4.20-pre8.vanilla/arch/sparc/mm/highmem.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.20-pre8/arch/sparc/mm/highmem.c	2002-09-29 11:46:38.000000000 +0200
@@ -0,0 +1,84 @@
+/*
+ *  highmem.c: virtual kernel memory mappings for high memory
+ *
+ *  Provides kernel-static versions of atomic kmap functions originally
+ *  found as inlines in include/asm-sparc/highmem.h.  These became
+ *  needed as kmap_atomic() and kunmap_atomic() started getting
+ *  called from within modules.
+ *  -- Tomas Szepe <szepe@pinerecords.com>, September 2002
+ */
+
+#include <linux/mm.h>
+#include <asm/highmem.h>
+#include <asm/pgalloc.h>
+
+/*
+ * The use of kmap_atomic/kunmap_atomic is discouraged -- kmap()/kunmap()
+ * gives a more generic (and caching) interface.  But kmap_atomic() can
+ * be used in IRQ contexts, so in some (very limited) cases we need it.
+ */
+void *kmap_atomic(struct page *page, enum km_type type)
+{
+	unsigned long idx;
+	unsigned long vaddr;
+
+	if (page < highmem_start_page)
+		return page_address(page);
+
+	idx = type + KM_TYPE_NR * smp_processor_id();
+	vaddr = fix_kmap_begin + idx * PAGE_SIZE;
+
+/* XXX Fix - Anton */
+#if 0
+	__flush_cache_one(vaddr);
+#else
+	flush_cache_all();
+#endif
+
+#if HIGHMEM_DEBUG
+	if (!pte_none(*(kmap_pte + idx)))
+		BUG();
+#endif
+	set_pte(kmap_pte + idx, mk_pte(page, kmap_prot));
+/* XXX Fix - Anton */
+#if 0
+	__flush_tlb_one(vaddr);
+#else
+	flush_tlb_all();
+#endif
+
+	return (void *) vaddr;
+}
+
+void kunmap_atomic(void *kvaddr, enum km_type type)
+{
+	unsigned long vaddr = (unsigned long) kvaddr;
+	unsigned long idx = type + KM_TYPE_NR * smp_processor_id();
+
+	if (vaddr < fix_kmap_begin) /* FIXME */
+		return;
+
+	if (vaddr != fix_kmap_begin + idx * PAGE_SIZE)
+		BUG();
+
+/* XXX Fix - Anton */
+#if 0
+	__flush_cache_one(vaddr);
+#else
+	flush_cache_all();
+#endif
+
+#ifdef HIGHMEM_DEBUG
+	/*
+	 *  Force other mappings to oops if they try to access
+	 *  this pte without first remapping it.
+	 */
+	pte_clear(kmap_pte + idx);
+/* XXX Fix - Anton */
+#if 0
+	__flush_tlb_one(vaddr);
+#else
+	flush_tlb_all();
+#endif
+#endif
+}
diff -urN 2.4.20-pre8.vanilla/include/asm-sparc/highmem.h linux-2.4.20-pre8/include/asm-sparc/highmem.h
--- 2.4.20-pre8.vanilla/include/asm-sparc/highmem.h	2002-09-29 11:36:45.000000000 +0200
+++ linux-2.4.20-pre8/include/asm-sparc/highmem.h	2002-09-29 11:48:13.000000000 +0200
@@ -29,6 +29,13 @@
 /* undef for production */
 #define HIGHMEM_DEBUG 1
 
+/* in mm/highmem.c */
+extern void *kmap_high(struct page *page);
+extern void kunmap_high(struct page *page);
+
+/* in mm/memory.c */
+extern struct page *highmem_start_page;
+
 /* declarations for highmem.c */
 extern unsigned long highstart_pfn, highend_pfn;
 
@@ -51,12 +58,13 @@
  */
 #define LAST_PKMAP 1024
 
-#define LAST_PKMAP_MASK (LAST_PKMAP - 1)
-#define PKMAP_NR(virt)  ((virt - pkmap_base) >> PAGE_SHIFT)
-#define PKMAP_ADDR(nr)  (pkmap_base + ((nr) << PAGE_SHIFT))
-
-extern void *kmap_high(struct page *page);
-extern void kunmap_high(struct page *page);
+#define LAST_PKMAP_MASK		(LAST_PKMAP - 1)
+#define PKMAP_NR(virt)		((virt - pkmap_base) >> PAGE_SHIFT)
+#define PKMAP_ADDR(nr)		(pkmap_base + ((nr) << PAGE_SHIFT))
+
+/* in arch/sparc/mm/highmem.c */
+void *kmap_atomic(struct page *page, enum km_type type);
+void kunmap_atomic(void *kvaddr, enum km_type type);
 
 static inline void *kmap(struct page *page)
 {
@@ -76,78 +84,6 @@
 	kunmap_high(page);
 }
 
-/*
- * The use of kmap_atomic/kunmap_atomic is discouraged - kmap/kunmap
- * gives a more generic (and caching) interface. But kmap_atomic can
- * be used in IRQ contexts, so in some (very limited) cases we need
- * it.
- */
-static inline void *kmap_atomic(struct page *page, enum km_type type)
-{
-	unsigned long idx;
-	unsigned long vaddr;
-
-	if (page < highmem_start_page)
-		return page_address(page);
-
-	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = fix_kmap_begin + idx * PAGE_SIZE;
-
-/* XXX Fix - Anton */
-#if 0
-	__flush_cache_one(vaddr);
-#else
-	flush_cache_all();
-#endif
-
-#if HIGHMEM_DEBUG
-	if (!pte_none(*(kmap_pte+idx)))
-		BUG();
-#endif
-	set_pte(kmap_pte+idx, mk_pte(page, kmap_prot));
-/* XXX Fix - Anton */
-#if 0
-	__flush_tlb_one(vaddr);
-#else
-	flush_tlb_all();
-#endif
-
-	return (void*) vaddr;
-}
-
-static inline void kunmap_atomic(void *kvaddr, enum km_type type)
-{
-	unsigned long vaddr = (unsigned long) kvaddr;
-	unsigned long idx = type + KM_TYPE_NR*smp_processor_id();
-
-	if (vaddr < fix_kmap_begin) // FIXME
-		return;
-
-	if (vaddr != fix_kmap_begin + idx * PAGE_SIZE)
-		BUG();
-
-/* XXX Fix - Anton */
-#if 0
-	__flush_cache_one(vaddr);
-#else
-	flush_cache_all();
-#endif
-
-#ifdef HIGHMEM_DEBUG
-	/*
-	 * force other mappings to Oops if they'll try to access
-	 * this pte without first remap it
-	 */
-	pte_clear(kmap_pte+idx);
-/* XXX Fix - Anton */
-#if 0
-	__flush_tlb_one(vaddr);
-#else
-	flush_tlb_all();
-#endif
-#endif
-}
-
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_HIGHMEM_H */
