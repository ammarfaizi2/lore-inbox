Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261326AbTDCQfn>; Thu, 3 Apr 2003 11:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261328AbTDCQfn>; Thu, 3 Apr 2003 11:35:43 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:16903 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S261326AbTDCQec>; Thu, 3 Apr 2003 11:34:32 -0500
Date: Thu, 3 Apr 2003 17:47:55 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: "David S. Miller" <davem@redhat.com>,
       Jes Sorensen <jes@trained-monkey.org>, Ralf Baechle <ralf@gnu.org>,
       Miles Bader <miles@gnu.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] flush flush_page_to_ram
Message-ID: <Pine.LNX.4.44.0304031741130.2047-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the long deprecated flush_page_to_ram.  We have
two different schemes for doing this cache flushing stuff, the old
flush_page_to_ram way and the not so old flush_dcache_page etc. way:
see DaveM's Documentation/cachetlb.txt.  Keeping flush_page_to_ram
around is confusing, and makes it harder to get this done right.

All architectures are updated, but the only ones where it amounts
to more than deleting a line or two are m68k, mips, mips64 and v850.

I followed a prescription from DaveM (though not to the letter), that
those arches with non-nop flush_page_to_ram need to do what it did
in their clear_user_page and copy_user_page and flush_dcache_page.

Dave is consterned that, in the v850 nb85e case, this patch leaves its
flush_dcache_page as was, uses it in clear_user_page and copy_user_page,
instead of making them all flush icache as well.  That may be wrong:
I'm just hesitant to add cruft blindly, changing a flush_dcache macro
to flush icache too; and naively hope that the necessary flush_icache
calls are already in place.  Miles, please let us know which way is
right for v850 nb85e - thanks.

Hugh

--- 2.5.66-mm3/Documentation/cachetlb.txt	Tue Apr 30 20:15:37 2002
+++ flushed/Documentation/cachetlb.txt	Wed Apr  2 19:44:01 2003
@@ -75,7 +75,7 @@
 	Platform developers note that generic code will always
 	invoke this interface with mm->page_table_lock held.
 
-4) void flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
+4) void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 
 	This time we need to remove the PAGE_SIZE sized translation
 	from the TLB.  The 'vma' is the backing structure used by
@@ -87,9 +87,9 @@
 
 	After running, this interface must make sure that any previous
 	page table modification for address space 'vma->vm_mm' for
-	user virtual address 'page' will be visible to the cpu.  That
+	user virtual address 'addr' will be visible to the cpu.  That
 	is, after running, there will be no entries in the TLB for
-	'vma->vm_mm' for virtual address 'page'.
+	'vma->vm_mm' for virtual address 'addr'.
 
 	This is used primarily during fault processing.
 
@@ -144,9 +144,9 @@
 	   change_range_of_page_tables(mm, start, end);
 	   flush_tlb_range(vma, start, end);
 
-	3) flush_cache_page(vma, page);
+	3) flush_cache_page(vma, addr);
 	   set_pte(pte_pointer, new_pte_val);
-	   flush_tlb_page(vma, page);
+	   flush_tlb_page(vma, addr);
 
 The cache level flush will always be first, because this allows
 us to properly handle systems whose caches are strict and require
@@ -200,7 +200,7 @@
 	call flush_cache_page (see below) for each entry which may be
 	modified.
 
-4) void flush_cache_page(struct vm_area_struct *vma, unsigned long page)
+4) void flush_cache_page(struct vm_area_struct *vma, unsigned long addr)
 
 	This time we need to remove a PAGE_SIZE sized range
 	from the cache.  The 'vma' is the backing structure used by
@@ -211,7 +211,7 @@
 	"Harvard" type cache layouts).
 
 	After running, there will be no entries in the cache for
-	'vma->vm_mm' for virtual address 'page'.
+	'vma->vm_mm' for virtual address 'addr'.
 
 	This is used primarily during fault processing.
 
@@ -235,7 +235,7 @@
 NOTE: This does not fix shared mmaps, check out the sparc64 port for
 one way to solve this (in particular SPARC_FLAG_MMAPSHARED).
 
-Next, you have two methods to solve the D-cache aliasing issue for all
+Next, you have to solve the D-cache aliasing issue for all
 other cases.  Please keep in mind that fact that, for a given page
 mapped into some user address space, there is always at least one more
 mapping, that of the kernel in it's linear mapping starting at
@@ -244,35 +244,8 @@
 aliasing problem has the potential to exist since the kernel already
 maps this page at its virtual address.
 
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
-
-  void copy_user_page(void *to, void *from, unsigned long address)
-  void clear_user_page(void *to, unsigned long address)
+  void copy_user_page(void *to, void *from, unsigned long addr, struct page *page)
+  void clear_user_page(void *to, unsigned long addr, struct page *page)
 
 	These two routines store data in user anonymous or COW
 	pages.  It allows a port to efficiently avoid D-cache alias
@@ -285,8 +258,9 @@
 	of the same "color" as the user mapping of the page.  Sparc64
 	for example, uses this technique.
 
-	The "address" parameter tells the virtual address where the
-	user will ultimately have this page mapped.
+	The 'addr' parameter tells the virtual address where the
+	user will ultimately have this page mapped, and the 'page'
+	parameter gives a pointer to the struct page of the target.
 
 	If D-cache aliasing is not an issue, these two routines may
 	simply call memcpy/memset directly and do nothing more.
@@ -363,5 +337,5 @@
 
   void flush_icache_page(struct vm_area_struct *vma, struct page *page)
 	All the functionality of flush_icache_page can be implemented in
-	flush_dcache_page and update_mmu_cache. In 2.5 the hope is to
+	flush_dcache_page and update_mmu_cache. In 2.7 the hope is to
 	remove this interface completely.
--- 2.5.66-mm3/arch/ia64/mm/init.c	Mon Feb 10 20:12:35 2003
+++ flushed/arch/ia64/mm/init.c	Wed Apr  2 19:44:01 2003
@@ -251,7 +251,6 @@
 			pte_unmap(pte);
 			goto out;
 		}
-		flush_page_to_ram(page);
 		set_pte(pte, mk_pte(page, PAGE_GATE));
 		pte_unmap(pte);
 	}
--- 2.5.66-mm3/arch/mips64/kernel/linux32.c	Tue Mar 18 07:38:31 2003
+++ flushed/arch/mips64/kernel/linux32.c	Wed Apr  2 19:44:01 2003
@@ -195,7 +195,7 @@
 			}
 			err = copy_from_user(kaddr + offset, (char *)A(str),
 			                     bytes_to_copy);
-			flush_page_to_ram(page);
+			flush_dcache_page(page);
 			kunmap(page);
 
 			if (err)
--- 2.5.66-mm3/arch/parisc/kernel/sys_parisc32.c	Tue Mar 25 08:06:31 2003
+++ flushed/arch/parisc/kernel/sys_parisc32.c	Wed Apr  2 19:44:01 2003
@@ -183,7 +183,6 @@
 			}
 			err = copy_from_user(kaddr + offset, (char *)A(str), bytes_to_copy);
 			flush_dcache_page(page);
-			flush_page_to_ram(page);
 			kunmap(page);
 
 			if (err)
--- 2.5.66-mm3/arch/ppc64/kernel/sys_ppc32.c	Tue Apr  1 11:25:39 2003
+++ flushed/arch/ppc64/kernel/sys_ppc32.c	Wed Apr  2 19:44:01 2003
@@ -2079,7 +2079,6 @@
 
 			err = copy_from_user(kaddr + offset, (char *)A(str),
 					     bytes_to_copy);
-			flush_page_to_ram(page);
 			kunmap((unsigned long)kaddr);
 
 			if (err)
--- 2.5.66-mm3/arch/s390x/kernel/linux32.c	Tue Mar 25 08:06:32 2003
+++ flushed/arch/s390x/kernel/linux32.c	Wed Apr  2 19:44:01 2003
@@ -1888,7 +1888,6 @@
 
 			err = copy_from_user(kaddr + offset, (char *)A(str),
 					     bytes_to_copy);
-			flush_page_to_ram(page);
 			kunmap(page);
 
 			if (err)
--- 2.5.66-mm3/fs/binfmt_elf.c	Tue Mar 25 08:06:50 2003
+++ flushed/fs/binfmt_elf.c	Wed Apr  2 19:44:01 2003
@@ -1378,7 +1378,6 @@
 					flush_cache_page(vma, addr);
 					kaddr = kmap(page);
 					DUMP_WRITE(kaddr, PAGE_SIZE);
-					flush_page_to_ram(page);
 					kunmap(page);
 				}
 				page_cache_release(page);
--- 2.5.66-mm3/fs/exec.c	Tue Apr  1 11:25:45 2003
+++ flushed/fs/exec.c	Wed Apr  2 19:44:01 2003
@@ -314,7 +314,6 @@
 	}
 	lru_cache_add_active(page);
 	flush_dcache_page(page);
-	flush_page_to_ram(page);
 	SetPageAnon(page);
 	set_pte(pte, pte_mkdirty(pte_mkwrite(mk_pte(page, PAGE_COPY))));
 	pte_chain = page_add_rmap(page, pte, pte_chain);
--- 2.5.66-mm3/include/asm-alpha/cacheflush.h	Mon Apr 15 12:30:04 2002
+++ flushed/include/asm-alpha/cacheflush.h	Wed Apr  2 19:44:01 2003
@@ -9,7 +9,6 @@
 #define flush_cache_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr)		do { } while (0)
-#define flush_page_to_ram(page)			do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
 
 /* Note that the following two definitions are _highly_ dependent
--- 2.5.66-mm3/include/asm-arm/proc-armo/cache.h	Tue Apr 23 12:18:56 2002
+++ flushed/include/asm-arm/proc-armo/cache.h	Wed Apr  2 19:44:01 2003
@@ -13,7 +13,6 @@
 #define flush_cache_mm(mm)			do { } while (0)
 #define flush_cache_range(vma,start,end)	do { } while (0)
 #define flush_cache_page(vma,vmaddr)		do { } while (0)
-#define flush_page_to_ram(page)			do { } while (0)
 
 #define invalidate_dcache_range(start,end)	do { } while (0)
 #define clean_dcache_range(start,end)		do { } while (0)
--- 2.5.66-mm3/include/asm-arm/proc-armv/cache.h	Mon Nov 18 06:02:49 2002
+++ flushed/include/asm-arm/proc-armv/cache.h	Wed Apr  2 19:44:01 2003
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
--- 2.5.66-mm3/include/asm-cris/pgtable.h	Mon Sep 16 05:51:50 2002
+++ flushed/include/asm-cris/pgtable.h	Wed Apr  2 19:44:01 2003
@@ -121,7 +121,6 @@
 #define flush_cache_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr)		do { } while (0)
-#define flush_page_to_ram(page)			do { } while (0)
 #define flush_dcache_page(page)                 do { } while (0)
 #define flush_icache_range(start, end)          do { } while (0)
 #define flush_icache_page(vma,pg)               do { } while (0)
--- 2.5.66-mm3/include/asm-i386/cacheflush.h	Wed Jun 19 20:10:02 2002
+++ flushed/include/asm-i386/cacheflush.h	Wed Apr  2 19:44:01 2003
@@ -9,7 +9,6 @@
 #define flush_cache_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr)		do { } while (0)
-#define flush_page_to_ram(page)			do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
 #define flush_icache_range(start, end)		do { } while (0)
 #define flush_icache_page(vma,pg)		do { } while (0)
--- 2.5.66-mm3/include/asm-ia64/cacheflush.h	Wed Aug 28 06:38:20 2002
+++ flushed/include/asm-ia64/cacheflush.h	Wed Apr  2 19:44:01 2003
@@ -20,7 +20,6 @@
 #define flush_cache_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr)		do { } while (0)
-#define flush_page_to_ram(page)			do { } while (0)
 #define flush_icache_page(vma,page)		do { } while (0)
 
 #define flush_dcache_page(page)			\
--- 2.5.66-mm3/include/asm-m68k/cacheflush.h	Thu Jul 25 13:04:57 2002
+++ flushed/include/asm-m68k/cacheflush.h	Wed Apr  2 19:44:01 2003
@@ -106,7 +106,6 @@
 
 /* Push the page at kernel virtual address and clear the icache */
 /* RZ: use cpush %bc instead of cpush %dc, cinv %ic */
-#define flush_page_to_ram(page) __flush_page_to_ram(page_address(page))
 extern inline void __flush_page_to_ram(void *vaddr)
 {
 	if (CPU_IS_040_OR_060) {
@@ -125,7 +124,7 @@
 	}
 }
 
-#define flush_dcache_page(page)			do { } while (0)
+#define flush_dcache_page(page)	__flush_page_to_ram(page_address(page))
 #define flush_icache_page(vma,pg)              do { } while (0)
 #define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
 
--- 2.5.66-mm3/include/asm-m68k/page.h	Tue Mar 25 08:06:54 2003
+++ flushed/include/asm-m68k/page.h	Wed Apr  2 19:44:01 2003
@@ -79,8 +79,14 @@
 #define copy_page(to,from)	memcpy((to), (from), PAGE_SIZE)
 #endif
 
-#define clear_user_page(page, vaddr, pg)	clear_page(page)
-#define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
+#define clear_user_page(addr, vaddr, page)	\
+	do { 	clear_page(addr);		\
+		flush_dcache_page(page);	\
+	} while (0)
+#define copy_user_page(to, from, vaddr, page)	\
+	do {	copy_page(to, from);		\
+		flush_dcache_page(page);	\
+	} while (0)
 
 /*
  * These are used to make use of C type-checking..
--- 2.5.66-mm3/include/asm-m68knommu/cacheflush.h	Mon Feb 24 20:03:39 2003
+++ flushed/include/asm-m68knommu/cacheflush.h	Wed Apr  2 19:44:01 2003
@@ -10,7 +10,6 @@
 #define flush_cache_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr)		do { } while (0)
-#define flush_page_to_ram(page)			do { } while (0)
 #define flush_dcache_range(start,len)		do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
 #define flush_icache_range(start,len)		__flush_cache_all()
--- 2.5.66-mm3/include/asm-mips/page.h	Tue Jan 14 12:17:45 2003
+++ flushed/include/asm-mips/page.h	Wed Apr  2 19:44:01 2003
@@ -25,8 +25,15 @@
 
 #define clear_page(page)	_clear_page(page)
 #define copy_page(to, from)	_copy_page(to, from)
-#define clear_user_page(page, vaddr)	clear_page(page)
-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
+
+#define clear_user_page(addr, vaddr, page)	\
+	do { 	clear_page(addr);		\
+		flush_dcache_page(page);	\
+	} while (0)
+#define copy_user_page(to, from, vaddr, page)	\
+	do {	copy_page(to, from);		\
+		flush_dcache_page(page);	\
+	} while (0)
 
 /*
  * These are used to make use of C type-checking..
--- 2.5.66-mm3/include/asm-mips/pgtable.h	Wed Mar  5 07:26:32 2003
+++ flushed/include/asm-mips/pgtable.h	Wed Apr  2 19:44:01 2003
@@ -24,7 +24,6 @@
  *  - flush_cache_mm(mm) flushes the specified mm context's cache lines
  *  - flush_cache_page(mm, vmaddr) flushes a single page
  *  - flush_cache_range(vma, start, end) flushes a range of pages
- *  - flush_page_to_ram(page) write back kernel page to ram
  *  - flush_icache_range(start, end) flush a range of instructions
  */
 extern void (*_flush_cache_all)(void);
@@ -39,15 +38,13 @@
 extern void (*_flush_icache_page)(struct vm_area_struct *vma,
                                   struct page *page);
 
-#define flush_dcache_page(page)			do { } while (0)
-
 #define flush_cache_all()		_flush_cache_all()
 #define __flush_cache_all()		___flush_cache_all()
 #define flush_cache_mm(mm)		_flush_cache_mm(mm)
 #define flush_cache_range(vma,start,end) _flush_cache_range(vma,start,end)
 #define flush_cache_page(vma,page)	_flush_cache_page(vma, page)
 #define flush_cache_sigtramp(addr)	_flush_cache_sigtramp(addr)
-#define flush_page_to_ram(page)		_flush_page_to_ram(page)
+#define flush_dcache_page(page)		_flush_page_to_ram(page)
 
 #define flush_icache_range(start, end)	_flush_icache_range(start,end)
 #define flush_icache_page(vma, page) 	_flush_icache_page(vma, page)
--- 2.5.66-mm3/include/asm-mips64/page.h	Tue Jan 14 12:17:45 2003
+++ flushed/include/asm-mips64/page.h	Wed Apr  2 19:44:01 2003
@@ -25,8 +25,15 @@
 
 #define clear_page(page)	_clear_page(page)
 #define copy_page(to, from)	_copy_page(to, from)
-#define clear_user_page(page, vaddr)	clear_page(page)
-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
+
+#define clear_user_page(addr, vaddr, page)	\
+	do { 	clear_page(addr);		\
+		flush_dcache_page(page);	\
+	} while (0)
+#define copy_user_page(to, from, vaddr, page)	\
+	do {	copy_page(to, from);		\
+		flush_dcache_page(page);	\
+	} while (0)
 
 /*
  * These are used to make use of C type-checking..
--- 2.5.66-mm3/include/asm-mips64/pgtable.h	Wed Mar  5 07:26:32 2003
+++ flushed/include/asm-mips64/pgtable.h	Wed Apr  2 19:44:01 2003
@@ -25,7 +25,6 @@
  *  - flush_cache_mm(mm) flushes the specified mm context's cache lines
  *  - flush_cache_page(mm, vmaddr) flushes a single page
  *  - flush_cache_range(vma, start, end) flushes a range of pages
- *  - flush_page_to_ram(page) write back kernel page to ram
  */
 extern void (*_flush_cache_mm)(struct mm_struct *mm);
 extern void (*_flush_cache_range)(struct vm_area_struct *vma, unsigned long start,
@@ -34,14 +33,12 @@
 extern void (*_flush_page_to_ram)(struct page * page);
 
 #define flush_cache_all()		do { } while(0)
-#define flush_dcache_page(page)		do { } while (0)
 
 #ifndef CONFIG_CPU_R10000
 #define flush_cache_mm(mm)		_flush_cache_mm(mm)
 #define flush_cache_range(vma,start,end) _flush_cache_range(vma,start,end)
 #define flush_cache_page(vma,page)	_flush_cache_page(vma, page)
-#define flush_page_to_ram(page)		_flush_page_to_ram(page)
-
+#define flush_dcache_page(page)		_flush_page_to_ram(page)
 #define flush_icache_range(start, end)	_flush_cache_l1()
 #define flush_icache_user_range(vma, page, addr, len)	\
 					flush_icache_page((vma), (page))
@@ -66,7 +63,7 @@
 #define flush_cache_mm(mm)		do { } while(0)
 #define flush_cache_range(vma,start,end) do { } while(0)
 #define flush_cache_page(vma,page)	do { } while(0)
-#define flush_page_to_ram(page)		do { } while(0)
+#define flush_dcache_page(page)		do { } while(0)
 #define flush_icache_range(start, end)	_flush_cache_l1()
 #define flush_icache_user_range(vma, page, addr, len)	\
 					flush_icache_page((vma), (page))
--- 2.5.66-mm3/include/asm-parisc/cacheflush.h	Tue Mar 25 08:06:54 2003
+++ flushed/include/asm-parisc/cacheflush.h	Wed Apr  2 19:44:01 2003
@@ -18,11 +18,6 @@
 #define flush_kernel_dcache_range(start,size) \
 	flush_kernel_dcache_range_asm((start), (start)+(size));
 
-static inline void
-flush_page_to_ram(struct page *page)
-{
-}
-
 extern void flush_cache_all_local(void);
 
 static inline void cacheflush_h_tmp_function(void *dummy)
--- 2.5.66-mm3/include/asm-ppc/cacheflush.h	Mon Nov 11 08:26:55 2002
+++ flushed/include/asm-ppc/cacheflush.h	Wed Apr  2 19:44:01 2003
@@ -23,7 +23,6 @@
 #define flush_cache_mm(mm)		do { } while (0)
 #define flush_cache_range(vma, a, b)	do { } while (0)
 #define flush_cache_page(vma, p)	do { } while (0)
-#define flush_page_to_ram(page)		do { } while (0)
 #define flush_icache_page(vma, page)	do { } while (0)
 
 extern void flush_dcache_page(struct page *page);
--- 2.5.66-mm3/include/asm-ppc64/cacheflush.h	Mon Jan 13 19:32:03 2003
+++ flushed/include/asm-ppc64/cacheflush.h	Wed Apr  2 19:44:01 2003
@@ -13,7 +13,6 @@
 #define flush_cache_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr)		do { } while (0)
-#define flush_page_to_ram(page)			do { } while (0)
 #define flush_icache_page(vma, page)		do { } while (0)
 
 extern void flush_dcache_page(struct page *page);
--- 2.5.66-mm3/include/asm-s390/cacheflush.h	Sun Jun  9 07:01:22 2002
+++ flushed/include/asm-s390/cacheflush.h	Wed Apr  2 19:44:01 2003
@@ -9,7 +9,6 @@
 #define flush_cache_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr)		do { } while (0)
-#define flush_page_to_ram(page)			do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
 #define flush_icache_range(start, end)		do { } while (0)
 #define flush_icache_page(vma,pg)		do { } while (0)
--- 2.5.66-mm3/include/asm-s390x/cacheflush.h	Sun Jun  9 07:01:23 2002
+++ flushed/include/asm-s390x/cacheflush.h	Wed Apr  2 19:44:01 2003
@@ -9,7 +9,6 @@
 #define flush_cache_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr)		do { } while (0)
-#define flush_page_to_ram(page)			do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
 #define flush_icache_range(start, end)		do { } while (0)
 #define flush_icache_page(vma,pg)		do { } while (0)
--- 2.5.66-mm3/include/asm-sh/pgtable.h	Tue Mar 18 07:38:43 2003
+++ flushed/include/asm-sh/pgtable.h	Wed Apr  2 19:44:01 2003
@@ -26,7 +26,6 @@
  *  - flush_cache_range(vma, start, end) flushes a range of pages
  *
  *  - flush_dcache_page(pg) flushes(wback&invalidates) a page for dcache
- *  - flush_page_to_ram(page) write back kernel page to ram
  *  - flush_icache_range(start, end) flushes(invalidates) a range for icache
  *  - flush_icache_page(vma, pg) flushes(invalidates) a page for icache
  *
@@ -37,7 +36,6 @@
 #define flush_cache_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr)		do { } while (0)
-#define flush_page_to_ram(page)			do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
 #define flush_icache_range(start, end)		do { } while (0)
 #define flush_icache_page(vma,pg)		do { } while (0)
@@ -63,7 +61,6 @@
 extern void flush_icache_range(unsigned long start, unsigned long end);
 extern void flush_cache_sigtramp(unsigned long addr);
 
-#define flush_page_to_ram(page)			do { } while (0)
 #define flush_icache_page(vma,pg)		do { } while (0)
 #define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
 
--- 2.5.66-mm3/include/asm-sparc/cacheflush.h	Sat Feb 15 08:30:11 2003
+++ flushed/include/asm-sparc/cacheflush.h	Wed Apr  2 19:44:01 2003
@@ -64,7 +64,6 @@
 
 extern void sparc_flush_page_to_ram(struct page *page);
 
-#define flush_page_to_ram(page)			do { } while (0)
 #define flush_dcache_page(page)			sparc_flush_page_to_ram(page)
 
 #endif /* _SPARC_CACHEFLUSH_H */
--- 2.5.66-mm3/include/asm-sparc64/cacheflush.h	Fri May  3 12:16:53 2002
+++ flushed/include/asm-sparc64/cacheflush.h	Wed Apr  2 19:44:01 2003
@@ -50,7 +50,4 @@
 
 extern void flush_dcache_page(struct page *page);
 
-/* This is unnecessary on the SpitFire since D-CACHE is write-through. */
-#define flush_page_to_ram(page)			do { } while (0)
-
 #endif /* _SPARC64_CACHEFLUSH_H */
--- 2.5.66-mm3/include/asm-v850/cacheflush.h	Tue Nov  5 00:03:09 2002
+++ flushed/include/asm-v850/cacheflush.h	Wed Apr  2 19:44:01 2003
@@ -29,7 +29,6 @@
 #define flush_cache_mm(mm)			((void)0)
 #define flush_cache_range(vma, start, end)	((void)0)
 #define flush_cache_page(vma, vmaddr)		((void)0)
-#define flush_page_to_ram(page)			((void)0)
 #define flush_dcache_page(page)			((void)0)
 #define flush_icache()				((void)0)
 #define flush_icache_range(start, end)		((void)0)
--- 2.5.66-mm3/include/asm-v850/nb85e_cache.h	Tue Nov  5 00:03:09 2002
+++ flushed/include/asm-v850/nb85e_cache.h	Wed Apr  2 19:44:01 2003
@@ -96,7 +96,6 @@
 #define flush_cache_mm(mm)			nb85e_cache_flush ()
 #define flush_cache_range(mm, start, end)	nb85e_cache_flush ()
 #define flush_cache_page(vma, vmaddr)		nb85e_cache_flush ()
-#define flush_page_to_ram(page)			nb85e_cache_flush ()
 #define flush_dcache_page(page)			nb85e_cache_flush_dcache ()
 #define flush_icache_range(start, end)		nb85e_cache_flush_icache ()
 #define flush_icache_page(vma,pg)		nb85e_cache_flush_icache ()
--- 2.5.66-mm3/include/asm-v850/page.h	Mon Feb 24 20:03:40 2003
+++ flushed/include/asm-v850/page.h	Wed Apr  2 19:44:01 2003
@@ -40,8 +40,14 @@
 #define clear_page(page)	memset ((void *)(page), 0, PAGE_SIZE)
 #define copy_page(to, from)	memcpy ((void *)(to), (void *)from, PAGE_SIZE)
 
-#define clear_user_page(page, vaddr, pg)	clear_page (page)
-#define copy_user_page(to, from, vaddr,pg)	copy_page (to, from)
+#define clear_user_page(addr, vaddr, page)	\
+	do { 	clear_page(addr);		\
+		flush_dcache_page(page);	\
+	} while (0)
+#define copy_user_page(to, from, vaddr, page)	\
+	do {	copy_page(to, from);		\
+		flush_dcache_page(page);	\
+	} while (0)
 
 #ifdef STRICT_MM_TYPECHECKS
 /*
--- 2.5.66-mm3/include/asm-x86_64/cacheflush.h	Wed Oct 16 06:31:03 2002
+++ flushed/include/asm-x86_64/cacheflush.h	Wed Apr  2 19:44:01 2003
@@ -9,7 +9,6 @@
 #define flush_cache_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr)		do { } while (0)
-#define flush_page_to_ram(page)			do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
 #define flush_icache_range(start, end)		do { } while (0)
 #define flush_icache_page(vma,pg)		do { } while (0)
--- 2.5.66-mm3/include/linux/highmem.h	Tue Apr  1 11:25:49 2003
+++ flushed/include/linux/highmem.h	Wed Apr  2 19:44:01 2003
@@ -67,7 +67,6 @@
 	kaddr = kmap_atomic(page, KM_USER0);
 	memset((char *)kaddr + offset, 0, size);
 	flush_dcache_page(page);
-	flush_page_to_ram(page);
 	kunmap_atomic(kaddr, KM_USER0);
 }
 
--- 2.5.66-mm3/mm/filemap.c	Tue Apr  1 11:25:50 2003
+++ flushed/mm/filemap.c	Wed Apr  2 19:44:01 2003
@@ -1008,11 +1008,9 @@
 
 success:
 	/*
-	 * Found the page and have a reference on it, need to check sharing
-	 * and possibly copy it over to another page..
+	 * Found the page and have a reference on it.
 	 */
 	mark_page_accessed(page);
-	flush_page_to_ram(page);
 	return page;
 
 no_cached_page:
@@ -1124,12 +1122,9 @@
 
 success:
 	/*
-	 * Found the page and have a reference on it, need to check sharing
-	 * and possibly copy it over to another page..
+	 * Found the page and have a reference on it.
 	 */
 	mark_page_accessed(page);
-	flush_page_to_ram(page);
-
 	return page;
 
 no_cached_page:
--- 2.5.66-mm3/mm/fremap.c	Tue Apr  1 11:25:50 2003
+++ flushed/mm/fremap.c	Wed Apr  2 19:44:01 2003
@@ -91,7 +91,6 @@
 	flush = zap_pte(mm, vma, addr, pte);
 
 	mm->rss++;
-	flush_page_to_ram(page);
 	flush_icache_page(vma, page);
 	set_pte(pte, mk_pte(page, prot));
 	pte_chain = page_add_rmap(page, pte, pte_chain);
--- 2.5.66-mm3/mm/memory.c	Tue Apr  1 11:25:50 2003
+++ flushed/mm/memory.c	Wed Apr  2 19:44:01 2003
@@ -928,7 +928,6 @@
 		pte_t *page_table)
 {
 	invalidate_vcache(address, vma->vm_mm, new_page);
-	flush_page_to_ram(new_page);
 	flush_cache_page(vma, address);
 	establish_pte(vma, address, page_table, pte_mkwrite(pte_mkdirty(mk_pte(new_page, vma->vm_page_prot))));
 }
@@ -1219,7 +1218,6 @@
 		pte = pte_mkdirty(pte_mkwrite(pte));
 	unlock_page(page);
 
-	flush_page_to_ram(page);
 	flush_icache_page(vma, page);
 	set_pte(page_table, pte);
 	SetPageAnon(page);
@@ -1285,7 +1283,6 @@
 			goto out;
 		}
 		mm->rss++;
-		flush_page_to_ram(page);
 		entry = pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
 		lru_cache_add_active(page);
 		mark_page_accessed(page);
@@ -1385,7 +1382,6 @@
 	/* Only go through if we didn't race with anybody else... */
 	if (pte_none(*page_table)) {
 		++mm->rss;
-		flush_page_to_ram(new_page);
 		flush_icache_page(vma, new_page);
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		if (write_access)
--- 2.5.66-mm3/mm/shmem.c	Wed Apr  2 19:22:23 2003
+++ flushed/mm/shmem.c	Wed Apr  2 19:44:01 2003
@@ -832,7 +832,6 @@
 			shmem_swp_unmap(entry);
 			delete_from_swap_cache(swappage);
 			spin_unlock(&info->lock);
-			flush_page_to_ram(swappage);
 			copy_highpage(filepage, swappage);
 			unlock_page(swappage);
 			page_cache_release(swappage);
@@ -953,7 +952,6 @@
 		return (error == -ENOMEM)? NOPAGE_OOM: NOPAGE_SIGBUS;
 
 	mark_page_accessed(page);
-	flush_page_to_ram(page);
 	return page;
 }
 
@@ -981,7 +979,6 @@
 			return err;
 		if (page) {
 			mark_page_accessed(page);
-			flush_page_to_ram(page);
 			err = install_page(mm, vma, addr, page, prot);
 			if (err) {
 				page_cache_release(page);
--- 2.5.66-mm3/mm/swapfile.c	Tue Apr  1 11:25:50 2003
+++ flushed/mm/swapfile.c	Wed Apr  2 19:44:01 2003
@@ -642,7 +642,6 @@
 		shmem = 0;
 		swcount = *swap_map;
 		if (swcount > 1) {
-			flush_page_to_ram(page);
 			if (start_mm == &init_mm)
 				shmem = shmem_unuse(entry, page);
 			else

