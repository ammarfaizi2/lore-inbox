Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316792AbSFJJMR>; Mon, 10 Jun 2002 05:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316794AbSFJJMQ>; Mon, 10 Jun 2002 05:12:16 -0400
Received: from hera.cwi.nl ([192.16.191.8]:44994 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S316792AbSFJJMJ>;
	Mon, 10 Jun 2002 05:12:09 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 10 Jun 2002 11:12:06 +0200 (MEST)
Message-Id: <UTC200206100912.g5A9C6C21596.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] scsi stuff
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below cleans up some SCSI stuff.

The main purpose is to avoid trying to read the partition table
of a removable disk when the drive has told us that no media
are present. (Right now we try to read a 4K block and fail and
retry and fail, and give an I/O error on the first sector,
then try to read the second sector and fail and retry ...)

Unused fields  sector_bit_size  and  sector_bit_shift  in
struct scsi_disk were removed. The field  has_part_table
(that has nothing to do with partition tables) was
renamed to  has_been_registered . The field  ready  was
renamed to  media_present .
The overly long  sd_init_onedisk()  was split up.

When we notice that no media are present anymore, the
partitions are removed from /proc/partitions, but the
drive remains, with size 0.

A future patch will remove the field  capacity  - there are
all too many places where capacities are stored - but the
present patch is large enough already.

There is also a quite independent patch in scsi_error.c
(yesterday someone had an infinite loop retrying to read
bad media) - this patch honours the SCpnt->retries.
In case you applied this already, just ignore the scsi_error.c part.

Also some "Overrides for Emacs" were removed.

Andries


diff -u --recursive --new-file andries/drivers/block/genhd.c brouwer/drivers/block/genhd.c
--- andries/drivers/block/genhd.c	Sun Jun  9 07:29:50 2002
+++ brouwer/drivers/block/genhd.c	Mon Jun 10 01:58:36 2002
@@ -177,9 +177,10 @@
 	if (sgp == gendisk_head)
 		seq_puts(part, "major minor  #blocks  name\n\n");
 
-	/* show all non-0 size partitions of this disk */
+	/* show the full disk and all non-0 size partitions of it */
 	for (n = 0; n < (sgp->nr_real << sgp->minor_shift); n++) {
-		if (sgp->part[n].nr_sects == 0)
+		int minormask = (1<<sgp->minor_shift) - 1;
+		if ((n & minormask) && sgp->part[n].nr_sects == 0)
 			continue;
 		seq_printf(part, "%4d  %4d %10d %s\n",
 			sgp->major, n, sgp->sizes[n],
diff -u --recursive --new-file andries/drivers/scsi/NCR53C9x.c brouwer/drivers/scsi/NCR53C9x.c
--- andries/drivers/scsi/NCR53C9x.c	Sun Jun  9 07:28:04 2002
+++ brouwer/drivers/scsi/NCR53C9x.c	Sun Jun  9 16:32:34 2002
@@ -2048,7 +2048,7 @@
 	 * and not only for the entire host adapter as it is now, the workaround
 	 * is way to expensive performance wise.
 	 * Instead, it turns out that when this happens the target has disconnected
-	 * allready but it doesn't show in the interrupt register. Compensate for
+	 * already but it doesn't show in the interrupt register. Compensate for
 	 * that here to try and avoid a SCSI bus reset.
 	 */
 	if(!esp->fas_premature_intr_workaround && (fifocnt == 1) &&
diff -u --recursive --new-file andries/drivers/scsi/scsi_error.c brouwer/drivers/scsi/scsi_error.c
--- andries/drivers/scsi/scsi_error.c	Sun Jun  9 07:26:30 2002
+++ brouwer/drivers/scsi/scsi_error.c	Sun Jun  9 22:17:53 2002
@@ -1095,6 +1095,8 @@
  */
 STATIC int scsi_eh_completed_normally(Scsi_Cmnd * SCpnt)
 {
+	int rtn;
+
 	/*
 	 * First check the host byte, to see if there is anything in there
 	 * that would indicate what we need to do.
@@ -1102,20 +1104,25 @@
 	if (host_byte(SCpnt->result) == DID_RESET) {
 		if (SCpnt->flags & IS_RESETTING) {
 			/*
-			 * OK, this is normal.  We don't know whether in fact the
-			 * command in question really needs to be rerun or not - 
-			 * if this was the original data command then the answer is yes,
-			 * otherwise we just flag it as success.
+			 * OK, this is normal.  We don't know whether in fact
+			 * the command in question really needs to be rerun
+			 * or not - if this was the original data command then
+			 * the answer is yes, otherwise we just flag it as
+			 * success.
 			 */
 			SCpnt->flags &= ~IS_RESETTING;
-			return NEEDS_RETRY;
+			goto maybe_retry;
 		}
 		/*
-		 * Rats.  We are already in the error handler, so we now get to try
-		 * and figure out what to do next.  If the sense is valid, we have
-		 * a pretty good idea of what to do.  If not, we mark it as failed.
+		 * Rats.  We are already in the error handler, so we now
+		 * get to try and figure out what to do next.  If the sense
+		 * is valid, we have a pretty good idea of what to do.
+		 * If not, we mark it as failed.
 		 */
-		return scsi_check_sense(SCpnt);
+		rtn = scsi_check_sense(SCpnt);
+		if (rtn == NEEDS_RETRY)
+			goto maybe_retry;
+		return rtn;
 	}
 	if (host_byte(SCpnt->result) != DID_OK) {
 		return FAILED;
@@ -1127,14 +1134,18 @@
 		return FAILED;
 	}
 	/*
-	 * Now, check the status byte to see if this indicates anything special.
+	 * Now, check the status byte to see if this indicates
+	 * anything special.
 	 */
 	switch (status_byte(SCpnt->result)) {
 	case GOOD:
 	case COMMAND_TERMINATED:
 		return SUCCESS;
 	case CHECK_CONDITION:
-		return scsi_check_sense(SCpnt);
+		rtn = scsi_check_sense(SCpnt);
+		if (rtn == NEEDS_RETRY)
+			goto maybe_retry;
+		return rtn;
 	case CONDITION_GOOD:
 	case INTERMEDIATE_GOOD:
 	case INTERMEDIATE_C_GOOD:
@@ -1149,6 +1160,14 @@
 		return FAILED;
 	}
 	return FAILED;
+
+ maybe_retry:
+	if ((++SCpnt->retries) < SCpnt->allowed) {
+		return NEEDS_RETRY;
+	} else {
+		/* No more retries - report this one back to upper level */
+		return SUCCESS;
+	}
 }
 
 /*
diff -u --recursive --new-file andries/drivers/scsi/scsi_ioctl.c brouwer/drivers/scsi/scsi_ioctl.c
--- andries/drivers/scsi/scsi_ioctl.c	Sun Jun  9 07:31:27 2002
+++ brouwer/drivers/scsi/scsi_ioctl.c	Mon Jun 10 02:21:16 2002
@@ -127,7 +127,7 @@
 				/* gag this error, VFS will log it anyway /axboe */
 				/* printk(KERN_INFO "Disc change detected.\n"); */
 				break;
-			};
+			}
 		default:	/* Fall through for non-removable media */
 			printk("SCSI error: host %d id %d lun %d return code = %x\n",
 			       dev->host->host_no,
@@ -139,7 +139,7 @@
 			       sense_error(SRpnt->sr_sense_buffer[0]),
 			       SRpnt->sr_sense_buffer[2] & 0xf);
 
-		};
+		}
 
 	result = SRpnt->sr_result;
 
@@ -152,7 +152,7 @@
 }
 
 /*
- * This interface is depreciated - users should use the scsi generic (sg)
+ * This interface is deprecated - users should use the scsi generic (sg)
  * interface instead, as this is a more flexible approach to performing
  * generic SCSI commands on a device.
  *
@@ -516,22 +516,3 @@
 	set_fs(oldfs);
 	return tmp;
 }
-
-/*
- * Overrides for Emacs so that we almost follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 4
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -4
- * c-argdecl-indent: 4
- * c-label-offset: -4
- * c-continued-statement-offset: 4
- * c-continued-brace-offset: 0
- * indent-tabs-mode: nil
- * tab-width: 8
- * End:
- */
diff -u --recursive --new-file andries/drivers/scsi/sd.c brouwer/drivers/scsi/sd.c
--- andries/drivers/scsi/sd.c	Sun Jun  9 07:27:53 2002
+++ brouwer/drivers/scsi/sd.c	Mon Jun 10 10:16:24 2002
@@ -95,7 +95,7 @@
 static int check_scsidisk_media_change(kdev_t);
 static int fop_revalidate_scsidisk(kdev_t);
 
-static int sd_init_onedisk(Scsi_Disk * sdkp, int dsk_nr);
+static void sd_init_onedisk(Scsi_Disk * sdkp, int dsk_nr);
 
 static int sd_init(void);
 static void sd_finish(void);
@@ -151,22 +151,24 @@
 	Scsi_Device *sdp;
 	struct Scsi_Host *shp = hp;
 	int dsk_nr;
+	kdev_t retval = NODEV;
 	unsigned long iflags;
 
 	SCSI_LOG_HLQUEUE(3, printk("sd_find_target: host_nr=%d, "
 			    "scsi_id=%d\n", shp->host_no, scsi_id));
 	read_lock_irqsave(&sd_dsk_arr_lock, iflags);
 	for (dsk_nr = 0; dsk_nr < sd_template.dev_max; ++dsk_nr) {
-		if (NULL == (sdkp = sd_dsk_arr[dsk_nr]))
+		sdkp = sd_dsk_arr[dsk_nr];
+		if (sdkp == NULL)
 			continue;
 		sdp = sdkp->device;
 		if (sdp && (sdp->host == shp) && (sdp->id == scsi_id)) {
-			read_unlock_irqrestore(&sd_dsk_arr_lock, iflags);
-			return MKDEV_SD(dsk_nr);
+			retval = MKDEV_SD(dsk_nr);
+			break;
 		}
 	}
 	read_unlock_irqrestore(&sd_dsk_arr_lock, iflags);
-	return NODEV;
+	return retval;
 }
 #endif
 
@@ -221,8 +223,8 @@
 	
 			/* default to most commonly used values */
 	
-		        diskinfo[0] = 0x40;
-	        	diskinfo[1] = 0x20;
+		        diskinfo[0] = 0x40;	/* 1 << 6 */
+	        	diskinfo[1] = 0x20;	/* 1 << 5 */
 	        	diskinfo[2] = sdkp->capacity >> 11;
 	
 			/* override with calculated, extended default, 
@@ -530,7 +532,7 @@
 		/*
 		 * If the drive is empty, just let the open fail.
 		 */
-		if ((!sdkp->ready) && !(filp->f_flags & O_NDELAY)) {
+		if ((!sdkp->media_present) && !(filp->f_flags & O_NDELAY)) {
 			retval = -ENOMEDIUM;
 			goto error_out;
 		}
@@ -786,8 +788,7 @@
 	 * that we would ever take a device offline in the first place.
 	 */
 	if (sdp->online == FALSE) {
-		sdkp->ready = 0;
-		sdp->changed = 1;
+		sd_set_media_not_present(sdkp);
 		return 1;	/* This will force a flush, if called from
 				 * check_disk_change */
 	}
@@ -808,18 +809,17 @@
 				 * it out later once the drive is available
 				 * again.  */
 
-		sdkp->ready = 0;
-		sdp->changed = 1;
+		sd_set_media_not_present(sdkp);
 		return 1;	/* This will force a flush, if called from
 				 * check_disk_change */
 	}
 	/*
-	 * for removable scsi disk ( FLOPTICAL ) we have to recognise the
-	 * presence of disk in the drive. This is kept in the Scsi_Disk
+	 * For removable scsi disk we have to recognise the presence
+	 * of a disk in the drive. This is kept in the Scsi_Disk
 	 * struct and tested at open !  Daniel Roche ( dan@lectra.fr )
 	 */
 
-	sdkp->ready = 1;	/* FLOPTICAL */
+	sdkp->media_present = 1;
 
 	retval = sdp->changed;
 	if (!flag)
@@ -827,63 +827,38 @@
 	return retval;
 }
 
-/**
- *	sd_init_onedisk - called the first time a new disk is seen,
- *	performs read_capacity, disk spin up (as required), etc.
- *	@sdkp: pointer to associated Scsi_Disk object
- *	@dsk_nr: disk number within this driver (e.g. 0->/dev/sda,
- *	1->/dev/sdb, etc)
- *
- *	Returns dsk_nr (pointless)
- *
- *	Note: this function is local to this driver.
- **/
-static int sd_init_onedisk(Scsi_Disk * sdkp, int dsk_nr)
-{
-	unsigned char cmd[10];
-	char nbuff[6];
-	unsigned char *buffer;
-	unsigned long spintime_value = 0;
-	int the_result, retries, spintime;
-	int sector_size;
-	Scsi_Device *sdp;
-	Scsi_Request *SRpnt;
-
-	SCSI_LOG_HLQUEUE(3, printk("sd_init_onedisk: dsk_nr=%d\n", 
-			    dsk_nr));
-	/*
-	 * Get the name of the disk, in case we need to log it somewhere.
-	 */
-	sd_dskname(dsk_nr, nbuff);
-
-	/*
-	 * If the device is offline, don't try and read capacity or any
-	 * of the other niceties.
-	 */
-	sdp = sdkp->device;
-	if (sdp->online == FALSE)
-		return dsk_nr;
-
-	/*
-	 * We need to retry the READ_CAPACITY because a UNIT_ATTENTION is
-	 * considered a fatal error, and many devices report such an error
-	 * just after a scsi bus reset.
-	 */
+static void
+sd_set_media_not_present(Scsi_Disk *sdkp) {
+	sdkp->media_present = 0;
+	sdkp->capacity = 0;
+	sdkp->device->changed = 1;
+}
 
-	SRpnt = scsi_allocate_request(sdp);
-	if (!SRpnt) {
-		printk(KERN_WARNING "(sd_init_onedisk:) Request allocation "
-		       "failure.\n");
-		return dsk_nr;
+static int
+sd_media_not_present(Scsi_Disk *sdkp, Scsi_Request *SRpnt) {
+	int the_result = SRpnt->sr_result;
+
+	if (the_result != 0
+	    && (driver_byte(the_result) & DRIVER_SENSE) != 0
+	    && (SRpnt->sr_sense_buffer[2] == NOT_READY ||
+		SRpnt->sr_sense_buffer[2] == UNIT_ATTENTION)
+	    && SRpnt->sr_sense_buffer[12] == 0x3A /* medium not present */) {
+		sd_set_media_not_present(sdkp);
+		return 1;
 	}
+	return 0;
+}
 
-	buffer = kmalloc(512, GFP_DMA);
-	if (!buffer) {
-		printk(KERN_WARNING "(sd_init_onedisk:) Memory allocation "
-		       "failure.\n");
-		scsi_release_request(SRpnt);
-		return dsk_nr;
-	}
+/*
+ * spinup disk - called only in sd_init_onedisk()
+ */
+static void
+sd_spinup_disk(Scsi_Disk *sdkp, char *diskname,
+	       Scsi_Request *SRpnt, unsigned char *buffer) {
+	unsigned char cmd[10];
+	Scsi_Device *sdp = sdkp->device;
+	unsigned long spintime_value = 0;
+	int the_result, retries, spintime;
 
 	spintime = 0;
 
@@ -895,15 +870,16 @@
 		while (retries < 3) {
 			cmd[0] = TEST_UNIT_READY;
 			cmd[1] = (sdp->scsi_level <= SCSI_2) ?
-				 ((sdp->lun << 5) & 0xe0) : 0;
+				((sdp->lun << 5) & 0xe0) : 0;
 			memset((void *) &cmd[2], 0, 8);
+
 			SRpnt->sr_cmd_len = 0;
 			SRpnt->sr_sense_buffer[0] = 0;
 			SRpnt->sr_sense_buffer[2] = 0;
 			SRpnt->sr_data_direction = SCSI_DATA_NONE;
 
 			scsi_wait_req (SRpnt, (void *) cmd, (void *) buffer,
-				0/*512*/, SD_TIMEOUT, MAX_RETRIES);
+				       0/*512*/, SD_TIMEOUT, MAX_RETRIES);
 
 			the_result = SRpnt->sr_result;
 			retries++;
@@ -917,16 +893,8 @@
 		 * any media in it, don't bother with any of the rest of
 		 * this crap.
 		 */
-		if( the_result != 0
-		    && ((driver_byte(the_result) & DRIVER_SENSE) != 0)
-		    && SRpnt->sr_sense_buffer[2] == UNIT_ATTENTION
-		    && SRpnt->sr_sense_buffer[12] == 0x3A ) {
-			sdkp->capacity = 0x1fffff;
-			sector_size = 512;
-			sdp->changed = 1;
-			sdkp->ready = 0;
-			break;
-		}
+		if (sd_media_not_present(sdkp, SRpnt))
+			return;
 
 		/* Look for non-removable devices that return NOT_READY.
 		 * Issue command to spin up drive for these cases. */
@@ -935,10 +903,10 @@
 			unsigned long time1;
 			if (!spintime) {
 				printk(KERN_NOTICE "%s: Spinning up disk...",
-				       nbuff);
+				       diskname);
 				cmd[0] = START_STOP;
 				cmd[1] = (sdp->scsi_level <= SCSI_2) ?
-				 	 ((sdp->lun << 5) & 0xe0) : 0;
+					((sdp->lun << 5) & 0xe0) : 0;
 				cmd[1] |= 1;	/* Return immediately */
 				memset((void *) &cmd[2], 0, 8);
 				cmd[4] = 1;	/* Start spin cycle */
@@ -963,65 +931,63 @@
 		}
 	} while (the_result && spintime &&
 		 time_after(spintime_value + 100 * HZ, jiffies));
+
 	if (spintime) {
 		if (the_result)
 			printk("not responding...\n");
 		else
 			printk("ready\n");
 	}
+}
+
+/*
+ * read disk capacity - called only in sd_init_onedisk()
+ */
+static void
+sd_read_capacity(Scsi_Disk *sdkp, char *diskname,
+		 Scsi_Request *SRpnt, unsigned char *buffer) {
+	unsigned char cmd[10];
+	Scsi_Device *sdp = sdkp->device;
+	int the_result, retries;
+	int sector_size;
+
 	retries = 3;
 	do {
 		cmd[0] = READ_CAPACITY;
 		cmd[1] = (sdp->scsi_level <= SCSI_2) ?
-			 ((sdp->lun << 5) & 0xe0) : 0;
+			((sdp->lun << 5) & 0xe0) : 0;
 		memset((void *) &cmd[2], 0, 8);
 		memset((void *) buffer, 0, 8);
+
 		SRpnt->sr_cmd_len = 0;
 		SRpnt->sr_sense_buffer[0] = 0;
 		SRpnt->sr_sense_buffer[2] = 0;
-
 		SRpnt->sr_data_direction = SCSI_DATA_READ;
+
 		scsi_wait_req(SRpnt, (void *) cmd, (void *) buffer,
-			    8, SD_TIMEOUT, MAX_RETRIES);
+			      8, SD_TIMEOUT, MAX_RETRIES);
+
+		if (sd_media_not_present(sdkp, SRpnt))
+			return;
 
 		the_result = SRpnt->sr_result;
 		retries--;
 
 	} while (the_result && retries);
 
-	/*
-	 * The SCSI standard says:
-	 * "READ CAPACITY is necessary for self configuring software"
-	 *  While not mandatory, support of READ CAPACITY is strongly
-	 *  encouraged.
-	 *  We used to die if we couldn't successfully do a READ CAPACITY.
-	 *  But, now we go on about our way.  The side effects of this are
-	 *
-	 *  1. We can't know block size with certainty. I have said
-	 *     "512 bytes is it" as this is most common.
-	 *
-	 *  2. Recovery from when someone attempts to read past the
-	 *     end of the raw device will be slower.
-	 */
-
 	if (the_result) {
 		printk(KERN_NOTICE "%s : READ CAPACITY failed.\n"
 		       "%s : status=%x, message=%02x, host=%d, driver=%02x \n",
-		       nbuff, nbuff,
+		       diskname, diskname,
 		       status_byte(the_result),
 		       msg_byte(the_result),
 		       host_byte(the_result),
-		       driver_byte(the_result)
-		    );
+		       driver_byte(the_result));
+
 		if (driver_byte(the_result) & DRIVER_SENSE)
 			print_req_sense("sd", SRpnt);
 		else
-			printk("%s : sense not available. \n", nbuff);
-
-		printk(KERN_NOTICE "%s : block size assumed to be 512 "
-		       "bytes, disk size 1GB.  \n", nbuff);
-		sdkp->capacity = 0x1fffff;
-		sector_size = 512;
+			printk("%s : sense not available. \n", diskname);
 
 		/* Set dirty bit for removable devices if not ready -
 		 * sometimes drives will not report this properly. */
@@ -1029,130 +995,193 @@
 		    SRpnt->sr_sense_buffer[2] == NOT_READY)
 			sdp->changed = 1;
 
-	} else {
+		/* Either no media are present but the drive didnt tell us,
+		   or they are present but the read capacity command fails */
+		/* sdkp->media_present = 0; -- not always correct */
+		sdkp->capacity = 0x200000; /* 1 GB - random */
+
+		return;
+	}
+
+	sdkp->capacity = 1 + ((buffer[0] << 24) |
+			      (buffer[1] << 16) |
+			      (buffer[2] << 8) |
+			      buffer[3]);
+
+	sector_size = (buffer[4] << 24) |
+		(buffer[5] << 16) | (buffer[6] << 8) | buffer[7];
+
+	if (sector_size == 0) {
+		sector_size = 512;
+		printk(KERN_NOTICE "%s : sector size 0 reported, "
+		       "assuming 512.\n", diskname);
+	}
+
+	if (sector_size != 512 &&
+	    sector_size != 1024 &&
+	    sector_size != 2048 &&
+	    sector_size != 4096 &&
+	    sector_size != 256) {
+		printk(KERN_NOTICE "%s : unsupported sector size "
+		       "%d.\n", diskname, sector_size);
 		/*
-		 * FLOPTICAL, if read_capa is ok, drive is assumed to be ready
+		 * The user might want to re-format the drive with
+		 * a supported sectorsize.  Once this happens, it
+		 * would be relatively trivial to set the thing up.
+		 * For this reason, we leave the thing in the table.
 		 */
-		sdkp->ready = 1;
+		sdkp->capacity = 0;
+	}
+	{
+		/*
+		 * The msdos fs needs to know the hardware sector size
+		 * So I have created this table. See ll_rw_blk.c
+		 * Jacques Gelinas (Jacques@solucorp.qc.ca)
+		 */
+		int hard_sector = sector_size;
+		int sz = sdkp->capacity * (hard_sector/256);
+		request_queue_t *queue = &sdp->request_queue;
+
+		blk_queue_hardsect_size(queue, hard_sector);
+		printk(KERN_NOTICE "SCSI device %s: "
+		       "%d %d-byte hdwr sectors (%d MB)\n",
+		       diskname, sdkp->capacity,
+		       hard_sector, (sz/2 - sz/1250 + 974)/1950);
+	}
+
+	/* Rescale capacity to 512-byte units */
+	if (sector_size == 4096)
+		sdkp->capacity <<= 3;
+	if (sector_size == 2048)
+		sdkp->capacity <<= 2;
+	if (sector_size == 1024)
+		sdkp->capacity <<= 1;
+	if (sector_size == 256)
+		sdkp->capacity >>= 1;
 
-		sdkp->capacity = 1 + ((buffer[0] << 24) |
-				      (buffer[1] << 16) |
-				      (buffer[2] << 8) |
-				      buffer[3]);
-
-		sector_size = (buffer[4] << 24) |
-		    (buffer[5] << 16) | (buffer[6] << 8) | buffer[7];
-
-		if (sector_size == 0) {
-			sector_size = 512;
-			printk(KERN_NOTICE "%s : sector size 0 reported, "
-			       "assuming 512.\n", nbuff);
-		}
-		if (sector_size != 512 &&
-		    sector_size != 1024 &&
-		    sector_size != 2048 &&
-		    sector_size != 4096 &&
-		    sector_size != 256) {
-			printk(KERN_NOTICE "%s : unsupported sector size "
-			       "%d.\n", nbuff, sector_size);
-			/*
-			 * The user might want to re-format the drive with
-			 * a supported sectorsize.  Once this happens, it
-			 * would be relatively trivial to set the thing up.
-			 * For this reason, we leave the thing in the table.
-			 */
-			sdkp->capacity = 0;
-		}
-		{
-			/*
-			 * The msdos fs needs to know the hardware sector size
-			 * So I have created this table. See ll_rw_blk.c
-			 * Jacques Gelinas (Jacques@solucorp.qc.ca)
-			 */
-			int hard_sector = sector_size;
-			int sz = sdkp->capacity * (hard_sector/256);
-			request_queue_t *queue = &sdp->request_queue;
-
-			blk_queue_hardsect_size(queue, hard_sector);
-			printk(KERN_NOTICE "SCSI device %s: "
-			       "%d %d-byte hdwr sectors (%d MB)\n",
-			       nbuff, sdkp->capacity,
-			       hard_sector, (sz/2 - sz/1250 + 974)/1950);
-		}
+	sdkp->device->sector_size = sector_size;
+}
 
-		/* Rescale capacity to 512-byte units */
-		if (sector_size == 4096)
-			sdkp->capacity <<= 3;
-		if (sector_size == 2048)
-			sdkp->capacity <<= 2;
-		if (sector_size == 1024)
-			sdkp->capacity <<= 1;
-		if (sector_size == 256)
-			sdkp->capacity >>= 1;
+/*
+ * read write protect setting, if possible - called only in sd_init_onedisk()
+ */
+static void
+sd_read_write_protect_flag(Scsi_Disk *sdkp, char *diskname,
+			   Scsi_Request *SRpnt, unsigned char *buffer) {
+	Scsi_Device *sdp = sdkp->device;
+	unsigned char cmd[8];
+	int the_result;
+
+	/*
+	 * For removable scsi disks we have to recognise the
+	 * Write Protect Flag. This flag is kept in the Scsi_Disk
+	 * struct and tested at open !
+	 * Daniel Roche ( dan@lectra.fr )
+	 *
+	 * Changed to get all pages (0x3f) rather than page 1 to
+	 * get around devices which do not have a page 1.  Since
+	 * we're only interested in the header anyway, this should
+	 * be fine.
+	 *   -- Matthew Dharm (mdharm-scsi@one-eyed-alien.net)
+	 *
+	 * As it turns out, some devices return an error for
+	 * every MODE_SENSE request except one for page 0.
+	 * So, we should also try that. --aeb
+	 */
+
+	memset((void *) &cmd[0], 0, 8);
+	cmd[0] = MODE_SENSE;
+	cmd[1] = (sdp->scsi_level <= SCSI_2) ?
+		((sdp->lun << 5) & 0xe0) : 0;
+	cmd[2] = 0x3f;	/* Get all pages */
+	cmd[4] = 255;   /* Ask for 255 bytes, even tho we want just the first 8 */
+	SRpnt->sr_cmd_len = 0;
+	SRpnt->sr_sense_buffer[0] = 0;
+	SRpnt->sr_sense_buffer[2] = 0;
+	SRpnt->sr_data_direction = SCSI_DATA_READ;
+
+	scsi_wait_req(SRpnt, (void *) cmd, (void *) buffer,
+		      512, SD_TIMEOUT, MAX_RETRIES);
+
+	the_result = SRpnt->sr_result;
+
+	if (the_result) {
+		printk("%s: test WP failed, assume Write Enabled\n",
+		       diskname);
+		/* alternatively, try page 0 */
+	} else {
+		sdkp->write_prot = ((buffer[2] & 0x80) != 0);
+		printk(KERN_NOTICE "%s: Write Protect is %s\n", diskname,
+		       sdkp->write_prot ? "on" : "off");
 	}
+}
 
+/**
+ *	sd_init_onedisk - called the first time a new disk is seen,
+ *	performs disk spin up, read_capacity, etc.
+ *	@sdkp: pointer to associated Scsi_Disk object
+ *	@dsk_nr: disk number within this driver (e.g. 0->/dev/sda,
+ *	1->/dev/sdb, etc)
+ *
+ *	Note: this function is local to this driver.
+ **/
+static void
+sd_init_onedisk(Scsi_Disk * sdkp, int dsk_nr) {
+	char diskname[40];
+	unsigned char *buffer;
+	Scsi_Device *sdp;
+	Scsi_Request *SRpnt;
+
+	SCSI_LOG_HLQUEUE(3, printk("sd_init_onedisk: dsk_nr=%d\n", dsk_nr));
 
 	/*
-	 * Unless otherwise specified, this is not write protected.
+	 * Get the name of the disk, in case we need to log it somewhere.
 	 */
-	sdkp->write_prot = 0;
-	if (sdp->removable && sdkp->ready) {
-		/* FLOPTICAL */
+	sd_dskname(dsk_nr, diskname);
 
-		/*
-		 * For removable scsi disk ( FLOPTICAL ) we have to recognise
-		 * the Write Protect Flag. This flag is kept in the Scsi_Disk
-		 * struct and tested at open !
-		 * Daniel Roche ( dan@lectra.fr )
-		 *
-		 * Changed to get all pages (0x3f) rather than page 1 to
-		 * get around devices which do not have a page 1.  Since
-		 * we're only interested in the header anyway, this should
-		 * be fine.
-		 *   -- Matthew Dharm (mdharm-scsi@one-eyed-alien.net)
-		 *
-		 * As it turns out, some devices return an error for
-		 * every MODE_SENSE request except one for page 0.
-		 * So, we should also try that. --aeb
-		 */
+	/*
+	 * If the device is offline, don't try and read capacity or any
+	 * of the other niceties.
+	 */
+	sdp = sdkp->device;
+	if (sdp->online == FALSE)
+		return;
 
-		memset((void *) &cmd[0], 0, 8);
-		cmd[0] = MODE_SENSE;
-		cmd[1] = (sdp->scsi_level <= SCSI_2) ?
-			 ((sdp->lun << 5) & 0xe0) : 0;
-		cmd[2] = 0x3f;	/* Get all pages */
-		cmd[4] = 255;   /* Ask for 255 bytes, even tho we want just the first 8 */
-		SRpnt->sr_cmd_len = 0;
-		SRpnt->sr_sense_buffer[0] = 0;
-		SRpnt->sr_sense_buffer[2] = 0;
+	SRpnt = scsi_allocate_request(sdp);
+	if (!SRpnt) {
+		printk(KERN_WARNING "(sd_init_onedisk:) Request allocation "
+		       "failure.\n");
+		return;
+	}
 
-		/* same code as READCAPA !! */
-		SRpnt->sr_data_direction = SCSI_DATA_READ;
-		scsi_wait_req(SRpnt, (void *) cmd, (void *) buffer,
-			    512, SD_TIMEOUT, MAX_RETRIES);
+	buffer = kmalloc(512, GFP_DMA);
+	if (!buffer) {
+		printk(KERN_WARNING "(sd_init_onedisk:) Memory allocation "
+		       "failure.\n");
+		goto leave;
+	}
 
-		the_result = SRpnt->sr_result;
+	/* defaults, until the device tells us otherwise */
+	sdkp->capacity = 0;
+	sdkp->device->sector_size = 512;
+	sdkp->media_present = 1;
+	sdkp->write_prot = 0;
 
-		if (the_result) {
-			printk("%s: test WP failed, assume Write Enabled\n",
-			       nbuff);
-			/* alternatively, try page 0 */
-		} else {
-			sdkp->write_prot = ((buffer[2] & 0x80) != 0);
-			printk(KERN_NOTICE "%s: Write Protect is %s\n", nbuff,
-			       sdkp->write_prot ? "on" : "off");
-		}
+	sd_spinup_disk(sdkp, diskname, SRpnt, buffer);
+
+	if (sdkp->media_present)
+		sd_read_capacity(sdkp, diskname, SRpnt, buffer);
+
+	if (sdp->removable && sdkp->media_present)
+		sd_read_write_protect_flag(sdkp, diskname, SRpnt, buffer);
 
-	}			/* check for write protect */
 	SRpnt->sr_device->ten = 1;
 	SRpnt->sr_device->remap = 1;
-	SRpnt->sr_device->sector_size = sector_size;
-	/* Wake up a process waiting for device */
+
+ leave:
 	scsi_release_request(SRpnt);
-	SRpnt = NULL;
 
 	kfree(buffer);
-	return dsk_nr;
 }
 
 /*
@@ -1275,18 +1304,15 @@
 		vfree(sd_gendisks[k].flags);
 	}
 cleanup_mem:
-	if (sd_gendisks) vfree(sd_gendisks);
+	vfree(sd_gendisks);
 	sd_gendisks = NULL;
-	if (sd) vfree(sd);
+	vfree(sd);
 	sd = NULL;
-	if (sd_sizes) vfree(sd_sizes);
+	vfree(sd_sizes);
 	sd_sizes = NULL;
 	if (sd_dsk_arr) {
-                for (k = 0; k < sd_template.dev_max; ++k) {
-			sdkp = sd_dsk_arr[k];
-			if (sdkp)
-				vfree(sdkp);
-		}
+                for (k = 0; k < sd_template.dev_max; ++k)
+			vfree(sd_dsk_arr[k]);
 		vfree(sd_dsk_arr);
 		sd_dsk_arr = NULL;
 	}
@@ -1321,12 +1347,12 @@
 		sdkp = sd_get_sdisk(k);
 		if (sdkp && (0 == sdkp->capacity) && sdkp->device) {
 			sd_init_onedisk(sdkp, k);
-			if (!sdkp->has_part_table) {
+			if (!sdkp->has_been_registered) {
 				sd_sizes[k << 4] = sdkp->capacity;
 				register_disk(&SD_GENDISK(k), MKDEV_SD(k),
 						1<<4, &sd_fops,
 						sdkp->capacity);
-				sdkp->has_part_table = 1;
+				sdkp->has_been_registered = 1;
 			}
 		}
 	}
@@ -1372,7 +1398,7 @@
         unsigned int devnum;
 	Scsi_Disk *sdkp;
 	int dsk_nr;
-	char nbuff[6];
+	char diskname[6];
 	unsigned long iflags;
 
 	if ((NULL == sdp) ||
@@ -1393,8 +1419,8 @@
 	for (dsk_nr = 0; dsk_nr < sd_template.dev_max; dsk_nr++) {
 		sdkp = sd_dsk_arr[dsk_nr];
 		if (!sdkp->device) {
+			memset(sdkp, 0, sizeof(Scsi_Disk));
 			sdkp->device = sdp;
-			sdkp->has_part_table = 0;
 			break;
 		}
 	}
@@ -1412,10 +1438,10 @@
         SD_GENDISK(dsk_nr).de_arr[devnum] = sdp->de;
         if (sdp->removable)
 		SD_GENDISK(dsk_nr).flags[devnum] |= GENHD_FL_REMOVABLE;
-	sd_dskname(dsk_nr, nbuff);
+	sd_dskname(dsk_nr, diskname);
 	printk(KERN_NOTICE "Attached scsi %sdisk %s at scsi%d, channel %d, "
 	       "id %d, lun %d\n", sdp->removable ? "removable " : "",
-	       nbuff, sdp->host->host_no, sdp->channel, sdp->id, sdp->lun);
+	       diskname, sdp->host->host_no, sdp->channel, sdp->id, sdp->lun);
 	return 0;
 }
 
@@ -1436,8 +1462,8 @@
 	Scsi_Disk * sdkp;
 	Scsi_Device * sdp;
 
-	 SCSI_LOG_HLQUEUE(3, printk("revalidate_scsidisk: dsk_nr=%d\n", 
-			     DEVICE_NR(dev)));
+	SCSI_LOG_HLQUEUE(3, printk("revalidate_scsidisk: dsk_nr=%d\n", 
+				   DEVICE_NR(dev)));
 	sdkp = sd_get_sdisk(dsk_nr);
 	if ((NULL == sdkp) || (NULL == (sdp = sdkp->device)))
 		return -ENODEV;
@@ -1457,6 +1483,7 @@
 	sd_init_onedisk(sdkp, dsk_nr);
 
 	grok_partitions(dev, sdkp->capacity);
+
 leave:
 	sdp->busy = 0;
 	return res;
@@ -1494,7 +1521,7 @@
 	for (dsk_nr = 0; dsk_nr < sd_template.dev_max; dsk_nr++) {
 		sdkp = sd_dsk_arr[dsk_nr];
 		if (sdkp->device == sdp) {
-			sdkp->has_part_table = 0;
+			sdkp->has_been_registered = 0;
 			sdkp->device = NULL;
 			sdkp->capacity = 0;
 			/* sdkp->detaching = 1; */
diff -u --recursive --new-file andries/drivers/scsi/sd.h brouwer/drivers/scsi/sd.h
--- andries/drivers/scsi/sd.h	Sun Jun  9 07:30:31 2002
+++ brouwer/drivers/scsi/sd.h	Mon Jun 10 10:00:21 2002
@@ -11,9 +11,6 @@
  */
 #ifndef _SD_H
 #define _SD_H
-/*
-   $Header: /usr/src/linux/kernel/blk_drv/scsi/RCS/sd.h,v 1.1 1992/07/24 06:27:38 root Exp root $
- */
 
 #ifndef _SCSI_H
 #include "scsi.h"
@@ -26,13 +23,11 @@
 extern struct hd_struct *sd;
 
 typedef struct scsi_disk {
-	unsigned capacity;	/* size in blocks */
+	unsigned capacity;		/* size in 512-byte sectors */
 	Scsi_Device *device;
-	unsigned char ready;	/* flag ready for FLOPTICAL */
-	unsigned char write_prot;	/* flag write_protect for rmvable dev */
-	unsigned char sector_bit_size;	/* sector_size = 2 to the  bit size power */
-	unsigned char sector_bit_shift;		/* power of 2 sectors per FS block */
-	unsigned has_part_table:1;	/* has partition table */
+	unsigned char media_present;
+	unsigned char write_prot;
+	unsigned has_been_registered:1;
 } Scsi_Disk;
 
 extern int revalidate_scsidisk(kdev_t dev, int maxusage);
@@ -48,22 +43,3 @@
 #define SD_PARTITION(i)		(((major(i) & SD_MAJOR_MASK) << 8) | (minor(i) & 255))
 
 #endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 4
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -4
- * c-argdecl-indent: 4
- * c-label-offset: -4
- * c-continued-statement-offset: 4
- * c-continued-brace-offset: 0
- * indent-tabs-mode: nil
- * tab-width: 8
- * End:
- */
diff -u --recursive --new-file andries/drivers/scsi/sr.h brouwer/drivers/scsi/sr.h
--- andries/drivers/scsi/sr.h	Sun Jun  9 07:28:56 2002
+++ brouwer/drivers/scsi/sr.h	Sun Jun  9 15:40:26 2002
@@ -24,8 +24,6 @@
 	Scsi_Device *device;
 	unsigned int vendor;	/* vendor code, see sr_vendor.c         */
 	unsigned long ms_offset;	/* for reading multisession-CD's        */
-	unsigned char sector_bit_size;	/* sector size = 2^sector_bit_size      */
-	unsigned char sector_bit_shift;		/* sectors/FS block = 2^sector_bit_shift */
 	unsigned needs_sector_size:1;	/* needs to get sector size */
 	unsigned use:1;		/* is this device still supportable     */
 	unsigned xa_flag:1;	/* CD has XA sectors ? */
diff -u --recursive --new-file andries/fs/partitions/check.c brouwer/fs/partitions/check.c
--- andries/fs/partitions/check.c	Sun Jun  9 07:28:55 2002
+++ brouwer/fs/partitions/check.c	Mon Jun 10 10:19:44 2002
@@ -412,8 +412,8 @@
 
 	g->part[first_minor].nr_sects = size;
 
-	/* No such device or no minors to use for partitions */
-	if (!size || minors == 1)
+	/* No minors to use for partitions */
+	if (minors == 1)
 		return;
 
 	if (g->sizes) {
@@ -422,6 +422,11 @@
 			g->sizes[i] = 0;
 	}
 	blk_size[g->major] = g->sizes;
+
+	/* No such device (e.g., media were just removed) */
+	if (!size)
+		return;
+
 	check_partition(g, mk_kdev(g->major, first_minor), 1 + first_minor);
 
  	/*
diff -u --recursive --new-file andries/include/scsi/scsi.h brouwer/include/scsi/scsi.h
--- andries/include/scsi/scsi.h	Sun Jun  9 07:31:29 2002
+++ brouwer/include/scsi/scsi.h	Mon Jun 10 00:34:54 2002
@@ -223,23 +223,4 @@
 /* Used to get the PCI location of a device */
 #define SCSI_IOCTL_GET_PCI 0x5387
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 4 
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -4
- * c-argdecl-indent: 4
- * c-label-offset: -4
- * c-continued-statement-offset: 4
- * c-continued-brace-offset: 0
- * indent-tabs-mode: nil
- * tab-width: 8
- * End:
- */
-
 #endif
