Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315946AbSHTRvQ>; Tue, 20 Aug 2002 13:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316204AbSHTRvQ>; Tue, 20 Aug 2002 13:51:16 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:58094 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315946AbSHTRvN>;
	Tue, 20 Aug 2002 13:51:13 -0400
Date: Tue, 20 Aug 2002 10:58:35 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: gregkh@us.ibm.com, greg@kroah.com
cc: Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: PCI Cleanup
Message-ID: <36220000.1029866315@w-hlinder>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is the ia64 port of Mat Dobson's PCI Cleanup
changes (changed again by Greg KH subtly) to support
the new pci_ops structure. This will apply cleanly
to bk://linuxusb.bkbits.net/pci_hp-2.5.

I have not compiled or run this code. The most recent
ia64 port for 2.5 is 2.5.18 if there is one for 2.5.31
please let me know. Otherwise, if there are any problems
let me know and I will be happy to resubmit.

Hanna Linder
hannal@us.ibm.com


---------
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.556   -> 1.557  
#	arch/ia64/kernel/pci.c	1.14    -> 1.15   
#	include/asm-ia64/pci.h	1.10    -> 1.11   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/19	hlinder@w-hlinder.beaverton.ibm.com	1.557
# Combination of ia64 port of pci_ops changes.
# --------------------------------------------
#
diff -Nru a/arch/ia64/kernel/pci.c b/arch/ia64/kernel/pci.c
--- a/arch/ia64/kernel/pci.c	Tue Aug 20 10:49:06 2002
+++ b/arch/ia64/kernel/pci.c	Tue Aug 20 10:49:06 2002
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
diff -Nru a/include/asm-ia64/pci.h b/include/asm-ia64/pci.h
--- a/include/asm-ia64/pci.h	Tue Aug 20 10:49:06 2002
+++ b/include/asm-ia64/pci.h	Tue Aug 20 10:49:06 2002
@@ -22,8 +22,6 @@
 
 void pcibios_config_init(void);
 struct pci_bus * pcibios_scan_root(int bus);
-extern int (*pci_config_read)(int seg, int bus, int dev, int fn, int reg, int len, u32 *value);
-extern int (*pci_config_write)(int seg, int bus, int dev, int fn, int reg, int len, u32 value);
 
 struct pci_dev;
 

