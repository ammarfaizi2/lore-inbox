Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264558AbUASLL5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 06:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264566AbUASLL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 06:11:57 -0500
Received: from ozlabs.org ([203.10.76.45]:11213 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264558AbUASLLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 06:11:06 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16395.47717.472261.52870@cargo.ozlabs.ibm.com>
Date: Mon, 19 Jan 2004 22:07:17 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, rth@twiddle.net,
       davem@redhat.com, davidm@napali.hpl.hp.com
Subject: [PATCH] sort exception tables
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch arranges for the exception tables to be sorted on most
architectures.  It sorts the main kernel exception table on startup
and the module exception tables when they get loaded.  The main table
is sorted reasonably early - just after kmem_cache_init - but that
could be moved even earlier if necessary.

There is now a lib/extable.c which includes the sort_extable()
function from arch/ppc/mm/extable.c and the search_extable() function
from arch/i386/mm/extable.c, which had been copied to many
architectures.  On many architectures, arch/$(ARCH)/mm/extable.c
became empty and so I have removed it.

There are four architectures which do things differently from i386:
alpha, ia64, sparc and sparc64.  Alpha and ia64 store the offset from
the offset from the exception table entry to the instruction, and
sparc and sparc64 have range entries in the table.  For those
architectures I have added empty sort_extable functions.  The
maintainers for those architectures can implement something better if
they care to.  As it is they are no worse off than before.

Although it is a moderately sizable patch, it ends up with a net
reduction of 377 lines in the size of the kernel source. :)

I have tested this on x86 and ppc with a module that uses __get_user
in an init function, deliberately laid out to get the exception table
out of order, and it works (whereas it oopsed without this patch).

Please apply.

Thanks,
Paul.

diff -urN linux-2.5/arch/alpha/mm/extable.c robin/arch/alpha/mm/extable.c
--- linux-2.5/arch/alpha/mm/extable.c	2003-01-07 05:11:27.000000000 +1100
+++ robin/arch/alpha/mm/extable.c	2004-01-18 22:33:50.000000000 +1100
@@ -6,6 +6,11 @@
 #include <linux/module.h>
 #include <asm/uaccess.h>
 
+void sort_extable(struct exception_table_entry *start,
+		  struct exception_table_entry *finish)
+{
+}
+
 const struct exception_table_entry *
 search_extable(const struct exception_table_entry *first,
 	       const struct exception_table_entry *last,
diff -urN linux-2.5/arch/arm/mm/extable.c robin/arch/arm/mm/extable.c
--- linux-2.5/arch/arm/mm/extable.c	2003-04-15 21:47:54.000000000 +1000
+++ robin/arch/arm/mm/extable.c	2004-01-18 22:34:23.000000000 +1100
@@ -4,27 +4,6 @@
 #include <linux/module.h>
 #include <asm/uaccess.h>
 
-const struct exception_table_entry *
-search_extable(const struct exception_table_entry *first,
-	       const struct exception_table_entry *last,
-	       unsigned long value)
-{
-        while (first <= last) {
-		const struct exception_table_entry *mid;
-		long diff;
-
-		mid = (last - first) / 2 + first;
-		diff = mid->insn - value;
-                if (diff == 0)
-                        return mid;
-                else if (diff < 0)
-                        first = mid+1;
-                else
-                        last = mid-1;
-        }
-        return NULL;
-}
-
 int fixup_exception(struct pt_regs *regs)
 {
 	const struct exception_table_entry *fixup;
diff -urN linux-2.5/arch/arm26/mm/extable.c robin/arch/arm26/mm/extable.c
--- linux-2.5/arch/arm26/mm/extable.c	2003-06-04 21:15:45.000000000 +1000
+++ robin/arch/arm26/mm/extable.c	2004-01-18 22:34:46.000000000 +1100
@@ -6,27 +6,6 @@
 #include <linux/module.h>
 #include <asm/uaccess.h>
 
-const struct exception_table_entry *
-search_extable(const struct exception_table_entry *first,
-               const struct exception_table_entry *last,
-               unsigned long value)
-{
-        while (first <= last) {
-                const struct exception_table_entry *mid;
-                long diff;
-
-                mid = (last - first) / 2 + first;
-                diff = mid->insn - value;
-                if (diff == 0)
-                        return mid;
-                else if (diff < 0)
-                        first = mid+1;
-                else
-                        last = mid-1;
-        }
-        return NULL;
-}
-
 int fixup_exception(struct pt_regs *regs)
 {
         const struct exception_table_entry *fixup;
diff -urN linux-2.5/arch/cris/mm/Makefile robin/arch/cris/mm/Makefile
--- linux-2.5/arch/cris/mm/Makefile	2003-07-11 10:41:24.000000000 +1000
+++ robin/arch/cris/mm/Makefile	2004-01-18 22:35:32.000000000 +1100
@@ -2,5 +2,5 @@
 # Makefile for the linux cris-specific parts of the memory manager.
 #
 
-obj-y	 := init.o fault.o tlb.o extable.o ioremap.o
+obj-y	 := init.o fault.o tlb.o ioremap.o
 
diff -urN linux-2.5/arch/cris/mm/extable.c robin/arch/cris/mm/extable.c
--- linux-2.5/arch/cris/mm/extable.c	Fri Jul 11 10:41:24 2003
+++ robin/arch/cris/mm/extable.c	Thu Jan 01 10:00:00 1970
@@ -1,48 +0,0 @@
-/*
- * linux/arch/cris/mm/extable.c
- *
- * $Log: extable.c,v $
- * Revision 1.4  2003/01/09 14:42:52  starvik
- * Merge of Linux 2.5.55
- *
- * Revision 1.3  2002/11/21 07:24:54  starvik
- * Made search_exception_table similar to implementation for other archs
- * (now compiles with CONFIG_MODULES)
- *
- * Revision 1.2  2002/11/18 07:36:55  starvik
- * Removed warning
- *
- * Revision 1.1  2001/12/17 13:59:27  bjornw
- * Initial revision
- *
- * Revision 1.3  2001/09/27 13:52:40  bjornw
- * Harmonize underscore-ness with other parts
- *
- *
- */
-
-#include <linux/config.h>
-#include <linux/module.h>
-#include <asm/uaccess.h>
-
-/* Simple binary search */
-const struct exception_table_entry *
-search_extable(const struct exception_table_entry *first,
-	       const struct exception_table_entry *last,
-	       unsigned long value)
-{
-        while (first <= last) {
-		const struct exception_table_entry *mid;
-		long diff;
-
-		mid = (last - first) / 2 + first;
-		diff = mid->insn - value;
-                if (diff == 0)
-                        return mid;
-                else if (diff < 0)
-                        first = mid+1;
-                else
-                        last = mid-1;
-        }
-        return NULL;
-}
diff -urN linux-2.5/arch/h8300/mm/Makefile robin/arch/h8300/mm/Makefile
--- linux-2.5/arch/h8300/mm/Makefile	2003-04-18 05:30:45.000000000 +1000
+++ robin/arch/h8300/mm/Makefile	2004-01-18 22:35:58.000000000 +1100
@@ -7,4 +7,4 @@
 #
 # Note 2! The CFLAGS definition is now in the main makefile...
 
-obj-y	 := init.o fault.o memory.o kmap.o extable.o
+obj-y	 := init.o fault.o memory.o kmap.o
diff -urN linux-2.5/arch/h8300/mm/extable.c robin/arch/h8300/mm/extable.c
--- linux-2.5/arch/h8300/mm/extable.c	Fri Apr 18 05:30:45 2003
+++ robin/arch/h8300/mm/extable.c	Thu Jan 01 10:00:00 1970
@@ -1,30 +0,0 @@
-/*
- * linux/arch/h8300/mm/extable.c
- */
-
-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/spinlock.h>
-#include <asm/uaccess.h>
-
-/* Simple binary search */
-const struct exception_table_entry *
-search_extable(const struct exception_table_entry *first,
-	       const struct exception_table_entry *last,
-	       unsigned long value)
-{
-        while (first <= last) {
-		const struct exception_table_entry *mid;
-		long diff;
-
-		mid = (last - first) / 2 + first;
-		diff = mid->insn - value;
-                if (diff == 0)
-                        return mid;
-                else if (diff < 0)
-                        first = mid+1;
-                else
-                        last = mid-1;
-        }
-        return NULL;
-}
diff -urN linux-2.5/arch/i386/mm/extable.c robin/arch/i386/mm/extable.c
--- linux-2.5/arch/i386/mm/extable.c	2003-01-11 14:29:47.000000000 +1100
+++ robin/arch/i386/mm/extable.c	2004-01-17 17:44:13.000000000 +1100
@@ -7,28 +7,6 @@
 #include <linux/spinlock.h>
 #include <asm/uaccess.h>
 
-/* Simple binary search */
-const struct exception_table_entry *
-search_extable(const struct exception_table_entry *first,
-	       const struct exception_table_entry *last,
-	       unsigned long value)
-{
-        while (first <= last) {
-		const struct exception_table_entry *mid;
-		long diff;
-
-		mid = (last - first) / 2 + first;
-		diff = mid->insn - value;
-                if (diff == 0)
-                        return mid;
-                else if (diff < 0)
-                        first = mid+1;
-                else
-                        last = mid-1;
-        }
-        return NULL;
-}
-
 int fixup_exception(struct pt_regs *regs)
 {
 	const struct exception_table_entry *fixup;
diff -urN linux-2.5/arch/ia64/mm/extable.c robin/arch/ia64/mm/extable.c
--- linux-2.5/arch/ia64/mm/extable.c	2003-02-08 10:58:08.000000000 +1100
+++ robin/arch/ia64/mm/extable.c	2004-01-18 22:36:30.000000000 +1100
@@ -10,6 +10,11 @@
 #include <asm/uaccess.h>
 #include <asm/module.h>
 
+void sort_extable(struct exception_table_entry *start,
+		  struct exception_table_entry *finish)
+{
+}
+
 const struct exception_table_entry *
 search_extable (const struct exception_table_entry *first,
 		const struct exception_table_entry *last,
diff -urN linux-2.5/arch/m68k/mm/Makefile robin/arch/m68k/mm/Makefile
--- linux-2.5/arch/m68k/mm/Makefile	2002-12-14 23:38:56.000000000 +1100
+++ robin/arch/m68k/mm/Makefile	2004-01-18 22:36:54.000000000 +1100
@@ -2,7 +2,7 @@
 # Makefile for the linux m68k-specific parts of the memory manager.
 #
 
-obj-y		:= init.o fault.o extable.o hwtest.o
+obj-y		:= init.o fault.o hwtest.o
 
 ifndef CONFIG_SUN3
 obj-y		+= kmap.o memory.o motorola.o
diff -urN linux-2.5/arch/m68k/mm/extable.c robin/arch/m68k/mm/extable.c
--- linux-2.5/arch/m68k/mm/extable.c	Fri Jan 17 07:59:52 2003
+++ robin/arch/m68k/mm/extable.c	Thu Jan 01 10:00:00 1970
@@ -1,33 +0,0 @@
-/*
- * linux/arch/m68k/mm/extable.c
- */
-
-#include <linux/config.h>
-#include <linux/module.h>
-#include <asm/uaccess.h>
-
-extern const struct exception_table_entry __start___ex_table[];
-extern const struct exception_table_entry __stop___ex_table[];
-
-/* Simple binary search */
-const struct exception_table_entry *
-search_extable(const struct exception_table_entry *first,
-	       const struct exception_table_entry *last,
-	       unsigned long value)
-{
-        while (first <= last) {
-		const struct exception_table_entry *mid;
-		long diff;
-
-		mid = (last - first) / 2 + first;
-		diff = value - mid->insn;
-		if (diff >= 0 && diff <= 2)
-			return mid;
-		else if (diff > 0)
-			first = mid+1;
-		else
-			last = mid-1;
-	}
-	return NULL;
-}
-
diff -urN linux-2.5/arch/m68knommu/mm/Makefile robin/arch/m68knommu/mm/Makefile
--- linux-2.5/arch/m68knommu/mm/Makefile	2003-02-19 18:57:08.000000000 +1100
+++ robin/arch/m68knommu/mm/Makefile	2004-01-18 22:37:17.000000000 +1100
@@ -2,4 +2,4 @@
 # Makefile for the linux m68knommu specific parts of the memory manager.
 #
 
-obj-y += init.o fault.o memory.o kmap.o extable.o
+obj-y += init.o fault.o memory.o kmap.o
diff -urN linux-2.5/arch/m68knommu/mm/extable.c robin/arch/m68knommu/mm/extable.c
--- linux-2.5/arch/m68knommu/mm/extable.c	Tue Feb 18 21:27:39 2003
+++ robin/arch/m68knommu/mm/extable.c	Thu Jan 01 10:00:00 1970
@@ -1,30 +0,0 @@
-/*
- * linux/arch/m68knommu/mm/extable.c
- */
-
-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/spinlock.h>
-#include <asm/uaccess.h>
-
-/* Simple binary search */
-const struct exception_table_entry *
-search_extable(const struct exception_table_entry *first,
-	       const struct exception_table_entry *last,
-	       unsigned long value)
-{
-        while (first <= last) {
-		const struct exception_table_entry *mid;
-		long diff;
-
-		mid = (last - first) / 2 + first;
-		diff = mid->insn - value;
-                if (diff == 0)
-                        return mid;
-                else if (diff < 0)
-                        first = mid+1;
-                else
-                        last = mid-1;
-        }
-        return NULL;
-}
diff -urN linux-2.5/arch/mips/mm/Makefile robin/arch/mips/mm/Makefile
--- linux-2.5/arch/mips/mm/Makefile	2003-08-02 09:37:29.000000000 +1000
+++ robin/arch/mips/mm/Makefile	2004-01-18 22:37:41.000000000 +1100
@@ -2,7 +2,7 @@
 # Makefile for the Linux/MIPS-specific parts of the memory manager.
 #
 
-obj-y				+= cache.o extable.o fault.o loadmmu.o pgtable.o
+obj-y				+= cache.o fault.o loadmmu.o pgtable.o
 
 obj-$(CONFIG_MIPS32)		+= ioremap.o pgtable-32.o
 obj-$(CONFIG_MIPS64)		+= pgtable-64.o
diff -urN linux-2.5/arch/mips/mm/extable.c robin/arch/mips/mm/extable.c
--- linux-2.5/arch/mips/mm/extable.c	Fri Jun 27 08:02:34 2003
+++ robin/arch/mips/mm/extable.c	Thu Jan 01 10:00:00 1970
@@ -1,30 +0,0 @@
-/*
- * linux/arch/i386/mm/extable.c
- */
-
-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/spinlock.h>
-#include <asm/uaccess.h>
-
-/* Simple binary search */
-const struct exception_table_entry *
-search_extable(const struct exception_table_entry *first,
-	       const struct exception_table_entry *last,
-	       unsigned long value)
-{
-        while (first <= last) {
-		const struct exception_table_entry *mid;
-		long diff;
-
-		mid = (last - first) / 2 + first;
-		diff = mid->insn - value;
-                if (diff == 0)
-                        return mid;
-                else if (diff < 0)
-                        first = mid+1;
-                else
-                        last = mid-1;
-        }
-        return NULL;
-}
diff -urN linux-2.5/arch/parisc/mm/Makefile robin/arch/parisc/mm/Makefile
--- linux-2.5/arch/parisc/mm/Makefile	2002-11-03 07:27:46.000000000 +1100
+++ robin/arch/parisc/mm/Makefile	2004-01-18 22:39:33.000000000 +1100
@@ -2,4 +2,4 @@
 # Makefile for arch/parisc/mm
 #
 
-obj-y	 := init.o fault.o extable.o ioremap.o
+obj-y	 := init.o fault.o ioremap.o
diff -urN linux-2.5/arch/parisc/mm/extable.c robin/arch/parisc/mm/extable.c
--- linux-2.5/arch/parisc/mm/extable.c	Sun Jan 12 19:55:41 2003
+++ robin/arch/parisc/mm/extable.c	Thu Jan 01 10:00:00 1970
@@ -1,37 +0,0 @@
-/*
- * Kernel exception handling table support.  Derived from arch/i386/mm/extable.c.
- *
- * Copyright (C) 2000 Hewlett-Packard Co
- * Copyright (C) 2000 John Marvin (jsm@fc.hp.com)
- */
-
-#include <asm/uaccess.h>
-
-const struct exception_table_entry *
-search_extable(const struct exception_table_entry *first,
-	       const struct exception_table_entry *last,
-	       unsigned long addr)
-{
-	/* Abort early if the search value is out of range.  */
-
-	if ((addr < first->addr) || (addr > last->addr))
-		return 0;
-
-        while (first <= last) {
-		const struct exception_table_entry *mid;
-		long diff;
-
-		mid = first + ((last - first)/2);
-		diff = mid->addr - addr;
-
-                if (diff == 0)
-                        return mid;
-                else if (diff < 0)
-                        first = mid+1;
-                else
-                        last = mid-1;
-        }
-
-        return 0;
-}
-
diff -urN linux-2.5/arch/ppc/kernel/module.c robin/arch/ppc/kernel/module.c
--- linux-2.5/arch/ppc/kernel/module.c	2003-09-24 10:55:53.000000000 +1000
+++ robin/arch/ppc/kernel/module.c	2004-01-18 22:40:47.000000000 +1100
@@ -265,7 +265,6 @@
 	return 0;
 }
 
-/* FIXME: Sort exception table --RR */
 int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs,
 		    struct module *me)
diff -urN linux-2.5/arch/ppc/mm/Makefile robin/arch/ppc/mm/Makefile
--- linux-2.5/arch/ppc/mm/Makefile	2003-09-04 07:57:13.000000000 +1000
+++ robin/arch/ppc/mm/Makefile	2004-01-18 15:48:03.000000000 +1100
@@ -6,7 +6,7 @@
 EXTRA_AFLAGS		:= -Wa,-mppc64bridge
 endif
 
-obj-y				:= fault.o init.o mem_pieces.o extable.o \
+obj-y				:= fault.o init.o mem_pieces.o \
 					mmu_context.o pgtable.o
 
 obj-$(CONFIG_PPC_STD_MMU)	+= hashtable.o ppc_mmu.o tlb.o
diff -urN linux-2.5/arch/ppc/mm/extable.c robin/arch/ppc/mm/extable.c
--- linux-2.5/arch/ppc/mm/extable.c	Fri Jan 03 18:55:27 2003
+++ robin/arch/ppc/mm/extable.c	Thu Jan 01 10:00:00 1970
@@ -1,70 +0,0 @@
-/*
- * arch/ppc/mm/extable.c
- *
- * from arch/i386/mm/extable.c
- */
-
-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <asm/uaccess.h>
-
-extern struct exception_table_entry __start___ex_table[];
-extern struct exception_table_entry __stop___ex_table[];
-
-/*
- * The exception table needs to be sorted because we use the macros
- * which put things into the exception table in a variety of segments
- * such as the prep, pmac, chrp, etc. segments as well as the init
- * segment and the main kernel text segment.
- */
-static inline void
-sort_ex_table(struct exception_table_entry *start,
-	      struct exception_table_entry *finish)
-{
-	struct exception_table_entry el, *p, *q;
-
-	/* insertion sort */
-	for (p = start + 1; p < finish; ++p) {
-		/* start .. p-1 is sorted */
-		if (p[0].insn < p[-1].insn) {
-			/* move element p down to its right place */
-			el = *p;
-			q = p;
-			do {
-				/* el comes before q[-1], move q[-1] up one */
-				q[0] = q[-1];
-				--q;
-			} while (q > start && el.insn < q[-1].insn);
-			*q = el;
-		}
-	}
-}
-
-void __init
-sort_exception_table(void)
-{
-	sort_ex_table(__start___ex_table, __stop___ex_table);
-}
-
-/* Simple binary search */
-const struct exception_table_entry *
-search_extable(const struct exception_table_entry *first,
-	       const struct exception_table_entry *last,
-	       unsigned long value)
-{
-        while (first <= last) {
-		const struct exception_table_entry *mid;
-		long diff;
-
-		mid = (last - first) / 2 + first;
-		diff = mid->insn - value;
-                if (diff == 0)
-                        return mid;
-                else if (diff < 0)
-                        first = mid+1;
-                else
-                        last = mid-1;
-        }
-	return NULL;
-}
diff -urN linux-2.5/arch/ppc64/kernel/module.c robin/arch/ppc64/kernel/module.c
--- linux-2.5/arch/ppc64/kernel/module.c	2003-06-15 12:12:49.000000000 +1000
+++ robin/arch/ppc64/kernel/module.c	2004-01-18 22:40:35.000000000 +1100
@@ -404,10 +404,6 @@
 	 */
 	list_add(&me->arch.bug_list, &module_bug_list);
 
-	sort_ex_table((struct exception_table_entry *)me->extable,
-		      (struct exception_table_entry *)me->extable +
-				me->num_exentries);
-
 	return 0;
 }
 
diff -urN linux-2.5/arch/ppc64/kernel/setup.c robin/arch/ppc64/kernel/setup.c
--- linux-2.5/arch/ppc64/kernel/setup.c	2003-10-09 10:07:18.000000000 +1000
+++ robin/arch/ppc64/kernel/setup.c	2004-01-18 22:40:20.000000000 +1100
@@ -486,7 +486,6 @@
 }	
 
 extern void (*calibrate_delay)(void);
-extern void sort_exception_table(void);
 
 /*
  * Called into from start_kernel, after lock_kernel has been called.
@@ -534,7 +533,6 @@
 	ppc_md.setup_arch();
 
 	paging_init();
-	sort_exception_table();
 	ppc64_boot_msg(0x15, "Setup Done");
 }
 
diff -urN linux-2.5/arch/ppc64/mm/Makefile robin/arch/ppc64/mm/Makefile
--- linux-2.5/arch/ppc64/mm/Makefile	2003-09-11 07:35:23.000000000 +1000
+++ robin/arch/ppc64/mm/Makefile	2004-01-18 22:41:25.000000000 +1100
@@ -4,6 +4,6 @@
 
 EXTRA_CFLAGS += -mno-minimal-toc
 
-obj-y := fault.o init.o extable.o imalloc.o
+obj-y := fault.o init.o imalloc.o
 obj-$(CONFIG_DISCONTIGMEM) += numa.o
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
diff -urN linux-2.5/arch/ppc64/mm/extable.c robin/arch/ppc64/mm/extable.c
--- linux-2.5/arch/ppc64/mm/extable.c	Sun Mar 16 22:35:03 2003
+++ robin/arch/ppc64/mm/extable.c	Thu Jan 01 10:00:00 1970
@@ -1,74 +0,0 @@
-/*
- * arch/ppc64/mm/extable.c
- *
- * from arch/i386/mm/extable.c
- *
- *      This program is free software; you can redistribute it and/or
- *      modify it under the terms of the GNU General Public License
- *      as published by the Free Software Foundation; either version
- *      2 of the License, or (at your option) any later version.
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <asm/uaccess.h>
-
-extern struct exception_table_entry __start___ex_table[];
-extern struct exception_table_entry __stop___ex_table[];
-
-/*
- * The exception table needs to be sorted because we use the macros
- * which put things into the exception table in a variety of segments
- * as well as the init segment and the main kernel text segment.
- *
- * Also used for modules.
- */
-void __init_or_module sort_ex_table(struct exception_table_entry *start,
-				    struct exception_table_entry *finish)
-{
-	struct exception_table_entry el, *p, *q;
-
-	/* insertion sort */
-	for (p = start + 1; p < finish; ++p) {
-		/* start .. p-1 is sorted */
-		if (p[0].insn < p[-1].insn) {
-			/* move element p down to its right place */
-			el = *p;
-			q = p;
-			do {
-				/* el comes before q[-1], move q[-1] up one */
-				q[0] = q[-1];
-				--q;
-			} while (q > start && el.insn < q[-1].insn);
-			*q = el;
-		}
-	}
-}
-
-void __init
-sort_exception_table(void)
-{
-	sort_ex_table(__start___ex_table, __stop___ex_table);
-}
-
-/* Simple binary search */
-const struct exception_table_entry *
-search_extable(const struct exception_table_entry *first,
-	       const struct exception_table_entry *last,
-	       unsigned long value)
-{
-	while (first <= last) {
-		const struct exception_table_entry *mid;
-		long diff;
-
-		mid = (last - first) / 2 + first;
-		diff = mid->insn - value;
-		if (diff == 0)
-			return mid;
-		else if (diff < 0)
-			first = mid+1;
-		else
-			last = mid-1;
-	}
-	return NULL;
-}
diff -urN linux-2.5/arch/s390/mm/Makefile robin/arch/s390/mm/Makefile
--- linux-2.5/arch/s390/mm/Makefile	2002-12-16 07:03:39.000000000 +1100
+++ robin/arch/s390/mm/Makefile	2004-01-18 22:41:27.000000000 +1100
@@ -2,4 +2,4 @@
 # Makefile for the linux s390-specific parts of the memory manager.
 #
 
-obj-y	 := init.o fault.o ioremap.o extable.o
+obj-y	 := init.o fault.o ioremap.o
diff -urN linux-2.5/arch/s390/mm/extable.c robin/arch/s390/mm/extable.c
--- linux-2.5/arch/s390/mm/extable.c	Tue Feb 25 09:45:46 2003
+++ robin/arch/s390/mm/extable.c	Thu Jan 01 10:00:00 1970
@@ -1,34 +0,0 @@
-/*
- *  arch/s390/mm/extable.c
- *
- *  S390 version
- *
- *  identical to arch/i386/mm/extable.c
- */
-
-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/spinlock.h>
-#include <asm/uaccess.h>
-
-/* Simple binary search */
-const struct exception_table_entry *
-search_extable(const struct exception_table_entry *first,
-	       const struct exception_table_entry *last,
-	       unsigned long value)
-{
-	while (first <= last) {
-		const struct exception_table_entry *mid;
-		long diff;
-
-		mid = (last - first) / 2 + first;
-		diff = mid->insn - value;
-		if (diff == 0)
-			return mid;
-		else if (diff < 0)
-			first = mid+1;
-		else
-			last = mid-1;
-	}
-	return NULL;
-}
diff -urN linux-2.5/arch/sh/mm/extable.c robin/arch/sh/mm/extable.c
--- linux-2.5/arch/sh/mm/extable.c	2003-07-03 09:52:33.000000000 +1000
+++ robin/arch/sh/mm/extable.c	2004-01-18 22:41:41.000000000 +1100
@@ -9,29 +9,6 @@
 #include <linux/module.h>
 #include <asm/uaccess.h>
 
-/* Simple binary search */
-const struct exception_table_entry *
-search_extable(const struct exception_table_entry *first,
-		 const struct exception_table_entry *last,
-		 unsigned long value)
-{
-        while (first <= last) {
-		const struct exception_table_entry *mid;
-		long diff;
-
-		mid = (last - first) / 2 + first;
-		diff = mid->insn - value;
-                if (diff == 0)
-                        return mid;
-                else if (diff < 0)
-                        first = mid+1;
-                else
-                        last = mid-1;
-        }
-
-        return NULL;
-}
-
 int fixup_exception(struct pt_regs *regs)
 {
 	const struct exception_table_entry *fixup;
diff -urN linux-2.5/arch/sparc/mm/extable.c robin/arch/sparc/mm/extable.c
--- linux-2.5/arch/sparc/mm/extable.c	2003-01-10 18:19:46.000000000 +1100
+++ robin/arch/sparc/mm/extable.c	2004-01-18 22:42:08.000000000 +1100
@@ -6,6 +6,11 @@
 #include <linux/module.h>
 #include <asm/uaccess.h>
 
+void sort_extable(struct exception_table_entry *start,
+		  struct exception_table_entry *finish)
+{
+}
+
 /* Caller knows they are in a range if ret->fixup == 0 */
 const struct exception_table_entry *
 search_extable(const struct exception_table_entry *start,
diff -urN linux-2.5/arch/sparc64/mm/extable.c robin/arch/sparc64/mm/extable.c
--- linux-2.5/arch/sparc64/mm/extable.c	2003-01-06 16:46:46.000000000 +1100
+++ robin/arch/sparc64/mm/extable.c	2004-01-18 22:42:27.000000000 +1100
@@ -9,6 +9,11 @@
 extern const struct exception_table_entry __start___ex_table[];
 extern const struct exception_table_entry __stop___ex_table[];
 
+void sort_extable(struct exception_table_entry *start,
+		  struct exception_table_entry *finish)
+{
+}
+
 /* Caller knows they are in a range if ret->fixup == 0 */
 const struct exception_table_entry *
 search_extable(const struct exception_table_entry *start,
diff -urN linux-2.5/arch/x86_64/mm/extable.c robin/arch/x86_64/mm/extable.c
--- linux-2.5/arch/x86_64/mm/extable.c	2003-10-28 19:50:31.000000000 +1100
+++ robin/arch/x86_64/mm/extable.c	2004-01-18 22:53:14.000000000 +1100
@@ -36,10 +36,9 @@
 
 /* When an exception handler is in an non standard section (like __init)
    the fixup table can end up unordered. Fix that here. */
-static __init int check_extable(void)
+void sort_extable(struct exception_table_entry *start,
+		  struct exception_table_entry *finish)
 {
-	extern struct exception_table_entry __start___ex_table[];
-	extern struct exception_table_entry  __stop___ex_table[];
 	struct exception_table_entry *e;
 	int change;
 
@@ -47,7 +46,7 @@
 	   best (and simplest) sort algorithm. */
 	do {
 		change = 0;
-		for (e = __start___ex_table+1; e < __stop___ex_table; e++) {
+		for (e = start+1; e < finish; e++) {
 			if (e->insn < e[-1].insn) {
 				struct exception_table_entry tmp = e[-1];
 				e[-1] = e[0];
@@ -58,4 +57,3 @@
 	} while (change != 0);
 	return 0;
 }
-core_initcall(check_extable);
diff -urN linux-2.5/include/asm-ppc/uaccess.h robin/include/asm-ppc/uaccess.h
--- linux-2.5/include/asm-ppc/uaccess.h	2003-10-07 07:07:26.000000000 +1000
+++ robin/include/asm-ppc/uaccess.h	2004-01-18 15:43:27.000000000 +1100
@@ -60,8 +60,6 @@
 	unsigned long insn, fixup;
 };
 
-extern void sort_exception_table(void);
-
 /*
  * These are the main single-value transfer routines.  They automatically
  * use the right size if we just have the right pointer type.
diff -urN linux-2.5/include/asm-ppc64/uaccess.h robin/include/asm-ppc64/uaccess.h
--- linux-2.5/include/asm-ppc64/uaccess.h	2003-10-17 06:01:35.000000000 +1000
+++ robin/include/asm-ppc64/uaccess.h	2004-01-18 15:43:38.000000000 +1100
@@ -82,7 +82,6 @@
 
 /* Returns 0 if exception not found and fixup otherwise.  */
 extern unsigned long search_exception_table(unsigned long);
-extern void sort_exception_table(void);
 
 /*
  * These are the main single-value transfer routines.  They automatically
diff -urN linux-2.5/include/linux/module.h robin/include/linux/module.h
--- linux-2.5/include/linux/module.h	2003-07-20 23:56:33.000000000 +1000
+++ robin/include/linux/module.h	2004-01-18 17:37:38.000000000 +1100
@@ -54,6 +54,9 @@
 search_extable(const struct exception_table_entry *first,
 	       const struct exception_table_entry *last,
 	       unsigned long value);
+void sort_extable(struct exception_table_entry *start,
+		  struct exception_table_entry *finish);
+void sort_main_extable(void);
 
 #ifdef MODULE
 #define ___module_cat(a,b) __mod_ ## a ## b
diff -urN linux-2.5/init/main.c robin/init/main.c
--- linux-2.5/init/main.c	2004-01-03 11:27:09.000000000 +1100
+++ robin/init/main.c	2004-01-18 15:48:56.000000000 +1100
@@ -435,6 +435,7 @@
 	page_address_init();
 	mem_init();
 	kmem_cache_init();
+	sort_main_extable();
 	if (late_time_init)
 		late_time_init();
 	calibrate_delay();
diff -urN linux-2.5/kernel/extable.c robin/kernel/extable.c
--- linux-2.5/kernel/extable.c	2003-07-20 23:56:33.000000000 +1000
+++ robin/kernel/extable.c	2004-01-18 17:36:39.000000000 +1100
@@ -16,11 +16,18 @@
     Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */
 #include <linux/module.h>
+#include <linux/init.h>
 #include <asm/uaccess.h>
 #include <asm/sections.h>
 
-extern const struct exception_table_entry __start___ex_table[];
-extern const struct exception_table_entry __stop___ex_table[];
+extern struct exception_table_entry __start___ex_table[];
+extern struct exception_table_entry __stop___ex_table[];
+
+/* Sort the kernel's built-in exception table */
+void __init sort_main_extable(void)
+{
+	sort_extable(__start___ex_table, __stop___ex_table);
+}
 
 /* Given an address, look for it in the exception tables. */
 const struct exception_table_entry *search_exception_tables(unsigned long addr)
diff -urN linux-2.5/kernel/module.c robin/kernel/module.c
--- linux-2.5/kernel/module.c	2004-01-14 07:50:28.000000000 +1100
+++ robin/kernel/module.c	2004-01-19 17:12:20.000000000 +1100
@@ -1395,6 +1395,7 @@
 	struct module *mod;
 	long err = 0;
 	void *percpu = NULL, *ptr = NULL; /* Stops spurious gcc warning */
+	struct exception_table_entry *extable;
 
 	DEBUGP("load_module: umod=%p, len=%lu, uargs=%p\n",
 	       umod, len, uargs);
@@ -1611,10 +1612,6 @@
 	}
 #endif
 
-  	/* Set up exception table */
-	mod->num_exentries = sechdrs[exindex].sh_size / sizeof(*mod->extable);
-	mod->extable = (void *)sechdrs[exindex].sh_addr;
-
 	/* Now do relocations. */
 	for (i = 1; i < hdr->e_shnum; i++) {
 		const char *strtab = (char *)sechdrs[strindex].sh_addr;
@@ -1637,6 +1634,11 @@
 			goto cleanup;
 	}
 
+  	/* Set up and sort exception table */
+	mod->num_exentries = sechdrs[exindex].sh_size / sizeof(*mod->extable);
+	mod->extable = extable = (void *)sechdrs[exindex].sh_addr;
+	sort_extable(extable, extable + mod->num_exentries);
+
 	/* Finally, copy percpu area over. */
 	percpu_modcopy(mod->percpu, (void *)sechdrs[pcpuindex].sh_addr,
 		       sechdrs[pcpuindex].sh_size);
diff -urN linux-2.5/lib/Makefile robin/lib/Makefile
--- linux-2.5/lib/Makefile	2003-12-31 09:39:13.000000000 +1100
+++ robin/lib/Makefile	2004-01-17 13:10:06.000000000 +1100
@@ -5,7 +5,7 @@
 
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
-	 kobject.o idr.o div64.o parser.o int_sqrt.o mask.o
+	 kobject.o idr.o div64.o parser.o int_sqrt.o mask.o extable.o
 
 lib-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
diff -urN linux-2.5/lib/extable.c robin/lib/extable.c
--- linux-2.5/lib/extable.c	Thu Jan 01 10:00:00 1970
+++ robin/lib/extable.c	Sun Jan 18 15:46:44 2004
@@ -0,0 +1,75 @@
+/*
+ * lib/extable.c
+ * Derived from arch/ppc/mm/extable.c and arch/i386/mm/extable.c.
+ *
+ * Copyright (C) 2004 Paul Mackerras, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <asm/uaccess.h>
+
+extern struct exception_table_entry __start___ex_table[];
+extern struct exception_table_entry __stop___ex_table[];
+
+/*
+ * The exception table needs to be sorted so that the binary
+ * search that we use to find entries in it works properly.
+ * This is used both for the kernel exception table and for
+ * the exception tables of modules that get loaded.
+ */
+void sort_extable(struct exception_table_entry *start,
+		  struct exception_table_entry *finish)
+{
+	struct exception_table_entry el, *p, *q;
+
+	/* insertion sort */
+	for (p = start + 1; p < finish; ++p) {
+		/* start .. p-1 is sorted */
+		if (p[0].insn < p[-1].insn) {
+			/* move element p down to its right place */
+			el = *p;
+			q = p;
+			do {
+				/* el comes before q[-1], move q[-1] up one */
+				q[0] = q[-1];
+				--q;
+			} while (q > start && el.insn < q[-1].insn);
+			*q = el;
+		}
+	}
+}
+
+/*
+ * Search one exception table for an entry corresponding to the
+ * given instruction address, and return the address of the entry,
+ * or NULL if none is found.
+ * We use a binary search, and thus we assume that the table is
+ * already sorted.
+ */
+const struct exception_table_entry *
+search_extable(const struct exception_table_entry *first,
+	       const struct exception_table_entry *last,
+	       unsigned long value)
+{
+        while (first <= last) {
+		const struct exception_table_entry *mid;
+		long diff;
+
+		mid = (last - first) / 2 + first;
+		diff = mid->insn - value;
+                if (diff == 0)
+                        return mid;
+                else if (diff < 0)
+                        first = mid+1;
+                else
+                        last = mid-1;
+        }
+        return NULL;
+}
