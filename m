Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318432AbSGYLw4>; Thu, 25 Jul 2002 07:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318433AbSGYLw4>; Thu, 25 Jul 2002 07:52:56 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:30460 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318432AbSGYLwy>; Thu, 25 Jul 2002 07:52:54 -0400
Subject: Re: [RFC/CFT] cmd640 irqlocking fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andre Hedrick <andre@linux-ide.org>, martin@dalecki.de,
       Vojtech Pavlik <vojtech@suse.cz>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1027601555.9489.57.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.10.10207250342410.4719-200000@master.linux-ide.org>
	 <1027601555.9489.57.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 25 Jul 2002 14:08:48 +0100
Message-Id: <1027602528.9488.68.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin this patch should do the job. It uses the correct pci_config_lock
and it also adds the 2.4 probe safety checks for deciding which pci
modes to use.

--- ../linux-2.5.28/drivers/ide/cmd640.c	Thu Jul 25 10:49:19 2002
+++ drivers/ide/cmd640.c	Thu Jul 25 11:41:27 2002
@@ -216,27 +216,27 @@
 
 /* PCI method 1 access */
 
-static void put_cmd640_reg_pci1 (unsigned short reg, byte val)
+extern spinlock_t pci_config_lock;
+
+static void put_cmd640_reg_pci1 (unsigned short reg, u8 val)
 {
 	unsigned long flags;
-
-	save_flags(flags);
-	cli();
-	outl_p((reg & 0xfc) | cmd640_key, 0xcf8);
+	
+	spin_lock_irqsave(&pci_config_lock, flags);
+	outb_p((reg & 0xfc) | cmd640_key, 0xcf8);
 	outb_p(val, (reg & 3) | 0xcfc);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&pci_config_lock, flags);
 }
 
 static u8 get_cmd640_reg_pci1 (unsigned short reg)
 {
 	u8 b;
 	unsigned long flags;
-
-	save_flags(flags);
-	cli();
-	outl_p((reg & 0xfc) | cmd640_key, 0xcf8);
-	b = inb_p((reg & 3) | 0xcfc);
-	restore_flags(flags);
+	
+	spin_lock_irqsave(&pci_config_lock, flags);
+	outb_p((reg & 0xfc) | cmd640_key, 0xcf8);
+	b=inb_p((reg & 3) | 0xcfc);
+	spin_unlock_irqrestore(&pci_config_lock, flags);
 	return b;
 }
 
@@ -245,26 +245,24 @@
 static void put_cmd640_reg_pci2 (unsigned short reg, u8 val)
 {
 	unsigned long flags;
-
-	save_flags(flags);
-	cli();
+	
+	spin_lock_irqsave(&pci_config_lock, flags);
 	outb_p(0x10, 0xcf8);
 	outb_p(val, cmd640_key + reg);
 	outb_p(0, 0xcf8);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&pci_config_lock, flags);
 }
 
 static u8 get_cmd640_reg_pci2 (unsigned short reg)
 {
 	u8 b;
 	unsigned long flags;
-
-	save_flags(flags);
-	cli();
+	
+	spin_lock_irqsave(&pci_config_lock, flags);
 	outb_p(0x10, 0xcf8);
 	b = inb_p(cmd640_key + reg);
 	outb_p(0, 0xcf8);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&pci_config_lock, flags);
 	return b;
 }
 
@@ -701,9 +699,62 @@
 
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
+	spin_lock_irqsave(&pci_config_lock, flags);
+
+	OUT_BYTE(0x01, 0xCFB);
+	tmp = inl(0xCF8);
+	outl(0x80000000, 0xCF8);
+	if (inl(0xCF8) == 0x80000000) {
+		spin_unlock_irqrestore(&pci_config_lock, flags);
+		outl(tmp, 0xCF8);
+		return 1;
+	}
+	outl(tmp, 0xCF8);
+	spin_unlock_irqrestore(&pci_config_lock, flags);
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
+	spin_lock_irqsave(&pci_config_lock, flags);
+	
+	OUT_BYTE(0x00, 0xCFB);
+	OUT_BYTE(0x00, 0xCF8);
+	OUT_BYTE(0x00, 0xCFA);
+	if (IN_BYTE(0xCF8) == 0x00 && IN_BYTE(0xCF8) == 0x00) {
+		spin_unlock_irqrestore(&pci_config_lock, flags);
+		return 1;
+	}
+	spin_unlock_irqrestore(&pci_config_lock, flags);
+	return 0;
+}
+
+
 /*
  * Probe for a cmd640 chipset, and initialize it if found.  Called from ide.c
  */
+ 
 int __init ide_probe_for_cmd640x(void)
 {
 #ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
@@ -718,9 +769,10 @@
 		bus_type = "VLB";
 	} else {
 		cmd640_vlb = 0;
-		if (probe_for_cmd640_pci1())
+		/* Find out what kind of PCI probing is supported */
+		if (pci_conf1() && probe_for_cmd640_pci1())
 			bus_type = "PCI (type1)";
-		else if (probe_for_cmd640_pci2())
+		else if (pci_conf2() && probe_for_cmd640_pci2())
 			bus_type = "PCI (type2)";
 		else
 			return 0;
