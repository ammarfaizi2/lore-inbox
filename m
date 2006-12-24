Return-Path: <linux-kernel-owner+w=401wt.eu-S1752288AbWLXRFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288AbWLXRFw (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 12:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752394AbWLXRFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 12:05:52 -0500
Received: from mail.parknet.jp ([210.171.160.80]:2497 "EHLO parknet.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752288AbWLXRFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 12:05:51 -0500
X-AuthUser: hirofumi@parknet.jp
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: [RFC] i386: per-cpu mmconfig map
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 25 Dec 2006 02:05:46 +0900
Message-ID: <87lkkxz0k5.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

    [ Alternatively, we could make a per-cpu mapping area or something. Not
      that it's probably worth it, but if we wanted to avoid all locking and
      instead just disable preemption, that would be the way to go. --Linus ]

This patch is a draft of Linus's suggestion. This seems work for me.
And this removes pci_config_lock in mmconfig access path, I think we
don't need lock on this path, although we need to disable IRQ.

Comment?

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>



Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 arch/i386/pci/mmconfig.c  |   89 ++++++++++++++++++++++++----------------------
 include/asm-i386/fixmap.h |    3 +
 2 files changed, 49 insertions(+), 43 deletions(-)

diff -puN include/asm-i386/fixmap.h~pci_mmcfg-per_cpu-map include/asm-i386/fixmap.h
--- linux-2.6/include/asm-i386/fixmap.h~pci_mmcfg-per_cpu-map	2006-12-25 00:03:24.000000000 +0900
+++ linux-2.6-hirofumi/include/asm-i386/fixmap.h	2006-12-25 00:03:25.000000000 +0900
@@ -84,7 +84,8 @@ enum fixed_addresses {
 	FIX_ACPI_END = FIX_ACPI_BEGIN + FIX_ACPI_PAGES - 1,
 #endif
 #ifdef CONFIG_PCI_MMCONFIG
-	FIX_PCIE_MCFG,
+	FIX_PCIE_MCFG_BEGIN,
+	FIX_PCIE_MCFG_END = FIX_PCIE_MCFG_BEGIN + NR_CPUS - 1,
 #endif
 	__end_of_permanent_fixed_addresses,
 	/* temporary boot-time mappings, used before ioremap() is functional */
diff -puN arch/i386/pci/mmconfig.c~pci_mmcfg-per_cpu-map arch/i386/pci/mmconfig.c
--- linux-2.6/arch/i386/pci/mmconfig.c~pci_mmcfg-per_cpu-map	2006-12-25 00:03:25.000000000 +0900
+++ linux-2.6-hirofumi/arch/i386/pci/mmconfig.c	2006-12-25 00:03:25.000000000 +0900
@@ -22,11 +22,8 @@
 /* Assume systems with more busses have correct MCFG */
 #define MAX_CHECK_BUS 16
 
-#define mmcfg_virt_addr ((void __iomem *) fix_to_virt(FIX_PCIE_MCFG))
-
 /* The base address of the last MMCONFIG device accessed */
-static u32 mmcfg_last_accessed_device;
-static int mmcfg_last_accessed_cpu;
+static DEFINE_PER_CPU(u32, mcfg_last_dev_base);
 
 static DECLARE_BITMAP(fallback_slots, MAX_CHECK_BUS*32);
 
@@ -68,24 +65,29 @@ static u32 get_base_addr(unsigned int se
 	return 0;
 }
 
-/*
- * This is always called under pci_config_lock
- */
-static void pci_exp_set_dev_base(unsigned int base, int bus, int devfn)
+static void __iomem *mcfg_map_dev_base(unsigned int base, int bus, int devfn)
 {
 	u32 dev_base = base | (bus << 20) | (devfn << 12);
-	int cpu = smp_processor_id();
-	if (dev_base != mmcfg_last_accessed_device ||
-	    cpu != mmcfg_last_accessed_cpu) {
-		mmcfg_last_accessed_device = dev_base;
-		mmcfg_last_accessed_cpu = cpu;
-		set_fixmap_nocache(FIX_PCIE_MCFG, dev_base);
+	int cpu, idx;
+
+	cpu = get_cpu();
+	idx = FIX_PCIE_MCFG_BEGIN + cpu;
+	if (dev_base != __get_cpu_var(mcfg_last_dev_base)) {
+		__get_cpu_var(mcfg_last_dev_base) = dev_base;
+		set_fixmap_nocache(idx, dev_base);
 	}
+	return (void __iomem *)__fix_to_virt(idx);
+}
+
+static inline void mcfg_unmap_dev_base(void)
+{
+	put_cpu();
 }
 
 static int pci_mmcfg_read(unsigned int seg, unsigned int bus,
 			  unsigned int devfn, int reg, int len, u32 *value)
 {
+	void __iomem *vaddr;
 	unsigned long flags;
 	u32 base;
 
@@ -98,23 +100,23 @@ static int pci_mmcfg_read(unsigned int s
 	if (!base)
 		return pci_conf1_read(seg,bus,devfn,reg,len,value);
 
-	spin_lock_irqsave(&pci_config_lock, flags);
-
-	pci_exp_set_dev_base(base, bus, devfn);
+	local_irq_save(flags);
+	vaddr = mcfg_map_dev_base(base, bus, devfn);
 
 	switch (len) {
 	case 1:
-		*value = readb(mmcfg_virt_addr + reg);
+		*value = readb(vaddr + reg);
 		break;
 	case 2:
-		*value = readw(mmcfg_virt_addr + reg);
+		*value = readw(vaddr + reg);
 		break;
 	case 4:
-		*value = readl(mmcfg_virt_addr + reg);
+		*value = readl(vaddr + reg);
 		break;
 	}
 
-	spin_unlock_irqrestore(&pci_config_lock, flags);
+	mcfg_unmap_dev_base();
+	local_irq_restore(flags);
 
 	return 0;
 }
@@ -122,6 +124,7 @@ static int pci_mmcfg_read(unsigned int s
 static int pci_mmcfg_write(unsigned int seg, unsigned int bus,
 			   unsigned int devfn, int reg, int len, u32 value)
 {
+	void __iomem *vaddr;
 	unsigned long flags;
 	u32 base;
 
@@ -132,23 +135,23 @@ static int pci_mmcfg_write(unsigned int 
 	if (!base)
 		return pci_conf1_write(seg,bus,devfn,reg,len,value);
 
-	spin_lock_irqsave(&pci_config_lock, flags);
-
-	pci_exp_set_dev_base(base, bus, devfn);
+	local_irq_save(flags);
+	vaddr = mcfg_map_dev_base(base, bus, devfn);
 
 	switch (len) {
 	case 1:
-		writeb(value, mmcfg_virt_addr + reg);
+		writeb(value, vaddr + reg);
 		break;
 	case 2:
-		writew(value, mmcfg_virt_addr + reg);
+		writew(value, vaddr + reg);
 		break;
 	case 4:
-		writel(value, mmcfg_virt_addr + reg);
+		writel(value, vaddr + reg);
 		break;
 	}
 
-	spin_unlock_irqrestore(&pci_config_lock, flags);
+	mcfg_unmap_dev_base();
+	local_irq_restore(flags);
 
 	return 0;
 }
@@ -166,30 +169,32 @@ static struct pci_raw_ops pci_mmcfg = {
    and fallback for them. */
 static __init void unreachable_devices(void)
 {
-	int i, k;
+	int i, bus;
 	unsigned long flags;
 
-	for (k = 0; k < MAX_CHECK_BUS; k++) {
+	for (bus = 0; bus < MAX_CHECK_BUS; bus++) {
 		for (i = 0; i < 32; i++) {
-			u32 val1;
-			u32 addr;
+			void __iomem *vaddr = NULL;
+			unsigned int devfn = PCI_DEVFN(i, 0);
+			u32 base, val1;
 
-			pci_conf1_read(0, k, PCI_DEVFN(i, 0), 0, 4, &val1);
+			pci_conf1_read(0, bus, devfn, 0, 4, &val1);
 			if (val1 == 0xffffffff)
 				continue;
 
 			/* Locking probably not needed, but safer */
-			spin_lock_irqsave(&pci_config_lock, flags);
-			addr = get_base_addr(0, k, PCI_DEVFN(i, 0));
-			if (addr != 0)
-				pci_exp_set_dev_base(addr, k, PCI_DEVFN(i, 0));
-			if (addr == 0 ||
-			    readl((u32 __iomem *)mmcfg_virt_addr) != val1) {
-				set_bit(i + 32*k, fallback_slots);
+			local_irq_save(flags);
+			base = get_base_addr(0, bus, devfn);
+			if (base != 0)
+				vaddr = mcfg_map_dev_base(base, bus, devfn);
+			if (base == 0 || readl(vaddr) != val1) {
+				set_bit(i + 32*bus, fallback_slots);
 				printk(KERN_NOTICE
-			"PCI: No mmconfig possible on %x:%x\n", k, i);
+			"PCI: No mmconfig possible on %x:%x\n", bus, i);
 			}
-			spin_unlock_irqrestore(&pci_config_lock, flags);
+			if (vaddr)
+				mcfg_unmap_dev_base();
+			local_irq_restore(flags);
 		}
 	}
 }
_
