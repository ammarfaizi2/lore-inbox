Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315375AbSG3JMv>; Tue, 30 Jul 2002 05:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315413AbSG3JMu>; Tue, 30 Jul 2002 05:12:50 -0400
Received: from [195.63.194.11] ([195.63.194.11]:65294 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315375AbSG3JMe>; Tue, 30 Jul 2002 05:12:34 -0400
Message-ID: <3D459710.3020405@evision.ag>
Date: Mon, 29 Jul 2002 21:27:12 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.29 IDE 108
References: <Pine.LNX.4.33.0207262004550.1357-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------010705040209040208080808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010705040209040208080808
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

- typedef unsigned char byte; is finally gone. Everything using it should
   be just ported to u8 if I missed some place where it still gets used.

- Next round of parameter parsing cleanups by Gerald Champagne.
   Adjusted a bit to harmonize with  hd.c.

- Move IDE register bitfields declarations over from hdparm.h to
   ide.h.

- Fixup cmd640 fix by LT.

- Don't manipulate REQ_QUEUED in blk_insert_special() as discussed on
   lkml. The single only affected file is ll_rw_blk.c of course.

- Declare constants needed by hd.c directly there. Those are standard
   values not subject to change and we prefer a bit of code duplication
   in favour of making the two drivers independant from each other.

- Move everything not ioctl related away from hdreg.h to ide.h.
   This header is in effect not private to the ATA code and should
   therefore not contain stuff only usefull there.

--------------010705040209040208080808
Content-Type: text/plain;
 name="ide-108.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-108.diff"

diff -durNp -X /tmp/diff.8vxI0X linux-2.5.29/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- linux-2.5.29/drivers/block/ll_rw_blk.c	2002-07-27 04:58:28.000000000 +0200
+++ linux/drivers/block/ll_rw_blk.c	2002-07-29 17:28:23.000000000 +0200
@@ -1253,7 +1253,7 @@ struct request *__blk_get_request(reques
  *    host that is unable to accept a particular command.
  */
 void blk_insert_request(request_queue_t *q, struct request *rq,
-		int at_head, void *data)
+			int at_head, void *data)
 {
 	unsigned long flags;
 
@@ -1262,15 +1262,18 @@ void blk_insert_request(request_queue_t 
 	 * must not attempt merges on this) and that it acts as a soft
 	 * barrier
 	 */
-	rq->flags &= REQ_QUEUED;
 	rq->flags |= REQ_SPECIAL | REQ_BARRIER;
 
 	rq->special = data;
 
 	spin_lock_irqsave(q->queue_lock, flags);
-	/* If command is tagged, release the tag */
-	if(blk_rq_tagged(rq))
+
+	/*
+	 * If command is tagged, release the tag
+	 */
+	if (blk_rq_tagged(rq))
 		blk_queue_end_tag(q, rq);
+
 	_elv_add_request(q, rq, !at_head, 0);
 	q->request_fn(q);
 	spin_unlock_irqrestore(q->queue_lock, flags);
diff -durNp -X /tmp/diff.8vxI0X linux-2.5.29/drivers/ide/cmd640.c linux/drivers/ide/cmd640.c
--- linux-2.5.29/drivers/ide/cmd640.c	2002-07-27 04:58:37.000000000 +0200
+++ linux/drivers/ide/cmd640.c	2002-07-27 10:31:49.000000000 +0200
@@ -167,16 +167,18 @@ int cmd640_vlb = 0;
  * Registers and masks for easy access by drive index:
  */
 static u8 prefetch_regs[4]  = {CNTRL, CNTRL, ARTTIM23, ARTTIM23};
-static u8 prefetch_masks[4] = {CNTRL_DIS_RA0, CNTRL_DIS_RA1, ARTTIM23_DIS_RA2, ARTTIM23_DIS_RA3};
-
-#ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
 
 /*
  * Protects register file access from overlapping on primary and secondary
  * channel, since those share hardware resources.
  */
+/* This is broken, but no more so than the old code.. */
 static spinlock_t cmd640_lock __cacheline_aligned = SPIN_LOCK_UNLOCKED;
 
+static u8 prefetch_masks[4] = {CNTRL_DIS_RA0, CNTRL_DIS_RA1, ARTTIM23_DIS_RA2, ARTTIM23_DIS_RA3};
+
+#ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
+
 static u8 arttim_regs[4] = {ARTTIM0, ARTTIM1, ARTTIM23, ARTTIM23};
 static u8 drwtim_regs[4] = {DRWTIM0, DRWTIM1, DRWTIM23, DRWTIM23};
 
@@ -214,9 +216,6 @@ static unsigned int cmd640_chip_version;
  * Therefore, we must use direct IO instead.
  */
 
-/* This is broken, but no more so than the old code.. */
-static spinlock_t cmd640_lock = SPIN_LOCK_UNLOCKED;
-
 /* PCI method 1 access */
 
 static void put_cmd640_reg_pci1 (unsigned short reg, u8 val)
@@ -574,7 +573,7 @@ static void program_drive_counts (unsign
 	/*
 	 * Now that everything is ready, program the new timings
 	 */
-	spin_lock(&cmd640_lock, flags);
+	spin_lock_irqsave(&cmd640_lock, flags);
 	/*
 	 * Program the address_setup clocks into ARTTIM reg,
 	 * and then the active/recovery counts into the DRWTIM reg
diff -durNp -X /tmp/diff.8vxI0X linux-2.5.29/drivers/ide/hd.c linux/drivers/ide/hd.c
--- linux-2.5.29/drivers/ide/hd.c	2002-07-27 04:58:30.000000000 +0200
+++ linux/drivers/ide/hd.c	2002-07-29 17:31:30.000000000 +0200
@@ -1,15 +1,11 @@
 /*
- *  linux/drivers/ide/hd.c
- *
  *  Copyright (C) 1991, 1992  Linus Torvalds
- */
-
-/*
+ *
  * This is the low-level hd interrupt support. It traverses the
  * request-list, using interrupts to jump between functions. As
  * all the functions are called within interrupts, we may not
  * sleep. Special care is recommended.
- * 
+ *
  *  modified by Drew Eckhardt to check nr of hd's from the CMOS.
  *
  *  Thanks to Branko Lankester, lankeste@fwi.uva.nl, who found a bug
@@ -26,10 +22,10 @@
  *  Bugfix: max_sectors must be <= 255 or the wheels tend to come
  *  off in a hurry once you queue things up - Paul G. 02/2001
  */
-  
+
 /* Uncomment the following if you want verbose error reports. */
 /* #define VERBOSE_ERRORS */
-  
+
 #include <linux/errno.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
@@ -37,7 +33,6 @@
 #include <linux/fs.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/kernel.h>
-#include <linux/hdreg.h>
 #include <linux/genhd.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -45,6 +40,7 @@
 #include <linux/mc146818rtc.h> /* CMOS defines */
 #include <linux/init.h>
 #include <linux/blkpg.h>
+#include <linux/hdreg.h>
 
 #define REALLY_SLOW_IO
 #include <asm/system.h>
@@ -55,6 +51,15 @@
 #define DEVICE_NR(device) (minor(device)>>6)
 #include <linux/blk.h>
 
+/* ATA commands we use.
+ */
+#define WIN_SPECIFY	0x91 /* set drive geometry translation */
+#define WIN_RESTORE	0x10
+#define WIN_READ	0x20 /* 28-Bit */
+#define WIN_WRITE	0x30 /* 28-Bit */
+
+#define HD_IRQ 14	/* the standard disk interrupt */
+
 #ifdef __arm__
 #undef  HD_IRQ
 #endif
@@ -63,6 +68,45 @@
 #define HD_IRQ IRQ_HARDDISK
 #endif
 
+/* Hd controller regster ports */
+
+#define HD_DATA		0x1f0		/* _CTL when writing */
+#define HD_ERROR	0x1f1		/* see err-bits */
+#define HD_NSECTOR	0x1f2		/* nr of sectors to read/write */
+#define HD_SECTOR	0x1f3		/* starting sector */
+#define HD_LCYL		0x1f4		/* starting cylinder */
+#define HD_HCYL		0x1f5		/* high byte of starting cyl */
+#define HD_CURRENT	0x1f6		/* 101dhhhh , d=drive, hhhh=head */
+#define HD_STATUS	0x1f7		/* see status-bits */
+#define HD_FEATURE	HD_ERROR	/* same io address, read=error, write=feature */
+#define HD_PRECOMP	HD_FEATURE	/* obsolete use of this port - predates IDE */
+#define HD_COMMAND	HD_STATUS	/* same io address, read=status, write=cmd */
+
+#define HD_CMD		0x3f6		/* used for resets */
+#define HD_ALTSTATUS	0x3f6		/* same as HD_STATUS but doesn't clear irq */
+
+/* Bits of HD_STATUS */
+#define ERR_STAT		0x01
+#define INDEX_STAT		0x02
+#define ECC_STAT		0x04	/* Corrected error */
+#define DRQ_STAT		0x08
+#define SEEK_STAT		0x10
+#define SERVICE_STAT		SEEK_STAT
+#define WRERR_STAT		0x20
+#define READY_STAT		0x40
+#define BUSY_STAT		0x80
+
+/* Bits for HD_ERROR */
+#define MARK_ERR		0x01	/* Bad address mark */
+#define TRK0_ERR		0x02	/* couldn't find track 0 */
+#define ABRT_ERR		0x04	/* Command aborted */
+#define MCR_ERR			0x08	/* media change request */
+#define ID_ERR			0x10	/* ID field not found */
+#define MC_ERR			0x20	/* media changed */
+#define ECC_ERR			0x40	/* Uncorrectable ECC error */
+#define BBD_ERR			0x80	/* pre-EIDE meaning:  block marked bad */
+#define ICRC_ERR		0x80	/* new meaning:  CRC error during transfer */
+
 static spinlock_t hd_lock = SPIN_LOCK_UNLOCKED;
 
 static int revalidate_hddisk(kdev_t, int);
@@ -162,12 +206,9 @@ void __init hd_setup(char *str, int *int
 
 static void dump_status (const char *msg, unsigned int stat)
 {
-	unsigned long flags;
 	char devc;
 
 	devc = !blk_queue_empty(QUEUE) ? 'a' + DEVICE_NR(CURRENT->rq_dev) : '?';
-	save_flags (flags);
-	sti();
 #ifdef VERBOSE_ERRORS
 	printk("hd%c: %s: status=0x%02x { ", devc, msg, stat & 0xff);
 	if (stat & BUSY_STAT)	printk("Busy ");
@@ -207,8 +248,7 @@ static void dump_status (const char *msg
 		hd_error = inb(HD_ERROR);
 		printk("hd%c: %s: error=0x%02x.\n", devc, msg, hd_error & 0xff);
 	}
-#endif	/* verbose errors */
-	restore_flags (flags);
+#endif
 }
 
 void check_status(void)
@@ -467,7 +507,7 @@ ok_to_write:
 	if (i > 0) {
 		SET_HANDLER(&write_intr);
 		outsw(HD_DATA,CURRENT->buffer,256);
-		sti();
+		local_irq_enable();
 	} else {
 #if (HD_DELAY > 0)
 		last_req = read_timer();
@@ -500,7 +540,7 @@ static void hd_times_out(unsigned long d
 		return;
 
 	disable_irq(HD_IRQ);
-	sti();
+	local_irq_enable();
 	reset = 1;
 	dev = DEVICE_NR(CURRENT->rq_dev);
 	printk("hd%c: timeout\n", dev+'a');
@@ -510,7 +550,7 @@ static void hd_times_out(unsigned long d
 #endif
 		end_request(CURRENT, 0);
 	}
-	cli();
+	local_irq_disable();
 	hd_request();
 	enable_irq(HD_IRQ);
 }
@@ -548,7 +588,7 @@ static void hd_request(void)
 		return;
 repeat:
 	del_timer(&device_timer);
-	sti();
+	local_irq_enable();
 
 	if (blk_queue_empty(QUEUE)) {
 		do_hd = NULL;
@@ -556,7 +596,7 @@ repeat:
 	}
 
 	if (reset) {
-		cli();
+		local_irq_disable();
 		reset_hd();
 		return;
 	}
@@ -688,7 +728,7 @@ static void hd_interrupt(int irq, void *
 	if (!handler)
 		handler = unexpected_hd_interrupt;
 	handler();
-	sti();
+	local_irq_enable();
 }
 
 static struct block_device_operations hd_fops = {
diff -durNp -X /tmp/diff.8vxI0X linux-2.5.29/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.29/drivers/ide/ide-cd.c	2002-07-27 04:58:37.000000000 +0200
+++ linux/drivers/ide/ide-cd.c	2002-07-29 15:10:31.000000000 +0200
@@ -305,8 +305,9 @@
 #include <linux/interrupt.h>
 #include <linux/errno.h>
 #include <linux/cdrom.h>
-#include <linux/ide.h>
 #include <linux/completion.h>
+#include <linux/hdreg.h>
+#include <linux/ide.h>
 
 #include <asm/irq.h>
 #include <asm/io.h>
diff -durNp -X /tmp/diff.8vxI0X linux-2.5.29/drivers/ide/ide-floppy.c linux/drivers/ide/ide-floppy.c
--- linux-2.5.29/drivers/ide/ide-floppy.c	2002-07-27 04:58:32.000000000 +0200
+++ linux/drivers/ide/ide-floppy.c	2002-07-29 15:12:30.000000000 +0200
@@ -94,9 +94,10 @@
 #include <linux/genhd.h>
 #include <linux/slab.h>
 #include <linux/cdrom.h>
+#include <linux/buffer_head.h>
+#include <linux/hdreg.h>
 #include <linux/ide.h>
 #include <linux/atapi.h>
-#include <linux/buffer_head.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
diff -durNp -X /tmp/diff.8vxI0X linux-2.5.29/drivers/ide/ide-pci.c linux/drivers/ide/ide-pci.c
--- linux-2.5.29/drivers/ide/ide-pci.c	2002-07-27 04:58:41.000000000 +0200
+++ linux/drivers/ide/ide-pci.c	2002-07-28 23:00:42.000000000 +0200
@@ -550,7 +550,8 @@ static void __init hpt374_device_order_f
 	if (!dev2) {
 		return;
 	} else {
-		byte irq = 0, irq2 = 0;
+		u8 irq = 0;
+		u8 irq2 = 0;
 		pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
 		pci_read_config_byte(dev2, PCI_INTERRUPT_LINE, &irq2);
 		if (irq != irq2) {
diff -durNp -X /tmp/diff.8vxI0X linux-2.5.29/drivers/ide/ide-tape.c linux/drivers/ide/ide-tape.c
--- linux-2.5.29/drivers/ide/ide-tape.c	2002-07-27 04:58:30.000000000 +0200
+++ linux/drivers/ide/ide-tape.c	2002-07-29 15:11:40.000000000 +0200
@@ -419,9 +419,10 @@
 #include <linux/pci.h>
 #include <linux/smp_lock.h>
 #include <linux/completion.h>
+#include <linux/buffer_head.h>
+#include <linux/hdreg.h>
 #include <linux/ide.h>
 #include <linux/atapi.h>
-#include <linux/buffer_head.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -1249,7 +1250,7 @@ char *idetape_sense_key_verbose(u8 ideta
 	}
 }
 
-char *idetape_command_key_verbose (byte idetape_command_key)
+char *idetape_command_key_verbose(u8 idetape_command_key)
 {
 	switch (idetape_command_key) {
 		case IDETAPE_TEST_UNIT_READY_CMD:	return("TEST_UNIT_READY_CMD");
@@ -1439,7 +1440,7 @@ static void idetape_analyze_error(struct
 # if IDETAPE_DEBUG_LOG_VERBOSE
 	if (tape->debug_level >= 1)
 		printk (KERN_INFO "ide-tape: pc = %s, sense key = %x, asc = %x, ascq = %x\n",
-			idetape_command_key_verbose((byte) pc->c[0]),
+			idetape_command_key_verbose(pc->c[0]),
 			result->sense_key,
 			result->asc,
 			result->ascq);
@@ -2166,7 +2167,7 @@ static void idetape_pc_callback(struct a
 /*
  *	A mode sense command is used to "sense" tape parameters.
  */
-static void idetape_create_mode_sense_cmd(struct atapi_packet_command *pc, byte page_code)
+static void idetape_create_mode_sense_cmd(struct atapi_packet_command *pc, u8 page_code)
 {
 	atapi_init_pc(pc);
 	pc->c[0] = IDETAPE_MODE_SENSE_CMD;
@@ -3225,7 +3226,7 @@ static int __idetape_discard_read_pipeli
  *	of the request queue and wait for their completion.
  *
  */
-static int idetape_position_tape(struct ata_device *drive, unsigned int block, byte partition, int skip)
+static int idetape_position_tape(struct ata_device *drive, unsigned int block, u8 partition, int skip)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	int retval;
@@ -3981,7 +3982,7 @@ static int idetape_add_chrdev_read_reque
 		printk (KERN_ERR "ide-tape: bug: trying to return more bytes than requested\n");
 		bytes_read=blocks*tape->tape_block_size;
 	}
-#endif /* IDETAPE_DEBUG_BUGS */
+#endif
 	return (bytes_read);
 }
 
diff -durNp -X /tmp/diff.8vxI0X linux-2.5.29/drivers/ide/ioctl.c linux/drivers/ide/ioctl.c
--- linux-2.5.29/drivers/ide/ioctl.c	2002-07-27 04:58:33.000000000 +0200
+++ linux/drivers/ide/ioctl.c	2002-07-29 16:20:57.000000000 +0200
@@ -33,6 +33,15 @@
 
 #include "ioctl.h"
 
+
+/* BIG GEOMETRY - dying, used only by HDIO_GETGEO_BIG_RAW */
+struct hd_big_geometry {
+	u8 heads;
+	u8 sectors;
+	u32 cylinders;
+	unsigned long start;
+};
+
 /*
  * Implement generic ioctls invoked from userspace to imlpement specific
  * functionality.
diff -durNp -X /tmp/diff.8vxI0X linux-2.5.29/drivers/ide/main.c linux/drivers/ide/main.c
--- linux-2.5.29/drivers/ide/main.c	2002-07-27 04:58:24.000000000 +0200
+++ linux/drivers/ide/main.c	2002-07-29 17:27:48.000000000 +0200
@@ -191,7 +191,11 @@ static void init_hwif_data(struct ata_ch
 
 	ch->noprobe	= !ch->io_ports[IDE_DATA_OFFSET];
 #ifdef CONFIG_BLK_DEV_HD
-	if (ch->io_ports[IDE_DATA_OFFSET] == HD_DATA)
+
+	/* Ignore disks for which handling by the legacy driver was requested
+	 * by the used.
+	 */
+	if (ch->io_ports[IDE_DATA_OFFSET] == 0x1f0)
 		ch->noprobe = 1; /* may be overridden by ide_setup() */
 #endif
 
@@ -701,79 +705,46 @@ static void __init init_global_data(void
 
 /*
  * This gets called VERY EARLY during initialization, to handle kernel "command
- * line" strings beginning with "hdx=" or "ide".It gets called even before the
- * actual module gets initialized.
+ * line" strings beginning with "hdx=".  It gets called even before the actual
+ * module gets initialized.
  *
  * Please look at Documentation/ide.txt to see the complete list of supported
  * options.
  */
-int __init ide_setup(char *s)
+static int __init ata_hd_setup(char *s)
 {
-	int i, vals[4];
-	struct ata_channel *ch;
+	int vals[4];
+	struct ata_channel *ch;	/* FIXME:  Channel parms should not be accessed in ata_hd_setup */
 	struct ata_device *drive;
 	unsigned int hw, unit;
 	const char max_drive = 'a' + ((MAX_HWIFS * MAX_DRIVES) - 1);
-	const char max_ch  = '0' + (MAX_HWIFS - 1);
 
-	if (!strncmp(s, "hd=", 3))	/* hd= is for hd.c driver and not us */
-		return 0;
-
-	if (strncmp(s,"ide",3) &&
-	    strncmp(s,"hd",2))		/* hdx= & hdxlun= */
+	if (s[0] == '=')	/* hd= is for hd.c driver and not us */
 		return 0;
 
-	printk(KERN_INFO  "ide_setup: %s", s);
+	printk(KERN_INFO  "hd%s", s);
 	init_global_data();
 
-#ifdef CONFIG_BLK_DEV_IDEDOUBLER
-	if (!strcmp(s, "ide=doubler")) {
-		extern int ide_doubler;
-
-		printk(KERN_INFO" : Enabled support for IDE doublers\n");
-		ide_doubler = 1;
-
-		return 1;
-	}
-#endif
-
-	if (!strcmp(s, "ide=nodma")) {
-		printk(KERN_INFO "ATA: Prevented DMA\n");
-		noautodma = 1;
-
-		return 1;
-	}
-
-#ifdef CONFIG_PCI
-	if (!strcmp(s, "ide=reverse")) {
-		ide_scan_direction = 1;
-		printk(" : Enabled support for IDE inverse scan order.\n");
-
-		return 1;
-	}
-#endif
-
-	/*
-	 * Look for drive options:  "hdx="
-	 */
-	if (!strncmp(s, "hd", 2) && s[2] >= 'a' && s[2] <= max_drive) {
-		const char *hd_words[] = {"none", "noprobe", "nowerr", "cdrom",
+	if (s[0] >= 'a' && s[0] <= max_drive) {
+		static const char *hd_words[] = {"none", "noprobe", "nowerr", "cdrom",
 				"serialize", "autotune", "noautotune",
 				"slow", "flash", "remap", "noremap", "scsi", NULL};
-		unit = s[2] - 'a';
+		unit = s[0] - 'a';
 		hw   = unit / MAX_DRIVES;
 		unit = unit % MAX_DRIVES;
 		ch = &ide_hwifs[hw];
 		drive = &ch->drives[unit];
-		if (!strncmp(s+3, "=ide-", 5)) {
-			strncpy(drive->driver_req, s + 4, 9);
+
+		/* Look for hdx=ide-* */
+		if (!strncmp(s+1, "=ide-", 5)) {
+			strncpy(drive->driver_req, s+2, 9);
 			goto done;
 		}
 		/*
 		 * Look for last lun option:  "hdxlun="
 		 */
-		if (!strncmp(s+3, "lun=", 4)) {
-	                if (*get_options(s+7, 2, vals) || vals[0]!=1)
+		if (!strncmp(s+1, "lun=", 4)) {
+	                if (*get_options(s+5, 2, vals) || vals[0]!=1)
 				goto bad_option;
 			if (vals[1] >= 0 && vals[1] <= 7) {
 				drive->last_lun = vals[1];
@@ -782,7 +753,7 @@ int __init ide_setup(char *s)
 				printk(" -- BAD LAST LUN! Expected value from 0 to 7");
 			goto done;
 		}
-		switch (match_parm(s+3, hd_words, vals, 3)) {
+		switch (match_parm(s+1, hd_words, vals, 3)) {
 			case -1: /* "none" */
 				drive->nobios = 1;  /* drop into "noprobe" */
 			case -2: /* "noprobe" */
@@ -790,16 +761,16 @@ int __init ide_setup(char *s)
 				goto done;
 			case -3: /* "nowerr" */
 				drive->bad_wstat = BAD_R_STAT;
-				ch->noprobe = 0;
+				ch->noprobe = 0;	/* FIXME:  Channel parm */
 				goto done;
 			case -4: /* "cdrom" */
 				drive->present = 1;
 				drive->type = ATA_ROM;
-				ch->noprobe = 0;
+				ch->noprobe = 0;	/* FIXME:  Channel parm */
 				goto done;
 			case -5: /* "serialize" */
 				printk(" -- USE \"ide%d=serialize\" INSTEAD", hw);
-				goto do_serialize;
+				goto bad_option;
 			case -6: /* "autotune" */
 				drive->autotune = 1;
 				goto done;
@@ -807,7 +778,7 @@ int __init ide_setup(char *s)
 				drive->autotune = 2;
 				goto done;
 			case -8: /* "slow" */
-				ch->slow = 1;
+				ch->slow = 1;		/* FIXME:  Channel parm */
 				goto done;
 			case -9: /* "flash" */
 				drive->ata_flash = 1;
@@ -840,11 +811,63 @@ int __init ide_setup(char *s)
 		}
 	}
 
+bad_option:
+	printk(" -- BAD OPTION\n");
+	return 1;
+
+done:
+	printk("\n");
+
+	return 1;
+}
+
+/*
+ * This gets called VERY EARLY during initialization, to handle kernel "command
+ * line" strings beginning with "ide".  It gets called even before the actual
+ * module gets initialized.
+ *
+ * Please look at Documentation/ide.txt to see the complete list of supported
+ * options.
+ */
+int __init ide_setup(char *s)
+{
+	int i, vals[4];
+	struct ata_channel *ch;
+	unsigned int hw;
+	const char max_ch  = '0' + (MAX_HWIFS - 1);
+
+	printk(KERN_INFO  "ide_setup: ide%s", s);
+	init_global_data();
+
+#ifdef CONFIG_BLK_DEV_IDEDOUBLER
+	if (!strcmp(s, "=doubler")) {
+		extern int ide_doubler;
+
+		printk(KERN_INFO" : Enabled support for IDE doublers\n");
+		ide_doubler = 1;
+		return 1;
+	}
+#endif
+
+	if (!strcmp(s, "=nodma")) {
+		printk(KERN_INFO "ATA: Prevented DMA\n");
+		noautodma = 1;
+		return 1;
+	}
+
+#ifdef CONFIG_PCI
+	if (!strcmp(s, "=reverse")) {
+		ide_scan_direction = 1;
+		printk(" : Enabled support for IDE inverse scan order.\n");
+		return 1;
+	}
+#endif
+
 	/*
 	 * Look for bus speed option:  "idebus="
 	 */
-	if (!strncmp(s, "idebus=", 7)) {
-		if (*get_options(s+7, 2, vals) || vals[0] != 1)
+	if (!strncmp(s, "bus=", 4)) {
+		if (*get_options(s+4, 2, vals) || vals[0] != 1)
 			goto bad_option;
 		idebus_parameter = vals[1];
 		goto done;
@@ -853,7 +876,7 @@ int __init ide_setup(char *s)
 	/*
 	 * Look for interface options:  "idex="
 	 */
-	if (!strncmp(s, "ide", 3) && s[3] >= '0' && s[3] <= max_ch) {
+	if (s[0] >= '0' && s[0] <= max_ch) {
 		/*
 		 * Be VERY CAREFUL changing this: note hardcoded indexes below
 		 */
@@ -861,11 +884,11 @@ int __init ide_setup(char *s)
 			"noprobe", "serialize", "autotune", "noautotune", "reset", "dma", "ata66", NULL };
 		const char *ide_words[] = {
 			"qd65xx", "ht6560b", "cmd640_vlb", "dtc2278", "umc8672", "ali14xx", "dc4030", NULL };
-		hw = s[3] - '0';
+		hw = s[0] - '0';
 		ch = &ide_hwifs[hw];
 
 
-		switch (match_parm(s+4, ide_options, vals, 1)) {
+		switch (match_parm(s+1, ide_options, vals, 1)) {
 			case -7: /* ata66 */
 #ifdef CONFIG_PCI
 				ch->udma_four = 1;
@@ -889,7 +912,6 @@ int __init ide_setup(char *s)
 				ch->drives[1].autotune = 1;
 				goto done;
 			case -2: /* "serialize" */
-			do_serialize:
 				{
 					struct ata_channel *mate;
 
@@ -904,7 +926,10 @@ int __init ide_setup(char *s)
 				goto done;
 		}
 
-		i = match_parm(&s[4], ide_words, vals, 3);
+		/*
+		 * Check for specific chipset name
+		 */
+		i = match_parm(s+1, ide_words, vals, 3);
 
 		/*
 		 * Cryptic check to ensure chipset not already set for a channel:
@@ -913,7 +938,7 @@ int __init ide_setup(char *s)
 			if (ide_hwifs[hw].chipset != ide_unknown)
 				goto bad_option;	/* chipset already specified */
 			if (i != -7 && hw != 0)
-				goto bad_channel;		/* chipset drivers are for "ide0=" only */
+				goto bad_channel;	/* chipset drivers are for "ide0=" only */
 			if (i != -7 && ide_hwifs[1].chipset != ide_unknown)
 				goto bad_option;	/* chipset for 2nd port already specified */
 			printk("\n");
@@ -1432,8 +1457,14 @@ static int __init init_ata(void)
 		while ((options = next) != NULL) {
 			if ((next = strchr(options,' ')) != NULL)
 				*next++ = 0;
-			if (!ide_setup(options))
-				printk(KERN_ERR "Unknown option '%s'\n", options);
+			if (!strncmp(options,"hd",2)) {
+				if (!ata_hd_setup(options+2))
+					printk(KERN_ERR "Unknown option '%s'\n", options);
+			}
+			else if (!strncmp(options,"ide",3)) {
+				if (!ide_setup(options+3))
+					printk(KERN_ERR "Unknown option '%s'\n", options);
+			}
 		}
 	}
 	return ata_module_init();
@@ -1457,6 +1488,7 @@ module_exit(cleanup_ata);
 #ifndef MODULE
 
 /* command line option parser */
-__setup("", ide_setup);
+__setup("ide", ide_setup);
+__setup("hd", ata_hd_setup);
 
 #endif
diff -durNp -X /tmp/diff.8vxI0X linux-2.5.29/drivers/ide/probe.c linux/drivers/ide/probe.c
--- linux-2.5.29/drivers/ide/probe.c	2002-07-27 04:58:23.000000000 +0200
+++ linux/drivers/ide/probe.c	2002-07-29 17:22:49.000000000 +0200
@@ -1082,7 +1082,12 @@ static void channel_init(struct ata_chan
 		}
 	}
 #ifdef CONFIG_BLK_DEV_HD
-	if (ch->irq == HD_IRQ && ch->io_ports[IDE_DATA_OFFSET] != HD_DATA) {
+
+	/* The first "legacy"  HD gets distinguished by the IRQ it is attached
+	 * to and the IO port it takes.
+	 */
+
+	if (ch->irq == 14 && ch->io_ports[IDE_DATA_OFFSET] != 0x1f0) {
 		printk("%s: CANNOT SHARE IRQ WITH OLD HARDDISK DRIVER (hd.c)\n", ch->name);
 
 		return;
diff -durNp -X /tmp/diff.8vxI0X linux-2.5.29/drivers/usb/storage/freecom.c linux/drivers/usb/storage/freecom.c
--- linux-2.5.29/drivers/usb/storage/freecom.c	2002-07-27 04:58:46.000000000 +0200
+++ linux/drivers/usb/storage/freecom.c	2002-07-29 17:37:40.000000000 +0200
@@ -40,43 +40,47 @@
 static void pdump (void *, int);
 #endif
 
+/* Bits of HD_STATUS */
+#define ERR_STAT		0x01
+#define DRQ_STAT		0x08
+
 struct freecom_udata {
-        __u8    buffer[64];             /* Common command block. */
+        u8    buffer[64];             /* Common command block. */
 };
 typedef struct freecom_udata *freecom_udata_t;
 
 /* All of the outgoing packets are 64 bytes long. */
 struct freecom_cb_wrap {
-        __u8    Type;                   /* Command type. */
-        __u8    Timeout;                /* Timeout in seconds. */
-        __u8    Atapi[12];              /* An ATAPI packet. */
-        __u8    Filler[50];             /* Padding Data. */
+        u8    Type;                   /* Command type. */
+        u8    Timeout;                /* Timeout in seconds. */
+        u8    Atapi[12];              /* An ATAPI packet. */
+        u8    Filler[50];             /* Padding Data. */
 };
 
 struct freecom_xfer_wrap {
-        __u8    Type;                   /* Command type. */
-        __u8    Timeout;                /* Timeout in seconds. */
-        __u32   Count;                  /* Number of bytes to transfer. */
-        __u8    Pad[58];
+        u8    Type;                   /* Command type. */
+        u8    Timeout;                /* Timeout in seconds. */
+        u32   Count;                  /* Number of bytes to transfer. */
+        u8    Pad[58];
 } __attribute__ ((packed));
 
 struct freecom_ide_out {
-        __u8    Type;                   /* Type + IDE register. */
-        __u8    Pad;
-        __u16   Value;                  /* Value to write. */
-        __u8    Pad2[60];
+        u8    Type;                   /* Type + IDE register. */
+        u8    Pad;
+        u16   Value;                  /* Value to write. */
+        u8    Pad2[60];
 };
 
 struct freecom_ide_in {
-        __u8    Type;                   /* Type | IDE register. */
-        __u8    Pad[63];
+        u8    Type;                   /* Type | IDE register. */
+        u8    Pad[63];
 };
 
 struct freecom_status {
-        __u8    Status;
-        __u8    Reason;
-        __u16   Count;
-        __u8    Pad[60];
+        u8    Status;
+        u8    Reason;
+        u16   Count;
+        u8    Pad[60];
 };
 
 /* Freecom stuffs the interrupt status in the INDEX_STAT bit of the ide
diff -durNp -X /tmp/diff.8vxI0X linux-2.5.29/include/linux/hdreg.h linux/include/linux/hdreg.h
--- linux-2.5.29/include/linux/hdreg.h	2002-07-27 04:58:37.000000000 +0200
+++ linux/include/linux/hdreg.h	2002-07-29 17:30:30.000000000 +0200
@@ -2,279 +2,18 @@
 #define _LINUX_HDREG_H
 
 /*
- * This file contains some defines for the AT-hd-controller.
- * Various sources.
- */
-
-#define HD_IRQ 14			/* the standard disk interrupt */
-
-/* ide.c has its own port definitions in "ide.h" */
-
-/* Hd controller regs. Ref: IBM AT Bios-listing */
-#define HD_DATA		0x1f0		/* _CTL when writing */
-#define HD_ERROR	0x1f1		/* see err-bits */
-#define HD_NSECTOR	0x1f2		/* nr of sectors to read/write */
-#define HD_SECTOR	0x1f3		/* starting sector */
-#define HD_LCYL		0x1f4		/* starting cylinder */
-#define HD_HCYL		0x1f5		/* high byte of starting cyl */
-#define HD_CURRENT	0x1f6		/* 101dhhhh , d=drive, hhhh=head */
-#define HD_STATUS	0x1f7		/* see status-bits */
-#define HD_FEATURE	HD_ERROR	/* same io address, read=error, write=feature */
-#define HD_PRECOMP	HD_FEATURE	/* obsolete use of this port - predates IDE */
-#define HD_COMMAND	HD_STATUS	/* same io address, read=status, write=cmd */
-
-#define HD_CMD		0x3f6		/* used for resets */
-#define HD_ALTSTATUS	0x3f6		/* same as HD_STATUS but doesn't clear irq */
-
-/* remainder is shared between hd.c, ide.c, ide-cd.c, and the hdparm utility */
-
-/* Bits of HD_STATUS */
-#define ERR_STAT		0x01
-#define INDEX_STAT		0x02
-#define ECC_STAT		0x04	/* Corrected error */
-#define DRQ_STAT		0x08
-#define SEEK_STAT		0x10
-#define SERVICE_STAT		SEEK_STAT
-#define WRERR_STAT		0x20
-#define READY_STAT		0x40
-#define BUSY_STAT		0x80
-
-/* Bits for HD_ERROR */
-#define MARK_ERR		0x01	/* Bad address mark */
-#define TRK0_ERR		0x02	/* couldn't find track 0 */
-#define ABRT_ERR		0x04	/* Command aborted */
-#define MCR_ERR			0x08	/* media change request */
-#define ID_ERR			0x10	/* ID field not found */
-#define MC_ERR			0x20	/* media changed */
-#define ECC_ERR			0x40	/* Uncorrectable ECC error */
-#define BBD_ERR			0x80	/* pre-EIDE meaning:  block marked bad */
-#define ICRC_ERR		0x80	/* new meaning:  CRC error during transfer */
-
-/*
- * sector count bits
- */
-#define NSEC_CD			0x01
-#define NSEC_IO			0x02
-#define NSEC_REL		0x04
-
-/*
  * Command Header sizes for IOCTL commands
  */
-
 #define HDIO_DRIVE_CMD_HDR_SIZE		(4 * sizeof(u8))
 #define HDIO_DRIVE_HOB_HDR_SIZE		(8 * sizeof(u8))
 
-#define IDE_DRIVE_TASK_INVALID		-1
-#define IDE_DRIVE_TASK_NO_DATA		0
-#define IDE_DRIVE_TASK_SET_XFER		1
-
-#define IDE_DRIVE_TASK_IN		2
-
-#define IDE_DRIVE_TASK_OUT		3
-#define IDE_DRIVE_TASK_RAW_WRITE	4
-
-struct hd_drive_task_hdr {
-	u8 feature;
-	u8 sector_count;
-	u8 sector_number;
-	u8 low_cylinder;
-	u8 high_cylinder;
-	u8 device_head;
-} __attribute__((packed));
-
-/*
- * Define standard taskfile in/out register
- */
-#define IDE_TASKFILE_STD_OUT_FLAGS	0xFE
-#define IDE_TASKFILE_STD_IN_FLAGS	0xFE
-#define IDE_HOB_STD_OUT_FLAGS		0xC0
-#define IDE_HOB_STD_IN_FLAGS		0xC0
-
-#define TASKFILE_INVALID		0x7fff
-#define TASKFILE_48			0x8000
-
-#define TASKFILE_NO_DATA		0x0000
-
-#define TASKFILE_IN			0x0001
-#define TASKFILE_MULTI_IN		0x0002
-
-#define TASKFILE_OUT			0x0004
-#define TASKFILE_MULTI_OUT		0x0008
-#define TASKFILE_IN_OUT			0x0010
-
-#define TASKFILE_IN_DMA			0x0020
-#define TASKFILE_OUT_DMA		0x0040
-#define TASKFILE_IN_DMAQ		0x0080
-#define TASKFILE_OUT_DMAQ		0x0100
-
-#define TASKFILE_P_IN			0x0200
-#define TASKFILE_P_OUT			0x0400
-#define TASKFILE_P_IN_DMA		0x0800
-#define TASKFILE_P_OUT_DMA		0x1000
-#define TASKFILE_P_IN_DMAQ		0x2000
-#define TASKFILE_P_OUT_DMAQ		0x4000
-
-/* ATA/ATAPI Commands pre T13 Spec */
-#define WIN_NOP				0x00
-#define CFA_REQ_EXT_ERROR_CODE		0x03 /* CFA Request Extended Error Code */
-#define WIN_SRST			0x08 /* ATAPI soft reset command */
-#define WIN_DEVICE_RESET		0x08
-#define WIN_RESTORE			0x10
-#define WIN_READ			0x20 /* 28-Bit */
-#define WIN_READ_EXT			0x24 /* 48-Bit */
-#define WIN_READDMA_EXT			0x25 /* 48-Bit */
-#define WIN_READDMA_QUEUED_EXT		0x26 /* 48-Bit */
-#define WIN_READ_NATIVE_MAX_EXT		0x27 /* 48-Bit */
-#define WIN_MULTREAD_EXT		0x29 /* 48-Bit */
-#define WIN_WRITE			0x30 /* 28-Bit */
-#define WIN_WRITE_EXT			0x34 /* 48-Bit */
-#define WIN_WRITEDMA_EXT		0x35 /* 48-Bit */
-#define WIN_WRITEDMA_QUEUED_EXT		0x36 /* 48-Bit */
-#define WIN_SET_MAX_EXT			0x37 /* 48-Bit */
-#define CFA_WRITE_SECT_WO_ERASE		0x38 /* CFA Write Sectors without erase */
-#define WIN_MULTWRITE_EXT		0x39 /* 48-Bit */
-#define WIN_WRITE_VERIFY		0x3C /* 28-Bit */
-#define WIN_VERIFY			0x40 /* 28-Bit - Read Verify Sectors */
-#define WIN_VERIFY_EXT			0x42 /* 48-Bit */
-#define WIN_FORMAT			0x50
-#define WIN_INIT			0x60
-#define WIN_SEEK			0x70
-#define CFA_TRANSLATE_SECTOR		0x87 /* CFA Translate Sector */
-#define WIN_DIAGNOSE			0x90
-#define WIN_SPECIFY			0x91 /* set drive geometry translation */
-#define WIN_DOWNLOAD_MICROCODE		0x92
-#define WIN_STANDBYNOW2			0x94
-#define WIN_SETIDLE2			0x97
-#define WIN_CHECKPOWERMODE2		0x98
-#define WIN_SLEEPNOW2			0x99
-#define WIN_PACKETCMD			0xA0 /* Send a packet command. */
-#define WIN_PIDENTIFY			0xA1 /* identify ATAPI device	*/
-#define WIN_QUEUED_SERVICE		0xA2
-#define WIN_SMART			0xB0 /* self-monitoring and reporting */
-#define CFA_ERASE_SECTORS		0xC0
-#define WIN_MULTREAD			0xC4 /* read sectors using multiple mode*/
-#define WIN_MULTWRITE			0xC5 /* write sectors using multiple mode */
-#define WIN_SETMULT			0xC6 /* enable/disable multiple mode */
-#define WIN_READDMA_QUEUED		0xC7 /* read sectors using Queued DMA transfers */
-#define WIN_READDMA			0xC8 /* read sectors using DMA transfers */
-#define WIN_WRITEDMA			0xCA /* write sectors using DMA transfers */
-#define WIN_WRITEDMA_QUEUED		0xCC /* write sectors using Queued DMA transfers */
-#define CFA_WRITE_MULTI_WO_ERASE	0xCD /* CFA Write multiple without erase */
-#define WIN_GETMEDIASTATUS		0xDA
-#define WIN_DOORLOCK			0xDE /* lock door on removable drives */
-#define WIN_DOORUNLOCK			0xDF /* unlock door on removable drives */
-#define WIN_STANDBYNOW1			0xE0
-#define WIN_IDLEIMMEDIATE		0xE1 /* force drive to become "ready" */
-#define WIN_STANDBY			0xE2 /* Set device in Standby Mode */
-#define WIN_SETIDLE1			0xE3
-#define WIN_READ_BUFFER			0xE4 /* force read only 1 sector */
-#define WIN_CHECKPOWERMODE1		0xE5
-#define WIN_SLEEPNOW1			0xE6
-#define WIN_FLUSH_CACHE			0xE7
-#define WIN_WRITE_BUFFER		0xE8 /* force write only 1 sector */
-#define WIN_FLUSH_CACHE_EXT		0xEA /* 48-Bit */
-#define WIN_IDENTIFY			0xEC /* ask drive to identify itself	*/
-#define WIN_MEDIAEJECT			0xED
-#define WIN_IDENTIFY_DMA		0xEE /* same as WIN_IDENTIFY, but DMA */
-#define WIN_SETFEATURES			0xEF /* set special drive features */
-#define EXABYTE_ENABLE_NEST		0xF0
-#define WIN_SECURITY_SET_PASS		0xF1
-#define WIN_SECURITY_UNLOCK		0xF2
-#define WIN_SECURITY_ERASE_PREPARE	0xF3
-#define WIN_SECURITY_ERASE_UNIT		0xF4
-#define WIN_SECURITY_FREEZE_LOCK	0xF5
-#define WIN_SECURITY_DISABLE		0xF6
-#define WIN_READ_NATIVE_MAX		0xF8 /* return the native maximum address */
-#define WIN_SET_MAX			0xF9
-#define DISABLE_SEAGATE			0xFB
-
-/* WIN_SMART sub-commands */
-
-#define SMART_READ_VALUES		0xD0
-#define SMART_READ_THRESHOLDS		0xD1
-#define SMART_AUTOSAVE			0xD2
-#define SMART_SAVE			0xD3
-#define SMART_IMMEDIATE_OFFLINE		0xD4
-#define SMART_READ_LOG_SECTOR		0xD5
-#define SMART_WRITE_LOG_SECTOR		0xD6
-#define SMART_WRITE_THRESHOLDS		0xD7
-#define SMART_ENABLE			0xD8
-#define SMART_DISABLE			0xD9
-#define SMART_STATUS			0xDA
-#define SMART_AUTO_OFFLINE		0xDB
-
-/* Password used in TF4 & TF5 executing SMART commands */
-
-#define SMART_LCYL_PASS			0x4F
-#define SMART_HCYL_PASS			0xC2
-
-/* WIN_SETFEATURES sub-commands */
-
-#define SETFEATURES_EN_WCACHE	0x02	/* Enable write cache */
-#define SETFEATURES_XFER	0x03	/* Set transfer mode */
-#	define XFER_UDMA_7	0x47	/* 0100|0111 */
-#	define XFER_UDMA_6	0x46	/* 0100|0110 */
-#	define XFER_UDMA_5	0x45	/* 0100|0101 */
-#	define XFER_UDMA_4	0x44	/* 0100|0100 */
-#	define XFER_UDMA_3	0x43	/* 0100|0011 */
-#	define XFER_UDMA_2	0x42	/* 0100|0010 */
-#	define XFER_UDMA_1	0x41	/* 0100|0001 */
-#	define XFER_UDMA_0	0x40	/* 0100|0000 */
-#	define XFER_MW_DMA_2	0x22	/* 0010|0010 */
-#	define XFER_MW_DMA_1	0x21	/* 0010|0001 */
-#	define XFER_MW_DMA_0	0x20	/* 0010|0000 */
-#	define XFER_SW_DMA_2	0x12	/* 0001|0010 */
-#	define XFER_SW_DMA_1	0x11	/* 0001|0001 */
-#	define XFER_SW_DMA_0	0x10	/* 0001|0000 */
-#	define XFER_PIO_4	0x0C	/* 0000|1100 */
-#	define XFER_PIO_3	0x0B	/* 0000|1011 */
-#	define XFER_PIO_2	0x0A	/* 0000|1010 */
-#	define XFER_PIO_1	0x09	/* 0000|1001 */
-#	define XFER_PIO_0	0x08	/* 0000|1000 */
-#	define XFER_PIO_SLOW	0x00	/* 0000|0000 */
-#define SETFEATURES_DIS_DEFECT	0x04	/* Disable Defect Management */
-#define SETFEATURES_EN_APM	0x05	/* Enable advanced power management */
-#define SETFEATURES_DIS_MSN	0x31	/* Disable Media Status Notification */
-#define SETFEATURES_EN_AAM	0x42	/* Enable Automatic Acoustic Management */
-#define SETFEATURES_DIS_RLA	0x55	/* Disable read look-ahead feature */
-#define SETFEATURES_EN_RI	0x5D	/* Enable release interrupt */
-#define SETFEATURES_EN_SI	0x5E	/* Enable SERVICE interrupt */
-#define SETFEATURES_DIS_RPOD	0x66	/* Disable reverting to power on defaults */
-#define SETFEATURES_DIS_WCACHE	0x82	/* Disable write cache */
-#define SETFEATURES_EN_DEFECT	0x84	/* Enable Defect Management */
-#define SETFEATURES_DIS_APM	0x85	/* Disable advanced power management */
-#define SETFEATURES_EN_MSN	0x95	/* Enable Media Status Notification */
-#define SETFEATURES_EN_RLA	0xAA	/* Enable read look-ahead feature */
-#define SETFEATURES_PREFETCH	0xAB	/* Sets drive prefetch value */
-#define SETFEATURES_DIS_AAM	0xC2	/* Disable Automatic Acoustic Management */
-#define SETFEATURES_EN_RPOD	0xCC	/* Enable reverting to power on defaults */
-#define SETFEATURES_DIS_RI	0xDD	/* Disable release interrupt */
-#define SETFEATURES_DIS_SI	0xDE	/* Disable SERVICE interrupt */
-
-/* WIN_SECURITY sub-commands */
-
-#define SECURITY_SET_PASSWORD		0xBA
-#define SECURITY_UNLOCK			0xBB
-#define SECURITY_ERASE_PREPARE		0xBC
-#define SECURITY_ERASE_UNIT		0xBD
-#define SECURITY_FREEZE_LOCK		0xBE
-#define SECURITY_DISABLE_PASSWORD	0xBF
-
 struct hd_geometry {
-      u8 heads;
-      u8 sectors;
-      u16 cylinders;
+      __u8 heads;
+      __u8 sectors;
+      __u16 cylinders;
       unsigned long start;
 };
 
-/* BIG GEOMETRY - dying, used only by HDIO_GETGEO_BIG_RAW */
-struct hd_big_geometry {
-	u8 heads;
-	u8 sectors;
-	u32 cylinders;
-	unsigned long start;
-};
-
 /* hd/ide ctl's that pass (arg) ptrs to user space are numbered 0x030n/0x031n */
 #define HDIO_GETGEO		0x0301	/* get device geometry */
 #define HDIO_GET_UNMASKINTR	0x0302	/* get current unmask setting */
@@ -306,263 +45,8 @@ struct hd_big_geometry {
 #define HDIO_SET_QDMA		0x032e	/* change use-qdma flag */
 #define HDIO_SET_ADDRESS	0x032f	/* change lba addressing modes */
 
-/* bus states */
-enum {
-	BUSSTATE_OFF = 0,
-	BUSSTATE_ON,
-	BUSSTATE_TRISTATE
-};
-
 /* hd/ide ctl's that pass (arg) ptrs to user space are numbered 0x033n/0x033n */
 /* 0x330 is reserved - used to be HDIO_GETGEO_BIG */
 #define HDIO_GETGEO_BIG_RAW	0x0331	/* */
 
-#define __NEW_HD_DRIVE_ID
-
-/*
- * Structure returned by HDIO_GET_IDENTITY, as per ANSI NCITS ATA6 rev.1b spec.
- *
- * If you change something here, please remember to update fix_driveid() in
- * ide/probe.c.
- */
-struct hd_driveid {
-	u16	config;		/* lots of obsolete bit flags */
-	u16	cyls;		/* Obsolete, "physical" cyls */
-	u16	reserved2;	/* reserved (word 2) */
-	u16	heads;		/* Obsolete, "physical" heads */
-	u16	track_bytes;	/* unformatted bytes per track */
-	u16	sector_bytes;	/* unformatted bytes per sector */
-	u16	sectors;	/* Obsolete, "physical" sectors per track */
-	u16	vendor0;	/* vendor unique */
-	u16	vendor1;	/* vendor unique */
-	u16	vendor2;	/* Retired vendor unique */
-	u8	serial_no[20];	/* 0 = not_specified */
-	u16	buf_type;	/* Retired */
-	u16	buf_size;	/* Retired, 512 byte increments
-				 * 0 = not_specified
-				 */
-	u16	ecc_bytes;	/* for r/w long cmds; 0 = not_specified */
-	u8	fw_rev[8];	/* 0 = not_specified */
-	char	model[40];	/* 0 = not_specified */
-	u8	max_multsect;	/* 0=not_implemented */
-	u8	vendor3;	/* vendor unique */
-	u16	dword_io;	/* 0=not_implemented; 1=implemented */
-	u8	vendor4;	/* vendor unique */
-	u8	capability;	/* (upper byte of word 49)
-				 *  3:	IORDYsup
-				 *  2:	IORDYsw
-				 *  1:	LBA
-				 *  0:	DMA
-				 */
-	u16	reserved50;	/* reserved (word 50) */
-	u8	vendor5;	/* Obsolete, vendor unique */
-	u8	tPIO;		/* Obsolete, 0=slow, 1=medium, 2=fast */
-	u8	vendor6;	/* Obsolete, vendor unique */
-	u8	tDMA;		/* Obsolete, 0=slow, 1=medium, 2=fast */
-	u16	field_valid;	/* (word 53)
-				 *  2:	ultra_ok	word  88
-				 *  1:	eide_ok		words 64-70
-				 *  0:	cur_ok		words 54-58
-				 */
-	u16	cur_cyls;	/* Obsolete, logical cylinders */
-	u16	cur_heads;	/* Obsolete, l heads */
-	u16	cur_sectors;	/* Obsolete, l sectors per track */
-	u16	cur_capacity0;	/* Obsolete, l total sectors on drive */
-	u16	cur_capacity1;	/* Obsolete, (2 words, misaligned int)     */
-	u8	multsect;	/* current multiple sector count */
-	u8	multsect_valid;	/* when (bit0==1) multsect is ok */
-	u32	lba_capacity;	/* Obsolete, total number of sectors */
-	u16	dma_1word;	/* Obsolete, single-word dma info */
-	u16	dma_mword;	/* multiple-word dma info */
-	u16	eide_pio_modes; /* bits 0:mode3 1:mode4 */
-	u16	eide_dma_min;	/* min mword dma cycle time (ns) */
-	u16	eide_dma_time;	/* recommended mword dma cycle time (ns) */
-	u16	eide_pio;       /* min cycle time (ns), no IORDY  */
-	u16	eide_pio_iordy; /* min cycle time (ns), with IORDY */
-	u16	words69_70[2];	/* reserved words 69-70
-				 * future command overlap and queuing
-				 */
-	/* HDIO_GET_IDENTITY currently returns only words 0 through 70 */
-	u16	words71_74[4];	/* reserved words 71-74
-				 * for IDENTIFY PACKET DEVICE command
-				 */
-	u16	queue_depth;	/* (word 75)
-				 * 15:5	reserved
-				 *  4:0	Maximum queue depth -1
-				 */
-	u16	words76_79[4];	/* reserved words 76-79 */
-	u16	major_rev_num;	/* (word 80) */
-	u16	minor_rev_num;	/* (word 81) */
-	u16	command_set_1;	/* (word 82) supported
-				 * 15:	Obsolete
-				 * 14:	NOP command
-				 * 13:	READ_BUFFER
-				 * 12:	WRITE_BUFFER
-				 * 11:	Obsolete
-				 * 10:	Host Protected Area
-				 *  9:	DEVICE Reset
-				 *  8:	SERVICE Interrupt
-				 *  7:	Release Interrupt
-				 *  6:	look-ahead
-				 *  5:	write cache
-				 *  4:	PACKET Command
-				 *  3:	Power Management Feature Set
-				 *  2:	Removable Feature Set
-				 *  1:	Security Feature Set
-				 *  0:	SMART Feature Set
-				 */
-	u16	command_set_2;	/* (word 83)
-				 * 15:	Shall be ZERO
-				 * 14:	Shall be ONE
-				 * 13:	FLUSH CACHE EXT
-				 * 12:	FLUSH CACHE
-				 * 11:	Device Configuration Overlay
-				 * 10:	48-bit Address Feature Set
-				 *  9:	Automatic Acoustic Management
-				 *  8:	SET MAX security
-				 *  7:	reserved 1407DT PARTIES
-				 *  6:	SetF sub-command Power-Up
-				 *  5:	Power-Up in Standby Feature Set
-				 *  4:	Removable Media Notification
-				 *  3:	APM Feature Set
-				 *  2:	CFA Feature Set
-				 *  1:	READ/WRITE DMA QUEUED
-				 *  0:	Download MicroCode
-				 */
-	u16	cfsse;		/* (word 84)
-				 * cmd set-feature supported extensions
-				 * 15:	Shall be ZERO
-				 * 14:	Shall be ONE
-				 * 13:3	reserved
-				 *  2:	Media Serial Number Valid
-				 *  1:	SMART selt-test supported
-				 *  0:	SMART error logging
-				 */
-	u16	cfs_enable_1;	/* (word 85)
-				 * command set-feature enabled
-				 * 15:	Obsolete
-				 * 14:	NOP command
-				 * 13:	READ_BUFFER
-				 * 12:	WRITE_BUFFER
-				 * 11:	Obsolete
-				 * 10:	Host Protected Area
-				 *  9:	DEVICE Reset
-				 *  8:	SERVICE Interrupt
-				 *  7:	Release Interrupt
-				 *  6:	look-ahead
-				 *  5:	write cache
-				 *  4:	PACKET Command
-				 *  3:	Power Management Feature Set
-				 *  2:	Removable Feature Set
-				 *  1:	Security Feature Set
-				 *  0:	SMART Feature Set
-				 */
-	u16	cfs_enable_2;	/* (word 86)
-				 * command set-feature enabled
-				 * 15:	Shall be ZERO
-				 * 14:	Shall be ONE
-				 * 13:	FLUSH CACHE EXT
-				 * 12:	FLUSH CACHE
-				 * 11:	Device Configuration Overlay
-				 * 10:	48-bit Address Feature Set
-				 *  9:	Automatic Acoustic Management
-				 *  8:	SET MAX security
-				 *  7:	reserved 1407DT PARTIES
-				 *  6:	SetF sub-command Power-Up
-				 *  5:	Power-Up in Standby Feature Set
-				 *  4:	Removable Media Notification
-				 *  3:	APM Feature Set
-				 *  2:	CFA Feature Set
-				 *  1:	READ/WRITE DMA QUEUED
-				 *  0:	Download MicroCode
-				 */
-	u16	csf_default;	/* (word 87)
-				 * command set-feature default
-				 * 15:	Shall be ZERO
-				 * 14:	Shall be ONE
-				 * 13:3	reserved
-				 *  2:	Media Serial Number Valid
-				 *  1:	SMART selt-test supported
-				 *  0:	SMART error logging
-				 */
-	u16	dma_ultra;	/* (word 88) */
-	u16	word89;		/* reserved (word 89) */
-	u16	word90;		/* reserved (word 90) */
-	u16	CurAPMvalues;	/* current APM values */
-	u16	word92;		/* reserved (word 92) */
-	u16	hw_config;	/* hardware config (word 93)
-				 * 15:
-				 * 14:
-				 * 13:
-				 * 12:
-				 * 11:
-				 * 10:
-				 *  9:
-				 *  8:
-				 *  7:
-				 *  6:
-				 *  5:
-				 *  4:
-				 *  3:
-				 *  2:
-				 *  1:
-				 *  0:
-				 */
-	u16	acoustic;	/* (word 94)
-				 * 15:8	Vendor's recommended value
-				 *  7:0	current value
-				 */
-	u16	words95_99[5];	/* reserved words 95-99 */
-	u64	lba_capacity_2;	/* 48-bit total number of sectors */
-	u16	words104_125[22];/* reserved words 104-125 */
-	u16	last_lun;	/* (word 126) */
-	u16	word127;	/* (word 127) Feature Set
-				 * Removable Media Notification
-				 * 15:2	reserved
-				 *  1:0	00 = not supported
-				 *	01 = supported
-				 *	10 = reserved
-				 *	11 = reserved
-				 */
-	u16	dlf;		/* (word 128)
-				 * device lock function
-				 * 15:9	reserved
-				 *  8	security level 1:max 0:high
-				 *  7:6	reserved
-				 *  5	enhanced erase
-				 *  4	expire
-				 *  3	frozen
-				 *  2	locked
-				 *  1	en/disabled
-				 *  0	capability
-				 */
-	u16	csfo;		/* (word 129)
-				 * current set features options
-				 * 15:4	reserved
-				 *  3:	auto reassign
-				 *  2:	reverting
-				 *  1:	read-look-ahead
-				 *  0:	write cache
-				 */
-	u16	words130_155[26];/* reserved vendor words 130-155 */
-	u16	word156;	/* reserved vendor word 156 */
-	u16	words157_159[3];/* reserved vendor words 157-159 */
-	u16	cfa_power;	/* (word 160) CFA Power Mode
-				 * 15 word 160 supported
-				 * 14 reserved
-				 * 13
-				 * 12
-				 * 11:0
-				 */
-	u16	words161_175[14];/* Reserved for CFA */
-	u16	words176_205[31];/* Current Media Serial Number */
-	u16	words206_254[48];/* reserved words 206-254 */
-	u16	integrity_word;	/* (word 255)
-				 * 15:8 Checksum
-				 *  7:0 Signature
-				 */
-} __attribute__((packed));
-
-#define IDE_NICE_DSC_OVERLAP	(0)	/* per the DSC overlap protocol */
-
 #endif
diff -durNp -X /tmp/diff.8vxI0X linux-2.5.29/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.29/include/linux/ide.h	2002-07-27 04:58:31.000000000 +0200
+++ linux/include/linux/ide.h	2002-07-29 17:31:33.000000000 +0200
@@ -8,7 +8,6 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
-#include <linux/hdreg.h>
 #include <linux/hdsmart.h>
 #include <linux/blkdev.h>
 #include <linux/proc_fs.h>
@@ -51,7 +50,460 @@
  *  "No user-serviceable parts" beyond this point
  *****************************************************************************/
 
-typedef unsigned char	byte;	/* used everywhere */
+
+/* ATA/ATAPI Commands pre T13 Spec */
+#define WIN_NOP				0x00
+#define CFA_REQ_EXT_ERROR_CODE		0x03 /* CFA Request Extended Error Code */
+#define WIN_SRST			0x08 /* ATAPI soft reset command */
+#define WIN_DEVICE_RESET		0x08
+#define WIN_RESTORE			0x10
+#define WIN_READ			0x20 /* 28-Bit */
+#define WIN_READ_EXT			0x24 /* 48-Bit */
+#define WIN_READDMA_EXT			0x25 /* 48-Bit */
+#define WIN_READDMA_QUEUED_EXT		0x26 /* 48-Bit */
+#define WIN_READ_NATIVE_MAX_EXT		0x27 /* 48-Bit */
+#define WIN_MULTREAD_EXT		0x29 /* 48-Bit */
+#define WIN_WRITE			0x30 /* 28-Bit */
+#define WIN_WRITE_EXT			0x34 /* 48-Bit */
+#define WIN_WRITEDMA_EXT		0x35 /* 48-Bit */
+#define WIN_WRITEDMA_QUEUED_EXT		0x36 /* 48-Bit */
+#define WIN_SET_MAX_EXT			0x37 /* 48-Bit */
+#define CFA_WRITE_SECT_WO_ERASE		0x38 /* CFA Write Sectors without erase */
+#define WIN_MULTWRITE_EXT		0x39 /* 48-Bit */
+#define WIN_WRITE_VERIFY		0x3C /* 28-Bit */
+#define WIN_VERIFY			0x40 /* 28-Bit - Read Verify Sectors */
+#define WIN_VERIFY_EXT			0x42 /* 48-Bit */
+#define WIN_FORMAT			0x50
+#define WIN_INIT			0x60
+#define WIN_SEEK			0x70
+#define CFA_TRANSLATE_SECTOR		0x87 /* CFA Translate Sector */
+#define WIN_DIAGNOSE			0x90
+#define WIN_SPECIFY			0x91 /* set drive geometry translation */
+#define WIN_DOWNLOAD_MICROCODE		0x92
+#define WIN_STANDBYNOW2			0x94
+#define WIN_SETIDLE2			0x97
+#define WIN_CHECKPOWERMODE2		0x98
+#define WIN_SLEEPNOW2			0x99
+#define WIN_PACKETCMD			0xA0 /* Send a packet command. */
+#define WIN_PIDENTIFY			0xA1 /* identify ATAPI device	*/
+#define WIN_QUEUED_SERVICE		0xA2
+#define WIN_SMART			0xB0 /* self-monitoring and reporting */
+#define CFA_ERASE_SECTORS		0xC0
+#define WIN_MULTREAD			0xC4 /* read sectors using multiple mode*/
+#define WIN_MULTWRITE			0xC5 /* write sectors using multiple mode */
+#define WIN_SETMULT			0xC6 /* enable/disable multiple mode */
+#define WIN_READDMA_QUEUED		0xC7 /* read sectors using Queued DMA transfers */
+#define WIN_READDMA			0xC8 /* read sectors using DMA transfers */
+#define WIN_WRITEDMA			0xCA /* write sectors using DMA transfers */
+#define WIN_WRITEDMA_QUEUED		0xCC /* write sectors using Queued DMA transfers */
+#define CFA_WRITE_MULTI_WO_ERASE	0xCD /* CFA Write multiple without erase */
+#define WIN_GETMEDIASTATUS		0xDA
+#define WIN_DOORLOCK			0xDE /* lock door on removable drives */
+#define WIN_DOORUNLOCK			0xDF /* unlock door on removable drives */
+#define WIN_STANDBYNOW1			0xE0
+#define WIN_IDLEIMMEDIATE		0xE1 /* force drive to become "ready" */
+#define WIN_STANDBY			0xE2 /* Set device in Standby Mode */
+#define WIN_SETIDLE1			0xE3
+#define WIN_READ_BUFFER			0xE4 /* force read only 1 sector */
+#define WIN_CHECKPOWERMODE1		0xE5
+#define WIN_SLEEPNOW1			0xE6
+#define WIN_FLUSH_CACHE			0xE7
+#define WIN_WRITE_BUFFER		0xE8 /* force write only 1 sector */
+#define WIN_FLUSH_CACHE_EXT		0xEA /* 48-Bit */
+#define WIN_IDENTIFY			0xEC /* ask drive to identify itself	*/
+#define WIN_MEDIAEJECT			0xED
+#define WIN_IDENTIFY_DMA		0xEE /* same as WIN_IDENTIFY, but DMA */
+#define WIN_SETFEATURES			0xEF /* set special drive features */
+#define EXABYTE_ENABLE_NEST		0xF0
+#define WIN_SECURITY_SET_PASS		0xF1
+#define WIN_SECURITY_UNLOCK		0xF2
+#define WIN_SECURITY_ERASE_PREPARE	0xF3
+#define WIN_SECURITY_ERASE_UNIT		0xF4
+#define WIN_SECURITY_FREEZE_LOCK	0xF5
+#define WIN_SECURITY_DISABLE		0xF6
+#define WIN_READ_NATIVE_MAX		0xF8 /* return the native maximum address */
+#define WIN_SET_MAX			0xF9
+#define DISABLE_SEAGATE			0xFB
+
+/* WIN_SMART sub-commands */
+
+#define SMART_READ_VALUES		0xD0
+#define SMART_READ_THRESHOLDS		0xD1
+#define SMART_AUTOSAVE			0xD2
+#define SMART_SAVE			0xD3
+#define SMART_IMMEDIATE_OFFLINE		0xD4
+#define SMART_READ_LOG_SECTOR		0xD5
+#define SMART_WRITE_LOG_SECTOR		0xD6
+#define SMART_WRITE_THRESHOLDS		0xD7
+#define SMART_ENABLE			0xD8
+#define SMART_DISABLE			0xD9
+#define SMART_STATUS			0xDA
+#define SMART_AUTO_OFFLINE		0xDB
+
+/* Password used in TF4 & TF5 executing SMART commands */
+
+#define SMART_LCYL_PASS			0x4F
+#define SMART_HCYL_PASS			0xC2
+
+/* WIN_SETFEATURES sub-commands */
+
+#define SETFEATURES_EN_WCACHE	0x02	/* Enable write cache */
+
+#define SETFEATURES_XFER	0x03	/* Set transfer mode */
+#	define XFER_UDMA_7	0x47	/* 0100|0111 */
+#	define XFER_UDMA_6	0x46	/* 0100|0110 */
+#	define XFER_UDMA_5	0x45	/* 0100|0101 */
+#	define XFER_UDMA_4	0x44	/* 0100|0100 */
+#	define XFER_UDMA_3	0x43	/* 0100|0011 */
+#	define XFER_UDMA_2	0x42	/* 0100|0010 */
+#	define XFER_UDMA_1	0x41	/* 0100|0001 */
+#	define XFER_UDMA_0	0x40	/* 0100|0000 */
+#	define XFER_MW_DMA_2	0x22	/* 0010|0010 */
+#	define XFER_MW_DMA_1	0x21	/* 0010|0001 */
+#	define XFER_MW_DMA_0	0x20	/* 0010|0000 */
+#	define XFER_SW_DMA_2	0x12	/* 0001|0010 */
+#	define XFER_SW_DMA_1	0x11	/* 0001|0001 */
+#	define XFER_SW_DMA_0	0x10	/* 0001|0000 */
+#	define XFER_PIO_4	0x0C	/* 0000|1100 */
+#	define XFER_PIO_3	0x0B	/* 0000|1011 */
+#	define XFER_PIO_2	0x0A	/* 0000|1010 */
+#	define XFER_PIO_1	0x09	/* 0000|1001 */
+#	define XFER_PIO_0	0x08	/* 0000|1000 */
+#	define XFER_PIO_SLOW	0x00	/* 0000|0000 */
+
+#define SETFEATURES_DIS_DEFECT	0x04	/* Disable Defect Management */
+#define SETFEATURES_EN_APM	0x05	/* Enable advanced power management */
+#define SETFEATURES_DIS_MSN	0x31	/* Disable Media Status Notification */
+#define SETFEATURES_EN_AAM	0x42	/* Enable Automatic Acoustic Management */
+#define SETFEATURES_DIS_RLA	0x55	/* Disable read look-ahead feature */
+#define SETFEATURES_EN_RI	0x5D	/* Enable release interrupt */
+#define SETFEATURES_EN_SI	0x5E	/* Enable SERVICE interrupt */
+#define SETFEATURES_DIS_RPOD	0x66	/* Disable reverting to power on defaults */
+#define SETFEATURES_DIS_WCACHE	0x82	/* Disable write cache */
+#define SETFEATURES_EN_DEFECT	0x84	/* Enable Defect Management */
+#define SETFEATURES_DIS_APM	0x85	/* Disable advanced power management */
+#define SETFEATURES_EN_MSN	0x95	/* Enable Media Status Notification */
+#define SETFEATURES_EN_RLA	0xAA	/* Enable read look-ahead feature */
+#define SETFEATURES_PREFETCH	0xAB	/* Sets drive prefetch value */
+#define SETFEATURES_DIS_AAM	0xC2	/* Disable Automatic Acoustic Management */
+#define SETFEATURES_EN_RPOD	0xCC	/* Enable reverting to power on defaults */
+#define SETFEATURES_DIS_RI	0xDD	/* Disable release interrupt */
+#define SETFEATURES_DIS_SI	0xDE	/* Disable SERVICE interrupt */
+
+/* WIN_SECURITY sub-commands */
+
+#define SECURITY_SET_PASSWORD		0xBA
+#define SECURITY_UNLOCK			0xBB
+#define SECURITY_ERASE_PREPARE		0xBC
+#define SECURITY_ERASE_UNIT		0xBD
+#define SECURITY_FREEZE_LOCK		0xBE
+#define SECURITY_DISABLE_PASSWORD	0xBF
+
+
+/* Taskfile related constants.
+ */
+#define IDE_DRIVE_TASK_INVALID		-1
+#define IDE_DRIVE_TASK_NO_DATA		0
+#define IDE_DRIVE_TASK_SET_XFER		1
+
+#define IDE_DRIVE_TASK_IN		2
+
+#define IDE_DRIVE_TASK_OUT		3
+#define IDE_DRIVE_TASK_RAW_WRITE	4
+
+struct hd_drive_task_hdr {
+	u8 feature;
+	u8 sector_count;
+	u8 sector_number;
+	u8 low_cylinder;
+	u8 high_cylinder;
+	u8 device_head;
+} __attribute__((packed));
+
+/*
+ * Define standard taskfile in/out register
+ */
+#define IDE_TASKFILE_STD_OUT_FLAGS	0xFE
+#define IDE_TASKFILE_STD_IN_FLAGS	0xFE
+#define IDE_HOB_STD_OUT_FLAGS		0xC0
+#define IDE_HOB_STD_IN_FLAGS		0xC0
+
+#define TASKFILE_INVALID		0x7fff
+#define TASKFILE_48			0x8000
+
+#define TASKFILE_NO_DATA		0x0000
+
+#define TASKFILE_IN			0x0001
+#define TASKFILE_MULTI_IN		0x0002
+
+#define TASKFILE_OUT			0x0004
+#define TASKFILE_MULTI_OUT		0x0008
+#define TASKFILE_IN_OUT			0x0010
+
+#define TASKFILE_IN_DMA			0x0020
+#define TASKFILE_OUT_DMA		0x0040
+#define TASKFILE_IN_DMAQ		0x0080
+#define TASKFILE_OUT_DMAQ		0x0100
+
+#define TASKFILE_P_IN			0x0200
+#define TASKFILE_P_OUT			0x0400
+#define TASKFILE_P_IN_DMA		0x0800
+#define TASKFILE_P_OUT_DMA		0x1000
+#define TASKFILE_P_IN_DMAQ		0x2000
+#define TASKFILE_P_OUT_DMAQ		0x4000
+
+/* bus states */
+enum {
+	BUSSTATE_OFF = 0,
+	BUSSTATE_ON,
+	BUSSTATE_TRISTATE
+};
+
+/*
+ * Structure returned by HDIO_GET_IDENTITY, as per ANSI NCITS ATA6 rev.1b spec.
+ *
+ * If you change something here, please remember to update fix_driveid() in
+ * ide/probe.c.
+ */
+struct hd_driveid {
+	u16	config;		/* lots of obsolete bit flags */
+	u16	cyls;		/* Obsolete, "physical" cyls */
+	u16	reserved2;	/* reserved (word 2) */
+	u16	heads;		/* Obsolete, "physical" heads */
+	u16	track_bytes;	/* unformatted bytes per track */
+	u16	sector_bytes;	/* unformatted bytes per sector */
+	u16	sectors;	/* Obsolete, "physical" sectors per track */
+	u16	vendor0;	/* vendor unique */
+	u16	vendor1;	/* vendor unique */
+	u16	vendor2;	/* Retired vendor unique */
+	u8	serial_no[20];	/* 0 = not_specified */
+	u16	buf_type;	/* Retired */
+	u16	buf_size;	/* Retired, 512 byte increments
+				 * 0 = not_specified
+				 */
+	u16	ecc_bytes;	/* for r/w long cmds; 0 = not_specified */
+	u8	fw_rev[8];	/* 0 = not_specified */
+	char	model[40];	/* 0 = not_specified */
+	u8	max_multsect;	/* 0=not_implemented */
+	u8	vendor3;	/* vendor unique */
+	u16	dword_io;	/* 0=not_implemented; 1=implemented */
+	u8	vendor4;	/* vendor unique */
+	u8	capability;	/* (upper byte of word 49)
+				 *  3:	IORDYsup
+				 *  2:	IORDYsw
+				 *  1:	LBA
+				 *  0:	DMA
+				 */
+	u16	reserved50;	/* reserved (word 50) */
+	u8	vendor5;	/* Obsolete, vendor unique */
+	u8	tPIO;		/* Obsolete, 0=slow, 1=medium, 2=fast */
+	u8	vendor6;	/* Obsolete, vendor unique */
+	u8	tDMA;		/* Obsolete, 0=slow, 1=medium, 2=fast */
+	u16	field_valid;	/* (word 53)
+				 *  2:	ultra_ok	word  88
+				 *  1:	eide_ok		words 64-70
+				 *  0:	cur_ok		words 54-58
+				 */
+	u16	cur_cyls;	/* Obsolete, logical cylinders */
+	u16	cur_heads;	/* Obsolete, l heads */
+	u16	cur_sectors;	/* Obsolete, l sectors per track */
+	u16	cur_capacity0;	/* Obsolete, l total sectors on drive */
+	u16	cur_capacity1;	/* Obsolete, (2 words, misaligned int)     */
+	u8	multsect;	/* current multiple sector count */
+	u8	multsect_valid;	/* when (bit0==1) multsect is ok */
+	u32	lba_capacity;	/* Obsolete, total number of sectors */
+	u16	dma_1word;	/* Obsolete, single-word dma info */
+	u16	dma_mword;	/* multiple-word dma info */
+	u16	eide_pio_modes; /* bits 0:mode3 1:mode4 */
+	u16	eide_dma_min;	/* min mword dma cycle time (ns) */
+	u16	eide_dma_time;	/* recommended mword dma cycle time (ns) */
+	u16	eide_pio;       /* min cycle time (ns), no IORDY  */
+	u16	eide_pio_iordy; /* min cycle time (ns), with IORDY */
+	u16	words69_70[2];	/* reserved words 69-70
+				 * future command overlap and queuing
+				 */
+	/* HDIO_GET_IDENTITY currently returns only words 0 through 70 */
+	u16	words71_74[4];	/* reserved words 71-74
+				 * for IDENTIFY PACKET DEVICE command
+				 */
+	u16	queue_depth;	/* (word 75)
+				 * 15:5	reserved
+				 *  4:0	Maximum queue depth -1
+				 */
+	u16	words76_79[4];	/* reserved words 76-79 */
+	u16	major_rev_num;	/* (word 80) */
+	u16	minor_rev_num;	/* (word 81) */
+	u16	command_set_1;	/* (word 82) supported
+				 * 15:	Obsolete
+				 * 14:	NOP command
+				 * 13:	READ_BUFFER
+				 * 12:	WRITE_BUFFER
+				 * 11:	Obsolete
+				 * 10:	Host Protected Area
+				 *  9:	DEVICE Reset
+				 *  8:	SERVICE Interrupt
+				 *  7:	Release Interrupt
+				 *  6:	look-ahead
+				 *  5:	write cache
+				 *  4:	PACKET Command
+				 *  3:	Power Management Feature Set
+				 *  2:	Removable Feature Set
+				 *  1:	Security Feature Set
+				 *  0:	SMART Feature Set
+				 */
+	u16	command_set_2;	/* (word 83)
+				 * 15:	Shall be ZERO
+				 * 14:	Shall be ONE
+				 * 13:	FLUSH CACHE EXT
+				 * 12:	FLUSH CACHE
+				 * 11:	Device Configuration Overlay
+				 * 10:	48-bit Address Feature Set
+				 *  9:	Automatic Acoustic Management
+				 *  8:	SET MAX security
+				 *  7:	reserved 1407DT PARTIES
+				 *  6:	SetF sub-command Power-Up
+				 *  5:	Power-Up in Standby Feature Set
+				 *  4:	Removable Media Notification
+				 *  3:	APM Feature Set
+				 *  2:	CFA Feature Set
+				 *  1:	READ/WRITE DMA QUEUED
+				 *  0:	Download MicroCode
+				 */
+	u16	cfsse;		/* (word 84)
+				 * cmd set-feature supported extensions
+				 * 15:	Shall be ZERO
+				 * 14:	Shall be ONE
+				 * 13:3	reserved
+				 *  2:	Media Serial Number Valid
+				 *  1:	SMART selt-test supported
+				 *  0:	SMART error logging
+				 */
+	u16	cfs_enable_1;	/* (word 85)
+				 * command set-feature enabled
+				 * 15:	Obsolete
+				 * 14:	NOP command
+				 * 13:	READ_BUFFER
+				 * 12:	WRITE_BUFFER
+				 * 11:	Obsolete
+				 * 10:	Host Protected Area
+				 *  9:	DEVICE Reset
+				 *  8:	SERVICE Interrupt
+				 *  7:	Release Interrupt
+				 *  6:	look-ahead
+				 *  5:	write cache
+				 *  4:	PACKET Command
+				 *  3:	Power Management Feature Set
+				 *  2:	Removable Feature Set
+				 *  1:	Security Feature Set
+				 *  0:	SMART Feature Set
+				 */
+	u16	cfs_enable_2;	/* (word 86)
+				 * command set-feature enabled
+				 * 15:	Shall be ZERO
+				 * 14:	Shall be ONE
+				 * 13:	FLUSH CACHE EXT
+				 * 12:	FLUSH CACHE
+				 * 11:	Device Configuration Overlay
+				 * 10:	48-bit Address Feature Set
+				 *  9:	Automatic Acoustic Management
+				 *  8:	SET MAX security
+				 *  7:	reserved 1407DT PARTIES
+				 *  6:	SetF sub-command Power-Up
+				 *  5:	Power-Up in Standby Feature Set
+				 *  4:	Removable Media Notification
+				 *  3:	APM Feature Set
+				 *  2:	CFA Feature Set
+				 *  1:	READ/WRITE DMA QUEUED
+				 *  0:	Download MicroCode
+				 */
+	u16	csf_default;	/* (word 87)
+				 * command set-feature default
+				 * 15:	Shall be ZERO
+				 * 14:	Shall be ONE
+				 * 13:3	reserved
+				 *  2:	Media Serial Number Valid
+				 *  1:	SMART selt-test supported
+				 *  0:	SMART error logging
+				 */
+	u16	dma_ultra;	/* (word 88) */
+	u16	word89;		/* reserved (word 89) */
+	u16	word90;		/* reserved (word 90) */
+	u16	CurAPMvalues;	/* current APM values */
+	u16	word92;		/* reserved (word 92) */
+	u16	hw_config;	/* hardware config (word 93)
+				 * 15:
+				 * 14:
+				 * 13:
+				 * 12:
+				 * 11:
+				 * 10:
+				 *  9:
+				 *  8:
+				 *  7:
+				 *  6:
+				 *  5:
+				 *  4:
+				 *  3:
+				 *  2:
+				 *  1:
+				 *  0:
+				 */
+	u16	acoustic;	/* (word 94)
+				 * 15:8	Vendor's recommended value
+				 *  7:0	current value
+				 */
+	u16	words95_99[5];	/* reserved words 95-99 */
+	u64	lba_capacity_2;	/* 48-bit total number of sectors */
+	u16	words104_125[22];/* reserved words 104-125 */
+	u16	last_lun;	/* (word 126) */
+	u16	word127;	/* (word 127) Feature Set
+				 * Removable Media Notification
+				 * 15:2	reserved
+				 *  1:0	00 = not supported
+				 *	01 = supported
+				 *	10 = reserved
+				 *	11 = reserved
+				 */
+	u16	dlf;		/* (word 128)
+				 * device lock function
+				 * 15:9	reserved
+				 *  8	security level 1:max 0:high
+				 *  7:6	reserved
+				 *  5	enhanced erase
+				 *  4	expire
+				 *  3	frozen
+				 *  2	locked
+				 *  1	en/disabled
+				 *  0	capability
+				 */
+	u16	csfo;		/* (word 129)
+				 * current set features options
+				 * 15:4	reserved
+				 *  3:	auto reassign
+				 *  2:	reverting
+				 *  1:	read-look-ahead
+				 *  0:	write cache
+				 */
+	u16	words130_155[26];/* reserved vendor words 130-155 */
+	u16	word156;	/* reserved vendor word 156 */
+	u16	words157_159[3];/* reserved vendor words 157-159 */
+	u16	cfa_power;	/* (word 160) CFA Power Mode
+				 * 15 word 160 supported
+				 * 14 reserved
+				 * 13
+				 * 12
+				 * 11:0
+				 */
+	u16	words161_175[14];/* Reserved for CFA */
+	u16	words176_205[31];/* Current Media Serial Number */
+	u16	words206_254[48];/* reserved words 206-254 */
+	u16	integrity_word;	/* (word 255)
+				 * 15:8 Checksum
+				 *  7:0 Signature
+				 */
+} __attribute__((packed));
+
+#define IDE_NICE_DSC_OVERLAP	(0)	/* per the DSC overlap protocol */
 
 /*
  * Probably not wise to fiddle with these
@@ -105,6 +557,35 @@ enum {
 #define GET_ALTSTAT()		IN_BYTE(drive->channel->io_ports[IDE_CONTROL_OFFSET])
 #define GET_FEAT()		IN_BYTE(IDE_NSECTOR_REG)
 
+/* Bits of HD_STATUS */
+#define ERR_STAT		0x01
+#define INDEX_STAT		0x02
+#define ECC_STAT		0x04	/* Corrected error */
+#define DRQ_STAT		0x08
+#define SEEK_STAT		0x10
+#define SERVICE_STAT		SEEK_STAT
+#define WRERR_STAT		0x20
+#define READY_STAT		0x40
+#define BUSY_STAT		0x80
+
+/* Bits for HD_ERROR */
+#define MARK_ERR		0x01	/* Bad address mark */
+#define TRK0_ERR		0x02	/* couldn't find track 0 */
+#define ABRT_ERR		0x04	/* Command aborted */
+#define MCR_ERR			0x08	/* media change request */
+#define ID_ERR			0x10	/* ID field not found */
+#define MC_ERR			0x20	/* media changed */
+#define ECC_ERR			0x40	/* Uncorrectable ECC error */
+#define BBD_ERR			0x80	/* pre-EIDE meaning:  block marked bad */
+#define ICRC_ERR		0x80	/* new meaning:  CRC error during transfer */
+
+/*
+ * sector count bits
+ */
+#define NSEC_CD			0x01
+#define NSEC_IO			0x02
+#define NSEC_REL		0x04
+
 #define BAD_R_STAT		(BUSY_STAT   | ERR_STAT)
 #define BAD_W_STAT		(BAD_R_STAT  | WRERR_STAT)
 #define BAD_STAT		(BAD_R_STAT  | DRQ_STAT)
Binary files linux-2.5.29/scripts/docproc and linux/scripts/docproc differ
Binary files linux-2.5.29/scripts/lxdialog/lxdialog and linux/scripts/lxdialog/lxdialog differ

--------------010705040209040208080808--


