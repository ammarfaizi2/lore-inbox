Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317258AbSIEHoC>; Thu, 5 Sep 2002 03:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317261AbSIEHoC>; Thu, 5 Sep 2002 03:44:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2577 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317258AbSIEHoA>;
	Thu, 5 Sep 2002 03:44:00 -0400
Message-ID: <3D770F48.52B0360B@zip.com.au>
Date: Thu, 05 Sep 2002 01:01:12 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 1/3] atomic copy_*_user() infrastructure
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The patch implements the atomic copy_*_user() function.

If the kernel takes a pagefault while running copy_*_user() in an
atomic region, the copy_*_user() will fail (return a short value).

And with this patch, holding an atomic kmap() puts the CPU into an
atomic region.

- Increment preempt_count() in kmap_atomic() regardless of the
  setting of CONFIG_PREEMPT.  The pagefault handler recognises this as
  an atomic region and refuses to service the fault.  copy_*_user will
  return a non-zero value.

- Attempts to propagate the in_atomic() predicate to all the other
  highmem-capable architectures' pagefault handlers.  But the code is
  only tested on x86.

- Fixed a PPC bug in kunmap_atomic(): it forgot to reenable
  preemption if HIGHMEM_DEBUG is turned on.

- Fixed a sparc bug in kunmap_atomic(): it forgot to reenable
  preemption all the time, for non-fixmap pages.

- Fix an error in <linux/highmem.h> - in the CONFIG_HIGHMEM=n case,
  kunmap_atomic() takes an address, not a page *.



 arch/ppc/mm/fault.c         |    2 +-
 arch/sparc/mm/fault.c       |    2 +-
 include/asm-i386/highmem.h  |    6 +++---
 include/asm-ppc/hardirq.h   |    2 ++
 include/asm-ppc/highmem.h   |    6 +++++-
 include/asm-sparc/hardirq.h |    6 ++++++
 include/asm-sparc/highmem.h |    6 +++++-
 include/linux/highmem.h     |    4 ++--
 8 files changed, 25 insertions(+), 9 deletions(-)

--- 2.5.33/include/asm-i386/highmem.h~copy_user_atomic	Thu Sep  5 00:44:46 2002
+++ 2.5.33-akpm/include/asm-i386/highmem.h	Thu Sep  5 00:44:46 2002
@@ -81,7 +81,7 @@ static inline void *kmap_atomic(struct p
 	enum fixed_addresses idx;
 	unsigned long vaddr;
 
-	preempt_disable();
+	inc_preempt_count();
 	if (page < highmem_start_page)
 		return page_address(page);
 
@@ -104,7 +104,7 @@ static inline void kunmap_atomic(void *k
 	enum fixed_addresses idx = type + KM_TYPE_NR*smp_processor_id();
 
 	if (vaddr < FIXADDR_START) { // FIXME
-		preempt_enable();
+		dec_preempt_count();
 		return;
 	}
 
@@ -119,7 +119,7 @@ static inline void kunmap_atomic(void *k
 	__flush_tlb_one(vaddr);
 #endif
 
-	preempt_enable();
+	dec_preempt_count();
 }
 
 #endif /* __KERNEL__ */
--- 2.5.33/include/asm-ppc/highmem.h~copy_user_atomic	Thu Sep  5 00:44:46 2002
+++ 2.5.33-akpm/include/asm-ppc/highmem.h	Thu Sep  5 00:44:46 2002
@@ -88,6 +88,7 @@ static inline void *kmap_atomic(struct p
 	unsigned int idx;
 	unsigned long vaddr;
 
+	inc_preempt_count();
 	if (page < highmem_start_page)
 		return page_address(page);
 
@@ -109,8 +110,10 @@ static inline void kunmap_atomic(void *k
 	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
 	unsigned int idx = type + KM_TYPE_NR*smp_processor_id();
 
-	if (vaddr < KMAP_FIX_BEGIN) // FIXME
+	if (vaddr < KMAP_FIX_BEGIN) { // FIXME
+		dec_preempt_count();
 		return;
+	}
 
 	if (vaddr != KMAP_FIX_BEGIN + idx * PAGE_SIZE)
 		BUG();
@@ -122,6 +125,7 @@ static inline void kunmap_atomic(void *k
 	pte_clear(kmap_pte+idx);
 	flush_tlb_page(0, vaddr);
 #endif
+	dec_preempt_count();
 }
 
 #endif /* __KERNEL__ */
--- 2.5.33/include/asm-sparc/highmem.h~copy_user_atomic	Thu Sep  5 00:44:46 2002
+++ 2.5.33-akpm/include/asm-sparc/highmem.h	Thu Sep  5 00:44:46 2002
@@ -83,6 +83,7 @@ static inline void *kmap_atomic(struct p
 	unsigned long idx;
 	unsigned long vaddr;
 
+	inc_preempt_count();
 	if (page < highmem_start_page)
 		return page_address(page);
 
@@ -116,8 +117,10 @@ static inline void kunmap_atomic(void *k
 	unsigned long vaddr = (unsigned long) kvaddr;
 	unsigned long idx = type + KM_TYPE_NR*smp_processor_id();
 
-	if (vaddr < FIX_KMAP_BEGIN) // FIXME
+	if (vaddr < FIX_KMAP_BEGIN) { // FIXME
+		dec_preempt_count();
 		return;
+	}
 
 	if (vaddr != FIX_KMAP_BEGIN + idx * PAGE_SIZE)
 		BUG();
@@ -142,6 +145,7 @@ static inline void kunmap_atomic(void *k
 	flush_tlb_all();
 #endif
 #endif
+	dec_preempt_count();
 }
 
 #endif /* __KERNEL__ */
--- 2.5.33/arch/sparc/mm/fault.c~copy_user_atomic	Thu Sep  5 00:44:46 2002
+++ 2.5.33-akpm/arch/sparc/mm/fault.c	Thu Sep  5 00:44:46 2002
@@ -233,7 +233,7 @@ asmlinkage void do_sparc_fault(struct pt
 	 * If we're in an interrupt or have no user
 	 * context, we must not take the fault..
 	 */
-        if (in_interrupt() || !mm)
+        if (in_atomic() || !mm)
                 goto no_context;
 
 	down_read(&mm->mmap_sem);
--- 2.5.33/arch/ppc/mm/fault.c~copy_user_atomic	Thu Sep  5 00:44:46 2002
+++ 2.5.33-akpm/arch/ppc/mm/fault.c	Thu Sep  5 00:44:46 2002
@@ -102,7 +102,7 @@ void do_page_fault(struct pt_regs *regs,
 #endif /* !CONFIG_4xx */
 #endif /* CONFIG_XMON || CONFIG_KGDB */
 
-	if (in_interrupt() || mm == NULL) {
+	if (in_atomic() || mm == NULL) {
 		bad_page_fault(regs, address, SIGSEGV);
 		return;
 	}
--- 2.5.33/include/asm-sparc/hardirq.h~copy_user_atomic	Thu Sep  5 00:44:46 2002
+++ 2.5.33-akpm/include/asm-sparc/hardirq.h	Thu Sep  5 00:44:46 2002
@@ -113,6 +113,12 @@ do {                                    
 #define irq_exit()		br_read_unlock(BR_GLOBALIRQ_LOCK)
 #endif
 
+#if CONFIG_PREEMPT
+# define in_atomic()	(preempt_count() != kernel_locked())
+#else
+# define in_atomic()	(preempt_count() != 0)
+#endif
+
 #ifndef CONFIG_SMP
 
 #define synchronize_irq()	barrier()
--- 2.5.33/include/asm-ppc/hardirq.h~copy_user_atomic	Thu Sep  5 00:44:46 2002
+++ 2.5.33-akpm/include/asm-ppc/hardirq.h	Thu Sep  5 00:44:46 2002
@@ -85,8 +85,10 @@ typedef struct {
 #define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
 
 #if CONFIG_PREEMPT
+# define in_atomic()	(preempt_count() != kernel_locked())
 # define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
 #else
+# define in_atomic()	(preempt_count() != 0)
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
 #define irq_exit()							\
--- 2.5.33/include/linux/highmem.h~copy_user_atomic	Thu Sep  5 00:44:46 2002
+++ 2.5.33-akpm/include/linux/highmem.h	Thu Sep  5 00:44:46 2002
@@ -24,8 +24,8 @@ static inline void *kmap(struct page *pa
 
 #define kunmap(page) do { (void) (page); } while (0)
 
-#define kmap_atomic(page,idx)		kmap(page)
-#define kunmap_atomic(page,idx)		kunmap(page)
+#define kmap_atomic(page, idx)		page_address(page)
+#define kunmap_atomic(addr, idx)	do { } while (0)
 
 #endif /* CONFIG_HIGHMEM */
 

.
