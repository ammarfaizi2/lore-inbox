Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbVCMQoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVCMQoN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 11:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbVCMQoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 11:44:12 -0500
Received: from coderock.org ([193.77.147.115]:32214 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261357AbVCMQeP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 11:34:15 -0500
From: Domen Puncer <domen@coderock.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, emoenke@gwdg.de, linux@rainbow-software.org,
       domen@coderock.org
In-Reply-To: <20050313163330.171476@nd47.coderock.org>
X-Mailer: Domen's patchbomb
Subject: Re: [patch 2/3] cdrom/cdu31a update
Message-Id: <20050313163342.1DA531E3B5@trashy.coderock.org>
Date: Sun, 13 Mar 2005 17:33:42 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use semaphores instead of sleep_on*.
Stolen from patch: http://lkml.org/lkml/2004/12/18/107 from
Ondrej Zary <linux@rainbow-software.org>


Signed-off-by: Domen Puncer <domen@coderock.org>
Acked-by: Ondrej Zary <linux@rainbow-software.org>

--- ./drivers/cdrom/cdu31a.c.orig2	2005-03-13 14:12:23.000000000 +0100
+++ ./drivers/cdrom/cdu31a.c	2005-03-13 14:13:44.000000000 +0100
@@ -267,7 +267,7 @@ static struct s_sony_subcode last_sony_s
 static volatile int sony_inuse = 0;	/* Is the drive in use?  Only one operation
 					   at a time allowed */
 
-static DECLARE_WAIT_QUEUE_HEAD(sony_wait);	/* Things waiting for the drive */
+static DECLARE_MUTEX(sony_sem);		/* Semaphore for drive hardware access */
 
 static struct task_struct *has_cd_task = NULL;	/* The task that is currently
 						   using the CDROM drive, or
@@ -341,13 +341,16 @@ static int scd_media_changed(struct cdro
  */
 static int scd_drive_status(struct cdrom_device_info *cdi, int slot_nr)
 {
-	if (CDSL_CURRENT != slot_nr) {
+	if (CDSL_CURRENT != slot_nr)
 		/* we have no changer support */
 		return -EINVAL;
-	}
-	if (scd_spinup() == 0) {
+	if (sony_spun_up)
+		return CDS_DISC_OK;
+	if (down_interruptible(&sony_sem))
+		return -ERESTARTSYS;
+	if (scd_spinup() == 0)
 		sony_spun_up = 1;
-	}
+	up(&sony_sem);
 	return sony_spun_up ? CDS_DISC_OK : CDS_DRIVE_NOT_READY;
 }
 
@@ -442,6 +445,8 @@ static int scd_reset(struct cdrom_device
 {
 	unsigned long retry_count;
 
+	if (down_interruptible(&sony_sem))
+		return -ERESTARTSYS;
 	reset_drive();
 
 	retry_count = jiffies + SONY_RESET_TIMEOUT;
@@ -449,6 +454,7 @@ static int scd_reset(struct cdrom_device
 		sony_sleep();
 	}
 
+	up(&sony_sem);
 	return 0;
 }
 
@@ -640,7 +646,10 @@ static int scd_select_speed(struct cdrom
 	else
 		sony_speed = speed - 1;
 
+	if (down_interruptible(&sony_sem))
+		return -ERESTARTSYS;
 	set_drive_params(sony_speed);
+	up(&sony_sem);
 	return 0;
 }
 
@@ -655,7 +664,10 @@ static int scd_lock_door(struct cdrom_de
 	} else {
 		is_auto_eject = 0;
 	}
+	if (down_interruptible(&sony_sem))
+		return -ERESTARTSYS;
 	set_drive_params(sony_speed);
+	up(&sony_sem);
 	return 0;
 }
 
@@ -848,38 +860,12 @@ do_sony_cd_cmd(unsigned char cmd,
 	       unsigned char *result_buffer, unsigned int *result_size)
 {
 	unsigned long retry_count;
-	int num_retries;
-	int recursive_call;
-	unsigned long flags;
-
-
-	save_flags(flags);
-	cli();
-	if (current != has_cd_task) {	/* Allow recursive calls to this routine */
-		while (sony_inuse) {
-			interruptible_sleep_on(&sony_wait);
-			if (signal_pending(current)) {
-				result_buffer[0] = 0x20;
-				result_buffer[1] = SONY_SIGNAL_OP_ERR;
-				*result_size = 2;
-				restore_flags(flags);
-				return;
-			}
-		}
-		sony_inuse = 1;
-		has_cd_task = current;
-		recursive_call = 0;
-	} else {
-		recursive_call = 1;
-	}
+	int num_retries = 0;
 
-	num_retries = 0;
 retry_cd_operation:
 
 	while (handle_sony_cd_attention());
 
-	sti();
-
 	retry_count = jiffies + SONY_JIFFIES_TIMEOUT;
 	while (time_before(jiffies, retry_count) && (is_busy())) {
 		sony_sleep();
@@ -907,14 +893,6 @@ retry_cd_operation:
 		msleep(100);
 		goto retry_cd_operation;
 	}
-
-	if (!recursive_call) {
-		has_cd_task = NULL;
-		sony_inuse = 0;
-		wake_up_interruptible(&sony_wait);
-	}
-
-	restore_flags(flags);
 }
 
 
@@ -1154,13 +1132,9 @@ static void abort_read(void)
    pending read operation. */
 static void handle_abort_timeout(unsigned long data)
 {
-	unsigned long flags;
-
 	pr_debug(PFX "Entering %s\n", __FUNCTION__);
-	save_flags(flags);
-	cli();
 	/* If it is in use, ignore it. */
-	if (!sony_inuse) {
+	if (down_trylock(&sony_sem) == 0) {
 		/* We can't use abort_read(), because it will sleep
 		   or schedule in the timer interrupt.  Just start
 		   the operation, finish it on the next access to
@@ -1171,8 +1145,8 @@ static void handle_abort_timeout(unsigne
 
 		sony_blocks_left = 0;
 		abort_read_started = 1;
+		up(&sony_sem);
 	}
-	restore_flags(flags);
 	pr_debug(PFX "Leaving %s\n", __FUNCTION__);
 }
 
@@ -1313,27 +1287,14 @@ static void do_cdu31a_request(request_qu
 	int block, nblock, num_retries;
 	unsigned char res_reg[12];
 	unsigned int res_size;
-	unsigned long flags;
 
 	pr_debug(PFX "Entering %s\n", __FUNCTION__);
 
-	/*
-	 * Make sure no one else is using the driver; wait for them
-	 * to finish if it is so.
-	 */
-	save_flags(flags);
-	cli();
-	while (sony_inuse) {
-		interruptible_sleep_on(&sony_wait);
-		if (signal_pending(current)) {
-			restore_flags(flags);
-			pr_debug(PFX "Leaving %s at %d\n", __FUNCTION__,
-			       __LINE__);
-			return;
-		}
+	spin_unlock_irq(q->queue_lock);
+	if (down_interruptible(&sony_sem)) {
+		spin_lock_irq(q->queue_lock);
+		return;
 	}
-	sony_inuse = 1;
-	has_cd_task = current;
 
 	/* Get drive status before doing anything. */
 	while (handle_sony_cd_attention());
@@ -1341,10 +1302,6 @@ static void do_cdu31a_request(request_qu
 	/* Make sure we have a valid TOC. */
 	sony_get_toc();
 
-	/*
-	 * jens: driver has lots of races
-	 */
-	spin_unlock_irq(q->queue_lock);
 
 	/* Make sure the timer is cancelled. */
 	del_timer(&cdu31a_abort_timer);
@@ -1457,7 +1414,6 @@ static void do_cdu31a_request(request_qu
 		goto try_read_again;
 	}
       end_do_cdu31a_request:
-	spin_lock_irq(q->queue_lock);
 #if 0
 	/* After finished, cancel any pending operations. */
 	abort_read();
@@ -1468,10 +1424,8 @@ static void do_cdu31a_request(request_qu
 	add_timer(&cdu31a_abort_timer);
 #endif
 
-	has_cd_task = NULL;
-	sony_inuse = 0;
-	wake_up_interruptible(&sony_wait);
-	restore_flags(flags);
+	up(&sony_sem);
+	spin_lock_irq(q->queue_lock);
 	pr_debug(PFX "Leaving %s at %d\n", __FUNCTION__, __LINE__);
 }
 
@@ -1940,8 +1894,12 @@ static int scd_get_last_session(struct c
 	if (ms_info == NULL)
 		return 1;
 
-	if (!sony_toc_read)
+	if (!sony_toc_read) {
+		if (down_interruptible(&sony_sem))
+			return -ERESTARTSYS;
 		sony_get_toc();
+		up(&sony_sem);
+	}
 
 	ms_info->addr_format = CDROM_LBA;
 	ms_info->addr.lba = sony_toc.start_track_lba;
@@ -2019,8 +1977,11 @@ scd_get_mcn(struct cdrom_device_info *cd
 	unsigned int res_size;
 
 	memset(mcn->medium_catalog_number, 0, 14);
+	if (down_interruptible(&sony_sem))
+		return -ERESTARTSYS;
 	do_sony_cd_cmd(SONY_REQ_UPC_EAN_CMD,
 		       NULL, 0, resbuffer, &res_size);
+	up(&sony_sem);
 	if ((res_size < 2) || ((resbuffer[0] & 0xf0) == 0x20));
 	else {
 		/* packed bcd to single ASCII digits */
@@ -2234,28 +2195,11 @@ static int read_audio(struct cdrom_read_
 	unsigned char res_reg[12];
 	unsigned int res_size;
 	unsigned int cframe;
-	unsigned long flags;
-
-	/* 
-	 * Make sure no one else is using the driver; wait for them
-	 * to finish if it is so.
-	 */
-	save_flags(flags);
-	cli();
-	while (sony_inuse) {
-		interruptible_sleep_on(&sony_wait);
-		if (signal_pending(current)) {
-			restore_flags(flags);
-			return -EAGAIN;
-		}
-	}
-	sony_inuse = 1;
-	has_cd_task = current;
-	restore_flags(flags);
 
-	if (!sony_spun_up) {
+	if (down_interruptible(&sony_sem))
+		return -ERESTARTSYS;
+	if (!sony_spun_up)
 		scd_spinup();
-	}
 
 	/* Set the drive to do raw operations. */
 	params[0] = SONY_SD_DECODE_PARAM;
@@ -2265,7 +2209,8 @@ static int read_audio(struct cdrom_read_
 	if ((res_size < 2) || ((res_reg[0] & 0xf0) == 0x20)) {
 		printk(KERN_ERR PFX "Unable to set decode params: 0x%2.2x\n",
 		       res_reg[1]);
-		return -EIO;
+		retval = -EIO;
+		goto out_up;
 	}
 
 	/* From here down, we have to goto exit_read_audio instead of returning
@@ -2383,12 +2328,11 @@ static int read_audio(struct cdrom_read_
 	if ((res_size < 2) || ((res_reg[0] & 0xf0) == 0x20)) {
 		printk(KERN_ERR PFX "Unable to reset decode params: 0x%2.2x\n",
 		       res_reg[1]);
-		return -EIO;
+		retval = -EIO;
 	}
 
-	has_cd_task = NULL;
-	sony_inuse = 0;
-	wake_up_interruptible(&sony_wait);
+ out_up:
+	up(&sony_sem);
 
 	return retval;
 }
@@ -2416,6 +2360,10 @@ do_sony_cd_cmd_chk(const char *name,
  */
 static int scd_tray_move(struct cdrom_device_info *cdi, int position)
 {
+	int retval;
+
+	if (down_interruptible(&sony_sem))
+		return -ERESTARTSYS;
 	if (position == 1 /* open tray */ ) {
 		unsigned char res_reg[12];
 		unsigned int res_size;
@@ -2426,13 +2374,15 @@ static int scd_tray_move(struct cdrom_de
 			       &res_size);
 
 		sony_audio_status = CDROM_AUDIO_INVALID;
-		return do_sony_cd_cmd_chk("EJECT", SONY_EJECT_CMD, NULL, 0,
+		retval = do_sony_cd_cmd_chk("EJECT", SONY_EJECT_CMD, NULL, 0,
 					  res_reg, &res_size);
 	} else {
 		if (0 == scd_spinup())
 			sony_spun_up = 1;
-		return 0;
+		retval = 0;
 	}
+	up(&sony_sem);
+	return retval;
 }
 
 /*
@@ -2444,12 +2394,13 @@ static int scd_audio_ioctl(struct cdrom_
 	unsigned char res_reg[12];
 	unsigned int res_size;
 	unsigned char params[7];
-	int i;
-
+	int i, retval;
 
+	if (down_interruptible(&sony_sem))
+		return -ERESTARTSYS;
 	switch (cmd) {
 	case CDROMSTART:	/* Spin up the drive */
-		return do_sony_cd_cmd_chk("START", SONY_SPIN_UP_CMD, NULL,
+		retval = do_sony_cd_cmd_chk("START", SONY_SPIN_UP_CMD, NULL,
 					  0, res_reg, &res_size);
 		break;
 
@@ -2462,28 +2413,33 @@ static int scd_audio_ioctl(struct cdrom_
 		 * already not spinning.
 		 */
 		sony_audio_status = CDROM_AUDIO_NO_STATUS;
-		return do_sony_cd_cmd_chk("STOP", SONY_SPIN_DOWN_CMD, NULL,
+		retval = do_sony_cd_cmd_chk("STOP", SONY_SPIN_DOWN_CMD, NULL,
 					  0, res_reg, &res_size);
+		break;
 
 	case CDROMPAUSE:	/* Pause the drive */
 		if (do_sony_cd_cmd_chk
 		    ("PAUSE", SONY_AUDIO_STOP_CMD, NULL, 0, res_reg,
-		     &res_size))
-			return -EIO;
+		     &res_size)) {
+			retval = -EIO;
+			break;
+		}
 		/* Get the current position and save it for resuming */
 		if (read_subcode() < 0) {
-			return -EIO;
+			retval = -EIO;
+			break;
 		}
 		cur_pos_msf[0] = last_sony_subcode.abs_msf[0];
 		cur_pos_msf[1] = last_sony_subcode.abs_msf[1];
 		cur_pos_msf[2] = last_sony_subcode.abs_msf[2];
 		sony_audio_status = CDROM_AUDIO_PAUSED;
-		return 0;
+		retval = 0;
 		break;
 
 	case CDROMRESUME:	/* Start the drive after being paused */
 		if (sony_audio_status != CDROM_AUDIO_PAUSED) {
-			return -EINVAL;
+			retval = -EINVAL;
+			break;
 		}
 
 		do_sony_cd_cmd(SONY_SPIN_UP_CMD, NULL, 0, res_reg,
@@ -2499,10 +2455,13 @@ static int scd_audio_ioctl(struct cdrom_
 		params[0] = 0x03;
 		if (do_sony_cd_cmd_chk
 		    ("RESUME", SONY_AUDIO_PLAYBACK_CMD, params, 7, res_reg,
-		     &res_size) < 0)
-			return -EIO;
+		     &res_size) < 0) {
+			retval = -EIO;
+			break;
+		}
 		sony_audio_status = CDROM_AUDIO_PLAY;
-		return 0;
+		retval = 0;
+		break;
 
 	case CDROMPLAYMSF:	/* Play starting at the given MSF address. */
 		do_sony_cd_cmd(SONY_SPIN_UP_CMD, NULL, 0, res_reg,
@@ -2516,15 +2475,18 @@ static int scd_audio_ioctl(struct cdrom_
 		params[0] = 0x03;
 		if (do_sony_cd_cmd_chk
 		    ("PLAYMSF", SONY_AUDIO_PLAYBACK_CMD, params, 7,
-		     res_reg, &res_size) < 0)
-			return -EIO;
+		     res_reg, &res_size) < 0) {
+			retval = -EIO;
+			break;
+		}
 
 		/* Save the final position for pauses and resumes */
 		final_pos_msf[0] = bcd_to_int(params[4]);
 		final_pos_msf[1] = bcd_to_int(params[5]);
 		final_pos_msf[2] = bcd_to_int(params[6]);
 		sony_audio_status = CDROM_AUDIO_PLAY;
-		return 0;
+		retval = 0;
+		break;
 
 	case CDROMREADTOCHDR:	/* Read the table of contents header */
 		{
@@ -2532,14 +2494,16 @@ static int scd_audio_ioctl(struct cdrom_
 
 			sony_get_toc();
 			if (!sony_toc_read) {
-				return -EIO;
+				retval = -EIO;
+				break;
 			}
 
 			hdr = (struct cdrom_tochdr *) arg;
 			hdr->cdth_trk0 = sony_toc.first_track_num;
 			hdr->cdth_trk1 = sony_toc.last_track_num;
 		}
-		return 0;
+		retval = 0;
+		break;
 
 	case CDROMREADTOCENTRY:	/* Read a given table of contents entry */
 		{
@@ -2549,14 +2513,16 @@ static int scd_audio_ioctl(struct cdrom_
 
 			sony_get_toc();
 			if (!sony_toc_read) {
-				return -EIO;
+				retval = -EIO;
+				break;
 			}
 
 			entry = (struct cdrom_tocentry *) arg;
 
 			track_idx = find_track(entry->cdte_track);
 			if (track_idx < 0) {
-				return -EINVAL;
+				retval = -EINVAL;
+				break;
 			}
 
 			entry->cdte_adr =
@@ -2577,7 +2543,7 @@ static int scd_audio_ioctl(struct cdrom_
 				    *(msf_val + 2);
 			}
 		}
-		return 0;
+		retval = 0;
 		break;
 
 	case CDROMPLAYTRKIND:	/* Play a track.  This currently ignores index. */
@@ -2587,18 +2553,21 @@ static int scd_audio_ioctl(struct cdrom_
 
 			sony_get_toc();
 			if (!sony_toc_read) {
-				return -EIO;
+				retval = -EIO;
+				break;
 			}
 
 			if ((ti->cdti_trk0 < sony_toc.first_track_num)
 			    || (ti->cdti_trk0 > sony_toc.last_track_num)
 			    || (ti->cdti_trk1 < ti->cdti_trk0)) {
-				return -EINVAL;
+				retval = -EINVAL;
+				break;
 			}
 
 			track_idx = find_track(ti->cdti_trk0);
 			if (track_idx < 0) {
-				return -EINVAL;
+				retval = -EINVAL;
+				break;
 			}
 			params[1] =
 			    int_to_bcd(sony_toc.tracks[track_idx].
@@ -2620,7 +2589,8 @@ static int scd_audio_ioctl(struct cdrom_
 				track_idx = find_track(ti->cdti_trk1 + 1);
 			}
 			if (track_idx < 0) {
-				return -EINVAL;
+				retval = -EINVAL;
+				break;
 			}
 			params[4] =
 			    int_to_bcd(sony_toc.tracks[track_idx].
@@ -2649,7 +2619,8 @@ static int scd_audio_ioctl(struct cdrom_
 				printk(KERN_ERR PFX
 					"Error %s (CDROMPLAYTRKIND)\n",
 				     translate_error(res_reg[1]));
-				return -EIO;
+				retval = -EIO;
+				break;
 			}
 
 			/* Save the final position for pauses and resumes */
@@ -2657,7 +2628,8 @@ static int scd_audio_ioctl(struct cdrom_
 			final_pos_msf[1] = bcd_to_int(params[5]);
 			final_pos_msf[2] = bcd_to_int(params[6]);
 			sony_audio_status = CDROM_AUDIO_PLAY;
-			return 0;
+			retval = 0;
+			break;
 		}
 
 	case CDROMVOLCTRL:	/* Volume control.  What volume does this change, anyway? */
@@ -2668,25 +2640,32 @@ static int scd_audio_ioctl(struct cdrom_
 			params[0] = SONY_SD_AUDIO_VOLUME;
 			params[1] = volctrl->channel0;
 			params[2] = volctrl->channel1;
-			return do_sony_cd_cmd_chk("VOLCTRL",
+			retval = do_sony_cd_cmd_chk("VOLCTRL",
 						  SONY_SET_DRIVE_PARAM_CMD,
 						  params, 3, res_reg,
 						  &res_size);
+			break;
 		}
 	case CDROMSUBCHNL:	/* Get subchannel info */
-		return sony_get_subchnl_info((struct cdrom_subchnl *) arg);
+		retval = sony_get_subchnl_info((struct cdrom_subchnl *) arg);
+		break;
 
 	default:
-		return -EINVAL;
+		retval = -EINVAL;
+		break;
 	}
+	up(&sony_sem);
+	return retval;
 }
 
 static int scd_dev_ioctl(struct cdrom_device_info *cdi,
 			 unsigned int cmd, unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
-	int i;
+	int retval;
 
+	if (down_interruptible(&sony_sem))
+		return -ERESTARTSYS;
 	switch (cmd) {
 	case CDROMREADAUDIO:	/* Read 2352 byte audio tracks and 2340 byte
 				   raw data tracks. */
@@ -2696,33 +2675,39 @@ static int scd_dev_ioctl(struct cdrom_de
 
 			sony_get_toc();
 			if (!sony_toc_read) {
-				return -EIO;
+				retval = -EIO;
+				break;
 			}
 
-			if (copy_from_user(&ra, argp, sizeof(ra)))
-				return -EFAULT;
+			if (copy_from_user(&ra, argp, sizeof(ra))) {
+				retval = -EFAULT;
+				break;
+			}
 
 			if (ra.nframes == 0) {
-				return 0;
+				retval = 0;
+				break;
 			}
 
-			i = verify_area(VERIFY_WRITE, ra.buf,
+			retval = verify_area(VERIFY_WRITE, ra.buf,
 					CD_FRAMESIZE_RAW * ra.nframes);
-			if (i < 0)
-				return i;
+			if (retval < 0)
+				break;
 
 			if (ra.addr_format == CDROM_LBA) {
 				if ((ra.addr.lba >=
 				     sony_toc.lead_out_start_lba)
 				    || (ra.addr.lba + ra.nframes >=
 					sony_toc.lead_out_start_lba)) {
-					return -EINVAL;
+					retval = -EINVAL;
+					break;
 				}
 			} else if (ra.addr_format == CDROM_MSF) {
 				if ((ra.addr.msf.minute >= 75)
 				    || (ra.addr.msf.second >= 60)
 				    || (ra.addr.msf.frame >= 75)) {
-					return -EINVAL;
+					retval = -EINVAL;
+					break;
 				}
 
 				ra.addr.lba = ((ra.addr.msf.minute * 4500)
@@ -2732,7 +2717,8 @@ static int scd_dev_ioctl(struct cdrom_de
 				     sony_toc.lead_out_start_lba)
 				    || (ra.addr.lba + ra.nframes >=
 					sony_toc.lead_out_start_lba)) {
-					return -EINVAL;
+					retval = -EINVAL;
+					break;
 				}
 
 				/* I know, this can go negative on an unsigned.  However,
@@ -2740,16 +2726,21 @@ static int scd_dev_ioctl(struct cdrom_de
 				   so this should compensate and allow direct msf access. */
 				ra.addr.lba -= LOG_START_OFFSET;
 			} else {
-				return -EINVAL;
+				retval = -EINVAL;
+				break;
 			}
 
-			return read_audio(&ra);
+			retval = read_audio(&ra);
+			break;
 		}
-		return 0;
+		retval = 0;
+		break;
 
 	default:
-		return -EINVAL;
+		retval = -EINVAL;
 	}
+	up(&sony_sem);
+	return retval;
 }
 
 static int scd_spinup(void)
@@ -2922,6 +2913,8 @@ static int scd_block_release(struct inod
 static int scd_block_ioctl(struct inode *inode, struct file *file,
 				unsigned cmd, unsigned long arg)
 {
+	int retval;
+
 	/* The eject and close commands should be handled by Uniform CD-ROM
 	 * driver - but I always got hard lockup instead of eject
 	 * until I put this here.
@@ -2929,12 +2922,15 @@ static int scd_block_ioctl(struct inode 
 	switch (cmd) {
 		case CDROMEJECT:
 			scd_lock_door(&scd_info, 0);
-			return scd_tray_move(&scd_info, 1);
+			retval = scd_tray_move(&scd_info, 1);
+			break;
 		case CDROMCLOSETRAY:
-			return scd_tray_move(&scd_info, 0);
+			retval = scd_tray_move(&scd_info, 0);
+			break;
 		default:
-			return cdrom_ioctl(file, &scd_info, inode, cmd, arg);
+			retval = cdrom_ioctl(file, &scd_info, inode, cmd, arg);
 	}
+	return retval;
 }
 
 static int scd_block_media_changed(struct gendisk *disk)
