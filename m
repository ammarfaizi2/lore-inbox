Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317386AbSG2Pqc>; Mon, 29 Jul 2002 11:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317472AbSG2Pqc>; Mon, 29 Jul 2002 11:46:32 -0400
Received: from h-64-105-136-34.SNVACAID.covad.net ([64.105.136.34]:18374 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S317386AbSG2Pq2>; Mon, 29 Jul 2002 11:46:28 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 29 Jul 2002 08:49:32 -0700
Message-Id: <200207291549.IAA04805@adam.yggdrasil.com>
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, martin@dalecki.de
Subject: Re: cli/sti removal from linux-2.5.29/drivers/ide?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Alan Cox wrote:
>> On Mon, 2002-07-29 at 01:26, Adam J. Richter wrote:
>> 
>>>	I have not seen any new IDE patches on lkml since 2.5.29 was
>>>released, nor have I seen any other IDE patches that fix this.  Sorry
>>>if I missed a message about it.
>> 
>> 
>> I've been through them and I have a set but I've not been able to verify
>> they are correct as they relate to vesa/eisa/isa stuff I don't posess.
>> 
>> Martin - is the host lock held when the tuning function is called ?

>Unfortunately not. Not right now. But if you are fixing something
>beneath - please "pretend" it is, since it should :-).

	Here is my first draft of a patch, and my understanding of
the interrupts and locking around channel->tuneproc.

	channel->tuneproc seems to be called in three places:

	1. In drivers/ide/ioctl.c, ata_ioctl calls it with channel->lock
taken and interrupts disabled.

	2. In drivers/ide/probe.c, channel_probe calls
channel->tuneproc before channel->lock is defined, with interupts
enabled, after it has reserved the IO ports with request_region.
Nothing else knows about the IDE, and the IO ports have already been
reserved with request_region, so even another ISA probe running in
parallel should not collide.

	3. In drivers/ide/pcidma.c, ide_register_subdriver calls
channel->udma_setup, which usually results in a call to
generic_udma_setup, which calls channel->tuneproc.
ide_register_subdriver has enabled IRQ's and is not holding
channel->lock.  Although nothing else should be accessing the drive at
that point, I think it is possible that another process could be
accessing a second drive on the same cable and could collide.  I think
this could happen if I were doing a lot of hard disk I/O while I
decide to load the ide-scsi module to talk to my IDE CDROM drive that
is on the same cable as the hard disk.

	To fix the ide_register_subdriver caes, I have attached a
patch below to ide_register_subdriver in drivers/ide/main.c to take
channel->lock and disable interrupts before calling ch->udma_setup,
which is how udma_generic_setup is eventually called.

	With this change, I believe I can remove all of the
cli()...restore_flags() pairs from the channel->tuneproc functions of
each IDE driver.  I have also removed what appear to be some
completely usedly cli()...restore_flags() pairs in qd65xx.c.  Finally,
I changed the cli..restore_flags() in the SCSI tape driver to use
spin_lock_irqflags instead.  This last change I am least sure of.  I
think it should work as well as what it replaced, but it may still be
overkill, as the comments in the code that it replaced mention.

	I am running this patch on a computer with only one IDE hard
disk and one CPU.  I'm working up the courage to install it on a
multiprocessor with multiple hard disks sharing IDE cables.


 Adam J. Richter     __     ______________   575 Oroville Road
 adam@yggdrasil.com     \ /                  Milpitas, California 95035
 +1 408 309-6081         | g g d r a s i l   United States of America
			  "Free Software For The Rest Of Us."

diff -u linux-2.5.29/drivers/ide/main.c linux/drivers/ide/main.c
--- linux-2.5.29/drivers/ide/main.c	2002-07-26 19:58:24.000000000 -0700
+++ linux/drivers/ide/main.c	2002-07-29 07:34:18.000000000 -0700
@@ -1046,11 +1047,13 @@
 			 *   PARANOIA!!!
 			 */
 
+			spin_lock_irqsave(ch->lock, flags);
 			udma_enable(drive, 0, 0);
 			ch->udma_setup(drive, ch->modes_map);
 #ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
 			udma_tcq_enable(drive, 1);
 #endif
+			spin_unlock_irqrestore(ch->lock, flags);
 		}
 
 		/* Only CD-ROMs and tape drives support DSC overlap.  But only
diff -u linux-2.5.29/drivers/ide/ali14xx.c linux/drivers/ide/ali14xx.c
--- linux-2.5.29/drivers/ide/ali14xx.c	2002-07-26 19:58:37.000000000 -0700
+++ linux/drivers/ide/ali14xx.c	2002-07-28 17:57:49.000000000 -0700
@@ -107,13 +107,14 @@
  * Set PIO mode for the specified drive.
  * This function computes timing parameters
  * and sets controller registers accordingly.
+ * It assumes IRQ's are disabled or at least that no other process will
+ * attempt to access the IDE registers concurrently.
  */
 static void ali14xx_tune_drive(struct ata_device *drive, u8 pio)
 {
 	int drive_num;
 	int time1, time2;
 	u8 param1, param2, param3, param4;
-	unsigned long flags;
 	struct ata_timing *t;
 
 	if (pio == 255)
@@ -140,15 +141,12 @@
 
 	/* stuff timing parameters into controller registers */
 	drive_num = (drive->channel->index << 1) + drive->select.b.unit;
-	save_flags(flags);	/* all CPUs */
-	cli();			/* all CPUs */
 	outb_p(reg_on, base_port);
 	out_reg(param1, reg_tab[drive_num].reg1);
 	out_reg(param2, reg_tab[drive_num].reg2);
 	out_reg(param3, reg_tab[drive_num].reg3);
 	out_reg(param4, reg_tab[drive_num].reg4);
 	outb_p(reg_off, base_port);
-	restore_flags(flags);	/* all CPUs */
 }
 
 /*
diff -u linux-2.5.29/drivers/ide/cmd640.c linux/drivers/ide/cmd640.c
--- linux-2.5.29/drivers/ide/cmd640.c	2002-07-26 19:58:37.000000000 -0700
+++ linux/drivers/ide/cmd640.c	2002-07-28 11:53:05.000000000 -0700
@@ -169,14 +169,14 @@
 static u8 prefetch_regs[4]  = {CNTRL, CNTRL, ARTTIM23, ARTTIM23};
 static u8 prefetch_masks[4] = {CNTRL_DIS_RA0, CNTRL_DIS_RA1, ARTTIM23_DIS_RA2, ARTTIM23_DIS_RA3};
 
-#ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
-
 /*
  * Protects register file access from overlapping on primary and secondary
  * channel, since those share hardware resources.
  */
 static spinlock_t cmd640_lock __cacheline_aligned = SPIN_LOCK_UNLOCKED;
 
+#ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
+
 static u8 arttim_regs[4] = {ARTTIM0, ARTTIM1, ARTTIM23, ARTTIM23};
 static u8 drwtim_regs[4] = {DRWTIM0, DRWTIM1, DRWTIM23, DRWTIM23};
 
@@ -214,9 +214,6 @@
  * Therefore, we must use direct IO instead.
  */
 
-/* This is broken, but no more so than the old code.. */
-static spinlock_t cmd640_lock = SPIN_LOCK_UNLOCKED;
-
 /* PCI method 1 access */
 
 static void put_cmd640_reg_pci1 (unsigned short reg, u8 val)
@@ -574,7 +571,7 @@
 	/*
 	 * Now that everything is ready, program the new timings
 	 */
-	spin_lock(&cmd640_lock, flags);
+	spin_lock_irqsave(&cmd640_lock, flags);
 	/*
 	 * Program the address_setup clocks into ARTTIM reg,
 	 * and then the active/recovery counts into the DRWTIM reg
diff -u linux-2.5.29/drivers/ide/cs5530.c linux/drivers/ide/cs5530.c
--- linux-2.5.29/drivers/ide/cs5530.c	2002-07-26 19:58:39.000000000 -0700
+++ linux/drivers/ide/cs5530.c	2002-07-28 18:14:12.000000000 -0700
@@ -227,8 +227,8 @@
 		return 0;
 	}
 
-	save_flags(flags);
-	cli();	/* all CPUs (there should only be one CPU with this chipset) */
+	local_irq_save(flags); /* There should only be one CPU with this
+				  chipset. */
 
 	/*
 	 * Enable BusMaster and MemoryWriteAndInvalidate for the cs5530:
@@ -274,7 +274,7 @@
 	pci_write_config_byte(master_0, 0x42, 0x00);
 	pci_write_config_byte(master_0, 0x43, 0xc1);
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	return 0;
 }
diff -u linux-2.5.29/drivers/ide/dtc2278.c linux/drivers/ide/dtc2278.c
--- linux-2.5.29/drivers/ide/dtc2278.c	2002-07-26 19:58:37.000000000 -0700
+++ linux/drivers/ide/dtc2278.c	2002-07-28 18:13:19.000000000 -0700
@@ -66,21 +66,18 @@
 	}
 }
 
+/* Assumes IRQ's are disabled or at least that no other process will
+   attempt to access the IDE registers concurrently. */
 static void tune_dtc2278(struct ata_device *drive, u8 pio)
 {
-	unsigned long flags;
-
 	pio = ata_timing_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
 
 	if (pio >= 3) {
-		save_flags(flags);	/* all CPUs */
-		cli();			/* all CPUs */
 		/*
 		 * This enables PIO mode4 (3?) on the first interface
 		 */
 		sub22(1,0xc3);
 		sub22(0,0xa0);
-		restore_flags(flags);	/* all CPUs */
 	} else {
 		/* we don't know how to set it back again.. */
 	}
diff -u linux-2.5.29/drivers/ide/ht6560b.c linux/drivers/ide/ht6560b.c
--- linux-2.5.29/drivers/ide/ht6560b.c	2002-07-26 19:58:31.000000000 -0700
+++ linux/drivers/ide/ht6560b.c	2002-07-28 18:11:46.000000000 -0700
@@ -249,12 +249,8 @@
  */
 static void ht_set_prefetch(struct ata_device *drive, u8 state)
 {
-	unsigned long flags;
 	int t = HT_PREFETCH_MODE << 8;
 
-	save_flags (flags);	/* all CPUs */
-	cli();		        /* all CPUs */
-
 	/*
 	 *  Prefetch mode and unmask irq seems to conflict
 	 */
@@ -267,13 +263,12 @@
 		drive->channel->no_unmask = 0;
 	}
 
-	restore_flags (flags);	/* all CPUs */
-
 #ifdef DEBUG
 	printk("ht6560b: drive %s prefetch mode %sabled\n", drive->name, (state ? "en" : "dis"));
 #endif
 }
-
+/* Assumes IRQ's are disabled or at least that no other process will
+   attempt to access the IDE registers concurrently. */
 static void tune_ht6560b(struct ata_device *drive, u8 pio)
 {
 	unsigned long flags;
@@ -288,14 +283,9 @@
 
 	timing = ht_pio2timings(drive, pio);
 
-	save_flags (flags);	/* all CPUs */
-	cli();		        /* all CPUs */
-
 	drive->drive_data &= 0xff00;
 	drive->drive_data |= timing;
 
-	restore_flags (flags);	/* all CPUs */
-
 #ifdef DEBUG
 	printk("ht6560b: drive %s tuned to pio mode %#x timing=%#x\n", drive->name, pio, timing);
 #endif
diff -u linux-2.5.29/drivers/ide/ide-tape.c linux/drivers/ide/ide-tape.c
--- linux-2.5.29/drivers/ide/ide-tape.c	2002-07-26 19:58:30.000000000 -0700
+++ linux/drivers/ide/ide-tape.c	2002-07-28 19:03:42.000000000 -0700
@@ -5892,14 +5892,13 @@
 	int minor = tape->minor;
 	unsigned long flags;
 
-	save_flags (flags);	/* all CPUs (overkill?) */
-	cli();			/* all CPUs (overkill?) */
+	spin_lock_irqsave (&tape->spinlock, flags);	/* overkill? */
 	if (test_bit (IDETAPE_BUSY, &tape->flags) || tape->first_stage != NULL || tape->merge_stage_size || drive->usage) {
-		restore_flags(flags);	/* all CPUs (overkill?) */
+		spin_unlock_irqrestore(&tape->spinlock, flags);
 		return 1;
 	}
 	idetape_chrdevs[minor].drive = NULL;
-	restore_flags (flags);	/* all CPUs (overkill?) */
+	spin_unlock_irqrestore(&tape->spinlock, flags);
 
 	MOD_DEC_USE_COUNT;
 
diff -u linux-2.5.29/drivers/ide/it8172.c linux/drivers/ide/it8172.c
--- linux-2.5.29/drivers/ide/it8172.c	2002-07-26 19:58:27.000000000 -0700
+++ linux/drivers/ide/it8172.c	2002-07-29 04:46:47.000000000 -0700
@@ -89,10 +89,7 @@
 	    drive_enables |= 0x0006;
     }
 
-    save_flags(flags);
-    cli();
 	pci_write_config_word(dev, master_port, master_data);
-    restore_flags(flags);
 }
 
 #if defined(CONFIG_BLK_DEV_IDEDMA) && defined(CONFIG_IT8172_TUNING)
diff -u linux-2.5.29/drivers/ide/opti621.c linux/drivers/ide/opti621.c
--- linux-2.5.29/drivers/ide/opti621.c	2002-07-26 19:58:30.000000000 -0700
+++ linux/drivers/ide/opti621.c	2002-07-28 18:04:37.000000000 -0700
@@ -244,13 +244,15 @@
 
 }
 
-/* Main tune procedure, called from tuneproc. */
+/* Main tune procedure, called from tuneproc.
+   Assumes IRQ's are disabled or at least that no other process will
+   attempt to access the IDE registers concurrently.
+*/
 static void opti621_tune_drive(struct ata_device *drive, u8 pio)
 {
 	/* primary and secondary drives share some registers,
 	 * so we have to program both drives
 	 */
-	unsigned long flags;
 	u8 pio1, pio2;
 	pio_clocks_t first, second;
 	int ax, drdy;
@@ -281,9 +283,6 @@
 		hwif->name, ax, second.data_time, second.recovery_time, drdy);
 #endif
 
-	save_flags(flags);	/* all CPUs */
-	cli();			/* all CPUs */
-
 	reg_base = hwif->io_ports[IDE_DATA_OFFSET];
 	outb(0xc0, reg_base+CNTRL_REG);	/* allow Register-B */
 	outb(0xff, reg_base+5);		/* hmm, setupvic.exe does this ;-) */
@@ -306,8 +305,6 @@
 
 	write_reg(misc, MISC_REG);	/* set address setup, DRDY timings,   */
 					/*  and read prefetch for both drives */
-
-	restore_flags(flags);	/* all CPUs */
 }
 
 /*
diff -u linux-2.5.29/drivers/ide/qd65xx.c linux/drivers/ide/qd65xx.c
--- linux-2.5.29/drivers/ide/qd65xx.c	2002-07-26 19:58:33.000000000 -0700
+++ linux/drivers/ide/qd65xx.c	2002-07-28 18:03:24.000000000 -0700
@@ -88,24 +88,12 @@
 
 static void qd_write_reg(u8 content, unsigned int reg)
 {
-	unsigned long flags;
-
-	save_flags(flags);	/* all CPUs */
-	cli();			/* all CPUs */
 	outb(content,reg);
-	restore_flags(flags);	/* all CPUs */
 }
 
 static u8 __init qd_read_reg(unsigned int reg)
 {
-	unsigned long flags;
-	u8 read;
-
-	save_flags(flags);	/* all CPUs */
-	cli();			/* all CPUs */
-	read = inb(reg);
-	restore_flags(flags);	/* all CPUs */
-	return read;
+	return inb(reg);
 }
 
 /*
@@ -308,16 +296,12 @@
 {
 	u8 savereg;
 	u8 readreg;
-	unsigned long flags;
 
-	save_flags(flags);	/* all CPUs */
-	cli();			/* all CPUs */
 	savereg = inb_p(port);
 	outb_p(QD_TESTVAL, port);	/* safe value */
 	readreg = inb_p(port);
 	outb(savereg, port);
-	restore_flags(flags);	/* all CPUs */
 
 	if (savereg == QD_TESTVAL) {
 		printk(KERN_ERR "Outch ! the probe for qd65xx isn't reliable !\n");
diff -u linux-2.5.29/drivers/ide/umc8672.c linux/drivers/ide/umc8672.c
--- linux-2.5.29/drivers/ide/umc8672.c	2002-07-26 19:58:34.000000000 -0700
+++ linux/drivers/ide/umc8672.c	2002-07-28 18:03:55.000000000 -0700
@@ -106,21 +106,18 @@
 		speeds[0], speeds[1], speeds[2], speeds[3]);
 }
 
+/* Assumes IRQ's are disabled or at least that no other process will
+   attempt to access the IDE registers concurrently. */
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

