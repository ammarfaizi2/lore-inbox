Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266213AbUAVKXe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 05:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266214AbUAVKXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 05:23:15 -0500
Received: from petasus.png.intel.com ([192.198.147.99]:24482 "EHLO
	petasus.png.intel.com") by vger.kernel.org with ESMTP
	id S266212AbUAVKWc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 05:22:32 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [patch] PCI Express Enhanced Config Patch - 2.6.0-test11
Date: Thu, 22 Jan 2004 15:51:22 +0530
Message-ID: <6B09584CC3D2124DB45C3B592414FA83011A3357@bgsmsx402.gar.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] PCI Express Enhanced Config Patch - 2.6.0-test11
Thread-Index: AcPVRIUoK/6PdYOKQ1+WoqFcIVUGTwLh+8mg
From: "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>
To: <linux-kernel@vger.kernel.org>, <linux-pci@atrey.karlin.mff.cuni.cz>
Cc: <torvalds@osdl.org>, <alan@lxorguk.ukuu.org.uk>, <greg@kroah.com>,
       "Andi Kleen" <ak@colin2.muc.de>,
       "Kondratiev, Vladimir" <vladimir.kondratiev@intel.com>,
       "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>,
       "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>
X-OriginalArrivalTime: 22 Jan 2004 10:21:24.0444 (UTC) FILETIME=[7CE169C0:01C3E0D1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All, 

I am reposting the updated patch after incorporating the review
comments.

This is the patch on PCI Express Enhanced configuration for 2.6.0 test11
kernel following up to the Vladimir (Vladimir.Kondratiev@intel.com) and
Harinarayanan (Harinarayanan.Seshadri@intel.com)  and my previous
patches .
I tested it on our i386 platform. 

This patch also implements a mechanism for the kernel to find the
chipset specific mmcfg base address. The kernel will detect the base
address of the chipset through the ACPI table entry and based on that
the PCI subsystem will be initialized.  

Please review this and send in your comments.

Thanks,
Sundar

diff -Naur linux-2.6.0/arch/i386/Kconfig
linux_pciexpress/arch/i386/Kconfig
--- linux-2.6.0/arch/i386/Kconfig	2003-12-18 08:28:16.000000000
+0530
+++ linux_pciexpress/arch/i386/Kconfig	2004-01-12 14:28:38.000000000
+0530
@@ -959,7 +959,7 @@
 endmenu
 
 
-menu "Bus options (PCI, PCMCIA, EISA, MCA, ISA)"
+menu "Bus options (PCI, PCMCIA, EISA, MCA, ISA, PCI_EXPRESS)"
 
 config X86_VISWS_APIC
 	bool
@@ -976,6 +976,18 @@
 	depends on SMP && !(X86_VISWS || X86_VOYAGER)
 	default y
 
+config PCI_EXPRESS
+	bool "PCI_EXPRESS (EXPERIMENTAL)" 
+	depends on EXPERIMENTAL && ACPI_BOOT
+	help
+	  PCI Express extends the configuration space from 256 bytes to
+	  4k bytes. It also defines an enhanced configuration mechanism
+	  to acces the extended configuration space.
+	  With this option, you can specify that Linux will first
attempt
+	  to access the pci configuration space through enhanced config
+	  access mechanism (Will work only on PCI Express based system)
+	  otherwise the pci direct mechanism will be used.
+
 config PCI
 	bool "PCI support" if !X86_VISWS
 	depends on !X86_VOYAGER
diff -Naur linux-2.6.0/arch/i386/kernel/acpi/boot.c
linux_pciexpress/arch/i386/kernel/acpi/boot.c
--- linux-2.6.0/arch/i386/kernel/acpi/boot.c	2003-12-18
08:29:29.000000000 +0530
+++ linux_pciexpress/arch/i386/kernel/acpi/boot.c	2004-01-12
14:14:22.000000000 +0530
@@ -93,6 +93,29 @@
 	return ((unsigned char *) base + offset);
 }
 
+#ifdef CONFIG_PCI_EXPRESS
+extern u32 mmcfg_base_address;
+static int __init acpi_parse_mcfg
+			 (unsigned long phys_addr, unsigned long size)
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
+		mmcfg_base_address = (u32)mcfg->base_address;
+	printk(KERN_INFO PREFIX "Local  mcfg address %p\n",
+			mcfg->base_address);
+	return 0;
+}
+#endif /* CONFIG_PCI_EXPRESS*/
 
 #ifdef CONFIG_X86_LOCAL_APIC
 
@@ -508,6 +531,22 @@
 
 #endif /* CONFIG_X86_IO_APIC && CONFIG_ACPI_INTERPRETER */
 
+#ifdef CONFIG_PCI_EXPRESS
+	result = acpi_table_parse(ACPI_MCFG, acpi_parse_mcfg);
+	if (!result) {
+		printk(KERN_WARNING PREFIX "MCFG not present\n");
+		return 0;
+	}
+	else if (result < 0) {
+		printk(KERN_ERR PREFIX "Error parsing MCFG\n");
+		return result;
+	}
+	else if (result > 1) {
+		printk(KERN_WARNING PREFIX \
+			"Multiple MCFG tables exist\n");
+	}
+#endif /*CONFIG_PCI_EXPRESS*/
+
 #ifdef CONFIG_X86_LOCAL_APIC
 	if (acpi_lapic && acpi_ioapic) {
 		smp_found_config = 1;
diff -Naur linux-2.6.0/arch/i386/pci/common.c
linux_pciexpress/arch/i386/pci/common.c
--- linux-2.6.0/arch/i386/pci/common.c	2003-12-18 08:28:46.000000000
+0530
+++ linux_pciexpress/arch/i386/pci/common.c	2004-01-22
11:54:42.000000000 +0530
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
+	else if (!strcmp(str, "no_pcie")) {
+		pci_probe &= !PCI_PROBE_ENHANCED;
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
+++ linux_pciexpress/arch/i386/pci/direct.c	2004-01-22
12:07:37.000000000 +0530
@@ -168,6 +168,71 @@
 
 
 /*
+ *We map full Page size on each request. Incidently that's the size we
+ *have for config space too.
+ */
+#ifdef CONFIG_PCI_EXPRESS
+/* 
+ *On PCI Express capable platform, at the time of kernel initialization
+ *the os would have scanned for mcfg table and set this variable to 
+ *appropriate value. If PCI Express not supported the variable will 
+ * have 0 value
+ */
+u32 mmcfg_base_address;
+
+/*
+ *Variable used to store the virtual  address of fixed PTE
+ */
+char * mmcfg_virt_addr;
+
+static int pci_express_conf_read(int seg, int bus,
+		int devfn, int reg, int len, u32 *value)
+{
+	if (!value || ((u32)bus > 255) || ((u32)devfn > 255) 
+		|| ((u32)reg > 4095)){
+		printk(KERN_ERR "pci_express_conf_read: \
+					Invalid Parameter\n");
+  		return -EINVAL;
+	}
+
+	/* Shoot misalligned transaction now */
+	if (reg & (len-1)){
+		printk(KERN_ERR "pci_express_conf_read: \
+					misalligned transaction\n");
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
+	if (((u32)bus > 255) || ((u32)devfn > 255) 
+		|| ((u32)reg > 4095)){
+		printk(KERN_ERR "pci_express_conf_write: \
+					Invalid Parameter\n");
+		return -EINVAL;
+	}
+
+	/* Shoot misalligned transaction now */
+	if (reg & (len-1)){
+		printk(KERN_ERR "pci_express_conf_write: \
+					misalligned transaction\n");
+  		return -EINVAL;
+	}
+	pci_express_write(bus, devfn, reg, len, value);
+	return 0;
+}
+
+static struct pci_raw_ops pci_express_conf = {
+	.read   =	pci_express_conf_read,
+	.write  =	pci_express_conf_write,
+};
+#endif /* CONFIG_PCI_EXPRESS */
+
+/*
  * Before we decide to use direct hardware access mechanisms, we try to
do some
  * trivial checks to ensure it at least _seems_ to be working -- we
just test
  * whether bus 00 contains a host bridge (this is similar to checking
@@ -244,7 +309,31 @@
 static int __init pci_direct_init(void)
 {
 	struct resource *region, *region2;
+	
+#ifdef CONFIG_PCI_EXPRESS
+	if ((pci_probe & PCI_PROBE_ENHANCED) == 0)
+		goto type1;
+	/*
+ 	 *Check if platform we are running is pci express capable
+  	 */
+	if (mmcfg_base_address == 0){
+		printk(KERN_INFO 
+		      "MCFG table entry is not found in ACPI
tables....\n \
+		       PCI Express not supported in this platform....\n
\
+		       Not enabling Enhanced Configuration....\n");
+		goto type1;
+	}
 
+	/* Calculate the virtual address of the PTE */
+	mmcfg_virt_addr = (char *) (fix_to_virt(FIX_PCIE_MCFG));
+
+	if (pci_sanity_check(&pci_express_conf)) {
+		printk(KERN_INFO "PCI:Using config type PCIExp\n");
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
+++ linux_pciexpress/arch/i386/pci/Makefile	2004-01-12
13:38:55.000000000 +0530
@@ -2,6 +2,7 @@
 
 obj-$(CONFIG_PCI_BIOS)		+= pcbios.o
 obj-$(CONFIG_PCI_DIRECT)	+= direct.o
+obj-$(CONFIG_PCI_EXPRES)	+= direct.o
 
 pci-y				:= fixup.o
 pci-$(CONFIG_ACPI_PCI)		+= acpi.o
diff -Naur linux-2.6.0/arch/i386/pci/pci.h
linux_pciexpress/arch/i386/pci/pci.h
--- linux-2.6.0/arch/i386/pci/pci.h	2003-12-18 08:28:57.000000000
+0530
+++ linux_pciexpress/arch/i386/pci/pci.h	2004-01-12
13:38:55.000000000 +0530
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
+++ linux_pciexpress/drivers/acpi/tables.c	2004-01-12
13:38:20.000000000 +0530
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
+++ linux_pciexpress/drivers/pci/pci.c	2004-01-12 13:38:06.000000000
+0530
@@ -90,6 +90,8 @@
  *  %PCI_CAP_ID_CHSWP        CompactPCI HotSwap 
  *
  *  %PCI_CAP_ID_PCIX         PCI-X
+ *  %PCI_CAP_ID_EXP          PCI-EXP
+
  */
 int
 pci_find_capability(struct pci_dev *dev, int cap)
diff -Naur linux-2.6.0/drivers/pci/proc.c
linux_pciexpress/drivers/pci/proc.c
--- linux-2.6.0/drivers/pci/proc.c	2003-12-18 08:28:57.000000000
+0530
+++ linux_pciexpress/drivers/pci/proc.c	2004-01-12 14:36:27.000000000
+0530
@@ -17,13 +17,30 @@
 #include <asm/byteorder.h>
 
 #define PCI_CFG_SPACE_SIZE 256
+#define PCI_CFG_SPACE_EXP_SIZE 4096
 
 static int proc_initialized;	/* = 0 */
 
+static int pci_cfg_space_size (struct pci_dev *dev)
+{
+#ifdef CONFIG_PCI_EXPRESS
+	/* Find whether the device is PCI Express device */
+	int is_pci_express_dev = 
+		pci_find_capability(dev, PCI_CAP_ID_EXP);
+	if (is_pci_express_dev)
+		return PCI_CFG_SPACE_EXP_SIZE;
+	else
+#endif
+	return PCI_CFG_SPACE_SIZE; 
+}
+
 static loff_t
 proc_bus_pci_lseek(struct file *file, loff_t off, int whence)
 {
 	loff_t new = -1;
+	const struct inode *ino = file->f_dentry->d_inode;
+	const struct proc_dir_entry *dp = PDE(ino);
+	struct pci_dev *dev = dp->data;
 
 	lock_kernel();
 	switch (whence) {
@@ -34,11 +51,11 @@
 		new = file->f_pos + off;
 		break;
 	case 2:
-		new = PCI_CFG_SPACE_SIZE + off;
+		new = pci_cfg_space_size(dev) + off;
 		break;
 	}
 	unlock_kernel();
-	if (new < 0 || new > PCI_CFG_SPACE_SIZE)
+	if (new < 0 || new > pci_cfg_space_size(dev))
 		return -EINVAL;
 	return (file->f_pos = new);
 }
@@ -59,7 +76,7 @@
 	 */
 
 	if (capable(CAP_SYS_ADMIN))
-		size = PCI_CFG_SPACE_SIZE;
+ 		size = pci_cfg_space_size (dev);
 	else if (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
 		size = 128;
 	else
@@ -134,12 +151,14 @@
 	int pos = *ppos;
 	int cnt;
 
-	if (pos >= PCI_CFG_SPACE_SIZE)
+	int size;
+	size = pci_cfg_space_size(dev);
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
@@ -384,6 +403,7 @@
 	struct pci_bus *bus = dev->bus;
 	struct proc_dir_entry *de, *e;
 	char name[16];
+	int size;
 
 	if (!proc_initialized)
 		return -EACCES;
@@ -401,7 +421,8 @@
 		return -ENOMEM;
 	e->proc_fops = &proc_bus_pci_operations;
 	e->data = dev;
-	e->size = PCI_CFG_SPACE_SIZE;
+	size = pci_cfg_space_size(dev);
+	e->size = size;
 
 	return 0;
 }
diff -Naur linux-2.6.0/include/asm-i386/fixmap.h
linux_pciexpress/include/asm-i386/fixmap.h
--- linux-2.6.0/include/asm-i386/fixmap.h	2003-12-18
08:28:06.000000000 +0530
+++ linux_pciexpress/include/asm-i386/fixmap.h	2004-01-12
13:40:19.000000000 +0530
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
+++ linux_pciexpress/include/asm-i386/pci.h	2004-01-12
14:39:42.000000000 +0530
@@ -96,4 +96,68 @@
 /* generic pci stuff */
 #include <asm-generic/pci.h>
 
+#ifdef CONFIG_PCI_EXPRESS
+/*
+ *Variable used to store the base address of the last pciexpress device
+ *accessed.
+ */
+static u32 pcie_last_accessed_device;
+
+extern u32 mmcfg_base_address;
+extern spinlock_t pci_config_lock;
+extern char * mmcfg_virt_addr;
+
+static __inline__ void pci_exp_set_dev_base (int bus, int devfn)
+{
+	u32 dev_base = 
+		mmcfg_base_address | (bus << 20) | (devfn << 12);
+	if (dev_base != pcie_last_accessed_device){
+		pcie_last_accessed_device = dev_base;
+		set_fixmap (FIX_PCIE_MCFG, dev_base);
+	}
+}
+
+static __inline__ void pci_express_read(int bus, int devfn, int reg, 
+		int len, u32 *value)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&pci_config_lock, flags);
+	pci_exp_set_dev_base(bus, devfn);
+ 	switch (len) {
+        case 1:
+		*value = (u8)readb((unsigned long) mmcfg_virt_addr +
reg);
+		break;
+        case 2:
+		*value = (u16)readw((unsigned long) mmcfg_virt_addr +
reg);
+		break;
+        case 4:
+		*value = (u32)readl((unsigned long) mmcfg_virt_addr +
reg);
+		break;
+	}
+	spin_unlock_irqrestore(&pci_config_lock, flags);
+}
+
+static __inline__ void pci_express_write(int bus, int devfn, int reg, 
+	int len, u32 value)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&pci_config_lock, flags);
+	pci_exp_set_dev_base(bus, devfn);
+	switch (len) {
+		case 1:
+			writeb(value,(unsigned long)mmcfg_virt_addr +
reg);
+			break;
+		case 2:
+			writew(value,(unsigned long)mmcfg_virt_addr +
reg);
+			break;
+	        case 4:
+			writel(value,(unsigned long)mmcfg_virt_addr +
reg);
+	                break;
+     	}
+	/* Dummy read to flush PCI write */
+	readl (mmcfg_virt_addr);
+	spin_unlock_irqrestore(&pci_config_lock, flags);
+}
+#endif /* CONFIG_PCI_EXPRESS */
 #endif /* __i386_PCI_H */
diff -Naur linux-2.6.0/include/linux/acpi.h
linux_pciexpress/include/linux/acpi.h
--- linux-2.6.0/include/linux/acpi.h	2003-12-18 08:27:58.000000000
+0530
+++ linux_pciexpress/include/linux/acpi.h	2004-01-12
14:43:23.000000000 +0530
@@ -317,6 +317,12 @@
 	char				ec_id[0];
 } __attribute__ ((packed));
 
+struct acpi_table_mcfg {
+	struct acpi_table_header 	header;
+	u8	reserved[8];
+	u64	base_address;
+} __attribute__ ((packed));
+
 /* Table Handlers */
 
 enum acpi_table_id {
@@ -338,6 +344,7 @@
 	ACPI_SSDT,
 	ACPI_SPMI,
 	ACPI_HPET,
+	ACPI_MCFG,
 	ACPI_TABLE_COUNT
 };
 
diff -Naur linux-2.6.0/include/linux/pci.h
linux_pciexpress/include/linux/pci.h
--- linux-2.6.0/include/linux/pci.h	2003-12-18 08:28:49.000000000
+0530
+++ linux_pciexpress/include/linux/pci.h	2004-01-12
13:40:01.000000000 +0530
@@ -198,6 +198,7 @@
 #define  PCI_CAP_ID_MSI		0x05	/* Message Signalled
Interrupts */
 #define  PCI_CAP_ID_CHSWP	0x06	/* CompactPCI HotSwap */
 #define  PCI_CAP_ID_PCIX	0x07	/* PCI-X */
+#define  PCI_CAP_ID_EXP 	0x10	/* PCI-Express*/
 #define PCI_CAP_LIST_NEXT	1	/* Next capability in the list
*/
 #define PCI_CAP_FLAGS		2	/* Capability defined flags (16
bits) */
 #define PCI_CAP_SIZEOF		4
