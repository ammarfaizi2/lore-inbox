Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262657AbVAEXeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbVAEXeK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 18:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262664AbVAEXeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 18:34:10 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:56035 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262657AbVAEXZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 18:25:56 -0500
Date: Wed, 5 Jan 2005 15:25:20 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Prezeroing V3 [2/4]: Extension of clear_page to take an order
 parameter
In-Reply-To: <Pine.LNX.4.58.0501041513330.1536@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0501051524020.9911@schroedinger.engr.sgi.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com>
 <41C20E3E.3070209@yahoo.com.au> <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412231132170.31791@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412231133130.31791@schroedinger.engr.sgi.com>
 <Pine.GSO.4.61.0501011123550.27452@waterleaf.sonytel.be>
 <Pine.LNX.4.58.0501041510430.1536@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0501041513330.1536@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an updated version that is independent of the first patch and
contains all the necessary modifications to make clear_page take a second
parameter.

Architecture support:
---------------------

Known to work:

ia64
i386
sparc64
m68k

Trivial modification expected to simply work:

arm
cris
h8300
m68knommu
ppc
ppc64
sh64
v850
parisc
sparc
um

Modification made but it would be good to have some feedback from the arch maintainers:

x86_64
s390
alpha
sh
mips
m32r

Index: linux-2.6.10/include/asm-ia64/page.h
===================================================================
--- linux-2.6.10.orig/include/asm-ia64/page.h	2004-12-24 13:34:00.000000000 -0800
+++ linux-2.6.10/include/asm-ia64/page.h	2005-01-05 10:09:51.000000000 -0800
@@ -56,7 +56,7 @@
 # ifdef __KERNEL__
 #  define STRICT_MM_TYPECHECKS

-extern void clear_page (void *page);
+extern void clear_page (void *page, int order);
 extern void copy_page (void *to, void *from);

 /*
@@ -65,7 +65,7 @@
  */
 #define clear_user_page(addr, vaddr, page)	\
 do {						\
-	clear_page(addr);			\
+	clear_page(addr, 0);			\
 	flush_dcache_page(page);		\
 } while (0)

Index: linux-2.6.10/include/asm-i386/page.h
===================================================================
--- linux-2.6.10.orig/include/asm-i386/page.h	2005-01-04 14:17:01.000000000 -0800
+++ linux-2.6.10/include/asm-i386/page.h	2005-01-05 10:09:51.000000000 -0800
@@ -18,7 +18,7 @@

 #include <asm/mmx.h>

-#define clear_page(page)	mmx_clear_page((void *)(page))
+#define clear_page(page, order)	mmx_clear_page((void *)(page),order)
 #define copy_page(to,from)	mmx_copy_page(to,from)

 #else
@@ -28,12 +28,12 @@
  *	Maybe the K6-III ?
  */

-#define clear_page(page)	memset((void *)(page), 0, PAGE_SIZE)
+#define clear_page(page, order)	memset((void *)(page), 0, PAGE_SIZE << (order))
 #define copy_page(to,from)	memcpy((void *)(to), (void *)(from), PAGE_SIZE)

 #endif

-#define clear_user_page(page, vaddr, pg)	clear_page(page)
+#define clear_user_page(page, vaddr, pg)	clear_page(page, 0)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)

 /*
Index: linux-2.6.10/include/asm-x86_64/page.h
===================================================================
--- linux-2.6.10.orig/include/asm-x86_64/page.h	2005-01-04 14:17:01.000000000 -0800
+++ linux-2.6.10/include/asm-x86_64/page.h	2005-01-05 10:09:51.000000000 -0800
@@ -32,10 +32,10 @@
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__

-void clear_page(void *);
+void clear_page(void *, int);
 void copy_page(void *, void *);

-#define clear_user_page(page, vaddr, pg)	clear_page(page)
+#define clear_user_page(page, vaddr, pg)	clear_page(page, 0)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)

 /*
Index: linux-2.6.10/include/asm-sparc/page.h
===================================================================
--- linux-2.6.10.orig/include/asm-sparc/page.h	2004-12-24 13:34:29.000000000 -0800
+++ linux-2.6.10/include/asm-sparc/page.h	2005-01-05 10:09:51.000000000 -0800
@@ -28,10 +28,10 @@

 #ifndef __ASSEMBLY__

-#define clear_page(page)	 memset((void *)(page), 0, PAGE_SIZE)
+#define clear_page(page, order)	 memset((void *)(page), 0, PAGE_SIZE << (order))
 #define copy_page(to,from) 	memcpy((void *)(to), (void *)(from), PAGE_SIZE)
 #define clear_user_page(addr, vaddr, page)	\
-	do { 	clear_page(addr);		\
+	do { 	clear_page(addr, 0);		\
 		sparc_flush_page_to_ram(page);	\
 	} while (0)
 #define copy_user_page(to, from, vaddr, page)	\
Index: linux-2.6.10/include/asm-s390/page.h
===================================================================
--- linux-2.6.10.orig/include/asm-s390/page.h	2004-12-24 13:34:01.000000000 -0800
+++ linux-2.6.10/include/asm-s390/page.h	2005-01-05 10:09:51.000000000 -0800
@@ -22,12 +22,12 @@

 #ifndef __s390x__

-static inline void clear_page(void *page)
+static inline void clear_page(void *page, int order)
 {
 	register_pair rp;

 	rp.subreg.even = (unsigned long) page;
-	rp.subreg.odd = (unsigned long) 4096;
+	rp.subreg.odd = (unsigned long) 4096 << order;
         asm volatile ("   slr  1,1\n"
 		      "   mvcl %0,0"
 		      : "+&a" (rp) : : "memory", "cc", "1" );
@@ -63,14 +63,19 @@

 #else /* __s390x__ */

-static inline void clear_page(void *page)
+static inline void clear_page(void *page, int order)
 {
-        asm volatile ("   lgr  2,%0\n"
+	int nr = 1 << order;
+
+	while (nr-- >0) {
+        	asm volatile ("   lgr  2,%0\n"
                       "   lghi 3,4096\n"
                       "   slgr 1,1\n"
                       "   mvcl 2,0"
                       : : "a" ((void *) (page))
 		      : "memory", "cc", "1", "2", "3" );
+		page += PAGE_SIZE;
+	}
 }

 static inline void copy_page(void *to, void *from)
@@ -103,7 +108,7 @@

 #endif /* __s390x__ */

-#define clear_user_page(page, vaddr, pg)	clear_page(page)
+#define clear_user_page(page, vaddr, pg)	clear_page(page, 0)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)

 /* Pure 2^n version of get_order */
Index: linux-2.6.10/arch/i386/lib/mmx.c
===================================================================
--- linux-2.6.10.orig/arch/i386/lib/mmx.c	2004-12-24 13:34:48.000000000 -0800
+++ linux-2.6.10/arch/i386/lib/mmx.c	2005-01-05 10:09:51.000000000 -0800
@@ -128,7 +128,7 @@
  *	other MMX using processors do not.
  */

-static void fast_clear_page(void *page)
+static void fast_clear_page(void *page, int order)
 {
 	int i;

@@ -138,7 +138,7 @@
 		"  pxor %%mm0, %%mm0\n" : :
 	);

-	for(i=0;i<4096/64;i++)
+	for(i=0;i<((4096/64) << order);i++)
 	{
 		__asm__ __volatile__ (
 		"  movntq %%mm0, (%0)\n"
@@ -257,7 +257,7 @@
  *	Generic MMX implementation without K7 specific streaming
  */

-static void fast_clear_page(void *page)
+static void fast_clear_page(void *page, int order)
 {
 	int i;

@@ -267,7 +267,7 @@
 		"  pxor %%mm0, %%mm0\n" : :
 	);

-	for(i=0;i<4096/128;i++)
+	for(i=0;i<((4096/128) << order);i++)
 	{
 		__asm__ __volatile__ (
 		"  movq %%mm0, (%0)\n"
@@ -359,23 +359,23 @@
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
Index: linux-2.6.10/include/asm-x86_64/mmx.h
===================================================================
--- linux-2.6.10.orig/include/asm-x86_64/mmx.h	2004-12-24 13:34:57.000000000 -0800
+++ linux-2.6.10/include/asm-x86_64/mmx.h	2005-01-05 10:09:51.000000000 -0800
@@ -8,7 +8,7 @@
 #include <linux/types.h>

 extern void *_mmx_memcpy(void *to, const void *from, size_t size);
-extern void mmx_clear_page(void *page);
+extern void mmx_clear_page(void *page, int order);
 extern void mmx_copy_page(void *to, void *from);

 #endif
Index: linux-2.6.10/arch/ia64/lib/clear_page.S
===================================================================
--- linux-2.6.10.orig/arch/ia64/lib/clear_page.S	2004-12-24 13:33:50.000000000 -0800
+++ linux-2.6.10/arch/ia64/lib/clear_page.S	2005-01-05 10:09:51.000000000 -0800
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

 GLOBAL_ENTRY(clear_page)
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
Index: linux-2.6.10/arch/x86_64/lib/clear_page.S
===================================================================
--- linux-2.6.10.orig/arch/x86_64/lib/clear_page.S	2004-12-24 13:34:33.000000000 -0800
+++ linux-2.6.10/arch/x86_64/lib/clear_page.S	2005-01-05 10:09:51.000000000 -0800
@@ -7,6 +7,7 @@
 clear_page:
 	xorl   %eax,%eax
 	movl   $4096/64,%ecx
+	shl	%esi, %ecx
 	.p2align 4
 .Lloop:
 	decl	%ecx
@@ -42,6 +43,7 @@
 	.section .altinstr_replacement,"ax"
 clear_page_c:
 	movl $4096/8,%ecx
+	shl	%esi, %ecx
 	xorl %eax,%eax
 	rep
 	stosq
Index: linux-2.6.10/include/asm-sh/page.h
===================================================================
--- linux-2.6.10.orig/include/asm-sh/page.h	2004-12-24 13:35:28.000000000 -0800
+++ linux-2.6.10/include/asm-sh/page.h	2005-01-05 10:09:51.000000000 -0800
@@ -36,12 +36,22 @@
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__

-extern void (*clear_page)(void *to);
+extern void (*_clear_page)(void *to);
 extern void (*copy_page)(void *to, void *from);

 extern void clear_page_slow(void *to);
 extern void copy_page_slow(void *to, void *from);

+static inline void clear_page(void *page, int order)
+{
+	unsigned int nr = 1 << order;
+
+	while (nr-- >0) {
+		_clear_page(page);
+		page += PAGE_SIZE;
+	}
+}
+
 #if defined(CONFIG_SH7705_CACHE_32KB) && defined(CONFIG_MMU)
 struct page;
 extern void clear_user_page(void *to, unsigned long address, struct page *pg);
@@ -49,7 +59,7 @@
 extern void __clear_user_page(void *to, void *orig_to);
 extern void __copy_user_page(void *to, void *from, void *orig_to);
 #elif defined(CONFIG_CPU_SH2) || defined(CONFIG_CPU_SH3) || !defined(CONFIG_MMU)
-#define clear_user_page(page, vaddr, pg)	clear_page(page)
+#define clear_user_page(page, vaddr, pg)	clear_page(page, 0)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 #elif defined(CONFIG_CPU_SH4)
 struct page;
Index: linux-2.6.10/include/asm-i386/mmx.h
===================================================================
--- linux-2.6.10.orig/include/asm-i386/mmx.h	2004-12-24 13:34:57.000000000 -0800
+++ linux-2.6.10/include/asm-i386/mmx.h	2005-01-05 10:09:51.000000000 -0800
@@ -8,7 +8,7 @@
 #include <linux/types.h>

 extern void *_mmx_memcpy(void *to, const void *from, size_t size);
-extern void mmx_clear_page(void *page);
+extern void mmx_clear_page(void *page, int order);
 extern void mmx_copy_page(void *to, void *from);

 #endif
Index: linux-2.6.10/arch/alpha/lib/clear_page.S
===================================================================
--- linux-2.6.10.orig/arch/alpha/lib/clear_page.S	2004-12-24 13:35:25.000000000 -0800
+++ linux-2.6.10/arch/alpha/lib/clear_page.S	2005-01-05 10:09:51.000000000 -0800
@@ -6,11 +6,10 @@

 	.text
 	.align 4
-	.global clear_page
-	.ent clear_page
-clear_page:
+	.global _clear_page
+	.ent _clear_page
+_clear_page:
 	.prologue 0
-
 	lda	$0,128
 	nop
 	unop
@@ -36,4 +35,4 @@
 	unop
 	nop

-	.end clear_page
+	.end _clear_page
Index: linux-2.6.10/include/asm-sh64/page.h
===================================================================
--- linux-2.6.10.orig/include/asm-sh64/page.h	2004-12-24 13:34:33.000000000 -0800
+++ linux-2.6.10/include/asm-sh64/page.h	2005-01-05 10:09:51.000000000 -0800
@@ -50,12 +50,20 @@
 extern void sh64_page_clear(void *page);
 extern void sh64_page_copy(void *from, void *to);

-#define clear_page(page)               sh64_page_clear(page)
+static inline void clear_page(page, order)
+{
+	int nr = 1 << order;
+
+	while (nr-- >0) {
+		sh64_page_clear(page++, 0);
+	}
+}
+
 #define copy_page(to,from)             sh64_page_copy(from, to)

 #if defined(CONFIG_DCACHE_DISABLED)

-#define clear_user_page(page, vaddr, pg)	clear_page(page)
+#define clear_user_page(page, vaddr, pg)	sh_clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)

 #else
Index: linux-2.6.10/include/asm-h8300/page.h
===================================================================
--- linux-2.6.10.orig/include/asm-h8300/page.h	2004-12-24 13:35:25.000000000 -0800
+++ linux-2.6.10/include/asm-h8300/page.h	2005-01-05 10:09:51.000000000 -0800
@@ -24,10 +24,10 @@
 #define get_user_page(vaddr)		__get_free_page(GFP_KERNEL)
 #define free_user_page(page, addr)	free_page(addr)

-#define clear_page(page)	memset((page), 0, PAGE_SIZE)
+#define clear_page(page, order)	memset((page), 0, PAGE_SIZE << (order))
 #define copy_page(to,from)	memcpy((to), (from), PAGE_SIZE)

-#define clear_user_page(page, vaddr, pg)	clear_page(page)
+#define clear_user_page(page, vaddr, pg)	clear_page(page, 0)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)

 /*
Index: linux-2.6.10/include/asm-arm/page.h
===================================================================
--- linux-2.6.10.orig/include/asm-arm/page.h	2004-12-24 13:34:01.000000000 -0800
+++ linux-2.6.10/include/asm-arm/page.h	2005-01-05 10:09:51.000000000 -0800
@@ -128,7 +128,7 @@
 		preempt_enable();			\
 	} while (0)

-#define clear_page(page)	memzero((void *)(page), PAGE_SIZE)
+#define clear_page(page, order)	memzero((void *)(page), PAGE_SIZE << (order))
 extern void copy_page(void *to, const void *from);

 #undef STRICT_MM_TYPECHECKS
Index: linux-2.6.10/include/asm-ppc64/page.h
===================================================================
--- linux-2.6.10.orig/include/asm-ppc64/page.h	2004-12-24 13:33:49.000000000 -0800
+++ linux-2.6.10/include/asm-ppc64/page.h	2005-01-05 10:09:51.000000000 -0800
@@ -102,12 +102,12 @@
 #define REGION_MASK   (((1UL<<REGION_SIZE)-1UL)<<REGION_SHIFT)
 #define REGION_STRIDE (1UL << REGION_SHIFT)

-static __inline__ void clear_page(void *addr)
+static __inline__ void clear_page(void *addr, int order)
 {
 	unsigned long lines, line_size;

 	line_size = systemcfg->dCacheL1LineSize;
-	lines = naca->dCacheL1LinesPerPage;
+	lines = naca->dCacheL1LinesPerPage << order;

 	__asm__ __volatile__(
 	"mtctr  	%1	# clear_page\n\
Index: linux-2.6.10/include/asm-m32r/page.h
===================================================================
--- linux-2.6.10.orig/include/asm-m32r/page.h	2004-12-24 13:34:29.000000000 -0800
+++ linux-2.6.10/include/asm-m32r/page.h	2005-01-05 10:09:51.000000000 -0800
@@ -11,10 +11,22 @@
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__

-extern void clear_page(void *to);
+extern void _clear_page(void *to);
+
+static inline void clear_page(void *page, int order)
+{
+	unsigned int nr = 1 << order;
+
+	while (nr-- > 0) {
+		_clear_page(page);
+		page += PAGE_SIZE;
+	}
+}
+
+
 extern void copy_page(void *to, void *from);

-#define clear_user_page(page, vaddr, pg)	clear_page(page)
+#define clear_user_page(page, vaddr, pg)	clear_page(page, 0)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)

 /*
Index: linux-2.6.10/include/asm-alpha/page.h
===================================================================
--- linux-2.6.10.orig/include/asm-alpha/page.h	2004-12-24 13:35:24.000000000 -0800
+++ linux-2.6.10/include/asm-alpha/page.h	2005-01-05 10:09:51.000000000 -0800
@@ -15,8 +15,20 @@

 #define STRICT_MM_TYPECHECKS

-extern void clear_page(void *page);
-#define clear_user_page(page, vaddr, pg)	clear_page(page)
+extern void _clear_page(void *page);
+
+static inline void clear_page(void *page, int order)
+{
+	int nr = 1 << order;
+
+	while (nr--)
+	{
+		_clear_page(page);
+		page += PAGE_SIZE;
+	}
+}
+
+#define clear_user_page(page, vaddr, pg)	clear_page(page, 0)

 extern void copy_page(void * _to, void * _from);
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
Index: linux-2.6.10/arch/mips/mm/pg-sb1.c
===================================================================
--- linux-2.6.10.orig/arch/mips/mm/pg-sb1.c	2004-12-24 13:35:50.000000000 -0800
+++ linux-2.6.10/arch/mips/mm/pg-sb1.c	2005-01-05 10:09:51.000000000 -0800
@@ -42,7 +42,7 @@
 #ifdef CONFIG_SIBYTE_DMA_PAGEOPS
 static inline void clear_page_cpu(void *page)
 #else
-void clear_page(void *page)
+void _clear_page(void *page)
 #endif
 {
 	unsigned char *addr = (unsigned char *) page;
@@ -172,14 +172,13 @@
 		     IOADDR(A_DM_REGISTER(cpu, R_DM_DSCR_BASE)));
 }

-void clear_page(void *page)
+void _clear_page(void *page)
 {
 	int cpu = smp_processor_id();

 	/* if the page is above Kseg0, use old way */
 	if (KSEGX(page) != CAC_BASE)
 		return clear_page_cpu(page);
-
 	page_descr[cpu].dscr_a = PHYSADDR(page) | M_DM_DSCRA_ZERO_MEM | M_DM_DSCRA_L2C_DEST | M_DM_DSCRA_INTERRUPT;
 	page_descr[cpu].dscr_b = V_DM_DSCRB_SRC_LENGTH(PAGE_SIZE);
 	__raw_writeq(1, IOADDR(A_DM_REGISTER(cpu, R_DM_DSCR_COUNT)));
@@ -218,5 +217,5 @@

 #endif

-EXPORT_SYMBOL(clear_page);
+EXPORT_SYMBOL(_clear_page);
 EXPORT_SYMBOL(copy_page);
Index: linux-2.6.10/include/asm-m68k/page.h
===================================================================
--- linux-2.6.10.orig/include/asm-m68k/page.h	2004-12-24 13:35:49.000000000 -0800
+++ linux-2.6.10/include/asm-m68k/page.h	2005-01-05 10:09:51.000000000 -0800
@@ -50,7 +50,7 @@
 		       );
 }

-static inline void clear_page(void *page)
+static inline void clear_page(void *page, int order)
 {
 	unsigned long tmp;
 	unsigned long *sp = page;
@@ -69,16 +69,16 @@
 			     "dbra   %1,1b\n\t"
 			     : "=a" (sp), "=d" (tmp)
 			     : "a" (page), "0" (sp),
-			       "1" ((PAGE_SIZE - 16) / 16 - 1));
+			       "1" (((PAGE_SIZE<<(order)) - 16) / 16 - 1));
 }

 #else
-#define clear_page(page)	memset((page), 0, PAGE_SIZE)
+#define clear_page(page, order)	memset((page), 0, PAGE_SIZE << (order))
 #define copy_page(to,from)	memcpy((to), (from), PAGE_SIZE)
 #endif

 #define clear_user_page(addr, vaddr, page)	\
-	do {	clear_page(addr);		\
+	do {	clear_page(addr, 0);		\
 		flush_dcache_page(page);	\
 	} while (0)
 #define copy_user_page(to, from, vaddr, page)	\
Index: linux-2.6.10/include/asm-mips/page.h
===================================================================
--- linux-2.6.10.orig/include/asm-mips/page.h	2004-12-24 13:34:31.000000000 -0800
+++ linux-2.6.10/include/asm-mips/page.h	2005-01-05 10:09:51.000000000 -0800
@@ -39,7 +39,18 @@
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__

-extern void clear_page(void * page);
+extern void _clear_page(void * page);
+
+static inline void clear_page(void *page, int order)
+{
+	unsigned int nr = 1 << order;
+
+	while (nr-- >0) {
+		_clear_page(page);
+		page += PAGE_SIZE;
+	}
+}
+
 extern void copy_page(void * to, void * from);

 extern unsigned long shm_align_mask;
@@ -57,7 +68,7 @@
 {
 	extern void (*flush_data_cache_page)(unsigned long addr);

-	clear_page(addr);
+	clear_page(addr, 0);
 	if (pages_do_alias((unsigned long) addr, vaddr))
 		flush_data_cache_page((unsigned long)addr);
 }
Index: linux-2.6.10/include/asm-m68knommu/page.h
===================================================================
--- linux-2.6.10.orig/include/asm-m68knommu/page.h	2004-12-24 13:34:33.000000000 -0800
+++ linux-2.6.10/include/asm-m68knommu/page.h	2005-01-05 10:09:51.000000000 -0800
@@ -24,10 +24,10 @@
 #define get_user_page(vaddr)		__get_free_page(GFP_KERNEL)
 #define free_user_page(page, addr)	free_page(addr)

-#define clear_page(page)	memset((page), 0, PAGE_SIZE)
+#define clear_page(page, order)	memset((page), 0, PAGE_SIZE << (order))
 #define copy_page(to,from)	memcpy((to), (from), PAGE_SIZE)

-#define clear_user_page(page, vaddr, pg)	clear_page(page)
+#define clear_user_page(page, vaddr, pg)	clear_page(page, 0)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)

 /*
Index: linux-2.6.10/include/asm-cris/page.h
===================================================================
--- linux-2.6.10.orig/include/asm-cris/page.h	2004-12-24 13:34:30.000000000 -0800
+++ linux-2.6.10/include/asm-cris/page.h	2005-01-05 10:09:51.000000000 -0800
@@ -15,10 +15,10 @@

 #ifdef __KERNEL__

-#define clear_page(page)        memset((void *)(page), 0, PAGE_SIZE)
+#define clear_page(page, order) memset((void *)(page), 0, PAGE_SIZE << (order))
 #define copy_page(to,from)      memcpy((void *)(to), (void *)(from), PAGE_SIZE)

-#define clear_user_page(page, vaddr, pg)    clear_page(page)
+#define clear_user_page(page, vaddr, pg)    clear_page(page, 0)
 #define copy_user_page(to, from, vaddr, pg) copy_page(to, from)

 /*
Index: linux-2.6.10/include/asm-v850/page.h
===================================================================
--- linux-2.6.10.orig/include/asm-v850/page.h	2004-12-24 13:35:00.000000000 -0800
+++ linux-2.6.10/include/asm-v850/page.h	2005-01-05 10:09:51.000000000 -0800
@@ -37,11 +37,11 @@

 #define STRICT_MM_TYPECHECKS

-#define clear_page(page)	memset ((void *)(page), 0, PAGE_SIZE)
+#define clear_page(page, order)	memset ((void *)(page), 0, PAGE_SIZE << (order))
 #define copy_page(to, from)	memcpy ((void *)(to), (void *)from, PAGE_SIZE)

 #define clear_user_page(addr, vaddr, page)	\
-	do { 	clear_page(addr);		\
+	do { 	clear_page(addr, 0);		\
 		flush_dcache_page(page);	\
 	} while (0)
 #define copy_user_page(to, from, vaddr, page)	\
Index: linux-2.6.10/include/asm-parisc/page.h
===================================================================
--- linux-2.6.10.orig/include/asm-parisc/page.h	2004-12-24 13:34:26.000000000 -0800
+++ linux-2.6.10/include/asm-parisc/page.h	2005-01-05 10:09:51.000000000 -0800
@@ -13,7 +13,7 @@
 #include <asm/types.h>
 #include <asm/cache.h>

-#define clear_page(page)	memset((void *)(page), 0, PAGE_SIZE)
+#define clear_page(page, order)	memset((void *)(page), 0, PAGE_SIZE << (order))
 #define copy_page(to,from)      copy_user_page_asm((void *)(to), (void *)(from))

 struct page;
Index: linux-2.6.10/arch/arm/mm/copypage-v6.c
===================================================================
--- linux-2.6.10.orig/arch/arm/mm/copypage-v6.c	2004-12-24 13:34:31.000000000 -0800
+++ linux-2.6.10/arch/arm/mm/copypage-v6.c	2005-01-05 10:09:51.000000000 -0800
@@ -47,7 +47,7 @@
  */
 void v6_clear_user_page_nonaliasing(void *kaddr, unsigned long vaddr)
 {
-	clear_page(kaddr);
+	_clear_page(kaddr);
 }

 /*
@@ -116,7 +116,7 @@

 	set_pte(to_pte + offset, pfn_pte(__pa(kaddr) >> PAGE_SHIFT, to_pgprot));
 	flush_tlb_kernel_page(to);
-	clear_page((void *)to);
+	_clear_page((void *)to);

 	spin_unlock(&v6_lock);
 }
Index: linux-2.6.10/arch/m32r/mm/page.S
===================================================================
--- linux-2.6.10.orig/arch/m32r/mm/page.S	2004-12-24 13:34:57.000000000 -0800
+++ linux-2.6.10/arch/m32r/mm/page.S	2005-01-05 10:09:51.000000000 -0800
@@ -51,7 +51,7 @@
 	jmp	r14

 	.text
-	.global	clear_page
+	.global	_clear_page
 	/*
 	 * clear_page (to)
 	 *
@@ -60,7 +60,7 @@
 	 * 16 * 256
 	 */
 	.align	4
-clear_page:
+_clear_page:
 	ldi	r2, #255
 	ldi	r4, #0
 	ld	r3, @r0		/* cache line allocate */
Index: linux-2.6.10/include/asm-ppc/page.h
===================================================================
--- linux-2.6.10.orig/include/asm-ppc/page.h	2004-12-24 13:34:29.000000000 -0800
+++ linux-2.6.10/include/asm-ppc/page.h	2005-01-05 10:09:51.000000000 -0800
@@ -85,7 +85,7 @@

 struct page;
 extern void clear_pages(void *page, int order);
-static inline void clear_page(void *page) { clear_pages(page, 0); }
+#define  clear_page clear_pages
 extern void copy_page(void *to, void *from);
 extern void clear_user_page(void *page, unsigned long vaddr, struct page *pg);
 extern void copy_user_page(void *to, void *from, unsigned long vaddr,
Index: linux-2.6.10/arch/alpha/kernel/alpha_ksyms.c
===================================================================
--- linux-2.6.10.orig/arch/alpha/kernel/alpha_ksyms.c	2004-12-24 13:33:51.000000000 -0800
+++ linux-2.6.10/arch/alpha/kernel/alpha_ksyms.c	2005-01-05 10:09:51.000000000 -0800
@@ -88,7 +88,7 @@
 EXPORT_SYMBOL(__memsetw);
 EXPORT_SYMBOL(__constant_c_memset);
 EXPORT_SYMBOL(copy_page);
-EXPORT_SYMBOL(clear_page);
+EXPORT_SYMBOL(_clear_page);

 EXPORT_SYMBOL(__direct_map_base);
 EXPORT_SYMBOL(__direct_map_size);
Index: linux-2.6.10/arch/alpha/lib/ev6-clear_page.S
===================================================================
--- linux-2.6.10.orig/arch/alpha/lib/ev6-clear_page.S	2004-12-24 13:35:24.000000000 -0800
+++ linux-2.6.10/arch/alpha/lib/ev6-clear_page.S	2005-01-05 10:09:51.000000000 -0800
@@ -6,9 +6,9 @@

         .text
         .align 4
-        .global clear_page
-        .ent clear_page
-clear_page:
+        .global _clear_page
+        .ent _clear_page
+_clear_page:
         .prologue 0

 	lda	$0,128
@@ -51,4 +51,4 @@
 	nop
 	nop

-	.end clear_page
+	.end _clear_page
Index: linux-2.6.10/arch/sh/mm/init.c
===================================================================
--- linux-2.6.10.orig/arch/sh/mm/init.c	2004-12-24 13:35:24.000000000 -0800
+++ linux-2.6.10/arch/sh/mm/init.c	2005-01-05 10:09:51.000000000 -0800
@@ -57,7 +57,7 @@
 #endif

 void (*copy_page)(void *from, void *to);
-void (*clear_page)(void *to);
+void (*_clear_page)(void *to);

 void show_mem(void)
 {
@@ -255,7 +255,7 @@
 	 * later in the boot process if a better method is available.
 	 */
 	copy_page = copy_page_slow;
-	clear_page = clear_page_slow;
+	_clear_page = clear_page_slow;

 	/* this will put all low memory onto the freelists */
 	totalram_pages += free_all_bootmem_node(NODE_DATA(0));
Index: linux-2.6.10/arch/sh/mm/pg-dma.c
===================================================================
--- linux-2.6.10.orig/arch/sh/mm/pg-dma.c	2004-12-24 13:35:00.000000000 -0800
+++ linux-2.6.10/arch/sh/mm/pg-dma.c	2005-01-05 10:09:51.000000000 -0800
@@ -78,7 +78,7 @@
 		return ret;

 	copy_page = copy_page_dma;
-	clear_page = clear_page_dma;
+	_clear_page = clear_page_dma;

 	return ret;
 }
Index: linux-2.6.10/arch/sh/mm/pg-nommu.c
===================================================================
--- linux-2.6.10.orig/arch/sh/mm/pg-nommu.c	2004-12-24 13:34:32.000000000 -0800
+++ linux-2.6.10/arch/sh/mm/pg-nommu.c	2005-01-05 10:09:51.000000000 -0800
@@ -27,7 +27,7 @@
 static int __init pg_nommu_init(void)
 {
 	copy_page = copy_page_nommu;
-	clear_page = clear_page_nommu;
+	_clear_page = clear_page_nommu;

 	return 0;
 }
Index: linux-2.6.10/arch/mips/mm/pg-r4k.c
===================================================================
--- linux-2.6.10.orig/arch/mips/mm/pg-r4k.c	2004-12-24 13:34:49.000000000 -0800
+++ linux-2.6.10/arch/mips/mm/pg-r4k.c	2005-01-05 10:09:51.000000000 -0800
@@ -39,9 +39,9 @@

 static unsigned int clear_page_array[0x130 / 4];

-void clear_page(void * page) __attribute__((alias("clear_page_array")));
+void _clear_page(void * page) __attribute__((alias("clear_page_array")));

-EXPORT_SYMBOL(clear_page);
+EXPORT_SYMBOL(_clear_page);

 /*
  * Maximum sizes:
Index: linux-2.6.10/arch/m32r/kernel/m32r_ksyms.c
===================================================================
--- linux-2.6.10.orig/arch/m32r/kernel/m32r_ksyms.c	2004-12-24 13:34:29.000000000 -0800
+++ linux-2.6.10/arch/m32r/kernel/m32r_ksyms.c	2005-01-05 10:09:51.000000000 -0800
@@ -102,7 +102,7 @@
 EXPORT_SYMBOL(memcmp);
 EXPORT_SYMBOL(memscan);
 EXPORT_SYMBOL(copy_page);
-EXPORT_SYMBOL(clear_page);
+EXPORT_SYMBOL(_clear_page);

 EXPORT_SYMBOL(strcat);
 EXPORT_SYMBOL(strchr);
Index: linux-2.6.10/include/asm-arm26/page.h
===================================================================
--- linux-2.6.10.orig/include/asm-arm26/page.h	2004-12-24 13:35:22.000000000 -0800
+++ linux-2.6.10/include/asm-arm26/page.h	2005-01-05 10:09:51.000000000 -0800
@@ -25,7 +25,7 @@
 		preempt_enable();			\
 	} while (0)

-#define clear_page(page)	memzero((void *)(page), PAGE_SIZE)
+#define clear_page(page, order)	memzero((void *)(page), PAGE_SIZE << (order))
 #define copy_page(to, from)  __copy_user_page(to, from, 0);

 #undef STRICT_MM_TYPECHECKS
Index: linux-2.6.10/include/asm-sparc64/page.h
===================================================================
--- linux-2.6.10.orig/include/asm-sparc64/page.h	2004-12-24 13:34:32.000000000 -0800
+++ linux-2.6.10/include/asm-sparc64/page.h	2005-01-05 10:09:51.000000000 -0800
@@ -14,8 +14,8 @@

 #ifndef __ASSEMBLY__

-extern void _clear_page(void *page);
-#define clear_page(X)	_clear_page((void *)(X))
+extern void _clear_page(void *page, unsigned long order);
+#define clear_page(X,Y)	_clear_page((void *)(X),(Y))
 struct page;
 extern void clear_user_page(void *addr, unsigned long vaddr, struct page *page);
 #define copy_page(X,Y)	memcpy((void *)(X), (void *)(Y), PAGE_SIZE)
Index: linux-2.6.10/arch/sparc64/lib/clear_page.S
===================================================================
--- linux-2.6.10.orig/arch/sparc64/lib/clear_page.S	2004-12-24 13:35:23.000000000 -0800
+++ linux-2.6.10/arch/sparc64/lib/clear_page.S	2005-01-05 10:09:51.000000000 -0800
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
@@ -69,16 +72,16 @@
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
Index: linux-2.6.10/drivers/net/tc35815.c
===================================================================
--- linux-2.6.10.orig/drivers/net/tc35815.c	2005-01-05 09:43:48.000000000 -0800
+++ linux-2.6.10/drivers/net/tc35815.c	2005-01-05 10:09:51.000000000 -0800
@@ -657,7 +657,7 @@
 		dma_cache_wback_inv((unsigned long)lp->fd_buf, PAGE_SIZE * FD_PAGE_NUM);
 #endif
 	} else {
-		clear_page(lp->fd_buf);
+		clear_page(lp->fd_buf, 0);
 #ifdef __mips__
 		dma_cache_wback_inv((unsigned long)lp->fd_buf, PAGE_SIZE * FD_PAGE_NUM);
 #endif
Index: linux-2.6.10/mm/page_alloc.c
===================================================================
--- linux-2.6.10.orig/mm/page_alloc.c	2005-01-05 09:32:52.000000000 -0800
+++ linux-2.6.10/mm/page_alloc.c	2005-01-05 10:09:51.000000000 -0800
@@ -550,10 +550,14 @@
  * or two.
  */
 static inline void prep_zero_page(struct page *page, int order) {
-	int i;

-	for(i = 0; i < 1 << order; i++)
-		clear_highpage(page + i);
+	if (PageHighMem(page)) {
+		int i;
+
+		for(i = 0; i < 1 << order; i++)
+			clear_highpage(page + i);
+	} else
+		clear_page(page_address(page), order);
 }

 static struct page *
Index: linux-2.6.10/include/linux/highmem.h
===================================================================
--- linux-2.6.10.orig/include/linux/highmem.h	2005-01-05 10:09:44.000000000 -0800
+++ linux-2.6.10/include/linux/highmem.h	2005-01-05 10:10:08.000000000 -0800
@@ -45,7 +45,7 @@
 static inline void clear_highpage(struct page *page)
 {
 	void *kaddr = kmap_atomic(page, KM_USER0);
-	clear_page(kaddr);
+	clear_page(kaddr, 0);
 	kunmap_atomic(kaddr, KM_USER0);
 }


