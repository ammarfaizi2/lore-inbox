Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279360AbRJWKpa>; Tue, 23 Oct 2001 06:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279362AbRJWKpX>; Tue, 23 Oct 2001 06:45:23 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:5519 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S279360AbRJWKpI>;
	Tue, 23 Oct 2001 06:45:08 -0400
Date: Tue, 23 Oct 2001 06:45:40 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [CFT][PATCH] cdrom-related rmmod races
Message-ID: <Pine.GSO.4.21.0110230640520.7440-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Folks, patch below should fix the rmmod/open() races for
cdrom drivers (including pcd and sr).  The problem with the current
code is that they use cdrom_open() as ->open() and bump module
refcount only in cdrom_device_info->open() callback.  cdrom_open()
blocks before calling it, with obvious results.

	Patch is pretty straightforward - it gives these guys ->open()
of their own that does MOD_INC_USE_COUNT and calls cdrom_open() - see
below for examples.  Please, give it a try - if there's no complaints it
goes to Linus.

diff -urN S13-pre6/drivers/block/paride/pcd.c S13-pre6-current/drivers/block/paride/pcd.c
--- S13-pre6/drivers/block/paride/pcd.c	Sun Oct 21 15:17:06 2001
+++ S13-pre6-current/drivers/block/paride/pcd.c	Mon Oct 22 22:52:22 2001
@@ -204,6 +204,8 @@
 int pcd_init(void);
 void cleanup_module( void );
 
+static int pcd_dev_open(struct inode *inode, struct file *file);
+static void pcd_dev_release(struct inode *inode, struct file *file);
 static int pcd_open(struct cdrom_device_info *cdi, int purpose);
 static void pcd_release(struct cdrom_device_info *cdi);
 static int pcd_drive_status(struct cdrom_device_info *cdi, int slot_nr);
@@ -265,6 +267,13 @@
 
 /* kernel glue structures */
 
+struct block_device_operations pcd_bdops = {
+	open:			pcd_dev_open,
+	release:		pcd_dev_release,
+	ioctl:			cdrom_ioctl,
+	check_media_change:	cdrom_media_changed,
+}
+
 static struct cdrom_device_ops pcd_dops = {
 	pcd_open,
 	pcd_release,
@@ -335,13 +344,17 @@
 	/* get the atapi capabilities page */
 	pcd_probe_capabilities();
 
-	if (register_blkdev(MAJOR_NR,name,&cdrom_fops)) {
+	if (register_blkdev(MAJOR_NR,name,&pcd_bdops)) {
 		printk("pcd: unable to get major number %d\n",MAJOR_NR);
 		return -1;
 	}
 
-	for (unit=0;unit<PCD_UNITS;unit++)
-		if (PCD.present) register_cdrom(&PCD.info);
+	for (unit=0;unit<PCD_UNITS;unit++) {
+		if (PCD.present) {
+			register_cdrom(&PCD.info);
+			devfs_plain_cdrom(&PCD.info, &pcd_bdops);
+		}
+	}
 
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
 	read_ahead[MAJOR_NR] = 8;	/* 8 sector (4kB) read ahead */
@@ -352,20 +365,36 @@
 	return 0;
 }
 
+static int pcd_dev_open(struct inode *inode, struct file *file)
+{
+	int err;
+
+	MOD_INC_USE_COUNT;
+	err = cdrom_open(inode, file);
+	if (err)
+		MOD_DEC_USE_COUNT;
+	return err;
+}
+
+static int pcd_dev_release(struct inode *inode, struct file *file)
+{
+	int err = cdrom_release(inode, file);
+	MOD_DEC_USE_COUNT;
+	return err;
+}
+
 static int pcd_open(struct cdrom_device_info *cdi, int purpose)
 
 {	int unit = DEVICE_NR(cdi->dev);
 
 	if  ((unit >= PCD_UNITS) || (!PCD.present)) return -ENODEV;
 
-	MOD_INC_USE_COUNT;
-
 	return 0;
 }
 
 static void pcd_release(struct cdrom_device_info *cdi)
 
-{	MOD_DEC_USE_COUNT;
+{
 }
 
 #ifdef MODULE
diff -urN S13-pre6/drivers/cdrom/cdrom.c S13-pre6-current/drivers/cdrom/cdrom.c
--- S13-pre6/drivers/cdrom/cdrom.c	Sun Oct 21 15:17:06 2001
+++ S13-pre6-current/drivers/cdrom/cdrom.c	Mon Oct 22 23:58:14 2001
@@ -310,11 +310,6 @@
 #define CHECKAUDIO if ((ret=check_for_audio_disc(cdi, cdo))) return ret
 
 /* Not-exported routines. */
-static int cdrom_open(struct inode *ip, struct file *fp);
-static int cdrom_release(struct inode *ip, struct file *fp);
-static int cdrom_ioctl(struct inode *ip, struct file *fp,
-				unsigned int cmd, unsigned long arg);
-static int cdrom_media_changed(kdev_t dev);
 static int open_for_data(struct cdrom_device_info * cdi);
 static int check_for_audio_disc(struct cdrom_device_info * cdi,
 			 struct cdrom_device_ops * cdo);
@@ -333,14 +328,6 @@
 static devfs_handle_t devfs_handle;
 static struct unique_numspace cdrom_numspace = UNIQUE_NUMBERSPACE_INITIALISER;
 
-struct block_device_operations cdrom_fops =
-{
-	open:			cdrom_open,
-	release:		cdrom_release,
-	ioctl:			cdrom_ioctl,
-	check_media_change:	cdrom_media_changed,
-};
-
 /* This macro makes sure we don't have to check on cdrom_device_ops
  * existence in the run-time routines below. Change_capability is a
  * hack to have the capability flags defined const, while we can still
@@ -354,7 +341,6 @@
 	int major = MAJOR(cdi->dev);
         struct cdrom_device_ops *cdo = cdi->ops;
         int *change_capability = (int *)&cdo->capability; /* hack */
-	char vname[16];
 
 	cdinfo(CD_OPEN, "entering register_cdrom\n"); 
 
@@ -396,7 +382,6 @@
 	if (!devfs_handle)
 		devfs_handle = devfs_mk_dir (NULL, "cdroms", NULL);
 	cdi->number = devfs_alloc_unique_number (&cdrom_numspace);
-	sprintf (vname, "cdrom%d", cdi->number);
 	if (cdi->de) {
 		int pos;
 		devfs_handle_t slave;
@@ -405,6 +390,8 @@
 		pos = devfs_generate_path (cdi->de, rname + 3,
 					   sizeof rname - 3);
 		if (pos >= 0) {
+			char vname[16];
+			sprintf (vname, "cdrom%d", cdi->number);
 			strncpy (rname + pos, "../", 3);
 			devfs_mk_symlink (devfs_handle, vname,
 					  DEVFS_FL_DEFAULT,
@@ -412,13 +399,6 @@
 			devfs_auto_unregister (cdi->de, slave);
 		}
 	}
-	else {
-		cdi->de =
-		    devfs_register (devfs_handle, vname, DEVFS_FL_DEFAULT,
-				    MAJOR (cdi->dev), MINOR (cdi->dev),
-				    S_IFBLK | S_IRUGO | S_IWUGO,
-				    &cdrom_fops, NULL);
-	}
 	cdinfo(CD_REG_UNREG, "drive \"/dev/%s\" registered\n", cdi->name);
 	cdi->next = topCdromPtr; 	
 	topCdromPtr = cdi;
@@ -475,7 +455,6 @@
  * is in their own interest: device control becomes a lot easier
  * this way.
  */
-static
 int cdrom_open(struct inode *ip, struct file *fp)
 {
 	struct cdrom_device_info *cdi;
@@ -669,7 +648,6 @@
 
 
 /* Admittedly, the logic below could be performed in a nicer way. */
-static
 int cdrom_release(struct inode *ip, struct file *fp)
 {
 	kdev_t dev = ip->i_rdev;
@@ -867,7 +845,7 @@
 	return ret;
 }
 
-static int cdrom_media_changed(kdev_t dev)
+int cdrom_media_changed(kdev_t dev)
 {
 	struct cdrom_device_info *cdi = cdrom_find_device(dev);
 	/* This talks to the VFS, which doesn't like errors - just 1 or 0.  
@@ -1480,7 +1458,7 @@
  * these days. ATAPI / SCSI specific code now mainly resides in
  * mmc_ioct().
  */
-static int cdrom_ioctl(struct inode *ip, struct file *fp, unsigned int cmd,
+int cdrom_ioctl(struct inode *ip, struct file *fp, unsigned int cmd,
 		       unsigned long arg)
 {
 	kdev_t dev = ip->i_rdev;
@@ -2391,7 +2369,10 @@
 EXPORT_SYMBOL(cdrom_count_tracks);
 EXPORT_SYMBOL(register_cdrom);
 EXPORT_SYMBOL(unregister_cdrom);
-EXPORT_SYMBOL(cdrom_fops);
+EXPORT_SYMBOL(cdrom_open);
+EXPORT_SYMBOL(cdrom_release);
+EXPORT_SYMBOL(cdrom_ioctl);
+EXPORT_SYMBOL(cdrom_media_changed);
 EXPORT_SYMBOL(cdrom_number_of_slots);
 EXPORT_SYMBOL(cdrom_select_disc);
 EXPORT_SYMBOL(cdrom_mode_select);
diff -urN S13-pre6/drivers/cdrom/cdu31a.c S13-pre6-current/drivers/cdrom/cdu31a.c
--- S13-pre6/drivers/cdrom/cdu31a.c	Sun Sep 23 16:11:59 2001
+++ S13-pre6-current/drivers/cdrom/cdu31a.c	Mon Oct 22 23:40:16 2001
@@ -3102,6 +3102,23 @@
 	return 0;
 }
 
+static int scd_dev_open(struct inode *inode, struct file *file)
+{
+	int err;
+	MOD_INC_USE_COUNT;
+	err = cdrom_open(inode, file);
+	if (err)
+		MOD_DEC_USE_COUNT;
+	return err;
+}
+
+static int scd_dev_release(struct inode *inode, struct file *file)
+{
+	int err = cdrom_release(inode, file);
+	MOD_DEC_USE_COUNT;
+	return err;
+}
+
 /*
  * Open the drive for operations.  Spin the drive up and read the table of
  * contents if these have not already been done.
@@ -3112,17 +3129,13 @@
 	unsigned int res_size;
 	unsigned char params[2];
 
-	MOD_INC_USE_COUNT;
 	if (sony_usage == 0) {
-		if (scd_spinup() != 0) {
-			MOD_DEC_USE_COUNT;
+		if (scd_spinup() != 0)
 			return -EIO;
-		}
 		sony_get_toc();
 		if (!sony_toc_read) {
 			do_sony_cd_cmd(SONY_SPIN_DOWN_CMD, NULL, 0,
 				       res_reg, &res_size);
-			MOD_DEC_USE_COUNT;
 			return -EIO;
 		}
 
@@ -3183,9 +3196,16 @@
 		sony_spun_up = 0;
 	}
 	sony_usage--;
-	MOD_DEC_USE_COUNT;
 }
 
+struct block_device_operations scd_bdops =
+{
+	open:			scd_dev_open,
+	release:		scd_dev_release,
+	ioctl:			cdrom_ioctl,
+	check_media_change:	cdrom_media_changed,
+};
+
 static struct cdrom_device_ops scd_dops = {
 	open:scd_open,
 	release:scd_release,
@@ -3383,7 +3403,7 @@
 
 		request_region(cdu31a_port, 4, "cdu31a");
 
-		if (devfs_register_blkdev(MAJOR_NR, "cdu31a", &cdrom_fops)) {
+		if (devfs_register_blkdev(MAJOR_NR, "cdu31a", &scd_bdops)) {
 			printk("Unable to get major %d for CDU-31a\n",
 			       MAJOR_NR);
 			goto errout2;
@@ -3465,6 +3485,7 @@
 		if (register_cdrom(&scd_info)) {
 			goto errout0;
 		}
+		devfs_plain_cdrom(&scd_info, &scd_bdops);
 	}
 
 
diff -urN S13-pre6/drivers/cdrom/cm206.c S13-pre6-current/drivers/cdrom/cm206.c
--- S13-pre6/drivers/cdrom/cm206.c	Sun Sep 23 16:11:59 2001
+++ S13-pre6-current/drivers/cdrom/cm206.c	Mon Oct 22 23:44:34 2001
@@ -765,11 +765,35 @@
 	}
 }
 
+static int cm206_dev_open(struct inode *inode, struct file *file)
+{
+	int err;
+	MOD_INC_USE_COUNT;
+	err = cdrom_open(inode, file);
+	if (err)
+		MOD_DEC_USE_COUNT;
+	return err;
+}
+
+static int cm206_dev_release(struct inode *inode, struct file *file)
+{
+	int err = cdrom_release(inode, file);
+	MOD_DEC_USE_COUNT;
+	return err;
+}
+
+struct block_device_operations cm206_bdops =
+{
+	open:			cm206_dev_open,
+	release:		cm206_dev_release,
+	ioctl:			cdrom_ioctl,
+	check_media_change:	cdrom_media_changed,
+};
+
 /* The new open. The real opening strategy is defined in cdrom.c. */
 
 static int cm206_open(struct cdrom_device_info *cdi, int purpose)
 {
-	MOD_INC_USE_COUNT;
 	if (!cd->openfiles) {	/* reset only first time */
 		cd->background = 0;
 		reset_cm260();
@@ -792,7 +816,6 @@
 		FIRST_TRACK = 0;	/* No valid disc status */
 	}
 	--cd->openfiles;
-	MOD_DEC_USE_COUNT;
 }
 
 /* Empty buffer empties $sectors$ sectors of the adapter card buffer,
@@ -1478,7 +1501,7 @@
 		return -EIO;
 	}
 	printk(".\n");
-	if (devfs_register_blkdev(MAJOR_NR, "cm206", &cdrom_fops) != 0) {
+	if (devfs_register_blkdev(MAJOR_NR, "cm206", &cm206_bdops) != 0) {
 		printk(KERN_INFO "Cannot register for major %d!\n",
 		       MAJOR_NR);
 		cleanup(3);
@@ -1491,6 +1514,7 @@
 		cleanup(3);
 		return -EIO;
 	}
+	devfs_plain_cdrom(&cm206_info, &cm206_bdops);
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
 	blksize_size[MAJOR_NR] = cm206_blocksizes;
 	read_ahead[MAJOR_NR] = 16;	/* reads ahead what? */
diff -urN S13-pre6/drivers/cdrom/mcd.c S13-pre6-current/drivers/cdrom/mcd.c
--- S13-pre6/drivers/cdrom/mcd.c	Sun Sep 23 16:11:59 2001
+++ S13-pre6-current/drivers/cdrom/mcd.c	Mon Oct 22 23:47:28 2001
@@ -189,6 +189,31 @@
 		    void *arg);
 int mcd_drive_status(struct cdrom_device_info *cdi, int slot_nr);
 
+static int mcd_dev_open(struct inode *inode, struct file *file)
+{
+	int err;
+	MOD_INC_USE_COUNT;
+	err = cdrom_open(inode, file);
+	if (err)
+		MOD_DEC_USE_COUNT;
+	return err;
+}
+
+static int mcd_dev_release(struct inode *inode, struct file *file)
+{
+	int err = cdrom_release(inode, file);
+	MOD_DEC_USE_COUNT;
+	return err;
+}
+
+struct block_device_operations mcd_bdops =
+{
+	open:			mcd_dev_open,
+	release:		mcd_dev_release,
+	ioctl:			cdrom_ioctl,
+	check_media_change:	cdrom_media_changed,
+};
+
 static struct timer_list mcd_timer;
 
 static struct cdrom_device_ops mcd_dops = {
@@ -978,8 +1003,6 @@
 	if (mcdPresent == 0)
 		return -ENXIO;	/* no hardware */
 
-	MOD_INC_USE_COUNT;
-
 	if (mcd_open_count || mcd_state != MCD_S_IDLE)
 		goto bump_count;
 
@@ -1002,7 +1025,6 @@
 	return 0;
 
 err_out:
-	MOD_DEC_USE_COUNT;
 	return -EIO;
 }
 
@@ -1015,7 +1037,6 @@
 	if (!--mcd_open_count) {
 		mcd_invalidate_buffers();
 	}
-	MOD_DEC_USE_COUNT;
 }
 
 
@@ -1060,7 +1081,7 @@
 		return -EIO;
 	}
 
-	if (devfs_register_blkdev(MAJOR_NR, "mcd", &cdrom_fops) != 0) {
+	if (devfs_register_blkdev(MAJOR_NR, "mcd", &mcd_bdops) != 0) {
 		printk(KERN_ERR "mcd: Unable to get major %d for Mitsumi CD-ROM\n", MAJOR_NR);
 		return -EIO;
 	}
@@ -1152,6 +1173,7 @@
 		cleanup(3);
 		return -EIO;
 	}
+	devfs_plain_cdrom(&mcd_info, &mcd_bdops);
 	printk(msg);
 
 	return 0;
diff -urN S13-pre6/drivers/cdrom/mcdx.c S13-pre6-current/drivers/cdrom/mcdx.c
--- S13-pre6/drivers/cdrom/mcdx.c	Sun Sep 23 16:11:59 2001
+++ S13-pre6-current/drivers/cdrom/mcdx.c	Tue Oct 23 05:31:44 2001
@@ -219,6 +219,31 @@
 int mcdx_init(void);
 void do_mcdx_request(request_queue_t * q);
 
+static int mcdx_dev_open(struct inode *inode, struct file *file)
+{
+	int err;
+	MOD_INC_USE_COUNT;
+	err = cdrom_open(inode, file);
+	if (err)
+		MOD_DEC_USE_COUNT;
+	return err;
+}
+
+static int mcdx_dev_release(struct inode *inode, struct file *file)
+{
+	int err = cdrom_release(inode, file);
+	MOD_DEC_USE_COUNT;
+	return err;
+}
+
+struct block_device_operations mcdx_bdops =
+{
+	open:			mcdx_dev_open,
+	release:		mcdx_dev_release,
+	ioctl:			cdrom_ioctl,
+	check_media_change:	cdrom_media_changed,
+};
+
 
 /*	Indirect exported functions. These functions are exported by their
 	addresses, such as mcdx_open and mcdx_close in the
@@ -640,13 +665,10 @@
 	/* Make the modules looking used ... (thanx bjorn).
 	 * But we shouldn't forget to decrement the module counter
 	 * on error return */
-	MOD_INC_USE_COUNT;
 
 	/* this is only done to test if the drive talks with us */
-	if (-1 == mcdx_getstatus(stuffp, 1)) {
-		MOD_DEC_USE_COUNT;
+	if (-1 == mcdx_getstatus(stuffp, 1))
 		return -EIO;
-	}
 
 	if (stuffp->xxx) {
 
@@ -705,10 +727,8 @@
 		}
 
 		xtrace(OPENCLOSE, "open() init irq generation\n");
-		if (-1 == mcdx_config(stuffp, 1)) {
-			MOD_DEC_USE_COUNT;
+		if (-1 == mcdx_config(stuffp, 1))
 			return -EIO;
-		}
 #if FALLBACK
 		/* Set the read speed */
 		xwarn("AAA %x AAA\n", stuffp->readcmd);
@@ -745,7 +765,7 @@
 								  MODE2 :
 								  MODE1,
 								  1))) {
-					/* MOD_DEC_USE_COUNT, return -EIO; */
+					/* return -EIO; */
 					stuffp->xa = 0;
 					break;
 				}
@@ -765,10 +785,8 @@
 		/* xa disks will be read in raw mode, others not */
 		if (-1 == mcdx_setdrivemode(stuffp,
 					    stuffp->xa ? RAW : COOKED,
-					    1)) {
-			MOD_DEC_USE_COUNT;
+					    1))
 			return -EIO;
-		}
 		if (stuffp->audio) {
 			xinfo("open() audio disk found\n");
 		} else if (stuffp->lastsector >= 0) {
@@ -792,8 +810,6 @@
 	stuffp = mcdx_stuffp[MINOR(cdi->dev)];
 
 	--stuffp->users;
-
-	MOD_DEC_USE_COUNT;
 }
 
 static int mcdx_media_changed(struct cdrom_device_info *cdi, int disc_nr)
@@ -1180,7 +1196,7 @@
 	}
 
 	xtrace(INIT, "init() register blkdev\n");
-	if (devfs_register_blkdev(MAJOR_NR, "mcdx", &cdrom_fops) != 0) {
+	if (devfs_register_blkdev(MAJOR_NR, "mcdx", &mcdx_bdops) != 0) {
 		xwarn("%s=0x%3p,%d: Init failed. Can't get major %d.\n",
 		      MCDX, stuffp->wreg_data, stuffp->irq, MAJOR_NR);
 		kfree(stuffp);
@@ -1240,6 +1256,7 @@
 		blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
 		return 2;
 	}
+	devfs_plain_cdrom(&mcdx_info, &mcdx_bdops);
 	printk(msg);
 	return 0;
 }
diff -urN S13-pre6/drivers/cdrom/sbpcd.c S13-pre6-current/drivers/cdrom/sbpcd.c
--- S13-pre6/drivers/cdrom/sbpcd.c	Sun Sep 23 16:11:59 2001
+++ S13-pre6-current/drivers/cdrom/sbpcd.c	Tue Oct 23 05:34:45 2001
@@ -5418,6 +5418,31 @@
 	return (1);
 }
 /*==========================================================================*/
+
+static int sbpcd_dev_open(struct inode *inode, struct file *file)
+{
+	int err;
+	MOD_INC_USE_COUNT;
+	err = cdrom_open(inode, file);
+	if (err)
+		MOD_DEC_USE_COUNT;
+	return err;
+}
+
+static int sbpcd_dev_release(struct inode *inode, struct file *file)
+{
+	int err = cdrom_release(inode, file);
+	MOD_DEC_USE_COUNT;
+	return err;
+}
+
+static struct block_device_operations sbpcd_bdops =
+{
+	open:			sbpcd_dev_open,
+	release:		sbpcd_dev_release,
+	ioctl:			cdrom_ioctl,
+	check_media_change:	cdrom_media_changed,
+};
 /*==========================================================================*/
 /*
  *  Open the device special file.  Check that a disk is in. Read TOC.
@@ -5428,7 +5453,6 @@
 
 	i = MINOR(cdi->dev);
 
-	MOD_INC_USE_COUNT;
 	down(&ioctl_read_sem);
 	switch_drive(i);
 
@@ -5495,7 +5519,6 @@
 		}
 	}
 	up(&ioctl_read_sem);
-	MOD_DEC_USE_COUNT;
 	return ;
 }
 /*==========================================================================*/
@@ -5848,7 +5871,7 @@
 	OUT(MIXER_data,0xCC); /* one nibble per channel, max. value: 0xFF */
 #endif /* SOUND_BASE */ 
 	
-	if (devfs_register_blkdev(MAJOR_NR, major_name, &cdrom_fops) != 0)
+	if (devfs_register_blkdev(MAJOR_NR, major_name, &sbpcd_bdops) != 0)
 	{
 		msg(DBG_INF, "Can't get MAJOR %d for Matsushita CDROM\n", MAJOR_NR);
 #ifdef MODULE
@@ -5923,7 +5946,7 @@
 		sbpcd_infop->de =
 		    devfs_register (devfs_handle, nbuff, DEVFS_FL_DEFAULT,
 				    MAJOR_NR, j, S_IFBLK | S_IRUGO | S_IWUGO,
-				    &cdrom_fops, NULL);
+				    &sbpcd_bdops, NULL);
 		if (register_cdrom(sbpcd_infop))
 		{
                 	printk(" sbpcd: Unable to register with Uniform CD-ROm driver\n");
diff -urN S13-pre6/drivers/ide/ide-cd.c S13-pre6-current/drivers/ide/ide-cd.c
--- S13-pre6/drivers/ide/ide-cd.c	Sun Oct 21 15:17:06 2001
+++ S13-pre6-current/drivers/ide/ide-cd.c	Mon Oct 22 22:53:44 2001
@@ -2863,7 +2863,7 @@
 		     struct inode *inode, struct file *file,
 		     unsigned int cmd, unsigned long arg)
 {
-	return cdrom_fops.ioctl (inode, file, cmd, arg);
+	return cdrom_ioctl (inode, file, cmd, arg);
 }
 
 static
@@ -2875,7 +2875,7 @@
 	MOD_INC_USE_COUNT;
 	if (info->buffer == NULL)
 		info->buffer = (char *) kmalloc(SECTOR_BUFFER_SIZE, GFP_KERNEL);
-        if ((info->buffer == NULL) || (rc = cdrom_fops.open(ip, fp))) {
+        if ((info->buffer == NULL) || (rc = cdrom_open(ip, fp))) {
 		drive->usage--;
 		MOD_DEC_USE_COUNT;
 	}
@@ -2886,14 +2886,14 @@
 void ide_cdrom_release (struct inode *inode, struct file *file,
 			ide_drive_t *drive)
 {
-	cdrom_fops.release (inode, file);
+	cdrom_release (inode, file);
 	MOD_DEC_USE_COUNT;
 }
 
 static
 int ide_cdrom_check_media_change (ide_drive_t *drive)
 {
-	return cdrom_fops.check_media_change(MKDEV (HWIF (drive)->major,
+	return cdrom_media_change(MKDEV (HWIF (drive)->major,
 			(drive->select.b.unit) << PARTN_BITS));
 }
 
diff -urN S13-pre6/drivers/scsi/sr.c S13-pre6-current/drivers/scsi/sr.c
--- S13-pre6/drivers/scsi/sr.c	Sun Oct 21 15:17:14 2001
+++ S13-pre6-current/drivers/scsi/sr.c	Mon Oct 22 23:56:54 2001
@@ -484,6 +484,31 @@
 	return 1;
 }
 
+static int sr_dev_open(struct inode *inode, struct file *file)
+{
+	int err;
+	MOD_INC_USE_COUNT;
+	err = cdrom_open(inode, file);
+	if (err)
+		MOD_DEC_USE_COUNT;
+	return err;
+}
+
+static int sr_dev_release(struct inode *inode, struct file *file)
+{
+	int err = cdrom_release(inode, file);
+	MOD_DEC_USE_COUNT;
+	return err;
+}
+
+struct block_device_operations sr_bdops =
+{
+	open:			sr_dev_open,
+	release:		sr_dev_release,
+	ioctl:			cdrom_ioctl,
+	check_media_change:	cdrom_media_changed,
+};
+
 static int sr_open(struct cdrom_device_info *cdi, int purpose)
 {
 	check_disk_change(cdi->dev);
@@ -778,7 +803,7 @@
 		return 0;
 
 	if (!sr_registered) {
-		if (devfs_register_blkdev(MAJOR_NR, "sr", &cdrom_fops)) {
+		if (devfs_register_blkdev(MAJOR_NR, "sr", &sr_bdops)) {
 			printk("Unable to get major %d for SCSI-CD\n", MAJOR_NR);
 			return 1;
 		}
@@ -875,7 +900,7 @@
                     devfs_register (scsi_CDs[i].device->de, "cd",
                                     DEVFS_FL_DEFAULT, MAJOR_NR, i,
                                     S_IFBLK | S_IRUGO | S_IWUGO,
-                                    &cdrom_fops, NULL);
+                                    &sr_bdops, NULL);
 		register_cdrom(&scsi_CDs[i].cdi);
 	}
 
diff -urN S13-pre6/include/linux/cdrom.h S13-pre6-current/include/linux/cdrom.h
--- S13-pre6/include/linux/cdrom.h	Fri Oct 19 23:06:18 2001
+++ S13-pre6-current/include/linux/cdrom.h	Tue Oct 23 05:26:08 2001
@@ -777,10 +777,25 @@
 };
 
 /* the general block_device operations structure: */
-extern struct block_device_operations cdrom_fops;
+extern int cdrom_open(struct inode *, struct file *);
+extern int cdrom_release(struct inode *, struct file *);
+extern int cdrom_ioctl(struct inode *, struct file *, unsigned, unsigned long);
+extern int cdrom_media_changed(kdev_t);
 
 extern int register_cdrom(struct cdrom_device_info *cdi);
 extern int unregister_cdrom(struct cdrom_device_info *cdi);
+
+static inline void devfs_plain_cdrom(struct cdrom_device_info *cdi,
+				struct block_device_operations *ops)
+{
+	char vname[23];
+
+	sprintf (vname, "cdroms/cdrom%d", cdi->number);
+	cdi->de = devfs_register (NULL, vname, DEVFS_FL_DEFAULT,
+				    MAJOR (cdi->dev), MINOR (cdi->dev),
+				    S_IFBLK | S_IRUGO | S_IWUGO,
+				    ops, NULL);
+}
 
 typedef struct {
     int data;

