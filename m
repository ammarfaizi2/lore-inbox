Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317904AbSGXWzW>; Wed, 24 Jul 2002 18:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317922AbSGXWzW>; Wed, 24 Jul 2002 18:55:22 -0400
Received: from holomorphy.com ([66.224.33.161]:19604 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317904AbSGXWzU>;
	Wed, 24 Jul 2002 18:55:20 -0400
Date: Wed, 24 Jul 2002 15:58:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC/CFT] cmd640 irqlocking fixes
Message-ID: <20020724225826.GF25038@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't have one of these, and I'm not even sure what it is. But here's
a wild guess at a fix.


Cheers,
Bill
===== drivers/ide/cmd640.c 1.11 vs edited =====
--- 1.11/drivers/ide/cmd640.c	Wed May 22 04:21:11 2002
+++ edited/drivers/ide/cmd640.c	Wed Jul 24 18:51:54 2002
@@ -115,6 +115,12 @@
 #include "ata-timing.h"
 
 /*
+ * Is this remotely correct?
+ */
+static spinlock_t cmd640_lock = SPIN_LOCK_UNLOCKED;
+
+
+/*
  * This flag is set in ide.c by the parameter:  ide0=cmd640_vlb
  */
 int cmd640_vlb = 0;
@@ -220,11 +226,10 @@
 {
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&cmd640_lock, flags);
 	outl_p((reg & 0xfc) | cmd640_key, 0xcf8);
 	outb_p(val, (reg & 3) | 0xcfc);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&cmd640_lock, flags);
 }
 
 static u8 get_cmd640_reg_pci1 (unsigned short reg)
@@ -232,11 +237,10 @@
 	u8 b;
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&cmd640_lock, flags);
 	outl_p((reg & 0xfc) | cmd640_key, 0xcf8);
 	b = inb_p((reg & 3) | 0xcfc);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&cmd640_lock, flags);
 	return b;
 }
 
@@ -246,12 +250,11 @@
 {
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&cmd640_lock, flags);
 	outb_p(0x10, 0xcf8);
 	outb_p(val, cmd640_key + reg);
 	outb_p(0, 0xcf8);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&cmd640_lock, flags);
 }
 
 static u8 get_cmd640_reg_pci2 (unsigned short reg)
@@ -259,12 +262,11 @@
 	u8 b;
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&cmd640_lock, flags);
 	outb_p(0x10, 0xcf8);
 	b = inb_p(cmd640_key + reg);
 	outb_p(0, 0xcf8);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&cmd640_lock, flags);
 	return b;
 }
 
@@ -274,11 +276,10 @@
 {
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&cmd640_lock, flags);
 	outb_p(reg, cmd640_key);
 	outb_p(val, cmd640_key + 4);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&cmd640_lock, flags);
 }
 
 static u8 get_cmd640_reg_vlb (unsigned short reg)
@@ -286,11 +287,10 @@
 	u8 b;
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&cmd640_lock, flags);
 	outb_p(reg, cmd640_key);
 	b = inb_p(cmd640_key + 4);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&cmd640_lock, flags);
 	return b;
 }
 
@@ -367,8 +367,7 @@
 {
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&cmd640_lock, flags);
 
 	outb_p(0x0a, 0x170 + IDE_SELECT_OFFSET);	/* select drive0 */
 	udelay(100);
@@ -376,11 +375,11 @@
 		outb_p(0x1a, 0x170 + IDE_SELECT_OFFSET); /* select drive1 */
 		udelay(100);
 		if ((inb_p(0x170 + IDE_SELECT_OFFSET) & 0x1f) != 0x1a) {
-			restore_flags(flags);
+			spin_unlock_irqrestore(&cmd640_lock, flags);
 			return 0; /* nothing responded */
 		}
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&cmd640_lock, flags);
 	return 1; /* success */
 }
 
@@ -461,8 +460,7 @@
 	u8 b;
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&cmd640_lock, flags);
 	b = get_cmd640_reg(reg);
 	if (mode) {	/* want prefetch on? */
 # if CMD640_PREFETCH_MASKS
@@ -478,7 +476,7 @@
 		b |= prefetch_masks[index];	/* disable prefetch */
 	}
 	put_cmd640_reg(reg, b);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&cmd640_lock, flags);
 }
 
 /*
@@ -579,8 +577,7 @@
 	/*
 	 * Now that everything is ready, program the new timings
 	 */
-	save_flags (flags);
-	cli();
+	spin_lock_irqsave(&cmd640_lock, flags);
 	/*
 	 * Program the address_setup clocks into ARTTIM reg,
 	 * and then the active/recovery counts into the DRWTIM reg
@@ -589,7 +586,7 @@
 	setup_count |= get_cmd640_reg(arttim_regs[index]) & 0x3f;
 	put_cmd640_reg(arttim_regs[index], setup_count);
 	put_cmd640_reg(drwtim_regs[index], pack_nibbles(active_count, recovery_count));
-	restore_flags(flags);
+	spin_unlock_irqrestore(&cmd640_lock, flags);
 }
 
 /*
