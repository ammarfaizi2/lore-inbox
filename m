Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261306AbRERRw3>; Fri, 18 May 2001 13:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261314AbRERRwU>; Fri, 18 May 2001 13:52:20 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:7172 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S261306AbRERRwI>; Fri, 18 May 2001 13:52:08 -0400
Date: Fri, 18 May 2001 21:46:17 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org
Subject: alpha iommu fixes
Message-ID: <20010518214617.A701@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The most interesting thing here is the pyxis "tbia" fix.
Whee! I can now copy files from SCSI to bus-master IDE, or
between two IDE drives on separate channels, or do other nice
things without hanging lx/sx164. :-)
The pyxis "tbia" turned out to be broken in a more nastier way
than one could expect - tech details are commented in the patch.

Another problem, I think, is that we need extra locking in
pci_unmap_xx(). It seems to be possible that after the scatter-gather
table "wraps" and some SG ptes get free, these ptes might be
immediately allocated and next_entry pointer advanced by pci_map_xx()
from interrupt or another CPU *before* the test for mv_pci_tbi().
In this case we'd have stale TLB entries.

Also small compile fix for 2.4.5-pre3.

Ivan.

--- 2.4.5p3/arch/alpha/kernel/core_cia.c	Fri Mar 30 19:02:39 2001
+++ linux/arch/alpha/kernel/core_cia.c	Fri May 18 13:50:51 2001
@@ -297,106 +297,82 @@ struct pci_ops cia_pci_ops = 
  * It cannot be invalidated.  Rather than hard code the pass numbers,
  * actually try the tbia to see if it works.
  */
-
-void
-cia_pci_tbi(struct pci_controller *hose, dma_addr_t start, dma_addr_t end)
-{
-	wmb();
-	*(vip)CIA_IOC_PCI_TBIA = 3;	/* Flush all locked and unlocked.  */
-	mb();
-	*(vip)CIA_IOC_PCI_TBIA;
-}
-
-/*
- * Fixup attempt number 1.
- *
- * Write zeros directly into the tag registers.
+/* Even if the tbia works, we cannot use it. It effectively locks the
+ * chip (as well as direct write to the tag registers) if there is a
+ * SG DMA operation in progress. This is true at least for PYXIS rev. 1.
  */
-
-static void
-cia_pci_tbi_try1(struct pci_controller *hose,
-		 dma_addr_t start, dma_addr_t end)
-{
-	wmb();
-	*(vip)CIA_IOC_TB_TAGn(0) = 0;
-	*(vip)CIA_IOC_TB_TAGn(1) = 0;
-	*(vip)CIA_IOC_TB_TAGn(2) = 0;
-	*(vip)CIA_IOC_TB_TAGn(3) = 0;
-	*(vip)CIA_IOC_TB_TAGn(4) = 0;
-	*(vip)CIA_IOC_TB_TAGn(5) = 0;
-	*(vip)CIA_IOC_TB_TAGn(6) = 0;
-	*(vip)CIA_IOC_TB_TAGn(7) = 0;
-	mb();
-	*(vip)CIA_IOC_TB_TAGn(0);
-}
-
-#if 0
 /*
- * Fixup attempt number 2.  This is the method NT and NetBSD use.
+ * This is the method NT and NetBSD use.
  *
  * Allocate mappings, and put the chip into DMA loopback mode to read a
  * garbage page.  This works by causing TLB misses, causing old entries to
  * be purged to make room for the new entries coming in for the garbage page.
  */
 
-#define CIA_BROKEN_TBI_TRY2_BASE	0xE0000000
+#define CIA_BROKEN_TBIA_BASE	0xE0000000
+#define CIA_BROKEN_TBIA_SIZE	1024
 
-static void __init
-cia_enable_broken_tbi_try2(void)
+static inline void
+cia_enable_broken_tbia(void)
 {
 	unsigned long *ppte, pte;
 	long i;
 
-	ppte = __alloc_bootmem(PAGE_SIZE, 32768, 0);
+	/* Use minimal 1K map. */
+	ppte = __alloc_bootmem(CIA_BROKEN_TBIA_SIZE, 32768, 0);
 	pte = (virt_to_phys(ppte) >> (PAGE_SHIFT - 1)) | 1;
 
-	for (i = 0; i < PAGE_SIZE / sizeof(unsigned long); ++i)
+	for (i = 0; i < CIA_BROKEN_TBIA_SIZE / sizeof(unsigned long); ++i)
 		ppte[i] = pte;
 
-	*(vip)CIA_IOC_PCI_W3_BASE = CIA_BROKEN_TBI_TRY2_BASE | 3;
-	*(vip)CIA_IOC_PCI_W3_MASK = (PAGE_SIZE - 1) & 0xfff00000;
+	*(vip)CIA_IOC_PCI_W3_BASE = CIA_BROKEN_TBIA_BASE | 3;
+	*(vip)CIA_IOC_PCI_W3_MASK = (CIA_BROKEN_TBIA_SIZE*1024 - 1)
+				    & 0xfff00000;
 	*(vip)CIA_IOC_PCI_T3_BASE = virt_to_phys(ppte) >> 2;
 }
 
-static void
-cia_pci_tbi_try2(struct pci_controller *hose,
+void
+cia_pci_tbi(struct pci_controller *hose,
 		 dma_addr_t start, dma_addr_t end)
 {
-	unsigned long flags;
 	unsigned long bus_addr;
 	int ctrl;
-	long i;
 
-	__save_and_cli(flags);
+/*	__save_and_cli(flags);	Don't need this -- we're called from
+				pci_unmap_xx() or iommu_arena_alloc()
+				with IPL_MAX after spin_lock_irqsave() */
 
 	/* Put the chip into PCI loopback mode.  */
 	mb();
 	ctrl = *(vip)CIA_IOC_CIA_CTRL;
 	*(vip)CIA_IOC_CIA_CTRL = ctrl | CIA_CTRL_PCI_LOOP_EN;
 	mb();
-	*(vip)CIA_IOC_CIA_CTRL;
-	mb();
 
 	/* Read from PCI dense memory space at TBI_ADDR, skipping 32k on
 	   each read.  This forces SG TLB misses.  NetBSD claims that the
 	   TLB entries are not quite LRU, meaning that we need to read more
 	   times than there are actual tags.  The 2117x docs claim strict
 	   round-robin.  Oh well, we've come this far...  */
-
-	bus_addr = cia_ioremap(CIA_BROKEN_TBI_TRY2_BASE);
-	for (i = 0; i < 12; ++i, bus_addr += 32768)
-		cia_readl(bus_addr);
+	/* Even better - as seen on the PYXIS rev 1 the TLB tags 0-3 can
+	   be filled by the TLB misses *only once* after being invalidated
+	   (by tbia or direct write). Next misses won't update them even
+	   though the lock bits are cleared. Tags 4-7 are "quite LRU" though,
+	   so use them and read at window 3 base exactly 4 times. -ink */
+
+	bus_addr = cia_ioremap(CIA_BROKEN_TBIA_BASE);
+
+	cia_readl(bus_addr + 0x00000);
+	cia_readl(bus_addr + 0x08000);
+	cia_readl(bus_addr + 0x10000);
+	cia_readl(bus_addr + 0x18000);
 
 	/* Restore normal PCI operation.  */
 	mb();
 	*(vip)CIA_IOC_CIA_CTRL = ctrl;
 	mb();
-	*(vip)CIA_IOC_CIA_CTRL;
-	mb();
 
-	__restore_flags(flags);
+/*	__restore_flags(flags);	*/
 }
-#endif
 
 static void __init
 verify_tb_operation(void)
@@ -440,10 +416,6 @@ verify_tb_operation(void)
 	/* First, verify we can read back what we've written.  If
 	   this fails, we can't be sure of any of the other testing
 	   we're going to do, so bail.  */
-	/* ??? Actually, we could do the work with machine checks.
-	   By passing this register update test, we pretty much
-	   guarantee that cia_pci_tbi_try1 works.  If this test
-	   fails, cia_pci_tbi_try2 might still work.  */
 
 	temp = *(vip)CIA_IOC_TB_TAGn(0);
 	if (temp != tag0) {
@@ -487,27 +459,7 @@ verify_tb_operation(void)
 	}
 	printk("pci: passed sg loopback i/o read test\n");
 
-	/* Third, try to invalidate the TLB.  */
-
-	cia_pci_tbi(arena->hose, 0, -1);
-	temp = *(vip)CIA_IOC_TB_TAGn(0);
-	if (temp & 1) {
-		cia_pci_tbi_try1(arena->hose, 0, -1);
-	
-		temp = *(vip)CIA_IOC_TB_TAGn(0);
-		if (temp & 1) {
-			printk("pci: failed tbia test; "
-			       "no usable workaround\n");
-			goto failed;
-		}
-
-		alpha_mv.mv_pci_tbi = cia_pci_tbi_try1;
-		printk("pci: failed tbia test; workaround 1 succeeded\n");
-	} else {
-		printk("pci: passed tbia test\n");
-	}
-
-	/* Fourth, verify the TLB snoops the EV5's caches when
+	/* Third, verify the TLB snoops the EV5's caches when
 	   doing a tlb fill.  */
 
 	data0 = 0x5adda15e;
@@ -531,7 +483,7 @@ verify_tb_operation(void)
 	}
 	printk("pci: passed pte write cache snoop test\n");
 
-	/* Fifth, verify that a previously invalid PTE entry gets
+	/* Fourth, verify that a previously invalid PTE entry gets
 	   filled from the page table.  */
 
 	data0 = 0xabcdef12;
@@ -558,7 +510,7 @@ verify_tb_operation(void)
 		printk("pci: passed valid tag invalid pte reload test\n");
 	}
 
-	/* Sixth, verify machine checks are working.  Test invalid
+	/* Fifth, verify machine checks are working.  Test invalid
 	   pte under the same valid tag as we used above.  */
 
 	mcheck_expected(0) = 1;
@@ -571,9 +523,19 @@ verify_tb_operation(void)
 	printk("pci: %s pci machine check test\n",
 	       mcheck_taken(0) ? "passed" : "failed");
 
+	printk("pci: broken tbia workaround enabled\n");
+
 	/* Clean up after the tests.  */
 	arena->ptes[4] = 0;
 	arena->ptes[5] = 0;
+
+	/* Disable tags 0-3 with the lock bit */
+	wmb();
+	*(vip)CIA_IOC_TB_TAGn(0) = 2;
+	*(vip)CIA_IOC_TB_TAGn(1) = 2;
+	*(vip)CIA_IOC_TB_TAGn(2) = 2;
+	*(vip)CIA_IOC_TB_TAGn(3) = 2;
+
 	alpha_mv.mv_pci_tbi(arena->hose, 0, -1);
 
 exit:
@@ -706,7 +668,7 @@ do_init_arch(int is_pyxis)
 	*(vip)CIA_IOC_PCI_W2_MASK = (0x40000000 - 1) & 0xfff00000;
 	*(vip)CIA_IOC_PCI_T2_BASE = 0x40000000 >> 2;
 
-	*(vip)CIA_IOC_PCI_W3_BASE = 0;
+	cia_enable_broken_tbia();
 }
 
 void __init
--- 2.4.5p3/arch/alpha/kernel/pci_iommu.c	Fri Mar 30 19:02:39 2001
+++ linux/arch/alpha/kernel/pci_iommu.c	Fri May 18 14:05:19 2001
@@ -175,7 +175,7 @@ pci_map_single(struct pci_dev *pdev, voi
 	/* If the machine doesn't define a pci_tbi routine, we have to
 	   assume it doesn't support sg mapping.  */
 	if (! alpha_mv.mv_pci_tbi) {
-		printk(KERN_INFO "pci_map_single failed: no hw sg\n");
+		printk(KERN_WARNING "pci_map_single failed: no hw sg\n");
 		return 0;
 	}
 		
@@ -186,7 +186,7 @@ pci_map_single(struct pci_dev *pdev, voi
 	npages = calc_npages((paddr & ~PAGE_MASK) + size);
 	dma_ofs = iommu_arena_alloc(arena, npages);
 	if (dma_ofs < 0) {
-		printk(KERN_INFO "pci_map_single failed: "
+		printk(KERN_WARNING "pci_map_single failed: "
 		       "could not allocate dma page tables\n");
 		return 0;
 	}
@@ -215,6 +215,7 @@ void
 pci_unmap_single(struct pci_dev *pdev, dma_addr_t dma_addr, long size,
 		 int direction)
 {
+	unsigned long flags;
 	struct pci_controller *hose = pdev ? pdev->sysdata : pci_isa_hose;
 	struct pci_iommu_arena *arena;
 	long dma_ofs, npages;
@@ -248,6 +249,9 @@ pci_unmap_single(struct pci_dev *pdev, d
 	}
 
 	npages = calc_npages((dma_addr & ~PAGE_MASK) + size);
+
+	spin_lock_irqsave(&arena->lock, flags);
+
 	iommu_arena_free(arena, dma_ofs, npages);
 
 
@@ -259,6 +263,8 @@ pci_unmap_single(struct pci_dev *pdev, d
 	if (dma_ofs >= arena->next_entry)
 		alpha_mv.mv_pci_tbi(hose, dma_addr, dma_addr + size - 1);
 
+	spin_unlock_irqrestore(&arena->lock, flags);
+
 	DBGA("pci_unmap_single: sg [%x,%lx] np %ld from %p\n",
 	     dma_addr, size, npages, __builtin_return_address(0));
 }
@@ -503,13 +509,13 @@ pci_map_sg(struct pci_dev *pdev, struct 
 		out->dma_length = 0;
 
 	if (out - start == 0)
-		printk(KERN_INFO "pci_map_sg failed: no entries?\n");
+		printk(KERN_WARNING "pci_map_sg failed: no entries?\n");
 	DBGA("pci_map_sg: %ld entries\n", out - start);
 
 	return out - start;
 
 error:
-	printk(KERN_INFO "pci_map_sg failed: "
+	printk(KERN_WARNING "pci_map_sg failed: "
 	       "could not allocate dma page tables\n");
 
 	/* Some allocation failed while mapping the scatterlist
@@ -528,6 +534,7 @@ void
 pci_unmap_sg(struct pci_dev *pdev, struct scatterlist *sg, int nents,
 	     int direction)
 {
+	unsigned long flags;
 	struct pci_controller *hose;
 	struct pci_iommu_arena *arena;
 	struct scatterlist *end;
@@ -547,6 +554,9 @@ pci_unmap_sg(struct pci_dev *pdev, struc
 		arena = hose->sg_isa;
 
 	fbeg = -1, fend = 0;
+
+	spin_lock_irqsave(&arena->lock, flags);
+
 	for (end = sg + nents; sg < end; ++sg) {
 		unsigned long addr, size;
 		long npages, ofs;
@@ -586,6 +596,8 @@ pci_unmap_sg(struct pci_dev *pdev, struc
 	*/
 	if ((fend - arena->dma_base) >> PAGE_SHIFT >= arena->next_entry)
 		alpha_mv.mv_pci_tbi(hose, fbeg, fend);
+
+	spin_unlock_irqrestore(&arena->lock, flags);
 
 	DBGA("pci_unmap_sg: %d entries\n", nents - (end - sg));
 }
--- 2.4.5p3/arch/alpha/kernel/setup.c	Fri Mar  2 22:12:07 2001
+++ linux/arch/alpha/kernel/setup.c	Fri May 18 19:43:15 2001
@@ -29,6 +29,7 @@
 #include <linux/string.h>
 #include <linux/ioport.h>
 #include <linux/bootmem.h>
+#include <linux/pci.h>
 
 #ifdef CONFIG_BLK_DEV_INITRD
 #include <linux/blk.h>
@@ -49,7 +50,6 @@ static struct notifier_block alpha_panic
 #include <asm/hwrpb.h>
 #include <asm/dma.h>
 #include <asm/io.h>
-#include <asm/pci.h>
 #include <asm/mmu_context.h>
 #include <asm/console.h>
 
