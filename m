Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbTLPKVJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 05:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbTLPKVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 05:21:09 -0500
Received: from fmr02.intel.com ([192.55.52.25]:13210 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S261298AbTLPKUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 05:20:50 -0500
Message-ID: <3FDEDC77.9010203@intel.com>
Date: Tue, 16 Dec 2003 12:20:39 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: arjanv@redhat.com, Gabriel Paubert <paubert@iram.es>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Alan Cox <alan@redhat.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Martin Mares <mj@ucw.cz>, zaitcev@redhat.com, hch@infradead.org
Subject: Re: PCI Express support for 2.4 kernel
References: <3FDCC171.9070902@intel.com> <3FDCCC12.20808@pobox.com>  <3FDD8691.80206@intel.com> <20031215103142.GA8735@iram.es>  <3FDDACA9.1050600@intel.com> <1071494155.5223.3.camel@laptop.fenrus.com> <3FDDBDFE.5020707@intel.com> <Pine.LNX.4.58.0312151154480.1631@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312151154480.1631@home.osdl.org>
Content-Type: multipart/mixed;
 boundary="------------080606060505090607000905"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080606060505090607000905
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I re-worked the patch. This time it uses fixmap; I added config 
parameters to
disable this code and to handle non-default base address.
Unless generic solution for auto detection found, it seems appropriate
way to go.

Autodetection problem isolated in 2 places: is_pcie_platform and, while 
it is not
do real auto detection, configuration option for custom base.

Vladimir.

Linus Torvalds wrote:

>On Mon, 15 Dec 2003, Vladimir Kondratiev wrote:
>  
>
>>There is alternative solution, for each transaction to ioremap/unmap
>>corresponded page.
>>    
>>
>
>Nope, you can't do that. It's not really supported from interrupts and
>early boot - both of which will want to access PCI config space.
>
>  
>
>>I don't like it, it involves huge overhead.
>>    
>>
>
>Indeed it would. But using fixmaps does _not_.
>
>But a fixmap will be easy to use, and reasonable efficient: it will
>allocate just one virtual page, and then it will force a TLB flush when it
>switches over the mapping.
>
>You can improve the efficiency by caching the "last fixmap entry" and only
>doing "set_fixmap()" when changing devices.
>
>You could also do a per-cpu fixmap, which would help further, but that
>ends up being more work too. Probably not worth it, especially as it is
>entirely possible that the hardware requires single-threaded access
>anyway (ie I would not be surprised at all if the southbridge got very
>confused if you tried to do overlapping config accesses)..
>
>		Linus
>  
>


--------------080606060505090607000905
Content-Type: text/plain;
 name="pciexp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pciexp.patch"

Enable PCI Express access method for configuration space
This path includes:
 * configuration options
 * access routines itself
 * command line argument "pci=exp" to force PCI Express, similar to "conf1" and "conf2"
 * full 4k config accessed through /proc/bus/pci/...

How it works:

With PCI-E, config space accessed through memory. Each device gets its own 4k memory mapped config,
total 256M for all devices.

At init time, fixmap used to create 4k window within config space.
For each access, window set to proper physical address. Last physical
address cached, to save page walk if the same device is accessed

For /proc/bus/pci/..., I changed PCI_CFG_SPACE_SIZE to variable and changed it to 4k for PCI-E.

It is tested on 1 platform, with PCI-E enabled and disabled.

Author: "Vladimir Kondratiev" <vladimir.kondratiev@intel.com> 

diff -dur linux-2.4.23/Documentation/Configure.help linux-2.4.23-pciexp/Documentation/Configure.help
--- linux-2.4.23/Documentation/Configure.help	2003-11-28 20:26:19.000000000 +0200
+++ linux-2.4.23-pciexp/Documentation/Configure.help	2003-12-16 11:44:11.000000000 +0200
@@ -4131,6 +4131,30 @@
   if that doesn't work. If unsure, go with the default, which is
   "Any".
 
+PCI-Express support
+CONFIG_PCI_EXPRESS
+  PCI-Express is standard for devices interconnection. It is compatible
+  with PCI. If your system is PCI-Express, and you want support for
+  extended PCI-Express features, set this option to Y. PCI-Express
+  is auto detected, thus saying Y here is safe.
+
+  This option provides access to 4k extended config space and uses
+  memory-mapped method to access config space. Kernel option
+  "pci=exp" allows to force PCI-Express mode.
+
+Enable PCI-E custom base address
+CONFIG_PCIEXP_USE_CUSTOM_BASE
+  Override autodetected base address for PCI-Express config space.
+
+  If you don't know really well what are you doing, say "N".
+
+PCI-Express base address
+CONFIG_PCI_EXPRESS_BASE
+  Override autodetected base address for PCI-Express config space.
+  Base will be this number * 0x10000000 (256Mb).
+
+  Default value is "0xe".
+
 PCI device name database
 CONFIG_PCI_NAMES
   By default, the kernel contains a database of all known PCI device
diff -dur linux-2.4.23/arch/i386/config.in linux-2.4.23-pciexp/arch/i386/config.in
--- linux-2.4.23/arch/i386/config.in	2003-11-28 20:26:19.000000000 +0200
+++ linux-2.4.23-pciexp/arch/i386/config.in	2003-12-16 11:18:46.000000000 +0200
@@ -292,6 +292,15 @@
       fi
       if [ "$CONFIG_PCI_GODIRECT" = "y" -o "$CONFIG_PCI_GOANY" = "y" ]; then
          define_bool CONFIG_PCI_DIRECT y
+         bool 'PCI-Express support' CONFIG_PCI_EXPRESS
+         if [ "$CONFIG_PCI_EXPRESS" = "y" ]; then
+            bool 'Enable PCI-E custom base address' CONFIG_PCIEXP_USE_CUSTOM_BASE
+            if [ "$CONFIG_PCIEXP_USE_CUSTOM_BASE" = "y" ]; then
+               hex 'PCI-Express base address' CONFIG_PCI_EXPRESS_BASE 0xe
+            else
+               define_hex CONFIG_PCI_EXPRESS_BASE 0xe
+            fi
+         fi
       fi
    fi
    bool 'ISA bus support' CONFIG_ISA
diff -dur linux-2.4.23/arch/i386/defconfig linux-2.4.23-pciexp/arch/i386/defconfig
--- linux-2.4.23/arch/i386/defconfig	2003-11-28 20:26:19.000000000 +0200
+++ linux-2.4.23-pciexp/arch/i386/defconfig	2003-12-16 11:32:40.000000000 +0200
@@ -79,6 +79,9 @@
 CONFIG_PCI_GOANY=y
 CONFIG_PCI_BIOS=y
 CONFIG_PCI_DIRECT=y
+# CONFIG_PCI_EXPRESS is not set
+# CONFIG_PCIEXP_USE_CUSTOM_BASE is not set
+CONFIG_PCI_EXPRESS_BASE=0xe
 CONFIG_PCI_NAMES=y
 # CONFIG_EISA is not set
 # CONFIG_MCA is not set
diff -dur linux-2.4.23/arch/i386/kernel/pci-i386.h linux-2.4.23-pciexp/arch/i386/kernel/pci-i386.h
--- linux-2.4.23/arch/i386/kernel/pci-i386.h	2003-11-28 20:26:19.000000000 +0200
+++ linux-2.4.23-pciexp/arch/i386/kernel/pci-i386.h	2003-12-16 11:48:43.000000000 +0200
@@ -15,6 +15,11 @@
 #define PCI_PROBE_BIOS		0x0001
 #define PCI_PROBE_CONF1		0x0002
 #define PCI_PROBE_CONF2		0x0004
+
+#ifdef CONFIG_PCI_EXPRESS
+#define PCI_PROBE_EXP		0x0008
+#endif
+
 #define PCI_NO_SORT		0x0100
 #define PCI_BIOS_SORT		0x0200
 #define PCI_NO_CHECKS		0x0400
diff -dur linux-2.4.23/arch/i386/kernel/pci-pc.c linux-2.4.23-pciexp/arch/i386/kernel/pci-pc.c
--- linux-2.4.23/arch/i386/kernel/pci-pc.c	2003-11-28 20:26:19.000000000 +0200
+++ linux-2.4.23-pciexp/arch/i386/kernel/pci-pc.c	2003-12-16 12:00:46.000000000 +0200
@@ -2,6 +2,9 @@
  *	Low-Level PCI Support for PC
  *
  *	(c) 1999--2000 Martin Mares <mj@ucw.cz>
+ *
+ *	(c) 2003 Vladimir Kondratiev <vladimir.kondratiev@intel.com>
+ *		PCI Express
  */
 
 #include <linux/config.h>
@@ -18,9 +21,17 @@
 #include <asm/smp.h>
 #include <asm/smpboot.h>
 
+#ifdef CONFIG_PCI_EXPRESS
+#include <asm/fixmap.h>
+#endif
+
 #include "pci-i386.h"
 
-unsigned int pci_probe = PCI_PROBE_BIOS | PCI_PROBE_CONF1 | PCI_PROBE_CONF2;
+unsigned int pci_probe = PCI_PROBE_BIOS | PCI_PROBE_CONF1 | PCI_PROBE_CONF2
+#ifdef CONFIG_PCI_EXPRESS
+ | PCI_PROBE_EXP
+#endif
+;
 
 int pcibios_last_bus = -1;
 struct pci_bus *pci_root_bus = NULL;
@@ -427,6 +438,211 @@
 	pci_conf2_write_config_dword
 };
 
+#ifdef CONFIG_PCI_EXPRESS
+/**
+ * PCI Express routines
+ * "Vladimir Kondratiev" <vladimir.kondratiev@intel.com>
+ */
+/**
+ * RRBAR (memory base for PCI-E config space) resides here.
+ * Initialized to default address. Actually, it is platform specific, and
+ * value may vary.
+ * I don't know how to detect it properly, it is chipset specific.
+ */
+static u32 rrbar_phys = CONFIG_PCI_EXPRESS_BASE * 0x10000000UL;
+
+/**
+ * Virtual address for RRBAR adjusted for the device being accessed.
+ */
+static void *rrbar_window_virt;
+
+/**
+ * It used to be #define, but I am going to modify it.
+ */
+extern int pci_cfg_space_size;
+
+/**
+ * Cached last accessed device.
+ * If the same device to be accessed, no need in set_fixmap
+ */
+static u32 pcie_last_accessed_device;
+
+/**
+ * I don't know how to detect it properly.
+ * assume it is PCI-E, sanity_check will
+ * stop me if it is not.
+ * 
+ * Also, this function supposed to set rrbar_phys
+ */
+static int is_pcie_platform(void)
+{ return 1; }
+
+/**
+ * Initializes PCI Express method for config space access.
+ * 
+ * There is no standard method to recognize presence of PCI Express,
+ * thus we will assume it is PCI-E, and rely on sanity check to
+ * deassert PCI-E presense. If PCI-E not present,
+ * there is no physical RAM on RRBAR address, and we should read
+ * something like 0xff.
+ * 
+ * @return 1 if OK, 0 if error
+ */
+static int pci_express_init(void)
+{
+	rrbar_window_virt = (void*)fix_to_virt(FIX_PCIE_CONFIG);
+	if (!is_pcie_platform())
+		return 0;
+	/**
+	 * adjust mapping for 1-st device (00:00.0)
+	 * to match pcie_last_accessed_device
+	 */
+	set_fixmap_nocache(FIX_PCIE_CONFIG, rrbar_phys);
+	return 1;
+}
+
+/**
+ * Shuts down PCI-E resources.
+ */
+static inline void pci_express_fini(void)
+{}
+
+/**
+ * Adjust window for the device.
+ * pci_config_lock should be held
+ */
+static inline void pci_exp_set_dev_base(int bus, int dev, int fn)
+{
+	u32 dev_base = (bus << 20) | (dev << 15) | (fn << 12);
+	if (dev_base != pcie_last_accessed_device) {
+		pcie_last_accessed_device = dev_base;
+		set_fixmap_nocache(FIX_PCIE_CONFIG, rrbar_phys | dev_base);
+	}
+}
+
+static int pci_exp_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
+{
+	unsigned long flags;
+	void *addr = rrbar_window_virt + reg;
+	if (((unsigned)bus > 255 || (unsigned)dev > 31
+	  || (unsigned)fn > 7 || (unsigned)reg > 4095)) 
+		return -EINVAL;
+	switch (len) {
+	case 2:
+		if (reg & 1)
+			return -EINVAL;
+		break;
+	case 4:
+		if (reg & 3)
+			return -EINVAL;
+		break;
+	}
+	spin_lock_irqsave(&pci_config_lock, flags);
+	pci_exp_set_dev_base(bus, dev, fn);
+	switch (len) {
+	case 1:
+		*value = readb(addr);
+		break;
+	case 2:
+		*value = readw(addr);
+		break;
+	case 4:
+		*value = readl(addr);
+		break;
+	}
+	spin_unlock_irqrestore(&pci_config_lock, flags);
+	return 0;
+}
+
+static int pci_exp_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
+{
+	unsigned long flags;
+	void *addr = rrbar_window_virt + reg;
+	if (((unsigned)bus > 255 || (unsigned)dev > 31
+	  || (unsigned)fn > 7 || (unsigned)reg > 4095)) 
+		return -EINVAL;
+	switch (len) {
+	case 2:
+		if (reg & 1)
+			return -EINVAL;
+		break;
+	case 4:
+		if (reg & 3)
+			return -EINVAL;
+		break;
+	}
+	spin_lock_irqsave(&pci_config_lock, flags);
+	pci_exp_set_dev_base(bus, dev, fn);
+	switch (len) {
+	case 1:
+		writeb(value, addr);
+		break;
+	case 2:
+		writew(value, addr);
+		break;
+	case 4:
+		writel(value, addr);
+		break;
+	}
+	/* dummy read to flush PCI write */
+	readb(addr);
+	spin_unlock_irqrestore(&pci_config_lock, flags);
+	return 0;
+}
+
+static int pci_exp_read_config_byte(struct pci_dev *dev, int where, u8 *value)
+{
+	int result; 
+	u32 data;
+	result = pci_exp_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
+			PCI_FUNC(dev->devfn), where, 1, &data);
+	*value = (u8)data;
+	return result;
+}
+
+static int pci_exp_read_config_word(struct pci_dev *dev, int where, u16 *value)
+{
+	int result; 
+	u32 data;
+	result = pci_exp_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
+			PCI_FUNC(dev->devfn), where, 2, &data);
+	*value = (u16)data;
+	return result;
+}
+
+static int pci_exp_read_config_dword(struct pci_dev *dev, int where, u32 *value)
+{
+	return pci_exp_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
+			PCI_FUNC(dev->devfn), where, 4, value);
+}
+
+static int pci_exp_write_config_byte(struct pci_dev *dev, int where, u8 value)
+{
+	return pci_exp_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
+			PCI_FUNC(dev->devfn), where, 1, value);
+}
+
+static int pci_exp_write_config_word(struct pci_dev *dev, int where, u16 value)
+{
+	return pci_exp_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
+			PCI_FUNC(dev->devfn), where, 2, value);
+}
+
+static int pci_exp_write_config_dword(struct pci_dev *dev, int where, u32 value)
+{
+	return pci_exp_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
+			PCI_FUNC(dev->devfn), where, 4, value);
+}
+
+static struct pci_ops pci_express_conf = {
+	pci_exp_read_config_byte,
+	pci_exp_read_config_word,
+	pci_exp_read_config_dword,
+	pci_exp_write_config_byte,
+	pci_exp_write_config_word,
+	pci_exp_write_config_dword
+};
+#endif /* CONFIG_PCI_EXPRESS */
 
 /*
  * Before we decide to use direct hardware access mechanisms, we try to do some
@@ -465,6 +681,25 @@
 
 	__save_flags(flags); __cli();
 
+#ifdef CONFIG_PCI_EXPRESS
+	/**
+	 * Check if PCI-express access work
+	 */
+	if (pci_express_init()) {
+		if (pci_sanity_check(&pci_express_conf)) {
+			/* PCI-E provides 4k config space */
+			pci_cfg_space_size = 4096;
+			__restore_flags(flags);
+			printk(KERN_INFO "PCI: Using configuration type PCI-Express\n");
+			printk(KERN_INFO "PCI-Express config at 0x%08x\n", rrbar_phys);
+			request_mem_region(rrbar_phys, 0x10000000UL, "PCI-Express config space");
+			return &pci_express_conf;
+		} else {
+			pci_express_fini();
+		}
+	}
+#endif /* CONFIG_PCI_EXPRESS */
+
 	/*
 	 * Check if configuration type 1 works.
 	 */
@@ -1398,17 +1633,25 @@
 #endif
 
 #ifdef CONFIG_PCI_DIRECT
-	if ((pci_probe & (PCI_PROBE_CONF1 | PCI_PROBE_CONF2)) 
-		&& (tmp = pci_check_direct())) {
+	if ((pci_probe & (PCI_PROBE_CONF1 | PCI_PROBE_CONF2
+#ifdef CONFIG_PCI_EXPRESS
+			| PCI_PROBE_EXP
+#endif
+		)) && (tmp = pci_check_direct())) {
 		pci_root_ops = tmp;
 		if (pci_root_ops == &pci_direct_conf1) {
 			pci_config_read = pci_conf1_read;
 			pci_config_write = pci_conf1_write;
-		}
-		else {
+		} else if (pci_root_ops == &pci_direct_conf2) {
 			pci_config_read = pci_conf2_read;
 			pci_config_write = pci_conf2_write;
+		} 
+#ifdef CONFIG_PCI_EXPRESS
+		else if (pci_root_ops == &pci_express_conf) {
+			pci_config_read = pci_exp_read;
+			pci_config_write = pci_exp_write;
 		}
+#endif
 	}
 #endif
 
@@ -1489,6 +1732,12 @@
 		pci_probe = PCI_PROBE_CONF2 | PCI_NO_CHECKS;
 		return NULL;
 	}
+#ifdef CONFIG_PCI_EXPRESS
+	else if (!strcmp(str, "exp")) {
+		pci_probe = PCI_PROBE_EXP | PCI_NO_CHECKS;
+		return NULL;
+	}
+#endif
 #endif
 	else if (!strcmp(str, "rom")) {
 		pci_probe |= PCI_ASSIGN_ROMS;
diff -dur linux-2.4.23/drivers/pci/proc.c linux-2.4.23-pciexp/drivers/pci/proc.c
--- linux-2.4.23/drivers/pci/proc.c	2002-11-29 01:53:14.000000000 +0200
+++ linux-2.4.23-pciexp/drivers/pci/proc.c	2003-12-15 11:48:16.000000000 +0200
@@ -16,7 +16,10 @@
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
 
-#define PCI_CFG_SPACE_SIZE 256
+/**
+ * For PCI Express, it will be set to 4096 during PCI init
+ */
+int pci_cfg_space_size=256;
 
 static loff_t
 proc_bus_pci_lseek(struct file *file, loff_t off, int whence)
@@ -31,12 +34,12 @@
 		new = file->f_pos + off;
 		break;
 	case 2:
-		new = PCI_CFG_SPACE_SIZE + off;
+		new = pci_cfg_space_size + off;
 		break;
 	default:
 		return -EINVAL;
 	}
-	if (new < 0 || new > PCI_CFG_SPACE_SIZE)
+	if (new < 0 || new > pci_cfg_space_size)
 		return -EINVAL;
 	return (file->f_pos = new);
 }
@@ -57,7 +60,7 @@
 	 */
 
 	if (capable(CAP_SYS_ADMIN))
-		size = PCI_CFG_SPACE_SIZE;
+		size = pci_cfg_space_size;
 	else if (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
 		size = 128;
 	else
@@ -132,12 +135,12 @@
 	int pos = *ppos;
 	int cnt;
 
-	if (pos >= PCI_CFG_SPACE_SIZE)
+	if (pos >= pci_cfg_space_size)
 		return 0;
-	if (nbytes >= PCI_CFG_SPACE_SIZE)
-		nbytes = PCI_CFG_SPACE_SIZE;
-	if (pos + nbytes > PCI_CFG_SPACE_SIZE)
-		nbytes = PCI_CFG_SPACE_SIZE - pos;
+	if (nbytes >= pci_cfg_space_size)
+		nbytes = pci_cfg_space_size;
+	if (pos + nbytes > pci_cfg_space_size)
+		nbytes = pci_cfg_space_size - pos;
 	cnt = nbytes;
 
 	if (!access_ok(VERIFY_READ, buf, cnt))
@@ -389,7 +392,7 @@
 		return -ENOMEM;
 	e->proc_fops = &proc_bus_pci_operations;
 	e->data = dev;
-	e->size = PCI_CFG_SPACE_SIZE;
+	e->size = pci_cfg_space_size;
 	return 0;
 }
 
diff -dur linux-2.4.23/include/asm-i386/fixmap.h linux-2.4.23-pciexp/include/asm-i386/fixmap.h
--- linux-2.4.23/include/asm-i386/fixmap.h	2003-12-11 14:52:05.000000000 +0200
+++ linux-2.4.23-pciexp/include/asm-i386/fixmap.h	2003-12-16 11:46:29.000000000 +0200
@@ -76,6 +76,9 @@
 	FIX_ACPI_BEGIN,
 	FIX_ACPI_END = FIX_ACPI_BEGIN + FIX_ACPI_PAGES - 1,
 #endif
+#ifdef CONFIG_PCI_EXPRESS
+	FIX_PCIE_CONFIG, /* Window within PCI-E config space*/
+#endif 
 	__end_of_permanent_fixed_addresses,
 	/* temporary boot-time mappings, used before ioremap() is functional */
 #define NR_FIX_BTMAPS	16

--------------080606060505090607000905--
