Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291532AbSBMKpd>; Wed, 13 Feb 2002 05:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291541AbSBMKpZ>; Wed, 13 Feb 2002 05:45:25 -0500
Received: from panoramix.vasoftware.com ([198.186.202.147]:26849 "EHLO
	mail2.vasoftware.com") by vger.kernel.org with ESMTP
	id <S291532AbSBMKpM>; Wed, 13 Feb 2002 05:45:12 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15466.17233.392549.252016@argo.ozlabs.ibm.com>
Date: Wed, 13 Feb 2002 21:43:29 +1100 (EST)
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] flush_icache_user_range (v2.5.4)
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below changes access_process_vm to use a new architecture
hook, flush_icache_user_range, instead of flush_icache_page, and adds
a definition of flush_icache_user_range which does the same thing as
flush_icache_page for all architectures except PPC.  (The PPC update
that is in Linus' BK tree already includes a suitable definition of
flush_icache_user_range.)

The reason for doing this is that when flush_icache_page is called
from do_no_page or do_swap_page, I want to be able to do the flush
conditionally, based on the state of the page.  In contrast,
access_process_vm needs to do the flush unconditionally since it has
just modified the page.  In the access_process_vm case it is useful to
have the information about the user address and length that have been
modified since then we can just flush the affected cache lines rather
than the whole page.

This patch should make it easy to improve performance on alpha, since
there (as I understand it) the icache flush is not needed at all in
do_no_page or do_swap_page, but is needed in access_process_vm.  All
that is needed is to make flush_icache_page a noop on alpha.  The
patch below doesn't do this, I'll let the alpha maintainers push that
change if they want.

Linus, I would like to see this patch go into 2.5.x.  I have posted
this patch before without any adverse response, and in fact Andrea
seemed to like it.

Thanks,
Paul.

diff -urN linux-2.5/Documentation/cachetlb.txt pmac-2.5/Documentation/cachetlb.txt
--- linux-2.5/Documentation/cachetlb.txt	Wed Feb  6 02:24:34 2002
+++ pmac-2.5/Documentation/cachetlb.txt	Wed Feb 13 19:27:30 2002
@@ -341,6 +341,17 @@
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
diff -urN linux-2.5/arch/alpha/kernel/smp.c pmac-2.5/arch/alpha/kernel/smp.c
--- linux-2.5/arch/alpha/kernel/smp.c	Tue Feb 12 19:17:36 2002
+++ pmac-2.5/arch/alpha/kernel/smp.c	Wed Feb 13 19:27:30 2002
@@ -1061,7 +1061,8 @@
 }
 
 void
-flush_icache_page(struct vm_area_struct *vma, struct page *page)
+flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
+			unsigned long addr, int len)
 {
 	struct mm_struct *mm = vma->vm_mm;
 
diff -urN linux-2.5/include/asm-alpha/pgalloc.h pmac-2.5/include/asm-alpha/pgalloc.h
--- linux-2.5/include/asm-alpha/pgalloc.h	Wed Feb  6 02:24:35 2002
+++ pmac-2.5/include/asm-alpha/pgalloc.h	Wed Feb 13 19:27:30 2002
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
+#define flush_icache_page(vma, page)	flush_icache_user_range((vma), (page), 0, 0)
 
 /*
  * Flush just one page in the current TLB set.
diff -urN linux-2.5/include/asm-cris/pgtable.h pmac-2.5/include/asm-cris/pgtable.h
--- linux-2.5/include/asm-cris/pgtable.h	Wed Feb  6 02:24:38 2002
+++ pmac-2.5/include/asm-cris/pgtable.h	Wed Feb 13 19:27:30 2002
@@ -125,6 +125,7 @@
 #define flush_dcache_page(page)                 do { } while (0)
 #define flush_icache_range(start, end)          do { } while (0)
 #define flush_icache_page(vma,pg)               do { } while (0)
+#define flush_icache_user_range(vma,pg,adr,len) do { } while (0)
 
 /*
  * TLB flushing (implemented in arch/cris/mm/tlb.c):
diff -urN linux-2.5/include/asm-i386/pgtable.h pmac-2.5/include/asm-i386/pgtable.h
--- linux-2.5/include/asm-i386/pgtable.h	Wed Feb  6 02:24:35 2002
+++ pmac-2.5/include/asm-i386/pgtable.h	Wed Feb 13 19:27:31 2002
@@ -33,6 +33,7 @@
 #define flush_dcache_page(page)			do { } while (0)
 #define flush_icache_range(start, end)		do { } while (0)
 #define flush_icache_page(vma,pg)		do { } while (0)
+#define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
 
 #define __flush_tlb()							\
 	do {								\
diff -urN linux-2.5/include/asm-m68k/pgalloc.h pmac-2.5/include/asm-m68k/pgalloc.h
--- linux-2.5/include/asm-m68k/pgalloc.h	Wed Feb  6 02:24:35 2002
+++ pmac-2.5/include/asm-m68k/pgalloc.h	Wed Feb 13 19:27:31 2002
@@ -127,6 +127,7 @@
 
 #define flush_dcache_page(page)			do { } while (0)
 #define flush_icache_page(vma,pg)              do { } while (0)
+#define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
 
 /* Push n pages at kernel virtual address and clear the icache */
 /* RZ: use cpush %bc instead of cpush %dc, cinv %ic */
diff -urN linux-2.5/include/asm-mips/pgtable.h pmac-2.5/include/asm-mips/pgtable.h
--- linux-2.5/include/asm-mips/pgtable.h	Wed Feb  6 02:24:35 2002
+++ pmac-2.5/include/asm-mips/pgtable.h	Wed Feb 13 19:27:31 2002
@@ -51,6 +51,8 @@
 
 #define flush_icache_range(start, end)	_flush_icache_range(start,end)
 #define flush_icache_page(vma, page) 	_flush_icache_page(vma, page)
+#define flush_icache_user_range(vma, page, addr, len)	\
+					_flush_icache_page((vma), (page))
 
 
 /*
diff -urN linux-2.5/include/asm-mips64/pgtable.h pmac-2.5/include/asm-mips64/pgtable.h
--- linux-2.5/include/asm-mips64/pgtable.h	Wed Feb  6 02:24:35 2002
+++ pmac-2.5/include/asm-mips64/pgtable.h	Wed Feb 13 19:27:31 2002
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
diff -urN linux-2.5/include/asm-parisc/pgalloc.h pmac-2.5/include/asm-parisc/pgalloc.h
--- linux-2.5/include/asm-parisc/pgalloc.h	Wed Feb  6 02:24:35 2002
+++ pmac-2.5/include/asm-parisc/pgalloc.h	Wed Feb 13 19:27:31 2002
@@ -106,6 +106,9 @@
 #define flush_icache_range(start, end) \
         __flush_icache_range(start, end - start)
 
+#define flush_icache_user_range(vma, page, addr, len) \
+	flush_icache_page((vma), (page))
+
 #define flush_icache_page(vma, page) \
 	__flush_icache_range(page_address(page), PAGE_SIZE)
 
diff -urN linux-2.5/include/asm-s390/pgtable.h pmac-2.5/include/asm-s390/pgtable.h
--- linux-2.5/include/asm-s390/pgtable.h	Wed Feb  6 02:24:35 2002
+++ pmac-2.5/include/asm-s390/pgtable.h	Wed Feb 13 19:27:40 2002
@@ -42,6 +42,7 @@
 #define flush_dcache_page(page)			do { } while (0)
 #define flush_icache_range(start, end)          do { } while (0)
 #define flush_icache_page(vma,pg)               do { } while (0)
+#define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
 
 /*
  * The S390 doesn't have any external MMU info: the kernel page
diff -urN linux-2.5/include/asm-s390x/pgtable.h pmac-2.5/include/asm-s390x/pgtable.h
--- linux-2.5/include/asm-s390x/pgtable.h	Wed Feb  6 02:24:35 2002
+++ pmac-2.5/include/asm-s390x/pgtable.h	Wed Feb 13 19:27:40 2002
@@ -38,6 +38,7 @@
 #define flush_dcache_page(page)			do { } while (0)
 #define flush_icache_range(start, end)          do { } while (0)
 #define flush_icache_page(vma,pg)               do { } while (0)
+#define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
 
 /*
  * The S390 doesn't have any external MMU info: the kernel page
diff -urN linux-2.5/include/asm-sh/pgtable.h pmac-2.5/include/asm-sh/pgtable.h
--- linux-2.5/include/asm-sh/pgtable.h	Wed Feb  6 02:24:42 2002
+++ pmac-2.5/include/asm-sh/pgtable.h	Wed Feb 13 19:27:40 2002
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
diff -urN linux-2.5/include/asm-sparc/pgtable.h pmac-2.5/include/asm-sparc/pgtable.h
--- linux-2.5/include/asm-sparc/pgtable.h	Wed Feb  6 02:24:35 2002
+++ pmac-2.5/include/asm-sparc/pgtable.h	Wed Feb 13 19:27:40 2002
@@ -348,6 +348,7 @@
 extern unsigned int pg_iobits;
 
 #define flush_icache_page(vma, pg)      do { } while(0)
+#define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
 
 /* Certain architectures need to do special things when pte's
  * within a page table are directly modified.  Thus, the following
diff -urN linux-2.5/include/asm-sparc64/pgtable.h pmac-2.5/include/asm-sparc64/pgtable.h
--- linux-2.5/include/asm-sparc64/pgtable.h	Tue Feb 12 10:23:32 2002
+++ pmac-2.5/include/asm-sparc64/pgtable.h	Wed Feb 13 19:27:40 2002
@@ -277,6 +277,7 @@
 extern void update_mmu_cache(struct vm_area_struct *, unsigned long, pte_t);
 
 #define flush_icache_page(vma, pg)	do { } while(0)
+#define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
 
 /* Make a non-present pseudo-TTE. */
 extern inline pte_t mk_pte_io(unsigned long page, pgprot_t prot, int space)
diff -urN linux-2.5/kernel/ptrace.c pmac-2.5/kernel/ptrace.c
--- linux-2.5/kernel/ptrace.c	Wed Feb  6 02:23:21 2002
+++ pmac-2.5/kernel/ptrace.c	Wed Feb 13 19:31:09 2002
@@ -151,7 +151,7 @@
 		if (write) {
 			memcpy(maddr + offset, buf, bytes);
 			flush_page_to_ram(page);
-			flush_icache_page(vma, page);
+			flush_icache_user_range(vma, page, addr, bytes);
 		} else {
 			memcpy(buf, maddr + offset, bytes);
 			flush_page_to_ram(page);
