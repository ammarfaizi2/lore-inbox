Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264876AbSIQW4K>; Tue, 17 Sep 2002 18:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264839AbSIQWzG>; Tue, 17 Sep 2002 18:55:06 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:23980 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264703AbSIQWsh>; Tue, 17 Sep 2002 18:48:37 -0400
Date: Tue, 17 Sep 2002 15:52:01 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [RFC] [PATCH] 4/7 2.5.35 SCSI multi-path
Message-ID: <20020917155201.D18424@eng2.beaverton.ibm.com>
References: <20020917154940.A18401@eng2.beaverton.ibm.com> <20020917155018.A18424@eng2.beaverton.ibm.com> <20020917155041.B18424@eng2.beaverton.ibm.com> <20020917155120.C18424@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020917155120.C18424@eng2.beaverton.ibm.com>; from patman on Tue, Sep 17, 2002 at 03:51:20PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patches to scsi upper level drivers to simplify and enable the addition of
scsi multi-path IO support.

This does not add multi-path support, it adds changes that simplify the
addition of the actual scsi multi-path code.

 sd.c        |   69 ++++++++++++++++++++------------------
 sg.c        |  107 ++++++++++++++++++++++++++++++++++++++----------------------
 sr.c        |   34 +++++++------------
 sr_ioctl.c  |   31 ++++-------------
 sr_vendor.c |   18 +---------
 st.c        |   52 ++++++++++++++++-------------
 6 files changed, 159 insertions(+), 152 deletions(-)

diff -Nru a/drivers/scsi/sd.c b/drivers/scsi/sd.c
--- a/drivers/scsi/sd.c	Mon Sep 16 15:29:45 2002
+++ b/drivers/scsi/sd.c	Mon Sep 16 15:29:45 2002
@@ -213,8 +213,9 @@
 			if(!loc)
 				return -EINVAL;
 
-			host = sdp->host;
-	
+			host = scsi_get_host(sdkp->device);
+			if (host == NULL)
+				return -ENODEV;
 			/* default to most commonly used values */
 	
 		        diskinfo[0] = 0x40;	/* 1 << 6 */
@@ -397,8 +398,7 @@
 		nbuff, (rq_data_dir(SCpnt->request) == WRITE) ? 
 		"writing" : "reading", this_count, SCpnt->request->nr_sectors));
 
-	SCpnt->cmnd[1] = (SCpnt->device->scsi_level <= SCSI_2) ?
-			 ((SCpnt->lun << 5) & 0xe0) : 0;
+	SCpnt->cmnd[1] = 0;
 
 	if (((this_count > 0xff) || (block > 0x1fffff)) || SCpnt->device->ten) {
 		if (this_count > 0xffff)
@@ -463,6 +463,7 @@
  **/
 static int sd_open(struct inode *inode, struct file *filp)
 {
+	struct Scsi_Host * shp;
 	int retval = -ENXIO;
 	Scsi_Device * sdp;
 	Scsi_Disk * sdkp;
@@ -485,8 +486,11 @@
 	 * The following code can sleep.
 	 * Module unloading must be prevented
 	 */
-	if (sdp->host->hostt->module)
-		__MOD_INC_USE_COUNT(sdp->host->hostt->module);
+	shp = scsi_get_host(sdp);
+	if (shp == NULL)
+		return -ENODEV;
+	if (shp->hostt->module)
+		__MOD_INC_USE_COUNT(shp->hostt->module);
 	if (sd_template.module)
 		__MOD_INC_USE_COUNT(sd_template.module);
 	sdp->access_count++;
@@ -530,8 +534,8 @@
 
 error_out:
 	sdp->access_count--;
-	if (sdp->host->hostt->module)
-		__MOD_DEC_USE_COUNT(sdp->host->hostt->module);
+	if (shp->hostt->module)
+		__MOD_DEC_USE_COUNT(shp->hostt->module);
 	if (sd_template.module)
 		__MOD_DEC_USE_COUNT(sd_template.module);
 	return retval;	
@@ -553,6 +557,7 @@
 	Scsi_Disk * sdkp;
 	int dsk_nr = DEVICE_NR(inode->i_rdev);
 	Scsi_Device * sdp;
+	struct Scsi_Host * shp;
 
 	SCSI_LOG_HLQUEUE(3, printk("sd_release: dsk_nr=%d, part_nr=%d\n", 
 			    dsk_nr, SD_PARTITION(inode->i_rdev)));
@@ -570,8 +575,9 @@
 			if (scsi_block_when_processing_errors(sdp))
 				scsi_ioctl(sdp, SCSI_IOCTL_DOORUNLOCK, NULL);
 	}
-	if (sdp->host->hostt->module)
-		__MOD_DEC_USE_COUNT(sdp->host->hostt->module);
+	shp = scsi_get_host(sdp);
+	if (shp && shp->hostt->module)
+		__MOD_DEC_USE_COUNT(shp->hostt->module);
 	if (sd_template.module)
 		__MOD_DEC_USE_COUNT(sd_template.module);
 	return 0;
@@ -809,8 +815,9 @@
 
 		while (retries < 3) {
 			cmd[0] = TEST_UNIT_READY;
-			cmd[1] = (sdp->scsi_level <= SCSI_2) ?
-				((sdp->lun << 5) & 0xe0) : 0;
+			/*
+			 * cmd[1] LUN is set in the mid-layer.
+			 */
 			memset((void *) &cmd[2], 0, 8);
 
 			SRpnt->sr_cmd_len = 0;
@@ -845,9 +852,7 @@
 				printk(KERN_NOTICE "%s: Spinning up disk...",
 				       diskname);
 				cmd[0] = START_STOP;
-				cmd[1] = (sdp->scsi_level <= SCSI_2) ?
-					((sdp->lun << 5) & 0xe0) : 0;
-				cmd[1] |= 1;	/* Return immediately */
+				cmd[1] = 1;	/* Return immediately */
 				memset((void *) &cmd[2], 0, 8);
 				cmd[4] = 1;	/* Start spin cycle */
 				SRpnt->sr_cmd_len = 0;
@@ -894,9 +899,7 @@
 	retries = 3;
 	do {
 		cmd[0] = READ_CAPACITY;
-		cmd[1] = (sdp->scsi_level <= SCSI_2) ?
-			((sdp->lun << 5) & 0xe0) : 0;
-		memset((void *) &cmd[2], 0, 8);
+		memset((void *) &cmd[1], 0, 9);
 		memset((void *) buffer, 0, 8);
 
 		SRpnt->sr_cmd_len = 0;
@@ -1003,13 +1006,13 @@
 }
 
 static int
-sd_do_mode_sense6(Scsi_Device *sdp, Scsi_Request *SRpnt,
-		  int modepage, unsigned char *buffer, int len) {
+sd_do_mode_sense6(Scsi_Request *SRpnt, int modepage, unsigned char *buffer,
+	       	int len) {
 	unsigned char cmd[8];
 
 	memset((void *) &cmd[0], 0, 8);
 	cmd[0] = MODE_SENSE;
-	cmd[1] = (sdp->scsi_level <= SCSI_2) ? ((sdp->lun << 5) & 0xe0) : 0;
+	cmd[1] = 0;
 	cmd[2] = modepage;
 	cmd[4] = len;
 
@@ -1030,7 +1033,6 @@
 static void
 sd_read_write_protect_flag(Scsi_Disk *sdkp, char *diskname,
 			   Scsi_Request *SRpnt, unsigned char *buffer) {
-	Scsi_Device *sdp = sdkp->device;
 	int res;
 
 	/*
@@ -1038,7 +1040,7 @@
 	 * We have to start carefully: some devices hang if we ask
 	 * for more than is available.
 	 */
-	res = sd_do_mode_sense6(sdp, SRpnt, 0x3F, buffer, 4);
+	res = sd_do_mode_sense6(SRpnt, 0x3F, buffer, 4);
 
 	/*
 	 * Second attempt: ask for page 0
@@ -1046,13 +1048,13 @@
 	 * Sense Key 5: Illegal Request, Sense Code 24: Invalid field in CDB.
 	 */
 	if (res)
-		res = sd_do_mode_sense6(sdp, SRpnt, 0, buffer, 4);
+		res = sd_do_mode_sense6(SRpnt, 0, buffer, 4);
 
 	/*
 	 * Third attempt: ask 255 bytes, as we did earlier.
 	 */
 	if (res)
-		res = sd_do_mode_sense6(sdp, SRpnt, 0x3F, buffer, 255);
+		res = sd_do_mode_sense6(SRpnt, 0x3F, buffer, 255);
 
 	if (res) {
 		printk(KERN_WARNING
@@ -1316,8 +1318,9 @@
 		return 1;
 	gd = &p->disk;
 
-	SCSI_LOG_HLQUEUE(3, printk("sd_attach: scsi device: <%d,%d,%d,%d>\n", 
-			 sdp->host->host_no, sdp->channel, sdp->id, sdp->lun));
+	SCSI_LOG_HLQUEUE(3, { printk("sd_attach: scsi_device: ");
+				scsi_paths_printk(sdp, ", ", "<%d,%d,%d,%d>");
+				printk("\n");});
 	if (sd_template.nr_dev >= sd_template.dev_max) {
 		sdp->attached--;
 		printk(KERN_ERR "sd_init: no more room for device\n");
@@ -1361,9 +1364,9 @@
         gd->flags |= GENHD_FL_DRIVERFS | GENHD_FL_DEVFS;
 	sd_disks[dsk_nr] = gd;
 	sd_dskname(dsk_nr, diskname);
-	printk(KERN_NOTICE "Attached scsi %sdisk %s at scsi%d, channel %d, "
-	       "id %d, lun %d\n", sdp->removable ? "removable " : "",
-	       diskname, sdp->host->host_no, sdp->channel, sdp->id, sdp->lun);
+	printk("Attached scsi %sdisk %s at: ",
+	       sdp->removable ? "removable " : "", diskname);
+	scsi_paths_printk(sdp, "\t", "scsi%d, channel %d, id %d, lun %d\n");
 	return 0;
 }
 
@@ -1398,9 +1401,9 @@
 	int dsk_nr;
 	unsigned long iflags;
 
-	SCSI_LOG_HLQUEUE(3, printk("sd_detach: <%d,%d,%d,%d>\n", 
-			    sdp->host->host_no, sdp->channel, sdp->id, 
-			    sdp->lun));
+	SCSI_LOG_HLQUEUE(3, { printk("sd_detach: scsi_device: ");
+				scsi_paths_printk(sdp, ", ", "<%d,%d,%d,%d>");
+				printk("\n");});
 	write_lock_irqsave(&sd_dsk_arr_lock, iflags);
 	for (dsk_nr = 0; dsk_nr < sd_template.dev_max; dsk_nr++) {
 		sdkp = sd_dsk_arr[dsk_nr];
diff -Nru a/drivers/scsi/sg.c b/drivers/scsi/sg.c
--- a/drivers/scsi/sg.c	Mon Sep 16 15:29:45 2002
+++ b/drivers/scsi/sg.c	Mon Sep 16 15:29:45 2002
@@ -236,6 +236,7 @@
 	Sg_fd *sfp;
 	int res;
 	int retval = -EBUSY;
+	struct Scsi_Host * shp;
 
 	SCSI_LOG_TIMEOUT(3, printk("sg_open: dev=%d, flags=0x%x\n", dev, flags));
 	sdp = sg_get_dev(dev);
@@ -246,8 +247,11 @@
 
 	/* This driver's module count bumped by fops_get in <linux/fs.h> */
 	/* Prevent the device driver from vanishing while we sleep */
-	if (sdp->device->host->hostt->module)
-		__MOD_INC_USE_COUNT(sdp->device->host->hostt->module);
+	shp = scsi_get_host(sdp->device);
+	if (shp == NULL)
+		return -ENODEV;
+	if (shp->hostt->module)
+		__MOD_INC_USE_COUNT(shp->hostt->module);
 	sdp->device->access_count++;
 
 	if (!((flags & O_NONBLOCK) ||
@@ -288,7 +292,7 @@
 	}
 	if (!sdp->headfp) {	/* no existing opens on this device */
 		sdp->sgdebug = 0;
-		sdp->sg_tablesize = sdp->device->host->sg_tablesize;
+		sdp->sg_tablesize = shp->sg_tablesize;
 	}
 	if ((sfp = sg_add_sfp(sdp, dev)))
 		filp->private_data = sfp;
@@ -302,8 +306,8 @@
 
       error_out:
 	sdp->device->access_count--;
-	if ((!sdp->detached) && sdp->device->host->hostt->module)
-		__MOD_DEC_USE_COUNT(sdp->device->host->hostt->module);
+	if ((!sdp->detached) && shp->hostt->module)
+		__MOD_DEC_USE_COUNT(shp->hostt->module);
 	return retval;
 }
 
@@ -313,6 +317,7 @@
 {
 	Sg_device *sdp;
 	Sg_fd *sfp;
+	struct Scsi_Host * shp;
 
 	if ((!(sfp = (Sg_fd *) filp->private_data)) || (!(sdp = sfp->parentdp)))
 		return -ENXIO;
@@ -320,10 +325,10 @@
 	sg_fasync(-1, filp, 0);	/* remove filp from async notification list */
 	if (0 == sg_remove_sfp(sdp, sfp)) {	/* Returns 1 when sdp gone */
 		if (!sdp->detached) {
+			shp = scsi_get_host(sdp->device);
 			sdp->device->access_count--;
-			if (sdp->device->host->hostt->module)
-				__MOD_DEC_USE_COUNT(sdp->device->host->hostt->
-						    module);
+			if (shp && shp->hostt->module)
+				__MOD_DEC_USE_COUNT(shp->hostt->module);
 		}
 		sdp->exclude = 0;
 		wake_up_interruptible(&sdp->o_excl_wait);
@@ -692,8 +697,11 @@
 	SRpnt->sr_sense_buffer[0] = 0;
 	SRpnt->sr_cmd_len = hp->cmd_len;
 	if (!(hp->flags & SG_FLAG_LUN_INHIBIT)) {
-		if (sdp->device->scsi_level <= SCSI_2)
-			cmnd[1] = (cmnd[1] & 0x1f) | (sdp->device->lun << 5);
+		/*
+		 * XXX The mid-layer now sets cmnd[1] LUN, and we can't
+		 * easily stop it. Maybe this is an artifact of setting
+		 * the cmnd[1] LUN when it should not have been set?
+		*/
 	}
 	SRpnt->sr_use_sg = srp->data.k_use_sg;
 	SRpnt->sr_sglist_len = srp->data.sglist_len;
@@ -740,6 +748,8 @@
 	Sg_fd *sfp;
 	Sg_request *srp;
 	unsigned long iflags;
+	struct Scsi_Host * shp;
+	struct scsi_path_id scsi_path;
 
 	if ((!(sfp = (Sg_fd *) filp->private_data)) || (!(sdp = sfp->parentdp)))
 		return -ENXIO;
@@ -808,7 +818,10 @@
 		} else {
 			if (sdp->detached)
 				return -ENODEV;
-			sfp->low_dma = sdp->device->host->unchecked_isa_dma;
+			shp = scsi_get_host(sdp->device);
+			if (shp == NULL)
+				return -ENODEV;
+			sfp->low_dma = shp->unchecked_isa_dma;
 		}
 		return 0;
 	case SG_GET_LOW_DMA:
@@ -824,14 +837,15 @@
 
 			if (sdp->detached)
 				return -ENODEV;
-			__put_user((int) sdp->device->host->host_no,
+			scsi_get_path(sdp->device, &scsi_path);
+			__put_user((int) scsi_path.spi_shpnt->host_no,
 				   &sg_idp->host_no);
-			__put_user((int) sdp->device->channel,
+			__put_user((int) scsi_path.spi_channel,
 				   &sg_idp->channel);
-			__put_user((int) sdp->device->id, &sg_idp->scsi_id);
-			__put_user((int) sdp->device->lun, &sg_idp->lun);
+			__put_user((int) scsi_path.spi_id, &sg_idp->scsi_id);
+			__put_user((int) scsi_path.spi_lun, &sg_idp->lun);
 			__put_user((int) sdp->device->type, &sg_idp->scsi_type);
-			__put_user((short) sdp->device->host->cmd_per_lun,
+			__put_user((short) scsi_path.spi_shpnt->cmd_per_lun,
 				   &sg_idp->h_cmd_per_lun);
 			__put_user((short) sdp->device->queue_depth,
 				   &sg_idp->d_queue_depth);
@@ -947,12 +961,18 @@
 	case SG_EMULATED_HOST:
 		if (sdp->detached)
 			return -ENODEV;
-		return put_user(sdp->device->host->hostt->emulated, (int *) arg);
+		shp = scsi_get_host(sdp->device);
+		if (shp == NULL)
+			return -ENODEV;
+		return put_user(shp->hostt->emulated, (int *) arg);
 	case SG_SCSI_RESET:
 		if (sdp->detached)
 			return -ENODEV;
 		if (filp->f_flags & O_NONBLOCK) {
-			if (sdp->device->host->in_recovery)
+			shp = scsi_get_host(sdp->device);
+			if (shp == NULL)
+				return -ENODEV;
+			if (shp->in_recovery)
 				return -EBUSY;
 		} else if (!scsi_block_when_processing_errors(sdp->device))
 			return -EBUSY;
@@ -1213,6 +1233,7 @@
 	Sg_device *sdp = NULL;
 	Sg_fd *sfp;
 	Sg_request *srp = NULL;
+	struct Scsi_Host * shp;
 
 	if (SCpnt && (SRpnt = SCpnt->sc_request))
 		srp = (Sg_request *) SRpnt->upper_private_data;
@@ -1288,8 +1309,9 @@
 			SCSI_LOG_TIMEOUT(1, printk("sg...bh: already closed, final cleanup\n"));
 			if (0 == sg_remove_sfp(sdp, sfp)) {	/* device still present */
 				sdp->device->access_count--;
-				if (sdp->device->host->hostt->module)
-					__MOD_DEC_USE_COUNT(sdp->device->host->hostt->module);
+				shp = scsi_get_host(sdp->device);
+				if (shp && shp->hostt->module)
+					__MOD_DEC_USE_COUNT(shp->hostt->module);
 			}
 			if (sg_template.module)
 				__MOD_DEC_USE_COUNT(sg_template.module);
@@ -1414,6 +1436,7 @@
 	Sg_device *sdp;
 	unsigned long iflags;
 	int k;
+	struct Scsi_Host * shp;
 
 	write_lock_irqsave(&sg_dev_arr_lock, iflags);
 	if (sg_template.nr_dev >= sg_template.dev_max) {	/* try to resize */
@@ -1443,11 +1466,10 @@
 	if (k > SG_MAX_DEVS_MASK) {
 		scsidp->attached--;
 		write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
-		printk(KERN_WARNING
-		       "Unable to attach sg device <%d, %d, %d, %d>"
-		       " type=%d, minor number exceed %d\n",
-		       scsidp->host->host_no, scsidp->channel, scsidp->id,
-		       scsidp->lun, scsidp->type, SG_MAX_DEVS_MASK);
+		printk(KERN_WARNING "Unable to attach sg device ");
+		scsi_paths_printk(scsidp, " ", "<%d, %d, %d, %d>");
+		printk(KERN_WARNING " type=%d, minor number exceed %d\n",
+		       scsidp->type, SG_MAX_DEVS_MASK);
 		return 1;
 	}
 	if (k < sg_template.dev_max)
@@ -1468,7 +1490,8 @@
 	sdp->exclude = 0;
 	sdp->sgdebug = 0;
 	sdp->detached = 0;
-	sdp->sg_tablesize = scsidp->host ? scsidp->host->sg_tablesize : 0;
+	shp = scsi_get_host(sdp->device);
+	sdp->sg_tablesize = shp ? shp->sg_tablesize : 0;
 	sdp->i_rdev = mk_kdev(SCSI_GENERIC_MAJOR, k);
 
 	memset(&sdp->sg_driverfs_dev, 0, sizeof (struct device));
@@ -1497,11 +1520,10 @@
 	case TYPE_TAPE:
 		break;
 	default:
-		printk(KERN_NOTICE
-		       "Attached scsi generic sg%d at scsi%d, channel"
-		       " %d, id %d, lun %d,  type %d\n", k,
-		       scsidp->host->host_no, scsidp->channel, scsidp->id,
-		       scsidp->lun, scsidp->type);
+		printk(KERN_NOTICE "Attached scsi generic sg%d type %d at ",
+			k, scsidp->type);
+		scsi_paths_printk(scsidp, KERN_NOTICE " ",
+				  "scsi%d, channel %d, id %d, lun %d\n");
 	}
 	return 0;
 }
@@ -1516,6 +1538,7 @@
 	Sg_request *srp;
 	Sg_request *tsrp;
 	int k, delay;
+	struct Scsi_Host * shp;
 
 	if (NULL == sg_dev_arr)
 		return;
@@ -1538,10 +1561,10 @@
 					sdp->device->access_count--;
 					if (sg_template.module)
 						__MOD_DEC_USE_COUNT(sg_template.module);
-					if (sdp->device->host->hostt->module)
+					shp = scsi_get_host(sdp->device);
+					if (shp->hostt->module)
 						__MOD_DEC_USE_COUNT(
-							sdp->device->host->
-							 hostt->module);
+							shp->hostt->module);
 					__sg_remove_sfp(sdp, sfp);
 				} else {
 					delay = 1;
@@ -1631,13 +1654,17 @@
 	int dxfer_dir = hp->dxfer_direction;
 	Sg_scatter_hold *req_schp = &srp->data;
 	Sg_scatter_hold *rsv_schp = &sfp->reserve;
+	struct Scsi_Host * shp;
 
 	SCSI_LOG_TIMEOUT(4, printk("sg_start_req: dxfer_len=%d\n", dxfer_len));
 	if ((dxfer_len <= 0) || (dxfer_dir == SG_DXFER_NONE))
 		return 0;
+	shp = scsi_get_host(sfp->parentdp->device);
+	if (shp == NULL)
+		return 0;
 	if (sg_allow_dio && (hp->flags & SG_FLAG_DIRECT_IO) &&
 	    (dxfer_dir != SG_DXFER_UNKNOWN) && (0 == hp->iovec_count) &&
-	    (!sfp->parentdp->device->host->unchecked_isa_dma)) {
+	    (!shp->unchecked_isa_dma)) {
 		res = sg_build_direct(srp, sfp, dxfer_len);
 		if (res <= 0)	/* -ve -> error, 0 -> done, 1 -> try indirect */
 			return res;
@@ -2422,6 +2449,7 @@
 {
 	Sg_fd *sfp;
 	unsigned long iflags;
+	struct Scsi_Host * shp;
 
 	sfp = (Sg_fd *) sg_page_malloc(sizeof (Sg_fd), 0, 0);
 	if (!sfp)
@@ -2432,8 +2460,9 @@
 
 	sfp->timeout = SG_DEFAULT_TIMEOUT;
 	sfp->force_packid = SG_DEF_FORCE_PACK_ID;
+	shp = scsi_get_host(sdp->device);
 	sfp->low_dma = (SG_DEF_FORCE_LOW_DMA == 0) ?
-	    sdp->device->host->unchecked_isa_dma : 1;
+	    ((shp == NULL) ? 1 : shp->unchecked_isa_dma) : 1;
 	sfp->cmd_q = SG_DEF_COMMAND_Q;
 	sfp->keep_orphan = SG_DEF_KEEP_ORPHAN;
 	sfp->parentdp = sdp;
@@ -2493,6 +2522,7 @@
 	Sg_request *tsrp;
 	int dirty = 0;
 	int res = 0;
+	struct Scsi_Host * shp;
 
 	for (srp = sfp->headrp; srp; srp = tsrp) {
 		tsrp = srp->nextrp;
@@ -2526,8 +2556,9 @@
 		/* MOD_INC's to inhibit unloading sg and associated adapter driver */
 		if (sg_template.module)
 			__MOD_INC_USE_COUNT(sg_template.module);
-		if (sdp->device->host->hostt->module)
-			__MOD_INC_USE_COUNT(sdp->device->host->hostt->module);
+		shp = scsi_get_host(sdp->device);
+		if (shp && shp->hostt->module)
+			__MOD_INC_USE_COUNT(shp->hostt->module);
 		SCSI_LOG_TIMEOUT(1, printk("sg_remove_sfp: worrisome, %d writes pending\n",
 				  dirty));
 	}
diff -Nru a/drivers/scsi/sr.c b/drivers/scsi/sr.c
--- a/drivers/scsi/sr.c	Mon Sep 16 15:29:45 2002
+++ b/drivers/scsi/sr.c	Mon Sep 16 15:29:45 2002
@@ -98,13 +98,15 @@
 
 static void sr_release(struct cdrom_device_info *cdi)
 {
+	struct Scsi_Host *shp;
 	Scsi_CD *cd = cdi->handle;
 
 	if (cd->device->sector_size > 2048)
 		sr_set_blocklength(cd, 2048);
 	cd->device->access_count--;
-	if (cd->device->host->hostt->module)
-		__MOD_DEC_USE_COUNT(cd->device->host->hostt->module);
+	shp = scsi_get_host(cd->device);
+	if (shp && shp->hostt->module)
+		__MOD_DEC_USE_COUNT(shp->hostt->module);
 	if (sr_template.module)
 		__MOD_DEC_USE_COUNT(sr_template.module);
 }
@@ -336,8 +338,7 @@
 		   (rq_data_dir(SCpnt->request) == WRITE) ? "writing" : "reading",
 				 this_count, SCpnt->request->nr_sectors));
 
-	SCpnt->cmnd[1] = (SCpnt->device->scsi_level <= SCSI_2) ?
-			 ((SCpnt->lun << 5) & 0xe0) : 0;
+	SCpnt->cmnd[1] = 0;
 
 	block = SCpnt->request->sector / (s_size >> 9);
 
@@ -399,6 +400,7 @@
 
 static int sr_open(struct cdrom_device_info *cdi, int purpose)
 {
+	struct Scsi_Host *shp;
 	Scsi_CD *cd = cdi->handle;
 
 	if (!cd->device)
@@ -411,8 +413,9 @@
 		return -ENXIO;
 	}
 	cd->device->access_count++;
-	if (cd->device->host->hostt->module)
-		__MOD_INC_USE_COUNT(cd->device->host->hostt->module);
+	shp = scsi_get_host(cd->device);
+	if (shp && shp->hostt->module)
+		__MOD_INC_USE_COUNT(shp->hostt->module);
 	if (sr_template.module)
 		__MOD_INC_USE_COUNT(sr_template.module);
 
@@ -462,8 +465,8 @@
 	if (sr_template.nr_dev > sr_template.dev_max)
 		panic("scsi_devices corrupt (sr)");
 
-	printk("Attached scsi CD-ROM %s at scsi%d, channel %d, id %d, lun %d\n",
-	       scsi_CDs[i].cdi.name, SDp->host->host_no, SDp->channel, SDp->id, SDp->lun);
+	printk("Attached scsi CD-ROM %s at: ", scsi_CDs[i].cdi.name);
+	scsi_paths_printk(SDp, "    ", "scsi%d, channel %d, id %d, lun %d\n");
 	return 0;
 }
 
@@ -486,9 +489,7 @@
 
 	do {
 		cmd[0] = READ_CAPACITY;
-		cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
-			 ((cd->device->lun << 5) & 0xe0) : 0;
-		memset((void *) &cmd[2], 0, 8);
+		memset((void *) &cmd[1], 0, 9);
 		SRpnt->sr_request->rq_status = RQ_SCSI_BUSY;	/* Mark as really busy */
 		SRpnt->sr_cmd_len = 0;
 
@@ -598,8 +599,7 @@
 		return;
 	}
 	cmd[0] = MODE_SENSE;
-	cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
-		 ((cd->device->lun << 5) & 0xe0) : 0;
+	cmd[1] = 0;
 	cmd[2] = 0x2a;
 	cmd[4] = 128;
 	cmd[3] = cmd[5] = 0;
@@ -673,15 +673,7 @@
  */
 static int sr_packet(struct cdrom_device_info *cdi, struct cdrom_generic_command *cgc)
 {
-	Scsi_CD *cd = cdi->handle;
-	Scsi_Device *device = cd->device;
-	
-	/* set the LUN */
-	if (device->scsi_level <= SCSI_2)
-		cgc->cmd[1] |= device->lun << 5;
-
 	cgc->stat = sr_do_ioctl(cdi->handle, cgc->cmd, cgc->buffer, cgc->buflen, cgc->quiet, cgc->data_direction, cgc->sense);
-
 	return cgc->stat;
 }
 
diff -Nru a/drivers/scsi/sr_ioctl.c b/drivers/scsi/sr_ioctl.c
--- a/drivers/scsi/sr_ioctl.c	Mon Sep 16 15:29:45 2002
+++ b/drivers/scsi/sr_ioctl.c	Mon Sep 16 15:29:45 2002
@@ -79,6 +79,7 @@
 	Scsi_Request *SRpnt;
 	Scsi_Device *SDev;
         struct request *req;
+	struct Scsi_Host *SHpnt;
 	int result, err = 0, retries = 0;
 	char *bounce_buffer;
 
@@ -92,7 +93,8 @@
 
 	/* use ISA DMA buffer if necessary */
 	SRpnt->sr_request->buffer = buffer;
-	if (buffer && SRpnt->sr_host->unchecked_isa_dma &&
+	SHpnt = scsi_get_host(SDev);
+	if (buffer && SHpnt && SHpnt->unchecked_isa_dma &&
 	    (virt_to_phys(buffer) + buflength - 1 > ISA_DMA_THRESHOLD)) {
 		bounce_buffer = (char *) kmalloc(buflength, GFP_DMA);
 		if (bounce_buffer == NULL) {
@@ -194,9 +196,7 @@
 	u_char sr_cmd[10];
 
 	sr_cmd[0] = GPCMD_TEST_UNIT_READY;
-	sr_cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
-	            ((cd->device->lun) << 5) : 0;
-	sr_cmd[2] = sr_cmd[3] = sr_cmd[4] = sr_cmd[5] = 0;
+	sr_cmd[1] = sr_cmd[2] = sr_cmd[3] = sr_cmd[4] = sr_cmd[5] = 0;
 	return sr_do_ioctl(cd, sr_cmd, NULL, 0, 1, SCSI_DATA_NONE, NULL);
 }
 
@@ -206,9 +206,7 @@
 	u_char sr_cmd[10];
 
 	sr_cmd[0] = GPCMD_START_STOP_UNIT;
-	sr_cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
-	            ((cd->device->lun) << 5) : 0;
-	sr_cmd[2] = sr_cmd[3] = sr_cmd[5] = 0;
+	sr_cmd[1] = sr_cmd[2] = sr_cmd[3] = sr_cmd[5] = 0;
 	sr_cmd[4] = (pos == 0) ? 0x03 /* close */ : 0x02 /* eject */ ;
 
 	return sr_do_ioctl(cd, sr_cmd, NULL, 0, 0, SCSI_DATA_NONE, NULL);
@@ -283,8 +281,7 @@
 	int result;
 
 	sr_cmd[0] = GPCMD_READ_SUBCHANNEL;
-	sr_cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
-	            ((cd->device->lun) << 5) : 0;
+	sr_cmd[1] = 0;
 	sr_cmd[2] = 0x40;	/* I do want the subchannel info */
 	sr_cmd[3] = 0x02;	/* Give me medium catalog number info */
 	sr_cmd[4] = sr_cmd[5] = 0;
@@ -318,8 +315,6 @@
 
 	memset(sr_cmd, 0, MAX_COMMAND_SIZE);
 	sr_cmd[0] = GPCMD_SET_SPEED;	/* SET CD SPEED */
-	sr_cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
-	            ((cd->device->lun) << 5) : 0;
 	sr_cmd[2] = (speed >> 8) & 0xff;	/* MSB for speed (in kbytes/sec) */
 	sr_cmd[3] = speed & 0xff;	/* LSB */
 
@@ -349,8 +344,6 @@
 			struct cdrom_tochdr *tochdr = (struct cdrom_tochdr *) arg;
 
 			sr_cmd[0] = GPCMD_READ_TOC_PMA_ATIP;
-			sr_cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
-			            ((cd->device->lun) << 5) : 0;
 			sr_cmd[2] = sr_cmd[3] = sr_cmd[4] = sr_cmd[5] = 0;
 			sr_cmd[8] = 12;		/* LSB of length */
 
@@ -367,9 +360,7 @@
 			struct cdrom_tocentry *tocentry = (struct cdrom_tocentry *) arg;
 
 			sr_cmd[0] = GPCMD_READ_TOC_PMA_ATIP;
-			sr_cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
-			            ((cd->device->lun) << 5) : 0;
-			sr_cmd[1] |= (tocentry->cdte_format == CDROM_MSF) ? 0x02 : 0;
+			sr_cmd[1] = (tocentry->cdte_format == CDROM_MSF) ? 0x02 : 0;
 			sr_cmd[2] = sr_cmd[3] = sr_cmd[4] = sr_cmd[5] = 0;
 			sr_cmd[6] = tocentry->cdte_track;
 			sr_cmd[8] = 12;		/* LSB of length */
@@ -394,8 +385,6 @@
 		struct cdrom_ti* ti = (struct cdrom_ti*)arg;
 
 		sr_cmd[0] = GPCMD_PLAYAUDIO_TI;
-		sr_cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
-		            (cd->device->lun << 5) : 0;
 		sr_cmd[4] = ti->cdti_trk0;
 		sr_cmd[5] = ti->cdti_ind0;
 		sr_cmd[7] = ti->cdti_trk1;
@@ -445,9 +434,7 @@
 
 	memset(cmd, 0, MAX_COMMAND_SIZE);
 	cmd[0] = GPCMD_READ_CD;	/* READ_CD */
-	cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
-	         (cd->device->lun << 5) : 0;
-	cmd[1] |= ((format & 7) << 2);
+	cmd[1] = ((format & 7) << 2);
 	cmd[2] = (unsigned char) (lba >> 24) & 0xff;
 	cmd[3] = (unsigned char) (lba >> 16) & 0xff;
 	cmd[4] = (unsigned char) (lba >> 8) & 0xff;
@@ -499,8 +486,6 @@
 
 	memset(cmd, 0, MAX_COMMAND_SIZE);
 	cmd[0] = GPCMD_READ_10;
-	cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
-	         (cd->device->lun << 5) : 0;
 	cmd[2] = (unsigned char) (lba >> 24) & 0xff;
 	cmd[3] = (unsigned char) (lba >> 16) & 0xff;
 	cmd[4] = (unsigned char) (lba >> 8) & 0xff;
diff -Nru a/drivers/scsi/sr_vendor.c b/drivers/scsi/sr_vendor.c
--- a/drivers/scsi/sr_vendor.c	Mon Sep 16 15:29:45 2002
+++ b/drivers/scsi/sr_vendor.c	Mon Sep 16 15:29:45 2002
@@ -122,9 +122,7 @@
 #endif
 	memset(cmd, 0, MAX_COMMAND_SIZE);
 	cmd[0] = MODE_SELECT;
-	cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
-	         (cd->device->lun << 5) : 0;
-	cmd[1] |= (1 << 4);
+	cmd[1] = (1 << 4);
 	cmd[4] = 12;
 	modesel = (struct ccs_modesel_head *) buffer;
 	memset(modesel, 0, sizeof(*modesel));
@@ -173,8 +171,6 @@
 	case VENDOR_SCSI3:
 		memset(cmd, 0, MAX_COMMAND_SIZE);
 		cmd[0] = READ_TOC;
-		cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
-		         (cd->device->lun << 5) : 0;
 		cmd[8] = 12;
 		cmd[9] = 0x40;
 		rc = sr_do_ioctl(cd, cmd, buffer, 12, 1, SCSI_DATA_READ, NULL);
@@ -199,9 +195,7 @@
 			unsigned long min, sec, frame;
 			memset(cmd, 0, MAX_COMMAND_SIZE);
 			cmd[0] = 0xde;
-			cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
-			         (cd->device->lun << 5) : 0;
-			cmd[1] |= 0x03;
+			cmd[1] = 0x03;
 			cmd[2] = 0xb0;
 			rc = sr_do_ioctl(cd, cmd, buffer, 0x16, 1, SCSI_DATA_READ, NULL);
 			if (rc != 0)
@@ -227,9 +221,7 @@
 			 * where starts the last session ?) */
 			memset(cmd, 0, MAX_COMMAND_SIZE);
 			cmd[0] = 0xc7;
-			cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
-			         (cd->device->lun << 5) : 0;
-			cmd[1] |= 0x03;
+			cmd[1] = 0x03;
 			rc = sr_do_ioctl(cd, cmd, buffer, 4, 1, SCSI_DATA_READ, NULL);
 			if (rc == -EINVAL) {
 				printk(KERN_INFO "%s: Hmm, seems the drive "
@@ -253,8 +245,6 @@
 	case VENDOR_WRITER:
 		memset(cmd, 0, MAX_COMMAND_SIZE);
 		cmd[0] = READ_TOC;
-		cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
-		         (cd->device->lun << 5) : 0;
 		cmd[8] = 0x04;
 		cmd[9] = 0x40;
 		rc = sr_do_ioctl(cd, cmd, buffer, 0x04, 1, SCSI_DATA_READ, NULL);
@@ -267,8 +257,6 @@
 			break;
 		}
 		cmd[0] = READ_TOC;	/* Read TOC */
-		cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
-		         (cd->device->lun << 5) : 0;
 		cmd[6] = rc & 0x7f;	/* number of last session */
 		cmd[8] = 0x0c;
 		cmd[9] = 0x40;
diff -Nru a/drivers/scsi/st.c b/drivers/scsi/st.c
--- a/drivers/scsi/st.c	Mon Sep 16 15:29:45 2002
+++ b/drivers/scsi/st.c	Mon Sep 16 15:29:45 2002
@@ -379,8 +379,6 @@
 		}
 	}
 
-	if (SRpnt->sr_device->scsi_level <= SCSI_2)
-		cmd[1] |= (SRpnt->sr_device->lun << 5) & 0xe0;
 	init_completion(&STp->wait);
 	SRpnt->sr_use_sg = STp->buffer->do_dio || (bytes > (STp->buffer)->frp[0].length);
 	if (SRpnt->sr_use_sg) {
@@ -929,6 +927,7 @@
 	Scsi_Tape *STp;
 	ST_partstat *STps;
 	int dev = TAPE_NR(inode->i_rdev);
+	struct Scsi_Host *SHpnt;
 
 	write_lock(&st_dev_arr_lock);
 	if (dev >= st_template.dev_max || scsi_tapes == NULL ||
@@ -946,8 +945,11 @@
 	write_unlock(&st_dev_arr_lock);
 	STp->rew_at_close = STp->autorew_dev = (minor(inode->i_rdev) & 0x80) == 0;
 
-	if (STp->device->host->hostt->module)
-		__MOD_INC_USE_COUNT(STp->device->host->hostt->module);
+	SHpnt = scsi_get_host(STp->device);
+	if (!SHpnt) 
+		return (-ENXIO);
+	if (SHpnt->hostt->module)
+		__MOD_INC_USE_COUNT(SHpnt->hostt->module);
 	STp->device->access_count++;
 
 	if (!scsi_block_when_processing_errors(STp->device)) {
@@ -990,8 +992,8 @@
 	normalize_buffer(STp->buffer);
 	STp->in_use = 0;
 	STp->device->access_count--;
-	if (STp->device->host->hostt->module)
-	    __MOD_DEC_USE_COUNT(STp->device->host->hostt->module);
+	if (SHpnt->hostt->module)
+	    __MOD_DEC_USE_COUNT(SHpnt->hostt->module);
 	return retval;
 
 }
@@ -1126,6 +1128,7 @@
 {
 	int result = 0;
 	Scsi_Tape *STp;
+	struct Scsi_Host *SHpnt;
 
 	kdev_t devt = inode->i_rdev;
 	int dev;
@@ -1143,8 +1146,9 @@
 	STp->in_use = 0;
 	write_unlock(&st_dev_arr_lock);
 	STp->device->access_count--;
-	if (STp->device->host->hostt->module)
-		__MOD_DEC_USE_COUNT(STp->device->host->hostt->module);
+	SHpnt = scsi_get_host(STp->device);
+	if (SHpnt && SHpnt->hostt->module)
+		__MOD_DEC_USE_COUNT(SHpnt->hostt->module);
 
 	return result;
 }
@@ -3659,22 +3663,26 @@
 	ST_buffer *buffer;
 	int i, mode, dev_num;
 	char *stp;
+	struct Scsi_Host *SHpnt;
 	u64 bounce_limit;
 
 	if (SDp->type != TYPE_TAPE)
 		return 1;
 	if ((stp = st_incompatible(SDp))) {
-		printk(KERN_INFO
-		       "st: Found incompatible tape at scsi%d, channel %d, id %d, lun %d\n",
-		       SDp->host->host_no, SDp->channel, SDp->id, SDp->lun);
+		printk(KERN_INFO "st: Found incompatible tape at ");
+		scsi_paths_printk(SDp, KERN_INFO "\t", 
+				  "scsi%d, channel %d, id %d, lun %d\n");
 		printk(KERN_INFO "st: The suggested driver is %s.\n", stp);
 		return 1;
 	}
 
-	i = SDp->host->sg_tablesize;
+	SHpnt = scsi_get_host(SDp);
+	if (SHpnt == NULL)
+		return 1;
+	i = SHpnt->sg_tablesize;
 	if (st_max_sg_segs < i)
 		i = st_max_sg_segs;
-	buffer = new_tape_buffer(TRUE, (SDp->host)->unchecked_isa_dma, i);
+	buffer = new_tape_buffer(TRUE, (SHpnt)->unchecked_isa_dma, i);
 	if (buffer == NULL) {
 		printk(KERN_ERR "st: Can't allocate new tape buffer. Device not attached.\n");
 		return 1;
@@ -3796,7 +3804,7 @@
 	tpnt->dirty = 0;
 	tpnt->in_use = 0;
 	tpnt->drv_buffer = 1;	/* Try buffering if no mode sense */
-	tpnt->restr_dma = (SDp->host)->unchecked_isa_dma;
+	tpnt->restr_dma = SHpnt->unchecked_isa_dma;
 	tpnt->use_pf = (SDp->scsi_level >= SCSI_2);
 	tpnt->density = 0;
 	tpnt->do_auto_lock = ST_AUTO_LOCK;
@@ -3814,17 +3822,17 @@
 	tpnt->timeout = ST_TIMEOUT;
 	tpnt->long_timeout = ST_LONG_TIMEOUT;
 
-	tpnt->try_dio = try_direct_io && !SDp->host->unchecked_isa_dma;
+	tpnt->try_dio = try_direct_io && !SHpnt->unchecked_isa_dma;
 	bounce_limit = BLK_BOUNCE_HIGH; /* Borrowed from scsi_merge.c */
-	if (SDp->host->highmem_io) {
+	if (SHpnt->highmem_io) {
 		if (!PCI_DMA_BUS_IS_PHYS)
 			/* Platforms with virtual-DMA translation
 			 * hardware have no practical limit.
 			 */
 			bounce_limit = BLK_BOUNCE_ANY;
-		else if (SDp->host->pci_dev)
-			bounce_limit = SDp->host->pci_dev->dma_mask;
-	} else if (SDp->host->unchecked_isa_dma)
+		else if (SHpnt->pci_dev)
+			bounce_limit = SHpnt->pci_dev->dma_mask;
+	} else if (SHpnt->unchecked_isa_dma)
 		bounce_limit = BLK_BOUNCE_ISA;
 	bounce_limit >>= PAGE_SHIFT;
 	if (bounce_limit > ULONG_MAX)
@@ -3863,9 +3871,9 @@
 
 	st_template.nr_dev++;
 	write_unlock(&st_dev_arr_lock);
-	printk(KERN_WARNING
-	"Attached scsi tape st%d at scsi%d, channel %d, id %d, lun %d\n",
-	       dev_num, SDp->host->host_no, SDp->channel, SDp->id, SDp->lun);
+	printk(KERN_WARNING "Attached scsi tape st%d at ", dev_num);
+	scsi_paths_printk(SDp, KERN_WARNING "\t",
+			  "scsi%d, channel %d, id %d, lun %d\n");
 	printk(KERN_WARNING "st%d: try direct i/o: %s, max page reachable by HBA %lu\n",
 	       dev_num, tpnt->try_dio ? "yes" : "no", tpnt->max_pfn);
 
