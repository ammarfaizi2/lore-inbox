Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263320AbREWXit>; Wed, 23 May 2001 19:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263321AbREWXik>; Wed, 23 May 2001 19:38:40 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:54541 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S263320AbREWXi2>;
	Wed, 23 May 2001 19:38:28 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15116.18879.19957.796622@tango.paulus.ozlabs.org>
Date: Thu, 24 May 2001 09:37:35 +1000 (EST)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: add page argument to copy/clear_user_page
In-Reply-To: <Pine.LNX.4.21.0105221012530.19531-100000@penguin.transmeta.com>
In-Reply-To: <15112.22465.860419.234933@tango.paulus.ozlabs.org>
	<Pine.LNX.4.21.0105221012530.19531-100000@penguin.transmeta.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> > As for the `to' argument, yes it is redundant since it is just kmap(page).
> 
> And why not let "clear_page()" just do that itself?

OK, here's a patch that does that.

> The thing is, copy/clear_page shouldn't exist at all (or rather, the
> "highpage" versions should be renamed to the non-highpage names, because
> the non-highmem case simply isn't interesting any more).

Each architecture already had a clear_page that was functionally
equivalent to memset(p, 0, PAGE_SIZE), but often in assembler, and
likewise a copy_page that was equivalent to memcpy(d, s, PAGE_SIZE).
So I renamed all the existing clear_page's and copy_page's to
__clear_page and __copy_page (since they are "lower-level" or "raw"
clear/copy page routines).

In highmem.h I have renamed copy_highpage to copy_page and
clear_highpage to clear_page.  I also have default versions of
copy_user_page and clear_user_page which just do copy_page/clear_page
for those architectures that don't have any cache issues to deal
with.  Architectures can define __HAVE_ARCH_USER_PAGE in asm/page.h
and then define their own copy/clear_user_page routines if they want
to.

I have fixed up all the architectures except sparc64.  There the
copy/clear_user_page routines are in assembler and my sparc assembler
is pretty rusty these days (particularly when DaveM goes doing hairy
things with the %g registers :).  I'll let Dave fix that one up; the
change is that copy/clear_user_page take page * arguments instead of
void * arguments.

This patch is a fair bit bigger than the last one, but most of the
bulk is just the renaming of clear_page to __clear_page and copy_page
to __copy_page.  I also renamed memclear_highpage to memclear_page
(which isn't actually used anywhere) and memclear_highpage_flush to
memclear_page_flush.

Let me know what you think of this; if it's OK, could you apply it to
your tree?

Thanks,
Paul.

diff -urN linux/Documentation/cachetlb.txt linux.new/Documentation/cachetlb.txt
--- linux/Documentation/cachetlb.txt	Sat Mar 31 03:05:54 2001
+++ linux.new/Documentation/cachetlb.txt	Wed May 23 20:48:38 2001
@@ -260,8 +260,9 @@
 
 Here is the new interface:
 
-  void copy_user_page(void *to, void *from, unsigned long address)
-  void clear_user_page(void *to, unsigned long address)
+  void copy_user_page(struct page *to, struct page *from,
+		      unsigned long address)
+  void clear_user_page(struct page *to, unsigned long address)
 
 	These two routines store data in user anonymous or COW
 	pages.  It allows a port to efficiently avoid D-cache alias
@@ -279,6 +280,11 @@
 
 	If D-cache aliasing is not an issue, these two routines may
 	simply call memcpy/memset directly and do nothing more.
+
+	There are default versions of these procedures supplied in
+	include/linux/highmem.h.  If a port does not want to use the
+	default versions it should declare them and define the symbol
+	__HAVE_ARCH_USER_PAGE in include/asm/page.h.
 
   void flush_dcache_page(struct page *page)
 
diff -urN linux/arch/alpha/kernel/alpha_ksyms.c linux.new/arch/alpha/kernel/alpha_ksyms.c
--- linux/arch/alpha/kernel/alpha_ksyms.c	Sat Apr 28 23:02:30 2001
+++ linux.new/arch/alpha/kernel/alpha_ksyms.c	Wed May 23 20:39:23 2001
@@ -98,8 +98,8 @@
 EXPORT_SYMBOL(__memset);
 EXPORT_SYMBOL(__memsetw);
 EXPORT_SYMBOL(__constant_c_memset);
-EXPORT_SYMBOL(copy_page);
-EXPORT_SYMBOL(clear_page);
+EXPORT_SYMBOL(__copy_page);
+EXPORT_SYMBOL(__clear_page);
 
 EXPORT_SYMBOL(__direct_map_base);
 EXPORT_SYMBOL(__direct_map_size);
diff -urN linux/arch/alpha/lib/clear_page.S linux.new/arch/alpha/lib/clear_page.S
--- linux/arch/alpha/lib/clear_page.S	Thu Feb 22 14:24:52 2001
+++ linux.new/arch/alpha/lib/clear_page.S	Wed May 23 20:39:23 2001
@@ -6,9 +6,9 @@
 
 	.text
 	.align 4
-	.global clear_page
-	.ent clear_page
-clear_page:
+	.global __clear_page
+	.ent __clear_page
+__clear_page:
 	.prologue 0
 
 	lda	$0,128
@@ -36,4 +36,4 @@
 	unop
 	nop
 
-	.end clear_page
+	.end __clear_page
diff -urN linux/arch/alpha/lib/copy_page.S linux.new/arch/alpha/lib/copy_page.S
--- linux/arch/alpha/lib/copy_page.S	Thu Feb 22 14:24:52 2001
+++ linux.new/arch/alpha/lib/copy_page.S	Wed May 23 21:05:31 2001
@@ -6,9 +6,9 @@
 
 	.text
 	.align 4
-	.global copy_page
-	.ent copy_page
-copy_page:
+	.global __copy_page
+	.ent __copy_page
+__copy_page:
 	.prologue 0
 
 	lda	$18,128
@@ -46,4 +46,4 @@
 	unop
 	nop
 
-	.end copy_page
+	.end __copy_page
diff -urN linux/arch/alpha/lib/ev6-clear_page.S linux.new/arch/alpha/lib/ev6-clear_page.S
--- linux/arch/alpha/lib/ev6-clear_page.S	Thu Feb 22 14:24:52 2001
+++ linux.new/arch/alpha/lib/ev6-clear_page.S	Wed May 23 20:39:23 2001
@@ -6,9 +6,9 @@
 
         .text
         .align 4
-        .global clear_page
-        .ent clear_page
-clear_page:
+        .global __clear_page
+        .ent __clear_page
+__clear_page:
         .prologue 0
 
 	lda	$0,128
@@ -51,4 +51,4 @@
 	nop
 	nop
 
-	.end clear_page
+	.end __clear_page
diff -urN linux/arch/alpha/lib/ev6-copy_page.S linux.new/arch/alpha/lib/ev6-copy_page.S
--- linux/arch/alpha/lib/ev6-copy_page.S	Thu Feb 22 14:24:52 2001
+++ linux.new/arch/alpha/lib/ev6-copy_page.S	Wed May 23 21:05:31 2001
@@ -59,9 +59,9 @@
 
 	.text
 	.align 4
-	.global copy_page
-	.ent copy_page
-copy_page:
+	.global __copy_page
+	.ent __copy_page
+__copy_page:
 	.prologue 0
 
 	/* Prefetch 5 read cachelines; write-hint 10 cache lines.  */
@@ -200,4 +200,4 @@
 	unop
 	nop
 
-	.end copy_page
+	.end __copy_page
diff -urN linux/arch/alpha/mm/init.c linux.new/arch/alpha/mm/init.c
--- linux/arch/alpha/mm/init.c	Sat Apr 28 23:02:30 2001
+++ linux.new/arch/alpha/mm/init.c	Wed May 23 20:43:32 2001
@@ -51,7 +51,7 @@
 	ret = (pgd_t *)__get_free_page(GFP_KERNEL);
 	init = pgd_offset(&init_mm, 0UL);
 	if (ret) {
-		clear_page(ret);
+		__clear_page(ret);
 #ifdef CONFIG_ALPHA_LARGE_VMALLOC
 		memcpy (ret + USER_PTRS_PER_PGD, init + USER_PTRS_PER_PGD,
 			(PTRS_PER_PGD - USER_PTRS_PER_PGD - 1)*sizeof(pgd_t));
diff -urN linux/arch/arm/lib/copy_page.S linux.new/arch/arm/lib/copy_page.S
--- linux/arch/arm/lib/copy_page.S	Sat Mar 31 03:05:55 2001
+++ linux.new/arch/arm/lib/copy_page.S	Wed May 23 21:05:31 2001
@@ -16,12 +16,12 @@
 		.text
 		.align	5
 /*
- * StrongARM optimised copy_page routine
+ * StrongARM optimised __copy_page routine
  * now 1.78bytes/cycle, was 1.60 bytes/cycle (50MHz bus -> 89MB/s)
  * Note that we probably achieve closer to the 100MB/s target with
  * the core clock switching.
  */
-ENTRY(copy_page)
+ENTRY(__copy_page)
 		stmfd	sp!, {r4, lr}			@	2
 		mov	r2, #PAGE_SZ/64			@	1
 		ldmia	r1!, {r3, r4, ip, lr}		@	4+1
diff -urN linux/arch/ia64/kernel/ia64_ksyms.c linux.new/arch/ia64/kernel/ia64_ksyms.c
--- linux/arch/ia64/kernel/ia64_ksyms.c	Sat Apr 28 23:02:32 2001
+++ linux.new/arch/ia64/kernel/ia64_ksyms.c	Wed May 23 20:39:23 2001
@@ -53,7 +53,7 @@
 EXPORT_SYMBOL_NOVERS(__rwsem_wake);
 
 #include <asm/page.h>
-EXPORT_SYMBOL(clear_page);
+EXPORT_SYMBOL(__clear_page);
 
 #include <asm/processor.h>
 EXPORT_SYMBOL(cpu_data);
diff -urN linux/arch/ia64/lib/clear_page.S linux.new/arch/ia64/lib/clear_page.S
--- linux/arch/ia64/lib/clear_page.S	Sat Apr 28 23:02:32 2001
+++ linux.new/arch/ia64/lib/clear_page.S	Wed May 23 20:39:23 2001
@@ -17,7 +17,7 @@
 #include <asm/asmmacro.h>
 #include <asm/page.h>
 
-GLOBAL_ENTRY(clear_page)
+GLOBAL_ENTRY(__clear_page)
 	.prologue
 	alloc r11=ar.pfs,1,0,0,0
 	.save ar.lc, r16
@@ -36,4 +36,4 @@
 	;;
 	mov ar.lc=r16		// restore lc
 	br.ret.sptk.few rp
-END(clear_page)
+END(__clear_page)
diff -urN linux/arch/ia64/lib/copy_page.S linux.new/arch/ia64/lib/copy_page.S
--- linux/arch/ia64/lib/copy_page.S	Sat Apr 28 23:02:32 2001
+++ linux.new/arch/ia64/lib/copy_page.S	Wed May 23 21:05:31 2001
@@ -1,6 +1,6 @@
 /*
  *
- * Optimized version of the standard copy_page() function
+ * Optimized version of the standard __copy_page() function
  *
  * Based on comments from ddd. Try not to overflow write buffer.
  *
@@ -28,7 +28,7 @@
 #define tgt1		r22
 #define tgt2		r23
 
-GLOBAL_ENTRY(copy_page)
+GLOBAL_ENTRY(__copy_page)
 	.prologue
 	.save ar.pfs, saved_pfs
 	alloc saved_pfs=ar.pfs,3,((2*PIPE_DEPTH+7)&~7),0,((2*PIPE_DEPTH+7)&~7)
@@ -85,4 +85,4 @@
 	mov ar.pfs=saved_pfs	// restore ar.ec
 	mov ar.lc=saved_lc	// restore saved lc
 	br.ret.sptk.few rp	// bye...
-END(copy_page)
+END(__copy_page)
diff -urN linux/arch/ia64/mm/init.c linux.new/arch/ia64/mm/init.c
--- linux/arch/ia64/mm/init.c	Sat Apr 28 23:02:32 2001
+++ linux.new/arch/ia64/mm/init.c	Wed May 23 20:39:23 2001
@@ -310,7 +310,7 @@
 {
 	unsigned long max_dma, zones_size[MAX_NR_ZONES];
 
-	clear_page((void *) ZERO_PAGE_ADDR);
+	__clear_page((void *) ZERO_PAGE_ADDR);
 
 	/* initialize mem_map[] */
 
diff -urN linux/arch/m68k/mm/memory.c linux.new/arch/m68k/mm/memory.c
--- linux/arch/m68k/mm/memory.c	Wed May 23 20:29:11 2001
+++ linux.new/arch/m68k/mm/memory.c	Wed May 23 20:39:23 2001
@@ -46,7 +46,7 @@
 	pte = (pte_t *) __get_free_page(GFP_KERNEL);
 	if (pmd_none(*pmd)) {
 		if (pte) {
-			clear_page(pte);
+			__clear_page(pte);
 			__flush_page_to_ram((unsigned long)pte);
 			flush_tlb_kernel_page((unsigned long)pte);
 			nocache_page((unsigned long)pte);
diff -urN linux/arch/m68k/mm/motorola.c linux.new/arch/m68k/mm/motorola.c
--- linux/arch/m68k/mm/motorola.c	Sat Apr 28 23:02:35 2001
+++ linux.new/arch/m68k/mm/motorola.c	Wed May 23 20:39:23 2001
@@ -51,7 +51,7 @@
 
 	ptablep = (pte_t *)alloc_bootmem_low_pages(PAGE_SIZE);
 
-	clear_page(ptablep);
+	__clear_page(ptablep);
 	__flush_page_to_ram((unsigned long) ptablep);
 	flush_tlb_kernel_page((unsigned long) ptablep);
 	nocache_page ((unsigned long)ptablep);
@@ -90,7 +90,7 @@
 	if (((unsigned long)(last_pgtable + PTRS_PER_PMD) & ~PAGE_MASK) == 0) {
 		last_pgtable = (pmd_t *)alloc_bootmem_low_pages(PAGE_SIZE);
 
-		clear_page(last_pgtable);
+		__clear_page(last_pgtable);
 		__flush_page_to_ram((unsigned long)last_pgtable);
 		flush_tlb_kernel_page((unsigned long)last_pgtable);
 		nocache_page((unsigned long)last_pgtable);
diff -urN linux/arch/mips/mm/init.c linux.new/arch/mips/mm/init.c
--- linux/arch/mips/mm/init.c	Tue Oct 17 06:58:51 2000
+++ linux.new/arch/mips/mm/init.c	Wed May 23 20:39:23 2001
@@ -64,7 +64,7 @@
 	page = (pte_t *) __get_free_page(GFP_USER);
 	if (pmd_none(*pmd)) {
 		if (page) {
-			clear_page(page);
+			__clear_page(page);
 			pmd_val(*pmd) = (unsigned long)page;
 			return page + offset;
 		}
@@ -86,7 +86,7 @@
 	page = (pte_t *) __get_free_page(GFP_KERNEL);
 	if (pmd_none(*pmd)) {
 		if (page) {
-			clear_page(page);
+			__clear_page(page);
 			pmd_val(*pmd) = (unsigned long)page;
 			return page + offset;
 		}
@@ -207,7 +207,7 @@
 	extern char empty_bad_page[PAGE_SIZE];
 	unsigned long page = (unsigned long) empty_bad_page;
 
-	clear_page((void *)page);
+	__clear_page((void *)page);
 	return pte_mkdirty(mk_pte_phys(__pa(page), PAGE_SHARED));
 }
 
diff -urN linux/arch/mips64/mm/init.c linux.new/arch/mips64/mm/init.c
--- linux/arch/mips64/mm/init.c	Tue Oct 17 06:58:51 2000
+++ linux.new/arch/mips64/mm/init.c	Wed May 23 20:39:23 2001
@@ -142,7 +142,7 @@
 	page = (pte_t *) __get_free_pages(GFP_USER, 1);
 	if (pmd_none(*pmd)) {
 		if (page) {
-			clear_page(page);
+			__clear_page(page);
 			pmd_set(pmd, page);
 			return page + offset;
 		}
@@ -164,7 +164,7 @@
 	page = (pte_t *) __get_free_pages(GFP_KERNEL, 0);
 	if (pmd_none(*pmd)) {
 		if (page) {
-			clear_page(page);
+			__clear_page(page);
 			pmd_val(*pmd) = (unsigned long)page;
 			return page + offset;
 		}
diff -urN linux/arch/parisc/mm/init.c linux.new/arch/parisc/mm/init.c
--- linux/arch/parisc/mm/init.c	Wed Dec  6 07:29:39 2000
+++ linux.new/arch/parisc/mm/init.c	Wed May 23 20:39:23 2001
@@ -82,7 +82,7 @@
 
 	if (pmd_none(*pmd)) {
 		if (pte) {
-			clear_page(pte);
+			__clear_page(pte);
 			pmd_val(*pmd) = _PAGE_TABLE + __pa((unsigned long)pte);
 			return pte + offset;
 		}
diff -urN linux/arch/parisc/mm/pa11.c linux.new/arch/parisc/mm/pa11.c
--- linux/arch/parisc/mm/pa11.c	Wed Dec  6 07:29:39 2000
+++ linux.new/arch/parisc/mm/pa11.c	Wed May 23 20:39:23 2001
@@ -141,8 +141,8 @@
 {
 
     /* Taken directly from the MIPS arch..  Lots of bad things here */
-	clear_page = pa11_clear_page;
-	copy_page = pa11_copy_page;
+	__clear_page = pa11_clear_page;
+	__copy_page = pa11_copy_page;
 
 	flush_cache_all = pa11_flush_cache_all;
 	flush_cache_mm = pa11_flush_cache_mm;
diff -urN linux/arch/parisc/mm/pa20.c linux.new/arch/parisc/mm/pa20.c
--- linux/arch/parisc/mm/pa20.c	Wed Dec  6 07:29:39 2000
+++ linux.new/arch/parisc/mm/pa20.c	Wed May 23 20:39:23 2001
@@ -141,8 +141,8 @@
 {
 
     /* Taken directly from the MIPS arch..  Lots of bad things here */
-	clear_page = pa20_clear_page;
-	copy_page = pa20_copy_page;
+	__clear_page = pa20_clear_page;
+	__copy_page = pa20_copy_page;
 
 	flush_cache_all = pa20_flush_cache_all;
 	flush_cache_mm = pa20_flush_cache_mm;
diff -urN linux/arch/ppc/kernel/misc.S linux.new/arch/ppc/kernel/misc.S
--- linux/arch/ppc/kernel/misc.S	Wed May 23 20:29:13 2001
+++ linux.new/arch/ppc/kernel/misc.S	Wed May 23 21:05:31 2001
@@ -388,7 +388,7 @@
  * memory traffic (except to write out any cache lines which get
  * displaced).  This only works on cacheable memory.
  */
-_GLOBAL(clear_page)
+_GLOBAL(__clear_page)
 	li	r0,4096/CACHE_LINE_SIZE
 	mtctr	r0
 #ifdef CONFIG_8xx
@@ -420,7 +420,7 @@
 	stw	r8,12(r3);	\
 	stwu	r9,16(r3)
 
-_GLOBAL(copy_page)
+_GLOBAL(__copy_page)
 	addi	r3,r3,-4
 	addi	r4,r4,-4
 	li	r5,4
diff -urN linux/arch/ppc/kernel/ppc_ksyms.c linux.new/arch/ppc/kernel/ppc_ksyms.c
--- linux/arch/ppc/kernel/ppc_ksyms.c	Wed May 23 20:29:13 2001
+++ linux.new/arch/ppc/kernel/ppc_ksyms.c	Wed May 23 20:39:23 2001
@@ -73,7 +73,7 @@
 int abs(int);
 extern unsigned long ret_to_user_hook;
 
-EXPORT_SYMBOL(clear_page);
+EXPORT_SYMBOL(__clear_page);
 EXPORT_SYMBOL(do_signal);
 EXPORT_SYMBOL(syscall_trace);
 EXPORT_SYMBOL(transfer_to_handler);
diff -urN linux/arch/ppc/mm/init.c linux.new/arch/ppc/mm/init.c
--- linux/arch/ppc/mm/init.c	Wed May 23 20:29:14 2001
+++ linux.new/arch/ppc/mm/init.c	Wed May 23 20:39:23 2001
@@ -228,7 +228,7 @@
 
 pte_t * __bad_pagetable(void)
 {
-	clear_page(empty_bad_page_table);
+	__clear_page(empty_bad_page_table);
 	return empty_bad_page_table;
 }
 
@@ -236,7 +236,7 @@
 
 pte_t __bad_page(void)
 {
-	clear_page(empty_bad_page);
+	__clear_page(empty_bad_page);
 	return pte_mkdirty(mk_pte_phys(__pa(empty_bad_page), PAGE_SHARED));
 }
 
diff -urN linux/arch/sh/mm/cache.c linux.new/arch/sh/mm/cache.c
--- linux/arch/sh/mm/cache.c	Wed May 23 20:29:14 2001
+++ linux.new/arch/sh/mm/cache.c	Wed May 23 21:05:31 2001
@@ -507,17 +507,26 @@
 /* Page is 4K, OC size is 16K, there are four lines. */
 #define CACHE_ALIAS 0x00003000
 
-void clear_user_page(void *to, unsigned long address)
+void clear_user_page(struct page *to_page, unsigned long address)
 {
-	clear_page(to);
+	void *to = kmap(to_page);
+
+	__clear_page(to);
 	if (((address ^ (unsigned long)to) & CACHE_ALIAS))
 		__flush_page_to_ram(to);
+	kunmap(to_pg);
 }
 
-void copy_user_page(void *to, void *from, unsigned long address)
+void copy_user_page(struct page *to_pg, struct page *from_pg,
+		    unsigned long address)
 {
-	copy_page(to, from);
+	void *to = kmap(to_pg);
+	void *from = kmap(from_pg);
+
+	__copy_page(to, from);
 	if (((address ^ (unsigned long)to) & CACHE_ALIAS))
 		__flush_page_to_ram(to);
+	kunmap(to_pg);
+	kunmap(from_pg);
 }
 #endif
diff -urN linux/include/asm-alpha/page.h linux.new/include/asm-alpha/page.h
--- linux/include/asm-alpha/page.h	Thu Feb 22 14:25:37 2001
+++ linux.new/include/asm-alpha/page.h	Wed May 23 20:39:23 2001
@@ -12,11 +12,8 @@
 
 #define STRICT_MM_TYPECHECKS
 
-extern void clear_page(void *page);
-#define clear_user_page(page, vaddr)	clear_page(page)
-
-extern void copy_page(void * _to, void * _from);
-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
+extern void __clear_page(void *page);
+extern void __copy_page(void * _to, void * _from);
 
 #ifdef STRICT_MM_TYPECHECKS
 /*
diff -urN linux/include/asm-alpha/pgalloc.h linux.new/include/asm-alpha/pgalloc.h
--- linux/include/asm-alpha/pgalloc.h	Sat Apr 28 23:02:52 2001
+++ linux.new/include/asm-alpha/pgalloc.h	Wed May 23 20:39:23 2001
@@ -275,7 +275,7 @@
 {
 	pmd_t *ret = (pmd_t *)__get_free_page(GFP_KERNEL);
 	if (ret)
-		clear_page(ret);
+		__clear_page(ret);
 	return ret;
 }
 
@@ -307,7 +307,7 @@
 {
 	pte_t *pte = (pte_t *)__get_free_page(GFP_KERNEL);
 	if (pte)
-		clear_page(pte);
+		__clear_page(pte);
 	return pte;
 }
 
diff -urN linux/include/asm-arm/page.h linux.new/include/asm-arm/page.h
--- linux/include/asm-arm/page.h	Mon Aug 14 02:54:15 2000
+++ linux.new/include/asm-arm/page.h	Wed May 23 20:39:23 2001
@@ -11,11 +11,8 @@
 
 #define STRICT_MM_TYPECHECKS
 
-#define clear_page(page)	memzero((void *)(page), PAGE_SIZE)
-extern void copy_page(void *to, void *from);
-
-#define clear_user_page(page, vaddr)	clear_page(page)
-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
+#define __clear_page(page)	memzero((void *)(page), PAGE_SIZE)
+extern void __copy_page(void *to, void *from);
 
 #ifdef STRICT_MM_TYPECHECKS
 /*
diff -urN linux/include/asm-cris/page.h linux.new/include/asm-cris/page.h
--- linux/include/asm-cris/page.h	Thu Feb 22 14:25:38 2001
+++ linux.new/include/asm-cris/page.h	Wed May 23 20:42:48 2001
@@ -11,11 +11,8 @@
 
 #ifdef __KERNEL__
 
-#define clear_page(page)        memset((void *)(page), 0, PAGE_SIZE)
-#define copy_page(to,from)      memcpy((void *)(to), (void *)(from), PAGE_SIZE)
-
-#define clear_user_page(page, vaddr)    clear_page(page)
-#define copy_user_page(to, from, vaddr) copy_page(to, from)
+#define __clear_page(page)        memset((void *)(page), 0, PAGE_SIZE)
+#define __copy_page(to,from)      memcpy((void *)(to), (void *)(from), PAGE_SIZE)
 
 #define STRICT_MM_TYPECHECKS
 
diff -urN linux/include/asm-cris/pgalloc.h linux.new/include/asm-cris/pgalloc.h
--- linux/include/asm-cris/pgalloc.h	Wed May 23 20:29:24 2001
+++ linux.new/include/asm-cris/pgalloc.h	Wed May 23 20:42:48 2001
@@ -64,7 +64,7 @@
 
         pte = (pte_t *) __get_free_page(GFP_KERNEL);
         if (pte)
-                clear_page(pte);
+                __clear_page(pte);
         return pte;
 }
 
diff -urN linux/include/asm-i386/page.h linux.new/include/asm-i386/page.h
--- linux/include/asm-i386/page.h	Fri Jan  5 09:50:46 2001
+++ linux.new/include/asm-i386/page.h	Wed May 23 20:39:23 2001
@@ -15,8 +15,8 @@
 
 #include <asm/mmx.h>
 
-#define clear_page(page)	mmx_clear_page(page)
-#define copy_page(to,from)	mmx_copy_page(to,from)
+#define __clear_page(page)	mmx_clear_page(page)
+#define __copy_page(to,from)	mmx_copy_page(to,from)
 
 #else
 
@@ -25,13 +25,10 @@
  *	Maybe the K6-III ?
  */
  
-#define clear_page(page)	memset((void *)(page), 0, PAGE_SIZE)
-#define copy_page(to,from)	memcpy((void *)(to), (void *)(from), PAGE_SIZE)
+#define __clear_page(page)	memset((void *)(page), 0, PAGE_SIZE)
+#define __copy_page(to,from)	memcpy((void *)(to), (void *)(from), PAGE_SIZE)
 
 #endif
-
-#define clear_user_page(page, vaddr)	clear_page(page)
-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
 
 /*
  * These are used to make use of C type-checking..
diff -urN linux/include/asm-i386/pgalloc.h linux.new/include/asm-i386/pgalloc.h
--- linux/include/asm-i386/pgalloc.h	Sat Apr 28 23:02:52 2001
+++ linux.new/include/asm-i386/pgalloc.h	Wed May 23 20:39:23 2001
@@ -33,7 +33,7 @@
 			unsigned long pmd = __get_free_page(GFP_KERNEL);
 			if (!pmd)
 				goto out_oom;
-			clear_page(pmd);
+			__clear_page(pmd);
 			set_pgd(pgd + i, __pgd(1 + __pa(pmd)));
 		}
 		memcpy(pgd + USER_PTRS_PER_PGD, swapper_pg_dir + USER_PTRS_PER_PGD, (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
@@ -100,7 +100,7 @@
 
 	pte = (pte_t *) __get_free_page(GFP_KERNEL);
 	if (pte)
-		clear_page(pte);
+		__clear_page(pte);
 	return pte;
 }
 
diff -urN linux/include/asm-ia64/page.h linux.new/include/asm-ia64/page.h
--- linux/include/asm-ia64/page.h	Sat Apr 28 23:02:53 2001
+++ linux.new/include/asm-ia64/page.h	Wed May 23 20:39:23 2001
@@ -37,8 +37,8 @@
 # ifdef __KERNEL__
 #  define STRICT_MM_TYPECHECKS
 
-extern void clear_page (void *page);
-extern void copy_page (void *to, void *from);
+extern void __clear_page (void *page);
+extern void __copy_page (void *to, void *from);
 
 /*
  * Note: the MAP_NR_*() macro can't use __pa() because MAP_NR_*(X) MUST
diff -urN linux/include/asm-ia64/pgalloc.h linux.new/include/asm-ia64/pgalloc.h
--- linux/include/asm-ia64/pgalloc.h	Sat Apr 28 23:02:53 2001
+++ linux.new/include/asm-ia64/pgalloc.h	Wed May 23 22:43:04 2001
@@ -56,7 +56,7 @@
 	if (__builtin_expect(pgd == NULL, 0)) {
 		pgd = (pgd_t *)__get_free_page(GFP_KERNEL);
 		if (__builtin_expect(pgd != NULL, 1))
-			clear_page(pgd);
+			__clear_page(pgd);
 	}
 	return pgd;
 }
@@ -95,7 +95,7 @@
 	pmd_t *pmd = (pmd_t *) __get_free_page(GFP_KERNEL);
 
 	if (__builtin_expect(pmd != NULL, 1))
-		clear_page(pmd);
+		__clear_page(pmd);
 	return pmd;
 }
 
@@ -133,7 +133,7 @@
 	pte_t *pte = (pte_t *) __get_free_page(GFP_KERNEL);
 
 	if (__builtin_expect(pte != NULL, 1))
-		clear_page(pte);
+		__clear_page(pte);
 	return pte;
 }
 
@@ -234,18 +234,20 @@
 	clear_bit(PG_arch_1, &page->flags);
 }
 
+#define __HAVE_ARCH_USER_PAGE
+
 static inline void
-clear_user_page (void *addr, unsigned long vaddr, struct page *page)
+clear_user_page (struct page *page, unsigned long vaddr)
 {
-	clear_page(addr);
+	clear_page(page);
 	flush_dcache_page(page);
 }
 
 static inline void
-copy_user_page (void *to, void *from, unsigned long vaddr, struct page *page)
+copy_user_page (struct page *to, struct page *from, unsigned long vaddr)
 {
 	copy_page(to, from);
-	flush_dcache_page(page);
+	flush_dcache_page(to);
 }
 
 /*
diff -urN linux/include/asm-m68k/page.h linux.new/include/asm-m68k/page.h
--- linux/include/asm-m68k/page.h	Tue Nov 28 13:00:49 2000
+++ linux.new/include/asm-m68k/page.h	Wed May 23 21:05:31 2001
@@ -32,7 +32,7 @@
  * We don't need to check for alignment etc.
  */
 #ifdef CPU_M68040_OR_M68060_ONLY
-static inline void copy_page(void *to, void *from)
+static inline void __copy_page(void *to, void *from)
 {
   unsigned long tmp;
 
@@ -47,7 +47,7 @@
 		       );
 }
 
-static inline void clear_page(void *page)
+static inline void __clear_page(void *page)
 {
 	unsigned long data, tmp;
 	void *sp = page;
@@ -72,12 +72,9 @@
 }
 
 #else
-#define clear_page(page)	memset((page), 0, PAGE_SIZE)
-#define copy_page(to,from)	memcpy((to), (from), PAGE_SIZE)
+#define __clear_page(page)	memset((page), 0, PAGE_SIZE)
+#define __copy_page(to,from)	memcpy((to), (from), PAGE_SIZE)
 #endif
-
-#define clear_user_page(page, vaddr)	clear_page(page)
-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
 
 /*
  * These are used to make use of C type-checking..
diff -urN linux/include/asm-mips/page.h linux.new/include/asm-mips/page.h
--- linux/include/asm-mips/page.h	Thu Aug 10 06:46:02 2000
+++ linux.new/include/asm-mips/page.h	Wed May 23 20:39:23 2001
@@ -26,10 +26,8 @@
 extern void (*_clear_page)(void * page);
 extern void (*_copy_page)(void * to, void * from);
 
-#define clear_page(page)	_clear_page(page)
-#define copy_page(to, from)	_copy_page(to, from)
-#define clear_user_page(page, vaddr)	clear_page(page)
-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
+#define __clear_page(page)	_clear_page(page)
+#define __copy_page(to, from)	_copy_page(to, from)
 
 /*
  * These are used to make use of C type-checking..
diff -urN linux/include/asm-mips64/page.h linux.new/include/asm-mips64/page.h
--- linux/include/asm-mips64/page.h	Thu Aug 10 06:46:02 2000
+++ linux.new/include/asm-mips64/page.h	Wed May 23 20:39:23 2001
@@ -26,10 +26,8 @@
 extern void (*_clear_page)(void * page);
 extern void (*_copy_page)(void * to, void * from);
 
-#define clear_page(page)	_clear_page(page)
-#define copy_page(to, from)	_copy_page(to, from)
-#define clear_user_page(page, vaddr)	clear_page(page)
-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
+#define __clear_page(page)	_clear_page(page)
+#define __copy_page(to, from)	_copy_page(to, from)
 
 /*
  * These are used to make use of C type-checking..
diff -urN linux/include/asm-parisc/page.h linux.new/include/asm-parisc/page.h
--- linux/include/asm-parisc/page.h	Wed Dec  6 07:29:39 2000
+++ linux.new/include/asm-parisc/page.h	Wed May 23 20:42:48 2001
@@ -9,11 +9,8 @@
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
 
-#define clear_page(page)	memset((void *)(page), 0, PAGE_SIZE)
-#define copy_page(to,from)	memcpy((void *)(to), (void *)(from), PAGE_SIZE)
-
-#define clear_user_page(page, vaddr) clear_page(page)
-#define copy_user_page(to, from, vaddr) copy_page(to, from)
+#define __clear_page(page)	memset((void *)(page), 0, PAGE_SIZE)
+#define __copy_page(to,from)	memcpy((void *)(to), (void *)(from), PAGE_SIZE)
 
 /*
  * These are used to make use of C type-checking..
diff -urN linux/include/asm-parisc/pgalloc.h linux.new/include/asm-parisc/pgalloc.h
--- linux/include/asm-parisc/pgalloc.h	Sat Apr 28 23:02:53 2001
+++ linux.new/include/asm-parisc/pgalloc.h	Wed May 23 20:42:48 2001
@@ -288,7 +288,7 @@
 	pmd_t *pmd = (pmd_t *) __get_free_page(GFP_KERNEL);
 
 	if (pmd)
-		clear_page(pmd);
+		__clear_page(pmd);
 	return pmd;
 }
 
diff -urN linux/include/asm-ppc/page.h linux.new/include/asm-ppc/page.h
--- linux/include/asm-ppc/page.h	Wed May 23 20:29:25 2001
+++ linux.new/include/asm-ppc/page.h	Wed May 23 20:39:23 2001
@@ -80,10 +80,8 @@
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
 
-extern void clear_page(void *page);
-extern void copy_page(void *to, void *from);
-#define clear_user_page(page, vaddr)	clear_page(page)
-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
+extern void __clear_page(void *page);
+extern void __copy_page(void *to, void *from);
 
 /* map phys->virtual and virtual->phys for RAM pages */
 static inline unsigned long ___pa(unsigned long v)
diff -urN linux/include/asm-ppc/pgalloc.h linux.new/include/asm-ppc/pgalloc.h
--- linux/include/asm-ppc/pgalloc.h	Wed May 23 20:29:25 2001
+++ linux.new/include/asm-ppc/pgalloc.h	Wed May 23 20:39:23 2001
@@ -60,7 +60,7 @@
 	pgd_t *ret;
 
 	if ((ret = (pgd_t *)__get_free_page(GFP_KERNEL)) != NULL)
-		clear_page(ret);
+		__clear_page(ret);
 	return ret;
 }
 
@@ -112,7 +112,7 @@
 	else
 		pte = (pte_t *) early_get_page();
 	if (pte != NULL)
-		clear_page(pte);
+		__clear_page(pte);
 	return pte;
 }
 
diff -urN linux/include/asm-s390/page.h linux.new/include/asm-s390/page.h
--- linux/include/asm-s390/page.h	Sat Apr 28 23:02:54 2001
+++ linux.new/include/asm-s390/page.h	Wed May 23 20:39:23 2001
@@ -20,7 +20,7 @@
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
 
-static inline void clear_page(void *page)
+static inline void __clear_page(void *page)
 {
 	register_pair rp;
 
@@ -31,7 +31,7 @@
 		      : "+&a" (rp) : : "memory", "1" );
 }
 
-static inline void copy_page(void *to, void *from)
+static inline void __copy_page(void *to, void *from)
 {
         if (MACHINE_HAS_MVPG)
 		asm volatile ("   sr   0,0\n"
@@ -58,9 +58,6 @@
 			      : : "a"((void *)(to)),"a"((void *)(from)) 
 			      : "memory" );
 }
-
-#define clear_user_page(page, vaddr)	clear_page(page)
-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
 
 #define BUG() do { \
         printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
diff -urN linux/include/asm-s390x/page.h linux.new/include/asm-s390x/page.h
--- linux/include/asm-s390x/page.h	Sat Apr 28 23:02:54 2001
+++ linux.new/include/asm-s390x/page.h	Wed May 23 20:42:48 2001
@@ -19,7 +19,7 @@
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
 
-static inline void clear_page(void *page)
+static inline void __clear_page(void *page)
 {
         asm volatile ("   lgr  2,%0\n"
                       "   lghi 3,4096\n"
@@ -29,7 +29,7 @@
 		      : "memory", "1", "2", "3" );
 }
 
-static inline void copy_page(void *to, void *from)
+static inline void __copy_page(void *to, void *from)
 {
         if (MACHINE_HAS_MVPG)
 		asm volatile ("   sgr  0,0\n"
@@ -56,9 +56,6 @@
 			      : : "a"((void *)(to)),"a"((void *)(from)) 
 			      : "memory" );
 }
-
-#define clear_user_page(page, vaddr)    clear_page(page)
-#define copy_user_page(to, from, vaddr) copy_page(to, from)
 
 #define BUG() do { \
         printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
diff -urN linux/include/asm-sh/page.h linux.new/include/asm-sh/page.h
--- linux/include/asm-sh/page.h	Mon Dec  4 12:48:19 2000
+++ linux.new/include/asm-sh/page.h	Wed May 23 22:00:08 2001
@@ -24,15 +24,15 @@
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
 
-#define clear_page(page)	memset((void *)(page), 0, PAGE_SIZE)
-#define copy_page(to,from)	memcpy((void *)(to), (void *)(from), PAGE_SIZE)
+#define __clear_page(page)	memset((void *)(page), 0, PAGE_SIZE)
+#define __copy_page(to,from)	memcpy((void *)(to), (void *)(from), PAGE_SIZE)
 
-#if defined(__sh3__)
-#define clear_user_page(page, vaddr)	clear_page(page)
-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
-#elif defined(__SH4__)
-extern void clear_user_page(void *to, unsigned long address);
-extern void copy_user_page(void *to, void *from, unsigned long address);
+#if defined(__SH4__)
+#define __HAVE_ARCH_USER_PAGE
+struct page;
+extern void clear_user_page(struct page *to, unsigned long address);
+extern void copy_user_page(struct page *to, struct page *from,
+			   unsigned long address);
 #endif
 
 /*
diff -urN linux/include/asm-sh/pgalloc.h linux.new/include/asm-sh/pgalloc.h
--- linux/include/asm-sh/pgalloc.h	Sat Apr 28 23:02:54 2001
+++ linux.new/include/asm-sh/pgalloc.h	Wed May 23 20:39:23 2001
@@ -59,7 +59,7 @@
 
 	pte = (pte_t *) __get_free_page(GFP_KERNEL);
 	if (pte)
-		clear_page(pte);
+		__clear_page(pte);
 	return pte;
 }
 
diff -urN linux/include/asm-sparc/page.h linux.new/include/asm-sparc/page.h
--- linux/include/asm-sparc/page.h	Tue Oct 31 09:34:12 2000
+++ linux.new/include/asm-sparc/page.h	Wed May 23 20:39:23 2001
@@ -52,10 +52,8 @@
 
 #define PAGE_BUG(page)	BUG()
 
-#define clear_page(page)	 memset((void *)(page), 0, PAGE_SIZE)
-#define copy_page(to,from) 	memcpy((void *)(to), (void *)(from), PAGE_SIZE)
-#define clear_user_page(page, vaddr)	clear_page(page)
-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
+#define __clear_page(page)	 memset((void *)(page), 0, PAGE_SIZE)
+#define __copy_page(to,from) 	memcpy((void *)(to), (void *)(from), PAGE_SIZE)
 
 /* The following structure is used to hold the physical
  * memory configuration of the machine.  This is filled in
diff -urN linux/include/asm-sparc64/page.h linux.new/include/asm-sparc64/page.h
--- linux/include/asm-sparc64/page.h	Fri Aug 11 05:43:12 2000
+++ linux.new/include/asm-sparc64/page.h	Wed May 23 21:59:52 2001
@@ -23,10 +23,13 @@
 
 extern void _clear_page(void *page);
 extern void _copy_page(void *to, void *from);
-#define clear_page(X)	_clear_page((void *)(X))
-#define copy_page(X,Y)	_copy_page((void *)(X), (void *)(Y))
-extern void clear_user_page(void *page, unsigned long vaddr);
-extern void copy_user_page(void *to, void *from, unsigned long vaddr);
+#define __clear_page(X)	_clear_page((void *)(X))
+#define __copy_page(X,Y)	_copy_page((void *)(X), (void *)(Y))
+
+#define __HAVE_ARCH_USER_PAGE
+struct page;
+extern void clear_user_page(struct page *page, unsigned long vaddr);
+extern void copy_user_page(struct page *to, struct page *from, unsigned long vaddr);
 
 /* GROSS, defining this makes gcc pass these types as aggregates,
  * and thus on the stack, turn this crap off... -DaveM
diff -urN linux/include/asm-sparc64/pgalloc.h linux.new/include/asm-sparc64/pgalloc.h
--- linux/include/asm-sparc64/pgalloc.h	Sat Apr 28 23:02:54 2001
+++ linux.new/include/asm-sparc64/pgalloc.h	Wed May 23 20:39:23 2001
@@ -185,7 +185,7 @@
 
 		if (page) {
 			ret = (struct page *)page_address(page);
-			clear_page(ret);
+			__clear_page(ret);
 			(unsigned long)page->pprev_hash = 2;
 			(unsigned long *)page->next_hash = pgd_quicklist;
 			pgd_quicklist = (unsigned long *)page;
diff -urN linux/include/linux/highmem.h linux.new/include/linux/highmem.h
--- linux/include/linux/highmem.h	Mon Apr  2 02:20:15 2001
+++ linux.new/include/linux/highmem.h	Wed May 23 22:13:19 2001
@@ -3,6 +3,7 @@
 
 #include <linux/config.h>
 #include <asm/pgalloc.h>
+#include <asm/page.h>
 
 #ifdef CONFIG_HIGHMEM
 
@@ -42,20 +43,31 @@
 
 #endif /* CONFIG_HIGHMEM */
 
-/* when CONFIG_HIGHMEM is not set these will be plain clear/copy_page */
-static inline void clear_user_highpage(struct page *page, unsigned long vaddr)
+/* when CONFIG_HIGHMEM is not set these will be plain __clear/__copy_page */
+static inline void clear_page(struct page *page)
 {
-	clear_user_page(kmap(page), vaddr);
+	__clear_page(kmap(page));
 	kunmap(page);
 }
 
-static inline void clear_highpage(struct page *page)
+static inline void copy_page(struct page *to, struct page *from)
 {
-	clear_page(kmap(page));
-	kunmap(page);
+	char *vfrom, *vto;
+
+	vfrom = kmap(from);
+	vto = kmap(to);
+	__copy_page(vto, vfrom);
+	kunmap(from);
+	kunmap(to);
 }
 
-static inline void memclear_highpage(struct page *page, unsigned int offset, unsigned int size)
+#ifndef __HAVE_ARCH_USER_PAGE
+/* use the default clear/copy_user_page */
+#define clear_user_page(page, va)	clear_page((page))
+#define	copy_user_page(to, from, va)	copy_page((to), (from))
+#endif /* __HAVE_ARCH_USER_PAGE */
+
+static inline void memclear_page(struct page *page, unsigned int offset, unsigned int size)
 {
 	char *kaddr;
 
@@ -69,7 +81,7 @@
 /*
  * Same but also flushes aliased cache contents to RAM.
  */
-static inline void memclear_highpage_flush(struct page *page, unsigned int offset, unsigned int size)
+static inline void memclear_page_flush(struct page *page, unsigned int offset, unsigned int size)
 {
 	char *kaddr;
 
@@ -79,28 +91,6 @@
 	memset(kaddr + offset, 0, size);
 	flush_page_to_ram(page);
 	kunmap(page);
-}
-
-static inline void copy_user_highpage(struct page *to, struct page *from, unsigned long vaddr)
-{
-	char *vfrom, *vto;
-
-	vfrom = kmap(from);
-	vto = kmap(to);
-	copy_user_page(vto, vfrom, vaddr);
-	kunmap(from);
-	kunmap(to);
-}
-
-static inline void copy_highpage(struct page *to, struct page *from)
-{
-	char *vfrom, *vto;
-
-	vfrom = kmap(from);
-	vto = kmap(to);
-	copy_page(vto, vfrom);
-	kunmap(from);
-	kunmap(to);
 }
 
 #endif /* _LINUX_HIGHMEM_H */
diff -urN linux/include/linux/raid/md_compatible.h linux.new/include/linux/raid/md_compatible.h
--- linux/include/linux/raid/md_compatible.h	Mon Apr  2 02:20:36 2001
+++ linux.new/include/linux/raid/md_compatible.h	Wed May 23 20:39:23 2001
@@ -36,7 +36,7 @@
 #endif
 
 /* 002 */
-#define md_clear_page(page)        clear_page(page)
+#define md_clear_page(page)        __clear_page(page)
 
 /* 003 */
 #define MD_EXPORT_SYMBOL(x) EXPORT_SYMBOL(x)
diff -urN linux/mm/filemap.c linux.new/mm/filemap.c
--- linux/mm/filemap.c	Wed May 23 20:29:28 2001
+++ linux.new/mm/filemap.c	Wed May 23 22:16:34 2001
@@ -193,7 +193,7 @@
 
 static inline void truncate_partial_page(struct page *page, unsigned partial)
 {
-	memclear_highpage_flush(page, partial, PAGE_CACHE_SIZE-partial);
+	memclear_page_flush(page, partial, PAGE_CACHE_SIZE-partial);
 				
 	if (page->buffers)
 		block_flushpage(page, partial);
@@ -1535,7 +1535,7 @@
 		struct page *new_page = alloc_page(GFP_HIGHUSER);
 
 		if (new_page) {
-			copy_user_highpage(new_page, old_page, address);
+			copy_user_page(new_page, old_page, address);
 			flush_page_to_ram(new_page);
 		} else
 			new_page = NOPAGE_OOM;
diff -urN linux/mm/memory.c linux.new/mm/memory.c
--- linux/mm/memory.c	Sat Apr 28 23:02:55 2001
+++ linux.new/mm/memory.c	Wed May 23 21:08:32 2001
@@ -61,10 +61,10 @@
 static inline void copy_cow_page(struct page * from, struct page * to, unsigned long address)
 {
 	if (from == ZERO_PAGE(address)) {
-		clear_user_highpage(to, address);
+		clear_user_page(to, address);
 		return;
 	}
-	copy_user_highpage(to, from, address);
+	copy_user_page(to, from, address);
 }
 
 mem_map_t * mem_map;
@@ -1192,7 +1192,7 @@
 			return 1;
 		}
 		mm->rss++;
-		clear_user_highpage(page, addr);
+		clear_user_page(page, addr);
 		flush_page_to_ram(page);
 		entry = pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
 	}
diff -urN linux/mm/page_alloc.c linux.new/mm/page_alloc.c
--- linux/mm/page_alloc.c	Sat Apr 28 23:02:56 2001
+++ linux.new/mm/page_alloc.c	Thu May 24 09:31:41 2001
@@ -521,9 +521,8 @@
 
 	page = alloc_pages(gfp_mask, 0);
 	if (page) {
-		void *address = page_address(page);
-		clear_page(address);
-		return (unsigned long) address;
+		clear_page(page);
+		return (unsigned long) page_address(page);
 	}
 	return 0;
 }
diff -urN linux/mm/shmem.c linux.new/mm/shmem.c
--- linux/mm/shmem.c	Wed May 23 20:29:28 2001
+++ linux.new/mm/shmem.c	Wed May 23 22:12:55 2001
@@ -370,7 +370,7 @@
 		page = page_cache_alloc(mapping);
 		if (!page)
 			return ERR_PTR(-ENOMEM);
-		clear_highpage(page);
+		clear_page(page);
 		inode->i_blocks += BLOCKS_PER_PAGE;
 		add_to_page_cache (page, mapping, idx);
 	}
@@ -446,7 +446,7 @@
 		struct page *new_page = page_cache_alloc(inode->i_mapping);
 
 		if (new_page) {
-			copy_user_highpage(new_page, page, address);
+			copy_user_page(new_page, page, address);
 			flush_page_to_ram(new_page);
 		} else
 			new_page = NOPAGE_OOM;
