Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261278AbSI1MXL>; Sat, 28 Sep 2002 08:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261286AbSI1MXL>; Sat, 28 Sep 2002 08:23:11 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:30224 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S261278AbSI1MXD>; Sat, 28 Sep 2002 08:23:03 -0400
Date: Sat, 28 Sep 2002 14:28:17 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "David S. Miller" <davem@redhat.com>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: sparc32 sunrpc.o
Message-ID: <20020928122817.GV27082@louise.pinerecords.com>
References: <mailman.1033072381.13688.linux-kernel2news@redhat.com> <200209262127.g8QLROv26197@devserv.devel.redhat.com> <20020926.142910.124086325.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020926.142910.124086325.davem@redhat.com>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    From: Pete Zaitcev <zaitcev@redhat.com>
>    Date: Thu, 26 Sep 2002 17:27:24 -0400
> 
>    > Since 2.4.20-pre2 or 3, sunrpc.o has had this problem on sparc32:
>    > 
>    > depmod: *** Unresolved symbols in /lib/modules/2.4.20-pre8/kernel/net/sunrpc/sunrpc.o
>    > depmod:         ___illegal_use_of_BTFIXUP_SETHI_in_module
>    > depmod:         ___f_set_pte
>    > depmod:         fix_kmap_begin
>    > depmod:         ___f_flush_cache_all
>    > depmod:         ___f_pte_clear
>    > depmod:         ___f_mk_pte
>    > depmod:         ___f_flush_tlb_all
>    
>    Try these two things:
>    
> No Peter, it really does use kmap_atomic stuff from modules, and this
> precludes providing those routines inline in highmem.h, they must
> live statically in main kernel image so that flush/pte calls can
> be properly BTFIXUP'd.
> 
> See my other email.

Ok, DaveM, could you have a look at this patch?

T.


diff -urN linux-2.4.20-pre8.vanilla/arch/sparc/kernel/sparc_ksyms.c linux-2.4.20-pre8/arch/sparc/kernel/sparc_ksyms.c
--- linux-2.4.20-pre8.vanilla/arch/sparc/kernel/sparc_ksyms.c	2002-08-03 06:12:08.000000000 +0200
+++ linux-2.4.20-pre8/arch/sparc/kernel/sparc_ksyms.c	2002-09-28 14:15:53.000000000 +0200
@@ -46,6 +46,9 @@
 #include <asm/sbus.h>
 #include <asm/dma.h>
 #endif
+#ifdef CONFIG_HIGHMEM
+#include <asm/highmem.h>
+#endif
 #include <asm/a.out.h>
 #include <asm/io-unit.h>
 
@@ -204,6 +207,14 @@
 EXPORT_SYMBOL(pci_dma_sync_single);
 #endif
 
+/* Highmem helpers from arch/sparc/mm/highmem.c */
+#ifdef CONFIG_HIGHMEM
+EXPORT_SYMBOL(kmap);
+EXPORT_SYMBOL(kunmap);
+EXPORT_SYMBOL(kmap_atomic);
+EXPORT_SYMBOL(kunmap_atomic);
+#endif
+
 /* Solaris/SunOS binary compatibility */
 EXPORT_SYMBOL(svr4_setcontext);
 EXPORT_SYMBOL(svr4_getcontext);
diff -urN linux-2.4.20-pre8.vanilla/arch/sparc/mm/Makefile linux-2.4.20-pre8/arch/sparc/mm/Makefile
--- linux-2.4.20-pre8.vanilla/arch/sparc/mm/Makefile	2000-12-29 23:07:21.000000000 +0100
+++ linux-2.4.20-pre8/arch/sparc/mm/Makefile	2002-09-28 13:33:55.000000000 +0200
@@ -11,7 +11,7 @@
 	$(CC) $(AFLAGS) -ansi -c -o $*.o $<
 
 O_TARGET := mm.o
-obj-y    := fault.o init.o loadmmu.o generic.o extable.o btfixup.o
+obj-y    := fault.o init.o loadmmu.o generic.o extable.o highmem.o btfixup.o
 
 ifeq ($(CONFIG_SUN4),y)
 obj-y	 += nosrmmu.o
diff -urN linux-2.4.20-pre8.vanilla/arch/sparc/mm/highmem.c linux-2.4.20-pre8/arch/sparc/mm/highmem.c
--- linux-2.4.20-pre8.vanilla/arch/sparc/mm/highmem.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.20-pre8/arch/sparc/mm/highmem.c	2002-09-28 13:56:56.000000000 +0200
@@ -0,0 +1,101 @@
+/*
+ *  highmem.c: virtual kernel memory mappings for high memory
+ *
+ *  Uninlined versions of kmap(), kunmap(), kmap_atomic(),
+ *  and kunmap_atomic() split from include/asm-sparc/highmem.h.
+ *  -- Tomas Szepe <szepe@pinerecords.com>, September 2002
+ */
+
+#include <linux/mm.h>
+#include <linux/highmem.h>
+#include <asm/highmem.h>
+
+void *kmap(struct page *page)
+{
+	if (in_interrupt())
+		BUG();
+	if (page < highmem_start_page)
+		return page_address(page);
+	return kmap_high(page);
+}
+
+void kunmap(struct page *page)
+{
+	if (in_interrupt())
+		BUG();
+	if (page < highmem_start_page)
+		return;
+	kunmap_high(page);
+}
+
+/*
+ * The use of kmap_atomic/kunmap_atomic is discouraged - kmap/kunmap
+ * gives a more generic (and caching) interface. But kmap_atomic can
+ * be used in IRQ contexts, so in some (very limited) cases we need
+ * it.
+ */
+void *kmap_atomic(struct page *page, enum km_type type)
+{
+	unsigned long idx;
+	unsigned long vaddr;
+
+	if (page < highmem_start_page)
+		return page_address(page);
+
+	idx = type + KM_TYPE_NR*smp_processor_id();
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
+	if (!pte_none(*(kmap_pte+idx)))
+		BUG();
+#endif
+	set_pte(kmap_pte+idx, mk_pte(page, kmap_prot));
+/* XXX Fix - Anton */
+#if 0
+	__flush_tlb_one(vaddr);
+#else
+	flush_tlb_all();
+#endif
+
+	return (void*) vaddr;
+}
+
+void kunmap_atomic(void *kvaddr, enum km_type type)
+{
+	unsigned long vaddr = (unsigned long) kvaddr;
+	unsigned long idx = type + KM_TYPE_NR*smp_processor_id();
+
+	if (vaddr < fix_kmap_begin) // FIXME
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
+	 * force other mappings to Oops if they'll try to access
+	 * this pte without first remap it
+	 */
+	pte_clear(kmap_pte+idx);
+/* XXX Fix - Anton */
+#if 0
+	__flush_tlb_one(vaddr);
+#else
+	flush_tlb_all();
+#endif
+#endif
+}
diff -urN linux-2.4.20-pre8.vanilla/include/asm-sparc/highmem.h linux-2.4.20-pre8/include/asm-sparc/highmem.h
--- linux-2.4.20-pre8.vanilla/include/asm-sparc/highmem.h	2002-09-28 14:18:17.000000000 +0200
+++ linux-2.4.20-pre8/include/asm-sparc/highmem.h	2002-09-28 14:10:12.000000000 +0200
@@ -29,6 +29,10 @@
 /* undef for production */
 #define HIGHMEM_DEBUG 1
 
+/* in mm/highmem.c */
+extern void *kmap_high(struct page *page);
+extern void kunmap_high(struct page *page);
+
 /* declarations for highmem.c */
 extern unsigned long highstart_pfn, highend_pfn;
 
@@ -55,98 +59,11 @@
 #define PKMAP_NR(virt)  ((virt - pkmap_base) >> PAGE_SHIFT)
 #define PKMAP_ADDR(nr)  (pkmap_base + ((nr) << PAGE_SHIFT))
 
-extern void *kmap_high(struct page *page);
-extern void kunmap_high(struct page *page);
-
-static inline void *kmap(struct page *page)
-{
-	if (in_interrupt())
-		BUG();
-	if (page < highmem_start_page)
-		return page_address(page);
-	return kmap_high(page);
-}
-
-static inline void kunmap(struct page *page)
-{
-	if (in_interrupt())
-		BUG();
-	if (page < highmem_start_page)
-		return;
-	kunmap_high(page);
-}
-
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
+/* in arch/sparc/mm/highmem.c */
+void *kmap(struct page *page);
+void kunmap(struct page *page);
+void *kmap_atomic(struct page *page, enum km_type type);
+void kunmap_atomic(void *kvaddr, enum km_type type);
 
 #endif /* __KERNEL__ */
 
