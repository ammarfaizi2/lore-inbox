Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbUDHGT6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 02:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbUDHGT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 02:19:58 -0400
Received: from ozlabs.org ([203.10.76.45]:57068 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261611AbUDHGTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 02:19:37 -0400
Date: Thu, 8 Apr 2004 16:16:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>
Subject: [PPC64] Allow hugepages anywhere in low 4GB
Message-ID: <20040408061631.GA16046@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linuxppc64-dev@lists.linuxppc.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply:

On PPC64, to deal with the restrictions imposed by the PPC MMU's
segment design, hugepages are only allowed to be mapping in two fixed
address ranges, one 2-3G (for use by 32-bit processes) and one 1-1.5T
(for use in 64-bit processes).  This is quite limiting, particularly
for 32-bit processes which want to use a lot of large page memory.

This patch relaxes this restriction, and allows any of the low 16
segments (i.e. those below 4G) to be individually switched over to
allow hugepage mappings (provided the segment does not already have
any normal page mappings).  The 1-1.5T fixed range for 64-bit
processes remains.

[This patch depends on the previous PPC64 hugepage patches I've sent
in the last few days, in particular the fix for freeing PTE pages, and
the fix to is_aligned_hugetlb_range().  It does not depend on the COW
patch]

Index: working-2.6/arch/ppc64/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/hugetlbpage.c	2004-04-08 12:01:17.000000000 +1000
+++ working-2.6/arch/ppc64/mm/hugetlbpage.c	2004-04-08 16:10:19.101797456 +1000
@@ -240,32 +240,26 @@
 {
 	asm volatile ("isync; slbia; isync":::"memory");
 }
-
-/* Activate the low hpage region for 32bit processes.  mmap_sem must
- * be held*/
-static int open_32bit_htlbpage_range(struct mm_struct *mm)
+  
+static int prepare_low_seg_for_htlb(struct mm_struct *mm, unsigned long seg)
 {
+	unsigned long start = seg << SID_SHIFT;
+	unsigned long end = (seg+1) << SID_SHIFT;
 	struct vm_area_struct *vma;
 	unsigned long addr;
 	struct mmu_gather *tlb;
 
-	if (mm->context.low_hpages)
-		return 0; /* The window is already open */
-	
-	/* Check no VMAs are in the region */
-	vma = find_vma(mm, TASK_HPAGE_BASE_32);
+	BUG_ON(seg >= 16);
 
-	if (vma && (vma->vm_start < TASK_HPAGE_END_32)) {
-		printk(KERN_DEBUG "Low HTLB region busy: PID=%d  vma @ %lx-%lx\n",
-		       current->pid, vma->vm_start, vma->vm_end);
+	/* Check no VMAs are in the region */
+	vma = find_vma(mm, start);
+	if (vma && (vma->vm_start < end))
 		return -EBUSY;
-	}
 
 	/* Clean up any leftover PTE pages in the region */
 	spin_lock(&mm->page_table_lock);
 	tlb = tlb_gather_mmu(mm, 0);
-	for (addr = TASK_HPAGE_BASE_32; addr < TASK_HPAGE_END_32;
-	     addr += PMD_SIZE) {
+	for (addr = start; addr < end; addr += PMD_SIZE) {
 		pgd_t *pgd = pgd_offset(mm, addr);
 		pmd_t *pmd;
 		struct page *page;
@@ -293,15 +287,29 @@
 		pgtable_remove_rmap(page);
 		pte_free_tlb(tlb, page);
 	}
-	tlb_finish_mmu(tlb, TASK_HPAGE_BASE_32, TASK_HPAGE_END_32);
+	tlb_finish_mmu(tlb, start, end);
 	spin_unlock(&mm->page_table_lock);
 
-	mm->context.low_hpages = 1;
+	return 0;
+}
+
+static int open_low_hpage_segs(struct mm_struct *mm, u16 newsegs)
+{
+	unsigned long i;
+
+	newsegs &= ~(mm->context.htlb_segs);
+	if (! newsegs)
+		return 0; /* The segments we want are already open */
 
+	for (i = 0; i < 16; i++)
+		if ((1 << i) & newsegs)
+			if (prepare_low_seg_for_htlb(mm, i) != 0)
+				return -EBUSY;
+
+	mm->context.htlb_segs |= newsegs;
 	/* the context change must make it to memory before the slbia,
 	 * so that further SLB misses do the right thing. */
 	mb();
-
 	on_each_cpu(do_slbia, NULL, 0, 1);
 
 	return 0;
@@ -311,8 +319,18 @@
 {
 	if (within_hugepage_high_range(addr, len))
 		return 0;
-	else if (within_hugepage_low_range(addr, len))
-		return open_32bit_htlbpage_range(current->mm);
+	else if ((addr < 0x100000000) && ((addr+len) < 0x100000000)) {
+		int err;
+		/* Yes, we need both tests, in case addr+len overflows
+		 * 64-bit arithmetic */
+		err = open_low_hpage_segs(current->mm,
+					  LOW_ESID_MASK(addr, len));
+		if (err)
+			printk(KERN_DEBUG "prepare_hugepage_range(%lx, %lx)"
+			       " failed (segs: 0x%04hx)\n", addr, len,
+			       LOW_ESID_MASK(addr, len));
+		return err;
+	}
 
 	return -EINVAL;
 }
@@ -559,7 +577,7 @@
 
 /* Because we have an exclusive hugepage region which lies within the
  * normal user address space, we have to take special measures to make
- * non-huge mmap()s evade the hugepage reserved region. */
+ * non-huge mmap()s evade the hugepage reserved regions. */
 unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
 				     unsigned long len, unsigned long pgoff,
 				     unsigned long flags)
@@ -574,36 +592,29 @@
 	if (addr) {
 		addr = PAGE_ALIGN(addr);
 		vma = find_vma(mm, addr);
-		if (TASK_SIZE - len >= addr &&
-		    (!vma || addr + len <= vma->vm_start) &&
-		    !is_hugepage_only_range(addr,len))
+		if (((TASK_SIZE - len) >= addr)
+		    && (!vma || (addr+len) <= vma->vm_start)
+		    && !is_hugepage_only_range(addr,len))
 			return addr;
 	}
 	start_addr = addr = mm->free_area_cache;
 
 full_search:
-	for (vma = find_vma(mm, addr); ; vma = vma->vm_next) {
-		/* At this point:  (!vma || addr < vma->vm_end). */
-		if (TASK_SIZE - len < addr) {
-			/*
-			 * Start a new search - just in case we missed
-			 * some holes.
-			 */
-			if (start_addr != TASK_UNMAPPED_BASE) {
-				start_addr = addr = TASK_UNMAPPED_BASE;
-				goto full_search;
-			}
-			return -ENOMEM;
+	vma = find_vma(mm, addr);
+	while (TASK_SIZE - len >= addr) {
+		BUG_ON(vma && (addr >= vma->vm_end));
+
+		if (touches_hugepage_low_range(addr, len)) {
+			addr = ALIGN(addr+1, 1<<SID_SHIFT);
+			vma = find_vma(mm, addr);
+			continue;
+		}
+		if (touches_hugepage_high_range(addr, len)) {
+			addr = TASK_HPAGE_END;
+			vma = find_vma(mm, addr);
+			continue;
 		}
 		if (!vma || addr + len <= vma->vm_start) {
-			if (is_hugepage_only_range(addr, len)) {
-				if (addr < TASK_HPAGE_END_32)
-					addr = TASK_HPAGE_END_32;
-				else
-					addr = TASK_HPAGE_END;
-
-				continue;
-			}
 			/*
 			 * Remember the place where we stopped the search:
 			 */
@@ -611,16 +622,70 @@
 			return addr;
 		}
 		addr = vma->vm_end;
+		vma = vma->vm_next;
+	}
+
+	/* Make sure we didn't miss any holes */
+	if (start_addr != TASK_UNMAPPED_BASE) {
+		start_addr = addr = TASK_UNMAPPED_BASE;
+		goto full_search;
+	}
+	return -ENOMEM;
+}
+
+static unsigned long htlb_get_low_area(unsigned long len, u16 segmask)
+{
+	unsigned long addr = 0;
+	struct vm_area_struct *vma;
+
+	vma = find_vma(current->mm, addr);
+	while (addr + len <= 0x100000000UL) {
+		BUG_ON(vma && (addr >= vma->vm_end)); /* invariant */
+
+		if (! __within_hugepage_low_range(addr, len, segmask)) {
+			addr = ALIGN(addr+1, 1<<SID_SHIFT);
+			vma = find_vma(current->mm, addr);
+			continue;
+		}
+
+		if (!vma || (addr + len) <= vma->vm_start)
+			return addr;
+		addr = ALIGN(vma->vm_end, HPAGE_SIZE);
+		/* Depending on segmask this might not be a confirmed
+		 * hugepage region, so the ALIGN could have skipped
+		 * some VMAs */
+		vma = find_vma(current->mm, addr);
+	}
+
+	return -ENOMEM;
+}
+
+static unsigned long htlb_get_high_area(unsigned long len)
+{
+	unsigned long addr = TASK_HPAGE_BASE;
+	struct vm_area_struct *vma;
+	
+	vma = find_vma(current->mm, addr);
+	for (vma = find_vma(current->mm, addr); 
+	     addr + len <= TASK_HPAGE_END;
+	     vma = vma->vm_next) {
+		BUG_ON(vma && (addr >= vma->vm_end)); /* invariant */
+		BUG_ON(! within_hugepage_high_range(addr, len));
+		
+		if (!vma || (addr + len) <= vma->vm_start)
+			return addr;
+		addr = ALIGN(vma->vm_end, HPAGE_SIZE);
+		/* Because we're in a hugepage region, this alignment
+		 * should not skip us over any VMAs */
 	}
+
+	return -ENOMEM;
 }
 
 unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 					unsigned long len, unsigned long pgoff,
 					unsigned long flags)
 {
-	struct vm_area_struct *vma;
-	unsigned long base, end;
-
 	if (len & ~HPAGE_MASK)
 		return -EINVAL;
 
@@ -628,34 +693,30 @@
 		return -EINVAL;
 
 	if (test_thread_flag(TIF_32BIT)) {
-		int err;
-
-		err = open_32bit_htlbpage_range(current->mm);
-		if (err)
-			return err; /* Should this just be EINVAL? */
+		int lastshift = 0;
+		u16 segmask, cursegs = current->mm->context.htlb_segs;
 
-		base = TASK_HPAGE_BASE_32;
-		end = TASK_HPAGE_END_32;
-	} else {
-		base = TASK_HPAGE_BASE;
-		end = TASK_HPAGE_END;
-	}
-	
-	if (!in_hugepage_area(current->mm->context, addr) 
-	    || (addr & (HPAGE_SIZE - 1)))
-		addr = base;
-
-	for (vma = find_vma(current->mm, addr); ; vma = vma->vm_next) {
-		/* At this point:  (!vma || addr < vma->vm_end). */
-		if (addr + len > end)
-			return -ENOMEM;
-		if (!vma || (addr + len) <= vma->vm_start)
+		/* First see if we can do the mapping in the existing
+		 * low hpage segments */
+		addr = htlb_get_low_area(len, cursegs);
+		if (addr != -ENOMEM)
 			return addr;
-		addr = ALIGN(vma->vm_end, HPAGE_SIZE);
 
-		/* Because we're in an exclusively hugepage region,
-		 * this alignment shouldn't have skipped over any
-		 * other vmas */
+		for (segmask = LOW_ESID_MASK(0x100000000UL-len, len);
+		     ! lastshift; segmask >>=1) {
+			if (segmask & 1)
+				lastshift = 1;
+
+			addr = htlb_get_low_area(len, cursegs | segmask);
+			if ((addr != -ENOMEM)
+			    && open_low_hpage_segs(current->mm, segmask) == 0)
+				return addr;
+		}
+		printk(KERN_DEBUG "hugetlb_get_unmapped_area() unable to open"
+		       " enough segments\n");
+		return -ENOMEM;
+	} else {
+		return htlb_get_high_area(len);
 	}
 }
 
Index: working-2.6/include/asm-ppc64/mmu.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/mmu.h	2004-03-08 11:07:08.000000000 +1100
+++ working-2.6/include/asm-ppc64/mmu.h	2004-04-08 16:10:19.104797000 +1000
@@ -23,12 +23,12 @@
 typedef struct {
 	mm_context_id_t id;
 #ifdef CONFIG_HUGETLB_PAGE
-	int low_hpages;
+	u16 htlb_segs; /* bitmask */
 #endif
 } mm_context_t;
 
 #ifdef CONFIG_HUGETLB_PAGE
-#define KERNEL_LOW_HPAGES	.low_hpages = 0,
+#define KERNEL_LOW_HPAGES	.htlb_segs = 0,
 #else
 #define KERNEL_LOW_HPAGES
 #endif
Index: working-2.6/include/asm-ppc64/page.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/page.h	2004-04-08 12:01:17.000000000 +1000
+++ working-2.6/include/asm-ppc64/page.h	2004-04-08 16:10:19.106796696 +1000
@@ -22,6 +22,10 @@
 #define PAGE_MASK	(~(PAGE_SIZE-1))
 #define PAGE_OFFSET_MASK (PAGE_SIZE-1)
 
+#define SID_SHIFT       28
+#define SID_MASK        0xfffffffff
+#define GET_ESID(x)     (((x) >> SID_SHIFT) & SID_MASK)
+
 #ifdef CONFIG_HUGETLB_PAGE
 
 #define HPAGE_SHIFT	24
@@ -33,34 +37,36 @@
 #define TASK_HPAGE_BASE 	(0x0000010000000000UL)
 #define TASK_HPAGE_END 	(0x0000018000000000UL)
 
-/* For 32-bit processes the hugepage range is 2-3G */
-#define TASK_HPAGE_BASE_32	(0x80000000UL)
-#define TASK_HPAGE_END_32	(0xc0000000UL)
+#define LOW_ESID_MASK(addr, len)	(((1U << (GET_ESID(addr+len-1)+1)) \
+	   	                	- (1U << GET_ESID(addr))) & 0xffff)
 
 #define ARCH_HAS_HUGEPAGE_ONLY_RANGE
 #define ARCH_HAS_PREPARE_HUGEPAGE_RANGE
 
 #define touches_hugepage_low_range(addr, len) \
-	(((addr) > (TASK_HPAGE_BASE_32-(len))) && ((addr) < TASK_HPAGE_END_32))
+	(LOW_ESID_MASK((addr), (len)) & current->mm->context.htlb_segs)
 #define touches_hugepage_high_range(addr, len) \
 	(((addr) > (TASK_HPAGE_BASE-(len))) && ((addr) < TASK_HPAGE_END))
-#define within_hugepage_low_range(addr, len) (((addr) >= TASK_HPAGE_BASE_32) \
-	  && ((addr)+(len) <= TASK_HPAGE_END_32) && ((addr)+(len) >= (addr)))
+
+#define __within_hugepage_low_range(addr, len, segmask) \
+	((LOW_ESID_MASK((addr), (len)) | (segmask)) == (segmask))
+#define within_hugepage_low_range(addr, len) \
+	__within_hugepage_low_range((addr), (len), \
+				    current->mm->context.htlb_segs)
 #define within_hugepage_high_range(addr, len) (((addr) >= TASK_HPAGE_BASE) \
 	  && ((addr)+(len) <= TASK_HPAGE_END) && ((addr)+(len) >= (addr)))
 
 #define is_hugepage_only_range(addr, len) \
 	(touches_hugepage_high_range((addr), (len)) || \
-	 (current->mm->context.low_hpages \
-	  && touches_hugepage_low_range((addr), (len))))
+	  touches_hugepage_low_range((addr), (len)))
 #define hugetlb_free_pgtables free_pgtables
 #define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
 
 #define in_hugepage_area(context, addr) \
 	((cur_cpu_spec->cpu_features & CPU_FTR_16M_PAGE) && \
-	 ((((addr) >= TASK_HPAGE_BASE) && ((addr) < TASK_HPAGE_END)) || \
-	  ((context).low_hpages && \
-	   (((addr) >= TASK_HPAGE_BASE_32) && ((addr) < TASK_HPAGE_END_32)))))
+	 ( (((addr) >= TASK_HPAGE_BASE) && ((addr) < TASK_HPAGE_END)) || \
+	   ( ((addr) < 0x100000000L) && \
+	     ((1 << GET_ESID(addr)) & (context).htlb_segs) ) ) )
 
 #else /* !CONFIG_HUGETLB_PAGE */
 
@@ -68,10 +74,6 @@
 
 #endif /* !CONFIG_HUGETLB_PAGE */
 
-#define SID_SHIFT       28
-#define SID_MASK        0xfffffffff
-#define GET_ESID(x)     (((x) >> SID_SHIFT) & SID_MASK)
-
 /* align addr on a size boundary - adjust address up/down if needed */
 #define _ALIGN_UP(addr,size)	(((addr)+((size)-1))&(~((size)-1)))
 #define _ALIGN_DOWN(addr,size)	((addr)&(~((size)-1)))


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
