Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288579AbSADKLc>; Fri, 4 Jan 2002 05:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288578AbSADKLY>; Fri, 4 Jan 2002 05:11:24 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:50649 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S288576AbSADKLN>; Fri, 4 Jan 2002 05:11:13 -0500
Date: Fri, 4 Jan 2002 02:11:07 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: Werner.Zimmermann@fht-esslingen.de, minyard@wf-rch.cirr.com,
        david@tm.tno.nl, raupach@nwfs1.rz.fh-hannover.de, heiko@lotte.sax.de,
        emoenke@gwdg.de, model@cecmow.enet.dec.com, vadim@rbrf.ru,
        linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: PATCH: Some linux-2.5.2-pre7/drivers/cdrom kdev_t fixes
Message-ID: <20020104021107.A19166@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Here are kdev_t compilation fixes for eight drivers
for non-IDE non-SCSI CDROM drives in linux-2.5.2-pre7/drivers/cdrom/.  
I have not done all of the drivers yet.

	I doubt that many people use these drives anymore, but I am
emailing this patch to the relevant authors of the drivers anyhow.

	I have not tested these patches.  I only know that they
compile.  One thing that I am a bit unsure about was my deleting
references to hardsect_size of optcd.c and sjcd.c.  I would
appreciate someone checking that.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cdrom.diffs"

diff -u linux-2.5.2-pre7/drivers/cdrom/aztcd.c linux/drivers/cdrom/aztcd.c
--- linux-2.5.2-pre7/drivers/cdrom/aztcd.c	Thu Oct 25 13:58:35 2001
+++ linux/drivers/cdrom/aztcd.c	Fri Jan  4 01:57:39 2002
@@ -229,7 +229,7 @@
 #endif
 
 #define CURRENT_VALID \
-  (!QUEUE_EMPTY && MAJOR(CURRENT -> rq_dev) == MAJOR_NR && CURRENT -> cmd == READ \
+  (!QUEUE_EMPTY && major(CURRENT -> rq_dev) == MAJOR_NR && CURRENT -> cmd == READ \
    && CURRENT -> sector != -1)
 
 #define AFL_STATUSorDATA (AFL_STATUS | AFL_DATA)
@@ -309,6 +309,8 @@
 static unsigned long aztTimeOutCount;
 static int aztCmd = 0;
 
+static spinlock_t aztSpin = SPIN_LOCK_UNLOCKED;
+
 /*###########################################################################
    Function Prototypes
   ###########################################################################
@@ -1599,10 +1601,6 @@
 	}
 	azt_transfer_is_active = 1;
 	while (CURRENT_VALID) {
-		if (CURRENT->bh) {
-			if (!buffer_locked(CURRENT->bh))
-				panic(DEVICE_NAME ": block not locked");
-		}
 		azt_transfer();
 		if (CURRENT->nr_sectors == 0) {
 			end_request(1);
@@ -1927,10 +1925,10 @@
 		       MAJOR_NR);
 		return -EIO;
 	}
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
+	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST, &aztSpin);
 	blksize_size[MAJOR_NR] = aztcd_blocksizes;
 	read_ahead[MAJOR_NR] = 4;
-	register_disk(NULL, MKDEV(MAJOR_NR, 0), 1, &azt_fops, 0);
+	register_disk(NULL, mk_kdev(MAJOR_NR, 0), 1, &azt_fops, 0);
 
 	if ((azt_port == 0x1f0) || (azt_port == 0x170))
 		request_region(azt_port, 8, "aztcd");	/*IDE-interface */
diff -u linux-2.5.2-pre7/drivers/cdrom/cdu31a.c linux/drivers/cdrom/cdu31a.c
--- linux-2.5.2-pre7/drivers/cdrom/cdu31a.c	Thu Jan  3 19:52:01 2002
+++ linux/drivers/cdrom/cdu31a.c	Fri Jan  4 01:57:39 2002
@@ -1587,7 +1587,7 @@
 	/*
 	 * jens: driver has lots of races
 	 */
-	spin_unlock_irq(&q->queue_lock);
+	spin_unlock_irq(q->queue_lock);
 
 	/* Make sure the timer is cancelled. */
 	del_timer(&cdu31a_abort_timer);
@@ -1717,7 +1717,7 @@
 		}
 	}
       end_do_cdu31a_request:
-	spin_lock_irq(&q->queue_lock);
+	spin_lock_irq(q->queue_lock);
 #if 0
 	/* After finished, cancel any pending operations. */
 	abort_read();
@@ -3450,7 +3450,7 @@
 		init_timer(&cdu31a_abort_timer);
 		cdu31a_abort_timer.function = handle_abort_timeout;
 
-		scd_info.dev = MKDEV(MAJOR_NR, 0);
+		scd_info.dev = mk_kdev(MAJOR_NR, 0);
 		scd_info.mask = deficiency;
 		strncpy(scd_info.name, "cdu31a", sizeof(scd_info.name));
 
diff -u linux-2.5.2-pre7/drivers/cdrom/cm206.c linux/drivers/cdrom/cm206.c
--- linux-2.5.2-pre7/drivers/cdrom/cm206.c	Tue Nov 27 09:23:27 2001
+++ linux/drivers/cdrom/cm206.c	Fri Jan  4 01:57:39 2002
@@ -302,6 +302,7 @@
 #define PLAY_TO cd->toc[0]	/* toc[0] records end-time in play */
 
 static struct cm206_struct *cd;	/* the main memory structure */
+static spinlock_t cm206_lock = SPIN_LOCK_UNLOCKED;
 
 /* First, we define some polling functions. These are actually
    only being used in the initialization. */
@@ -866,7 +867,7 @@
 			end_request(0);
 			continue;
 		}
-		spin_unlock_irq(&q->queue_lock);
+		spin_unlock_irq(q->queue_lock);
 		error = 0;
 		for (i = 0; i < CURRENT->nr_sectors; i++) {
 			int e1, e2;
@@ -893,7 +894,7 @@
 				debug(("cm206_request: %d %d\n", e1, e2));
 			}
 		}
-		spin_lock_irq(&q->queue_lock);
+		spin_lock_irq(q->queue_lock);
 		end_request(!error);
 	}
 }
@@ -1491,7 +1492,7 @@
 		cleanup(3);
 		return -EIO;
 	}
-	cm206_info.dev = MKDEV(MAJOR_NR, 0);
+	cm206_info.dev = mk_kdev(MAJOR_NR, 0);
 	if (register_cdrom(&cm206_info) != 0) {
 		printk(KERN_INFO "Cannot register for cdrom %d!\n",
 		       MAJOR_NR);
@@ -1499,7 +1500,8 @@
 		return -EIO;
 	}
 	devfs_plain_cdrom(&cm206_info, &cm206_bdops);
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
+	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST,
+		       &cm206_lock);
 	blksize_size[MAJOR_NR] = cm206_blocksizes;
 	read_ahead[MAJOR_NR] = 16;	/* reads ahead what? */
 	init_bh(CM206_BH, cm206_bh);
diff -u linux-2.5.2-pre7/drivers/cdrom/gscd.c linux/drivers/cdrom/gscd.c
--- linux-2.5.2-pre7/drivers/cdrom/gscd.c	Thu Oct 25 13:58:35 2001
+++ linux/drivers/cdrom/gscd.c	Fri Jan  4 01:57:39 2002
@@ -162,6 +162,7 @@
 static int AudioEnd_f;
 
 static struct timer_list gscd_timer;
+static spinlock_t gscd_lock = SPIN_LOCK_UNLOCKED;
 
 static struct block_device_operations gscd_fops = {
 	owner:THIS_MODULE,
@@ -180,7 +181,7 @@
 	int target;
 
 
-	target = MINOR(full_dev);
+	target = minor(full_dev);
 
 	if (target > 0) {
 		printk
@@ -283,7 +284,7 @@
 	if (QUEUE_EMPTY || CURRENT->rq_status == RQ_INACTIVE)
 		goto out;
 	INIT_REQUEST;
-	dev = MINOR(CURRENT->rq_dev);
+	dev = minor(CURRENT->rq_dev);
 	block = CURRENT->sector;
 	nsect = CURRENT->nr_sectors;
 
@@ -296,7 +297,7 @@
 		goto repeat;
 	}
 
-	if (MINOR(CURRENT->rq_dev) != 0) {
+	if (dev != 0) {
 		printk("GSCD: this version supports only one device\n");
 		end_request(0);
 		goto repeat;
@@ -1019,7 +1020,7 @@
 	devfs_register(NULL, "gscd", DEVFS_FL_DEFAULT, MAJOR_NR, 0,
 		       S_IFBLK | S_IRUGO | S_IWUGO, &gscd_fops, NULL);
 
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
+	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST, &gscd_lock);
 	blksize_size[MAJOR_NR] = gscd_blocksizes;
 	read_ahead[MAJOR_NR] = 4;
 
@@ -1027,7 +1028,7 @@
 	gscdPresent = 1;
 
 	request_region(gscd_port, 4, "gscd");
-	register_disk(NULL, MKDEV(MAJOR_NR, 0), 1, &gscd_fops, 0);
+	register_disk(NULL, mk_kdev(MAJOR_NR, 0), 1, &gscd_fops, 0);
 
 	printk(KERN_INFO "GSCD: GoldStar CD-ROM Drive found.\n");
 	return 0;
diff -u linux-2.5.2-pre7/drivers/cdrom/mcd.c linux/drivers/cdrom/mcd.c
--- linux-2.5.2-pre7/drivers/cdrom/mcd.c	Thu Oct 25 13:58:35 2001
+++ linux/drivers/cdrom/mcd.c	Fri Jan  4 01:57:39 2002
@@ -123,7 +123,7 @@
 #define QUICK_LOOP_COUNT 20
 
 #define CURRENT_VALID \
-(!QUEUE_EMPTY && MAJOR(CURRENT -> rq_dev) == MAJOR_NR && CURRENT -> cmd == READ \
+(!QUEUE_EMPTY && major(CURRENT -> rq_dev) == MAJOR_NR && CURRENT -> cmd == READ \
 && CURRENT -> sector != -1)
 
 #define MFL_STATUSorDATA (MFL_STATUS | MFL_DATA)
@@ -185,6 +185,7 @@
 static void mcd_release(struct cdrom_device_info *cdi);
 static int mcd_media_changed(struct cdrom_device_info *cdi, int disc_nr);
 static int mcd_tray_move(struct cdrom_device_info *cdi, int position);
+static spinlock_t mcd_spinlock = SPIN_LOCK_UNLOCKED;
 int mcd_audio_ioctl(struct cdrom_device_info *cdi, unsigned int cmd,
 		    void *arg);
 int mcd_drive_status(struct cdrom_device_info *cdi, int slot_nr);
@@ -617,10 +618,6 @@
 
 		mcd_transfer_is_active = 1;
 	while (CURRENT_VALID) {
-		if (CURRENT->bh) {
-			if (!buffer_locked(CURRENT->bh))
-				panic(DEVICE_NAME ": block not locked");
-		}
 		mcd_transfer();
 		if (CURRENT->nr_sectors == 0) {
 			end_request(1);
@@ -1076,7 +1073,8 @@
 	}
 
 	blksize_size[MAJOR_NR] = mcd_blocksizes;
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
+	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST,
+		       &mcd_spinlock);
 	read_ahead[MAJOR_NR] = 4;
 
 	/* check for card */
@@ -1150,7 +1148,7 @@
 	mcd_invalidate_buffers();
 	mcdPresent = 1;
 
-	mcd_info.dev = MKDEV(MAJOR_NR, 0);
+	mcd_info.dev = mk_kdev(MAJOR_NR, 0);
 
 	if (register_cdrom(&mcd_info) != 0) {
 		printk(KERN_ERR "mcd: Unable to register Mitsumi CD-ROM.\n");
diff -u linux-2.5.2-pre7/drivers/cdrom/mcdx.c linux/drivers/cdrom/mcdx.c
--- linux-2.5.2-pre7/drivers/cdrom/mcdx.c	Thu Oct 25 13:58:35 2001
+++ linux/drivers/cdrom/mcdx.c	Fri Jan  4 01:57:39 2002
@@ -291,6 +291,7 @@
 static struct s_drive_stuff *mcdx_irq_map[16] = { 0, 0, 0, 0, 0, 0, 0, 0,
 	0, 0, 0, 0, 0, 0, 0, 0
 };
+static spinlock_t mcdx_lock = SPIN_LOCK_UNLOCKED;
 MODULE_PARM(mcdx, "1-4i");
 
 static struct cdrom_device_ops mcdx_dops = {
@@ -318,7 +319,7 @@
 static int mcdx_audio_ioctl(struct cdrom_device_info *cdi,
 			    unsigned int cmd, void *arg)
 {
-	struct s_drive_stuff *stuffp = mcdx_stuffp[MINOR(cdi->dev)];
+	struct s_drive_stuff *stuffp = mcdx_stuffp[minor(cdi->dev)];
 
 	if (!stuffp->present)
 		return -ENXIO;
@@ -575,7 +576,7 @@
 
 	INIT_REQUEST;
 
-	dev = MINOR(CURRENT->rq_dev);
+	dev = minor(CURRENT->rq_dev);
 	stuffp = mcdx_stuffp[dev];
 
 	if ((dev < 0)
@@ -598,14 +599,13 @@
 	xtrace(REQUEST, "do_request() (%lu + %lu)\n",
 	       CURRENT->sector, CURRENT->nr_sectors);
 
-	switch (CURRENT->cmd) {
-	case WRITE:
-		xwarn("do_request(): attempt to write to cd!!\n");
+	if (CURRENT->cmd != READ) {
+		xwarn("do_request(): non-read command to cd!!\n");
 		xtrace(REQUEST, "end_request(0): write\n");
 		end_request(0);
 		return;
-
-	case READ:
+	}
+	else {
 		stuffp->status = 0;
 		while (CURRENT->nr_sectors) {
 			int i;
@@ -628,11 +628,6 @@
 
 		xtrace(REQUEST, "end_request(1)\n");
 		end_request(1);
-		break;
-
-	default:
-		panic(MCDX "do_request: unknown command.\n");
-		break;
 	}
 
 	goto again;
@@ -642,7 +637,7 @@
 {
 	struct s_drive_stuff *stuffp;
 	xtrace(OPENCLOSE, "open()\n");
-	stuffp = mcdx_stuffp[MINOR(cdi->dev)];
+	stuffp = mcdx_stuffp[minor(cdi->dev)];
 	if (!stuffp->present)
 		return -ENXIO;
 
@@ -791,7 +786,7 @@
 
 	xtrace(OPENCLOSE, "close()\n");
 
-	stuffp = mcdx_stuffp[MINOR(cdi->dev)];
+	stuffp = mcdx_stuffp[minor(cdi->dev)];
 
 	--stuffp->users;
 }
@@ -805,7 +800,7 @@
 	xinfo("mcdx_media_changed called for device %s\n",
 	      kdevname(cdi->dev));
 
-	stuffp = mcdx_stuffp[MINOR(cdi->dev)];
+	stuffp = mcdx_stuffp[minor(cdi->dev)];
 	mcdx_getstatus(stuffp, 1);
 
 	if (stuffp->yyy == 0)
@@ -1187,7 +1182,8 @@
 		return 1;
 	}
 
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
+	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST,
+		       &mcdx_lock);
 	read_ahead[MAJOR_NR] = READ_AHEAD;
 	blksize_size[MAJOR_NR] = mcdx_blocksizes;
 
@@ -1228,7 +1224,7 @@
 		stuffp->wreg_data, stuffp->irq, version.code, version.ver);
 	mcdx_stuffp[drive] = stuffp;
 	xtrace(INIT, "init() mcdx_stuffp[%d] = %p\n", drive, stuffp);
-	mcdx_info.dev = MKDEV(MAJOR_NR, 0);
+	mcdx_info.dev = mk_kdev(MAJOR_NR, 0);
 	if (register_cdrom(&mcdx_info) != 0) {
 		printk("Cannot register Mitsumi CD-ROM!\n");
 		release_region((unsigned long) stuffp->wreg_data,
@@ -1698,7 +1694,7 @@
 
 static int mcdx_tray_move(struct cdrom_device_info *cdi, int position)
 {
-	struct s_drive_stuff *stuffp = mcdx_stuffp[MINOR(cdi->dev)];
+	struct s_drive_stuff *stuffp = mcdx_stuffp[minor(cdi->dev)];
 
 	if (!stuffp->present)
 		return -ENXIO;
@@ -1888,7 +1884,7 @@
 
 static int mcdx_lockdoor(struct cdrom_device_info *cdi, int lock)
 {
-	struct s_drive_stuff *stuffp = mcdx_stuffp[MINOR(cdi->dev)];
+	struct s_drive_stuff *stuffp = mcdx_stuffp[minor(cdi->dev)];
 	char cmd[2] = { 0xfe };
 
 	if (!(stuffp->present & DOOR))
diff -u linux-2.5.2-pre7/drivers/cdrom/optcd.c linux/drivers/cdrom/optcd.c
--- linux-2.5.2-pre7/drivers/cdrom/optcd.c	Thu Oct 25 13:58:35 2001
+++ linux/drivers/cdrom/optcd.c	Fri Jan  4 01:57:39 2002
@@ -109,7 +109,6 @@
 #endif
 
 static int blksize = 2048;
-static int hsecsize = 2048;
 
 
 /* Drive hardware/firmware characteristics
@@ -267,6 +266,7 @@
 static DECLARE_WAIT_QUEUE_HEAD(waitq);
 static void sleep_timer(unsigned long data);
 static struct timer_list delay_timer = {function: sleep_timer};
+spinlock_t optcd_lock = SPIN_LOCK_UNLOCKED;
 
 
 /* Timer routine: wake up when desired flag goes low,
@@ -977,7 +977,7 @@
 
 
 #define CURRENT_VALID \
-	(!QUEUE_EMPTY && MAJOR(CURRENT -> rq_dev) == MAJOR_NR \
+	(!QUEUE_EMPTY && major(CURRENT -> rq_dev) == MAJOR_NR \
 	 && CURRENT -> cmd == READ && CURRENT -> sector != -1)
 
 
@@ -1371,10 +1371,6 @@
 
 	transfer_is_active = 1;
 	while (CURRENT_VALID) {
-		if (CURRENT->bh) {
-			if (!buffer_locked(CURRENT->bh))
-				panic(DEVICE_NAME ": block not locked");
-		}
 		transfer();	/* First try to transfer block from buffers */
 		if (CURRENT -> nr_sectors == 0) {
 			end_request(1);
@@ -2063,12 +2059,12 @@
 	}
 	devfs_register (NULL, "optcd", DEVFS_FL_DEFAULT, MAJOR_NR, 0,
 			S_IFBLK | S_IRUGO | S_IWUGO, &opt_fops, NULL);
-	hardsect_size[MAJOR_NR] = &hsecsize;
 	blksize_size[MAJOR_NR] = &blksize;
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
+	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST,
+		       &optcd_lock);
 	read_ahead[MAJOR_NR] = 4;
 	request_region(optcd_port, 4, "optcd");
-	register_disk(NULL, MKDEV(MAJOR_NR,0), 1, &opt_fops, 0);
+	register_disk(NULL, mk_kdev(MAJOR_NR,0), 1, &opt_fops, 0);
 
 	printk(KERN_INFO "optcd: DOLPHIN 8000 AT CDROM at 0x%x\n", optcd_port);
 	return 0;
diff -u linux-2.5.2-pre7/drivers/cdrom/sjcd.c linux/drivers/cdrom/sjcd.c
--- linux-2.5.2-pre7/drivers/cdrom/sjcd.c	Thu Oct 25 13:58:35 2001
+++ linux/drivers/cdrom/sjcd.c	Fri Jan  4 01:57:39 2002
@@ -1664,7 +1664,6 @@
 };
 
 static int blksize = 2048;
-static int secsize = 2048;
 
 /*
  * Following stuff is intended for initialization of the cdrom. It
@@ -1692,7 +1691,6 @@
 	printk("SJCD: sjcd=0x%x: ", sjcd_base);
 #endif
 
-	hardsect_size[MAJOR_NR] = &secsize;
 	blksize_size[MAJOR_NR] = &blksize;
 
 	if (devfs_register_blkdev(MAJOR_NR, "sjcd", &sjcd_fops) != 0) {

--WIyZ46R2i8wDzkSu--
