Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317639AbSH3WHs>; Fri, 30 Aug 2002 18:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317610AbSH3WHN>; Fri, 30 Aug 2002 18:07:13 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:31251 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317606AbSH3WGx>;
	Fri, 30 Aug 2002 18:06:53 -0400
Date: Fri, 30 Aug 2002 15:10:17 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] PCI ops cleanups for 2.5.32-bk
Message-ID: <20020830221017.GE10783@kroah.com>
References: <20020830220720.GA10783@kroah.com> <20020830220846.GB10783@kroah.com> <20020830220912.GC10783@kroah.com> <20020830220931.GD10783@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020830220931.GD10783@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.545   -> 1.546  
#	arch/x86_64/pci/direct.c	1.2     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/30	greg@kroah.com	1.546
# [PATCH] PCI: x86-64 pci_ops changes
# 
# x86-64 pci changes
# --------------------------------------------
#
diff -Nru a/arch/x86_64/pci/direct.c b/arch/x86_64/pci/direct.c
--- a/arch/x86_64/pci/direct.c	Fri Aug 30 15:00:30 2002
+++ b/arch/x86_64/pci/direct.c	Fri Aug 30 15:00:30 2002
@@ -13,7 +13,7 @@
 #define PCI_CONF1_ADDRESS(bus, dev, fn, reg) \
 	(0x80000000 | (bus << 16) | (dev << 11) | (fn << 8) | (reg & ~3))
 
-static int pci_conf1_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
+static int __pci_conf1_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
 {
 	unsigned long flags;
 
@@ -41,7 +41,7 @@
 	return 0;
 }
 
-static int pci_conf1_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
+static int __pci_conf1_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
 {
 	unsigned long flags;
 
@@ -69,75 +69,23 @@
 	return 0;
 }
 
-
 #undef PCI_CONF1_ADDRESS
 
-static int pci_conf1_read_config_byte(struct pci_dev *dev, int where, u8 *value)
+static int pci_conf1_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *value)
 {
-	int result; 
-	u32 data;
-
-	if (!value) 
-		return -EINVAL;
-
-	result = pci_conf1_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, 1, &data);
-
-	*value = (u8)data;
-
-	return result;
+	return __pci_conf1_read(0, bus->number, PCI_SLOT(devfn), 
+		PCI_FUNC(devfn), where, size, value);
 }
 
-static int pci_conf1_read_config_word(struct pci_dev *dev, int where, u16 *value)
+static int pci_conf1_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 value)
 {
-	int result; 
-	u32 data;
-
-	if (!value) 
-		return -EINVAL;
-
-	result = pci_conf1_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, 2, &data);
-
-	*value = (u16)data;
-
-	return result;
-}
-
-static int pci_conf1_read_config_dword(struct pci_dev *dev, int where, u32 *value)
-{
-	if (!value) 
-		return -EINVAL;
-
-	return pci_conf1_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, 4, value);
-}
-
-static int pci_conf1_write_config_byte(struct pci_dev *dev, int where, u8 value)
-{
-	return pci_conf1_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, 1, value);
-}
-
-static int pci_conf1_write_config_word(struct pci_dev *dev, int where, u16 value)
-{
-	return pci_conf1_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, 2, value);
-}
-
-static int pci_conf1_write_config_dword(struct pci_dev *dev, int where, u32 value)
-{
-	return pci_conf1_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, 4, value);
+	return __pci_conf1_write(0, bus->number, PCI_SLOT(devfn), 
+		PCI_FUNC(devfn), where, size, value);
 }
 
 static struct pci_ops pci_direct_conf1 = {
-	pci_conf1_read_config_byte,
-	pci_conf1_read_config_word,
-	pci_conf1_read_config_dword,
-	pci_conf1_write_config_byte,
-	pci_conf1_write_config_word,
-	pci_conf1_write_config_dword
+	.read =		pci_conf1_read,
+	.write =	pci_conf1_write,
 };
 
 
@@ -147,7 +95,7 @@
 
 #define PCI_CONF2_ADDRESS(dev, reg)	(u16)(0xC000 | (dev << 8) | reg)
 
-static int pci_conf2_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
+static int __pci_conf2_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
 {
 	unsigned long flags;
 
@@ -181,7 +129,7 @@
 	return 0;
 }
 
-static int pci_conf2_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
+static int __pci_conf2_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
 {
 	unsigned long flags;
 
@@ -217,57 +165,21 @@
 
 #undef PCI_CONF2_ADDRESS
 
-static int pci_conf2_read_config_byte(struct pci_dev *dev, int where, u8 *value)
-{
-	int result; 
-	u32 data;
-	result = pci_conf2_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, 1, &data);
-	*value = (u8)data;
-	return result;
-}
-
-static int pci_conf2_read_config_word(struct pci_dev *dev, int where, u16 *value)
-{
-	int result; 
-	u32 data;
-	result = pci_conf2_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, 2, &data);
-	*value = (u16)data;
-	return result;
-}
-
-static int pci_conf2_read_config_dword(struct pci_dev *dev, int where, u32 *value)
-{
-	return pci_conf2_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, 4, value);
-}
-
-static int pci_conf2_write_config_byte(struct pci_dev *dev, int where, u8 value)
+static int pci_conf2_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *value)
 {
-	return pci_conf2_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, 1, value);
+	return __pci_conf2_read(0, bus->number, PCI_SLOT(devfn), 
+		PCI_FUNC(devfn), where, size, value);
 }
 
-static int pci_conf2_write_config_word(struct pci_dev *dev, int where, u16 value)
+static int pci_conf2_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 value)
 {
-	return pci_conf2_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, 2, value);
-}
-
-static int pci_conf2_write_config_dword(struct pci_dev *dev, int where, u32 value)
-{
-	return pci_conf2_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, 4, value);
+	return __pci_conf2_write(0, bus->number, PCI_SLOT(devfn), 
+		PCI_FUNC(devfn), where, size, value);
 }
 
 static struct pci_ops pci_direct_conf2 = {
-	pci_conf2_read_config_byte,
-	pci_conf2_read_config_word,
-	pci_conf2_read_config_dword,
-	pci_conf2_write_config_byte,
-	pci_conf2_write_config_word,
-	pci_conf2_write_config_dword
+	.read =		pci_conf2_read,
+	.write =	pci_conf2_write,
 };
 
 
@@ -283,7 +195,7 @@
  */
 static int __devinit pci_sanity_check(struct pci_ops *o)
 {
-	u16 x;
+	u32 x = 0;
 	struct pci_bus bus;		/* Fake bus and device */
 	struct pci_dev dev;
 
@@ -292,16 +204,16 @@
 	bus.number = 0;
 	dev.bus = &bus;
 	for(dev.devfn=0; dev.devfn < 0x100; dev.devfn++)
-		if ((!o->read_word(&dev, PCI_CLASS_DEVICE, &x) &&
+		if ((!o->read(&bus, dev.devfn, PCI_CLASS_DEVICE, 2, &x) &&
 		     (x == PCI_CLASS_BRIDGE_HOST || x == PCI_CLASS_DISPLAY_VGA)) ||
-		    (!o->read_word(&dev, PCI_VENDOR_ID, &x) &&
+		    (!o->read(&bus, dev.devfn, PCI_VENDOR_ID, 2, &x) &&
 		     (x == PCI_VENDOR_ID_INTEL || x == PCI_VENDOR_ID_COMPAQ)))
 			return 1;
 	DBG("PCI: Sanity check failed\n");
 	return 0;
 }
 
-static struct pci_ops * __devinit pci_check_direct(void)
+static int __init pci_direct_init(void)
 {
 	unsigned int tmp;
 	unsigned long flags;
@@ -321,8 +233,10 @@
 			local_irq_restore(flags);
 			printk(KERN_INFO "PCI: Using configuration type 1\n");
 			if (!request_region(0xCF8, 8, "PCI conf1"))
-				return NULL;
-			return &pci_direct_conf1;
+				pci_root_ops = NULL;
+			else
+				pci_root_ops = &pci_direct_conf1;
+			return 0;
 		}
 		outl (tmp, 0xCF8);
 	}
@@ -339,28 +253,15 @@
 			local_irq_restore(flags);
 			printk(KERN_INFO "PCI: Using configuration type 2\n");
 			if (!request_region(0xCF8, 4, "PCI conf2"))
-				return NULL;
-			return &pci_direct_conf2;
+				pci_root_ops = NULL;
+			else
+				pci_root_ops = &pci_direct_conf2;
+			return 0;
 		}
 	}
 
 	local_irq_restore(flags);
-	return NULL;
-}
-
-static int __init pci_direct_init(void)
-{
-	if ((pci_probe & (PCI_PROBE_CONF1 | PCI_PROBE_CONF2)) 
-		&& (pci_root_ops = pci_check_direct())) {
-		if (pci_root_ops == &pci_direct_conf1) {
-			pci_config_read = pci_conf1_read;
-			pci_config_write = pci_conf1_write;
-		}
-		else {
-			pci_config_read = pci_conf2_read;
-			pci_config_write = pci_conf2_write;
-		}
-	}
+	pci_root_ops = NULL;
 	return 0;
 }
 
