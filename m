Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265096AbTLRLlu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 06:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265105AbTLRLlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 06:41:50 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:12696 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265096AbTLRLkG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 06:40:06 -0500
Date: Thu, 18 Dec 2003 12:40:00 +0100
From: Jens Axboe <axboe@suse.de>
To: Milos Prudek <milos.prudek@tiscali.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Mount Rainier in 2.6
Message-ID: <20031218114000.GB2069@suse.de>
References: <3FE16489.9060006@tiscali.cz> <20031218083530.GP2495@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <20031218083530.GP2495@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 18 2003, Jens Axboe wrote:
> On Thu, Dec 18 2003, Milos Prudek wrote:
> > I noticed that Jens Axboe's patch to allow Mount Rainier support did not 
> > make it into 2.6.0-test11.
> > 
> > Current Mount Rainier patch fails on 2.4.22.
> > 
> > Will Jens Axboe's patch be updated for 2.4.x and/or 2.6.x ?
> 
> I just ported the patch yesterday, I'll post it for testing later today.
> If testing goes fine, I would imagine an inclusion in 2.6.1/2 would not
> be out of the question.

Here's a patch, it's received a little testing. Let me know if it works
for you. I'm also attaching a slightly updated cdmrw tool.

===== drivers/cdrom/cdrom.c 1.41 vs edited =====
--- 1.41/drivers/cdrom/cdrom.c	Sat Sep 27 16:24:59 2003
+++ edited/drivers/cdrom/cdrom.c	Thu Dec 18 11:41:45 2003
@@ -228,10 +228,16 @@
    3.12 Oct 18, 2000 - Jens Axboe <axboe@suse.de>
   -- Use quiet bit on packet commands not known to work
 
+   3.20 Dec 17, 2003 - Jens Axboe <axboe@suse.de>
+  -- Various fixes and lots of cleanups not listed :-)
+  -- Locking fixes
+  -- Mt Rainier support
+  -- DVD-RAM write open fixes
+
 -------------------------------------------------------------------------*/
 
-#define REVISION "Revision: 3.12"
-#define VERSION "Id: cdrom.c 3.12 2000/10/18"
+#define REVISION "Revision: 3.20"
+#define VERSION "Id: cdrom.c 3.20 2003/12/17"
 
 /* I use an error-log mask to give fine grain control over the type of
    messages dumped to the system logs.  The available masks include: */
@@ -282,11 +288,25 @@
 static int lockdoor = 1;
 /* will we ever get to use this... sigh. */
 static int check_media_type;
+/* automatically restart mrw format */
+static int mrw_format_restart = 1;
 MODULE_PARM(debug, "i");
 MODULE_PARM(autoclose, "i");
 MODULE_PARM(autoeject, "i");
 MODULE_PARM(lockdoor, "i");
 MODULE_PARM(check_media_type, "i");
+MODULE_PARM(mrw_format_restart, "i");
+
+static spinlock_t cdrom_lock = SPIN_LOCK_UNLOCKED;
+
+static const char *mrw_format_status[] = {
+	"not mrw",
+	"bgformat inactive",
+	"bgformat active",
+	"mrw complete",
+};
+
+static const char *mrw_address_space[] = { "DMA", "GAA" };
 
 #if (ERRLOGMASK!=CD_NOTHING)
 #define cdinfo(type, fmt, args...) \
@@ -325,6 +345,10 @@
 static int cdrom_get_next_writable(struct cdrom_device_info *, long *);
 static void cdrom_count_tracks(struct cdrom_device_info *, tracktype*);
 
+static int cdrom_mrw_exit(struct cdrom_device_info *cdi);
+
+static int cdrom_get_disc_info(struct cdrom_device_info *cdi, disc_information *di);
+
 #ifdef CONFIG_SYSCTL
 static void cdrom_sysctl_register(void);
 #endif /* CONFIG_SYSCTL */ 
@@ -347,13 +371,14 @@
 
 	if (cdo->open == NULL || cdo->release == NULL)
 		return -2;
-	if ( !banner_printed ) {
+	if (!banner_printed) {
 		printk(KERN_INFO "Uniform CD-ROM driver " REVISION "\n");
 		banner_printed = 1;
 #ifdef CONFIG_SYSCTL
 		cdrom_sysctl_register();
 #endif /* CONFIG_SYSCTL */ 
 	}
+
 	ENSURE(drive_status, CDC_DRIVE_STATUS );
 	ENSURE(media_changed, CDC_MEDIA_CHANGED);
 	ENSURE(tray_move, CDC_CLOSE_TRAY | CDC_OPEN_TRAY);
@@ -378,9 +403,14 @@
 	if (check_media_type==1)
 		cdi->options |= (int) CDO_CHECK_TYPE;
 
+	if (CDROM_CAN(CDC_MRW_W))
+		cdi->exit = cdrom_mrw_exit;
+
 	cdinfo(CD_REG_UNREG, "drive \"/dev/%s\" registered\n", cdi->name);
+	spin_lock(&cdrom_lock);
 	cdi->next = topCdromPtr; 	
 	topCdromPtr = cdi;
+	spin_unlock(&cdrom_lock);
 	return 0;
 }
 #undef ENSURE
@@ -391,23 +421,311 @@
 	cdinfo(CD_OPEN, "entering unregister_cdrom\n"); 
 
 	prev = NULL;
+	spin_lock(&cdrom_lock);
 	cdi = topCdromPtr;
 	while (cdi && cdi != unreg) {
 		prev = cdi;
 		cdi = cdi->next;
 	}
 
-	if (cdi == NULL)
+	if (cdi == NULL) {
+		spin_unlock(&cdrom_lock);
 		return -2;
+	}
 	if (prev)
 		prev->next = cdi->next;
 	else
 		topCdromPtr = cdi->next;
+
+	spin_unlock(&cdrom_lock);
+
+	if (cdi->exit)
+		cdi->exit(cdi);
+
 	cdi->ops->n_minors--;
 	cdinfo(CD_REG_UNREG, "drive \"/dev/%s\" unregistered\n", cdi->name);
 	return 0;
 }
 
+int cdrom_get_media_event(struct cdrom_device_info *cdi,
+			  struct media_event_desc *med)
+{
+	struct cdrom_generic_command cgc;
+	unsigned char buffer[8];
+	struct event_header *eh = (struct event_header *) buffer;
+
+	init_cdrom_command(&cgc, buffer, sizeof(buffer), CGC_DATA_READ);
+	cgc.cmd[0] = GPCMD_GET_EVENT_STATUS_NOTIFICATION;
+	cgc.cmd[1] = 1;		/* IMMED */
+	cgc.cmd[4] = 1 << 4;	/* media event */
+	cgc.cmd[8] = sizeof(buffer);
+	cgc.quiet = 1;
+
+	if (cdi->ops->generic_packet(cdi, &cgc))
+		return 1;
+
+	if (be16_to_cpu(eh->data_len) < sizeof(*med))
+		return 1;
+
+	memcpy(med, &buffer[sizeof(*eh)], sizeof(*med));
+	return 0;
+}
+
+/*
+ * the first prototypes used 0x2c as the page code for the mrw mode page,
+ * subsequently this was changed to 0x03. probe the one used by this drive
+ */
+int cdrom_mrw_probe_pc(struct cdrom_device_info *cdi)
+{
+	struct cdrom_generic_command cgc;
+	char buffer[16];
+
+	init_cdrom_command(&cgc, buffer, sizeof(buffer), CGC_DATA_READ);
+
+	cgc.buffer = buffer;
+	cgc.buflen = sizeof(buffer);
+	cgc.timeout = HZ;
+	cgc.quiet = 1;
+
+	if (!cdrom_mode_sense(cdi, &cgc, MRW_MODE_PC, 0)) {
+		cdi->mrw_mode_page = MRW_MODE_PC;
+		return 0;
+	} else if (!cdrom_mode_sense(cdi, &cgc, MRW_MODE_PC_PRE1, 0)) {
+		cdi->mrw_mode_page = MRW_MODE_PC_PRE1;
+		return 0;
+	} else {
+		printk("cdrom: %s: unknown mrw mode page\n", cdi->name);
+		return 1;
+	}
+
+	printk("cdrom: %s: mrw mode page %x\n", cdi->name, cdi->mrw_mode_page);
+}
+	
+int cdrom_is_mrw(struct cdrom_device_info *cdi, int *write)
+{
+	struct cdrom_generic_command cgc;
+	struct mrw_feature_desc *mfd;
+	unsigned char buffer[16];
+	int ret;
+
+	init_cdrom_command(&cgc, buffer, sizeof(buffer), CGC_DATA_READ);
+
+	cgc.cmd[0] = GPCMD_GET_CONFIGURATION;
+	cgc.cmd[3] = CDF_MRW;
+	cgc.cmd[8] = sizeof(buffer);
+	cgc.quiet = 1;
+
+	if ((ret = cdi->ops->generic_packet(cdi, &cgc)))
+		return ret;
+
+	mfd = (struct mrw_feature_desc *)&buffer[sizeof(struct feature_header)];
+	*write = mfd->write;
+
+	if ((ret = cdrom_mrw_probe_pc(cdi)))
+		return ret;
+
+	return 0;
+}
+
+static int cdrom_mrw_bgformat(struct cdrom_device_info *cdi, int cont)
+{
+	struct cdrom_generic_command cgc;
+	unsigned char buffer[12];
+	int ret;
+
+	printk("cdrom: %sstarting format\n", cont ? "Re" : "");
+
+	/*
+	 * FmtData bit set (bit 4), format type is 1
+	 */
+	init_cdrom_command(&cgc, buffer, sizeof(buffer), CGC_DATA_WRITE);
+	cgc.cmd[0] = GPCMD_FORMAT_UNIT;
+	cgc.cmd[1] = (1 << 4) | 1;
+
+	cgc.timeout = 5 * 60 * HZ;
+
+	/*
+	 * 4 byte format list header, 8 byte format list descriptor
+	 */
+	buffer[1] = 1 << 1;
+	buffer[3] = 8;
+
+	/*
+	 * nr_blocks field
+	 */
+	buffer[4] = 0xff;
+	buffer[5] = 0xff;
+	buffer[6] = 0xff;
+	buffer[7] = 0xff;
+
+	buffer[8] = 0x24 << 2;
+	buffer[11] = cont;
+
+	ret = cdi->ops->generic_packet(cdi, &cgc);
+	if (ret)
+		printk("cdrom: bgformat failed\n");
+
+	return ret;
+}
+
+static int cdrom_mrw_bgformat_susp(struct cdrom_device_info *cdi, int immed)
+{
+	struct cdrom_generic_command cgc;
+
+	init_cdrom_command(&cgc, NULL, 0, CGC_DATA_NONE);
+	cgc.cmd[0] = GPCMD_CLOSE_TRACK;
+
+	/*
+	 * Session = 1, Track = 0
+	 */
+	cgc.cmd[1] = !!immed;
+	cgc.cmd[2] = 1 << 1;
+
+	cgc.timeout = 300 * HZ;
+
+	return cdi->ops->generic_packet(cdi, &cgc);
+}
+
+static int cdrom_flush_cache(struct cdrom_device_info *cdi)
+{
+	struct cdrom_generic_command cgc;
+
+	init_cdrom_command(&cgc, NULL, 0, CGC_DATA_NONE);
+	cgc.cmd[0] = GPCMD_FLUSH_CACHE;
+
+	cgc.timeout = 5 * 60 * HZ;
+
+	return cdi->ops->generic_packet(cdi, &cgc);
+}
+
+static int cdrom_mrw_exit(struct cdrom_device_info *cdi)
+{
+	disc_information di;
+	int ret = 0;
+
+	if (cdrom_get_disc_info(cdi, &di))
+		return 1;
+
+	if (di.mrw_status == CDM_MRW_BGFORMAT_ACTIVE) {
+		printk("cdrom: issuing MRW back ground format suspend\n");
+		ret = cdrom_mrw_bgformat_susp(cdi, 0);
+	}
+
+	if (!ret)
+		ret = cdrom_flush_cache(cdi);
+
+	return ret;
+}
+
+static int cdrom_mrw_set_lba_space(struct cdrom_device_info *cdi, int space)
+{
+	struct cdrom_generic_command cgc;
+	struct mode_page_header *mph;
+	char buffer[16];
+	int ret, offset, size;
+
+	init_cdrom_command(&cgc, buffer, sizeof(buffer), CGC_DATA_READ);
+
+	cgc.buffer = buffer;
+	cgc.buflen = sizeof(buffer);
+
+	if ((ret = cdrom_mode_sense(cdi, &cgc, cdi->mrw_mode_page, 0)))
+		return ret;
+
+	mph = (struct mode_page_header *) buffer;
+	offset = be16_to_cpu(mph->desc_length);
+	size = be16_to_cpu(mph->mode_data_length) + 2;
+
+	buffer[offset + 3] = space;
+	cgc.buflen = size;
+
+	if ((ret = cdrom_mode_select(cdi, &cgc)))
+		return ret;
+
+	printk("cdrom: %s: mrw address space %s selected\n", cdi->name, mrw_address_space[space]);
+	return 0;
+}
+
+static int cdrom_media_erasable(struct cdrom_device_info *cdi)
+{
+	disc_information di;
+
+	if (cdrom_get_disc_info(cdi, &di))
+		return 0;
+
+	return di.erasable;
+}
+
+/*
+ * FIXME: check RO bit
+ */
+static int cdrom_dvdram_open_write(struct cdrom_device_info *cdi)
+{
+	return !cdrom_media_erasable(cdi);
+}
+
+static int cdrom_mrw_open_write(struct cdrom_device_info *cdi)
+{
+	disc_information di;
+	int ret;
+
+	/*
+	 * always reset to DMA lba space on open
+	 */
+	if (cdrom_mrw_set_lba_space(cdi, MRW_LBA_DMA)) {
+		printk("failed setting lba address space\n");
+		return 1;
+	}
+
+	if (cdrom_get_disc_info(cdi, &di))
+		return 1;
+
+	if (!di.erasable) {
+		printk("cdrom not erasable\n");
+		return 1;
+	}
+
+	/*
+	 * mrw_status
+	 * 0	-	not MRW formatted
+	 * 1	-	MRW bgformat started, but not running or complete
+	 * 2	-	MRW bgformat in progress
+	 * 3	-	MRW formatting complete
+	 */
+	ret = 0;
+	printk("cdrom open: mrw_status '%s'\n", mrw_format_status[di.mrw_status]);
+	if (!di.mrw_status)
+		ret = 1;
+	else if (di.mrw_status == CDM_MRW_BGFORMAT_INACTIVE && mrw_format_restart)
+		ret = cdrom_mrw_bgformat(cdi, 1);
+
+	return ret;
+}
+
+/*
+ * returns 0 for ok to open write, non-0 to disallow
+ */
+static int cdrom_open_write(struct cdrom_device_info *cdi)
+{
+	int ret = 1;
+
+	if (CDROM_CAN(CDC_MRW_W))
+		ret = cdrom_mrw_open_write(cdi);
+	else if (CDROM_CAN(CDC_DVD_RAM))
+		ret = cdrom_dvdram_open_write(cdi);
+
+	return ret;
+}
+
+static int cdrom_close_write(struct cdrom_device_info *cdi)
+{
+#if 0
+	return cdrom_flush_cache(cdi);
+#else
+	return 0;
+#endif
+}
+
 /* We use the open-option O_NONBLOCK to indicate that the
  * purpose of opening is only for subsequent ioctl() calls; no device
  * integrity checks are performed.
@@ -421,23 +739,32 @@
 	int ret;
 
 	cdinfo(CD_OPEN, "entering cdrom_open\n"); 
+	cdi->use_count++;
+	ret = -EROFS;
+	if (fp->f_mode & FMODE_WRITE) {
+		printk("cdrom: %s opening for WRITE\n", current->comm);
+		if (!CDROM_CAN(CDC_RAM)) {
+			printk("bzzt\n");
+			goto out;
+		}
+		if (cdrom_open_write(cdi))
+			goto out;
+	}
+
 	/* if this was a O_NONBLOCK open and we should honor the flags,
 	 * do a quick open without drive/disc integrity checks. */
 	if ((fp->f_flags & O_NONBLOCK) && (cdi->options & CDO_USE_FFLAGS))
 		ret = cdi->ops->open(cdi, 1);
-	else {
-		if ((fp->f_mode & FMODE_WRITE) && !CDROM_CAN(CDC_DVD_RAM))
-			return -EROFS;
-
+	else
 		ret = open_for_data(cdi);
-	}
-
-	if (!ret) cdi->use_count++;
 
 	cdinfo(CD_OPEN, "Use count for \"/dev/%s\" now %d\n", cdi->name, cdi->use_count);
 	/* Do this on open.  Don't wait for mount, because they might
 	    not be mounting, but opening with O_NONBLOCK */
 	check_disk_change(ip->i_bdev);
+out:
+	if (ret)
+		cdi->use_count--;
 	return ret;
 }
 
@@ -525,7 +852,7 @@
 		cdinfo(CD_OPEN, "open device failed.\n"); 
 		goto clean_up_and_return;
 	}
-	if (CDROM_CAN(CDC_LOCK) && cdi->options & CDO_LOCK) {
+	if (CDROM_CAN(CDC_LOCK) && (cdi->options & CDO_LOCK)) {
 			cdo->lock_door(cdi, 1);
 			cdinfo(CD_OPEN, "door locked.\n");
 	}
@@ -603,7 +930,6 @@
 	return 0;
 }
 
-
 /* Admittedly, the logic below could be performed in a nicer way. */
 int cdrom_release(struct cdrom_device_info *cdi, struct file *fp)
 {
@@ -612,17 +938,23 @@
 
 	cdinfo(CD_CLOSE, "entering cdrom_release\n"); 
 
-	if (cdi->use_count > 0)
-		cdi->use_count--;
-	if (cdi->use_count == 0)
+	if (!--cdi->use_count) {
 		cdinfo(CD_CLOSE, "Use count for \"/dev/%s\" now zero\n", cdi->name);
-	if (cdi->use_count == 0 &&
-	    cdo->capability & CDC_LOCK && !keeplocked) {
-		cdinfo(CD_CLOSE, "Unlocking door!\n");
-		cdo->lock_door(cdi, 0);
+		if ((cdo->capability & CDC_LOCK) && !keeplocked) {
+			cdinfo(CD_CLOSE, "Unlocking door!\n");
+			cdo->lock_door(cdi, 0);
+		}
 	}
+
 	opened_for_data = !(cdi->options & CDO_USE_FFLAGS) ||
 		!(fp && fp->f_flags & O_NONBLOCK);
+
+	/*
+	 * flush cache on last write release
+	 */
+	if (CDROM_CAN(CDC_RAM) && !cdi->use_count && opened_for_data)
+		cdrom_close_write(cdi);
+
 	cdo->release(cdi);
 	if (cdi->use_count == 0) {      /* last process that closes dev*/
 		if (opened_for_data &&
@@ -2203,7 +2535,6 @@
 	return cdo->generic_packet(cdi, &cgc);
 }
 
-
 /* return the last written block on the CD-R media. this is for the udf
    file system. */
 int cdrom_get_last_written(struct cdrom_device_info *cdi, long *last_written)
@@ -2310,6 +2641,8 @@
 EXPORT_SYMBOL(cdrom_mode_select);
 EXPORT_SYMBOL(cdrom_mode_sense);
 EXPORT_SYMBOL(init_cdrom_command);
+EXPORT_SYMBOL(cdrom_get_media_event);
+EXPORT_SYMBOL(cdrom_is_mrw);
 
 #ifdef CONFIG_SYSCTL
 
@@ -2405,6 +2738,14 @@
 	pos += sprintf(info+pos, "\nCan write DVD-RAM:");
 	for (cdi=topCdromPtr;cdi!=NULL;cdi=cdi->next)
 	    pos += sprintf(info+pos, "\t%d", CDROM_CAN(CDC_DVD_RAM) != 0);
+
+	pos += sprintf(info+pos, "\nCan read MRW:");
+	for (cdi=topCdromPtr;cdi!=NULL;cdi=cdi->next)
+	    pos += sprintf(info+pos, "\t\t%d", CDROM_CAN(CDC_MRW) != 0);
+
+	pos += sprintf(info+pos, "\nCan write MRW:");
+	for (cdi=topCdromPtr;cdi!=NULL;cdi=cdi->next)
+	    pos += sprintf(info+pos, "\t\t%d", CDROM_CAN(CDC_MRW_W) != 0);
 
 	strcpy(info+pos,"\n\n");
 		
===== drivers/ide/ide-cd.c 1.62 vs edited =====
--- 1.62/drivers/ide/ide-cd.c	Sun Dec 14 01:01:28 2003
+++ edited/drivers/ide/ide-cd.c	Thu Dec 18 12:33:11 2003
@@ -291,10 +291,13 @@
  *			- Use extended sense on drives that support it for
  *			  correctly reporting tray status -- from
  *			  Michael D Johnson <johnsom@orst.edu>
+ * 4.60  Dec 17, 2003	- Add mt rainier support
+ *			- Bump timeout for packet commands, matches sr
+ *			- Odd stuff
  *
  *************************************************************************/
  
-#define IDECD_VERSION "4.59-ac1"
+#define IDECD_VERSION "4.60"
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -774,11 +777,14 @@
 
 		if (sense_key == NOT_READY) {
 			/* Tray open. */
-			cdrom_saw_media_change (drive);
+			if (rq_data_dir(rq) == READ) {
+				cdrom_saw_media_change (drive);
 
-			/* Fail the request. */
-			printk ("%s: tray open\n", drive->name);
-			do_end_request = 1;
+				/* Fail the request. */
+				printk ("%s: tray open\n", drive->name);
+				do_end_request = 1;
+			}
+			/* FIXME: need to timeout writes */
 		} else if (sense_key == UNIT_ATTENTION) {
 			/* Media change. */
 			cdrom_saw_media_change (drive);
@@ -844,9 +850,13 @@
 		case GPCMD_BLANK:
 		case GPCMD_FORMAT_UNIT:
 		case GPCMD_RESERVE_RZONE_TRACK:
-			wait = WAIT_CMD;
+		case GPCMD_CLOSE_TRACK:
+		case GPCMD_FLUSH_CACHE:
+			wait = ATAPI_WAIT_PC;
 			break;
 		default:
+			if (!(rq->flags & REQ_QUIET))
+				printk(KERN_INFO "ide-cd: cmd 0x%x timed out\n", rq->cmd[0]);
 			wait = 0;
 			break;
 	}
@@ -894,7 +904,7 @@
  
 	if (CDROM_CONFIG_FLAGS (drive)->drq_interrupt) {
 		/* packet command */
-		ide_execute_command(drive, WIN_PACKETCMD, handler, WAIT_CMD, cdrom_timer_expiry);
+		ide_execute_command(drive, WIN_PACKETCMD, handler, ATAPI_WAIT_PC, cdrom_timer_expiry);
 		return ide_started;
 	} else {
 		/* packet command */
@@ -1167,7 +1177,7 @@
 	}
 
 	/* Done moving data!  Wait for another interrupt. */
-	ide_set_handler(drive, &cdrom_read_intr, WAIT_CMD, NULL);
+	ide_set_handler(drive, &cdrom_read_intr, ATAPI_WAIT_PC, NULL);
 	return ide_started;
 }
 
@@ -1277,7 +1287,7 @@
 		(65534 / CD_FRAMESIZE) : 65535);
 
 	/* Set up the command */
-	rq->timeout = WAIT_CMD;
+	rq->timeout = ATAPI_WAIT_PC;
 
 	/* Send the command to the drive and return. */
 	return cdrom_transfer_packet_command(drive, rq, &cdrom_read_intr);
@@ -1286,7 +1296,7 @@
 
 #define IDECD_SEEK_THRESHOLD	(1000)			/* 1000 blocks */
 #define IDECD_SEEK_TIMER	(5 * WAIT_MIN_SLEEP)	/* 100 ms */
-#define IDECD_SEEK_TIMEOUT     WAIT_CMD			/* 10 sec */
+#define IDECD_SEEK_TIMEOUT	(2 * WAIT_CMD)		/* 20 sec */
 
 static ide_startstop_t cdrom_seek_intr (ide_drive_t *drive)
 {
@@ -1326,7 +1336,7 @@
 	rq->cmd[0] = GPCMD_SEEK;
 	put_unaligned(cpu_to_be32(frame), (unsigned int *) &rq->cmd[2]);
 
-	rq->timeout = WAIT_CMD;
+	rq->timeout = ATAPI_WAIT_PC;
 	return cdrom_transfer_packet_command(drive, rq, &cdrom_seek_intr);
 }
 
@@ -1502,7 +1512,7 @@
 	}
 
 	/* Now we wait for another interrupt. */
-	ide_set_handler(drive, &cdrom_pc_intr, WAIT_CMD, cdrom_timer_expiry);
+	ide_set_handler(drive, &cdrom_pc_intr, ATAPI_WAIT_PC, cdrom_timer_expiry);
 	return ide_started;
 }
 
@@ -1511,7 +1521,7 @@
 	struct request *rq = HWGROUP(drive)->rq;
 
 	if (!rq->timeout)
-		rq->timeout = WAIT_CMD;
+		rq->timeout = ATAPI_WAIT_PC;
 
 	/* Send the command to the drive and return. */
 	return cdrom_transfer_packet_command(drive, rq, &cdrom_pc_intr);
@@ -1716,11 +1726,8 @@
 	/*
 	 * If DRQ is clear, the command has completed.
 	 */
-	if ((stat & DRQ_STAT) == 0) {
-		if (rq->data_len)
-			printk("%s: %u residual after xfer\n", __FUNCTION__, rq->data_len);
+	if ((stat & DRQ_STAT) == 0)
 		goto end_request;
-	}
 
 	/*
 	 * check which way to transfer data
@@ -1826,10 +1833,8 @@
 		}
 	}
 
-	if (cdrom_decode_status(drive, 0, &stat)) {
-		printk("ide-cd: write_intr decode_status bad\n");
+	if (cdrom_decode_status(drive, 0, &stat))
 		return ide_stopped;
-	}
 
 	/*
 	 * using dma, transfer is complete now
@@ -1904,7 +1909,7 @@
 	}
 
 	/* re-arm handler */
-	ide_set_handler(drive, &cdrom_write_intr, 5 * WAIT_CMD, NULL);
+	ide_set_handler(drive, &cdrom_write_intr, ATAPI_WAIT_PC, NULL);
 	return ide_started;
 }
 
@@ -1915,7 +1920,7 @@
 #if 0	/* the immediate bit */
 	rq->cmd[1] = 1 << 3;
 #endif
-	rq->timeout = 2 * WAIT_CMD;
+	rq->timeout = ATAPI_WAIT_PC;
 
 	return cdrom_transfer_packet_command(drive, rq, cdrom_write_intr);
 }
@@ -1956,7 +1961,7 @@
 	struct request *rq = HWGROUP(drive)->rq;
 
 	if (!rq->timeout)
-		rq->timeout = WAIT_CMD;
+		rq->timeout = ATAPI_WAIT_PC;
 
 	return cdrom_transfer_packet_command(drive, rq, cdrom_newpc_intr);
 }
@@ -2483,7 +2488,7 @@
 	ide_drive_t *drive = (ide_drive_t*) cdi->handle;
 
 	if (cgc->timeout <= 0)
-		cgc->timeout = WAIT_CMD;
+		cgc->timeout = ATAPI_WAIT_PC;
 
 	/* here we queue the commands from the uniform CD-ROM
 	   layer. the packet must be complete, as we do not
@@ -2688,37 +2693,49 @@
         return 0;
 }
 
+/*
+ * add logic to try GET_EVENT command first to check for media and tray
+ * status. this should be supported by newer cd-r/w and all DVD etc
+ * drives
+ */
 static
 int ide_cdrom_drive_status (struct cdrom_device_info *cdi, int slot_nr)
 {
 	ide_drive_t *drive = (ide_drive_t*) cdi->handle;
+	struct media_event_desc med;
+	struct request_sense sense;
+	int stat;
 
-	if (slot_nr == CDSL_CURRENT) {
-		struct request_sense sense;
-		int stat = cdrom_check_status(drive, &sense);
-		if (stat == 0 || sense.sense_key == UNIT_ATTENTION)
-			return CDS_DISC_OK;
+	if (slot_nr != CDSL_CURRENT)
+		return -EINVAL;
 
-		if (sense.sense_key == NOT_READY && sense.asc == 0x04 &&
-		    sense.ascq == 0x04)
-			return CDS_DISC_OK;
+	stat = cdrom_check_status(drive, &sense);
+	if (!stat || sense.sense_key == UNIT_ATTENTION)
+		return CDS_DISC_OK;
 
+	if (!cdrom_get_media_event(cdi, &med)) {
+		if (med.media_present)
+			return CDS_DISC_OK;
+		if (med.door_open)
+			return CDS_TRAY_OPEN;
+	}
 
-		/*
-		 * If not using Mt Fuji extended media tray reports,
-		 * just return TRAY_OPEN since ATAPI doesn't provide
-		 * any other way to detect this...
-		 */
-		if (sense.sense_key == NOT_READY) {
-			if (sense.asc == 0x3a && sense.ascq == 1)
-				return CDS_NO_DISC;
-			else
-				return CDS_TRAY_OPEN;
-		}
+	if (sense.sense_key == NOT_READY && sense.asc == 0x04 && sense.ascq == 0x04)
+		return CDS_DISC_OK;
 
-		return CDS_DRIVE_NOT_READY;
+	/*
+	 * If not using Mt Fuji extended media tray reports,
+	 * just return TRAY_OPEN since ATAPI doesn't provide
+	 * any other way to detect this...
+	 */
+	if (sense.sense_key == NOT_READY) {
+		if (sense.asc == 0x3a && sense.ascq == 1)
+			return CDS_NO_DISC;
+		else
+			return CDS_TRAY_OPEN;
 	}
-	return -EINVAL;
+
+	return CDS_DRIVE_NOT_READY;
 }
 
 static
@@ -2826,7 +2843,8 @@
 				CDC_MEDIA_CHANGED | CDC_PLAY_AUDIO | CDC_RESET |
 				CDC_IOCTLS | CDC_DRIVE_STATUS | CDC_CD_R |
 				CDC_CD_RW | CDC_DVD | CDC_DVD_R| CDC_DVD_RAM |
-				CDC_GENERIC_PACKET | CDC_MO_DRIVE,
+				CDC_GENERIC_PACKET | CDC_MO_DRIVE | CDC_MRW |
+				CDC_MRW_W | CDC_RAM,
 	.generic_packet		= ide_cdrom_packet,
 };
 
@@ -2861,6 +2879,10 @@
 		devinfo->mask |= CDC_CLOSE_TRAY;
 	if (!CDROM_CONFIG_FLAGS(drive)->mo_drive)
 		devinfo->mask |= CDC_MO_DRIVE;
+	if (!CDROM_CONFIG_FLAGS(drive)->mrw)
+		devinfo->mask |= CDC_MRW;
+	if (!CDROM_CONFIG_FLAGS(drive)->mrw_w)
+		devinfo->mask |= CDC_MRW_W;
 
 	return register_cdrom(devinfo);
 }
@@ -2881,14 +2903,6 @@
 	    !strcmp(drive->id->model, "WPI CDS-32X")))
 		size -= sizeof(cap->pad);
 
-	/* we have to cheat a little here. the packet will eventually
-	 * be queued with ide_cdrom_packet(), which extracts the
-	 * drive from cdi->handle. Since this device hasn't been
-	 * registered with the Uniform layer yet, it can't do this.
-	 * Same goes for cdi->ops.
-	 */
-	cdi->handle = (ide_drive_t *) drive;
-	cdi->ops = &ide_cdrom_dops;
 	init_cdrom_command(&cgc, cap, size, CGC_DATA_UNKNOWN);
 	do { /* we seem to get stat=0x01,err=0x00 the first time (??) */
 		stat = cdrom_mode_sense(cdi, &cgc, GPMODE_CAPABILITIES_PAGE, 0);
@@ -2904,7 +2918,7 @@
 	struct cdrom_info *info = drive->driver_data;
 	struct cdrom_device_info *cdi = &info->devinfo;
 	struct atapi_capabilities_page cap;
-	int nslots = 1;
+	int nslots = 1, mrw_write = 0;
 
 	if (drive->media == ide_optical) {
 		CDROM_CONFIG_FLAGS(drive)->mo_drive = 1;
@@ -2912,15 +2926,34 @@
 		return nslots;
 	}
 
-	if (CDROM_CONFIG_FLAGS(drive)->nec260) {
-		CDROM_CONFIG_FLAGS(drive)->no_eject = 0;                       
-		CDROM_CONFIG_FLAGS(drive)->audio_play = 1;       
+	if (CDROM_CONFIG_FLAGS(drive)->nec260 ||
+	    !strcmp(drive->id->model,"STINGRAY 8422 IDE 8X CD-ROM 7-27-95")) {
+		CDROM_CONFIG_FLAGS(drive)->no_eject = 0;
+		CDROM_CONFIG_FLAGS(drive)->audio_play = 1;
 		return nslots;
 	}
 
+	/*
+	 * we have to cheat a little here. the packet will eventually
+	 * be queued with ide_cdrom_packet(), which extracts the
+	 * drive from cdi->handle. Since this device hasn't been
+	 * registered with the Uniform layer yet, it can't do this.
+	 * Same goes for cdi->ops.
+	 */
+	cdi->handle = (ide_drive_t *) drive;
+	cdi->ops = &ide_cdrom_dops;
+
 	if (ide_cdrom_get_capabilities(drive, &cap))
 		return 0;
 
+	if (!cdrom_is_mrw(cdi, &mrw_write)) {
+		CDROM_CONFIG_FLAGS(drive)->mrw = 1;
+		if (mrw_write) {
+			CDROM_CONFIG_FLAGS(drive)->mrw_w = 1;
+			CDROM_CONFIG_FLAGS(drive)->ram = 1;
+		}
+	}
+
 	if (cap.lock == 0)
 		CDROM_CONFIG_FLAGS(drive)->no_doorlock = 1;
 	if (cap.eject)
@@ -2933,8 +2966,10 @@
 		CDROM_CONFIG_FLAGS(drive)->test_write = 1;
 	if (cap.dvd_ram_read || cap.dvd_r_read || cap.dvd_rom)
 		CDROM_CONFIG_FLAGS(drive)->dvd = 1;
-	if (cap.dvd_ram_write)
+	if (cap.dvd_ram_write) {
 		CDROM_CONFIG_FLAGS(drive)->dvd_ram = 1;
+		CDROM_CONFIG_FLAGS(drive)->ram = 1;
+	}
 	if (cap.dvd_r_write)
 		CDROM_CONFIG_FLAGS(drive)->dvd_r = 1;
 	if (cap.audio_play)
@@ -2998,6 +3033,9 @@
         	(CDROM_CONFIG_FLAGS(drive)->cd_r)? "-R" : "", 
         	(CDROM_CONFIG_FLAGS(drive)->cd_rw)? "/RW" : "");
 
+	if (CDROM_CONFIG_FLAGS(drive)->mrw || CDROM_CONFIG_FLAGS(drive)->mrw_w)
+		printk(" CD-MR%s", CDROM_CONFIG_FLAGS(drive)->mrw_w ? "W" : "");
+
         if (CDROM_CONFIG_FLAGS(drive)->is_changer) 
         	printk(" changer w/%d slots", nslots);
         else 	
@@ -3105,12 +3143,6 @@
 	struct cdrom_device_info *cdi = &info->devinfo;
 	int nslots;
 
-	/*
-	 * default to read-only always and fix latter at the bottom
-	 */
-	set_disk_ro(drive->disk, 1);
-	blk_queue_hardsect_size(drive->queue, CD_FRAMESIZE);
-
 	blk_queue_prep_rq(drive->queue, ide_cdrom_prep_fn);
 	blk_queue_dma_alignment(drive->queue, 3);
 
@@ -3215,8 +3247,11 @@
 
 	nslots = ide_cdrom_probe_capabilities (drive);
 
-	if (CDROM_CONFIG_FLAGS(drive)->dvd_ram)
-		set_disk_ro(drive->disk, 0);
+	/*
+	 * set correct block size and read-only for non-ram media
+	 */
+	set_disk_ro(drive->disk, !CDROM_CONFIG_FLAGS(drive)->ram);
+	blk_queue_hardsect_size(drive->queue, CD_FRAMESIZE);
 
 #if 0
 	drive->dsc_overlap = (HWIF(drive)->no_dsc) ? 0 : 1;
===== drivers/ide/ide-cd.h 1.7 vs edited =====
--- 1.7/drivers/ide/ide-cd.h	Sun Dec 14 00:58:07 2003
+++ edited/drivers/ide/ide-cd.h	Wed Dec 17 21:57:43 2003
@@ -35,6 +35,11 @@
 #define NO_DOOR_LOCKING 0
 #endif
 
+/*
+ * typical timeout for packet command
+ */
+#define ATAPI_WAIT_PC  (60 * HZ)
+
 /************************************************************************/
 
 #define SECTOR_BITS 		9
@@ -75,6 +80,9 @@
 	__u8 dvd		: 1; /* Drive is a DVD-ROM */
 	__u8 dvd_r		: 1; /* Drive can write DVD-R */
 	__u8 dvd_ram		: 1; /* Drive can write DVD-RAM */
+	__u8 mrw		: 1; /* drive can read mrw */
+	__u8 mrw_w		: 1; /* drive can write mrw */
+	__u8 ram		: 1; /* generic WRITE (dvd-ram/mrw) */
 	__u8 test_write		: 1; /* Drive can fake writes */
 	__u8 supp_disc_present	: 1; /* Changer can report exact contents
 					of slots. */
===== drivers/scsi/sr.c 1.95 vs edited =====
--- 1.95/drivers/scsi/sr.c	Wed Oct 22 07:09:52 2003
+++ edited/drivers/scsi/sr.c	Wed Dec 17 21:53:24 2003
@@ -67,7 +67,8 @@
 	(CDC_CLOSE_TRAY|CDC_OPEN_TRAY|CDC_LOCK|CDC_SELECT_SPEED| \
 	 CDC_SELECT_DISC|CDC_MULTI_SESSION|CDC_MCN|CDC_MEDIA_CHANGED| \
 	 CDC_PLAY_AUDIO|CDC_RESET|CDC_IOCTLS|CDC_DRIVE_STATUS| \
-	 CDC_CD_R|CDC_CD_RW|CDC_DVD|CDC_DVD_R|CDC_DVD_RAM|CDC_GENERIC_PACKET)
+	 CDC_CD_R|CDC_CD_RW|CDC_DVD|CDC_DVD_R|CDC_DVD_RAM|CDC_GENERIC_PACKET| \
+	 CDC_MRW|CDC_MRW_R|CDC_RAM)
 
 static int sr_probe(struct device *);
 static int sr_remove(struct device *);
@@ -692,7 +693,7 @@
 static void get_capabilities(struct scsi_cd *cd)
 {
 	unsigned char *buffer;
-	int rc, n;
+	int rc, n, mwr_write = 0, mrw = 1;
 	struct scsi_mode_data data;
 	struct scsi_request *SRpnt;
 	unsigned char cmd[MAX_COMMAND_SIZE];
@@ -765,6 +766,15 @@
 		printk("%s: scsi-1 drive\n", cd->cdi.name);
 		return;
 	}
+
+	if (cdrom_is_mrw(&scsi_CDs[i].cdi, &mrw_write)) {
+		mrw = 0;
+		scsi_CDs[i].cdi.mask |= CDC_MRW;
+		scsi_CDs[i].cdi.mask |= CDC_MRW_W;
+	}
+	if (!mrw_write)
+		scsi_CDs[i].cdi.mask |= CDC_MRW_W;
+
 	n = data.header_length + data.block_descriptor_length;
 	cd->cdi.speed = ((buffer[n + 8] << 8) + buffer[n + 9]) / 176;
 	cd->readcd_known = 1;
@@ -788,9 +798,7 @@
 	if ((buffer[n + 3] & 0x20) == 0) {
 		/* can't write DVD-RAM media */
 		cd->cdi.mask |= CDC_DVD_RAM;
-	} else {
-		cd->device->writeable = 1;
-	}
+	} else
 	if ((buffer[n + 3] & 0x10) == 0)
 		/* can't write DVD-R media */
 		cd->cdi.mask |= CDC_DVD_R;
@@ -813,6 +821,12 @@
 		cd->cdi.mask |= CDC_SELECT_DISC;
 	/*else    I don't think it can close its tray
 		cd->cdi.mask |= CDC_CLOSE_TRAY; */
+
+	/*
+	 * if DVD-RAM of MRW-W, we are randomly writeable
+	 */
+	if ((scsi_CDs[i].cdi.mask & (CDC_DVD_RAM | CDC_MRW_W)) != (CDC_DVD_RAM | CDC_MRW_W))
+		scsi_CDs[i].device->writeable = 1;
 
 	scsi_release_request(SRpnt);
 	kfree(buffer);
===== include/linux/cdrom.h 1.14 vs edited =====
--- 1.14/include/linux/cdrom.h	Fri Jun  6 15:05:30 2003
+++ edited/include/linux/cdrom.h	Thu Dec 18 11:23:29 2003
@@ -5,7 +5,7 @@
  *               1994, 1995   Eberhard Moenkeberg, emoenke@gwdg.de
  *               1996         David van Leeuwen, david@tm.tno.nl
  *               1997, 1998   Erik Andersen, andersee@debian.org
- *               1998-2000    Jens Axboe, axboe@suse.de
+ *               1998-2002    Jens Axboe, axboe@suse.de
  */
  
 #ifndef	_LINUX_CDROM_H
@@ -388,6 +388,9 @@
 #define CDC_DVD_R		0x10000	/* drive can write DVD-R */
 #define CDC_DVD_RAM		0x20000	/* drive can write DVD-RAM */
 #define CDC_MO_DRIVE		0x40000 /* drive is an MO device */
+#define CDC_MRW			0x80000 /* drive can read MRW */
+#define CDC_MRW_W		0x100000 /* drive can write MRW */
+#define CDC_RAM			0x200000 /* ok to open for WRITE */
 
 /* drive status possibilities returned by CDROM_DRIVE_STATUS ioctl */
 #define CDS_NO_INFO		0	/* if not implemented */
@@ -715,92 +718,57 @@
 	__u8 asb[46];
 };
 
-#ifdef __KERNEL__
-#include <linux/fs.h>		/* not really needed, later.. */
-#include <linux/device.h>
-
-struct cdrom_write_settings {
-	unsigned char fpacket;		/* fixed/variable packets */
-	unsigned long packet_size;	/* write out this number of packets */
-	unsigned long nwa;		/* next writeable address */
-	unsigned char writeable;	/* cdrom is writeable */
-};
-
-/* Uniform cdrom data structures for cdrom.c */
-struct cdrom_device_info {
-	struct cdrom_device_ops  *ops;  /* link to device_ops */
-	struct cdrom_device_info *next; /* next device_info for this major */
-	void *handle;		        /* driver-dependent data */
-/* specifications */
-	int mask;                       /* mask of capability: disables them */
-	int speed;			/* maximum speed for reading data */
-	int capacity;			/* number of discs in jukebox */
-/* device-related storage */
-	int options		: 30;	/* options flags */
-	unsigned mc_flags	: 2;	/* media change buffer flags */
-    	int use_count;                  /* number of times device opened */
-    	char name[20];                  /* name of the device type */
-/* per-device flags */
-        __u8 sanyo_slot		: 2;	/* Sanyo 3 CD changer support */
-        __u8 reserved		: 6;	/* not used yet */
-	struct cdrom_write_settings write;
-};
-
-struct cdrom_device_ops {
-/* routines */
-	int (*open) (struct cdrom_device_info *, int);
-	void (*release) (struct cdrom_device_info *);
-	int (*drive_status) (struct cdrom_device_info *, int);
-	int (*media_changed) (struct cdrom_device_info *, int);
-	int (*tray_move) (struct cdrom_device_info *, int);
-	int (*lock_door) (struct cdrom_device_info *, int);
-	int (*select_speed) (struct cdrom_device_info *, int);
-	int (*select_disc) (struct cdrom_device_info *, int);
-	int (*get_last_session) (struct cdrom_device_info *,
-				 struct cdrom_multisession *);
-	int (*get_mcn) (struct cdrom_device_info *,
-			struct cdrom_mcn *);
-	/* hard reset device */
-	int (*reset) (struct cdrom_device_info *);
-	/* play stuff */
-	int (*audio_ioctl) (struct cdrom_device_info *,unsigned int, void *);
-	/* dev-specific */
- 	int (*dev_ioctl) (struct cdrom_device_info *,
-			  unsigned int, unsigned long);
-/* driver specifications */
-	const int capability;   /* capability flags */
-	int n_minors;           /* number of active minor devices */
-	/* handle uniform packets for scsi type devices (scsi,atapi) */
-	int (*generic_packet) (struct cdrom_device_info *,
-			       struct cdrom_generic_command *);
-};
+/*
+ * feature profile
+ */
+#define CDF_MRW		0x28
 
-/* the general block_device operations structure: */
-extern int cdrom_open(struct cdrom_device_info *, struct inode *, struct file *);
-extern int cdrom_release(struct cdrom_device_info *, struct file *);
-extern int cdrom_ioctl(struct cdrom_device_info *, struct inode *, unsigned, unsigned long);
-extern int cdrom_media_changed(struct cdrom_device_info *);
+/*
+ * media status bits
+ */
+#define CDM_MRW_NOTMRW			0
+#define CDM_MRW_BGFORMAT_INACTIVE	1
+#define CDM_MRW_BGFORMAT_ACTIVE		2
+#define CDM_MRW_BGFORMAT_COMPLETE	3
 
-extern int register_cdrom(struct cdrom_device_info *cdi);
-extern int unregister_cdrom(struct cdrom_device_info *cdi);
+/*
+ * mrw address spaces
+ */
+#define MRW_LBA_DMA			0
+#define MRW_LBA_GAA			1
 
-typedef struct {
-    int data;
-    int audio;
-    int cdi;
-    int xa;
-    long error;
-} tracktype;
+/*
+ * mrw mode pages (first is deprecated) -- probed at init time and
+ * cdi->mrw_mode_page is set
+ */
+#define MRW_MODE_PC_PRE1		0x2c
+#define MRW_MODE_PC			0x03
 
-extern int cdrom_get_last_written(struct cdrom_device_info *cdi, long *last_written);
-extern int cdrom_number_of_slots(struct cdrom_device_info *cdi);
-extern int cdrom_mode_select(struct cdrom_device_info *cdi,
-			     struct cdrom_generic_command *cgc);
-extern int cdrom_mode_sense(struct cdrom_device_info *cdi,
-			    struct cdrom_generic_command *cgc,
-			    int page_code, int page_control);
-extern void init_cdrom_command(struct cdrom_generic_command *cgc,
-			       void *buffer, int len, int type);
+struct mrw_feature_desc {
+	__u16 feature_code;
+#if defined(__BIG_ENDIAN_BITFIELD)
+	__u8 reserved1		: 2;
+	__u8 feature_version	: 4;
+	__u8 persistent		: 1;
+	__u8 curr		: 1;
+#elif defined(__LITTLE_ENDIAN_BITFIELD)
+	__u8 curr		: 1;
+	__u8 persistent		: 1;
+	__u8 feature_version	: 4;
+	__u8 reserved1		: 2;
+#endif
+	__u8 add_len;
+#if defined(__BIG_ENDIAN_BITFIELD)
+	__u8 reserved2		: 7;
+	__u8 write		: 1;
+#elif defined(__LITTLE_ENDIAN_BITFIELD)
+	__u8 write		: 1;
+	__u8 reserved2		: 7;
+#endif
+	__u8 reserved3;
+	__u8 reserved4;
+	__u8 reserved5;
+};
 
 typedef struct {
 	__u16 disc_information_length;
@@ -825,9 +793,13 @@
 	__u8 did_v			: 1;
         __u8 dbc_v			: 1;
         __u8 uru			: 1;
-        __u8 reserved2			: 5;
+        __u8 reserved2			: 2;
+	__u8 dbit			: 1;
+	__u8 mrw_status			: 2;
 #elif defined(__LITTLE_ENDIAN_BITFIELD)
-        __u8 reserved2			: 5;
+	__u8 mrw_status			: 2;
+	__u8 dbit			: 1;
+        __u8 reserved2			: 2;
         __u8 uru			: 1;
         __u8 dbc_v			: 1;
 	__u8 did_v			: 1;
@@ -884,6 +856,103 @@
 	__u32 last_rec_address;
 } track_information;
 
+struct feature_header {
+	__u32 data_len;
+	__u8 reserved1;
+	__u8 reserved2;
+	__u16 curr_profile;
+};
+
+struct mode_page_header {
+	__u16 mode_data_length;
+	__u8 medium_type;
+	__u8 reserved1;
+	__u8 reserved2;
+	__u8 reserved3;
+	__u16 desc_length;
+};
+
+#ifdef __KERNEL__
+#include <linux/fs.h>		/* not really needed, later.. */
+#include <linux/device.h>
+
+/* Uniform cdrom data structures for cdrom.c */
+struct cdrom_device_info {
+	struct cdrom_device_ops  *ops;  /* link to device_ops */
+	struct cdrom_device_info *next; /* next device_info for this major */
+	void *handle;		        /* driver-dependent data */
+/* specifications */
+	int mask;                       /* mask of capability: disables them */
+	int speed;			/* maximum speed for reading data */
+	int capacity;			/* number of discs in jukebox */
+/* device-related storage */
+	int options		: 30;	/* options flags */
+	unsigned mc_flags	: 2;	/* media change buffer flags */
+    	int use_count;                  /* number of times device opened */
+    	char name[20];                  /* name of the device type */
+/* per-device flags */
+        __u8 sanyo_slot		: 2;	/* Sanyo 3 CD changer support */
+        __u8 reserved		: 6;	/* not used yet */
+	int (*exit)(struct cdrom_device_info *);
+	int mrw_mode_page;
+};
+
+struct cdrom_device_ops {
+/* routines */
+	int (*open) (struct cdrom_device_info *, int);
+	void (*release) (struct cdrom_device_info *);
+	int (*drive_status) (struct cdrom_device_info *, int);
+	int (*media_changed) (struct cdrom_device_info *, int);
+	int (*tray_move) (struct cdrom_device_info *, int);
+	int (*lock_door) (struct cdrom_device_info *, int);
+	int (*select_speed) (struct cdrom_device_info *, int);
+	int (*select_disc) (struct cdrom_device_info *, int);
+	int (*get_last_session) (struct cdrom_device_info *,
+				 struct cdrom_multisession *);
+	int (*get_mcn) (struct cdrom_device_info *,
+			struct cdrom_mcn *);
+	/* hard reset device */
+	int (*reset) (struct cdrom_device_info *);
+	/* play stuff */
+	int (*audio_ioctl) (struct cdrom_device_info *,unsigned int, void *);
+	/* dev-specific */
+ 	int (*dev_ioctl) (struct cdrom_device_info *,
+			  unsigned int, unsigned long);
+/* driver specifications */
+	const int capability;   /* capability flags */
+	int n_minors;           /* number of active minor devices */
+	/* handle uniform packets for scsi type devices (scsi,atapi) */
+	int (*generic_packet) (struct cdrom_device_info *,
+			       struct cdrom_generic_command *);
+};
+
+/* the general block_device operations structure: */
+extern int cdrom_open(struct cdrom_device_info *, struct inode *, struct file *);
+extern int cdrom_release(struct cdrom_device_info *, struct file *);
+extern int cdrom_ioctl(struct cdrom_device_info *, struct inode *, unsigned, unsigned long);
+extern int cdrom_media_changed(struct cdrom_device_info *);
+
+extern int register_cdrom(struct cdrom_device_info *cdi);
+extern int unregister_cdrom(struct cdrom_device_info *cdi);
+
+typedef struct {
+    int data;
+    int audio;
+    int cdi;
+    int xa;
+    long error;
+} tracktype;
+
+extern int cdrom_get_last_written(struct cdrom_device_info *cdi, long *last_written);
+extern int cdrom_number_of_slots(struct cdrom_device_info *cdi);
+extern int cdrom_mode_select(struct cdrom_device_info *cdi,
+			     struct cdrom_generic_command *cgc);
+extern int cdrom_mode_sense(struct cdrom_device_info *cdi,
+			    struct cdrom_generic_command *cgc,
+			    int page_code, int page_control);
+extern void init_cdrom_command(struct cdrom_generic_command *cgc,
+			       void *buffer, int len, int type);
+
 /* The SCSI spec says there could be 256 slots. */
 #define CDROM_MAX_SLOTS	256
 
@@ -934,15 +1003,6 @@
 	mechtype_cartridge_changer  = 5
 } mechtype_t;
 
-struct mode_page_header {
-	__u16 mode_data_length;
-	__u8 medium_type;
-	__u8 reserved1;
-	__u8 reserved2;
-	__u8 reserved3;
-	__u16 desc_length;
-};
-
 typedef struct {
 #if defined(__BIG_ENDIAN_BITFIELD)
 	__u8 ps			: 1;
@@ -1031,6 +1091,41 @@
 	__u8 rpc_scheme;
 	__u8 reserved3;
 } rpc_state_t;
+
+struct event_header {
+	__u16 data_len;
+#if defined(__BIG_ENDIAN_BITFIELD)
+	__u8 nea		: 1;
+	__u8 reserved1		: 4;
+	__u8 notification_class	: 3;
+#elif defined(__LITTLE_ENDIAN_BITFIELD)
+	__u8 notification_class	: 3;
+	__u8 reserved1		: 4;
+	__u8 nea		: 1;
+#endif
+	__u8 supp_event_class;
+};
+
+struct media_event_desc {
+#if defined(__BIG_ENDIAN_BITFIELD)
+	__u8 reserved1		: 4;
+	__u8 media_event_code	: 4;
+	__u8 reserved2		: 6;
+	__u8 media_present	: 1;
+	__u8 door_open		: 1;
+#elif defined(__LITTLE_ENDIAN_BITFIELD)
+	__u8 media_event_code	: 4;
+	__u8 reserved1		: 4;
+	__u8 door_open		: 1;
+	__u8 media_present	: 1;
+	__u8 reserved2		: 6;
+#endif
+	__u8 start_slot;
+	__u8 end_slot;
+};
+
+extern int cdrom_get_media_event(struct cdrom_device_info *cdi, struct media_event_desc *med);
+extern int cdrom_is_mrw(struct cdrom_device_info *cdi, int *write);
 
 #endif  /* End of kernel only stuff */ 
 

-- 
Jens Axboe


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cdmrw.c"

/*
 * Copyright (c) 2002 Jens Axboe <axboe@suse.de>
 *
 * cdmrw -- utility to manage mt rainier cd drives + media
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License version 2 as
 *   published by the Free Software Foundation.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program; if not, write to the Free Software
 *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>
#include <byteswap.h>
#include <sys/ioctl.h>

/*
 * you probably want to copy 2.6.0 (patched mrw) to /usr/include/linux
 * or change the include path
 */
#include <linux/cdrom.h>

#define INIT_CGC(cgc)	memset((cgc), 0, sizeof(struct cdrom_generic_command))

#define FORMAT_TYPE_RESTART	1
#define FORMAT_TYPE_FULL	2

#define LBA_DMA			0
#define LBA_GAA			1

/*
 * early mrw drives may use mode page 0x2c still, 0x03 is the official one
 */
#define MRW_MODE_PC_PRE1	0x2c
#define MRW_MODE_PC		0x03

#define UHZ			100

static int format_type, format_force, poll_wait, poll_err, suspend_format;
static int lba_space = -1, mrw_mode_page;

static char mrw_device[256];

static char *lba_spaces[] = { "DMA", "GAA" };

void dump_cgc(struct cdrom_generic_command *cgc)
{
	struct request_sense *sense = cgc->sense;
	int i;

	printf("cdb: ");
	for (i = 0; i < 12; i++)
		printf("%02x ", cgc->cmd[i]);
	printf("\n");

	printf("buffer (%d): ", cgc->buflen);
	for (i = 0; i < cgc->buflen; i++)
		printf("%02x ", cgc->buffer[i]);
	printf("\n");

	if (!sense)
		return;

	printf("sense: %02x.%02x.%02x\n", sense->sense_key, sense->asc, sense->ascq);
}

/*
 * issue packet command (blocks until it has completed)
 */
int wait_cmd(int fd, struct cdrom_generic_command *cgc, void *buffer,
	     int len, int ddir, int timeout, int quiet)
{
	struct request_sense sense;
	int ret;

	memset(&sense, 0, sizeof(sense));

	cgc->timeout = timeout;
	cgc->buffer = buffer;
	cgc->buflen = len;
	cgc->data_direction = ddir;
	cgc->sense = &sense;
	cgc->quiet = 0;

	ret = ioctl(fd, CDROM_SEND_PACKET, cgc);
	if (ret == -1 && !quiet) {
		perror("ioctl");
		dump_cgc(cgc);
	}

	return ret;
}

int start_bg_format(int fd, int new)
{
	struct cdrom_generic_command cgc;
	unsigned char buffer[12];

	INIT_CGC(&cgc);
	memset(buffer, 0, sizeof(buffer));

	cgc.cmd[0] = GPCMD_FORMAT_UNIT;
	cgc.cmd[1] = (1 << 4) | 1;

	buffer[1] = 1 << 1;
	buffer[3] = 8;

	buffer[4] = 0xff;
	buffer[5] = 0xff;
	buffer[6] = 0xff;
	buffer[7] = 0xff;
	buffer[8] = 0x24 << 2;
	buffer[11] = !new;

	return wait_cmd(fd, &cgc, buffer, sizeof(buffer), CGC_DATA_WRITE, 121 * UHZ, 0);
}

/*
 * instantiate a format, if appropriate
 */
int mrw_format(int fd, int media_status)
{
	if (media_status == CDM_MRW_BGFORMAT_ACTIVE) {
		printf("%s: back ground format already active\n", mrw_device);
		return 1;
	} else if (media_status == CDM_MRW_BGFORMAT_COMPLETE && !format_force) {
		printf("%s: disc is already mrw formatted\n", mrw_device);
		return 1;
	}

	if (format_type == FORMAT_TYPE_RESTART && media_status != CDM_MRW_BGFORMAT_INACTIVE) {
		printf("%s: can't restart format, need full\n", mrw_device);
		return 1;
	}

	return start_bg_format(fd, format_type == FORMAT_TYPE_FULL);
}

int mrw_format_suspend(int fd, int media_status)
{
	struct cdrom_generic_command cgc;

	if (media_status != CDM_MRW_BGFORMAT_ACTIVE) {
		printf("%s: can't suspend, format not running\n", mrw_device);
		return 1;
	}

	printf("%s: suspending back ground format: ", mrw_device);

	INIT_CGC(&cgc);

	cgc.cmd[0] = GPCMD_CLOSE_TRACK;
	cgc.cmd[1] = 0; /* IMMED */
	cgc.cmd[2] = 1 << 1;

	if (wait_cmd(fd, &cgc, NULL, 0, CGC_DATA_NONE, 300 * UHZ, 0)) {
		printf("failed\n");
		return 1;
	}

	printf("done\n");
	return 0;
}

int get_media_event(int fd)
{
	struct cdrom_generic_command cgc;
	unsigned char buffer[8];
	int ret;

	INIT_CGC(&cgc);
	memset(buffer, 0, sizeof(buffer));

	cgc.cmd[0] = GPCMD_GET_EVENT_STATUS_NOTIFICATION;
	cgc.cmd[1] = 1;
	cgc.cmd[4] = 16;
	cgc.cmd[8] = sizeof(buffer);

	ret = wait_cmd(fd, &cgc, buffer, sizeof(buffer), CGC_DATA_READ, 10*UHZ, 0);
	if (ret < 0) {
		perror("GET_EVENT");
		return ret;
	}

	return buffer[4] & 0xf;
}

int get_progress(int fd)
{
	struct cdrom_generic_command cgc;
	struct request_sense sense;
	int progress;

	INIT_CGC(&cgc);
	memset(&sense, 0, sizeof(sense));

	cgc.cmd[0] = GPCMD_TEST_UNIT_READY;
	cgc.sense = &sense;

	(void) wait_cmd(fd, &cgc, NULL, 0, CGC_DATA_NONE, 10 * UHZ, 0);

	printf("progress: ");
	if (sense.sks[0] & 0x80) {
		progress = (sense.sks[1] << 8) + sense.sks[2];
		fprintf(stderr, "%d%%\r", progress);
	} else
		printf("no progress indicator\n");

	return 0;
}

int get_format_progress(int fd)
{
	struct cdrom_generic_command cgc;
	struct request_sense sense;

#if 0
	if (poll_err)
		return 0;
#endif

	INIT_CGC(&cgc);
	memset(&sense, 0, sizeof(sense));

	cgc.cmd[0] = GPCMD_TEST_UNIT_READY;
	cgc.sense = &sense;

	if (wait_cmd(fd, &cgc, NULL, 0, CGC_DATA_NONE, 10 * UHZ, 0)) {
		printf("%s: TUR failed\n", mrw_device);
		return 0;
	}

	/*
	 * all mrw drives should support progress indicator, but you never
	 * know...
	 */
	if (!(sense.sks[0] & 0x80)) {
		printf("drive fails to support progress indicator\n");
		poll_err = 1;
		//return 0;
	}

	return (sense.sks[1] << 8) + sense.sks[2];
}

/*
 * return mrw media status bits from disc info or -1 on failure
 */
int get_mrw_media_status(int fd)
{
	struct cdrom_generic_command cgc;
	disc_information di;

	INIT_CGC(&cgc);

	cgc.cmd[0] = GPCMD_READ_DISC_INFO;
	cgc.cmd[8] = sizeof(di);

	if (wait_cmd(fd, &cgc, &di, sizeof(di), CGC_DATA_READ, UHZ, 0)) {
		printf("read disc info failed\n");
		return -1;
	}

	return di.mrw_status;
}

int poll_events(int fd)
{
	int event, quit, first, progress, media_status;

	quit = 0;
	first = 1;
	do {
		event = get_media_event(fd);
		if (event < 0)
			break;

		switch (event) {
			case 0:
				if (first)
					printf("no media change\n");
				break;
			case 1:
				printf("eject request\n");
				if ((media_status = get_mrw_media_status(fd)) == -1)
					break;
				if (media_status == CDM_MRW_BGFORMAT_ACTIVE)
					mrw_format_suspend(fd, media_status);
				quit = 1;
				break;
			case 2:
				printf("new media\n");
				break;
			case 3:
				printf("media removal\n");
				quit = 1;
				break;
			case 4:
				printf("media change\n");
				break;
			case 5:
				printf("bgformat complete!\n");
				quit = 1;
				break;
			case 6:
				printf("bgformat automatically restarted\n");
				break;
			default:
				printf("unknown media event (%d)\n", event);
				break;
		}

		if (!quit) {
			first = 0;
			progress = get_progress(fd);
			if (event)
				continue;

			sleep(2);
		}

	} while (!quit);

	return event;
}

/*
 * issue GET_CONFIGURATION and check for the mt rainier profile
 */
int check_for_mrw(int fd)
{
	struct mrw_feature_desc *mfd;
	struct cdrom_generic_command cgc;
	char buffer[16];

	INIT_CGC(&cgc);

	cgc.cmd[0] = GPCMD_GET_CONFIGURATION;
	cgc.cmd[3] = CDF_MRW;
	cgc.cmd[8] = sizeof(buffer);

	if (wait_cmd(fd, &cgc, buffer, sizeof(buffer), CGC_DATA_READ, UHZ, 1))
		return 1;

	mfd = (struct mrw_feature_desc *)&buffer[sizeof(struct feature_header)];

	return !mfd->write;
}

int __get_lba_space(int fd, int pc, char *buffer, int size)
{
	struct cdrom_generic_command cgc;

	INIT_CGC(&cgc);

	cgc.cmd[0] = GPCMD_MODE_SENSE_10;
	cgc.cmd[2] = pc | (0 << 6);
	cgc.cmd[8] = size;

	if (wait_cmd(fd, &cgc, buffer, size, CGC_DATA_READ, UHZ, 1))
		return 1;

	return 0;
}

/*
 * return LBA_DMA or LBA_GAA, -1 on failure
 */
int get_lba_space(int fd)
{
	struct mode_page_header *mph;
	char buffer[32];
	int offset;

	if (__get_lba_space(fd, mrw_mode_page, buffer, sizeof(buffer)))
		return -1;

	mph = (struct mode_page_header *) buffer;
	offset = sizeof(*mph) + bswap_16(mph->desc_length);

	/*
	 * LBA space bit is bit 0 in byte 3 of the mrw mode page
	 */
	return buffer[offset + 3] & 1;
}

int probe_mrw_mode_page(int fd)
{
	char buffer[32];

	mrw_mode_page = -1;

	if (!__get_lba_space(fd, MRW_MODE_PC, buffer, sizeof(buffer)))
		mrw_mode_page = MRW_MODE_PC;
	else if (!__get_lba_space(fd, MRW_MODE_PC_PRE1, buffer, sizeof(buffer)))
		mrw_mode_page = MRW_MODE_PC_PRE1;

	if (mrw_mode_page == MRW_MODE_PC_PRE1)
		printf("%s: still using deprecated mrw mode page\n",mrw_device);

	return mrw_mode_page;
}

int switch_lba_space(int fd, int lba_space)
{
	struct cdrom_generic_command cgc;
	struct mode_page_header *mph;
	int cur_space, offset, size;
	char buffer[32];

	if (__get_lba_space(fd, mrw_mode_page, buffer, sizeof(buffer)))
		return 1;

	mph = (struct mode_page_header *) buffer;
	offset = sizeof(*mph) + bswap_16(mph->desc_length);
	cur_space = buffer[offset + 3] & 1;

	if (cur_space == lba_space)
		return 0;

	/*
	 * mode data length doesn't include its own space
	 */
	size = bswap_16(mph->mode_data_length) + 2;

	/*
	 * init command and set the required lba space
	 */
	INIT_CGC(&cgc);

	cgc.cmd[0] = GPCMD_MODE_SELECT_10;
	cgc.cmd[8] = size;

	buffer[offset + 3] = lba_space;

	if (wait_cmd(fd, &cgc, buffer, size, CGC_DATA_WRITE, UHZ, 0))
		return 1;

	return 0;
}

void print_mrw_status(int media_status)
{
	switch (media_status) {
		case CDM_MRW_NOTMRW:
			printf("not a mrw formatted disc\n");
			break;
		case CDM_MRW_BGFORMAT_INACTIVE:
			printf("mrw format inactive and not complete\n");
			break;
		case CDM_MRW_BGFORMAT_ACTIVE:
			printf("mrw format running\n");
			break;
		case CDM_MRW_BGFORMAT_COMPLETE:
			printf("disc is mrw formatted\n");
			break;
	}
}

void print_options(const char *prg)
{
	printf("%s: options:\n", prg);
	printf("\t-d:\t<device>\n");
	printf("\t-f:\t<{restart, full} format type\n");
	printf("\t-F:\tforce format\n");
	printf("\t-s:\tsuspend format\n");
	printf("\t-p:\tpoll for format completion\n");
}

void get_options(int argc, char *argv[])
{
	char c;

	strcpy(mrw_device, "/dev/cdrom");

	while ((c = getopt(argc, argv, "d:f:Fpsl:")) != EOF) {
		switch (c) {
			case 'd':
				strcpy(mrw_device, optarg);
				break;
			case 'f':
				if (!strcmp(optarg, "full"))
					format_type = FORMAT_TYPE_FULL;
				else if (!strcmp(optarg, "restart"))
					format_type = FORMAT_TYPE_RESTART;
				else
					printf("%s: invalid format type %s\n", argv[0], optarg);
				break;
			case 'F':
				format_force = 1;
				break;
			case 'p':
				poll_wait = 1;
				break;
			case 's':
				suspend_format = 1;
				break;
			case 'l':
				if (!strcmp(optarg, "gaa"))
					lba_space = LBA_GAA;
				else if (!strcmp(optarg, "dma"))
					lba_space = LBA_DMA;
				else
					printf("%s: invalid address space %s\n", argv[0], optarg);
				break;
			default:
				if (optarg)
					printf("%s: unknown option '%s'\n", argv[0], optarg);
				print_options(argv[0]);
				exit(1);
		}
	}
}

int main(int argc, char *argv[])
{
	int fd, media_status, progress;

	if (argc == 1) {
		print_options(argv[0]);
		return 1;
	}

	get_options(argc, argv);

	fd = open(mrw_device, O_RDONLY | O_NONBLOCK);
	if (fd == -1) {
		perror("open");
		return 1;
	}

	if (check_for_mrw(fd)) {
		printf("%s: %s is not a mrw drive or mrw reader\n", argv[0], mrw_device);
		return 1;
	}

	if ((media_status = get_mrw_media_status(fd)) == -1) {
		printf("%s: failed to retrieve media status\n", argv[0]);
		return 1;
	}

	print_mrw_status(media_status);

	if (probe_mrw_mode_page(fd) == -1) {
		printf("%s: failed to probe mrw mode page\n", mrw_device);
		return 1;
	}

	if (lba_space != -1) {
		if (switch_lba_space(fd, lba_space)) {
			printf("%s: failed switching lba space\n", mrw_device);
			return 1;
		}
	}

	printf("LBA space: %s\n", lba_spaces[get_lba_space(fd)]);

	if (media_status == CDM_MRW_BGFORMAT_ACTIVE) {
		progress = get_format_progress(fd);
		printf("%s: back ground format %d%% complete\n", mrw_device, progress);
	}

	if (format_type) {
		if (mrw_format(fd, media_status))
			return 1;
	} else if (suspend_format)
		mrw_format_suspend(fd, media_status);

	if (poll_wait)
		poll_events(fd);

	return 0;
}

--UlVJffcvxoiEqYs2--
