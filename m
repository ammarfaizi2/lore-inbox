Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261186AbSJHPyD>; Tue, 8 Oct 2002 11:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261205AbSJHPyC>; Tue, 8 Oct 2002 11:54:02 -0400
Received: from zeus.kernel.org ([204.152.189.113]:12235 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261186AbSJHPxy>;
	Tue, 8 Oct 2002 11:53:54 -0400
Date: Tue, 8 Oct 2002 19:58:19 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.5.41] alpha ISA dma and MAX_DMA_ADDRESS
Message-ID: <20021008195819.A2215@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks David Miller, Jay Estabrook and Richard Henderson for
reviewing the patch and for corrections.

Description:

The ISA dma falls into 2 classes.
1. True busmastering (aka DMA_MODE_CASCADE) when the ISA device
   generate bus addresses by itself. Obviously, such devices are
   limited to lower 16 Mb as there are only 24 address lines on
   the ISA bus. Drivers for these devices pass NULL pdev
   argument to pci mapping functions, and we must always use
   dma_mask = 0x00ffffff in this case.
2. ISA devices using i8237 DMA controller functionality:
   floppy, all soundcards (AFAIK) and a lot of other cheap ISA cards.
   In this case actual device doing DMA is a PCI-to-ISA bridge.
   Quite a few of ISA bridges can do 32-bit DMA (using "high page"
   extensions), and alpha traditionally uses this.

I propose the following:
introduce 'struct pci_dev *isa_bridge' global variable; this
will be pointer to either real bridge device found by pci
probing code, or a fake device in special cases (like jensen running
generic kernel). isa_bridge->dma_mask will be set depending on DMA
capabilities of particular bridge (either using generic quirk list or
in an arch specific manner).
This would allow devices like floppy and audio utilize 32-bit DMA
just by replacing 'NULL' with 'isa_bridge' in the pci mapping calls.

Also, this helps to resolve ISA dma vs. MAX_DMA_ADDRESS mess on alpha.
Setting MAX_DMA_ADDRESS depending on the number of address lines
on the ISA bridge became bogus since early 2.4 when we started to
use the SG windows. Basically, if we have a working iommu, we don't
have any dma limitations. All we need is a correct dma_mask to choose
proper dma window.
OTOH, there are 'iommuless' alphas (rx164, nautilus, possibly early
miata) which need to have 16 Mb GFP_DMA zone (just like i386) even
if their ISA bridge is 32-bit.

Proposed changes:
- rename all XXX_MAX_DMA_ADDRESS to XXX_MAX_ISA_DMA_ADDRESS;
  alpha_mv.max_dma_address - ditto (it's about 90% of the patch);
- ISA bridge on nautilus does support 32-bit dma;
- MAX_DMA_ADDRESS is 16 Mb if there is no iommu, ~0UL (unlimited)
  otherwise;
- if needed, fall back to GFP_DMA allocations in
  pci_alloc_consistent();
- pci_dma_supported() also returns success if GFP_DMA is helpful;
- isa_bridge stuff. Used only by floppy as yet.

Ivan.

--- 2.5.41/include/linux/pci.h	Mon Oct  7 14:42:55 2002
+++ linux/include/linux/pci.h	Mon Oct  7 15:22:21 2002
@@ -643,6 +643,10 @@ void pci_pool_destroy (struct pci_pool *
 void *pci_pool_alloc (struct pci_pool *pool, int flags, dma_addr_t *handle);
 void pci_pool_free (struct pci_pool *pool, void *vaddr, dma_addr_t addr);
 
+#if defined(CONFIG_ISA) || defined(CONFIG_EISA)
+extern struct pci_dev *isa_bridge;
+#endif
+
 #endif /* CONFIG_PCI */
 
 /* Include architecture-dependent settings and functions */
@@ -702,6 +706,8 @@ static inline int pci_enable_wake(struct
 
 #define pci_for_each_dev(dev) \
 	for(dev = NULL; 0; )
+
+#define	isa_bridge	((struct pci_dev *)NULL)
 
 #else
 
--- 2.5.41/include/asm-alpha/dma.h	Tue Oct  1 11:07:35 2002
+++ linux/include/asm-alpha/dma.h	Mon Oct  7 15:21:29 2002
@@ -85,43 +85,46 @@
 /* The maximum address for ISA DMA transfer on Alpha XL, due to an
    hardware SIO limitation, is 64MB.
 */
-#define ALPHA_XL_MAX_DMA_ADDRESS	(IDENT_ADDR+0x04000000UL)
+#define ALPHA_XL_MAX_ISA_DMA_ADDRESS		0x04000000UL
 
-/* The maximum address for ISA DMA transfer on RUFFIAN and NAUTILUS,
+/* The maximum address for ISA DMA transfer on RUFFIAN,
    due to an hardware SIO limitation, is 16MB.
 */
-#define ALPHA_RUFFIAN_MAX_DMA_ADDRESS	(IDENT_ADDR+0x01000000UL)
-#define ALPHA_NAUTILUS_MAX_DMA_ADDRESS	(IDENT_ADDR+0x01000000UL)
+#define ALPHA_RUFFIAN_MAX_ISA_DMA_ADDRESS	0x01000000UL
 
 /* The maximum address for ISA DMA transfer on SABLE, and some ALCORs,
    due to an hardware SIO chip limitation, is 2GB.
 */
-#define ALPHA_SABLE_MAX_DMA_ADDRESS	(IDENT_ADDR+0x80000000UL)
-#define ALPHA_ALCOR_MAX_DMA_ADDRESS	(IDENT_ADDR+0x80000000UL)
+#define ALPHA_SABLE_MAX_ISA_DMA_ADDRESS		0x80000000UL
+#define ALPHA_ALCOR_MAX_ISA_DMA_ADDRESS		0x80000000UL
 
 /*
   Maximum address for all the others is the complete 32-bit bus
   address space.
 */
-#define ALPHA_MAX_DMA_ADDRESS		(IDENT_ADDR+0x100000000UL)
+#define ALPHA_MAX_ISA_DMA_ADDRESS		0x100000000UL
 
 #ifdef CONFIG_ALPHA_GENERIC
-# define MAX_DMA_ADDRESS		(alpha_mv.max_dma_address)
+# define MAX_ISA_DMA_ADDRESS		(alpha_mv.max_isa_dma_address)
 #else
 # if defined(CONFIG_ALPHA_XL)
-#  define MAX_DMA_ADDRESS		ALPHA_XL_MAX_DMA_ADDRESS
+#  define MAX_ISA_DMA_ADDRESS		ALPHA_XL_MAX_ISA_DMA_ADDRESS
 # elif defined(CONFIG_ALPHA_RUFFIAN)
-#  define MAX_DMA_ADDRESS		ALPHA_RUFFIAN_MAX_DMA_ADDRESS
-# elif defined(CONFIG_ALPHA_NAUTILUS)
-#  define MAX_DMA_ADDRESS		ALPHA_NAUTILUS_MAX_DMA_ADDRESS
+#  define MAX_ISA_DMA_ADDRESS		ALPHA_RUFFIAN_MAX_ISA_DMA_ADDRESS
 # elif defined(CONFIG_ALPHA_SABLE)
-#  define MAX_DMA_ADDRESS		ALPHA_SABLE_MAX_DMA_ADDRESS
+#  define MAX_ISA_DMA_ADDRESS		ALPHA_SABLE_MAX_DMA_ISA_ADDRESS
 # elif defined(CONFIG_ALPHA_ALCOR)
-#  define MAX_DMA_ADDRESS		ALPHA_ALCOR_MAX_DMA_ADDRESS
+#  define MAX_ISA_DMA_ADDRESS		ALPHA_ALCOR_MAX_DMA_ISA_ADDRESS
 # else
-#  define MAX_DMA_ADDRESS		ALPHA_MAX_DMA_ADDRESS
+#  define MAX_ISA_DMA_ADDRESS		ALPHA_MAX_ISA_DMA_ADDRESS
 # endif
 #endif
+
+/* If we have the iommu, we don't have any address limitations on DMA.
+   Otherwise (Nautilus, RX164), we have to have 0-16 Mb DMA zone
+   like i386. */
+#define MAX_DMA_ADDRESS		(alpha_mv.mv_pci_tbi ?	\
+				 ~0UL : IDENT_ADDR + 0x01000000)
 
 /* 8237 DMA controllers */
 #define IO_DMA1_BASE	0x00	/* 8 bit slave DMA, channels 0..3 */
--- 2.5.41/include/asm-alpha/machvec.h	Tue Oct  1 11:06:17 2002
+++ linux/include/asm-alpha/machvec.h	Mon Oct  7 15:21:29 2002
@@ -34,7 +34,7 @@ struct alpha_machine_vector
 	int nr_irqs;
 	int rtc_port;
 	int max_asn;
-	unsigned long max_dma_address;
+	unsigned long max_isa_dma_address;
 	unsigned long irq_probe_mask;
 	unsigned long iack_sc;
 	unsigned long min_io_address;
--- 2.5.41/include/asm-alpha/floppy.h	Tue Oct  1 11:07:38 2002
+++ linux/include/asm-alpha/floppy.h	Mon Oct  7 15:21:29 2002
@@ -51,12 +51,12 @@ alpha_fd_dma_setup(char *addr, unsigned 
 	if (bus_addr 
 	    && (addr != prev_addr || size != prev_size || dir != prev_dir)) {
 		/* different from last time -- unmap prev */
-		pci_unmap_single(NULL, bus_addr, prev_size, prev_dir);
+		pci_unmap_single(isa_bridge, bus_addr, prev_size, prev_dir);
 		bus_addr = 0;
 	}
 
 	if (!bus_addr)	/* need to map it */
-		bus_addr = pci_map_single(NULL, addr, size, dir);
+		bus_addr = pci_map_single(isa_bridge, addr, size, dir);
 
 	/* remember this one as prev */
 	prev_addr = addr;
--- 2.5.41/drivers/pci/pci.c	Tue Oct  1 11:06:27 2002
+++ linux/drivers/pci/pci.c	Mon Oct  7 15:22:21 2002
@@ -642,6 +642,11 @@ device_initcall(pci_init);
 
 __setup("pci=", pci_setup);
 
+#if defined(CONFIG_ISA) || defined(CONFIG_EISA)
+struct pci_dev *isa_bridge;
+EXPORT_SYMBOL(isa_bridge);
+#endif
+
 EXPORT_SYMBOL(pci_enable_device);
 EXPORT_SYMBOL(pci_disable_device);
 EXPORT_SYMBOL(pci_find_capability);
--- 2.5.41/arch/alpha/kernel/sys_rx164.c	Tue Oct  1 11:05:47 2002
+++ linux/arch/alpha/kernel/sys_rx164.c	Mon Oct  7 15:21:29 2002
@@ -203,7 +203,7 @@ struct alpha_machine_vector rx164_mv __i
 	DO_POLARIS_IO,
 	DO_POLARIS_BUS,
 	machine_check:		polaris_machine_check,
-	max_dma_address:	ALPHA_MAX_DMA_ADDRESS,
+	max_isa_dma_address:	ALPHA_MAX_ISA_DMA_ADDRESS,
 	min_io_address:		DEFAULT_IO_BASE,
 	min_mem_address:	DEFAULT_MEM_BASE,
 
--- 2.5.41/arch/alpha/kernel/sys_sio.c	Tue Oct  1 11:06:13 2002
+++ linux/arch/alpha/kernel/sys_sio.c	Mon Oct  7 15:21:29 2002
@@ -258,7 +258,7 @@ struct alpha_machine_vector alphabook1_m
 	DO_LCA_IO,
 	DO_LCA_BUS,
 	machine_check:		lca_machine_check,
-	max_dma_address:	ALPHA_MAX_DMA_ADDRESS,
+	max_isa_dma_address:	ALPHA_MAX_ISA_DMA_ADDRESS,
 	min_io_address:		DEFAULT_IO_BASE,
 	min_mem_address:	APECS_AND_LCA_DEFAULT_MEM_BASE,
 
@@ -289,7 +289,7 @@ struct alpha_machine_vector avanti_mv __
 	DO_APECS_IO,
 	DO_APECS_BUS,
 	machine_check:		apecs_machine_check,
-	max_dma_address:	ALPHA_MAX_DMA_ADDRESS,
+	max_isa_dma_address:	ALPHA_MAX_ISA_DMA_ADDRESS,
 	min_io_address:		DEFAULT_IO_BASE,
 	min_mem_address:	APECS_AND_LCA_DEFAULT_MEM_BASE,
 
@@ -318,7 +318,7 @@ struct alpha_machine_vector noname_mv __
 	DO_LCA_IO,
 	DO_LCA_BUS,
 	machine_check:		lca_machine_check,
-	max_dma_address:	ALPHA_MAX_DMA_ADDRESS,
+	max_isa_dma_address:	ALPHA_MAX_ISA_DMA_ADDRESS,
 	min_io_address:		DEFAULT_IO_BASE,
 	min_mem_address:	APECS_AND_LCA_DEFAULT_MEM_BASE,
 
@@ -356,7 +356,7 @@ struct alpha_machine_vector p2k_mv __ini
 	DO_LCA_IO,
 	DO_LCA_BUS,
 	machine_check:		lca_machine_check,
-	max_dma_address:	ALPHA_MAX_DMA_ADDRESS,
+	max_isa_dma_address:	ALPHA_MAX_ISA_DMA_ADDRESS,
 	min_io_address:		DEFAULT_IO_BASE,
 	min_mem_address:	APECS_AND_LCA_DEFAULT_MEM_BASE,
 
@@ -385,7 +385,7 @@ struct alpha_machine_vector xl_mv __init
 	DO_APECS_IO,
 	BUS(apecs),
 	machine_check:		apecs_machine_check,
-	max_dma_address:	ALPHA_XL_MAX_DMA_ADDRESS,
+	max_isa_dma_address:	ALPHA_XL_MAX_ISA_DMA_ADDRESS,
 	min_io_address:		DEFAULT_IO_BASE,
 	min_mem_address:	XL_DEFAULT_MEM_BASE,
 
--- 2.5.41/arch/alpha/kernel/sys_sable.c	Tue Oct  1 11:06:17 2002
+++ linux/arch/alpha/kernel/sys_sable.c	Mon Oct  7 15:21:30 2002
@@ -290,7 +290,7 @@ struct alpha_machine_vector sable_mv __i
 	DO_T2_IO,
 	DO_T2_BUS,
 	machine_check:		t2_machine_check,
-	max_dma_address:	ALPHA_SABLE_MAX_DMA_ADDRESS,
+	max_isa_dma_address:	ALPHA_SABLE_MAX_ISA_DMA_ADDRESS,
 	min_io_address:		EISA_DEFAULT_IO_BASE,
 	min_mem_address:	T2_DEFAULT_MEM_BASE,
 
@@ -322,7 +322,7 @@ struct alpha_machine_vector sable_gamma_
 	DO_T2_IO,
 	DO_T2_BUS,
 	machine_check:		t2_machine_check,
-	max_dma_address:	ALPHA_SABLE_MAX_DMA_ADDRESS,
+	max_isa_dma_address:	ALPHA_SABLE_MAX_ISA_DMA_ADDRESS,
 	min_io_address:		EISA_DEFAULT_IO_BASE,
 	min_mem_address:	T2_DEFAULT_MEM_BASE,
 
--- 2.5.41/arch/alpha/kernel/sys_eiger.c	Tue Oct  1 11:06:17 2002
+++ linux/arch/alpha/kernel/sys_eiger.c	Mon Oct  7 15:21:30 2002
@@ -231,7 +231,7 @@ struct alpha_machine_vector eiger_mv __i
 	DO_TSUNAMI_IO,
 	DO_TSUNAMI_BUS,
 	machine_check:		tsunami_machine_check,
-	max_dma_address:	ALPHA_MAX_DMA_ADDRESS,
+	max_isa_dma_address:	ALPHA_MAX_ISA_DMA_ADDRESS,
 	min_io_address:		DEFAULT_IO_BASE,
 	min_mem_address:	DEFAULT_MEM_BASE,
 	pci_dac_offset:		TSUNAMI_DAC_OFFSET,
--- 2.5.41/arch/alpha/kernel/sys_takara.c	Tue Oct  1 11:06:18 2002
+++ linux/arch/alpha/kernel/sys_takara.c	Mon Oct  7 15:21:30 2002
@@ -275,7 +275,7 @@ struct alpha_machine_vector takara_mv __
 	DO_CIA_IO,
 	DO_CIA_BUS,
 	machine_check:		cia_machine_check,
-	max_dma_address:	ALPHA_MAX_DMA_ADDRESS,
+	max_isa_dma_address:	ALPHA_MAX_ISA_DMA_ADDRESS,
 	min_io_address:		DEFAULT_IO_BASE,
 	min_mem_address:	CIA_DEFAULT_MEM_BASE,
 
--- 2.5.41/arch/alpha/kernel/sys_dp264.c	Tue Oct  1 11:06:22 2002
+++ linux/arch/alpha/kernel/sys_dp264.c	Mon Oct  7 15:21:30 2002
@@ -572,7 +572,7 @@ struct alpha_machine_vector dp264_mv __i
 	DO_TSUNAMI_IO,
 	DO_TSUNAMI_BUS,
 	machine_check:		tsunami_machine_check,
-	max_dma_address:	ALPHA_MAX_DMA_ADDRESS,
+	max_isa_dma_address:	ALPHA_MAX_ISA_DMA_ADDRESS,
 	min_io_address:		DEFAULT_IO_BASE,
 	min_mem_address:	DEFAULT_MEM_BASE,
 	pci_dac_offset:		TSUNAMI_DAC_OFFSET,
@@ -597,7 +597,7 @@ struct alpha_machine_vector monet_mv __i
 	DO_TSUNAMI_IO,
 	DO_TSUNAMI_BUS,
 	machine_check:		tsunami_machine_check,
-	max_dma_address:	ALPHA_MAX_DMA_ADDRESS,
+	max_isa_dma_address:	ALPHA_MAX_ISA_DMA_ADDRESS,
 	min_io_address:		DEFAULT_IO_BASE,
 	min_mem_address:	DEFAULT_MEM_BASE,
 	pci_dac_offset:		TSUNAMI_DAC_OFFSET,
@@ -621,7 +621,7 @@ struct alpha_machine_vector webbrick_mv 
 	DO_TSUNAMI_IO,
 	DO_TSUNAMI_BUS,
 	machine_check:		tsunami_machine_check,
-	max_dma_address:	ALPHA_MAX_DMA_ADDRESS,
+	max_isa_dma_address:	ALPHA_MAX_ISA_DMA_ADDRESS,
 	min_io_address:		DEFAULT_IO_BASE,
 	min_mem_address:	DEFAULT_MEM_BASE,
 	pci_dac_offset:		TSUNAMI_DAC_OFFSET,
@@ -645,7 +645,7 @@ struct alpha_machine_vector clipper_mv _
 	DO_TSUNAMI_IO,
 	DO_TSUNAMI_BUS,
 	machine_check:		tsunami_machine_check,
-	max_dma_address:	ALPHA_MAX_DMA_ADDRESS,
+	max_isa_dma_address:	ALPHA_MAX_ISA_DMA_ADDRESS,
 	min_io_address:		DEFAULT_IO_BASE,
 	min_mem_address:	DEFAULT_MEM_BASE,
 	pci_dac_offset:		TSUNAMI_DAC_OFFSET,
@@ -674,7 +674,7 @@ struct alpha_machine_vector shark_mv __i
 	DO_TSUNAMI_IO,
 	DO_TSUNAMI_BUS,
 	machine_check:		tsunami_machine_check,
-	max_dma_address:	ALPHA_MAX_DMA_ADDRESS,
+	max_isa_dma_address:	ALPHA_MAX_ISA_DMA_ADDRESS,
 	min_io_address:		DEFAULT_IO_BASE,
 	min_mem_address:	DEFAULT_MEM_BASE,
 	pci_dac_offset:		TSUNAMI_DAC_OFFSET,
--- 2.5.41/arch/alpha/kernel/sys_noritake.c	Tue Oct  1 11:06:23 2002
+++ linux/arch/alpha/kernel/sys_noritake.c	Mon Oct  7 15:21:30 2002
@@ -305,7 +305,7 @@ struct alpha_machine_vector noritake_mv 
 	DO_APECS_IO,
 	DO_APECS_BUS,
 	machine_check:		noritake_apecs_machine_check,
-	max_dma_address:	ALPHA_MAX_DMA_ADDRESS,
+	max_isa_dma_address:	ALPHA_MAX_ISA_DMA_ADDRESS,
 	min_io_address:		EISA_DEFAULT_IO_BASE,
 	min_mem_address:	APECS_AND_LCA_DEFAULT_MEM_BASE,
 
@@ -331,7 +331,7 @@ struct alpha_machine_vector noritake_pri
 	DO_CIA_IO,
 	DO_CIA_BUS,
 	machine_check:		cia_machine_check,
-	max_dma_address:	ALPHA_MAX_DMA_ADDRESS,
+	max_isa_dma_address:	ALPHA_MAX_ISA_DMA_ADDRESS,
 	min_io_address:		EISA_DEFAULT_IO_BASE,
 	min_mem_address:	CIA_DEFAULT_MEM_BASE,
 
--- 2.5.41/arch/alpha/kernel/sys_mikasa.c	Tue Oct  1 11:07:34 2002
+++ linux/arch/alpha/kernel/sys_mikasa.c	Mon Oct  7 15:21:30 2002
@@ -223,7 +223,7 @@ struct alpha_machine_vector mikasa_mv __
 	DO_APECS_IO,
 	DO_APECS_BUS,
 	machine_check:		mikasa_apecs_machine_check,
-	max_dma_address:	ALPHA_MAX_DMA_ADDRESS,
+	max_isa_dma_address:	ALPHA_MAX_ISA_DMA_ADDRESS,
 	min_io_address:		DEFAULT_IO_BASE,
 	min_mem_address:	APECS_AND_LCA_DEFAULT_MEM_BASE,
 
@@ -249,7 +249,7 @@ struct alpha_machine_vector mikasa_primo
 	DO_CIA_IO,
 	DO_CIA_BUS,
 	machine_check:		cia_machine_check,
-	max_dma_address:	ALPHA_MAX_DMA_ADDRESS,
+	max_isa_dma_address:	ALPHA_MAX_ISA_DMA_ADDRESS,
 	min_io_address:		DEFAULT_IO_BASE,
 	min_mem_address:	CIA_DEFAULT_MEM_BASE,
 
--- 2.5.41/arch/alpha/kernel/sys_cabriolet.c	Tue Oct  1 11:06:26 2002
+++ linux/arch/alpha/kernel/sys_cabriolet.c	Mon Oct  7 15:21:30 2002
@@ -327,7 +327,7 @@ struct alpha_machine_vector cabriolet_mv
 	DO_APECS_IO,
 	DO_APECS_BUS,
 	machine_check:		apecs_machine_check,
-	max_dma_address:	ALPHA_MAX_DMA_ADDRESS,
+	max_isa_dma_address:	ALPHA_MAX_ISA_DMA_ADDRESS,
 	min_io_address:		DEFAULT_IO_BASE,
 	min_mem_address:	APECS_AND_LCA_DEFAULT_MEM_BASE,
 
@@ -355,7 +355,7 @@ struct alpha_machine_vector eb164_mv __i
 	DO_CIA_IO,
 	DO_CIA_BUS,
 	machine_check:		cia_machine_check,
-	max_dma_address:	ALPHA_MAX_DMA_ADDRESS,
+	max_isa_dma_address:	ALPHA_MAX_ISA_DMA_ADDRESS,
 	min_io_address:		DEFAULT_IO_BASE,
 	min_mem_address:	CIA_DEFAULT_MEM_BASE,
 
@@ -380,7 +380,7 @@ struct alpha_machine_vector eb66p_mv __i
 	DO_LCA_IO,
 	DO_LCA_BUS,
 	machine_check:		lca_machine_check,
-	max_dma_address:	ALPHA_MAX_DMA_ADDRESS,
+	max_isa_dma_address:	ALPHA_MAX_ISA_DMA_ADDRESS,
 	min_io_address:		DEFAULT_IO_BASE,
 	min_mem_address:	APECS_AND_LCA_DEFAULT_MEM_BASE,
 
@@ -405,7 +405,7 @@ struct alpha_machine_vector lx164_mv __i
 	DO_PYXIS_IO,
 	DO_CIA_BUS,
 	machine_check:		cia_machine_check,
-	max_dma_address:	ALPHA_MAX_DMA_ADDRESS,
+	max_isa_dma_address:	ALPHA_MAX_ISA_DMA_ADDRESS,
 	min_io_address:		DEFAULT_IO_BASE,
 	min_mem_address:	DEFAULT_MEM_BASE,
 	pci_dac_offset:		PYXIS_DAC_OFFSET,
@@ -431,7 +431,7 @@ struct alpha_machine_vector pc164_mv __i
 	DO_CIA_IO,
 	DO_CIA_BUS,
 	machine_check:		cia_machine_check,
-	max_dma_address:	ALPHA_MAX_DMA_ADDRESS,
+	max_isa_dma_address:	ALPHA_MAX_ISA_DMA_ADDRESS,
 	min_io_address:		DEFAULT_IO_BASE,
 	min_mem_address:	CIA_DEFAULT_MEM_BASE,
 
--- 2.5.41/arch/alpha/kernel/sys_nautilus.c	Tue Oct  1 11:06:55 2002
+++ linux/arch/alpha/kernel/sys_nautilus.c	Mon Oct  7 15:21:30 2002
@@ -516,7 +516,7 @@ struct alpha_machine_vector nautilus_mv 
 	DO_IRONGATE_IO,
 	DO_IRONGATE_BUS,
 	machine_check:		nautilus_machine_check,
-	max_dma_address:	ALPHA_NAUTILUS_MAX_DMA_ADDRESS,
+	max_isa_dma_address:	ALPHA_MAX_ISA_DMA_ADDRESS,
 	min_io_address:		DEFAULT_IO_BASE,
 	min_mem_address:	IRONGATE_DEFAULT_MEM_BASE,
 
--- 2.5.41/arch/alpha/kernel/sys_wildfire.c	Tue Oct  1 11:06:57 2002
+++ linux/arch/alpha/kernel/sys_wildfire.c	Mon Oct  7 15:21:30 2002
@@ -339,7 +339,7 @@ struct alpha_machine_vector wildfire_mv 
 	DO_WILDFIRE_IO,
 	DO_WILDFIRE_BUS,
 	machine_check:		wildfire_machine_check,
-	max_dma_address:	ALPHA_MAX_DMA_ADDRESS,
+	max_isa_dma_address:	ALPHA_MAX_ISA_DMA_ADDRESS,
 	min_io_address:		DEFAULT_IO_BASE,
 	min_mem_address:	DEFAULT_MEM_BASE,
 
--- 2.5.41/arch/alpha/kernel/sys_alcor.c	Tue Oct  1 11:06:57 2002
+++ linux/arch/alpha/kernel/sys_alcor.c	Mon Oct  7 15:21:30 2002
@@ -251,7 +251,7 @@ struct alpha_machine_vector alcor_mv __i
 	DO_CIA_IO,
 	DO_CIA_BUS,
 	machine_check:		cia_machine_check,
-	max_dma_address:	ALPHA_ALCOR_MAX_DMA_ADDRESS,
+	max_isa_dma_address:	ALPHA_ALCOR_MAX_ISA_DMA_ADDRESS,
 	min_io_address:		EISA_DEFAULT_IO_BASE,
 	min_mem_address:	CIA_DEFAULT_MEM_BASE,
 
@@ -281,7 +281,7 @@ struct alpha_machine_vector xlt_mv __ini
 	DO_CIA_IO,
 	DO_CIA_BUS,
 	machine_check:		cia_machine_check,
-	max_dma_address:	ALPHA_MAX_DMA_ADDRESS,
+	max_isa_dma_address:	ALPHA_MAX_ISA_DMA_ADDRESS,
 	min_io_address:		EISA_DEFAULT_IO_BASE,
 	min_mem_address:	CIA_DEFAULT_MEM_BASE,
 
--- 2.5.41/arch/alpha/kernel/sys_sx164.c	Tue Oct  1 11:06:59 2002
+++ linux/arch/alpha/kernel/sys_sx164.c	Mon Oct  7 15:21:30 2002
@@ -160,7 +160,7 @@ struct alpha_machine_vector sx164_mv __i
 	DO_PYXIS_IO,
 	DO_CIA_BUS,
 	machine_check:		cia_machine_check,
-	max_dma_address:	ALPHA_MAX_DMA_ADDRESS,
+	max_isa_dma_address:	ALPHA_MAX_ISA_DMA_ADDRESS,
 	min_io_address:		DEFAULT_IO_BASE,
 	min_mem_address:	DEFAULT_MEM_BASE,
 	pci_dac_offset:		PYXIS_DAC_OFFSET,
--- 2.5.41/arch/alpha/kernel/sys_miata.c	Tue Oct  1 11:07:00 2002
+++ linux/arch/alpha/kernel/sys_miata.c	Mon Oct  7 15:21:30 2002
@@ -267,7 +267,7 @@ struct alpha_machine_vector miata_mv __i
 	DO_PYXIS_IO,
 	DO_CIA_BUS,
 	machine_check:		cia_machine_check,
-	max_dma_address:	ALPHA_MAX_DMA_ADDRESS,
+	max_isa_dma_address:	ALPHA_MAX_ISA_DMA_ADDRESS,
 	min_io_address:		DEFAULT_IO_BASE,
 	min_mem_address:	DEFAULT_MEM_BASE,
 	pci_dac_offset:		PYXIS_DAC_OFFSET,
--- 2.5.41/arch/alpha/kernel/sys_ruffian.c	Tue Oct  1 11:07:05 2002
+++ linux/arch/alpha/kernel/sys_ruffian.c	Mon Oct  7 15:21:30 2002
@@ -218,7 +218,7 @@ struct alpha_machine_vector ruffian_mv _
 	DO_PYXIS_IO,
 	DO_CIA_BUS,
 	machine_check:		cia_machine_check,
-	max_dma_address:	ALPHA_RUFFIAN_MAX_DMA_ADDRESS,
+	max_isa_dma_address:	ALPHA_RUFFIAN_MAX_ISA_DMA_ADDRESS,
 	min_io_address:		DEFAULT_IO_BASE,
 	min_mem_address:	DEFAULT_MEM_BASE,
 	pci_dac_offset:		PYXIS_DAC_OFFSET,
--- 2.5.41/arch/alpha/kernel/sys_jensen.c	Tue Oct  1 11:07:07 2002
+++ linux/arch/alpha/kernel/sys_jensen.c	Mon Oct  7 15:21:30 2002
@@ -219,6 +219,11 @@ static void __init
 jensen_init_arch(void)
 {
 	struct pci_controller *hose;
+#ifdef CONFIG_PCI
+	static struct pci_dev fake_isa_bridge = { dma_mask: 0xffffffffUL, };
+
+	isa_bridge = &fake_isa_bridge;
+#endif
 
 	/* Create a hose so that we can report i/o base addresses to
 	   userland.  */
@@ -257,7 +262,7 @@ struct alpha_machine_vector jensen_mv __
 	IO_LITE(JENSEN,jensen),
 	BUS(jensen),
 	machine_check:		jensen_machine_check,
-	max_dma_address:	ALPHA_MAX_DMA_ADDRESS,
+	max_isa_dma_address:	ALPHA_MAX_ISA_DMA_ADDRESS,
 	rtc_port:		0x170,
 
 	nr_irqs:		16,
--- 2.5.41/arch/alpha/kernel/sys_eb64p.c	Tue Oct  1 11:07:34 2002
+++ linux/arch/alpha/kernel/sys_eb64p.c	Mon Oct  7 15:21:30 2002
@@ -214,7 +214,7 @@ struct alpha_machine_vector eb64p_mv __i
 	DO_APECS_IO,
 	DO_APECS_BUS,
 	machine_check:		apecs_machine_check,
-	max_dma_address:	ALPHA_MAX_DMA_ADDRESS,
+	max_isa_dma_address:	ALPHA_MAX_ISA_DMA_ADDRESS,
 	min_io_address:		DEFAULT_IO_BASE,
 	min_mem_address:	APECS_AND_LCA_DEFAULT_MEM_BASE,
 
@@ -240,7 +240,7 @@ struct alpha_machine_vector eb66_mv __in
 	DO_LCA_IO,
 	DO_LCA_BUS,
 	machine_check:		lca_machine_check,
-	max_dma_address:	ALPHA_MAX_DMA_ADDRESS,
+	max_isa_dma_address:	ALPHA_MAX_ISA_DMA_ADDRESS,
 	min_io_address:		DEFAULT_IO_BASE,
 	min_mem_address:	APECS_AND_LCA_DEFAULT_MEM_BASE,
 
--- 2.5.41/arch/alpha/kernel/sys_rawhide.c	Tue Oct  1 11:07:36 2002
+++ linux/arch/alpha/kernel/sys_rawhide.c	Mon Oct  7 15:21:30 2002
@@ -252,7 +252,7 @@ struct alpha_machine_vector rawhide_mv _
 	DO_MCPCIA_IO,
 	DO_MCPCIA_BUS,
 	machine_check:		mcpcia_machine_check,
-	max_dma_address:	ALPHA_MAX_DMA_ADDRESS,
+	max_isa_dma_address:	ALPHA_MAX_ISA_DMA_ADDRESS,
 	min_io_address:		DEFAULT_IO_BASE,
 	min_mem_address:	MCPCIA_DEFAULT_MEM_BASE,
 	pci_dac_offset:		MCPCIA_DAC_OFFSET,
--- 2.5.41/arch/alpha/kernel/sys_titan.c	Tue Oct  1 11:07:38 2002
+++ linux/arch/alpha/kernel/sys_titan.c	Mon Oct  7 15:21:30 2002
@@ -373,7 +373,7 @@ struct alpha_machine_vector privateer_mv
 	DO_TITAN_IO,
 	DO_TITAN_BUS,
 	machine_check:		privateer_machine_check,
-	max_dma_address:	ALPHA_MAX_DMA_ADDRESS,
+	max_isa_dma_address:	ALPHA_MAX_ISA_DMA_ADDRESS,
 	min_io_address:		DEFAULT_IO_BASE,
 	min_mem_address:	DEFAULT_MEM_BASE,
 	pci_dac_offset:		TITAN_DAC_OFFSET,
--- 2.5.41/arch/alpha/kernel/pci_iommu.c	Tue Oct  1 11:07:43 2002
+++ linux/arch/alpha/kernel/pci_iommu.c	Mon Oct  7 15:23:40 2002
@@ -30,9 +30,7 @@
 #define DEBUG_NODIRECT 0
 #define DEBUG_FORCEDAC 0
 
-/* Most Alphas support 32-bit ISA DMA. Exceptions are XL, Ruffian,
-   Nautilus, Sable, and Alcor (see asm-alpha/dma.h for details). */
-#define ISA_DMA_MASK	(MAX_DMA_ADDRESS - IDENT_ADDR - 1)
+#define ISA_DMA_MASK		0x00ffffff
 
 static inline unsigned long
 mk_iommu_pte(unsigned long paddr)
@@ -189,6 +187,7 @@ pci_map_single_1(struct pci_dev *pdev, v
 	long npages, dma_ofs, i;
 	unsigned long paddr;
 	dma_addr_t ret;
+	unsigned int align = 0;
 
 	paddr = __pa(cpu_addr);
 
@@ -216,27 +215,27 @@ pci_map_single_1(struct pci_dev *pdev, v
 	}
 
 	/* If the machine doesn't define a pci_tbi routine, we have to
-	   assume it doesn't support sg mapping.  */
+	   assume it doesn't support sg mapping, and, since we tried to
+	   use direct_map above, it now must be considered an error. */
 	if (! alpha_mv.mv_pci_tbi) {
-		static int been_here = 0;
+		static int been_here = 0; /* Only print the message once. */
 		if (!been_here) {
-		    printk(KERN_WARNING "pci_map_single: no hw sg, using "
-			   "direct map when possible\n");
+		    printk(KERN_WARNING "pci_map_single: no HW sg\n");
 		    been_here = 1;
 		}
-		if (paddr + size <= __direct_map_size)
-		    return (paddr + __direct_map_base);
-		else
-		    return 0;
+		return 0;
 	}
-		
+
 	arena = hose->sg_pci;
 	if (!arena || arena->dma_base + arena->size - 1 > max_dma)
 		arena = hose->sg_isa;
 
 	npages = calc_npages((paddr & ~PAGE_MASK) + size);
-	/* Force allocation to 64KB boundary for all ISA devices. */
-	dma_ofs = iommu_arena_alloc(arena, npages, pdev ? 8 : 0);
+
+	/* Force allocation to 64KB boundary for ISA bridges. */
+	if (pdev && pdev == isa_bridge)
+		align = 8;
+	dma_ofs = iommu_arena_alloc(arena, npages, align);
 	if (dma_ofs < 0) {
 		printk(KERN_WARNING "pci_map_single failed: "
 		       "could not allocate dma page tables\n");
@@ -364,8 +363,10 @@ pci_alloc_consistent(struct pci_dev *pde
 {
 	void *cpu_addr;
 	long order = get_order(size);
+	int gfp = GFP_ATOMIC;
 
-	cpu_addr = (void *)__get_free_pages(GFP_ATOMIC, order);
+try_again:
+	cpu_addr = (void *)__get_free_pages(gfp, order);
 	if (! cpu_addr) {
 		printk(KERN_INFO "pci_alloc_consistent: "
 		       "get_free_pages failed from %p\n",
@@ -379,7 +380,12 @@ pci_alloc_consistent(struct pci_dev *pde
 	*dma_addrp = pci_map_single_1(pdev, cpu_addr, size, 0);
 	if (*dma_addrp == 0) {
 		free_pages((unsigned long)cpu_addr, order);
-		return NULL;
+		if (alpha_mv.mv_pci_tbi || (gfp & GFP_DMA))
+			return NULL;
+		/* The address doesn't fit required mask and we
+		   do not have iommu. Try again with GFP_DMA. */
+		gfp |= GFP_DMA;
+		goto try_again;
 	}
 		
 	DBGA2("pci_alloc_consistent: %lx -> [%p,%x] from %p\n",
@@ -727,8 +733,8 @@ pci_dma_supported(struct pci_dev *pdev, 
 	   the entire direct mapped space or the total system memory as
 	   shifted by the map base */
 	if (__direct_map_size != 0
-	    && (__direct_map_base + __direct_map_size - 1 <= mask
-		|| __direct_map_base + (max_low_pfn<<PAGE_SHIFT)-1 <= mask))
+	    && (__direct_map_base + __direct_map_size - 1 <= mask ||
+		__direct_map_base + (max_low_pfn << PAGE_SHIFT) - 1 <= mask))
 		return 1;
 
 	/* Check that we have a scatter-gather arena that fits.  */
@@ -738,6 +744,10 @@ pci_dma_supported(struct pci_dev *pdev, 
 		return 1;
 	arena = hose->sg_pci;
 	if (arena && arena->dma_base + arena->size - 1 <= mask)
+		return 1;
+
+	/* As last resort try ZONE_DMA.  */
+	if (!__direct_map_base && MAX_DMA_ADDRESS - IDENT_ADDR - 1 <= mask)
 		return 1;
 
 	return 0;
--- 2.5.41/arch/alpha/kernel/pci.c	Tue Oct  1 11:06:16 2002
+++ linux/arch/alpha/kernel/pci.c	Mon Oct  7 15:21:30 2002
@@ -117,6 +117,18 @@ quirk_cypress(struct pci_dev *dev)
 	}
 }
 
+/* Called for each device after PCI setup is done. */
+static void __init
+pcibios_fixup_final(struct pci_dev *dev)
+{
+	unsigned int class = dev->class >> 8;
+
+	if (class == PCI_CLASS_BRIDGE_ISA || class == PCI_CLASS_BRIDGE_ISA) {
+		dev->dma_mask = MAX_ISA_DMA_ADDRESS - 1;
+		isa_bridge = dev;
+	}
+}
+
 struct pci_fixup pcibios_fixups[] __initdata = {
 	{ PCI_FIXUP_HEADER, PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82375,
 	  quirk_eisa_bridge },
@@ -126,6 +138,8 @@ struct pci_fixup pcibios_fixups[] __init
 	  quirk_ali_ide_ports },
 	{ PCI_FIXUP_HEADER, PCI_VENDOR_ID_CONTAQ, PCI_DEVICE_ID_CONTAQ_82C693,
 	  quirk_cypress },
+	{ PCI_FIXUP_FINAL,  PCI_ANY_ID,	PCI_ANY_ID,
+	  pcibios_fixup_final },
 	{ 0 }
 };
 
