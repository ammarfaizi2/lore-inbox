Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269481AbRH0WRg>; Mon, 27 Aug 2001 18:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269639AbRH0WRY>; Mon, 27 Aug 2001 18:17:24 -0400
Received: from mail.courier-mta.com ([216.254.50.2]:14608 "EHLO
	mail.courier-mta.com") by vger.kernel.org with ESMTP
	id <S269421AbRH0WRC>; Mon, 27 Aug 2001 18:17:02 -0400
Date: Mon, 27 Aug 2001 18:17:19 -0400 (EDT)
From: Sam Varshavchik <mrsam@courier-mta.com>
X-X-Sender: <geo@ny.email-scan.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.9 ide-floppy broken - 2.4.8 works ok
In-Reply-To: <fa.cv4c3uv.cnsuh8@ifi.uio.no>
Message-ID: <Pine.LNX.4.33.0108271812200.5262-100000@ny.email-scan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In article <fa.cv4c3uv.cnsuh8@ifi.uio.no>,
	Floydsmith@aol.com writes:

> My ls-120 drive is connected to /dev/hdd (a scsi emulated IDE drive is
> connected to /dev/hdc)
>
> The "messages" has:
> Aug 27 17:17:28 localhost kernel: hdb: 30043440 sectors (15382 MB) w/2048KiB
> Cache, CHS=1870/255/63
> Aug 27 17:17:28 localhost kernel: ide-floppy driver 0.97
> Aug 27 17:17:28 localhost kernel: hdd: No disk in drive
> Aug 27 17:17:28 localhost kernel: hdd: 123264kB, 963/8/32 CHS, 533 kBps, 512
> sector size, 720 rpm
> Aug 27 17:17:28 localhost kernel: ide-floppy: hdd: I/O error, pc = 5a, key =
> 5, asc = 24, ascq =  0
> Aug 27 17:17:28 localhost kernel: Partition check:
> Aug 27 17:17:28 localhost kernel:  hda: hda1 hda2 hda3 hda4 < hda5 >
> Aug 27 17:17:28 localhost kernel:  hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 >
> Aug 27 17:17:28 localhost kernel: ide-floppy driver 0.97
>
> Same message appears when a diskette is attempted to be mounted.

Huh???

[ clickety-click ]

<Sigh> Looks like the merge from Paul's tree in 2.4.7-ac3 either wasn't
complete, or Paul backed out one of my patches.  At least the following
code existed in Paul's tree six months ago.  You are logging a bogus error
message because the drive is bouncing an optional
IDEFLOPPY_CAPABILITIES_PAGE ATAPI packet.  This can be ignored.  False
alarm.  Try the following patch, which suppresses this crap.



Index: ide-floppy.c
===================================================================
RCS file: /home/mrsam/cvsroot/ide-floppy/ide-floppy/linus-tree/ide-floppy.c,v
retrieving revision 1.2
diff -U3 -r1.2 ide-floppy.c
--- ide-floppy.c	2001/08/27 21:55:52	1.2
+++ ide-floppy.c	2001/08/27 21:58:44
@@ -1,7 +1,8 @@
 /*
- * linux/drivers/ide/ide-floppy.c	Version 0.9.sv	Jan 6 2001
+ * linux/drivers/ide/ide-floppy.c	Version 0.97.sv	Jan 14 2001
  *
  * Copyright (C) 1996 - 1999 Gadi Oxman <gadio@netvision.net.il>
+ * Copyright (C) 2000 - 2001 Paul Bristow <paul@paulbristow.net>
  */

 /*
@@ -10,6 +11,12 @@
  * The driver currently doesn't have any fancy features, just the bare
  * minimum read/write support.
  *
+ * This driver supports the following IDE floppy drives:
+ *
+ * LS-120 SuperDisk
+ * Iomega Zip 100/250
+ * Iomega PC Card Clik!/PocketZip
+ *
  * Many thanks to Lode Leroy <Lode.Leroy@www.ibase.be>, who tested so many
  * ALPHA patches to this driver on an EASYSTOR LS-120 ATAPI floppy drive.
  *
@@ -38,6 +45,20 @@
  *                       mode page.  Implemented four IOCTLs in order to
  *                       implement formatting.  IOCTls begin with 0x4600,
  *                       0x46 is 'F' as in Format.
+ *            Jan 9 01   Userland option to select format verify.
+ *                       Added PC_SUPPRESS_ERROR flag - some idefloppy drives
+ *                       do not implement IDEFLOPPY_CAPABILITIES_PAGE, and
+ *                       return a sense error.  Suppress error reporting in
+ *                       this particular case in order to avoid spurious
+ *                       errors in syslog.  The culprit is
+ *                       idefloppy_get_capability_page(), so move it to
+ *                       idefloppy_begin_format() so that it's not used
+ *                       unless absolutely necessary.
+ *                       If drive does not support format progress indication
+ *                       monitor the dsc bit in the status register.
+ *                       Also, O_NDELAY on open will allow the device to be
+ *                       opened without a disk available.  This can be used to
+ *                       open an unformatted disk, or get the device capacity.
  * Ver 0.91  Dec 11 99   Added IOMEGA Clik! drive support by
  *     		   <paul@paulbristow.net>
  * Ver 0.92  Oct 22 00   Paul Bristow became official maintainer for this
@@ -49,9 +70,10 @@
  * Ver 0.96  Jan  7 01   Actually in line with release version of 2.4.0
  *                       including set_bit patch from Rusty Russel
  * Ver 0.97  Jul 22 01   Merge 0.91-0.96 onto 0.9.sv for ac series
+ * Ver 0.97.sv Aug 3 01  Backported from 2.4.7-ac3
  */

-#define IDEFLOPPY_VERSION "0.97"
+#define IDEFLOPPY_VERSION "0.97.sv"

 #include <linux/config.h>
 #include <linux/module.h>
@@ -140,6 +162,8 @@
 #define	PC_DMA_ERROR			4	/* 1 when encountered problem during DMA */
 #define	PC_WRITING			5	/* Data direction */

+#define	PC_SUPPRESS_ERROR		6	/* Suppress error reporting */
+
 /*
  *	Removable Block Access Capabilities Page
  */
@@ -1022,8 +1046,11 @@
 		 *	a legitimate error code was received.
 		 */
 		if (!test_bit (PC_ABORT, &pc->flags)) {
-			printk (KERN_ERR "ide-floppy: %s: I/O error, pc = %2x, key = %2x, asc = %2x, ascq = %2x\n",
+			if (!test_bit (PC_SUPPRESS_ERROR, &pc->flags)) {
+				;
+      printk( KERN_ERR "ide-floppy: %s: I/O error, pc = %2x, key = %2x, asc = %2x, ascq = %2x\n",
 				drive->name, pc->c[0], floppy->sense_key, floppy->asc, floppy->ascq);
+			}
 			pc->error = IDEFLOPPY_ERROR_GENERAL;		/* Giving up */
 		}
 		floppy->failed_pc=NULL;
@@ -1101,14 +1128,19 @@
 	pc->request_transfer = 255;
 }

-static void idefloppy_create_format_unit_cmd (idefloppy_pc_t *pc, int b, int l)
+static void idefloppy_create_format_unit_cmd (idefloppy_pc_t *pc, int b, int l,
+					      int flags)
 {
 	idefloppy_init_pc (pc);
 	pc->c[0] = IDEFLOPPY_FORMAT_UNIT_CMD;
 	pc->c[1] = 0x17;

 	memset(pc->buffer, 0, 12);
-	pc->buffer[1] = 0xA2;	/* Format list header, byte 1: FOV/DCRT/IMM */
+	pc->buffer[1] = 0xA2;
+	/* Default format list header, byte 1: FOV/DCRT/IMM bits set */
+
+	if (flags & 1)				/* Verify bit on... */
+		pc->buffer[1] ^= 0x20;		/* ... turn off DCRT bit */
 	pc->buffer[3] = 8;

 	put_unaligned(htonl(b), (unsigned int *)(&pc->buffer[4]));
@@ -1300,9 +1332,12 @@
 	floppy->srfp=0;
 	idefloppy_create_mode_sense_cmd (&pc, IDEFLOPPY_CAPABILITIES_PAGE,
 						 MODE_SENSE_CURRENT);
+
+	set_bit(PC_SUPPRESS_ERROR, &pc.flags);
 	if (idefloppy_queue_pc_tail (drive,&pc)) {
 		return 1;
 	}
+
 	header = (idefloppy_mode_parameter_header_t *) pc.buffer;
 	page= (idefloppy_capabilities_page_t *)(header+1);
 	floppy->srfp=page->srfp;
@@ -1378,7 +1413,6 @@
         if (!test_bit(IDEFLOPPY_CLIK_DRIVE, &floppy->flags))
 	{
 		(void) idefloppy_get_flexible_disk_page (drive);
-		(void) idefloppy_get_capability_page (drive);
 	}

 	drive->part[0].nr_sects = floppy->blocks * floppy->bs_factor;
@@ -1478,7 +1512,12 @@
 ** struct idefloppy_format_command {
 **        int nblocks;
 **        int blocksize;
+**        int flags;
 **        } ;
+**
+** flags is a bitmask, currently, the only defined flag is:
+**
+**        0x01 - verify media after format.
 */

 static int idefloppy_begin_format(ide_drive_t *drive,
@@ -1488,15 +1527,18 @@
 {
 	int blocks;
 	int length;
+	int flags;
 	idefloppy_pc_t pc;

 	if (get_user(blocks, arg)
-	    || get_user(length, arg+1))
+	    || get_user(length, arg+1)
+	    || get_user(flags, arg+2))
 	{
 		return (-EFAULT);
 	}

-	idefloppy_create_format_unit_cmd(&pc, blocks, length);
+	(void) idefloppy_get_capability_page (drive);	/* Get the SFRP bit */
+	idefloppy_create_format_unit_cmd(&pc, blocks, length, flags);
 	if (idefloppy_queue_pc_tail (drive, &pc))
 	{
                 return (-EIO);
@@ -1510,8 +1552,8 @@
 ** Userland gives a pointer to an int.  The int is set to a progresss
 ** indicator 0-65536, with 65536=100%.
 **
-** If the drive does not support format progress indication, we just return
-** a 65536, screw it.
+** If the drive does not support format progress indication, we just check
+** the dsc bit, and return either 0 or 65536.
 */

 static int idefloppy_get_format_progress(ide_drive_t *drive,
@@ -1536,8 +1578,21 @@
 		{
 			progress_indication=floppy->progress_indication;
 		}
+		/* Else assume format_unit has finished, and we're
+		** at 0x10000 */
 	}
+	else
+	{
+		idefloppy_status_reg_t status;
+		unsigned long flags;
+
+		__save_flags(flags);
+		__cli();
+		status.all=GET_STAT();
+		__restore_flags(flags);

+		progress_indication= !status.b.dsc ? 0:0x10000;
+	}
 	if (put_user(progress_indication, arg))
 		return (-EFAULT);

@@ -1587,8 +1642,6 @@
 		{
 			idefloppy_floppy_t *floppy = drive->driver_data;

-			set_bit(IDEFLOPPY_FORMAT_IN_PROGRESS, &floppy->flags);
-
 			if (drive->usage > 1)
 			{
 				/* Don't format if someone is using the disk */
@@ -1599,7 +1652,12 @@
 			}
 			else
 			{
-				int rc=idefloppy_begin_format(drive, inode,
+				int rc;
+
+				set_bit(IDEFLOPPY_FORMAT_IN_PROGRESS,
+					&floppy->flags);
+
+				rc=idefloppy_begin_format(drive, inode,
 							      file,
 							      (int *)arg);

@@ -1637,7 +1695,6 @@

 	MOD_INC_USE_COUNT;
 	if (drive->usage == 1) {
-
 		clear_bit(IDEFLOPPY_FORMAT_IN_PROGRESS, &floppy->flags);
 		/* Just in case */

@@ -1646,21 +1703,26 @@
 			idefloppy_create_start_stop_cmd (&pc, 1);
 			(void) idefloppy_queue_pc_tail (drive, &pc);
 		}
-
-		if (idefloppy_get_capacity (drive)) {
+		if (idefloppy_get_capacity (drive)
+		   && (filp->f_flags & O_NDELAY) == 0
+		    /*
+		    ** Allow O_NDELAY to open a drive without a disk, or with
+		    ** an unreadable disk, so that we can get the format
+		    ** capacity of the drive or begin the format - Sam
+		    */
+		    ) {
 			drive->usage--;
 			MOD_DEC_USE_COUNT;
 			return -EIO;
 		}
-
 		if (floppy->wp && (filp->f_mode & 2)) {
 			drive->usage--;
 			MOD_DEC_USE_COUNT;
 			return -EROFS;
 		}
 		set_bit (IDEFLOPPY_MEDIA_CHANGED, &floppy->flags);
-		/* IOMEGA Clik! drives do not support lock/unlock commands */
-                if (!test_bit(IDEFLOPPY_CLIK_DRIVE, &floppy->flags)) {
+		/* IOMEGA Clik! drives do not support lock/unlock commands - no room for mechanism */
+		if (!test_bit(IDEFLOPPY_CLIK_DRIVE, &floppy->flags)) {
 			idefloppy_create_prevent_cmd (&pc, 1);
 			(void) idefloppy_queue_pc_tail (drive, &pc);
 		}
@@ -1893,6 +1955,17 @@
 		for (i = 0; i < 1 << PARTN_BITS; i++)
 			max_sectors[major][minor + i] = 64;
 	}
+  /*
+   *      Guess what?  The IOMEGA Clik! drive also needs the
+   *      above fix.  It makes nasty clicking noises without
+   *      it, so please don't remove this.
+   */
+  if (strcmp(drive->id->model, "IOMEGA Clik! 40 CZ ATAPI") == 0)
+  {
+    for (i = 0; i < 1 << PARTN_BITS; i++)
+      max_sectors[major][minor + i] = 64;
+    set_bit(IDEFLOPPY_CLIK_DRIVE, &floppy->flags);
+  }

 	/*
 	*      Guess what?  The IOMEGA Clik! drive also needs the




