Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVBGTfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVBGTfq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 14:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVBGTfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 14:35:46 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:4023 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261263AbVBGTbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 14:31:25 -0500
Date: Mon, 7 Feb 2005 11:31:21 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: akpm@osdl.org
cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: prezeroing V6 [1/3]: clear_pages
In-Reply-To: <Pine.LNX.4.58.0502071127470.27951@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0502071130520.27951@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0501211228430.26068@schroedinger.engr.sgi.com>
 <1106828124.19262.45.camel@hades.cambridge.redhat.com> <20050202153256.GA19615@logos.cnet>
 <Pine.LNX.4.58.0502071127470.27951@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The zeroing of a page of a arbitrary order in page_alloc.c and in hugetlb.c
is currently done one page at a time. It may be beneficial to
zero large areas of memory in one go. The following patch introduces
clear_pages that takes an additional order parameter. clear_pages is only used
when __HAVE_ARCH_CLEAR_PAGES has been defined by an architecture.

clear_pages functions have been provided for ia64, i386, sparc64 and x86_64.
This version was tested by me on ia64, i386 and x86_64.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.10/mm/page_alloc.c
===================================================================
--- linux-2.6.10.orig/mm/page_alloc.c	2005-02-03 22:51:57.000000000 -0800
+++ linux-2.6.10/mm/page_alloc.c	2005-02-07 11:04:32.000000000 -0800
@@ -599,11 +599,19 @@ void fastcall free_cold_page(struct page
 	free_hot_cold_page(page, 1);
 }

-static inline void prep_zero_page(struct page *page, int order, int gfp_flags)
+void prep_zero_page(struct page *page, unsigned int order, unsigned int gfp_flags)
 {
 	int i;

 	BUG_ON((gfp_flags & (__GFP_WAIT | __GFP_HIGHMEM)) == __GFP_HIGHMEM);
+
+#ifdef __HAVE_ARCH_CLEAR_PAGES
+	if (!PageHighMem(page)) {
+		clear_pages(page_address(page), order);
+		return;
+	}
+#endif
+
 	for(i = 0; i < (1 << order); i++)
 		clear_highpage(page + i);
 }
Index: linux-2.6.10/mm/hugetlb.c
===================================================================
--- linux-2.6.10.orig/mm/hugetlb.c	2005-02-03 22:51:56.000000000 -0800
+++ linux-2.6.10/mm/hugetlb.c	2005-02-07 11:04:32.000000000 -0800
@@ -78,7 +78,6 @@ void free_huge_page(struct page *page)
 struct page *alloc_huge_page(void)
 {
 	struct page *page;
-	int i;

 	spin_lock(&hugetlb_lock);
 	page = dequeue_huge_page();
@@ -89,8 +88,7 @@ struct page *alloc_huge_page(void)
 	spin_unlock(&hugetlb_lock);
 	set_page_count(page, 1);
 	page[1].mapping = (void *)free_huge_page;
-	for (i = 0; i < (HPAGE_SIZE/PAGE_SIZE); ++i)
-		clear_highpage(&page[i]);
+	prep_zero_page(page, HUGETLB_PAGE_ORDER, GFP_HIGHUSER);
 	return page;
 }

Index: linux-2.6.10/include/asm-ia64/page.h
===================================================================
--- linux-2.6.10.orig/include/asm-ia64/page.h	2005-02-03 22:51:35.000000000 -0800
+++ linux-2.6.10/include/asm-ia64/page.h	2005-02-07 11:04:32.000000000 -0800
@@ -56,8 +56,10 @@
 # ifdef __KERNEL__
 #  define STRICT_MM_TYPECHECKS

-extern void clear_page (void *page);
+extern void clear_pages (void *page, int order);
 extern void copy_page (void *to, void *from);
+#define clear_page(__page) clear_pages(__page, 0)
+#define __HAVE_ARCH_CLEAR_PAGES

 /*
  * clear_user_page() and copy_user_page() can't be inline functions because
Index: linux-2.6.10/arch/ia64/kernel/ia64_ksyms.c
===================================================================
--- linux-2.6.10.orig/arch/ia64/kernel/ia64_ksyms.c	2005-02-03 22:49:31.000000000 -0800
+++ linux-2.6.10/arch/ia64/kernel/ia64_ksyms.c	2005-02-07 11:04:32.000000000 -0800
@@ -38,7 +38,7 @@ EXPORT_SYMBOL(__down_trylock);
 EXPORT_SYMBOL(__up);

 #include <asm/page.h>
-EXPORT_SYMBOL(clear_page);
+EXPORT_SYMBOL(clear_pages);

 #ifdef CONFIG_VIRTUAL_MEM_MAP
 #include <linux/bootmem.h>
Index: linux-2.6.10/arch/ia64/lib/clear_page.S
===================================================================
--- linux-2.6.10.orig/arch/ia64/lib/clear_page.S	2004-12-24 13:33:50.000000000 -0800
+++ linux-2.6.10/arch/ia64/lib/clear_page.S	2005-02-07 11:04:32.000000000 -0800
@@ -7,6 +7,7 @@
  * 1/06/01 davidm	Tuned for Itanium.
  * 2/12/02 kchen	Tuned for both Itanium and McKinley
  * 3/08/02 davidm	Some more tweaking
+ * 12/10/04 clameter	Make it work on pages of order size
  */
 #include <linux/config.h>

@@ -29,27 +30,33 @@
 #define dst4		r11

 #define dst_last	r31
+#define totsize		r14

-GLOBAL_ENTRY(clear_page)
+GLOBAL_ENTRY(clear_pages)
 	.prologue
-	.regstk 1,0,0,0
-	mov r16 = PAGE_SIZE/L3_LINE_SIZE-1	// main loop count, -1=repeat/until
+	.regstk 2,0,0,0
+	mov r16 = PAGE_SIZE/L3_LINE_SIZE	// main loop count
+	mov totsize = PAGE_SIZE
 	.save ar.lc, saved_lc
 	mov saved_lc = ar.lc
-
+	;;
 	.body
+	adds dst1 = 16, in0
 	mov ar.lc = (PREFETCH_LINES - 1)
 	mov dst_fetch = in0
-	adds dst1 = 16, in0
 	adds dst2 = 32, in0
+	shl r16 = r16, in1
+	shl totsize = totsize, in1
 	;;
 .fetch:	stf.spill.nta [dst_fetch] = f0, L3_LINE_SIZE
 	adds dst3 = 48, in0		// executing this multiple times is harmless
 	br.cloop.sptk.few .fetch
+	add r16 = -1,r16
+	add dst_last = totsize, dst_fetch
+	adds dst4 = 64, in0
 	;;
-	addl dst_last = (PAGE_SIZE - PREFETCH_LINES*L3_LINE_SIZE), dst_fetch
 	mov ar.lc = r16			// one L3 line per iteration
-	adds dst4 = 64, in0
+	adds dst_last = -PREFETCH_LINES*L3_LINE_SIZE, dst_last
 	;;
 #ifdef CONFIG_ITANIUM
 	// Optimized for Itanium
@@ -74,4 +81,4 @@ GLOBAL_ENTRY(clear_page)
 	;;
 	mov ar.lc = saved_lc		// restore lc
 	br.ret.sptk.many rp
-END(clear_page)
+END(clear_pages)
Index: linux-2.6.10/include/asm-i386/page.h
===================================================================
--- linux-2.6.10.orig/include/asm-i386/page.h	2005-02-03 22:51:34.000000000 -0800
+++ linux-2.6.10/include/asm-i386/page.h	2005-02-07 11:04:32.000000000 -0800
@@ -18,7 +18,7 @@

 #include <asm/mmx.h>

-#define clear_page(page)	mmx_clear_page((void *)(page))
+#define clear_pages(page, order)	mmx_clear_page((void *)(page),order)
 #define copy_page(to,from)	mmx_copy_page(to,from)

 #else
@@ -28,11 +28,13 @@
  *	Maybe the K6-III ?
  */

-#define clear_page(page)	memset((void *)(page), 0, PAGE_SIZE)
+#define clear_pages(page, order)	memset((void *)(page), 0, PAGE_SIZE << (order))
 #define copy_page(to,from)	memcpy((void *)(to), (void *)(from), PAGE_SIZE)

 #endif

+#define __HAVE_ARCH_CLEAR_PAGES
+#define clear_page(page) clear_pages(page, 0)
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)

Index: linux-2.6.10/include/asm-i386/mmx.h
===================================================================
--- linux-2.6.10.orig/include/asm-i386/mmx.h	2004-12-24 13:34:57.000000000 -0800
+++ linux-2.6.10/include/asm-i386/mmx.h	2005-02-07 11:04:32.000000000 -0800
@@ -8,7 +8,7 @@
 #include <linux/types.h>

 extern void *_mmx_memcpy(void *to, const void *from, size_t size);
-extern void mmx_clear_page(void *page);
+extern void mmx_clear_page(void *page, int order);
 extern void mmx_copy_page(void *to, void *from);

 #endif
Index: linux-2.6.10/arch/i386/lib/mmx.c
===================================================================
--- linux-2.6.10.orig/arch/i386/lib/mmx.c	2004-12-24 13:34:48.000000000 -0800
+++ linux-2.6.10/arch/i386/lib/mmx.c	2005-02-07 11:04:32.000000000 -0800
@@ -128,7 +128,7 @@ void *_mmx_memcpy(void *to, const void *
  *	other MMX using processors do not.
  */

-static void fast_clear_page(void *page)
+static void fast_clear_page(void *page, int order)
 {
 	int i;

@@ -138,7 +138,7 @@ static void fast_clear_page(void *page)
 		"  pxor %%mm0, %%mm0\n" : :
 	);

-	for(i=0;i<4096/64;i++)
+	for(i=0;i<((4096/64) << order);i++)
 	{
 		__asm__ __volatile__ (
 		"  movntq %%mm0, (%0)\n"
@@ -257,7 +257,7 @@ static void fast_copy_page(void *to, voi
  *	Generic MMX implementation without K7 specific streaming
  */

-static void fast_clear_page(void *page)
+static void fast_clear_page(void *page, int order)
 {
 	int i;

@@ -267,7 +267,7 @@ static void fast_clear_page(void *page)
 		"  pxor %%mm0, %%mm0\n" : :
 	);

-	for(i=0;i<4096/128;i++)
+	for(i=0;i<((4096/128) << order);i++)
 	{
 		__asm__ __volatile__ (
 		"  movq %%mm0, (%0)\n"
@@ -359,23 +359,23 @@ static void fast_copy_page(void *to, voi
  *	Favour MMX for page clear and copy.
  */

-static void slow_zero_page(void * page)
+static void slow_clear_page(void * page, int order)
 {
 	int d0, d1;
 	__asm__ __volatile__( \
 		"cld\n\t" \
 		"rep ; stosl" \
 		: "=&c" (d0), "=&D" (d1)
-		:"a" (0),"1" (page),"0" (1024)
+		:"a" (0),"1" (page),"0" (1024 << order)
 		:"memory");
 }
-
-void mmx_clear_page(void * page)
+
+void mmx_clear_page(void * page, int order)
 {
 	if(unlikely(in_interrupt()))
-		slow_zero_page(page);
+		slow_clear_page(page, order);
 	else
-		fast_clear_page(page);
+		fast_clear_page(page, order);
 }

 static void slow_copy_page(void *to, void *from)
Index: linux-2.6.10/include/asm-x86_64/page.h
===================================================================
--- linux-2.6.10.orig/include/asm-x86_64/page.h	2005-02-03 22:51:46.000000000 -0800
+++ linux-2.6.10/include/asm-x86_64/page.h	2005-02-07 11:04:32.000000000 -0800
@@ -32,8 +32,10 @@
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__

-void clear_page(void *);
+void clear_pages(void *, int);
 void copy_page(void *, void *);
+#define __HAVE_ARCH_CLEAR_PAGES
+#define clear_page(__page) clear_pages(__page, 0)

 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
Index: linux-2.6.10/arch/x86_64/kernel/x8664_ksyms.c
===================================================================
--- linux-2.6.10.orig/arch/x86_64/kernel/x8664_ksyms.c	2005-02-03 22:50:03.000000000 -0800
+++ linux-2.6.10/arch/x86_64/kernel/x8664_ksyms.c	2005-02-07 11:04:32.000000000 -0800
@@ -108,7 +108,7 @@ EXPORT_SYMBOL(pci_mem_start);
 #endif

 EXPORT_SYMBOL(copy_page);
-EXPORT_SYMBOL(clear_page);
+EXPORT_SYMBOL(clear_pages);

 EXPORT_SYMBOL(cpu_pda);
 #ifdef CONFIG_SMP
Index: linux-2.6.10/arch/x86_64/lib/clear_page.S
===================================================================
--- linux-2.6.10.orig/arch/x86_64/lib/clear_page.S	2004-12-24 13:34:33.000000000 -0800
+++ linux-2.6.10/arch/x86_64/lib/clear_page.S	2005-02-07 11:04:32.000000000 -0800
@@ -1,12 +1,16 @@
 /*
  * Zero a page.
  * rdi	page
+ * rsi	order
  */
-	.globl clear_page
+	.globl clear_pages
 	.p2align 4
-clear_page:
+clear_pages:
+	movl   $4096/64,%eax
+	movl	%esi, %ecx
+	shll	%cl, %eax
+	movl	%eax, %ecx
 	xorl   %eax,%eax
-	movl   $4096/64,%ecx
 	.p2align 4
 .Lloop:
 	decl	%ecx
@@ -23,7 +27,7 @@ clear_page:
 	jnz	.Lloop
 	nop
 	ret
-clear_page_end:
+clear_pages_end:

 	/* C stepping K8 run faster using the string instructions.
 	   It is also a lot simpler. Use this when possible */
@@ -32,19 +36,22 @@ clear_page_end:

 	.section .altinstructions,"a"
 	.align 8
-	.quad  clear_page
-	.quad  clear_page_c
+	.quad  clear_pages
+	.quad  clear_pages_c
 	.byte  X86_FEATURE_K8_C
-	.byte  clear_page_end-clear_page
-	.byte  clear_page_c_end-clear_page_c
+	.byte  clear_pages_end-clear_pages
+	.byte  clear_pages_c_end-clear_pages_c
 	.previous

 	.section .altinstr_replacement,"ax"
-clear_page_c:
-	movl $4096/8,%ecx
+clear_pages_c:
+	movl $4096/8,%eax
+	movl %esi, %ecx
+	shll %cl, %eax
+	movl %eax, %ecx
 	xorl %eax,%eax
 	rep
 	stosq
 	ret
-clear_page_c_end:
+clear_pages_c_end:
 	.previous
Index: linux-2.6.10/arch/sparc64/lib/clear_page.S
===================================================================
--- linux-2.6.10.orig/arch/sparc64/lib/clear_page.S	2004-12-24 13:35:23.000000000 -0800
+++ linux-2.6.10/arch/sparc64/lib/clear_page.S	2005-02-07 11:04:32.000000000 -0800
@@ -28,9 +28,12 @@
 	.text

 	.globl		_clear_page
-_clear_page:		/* %o0=dest */
+_clear_page:		/* %o0=dest, %o1=order */
+	sethi		%hi(PAGE_SIZE/64), %o2
+	clr		%o4
+	or		%o2, %lo(PAGE_SIZE/64), %o2
 	ba,pt		%xcc, clear_page_common
-	 clr		%o4
+	 sllx		%o2, %o1, %o1

 	/* This thing is pretty important, it shows up
 	 * on the profiles via do_anonymous_page().
@@ -69,16 +72,16 @@ clear_user_page:	/* %o0=dest, %o1=vaddr
 	flush		%g6
 	wrpr		%o4, 0x0, %pstate

+	sethi		%hi(PAGE_SIZE/64), %o1
 	mov		1, %o4
+	or		%o1, %lo(PAGE_SIZE/64), %o1

 clear_page_common:
 	VISEntryHalf
 	membar		#StoreLoad | #StoreStore | #LoadStore
 	fzero		%f0
-	sethi		%hi(PAGE_SIZE/64), %o1
 	mov		%o0, %g1		! remember vaddr for tlbflush
 	fzero		%f2
-	or		%o1, %lo(PAGE_SIZE/64), %o1
 	faddd		%f0, %f2, %f4
 	fmuld		%f0, %f2, %f6
 	faddd		%f0, %f2, %f8
Index: linux-2.6.10/include/asm-sparc64/page.h
===================================================================
--- linux-2.6.10.orig/include/asm-sparc64/page.h	2005-02-03 22:51:43.000000000 -0800
+++ linux-2.6.10/include/asm-sparc64/page.h	2005-02-07 11:04:32.000000000 -0800
@@ -14,8 +14,10 @@

 #ifndef __ASSEMBLY__

-extern void _clear_page(void *page);
-#define clear_page(X)	_clear_page((void *)(X))
+extern void _clear_page(void *page, int order);
+#define clear_page(X)	_clear_page((void *)(X), 0)
+#define clear_pages _clear_page
+
 struct page;
 extern void clear_user_page(void *addr, unsigned long vaddr, struct page *page);
 #define copy_page(X,Y)	memcpy((void *)(X), (void *)(Y), PAGE_SIZE)
Index: linux-2.6.10/include/linux/gfp.h
===================================================================
--- linux-2.6.10.orig/include/linux/gfp.h	2005-02-03 22:51:46.000000000 -0800
+++ linux-2.6.10/include/linux/gfp.h	2005-02-07 11:06:13.000000000 -0800
@@ -131,4 +131,5 @@ extern void FASTCALL(free_cold_page(stru

 void page_alloc_init(void);

+void prep_zero_page(struct page *, unsigned int order, unsigned int gfp_flags);
 #endif /* __LINUX_GFP_H */

