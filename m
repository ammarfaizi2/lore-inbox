Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319456AbSIGIXR>; Sat, 7 Sep 2002 04:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319457AbSIGIXR>; Sat, 7 Sep 2002 04:23:17 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:22791 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S319456AbSIGIXJ>; Sat, 7 Sep 2002 04:23:09 -0400
Date: Sat, 7 Sep 2002 12:27:32 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>,
       Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.5.33] alpha: misc fixes
Message-ID: <20020907122732.C17245@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch set from Jay Estabrook:

./include/asm-alpha/dma.h

	Add MAX_DMA_ADDR for SABLE and ALCOR

./include/asm-alpha/floppy.h

	enable the full CROSS_64KB macro for all platforms

./include/asm-alpha/core_t2.h

	fix HAE usage

./arch/alpha/kernel/pci.c

	fiddle with quirk_cypress

./arch/alpha/kernel/traps.c

	prevent opDEC_check() from multiple calls (EV4 SMP SABLEs)

./arch/alpha/kernel/proto.h

	make t2_pci_tbi() real

./arch/alpha/kernel/time.c

	shorten timeout delay

./arch/alpha/kernel/sys_alcor.c

	use ALCOR_MAX_DMA_ADDR because of the 1GB limit on ISA devices

./arch/alpha/kernel/core_t2.c

	add S/G support and allow direct-map to handle 2GB of memory

./arch/alpha/kernel/core_tsunami.c

	rework alignment requirements for ISA DMA, esp. for ACER platforms

./arch/alpha/kernel/sys_sable.c

	fix MAX_DMA_ADDR for the 1GB limitation

./arch/alpha/kernel/pci_impl.h

	add T2_DEFAULT_MEM_BASE to help avoid HAE use

./arch/alpha/kernel/pci_iommu.c

	fix ISA_DMA_MASK calculation, and force ISA alignment to 64KB


Ivan.

--- 2.5.33/arch/alpha/kernel/pci_iommu.c	Sun Sep  1 02:05:35 2002
+++ linux/arch/alpha/kernel/pci_iommu.c	Sat Sep  7 11:47:23 2002
@@ -30,6 +30,9 @@
 #define DEBUG_NODIRECT 0
 #define DEBUG_FORCEDAC 0
 
+/* Most Alphas support 32-bit ISA DMA. Exceptions are XL, Ruffian,
+   Nautilus, Sable, and Alcor (see asm-alpha/dma.h for details). */
+#define ISA_DMA_MASK	(MAX_DMA_ADDRESS - IDENT_ADDR - 1)
 
 static inline unsigned long
 mk_iommu_pte(unsigned long paddr)
@@ -129,8 +132,8 @@ iommu_arena_find_pages(struct pci_iommu_
 	return p;
 }
 
-long
-iommu_arena_alloc(struct pci_iommu_arena *arena, long n)
+static long
+iommu_arena_alloc(struct pci_iommu_arena *arena, long n, unsigned int align)
 {
 	unsigned long flags;
 	unsigned long *ptes;
@@ -140,7 +143,7 @@ iommu_arena_alloc(struct pci_iommu_arena
 
 	/* Search for N empty ptes */
 	ptes = arena->ptes;
-	mask = arena->align_entry - 1;
+	mask = max(align, arena->align_entry) - 1;
 	p = iommu_arena_find_pages(arena, n, mask);
 	if (p < 0) {
 		spin_unlock_irqrestore(&arena->lock, flags);
@@ -181,7 +184,7 @@ pci_map_single_1(struct pci_dev *pdev, v
 		 int dac_allowed)
 {
 	struct pci_controller *hose = pdev ? pdev->sysdata : pci_isa_hose;
-	dma_addr_t max_dma = pdev ? pdev->dma_mask : 0x00ffffff;
+	dma_addr_t max_dma = pdev ? pdev->dma_mask : ISA_DMA_MASK;
 	struct pci_iommu_arena *arena;
 	long npages, dma_ofs, i;
 	unsigned long paddr;
@@ -232,7 +235,8 @@ pci_map_single_1(struct pci_dev *pdev, v
 		arena = hose->sg_isa;
 
 	npages = calc_npages((paddr & ~PAGE_MASK) + size);
-	dma_ofs = iommu_arena_alloc(arena, npages);
+	/* Force allocation to 64KB boundary for all ISA devices. */
+	dma_ofs = iommu_arena_alloc(arena, npages, pdev ? 8 : 0);
 	if (dma_ofs < 0) {
 		printk(KERN_WARNING "pci_map_single failed: "
 		       "could not allocate dma page tables\n");
@@ -499,7 +503,7 @@ sg_fill(struct scatterlist *leader, stru
 
 	paddr &= ~PAGE_MASK;
 	npages = calc_npages(paddr + size);
-	dma_ofs = iommu_arena_alloc(arena, npages);
+	dma_ofs = iommu_arena_alloc(arena, npages, 0);
 	if (dma_ofs < 0) {
 		/* If we attempted a direct map above but failed, die.  */
 		if (leader->dma_address == 0)
@@ -588,7 +592,7 @@ pci_map_sg(struct pci_dev *pdev, struct 
 	/* Second, figure out where we're going to map things.  */
 	if (alpha_mv.mv_pci_tbi) {
 		hose = pdev ? pdev->sysdata : pci_isa_hose;
-		max_dma = pdev ? pdev->dma_mask : 0x00ffffff;
+		max_dma = pdev ? pdev->dma_mask : ISA_DMA_MASK;
 		arena = hose->sg_pci;
 		if (!arena || arena->dma_base + arena->size - 1 > max_dma)
 			arena = hose->sg_isa;
@@ -651,7 +655,7 @@ pci_unmap_sg(struct pci_dev *pdev, struc
 		return;
 
 	hose = pdev ? pdev->sysdata : pci_isa_hose;
-	max_dma = pdev ? pdev->dma_mask : 0x00ffffff;
+	max_dma = pdev ? pdev->dma_mask : ISA_DMA_MASK;
 	arena = hose->sg_pci;
 	if (!arena || arena->dma_base + arena->size - 1 > max_dma)
 		arena = hose->sg_isa;
--- 2.5.33/arch/alpha/kernel/core_t2.c	Sat Sep  7 11:22:30 2002
+++ linux/arch/alpha/kernel/core_t2.c	Sat Sep  7 11:49:08 2002
@@ -26,6 +26,18 @@
 #include "proto.h"
 #include "pci_impl.h"
 
+/*
+ * By default, we direct-map starting at 2GB, in order to allow the
+ * maximum size direct-map window (2GB) to match the maximum amount of
+ * memory (2GB) that can be present on SABLEs. But that limits the
+ * floppy to DMA only via the scatter/gather window set up for 8MB
+ * ISA DMA, since the maximum ISA DMA address is 2GB-1.
+ *
+ * For now, this seems a reasonable trade-off: even though most SABLEs
+ * have far less than even 1GB of memory, floppy usage/performance will
+ * not really be affected by forcing it to go via scatter/gather...
+ */
+#define T2_DIRECTMAP_2G 1
 
 /*
  * NOTE: Herein lie back-to-back mb instructions.  They are magic. 
@@ -282,6 +294,7 @@ void __init
 t2_init_arch(void)
 {
 	struct pci_controller *hose;
+	unsigned long t2_iocsr;
 	unsigned int i;
 
 	for (i = 0; i < NR_CPUS; i++) {
@@ -290,43 +303,80 @@ t2_init_arch(void)
 	}
 
 #if 0
-	{
-	  /* Set up error reporting.  */
-	  unsigned long t2_err;
+	/* Set up error reporting.  */
+	t2_iocsr = *(vulp)T2_IOCSR;
+	*(vulp)T2_IOCSR = t2_iocsr | (0x1UL << 7); /* TLB error check */
+	mb();
+	*(vulp)T2_IOCSR; /* read it back to make sure */
+#endif
 
-	  t2_err = *(vulp)T2_IOCSR;
-	  t2_err |= (0x1 << 7);   /* master abort */
-	  *(vulp)T2_IOCSR = t2_err;
-	  mb();
+	/* Enable scatter/gather TLB use.  */
+	t2_iocsr = *(vulp)T2_IOCSR;
+	if (!(t2_iocsr & (0x1UL << 26))) {
+		printk("t2_init_arch: enabling SG TLB, IOCSR was 0x%lx\n",
+		       t2_iocsr);
+		*(vulp)T2_IOCSR = t2_iocsr | (0x1UL << 26);
+		mb();	
+		*(vulp)T2_IOCSR; /* read it back to make sure */
 	}
-#endif
 
-	printk("t2_init: HBASE was 0x%lx\n", *(vulp)T2_HBASE);
 #if 0
-	printk("t2_init: WBASE1=0x%lx WMASK1=0x%lx TBASE1=0x%lx\n",
-	       *(vulp)T2_WBASE1,
-	       *(vulp)T2_WMASK1,
-	       *(vulp)T2_TBASE1);
-	printk("t2_init: WBASE2=0x%lx WMASK2=0x%lx TBASE2=0x%lx\n",
-	       *(vulp)T2_WBASE2,
-	       *(vulp)T2_WMASK2,
-	       *(vulp)T2_TBASE2);
+	printk("t2_init_arch: HBASE was 0x%lx\n", *(vulp)T2_HBASE);
+	printk("t2_init_arch: WBASE1=0x%lx WMASK1=0x%lx TBASE1=0x%lx\n",
+	       *(vulp)T2_WBASE1, *(vulp)T2_WMASK1, *(vulp)T2_TBASE1);
+	printk("t2_init_arch: WBASE2=0x%lx WMASK2=0x%lx TBASE2=0x%lx\n",
+	       *(vulp)T2_WBASE2, *(vulp)T2_WMASK2, *(vulp)T2_TBASE2);
 #endif
 
 	/*
+	 * Create our single hose.
+	 */
+
+	pci_isa_hose = hose = alloc_pci_controller();
+	hose->io_space = &ioport_resource;
+	hose->mem_space = &iomem_resource;
+	hose->index = 0;
+
+	hose->sparse_mem_base = T2_SPARSE_MEM - IDENT_ADDR;
+	hose->dense_mem_base = T2_DENSE_MEM - IDENT_ADDR;
+	hose->sparse_io_base = T2_IO - IDENT_ADDR;
+	hose->dense_io_base = 0;
+
+	/* Note we can only do 1 SG window, as the other is for direct, so
+	   do an ISA SG area, especially for the floppy. */
+        hose->sg_isa = iommu_arena_new(hose, 0x00800000, 0x00800000, 0);
+	hose->sg_pci = NULL;
+
+	/*
 	 * Set up the PCI->physical memory translation windows.
-	 * For now, window 2 is  disabled.  In the future, we may
-	 * want to use it to do scatter/gather DMA. 
 	 *
-	 * Window 1 goes at 1 GB and is 1 GB large.
+	 * Window 1 goes at ? GB and is ?GB large, direct mapped.
+	 * Window 2 goes at 8 MB and is 8MB large, scatter/gather (for ISA).
 	 */
 
-	/* WARNING!! must correspond to the DMA_WIN params!!! */
+#if T2_DIRECTMAP_2G
+	__direct_map_base = 0x80000000UL;
+	__direct_map_size = 0x80000000UL;
+
+	/* WARNING!! must correspond to the direct map window params!!! */
+	*(vulp)T2_WBASE1 = 0x80080fffU;
+	*(vulp)T2_WMASK1 = 0x7ff00000U;
+	*(vulp)T2_TBASE1 = 0;
+#else /* T2_DIRECTMAP_2G */
+	__direct_map_base = 0x40000000UL;
+	__direct_map_size = 0x40000000UL;
+
+	/* WARNING!! must correspond to the direct map window params!!! */
 	*(vulp)T2_WBASE1 = 0x400807ffU;
 	*(vulp)T2_WMASK1 = 0x3ff00000U;
 	*(vulp)T2_TBASE1 = 0;
+#endif /* T2_DIRECTMAP_2G */
+
+	/* WARNING!! must correspond to the SG arena/window params!!! */
+	*(vulp)T2_WBASE2 = 0x008c000fU;
+	*(vulp)T2_WMASK2 = 0x00700000U;
+	*(vulp)T2_TBASE2 = virt_to_phys(hose->sg_isa->ptes) >> 1;
 
-	*(vulp)T2_WBASE2 = 0x0;
 	*(vulp)T2_HBASE = 0x0;
 
 	/* Zero HAE.  */
@@ -334,26 +384,28 @@ t2_init_arch(void)
 	*(vulp)T2_HAE_2 = 0; mb();
 	*(vulp)T2_HAE_3 = 0; mb();
 #if 0
-	*(vulp)T2_HAE_4 = 0; mb(); /* do not touch this */
+	*(vulp)T2_HAE_4 = 0; mb(); /* DO NOT TOUCH THIS!!! */
 #endif
 
-	/*
-	 * Create our single hose.
-	 */
+	t2_pci_tbi(hose, 0, -1); /* flush TLB all */
+}
 
-	pci_isa_hose = hose = alloc_pci_controller();
-	hose->io_space = &ioport_resource;
-	hose->mem_space = &iomem_resource;
-	hose->index = 0;
+void
+t2_pci_tbi(struct pci_controller *hose, dma_addr_t start, dma_addr_t end)
+{
+	unsigned long t2_iocsr;
 
-	hose->sparse_mem_base = T2_SPARSE_MEM - IDENT_ADDR;
-	hose->dense_mem_base = T2_DENSE_MEM - IDENT_ADDR;
-	hose->sparse_io_base = T2_IO - IDENT_ADDR;
-	hose->dense_io_base = 0;
+	t2_iocsr = *(vulp)T2_IOCSR;
 
-	hose->sg_isa = hose->sg_pci = NULL;
-	__direct_map_base = 0x40000000;
-	__direct_map_size = 0x40000000;
+	/* set the TLB Clear bit */
+	*(vulp)T2_IOCSR = t2_iocsr | (0x1UL << 28);
+	mb();
+	*(vulp)T2_IOCSR; /* read it back to make sure */
+
+	/* clear the TLB Clear bit */
+	*(vulp)T2_IOCSR = t2_iocsr & ~(0x1UL << 28);
+	mb();
+	*(vulp)T2_IOCSR; /* read it back to make sure */
 }
 
 #define SIC_SEIC (1UL << 33)    /* System Event Clear */
--- 2.5.33/arch/alpha/kernel/core_tsunami.c	Sat Sep  7 11:22:30 2002
+++ linux/arch/alpha/kernel/core_tsunami.c	Sat Sep  7 11:49:08 2002
@@ -317,10 +317,17 @@ tsunami_init_one_pchip(tsunami_pchip *pc
 	 * Window 0 is scatter-gather 8MB at 8MB (for isa)
 	 * Window 1 is scatter-gather (up to) 1GB at 1GB
 	 * Window 2 is direct access 2GB at 2GB
+	 *
+	 * NOTE: we need the align_entry settings for Acer devices on ES40,
+	 * specifically floppy and IDE when memory is larger than 2GB.
 	 */
 	hose->sg_isa = iommu_arena_new(hose, 0x00800000, 0x00800000, 0);
+	/* Initially set for 4 PTEs, but will be overridden to 64K for ISA. */
+        hose->sg_isa->align_entry = 4;
+
 	hose->sg_pci = iommu_arena_new(hose, 0x40000000,
 				       size_for_memory(0x40000000), 0);
+        hose->sg_pci->align_entry = 4; /* Tsunami caches 4 PTEs at a time */
 
 	__direct_map_base = 0x80000000;
 	__direct_map_size = 0x80000000;
--- 2.5.33/arch/alpha/kernel/pci.c	Sun Sep  1 02:04:48 2002
+++ linux/arch/alpha/kernel/pci.c	Sat Sep  7 11:50:46 2002
@@ -97,15 +97,22 @@ quirk_cypress(struct pci_dev *dev)
 	   way to turn this off.  The bridge also supports several extended
 	   BIOS ranges (disabled after power-up), and some consoles do turn
 	   them on.  So if we use a large direct-map window, or a large SG
-	   window, we must avoid entire 0xfff00000-0xffffffff region.  */
+	   window, we must avoid the entire 0xfff00000-0xffffffff region.  */
 	else if (dev->class >> 8 == PCI_CLASS_BRIDGE_ISA) {
-		if (__direct_map_base + __direct_map_size >= 0xfff00000)
-			__direct_map_size = 0xfff00000 - __direct_map_base;
-		else {
+#define DMAPSZ (max_low_pfn << PAGE_SHIFT) /* memory size, not window size */
+		if ((__direct_map_base + DMAPSZ - 1) >= 0xfff00000UL) {
+			__direct_map_size = 0xfff00000UL - __direct_map_base;
+			printk("%s: adjusting direct map size to 0x%x\n",
+			       __FUNCTION__, __direct_map_size);
+		} else {
 			struct pci_controller *hose = dev->sysdata;
 			struct pci_iommu_arena *pci = hose->sg_pci;
-			if (pci && pci->dma_base + pci->size >= 0xfff00000)
-				pci->size = 0xfff00000 - pci->dma_base;
+			if (pci &&
+			    (pci->dma_base + pci->size - 1) >= 0xfff00000UL) {
+				pci->size = 0xfff00000UL - pci->dma_base;
+ 				printk("%s: adjusting PCI S/G size to 0x%x\n",
+				       __FUNCTION__, pci->size);
+			}
 		}
 	}
 }
--- 2.5.33/arch/alpha/kernel/pci_impl.h	Sun Sep  1 02:05:34 2002
+++ linux/arch/alpha/kernel/pci_impl.h	Sat Sep  7 11:51:33 2002
@@ -52,15 +52,16 @@ struct pci_iommu_arena;
 #define APECS_AND_LCA_DEFAULT_MEM_BASE ((16+2)*1024*1024)
 
 /*
- * Because the MCPCIA core logic supports more bits for physical addresses,
- * it should allow an expanded range of SPARSE memory addresses.
- * However, we do not use them all, in order to avoid the HAE manipulation
- * that would be needed.
+ * Because MCPCIA and T2 core logic support more bits for
+ * physical addresses, they should allow an expanded range of SPARSE
+ * memory addresses.  However, we do not use them all, in order to
+ * avoid the HAE manipulation that would be needed.
  */
 #define MCPCIA_DEFAULT_MEM_BASE ((32+2)*1024*1024)
+#define T2_DEFAULT_MEM_BASE ((16+1)*1024*1024)
 
 /*
- * Because CIA and PYXIS and T2 have more bits for physical addresses,
+ * Because CIA and PYXIS have more bits for physical addresses,
  * they support an expanded range of SPARSE memory addresses.
  */
 #define DEFAULT_MEM_BASE ((128+16)*1024*1024)
@@ -157,8 +158,6 @@ extern struct resource *alloc_resource(v
 extern struct pci_iommu_arena *iommu_arena_new(struct pci_controller *,
 					       dma_addr_t, unsigned long,
 					       unsigned long);
-extern long iommu_arena_alloc(struct pci_iommu_arena *arena, long n);
-
 extern const char *const pci_io_names[];
 extern const char *const pci_mem_names[];
 extern const char pci_hae0_name[];
--- 2.5.33/arch/alpha/kernel/proto.h	Sun Sep  1 02:04:52 2002
+++ linux/arch/alpha/kernel/proto.h	Sat Sep  7 11:49:08 2002
@@ -59,7 +59,7 @@ extern void polaris_machine_check(u64, u
 extern struct pci_ops t2_pci_ops;
 extern void t2_init_arch(void);
 extern void t2_machine_check(u64, u64, struct pt_regs *);
-#define t2_pci_tbi ((void *)0)
+extern void t2_pci_tbi(struct pci_controller *, dma_addr_t, dma_addr_t);
 
 /* core_titan.c */
 extern struct pci_ops titan_pci_ops;
--- 2.5.33/arch/alpha/kernel/sys_alcor.c	Sun Sep  1 02:04:59 2002
+++ linux/arch/alpha/kernel/sys_alcor.c	Sat Sep  7 11:49:08 2002
@@ -251,7 +251,7 @@ struct alpha_machine_vector alcor_mv __i
 	DO_CIA_IO,
 	DO_CIA_BUS,
 	machine_check:		cia_machine_check,
-	max_dma_address:	ALPHA_MAX_DMA_ADDRESS,
+	max_dma_address:	ALPHA_ALCOR_MAX_DMA_ADDRESS,
 	min_io_address:		EISA_DEFAULT_IO_BASE,
 	min_mem_address:	CIA_DEFAULT_MEM_BASE,
 
--- 2.5.33/arch/alpha/kernel/sys_sable.c	Sun Sep  1 02:04:49 2002
+++ linux/arch/alpha/kernel/sys_sable.c	Sat Sep  7 11:49:08 2002
@@ -290,9 +290,9 @@ struct alpha_machine_vector sable_mv __i
 	DO_T2_IO,
 	DO_T2_BUS,
 	machine_check:		t2_machine_check,
-	max_dma_address:	ALPHA_MAX_DMA_ADDRESS,
+	max_dma_address:	ALPHA_SABLE_MAX_DMA_ADDRESS,
 	min_io_address:		EISA_DEFAULT_IO_BASE,
-	min_mem_address:	DEFAULT_MEM_BASE,
+	min_mem_address:	T2_DEFAULT_MEM_BASE,
 
 	nr_irqs:		40,
 	device_interrupt:	sable_srm_device_interrupt,
@@ -322,9 +322,9 @@ struct alpha_machine_vector sable_gamma_
 	DO_T2_IO,
 	DO_T2_BUS,
 	machine_check:		t2_machine_check,
-	max_dma_address:	ALPHA_MAX_DMA_ADDRESS,
+	max_dma_address:	ALPHA_SABLE_MAX_DMA_ADDRESS,
 	min_io_address:		EISA_DEFAULT_IO_BASE,
-	min_mem_address:	DEFAULT_MEM_BASE,
+	min_mem_address:	T2_DEFAULT_MEM_BASE,
 
 	nr_irqs:		40,
 	device_interrupt:	sable_srm_device_interrupt,
--- 2.5.33/arch/alpha/kernel/time.c	Sun Sep  1 02:05:23 2002
+++ linux/arch/alpha/kernel/time.c	Sat Sep  7 11:49:08 2002
@@ -185,8 +185,8 @@ validate_cc_value(unsigned long cc)
 		unsigned int min, max;
 	} cpu_hz[] __initdata = {
 		[EV3_CPU]    = {   50000000,  200000000 },	/* guess */
-		[EV4_CPU]    = {  150000000,  300000000 },
-		[LCA4_CPU]   = {  150000000,  300000000 },	/* guess */
+		[EV4_CPU]    = {  100000000,  300000000 },
+		[LCA4_CPU]   = {  100000000,  300000000 },	/* guess */
 		[EV45_CPU]   = {  200000000,  300000000 },
 		[EV5_CPU]    = {  250000000,  433000000 },
 		[EV56_CPU]   = {  333000000,  667000000 },
@@ -257,12 +257,12 @@ calibrate_cc_with_pic(void)
 
 	cc = rpcc();
 	do {
-		count++;
+	  count+=100; /* by 1 takes too long to timeout from 0 */
 	} while ((inb(0x61) & 0x20) == 0 && count > 0);
 	cc = rpcc() - cc;
 
 	/* Error: ECTCNEVERSET or ECPUTOOFAST.  */
-	if (count <= 1)
+	if (count <= 100)
 		return 0;
 
 	/* Error: ECPUTOOSLOW.  */
--- 2.5.33/arch/alpha/kernel/traps.c	Sun Sep  1 02:04:53 2002
+++ linux/arch/alpha/kernel/traps.c	Sat Sep  7 11:49:08 2002
@@ -29,6 +29,7 @@
 */
 static int opDEC_testing = 0;
 static int opDEC_fix = 0;
+static int opDEC_checked = 0;
 static unsigned long opDEC_test_pc = 0;
 
 static void
@@ -36,6 +37,8 @@ opDEC_check(void)
 {
 	unsigned long test_pc;
 
+	if (opDEC_checked) return;
+
 	lock_kernel();
 	opDEC_testing = 1;
 
@@ -48,6 +51,7 @@ opDEC_check(void)
 		: );
 
 	opDEC_testing = 0;
+	opDEC_checked = 1;
 	unlock_kernel();
 }
 
--- 2.5.33/include/asm-alpha/core_t2.h	Sun Sep  1 02:05:17 2002
+++ linux/include/asm-alpha/core_t2.h	Sat Sep  7 11:49:08 2002
@@ -19,7 +19,7 @@
  *
  */
 
-#define T2_MEM_R1_MASK 0x03ffffff  /* Mem sparse region 1 mask is 26 bits */
+#define T2_MEM_R1_MASK 0x07ffffff  /* Mem sparse region 1 mask is 26 bits */
 
 /* GAMMA-SABLE is a SABLE with EV5-based CPUs */
 #define _GAMMA_BIAS		0x8000000000UL
@@ -402,13 +402,17 @@ __EXTERN_INLINE void t2_outl(u32 b, unsi
  *
  */
 
+#define t2_set_hae { \
+	msb = addr  >> 27; \
+	addr &= T2_MEM_R1_MASK; \
+	set_hae(msb); \
+}
+
 __EXTERN_INLINE u8 t2_readb(unsigned long addr)
 {
 	unsigned long result, msb;
 
-	msb = addr & 0xE0000000;
-	addr &= T2_MEM_R1_MASK;
-	set_hae(msb);
+	t2_set_hae;
 
 	result = *(vip) ((addr << 5) + T2_SPARSE_MEM + 0x00);
 	return __kernel_extbl(result, addr & 3);
@@ -418,9 +422,7 @@ __EXTERN_INLINE u16 t2_readw(unsigned lo
 {
 	unsigned long result, msb;
 
-	msb = addr & 0xE0000000;
-	addr &= T2_MEM_R1_MASK;
-	set_hae(msb);
+	t2_set_hae;
 
 	result = *(vuip) ((addr << 5) + T2_SPARSE_MEM + 0x08);
 	return __kernel_extwl(result, addr & 3);
@@ -431,9 +433,7 @@ __EXTERN_INLINE u32 t2_readl(unsigned lo
 {
 	unsigned long msb;
 
-	msb = addr & 0xE0000000;
-	addr &= T2_MEM_R1_MASK;
-	set_hae(msb);
+	t2_set_hae;
 
 	return *(vuip) ((addr << 5) + T2_SPARSE_MEM + 0x18);
 }
@@ -442,9 +442,7 @@ __EXTERN_INLINE u64 t2_readq(unsigned lo
 {
 	unsigned long r0, r1, work, msb;
 
-	msb = addr & 0xE0000000;
-	addr &= T2_MEM_R1_MASK;
-	set_hae(msb);
+	t2_set_hae;
 
 	work = (addr << 5) + T2_SPARSE_MEM + 0x18;
 	r0 = *(vuip)(work);
@@ -456,9 +454,7 @@ __EXTERN_INLINE void t2_writeb(u8 b, uns
 {
 	unsigned long msb, w;
 
-	msb = addr & 0xE0000000;
-	addr &= T2_MEM_R1_MASK;
-	set_hae(msb);
+	t2_set_hae;
 
 	w = __kernel_insbl(b, addr & 3);
 	*(vuip) ((addr << 5) + T2_SPARSE_MEM + 0x00) = w;
@@ -468,9 +464,7 @@ __EXTERN_INLINE void t2_writew(u16 b, un
 {
 	unsigned long msb, w;
 
-	msb = addr & 0xE0000000;
-	addr &= T2_MEM_R1_MASK;
-	set_hae(msb);
+	t2_set_hae;
 
 	w = __kernel_inswl(b, addr & 3);
 	*(vuip) ((addr << 5) + T2_SPARSE_MEM + 0x08) = w;
@@ -481,9 +475,7 @@ __EXTERN_INLINE void t2_writel(u32 b, un
 {
 	unsigned long msb;
 
-	msb = addr & 0xE0000000;
-	addr &= T2_MEM_R1_MASK;
-	set_hae(msb);
+	t2_set_hae;
 
 	*(vuip) ((addr << 5) + T2_SPARSE_MEM + 0x18) = b;
 }
@@ -492,9 +484,7 @@ __EXTERN_INLINE void t2_writeq(u64 b, un
 {
 	unsigned long msb, work;
 
-	msb = addr & 0xE0000000;
-	addr &= T2_MEM_R1_MASK;
-	set_hae(msb);
+	t2_set_hae;
 
 	work = (addr << 5) + T2_SPARSE_MEM + 0x18;
 	*(vuip)work = b;
--- 2.5.33/include/asm-alpha/dma.h	Sun Sep  1 02:05:31 2002
+++ linux/include/asm-alpha/dma.h	Sat Sep  7 11:49:08 2002
@@ -75,34 +75,49 @@
 
 #define MAX_DMA_CHANNELS	8
 
-/* The maximum address that we can perform a DMA transfer to on Alpha XL,
-   due to a hardware SIO (PCI<->ISA bus bridge) chip limitation, is 64MB.
-   See <asm/apecs.h> for more info.
+/*
+  ISA DMA limitations on Alpha platforms,
+
+  These may be due to SIO (PCI<->ISA bridge) chipset limitation, or
+  just a wiring limit.
+*/
+
+/* The maximum address for ISA DMA transfer on Alpha XL, due to an
+   hardware SIO limitation, is 64MB.
 */
-/* The maximum address that we can perform a DMA transfer to on RUFFIAN,
-   due to a hardware SIO (PCI<->ISA bus bridge) chip limitation, is 16MB.
-   See <asm/pyxis.h> for more info.
+#define ALPHA_XL_MAX_DMA_ADDRESS	(IDENT_ADDR+0x04000000UL)
+
+/* The maximum address for ISA DMA transfer on RUFFIAN and NAUTILUS,
+   due to an hardware SIO limitation, is 16MB.
 */
-/* NOTE: we must define the maximum as something less than 64Mb, to prevent 
-   virt_to_bus() from returning an address in the first window, for a
-   data area that goes beyond the 64Mb first DMA window. Sigh...
-   We MUST coordinate the maximum with <asm/apecs.h> for consistency.
-   For now, this limit is set to 48Mb...
+#define ALPHA_RUFFIAN_MAX_DMA_ADDRESS	(IDENT_ADDR+0x01000000UL)
+#define ALPHA_NAUTILUS_MAX_DMA_ADDRESS	(IDENT_ADDR+0x01000000UL)
+
+/* The maximum address for ISA DMA transfer on SABLE, and some ALCORs,
+   due to an hardware SIO chip limitation, is 2GB.
+*/
+#define ALPHA_SABLE_MAX_DMA_ADDRESS	(IDENT_ADDR+0x80000000UL)
+#define ALPHA_ALCOR_MAX_DMA_ADDRESS	(IDENT_ADDR+0x80000000UL)
+
+/*
+  Maximum address for all the others is the complete 32-bit bus
+  address space.
 */
-#define ALPHA_XL_MAX_DMA_ADDRESS	(IDENT_ADDR+0x3000000UL)
-#define ALPHA_RUFFIAN_MAX_DMA_ADDRESS	(IDENT_ADDR+0x1000000UL)
-#define ALPHA_NAUTILUS_MAX_DMA_ADDRESS	(IDENT_ADDR+0x1000000UL)
-#define ALPHA_MAX_DMA_ADDRESS		(~0UL)
+#define ALPHA_MAX_DMA_ADDRESS		(IDENT_ADDR+0x100000000UL)
 
 #ifdef CONFIG_ALPHA_GENERIC
 # define MAX_DMA_ADDRESS		(alpha_mv.max_dma_address)
 #else
-# ifdef CONFIG_ALPHA_XL
+# if defined(CONFIG_ALPHA_XL)
 #  define MAX_DMA_ADDRESS		ALPHA_XL_MAX_DMA_ADDRESS
 # elif defined(CONFIG_ALPHA_RUFFIAN)
 #  define MAX_DMA_ADDRESS		ALPHA_RUFFIAN_MAX_DMA_ADDRESS
 # elif defined(CONFIG_ALPHA_NAUTILUS)
 #  define MAX_DMA_ADDRESS		ALPHA_NAUTILUS_MAX_DMA_ADDRESS
+# elif defined(CONFIG_ALPHA_SABLE)
+#  define MAX_DMA_ADDRESS		ALPHA_SABLE_MAX_DMA_ADDRESS
+# elif defined(CONFIG_ALPHA_ALCOR)
+#  define MAX_DMA_ADDRESS		ALPHA_ALCOR_MAX_DMA_ADDRESS
 # else
 #  define MAX_DMA_ADDRESS		ALPHA_MAX_DMA_ADDRESS
 # endif
--- 2.5.33/include/asm-alpha/floppy.h	Sun Sep  1 02:05:34 2002
+++ linux/include/asm-alpha/floppy.h	Sat Sep  7 11:49:08 2002
@@ -97,24 +97,21 @@ static int FDC2 = -1;
 
 /*
  * Most Alphas have no problems with floppy DMA crossing 64k borders,
- * except for XL and RUFFIAN.  They are also the only one with DMA
- * limits, so we use that to test in the generic kernel.
+ * except for certain ones, like XL and RUFFIAN.
+ *
+ * However, the test is simple and fast, and this *is* floppy, after all,
+ * so we do it for all platforms, just to make sure.
+ *
+ * This is advantageous in other circumstances as well, as in moving
+ * about the PCI DMA windows and forcing the floppy to start doing
+ * scatter-gather when it never had before, and there *is* a problem
+ * on that platform... ;-}
  */
 
-#define __CROSS_64KB(a,s)					\
+#define CROSS_64KB(a,s)						\
 ({ unsigned long __s64 = (unsigned long)(a);			\
    unsigned long __e64 = __s64 + (unsigned long)(s) - 1;	\
    (__s64 ^ __e64) & ~0xfffful; })
-
-#ifdef CONFIG_ALPHA_GENERIC
-# define CROSS_64KB(a,s)   (__CROSS_64KB(a,s) && ~alpha_mv.max_dma_address)
-#else
-# if defined(CONFIG_ALPHA_XL) || defined(CONFIG_ALPHA_RUFFIAN) || defined(CONFIG_ALPHA_NAUTILUS)
-#  define CROSS_64KB(a,s)  __CROSS_64KB(a,s)
-# else
-#  define CROSS_64KB(a,s)  (0)
-# endif
-#endif
 
 #define EXTRA_FLOPPY_PARAMS
 
