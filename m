Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310428AbSCGRsR>; Thu, 7 Mar 2002 12:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310429AbSCGRsN>; Thu, 7 Mar 2002 12:48:13 -0500
Received: from ns.caldera.de ([212.34.180.1]:12725 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S310428AbSCGRr7>;
	Thu, 7 Mar 2002 12:47:59 -0500
Date: Thu, 7 Mar 2002 18:47:45 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] SCSI cdrom cleanup
Message-ID: <20020307184745.A11790@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

the appended patch is one of the very early steps on cleaning
up the SCSI cdrom driver.  This gets rid of directly accessing
the scsi_CDs array in favour of using the handle we get from
the generic cdrom layer.  Also uses local vars instead of many
grouped scsi_CDs accesses in other places.

The gain is to get rid of the global, static array of CDROMS
in the end.

Please apply,

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.

diff -uNr -Xdontdiff ../master/linux-2.5.6-pre3/drivers/scsi/sr.c linux/drivers/scsi/sr.c
--- ../master/linux-2.5.6-pre3/drivers/scsi/sr.c	Thu Mar  7 18:23:42 2002
+++ linux/drivers/scsi/sr.c	Thu Mar  7 18:31:35 2002
@@ -99,11 +99,13 @@
 
 static void sr_release(struct cdrom_device_info *cdi)
 {
-	if (scsi_CDs[minor(cdi->dev)].device->sector_size > 2048)
+	Scsi_CD *SCp = cdi->handle;
+
+	if (SCp->device->sector_size > 2048)
 		sr_set_blocklength(minor(cdi->dev), 2048);
-	scsi_CDs[minor(cdi->dev)].device->access_count--;
-	if (scsi_CDs[minor(cdi->dev)].device->host->hostt->module)
-		__MOD_DEC_USE_COUNT(scsi_CDs[minor(cdi->dev)].device->host->hostt->module);
+	SCp->device->access_count--;
+	if (SCp->device->host->hostt->module)
+		__MOD_DEC_USE_COUNT(SCp->device->host->hostt->module);
 	if (sr_template.module)
 		__MOD_DEC_USE_COUNT(sr_template.module);
 }
@@ -144,28 +146,27 @@
 
 int sr_media_change(struct cdrom_device_info *cdi, int slot)
 {
+	Scsi_CD *SCp = cdi->handle;
 	int retval;
 
 	if (CDSL_CURRENT != slot) {
 		/* no changer support */
 		return -EINVAL;
 	}
-	retval = scsi_ioctl(scsi_CDs[minor(cdi->dev)].device,
-			    SCSI_IOCTL_TEST_UNIT_READY, 0);
 
+	retval = scsi_ioctl(SCp->device, SCSI_IOCTL_TEST_UNIT_READY, 0);
 	if (retval) {
 		/* Unable to test, unit probably not ready.  This usually
 		 * means there is no disc in the drive.  Mark as changed,
 		 * and we will figure it out later once the drive is
 		 * available again.  */
-
-		scsi_CDs[minor(cdi->dev)].device->changed = 1;
+		SCp->device->changed = 1;
 		return 1;	/* This will force a flush, if called from
 				 * check_disk_change */
 	};
 
-	retval = scsi_CDs[minor(cdi->dev)].device->changed;
-	scsi_CDs[minor(cdi->dev)].device->changed = 0;
+	retval = SCp->device->changed;
+	SCp->device->changed = 0;
 	/* If the disk changed, the capacity will now be different,
 	 * so we force a re-read of this information */
 	if (retval) {
@@ -179,9 +180,8 @@
 		 * be trying to use something that is too small if the disc
 		 * has changed.
 		 */
-		scsi_CDs[minor(cdi->dev)].needs_sector_size = 1;
-
-		scsi_CDs[minor(cdi->dev)].device->sector_size = 2048;
+		SCp->needs_sector_size = 1;
+		SCp->device->sector_size = 2048;
 	}
 	return retval;
 }
@@ -198,6 +198,7 @@
 	int good_sectors = (result == 0 ? this_count : 0);
 	int block_sectors = 0;
 	int device_nr = DEVICE_NR(SCpnt->request.rq_dev);
+	Scsi_CD *SCp = &scsi_CDs[device_nr];
 
 #ifdef DEBUG
 	printk("sr.c done: %x %p\n", result, SCpnt->request.bh->b_data);
@@ -222,7 +224,7 @@
 			block_sectors = bio_sectors(SCpnt->request.bio);
 		if (block_sectors < 4)
 			block_sectors = 4;
-		if (scsi_CDs[device_nr].device->sector_size == 2048)
+		if (SCp->device->sector_size == 2048)
 			error_sector <<= 2;
 		error_sector &= ~(block_sectors - 1);
 		good_sectors = error_sector - SCpnt->request.sector;
@@ -235,7 +237,7 @@
 		 * 75 2K sectors, we decrease the saved size value.
 		 */
 		if ((error_sector >> 1) < sr_sizes[device_nr] &&
-		    scsi_CDs[device_nr].capacity - error_sector < 4 * 75)
+		    SCp->capacity - error_sector < 4 * 75)
 			sr_sizes[device_nr] = error_sector >> 1;
 	}
 
@@ -250,32 +252,34 @@
 
 static request_queue_t *sr_find_queue(kdev_t dev)
 {
-	/*
-	 * No such device
-	 */
-	if (minor(dev) >= sr_template.dev_max || !scsi_CDs[minor(dev)].device)
-		return NULL;
+	Scsi_CD *SCp;
 
-	return &scsi_CDs[minor(dev)].device->request_queue;
+	if (minor(dev) >= sr_template.dev_max)
+		return NULL;
+	SCp = &scsi_CDs[minor(dev)];
+	if (!SCp->device)
+		return NULL;
+	return &SCp->device->request_queue;
 }
 
 static int sr_init_command(Scsi_Cmnd * SCpnt)
 {
 	int dev, devm, block=0, this_count, s_size;
+	Scsi_CD *SCp;
 
 	devm = minor(SCpnt->request.rq_dev);
 	dev = DEVICE_NR(SCpnt->request.rq_dev);
+	SCp = &scsi_CDs[dev];
 
 	SCSI_LOG_HLQUEUE(1, printk("Doing sr request, dev = %d, block = %d\n", devm, block));
 
-	if (dev >= sr_template.nr_dev ||
-	    !scsi_CDs[dev].device ||
-	    !scsi_CDs[dev].device->online) {
+	if (dev >= sr_template.nr_dev || !SCp->device || !SCp->device->online) {
 		SCSI_LOG_HLQUEUE(2, printk("Finishing %ld sectors\n", SCpnt->request.nr_sectors));
 		SCSI_LOG_HLQUEUE(2, printk("Retry with 0x%p\n", SCpnt));
 		return 0;
 	}
-	if (scsi_CDs[dev].device->changed) {
+
+	if (SCp->device->changed) {
 		/*
 		 * quietly refuse to do anything to a changed disc until the
 		 * changed bit has been reset
@@ -292,7 +296,7 @@
 	 * we do lazy blocksize switching (when reading XA sectors,
 	 * see CDROMREADMODE2 ioctl) 
 	 */
-	s_size = scsi_CDs[dev].device->sector_size;
+	s_size = SCp->device->sector_size;
 	if (s_size > 2048) {
 		if (!in_interrupt())
 			sr_set_blocklength(DEVICE_NR(CURRENT->rq_dev), 2048);
@@ -306,7 +310,7 @@
 	}
 
 	if (rq_data_dir(&SCpnt->request) == WRITE) {
-		if (!scsi_CDs[dev].device->writeable)
+		if (!SCp->device->writeable)
 			return 0;
 		SCpnt->cmnd[0] = WRITE_10;
 		SCpnt->sc_data_direction = SCSI_DATA_WRITE;
@@ -355,7 +359,7 @@
 	 * host adapter, it's safe to assume that we can at least transfer
 	 * this many bytes between each connect / disconnect.
 	 */
-	SCpnt->transfersize = scsi_CDs[dev].device->sector_size;
+	SCpnt->transfersize = SCp->device->sector_size;
 	SCpnt->underflow = this_count << 9;
 
 	SCpnt->allowed = MAX_RETRIES;
@@ -397,22 +401,23 @@
 
 static int sr_open(struct cdrom_device_info *cdi, int purpose)
 {
+	Scsi_CD *SCp = cdi->handle;
+
 	check_disk_change(cdi->dev);
 
-	if (minor(cdi->dev) >= sr_template.dev_max
-	    || !scsi_CDs[minor(cdi->dev)].device) {
+	if (minor(cdi->dev) >= sr_template.dev_max || !SCp->device) {
 		return -ENXIO;	/* No such device */
 	}
 	/*
 	 * If the device is in error recovery, wait until it is done.
 	 * If the device is offline, then disallow any access to it.
 	 */
-	if (!scsi_block_when_processing_errors(scsi_CDs[minor(cdi->dev)].device)) {
+	if (!scsi_block_when_processing_errors(SCp->device)) {
 		return -ENXIO;
 	}
-	scsi_CDs[minor(cdi->dev)].device->access_count++;
-	if (scsi_CDs[minor(cdi->dev)].device->host->hostt->module)
-		__MOD_INC_USE_COUNT(scsi_CDs[minor(cdi->dev)].device->host->hostt->module);
+	SCp->device->access_count++;
+	if (SCp->device->host->hostt->module)
+		__MOD_INC_USE_COUNT(SCp->device->host->hostt->module);
 	if (sr_template.module)
 		__MOD_INC_USE_COUNT(sr_template.module);
 
@@ -421,7 +426,7 @@
 	 * this is the case, and try again.
 	 */
 
-	if (scsi_CDs[minor(cdi->dev)].needs_sector_size)
+	if (SCp->needs_sector_size)
 		get_sectorsize(minor(cdi->dev));
 
 	return 0;
@@ -472,31 +477,25 @@
 {
 	unsigned char cmd[10];
 	unsigned char *buffer;
-	int the_result, retries;
+	int the_result, retries = 3;
 	int sector_size;
-	Scsi_Request *SRpnt;
+	Scsi_Request *SRpnt = NULL;
+	Scsi_CD *SCp;
 	request_queue_t *queue;
 
-	buffer = (unsigned char *) kmalloc(512, GFP_DMA);
-	SRpnt = scsi_allocate_request(scsi_CDs[i].device);
-	
-	if(buffer == NULL || SRpnt == NULL)
-	{
-		scsi_CDs[i].capacity = 0x1fffff;
-		sector_size = 2048;	/* A guess, just in case */
-		scsi_CDs[i].needs_sector_size = 1;
-		if(buffer)
-			kfree(buffer);
-		if(SRpnt)
-			scsi_release_request(SRpnt);
-		return;
-	}	
+	SCp = &scsi_CDs[i];
+
+	buffer = kmalloc(512, GFP_DMA);
+	if (!buffer)
+		goto Enomem;
+	SRpnt = scsi_allocate_request(SCp->device);
+	if (!SRpnt)
+		goto Enomem;
 
-	retries = 3;
 	do {
 		cmd[0] = READ_CAPACITY;
-		cmd[1] = (scsi_CDs[i].device->scsi_level <= SCSI_2) ?
-			 ((scsi_CDs[i].device->lun << 5) & 0xe0) : 0;
+		cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
+			 ((SCp->device->lun << 5) & 0xe0) : 0;
 		memset((void *) &cmd[2], 0, 8);
 		SRpnt->sr_request.rq_status = RQ_SCSI_BUSY;	/* Mark as really busy */
 		SRpnt->sr_cmd_len = 0;
@@ -519,15 +518,15 @@
 	SRpnt = NULL;
 
 	if (the_result) {
-		scsi_CDs[i].capacity = 0x1fffff;
+		SCp->capacity = 0x1fffff;
 		sector_size = 2048;	/* A guess, just in case */
-		scsi_CDs[i].needs_sector_size = 1;
+		SCp->needs_sector_size = 1;
 	} else {
 #if 0
 		if (cdrom_get_last_written(mkdev(MAJOR_NR, i),
 					   &scsi_CDs[i].capacity))
 #endif
-			scsi_CDs[i].capacity = 1 + ((buffer[0] << 24) |
+			SCp->capacity = 1 + ((buffer[0] << 24) |
 						    (buffer[1] << 16) |
 						    (buffer[2] << 8) |
 						    buffer[3]);
@@ -546,33 +545,45 @@
 			sector_size = 2048;
 			/* fall through */
 		case 2048:
-			scsi_CDs[i].capacity *= 4;
+			SCp->capacity *= 4;
 			/* fall through */
 		case 512:
 			break;
 		default:
 			printk("sr%d: unsupported sector size %d.\n",
 			       i, sector_size);
-			scsi_CDs[i].capacity = 0;
-			scsi_CDs[i].needs_sector_size = 1;
+			SCp->capacity = 0;
+			SCp->needs_sector_size = 1;
 		}
 
-		scsi_CDs[i].device->sector_size = sector_size;
+		SCp->device->sector_size = sector_size;
 
 		/*
 		 * Add this so that we have the ability to correctly gauge
 		 * what the device is capable of.
 		 */
-		scsi_CDs[i].needs_sector_size = 0;
-		sr_sizes[i] = scsi_CDs[i].capacity >> (BLOCK_SIZE_BITS - 9);
+		SCp->needs_sector_size = 0;
+		sr_sizes[i] = SCp->capacity >> (BLOCK_SIZE_BITS - 9);
 	}
-	queue = &scsi_CDs[i].device->request_queue;
+
+	queue = &SCp->device->request_queue;
 	blk_queue_hardsect_size(queue, sector_size);
+out:
 	kfree(buffer);
+	return;
+
+Enomem:
+	SCp->capacity = 0x1fffff;
+	sector_size = 2048;	/* A guess, just in case */
+	SCp->needs_sector_size = 1;
+	if (SRpnt)
+		scsi_release_request(SRpnt);
+	goto out;
 }
 
 void get_capabilities(int i)
 {
+	Scsi_CD *SCp;
 	unsigned char cmd[6];
 	unsigned char *buffer;
 	int rc, n;
@@ -589,15 +600,16 @@
 		""
 	};
 
-	buffer = (unsigned char *) kmalloc(512, GFP_DMA);
+	SCp = &scsi_CDs[i];
+	buffer = kmalloc(512, GFP_DMA);
 	if (!buffer)
 	{
 		printk(KERN_ERR "sr: out of memory.\n");
 		return;
 	}
 	cmd[0] = MODE_SENSE;
-	cmd[1] = (scsi_CDs[i].device->scsi_level <= SCSI_2) ?
-		 ((scsi_CDs[i].device->lun << 5) & 0xe0) : 0;
+	cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
+		 ((SCp->device->lun << 5) & 0xe0) : 0;
 	cmd[2] = 0x2a;
 	cmd[4] = 128;
 	cmd[3] = cmd[5] = 0;
@@ -605,8 +617,8 @@
 
 	if (rc) {
 		/* failed, drive doesn't have capabilities mode page */
-		scsi_CDs[i].cdi.speed = 1;
-		scsi_CDs[i].cdi.mask |= (CDC_CD_R | CDC_CD_RW | CDC_DVD_R |
+		SCp->cdi.speed = 1;
+		SCp->cdi.mask |= (CDC_CD_R | CDC_CD_RW | CDC_DVD_R |
 					 CDC_DVD | CDC_DVD_RAM |
 					 CDC_SELECT_DISC | CDC_SELECT_SPEED);
 		kfree(buffer);
@@ -614,13 +626,13 @@
 		return;
 	}
 	n = buffer[3] + 4;
-	scsi_CDs[i].cdi.speed = ((buffer[n + 8] << 8) + buffer[n + 9]) / 176;
-	scsi_CDs[i].readcd_known = 1;
-	scsi_CDs[i].readcd_cdda = buffer[n + 5] & 0x01;
+	SCp->cdi.speed = ((buffer[n + 8] << 8) + buffer[n + 9]) / 176;
+	SCp->readcd_known = 1;
+	SCp->readcd_cdda = buffer[n + 5] & 0x01;
 	/* print some capability bits */
 	printk("sr%i: scsi3-mmc drive: %dx/%dx %s%s%s%s%s%s\n", i,
 	       ((buffer[n + 14] << 8) + buffer[n + 15]) / 176,
-	       scsi_CDs[i].cdi.speed,
+	       SCp->cdi.speed,
 	       buffer[n + 3] & 0x01 ? "writer " : "",	/* CD Writer */
 	       buffer[n + 3] & 0x20 ? "dvd-ram " : "",
 	       buffer[n + 2] & 0x02 ? "cd/rw " : "",	/* can read rewriteable */
@@ -629,38 +641,38 @@
 	       loadmech[buffer[n + 6] >> 5]);
 	if ((buffer[n + 6] >> 5) == 0)
 		/* caddy drives can't close tray... */
-		scsi_CDs[i].cdi.mask |= CDC_CLOSE_TRAY;
+		SCp->cdi.mask |= CDC_CLOSE_TRAY;
 	if ((buffer[n + 2] & 0x8) == 0)
 		/* not a DVD drive */
-		scsi_CDs[i].cdi.mask |= CDC_DVD;
+		SCp->cdi.mask |= CDC_DVD;
 	if ((buffer[n + 3] & 0x20) == 0) {
 		/* can't write DVD-RAM media */
-		scsi_CDs[i].cdi.mask |= CDC_DVD_RAM;
+		SCp->cdi.mask |= CDC_DVD_RAM;
 	} else {
-		scsi_CDs[i].device->writeable = 1;
+		SCp->device->writeable = 1;
 	}
 	if ((buffer[n + 3] & 0x10) == 0)
 		/* can't write DVD-R media */
-		scsi_CDs[i].cdi.mask |= CDC_DVD_R;
+		SCp->cdi.mask |= CDC_DVD_R;
 	if ((buffer[n + 3] & 0x2) == 0)
 		/* can't write CD-RW media */
-		scsi_CDs[i].cdi.mask |= CDC_CD_RW;
+		SCp->cdi.mask |= CDC_CD_RW;
 	if ((buffer[n + 3] & 0x1) == 0)
 		/* can't write CD-R media */
-		scsi_CDs[i].cdi.mask |= CDC_CD_R;
+		SCp->cdi.mask |= CDC_CD_R;
 	if ((buffer[n + 6] & 0x8) == 0)
 		/* can't eject */
-		scsi_CDs[i].cdi.mask |= CDC_OPEN_TRAY;
+		SCp->cdi.mask |= CDC_OPEN_TRAY;
 
 	if ((buffer[n + 6] >> 5) == mechtype_individual_changer ||
 	    (buffer[n + 6] >> 5) == mechtype_cartridge_changer)
-		scsi_CDs[i].cdi.capacity =
-		    cdrom_number_of_slots(&(scsi_CDs[i].cdi));
-	if (scsi_CDs[i].cdi.capacity <= 1)
+		SCp->cdi.capacity =
+		    cdrom_number_of_slots(&SCp->cdi);
+	if (SCp->cdi.capacity <= 1)
 		/* not a changer */
-		scsi_CDs[i].cdi.mask |= CDC_SELECT_DISC;
+		SCp->cdi.mask |= CDC_SELECT_DISC;
 	/*else    I don't think it can close its tray
-	   scsi_CDs[i].cdi.mask |= CDC_CLOSE_TRAY; */
+		SCp->cdi.mask |= CDC_CLOSE_TRAY; */
 
 	kfree(buffer);
 }
@@ -671,8 +683,9 @@
  */
 static int sr_packet(struct cdrom_device_info *cdi, struct cdrom_generic_command *cgc)
 {
-	Scsi_Device *device = scsi_CDs[minor(cdi->dev)].device;
-
+	Scsi_CD *SCp = cdi->handle;
+	Scsi_Device *device = SCp->device;
+	
 	/* set the LUN */
 	if (device->scsi_level <= SCSI_2)
 		cgc->cmd[1] |= device->lun << 5;
@@ -743,47 +756,47 @@
 	blk_size[MAJOR_NR] = sr_sizes;
 
 	for (i = 0; i < sr_template.nr_dev; ++i) {
+		Scsi_CD *SCp = &scsi_CDs[i];
 		/* If we have already seen this, then skip it.  Comes up
 		 * with loadable modules. */
-		if (scsi_CDs[i].capacity)
+		if (SCp->capacity)
 			continue;
-		scsi_CDs[i].capacity = 0x1fffff;
-		scsi_CDs[i].device->sector_size = 2048;		/* A guess, just in case */
-		scsi_CDs[i].needs_sector_size = 1;
-		scsi_CDs[i].device->changed = 1;	/* force recheck CD type */
+		SCp->capacity = 0x1fffff;
+		SCp->device->sector_size = 2048;/* A guess, just in case */
+		SCp->needs_sector_size = 1;
+		SCp->device->changed = 1;	/* force recheck CD type */
 #if 0
 		/* seems better to leave this for later */
 		get_sectorsize(i);
-		printk("Scd sectorsize = %d bytes.\n", scsi_CDs[i].sector_size);
+		printk("Scd sectorsize = %d bytes.\n", SCp->sector_size);
 #endif
-		scsi_CDs[i].use = 1;
+		SCp->use = 1;
 
-		scsi_CDs[i].device->ten = 1;
-		scsi_CDs[i].device->remap = 1;
-		scsi_CDs[i].readcd_known = 0;
-		scsi_CDs[i].readcd_cdda = 0;
-		sr_sizes[i] = scsi_CDs[i].capacity >> (BLOCK_SIZE_BITS - 9);
-
-		scsi_CDs[i].cdi.ops = &sr_dops;
-		scsi_CDs[i].cdi.handle = &scsi_CDs[i];
-		scsi_CDs[i].cdi.dev = mk_kdev(MAJOR_NR, i);
-		scsi_CDs[i].cdi.mask = 0;
-		scsi_CDs[i].cdi.capacity = 1;
+		SCp->device->ten = 1;
+		SCp->device->remap = 1;
+		SCp->readcd_known = 0;
+		SCp->readcd_cdda = 0;
+		sr_sizes[i] = SCp->capacity >> (BLOCK_SIZE_BITS - 9);
+
+		SCp->cdi.ops = &sr_dops;
+		SCp->cdi.handle = SCp;
+		SCp->cdi.dev = mk_kdev(MAJOR_NR, i);
+		SCp->cdi.mask = 0;
+		SCp->cdi.capacity = 1;
 		/*
 		 *	FIXME: someone needs to handle a get_capabilities
 		 *	failure properly ??
 		 */
 		get_capabilities(i);
-		sr_vendor_init(i);
+		sr_vendor_init(SCp);
 
 		sprintf(name, "sr%d", i);
-		strcpy(scsi_CDs[i].cdi.name, name);
-                scsi_CDs[i].cdi.de =
-                    devfs_register (scsi_CDs[i].device->de, "cd",
+		strcpy(SCp->cdi.name, name);
+                SCp->cdi.de = devfs_register(SCp->device->de, "cd",
                                     DEVFS_FL_DEFAULT, MAJOR_NR, i,
                                     S_IFBLK | S_IRUGO | S_IWUGO,
                                     &sr_bdops, NULL);
-		register_cdrom(&scsi_CDs[i].cdi);
+		register_cdrom(&SCp->cdi);
 	}
 }
 
diff -uNr -Xdontdiff ../master/linux-2.5.6-pre3/drivers/scsi/sr.h linux/drivers/scsi/sr.h
--- ../master/linux-2.5.6-pre3/drivers/scsi/sr.h	Fri Jul 20 06:18:31 2001
+++ linux/drivers/scsi/sr.h	Thu Mar  7 18:30:21 2002
@@ -53,7 +59,7 @@
 int sr_is_xa(int minor);
 
 /* sr_vendor.c */
-void sr_vendor_init(int minor);
+void sr_vendor_init(Scsi_CD *);
 int sr_cd_check(struct cdrom_device_info *);
 int sr_set_blocklength(int minor, int blocklength);
 
diff -uNr -Xdontdiff ../master/linux-2.5.6-pre3/drivers/scsi/sr_ioctl.c linux/drivers/scsi/sr_ioctl.c
--- ../master/linux-2.5.6-pre3/drivers/scsi/sr_ioctl.c	Thu Mar  7 18:23:59 2002
+++ linux/drivers/scsi/sr_ioctl.c	Thu Mar  7 18:32:49 2002
@@ -83,8 +83,8 @@
 	int result, err = 0, retries = 0;
 	char *bounce_buffer;
 
-	SDev = scsi_CDs[target].device;
-	SRpnt = scsi_allocate_request(scsi_CDs[target].device);
+	SDev = scsi_CDs[target].device;
+	SRpnt = scsi_allocate_request(SDev);
         if (!SRpnt) {
                 printk("Unable to allocate SCSI request in sr_do_ioctl");
                 return -ENOMEM;
@@ -124,7 +124,7 @@
 	if (driver_byte(result) != 0) {
 		switch (SRpnt->sr_sense_buffer[2] & 0xf) {
 		case UNIT_ATTENTION:
-			scsi_CDs[target].device->changed = 1;
+			SDev->changed = 1;
 			if (!quiet)
 				printk(KERN_INFO "sr%d: disc change detected.\n", target);
 			if (retries++ < 10)
@@ -192,22 +192,25 @@
 
 static int test_unit_ready(int minor)
 {
+	Scsi_CD *SCp;
 	u_char sr_cmd[10];
 
+	SCp = &scsi_CDs[minor];
 	sr_cmd[0] = GPCMD_TEST_UNIT_READY;
-	sr_cmd[1] = (scsi_CDs[minor].device->scsi_level <= SCSI_2) ?
-	            ((scsi_CDs[minor].device->lun) << 5) : 0;
+	sr_cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
+	            ((SCp->device->lun) << 5) : 0;
 	sr_cmd[2] = sr_cmd[3] = sr_cmd[4] = sr_cmd[5] = 0;
 	return sr_do_ioctl(minor, sr_cmd, NULL, 0, 1, SCSI_DATA_NONE, NULL);
 }
 
 int sr_tray_move(struct cdrom_device_info *cdi, int pos)
 {
+	Scsi_CD *SCp = cdi->handle;
 	u_char sr_cmd[10];
 
 	sr_cmd[0] = GPCMD_START_STOP_UNIT;
-	sr_cmd[1] = (scsi_CDs[minor(cdi->dev)].device->scsi_level <= SCSI_2) ?
-	            ((scsi_CDs[minor(cdi->dev)].device->lun) << 5) : 0;
+	sr_cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
+	            ((SCp->device->lun) << 5) : 0;
 	sr_cmd[2] = sr_cmd[3] = sr_cmd[5] = 0;
 	sr_cmd[4] = (pos == 0) ? 0x03 /* close */ : 0x02 /* eject */ ;
 
@@ -216,9 +219,10 @@
 
 int sr_lock_door(struct cdrom_device_info *cdi, int lock)
 {
-	return scsi_ioctl(scsi_CDs[minor(cdi->dev)].device,
-		      lock ? SCSI_IOCTL_DOORLOCK : SCSI_IOCTL_DOORUNLOCK,
-			  0);
+	Scsi_CD *SCp = cdi->handle;
+
+	return scsi_ioctl(SCp->device, lock ? SCSI_IOCTL_DOORLOCK :
+			SCSI_IOCTL_DOORUNLOCK, 0);
 }
 
 int sr_drive_status(struct cdrom_device_info *cdi, int slot)
@@ -235,6 +239,7 @@
 
 int sr_disk_status(struct cdrom_device_info *cdi)
 {
+	Scsi_CD *SCp = cdi->handle;
 	struct cdrom_tochdr toc_h;
 	struct cdrom_tocentry toc_e;
 	int i, rc, have_datatracks = 0;
@@ -256,7 +261,7 @@
 	if (!have_datatracks)
 		return CDS_AUDIO;
 
-	if (scsi_CDs[minor(cdi->dev)].xa_flag)
+	if (SCp->xa_flag)
 		return CDS_XA_2_1;
 	else
 		return CDS_DATA_1;
@@ -265,22 +270,24 @@
 int sr_get_last_session(struct cdrom_device_info *cdi,
 			struct cdrom_multisession *ms_info)
 {
-	ms_info->addr.lba = scsi_CDs[minor(cdi->dev)].ms_offset;
-	ms_info->xa_flag = scsi_CDs[minor(cdi->dev)].xa_flag ||
-	    (scsi_CDs[minor(cdi->dev)].ms_offset > 0);
+	Scsi_CD *SCp = cdi->handle;
+
+	ms_info->addr.lba = SCp->ms_offset;
+	ms_info->xa_flag = SCp->xa_flag || SCp->ms_offset > 0;
 
 	return 0;
 }
 
 int sr_get_mcn(struct cdrom_device_info *cdi, struct cdrom_mcn *mcn)
 {
+	Scsi_CD *SCp = cdi->handle;
 	u_char sr_cmd[10];
 	char buffer[32];
 	int result;
 
 	sr_cmd[0] = GPCMD_READ_SUBCHANNEL;
-	sr_cmd[1] = (scsi_CDs[minor(cdi->dev)].device->scsi_level <= SCSI_2) ?
-	            ((scsi_CDs[minor(cdi->dev)].device->lun) << 5) : 0;
+	sr_cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
+	            ((SCp->device->lun) << 5) : 0;
 	sr_cmd[2] = 0x40;	/* I do want the subchannel info */
 	sr_cmd[3] = 0x02;	/* Give me medium catalog number info */
 	sr_cmd[4] = sr_cmd[5] = 0;
@@ -305,6 +312,7 @@
 
 int sr_select_speed(struct cdrom_device_info *cdi, int speed)
 {
+	Scsi_CD *SCp = cdi->handle;
 	u_char sr_cmd[MAX_COMMAND_SIZE];
 
 	if (speed == 0)
@@ -314,8 +322,8 @@
 
 	memset(sr_cmd, 0, MAX_COMMAND_SIZE);
 	sr_cmd[0] = GPCMD_SET_SPEED;	/* SET CD SPEED */
-	sr_cmd[1] = (scsi_CDs[minor(cdi->dev)].device->scsi_level <= SCSI_2) ?
-	            ((scsi_CDs[minor(cdi->dev)].device->lun) << 5) : 0;
+	sr_cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
+	            ((SCp->device->lun) << 5) : 0;
 	sr_cmd[2] = (speed >> 8) & 0xff;	/* MSB for speed (in kbytes/sec) */
 	sr_cmd[3] = speed & 0xff;	/* LSB */
 
@@ -332,6 +340,7 @@
 
 int sr_audio_ioctl(struct cdrom_device_info *cdi, unsigned int cmd, void *arg)
 {
+	Scsi_CD *SCp = cdi->handle;
 	u_char sr_cmd[10];
 	int result, target = minor(cdi->dev);
 	unsigned char buffer[32];
@@ -344,8 +353,8 @@
 			struct cdrom_tochdr *tochdr = (struct cdrom_tochdr *) arg;
 
 			sr_cmd[0] = GPCMD_READ_TOC_PMA_ATIP;
-			sr_cmd[1] = (scsi_CDs[target].device->scsi_level <= SCSI_2) ?
-			            ((scsi_CDs[target].device->lun) << 5) : 0;
+			sr_cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
+			            ((SCp->device->lun) << 5) : 0;
 			sr_cmd[2] = sr_cmd[3] = sr_cmd[4] = sr_cmd[5] = 0;
 			sr_cmd[8] = 12;		/* LSB of length */
 
@@ -362,8 +371,8 @@
 			struct cdrom_tocentry *tocentry = (struct cdrom_tocentry *) arg;
 
 			sr_cmd[0] = GPCMD_READ_TOC_PMA_ATIP;
-			sr_cmd[1] = (scsi_CDs[target].device->scsi_level <= SCSI_2) ?
-			            ((scsi_CDs[target].device->lun) << 5) : 0;
+			sr_cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
+			            ((SCp->device->lun) << 5) : 0;
 			sr_cmd[1] |= (tocentry->cdte_format == CDROM_MSF) ? 0x02 : 0;
 			sr_cmd[2] = sr_cmd[3] = sr_cmd[4] = sr_cmd[5] = 0;
 			sr_cmd[6] = tocentry->cdte_track;
@@ -389,8 +398,8 @@
 		struct cdrom_ti* ti = (struct cdrom_ti*)arg;
 
 		sr_cmd[0] = GPCMD_PLAYAUDIO_TI;
-		sr_cmd[1] = (scsi_CDs[target].device->scsi_level <= SCSI_2) ?
-		            (scsi_CDs[target].device->lun << 5) : 0;
+		sr_cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
+		            (SCp->device->lun << 5) : 0;
 		sr_cmd[4] = ti->cdti_trk0;
 		sr_cmd[5] = ti->cdti_ind0;
 		sr_cmd[7] = ti->cdti_trk1;
@@ -432,6 +441,7 @@
 int sr_read_cd(int minor, unsigned char *dest, int lba, int format, int blksize)
 {
 	unsigned char cmd[MAX_COMMAND_SIZE];
+	Scsi_CD *SCp = &scsi_CDs[minor];
 
 #ifdef DEBUG
 	printk("sr%d: sr_read_cd lba=%d format=%d blksize=%d\n",
@@ -440,8 +452,8 @@
 
 	memset(cmd, 0, MAX_COMMAND_SIZE);
 	cmd[0] = GPCMD_READ_CD;	/* READ_CD */
-	cmd[1] = (scsi_CDs[minor].device->scsi_level <= SCSI_2) ?
-	         (scsi_CDs[minor].device->lun << 5) : 0;
+	cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
+	         (SCp->device->lun << 5) : 0;
 	cmd[1] |= ((format & 7) << 2);
 	cmd[2] = (unsigned char) (lba >> 24) & 0xff;
 	cmd[3] = (unsigned char) (lba >> 16) & 0xff;
@@ -472,19 +484,20 @@
 int sr_read_sector(int minor, int lba, int blksize, unsigned char *dest)
 {
 	unsigned char cmd[MAX_COMMAND_SIZE];	/* the scsi-command */
+	Scsi_CD *SCp = &scsi_CDs[minor];
 	int rc;
 
 	/* we try the READ CD command first... */
-	if (scsi_CDs[minor].readcd_known) {
+	if (SCp->readcd_known) {
 		rc = sr_read_cd(minor, dest, lba, 0, blksize);
 		if (-EDRIVE_CANT_DO_THIS != rc)
 			return rc;
-		scsi_CDs[minor].readcd_known = 0;
+		SCp->readcd_known = 0;
 		printk("CDROM does'nt support READ CD (0xbe) command\n");
 		/* fall & retry the other way */
 	}
 	/* ... if this fails, we switch the blocksize using MODE SELECT */
-	if (blksize != scsi_CDs[minor].device->sector_size) {
+	if (blksize != SCp->device->sector_size) {
 		if (0 != (rc = sr_set_blocklength(minor, blksize)))
 			return rc;
 	}
@@ -494,8 +509,8 @@
 
 	memset(cmd, 0, MAX_COMMAND_SIZE);
 	cmd[0] = GPCMD_READ_10;
-	cmd[1] = (scsi_CDs[minor].device->scsi_level <= SCSI_2) ?
-	         (scsi_CDs[minor].device->lun << 5) : 0;
+	cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
+	         (SCp->device->lun << 5) : 0;
 	cmd[2] = (unsigned char) (lba >> 24) & 0xff;
 	cmd[3] = (unsigned char) (lba >> 16) & 0xff;
 	cmd[4] = (unsigned char) (lba >> 8) & 0xff;
@@ -514,15 +529,16 @@
 int sr_is_xa(int minor)
 {
 	unsigned char *raw_sector;
+	Scsi_CD *SCp = &scsi_CDs[minor];
 	int is_xa;
 
 	if (!xa_test)
 		return 0;
 
 	raw_sector = (unsigned char *) kmalloc(2048, GFP_DMA | GFP_KERNEL);
 	if (!raw_sector)
 		return -ENOMEM;
-	if (0 == sr_read_sector(minor, scsi_CDs[minor].ms_offset + 16,
+	if (0 == sr_read_sector(minor, SCp->ms_offset + 16,
 				CD_FRAMESIZE_RAW1, raw_sector)) {
 		is_xa = (raw_sector[3] == 0x02) ? 1 : 0;
 	} else {
@@ -539,18 +556,16 @@
 int sr_dev_ioctl(struct cdrom_device_info *cdi,
 		 unsigned int cmd, unsigned long arg)
 {
-	int target;
-
-	target = minor(cdi->dev);
+	Scsi_CD *SCp = cdi->handle;
 
 	switch (cmd) {
 	case BLKGETSIZE:
-		return put_user(scsi_CDs[target].capacity, (unsigned long *) arg);
+		return put_user(SCp->capacity, (unsigned long *) arg);
 	case BLKGETSIZE64:
-		return put_user((u64)scsi_CDs[target].capacity << 9, (u64 *)arg);
+		return put_user((u64)SCp->capacity << 9, (u64 *)arg);
 
 	default:
-		return scsi_ioctl(scsi_CDs[target].device, cmd, (void *) arg);
+		return scsi_ioctl(SCp->device, cmd, (void *)arg);
 	}
 }
 
diff -uNr -Xdontdiff ../master/linux-2.5.6-pre3/drivers/scsi/sr_vendor.c linux/drivers/scsi/sr_vendor.c
--- ../master/linux-2.5.6-pre3/drivers/scsi/sr_vendor.c	Tue Jan 15 10:59:09 2002
+++ linux/drivers/scsi/sr_vendor.c	Thu Mar  7 18:34:09 2002
@@ -58,27 +58,25 @@
 #define VENDOR_TOSHIBA         3
 #define VENDOR_WRITER          4	/* pre-scsi3 writers */
 
-#define VENDOR_ID (scsi_CDs[minor].vendor)
-
-void sr_vendor_init(int minor)
+void sr_vendor_init(Scsi_CD *SCp)
 {
 #ifndef CONFIG_BLK_DEV_SR_VENDOR
-	VENDOR_ID = VENDOR_SCSI3;
+	SCp->vendor = VENDOR_SCSI3;
 #else
-	char *vendor = scsi_CDs[minor].device->vendor;
-	char *model = scsi_CDs[minor].device->model;
-
+	char *vendor = SCp->device->vendor;
+	char *model = SCp->device->model;
+	
 	/* default */
-	VENDOR_ID = VENDOR_SCSI3;
-	if (scsi_CDs[minor].readcd_known)
+	SCp->vendor = VENDOR_SCSI3;
+	if (SCp->readcd_known)
 		/* this is true for scsi3/mmc drives - no more checks */
 		return;
 
-	if (scsi_CDs[minor].device->type == TYPE_WORM) {
-		VENDOR_ID = VENDOR_WRITER;
+	if (SCp->device->type == TYPE_WORM) {
+		SCp->vendor = VENDOR_WRITER;
 
 	} else if (!strncmp(vendor, "NEC", 3)) {
-		VENDOR_ID = VENDOR_NEC;
+		SCp->vendor = VENDOR_NEC;
 		if (!strncmp(model, "CD-ROM DRIVE:25", 15) ||
 		    !strncmp(model, "CD-ROM DRIVE:36", 15) ||
 		    !strncmp(model, "CD-ROM DRIVE:83", 15) ||
@@ -90,10 +88,10 @@
 #endif
 		    )
 			/* these can't handle multisession, may hang */
-			scsi_CDs[minor].cdi.mask |= CDC_MULTI_SESSION;
+			SCp->cdi.mask |= CDC_MULTI_SESSION;
 
 	} else if (!strncmp(vendor, "TOSHIBA", 7)) {
-		VENDOR_ID = VENDOR_TOSHIBA;
+		SCp->vendor = VENDOR_TOSHIBA;
 
 	}
 #endif
@@ -108,10 +106,11 @@
 	unsigned char *buffer;	/* the buffer for the ioctl */
 	unsigned char cmd[MAX_COMMAND_SIZE];	/* the scsi-command */
 	struct ccs_modesel_head *modesel;
+	Scsi_CD *SCp = &scsi_CDs[minor];
 	int rc, density = 0;
 
 #ifdef CONFIG_BLK_DEV_SR_VENDOR
-	if (VENDOR_ID == VENDOR_TOSHIBA)
+	if (SCp->vendor == VENDOR_TOSHIBA)
 		density = (blocklength > 2048) ? 0x81 : 0x83;
 #endif
 
@@ -124,8 +125,8 @@
 #endif
 	memset(cmd, 0, MAX_COMMAND_SIZE);
 	cmd[0] = MODE_SELECT;
-	cmd[1] = (scsi_CDs[minor].device->scsi_level <= SCSI_2) ?
-	         (scsi_CDs[minor].device->lun << 5) : 0;
+	cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
+	         (SCp->device->lun << 5) : 0;
 	cmd[1] |= (1 << 4);
 	cmd[4] = 12;
 	modesel = (struct ccs_modesel_head *) buffer;
@@ -135,7 +136,7 @@
 	modesel->block_length_med = (blocklength >> 8) & 0xff;
 	modesel->block_length_lo = blocklength & 0xff;
 	if (0 == (rc = sr_do_ioctl(minor, cmd, buffer, sizeof(*modesel), 0, SCSI_DATA_WRITE, NULL))) {
-		scsi_CDs[minor].device->sector_size = blocklength;
+		SCp->device->sector_size = blocklength;
 	}
 #ifdef DEBUG
 	else
@@ -153,13 +154,14 @@
 
 int sr_cd_check(struct cdrom_device_info *cdi)
 {
+	Scsi_CD *SCp = cdi->handle;
 	unsigned long sector;
 	unsigned char *buffer;	/* the buffer for the ioctl */
 	unsigned char cmd[MAX_COMMAND_SIZE];	/* the scsi-command */
 	int rc, no_multi, minor;
 
 	minor = minor(cdi->dev);
-	if (scsi_CDs[minor].cdi.mask & CDC_MULTI_SESSION)
+	if (SCp->cdi.mask & CDC_MULTI_SESSION)
 		return 0;
 
 	buffer = (unsigned char *) kmalloc(512, GFP_KERNEL | GFP_DMA);
@@ -170,13 +172,13 @@
 	no_multi = 0;		/* flag: the drive can't handle multisession */
 	rc = 0;
 
-	switch (VENDOR_ID) {
+	switch (SCp->vendor) {
 
 	case VENDOR_SCSI3:
 		memset(cmd, 0, MAX_COMMAND_SIZE);
 		cmd[0] = READ_TOC;
-		cmd[1] = (scsi_CDs[minor].device->scsi_level <= SCSI_2) ?
-		         (scsi_CDs[minor].device->lun << 5) : 0;
+		cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
+		         (SCp->device->lun << 5) : 0;
 		cmd[8] = 12;
 		cmd[9] = 0x40;
 		rc = sr_do_ioctl(minor, cmd, buffer, 12, 1, SCSI_DATA_READ, NULL);
@@ -201,8 +203,8 @@
 			unsigned long min, sec, frame;
 			memset(cmd, 0, MAX_COMMAND_SIZE);
 			cmd[0] = 0xde;
-			cmd[1] = (scsi_CDs[minor].device->scsi_level <= SCSI_2) ?
-			         (scsi_CDs[minor].device->lun << 5) : 0;
+			cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
+			         (SCp->device->lun << 5) : 0;
 			cmd[1] |= 0x03;
 			cmd[2] = 0xb0;
 			rc = sr_do_ioctl(minor, cmd, buffer, 0x16, 1, SCSI_DATA_READ, NULL);
@@ -228,8 +230,8 @@
 			 * where starts the last session ?) */
 			memset(cmd, 0, MAX_COMMAND_SIZE);
 			cmd[0] = 0xc7;
-			cmd[1] = (scsi_CDs[minor].device->scsi_level <= SCSI_2) ?
-			         (scsi_CDs[minor].device->lun << 5) : 0;
+			cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
+			         (SCp->device->lun << 5) : 0;
 			cmd[1] |= 0x03;
 			rc = sr_do_ioctl(minor, cmd, buffer, 4, 1, SCSI_DATA_READ, NULL);
 			if (rc == -EINVAL) {
@@ -253,8 +255,8 @@
 	case VENDOR_WRITER:
 		memset(cmd, 0, MAX_COMMAND_SIZE);
 		cmd[0] = READ_TOC;
-		cmd[1] = (scsi_CDs[minor].device->scsi_level <= SCSI_2) ?
-		         (scsi_CDs[minor].device->lun << 5) : 0;
+		cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
+		         (SCp->device->lun << 5) : 0;
 		cmd[8] = 0x04;
 		cmd[9] = 0x40;
 		rc = sr_do_ioctl(minor, cmd, buffer, 0x04, 1, SCSI_DATA_READ, NULL);
@@ -267,8 +269,8 @@
 			break;
 		}
 		cmd[0] = READ_TOC;	/* Read TOC */
-		cmd[1] = (scsi_CDs[minor].device->scsi_level <= SCSI_2) ?
-		         (scsi_CDs[minor].device->lun << 5) : 0;
+		cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
+		         (SCp->device->lun << 5) : 0;
 		cmd[6] = rc & 0x7f;	/* number of last session */
 		cmd[8] = 0x0c;
 		cmd[9] = 0x40;
@@ -285,17 +287,17 @@
 		/* should not happen */
 		printk(KERN_WARNING
 		   "sr%d: unknown vendor code (%i), not initialized ?\n",
-		       minor, VENDOR_ID);
+		       minor, SCp->vendor);
 		sector = 0;
 		no_multi = 1;
 		break;
 	}
-	scsi_CDs[minor].ms_offset = sector;
-	scsi_CDs[minor].xa_flag = 0;
+	SCp->ms_offset = sector;
+	SCp->xa_flag = 0;
 	if (CDS_AUDIO != sr_disk_status(cdi) && 1 == sr_is_xa(minor))
-		scsi_CDs[minor].xa_flag = 1;
+		SCp->xa_flag = 1;
 
-	if (2048 != scsi_CDs[minor].device->sector_size) {
+	if (2048 != SCp->device->sector_size) {
 		sr_set_blocklength(minor, 2048);
 	}
 	if (no_multi)
