Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261218AbSJ1OOX>; Mon, 28 Oct 2002 09:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261223AbSJ1OOX>; Mon, 28 Oct 2002 09:14:23 -0500
Received: from pizda.ninka.net ([216.101.162.242]:53930 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261218AbSJ1OOP>;
	Mon, 28 Oct 2002 09:14:15 -0500
Date: Mon, 28 Oct 2002 06:10:59 -0800 (PST)
Message-Id: <20021028.061059.38206858.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: rmk@arm.linux.org.uk, hugh@veritas.com, willy@debian.org, akpm@zip.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shmem missing cache flush
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1035216742.27318.189.camel@irongate.swansea.linux.org.uk>
References: <1035212657.27259.154.camel@irongate.swansea.linux.org.uk>
	<20021021.082107.56539790.davem@redhat.com>
	<1035216742.27318.189.camel@irongate.swansea.linux.org.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: 21 Oct 2002 17:12:22 +0100
   
   Send me the diffs Im happy to give them a spin.

Here goes.  I contacted Anton and Paulus about flush_icache_page as
that is on the hitlist next and ppc/ppc64 is the only well maintained
port using that.

--- ./Documentation/cachetlb.txt.~1~	Mon Oct 28 06:03:18 2002
+++ ./Documentation/cachetlb.txt	Mon Oct 28 06:08:05 2002
@@ -235,41 +235,14 @@ this value.
 NOTE: This does not fix shared mmaps, check out the sparc64 port for
 one way to solve this (in particular SPARC_FLAG_MMAPSHARED).
 
-Next, you have two methods to solve the D-cache aliasing issue for all
+Here is the method to solve the D-cache aliasing issue for all
 other cases.  Please keep in mind that fact that, for a given page
 mapped into some user address space, there is always at least one more
 mapping, that of the kernel in it's linear mapping starting at
 PAGE_OFFSET.  So immediately, once the first user maps a given
 physical page into its address space, by implication the D-cache
 aliasing problem has the potential to exist since the kernel already
-maps this page at its virtual address.
-
-First, I describe the old method to deal with this problem.  I am
-describing it for documentation purposes, but it is deprecated and the
-latter method I describe next should be used by all new ports and all
-existing ports should move over to the new mechanism as well.
-
-  flush_page_to_ram(struct page *page)
-
-	The physical page 'page' is about to be place into the
-	user address space of a process.  If it is possible for
-	stores done recently by the kernel into this physical
-	page, to not be visible to an arbitrary mapping in userspace,
-	you must flush this page from the D-cache.
-
-	If the D-cache is writeback in nature, the dirty data (if
-	any) for this physical page must be written back to main
-	memory before the cache lines are invalidated.
-
-Admittedly, the author did not think very much when designing this
-interface.  It does not give the architecture enough information about
-what exactly is going on, and there is no context to base a judgment
-on about whether an alias is possible at all.  The new interfaces to
-deal with D-cache aliasing are meant to address this by telling the
-architecture specific code exactly which is going on at the proper points
-in time.
-
-Here is the new interface:
+maps this page at its virtual address:
 
   void copy_user_page(void *to, void *from, unsigned long address)
   void clear_user_page(void *to, unsigned long address)
--- ./arch/ia64/mm/init.c.~1~	Mon Oct 28 05:56:41 2002
+++ ./arch/ia64/mm/init.c	Mon Oct 28 05:57:29 2002
@@ -250,7 +250,6 @@ put_gate_page (struct page *page, unsign
 			pte_unmap(pte);
 			goto out;
 		}
-		flush_page_to_ram(page);
 		set_pte(pte, mk_pte(page, PAGE_GATE));
 		pte_unmap(pte);
 	}
--- ./arch/ppc64/kernel/sys_ppc32.c.~1~	Mon Oct 28 05:56:41 2002
+++ ./arch/ppc64/kernel/sys_ppc32.c	Mon Oct 28 05:57:36 2002
@@ -3464,7 +3464,6 @@ static int copy_strings32(int argc, u32 
 
 			err = copy_from_user(kaddr + offset, (char *)A(str),
 					     bytes_to_copy);
-			flush_page_to_ram(page);
 			kunmap((unsigned long)kaddr);
 
 			if (err)
--- ./arch/s390x/kernel/linux32.c.~1~	Mon Oct 28 05:56:41 2002
+++ ./arch/s390x/kernel/linux32.c	Mon Oct 28 05:57:44 2002
@@ -3019,7 +3019,6 @@ static int copy_strings32(int argc, u32 
 
 			err = copy_from_user(kaddr + offset, (char *)A(str),
 					     bytes_to_copy);
-			flush_page_to_ram(page);
 			kunmap(page);
 
 			if (err)
--- ./fs/binfmt_elf.c.~1~	Mon Oct 28 05:56:41 2002
+++ ./fs/binfmt_elf.c	Mon Oct 28 05:57:53 2002
@@ -1253,7 +1253,6 @@ static int elf_core_dump(long signr, str
 					flush_cache_page(vma, addr);
 					kaddr = kmap(page);
 					DUMP_WRITE(kaddr, PAGE_SIZE);
-					flush_page_to_ram(page);
 					kunmap(page);
 				}
 				page_cache_release(page);
--- ./fs/exec.c.~1~	Mon Oct 28 05:56:41 2002
+++ ./fs/exec.c	Mon Oct 28 05:57:58 2002
@@ -308,7 +308,6 @@ void put_dirty_page(struct task_struct *
 	}
 	lru_cache_add(page);
 	flush_dcache_page(page);
-	flush_page_to_ram(page);
 	set_pte(pte, pte_mkdirty(pte_mkwrite(mk_pte(page, PAGE_COPY))));
 	page_add_rmap(page, pte);
 	pte_unmap(pte);
--- ./include/asm-alpha/cacheflush.h.~1~	Mon Oct 28 05:56:41 2002
+++ ./include/asm-alpha/cacheflush.h	Mon Oct 28 05:58:04 2002
@@ -9,7 +9,6 @@
 #define flush_cache_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr)		do { } while (0)
-#define flush_page_to_ram(page)			do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
 
 /* Note that the following two definitions are _highly_ dependent
--- ./include/asm-arm/proc-armo/cache.h.~1~	Mon Oct 28 05:56:41 2002
+++ ./include/asm-arm/proc-armo/cache.h	Mon Oct 28 05:58:10 2002
@@ -13,7 +13,6 @@
 #define flush_cache_mm(mm)			do { } while (0)
 #define flush_cache_range(vma,start,end)	do { } while (0)
 #define flush_cache_page(vma,vmaddr)		do { } while (0)
-#define flush_page_to_ram(page)			do { } while (0)
 
 #define invalidate_dcache_range(start,end)	do { } while (0)
 #define clean_dcache_range(start,end)		do { } while (0)
--- ./include/asm-arm/proc-armv/cache.h.~1~	Mon Oct 28 05:56:41 2002
+++ ./include/asm-arm/proc-armv/cache.h	Mon Oct 28 05:58:16 2002
@@ -71,13 +71,6 @@
 					 ((unsigned long)start) + size, 0);
 
 /*
- * This is an obsolete interface; the functionality that was provided by this
- * function is now merged into our flush_dcache_page, flush_icache_page,
- * copy_user_page and clear_user_page functions.
- */
-#define flush_page_to_ram(page)	do { } while (0)
-
-/*
  * flush_dcache_page is used when the kernel has written to the page
  * cache page at virtual address page->virtual.
  *
--- ./include/asm-cris/pgtable.h.~1~	Mon Oct 28 05:56:41 2002
+++ ./include/asm-cris/pgtable.h	Mon Oct 28 05:58:25 2002
@@ -121,7 +121,6 @@ extern void paging_init(void);
 #define flush_cache_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr)		do { } while (0)
-#define flush_page_to_ram(page)			do { } while (0)
 #define flush_dcache_page(page)                 do { } while (0)
 #define flush_icache_range(start, end)          do { } while (0)
 #define flush_icache_page(vma,pg)               do { } while (0)
--- ./include/asm-i386/cacheflush.h.~1~	Mon Oct 28 05:56:41 2002
+++ ./include/asm-i386/cacheflush.h	Mon Oct 28 05:58:31 2002
@@ -9,7 +9,6 @@
 #define flush_cache_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr)		do { } while (0)
-#define flush_page_to_ram(page)			do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
 #define flush_icache_range(start, end)		do { } while (0)
 #define flush_icache_page(vma,pg)		do { } while (0)
--- ./include/asm-ia64/cacheflush.h.~1~	Mon Oct 28 05:56:41 2002
+++ ./include/asm-ia64/cacheflush.h	Mon Oct 28 05:58:36 2002
@@ -20,7 +20,6 @@
 #define flush_cache_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr)		do { } while (0)
-#define flush_page_to_ram(page)			do { } while (0)
 #define flush_icache_page(vma,page)		do { } while (0)
 
 #define flush_dcache_page(page)			\
--- ./include/asm-m68k/cacheflush.h.~1~	Mon Oct 28 05:56:41 2002
+++ ./include/asm-m68k/cacheflush.h	Mon Oct 28 05:59:02 2002
@@ -106,7 +106,7 @@ extern inline void flush_cache_page(stru
 
 /* Push the page at kernel virtual address and clear the icache */
 /* RZ: use cpush %bc instead of cpush %dc, cinv %ic */
-#define flush_page_to_ram(page) __flush_page_to_ram(page_address(page))
+#error flush_page_to_ram is obsoleted, please convert to flush_dcache_page
 extern inline void __flush_page_to_ram(void *vaddr)
 {
 	if (CPU_IS_040_OR_060) {
--- ./include/asm-mips/pgtable.h.~1~	Mon Oct 28 05:56:41 2002
+++ ./include/asm-mips/pgtable.h	Mon Oct 28 05:59:32 2002
@@ -24,7 +24,6 @@
  *  - flush_cache_mm(mm) flushes the specified mm context's cache lines
  *  - flush_cache_page(mm, vmaddr) flushes a single page
  *  - flush_cache_range(vma, start, end) flushes a range of pages
- *  - flush_page_to_ram(page) write back kernel page to ram
  *  - flush_icache_range(start, end) flush a range of instructions
  */
 extern void (*_flush_cache_all)(void);
@@ -34,7 +33,7 @@ extern void (*_flush_cache_range)(struct
 				 unsigned long end);
 extern void (*_flush_cache_page)(struct vm_area_struct *vma, unsigned long page);
 extern void (*_flush_cache_sigtramp)(unsigned long addr);
-extern void (*_flush_page_to_ram)(struct page * page);
+#error flush_page_to_ram is obsoleted, please convert to flush_dcache_page
 extern void (*_flush_icache_range)(unsigned long start, unsigned long end);
 extern void (*_flush_icache_page)(struct vm_area_struct *vma,
                                   struct page *page);
@@ -47,7 +46,6 @@ extern void (*_flush_icache_page)(struct
 #define flush_cache_range(vma,start,end) _flush_cache_range(vma,start,end)
 #define flush_cache_page(vma,page)	_flush_cache_page(vma, page)
 #define flush_cache_sigtramp(addr)	_flush_cache_sigtramp(addr)
-#define flush_page_to_ram(page)		_flush_page_to_ram(page)
 
 #define flush_icache_range(start, end)	_flush_icache_range(start,end)
 #define flush_icache_page(vma, page) 	_flush_icache_page(vma, page)
--- ./include/asm-mips64/pgtable.h.~1~	Mon Oct 28 05:56:41 2002
+++ ./include/asm-mips64/pgtable.h	Mon Oct 28 05:59:55 2002
@@ -25,13 +25,12 @@
  *  - flush_cache_mm(mm) flushes the specified mm context's cache lines
  *  - flush_cache_page(mm, vmaddr) flushes a single page
  *  - flush_cache_range(vma, start, end) flushes a range of pages
- *  - flush_page_to_ram(page) write back kernel page to ram
  */
 extern void (*_flush_cache_mm)(struct mm_struct *mm);
 extern void (*_flush_cache_range)(struct vm_area_struct *vma, unsigned long start,
                                  unsigned long end);
 extern void (*_flush_cache_page)(struct vm_area_struct *vma, unsigned long page);
-extern void (*_flush_page_to_ram)(struct page * page);
+#error flush_page_to_ram is obsoleted, please convert to flush_dcache_page
 
 #define flush_cache_all()		do { } while(0)
 #define flush_dcache_page(page)		do { } while (0)
@@ -40,7 +39,6 @@ extern void (*_flush_page_to_ram)(struct
 #define flush_cache_mm(mm)		_flush_cache_mm(mm)
 #define flush_cache_range(vma,start,end) _flush_cache_range(vma,start,end)
 #define flush_cache_page(vma,page)	_flush_cache_page(vma, page)
-#define flush_page_to_ram(page)		_flush_page_to_ram(page)
 
 #define flush_icache_range(start, end)	_flush_cache_l1()
 #define flush_icache_user_range(vma, page, addr, len)	\
@@ -66,7 +64,6 @@ extern void andes_flush_icache_page(unsi
 #define flush_cache_mm(mm)		do { } while(0)
 #define flush_cache_range(vma,start,end) do { } while(0)
 #define flush_cache_page(vma,page)	do { } while(0)
-#define flush_page_to_ram(page)		do { } while(0)
 #define flush_icache_range(start, end)	_flush_cache_l1()
 #define flush_icache_user_range(vma, page, addr, len)	\
 					flush_icache_page((vma), (page))
--- ./include/asm-parisc/pgalloc.h.~1~	Mon Oct 28 05:56:41 2002
+++ ./include/asm-parisc/pgalloc.h	Mon Oct 28 06:00:13 2002
@@ -72,7 +72,7 @@ flush_kernel_dcache_range(unsigned long 
 	asm volatile("syncdma" : : );
 }
 
-extern void __flush_page_to_ram(unsigned long address);
+#error flush_page_to_ram is obsoleted, please convert to flush_dcache_page
 
 #define flush_cache_all()			flush_all_caches()
 #define flush_cache_mm(foo)			flush_all_caches()
@@ -99,9 +99,6 @@ extern inline void flush_cache_mm(struct
                 __flush_dcache_range(vmaddr, PAGE_SIZE); \
                 __flush_icache_range(vmaddr, PAGE_SIZE); \
 } while(0)
-
-#define flush_page_to_ram(page)	\
-        __flush_page_to_ram((unsigned long)page_address(page))
 
 #define flush_icache_range(start, end) \
         __flush_icache_range(start, end - start)
--- ./include/asm-ppc/cacheflush.h.~1~	Mon Oct 28 05:56:41 2002
+++ ./include/asm-ppc/cacheflush.h	Mon Oct 28 06:00:28 2002
@@ -23,7 +23,6 @@
 #define flush_cache_mm(mm)		do { } while (0)
 #define flush_cache_range(vma, a, b)	do { } while (0)
 #define flush_cache_page(vma, p)	do { } while (0)
-#define flush_page_to_ram(page)		do { } while (0)
 
 extern void flush_dcache_page(struct page *page);
 extern void flush_icache_page(struct vm_area_struct *vma, struct page *page);
--- ./include/asm-ppc64/cacheflush.h.~1~	Mon Oct 28 05:56:41 2002
+++ ./include/asm-ppc64/cacheflush.h	Mon Oct 28 06:00:35 2002
@@ -13,7 +13,6 @@
 #define flush_cache_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr)		do { } while (0)
-#define flush_page_to_ram(page)			do { } while (0)
 
 extern void flush_dcache_page(struct page *page);
 extern void flush_icache_range(unsigned long, unsigned long);
--- ./include/asm-s390/cacheflush.h.~1~	Mon Oct 28 05:56:41 2002
+++ ./include/asm-s390/cacheflush.h	Mon Oct 28 06:00:40 2002
@@ -9,7 +9,6 @@
 #define flush_cache_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr)		do { } while (0)
-#define flush_page_to_ram(page)			do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
 #define flush_icache_range(start, end)		do { } while (0)
 #define flush_icache_page(vma,pg)		do { } while (0)
--- ./include/asm-s390x/cacheflush.h.~1~	Mon Oct 28 05:56:41 2002
+++ ./include/asm-s390x/cacheflush.h	Mon Oct 28 06:00:45 2002
@@ -9,7 +9,6 @@
 #define flush_cache_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr)		do { } while (0)
-#define flush_page_to_ram(page)			do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
 #define flush_icache_range(start, end)		do { } while (0)
 #define flush_icache_page(vma,pg)		do { } while (0)
--- ./include/asm-sh/pgtable.h.~1~	Mon Oct 28 05:56:41 2002
+++ ./include/asm-sh/pgtable.h	Mon Oct 28 06:00:53 2002
@@ -26,7 +26,6 @@ extern void paging_init(void);
  *  - flush_cache_range(vma, start, end) flushes a range of pages
  *
  *  - flush_dcache_page(pg) flushes(wback&invalidates) a page for dcache
- *  - flush_page_to_ram(page) write back kernel page to ram
  *  - flush_icache_range(start, end) flushes(invalidates) a range for icache
  *  - flush_icache_page(vma, pg) flushes(invalidates) a page for icache
  *
@@ -37,7 +36,6 @@ extern void paging_init(void);
 #define flush_cache_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr)		do { } while (0)
-#define flush_page_to_ram(page)			do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
 #define flush_icache_range(start, end)		do { } while (0)
 #define flush_icache_page(vma,pg)		do { } while (0)
@@ -63,7 +61,6 @@ extern void flush_dcache_page(struct pag
 extern void flush_icache_range(unsigned long start, unsigned long end);
 extern void flush_cache_sigtramp(unsigned long addr);
 
-#define flush_page_to_ram(page)			do { } while (0)
 #define flush_icache_page(vma,pg)		do { } while (0)
 #define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
 
--- ./include/asm-sparc/cacheflush.h.~1~	Mon Oct 28 05:56:41 2002
+++ ./include/asm-sparc/cacheflush.h	Mon Oct 28 06:01:31 2002
@@ -24,10 +24,8 @@ BTFIXUPDEF_CALL(void, local_flush_cache_
 #define local_flush_cache_range(vma,start,end) BTFIXUP_CALL(local_flush_cache_range)(vma,start,end)
 #define local_flush_cache_page(vma,addr) BTFIXUP_CALL(local_flush_cache_page)(vma,addr)
 
-BTFIXUPDEF_CALL(void, local_flush_page_to_ram, unsigned long)
 BTFIXUPDEF_CALL(void, local_flush_sig_insns, struct mm_struct *, unsigned long)
 
-#define local_flush_page_to_ram(addr) BTFIXUP_CALL(local_flush_page_to_ram)(addr)
 #define local_flush_sig_insns(mm,insn_addr) BTFIXUP_CALL(local_flush_sig_insns)(mm,insn_addr)
 
 extern void smp_flush_cache_all(void);
@@ -37,7 +35,6 @@ extern void smp_flush_cache_range(struct
 				  unsigned long end);
 extern void smp_flush_cache_page(struct vm_area_struct *vma, unsigned long page);
 
-extern void smp_flush_page_to_ram(unsigned long page);
 extern void smp_flush_sig_insns(struct mm_struct *mm, unsigned long insn_addr);
 
 #endif /* CONFIG_SMP */
@@ -56,13 +53,11 @@ BTFIXUPDEF_CALL(void, flush_cache_page, 
 
 #define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
 
-BTFIXUPDEF_CALL(void, __flush_page_to_ram, unsigned long)
 BTFIXUPDEF_CALL(void, flush_sig_insns, struct mm_struct *, unsigned long)
 
-#define __flush_page_to_ram(addr) BTFIXUP_CALL(__flush_page_to_ram)(addr)
 #define flush_sig_insns(mm,insn_addr) BTFIXUP_CALL(flush_sig_insns)(mm,insn_addr)
 
-extern void flush_page_to_ram(struct page *page);
+#error flush_page_to_ram is obsoleted, please convert to flush_dcache_page
 
 #define flush_dcache_page(page)			do { } while (0)
 
--- ./include/asm-sparc64/cacheflush.h.~1~	Mon Oct 28 05:56:41 2002
+++ ./include/asm-sparc64/cacheflush.h	Mon Oct 28 06:01:41 2002
@@ -50,7 +50,4 @@ extern void smp_flush_cache_all(void);
 
 extern void flush_dcache_page(struct page *page);
 
-/* This is unnecessary on the SpitFire since D-CACHE is write-through. */
-#define flush_page_to_ram(page)			do { } while (0)
-
 #endif /* _SPARC64_CACHEFLUSH_H */
--- ./include/asm-x86_64/cacheflush.h.~1~	Mon Oct 28 05:56:58 2002
+++ ./include/asm-x86_64/cacheflush.h	Mon Oct 28 06:01:47 2002
@@ -9,7 +9,6 @@
 #define flush_cache_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr)		do { } while (0)
-#define flush_page_to_ram(page)			do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
 #define flush_icache_range(start, end)		do { } while (0)
 #define flush_icache_page(vma,pg)		do { } while (0)
--- ./include/linux/highmem.h.~1~	Mon Oct 28 05:56:41 2002
+++ ./include/linux/highmem.h	Mon Oct 28 06:01:55 2002
@@ -58,7 +58,6 @@ static inline void memclear_highpage_flu
 	kaddr = kmap_atomic(page, KM_USER0);
 	memset((char *)kaddr + offset, 0, size);
 	flush_dcache_page(page);
-	flush_page_to_ram(page);
 	kunmap_atomic(kaddr, KM_USER0);
 }
 
--- ./kernel/ptrace.c.~1~	Mon Oct 28 05:56:41 2002
+++ ./kernel/ptrace.c	Mon Oct 28 06:02:07 2002
@@ -181,11 +181,9 @@ int access_process_vm(struct task_struct
 		maddr = kmap(page);
 		if (write) {
 			memcpy(maddr + offset, buf, bytes);
-			flush_page_to_ram(page);
 			flush_icache_user_range(vma, page, addr, bytes);
 		} else {
 			memcpy(buf, maddr + offset, bytes);
-			flush_page_to_ram(page);
 		}
 		kunmap(page);
 		page_cache_release(page);
--- ./kernel/ptrace.c.~1~	Mon Oct 28 05:56:41 2002
+++ ./kernel/ptrace.c	Mon Oct 28 06:02:07 2002
@@ -181,11 +181,9 @@ int access_process_vm(struct task_struct
 		maddr = kmap(page);
 		if (write) {
 			memcpy(maddr + offset, buf, bytes);
-			flush_page_to_ram(page);
 			flush_icache_user_range(vma, page, addr, bytes);
 		} else {
 			memcpy(buf, maddr + offset, bytes);
-			flush_page_to_ram(page);
 		}
 		kunmap(page);
 		page_cache_release(page);
--- ./mm/filemap.c.~1~	Mon Oct 28 05:56:41 2002
+++ ./mm/filemap.c	Mon Oct 28 06:02:13 2002
@@ -1077,7 +1077,6 @@ success:
 	 * and possibly copy it over to another page..
 	 */
 	mark_page_accessed(page);
-	flush_page_to_ram(page);
 	return page;
 
 no_cached_page:
--- ./mm/memory.c.~1~	Mon Oct 28 05:56:41 2002
+++ ./mm/memory.c	Mon Oct 28 06:02:22 2002
@@ -760,7 +760,6 @@ static inline void break_cow(struct vm_a
 		pte_t *page_table)
 {
 	invalidate_vcache(address, vma->vm_mm, new_page);
-	flush_page_to_ram(new_page);
 	flush_cache_page(vma, address);
 	establish_pte(vma, address, page_table, pte_mkwrite(pte_mkdirty(mk_pte(new_page, vma->vm_page_prot))));
 }
@@ -1032,7 +1031,6 @@ static int do_swap_page(struct mm_struct
 		pte = pte_mkdirty(pte_mkwrite(pte));
 	unlock_page(page);
 
-	flush_page_to_ram(page);
 	flush_icache_page(vma, page);
 	set_pte(page_table, pte);
 	page_add_rmap(page, page_table);
@@ -1078,7 +1076,6 @@ static int do_anonymous_page(struct mm_s
 			return VM_FAULT_MINOR;
 		}
 		mm->rss++;
-		flush_page_to_ram(page);
 		entry = pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
 		lru_cache_add(page);
 		mark_page_accessed(page);
@@ -1159,7 +1156,6 @@ static int do_no_page(struct mm_struct *
 	/* Only go through if we didn't race with anybody else... */
 	if (pte_none(*page_table)) {
 		++mm->rss;
-		flush_page_to_ram(new_page);
 		flush_icache_page(vma, new_page);
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		if (write_access)
--- ./mm/shmem.c.~1~	Mon Oct 28 05:56:41 2002
+++ ./mm/shmem.c	Mon Oct 28 06:02:27 2002
@@ -904,7 +904,6 @@ struct page *shmem_nopage(struct vm_area
 		return (error == -ENOMEM)? NOPAGE_OOM: NOPAGE_SIGBUS;
 
 	unlock_page(page);
-	flush_page_to_ram(page);
 	return page;
 }
 
--- ./mm/swapfile.c.~1~	Mon Oct 28 05:56:42 2002
+++ ./mm/swapfile.c	Mon Oct 28 06:02:32 2002
@@ -615,7 +615,6 @@ static int try_to_unuse(unsigned int typ
 		shmem = 0;
 		swcount = *swap_map;
 		if (swcount > 1) {
-			flush_page_to_ram(page);
 			if (start_mm == &init_mm)
 				shmem = shmem_unuse(entry, page);
 			else
