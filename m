Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbTL2LdV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 06:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbTL2LdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 06:33:21 -0500
Received: from petasus.png.intel.com ([192.198.147.99]:46224 "EHLO
	petasus.png.intel.com") by vger.kernel.org with ESMTP
	id S262750AbTL2Lcw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 06:32:52 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: [patch] PCI Express Enhanced Config Patch - 2.6.0-test11
Date: Mon, 29 Dec 2003 17:02:39 +0530
Message-ID: <6B09584CC3D2124DB45C3B592414FA8308C898@bgsmsx402.gar.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] PCI Express Enhanced Config Patch - 2.6.0-test11
Thread-Index: AcPN/2NHTFEr19pgTFWRnnD6EBRW5g==
From: "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>,
       "Kondratiev, Vladimir" <vladimir.kondratiev@intel.com>
X-OriginalArrivalTime: 29 Dec 2003 11:32:48.0252 (UTC) FILETIME=[7C50A3C0:01C3CDFF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This is the patch on PCI Express Enhanced configuration for 2.6.0 test11
kernel following up to the Vladamir (Vladimir.Kondratiev@intel.com) and
HariNarayanan (Harinarayanan.Seshadri@intel.com) patches . I tested it
on our i386 platform. 

This patch also implements a mechanism for the kernel to find the
chipset specific mmcfg base address. The kernel will detect the base
address of the chipset through the ACPI table entry and based on that
the PCI subsystem will be initialized.  

Please review this and send in your comments.

Thanks,
Sundar


diff -Naur linux-2.6_src/arch/i386/Kconfig
linux-2.6_pciexpress/arch/i386/Kconfig
--- linux-2.6_src/arch/i386/Kconfig	2003-12-24 14:41:04.000000000
+0530
+++ linux-2.6_pciexpress/arch/i386/Kconfig	2003-12-24
18:34:29.740617408 +0530
@@ -959,7 +959,7 @@
 endmenu
 
 
-menu "Bus options (PCI, PCMCIA, EISA, MCA, ISA)"
+menu "Bus options (PCI, PCMCIA, EISA, MCA, ISA, PCI_EXPRESS)"
 
 config X86_VISWS_APIC
 	bool
@@ -976,6 +976,18 @@
 	depends on SMP && !(X86_VISWS || X86_VOYAGER)
 	default y
 
+config PCI_EXP_ENHANCED
+	bool "PCI_EXPRESS (EXPERIMENTAL)" 
+	depends on EXPERIMENTAL 
+	help
+	   PCI Express extends the configuration space from 256 bytes to
4k
+	   bytes. It also defines an enhanced configuration mechanism to
acces
+	   the extended configuration space.
+	   With this option, you can specify that Linux will first
attempt to
+	   access the pci configuration space through enhanced config
access
+	   mechanism (Will work only on PCI Express based system)
otherwise the
+	   pci direct mechanism will be used.
+
 config PCI
 	bool "PCI support" if !X86_VISWS
 	depends on !X86_VOYAGER
diff -Naur linux-2.6_src/arch/i386/kernel/acpi/boot.c
linux-2.6_pciexpress/arch/i386/kernel/acpi/boot.c
--- linux-2.6_src/arch/i386/kernel/acpi/boot.c	2003-11-27
17:47:49.000000000 +0530
+++ linux-2.6_pciexpress/arch/i386/kernel/acpi/boot.c	2003-12-24
18:34:26.844057752 +0530
@@ -93,12 +93,33 @@
 	return ((unsigned char *) base + offset);
 }
 
+#ifdef CONFIG_PCI_EXP_ENHANCED
+extern u64 mmcfg_base_address;
+static int __init
+acpi_parse_mcfg (
+	unsigned long		phys_addr,
+	unsigned long		size)
+{
+	struct acpi_table_mcfg	*mcfg = NULL;
 
-#ifdef CONFIG_X86_LOCAL_APIC
-
-static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
+	if (!phys_addr || !size)
+		return -EINVAL;
 
+	mcfg = (struct acpi_table_mcfg *) __acpi_map_table(phys_addr,
size);
+	if (!mcfg) {
+		printk(KERN_WARNING PREFIX "Unable to map MCFG\n");
+		return -ENODEV;
+	}
+	if (mcfg->base_address)
+		mmcfg_base_address =mcfg->base_address;
+	printk(KERN_INFO PREFIX "Local  mcfg address 0x%x\n",
+			mcfg->base_address);
+	return 0;
+}
+#endif /* CONFIG_PCI_EXP_ENHANCED*/
 
+#ifdef CONFIG_X86_LOCAL_APIC
+static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
 static int __init
 acpi_parse_madt (
 	unsigned long		phys_addr,
@@ -508,6 +529,21 @@
 
 #endif /* CONFIG_X86_IO_APIC && CONFIG_ACPI_INTERPRETER */
 
+#ifdef CONFIG_PCI_EXP_ENHANCED
+	result = acpi_table_parse(ACPI_MCFG, acpi_parse_mcfg);
+	if (!result) {
+		printk(KERN_WARNING PREFIX "MCFG not present\n");
+		return 0;
+	}
+	else if (result < 0) {
+		printk(KERN_ERR PREFIX "Error parsing MCFG\n");
+		return result;
+	}
+	else if (result > 1) 
+		printk(KERN_WARNING PREFIX "Multiple MCFG tables
exist\n");
+#endif /*CONFIG_PCI_EXP_ENHANCED*/
+
+
 #ifdef CONFIG_X86_LOCAL_APIC
 	if (acpi_lapic && acpi_ioapic) {
 		smp_found_config = 1;
diff -Naur linux-2.6_src/arch/i386/pci/direct.c
linux-2.6_pciexpress/arch/i386/pci/direct.c
--- linux-2.6_src/arch/i386/pci/direct.c	2003-11-27
17:47:49.000000000 +0530
+++ linux-2.6_pciexpress/arch/i386/pci/direct.c	2003-12-24
18:34:29.432664224 +0530
@@ -168,6 +168,123 @@
 
 
 /*
+	We map full Page size on each request. Incidently that's the
size we
+	have for config space too.
+*/
+#ifdef CONFIG_PCI_EXP_ENHANCED
+u64 mmcfg_base_address;
+
+/* mmcfg base address will be initalised by the os initalisation 
+ * code on PCI Express capable platform 
+ */
+static int is_pci_exp_platform(void )
+{
+/* 
+	At the time of initialisation of  the os would have 
+	scanned for mcfg table and set this variable to appropriate 
+	value If PCI Express not supported the variable 
+	will have 0 value
+*/
+	if (mmcfg_base_address == 0){
+		printk(KERN_INFO "MCFG table entry is not found in ACPI
tables....\n");
+		printk(KERN_INFO " PCI Express not supported in this
platform....\n");
+		printk(KERN_INFO " Not enabling Enhanced
Configuration....\n");
+		return 0;
+	}
+	return 1;
+}
+/*
+ Variable used to store the base address of the last pciexpress device 
+  accessed.
+ */
+u32 pcie_last_accessed_device;
+
+unsigned long pci_exp_set_dev_base (int bus, int dev, int fn)
+{
+	u32 dev_base = 
+		mmcfg_base_address | (bus << 20) | ((PCI_DEVFN (dev,fn))
<<12);
+	if (dev_base != pcie_last_accessed_device){
+		pcie_last_accessed_device = dev_base;
+		set_fixmap (FIX_PCIE_MCFG, dev_base);
+	}
+}
+
+static int pci_express_conf_read(int seg, int bus, int devfn, int reg,
int len, u32 *value)
+{
+	 unsigned long flags;
+	 unsigned long base_address;
+	 char * virt_addr;
+	 int dev = PCI_SLOT (devfn);
+	 int fn  = PCI_FUNC (devfn);
+ 
+  if (!value || ((u32)bus > 255) || ((u32)dev > 31) || ((u32)fn > 7) ||
((u32)reg > 4095))
+  	return -EINVAL;
+
+	/* Shoot misalligned transaction now */
+	if (reg & (len-1))
+  	return -EINVAL;
+
+  spin_lock_irqsave(&pci_config_lock, flags);
+	pci_exp_set_dev_base(bus, dev, fn);
+	virt_addr = (char *) (fix_to_virt(FIX_PCIE_MCFG));
+  switch (len) {
+        case 1:
+       		*value = (u8)readb((unsigned long)
virt_addr+reg);
+                break;
+        case 2:
+       		*value = (u16)readw((unsigned long)
virt_addr+reg);
+                break;
+        case 4:
+       		*value = (u32)readl((unsigned long)
virt_addr+reg);
+                break;
+	}
+  spin_unlock_irqrestore(&pci_config_lock, flags);
+  return 0;
+}
+ 
+static int pci_express_conf_write(int seg, int bus, int devfn, int reg,
int len, u32 value)
+{
+	unsigned long flags;
+	unsigned long base_address;
+	unsigned char * virt_addr;
+	int dev = PCI_SLOT (devfn);
+	int fn  = PCI_FUNC (devfn);
+	
+	if (!value || ((u32)bus > 255) || ((u32)dev > 31) || ((u32)fn >
7) || ((u32)reg > 4095))
+		return -EINVAL;
+	
+	/* Shoot misalligned transaction now */
+	if (reg & (len-1))
+  	return -EINVAL;
+  
+	spin_lock_irqsave(&pci_config_lock, flags);
+	pci_exp_set_dev_base(bus, dev, fn);
+	virt_addr = (char *) (fix_to_virt(FIX_PCIE_MCFG));
+	
+	switch (len) {
+		case 1:
+			writeb(value,(unsigned long)virt_addr+reg);
+			break;
+		case 2:
+			writew(value,(unsigned long)virt_addr+reg);
+       		        break;
+	        case 4:
+			writel(value,(unsigned long)virt_addr+reg);
+	                break;
+     	}
+ 	/* Dummy read to flush PCI write */
+	readl (virt_addr);
+	spin_unlock_irqrestore(&pci_config_lock, flags);	 
+	return 0;
+}
+
+static struct pci_raw_ops pci_express_conf = {
+				.read   =        pci_express_conf_read,
+        .write  =        pci_express_conf_write,
+};
+#endif /* CONFIG_PCI_EXP_ENHANCED */
+
+/*
  * Before we decide to use direct hardware access mechanisms, we try to
do some
  * trivial checks to ensure it at least _seems_ to be working -- we
just test
  * whether bus 00 contains a host bridge (this is similar to checking
@@ -244,6 +361,22 @@
 static int __init pci_direct_init(void)
 {
 	struct resource *region, *region2;
+	unsigned long flags;
+#ifdef CONFIG_PCI_EXP_ENHANCED
+	local_irq_save(flags);
+	/*
+	 *	Check if platform we are running is pci express capable
+	 */
+	 if( is_pci_exp_platform() != 0){
+		if (pci_sanity_check(&pci_express_conf)) {
+			local_irq_restore(flags);
+			printk(KERN_INFO "PCI:Using config type
PCIExp\n");
+			raw_pci_ops = &pci_express_conf;
+			return 0;
+		} 
+	}
+	local_irq_restore(flags);
+#endif /* CONFIG_PCI_EXP_ENHANCED */
 
 	if ((pci_probe & PCI_PROBE_CONF1) == 0)
 		goto type2;
diff -Naur linux-2.6_src/arch/i386/pci/Makefile
linux-2.6_pciexpress/arch/i386/pci/Makefile
--- linux-2.6_src/arch/i386/pci/Makefile	2003-11-27
17:47:49.000000000 +0530
+++ linux-2.6_pciexpress/arch/i386/pci/Makefile	2003-12-24
18:34:29.438663312 +0530
@@ -2,6 +2,7 @@
 
 obj-$(CONFIG_PCI_BIOS)		+= pcbios.o
 obj-$(CONFIG_PCI_DIRECT)	+= direct.o
+obj-$(CONFIG_PCI_EXP_ENHANCED)	+= direct.o
 
 pci-y				:= fixup.o
 pci-$(CONFIG_ACPI_PCI)		+= acpi.o
diff -Naur linux-2.6_src/drivers/acpi/tables.c
linux-2.6_pciexpress/drivers/acpi/tables.c
--- linux-2.6_src/drivers/acpi/tables.c	2003-11-27 17:48:39.000000000
+0530
+++ linux-2.6_pciexpress/drivers/acpi/tables.c	2003-12-24
18:34:38.048354440 +0530
@@ -58,6 +58,9 @@
 	[ACPI_SSDT]		= "SSDT",
 	[ACPI_SPMI]		= "SPMI",
 	[ACPI_HPET]		= "HPET",
+#ifdef CONFIG_PCI_EXP_ENHANCED
+	[ACPI_MCFG]		= "MCFG",
+#endif
 };
 
 /* System Description Table (RSDT/XSDT) */
diff -Naur linux-2.6_src/drivers/pci/pci.c
linux-2.6_pciexpress/drivers/pci/pci.c
--- linux-2.6_src/drivers/pci/pci.c	2003-11-27 17:48:59.000000000
+0530
+++ linux-2.6_pciexpress/drivers/pci/pci.c	2003-12-24
18:34:41.216872752 +0530
@@ -90,6 +90,8 @@
  *  %PCI_CAP_ID_CHSWP        CompactPCI HotSwap 
  *
  *  %PCI_CAP_ID_PCIX         PCI-X
+ *  %PCI_CAP_ID_EXP          PCI-EXP
+
  */
 int
 pci_find_capability(struct pci_dev *dev, int cap)
diff -Naur linux-2.6_src/drivers/pci/proc.c
linux-2.6_pciexpress/drivers/pci/proc.c
--- linux-2.6_src/drivers/pci/proc.c	2003-11-27 17:48:59.000000000
+0530
+++ linux-2.6_pciexpress/drivers/pci/proc.c	2003-12-24
18:34:41.249867736 +0530
@@ -18,11 +18,23 @@
 
 #define PCI_CFG_SPACE_SIZE 256
 
+#ifdef CONFIG_PCI_EXP_ENHANCED
+#define PCI_CFG_SPACE_EXP_SIZE 4096
+#endif
+ 
+
 static int proc_initialized;	/* = 0 */
 
 static loff_t
 proc_bus_pci_lseek(struct file *file, loff_t off, int whence)
 {
+#ifdef CONFIG_PCI_EXP_ENHANCED
+	const struct inode *ino = file->f_dentry->d_inode;
+	const struct proc_dir_entry *dp = PDE(ino);
+	struct pci_dev *dev = dp->data;
+	/* Find whether the device is PCI Express device */
+	int is_pci_express_dev =  pci_find_capability(dev,
PCI_CAP_ID_EXP);
+#endif /*CONFIG_PCI_EXP_ENHANCED*/
 	loff_t new = -1;
 
 	lock_kernel();
@@ -34,12 +46,22 @@
 		new = file->f_pos + off;
 		break;
 	case 2:
+#ifdef CONFIG_PCI_EXP_ENHANCED
+		if (is_pci_express_dev)
+			new = PCI_CFG_SPACE_EXP_SIZE + off;
+		else
+#endif /*CONFIG_PCI_EXP_ENHANCED*/
 		new = PCI_CFG_SPACE_SIZE + off;
 		break;
 	}
 	unlock_kernel();
+#ifdef CONFIG_PCI_EXP_ENHANCED
+	if (is_pci_express_dev && (new < 0 || new >
PCI_CFG_SPACE_EXP_SIZE))
+		return -EINVAL;
+#else
 	if (new < 0 || new > PCI_CFG_SPACE_SIZE)
 		return -EINVAL;
+#endif /*CONFIG_PCI_EXP_ENHANCED */
 	return (file->f_pos = new);
 }
 
@@ -59,7 +81,12 @@
 	 */
 
 	if (capable(CAP_SYS_ADMIN))
-		size = PCI_CFG_SPACE_SIZE;
+#ifdef CONFIG_PCI_EXP_ENHANCED
+		if (pci_find_capability(dev,PCI_CAP_ID_EXP))
+			size = PCI_CFG_SPACE_EXP_SIZE;
+		else
+#endif /*CONFIG_PCI_EXP_ENHANCED */
+ 		size = PCI_CFG_SPACE_SIZE;
 	else if (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
 		size = 128;
 	else
@@ -134,12 +161,21 @@
 	int pos = *ppos;
 	int cnt;
 
-	if (pos >= PCI_CFG_SPACE_SIZE)
+	int size;
+#ifdef CONFIG_PCI_EXP_ENHANCED
+	if (pci_find_capability(dev,PCI_CAP_ID_EXP))
+		size = PCI_CFG_SPACE_EXP_SIZE;
+	else
+#endif /* CONFIG_PCI_EXP_ENHANCED */
+	size = PCI_CFG_SPACE_SIZE;
+
+
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
@@ -384,6 +420,7 @@
 	struct pci_bus *bus = dev->bus;
 	struct proc_dir_entry *de, *e;
 	char name[16];
+	int size;
 
 	if (!proc_initialized)
 		return -EACCES;
@@ -401,7 +438,14 @@
 		return -ENOMEM;
 	e->proc_fops = &proc_bus_pci_operations;
 	e->data = dev;
-	e->size = PCI_CFG_SPACE_SIZE;
+
+#ifdef CONFIG_PCI_EXP_ENHANCED
+	if (pci_find_capability(dev,PCI_CAP_ID_EXP))
+		size = PCI_CFG_SPACE_EXP_SIZE;
+	else
+#endif /*CONFIG_PCI_EXP_ENHANCED */
+	size = PCI_CFG_SPACE_SIZE;
+	e->size = size;
 
 	return 0;
 }
diff -Naur linux-2.6_src/include/asm-i386/fixmap.h
linux-2.6_pciexpress/include/asm-i386/fixmap.h
--- linux-2.6_src/include/asm-i386/fixmap.h	2003-11-27
17:47:00.000000000 +0530
+++ linux-2.6_pciexpress/include/asm-i386/fixmap.h	2003-12-24
18:34:19.213217816 +0530
@@ -67,6 +67,9 @@
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings
*/
 	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
 #endif
+#ifdef CONFIG_PCI_EXP_ENHANCED
+	FIX_PCIE_MCFG,
+#endif
 #ifdef CONFIG_ACPI_BOOT
 	FIX_ACPI_BEGIN,
 	FIX_ACPI_END = FIX_ACPI_BEGIN + FIX_ACPI_PAGES - 1,
diff -Naur linux-2.6_src/include/linux/acpi.h
linux-2.6_pciexpress/include/linux/acpi.h
--- linux-2.6_src/include/linux/acpi.h	2003-11-27 17:47:18.000000000
+0530
+++ linux-2.6_pciexpress/include/linux/acpi.h	2003-12-24
18:34:21.000000000 +0530
@@ -317,6 +317,15 @@
 	char				ec_id[0];
 } __attribute__ ((packed));
 
+#ifdef CONFIG_PCI_EXP_ENHANCED
+struct acpi_table_mcfg {
+	struct acpi_table_header 	header;
+	u8	reserved[8];
+	u64	base_address;
+} __attribute__ ((packed));
+#endif
+
+
 /* Table Handlers */
 
 enum acpi_table_id {
@@ -338,6 +347,9 @@
 	ACPI_SSDT,
 	ACPI_SPMI,
 	ACPI_HPET,
+#ifdef CONFIG_PCI_EXP_ENHANCED
+	ACPI_MCFG,
+#endif
 	ACPI_TABLE_COUNT
 };
 
diff -Naur linux-2.6_src/include/linux/pci.h
linux-2.6_pciexpress/include/linux/pci.h
--- linux-2.6_src/include/linux/pci.h	2003-11-27 17:47:11.000000000
+0530
+++ linux-2.6_pciexpress/include/linux/pci.h	2003-12-24
18:34:20.000000000 +0530
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
