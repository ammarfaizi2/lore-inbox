Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266122AbUA2P7r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 10:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266166AbUA2P7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 10:59:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31183 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266122AbUA2P7P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 10:59:15 -0500
Date: Thu, 29 Jan 2004 15:59:11 +0000
From: Matthew Wilcox <willy@debian.org>
To: Matthew Wilcox <willy@debian.org>
Cc: "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       torvalds@osdl.org, alan@lxorguk.ukuu.org.uk, greg@kroah.com,
       Andi Kleen <ak@colin2.muc.de>, akpm@osdl.org, mj@ucw.cz,
       "Kondratiev, Vladimir" <vladimir.kondratiev@intel.com>,
       "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [patch] PCI Express Enhanced Config Patch - 2.6.0-test11
Message-ID: <20040129155911.GD18725@parcelfarce.linux.theplanet.co.uk>
References: <6B09584CC3D2124DB45C3B592414FA830112C34F@bgsmsx402.gar.corp.intel.com> <20040129150925.GC18725@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040129150925.GC18725@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 29, 2004 at 03:09:25PM +0000, Matthew Wilcox wrote:
> On Thu, Jan 29, 2004 at 05:02:39PM +0530, Durairaj, Sundarapandian wrote:
> > Please review this updated patch and send your comments.
> 
> Here's a rewrite of Sundarapandian Durairaj's patch for accessing extended
> PCI configuration space.  Changes of note:

Brian Gerst spotted a bug -- I'd forgotten to initialise mmcfg_virt_addr.
Updated patch:

diff -urpNX build-tools/dontdiff linus-2.6/arch/i386/Kconfig pciexp-2.6/arch/i386/Kconfig
--- linus-2.6/arch/i386/Kconfig	2004-01-27 21:05:17.000000000 -0500
+++ pciexp-2.6/arch/i386/Kconfig	2004-01-29 09:16:22.000000000 -0500
@@ -1030,12 +1030,16 @@ config PCI_GOBIOS
 	  PCI-based systems don't have any BIOS at all. Linux can also try to
 	  detect the PCI hardware directly without using the BIOS.
 
-	  With this option, you can specify how Linux should detect the PCI
-	  devices. If you choose "BIOS", the BIOS will be used, if you choose
-	  "Direct", the BIOS won't be used, and if you choose "Any", the
-	  kernel will try the direct access method and falls back to the BIOS
-	  if that doesn't work. If unsure, go with the default, which is
-	  "Any".
+	  With this option, you can specify how Linux should detect the
+	  PCI devices. If you choose "BIOS", the BIOS will be used,
+	  if you choose "Direct", the BIOS won't be used, and if you
+	  choose "MMConfig", then PCI Express MMCONFIG will be used.
+	  If you choose "Any", the kernel will try MMCONFIG, then the
+	  direct access method and falls back to the BIOS if that doesn't
+	  work. If unsure, go with the default, which is "Any".
+
+config PCI_GOMMCONFIG
+	bool "MMConfig"
 
 config PCI_GODIRECT
 	bool "Direct"
@@ -1055,6 +1059,12 @@ config PCI_DIRECT
  	depends on PCI && ((PCI_GODIRECT || PCI_GOANY) || X86_VISWS)
 	default y
 
+config PCI_MMCONFIG
+	bool
+	depends on PCI && (PCI_GOMMCONFIG || PCI_GOANY)
+	select ACPI_BOOT
+	default y
+
 config PCI_USE_VECTOR
 	bool "Vector-based interrupt indexing"
 	depends on X86_LOCAL_APIC && X86_IO_APIC
diff -urpNX build-tools/dontdiff linus-2.6/arch/i386/kernel/acpi/boot.c pciexp-2.6/arch/i386/kernel/acpi/boot.c
--- linus-2.6/arch/i386/kernel/acpi/boot.c	2004-01-07 18:02:42.000000000 -0500
+++ pciexp-2.6/arch/i386/kernel/acpi/boot.c	2004-01-29 09:13:51.000000000 -0500
@@ -95,6 +95,27 @@ char *__acpi_map_table(unsigned long phy
 }
 
 
+#ifdef CONFIG_PCI_MMCONFIG
+static int __init acpi_parse_mcfg(unsigned long phys_addr, unsigned long size)
+{
+	struct acpi_table_mcfg *mcfg;
+
+	if (!phys_addr || !size)
+		return -EINVAL;
+
+	mcfg = (struct acpi_table_mcfg *) __acpi_map_table(phys_addr, size);
+	if (!mcfg) {
+		printk(KERN_WARNING PREFIX "Unable to map MCFG\n");
+		return -ENODEV;
+	}
+
+	if (mcfg->base_address)
+		pci_mmcfg_base_addr = mcfg->base_address;
+
+	return 0;
+}
+#endif /* CONFIG_PCI_MMCONFIG */
+
 #ifdef CONFIG_X86_LOCAL_APIC
 
 static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
@@ -515,6 +536,19 @@ acpi_boot_init (void)
 
 #endif /* CONFIG_X86_IO_APIC && CONFIG_ACPI_INTERPRETER */
 
+#ifdef CONFIG_PCI_MMCONFIG
+	result = acpi_table_parse(ACPI_MCFG, acpi_parse_mcfg);
+	if (!result) {
+		printk(KERN_WARNING PREFIX "MCFG not present\n");
+		return 0;
+	} else if (result < 0) {
+		printk(KERN_ERR PREFIX "Error parsing MCFG\n");
+		return result;
+	} else if (result > 1) {
+		printk(KERN_WARNING PREFIX "Multiple MCFG tables exist\n");
+	}
+#endif /* CONFIG_PCI_MMCONFIG */
+
 #ifdef CONFIG_X86_LOCAL_APIC
 	if (acpi_lapic && acpi_ioapic) {
 		smp_found_config = 1;
diff -urpNX build-tools/dontdiff linus-2.6/arch/i386/pci/Makefile pciexp-2.6/arch/i386/pci/Makefile
--- linus-2.6/arch/i386/pci/Makefile	2003-07-29 13:00:27.000000000 -0400
+++ pciexp-2.6/arch/i386/pci/Makefile	2004-01-29 08:11:28.000000000 -0500
@@ -1,6 +1,7 @@
 obj-y				:= i386.o
 
 obj-$(CONFIG_PCI_BIOS)		+= pcbios.o
+obj-$(CONFIG_PCI_MMCONFIG)	+= mmconfig.o
 obj-$(CONFIG_PCI_DIRECT)	+= direct.o
 
 pci-y				:= fixup.o
diff -urpNX build-tools/dontdiff linus-2.6/arch/i386/pci/common.c pciexp-2.6/arch/i386/pci/common.c
--- linus-2.6/arch/i386/pci/common.c	2003-09-08 17:41:32.000000000 -0400
+++ pciexp-2.6/arch/i386/pci/common.c	2004-01-29 08:11:19.000000000 -0500
@@ -19,7 +19,8 @@
 extern  void pcibios_sort(void);
 #endif
 
-unsigned int pci_probe = PCI_PROBE_BIOS | PCI_PROBE_CONF1 | PCI_PROBE_CONF2;
+unsigned int pci_probe = PCI_PROBE_BIOS | PCI_PROBE_CONF1 | PCI_PROBE_CONF2 |
+				PCI_PROBE_MMCONF;
 
 int pcibios_last_bus = -1;
 struct pci_bus *pci_root_bus = NULL;
@@ -197,6 +198,12 @@ char * __devinit  pcibios_setup(char *st
 		return NULL;
 	}
 #endif
+#ifdef CONFIG_PCI_MMCONFIG
+	else if (!strcmp(str, "nommconf")) {
+		pci_probe &= ~PCI_PROBE_MMCONF;
+		return NULL;
+	}
+#endif
 #ifdef CONFIG_ACPI_PCI
 	else if (!strcmp(str, "noacpi")) {
 		pci_probe |= PCI_NO_ACPI_ROUTING;
diff -urpNX build-tools/dontdiff linus-2.6/arch/i386/pci/mmconfig.c pciexp-2.6/arch/i386/pci/mmconfig.c
--- linus-2.6/arch/i386/pci/mmconfig.c	1969-12-31 19:00:00.000000000 -0500
+++ pciexp-2.6/arch/i386/pci/mmconfig.c	2004-01-29 10:50:30.000000000 -0500
@@ -0,0 +1,119 @@
+/*
+ * mmconfig.c - Low-level direct PCI config space access via MMCONFIG
+ */
+
+#include <linux/pci.h>
+#include <linux/init.h>
+#include "pci.h"
+
+/* The physical address of the MMCONFIG aperture.  Set from ACPI tables. */
+u32 pci_mmcfg_base_addr;
+
+/* The virtual address of the fixed PTE */
+static unsigned long mmcfg_virt_addr;
+
+/* The base address of the last MMCONFIG device accessed */
+static u32 mmcfg_last_accessed_device;
+
+/*
+ * Functions for accessing PCI configuration space with MMCONFIG accesses
+ */
+
+static inline void pci_exp_set_dev_base(int bus, int devfn)
+{
+	u32 dev_base = pci_mmcfg_base_addr | (bus << 20) | (devfn << 12);
+	if (dev_base != mmcfg_last_accessed_device) {
+		mmcfg_last_accessed_device = dev_base;
+		set_fixmap(FIX_PCIE_MCFG, dev_base);
+	}
+}
+
+static int pci_mmcfg_read(int seg, int bus, int devfn, int reg, int len, u32 *value)
+{
+	unsigned long flags;
+
+	if (!value || (bus > 255) || (devfn > 255) || (reg > 4095))
+		return -EINVAL;
+
+	spin_lock_irqsave(&pci_config_lock, flags);
+
+	pci_exp_set_dev_base(bus, devfn);
+
+	switch (len) {
+	case 1:
+		*value = readb(mmcfg_virt_addr + reg);
+		break;
+	case 2:
+		*value = readw(mmcfg_virt_addr + reg);
+		break;
+	case 4:
+		*value = readl(mmcfg_virt_addr + reg);
+		break;
+	}
+
+	spin_unlock_irqrestore(&pci_config_lock, flags);
+
+	return 0;
+}
+
+static int pci_mmcfg_write(int seg, int bus, int devfn, int reg, int len, u32 value)
+{
+	unsigned long flags;
+
+	if ((bus > 255) || (devfn > 255) || (reg > 4095)) 
+		return -EINVAL;
+
+	spin_lock_irqsave(&pci_config_lock, flags);
+
+	pci_exp_set_dev_base(bus, devfn);
+
+	switch (len) {
+	case 1:
+		writeb(value, mmcfg_virt_addr + reg);
+		break;
+	case 2:
+		writew(value, mmcfg_virt_addr + reg);
+		break;
+	case 4:
+		writel(value, mmcfg_virt_addr + reg);
+		break;
+	}
+
+	/* Dummy read to flush PCI write */
+	readl(mmcfg_virt_addr);
+
+	spin_unlock_irqrestore(&pci_config_lock, flags);
+
+	return 0;
+}
+
+static struct pci_raw_ops pci_mmcfg = {
+	.read =		pci_mmcfg_read,
+	.write =	pci_mmcfg_write,
+};
+
+static int __init pci_mmcfg_init(void)
+{
+	struct resource *region;
+
+	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
+		goto out;
+	if (!pci_mmcfg_base_addr)
+		goto out;
+	region = request_mem_region(pci_mmcfg_base_addr, 256 * 1024 * 1024,
+			"PCI MMCONFIG");
+	if (!region)
+		goto out;
+
+	/* Calculate the virtual address of the PTE */
+	mmcfg_virt_addr = fix_to_virt(FIX_PCIE_MCFG);
+
+	printk(KERN_INFO "PCI: Using MMCONFIG\n");
+	raw_pci_ops = &pci_mmcfg;
+	pci_probe = (pci_probe & ~PCI_PROBE_MASK) | PCI_PROBE_MMCONF;
+
+ out:
+	return 0;
+}
+
+arch_initcall(pci_mmcfg_init);
diff -urpNX build-tools/dontdiff linus-2.6/arch/i386/pci/pci.h pciexp-2.6/arch/i386/pci/pci.h
--- linus-2.6/arch/i386/pci/pci.h	2003-07-29 13:00:27.000000000 -0400
+++ pciexp-2.6/arch/i386/pci/pci.h	2004-01-29 08:14:48.000000000 -0500
@@ -15,6 +15,9 @@
 #define PCI_PROBE_BIOS		0x0001
 #define PCI_PROBE_CONF1		0x0002
 #define PCI_PROBE_CONF2		0x0004
+#define PCI_PROBE_MMCONF	0x0008
+#define PCI_PROBE_MASK		0x000f
+
 #define PCI_NO_SORT		0x0100
 #define PCI_BIOS_SORT		0x0200
 #define PCI_NO_CHECKS		0x0400
diff -urpNX build-tools/dontdiff linus-2.6/drivers/acpi/tables.c pciexp-2.6/drivers/acpi/tables.c
--- linus-2.6/drivers/acpi/tables.c	2003-10-08 16:52:16.000000000 -0400
+++ pciexp-2.6/drivers/acpi/tables.c	2004-01-29 08:22:52.000000000 -0500
@@ -58,6 +58,7 @@ static char *acpi_table_signatures[ACPI_
 	[ACPI_SSDT]		= "SSDT",
 	[ACPI_SPMI]		= "SPMI",
 	[ACPI_HPET]		= "HPET",
+	[ACPI_MCFG]		= "MCFG",
 };
 
 /* System Description Table (RSDT/XSDT) */
diff -urpNX build-tools/dontdiff linus-2.6/drivers/pci/pci-sysfs.c pciexp-2.6/drivers/pci/pci-sysfs.c
--- linus-2.6/drivers/pci/pci-sysfs.c	2003-08-22 22:46:57.000000000 -0400
+++ pciexp-2.6/drivers/pci/pci-sysfs.c	2004-01-29 09:30:43.000000000 -0500
@@ -71,7 +71,7 @@ pci_read_config(struct kobject *kobj, ch
 
 	/* Several chips lock up trying to read undefined config space */
 	if (capable(CAP_SYS_ADMIN)) {
-		size = 256;
+		size = dev->cfg_size;
 	} else if (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS) {
 		size = 128;
 	}
@@ -123,10 +123,10 @@ pci_write_config(struct kobject *kobj, c
 	unsigned int size = count;
 	loff_t init_off = off;
 
-	if (off > 256)
+	if (off > dev->cfg_size)
 		return 0;
-	if (off + count > 256) {
-		size = 256 - off;
+	if (off + count > dev->cfg_size) {
+		size = dev->cfg_size - off;
 		count = size;
 	}
 
@@ -166,6 +166,16 @@ static struct bin_attribute pci_config_a
 	.write = pci_write_config,
 };
 
+static struct bin_attribute pcie_config_attr = {
+	.attr =	{
+		.name = "config",
+		.mode = S_IRUGO | S_IWUSR,
+	},
+	.size = 4096,
+	.read = pci_read_config,
+	.write = pci_write_config,
+};
+
 void pci_create_sysfs_dev_files (struct pci_dev *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -178,5 +188,9 @@ void pci_create_sysfs_dev_files (struct 
 	device_create_file (dev, &dev_attr_class);
 	device_create_file (dev, &dev_attr_irq);
 	device_create_file (dev, &dev_attr_resource);
-	sysfs_create_bin_file(&dev->kobj, &pci_config_attr);
+	if (pdev->cfg_size < 4096) {
+		sysfs_create_bin_file(&dev->kobj, &pci_config_attr);
+	} else {
+		sysfs_create_bin_file(&dev->kobj, &pcie_config_attr);
+	}
 }
diff -urpNX build-tools/dontdiff linus-2.6/drivers/pci/pci.c pciexp-2.6/drivers/pci/pci.c
--- linus-2.6/drivers/pci/pci.c	2003-10-08 16:52:35.000000000 -0400
+++ pciexp-2.6/drivers/pci/pci.c	2004-01-29 08:23:57.000000000 -0500
@@ -90,6 +90,8 @@ pci_max_busnr(void)
  *  %PCI_CAP_ID_CHSWP        CompactPCI HotSwap 
  *
  *  %PCI_CAP_ID_PCIX         PCI-X
+ *
+ *  %PCI_CAP_ID_EXP          PCI Express
  */
 int
 pci_find_capability(struct pci_dev *dev, int cap)
diff -urpNX build-tools/dontdiff linus-2.6/drivers/pci/probe.c pciexp-2.6/drivers/pci/probe.c
--- linus-2.6/drivers/pci/probe.c	2004-01-07 18:02:53.000000000 -0500
+++ pciexp-2.6/drivers/pci/probe.c	2004-01-29 08:59:46.000000000 -0500
@@ -17,6 +17,8 @@
 
 #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
 #define CARDBUS_RESERVE_BUSNR	3
+#define PCI_CFG_SPACE_SIZE	256
+#define PCI_CFG_SPACE_EXP_SIZE	4096
 
 /* Ugh.  Need to stop exporting this to modules. */
 LIST_HEAD(pci_root_buses);
@@ -479,6 +481,20 @@ static void pci_release_dev(struct devic
 	kfree(pci_dev);
 }
 
+/**
+ * pci_cfg_space_size - get the configuration space size of the PCI device
+ */
+static int pci_cfg_space_size(struct pci_dev *dev)
+{
+#ifdef CONFIG_PCI_MMCONFIG
+	/* Find whether the device is PCI Express */
+	int is_pci_express_dev = pci_find_capability(dev, PCI_CAP_ID_EXP);
+	if (is_pci_express_dev)
+		return PCI_CFG_SPACE_EXP_SIZE;
+#endif
+	return PCI_CFG_SPACE_SIZE;
+}
+
 /*
  * Read the config data for a PCI device, sanity-check it
  * and fill in the dev structure...
@@ -515,6 +531,7 @@ pci_scan_device(struct pci_bus *bus, int
 	dev->multifunction = !!(hdr_type & 0x80);
 	dev->vendor = l & 0xffff;
 	dev->device = (l >> 16) & 0xffff;
+	dev->cfg_size = pci_cfg_space_size(dev);
 
 	/* Assume 32-bit PCI; let 64-bit PCI cards (which are far rarer)
 	   set this higher, assuming the system even supports it.  */
diff -urpNX build-tools/dontdiff linus-2.6/drivers/pci/proc.c pciexp-2.6/drivers/pci/proc.c
--- linus-2.6/drivers/pci/proc.c	2004-01-07 18:02:53.000000000 -0500
+++ pciexp-2.6/drivers/pci/proc.c	2004-01-29 08:38:49.000000000 -0500
@@ -16,16 +16,15 @@
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
 
-#define PCI_CFG_SPACE_SIZE 256
-
 static int proc_initialized;	/* = 0 */
 
 static loff_t
 proc_bus_pci_lseek(struct file *file, loff_t off, int whence)
 {
 	loff_t new = -1;
+	struct inode *inode = file->f_dentry->d_inode;
 
-	down(&file->f_dentry->d_inode->i_sem);
+	down(&inode->i_sem);
 	switch (whence) {
 	case 0:
 		new = off;
@@ -34,14 +33,14 @@ proc_bus_pci_lseek(struct file *file, lo
 		new = file->f_pos + off;
 		break;
 	case 2:
-		new = PCI_CFG_SPACE_SIZE + off;
+		new = inode->i_size + off;
 		break;
 	}
-	if (new < 0 || new > PCI_CFG_SPACE_SIZE)
+	if (new < 0 || new > inode->i_size)
 		new = -EINVAL;
 	else
 		file->f_pos = new;
-	up(&file->f_dentry->d_inode->i_sem);
+	up(&inode->i_sem);
 	return new;
 }
 
@@ -61,7 +60,7 @@ proc_bus_pci_read(struct file *file, cha
 	 */
 
 	if (capable(CAP_SYS_ADMIN))
-		size = PCI_CFG_SPACE_SIZE;
+		size = dev->cfg_size;
 	else if (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
 		size = 128;
 	else
@@ -134,14 +133,15 @@ proc_bus_pci_write(struct file *file, co
 	const struct proc_dir_entry *dp = PDE(ino);
 	struct pci_dev *dev = dp->data;
 	int pos = *ppos;
+	int size = dev->cfg_size;
 	int cnt;
 
-	if (pos >= PCI_CFG_SPACE_SIZE)
+	if (pos >= size)
 		return 0;
-	if (nbytes >= PCI_CFG_SPACE_SIZE)
-		nbytes = PCI_CFG_SPACE_SIZE;
-	if (pos + nbytes > PCI_CFG_SPACE_SIZE)
-		nbytes = PCI_CFG_SPACE_SIZE - pos;
+	if (nbytes >= size)
+		nbytes = size;
+	if (pos + nbytes > size)
+		nbytes = size - pos;
 	cnt = nbytes;
 
 	if (!access_ok(VERIFY_READ, buf, cnt))
@@ -403,7 +403,7 @@ int pci_proc_attach_device(struct pci_de
 		return -ENOMEM;
 	e->proc_fops = &proc_bus_pci_operations;
 	e->data = dev;
-	e->size = PCI_CFG_SPACE_SIZE;
+	e->size = dev->cfg_size;
 
 	return 0;
 }
diff -urpNX build-tools/dontdiff linus-2.6/include/asm-i386/fixmap.h pciexp-2.6/include/asm-i386/fixmap.h
--- linus-2.6/include/asm-i386/fixmap.h	2003-07-29 13:01:54.000000000 -0400
+++ pciexp-2.6/include/asm-i386/fixmap.h	2004-01-29 08:40:21.000000000 -0500
@@ -71,6 +71,9 @@ enum fixed_addresses {
 	FIX_ACPI_BEGIN,
 	FIX_ACPI_END = FIX_ACPI_BEGIN + FIX_ACPI_PAGES - 1,
 #endif
+#ifdef CONFIG_PCI_MMCONFIG
+	FIX_PCIE_MCFG,
+#endif
 	__end_of_permanent_fixed_addresses,
 	/* temporary boot-time mappings, used before ioremap() is functional */
 #define NR_FIX_BTMAPS	16
diff -urpNX build-tools/dontdiff linus-2.6/include/linux/acpi.h pciexp-2.6/include/linux/acpi.h
--- linus-2.6/include/linux/acpi.h	2003-10-08 16:53:03.000000000 -0400
+++ pciexp-2.6/include/linux/acpi.h	2004-01-29 08:46:48.000000000 -0500
@@ -317,6 +317,15 @@ struct acpi_table_ecdt {
 	char				ec_id[0];
 } __attribute__ ((packed));
 
+/* PCI MMCONFIG */
+
+struct acpi_table_mcfg {
+	struct acpi_table_header	header;
+	u8				reserved[8];
+	u32				base_address;
+	u32				base_reserved;
+} __attribute__ ((packed));
+
 /* Table Handlers */
 
 enum acpi_table_id {
@@ -338,6 +347,7 @@ enum acpi_table_id {
 	ACPI_SSDT,
 	ACPI_SPMI,
 	ACPI_HPET,
+	ACPI_MCFG,
 	ACPI_TABLE_COUNT
 };
 
@@ -369,6 +379,8 @@ void acpi_numa_arch_fixup(void);
 
 extern int acpi_mp_config;
 
+extern u32 pci_mmcfg_base_addr;
+
 #else	/*!CONFIG_ACPI_BOOT*/
 
 #define acpi_mp_config	0
diff -urpNX build-tools/dontdiff linus-2.6/include/linux/pci.h pciexp-2.6/include/linux/pci.h
--- linus-2.6/include/linux/pci.h	2004-01-27 21:05:48.000000000 -0500
+++ pciexp-2.6/include/linux/pci.h	2004-01-29 09:13:20.000000000 -0500
@@ -410,6 +410,8 @@ struct pci_dev {
 	unsigned short vendor_compatible[DEVICE_COUNT_COMPATIBLE];
 	unsigned short device_compatible[DEVICE_COUNT_COMPATIBLE];
 
+	int		cfg_size;	/* Size of configuration space */
+
 	/*
 	 * Instead of touching interrupt line and base address registers
 	 * directly, use the values stored here. They might be different!

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
