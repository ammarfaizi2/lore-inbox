Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbTFSX2p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 19:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbTFSX2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 19:28:14 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:17311 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261936AbTFSXZp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 19:25:45 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10560659712885@kroah.com>
Subject: Re: [PATCH] PCI changes and fixes for 2.5.72
In-Reply-To: <10560659712069@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 19 Jun 2003 16:39:31 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1360, 2003/06/19 16:02:39-07:00, willy@debian.org

[PATCH] PCI: pci_raw_ops patch to fix acpi on ia64


 arch/i386/pci/common.c  |   23 +++++++++++--
 arch/i386/pci/direct.c  |   82 ++++++++++++++----------------------------------
 arch/i386/pci/fixup.c   |    6 +--
 arch/i386/pci/irq.c     |    2 -
 arch/i386/pci/legacy.c  |    6 +--
 arch/i386/pci/numa.c    |   26 ++++-----------
 arch/i386/pci/pcbios.c  |   22 ++----------
 arch/i386/pci/pci.h     |    2 -
 arch/ia64/pci/pci.c     |   33 +++++++++++--------
 drivers/acpi/osl.c      |   41 +++++++-----------------
 drivers/acpi/pci_root.c |    2 -
 include/linux/pci.h     |    7 ++++
 12 files changed, 103 insertions(+), 149 deletions(-)


diff -Nru a/arch/i386/pci/common.c b/arch/i386/pci/common.c
--- a/arch/i386/pci/common.c	Thu Jun 19 16:32:08 2003
+++ b/arch/i386/pci/common.c	Thu Jun 19 16:32:08 2003
@@ -23,7 +23,24 @@
 
 int pcibios_last_bus = -1;
 struct pci_bus *pci_root_bus = NULL;
-struct pci_ops *pci_root_ops = NULL;
+struct pci_raw_ops *raw_pci_ops;
+
+static int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *value)
+{
+	return raw_pci_ops->read(0, bus->number, PCI_SLOT(devfn), 
+		PCI_FUNC(devfn), where, size, value);
+}
+
+static int pci_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 value)
+{
+	return raw_pci_ops->write(0, bus->number, PCI_SLOT(devfn), 
+		PCI_FUNC(devfn), where, size, value);
+}
+
+struct pci_ops pci_root_ops = {
+	.read = pci_read,
+	.write = pci_write,
+};
 
 /*
  * legacy, numa, and acpi all want to call pcibios_scan_root
@@ -115,7 +132,7 @@
 
 	printk("PCI: Probing PCI hardware (bus %02x)\n", busnum);
 
-	return pci_scan_bus(busnum, pci_root_ops, NULL);
+	return pci_scan_bus(busnum, &pci_root_ops, NULL);
 }
 
 extern u8 pci_cache_line_size;
@@ -124,7 +141,7 @@
 {
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 
-	if (!pci_root_ops) {
+	if (!raw_pci_ops) {
 		printk("PCI: System does not support PCI\n");
 		return 0;
 	}
diff -Nru a/arch/i386/pci/direct.c b/arch/i386/pci/direct.c
--- a/arch/i386/pci/direct.c	Thu Jun 19 16:32:08 2003
+++ b/arch/i386/pci/direct.c	Thu Jun 19 16:32:08 2003
@@ -13,7 +13,7 @@
 #define PCI_CONF1_ADDRESS(bus, dev, fn, reg) \
 	(0x80000000 | (bus << 16) | (dev << 11) | (fn << 8) | (reg & ~3))
 
-static int __pci_conf1_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
+static int pci_conf1_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
 {
 	unsigned long flags;
 
@@ -41,7 +41,7 @@
 	return 0;
 }
 
-static int __pci_conf1_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
+static int pci_conf1_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
 {
 	unsigned long flags;
 
@@ -71,19 +71,7 @@
 
 #undef PCI_CONF1_ADDRESS
 
-static int pci_conf1_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *value)
-{
-	return __pci_conf1_read(0, bus->number, PCI_SLOT(devfn), 
-		PCI_FUNC(devfn), where, size, value);
-}
-
-static int pci_conf1_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 value)
-{
-	return __pci_conf1_write(0, bus->number, PCI_SLOT(devfn), 
-		PCI_FUNC(devfn), where, size, value);
-}
-
-struct pci_ops pci_direct_conf1 = {
+struct pci_raw_ops pci_direct_conf1 = {
 	.read =		pci_conf1_read,
 	.write =	pci_conf1_write,
 };
@@ -95,7 +83,7 @@
 
 #define PCI_CONF2_ADDRESS(dev, reg)	(u16)(0xC000 | (dev << 8) | reg)
 
-static int __pci_conf2_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
+static int pci_conf2_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
 {
 	unsigned long flags;
 
@@ -129,7 +117,7 @@
 	return 0;
 }
 
-static int __pci_conf2_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
+static int pci_conf2_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
 {
 	unsigned long flags;
 
@@ -165,19 +153,7 @@
 
 #undef PCI_CONF2_ADDRESS
 
-static int pci_conf2_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *value)
-{
-	return __pci_conf2_read(0, bus->number, PCI_SLOT(devfn), 
-		PCI_FUNC(devfn), where, size, value);
-}
-
-static int pci_conf2_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 value)
-{
-	return __pci_conf2_write(0, bus->number, PCI_SLOT(devfn), 
-		PCI_FUNC(devfn), where, size, value);
-}
-
-static struct pci_ops pci_direct_conf2 = {
+static struct pci_raw_ops pci_direct_conf2 = {
 	.read =		pci_conf2_read,
 	.write =	pci_conf2_write,
 };
@@ -193,38 +169,30 @@
  * This should be close to trivial, but it isn't, because there are buggy
  * chipsets (yes, you guessed it, by Intel and Compaq) that have no class ID.
  */
-static int __devinit pci_sanity_check(struct pci_ops *o)
+static int __devinit pci_sanity_check(struct pci_raw_ops *o)
 {
 	u32 x = 0;
-	int retval = 0;
-	struct pci_bus *bus;		/* Fake bus and device */
-	struct pci_dev *dev;
+	int devfn;
 
 	if (pci_probe & PCI_NO_CHECKS)
 		return 1;
 
-	bus = kmalloc(sizeof(*bus), GFP_ATOMIC);
-	dev = kmalloc(sizeof(*dev), GFP_ATOMIC);
-	if (!bus || !dev) {
-		printk(KERN_ERR "Out of memory in %s\n", __FUNCTION__);
-		goto exit;
+	for (devfn = 0; devfn < 0x100; devfn++) {
+		if (o->read(0, 0, PCI_SLOT(devfn), PCI_FUNC(devfn),
+						PCI_CLASS_DEVICE, 2, &x))
+			continue;
+		if (x == PCI_CLASS_BRIDGE_HOST || x == PCI_CLASS_DISPLAY_VGA)
+			return 1;
+
+		if (o->read(0, 0, PCI_SLOT(devfn), PCI_FUNC(devfn),
+						PCI_VENDOR_ID, 2, &x))
+			continue;
+		if (x == PCI_VENDOR_ID_INTEL || x == PCI_VENDOR_ID_COMPAQ)
+			return 1;
 	}
 
-	bus->number = 0;
-	dev->bus = bus;
-	for(dev->devfn=0; dev->devfn < 0x100; dev->devfn++)
-		if ((!o->read(bus, dev->devfn, PCI_CLASS_DEVICE, 2, &x) &&
-		     (x == PCI_CLASS_BRIDGE_HOST || x == PCI_CLASS_DISPLAY_VGA)) ||
-		    (!o->read(bus, dev->devfn, PCI_VENDOR_ID, 2, &x) &&
-		     (x == PCI_VENDOR_ID_INTEL || x == PCI_VENDOR_ID_COMPAQ))) {
-			retval = 1;
-			goto exit;
-		}
 	DBG("PCI: Sanity check failed\n");
-exit:
-	kfree(dev);
-	kfree(bus);
-	return retval;
+	return 0;
 }
 
 static int __init pci_direct_init(void)
@@ -247,9 +215,9 @@
 			local_irq_restore(flags);
 			printk(KERN_INFO "PCI: Using configuration type 1\n");
 			if (!request_region(0xCF8, 8, "PCI conf1"))
-				pci_root_ops = NULL;
+				raw_pci_ops = NULL;
 			else
-				pci_root_ops = &pci_direct_conf1;
+				raw_pci_ops = &pci_direct_conf1;
 			return 0;
 		}
 		outl (tmp, 0xCF8);
@@ -267,9 +235,9 @@
 			local_irq_restore(flags);
 			printk(KERN_INFO "PCI: Using configuration type 2\n");
 			if (!request_region(0xCF8, 4, "PCI conf2"))
-				pci_root_ops = NULL;
+				raw_pci_ops = NULL;
 			else
-				pci_root_ops = &pci_direct_conf2;
+				raw_pci_ops = &pci_direct_conf2;
 			return 0;
 		}
 	}
diff -Nru a/arch/i386/pci/fixup.c b/arch/i386/pci/fixup.c
--- a/arch/i386/pci/fixup.c	Thu Jun 19 16:32:08 2003
+++ b/arch/i386/pci/fixup.c	Thu Jun 19 16:32:08 2003
@@ -23,9 +23,9 @@
 		pci_read_config_byte(d, reg++, &subb);
 		DBG("i450NX PXB %d: %02x/%02x/%02x\n", pxb, busno, suba, subb);
 		if (busno)
-			pci_scan_bus(busno, pci_root_ops, NULL);	/* Bus A */
+			pci_scan_bus(busno, &pci_root_ops, NULL);	/* Bus A */
 		if (suba < subb)
-			pci_scan_bus(suba+1, pci_root_ops, NULL);	/* Bus B */
+			pci_scan_bus(suba+1, &pci_root_ops, NULL);	/* Bus B */
 	}
 	pcibios_last_bus = -1;
 }
@@ -39,7 +39,7 @@
 	u8 busno;
 	pci_read_config_byte(d, 0x4a, &busno);
 	printk(KERN_INFO "PCI: i440KX/GX host bridge %s: secondary bus %02x\n", d->slot_name, busno);
-	pci_scan_bus(busno, pci_root_ops, NULL);
+	pci_scan_bus(busno, &pci_root_ops, NULL);
 	pcibios_last_bus = -1;
 }
 
diff -Nru a/arch/i386/pci/irq.c b/arch/i386/pci/irq.c
--- a/arch/i386/pci/irq.c	Thu Jun 19 16:32:08 2003
+++ b/arch/i386/pci/irq.c	Thu Jun 19 16:32:08 2003
@@ -107,7 +107,7 @@
 		 *  It might be a secondary bus, but in this case its parent is already
 		 *  known (ascending bus order) and therefore pci_scan_bus returns immediately.
 		 */
-		if (busmap[i] && pci_scan_bus(i, pci_root_bus->ops, NULL))
+		if (busmap[i] && pci_scan_bus(i, &pci_root_ops, NULL))
 			printk(KERN_INFO "PCI: Discovered primary peer bus %02x [IRQ]\n", i);
 	pcibios_last_bus = -1;
 }
diff -Nru a/arch/i386/pci/legacy.c b/arch/i386/pci/legacy.c
--- a/arch/i386/pci/legacy.c	Thu Jun 19 16:32:08 2003
+++ b/arch/i386/pci/legacy.c	Thu Jun 19 16:32:08 2003
@@ -31,14 +31,14 @@
 		if (pci_bus_exists(&pci_root_buses, n))
 			continue;
 		bus->number = n;
-		bus->ops = pci_root_ops;
+		bus->ops = &pci_root_ops;
 		dev->bus = bus;
 		for (dev->devfn=0; dev->devfn<256; dev->devfn += 8)
 			if (!pci_read_config_word(dev, PCI_VENDOR_ID, &l) &&
 			    l != 0x0000 && l != 0xffff) {
 				DBG("Found device at %02x:%02x [%04x]\n", n, dev->devfn, l);
 				printk(KERN_INFO "PCI: Discovered peer bus %02x\n", n);
-				pci_scan_bus(n, pci_root_ops, NULL);
+				pci_scan_bus(n, &pci_root_ops, NULL);
 				break;
 			}
 	}
@@ -49,7 +49,7 @@
 
 static int __init pci_legacy_init(void)
 {
-	if (!pci_root_ops) {
+	if (!raw_pci_ops) {
 		printk("PCI: System does not support PCI\n");
 		return 0;
 	}
diff -Nru a/arch/i386/pci/numa.c b/arch/i386/pci/numa.c
--- a/arch/i386/pci/numa.c	Thu Jun 19 16:32:08 2003
+++ b/arch/i386/pci/numa.c	Thu Jun 19 16:32:08 2003
@@ -13,7 +13,7 @@
 #define PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg) \
 	(0x80000000 | (BUS2LOCAL(bus) << 16) | (dev << 11) | (fn << 8) | (reg & ~3))
 
-static int __pci_conf1_mq_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
+static int pci_conf1_mq_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
 {
 	unsigned long flags;
 
@@ -41,7 +41,7 @@
 	return 0;
 }
 
-static int __pci_conf1_mq_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
+static int pci_conf1_mq_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
 {
 	unsigned long flags;
 
@@ -71,19 +71,7 @@
 
 #undef PCI_CONF1_MQ_ADDRESS
 
-static int pci_conf1_mq_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *value)
-{
-	return __pci_conf1_mq_read(0, bus->number, PCI_SLOT(devfn), 
-		PCI_FUNC(devfn), where, size, value);
-}
-
-static int pci_conf1_mq_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 value)
-{
-	return __pci_conf1_mq_write(0, bus->number, PCI_SLOT(devfn), 
-		PCI_FUNC(devfn), where, size, value);
-}
-
-static struct pci_ops pci_direct_conf1_mq = {
+static struct pci_raw_ops pci_direct_conf1_mq = {
 	.read	= pci_conf1_mq_read,
 	.write	= pci_conf1_mq_write
 };
@@ -106,9 +94,9 @@
 		pci_read_config_byte(d, reg++, &subb);
 		DBG("i450NX PXB %d: %02x/%02x/%02x\n", pxb, busno, suba, subb);
 		if (busno)
-			pci_scan_bus(QUADLOCAL2BUS(quad,busno), pci_root_ops, NULL);	/* Bus A */
+			pci_scan_bus(QUADLOCAL2BUS(quad,busno), &pci_root_ops, NULL);	/* Bus A */
 		if (suba < subb)
-			pci_scan_bus(QUADLOCAL2BUS(quad,suba+1), pci_root_ops, NULL);	/* Bus B */
+			pci_scan_bus(QUADLOCAL2BUS(quad,suba+1), &pci_root_ops, NULL);	/* Bus B */
 	}
 	pcibios_last_bus = -1;
 }
@@ -121,7 +109,7 @@
 {
 	int quad;
 
-	pci_root_ops = &pci_direct_conf1_mq;
+	raw_pci_ops = &pci_direct_conf1_mq;
 
 	if (pcibios_scanned++)
 		return 0;
@@ -132,7 +120,7 @@
 			printk("Scanning PCI bus %d for quad %d\n", 
 				QUADLOCAL2BUS(quad,0), quad);
 			pci_scan_bus(QUADLOCAL2BUS(quad,0), 
-				pci_root_ops, NULL);
+				&pci_root_ops, NULL);
 		}
 	}
 	return 0;
diff -Nru a/arch/i386/pci/pcbios.c b/arch/i386/pci/pcbios.c
--- a/arch/i386/pci/pcbios.c	Thu Jun 19 16:32:08 2003
+++ b/arch/i386/pci/pcbios.c	Thu Jun 19 16:32:08 2003
@@ -172,7 +172,7 @@
 	return (int) (ret & 0xff00) >> 8;
 }
 
-static int __pci_bios_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
+static int pci_bios_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
 {
 	unsigned long result = 0;
 	unsigned long flags;
@@ -227,7 +227,7 @@
 	return (int)((result & 0xff00) >> 8);
 }
 
-static int __pci_bios_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
+static int pci_bios_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
 {
 	unsigned long result = 0;
 	unsigned long flags;
@@ -282,24 +282,12 @@
 	return (int)((result & 0xff00) >> 8);
 }
 
-static int pci_bios_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *value)
-{
-	return __pci_bios_read(0, bus->number, PCI_SLOT(devfn), 
-		PCI_FUNC(devfn), where, size, value);
-}
-
-static int pci_bios_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 value)
-{
-	return __pci_bios_write(0, bus->number, PCI_SLOT(devfn),
-		PCI_FUNC(devfn), where, size, value);
-}
-
 
 /*
  * Function table for BIOS32 access
  */
 
-static struct pci_ops pci_bios_access = {
+static struct pci_raw_ops pci_bios_access = {
 	.read =		pci_bios_read,
 	.write =	pci_bios_write
 };
@@ -308,7 +296,7 @@
  * Try to find PCI BIOS.
  */
 
-static struct pci_ops * __devinit pci_find_bios(void)
+static struct pci_raw_ops * __devinit pci_find_bios(void)
 {
 	union bios32 *check;
 	unsigned char sum;
@@ -484,7 +472,7 @@
 static int __init pci_pcbios_init(void)
 {
 	if ((pci_probe & PCI_PROBE_BIOS) 
-		&& ((pci_root_ops = pci_find_bios()))) {
+		&& ((raw_pci_ops = pci_find_bios()))) {
 		pci_probe |= PCI_BIOS_SORT;
 		pci_bios_present = 1;
 	}
diff -Nru a/arch/i386/pci/pci.h b/arch/i386/pci/pci.h
--- a/arch/i386/pci/pci.h	Thu Jun 19 16:32:08 2003
+++ b/arch/i386/pci/pci.h	Thu Jun 19 16:32:08 2003
@@ -37,7 +37,7 @@
 
 extern int pcibios_last_bus;
 extern struct pci_bus *pci_root_bus;
-extern struct pci_ops *pci_root_ops;
+extern struct pci_ops pci_root_ops;
 
 /* pci-irq.c */
 
diff -Nru a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
--- a/arch/ia64/pci/pci.c	Thu Jun 19 16:32:08 2003
+++ b/arch/ia64/pci/pci.c	Thu Jun 19 16:32:08 2003
@@ -59,7 +59,7 @@
 
 
 static int
-__pci_sal_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
+pci_sal_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
 {
 	int result = 0;
 	u64 data = 0;
@@ -75,7 +75,7 @@
 }
 
 static int
-__pci_sal_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
+pci_sal_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
 {
 	if ((seg > 255) || (bus > 255) || (dev > 31) || (fn > 7) || (reg > 255))
 		return -EINVAL;
@@ -83,28 +83,33 @@
 	return ia64_sal_pci_config_write(PCI_SAL_ADDRESS(seg, bus, dev, fn, reg), len, value);
 }
 
+struct pci_raw_ops pci_sal_ops = {
+	.read = 	pci_sal_read,
+	.write =	pci_sal_write
+};
+
+struct pci_raw_ops *raw_pci_ops = &pci_sal_ops;	/* default to SAL */
+
 
 static int
-pci_sal_read (struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *value)
+pci_read (struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *value)
 {
-	return __pci_sal_read(pci_domain_nr(bus), bus->number, PCI_SLOT(devfn), PCI_FUNC(devfn),
-			      where, size, value);
+	return raw_pci_ops->read(pci_domain_nr(bus), bus->number,
+			PCI_SLOT(devfn), PCI_FUNC(devfn), where, size, value);
 }
 
 static int
-pci_sal_write (struct pci_bus *bus, unsigned int devfn, int where, int size, u32 value)
+pci_write (struct pci_bus *bus, unsigned int devfn, int where, int size, u32 value)
 {
-	return __pci_sal_write(pci_domain_nr(bus), bus->number, PCI_SLOT(devfn), PCI_FUNC(devfn),
-			       where, size, value);
+	return raw_pci_ops->write(pci_domain_nr(bus), bus->number,
+			PCI_SLOT(devfn), PCI_FUNC(devfn), where, size, value);
 }
 
-struct pci_ops pci_sal_ops = {
-	.read = 	pci_sal_read,
-	.write =	pci_sal_write
+static struct pci_ops pci_root_ops = {
+	.read = pci_read,
+	.write = pci_write,
 };
 
-struct pci_ops *pci_root_ops = &pci_sal_ops;	/* default to SAL */
-
 static int __init
 pci_acpi_init (void)
 {
@@ -307,7 +312,7 @@
 	info.name = name;
 	acpi_walk_resources(handle, METHOD_NAME__CRS, add_window, &info);
 
-	return scan_root_bus(bus, pci_root_ops, controller);
+	return scan_root_bus(bus, &pci_root_ops, controller);
 
 out3:
 	kfree(controller->window);
diff -Nru a/drivers/acpi/osl.c b/drivers/acpi/osl.c
--- a/drivers/acpi/osl.c	Thu Jun 19 16:32:08 2003
+++ b/drivers/acpi/osl.c	Thu Jun 19 16:32:08 2003
@@ -69,8 +69,6 @@
 static OSD_HANDLER acpi_irq_handler = NULL;
 static void *acpi_irq_context = NULL;
 
-extern struct pci_ops *pci_root_ops;
-
 acpi_status
 acpi_os_initialize(void)
 {
@@ -79,7 +77,7 @@
 	 * it while walking the namespace (bus 0 and root bridges w/ _BBNs).
 	 */
 #ifdef CONFIG_ACPI_PCI
-	if (!pci_root_ops) {
+	if (!raw_pci_ops) {
 		printk(KERN_ERR PREFIX "Access to PCI configuration space unavailable\n");
 		return AE_NULL_ENTRY;
 	}
@@ -446,15 +444,9 @@
 #ifdef CONFIG_ACPI_PCI
 
 acpi_status
-acpi_os_read_pci_configuration (
-	struct acpi_pci_id	*pci_id,
-	u32			reg,
-	void			*value,
-	u32			width)
+acpi_os_read_pci_configuration (struct acpi_pci_id *pci_id, u32 reg, void *value, u32 width)
 {
-	int			result = 0;
-	int			size = 0;
-	struct pci_bus		bus;
+	int result, size;
 
 	if (!value)
 		return AE_BAD_PARAMETER;
@@ -470,27 +462,19 @@
 		size = 4;
 		break;
 	default:
-		BUG();
+		return AE_ERROR;
 	}
 
-	bus.number = pci_id->bus;
-	result = pci_root_ops->read(&bus, PCI_DEVFN(pci_id->device,
-						    pci_id->function),
-				    reg, size, value);
+	result = raw_pci_ops->read(pci_id->segment, pci_id->bus,
+			pci_id->device, pci_id->function, reg, size, value);
 
 	return (result ? AE_ERROR : AE_OK);
 }
 
 acpi_status
-acpi_os_write_pci_configuration (
-	struct acpi_pci_id	*pci_id,
-	u32			reg,
-	acpi_integer		value,
-	u32			width)
+acpi_os_write_pci_configuration (struct acpi_pci_id *pci_id, u32 reg, acpi_integer value, u32 width)
 {
-	int			result = 0;
-	int			size = 0;
-	struct pci_bus		bus;
+	int result, size;
 
 	switch (width) {
 	case 8:
@@ -503,13 +487,12 @@
 		size = 4;
 		break;
 	default:
-		BUG();
+		return AE_ERROR;
 	}
 
-	bus.number = pci_id->bus;
-	result = pci_root_ops->write(&bus, PCI_DEVFN(pci_id->device,
-						     pci_id->function),
-				     reg, size, value);
+	result = raw_pci_ops->write(pci_id->segment, pci_id->bus,
+			pci_id->device, pci_id->function, reg, size, value);
+
 	return (result ? AE_ERROR : AE_OK);
 }
 
diff -Nru a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
--- a/drivers/acpi/pci_root.c	Thu Jun 19 16:32:08 2003
+++ b/drivers/acpi/pci_root.c	Thu Jun 19 16:32:08 2003
@@ -44,8 +44,6 @@
 #define ACPI_PCI_ROOT_DRIVER_NAME	"ACPI PCI Root Bridge Driver"
 #define ACPI_PCI_ROOT_DEVICE_NAME	"PCI Root Bridge"
 
-extern struct pci_ops *pci_root_ops;
-
 static int acpi_pci_root_add (struct acpi_device *device);
 static int acpi_pci_root_remove (struct acpi_device *device, int type);
 
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Thu Jun 19 16:32:08 2003
+++ b/include/linux/pci.h	Thu Jun 19 16:32:08 2003
@@ -486,6 +486,13 @@
 	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
 };
 
+struct pci_raw_ops {
+	int (*read)(int dom, int bus, int dev, int func, int reg, int len, u32 *val);
+	int (*write)(int dom, int bus, int dev, int func, int reg, int len, u32 val);
+};
+
+extern struct pci_raw_ops *raw_pci_ops;
+
 struct pci_bus_region {
 	unsigned long start;
 	unsigned long end;

