Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263023AbVCKBGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263023AbVCKBGh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 20:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263033AbVCKBGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 20:06:36 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:7897 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263023AbVCKBFD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 20:05:03 -0500
Date: Thu, 10 Mar 2005 17:03:15 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Dave Hansen <haveblue@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH] add a clear_pages function to clear pages of higher
 order
In-Reply-To: <1110490683.24355.17.camel@localhost>
Message-ID: <Pine.LNX.4.58.0503101702120.15940@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503101229420.13911@schroedinger.engr.sgi.com>
 <1110490683.24355.17.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
- use Kconfig and CONFIG_CLEAR_PAGES

The zeroing of a page of a arbitrary order in page_alloc.c and in hugetlb.c may benefit from a
clear_page that is capable of zeroing multiple pages at once. The following patch adds
a function "clear_pages" that is capable of clearing multiple continuous pages at once.

Patch against 2.6.11-bk6

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.11/mm/page_alloc.c
===================================================================
--- linux-2.6.11.orig/mm/page_alloc.c	2005-03-10 14:42:43.000000000 -0800
+++ linux-2.6.11/mm/page_alloc.c	2005-03-10 15:01:53.000000000 -0800
@@ -628,11 +628,19 @@ void fastcall free_cold_page(struct page
 	free_hot_cold_page(page, 1);
 }

-static inline void prep_zero_page(struct page *page, int order, int gfp_flags)
+void prep_zero_page(struct page *page, unsigned int order, unsigned int gfp_flags)
 {
 	int i;

 	BUG_ON((gfp_flags & (__GFP_WAIT | __GFP_HIGHMEM)) == __GFP_HIGHMEM);
+
+#ifdef CONFIG_CLEAR_PAGES
+	if (!PageHighMem(page)) {
+		clear_pages(page_address(page), order);
+		return;
+	}
+#endif
+
 	for(i = 0; i < (1 << order); i++)
 		clear_highpage(page + i);
 }
Index: linux-2.6.11/mm/hugetlb.c
===================================================================
--- linux-2.6.11.orig/mm/hugetlb.c	2005-03-01 23:38:12.000000000 -0800
+++ linux-2.6.11/mm/hugetlb.c	2005-03-10 15:01:53.000000000 -0800
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

Index: linux-2.6.11/include/asm-ia64/page.h
===================================================================
--- linux-2.6.11.orig/include/asm-ia64/page.h	2005-03-01 23:37:48.000000000 -0800
+++ linux-2.6.11/include/asm-ia64/page.h	2005-03-10 15:02:47.000000000 -0800
@@ -56,8 +56,9 @@
 # ifdef __KERNEL__
 #  define STRICT_MM_TYPECHECKS

-extern void clear_page (void *page);
+extern void clear_pages (void *page, int order);
 extern void copy_page (void *to, void *from);
+#define clear_page(__page) clear_pages(__page, 0)

 /*
  * clear_user_page() and copy_user_page() can't be inline functions because
Index: linux-2.6.11/arch/ia64/kernel/ia64_ksyms.c
===================================================================
--- linux-2.6.11.orig/arch/ia64/kernel/ia64_ksyms.c	2005-03-01 23:38:08.000000000 -0800
+++ linux-2.6.11/arch/ia64/kernel/ia64_ksyms.c	2005-03-10 15:01:53.000000000 -0800
@@ -38,7 +38,7 @@ EXPORT_SYMBOL(__down_trylock);
 EXPORT_SYMBOL(__up);

 #include <asm/page.h>
-EXPORT_SYMBOL(clear_page);
+EXPORT_SYMBOL(clear_pages);

 #ifdef CONFIG_VIRTUAL_MEM_MAP
 #include <linux/bootmem.h>
Index: linux-2.6.11/arch/ia64/lib/clear_page.S
===================================================================
--- linux-2.6.11.orig/arch/ia64/lib/clear_page.S	2005-03-01 23:37:47.000000000 -0800
+++ linux-2.6.11/arch/ia64/lib/clear_page.S	2005-03-10 15:01:53.000000000 -0800
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
Index: linux-2.6.11/include/asm-i386/page.h
===================================================================
--- linux-2.6.11.orig/include/asm-i386/page.h	2005-03-01 23:37:49.000000000 -0800
+++ linux-2.6.11/include/asm-i386/page.h	2005-03-10 15:02:59.000000000 -0800
@@ -18,7 +18,7 @@

 #include <asm/mmx.h>

-#define clear_page(page)	mmx_clear_page((void *)(page))
+#define clear_pages(page, order)	mmx_clear_page((void *)(page),order)
 #define copy_page(to,from)	mmx_copy_page(to,from)

 #else
@@ -28,11 +28,12 @@
  *	Maybe the K6-III ?
  */

-#define clear_page(page)	memset((void *)(page), 0, PAGE_SIZE)
+#define clear_pages(page, order)	memset((void *)(page), 0, PAGE_SIZE << (order))
 #define copy_page(to,from)	memcpy((void *)(to), (void *)(from), PAGE_SIZE)

 #endif

+#define clear_page(page) clear_pages(page, 0)
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)

Index: linux-2.6.11/include/asm-i386/mmx.h
===================================================================
--- linux-2.6.11.orig/include/asm-i386/mmx.h	2005-03-01 23:38:09.000000000 -0800
+++ linux-2.6.11/include/asm-i386/mmx.h	2005-03-10 15:01:53.000000000 -0800
@@ -8,7 +8,7 @@
 #include <linux/types.h>

 extern void *_mmx_memcpy(void *to, const void *from, size_t size);
-extern void mmx_clear_page(void *page);
+extern void mmx_clear_page(void *page, int order);
 extern void mmx_copy_page(void *to, void *from);

 #endif
Index: linux-2.6.11/arch/i386/lib/mmx.c
===================================================================
--- linux-2.6.11.orig/arch/i386/lib/mmx.c	2005-03-01 23:38:09.000000000 -0800
+++ linux-2.6.11/arch/i386/lib/mmx.c	2005-03-10 15:01:53.000000000 -0800
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
Index: linux-2.6.11/include/asm-x86_64/page.h
===================================================================
--- linux-2.6.11.orig/include/asm-x86_64/page.h	2005-03-01 23:37:47.000000000 -0800
+++ linux-2.6.11/include/asm-x86_64/page.h	2005-03-10 15:03:10.000000000 -0800
@@ -32,8 +32,9 @@
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__

-void clear_page(void *);
+void clear_pages(void *, int);
 void copy_page(void *, void *);
+#define clear_page(__page) clear_pages(__page, 0)

 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
Index: linux-2.6.11/arch/x86_64/kernel/x8664_ksyms.c
===================================================================
--- linux-2.6.11.orig/arch/x86_64/kernel/x8664_ksyms.c	2005-03-01 23:37:49.000000000 -0800
+++ linux-2.6.11/arch/x86_64/kernel/x8664_ksyms.c	2005-03-10 15:01:53.000000000 -0800
@@ -108,7 +108,7 @@ EXPORT_SYMBOL(pci_mem_start);
 #endif

 EXPORT_SYMBOL(copy_page);
-EXPORT_SYMBOL(clear_page);
+EXPORT_SYMBOL(clear_pages);

 EXPORT_SYMBOL(cpu_pda);
 #ifdef CONFIG_SMP
Index: linux-2.6.11/arch/x86_64/lib/clear_page.S
===================================================================
--- linux-2.6.11.orig/arch/x86_64/lib/clear_page.S	2005-03-01 23:38:08.000000000 -0800
+++ linux-2.6.11/arch/x86_64/lib/clear_page.S	2005-03-10 15:01:53.000000000 -0800
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
Index: linux-2.6.11/arch/sparc64/lib/clear_page.S
===================================================================
--- linux-2.6.11.orig/arch/sparc64/lib/clear_page.S	2005-03-01 23:38:17.000000000 -0800
+++ linux-2.6.11/arch/sparc64/lib/clear_page.S	2005-03-10 15:01:53.000000000 -0800
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
Index: linux-2.6.11/include/asm-sparc64/page.h
===================================================================
--- linux-2.6.11.orig/include/asm-sparc64/page.h	2005-03-01 23:38:07.000000000 -0800
+++ linux-2.6.11/include/asm-sparc64/page.h	2005-03-10 15:03:43.000000000 -0800
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
Index: linux-2.6.11/include/linux/gfp.h
===================================================================
--- linux-2.6.11.orig/include/linux/gfp.h	2005-03-01 23:37:50.000000000 -0800
+++ linux-2.6.11/include/linux/gfp.h	2005-03-10 15:01:53.000000000 -0800
@@ -131,4 +131,5 @@ extern void FASTCALL(free_cold_page(stru

 void page_alloc_init(void);

+void prep_zero_page(struct page *, unsigned int order, unsigned int gfp_flags);
 #endif /* __LINUX_GFP_H */
Index: linux-2.6.11/arch/x86_64/Kconfig
===================================================================
--- linux-2.6.11.orig/arch/x86_64/Kconfig	2005-03-10 14:42:41.000000000 -0800
+++ linux-2.6.11/arch/x86_64/Kconfig	2005-03-10 15:01:53.000000000 -0800
@@ -78,6 +78,10 @@ config GENERIC_IOMAP
 	bool
 	default y

+config CLEAR_PAGES
+	bool
+	default y
+
 source "init/Kconfig"


Index: linux-2.6.11/arch/i386/Kconfig
===================================================================
--- linux-2.6.11.orig/arch/i386/Kconfig	2005-03-10 14:42:41.000000000 -0800
+++ linux-2.6.11/arch/i386/Kconfig	2005-03-10 15:01:53.000000000 -0800
@@ -33,6 +33,10 @@ config GENERIC_IOMAP
 	bool
 	default y

+config CLEAR_PAGES
+	bool
+	default y
+
 source "init/Kconfig"

 menu "Processor type and features"
Index: linux-2.6.11/arch/ia64/Kconfig
===================================================================
--- linux-2.6.11.orig/arch/ia64/Kconfig	2005-03-01 23:38:26.000000000 -0800
+++ linux-2.6.11/arch/ia64/Kconfig	2005-03-10 15:01:53.000000000 -0800
@@ -46,6 +46,10 @@ config GENERIC_IOMAP
 	bool
 	default y

+config CLEAR_PAGES
+	bool
+	default y
+
 choice
 	prompt "System type"
 	default IA64_GENERIC
Index: linux-2.6.11/arch/sparc64/Kconfig
===================================================================
--- linux-2.6.11.orig/arch/sparc64/Kconfig	2005-03-01 23:38:25.000000000 -0800
+++ linux-2.6.11/arch/sparc64/Kconfig	2005-03-10 15:02:16.000000000 -0800
@@ -16,6 +16,10 @@ config TIME_INTERPOLATION
 	bool
 	default y

+config CLEAR_PAGES
+	bool
+	default y
+
 source "init/Kconfig"

 config SYSVIPC_COMPAT
