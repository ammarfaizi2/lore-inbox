Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277435AbRKVLo2>; Thu, 22 Nov 2001 06:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277509AbRKVLoU>; Thu, 22 Nov 2001 06:44:20 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:16915 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S277435AbRKVLoI>;
	Thu, 22 Nov 2001 06:44:08 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15356.58612.264155.733585@cargo.ozlabs.ibm.com>
Date: Thu, 22 Nov 2001 22:43:48 +1100 (EST)
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] flush_icache_user_range
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below changes access_one_page in kernel/ptrace.c to use a
new function, flush_icache_user_range, instead of flush_icache_page as
at present.  The reason for making this change is that
flush_icache_page is also called in do_no_page and do_swap_page, where
it does a fundamentally different job.  Decoupling the two makes it
possible to improve performance, because we can make flush_icache_page
do the flush only when needed.

This patch particularly affects alpha: for alpha I renamed the
existing flush_icache_page to flush_icache_user_range and made
flush_icache_page a no-op.  This is based on a suggestion from
Andrea and the comments in the code.  I would be very interested to
hear how it affects alpha as regards stability and performance.

For PPC, I have added a flush_icache_user_range that only flushes the
cachelines that have been modified.  I have a more extensive
cache-flush avoidance patch in the works that depends on this one and
also needs modifications to clear_user_page and copy_user_page.  This
all gives us a substantial performance increase on PPC.

For all the other architectures I have made flush_icache_user_range
the same as flush_icache_page, i.e. a no-op for most architectures.
So this patch should have zero impact except on alpha and PPC, and on
alpha it should improve performance.

Note that flush_icache_user_range is different from flush_icache_page
now in that flush_icache_user_range is only called when the page has
been modified, so we know we do have to flush (if the icache doesn't
snoop stores by the cpu).  In contrast, flush_icache_page is called in
situations where the page often (usually?) is unmodified, so it makes
sense to try to work out whether the flush is actually needed.

Comments?  Linus, would you be willing to apply this?

Paul.

diff -ur linux-2.4.15-pre9/Documentation/cachetlb.txt test/Documentation/cachetlb.txt
--- linux-2.4.15-pre9/Documentation/cachetlb.txt	Wed Oct 24 23:04:52 2001
+++ test/Documentation/cachetlb.txt	Thu Nov 22 22:11:04 2001
@@ -339,6 +339,17 @@
 	If the icache does not snoop stores then this routine will need
 	to flush it.
 
+  void flush_icache_user_range(struct vm_area_struct *vma,
+			struct page *page, unsigned long addr, int len)
+	This is called when the kernel stores into addresses that are
+	part of the address space of a user process (which may be some
+	other process than the current process).  The addr argument
+	gives the virtual address in that process's address space,
+	page is the page which is being modified, and len indicates
+	how many bytes have been modified.  The modified region must
+	not cross a page boundary.  Currently this is only called from
+	kernel/ptrace.c.
+
   void flush_icache_page(struct vm_area_struct *vma, struct page *page)
 	All the functionality of flush_icache_page can be implemented in
 	flush_dcache_page and update_mmu_cache. In 2.5 the hope is to
diff -ur linux-2.4.15-pre9/arch/alpha/kernel/smp.c test/arch/alpha/kernel/smp.c
--- linux-2.4.15-pre9/arch/alpha/kernel/smp.c	Thu Nov 22 22:06:49 2001
+++ test/arch/alpha/kernel/smp.c	Thu Nov 22 22:11:04 2001
@@ -1064,7 +1064,8 @@
 }
 
 void
-flush_icache_page(struct vm_area_struct *vma, struct page *page)
+flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
+			unsigned long addr, int len)
 {
 	struct mm_struct *mm = vma->vm_mm;
 
diff -ur linux-2.4.15-pre9/arch/ppc/mm/init.c test/arch/ppc/mm/init.c
--- linux-2.4.15-pre9/arch/ppc/mm/init.c	Wed Oct 10 12:38:52 2001
+++ test/arch/ppc/mm/init.c	Thu Nov 22 22:11:04 2001
@@ -601,3 +601,13 @@
 	*ptep = pte;
 #endif
 }
+
+void flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
+			     unsigned long addr, int len)
+{
+	unsigned long maddr;
+
+	maddr = (unsigned long) kmap(page) + (addr & ~PAGE_MASK);
+	flush_icache_range(maddr, maddr + len);
+	kunmap(page);
+}
diff -ur linux-2.4.15-pre9/include/asm-alpha/pgalloc.h test/include/asm-alpha/pgalloc.h
--- linux-2.4.15-pre9/include/asm-alpha/pgalloc.h	Sat May 26 12:39:52 2001
+++ test/include/asm-alpha/pgalloc.h	Thu Nov 22 22:11:04 2001
@@ -70,8 +70,7 @@
 }
 
 /* We need to flush the userspace icache after setting breakpoints in
-   ptrace.  I don't think it's needed in do_swap_page, or do_no_page,
-   but I don't know how to get rid of it either.
+   ptrace.
 
    Instead of indiscriminately using imb, take advantage of the fact
    that icache entries are tagged with the ASN and load a new mm context.  */
@@ -79,7 +78,8 @@
 
 #ifndef CONFIG_SMP
 static inline void
-flush_icache_page(struct vm_area_struct *vma, struct page *page)
+flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
+			unsigned long addr, int len)
 {
 	if (vma->vm_flags & VM_EXEC) {
 		struct mm_struct *mm = vma->vm_mm;
@@ -90,8 +90,12 @@
 	}
 }
 #else
-extern void flush_icache_page(struct vm_area_struct *vma, struct page *page);
+extern void flush_icache_user_range(struct vm_area_struct *vma,
+		struct page *page, unsigned long addr, int len);
 #endif
+
+/* this is used only in do_no_page and do_swap_page */
+#define flush_icache_page(vma, page)	do { } while (0)
 
 /*
  * Flush just one page in the current TLB set.
diff -ur linux-2.4.15-pre9/include/asm-cris/pgtable.h test/include/asm-cris/pgtable.h
--- linux-2.4.15-pre9/include/asm-cris/pgtable.h	Thu Nov 22 22:06:57 2001
+++ test/include/asm-cris/pgtable.h	Thu Nov 22 22:11:04 2001
@@ -117,6 +117,7 @@
 #define flush_dcache_page(page)                 do { } while (0)
 #define flush_icache_range(start, end)          do { } while (0)
 #define flush_icache_page(vma,pg)               do { } while (0)
+#define flush_icache_user_range(vma,pg,adr,len) do { } while (0)
 
 /*
  * TLB flushing (implemented in arch/cris/mm/tlb.c):
diff -ur linux-2.4.15-pre9/include/asm-i386/pgtable.h test/include/asm-i386/pgtable.h
--- linux-2.4.15-pre9/include/asm-i386/pgtable.h	Thu Nov 22 22:06:57 2001
+++ test/include/asm-i386/pgtable.h	Thu Nov 22 22:11:04 2001
@@ -33,6 +33,7 @@
 #define flush_dcache_page(page)			do { } while (0)
 #define flush_icache_range(start, end)		do { } while (0)
 #define flush_icache_page(vma,pg)		do { } while (0)
+#define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
 
 #define __flush_tlb()							\
 	do {								\
diff -ur linux-2.4.15-pre9/include/asm-m68k/pgalloc.h test/include/asm-m68k/pgalloc.h
--- linux-2.4.15-pre9/include/asm-m68k/pgalloc.h	Tue Nov  6 18:21:37 2001
+++ test/include/asm-m68k/pgalloc.h	Thu Nov 22 22:11:04 2001
@@ -127,6 +127,7 @@
 
 #define flush_dcache_page(page)			do { } while (0)
 #define flush_icache_page(vma,pg)              do { } while (0)
+#define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
 
 /* Push n pages at kernel virtual address and clear the icache */
 /* RZ: use cpush %bc instead of cpush %dc, cinv %ic */
diff -ur linux-2.4.15-pre9/include/asm-mips/pgtable.h test/include/asm-mips/pgtable.h
--- linux-2.4.15-pre9/include/asm-mips/pgtable.h	Mon Sep 24 09:31:35 2001
+++ test/include/asm-mips/pgtable.h	Thu Nov 22 22:11:04 2001
@@ -51,6 +51,8 @@
 
 #define flush_icache_range(start, end)	_flush_icache_range(start,end)
 #define flush_icache_page(vma, page) 	_flush_icache_page(vma, page)
+#define flush_icache_user_range(vma, page, addr, len)	\
+					_flush_icache_page((vma), (page))
 
 
 /*
diff -ur linux-2.4.15-pre9/include/asm-mips64/pgtable.h test/include/asm-mips64/pgtable.h
--- linux-2.4.15-pre9/include/asm-mips64/pgtable.h	Mon Sep 24 09:31:36 2001
+++ test/include/asm-mips64/pgtable.h	Thu Nov 22 22:11:04 2001
@@ -43,6 +43,8 @@
 #define flush_page_to_ram(page)		_flush_page_to_ram(page)
 
 #define flush_icache_range(start, end)	_flush_cache_l1()
+#define flush_icache_user_range(vma, page, addr, len)	\
+					flush_icache_page((vma), (page))
 
 #define flush_icache_page(vma, page)					\
 do {									\
@@ -66,6 +68,8 @@
 #define flush_cache_page(vma,page)	do { } while(0)
 #define flush_page_to_ram(page)		do { } while(0)
 #define flush_icache_range(start, end)	_flush_cache_l1()
+#define flush_icache_user_range(vma, page, addr, len)	\
+					flush_icache_page((vma), (page))
 #define flush_icache_page(vma, page)					\
 do {									\
 	if ((vma)->vm_flags & VM_EXEC)					\
diff -ur linux-2.4.15-pre9/include/asm-parisc/pgalloc.h test/include/asm-parisc/pgalloc.h
--- linux-2.4.15-pre9/include/asm-parisc/pgalloc.h	Sat Apr 28 23:02:53 2001
+++ test/include/asm-parisc/pgalloc.h	Thu Nov 22 22:11:04 2001
@@ -106,6 +106,9 @@
 #define flush_icache_range(start, end) \
         __flush_icache_range(start, end - start)
 
+#define flush_icache_user_range(vma, page, addr, len) \
+	flush_icache_page((vma), (page))
+
 #define flush_icache_page(vma, page) \
 	__flush_icache_range(page_address(page), PAGE_SIZE)
 
diff -ur linux-2.4.15-pre9/include/asm-ppc/pgtable.h test/include/asm-ppc/pgtable.h
--- linux-2.4.15-pre9/include/asm-ppc/pgtable.h	Thu Nov 22 22:06:57 2001
+++ test/include/asm-ppc/pgtable.h	Thu Nov 22 22:11:04 2001
@@ -84,6 +84,8 @@
 #define flush_cache_page(vma, p)	do { } while (0)
 #define flush_icache_page(vma, page)	do { } while (0)
 
+extern void flush_icache_user_range(struct vm_area_struct *vma,
+		struct page *page, unsigned long addr, int len);
 extern void flush_icache_range(unsigned long, unsigned long);
 extern void __flush_page_to_ram(unsigned long page_va);
 extern void flush_page_to_ram(struct page *page);
diff -ur linux-2.4.15-pre9/include/asm-s390/pgtable.h test/include/asm-s390/pgtable.h
--- linux-2.4.15-pre9/include/asm-s390/pgtable.h	Wed Oct 24 23:05:18 2001
+++ test/include/asm-s390/pgtable.h	Thu Nov 22 22:11:04 2001
@@ -42,6 +42,7 @@
 #define flush_dcache_page(page)			do { } while (0)
 #define flush_icache_range(start, end)          do { } while (0)
 #define flush_icache_page(vma,pg)               do { } while (0)
+#define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
 
 /*
  * The S390 doesn't have any external MMU info: the kernel page
diff -ur linux-2.4.15-pre9/include/asm-s390x/pgtable.h test/include/asm-s390x/pgtable.h
--- linux-2.4.15-pre9/include/asm-s390x/pgtable.h	Wed Oct 24 23:05:20 2001
+++ test/include/asm-s390x/pgtable.h	Thu Nov 22 22:11:04 2001
@@ -38,6 +38,7 @@
 #define flush_dcache_page(page)			do { } while (0)
 #define flush_icache_range(start, end)          do { } while (0)
 #define flush_icache_page(vma,pg)               do { } while (0)
+#define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
 
 /*
  * The S390 doesn't have any external MMU info: the kernel page
diff -ur linux-2.4.15-pre9/include/asm-sh/pgtable.h test/include/asm-sh/pgtable.h
--- linux-2.4.15-pre9/include/asm-sh/pgtable.h	Thu Nov 22 22:06:57 2001
+++ test/include/asm-sh/pgtable.h	Thu Nov 22 22:11:04 2001
@@ -41,6 +41,7 @@
 #define flush_dcache_page(page)			do { } while (0)
 #define flush_icache_range(start, end)		do { } while (0)
 #define flush_icache_page(vma,pg)		do { } while (0)
+#define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
 #define flush_cache_sigtramp(vaddr)		do { } while (0)
 
 #define p3_cache_init()				do { } while (0)
@@ -64,6 +65,7 @@
 
 #define flush_page_to_ram(page)			do { } while (0)
 #define flush_icache_page(vma,pg)		do { } while (0)
+#define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
 
 /* Initialization of P3 area for copy_user_page */
 extern void p3_cache_init(void);
diff -ur linux-2.4.15-pre9/include/asm-sparc/pgtable.h test/include/asm-sparc/pgtable.h
--- linux-2.4.15-pre9/include/asm-sparc/pgtable.h	Thu Nov 22 22:06:57 2001
+++ test/include/asm-sparc/pgtable.h	Thu Nov 22 22:11:04 2001
@@ -348,6 +348,7 @@
 extern unsigned int pg_iobits;
 
 #define flush_icache_page(vma, pg)      do { } while(0)
+#define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
 
 /* Certain architectures need to do special things when pte's
  * within a page table are directly modified.  Thus, the following
diff -ur linux-2.4.15-pre9/include/asm-sparc64/pgtable.h test/include/asm-sparc64/pgtable.h
--- linux-2.4.15-pre9/include/asm-sparc64/pgtable.h	Thu Nov 22 22:06:57 2001
+++ test/include/asm-sparc64/pgtable.h	Thu Nov 22 22:17:09 2001
@@ -267,6 +267,7 @@
 extern void update_mmu_cache(struct vm_area_struct *, unsigned long, pte_t);
 
 #define flush_icache_page(vma, pg)	do { } while(0)
+#define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
 
 /* Make a non-present pseudo-TTE. */
 extern inline pte_t mk_pte_io(unsigned long page, pgprot_t prot, int space)
diff -ur linux-2.4.15-pre9/kernel/ptrace.c test/kernel/ptrace.c
--- linux-2.4.15-pre9/kernel/ptrace.c	Thu Nov 22 22:06:58 2001
+++ test/kernel/ptrace.c	Thu Nov 22 22:11:04 2001
@@ -165,7 +165,7 @@
 		maddr = kmap(page);
 		memcpy(maddr + (addr & ~PAGE_MASK), buf, len);
 		flush_page_to_ram(page);
-		flush_icache_page(vma, page);
+		flush_icache_user_range(vma, page, addr, len);
 		kunmap(page);
 	} else {
 		maddr = kmap(page);
