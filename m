Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316586AbSGYPSH>; Thu, 25 Jul 2002 11:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316587AbSGYPSG>; Thu, 25 Jul 2002 11:18:06 -0400
Received: from smtp.9tel.net ([213.203.124.147]:51926 "HELO smtp4.9tel.net")
	by vger.kernel.org with SMTP id <S316586AbSGYPSE>;
	Thu, 25 Jul 2002 11:18:04 -0400
Date: Thu, 25 Jul 2002 17:15:42 +0200 (CEST)
From: Samuel Thibault <samuel.thibault@fnac.net>
Reply-To: Samuel Thibault <samuel.thibault@fnac.net>
To: vojtech@suse.cz, martin@dalecki.de
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       andre@linux-ide.org
Subject: Re: [PATCH] drivers/ide/qd65xx: no cli/sti (2.4.19-pre3 & 2.5.28)
In-Reply-To: <20020725105254.A21927@ucw.cz>
Message-ID: <Pine.LNX.4.10.10207251642490.935-100000@bureau.famille.thibault.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 25 Jul 2002, Vojtech Pavlik wrote:

> so the IN_BYTE/OUT_BYTE macros might not work there.

and

> it would be nice if the IDE core guaranteed that no two tuning
> functions would be ever run at the same time. No performance hit, life
> a lot easier.

Oops, I didn't realize that...

Here are corrected patches, according to your notes:
I eventually completely removed qd_read_reg, since it is only needed when
probing when one has to read config & control registers: nothing to do
with tuning or selecting, it shouldn't hurt the board.

--- linux-2.4.19rc3/drivers/ide/qd65xx.c
+++ linux-2.4.19rc3/drivers/ide/qd65xx.c
@@ -90,32 +90,23 @@
 
 static int timings[4]={-1,-1,-1,-1}; /* stores current timing for each timer */
 
+static spinlock_t qd_iolock = SPIN_LOCK_UNLOCKED; /* lock for i/o operations */
+static spinlock_t qd_timlock = SPIN_LOCK_UNLOCKED; /* lock for time computing */
+
 static void qd_write_reg (byte content, byte reg)
 {
 	unsigned long flags;
 
-	save_flags(flags);	/* all CPUs */
-	cli();			/* all CPUs */
+	spin_lock_irqsave(&qd_iolock,flags);
 	outb(content,reg);
-	restore_flags(flags);	/* all CPUs */
-}
-
-byte __init qd_read_reg (byte reg)
-{
-	unsigned long flags;
-	byte read;
-
-	save_flags(flags);	/* all CPUs */
-	cli();			/* all CPUs */
-	read = inb(reg);
-	restore_flags(flags);	/* all CPUs */
-	return read;
+	spin_unlock_irqrestore(&qd_iolock,flags);
 }
 
 /*
  * qd_select:
  *
  * This routine is invoked from ide.c to prepare for access to a given drive.
+ * A timing reg can only be shared within one ata channel.
  */
 
 static void qd_select (ide_drive_t *drive)
@@ -214,15 +205,19 @@
 
 static void qd_set_timing (ide_drive_t *drive, byte timing)
 {
+	unsigned long flags;
 	ide_hwif_t *hwif = HWIF(drive);
 
 	drive->drive_data &= 0xff00;
 	drive->drive_data |= timing;
+
+	spin_lock_irqsave(&qd_timlock,flags);
 	if (qd_timing_ok(hwif->drives)) {
 		qd_select(drive); /* selects once */
 		hwif->selectproc = NULL;
 	} else
 		hwif->selectproc = &qd_select;
+	spin_unlock_irqrestore(&qd_timlock,flags);
 
 	printk(KERN_DEBUG "%s: %#x\n",drive->name,timing);
 }
@@ -313,13 +308,12 @@
 	byte readreg;
 	unsigned long flags;
 
-	save_flags(flags);	/* all CPUs */
-	cli();			/* all CPUs */
+	spin_lock_irqsave(&qd_iolock,flags);
 	savereg = inb_p(port);
 	outb_p(QD_TESTVAL,port);	/* safe value */
 	readreg = inb_p(port);
 	outb(savereg,port);
-	restore_flags(flags);	/* all CPUs */
+	spin_unlock_irqrestore(&qd_iolock,flags);
 
 	if (savereg == QD_TESTVAL) {
 		printk(KERN_ERR "Outch ! the probe for qd65xx isn't reliable !\n");
@@ -338,12 +332,12 @@
  * return 1 if another qd may be probed
  */
 
-int __init probe (int base)
+static int __init qd_probe (int base)
 {
 	byte config;
 	byte index;
 
-	config = qd_read_reg(QD_CONFIG_PORT);
+	config = inb(QD_CONFIG_PORT);
 
 	if (! ((config & QD_CONFIG_BASEPORT) >> 1 == (base == 0xb0)) ) return 1;
 
@@ -387,7 +381,7 @@
 
 			/* qd6580 found */
 
-		control = qd_read_reg(QD_CONTROL_PORT);
+		control = inb(QD_CONTROL_PORT);
 
 		printk(KERN_NOTICE "qd6580 at %#x\n", base);
 		printk(KERN_DEBUG "qd6580: config=%#x, control=%#x, ID3=%u\n",
@@ -403,8 +397,8 @@
 			hwif->chipset = ide_qd65xx;
 			hwif->select_data = base;
 			hwif->config_data = config | (control <<8);
-			hwif->drives[0].drive_data =
-			hwif->drives[1].drive_data = QD6580_DEF_DATA;
+			hwif->drives[0].drive_data = QD6580_DEF_DATA;
+			hwif->drives[1].drive_data = QD6580_DEF_DATA2;
 			hwif->drives[0].io_32bit =
 			hwif->drives[1].io_32bit = 1;
 			hwif->tuneproc = &qd6580_tune_drive;
@@ -452,5 +446,5 @@
 
 void __init init_qd65xx (void)
 {
-	if (probe(0x30)) probe(0xb0);
+	if (qd_probe(0x30)) qd_probe(0xb0);
 }

--- linux-2.5.28/drivers/ide/qd65xx.c
+++ linux-2.5.28/drivers/ide/qd65xx.c
@@ -85,32 +85,23 @@
 
 static int timings[4]={-1,-1,-1,-1}; /* stores current timing for each timer */
 
+static spinlock_t qd_iolock = SPIN_LOCK_UNLOCKED; /* lock for i/o operations */
+static spinlock_t qd_timlock = SPIN_LOCK_UNLOCKED; /* lock for time computing */
+
 static void qd_write_reg(byte content, byte reg)
 {
 	unsigned long flags;
 
-	save_flags(flags);	/* all CPUs */
-	cli();			/* all CPUs */
+	spin_lock_irqsave(&qd_iolock,flags);
 	outb(content,reg);
-	restore_flags(flags);	/* all CPUs */
-}
-
-byte __init qd_read_reg(byte reg)
-{
-	unsigned long flags;
-	byte read;
-
-	save_flags(flags);	/* all CPUs */
-	cli();			/* all CPUs */
-	read = inb(reg);
-	restore_flags(flags);	/* all CPUs */
-	return read;
+	spin_unlock_irqrestore(&qd_iolock,flags);
 }
 
 /*
  * qd_select:
  *
  * This routine is invoked from ide.c to prepare for access to a given drive.
+ * A timing reg can only be shared within one ata channel.
  */
 
 static void qd_select(struct ata_device *drive)
@@ -207,15 +198,19 @@
 
 static void qd_set_timing(struct ata_device *drive, byte timing)
 {
+	unsigned long flags;
 	struct ata_channel *hwif = drive->channel;
 
 	drive->drive_data &= 0xff00;
 	drive->drive_data |= timing;
+
+	spin_lock_irqsave(&qd_timlock,flags);
 	if (qd_timing_ok(hwif->drives)) {
 		qd_select(drive); /* selects once */
 		hwif->selectproc = NULL;
 	} else
 		hwif->selectproc = &qd_select;
+	spin_unlock_irqrestore(&qd_timlock,flags);
 
 	printk(KERN_DEBUG "%s: %#x\n", drive->name, timing);
 }
@@ -309,13 +304,12 @@
 	byte readreg;
 	unsigned long flags;
 
-	save_flags(flags);	/* all CPUs */
-	cli();			/* all CPUs */
+	spin_lock_irqsave(&qd_iolock,flags);
 	savereg = inb_p(port);
 	outb_p(QD_TESTVAL, port);	/* safe value */
 	readreg = inb_p(port);
 	outb(savereg, port);
-	restore_flags(flags);	/* all CPUs */
+	spin_unlock_irqrestore(&qd_iolock,flags);
 
 	if (savereg == QD_TESTVAL) {
 		printk(KERN_ERR "Outch ! the probe for qd65xx isn't reliable !\n");
@@ -333,7 +327,7 @@
  * called to setup an ata channel : adjusts attributes & links for tuning
  */
 
-void __init qd_setup(int unit, int base, int config, unsigned int data0, unsigned int data1, void (*tuneproc) (struct ata_device *, byte pio))
+static void __init qd_setup(int unit, int base, int config, unsigned int data0, unsigned int data1, void (*tuneproc) (struct ata_device *, byte pio))
 {
 	struct ata_channel *hwif = &ide_hwifs[unit];
 
@@ -352,7 +346,7 @@
  *
  * called to unsetup an ata channel : back to default values, unlinks tuning
  */
-void __init qd_unsetup(int unit) {
+static void __init qd_unsetup(int unit) {
 	struct ata_channel *hwif = &ide_hwifs[unit];
 	byte config = hwif->config_data;
 	int base = hwif->select_data;
@@ -388,12 +382,12 @@
  * return 1 if another qd may be probed
  */
 
-int __init qd_probe(int base)
+static int __init qd_probe(int base)
 {
 	byte config;
 	int unit;
 
-	config = qd_read_reg(QD_CONFIG_PORT);
+	config = inb(QD_CONFIG_PORT);
 
 	if (! ((config & QD_CONFIG_BASEPORT) >> 1 == (base == 0xb0)) ) return 1;
 
@@ -424,7 +418,7 @@
 
 		/* qd6580 found */
 
-		control = qd_read_reg(QD_CONTROL_PORT);
+		control = inb(QD_CONTROL_PORT);
 
 		printk(KERN_NOTICE "qd6580 at %#x\n", base);
 		printk(KERN_DEBUG "qd6580: config=%#x, control=%#x, ID3=%u\n", config, control, QD_ID3);

