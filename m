Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310252AbSCUNMr>; Thu, 21 Mar 2002 08:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311614AbSCUNMg>; Thu, 21 Mar 2002 08:12:36 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:16388 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S310252AbSCUNML>;
	Thu, 21 Mar 2002 08:12:11 -0500
Date: Thu, 21 Mar 2002 14:12:01 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][CFT] CD-MRW (Mt Rainier) support
Message-ID: <20020321131201.GF2109@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I've written the basic kernel and user space code to support the "new"
mt rainier cd-rw drives (hence forth known as cd-mrw in this mail).

What are these drives? They are basically CD-RW drives with a twist. The
twist, to put it shortly:

- back ground formatting support is a requirement
- read-modify-write cycle support is in firmware, not software
- bad block management is in firmware, not file system

The drives use regular CD-RW media. The media needs to be initialized
before use, the supplied mtr tool can help you do that. Basically you
just need to start a back ground format:

# ./mtr -d /dev/hdc -f full

This will take ~10 seconds or so, after which the media can be used for
writing. No more waiting for format completion. Should you wish to enjoy
the silence and watch the media format, there's a -p poll switch for
that:

# ./mtr -d /dev/hdc -p

(can of course also be used while starting the format). If you want to
remove the media before the format has completed, you need to suspend
it.

# ./mtr -d /dev/hdc -s

ide-cd will do this automagically if you remove the driver while a
format is in progress, btw (from dmesg).

cdrom: issuing MRW bgformat suspend

The mtr tool can restart a format for you as well:

# ./mtr -d /dev/hdc -f restart

ide-cd will also do this automagically if you mount a media rw which is
partially formatted, if you didn't disable the bgformat restart option
when loading cdrom.o (new options, mrw_format_restart, defaults to 1):

cdrom: mount opening for WRITE
cdrom open: mrw_status 'bgformat inactive'
cdrom: Restarting format

I dunno which drives have cd-mrw support yet, I've got some Philips
samples here. I have heard that there are at least TEAC drives with a
firmware upgrade option to support cd-mrw, and I'm sure that pretty soon
all new burners are going to have this feature. Running the mtr tool
will tell you if your drive supports cd-mrw or not.

Any file system will work, but using UDF is recommended. Make sure to
remember to include UDF rw support :-). Incidentally, 2.4.19-pre4 has a
bug that prevents UDF from being built with read-write support. Patch is
included for that and sent to Marcelo separately. Recommended format
options:

# mkudffs --media-type=cdrw -b 2048 /dev/hdc
start=0, blocks=16, type=RESERVED 
start=16, blocks=3, type=VRS 
start=19, blocks=237, type=USPACE 
start=256, blocks=1, type=ANCHOR 
start=257, blocks=31, type=USPACE 
start=288, blocks=32, type=PVDS 
start=320, blocks=32, type=LVID 
start=352, blocks=32, type=STABLE 
start=384, blocks=1024, type=SSPACE 
start=1408, blocks=256608, type=PSPACE 
start=258016, blocks=31, type=USPACE 
start=258047, blocks=1, type=ANCHOR 
start=258048, blocks=160, type=USPACE 
start=258208, blocks=32, type=STABLE 
start=258240, blocks=32, type=RVDS 
start=258272, blocks=31, type=USPACE 
start=258303, blocks=1, type=ANCHOR 

This is the first release. Works for me, YMMV.

Patch your 2.4.19-pre4 kernel and give it a spin. Note that only ide-cd
supports Mt Rainier right now. The bulk of the support is in the uniform
layer, so adding SCSI CD-ROM support is going to be a breeze. I'm not
quite done shoving code around between ide-cd and cdrom, so that's why I
didn't bother adding the SCSI bits just yet.

-- 
Jens Axboe


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=cd-mrw-1

diff -ur -X /usr/src/exclude /opt/kernel/linux-2.4.19-pre4/drivers/cdrom/cdrom.c linux/drivers/cdrom/cdrom.c
--- /opt/kernel/linux-2.4.19-pre4/drivers/cdrom/cdrom.c	Fri Nov 16 19:14:08 2001
+++ linux/drivers/cdrom/cdrom.c	Thu Mar 21 13:35:25 2002
@@ -228,10 +228,16 @@
    3.12 Oct 18, 2000 - Jens Axboe <axboe@suse.de>
   -- Use quiet bit on packet commands not known to work
 
+   3.20 Sep 24, 2001 - Jens Axboe <axboe@suse.de>
+  -- Various fixes and lots of cleanups not listed :-)
+  -- Locking fixes
+  -- Mt Rainier support
+  -- DVD-RAM write open fixes
+
 -------------------------------------------------------------------------*/
 
-#define REVISION "Revision: 3.12"
-#define VERSION "Id: cdrom.c 3.12 2000/10/18"
+#define REVISION "Revision: 3.20"
+#define VERSION "Id: cdrom.c 3.20 2001/09/24"
 
 /* I use an error-log mask to give fine grain control over the type of
    messages dumped to the system logs.  The available masks include: */
@@ -266,7 +272,6 @@
 #include <linux/init.h>
 
 #include <asm/fcntl.h>
-#include <asm/segment.h>
 #include <asm/uaccess.h>
 
 /* used to tell the module to turn on full debugging messages */
@@ -279,11 +284,23 @@
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
+static const char *mrw_format_status[4] = {
+	"not mrw",
+	"bgformat inactive",
+	"bgformat active",
+	"mrw complete",
+};
 
 #if (ERRLOGMASK!=CD_NOTHING)
 #define cdinfo(type, fmt, args...) \
@@ -321,6 +338,8 @@
 int cdrom_get_last_written(kdev_t dev, long *last_written);
 int cdrom_get_next_writable(kdev_t dev, long *next_writable);
 
+static int __cdrom_get_di(struct cdrom_device_info *cdi, disc_information *di);
+
 #ifdef CONFIG_SYSCTL
 static void cdrom_sysctl_register(void);
 #endif /* CONFIG_SYSCTL */ 
@@ -348,13 +367,14 @@
 		return -1;
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
@@ -400,8 +420,10 @@
 		}
 	}
 	cdinfo(CD_REG_UNREG, "drive \"/dev/%s\" registered\n", cdi->name);
+	spin_lock(&cdrom_lock);
 	cdi->next = topCdromPtr; 	
 	topCdromPtr = cdi;
+	spin_unlock(&cdrom_lock);
 	return 0;
 }
 #undef ENSURE
@@ -417,18 +439,23 @@
 		return -1;
 
 	prev = NULL;
+	spin_lock(&cdrom_lock);
 	cdi = topCdromPtr;
 	while (cdi != NULL && cdi->dev != unreg->dev) {
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
+	spin_unlock(&cdrom_lock);
+
 	cdi->ops->n_minors--;
 	devfs_unregister (cdi->de);
 	devfs_dealloc_unique_number (&cdrom_numspace, cdi->number);
@@ -440,13 +467,213 @@
 {
 	struct cdrom_device_info *cdi;
 
+	spin_lock(&cdrom_lock);
 	cdi = topCdromPtr;
 	while (cdi != NULL && cdi->dev != dev)
 		cdi = cdi->next;
+	spin_unlock(&cdrom_lock);
 
 	return cdi;
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
+	if (!cdi->ops->generic_packet(cdi, &cgc)) {
+		if (be16_to_cpu(eh->data_len) < sizeof(*med))
+			return 1;
+		memcpy(med, &buffer[sizeof(*eh)], sizeof(*med));
+		return 0;
+	}
+
+	return 1;
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
+	cgc.timeout = 120 * HZ;
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
+	if (__cdrom_get_di(cdi, &di))
+		return 1;
+
+	if (di.mrw_status == CDM_MRW_BGFORMAT_ACTIVE) {
+		printk("cdrom: issuing MRW bgformat suspend\n");
+		ret = cdrom_mrw_bgformat_susp(cdi, 0);
+	}
+
+	if (!ret)
+		ret = cdrom_flush_cache(cdi);
+
+	return ret;
+}
+
+/*
+ * called by sub driver before module is removed to take any last
+ * actions
+ */
+int exit_cdrom(struct cdrom_device_info *cdi)
+{
+	if (CDROM_CAN(CDC_MRW_W))
+		return cdrom_mrw_exit(cdi);
+
+	return 0;
+}
+
+static int cdrom_media_erasable(struct cdrom_device_info *cdi)
+{
+	disc_information di;
+
+	if (__cdrom_get_di(cdi, &di))
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
+	if (__cdrom_get_di(cdi, &di))
+		return 1;
+
+	if (!di.erasable)
+		return 1;
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
+	int ret;
+
+	if (CDROM_CAN(CDC_MRW_W))
+		ret = cdrom_mrw_open_write(cdi);
+	else if (CDROM_CAN(CDC_DVD_RAM))
+		ret = cdrom_dvdram_open_write(cdi);
+	else
+		ret = 1;
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
@@ -465,8 +692,15 @@
 	if ((cdi = cdrom_find_device(dev)) == NULL)
 		return -ENODEV;
 
-	if ((fp->f_mode & FMODE_WRITE) && !CDROM_CAN(CDC_DVD_RAM))
-		return -EROFS;
+	cdi->use_count++;
+	ret = -EROFS;
+	if (fp->f_mode & FMODE_WRITE) {
+		printk("cdrom: %s opening for WRITE\n", current->comm);
+		if (!CDROM_CAN(CDC_RAM))
+			goto out;
+		if (cdrom_open_write(cdi))
+			goto out;
+	}
 
 	/* if this was a O_NONBLOCK open and we should honor the flags,
 	 * do a quick open without drive/disc integrity checks. */
@@ -475,12 +709,13 @@
 	else
 		ret = open_for_data(cdi);
 
-	if (!ret) cdi->use_count++;
-
 	cdinfo(CD_OPEN, "Use count for \"/dev/%s\" now %d\n", cdi->name, cdi->use_count);
 	/* Do this on open.  Don't wait for mount, because they might
 	    not be mounting, but opening with O_NONBLOCK */
 	check_disk_change(dev);
+out:
+	if (ret)
+		cdi->use_count--;
 	return ret;
 }
 
@@ -491,6 +726,7 @@
 	struct cdrom_device_ops *cdo = cdi->ops;
 	tracktype tracks;
 	cdinfo(CD_OPEN, "entering open_for_data\n");
+
 	/* Check if the driver can report drive status.  If it can, we
 	   can do clever things.  If it can't, well, we at least tried! */
 	if (cdo->drive_status != NULL) {
@@ -568,7 +804,7 @@
 		cdinfo(CD_OPEN, "open device failed.\n"); 
 		goto clean_up_and_return;
 	}
-	if (CDROM_CAN(CDC_LOCK) && cdi->options & CDO_LOCK) {
+	if (CDROM_CAN(CDC_LOCK) && (cdi->options & CDO_LOCK)) {
 			cdo->lock_door(cdi, 1);
 			cdinfo(CD_OPEN, "door locked.\n");
 	}
@@ -646,7 +882,6 @@
 	return 0;
 }
 
-
 /* Admittedly, the logic below could be performed in a nicer way. */
 int cdrom_release(struct inode *ip, struct file *fp)
 {
@@ -657,17 +892,23 @@
 
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
@@ -1902,10 +2143,24 @@
 		}
 	}
 
+	/*
+	 * queue command and wait for it to complete
+	 */
 	ret = cdi->ops->generic_packet(cdi, cgc);
-	__copy_to_user(usense, cgc->sense, sizeof(*usense));
+
+	/*
+	 * always copy back sense, command need not have failed for it to
+	 * contain useful info
+	 */
+	if (usense)
+		__copy_to_user(usense, cgc->sense, sizeof(*usense));
+
+	/*
+	 * this really needs to be modified to copy back good bytes
+	 */
 	if (!ret && cgc->data_direction == CGC_DATA_READ)
 		__copy_to_user(ubuf, cgc->buffer, cgc->buflen);
+
 	kfree(cgc->buffer);
 	return ret;
 }
@@ -2234,10 +2489,8 @@
 	return cdo->generic_packet(cdi, &cgc);
 }
 
-/* requires CD R/RW */
-int cdrom_get_disc_info(kdev_t dev, disc_information *di)
+static int __cdrom_get_di(struct cdrom_device_info *cdi, disc_information *di)
 {
-	struct cdrom_device_info *cdi = cdrom_find_device(dev);
 	struct cdrom_device_ops *cdo = cdi->ops;
 	struct cdrom_generic_command cgc;
 	int ret;
@@ -2264,6 +2517,14 @@
 	return cdo->generic_packet(cdi, &cgc);
 }
 
+/* requires CD R/RW */
+int cdrom_get_disc_info(kdev_t dev, disc_information *di)
+{
+	struct cdrom_device_info *cdi = cdrom_find_device(dev);
+
+	return __cdrom_get_di(cdi, di);
+}
+
 
 /* return the last written block on the CD-R media. this is for the udf
    file system. */
@@ -2379,6 +2640,8 @@
 EXPORT_SYMBOL(cdrom_mode_sense);
 EXPORT_SYMBOL(init_cdrom_command);
 EXPORT_SYMBOL(cdrom_find_device);
+EXPORT_SYMBOL(exit_cdrom);
+EXPORT_SYMBOL(cdrom_get_media_event);
 
 #ifdef CONFIG_SYSCTL
 
@@ -2474,6 +2737,14 @@
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
 		
diff -ur -X /usr/src/exclude /opt/kernel/linux-2.4.19-pre4/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- /opt/kernel/linux-2.4.19-pre4/drivers/ide/ide-cd.c	Thu Mar 21 12:53:28 2002
+++ linux/drivers/ide/ide-cd.c	Thu Mar 21 13:38:34 2002
@@ -292,9 +292,13 @@
  *			  correctly reporting tray status -- from
  *			  Michael D Johnson <johnsom@orst.edu>
  *
+ * 4.60  Mar 21, 2002	- Add mt rainier support
+ *			- Bump timeout value for packet commands
+ *			- Odd stuff
+ *
  *************************************************************************/
  
-#define IDECD_VERSION "4.59"
+#define IDECD_VERSION "4.60"
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -694,12 +698,17 @@
 		case GPCMD_BLANK:
 		case GPCMD_FORMAT_UNIT:
 		case GPCMD_RESERVE_RZONE_TRACK:
-			wait = WAIT_CMD;
+		case GPCMD_CLOSE_TRACK:
+		case GPCMD_FLUSH_CACHE:
+			wait = ATAPI_WAIT_PC;
 			break;
 		default:
+			if (!pc->quiet)
+				printk("ide-cd: cmd 0x%x timed out\n",pc->c[0]);
 			wait = 0;
 			break;
 	}
+
 	return wait;
 }
 
@@ -745,7 +754,7 @@
 		(void) (HWIF(drive)->dmaproc(ide_dma_begin, drive));
 
 	if (CDROM_CONFIG_FLAGS (drive)->drq_interrupt) {
-		ide_set_handler (drive, handler, WAIT_CMD, cdrom_timer_expiry);
+		ide_set_handler (drive, handler, ATAPI_WAIT_PC, cdrom_timer_expiry);
 		OUT_BYTE (WIN_PACKETCMD, IDE_COMMAND_REG); /* packet command */
 		return ide_started;
 	} else {
@@ -1009,7 +1018,7 @@
 
 	/* Done moving data!
 	   Wait for another interrupt. */
-	ide_set_handler(drive, &cdrom_read_intr, WAIT_CMD, NULL);
+	ide_set_handler(drive, &cdrom_read_intr, ATAPI_WAIT_PC, NULL);
 	return ide_started;
 }
 
@@ -1125,16 +1134,15 @@
 	pc.c[7] = (nframes >> 8);
 	pc.c[8] = (nframes & 0xff);
 	put_unaligned(cpu_to_be32(frame), (unsigned int *) &pc.c[2]);
-	pc.timeout = WAIT_CMD;
+	pc.timeout = ATAPI_WAIT_PC;
 
 	/* Send the command to the drive and return. */
 	return cdrom_transfer_packet_command(drive, &pc, &cdrom_read_intr);
 }
 
-
 #define IDECD_SEEK_THRESHOLD	(1000)			/* 1000 blocks */
 #define IDECD_SEEK_TIMER	(5 * WAIT_MIN_SLEEP)	/* 100 ms */
-#define IDECD_SEEK_TIMEOUT     WAIT_CMD			/* 10 sec */
+#define IDECD_SEEK_TIMEOUT	(2 * WAIT_CMD)		/* 20 sec */
 
 static ide_startstop_t cdrom_seek_intr (ide_drive_t *drive)
 {
@@ -1178,7 +1186,7 @@
 	pc.c[0] = GPCMD_SEEK;
 	put_unaligned(cpu_to_be32(frame), (unsigned int *) &pc.c[2]);
 
-	pc.timeout = WAIT_CMD;
+	pc.timeout = ATAPI_WAIT_PC;
 	return cdrom_transfer_packet_command(drive, &pc, &cdrom_seek_intr);
 }
 
@@ -1192,26 +1200,6 @@
 	return cdrom_start_packet_command (drive, 0, cdrom_start_seek_continuation);
 }
 
-static inline int cdrom_merge_requests(struct request *rq, struct request *nxt)
-{
-	int ret = 1;
-
-	/*
-	 * partitions not really working, but better check anyway...
-	 */
-	if (rq->cmd == nxt->cmd && rq->rq_dev == nxt->rq_dev) {
-		rq->nr_sectors += nxt->nr_sectors;
-		rq->hard_nr_sectors += nxt->nr_sectors;
-		rq->bhtail->b_reqnext = nxt->bh;
-		rq->bhtail = nxt->bhtail;
-		list_del(&nxt->queue);
-		blkdev_release_request(nxt);
-		ret = 0;
-	}
-
-	return ret;
-}
-
 /*
  * the current request will always be the first one on the list
  */
@@ -1229,13 +1217,31 @@
 			break;
 
 		nxt = blkdev_entry_to_request(entry);
+
+		if (rq->cmd != nxt->cmd)
+			break;
+		if (rq->rq_dev != nxt->rq_dev)
+			break;
 		if (rq->sector + rq->nr_sectors != nxt->sector)
 			break;
-		else if (rq->nr_sectors + nxt->nr_sectors > SECTORS_MAX)
+		if (rq->nr_sectors + nxt->nr_sectors >= SECTORS_MAX)
 			break;
-
-		if (cdrom_merge_requests(rq, nxt))
+		if (rq->nr_segments + nxt->nr_segments > PRD_ENTRIES)
 			break;
+
+		/*
+		 * ok to merge them
+		 */
+		rq->nr_sectors += nxt->nr_sectors;
+		rq->hard_nr_sectors += nxt->nr_sectors;
+		rq->bhtail->b_reqnext = nxt->bh;
+		rq->bhtail = nxt->bhtail;
+
+		/*
+		 * release nxt
+		 */
+		blkdev_dequeue_request(nxt);
+		blkdev_release_request(nxt);
 	}
 
 	spin_unlock_irqrestore(&io_request_lock, flags);
@@ -1399,7 +1405,7 @@
 	}
 
 	/* Now we wait for another interrupt. */
-	ide_set_handler (drive, &cdrom_pc_intr, WAIT_CMD, cdrom_timer_expiry);
+	ide_set_handler (drive, &cdrom_pc_intr, ATAPI_WAIT_PC, cdrom_timer_expiry);
 	return ide_started;
 }
 
@@ -1410,7 +1416,7 @@
 	struct packet_command *pc = (struct packet_command *)rq->buffer;
 
 	if (!pc->timeout)
-		pc->timeout = WAIT_CMD;
+		pc->timeout = ATAPI_WAIT_PC;
 
 	/* Send the command to the drive and return. */
 	return cdrom_transfer_packet_command(drive, pc, &cdrom_pc_intr);
@@ -1624,7 +1630,7 @@
 	}
 
 	/* re-arm handler */
-	ide_set_handler(drive, &cdrom_write_intr, 5 * WAIT_CMD, NULL);
+	ide_set_handler(drive, &cdrom_write_intr, ATAPI_WAIT_PC, NULL);
 	return ide_started;
 }
 
@@ -1649,7 +1655,7 @@
 	pc.c[7] = (nframes >> 8) & 0xff;
 	pc.c[8] = nframes & 0xff;
 	put_unaligned(cpu_to_be32(frame), (unsigned int *)&pc.c[2]);
-	pc.timeout = 2 * WAIT_CMD;
+	pc.timeout = ATAPI_WAIT_PC;
 
 	return cdrom_transfer_packet_command(drive, &pc, cdrom_write_intr);
 }
@@ -2188,7 +2194,7 @@
 	ide_drive_t *drive = (ide_drive_t*) cdi->handle;
 
 	if (cgc->timeout <= 0)
-		cgc->timeout = WAIT_CMD;
+		cgc->timeout = ATAPI_WAIT_PC;
 
 	/* here we queue the commands from the uniform CD-ROM
 	   layer. the packet must be complete, as we do not
@@ -2200,7 +2206,13 @@
 	pc.quiet = cgc->quiet;
 	pc.timeout = cgc->timeout;
 	pc.sense = cgc->sense;
-	return cgc->stat = cdrom_queue_packet_command(drive, &pc);
+
+	cgc->stat = cdrom_queue_packet_command(drive, &pc);
+
+	if (cgc->stat)
+		printk("%02x.%02x.%02x\n", pc.sense->sense_key, pc.sense->asc, pc.sense->ascq);
+
+	return cgc->stat;
 }
 
 static
@@ -2385,37 +2397,49 @@
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
+	stat = cdrom_check_status(drive, &sense);
+	if (!stat || sense.sense_key == UNIT_ATTENTION)
+		return CDS_DISC_OK;
+
+	if (!cdrom_get_media_event(cdi, &med)) {
+		if (med.media_present)
 			return CDS_DISC_OK;
+		if (med.door_open)
+			return CDS_TRAY_OPEN;
+	}
 
+	if (sense.sense_key == NOT_READY && sense.asc == 0x04 && sense.ascq == 0x04)
+		return CDS_DISC_OK;
 
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
-
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
@@ -2523,7 +2547,8 @@
 				CDC_MEDIA_CHANGED | CDC_PLAY_AUDIO | CDC_RESET |
 				CDC_IOCTLS | CDC_DRIVE_STATUS | CDC_CD_R |
 				CDC_CD_RW | CDC_DVD | CDC_DVD_R| CDC_DVD_RAM |
-				CDC_GENERIC_PACKET,
+				CDC_GENERIC_PACKET | CDC_MRW | CDC_MRW_W |
+				CDC_RAM,
 	generic_packet:		ide_cdrom_packet,
 };
 
@@ -2558,6 +2583,10 @@
 		devinfo->mask |= CDC_PLAY_AUDIO;
 	if (!CDROM_CONFIG_FLAGS (drive)->close_tray)
 		devinfo->mask |= CDC_CLOSE_TRAY;
+	if (!CDROM_CONFIG_FLAGS(drive)->mrw)
+		devinfo->mask |= CDC_MRW;
+	if (!CDROM_CONFIG_FLAGS(drive)->mrw_w)
+		devinfo->mask |= CDC_MRW_W;
 
 	devinfo->de = devfs_register(drive->de, "cd", DEVFS_FL_DEFAULT,
 				     HWIF(drive)->major, minor,
@@ -2567,6 +2596,39 @@
 	return register_cdrom(devinfo);
 }
 
+static int ide_cdrom_get_mrw_feat(ide_drive_t *drive,
+				  struct mrw_feature_desc *mfd)
+{
+	struct cdrom_info *info = drive->driver_data;
+	struct cdrom_device_info *cdi = &info->devinfo;
+	struct cdrom_generic_command cgc;
+	struct feature_header *fh;
+	unsigned char buffer[16];
+	int ret;
+
+	cdi->handle = (ide_drive_t *) drive;
+	cdi->ops = &ide_cdrom_dops;
+	init_cdrom_command(&cgc, buffer, sizeof(buffer), CGC_DATA_READ);
+
+	cgc.cmd[0] = GPCMD_GET_CONFIGURATION;
+	cgc.cmd[3] = CDF_MRW;
+	cgc.cmd[8] = sizeof(buffer);
+
+	fh = (struct feature_header *) buffer;
+
+	ret = ide_cdrom_packet(cdi, &cgc);
+	if (!ret) {
+		if (be32_to_cpu(fh->data_len) < sizeof(*mfd)) {
+			printk("ide-cd: MRW feature desc size wrong (%d)\n",
+				be32_to_cpu(fh->data_len));
+			return 1;
+		}
+		memcpy(mfd, &buffer[sizeof(*fh)], sizeof(*mfd));
+	}
+
+	return ret;
+}
+
 static
 int ide_cdrom_get_capabilities(ide_drive_t *drive, struct atapi_capabilities_page *cap)
 {
@@ -2608,9 +2670,11 @@
 	struct cdrom_info *info = drive->driver_data;
 	struct cdrom_device_info *cdi = &info->devinfo;
 	struct atapi_capabilities_page cap;
+	struct mrw_feature_desc mfd;
 	int nslots = 1;
 
-	if (CDROM_CONFIG_FLAGS (drive)->nec260) {
+	if (CDROM_CONFIG_FLAGS (drive)->nec260 || 
+	    !strcmp(drive->id->model,"STINGRAY 8422 IDE 8X CD-ROM 7-27-95")) {
 		CDROM_CONFIG_FLAGS (drive)->no_eject = 0;                       
 		CDROM_CONFIG_FLAGS (drive)->audio_play = 1;       
 		return nslots;
@@ -2619,6 +2683,17 @@
 	if (ide_cdrom_get_capabilities(drive, &cap))
 		return 0;
 
+	/*
+	 * check mrw feature
+	 */
+	if (!ide_cdrom_get_mrw_feat(drive, &mfd)) {
+		CDROM_CONFIG_FLAGS(drive)->mrw = 1;
+		if (mfd.write) {
+			CDROM_CONFIG_FLAGS(drive)->mrw_w = 1;
+			CDROM_CONFIG_FLAGS(drive)->ram = 1;
+		}
+	}
+
 	if (cap.lock == 0)
 		CDROM_CONFIG_FLAGS (drive)->no_doorlock = 1;
 	if (cap.eject)
@@ -2631,8 +2706,10 @@
 		CDROM_CONFIG_FLAGS (drive)->test_write = 1;
 	if (cap.dvd_ram_read || cap.dvd_r_read || cap.dvd_rom)
 		CDROM_CONFIG_FLAGS (drive)->dvd = 1;
-	if (cap.dvd_ram_write)
+	if (cap.dvd_ram_write) {
 		CDROM_CONFIG_FLAGS (drive)->dvd_ram = 1;
+		CDROM_CONFIG_FLAGS(drive)->ram = 1;
+	}
 	if (cap.dvd_r_write)
 		CDROM_CONFIG_FLAGS (drive)->dvd_r = 1;
 	if (cap.audio_play)
@@ -2693,6 +2770,10 @@
         	(CDROM_CONFIG_FLAGS (drive)->cd_r)? "-R" : "", 
         	(CDROM_CONFIG_FLAGS (drive)->cd_rw)? "/RW" : "");
 
+	if (CDROM_CONFIG_FLAGS(drive)->mrw || CDROM_CONFIG_FLAGS(drive)->mrw_w)
+		printk(" CD-MR%s",
+		CDROM_CONFIG_FLAGS(drive)->mrw_w ? "W" : "");
+
         if (CDROM_CONFIG_FLAGS (drive)->is_changer) 
         	printk (" changer w/%d slots", nslots);
         else 	
@@ -2726,14 +2807,9 @@
 	struct cdrom_info *info = drive->driver_data;
 	struct cdrom_device_info *cdi = &info->devinfo;
 	int minor = drive->select.b.unit << PARTN_BITS;
+	kdev_t cd_dev = MKDEV(HWIF(drive)->major, minor);
 	int nslots;
 
-	/*
-	 * default to read-only always and fix latter at the bottom
-	 */
-	set_device_ro(MKDEV(HWIF(drive)->major, minor), 1);
-	set_blocksize(MKDEV(HWIF(drive)->major, minor), CD_FRAMESIZE);
-
 	drive->special.all	= 0;
 	drive->ready_stat	= 0;
 
@@ -2850,8 +2926,11 @@
 
 	nslots = ide_cdrom_probe_capabilities (drive);
 
-	if (CDROM_CONFIG_FLAGS(drive)->dvd_ram)
-		set_device_ro(MKDEV(HWIF(drive)->major, minor), 0);
+	/*
+	 * set correct block size and read-only for non-ram media
+	 */
+	set_blocksize(cd_dev, CD_FRAMESIZE);
+	set_device_ro(cd_dev, !CDROM_CONFIG_FLAGS(drive)->ram);
 
 	if (ide_cdrom_register (drive, nslots)) {
 		printk ("%s: ide_cdrom_setup failed to register device with the cdrom driver.\n", drive->name);
@@ -2945,6 +3024,8 @@
 {
 	struct cdrom_info *info = drive->driver_data;
 	struct cdrom_device_info *devinfo = &info->devinfo;
+
+	exit_cdrom(devinfo);
 
 	if (ide_unregister_subdriver (drive))
 		return 1;
diff -ur -X /usr/src/exclude /opt/kernel/linux-2.4.19-pre4/drivers/ide/ide-cd.h linux/drivers/ide/ide-cd.h
--- /opt/kernel/linux-2.4.19-pre4/drivers/ide/ide-cd.h	Thu Mar 21 12:53:28 2002
+++ linux/drivers/ide/ide-cd.h	Thu Mar 21 13:53:00 2002
@@ -35,6 +35,11 @@
 #define NO_DOOR_LOCKING 0
 #endif
 
+/*
+ * typical timeout for packet command
+ */
+#define ATAPI_WAIT_PC	(60 * HZ)
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
diff -ur -X /usr/src/exclude /opt/kernel/linux-2.4.19-pre4/drivers/ide/ide-dma.c linux/drivers/ide/ide-dma.c
--- /opt/kernel/linux-2.4.19-pre4/drivers/ide/ide-dma.c	Thu Mar 21 12:53:28 2002
+++ linux/drivers/ide/ide-dma.c	Thu Mar 21 08:46:02 2002
@@ -204,25 +204,6 @@
 #endif /* CONFIG_IDEDMA_NEW_DRIVE_LISTINGS */
 
 /*
- * Our Physical Region Descriptor (PRD) table should be large enough
- * to handle the biggest I/O request we are likely to see.  Since requests
- * can have no more than 256 sectors, and since the typical blocksize is
- * two or more sectors, we could get by with a limit of 128 entries here for
- * the usual worst case.  Most requests seem to include some contiguous blocks,
- * further reducing the number of table entries required.
- *
- * The driver reverts to PIO mode for individual requests that exceed
- * this limit (possible with 512 byte blocksizes, eg. MSDOS f/s), so handling
- * 100% of all crazy scenarios here is not necessary.
- *
- * As it turns out though, we must allocate a full 4KB page for this,
- * so the two PRD tables (ide0 & ide1) will each get half of that,
- * allowing each to have about 256 entries (8 bytes each) from this.
- */
-#define PRD_BYTES	8
-#define PRD_ENTRIES	(PAGE_SIZE / (2 * PRD_BYTES))
-
-/*
  * dma_intr() is the handler for disk read/write DMA interrupts
  */
 ide_startstop_t ide_dma_intr (ide_drive_t *drive)
diff -ur -X /usr/src/exclude /opt/kernel/linux-2.4.19-pre4/include/linux/cdrom.h linux/include/linux/cdrom.h
--- /opt/kernel/linux-2.4.19-pre4/include/linux/cdrom.h	Thu Nov 22 20:47:04 2001
+++ linux/include/linux/cdrom.h	Thu Mar 21 13:52:58 2002
@@ -5,7 +5,7 @@
  *               1994, 1995   Eberhard Moenkeberg, emoenke@gwdg.de
  *               1996         David van Leeuwen, david@tm.tno.nl
  *               1997, 1998   Erik Andersen, andersee@debian.org
- *               1998-2000    Jens Axboe, axboe@suse.de
+ *               1998-2002    Jens Axboe, axboe@suse.de
  */
  
 #ifndef	_LINUX_CDROM_H
@@ -387,6 +387,9 @@
 #define CDC_DVD			0x8000	/* drive is a DVD */
 #define CDC_DVD_R		0x10000	/* drive can write DVD-R */
 #define CDC_DVD_RAM		0x20000	/* drive can write DVD-RAM */
+#define CDC_MRW			0x40000	/* drive can read MRW */
+#define CDC_MRW_W		0x80000	/* drive can write MRW */
+#define CDC_RAM			0x100000 /* ok to open WRITE */
 
 /* drive status possibilities returned by CDROM_DRIVE_STATUS ioctl */
 #define CDS_NO_INFO		0	/* if not implemented */
@@ -714,16 +717,48 @@
 	__u8 asb[46];
 };
 
-#ifdef __KERNEL__
-#include <linux/devfs_fs_kernel.h>
+/*
+ * feature profile
+ */
+#define CDF_MRW		0x28
+
+/*
+ * media status bits
+ */
+#define CDM_MRW_NOTMRW			0
+#define CDM_MRW_BGFORMAT_INACTIVE	1
+#define CDM_MRW_BGFORMAT_ACTIVE		2
+#define CDM_MRW_BGFORMAT_COMPLETE	3
 
-struct cdrom_write_settings {
-	unsigned char fpacket;		/* fixed/variable packets */
-	unsigned long packet_size;	/* write out this number of packets */
-	unsigned long nwa;		/* next writeable address */
-	unsigned char writeable;	/* cdrom is writeable */
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
 };
 
+#ifdef __KERNEL__
+#include <linux/devfs_fs_kernel.h>
+
 /* Uniform cdrom data structures for cdrom.c */
 struct cdrom_device_info {
 	struct cdrom_device_ops  *ops;  /* link to device_ops */
@@ -744,7 +779,6 @@
 /* per-device flags */
         __u8 sanyo_slot		: 2;	/* Sanyo 3 CD changer support */
         __u8 reserved		: 6;	/* not used yet */
-	struct cdrom_write_settings write;
 };
 
 struct cdrom_device_ops {
@@ -784,6 +818,7 @@
 
 extern int register_cdrom(struct cdrom_device_info *cdi);
 extern int unregister_cdrom(struct cdrom_device_info *cdi);
+extern int exit_cdrom(struct cdrom_device_info *cdi);
 
 static inline void devfs_plain_cdrom(struct cdrom_device_info *cdi,
 				struct block_device_operations *ops)
@@ -819,7 +854,9 @@
 			       void *buffer, int len, int type);
 extern struct cdrom_device_info *cdrom_find_device(kdev_t dev);
 
-typedef struct {
+#endif /* __KERNEL__ */
+
+typedef struct discinformation {
 	__u16 disc_information_length;
 #if defined(__BIG_ENDIAN_BITFIELD)
 	__u8 reserved1			: 3;
@@ -842,9 +879,13 @@
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
@@ -861,7 +902,7 @@
 	__u8 n_opc;
 } disc_information;
 
-typedef struct {
+typedef struct trackinformation {
 	__u16 track_information_length;
 	__u8 track_lsb;
 	__u8 session_lsb;
@@ -901,10 +942,6 @@
 	__u32 last_rec_address;
 } track_information;
 
-extern int cdrom_get_disc_info(kdev_t dev, disc_information *di);
-extern int cdrom_get_track_info(kdev_t dev, __u16 track, __u8 type,
-				track_information *ti);
-
 /* The SCSI spec says there could be 256 slots. */
 #define CDROM_MAX_SLOTS	256
 
@@ -1053,6 +1090,50 @@
 	__u8 reserved3;
 } rpc_state_t;
 
-#endif  /* End of kernel only stuff */ 
+struct feature_header {
+	__u32 data_len;
+	__u8 reserved1;
+	__u8 reserved2;
+	__u16 curr_profile;
+};
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
+#ifdef __KERNEL__
+extern int cdrom_get_disc_info(kdev_t dev, disc_information *di);
+extern int cdrom_get_track_info(kdev_t dev, __u16 track, __u8 type,
+				track_information *ti);
+extern int cdrom_get_media_event(struct cdrom_device_info *cdi, struct media_event_desc *med);
+#endif /* __KERNEL__ */
 
 #endif  /* _LINUX_CDROM_H */
diff -ur -X /usr/src/exclude /opt/kernel/linux-2.4.19-pre4/include/linux/ide.h linux/include/linux/ide.h
--- /opt/kernel/linux-2.4.19-pre4/include/linux/ide.h	Thu Mar 21 12:53:32 2002
+++ linux/include/linux/ide.h	Thu Mar 21 13:52:59 2002
@@ -259,6 +259,25 @@
 #endif
 
 /*
+ * Our Physical Region Descriptor (PRD) table should be large enough
+ * to handle the biggest I/O request we are likely to see.  Since requests
+ * can have no more than 256 sectors, and since the typical blocksize is
+ * two or more sectors, we could get by with a limit of 128 entries here for
+ * the usual worst case.  Most requests seem to include some contiguous blocks,
+ * further reducing the number of table entries required.
+ *
+ * The driver reverts to PIO mode for individual requests that exceed
+ * this limit (possible with 512 byte blocksizes, eg. MSDOS f/s), so handling
+ * 100% of all crazy scenarios here is not necessary.
+ *
+ * As it turns out though, we must allocate a full 4KB page for this,
+ * so the two PRD tables (ide0 & ide1) will each get half of that,
+ * allowing each to have about 256 entries (8 bytes each) from this.
+ */
+#define PRD_BYTES	8
+#define PRD_ENTRIES	(PAGE_SIZE / (2 * PRD_BYTES))
+
+/*
  * hwif_chipset_t is used to keep track of the specific hardware
  * chipset used by each IDE interface, if known.
  */
diff -ur -X /usr/src/exclude /opt/kernel/linux-2.4.19-pre4/include/linux/udf_fs.h linux/include/linux/udf_fs.h
--- /opt/kernel/linux-2.4.19-pre4/include/linux/udf_fs.h	Thu Mar 21 12:53:32 2002
+++ linux/include/linux/udf_fs.h	Thu Mar 21 14:00:50 2002
@@ -30,6 +30,7 @@
  * HISTORY
  *
  */
+#include <linux/config.h>
 
 #ifndef _UDF_FS_H
 #define _UDF_FS_H 1

--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mtr.c"

/*
 * Copyright (c) 2002 Jens Axboe <axboe@suse.de>
 *
 * mtr -- utility to manage mt rainier cd drives + media
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
#include <sys/ioctl.h>

#include <linux/cdrom.h>

#define INIT_CGC(cgc)	memset((cgc), 0, sizeof(struct cdrom_generic_command))

#define FORMAT_TYPE_RESTART	1
#define FORMAT_TYPE_FULL	2

static int format_type, format_force, poll_wait, poll_err, suspend_format;

static char mrw_device[256];

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
	     int len, int ddir, int timeout)
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
	if (ret == -1) {
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

	return wait_cmd(fd, &cgc, buffer, sizeof(buffer), CGC_DATA_WRITE, 600);
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

	if (wait_cmd(fd, &cgc, NULL, 0, CGC_DATA_NONE, 1000)) {
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

	ret = wait_cmd(fd, &cgc, buffer, sizeof(buffer), CGC_DATA_READ, 600);
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

	(void) wait_cmd(fd, &cgc, NULL, 0, CGC_DATA_NONE, 1000);

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

	if (wait_cmd(fd, &cgc, NULL, 0, CGC_DATA_NONE, 1000)) {
		printf("%s: TUR failed\n", mrw_device);
		return 0;
	}

	if (sense.sense_key != 0x02 && sense.asc != 0x04 && sense.ascq != 0x04)
		printf("%02x.%02x.%02x\n", sense.sense_key, sense.asc, sense.ascq);

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

	if (wait_cmd(fd, &cgc, &di, sizeof(di), CGC_DATA_READ, 60)) {
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

	if (wait_cmd(fd, &cgc, buffer, sizeof(buffer), CGC_DATA_READ, 60))
		return 1;

	mfd = (struct mrw_feature_desc *)&buffer[sizeof(struct feature_header)];

	return !mfd->write;
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

	while ((c = getopt(argc, argv, "d:f:Fps")) != EOF) {
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

--qMm9M+Fa2AknHoGS--
