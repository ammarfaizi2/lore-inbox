Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbVFTUGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbVFTUGk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 16:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVFTUGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 16:06:40 -0400
Received: from alog0149.analogic.com ([208.224.220.164]:5001 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261544AbVFTTxg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 15:53:36 -0400
Date: Mon, 20 Jun 2005 15:53:34 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Linux-2.6.12 memory mapping broken
Message-ID: <Pine.LNX.4.61.0506201548150.5317@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


To the memory expert that made the massive changes to mm/memory.c:

This shows debugging info from a driver that allocates and
memory-maps memory the following way:

(1) The kernel is told it has only `mem=768m` of memory.
(2) The number of kernel pages is found from variable 'num_physpages'
(3) DMA buffer allocation starts at (num_physpages * PAGE_SIZE) +
     PAGE_SIZE.
(4) The remaining pages are ioremap_nocache() by the driver.
(4) The number of remaining writable pages are determined by the code
     trying to write/read from the end of each new ioremap_nocache() pages.
(5) In this case, we have (0x04004000 >> PAGE_SHIFT) writable pages
or 0x04004000 bytes available.

Code up to linux-2.6.11.9 allowed me to memory-map this to user-space
so I could DMA data directly to user-space, a mandatory customer
requirement.

Memory allocation is 18656 bytes
len = 67125248 (04004000)
ACPI: PCI interrupt 0000:02:03.0[A] -> GSI 19 (level, low) -> IRQ 19
Analogic Corp DLB : Found 000012d6 (00008004) using IRQ 19
PCI: Enabling device 0000:02:03.0 (0106 -> 0107)
ACPI: PCI interrupt 0000:02:03.0[A] -> GSI 19 (level, low) -> IRQ 19
Analogic Corp DLB : Installed 12d6:8004 IRQ19 slot:0203 DMA:30001000
Analogic Corp DLB : Initialization complete
DIF =  74900  ref = 139621
Analogic Corp DLB : Start sequencer
ioctl
DATALINK_VERS
ioctl
DATALINK_FPGA
ioctl
DATALINK_GETPHYS
ioctl
DATALINK_GETMEMLEN
mmap
UNIQUE.dma.len = 04001fe0
vma->vm_end-vma->vm_start=04002000
About to execute remap_pfn_range
     vma->vm_start = 20000000
      base address = 30003000
            length = 04001fe0 >> PAGE_SHIFT
vma->vm_page_prot = 0000003f
    returned value = 0
ioctl
DATALINK_SET_ADDRESS
ioctl
DATALINK_GET_MODE

The above worked.

Code in linux-2.6.12 fails with the following (remap_pfn_range
gets the exact same values):

Memory allocation is 18656 bytes
len = 67125248 (04004000)
ACPI: PCI Interrupt 0000:02:03.0[A] -> GSI 19 (level, low) -> IRQ 19
Analogic Corp DLB : Found 000012d6 (00008004) using IRQ 19
PCI: Enabling device 0000:02:03.0 (0106 -> 0107)
ACPI: PCI Interrupt 0000:02:03.0[A] -> GSI 19 (level, low) -> IRQ 19
Analogic Corp DLB : Installed 12d6:8004 IRQ19 slot:0203 DMA:30001000
Analogic Corp DLB : Initialization complete
DIF =  60144  ref = 139622
Analogic Corp DLB : Start sequencer
ioctl
DATALINK_VERS
ioctl
DATALINK_FPGA
ioctl
DATALINK_GETPHYS
ioctl
DATALINK_GETMEMLEN
mmap
UNIQUE.dma.len = 04001fe0
vma->vm_end-vma->vm_start=04002000
About to execute remap_pfn_range
     vma->vm_start = 20000000
      base address = 30003000
            length = 04001fe0 >> PAGE_SHIFT
vma->vm_page_prot = 0000003f
------------[ cut here ]------------
kernel BUG at mm/memory.c:1112!
invalid operand: 0000 [#1]
PREEMPT SMP 
Modules linked in: HeavyLink parport_pc lp parport autofs4 rfcomm l2cap bluetooth nfsd exportfs lockd sunrpc e100 mii ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables floppy sg sr_mod microcode nls_cp437 msdos fat dm_mod uhci_hcd ehci_hcd video container button battery ac rtc ipv6 ext3 jbd ata_piix libata aic7xxx scsi_transport_spi sd_mod scsi_mod
CPU:    0
EIP:    0060:[<c01577f0>]    Not tainted VLI
EFLAGS: 00010206   (2.6.12) 
EIP is at remap_pte_range+0x70/0x80
eax: 20200a30   ebx: 00034403   ecx: 0000000c   edx: e0bc3000
esi: 24400000   edi: 24001fe0   ebp: 0000003f   esp: e33b5ea0
ds: 007b   es: 007b   ss: 0068
Process ftest (pid: 5048, threadinfo=e33b4000 task=edb31550)
Stack: 24000000 e0e4e240 24001fe0 24001fe0 c01578b4 ee0b2300 e0e4e240 24000000
        24001fe0 00034003 0000003f 24001fdf fffffff4 ee0b2340 ee0b2300 00000000
        30003000 ee5c938c dedc8000 f0ab662d ee5c938c 20000000 00010003 04001fe0 
Call Trace:
  [<c01578b4>] remap_pfn_range+0xb4/0x100
  [<f0ab662d>] dma_buffer+0x35781/0x36d50 [HeavyLink]
  [<c015ade6>] get_unmapped_area+0x56/0xb0
  [<c015a707>] do_mmap_pgoff+0x3a7/0x7f0
  [<c017bb37>] do_ioctl+0x77/0xa0
  [<c010aa8e>] sys_mmap2+0x9e/0xe0
  [<c01043cb>] sysenter_past_esp+0x54/0x75
Code: d8 c1 e0 05 01 c8 8b 00 f6 c4 08 74 09 89 d8 c1 e0 0c 09 e8 89 02 81 c6 00 10 00 00 43 83 c2 04 39 fe 75 c7 31 c0 5b 5e 5f 5d c3 <0f> 0b 58 04 07 37 35 c0 eb bc 8d b6 00 00 00 00 55 57 56 53 83
  <3>Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():0
  [<c011f417>] __might_sleep+0xa7/0xb0
  [<c0122b31>] profile_task_exit+0x21/0x60
  [<c0124c7a>] do_exit+0x1a/0x3a0
  [<c012007b>] copy_files+0xb/0x320
  [<c0105728>] die+0x188/0x190
  [<c0105b00>] do_invalid_op+0x0/0xd0
  [<c0105bb2>] do_invalid_op+0xb2/0xd0
  [<c0235084>] set_cursor+0x64/0x80
  [<c01577f0>] remap_pte_range+0x70/0x80
  [<c014c760>] prep_new_page+0x60/0x70
  [<c014cd49>] buffered_rmqueue+0x119/0x270
  [<c014d243>] __alloc_pages+0x2f3/0x4a0
  [<c0104f3b>] error_code+0x4f/0x54
  [<c01577f0>] remap_pte_range+0x70/0x80
  [<c01578b4>] remap_pfn_range+0xb4/0x100
  [<f0ab662d>] dma_buffer+0x35781/0x36d50 [HeavyLink]
  [<c015ade6>] get_unmapped_area+0x56/0xb0
  [<c015a707>] do_mmap_pgoff+0x3a7/0x7f0
  [<c017bb37>] do_ioctl+0x77/0xa0
  [<c010aa8e>] sys_mmap2+0x9e/0xe0
  [<c01043cb>] sysenter_past_esp+0x54/0x75
note: ftest[5048] exited with preempt_count 1
scheduling while atomic: ftest/0x00000001/5048
  [<c033af54>] schedule+0xcc4/0xcd0
  [<c012259e>] release_console_sem+0x7e/0xc0
  [<c01223cd>] vprintk+0x19d/0x250
  [<c033bc7d>] rwsem_down_read_failed+0xad/0x1a0
  [<c01043cb>] sysenter_past_esp+0x54/0x75
  [<c0126060>] .text.lock.exit+0x27/0x87
  [<c0124d27>] do_exit+0xc7/0x3a0
  [<c0105728>] die+0x188/0x190
  [<c0105b00>] do_invalid_op+0x0/0xd0
  [<c0105bb2>] do_invalid_op+0xb2/0xd0
  [<c0235084>] set_cursor+0x64/0x80
  [<c01577f0>] remap_pte_range+0x70/0x80
  [<c014c760>] prep_new_page+0x60/0x70
  [<c014cd49>] buffered_rmqueue+0x119/0x270
  [<c014d243>] __alloc_pages+0x2f3/0x4a0
  [<c0104f3b>] error_code+0x4f/0x54
  [<c01577f0>] remap_pte_range+0x70/0x80
  [<c01578b4>] remap_pfn_range+0xb4/0x100
  [<f0ab662d>] dma_buffer+0x35781/0x36d50 [HeavyLink]
  [<c015ade6>] get_unmapped_area+0x56/0xb0
  [<c015a707>] do_mmap_pgoff+0x3a7/0x7f0
  [<c017bb37>] do_ioctl+0x77/0xa0
  [<c010aa8e>] sys_mmap2+0x9e/0xe0
  [<c01043cb>] sysenter_past_esp+0x54/0x75


There are MAJOR changes that have been made to linux-2.6.12 that
no longer allow me to memory-map this memory. Would whoever made
these changes please review them to make sure that I (and others)
can still remap memory that the kernel didn't 'own' and was
mapped using ioremap_nocache().

I can test any patches.


--- /usr/src/linux-2.6.11.9/mm/memory.c	2005-05-11 18:41:52.000000000 -0400
+++ /usr/src/linux-2.6.12/mm/memory.c	2005-06-20 11:51:45.000000000 -0400
@@ -46,7 +46,6 @@
  #include <linux/highmem.h>
  #include <linux/pagemap.h>
  #include <linux/rmap.h>
-#include <linux/acct.h>
  #include <linux/module.h>
  #include <linux/init.h>

@@ -84,116 +83,205 @@
  EXPORT_SYMBOL(vmalloc_earlyreserve);

  /*
- * Note: this doesn't free the actual pages themselves. That
- * has been handled earlier when unmapping all the memory regions.
+ * If a p?d_bad entry is found while walking page tables, report
+ * the error, before resetting entry to p?d_none.  Usually (but
+ * very seldom) called out from the p?d_none_or_clear_bad macros.
   */
-static inline void clear_pmd_range(struct mmu_gather *tlb, pmd_t *pmd, unsigned long start, unsigned long end)
+
+void pgd_clear_bad(pgd_t *pgd)
  {
-	struct page *page;
+	pgd_ERROR(*pgd);
+	pgd_clear(pgd);
+}

-	if (pmd_none(*pmd))
-		return;
-	if (unlikely(pmd_bad(*pmd))) {
-		pmd_ERROR(*pmd);
-		pmd_clear(pmd);
-		return;
-	}
-	if (!((start | end) & ~PMD_MASK)) {
-		/* Only clear full, aligned ranges */
-		page = pmd_page(*pmd);
-		pmd_clear(pmd);
-		dec_page_state(nr_page_table_pages);
-		tlb->mm->nr_ptes--;
-		pte_free_tlb(tlb, page);
-	}
+void pud_clear_bad(pud_t *pud)
+{
+	pud_ERROR(*pud);
+	pud_clear(pud);
  }

-static inline void clear_pud_range(struct mmu_gather *tlb, pud_t *pud, unsigned long start, unsigned long end)
+void pmd_clear_bad(pmd_t *pmd)
  {
-	unsigned long addr = start, next;
-	pmd_t *pmd, *__pmd;
+	pmd_ERROR(*pmd);
+	pmd_clear(pmd);
+}

-	if (pud_none(*pud))
-		return;
-	if (unlikely(pud_bad(*pud))) {
-		pud_ERROR(*pud);
-		pud_clear(pud);
-		return;
-	}
+/*
+ * Note: this doesn't free the actual pages themselves. That
+ * has been handled earlier when unmapping all the memory regions.
+ */
+static void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd)
+{
+	struct page *page = pmd_page(*pmd);
+	pmd_clear(pmd);
+	pte_free_tlb(tlb, page);
+	dec_page_state(nr_page_table_pages);
+	tlb->mm->nr_ptes--;
+}
+
+static inline void free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
+				unsigned long addr, unsigned long end,
+				unsigned long floor, unsigned long ceiling)
+{
+	pmd_t *pmd;
+	unsigned long next;
+	unsigned long start;

-	pmd = __pmd = pmd_offset(pud, start);
+	start = addr;
+	pmd = pmd_offset(pud, addr);
  	do {
-		next = (addr + PMD_SIZE) & PMD_MASK;
-		if (next > end || next <= addr)
-			next = end;
- 
-		clear_pmd_range(tlb, pmd, addr, next);
-		pmd++;
-		addr = next;
-	} while (addr && (addr < end));
+		next = pmd_addr_end(addr, end);
+		if (pmd_none_or_clear_bad(pmd))
+			continue;
+		free_pte_range(tlb, pmd);
+	} while (pmd++, addr = next, addr != end);

-	if (!((start | end) & ~PUD_MASK)) {
-		/* Only clear full, aligned ranges */
-		pud_clear(pud);
-		pmd_free_tlb(tlb, __pmd);
+	start &= PUD_MASK;
+	if (start < floor)
+		return;
+	if (ceiling) {
+		ceiling &= PUD_MASK;
+		if (!ceiling)
+			return;
  	}
-}
+	if (end - 1 > ceiling - 1)
+		return;

+	pmd = pmd_offset(pud, start);
+	pud_clear(pud);
+	pmd_free_tlb(tlb, pmd);
+}

-static inline void clear_pgd_range(struct mmu_gather *tlb, pgd_t *pgd, unsigned long start, unsigned long end)
+static inline void free_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
+				unsigned long addr, unsigned long end,
+				unsigned long floor, unsigned long ceiling)
  {
-	unsigned long addr = start, next;
-	pud_t *pud, *__pud;
-
-	if (pgd_none(*pgd))
-		return;
-	if (unlikely(pgd_bad(*pgd))) {
-		pgd_ERROR(*pgd);
-		pgd_clear(pgd);
-		return;
-	}
+	pud_t *pud;
+	unsigned long next;
+	unsigned long start;

-	pud = __pud = pud_offset(pgd, start);
+	start = addr;
+	pud = pud_offset(pgd, addr);
  	do {
-		next = (addr + PUD_SIZE) & PUD_MASK;
-		if (next > end || next <= addr)
-			next = end;
- 
-		clear_pud_range(tlb, pud, addr, next);
-		pud++;
-		addr = next;
-	} while (addr && (addr < end));
+		next = pud_addr_end(addr, end);
+		if (pud_none_or_clear_bad(pud))
+			continue;
+		free_pmd_range(tlb, pud, addr, next, floor, ceiling);
+	} while (pud++, addr = next, addr != end);

-	if (!((start | end) & ~PGDIR_MASK)) {
-		/* Only clear full, aligned ranges */
-		pgd_clear(pgd);
-		pud_free_tlb(tlb, __pud);
+	start &= PGDIR_MASK;
+	if (start < floor)
+		return;
+	if (ceiling) {
+		ceiling &= PGDIR_MASK;
+		if (!ceiling)
+			return;
  	}
+	if (end - 1 > ceiling - 1)
+		return;
+
+	pud = pud_offset(pgd, start);
+	pgd_clear(pgd);
+	pud_free_tlb(tlb, pud);
  }

  /*
- * This function clears user-level page tables of a process.
+ * This function frees user-level page tables of a process.
   *
   * Must be called with pagetable lock held.
   */
-void clear_page_range(struct mmu_gather *tlb, unsigned long start, unsigned long end)
+void free_pgd_range(struct mmu_gather **tlb,
+			unsigned long addr, unsigned long end,
+			unsigned long floor, unsigned long ceiling)
  {
-	unsigned long addr = start, next;
-	pgd_t * pgd = pgd_offset(tlb->mm, start);
-	unsigned long i;
-
-	for (i = pgd_index(start); i <= pgd_index(end-1); i++) {
-		next = (addr + PGDIR_SIZE) & PGDIR_MASK;
-		if (next > end || next <= addr)
-			next = end;
- 
-		clear_pgd_range(tlb, pgd, addr, next);
-		pgd++;
-		addr = next;
+	pgd_t *pgd;
+	unsigned long next;
+	unsigned long start;
+
+	/*
+	 * The next few lines have given us lots of grief...
+	 *
+	 * Why are we testing PMD* at this top level?  Because often
+	 * there will be no work to do at all, and we'd prefer not to
+	 * go all the way down to the bottom just to discover that.
+	 *
+	 * Why all these "- 1"s?  Because 0 represents both the bottom
+	 * of the address space and the top of it (using -1 for the
+	 * top wouldn't help much: the masks would do the wrong thing).
+	 * The rule is that addr 0 and floor 0 refer to the bottom of
+	 * the address space, but end 0 and ceiling 0 refer to the top
+	 * Comparisons need to use "end - 1" and "ceiling - 1" (though
+	 * that end 0 case should be mythical).
+	 *
+	 * Wherever addr is brought up or ceiling brought down, we must
+	 * be careful to reject "the opposite 0" before it confuses the
+	 * subsequent tests.  But what about where end is brought down
+	 * by PMD_SIZE below? no, end can't go down to 0 there.
+	 *
+	 * Whereas we round start (addr) and ceiling down, by different
+	 * masks at different levels, in order to test whether a table
+	 * now has no other vmas using it, so can be freed, we don't
+	 * bother to round floor or end up - the tests don't need that.
+	 */
+
+	addr &= PMD_MASK;
+	if (addr < floor) {
+		addr += PMD_SIZE;
+		if (!addr)
+			return;
+	}
+	if (ceiling) {
+		ceiling &= PMD_MASK;
+		if (!ceiling)
+			return;
+	}
+	if (end - 1 > ceiling - 1)
+		end -= PMD_SIZE;
+	if (addr > end - 1)
+		return;
+
+	start = addr;
+	pgd = pgd_offset((*tlb)->mm, addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		if (pgd_none_or_clear_bad(pgd))
+			continue;
+		free_pud_range(*tlb, pgd, addr, next, floor, ceiling);
+	} while (pgd++, addr = next, addr != end);
+
+	if (!tlb_is_full_mm(*tlb))
+		flush_tlb_pgtables((*tlb)->mm, start, end);
+}
+
+void free_pgtables(struct mmu_gather **tlb, struct vm_area_struct *vma,
+		unsigned long floor, unsigned long ceiling)
+{
+	while (vma) {
+		struct vm_area_struct *next = vma->vm_next;
+		unsigned long addr = vma->vm_start;
+
+		if (is_hugepage_only_range(vma->vm_mm, addr, HPAGE_SIZE)) {
+			hugetlb_free_pgd_range(tlb, addr, vma->vm_end,
+				floor, next? next->vm_start: ceiling);
+		} else {
+			/*
+			 * Optimization: gather nearby vmas into one call down
+			 */
+			while (next && next->vm_start <= vma->vm_end + PMD_SIZE
+			  && !is_hugepage_only_range(vma->vm_mm, next->vm_start,
+							HPAGE_SIZE)) {
+				vma = next;
+				next = vma->vm_next;
+			}
+			free_pgd_range(tlb, addr, vma->vm_end,
+				floor, next? next->vm_start: ceiling);
+		}
+		vma = next;
  	}
  }

-pte_t fastcall * pte_alloc_map(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
+pte_t fastcall *pte_alloc_map(struct mm_struct *mm, pmd_t *pmd,
+				unsigned long address)
  {
  	if (!pmd_present(*pmd)) {
  		struct page *new;
@@ -254,20 +342,7 @@
   */

  static inline void
-copy_swap_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm, pte_t pte)
-{
-	if (pte_file(pte))
-		return;
-	swap_duplicate(pte_to_swp_entry(pte));
-	if (list_empty(&dst_mm->mmlist)) {
-		spin_lock(&mmlist_lock);
-		list_add(&dst_mm->mmlist, &src_mm->mmlist);
-		spin_unlock(&mmlist_lock);
-	}
-}
-
-static inline void
-copy_one_pte(struct mm_struct *dst_mm,  struct mm_struct *src_mm,
+copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
  		pte_t *dst_pte, pte_t *src_pte, unsigned long vm_flags,
  		unsigned long addr)
  {
@@ -275,12 +350,21 @@
  	struct page *page;
  	unsigned long pfn;

-	/* pte contains position in swap, so copy. */
-	if (!pte_present(pte)) {
-		copy_swap_pte(dst_mm, src_mm, pte);
-		set_pte(dst_pte, pte);
+	/* pte contains position in swap or file, so copy. */
+	if (unlikely(!pte_present(pte))) {
+		if (!pte_file(pte)) {
+			swap_duplicate(pte_to_swp_entry(pte));
+			/* make sure dst_mm is on swapoff's mmlist. */
+			if (unlikely(list_empty(&dst_mm->mmlist))) {
+				spin_lock(&mmlist_lock);
+				list_add(&dst_mm->mmlist, &src_mm->mmlist);
+				spin_unlock(&mmlist_lock);
+			}
+		}
+		set_pte_at(dst_mm, addr, dst_pte, pte);
  		return;
  	}
+
  	pfn = pte_pfn(pte);
  	/* the pte points outside of valid memory, the
  	 * mapping is assumed to be good, meaningful
@@ -292,7 +376,7 @@
  		page = pfn_to_page(pfn);

  	if (!page || PageReserved(page)) {
-		set_pte(dst_pte, pte);
+		set_pte_at(dst_mm, addr, dst_pte, pte);
  		return;
  	}

@@ -301,7 +385,7 @@
  	 * in the parent and the child
  	 */
  	if ((vm_flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE) {
-		ptep_set_wrprotect(src_pte);
+		ptep_set_wrprotect(src_mm, addr, src_pte);
  		pte = *src_pte;
  	}

@@ -313,172 +397,137 @@
  		pte = pte_mkclean(pte);
  	pte = pte_mkold(pte);
  	get_page(page);
-	dst_mm->rss++;
+	inc_mm_counter(dst_mm, rss);
  	if (PageAnon(page))
-		dst_mm->anon_rss++;
-	set_pte(dst_pte, pte);
+		inc_mm_counter(dst_mm, anon_rss);
+	set_pte_at(dst_mm, addr, dst_pte, pte);
  	page_dup_rmap(page);
  }

-static int copy_pte_range(struct mm_struct *dst_mm,  struct mm_struct *src_mm,
+static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
  		pmd_t *dst_pmd, pmd_t *src_pmd, struct vm_area_struct *vma,
  		unsigned long addr, unsigned long end)
  {
  	pte_t *src_pte, *dst_pte;
-	pte_t *s, *d;
  	unsigned long vm_flags = vma->vm_flags;
+	int progress;

-	d = dst_pte = pte_alloc_map(dst_mm, dst_pmd, addr);
+again:
+	dst_pte = pte_alloc_map(dst_mm, dst_pmd, addr);
  	if (!dst_pte)
  		return -ENOMEM;
+	src_pte = pte_offset_map_nested(src_pmd, addr);

+	progress = 0;
  	spin_lock(&src_mm->page_table_lock);
-	s = src_pte = pte_offset_map_nested(src_pmd, addr);
-	for (; addr < end; addr += PAGE_SIZE, s++, d++) {
-		if (pte_none(*s))
+	do {
+		/*
+		 * We are holding two locks at this point - either of them
+		 * could generate latencies in another task on another CPU.
+		 */
+		if (progress >= 32 && (need_resched() ||
+		    need_lockbreak(&src_mm->page_table_lock) ||
+		    need_lockbreak(&dst_mm->page_table_lock)))
+			break;
+		if (pte_none(*src_pte)) {
+			progress++;
  			continue;
-		copy_one_pte(dst_mm, src_mm, d, s, vm_flags, addr);
-	}
-	pte_unmap_nested(src_pte);
-	pte_unmap(dst_pte);
+		}
+		copy_one_pte(dst_mm, src_mm, dst_pte, src_pte, vm_flags, addr);
+		progress += 8;
+	} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr != end);
  	spin_unlock(&src_mm->page_table_lock);
+
+	pte_unmap_nested(src_pte - 1);
+	pte_unmap(dst_pte - 1);
  	cond_resched_lock(&dst_mm->page_table_lock);
+	if (addr != end)
+		goto again;
  	return 0;
  }

-static int copy_pmd_range(struct mm_struct *dst_mm,  struct mm_struct *src_mm,
+static inline int copy_pmd_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
  		pud_t *dst_pud, pud_t *src_pud, struct vm_area_struct *vma,
  		unsigned long addr, unsigned long end)
  {
  	pmd_t *src_pmd, *dst_pmd;
-	int err = 0;
  	unsigned long next;

-	src_pmd = pmd_offset(src_pud, addr);
  	dst_pmd = pmd_alloc(dst_mm, dst_pud, addr);
  	if (!dst_pmd)
  		return -ENOMEM;
-
-	for (; addr < end; addr = next, src_pmd++, dst_pmd++) {
-		next = (addr + PMD_SIZE) & PMD_MASK;
-		if (next > end || next <= addr)
-			next = end;
-		if (pmd_none(*src_pmd))
-			continue;
-		if (pmd_bad(*src_pmd)) {
-			pmd_ERROR(*src_pmd);
-			pmd_clear(src_pmd);
+	src_pmd = pmd_offset(src_pud, addr);
+	do {
+		next = pmd_addr_end(addr, end);
+		if (pmd_none_or_clear_bad(src_pmd))
  			continue;
-		}
-		err = copy_pte_range(dst_mm, src_mm, dst_pmd, src_pmd,
-							vma, addr, next);
-		if (err)
-			break;
-	}
-	return err;
+		if (copy_pte_range(dst_mm, src_mm, dst_pmd, src_pmd,
+						vma, addr, next))
+			return -ENOMEM;
+	} while (dst_pmd++, src_pmd++, addr = next, addr != end);
+	return 0;
  }

-static int copy_pud_range(struct mm_struct *dst_mm,  struct mm_struct *src_mm,
+static inline int copy_pud_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
  		pgd_t *dst_pgd, pgd_t *src_pgd, struct vm_area_struct *vma,
  		unsigned long addr, unsigned long end)
  {
  	pud_t *src_pud, *dst_pud;
-	int err = 0;
  	unsigned long next;

-	src_pud = pud_offset(src_pgd, addr);
  	dst_pud = pud_alloc(dst_mm, dst_pgd, addr);
  	if (!dst_pud)
  		return -ENOMEM;
-
-	for (; addr < end; addr = next, src_pud++, dst_pud++) {
-		next = (addr + PUD_SIZE) & PUD_MASK;
-		if (next > end || next <= addr)
-			next = end;
-		if (pud_none(*src_pud))
-			continue;
-		if (pud_bad(*src_pud)) {
-			pud_ERROR(*src_pud);
-			pud_clear(src_pud);
+	src_pud = pud_offset(src_pgd, addr);
+	do {
+		next = pud_addr_end(addr, end);
+		if (pud_none_or_clear_bad(src_pud))
  			continue;
-		}
-		err = copy_pmd_range(dst_mm, src_mm, dst_pud, src_pud,
-							vma, addr, next);
-		if (err)
-			break;
-	}
-	return err;
+		if (copy_pmd_range(dst_mm, src_mm, dst_pud, src_pud,
+						vma, addr, next))
+			return -ENOMEM;
+	} while (dst_pud++, src_pud++, addr = next, addr != end);
+	return 0;
  }

-int copy_page_range(struct mm_struct *dst, struct mm_struct *src,
+int copy_page_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
  		struct vm_area_struct *vma)
  {
  	pgd_t *src_pgd, *dst_pgd;
-	unsigned long addr, start, end, next;
-	int err = 0;
+	unsigned long next;
+	unsigned long addr = vma->vm_start;
+	unsigned long end = vma->vm_end;

  	if (is_vm_hugetlb_page(vma))
-		return copy_hugetlb_page_range(dst, src, vma);
-
-	start = vma->vm_start;
-	src_pgd = pgd_offset(src, start);
-	dst_pgd = pgd_offset(dst, start);
-
-	end = vma->vm_end;
-	addr = start;
-	while (addr && (addr < end-1)) {
-		next = (addr + PGDIR_SIZE) & PGDIR_MASK;
-		if (next > end || next <= addr)
-			next = end;
-		if (pgd_none(*src_pgd))
-			goto next_pgd;
-		if (pgd_bad(*src_pgd)) {
-			pgd_ERROR(*src_pgd);
-			pgd_clear(src_pgd);
-			goto next_pgd;
-		}
-		err = copy_pud_range(dst, src, dst_pgd, src_pgd,
-							vma, addr, next);
-		if (err)
-			break;
-
-next_pgd:
-		src_pgd++;
-		dst_pgd++;
-		addr = next;
-	}
+		return copy_hugetlb_page_range(dst_mm, src_mm, vma);

-	return err;
+	dst_pgd = pgd_offset(dst_mm, addr);
+	src_pgd = pgd_offset(src_mm, addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		if (pgd_none_or_clear_bad(src_pgd))
+			continue;
+		if (copy_pud_range(dst_mm, src_mm, dst_pgd, src_pgd,
+						vma, addr, next))
+			return -ENOMEM;
+	} while (dst_pgd++, src_pgd++, addr = next, addr != end);
+	return 0;
  }

-static void zap_pte_range(struct mmu_gather *tlb,
-		pmd_t *pmd, unsigned long address,
-		unsigned long size, struct zap_details *details)
+static void zap_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
+				unsigned long addr, unsigned long end,
+				struct zap_details *details)
  {
-	unsigned long offset;
-	pte_t *ptep;
+	pte_t *pte;

-	if (pmd_none(*pmd))
-		return;
-	if (unlikely(pmd_bad(*pmd))) {
-		pmd_ERROR(*pmd);
-		pmd_clear(pmd);
-		return;
-	}
-	ptep = pte_offset_map(pmd, address);
-	offset = address & ~PMD_MASK;
-	if (offset + size > PMD_SIZE)
-		size = PMD_SIZE - offset;
-	size &= PAGE_MASK;
-	if (details && !details->check_mapping && !details->nonlinear_vma)
-		details = NULL;
-	for (offset=0; offset < size; ptep++, offset += PAGE_SIZE) {
-		pte_t pte = *ptep;
-		if (pte_none(pte))
+	pte = pte_offset_map(pmd, addr);
+	do {
+		pte_t ptent = *pte;
+		if (pte_none(ptent))
  			continue;
-		if (pte_present(pte)) {
+		if (pte_present(ptent)) {
  			struct page *page = NULL;
-			unsigned long pfn = pte_pfn(pte);
+			unsigned long pfn = pte_pfn(ptent);
  			if (pfn_valid(pfn)) {
  				page = pfn_to_page(pfn);
  				if (PageReserved(page))
@@ -502,19 +551,20 @@
  				     page->index > details->last_index))
  					continue;
  			}
-			pte = ptep_get_and_clear(ptep);
-			tlb_remove_tlb_entry(tlb, ptep, address+offset);
+			ptent = ptep_get_and_clear(tlb->mm, addr, pte);
+			tlb_remove_tlb_entry(tlb, pte, addr);
  			if (unlikely(!page))
  				continue;
  			if (unlikely(details) && details->nonlinear_vma
  			    && linear_page_index(details->nonlinear_vma,
-					address+offset) != page->index)
-				set_pte(ptep, pgoff_to_pte(page->index));
-			if (pte_dirty(pte))
+						addr) != page->index)
+				set_pte_at(tlb->mm, addr, pte,
+					   pgoff_to_pte(page->index));
+			if (pte_dirty(ptent))
  				set_page_dirty(page);
  			if (PageAnon(page))
-				tlb->mm->anon_rss--;
-			else if (pte_young(pte))
+				dec_mm_counter(tlb->mm, anon_rss);
+			else if (pte_young(ptent))
  				mark_page_accessed(page);
  			tlb->freed++;
  			page_remove_rmap(page);
@@ -527,78 +577,64 @@
  		 */
  		if (unlikely(details))
  			continue;
-		if (!pte_file(pte))
-			free_swap_and_cache(pte_to_swp_entry(pte));
-		pte_clear(ptep);
-	}
-	pte_unmap(ptep-1);
+		if (!pte_file(ptent))
+			free_swap_and_cache(pte_to_swp_entry(ptent));
+		pte_clear(tlb->mm, addr, pte);
+	} while (pte++, addr += PAGE_SIZE, addr != end);
+	pte_unmap(pte - 1);
  }

-static void zap_pmd_range(struct mmu_gather *tlb,
-		pud_t *pud, unsigned long address,
-		unsigned long size, struct zap_details *details)
+static inline void zap_pmd_range(struct mmu_gather *tlb, pud_t *pud,
+				unsigned long addr, unsigned long end,
+				struct zap_details *details)
  {
-	pmd_t * pmd;
-	unsigned long end;
+	pmd_t *pmd;
+	unsigned long next;

-	if (pud_none(*pud))
-		return;
-	if (unlikely(pud_bad(*pud))) {
-		pud_ERROR(*pud);
-		pud_clear(pud);
-		return;
-	}
-	pmd = pmd_offset(pud, address);
-	end = address + size;
-	if (end > ((address + PUD_SIZE) & PUD_MASK))
-		end = ((address + PUD_SIZE) & PUD_MASK);
+	pmd = pmd_offset(pud, addr);
  	do {
-		zap_pte_range(tlb, pmd, address, end - address, details);
-		address = (address + PMD_SIZE) & PMD_MASK; 
-		pmd++;
-	} while (address && (address < end));
+		next = pmd_addr_end(addr, end);
+		if (pmd_none_or_clear_bad(pmd))
+			continue;
+		zap_pte_range(tlb, pmd, addr, next, details);
+	} while (pmd++, addr = next, addr != end);
  }

-static void zap_pud_range(struct mmu_gather *tlb,
-		pgd_t * pgd, unsigned long address,
-		unsigned long end, struct zap_details *details)
+static inline void zap_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
+				unsigned long addr, unsigned long end,
+				struct zap_details *details)
  {
-	pud_t * pud;
+	pud_t *pud;
+	unsigned long next;

-	if (pgd_none(*pgd))
-		return;
-	if (unlikely(pgd_bad(*pgd))) {
-		pgd_ERROR(*pgd);
-		pgd_clear(pgd);
-		return;
-	}
-	pud = pud_offset(pgd, address);
+	pud = pud_offset(pgd, addr);
  	do {
-		zap_pmd_range(tlb, pud, address, end - address, details);
-		address = (address + PUD_SIZE) & PUD_MASK; 
-		pud++;
-	} while (address && (address < end));
+		next = pud_addr_end(addr, end);
+		if (pud_none_or_clear_bad(pud))
+			continue;
+		zap_pmd_range(tlb, pud, addr, next, details);
+	} while (pud++, addr = next, addr != end);
  }

-static void unmap_page_range(struct mmu_gather *tlb,
-		struct vm_area_struct *vma, unsigned long address,
-		unsigned long end, struct zap_details *details)
+static void unmap_page_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+				unsigned long addr, unsigned long end,
+				struct zap_details *details)
  {
-	unsigned long next;
  	pgd_t *pgd;
-	int i;
+	unsigned long next;

-	BUG_ON(address >= end);
-	pgd = pgd_offset(vma->vm_mm, address);
+	if (details && !details->check_mapping && !details->nonlinear_vma)
+		details = NULL;
+
+	BUG_ON(addr >= end);
  	tlb_start_vma(tlb, vma);
-	for (i = pgd_index(address); i <= pgd_index(end-1); i++) {
-		next = (address + PGDIR_SIZE) & PGDIR_MASK;
-		if (next <= address || next > end)
-			next = end;
-		zap_pud_range(tlb, pgd, address, next, details);
-		address = next;
-		pgd++;
-	}
+	pgd = pgd_offset(vma->vm_mm, addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		if (pgd_none_or_clear_bad(pgd))
+			continue;
+		zap_pud_range(tlb, pgd, addr, next, details);
+	} while (pgd++, addr = next, addr != end);
  	tlb_end_vma(tlb, vma);
  }

@@ -619,7 +655,7 @@
   * @nr_accounted: Place number of unmapped pages in vm-accountable vma's here
   * @details: details of nonlinear truncation or shared cache invalidation
   *
- * Returns the number of vma's which were covered by the unmapping.
+ * Returns the end address of the unmapping (restart addr if interrupted).
   *
   * Unmap all pages in the vma list.  Called under page_table_lock.
   *
@@ -636,7 +672,7 @@
   * ensure that any thus-far unmapped pages are flushed before unmap_vmas()
   * drops the lock and schedules.
   */
-int unmap_vmas(struct mmu_gather **tlbp, struct mm_struct *mm,
+unsigned long unmap_vmas(struct mmu_gather **tlbp, struct mm_struct *mm,
  		struct vm_area_struct *vma, unsigned long start_addr,
  		unsigned long end_addr, unsigned long *nr_accounted,
  		struct zap_details *details)
@@ -644,12 +680,11 @@
  	unsigned long zap_bytes = ZAP_BLOCK_SIZE;
  	unsigned long tlb_start = 0;	/* For tlb_finish_mmu */
  	int tlb_start_valid = 0;
-	int ret = 0;
+	unsigned long start = start_addr;
  	spinlock_t *i_mmap_lock = details? details->i_mmap_lock: NULL;
  	int fullmm = tlb_is_full_mm(*tlbp);

  	for ( ; vma && vma->vm_start < end_addr; vma = vma->vm_next) {
-		unsigned long start;
  		unsigned long end;

  		start = max(vma->vm_start, start_addr);
@@ -662,7 +697,6 @@
  		if (vma->vm_flags & VM_ACCOUNT)
  			*nr_accounted += (end - start) >> PAGE_SHIFT;

-		ret++;
  		while (start != end) {
  			unsigned long block;

@@ -693,7 +727,6 @@
  				if (i_mmap_lock) {
  					/* must reset count of rss freed */
  					*tlbp = tlb_gather_mmu(mm, fullmm);
-					details->break_addr = start;
  					goto out;
  				}
  				spin_unlock(&mm->page_table_lock);
@@ -707,7 +740,7 @@
  		}
  	}
  out:
-	return ret;
+	return start;	/* which is now the end (or restart) address */
  }

  /**
@@ -717,7 +750,7 @@
   * @size: number of bytes to zap
   * @details: details of nonlinear truncation or shared cache invalidation
   */
-void zap_page_range(struct vm_area_struct *vma, unsigned long address,
+unsigned long zap_page_range(struct vm_area_struct *vma, unsigned long address,
  		unsigned long size, struct zap_details *details)
  {
  	struct mm_struct *mm = vma->vm_mm;
@@ -727,16 +760,16 @@

  	if (is_vm_hugetlb_page(vma)) {
  		zap_hugepage_range(vma, address, size);
-		return;
+		return end;
  	}

  	lru_add_drain();
  	spin_lock(&mm->page_table_lock);
  	tlb = tlb_gather_mmu(mm, 0);
-	unmap_vmas(&tlb, mm, vma, address, end, &nr_accounted, details);
+	end = unmap_vmas(&tlb, mm, vma, address, end, &nr_accounted, details);
  	tlb_finish_mmu(tlb, address, end);
-	acct_update_integrals();
  	spin_unlock(&mm->page_table_lock);
+	return end;
  }

  /*
@@ -987,111 +1020,78 @@

  EXPORT_SYMBOL(get_user_pages);

-static void zeromap_pte_range(pte_t * pte, unsigned long address,
-                                     unsigned long size, pgprot_t prot)
+static int zeromap_pte_range(struct mm_struct *mm, pmd_t *pmd,
+			unsigned long addr, unsigned long end, pgprot_t prot)
  {
-	unsigned long end;
+	pte_t *pte;

-	address &= ~PMD_MASK;
-	end = address + size;
-	if (end > PMD_SIZE)
-		end = PMD_SIZE;
+	pte = pte_alloc_map(mm, pmd, addr);
+	if (!pte)
+		return -ENOMEM;
  	do {
-		pte_t zero_pte = pte_wrprotect(mk_pte(ZERO_PAGE(address), prot));
+		pte_t zero_pte = pte_wrprotect(mk_pte(ZERO_PAGE(addr), prot));
  		BUG_ON(!pte_none(*pte));
-		set_pte(pte, zero_pte);
-		address += PAGE_SIZE;
-		pte++;
-	} while (address && (address < end));
-}
-
-static inline int zeromap_pmd_range(struct mm_struct *mm, pmd_t * pmd,
-		unsigned long address, unsigned long size, pgprot_t prot)
-{
-	unsigned long base, end;
-
-	base = address & PUD_MASK;
-	address &= ~PUD_MASK;
-	end = address + size;
-	if (end > PUD_SIZE)
-		end = PUD_SIZE;
+		set_pte_at(mm, addr, pte, zero_pte);
+	} while (pte++, addr += PAGE_SIZE, addr != end);
+	pte_unmap(pte - 1);
+	return 0;
+}
+
+static inline int zeromap_pmd_range(struct mm_struct *mm, pud_t *pud,
+			unsigned long addr, unsigned long end, pgprot_t prot)
+{
+	pmd_t *pmd;
+	unsigned long next;
+
+	pmd = pmd_alloc(mm, pud, addr);
+	if (!pmd)
+		return -ENOMEM;
  	do {
-		pte_t * pte = pte_alloc_map(mm, pmd, base + address);
-		if (!pte)
+		next = pmd_addr_end(addr, end);
+		if (zeromap_pte_range(mm, pmd, addr, next, prot))
  			return -ENOMEM;
-		zeromap_pte_range(pte, base + address, end - address, prot);
-		pte_unmap(pte);
-		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
-	} while (address && (address < end));
+	} while (pmd++, addr = next, addr != end);
  	return 0;
  }

-static inline int zeromap_pud_range(struct mm_struct *mm, pud_t * pud,
-				    unsigned long address,
-                                    unsigned long size, pgprot_t prot)
-{
-	unsigned long base, end;
-	int error = 0;
-
-	base = address & PGDIR_MASK;
-	address &= ~PGDIR_MASK;
-	end = address + size;
-	if (end > PGDIR_SIZE)
-		end = PGDIR_SIZE;
+static inline int zeromap_pud_range(struct mm_struct *mm, pgd_t *pgd,
+			unsigned long addr, unsigned long end, pgprot_t prot)
+{
+	pud_t *pud;
+	unsigned long next;
+
+	pud = pud_alloc(mm, pgd, addr);
+	if (!pud)
+		return -ENOMEM;
  	do {
-		pmd_t * pmd = pmd_alloc(mm, pud, base + address);
-		error = -ENOMEM;
-		if (!pmd)
-			break;
-		error = zeromap_pmd_range(mm, pmd, base + address,
-					  end - address, prot);
-		if (error)
-			break;
-		address = (address + PUD_SIZE) & PUD_MASK;
-		pud++;
-	} while (address && (address < end));
+		next = pud_addr_end(addr, end);
+		if (zeromap_pmd_range(mm, pud, addr, next, prot))
+			return -ENOMEM;
+	} while (pud++, addr = next, addr != end);
  	return 0;
  }

-int zeromap_page_range(struct vm_area_struct *vma, unsigned long address,
-					unsigned long size, pgprot_t prot)
+int zeromap_page_range(struct vm_area_struct *vma,
+			unsigned long addr, unsigned long size, pgprot_t prot)
  {
-	int i;
-	int error = 0;
-	pgd_t * pgd;
-	unsigned long beg = address;
-	unsigned long end = address + size;
+	pgd_t *pgd;
  	unsigned long next;
+	unsigned long end = addr + size;
  	struct mm_struct *mm = vma->vm_mm;
+	int err;

-	pgd = pgd_offset(mm, address);
-	flush_cache_range(vma, beg, end);
-	BUG_ON(address >= end);
-	BUG_ON(end > vma->vm_end);
-
+	BUG_ON(addr >= end);
+	pgd = pgd_offset(mm, addr);
+	flush_cache_range(vma, addr, end);
  	spin_lock(&mm->page_table_lock);
-	for (i = pgd_index(address); i <= pgd_index(end-1); i++) {
-		pud_t *pud = pud_alloc(mm, pgd, address);
-		error = -ENOMEM;
-		if (!pud)
-			break;
-		next = (address + PGDIR_SIZE) & PGDIR_MASK;
-		if (next <= beg || next > end)
-			next = end;
-		error = zeromap_pud_range(mm, pud, address,
-						next - address, prot);
-		if (error)
+	do {
+		next = pgd_addr_end(addr, end);
+		err = zeromap_pud_range(mm, pgd, addr, next, prot);
+		if (err)
  			break;
-		address = next;
-		pgd++;
-	}
-	/*
-	 * Why flush? zeromap_pte_range has a BUG_ON for !pte_none()
-	 */
-	flush_tlb_range(vma, beg, end);
+	} while (pgd++, addr = next, addr != end);
  	spin_unlock(&mm->page_table_lock);
-	return error;
+	return err;
  }

  /*
@@ -1099,95 +1099,74 @@
   * mappings are removed. any references to nonexistent pages results
   * in null mappings (currently treated as "copy-on-access")
   */
-static inline void
-remap_pte_range(pte_t * pte, unsigned long address, unsigned long size,
-		unsigned long pfn, pgprot_t prot)
+static int remap_pte_range(struct mm_struct *mm, pmd_t *pmd,
+			unsigned long addr, unsigned long end,
+			unsigned long pfn, pgprot_t prot)
  {
-	unsigned long end;
+	pte_t *pte;

-	address &= ~PMD_MASK;
-	end = address + size;
-	if (end > PMD_SIZE)
-		end = PMD_SIZE;
+	pte = pte_alloc_map(mm, pmd, addr);
+	if (!pte)
+		return -ENOMEM;
  	do {
  		BUG_ON(!pte_none(*pte));
  		if (!pfn_valid(pfn) || PageReserved(pfn_to_page(pfn)))
- 			set_pte(pte, pfn_pte(pfn, prot));
-		address += PAGE_SIZE;
+			set_pte_at(mm, addr, pte, pfn_pte(pfn, prot));
  		pfn++;
-		pte++;
-	} while (address && (address < end));
+	} while (pte++, addr += PAGE_SIZE, addr != end);
+	pte_unmap(pte - 1);
+	return 0;
  }

-static inline int
-remap_pmd_range(struct mm_struct *mm, pmd_t * pmd, unsigned long address,
-		unsigned long size, unsigned long pfn, pgprot_t prot)
+static inline int remap_pmd_range(struct mm_struct *mm, pud_t *pud,
+			unsigned long addr, unsigned long end,
+			unsigned long pfn, pgprot_t prot)
  {
-	unsigned long base, end;
+	pmd_t *pmd;
+	unsigned long next;

-	base = address & PUD_MASK;
-	address &= ~PUD_MASK;
-	end = address + size;
-	if (end > PUD_SIZE)
-		end = PUD_SIZE;
-	pfn -= (address >> PAGE_SHIFT);
+	pfn -= addr >> PAGE_SHIFT;
+	pmd = pmd_alloc(mm, pud, addr);
+	if (!pmd)
+		return -ENOMEM;
  	do {
-		pte_t * pte = pte_alloc_map(mm, pmd, base + address);
-		if (!pte)
+		next = pmd_addr_end(addr, end);
+		if (remap_pte_range(mm, pmd, addr, next,
+				pfn + (addr >> PAGE_SHIFT), prot))
  			return -ENOMEM;
-		remap_pte_range(pte, base + address, end - address,
-				(address >> PAGE_SHIFT) + pfn, prot);
-		pte_unmap(pte);
-		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
-	} while (address && (address < end));
+	} while (pmd++, addr = next, addr != end);
  	return 0;
  }

-static inline int remap_pud_range(struct mm_struct *mm, pud_t * pud,
-				  unsigned long address, unsigned long size,
-				  unsigned long pfn, pgprot_t prot)
-{
-	unsigned long base, end;
-	int error;
-
-	base = address & PGDIR_MASK;
-	address &= ~PGDIR_MASK;
-	end = address + size;
-	if (end > PGDIR_SIZE)
-		end = PGDIR_SIZE;
-	pfn -= address >> PAGE_SHIFT;
+static inline int remap_pud_range(struct mm_struct *mm, pgd_t *pgd,
+			unsigned long addr, unsigned long end,
+			unsigned long pfn, pgprot_t prot)
+{
+	pud_t *pud;
+	unsigned long next;
+
+	pfn -= addr >> PAGE_SHIFT;
+	pud = pud_alloc(mm, pgd, addr);
+	if (!pud)
+		return -ENOMEM;
  	do {
-		pmd_t *pmd = pmd_alloc(mm, pud, base+address);
-		error = -ENOMEM;
-		if (!pmd)
-			break;
-		error = remap_pmd_range(mm, pmd, base + address, end - address,
-				(address >> PAGE_SHIFT) + pfn, prot);
-		if (error)
-			break;
-		address = (address + PUD_SIZE) & PUD_MASK;
-		pud++;
-	} while (address && (address < end));
-	return error;
+		next = pud_addr_end(addr, end);
+		if (remap_pmd_range(mm, pud, addr, next,
+				pfn + (addr >> PAGE_SHIFT), prot))
+			return -ENOMEM;
+	} while (pud++, addr = next, addr != end);
+	return 0;
  }

  /*  Note: this is only safe if the mm semaphore is held when called. */
-int remap_pfn_range(struct vm_area_struct *vma, unsigned long from,
+int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
  		    unsigned long pfn, unsigned long size, pgprot_t prot)
  {
-	int error = 0;
  	pgd_t *pgd;
-	unsigned long beg = from;
-	unsigned long end = from + size;
  	unsigned long next;
+	unsigned long end = addr + size;
  	struct mm_struct *mm = vma->vm_mm;
-	int i;
-
-	pfn -= from >> PAGE_SHIFT;
-	pgd = pgd_offset(mm, from);
-	flush_cache_range(vma, beg, end);
-	BUG_ON(from >= end);
+	int err;

  	/*
  	 * Physically remapped pages are special. Tell the
@@ -1199,31 +1178,21 @@
  	 */
  	vma->vm_flags |= VM_IO | VM_RESERVED;

+	BUG_ON(addr >= end);
+	pfn -= addr >> PAGE_SHIFT;
+	pgd = pgd_offset(mm, addr);
+	flush_cache_range(vma, addr, end);
  	spin_lock(&mm->page_table_lock);
-	for (i = pgd_index(beg); i <= pgd_index(end-1); i++) {
-		pud_t *pud = pud_alloc(mm, pgd, from);
-		error = -ENOMEM;
-		if (!pud)
-			break;
-		next = (from + PGDIR_SIZE) & PGDIR_MASK;
-		if (next > end || next <= from)
-			next = end;
-		error = remap_pud_range(mm, pud, from, end - from,
-					pfn + (from >> PAGE_SHIFT), prot);
-		if (error)
+	do {
+		next = pgd_addr_end(addr, end);
+		err = remap_pud_range(mm, pgd, addr, next,
+				pfn + (addr >> PAGE_SHIFT), prot);
+		if (err)
  			break;
-		from = next;
-		pgd++;
-	}
-	/*
-	 * Why flush? remap_pte_range has a BUG_ON for !pte_none()
-	 */
-	flush_tlb_range(vma, beg, end);
+	} while (pgd++, addr = next, addr != end);
  	spin_unlock(&mm->page_table_lock);
-
-	return error;
+	return err;
  }
-
  EXPORT_SYMBOL(remap_pfn_range);

  /*
@@ -1247,11 +1216,11 @@
  {
  	pte_t entry;

-	flush_cache_page(vma, address);
  	entry = maybe_mkwrite(pte_mkdirty(mk_pte(new_page, vma->vm_page_prot)),
  			      vma);
  	ptep_establish(vma, address, page_table, entry);
  	update_mmu_cache(vma, address, entry);
+	lazy_mmu_prot_update(entry);
  }

  /*
@@ -1299,11 +1268,12 @@
  		int reuse = can_share_swap_page(old_page);
  		unlock_page(old_page);
  		if (reuse) {
-			flush_cache_page(vma, address);
+			flush_cache_page(vma, address, pfn);
  			entry = maybe_mkwrite(pte_mkyoung(pte_mkdirty(pte)),
  					      vma);
  			ptep_set_access_flags(vma, address, page_table, entry, 1);
  			update_mmu_cache(vma, address, entry);
+			lazy_mmu_prot_update(entry);
  			pte_unmap(page_table);
  			spin_unlock(&mm->page_table_lock);
  			return VM_FAULT_MINOR;
@@ -1337,13 +1307,12 @@
  	page_table = pte_offset_map(pmd, address);
  	if (likely(pte_same(*page_table, pte))) {
  		if (PageAnon(old_page))
-			mm->anon_rss--;
-		if (PageReserved(old_page)) {
-			++mm->rss;
-			acct_update_integrals();
-			update_mem_hiwater();
-		} else
+			dec_mm_counter(mm, anon_rss);
+		if (PageReserved(old_page))
+			inc_mm_counter(mm, rss);
+		else
  			page_remove_rmap(old_page);
+		flush_cache_page(vma, address, pfn);
  		break_cow(vma, new_page, address, page_table);
  		lru_cache_add_active(new_page);
  		page_add_anon_rmap(new_page, vma, address);
@@ -1387,7 +1356,7 @@
   * i_mmap_lock.
   *
   * In order to make forward progress despite repeatedly restarting some
- * large vma, note the break_addr set by unmap_vmas when it breaks out:
+ * large vma, note the restart_addr from unmap_vmas when it breaks out:
   * and restart from that address when we reach that vma again.  It might
   * have been split or merged, shrunk or extended, but never shifted: so
   * restart_addr remains valid so long as it remains in the vma's range.
@@ -1425,8 +1394,8 @@
  		}
  	}

-	details->break_addr = end_addr;
-	zap_page_range(vma, start_addr, end_addr - start_addr, details);
+	restart_addr = zap_page_range(vma, start_addr,
+					end_addr - start_addr, details);

  	/*
  	 * We cannot rely on the break test in unmap_vmas:
@@ -1437,14 +1406,14 @@
  	need_break = need_resched() ||
  			need_lockbreak(details->i_mmap_lock);

-	if (details->break_addr >= end_addr) {
+	if (restart_addr >= end_addr) {
  		/* We have now completed this vma: mark it so */
  		vma->vm_truncate_count = details->truncate_count;
  		if (!need_break)
  			return 0;
  	} else {
  		/* Note restart_addr in vma's truncate_count field */
-		vma->vm_truncate_count = details->break_addr;
+		vma->vm_truncate_count = restart_addr;
  		if (!need_break)
  			goto again;
  	}
@@ -1732,12 +1701,13 @@
  	spin_lock(&mm->page_table_lock);
  	page_table = pte_offset_map(pmd, address);
  	if (unlikely(!pte_same(*page_table, orig_pte))) {
-		pte_unmap(page_table);
-		spin_unlock(&mm->page_table_lock);
-		unlock_page(page);
-		page_cache_release(page);
  		ret = VM_FAULT_MINOR;
-		goto out;
+		goto out_nomap;
+	}
+
+	if (unlikely(!PageUptodate(page))) {
+		ret = VM_FAULT_SIGBUS;
+		goto out_nomap;
  	}

  	/* The page isn't present yet, go ahead with the fault. */
@@ -1746,10 +1716,7 @@
  	if (vm_swap_full())
  		remove_exclusive_swap_page(page);

-	mm->rss++;
-	acct_update_integrals();
-	update_mem_hiwater();
-
+	inc_mm_counter(mm, rss);
  	pte = mk_pte(page, vma->vm_page_prot);
  	if (write_access && can_share_swap_page(page)) {
  		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
@@ -1758,7 +1725,7 @@
  	unlock_page(page);

  	flush_icache_page(vma, page);
-	set_pte(page_table, pte);
+	set_pte_at(mm, address, page_table, pte);
  	page_add_anon_rmap(page, vma, address);

  	if (write_access) {
@@ -1770,10 +1737,17 @@

  	/* No need to invalidate - it was non-present before */
  	update_mmu_cache(vma, address, pte);
+	lazy_mmu_prot_update(pte);
  	pte_unmap(page_table);
  	spin_unlock(&mm->page_table_lock);
  out:
  	return ret;
+out_nomap:
+	pte_unmap(page_table);
+	spin_unlock(&mm->page_table_lock);
+	unlock_page(page);
+	page_cache_release(page);
+	goto out;
  }

  /*
@@ -1813,9 +1787,7 @@
  			spin_unlock(&mm->page_table_lock);
  			goto out;
  		}
-		mm->rss++;
-		acct_update_integrals();
-		update_mem_hiwater();
+		inc_mm_counter(mm, rss);
  		entry = maybe_mkwrite(pte_mkdirty(mk_pte(page,
  							 vma->vm_page_prot)),
  				      vma);
@@ -1824,11 +1796,12 @@
  		page_add_anon_rmap(page, vma, addr);
  	}

-	set_pte(page_table, entry);
+	set_pte_at(mm, addr, page_table, entry);
  	pte_unmap(page_table);

  	/* No need to invalidate - it was non-present before */
  	update_mmu_cache(vma, addr, entry);
+	lazy_mmu_prot_update(entry);
  	spin_unlock(&mm->page_table_lock);
  out:
  	return VM_FAULT_MINOR;
@@ -1931,15 +1904,13 @@
  	/* Only go through if we didn't race with anybody else... */
  	if (pte_none(*page_table)) {
  		if (!PageReserved(new_page))
-			++mm->rss;
-		acct_update_integrals();
-		update_mem_hiwater();
+			inc_mm_counter(mm, rss);

  		flush_icache_page(vma, new_page);
  		entry = mk_pte(new_page, vma->vm_page_prot);
  		if (write_access)
  			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
-		set_pte(page_table, entry);
+		set_pte_at(mm, address, page_table, entry);
  		if (anon) {
  			lru_cache_add_active(new_page);
  			page_add_anon_rmap(new_page, vma, address);
@@ -1956,6 +1927,7 @@

  	/* no need to invalidate: a not-present page shouldn't be cached */
  	update_mmu_cache(vma, address, entry);
+	lazy_mmu_prot_update(entry);
  	spin_unlock(&mm->page_table_lock);
  out:
  	return ret;
@@ -1983,7 +1955,7 @@
  	 */
  	if (!vma->vm_ops || !vma->vm_ops->populate ||
  			(write_access && !(vma->vm_flags & VM_SHARED))) {
-		pte_clear(pte);
+		pte_clear(mm, address, pte);
  		return do_no_page(mm, vma, address, write_access, pte, pmd);
  	}

@@ -2050,6 +2022,7 @@
  	entry = pte_mkyoung(entry);
  	ptep_set_access_flags(vma, address, pte, entry, write_access);
  	update_mmu_cache(vma, address, entry);
+	lazy_mmu_prot_update(entry);
  	pte_unmap(pte);
  	spin_unlock(&mm->page_table_lock);
  	return VM_FAULT_MINOR;
@@ -2099,15 +2072,12 @@
  	return VM_FAULT_OOM;
  }

-#ifndef __ARCH_HAS_4LEVEL_HACK
+#ifndef __PAGETABLE_PUD_FOLDED
  /*
   * Allocate page upper directory.
   *
   * We've already handled the fast-path in-line, and we own the
   * page table lock.
- *
- * On a two-level or three-level page table, this ends up actually being
- * entirely optimized away.
   */
  pud_t fastcall *__pud_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
  {
@@ -2131,15 +2101,14 @@
   out:
  	return pud_offset(pgd, address);
  }
+#endif /* __PAGETABLE_PUD_FOLDED */

+#ifndef __PAGETABLE_PMD_FOLDED
  /*
   * Allocate page middle directory.
   *
   * We've already handled the fast-path in-line, and we own the
   * page table lock.
- *
- * On a two-level page table, this ends up actually being entirely
- * optimized away.
   */
  pmd_t fastcall *__pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
  {
@@ -2155,38 +2124,24 @@
  	 * Because we dropped the lock, we should re-check the
  	 * entry, as somebody else could have populated it..
  	 */
+#ifndef __ARCH_HAS_4LEVEL_HACK
  	if (pud_present(*pud)) {
  		pmd_free(new);
  		goto out;
  	}
  	pud_populate(mm, pud, new);
- out:
-	return pmd_offset(pud, address);
-}
  #else
-pmd_t fastcall *__pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
-{
-	pmd_t *new;
-
-	spin_unlock(&mm->page_table_lock);
-	new = pmd_alloc_one(mm, address);
-	spin_lock(&mm->page_table_lock);
-	if (!new)
-		return NULL;
-
-	/*
-	 * Because we dropped the lock, we should re-check the
-	 * entry, as somebody else could have populated it..
-	 */
  	if (pgd_present(*pud)) {
  		pmd_free(new);
  		goto out;
  	}
  	pgd_populate(mm, pud, new);
-out:
+#endif /* __ARCH_HAS_4LEVEL_HACK */
+
+ out:
  	return pmd_offset(pud, address);
  }
-#endif
+#endif /* __PAGETABLE_PMD_FOLDED */

  int make_pages_present(unsigned long addr, unsigned long end)
  {
@@ -2253,13 +2208,13 @@
   * update_mem_hiwater
   *	- update per process rss and vm high water data
   */
-void update_mem_hiwater(void)
+void update_mem_hiwater(struct task_struct *tsk)
  {
-	struct task_struct *tsk = current;
-
  	if (tsk->mm) {
-		if (tsk->mm->hiwater_rss < tsk->mm->rss)
-			tsk->mm->hiwater_rss = tsk->mm->rss;
+		unsigned long rss = get_mm_counter(tsk->mm, rss);
+
+		if (tsk->mm->hiwater_rss < rss)
+			tsk->mm->hiwater_rss = rss;
  		if (tsk->mm->hiwater_vm < tsk->mm->total_vm)
  			tsk->mm->hiwater_vm = tsk->mm->total_vm;
  	}

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
