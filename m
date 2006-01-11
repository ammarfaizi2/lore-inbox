Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751534AbWAKNTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbWAKNTL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 08:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWAKNTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 08:19:11 -0500
Received: from verein.lst.de ([213.95.11.210]:25050 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751534AbWAKNTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 08:19:07 -0500
Date: Wed, 11 Jan 2006 14:19:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] kill cdrom ->dev_ioctl method
Message-ID: <20060111131901.GB9491@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since early 2.4.x all cdrom drivers implement the block_device methods
themselves, so they can handle additional ioctls directly instead of
going through the cdrom layer.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/drivers/ide/ide-cd.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-cd.c	2006-01-10 18:31:32.000000000 +0100
+++ linux-2.6/drivers/ide/ide-cd.c	2006-01-11 12:55:09.000000000 +0100
@@ -2471,52 +2471,6 @@
 }
 
 static
-int ide_cdrom_dev_ioctl (struct cdrom_device_info *cdi,
-			 unsigned int cmd, unsigned long arg)
-{
-	struct packet_command cgc;
-	char buffer[16];
-	int stat;
-
-	init_cdrom_command(&cgc, buffer, sizeof(buffer), CGC_DATA_UNKNOWN);
-
-	/* These will be moved into the Uniform layer shortly... */
-	switch (cmd) {
- 	case CDROMSETSPINDOWN: {
- 		char spindown;
- 
- 		if (copy_from_user(&spindown, (void __user *) arg, sizeof(char)))
-			return -EFAULT;
- 
-                if ((stat = cdrom_mode_sense(cdi, &cgc, GPMODE_CDROM_PAGE, 0)))
-			return stat;
-
- 		buffer[11] = (buffer[11] & 0xf0) | (spindown & 0x0f);
-
- 		return cdrom_mode_select(cdi, &cgc);
- 	} 
- 
- 	case CDROMGETSPINDOWN: {
- 		char spindown;
- 
-                if ((stat = cdrom_mode_sense(cdi, &cgc, GPMODE_CDROM_PAGE, 0)))
-			return stat;
- 
- 		spindown = buffer[11] & 0x0f;
- 
-		if (copy_to_user((void __user *) arg, &spindown, sizeof (char)))
-			return -EFAULT;
- 
- 		return 0;
- 	}
-  
-	default:
-		return -EINVAL;
-	}
-
-}
-
-static
 int ide_cdrom_audio_ioctl (struct cdrom_device_info *cdi,
 			   unsigned int cmd, void *arg)
 			   
@@ -2852,12 +2806,11 @@
 	.get_mcn		= ide_cdrom_get_mcn,
 	.reset			= ide_cdrom_reset,
 	.audio_ioctl		= ide_cdrom_audio_ioctl,
-	.dev_ioctl		= ide_cdrom_dev_ioctl,
 	.capability		= CDC_CLOSE_TRAY | CDC_OPEN_TRAY | CDC_LOCK |
 				CDC_SELECT_SPEED | CDC_SELECT_DISC |
 				CDC_MULTI_SESSION | CDC_MCN |
 				CDC_MEDIA_CHANGED | CDC_PLAY_AUDIO | CDC_RESET |
-				CDC_IOCTLS | CDC_DRIVE_STATUS | CDC_CD_R |
+				CDC_DRIVE_STATUS | CDC_CD_R |
 				CDC_CD_RW | CDC_DVD | CDC_DVD_R| CDC_DVD_RAM |
 				CDC_GENERIC_PACKET | CDC_MO_DRIVE | CDC_MRW |
 				CDC_MRW_W | CDC_RAM,
@@ -3370,6 +3323,45 @@
 	return 0;
 }
 
+static int idecd_set_spindown(struct cdrom_device_info *cdi, unsigned long arg)
+{
+	struct packet_command cgc;
+	char buffer[16];
+	int stat;
+	char spindown;
+
+	if (copy_from_user(&spindown, (void __user *)arg, sizeof(char)))
+		return -EFAULT;
+
+	init_cdrom_command(&cgc, buffer, sizeof(buffer), CGC_DATA_UNKNOWN);
+
+	stat = cdrom_mode_sense(cdi, &cgc, GPMODE_CDROM_PAGE, 0);
+	if (stat)
+		return stat;
+
+	buffer[11] = (buffer[11] & 0xf0) | (spindown & 0x0f);
+	return cdrom_mode_select(cdi, &cgc);
+}
+
+static int idecd_get_spindown(struct cdrom_device_info *cdi, unsigned long arg)
+{
+	struct packet_command cgc;
+	char buffer[16];
+	int stat;
+ 	char spindown;
+
+	init_cdrom_command(&cgc, buffer, sizeof(buffer), CGC_DATA_UNKNOWN);
+
+	stat = cdrom_mode_sense(cdi, &cgc, GPMODE_CDROM_PAGE, 0);
+	if (stat)
+		return stat;
+
+	spindown = buffer[11] & 0x0f;
+	if (copy_to_user((void __user *)arg, &spindown, sizeof (char)))
+		return -EFAULT;
+	return 0;
+}
+
 static int idecd_ioctl (struct inode *inode, struct file *file,
 			unsigned int cmd, unsigned long arg)
 {
@@ -3377,7 +3369,16 @@
 	struct cdrom_info *info = ide_cd_g(bdev->bd_disk);
 	int err;
 
-	err  = generic_ide_ioctl(info->drive, file, bdev, cmd, arg);
+	switch (cmd) {
+ 	case CDROMSETSPINDOWN:
+		return idecd_set_spindown(&info->devinfo, arg);
+ 	case CDROMGETSPINDOWN:
+		return idecd_get_spindown(&info->devinfo, arg);
+	default:
+		break;
+ 	}
+
+	err = generic_ide_ioctl(info->drive, file, bdev, cmd, arg);
 	if (err == -EINVAL)
 		err = cdrom_ioctl(file, &info->devinfo, inode, cmd, arg);
 
Index: linux-2.6/drivers/scsi/sr.c
===================================================================
--- linux-2.6.orig/drivers/scsi/sr.c	2006-01-05 16:43:19.000000000 +0100
+++ linux-2.6/drivers/scsi/sr.c	2006-01-11 12:55:09.000000000 +0100
@@ -66,7 +66,7 @@
 #define SR_CAPABILITIES \
 	(CDC_CLOSE_TRAY|CDC_OPEN_TRAY|CDC_LOCK|CDC_SELECT_SPEED| \
 	 CDC_SELECT_DISC|CDC_MULTI_SESSION|CDC_MCN|CDC_MEDIA_CHANGED| \
-	 CDC_PLAY_AUDIO|CDC_RESET|CDC_IOCTLS|CDC_DRIVE_STATUS| \
+	 CDC_PLAY_AUDIO|CDC_RESET|CDC_DRIVE_STATUS| \
 	 CDC_CD_R|CDC_CD_RW|CDC_DVD|CDC_DVD_R|CDC_DVD_RAM|CDC_GENERIC_PACKET| \
 	 CDC_MRW|CDC_MRW_W|CDC_RAM)
 
@@ -113,7 +113,6 @@
 	.get_mcn		= sr_get_mcn,
 	.reset			= sr_reset,
 	.audio_ioctl		= sr_audio_ioctl,
-	.dev_ioctl		= sr_dev_ioctl,
 	.capability		= SR_CAPABILITIES,
 	.generic_packet		= sr_packet,
 };
@@ -472,17 +471,33 @@
 {
 	struct scsi_cd *cd = scsi_cd(inode->i_bdev->bd_disk);
 	struct scsi_device *sdev = cd->device;
+	void __user *argp = (void __user *)arg;
+	int ret;
 
-        /*
-         * Send SCSI addressing ioctls directly to mid level, send other
-         * ioctls to cdrom/block level.
-         */
-        switch (cmd) {
-                case SCSI_IOCTL_GET_IDLUN:
-                case SCSI_IOCTL_GET_BUS_NUMBER:
-                        return scsi_ioctl(sdev, cmd, (void __user *)arg);
+	/*
+	 * Send SCSI addressing ioctls directly to mid level, send other
+	 * ioctls to cdrom/block level.
+	 */
+	switch (cmd) {
+	case SCSI_IOCTL_GET_IDLUN:
+	case SCSI_IOCTL_GET_BUS_NUMBER:
+		return scsi_ioctl(sdev, cmd, argp);
 	}
-	return cdrom_ioctl(file, &cd->cdi, inode, cmd, arg);
+
+	ret = cdrom_ioctl(file, &cd->cdi, inode, cmd, arg);
+	if (ret != ENOSYS)
+		return ret;
+
+	/*
+	 * ENODEV means that we didn't recognise the ioctl, or that we
+	 * cannot execute it in the current device state.  In either
+	 * case fall through to scsi_ioctl, which will return ENDOEV again
+	 * if it doesn't recognise the ioctl
+	 */
+	ret = scsi_nonblockable_ioctl(sdev, cmd, argp, NULL);
+	if (ret != -ENODEV)
+		return ret;
+	return scsi_ioctl(sdev, cmd, argp);
 }
 
 static int sr_block_media_changed(struct gendisk *disk)
Index: linux-2.6/drivers/scsi/sr.h
===================================================================
--- linux-2.6.orig/drivers/scsi/sr.h	2005-12-27 18:30:31.000000000 +0100
+++ linux-2.6/drivers/scsi/sr.h	2006-01-11 12:55:09.000000000 +0100
@@ -55,7 +55,6 @@
 int sr_reset(struct cdrom_device_info *);
 int sr_select_speed(struct cdrom_device_info *cdi, int speed);
 int sr_audio_ioctl(struct cdrom_device_info *, unsigned int, void *);
-int sr_dev_ioctl(struct cdrom_device_info *, unsigned int, unsigned long);
 
 int sr_is_xa(Scsi_CD *);
 
Index: linux-2.6/drivers/scsi/sr_ioctl.c
===================================================================
--- linux-2.6.orig/drivers/scsi/sr_ioctl.c	2005-12-27 18:30:31.000000000 +0100
+++ linux-2.6/drivers/scsi/sr_ioctl.c	2006-01-11 12:55:09.000000000 +0100
@@ -542,22 +542,3 @@
 #endif
 	return is_xa;
 }
-
-int sr_dev_ioctl(struct cdrom_device_info *cdi,
-		 unsigned int cmd, unsigned long arg)
-{
-	Scsi_CD *cd = cdi->handle;
-	int ret;
-	
-	ret = scsi_nonblockable_ioctl(cd->device, cmd,
-				      (void __user *)arg, NULL);
-	/*
-	 * ENODEV means that we didn't recognise the ioctl, or that we
-	 * cannot execute it in the current device state.  In either
-	 * case fall through to scsi_ioctl, which will return ENDOEV again
-	 * if it doesn't recognise the ioctl
-	 */
-	if (ret != -ENODEV)
-		return ret;
-	return scsi_ioctl(cd->device, cmd, (void __user *)arg);
-}
Index: linux-2.6/drivers/cdrom/cdrom.c
===================================================================
--- linux-2.6.orig/drivers/cdrom/cdrom.c	2006-01-11 12:55:08.000000000 +0100
+++ linux-2.6/drivers/cdrom/cdrom.c	2006-01-11 12:55:09.000000000 +0100
@@ -407,7 +407,6 @@
 	ENSURE(get_mcn, CDC_MCN);
 	ENSURE(reset, CDC_RESET);
 	ENSURE(audio_ioctl, CDC_PLAY_AUDIO);
-	ENSURE(dev_ioctl, CDC_IOCTLS);
 	ENSURE(generic_packet, CDC_GENERIC_PACKET);
 	cdi->mc_flags = 0;
 	cdo->n_minors = 0;
@@ -2776,12 +2775,6 @@
 		return cdrom_ioctl_audioctl(cdi, cmd);
 	}
 
-	/*
-	 * Finally, do the device specific ioctls
-	 */
-	if (CDROM_CAN(CDC_IOCTLS))
-		return cdi->ops->dev_ioctl(cdi, cmd, arg);
-
 	return -ENOSYS;
 }
 
Index: linux-2.6/drivers/cdrom/cm206.c
===================================================================
--- linux-2.6.orig/drivers/cdrom/cm206.c	2006-01-10 13:46:03.000000000 +0100
+++ linux-2.6/drivers/cdrom/cm206.c	2006-01-11 12:55:09.000000000 +0100
@@ -1157,32 +1157,6 @@
 	}
 }
 
-/* Ioctl. These ioctls are specific to the cm206 driver. I have made
-   some driver statistics accessible through ioctl calls.
- */
-
-static int cm206_ioctl(struct cdrom_device_info *cdi, unsigned int cmd,
-		       unsigned long arg)
-{
-	switch (cmd) {
-#ifdef STATISTICS
-	case CM206CTL_GET_STAT:
-		if (arg >= NR_STATS)
-			return -EINVAL;
-		else
-			return cd->stats[arg];
-	case CM206CTL_GET_LAST_STAT:
-		if (arg >= NR_STATS)
-			return -EINVAL;
-		else
-			return cd->last_stat[arg];
-#endif
-	default:
-		debug(("Unknown ioctl call 0x%x\n", cmd));
-		return -EINVAL;
-	}
-}
-
 static int cm206_media_changed(struct cdrom_device_info *cdi, int disc_nr)
 {
 	if (cd != NULL) {
@@ -1321,11 +1295,10 @@
 	.get_mcn		= cm206_get_upc,
 	.reset			= cm206_reset,
 	.audio_ioctl		= cm206_audio_ioctl,
-	.dev_ioctl		= cm206_ioctl,
 	.capability		= CDC_CLOSE_TRAY | CDC_OPEN_TRAY | CDC_LOCK |
 				  CDC_MULTI_SESSION | CDC_MEDIA_CHANGED |
 				  CDC_MCN | CDC_PLAY_AUDIO | CDC_SELECT_SPEED |
-				  CDC_IOCTLS | CDC_DRIVE_STATUS,
+				  CDC_DRIVE_STATUS,
 	.n_minors		= 1,
 };
 
@@ -1350,6 +1323,21 @@
 static int cm206_block_ioctl(struct inode *inode, struct file *file,
 				unsigned cmd, unsigned long arg)
 {
+	switch (cmd) {
+#ifdef STATISTICS
+	case CM206CTL_GET_STAT:
+		if (arg >= NR_STATS)
+			return -EINVAL;
+		return cd->stats[arg];
+	case CM206CTL_GET_LAST_STAT:
+		if (arg >= NR_STATS)
+			return -EINVAL;
+		return cd->last_stat[arg];
+#endif
+	default:
+		break;
+	}
+
 	return cdrom_ioctl(file, &cm206_info, inode, cmd, arg);
 }
 
Index: linux-2.6/drivers/cdrom/sbpcd.c
===================================================================
--- linux-2.6.orig/drivers/cdrom/sbpcd.c	2005-12-27 18:30:27.000000000 +0100
+++ linux-2.6/drivers/cdrom/sbpcd.c	2006-01-11 12:55:09.000000000 +0100
@@ -4160,18 +4160,13 @@
 	return  0;
 }
 
-/*==========================================================================*/
-/*==========================================================================*/
-/*
- * ioctl support
- */
-static int sbpcd_dev_ioctl(struct cdrom_device_info *cdi, u_int cmd,
-		      u_long arg)
+static int sbpcd_audio_ioctl(struct cdrom_device_info *cdi, u_int cmd,
+		       void * arg)
 {
 	struct sbpcd_drive *p = cdi->handle;
-	int i;
+	int i, st, j;
 	
-	msg(DBG_IO2,"ioctl(%s, 0x%08lX, 0x%08lX)\n", cdi->name, cmd, arg);
+	msg(DBG_IO2,"ioctl(%s, 0x%08lX, 0x%08p)\n", cdi->name, cmd, arg);
 	if (p->drv_id==-1) {
 		msg(DBG_INF, "ioctl: bad device: %s\n", cdi->name);
 		return (-ENXIO);             /* no such drive */
@@ -4183,1194 +4178,1192 @@
 	msg(DBG_IO2,"ioctl: device %s, request %04X\n",cdi->name,cmd);
 	switch (cmd) 		/* Sun-compatible */
 	{
-	case DDIOCSDBG:		/* DDI Debug */
-		if (!capable(CAP_SYS_ADMIN)) RETURN_UP(-EPERM);
-		i=sbpcd_dbg_ioctl(arg,1);
-		RETURN_UP(i);
-	case CDROMRESET:      /* hard reset the drive */
-		msg(DBG_IOC,"ioctl: CDROMRESET entered.\n");
-		i=DriveReset();
-		current_drive->audio_state=0;
-		RETURN_UP(i);
 		
-	case CDROMREADMODE1:
-		msg(DBG_IOC,"ioctl: CDROMREADMODE1 requested.\n");
+	case CDROMPAUSE:     /* Pause the drive */
+		msg(DBG_IOC,"ioctl: CDROMPAUSE entered.\n");
+		/* pause the drive unit when it is currently in PLAY mode,         */
+		/* or reset the starting and ending locations when in PAUSED mode. */
+		/* If applicable, at the next stopping point it reaches            */
+		/* the drive will discontinue playing.                             */
+		switch (current_drive->audio_state)
+		{
+		case audio_playing:
+			if (famL_drive) i=cc_ReadSubQ();
+			else i=cc_Pause_Resume(1);
+			if (i<0) RETURN_UP(-EIO);
+			if (famL_drive) i=cc_Pause_Resume(1);
+			else i=cc_ReadSubQ();
+			if (i<0) RETURN_UP(-EIO);
+			current_drive->pos_audio_start=current_drive->SubQ_run_tot;
+			current_drive->audio_state=audio_pausing;
+			RETURN_UP(0);
+		case audio_pausing:
+			i=cc_Seek(current_drive->pos_audio_start,1);
+			if (i<0) RETURN_UP(-EIO);
+			RETURN_UP(0);
+		default:
+			RETURN_UP(-EINVAL);
+		}
+		
+	case CDROMRESUME: /* resume paused audio play */
+		msg(DBG_IOC,"ioctl: CDROMRESUME entered.\n");
+		/* resume playing audio tracks when a previous PLAY AUDIO call has  */
+		/* been paused with a PAUSE command.                                */
+		/* It will resume playing from the location saved in SubQ_run_tot.  */
+		if (current_drive->audio_state!=audio_pausing) RETURN_UP(-EINVAL);
+		if (famL_drive)
+			i=cc_PlayAudio(current_drive->pos_audio_start,
+				       current_drive->pos_audio_end);
+		else i=cc_Pause_Resume(3);
+		if (i<0) RETURN_UP(-EIO);
+		current_drive->audio_state=audio_playing;
+		RETURN_UP(0);
+		
+	case CDROMPLAYMSF:
+		msg(DBG_IOC,"ioctl: CDROMPLAYMSF entered.\n");
 #ifdef SAFE_MIXED
 		if (current_drive->has_data>1) RETURN_UP(-EBUSY);
-#endif /* SAFE_MIXED */
-		cc_ModeSelect(CD_FRAMESIZE);
-		cc_ModeSense();
-		current_drive->mode=READ_M1;
+#endif /* SAFE_MIXED */ 
+		if (current_drive->audio_state==audio_playing)
+		{
+			i=cc_Pause_Resume(1);
+			if (i<0) RETURN_UP(-EIO);
+			i=cc_ReadSubQ();
+			if (i<0) RETURN_UP(-EIO);
+			current_drive->pos_audio_start=current_drive->SubQ_run_tot;
+			i=cc_Seek(current_drive->pos_audio_start,1);
+		}
+		memcpy(&msf, (void *) arg, sizeof(struct cdrom_msf));
+		/* values come as msf-bin */
+		current_drive->pos_audio_start = (msf.cdmsf_min0<<16) |
+                        (msf.cdmsf_sec0<<8) |
+				msf.cdmsf_frame0;
+		current_drive->pos_audio_end = (msf.cdmsf_min1<<16) |
+			(msf.cdmsf_sec1<<8) |
+				msf.cdmsf_frame1;
+		msg(DBG_IOX,"ioctl: CDROMPLAYMSF %08X %08X\n",
+		    current_drive->pos_audio_start,current_drive->pos_audio_end);
+		i=cc_PlayAudio(current_drive->pos_audio_start,current_drive->pos_audio_end);
+		if (i<0)
+		{
+			msg(DBG_INF,"ioctl: cc_PlayAudio returns %d\n",i);
+			DriveReset();
+			current_drive->audio_state=0;
+			RETURN_UP(-EIO);
+		}
+		current_drive->audio_state=audio_playing;
 		RETURN_UP(0);
 		
-	case CDROMREADMODE2: /* not usable at the moment */
-		msg(DBG_IOC,"ioctl: CDROMREADMODE2 requested.\n");
+	case CDROMPLAYTRKIND: /* Play a track.  This currently ignores index. */
+		msg(DBG_IOC,"ioctl: CDROMPLAYTRKIND entered.\n");
 #ifdef SAFE_MIXED
 		if (current_drive->has_data>1) RETURN_UP(-EBUSY);
-#endif /* SAFE_MIXED */
-		cc_ModeSelect(CD_FRAMESIZE_RAW1);
-		cc_ModeSense();
-		current_drive->mode=READ_M2;
+#endif /* SAFE_MIXED */ 
+		if (current_drive->audio_state==audio_playing)
+		{
+			msg(DBG_IOX,"CDROMPLAYTRKIND: already audio_playing.\n");
+#if 1
+			RETURN_UP(0); /* just let us play on */
+#else
+			RETURN_UP(-EINVAL); /* play on, but say "error" */
+#endif
+		}
+		memcpy(&ti,(void *) arg,sizeof(struct cdrom_ti));
+		msg(DBG_IOX,"ioctl: trk0: %d, ind0: %d, trk1:%d, ind1:%d\n",
+		    ti.cdti_trk0,ti.cdti_ind0,ti.cdti_trk1,ti.cdti_ind1);
+		if (ti.cdti_trk0<current_drive->n_first_track) RETURN_UP(-EINVAL);
+		if (ti.cdti_trk0>current_drive->n_last_track) RETURN_UP(-EINVAL);
+		if (ti.cdti_trk1<ti.cdti_trk0) ti.cdti_trk1=ti.cdti_trk0;
+		if (ti.cdti_trk1>current_drive->n_last_track) ti.cdti_trk1=current_drive->n_last_track;
+		current_drive->pos_audio_start=current_drive->TocBuffer[ti.cdti_trk0].address;
+		current_drive->pos_audio_end=current_drive->TocBuffer[ti.cdti_trk1+1].address;
+		i=cc_PlayAudio(current_drive->pos_audio_start,current_drive->pos_audio_end);
+		if (i<0)
+		{
+			msg(DBG_INF,"ioctl: cc_PlayAudio returns %d\n",i);
+			DriveReset();
+			current_drive->audio_state=0;
+			RETURN_UP(-EIO);
+		}
+		current_drive->audio_state=audio_playing;
 		RETURN_UP(0);
 		
-	case CDROMAUDIOBUFSIZ: /* configure the audio buffer size */
-		msg(DBG_IOC,"ioctl: CDROMAUDIOBUFSIZ entered.\n");
-		if (current_drive->sbp_audsiz>0)
-			vfree(current_drive->aud_buf);
-		current_drive->aud_buf=NULL;
-		current_drive->sbp_audsiz=arg;
+	case CDROMREADTOCHDR:        /* Read the table of contents header */
+		msg(DBG_IOC,"ioctl: CDROMREADTOCHDR entered.\n");
+		tochdr.cdth_trk0=current_drive->n_first_track;
+		tochdr.cdth_trk1=current_drive->n_last_track;
+		memcpy((void *) arg, &tochdr, sizeof(struct cdrom_tochdr));
+		RETURN_UP(0);
 		
-		if (current_drive->sbp_audsiz>16)
-		{
-			current_drive->sbp_audsiz = 0;
-			RETURN_UP(current_drive->sbp_audsiz);
-		}
-	
-		if (current_drive->sbp_audsiz>0)
+	case CDROMREADTOCENTRY:      /* Read an entry in the table of contents */
+		msg(DBG_IOC,"ioctl: CDROMREADTOCENTRY entered.\n");
+		memcpy(&tocentry, (void *) arg, sizeof(struct cdrom_tocentry));
+		i=tocentry.cdte_track;
+		if (i==CDROM_LEADOUT) i=current_drive->n_last_track+1;
+		else if (i<current_drive->n_first_track||i>current_drive->n_last_track)
+                  RETURN_UP(-EINVAL);
+		tocentry.cdte_adr=current_drive->TocBuffer[i].ctl_adr&0x0F;
+		tocentry.cdte_ctrl=(current_drive->TocBuffer[i].ctl_adr>>4)&0x0F;
+		tocentry.cdte_datamode=current_drive->TocBuffer[i].format;
+		if (tocentry.cdte_format==CDROM_MSF) /* MSF-bin required */
 		{
-			current_drive->aud_buf=(u_char *) vmalloc(current_drive->sbp_audsiz*CD_FRAMESIZE_RAW);
-			if (current_drive->aud_buf==NULL)
-			{
-				msg(DBG_INF,"audio buffer (%d frames) not available.\n",current_drive->sbp_audsiz);
-				current_drive->sbp_audsiz=0;
-			}
-			else msg(DBG_INF,"audio buffer size: %d frames.\n",current_drive->sbp_audsiz);
+			tocentry.cdte_addr.msf.minute=(current_drive->TocBuffer[i].address>>16)&0x00FF;
+			tocentry.cdte_addr.msf.second=(current_drive->TocBuffer[i].address>>8)&0x00FF;
+			tocentry.cdte_addr.msf.frame=current_drive->TocBuffer[i].address&0x00FF;
 		}
-		RETURN_UP(current_drive->sbp_audsiz);
-
-	case CDROMREADAUDIO:
-	{ /* start of CDROMREADAUDIO */
-		int i=0, j=0, frame, block=0;
-		u_int try=0;
-		u_long timeout;
-		u_char *p;
-		u_int data_tries = 0;
-		u_int data_waits = 0;
-		u_int data_retrying = 0;
-		int status_tries;
-		int error_flag;
+		else if (tocentry.cdte_format==CDROM_LBA) /* blk required */
+			tocentry.cdte_addr.lba=msf2blk(current_drive->TocBuffer[i].address);
+		else RETURN_UP(-EINVAL);
+		memcpy((void *) arg, &tocentry, sizeof(struct cdrom_tocentry));
+		RETURN_UP(0);
 		
-		msg(DBG_IOC,"ioctl: CDROMREADAUDIO entered.\n");
-		if (fam0_drive) RETURN_UP(-EINVAL);
-		if (famL_drive) RETURN_UP(-EINVAL);
-		if (famV_drive) RETURN_UP(-EINVAL);
-		if (famT_drive) RETURN_UP(-EINVAL);
+	case CDROMSTOP:      /* Spin down the drive */
+		msg(DBG_IOC,"ioctl: CDROMSTOP entered.\n");
 #ifdef SAFE_MIXED
 		if (current_drive->has_data>1) RETURN_UP(-EBUSY);
 #endif /* SAFE_MIXED */ 
-		if (current_drive->aud_buf==NULL) RETURN_UP(-EINVAL);
-		if (copy_from_user(&read_audio, (void __user *)arg,
-				   sizeof(struct cdrom_read_audio)))
-			RETURN_UP(-EFAULT);
-		if (read_audio.nframes < 0 || read_audio.nframes>current_drive->sbp_audsiz) RETURN_UP(-EINVAL);
-		if (!access_ok(VERIFY_WRITE, read_audio.buf,
-			      read_audio.nframes*CD_FRAMESIZE_RAW))
-                	RETURN_UP(-EFAULT);
-		
-		if (read_audio.addr_format==CDROM_MSF) /* MSF-bin specification of where to start */
-			block=msf2lba(&read_audio.addr.msf.minute);
-		else if (read_audio.addr_format==CDROM_LBA) /* lba specification of where to start */
-			block=read_audio.addr.lba;
-		else RETURN_UP(-EINVAL);
-#if 000
-		i=cc_SetSpeed(speed_150,0,0);
-		if (i) msg(DBG_AUD,"read_audio: SetSpeed error %d\n", i);
+		i=cc_Pause_Resume(1);
+		current_drive->audio_state=0;
+#if 0
+		cc_DriveReset();
 #endif
-		msg(DBG_AUD,"read_audio: lba: %d, msf: %06X\n",
-		    block, blk2msf(block));
-		msg(DBG_AUD,"read_audio: before cc_ReadStatus.\n");
-#if OLD_BUSY
-		while (busy_data) sbp_sleep(HZ/10); /* wait a bit */
-		busy_audio=1;
-#endif /* OLD_BUSY */ 
-		error_flag=0;
-		for (data_tries=5; data_tries>0; data_tries--)
-		{
-			msg(DBG_AUD,"data_tries=%d ...\n", data_tries);
-			current_drive->mode=READ_AU;
-			cc_ModeSelect(CD_FRAMESIZE_RAW);
-			cc_ModeSense();
-			for (status_tries=3; status_tries > 0; status_tries--)
-			{
-				flags_cmd_out |= f_respo3;
-				cc_ReadStatus();
-				if (sbp_status() != 0) break;
-				if (st_check) cc_ReadError();
-				sbp_sleep(1);    /* wait a bit, try again */
-			}
-			if (status_tries == 0)
-			{
-				msg(DBG_AUD,"read_audio: sbp_status: failed after 3 tries in line %d.\n", __LINE__);
-				continue;
-			}
-			msg(DBG_AUD,"read_audio: sbp_status: ok.\n");
-			
-			flags_cmd_out = f_putcmd | f_respo2 | f_ResponseStatus | f_obey_p_check;
-			if (fam0L_drive)
-			{
-				flags_cmd_out |= f_lopsta | f_getsta | f_bit1;
-				cmd_type=READ_M2;
-				drvcmd[0]=CMD0_READ_XA; /* "read XA frames", old drives */
-				drvcmd[1]=(block>>16)&0x000000ff;
-				drvcmd[2]=(block>>8)&0x000000ff;
-				drvcmd[3]=block&0x000000ff;
-				drvcmd[4]=0;
-				drvcmd[5]=read_audio.nframes; /* # of frames */
-				drvcmd[6]=0;
-			}
-			else if (fam1_drive)
-			{
-				drvcmd[0]=CMD1_READ; /* "read frames", new drives */
-				lba2msf(block,&drvcmd[1]); /* msf-bin format required */
-				drvcmd[4]=0;
-				drvcmd[5]=0;
-				drvcmd[6]=read_audio.nframes; /* # of frames */
+		RETURN_UP(i);
+		
+	case CDROMSTART:  /* Spin up the drive */
+		msg(DBG_IOC,"ioctl: CDROMSTART entered.\n");
+		cc_SpinUp();
+		current_drive->audio_state=0;
+		RETURN_UP(0);
+		
+	case CDROMVOLCTRL:   /* Volume control */
+		msg(DBG_IOC,"ioctl: CDROMVOLCTRL entered.\n");
+		memcpy(&volctrl,(char *) arg,sizeof(volctrl));
+		current_drive->vol_chan0=0;
+		current_drive->vol_ctrl0=volctrl.channel0;
+		current_drive->vol_chan1=1;
+		current_drive->vol_ctrl1=volctrl.channel1;
+		i=cc_SetVolume();
+		RETURN_UP(0);
+		
+	case CDROMVOLREAD:   /* read Volume settings from drive */
+		msg(DBG_IOC,"ioctl: CDROMVOLREAD entered.\n");
+		st=cc_GetVolume();
+		if (st<0) RETURN_UP(st);
+		volctrl.channel0=current_drive->vol_ctrl0;
+		volctrl.channel1=current_drive->vol_ctrl1;
+		volctrl.channel2=0;
+		volctrl.channel2=0;
+		memcpy((void *)arg,&volctrl,sizeof(volctrl));
+		RETURN_UP(0);
+
+	case CDROMSUBCHNL:   /* Get subchannel info */
+		msg(DBG_IOS,"ioctl: CDROMSUBCHNL entered.\n");
+		/* Bogus, I can do better than this! --AJK
+		if ((st_spinning)||(!subq_valid)) {
+			i=cc_ReadSubQ();
+			if (i<0) RETURN_UP(-EIO);
+		}
+		*/
+		i=cc_ReadSubQ();
+		if (i<0) {
+			j=cc_ReadError(); /* clear out error status from drive */
+			current_drive->audio_state=CDROM_AUDIO_NO_STATUS;
+			/* get and set the disk state here, 
+			probably not the right place, but who cares!
+			It makes it work properly! --AJK */
+			if (current_drive->CD_changed==0xFF) {
+				msg(DBG_000,"Disk changed detect\n");
+				current_drive->diskstate_flags &= ~cd_size_bit;
 			}
-			else if (fam2_drive)
-			{
-				drvcmd[0]=CMD2_READ_XA2;
-				lba2msf(block,&drvcmd[1]); /* msf-bin format required */
-				drvcmd[4]=0;
-				drvcmd[5]=read_audio.nframes; /* # of frames */
-				drvcmd[6]=0x11; /* raw mode */
+			RETURN_UP(-EIO);
+		}
+		if (current_drive->CD_changed==0xFF) {
+			/* reread the TOC because the disk has changed! --AJK */
+			msg(DBG_000,"Disk changed STILL detected, rereading TOC!\n");
+			i=DiskInfo();
+			if(i==0) {
+				current_drive->CD_changed=0x00; /* cd has changed, procede, */
+				RETURN_UP(-EIO); /* and get TOC, etc on next try! --AJK */
+			} else {
+				RETURN_UP(-EIO); /* we weren't ready yet! --AJK */
 			}
-			else if (famT_drive) /* CD-55A: not tested yet */
-			{
+		}
+		memcpy(&SC, (void *) arg, sizeof(struct cdrom_subchnl));
+		/* 
+			This virtual crap is very bogus! 
+			It doesn't detect when the cd is done playing audio!
+			Lets do this right with proper hardware register reading!
+		*/
+		cc_ReadStatus();
+		i=ResponseStatus();
+		msg(DBG_000,"Drive Status: door_locked =%d.\n", st_door_locked);
+		msg(DBG_000,"Drive Status: door_closed =%d.\n", st_door_closed);
+		msg(DBG_000,"Drive Status: caddy_in =%d.\n", st_caddy_in);
+		msg(DBG_000,"Drive Status: disk_ok =%d.\n", st_diskok);
+		msg(DBG_000,"Drive Status: spinning =%d.\n", st_spinning);
+		msg(DBG_000,"Drive Status: busy =%d.\n", st_busy);
+		/* st_busy indicates if it's _ACTUALLY_ playing audio */
+		switch (current_drive->audio_state)
+		{
+		case audio_playing:
+			if(st_busy==0) {
+				/* CD has stopped playing audio --AJK */
+				current_drive->audio_state=audio_completed;
+				SC.cdsc_audiostatus=CDROM_AUDIO_COMPLETED;
+			} else {
+				SC.cdsc_audiostatus=CDROM_AUDIO_PLAY;
 			}
-			msg(DBG_AUD,"read_audio: before giving \"read\" command.\n");
-			flags_cmd_out=f_putcmd;
-			response_count=0;
-			i=cmd_out();
-			if (i<0) msg(DBG_INF,"error giving READ AUDIO command: %0d\n", i);
-			sbp_sleep(0);
-			msg(DBG_AUD,"read_audio: after giving \"read\" command.\n");
-			for (frame=1;frame<2 && !error_flag; frame++)
-			{
-				try=maxtim_data;
-				for (timeout=jiffies+9*HZ; ; )
-				{
-					for ( ; try!=0;try--)
-					{
-						j=inb(CDi_status);
-						if (!(j&s_not_data_ready)) break;
-						if (!(j&s_not_result_ready)) break;
-						if (fam0L_drive) if (j&s_attention) break;
-					}
-					if (try != 0 || time_after_eq(jiffies, timeout)) break;
-					if (data_retrying == 0) data_waits++;
-					data_retrying = 1;
-					sbp_sleep(1);
-					try = 1;
-				}
-				if (try==0)
-				{
-					msg(DBG_INF,"read_audio: sbp_data: CDi_status timeout.\n");
-					error_flag++;
-					break;
-				}
-				msg(DBG_AUD,"read_audio: sbp_data: CDi_status ok.\n");
-				if (j&s_not_data_ready)
-				{
-					msg(DBG_INF, "read_audio: sbp_data: DATA_READY timeout.\n");
-					error_flag++;
-					break;
-				}
-				msg(DBG_AUD,"read_audio: before reading data.\n");
-				error_flag=0;
-				p = current_drive->aud_buf;
-				if (sbpro_type==1) OUT(CDo_sel_i_d,1);
-				if (do_16bit)
-				{
-					u_short *p2 = (u_short *) p;
+			break;
+		case audio_pausing:
+			SC.cdsc_audiostatus=CDROM_AUDIO_PAUSED;
+			break;
+		case audio_completed:
+			SC.cdsc_audiostatus=CDROM_AUDIO_COMPLETED;
+			break;
+		default:
+			SC.cdsc_audiostatus=CDROM_AUDIO_NO_STATUS;
+			break;
+		}
+		SC.cdsc_adr=current_drive->SubQ_ctl_adr;
+		SC.cdsc_ctrl=current_drive->SubQ_ctl_adr>>4;
+		SC.cdsc_trk=bcd2bin(current_drive->SubQ_trk);
+		SC.cdsc_ind=bcd2bin(current_drive->SubQ_pnt_idx);
+		if (SC.cdsc_format==CDROM_LBA)
+		{
+			SC.cdsc_absaddr.lba=msf2blk(current_drive->SubQ_run_tot);
+			SC.cdsc_reladdr.lba=msf2blk(current_drive->SubQ_run_trk);
+		}
+		else /* not only if (SC.cdsc_format==CDROM_MSF) */
+		{
+			SC.cdsc_absaddr.msf.minute=(current_drive->SubQ_run_tot>>16)&0x00FF;
+			SC.cdsc_absaddr.msf.second=(current_drive->SubQ_run_tot>>8)&0x00FF;
+			SC.cdsc_absaddr.msf.frame=current_drive->SubQ_run_tot&0x00FF;
+			SC.cdsc_reladdr.msf.minute=(current_drive->SubQ_run_trk>>16)&0x00FF;
+			SC.cdsc_reladdr.msf.second=(current_drive->SubQ_run_trk>>8)&0x00FF;
+			SC.cdsc_reladdr.msf.frame=current_drive->SubQ_run_trk&0x00FF;
+		}
+		memcpy((void *) arg, &SC, sizeof(struct cdrom_subchnl));
+		msg(DBG_IOS,"CDROMSUBCHNL: %1X %02X %08X %08X %02X %02X %06X %06X\n",
+		    SC.cdsc_format,SC.cdsc_audiostatus,
+		    SC.cdsc_adr,SC.cdsc_ctrl,
+		    SC.cdsc_trk,SC.cdsc_ind,
+		    SC.cdsc_absaddr,SC.cdsc_reladdr);
+		RETURN_UP(0);
+		
+	default:
+		msg(DBG_IOC,"ioctl: unknown function request %04X\n", cmd);
+		RETURN_UP(-EINVAL);
+	} /* end switch(cmd) */
+}
+/*==========================================================================*/
+/*
+ *  Take care of the different block sizes between cdrom and Linux.
+ */
+static void sbp_transfer(struct request *req)
+{
+	long offs;
+	
+	while ( (req->nr_sectors > 0) &&
+	       (req->sector/4 >= current_drive->sbp_first_frame) &&
+	       (req->sector/4 <= current_drive->sbp_last_frame) )
+	{
+		offs = (req->sector - current_drive->sbp_first_frame * 4) * 512;
+		memcpy(req->buffer, current_drive->sbp_buf + offs, 512);
+		req->nr_sectors--;
+		req->sector++;
+		req->buffer += 512;
+	}
+}
+/*==========================================================================*/
+/*
+ *  special end_request for sbpcd to solve CURRENT==NULL bug. (GTL)
+ *  GTL = Gonzalo Tornaria <tornaria@cmat.edu.uy>
+ *
+ *  This is a kludge so we don't need to modify end_request.
+ *  We put the req we take out after INIT_REQUEST in the requests list,
+ *  so that end_request will discard it. 
+ *
+ *  The bug could be present in other block devices, perhaps we
+ *  should modify INIT_REQUEST and end_request instead, and
+ *  change every block device.. 
+ *
+ *  Could be a race here?? Could e.g. a timer interrupt schedule() us?
+ *  If so, we should copy end_request here, and do it right.. (or
+ *  modify end_request and the block devices).
+ *
+ *  In any case, the race here would be much small than it was, and
+ *  I couldn't reproduce..
+ *
+ *  The race could be: suppose CURRENT==NULL. We put our req in the list,
+ *  and we are scheduled. Other process takes over, and gets into
+ *  do_sbpcd_request. It sees CURRENT!=NULL (it is == to our req), so
+ *  proceeds. It ends, so CURRENT is now NULL.. Now we awake somewhere in
+ *  end_request, but now CURRENT==NULL... oops!
+ *
+ */
+#undef DEBUG_GTL
 
-					for (; (u_char *) p2 < current_drive->aud_buf + read_audio.nframes*CD_FRAMESIZE_RAW;)
-				  	{
-						if ((inb_p(CDi_status)&s_not_data_ready)) continue;
+/*==========================================================================*/
+/*
+ *  I/O request routine, called from Linux kernel.
+ */
+static void do_sbpcd_request(request_queue_t * q)
+{
+	u_int block;
+	u_int nsect;
+	int status_tries, data_tries;
+	struct request *req;
+	struct sbpcd_drive *p;
+#ifdef DEBUG_GTL
+	static int xx_nr=0;
+	int xnr;
+#endif
 
-						/* get one sample */
-						*p2++ = inw_p(CDi_data);
-						*p2++ = inw_p(CDi_data);
-					}
-				} else {
-					for (; p < current_drive->aud_buf + read_audio.nframes*CD_FRAMESIZE_RAW;)
-				  	{
-						if ((inb_p(CDi_status)&s_not_data_ready)) continue;
+ request_loop:
+#ifdef DEBUG_GTL
+	xnr=++xx_nr;
 
-						/* get one sample */
-						*p++ = inb_p(CDi_data);
-						*p++ = inb_p(CDi_data);
-						*p++ = inb_p(CDi_data);
-						*p++ = inb_p(CDi_data);
-					}
-				}
-				if (sbpro_type==1) OUT(CDo_sel_i_d,0);
-				data_retrying = 0;
-			}
-			msg(DBG_AUD,"read_audio: after reading data.\n");
-			if (error_flag)    /* must have been spurious D_RDY or (ATTN&&!D_RDY) */
-			{
-				msg(DBG_AUD,"read_audio: read aborted by drive\n");
-#if 0000
-				i=cc_DriveReset();                /* ugly fix to prevent a hang */
-#else
-				i=cc_ReadError();
+	req = elv_next_request(q);
+
+	if (!req)
+	{
+		printk( "do_sbpcd_request[%di](NULL), Pid:%d, Time:%li\n",
+			xnr, current->pid, jiffies);
+		printk( "do_sbpcd_request[%do](NULL) end 0 (null), Time:%li\n",
+			xnr, jiffies);
+		return;
+	}
+
+	printk(" do_sbpcd_request[%di](%p:%ld+%ld), Pid:%d, Time:%li\n",
+		xnr, req, req->sector, req->nr_sectors, current->pid, jiffies);
 #endif
-				continue;
-			}
-			if (fam0L_drive)
-			{
-				i=maxtim_data;
-				for (timeout=jiffies+9*HZ; time_before(jiffies, timeout); timeout--)
-				{
-					for ( ;i!=0;i--)
-					{
-						j=inb(CDi_status);
-						if (!(j&s_not_data_ready)) break;
-						if (!(j&s_not_result_ready)) break;
-						if (j&s_attention) break;
-					}
-					if (i != 0 || time_after_eq(jiffies, timeout)) break;
-					sbp_sleep(0);
-					i = 1;
-				}
-				if (i==0) msg(DBG_AUD,"read_audio: STATUS TIMEOUT AFTER READ");
-				if (!(j&s_attention))
-				{
-					msg(DBG_AUD,"read_audio: sbp_data: timeout waiting DRV_ATTN - retrying\n");
-					i=cc_DriveReset();  /* ugly fix to prevent a hang */
-					continue;
-				}
-			}
-			do
-			{
-				if (fam0L_drive) cc_ReadStatus();
-				i=ResponseStatus();  /* builds status_bits, returns orig. status (old) or faked p_success (new) */
-				if (i<0) { msg(DBG_AUD,
-					       "read_audio: cc_ReadStatus error after read: %02X\n",
-					       current_drive->status_bits);
-					   continue; /* FIXME */
-				   }
-			}
-			while ((fam0L_drive)&&(!st_check)&&(!(i&p_success)));
-			if (st_check)
-			{
-				i=cc_ReadError();
-				msg(DBG_AUD,"read_audio: cc_ReadError was necessary after read: %02X\n",i);
-				continue;
-			}
-			if (copy_to_user(read_audio.buf,
-					 current_drive->aud_buf,
-					 read_audio.nframes * CD_FRAMESIZE_RAW))
-				RETURN_UP(-EFAULT);
-			msg(DBG_AUD,"read_audio: copy_to_user done.\n");
-			break;
+
+	req = elv_next_request(q);	/* take out our request so no other */
+	if (!req)
+		return;
+
+	if (req -> sector == -1)
+		end_request(req, 0);
+	spin_unlock_irq(q->queue_lock);
+
+	down(&ioctl_read_sem);
+	if (rq_data_dir(elv_next_request(q)) != READ)
+	{
+		msg(DBG_INF, "bad cmd %d\n", req->cmd[0]);
+		goto err_done;
+	}
+	p = req->rq_disk->private_data;
+#if OLD_BUSY
+	while (busy_audio) sbp_sleep(HZ); /* wait a bit */
+	busy_data=1;
+#endif /* OLD_BUSY */
+	
+	if (p->audio_state==audio_playing) goto err_done;
+	if (p != current_drive)
+		switch_drive(p);
+
+	block = req->sector; /* always numbered as 512-byte-pieces */
+	nsect = req->nr_sectors; /* always counted as 512-byte-pieces */
+	
+	msg(DBG_BSZ,"read sector %d (%d sectors)\n", block, nsect);
+#if 0
+	msg(DBG_MUL,"read LBA %d\n", block/4);
+#endif
+	
+	sbp_transfer(req);
+	/* if we satisfied the request from the buffer, we're done. */
+	if (req->nr_sectors == 0)
+	{
+#ifdef DEBUG_GTL
+		printk(" do_sbpcd_request[%do](%p:%ld+%ld) end 2, Time:%li\n",
+			xnr, req, req->sector, req->nr_sectors, jiffies);
+#endif
+		up(&ioctl_read_sem);
+		spin_lock_irq(q->queue_lock);
+		end_request(req, 1);
+		goto request_loop;
+	}
+
+#ifdef FUTURE
+	i=prepare(0,0); /* at moment not really a hassle check, but ... */
+	if (i!=0)
+		msg(DBG_INF,"\"prepare\" tells error %d -- ignored\n", i);
+#endif /* FUTURE */ 
+	
+	if (!st_spinning) cc_SpinUp();
+	
+	for (data_tries=n_retries; data_tries > 0; data_tries--)
+	{
+		for (status_tries=3; status_tries > 0; status_tries--)
+		{
+			flags_cmd_out |= f_respo3;
+			cc_ReadStatus();
+			if (sbp_status() != 0) break;
+			if (st_check) cc_ReadError();
+			sbp_sleep(1);    /* wait a bit, try again */
 		}
-		cc_ModeSelect(CD_FRAMESIZE);
-		cc_ModeSense();
-		current_drive->mode=READ_M1;
-#if OLD_BUSY
-		busy_audio=0;
-#endif /* OLD_BUSY */ 
-		if (data_tries == 0)
+		if (status_tries == 0)
 		{
-			msg(DBG_AUD,"read_audio: failed after 5 tries in line %d.\n", __LINE__);
-			RETURN_UP(-EIO);
+			msg(DBG_INF,"sbp_status: failed after 3 tries in line %d\n", __LINE__);
+			break;
 		}
-		msg(DBG_AUD,"read_audio: successful return.\n");
-		RETURN_UP(0);
-	} /* end of CDROMREADAUDIO */
 		
-	default:
-		msg(DBG_IOC,"ioctl: unknown function request %04X\n", cmd);
-		RETURN_UP(-EINVAL);
-	} /* end switch(cmd) */
+		sbp_read_cmd(req);
+		sbp_sleep(0);
+		if (sbp_data(req) != 0)
+		{
+#ifdef SAFE_MIXED
+			current_drive->has_data=2; /* is really a data disk */
+#endif /* SAFE_MIXED */ 
+#ifdef DEBUG_GTL
+			printk(" do_sbpcd_request[%do](%p:%ld+%ld) end 3, Time:%li\n",
+				xnr, req, req->sector, req->nr_sectors, jiffies);
+#endif
+			up(&ioctl_read_sem);
+			spin_lock_irq(q->queue_lock);
+			end_request(req, 1);
+			goto request_loop;
+		}
+	}
+	
+ err_done:
+#if OLD_BUSY
+	busy_data=0;
+#endif /* OLD_BUSY */
+#ifdef DEBUG_GTL
+	printk(" do_sbpcd_request[%do](%p:%ld+%ld) end 4 (error), Time:%li\n",
+		xnr, req, req->sector, req->nr_sectors, jiffies);
+#endif
+	up(&ioctl_read_sem);
+	sbp_sleep(0);    /* wait a bit, try again */
+	spin_lock_irq(q->queue_lock);
+	end_request(req, 0);
+	goto request_loop;
 }
-
-static int sbpcd_audio_ioctl(struct cdrom_device_info *cdi, u_int cmd,
-		       void * arg)
+/*==========================================================================*/
+/*
+ *  build and send the READ command.
+ */
+static void sbp_read_cmd(struct request *req)
 {
-	struct sbpcd_drive *p = cdi->handle;
-	int i, st, j;
+#undef OLD
+
+	int i;
+	int block;
 	
-	msg(DBG_IO2,"ioctl(%s, 0x%08lX, 0x%08p)\n", cdi->name, cmd, arg);
-	if (p->drv_id==-1) {
-		msg(DBG_INF, "ioctl: bad device: %s\n", cdi->name);
-		return (-ENXIO);             /* no such drive */
+	current_drive->sbp_first_frame=current_drive->sbp_last_frame=-1;      /* purge buffer */
+	current_drive->sbp_current = 0;
+	block=req->sector/4;
+	if (block+current_drive->sbp_bufsiz <= current_drive->CDsize_frm)
+		current_drive->sbp_read_frames = current_drive->sbp_bufsiz;
+	else
+	{
+		current_drive->sbp_read_frames=current_drive->CDsize_frm-block;
+		/* avoid reading past end of data */
+		if (current_drive->sbp_read_frames < 1)
+		{
+			msg(DBG_INF,"requested frame %d, CD size %d ???\n",
+			    block, current_drive->CDsize_frm);
+			current_drive->sbp_read_frames=1;
+		}
 	}
-	down(&ioctl_read_sem);
-	if (p != current_drive)
-		switch_drive(p);
 	
-	msg(DBG_IO2,"ioctl: device %s, request %04X\n",cdi->name,cmd);
-	switch (cmd) 		/* Sun-compatible */
+	flags_cmd_out = f_putcmd | f_respo2 | f_ResponseStatus | f_obey_p_check;
+	clr_cmdbuf();
+	if (famV_drive)
+	  {
+	    drvcmd[0]=CMDV_READ;
+	    lba2msf(block,&drvcmd[1]); /* msf-bcd format required */
+	    bin2bcdx(&drvcmd[1]);
+	    bin2bcdx(&drvcmd[2]);
+	    bin2bcdx(&drvcmd[3]);
+	    drvcmd[4]=current_drive->sbp_read_frames>>8;
+	    drvcmd[5]=current_drive->sbp_read_frames&0xff;
+	    drvcmd[6]=0x02; /* flag "msf-bcd" */
+	}
+	else if (fam0L_drive)
 	{
-		
-	case CDROMPAUSE:     /* Pause the drive */
-		msg(DBG_IOC,"ioctl: CDROMPAUSE entered.\n");
-		/* pause the drive unit when it is currently in PLAY mode,         */
-		/* or reset the starting and ending locations when in PAUSED mode. */
-		/* If applicable, at the next stopping point it reaches            */
-		/* the drive will discontinue playing.                             */
-		switch (current_drive->audio_state)
+		flags_cmd_out |= f_lopsta | f_getsta | f_bit1;
+		if (current_drive->xa_byte==0x20)
 		{
-		case audio_playing:
-			if (famL_drive) i=cc_ReadSubQ();
-			else i=cc_Pause_Resume(1);
-			if (i<0) RETURN_UP(-EIO);
-			if (famL_drive) i=cc_Pause_Resume(1);
-			else i=cc_ReadSubQ();
-			if (i<0) RETURN_UP(-EIO);
-			current_drive->pos_audio_start=current_drive->SubQ_run_tot;
-			current_drive->audio_state=audio_pausing;
-			RETURN_UP(0);
-		case audio_pausing:
-			i=cc_Seek(current_drive->pos_audio_start,1);
-			if (i<0) RETURN_UP(-EIO);
-			RETURN_UP(0);
-		default:
-			RETURN_UP(-EINVAL);
+			cmd_type=READ_M2;
+			drvcmd[0]=CMD0_READ_XA; /* "read XA frames", old drives */
+			drvcmd[1]=(block>>16)&0x0ff;
+			drvcmd[2]=(block>>8)&0x0ff;
+			drvcmd[3]=block&0x0ff;
+			drvcmd[4]=(current_drive->sbp_read_frames>>8)&0x0ff;
+			drvcmd[5]=current_drive->sbp_read_frames&0x0ff;
 		}
+		else
+		{
+			drvcmd[0]=CMD0_READ; /* "read frames", old drives */
+			if (current_drive->drv_type>=drv_201)
+			{
+				lba2msf(block,&drvcmd[1]); /* msf-bcd format required */
+				bin2bcdx(&drvcmd[1]);
+				bin2bcdx(&drvcmd[2]);
+				bin2bcdx(&drvcmd[3]);
+			}
+			else
+			{
+				drvcmd[1]=(block>>16)&0x0ff;
+				drvcmd[2]=(block>>8)&0x0ff;
+				drvcmd[3]=block&0x0ff;
+			}
+			drvcmd[4]=(current_drive->sbp_read_frames>>8)&0x0ff;
+			drvcmd[5]=current_drive->sbp_read_frames&0x0ff;
+			drvcmd[6]=(current_drive->drv_type<drv_201)?0:2; /* flag "lba or msf-bcd format" */
+		}
+	}
+	else if (fam1_drive)
+	{
+		drvcmd[0]=CMD1_READ;
+		lba2msf(block,&drvcmd[1]); /* msf-bin format required */
+		drvcmd[5]=(current_drive->sbp_read_frames>>8)&0x0ff;
+		drvcmd[6]=current_drive->sbp_read_frames&0x0ff;
+	}
+	else if (fam2_drive)
+	{
+		drvcmd[0]=CMD2_READ;
+		lba2msf(block,&drvcmd[1]); /* msf-bin format required */
+		drvcmd[4]=(current_drive->sbp_read_frames>>8)&0x0ff;
+		drvcmd[5]=current_drive->sbp_read_frames&0x0ff;
+		drvcmd[6]=0x02;
+	}
+	else if (famT_drive)
+	{
+		drvcmd[0]=CMDT_READ;
+		drvcmd[2]=(block>>24)&0x0ff;
+		drvcmd[3]=(block>>16)&0x0ff;
+		drvcmd[4]=(block>>8)&0x0ff;
+		drvcmd[5]=block&0x0ff;
+		drvcmd[7]=(current_drive->sbp_read_frames>>8)&0x0ff;
+		drvcmd[8]=current_drive->sbp_read_frames&0x0ff;
+	}
+	flags_cmd_out=f_putcmd;
+	response_count=0;
+	i=cmd_out();
+	if (i<0) msg(DBG_INF,"error giving READ command: %0d\n", i);
+	return;
+}
+/*==========================================================================*/
+/*
+ *  Check the completion of the read-data command.  On success, read
+ *  the current_drive->sbp_bufsiz * 2048 bytes of data from the disk into buffer.
+ */
+static int sbp_data(struct request *req)
+{
+	int i=0, j=0, l, frame;
+	u_int try=0;
+	u_long timeout;
+	u_char *p;
+	u_int data_tries = 0;
+	u_int data_waits = 0;
+	u_int data_retrying = 0;
+	int error_flag;
+	int xa_count;
+	int max_latency;
+	int success;
+	int wait;
+	int duration;
+	
+	error_flag=0;
+	success=0;
+#if LONG_TIMING
+	max_latency=9*HZ;
+#else
+	if (current_drive->f_multisession) max_latency=15*HZ;
+	else max_latency=5*HZ;
+#endif
+	duration=jiffies;
+	for (frame=0;frame<current_drive->sbp_read_frames&&!error_flag; frame++)
+	{
+		SBPCD_CLI;
 		
-	case CDROMRESUME: /* resume paused audio play */
-		msg(DBG_IOC,"ioctl: CDROMRESUME entered.\n");
-		/* resume playing audio tracks when a previous PLAY AUDIO call has  */
-		/* been paused with a PAUSE command.                                */
-		/* It will resume playing from the location saved in SubQ_run_tot.  */
-		if (current_drive->audio_state!=audio_pausing) RETURN_UP(-EINVAL);
-		if (famL_drive)
-			i=cc_PlayAudio(current_drive->pos_audio_start,
-				       current_drive->pos_audio_end);
-		else i=cc_Pause_Resume(3);
-		if (i<0) RETURN_UP(-EIO);
-		current_drive->audio_state=audio_playing;
-		RETURN_UP(0);
-		
-	case CDROMPLAYMSF:
-		msg(DBG_IOC,"ioctl: CDROMPLAYMSF entered.\n");
-#ifdef SAFE_MIXED
-		if (current_drive->has_data>1) RETURN_UP(-EBUSY);
-#endif /* SAFE_MIXED */ 
-		if (current_drive->audio_state==audio_playing)
+		del_timer(&data_timer);
+		data_timer.expires=jiffies+max_latency;
+		timed_out_data=0;
+		add_timer(&data_timer);
+		while (!timed_out_data) 
 		{
-			i=cc_Pause_Resume(1);
-			if (i<0) RETURN_UP(-EIO);
-			i=cc_ReadSubQ();
-			if (i<0) RETURN_UP(-EIO);
-			current_drive->pos_audio_start=current_drive->SubQ_run_tot;
-			i=cc_Seek(current_drive->pos_audio_start,1);
+			if (current_drive->f_multisession) try=maxtim_data*4;
+			else try=maxtim_data;
+			msg(DBG_000,"sbp_data: CDi_status loop: try=%d.\n",try);
+			for ( ; try!=0;try--)
+			{
+				j=inb(CDi_status);
+				if (!(j&s_not_data_ready)) break;
+				if (!(j&s_not_result_ready)) break;
+				if (fam0LV_drive) if (j&s_attention) break;
+			}
+			if (!(j&s_not_data_ready)) goto data_ready;
+			if (try==0)
+			{
+				if (data_retrying == 0) data_waits++;
+				data_retrying = 1;
+				msg(DBG_000,"sbp_data: CDi_status loop: sleeping.\n");
+				sbp_sleep(1);
+				try = 1;
+			}
 		}
-		memcpy(&msf, (void *) arg, sizeof(struct cdrom_msf));
-		/* values come as msf-bin */
-		current_drive->pos_audio_start = (msf.cdmsf_min0<<16) |
-                        (msf.cdmsf_sec0<<8) |
-				msf.cdmsf_frame0;
-		current_drive->pos_audio_end = (msf.cdmsf_min1<<16) |
-			(msf.cdmsf_sec1<<8) |
-				msf.cdmsf_frame1;
-		msg(DBG_IOX,"ioctl: CDROMPLAYMSF %08X %08X\n",
-		    current_drive->pos_audio_start,current_drive->pos_audio_end);
-		i=cc_PlayAudio(current_drive->pos_audio_start,current_drive->pos_audio_end);
-		if (i<0)
+		msg(DBG_INF,"sbp_data: CDi_status loop expired.\n");
+	data_ready:
+		del_timer(&data_timer);
+
+		if (timed_out_data)
 		{
-			msg(DBG_INF,"ioctl: cc_PlayAudio returns %d\n",i);
-			DriveReset();
-			current_drive->audio_state=0;
-			RETURN_UP(-EIO);
+			msg(DBG_INF,"sbp_data: CDi_status timeout (timed_out_data) (%02X).\n", j);
+			error_flag++;
 		}
-		current_drive->audio_state=audio_playing;
-		RETURN_UP(0);
-		
-	case CDROMPLAYTRKIND: /* Play a track.  This currently ignores index. */
-		msg(DBG_IOC,"ioctl: CDROMPLAYTRKIND entered.\n");
-#ifdef SAFE_MIXED
-		if (current_drive->has_data>1) RETURN_UP(-EBUSY);
-#endif /* SAFE_MIXED */ 
-		if (current_drive->audio_state==audio_playing)
+		if (try==0)
 		{
-			msg(DBG_IOX,"CDROMPLAYTRKIND: already audio_playing.\n");
-#if 1
-			RETURN_UP(0); /* just let us play on */
-#else
-			RETURN_UP(-EINVAL); /* play on, but say "error" */
-#endif
+			msg(DBG_INF,"sbp_data: CDi_status timeout (try=0) (%02X).\n", j);
+			error_flag++;
 		}
-		memcpy(&ti,(void *) arg,sizeof(struct cdrom_ti));
-		msg(DBG_IOX,"ioctl: trk0: %d, ind0: %d, trk1:%d, ind1:%d\n",
-		    ti.cdti_trk0,ti.cdti_ind0,ti.cdti_trk1,ti.cdti_ind1);
-		if (ti.cdti_trk0<current_drive->n_first_track) RETURN_UP(-EINVAL);
-		if (ti.cdti_trk0>current_drive->n_last_track) RETURN_UP(-EINVAL);
-		if (ti.cdti_trk1<ti.cdti_trk0) ti.cdti_trk1=ti.cdti_trk0;
-		if (ti.cdti_trk1>current_drive->n_last_track) ti.cdti_trk1=current_drive->n_last_track;
-		current_drive->pos_audio_start=current_drive->TocBuffer[ti.cdti_trk0].address;
-		current_drive->pos_audio_end=current_drive->TocBuffer[ti.cdti_trk1+1].address;
-		i=cc_PlayAudio(current_drive->pos_audio_start,current_drive->pos_audio_end);
-		if (i<0)
+		if (!(j&s_not_result_ready))
 		{
-			msg(DBG_INF,"ioctl: cc_PlayAudio returns %d\n",i);
-			DriveReset();
-			current_drive->audio_state=0;
-			RETURN_UP(-EIO);
+			msg(DBG_INF, "sbp_data: RESULT_READY where DATA_READY awaited (%02X).\n", j);
+			response_count=20;
+			j=ResponseInfo();
+			j=inb(CDi_status);
 		}
-		current_drive->audio_state=audio_playing;
-		RETURN_UP(0);
-		
-	case CDROMREADTOCHDR:        /* Read the table of contents header */
-		msg(DBG_IOC,"ioctl: CDROMREADTOCHDR entered.\n");
-		tochdr.cdth_trk0=current_drive->n_first_track;
-		tochdr.cdth_trk1=current_drive->n_last_track;
-		memcpy((void *) arg, &tochdr, sizeof(struct cdrom_tochdr));
-		RETURN_UP(0);
-		
-	case CDROMREADTOCENTRY:      /* Read an entry in the table of contents */
-		msg(DBG_IOC,"ioctl: CDROMREADTOCENTRY entered.\n");
-		memcpy(&tocentry, (void *) arg, sizeof(struct cdrom_tocentry));
-		i=tocentry.cdte_track;
-		if (i==CDROM_LEADOUT) i=current_drive->n_last_track+1;
-		else if (i<current_drive->n_first_track||i>current_drive->n_last_track)
-                  RETURN_UP(-EINVAL);
-		tocentry.cdte_adr=current_drive->TocBuffer[i].ctl_adr&0x0F;
-		tocentry.cdte_ctrl=(current_drive->TocBuffer[i].ctl_adr>>4)&0x0F;
-		tocentry.cdte_datamode=current_drive->TocBuffer[i].format;
-		if (tocentry.cdte_format==CDROM_MSF) /* MSF-bin required */
+		if (j&s_not_data_ready)
 		{
-			tocentry.cdte_addr.msf.minute=(current_drive->TocBuffer[i].address>>16)&0x00FF;
-			tocentry.cdte_addr.msf.second=(current_drive->TocBuffer[i].address>>8)&0x00FF;
-			tocentry.cdte_addr.msf.frame=current_drive->TocBuffer[i].address&0x00FF;
-		}
-		else if (tocentry.cdte_format==CDROM_LBA) /* blk required */
-			tocentry.cdte_addr.lba=msf2blk(current_drive->TocBuffer[i].address);
-		else RETURN_UP(-EINVAL);
-		memcpy((void *) arg, &tocentry, sizeof(struct cdrom_tocentry));
-		RETURN_UP(0);
-		
-	case CDROMSTOP:      /* Spin down the drive */
-		msg(DBG_IOC,"ioctl: CDROMSTOP entered.\n");
-#ifdef SAFE_MIXED
-		if (current_drive->has_data>1) RETURN_UP(-EBUSY);
-#endif /* SAFE_MIXED */ 
-		i=cc_Pause_Resume(1);
-		current_drive->audio_state=0;
-#if 0
-		cc_DriveReset();
-#endif
-		RETURN_UP(i);
-		
-	case CDROMSTART:  /* Spin up the drive */
-		msg(DBG_IOC,"ioctl: CDROMSTART entered.\n");
-		cc_SpinUp();
-		current_drive->audio_state=0;
-		RETURN_UP(0);
-		
-	case CDROMVOLCTRL:   /* Volume control */
-		msg(DBG_IOC,"ioctl: CDROMVOLCTRL entered.\n");
-		memcpy(&volctrl,(char *) arg,sizeof(volctrl));
-		current_drive->vol_chan0=0;
-		current_drive->vol_ctrl0=volctrl.channel0;
-		current_drive->vol_chan1=1;
-		current_drive->vol_ctrl1=volctrl.channel1;
-		i=cc_SetVolume();
-		RETURN_UP(0);
-		
-	case CDROMVOLREAD:   /* read Volume settings from drive */
-		msg(DBG_IOC,"ioctl: CDROMVOLREAD entered.\n");
-		st=cc_GetVolume();
-		if (st<0) RETURN_UP(st);
-		volctrl.channel0=current_drive->vol_ctrl0;
-		volctrl.channel1=current_drive->vol_ctrl1;
-		volctrl.channel2=0;
-		volctrl.channel2=0;
-		memcpy((void *)arg,&volctrl,sizeof(volctrl));
-		RETURN_UP(0);
-
-	case CDROMSUBCHNL:   /* Get subchannel info */
-		msg(DBG_IOS,"ioctl: CDROMSUBCHNL entered.\n");
-		/* Bogus, I can do better than this! --AJK
-		if ((st_spinning)||(!subq_valid)) {
-			i=cc_ReadSubQ();
-			if (i<0) RETURN_UP(-EIO);
-		}
-		*/
-		i=cc_ReadSubQ();
-		if (i<0) {
-			j=cc_ReadError(); /* clear out error status from drive */
-			current_drive->audio_state=CDROM_AUDIO_NO_STATUS;
-			/* get and set the disk state here, 
-			probably not the right place, but who cares!
-			It makes it work properly! --AJK */
-			if (current_drive->CD_changed==0xFF) {
-				msg(DBG_000,"Disk changed detect\n");
-				current_drive->diskstate_flags &= ~cd_size_bit;
-			}
-			RETURN_UP(-EIO);
-		}
-		if (current_drive->CD_changed==0xFF) {
-			/* reread the TOC because the disk has changed! --AJK */
-			msg(DBG_000,"Disk changed STILL detected, rereading TOC!\n");
-			i=DiskInfo();
-			if(i==0) {
-				current_drive->CD_changed=0x00; /* cd has changed, procede, */
-				RETURN_UP(-EIO); /* and get TOC, etc on next try! --AJK */
-			} else {
-				RETURN_UP(-EIO); /* we weren't ready yet! --AJK */
-			}
+			if ((current_drive->ored_ctl_adr&0x40)==0)
+				msg(DBG_INF, "CD contains no data tracks.\n");
+			else msg(DBG_INF, "sbp_data: DATA_READY timeout (%02X).\n", j);
+			error_flag++;
 		}
-		memcpy(&SC, (void *) arg, sizeof(struct cdrom_subchnl));
-		/* 
-			This virtual crap is very bogus! 
-			It doesn't detect when the cd is done playing audio!
-			Lets do this right with proper hardware register reading!
-		*/
-		cc_ReadStatus();
-		i=ResponseStatus();
-		msg(DBG_000,"Drive Status: door_locked =%d.\n", st_door_locked);
-		msg(DBG_000,"Drive Status: door_closed =%d.\n", st_door_closed);
-		msg(DBG_000,"Drive Status: caddy_in =%d.\n", st_caddy_in);
-		msg(DBG_000,"Drive Status: disk_ok =%d.\n", st_diskok);
-		msg(DBG_000,"Drive Status: spinning =%d.\n", st_spinning);
-		msg(DBG_000,"Drive Status: busy =%d.\n", st_busy);
-		/* st_busy indicates if it's _ACTUALLY_ playing audio */
-		switch (current_drive->audio_state)
-		{
-		case audio_playing:
-			if(st_busy==0) {
-				/* CD has stopped playing audio --AJK */
-				current_drive->audio_state=audio_completed;
-				SC.cdsc_audiostatus=CDROM_AUDIO_COMPLETED;
-			} else {
-				SC.cdsc_audiostatus=CDROM_AUDIO_PLAY;
-			}
-			break;
-		case audio_pausing:
-			SC.cdsc_audiostatus=CDROM_AUDIO_PAUSED;
-			break;
-		case audio_completed:
-			SC.cdsc_audiostatus=CDROM_AUDIO_COMPLETED;
-			break;
-		default:
-			SC.cdsc_audiostatus=CDROM_AUDIO_NO_STATUS;
-			break;
+		SBPCD_STI;
+		if (error_flag) break;
+
+		msg(DBG_000, "sbp_data: beginning to read.\n");
+		p = current_drive->sbp_buf + frame *  CD_FRAMESIZE;
+		if (sbpro_type==1) OUT(CDo_sel_i_d,1);
+		if (cmd_type==READ_M2) {
+                        if (do_16bit) insw(CDi_data, xa_head_buf, CD_XA_HEAD>>1);
+                        else insb(CDi_data, xa_head_buf, CD_XA_HEAD);
 		}
-		SC.cdsc_adr=current_drive->SubQ_ctl_adr;
-		SC.cdsc_ctrl=current_drive->SubQ_ctl_adr>>4;
-		SC.cdsc_trk=bcd2bin(current_drive->SubQ_trk);
-		SC.cdsc_ind=bcd2bin(current_drive->SubQ_pnt_idx);
-		if (SC.cdsc_format==CDROM_LBA)
+		if (do_16bit) insw(CDi_data, p, CD_FRAMESIZE>>1);
+		else insb(CDi_data, p, CD_FRAMESIZE);
+		if (cmd_type==READ_M2) {
+                        if (do_16bit) insw(CDi_data, xa_tail_buf, CD_XA_TAIL>>1);
+                        else insb(CDi_data, xa_tail_buf, CD_XA_TAIL);
+		}
+		current_drive->sbp_current++;
+		if (sbpro_type==1) OUT(CDo_sel_i_d,0);
+		if (cmd_type==READ_M2)
 		{
-			SC.cdsc_absaddr.lba=msf2blk(current_drive->SubQ_run_tot);
-			SC.cdsc_reladdr.lba=msf2blk(current_drive->SubQ_run_trk);
+			for (xa_count=0;xa_count<CD_XA_HEAD;xa_count++)
+				sprintf(&msgbuf[xa_count*3], " %02X", xa_head_buf[xa_count]);
+			msgbuf[xa_count*3]=0;
+			msg(DBG_XA1,"xa head:%s\n", msgbuf);
 		}
-		else /* not only if (SC.cdsc_format==CDROM_MSF) */
+		data_retrying = 0;
+		data_tries++;
+		if (data_tries >= 1000)
 		{
-			SC.cdsc_absaddr.msf.minute=(current_drive->SubQ_run_tot>>16)&0x00FF;
-			SC.cdsc_absaddr.msf.second=(current_drive->SubQ_run_tot>>8)&0x00FF;
-			SC.cdsc_absaddr.msf.frame=current_drive->SubQ_run_tot&0x00FF;
-			SC.cdsc_reladdr.msf.minute=(current_drive->SubQ_run_trk>>16)&0x00FF;
-			SC.cdsc_reladdr.msf.second=(current_drive->SubQ_run_trk>>8)&0x00FF;
-			SC.cdsc_reladdr.msf.frame=current_drive->SubQ_run_trk&0x00FF;
+			msg(DBG_INF,"sbp_data() statistics: %d waits in %d frames.\n", data_waits, data_tries);
+			data_waits = data_tries = 0;
 		}
-		memcpy((void *) arg, &SC, sizeof(struct cdrom_subchnl));
-		msg(DBG_IOS,"CDROMSUBCHNL: %1X %02X %08X %08X %02X %02X %06X %06X\n",
-		    SC.cdsc_format,SC.cdsc_audiostatus,
-		    SC.cdsc_adr,SC.cdsc_ctrl,
-		    SC.cdsc_trk,SC.cdsc_ind,
-		    SC.cdsc_absaddr,SC.cdsc_reladdr);
-		RETURN_UP(0);
-		
-	default:
-		msg(DBG_IOC,"ioctl: unknown function request %04X\n", cmd);
-		RETURN_UP(-EINVAL);
-	} /* end switch(cmd) */
-}
-/*==========================================================================*/
-/*
- *  Take care of the different block sizes between cdrom and Linux.
- */
-static void sbp_transfer(struct request *req)
-{
-	long offs;
-	
-	while ( (req->nr_sectors > 0) &&
-	       (req->sector/4 >= current_drive->sbp_first_frame) &&
-	       (req->sector/4 <= current_drive->sbp_last_frame) )
-	{
-		offs = (req->sector - current_drive->sbp_first_frame * 4) * 512;
-		memcpy(req->buffer, current_drive->sbp_buf + offs, 512);
-		req->nr_sectors--;
-		req->sector++;
-		req->buffer += 512;
 	}
-}
-/*==========================================================================*/
-/*
- *  special end_request for sbpcd to solve CURRENT==NULL bug. (GTL)
- *  GTL = Gonzalo Tornaria <tornaria@cmat.edu.uy>
- *
- *  This is a kludge so we don't need to modify end_request.
- *  We put the req we take out after INIT_REQUEST in the requests list,
- *  so that end_request will discard it. 
- *
- *  The bug could be present in other block devices, perhaps we
- *  should modify INIT_REQUEST and end_request instead, and
- *  change every block device.. 
- *
- *  Could be a race here?? Could e.g. a timer interrupt schedule() us?
- *  If so, we should copy end_request here, and do it right.. (or
- *  modify end_request and the block devices).
- *
- *  In any case, the race here would be much small than it was, and
- *  I couldn't reproduce..
- *
- *  The race could be: suppose CURRENT==NULL. We put our req in the list,
- *  and we are scheduled. Other process takes over, and gets into
- *  do_sbpcd_request. It sees CURRENT!=NULL (it is == to our req), so
- *  proceeds. It ends, so CURRENT is now NULL.. Now we awake somewhere in
- *  end_request, but now CURRENT==NULL... oops!
- *
- */
-#undef DEBUG_GTL
-
-/*==========================================================================*/
-/*
- *  I/O request routine, called from Linux kernel.
- */
-static void do_sbpcd_request(request_queue_t * q)
-{
-	u_int block;
-	u_int nsect;
-	int status_tries, data_tries;
-	struct request *req;
-	struct sbpcd_drive *p;
-#ifdef DEBUG_GTL
-	static int xx_nr=0;
-	int xnr;
-#endif
-
- request_loop:
-#ifdef DEBUG_GTL
-	xnr=++xx_nr;
-
-	req = elv_next_request(q);
-
-	if (!req)
+	duration=jiffies-duration;
+	msg(DBG_TEA,"time to read %d frames: %d jiffies .\n",frame,duration);
+	if (famT_drive)
 	{
-		printk( "do_sbpcd_request[%di](NULL), Pid:%d, Time:%li\n",
-			xnr, current->pid, jiffies);
-		printk( "do_sbpcd_request[%do](NULL) end 0 (null), Time:%li\n",
-			xnr, jiffies);
-		return;
-	}
-
-	printk(" do_sbpcd_request[%di](%p:%ld+%ld), Pid:%d, Time:%li\n",
-		xnr, req, req->sector, req->nr_sectors, current->pid, jiffies);
+		wait=8;
+		do
+		{
+			if (teac==2)
+                          {
+                            if ((i=CDi_stat_loop_T()) == -1) break;
+                          }
+                        else
+                          {
+                            sbp_sleep(1);
+                            OUT(CDo_sel_i_d,0); 
+                            i=inb(CDi_status);
+                          } 
+			if (!(i&s_not_data_ready))
+			{
+				OUT(CDo_sel_i_d,1);
+				j=0;
+				do
+				{
+					if (do_16bit) i=inw(CDi_data);
+					else i=inb(CDi_data);
+					j++;
+					i=inb(CDi_status);
+				}
+				while (!(i&s_not_data_ready));
+				msg(DBG_TEA, "==========too much data (%d bytes/words)==============.\n", j);
+			}
+			if (!(i&s_not_result_ready))
+			{
+				OUT(CDo_sel_i_d,0);
+				l=0;
+				do
+				{
+					infobuf[l++]=inb(CDi_info);
+					i=inb(CDi_status);
+				}
+				while (!(i&s_not_result_ready));
+				if (infobuf[0]==0x00) success=1;
+#if 1
+				for (j=0;j<l;j++) sprintf(&msgbuf[j*3], " %02X", infobuf[j]);
+				msgbuf[j*3]=0;
+				msg(DBG_TEA,"sbp_data info response:%s\n", msgbuf);
 #endif
-
-	req = elv_next_request(q);	/* take out our request so no other */
-	if (!req)
-		return;
-
-	if (req -> sector == -1)
-		end_request(req, 0);
-	spin_unlock_irq(q->queue_lock);
-
-	down(&ioctl_read_sem);
-	if (rq_data_dir(elv_next_request(q)) != READ)
-	{
-		msg(DBG_INF, "bad cmd %d\n", req->cmd[0]);
-		goto err_done;
-	}
-	p = req->rq_disk->private_data;
-#if OLD_BUSY
-	while (busy_audio) sbp_sleep(HZ); /* wait a bit */
-	busy_data=1;
-#endif /* OLD_BUSY */
-	
-	if (p->audio_state==audio_playing) goto err_done;
-	if (p != current_drive)
-		switch_drive(p);
-
-	block = req->sector; /* always numbered as 512-byte-pieces */
-	nsect = req->nr_sectors; /* always counted as 512-byte-pieces */
-	
-	msg(DBG_BSZ,"read sector %d (%d sectors)\n", block, nsect);
+				if (infobuf[0]==0x02)
+				{
+					error_flag++;
+					do
+					{
+						++recursion;
+						if (recursion>1) msg(DBG_TEA,"cmd_out_T READ_ERR recursion (sbp_data): %d !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n",recursion);
+						else msg(DBG_TEA,"sbp_data: CMDT_READ_ERR necessary.\n");
+						clr_cmdbuf();
+						drvcmd[0]=CMDT_READ_ERR;
+						j=cmd_out_T(); /* !!! recursive here !!! */
+						--recursion;
+						sbp_sleep(1);
+					}
+					while (j<0);
+					current_drive->error_state=infobuf[2];
+					current_drive->b3=infobuf[3];
+					current_drive->b4=infobuf[4];
+				}
+				break;
+			}
+			else
+			{
 #if 0
-	msg(DBG_MUL,"read LBA %d\n", block/4);
+				msg(DBG_TEA, "============= waiting for result=================.\n");
+				sbp_sleep(1);
 #endif
-	
-	sbp_transfer(req);
-	/* if we satisfied the request from the buffer, we're done. */
-	if (req->nr_sectors == 0)
+			}
+		}
+		while (wait--);
+	}
+
+	if (error_flag) /* must have been spurious D_RDY or (ATTN&&!D_RDY) */
 	{
-#ifdef DEBUG_GTL
-		printk(" do_sbpcd_request[%do](%p:%ld+%ld) end 2, Time:%li\n",
-			xnr, req, req->sector, req->nr_sectors, jiffies);
-#endif
-		up(&ioctl_read_sem);
-		spin_lock_irq(q->queue_lock);
-		end_request(req, 1);
-		goto request_loop;
+		msg(DBG_TEA, "================error flag: %d=================.\n", error_flag);
+		msg(DBG_INF,"sbp_data: read aborted by drive.\n");
+#if 1
+		i=cc_DriveReset(); /* ugly fix to prevent a hang */
+#else
+		i=cc_ReadError();
+#endif
+		return (0);
 	}
-
-#ifdef FUTURE
-	i=prepare(0,0); /* at moment not really a hassle check, but ... */
-	if (i!=0)
-		msg(DBG_INF,"\"prepare\" tells error %d -- ignored\n", i);
-#endif /* FUTURE */ 
-	
-	if (!st_spinning) cc_SpinUp();
 	
-	for (data_tries=n_retries; data_tries > 0; data_tries--)
+	if (fam0LV_drive)
 	{
-		for (status_tries=3; status_tries > 0; status_tries--)
+		SBPCD_CLI;
+		i=maxtim_data;
+		for (timeout=jiffies+HZ; time_before(jiffies, timeout); timeout--)
 		{
-			flags_cmd_out |= f_respo3;
-			cc_ReadStatus();
-			if (sbp_status() != 0) break;
-			if (st_check) cc_ReadError();
-			sbp_sleep(1);    /* wait a bit, try again */
+			for ( ;i!=0;i--)
+			{
+				j=inb(CDi_status);
+				if (!(j&s_not_data_ready)) break;
+				if (!(j&s_not_result_ready)) break;
+				if (j&s_attention) break;
+			}
+			if (i != 0 || time_after_eq(jiffies, timeout)) break;
+			sbp_sleep(0);
+			i = 1;
 		}
-		if (status_tries == 0)
+		if (i==0) msg(DBG_INF,"status timeout after READ.\n");
+		if (!(j&s_attention))
 		{
-			msg(DBG_INF,"sbp_status: failed after 3 tries in line %d\n", __LINE__);
-			break;
+			msg(DBG_INF,"sbp_data: timeout waiting DRV_ATTN - retrying.\n");
+			i=cc_DriveReset();  /* ugly fix to prevent a hang */
+			SBPCD_STI;
+			return (0);
 		}
-		
-		sbp_read_cmd(req);
-		sbp_sleep(0);
-		if (sbp_data(req) != 0)
+		SBPCD_STI;
+	}
+	
+#if 0
+	if (!success)
+#endif
+		do
 		{
-#ifdef SAFE_MIXED
-			current_drive->has_data=2; /* is really a data disk */
-#endif /* SAFE_MIXED */ 
-#ifdef DEBUG_GTL
-			printk(" do_sbpcd_request[%do](%p:%ld+%ld) end 3, Time:%li\n",
-				xnr, req, req->sector, req->nr_sectors, jiffies);
+			if (fam0LV_drive) cc_ReadStatus();
+#if 1
+			if (famT_drive) msg(DBG_TEA, "================before ResponseStatus=================.\n", i);
 #endif
-			up(&ioctl_read_sem);
-			spin_lock_irq(q->queue_lock);
-			end_request(req, 1);
-			goto request_loop;
+			i=ResponseStatus();  /* builds status_bits, returns orig. status (old) or faked p_success (new) */
+#if 1
+			if (famT_drive)	msg(DBG_TEA, "================ResponseStatus: %d=================.\n", i);
+#endif
+			if (i<0)
+			{
+				msg(DBG_INF,"bad cc_ReadStatus after read: %02X\n", current_drive->status_bits);
+				return (0);
+			}
 		}
+		while ((fam0LV_drive)&&(!st_check)&&(!(i&p_success)));
+	if (st_check)
+	{
+		i=cc_ReadError();
+		msg(DBG_INF,"cc_ReadError was necessary after read: %d\n",i);
+		return (0);
+	}
+	if (fatal_err)
+	{
+		fatal_err=0;
+		current_drive->sbp_first_frame=current_drive->sbp_last_frame=-1;      /* purge buffer */
+		current_drive->sbp_current = 0;
+		msg(DBG_INF,"sbp_data: fatal_err - retrying.\n");
+		return (0);
 	}
 	
- err_done:
-#if OLD_BUSY
-	busy_data=0;
-#endif /* OLD_BUSY */
-#ifdef DEBUG_GTL
-	printk(" do_sbpcd_request[%do](%p:%ld+%ld) end 4 (error), Time:%li\n",
-		xnr, req, req->sector, req->nr_sectors, jiffies);
-#endif
-	up(&ioctl_read_sem);
-	sbp_sleep(0);    /* wait a bit, try again */
-	spin_lock_irq(q->queue_lock);
-	end_request(req, 0);
-	goto request_loop;
+	current_drive->sbp_first_frame = req -> sector / 4;
+	current_drive->sbp_last_frame = current_drive->sbp_first_frame + current_drive->sbp_read_frames - 1;
+	sbp_transfer(req);
+	return (1);
 }
 /*==========================================================================*/
-/*
- *  build and send the READ command.
- */
-static void sbp_read_cmd(struct request *req)
+
+static int sbpcd_block_open(struct inode *inode, struct file *file)
 {
-#undef OLD
+	struct sbpcd_drive *p = inode->i_bdev->bd_disk->private_data;
+	return cdrom_open(p->sbpcd_infop, inode, file);
+}
 
-	int i;
-	int block;
+static int sbpcd_block_release(struct inode *inode, struct file *file)
+{
+	struct sbpcd_drive *p = inode->i_bdev->bd_disk->private_data;
+	return cdrom_release(p->sbpcd_infop, file);
+}
+
+static int sbpcd_block_ioctl(struct inode *inode, struct file *file,
+				unsigned cmd, unsigned long arg)
+{
+	struct sbpcd_drive *p = inode->i_bdev->bd_disk->private_data;
+	struct cdrom_device_info *cdi = p->sbpcd_infop;
+	int ret, i;
+
+	ret = cdrom_ioctl(file, p->sbpcd_infop, inode, cmd, arg);
+	if (ret != -ENOSYS)
+		return ret;
+
+	msg(DBG_IO2,"ioctl(%s, 0x%08lX, 0x%08lX)\n", cdi->name, cmd, arg);
+	if (p->drv_id==-1) {
+		msg(DBG_INF, "ioctl: bad device: %s\n", cdi->name);
+		return (-ENXIO);             /* no such drive */
+	}
+	down(&ioctl_read_sem);
+	if (p != current_drive)
+		switch_drive(p);
 	
-	current_drive->sbp_first_frame=current_drive->sbp_last_frame=-1;      /* purge buffer */
-	current_drive->sbp_current = 0;
-	block=req->sector/4;
-	if (block+current_drive->sbp_bufsiz <= current_drive->CDsize_frm)
-		current_drive->sbp_read_frames = current_drive->sbp_bufsiz;
-	else
+	msg(DBG_IO2,"ioctl: device %s, request %04X\n",cdi->name,cmd);
+	switch (cmd) 		/* Sun-compatible */
 	{
-		current_drive->sbp_read_frames=current_drive->CDsize_frm-block;
-		/* avoid reading past end of data */
-		if (current_drive->sbp_read_frames < 1)
+	case DDIOCSDBG:		/* DDI Debug */
+		if (!capable(CAP_SYS_ADMIN)) RETURN_UP(-EPERM);
+		i=sbpcd_dbg_ioctl(arg,1);
+		RETURN_UP(i);
+	case CDROMRESET:      /* hard reset the drive */
+		msg(DBG_IOC,"ioctl: CDROMRESET entered.\n");
+		i=DriveReset();
+		current_drive->audio_state=0;
+		RETURN_UP(i);
+		
+	case CDROMREADMODE1:
+		msg(DBG_IOC,"ioctl: CDROMREADMODE1 requested.\n");
+#ifdef SAFE_MIXED
+		if (current_drive->has_data>1) RETURN_UP(-EBUSY);
+#endif /* SAFE_MIXED */
+		cc_ModeSelect(CD_FRAMESIZE);
+		cc_ModeSense();
+		current_drive->mode=READ_M1;
+		RETURN_UP(0);
+		
+	case CDROMREADMODE2: /* not usable at the moment */
+		msg(DBG_IOC,"ioctl: CDROMREADMODE2 requested.\n");
+#ifdef SAFE_MIXED
+		if (current_drive->has_data>1) RETURN_UP(-EBUSY);
+#endif /* SAFE_MIXED */
+		cc_ModeSelect(CD_FRAMESIZE_RAW1);
+		cc_ModeSense();
+		current_drive->mode=READ_M2;
+		RETURN_UP(0);
+		
+	case CDROMAUDIOBUFSIZ: /* configure the audio buffer size */
+		msg(DBG_IOC,"ioctl: CDROMAUDIOBUFSIZ entered.\n");
+		if (current_drive->sbp_audsiz>0)
+			vfree(current_drive->aud_buf);
+		current_drive->aud_buf=NULL;
+		current_drive->sbp_audsiz=arg;
+		
+		if (current_drive->sbp_audsiz>16)
 		{
-			msg(DBG_INF,"requested frame %d, CD size %d ???\n",
-			    block, current_drive->CDsize_frm);
-			current_drive->sbp_read_frames=1;
+			current_drive->sbp_audsiz = 0;
+			RETURN_UP(current_drive->sbp_audsiz);
 		}
-	}
 	
-	flags_cmd_out = f_putcmd | f_respo2 | f_ResponseStatus | f_obey_p_check;
-	clr_cmdbuf();
-	if (famV_drive)
-	  {
-	    drvcmd[0]=CMDV_READ;
-	    lba2msf(block,&drvcmd[1]); /* msf-bcd format required */
-	    bin2bcdx(&drvcmd[1]);
-	    bin2bcdx(&drvcmd[2]);
-	    bin2bcdx(&drvcmd[3]);
-	    drvcmd[4]=current_drive->sbp_read_frames>>8;
-	    drvcmd[5]=current_drive->sbp_read_frames&0xff;
-	    drvcmd[6]=0x02; /* flag "msf-bcd" */
-	}
-	else if (fam0L_drive)
-	{
-		flags_cmd_out |= f_lopsta | f_getsta | f_bit1;
-		if (current_drive->xa_byte==0x20)
+		if (current_drive->sbp_audsiz>0)
 		{
-			cmd_type=READ_M2;
-			drvcmd[0]=CMD0_READ_XA; /* "read XA frames", old drives */
-			drvcmd[1]=(block>>16)&0x0ff;
-			drvcmd[2]=(block>>8)&0x0ff;
-			drvcmd[3]=block&0x0ff;
-			drvcmd[4]=(current_drive->sbp_read_frames>>8)&0x0ff;
-			drvcmd[5]=current_drive->sbp_read_frames&0x0ff;
+			current_drive->aud_buf=(u_char *) vmalloc(current_drive->sbp_audsiz*CD_FRAMESIZE_RAW);
+			if (current_drive->aud_buf==NULL)
+			{
+				msg(DBG_INF,"audio buffer (%d frames) not available.\n",current_drive->sbp_audsiz);
+				current_drive->sbp_audsiz=0;
+			}
+			else msg(DBG_INF,"audio buffer size: %d frames.\n",current_drive->sbp_audsiz);
 		}
-		else
+		RETURN_UP(current_drive->sbp_audsiz);
+
+	case CDROMREADAUDIO:
+	{ /* start of CDROMREADAUDIO */
+		int i=0, j=0, frame, block=0;
+		u_int try=0;
+		u_long timeout;
+		u_char *p;
+		u_int data_tries = 0;
+		u_int data_waits = 0;
+		u_int data_retrying = 0;
+		int status_tries;
+		int error_flag;
+		
+		msg(DBG_IOC,"ioctl: CDROMREADAUDIO entered.\n");
+		if (fam0_drive) RETURN_UP(-EINVAL);
+		if (famL_drive) RETURN_UP(-EINVAL);
+		if (famV_drive) RETURN_UP(-EINVAL);
+		if (famT_drive) RETURN_UP(-EINVAL);
+#ifdef SAFE_MIXED
+		if (current_drive->has_data>1) RETURN_UP(-EBUSY);
+#endif /* SAFE_MIXED */ 
+		if (current_drive->aud_buf==NULL) RETURN_UP(-EINVAL);
+		if (copy_from_user(&read_audio, (void __user *)arg,
+				   sizeof(struct cdrom_read_audio)))
+			RETURN_UP(-EFAULT);
+		if (read_audio.nframes < 0 || read_audio.nframes>current_drive->sbp_audsiz) RETURN_UP(-EINVAL);
+		if (!access_ok(VERIFY_WRITE, read_audio.buf,
+			      read_audio.nframes*CD_FRAMESIZE_RAW))
+                	RETURN_UP(-EFAULT);
+		
+		if (read_audio.addr_format==CDROM_MSF) /* MSF-bin specification of where to start */
+			block=msf2lba(&read_audio.addr.msf.minute);
+		else if (read_audio.addr_format==CDROM_LBA) /* lba specification of where to start */
+			block=read_audio.addr.lba;
+		else RETURN_UP(-EINVAL);
+#if 000
+		i=cc_SetSpeed(speed_150,0,0);
+		if (i) msg(DBG_AUD,"read_audio: SetSpeed error %d\n", i);
+#endif
+		msg(DBG_AUD,"read_audio: lba: %d, msf: %06X\n",
+		    block, blk2msf(block));
+		msg(DBG_AUD,"read_audio: before cc_ReadStatus.\n");
+#if OLD_BUSY
+		while (busy_data) sbp_sleep(HZ/10); /* wait a bit */
+		busy_audio=1;
+#endif /* OLD_BUSY */ 
+		error_flag=0;
+		for (data_tries=5; data_tries>0; data_tries--)
 		{
-			drvcmd[0]=CMD0_READ; /* "read frames", old drives */
-			if (current_drive->drv_type>=drv_201)
+			msg(DBG_AUD,"data_tries=%d ...\n", data_tries);
+			current_drive->mode=READ_AU;
+			cc_ModeSelect(CD_FRAMESIZE_RAW);
+			cc_ModeSense();
+			for (status_tries=3; status_tries > 0; status_tries--)
 			{
-				lba2msf(block,&drvcmd[1]); /* msf-bcd format required */
-				bin2bcdx(&drvcmd[1]);
-				bin2bcdx(&drvcmd[2]);
-				bin2bcdx(&drvcmd[3]);
+				flags_cmd_out |= f_respo3;
+				cc_ReadStatus();
+				if (sbp_status() != 0) break;
+				if (st_check) cc_ReadError();
+				sbp_sleep(1);    /* wait a bit, try again */
 			}
-			else
+			if (status_tries == 0)
 			{
-				drvcmd[1]=(block>>16)&0x0ff;
-				drvcmd[2]=(block>>8)&0x0ff;
-				drvcmd[3]=block&0x0ff;
+				msg(DBG_AUD,"read_audio: sbp_status: failed after 3 tries in line %d.\n", __LINE__);
+				continue;
 			}
-			drvcmd[4]=(current_drive->sbp_read_frames>>8)&0x0ff;
-			drvcmd[5]=current_drive->sbp_read_frames&0x0ff;
-			drvcmd[6]=(current_drive->drv_type<drv_201)?0:2; /* flag "lba or msf-bcd format" */
-		}
-	}
-	else if (fam1_drive)
-	{
-		drvcmd[0]=CMD1_READ;
-		lba2msf(block,&drvcmd[1]); /* msf-bin format required */
-		drvcmd[5]=(current_drive->sbp_read_frames>>8)&0x0ff;
-		drvcmd[6]=current_drive->sbp_read_frames&0x0ff;
-	}
-	else if (fam2_drive)
-	{
-		drvcmd[0]=CMD2_READ;
-		lba2msf(block,&drvcmd[1]); /* msf-bin format required */
-		drvcmd[4]=(current_drive->sbp_read_frames>>8)&0x0ff;
-		drvcmd[5]=current_drive->sbp_read_frames&0x0ff;
-		drvcmd[6]=0x02;
-	}
-	else if (famT_drive)
-	{
-		drvcmd[0]=CMDT_READ;
-		drvcmd[2]=(block>>24)&0x0ff;
-		drvcmd[3]=(block>>16)&0x0ff;
-		drvcmd[4]=(block>>8)&0x0ff;
-		drvcmd[5]=block&0x0ff;
-		drvcmd[7]=(current_drive->sbp_read_frames>>8)&0x0ff;
-		drvcmd[8]=current_drive->sbp_read_frames&0x0ff;
-	}
-	flags_cmd_out=f_putcmd;
-	response_count=0;
-	i=cmd_out();
-	if (i<0) msg(DBG_INF,"error giving READ command: %0d\n", i);
-	return;
-}
-/*==========================================================================*/
-/*
- *  Check the completion of the read-data command.  On success, read
- *  the current_drive->sbp_bufsiz * 2048 bytes of data from the disk into buffer.
- */
-static int sbp_data(struct request *req)
-{
-	int i=0, j=0, l, frame;
-	u_int try=0;
-	u_long timeout;
-	u_char *p;
-	u_int data_tries = 0;
-	u_int data_waits = 0;
-	u_int data_retrying = 0;
-	int error_flag;
-	int xa_count;
-	int max_latency;
-	int success;
-	int wait;
-	int duration;
-	
-	error_flag=0;
-	success=0;
-#if LONG_TIMING
-	max_latency=9*HZ;
-#else
-	if (current_drive->f_multisession) max_latency=15*HZ;
-	else max_latency=5*HZ;
-#endif
-	duration=jiffies;
-	for (frame=0;frame<current_drive->sbp_read_frames&&!error_flag; frame++)
-	{
-		SBPCD_CLI;
-		
-		del_timer(&data_timer);
-		data_timer.expires=jiffies+max_latency;
-		timed_out_data=0;
-		add_timer(&data_timer);
-		while (!timed_out_data) 
-		{
-			if (current_drive->f_multisession) try=maxtim_data*4;
-			else try=maxtim_data;
-			msg(DBG_000,"sbp_data: CDi_status loop: try=%d.\n",try);
-			for ( ; try!=0;try--)
+			msg(DBG_AUD,"read_audio: sbp_status: ok.\n");
+			
+			flags_cmd_out = f_putcmd | f_respo2 | f_ResponseStatus | f_obey_p_check;
+			if (fam0L_drive)
 			{
-				j=inb(CDi_status);
-				if (!(j&s_not_data_ready)) break;
-				if (!(j&s_not_result_ready)) break;
-				if (fam0LV_drive) if (j&s_attention) break;
+				flags_cmd_out |= f_lopsta | f_getsta | f_bit1;
+				cmd_type=READ_M2;
+				drvcmd[0]=CMD0_READ_XA; /* "read XA frames", old drives */
+				drvcmd[1]=(block>>16)&0x000000ff;
+				drvcmd[2]=(block>>8)&0x000000ff;
+				drvcmd[3]=block&0x000000ff;
+				drvcmd[4]=0;
+				drvcmd[5]=read_audio.nframes; /* # of frames */
+				drvcmd[6]=0;
 			}
-			if (!(j&s_not_data_ready)) goto data_ready;
-			if (try==0)
+			else if (fam1_drive)
 			{
-				if (data_retrying == 0) data_waits++;
-				data_retrying = 1;
-				msg(DBG_000,"sbp_data: CDi_status loop: sleeping.\n");
-				sbp_sleep(1);
-				try = 1;
+				drvcmd[0]=CMD1_READ; /* "read frames", new drives */
+				lba2msf(block,&drvcmd[1]); /* msf-bin format required */
+				drvcmd[4]=0;
+				drvcmd[5]=0;
+				drvcmd[6]=read_audio.nframes; /* # of frames */
 			}
-		}
-		msg(DBG_INF,"sbp_data: CDi_status loop expired.\n");
-	data_ready:
-		del_timer(&data_timer);
-
-		if (timed_out_data)
-		{
-			msg(DBG_INF,"sbp_data: CDi_status timeout (timed_out_data) (%02X).\n", j);
-			error_flag++;
-		}
-		if (try==0)
-		{
-			msg(DBG_INF,"sbp_data: CDi_status timeout (try=0) (%02X).\n", j);
-			error_flag++;
-		}
-		if (!(j&s_not_result_ready))
-		{
-			msg(DBG_INF, "sbp_data: RESULT_READY where DATA_READY awaited (%02X).\n", j);
-			response_count=20;
-			j=ResponseInfo();
-			j=inb(CDi_status);
-		}
-		if (j&s_not_data_ready)
-		{
-			if ((current_drive->ored_ctl_adr&0x40)==0)
-				msg(DBG_INF, "CD contains no data tracks.\n");
-			else msg(DBG_INF, "sbp_data: DATA_READY timeout (%02X).\n", j);
-			error_flag++;
-		}
-		SBPCD_STI;
-		if (error_flag) break;
-
-		msg(DBG_000, "sbp_data: beginning to read.\n");
-		p = current_drive->sbp_buf + frame *  CD_FRAMESIZE;
-		if (sbpro_type==1) OUT(CDo_sel_i_d,1);
-		if (cmd_type==READ_M2) {
-                        if (do_16bit) insw(CDi_data, xa_head_buf, CD_XA_HEAD>>1);
-                        else insb(CDi_data, xa_head_buf, CD_XA_HEAD);
-		}
-		if (do_16bit) insw(CDi_data, p, CD_FRAMESIZE>>1);
-		else insb(CDi_data, p, CD_FRAMESIZE);
-		if (cmd_type==READ_M2) {
-                        if (do_16bit) insw(CDi_data, xa_tail_buf, CD_XA_TAIL>>1);
-                        else insb(CDi_data, xa_tail_buf, CD_XA_TAIL);
-		}
-		current_drive->sbp_current++;
-		if (sbpro_type==1) OUT(CDo_sel_i_d,0);
-		if (cmd_type==READ_M2)
-		{
-			for (xa_count=0;xa_count<CD_XA_HEAD;xa_count++)
-				sprintf(&msgbuf[xa_count*3], " %02X", xa_head_buf[xa_count]);
-			msgbuf[xa_count*3]=0;
-			msg(DBG_XA1,"xa head:%s\n", msgbuf);
-		}
-		data_retrying = 0;
-		data_tries++;
-		if (data_tries >= 1000)
-		{
-			msg(DBG_INF,"sbp_data() statistics: %d waits in %d frames.\n", data_waits, data_tries);
-			data_waits = data_tries = 0;
-		}
-	}
-	duration=jiffies-duration;
-	msg(DBG_TEA,"time to read %d frames: %d jiffies .\n",frame,duration);
-	if (famT_drive)
-	{
-		wait=8;
-		do
-		{
-			if (teac==2)
-                          {
-                            if ((i=CDi_stat_loop_T()) == -1) break;
-                          }
-                        else
-                          {
-                            sbp_sleep(1);
-                            OUT(CDo_sel_i_d,0); 
-                            i=inb(CDi_status);
-                          } 
-			if (!(i&s_not_data_ready))
+			else if (fam2_drive)
 			{
-				OUT(CDo_sel_i_d,1);
-				j=0;
-				do
+				drvcmd[0]=CMD2_READ_XA2;
+				lba2msf(block,&drvcmd[1]); /* msf-bin format required */
+				drvcmd[4]=0;
+				drvcmd[5]=read_audio.nframes; /* # of frames */
+				drvcmd[6]=0x11; /* raw mode */
+			}
+			else if (famT_drive) /* CD-55A: not tested yet */
+			{
+			}
+			msg(DBG_AUD,"read_audio: before giving \"read\" command.\n");
+			flags_cmd_out=f_putcmd;
+			response_count=0;
+			i=cmd_out();
+			if (i<0) msg(DBG_INF,"error giving READ AUDIO command: %0d\n", i);
+			sbp_sleep(0);
+			msg(DBG_AUD,"read_audio: after giving \"read\" command.\n");
+			for (frame=1;frame<2 && !error_flag; frame++)
+			{
+				try=maxtim_data;
+				for (timeout=jiffies+9*HZ; ; )
+				{
+					for ( ; try!=0;try--)
+					{
+						j=inb(CDi_status);
+						if (!(j&s_not_data_ready)) break;
+						if (!(j&s_not_result_ready)) break;
+						if (fam0L_drive) if (j&s_attention) break;
+					}
+					if (try != 0 || time_after_eq(jiffies, timeout)) break;
+					if (data_retrying == 0) data_waits++;
+					data_retrying = 1;
+					sbp_sleep(1);
+					try = 1;
+				}
+				if (try==0)
 				{
-					if (do_16bit) i=inw(CDi_data);
-					else i=inb(CDi_data);
-					j++;
-					i=inb(CDi_status);
+					msg(DBG_INF,"read_audio: sbp_data: CDi_status timeout.\n");
+					error_flag++;
+					break;
 				}
-				while (!(i&s_not_data_ready));
-				msg(DBG_TEA, "==========too much data (%d bytes/words)==============.\n", j);
-			}
-			if (!(i&s_not_result_ready))
-			{
-				OUT(CDo_sel_i_d,0);
-				l=0;
-				do
+				msg(DBG_AUD,"read_audio: sbp_data: CDi_status ok.\n");
+				if (j&s_not_data_ready)
 				{
-					infobuf[l++]=inb(CDi_info);
-					i=inb(CDi_status);
+					msg(DBG_INF, "read_audio: sbp_data: DATA_READY timeout.\n");
+					error_flag++;
+					break;
 				}
-				while (!(i&s_not_result_ready));
-				if (infobuf[0]==0x00) success=1;
-#if 1
-				for (j=0;j<l;j++) sprintf(&msgbuf[j*3], " %02X", infobuf[j]);
-				msgbuf[j*3]=0;
-				msg(DBG_TEA,"sbp_data info response:%s\n", msgbuf);
+				msg(DBG_AUD,"read_audio: before reading data.\n");
+				error_flag=0;
+				p = current_drive->aud_buf;
+				if (sbpro_type==1) OUT(CDo_sel_i_d,1);
+				if (do_16bit)
+				{
+					u_short *p2 = (u_short *) p;
+
+					for (; (u_char *) p2 < current_drive->aud_buf + read_audio.nframes*CD_FRAMESIZE_RAW;)
+				  	{
+						if ((inb_p(CDi_status)&s_not_data_ready)) continue;
+
+						/* get one sample */
+						*p2++ = inw_p(CDi_data);
+						*p2++ = inw_p(CDi_data);
+					}
+				} else {
+					for (; p < current_drive->aud_buf + read_audio.nframes*CD_FRAMESIZE_RAW;)
+				  	{
+						if ((inb_p(CDi_status)&s_not_data_ready)) continue;
+
+						/* get one sample */
+						*p++ = inb_p(CDi_data);
+						*p++ = inb_p(CDi_data);
+						*p++ = inb_p(CDi_data);
+						*p++ = inb_p(CDi_data);
+					}
+				}
+				if (sbpro_type==1) OUT(CDo_sel_i_d,0);
+				data_retrying = 0;
+			}
+			msg(DBG_AUD,"read_audio: after reading data.\n");
+			if (error_flag)    /* must have been spurious D_RDY or (ATTN&&!D_RDY) */
+			{
+				msg(DBG_AUD,"read_audio: read aborted by drive\n");
+#if 0000
+				i=cc_DriveReset();                /* ugly fix to prevent a hang */
+#else
+				i=cc_ReadError();
 #endif
-				if (infobuf[0]==0x02)
+				continue;
+			}
+			if (fam0L_drive)
+			{
+				i=maxtim_data;
+				for (timeout=jiffies+9*HZ; time_before(jiffies, timeout); timeout--)
 				{
-					error_flag++;
-					do
+					for ( ;i!=0;i--)
 					{
-						++recursion;
-						if (recursion>1) msg(DBG_TEA,"cmd_out_T READ_ERR recursion (sbp_data): %d !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n",recursion);
-						else msg(DBG_TEA,"sbp_data: CMDT_READ_ERR necessary.\n");
-						clr_cmdbuf();
-						drvcmd[0]=CMDT_READ_ERR;
-						j=cmd_out_T(); /* !!! recursive here !!! */
-						--recursion;
-						sbp_sleep(1);
+						j=inb(CDi_status);
+						if (!(j&s_not_data_ready)) break;
+						if (!(j&s_not_result_ready)) break;
+						if (j&s_attention) break;
 					}
-					while (j<0);
-					current_drive->error_state=infobuf[2];
-					current_drive->b3=infobuf[3];
-					current_drive->b4=infobuf[4];
+					if (i != 0 || time_after_eq(jiffies, timeout)) break;
+					sbp_sleep(0);
+					i = 1;
+				}
+				if (i==0) msg(DBG_AUD,"read_audio: STATUS TIMEOUT AFTER READ");
+				if (!(j&s_attention))
+				{
+					msg(DBG_AUD,"read_audio: sbp_data: timeout waiting DRV_ATTN - retrying\n");
+					i=cc_DriveReset();  /* ugly fix to prevent a hang */
+					continue;
 				}
-				break;
 			}
-			else
+			do
 			{
-#if 0
-				msg(DBG_TEA, "============= waiting for result=================.\n");
-				sbp_sleep(1);
-#endif
+				if (fam0L_drive) cc_ReadStatus();
+				i=ResponseStatus();  /* builds status_bits, returns orig. status (old) or faked p_success (new) */
+				if (i<0) { msg(DBG_AUD,
+					       "read_audio: cc_ReadStatus error after read: %02X\n",
+					       current_drive->status_bits);
+					   continue; /* FIXME */
+				   }
 			}
-		}
-		while (wait--);
-	}
-
-	if (error_flag) /* must have been spurious D_RDY or (ATTN&&!D_RDY) */
-	{
-		msg(DBG_TEA, "================error flag: %d=================.\n", error_flag);
-		msg(DBG_INF,"sbp_data: read aborted by drive.\n");
-#if 1
-		i=cc_DriveReset(); /* ugly fix to prevent a hang */
-#else
-		i=cc_ReadError();
-#endif
-		return (0);
-	}
-	
-	if (fam0LV_drive)
-	{
-		SBPCD_CLI;
-		i=maxtim_data;
-		for (timeout=jiffies+HZ; time_before(jiffies, timeout); timeout--)
-		{
-			for ( ;i!=0;i--)
+			while ((fam0L_drive)&&(!st_check)&&(!(i&p_success)));
+			if (st_check)
 			{
-				j=inb(CDi_status);
-				if (!(j&s_not_data_ready)) break;
-				if (!(j&s_not_result_ready)) break;
-				if (j&s_attention) break;
+				i=cc_ReadError();
+				msg(DBG_AUD,"read_audio: cc_ReadError was necessary after read: %02X\n",i);
+				continue;
 			}
-			if (i != 0 || time_after_eq(jiffies, timeout)) break;
-			sbp_sleep(0);
-			i = 1;
-		}
-		if (i==0) msg(DBG_INF,"status timeout after READ.\n");
-		if (!(j&s_attention))
-		{
-			msg(DBG_INF,"sbp_data: timeout waiting DRV_ATTN - retrying.\n");
-			i=cc_DriveReset();  /* ugly fix to prevent a hang */
-			SBPCD_STI;
-			return (0);
+			if (copy_to_user(read_audio.buf,
+					 current_drive->aud_buf,
+					 read_audio.nframes * CD_FRAMESIZE_RAW))
+				RETURN_UP(-EFAULT);
+			msg(DBG_AUD,"read_audio: copy_to_user done.\n");
+			break;
 		}
-		SBPCD_STI;
-	}
-	
-#if 0
-	if (!success)
-#endif
-		do
+		cc_ModeSelect(CD_FRAMESIZE);
+		cc_ModeSense();
+		current_drive->mode=READ_M1;
+#if OLD_BUSY
+		busy_audio=0;
+#endif /* OLD_BUSY */ 
+		if (data_tries == 0)
 		{
-			if (fam0LV_drive) cc_ReadStatus();
-#if 1
-			if (famT_drive) msg(DBG_TEA, "================before ResponseStatus=================.\n", i);
-#endif
-			i=ResponseStatus();  /* builds status_bits, returns orig. status (old) or faked p_success (new) */
-#if 1
-			if (famT_drive)	msg(DBG_TEA, "================ResponseStatus: %d=================.\n", i);
-#endif
-			if (i<0)
-			{
-				msg(DBG_INF,"bad cc_ReadStatus after read: %02X\n", current_drive->status_bits);
-				return (0);
-			}
+			msg(DBG_AUD,"read_audio: failed after 5 tries in line %d.\n", __LINE__);
+			RETURN_UP(-EIO);
 		}
-		while ((fam0LV_drive)&&(!st_check)&&(!(i&p_success)));
-	if (st_check)
-	{
-		i=cc_ReadError();
-		msg(DBG_INF,"cc_ReadError was necessary after read: %d\n",i);
-		return (0);
-	}
-	if (fatal_err)
-	{
-		fatal_err=0;
-		current_drive->sbp_first_frame=current_drive->sbp_last_frame=-1;      /* purge buffer */
-		current_drive->sbp_current = 0;
-		msg(DBG_INF,"sbp_data: fatal_err - retrying.\n");
-		return (0);
-	}
-	
-	current_drive->sbp_first_frame = req -> sector / 4;
-	current_drive->sbp_last_frame = current_drive->sbp_first_frame + current_drive->sbp_read_frames - 1;
-	sbp_transfer(req);
-	return (1);
-}
-/*==========================================================================*/
-
-static int sbpcd_block_open(struct inode *inode, struct file *file)
-{
-	struct sbpcd_drive *p = inode->i_bdev->bd_disk->private_data;
-	return cdrom_open(p->sbpcd_infop, inode, file);
-}
-
-static int sbpcd_block_release(struct inode *inode, struct file *file)
-{
-	struct sbpcd_drive *p = inode->i_bdev->bd_disk->private_data;
-	return cdrom_release(p->sbpcd_infop, file);
-}
-
-static int sbpcd_block_ioctl(struct inode *inode, struct file *file,
-				unsigned cmd, unsigned long arg)
-{
-	struct sbpcd_drive *p = inode->i_bdev->bd_disk->private_data;
-	return cdrom_ioctl(file, p->sbpcd_infop, inode, cmd, arg);
+		msg(DBG_AUD,"read_audio: successful return.\n");
+		RETURN_UP(0);
+	} /* end of CDROMREADAUDIO */
+		
+	default:
+		msg(DBG_IOC,"ioctl: unknown function request %04X\n", cmd);
+		RETURN_UP(-EINVAL);
+	} /* end switch(cmd) */
 }
 
 static int sbpcd_block_media_changed(struct gendisk *disk)
@@ -5478,10 +5471,9 @@
 	.get_mcn		= sbpcd_get_mcn,
 	.reset			= sbpcd_reset,
 	.audio_ioctl		= sbpcd_audio_ioctl,
-	.dev_ioctl		= sbpcd_dev_ioctl,
 	.capability		= CDC_CLOSE_TRAY | CDC_OPEN_TRAY | CDC_LOCK |
 				CDC_MULTI_SESSION | CDC_MEDIA_CHANGED |
-				CDC_MCN | CDC_PLAY_AUDIO | CDC_IOCTLS,
+				CDC_MCN | CDC_PLAY_AUDIO,
 	.n_minors		= 1,
 };
 
Index: linux-2.6/drivers/cdrom/viocd.c
===================================================================
--- linux-2.6.orig/drivers/cdrom/viocd.c	2005-12-27 18:30:27.000000000 +0100
+++ linux-2.6/drivers/cdrom/viocd.c	2006-01-11 12:55:09.000000000 +0100
@@ -629,7 +629,7 @@
 	.media_changed = viocd_media_changed,
 	.lock_door = viocd_lock_door,
 	.generic_packet = viocd_packet,
-	.capability = CDC_CLOSE_TRAY | CDC_OPEN_TRAY | CDC_LOCK | CDC_SELECT_SPEED | CDC_SELECT_DISC | CDC_MULTI_SESSION | CDC_MCN | CDC_MEDIA_CHANGED | CDC_PLAY_AUDIO | CDC_RESET | CDC_IOCTLS | CDC_DRIVE_STATUS | CDC_GENERIC_PACKET | CDC_CD_R | CDC_CD_RW | CDC_DVD | CDC_DVD_R | CDC_DVD_RAM | CDC_RAM
+	.capability = CDC_CLOSE_TRAY | CDC_OPEN_TRAY | CDC_LOCK | CDC_SELECT_SPEED | CDC_SELECT_DISC | CDC_MULTI_SESSION | CDC_MCN | CDC_MEDIA_CHANGED | CDC_PLAY_AUDIO | CDC_RESET | CDC_DRIVE_STATUS | CDC_GENERIC_PACKET | CDC_CD_R | CDC_CD_RW | CDC_DVD | CDC_DVD_R | CDC_DVD_RAM | CDC_RAM
 };
 
 static int __init find_capability(const char *type)
Index: linux-2.6/include/linux/cdrom.h
===================================================================
--- linux-2.6.orig/include/linux/cdrom.h	2005-12-27 18:30:35.000000000 +0100
+++ linux-2.6/include/linux/cdrom.h	2006-01-11 12:55:09.000000000 +0100
@@ -378,7 +378,6 @@
 #define CDC_MEDIA_CHANGED 	0x80    /* media changed */
 #define CDC_PLAY_AUDIO		0x100   /* audio functions */
 #define CDC_RESET               0x200   /* hard reset device */
-#define CDC_IOCTLS              0x400   /* driver has non-standard ioctls */
 #define CDC_DRIVE_STATUS        0x800   /* driver implements drive status */
 #define CDC_GENERIC_PACKET	0x1000	/* driver implements generic packets */
 #define CDC_CD_R		0x2000	/* drive is a CD-R */
@@ -974,9 +973,7 @@
 	int (*reset) (struct cdrom_device_info *);
 	/* play stuff */
 	int (*audio_ioctl) (struct cdrom_device_info *,unsigned int, void *);
-	/* dev-specific */
- 	int (*dev_ioctl) (struct cdrom_device_info *,
-			  unsigned int, unsigned long);
+
 /* driver specifications */
 	const int capability;   /* capability flags */
 	int n_minors;           /* number of active minor devices */
Index: linux-2.6/drivers/cdrom/cdu31a.c
===================================================================
--- linux-2.6.orig/drivers/cdrom/cdu31a.c	2006-01-10 13:46:03.000000000 +0100
+++ linux-2.6/drivers/cdrom/cdu31a.c	2006-01-11 12:55:09.000000000 +0100
@@ -2668,7 +2668,7 @@
 	return retval;
 }
 
-static int scd_dev_ioctl(struct cdrom_device_info *cdi,
+static int scd_read_audio(struct cdrom_device_info *cdi,
 			 unsigned int cmd, unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
@@ -2894,11 +2894,10 @@
 	.get_mcn		= scd_get_mcn,
 	.reset			= scd_reset,
 	.audio_ioctl		= scd_audio_ioctl,
-	.dev_ioctl		= scd_dev_ioctl,
 	.capability		= CDC_OPEN_TRAY | CDC_CLOSE_TRAY | CDC_LOCK |
 				  CDC_SELECT_SPEED | CDC_MULTI_SESSION |
 				  CDC_MCN | CDC_MEDIA_CHANGED | CDC_PLAY_AUDIO |
-				  CDC_RESET | CDC_IOCTLS | CDC_DRIVE_STATUS,
+				  CDC_RESET | CDC_DRIVE_STATUS,
 	.n_minors		= 1,
 };
 
@@ -2936,6 +2935,9 @@
 		case CDROMCLOSETRAY:
 			retval = scd_tray_move(&scd_info, 0);
 			break;
+		case CDROMREADAUDIO:
+			retval = scd_read_audio(&scd_info, CDROMREADAUDIO, arg);
+			break;
 		default:
 			retval = cdrom_ioctl(file, &scd_info, inode, cmd, arg);
 	}
