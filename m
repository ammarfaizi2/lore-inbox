Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319663AbSIMOjW>; Fri, 13 Sep 2002 10:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319665AbSIMOjW>; Fri, 13 Sep 2002 10:39:22 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:41990 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S319663AbSIMOim>; Fri, 13 Sep 2002 10:38:42 -0400
Date: Fri, 13 Sep 2002 18:43:10 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>,
       Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.5.34] alpha: nautilus update
Message-ID: <20020913184310.B7498@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mostly UP1500 (Samsung board based on ev68 + AMD-761 chipset)
specific stuff. This machine takes up to 4 Gb of RAM, so we
want to keep PCI memory region as small as possible and place it
as close as possible to 0xffffffff. Thus we waste minimal amount of
system RAM and have working peer-to-peer DMA.
Irongate AGP GART is still non-functional - I haven't tried kernel
mode cflush routine yet...
Also, here are fixes common for all Nautilus family:
- nasty stack overflow in the machine check handler;
- as there is no iommu, use GFP_DMA for broken PCI hardware with
  less than 32 address lines (like on-board ALi audio);
- free_reserved_mem() function for late freeing the bootmem allocations,
  might be useful on some other alphas as well (freeing iommu pagetable
  for CIA tbia workaround, for example).

Ivan.


--- 2.5.34/arch/alpha/kernel/core_irongate.c	Fri Sep  6 03:04:45 2002
+++ linux/arch/alpha/kernel/core_irongate.c	Fri Sep  6 03:07:45 2002
@@ -27,13 +27,11 @@
 #include <asm/core_irongate.h>
 #undef __EXTERN_INLINE
 
+#include <linux/bootmem.h>
+
 #include "proto.h"
 #include "pci_impl.h"
 
-#undef DEBUG_IRONGATE 		/* define to enable verbose Irongate debug */
-
-#define IRONGATE_DEFAULT_AGP_APER_SIZE	(256*1024*1024) /* 256MB */
-
 /*
  * BIOS32-style PCI interface:
  */
@@ -46,6 +44,7 @@
 # define DBG_CFG(args)
 #endif
 
+igcsr32 *IronECC;
 
 /*
  * Given a bus, device, and function number, compute resulting
@@ -165,143 +164,6 @@ struct pci_ops irongate_pci_ops =
 	.write =	irongate_write_config,
 };
 
-#ifdef DEBUG_IRONGATE
-static void
-irongate_register_dump(const char *function_name)
-{
-	printk("%s: Irongate registers:\n"
-	       "\tFunction 0:\n"
-	       "\tdev_vendor\t0x%08x\n"
-	       "\tstat_cmd\t0x%08x\n"
-	       "\tclass\t\t0x%08x\n"
-	       "\tlatency\t\t0x%08x\n"
-	       "\tbar0\t\t0x%08x\n"
-	       "\tbar1\t\t0x%08x\n"
-	       "\tbar2\t\t0x%08x\n"
-	       "\trsrvd0[0]\t0x%08x\n"
-	       "\trsrvd0[1]\t0x%08x\n"
-	       "\trsrvd0[2]\t0x%08x\n"
-	       "\trsrvd0[3]\t0x%08x\n"
-	       "\trsrvd0[4]\t0x%08x\n"
-	       "\trsrvd0[5]\t0x%08x\n"
-	       "\tcapptr\t\t0x%08x\n"
-	       "\trsrvd1[0]\t0x%08x\n"
-	       "\trsrvd1[1]\t0x%08x\n"
-	       "\tbacsr10\t\t0x%08x\n"
-	       "\tbacsr32\t\t0x%08x\n"
-	       "\tbacsr54\t\t0x%08x\n"
-	       "\trsrvd2[0]\t0x%08x\n"
-	       "\tdrammap\t\t0x%08x\n"
-	       "\tdramtm\t\t0x%08x\n"
-	       "\tdramms\t\t0x%08x\n"
-	       "\trsrvd3[0]\t0x%08x\n"
-	       "\tbiu0\t\t0x%08x\n"
-	       "\tbiusip\t\t0x%08x\n"
-	       "\trsrvd4[0]\t0x%08x\n"
-	       "\trsrvd4[1]\t0x%08x\n"
-	       "\tmro\t\t0x%08x\n"
-	       "\trsrvd5[0]\t0x%08x\n"
-	       "\trsrvd5[1]\t0x%08x\n"
-	       "\trsrvd5[2]\t0x%08x\n"
-	       "\twhami\t\t0x%08x\n"
-	       "\tpciarb\t\t0x%08x\n"
-	       "\tpcicfg\t\t0x%08x\n"
-	       "\trsrvd6[0]\t0x%08x\n"
-	       "\trsrvd6[1]\t0x%08x\n"
-	       "\trsrvd6[2]\t0x%08x\n"
-	       "\trsrvd6[3]\t0x%08x\n"
-	       "\trsrvd6[4]\t0x%08x\n"
-	       "\tagpcap\t\t0x%08x\n"
-	       "\tagpstat\t\t0x%08x\n"
-	       "\tagpcmd\t\t0x%08x\n"
-	       "\tagpva\t\t0x%08x\n"
-	       "\tagpmode\t\t0x%08x\n"
-
-	       "\n\tFunction 1:\n"
-	       "\tdev_vendor:\t0x%08x\n"
-	       "\tcmd_status:\t0x%08x\n"
-	       "\trevid_etc :\t0x%08x\n"
-	       "\thtype_etc :\t0x%08x\n"
-	       "\trsrvd0[0] :\t0x%08x\n"
-	       "\trsrvd0[1] :\t0x%08x\n"
-	       "\tbus_nmbers:\t0x%08x\n"
-	       "\tio_baselim:\t0x%08x\n"
-	       "\tmem_bselim:\t0x%08x\n"
-	       "\tpf_baselib:\t0x%08x\n"
-	       "\trsrvd1[0] :\t0x%08x\n"
-	       "\trsrvd1[1] :\t0x%08x\n"
-	       "\tio_baselim:\t0x%08x\n"
-	       "\trsrvd2[0] :\t0x%08x\n"
-	       "\trsrvd2[1] :\t0x%08x\n"
-	       "\tinterrupt :\t0x%08x\n",
-
-	       function_name,
-	       IRONGATE0->dev_vendor,
-	       IRONGATE0->stat_cmd,
-	       IRONGATE0->class,
-	       IRONGATE0->latency,
-	       IRONGATE0->bar0,
-	       IRONGATE0->bar1,
-	       IRONGATE0->bar2,
-	       IRONGATE0->rsrvd0[0],
-	       IRONGATE0->rsrvd0[1],
-	       IRONGATE0->rsrvd0[2],
-	       IRONGATE0->rsrvd0[3],
-	       IRONGATE0->rsrvd0[4],
-	       IRONGATE0->rsrvd0[5],
-	       IRONGATE0->capptr,
-	       IRONGATE0->rsrvd1[0],
-	       IRONGATE0->rsrvd1[1],
-	       IRONGATE0->bacsr10,
-	       IRONGATE0->bacsr32,
-	       IRONGATE0->bacsr54,
-	       IRONGATE0->rsrvd2[0],
-	       IRONGATE0->drammap,
-	       IRONGATE0->dramtm,
-	       IRONGATE0->dramms,
-	       IRONGATE0->rsrvd3[0],
-	       IRONGATE0->biu0,
-	       IRONGATE0->biusip,
-	       IRONGATE0->rsrvd4[0],
-	       IRONGATE0->rsrvd4[1],
-	       IRONGATE0->mro,
-	       IRONGATE0->rsrvd5[0],
-	       IRONGATE0->rsrvd5[1],
-	       IRONGATE0->rsrvd5[2],
-	       IRONGATE0->whami,
-	       IRONGATE0->pciarb,
-	       IRONGATE0->pcicfg,
-	       IRONGATE0->rsrvd6[0],
-	       IRONGATE0->rsrvd6[1],
-	       IRONGATE0->rsrvd6[2],
-	       IRONGATE0->rsrvd6[3],
-	       IRONGATE0->rsrvd6[4],
-	       IRONGATE0->agpcap,
-	       IRONGATE0->agpstat,
-	       IRONGATE0->agpcmd,
-	       IRONGATE0->agpva,
-	       IRONGATE0->agpmode,
-	       IRONGATE1->dev_vendor,
-	       IRONGATE1->stat_cmd,
-	       IRONGATE1->class,
-	       IRONGATE1->htype,
-	       IRONGATE1->rsrvd0[0],
-	       IRONGATE1->rsrvd0[1],
-	       IRONGATE1->busnos,
-	       IRONGATE1->io_baselim_regs,
-	       IRONGATE1->mem_baselim,
-	       IRONGATE1->pfmem_baselim,
-	       IRONGATE1->rsrvd1[0],
-	       IRONGATE1->rsrvd1[1],
-	       IRONGATE1->io_baselim,
-	       IRONGATE1->rsrvd2[0],
-	       IRONGATE1->rsrvd2[1],
-	       IRONGATE1->interrupt );
-}
-#else
-#define irongate_register_dump(x)
-#endif
-
 int
 irongate_pci_clr_err(void)
 {
@@ -315,11 +177,11 @@ again:
 	mb();
 	IRONGATE_jd = IRONGATE0->stat_cmd;  /* re-read to force write */
 
-	IRONGATE_jd = IRONGATE0->dramms;
-	printk("Iron dramms %x\n", IRONGATE_jd);
-	IRONGATE0->dramms = IRONGATE_jd; /* write again clears error bits */
+	IRONGATE_jd = *IronECC;
+	printk("Iron ECC %x\n", IRONGATE_jd);
+	*IronECC = IRONGATE_jd; /* write again clears error bits */
 	mb();
-	IRONGATE_jd = IRONGATE0->dramms;  /* re-read to force write */
+	IRONGATE_jd = *IronECC;  /* re-read to force write */
 
 	/* Clear ALI NMI */
         nmi_ctl = inb(0x61);
@@ -328,28 +190,142 @@ again:
         nmi_ctl &= ~0x0c;
         outb(nmi_ctl, 0x61);
 
-	IRONGATE_jd = IRONGATE0->dramms;
+	IRONGATE_jd = *IronECC;
 	if (IRONGATE_jd & 0x300) goto again;
 
 	return 0;
 }
 
+#if 0
+#define	DDR_MAGIC	0x0905
+
+static void __init
+albacore_fix_ddr(void)
+{
+	igcsr32 *ddr = (igcsr32 *)IGCSR(0, 1, 0x8c);
+	unsigned int val = (DDR_MAGIC << 16) | DDR_MAGIC;
+
+	ddr[0] = val;
+	ddr[1] = val;
+	ddr[2] = val;
+	ddr[3] = val;
+	mb();
+}
+#endif
+
+#define IRONGATE_3GB 0xc0000000UL
+
+/* On Albacore (aka UP1500) with 4Gb of RAM we have to reserve some
+   memory for PCI. At this point we just reserve memory above 3Gb. Most
+   of this memory will be freed after PCI setup is done. */
+static void __init
+albacore_init_arch(void)
+{
+	unsigned long memtop = max_low_pfn << PAGE_SHIFT;
+	unsigned long pci_mem = (memtop + 0x1000000UL) & ~0xffffffUL;
+	struct percpu_struct *cpu = (struct percpu_struct*)
+		((char*)hwrpb + hwrpb->processor_offset);
+	int pal_rev = cpu->pal_revision & 0xffff;
+	int pal_var = (cpu->pal_revision >> 16) & 0xff;
+
+	/* Consoles earlier than A5.6-18 (OSF PALcode v1.62-2) have
+	   severe problems. Issue a warning for such consoles. */
+	if (alpha_using_srm &&
+	    (pal_rev < 0x13e ||	(pal_rev == 0x13e && pal_var < 2)))
+		printk(KERN_WARNING "WARNING! Upgrade to SRM A5.6-19 "
+				    "or later\n");
+
+	if (pci_mem > IRONGATE_3GB)
+		pci_mem = IRONGATE_3GB;
+	IRONGATE0->pci_mem = pci_mem;
+	alpha_mv.min_mem_address = pci_mem;
+	if (memtop > pci_mem) {
+#ifdef CONFIG_BLK_DEV_INITRD
+		extern unsigned long initrd_start, initrd_end;
+
+		/* Move the initrd out of the way. */
+		if (initrd_end && __pa(initrd_end) > pci_mem) {
+			void *start;
+			unsigned long size;
+
+			size = initrd_end - initrd_start;
+			start = __alloc_bootmem(size, PAGE_SIZE, 0);
+			if (!start || __pa(start) + size > pci_mem)
+				BUG();	/* Initrd way too large? */
+			memcpy(start, (void *)initrd_start, size);
+			free_bootmem(__pa(initrd_start), PAGE_ALIGN(size));
+			initrd_start = (unsigned long)start;
+			initrd_end = initrd_start + size;
+			printk("irongate_init_arch: initrd moved to %p\n",
+				start);
+		}
+#endif
+		reserve_bootmem(pci_mem, memtop - pci_mem);
+		printk("irongate_init_arch: temporarily reserving "
+			"region %08lx-%08lx for PCI\n", pci_mem, memtop - 1);
+	}
+#if 0
+	albacore_fix_ddr();
+#endif
+}
+
+static void __init
+irongate_setup_agp(void)
+{
+	u32 *mmio_regs, *gart_dir, pte;
+	int i, agpva;
+	unsigned long agpconf;
+
+	IRONGATE0->bar0 = 0;
+
+	/* If there is no AGP card (always dev 5 on the AGP bus),
+	   then the GART stuff makes no sense. */
+	agpconf = ((IRONGATE1->busnos & 0xff00) << 8) + (5 << 11);
+	if (*(volatile int *)(IRONGATE_CONF | agpconf) == -1)
+		alpha_agpgart_size = 0;
+
+	if (!alpha_agpgart_size) {
+		/* Disable GART window. */
+		IRONGATE0->agpva = IRONGATE0->agpva & ~0xf;
+		return;
+	}
+	agpva = (floor_log2(alpha_agpgart_size >> 25) << 1) | 1;
+	IRONGATE0->agpva = (IRONGATE0->agpva & ~0xf) | agpva;
+
+	/* Build dummy GART table which is referencing itself to
+	   avoid machine checks by speculative loads hitting
+	   the GART window. */
+	gart_dir = __alloc_bootmem(4096, 4096, 0);
+	pte = (u32)virt_to_phys(gart_dir);
+	for (i = 0; i < 1024; i++)
+		*gart_dir++ = pte | 1;
+	mb();
+
+	mmio_regs = (u32 *)(((unsigned long)IRONGATE0->bar1 &
+			PCI_BASE_ADDRESS_MEM_MASK) + IRONGATE_MEM);
+	mmio_regs[0] = mmio_regs[0] | 0x40000;	/* Enable GART */
+	mmio_regs[1] = pte;			/* Address of GART directory */
+	mmio_regs[3] = mmio_regs[3] | 1;	/* Invalidate all */
+	while (mmio_regs[3] & 1)
+		barrier();
+	IRONGATE0->agpmode |= 0x20000;		/* Page Dir Cache enable */
+	mb();
+}
+
 void __init
 irongate_init_arch(void)
 {
 	struct pci_controller *hose;
+	int amd761 = (IRONGATE0->dev_vendor >> 16) > 0x7006;	/* Albacore? */
+
+	IronECC = amd761 ? &IRONGATE0->bacsr54_eccms761 : &IRONGATE0->dramms;
 
-	IRONGATE0->stat_cmd = IRONGATE0->stat_cmd & ~0x100;
 	irongate_pci_clr_err();
-	irongate_register_dump(__FUNCTION__);
 
-	/*
-	 * HACK: set AGP aperture size to 256MB.
-	 * This should really be changed during PCI probe, when the
-	 * size of the aperture the AGP card wants is known.
-	 */
-	printk("irongate_init_arch: AGPVA was 0x%x\n", IRONGATE0->agpva);
-	IRONGATE0->agpva = (IRONGATE0->agpva & ~0x0000000f) | 0x00000007;
+	if (amd761)
+		albacore_init_arch();
+
+	irongate_setup_agp();
 
 	/*
 	 * Create our single hose.
@@ -374,203 +350,4 @@ irongate_init_arch(void)
 	hose->sg_isa = hose->sg_pci = NULL;
 	__direct_map_base = 0;
 	__direct_map_size = 0xffffffff;
-}
-
-/*
- * IO map and AGP support
- */
-#include <linux/vmalloc.h>
-#include <asm/pgalloc.h>
-
-static inline void 
-irongate_remap_area_pte(pte_t * pte, unsigned long address, unsigned long size, 
-		     unsigned long phys_addr, unsigned long flags)
-{
-	unsigned long end;
-	unsigned long pfn;
-
-	address &= ~PMD_MASK;
-	end = address + size;
-	if (end > PMD_SIZE)
-		end = PMD_SIZE;
-	if (address >= end)
-		BUG();
-	pfn = phys_addr >> PAGE_SHIFT;
-	do {
-		if (!pte_none(*pte)) {
-			printk("irongate_remap_area_pte: page already exists\n");
-			BUG();
-		}
-		set_pte(pte, pfn_pte(pfn,
-				     __pgprot(_PAGE_VALID | _PAGE_ASM | 
-					      _PAGE_KRE | _PAGE_KWE | flags)));
-		address += PAGE_SIZE;
-		pfn++;
-		pte++;
-	} while (address && (address < end));
-}
-
-static inline int 
-irongate_remap_area_pmd(pmd_t * pmd, unsigned long address, unsigned long size, 
-		     unsigned long phys_addr, unsigned long flags)
-{
-	unsigned long end;
-
-	address &= ~PGDIR_MASK;
-	end = address + size;
-	if (end > PGDIR_SIZE)
-		end = PGDIR_SIZE;
-	phys_addr -= address;
-	if (address >= end)
-		BUG();
-	do {
-		pte_t * pte = pte_alloc_kernel(&init_mm, pmd, address);
-		if (!pte)
-			return -ENOMEM;
-		irongate_remap_area_pte(pte, address, end - address, 
-				     address + phys_addr, flags);
-		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
-	} while (address && (address < end));
-	return 0;
-}
-
-static int
-irongate_remap_area_pages(unsigned long address, unsigned long phys_addr,
-		       unsigned long size, unsigned long flags)
-{
-	pgd_t * dir;
-	unsigned long end = address + size;
-
-	phys_addr -= address;
-	dir = pgd_offset(&init_mm, address);
-	flush_cache_all();
-	if (address >= end)
-		BUG();
-	do {
-		pmd_t *pmd;
-		pmd = pmd_alloc(&init_mm, dir, address);
-		if (!pmd)
-			return -ENOMEM;
-		if (irongate_remap_area_pmd(pmd, address, end - address,
-					 phys_addr + address, flags))
-			return -ENOMEM;
-		address = (address + PGDIR_SIZE) & PGDIR_MASK;
-		dir++;
-	} while (address && (address < end));
-	return 0;
-}
-
-#include <linux/agp_backend.h>
-#include <linux/agpgart.h>
-
-#define GET_PAGE_DIR_OFF(addr) (addr >> 22)
-#define GET_PAGE_DIR_IDX(addr) (GET_PAGE_DIR_OFF(addr))
-
-#define GET_GATT_OFF(addr) ((addr & 0x003ff000) >> 12) 
-#define GET_GATT(addr) (gatt_pages[GET_PAGE_DIR_IDX(addr)])
-
-unsigned long
-irongate_ioremap(unsigned long addr, unsigned long size)
-{
-	struct vm_struct *area;
-	unsigned long vaddr;
-	unsigned long baddr, last;
-	u32 *mmio_regs, *gatt_pages, *cur_gatt, pte;
-	unsigned long gart_bus_addr, gart_aper_size;
-
-	gart_bus_addr = (unsigned long)IRONGATE0->bar0 &
-			PCI_BASE_ADDRESS_MEM_MASK; 
-
-	if (!gart_bus_addr) /* FIXME - there must be a better way!!! */
-		return addr + IRONGATE_MEM;
-
-	gart_aper_size = IRONGATE_DEFAULT_AGP_APER_SIZE; /* FIXME */
-
-	/* 
-	 * Check for within the AGP aperture...
-	 */
-	do {
-		/*
-		 * Check the AGP area
-		 */
-		if (addr >= gart_bus_addr && addr + size - 1 < 
-		    gart_bus_addr + gart_aper_size)
-			break;
-
-		/*
-		 * Not found - assume legacy ioremap
-		 */
-		return addr + IRONGATE_MEM;
-	} while(0);
-
-	mmio_regs = (u32 *)(((unsigned long)IRONGATE0->bar1 &
-			PCI_BASE_ADDRESS_MEM_MASK) + IRONGATE_MEM);
-
-	gatt_pages = (u32 *)(phys_to_virt(mmio_regs[1])); /* FIXME */
-
-	/*
-	 * Adjust the limits (mappings must be page aligned)
-	 */
-	if (addr & ~PAGE_MASK) {
-		printk("AGP ioremap failed... addr not page aligned (0x%lx)\n",
-		       addr);
-		return addr + IRONGATE_MEM;
-	}
-	last = addr + size - 1;
-	size = PAGE_ALIGN(last) - addr;
-
-#if 0
-	printk("irongate_ioremap(0x%lx, 0x%lx)\n", addr, size);
-	printk("irongate_ioremap:  gart_bus_addr  0x%lx\n", gart_bus_addr);
-	printk("irongate_ioremap:  gart_aper_size 0x%lx\n", gart_aper_size);
-	printk("irongate_ioremap:  mmio_regs      %p\n", mmio_regs);
-	printk("irongate_ioremap:  gatt_pages     %p\n", gatt_pages);
-	
-	for(baddr = addr; baddr <= last; baddr += PAGE_SIZE)
-	{
-		cur_gatt = phys_to_virt(GET_GATT(baddr) & ~1);
-		pte = cur_gatt[GET_GATT_OFF(baddr)] & ~1;
-		printk("irongate_ioremap:  cur_gatt %p pte 0x%x\n",
-		       cur_gatt, pte);
-	}
-#endif
-
-	/*
-	 * Map it
-	 */
-	area = get_vm_area(size, VM_IOREMAP);
-	if (!area) return (unsigned long)NULL;
-
-	for(baddr = addr, vaddr = (unsigned long)area->addr; 
-	    baddr <= last; 
-	    baddr += PAGE_SIZE, vaddr += PAGE_SIZE)
-	{
-		cur_gatt = phys_to_virt(GET_GATT(baddr) & ~1);
-		pte = cur_gatt[GET_GATT_OFF(baddr)] & ~1;
-
-		if (irongate_remap_area_pages(VMALLOC_VMADDR(vaddr), 
-					   pte, PAGE_SIZE, 0)) {
-			printk("AGP ioremap: FAILED to map...\n");
-			vfree(area->addr);
-			return (unsigned long)NULL;
-		}
-	}
-
-	flush_tlb_all();
-
-	vaddr = (unsigned long)area->addr + (addr & ~PAGE_MASK);
-#if 0
-	printk("irongate_ioremap(0x%lx, 0x%lx) returning 0x%lx\n",
-	       addr, size, vaddr);
-#endif
-	return vaddr;
-}
-
-void
-irongate_iounmap(unsigned long addr)
-{
-	if (((long)addr >> 41) == -2)
-		return;	/* kseg map, nothing to do */
-	if (addr) return vfree((void *)(PAGE_MASK & addr)); 
 }
--- 2.5.34/arch/alpha/kernel/sys_nautilus.c	Wed Apr 17 00:54:30 2002
+++ linux/arch/alpha/kernel/sys_nautilus.c	Fri Sep  6 03:07:45 2002
@@ -31,6 +31,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/reboot.h>
+#include <linux/bootmem.h>
 
 #include <asm/ptrace.h>
 #include <asm/system.h>
@@ -189,19 +190,21 @@ static const char *slotb = "";
 static const char *membus = "";
 #endif
 
+static char interp[256];
+
 static void
-ev6_crd_interp(char *interp, struct el_common_EV6_mcheck * L)
+ev6_crd_interp(struct el_common_EV6_mcheck * L)
 {
 	/* Icache data or tag parity error.  */
 	if (L->I_STAT & EV6__I_STAT__PAR) {
-		sprintf(interp, "%s: I_STAT[PAR]\n "
+		snprintf(interp, 255, "%s: I_STAT[PAR]\n "
 			"Icache data or tag parity error", interr);
 		return;
 	}
 
 	/* Dcache tag parity error (on issue) (DFAULT).  */
 	if (L->MM_STAT & EV6__MM_STAT__DC_TAG_PERR) {
-		sprintf(interp, "%s: MM_STAT[DC_TAG_PERR]\n "
+		snprintf(interp, 255, "%s: MM_STAT[DC_TAG_PERR]\n "
 			"Dcache tag parity error(on issue)", interr);
 		return;
 	}
@@ -212,7 +215,7 @@ ev6_crd_interp(char *interp, struct el_c
 			      | EV6__DC_STAT__ECC_ERR_LD)) {
 	case EV6__DC_STAT__ECC_ERR_ST:
 		/* Dcache single-bit ECC error on small store */
-		sprintf(interp, "%s: DC_STAT[ECC_ERR_ST]\n "
+		snprintf(interp, 255, "%s: DC_STAT[ECC_ERR_ST]\n "
 			"Dcache single-bit ECC error on small store", interr);
 		return;
 
@@ -221,28 +224,28 @@ ev6_crd_interp(char *interp, struct el_c
 		case 0:
 			/* Dcache single-bit error on speculative load */
 			/* Bcache victim read on Dcache/Bcache miss */
-			sprintf(interp, "%s: DC_STAT[ECC_ERR_LD] C_STAT=0\n "
+			snprintf(interp, 255, "%s: DC_STAT[ECC_ERR_LD] C_STAT=0\n "
 				"Dcache single-bit ECC error on speculative load",
 				slotb);
 			return;
 
 		case EV6__C_STAT__DSTREAM_DC_ERR:
 			/* Dcache single bit error on load */
-			sprintf(interp, "%s: DC_STAT[ECC_ERR_LD] C_STAT[DSTREAM_DC_ERR]\n"
+			snprintf(interp, 255, "%s: DC_STAT[ECC_ERR_LD] C_STAT[DSTREAM_DC_ERR]\n"
 				" Dcache single-bit ECC error on speculative load, bit %d",
 				interr, ev6_syn2bit(L->DC0_SYNDROME, L->DC1_SYNDROME));
 			return;
 
 		case EV6__C_STAT__DSTREAM_BC_ERR:
 			/* Bcache single-bit error on Dcache fill */
-			sprintf(interp, "%s: DC_STAT[ECC_ERR_LD] C_STAT[DSTREAM_BC_ERR]\n"
+			snprintf(interp, 255, "%s: DC_STAT[ECC_ERR_LD] C_STAT[DSTREAM_BC_ERR]\n"
 				" Bcache single-bit error on Dcache fill, bit %d",
 				slotb, ev6_syn2bit(L->DC0_SYNDROME, L->DC1_SYNDROME));
 			return;
 
 		case EV6__C_STAT__DSTREAM_MEM_ERR:
 			/* Memory single-bit error on Dcache fill */
-			sprintf(interp, "%s (to Dcache): DC_STAT[ECC_ERR_LD] "
+			snprintf(interp, 255, "%s (to Dcache): DC_STAT[ECC_ERR_LD] "
 				"C_STAT[DSTREAM_MEM_ERR]\n "
 				"Memory single-bit error on Dcache fill, "
 				"Address 0x%lX, bit %d",
@@ -256,14 +259,14 @@ ev6_crd_interp(char *interp, struct el_c
 	switch (L->C_STAT) {
 	case EV6__C_STAT__ISTREAM_BC_ERR:
 		/* Bcache single-bit error on Icache fill (also MCHK) */
-		sprintf(interp, "%s: C_STAT[ISTREAM_BC_ERR]\n "
+		snprintf(interp, 255, "%s: C_STAT[ISTREAM_BC_ERR]\n "
 			"Bcache single-bit error on Icache fill, bit %d",
 			slotb, ev6_syn2bit(L->DC0_SYNDROME, L->DC1_SYNDROME));
 		return;
 
 	case EV6__C_STAT__ISTREAM_MEM_ERR:
 		/* Memory single-bit error on Icache fill (also MCHK) */
-		sprintf(interp, "%s : C_STATISTREAM_MEM_ERR]\n "
+		snprintf(interp, 255, "%s : C_STATISTREAM_MEM_ERR]\n "
 			"Memory single-bit error on Icache fill "
 			"addr 0x%lX, bit %d",
 			membus, L->C_ADDR, ev6_syn2bit(L->DC0_SYNDROME,
@@ -273,7 +276,7 @@ ev6_crd_interp(char *interp, struct el_c
 	case EV6__C_STAT__PROBE_BC_ERR0:
 	case EV6__C_STAT__PROBE_BC_ERR1:
 		/* Bcache single-bit error on a probe hit */
-		sprintf(interp, "%s: C_STAT[PROBE_BC_ERR]\n "
+		snprintf(interp, 255, "%s: C_STAT[PROBE_BC_ERR]\n "
 			"Bcache single-bit error on a probe hit, "
 			"addr 0x%lx, bit %d",
 			slotb, L->C_ADDR, ev6_syn2bit(L->DC0_SYNDROME,
@@ -283,20 +286,20 @@ ev6_crd_interp(char *interp, struct el_c
 }
 
 static void
-ev6_mchk_interp(char *interp, struct el_common_EV6_mcheck * L)
+ev6_mchk_interp(struct el_common_EV6_mcheck * L)
 {
 	/* Machine check errors described by DC_STAT */
 	switch (L->DC_STAT) {
 	case EV6__DC_STAT__TPERR_P0:
 	case EV6__DC_STAT__TPERR_P1:
 		/* Dcache tag parity error (on retry) */
-		sprintf(interp, "%s: DC_STAT[TPERR_P0|TPERR_P1]\n "
+		snprintf(interp, 255, "%s: DC_STAT[TPERR_P0|TPERR_P1]\n "
 			"Dcache tag parity error(on retry)", interr);
 		return;
 
 	case EV6__DC_STAT__SEO:
 		/* Dcache second error on store */
-		sprintf(interp, "%s: DC_STAT[SEO]\n "
+		snprintf(interp, 255, "%s: DC_STAT[SEO]\n "
 			"Dcache second error during mcheck", interr);
 		return;
 	}
@@ -305,21 +308,21 @@ ev6_mchk_interp(char *interp, struct el_
 	switch (L->C_STAT) {
 	case EV6__C_STAT__DC_PERR:
 		/* Dcache duplicate tag parity error */
-		sprintf(interp, "%s: C_STAT[DC_PERR]\n "
+		snprintf(interp, 255, "%s: C_STAT[DC_PERR]\n "
 			"Dcache duplicate tag parity error at 0x%lX",
 			interr, L->C_ADDR);
 		return;
 
 	case EV6__C_STAT__BC_PERR:
 		/* Bcache tag parity error */
-		sprintf(interp, "%s: C_STAT[BC_PERR]\n "
+		snprintf(interp, 255, "%s: C_STAT[BC_PERR]\n "
 			"Bcache tag parity error at 0x%lX",
 			slotb, L->C_ADDR);
 		return;
 
 	case EV6__C_STAT__ISTREAM_BC_ERR:
 		/* Bcache single-bit error on Icache fill (also CRD) */
-		sprintf(interp, "%s: C_STAT[ISTREAM_BC_ERR]\n "
+		snprintf(interp, 255, "%s: C_STAT[ISTREAM_BC_ERR]\n "
 			"Bcache single-bit error on Icache fill 0x%lX bit %d",
 			slotb, L->C_ADDR,
 			ev6_syn2bit(L->DC0_SYNDROME, L->DC1_SYNDROME));
@@ -328,7 +331,7 @@ ev6_mchk_interp(char *interp, struct el_
 
 	case EV6__C_STAT__ISTREAM_MEM_ERR:
 		/* Memory single-bit error on Icache fill (also CRD) */
-		sprintf(interp, "%s: C_STAT[ISTREAM_MEM_ERR]\n "
+		snprintf(interp, 255, "%s: C_STAT[ISTREAM_MEM_ERR]\n "
 			"Memory single-bit error on Icache fill 0x%lX, bit %d",
 			membus, L->C_ADDR,
 			ev6_syn2bit(L->DC0_SYNDROME, L->DC1_SYNDROME));
@@ -337,27 +340,27 @@ ev6_mchk_interp(char *interp, struct el_
 
 	case EV6__C_STAT__ISTREAM_BC_DBL:
 		/* Bcache double-bit error on Icache fill */
-		sprintf(interp, "%s: C_STAT[ISTREAM_BC_DBL]\n "
+		snprintf(interp, 255, "%s: C_STAT[ISTREAM_BC_DBL]\n "
 			"Bcache double-bit error on Icache fill at 0x%lX",
 			slotb, L->C_ADDR);
 		return;
 	case EV6__C_STAT__DSTREAM_BC_DBL:
 		/* Bcache double-bit error on Dcache fill */
-		sprintf(interp, "%s: C_STAT[DSTREAM_BC_DBL]\n "
+		snprintf(interp, 255, "%s: C_STAT[DSTREAM_BC_DBL]\n "
 			"Bcache double-bit error on Dcache fill at 0x%lX",
 			slotb, L->C_ADDR);
 		return;
 
 	case EV6__C_STAT__ISTREAM_MEM_DBL:
 		/* Memory double-bit error on Icache fill */
-		sprintf(interp, "%s: C_STAT[ISTREAM_MEM_DBL]\n "
+		snprintf(interp, 255, "%s: C_STAT[ISTREAM_MEM_DBL]\n "
 			"Memory double-bit error on Icache fill at 0x%lX",
 			membus, L->C_ADDR);
 		return;
 
 	case EV6__C_STAT__DSTREAM_MEM_DBL:
 		/* Memory double-bit error on Dcache fill */
-		sprintf(interp, "%s: C_STAT[DSTREAM_MEM_DBL]\n "
+		snprintf(interp, 255, "%s: C_STAT[DSTREAM_MEM_DBL]\n "
 			"Memory double-bit error on Dcache fill at 0x%lX",
 			membus, L->C_ADDR);
 		return;
@@ -368,8 +371,6 @@ static void
 ev6_cpu_machine_check(unsigned long vector, struct el_common_EV6_mcheck *L,
 		      struct pt_regs *regs)
 {
-	char interp[80];
-
 	/* This is verbose and looks intimidating.  Should it be printed for
 	   corrected (CRD) machine checks? */
 
@@ -403,9 +404,9 @@ ev6_cpu_machine_check(unsigned long vect
 	/* Attempt an interpretation on the meanings of the fields above.  */
 	sprintf(interp, "No interpretation available!" );
 	if (vector == SCB_Q_PROCERR)
-		ev6_crd_interp(interp, L);
+		ev6_crd_interp(L);
 	else if (vector == SCB_Q_PROCMCHK)
-		ev6_mchk_interp(interp, L);
+		ev6_mchk_interp(L);
 
 	printk(KERN_CRIT "interpretation: %s\n\n", interp);
 }
@@ -430,14 +431,13 @@ nautilus_machine_check(unsigned long vec
 		       struct pt_regs *regs)
 {
 	char *mchk_class;
-	unsigned cpu_analysis=0, sys_analysis=0;
+	unsigned cpu_analysis = 0, sys_analysis = 0;
 
 	/* Now for some analysis.  Machine checks fall into two classes --
 	   those picked up by the system, and those picked up by the CPU.
 	   Add to that the two levels of severity - correctable or not.  */
 
-	if (vector == SCB_Q_SYSMCHK
-	    && ((IRONGATE0->dramms & 0x300) == 0x300)) {
+	if (vector == SCB_Q_SYSMCHK && (*IronECC & 0x300) == 0x300) {
 		unsigned long nmi_ctl;
 
 		/* Clear ALI NMI */
@@ -448,14 +448,14 @@ nautilus_machine_check(unsigned long vec
 		outb(nmi_ctl, 0x61);
 
 		/* Write again clears error bits.  */
-		IRONGATE0->stat_cmd = IRONGATE0->stat_cmd & ~0x100;
+		IRONGATE0->stat_cmd = IRONGATE0->stat_cmd;
 		mb();
 		IRONGATE0->stat_cmd;
 
 		/* Write again clears error bits.  */
-		IRONGATE0->dramms = IRONGATE0->dramms;
+		*IronECC = *IronECC;
 		mb();
-		IRONGATE0->dramms;
+		*IronECC;
 
 		draina();
 		wrmces(0x7);
@@ -503,7 +503,77 @@ nautilus_machine_check(unsigned long vec
 	mb();
 }
 
+extern void free_reserved_mem(void *, void *);
+extern void pbus_size_bridges(struct pci_bus *);
+extern void pbus_assign_resources(struct pci_bus *);
+
+void __init
+nautilus_init_pci(void)
+{
+	struct pci_controller *hose = hose_head;
+	struct pci_bus *bus;
+	struct pci_dev *irongate, *dev;
+	unsigned long saved_io_start, saved_io_end;
+	unsigned long saved_mem_start, saved_mem_end;
+	unsigned long bus_align, bus_size, pci_mem;
+	unsigned long memtop = max_low_pfn << PAGE_SHIFT;
+
+	/* Scan our single hose.  */
+	bus = pci_scan_bus(0, alpha_mv.pci_ops, hose);
+	hose->bus = bus;
+	hose->last_busno = bus->subordinate;
+
+	/* Sizing the root bus is a bit tricky. We must
+	   - have non-NULL PCI device associated with the bus
+	   - preserve root bus (hose) resources. */
+	irongate = pci_find_slot(0, 0);
+	bus->self = irongate;
+	saved_io_start = bus->resource[0]->start;
+	saved_io_end = bus->resource[0]->end;
+	saved_mem_start = bus->resource[1]->start;
+	saved_mem_end = bus->resource[1]->end;
+
+	pbus_size_bridges(bus);
+
+	bus->self = NULL;	/* Huh. */
+
+	/* Don't care about IO. */
+	bus->resource[0]->start = saved_io_start;
+	bus->resource[0]->end = saved_io_end;
+
+	bus_align = bus->resource[1]->start;
+	bus_size = bus->resource[1]->end + 1 - bus_align;
+	/* Align to 16Mb. */
+	if (bus_align < 0x1000000UL)
+		bus_align = 0x1000000UL;
+
+	/* Restore hose MEM resource. */
+	bus->resource[1]->start = saved_mem_start;
+	bus->resource[1]->end = saved_mem_end;
+
+	/* Do not allocate in the last megabyte - the ALi bridge might
+	   respond to these addresses. */
+	pci_mem = (0x100000000UL - 1024*1024 - bus_size) & -bus_align;
+
+	if (pci_mem < memtop && pci_mem > alpha_mv.min_mem_address) {
+		free_reserved_mem(__va(alpha_mv.min_mem_address),
+				  __va(pci_mem));
+		printk("nautilus_init_arch: %ldk freed\n",
+			(pci_mem - alpha_mv.min_mem_address) >> 10);
+	}
+
+	alpha_mv.min_mem_address = pci_mem;
+	if (irongate->device > 0x7006)		/* Albacore? */
+		IRONGATE0->pci_mem = pci_mem;
+
+	pbus_assign_resources(bus);
 
+	pci_for_each_dev(dev) {
+		pdev_enable_device(dev);
+	}
+
+	pci_fixup_irqs(alpha_mv.pci_swizzle, alpha_mv.pci_map_irq);
+}
 
 /*
  * The System Vectors
@@ -526,7 +596,7 @@ struct alpha_machine_vector nautilus_mv 
 	init_arch:		irongate_init_arch,
 	init_irq:		nautilus_init_irq,
 	init_rtc:		common_init_rtc,
-	init_pci:		common_init_pci,
+	init_pci:		nautilus_init_pci,
 	kill_arch:		nautilus_kill_arch,
 	pci_map_irq:		nautilus_map_irq,
 	pci_swizzle:		common_swizzle,
--- 2.5.34/arch/alpha/kernel/pci_impl.h	Mon Mar 18 23:37:18 2002
+++ linux/arch/alpha/kernel/pci_impl.h	Fri Sep  6 03:09:24 2002
@@ -70,6 +70,12 @@ struct pci_iommu_arena;
 
 #define IRONGATE_DEFAULT_MEM_BASE ((256*8-16)*1024*1024)
 
+#if 0	/* By now, Irongate AGP GART is non-functional */
+#define DEFAULT_AGP_APERTURE	(128*1024*1024)
+#else
+#define DEFAULT_AGP_APERTURE	0
+#endif
+
 /* 
  * A small note about bridges and interrupts.  The DECchip 21050 (and
  * later) adheres to the PCI-PCI bridge specification.  This says that
@@ -149,6 +155,8 @@ struct pci_iommu_arena
 extern struct pci_controller *hose_head, **hose_tail;
 extern struct pci_controller *pci_isa_hose;
 
+extern unsigned long alpha_agpgart_size;
+
 extern void common_init_pci(void);
 extern u8 common_swizzle(struct pci_dev *, u8 *);
 extern struct pci_controller *alloc_pci_controller(void);
@@ -169,5 +177,3 @@ extern int iommu_reserve(struct pci_iomm
 extern int iommu_release(struct pci_iommu_arena *, long, long);
 extern int iommu_bind(struct pci_iommu_arena *, long, long, unsigned long *);
 extern int iommu_unbind(struct pci_iommu_arena *, long, long);
-
-
--- 2.5.34/arch/alpha/kernel/pci_iommu.c	Mon Mar 18 23:37:19 2002
+++ linux/arch/alpha/kernel/pci_iommu.c	Fri Sep  6 03:07:45 2002
@@ -213,20 +213,17 @@ pci_map_single_1(struct pci_dev *pdev, v
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
@@ -360,8 +357,10 @@ pci_alloc_consistent(struct pci_dev *pde
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
@@ -375,7 +374,12 @@ pci_alloc_consistent(struct pci_dev *pde
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
@@ -723,8 +727,8 @@ pci_dma_supported(struct pci_dev *pdev, 
 	   the entire direct mapped space or the total system memory as
 	   shifted by the map base */
 	if (__direct_map_size != 0
-	    && (__direct_map_base + __direct_map_size - 1 <= mask
-		|| __direct_map_base + (max_low_pfn<<PAGE_SHIFT)-1 <= mask))
+	    && (__direct_map_base + __direct_map_size - 1 <= mask ||
+		__direct_map_base + (max_low_pfn << PAGE_SHIFT) - 1 <= mask))
 		return 1;
 
 	/* Check that we have a scatter-gather arena that fits.  */
@@ -734,6 +738,10 @@ pci_dma_supported(struct pci_dev *pdev, 
 		return 1;
 	arena = hose->sg_pci;
 	if (arena && arena->dma_base + arena->size - 1 <= mask)
+		return 1;
+
+	/* As last resort try ZONE_DMA.  */
+	if (MAX_DMA_ADDRESS - IDENT_ADDR - 1 <= mask)
 		return 1;
 
 	return 0;
--- 2.5.34/arch/alpha/kernel/setup.c	Tue Sep  3 01:11:59 2002
+++ linux/arch/alpha/kernel/setup.c	Fri Sep  6 03:07:45 2002
@@ -84,6 +84,10 @@ int srmcons_output = 0;
 /* Enforce a memory size limit; useful for testing. By default, none. */
 unsigned long mem_size_limit = 0;
 
+/* Set AGP GART window size (0 means disabled). As of 2002-05-26 the
+   "gartsize=" bootcommand arg makes sense on Nautilus only. */
+unsigned long alpha_agpgart_size = DEFAULT_AGP_APERTURE;
+
 #ifdef CONFIG_ALPHA_GENERIC
 struct alpha_machine_vector alpha_mv;
 int alpha_using_srm;
@@ -527,6 +531,11 @@ setup_arch(char **cmdline_p)
 		}
 		if (strncmp(p, "srmcons", 7) == 0) {
 			srmcons_output = 1;
+			continue;
+		}
+		if (strncmp(p, "gartsize=", 9) == 0) {
+			alpha_agpgart_size =
+				get_mem_size_limit(p+9) << PAGE_SHIFT;
 			continue;
 		}
 	}
--- 2.5.34/arch/alpha/kernel/alpha_ksyms.c	Tue Sep  3 01:12:07 2002
+++ linux/arch/alpha/kernel/alpha_ksyms.c	Fri Sep  6 03:07:45 2002
@@ -253,8 +253,3 @@ EXPORT_SYMBOL_NOVERS(memset);
 EXPORT_SYMBOL_NOVERS(memchr);
 
 EXPORT_SYMBOL(get_wchan);
-
-#ifdef CONFIG_ALPHA_IRONGATE
-EXPORT_SYMBOL(irongate_ioremap);
-EXPORT_SYMBOL(irongate_iounmap);
-#endif
--- 2.5.34/arch/alpha/mm/init.c	Sun May 26 13:58:19 2002
+++ linux/arch/alpha/mm/init.c	Fri Sep  6 03:07:45 2002
@@ -357,18 +357,23 @@ mem_init(void)
 #endif /* CONFIG_DISCONTIGMEM */
 
 void
-free_initmem (void)
+free_reserved_mem(void *start, void *end)
 {
-	extern char __init_begin, __init_end;
-	unsigned long addr;
-
-	addr = (unsigned long)(&__init_begin);
-	for (; addr < (unsigned long)(&__init_end); addr += PAGE_SIZE) {
-		ClearPageReserved(virt_to_page(addr));
-		set_page_count(virt_to_page(addr), 1);
-		free_page(addr);
+	void *__start = start;
+	for (; __start < end; __start += PAGE_SIZE) {
+		ClearPageReserved(virt_to_page(__start));
+		set_page_count(virt_to_page(__start), 1);
+		free_page((long)__start);
 		totalram_pages++;
 	}
+}
+
+void
+free_initmem(void)
+{
+	extern char __init_begin, __init_end;
+
+	free_reserved_mem(&__init_begin, &__init_end);
 	printk ("Freeing unused kernel memory: %ldk freed\n",
 		(&__init_end - &__init_begin) >> 10);
 }
@@ -377,13 +382,7 @@ free_initmem (void)
 void
 free_initrd_mem(unsigned long start, unsigned long end)
 {
-	unsigned long __start = start;
-	for (; start < end; start += PAGE_SIZE) {
-		ClearPageReserved(virt_to_page(start));
-		set_page_count(virt_to_page(start), 1);
-		free_page(start);
-		totalram_pages++;
-	}
-	printk ("Freeing initrd memory: %ldk freed\n", (end - __start) >> 10);
+	free_reserved_mem((void *)start, (void *)end);
+	printk ("Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
 }
 #endif
--- 2.5.34/include/asm-alpha/core_irongate.h	Mon Mar 18 23:37:11 2002
+++ linux/include/asm-alpha/core_irongate.h	Fri Sep  6 03:07:45 2002
@@ -50,13 +50,14 @@ typedef struct {
 
 	igcsr32 bacsr10;		/* 0x40 - base address chip selects */
 	igcsr32 bacsr32;		/* 0x44 - base address chip selects */
-	igcsr32 bacsr54;		/* 0x48 - base address chip selects */
+	igcsr32 bacsr54_eccms761;	/* 0x48 - 751: base addr. chip selects
+						  761: ECC, mode/status */
 
 	igcsr32 rsrvd2[1];		/* 0x4C-0x4F reserved */
 
 	igcsr32 drammap;		/* 0x50 - address mapping control */
 	igcsr32 dramtm;			/* 0x54 - timing, driver strength */
-	igcsr32 dramms;			/* 0x58 - ECC, mode/status */
+	igcsr32 dramms;			/* 0x58 - DRAM mode/status */
 
 	igcsr32 rsrvd3[1];		/* 0x5C-0x5F reserved */
 
@@ -73,7 +74,10 @@ typedef struct {
 	igcsr32 pciarb;			/* 0x84 - PCI arbitration control */
 	igcsr32 pcicfg;			/* 0x88 - PCI config status */
 
-	igcsr32 rsrvd6[5];		/* 0x8C-0x9F reserved */
+	igcsr32 rsrvd6[4];		/* 0x8C-0x9B reserved */
+
+	igcsr32 pci_mem;		/* 0x9C - PCI top of memory,
+						  761 only */
 
 	/* AGP (bus 1) control registers */
 	igcsr32 agpcap;			/* 0xA0 - AGP Capability Identifier */
@@ -102,6 +106,7 @@ typedef struct {
 
 } Irongate1;
 
+extern igcsr32 *IronECC;
 
 /*
  * Memory spaces:
@@ -267,8 +272,17 @@ __EXTERN_INLINE void irongate_writeq(u64
 	*(vulp)addr = b;
 }
 
-extern unsigned long irongate_ioremap(unsigned long addr, unsigned long size);
-extern void irongate_iounmap(unsigned long addr);
+__EXTERN_INLINE unsigned long irongate_ioremap(unsigned long addr, 
+					       unsigned long size
+					       __attribute__((unused)))
+{
+	return addr + IRONGATE_MEM;
+}
+
+__EXTERN_INLINE void irongate_iounmap(unsigned long addr)
+{
+	return;
+}
 
 __EXTERN_INLINE int irongate_is_ioaddr(unsigned long addr)
 {
