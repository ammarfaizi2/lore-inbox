Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288277AbSACSpl>; Thu, 3 Jan 2002 13:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288281AbSACSpd>; Thu, 3 Jan 2002 13:45:33 -0500
Received: from vena.lwn.net ([206.168.112.25]:18195 "HELO eklektix.com")
	by vger.kernel.org with SMTP id <S288277AbSACSpY>;
	Thu, 3 Jan 2002 13:45:24 -0500
Message-ID: <20020103184523.6115.qmail@eklektix.com>
To: davej@suse.de
Subject: [PATCH] Fix kdev_t in sr, st, sg
cc: linux-kernel@vger.kernel.org
From: Jonathan Corbet <corbet-lk@lwn.net>
Date: Thu, 03 Jan 2002 11:45:23 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch against 2.5.1-dj11 which fixes the kdev_t compilation
problems in the SCSI tape, CD, and generic modules.  Tape and CD are tested
and work; I've not had a chance to actually *run* anything that uses sg
yet, but it "looks like it should work."

I have a 2.5.2-pre6 version that I'll send out shortly.

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net


diff -r -u dj11-vanilla/drivers/scsi/sg.c linux-2.5.1-dj11/drivers/scsi/sg.c
--- dj11-vanilla/drivers/scsi/sg.c	Thu Jan  3 09:42:20 2002
+++ linux-2.5.1-dj11/drivers/scsi/sg.c	Thu Jan  3 09:52:00 2002
@@ -259,7 +259,7 @@
 
 static int sg_open(struct inode * inode, struct file * filp)
 {
-    int dev = MINOR(inode->i_rdev);
+    int dev = minor(inode->i_rdev);
     int flags = filp->f_flags;
     Sg_device * sdp;
     Sg_fd * sfp;
@@ -345,7 +345,7 @@
     if ((! (sfp = (Sg_fd *)filp->private_data)) || (! (sdp = sfp->parentdp))) {
         return -ENXIO;
     }
-    SCSI_LOG_TIMEOUT(3, printk("sg_release: dev=%d\n", MINOR(sdp->i_rdev)));
+    SCSI_LOG_TIMEOUT(3, printk("sg_release: dev=%d\n", minor(sdp->i_rdev)));
     sg_fasync(-1, filp, 0);   /* remove filp from async notification list */
     if (0 == sg_remove_sfp(sdp, sfp)) { /* Returns 1 when sdp gone */
         if (! sdp->detached) {
@@ -374,7 +374,7 @@
     if ((! (sfp = (Sg_fd *)filp->private_data)) || (! (sdp = sfp->parentdp)))
         return -ENXIO;
     SCSI_LOG_TIMEOUT(3, printk("sg_read: dev=%d, count=%d\n",
-                               MINOR(sdp->i_rdev), (int)count));
+                               minor(sdp->i_rdev), (int)count));
     if (ppos != &filp->f_pos)
         ; /* FIXME: Hmm.  Seek to the right place, or fail?  */
     if ((k = verify_area(VERIFY_WRITE, buf, count)))
@@ -519,7 +519,7 @@
     if ((! (sfp = (Sg_fd *)filp->private_data)) || (! (sdp = sfp->parentdp)))
         return -ENXIO;
     SCSI_LOG_TIMEOUT(3, printk("sg_write: dev=%d, count=%d\n",
-                               MINOR(sdp->i_rdev), (int)count));
+                               minor(sdp->i_rdev), (int)count));
     if (sdp->detached)
     	return -ENODEV;
     if (! ((filp->f_flags & O_NONBLOCK) ||
@@ -752,7 +752,7 @@
     if ((! (sfp = (Sg_fd *)filp->private_data)) || (! (sdp = sfp->parentdp)))
         return -ENXIO;
     SCSI_LOG_TIMEOUT(3, printk("sg_ioctl: dev=%d, cmd=0x%x\n",
-                               MINOR(sdp->i_rdev), (int)cmd_in));
+                               minor(sdp->i_rdev), (int)cmd_in));
     read_only = (O_RDWR != (filp->f_flags & O_ACCMODE));
 
     switch(cmd_in)
@@ -1032,7 +1032,7 @@
     else if (count < SG_MAX_QUEUE)
         res |= POLLOUT | POLLWRNORM;
     SCSI_LOG_TIMEOUT(3, printk("sg_poll: dev=%d, res=0x%x\n",
-                        MINOR(sdp->i_rdev), (int)res));
+                        minor(sdp->i_rdev), (int)res));
     return res;
 }
 
@@ -1045,7 +1045,7 @@
     if ((! (sfp = (Sg_fd *)filp->private_data)) || (! (sdp = sfp->parentdp)))
         return -ENXIO;
     SCSI_LOG_TIMEOUT(3, printk("sg_fasync: dev=%d, mode=%d\n",
-                               MINOR(sdp->i_rdev), mode));
+                               minor(sdp->i_rdev), mode));
 
     retval = fasync_helper(fd, filp, mode, &sfp->async_qp);
     return (retval < 0) ? retval : 0;
@@ -1189,7 +1189,7 @@
 static void sg_cmd_done_bh(Scsi_Cmnd * SCpnt)
 {
     Scsi_Request * SRpnt = SCpnt->sc_request;
-    int dev = MINOR(SRpnt->sr_request.rq_dev);
+    int dev = minor(SRpnt->sr_request.rq_dev);
     Sg_device * sdp = NULL;
     Sg_fd * sfp;
     Sg_request * srp = NULL;
@@ -1236,7 +1236,7 @@
     SRpnt->sr_bufflen = 0;
     SRpnt->sr_buffer = NULL;
     SRpnt->sr_underflow = 0;
-    SRpnt->sr_request.rq_dev = MKDEV(0, 0);  /* "sg" _disowns_ request blk */
+    SRpnt->sr_request.rq_dev = mk_kdev(0, 0);  /* "sg" _disowns_ request blk */
 
     srp->my_cmdp = NULL;
     srp->done = 1;
@@ -1441,7 +1441,7 @@
     sdp->sgdebug = 0;
     sdp->detached = 0;
     sdp->sg_tablesize = scsidp->host ? scsidp->host->sg_tablesize : 0;
-    sdp->i_rdev = MKDEV(SCSI_GENERIC_MAJOR, k);
+    sdp->i_rdev = mk_kdev(SCSI_GENERIC_MAJOR, k);
     sdp->de = devfs_register (scsidp->de, "generic", DEVFS_FL_DEFAULT,
                              SCSI_GENERIC_MAJOR, k,
                              S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP,
@@ -2883,7 +2883,7 @@
 		PRINT_PROC("device %d detached ??\n", j);
 		continue;
 	    }
-	    dev = MINOR(sdp->i_rdev);
+	    dev = minor(sdp->i_rdev);
 
 	    if (sg_get_nth_sfp(sdp, 0)) {
 		PRINT_PROC(" >>> device=sg%d ", dev);
diff -r -u dj11-vanilla/drivers/scsi/sr.c linux-2.5.1-dj11/drivers/scsi/sr.c
--- dj11-vanilla/drivers/scsi/sr.c	Thu Jan  3 09:42:18 2002
+++ linux-2.5.1-dj11/drivers/scsi/sr.c	Thu Jan  3 09:47:27 2002
@@ -99,11 +99,11 @@
 
 static void sr_release(struct cdrom_device_info *cdi)
 {
-	if (scsi_CDs[MINOR(cdi->dev)].device->sector_size > 2048)
-		sr_set_blocklength(MINOR(cdi->dev), 2048);
-	scsi_CDs[MINOR(cdi->dev)].device->access_count--;
-	if (scsi_CDs[MINOR(cdi->dev)].device->host->hostt->module)
-		__MOD_DEC_USE_COUNT(scsi_CDs[MINOR(cdi->dev)].device->host->hostt->module);
+	if (scsi_CDs[minor(cdi->dev)].device->sector_size > 2048)
+		sr_set_blocklength(minor(cdi->dev), 2048);
+	scsi_CDs[minor(cdi->dev)].device->access_count--;
+	if (scsi_CDs[minor(cdi->dev)].device->host->hostt->module)
+		__MOD_DEC_USE_COUNT(scsi_CDs[minor(cdi->dev)].device->host->hostt->module);
 	if (sr_template.module)
 		__MOD_DEC_USE_COUNT(sr_template.module);
 }
@@ -150,7 +150,7 @@
 		/* no changer support */
 		return -EINVAL;
 	}
-	retval = scsi_ioctl(scsi_CDs[MINOR(cdi->dev)].device,
+	retval = scsi_ioctl(scsi_CDs[minor(cdi->dev)].device,
 			    SCSI_IOCTL_TEST_UNIT_READY, 0);
 
 	if (retval) {
@@ -159,13 +159,13 @@
 		 * and we will figure it out later once the drive is
 		 * available again.  */
 
-		scsi_CDs[MINOR(cdi->dev)].device->changed = 1;
+		scsi_CDs[minor(cdi->dev)].device->changed = 1;
 		return 1;	/* This will force a flush, if called from
 				 * check_disk_change */
 	};
 
-	retval = scsi_CDs[MINOR(cdi->dev)].device->changed;
-	scsi_CDs[MINOR(cdi->dev)].device->changed = 0;
+	retval = scsi_CDs[minor(cdi->dev)].device->changed;
+	scsi_CDs[minor(cdi->dev)].device->changed = 0;
 	/* If the disk changed, the capacity will now be different,
 	 * so we force a re-read of this information */
 	if (retval) {
@@ -179,9 +179,9 @@
 		 * be trying to use something that is too small if the disc
 		 * has changed.
 		 */
-		scsi_CDs[MINOR(cdi->dev)].needs_sector_size = 1;
+		scsi_CDs[minor(cdi->dev)].needs_sector_size = 1;
 
-		scsi_CDs[MINOR(cdi->dev)].device->sector_size = 2048;
+		scsi_CDs[minor(cdi->dev)].device->sector_size = 2048;
 	}
 	return retval;
 }
@@ -253,17 +253,17 @@
 	/*
 	 * No such device
 	 */
-	if (MINOR(dev) >= sr_template.dev_max || !scsi_CDs[MINOR(dev)].device)
+	if (minor(dev) >= sr_template.dev_max || !scsi_CDs[minor(dev)].device)
 		return NULL;
 
-	return &scsi_CDs[MINOR(dev)].device->request_queue;
+	return &scsi_CDs[minor(dev)].device->request_queue;
 }
 
 static int sr_init_command(Scsi_Cmnd * SCpnt)
 {
 	int dev, devm, block=0, this_count, s_size;
 
-	devm = MINOR(SCpnt->request.rq_dev);
+	devm = minor(SCpnt->request.rq_dev);
 	dev = DEVICE_NR(SCpnt->request.rq_dev);
 
 	SCSI_LOG_HLQUEUE(1, printk("Doing sr request, dev = %d, block = %d\n", devm, block));
@@ -399,20 +399,20 @@
 {
 	check_disk_change(cdi->dev);
 
-	if (MINOR(cdi->dev) >= sr_template.dev_max
-	    || !scsi_CDs[MINOR(cdi->dev)].device) {
+	if (minor(cdi->dev) >= sr_template.dev_max
+	    || !scsi_CDs[minor(cdi->dev)].device) {
 		return -ENXIO;	/* No such device */
 	}
 	/*
 	 * If the device is in error recovery, wait until it is done.
 	 * If the device is offline, then disallow any access to it.
 	 */
-	if (!scsi_block_when_processing_errors(scsi_CDs[MINOR(cdi->dev)].device)) {
+	if (!scsi_block_when_processing_errors(scsi_CDs[minor(cdi->dev)].device)) {
 		return -ENXIO;
 	}
-	scsi_CDs[MINOR(cdi->dev)].device->access_count++;
-	if (scsi_CDs[MINOR(cdi->dev)].device->host->hostt->module)
-		__MOD_INC_USE_COUNT(scsi_CDs[MINOR(cdi->dev)].device->host->hostt->module);
+	scsi_CDs[minor(cdi->dev)].device->access_count++;
+	if (scsi_CDs[minor(cdi->dev)].device->host->hostt->module)
+		__MOD_INC_USE_COUNT(scsi_CDs[minor(cdi->dev)].device->host->hostt->module);
 	if (sr_template.module)
 		__MOD_INC_USE_COUNT(sr_template.module);
 
@@ -421,8 +421,8 @@
 	 * this is the case, and try again.
 	 */
 
-	if (scsi_CDs[MINOR(cdi->dev)].needs_sector_size)
-		get_sectorsize(MINOR(cdi->dev));
+	if (scsi_CDs[minor(cdi->dev)].needs_sector_size)
+		get_sectorsize(minor(cdi->dev));
 
 	return 0;
 }
@@ -671,13 +671,13 @@
  */
 static int sr_packet(struct cdrom_device_info *cdi, struct cdrom_generic_command *cgc)
 {
-	Scsi_Device *device = scsi_CDs[MINOR(cdi->dev)].device;
+	Scsi_Device *device = scsi_CDs[minor(cdi->dev)].device;
 
 	/* set the LUN */
 	if (device->scsi_level <= SCSI_2)
 		cgc->cmd[1] |= device->lun << 5;
 
-	cgc->stat = sr_do_ioctl(MINOR(cdi->dev), cgc->cmd, cgc->buffer, cgc->buflen, cgc->quiet, cgc->data_direction, cgc->sense);
+	cgc->stat = sr_do_ioctl(minor(cdi->dev), cgc->cmd, cgc->buffer, cgc->buflen, cgc->quiet, cgc->data_direction, cgc->sense);
 
 	return cgc->stat;
 }
@@ -766,7 +766,7 @@
 
 		scsi_CDs[i].cdi.ops = &sr_dops;
 		scsi_CDs[i].cdi.handle = &scsi_CDs[i];
-		scsi_CDs[i].cdi.dev = MKDEV(MAJOR_NR, i);
+		scsi_CDs[i].cdi.dev = mk_kdev(MAJOR_NR, i);
 		scsi_CDs[i].cdi.mask = 0;
 		scsi_CDs[i].cdi.capacity = 1;
 		/*
@@ -809,7 +809,7 @@
 			 * the device.
 			 * We should be kind to our buffer cache, however.
 			 */
-			invalidate_device(MKDEV(MAJOR_NR, i), 0);
+			invalidate_device(mk_kdev(MAJOR_NR, i), 0);
 
 			/*
 			 * Reset things back to a sane state so that one can
diff -r -u dj11-vanilla/drivers/scsi/sr_ioctl.c linux-2.5.1-dj11/drivers/scsi/sr_ioctl.c
--- dj11-vanilla/drivers/scsi/sr_ioctl.c	Thu Jan  3 09:42:18 2002
+++ linux-2.5.1-dj11/drivers/scsi/sr_ioctl.c	Thu Jan  3 09:48:03 2002
@@ -68,7 +68,7 @@
 	sr_cmd[6] = trk1_te.cdte_addr.msf.minute;
 	sr_cmd[7] = trk1_te.cdte_addr.msf.second;
 	sr_cmd[8] = trk1_te.cdte_addr.msf.frame;
-	return sr_do_ioctl(MINOR(cdi->dev), sr_cmd, NULL, 0, 0, SCSI_DATA_NONE, NULL);
+	return sr_do_ioctl(minor(cdi->dev), sr_cmd, NULL, 0, 0, SCSI_DATA_NONE, NULL);
 }
 
 /* We do our own retries because we want to know what the specific
@@ -206,17 +206,17 @@
 	u_char sr_cmd[10];
 
 	sr_cmd[0] = GPCMD_START_STOP_UNIT;
-	sr_cmd[1] = (scsi_CDs[MINOR(cdi->dev)].device->scsi_level <= SCSI_2) ?
-	            ((scsi_CDs[MINOR(cdi->dev)].device->lun) << 5) : 0;
+	sr_cmd[1] = (scsi_CDs[minor(cdi->dev)].device->scsi_level <= SCSI_2) ?
+	            ((scsi_CDs[minor(cdi->dev)].device->lun) << 5) : 0;
 	sr_cmd[2] = sr_cmd[3] = sr_cmd[5] = 0;
 	sr_cmd[4] = (pos == 0) ? 0x03 /* close */ : 0x02 /* eject */ ;
 
-	return sr_do_ioctl(MINOR(cdi->dev), sr_cmd, NULL, 0, 0, SCSI_DATA_NONE, NULL);
+	return sr_do_ioctl(minor(cdi->dev), sr_cmd, NULL, 0, 0, SCSI_DATA_NONE, NULL);
 }
 
 int sr_lock_door(struct cdrom_device_info *cdi, int lock)
 {
-	return scsi_ioctl(scsi_CDs[MINOR(cdi->dev)].device,
+	return scsi_ioctl(scsi_CDs[minor(cdi->dev)].device,
 		      lock ? SCSI_IOCTL_DOORLOCK : SCSI_IOCTL_DOORUNLOCK,
 			  0);
 }
@@ -227,7 +227,7 @@
 		/* we have no changer support */
 		return -EINVAL;
 	}
-	if (0 == test_unit_ready(MINOR(cdi->dev)))
+	if (0 == test_unit_ready(minor(cdi->dev)))
 		return CDS_DISC_OK;
 
 	return CDS_TRAY_OPEN;
@@ -256,7 +256,7 @@
 	if (!have_datatracks)
 		return CDS_AUDIO;
 
-	if (scsi_CDs[MINOR(cdi->dev)].xa_flag)
+	if (scsi_CDs[minor(cdi->dev)].xa_flag)
 		return CDS_XA_2_1;
 	else
 		return CDS_DATA_1;
@@ -265,9 +265,9 @@
 int sr_get_last_session(struct cdrom_device_info *cdi,
 			struct cdrom_multisession *ms_info)
 {
-	ms_info->addr.lba = scsi_CDs[MINOR(cdi->dev)].ms_offset;
-	ms_info->xa_flag = scsi_CDs[MINOR(cdi->dev)].xa_flag ||
-	    (scsi_CDs[MINOR(cdi->dev)].ms_offset > 0);
+	ms_info->addr.lba = scsi_CDs[minor(cdi->dev)].ms_offset;
+	ms_info->xa_flag = scsi_CDs[minor(cdi->dev)].xa_flag ||
+	    (scsi_CDs[minor(cdi->dev)].ms_offset > 0);
 
 	return 0;
 }
@@ -279,8 +279,8 @@
 	int result;
 
 	sr_cmd[0] = GPCMD_READ_SUBCHANNEL;
-	sr_cmd[1] = (scsi_CDs[MINOR(cdi->dev)].device->scsi_level <= SCSI_2) ?
-	            ((scsi_CDs[MINOR(cdi->dev)].device->lun) << 5) : 0;
+	sr_cmd[1] = (scsi_CDs[minor(cdi->dev)].device->scsi_level <= SCSI_2) ?
+	            ((scsi_CDs[minor(cdi->dev)].device->lun) << 5) : 0;
 	sr_cmd[2] = 0x40;	/* I do want the subchannel info */
 	sr_cmd[3] = 0x02;	/* Give me medium catalog number info */
 	sr_cmd[4] = sr_cmd[5] = 0;
@@ -289,7 +289,7 @@
 	sr_cmd[8] = 24;
 	sr_cmd[9] = 0;
 
-	result = sr_do_ioctl(MINOR(cdi->dev), sr_cmd, buffer, 24, 0, SCSI_DATA_READ, NULL);
+	result = sr_do_ioctl(minor(cdi->dev), sr_cmd, buffer, 24, 0, SCSI_DATA_READ, NULL);
 
 	memcpy(mcn->medium_catalog_number, buffer + 9, 13);
 	mcn->medium_catalog_number[13] = 0;
@@ -314,12 +314,12 @@
 
 	memset(sr_cmd, 0, MAX_COMMAND_SIZE);
 	sr_cmd[0] = GPCMD_SET_SPEED;	/* SET CD SPEED */
-	sr_cmd[1] = (scsi_CDs[MINOR(cdi->dev)].device->scsi_level <= SCSI_2) ?
-	            ((scsi_CDs[MINOR(cdi->dev)].device->lun) << 5) : 0;
+	sr_cmd[1] = (scsi_CDs[minor(cdi->dev)].device->scsi_level <= SCSI_2) ?
+	            ((scsi_CDs[minor(cdi->dev)].device->lun) << 5) : 0;
 	sr_cmd[2] = (speed >> 8) & 0xff;	/* MSB for speed (in kbytes/sec) */
 	sr_cmd[3] = speed & 0xff;	/* LSB */
 
-	if (sr_do_ioctl(MINOR(cdi->dev), sr_cmd, NULL, 0, 0, SCSI_DATA_NONE, NULL))
+	if (sr_do_ioctl(minor(cdi->dev), sr_cmd, NULL, 0, 0, SCSI_DATA_NONE, NULL))
 		return -EIO;
 	return 0;
 }
@@ -333,7 +333,7 @@
 int sr_audio_ioctl(struct cdrom_device_info *cdi, unsigned int cmd, void *arg)
 {
 	u_char sr_cmd[10];
-	int result, target = MINOR(cdi->dev);
+	int result, target = minor(cdi->dev);
 	unsigned char buffer[32];
 
 	memset(sr_cmd, 0, sizeof(sr_cmd));
@@ -541,7 +541,7 @@
 {
 	int target;
 
-	target = MINOR(cdi->dev);
+	target = minor(cdi->dev);
 
 	switch (cmd) {
 	case BLKGETSIZE:
diff -r -u dj11-vanilla/drivers/scsi/sr_vendor.c linux-2.5.1-dj11/drivers/scsi/sr_vendor.c
--- dj11-vanilla/drivers/scsi/sr_vendor.c	Thu Jan  3 09:42:22 2002
+++ linux-2.5.1-dj11/drivers/scsi/sr_vendor.c	Thu Jan  3 09:50:51 2002
@@ -158,7 +158,7 @@
 	unsigned char cmd[MAX_COMMAND_SIZE];	/* the scsi-command */
 	int rc, no_multi, minor;
 
-	minor = MINOR(cdi->dev);
+	minor = minor(cdi->dev);
 	if (scsi_CDs[minor].cdi.mask & CDC_MULTI_SESSION)
 		return 0;
 
diff -r -u dj11-vanilla/drivers/scsi/st.c linux-2.5.1-dj11/drivers/scsi/st.c
--- dj11-vanilla/drivers/scsi/st.c	Thu Jan  3 09:42:18 2002
+++ linux-2.5.1-dj11/drivers/scsi/st.c	Thu Jan  3 09:45:42 2002
@@ -133,8 +133,8 @@
 #define ST_TIMEOUT (900 * HZ)
 #define ST_LONG_TIMEOUT (14000 * HZ)
 
-#define TAPE_NR(x) (MINOR(x) & ~(128 | ST_MODE_MASK))
-#define TAPE_MODE(x) ((MINOR(x) & ST_MODE_MASK) >> ST_MODE_SHIFT)
+#define TAPE_NR(x) (minor(x) & ~(128 | ST_MODE_MASK))
+#define TAPE_MODE(x) ((minor(x) & ST_MODE_MASK) >> ST_MODE_SHIFT)
 
 /* Internal ioctl to set both density (uppermost 8 bits) and blocksize (lower
    24 bits) */
@@ -878,7 +878,7 @@
 	}
 	STp->in_use = 1;
 	write_unlock_irqrestore(&st_dev_arr_lock, flags);
-	STp->rew_at_close = STp->autorew_dev = (MINOR(inode->i_rdev) & 0x80) == 0;
+	STp->rew_at_close = STp->autorew_dev = (minor(inode->i_rdev) & 0x80) == 0;
 
 	if (STp->device->host->hostt->module)
 		__MOD_INC_USE_COUNT(STp->device->host->hostt->module);
@@ -3717,7 +3717,7 @@
 		tpnt->tape_type = MT_ISSCSI2;
 
         tpnt->inited = 0;
-	tpnt->devt = MKDEV(SCSI_TAPE_MAJOR, i);
+	tpnt->devt = mk_kdev(SCSI_TAPE_MAJOR, i);
 	tpnt->dirty = 0;
 	tpnt->in_use = 0;
 	tpnt->drv_buffer = 1;	/* Try buffering if no mode sense */
