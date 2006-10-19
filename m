Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161393AbWJSKZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161393AbWJSKZz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 06:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161389AbWJSKZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 06:25:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6085 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161386AbWJSKZg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 06:25:36 -0400
Message-Id: <20061019102309.235362000@chello.nl>
References: <20061019101722.805147000@chello.nl>
User-Agent: quilt/0.45-1
Date: Thu, 19 Oct 2006 12:17:24 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Cc: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [RFC][PATCH 2/4] mm: pagefault_{disable,enable}()
Content-Disposition: inline; filename=pagefault_disable.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce pagefault_{disable,enable}() and use these where previously
we did manual preempt increments/decrements to make the pagefault handler
do the atomic thing.

Currently they still rely on the increased preempt count, but do not rely
on the disabled preemption, this might go away in the future.

(NOTE: the extra barrier() in pagefault_disable might fix some holes on
       machines which have too many registers for their own good)

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 arch/frv/kernel/futex.c     |    4 ++--
 arch/i386/mm/highmem.c      |   10 ++++------
 arch/mips/mm/highmem.c      |   10 ++++------
 arch/s390/lib/uaccess_std.c |    4 ++--
 arch/sparc/mm/highmem.c     |    8 +++-----
 include/asm-frv/highmem.h   |    5 ++---
 include/asm-generic/futex.h |    4 ++--
 include/asm-i386/futex.h    |    4 ++--
 include/asm-ia64/futex.h    |    4 ++--
 include/asm-mips/futex.h    |    4 ++--
 include/asm-parisc/futex.h  |    4 ++--
 include/asm-powerpc/futex.h |    4 ++--
 include/asm-ppc/highmem.h   |    8 +++-----
 include/asm-sparc64/futex.h |    4 ++--
 include/asm-x86_64/futex.h  |    4 ++--
 include/linux/uaccess.h     |   39 +++++++++++++++++++++++++++++++++++++--
 kernel/futex.c              |   28 ++++++++++++++--------------
 17 files changed, 87 insertions(+), 61 deletions(-)

Index: linux-2.6/arch/frv/kernel/futex.c
===================================================================
--- linux-2.6.orig/arch/frv/kernel/futex.c
+++ linux-2.6/arch/frv/kernel/futex.c
@@ -200,7 +200,7 @@ int futex_atomic_op_inuser(int encoded_o
 	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(int)))
 		return -EFAULT;
 
-	inc_preempt_count();
+	pagefault_disable();
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -223,7 +223,7 @@ int futex_atomic_op_inuser(int encoded_o
 		break;
 	}
 
-	dec_preempt_count();
+	pagefault_enable();
 
 	if (!ret) {
 		switch (cmp) {
Index: linux-2.6/arch/i386/mm/highmem.c
===================================================================
--- linux-2.6.orig/arch/i386/mm/highmem.c
+++ linux-2.6/arch/i386/mm/highmem.c
@@ -32,7 +32,7 @@ void *kmap_atomic(struct page *page, enu
 	unsigned long vaddr;
 
 	/* even !CONFIG_PREEMPT needs this, for in_atomic in do_page_fault */
-	inc_preempt_count();
+	pagefault_disable();
 	if (!PageHighMem(page))
 		return page_address(page);
 
@@ -52,8 +52,7 @@ void kunmap_atomic(void *kvaddr, enum km
 
 #ifdef CONFIG_DEBUG_HIGHMEM
 	if (vaddr >= PAGE_OFFSET && vaddr < (unsigned long)high_memory) {
-		dec_preempt_count();
-		preempt_check_resched();
+		pagefault_enable();
 		return;
 	}
 
@@ -68,8 +67,7 @@ void kunmap_atomic(void *kvaddr, enum km
 	 */
 	kpte_clear_flush(kmap_pte-idx, vaddr);
 
-	dec_preempt_count();
-	preempt_check_resched();
+	pagefault_enable();
 }
 
 /* This is the same as kmap_atomic() but can map memory that doesn't
@@ -80,7 +78,7 @@ void *kmap_atomic_pfn(unsigned long pfn,
 	enum fixed_addresses idx;
 	unsigned long vaddr;
 
-	inc_preempt_count();
+	pagefault_disable();
 
 	idx = type + KM_TYPE_NR*smp_processor_id();
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
Index: linux-2.6/arch/mips/mm/highmem.c
===================================================================
--- linux-2.6.orig/arch/mips/mm/highmem.c
+++ linux-2.6/arch/mips/mm/highmem.c
@@ -39,7 +39,7 @@ void *__kmap_atomic(struct page *page, e
 	unsigned long vaddr;
 
 	/* even !CONFIG_PREEMPT needs this, for in_atomic in do_page_fault */
-	inc_preempt_count();
+	pagefault_disable();
 	if (!PageHighMem(page))
 		return page_address(page);
 
@@ -62,8 +62,7 @@ void __kunmap_atomic(void *kvaddr, enum 
 	enum fixed_addresses idx = type + KM_TYPE_NR*smp_processor_id();
 
 	if (vaddr < FIXADDR_START) { // FIXME
-		dec_preempt_count();
-		preempt_check_resched();
+		pagefault_enable();
 		return;
 	}
 
@@ -78,8 +77,7 @@ void __kunmap_atomic(void *kvaddr, enum 
 	local_flush_tlb_one(vaddr);
 #endif
 
-	dec_preempt_count();
-	preempt_check_resched();
+	pagefault_enable();
 }
 
 #ifndef CONFIG_LIMITED_DMA
@@ -92,7 +90,7 @@ void *kmap_atomic_pfn(unsigned long pfn,
 	enum fixed_addresses idx;
 	unsigned long vaddr;
 
-	inc_preempt_count();
+	pagefault_disable();
 
 	idx = type + KM_TYPE_NR*smp_processor_id();
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
Index: linux-2.6/arch/s390/lib/uaccess_std.c
===================================================================
--- linux-2.6.orig/arch/s390/lib/uaccess_std.c
+++ linux-2.6/arch/s390/lib/uaccess_std.c
@@ -295,7 +295,7 @@ int futex_atomic_op(int op, int __user *
 {
 	int oldval = 0, newval, ret;
 
-	inc_preempt_count();
+	pagefault_disable();
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -321,7 +321,7 @@ int futex_atomic_op(int op, int __user *
 	default:
 		ret = -ENOSYS;
 	}
-	dec_preempt_count();
+	pagefault_enable();
 	*old = oldval;
 	return ret;
 }
Index: linux-2.6/arch/sparc/mm/highmem.c
===================================================================
--- linux-2.6.orig/arch/sparc/mm/highmem.c
+++ linux-2.6/arch/sparc/mm/highmem.c
@@ -35,7 +35,7 @@ void *kmap_atomic(struct page *page, enu
 	unsigned long vaddr;
 
 	/* even !CONFIG_PREEMPT needs this, for in_atomic in do_page_fault */
-	inc_preempt_count();
+	pagefault_disable();
 	if (!PageHighMem(page))
 		return page_address(page);
 
@@ -70,8 +70,7 @@ void kunmap_atomic(void *kvaddr, enum km
 	unsigned long idx = type + KM_TYPE_NR*smp_processor_id();
 
 	if (vaddr < FIXADDR_START) { // FIXME
-		dec_preempt_count();
-		preempt_check_resched();
+		pagefault_enable();
 		return;
 	}
 
@@ -97,8 +96,7 @@ void kunmap_atomic(void *kvaddr, enum km
 #endif
 #endif
 
-	dec_preempt_count();
-	preempt_check_resched();
+	pagefault_enable();
 }
 
 /* We may be fed a pagetable here by ptep_to_xxx and others. */
Index: linux-2.6/include/asm-frv/highmem.h
===================================================================
--- linux-2.6.orig/include/asm-frv/highmem.h
+++ linux-2.6/include/asm-frv/highmem.h
@@ -115,7 +115,7 @@ static inline void *kmap_atomic(struct p
 {
 	unsigned long paddr;
 
-	inc_preempt_count();
+	pagefault_disable();
 	paddr = page_to_phys(page);
 
 	switch (type) {
@@ -170,8 +170,7 @@ static inline void kunmap_atomic(void *k
 	default:
 		BUG();
 	}
-	dec_preempt_count();
-	preempt_check_resched();
+	pagefault_enable();
 }
 
 #endif /* !__ASSEMBLY__ */
Index: linux-2.6/include/asm-generic/futex.h
===================================================================
--- linux-2.6.orig/include/asm-generic/futex.h
+++ linux-2.6/include/asm-generic/futex.h
@@ -21,7 +21,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
 		return -EFAULT;
 
-	inc_preempt_count();
+	pagefault_disable();
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -33,7 +33,7 @@ futex_atomic_op_inuser (int encoded_op, 
 		ret = -ENOSYS;
 	}
 
-	dec_preempt_count();
+	pagefault_enable();
 
 	if (!ret) {
 		switch (cmp) {
Index: linux-2.6/include/asm-i386/futex.h
===================================================================
--- linux-2.6.orig/include/asm-i386/futex.h
+++ linux-2.6/include/asm-i386/futex.h
@@ -56,7 +56,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
 		return -EFAULT;
 
-	inc_preempt_count();
+	pagefault_disable();
 
 	if (op == FUTEX_OP_SET)
 		__futex_atomic_op1("xchgl %0, %2", ret, oldval, uaddr, oparg);
@@ -88,7 +88,7 @@ futex_atomic_op_inuser (int encoded_op, 
 		}
 	}
 
-	dec_preempt_count();
+	pagefault_enable();
 
 	if (!ret) {
 		switch (cmp) {
Index: linux-2.6/include/asm-ia64/futex.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/futex.h
+++ linux-2.6/include/asm-ia64/futex.h
@@ -59,7 +59,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
 		return -EFAULT;
 
-	inc_preempt_count();
+	pagefault_disable();
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -83,7 +83,7 @@ futex_atomic_op_inuser (int encoded_op, 
 		ret = -ENOSYS;
 	}
 
-	dec_preempt_count();
+	pagefault_enable();
 
 	if (!ret) {
 		switch (cmp) {
Index: linux-2.6/include/asm-mips/futex.h
===================================================================
--- linux-2.6.orig/include/asm-mips/futex.h
+++ linux-2.6/include/asm-mips/futex.h
@@ -86,7 +86,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
 		return -EFAULT;
 
-	inc_preempt_count();
+	pagefault_disable();
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -113,7 +113,7 @@ futex_atomic_op_inuser (int encoded_op, 
 		ret = -ENOSYS;
 	}
 
-	dec_preempt_count();
+	pagefault_enable();
 
 	if (!ret) {
 		switch (cmp) {
Index: linux-2.6/include/asm-parisc/futex.h
===================================================================
--- linux-2.6.orig/include/asm-parisc/futex.h
+++ linux-2.6/include/asm-parisc/futex.h
@@ -21,7 +21,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
 		return -EFAULT;
 
-	inc_preempt_count();
+	pagefault_disable();
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -33,7 +33,7 @@ futex_atomic_op_inuser (int encoded_op, 
 		ret = -ENOSYS;
 	}
 
-	dec_preempt_count();
+	pagefault_enable();
 
 	if (!ret) {
 		switch (cmp) {
Index: linux-2.6/include/asm-powerpc/futex.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/futex.h
+++ linux-2.6/include/asm-powerpc/futex.h
@@ -43,7 +43,7 @@ static inline int futex_atomic_op_inuser
 	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
 		return -EFAULT;
 
-	inc_preempt_count();
+	pagefault_disable();
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -65,7 +65,7 @@ static inline int futex_atomic_op_inuser
 		ret = -ENOSYS;
 	}
 
-	dec_preempt_count();
+	pagefault_enable();
 
 	if (!ret) {
 		switch (cmp) {
Index: linux-2.6/include/asm-ppc/highmem.h
===================================================================
--- linux-2.6.orig/include/asm-ppc/highmem.h
+++ linux-2.6/include/asm-ppc/highmem.h
@@ -79,7 +79,7 @@ static inline void *kmap_atomic(struct p
 	unsigned long vaddr;
 
 	/* even !CONFIG_PREEMPT needs this, for in_atomic in do_page_fault */
-	inc_preempt_count();
+	pagefault_disable();
 	if (!PageHighMem(page))
 		return page_address(page);
 
@@ -101,8 +101,7 @@ static inline void kunmap_atomic(void *k
 	unsigned int idx = type + KM_TYPE_NR*smp_processor_id();
 
 	if (vaddr < KMAP_FIX_BEGIN) { // FIXME
-		dec_preempt_count();
-		preempt_check_resched();
+		pagefault_enable();
 		return;
 	}
 
@@ -115,8 +114,7 @@ static inline void kunmap_atomic(void *k
 	pte_clear(&init_mm, vaddr, kmap_pte+idx);
 	flush_tlb_page(NULL, vaddr);
 #endif
-	dec_preempt_count();
-	preempt_check_resched();
+	pagefault_enable();
 }
 
 static inline struct page *kmap_atomic_to_page(void *ptr)
Index: linux-2.6/include/asm-sparc64/futex.h
===================================================================
--- linux-2.6.orig/include/asm-sparc64/futex.h
+++ linux-2.6/include/asm-sparc64/futex.h
@@ -45,7 +45,7 @@ static inline int futex_atomic_op_inuser
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
-	inc_preempt_count();
+	pagefault_disable();
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -67,7 +67,7 @@ static inline int futex_atomic_op_inuser
 		ret = -ENOSYS;
 	}
 
-	dec_preempt_count();
+	pagefault_enable();
 
 	if (!ret) {
 		switch (cmp) {
Index: linux-2.6/include/asm-x86_64/futex.h
===================================================================
--- linux-2.6.orig/include/asm-x86_64/futex.h
+++ linux-2.6/include/asm-x86_64/futex.h
@@ -55,7 +55,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
 		return -EFAULT;
 
-	inc_preempt_count();
+	pagefault_disable();
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -78,7 +78,7 @@ futex_atomic_op_inuser (int encoded_op, 
 		ret = -ENOSYS;
 	}
 
-	dec_preempt_count();
+	pagefault_enable();
 
 	if (!ret) {
 		switch (cmp) {
Index: linux-2.6/include/linux/uaccess.h
===================================================================
--- linux-2.6.orig/include/linux/uaccess.h
+++ linux-2.6/include/linux/uaccess.h
@@ -1,8 +1,43 @@
 #ifndef __LINUX_UACCESS_H__
 #define __LINUX_UACCESS_H__
 
+#include <linux/preempt.h>
 #include <asm/uaccess.h>
 
+/*
+ * These routines enable/disable the pagefault handler in that
+ * it will not take any locks and go straight to the fixup table.
+ *
+ * They have great resemblance to the preempt_disable/enable calls
+ * and in fact they are identical; this is because currently there is
+ * no other way to make the pagefault handlers do this. So we do
+ * disable preemption but we don't necessarily care about that.
+ */
+static inline void pagefault_disable(void)
+{
+	inc_preempt_count();
+	/*
+	 * make sure to have issued the store before a pagefault
+	 * can hit.
+	 */
+	barrier();
+}
+
+static inline void pagefault_enable(void)
+{
+	/*
+	 * make sure to issue those last loads/stores before enabling
+	 * the pagefault handler again.
+	 */
+	barrier();
+	dec_preempt_count();
+	/*
+	 * make sure we do..
+	 */
+	barrier();
+	preempt_check_resched();
+}
+
 #ifndef ARCH_HAS_NOCACHE_UACCESS
 
 static inline unsigned long __copy_from_user_inatomic_nocache(void *to,
@@ -35,9 +70,9 @@ static inline unsigned long __copy_from_
 	({						\
 		long ret;				\
 							\
-		inc_preempt_count();			\
+	 	pagefault_disable();			\
 		ret = __get_user(retval, addr);		\
-		dec_preempt_count();			\
+		pagefault_enable();			\
 		ret;					\
 	})
 
Index: linux-2.6/kernel/futex.c
===================================================================
--- linux-2.6.orig/kernel/futex.c
+++ linux-2.6/kernel/futex.c
@@ -282,9 +282,9 @@ static inline int get_futex_value_locked
 {
 	int ret;
 
-	inc_preempt_count();
+	pagefault_disable();
 	ret = __copy_from_user_inatomic(dest, from, sizeof(u32));
-	dec_preempt_count();
+	pagefault_enable();
 
 	return ret ? -EFAULT : 0;
 }
@@ -585,9 +585,9 @@ static int wake_futex_pi(u32 __user *uad
 	if (!(uval & FUTEX_OWNER_DIED)) {
 		newval = FUTEX_WAITERS | new_owner->pid;
 
-		inc_preempt_count();
+		pagefault_disable();
 		curval = futex_atomic_cmpxchg_inatomic(uaddr, uval, newval);
-		dec_preempt_count();
+		pagefault_enable();
 		if (curval == -EFAULT)
 			return -EFAULT;
 		if (curval != uval)
@@ -618,9 +618,9 @@ static int unlock_futex_pi(u32 __user *u
 	 * There is no waiter, so we unlock the futex. The owner died
 	 * bit has not to be preserved here. We are the owner:
 	 */
-	inc_preempt_count();
+	pagefault_disable();
 	oldval = futex_atomic_cmpxchg_inatomic(uaddr, uval, 0);
-	dec_preempt_count();
+	pagefault_enable();
 
 	if (oldval == -EFAULT)
 		return oldval;
@@ -1158,9 +1158,9 @@ static int futex_lock_pi(u32 __user *uad
 	 */
 	newval = current->pid;
 
-	inc_preempt_count();
+	pagefault_disable();
 	curval = futex_atomic_cmpxchg_inatomic(uaddr, 0, newval);
-	dec_preempt_count();
+	pagefault_enable();
 
 	if (unlikely(curval == -EFAULT))
 		goto uaddr_faulted;
@@ -1183,9 +1183,9 @@ static int futex_lock_pi(u32 __user *uad
 	uval = curval;
 	newval = uval | FUTEX_WAITERS;
 
-	inc_preempt_count();
+	pagefault_disable();
 	curval = futex_atomic_cmpxchg_inatomic(uaddr, uval, newval);
-	dec_preempt_count();
+	pagefault_enable();
 
 	if (unlikely(curval == -EFAULT))
 		goto uaddr_faulted;
@@ -1215,10 +1215,10 @@ static int futex_lock_pi(u32 __user *uad
 			newval = current->pid |
 				FUTEX_OWNER_DIED | FUTEX_WAITERS;
 
-			inc_preempt_count();
+			pagefault_disable();
 			curval = futex_atomic_cmpxchg_inatomic(uaddr,
 							       uval, newval);
-			dec_preempt_count();
+			pagefault_enable();
 
 			if (unlikely(curval == -EFAULT))
 				goto uaddr_faulted;
@@ -1390,9 +1390,9 @@ retry_locked:
 	 * anyone else up:
 	 */
 	if (!(uval & FUTEX_OWNER_DIED)) {
-		inc_preempt_count();
+		pagefault_disable();
 		uval = futex_atomic_cmpxchg_inatomic(uaddr, current->pid, 0);
-		dec_preempt_count();
+		pagefault_enable();
 	}
 
 	if (unlikely(uval == -EFAULT))

--

