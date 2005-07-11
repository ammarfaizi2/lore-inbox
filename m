Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbVGKNRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVGKNRQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 09:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbVGKNRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 09:17:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23232 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261673AbVGKNRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 09:17:01 -0400
Date: Mon, 11 Jul 2005 09:16:58 -0400
From: Kimball Murray <kmurray@redhat.com>
To: <linux-kernel@vger.kernel.org>
Cc: Kimball Murray <kmurray@redhat.com>
Message-Id: <20050711131531.8257.62845.sendpatchset@dhcp83-73.boston.redhat.com>
Subject: Dirty page tracking patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello to all.

	On behalf of Stratus Technologies (www.stratus.com) I'd like to
present a patch to the i386 kernel code that will allow developers to track
dirty memory pages.  Stratus uses this technique to facilitate bringing
separate cpu and memory module "nodes" into lockstep with each other, with
a minimum of OS down time. This feature could also be used to provide inputs
into memory management algorithms, or to support hot-plug memory dimm modules
for specially developed hardware.

	Stratus has used this patch in kernels 2.4.2, 2.4.18, 2.6.5, and 2.6.9
with great success. Also this same technique in different forms has been
shipping in Stratus products for 25 years in many different operating systems.
Stratus would like to share this tracking capability with the community.  In
particular, we'd like to hear ideas anyone may have about other uses for it,
how to improve it technically, or even if there's a better way to do this.  In
its current state, it is pretty lightweight, but it's inevitable that
developers will find ways to make it better, and more versatile.


Thank in advance for those that take an interest in this discussion.

	- Kimball Murray	(Stratus Technologies, currently on-site at
	  			 Redhat)

Please CC comments to:

	kmurray@redhat.com


What the patch does:
-------------------

	The patch adds a new _PAGE_SOFT_DIRTY bit to the pte layout.  This
takes the place of a previously unused bit in the pte.  The hardware will set
the _PAGE_DIRTY bit when the cpu writes to memory.  The _PAGE_SOFT_DIRTY bit
will only ever be set by software that is trying to copy live memory from one
memory domain to another. Such software would clear the _PAGE_DIRTY bit while
it sets the _PAGE_SOFT_DIRTY bit.  In this way, it would know that this page
has been added to a "must copy" list already.  A few kernel macros are
modified by this patch so that when the kernel queries the _PAGE_DIRTY bit, it
also queries the _PAGE_SOFT_DIRTY bit.  Doing this allows the kernel to run
normally whether or not a page harvest is in progress.
	Another addition this patch provides, is the mm_track(void*) call,
which allows software to record that a particular page needs to be copied
later.  For synchronizing memory domains on a live system, a cyclic page
harvester must not only copy all newly-dirtied pages in a given pass to the
target memory domain, it must also worry about pages that were dirtied after
the last pass, but whose reference is lost before the next pass.  For this
reason, the patch adds a few calls to mm_track() in places where page
references are being retired.
	Finally, tracking can be turned on and off by software at runtime.
When turned off, the impact of this patch on kernel performance is negligible.


What the patch doesn't do:
-------------------------

	Pages dirtied by device DMA into memory are not captured by the
tracking mechanism provided by this patch.  Stratus has constructed a special
PCI bridge which has a "snarf" mode that, when enabled, directs all DMA to
memory to each of the participating cpu/memory nodes.  Further, Stratus
hardware also performs a hardware memory check before releasing new cpu/memory
nodes into lockstep service.  This provides a means of evaluating both the
memory tracking patch, and also a particular harvest algorithm.
	The page harvest routine is not in this patch.  Stratus has a goal
that this patch have a minimal kernel footprint.  Therefore, our particular
harvest routine is in a kernel module.  Many implementations of the harvest
are possible as well, and we did not want to constrain that in this patch.


	Below are more details about the Stratus hardware and our harvest
algorithm.  Some of the discussion below may repeat things already covered
above.  If you just want to have a look at the patch itself, then please
fast-forward to the word "snip" in this document.

	
Stratus Architecture
--------------------

	Stratus Technologies builds highly available, fault-tolerant servers
by provided for redundancy of all system components, including processors
and DIMMs. It is possible to remove and replace these components in a way that
is transparent to the applications running on the system.

	Below is my poor man's sketch of the system layout.  The customer
replaceable units (CRUs) are usually 1-U rack-mounted slices.  The PCI bridge
in the middle box is split across the backplane, but appears as a single
PCI-PCI bridge to the OS.  The top and bottom halves of the bridge communicate
using a proprietary, packet-based protocol.

		(below) 2 or 3 CPU CRUs

    +---------------------+   +--------------------+
    |  CPUs and DIMMs     |   |  CPUs and DIMMs    |	... lockstep domain
    +---------------------+   +--------------------+
              |                         |
          +---------------------------------+
          |   |   PCI bridge (top)      |   |
          |   |         backplane       |   |
          |   +-------------------------+   |
          |   |         backplane       |   |
          |   |   PCI bridge (bottom)   |   |
          +---------------------------------+
              |                         |
    +---------------------+   +--------------------+
    |  PCI cards (IO)     |   |  PCI cards (IO)    |	... fail-over domain
    +---------------------+   +--------------------+

		(above) 2 or 4 IO CRUs

The fail-over domain features standard PCI devices configured in redundant
ways, like RAID1 for disk mirrors or bonded network interfaces.


Lockstep
--------

The lockstep domain requires each CPU CRU to be driven by the same clock.
Equally important, the contents of memory in each CRU must be the same.
To facilitate this, hardware is provided that can copy pages of memory
across the backplane from one CPU CRU to another.  The real trick is to
copy this memory without stopping any applications that are running on
the system, thereby allowing the possibility that some pages that have
been copied from online board to offline board have become dirty again on
the online board.  These pages will have to be copied over again.

The newly dirtied pages are tracked in software, and are again copied to the
offline board.  This loop continues until the total number of dirty pages
is below a predetermined threshold.  When that occurs, an SMI is issued on
the both boards.  A Stratus SMI handler will copy the remaining
dirty pages to the offline board.  During this operation the system is in
"blackout", which lasts about 300 mS, depending on the threshold value. After
the final pages are copied, a reset is issued to all boards,
caches are flushed, etc., and as the SMI handler returns, it restores all of
the processor state that existed before the SMI was issued.  On return from
SMI, the new board is executing in lock with the old.

	(yes, I have omitted some nitty gritty chipset details.)

Dirty Page Harvest
------------------

I'd like now to discuss how the harvest loop works.  First I should mention
that the harvest code is not in the kernel proper, it is instead a GPL loadable
kernel module that uses the tracking structure created by the patch included
in this note.  Here is the basic algorithm (again, some details omitted
for the sake of brevity/clarity):

1. Turn on dirty page tracking
2. Copy _all_ physical memory from online board to offline board
3. Begin harvest loop
	a) Iterate over all page tables.  For each pte (pmd, pgd):
		If the hardware dirty bit is set
			Clear it and copy it into a software dirty bit.
			Add this page to the mm_track bit vector.

		---- Begin processing bit vector ----

	b) CPUs enter rendezvous, interrupts off (momentary blackout)

	c) If number of dirty pages remaining < THRESHOLD
		Break out of the harvest loop (goto step 4.)

	d) Iterate over the mm_track bit vector. A bit set indicates a dirty
           page was found.
		Add pages to a list of pages to be copied to offline board.

	e) Clear mm_track bit vector

	f) Interrupts on, cpus exit rendezvous

		---- End processing bit vector ----

	g) Copy pages in list to offline board, using "data mover"
           hardware.

	h) Go back to start of loop, step a).
4. Trigger SMI, do final copy, reset boards.	(Enter 300mS blackout)
5. Return from SMI, boards now in lock.

In addition to tracking pages whose hardware dirty bits are set, it is
necessary to track pages that are being retired.  This is because they
may be retired outside of step 3.a above, in which case they could have
been dirty, but we just lost the reference to them.  To guard against this,
we simply call mm_track for ptes leaving the system.  It's better to over-
track than under-track.  A single forgotten page will eventually cause the
CPU CRUs to break lockstep.


Effect of patch on non-Stratus systems
--------------------------------------

Dirty page tracking must be turned on to really do anything. It can be turned
on by a kernel loadable agent, such as the harvest module described above. On
systems which do not enable it, it has no effect, other than adding a test
to see if tracking is turned on to a few pte macros, as well as an additional
boolean test is some other pte macros (because of the hard vs soft dirty bits).


Robustness of tracking on Stratus systems
-----------------------------------------

Stratus has a failsafe operation that verifies how well the tracking system
works.  After bringing an offline CPU board into lockstep with an online
board, a hardware memory check is done on both boards.  If there are any
differences, the newly online board is taken out of service.  Additionally,
this post sync memory check helps Stratus catch the case where a user has
loaded a binary module that was compiled without tracking support.  It's
possible, though unlikely, that this module could retire pages (via calls
to set_pte, etc) and these pages would not have been tracked.  The hardware
memory checker will catch these cases by not allowing CPU CRUs to be brought
into lockstep.


	The following patch is against linux-2.6.9-13-rc2:

--------------------------------- snip -----------------------------------

diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -37,6 +37,14 @@ source "init/Kconfig"
 
 menu "Processor type and features"
 
+config MEM_MIRROR
+	bool "Memory Mirroring (memory tracking support)"
+	depends on SMP
+	help
+	  Memory tracking support can be used by agents wishing to
+	  keep track of changes to memory while monitoring or copying
+	  memory contents.
+
 choice
 	prompt "Subarchitecture Type"
 	default X86_PC
diff --git a/arch/i386/mm/init.c b/arch/i386/mm/init.c
--- a/arch/i386/mm/init.c
+++ b/arch/i386/mm/init.c
@@ -694,3 +694,33 @@ void free_initrd_mem(unsigned long start
 	}
 }
 #endif
+
+#ifdef CONFIG_MEM_MIRROR
+/*
+ * For memory-tracking purposes, see mm_track.h for details.
+ */
+struct mm_tracker mm_tracking_struct = {ATOMIC_INIT(0), ATOMIC_INIT(0), 0, 0};
+EXPORT_SYMBOL_GPL(mm_tracking_struct);
+
+/* The do_mm_track routine is needed by macros in the pgtable-2level.h
+ * and pgtable-3level.h.
+ */
+void do_mm_track(void * val)
+{
+	pte_t *ptep = (pte_t*)val;
+	unsigned long pfn;
+
+	if (!pte_present(*ptep))
+		return;
+
+	pfn = pte_pfn(*ptep);
+	pfn &= ((1LL << (PFN_BITS - PAGE_SHIFT)) - 1);
+
+	if (pfn >= mm_tracking_struct.bitcnt)
+		return;
+
+	if (!test_and_set_bit(pfn, mm_tracking_struct.vector))
+		atomic_inc(&mm_tracking_struct.count);
+}
+EXPORT_SYMBOL_GPL(do_mm_track);
+#endif
diff --git a/include/asm-i386/mm_track.h b/include/asm-i386/mm_track.h
new file mode 100644
--- /dev/null
+++ b/include/asm-i386/mm_track.h
@@ -0,0 +1,57 @@
+#ifndef __I386_MMTRACK_H__
+#define __I386_MMTRACK_H__
+
+#ifndef CONFIG_MEM_MIRROR
+
+#define mm_track(ptep)
+
+#else
+
+#include <asm/page.h>
+#include <asm/atomic.h>
+ /*
+  * For memory-tracking purposes, if active is true (non-zero), the other
+  * elements of the structure are available for use.  Each time mm_track
+  * is called, it increments count and sets a bit in the bitvector table.
+  * Each bit in the bitvector represents a physical page in memory.
+  *
+  * This is declared in arch/i386/mm/init.c.
+  *
+  * The in_use element is used in the code which drives the memory tracking
+  * environment.  When tracking is complete, the vector may be freed, but 
+  * only after the active flag is set to zero and the in_use count goes to
+  * zero.
+  *
+  * The count element indicates how many pages have been stored in the
+  * bitvector.  This is an optimization to avoid counting the bits in the
+  * vector between harvest operations.
+  */
+struct mm_tracker {
+	atomic_t active;	// non-zero if this structure in use
+	atomic_t count;		// number of pages tracked by mm_track()
+	unsigned long * vector;	// bit vector of modified pages
+	unsigned long bitcnt;	// number of bits in vector
+};
+extern struct mm_tracker mm_tracking_struct;
+
+#ifdef CONFIG_X86_PAE
+#define PFN_BITS	36
+#else /* !CONFIG_X86_PAE */
+#define PFN_BITS	32
+#endif /* !CONFIG_X86_PAE */
+
+extern void do_mm_track(void *);
+
+/* The mm_track routine is needed by macros in the pgtable-2level.h
+ * and pgtable-3level.h.  The pte manipulation is all longhand below
+ * because the required order of header files makes all the useful
+ * definitions happen after the following code.
+ */
+static __inline__ void mm_track(void * val)
+{
+	if (unlikely(atomic_read(&mm_tracking_struct.active)))
+		do_mm_track(val);
+}
+#endif /* CONFIG_MEM_MIRROR */
+
+#endif /* __I386_MMTRACK_H__ */
diff --git a/include/asm-i386/pgtable-2level.h b/include/asm-i386/pgtable-2level.h
--- a/include/asm-i386/pgtable-2level.h
+++ b/include/asm-i386/pgtable-2level.h
@@ -13,12 +13,24 @@
  * within a page table are directly modified.  Thus, the following
  * hook is made available.
  */
-#define set_pte(pteptr, pteval) (*(pteptr) = pteval)
+#define set_pte(pteptr, pteval)			\
+({						\
+	mm_track(pteptr);			\
+	*(pteptr) = pteval;			\
+})
 #define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
 #define set_pte_atomic(pteptr, pteval) set_pte(pteptr,pteval)
-#define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
-
-#define ptep_get_and_clear(mm,addr,xp)	__pte(xchg(&(xp)->pte_low, 0))
+#define set_pmd(pmdptr, pmdval)			\
+({						\
+ 	mm_track(pmdptr);			\
+	*(pmdptr) = pmdval;			\
+})
+
+#define ptep_get_and_clear(mm,addr,xp)		\
+({						\
+	mm_track(xp);				\
+	__pte(xchg(&(xp)->pte_low, 0));		\
+})
 #define pte_same(a, b)		((a).pte_low == (b).pte_low)
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
 #define pte_none(x)		(!(x).pte_low)
diff --git a/include/asm-i386/pgtable-3level.h b/include/asm-i386/pgtable-3level.h
--- a/include/asm-i386/pgtable-3level.h
+++ b/include/asm-i386/pgtable-3level.h
@@ -52,6 +52,7 @@ static inline int pte_exec_kernel(pte_t 
  */
 static inline void set_pte(pte_t *ptep, pte_t pte)
 {
+	mm_track(ptep);	// track the old (departing) page
 	ptep->pte_high = pte.pte_high;
 	smp_wmb();
 	ptep->pte_low = pte.pte_low;
@@ -59,10 +60,16 @@ static inline void set_pte(pte_t *ptep, 
 #define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
 
 #define __HAVE_ARCH_SET_PTE_ATOMIC
-#define set_pte_atomic(pteptr,pteval) \
-		set_64bit((unsigned long long *)(pteptr),pte_val(pteval))
-#define set_pmd(pmdptr,pmdval) \
-		set_64bit((unsigned long long *)(pmdptr),pmd_val(pmdval))
+#define set_pte_atomic(pteptr,pteval)					\
+({									\
+ 	mm_track(pteptr);	 /* track the old page */		\
+	set_64bit((unsigned long long *)(pteptr),pte_val(pteval));	\
+})
+#define set_pmd(pmdptr,pmdval)						\
+({									\
+	mm_track(pmdptr);	/* track the old page */		\
+	set_64bit((unsigned long long *)(pmdptr),pmd_val(pmdval));	\
+})
 #define set_pud(pudptr,pudval) \
 		set_64bit((unsigned long long *)(pudptr),pud_val(pudval))
 
@@ -94,6 +101,8 @@ static inline pte_t ptep_get_and_clear(s
 {
 	pte_t res;
 
+	mm_track(ptep);	// track old page before losing this reference
+
 	/* xchg acts as a barrier before the setting of the high bits */
 	res.pte_low = xchg(&ptep->pte_low, 0);
 	res.pte_high = ptep->pte_high;
diff --git a/include/asm-i386/pgtable.h b/include/asm-i386/pgtable.h
--- a/include/asm-i386/pgtable.h
+++ b/include/asm-i386/pgtable.h
@@ -21,6 +21,8 @@
 #include <asm/bitops.h>
 #endif
 
+#include <asm/mm_track.h>
+
 #include <linux/slab.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
@@ -101,7 +103,7 @@ void paging_init(void);
 #define _PAGE_BIT_DIRTY		6
 #define _PAGE_BIT_PSE		7	/* 4 MB (or 2MB) page, Pentium+, if present.. */
 #define _PAGE_BIT_GLOBAL	8	/* Global TLB entry PPro+ */
-#define _PAGE_BIT_UNUSED1	9	/* available for programmer */
+#define _PAGE_BIT_SOFTDIRTY	9	/* save dirty state when hdw dirty bit cleared */
 #define _PAGE_BIT_UNUSED2	10
 #define _PAGE_BIT_UNUSED3	11
 #define _PAGE_BIT_NX		63
@@ -115,7 +117,7 @@ void paging_init(void);
 #define _PAGE_DIRTY	0x040
 #define _PAGE_PSE	0x080	/* 4 MB (or 2MB) page, Pentium+, if present.. */
 #define _PAGE_GLOBAL	0x100	/* Global TLB entry PPro+ */
-#define _PAGE_UNUSED1	0x200	/* available for programmer */
+#define _PAGE_SOFTDIRTY	0x200
 #define _PAGE_UNUSED2	0x400
 #define _PAGE_UNUSED3	0x800
 
@@ -129,7 +131,7 @@ void paging_init(void);
 
 #define _PAGE_TABLE	(_PAGE_PRESENT | _PAGE_RW | _PAGE_USER | _PAGE_ACCESSED | _PAGE_DIRTY)
 #define _KERNPG_TABLE	(_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY)
-#define _PAGE_CHG_MASK	(PTE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY)
+#define _PAGE_CHG_MASK	(PTE_MASK | _PAGE_ACCESSED | _PAGE_SOFTDIRTY | _PAGE_DIRTY)
 
 #define PAGE_NONE \
 	__pgprot(_PAGE_PROTNONE | _PAGE_ACCESSED)
@@ -206,8 +208,7 @@ extern unsigned long pg0[];
 #define pmd_none(x)	(!pmd_val(x))
 #define pmd_present(x)	(pmd_val(x) & _PAGE_PRESENT)
 #define pmd_clear(xp)	do { set_pmd(xp, __pmd(0)); } while (0)
-#define	pmd_bad(x)	((pmd_val(x) & (~PAGE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE)
-
+#define	pmd_bad(x)	((pmd_val(x) & (~PAGE_MASK & ~_PAGE_USER & ~_PAGE_SOFTDIRTY & ~_PAGE_ACCESSED)) != (_KERNPG_TABLE & ~_PAGE_ACCESSED))
 
 #define pages_to_mb(x) ((x) >> (20-PAGE_SHIFT))
 
@@ -217,7 +218,7 @@ extern unsigned long pg0[];
  */
 static inline int pte_user(pte_t pte)		{ return (pte).pte_low & _PAGE_USER; }
 static inline int pte_read(pte_t pte)		{ return (pte).pte_low & _PAGE_USER; }
-static inline int pte_dirty(pte_t pte)		{ return (pte).pte_low & _PAGE_DIRTY; }
+static inline int pte_dirty(pte_t pte)		{ return (pte).pte_low & (_PAGE_DIRTY | _PAGE_SOFTDIRTY); }
 static inline int pte_young(pte_t pte)		{ return (pte).pte_low & _PAGE_ACCESSED; }
 static inline int pte_write(pte_t pte)		{ return (pte).pte_low & _PAGE_RW; }
 
@@ -228,7 +229,7 @@ static inline int pte_file(pte_t pte)		{
 
 static inline pte_t pte_rdprotect(pte_t pte)	{ (pte).pte_low &= ~_PAGE_USER; return pte; }
 static inline pte_t pte_exprotect(pte_t pte)	{ (pte).pte_low &= ~_PAGE_USER; return pte; }
-static inline pte_t pte_mkclean(pte_t pte)	{ (pte).pte_low &= ~_PAGE_DIRTY; return pte; }
+static inline pte_t pte_mkclean(pte_t pte)      { (pte).pte_low &= ~(_PAGE_SOFTDIRTY | _PAGE_DIRTY); return pte; }
 static inline pte_t pte_mkold(pte_t pte)	{ (pte).pte_low &= ~_PAGE_ACCESSED; return pte; }
 static inline pte_t pte_wrprotect(pte_t pte)	{ (pte).pte_low &= ~_PAGE_RW; return pte; }
 static inline pte_t pte_mkread(pte_t pte)	{ (pte).pte_low |= _PAGE_USER; return pte; }
@@ -246,9 +247,9 @@ static inline pte_t pte_mkhuge(pte_t pte
 
 static inline int ptep_test_and_clear_dirty(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
 {
-	if (!pte_dirty(*ptep))
-		return 0;
-	return test_and_clear_bit(_PAGE_BIT_DIRTY, &ptep->pte_low);
+ 	mm_track(ptep);
+       	return (test_and_clear_bit(_PAGE_BIT_DIRTY, &ptep->pte_low) |
+		test_and_clear_bit(_PAGE_BIT_SOFTDIRTY, &ptep->pte_low));
 }
 
 static inline int ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
