Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVCXWxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVCXWxQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 17:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVCXWxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 17:53:16 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:46731 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261199AbVCXWwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 17:52:00 -0500
Date: Thu, 24 Mar 2005 14:49:55 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: "David S. Miller" <davem@davemloft.net>
cc: davidm@hpl.hp.com, ak@muc.de, clameter@sgi.com,
       vda@port.imtp.ilyichevsk.odessa.ua, haveblue@us.ibm.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, mel@csn.ul.ie, linux-ia64@vger.kernel.org,
       Jens.Maurer@gmx.net
Subject: Re: [PATCH] add a clear_pages function to clear pages of higher
 order
In-Reply-To: <20050324110336.488241c4.davem@davemloft.net>
Message-ID: <Pine.LNX.4.58.0503241449070.7119@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503101229420.13911@schroedinger.engr.sgi.com>
 <200503111008.12134.vda@port.imtp.ilyichevsk.odessa.ua>
 <Pine.LNX.4.58.0503161720570.1787@schroedinger.engr.sgi.com>
 <200503181154.37414.vda@port.imtp.ilyichevsk.odessa.ua>
 <Pine.LNX.4.58.0503180652350.15022@schroedinger.engr.sgi.com>
 <20050318192808.GB38053@muc.de> <16963.2075.713737.485070@napali.hpl.hp.com>
 <Pine.LNX.4.58.0503241038040.5663@schroedinger.engr.sgi.com>
 <20050324110336.488241c4.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2005, David S. Miller wrote:

> > prep_zero_page would use a temporal clear for an order 0 page but a
> > nontemporal clear for higher order pages.
>
> That sounds about right to me.
>
> Hmmm, I'm inspired to experiment with this on sparc64 a bit.

Could you help me fix up this patch replacing the old clear_pages patch?

Introduces a new function clear_cold(void *pageaddress, int order) to clear
pages of an arbitrary size with non temporal stores. Cold clearing is typically
faster than hot clearing. Hot clearing is beneficial when the data is to be used soon.
(The hot cold distincion also work well with the new hot and cold aware prezeroing daemon)

- Use cold clearing for huge pages.
- For ia64 also make clear_page uses temporal stores.
- Patch needs fixes to work properly on i386, x86_64 and sparc64.
- There may be other allocations that can benefit from the increased
  performance possible for cold zeroed pages if the pages are not to be
  used right away. Add __GFP_COLD to the gfp_flags for those.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.11/mm/hugetlb.c
===================================================================
--- linux-2.6.11.orig/mm/hugetlb.c	2005-03-01 23:38:12.000000000 -0800
+++ linux-2.6.11/mm/hugetlb.c	2005-03-24 14:12:53.000000000 -0800
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
+	prep_zero_page(page, HUGETLB_PAGE_ORDER, GFP_HIGHUSER | __GFP_COLD);
 	return page;
 }

Index: linux-2.6.11/mm/page_alloc.c
===================================================================
--- linux-2.6.11.orig/mm/page_alloc.c	2005-03-24 13:15:40.000000000 -0800
+++ linux-2.6.11/mm/page_alloc.c	2005-03-24 14:15:15.000000000 -0800
@@ -633,11 +633,17 @@ void fastcall free_cold_page(struct page
 	free_hot_cold_page(page, 1);
 }

-static inline void prep_zero_page(struct page *page, int order, int gfp_flags)
+void prep_zero_page(struct page *page, int order, int gfp_flags)
 {
 	int i;

 	BUG_ON((gfp_flags & (__GFP_WAIT | __GFP_HIGHMEM)) == __GFP_HIGHMEM);
+
+#ifdef CONFIG_CLEAR_COLD
+	if ((gfp_flags & __GFP_COLD) && !PageHighmem(page))
+		clear_cold(page_address(page), order)
+	else
+#endif
 	for(i = 0; i < (1 << order); i++)
 		clear_highpage(page + i);
 }
Index: linux-2.6.11/include/linux/gfp.h
===================================================================
--- linux-2.6.11.orig/include/linux/gfp.h	2005-03-01 23:37:50.000000000 -0800
+++ linux-2.6.11/include/linux/gfp.h	2005-03-24 14:12:53.000000000 -0800
@@ -131,4 +131,5 @@ extern void FASTCALL(free_cold_page(stru

 void page_alloc_init(void);

+void prep_zero_page(struct page *, unsigned int order, unsigned int gfp_flags);
 #endif /* __LINUX_GFP_H */
Index: linux-2.6.11/arch/ia64/Kconfig
===================================================================
--- linux-2.6.11.orig/arch/ia64/Kconfig	2005-03-01 23:38:26.000000000 -0800
+++ linux-2.6.11/arch/ia64/Kconfig	2005-03-24 14:12:53.000000000 -0800
@@ -46,6 +46,10 @@ config GENERIC_IOMAP
 	bool
 	default y

+config CLEAR_COLD
+	bool
+	default y
+
 choice
 	prompt "System type"
 	default IA64_GENERIC
Index: linux-2.6.11/include/asm-ia64/page.h
===================================================================
--- linux-2.6.11.orig/include/asm-ia64/page.h	2005-03-01 23:37:48.000000000 -0800
+++ linux-2.6.11/include/asm-ia64/page.h	2005-03-24 14:12:53.000000000 -0800
@@ -57,6 +57,8 @@
 #  define STRICT_MM_TYPECHECKS

 extern void clear_page (void *page);
+/* Clear arbitrary order page using nontemporal writes */
+extern void clear_cold (void *page, unsigned int order);
 extern void copy_page (void *to, void *from);

 /*
Index: linux-2.6.11/arch/ia64/kernel/ia64_ksyms.c
===================================================================
--- linux-2.6.11.orig/arch/ia64/kernel/ia64_ksyms.c	2005-03-01 23:38:08.000000000 -0800
+++ linux-2.6.11/arch/ia64/kernel/ia64_ksyms.c	2005-03-24 14:12:53.000000000 -0800
@@ -39,6 +39,7 @@ EXPORT_SYMBOL(__up);

 #include <asm/page.h>
 EXPORT_SYMBOL(clear_page);
+EXPORT_SYMBOL(clear_cold);

 #ifdef CONFIG_VIRTUAL_MEM_MAP
 #include <linux/bootmem.h>
Index: linux-2.6.11/arch/ia64/lib/clear_page.S
===================================================================
--- linux-2.6.11.orig/arch/ia64/lib/clear_page.S	2005-03-01 23:37:47.000000000 -0800
+++ linux-2.6.11/arch/ia64/lib/clear_page.S	2005-03-24 14:12:53.000000000 -0800
@@ -7,6 +7,8 @@
  * 1/06/01 davidm	Tuned for Itanium.
  * 2/12/02 kchen	Tuned for both Itanium and McKinley
  * 3/08/02 davidm	Some more tweaking
+ * 24/3/04 clameter	Make clear_page use temporal stores
+			add clear_cold using nontemporal stores
  */
 #include <linux/config.h>

@@ -53,6 +55,58 @@ GLOBAL_ENTRY(clear_page)
 	;;
 #ifdef CONFIG_ITANIUM
 	// Optimized for Itanium
+1:	stf.spill [dst1] = f0, 64
+	stf.spill [dst2] = f0, 64
+	cmp.lt p8,p0=dst_fetch, dst_last
+	;;
+#else
+	// Optimized for McKinley
+1:	stf.spill [dst1] = f0, 64
+	stf.spill [dst2] = f0, 64
+	stf.spill [dst3] = f0, 64
+	stf.spill [dst4] = f0, 128
+	cmp.lt p8,p0=dst_fetch, dst_last
+	;;
+	stf.spill [dst1] = f0, 64
+	stf.spill [dst2] = f0, 64
+#endif
+	stf.spill [dst3] = f0, 64
+(p8)	stf.spill [dst_fetch] = f0, L3_LINE_SIZE
+	br.cloop.sptk.few 1b
+	;;
+	mov ar.lc = saved_lc		// restore lc
+	br.ret.sptk.many rp
+END(clear_page)
+
+
+GLOBAL_ENTRY(clear_cold)
+	.prologue
+	.regstk 2,0,0,0
+	mov r16 = PAGE_SIZE/L3_LINE_SIZE	// main loop count
+	mov totsize = PAGE_SIZE
+	.save ar.lc, saved_lc
+	mov saved_lc = ar.lc
+	;;
+	.body
+	adds dst1 = 16, in0
+	mov ar.lc = (PREFETCH_LINES - 1)
+	mov dst_fetch = in0
+	adds dst2 = 32, in0
+	shl r16 = r16, in1
+	shl totsize = totsize, in1
+	;;
+.fetch:	stf.spill.nta [dst_fetch] = f0, L3_LINE_SIZE
+	adds dst3 = 48, in0		// executing this multiple times is harmless
+	br.cloop.sptk.few .fetch
+	add r16 = -1,r16
+	add dst_last = totsize, dst_fetch
+	adds dst4 = 64, in0
+	;;
+	mov ar.lc = r16			// one L3 line per iteration
+	adds dst_last = -PREFETCH_LINES*L3_LINE_SIZE, dst_last
+	;;
+#ifdef CONFIG_ITANIUM
+	// Optimized for Itanium
 1:	stf.spill.nta [dst1] = f0, 64
 	stf.spill.nta [dst2] = f0, 64
 	cmp.lt p8,p0=dst_fetch, dst_last
@@ -74,4 +128,4 @@ GLOBAL_ENTRY(clear_page)
 	;;
 	mov ar.lc = saved_lc		// restore lc
 	br.ret.sptk.many rp
-END(clear_page)
+END(clear_cold)
Index: linux-2.6.11/arch/i386/Kconfig
===================================================================
--- linux-2.6.11.orig/arch/i386/Kconfig	2005-03-24 13:15:36.000000000 -0800
+++ linux-2.6.11/arch/i386/Kconfig	2005-03-24 14:12:53.000000000 -0800
@@ -33,6 +33,10 @@ config GENERIC_IOMAP
 	bool
 	default y

+config CLEAR_COLD
+	bool
+	default y
+
 source "init/Kconfig"

 menu "Processor type and features"
Index: linux-2.6.11/include/asm-i386/page.h
===================================================================
--- linux-2.6.11.orig/include/asm-i386/page.h	2005-03-01 23:37:49.000000000 -0800
+++ linux-2.6.11/include/asm-i386/page.h	2005-03-24 14:12:53.000000000 -0800
@@ -19,6 +19,7 @@
 #include <asm/mmx.h>

 #define clear_page(page)	mmx_clear_page((void *)(page))
+#define clear_cold(page, order)	mmx_clear_cold((void *)(page), order)
 #define copy_page(to,from)	mmx_copy_page(to,from)

 #else
@@ -29,6 +30,8 @@
  */

 #define clear_page(page)	memset((void *)(page), 0, PAGE_SIZE)
+/* Clear arbitrary order page with nontemporal stores... is memset temporal?? */
+#define clear_cold(page, order)	memset((void *)(page), 0, PAGE_SIZE << order)
 #define copy_page(to,from)	memcpy((void *)(to), (void *)(from), PAGE_SIZE)

 #endif
Index: linux-2.6.11/include/asm-i386/mmx.h
===================================================================
--- linux-2.6.11.orig/include/asm-i386/mmx.h	2005-03-01 23:38:09.000000000 -0800
+++ linux-2.6.11/include/asm-i386/mmx.h	2005-03-24 14:12:53.000000000 -0800
@@ -9,6 +9,7 @@

 extern void *_mmx_memcpy(void *to, const void *from, size_t size);
 extern void mmx_clear_page(void *page);
+extern void mmx_clear_cold(void *page, unsigned int order);
 extern void mmx_copy_page(void *to, void *from);

 #endif
Index: linux-2.6.11/arch/i386/lib/mmx.c
===================================================================
--- linux-2.6.11.orig/arch/i386/lib/mmx.c	2005-03-01 23:38:09.000000000 -0800
+++ linux-2.6.11/arch/i386/lib/mmx.c	2005-03-24 14:12:53.000000000 -0800
@@ -397,3 +397,14 @@ void mmx_copy_page(void *to, void *from)
 	else
 		fast_copy_page(to, from);
 }
+
+/* FIXME: Make this a real cold zeroing function */
+void mmx_clear_cold(void *page, int order)
+{
+	int i;
+
+	for(i=0; i < (1 << order); i++) {
+		mmx_clear_page(page);
+		page += PAGE_SIZE;
+	}
+}
Index: linux-2.6.11/arch/x86_64/Kconfig
===================================================================
--- linux-2.6.11.orig/arch/x86_64/Kconfig	2005-03-24 13:15:37.000000000 -0800
+++ linux-2.6.11/arch/x86_64/Kconfig	2005-03-24 14:12:53.000000000 -0800
@@ -78,6 +78,10 @@ config GENERIC_IOMAP
 	bool
 	default y

+config CLEAR_COLD
+	bool
+	default y
+
 source "init/Kconfig"


Index: linux-2.6.11/include/asm-x86_64/page.h
===================================================================
--- linux-2.6.11.orig/include/asm-x86_64/page.h	2005-03-01 23:37:47.000000000 -0800
+++ linux-2.6.11/include/asm-x86_64/page.h	2005-03-24 14:12:53.000000000 -0800
@@ -33,6 +33,8 @@
 #ifndef __ASSEMBLY__

 void clear_page(void *);
+/* Clear arbitrary order page using non-temporal writes */
+void clear_cold(void *, int order);
 void copy_page(void *, void *);

 #define clear_user_page(page, vaddr, pg)	clear_page(page)
Index: linux-2.6.11/arch/x86_64/kernel/x8664_ksyms.c
===================================================================
--- linux-2.6.11.orig/arch/x86_64/kernel/x8664_ksyms.c	2005-03-24 13:15:37.000000000 -0800
+++ linux-2.6.11/arch/x86_64/kernel/x8664_ksyms.c	2005-03-24 14:12:53.000000000 -0800
@@ -108,6 +108,7 @@ EXPORT_SYMBOL(pci_mem_start);

 EXPORT_SYMBOL(copy_page);
 EXPORT_SYMBOL(clear_page);
+EXPORT_SYMBOL(clear_cold);

 EXPORT_SYMBOL(cpu_pda);
 #ifdef CONFIG_SMP
Index: linux-2.6.11/arch/x86_64/lib/clear_page.S
===================================================================
--- linux-2.6.11.orig/arch/x86_64/lib/clear_page.S	2005-03-01 23:38:08.000000000 -0800
+++ linux-2.6.11/arch/x86_64/lib/clear_page.S	2005-03-24 14:12:53.000000000 -0800
@@ -48,3 +48,57 @@ clear_page_c:
 	ret
 clear_page_c_end:
 	.previous
+
+
+/*
+ * Zero a page cold.
+ * rdi	page
+ * rsi	order
+ */
+	.globl clear_cold
+	.p2align 4
+clear_cold:
+	movl   $4096/64,%eax
+	movl	%esi, %ecx
+	shll	%cl, %eax
+	movl	%eax, %ecx
+	xorl   %eax,%eax
+	.p2align 4
+.Lcloop:
+	decl	%ecx
+#define PUTC(x) movq %rax,x*8(%rdi)
+	movq %rax,(%rdi)
+	PUTC(1)
+	PUTC(2)
+	PUTC(3)
+	PUTC(4)
+	PUTC(5)
+	PUTC(6)
+	PUTC(7)
+	leaq	64(%rdi),%rdi
+	jnz	.Lcloop
+	nop
+	ret
+clear_cold_end:
+
+	.section .altinstructions,"a"
+	.align 8
+	.quad  clear_cold
+	.quad  clear_cold_c
+	.byte  X86_FEATURE_K8_C
+	.byte  clear_cold_end-clear_cold
+	.byte  clear_cold_c_end-clear_cold_c
+	.previous
+
+	.section .altinstr_replacement,"ax"
+clear_cold_c:
+	movl $4096/8,%eax
+	movl %esi, %ecx
+	shll %cl, %eax
+	movl %eax, %ecx
+	xorl %eax,%eax
+	rep
+	stosq
+	ret
+clear_cold_c_end:
+	.previous
Index: linux-2.6.11/arch/sparc64/lib/clear_page.S
===================================================================
--- linux-2.6.11.orig/arch/sparc64/lib/clear_page.S	2005-03-01 23:38:17.000000000 -0800
+++ linux-2.6.11/arch/sparc64/lib/clear_page.S	2005-03-24 14:12:53.000000000 -0800
@@ -103,3 +103,82 @@ clear_page_common:
 out:	retl
 	 nop

+	.globl		clear_cold
+clear_cold:		/* %o0=dest, %o1=order */
+	sethi		%hi(PAGE_SIZE/64), %o2
+	clr		%o4
+	or		%o2, %lo(PAGE_SIZE/64), %o2
+	ba,pt		%xcc, clear_cold_common
+	 sllx		%o2, %o1, %o1
+
+	/* This thing is pretty important, it shows up
+	 * on the profiles via do_anonymous_page().
+	 */
+	.align		32
+	.globl		clear_cold_page
+clear_cold_user_page:	/* %o0=dest, %o1=vaddr */
+	lduw		[%g6 + TI_PRE_COUNT], %o2
+	sethi		%uhi(PAGE_OFFSET), %g2
+	sethi		%hi(PAGE_SIZE), %o4
+
+	sllx		%g2, 32, %g2
+	sethi		%uhi(TTE_BITS_TOP), %g3
+
+	sllx		%g3, 32, %g3
+	sub		%o0, %g2, %g1		! paddr
+
+	or		%g3, TTE_BITS_BOTTOM, %g3
+	and		%o1, %o4, %o0		! vaddr D-cache alias bit
+
+	or		%g1, %g3, %g1		! TTE data
+	sethi		%hi(TLBTEMP_BASE), %o3
+
+	add		%o2, 1, %o4
+	add		%o0, %o3, %o0		! TTE vaddr
+
+	/* Disable preemption.  */
+	mov		TLB_TAG_ACCESS, %g3
+	stw		%o4, [%g6 + TI_PRE_COUNT]
+
+	/* Load TLB entry.  */
+	rdpr		%pstate, %o4
+	wrpr		%o4, PSTATE_IE, %pstate
+	stxa		%o0, [%g3] ASI_DMMU
+	stxa		%g1, [%g0] ASI_DTLB_DATA_IN
+	flush		%g6
+	wrpr		%o4, 0x0, %pstate
+
+	sethi		%hi(PAGE_SIZE/64), %o1
+	mov		1, %o4
+	or		%o1, %lo(PAGE_SIZE/64), %o1
+
+clear_cold_common:
+	VISEntryHalf
+	membar		#StoreLoad | #StoreStore | #LoadStore
+	fzero		%f0
+	mov		%o0, %g1		! remember vaddr for tlbflush
+	fzero		%f2
+	faddd		%f0, %f2, %f4
+	fmuld		%f0, %f2, %f6
+	faddd		%f0, %f2, %f8
+	fmuld		%f0, %f2, %f10
+
+	faddd		%f0, %f2, %f12
+	fmuld		%f0, %f2, %f14
+2:	stda		%f0, [%o0 + %g0] ASI_BLK_P
+	subcc		%o1, 1, %o1
+	bne,pt		%icc, 2b
+	 add		%o0, 0x40, %o0
+	membar		#Sync
+	VISExitHalf
+
+	brz,pn		%o4, outcold
+	 nop
+
+	stxa		%g0, [%g1] ASI_DMMU_DEMAP
+	membar		#Sync
+	stw		%o2, [%g6 + TI_PRE_COUNT]
+
+outcold:	retl
+	 nop
+
Index: linux-2.6.11/include/asm-sparc64/page.h
===================================================================
--- linux-2.6.11.orig/include/asm-sparc64/page.h	2005-03-01 23:38:07.000000000 -0800
+++ linux-2.6.11/include/asm-sparc64/page.h	2005-03-24 14:12:53.000000000 -0800
@@ -16,6 +16,8 @@

 extern void _clear_page(void *page);
 #define clear_page(X)	_clear_page((void *)(X))
+/* Non temporal clear an arbitrary order page */
+extern void clear_cold(void *page, unsigned int order);
 struct page;
 extern void clear_user_page(void *addr, unsigned long vaddr, struct page *page);
 #define copy_page(X,Y)	memcpy((void *)(X), (void *)(Y), PAGE_SIZE)
Index: linux-2.6.11/arch/sparc64/Kconfig
===================================================================
--- linux-2.6.11.orig/arch/sparc64/Kconfig	2005-03-01 23:38:25.000000000 -0800
+++ linux-2.6.11/arch/sparc64/Kconfig	2005-03-24 14:12:53.000000000 -0800
@@ -16,6 +16,10 @@ config TIME_INTERPOLATION
 	bool
 	default y

+config CLEAR_COLD
+	bool
+	default y
+
 source "init/Kconfig"

 config SYSVIPC_COMPAT
