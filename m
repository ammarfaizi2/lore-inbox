Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282005AbRKVHir>; Thu, 22 Nov 2001 02:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282066AbRKVHih>; Thu, 22 Nov 2001 02:38:37 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:20522 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S282005AbRKVHic>; Thu, 22 Nov 2001 02:38:32 -0500
Message-ID: <3BFCABAA.4020805@paulbristow.net>
Date: Thu, 22 Nov 2001 08:39:22 +0100
From: Paul Bristow <paul@paulbristow.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010914
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] ide-floppy update to fix lockups with ZIP + Via chipset
Content-Type: multipart/mixed;
 boundary="------------060108010509090203000906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060108010509090203000906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi everyone,

This patch is intended to fix the lockup problem that some people are 
experiencing with the combination of the Via 82cxxx chipset and ZIP drives.

It doesn't affect other chipset drive combinations so it is safe to just 
apply it.

It applies to kernel 2.4.14.

Thanks to Skip Gaede, Timo Tera and Gadi Oxman for the suggestions...

Regards,

-- 

Paul

ide-floppy maintainer
Email: 
paul@paulbristow.net
Web: 
http://paulbristow.net
ICQ: 
11965223

--------------060108010509090203000906
Content-Type: text/plain;
 name="via-patch-paul"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="via-patch-paul"

diff -urN -X dontdiff linux-2.4.14-clean/drivers/ide/ide-floppy.c linux-2.4.14/drivers/ide/ide-floppy.c
--- linux-2.4.14-clean/drivers/ide/ide-floppy.c	Thu Oct 11 18:14:32 2001
+++ linux-2.4.14/drivers/ide/ide-floppy.c	Wed Nov 21 22:39:44 2001
@@ -71,9 +71,20 @@
  *                       including set_bit patch from Rusty Russel
  * Ver 0.97  Jul 22 01   Merge 0.91-0.96 onto 0.9.sv for ac series
  * Ver 0.97.sv Aug 3 01  Backported from 2.4.7-ac3
+ * Ver 0.98  Nov  8 01   There is a bug with the Via82c686b chip when used with
+ *		an ATAPI ZIP drive. The problem occurs when issuing write 
+ *		commands to the drive, and it doesn't happen with the promise
+ *		pdc20265 chipset. Both Skip Gaede (sgaede@mediaone.net) and
+ *		Timo Teras (timo.teras@iki.fi) discovered that including
+ *		a delay fixed the problem. Gadi Oxman suggested using the timer
+ *		queue instead of counting, and Timo implemented code to limit
+ *		the delay to machines having the via chipset. A delay of 50
+ *		msec works on my system. The variable ticks is exposed 
+ *		in /proc/ide/hdx/settings. Each tick is 10 msec. If ticks is
+ *		set to zero, the driver reverts to the old algorithm. --Skip
  */
 
-#define IDEFLOPPY_VERSION "0.97.sv"
+#define IDEFLOPPY_VERSION "0.98"
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -276,6 +287,7 @@
 	 *	Last error information
 	 */
 	byte sense_key, asc, ascq;
+	byte ticks;		/* delay this long before sending packet command */
 	int progress_indication;
 
 	/*
@@ -287,8 +299,18 @@
 	int wp;							/* Write protect */
 	int srfp;			/* Supports format progress report */
 	unsigned long flags;			/* Status/Action flags */
+	unsigned long via_kludge;			/* holds jiffies after write cmds */
 } idefloppy_floppy_t;
 
+/* 
+ * default delay for VIA chipset (50 ms, or 5 ticks)
+ * This value is exposed as the variable ticks and may be adjusted if necessary.
+ * On my system, a 1200 mhz Athlon with the Asus A7V133 board. this is the minimum 
+ * delay. If set to zero, the standard algorithm is used. Note: my board also has a 
+ * Promise PDC20265 (ATA100) controller. The ZIP drive works fine on the other chipset.
+ */
+#define IDEFLOPPY_TICKS_DELAY		((50 * HZ) / 1000)	
+
 /*
  *	Floppy flag bits values.
  */
@@ -296,8 +318,8 @@
 #define IDEFLOPPY_MEDIA_CHANGED		1	/* Media may have changed */
 #define IDEFLOPPY_USE_READ12		2	/* Use READ12/WRITE12 or READ10/WRITE10 */
 #define	IDEFLOPPY_FORMAT_IN_PROGRESS	3	/* Format in progress */
-#define IDEFLOPPY_CLIK_DRIVE	        4       /* Avoid commands not supported in Clik drive */
-
+#define IDEFLOPPY_CLIK_DRIVE	        4	/* Avoid commands not supported in Clik drive */
+#define IDEFLOPPY_SLOW_DRIVE		5	/* Need two stage algorithm */
 
 /*
  *	ATAPI floppy drive packet commands
@@ -1001,6 +1023,11 @@
 	return ide_started;
 }
 
+/*
+ * This is the standard routine that does the packet transfer. On systems with
+ * a VIA chip and ATAPI ZIP drives, routines transfer_pc1 and transfer_pc2
+ * are used instead. The algorithm is selected in idefloppy_issue_pc
+ */
 static ide_startstop_t idefloppy_transfer_pc (ide_drive_t *drive)
 {
 	ide_startstop_t startstop;
@@ -1021,6 +1048,55 @@
 	return ide_started;
 }
 
+
+/*
+ * Transfer_pc1 is called when the device says it's ready for a packet.
+ * The packet transfer occurs 50 msec (5 ticks) later in transfer_pc2.
+ */
+static int idefloppy_transfer_pc2 (ide_drive_t *drive)
+{
+	idefloppy_floppy_t *floppy = drive->driver_data;
+
+	atapi_output_bytes (drive, floppy->pc->c, 12); /* Send the actual packet */
+	return IDEFLOPPY_WAIT_CMD;		/* Timeout for the packet command */
+}
+
+static ide_startstop_t idefloppy_transfer_pc1 (ide_drive_t *drive)
+{
+	idefloppy_floppy_t *floppy = drive->driver_data;
+	ide_startstop_t startstop;
+	idefloppy_ireason_reg_t ireason;
+	unsigned long wait=0;
+	
+	if (floppy->via_kludge) {
+		if (time_before(jiffies,floppy->via_kludge)) {
+			wait = floppy->via_kludge - jiffies;
+		} 
+		floppy->via_kludge = 0;
+	}
+
+	if (ide_wait_stat (&startstop,drive,DRQ_STAT,BUSY_STAT,WAIT_READY)) {
+		printk (KERN_ERR "ide-floppy: Strange, packet command initiated yet DRQ isn't asserted\n");
+		return startstop;
+	}
+	ireason.all=IN_BYTE (IDE_IREASON_REG);
+	if (!ireason.b.cod || ireason.b.io) {
+		printk (KERN_ERR "ide-floppy: (IO,CoD) != (0,1) while issuing a packet command\n");
+		return ide_do_reset (drive);
+	}
+	/* 
+	 * We set the handler for the interrupt in response to the packet written
+	 * in transfer_pc2. Transfer_pc2 will be called after the variable number
+	 * of ticks has expired, and it will then set the timeout for the packet
+	 * command interrupt. This is a work around for the via82c686b chip.
+	 */
+	ide_set_handler (drive, 
+	  &idefloppy_pc_intr, 		/* service routine for next interrupt */
+	  wait,			/* wait before back to back writes */
+	  &idefloppy_transfer_pc2);	/* called when timeout occurs to write packet */
+	return ide_started;
+}
+
 /*
  *	Issue a packet command
  */
@@ -1029,6 +1105,7 @@
 	idefloppy_floppy_t *floppy = drive->driver_data;
 	idefloppy_bcount_reg_t bcount;
 	int dma_ok = 0;
+	ide_handler_t *pkt_xfer_routine;
 
 #if IDEFLOPPY_DEBUG_BUGS
 	if (floppy->pc->c[0] == IDEFLOPPY_REQUEST_SENSE_CMD && pc->c[0] == IDEFLOPPY_REQUEST_SENSE_CMD) {
@@ -1088,23 +1165,43 @@
 	}
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 
+	/* Can we transfer the packet when we get the interrupt or wait? */
+	if (floppy->ticks &&	/* if user has not disabled this, and */
+	    floppy->via_kludge &&  /* it might be the right thing to do, and */
+	    time_before(jiffies, floppy->via_kludge)) { /* a delay is needed */
+		pkt_xfer_routine = &idefloppy_transfer_pc1;	/* wait */
+	} else {
+		floppy->via_kludge = 0;
+		pkt_xfer_routine = &idefloppy_transfer_pc;	/* immediate */
+	}
+	
 	if (test_bit (IDEFLOPPY_DRQ_INTERRUPT, &floppy->flags)) {
-		ide_set_handler (drive, &idefloppy_transfer_pc, IDEFLOPPY_WAIT_CMD, NULL);
+		ide_set_handler (drive, pkt_xfer_routine, IDEFLOPPY_WAIT_CMD, NULL);
 		OUT_BYTE (WIN_PACKETCMD, IDE_COMMAND_REG);		/* Issue the packet command */
 		return ide_started;
 	} else {
 		OUT_BYTE (WIN_PACKETCMD, IDE_COMMAND_REG);
-		return idefloppy_transfer_pc (drive);
+		return (*pkt_xfer_routine) (drive);
 	}
 }
 
 static void idefloppy_rw_callback (ide_drive_t *drive)
 {
+	idefloppy_floppy_t *floppy = drive->driver_data;
+
 #if IDEFLOPPY_DEBUG_LOG	
 	printk (KERN_INFO "ide-floppy: Reached idefloppy_rw_callback\n");
 #endif /* IDEFLOPPY_DEBUG_LOG */
 
 	idefloppy_end_request(1, HWGROUP(drive));
+	
+	if (test_bit(IDEFLOPPY_SLOW_DRIVE, &floppy->flags) &&
+	   (floppy->pc->c[0] == IDEFLOPPY_WRITE10_CMD ||
+	    floppy->pc->c[0] == IDEFLOPPY_WRITE12_CMD)) {
+		floppy->via_kludge = jiffies + floppy->ticks;
+					/* time when we can do next write */
+	}
+	
 	return;
 }
 
@@ -1242,6 +1339,8 @@
 	}
 	switch (rq->cmd) {
 		case READ:
+			floppy->via_kludge = 0;		/* not back to back writes */
+			/* fall through */
 		case WRITE:
 			if (rq->sector % floppy->bs_factor || rq->nr_sectors % floppy->bs_factor) {
 				printk ("%s: unsupported r/w request size\n", drive->name);
@@ -1914,14 +2013,18 @@
 {
 	int major = HWIF(drive)->major;
 	int minor = drive->select.b.unit << PARTN_BITS;
+	idefloppy_floppy_t *floppy = drive->driver_data;
 
-	ide_add_setting(drive,	"bios_cyl",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	1023,				1,	1,	&drive->bios_cyl,		NULL);
-	ide_add_setting(drive,	"bios_head",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	255,				1,	1,	&drive->bios_head,		NULL);
-	ide_add_setting(drive,	"bios_sect",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	63,				1,	1,	&drive->bios_sect,		NULL);
-	ide_add_setting(drive,	"breada_readahead",	SETTING_RW,					BLKRAGET,		BLKRASET,		TYPE_INT,	0,	255,				1,	2,	&read_ahead[major],		NULL);
-	ide_add_setting(drive,	"file_readahead",	SETTING_RW,					BLKFRAGET,		BLKFRASET,		TYPE_INTA,	0,	INT_MAX,			1,	1024,	&max_readahead[major][minor],	NULL);
-	ide_add_setting(drive,	"max_kb_per_request",	SETTING_RW,					BLKSECTGET,		BLKSECTSET,		TYPE_INTA,	1,	255,				1,	2,	&max_sectors[major][minor],	NULL);
-
+/*
+ *			drive	setting name		read/write	ioctl		ioctl		data type	min	max	 mul_factor  div_factor	data pointer		set function
+ */
+	ide_add_setting(drive,	"bios_cyl",		SETTING_RW,	-1,		-1,		TYPE_INT,	0,	1023,		1,	1,	&drive->bios_cyl,		NULL);
+	ide_add_setting(drive,	"bios_head",		SETTING_RW,	-1,		-1,		TYPE_BYTE,	0,	255,		1,	1,	&drive->bios_head,		NULL);
+	ide_add_setting(drive,	"bios_sect",		SETTING_RW,	-1,		-1,		TYPE_BYTE,	0,	63,		1,	1,	&drive->bios_sect,		NULL);
+	ide_add_setting(drive,	"breada_readahead",	SETTING_RW,	BLKRAGET,	BLKRASET,	TYPE_INT,	0,	255,		1,	2,	&read_ahead[major],		NULL);
+	ide_add_setting(drive,	"file_readahead",	SETTING_RW,	BLKFRAGET,	BLKFRASET,	TYPE_INTA,	0,	INT_MAX,	1,	1024,	&max_readahead[major][minor],	NULL);
+	ide_add_setting(drive,	"max_kb_per_request",	SETTING_RW,	BLKSECTGET,	BLKSECTSET,	TYPE_INTA,	1,	255,		1,	2,	&max_sectors[major][minor],	NULL);
+	ide_add_setting(drive,	"ticks",		SETTING_RW,	-1,		-1,		TYPE_BYTE,	0,	255,		1,	1,	&floppy->ticks,			NULL);
 }
 
 /*
@@ -1941,6 +2044,9 @@
 	floppy->pc = floppy->pc_stack;
 	if (gcw.drq_type == 1)
 		set_bit (IDEFLOPPY_DRQ_INTERRUPT, &floppy->flags);
+	/* the following value can be tweaked under /proc/ide/hdx/settings */
+	floppy->ticks = IDEFLOPPY_TICKS_DELAY;
+
 	/*
 	 *	We used to check revisions here. At this point however
 	 *	I'm giving up. Just assume they are all broken, its easier.
@@ -1954,20 +2060,13 @@
 
 	if (strcmp(drive->id->model, "IOMEGA ZIP 100 ATAPI") == 0)
 	{
+		if (HWIF(drive)->chipset == ide_via82cxxx) {
+			/* FIXME: appropriate for other drives as well?? */
+			set_bit(IDEFLOPPY_SLOW_DRIVE, &floppy->flags);
+		}
 		for (i = 0; i < 1 << PARTN_BITS; i++)
 			max_sectors[major][minor + i] = 64;
 	}
-  /*
-   *      Guess what?  The IOMEGA Clik! drive also needs the
-   *      above fix.  It makes nasty clicking noises without
-   *      it, so please don't remove this.
-   */
-  if (strcmp(drive->id->model, "IOMEGA Clik! 40 CZ ATAPI") == 0)
-  {
-    for (i = 0; i < 1 << PARTN_BITS; i++)
-      max_sectors[major][minor + i] = 64;
-    set_bit(IDEFLOPPY_CLIK_DRIVE, &floppy->flags);
-  }
 
 	/*
 	*      Guess what?  The IOMEGA Clik! drive also needs the
@@ -2057,8 +2156,6 @@
 	NULL
 };
 
-MODULE_DESCRIPTION("ATAPI FLOPPY Driver");
-
 static void __exit idefloppy_exit (void)
 {
 	ide_drive_t *drive;
@@ -2086,7 +2183,6 @@
 	idefloppy_floppy_t *floppy;
 	int failed = 0;
 
-	printk("ide-floppy driver " IDEFLOPPY_VERSION "\n");
 	MOD_INC_USE_COUNT;
 	while ((drive = ide_scan_devices (ide_floppy, idefloppy_driver.name, NULL, failed++)) != NULL) {
 		if (!idefloppy_identify_device (drive, drive->id)) {
@@ -2117,3 +2213,6 @@
 module_init(idefloppy_init);
 module_exit(idefloppy_exit);
 MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Maintainer: Paul Bristow <paul@paulbristow.net>");
+MODULE_DESCRIPTION("ATAPI Floppy Driver V"IDEFLOPPY_VERSION);
+
diff -urN -X dontdiff linux-2.4.14-clean/drivers/ide/via82cxxx.c linux-2.4.14/drivers/ide/via82cxxx.c
--- linux-2.4.14-clean/drivers/ide/via82cxxx.c	Tue Sep 11 17:40:36 2001
+++ linux-2.4.14/drivers/ide/via82cxxx.c	Wed Nov 21 19:23:04 2001
@@ -510,6 +510,7 @@
 	hwif->tuneproc = &via82cxxx_tune_drive;
 	hwif->speedproc = &via_set_drive;
 	hwif->autodma = 0;
+	hwif->chipset = ide_via82cxxx;	/* Timo's patch */
 
 	for (i = 0; i < 2; i++) {
 		hwif->drives[i].io_32bit = 1;
diff -urN -X dontdiff linux-2.4.14-clean/include/linux/ide.h linux-2.4.14/include/linux/ide.h
--- linux-2.4.14-clean/include/linux/ide.h	Mon Nov  5 21:43:28 2001
+++ linux-2.4.14/include/linux/ide.h	Wed Nov 21 20:27:56 2001
@@ -449,7 +449,7 @@
 		ide_qd65xx,	ide_umc8672,	ide_ht6560b,
 		ide_pdc4030,	ide_rz1000,	ide_trm290,
 		ide_cmd646,	ide_cy82c693,	ide_4drives,
-		ide_pmac,       ide_etrax100
+		ide_pmac,       ide_etrax100,	ide_via82cxxx
 } hwif_chipset_t;
 
 #define IDE_CHIPSET_PCI_MASK	\

--------------060108010509090203000906--

