Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317698AbSH3WJZ>; Fri, 30 Aug 2002 18:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317642AbSH3WIP>; Fri, 30 Aug 2002 18:08:15 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:32275 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317637AbSH3WHp>;
	Fri, 30 Aug 2002 18:07:45 -0400
Date: Fri, 30 Aug 2002 15:11:08 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] PCI ops cleanups for 2.5.32-bk
Message-ID: <20020830221107.GG10783@kroah.com>
References: <20020830220720.GA10783@kroah.com> <20020830220846.GB10783@kroah.com> <20020830220912.GC10783@kroah.com> <20020830220931.GD10783@kroah.com> <20020830221017.GE10783@kroah.com> <20020830221044.GF10783@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020830221044.GF10783@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.547   -> 1.548  
#	arch/ia64/sn/io/pci.c	1.3     -> 1.4    
#	arch/ia64/kernel/pci.c	1.14    -> 1.15   
#	include/asm-ia64/pci.h	1.10    -> 1.11   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/30	hannal@us.ibm.com	1.548
# [PATCH] PCI: ia64 pci_ops changes
# 
# ia64 pci ops changes
# --------------------------------------------
#
diff -Nru a/arch/ia64/kernel/pci.c b/arch/ia64/kernel/pci.c
--- a/arch/ia64/kernel/pci.c	Fri Aug 30 15:00:24 2002
+++ b/arch/ia64/kernel/pci.c	Fri Aug 30 15:00:24 2002
@@ -46,9 +46,6 @@
 
 struct pci_ops *pci_root_ops;
 
-int (*pci_config_read)(int seg, int bus, int dev, int fn, int reg, int len, u32 *value);
-int (*pci_config_write)(int seg, int bus, int dev, int fn, int reg, int len, u32 value);
-
 
 /*
  * Low-level SAL-based PCI configuration access functions. Note that SAL
@@ -60,7 +57,7 @@
 	((u64)(bus << 16) | (u64)(dev << 11) | (u64)(fn << 8) | (u64)(reg))
 
 static int
-pci_sal_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
+__pci_sal_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
 {
 	int result = 0;
 	u64 data = 0;
@@ -76,7 +73,7 @@
 }
 
 static int
-pci_sal_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
+__pci_sal_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
 {
 	if ((bus > 255) || (dev > 31) || (fn > 7) || (reg > 255))
 		return -EINVAL;
@@ -86,77 +83,22 @@
 
 
 static int
-pci_sal_read_config_byte (struct pci_dev *dev, int where, u8 *value)
-{
-	int result = 0;
-	u32 data = 0;
-
-	if (!value)
-		return -EINVAL;
-
-	result = pci_sal_read(0, dev->bus->number, PCI_SLOT(dev->devfn),
-			      PCI_FUNC(dev->devfn), where, 1, &data);
-
-	*value = (u8) data;
-
-	return result;
-}
-
-static int
-pci_sal_read_config_word (struct pci_dev *dev, int where, u16 *value)
-{
-	int result = 0;
-	u32 data = 0;
-
-	if (!value)
-		return -EINVAL;
-
-	result = pci_sal_read(0, dev->bus->number, PCI_SLOT(dev->devfn),
-			      PCI_FUNC(dev->devfn), where, 2, &data);
-
-	*value = (u16) data;
-
-	return result;
-}
-
-static int
-pci_sal_read_config_dword (struct pci_dev *dev, int where, u32 *value)
-{
-	if (!value)
-		return -EINVAL;
-
-	return pci_sal_read(0, dev->bus->number, PCI_SLOT(dev->devfn),
-			    PCI_FUNC(dev->devfn), where, 4, value);
-}
-
-static int
-pci_sal_write_config_byte (struct pci_dev *dev, int where, u8 value)
-{
-	return pci_sal_write(0, dev->bus->number, PCI_SLOT(dev->devfn),
-			     PCI_FUNC(dev->devfn), where, 1, value);
-}
-
-static int
-pci_sal_write_config_word (struct pci_dev *dev, int where, u16 value)
+pci_sal_read (struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *value)
 {
-	return pci_sal_write(0, dev->bus->number, PCI_SLOT(dev->devfn),
-			     PCI_FUNC(dev->devfn), where, 2, value);
+	return __pci_sal_read(0, bus->number, PCI_SLOT(devfn),
+			    PCI_FUNC(devfn), where, size, value);
 }
 
 static int
-pci_sal_write_config_dword (struct pci_dev *dev, int where, u32 value)
+pci_sal_write (struct pci_bus *bus, unsigned int devfn, int where, int size, u32 value)
 {
-	return pci_sal_write(0, dev->bus->number, PCI_SLOT(dev->devfn),
-			     PCI_FUNC(dev->devfn), where, 4, value);
+	return __pci_sal_write(0, bus->number, PCI_SLOT(devfn),
+			     PCI_FUNC(devfn), where, size, value);
 }
 
 struct pci_ops pci_sal_ops = {
-	pci_sal_read_config_byte,
-	pci_sal_read_config_word,
-	pci_sal_read_config_dword,
-	pci_sal_write_config_byte,
-	pci_sal_write_config_word,
-	pci_sal_write_config_dword
+	.read = 	pci_sal_read,
+	.write =	pci_sal_write,
 };
 
 
@@ -193,8 +135,6 @@
 	printk("PCI: Using SAL to access configuration space\n");
 
 	pci_root_ops = &pci_sal_ops;
-	pci_config_read = pci_sal_read;
-	pci_config_write = pci_sal_write;
 
 	return;
 }
diff -Nru a/arch/ia64/sn/io/pci.c b/arch/ia64/sn/io/pci.c
--- a/arch/ia64/sn/io/pci.c	Fri Aug 30 15:00:24 2002
+++ b/arch/ia64/sn/io/pci.c	Fri Aug 30 15:00:24 2002
@@ -44,22 +44,21 @@
 extern devfs_handle_t devfn_to_vertex(unsigned char bus, unsigned char devfn);
 
 /*
- * snia64_read_config_byte - Read a byte from the config area of the device.
+ * snia64_read - Read from the config area of the device.
  */
-static int snia64_read_config_byte (struct pci_dev *dev,
-                                   int where, unsigned char *val)
+static int snia64_read (struct pci_bus *bus, unsigned char devfn,
+                                   int where, int size, unsigned char *val)
 {
 	unsigned long res = 0;
-	unsigned size = 1;
 	devfs_handle_t device_vertex;
 
-	if ( (dev == (struct pci_dev *)0) || (val == (unsigned char *)0) ) {
+	if ( (bus == NULL) || (val == (unsigned char *)0) ) {
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
-	device_vertex = devfn_to_vertex(dev->bus->number, dev->devfn);
+	device_vertex = devfn_to_vertex(bus->number, devfn);
 	if (!device_vertex) {
 		DBG("%s : nonexistent device: bus= 0x%x  slot= 0x%x  func= 0x%x\n", 
-		__FUNCTION__, dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
+		__FUNCTION__, bus->number, PCI_SLOT(devfn), PCI_FUNC(devfn));
 		return(-1);
 	}
 	res = pciio_config_get(device_vertex, (unsigned) where, size);
@@ -68,160 +67,40 @@
 }
 
 /*
- * snia64_read_config_word - Read 2 bytes from the config area of the device.
+ * snia64_write - Writes to the config area of the device.
  */
-static int snia64_read_config_word (struct pci_dev *dev,
-                                   int where, unsigned short *val)
+static int snia64_write (struct pci_bus *bus, unsigned char devfn,
+                                    int where, int size, unsigned char val)
 {
-	unsigned long res = 0;
-	unsigned size = 2; /* 2 bytes */
-	devfs_handle_t device_vertex;
-
-	if ( (dev == (struct pci_dev *)0) || (val == (unsigned short *)0) ) {
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
-	device_vertex = devfn_to_vertex(dev->bus->number, dev->devfn);
-	if (!device_vertex) {
-		DBG("%s : nonexistent device: bus= 0x%x  slot= 0x%x  func= 0x%x\n", 
-		__FUNCTION__, dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
-		return(-1);
-	}
-	res = pciio_config_get(device_vertex, (unsigned) where, size);
-	*val = (unsigned short) res;
-	return PCIBIOS_SUCCESSFUL;
-}
-
-/*
- * snia64_read_config_dword - Read 4 bytes from the config area of the device.
- */
-static int snia64_read_config_dword (struct pci_dev *dev,
-                                    int where, unsigned int *val)
-{
-	unsigned long res = 0;
-	unsigned size = 4; /* 4 bytes */
 	devfs_handle_t device_vertex;
 
-	if (where & 3) {
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-	}
-	if ( (dev == (struct pci_dev *)0) || (val == (unsigned int *)0) ) {
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
-
-	device_vertex = devfn_to_vertex(dev->bus->number, dev->devfn);
-	if (!device_vertex) {
-		DBG("%s : nonexistent device: bus= 0x%x  slot= 0x%x  func= 0x%x\n", 
-		__FUNCTION__, dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
-		return(-1);
-	}
-	res = pciio_config_get(device_vertex, (unsigned) where, size);
-	*val = (unsigned int) res;
-	return PCIBIOS_SUCCESSFUL;
-}
-
-/*
- * snia64_write_config_byte - Writes 1 byte to the config area of the device.
- */
-static int snia64_write_config_byte (struct pci_dev *dev,
-                                    int where, unsigned char val)
-{
-	devfs_handle_t device_vertex;
-
-	if ( dev == (struct pci_dev *)0 ) {
+	if ( bus == NULL) {
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 	/* 
 	 * if it's an IOC3 then we bail out, we special
 	 * case them with pci_fixup_ioc3
 	 */
-	if (dev->vendor == PCI_VENDOR_ID_SGI && 
+	/* Starting 2.5.32 struct pci_dev is not passed down */
+	/*if (dev->vendor == PCI_VENDOR_ID_SGI && 
 	    dev->device == PCI_DEVICE_ID_SGI_IOC3 )
 		return PCIBIOS_SUCCESSFUL;
+	*/
 
-	device_vertex = devfn_to_vertex(dev->bus->number, dev->devfn);
-	if (!device_vertex) {
-		DBG("%s : nonexistent device: bus= 0x%x  slot= 0x%x  func= 0x%x\n", 
-		__FUNCTION__, dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
-		return(-1);
-	}
-	pciio_config_set( device_vertex, (unsigned)where, 1, (uint64_t) val);
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-/*
- * snia64_write_config_word - Writes 2 bytes to the config area of the device.
- */
-static int snia64_write_config_word (struct pci_dev *dev,
-                                    int where, unsigned short val)
-{
-	devfs_handle_t device_vertex = NULL;
-
-	if (where & 1) {
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-	}
-	if ( dev == (struct pci_dev *)0 ) {
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
-	/* 
-	 * if it's an IOC3 then we bail out, we special
-	 * case them with pci_fixup_ioc3
-	 */
-	if (dev->vendor == PCI_VENDOR_ID_SGI && 
-	    dev->device == PCI_DEVICE_ID_SGI_IOC3)
-		return PCIBIOS_SUCCESSFUL;
-
-	device_vertex = devfn_to_vertex(dev->bus->number, dev->devfn);
-	if (!device_vertex) {
-		DBG("%s : nonexistent device: bus= 0x%x  slot= 0x%x  func= 0x%x\n", 
-		__FUNCTION__, dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
-		return(-1);
-	}
-	pciio_config_set( device_vertex, (unsigned)where, 2, (uint64_t) val);
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-/*
- * snia64_write_config_dword - Writes 4 bytes to the config area of the device.
- */
-static int snia64_write_config_dword (struct pci_dev *dev,
-                                     int where, unsigned int val)
-{
-	devfs_handle_t device_vertex;
-
-	if (where & 3) {
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-	}
-	if ( dev == (struct pci_dev *)0 ) {
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
-	/* 
-	 * if it's an IOC3 then we bail out, we special
-	 * case them with pci_fixup_ioc3
-	 */
-	if (dev->vendor == PCI_VENDOR_ID_SGI && 
-	    dev->device == PCI_DEVICE_ID_SGI_IOC3)
-		return PCIBIOS_SUCCESSFUL;
-
-	device_vertex = devfn_to_vertex(dev->bus->number, dev->devfn);
+	device_vertex = devfn_to_vertex(bus->number, devfn);
 	if (!device_vertex) {
 		DBG("%s : nonexistent device: bus= 0x%x  slot= 0x%x  func= 0x%x\n", 
-		__FUNCTION__, dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
+		__FUNCTION__, bus->number, PCI_SLOT(devfn), PCI_FUNC(devfn));
 		return(-1);
 	}
-	pciio_config_set( device_vertex, (unsigned)where, 4, (uint64_t) val);
+	pciio_config_set( device_vertex, (unsigned)where, size, (uint64_t) val);
 
 	return PCIBIOS_SUCCESSFUL;
 }
 
 static struct pci_ops snia64_pci_ops = {
-	snia64_read_config_byte,
-	snia64_read_config_word,
-	snia64_read_config_dword,
-	snia64_write_config_byte,
-	snia64_write_config_word,
-	snia64_write_config_dword
+	.read =		snia64_read,
+	.write = 	snia64_write,
 };
 
 /*
diff -Nru a/include/asm-ia64/pci.h b/include/asm-ia64/pci.h
--- a/include/asm-ia64/pci.h	Fri Aug 30 15:00:24 2002
+++ b/include/asm-ia64/pci.h	Fri Aug 30 15:00:24 2002
@@ -22,8 +22,6 @@
 
 void pcibios_config_init(void);
 struct pci_bus * pcibios_scan_root(int bus);
-extern int (*pci_config_read)(int seg, int bus, int dev, int fn, int reg, int len, u32 *value);
-extern int (*pci_config_write)(int seg, int bus, int dev, int fn, int reg, int len, u32 value);
 
 struct pci_dev;
 
