Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270165AbRIAImr>; Sat, 1 Sep 2001 04:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270168AbRIAImj>; Sat, 1 Sep 2001 04:42:39 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:27410 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S270165AbRIAIm2>;
	Sat, 1 Sep 2001 04:42:28 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15248.40412.665276.271570@cargo.ozlabs.ibm.com>
Date: Sat, 1 Sep 2001 18:35:40 +1000 (EST)
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, davidm@hpl.hp.com
Subject: Re: [PATCH] avoid unnecessary cache flushes
In-Reply-To: <20010831.154550.70219421.davem@redhat.com>
In-Reply-To: <15247.29338.3671.548678@cargo.ozlabs.ibm.com>
	<20010831.154550.70219421.davem@redhat.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:

> I would suggest instead to change the name of the assembler
> routine to __copy_user_page et al. and make copy_user_page just
> an inline or define which plucks out page->address and passes
> that onto __copy_user_page. 

Good idea, thanks.  Here is a new patch - does it look OK to you?
Linus, any comment?

> This way you require no knowledge
> of Sparc assembly whatsoever.

Well, I have done sparc assembly in my time (remember Dave Sitsky and
I did a port of the kernel to the ultrasparc running in 32-bit mode
before you did the sparc64 port) but the stuff you're doing in there
isn't just assembly, it's magic assembly. ;)

Regards,
Paul.

diff -urN linux/Documentation/cachetlb.txt linux-cfa/Documentation/cachetlb.txt
--- linux/Documentation/cachetlb.txt	Sat Mar 31 03:05:54 2001
+++ linux-cfa/Documentation/cachetlb.txt	Sat Aug 18 19:22:15 2001
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
 
diff -urN linux/arch/ppc/kernel/misc.S linux-cfa/arch/ppc/kernel/misc.S
--- linux/arch/ppc/kernel/misc.S	Wed Aug 29 08:16:33 2001
+++ linux-cfa/arch/ppc/kernel/misc.S	Fri Aug 31 11:14:18 2001
@@ -475,9 +475,9 @@
  * snoop from the data cache.
  * This is a no-op on the 601 which has a unified cache.
  *
- *	void __flush_page_to_ram(void *page)
+ *	void __flush_dcache_icache(void *page)
  */
-_GLOBAL(__flush_page_to_ram)
+_GLOBAL(__flush_dcache_icache)
 	mfspr	r5,PVR
 	rlwinm	r5,r5,16,16,31
 	cmpi	0,r5,1
@@ -493,28 +493,6 @@
 	mtctr	r4
 1:	icbi	0,r6
 	addi	r6,r6,CACHE_LINE_SIZE
-	bdnz	1b
-	sync
-	isync
-	blr
-
-/*
- * Flush a particular page from the instruction cache.
- * Note: this is necessary because the instruction cache does *not*
- * snoop from the data cache.
- * This is a no-op on the 601 which has a unified cache.
- *
- *	void __flush_icache_page(void *page)
- */
-_GLOBAL(__flush_icache_page)
-	mfspr	r5,PVR
-	rlwinm	r5,r5,16,16,31
-	cmpi	0,r5,1
-	beqlr				/* for 601, do nothing */
-	li	r4,4096/CACHE_LINE_SIZE	/* Number of lines in a page */
-	mtctr	r4
-1:	icbi	0,r3
-	addi	r3,r3,CACHE_LINE_SIZE
 	bdnz	1b
 	sync
 	isync
diff -urN linux/arch/ppc/kernel/ppc_ksyms.c linux-cfa/arch/ppc/kernel/ppc_ksyms.c
--- linux/arch/ppc/kernel/ppc_ksyms.c	Wed Aug 29 08:16:33 2001
+++ linux-cfa/arch/ppc/kernel/ppc_ksyms.c	Tue Aug 28 16:01:11 2001
@@ -185,6 +185,7 @@
 EXPORT_SYMBOL(enable_kernel_fp);
 EXPORT_SYMBOL(flush_icache_range);
 EXPORT_SYMBOL(flush_dcache_range);
+EXPORT_SYMBOL(flush_dcache_page);
 EXPORT_SYMBOL(xchg_u32);
 #ifdef CONFIG_ALTIVEC
 EXPORT_SYMBOL(last_task_used_altivec);
diff -urN linux/arch/ppc/mm/init.c linux-cfa/arch/ppc/mm/init.c
--- linux/arch/ppc/mm/init.c	Wed Aug 29 08:16:33 2001
+++ linux-cfa/arch/ppc/mm/init.c	Mon Aug 20 20:34:27 2001
@@ -578,17 +578,23 @@
 	mem_pieces_remove(&phys_avail, start, size, 1);
 }
 
-void flush_page_to_ram(struct page *page)
+/*
+ * This is called when a page has been modified by the kernel.
+ * It just marks the page as not i-cache clean.  We do the i-cache
+ * flush later when the page is given to a user process, if necessary.
+ */
+void flush_dcache_page(struct page *page)
 {
-	unsigned long vaddr = (unsigned long) kmap(page);
-	__flush_page_to_ram(vaddr);
-	kunmap(page);
+	clear_bit(PG_arch_1, &page->flags);
 }
 
 /*
  * set_pte stores a linux PTE into the linux page table.
  * On machines which use an MMU hash table we avoid changing the
  * _PAGE_HASHPTE bit.
+ * If the new PTE has _PAGE_EXEC set, meaning that the user wants
+ * to be able to execute out of the page, we check if the page is
+ * i-cache dirty and flush it if so, and mark it clean.
  */
 void set_pte(pte_t *ptep, pte_t pte)
 {
@@ -597,4 +603,25 @@
 #else
 	*ptep = pte;
 #endif
+	if (mem_init_done && (pte_val(pte) & _PAGE_EXEC)
+	    && (pte_val(pte) & PAGE_MASK) < total_memory) {
+		struct page *page = pte_page(pte);
+		if (!test_bit(PG_arch_1, &page->flags)) {
+			__flush_dcache_icache((unsigned long)kmap(page));
+			kunmap(page);
+			set_bit(PG_arch_1, &page->flags);
+		}
+	}
+}
+
+void clear_user_page(struct page *page, unsigned long vaddr)
+{
+	clear_mem_page(page);
+	clear_bit(PG_arch_1, &page->flags);
+}
+
+void copy_user_page(struct page *to, struct page *from, unsigned long vaddr)
+{
+	copy_mem_page(to, from);
+	clear_bit(PG_arch_1, &to->flags);
 }
diff -urN linux/include/asm-alpha/page.h linux-cfa/include/asm-alpha/page.h
--- linux/include/asm-alpha/page.h	Sat May 26 12:39:52 2001
+++ linux-cfa/include/asm-alpha/page.h	Tue Jun  5 12:50:07 2001
@@ -15,10 +15,7 @@
 #define STRICT_MM_TYPECHECKS
 
 extern void clear_page(void *page);
-#define clear_user_page(page, vaddr)	clear_page(page)
-
 extern void copy_page(void * _to, void * _from);
-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
 
 #ifdef STRICT_MM_TYPECHECKS
 /*
diff -urN linux/include/asm-arm/page.h linux-cfa/include/asm-arm/page.h
--- linux/include/asm-arm/page.h	Fri Aug 17 08:29:04 2001
+++ linux-cfa/include/asm-arm/page.h	Mon Aug 20 14:30:07 2001
@@ -14,9 +14,6 @@
 #define clear_page(page)	memzero((void *)(page), PAGE_SIZE)
 extern void copy_page(void *to, void *from);
 
-#define clear_user_page(page, vaddr)	clear_page(page)
-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
-
 #ifdef STRICT_MM_TYPECHECKS
 /*
  * These are used to make use of C type-checking..
diff -urN linux/include/asm-cris/page.h linux-cfa/include/asm-cris/page.h
--- linux/include/asm-cris/page.h	Thu Feb 22 14:25:38 2001
+++ linux-cfa/include/asm-cris/page.h	Tue Jun  5 12:50:57 2001
@@ -14,9 +14,6 @@
 #define clear_page(page)        memset((void *)(page), 0, PAGE_SIZE)
 #define copy_page(to,from)      memcpy((void *)(to), (void *)(from), PAGE_SIZE)
 
-#define clear_user_page(page, vaddr)    clear_page(page)
-#define copy_user_page(to, from, vaddr) copy_page(to, from)
-
 #define STRICT_MM_TYPECHECKS
 
 #ifdef STRICT_MM_TYPECHECKS
diff -urN linux/include/asm-ia64/pgalloc.h linux-cfa/include/asm-ia64/pgalloc.h
--- linux/include/asm-ia64/pgalloc.h	Sat Aug 11 15:19:15 2001
+++ linux-cfa/include/asm-ia64/pgalloc.h	Sat Aug 11 16:29:30 2001
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
+	clear_mem_page(page);
 	flush_dcache_page(page);
 }
 
 static inline void
-copy_user_page (void *to, void *from, unsigned long vaddr, struct page *page)
+copy_user_page (struct page *to, struct page *from, unsigned long vaddr)
 {
-	copy_page(to, from);
-	flush_dcache_page(page);
+	copy_mem_page(to, from);
+	flush_dcache_page(to);
 }
 
 /*
diff -urN linux/include/asm-m68k/page.h linux-cfa/include/asm-m68k/page.h
--- linux/include/asm-m68k/page.h	Tue Nov 28 13:00:49 2000
+++ linux-cfa/include/asm-m68k/page.h	Tue Jun  5 12:52:51 2001
@@ -76,9 +76,6 @@
 #define copy_page(to,from)	memcpy((to), (from), PAGE_SIZE)
 #endif
 
-#define clear_user_page(page, vaddr)	clear_page(page)
-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
-
 /*
  * These are used to make use of C type-checking..
  */
diff -urN linux/include/asm-mips/page.h linux-cfa/include/asm-mips/page.h
--- linux/include/asm-mips/page.h	Thu Aug 10 06:46:02 2000
+++ linux-cfa/include/asm-mips/page.h	Tue Jun  5 12:53:14 2001
@@ -28,8 +28,6 @@
 
 #define clear_page(page)	_clear_page(page)
 #define copy_page(to, from)	_copy_page(to, from)
-#define clear_user_page(page, vaddr)	clear_page(page)
-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
 
 /*
  * These are used to make use of C type-checking..
diff -urN linux/include/asm-mips64/page.h linux-cfa/include/asm-mips64/page.h
--- linux/include/asm-mips64/page.h	Thu Aug 10 06:46:02 2000
+++ linux-cfa/include/asm-mips64/page.h	Tue Jun  5 12:53:25 2001
@@ -28,8 +28,6 @@
 
 #define clear_page(page)	_clear_page(page)
 #define copy_page(to, from)	_copy_page(to, from)
-#define clear_user_page(page, vaddr)	clear_page(page)
-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
 
 /*
  * These are used to make use of C type-checking..
diff -urN linux/include/asm-parisc/page.h linux-cfa/include/asm-parisc/page.h
--- linux/include/asm-parisc/page.h	Wed Dec  6 07:29:39 2000
+++ linux-cfa/include/asm-parisc/page.h	Tue Jun  5 12:53:40 2001
@@ -12,9 +12,6 @@
 #define clear_page(page)	memset((void *)(page), 0, PAGE_SIZE)
 #define copy_page(to,from)	memcpy((void *)(to), (void *)(from), PAGE_SIZE)
 
-#define clear_user_page(page, vaddr) clear_page(page)
-#define copy_user_page(to, from, vaddr) copy_page(to, from)
-
 /*
  * These are used to make use of C type-checking..
  */
diff -urN linux/include/asm-ppc/page.h linux-cfa/include/asm-ppc/page.h
--- linux/include/asm-ppc/page.h	Wed Aug 29 08:16:34 2001
+++ linux-cfa/include/asm-ppc/page.h	Fri Aug 31 12:27:40 2001
@@ -83,8 +83,11 @@
 
 extern void clear_page(void *page);
 extern void copy_page(void *to, void *from);
-#define clear_user_page(page, vaddr)	clear_page(page)
-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
+
+#define __HAVE_ARCH_USER_PAGE
+struct page;
+extern void clear_user_page(struct page *page, unsigned long vaddr);
+extern void copy_user_page(struct page *to, struct page *from, unsigned long vaddr);
 
 /* map phys->virtual and virtual->phys for RAM pages */
 static inline unsigned long ___pa(unsigned long v)
diff -urN linux/include/asm-ppc/pgtable.h linux-cfa/include/asm-ppc/pgtable.h
--- linux/include/asm-ppc/pgtable.h	Wed Jul  4 14:33:57 2001
+++ linux-cfa/include/asm-ppc/pgtable.h	Fri Aug 31 12:27:40 2001
@@ -83,12 +83,11 @@
 #define flush_cache_range(mm, a, b)	do { } while (0)
 #define flush_cache_page(vma, p)	do { } while (0)
 #define flush_icache_page(vma, page)	do { } while (0)
+#define flush_page_to_ram(page)		do { } while (0)
 
 extern void flush_icache_range(unsigned long, unsigned long);
-extern void __flush_page_to_ram(unsigned long page_va);
-extern void flush_page_to_ram(struct page *page);
-
-#define flush_dcache_page(page)			do { } while (0)
+extern void __flush_dcache_icache(unsigned long page_va);
+extern void flush_dcache_page(struct page *page);
 
 extern unsigned long va_to_phys(unsigned long address);
 extern pte_t *va_to_pte(unsigned long address);
@@ -421,6 +420,10 @@
 }
 
 /*
+ * When a new value is written into a PTE, we may need to flush the
+ * i-cache for the page of memory that the PTE points to.
+ * (Note: machines with software TLB reloads could do the flush in
+ * the instruction TLB miss handler instead.)
  * Writing a new value into the PTE doesn't disturb the state of the
  * _PAGE_HASHPTE bit, on those machines which use an MMU hash table.
  */
diff -urN linux/include/asm-s390/page.h linux-cfa/include/asm-s390/page.h
--- linux/include/asm-s390/page.h	Sat Aug 11 15:19:15 2001
+++ linux-cfa/include/asm-s390/page.h	Sat Aug 11 16:28:36 2001
@@ -59,9 +59,6 @@
 			      : "memory" );
 }
 
-#define clear_user_page(page, vaddr)	clear_page(page)
-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
-
 #define BUG() do { \
         printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
         __asm__ __volatile__(".word 0x0000"); \
diff -urN linux/include/asm-s390x/page.h linux-cfa/include/asm-s390x/page.h
--- linux/include/asm-s390x/page.h	Sat Aug 11 15:19:15 2001
+++ linux-cfa/include/asm-s390x/page.h	Sat Aug 11 16:28:36 2001
@@ -57,9 +57,6 @@
 			      : "memory" );
 }
 
-#define clear_user_page(page, vaddr)    clear_page(page)
-#define copy_user_page(to, from, vaddr) copy_page(to, from)
-
 #define BUG() do { \
         printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
         __asm__ __volatile__(".long 0"); \
diff -urN linux/include/asm-sh/page.h linux-cfa/include/asm-sh/page.h
--- linux/include/asm-sh/page.h	Mon Dec  4 12:48:19 2000
+++ linux-cfa/include/asm-sh/page.h	Tue Jun  5 12:56:48 2001
@@ -27,12 +27,12 @@
 #define clear_page(page)	memset((void *)(page), 0, PAGE_SIZE)
 #define copy_page(to,from)	memcpy((void *)(to), (void *)(from), PAGE_SIZE)
 
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
diff -urN linux/include/asm-sparc/page.h linux-cfa/include/asm-sparc/page.h
--- linux/include/asm-sparc/page.h	Tue Oct 31 09:34:12 2000
+++ linux-cfa/include/asm-sparc/page.h	Tue Jun  5 12:59:53 2001
@@ -54,8 +54,6 @@
 
 #define clear_page(page)	 memset((void *)(page), 0, PAGE_SIZE)
 #define copy_page(to,from) 	memcpy((void *)(to), (void *)(from), PAGE_SIZE)
-#define clear_user_page(page, vaddr)	clear_page(page)
-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
 
 /* The following structure is used to hold the physical
  * memory configuration of the machine.  This is filled in
diff -urN linux/include/asm-sparc64/page.h linux-cfa/include/asm-sparc64/page.h
--- linux/include/asm-sparc64/page.h	Fri Aug 11 05:43:12 2000
+++ linux-cfa/include/asm-sparc64/page.h	Sat Sep  1 18:25:49 2001
@@ -25,8 +25,13 @@
 extern void _copy_page(void *to, void *from);
 #define clear_page(X)	_clear_page((void *)(X))
 #define copy_page(X,Y)	_copy_page((void *)(X), (void *)(Y))
-extern void clear_user_page(void *page, unsigned long vaddr);
-extern void copy_user_page(void *to, void *from, unsigned long vaddr);
+
+#define __HAVE_ARCH_USER_PAGE
+extern void __clear_user_page(void *page, unsigned long vaddr);
+extern void __copy_user_page(void *to, void *from, unsigned long vaddr);
+#define clear_user_page(pg, va)	__clear_user_page((pg)->address, (va))
+#define copy_user_page(to, from, va) \
+		__copy_user_page((to)->address, (from)->address, (va))
 
 /* GROSS, defining this makes gcc pass these types as aggregates,
  * and thus on the stack, turn this crap off... -DaveM
diff -urN linux/include/linux/highmem.h linux-cfa/include/linux/highmem.h
--- linux/include/linux/highmem.h	Wed Aug 29 08:16:34 2001
+++ linux-cfa/include/linux/highmem.h	Fri Aug 31 20:34:49 2001
@@ -43,20 +43,23 @@
 #endif /* CONFIG_HIGHMEM */
 
 /* when CONFIG_HIGHMEM is not set these will be plain clear/copy_page */
-static inline void clear_user_highpage(struct page *page, unsigned long vaddr)
+
+#ifndef __HAVE_ARCH_USER_PAGE
+static inline void clear_user_page(struct page *page, unsigned long vaddr)
 {
 	void *addr = kmap_atomic(page, KM_USER0);
-	clear_user_page(addr, vaddr);
+	clear_page(addr, vaddr);
 	kunmap_atomic(addr, KM_USER0);
 }
+#endif /* __HAVE_ARCH_USER_PAGE */
 
-static inline void clear_highpage(struct page *page)
+static inline void clear_mem_page(struct page *page)
 {
 	clear_page(kmap(page));
 	kunmap(page);
 }
 
-static inline void memclear_highpage(struct page *page, unsigned int offset, unsigned int size)
+static inline void memclear_page(struct page *page, unsigned int offset, unsigned int size)
 {
 	char *kaddr;
 
@@ -70,7 +73,7 @@
 /*
  * Same but also flushes aliased cache contents to RAM.
  */
-static inline void memclear_highpage_flush(struct page *page, unsigned int offset, unsigned int size)
+static inline void memclear_page_flush(struct page *page, unsigned int offset, unsigned int size)
 {
 	char *kaddr;
 
@@ -82,7 +85,8 @@
 	kunmap(page);
 }
 
-static inline void copy_user_highpage(struct page *to, struct page *from, unsigned long vaddr)
+#ifndef __HAVE_ARCH_USER_PAGE
+static inline void copy_user_page(struct page *to, struct page *from, unsigned long vaddr)
 {
 	char *vfrom, *vto;
 
@@ -92,8 +96,9 @@
 	kunmap_atomic(vfrom, KM_USER0);
 	kunmap_atomic(vto, KM_USER1);
 }
+#endif
 
-static inline void copy_highpage(struct page *to, struct page *from)
+static inline void copy_mem_page(struct page *to, struct page *from)
 {
 	char *vfrom, *vto;
 
diff -urN linux/kernel/ptrace.c linux-cfa/kernel/ptrace.c
--- linux/kernel/ptrace.c	Sat Jul 21 09:51:59 2001
+++ linux-cfa/kernel/ptrace.c	Sat Aug 18 15:20:11 2001
@@ -103,10 +103,11 @@
 	flush_cache_page(vma, addr);
 
 	if (write) {
-		maddr = kmap(page);
-		memcpy(maddr + (addr & ~PAGE_MASK), buf, len);
+		maddr = kmap(page) + (addr & ~PAGE_MASK);
+		memcpy(maddr, buf, len);
 		flush_page_to_ram(page);
-		flush_icache_page(vma, page);
+		flush_icache_range((unsigned long) maddr,
+				   (unsigned long) maddr + len);
 		kunmap(page);
 	} else {
 		maddr = kmap(page);
diff -urN linux/mm/filemap.c linux-cfa/mm/filemap.c
--- linux/mm/filemap.c	Wed Aug 29 08:16:34 2001
+++ linux-cfa/mm/filemap.c	Fri Aug 31 11:57:54 2001
@@ -193,7 +193,7 @@
 
 static inline void truncate_partial_page(struct page *page, unsigned partial)
 {
-	memclear_highpage_flush(page, partial, PAGE_CACHE_SIZE-partial);
+	memclear_page_flush(page, partial, PAGE_CACHE_SIZE-partial);
 				
 	if (page->buffers)
 		block_flushpage(page, partial);
@@ -1477,7 +1477,7 @@
 		struct page *new_page = alloc_page(GFP_HIGHUSER);
 
 		if (new_page) {
-			copy_user_highpage(new_page, old_page, address);
+			copy_user_page(new_page, old_page, address);
 			flush_page_to_ram(new_page);
 		} else
 			new_page = NOPAGE_OOM;
diff -urN linux/mm/memory.c linux-cfa/mm/memory.c
--- linux/mm/memory.c	Wed Aug 29 08:16:34 2001
+++ linux-cfa/mm/memory.c	Fri Aug 31 11:58:55 2001
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
@@ -1186,7 +1186,7 @@
 		page = alloc_page(GFP_HIGHUSER);
 		if (!page)
 			goto no_mem;
-		clear_user_highpage(page, addr);
+		clear_user_page(page, addr);
 
 		spin_lock(&mm->page_table_lock);
 		if (!pte_none(*page_table)) {
diff -urN linux/mm/page_alloc.c linux-cfa/mm/page_alloc.c
--- linux/mm/page_alloc.c	Wed Aug 29 08:16:34 2001
+++ linux-cfa/mm/page_alloc.c	Fri Aug 31 11:59:16 2001
@@ -526,9 +526,8 @@
 
 	page = alloc_pages(gfp_mask, 0);
 	if (page) {
-		void *address = page_address(page);
-		clear_page(address);
-		return (unsigned long) address;
+		clear_mem_page(page);
+		return (unsigned long) page_address(page);
 	}
 	return 0;
 }
diff -urN linux/mm/shmem.c linux-cfa/mm/shmem.c
--- linux/mm/shmem.c	Wed Aug 29 08:16:34 2001
+++ linux-cfa/mm/shmem.c	Wed Aug 29 09:26:38 2001
@@ -376,7 +376,7 @@
 		page = page_cache_alloc(mapping);
 		if (!page)
 			return ERR_PTR(-ENOMEM);
-		clear_highpage(page);
+		clear_mem_page(page);
 		inode->i_blocks += BLOCKS_PER_PAGE;
 		add_to_page_cache (page, mapping, idx);
 	}
@@ -439,7 +439,7 @@
 		struct page *new_page = page_cache_alloc(inode->i_mapping);
 
 		if (new_page) {
-			copy_user_highpage(new_page, page, address);
+			copy_user_page(new_page, page, address);
 			flush_page_to_ram(new_page);
 		} else
 			new_page = NOPAGE_OOM;
