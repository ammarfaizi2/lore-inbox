Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316879AbSE1SjP>; Tue, 28 May 2002 14:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316880AbSE1SjO>; Tue, 28 May 2002 14:39:14 -0400
Received: from [195.63.194.11] ([195.63.194.11]:39685 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316879AbSE1SjE>; Tue, 28 May 2002 14:39:04 -0400
Message-ID: <3CF3BFE3.2040408@evision-ventures.com>
Date: Tue, 28 May 2002 19:35:31 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.18 QUEUE_EMPTY and the unpleasant friends.
In-Reply-To: <Pine.LNX.4.33.0205241902001.1537-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------050004060400080208060908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050004060400080208060908
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Tue May 28 17:25:29 CEST 2002

- Eliminate all usages of the obscure QUEUE_EMPTY macro.

- Eliminate all unneccessary checks for RQ_INACTIVE, this can't happen during
   the time we run the request strategy routine of a single major number block
   device. Perhaps the still remaining usage in scsi and i2o_block.c should be
   killed as well, since the upper ll_rw_blk layer shouldn't pass inactive
   requests down.

Those are all places where we have deeply burried and hidden major number
indexed arrays. Let's deal with them slowly...

--------------050004060400080208060908
Content-Type: text/plain;
 name="blk-2.5.18.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="blk-2.5.18.diff"

diff -ur linux-2.5.18/drivers/acorn/block/fd1772.c linux/drivers/acorn/bl=
ock/fd1772.c
--- linux-2.5.18/drivers/acorn/block/fd1772.c	2002-05-25 03:55:23.0000000=
00 +0200
+++ linux/drivers/acorn/block/fd1772.c	2002-05-28 20:07:24.000000000 +020=
0
@@ -591,7 +591,7 @@
 {
 	printk("FDC1772: fd_error\n");
 	/*panic("fd1772: fd_error"); *//* DAG tmp */
-	if (QUEUE_EMPTY)
+	if (blk_queue_empty(QUEUE))
 		return;
 	CURRENT->errors++;
 	if (CURRENT->errors >=3D MAX_ERRORS) {
@@ -1114,16 +1114,6 @@
 static int fd_ref[4];
 static int fd_device[4];
=20
-/*
- * Current device number. Taken either from the block header or from the=

- * format request descriptor.
- */
-#define CURRENT_DEVICE (CURRENT->rq_dev)
-
-/* Current error count. */
-#define CURRENT_ERRORS (CURRENT->errors)
-
-
 /* dummy for blk.h */
 static void floppy_off(unsigned int nr)
 {
@@ -1145,7 +1135,7 @@
 {
 	unsigned int drive =3D (dev & 0x03);
=20
-	if (MAJOR(dev) !=3D MAJOR_NR) {
+	if (major(dev) !=3D MAJOR_NR) {
 		printk("floppy_changed: not a floppy\n");
 		return 0;
 	}
@@ -1205,7 +1195,7 @@
 	ReqData =3D ReqBuffer + 512 * ReqCnt;
=20
 #ifdef TRACKBUFFER
-	read_track =3D (ReqCmd =3D=3D READ && CURRENT_ERRORS =3D=3D 0);
+	read_track =3D (ReqCmd =3D=3D READ && CURRENT->errors =3D=3D 0);
 #endif
=20
 	DPRINT(("Request params: Si=3D%d Tr=3D%d Se=3D%d Data=3D%08lx\n", ReqSi=
de,
@@ -1220,24 +1210,21 @@
=20
 	DPRINT(("redo_fd_request: CURRENT=3D%08lx CURRENT->rq_dev=3D%04x CURREN=
T->sector=3D%ld\n",
 		(unsigned long) CURRENT, CURRENT ? CURRENT->rq_dev : 0,
-		!QUEUE_EMPTY ? CURRENT->sector : 0));
-
-	if (!QUEUE_EMPTY && CURRENT->rq_status =3D=3D RQ_INACTIVE)
-		goto the_end;
+		!blk_queue_empty(QUEUE) ? CURRENT->sector : 0));
=20
 repeat:
=20
-	if (QUEUE_EMPTY)
+	if (blk_queue_empty(QUEUE))
 		goto the_end;
=20
-	if (MAJOR(CURRENT->rq_dev) !=3D MAJOR_NR)
+	if (major(CURRENT->rq_dev) !=3D MAJOR_NR)
 		panic(DEVICE_NAME ": request list destroyed");
=20
 	if (CURRENT->bh) {
 		if (!buffer_locked(CURRENT->bh))
 			panic(DEVICE_NAME ": block not locked");
 	}
-	device =3D MINOR(CURRENT_DEVICE);
+	device =3D minor(CURRENT->rq_dev);
 	drive =3D device & 3;
 	type =3D device >> 2;
 	floppy =3D &unit[drive];
@@ -1343,7 +1330,7 @@
 	int drive, device;
=20
 	device =3D inode->i_rdev;
-	drive =3D MINOR(device);
+	drive =3D minor(device);
 	switch (cmd) {
 	case FDFMTBEG:
 		return 0;
@@ -1502,8 +1489,8 @@
 		DPRINT(("Weird, open called with filp=3D0\n"));
 		return -EIO;
 	}
-	drive =3D MINOR(inode->i_rdev) & 3;
-	if ((MINOR(inode->i_rdev) >> 2) > NUM_DISK_TYPES)
+	drive =3D minor(inode->i_rdev) & 3;
+	if ((minor(inode->i_rdev) >> 2) > NUM_DISK_TYPES)
 		return -ENXIO;
=20
 	old_dev =3D fd_device[drive];
@@ -1543,7 +1530,7 @@
=20
 static int floppy_release(struct inode *inode, struct file *filp)
 {
-	int drive =3D MINOR(inode->i_rdev) & 3;
+	int drive =3D minor(inode->i_rdev) & 3;
=20
 	if (fd_ref[drive] < 0)
 		fd_ref[drive] =3D 0;
diff -ur linux-2.5.18/drivers/acorn/block/mfmhd.c linux/drivers/acorn/blo=
ck/mfmhd.c
--- linux-2.5.18/drivers/acorn/block/mfmhd.c	2002-05-25 03:55:21.00000000=
0 +0200
+++ linux/drivers/acorn/block/mfmhd.c	2002-05-28 19:46:42.000000000 +0200=

@@ -756,7 +756,7 @@
 		/* No - its the end of the line */
 		/* end_request's should have happened at the end of sector DMAs */
 		/* Turns Drive LEDs off - may slow it down? */
-		if (QUEUE_EMPTY)
+		if (blk_queue_empty(QUEUE))
 			issue_command(CMD_CKV, block, 2);
=20
 		Busy =3D 0;
diff -ur linux-2.5.18/drivers/block/acsi.c linux/drivers/block/acsi.c
--- linux-2.5.18/drivers/block/acsi.c	2002-05-25 03:55:26.000000000 +0200=

+++ linux/drivers/block/acsi.c	2002-05-28 19:54:16.000000000 +0200
@@ -768,7 +768,7 @@
 static void bad_rw_intr( void )
=20
 {
-	if (QUEUE_EMPTY)
+	if (blk_queue_empty(QUEUE))
 		return;
=20
 	if (++CURRENT->errors >=3D MAX_ERRORS)
@@ -842,7 +842,8 @@
=20
 	DEVICE_INTR =3D NULL;
 	printk( KERN_ERR "ACSI timeout\n" );
-	if (QUEUE_EMPTY) return;
+	if (blk_queue_empty(QUEUE))
+	    return;
 	if (++CURRENT->errors >=3D MAX_ERRORS) {
 #ifdef DEBUG
 		printk( KERN_ERR "ACSI: too many errors.\n" );
@@ -951,40 +952,20 @@
 	char 				*buffer;
 	unsigned long		pbuffer;
 	struct buffer_head	*bh;
-=09
-	if (!QUEUE_EMPTY && CURRENT->rq_status =3D=3D RQ_INACTIVE) {
-		if (!DEVICE_INTR) {
-			ENABLE_IRQ();
-			stdma_release();
-		}
-		return;
-	}
-
-	if (DEVICE_INTR)
-		return;
=20
   repeat:
 	CLEAR_TIMER();
-	/* Another check here: An interrupt or timer event could have
-	 * happened since the last check!
-	 */
-	if (!QUEUE_EMPTY && CURRENT->rq_status =3D=3D RQ_INACTIVE) {
-		if (!DEVICE_INTR) {
-			ENABLE_IRQ();
-			stdma_release();
-		}
-		return;
-	}
+
 	if (DEVICE_INTR)
 		return;
=20
-	if (QUEUE_EMPTY) {
+	if (blk_queue_empty(QUEUE)) {
 		CLEAR_INTR;
 		ENABLE_IRQ();
 		stdma_release();
 		return;
 	}
-=09
+
 	if (MAJOR(CURRENT->rq_dev) !=3D MAJOR_NR)
 		panic(DEVICE_NAME ": request list destroyed");
 	if (CURRENT->bh) {
diff -ur linux-2.5.18/drivers/block/amiflop.c linux/drivers/block/amiflop=
=2Ec
--- linux-2.5.18/drivers/block/amiflop.c	2002-05-25 03:55:26.000000000 +0=
200
+++ linux/drivers/block/amiflop.c	2002-05-28 20:13:24.000000000 +0200
@@ -209,17 +209,6 @@
 static kdev_t fd_device[4] =3D { NODEV, NODEV, NODEV, NODEV };
=20
 /*
- * Current device number. Taken either from the block header or from the=

- * format request descriptor.
- */
-#define CURRENT_DEVICE (CURRENT->rq_dev)
-
-/* Current error count. */
-#define CURRENT_ERRORS (CURRENT->errors)
-
-
-
-/*
  * Here come the actual hardware access and helper functions.
  * They are not reentrant and single threaded because all drives
  * share the same hardware and the same trackbuffer.
@@ -1383,12 +1372,8 @@
 	char *data;
 	unsigned long flags;
=20
-	if (!QUEUE_EMPTY && CURRENT->rq_status =3D=3D RQ_INACTIVE){
-		return;
-	}
-
  repeat:
-	if (QUEUE_EMPTY) {
+	if (blk_queue_empty(QUEUE)) {
 		/* Nothing left to do */
 		return;
 	}
@@ -1396,7 +1381,7 @@
 	if (major(CURRENT->rq_dev) !=3D MAJOR_NR)
 		panic(DEVICE_NAME ": request list destroyed");
=20
-	device =3D minor(CURRENT_DEVICE);
+	device =3D minor(CURRENT->rq_dev);
 	if (device < 8) {
 		/* manual selection */
 		drive =3D device & 3;
diff -ur linux-2.5.18/drivers/block/ataflop.c linux/drivers/block/ataflop=
=2Ec
--- linux-2.5.18/drivers/block/ataflop.c	2002-05-25 03:55:20.000000000 +0=
200
+++ linux/drivers/block/ataflop.c	2002-05-28 20:10:29.000000000 +0200
@@ -625,8 +625,10 @@
 		wake_up( &format_wait );
 		return;
 	}
-	=09
-	if (QUEUE_EMPTY) return;
+
+	if (blk_queue_empty(QUEUE))
+		return;
+
 	CURRENT->errors++;
 	if (CURRENT->errors >=3D MAX_ERRORS) {
 		printk(KERN_ERR "fd%d: too many errors.\n", SelectedDrive );
@@ -1335,16 +1337,6 @@
 static int fd_ref[4] =3D { 0,0,0,0 };
 static int fd_device[4] =3D { 0,0,0,0 };
=20
-/*
- * Current device number. Taken either from the block header or from the=

- * format request descriptor.
- */
-#define CURRENT_DEVICE (CURRENT->rq_dev)
-
-/* Current error count. */
-#define CURRENT_ERRORS (CURRENT->errors)
-
-
 /* dummy for blk.h */
 static void floppy_off( unsigned int nr) {}
=20
@@ -1437,7 +1429,7 @@
 	ReqData =3D ReqBuffer + 512 * ReqCnt;
=20
 	if (UseTrackbuffer)
-		read_track =3D (ReqCmd =3D=3D READ && CURRENT_ERRORS =3D=3D 0);
+		read_track =3D (ReqCmd =3D=3D READ && CURRENT->errors =3D=3D 0);
 	else
 		read_track =3D 0;
=20
@@ -1451,18 +1443,14 @@
 	int device, drive, type;
  =20
 	DPRINT(("redo_fd_request: CURRENT=3D%08lx CURRENT->dev=3D%04x CURRENT->=
sector=3D%ld\n",
-		(unsigned long)CURRENT, !QUEUE_EMPTY ? CURRENT->rq_dev : 0,
-		!QUEUE_EMPTY ? CURRENT->sector : 0 ));
+		(unsigned long)CURRENT, !blk_queue_empty(QUEUE) ? CURRENT->rq_dev : 0,=

+		!blk_queue_empty(QUEUE) ? CURRENT->sector : 0 ));
=20
 	IsFormatting =3D 0;
=20
-	if (!QUEUE_EMPTY && CURRENT->rq_status =3D=3D RQ_INACTIVE){
-		return;
-	}
-
 repeat:
-   =20
-	if (QUEUE_EMPTY)
+
+	if (blk_queue_empty(QUEUE))
 		goto the_end;
=20
 	if (major(CURRENT->rq_dev) !=3D MAJOR_NR)
@@ -1471,7 +1459,7 @@
 	if (CURRENT->bh && !buffer_locked(CURRENT->bh))
 		panic(DEVICE_NAME ": block not locked");
=20
-	device =3D minor(CURRENT_DEVICE);
+	device =3D minor(CURRENT->rq_dev);
 	drive =3D device & 3;
 	type =3D device >> 2;
 =09
diff -ur linux-2.5.18/drivers/block/floppy.c linux/drivers/block/floppy.c=

--- linux-2.5.18/drivers/block/floppy.c	2002-05-25 03:55:20.000000000 +02=
00
+++ linux/drivers/block/floppy.c	2002-05-28 19:53:03.000000000 +0200
@@ -2918,14 +2918,8 @@
 	if (current_drive < N_DRIVE)
 		floppy_off(current_drive);
=20
-	if (!QUEUE_EMPTY && CURRENT->rq_status =3D=3D RQ_INACTIVE){
-		CLEAR_INTR;
-		unlock_fdc();
-		return;
-	}
-
-	while(1){
-		if (QUEUE_EMPTY) {
+	for (;;) {
+		if (blk_queue_empty(QUEUE)) {
 			CLEAR_INTR;
 			unlock_fdc();
 			return;
diff -ur linux-2.5.18/drivers/block/nbd.c linux/drivers/block/nbd.c
--- linux-2.5.18/drivers/block/nbd.c	2002-05-25 03:55:21.000000000 +0200
+++ linux/drivers/block/nbd.c	2002-05-28 19:38:03.000000000 +0200
@@ -323,7 +323,7 @@
 	int dev =3D 0;
 	struct nbd_device *lo;
=20
-	while (!QUEUE_EMPTY) {
+	while (!blk_queue_empty(QUEUE)) {
 		req =3D CURRENT;
 #ifdef PARANOIA
 		if (!req)
diff -ur linux-2.5.18/drivers/block/paride/pd.c linux/drivers/block/parid=
e/pd.c
--- linux-2.5.18/drivers/block/paride/pd.c	2002-05-25 03:55:22.000000000 =
+0200
+++ linux/drivers/block/paride/pd.c	2002-05-28 19:52:15.000000000 +0200
@@ -877,10 +877,9 @@
 =09
 /* paranoia */
=20
-	if (QUEUE_EMPTY ||
+	if (blk_queue_empty(QUEUE) ||
 	    (rq_data_dir(CURRENT) !=3D pd_cmd) ||
 	    (minor(CURRENT->rq_dev) !=3D pd_dev) ||
-	    (CURRENT->rq_status =3D=3D RQ_INACTIVE) ||
 	    (CURRENT->sector !=3D pd_block))=20
 		printk("%s: OUCH: request list changed unexpectedly\n",
 			PD.name);
diff -ur linux-2.5.18/drivers/block/paride/pf.c linux/drivers/block/parid=
e/pf.c
--- linux-2.5.18/drivers/block/paride/pf.c	2002-05-25 03:55:19.000000000 =
+0200
+++ linux/drivers/block/paride/pf.c	2002-05-28 19:52:11.000000000 +0200
@@ -881,10 +881,9 @@
 =09
 /* paranoia */
=20
-	if (QUEUE_EMPTY ||
+	if (blk_queue_empty(QUEUE) ||
 	    (rq_data_dir(CURRENT) !=3D pf_cmd) ||
 	    (DEVICE_NR(CURRENT->rq_dev) !=3D pf_unit) ||
-	    (CURRENT->rq_status =3D=3D RQ_INACTIVE) ||
 	    (CURRENT->sector !=3D pf_block))=20
 		printk("%s: OUCH: request list changed unexpectedly\n",
 			PF.name);
diff -ur linux-2.5.18/drivers/block/ps2esdi.c linux/drivers/block/ps2esdi=
=2Ec
--- linux-2.5.18/drivers/block/ps2esdi.c	2002-05-25 03:55:16.000000000 +0=
200
+++ linux/drivers/block/ps2esdi.c	2002-05-28 20:09:30.000000000 +0200
@@ -466,7 +466,7 @@
 #if 0
 	printk("%s:got request. device : %d minor : %d command : %d  sector : %=
ld count : %ld, buffer: %p\n",
 	       DEVICE_NAME,
-	       CURRENT_DEV, minor(CURRENT->rq_dev),
+	       DEVICE_NR(CURRENT->rq_dev), minor(CURRENT->rq_dev),
 	       CURRENT->cmd, CURRENT->sector,
 	       CURRENT->current_nr_sectors, CURRENT->buffer);
 #endif
@@ -482,14 +482,14 @@
 		printk("%s: DMA above 16MB not supported\n", DEVICE_NAME);
 		end_request(FAIL);
 	}			/* check for above 16Mb dmas */
-	else if ((CURRENT_DEV < ps2esdi_drives) &&
+	else if ((DEVICE_NR(CURRENT->rq_dev) < ps2esdi_drives) &&
 	    (CURRENT->sector + CURRENT->current_nr_sectors <=3D
 	     ps2esdi[minor(CURRENT->rq_dev)].nr_sects) &&
 	    	CURRENT->flags & REQ_CMD) {
 #if 0
 		printk("%s:got request. device : %d minor : %d command : %d  sector : =
%ld count : %ld\n",
 		       DEVICE_NAME,
-		       CURRENT_DEV, minor(CURRENT->rq_dev),
+		       DEVICE_NR(CURRENT->rq_dev), minor(CURRENT->rq_dev),
 		       CURRENT->cmd, CURRENT->sector,
 		       CURRENT->current_nr_sectors);
 #endif
@@ -499,10 +499,10 @@
=20
 		switch (rq_data_dir(CURRENT)) {
 		case READ:
-			ps2esdi_readwrite(READ, CURRENT_DEV, block, count);
+			ps2esdi_readwrite(READ, DEVICE_NR(CURRENT->rq_dev), block, count);
 			break;
 		case WRITE:
-			ps2esdi_readwrite(WRITE, CURRENT_DEV, block, count);
+			ps2esdi_readwrite(WRITE, DEVICE_NR(CURRENT->rq_dev), block, count);
 			break;
 		default:
 			printk("%s: Unknown command\n", DEVICE_NAME);
diff -ur linux-2.5.18/drivers/block/swim3.c linux/drivers/block/swim3.c
--- linux-2.5.18/drivers/block/swim3.c	2002-05-25 03:55:24.000000000 +020=
0
+++ linux/drivers/block/swim3.c	2002-05-28 19:38:44.000000000 +0200
@@ -313,7 +313,7 @@
 		wake_up(&fs->wait);
 		return;
 	}
-	while (!QUEUE_EMPTY && fs->state =3D=3D idle) {
+	while (!blk_queue_empty(QUEUE) && fs->state =3D=3D idle) {
 		if (major(CURRENT->rq_dev) !=3D MAJOR_NR)
 			panic(DEVICE_NAME ": request list destroyed");
 //		if (CURRENT->bh && !buffer_locked(CURRENT->bh))
diff -ur linux-2.5.18/drivers/block/swim_iop.c linux/drivers/block/swim_i=
op.c
--- linux-2.5.18/drivers/block/swim_iop.c	2002-05-25 03:55:17.000000000 +=
0200
+++ linux/drivers/block/swim_iop.c	2002-05-28 19:42:12.000000000 +0200
@@ -552,7 +552,7 @@
 		wake_up(&fs->wait);
 		return;
 	}
-	while (!QUEUE_EMPTY && fs->state =3D=3D idle) {
+	while (!blk_queue_empty(QUEUE) && fs->state =3D=3D idle) {
 		if (MAJOR(CURRENT->rq_dev) !=3D MAJOR_NR)
 			panic(DEVICE_NAME ": request list destroyed");
 		if (CURRENT->bh && !buffer_locked(CURRENT->bh))
diff -ur linux-2.5.18/drivers/block/xd.c linux/drivers/block/xd.c
--- linux-2.5.18/drivers/block/xd.c	2002-05-25 03:55:22.000000000 +0200
+++ linux/drivers/block/xd.c	2002-05-28 20:11:32.000000000 +0200
@@ -286,7 +286,7 @@
 			return;
 		}
=20
-		if (CURRENT_DEV < xd_drives
+		if (DEVICE_NR(CURRENT->rq_dev) < xd_drives
 		    && (CURRENT->flags & REQ_CMD)
 		    && CURRENT->sector + CURRENT->nr_sectors
 		         <=3D xd_struct[minor(CURRENT->rq_dev)].nr_sects) {
@@ -297,7 +297,8 @@
 				case READ:
 				case WRITE:
 					for (retry =3D 0; (retry < XD_RETRIES) && !code; retry++)
-						code =3D xd_readwrite(rq_data_dir(CURRENT),CURRENT_DEV,CURRENT->bu=
ffer,block,count);
+						code =3D xd_readwrite(rq_data_dir(CURRENT),DEVICE_NR(CURRENT->rq_d=
ev),
+							CURRENT->buffer,block,count);
 					break;
 				default:
 					printk("do_xd_request: unknown request\n");
diff -ur linux-2.5.18/drivers/cdrom/aztcd.c linux/drivers/cdrom/aztcd.c
--- linux-2.5.18/drivers/cdrom/aztcd.c	2002-05-25 03:55:30.000000000 +020=
0
+++ linux/drivers/cdrom/aztcd.c	2002-05-28 19:34:53.000000000 +0200
@@ -226,9 +226,13 @@
 #define AZT_DEBUG_MULTISESSION
 #endif
=20
-#define CURRENT_VALID \
-  (!QUEUE_EMPTY && major(CURRENT -> rq_dev) =3D=3D MAJOR_NR && CURRENT -=
> cmd =3D=3D READ \
-   && CURRENT -> sector !=3D -1)
+static int current_valid(void)
+{
+        return !blk_queue_empty(QUEUE) &&
+	        major(CURRENT->rq_dev) =3D=3D MAJOR_NR &&
+		CURRENT->cmd =3D=3D READ &&
+		CURRENT->sector !=3D -1;
+}
=20
 #define AFL_STATUSorDATA (AFL_STATUS | AFL_DATA)
 #define AZT_BUF_SIZ 16
@@ -1554,34 +1558,33 @@
 #ifdef AZT_TEST
 	printk("aztcd: executing azt_transfer Time:%li\n", jiffies);
 #endif
-	if (CURRENT_VALID) {
-		while (CURRENT->nr_sectors) {
-			int bn =3D CURRENT->sector / 4;
-			int i;
-			for (i =3D 0; i < AZT_BUF_SIZ && azt_buf_bn[i] !=3D bn;
-			     ++i);
-			if (i < AZT_BUF_SIZ) {
-				int offs =3D
-				    (i * 4 + (CURRENT->sector & 3)) * 512;
-				int nr_sectors =3D 4 - (CURRENT->sector & 3);
-				if (azt_buf_out !=3D i) {
-					azt_buf_out =3D i;
-					if (azt_buf_bn[i] !=3D bn) {
-						azt_buf_out =3D -1;
-						continue;
-					}
-				}
-				if (nr_sectors > CURRENT->nr_sectors)
-					nr_sectors =3D CURRENT->nr_sectors;
-				memcpy(CURRENT->buffer, azt_buf + offs,
-				       nr_sectors * 512);
-				CURRENT->nr_sectors -=3D nr_sectors;
-				CURRENT->sector +=3D nr_sectors;
-				CURRENT->buffer +=3D nr_sectors * 512;
-			} else {
-				azt_buf_out =3D -1;
-				break;
-			}
+	if (!current_valid())
+	        return;
+
+	while (CURRENT->nr_sectors) {
+		int bn =3D CURRENT->sector / 4;
+		int i;
+		for (i =3D 0; i < AZT_BUF_SIZ && azt_buf_bn[i] !=3D bn; ++i);
+		if (i < AZT_BUF_SIZ) {
+			int offs =3D (i * 4 + (CURRENT->sector & 3)) * 512;
+			int nr_sectors =3D 4 - (CURRENT->sector & 3);
+			if (azt_buf_out !=3D i) {
+				azt_buf_out =3D i;
+				if (azt_buf_bn[i] !=3D bn) {
+					azt_buf_out =3D -1;
+					continue;
+				}
+			}
+			if (nr_sectors > CURRENT->nr_sectors)
+			    nr_sectors =3D CURRENT->nr_sectors;
+			memcpy(CURRENT->buffer, azt_buf + offs,
+				nr_sectors * 512);
+			CURRENT->nr_sectors -=3D nr_sectors;
+			CURRENT->sector +=3D nr_sectors;
+			CURRENT->buffer +=3D nr_sectors * 512;
+		} else {
+			azt_buf_out =3D -1;
+			break;
 		}
 	}
 }
@@ -1598,7 +1601,7 @@
 		return;
 	}
 	azt_transfer_is_active =3D 1;
-	while (CURRENT_VALID) {
+	while (current_valid()) {
 		azt_transfer();
 		if (CURRENT->nr_sectors =3D=3D 0) {
 			end_request(1);
@@ -1607,7 +1610,7 @@
 			if (azt_state =3D=3D AZT_S_IDLE) {
 				if ((!aztTocUpToDate) || aztDiskChanged) {
 					if (aztUpdateToc() < 0) {
-						while (CURRENT_VALID)
+						while (current_valid())
 							end_request(0);
 						break;
 					}
@@ -1991,7 +1994,7 @@
 				AztTries =3D 0;
 				loop_ctl =3D 0;
 			}
-			if (CURRENT_VALID)
+			if (current_valid())
 				end_request(0);
 			AztTries =3D 5;
 		}
@@ -2065,7 +2068,7 @@
 					break;
 				}
 				azt_state =3D AZT_S_IDLE;
-				while (CURRENT_VALID)
+				while (current_valid())
 					end_request(0);
 				return;
 			}
@@ -2120,12 +2123,12 @@
 					break;
 				}
 				azt_state =3D AZT_S_IDLE;
-				while (CURRENT_VALID)
+				while (current_valid())
 					end_request(0);
 				return;
 			}
=20
-			if (CURRENT_VALID) {
+			if (current_valid()) {
 				struct azt_Play_msf msf;
 				int i;
 				azt_next_bn =3D CURRENT->sector / 4;
@@ -2218,7 +2221,7 @@
 						AztTries =3D 0;
 						break;
 					}
-					if (CURRENT_VALID)
+					if (current_valid())
 						end_request(0);
 					AztTries =3D 5;
 				}
@@ -2246,8 +2249,7 @@
 				}
 #endif
 				AztTries =3D 5;
-				if (!CURRENT_VALID
-				    && azt_buf_in =3D=3D azt_buf_out) {
+				if (!current_valid() && azt_buf_in =3D=3D azt_buf_out) {
 					azt_state =3D AZT_S_STOP;
 					loop_ctl =3D 1;
 					break;
@@ -2319,7 +2321,7 @@
 					}
 				}
 				if (!azt_transfer_is_active) {
-					while (CURRENT_VALID) {
+					while (current_valid()) {
 						azt_transfer();
 						if (CURRENT->nr_sectors =3D=3D
 						    0)
@@ -2329,7 +2331,7 @@
 					}
 				}
=20
-				if (CURRENT_VALID
+				if (current_valid()
 				    && (CURRENT->sector / 4 < azt_next_bn
 					|| CURRENT->sector / 4 >
 					azt_next_bn + AZT_BUF_SIZ)) {
@@ -2403,10 +2405,10 @@
=20
 #ifdef AZT_TEST3
 			printk("CURRENT_VALID %d azt_mode %d\n",
-			       CURRENT_VALID, azt_mode);
+			       current_valid(), azt_mode);
 #endif
=20
-			if (CURRENT_VALID) {
+			if (current_valid()) {
 				if (st !=3D -1) {
 					if (azt_mode =3D=3D 1) {
 						azt_state =3D AZT_S_READ;
diff -ur linux-2.5.18/drivers/cdrom/cdu31a.c linux/drivers/cdrom/cdu31a.c=

--- linux-2.5.18/drivers/cdrom/cdu31a.c	2002-05-25 03:55:20.000000000 +02=
00
+++ linux/drivers/cdrom/cdu31a.c	2002-05-28 19:57:22.000000000 +0200
@@ -1563,11 +1563,6 @@
 		interruptible_sleep_on(&sony_wait);
 		if (signal_pending(current)) {
 			restore_flags(flags);
-			if (!QUEUE_EMPTY
-			    && CURRENT->rq_status !=3D RQ_INACTIVE) {
-				end_request(0);
-			}
-			restore_flags(flags);
 #if DEBUG
 			printk("Leaving do_cdu31a_request at %d\n",
 			       __LINE__);
diff -ur linux-2.5.18/drivers/cdrom/gscd.c linux/drivers/cdrom/gscd.c
--- linux-2.5.18/drivers/cdrom/gscd.c	2002-05-25 03:55:17.000000000 +0200=

+++ linux/drivers/cdrom/gscd.c	2002-05-28 20:00:25.000000000 +0200
@@ -288,7 +288,7 @@
 	block =3D CURRENT->sector;
 	nsect =3D CURRENT->nr_sectors;
=20
-	if (QUEUE_EMPTY || CURRENT->sector =3D=3D -1)
+	if (CURRENT->sector =3D=3D -1)
 		goto out;
=20
 	if (CURRENT->cmd !=3D READ) {
diff -ur linux-2.5.18/drivers/cdrom/mcd.c linux/drivers/cdrom/mcd.c
--- linux-2.5.18/drivers/cdrom/mcd.c	2002-05-25 03:55:18.000000000 +0200
+++ linux/drivers/cdrom/mcd.c	2002-05-28 19:24:20.000000000 +0200
@@ -119,9 +119,13 @@
 #define QUICK_LOOP_DELAY udelay(45)	/* use udelay */
 #define QUICK_LOOP_COUNT 20
=20
-#define CURRENT_VALID \
-(!QUEUE_EMPTY && major(CURRENT -> rq_dev) =3D=3D MAJOR_NR && CURRENT -> =
cmd =3D=3D READ \
-&& CURRENT -> sector !=3D -1)
+static int current_valid(void)
+{
+        return !blk_queue_empty(QUEUE) &&
+	        major(CURRENT->rq_dev) =3D=3D MAJOR_NR &&
+		CURRENT->cmd =3D=3D READ &&
+		CURRENT->sector !=3D -1;
+}
=20
 #define MFL_STATUSorDATA (MFL_STATUS | MFL_DATA)
 #define MCD_BUF_SIZ 16
@@ -556,33 +560,33 @@
=20
 static void mcd_transfer(void)
 {
-	if (CURRENT_VALID) {
-		while (CURRENT->nr_sectors) {
-			int bn =3D CURRENT->sector / 4;
-			int i;
-			for (i =3D 0; i < MCD_BUF_SIZ && mcd_buf_bn[i] !=3D bn;
-			     ++i);
-			if (i < MCD_BUF_SIZ) {
-				int offs =3D(i * 4 + (CURRENT->sector & 3)) * 512;
-				int nr_sectors =3D 4 - (CURRENT->sector & 3);
-				if (mcd_buf_out !=3D i) {
-					mcd_buf_out =3D i;
-					if (mcd_buf_bn[i] !=3D bn) {
-						mcd_buf_out =3D -1;
-						continue;
-					}
+	if (!current_valid())
+		return;
+
+	while (CURRENT->nr_sectors) {
+		int bn =3D CURRENT->sector / 4;
+		int i;
+		for (i =3D 0; i < MCD_BUF_SIZ && mcd_buf_bn[i] !=3D bn; ++i)
+			;
+		if (i < MCD_BUF_SIZ) {
+			int offs =3D(i * 4 + (CURRENT->sector & 3)) * 512;
+			int nr_sectors =3D 4 - (CURRENT->sector & 3);
+			if (mcd_buf_out !=3D i) {
+				mcd_buf_out =3D i;
+				if (mcd_buf_bn[i] !=3D bn) {
+					mcd_buf_out =3D -1;
+					continue;
 				}
-				if (nr_sectors > CURRENT->nr_sectors)
-					nr_sectors =3D CURRENT->nr_sectors;
-				memcpy(CURRENT->buffer, mcd_buf + offs,
-				       nr_sectors * 512);
-				CURRENT->nr_sectors -=3D nr_sectors;
-				CURRENT->sector +=3D nr_sectors;
-				CURRENT->buffer +=3D nr_sectors * 512;
-			} else {
-				mcd_buf_out =3D -1;
-				break;
 			}
+			if (nr_sectors > CURRENT->nr_sectors)
+				nr_sectors =3D CURRENT->nr_sectors;
+			memcpy(CURRENT->buffer, mcd_buf + offs, nr_sectors * 512);
+			CURRENT->nr_sectors -=3D nr_sectors;
+			CURRENT->sector +=3D nr_sectors;
+			CURRENT->buffer +=3D nr_sectors * 512;
+		} else {
+		        mcd_buf_out =3D -1;
+			break;
 		}
 	}
 }
@@ -614,7 +618,7 @@
 	       CURRENT->nr_sectors));
=20
 		mcd_transfer_is_active =3D 1;
-	while (CURRENT_VALID) {
+	while (current_valid()) {
 		mcd_transfer();
 		if (CURRENT->nr_sectors =3D=3D 0) {
 			end_request(1);
@@ -623,7 +627,7 @@
 			if (mcd_state =3D=3D MCD_S_IDLE) {
 				if (!tocUpToDate) {
 					if (updateToc() < 0) {
-						while (CURRENT_VALID)
+						while (current_valid())
 							end_request(0);
 						break;
 					}
@@ -688,7 +692,7 @@
 					McdTries =3D 0;
 					goto ret;
 				}
-				if (CURRENT_VALID)
+				if (current_valid())
 					end_request(0);
 				McdTries =3D MCD_RETRY_ATTEMPTS;
 			}
@@ -745,7 +749,7 @@
 				       "mcd: door open\n" :
 				       "mcd: disk removed\n");
 				mcd_state =3D MCD_S_IDLE;
-				while (CURRENT_VALID)
+				while (current_valid())
 					end_request(0);
 				goto out;
 			}
@@ -779,12 +783,12 @@
 				       "mcd: door open\n" :
 				       "mcd: disk removed\n");
 				mcd_state =3D MCD_S_IDLE;
-				while (CURRENT_VALID)
+				while (current_valid())
 					end_request(0);
 				goto out;
 			}
=20
-			if (CURRENT_VALID) {
+			if (current_valid()) {
 				struct mcd_Play_msf msf;
 				mcd_next_bn =3D CURRENT->sector / 4;
 				hsg2msf(mcd_next_bn, &msf.start);
@@ -820,7 +824,7 @@
 					McdTries =3D 0;
 					break;
 				}
-				if (CURRENT_VALID)
+				if (current_valid())
 					end_request(0);
 				McdTries =3D 5;
 			}
@@ -833,7 +837,7 @@
=20
 		default:
 			McdTries =3D 5;
-			if (!CURRENT_VALID && mcd_buf_in =3D=3D mcd_buf_out) {
+			if (!current_valid() && mcd_buf_in =3D=3D mcd_buf_out) {
 				mcd_state =3D MCD_S_STOP;
 				goto immediately;
 			}
@@ -845,7 +849,7 @@
 				mcd_buf_out =3D mcd_buf_in;
 			mcd_buf_in =3D mcd_buf_in + 1 =3D=3D MCD_BUF_SIZ ? 0 : mcd_buf_in + 1=
;
 			if (!mcd_transfer_is_active) {
-				while (CURRENT_VALID) {
+				while (current_valid()) {
 					mcd_transfer();
 					if (CURRENT->nr_sectors =3D=3D 0)
 						end_request(1);
@@ -854,7 +858,7 @@
 				}
 			}
=20
-			if (CURRENT_VALID
+			if (current_valid()
 			    && (CURRENT->sector / 4 < mcd_next_bn ||
 				CURRENT->sector / 4 > mcd_next_bn + 16)) {
 				mcd_state =3D MCD_S_STOP;
@@ -933,8 +937,9 @@
 		st =3D -1;
=20
 do_not_work_around_mitsumi_bug_93_2:
-		test3(printk("CURRENT_VALID %d mcd_mode %d\n", CURRENT_VALID, mcd_mode=
));
-		if (CURRENT_VALID) {
+		test3(printk("CURRENT_VALID %d mcd_mode %d\n", current_valid(),
+			    mcd_mode));
+		if (current_valid()) {
 			if (st !=3D -1) {
 				if (mcd_mode =3D=3D 1)
 					goto read_immediately;
diff -ur linux-2.5.18/drivers/cdrom/optcd.c linux/drivers/cdrom/optcd.c
--- linux-2.5.18/drivers/cdrom/optcd.c	2002-05-25 03:55:21.000000000 +020=
0
+++ linux/drivers/cdrom/optcd.c	2002-05-28 19:28:07.000000000 +0200
@@ -973,11 +973,13 @@
 =0C
 /* Request handling */
=20
-
-#define CURRENT_VALID \
-	(!QUEUE_EMPTY && major(CURRENT -> rq_dev) =3D=3D MAJOR_NR \
-	 && CURRENT -> cmd =3D=3D READ && CURRENT -> sector !=3D -1)
-
+static int current_valid(void)
+{
+        return !blk_queue_empty(QUEUE) &&
+	        major(CURRENT->rq_dev) =3D=3D MAJOR_NR &&
+		CURRENT->cmd =3D=3D READ &&
+		CURRENT->sector !=3D -1;
+}
=20
 /* Buffers for block size conversion. */
 #define NOBUF		-1
@@ -1006,7 +1008,7 @@
 	printk(KERN_DEBUG "optcd: executing transfer\n");
 #endif
=20
-	if (!CURRENT_VALID)
+	if (!current_valid())
 		return;
 	while (CURRENT -> nr_sectors) {
 		int bn =3D CURRENT -> sector / 4;
@@ -1092,7 +1094,7 @@
 				" Giving up\n", next_bn);
 			if (transfer_is_active)
 				loop_again =3D 0;
-			if (CURRENT_VALID)
+			if (current_valid())
 				end_request(0);
 			tries =3D 5;
 		}
@@ -1126,7 +1128,7 @@
 				break;
 			if (send_cmd(COMDRVST)) {
 				state =3D S_IDLE;
-				while (CURRENT_VALID)
+				while (current_valid())
 					end_request(0);
 				return;
 			}
@@ -1153,11 +1155,11 @@
 					? "door open"
 					: "disk removed");
 				state =3D S_IDLE;
-				while (CURRENT_VALID)
+				while (current_valid())
 					end_request(0);
 				return;
 			}
-			if (!CURRENT_VALID) {
+			if (!current_valid()) {
 				state =3D S_STOP;
 				loop_again =3D 1;
 				break;
@@ -1208,7 +1210,7 @@
 						tries =3D 0;
 						break;
 					}
-					if (CURRENT_VALID)
+					if (current_valid())
 						end_request(0);
 					tries =3D 5;
 				}
@@ -1219,7 +1221,7 @@
 				break;
 			default:	/* DTEN low */
 				tries =3D 5;
-				if (!CURRENT_VALID && buf_in =3D=3D buf_out) {
+				if (!current_valid() && buf_in =3D=3D buf_out) {
 					state =3D S_STOP;
 					loop_again =3D 1;
 					break;
@@ -1272,7 +1274,7 @@
 						N_BUFS ? 0 : buf_in + 1;
 				}
 				if (!transfer_is_active) {
-					while (CURRENT_VALID) {
+					while (current_valid()) {
 						transfer();
 						if (CURRENT -> nr_sectors =3D=3D 0)
 							end_request(1);
@@ -1281,7 +1283,7 @@
 					}
 				}
=20
-				if (CURRENT_VALID
+				if (current_valid()
 				    && (CURRENT -> sector / 4 < next_bn ||
 				    CURRENT -> sector / 4 >
 				     next_bn + N_BUFS)) {
@@ -1305,7 +1307,7 @@
 			flush_data();
 			if (send_cmd(COMDRVST)) {
 				state =3D S_IDLE;
-				while (CURRENT_VALID)
+				while (current_valid())
 					end_request(0);
 				return;
 			}
@@ -1320,7 +1322,7 @@
 				toc_uptodate =3D 0;
 				opt_invalidate_buffers();
 			}
-			if (CURRENT_VALID) {
+			if (current_valid()) {
 				if (status >=3D 0) {
 					state =3D S_READ;
 					loop_again =3D 1;
@@ -1346,7 +1348,7 @@
 		state =3D S_STOP;
 		if (exec_cmd(COMSTOP) < 0) {
 			state =3D S_IDLE;
-			while (CURRENT_VALID)
+			while (current_valid())
 				end_request(0);
 			return;
 		}
@@ -1368,7 +1370,7 @@
 	}
=20
 	transfer_is_active =3D 1;
-	while (CURRENT_VALID) {
+	while (current_valid()) {
 		transfer();	/* First try to transfer block from buffers */
 		if (CURRENT -> nr_sectors =3D=3D 0) {
 			end_request(1);
@@ -1377,7 +1379,7 @@
 			if (state =3D=3D S_IDLE) {
 				/* %% Should this block the request queue?? */
 				if (update_toc() < 0) {
-					while (CURRENT_VALID)
+					while (current_valid())
 						end_request(0);
 					break;
 				}
diff -ur linux-2.5.18/drivers/cdrom/sbpcd.c linux/drivers/cdrom/sbpcd.c
--- linux-2.5.18/drivers/cdrom/sbpcd.c	2002-05-25 03:55:20.000000000 +020=
0
+++ linux/drivers/cdrom/sbpcd.c	2002-05-28 19:25:45.000000000 +0200
@@ -4902,7 +4902,7 @@
 #ifdef DEBUG_GTL
 	xnr=3D++xx_nr;
=20
-	if(QUEUE_EMPTY)
+	if(blk_queue_empty(QUEUE))
 	{
 		printk( "do_sbpcd_request[%di](NULL), Pid:%d, Time:%li\n",
 			xnr, current->pid, jiffies);
diff -ur linux-2.5.18/drivers/cdrom/sjcd.c linux/drivers/cdrom/sjcd.c
--- linux-2.5.18/drivers/cdrom/sjcd.c	2002-05-25 03:55:28.000000000 +0200=

+++ linux/drivers/cdrom/sjcd.c	2002-05-28 19:30:08.000000000 +0200
@@ -1074,16 +1074,20 @@
  * When Linux gets variable block sizes this will probably go away.
  */
=20
-#define CURRENT_IS_VALID                                      \
-    ( !QUEUE_EMPTY && major( CURRENT->rq_dev ) =3D=3D MAJOR_NR && \
-      CURRENT->cmd =3D=3D READ && CURRENT->sector !=3D -1 )
+static int current_valid(void)
+{
+        return !blk_queue_empty(QUEUE) &&
+	        major(CURRENT->rq_dev) =3D=3D MAJOR_NR &&
+		CURRENT->cmd =3D=3D READ &&
+		CURRENT->sector !=3D -1;
+}
=20
 static void sjcd_transfer(void)
 {
 #if defined( SJCD_TRACE )
 	printk("SJCD: transfer:\n");
 #endif
-	if (CURRENT_IS_VALID) {
+	if (current_valid()) {
 		while (CURRENT->nr_sectors) {
 			int i, bn =3D CURRENT->sector / 4;
 			for (i =3D 0;
@@ -1239,7 +1243,7 @@
 					}
 				}
=20
-				if (CURRENT_IS_VALID) {
+				if (current_valid()) {
 					struct sjcd_play_msf msf;
=20
 					sjcd_next_bn =3D CURRENT->sector / 4;
@@ -1307,7 +1311,7 @@
 					    ("SJCD: read block %d failed, maybe audio disk? Giving up\n",
 					     sjcd_next_bn);
 #endif
-					if (CURRENT_IS_VALID)
+					if (current_valid())
 						end_request(0);
 #if defined( SJCD_TRACE )
 					printk
@@ -1332,7 +1336,7 @@
 				 * Otherwise cdrom hangs up. Check to see if we have something to co=
py
 				 * to.
 				 */
-				if (!CURRENT_IS_VALID
+				if (!current_valid()
 				    && sjcd_buf_in =3D=3D sjcd_buf_out) {
 #if defined( SJCD_TRACE )
 					printk
@@ -1373,7 +1377,7 @@
 					 * OK, request seems to be precessed. Continue transferring...
 					 */
 					if (!sjcd_transfer_is_active) {
-						while (CURRENT_IS_VALID) {
+						while (current_valid()) {
 							/*
 							 * Continue transferring.
 							 */
@@ -1387,7 +1391,7 @@
 								break;
 						}
 					}
-					if (CURRENT_IS_VALID &&
+					if (current_valid() &&
 					    (CURRENT->sector / 4 <
 					     sjcd_next_bn
 					     || CURRENT->sector / 4 >
@@ -1450,7 +1454,7 @@
 					sjcd_toc_uptodate =3D 0;
 					sjcd_invalidate_buffers();
 				}
-				if (CURRENT_IS_VALID) {
+				if (current_valid()) {
 					if (sjcd_status_valid)
 						sjcd_transfer_state =3D
 						    SJCD_S_READ;
@@ -1476,7 +1480,7 @@
=20
 	if (--sjcd_transfer_timeout =3D=3D 0) {
 		printk("SJCD: timeout in state %d\n", sjcd_transfer_state);
-		while (CURRENT_IS_VALID)
+		while (current_valid())
 			end_request(0);
 		sjcd_send_cmd(SCMD_STOP);
 		sjcd_transfer_state =3D SJCD_S_IDLE;
@@ -1497,7 +1501,7 @@
 	       CURRENT->sector, CURRENT->nr_sectors);
 #endif
 	sjcd_transfer_is_active =3D 1;
-	while (CURRENT_IS_VALID) {
+	while (current_valid()) {
 		sjcd_transfer();
 		if (CURRENT->nr_sectors =3D=3D 0)
 			end_request(1);
@@ -1508,7 +1512,7 @@
 					if (sjcd_update_toc() < 0) {
 						printk
 						    ("SJCD: transfer: discard\n");
-						while (CURRENT_IS_VALID)
+						while (current_valid())
 							end_request(0);
 						break;
 					}
diff -ur linux-2.5.18/drivers/ide/hd.c linux/drivers/ide/hd.c
--- linux-2.5.18/drivers/ide/hd.c	2002-05-25 03:55:20.000000000 +0200
+++ linux/drivers/ide/hd.c	2002-05-28 20:00:11.000000000 +0200
@@ -167,7 +167,7 @@
 	unsigned long flags;
 	char devc;
=20
-	devc =3D !QUEUE_EMPTY ? 'a' + DEVICE_NR(CURRENT->rq_dev) : '?';
+	devc =3D !blk_queue_empty(QUEUE) ? 'a' + DEVICE_NR(CURRENT->rq_dev) : '=
?';
 	save_flags (flags);
 	sti();
 #ifdef VERBOSE_ERRORS
@@ -196,7 +196,7 @@
 		if (hd_error & (BBD_ERR|ECC_ERR|ID_ERR|MARK_ERR)) {
 			printk(", CHS=3D%d/%d/%d", (inb(HD_HCYL)<<8) + inb(HD_LCYL),
 				inb(HD_CURRENT) & 0xf, inb(HD_SECTOR));
-			if (!QUEUE_EMPTY)
+			if (!blk_queue_empty(QUEUE))
 				printk(", sector=3D%ld", CURRENT->sector);
 		}
 		printk("\n");
@@ -373,7 +373,7 @@
 {
 	int dev;
=20
-	if (QUEUE_EMPTY)
+	if (blk_queue_empty(QUEUE))
 		return;
 	dev =3D DEVICE_NR(CURRENT->rq_dev);
 	if (++CURRENT->errors >=3D MAX_ERRORS || (hd_error & BBD_ERR)) {
@@ -436,7 +436,7 @@
 #if (HD_DELAY > 0)
 	last_req =3D read_timer();
 #endif
-	if (!QUEUE_EMPTY)
+	if (!blk_queue_empty(QUEUE))
 		hd_request();
 	return;
 }
@@ -497,8 +497,10 @@
 	unsigned int dev;
=20
 	DEVICE_INTR =3D NULL;
-	if (QUEUE_EMPTY)
+
+	if (blk_queue_empty(QUEUE))
 		return;
+
 	disable_irq(HD_IRQ);
 	sti();
 	reset =3D 1;
diff -ur linux-2.5.18/drivers/mtd/mtdblock.c linux/drivers/mtd/mtdblock.c=

--- linux-2.5.18/drivers/mtd/mtdblock.c	2002-05-25 03:55:24.000000000 +02=
00
+++ linux/drivers/mtd/mtdblock.c	2002-05-28 19:44:58.000000000 +0200
@@ -19,15 +19,6 @@
 #define DEVICE_NR(device) (device)
 #define LOCAL_END_REQUEST
 #include <linux/blk.h>
-/* for old kernels... */
-#ifndef QUEUE_EMPTY
-#define QUEUE_EMPTY  (!CURRENT)
-#endif
-#if LINUX_VERSION_CODE < 0x20300
-#define QUEUE_PLUGGED (blk_dev[MAJOR_NR].plug_tq.sync)
-#else
-#define QUEUE_PLUGGED (blk_queue_plugged(QUEUE))
-#endif
=20
 #ifdef CONFIG_DEVFS_FS
 #include <linux/devfs_fs_kernel.h>
@@ -486,7 +477,7 @@
 		add_wait_queue(&thr_wq, &wait);
 		set_current_state(TASK_INTERRUPTIBLE);
 		spin_lock_irq(QUEUE->queue_lock);
-		if (QUEUE_EMPTY || QUEUE_PLUGGED) {
+		if (blk_queue_empty(QUEUE) || blk_queue_plugged(QUEUE)) {
 			spin_unlock_irq(QUEUE->queue_lock);
 			schedule();
 			remove_wait_queue(&thr_wq, &wait);=20
diff -ur linux-2.5.18/drivers/mtd/mtdblock_ro.c linux/drivers/mtd/mtdbloc=
k_ro.c
--- linux-2.5.18/drivers/mtd/mtdblock_ro.c	2002-05-25 03:55:26.000000000 =
+0200
+++ linux/drivers/mtd/mtdblock_ro.c	2002-05-28 20:10:35.000000000 +0200
@@ -132,7 +132,7 @@
=20
       mtd =3D __get_mtd_device(NULL, minor(current_request->rq_dev));
       if (!mtd) {
-	      printk("MTD device %d doesn't appear to exist any more\n", CURREN=
T_DEV);
+	      printk("MTD device %d doesn't appear to exist any more\n", DEVICE=
_NR(CURRENT->rq_dev));
 	      mtdblock_end_request(current_request, 0);
       }
=20
diff -ur linux-2.5.18/include/linux/blk.h linux/include/linux/blk.h
--- linux-2.5.18/include/linux/blk.h	2002-05-25 03:55:22.000000000 +0200
+++ linux/include/linux/blk.h	2002-05-28 20:19:50.000000000 +0200
@@ -293,20 +293,15 @@
 #if !defined(IDE_DRIVER)
=20
 #ifndef CURRENT
-#define CURRENT elv_next_request(&blk_dev[MAJOR_NR].request_queue)
+# define CURRENT elv_next_request(&blk_dev[MAJOR_NR].request_queue)
 #endif
 #ifndef QUEUE
-#define QUEUE (&blk_dev[MAJOR_NR].request_queue)
-#endif
-#ifndef QUEUE_EMPTY
-#define QUEUE_EMPTY blk_queue_empty(QUEUE)
+# define QUEUE (&blk_dev[MAJOR_NR].request_queue)
 #endif
 #ifndef DEVICE_NAME
-#define DEVICE_NAME "unknown"
+# define DEVICE_NAME "unknown"
 #endif
=20
-#define CURRENT_DEV DEVICE_NR(CURRENT->rq_dev)
-
 #ifdef DEVICE_INTR
 static void (*DEVICE_INTR)(void) =3D NULL;
 #endif

--------------050004060400080208060908--

