Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315388AbSG3JNP>; Tue, 30 Jul 2002 05:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315413AbSG3JNP>; Tue, 30 Jul 2002 05:13:15 -0400
Received: from [195.63.194.11] ([195.63.194.11]:15 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S315388AbSG3JMe>;
	Tue, 30 Jul 2002 05:12:34 -0400
Message-ID: <3D45AAB4.1030409@evision.ag>
Date: Mon, 29 Jul 2002 22:51:00 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de, martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.29 IDE 109
References: <Pine.LNX.4.33.0207262004550.1357-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------020204070100080001030001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020204070100080001030001
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

- Include first cut by Adam J. Richter on proper lock protection for
    tuning functions.

- Rename ide_register_subdriver() to ata_register_device() and
    ide_unregister_subdriver() accordingly to ata_unregister_device(),
    since this is reflecting better what those functions are about.

- Remove tons of "curicum vite" style useless documentation here and
    there.



--------------020204070100080001030001
Content-Type: text/plain;
 name="ide-109.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-109.diff"

diff -durNp -X /tmp/diff.X8zbex linux-2.5.29/Documentation/ide.txt linux/Documentation/ide.txt
--- linux-2.5.29/Documentation/ide.txt	2002-07-27 04:58:29.000000000 +0200
+++ linux/Documentation/ide.txt	2002-07-29 22:14:20.000000000 +0200
@@ -1,9 +1,6 @@
 
-
-
 	Information regarding the Enhanced IDE drive in Linux 2.5
 
-
 ==============================================================================
 
    
@@ -303,6 +300,53 @@ Everything else is rejected with a "BAD 
 
 ================================================================================
 
+IDE ATAPI streaming tape driver
+-------------------------------
+
+This driver is a part of the Linux ide driver and works in co-operation
+with linux/drivers/block/ide.c.
+
+The driver, in co-operation with ide.c, basically traverses the
+request-list for the block device interface. The character device
+interface, on the other hand, creates new requests, adds them
+to the request-list of the block device, and waits for their completion.
+
+Pipelined operation mode is now supported on both reads and writes.
+
+The block device major and minor numbers are determined from the
+tape's relative position in the ide interfaces, as explained in ide.c.
+
+The character device interface consists of the following devices:
+
+ ht0		major 37, minor 0	first  IDE tape, rewind on close.
+ ht1		major 37, minor 1	second IDE tape, rewind on close.
+ ...
+ nht0		major 37, minor 128	first  IDE tape, no rewind on close.
+ nht1		major 37, minor 129	second IDE tape, no rewind on close.
+ ...
+
+Run linux/scripts/MAKEDEV.ide to create the above entries.
+
+The general magnetic tape commands compatible interface, as defined by
+include/linux/mtio.h, is accessible through the character device.
+
+General ide driver configuration options, such as the interrupt-unmask
+flag, can be configured by issuing an ioctl to the block device interface,
+as any other ide device.
+
+Our own ide-tape ioctl's can be issued to either the block device or
+the character device interface.
+
+Maximal throughput with minimal bus load will usually be achieved in the
+following scenario:
+
+	1.	ide-tape is operating in the pipelined operation mode.
+	2.	No buffering is performed by the user backup program.
+
+
+
+================================================================================
+
 Some Terminology
 ----------------
 IDE = Integrated Drive Electronics, meaning that each drive has a built-in
diff -durNp -X /tmp/diff.X8zbex linux-2.5.29/drivers/ide/ali14xx.c linux/drivers/ide/ali14xx.c
--- linux-2.5.29/drivers/ide/ali14xx.c	2002-07-27 04:58:37.000000000 +0200
+++ linux/drivers/ide/ali14xx.c	2002-07-29 21:35:50.000000000 +0200
@@ -107,13 +107,14 @@ static inline void out_reg(u8 data, u8 r
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
@@ -140,15 +141,12 @@ static void ali14xx_tune_drive(struct at
 
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
diff -durNp -X /tmp/diff.X8zbex linux-2.5.29/drivers/ide/cs5530.c linux/drivers/ide/cs5530.c
--- linux-2.5.29/drivers/ide/cs5530.c	2002-07-27 04:58:39.000000000 +0200
+++ linux/drivers/ide/cs5530.c	2002-07-29 21:35:50.000000000 +0200
@@ -227,8 +227,8 @@ static unsigned int __init pci_init_cs55
 		return 0;
 	}
 
-	save_flags(flags);
-	cli();	/* all CPUs (there should only be one CPU with this chipset) */
+	local_irq_save(flags); /* There should only be one CPU with this
+				  chipset. */
 
 	/*
 	 * Enable BusMaster and MemoryWriteAndInvalidate for the cs5530:
@@ -274,7 +274,7 @@ static unsigned int __init pci_init_cs55
 	pci_write_config_byte(master_0, 0x42, 0x00);
 	pci_write_config_byte(master_0, 0x43, 0xc1);
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	return 0;
 }
diff -durNp -X /tmp/diff.X8zbex linux-2.5.29/drivers/ide/dtc2278.c linux/drivers/ide/dtc2278.c
--- linux-2.5.29/drivers/ide/dtc2278.c	2002-07-27 04:58:37.000000000 +0200
+++ linux/drivers/ide/dtc2278.c	2002-07-29 21:35:50.000000000 +0200
@@ -66,21 +66,18 @@ static void sub22 (char b, char c)
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
diff -durNp -X /tmp/diff.X8zbex linux-2.5.29/drivers/ide/ht6560b.c linux/drivers/ide/ht6560b.c
--- linux-2.5.29/drivers/ide/ht6560b.c	2002-07-27 04:58:31.000000000 +0200
+++ linux/drivers/ide/ht6560b.c	2002-07-29 21:43:52.000000000 +0200
@@ -249,12 +249,8 @@ static u8 ht_pio2timings(struct ata_devi
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
@@ -267,16 +263,16 @@ static void ht_set_prefetch(struct ata_d
 		drive->channel->no_unmask = 0;
 	}
 
-	restore_flags (flags);	/* all CPUs */
-
 #ifdef DEBUG
 	printk("ht6560b: drive %s prefetch mode %sabled\n", drive->name, (state ? "en" : "dis"));
 #endif
 }
 
+/* Assumes IRQ's are disabled or at least that no other process will attempt to
+ * access the IDE registers concurrently.
+ */
 static void tune_ht6560b(struct ata_device *drive, u8 pio)
 {
-	unsigned long flags;
 	u8 timing;
 
 	switch (pio) {
@@ -288,14 +284,9 @@ static void tune_ht6560b(struct ata_devi
 
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
diff -durNp -X /tmp/diff.X8zbex linux-2.5.29/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.29/drivers/ide/ide-cd.c	2002-07-29 21:27:35.000000000 +0200
+++ linux/drivers/ide/ide-cd.c	2002-07-29 22:18:01.000000000 +0200
@@ -2915,7 +2915,7 @@ int ide_cdrom_cleanup(struct ata_device 
 	struct cdrom_info *info = drive->driver_data;
 	struct cdrom_device_info *devinfo = &info->devinfo;
 
-	if (ide_unregister_subdriver (drive))
+	if (ata_unregister_device(drive))
 		return 1;
 	if (info->buffer != NULL)
 		kfree(info->buffer);
@@ -2974,7 +2974,7 @@ static void ide_cdrom_attach(struct ata_
 		printk(KERN_ERR "%s: Can't allocate a cdrom structure\n", drive->name);
 		return;
 	}
-	if (ide_register_subdriver (drive, &ide_cdrom_driver)) {
+	if (ata_register_device(drive, &ide_cdrom_driver)) {
 		printk(KERN_ERR "%s: Failed to register the driver with ide.c\n", drive->name);
 		kfree (info);
 		return;
diff -durNp -X /tmp/diff.X8zbex linux-2.5.29/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.29/drivers/ide/ide-disk.c	2002-07-27 04:58:24.000000000 +0200
+++ linux/drivers/ide/ide-disk.c	2002-07-29 22:17:16.000000000 +0200
@@ -1279,7 +1279,7 @@ static int idedisk_cleanup(struct ata_de
 			printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
 				drive->name);
 	}
-	ret = ide_unregister_subdriver(drive);
+	ret = ata_unregister_device(drive);
 
 	/* FIXME: This is killing the kernel with BUG 185 at asm/spinlocks.h
 	 * horribly.  Check whatever we did REGISTER the device properly
@@ -1471,8 +1471,8 @@ static void idedisk_attach(struct ata_de
 	if (req[0] != '\0' && strcmp(req, "ide-disk"))
 		return;
 
-	if (ide_register_subdriver(drive, &idedisk_driver)) {
-		printk (KERN_ERR "ide-disk: %s: Failed to register the driver with ide.c\n", drive->name);
+	if (ata_register_device(drive, &idedisk_driver)) {
+		printk(KERN_ERR "%s: Failed to register the driver with ide.c\n", drive->name);
 		return;
 	}
 
diff -durNp -X /tmp/diff.X8zbex linux-2.5.29/drivers/ide/ide-floppy.c linux/drivers/ide/ide-floppy.c
--- linux-2.5.29/drivers/ide/ide-floppy.c	2002-07-29 21:27:35.000000000 +0200
+++ linux/drivers/ide/ide-floppy.c	2002-07-29 22:17:48.000000000 +0200
@@ -1723,10 +1723,10 @@ static int idefloppy_cleanup(struct ata_
 {
 	idefloppy_floppy_t *floppy = drive->driver_data;
 
-	if (ide_unregister_subdriver (drive))
+	if (ata_unregister_device(drive))
 		return 1;
 	drive->driver_data = NULL;
-	kfree (floppy);
+	kfree(floppy);
 	return 0;
 }
 
@@ -1780,7 +1780,7 @@ static void idefloppy_attach(struct ata_
 				drive->name);
 		return;
 	}
-	if (ide_register_subdriver(drive, &idefloppy_driver)) {
+	if (ata_register_device(drive, &idefloppy_driver)) {
 		printk(KERN_ERR "ide-floppy: %s: Failed to register the driver with ide.c\n", drive->name);
 		kfree (floppy);
 		return;
diff -durNp -X /tmp/diff.X8zbex linux-2.5.29/drivers/ide/ide-tape.c linux/drivers/ide/ide-tape.c
--- linux-2.5.29/drivers/ide/ide-tape.c	2002-07-29 21:27:35.000000000 +0200
+++ linux/drivers/ide/ide-tape.c	2002-07-29 22:17:27.000000000 +0200
@@ -7,401 +7,18 @@
  *
  * It is hereby placed under the terms of the GNU general public license.
  * (See linux/COPYING).
- */
-
-/*
- * BIG FAT FIXME: clean tape->spinlock locking  --bzolnier
- */
-
-/*
- * IDE ATAPI streaming tape driver.
- *
- * This driver is a part of the Linux ide driver and works in co-operation
- * with linux/drivers/block/ide.c.
- *
- * The driver, in co-operation with ide.c, basically traverses the
- * request-list for the block device interface. The character device
- * interface, on the other hand, creates new requests, adds them
- * to the request-list of the block device, and waits for their completion.
- *
- * Pipelined operation mode is now supported on both reads and writes.
- *
- * The block device major and minor numbers are determined from the
- * tape's relative position in the ide interfaces, as explained in ide.c.
- *
- * The character device interface consists of the following devices:
- *
- * ht0		major 37, minor 0	first  IDE tape, rewind on close.
- * ht1		major 37, minor 1	second IDE tape, rewind on close.
- * ...
- * nht0		major 37, minor 128	first  IDE tape, no rewind on close.
- * nht1		major 37, minor 129	second IDE tape, no rewind on close.
- * ...
- *
- * Run linux/scripts/MAKEDEV.ide to create the above entries.
- *
- * The general magnetic tape commands compatible interface, as defined by
- * include/linux/mtio.h, is accessible through the character device.
- *
- * General ide driver configuration options, such as the interrupt-unmask
- * flag, can be configured by issuing an ioctl to the block device interface,
- * as any other ide device.
  *
- * Our own ide-tape ioctl's can be issued to either the block device or
- * the character device interface.
- *
- * Maximal throughput with minimal bus load will usually be achieved in the
- * following scenario:
- *
- *	1.	ide-tape is operating in the pipelined operation mode.
- *	2.	No buffering is performed by the user backup program.
- *
- * Testing was done with a 2 GB CONNER CTMA 4000 IDE ATAPI Streaming Tape Drive.
- * 
- * Ver 0.1   Nov  1 95   Pre-working code :-)
- * Ver 0.2   Nov 23 95   A short backup (few megabytes) and restore procedure
- *                        was successful ! (Using tar cvf ... on the block
- *                        device interface).
- *                       A longer backup resulted in major swapping, bad
- *                        overall Linux performance and eventually failed as
- *                        we received non serial read-ahead requests from the
- *                        buffer cache.
- * Ver 0.3   Nov 28 95   Long backups are now possible, thanks to the
- *                        character device interface. Linux's responsiveness
- *                        and performance doesn't seem to be much affected
- *                        from the background backup procedure.
- *                       Some general mtio.h magnetic tape operations are
- *                        now supported by our character device. As a result,
- *                        popular tape utilities are starting to work with
- *                        ide tapes :-)
- *                       The following configurations were tested:
- *                       	1. An IDE ATAPI TAPE shares the same interface
- *                       	   and irq with an IDE ATAPI CDROM.
- *                        	2. An IDE ATAPI TAPE shares the same interface
- *                          	   and irq with a normal IDE disk.
- *                        Both configurations seemed to work just fine !
- *                        However, to be on the safe side, it is meanwhile
- *                        recommended to give the IDE TAPE its own interface
- *                        and irq.
- *                       The one thing which needs to be done here is to
- *                        add a "request postpone" feature to ide.c,
- *                        so that we won't have to wait for the tape to finish
- *                        performing a long media access (DSC) request (such
- *                        as a rewind) before we can access the other device
- *                        on the same interface. This effect doesn't disturb
- *                        normal operation most of the time because read/write
- *                        requests are relatively fast, and once we are
- *                        performing one tape r/w request, a lot of requests
- *                        from the other device can be queued and ide.c will
- *			  service all of them after this single tape request.
- * Ver 1.0   Dec 11 95   Integrated into Linux 1.3.46 development tree.
- *                       On each read / write request, we now ask the drive
- *                        if we can transfer a constant number of bytes
- *                        (a parameter of the drive) only to its buffers,
- *                        without causing actual media access. If we can't,
- *                        we just wait until we can by polling the DSC bit.
- *                        This ensures that while we are not transferring
- *                        more bytes than the constant referred to above, the
- *                        interrupt latency will not become too high and
- *                        we won't cause an interrupt timeout, as happened
- *                        occasionally in the previous version.
- *                       While polling for DSC, the current request is
- *                        postponed and ide.c is free to handle requests from
- *                        the other device. This is handled transparently to
- *                        ide.c. The hwgroup locking method which was used
- *                        in the previous version was removed.
- *                       Use of new general features which are provided by
- *                        ide.c for use with atapi devices.
- *                        (Programming done by Mark Lord)
- *                       Few potential bug fixes (Again, suggested by Mark)
- *                       Single character device data transfers are now
- *                        not limited in size, as they were before.
- *                       We are asking the tape about its recommended
- *                        transfer unit and send a larger data transfer
- *                        as several transfers of the above size.
- *                        For best results, use an integral number of this
- *                        basic unit (which is shown during driver
- *                        initialization). I will soon add an ioctl to get
- *                        this important parameter.
- *                       Our data transfer buffer is allocated on startup,
- *                        rather than before each data transfer. This should
- *                        ensure that we will indeed have a data buffer.
- * Ver 1.1   Dec 14 95   Fixed random problems which occurred when the tape
- *                        shared an interface with another device.
- *                        (poll_for_dsc was a complete mess).
- *                       Removed some old (non-active) code which had
- *                        to do with supporting buffer cache originated
- *                        requests.
- *                       The block device interface can now be opened, so
- *                        that general ide driver features like the unmask
- *                        interrupts flag can be selected with an ioctl.
- *                        This is the only use of the block device interface.
- *                       New fast pipelined operation mode (currently only on
- *                        writes). When using the pipelined mode, the
- *                        throughput can potentially reach the maximum
- *                        tape supported throughput, regardless of the
- *                        user backup program. On my tape drive, it sometimes
- *                        boosted performance by a factor of 2. Pipelined
- *                        mode is enabled by default, but since it has a few
- *                        downfalls as well, you may want to disable it.
- *                        A short explanation of the pipelined operation mode
- *                        is available below.
- * Ver 1.2   Jan  1 96   Eliminated pipelined mode race condition.
- *                       Added pipeline read mode. As a result, restores
- *                        are now as fast as backups.
- *                       Optimized shared interface behavior. The new behavior
- *                        typically results in better IDE bus efficiency and
- *                        higher tape throughput.
- *                       Pre-calculation of the expected read/write request
- *                        service time, based on the tape's parameters. In
- *                        the pipelined operation mode, this allows us to
- *                        adjust our polling frequency to a much lower value,
- *                        and thus to dramatically reduce our load on Linux,
- *                        without any decrease in performance.
- *                       Implemented additional mtio.h operations.
- *                       The recommended user block size is returned by
- *                        the MTIOCGET ioctl.
- *                       Additional minor changes.
- * Ver 1.3   Feb  9 96   Fixed pipelined read mode bug which prevented the
- *                        use of some block sizes during a restore procedure.
- *                       The character device interface will now present a
- *                        continuous view of the media - any mix of block sizes
- *                        during a backup/restore procedure is supported. The
- *                        driver will buffer the requests internally and
- *                        convert them to the tape's recommended transfer
- *                        unit, making performance almost independent of the
- *                        chosen user block size.
- *                       Some improvements in error recovery.
- *                       By cooperating with ide-dma.c, bus mastering DMA can
- *                        now sometimes be used with IDE tape drives as well.
- *                        Bus mastering DMA has the potential to dramatically
- *                        reduce the CPU's overhead when accessing the device,
- *                        and can be enabled by using hdparm -d1 on the tape's
- *                        block device interface. For more info, read the
- *                        comments in ide-dma.c.
- * Ver 1.4   Mar 13 96   Fixed serialize support.
- * Ver 1.5   Apr 12 96   Fixed shared interface operation, broken in 1.3.85.
- *                       Fixed pipelined read mode inefficiency.
- *                       Fixed nasty null dereferencing bug.
- * Ver 1.6   Aug 16 96   Fixed FPU usage in the driver.
- *                       Fixed end of media bug.
- * Ver 1.7   Sep 10 96   Minor changes for the CONNER CTT8000-A model.
- * Ver 1.8   Sep 26 96   Attempt to find a better balance between good
- *                        interactive response and high system throughput.
- * Ver 1.9   Nov  5 96   Automatically cross encountered filemarks rather
- *                        than requiring an explicit FSF command.
- *                       Abort pending requests at end of media.
- *                       MTTELL was sometimes returning incorrect results.
- *                       Return the real block size in the MTIOCGET ioctl.
- *                       Some error recovery bug fixes.
- * Ver 1.10  Nov  5 96   Major reorganization.
- *                       Reduced CPU overhead a bit by eliminating internal
- *                        bounce buffers.
- *                       Added module support.
- *                       Added multiple tape drives support.
- *                       Added partition support.
- *                       Rewrote DSC handling.
- *                       Some portability fixes.
- *                       Removed ide-tape.h.
- *                       Additional minor changes.
- * Ver 1.11  Dec  2 96   Bug fix in previous DSC timeout handling.
- *                       Use ide_stall_queue() for DSC overlap.
- *                       Use the maximum speed rather than the current speed
- *                        to compute the request service time.
- * Ver 1.12  Dec  7 97   Fix random memory overwriting and/or last block data
- *                        corruption, which could occur if the total number
- *                        of bytes written to the tape was not an integral
- *                        number of tape blocks.
- *                       Add support for INTERRUPT DRQ devices.
- * Ver 1.13  Jan  2 98   Add "speed == 0" work-around for HP COLORADO 5GB
- * Ver 1.14  Dec 30 98   Partial fixes for the Sony/AIWA tape drives.
- *                       Replace cli()/sti() with hwgroup spinlocks.
- * Ver 1.15  Mar 25 99   Fix SMP race condition by replacing hwgroup
- *                        spinlock with private per-tape spinlock.
- * Ver 1.16  Sep  1 99   Add OnStream tape support.
- *                       Abort read pipeline on EOD.
- *                       Wait for the tape to become ready in case it returns
- *                        "in the process of becoming ready" on open().
- *                       Fix zero padding of the last written block in
- *                        case the tape block size is larger than PAGE_SIZE.
- *                       Decrease the default disconnection time to tn.
- * Ver 1.16e Oct  3 99   Minor fixes.
- * Ver 1.16e1 Oct 13 99  Patches by Arnold Niessen,
- *                          niessen@iae.nl / arnold.niessen@philips.com
- *                   GO-1)  Undefined code in idetape_read_position
- *				according to Gadi's email
- *                   AJN-1) Minor fix asc == 11 should be asc == 0x11
- *                               in idetape_issue_packet_command (did effect
- *                               debugging output only)
- *                   AJN-2) Added more debugging output, and
- *                              added ide-tape: where missing. I would also
- *				like to add tape->name where possible
- *                   AJN-3) Added different debug_level's 
- *                              via /proc/ide/hdc/settings
- * 				"debug_level" determines amount of debugging output;
- * 				can be changed using /proc/ide/hdx/settings
- * 				0 : almost no debugging output
- * 				1 : 0+output errors only
- * 				2 : 1+output all sensekey/asc
- * 				3 : 2+follow all chrdev related procedures
- * 				4 : 3+follow all procedures
- * 				5 : 4+include pc_stack rq_stack info
- * 				6 : 5+USE_COUNT updates
- *                   AJN-4) Fixed timeout for retension in idetape_queue_pc_tail
- *				from 5 to 10 minutes
- *                   AJN-5) Changed maximum number of blocks to skip when
- *                              reading tapes with multiple consecutive write
- *                              errors from 100 to 1000 in idetape_get_logical_blk
- *                   Proposed changes to code:
- *                   1) output "logical_blk_num" via /proc
- *                   2) output "current_operation" via /proc
- *                   3) Either solve or document the fact that `mt rewind' is
- *                      required after reading from /dev/nhtx to be
- *			able to rmmod the idetape module;
- *			Also, sometimes an application finishes but the
- *			device remains `busy' for some time. Same cause ?
- *                   Proposed changes to release-notes:
- *		     4) write a simple `quickstart' section in the
- *                      release notes; I volunteer if you don't want to
- * 		     5) include a pointer to video4linux in the doc
- *                      to stimulate video applications
- *                   6) release notes lines 331 and 362: explain what happens
- *			if the application data rate is higher than 1100 KB/s; 
- *			similar approach to lower-than-500 kB/s ?
- *		     7) 6.6 Comparison; wouldn't it be better to allow different 
- *			strategies for read and write ?
- *			Wouldn't it be better to control the tape buffer
- *			contents instead of the bandwidth ?
- *		     8) line 536: replace will by would (if I understand
- *			this section correctly, a hypothetical and unwanted situation
- *			 is being described)
- * Ver 1.16f Dec 15 99   Change place of the secondary OnStream header frames.
- * Ver 1.17  Nov 2000 / Jan 2001  Marcel Mol, marcel@mesa.nl
- *			- Add idetape_onstream_mode_sense_tape_parameter_page
- *			  function to get tape capacity in frames: tape->capacity.
- *			- Add support for DI-50 drives( or any DI- drive).
- *			- 'workaround' for read error/blank block arround block 3000.
- *			- Implement Early warning for end of media for Onstream.
- *			- Cosmetic code changes for readability.
- *			- Idetape_position_tape should not use SKIP bit during
- *			  Onstream read recovery.
- *			- Add capacity, logical_blk_num and first/last_frame_position
- *			  to /proc/ide/hd?/settings.
- *			- Module use count was gone in the Linux 2.4 driver.
- * Ver 1.17a Apr 2001 Willem Riede osst@riede.org
- * 			- Get drive's actual block size from mode sense block descriptor
- * 			- Limit size of pipeline
- *
- * Here are some words from the first releases of hd.c, which are quoted
- * in ide.c and apply here as well:
- *
- * | Special care is recommended.  Have Fun!
- *
- */
-
-/*
- * An overview of the pipelined operation mode.
- *
- * In the pipelined write mode, we will usually just add requests to our
- * pipeline and return immediately, before we even start to service them. The
- * user program will then have enough time to prepare the next request while
- * we are still busy servicing previous requests. In the pipelined read mode,
- * the situation is similar - we add read-ahead requests into the pipeline,
- * before the user even requested them.
- *
- * The pipeline can be viewed as a "safety net" which will be activated when
- * the system load is high and prevents the user backup program from keeping up
- * with the current tape speed. At this point, the pipeline will get
- * shorter and shorter but the tape will still be streaming at the same speed.
- * Assuming we have enough pipeline stages, the system load will hopefully
- * decrease before the pipeline is completely empty, and the backup program
- * will be able to "catch up" and refill the pipeline again.
- * 
- * When using the pipelined mode, it would be best to disable any type of
- * buffering done by the user program, as ide-tape already provides all the
- * benefits in the kernel, where it can be done in a more efficient way.
- * As we will usually not block the user program on a request, the most
- * efficient user code will then be a simple read-write-read-... cycle.
- * Any additional logic will usually just slow down the backup process.
- *
- * Using the pipelined mode, I get a constant over 400 KBps throughput,
- * which seems to be the maximum throughput supported by my tape.
- *
- * However, there are some downfalls:
- *
- *	1.	We use memory (for data buffers) in proportional to the number
- *		of pipeline stages (each stage is about 26 KB with my tape).
- *	2.	In the pipelined write mode, we cheat and postpone error codes
- *		to the user task. In read mode, the actual tape position
- *		will be a bit further than the last requested block.
- *
- * Concerning (1):
- *
- *	1.	We allocate stages dynamically only when we need them. When
- *		we don't need them, we don't consume additional memory. In
- *		case we can't allocate stages, we just manage without them
- *		(at the expense of decreased throughput) so when Linux is
- *		tight in memory, we will not pose additional difficulties.
- *
- *	2.	The maximum number of stages (which is, in fact, the maximum
- *		amount of memory) which we allocate is limited by the compile
- *		time parameter IDETAPE_MAX_PIPELINE_STAGES.
- *
- *	3.	The maximum number of stages is a controlled parameter - We
- *		don't start from the user defined maximum number of stages
- *		but from the lower IDETAPE_MIN_PIPELINE_STAGES (again, we
- *		will not even allocate this amount of stages if the user
- *		program can't handle the speed). We then implement a feedback
- *		loop which checks if the pipeline is empty, and if it is, we
- *		increase the maximum number of stages as necessary until we
- *		reach the optimum value which just manages to keep the tape
- *		busy with minimum allocated memory or until we reach
- *		IDETAPE_MAX_PIPELINE_STAGES.
- *
- * Concerning (2):
- *
- *	In pipelined write mode, ide-tape can not return accurate error codes
- *	to the user program since we usually just add the request to the
- *      pipeline without waiting for it to be serviced. In case an error
- *      occurs, I will report it on the next user request.
- *
- *	In the pipelined read mode, subsequent read requests or forward
- *	filemark spacing will perform correctly, as we preserve all blocks
- *	and filemarks which we encountered during our excess read-ahead.
- * 
- *	For accurate tape positioning and error reporting, disabling
- *	pipelined mode might be the best option.
+ * Contributors:
  *
- * You can enable/disable/tune the pipelined operation mode by adjusting
- * the compile time parameters below.
+ * Oct 1999		Arnold Niessen, <niessen@iae.nl>, <arnold.niessen@philips.com>
+ * Nov 2000, Jan 2001	Marcel Mol,	<marcel@mesa.nl>
+ * Apr 2001		Willem Riede,	<osst@riede.org>
  */
 
 /*
- *	Possible improvements.
- *
- *	1.	Support for the ATAPI overlap protocol.
- *
- *		In order to maximize bus throughput, we currently use the DSC
- *		overlap method which enables ide.c to service requests from the
- *		other device while the tape is busy executing a command. The
- *		DSC overlap method involves polling the tape's status register
- *		for the DSC bit, and servicing the other device while the tape
- *		isn't ready.
- *
- *		In the current QIC development standard (December 1995),
- *		it is recommended that new tape drives will *in addition* 
- *		implement the ATAPI overlap protocol, which is used for the
- *		same purpose - efficient use of the IDE bus, but is interrupt
- *		driven and thus has much less CPU overhead.
- *
- *		ATAPI overlap is likely to be supported in most new ATAPI
- *		devices, including new ATAPI cdroms, and thus provides us
- *		a method by which we can achieve higher throughput when
- *		sharing a (fast) ATA-2 disk with any (slow) new ATAPI device.
+ * FIXME: clean tape->spinlock locking  --bzolnier
  */
 
-#define IDETAPE_VERSION "1.17a"
-
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/types.h>
@@ -446,6 +63,7 @@
 
 #define OS_DATA_STARTFRAME1	20
 #define OS_DATA_ENDFRAME1	2980
+
 /*
  * partition
  */
@@ -5893,18 +5511,17 @@ static int idetape_cleanup(struct ata_de
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
 
-	ide_unregister_subdriver (drive);
+	ata_unregister_device(drive);
 	drive->driver_data = NULL;
 	devfs_unregister (tape->de_r);
 	devfs_unregister (tape->de_n);
@@ -5993,11 +5610,11 @@ static void idetape_attach(struct ata_de
 	}
 	tape = (idetape_tape_t *) kmalloc (sizeof (idetape_tape_t), GFP_KERNEL);
 	if (!tape) {
-		printk (KERN_ERR "ide-tape: %s: Can't allocate a tape structure\n", drive->name);
+		printk(KERN_ERR "ide-tape: %s: Can't allocate a tape structure\n", drive->name);
 		return;
 	}
-	if (ide_register_subdriver (drive, &idetape_driver)) {
-		printk (KERN_ERR "ide-tape: %s: Failed to register the driver with ide.c\n", drive->name);
+	if (ata_register_device(drive, &idetape_driver)) {
+		printk(KERN_ERR "ide-tape: %s: Failed to register the driver with ide.c\n", drive->name);
 		kfree (tape);
 		return;
 	}
diff -durNp -X /tmp/diff.X8zbex linux-2.5.29/drivers/ide/it8172.c linux/drivers/ide/it8172.c
--- linux-2.5.29/drivers/ide/it8172.c	2002-07-27 04:58:27.000000000 +0200
+++ linux/drivers/ide/it8172.c	2002-07-29 21:35:50.000000000 +0200
@@ -89,10 +89,7 @@ static void it8172_tune_drive (struct at
 	    drive_enables |= 0x0006;
     }
 
-    save_flags(flags);
-    cli();
 	pci_write_config_word(dev, master_port, master_data);
-    restore_flags(flags);
 }
 
 #if defined(CONFIG_BLK_DEV_IDEDMA) && defined(CONFIG_IT8172_TUNING)
diff -durNp -X /tmp/diff.X8zbex linux-2.5.29/drivers/ide/main.c linux/drivers/ide/main.c
--- linux-2.5.29/drivers/ide/main.c	2002-07-29 21:27:35.000000000 +0200
+++ linux/drivers/ide/main.c	2002-07-29 22:31:31.000000000 +0200
@@ -365,7 +365,7 @@ void ide_unregister(struct ata_channel *
 				if (ata_ops(drive)->cleanup(drive))
 					goto abort;
 			} else
-				ide_unregister_subdriver(drive);
+				ata_unregister_device(drive);
 		}
 	}
 	ch->present = 0;
@@ -1037,10 +1037,7 @@ done:
 
 /****************************************************************************/
 
-/*
- * This is in fact registering a device not a driver.
- */
-int ide_register_subdriver(struct ata_device *drive, struct ata_operations *driver)
+int ata_register_device(struct ata_device *drive, struct ata_operations *driver)
 {
 	unsigned long flags;
 
@@ -1052,12 +1049,9 @@ int ide_register_subdriver(struct ata_de
 		return 1;
 	}
 
-	/* FIXME: This will be pushed to the drivers! Thus allowing us to
-	 * save one parameter here and to separate this out.
-	 */
 	drive->driver = driver;
-
 	spin_unlock_irqrestore(&ide_lock, flags);
+
 	/* Default autotune or requested autotune */
 	if (drive->autotune != 2) {
 		struct ata_channel *ch = drive->channel;
@@ -1071,11 +1065,13 @@ int ide_register_subdriver(struct ata_de
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
@@ -1103,13 +1099,8 @@ int ide_register_subdriver(struct ata_de
  *
  * FIXME: Check whatever we maybe don't call it twice!.
  */
-int ide_unregister_subdriver(struct ata_device *drive)
+int ata_unregister_device(struct ata_device *drive)
 {
-#if 0
-	if (__MOD_IN_USE(ata_ops(drive)->owner))
-		return 1;
-#endif
-
 	if (drive->usage || drive->busy || !ata_ops(drive))
 		return 1;
 
@@ -1181,8 +1172,8 @@ EXPORT_SYMBOL(ide_lock);
 
 devfs_handle_t ide_devfs_handle;
 
-EXPORT_SYMBOL(ide_register_subdriver);
-EXPORT_SYMBOL(ide_unregister_subdriver);
+EXPORT_SYMBOL(ata_register_device);
+EXPORT_SYMBOL(ata_unregister_device);
 EXPORT_SYMBOL(ata_revalidate);
 EXPORT_SYMBOL(ide_register_hw);
 EXPORT_SYMBOL(ide_unregister);
diff -durNp -X /tmp/diff.X8zbex linux-2.5.29/drivers/ide/opti621.c linux/drivers/ide/opti621.c
--- linux-2.5.29/drivers/ide/opti621.c	2002-07-27 04:58:30.000000000 +0200
+++ linux/drivers/ide/opti621.c	2002-07-29 21:35:50.000000000 +0200
@@ -244,13 +244,15 @@ static void compute_clocks(int pio, pio_
 
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
@@ -281,9 +283,6 @@ static void opti621_tune_drive(struct at
 		hwif->name, ax, second.data_time, second.recovery_time, drdy);
 #endif
 
-	save_flags(flags);	/* all CPUs */
-	cli();			/* all CPUs */
-
 	reg_base = hwif->io_ports[IDE_DATA_OFFSET];
 	outb(0xc0, reg_base+CNTRL_REG);	/* allow Register-B */
 	outb(0xff, reg_base+5);		/* hmm, setupvic.exe does this ;-) */
@@ -306,8 +305,6 @@ static void opti621_tune_drive(struct at
 
 	write_reg(misc, MISC_REG);	/* set address setup, DRDY timings,   */
 					/*  and read prefetch for both drives */
-
-	restore_flags(flags);	/* all CPUs */
 }
 
 /*
diff -durNp -X /tmp/diff.X8zbex linux-2.5.29/drivers/ide/qd65xx.c linux/drivers/ide/qd65xx.c
--- linux-2.5.29/drivers/ide/qd65xx.c	2002-07-27 04:58:33.000000000 +0200
+++ linux/drivers/ide/qd65xx.c	2002-07-29 21:42:28.000000000 +0200
@@ -1,8 +1,6 @@
 /*
  *  Copyright (C) 1996-2001  Linus Torvalds & author (see below)
- */
-
-/*
+ *
  *  Version 0.03	Cleaned auto-tune, added probe
  *  Version 0.04	Added second channel tuning
  *  Version 0.05	Enhanced tuning ; added qd6500 support
@@ -81,36 +79,12 @@
  * bit 5 : status, but of what ?
  * bit 6 : always set 1 by dos driver
  * bit 7 : set 1 for non-ATAPI devices on primary port
- * 	(maybe read-ahead and post-write buffer ?)
+ *	(maybe read-ahead and post-write buffer ?)
  */
 
 static int timings[4]={-1,-1,-1,-1}; /* stores current timing for each timer */
 
-static void qd_write_reg(u8 content, unsigned int reg)
-{
-	unsigned long flags;
-
-	save_flags(flags);	/* all CPUs */
-	cli();			/* all CPUs */
-	outb(content,reg);
-	restore_flags(flags);	/* all CPUs */
-}
-
-static u8 __init qd_read_reg(unsigned int reg)
-{
-	unsigned long flags;
-	u8 read;
-
-	save_flags(flags);	/* all CPUs */
-	cli();			/* all CPUs */
-	read = inb(reg);
-	restore_flags(flags);	/* all CPUs */
-	return read;
-}
-
 /*
- * qd_select:
- *
  * This routine is invoked from ide.c to prepare for access to a given drive.
  */
 
@@ -120,12 +94,10 @@ static void qd_select(struct ata_device 
 		(QD_TIMREG(drive) & 0x02);
 
 	if (timings[index] != QD_TIMING(drive))
-		qd_write_reg(timings[index] = QD_TIMING(drive), QD_TIMREG(drive));
+		outb(timings[index] = QD_TIMING(drive), QD_TIMREG(drive));
 }
 
 /*
- * qd6500_compute_timing
- *
  * computes the timing value where
  *	lower nibble represents active time,   in count of VLB clocks
  *	upper nibble represents recovery time, in count of VLB clocks
@@ -147,8 +119,6 @@ static u8 qd6500_compute_timing(struct a
 }
 
 /*
- * qd6580_compute_timing
- *
  * idem for qd6580
  */
 
@@ -161,8 +131,6 @@ static u8 qd6580_compute_timing(int acti
 }
 
 /*
- * qd_find_disk_type
- *
  * tries to find timing from dos driver's table
  */
 
@@ -187,8 +155,6 @@ static int qd_find_disk_type(struct ata_
 }
 
 /*
- * qd_timing_ok:
- *
  * check whether timings don't conflict
  */
 
@@ -201,8 +167,6 @@ static int qd_timing_ok(struct ata_devic
 }
 
 /*
- * qd_set_timing:
- *
  * records the timing, and enables selectproc as needed
  */
 
@@ -221,10 +185,6 @@ static void qd_set_timing(struct ata_dev
 	printk(KERN_DEBUG "%s: %#x\n", drive->name, timing);
 }
 
-/*
- * qd6500_tune_drive
- */
-
 static void qd6500_tune_drive(struct ata_device *drive, u8 pio)
 {
 	int active_time   = 175;
@@ -242,10 +202,6 @@ static void qd6500_tune_drive(struct ata
 	qd_set_timing(drive, qd6500_compute_timing(drive->channel, active_time, recovery_time));
 }
 
-/*
- * qd6580_tune_drive
- */
-
 static void qd6580_tune_drive(struct ata_device *drive, u8 pio)
 {
 	struct ata_timing *t;
@@ -291,7 +247,7 @@ static void qd6580_tune_drive(struct ata
 	}
 
 	if (!drive->channel->unit && drive->type != ATA_DISK) {
-		qd_write_reg(0x5f, QD_CONTROL_PORT);
+		outb(0x5f, QD_CONTROL_PORT);
 		printk(KERN_WARNING "%s: ATAPI: disabled read-ahead FIFO and post-write buffer on %s.\n", drive->name, drive->channel->name);
 	}
 
@@ -299,8 +255,6 @@ static void qd6580_tune_drive(struct ata
 }
 
 /*
- * qd_testreg
- *
  * tests if the given port is a register
  */
 
@@ -329,8 +283,6 @@ static int __init qd_testreg(int port)
 }
 
 /*
- * qd_setup:
- *
  * called to setup an ata channel : adjusts attributes & links for tuning
  */
 
@@ -349,8 +301,6 @@ void __init qd_setup(int unit, int base,
 }
 
 /*
- * qd_unsetup:
- *
  * called to unsetup an ata channel : back to default values, unlinks tuning
  */
 void __init qd_unsetup(int unit) {
@@ -368,13 +318,13 @@ void __init qd_unsetup(int unit) {
 
 	if (tuneproc == (void *) qd6500_tune_drive) {
 		// will do it for both
-		qd_write_reg(QD6500_DEF_DATA, QD_TIMREG(&hwif->drives[0]));
+		outb(QD6500_DEF_DATA, QD_TIMREG(&hwif->drives[0]));
 	} else if (tuneproc == (void *) qd6580_tune_drive) {
 		if (QD_CONTROL(hwif) & QD_CONTR_SEC_DISABLED) {
-			qd_write_reg(QD6580_DEF_DATA, QD_TIMREG(&hwif->drives[0]));
-			qd_write_reg(QD6580_DEF_DATA2, QD_TIMREG(&hwif->drives[1]));
+			outb(QD6580_DEF_DATA, QD_TIMREG(&hwif->drives[0]));
+			outb(QD6580_DEF_DATA2, QD_TIMREG(&hwif->drives[1]));
 		} else {
-			qd_write_reg(unit?QD6580_DEF_DATA2:QD6580_DEF_DATA, QD_TIMREG(&hwif->drives[0]));
+			outb(unit ? QD6580_DEF_DATA2 : QD6580_DEF_DATA, QD_TIMREG(&hwif->drives[0]));
 		}
 	} else {
 		printk(KERN_WARNING "Unknown qd65xx tuning fonction !\n");
@@ -383,8 +333,6 @@ void __init qd_unsetup(int unit) {
 }
 
 /*
- * qd_probe:
- *
  * looks at the specified baseport, and if qd found, registers & initialises it
  * return 1 if another qd may be probed
  */
@@ -394,7 +342,7 @@ int __init qd_probe(int base)
 	u8 config;
 	int unit;
 
-	config = qd_read_reg(QD_CONFIG_PORT);
+	config = inb(QD_CONFIG_PORT);
 
 	if (! ((config & QD_CONFIG_BASEPORT) >> 1 == (base == 0xb0)) ) return 1;
 
@@ -425,7 +373,7 @@ int __init qd_probe(int base)
 
 		/* qd6580 found */
 
-		control = qd_read_reg(QD_CONTROL_PORT);
+		control = inb(QD_CONTROL_PORT);
 
 		printk(KERN_NOTICE "qd6580 at %#x\n", base);
 		printk(KERN_DEBUG "qd6580: config=%#x, control=%#x, ID3=%u\n", config, control, QD_ID3);
@@ -434,7 +382,7 @@ int __init qd_probe(int base)
 			/* secondary disabled */
 			printk(KERN_INFO "%s: qd6580: single IDE board\n", ide_hwifs[unit].name);
 			qd_setup(unit, base, config | (control << 8), QD6580_DEF_DATA, QD6580_DEF_DATA2, &qd6580_tune_drive);
-			qd_write_reg(QD_DEF_CONTR, QD_CONTROL_PORT);
+			outb(QD_DEF_CONTR, QD_CONTROL_PORT);
 
 			return 1;
 		} else {
@@ -443,7 +391,7 @@ int __init qd_probe(int base)
 
 			qd_setup(ATA_PRIMARY, base, config | (control << 8), QD6580_DEF_DATA, QD6580_DEF_DATA, &qd6580_tune_drive);
 			qd_setup(ATA_SECONDARY, base, config | (control << 8), QD6580_DEF_DATA2, QD6580_DEF_DATA2, &qd6580_tune_drive);
-			qd_write_reg(QD_DEF_CONTR, QD_CONTROL_PORT);
+			outb(QD_DEF_CONTR, QD_CONTROL_PORT);
 
 			return 0; /* no other qd65xx possible */
 		}
@@ -454,8 +402,6 @@ int __init qd_probe(int base)
 
 #ifndef MODULE
 /*
- * init_qd65xx:
- *
  * called by ide.c when parsing command line
  */
 
diff -durNp -X /tmp/diff.X8zbex linux-2.5.29/drivers/scsi/ide-scsi.c linux/drivers/scsi/ide-scsi.c
--- linux-2.5.29/drivers/scsi/ide-scsi.c	2002-07-27 04:58:26.000000000 +0200
+++ linux/drivers/scsi/ide-scsi.c	2002-07-29 22:16:47.000000000 +0200
@@ -1,33 +1,12 @@
 /*
  * Copyright (C) 1996 - 1999 Gadi Oxman <gadio@netvision.net.il>
- */
-/*
+ *
  * Emulation of a SCSI host adapter for IDE ATAPI devices.
  *
  * With this driver, one can use the Linux SCSI drivers instead of the
  * native IDE ATAPI drivers.
- *
- * Ver 0.1   Dec  3 96   Initial version.
- * Ver 0.2   Jan 26 97   Fixed bug in cleanup_module() and added emulation
- *                        of MODE_SENSE_6/MODE_SELECT_6 for cdroms. Thanks
- *                        to Janos Farkas for pointing this out.
- *                       Avoid using bitfields in structures for m68k.
- *                       Added Scatter/Gather and DMA support.
- * Ver 0.4   Dec  7 97   Add support for ATAPI PD/CD drives.
- *                       Use variable timeout for each command.
- * Ver 0.5   Jan  2 98   Fix previous PD/CD support.
- *                       Allow disabling of SCSI-6 to SCSI-10 transformation.
- * Ver 0.6   Jan 27 98   Allow disabling of SCSI command translation layer
- *                        for access through /dev/sg.
- *                       Fix MODE_SENSE_6/MODE_SELECT_6/INQUIRY translation.
- * Ver 0.7   Dec 04 98   Ignore commands where lun != 0 to avoid multiple
- *                        detection of devices with CONFIG_SCSI_MULTI_LUN
- * Ver 0.8   Feb 05 99   Optical media need translation too. Reverse 0.7.
- * Ver 0.9   Jul 04 99   Fix a bug in SG_SET_TRANSFORM.
  */
 
-#define IDESCSI_VERSION "0.9"
-
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/string.h>
@@ -495,9 +474,8 @@ static void idescsi_release(struct inode
 static Scsi_Host_Template template;
 static int idescsi_cleanup (struct ata_device *drive)
 {
-	if (ide_unregister_subdriver (drive)) {
+	if (ata_unregister_device(drive))
 		return 1;
-	}
 	scsi_unregister_host(&template);
 
 	return 0;
@@ -762,7 +740,7 @@ static void idescsi_attach(struct ata_de
 
 	host = scsi_register(&template, sizeof(idescsi_scsi_t));
 	if (!host) {
-		printk (KERN_ERR
+		printk(KERN_ERR
 			"ide-scsi: %s: Can't allocate a scsi host structure\n",
 			drive->name);
 		return;
@@ -771,8 +749,8 @@ static void idescsi_attach(struct ata_de
 	host->max_lun = drive->last_lun + 1;
 	host->max_id = 1;
 
-	if (ide_register_subdriver(drive, &ata_ops)) {
-		printk (KERN_ERR "ide-scsi: %s: Failed to register the driver with ide.c\n", drive->name);
+	if (ata_register_device(drive, &ata_ops)) {
+		printk(KERN_ERR "ide-scsi: %s: Failed to register the driver with ide.c\n", drive->name);
 		scsi_unregister(host);
 		return;
 	}
diff -durNp -X /tmp/diff.X8zbex linux-2.5.29/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.29/include/linux/ide.h	2002-07-29 21:27:35.000000000 +0200
+++ linux/include/linux/ide.h	2002-07-29 22:19:21.000000000 +0200
@@ -1146,23 +1146,23 @@ extern struct block_device_operations id
  */
 extern int ideprobe_init(void);
 #ifdef CONFIG_BLK_DEV_IDEDISK
-extern int idedisk_init (void);
+extern int idedisk_init(void);
 #endif
 #ifdef CONFIG_BLK_DEV_IDECD
-extern int ide_cdrom_init (void);
+extern int ide_cdrom_init(void);
 #endif
 #ifdef CONFIG_BLK_DEV_IDETAPE
-extern int idetape_init (void);
+extern int idetape_init(void);
 #endif
 #ifdef CONFIG_BLK_DEV_IDEFLOPPY
-extern int idefloppy_init (void);
+extern int idefloppy_init(void);
 #endif
 #ifdef CONFIG_BLK_DEV_IDESCSI
-extern int idescsi_init (void);
+extern int idescsi_init(void);
 #endif
 
-extern int ide_register_subdriver(struct ata_device *, struct ata_operations *);
-extern int ide_unregister_subdriver(struct ata_device *drive);
+extern int ata_register_device(struct ata_device *, struct ata_operations *);
+extern int ata_unregister_device(struct ata_device *drive);
 extern int ata_revalidate(kdev_t i_rdev);
 extern void ide_driver_module(void);
 
Binary files linux-2.5.29/scripts/docproc and linux/scripts/docproc differ
Binary files linux-2.5.29/scripts/lxdialog/lxdialog and linux/scripts/lxdialog/lxdialog differ


--------------020204070100080001030001--


