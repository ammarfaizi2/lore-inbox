Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265319AbUEZGcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265319AbUEZGcM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 02:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265322AbUEZGcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 02:32:11 -0400
Received: from petasus.png.intel.com ([192.198.147.99]:55941 "EHLO
	petasus.png.intel.com") by vger.kernel.org with ESMTP
	id S265319AbUEZGbA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 02:31:00 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [BK PATCH] PCI Express patches for 2.4.27-pre3
Date: Wed, 26 May 2004 11:59:43 +0530
Message-ID: <6B09584CC3D2124DB45C3B592414FA83021EB9E5@bgsmsx402.gar.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BK PATCH] PCI Express patches for 2.4.27-pre3
Thread-Index: AcRB3bL7X1kVTZXGSvCFL2X+F1puQgBDH15Q
From: "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>
To: "Andi Kleen" <ak@muc.de>, "Greg KH" <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-pci@atrey.karlin.mff.cuni.cz>,
       <marcelo.tosatti@cyclades.com>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>
X-OriginalArrivalTime: 26 May 2004 06:29:46.0277 (UTC) FILETIME=[D6902D50:01C442EA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

That's a very good point. I agree for x86_64 we can get rid of dynamic
fixmap and can use ioremap like in  2.6. ( I think it's a fall over from
the i386 version patch)

Please find a updated patch, this closely follows 2.6 version. This
patch is for 2.4.27-pre3 kernel on both x86 and x86-64 architecture and
tested in PCI Express platforms of both x86 and x86_64 architecture.

	 
I think its important that we have this patch for 2.4 kernel as well, as
it will enable the PCI express devices to access extended config space
(above 256 bytes), where all Advance feature of PCI Express config
registers resides. Also this patch is backward compatible in any case,
meaning the user can still fall back to direct config (Existing) access
method, by selecting proper kernel option.

One other option, is we can keep the existing direct access as default
and provide this (MCFG)access method as an kernel configurable option.
Please let me know your opinion on this?


Thanks,
Sundar

-----Original Message-----
From: owner-linux-pci@atrey.karlin.mff.cuni.cz
[mailto:owner-linux-pci@atrey.karlin.mff.cuni.cz] On Behalf Of Andi
Kleen
Sent: Tuesday, May 25, 2004 3:52 AM
To: Greg KH
Cc: linux-kernel@vger.kernel.org; linux-pci@atrey.karlin.mff.cuni.cz;
marcelo.tosatti@cyclades.com
Subject: Re: [BK PATCH] PCI Express patches for 2.4.27-pre3

Greg KH <greg@kroah.com> writes:
>  obj-y			+= pci-pc.o pci-irq.o
> diff -Nru a/arch/x86_64/kernel/mmconfig.c
b/arch/x86_64/kernel/mmconfig.c
> --- /dev/null	Wed Dec 31 16:00:00 1969
> +++ b/arch/x86_64/kernel/mmconfig.c	Mon May 24 13:52:10 2004


> +static inline void pci_exp_set_dev_base(int bus, int devfn)
> +{
> +	u32 dev_base = pci_mmcfg_base_addr | (bus << 20) | (devfn <<
12);
> +	if (dev_base != mmcfg_last_accessed_device) {
> +		mmcfg_last_accessed_device = dev_base;
> +		set_fixmap(FIX_PCIE_MCFG, dev_base);
> +	}

Please no dynamic fixmap crap on x86-64. Do it like 2.6 does  -
ioremap()
the complete mmconfig aperture once and just just reference it directly.

Then you can also get rid of the spinlocks in the actual access
functions,
since everything will be stateless.

-Andi


#################### Patch Start #############################

diff -Naur linux-2.4.27-pre3/arch/i386/config.in
linux-2.4.27-pre3-patched/arch/i386/config.in
--- linux-2.4.27-pre3/arch/i386/config.in	2004-05-25
16:44:16.000000000 +0530
+++ linux-2.4.27-pre3-patched/arch/i386/config.in	2004-05-25
16:49:40.000000000 +0530
@@ -286,6 +286,7 @@
       choice '  PCI access mode' \
 	"BIOS		CONFIG_PCI_GOBIOS	\
 	 Direct		CONFIG_PCI_GODIRECT	\
+	 MMConfig 	CONFIG_PCI_GOMMCONFIG	\
 	 Any		CONFIG_PCI_GOANY"	Any
       if [ "$CONFIG_PCI_GOBIOS" = "y" -o "$CONFIG_PCI_GOANY" = "y" ];
then
          define_bool CONFIG_PCI_BIOS y
@@ -293,6 +294,9 @@
       if [ "$CONFIG_PCI_GODIRECT" = "y" -o "$CONFIG_PCI_GOANY" = "y" ];
then
          define_bool CONFIG_PCI_DIRECT y
       fi
+      if [ "$CONFIG_PCI_GOMMCONFIG" = "y" -o "$CONFIG_PCI_GOANY" = "y"
]; then
+         define_bool CONFIG_PCI_MMCONFIG y
+      fi
    fi
    bool 'ISA bus support' CONFIG_ISA
 fi
diff -Naur linux-2.4.27-pre3/arch/i386/kernel/Makefile
linux-2.4.27-pre3-patched/arch/i386/kernel/Makefile
--- linux-2.4.27-pre3/arch/i386/kernel/Makefile	2004-05-25
16:44:16.000000000 +0530
+++ linux-2.4.27-pre3-patched/arch/i386/kernel/Makefile	2004-05-25
16:49:40.000000000 +0530
@@ -30,6 +30,10 @@
 endif
 endif
 
+ifdef CONFIG_PCI_MMCONFIG
+obj-y			+= mmconfig.o
+endif
+
 obj-$(CONFIG_MCA)		+= mca.o
 obj-$(CONFIG_MTRR)		+= mtrr.o
 obj-$(CONFIG_X86_MSR)		+= msr.o
diff -Naur linux-2.4.27-pre3/arch/i386/kernel/mmconfig.c
linux-2.4.27-pre3-patched/arch/i386/kernel/mmconfig.c
--- linux-2.4.27-pre3/arch/i386/kernel/mmconfig.c	1970-01-01
05:30:00.000000000 +0530
+++ linux-2.4.27-pre3-patched/arch/i386/kernel/mmconfig.c
2004-05-25 16:49:40.000000000 +0530
@@ -0,0 +1,178 @@
+/*
+ * mmconfig.c - Low-level direct PCI config space access via MMCONFIG
+ */
+
+#include <linux/pci.h>
+#include <linux/init.h>
+#include "pci-i386.h"
+
+/* The physical address of the MMCONFIG aperture.  Set from ACPI
tables. */
+extern u32 pci_mmcfg_base_addr;
+
+#define mmcfg_virt_addr (fix_to_virt(FIX_PCIE_MCFG))
+
+/* The base address of the last MMCONFIG device accessed */
+static u32 mmcfg_last_accessed_device;
+
+/*
+ * Functions for accessing PCI configuration space with MMCONFIG
accesses
+ */
+
+static inline void pci_exp_set_dev_base(int bus, int devfn)
+{
+	u32 dev_base = pci_mmcfg_base_addr | (bus << 20) | (devfn <<
12);
+	if (dev_base != mmcfg_last_accessed_device) {
+		mmcfg_last_accessed_device = dev_base;
+		set_fixmap(FIX_PCIE_MCFG, dev_base);
+	}
+}
+
+static int pci_mmcfg_read(int seg, int bus, int devfn, int reg, int
len, u32 *value)
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
+static int pci_mmcfg_write(int seg, int bus, int devfn, int reg, int
len, u32 value)
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
+static int pci_mmcfg_read_config_byte(struct pci_dev *dev, int where,
u8 *value)
+{
+	int result; 
+	u32 data;
+
+	result = pci_mmcfg_read(0, dev->bus->number, dev->devfn, 
+				where, 1, &data);
+
+	*value = (u8)data;
+
+	return result;
+}
+
+static int pci_mmcfg_read_config_word(struct pci_dev *dev, int where,
u16 *value)
+{
+	int result; 
+	u32 data;
+
+	result = pci_mmcfg_read(0, dev->bus->number, dev->devfn, 
+ 				where, 2, &data);
+
+	*value = (u16)data;
+
+	return result;
+}
+
+static int pci_mmcfg_read_config_dword(struct pci_dev *dev, int where,
u32 *value)
+{
+	return pci_mmcfg_read(0, dev->bus->number, dev->devfn, 
+				where, 4, value);
+}
+
+static int pci_mmcfg_write_config_byte(struct pci_dev *dev, int where,
u8 value)
+{
+	return pci_mmcfg_write(0, dev->bus->number, dev->devfn, 
+				where, 1, value);
+}
+
+static int pci_mmcfg_write_config_word(struct pci_dev *dev, int where,
u16 value)
+{
+	return pci_mmcfg_write(0, dev->bus->number, dev->devfn, 
+				where, 2, value);
+}
+
+static int pci_mmcfg_write_config_dword(struct pci_dev *dev, int where,
u32 value)
+{
+	return pci_mmcfg_write(0, dev->bus->number, dev->devfn, 
+				where, 4, value);
+}
+
+static struct pci_ops pci_mmcfg = {
+	pci_mmcfg_read_config_byte,
+	pci_mmcfg_read_config_word,
+	pci_mmcfg_read_config_dword,
+	pci_mmcfg_write_config_byte,
+	pci_mmcfg_write_config_word,
+	pci_mmcfg_write_config_dword
+};
+
+struct pci_ops * __devinit pci_mmcfg_init(void)
+{
+	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
+	{
+		goto out;
+	}
+	if (!pci_mmcfg_base_addr)
+	{
+		goto out;
+	}
+
+	printk(KERN_INFO "PCI: Using MMCONFIG\n");
+	pci_probe = (pci_probe & ~PCI_PROBE_MASK) | PCI_PROBE_MMCONF;
+
+	return &pci_mmcfg;
+
+out:
+	return NULL;
+}
+
+int pci_mcfg_read(int seg, int bus, int dev, int fn, int reg, int len, 
+				u32 *value)
+{
+	pci_mmcfg_read(seg, bus, PCI_DEVFN(dev, fn), reg, len, value);
+}
+
+int pci_mcfg_write(int seg, int bus, int dev, int fn, int reg, int len,

+				u32 *value)
+{
+	pci_mmcfg_write(seg, bus, PCI_DEVFN(dev, fn), reg, len, value);
+}
diff -Naur linux-2.4.27-pre3/arch/i386/kernel/pci-i386.h
linux-2.4.27-pre3-patched/arch/i386/kernel/pci-i386.h
--- linux-2.4.27-pre3/arch/i386/kernel/pci-i386.h	2004-05-25
16:44:16.000000000 +0530
+++ linux-2.4.27-pre3-patched/arch/i386/kernel/pci-i386.h
2004-05-25 16:49:40.000000000 +0530
@@ -15,6 +15,8 @@
 #define PCI_PROBE_BIOS		0x0001
 #define PCI_PROBE_CONF1		0x0002
 #define PCI_PROBE_CONF2		0x0004
+#define PCI_PROBE_MMCONF	0x0008
+#define PCI_PROBE_MASK		0x000f
 #define PCI_NO_SORT		0x0100
 #define PCI_BIOS_SORT		0x0200
 #define PCI_NO_CHECKS		0x0400
@@ -23,6 +25,7 @@
 #define PCI_ASSIGN_ALL_BUSSES	0x4000
 
 extern unsigned int pci_probe;
+extern spinlock_t pci_config_lock;
 
 /* pci-i386.c */
 
@@ -69,3 +72,10 @@
 void pcibios_irq_init(void);
 void pcibios_fixup_irqs(void);
 void pcibios_enable_irq(struct pci_dev *dev);
+
+/* mmconfig.c */
+int pci_mcfg_read(int seg, int bus, int dev, int fn, int reg, int len, 
+				u32 *value);
+int pci_mcfg_write(int seg, int bus, int dev, int fn, int reg, int len,

+				u32 *value);
+struct pci_ops * __devinit pci_mmcfg_init(void);
diff -Naur linux-2.4.27-pre3/arch/i386/kernel/pci-pc.c
linux-2.4.27-pre3-patched/arch/i386/kernel/pci-pc.c
--- linux-2.4.27-pre3/arch/i386/kernel/pci-pc.c	2004-05-25
16:48:45.000000000 +0530
+++ linux-2.4.27-pre3-patched/arch/i386/kernel/pci-pc.c	2004-05-25
16:49:40.000000000 +0530
@@ -20,7 +20,8 @@
 
 #include "pci-i386.h"
 
-unsigned int pci_probe = PCI_PROBE_BIOS | PCI_PROBE_CONF1 |
PCI_PROBE_CONF2;
+unsigned int pci_probe = PCI_PROBE_BIOS | PCI_PROBE_CONF1 |
PCI_PROBE_CONF2 |
+				PCI_PROBE_MMCONF;
 
 int pcibios_last_bus = -1;
 struct pci_bus *pci_root_bus = NULL;
@@ -45,7 +46,7 @@
  * This interrupt-safe spinlock protects all accesses to PCI
  * configuration space.
  */
-static spinlock_t pci_config_lock = SPIN_LOCK_UNLOCKED;
+spinlock_t pci_config_lock = SPIN_LOCK_UNLOCKED;
 
 
 /*
@@ -1446,6 +1447,33 @@
 	}
 #endif
 
+#ifdef CONFIG_PCI_MMCONFIG
+	pci_root_ops = pci_mmcfg_init();
+	if (pci_root_ops){
+		pci_config_read = pci_mcfg_read;
+		pci_config_write = pci_mcfg_write;
+		return;
+	}
+#ifdef CONFIG_PCI_DIRECT
+	/*
+	 * PCI Express option is enabled in NON-PCI Express
+	 * platforms. Reset the PCI root ops
+	 */
+	if ((pci_probe & (PCI_PROBE_CONF1 | PCI_PROBE_CONF2)) 
+		&& (tmp = pci_check_direct())) {
+		pci_root_ops = tmp;
+		if (pci_root_ops == &pci_direct_conf1) {
+			pci_config_read = pci_conf1_read;
+			pci_config_write = pci_conf1_write;
+		}
+		else {
+			pci_config_read = pci_conf2_read;
+			pci_config_write = pci_conf2_write;
+		}
+	}
+#endif
+#endif
+
 	return;
 }
 
@@ -1523,6 +1551,12 @@
 		return NULL;
 	}
 #endif
+#ifdef CONFIG_PCI_MMCONFIG
+	else if (!strcmp(str, "nommconf")) {
+		pci_probe &= ~PCI_PROBE_MMCONF;
+		return NULL;
+	}
+#endif
 	else if (!strcmp(str, "rom")) {
 		pci_probe |= PCI_ASSIGN_ROMS;
 		return NULL;
diff -Naur linux-2.4.27-pre3/arch/x86_64/config.in
linux-2.4.27-pre3-patched/arch/x86_64/config.in
--- linux-2.4.27-pre3/arch/x86_64/config.in	2004-05-25
16:44:15.000000000 +0530
+++ linux-2.4.27-pre3-patched/arch/x86_64/config.in	2004-05-25
16:49:40.000000000 +0530
@@ -95,7 +95,16 @@
 bool 'Networking support' CONFIG_NET
 bool 'PCI support' CONFIG_PCI
 if [ "$CONFIG_PCI" = "y" ]; then
-   define_bool CONFIG_PCI_DIRECT y 
+      choice '  PCI access mode' \
+	"Direct		CONFIG_PCI_GODIRECT 	\
+	 MMConfig 	CONFIG_PCI_GOMMCONFIG 	\
+	 Any		CONFIG_PCI_GOANY"	Any
+      if [ "$CONFIG_PCI_GODIRECT" = "y" -o "$CONFIG_PCI_GOANY" = "y" ];
then
+         define_bool CONFIG_PCI_DIRECT y
+      fi
+      if [ "$CONFIG_PCI_GOMMCONFIG" = "y" -o "$CONFIG_PCI_GOANY" = "y"
]; then
+         define_bool CONFIG_PCI_MMCONFIG y
+      fi
 fi
 
 source drivers/pci/Config.in
diff -Naur linux-2.4.27-pre3/arch/x86_64/kernel/Makefile
linux-2.4.27-pre3-patched/arch/x86_64/kernel/Makefile
--- linux-2.4.27-pre3/arch/x86_64/kernel/Makefile	2004-05-25
16:44:15.000000000 +0530
+++ linux-2.4.27-pre3-patched/arch/x86_64/kernel/Makefile
2004-05-25 16:49:40.000000000 +0530
@@ -21,6 +21,10 @@
 		pci-dma.o x8664_ksyms.o i387.o syscall.o vsyscall.o \
 		setup64.o e820.o warmreboot.o
 
+ifdef CONFIG_PCI_MMCONFIG
+obj-y			+= mmconfig.o
+endif
+
 ifdef CONFIG_PCI
 obj-y			+= pci-x86_64.o
 obj-y			+= pci-pc.o pci-irq.o
diff -Naur linux-2.4.27-pre3/arch/x86_64/kernel/mmconfig.c
linux-2.4.27-pre3-patched/arch/x86_64/kernel/mmconfig.c
--- linux-2.4.27-pre3/arch/x86_64/kernel/mmconfig.c	1970-01-01
05:30:00.000000000 +0530
+++ linux-2.4.27-pre3-patched/arch/x86_64/kernel/mmconfig.c
2004-05-25 17:06:59.000000000 +0530
@@ -0,0 +1,173 @@
+/*
+ * mmconfig.c - Low-level direct PCI config space access via MMCONFIG
+ */
+
+#include <linux/pci.h>
+#include <linux/init.h>
+#include "pci-x86_64.h"
+
+#define MMCONFIG_APER_SIZE (256*1024*1024)
+
+/* The physical address of the MMCONFIG aperture.  Set from ACPI
tables. */
+extern u32 pci_mmcfg_base_addr;
+
+/* Static virtual mapping of the MMCONFIG aperture */
+char *pci_mmcfg_virt;
+
+/*
+ * Functions for accessing PCI configuration space with MMCONFIG
accesses
+ */
+
+static inline char* pci_dev_base(int bus, int devfn)
+{
+	return pci_mmcfg_virt + ((bus << 20) | (devfn << 12));
+}
+
+static int pci_mmcfg_read(int seg, int bus, int devfn, int reg, int
len, 
+				u32 *value)
+{
+	char *addr = pci_dev_base(bus, devfn); 
+	
+	if (!value || (bus > 255) || (devfn > 255) || (reg > 4095))
+		return -EINVAL;
+
+	switch (len) {
+	case 1:
+		*value = readb(addr + reg);
+		break;
+	case 2:
+		*value = readw(addr + reg);
+		break;
+	case 4:
+		*value = readl(addr + reg);
+		break;
+	}
+
+	return 0;
+}
+
+static int pci_mmcfg_write(int seg, int bus, int devfn, int reg, int
len, 
+				u32 value)
+{
+	char *addr = pci_dev_base(bus, devfn); 
+	
+	if ((bus > 255) || (devfn > 255) || (reg > 4095)) 
+		return -EINVAL;
+
+	switch (len) {
+	case 1:
+		writeb(value, addr + reg);
+		break;
+	case 2:
+		writew(value, addr + reg);
+		break;
+	case 4:
+		writel(value, addr + reg);
+		break;
+	}
+
+	/* Dummy read to flush PCI write */
+	readl(addr);
+
+	return 0;
+}
+
+static int pci_mmcfg_read_config_byte(struct pci_dev *dev, int where, 
+					u8 *value)
+{
+	int result; 
+	u32 data;
+
+	result = pci_mmcfg_read(0, dev->bus->number, dev->devfn, 
+				where, 1, &data);
+
+	*value = (u8)data;
+
+	return result;
+}
+
+static int pci_mmcfg_read_config_word(struct pci_dev *dev, int where, 
+					u16 *value)
+{
+	int result; 
+	u32 data;
+
+	result = pci_mmcfg_read(0, dev->bus->number, dev->devfn, 
+ 				where, 2, &data);
+
+	*value = (u16)data;
+
+	return result;
+}
+
+static int pci_mmcfg_read_config_dword(struct pci_dev *dev, int where, 
+					u32 *value)
+{
+	return pci_mmcfg_read(0, dev->bus->number, dev->devfn, 
+				where, 4, value);
+}
+
+static int pci_mmcfg_write_config_byte(struct pci_dev *dev, int where, 
+					u8 value)
+{
+	return pci_mmcfg_write(0, dev->bus->number, dev->devfn, 
+				where, 1, value);
+}
+
+static int pci_mmcfg_write_config_word(struct pci_dev *dev, int where, 
+					u16 value)
+{
+	return pci_mmcfg_write(0, dev->bus->number, dev->devfn, 
+				where, 2, value);
+}
+
+static int pci_mmcfg_write_config_dword(struct pci_dev *dev, int where,

+					u32 value)
+{
+	return pci_mmcfg_write(0, dev->bus->number, dev->devfn, 
+				where, 4, value);
+}
+
+static struct pci_ops pci_mmcfg = {
+	pci_mmcfg_read_config_byte,
+	pci_mmcfg_read_config_word,
+	pci_mmcfg_read_config_dword,
+	pci_mmcfg_write_config_byte,
+	pci_mmcfg_write_config_word,
+	pci_mmcfg_write_config_dword
+};
+
+struct pci_ops * __devinit pci_mmcfg_init(void)
+{
+	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
+		goto out;
+	if (!pci_mmcfg_base_addr)
+		goto out;
+
+	/* i386 doesn't do _nocache right now */
+	pci_mmcfg_virt = ioremap_nocache(pci_mmcfg_base_addr, 
+						MMCONFIG_APER_SIZE);
+	if (!pci_mmcfg_virt) { 
+		printk("PCI: Cannot map mmconfig aperture\n");
+		goto out;
+	}	
+
+	printk(KERN_INFO "PCI: Using MMCONFIG at %x\n",
pci_mmcfg_base_addr);
+
+	return &pci_mmcfg;
+
+out:
+	return NULL;
+}
+
+int pci_mcfg_read(int seg, int bus, int dev, int fn, int reg, int len, 
+				u32 *value)
+{
+	pci_mmcfg_read(seg, bus, PCI_DEVFN(dev, fn), reg, len, value);
+}
+
+int pci_mcfg_write(int seg, int bus, int dev, int fn, int reg, int len,

+				u32 *value)
+{
+	pci_mmcfg_write(seg, bus, PCI_DEVFN(dev, fn), reg, len, value);
+}
diff -Naur linux-2.4.27-pre3/arch/x86_64/kernel/pci-pc.c
linux-2.4.27-pre3-patched/arch/x86_64/kernel/pci-pc.c
--- linux-2.4.27-pre3/arch/x86_64/kernel/pci-pc.c	2004-05-25
16:48:47.000000000 +0530
+++ linux-2.4.27-pre3-patched/arch/x86_64/kernel/pci-pc.c
2004-05-25 16:49:40.000000000 +0530
@@ -27,7 +27,7 @@
 
 #include "pci-x86_64.h"
 
-unsigned int pci_probe = PCI_PROBE_CONF1 | PCI_PROBE_CONF2;
+unsigned int pci_probe = PCI_PROBE_CONF1 | PCI_PROBE_CONF2 |
PCI_PROBE_MMCONF;
 
 int pcibios_last_bus = -1;
 struct pci_bus *pci_root_bus;
@@ -566,6 +566,31 @@
 		printk("??? no pci access\n"); 
 #endif
 
+#ifdef CONFIG_PCI_MMCONFIG
+	pci_root_ops = pci_mmcfg_init();
+	if (pci_root_ops) {
+		pci_config_read = pci_mcfg_read;
+		pci_config_write = pci_mcfg_write;
+	}
+#ifdef CONFIG_PCI_DIRECT
+	else {
+	/*
+	 * PCI Express option is enabled in NON-PCI Express
+	 * platforms. Reset the PCI root ops
+	 */
+		pci_root_ops = pci_check_direct();
+		if (pci_root_ops == &pci_direct_conf1) {
+			pci_config_read = pci_conf1_read;
+			pci_config_write = pci_conf1_write;
+		}
+		else {
+			pci_config_read = pci_conf2_read;
+			pci_config_write = pci_conf2_write;
+		}
+	}
+#endif
+#endif
+
 	return;
 }
 
@@ -580,6 +605,19 @@
 	if (pci_probe & (PCI_PROBE_CONF1 | PCI_PROBE_CONF2))
 		dir = pci_check_direct();
 #endif
+
+#ifdef CONFIG_PCI_MMCONFIG
+	dir = pci_mmcfg_init();
+#ifdef CONFIG_PCI_DIRECT
+	/*
+	 * PCI Express option is enabled in NON-PCI Express
+	 * platforms. Reset the PCI root ops
+	 */
+	if (!dir) {
+		dir = pci_check_direct();
+	}
+#endif
+#endif
 	if (dir)
 		pci_root_ops = dir;
 	else {
@@ -633,6 +671,12 @@
 		return NULL;
 	}
 #endif
+#ifdef CONFIG_PCI_MMCONFIG
+	else if (!strcmp(str, "nommconf")) {
+		pci_probe &= ~PCI_PROBE_MMCONF;
+		return NULL;
+	}
+#endif
 	else if (!strcmp(str, "rom")) {
 		pci_probe |= PCI_ASSIGN_ROMS;
 		return NULL;
diff -Naur linux-2.4.27-pre3/arch/x86_64/kernel/pci-x86_64.h
linux-2.4.27-pre3-patched/arch/x86_64/kernel/pci-x86_64.h
--- linux-2.4.27-pre3/arch/x86_64/kernel/pci-x86_64.h	2004-05-25
16:44:15.000000000 +0530
+++ linux-2.4.27-pre3-patched/arch/x86_64/kernel/pci-x86_64.h
2004-05-25 16:49:40.000000000 +0530
@@ -15,6 +15,8 @@
 #define PCI_PROBE_BIOS		0x0001
 #define PCI_PROBE_CONF1		0x0002
 #define PCI_PROBE_CONF2		0x0004
+#define PCI_PROBE_MMCONF	0x0008
+#define PCI_PROBE_MASK		0x000f
 #define PCI_NO_SORT		0x0100
 #define PCI_BIOS_SORT		0x0200
 #define PCI_NO_CHECKS		0x0400
@@ -74,3 +76,10 @@
 void pcibios_enable_irq(struct pci_dev *dev);
 
 void pci_iommu_init(void);
+
+/* mmconfig.c */
+int pci_mcfg_read(int seg, int bus, int dev, int fn, int reg, int len, 
+				u32 *value);
+int pci_mcfg_write(int seg, int bus, int dev, int fn, int reg, int len,

+				u32 *value);
+struct pci_ops * __devinit pci_mmcfg_init(void);
diff -Naur linux-2.4.27-pre3/drivers/pci/pci.c
linux-2.4.27-pre3-patched/drivers/pci/pci.c
--- linux-2.4.27-pre3/drivers/pci/pci.c	2004-05-25 16:48:51.000000000
+0530
+++ linux-2.4.27-pre3-patched/drivers/pci/pci.c	2004-05-25
16:49:40.000000000 +0530
@@ -36,6 +36,9 @@
 #define DBG(x...)
 #endif
 
+#define PCI_CFG_SPACE_SIZE	256
+#define PCI_CFG_SPACE_EXP_SIZE	4096
+
 LIST_HEAD(pci_root_buses);
 LIST_HEAD(pci_devices);
 
@@ -165,6 +168,8 @@
  *  %PCI_CAP_ID_CHSWP        CompactPCI HotSwap 
  *
  *  %PCI_CAP_ID_PCIX         PCI-X
+ *
+ *  %PCI_CAP_ID_EXP          PCI Express
  */
 int
 pci_find_capability(struct pci_dev *dev, int cap)
@@ -199,6 +204,21 @@
 	return 0;
 }
 
+/**
+ * pci_cfg_space_size - get the configuration space size of the PCI
device.
+ * Regular PCI devices have 256 bytes, but PCI-X 2 and PCI Express
devices
+ * have 4096 bytes.
+ */
+static int pci_cfg_space_size(struct pci_dev *dev)
+{
+	int pos;
+
+	pos = pci_find_capability(dev, PCI_CAP_ID_EXP);
+	if (pos)
+		return PCI_CFG_SPACE_EXP_SIZE;
+	
+	return PCI_CFG_SPACE_SIZE;
+}
 
 /**
  * pci_find_parent_resource - return resource region of parent bus of
given region
@@ -1427,6 +1447,9 @@
 		dev->class = PCI_CLASS_NOT_DEFINED;
 	}
 
+	/* Get the config space size */
+	dev->cfg_size = pci_cfg_space_size(dev);
+
 	/* We found a fine healthy device, go go go... */
 	return 0;
 }
diff -Naur linux-2.4.27-pre3/drivers/pci/proc.c
linux-2.4.27-pre3-patched/drivers/pci/proc.c
--- linux-2.4.27-pre3/drivers/pci/proc.c	2004-05-25
16:44:07.000000000 +0530
+++ linux-2.4.27-pre3-patched/drivers/pci/proc.c	2004-05-25
16:49:41.000000000 +0530
@@ -16,12 +16,13 @@
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
 
-#define PCI_CFG_SPACE_SIZE 256
-
 static loff_t
 proc_bus_pci_lseek(struct file *file, loff_t off, int whence)
 {
 	loff_t new;
+	const struct inode *ino = file->f_dentry->d_inode;
+	const struct proc_dir_entry *dp = ino->u.generic_ip;
+	struct pci_dev *dev = dp->data;
 
 	switch (whence) {
 	case 0:
@@ -31,12 +32,12 @@
 		new = file->f_pos + off;
 		break;
 	case 2:
-		new = PCI_CFG_SPACE_SIZE + off;
+		new = dev->cfg_size + off;
 		break;
 	default:
 		return -EINVAL;
 	}
-	if (new < 0 || new > PCI_CFG_SPACE_SIZE)
+	if (new < 0 || new > dev->cfg_size)
 		return -EINVAL;
 	return (file->f_pos = new);
 }
@@ -57,7 +58,7 @@
 	 */
 
 	if (capable(CAP_SYS_ADMIN))
-		size = PCI_CFG_SPACE_SIZE;
+		size = dev->cfg_size;
 	else if (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
 		size = 128;
 	else
@@ -132,12 +133,12 @@
 	int pos = *ppos;
 	int cnt;
 
-	if (pos >= PCI_CFG_SPACE_SIZE)
+	if (pos >= dev->cfg_size)
 		return 0;
-	if (nbytes >= PCI_CFG_SPACE_SIZE)
-		nbytes = PCI_CFG_SPACE_SIZE;
-	if (pos + nbytes > PCI_CFG_SPACE_SIZE)
-		nbytes = PCI_CFG_SPACE_SIZE - pos;
+	if (nbytes >= dev->cfg_size)
+		nbytes = dev->cfg_size;
+	if (pos + nbytes > dev->cfg_size)
+		nbytes = dev->cfg_size - pos;
 	cnt = nbytes;
 
 	if (!access_ok(VERIFY_READ, buf, cnt))
@@ -389,7 +390,7 @@
 		return -ENOMEM;
 	e->proc_fops = &proc_bus_pci_operations;
 	e->data = dev;
-	e->size = PCI_CFG_SPACE_SIZE;
+	e->size = dev->cfg_size;
 	return 0;
 }
 
diff -Naur linux-2.4.27-pre3/include/asm-i386/fixmap.h
linux-2.4.27-pre3-patched/include/asm-i386/fixmap.h
--- linux-2.4.27-pre3/include/asm-i386/fixmap.h	2004-05-25
16:43:56.000000000 +0530
+++ linux-2.4.27-pre3-patched/include/asm-i386/fixmap.h	2004-05-25
16:49:41.000000000 +0530
@@ -76,6 +76,9 @@
 	FIX_ACPI_BEGIN,
 	FIX_ACPI_END = FIX_ACPI_BEGIN + FIX_ACPI_PAGES - 1,
 #endif
+#ifdef CONFIG_PCI_MMCONFIG
+	FIX_PCIE_MCFG,
+#endif
 	__end_of_permanent_fixed_addresses,
 	/* temporary boot-time mappings, used before ioremap() is
functional */
 #define NR_FIX_BTMAPS	16
diff -Naur linux-2.4.27-pre3/include/linux/pci.h
linux-2.4.27-pre3-patched/include/linux/pci.h
--- linux-2.4.27-pre3/include/linux/pci.h	2004-05-25
16:48:53.000000000 +0530
+++ linux-2.4.27-pre3-patched/include/linux/pci.h	2004-05-25
16:49:41.000000000 +0530
@@ -401,6 +401,7 @@
 	/* device is compatible with these IDs */
 	unsigned short vendor_compatible[DEVICE_COUNT_COMPATIBLE];
 	unsigned short device_compatible[DEVICE_COUNT_COMPATIBLE];
+	int		cfg_size;	/* Size of configuration space
*/
 
 	/*
 	 * Instead of touching interrupt line and base address registers

#################### Patch END #############################

