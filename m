Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318873AbSG1BC6>; Sat, 27 Jul 2002 21:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318874AbSG1BC6>; Sat, 27 Jul 2002 21:02:58 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23302 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S318873AbSG1BC4>; Sat, 27 Jul 2002 21:02:56 -0400
Subject: PATCH: 2.5.29 Fix cmd640 config locking
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Sun, 28 Jul 2002 01:52:14 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17YcIA-0002NK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We use the pci host lock so that we lock config space portably while
handling the CMD640 config space via our own routines to avoid pci bios
tripping CMD640 hardware stuff. We need to use this lock in order to 
ensure that we lock at a portable layer. Also add the 2.4.19 fixes for
avoiding wrong probes, and the fix noted on the list.

diff -u --exclude-from /usr/src/exclude --new-file --recursive linux-2.5.29/drivers/ide/cmd640.c linux-2.5.29-ac1/drivers/ide/cmd640.c
--- linux-2.5.29/drivers/ide/cmd640.c	2002-07-27 15:33:52.000000000 +0100
+++ linux-2.5.29-ac1/drivers/ide/cmd640.c	2002-07-28 00:24:30.000000000 +0100
@@ -109,6 +109,7 @@
 #include <linux/init.h>
 #include <linux/hdreg.h>
 #include <linux/ide.h>
+#include <linux/pci.h>
 
 #include <asm/io.h>
 
@@ -214,19 +215,16 @@
  * Therefore, we must use direct IO instead.
  */
 
-/* This is broken, but no more so than the old code.. */
-static spinlock_t cmd640_lock = SPIN_LOCK_UNLOCKED;
-
 /* PCI method 1 access */
 
 static void put_cmd640_reg_pci1 (unsigned short reg, u8 val)
 {
 	unsigned long flags;
-
-	spin_lock_irqsave(&cmd640_lock, flags);
-	outl_p((reg & 0xfc) | cmd640_key, 0xcf8);
+	
+	spin_lock_irqsave(&pci_lock, flags);
+	outb_p((reg & 0xfc) | cmd640_key, 0xcf8);
 	outb_p(val, (reg & 3) | 0xcfc);
-	spin_unlock_irqrestore(&cmd640_lock, flags);
+	spin_unlock_irqrestore(&pci_lock, flags);
 }
 
 static u8 get_cmd640_reg_pci1 (unsigned short reg)
@@ -234,10 +232,10 @@
 	u8 b;
 	unsigned long flags;
 
-	spin_lock_irqsave(&cmd640_lock, flags);
-	outl_p((reg & 0xfc) | cmd640_key, 0xcf8);
-	b = inb_p((reg & 3) | 0xcfc);
-	spin_unlock_irqrestore(&cmd640_lock, flags);
+	spin_lock_irqsave(&pci_lock, flags);
+	outb_p((reg & 0xfc) | cmd640_key, 0xcf8);
+	b=inb_p((reg & 3) | 0xcfc);
+	spin_unlock_irqrestore(&pci_lock, flags);
 	return b;
 }
 
@@ -247,11 +245,11 @@
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&cmd640_lock, flags);
+	spin_lock_irqsave(&pci_lock, flags);
 	outb_p(0x10, 0xcf8);
 	outb_p(val, cmd640_key + reg);
 	outb_p(0, 0xcf8);
-	spin_unlock_irqrestore(&cmd640_lock, flags);
+	spin_unlock_irqrestore(&pci_lock, flags);
 }
 
 static u8 get_cmd640_reg_pci2 (unsigned short reg)
@@ -259,11 +257,11 @@
 	u8 b;
 	unsigned long flags;
 
-	spin_lock_irqsave(&cmd640_lock, flags);
+	spin_lock_irqsave(&pci_lock, flags);
 	outb_p(0x10, 0xcf8);
 	b = inb_p(cmd640_key + reg);
 	outb_p(0, 0xcf8);
-	spin_unlock_irqrestore(&cmd640_lock, flags);
+	spin_unlock_irqrestore(&pci_lock, flags);
 	return b;
 }
 
@@ -574,7 +572,7 @@
 	/*
 	 * Now that everything is ready, program the new timings
 	 */
-	spin_lock(&cmd640_lock, flags);
+	spin_lock_irqsave(&cmd640_lock, flags);
 	/*
 	 * Program the address_setup clocks into ARTTIM reg,
 	 * and then the active/recovery counts into the DRWTIM reg
@@ -695,9 +693,61 @@
 
 #endif
 
+/**
+ *	pci_conf1	-	check for PCI type 1 configuration
+ *	
+ *	Issues a safe probe sequence for PCI configuration type 1 and
+ *	returns non-zero if conf1 is supported. Takes the pci_config lock
+ */
+ 
+static int pci_conf1(void)
+{
+	u32 tmp;
+	unsigned long flags;
+	
+	spin_lock_irqsave(&pci_lock, flags);
+
+	OUT_BYTE(0x01, 0xCFB);
+	tmp = inl(0xCF8);
+	outl(0x80000000, 0xCF8);
+	if (inl(0xCF8) == 0x80000000) {
+		spin_unlock_irqrestore(&pci_lock, flags);
+		outl(tmp, 0xCF8);
+		return 1;
+	}
+	outl(tmp, 0xCF8);
+	spin_unlock_irqrestore(&pci_lock, flags);
+	return 0;
+}
+
+/**
+ *	pci_conf2	-	check for PCI type 2 configuration
+ *	
+ *	Issues a safe probe sequence for PCI configuration type 2 and
+ *	returns non-zero if conf2 is supported. Takes the pci_config lock.
+ */
+ 
+
+static int pci_conf2(void)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&pci_lock, flags);
+	
+	OUT_BYTE(0x00, 0xCFB);
+	OUT_BYTE(0x00, 0xCF8);
+	OUT_BYTE(0x00, 0xCFA);
+	if (IN_BYTE(0xCF8) == 0x00 && IN_BYTE(0xCFA) == 0x00) {
+		spin_unlock_irqrestore(&pci_lock, flags);
+		return 1;
+	}
+	spin_unlock_irqrestore(&pci_lock, flags);
+	return 0;
+}
+
 /*
  * Probe for a cmd640 chipset, and initialize it if found.  Called from ide.c
  */
+
 int __init ide_probe_for_cmd640x(void)
 {
 #ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
@@ -712,9 +762,9 @@
 		bus_type = "VLB";
 	} else {
 		cmd640_vlb = 0;
-		if (probe_for_cmd640_pci1())
+		if (pci_conf1() && probe_for_cmd640_pci1())
 			bus_type = "PCI (type1)";
-		else if (probe_for_cmd640_pci2())
+		else if (pci_conf2() && probe_for_cmd640_pci2())
 			bus_type = "PCI (type2)";
 		else
 			return 0;
diff -u --exclude-from /usr/src/exclude --new-file --recursive linux-2.5.29/drivers/pci/access.c linux-2.5.29-ac1/drivers/pci/access.c
--- linux-2.5.29/drivers/pci/access.c	2002-07-20 20:12:30.000000000 +0100
+++ linux-2.5.29-ac1/drivers/pci/access.c	2002-07-27 15:38:49.000000000 +0100
@@ -7,7 +7,7 @@
  * configuration space.
  */
 
-static spinlock_t pci_lock = SPIN_LOCK_UNLOCKED;
+spinlock_t pci_lock = SPIN_LOCK_UNLOCKED;
 
 /*
  *  Wrappers for all PCI configuration access functions.  They just check
@@ -44,3 +44,4 @@
 EXPORT_SYMBOL(pci_write_config_byte);
 EXPORT_SYMBOL(pci_write_config_word);
 EXPORT_SYMBOL(pci_write_config_dword);
+EXPORT_SYMBOL(pci_lock);
diff -u --exclude-from /usr/src/exclude --new-file --recursive linux-2.5.29/include/linux/pci.h linux-2.5.29-ac1/include/linux/pci.h
--- linux-2.5.29/include/linux/pci.h	2002-07-27 15:32:57.000000000 +0100
+++ linux-2.5.29-ac1/include/linux/pci.h	2002-07-27 15:38:14.000000000 +0100
@@ -567,6 +567,8 @@
 int pci_write_config_word(struct pci_dev *dev, int where, u16 val);
 int pci_write_config_dword(struct pci_dev *dev, int where, u32 val);
 
+extern spinlock_t pci_lock;
+
 int pci_enable_device(struct pci_dev *dev);
 void pci_disable_device(struct pci_dev *dev);
 void pci_set_master(struct pci_dev *dev);
