Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbUCEC4U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 21:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbUCEC4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 21:56:20 -0500
Received: from ozlabs.org ([203.10.76.45]:32941 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262163AbUCEC4J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 21:56:09 -0500
Date: Fri, 5 Mar 2004 10:54:01 +0800
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: Convert ppc64 mm_context_t to a struct
Message-ID: <20040305025401.GE31852@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
	linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply.  The patch below converts the mm_context_t on
ppc64 to be a struct.  This lets us separate the low_hpages flag into
a separate field rather than folding it into the actual context id.
That makes things neater, since the flag is conceptually separate and
has, for example, should be propogate across a fork whereas the
context ID obviously isn't.  The mm_context_id is the only place to
put arch-specific information in the mm_struct.

This patch will also make some interesting extensions to the hugepage
support much easier, such as allowing dynamic resizing of the hugepage
address space, or using special pagetables for hugepages.

mmu-context-struct (2.6.0):
   This patch converts the mmu_context variable to a structure, making the
actual context number and the low_hpages flag separate fields.  This makes
hugepage support neater, and will be needed for extensions to the hugepage
support such as dynamically resizing the hugepage address space.

Index: working-2.6/arch/ppc64/kernel/stab.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/stab.c	2004-03-02 13:56:14.000000000 +1100
+++ working-2.6/arch/ppc64/kernel/stab.c	2004-03-02 14:54:44.534690496 +1100
@@ -184,13 +184,13 @@
 	/* Kernel or user address? */
 	if (REGION_ID(ea) >= KERNEL_REGION_ID) {
 		vsid = get_kernel_vsid(ea);
-		context = REGION_ID(ea);
+		context = KERNEL_CONTEXT(ea);
 	} else {
 		if (!current->mm)
 			return 1;
 
 		context = current->mm->context;
-		vsid = get_vsid(context, ea);
+		vsid = get_vsid(context.id, ea);
 	}
 
 	esid = GET_ESID(ea);
@@ -223,7 +223,7 @@
 
 	if (!IS_VALID_EA(pc) || (REGION_ID(pc) >= KERNEL_REGION_ID))
 		return;
-	vsid = get_vsid(mm->context, pc);
+	vsid = get_vsid(mm->context.id, pc);
 	__ste_allocate(pc_esid, vsid);
 
 	if (pc_esid == stack_esid)
@@ -231,7 +231,7 @@
 
 	if (!IS_VALID_EA(stack) || (REGION_ID(stack) >= KERNEL_REGION_ID))
 		return;
-	vsid = get_vsid(mm->context, stack);
+	vsid = get_vsid(mm->context.id, stack);
 	__ste_allocate(stack_esid, vsid);
 
 	if (pc_esid == unmapped_base_esid || stack_esid == unmapped_base_esid)
@@ -240,7 +240,7 @@
 	if (!IS_VALID_EA(unmapped_base) ||
 	    (REGION_ID(unmapped_base) >= KERNEL_REGION_ID))
 		return;
-	vsid = get_vsid(mm->context, unmapped_base);
+	vsid = get_vsid(mm->context.id, unmapped_base);
 	__ste_allocate(unmapped_base_esid, vsid);
 
 	/* Order update */
@@ -406,14 +406,14 @@
 
 	/* Kernel or user address? */
 	if (REGION_ID(ea) >= KERNEL_REGION_ID) {
-		context = REGION_ID(ea);
+		context = KERNEL_CONTEXT(ea);
 		vsid = get_kernel_vsid(ea);
 	} else {
 		if (unlikely(!current->mm))
 			return 1;
 
 		context = current->mm->context;
-		vsid = get_vsid(context, ea);
+		vsid = get_vsid(context.id, ea);
 	}
 
 	esid = GET_ESID(ea);
@@ -444,7 +444,7 @@
 
 	if (!IS_VALID_EA(pc) || (REGION_ID(pc) >= KERNEL_REGION_ID))
 		return;
-	vsid = get_vsid(mm->context, pc);
+	vsid = get_vsid(mm->context.id, pc);
 	__slb_allocate(pc_esid, vsid, mm->context);
 
 	if (pc_esid == stack_esid)
@@ -452,7 +452,7 @@
 
 	if (!IS_VALID_EA(stack) || (REGION_ID(stack) >= KERNEL_REGION_ID))
 		return;
-	vsid = get_vsid(mm->context, stack);
+	vsid = get_vsid(mm->context.id, stack);
 	__slb_allocate(stack_esid, vsid, mm->context);
 
 	if (pc_esid == unmapped_base_esid || stack_esid == unmapped_base_esid)
@@ -461,7 +461,7 @@
 	if (!IS_VALID_EA(unmapped_base) ||
 	    (REGION_ID(unmapped_base) >= KERNEL_REGION_ID))
 		return;
-	vsid = get_vsid(mm->context, unmapped_base);
+	vsid = get_vsid(mm->context.id, unmapped_base);
 	__slb_allocate(unmapped_base_esid, vsid, mm->context);
 }
 
Index: working-2.6/arch/ppc64/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/hugetlbpage.c	2004-02-02 10:44:47.000000000 +1100
+++ working-2.6/arch/ppc64/mm/hugetlbpage.c	2004-03-02 14:54:44.545688824 +1100
@@ -244,7 +244,7 @@
 	struct vm_area_struct *vma;
 	unsigned long addr;
 
-	if (mm->context & CONTEXT_LOW_HPAGES)
+	if (mm->context.low_hpages)
 		return 0; /* The window is already open */
 	
 	/* Check no VMAs are in the region */
@@ -281,7 +281,7 @@
 
 	/* FIXME: do we need to scan for PTEs too? */
 
-	mm->context |= CONTEXT_LOW_HPAGES;
+	mm->context.low_hpages = 1;
 
 	/* the context change must make it to memory before the slbia,
 	 * so that further SLB misses do the right thing. */
@@ -589,7 +589,6 @@
 	}
 }
 
-
 unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 					unsigned long len, unsigned long pgoff,
 					unsigned long flags)
@@ -778,7 +777,7 @@
 	BUG_ON(hugepte_bad(pte));
 	BUG_ON(!in_hugepage_area(context, ea));
 
-	vsid = get_vsid(context, ea);
+	vsid = get_vsid(context.id, ea);
 
 	va = (vsid << 28) | (ea & 0x0fffffff);
 	vpn = va >> LARGE_PAGE_SHIFT;
Index: working-2.6/arch/ppc64/mm/init.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/init.c	2004-03-02 13:56:14.000000000 +1100
+++ working-2.6/arch/ppc64/mm/init.c	2004-03-02 14:54:44.548688368 +1100
@@ -794,7 +794,7 @@
 	if (!ptep)
 		return;
 
-	vsid = get_vsid(vma->vm_mm->context, ea);
+	vsid = get_vsid(vma->vm_mm->context.id, ea);
 
 	tmp = cpumask_of_cpu(smp_processor_id());
 	if (cpus_equal(vma->vm_mm->cpu_vm_mask, tmp))
Index: working-2.6/arch/ppc64/mm/hash_utils.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/hash_utils.c	2004-03-02 13:56:14.000000000 +1100
+++ working-2.6/arch/ppc64/mm/hash_utils.c	2004-03-02 14:54:44.551687912 +1100
@@ -265,7 +265,7 @@
 		if (mm == NULL)
 			return 1;
 
-		vsid = get_vsid(mm->context, ea);
+		vsid = get_vsid(mm->context.id, ea);
 		break;
 	case IO_REGION_ID:
 		mm = &ioremap_mm;
Index: working-2.6/arch/ppc64/mm/tlb.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/tlb.c	2004-03-02 13:56:14.000000000 +1100
+++ working-2.6/arch/ppc64/mm/tlb.c	2004-03-02 15:01:00.650612248 +1100
@@ -62,7 +62,7 @@
 	addr = ptep_to_address(ptep);
 
 	if (REGION_ID(addr) == USER_REGION_ID)
-		context = mm->context;
+		context = mm->context.id;
 	i = batch->index;
 
 	/*
Index: working-2.6/include/asm-ppc64/mmu.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/mmu.h	2004-02-02 10:44:49.000000000 +1100
+++ working-2.6/include/asm-ppc64/mmu.h	2004-03-02 14:54:44.561686392 +1100
@@ -18,15 +18,25 @@
 
 #ifndef __ASSEMBLY__
 
-/* Default "unsigned long" context */
-typedef unsigned long mm_context_t;
+/* Time to allow for more things here */
+typedef unsigned long mm_context_id_t;
+typedef struct {
+	mm_context_id_t id;
+#ifdef CONFIG_HUGETLB_PAGE
+	int low_hpages;
+#endif
+} mm_context_t;
 
 #ifdef CONFIG_HUGETLB_PAGE
-#define CONTEXT_LOW_HPAGES	(1UL<<63)
+#define KERNEL_LOW_HPAGES	.low_hpages = 0,
 #else
-#define CONTEXT_LOW_HPAGES	0
+#define KERNEL_LOW_HPAGES
 #endif
 
+#define KERNEL_CONTEXT(ea) ({ \
+		mm_context_t ctx = { .id = REGION_ID(ea), KERNEL_LOW_HPAGES}; \
+		ctx; })
+
 /*
  * Hardware Segment Lookaside Buffer Entry
  * This structure has been padded out to two 64b doublewords (actual SLBE's are
Index: working-2.6/include/asm-ppc64/mmu_context.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/mmu_context.h	2004-02-28 23:14:34.000000000 +1100
+++ working-2.6/include/asm-ppc64/mmu_context.h	2004-03-02 14:54:44.569685176 +1100
@@ -52,7 +52,7 @@
 	long head;
 	long tail;
 	long size;
-	mm_context_t elements[LAST_USER_CONTEXT];
+	mm_context_id_t elements[LAST_USER_CONTEXT];
 };
 
 extern struct mmu_context_queue_t mmu_context_queue;
@@ -83,7 +83,6 @@
 	long head;
 	unsigned long flags;
 	/* This does the right thing across a fork (I hope) */
-	unsigned long low_hpages = mm->context & CONTEXT_LOW_HPAGES;
 
 	spin_lock_irqsave(&mmu_context_queue.lock, flags);
 
@@ -93,8 +92,7 @@
 	}
 
 	head = mmu_context_queue.head;
-	mm->context = mmu_context_queue.elements[head];
-	mm->context |= low_hpages;
+	mm->context.id = mmu_context_queue.elements[head];
 
 	head = (head < LAST_USER_CONTEXT-1) ? head+1 : 0;
 	mmu_context_queue.head = head;
@@ -132,8 +130,7 @@
 #endif
 
 	mmu_context_queue.size++;
-	mmu_context_queue.elements[index] =
-		mm->context & ~CONTEXT_LOW_HPAGES;
+	mmu_context_queue.elements[index] = mm->context.id;
 
 	spin_unlock_irqrestore(&mmu_context_queue.lock, flags);
 }
@@ -212,8 +209,6 @@
 {
 	unsigned long ordinal, vsid;
 
-	context &= ~CONTEXT_LOW_HPAGES;
-
 	ordinal = (((ea >> 28) & 0x1fffff) * LAST_USER_CONTEXT) | context;
 	vsid = (ordinal * VSID_RANDOMIZER) & VSID_MASK;
 
Index: working-2.6/include/asm-ppc64/page.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/page.h	2004-03-02 13:56:14.000000000 +1100
+++ working-2.6/include/asm-ppc64/page.h	2004-03-02 14:54:44.571684872 +1100
@@ -32,6 +32,7 @@
 /* For 64-bit processes the hugepage range is 1T-1.5T */
 #define TASK_HPAGE_BASE 	(0x0000010000000000UL)
 #define TASK_HPAGE_END 	(0x0000018000000000UL)
+
 /* For 32-bit processes the hugepage range is 2-3G */
 #define TASK_HPAGE_BASE_32	(0x80000000UL)
 #define TASK_HPAGE_END_32	(0xc0000000UL)
@@ -39,7 +40,7 @@
 #define ARCH_HAS_HUGEPAGE_ONLY_RANGE
 #define is_hugepage_only_range(addr, len) \
 	( ((addr > (TASK_HPAGE_BASE-len)) && (addr < TASK_HPAGE_END)) || \
-	  ((current->mm->context & CONTEXT_LOW_HPAGES) && \
+	  (current->mm->context.low_hpages && \
 	   (addr > (TASK_HPAGE_BASE_32-len)) && (addr < TASK_HPAGE_END_32)) )
 #define hugetlb_free_pgtables free_pgtables
 #define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
@@ -47,7 +48,7 @@
 #define in_hugepage_area(context, addr) \
 	((cur_cpu_spec->cpu_features & CPU_FTR_16M_PAGE) && \
 	 ((((addr) >= TASK_HPAGE_BASE) && ((addr) < TASK_HPAGE_END)) || \
-	  (((context) & CONTEXT_LOW_HPAGES) && \
+	  ((context).low_hpages && \
 	   (((addr) >= TASK_HPAGE_BASE_32) && ((addr) < TASK_HPAGE_END_32)))))
 
 #else /* !CONFIG_HUGETLB_PAGE */


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
