Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265859AbUA2Lej (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 06:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265871AbUA2Lej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 06:34:39 -0500
Received: from petasus.png.intel.com ([192.198.147.99]:925 "EHLO
	petasus.png.intel.com") by vger.kernel.org with ESMTP
	id S265859AbUA2LeW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 06:34:22 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [patch] PCI Express Enhanced Config Patch - 2.6.0-test11
Date: Thu, 29 Jan 2004 17:02:39 +0530
Message-ID: <6B09584CC3D2124DB45C3B592414FA830112C34F@bgsmsx402.gar.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] PCI Express Enhanced Config Patch - 2.6.0-test11
Thread-Index: AcPVRIUoK/6PdYOKQ1+WoqFcIVUGTwLh+8mgASzh6RAANrlgsA==
From: "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>
To: <linux-kernel@vger.kernel.org>, <linux-pci@atrey.karlin.mff.cuni.cz>
Cc: <torvalds@osdl.org>, <alan@lxorguk.ukuu.org.uk>, <greg@kroah.com>,
       "Andi Kleen" <ak@colin2.muc.de>, <akpm@osdl.org>, <mj@ucw.cz>,
       "Kondratiev, Vladimir" <vladimir.kondratiev@intel.com>,
       "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>
X-OriginalArrivalTime: 29 Jan 2004 11:32:51.0093 (UTC) FILETIME=[A0D06450:01C3E65B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Thanks for the comments.

Please review this updated patch and send your comments.

Thanks,
Sundar

Note:
This is the patch on PCI Express Enhanced configuration for 2.6.0 test11
kernel following up to the Vladimir (Vladimir.Kondratiev@intel.com) and
Harinarayanan (Harinarayanan.Seshadri@intel.com)  and my previous
patches .
I tested it on our i386 platform. 

This patch also implements a mechanism for the kernel to find the
chipset specific mmcfg base address. The kernel will detect the base
address of the chipset through the ACPI table entry and based on that
the PCI subsystem will be initialized.  

diff -Naur linux-2.6.0/arch/i386/Kconfig
linux_pciexpress/arch/i386/Kconfig
--- linux-2.6.0/arch/i386/Kconfig	2003-12-18 08:28:16.000000000
+0530
+++ linux_pciexpress/arch/i386/Kconfig	2004-01-29 16:50:56.000000000
+0530
@@ -1020,6 +1020,18 @@
 
 endchoice
 
+config PCI_EXPRESS
+	bool "PCI_EXPRESS (EXPERIMENTAL)" 
+	depends on EXPERIMENTAL && PCI
+	select ACPI_BOOT
+	help
+	  PCI Express is the next generation PCI architecture that
supports
+	  the configuration space size of 4K bytes. With this option, 
+	  Linux will first attempt to access the configuration space
through 
+	  enhanced config access mechanism (will work only on 
+	  PCI Express based system) otherwise other standard PCI access 
+	  mechanism will be used.
+
 config PCI_BIOS
 	bool
 	depends on !X86_VISWS && PCI && (PCI_GOBIOS || PCI_GOANY)
diff -Naur linux-2.6.0/arch/i386/kernel/acpi/boot.c
linux_pciexpress/arch/i386/kernel/acpi/boot.c
--- linux-2.6.0/arch/i386/kernel/acpi/boot.c	2003-12-18
08:29:29.000000000 +0530
+++ linux_pciexpress/arch/i386/kernel/acpi/boot.c	2004-01-29
16:14:43.000000000 +0530
@@ -93,6 +93,27 @@
 	return ((unsigned char *) base + offset);
 }
 
+#ifdef CONFIG_PCI_EXPRESS
+static int __init acpi_parse_mcfg
+			(unsigned long phys_addr, unsigned long size)
+{
+	struct acpi_table_mcfg	*mcfg = NULL;
+
+	if (!phys_addr || !size)
+		return -EINVAL;
+
+	mcfg = (struct acpi_table_mcfg *) __acpi_map_table
+						(phys_addr, size);
+	if (!mcfg) {
+		printk(KERN_WARNING PREFIX "Unable to map MCFG\n");
+		return -ENODEV;
+	}
+	if (mcfg->base_address)
+		mmcfg_base_address = mcfg->base_address;
+
+	return 0;
+}
+#endif /* CONFIG_PCI_EXPRESS */
 
 #ifdef CONFIG_X86_LOCAL_APIC
 
@@ -508,6 +529,20 @@
 
 #endif /* CONFIG_X86_IO_APIC && CONFIG_ACPI_INTERPRETER */
 
+#ifdef CONFIG_PCI_EXPRESS
+	result = acpi_table_parse(ACPI_MCFG, acpi_parse_mcfg);
+	if (!result) {
+		printk(KERN_WARNING PREFIX "MCFG not present\n");
+		return 0;
+	} else if (result < 0) {
+		printk(KERN_ERR PREFIX "Error parsing MCFG\n");
+		return result;
+	} else if (result > 1) {
+		printk(KERN_WARNING PREFIX
+			"Multiple MCFG tables exist\n");
+	}
+#endif /* CONFIG_PCI_EXPRESS */
+
 #ifdef CONFIG_X86_LOCAL_APIC
 	if (acpi_lapic && acpi_ioapic) {
 		smp_found_config = 1;
diff -Naur linux-2.6.0/arch/i386/pci/common.c
linux_pciexpress/arch/i386/pci/common.c
--- linux-2.6.0/arch/i386/pci/common.c	2003-12-18 08:28:46.000000000
+0530
+++ linux_pciexpress/arch/i386/pci/common.c	2004-01-29
16:14:45.000000000 +0530
@@ -19,7 +19,8 @@
 extern  void pcibios_sort(void);
 #endif
 
-unsigned int pci_probe = PCI_PROBE_BIOS | PCI_PROBE_CONF1 |
PCI_PROBE_CONF2;
+unsigned int pci_probe = PCI_PROBE_BIOS | PCI_PROBE_CONF1 |
PCI_PROBE_CONF2
+				 | PCI_PROBE_ENHANCED;
 
 int pcibios_last_bus = -1;
 struct pci_bus *pci_root_bus = NULL;
@@ -197,6 +198,12 @@
 		return NULL;
 	}
 #endif
+#ifdef CONFIG_PCI_EXPRESS
+	else if (!strcmp(str, "nopciexpress")) {
+		pci_probe &= ~PCI_PROBE_ENHANCED;
+		return NULL;
+	}
+#endif
 #ifdef CONFIG_ACPI_PCI
 	else if (!strcmp(str, "noacpi")) {
 		pci_probe |= PCI_NO_ACPI_ROUTING;
diff -Naur linux-2.6.0/arch/i386/pci/direct.c
linux_pciexpress/arch/i386/pci/direct.c
--- linux-2.6.0/arch/i386/pci/direct.c	2003-12-18 08:28:28.000000000
+0530
+++ linux_pciexpress/arch/i386/pci/direct.c	2004-01-29
16:14:45.000000000 +0530
@@ -167,6 +167,60 @@
 };
 
 
+#ifdef CONFIG_PCI_EXPRESS
+/*
+ * We map full Page size on each PCI Express request. Incidentally
that's 
+ * the size we have for config space too in PCI Express devices.
+ * On PCI Express capable platform, at the time of kernel
initialization
+ * the OS would have scanned for MCFG table and set this variable to 
+ * appropriate value. If PCI Express not supported the variable will 
+ * have 0 value
+ */
+u32 mmcfg_base_address;
+
+/*
+ * Variable used to store the virtual  address of fixed PTE
+ */
+char *mmcfg_virt_addr;
+
+/*
+ * Variable used to store the base address of the last PCI Express
device
+ * accessed.
+ */
+u32 pcie_last_accessed_device;
+
+static int pci_express_conf_read(int seg, int bus,
+		int devfn, int reg, int len, u32 *value)
+{
+	if (!value || (bus > 255) || (devfn > 255) || (reg > 4095)) {
+		printk(KERN_ERR "%s: Invalid Parameter\n",
+				__FUNCTION__);
+  		return -EINVAL;
+	}
+	pci_express_read(bus, devfn, reg, len, value);
+
+	return 0;
+}
+ 
+static int pci_express_conf_write(int seg, int bus, 
+			int devfn, int reg, int len, u32 value)
+{
+	if ((bus > 255) || (devfn > 255) || (reg > 4095)) {
+		printk(KERN_ERR "%s: Invalid Parameter\n",
+				__FUNCTION__);
+		return -EINVAL;
+	}
+	pci_express_write(bus, devfn, reg, len, value);
+
+	return 0;
+}
+
+static struct pci_raw_ops pci_express_conf = {
+	.read   =	pci_express_conf_read,
+	.write  =	pci_express_conf_write,
+};
+#endif /* CONFIG_PCI_EXPRESS */
+
 /*
  * Before we decide to use direct hardware access mechanisms, we try to
do some
  * trivial checks to ensure it at least _seems_ to be working -- we
just test
@@ -244,7 +298,30 @@
 static int __init pci_direct_init(void)
 {
 	struct resource *region, *region2;
+	
+#ifdef CONFIG_PCI_EXPRESS
+	if ((pci_probe & PCI_PROBE_ENHANCED) == 0)
+		goto type1;
+	/*
+ 	 * Check if platform we are running is PCI Express capable
+  	 */
+	if (mmcfg_base_address == 0) {
+		printk(KERN_INFO 
+		      "MCFG table entry is not found in ACPI
tables....\n"
+		      "Not enabling Enhanced Configuration....\n");
+		goto type1;
+	}
 
+	/* Calculate the virtual address of the PTE */
+	mmcfg_virt_addr = (char *)fix_to_virt(FIX_PCIE_MCFG);
+
+	if (pci_sanity_check(&pci_express_conf)) {
+		printk(KERN_INFO "PCI: Using config type PCIExp\n");
+		raw_pci_ops = &pci_express_conf;
+		return 0;
+	}
+type1:
+#endif /* CONFIG_PCI_EXPRESS */
 	if ((pci_probe & PCI_PROBE_CONF1) == 0)
 		goto type2;
 	region = request_region(0xCF8, 8, "PCI conf1");
diff -Naur linux-2.6.0/arch/i386/pci/Makefile
linux_pciexpress/arch/i386/pci/Makefile
--- linux-2.6.0/arch/i386/pci/Makefile	2003-12-18 08:28:57.000000000
+0530
+++ linux_pciexpress/arch/i386/pci/Makefile	2004-01-29
16:14:45.000000000 +0530
@@ -2,6 +2,7 @@
 
 obj-$(CONFIG_PCI_BIOS)		+= pcbios.o
 obj-$(CONFIG_PCI_DIRECT)	+= direct.o
+obj-$(CONFIG_PCI_EXPRESS)	+= direct.o
 
 pci-y				:= fixup.o
 pci-$(CONFIG_ACPI_PCI)		+= acpi.o
diff -Naur linux-2.6.0/arch/i386/pci/pci.h
linux_pciexpress/arch/i386/pci/pci.h
--- linux-2.6.0/arch/i386/pci/pci.h	2003-12-18 08:28:57.000000000
+0530
+++ linux_pciexpress/arch/i386/pci/pci.h	2004-01-29
16:14:45.000000000 +0530
@@ -15,6 +15,11 @@
 #define PCI_PROBE_BIOS		0x0001
 #define PCI_PROBE_CONF1		0x0002
 #define PCI_PROBE_CONF2		0x0004
+#ifdef CONFIG_PCI_EXPRESS
+#define PCI_PROBE_ENHANCED	0x0008
+#else
+#define PCI_PROBE_ENHANCED 	0x0
+#endif
 #define PCI_NO_SORT		0x0100
 #define PCI_BIOS_SORT		0x0200
 #define PCI_NO_CHECKS		0x0400
diff -Naur linux-2.6.0/drivers/acpi/tables.c
linux_pciexpress/drivers/acpi/tables.c
--- linux-2.6.0/drivers/acpi/tables.c	2003-12-18 08:28:46.000000000
+0530
+++ linux_pciexpress/drivers/acpi/tables.c	2004-01-29
16:14:08.000000000 +0530
@@ -58,6 +58,7 @@
 	[ACPI_SSDT]		= "SSDT",
 	[ACPI_SPMI]		= "SPMI",
 	[ACPI_HPET]		= "HPET",
+	[ACPI_MCFG]		= "MCFG",
 };
 
 /* System Description Table (RSDT/XSDT) */
diff -Naur linux-2.6.0/drivers/pci/pci.c
linux_pciexpress/drivers/pci/pci.c
--- linux-2.6.0/drivers/pci/pci.c	2003-12-18 08:28:38.000000000
+0530
+++ linux_pciexpress/drivers/pci/pci.c	2004-01-29 16:13:58.000000000
+0530
@@ -90,6 +90,7 @@
  *  %PCI_CAP_ID_CHSWP        CompactPCI HotSwap 
  *
  *  %PCI_CAP_ID_PCIX         PCI-X
+ *  %PCI_CAP_ID_EXP          PCI-EXP
  */
 int
 pci_find_capability(struct pci_dev *dev, int cap)
diff -Naur linux-2.6.0/drivers/pci/probe.c
linux_pciexpress/drivers/pci/probe.c
--- linux-2.6.0/drivers/pci/probe.c	2003-12-18 08:29:06.000000000
+0530
+++ linux_pciexpress/drivers/pci/probe.c	2004-01-29
16:13:58.000000000 +0530
@@ -17,6 +17,8 @@
 
 #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
 #define CARDBUS_RESERVE_BUSNR	3
+#define PCI_CFG_SPACE_SIZE	256
+#define PCI_CFG_SPACE_EXP_SIZE	4096
 
 /* Ugh.  Need to stop exporting this to modules. */
 LIST_HEAD(pci_root_buses);
@@ -479,6 +481,21 @@
 	kfree(pci_dev);
 }
 
+/* 
+ * pci_cfg_space_size - get the configuration space size of the PCI
device
+ */
+static int pci_cfg_space_size(struct pci_dev *dev)
+{
+#ifdef CONFIG_PCI_EXPRESS
+	/* Find whether the device is PCI Express device */
+	int is_pci_express_dev = 
+		pci_find_capability(dev, PCI_CAP_ID_EXP);
+	if (is_pci_express_dev)
+		return PCI_CFG_SPACE_EXP_SIZE;
+#endif
+	return PCI_CFG_SPACE_SIZE; 
+}
+
 /*
  * Read the config data for a PCI device, sanity-check it
  * and fill in the dev structure...
@@ -515,6 +532,7 @@
 	dev->multifunction = !!(hdr_type & 0x80);
 	dev->vendor = l & 0xffff;
 	dev->device = (l >> 16) & 0xffff;
+	dev->cfg_size = pci_cfg_space_size(dev);
 
 	/* Assume 32-bit PCI; let 64-bit PCI cards (which are far rarer)
 	   set this higher, assuming the system even supports it.  */
diff -Naur linux-2.6.0/drivers/pci/proc.c
linux_pciexpress/drivers/pci/proc.c
--- linux-2.6.0/drivers/pci/proc.c	2003-12-18 08:28:57.000000000
+0530
+++ linux_pciexpress/drivers/pci/proc.c	2004-01-29 16:13:58.000000000
+0530
@@ -16,14 +16,15 @@
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
 
-#define PCI_CFG_SPACE_SIZE 256
-
 static int proc_initialized;	/* = 0 */
 
 static loff_t
 proc_bus_pci_lseek(struct file *file, loff_t off, int whence)
 {
 	loff_t new = -1;
+	const struct inode *ino = file->f_dentry->d_inode;
+	const struct proc_dir_entry *dp = PDE(ino);
+	struct pci_dev *dev = dp->data;
 
 	lock_kernel();
 	switch (whence) {
@@ -34,11 +35,11 @@
 		new = file->f_pos + off;
 		break;
 	case 2:
-		new = PCI_CFG_SPACE_SIZE + off;
+		new = dev->cfg_size + off;
 		break;
 	}
 	unlock_kernel();
-	if (new < 0 || new > PCI_CFG_SPACE_SIZE)
+	if (new < 0 || new > dev->cfg_size)
 		return -EINVAL;
 	return (file->f_pos = new);
 }
@@ -59,7 +60,7 @@
 	 */
 
 	if (capable(CAP_SYS_ADMIN))
-		size = PCI_CFG_SPACE_SIZE;
+ 		size = dev->cfg_size;
 	else if (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
 		size = 128;
 	else
@@ -133,13 +134,14 @@
 	struct pci_dev *dev = dp->data;
 	int pos = *ppos;
 	int cnt;
+	int size = dev->cfg_size;
 
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
@@ -401,7 +403,7 @@
 		return -ENOMEM;
 	e->proc_fops = &proc_bus_pci_operations;
 	e->data = dev;
-	e->size = PCI_CFG_SPACE_SIZE;
+	e->size = dev->cfg_size;
 
 	return 0;
 }
diff -Naur linux-2.6.0/include/asm-i386/fixmap.h
linux_pciexpress/include/asm-i386/fixmap.h
--- linux-2.6.0/include/asm-i386/fixmap.h	2003-12-18
08:28:06.000000000 +0530
+++ linux_pciexpress/include/asm-i386/fixmap.h	2004-01-29
16:15:38.000000000 +0530
@@ -67,6 +67,9 @@
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings
*/
 	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
 #endif
+#ifdef CONFIG_PCI_EXPRESS
+	FIX_PCIE_MCFG,
+#endif
 #ifdef CONFIG_ACPI_BOOT
 	FIX_ACPI_BEGIN,
 	FIX_ACPI_END = FIX_ACPI_BEGIN + FIX_ACPI_PAGES - 1,
diff -Naur linux-2.6.0/include/asm-i386/pci.h
linux_pciexpress/include/asm-i386/pci.h
--- linux-2.6.0/include/asm-i386/pci.h	2003-12-18 08:28:47.000000000
+0530
+++ linux_pciexpress/include/asm-i386/pci.h	2004-01-29
16:15:39.000000000 +0530
@@ -96,4 +96,69 @@
 /* generic pci stuff */
 #include <asm-generic/pci.h>
 
+#ifdef CONFIG_PCI_EXPRESS
+extern spinlock_t pci_config_lock;
+
+/*
+ * Variable used to store the base address of the last PCI Express
device
+ * accessed.
+ */
+extern u32 pcie_last_accessed_device;
+
+/*
+ * Variable used to store the base address of the chipset
+ */
+extern u32 mmcfg_base_address;
+
+/*
+ * Variable used to store the virtual  address of fixed PTE
+ */
+extern char *mmcfg_virt_addr;
+
+static inline void pci_exp_set_dev_base(int bus, int devfn)
+{
+	u32 dev_base = 
+		mmcfg_base_address | (bus << 20) | (devfn << 12);
+	if (dev_base != pcie_last_accessed_device) {
+		pcie_last_accessed_device = dev_base;
+		set_fixmap(FIX_PCIE_MCFG, dev_base);
+	}
+}
+
+static inline void pci_express_read(int bus, int devfn, int reg, 
+		int len, u32 *value)
+{
+	pci_exp_set_dev_base(bus, devfn);
+ 	switch (len) {
+        case 1:
+		*value = (u8)readb(mmcfg_virt_addr + reg);
+		break;
+        case 2:
+		*value = (u16)readw(mmcfg_virt_addr + reg);
+		break;
+        case 4:
+		*value = (u32)readl(mmcfg_virt_addr + reg);
+		break;
+	}
+}
+
+static inline void pci_express_write(int bus, int devfn, int reg, 
+	int len, u32 value)
+{
+	pci_exp_set_dev_base(bus, devfn);
+	switch (len) {
+		case 1:
+			writeb(value, mmcfg_virt_addr + reg);
+			break;
+		case 2:
+			writew(value, mmcfg_virt_addr + reg);
+			break;
+	        case 4:
+			writel(value, mmcfg_virt_addr + reg);
+	                break;
+     	}
+	/* Dummy read to flush PCI write */
+	readl(mmcfg_virt_addr);
+}
+#endif /* CONFIG_PCI_EXPRESS */
 #endif /* __i386_PCI_H */
diff -Naur linux-2.6.0/include/linux/acpi.h
linux_pciexpress/include/linux/acpi.h
--- linux-2.6.0/include/linux/acpi.h	2003-12-18 08:27:58.000000000
+0530
+++ linux_pciexpress/include/linux/acpi.h	2004-01-29
16:15:20.000000000 +0530
@@ -317,6 +317,13 @@
 	char				ec_id[0];
 } __attribute__ ((packed));
 
+struct acpi_table_mcfg {
+	struct acpi_table_header 	header;
+	u8	reserved[8];
+	u32	base_address;
+	u32	base_reserved;
+} __attribute__ ((packed));
+
 /* Table Handlers */
 
 enum acpi_table_id {
@@ -338,6 +345,7 @@
 	ACPI_SSDT,
 	ACPI_SPMI,
 	ACPI_HPET,
+	ACPI_MCFG,
 	ACPI_TABLE_COUNT
 };
 
@@ -437,4 +445,7 @@
 
 #endif /*!CONFIG_ACPI_INTERPRETER*/
 
+#ifdef CONFIG_PCI_EXPRESS
+extern u32 mmcfg_base_address;
+#endif
 #endif /*_LINUX_ACPI_H*/
diff -Naur linux-2.6.0/include/linux/pci.h
linux_pciexpress/include/linux/pci.h
--- linux-2.6.0/include/linux/pci.h	2003-12-18 08:28:49.000000000
+0530
+++ linux_pciexpress/include/linux/pci.h	2004-01-29
16:43:01.000000000 +0530
@@ -198,6 +198,7 @@
 #define  PCI_CAP_ID_MSI		0x05	/* Message Signalled
Interrupts */
 #define  PCI_CAP_ID_CHSWP	0x06	/* CompactPCI HotSwap */
 #define  PCI_CAP_ID_PCIX	0x07	/* PCI-X */
+#define  PCI_CAP_ID_EXP 	0x10	/* PCI-EXPANDED */
 #define PCI_CAP_LIST_NEXT	1	/* Next capability in the list
*/
 #define PCI_CAP_FLAGS		2	/* Capability defined flags (16
bits) */
 #define PCI_CAP_SIZEOF		4
@@ -424,6 +425,7 @@
 #define PCI_NAME_HALF	__stringify(20)	/* less than half to handle slop
*/
 	char		pretty_name[PCI_NAME_SIZE];	/* pretty name
for users to see */
 #endif
+	int cfg_size;
 };
 
 #define pci_dev_g(n) list_entry(n, struct pci_dev, global_list)
