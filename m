Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317582AbSH3WFc>; Fri, 30 Aug 2002 18:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317592AbSH3WFc>; Fri, 30 Aug 2002 18:05:32 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:29715 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317582AbSH3WFX>;
	Fri, 30 Aug 2002 18:05:23 -0400
Date: Fri, 30 Aug 2002 15:08:47 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] PCI ops cleanups for 2.5.32-bk
Message-ID: <20020830220846.GB10783@kroah.com>
References: <20020830220720.GA10783@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020830220720.GA10783@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And here are the different patches in this set of changesets...


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.542   -> 1.543  
#	arch/i386/pci/pcbios.c	1.9     -> 1.10   
#	arch/i386/pci/direct.c	1.9     -> 1.10   
#	arch/i386/pci/common.c	1.32    -> 1.33   
#	include/asm-i386/pci.h	1.15    -> 1.16   
#	 include/linux/pci.h	1.35    -> 1.36   
#	drivers/pci/access.c	1.3     -> 1.4    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/30	colpatch@us.ibm.com	1.543
# [PATCH] PCI Cleanup
# 
# The patch removes the pci_confN_(read|write)_config_(byte|word|dword) mess and
# pares it down to pci_confN_(read|write).  This change is reflected in the
# pci_ops structure, which only has read and write function pointers rather than
# the byte, word, and dword versions.  These changes happen in the pci_conf(1|2)
# and pci_bios read and write calls.
# 
# This patch also removes the pci_config_(read|write) function pointers.  People
# shouldn't be using these (I don't think) and should be using the pci_ops
# structure linked through the pci_dev structure.  These end up calling the same
# functions that the pci_config_(read|write) pointers refer to anyway.
# --------------------------------------------
#
diff -Nru a/arch/i386/pci/common.c b/arch/i386/pci/common.c
--- a/arch/i386/pci/common.c	Fri Aug 30 15:00:39 2002
+++ b/arch/i386/pci/common.c	Fri Aug 30 15:00:39 2002
@@ -25,9 +25,6 @@
 struct pci_bus *pci_root_bus = NULL;
 struct pci_ops *pci_root_ops = NULL;
 
-int (*pci_config_read)(int seg, int bus, int dev, int fn, int reg, int len, u32 *value) = NULL;
-int (*pci_config_write)(int seg, int bus, int dev, int fn, int reg, int len, u32 value) = NULL;
-
 /*
  * legacy, numa, and acpi all want to call pcibios_scan_root
  * from their initcalls. This flag prevents that.
diff -Nru a/arch/i386/pci/direct.c b/arch/i386/pci/direct.c
--- a/arch/i386/pci/direct.c	Fri Aug 30 15:00:39 2002
+++ b/arch/i386/pci/direct.c	Fri Aug 30 15:00:39 2002
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
+static int pci_conf1_read(struct pci_dev *dev, int where, int size, u32 *value)
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
+	return __pci_conf1_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
+		PCI_FUNC(dev->devfn), where, size, value);
 }
 
-static int pci_conf1_read_config_word(struct pci_dev *dev, int where, u16 *value)
+static int pci_conf1_write(struct pci_dev *dev, int where, int size, u32 value)
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
+	return __pci_conf1_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
+		PCI_FUNC(dev->devfn), where, size, value);
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
+static int pci_conf2_read(struct pci_dev *dev, int where, int size, u32 *value)
 {
-	return pci_conf2_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, 1, value);
+	return __pci_conf2_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
+		PCI_FUNC(dev->devfn), where, size, value);
 }
 
-static int pci_conf2_write_config_word(struct pci_dev *dev, int where, u16 value)
+static int pci_conf2_write(struct pci_dev *dev, int where, int size, u32 value)
 {
-	return pci_conf2_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, 2, value);
-}
-
-static int pci_conf2_write_config_dword(struct pci_dev *dev, int where, u32 value)
-{
-	return pci_conf2_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, 4, value);
+	return __pci_conf2_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
+		PCI_FUNC(dev->devfn), where, size, value);
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
+		if ((!o->read(&dev, PCI_CLASS_DEVICE, 2, &x) &&
 		     (x == PCI_CLASS_BRIDGE_HOST || x == PCI_CLASS_DISPLAY_VGA)) ||
-		    (!o->read_word(&dev, PCI_VENDOR_ID, &x) &&
+		    (!o->read(&dev, PCI_VENDOR_ID, 2, &x) &&
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
 
diff -Nru a/arch/i386/pci/pcbios.c b/arch/i386/pci/pcbios.c
--- a/arch/i386/pci/pcbios.c	Fri Aug 30 15:00:39 2002
+++ b/arch/i386/pci/pcbios.c	Fri Aug 30 15:00:39 2002
@@ -185,7 +185,7 @@
 	return (int) (ret & 0xff00) >> 8;
 }
 
-static int pci_bios_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
+static int __pci_bios_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
 {
 	unsigned long result = 0;
 	unsigned long flags;
@@ -240,7 +240,7 @@
 	return (int)((result & 0xff00) >> 8);
 }
 
-static int pci_bios_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
+static int __pci_bios_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
 {
 	unsigned long result = 0;
 	unsigned long flags;
@@ -295,63 +295,16 @@
 	return (int)((result & 0xff00) >> 8);
 }
 
-static int pci_bios_read_config_byte(struct pci_dev *dev, int where, u8 *value)
+static int pci_bios_read(struct pci_dev *dev, int where, int size, u32 *value)
 {
-	int result; 
-	u32 data;
-
-	if (!value) 
-		return -EINVAL;
-
-	result = pci_bios_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, 1, &data);
-
-	*value = (u8)data;
-
-	return result;
-}
-
-static int pci_bios_read_config_word(struct pci_dev *dev, int where, u16 *value)
-{
-	int result; 
-	u32 data;
-
-	if (!value) 
-		return -EINVAL;
-
-	result = pci_bios_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, 2, &data);
-
-	*value = (u16)data;
-
-	return result;
-}
-
-static int pci_bios_read_config_dword(struct pci_dev *dev, int where, u32 *value)
-{
-	if (!value) 
-		return -EINVAL;
-	
-	return pci_bios_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, 4, value);
-}
-
-static int pci_bios_write_config_byte(struct pci_dev *dev, int where, u8 value)
-{
-	return pci_bios_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, 1, value);
-}
-
-static int pci_bios_write_config_word(struct pci_dev *dev, int where, u16 value)
-{
-	return pci_bios_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, 2, value);
+	return __pci_bios_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
+		PCI_FUNC(dev->devfn), where, size, value);
 }
 
-static int pci_bios_write_config_dword(struct pci_dev *dev, int where, u32 value)
+static int pci_bios_write(struct pci_dev *dev, int where, int size, u32 value)
 {
-	return pci_bios_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, 4, value);
+	return __pci_bios_write(0, dev->bus->number, PCI_SLOT(dev->devfn),
+		PCI_FUNC(dev->devfn), where, size, value);
 }
 
 
@@ -360,12 +313,8 @@
  */
 
 static struct pci_ops pci_bios_access = {
-      pci_bios_read_config_byte,
-      pci_bios_read_config_word,
-      pci_bios_read_config_dword,
-      pci_bios_write_config_byte,
-      pci_bios_write_config_word,
-      pci_bios_write_config_dword
+	.read =		pci_bios_read,
+	.write =	pci_bios_write
 };
 
 /*
@@ -551,8 +500,6 @@
 		&& ((pci_root_ops = pci_find_bios()))) {
 		pci_probe |= PCI_BIOS_SORT;
 		pci_bios_present = 1;
-		pci_config_read = pci_bios_read;
-		pci_config_write = pci_bios_write;
 	}
 	return 0;
 }
diff -Nru a/drivers/pci/access.c b/drivers/pci/access.c
--- a/drivers/pci/access.c	Fri Aug 30 15:00:39 2002
+++ b/drivers/pci/access.c	Fri Aug 30 15:00:39 2002
@@ -19,24 +19,38 @@
 #define PCI_word_BAD (pos & 1)
 #define PCI_dword_BAD (pos & 3)
 
-#define PCI_OP(rw,size,type) \
-int pci_##rw##_config_##size (struct pci_dev *dev, int pos, type value) \
+#define PCI_OP_READ(size,type,len) \
+int pci_read_config_##size (struct pci_dev *dev, int pos, type *value) \
 {									\
 	int res;							\
 	unsigned long flags;						\
+	u32 data = 0;							\
 	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
 	spin_lock_irqsave(&pci_lock, flags);				\
-	res = dev->bus->ops->rw##_##size(dev, pos, value);		\
+	res = dev->bus->ops->read(dev, pos, len, &data);		\
+	*value = (type)data;						\
 	spin_unlock_irqrestore(&pci_lock, flags);			\
 	return res;							\
 }
 
-PCI_OP(read, byte, u8 *)
-PCI_OP(read, word, u16 *)
-PCI_OP(read, dword, u32 *)
-PCI_OP(write, byte, u8)
-PCI_OP(write, word, u16)
-PCI_OP(write, dword, u32)
+#define PCI_OP_WRITE(size,type,len) \
+int pci_write_config_##size (struct pci_dev *dev, int pos, type value) \
+{									\
+	int res;							\
+	unsigned long flags;						\
+	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
+	spin_lock_irqsave(&pci_lock, flags);				\
+	res = dev->bus->ops->write(dev, pos, len, value);		\
+	spin_unlock_irqrestore(&pci_lock, flags);			\
+	return res;							\
+}
+
+PCI_OP_READ(byte, u8, 1)
+PCI_OP_READ(word, u16, 2)
+PCI_OP_READ(dword, u32, 4)
+PCI_OP_WRITE(byte, u8, 1)
+PCI_OP_WRITE(word, u16, 2)
+PCI_OP_WRITE(dword, u32, 4)
 
 EXPORT_SYMBOL(pci_read_config_byte);
 EXPORT_SYMBOL(pci_read_config_word);
diff -Nru a/include/asm-i386/pci.h b/include/asm-i386/pci.h
--- a/include/asm-i386/pci.h	Fri Aug 30 15:00:39 2002
+++ b/include/asm-i386/pci.h	Fri Aug 30 15:00:39 2002
@@ -22,8 +22,6 @@
 
 void pcibios_config_init(void);
 struct pci_bus * pcibios_scan_root(int bus);
-extern int (*pci_config_read)(int seg, int bus, int dev, int fn, int reg, int len, u32 *value);
-extern int (*pci_config_write)(int seg, int bus, int dev, int fn, int reg, int len, u32 value);
 
 void pcibios_set_master(struct pci_dev *dev);
 void pcibios_penalize_isa_irq(int irq);
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Fri Aug 30 15:00:39 2002
+++ b/include/linux/pci.h	Fri Aug 30 15:00:39 2002
@@ -456,12 +456,8 @@
 /* Low-level architecture-dependent routines */
 
 struct pci_ops {
-	int (*read_byte)(struct pci_dev *, int where, u8 *val);
-	int (*read_word)(struct pci_dev *, int where, u16 *val);
-	int (*read_dword)(struct pci_dev *, int where, u32 *val);
-	int (*write_byte)(struct pci_dev *, int where, u8 val);
-	int (*write_word)(struct pci_dev *, int where, u16 val);
-	int (*write_dword)(struct pci_dev *, int where, u32 val);
+	int (*read)(struct pci_dev *, int where, int size, u32 *val);
+	int (*write)(struct pci_dev *, int where, int size, u32 val);
 };
 
 struct pbus_set_ranges_data
