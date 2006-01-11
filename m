Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbWAKNRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWAKNRV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 08:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWAKNRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 08:17:21 -0500
Received: from verein.lst.de ([213.95.11.210]:19418 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751479AbWAKNRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 08:17:20 -0500
Date: Wed, 11 Jan 2006 14:17:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] cleanup cdrom_ioctl
Message-ID: <20060111131717.GA9491@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00,UPPERCASE_25_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

add a small helper for each ioctl to cut down cdrom_ioctl to a readable
size.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/drivers/cdrom/cdrom.c
===================================================================
--- linux-2.6.orig/drivers/cdrom/cdrom.c	2005-10-31 12:23:21.000000000 +0100
+++ linux-2.6/drivers/cdrom/cdrom.c	2005-11-18 04:21:18.000000000 +0100
@@ -2196,395 +2196,592 @@
 	return cdrom_read_cdda_old(cdi, ubuf, lba, nframes);	
 }
 
-/* Just about every imaginable ioctl is supported in the Uniform layer
- * these days. ATAPI / SCSI specific code now mainly resides in
- * mmc_ioct().
- */
-int cdrom_ioctl(struct file * file, struct cdrom_device_info *cdi,
-		struct inode *ip, unsigned int cmd, unsigned long arg)
+static int cdrom_ioctl_multisession(struct cdrom_device_info *cdi,
+		void __user *argp)
 {
-	struct cdrom_device_ops *cdo = cdi->ops;
+	struct cdrom_multisession ms_info;
+	u8 requested_format;
 	int ret;
 
-	/* Try the generic SCSI command ioctl's first.. */
-	ret = scsi_cmd_ioctl(file, ip->i_bdev->bd_disk, cmd, (void __user *)arg);
-	if (ret != -ENOTTY)
+	cdinfo(CD_DO_IOCTL, "entering CDROMMULTISESSION\n");
+
+	if (!(cdi->ops->capability & CDC_MULTI_SESSION))
+		return -ENOSYS;
+
+	if (copy_from_user(&ms_info, argp, sizeof(ms_info)))
+		return -EFAULT;
+
+	requested_format = ms_info.addr_format;
+	if (requested_format != CDROM_MSF && requested_format != CDROM_LBA)
+		return -EINVAL;
+	ms_info.addr_format = CDROM_LBA;
+
+	ret = cdi->ops->get_last_session(cdi, &ms_info);
+	if (ret)
 		return ret;
 
-	/* the first few commands do not deal with audio drive_info, but
-	   only with routines in cdrom device operations. */
-	switch (cmd) {
-	case CDROMMULTISESSION: {
-		struct cdrom_multisession ms_info;
-		u_char requested_format;
-		cdinfo(CD_DO_IOCTL, "entering CDROMMULTISESSION\n"); 
-                if (!(cdo->capability & CDC_MULTI_SESSION))
-                        return -ENOSYS;
-		IOCTL_IN(arg, struct cdrom_multisession, ms_info);
-		requested_format = ms_info.addr_format;
-		if (!((requested_format == CDROM_MSF) ||
-			(requested_format == CDROM_LBA)))
-				return -EINVAL;
-		ms_info.addr_format = CDROM_LBA;
-		if ((ret=cdo->get_last_session(cdi, &ms_info)))
+	sanitize_format(&ms_info.addr, &ms_info.addr_format, requested_format);
+
+	if (copy_to_user(argp, &ms_info, sizeof(ms_info)))
+		return -EFAULT;
+
+	cdinfo(CD_DO_IOCTL, "CDROMMULTISESSION successful\n");
+	return 0;
+}
+
+static int cdrom_ioctl_eject(struct cdrom_device_info *cdi)
+{
+	cdinfo(CD_DO_IOCTL, "entering CDROMEJECT\n");
+
+	if (!CDROM_CAN(CDC_OPEN_TRAY))
+		return -ENOSYS;
+	if (cdi->use_count != 1 || keeplocked)
+		return -EBUSY;
+	if (CDROM_CAN(CDC_LOCK)) {
+		int ret = cdi->ops->lock_door(cdi, 0);
+		if (ret)
 			return ret;
-		sanitize_format(&ms_info.addr, &ms_info.addr_format,
-				requested_format);
-		IOCTL_OUT(arg, struct cdrom_multisession, ms_info);
-		cdinfo(CD_DO_IOCTL, "CDROMMULTISESSION successful\n"); 
-		return 0;
-		}
+	}
 
-	case CDROMEJECT: {
-		cdinfo(CD_DO_IOCTL, "entering CDROMEJECT\n"); 
-		if (!CDROM_CAN(CDC_OPEN_TRAY))
-			return -ENOSYS;
-		if (cdi->use_count != 1 || keeplocked)
-			return -EBUSY;
-		if (CDROM_CAN(CDC_LOCK))
-			if ((ret=cdo->lock_door(cdi, 0)))
-				return ret;
+	return cdi->ops->tray_move(cdi, 1);
+}
 
-		return cdo->tray_move(cdi, 1);
-		}
+static int cdrom_ioctl_closetray(struct cdrom_device_info *cdi)
+{
+	cdinfo(CD_DO_IOCTL, "entering CDROMCLOSETRAY\n");
 
-	case CDROMCLOSETRAY: {
-		cdinfo(CD_DO_IOCTL, "entering CDROMCLOSETRAY\n"); 
-		if (!CDROM_CAN(CDC_CLOSE_TRAY))
-			return -ENOSYS;
-		return cdo->tray_move(cdi, 0);
-		}
+	if (!CDROM_CAN(CDC_CLOSE_TRAY))
+		return -ENOSYS;
+	return cdi->ops->tray_move(cdi, 0);
+}
 
-	case CDROMEJECT_SW: {
-		cdinfo(CD_DO_IOCTL, "entering CDROMEJECT_SW\n"); 
-		if (!CDROM_CAN(CDC_OPEN_TRAY))
-			return -ENOSYS;
-		if (keeplocked)
-			return -EBUSY;
-		cdi->options &= ~(CDO_AUTO_CLOSE | CDO_AUTO_EJECT);
-		if (arg)
-			cdi->options |= CDO_AUTO_CLOSE | CDO_AUTO_EJECT;
-		return 0;
-		}
+static int cdrom_ioctl_eject_sw(struct cdrom_device_info *cdi,
+		unsigned long arg)
+{
+	cdinfo(CD_DO_IOCTL, "entering CDROMEJECT_SW\n");
 
-	case CDROM_MEDIA_CHANGED: {
-		struct cdrom_changer_info *info;
-		int changed;
+	if (!CDROM_CAN(CDC_OPEN_TRAY))
+		return -ENOSYS;
+	if (keeplocked)
+		return -EBUSY;
+
+	cdi->options &= ~(CDO_AUTO_CLOSE | CDO_AUTO_EJECT);
+	if (arg)
+		cdi->options |= CDO_AUTO_CLOSE | CDO_AUTO_EJECT;
+	return 0;
+}
+
+static int cdrom_ioctl_media_changed(struct cdrom_device_info *cdi,
+		unsigned long arg)
+{
+	struct cdrom_changer_info *info;
+	int ret;
+
+	cdinfo(CD_DO_IOCTL, "entering CDROM_MEDIA_CHANGED\n");
+
+	if (!CDROM_CAN(CDC_MEDIA_CHANGED))
+		return -ENOSYS;
+
+	/* cannot select disc or select current disc */
+	if (!CDROM_CAN(CDC_SELECT_DISC) || arg == CDSL_CURRENT)
+		return media_changed(cdi, 1);
+
+	if ((unsigned int)arg >= cdi->capacity)
+		return -EINVAL;
+
+	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	ret = cdrom_read_mech_status(cdi, info);
+	if (!ret)
+		ret = info->slots[arg].change;
+	kfree(info);
+	return ret;
+}
+
+static int cdrom_ioctl_set_options(struct cdrom_device_info *cdi,
+		unsigned long arg)
+{
+	cdinfo(CD_DO_IOCTL, "entering CDROM_SET_OPTIONS\n");
 
-		cdinfo(CD_DO_IOCTL, "entering CDROM_MEDIA_CHANGED\n"); 
-		if (!CDROM_CAN(CDC_MEDIA_CHANGED))
+	/*
+	 * Options need to be in sync with capability.
+	 * Too late for that, so we have to check each one separately.
+	 */
+	switch (arg) {
+	case CDO_USE_FFLAGS:
+	case CDO_CHECK_TYPE:
+		break;
+	case CDO_LOCK:
+		if (!CDROM_CAN(CDC_LOCK))
+			return -ENOSYS;
+		break;
+	case 0:
+		return cdi->options;
+	/* default is basically CDO_[AUTO_CLOSE|AUTO_EJECT] */
+	default:
+		if (!CDROM_CAN(arg))
 			return -ENOSYS;
+	}
+	cdi->options |= (int) arg;
+	return cdi->options;
+}
 
-		/* cannot select disc or select current disc */
-		if (!CDROM_CAN(CDC_SELECT_DISC) || arg == CDSL_CURRENT)
-			return media_changed(cdi, 1);
+static int cdrom_ioctl_clear_options(struct cdrom_device_info *cdi,
+		unsigned long arg)
+{
+	cdinfo(CD_DO_IOCTL, "entering CDROM_CLEAR_OPTIONS\n");
 
-		if ((unsigned int)arg >= cdi->capacity)
-			return -EINVAL;
+	cdi->options &= ~(int) arg;
+	return cdi->options;
+}
 
-		info = kmalloc(sizeof(*info), GFP_KERNEL);
-		if (!info)
-			return -ENOMEM;
+static int cdrom_ioctl_select_speed(struct cdrom_device_info *cdi,
+		unsigned long arg)
+{
+	cdinfo(CD_DO_IOCTL, "entering CDROM_SELECT_SPEED\n");
 
-		if ((ret = cdrom_read_mech_status(cdi, info))) {
-			kfree(info);
-			return ret;
-		}
+	if (!CDROM_CAN(CDC_SELECT_SPEED))
+		return -ENOSYS;
+	return cdi->ops->select_speed(cdi, arg);
+}
 
-		changed = info->slots[arg].change;
-		kfree(info);
-		return changed;
-		}
+static int cdrom_ioctl_select_disc(struct cdrom_device_info *cdi,
+		unsigned long arg)
+{
+	cdinfo(CD_DO_IOCTL, "entering CDROM_SELECT_DISC\n");
 
-	case CDROM_SET_OPTIONS: {
-		cdinfo(CD_DO_IOCTL, "entering CDROM_SET_OPTIONS\n"); 
-		/* options need to be in sync with capability. too late for
-		   that, so we have to check each one separately... */
-		switch (arg) {
-		case CDO_USE_FFLAGS:
-		case CDO_CHECK_TYPE:
-			break;
-		case CDO_LOCK:
-			if (!CDROM_CAN(CDC_LOCK))
-				return -ENOSYS;
-			break;
-		case 0:
-			return cdi->options;
-		/* default is basically CDO_[AUTO_CLOSE|AUTO_EJECT] */
-		default:
-			if (!CDROM_CAN(arg))
-				return -ENOSYS;
-		}
-		cdi->options |= (int) arg;
-		return cdi->options;
-		}
+	if (!CDROM_CAN(CDC_SELECT_DISC))
+		return -ENOSYS;
 
-	case CDROM_CLEAR_OPTIONS: {
-		cdinfo(CD_DO_IOCTL, "entering CDROM_CLEAR_OPTIONS\n"); 
-		cdi->options &= ~(int) arg;
-		return cdi->options;
-		}
+	if (arg != CDSL_CURRENT && arg != CDSL_NONE) {
+		if ((int)arg >= cdi->capacity)
+			return -EINVAL;
+	}
 
-	case CDROM_SELECT_SPEED: {
-		cdinfo(CD_DO_IOCTL, "entering CDROM_SELECT_SPEED\n"); 
-		if (!CDROM_CAN(CDC_SELECT_SPEED))
-			return -ENOSYS;
-		return cdo->select_speed(cdi, arg);
-		}
+	/*
+	 * ->select_disc is a hook to allow a driver-specific way of
+	 * seleting disc.  However, since there is no equivalent hook for
+	 * cdrom_slot_status this may not actually be useful...
+	 */
+	if (cdi->ops->select_disc)
+		return cdi->ops->select_disc(cdi, arg);
 
-	case CDROM_SELECT_DISC: {
-		cdinfo(CD_DO_IOCTL, "entering CDROM_SELECT_DISC\n"); 
-		if (!CDROM_CAN(CDC_SELECT_DISC))
-			return -ENOSYS;
+	cdinfo(CD_CHANGER, "Using generic cdrom_select_disc()\n");
+	return cdrom_select_disc(cdi, arg);
+}
 
-                if ((arg != CDSL_CURRENT) && (arg != CDSL_NONE))
-			if ((int)arg >= cdi->capacity)
-				return -EINVAL;
-
-		/* cdo->select_disc is a hook to allow a driver-specific
-		 * way of seleting disc.  However, since there is no
-		 * equiv hook for cdrom_slot_status this may not 
-		 * actually be useful...
-		 */
-		if (cdo->select_disc != NULL)
-			return cdo->select_disc(cdi, arg);
-
-		/* no driver specific select_disc(), call our own */
-		cdinfo(CD_CHANGER, "Using generic cdrom_select_disc()\n"); 
-		return cdrom_select_disc(cdi, arg);
-		}
+static int cdrom_ioctl_reset(struct cdrom_device_info *cdi,
+		struct block_device *bdev)
+{
+	cdinfo(CD_DO_IOCTL, "entering CDROM_RESET\n");
 
-	case CDROMRESET: {
-		if (!capable(CAP_SYS_ADMIN))
-			return -EACCES;
-		cdinfo(CD_DO_IOCTL, "entering CDROM_RESET\n");
-		if (!CDROM_CAN(CDC_RESET))
-			return -ENOSYS;
-		invalidate_bdev(ip->i_bdev, 0);
-		return cdo->reset(cdi);
-		}
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+	if (!CDROM_CAN(CDC_RESET))
+		return -ENOSYS;
+	invalidate_bdev(bdev, 0);
+	return cdi->ops->reset(cdi);
+}
 
-	case CDROM_LOCKDOOR: {
-		cdinfo(CD_DO_IOCTL, "%socking door.\n", arg ? "L" : "Unl");
-		if (!CDROM_CAN(CDC_LOCK))
-			return -EDRIVE_CANT_DO_THIS;
-		keeplocked = arg ? 1 : 0;
-		/* don't unlock the door on multiple opens,but allow root
-		 * to do so */
-		if ((cdi->use_count != 1) && !arg && !capable(CAP_SYS_ADMIN))
-			return -EBUSY;
-		return cdo->lock_door(cdi, arg);
-		}
+static int cdrom_ioctl_lock_door(struct cdrom_device_info *cdi,
+		unsigned long arg)
+{
+	cdinfo(CD_DO_IOCTL, "%socking door.\n", arg ? "L" : "Unl");
 
-	case CDROM_DEBUG: {
-		if (!capable(CAP_SYS_ADMIN))
-			return -EACCES;
-		cdinfo(CD_DO_IOCTL, "%sabling debug.\n", arg ? "En" : "Dis");
-		debug = arg ? 1 : 0;
-		return debug;
-		}
+	if (!CDROM_CAN(CDC_LOCK))
+		return -EDRIVE_CANT_DO_THIS;
 
-	case CDROM_GET_CAPABILITY: {
-		cdinfo(CD_DO_IOCTL, "entering CDROM_GET_CAPABILITY\n");
-		return (cdo->capability & ~cdi->mask);
-		}
+	keeplocked = arg ? 1 : 0;
+
+	/*
+	 * Don't unlock the door on multiple opens by default, but allow
+	 * root to do so.
+	 */
+	if (cdi->use_count != 1 && !arg && !capable(CAP_SYS_ADMIN))
+		return -EBUSY;
+	return cdi->ops->lock_door(cdi, arg);
+}
+
+static int cdrom_ioctl_debug(struct cdrom_device_info *cdi,
+		unsigned long arg)
+{
+	cdinfo(CD_DO_IOCTL, "%sabling debug.\n", arg ? "En" : "Dis");
 
-/* The following function is implemented, although very few audio
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+	debug = arg ? 1 : 0;
+	return debug;
+}
+
+static int cdrom_ioctl_get_capability(struct cdrom_device_info *cdi)
+{
+	cdinfo(CD_DO_IOCTL, "entering CDROM_GET_CAPABILITY\n");
+	return (cdi->ops->capability & ~cdi->mask);
+}
+
+/*
+ * The following function is implemented, although very few audio
  * discs give Universal Product Code information, which should just be
  * the Medium Catalog Number on the box.  Note, that the way the code
  * is written on the CD is /not/ uniform across all discs!
  */
-	case CDROM_GET_MCN: {
-		struct cdrom_mcn mcn;
-		cdinfo(CD_DO_IOCTL, "entering CDROM_GET_MCN\n"); 
-		if (!(cdo->capability & CDC_MCN))
-			return -ENOSYS;
-		if ((ret=cdo->get_mcn(cdi, &mcn)))
-			return ret;
-		IOCTL_OUT(arg, struct cdrom_mcn, mcn);
-		cdinfo(CD_DO_IOCTL, "CDROM_GET_MCN successful\n"); 
-		return 0;
-		}
+static int cdrom_ioctl_get_mcn(struct cdrom_device_info *cdi,
+		void __user *argp)
+{
+	struct cdrom_mcn mcn;
+	int ret;
 
-	case CDROM_DRIVE_STATUS: {
-		cdinfo(CD_DO_IOCTL, "entering CDROM_DRIVE_STATUS\n"); 
-		if (!(cdo->capability & CDC_DRIVE_STATUS))
-			return -ENOSYS;
-		if (!CDROM_CAN(CDC_SELECT_DISC))
-			return cdo->drive_status(cdi, CDSL_CURRENT);
-                if ((arg == CDSL_CURRENT) || (arg == CDSL_NONE)) 
-			return cdo->drive_status(cdi, CDSL_CURRENT);
-		if (((int)arg >= cdi->capacity))
-			return -EINVAL;
-		return cdrom_slot_status(cdi, arg);
-		}
+	cdinfo(CD_DO_IOCTL, "entering CDROM_GET_MCN\n");
 
-	/* Ok, this is where problems start.  The current interface for the
-	   CDROM_DISC_STATUS ioctl is flawed.  It makes the false assumption
-	   that CDs are all CDS_DATA_1 or all CDS_AUDIO, etc.  Unfortunatly,
-	   while this is often the case, it is also very common for CDs to
-	   have some tracks with data, and some tracks with audio.  Just 
-	   because I feel like it, I declare the following to be the best
-	   way to cope.  If the CD has ANY data tracks on it, it will be
-	   returned as a data CD.  If it has any XA tracks, I will return
-	   it as that.  Now I could simplify this interface by combining these 
-	   returns with the above, but this more clearly demonstrates
-	   the problem with the current interface.  Too bad this wasn't 
-	   designed to use bitmasks...         -Erik 
-
-	   Well, now we have the option CDS_MIXED: a mixed-type CD. 
-	   User level programmers might feel the ioctl is not very useful.
-	   					---david
-	*/
-	case CDROM_DISC_STATUS: {
-		tracktype tracks;
-		cdinfo(CD_DO_IOCTL, "entering CDROM_DISC_STATUS\n"); 
-		cdrom_count_tracks(cdi, &tracks);
-		if (tracks.error) 
-			return(tracks.error);
-
-		/* Policy mode on */
-		if (tracks.audio > 0) {
-			if (tracks.data==0 && tracks.cdi==0 && tracks.xa==0) 
-				return CDS_AUDIO;
-			else
-				return CDS_MIXED;
-		}
-		if (tracks.cdi > 0) return CDS_XA_2_2;
-		if (tracks.xa > 0) return CDS_XA_2_1;
-		if (tracks.data > 0) return CDS_DATA_1;
-		/* Policy mode off */
+	if (!(cdi->ops->capability & CDC_MCN))
+		return -ENOSYS;
+	ret = cdi->ops->get_mcn(cdi, &mcn);
+	if (ret)
+		return ret;
 
-		cdinfo(CD_WARNING,"This disc doesn't have any tracks I recognize!\n");
-		return CDS_NO_INFO;
-		}
+	if (copy_to_user(argp, &mcn, sizeof(mcn)))
+		return -EFAULT;
+	cdinfo(CD_DO_IOCTL, "CDROM_GET_MCN successful\n");
+	return 0;
+}
 
-	case CDROM_CHANGER_NSLOTS: {
-		cdinfo(CD_DO_IOCTL, "entering CDROM_CHANGER_NSLOTS\n"); 
-		return cdi->capacity;
-		}
+static int cdrom_ioctl_drive_status(struct cdrom_device_info *cdi,
+		unsigned long arg)
+{
+	cdinfo(CD_DO_IOCTL, "entering CDROM_DRIVE_STATUS\n");
+
+	if (!(cdi->ops->capability & CDC_DRIVE_STATUS))
+		return -ENOSYS;
+	if (!CDROM_CAN(CDC_SELECT_DISC) ||
+	    (arg == CDSL_CURRENT || arg == CDSL_NONE))
+		return cdi->ops->drive_status(cdi, CDSL_CURRENT);
+	if (((int)arg >= cdi->capacity))
+		return -EINVAL;
+	return cdrom_slot_status(cdi, arg);
+}
+
+/*
+ * Ok, this is where problems start.  The current interface for the
+ * CDROM_DISC_STATUS ioctl is flawed.  It makes the false assumption that
+ * CDs are all CDS_DATA_1 or all CDS_AUDIO, etc.  Unfortunatly, while this
+ * is often the case, it is also very common for CDs to have some tracks
+ * with data, and some tracks with audio.  Just because I feel like it,
+ * I declare the following to be the best way to cope.  If the CD has ANY
+ * data tracks on it, it will be returned as a data CD.  If it has any XA
+ * tracks, I will return it as that.  Now I could simplify this interface
+ * by combining these  returns with the above, but this more clearly
+ * demonstrates the problem with the current interface.  Too bad this
+ * wasn't designed to use bitmasks...         -Erik
+ *
+ * Well, now we have the option CDS_MIXED: a mixed-type CD.
+ * User level programmers might feel the ioctl is not very useful.
+ *					---david
+ */
+static int cdrom_ioctl_disc_status(struct cdrom_device_info *cdi)
+{
+	tracktype tracks;
+
+	cdinfo(CD_DO_IOCTL, "entering CDROM_DISC_STATUS\n");
+
+	cdrom_count_tracks(cdi, &tracks);
+	if (tracks.error)
+		return tracks.error;
+
+	/* Policy mode on */
+	if (tracks.audio > 0) {
+		if (!tracks.data && !tracks.cdi && !tracks.xa)
+			return CDS_AUDIO;
+		else
+			return CDS_MIXED;
+	}
+
+	if (tracks.cdi > 0)
+		return CDS_XA_2_2;
+	if (tracks.xa > 0)
+		return CDS_XA_2_1;
+	if (tracks.data > 0)
+		return CDS_DATA_1;
+	/* Policy mode off */
+
+	cdinfo(CD_WARNING,"This disc doesn't have any tracks I recognize!\n");
+	return CDS_NO_INFO;
+}
+
+static int cdrom_ioctl_changer_nslots(struct cdrom_device_info *cdi)
+{
+	cdinfo(CD_DO_IOCTL, "entering CDROM_CHANGER_NSLOTS\n");
+	return cdi->capacity;
+}
+
+static int cdrom_ioctl_get_subchnl(struct cdrom_device_info *cdi,
+		void __user *argp)
+{
+	struct cdrom_subchnl q;
+	u8 requested, back;
+	int ret;
+
+	/* cdinfo(CD_DO_IOCTL,"entering CDROMSUBCHNL\n");*/
+
+	if (!CDROM_CAN(CDC_PLAY_AUDIO))
+		return -ENOSYS;
+	if (copy_from_user(&q, argp, sizeof(q)))
+		return -EFAULT;
+
+	requested = q.cdsc_format;
+	if (requested != CDROM_MSF && requested != CDROM_LBA)
+		return -EINVAL;
+	q.cdsc_format = CDROM_MSF;
+
+	ret = cdi->ops->audio_ioctl(cdi, CDROMSUBCHNL, &q);
+	if (ret)
+		return ret;
+
+	back = q.cdsc_format; /* local copy */
+	sanitize_format(&q.cdsc_absaddr, &back, requested);
+	sanitize_format(&q.cdsc_reladdr, &q.cdsc_format, requested);
+
+	if (copy_to_user(argp, &q, sizeof(q)))
+		return -EFAULT;
+	/* cdinfo(CD_DO_IOCTL, "CDROMSUBCHNL successful\n"); */
+	return 0;
+}
+
+static int cdrom_ioctl_read_tochdr(struct cdrom_device_info *cdi,
+		void __user *argp)
+{
+	struct cdrom_tochdr header;
+	int ret;
+
+	/* cdinfo(CD_DO_IOCTL, "entering CDROMREADTOCHDR\n"); */
+
+	if (!CDROM_CAN(CDC_PLAY_AUDIO))
+		return -ENOSYS;
+	if (copy_from_user(&header, argp, sizeof(header)))
+		return -EFAULT;
+
+	ret = cdi->ops->audio_ioctl(cdi, CDROMREADTOCHDR, &header);
+	if (ret)
+		return ret;
+
+	if (copy_to_user(argp, &header, sizeof(header)))
+		return -EFAULT;
+	/* cdinfo(CD_DO_IOCTL, "CDROMREADTOCHDR successful\n"); */
+	return 0;
+}
+
+static int cdrom_ioctl_read_tocentry(struct cdrom_device_info *cdi,
+		void __user *argp)
+{
+	struct cdrom_tocentry entry;
+	u8 requested_format;
+	int ret;
+
+	/* cdinfo(CD_DO_IOCTL, "entering CDROMREADTOCENTRY\n"); */
+
+	if (!CDROM_CAN(CDC_PLAY_AUDIO))
+		return -ENOSYS;
+	if (copy_from_user(&entry, argp, sizeof(entry)))
+		return -EFAULT;
+
+	requested_format = entry.cdte_format;
+	if (requested_format != CDROM_MSF || requested_format != CDROM_LBA)
+		return -EINVAL;
+	/* make interface to low-level uniform */
+	entry.cdte_format = CDROM_MSF;
+	ret = cdi->ops->audio_ioctl(cdi, CDROMREADTOCENTRY, &entry);
+	if (ret)
+		return ret;
+	sanitize_format(&entry.cdte_addr, &entry.cdte_format, requested_format);
+
+	if (copy_to_user(argp, &entry, sizeof(entry)))
+		return -EFAULT;
+	/* cdinfo(CD_DO_IOCTL, "CDROMREADTOCENTRY successful\n"); */
+	return 0;
+}
+
+static int cdrom_ioctl_play_msf(struct cdrom_device_info *cdi,
+		void __user *argp)
+{
+	struct cdrom_msf msf;
+
+	cdinfo(CD_DO_IOCTL, "entering CDROMPLAYMSF\n");
+
+	if (!CDROM_CAN(CDC_PLAY_AUDIO))
+		return -ENOSYS;
+	if (copy_from_user(&msf, argp, sizeof(msf)))
+		return -EFAULT;
+	return cdi->ops->audio_ioctl(cdi, CDROMPLAYMSF, &msf);
+}
+
+static int cdrom_ioctl_play_trkind(struct cdrom_device_info *cdi,
+		void __user *argp)
+{
+	struct cdrom_ti ti;
+	int ret;
+
+	cdinfo(CD_DO_IOCTL, "entering CDROMPLAYTRKIND\n");
+
+	if (!CDROM_CAN(CDC_PLAY_AUDIO))
+		return -ENOSYS;
+	if (copy_from_user(&ti, argp, sizeof(ti)))
+		return -EFAULT;
+
+	ret = check_for_audio_disc(cdi, cdi->ops);
+	if (ret)
+		return ret;
+	return cdi->ops->audio_ioctl(cdi, CDROMPLAYTRKIND, &ti);
+}
+static int cdrom_ioctl_volctrl(struct cdrom_device_info *cdi,
+		void __user *argp)
+{
+	struct cdrom_volctrl volume;
+
+	cdinfo(CD_DO_IOCTL, "entering CDROMVOLCTRL\n");
+
+	if (!CDROM_CAN(CDC_PLAY_AUDIO))
+		return -ENOSYS;
+	if (copy_from_user(&volume, argp, sizeof(volume)))
+		return -EFAULT;
+	return cdi->ops->audio_ioctl(cdi, CDROMVOLCTRL, &volume);
+}
+
+static int cdrom_ioctl_volread(struct cdrom_device_info *cdi,
+		void __user *argp)
+{
+	struct cdrom_volctrl volume;
+	int ret;
+
+	cdinfo(CD_DO_IOCTL, "entering CDROMVOLREAD\n");
+
+	if (!CDROM_CAN(CDC_PLAY_AUDIO))
+		return -ENOSYS;
+
+	ret = cdi->ops->audio_ioctl(cdi, CDROMVOLREAD, &volume);
+	if (ret)
+		return ret;
+
+	if (copy_to_user(argp, &volume, sizeof(volume)))
+		return -EFAULT;
+	return 0;
+}
+
+static int cdrom_ioctl_audioctl(struct cdrom_device_info *cdi,
+		unsigned int cmd)
+{
+	int ret;
+
+	cdinfo(CD_DO_IOCTL, "doing audio ioctl (start/stop/pause/resume)\n");
+
+	if (!CDROM_CAN(CDC_PLAY_AUDIO))
+		return -ENOSYS;
+	ret = check_for_audio_disc(cdi, cdi->ops);
+	if (ret)
+		return ret;
+	return cdi->ops->audio_ioctl(cdi, cmd, NULL);
+}
+
+/*
+ * Just about every imaginable ioctl is supported in the Uniform layer
+ * these days.
+ * ATAPI / SCSI specific code now mainly resides in mmc_ioctl().
+ */
+int cdrom_ioctl(struct file * file, struct cdrom_device_info *cdi,
+		struct inode *ip, unsigned int cmd, unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+	int ret;
+
+	/*
+	 * Try the generic SCSI command ioctl's first.
+	 */
+	ret = scsi_cmd_ioctl(file, ip->i_bdev->bd_disk, cmd, argp);
+	if (ret != -ENOTTY)
+		return ret;
+
+	switch (cmd) {
+	case CDROMMULTISESSION:
+		return cdrom_ioctl_multisession(cdi, argp);
+	case CDROMEJECT:
+		return cdrom_ioctl_eject(cdi);
+	case CDROMCLOSETRAY:
+		return cdrom_ioctl_closetray(cdi);
+	case CDROMEJECT_SW:
+		return cdrom_ioctl_eject_sw(cdi, arg);
+	case CDROM_MEDIA_CHANGED:
+		return cdrom_ioctl_media_changed(cdi, arg);
+	case CDROM_SET_OPTIONS:
+		return cdrom_ioctl_set_options(cdi, arg);
+	case CDROM_CLEAR_OPTIONS:
+		return cdrom_ioctl_clear_options(cdi, arg);
+	case CDROM_SELECT_SPEED:
+		return cdrom_ioctl_select_speed(cdi, arg);
+	case CDROM_SELECT_DISC:
+		return cdrom_ioctl_select_disc(cdi, arg);
+	case CDROMRESET:
+		return cdrom_ioctl_reset(cdi, ip->i_bdev);
+	case CDROM_LOCKDOOR:
+		return cdrom_ioctl_lock_door(cdi, arg);
+	case CDROM_DEBUG:
+		return cdrom_ioctl_debug(cdi, arg);
+	case CDROM_GET_CAPABILITY:
+		return cdrom_ioctl_get_capability(cdi);
+	case CDROM_GET_MCN:
+		return cdrom_ioctl_get_mcn(cdi, argp);
+	case CDROM_DRIVE_STATUS:
+		return cdrom_ioctl_drive_status(cdi, arg);
+	case CDROM_DISC_STATUS:
+		return cdrom_ioctl_disc_status(cdi);
+	case CDROM_CHANGER_NSLOTS:
+		return cdrom_ioctl_changer_nslots(cdi);
 	}
 
-	/* use the ioctls that are implemented through the generic_packet()
-	   interface. this may look at bit funny, but if -ENOTTY is
-	   returned that particular ioctl is not implemented and we
-	   let it go through the device specific ones. */
+	/*
+	 * Use the ioctls that are implemented through the generic_packet()
+	 * interface. this may look at bit funny, but if -ENOTTY is
+	 * returned that particular ioctl is not implemented and we
+	 * let it go through the device specific ones.
+	 */
 	if (CDROM_CAN(CDC_GENERIC_PACKET)) {
 		ret = mmc_ioctl(cdi, cmd, arg);
-		if (ret != -ENOTTY) {
+		if (ret != -ENOTTY)
 			return ret;
-		}
 	}
 
-	/* note: most of the cdinfo() calls are commented out here,
-	   because they fill up the sys log when CD players poll
-	   the drive. */
+	/*
+	 * Note: most of the cdinfo() calls are commented out here,
+	 * because they fill up the sys log when CD players poll
+	 * the drive.
+	 */
 	switch (cmd) {
-	case CDROMSUBCHNL: {
-		struct cdrom_subchnl q;
-		u_char requested, back;
-		if (!CDROM_CAN(CDC_PLAY_AUDIO))
-			return -ENOSYS;
-		/* cdinfo(CD_DO_IOCTL,"entering CDROMSUBCHNL\n");*/ 
-		IOCTL_IN(arg, struct cdrom_subchnl, q);
-		requested = q.cdsc_format;
-		if (!((requested == CDROM_MSF) ||
-		      (requested == CDROM_LBA)))
-			return -EINVAL;
-		q.cdsc_format = CDROM_MSF;
-		if ((ret=cdo->audio_ioctl(cdi, cmd, &q)))
-			return ret;
-		back = q.cdsc_format; /* local copy */
-		sanitize_format(&q.cdsc_absaddr, &back, requested);
-		sanitize_format(&q.cdsc_reladdr, &q.cdsc_format, requested);
-		IOCTL_OUT(arg, struct cdrom_subchnl, q);
-		/* cdinfo(CD_DO_IOCTL, "CDROMSUBCHNL successful\n"); */ 
-		return 0;
-		}
-	case CDROMREADTOCHDR: {
-		struct cdrom_tochdr header;
-		if (!CDROM_CAN(CDC_PLAY_AUDIO))
-			return -ENOSYS;
-		/* cdinfo(CD_DO_IOCTL, "entering CDROMREADTOCHDR\n"); */ 
-		IOCTL_IN(arg, struct cdrom_tochdr, header);
-		if ((ret=cdo->audio_ioctl(cdi, cmd, &header)))
-			return ret;
-		IOCTL_OUT(arg, struct cdrom_tochdr, header);
-		/* cdinfo(CD_DO_IOCTL, "CDROMREADTOCHDR successful\n"); */ 
-		return 0;
-		}
-	case CDROMREADTOCENTRY: {
-		struct cdrom_tocentry entry;
-		u_char requested_format;
-		if (!CDROM_CAN(CDC_PLAY_AUDIO))
-			return -ENOSYS;
-		/* cdinfo(CD_DO_IOCTL, "entering CDROMREADTOCENTRY\n"); */ 
-		IOCTL_IN(arg, struct cdrom_tocentry, entry);
-		requested_format = entry.cdte_format;
-		if (!((requested_format == CDROM_MSF) || 
-			(requested_format == CDROM_LBA)))
-				return -EINVAL;
-		/* make interface to low-level uniform */
-		entry.cdte_format = CDROM_MSF;
-		if ((ret=cdo->audio_ioctl(cdi, cmd, &entry)))
-			return ret;
-		sanitize_format(&entry.cdte_addr,
-		&entry.cdte_format, requested_format);
-		IOCTL_OUT(arg, struct cdrom_tocentry, entry);
-		/* cdinfo(CD_DO_IOCTL, "CDROMREADTOCENTRY successful\n"); */ 
-		return 0;
-		}
-	case CDROMPLAYMSF: {
-		struct cdrom_msf msf;
-		if (!CDROM_CAN(CDC_PLAY_AUDIO))
-			return -ENOSYS;
-		cdinfo(CD_DO_IOCTL, "entering CDROMPLAYMSF\n"); 
-		IOCTL_IN(arg, struct cdrom_msf, msf);
-		return cdo->audio_ioctl(cdi, cmd, &msf);
-		}
-	case CDROMPLAYTRKIND: {
-		struct cdrom_ti ti;
-		if (!CDROM_CAN(CDC_PLAY_AUDIO))
-			return -ENOSYS;
-		cdinfo(CD_DO_IOCTL, "entering CDROMPLAYTRKIND\n"); 
-		IOCTL_IN(arg, struct cdrom_ti, ti);
-		CHECKAUDIO;
-		return cdo->audio_ioctl(cdi, cmd, &ti);
-		}
-	case CDROMVOLCTRL: {
-		struct cdrom_volctrl volume;
-		if (!CDROM_CAN(CDC_PLAY_AUDIO))
-			return -ENOSYS;
-		cdinfo(CD_DO_IOCTL, "entering CDROMVOLCTRL\n"); 
-		IOCTL_IN(arg, struct cdrom_volctrl, volume);
-		return cdo->audio_ioctl(cdi, cmd, &volume);
-		}
-	case CDROMVOLREAD: {
-		struct cdrom_volctrl volume;
-		if (!CDROM_CAN(CDC_PLAY_AUDIO))
-			return -ENOSYS;
-		cdinfo(CD_DO_IOCTL, "entering CDROMVOLREAD\n"); 
-		if ((ret=cdo->audio_ioctl(cdi, cmd, &volume)))
-			return ret;
-		IOCTL_OUT(arg, struct cdrom_volctrl, volume);
-		return 0;
-		}
+	case CDROMSUBCHNL:
+		return cdrom_ioctl_get_subchnl(cdi, argp);
+	case CDROMREADTOCHDR:
+		return cdrom_ioctl_read_tochdr(cdi, argp);
+	case CDROMREADTOCENTRY:
+		return cdrom_ioctl_read_tocentry(cdi, argp);
+	case CDROMPLAYMSF:
+		return cdrom_ioctl_play_msf(cdi, argp);
+	case CDROMPLAYTRKIND:
+		return cdrom_ioctl_play_trkind(cdi, argp);
+	case CDROMVOLCTRL:
+		return cdrom_ioctl_volctrl(cdi, argp);
+	case CDROMVOLREAD:
+		return cdrom_ioctl_volread(cdi, argp);
 	case CDROMSTART:
 	case CDROMSTOP:
 	case CDROMPAUSE:
-	case CDROMRESUME: {
-		if (!CDROM_CAN(CDC_PLAY_AUDIO))
-			return -ENOSYS;
-		cdinfo(CD_DO_IOCTL, "doing audio ioctl (start/stop/pause/resume)\n"); 
-		CHECKAUDIO;
-		return cdo->audio_ioctl(cdi, cmd, NULL);
-		}
-	} /* switch */
+	case CDROMRESUME:
+		return cdrom_ioctl_audioctl(cdi, cmd);
+	}
 
-	/* do the device specific ioctls */
+	/*
+	 * Finally, do the device specific ioctls
+	 */
 	if (CDROM_CAN(CDC_IOCTLS))
-		return cdo->dev_ioctl(cdi, cmd, arg);
-	
+		return cdi->ops->dev_ioctl(cdi, cmd, arg);
+
 	return -ENOSYS;
 }
 
