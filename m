Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbTLNUBL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 15:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbTLNUBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 15:01:10 -0500
Received: from fmr99.intel.com ([192.55.52.32]:27868 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S262352AbTLNUA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 15:00:57 -0500
Message-ID: <3FDCC171.9070902@intel.com>
Date: Sun, 14 Dec 2003 22:00:49 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@redhat.com>, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: PCI Express support for 2.4 kernel
Content-Type: multipart/mixed;
 boundary="------------040101090301080609010002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040101090301080609010002
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Please, ignore previous submission with the same subject. Patch file 
attached was wrong one. Now correct patch attached.

Hi,
PCI-Express platforms will soon appear on the market. It is worth to
support it.

Following is patch for 2.4.23 kernel. I tested it on my host, it works
properly.
I did it for i386 only, I have no other architecture to test.

It was patch on the same subject from* Seshadri, Harinarayanan*
(/harinarayanan.seshadri@intel.com/
<mailto:harinarayanan.seshadri@intel.com>)
http://www.cs.helsinki.fi/linux/linux-kernel/2003-17/0247.html
My version differ in several aspects: it is for 2.4 (vs. 2.6); it do not
ioremap/unmap page for each transaction.

How about inclusion in 2.4.24?

I am not subscribed to lkml, thus please CC me
(Vladimir Kondratiev <vladimir.kondratiev@intel.com>) in replies.

Vladimir.


--------------040101090301080609010002
Content-Type: text/plain;
 name="pciexp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pciexp.patch"

Enable PCI Express access method for configuration space
This path includes:
 * access routines itself
 * command line argument "pci=exp" to force PCI Express, similar to "conf1" and "conf2"
 * full 4k config accessed through /proc/bus/pci/...

How it works:

With PCI-E, config space accessed through memory. Each device gets its own 4k memory mapped config,
total 256M for all devices.

At init time, I map whole region to not spent time for mapping later.

For /proc/bus/pci/..., I changed PCI_CFG_SPACE_SIZE to variable and changed it to 4k for PCI-E.

It is tested on 1 platform.

Author: "Vladimir Kondratiev" <vladimir.kondratiev@intel.com> 

diff -bBdur linux-2.4.23/arch/i386/kernel/pci-i386.h linux-2.4.23-pciexp/arch/i386/kernel/pci-i386.h
--- linux-2.4.23/arch/i386/kernel/pci-i386.h	2003-11-28 20:26:19.000000000 +0200
+++ linux-2.4.23-pciexp/arch/i386/kernel/pci-i386.h	2003-12-14 11:08:17.000000000 +0200
@@ -15,6 +15,7 @@
 #define PCI_PROBE_BIOS		0x0001
 #define PCI_PROBE_CONF1		0x0002
 #define PCI_PROBE_CONF2		0x0004
+#define PCI_PROBE_EXP		0x0008
 #define PCI_NO_SORT		0x0100
 #define PCI_BIOS_SORT		0x0200
 #define PCI_NO_CHECKS		0x0400
diff -bBdur linux-2.4.23/arch/i386/kernel/pci-pc.c linux-2.4.23-pciexp/arch/i386/kernel/pci-pc.c
--- linux-2.4.23/arch/i386/kernel/pci-pc.c	2003-11-28 20:26:19.000000000 +0200
+++ linux-2.4.23-pciexp/arch/i386/kernel/pci-pc.c	2003-12-14 21:27:52.000000000 +0200
@@ -20,7 +20,7 @@
 
 #include "pci-i386.h"
 
-unsigned int pci_probe = PCI_PROBE_BIOS | PCI_PROBE_CONF1 | PCI_PROBE_CONF2;
+unsigned int pci_probe = PCI_PROBE_BIOS | PCI_PROBE_CONF1 | PCI_PROBE_CONF2 | PCI_PROBE_EXP;
 
 int pcibios_last_bus = -1;
 struct pci_bus *pci_root_bus = NULL;
@@ -427,6 +427,155 @@
 	pci_conf2_write_config_dword
 };
 
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
+static u32 rrbar_phys=0xe0000000UL;
+/**
+ * RRBAR is always 256M
+ */
+static u32 rrbar_size=0x10000000UL;
+/**
+ * Virtual address for RRBAR
+ */
+static void* rrbar_virt=NULL;
+/**
+ * It used to be #define, but I am going to change it.
+ */
+extern int PCI_CFG_SPACE_SIZE;
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
+ * Creates mapping for whole 256M area.
+ * 
+ * @return 1 if OK, 0 if error
+ */
+static int pci_express_init(void)
+{
+  /* TODO: check PCI-Ex presense */
+  rrbar_virt=ioremap(rrbar_phys,rrbar_size);
+  if (!rrbar_virt) return 0;
+  return 1;
+}
+
+/**
+ * Shuts down PCI-E resources.
+ */
+static void pci_express_fini(void)
+{
+  if (rrbar_virt) {
+    iounmap(rrbar_virt);
+  }
+}
+
+static int pci_exp_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
+{
+  void* addr=rrbar_virt+(bus << 20)+(dev << 15)+(fn << 12)+reg;
+  if ((bus > 255 || dev > 31 || fn > 7 || reg > 4095)) 
+    return -EINVAL;
+  switch (len) {
+  case 1:
+    *value=readb(addr);
+    break;
+  case 2:
+    if (reg&1) return -EINVAL;
+    *value=readw(addr);
+    break;
+  case 4:
+    if (reg&3) return -EINVAL;
+    *value=readl(addr);
+    break;
+  }
+  return 0;
+}
+
+static int pci_exp_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
+{
+  void* addr=rrbar_virt+(bus << 20)+(dev << 15)+(fn << 12)+reg;
+  if ((bus > 255 || dev > 31 || fn > 7 || reg > 4095)) 
+    return -EINVAL;
+  switch (len) {
+  case 1:
+    writeb(value,addr);
+    break;
+  case 2:
+    if (reg&1) return -EINVAL;
+    writew(value,addr);
+    break;
+  case 4:
+    if (reg&3) return -EINVAL;
+    writel(value,addr);
+    break;
+  }
+  return 0;
+}
+
+static int pci_exp_read_config_byte(struct pci_dev *dev, int where, u8 *value)
+{
+  int result; 
+  u32 data;
+  result = pci_exp_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
+			PCI_FUNC(dev->devfn), where, 1, &data);
+  *value = (u8)data;
+  return result;
+}
+
+static int pci_exp_read_config_word(struct pci_dev *dev, int where, u16 *value)
+{
+  int result; 
+  u32 data;
+  result = pci_exp_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
+			PCI_FUNC(dev->devfn), where, 2, &data);
+  *value = (u16)data;
+  return result;
+}
+
+static int pci_exp_read_config_dword(struct pci_dev *dev, int where, u32 *value)
+{
+  return pci_exp_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
+		      PCI_FUNC(dev->devfn), where, 4, value);
+}
+
+static int pci_exp_write_config_byte(struct pci_dev *dev, int where, u8 value)
+{
+  return pci_exp_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
+		       PCI_FUNC(dev->devfn), where, 1, value);
+}
+
+static int pci_exp_write_config_word(struct pci_dev *dev, int where, u16 value)
+{
+  return pci_exp_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
+		       PCI_FUNC(dev->devfn), where, 2, value);
+}
+
+static int pci_exp_write_config_dword(struct pci_dev *dev, int where, u32 value)
+{
+  return pci_exp_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
+		       PCI_FUNC(dev->devfn), where, 4, value);
+}
+
+static struct pci_ops pci_express_conf = {
+  pci_exp_read_config_byte,
+  pci_exp_read_config_word,
+  pci_exp_read_config_dword,
+  pci_exp_write_config_byte,
+  pci_exp_write_config_word,
+  pci_exp_write_config_dword
+};
 
 /*
  * Before we decide to use direct hardware access mechanisms, we try to do some
@@ -465,6 +614,21 @@
 
 	__save_flags(flags); __cli();
 
+    /**
+     * Check if PCI-express access work
+     */
+    if (pci_express_init()) {
+        if (pci_sanity_check(&pci_express_conf)) {
+            PCI_CFG_SPACE_SIZE=4096;
+			__restore_flags(flags);
+			printk(KERN_INFO "PCI: Using configuration type PCI Express\n");
+			request_mem_region(rrbar_phys, rrbar_size, "PCI-Express config space");
+			return &pci_express_conf;
+        } else {
+            pci_express_fini();
+        }
+    }
+
 	/*
 	 * Check if configuration type 1 works.
 	 */
@@ -1398,16 +1562,18 @@
 #endif
 
 #ifdef CONFIG_PCI_DIRECT
-	if ((pci_probe & (PCI_PROBE_CONF1 | PCI_PROBE_CONF2)) 
+	if ((pci_probe & (PCI_PROBE_CONF1 | PCI_PROBE_CONF2 | PCI_PROBE_EXP)) 
 		&& (tmp = pci_check_direct())) {
 		pci_root_ops = tmp;
 		if (pci_root_ops == &pci_direct_conf1) {
 			pci_config_read = pci_conf1_read;
 			pci_config_write = pci_conf1_write;
-		}
-		else {
+		} else if (pci_root_ops == &pci_direct_conf2) {
 			pci_config_read = pci_conf2_read;
 			pci_config_write = pci_conf2_write;
+		} else if (pci_root_ops == &pci_express_conf) {
+			pci_config_read = pci_exp_read;
+			pci_config_write = pci_exp_write;
 		}
 	}
 #endif
@@ -1489,6 +1655,10 @@
 		pci_probe = PCI_PROBE_CONF2 | PCI_NO_CHECKS;
 		return NULL;
 	}
+	else if (!strcmp(str, "exp")) {
+		pci_probe = PCI_PROBE_EXP | PCI_NO_CHECKS;
+		return NULL;
+	}
 #endif
 	else if (!strcmp(str, "rom")) {
 		pci_probe |= PCI_ASSIGN_ROMS;
diff -bBdur linux-2.4.23/drivers/pci/proc.c linux-2.4.23-pciexp/drivers/pci/proc.c
--- linux-2.4.23/drivers/pci/proc.c	2002-11-29 01:53:14.000000000 +0200
+++ linux-2.4.23-pciexp/drivers/pci/proc.c	2003-12-14 14:18:58.000000000 +0200
@@ -16,7 +16,7 @@
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
 
-#define PCI_CFG_SPACE_SIZE 256
+int PCI_CFG_SPACE_SIZE=256;
 
 static loff_t
 proc_bus_pci_lseek(struct file *file, loff_t off, int whence)

--------------040101090301080609010002--
