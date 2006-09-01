Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751490AbWIALLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWIALLm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 07:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWIALLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 07:11:42 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:18102 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751486AbWIALLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 07:11:37 -0400
Date: Fri, 1 Sep 2006 13:11:33 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com,
       rhim@cc.gateh.edu
Subject: [patch 9/9] Guest page hinting: full s390 support.
Message-ID: <20060901111133.GJ15684@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>
From: Hubertus Franke <frankeh@watson.ibm.com>
From: Himanshu Raj <rhim@cc.gatech.edu>

[patch 9/9] Guest page hinting: full s390 support.

s390 uses the milli-coded ESSA instruction to set the page state. The
page state is formed by four guest page states called block usage states
and three host page states called block content states.

The guest states are:
 - stable (S): there is essential content in the page
 - unused (U): there is no useful content and any access to the page will
   cause an addressing exception
 - volatile (V): there is useful content in the page. The host system is
   allowed to discard the content anytime, but has to deliver a discard
   fault with the absolute address of the page if the guest tries to
   access it.
 - potential volatile (P): the page has useful content. The host system
   is allowed to discard the content after it has checked the dirty bit
   of the page. It has to deliver a discard fault with the absolute
   address of the page if the guest tries to access it.

The host states are:
 - resident: the page is present in real memory.
 - preserved: the page is not present in real memory but the content is
   preserved elsewhere by the machine, e.g. on the paging device.
 - zero: the page is not present in real memory. The content of the page
   is logically-zero.

There are 12 combinations of guest and host state, currently only 8 are
valid page states:
 Sr: a stable, resident page.
 Sp: a stable, preserved page.
 Sz: a stable, logically zero page. A page filled with zeroes will be
     allocated on first access.
 Ur: an unused but resident page. The host could make it Uz anytime but
     it doesn't have to.
 Uz: an unused, logically zero page.
 Vr: a volatile, resident page. The guest can access it normally.
 Vz: a volatile, logically zero page. This is a discarded page. The host
     will deliver a discard fault for any access to the page.
 Pr: a potential volatile, resident page. The guest can access it normally.

The remaining 4 combinations can't occur:
 Up: an unused, preserved page. If the host tries to get rid of a Ur page
     it will remove it without writing the page content to disk and set
     the page to Uz.
 Vp: a volatile, preserved page. If the host picks a Vp page for eviction
     it will discard it and set the page state to Vz.
 Pp: a potential volatile, preserved page. There are two cases for page out:
     1) the page is dirty then the host will preserved the page and set it
     to Sp or 2) the page is clean then the host will discard it and set the
     page state to Vz.
 Pz: a potential volatile, logically zero page. The host system will always
     use Vz instead of Pz.

The state transitions (a diagram would be nicer but that is too hard
to do in ascii art...):
{Ur,Sr,Vr,Pr}: a resident page will change its block usage state if the
     guest requests it with page_set_{unused,stable,volatile}.
{Uz,Sz,Vz}: a logically zero page will change its block usage state if the
     guest requests it with page_set_{unused,stable,volatile}. The
     guest can't create the Pz state, the state will be Vz instead.
Ur -> Uz: the host system can remove an unused, resident page from memory
Sz -> Sr: on first access a stable, logically zero page will become resident
Sr -> Sp: the host system can swap a stable page to disk
Sp -> Sr: a guest access to a Sp page forces the host to retrieve it
Vr -> Vz: the host can discard a volatile page
Sp -> Uz: a page preserved by the host will be removed if the guest sets 
     the block usage state to unused.
Sp -> Vz: a page preserved by the host will be discarded if the guest sets
     the block usage state to volatile.
Pr -> Sp: the host can move a page from Pr to Sp if it discovers that the
     page is dirty while trying to discard the page. Instead it is swapped
     to disk. 
Pr -> Vz: the host can discard a Pr page. The Pz state is replaced by the
     Vz state.

For potential volatile pages there is one more pitfall. The transfer of
the hardware dirty bit to the software dirty bit needs to make sure that
the page gets into the stable state before the hardware dirty bit is
cleared. The primitive page_test_and_clear_dirty is split into
page_test_dirty and page_clear_dirty to be able to place a
page_make_stable call between them.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/Kconfig              |    5 ++
 arch/s390/kernel/traps.c       |    4 ++
 arch/s390/mm/fault.c           |   73 +++++++++++++++++++++++++++++++++++++++++
 include/asm-generic/pgtable.h  |   11 +++++-
 include/asm-s390/page-states.h |   39 +++++++++++++++++++++
 include/asm-s390/pgtable.h     |   17 ++++++---
 include/linux/page-flags.h     |    8 ++--
 mm/rmap.c                      |   12 ++++++
 8 files changed, 156 insertions(+), 13 deletions(-)

diff -urpN linux-2.6/arch/s390/Kconfig linux-2.6-patched/arch/s390/Kconfig
--- linux-2.6/arch/s390/Kconfig	2006-09-01 12:49:36.000000000 +0200
+++ linux-2.6-patched/arch/s390/Kconfig	2006-09-01 12:50:25.000000000 +0200
@@ -463,8 +463,13 @@ config KEXEC
 	  current kernel, and to start another kernel.  It is like a reboot
 	  but is independent of hardware/microcode support.
 
+config PAGE_DISCARD_LIST
+	bool
+	default n
+
 config PAGE_STATES
 	bool "Enable support for guest page hinting."
+	select PAGE_DISCARD_LIST
 
 endmenu
 
diff -urpN linux-2.6/arch/s390/kernel/traps.c linux-2.6-patched/arch/s390/kernel/traps.c
--- linux-2.6/arch/s390/kernel/traps.c	2006-09-01 12:49:25.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/traps.c	2006-09-01 12:50:25.000000000 +0200
@@ -65,6 +65,7 @@ extern void pfault_interrupt(struct pt_r
 static ext_int_info_t ext_int_pfault;
 #endif
 extern pgm_check_handler_t do_monitor_call;
+extern pgm_check_handler_t do_discard_fault;
 
 #define stack_pointer ({ void **sp; asm("la %0,0(15)" : "=&d" (sp)); sp; })
 
@@ -734,6 +735,9 @@ void __init trap_init(void)
         pgm_check_table[0x1C] = &space_switch_exception;
         pgm_check_table[0x1D] = &hfp_sqrt_exception;
 	pgm_check_table[0x40] = &do_monitor_call;
+#if defined(CONFIG_PAGE_STATES)
+	pgm_check_table[0x1a] = &do_discard_fault;
+#endif
 
 	if (MACHINE_IS_VM) {
 #ifdef CONFIG_PFAULT
diff -urpN linux-2.6/arch/s390/mm/fault.c linux-2.6-patched/arch/s390/mm/fault.c
--- linux-2.6/arch/s390/mm/fault.c	2006-09-01 12:49:25.000000000 +0200
+++ linux-2.6-patched/arch/s390/mm/fault.c	2006-09-01 12:50:25.000000000 +0200
@@ -19,6 +19,7 @@
 #include <linux/ptrace.h>
 #include <linux/mman.h>
 #include <linux/mm.h>
+#include <linux/pagemap.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
@@ -31,6 +32,7 @@
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/kdebug.h>
+#include <asm/io.h>
 
 #ifndef CONFIG_64BIT
 #define __FAIL_ADDR_MASK 0x7ffff000
@@ -515,3 +517,74 @@ pfault_interrupt(struct pt_regs *regs, _
 }
 #endif
 
+#if defined(CONFIG_PAGE_STATES)
+
+static int __init nocmm2(char *str)
+{
+	machine_flags &= ~MACHINE_HAS_ESSA;
+	return 1;
+}
+
+__setup("nocmm2", nocmm2);
+
+static inline void fixup_user_copy(struct pt_regs *regs,
+				   unsigned long address, unsigned short rx)
+{
+	const struct exception_table_entry *fixup;
+	unsigned long kaddr;
+
+	kaddr = (regs->gprs[rx >> 12] + (rx & 0xfff)) & __FAIL_ADDR_MASK;
+	if (virt_to_phys((void *) kaddr) != address)
+		return;
+
+	fixup = search_exception_tables(regs->psw.addr & PSW_ADDR_INSN);
+	if (fixup)
+		regs->psw.addr = fixup->fixup | PSW_ADDR_AMODE;
+	else
+		die("discard fault", regs, SIGSEGV);
+}
+
+/*
+ * Discarded pages with a page_count() of zero are placed on
+ * the page_discarded_list until all cpus have been at
+ * least once in enabled code. That closes the race of page
+ * free vs. discard faults.
+ */
+void do_discard_fault(struct pt_regs *regs, unsigned long error_code)
+{
+	unsigned long address;
+	struct page *page;
+
+	/*
+	 * get the real address that caused the block validity
+	 * exception.
+	 */
+	address = S390_lowcore.trans_exc_code & __FAIL_ADDR_MASK;
+	page = pfn_to_page(address >> PAGE_SHIFT);
+
+	/*
+	 * Check for the special case of a discard fault in
+	 * copy_{from,to}_user. User copy is done using the
+	 * two special instructions mvcp/mvcs.
+	 */
+	if (!(regs->psw.mask & PSW_MASK_PSTATE)) {
+		switch (*(unsigned char *) regs->psw.addr) {
+		case 0xda:	/* mvcp */
+			fixup_user_copy(regs, address,
+					*(__u16 *)(regs->psw.addr + 2));
+			break;
+		case 0xdb:	/* mvcs */
+			fixup_user_copy(regs, address,
+					*(__u16 *)(regs->psw.addr + 4));
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (likely(get_page_unless_zero(page))) {
+		local_irq_enable();
+		page_discard(page);
+	}
+}
+#endif
diff -urpN linux-2.6/include/asm-generic/pgtable.h linux-2.6-patched/include/asm-generic/pgtable.h
--- linux-2.6/include/asm-generic/pgtable.h	2006-09-01 12:49:31.000000000 +0200
+++ linux-2.6-patched/include/asm-generic/pgtable.h	2006-09-01 12:50:25.000000000 +0200
@@ -139,8 +139,15 @@ static inline void ptep_set_wrprotect(st
 #define pte_same(A,B)	(pte_val(A) == pte_val(B))
 #endif
 
-#ifndef __HAVE_ARCH_PAGE_TEST_AND_CLEAR_DIRTY
-#define page_test_and_clear_dirty(page) (0)
+#ifndef __HAVE_ARCH_PAGE_TEST_DIRTY
+#define page_test_dirty(page)		(0)
+#endif
+
+#ifndef __HAVE_ARCH_PAGE_CLEAR_DIRTY
+#define page_clear_dirty(page)		do { } while (0)
+#endif
+
+#ifndef __HAVE_ARCH_PAGE_TEST_DIRTY
 #define pte_maybe_dirty(pte)		pte_dirty(pte)
 #else
 #define pte_maybe_dirty(pte)		(1)
diff -urpN linux-2.6/include/asm-s390/page-states.h linux-2.6-patched/include/asm-s390/page-states.h
--- linux-2.6/include/asm-s390/page-states.h	2006-09-01 12:49:36.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/page-states.h	2006-09-01 12:50:25.000000000 +0200
@@ -33,6 +33,22 @@ extern struct page *mem_map;
 	_rc; \
 })
 
+static inline int page_host_discards(void)
+{
+	return MACHINE_HAS_ESSA;
+}
+
+static inline int page_discarded(struct page *page)
+{
+	int state;
+
+	if (!MACHINE_HAS_ESSA)
+		return 0;
+	state = page_essa(page, ESSA_GET_STATE);
+	return (state & ESSA_USTATE_MASK) == ESSA_USTATE_VOLATILE &&
+		(state & ESSA_CSTATE_MASK) == ESSA_CSTATE_ZERO;
+}
+
 static inline void page_set_unused(struct page *page, int order)
 {
 	int i;
@@ -52,4 +68,27 @@ static inline void page_set_stable(struc
 	for (i = 0; i < (1 << order); i++)
 		page_essa(page + i, ESSA_SET_STABLE);
 }
+
+static inline void page_set_volatile(struct page *page, int writable)
+{
+	if (!MACHINE_HAS_ESSA)
+		return;
+	if (writable)
+		page_essa(page, ESSA_SET_PVOLATILE);
+	else
+		page_essa(page, ESSA_SET_VOLATILE);
+}
+
+static inline int page_set_stable_if_present(struct page *page)
+{
+	int rc;
+
+	if (!MACHINE_HAS_ESSA || PageReserved(page))
+		return 1;
+
+	rc = page_essa(page, ESSA_SET_STABLE_IF_NOT_DISCARDED);
+	return (rc & ESSA_USTATE_MASK) != ESSA_USTATE_VOLATILE ||
+		(rc & ESSA_CSTATE_MASK) != ESSA_CSTATE_ZERO;
+}
+
 #endif /* _ASM_S390_PAGE_STATES_H */
diff -urpN linux-2.6/include/asm-s390/pgtable.h linux-2.6-patched/include/asm-s390/pgtable.h
--- linux-2.6/include/asm-s390/pgtable.h	2006-09-01 12:49:32.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/pgtable.h	2006-09-01 12:50:25.000000000 +0200
@@ -604,14 +604,18 @@ ptep_establish(struct vm_area_struct *vm
  * should therefore only be called if it is not mapped in any
  * address space.
  */
-#define page_test_and_clear_dirty(_page)				  \
+#define page_test_dirty(_page)						  \
 ({									  \
 	struct page *__page = (_page);					  \
 	unsigned long __physpage = __pa((__page-mem_map) << PAGE_SHIFT);  \
-	int __skey = page_get_storage_key(__physpage);			  \
-	if (__skey & _PAGE_CHANGED)					  \
-		page_set_storage_key(__physpage, __skey & ~_PAGE_CHANGED);\
-	(__skey & _PAGE_CHANGED);					  \
+	(page_get_storage_key(__physpage) & _PAGE_CHANGED);		  \
+})
+
+#define page_clear_dirty(_page)						  \
+({									  \
+	struct page *__page = (_page);					  \
+	unsigned long __physpage = __pa((__page-mem_map) << PAGE_SHIFT);  \
+	page_set_storage_key(__physpage, PAGE_DEFAULT_KEY);		  \
 })
 
 /*
@@ -801,7 +805,8 @@ static inline pte_t mk_swap_pte(unsigned
 #define __HAVE_ARCH_PTEP_CLEAR_FLUSH
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 #define __HAVE_ARCH_PTE_SAME
-#define __HAVE_ARCH_PAGE_TEST_AND_CLEAR_DIRTY
+#define __HAVE_ARCH_PAGE_TEST_DIRTY
+#define __HAVE_ARCH_PAGE_CLEAR_DIRTY
 #define __HAVE_ARCH_PAGE_TEST_AND_CLEAR_YOUNG
 #include <asm-generic/pgtable.h>
 
diff -urpN linux-2.6/include/linux/page-flags.h linux-2.6-patched/include/linux/page-flags.h
--- linux-2.6/include/linux/page-flags.h	2006-09-01 12:50:25.000000000 +0200
+++ linux-2.6-patched/include/linux/page-flags.h	2006-09-01 12:50:25.000000000 +0200
@@ -135,10 +135,10 @@
 #define PageUptodate(page)	test_bit(PG_uptodate, &(page)->flags)
 #ifdef CONFIG_S390
 #define SetPageUptodate(_page) \
-	do {								      \
-		struct page *__page = (_page);				      \
-		if (!test_and_set_bit(PG_uptodate, &__page->flags))	      \
-			page_test_and_clear_dirty(_page);		      \
+	do {								  \
+		struct page *__page = (_page);				  \
+		if (!test_and_set_bit(PG_uptodate, &__page->flags))	  \
+			page_clear_dirty(_page);			  \
 	} while (0)
 #else
 #define SetPageUptodate(page)	set_bit(PG_uptodate, &(page)->flags)
diff -urpN linux-2.6/mm/rmap.c linux-2.6-patched/mm/rmap.c
--- linux-2.6/mm/rmap.c	2006-09-01 12:50:25.000000000 +0200
+++ linux-2.6-patched/mm/rmap.c	2006-09-01 12:50:25.000000000 +0200
@@ -594,8 +594,18 @@ void page_remove_rmap(struct page *page)
 		 * Leaving it set also helps swapoff to reinstate ptes
 		 * faster for those pages still in swapcache.
 		 */
-		if (page_test_and_clear_dirty(page))
+		if (page_test_dirty(page)) {
+			BUG_ON(!page_make_stable(page));
+			/*
+			 * We decremented the mapcount so we now have an
+			 * extra reference for the page. That prevents
+			 * page_make_volatile from making the page
+			 * volatile again while the dirty bit is in
+			 * transit.
+			 */
+			page_clear_dirty(page);
 			set_page_dirty(page);
+		}
 		__dec_zone_page_state(page,
 				PageAnon(page) ? NR_ANON_PAGES : NR_FILE_MAPPED);
 		page_reset_writable(page);
