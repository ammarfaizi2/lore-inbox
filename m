Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313202AbSG3ScX>; Tue, 30 Jul 2002 14:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315928AbSG3ScX>; Tue, 30 Jul 2002 14:32:23 -0400
Received: from [64.105.35.245] ([64.105.35.245]:62111 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S313202AbSG3ScU>; Tue, 30 Jul 2002 14:32:20 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 30 Jul 2002 11:35:27 -0700
Message-Id: <200207301835.LAA02863@baldur.yggdrasil.com>
To: martin@dalecki.de
Subject: Re: cli/sti removal from linux-2.5.29/drivers/ide?
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Please just send me a single diff against 2.5.29 + 108 + 109 just
>posted. This would make me happy. Thanks.

	Here is a patch against 108+109, but without Alan and Andre's
cmd640 changes, because of the questions that I just emailed about
that patch.  I can make a patch for that one later.

	I am also holding off on submitting the patch to have
ide/probe.c disable interrupts before calling ch->tuneproc, as
I do not think anything else will touch the IO ports in question
and I haven't gotten an answer on whether an unrelated interrupt
could cause a problem with the tuning just on account of timing
and unrelated bus activity.

	Anyhow, this patch includes the following changes:

	1. Alan Cox's cs5530 patches, plus I deleted two variables that
	   are no longer used as a result of Alan's changes.

	2. umc8672.c cli/sti removal.  I must have missed this file before.

	3. qd65xx.c cil/sti removal.  I changed cli/sti to
	   local_irq_{save,restore} in what appears to be a
	   probably obselete sanity check routine.  It does not
	   cause any additional detections of problems, although it
	   could fail to discover a problem in a very improbable
	   situation on a multiprocesor.  However, the detection was not
	   perfect to begin with anyhow.

	I plan to submit the cmd640 and probe.c changes, but I thought
I ought not delay the cs5530 and umc8672 changes in the meantime.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

diff -u linux-2.5.29-ide109/drivers/ide/cs5530.c linux/drivers/ide/cs5530.c
--- linux-2.5.29-ide109/drivers/ide/cs5530.c	2002-07-30 07:27:09.000000000 -0700
+++ linux/drivers/ide/cs5530.c	2002-07-30 08:39:29.000000000 -0700
@@ -203,8 +203,6 @@
 static unsigned int __init pci_init_cs5530(struct pci_dev *dev)
 {
 	struct pci_dev *master_0 = NULL, *cs5530_0 = NULL;
-	unsigned short pcicmd = 0;
-	unsigned long flags;
 
 	pci_for_each_dev(dev) {
 		if (dev->vendor == PCI_VENDOR_ID_CYRIX) {
@@ -218,6 +216,7 @@
 			}
 		}
 	}
+
 	if (!master_0) {
 		printk("%s: unable to locate PCI MASTER function\n", dev->name);
 		return 0;
@@ -227,15 +226,11 @@
 		return 0;
 	}
 
-	local_irq_save(flags); /* There should only be one CPU with this
-				  chipset. */
-
 	/*
 	 * Enable BusMaster and MemoryWriteAndInvalidate for the cs5530:
-	 * -->  OR 0x14 into 16-bit PCI COMMAND reg of function 0 of the cs5530
 	 */
-	pci_read_config_word (cs5530_0, PCI_COMMAND, &pcicmd);
-	pci_write_config_word(cs5530_0, PCI_COMMAND, pcicmd | PCI_COMMAND_MASTER | PCI_COMMAND_INVALIDATE);
+	pci_set_master(cs5530_0);
+	pci_set_mwi(cs5530_0);
 
 	/*
 	 * Set PCI CacheLineSize to 16-bytes:
@@ -274,8 +269,6 @@
 	pci_write_config_byte(master_0, 0x42, 0x00);
 	pci_write_config_byte(master_0, 0x43, 0xc1);
 
-	local_irq_restore(flags);
-
 	return 0;
 }
 
diff -u linux-2.5.29-ide109/drivers/ide/qd65xx.c linux/drivers/ide/qd65xx.c
--- linux-2.5.29-ide109/drivers/ide/qd65xx.c	2002-07-30 07:27:09.000000000 -0700
+++ linux/drivers/ide/qd65xx.c	2002-07-30 08:43:30.000000000 -0700
@@ -264,14 +264,18 @@
 	u8 readreg;
 	unsigned long flags;
 
-	save_flags(flags);	/* all CPUs */
-	cli();			/* all CPUs */
+	/* As of 2.5.29, we no longer have cli(), and there is no lock that
+	   we can take on all IO ports, so we can only lock out local
+	   interrupts.  This routine is an unreliable debugging aid that
+	   has served its purpose and should probably be removed anyhow.
+	   -Adam J. Richter, 2002.07.30 */
+	local_irq_save(flags);
 	savereg = inb_p(port);
 	outb_p(QD_TESTVAL, port);	/* safe value */
 	readreg = inb_p(port);
 	outb(savereg, port);
-	restore_flags(flags);	/* all CPUs */
+	local_irq_restore(flags);
 
 	if (savereg == QD_TESTVAL) {
 		printk(KERN_ERR "Outch ! the probe for qd65xx isn't reliable !\n");
diff -u linux-2.5.29-ide109/drivers/ide/umc8672.c linux/drivers/ide/umc8672.c
--- linux-2.5.29-ide109/drivers/ide/umc8672.c	2002-07-28 08:24:39.000000000 -0700
+++ linux/drivers/ide/umc8672.c	2002-07-30 07:50:08.000000000 -0700
@@ -108,19 +108,14 @@
 
 static void tune_umc(struct ata_device *drive, u8 pio)
 {
-	unsigned long flags;
-
 	if (pio == 255)
 		pio = ata_timing_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
 	else
 		pio = min_t(u8, pio, 4);
 
 	printk("%s: setting umc8672 to PIO mode%d (speed %d)\n", drive->name, pio, pio_to_umc[pio]);
-	save_flags(flags);	/* all CPUs */
-	cli();			/* all CPUs */
 	current_speeds[drive->name[2] - 'a'] = pio_to_umc[pio];
 	umc_set_speeds (current_speeds);
-	restore_flags(flags);	/* all CPUs */
 }
 
 void __init init_umc8672(void)	/* called from ide.c */
