Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266113AbTFWT0W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 15:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266114AbTFWT0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 15:26:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54496 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266113AbTFWT0O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 15:26:14 -0400
Date: Mon, 23 Jun 2003 20:40:21 +0100
From: Matthew Wilcox <willy@debian.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pci_raw_ops devfn
Message-ID: <20030623194021.GC25982@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Combine the dev and func arguments to pci_raw_ops into devfn which is
more natural all around.

Index: arch/i386/pci/common.c
===================================================================
RCS file: /var/cvs/linux-2.5/arch/i386/pci/common.c,v
retrieving revision 1.9
diff -u -p -r1.9 common.c
--- arch/i386/pci/common.c	23 Jun 2003 03:29:59 -0000	1.9
+++ arch/i386/pci/common.c	23 Jun 2003 19:31:05 -0000
@@ -27,14 +27,12 @@ struct pci_raw_ops *raw_pci_ops;
 
 static int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *value)
 {
-	return raw_pci_ops->read(0, bus->number, PCI_SLOT(devfn), 
-		PCI_FUNC(devfn), where, size, value);
+	return raw_pci_ops->read(0, bus->number, devfn, where, size, value);
 }
 
 static int pci_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 value)
 {
-	return raw_pci_ops->write(0, bus->number, PCI_SLOT(devfn), 
-		PCI_FUNC(devfn), where, size, value);
+	return raw_pci_ops->write(0, bus->number, devfn, where, size, value);
 }
 
 struct pci_ops pci_root_ops = {
Index: arch/i386/pci/direct.c
===================================================================
RCS file: /var/cvs/linux-2.5/arch/i386/pci/direct.c,v
retrieving revision 1.7
diff -u -p -r1.7 direct.c
--- arch/i386/pci/direct.c	23 Jun 2003 03:29:59 -0000	1.7
+++ arch/i386/pci/direct.c	23 Jun 2003 19:31:05 -0000
@@ -10,19 +10,19 @@
  * Functions for accessing PCI configuration space with type 1 accesses
  */
 
-#define PCI_CONF1_ADDRESS(bus, dev, fn, reg) \
-	(0x80000000 | (bus << 16) | (dev << 11) | (fn << 8) | (reg & ~3))
+#define PCI_CONF1_ADDRESS(bus, devfn, reg) \
+	(0x80000000 | (bus << 16) | (devfn << 8) | (reg & ~3))
 
-static int pci_conf1_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
+static int pci_conf1_read (int seg, int bus, int devfn, int reg, int len, u32 *value)
 {
 	unsigned long flags;
 
-	if (!value || (bus > 255) || (dev > 31) || (fn > 7) || (reg > 255))
+	if (!value || (bus > 255) || (devfn > 255) || (reg > 255))
 		return -EINVAL;
 
 	spin_lock_irqsave(&pci_config_lock, flags);
 
-	outl(PCI_CONF1_ADDRESS(bus, dev, fn, reg), 0xCF8);
+	outl(PCI_CONF1_ADDRESS(bus, devfn, reg), 0xCF8);
 
 	switch (len) {
 	case 1:
@@ -41,16 +41,16 @@ static int pci_conf1_read (int seg, int 
 	return 0;
 }
 
-static int pci_conf1_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
+static int pci_conf1_write (int seg, int bus, int devfn, int reg, int len, u32 value)
 {
 	unsigned long flags;
 
-	if ((bus > 255) || (dev > 31) || (fn > 7) || (reg > 255)) 
+	if ((bus > 255) || (devfn > 255) || (reg > 255)) 
 		return -EINVAL;
 
 	spin_lock_irqsave(&pci_config_lock, flags);
 
-	outl(PCI_CONF1_ADDRESS(bus, dev, fn, reg), 0xCF8);
+	outl(PCI_CONF1_ADDRESS(bus, devfn, reg), 0xCF8);
 
 	switch (len) {
 	case 1:
@@ -83,13 +83,17 @@ struct pci_raw_ops pci_direct_conf1 = {
 
 #define PCI_CONF2_ADDRESS(dev, reg)	(u16)(0xC000 | (dev << 8) | reg)
 
-static int pci_conf2_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
+static int pci_conf2_read(int seg, int bus, int devfn, int reg, int len, u32 *value)
 {
 	unsigned long flags;
+	int dev, fn;
 
-	if (!value || (bus > 255) || (dev > 31) || (fn > 7) || (reg > 255))
+	if (!value || (bus > 255) || (devfn > 255) || (reg > 255))
 		return -EINVAL;
 
+	dev = PCI_SLOT(devfn);
+	fn = PCI_FUNC(devfn);
+
 	if (dev & 0x10) 
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
@@ -110,20 +114,24 @@ static int pci_conf2_read (int seg, int 
 		break;
 	}
 
-	outb (0, 0xCF8);
+	outb(0, 0xCF8);
 
 	spin_unlock_irqrestore(&pci_config_lock, flags);
 
 	return 0;
 }
 
-static int pci_conf2_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
+static int pci_conf2_write (int seg, int bus, int devfn, int reg, int len, u32 value)
 {
 	unsigned long flags;
+	int dev, fn;
 
-	if ((bus > 255) || (dev > 31) || (fn > 7) || (reg > 255)) 
+	if ((bus > 255) || (devfn > 255) || (reg > 255)) 
 		return -EINVAL;
 
+	dev = PCI_SLOT(devfn);
+	fn = PCI_FUNC(devfn);
+
 	if (dev & 0x10) 
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
@@ -134,17 +142,17 @@ static int pci_conf2_write (int seg, int
 
 	switch (len) {
 	case 1:
-		outb ((u8)value, PCI_CONF2_ADDRESS(dev, reg));
+		outb((u8)value, PCI_CONF2_ADDRESS(dev, reg));
 		break;
 	case 2:
-		outw ((u16)value, PCI_CONF2_ADDRESS(dev, reg));
+		outw((u16)value, PCI_CONF2_ADDRESS(dev, reg));
 		break;
 	case 4:
-		outl ((u32)value, PCI_CONF2_ADDRESS(dev, reg));
+		outl((u32)value, PCI_CONF2_ADDRESS(dev, reg));
 		break;
 	}
 
-	outb (0, 0xCF8);    
+	outb(0, 0xCF8);    
 
 	spin_unlock_irqrestore(&pci_config_lock, flags);
 
@@ -178,14 +186,12 @@ static int __devinit pci_sanity_check(st
 		return 1;
 
 	for (devfn = 0; devfn < 0x100; devfn++) {
-		if (o->read(0, 0, PCI_SLOT(devfn), PCI_FUNC(devfn),
-						PCI_CLASS_DEVICE, 2, &x))
+		if (o->read(0, 0, devfn, PCI_CLASS_DEVICE, 2, &x))
 			continue;
 		if (x == PCI_CLASS_BRIDGE_HOST || x == PCI_CLASS_DISPLAY_VGA)
 			return 1;
 
-		if (o->read(0, 0, PCI_SLOT(devfn), PCI_FUNC(devfn),
-						PCI_VENDOR_ID, 2, &x))
+		if (o->read(0, 0, devfn, PCI_VENDOR_ID, 2, &x))
 			continue;
 		if (x == PCI_VENDOR_ID_INTEL || x == PCI_VENDOR_ID_COMPAQ)
 			return 1;
Index: arch/i386/pci/numa.c
===================================================================
RCS file: /var/cvs/linux-2.5/arch/i386/pci/numa.c,v
retrieving revision 1.7
diff -u -p -r1.7 numa.c
--- arch/i386/pci/numa.c	23 Jun 2003 03:29:59 -0000	1.7
+++ arch/i386/pci/numa.c	23 Jun 2003 19:31:05 -0000
@@ -10,19 +10,19 @@
 #define BUS2LOCAL(global) (mp_bus_id_to_local[global])
 #define QUADLOCAL2BUS(quad,local) (quad_local_to_mp_bus_id[quad][local])
 
-#define PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg) \
-	(0x80000000 | (BUS2LOCAL(bus) << 16) | (dev << 11) | (fn << 8) | (reg & ~3))
+#define PCI_CONF1_MQ_ADDRESS(bus, devfn, reg) \
+	(0x80000000 | (BUS2LOCAL(bus) << 16) | (devfn << 8) | (reg & ~3))
 
-static int pci_conf1_mq_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
+static int pci_conf1_mq_read (int seg, int bus, int devfn, int reg, int len, u32 *value)
 {
 	unsigned long flags;
 
-	if (!value || (bus > MAX_MP_BUSSES) || (dev > 31) || (fn > 7) || (reg > 255))
+	if (!value || (bus > MAX_MP_BUSSES) || (devfn > 255) || (reg > 255))
 		return -EINVAL;
 
 	spin_lock_irqsave(&pci_config_lock, flags);
 
-	outl_quad(PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg), 0xCF8, BUS2QUAD(bus));
+	outl_quad(PCI_CONF1_MQ_ADDRESS(bus, devfn, reg), 0xCF8, BUS2QUAD(bus));
 
 	switch (len) {
 	case 1:
@@ -41,16 +41,16 @@ static int pci_conf1_mq_read (int seg, i
 	return 0;
 }
 
-static int pci_conf1_mq_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
+static int pci_conf1_mq_write (int seg, int bus, int devfn, int reg, int len, u32 value)
 {
 	unsigned long flags;
 
-	if ((bus > MAX_MP_BUSSES) || (dev > 31) || (fn > 7) || (reg > 255)) 
+	if ((bus > MAX_MP_BUSSES) || (devfn > 255) || (reg > 255)) 
 		return -EINVAL;
 
 	spin_lock_irqsave(&pci_config_lock, flags);
 
-	outl_quad(PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg), 0xCF8, BUS2QUAD(bus));
+	outl_quad(PCI_CONF1_MQ_ADDRESS(bus, devfn, reg), 0xCF8, BUS2QUAD(bus));
 
 	switch (len) {
 	case 1:
Index: arch/i386/pci/pcbios.c
===================================================================
RCS file: /var/cvs/linux-2.5/arch/i386/pci/pcbios.c,v
retrieving revision 1.6
diff -u -p -r1.6 pcbios.c
--- arch/i386/pci/pcbios.c	23 Jun 2003 03:29:59 -0000	1.6
+++ arch/i386/pci/pcbios.c	23 Jun 2003 19:31:05 -0000
@@ -172,13 +172,13 @@ static int __devinit pci_bios_find_devic
 	return (int) (ret & 0xff00) >> 8;
 }
 
-static int pci_bios_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
+static int pci_bios_read (int seg, int bus, int devfn, int reg, int len, u32 *value)
 {
 	unsigned long result = 0;
 	unsigned long flags;
-	unsigned long bx = ((bus << 8) | (dev << 3) | fn);
+	unsigned long bx = (bus << 8) | devfn;
 
-	if (!value || (bus > 255) || (dev > 31) || (fn > 7) || (reg > 255))
+	if (!value || (bus > 255) || (devfn > 255) || (reg > 255))
 		return -EINVAL;
 
 	spin_lock_irqsave(&pci_config_lock, flags);
@@ -227,13 +227,13 @@ static int pci_bios_read (int seg, int b
 	return (int)((result & 0xff00) >> 8);
 }
 
-static int pci_bios_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
+static int pci_bios_write (int seg, int bus, int devfn, int reg, int len, u32 value)
 {
 	unsigned long result = 0;
 	unsigned long flags;
-	unsigned long bx = ((bus << 8) | (dev << 3) | fn);
+	unsigned long bx = (bus << 8) | devfn;
 
-	if ((bus > 255) || (dev > 31) || (fn > 7) || (reg > 255)) 
+	if ((bus > 255) || (devfn > 255) || (reg > 255)) 
 		return -EINVAL;
 
 	spin_lock_irqsave(&pci_config_lock, flags);
Index: arch/ia64/pci/pci.c
===================================================================
RCS file: /var/cvs/linux-2.5/arch/ia64/pci/pci.c,v
retrieving revision 1.9
diff -u -p -r1.9 pci.c
--- arch/ia64/pci/pci.c	23 Jun 2003 03:30:02 -0000	1.9
+++ arch/ia64/pci/pci.c	23 Jun 2003 19:31:05 -0000
@@ -53,21 +53,21 @@ struct pci_fixup pcibios_fixups[1];
  * synchronization mechanism here.
  */
 
-#define PCI_SAL_ADDRESS(seg, bus, dev, fn, reg) \
+#define PCI_SAL_ADDRESS(seg, bus, devfn, reg) \
 	((u64)(seg << 24) | (u64)(bus << 16) | \
-	 (u64)(dev << 11) | (u64)(fn << 8) | (u64)(reg))
+	 (u64)(devfn << 8) | (u64)(reg))
 
 
 static int
-pci_sal_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
+pci_sal_read (int seg, int bus, int devfn, int reg, int len, u32 *value)
 {
 	int result = 0;
 	u64 data = 0;
 
-	if (!value || (seg > 255) || (bus > 255) || (dev > 31) || (fn > 7) || (reg > 255))
+	if (!value || (seg > 255) || (bus > 255) || (devfn > 255) || (reg > 255))
 		return -EINVAL;
 
-	result = ia64_sal_pci_config_read(PCI_SAL_ADDRESS(seg, bus, dev, fn, reg), len, &data);
+	result = ia64_sal_pci_config_read(PCI_SAL_ADDRESS(seg, bus, devfn, reg), len, &data);
 
 	*value = (u32) data;
 
@@ -75,12 +75,12 @@ pci_sal_read (int seg, int bus, int dev,
 }
 
 static int
-pci_sal_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
+pci_sal_write (int seg, int bus, int devfn, int reg, int len, u32 value)
 {
-	if ((seg > 255) || (bus > 255) || (dev > 31) || (fn > 7) || (reg > 255))
+	if ((seg > 255) || (bus > 255) || (devfn > 255) || (reg > 255))
 		return -EINVAL;
 
-	return ia64_sal_pci_config_write(PCI_SAL_ADDRESS(seg, bus, dev, fn, reg), len, value);
+	return ia64_sal_pci_config_write(PCI_SAL_ADDRESS(seg, bus, devfn, reg), len, value);
 }
 
 struct pci_raw_ops pci_sal_ops = {
@@ -95,14 +95,14 @@ static int
 pci_read (struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *value)
 {
 	return raw_pci_ops->read(pci_domain_nr(bus), bus->number,
-			PCI_SLOT(devfn), PCI_FUNC(devfn), where, size, value);
+			devfn, where, size, value);
 }
 
 static int
 pci_write (struct pci_bus *bus, unsigned int devfn, int where, int size, u32 value)
 {
 	return raw_pci_ops->write(pci_domain_nr(bus), bus->number,
-			PCI_SLOT(devfn), PCI_FUNC(devfn), where, size, value);
+			devfn, where, size, value);
 }
 
 static struct pci_ops pci_root_ops = {
Index: drivers/acpi/osl.c
===================================================================
RCS file: /var/cvs/linux-2.5/drivers/acpi/osl.c,v
retrieving revision 1.18
diff -u -p -r1.18 osl.c
--- drivers/acpi/osl.c	23 Jun 2003 03:30:15 -0000	1.18
+++ drivers/acpi/osl.c	23 Jun 2003 19:31:07 -0000
@@ -466,7 +466,8 @@ acpi_os_read_pci_configuration (struct a
 	}
 
 	result = raw_pci_ops->read(pci_id->segment, pci_id->bus,
-			pci_id->device, pci_id->function, reg, size, value);
+				PCI_DEVFN(pci_id->device, pci_id->function),
+				reg, size, value);
 
 	return (result ? AE_ERROR : AE_OK);
 }
@@ -491,7 +492,8 @@ acpi_os_write_pci_configuration (struct 
 	}
 
 	result = raw_pci_ops->write(pci_id->segment, pci_id->bus,
-			pci_id->device, pci_id->function, reg, size, value);
+				PCI_DEVFN(pci_id->device, pci_id->function),
+				reg, size, value);
 
 	return (result ? AE_ERROR : AE_OK);
 }
Index: include/linux/pci.h
===================================================================
RCS file: /var/cvs/linux-2.5/include/linux/pci.h,v
retrieving revision 1.18
diff -u -p -r1.18 pci.h
--- include/linux/pci.h	23 Jun 2003 03:30:53 -0000	1.18
+++ include/linux/pci.h	23 Jun 2003 19:31:13 -0000
@@ -487,8 +487,8 @@ struct pci_ops {
 };
 
 struct pci_raw_ops {
-	int (*read)(int dom, int bus, int dev, int func, int reg, int len, u32 *val);
-	int (*write)(int dom, int bus, int dev, int func, int reg, int len, u32 val);
+	int (*read)(int dom, int bus, int devfn, int reg, int len, u32 *val);
+	int (*write)(int dom, int bus, int devfn, int reg, int len, u32 val);
 };
 
 extern struct pci_raw_ops *raw_pci_ops;

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
