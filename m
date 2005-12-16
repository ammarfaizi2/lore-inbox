Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbVLPVIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbVLPVIx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 16:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbVLPVI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 16:08:26 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:53129 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932197AbVLPVIW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 16:08:22 -0500
Date: Fri, 16 Dec 2005 22:08:22 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, frankeh@watson.ibm.com,
       rhim@cc.gatech.edu
Subject: [rfc][patch 6/6] Page host virtual assist: s390 support.
Message-ID: <20051216210822.GG11062@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>
From: Hubertus Franke <frankeh@watson.ibm.com>
From: Himanshu Raj <rhim@cc.gatech.edu>

[rfc][patch 6/6] Page host virtual assist: s390 support.

And finally the patch that introduces hva support for s390.
s390 uses the milli-coded ESSA instruction to set the page state.
The page state is formed by four guest page states called block usage
states and three host page states called block content states.

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

There are 12 combinations of guest and host state, but only 8 are valid
page states:
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
     guest requests it with page_hva_set_{unused,stable,volatile}.
{Uz,Sz,Vz}: a logically zero page will change its block usage state if the
     guest requests it with page_hva_set_{unused,stable,volatile}. The
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

For potential volatile page there is one more pitfall. The transfer of
the hardware dirty bit to the software dirty bit needs to make sure that
the page gets into the stable state before the hardware dirty bit is
cleared. The primitive page_test_and_clear_dirty is split into
page_test_dirty and page_clear_dirty to be able to place a
page_hva_make_stable call between them.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 arch/s390/Kconfig             |    3 +
 arch/s390/kernel/head64.S     |   10 ++++
 arch/s390/kernel/traps.c      |    4 +
 arch/s390/mm/fault.c          |   46 ++++++++++++++++++++
 include/asm-generic/pgtable.h |   11 ++++
 include/asm-s390/page_hva.h   |   93 ++++++++++++++++++++++++++++++++++++++++++
 include/asm-s390/pgtable.h    |   25 ++++++-----
 include/asm-s390/setup.h      |    1 
 mm/msync.c                    |   24 +++++++++-
 mm/rmap.c                     |   12 ++++-
 10 files changed, 214 insertions(+), 15 deletions(-)

diff -urpN linux-2.6/arch/s390/Kconfig linux-2.6-patched/arch/s390/Kconfig
--- linux-2.6/arch/s390/Kconfig	2005-12-16 20:40:25.000000000 +0100
+++ linux-2.6-patched/arch/s390/Kconfig	2005-12-16 20:40:54.000000000 +0100
@@ -459,6 +459,9 @@ config KEXEC
 	  current kernel, and to start another kernel.  It is like a reboot
 	  but is independent of hardware/microcode support.
 
+config PAGE_HVA
+	bool "Enable support for host virtual assist."
+
 endmenu
 
 source "net/Kconfig"
diff -urpN linux-2.6/arch/s390/kernel/head64.S linux-2.6-patched/arch/s390/kernel/head64.S
--- linux-2.6/arch/s390/kernel/head64.S	2005-12-16 20:39:55.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/head64.S	2005-12-16 20:40:54.000000000 +0100
@@ -222,6 +222,16 @@ startup:basr  %r13,0                    
 	oi	7(%r12),0x80		# set IDTE flag
 0:
 
+#
+# find out if we have the ESSA instruction
+#
+	la	%r1,0f-.LPG1(%r13)	# set program check address
+	stg	%r1,__LC_PGM_NEW_PSW+8
+	lghi	%r1,0
+	.long	0xb9ab0001		# essa get state
+	oi	6(%r12),0x01		# set ESSA flag
+0:
+
         lpswe .Lentry-.LPG1(13)         # jump to _stext in primary-space,
                                         # virtual and never return ...
         .align 16
diff -urpN linux-2.6/arch/s390/kernel/traps.c linux-2.6-patched/arch/s390/kernel/traps.c
--- linux-2.6/arch/s390/kernel/traps.c	2005-12-16 20:39:55.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/traps.c	2005-12-16 20:40:54.000000000 +0100
@@ -64,6 +64,7 @@ extern void pfault_interrupt(struct pt_r
 static ext_int_info_t ext_int_pfault;
 #endif
 extern pgm_check_handler_t do_monitor_call;
+extern pgm_check_handler_t do_discard_fault;
 
 #define stack_pointer ({ void **sp; asm("la %0,0(15)" : "=&d" (sp)); sp; })
 
@@ -712,6 +713,9 @@ void __init trap_init(void)
         pgm_check_table[0x1C] = &space_switch_exception;
         pgm_check_table[0x1D] = &hfp_sqrt_exception;
 	pgm_check_table[0x40] = &do_monitor_call;
+#ifdef CONFIG_PAGE_HVA
+	pgm_check_table[0x1a] = &do_discard_fault;
+#endif
 
 	if (MACHINE_IS_VM) {
 #ifdef CONFIG_PFAULT
diff -urpN linux-2.6/arch/s390/mm/fault.c linux-2.6-patched/arch/s390/mm/fault.c
--- linux-2.6/arch/s390/mm/fault.c	2005-12-16 20:39:55.000000000 +0100
+++ linux-2.6-patched/arch/s390/mm/fault.c	2005-12-16 20:40:54.000000000 +0100
@@ -20,6 +20,7 @@
 #include <linux/ptrace.h>
 #include <linux/mman.h>
 #include <linux/mm.h>
+#include <linux/pagemap.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
@@ -254,6 +255,7 @@ survive:
 		tsk->min_flt++;
 		break;
 	case VM_FAULT_MAJOR:
+	case VM_FAULT_DISCARD:
 		tsk->maj_flt++;
 		break;
 	case VM_FAULT_SIGBUS:
@@ -478,3 +480,47 @@ pfault_interrupt(struct pt_regs *regs, _
 }
 #endif
 
+#ifdef CONFIG_PAGE_HVA
+
+/*
+ * Special variant of get_page. It only gets a reference if
+ * the page_count() is not zero.
+ * Discarded pages with a page_count() of zero are placed on
+ * the page_hva_discarded_list until all cpus have been at
+ * least once in enabled code. That closes the race of page
+ * free vs. discard faults.
+ */
+static inline int get_page_if_present(struct page *page)
+{
+	int old, new;
+
+	if (unlikely(PageCompound(page)))
+		page = (struct page *) page_private(page);
+	do {
+		old = atomic_read(&page->_count);
+		if (old < 0)
+			break;
+		new = old + 1;
+	} while (atomic_cmpxchg(&page->_count, old, new) != old);
+	return old >= 0;
+}
+
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
+	if (get_page_if_present(page)) {
+		local_irq_enable();
+		page_hva_discard_page(page);
+		page_cache_release(page);
+	}
+}
+#endif
diff -urpN linux-2.6/include/asm-generic/pgtable.h linux-2.6-patched/include/asm-generic/pgtable.h
--- linux-2.6/include/asm-generic/pgtable.h	2005-12-16 20:40:14.000000000 +0100
+++ linux-2.6-patched/include/asm-generic/pgtable.h	2005-12-16 20:40:54.000000000 +0100
@@ -140,8 +140,15 @@ static inline void ptep_set_wrprotect(st
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
diff -urpN linux-2.6/include/asm-s390/page_hva.h linux-2.6-patched/include/asm-s390/page_hva.h
--- linux-2.6/include/asm-s390/page_hva.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/page_hva.h	2005-12-16 20:40:54.000000000 +0100
@@ -0,0 +1,93 @@
+#ifndef _ASM_S390_PAGE_HVA_H
+#define _ASM_S390_PAGE_HVA_H
+
+#define ESSA_GET_STATE			0
+#define ESSA_SET_STABLE			1
+#define ESSA_SET_UNUSED			2
+#define ESSA_SET_VOLATILE		3
+#define ESSA_SET_PVOLATILE		4
+#define ESSA_SET_STABLE_MAKE_RESIDENT	5
+#define ESSA_SET_STABLE_IF_RESIDENT	6
+
+#define ESSA_USTATE_MASK		0x0c
+#define ESSA_USTATE_STABLE		0x00
+#define ESSA_USTATE_UNUSED		0x04
+#define ESSA_USTATE_PVOLATILE		0x08
+#define ESSA_USTATE_VOLATILE		0x0c
+
+#define ESSA_CSTATE_MASK		0x03
+#define ESSA_CSTATE_RESIDENT		0x00
+#define ESSA_CSTATE_PRESERVED		0x02
+#define ESSA_CSTATE_ZERO		0x03
+
+extern struct page *mem_map;
+
+/*
+ * ESSA <rc-reg>,<page-address-reg>,<command-immediate>
+ */
+#define page_hva_essa(_page,_command) ({		       \
+	int _rc; \
+	asm volatile(".insn rrf,0xb9ab0000,%0,%1,%2,0" \
+		     : "=&d" (_rc) : "a" (((_page)-mem_map)<<PAGE_SHIFT), \
+		       "i" (_command)); \
+	_rc; \
+})
+
+static inline int page_hva_enabled(void)
+{
+	return MACHINE_HAS_ESSA;
+}
+
+static inline int page_hva_get_state(struct page *page)
+{
+	return page_hva_essa(page, ESSA_GET_STATE);
+}
+
+static inline int page_hva_discarded(struct page *page)
+{
+	int state;
+
+	if (!page_hva_enabled())
+		return 0;
+	state = page_hva_get_state(page);
+	return (state & ESSA_USTATE_MASK) == ESSA_USTATE_VOLATILE &&
+		(state & ESSA_CSTATE_MASK) == ESSA_CSTATE_ZERO;
+}
+
+static inline void page_hva_set_unused(struct page *page)
+{
+	if (!page_hva_enabled())
+		return;
+	page_hva_essa(page, ESSA_SET_UNUSED);
+}
+
+static inline void page_hva_set_stable(struct page *page)
+{
+	if (!page_hva_enabled())
+		return;
+	page_hva_essa(page, ESSA_SET_STABLE);
+}
+
+static inline void page_hva_set_volatile(struct page *page, int writable)
+{
+	if (!page_hva_enabled())
+		return;
+	if (writable)
+		page_hva_essa(page, ESSA_SET_PVOLATILE);
+	else
+		page_hva_essa(page, ESSA_SET_VOLATILE);
+}
+
+static inline int page_hva_set_stable_if_resident(struct page *page)
+{
+	int rc;
+
+	if (!page_hva_enabled())
+		return 1;
+
+	rc = page_hva_essa(page, ESSA_SET_STABLE_IF_RESIDENT);
+	return (rc & ESSA_USTATE_MASK) != ESSA_USTATE_VOLATILE ||
+		(rc & ESSA_CSTATE_MASK) != ESSA_CSTATE_ZERO;
+}
+
+#endif /* _ASM_S390_PAGE_HVA_H */
diff -urpN linux-2.6/include/asm-s390/pgtable.h linux-2.6-patched/include/asm-s390/pgtable.h
--- linux-2.6/include/asm-s390/pgtable.h	2005-12-16 20:40:15.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/pgtable.h	2005-12-16 20:40:54.000000000 +0100
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
@@ -658,10 +662,10 @@ static inline pte_t mk_pte_phys(unsigned
 })
 
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
 
 #ifdef __s390x__
@@ -806,7 +810,8 @@ static inline pte_t mk_swap_pte(unsigned
 #define __HAVE_ARCH_PTEP_CLEAR_FLUSH
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 #define __HAVE_ARCH_PTE_SAME
-#define __HAVE_ARCH_PAGE_TEST_AND_CLEAR_DIRTY
+#define __HAVE_ARCH_PAGE_TEST_DIRTY
+#define __HAVE_ARCH_PAGE_CLEAR_DIRTY
 #define __HAVE_ARCH_PAGE_TEST_AND_CLEAR_YOUNG
 #include <asm-generic/pgtable.h>
 
diff -urpN linux-2.6/include/asm-s390/setup.h linux-2.6-patched/include/asm-s390/setup.h
--- linux-2.6/include/asm-s390/setup.h	2005-12-16 20:40:15.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/setup.h	2005-12-16 20:40:54.000000000 +0100
@@ -40,6 +40,7 @@ extern unsigned long machine_flags;
 #define MACHINE_HAS_MVPG	(machine_flags & 16)
 #define MACHINE_HAS_DIAG44	(machine_flags & 32)
 #define MACHINE_HAS_IDTE	(machine_flags & 128)
+#define MACHINE_HAS_ESSA	(machine_flags & 256)
 
 #ifndef __s390x__
 #define MACHINE_HAS_IEEE	(machine_flags & 2)
diff -urpN linux-2.6/mm/msync.c linux-2.6-patched/mm/msync.c
--- linux-2.6/mm/msync.c	2005-12-16 20:40:15.000000000 +0100
+++ linux-2.6-patched/mm/msync.c	2005-12-16 20:40:54.000000000 +0100
@@ -42,9 +42,29 @@ again:
 		page = vm_normal_page(vma, addr, *pte);
 		if (!page)
 			continue;
-		if (ptep_clear_flush_dirty(vma, addr, pte) ||
-		    page_test_and_clear_dirty(page))
+		if (ptep_clear_flush_dirty(vma, addr, pte))
 			set_page_dirty(page);
+		if (page_test_dirty(page)) {
+			if (page_hva_enabled()) {
+				/*
+				 * Take another reference to the page to
+				 * make sure that make_volatile cannot make
+				 * the page volatile again after we made it
+				 * stable.
+				 * After the (software) dirty bit is set we
+				 * can release the reference again because
+				 * then the dirty bit takes over the job.
+				 */
+				page_cache_get(page);
+				BUG_ON(!page_hva_make_stable(page));
+				page_clear_dirty(page);
+				set_page_dirty(page);
+				page_cache_release(page);
+			} else {
+				page_clear_dirty(page);
+				set_page_dirty(page);
+			}
+		}
 		progress += 3;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	pte_unmap_unlock(pte - 1, ptl);
diff -urpN linux-2.6/mm/rmap.c linux-2.6-patched/mm/rmap.c
--- linux-2.6/mm/rmap.c	2005-12-16 20:40:53.000000000 +0100
+++ linux-2.6-patched/mm/rmap.c	2005-12-16 20:40:54.000000000 +0100
@@ -666,8 +666,18 @@ void page_remove_rmap(struct page *page)
 		 * Leaving it set also helps swapoff to reinstate ptes
 		 * faster for those pages still in swapcache.
 		 */
-		if (page_test_and_clear_dirty(page))
+		if (page_test_dirty(page)) {
+			BUG_ON(!page_hva_make_stable(page));
+			/*
+			 * We decremented the mapcount so we now have an
+			 * extra reference for the page. That prevents
+			 * page_hva_make_volatile from making the page
+			 * volatile again while the dirty bit is in
+			 * transit.
+			 */
+			page_clear_dirty(page);
 			set_page_dirty(page);
+		}
 		__dec_page_state(nr_mapped);
 		page_hva_reset_write(page);
 	}
