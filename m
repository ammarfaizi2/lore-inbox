Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbTJ0M2W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 07:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbTJ0M2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 07:28:22 -0500
Received: from web20605.mail.yahoo.com ([216.136.226.163]:2907 "HELO
	web20605.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261667AbTJ0M0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 07:26:53 -0500
Message-ID: <20031027122652.29090.qmail@web20605.mail.yahoo.com>
Date: Mon, 27 Oct 2003 04:26:52 -0800 (PST)
From: Stefan Talpalaru <stefantalpalaru@yahoo.com>
Subject: CMD640 ide driver made to work
To: andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre!

  I own an old 486 box with a CMD640 chipset on it. It works just fine
under
the 2.2.x kernel, but not under the 2.4.x series. I modified the
"cmd640"
driver so it works and I have tested it on my hardware.
  This patch is for the 2.4.22 kernel.


diff -urN linux-2.4.22/Documentation/Configure.help
linux-2.4.22-new/Documentation/Configure.help
--- linux-2.4.22/Documentation/Configure.help	2003-09-10
17:39:41.000000000 +0000
+++ linux-2.4.22-new/Documentation/Configure.help	2003-10-26
14:14:12.000000000 +0000
@@ -916,14 +916,6 @@
   the "CSA-6400E PCI to IDE controller" that some people have. For
   details, read <file:Documentation/ide.txt>.
 
-CMD640 enhanced support
-CONFIG_BLK_DEV_CMD640_ENHANCED
-  This option includes support for setting/autotuning PIO modes and
-  prefetch on CMD640 IDE interfaces.  For details, read
-  <file:Documentation/ide.txt>. If you have a CMD640 IDE interface
-  and your BIOS does not already do this for you, then say Y here.
-  Otherwise say N.
-
 RZ1000 chipset bugfix/support
 CONFIG_BLK_DEV_RZ1000
   The PC-Technologies RZ1000 IDE chip is used on many common 486 and
diff -urN linux-2.4.22/drivers/ide/Config.in
linux-2.4.22-new/drivers/ide/Config.in
--- linux-2.4.22/drivers/ide/Config.in	2003-09-10 17:49:50.000000000
+0000
+++ linux-2.4.22-new/drivers/ide/Config.in	2003-10-18
21:43:37.000000000 +0000
@@ -28,7 +28,6 @@
    comment 'IDE chipset support/bugfixes'
    if [ "$CONFIG_BLK_DEV_IDE" != "n" ]; then
       dep_bool '  CMD640 chipset bugfix/support' CONFIG_BLK_DEV_CMD640
$CONFIG_X86
-      dep_bool '    CMD640 enhanced support'
CONFIG_BLK_DEV_CMD640_ENHANCED $CONFIG_BLK_DEV_CMD640
       dep_bool '  ISA-PNP EIDE support' CONFIG_BLK_DEV_ISAPNP
$CONFIG_ISAPNP
       if [ "$CONFIG_PCI" = "y" ]; then
 	 bool '  PCI IDE chipset support' CONFIG_BLK_DEV_IDEPCI
diff -urN linux-2.4.22/drivers/ide/pci/cmd640.c
linux-2.4.22-new/drivers/ide/pci/cmd640.c
--- linux-2.4.22/drivers/ide/pci/cmd640.c	2003-09-10 17:49:55.000000000
+0000
+++ linux-2.4.22-new/drivers/ide/pci/cmd640.c	2003-10-26
17:07:07.000000000 +0000
@@ -1,12 +1,14 @@
 /*
- *  linux/drivers/ide/pci/cmd640.c		Version 1.02  Sep 01, 1996
+ *  linux/drivers/ide/pci/cmd640.c		Version 2.00  Oct 26, 2003
  *
- *  Copyright (C) 1995-1996  Linus Torvalds & authors (see below)
+ *  Copyright (C) 1995-2003  Linus Torvalds & authors (see below)
  */
 
 /*
  *  Original authors:	abramov@cecmow.enet.dec.com (Igor Abramov)
  *  			mlord@pobox.com (Mark Lord)
+ *  The guy that made it work in the 2.4.x kernel:
+ *                      stefantalpalaru@yahoo.com (Stefan Talpalaru)
  *
  *  See linux/MAINTAINERS for address of current maintainer.
  *
@@ -96,6 +98,8 @@
  *			 ("fast" is necessary for 32bit I/O in some systems)
  *  Version 1.02	fix bug that resulted in slow "setup times"
  *			 (patch courtesy of Zoltan Hidvegi)
+ *  Version 2.00        it seems that this driver never worked in the
2.4.x
+ *                      kernel series. This version fixes this
problem.
  */
 
 #undef REALLY_SLOW_IO		/* most systems can safely undef this */
@@ -111,12 +115,13 @@
 #include <linux/ioport.h>
 #include <linux/blkdev.h>
 #include <linux/hdreg.h>
+#include <linux/pci.h>
 #include <linux/ide.h>
 #include <linux/init.h>
-
 #include <asm/io.h>
 
 #include "ide_modes.h"
+#include "cmd640.h"
 
 /*
  * This flag is set in ide.c by the parameter:  ide0=cmd640_vlb
@@ -171,42 +176,42 @@
 /*
  * Registers and masks for easy access by drive index:
  */
-static u8 prefetch_regs[4]  = {CNTRL, CNTRL, ARTTIM23, ARTTIM23};
-static u8 prefetch_masks[4] = {CNTRL_DIS_RA0, CNTRL_DIS_RA1,
ARTTIM23_DIS_RA2, ARTTIM23_DIS_RA3};
-
-#ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
-
-static u8 arttim_regs[4] = {ARTTIM0, ARTTIM1, ARTTIM23, ARTTIM23};
-static u8 drwtim_regs[4] = {DRWTIM0, DRWTIM1, DRWTIM23, DRWTIM23};
+static u8 prefetch_regs[4] = { CNTRL, CNTRL, ARTTIM23, ARTTIM23 };
+static u8 prefetch_masks[4] =
+    { CNTRL_DIS_RA0, CNTRL_DIS_RA1, ARTTIM23_DIS_RA2, ARTTIM23_DIS_RA3
};
+static u8 arttim_regs[4] = { ARTTIM0, ARTTIM1, ARTTIM23, ARTTIM23 };
+static u8 drwtim_regs[4] = { DRWTIM0, DRWTIM1, DRWTIM23, DRWTIM23 };
 
 /*
  * Current cmd640 timing values for each drive.
  * The defaults for each are the slowest possible timings.
  */
-static u8 setup_counts[4]    = {4, 4, 4, 4};     /* Address setup
count (in clocks) */
-static u8 active_counts[4]   = {16, 16, 16, 16}; /* Active count  
(encoded) */
-static u8 recovery_counts[4] = {16, 16, 16, 16}; /* Recovery count
(encoded) */
-
-#endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
-
-/*
- * These are initialized to point at the devices we control
- */
-static ide_hwif_t  *cmd_hwif0, *cmd_hwif1;
-static ide_drive_t *cmd_drives[4];
+static u8 setup_counts[4] = { 4, 4, 4, 4 };	/* Address setup count (in
clocks) */
+static u8 active_counts[4] = { 16, 16, 16, 16 };	/* Active count  
(encoded) */
+static u8 recovery_counts[4] = { 16, 16, 16, 16 };	/* Recovery count
(encoded) */
 
 /*
  * Interface to access cmd640x registers
  */
 static unsigned int cmd640_key;
-static void (*__put_cmd640_reg)(u16 reg, u8 val);
-static u8 (*__get_cmd640_reg)(u16 reg);
+static void (*put_cmd640_reg) (u16 reg, u8 val);
+static u8 (*get_cmd640_reg) (u16 reg);
 
 /*
  * This is read from the CFR reg, and is used in several places.
  */
 static unsigned int cmd640_chip_version;
 
+static inline int
+calculate_index (ide_drive_t * drive)
+{
+	ide_hwif_t *hwif = HWIF (drive);
+	int channel = (int) hwif->channel;
+	int slave = (hwif->drives != drive);
+
+	return 2 * channel + slave;
+}
+
 /*
  * The CMD640x chip does not support DWORD config write cycles, but
some
  * of the BIOSes use them to implement the config services.
@@ -215,100 +220,114 @@
 
 /* PCI method 1 access */
 
-static void put_cmd640_reg_pci1 (u16 reg, u8 val)
+static void
+put_cmd640_reg_pci1 (u16 reg, u8 val)
 {
-	outb_p((reg & 0xfc) | cmd640_key, 0xcf8);
-	outb_p(val, (reg & 3) | 0xcfc);
+	unsigned long flags;
+
+	spin_lock_irqsave (&ide_lock, flags);
+	outl_p ((reg & 0xfc) | cmd640_key, 0xcf8);
+	outb_p (val, (reg & 3) | 0xcfc);
+	spin_unlock_irqrestore (&ide_lock, flags);
 }
 
-static u8 get_cmd640_reg_pci1 (u16 reg)
+static u8
+get_cmd640_reg_pci1 (u16 reg)
 {
-	outb_p((reg & 0xfc) | cmd640_key, 0xcf8);
-	return inb_p((reg & 3) | 0xcfc);
+	u8 b;
+	unsigned long flags;
+
+	spin_lock_irqsave (&ide_lock, flags);
+	outl_p ((reg & 0xfc) | cmd640_key, 0xcf8);
+	b = inb_p ((reg & 3) | 0xcfc);
+	spin_unlock_irqrestore (&ide_lock, flags);
+	return b;
 }
 
 /* PCI method 2 access (from CMD datasheet) */
 
-static void put_cmd640_reg_pci2 (u16 reg, u8 val)
+static void
+put_cmd640_reg_pci2 (u16 reg, u8 val)
 {
-	outb_p(0x10, 0xcf8);
-	outb_p(val, cmd640_key + reg);
-	outb_p(0, 0xcf8);
+	unsigned long flags;
+
+	spin_lock_irqsave (&ide_lock, flags);
+	outb_p (0x10, 0xcf8);
+	outb_p (val, cmd640_key + reg);
+	outb_p (0, 0xcf8);
+	spin_unlock_irqrestore (&ide_lock, flags);
 }
 
-static u8 get_cmd640_reg_pci2 (u16 reg)
+static u8
+get_cmd640_reg_pci2 (u16 reg)
 {
 	u8 b;
+	unsigned long flags;
 
-	outb_p(0x10, 0xcf8);
-	b = inb_p(cmd640_key + reg);
-	outb_p(0, 0xcf8);
+	spin_lock_irqsave (&ide_lock, flags);
+	outb_p (0x10, 0xcf8);
+	b = inb_p (cmd640_key + reg);
+	outb_p (0, 0xcf8);
+	spin_unlock_irqrestore (&ide_lock, flags);
 	return b;
 }
 
 /* VLB access */
 
-static void put_cmd640_reg_vlb (u16 reg, u8 val)
+static void
+put_cmd640_reg_vlb (u16 reg, u8 val)
 {
-	outb_p(reg, cmd640_key);
-	outb_p(val, cmd640_key + 4);
-}
+	unsigned long flags;
 
-static u8 get_cmd640_reg_vlb (u16 reg)
-{
-	outb_p(reg, cmd640_key);
-	return inb_p(cmd640_key + 4);
+	spin_lock_irqsave (&ide_lock, flags);
+	outb_p (reg, cmd640_key);
+	outb_p (val, cmd640_key + 4);
+	spin_unlock_irqrestore (&ide_lock, flags);
 }
 
-static u8 get_cmd640_reg(u16 reg)
+static u8
+get_cmd640_reg_vlb (u16 reg)
 {
 	u8 b;
 	unsigned long flags;
 
-	spin_lock_irqsave(&ide_lock, flags);
-	b = __get_cmd640_reg(reg);
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_lock_irqsave (&ide_lock, flags);
+	outb_p (reg, cmd640_key);
+	b = inb_p (cmd640_key + 4);
+	spin_unlock_irqrestore (&ide_lock, flags);
 	return b;
 }
 
-static void put_cmd640_reg(u16 reg, u8 val)
+static int __init
+match_pci_cmd640_device (void)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&ide_lock, flags);
-	__put_cmd640_reg(reg,val);
-	spin_unlock_irqrestore(&ide_lock, flags);
-}
-
-static int __init match_pci_cmd640_device (void)
-{
-	const u8 ven_dev[4] = {0x95, 0x10, 0x40, 0x06};
+	const u8 ven_dev[4] = { 0x95, 0x10, 0x40, 0x06 };
 	unsigned int i;
 	for (i = 0; i < 4; i++) {
-		if (get_cmd640_reg(i) != ven_dev[i])
+		if (get_cmd640_reg (i) != ven_dev[i])
 			return 0;
 	}
 #ifdef STUPIDLY_TRUST_BROKEN_PCMD_ENA_BIT
-	if ((get_cmd640_reg(PCMD) & PCMD_ENA) == 0) {
-		printk("ide: cmd640 on PCI disabled by BIOS\n");
+	if ((get_cmd640_reg (PCMD) & PCMD_ENA) == 0) {
+		printk ("ide: cmd640 on PCI disabled by BIOS\n");
 		return 0;
 	}
-#endif /* STUPIDLY_TRUST_BROKEN_PCMD_ENA_BIT */
-	return 1; /* success */
+#endif				/* STUPIDLY_TRUST_BROKEN_PCMD_ENA_BIT */
+	return 1;		/* success */
 }
 
 /*
  * Probe for CMD640x -- pci method 1
  */
-static int __init probe_for_cmd640_pci1 (void)
+static int __init
+probe_for_cmd640_pci1 (void)
 {
-	__get_cmd640_reg = get_cmd640_reg_pci1;
-	__put_cmd640_reg = put_cmd640_reg_pci1;
-	for (cmd640_key = 0x80000000;
-	     cmd640_key <= 0x8000f800;
+	get_cmd640_reg = get_cmd640_reg_pci1;
+	put_cmd640_reg = put_cmd640_reg_pci1;
+	for (cmd640_key = 0x80000000; cmd640_key <= 0x8000f800;
 	     cmd640_key += 0x800) {
-		if (match_pci_cmd640_device())
-			return 1; /* success */
+		if (match_pci_cmd640_device ())
+			return 1;	/* success */
 	}
 	return 0;
 }
@@ -316,13 +335,14 @@
 /*
  * Probe for CMD640x -- pci method 2
  */
-static int __init probe_for_cmd640_pci2 (void)
+static int __init
+probe_for_cmd640_pci2 (void)
 {
-	__get_cmd640_reg = get_cmd640_reg_pci2;
-	__put_cmd640_reg = put_cmd640_reg_pci2;
+	get_cmd640_reg = get_cmd640_reg_pci2;
+	put_cmd640_reg = put_cmd640_reg_pci2;
 	for (cmd640_key = 0xc000; cmd640_key <= 0xcf00; cmd640_key += 0x100)
{
-		if (match_pci_cmd640_device())
-			return 1; /* success */
+		if (match_pci_cmd640_device ())
+			return 1;	/* success */
 	}
 	return 0;
 }
@@ -330,63 +350,66 @@
 /*
  * Probe for CMD640x -- vlb
  */
-static int __init probe_for_cmd640_vlb (void)
+static int __init
+probe_for_cmd640_vlb (void)
 {
 	u8 b;
 
-	__get_cmd640_reg = get_cmd640_reg_vlb;
-	__put_cmd640_reg = put_cmd640_reg_vlb;
+	get_cmd640_reg = get_cmd640_reg_vlb;
+	put_cmd640_reg = put_cmd640_reg_vlb;
 	cmd640_key = 0x178;
-	b = get_cmd640_reg(CFR);
+	b = get_cmd640_reg (CFR);
 	if (b == 0xff || b == 0x00 || (b & CFR_AT_VESA_078h)) {
 		cmd640_key = 0x78;
-		b = get_cmd640_reg(CFR);
+		b = get_cmd640_reg (CFR);
 		if (b == 0xff || b == 0x00 || !(b & CFR_AT_VESA_078h))
 			return 0;
 	}
-	return 1; /* success */
+	return 1;		/* success */
 }
 
 /*
  *  Returns 1 if an IDE interface/drive exists at 0x170,
  *  Returns 0 otherwise.
  */
-static int __init secondary_port_responding (void)
+static int __init
+secondary_port_responding (void)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&ide_lock, flags);
+	spin_lock_irqsave (&ide_lock, flags);
 
-	outb_p(0x0a, 0x170 + IDE_SELECT_OFFSET);	/* select drive0 */
-	udelay(100);
-	if ((inb_p(0x170 + IDE_SELECT_OFFSET) & 0x1f) != 0x0a) {
-		outb_p(0x1a, 0x170 + IDE_SELECT_OFFSET); /* select drive1 */
-		udelay(100);
-		if ((inb_p(0x170 + IDE_SELECT_OFFSET) & 0x1f) != 0x1a) {
-			spin_unlock_irqrestore(&ide_lock, flags);
-			return 0; /* nothing responded */
+	outb_p (0x0a, 0x170 + IDE_SELECT_OFFSET);	/* select drive0 */
+	udelay (100);
+	if ((inb_p (0x170 + IDE_SELECT_OFFSET) & 0x1f) != 0x0a) {
+		outb_p (0x1a, 0x170 + IDE_SELECT_OFFSET);	/* select drive1 */
+		udelay (100);
+		if ((inb_p (0x170 + IDE_SELECT_OFFSET) & 0x1f) != 0x1a) {
+			spin_unlock_irqrestore (&ide_lock, flags);
+			return 0;	/* nothing responded */
 		}
 	}
-	spin_unlock_irqrestore(&ide_lock, flags);
-	return 1; /* success */
+	spin_unlock_irqrestore (&ide_lock, flags);
+	return 1;		/* success */
 }
 
 #ifdef CMD640_DUMP_REGS
 /*
  * Dump out all cmd640 registers.  May be called from ide.c
  */
-static void cmd640_dump_regs (void)
+static void __init
+cmd640_dump_regs (void)
 {
 	unsigned int reg = cmd640_vlb ? 0x50 : 0x00;
 
 	/* Dump current state of chip registers */
-	printk("ide: cmd640 internal register dump:");
+	printk ("ide: cmd640 internal register dump:");
 	for (; reg <= 0x59; reg++) {
 		if (!(reg & 0x0f))
-			printk("\n%04x:", reg);
-		printk(" %02x", get_cmd640_reg(reg));
+			printk ("\n%04x:", reg);
+		printk (" %02x", get_cmd640_reg (reg));
 	}
-	printk("\n");
+	printk ("\n");
 }
 #endif
 
@@ -394,12 +417,14 @@
  * Check whether prefetch is on for a drive,
  * and initialize the unmask flags for safe operation.
  */
-static void __init check_prefetch (unsigned int index)
+static void __init
+check_prefetch (ide_drive_t * drive)
 {
-	ide_drive_t *drive = cmd_drives[index];
-	u8 b = get_cmd640_reg(prefetch_regs[index]);
+	int index = calculate_index (drive);
+	u8 b = get_cmd640_reg (prefetch_regs[index]);
 
-	if (b & prefetch_masks[index]) {	/* is prefetch off? */
+	if (b & prefetch_masks[index]) {
+		/* is prefetch off? */
 		drive->no_unmask = 0;
 		drive->no_io_32bit = 1;
 		drive->io_32bit = 0;
@@ -413,44 +438,20 @@
 }
 
 /*
- * Figure out which devices we control
- */
-static void __init setup_device_ptrs (void)
-{
-	unsigned int i;
-
-	cmd_hwif0 = &ide_hwifs[0]; /* default, if not found below */
-	cmd_hwif1 = &ide_hwifs[1]; /* default, if not found below */
-	for (i = 0; i < MAX_HWIFS; i++) {
-		ide_hwif_t *hwif = &ide_hwifs[i];
-		if (hwif->chipset == ide_unknown || hwif->chipset == ide_generic) {
-			if (hwif->io_ports[IDE_DATA_OFFSET] == 0x1f0)
-				cmd_hwif0 = hwif;
-			else if (hwif->io_ports[IDE_DATA_OFFSET] == 0x170)
-				cmd_hwif1 = hwif;
-		}
-	}
-	cmd_drives[0] = &cmd_hwif0->drives[0];
-	cmd_drives[1] = &cmd_hwif0->drives[1];
-	cmd_drives[2] = &cmd_hwif1->drives[0];
-	cmd_drives[3] = &cmd_hwif1->drives[1];
-}
-
-#ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
-
-/*
  * Sets prefetch mode for a drive.
  */
-static void set_prefetch_mode (unsigned int index, int mode)
+static void
+set_prefetch_mode (ide_drive_t * drive, int mode)
 {
-	ide_drive_t *drive = cmd_drives[index];
+	int index = calculate_index (drive);
 	int reg = prefetch_regs[index];
 	u8 b;
 	unsigned long flags;
 
-	spin_lock_irqsave(&ide_lock, flags);
-	b = __get_cmd640_reg(reg);
-	if (mode) {	/* want prefetch on? */
+	spin_lock_irqsave (&ide_lock, flags);
+	b = get_cmd640_reg (reg);
+	if (mode) {
+		/* want prefetch on? */
 #if CMD640_PREFETCH_MASKS
 		drive->no_unmask = 1;
 		drive->unmask = 0;
@@ -463,15 +464,17 @@
 		drive->io_32bit = 0;
 		b |= prefetch_masks[index];	/* disable prefetch */
 	}
-	__put_cmd640_reg(reg, b);
-	spin_unlock_irqrestore(&ide_lock, flags);
+	put_cmd640_reg (reg, b);
+	spin_unlock_irqrestore (&ide_lock, flags);
 }
 
 /*
  * Dump out current drive clocks settings
  */
-static void display_clocks (unsigned int index)
+static void __init
+display_clocks (ide_drive_t * drive)
 {
+	int index = calculate_index (drive);
 	u8 active_count, recovery_count;
 
 	active_count = active_counts[index];
@@ -481,15 +484,17 @@
 	if (active_count > 3 && recovery_count == 1)
 		++recovery_count;
 	if (cmd640_chip_version > 1)
-		recovery_count += 1;  /* cmd640b uses (count + 1)*/
-	printk(", clocks=%d/%d/%d\n", setup_counts[index], active_count,
recovery_count);
+		recovery_count += 1;	/* cmd640b uses (count + 1) */
+	printk (", clocks=%d/%d/%d\n", setup_counts[index], active_count,
+		recovery_count);
 }
 
 /*
  * Pack active and recovery counts into single byte representation
  * used by controller
  */
-inline static u8 pack_nibbles (u8 upper, u8 lower)
+inline static u8
+pack_nibbles (u8 upper, u8 lower)
 {
 	return ((upper & 0x0f) << 4) | (lower & 0x0f);
 }
@@ -497,41 +502,52 @@
 /*
  * This routine retrieves the initial drive timings from the chipset.
  */
-static void __init retrieve_drive_counts (unsigned int index)
+static void __init
+retrieve_drive_counts (ide_drive_t * drive)
 {
+	int index = calculate_index (drive);
 	u8 b;
 
 	/*
 	 * Get the internal setup timing, and convert to clock count
 	 */
-	b = get_cmd640_reg(arttim_regs[index]) & ~0x3f;
+	b = get_cmd640_reg (arttim_regs[index]) & ~0x3f;
 	switch (b) {
-		case 0x00: b = 4; break;
-		case 0x80: b = 3; break;
-		case 0x40: b = 2; break;
-		default:   b = 5; break;
+	case 0x00:
+		b = 4;
+		break;
+	case 0x80:
+		b = 3;
+		break;
+	case 0x40:
+		b = 2;
+		break;
+	default:
+		b = 5;
+		break;
 	}
 	setup_counts[index] = b;
 
 	/*
 	 * Get the active/recovery counts
 	 */
-	b = get_cmd640_reg(drwtim_regs[index]);
-	active_counts[index]   = (b >> 4)   ? (b >> 4)   : 0x10;
+	b = get_cmd640_reg (drwtim_regs[index]);
+	active_counts[index] = (b >> 4) ? (b >> 4) : 0x10;
 	recovery_counts[index] = (b & 0x0f) ? (b & 0x0f) : 0x10;
 }
 
-
 /*
  * This routine writes the prepared setup/active/recovery counts
  * for a drive into the cmd640 chipset registers to active them.
  */
-static void program_drive_counts (unsigned int index)
+static void
+program_drive_counts (ide_drive_t * drive, int setup_count, int
active_count,
+		      int recovery_count)
 {
 	unsigned long flags;
-	u8 setup_count    = setup_counts[index];
-	u8 active_count   = active_counts[index];
-	u8 recovery_count = recovery_counts[index];
+	ide_drive_t *drives = HWIF (drive)->drives;
+	int channel = (int) HWIF (drive)->channel;
+	int index = calculate_index (drive);
 
 	/*
 	 * Set up address setup count and drive read/write timing registers.
@@ -539,56 +555,87 @@
 	 * each drive.  Secondary interface has one common set of registers,
 	 * so we merge the timings, using the slowest value for each timing.
 	 */
-	if (index > 1) {
-		unsigned int mate;
-		if (cmd_drives[mate = index ^ 1]->present) {
-			if (setup_count < setup_counts[mate])
-				setup_count = setup_counts[mate];
-			if (active_count < active_counts[mate])
-				active_count = active_counts[mate];
-			if (recovery_count < recovery_counts[mate])
-				recovery_count = recovery_counts[mate];
-		}
+	if (channel) {
+		drive->drive_data = setup_count;
+		setup_count = IDE_MAX (drives[0].drive_data,
+				       drives[1].drive_data);
 	}
 
 	/*
-	 * Convert setup_count to internal chipset representation
+	 * Convert values to internal chipset representation
 	 */
 	switch (setup_count) {
-		case 4:	 setup_count = 0x00; break;
-		case 3:	 setup_count = 0x80; break;
-		case 1:
-		case 2:	 setup_count = 0x40; break;
-		default: setup_count = 0xc0; /* case 5 */
+	case 4:
+		setup_count = 0x00;
+		break;
+	case 3:
+		setup_count = 0x80;
+		break;
+	case 1:
+	case 2:
+		setup_count = 0x40;
+		break;
+	default:
+		setup_count = 0xc0;	/* case 5 */
 	}
 
 	/*
 	 * Now that everything is ready, program the new timings
 	 */
-	spin_lock_irqsave(&ide_lock, flags);
+	spin_lock_irqsave (&ide_lock, flags);
 	/*
 	 * Program the address_setup clocks into ARTTIM reg,
 	 * and then the active/recovery counts into the DRWTIM reg
 	 * (this converts counts of 16 into counts of zero -- okay).
 	 */
-	setup_count |= __get_cmd640_reg(arttim_regs[index]) & 0x3f;
-	__put_cmd640_reg(arttim_regs[index], setup_count);
-	__put_cmd640_reg(drwtim_regs[index], pack_nibbles(active_count,
recovery_count));
-	spin_unlock_irqrestore(&ide_lock, flags);
+	setup_count |= get_cmd640_reg (arttim_regs[index]) & 0x3f;
+	put_cmd640_reg (arttim_regs[index], setup_count);
+	put_cmd640_reg (drwtim_regs[index],
+			pack_nibbles (active_count, recovery_count));
+	spin_unlock_irqrestore (&ide_lock, flags);
 }
 
 /*
- * Set a specific pio_mode for a drive
+ * Drive PIO mode selection:
  */
-static void cmd640_set_mode (unsigned int index, u8 pio_mode, unsigned
int cycle_time)
+static void
+cmd640_tuneproc (ide_drive_t * drive, u8 mode_wanted)
 {
-	int setup_time, active_time, recovery_time, clock_time;
-	u8 setup_count, active_count, recovery_count, recovery_count2,
cycle_count;
-	int bus_speed = system_bus_clock();
+	int setup_time, active_time, recovery_time;
+	int clock_time, pio_mode, cycle_time;
+	u8 recovery_count2, cycle_count, b;
+	int setup_count, active_count, recovery_count;
+	int bus_speed = system_bus_clock ();
+	ide_pio_data_t d;
+
+	switch (mode_wanted) {
+	case 6:		/* set fast-devsel off */
+	case 7:		/* set fast-devsel on */
+		mode_wanted &= 1;
+		b = get_cmd640_reg (CNTRL) & ~0x27;
+		if (mode_wanted)
+			b |= 0x27;
+		put_cmd640_reg (CNTRL, b);
+		printk ("%s: %sabled cmd640 fast host timing (devsel)\n",
+			drive->name, mode_wanted ? "en" : "dis");
+		return;
+
+	case 8:		/* set prefetch off */
+	case 9:		/* set prefetch on */
+		mode_wanted &= 1;
+		set_prefetch_mode (drive, mode_wanted);
+		printk ("%s: %sabled cmd640 prefetch\n", drive->name,
+			mode_wanted ? "en" : "dis");
+		return;
+	}
+
+	mode_wanted = ide_get_best_pio_mode (drive, mode_wanted, 5, &d);
+	pio_mode = d.pio_mode;
+	cycle_time = d.cycle_time;
 
 	if (pio_mode > 5)
 		pio_mode = 5;
-	setup_time  = ide_pio_timings[pio_mode].setup_time;
+	setup_time = ide_pio_timings[pio_mode].setup_time;
 	active_time = ide_pio_timings[pio_mode].active_time;
 	recovery_time = cycle_time - (setup_time + active_time);
 	clock_time = 1000 / bus_speed;
@@ -598,158 +645,78 @@
 
 	active_count = (active_time + clock_time - 1) / clock_time;
 	if (active_count < 2)
-		active_count = 2; /* minimum allowed by cmd640 */
+		active_count = 2;	/* minimum allowed by cmd640 */
 
 	recovery_count = (recovery_time + clock_time - 1) / clock_time;
 	recovery_count2 = cycle_count - (setup_count + active_count);
 	if (recovery_count2 > recovery_count)
 		recovery_count = recovery_count2;
 	if (recovery_count < 2)
-		recovery_count = 2; /* minimum allowed by cmd640 */
+		recovery_count = 2;	/* minimum allowed by cmd640 */
 	if (recovery_count > 17) {
 		active_count += recovery_count - 17;
 		recovery_count = 17;
 	}
 	if (active_count > 16)
-		active_count = 16; /* maximum allowed by cmd640 */
+		active_count = 16;	/* maximum allowed by cmd640 */
 	if (cmd640_chip_version > 1)
-		recovery_count -= 1;  /* cmd640b uses (count + 1)*/
+		recovery_count -= 1;	/* cmd640b uses (count + 1) */
 	if (recovery_count > 16)
-		recovery_count = 16; /* maximum allowed by cmd640 */
-
-	setup_counts[index]    = setup_count;
-	active_counts[index]   = active_count;
-	recovery_counts[index] = recovery_count;
+		recovery_count = 16;	/* maximum allowed by cmd640 */
 
 	/*
 	 * In a perfect world, we might set the drive pio mode here
 	 * (using WIN_SETFEATURE) before continuing.
 	 *
 	 * But we do not, because:
-	 *	1) this is the wrong place to do it (proper is do_special() in
ide.c)
-	 * 	2) in practice this is rarely, if ever, necessary
+	 *      1) this is the wrong place to do it (proper is do_special()
in ide.c)
+	 *      2) in practice this is rarely, if ever, necessary
 	 */
-	program_drive_counts (index);
-}
-
-/*
- * Drive PIO mode selection:
- */
-static void cmd640_tune_drive (ide_drive_t *drive, u8 mode_wanted)
-{
-	u8 b;
-	ide_pio_data_t  d;
-	unsigned int index = 0;
-
-	while (drive != cmd_drives[index]) {
-		if (++index > 3) {
-			printk("%s: bad news in cmd640_tune_drive\n", drive->name);
-			return;
-		}
-	}
-	switch (mode_wanted) {
-		case 6: /* set fast-devsel off */
-		case 7: /* set fast-devsel on */
-			mode_wanted &= 1;
-			b = get_cmd640_reg(CNTRL) & ~0x27;
-			if (mode_wanted)
-				b |= 0x27;
-			put_cmd640_reg(CNTRL, b);
-			printk("%s: %sabled cmd640 fast host timing (devsel)\n",
drive->name, mode_wanted ? "en" : "dis");
-			return;
-
-		case 8: /* set prefetch off */
-		case 9: /* set prefetch on */
-			mode_wanted &= 1;
-			set_prefetch_mode(index, mode_wanted);
-			printk("%s: %sabled cmd640 prefetch\n", drive->name, mode_wanted ?
"en" : "dis");
-			return;
-	}
-
-	(void) ide_get_best_pio_mode (drive, mode_wanted, 5, &d);
-	cmd640_set_mode (index, d.pio_mode, d.cycle_time);
+	program_drive_counts (drive, setup_count, active_count,
recovery_count);
 
-	printk ("%s: selected cmd640 PIO mode%d (%dns)%s",
-		drive->name,
-		d.pio_mode,
-		d.cycle_time,
-		d.overridden ? " (overriding vendor mode)" : "");
-	display_clocks(index);
-	return;
+	printk ("%s: selected cmd640 PIO mode%d : %d (%dns)%s, "
+		"clocks=%d/%d/%d\n",
+		drive->name, pio_mode, mode_wanted, cycle_time,
+		d.overridden ? " (overriding vendor mode)" : "",
+		setup_count, active_count, recovery_count);
 }
 
-#endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
-
-static int pci_conf1(void)
+static void __init
+init_hwif_cmd640 (ide_hwif_t * hwif)
 {
-	u32 tmp;
-	unsigned long flags;
-
-	spin_lock_irqsave(&ide_lock, flags);
-	outb(0x01, 0xCFB);
-	tmp = inl(0xCF8);
-	outl(0x80000000, 0xCF8);
-	if (inl(0xCF8) == 0x80000000) {
-		outl(tmp, 0xCF8);
-		spin_unlock_irqrestore(&ide_lock, flags);
-		return 1;
-	}
-	outl(tmp, 0xCF8);
-	spin_unlock_irqrestore(&ide_lock, flags);
-	return 0;
-}
-
-static int pci_conf2(void)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&ide_lock, flags);
-	outb(0x00, 0xCFB);
-	outb(0x00, 0xCF8);
-	outb(0x00, 0xCFA);
-	if (inb(0xCF8) == 0x00 && inb(0xCF8) == 0x00) {
-		spin_unlock_irqrestore(&ide_lock, flags);
-		return 1;
-	}
-	spin_unlock_irqrestore(&ide_lock, flags);
-	return 0;
-}
-
-/*
- * Probe for a cmd640 chipset, and initialize it if found.  Called
from ide.c
- */
-static void __init ide_probe_for_cmd640x (void)
-{
-#ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
 	int second_port_toggled = 0;
-#endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
 	int second_port_cmd640 = 0;
 	const char *bus_type, *port2;
-	unsigned int index;
 	u8 b, cfr;
+	int i;
+
+	hwif->tuneproc = &cmd640_tuneproc;
 
-	if (cmd640_vlb && probe_for_cmd640_vlb()) {
+	if (cmd640_vlb && probe_for_cmd640_vlb ()) {
 		bus_type = "VLB";
 	} else {
 		cmd640_vlb = 0;
 		/* Find out what kind of PCI probing is supported otherwise
 		   we break some Adaptec cards...  */
-		if (pci_conf1() && probe_for_cmd640_pci1())
+
+		if (probe_for_cmd640_pci1 ())
 			bus_type = "PCI (type1)";
-		else if (pci_conf2() && probe_for_cmd640_pci2())
+		else if (probe_for_cmd640_pci2 ())
 			bus_type = "PCI (type2)";
 		else
 			return;
 	}
+
 	/*
 	 * Undocumented magic (there is no 0x5b reg in specs)
 	 */
-	put_cmd640_reg(0x5b, 0xbd);
-	if (get_cmd640_reg(0x5b) != 0xbd) {
-		printk(KERN_ERR "ide: cmd640 init failed: wrong value in reg
0x5b\n");
+	put_cmd640_reg (0x5b, 0xbd);
+	if (get_cmd640_reg (0x5b) != 0xbd) {
+		printk (KERN_ERR
+			"ide: cmd640 init failed: wrong value in reg 0x5b\n");
 		return;
 	}
-	put_cmd640_reg(0x5b, 0);
+	put_cmd640_reg (0x5b, 0);
 
 #ifdef CMD640_DUMP_REGS
 	CMD640_DUMP_REGS;
@@ -758,23 +725,18 @@
 	/*
 	 * Documented magic begins here
 	 */
-	cfr = get_cmd640_reg(CFR);
+	cfr = get_cmd640_reg (CFR);
 	cmd640_chip_version = cfr & CFR_DEVREV;
 	if (cmd640_chip_version == 0) {
 		printk ("ide: bad cmd640 revision: %d\n", cmd640_chip_version);
 		return;
 	}
 
-	/*
-	 * Initialize data for primary port
-	 */
-	setup_device_ptrs ();
-	printk("%s: buggy cmd640%c interface on %s, config=0x%02x\n",
-	       cmd_hwif0->name, 'a' + cmd640_chip_version - 1, bus_type,
cfr);
-	cmd_hwif0->chipset = ide_cmd640;
-#ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
-	cmd_hwif0->tuneproc = &cmd640_tune_drive;
-#endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
+	printk ("%s: buggy cmd640%c interface on %s, config=0x%02x\n",
+		hwif->name, 'a' + cmd640_chip_version - 1, bus_type, cfr);
+
+	hwif->serialized = 1;
+	hwif->chipset = ide_cmd640;
 
 	/*
 	 * Ensure compatibility by always using the slowest timings
@@ -783,121 +745,138 @@
 	 *
 	 * Maybe we need a way to NOT do these on *some* systems?
 	 */
-	put_cmd640_reg(CMDTIM, 0);
-	put_cmd640_reg(BRST, 0x40);
+	put_cmd640_reg (CMDTIM, 0);
+	put_cmd640_reg (BRST, 0x40);
 
 	/*
 	 * Try to enable the secondary interface, if not already enabled
 	 */
-	if (cmd_hwif1->noprobe) {
-		port2 = "not probed";
-	} else {
-		b = get_cmd640_reg(CNTRL);
-		if (secondary_port_responding()) {
-			if ((b & CNTRL_ENA_2ND)) {
-				second_port_cmd640 = 1;
-				port2 = "okay";
-			} else if (cmd640_vlb) {
-				second_port_cmd640 = 1;
-				port2 = "alive";
-			} else
-				port2 = "not cmd640";
+	if (hwif->channel == 1)	//secondary interface
+	{
+		if (hwif->noprobe) {
+			port2 = "not probed";
 		} else {
-			put_cmd640_reg(CNTRL, b ^ CNTRL_ENA_2ND); /* toggle the bit */
-			if (secondary_port_responding()) {
-				second_port_cmd640 = 1;
-#ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
-				second_port_toggled = 1;
-#endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
-				port2 = "enabled";
+			b = get_cmd640_reg (CNTRL);
+			if (secondary_port_responding ()) {
+				if ((b & CNTRL_ENA_2ND)) {
+					second_port_cmd640 = 1;
+					port2 = "okay";
+				} else if (cmd640_vlb) {
+					second_port_cmd640 = 1;
+					port2 = "alive";
+				} else
+					port2 = "not cmd640";
 			} else {
-				put_cmd640_reg(CNTRL, b); /* restore original setting */
-				port2 = "not responding";
+				put_cmd640_reg (CNTRL, b ^ CNTRL_ENA_2ND);	/* toggle the bit */
+				if (secondary_port_responding ()) {
+					second_port_cmd640 = 1;
+					second_port_toggled = 1;
+					port2 = "enabled";
+				} else {
+					put_cmd640_reg (CNTRL, b);	/* restore original setting */
+					port2 = "not responding";
+				}
 			}
 		}
-	}
 
-	/*
-	 * Initialize data for secondary cmd640 port, if enabled
-	 */
-	if (second_port_cmd640) {
-		cmd_hwif0->serialized = 1;
-		cmd_hwif1->serialized = 1;
-		cmd_hwif1->chipset = ide_cmd640;
-		cmd_hwif0->mate = cmd_hwif1;
-		cmd_hwif1->mate = cmd_hwif0;
-		cmd_hwif1->channel = 1;
-#ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
-		cmd_hwif1->tuneproc = &cmd640_tune_drive;
-#endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
+		/*
+		 * Initialize data for secondary cmd640 port, if enabled
+		 */
+		printk (KERN_INFO "%s: %sserialized, secondary interface %s\n",
+			hwif->name, hwif->serialized ? "" : "not ", port2);
 	}
-	printk(KERN_INFO "%s: %sserialized, secondary interface %s\n",
cmd_hwif1->name,
-		cmd_hwif0->serialized ? "" : "not ", port2);
 
 	/*
 	 * Establish initial timings/prefetch for all drives.
 	 * Do not unnecessarily disturb any prior BIOS setup of these.
 	 */
-	for (index = 0; index < (2 + (second_port_cmd640 << 1)); index++) {
-		ide_drive_t *drive = cmd_drives[index];
-#ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
-		if (drive->autotune || ((index > 1) && second_port_toggled)) {
-	 		/*
-	 		 * Reset timing to the slowest speed and turn off prefetch.
+	for (i = 0; i < 2; i++) {
+		if (hwif->drives[i].autotune) {
+			/*
+			 * Reset timing to the slowest speed and turn off prefetch.
 			 * This way, the drive identify code has a better chance.
 			 */
-			setup_counts    [index] = 4;	/* max possible */
-			active_counts   [index] = 16;	/* max possible */
-			recovery_counts [index] = 16;	/* max possible */
-			program_drive_counts (index);
-			set_prefetch_mode (index, 0);
-			printk("cmd640: drive%d timings/prefetch cleared\n", index);
+			setup_counts[2 * hwif->channel + i] = 4;	/* max possible */
+			active_counts[2 * hwif->channel + i] = 16;	/* max possible */
+			recovery_counts[2 * hwif->channel + i] = 16;	/* max possible */
+			program_drive_counts (&(hwif->drives[i]), 4, 16, 16);
+			set_prefetch_mode ((&hwif->drives[i]), 0);
+			printk ("cmd640: drive%d timings/prefetch cleared\n",
+				2 * hwif->channel + i);
 		} else {
 			/*
 			 * Record timings/prefetch without changing them.
 			 * This preserves any prior BIOS setup.
 			 */
-			retrieve_drive_counts (index);
-			check_prefetch (index);
-			printk("cmd640: drive%d timings/prefetch(%s) preserved",
-				index, drive->no_io_32bit ? "off" : "on");
-			display_clocks(index);
+			retrieve_drive_counts (&hwif->drives[i]);
+			check_prefetch (&hwif->drives[i]);
+			printk
+			    ("cmd640: drive%d timings/prefetch(%s) preserved",
+			     2 * hwif->channel + i,
+			     hwif->drives[i].no_io_32bit ? "off" : "on");
+			display_clocks (&hwif->drives[i]);
 		}
-#else
-		/*
-		 * Set the drive unmask flags to match the prefetch setting
-		 */
-		check_prefetch (index);
-		printk("cmd640: drive%d timings/prefetch(%s) preserved\n",
-			index, drive->no_io_32bit ? "off" : "on");
-#endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
 	}
 
 #ifdef CMD640_DUMP_REGS
 	CMD640_DUMP_REGS;
 #endif
-	return;
-}
-
-static int __init cmd640_init(void)
-{
-	ide_register_driver(ide_probe_for_cmd640x);
-	return 0;
 }
 
 /*
  *	Called by the IDE core when compiled in and cmd640=vlb is
  *	selected.
  */
-void init_cmd640_vlb(void)
+void __init
+init_cmd640_vlb (void)
 {
 	cmd640_vlb = 1;
 }
 
-module_init(cmd640_init);
+extern void ide_setup_pci_device (struct pci_dev *, ide_pci_device_t
*);
+
+static int __devinit
+cmd640_init_one (struct pci_dev *dev, const struct pci_device_id *id)
+{
+	ide_pci_device_t *d = &cmd640_chipsets[id->driver_data];
+	if (dev->device != d->device)
+		BUG ();
+	ide_setup_pci_device (dev, d);
+	MOD_INC_USE_COUNT;
+	return 0;
+}
+
+static struct pci_device_id cmd640_pci_tbl[] __devinitdata = {
+	{PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_CMD_640, PCI_ANY_ID, PCI_ANY_ID, 0,
0,
+	 0},
+	{0,},
+};
+
+static struct pci_driver driver = {
+	.name = "CMD640 IDE",
+	.id_table = cmd640_pci_tbl,
+	.probe = cmd640_init_one,
+};
+
+static int __init
+cmd640_ide_init (void)
+{
+	return ide_pci_register_driver (&driver);
+}
+
+static void __exit
+cmd640_ide_exit (void)
+{
+	ide_pci_unregister_driver (&driver);
+}
+
+module_init (cmd640_ide_init);
+module_exit (cmd640_ide_exit);
+
+MODULE_AUTHOR ("Igor Abramov, Mark Lord, Stefan Talpalaru");
+MODULE_DESCRIPTION ("IDE support for CMD640 controller");
+MODULE_PARM (cmd640_vlb, "i");
+MODULE_PARM_DESC (cmd640_vlb, "Set to enable scanning for VLB
controllers");
+MODULE_LICENSE ("GPL");
 
-MODULE_AUTHOR("See Source");
-MODULE_DESCRIPTION("IDE support for CMD640 controller");
-MODULE_PARM(cmd640_vlb, "i");
-MODULE_PARM_DESC(cmd640_vlb, "Set to enable scanning for VLB
controllers");
-MODULE_LICENSE("GPL");
+EXPORT_NO_SYMBOLS;
diff -urN linux-2.4.22/drivers/ide/pci/cmd640.h
linux-2.4.22-new/drivers/ide/pci/cmd640.h
--- linux-2.4.22/drivers/ide/pci/cmd640.h	2003-09-10 17:18:22.000000000
+0000
+++ linux-2.4.22-new/drivers/ide/pci/cmd640.h	2003-10-26
17:07:10.000000000 +0000
@@ -5,28 +5,28 @@
 #include <linux/pci.h>
 #include <linux/ide.h>
 
-#define IDE_IGNORE      ((void *)-1)
+static void init_hwif_cmd640 (ide_hwif_t *);
 
-static ide_pci_device_t cmd640_chipsets[] __initdata = {
+static ide_pci_device_t cmd640_chipsets[] __devinitdata = {
 	{
-		.vendor		= PCI_VENDOR_ID_CMD,
-		.device		= PCI_DEVICE_ID_CMD_640,
-		.name		= "CMD640",
-		.init_setup	= NULL,
-		.init_chipset	= NULL,
-		.init_iops	= NULL,
-		.init_hwif	= IDE_IGNORE,
-		.init_dma	= NULL,
-		.channels	= 2,
-		.autodma	= NODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-		.bootable	= ON_BOARD,
-		.extra		= 0
-	},{
-		.vendor		= 0,
-		.device		= 0,
-		.bootable	= EOL,
-	}
-}
+	 .vendor = PCI_VENDOR_ID_CMD,
+	 .device = PCI_DEVICE_ID_CMD_640,
+	 .name = "CMD640",
+	 .init_setup = NULL,
+	 .init_chipset = NULL,
+	 .init_iops = NULL,
+	 .init_hwif = init_hwif_cmd640,
+	 .init_dma = NULL,
+	 .channels = 2,
+	 .autodma = NODMA,
+	 .enablebits = {{0x00, 0x00, 0x00}, {0x00, 0x00, 0x00}},
+	 .bootable = ON_BOARD,
+	 .extra = 0}, {
+		       .vendor = 0,
+		       .device = 0,
+		       .channels = 0,
+		       .bootable = EOL,
+		       }
+};
 
-#endif /* CMD640_H */
+#endif				/* CMD640_H */


=====
Stefan Talpalaru

__________________________________
Do you Yahoo!?
Exclusive Video Premiere - Britney Spears
http://launch.yahoo.com/promos/britneyspears/
