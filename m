Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263862AbTCUTg2>; Fri, 21 Mar 2003 14:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263875AbTCUTgE>; Fri, 21 Mar 2003 14:36:04 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:64132
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263862AbTCUTeM>; Fri, 21 Mar 2003 14:34:12 -0500
Date: Fri, 21 Mar 2003 20:49:24 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212049.h2LKnOeg026527@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix cmd640 ide locking
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/pci/cmd640.c linux-2.5.65-ac2/drivers/ide/pci/cmd640.c
--- linux-2.5.65/drivers/ide/pci/cmd640.c	2003-03-03 19:20:09.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/pci/cmd640.c	2003-03-14 00:49:44.000000000 +0000
@@ -197,8 +197,8 @@
  * Interface to access cmd640x registers
  */
 static unsigned int cmd640_key;
-static void (*put_cmd640_reg)(u16 reg, u8 val);
-static u8 (*get_cmd640_reg)(u16 reg);
+static void (*__put_cmd640_reg)(u16 reg, u8 val);
+static u8 (*__get_cmd640_reg)(u16 reg);
 
 /*
  * This is read from the CFR reg, and is used in several places.
@@ -215,49 +215,32 @@
 
 static void put_cmd640_reg_pci1 (u16 reg, u8 val)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&ide_lock, flags);
 	outb_p((reg & 0xfc) | cmd640_key, 0xcf8);
 	outb_p(val, (reg & 3) | 0xcfc);
-	spin_unlock_irqrestore(&ide_lock, flags);
 }
 
 static u8 get_cmd640_reg_pci1 (u16 reg)
 {
-	u8 b;
-	unsigned long flags;
-
-	spin_lock_irqsave(&ide_lock, flags);
 	outb_p((reg & 0xfc) | cmd640_key, 0xcf8);
-	b = inb_p((reg & 3) | 0xcfc);
-	spin_unlock_irqrestore(&ide_lock, flags);
-	return b;
+	return inb_p((reg & 3) | 0xcfc);
 }
 
 /* PCI method 2 access (from CMD datasheet) */
 
 static void put_cmd640_reg_pci2 (u16 reg, u8 val)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&ide_lock, flags);
 	outb_p(0x10, 0xcf8);
 	outb_p(val, cmd640_key + reg);
 	outb_p(0, 0xcf8);
-	spin_unlock_irqrestore(&ide_lock, flags);
 }
 
 static u8 get_cmd640_reg_pci2 (u16 reg)
 {
 	u8 b;
-	unsigned long flags;
 
-	spin_lock_irqsave(&ide_lock, flags);
 	outb_p(0x10, 0xcf8);
 	b = inb_p(cmd640_key + reg);
 	outb_p(0, 0xcf8);
-	spin_unlock_irqrestore(&ide_lock, flags);
 	return b;
 }
 
@@ -265,26 +248,36 @@
 
 static void put_cmd640_reg_vlb (u16 reg, u8 val)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&ide_lock, flags);
 	outb_p(reg, cmd640_key);
 	outb_p(val, cmd640_key + 4);
-	spin_unlock_irqrestore(&ide_lock, flags);
 }
 
 static u8 get_cmd640_reg_vlb (u16 reg)
 {
+	outb_p(reg, cmd640_key);
+	return inb_p(cmd640_key + 4);
+}
+
+static u8 get_cmd640_reg(u16 reg)
+{
 	u8 b;
 	unsigned long flags;
 
 	spin_lock_irqsave(&ide_lock, flags);
-	outb_p(reg, cmd640_key);
-	b = inb_p(cmd640_key + 4);
+	b = __get_cmd640_reg(reg);
 	spin_unlock_irqrestore(&ide_lock, flags);
 	return b;
 }
 
+static void put_cmd640_reg(u16 reg, u8 val)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ide_lock, flags);
+	__put_cmd640_reg(reg,val);
+	spin_unlock_irqrestore(&ide_lock, flags);
+}
+
 static int __init match_pci_cmd640_device (void)
 {
 	const u8 ven_dev[4] = {0x95, 0x10, 0x40, 0x06};
@@ -307,8 +300,8 @@
  */
 static int __init probe_for_cmd640_pci1 (void)
 {
-	get_cmd640_reg = get_cmd640_reg_pci1;
-	put_cmd640_reg = put_cmd640_reg_pci1;
+	__get_cmd640_reg = get_cmd640_reg_pci1;
+	__put_cmd640_reg = put_cmd640_reg_pci1;
 	for (cmd640_key = 0x80000000;
 	     cmd640_key <= 0x8000f800;
 	     cmd640_key += 0x800) {
@@ -323,8 +316,8 @@
  */
 static int __init probe_for_cmd640_pci2 (void)
 {
-	get_cmd640_reg = get_cmd640_reg_pci2;
-	put_cmd640_reg = put_cmd640_reg_pci2;
+	__get_cmd640_reg = get_cmd640_reg_pci2;
+	__put_cmd640_reg = put_cmd640_reg_pci2;
 	for (cmd640_key = 0xc000; cmd640_key <= 0xcf00; cmd640_key += 0x100) {
 		if (match_pci_cmd640_device())
 			return 1; /* success */
@@ -339,8 +332,8 @@
 {
 	u8 b;
 
-	get_cmd640_reg = get_cmd640_reg_vlb;
-	put_cmd640_reg = put_cmd640_reg_vlb;
+	__get_cmd640_reg = get_cmd640_reg_vlb;
+	__put_cmd640_reg = put_cmd640_reg_vlb;
 	cmd640_key = 0x178;
 	b = get_cmd640_reg(CFR);
 	if (b == 0xff || b == 0x00 || (b & CFR_AT_VESA_078h)) {
@@ -454,7 +447,7 @@
 	unsigned long flags;
 
 	spin_lock_irqsave(&ide_lock, flags);
-	b = get_cmd640_reg(reg);
+	b = __get_cmd640_reg(reg);
 	if (mode) {	/* want prefetch on? */
 #if CMD640_PREFETCH_MASKS
 		drive->no_unmask = 1;
@@ -468,7 +461,7 @@
 		drive->io_32bit = 0;
 		b |= prefetch_masks[index];	/* disable prefetch */
 	}
-	put_cmd640_reg(reg, b);
+	__put_cmd640_reg(reg, b);
 	spin_unlock_irqrestore(&ide_lock, flags);
 }
 
@@ -576,9 +569,9 @@
 	 * and then the active/recovery counts into the DRWTIM reg
 	 * (this converts counts of 16 into counts of zero -- okay).
 	 */
-	setup_count |= get_cmd640_reg(arttim_regs[index]) & 0x3f;
-	put_cmd640_reg(arttim_regs[index], setup_count);
-	put_cmd640_reg(drwtim_regs[index], pack_nibbles(active_count, recovery_count));
+	setup_count |= __get_cmd640_reg(arttim_regs[index]) & 0x3f;
+	__put_cmd640_reg(arttim_regs[index], setup_count);
+	__put_cmd640_reg(drwtim_regs[index], pack_nibbles(active_count, recovery_count));
 	spin_unlock_irqrestore(&ide_lock, flags);
 }
 
