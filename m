Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261868AbSJYW2J>; Fri, 25 Oct 2002 18:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261664AbSJYWVn>; Fri, 25 Oct 2002 18:21:43 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:39657 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261661AbSJYWQr>;
	Fri, 25 Oct 2002 18:16:47 -0400
Date: Fri, 25 Oct 2002 15:22:52 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] 4/6 2.5.44 scsi multi-path IO - upper layer
Message-ID: <20021025152252.D17527@eng2.beaverton.ibm.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20021025152116.A17462@eng2.beaverton.ibm.com> <20021025152149.A17527@eng2.beaverton.ibm.com> <20021025152208.B17527@eng2.beaverton.ibm.com> <20021025152226.C17527@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20021025152226.C17527@eng2.beaverton.ibm.com>; from patman on Fri, Oct 25, 2002 at 03:22:26PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SCSI upper-layer multi-path IO changes

 sd.c       |   52 ++++++++++++++----------
 sg.c       |  130 ++++++++++++++++++++++++++++++++++++++++---------------------
 sr.c       |   18 +++++---
 sr_ioctl.c |    4 +
 st.c       |   50 ++++++++++++++---------
 5 files changed, 160 insertions(+), 94 deletions(-)

diff -Nru a/drivers/scsi/sd.c b/drivers/scsi/sd.c
--- a/drivers/scsi/sd.c	Fri Oct 25 11:26:48 2002
+++ b/drivers/scsi/sd.c	Fri Oct 25 11:26:48 2002
@@ -219,8 +219,9 @@
 			if(!loc)
 				return -EINVAL;
 
-			host = sdp->host;
-	
+			host = scsi_get_host(sdkp->device);
+			if (host == NULL)
+				return -ENODEV;
 			/* default to most commonly used values */
 	
 		        diskinfo[0] = 0x40;	/* 1 << 6 */
@@ -466,6 +467,7 @@
  **/
 static int sd_open(struct inode *inode, struct file *filp)
 {
+	struct Scsi_Host * shp;
 	struct gendisk *disk = inode->i_bdev->bd_disk;
 	Scsi_Disk *sdkp = disk->private_data;
 	Scsi_Device * sdp = sdkp->device;
@@ -486,8 +488,11 @@
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
@@ -531,8 +536,8 @@
 
 error_out:
 	sdp->access_count--;
-	if (sdp->host->hostt->module)
-		__MOD_DEC_USE_COUNT(sdp->host->hostt->module);
+	if (shp->hostt->module)
+		__MOD_DEC_USE_COUNT(shp->hostt->module);
 	if (sd_template.module)
 		__MOD_DEC_USE_COUNT(sd_template.module);
 	return retval;	
@@ -554,6 +559,7 @@
 	struct gendisk *disk = inode->i_bdev->bd_disk;
 	Scsi_Disk *sdkp = disk->private_data;
 	Scsi_Device *sdp = sdkp->device;
+	struct Scsi_Host * shp;
 
 	SCSI_LOG_HLQUEUE(3, printk("sd_release: disk=%s\n", disk->disk_name));
 	if (!sdp)
@@ -569,8 +575,9 @@
 			if (scsi_block_when_processing_errors(sdp))
 				scsi_set_medium_removal(sdp, SCSI_REMOVAL_ALLOW);
 	}
-	if (sdp->host->hostt->module)
-		__MOD_DEC_USE_COUNT(sdp->host->hostt->module);
+	shp = scsi_get_host(sdp);
+	if (shp && shp->hostt->module)
+		__MOD_DEC_USE_COUNT(shp->hostt->module);
 	if (sd_template.module)
 		__MOD_DEC_USE_COUNT(sd_template.module);
 
@@ -1071,8 +1078,8 @@
 }
 
 static int
-sd_do_mode_sense6(Scsi_Device *sdp, Scsi_Request *SRpnt,
-		  int modepage, unsigned char *buffer, int len) {
+sd_do_mode_sense6(Scsi_Request *SRpnt, int modepage, unsigned char *buffer,
+	       	int len) {
 	unsigned char cmd[8];
 
 	memset((void *) &cmd[0], 0, 8);
@@ -1097,7 +1104,6 @@
 static void
 sd_read_write_protect_flag(Scsi_Disk *sdkp, char *diskname,
 			   Scsi_Request *SRpnt, unsigned char *buffer) {
-	Scsi_Device *sdp = sdkp->device;
 	int res;
 
 	/*
@@ -1105,7 +1111,7 @@
 	 * We have to start carefully: some devices hang if we ask
 	 * for more than is available.
 	 */
-	res = sd_do_mode_sense6(sdp, SRpnt, 0x3F, buffer, 4);
+	res = sd_do_mode_sense6(SRpnt, 0x3F, buffer, 4);
 
 	/*
 	 * Second attempt: ask for page 0
@@ -1113,13 +1119,13 @@
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
@@ -1371,8 +1377,9 @@
 	if (!gd)
 		return 1;
 
-	SCSI_LOG_HLQUEUE(3, printk("sd_attach: scsi device: <%d,%d,%d,%d>\n", 
-			 sdp->host->host_no, sdp->channel, sdp->id, sdp->lun));
+	SCSI_LOG_HLQUEUE(3, { printk("sd_attach: scsi_device: ");
+				scsi_paths_printk(sdp, ", ", "<%d,%d,%d,%d>");
+				printk("\n");});
 	if (sd_template.nr_dev >= sd_template.dev_max) {
 		sdp->attached--;
 		printk(KERN_ERR "sd_init: no more room for device\n");
@@ -1413,9 +1420,10 @@
         gd->driverfs_dev = &sdp->sdev_driverfs_dev;
         gd->flags |= GENHD_FL_DRIVERFS | GENHD_FL_DEVFS;
 	sd_disks[dsk_nr] = gd;
-	printk(KERN_NOTICE "Attached scsi %sdisk %s at scsi%d, channel %d, "
-	       "id %d, lun %d\n", sdp->removable ? "removable " : "",
-	       gd->disk_name, sdp->host->host_no, sdp->channel, sdp->id, sdp->lun);
+	printk(KERN_NOTICE "Attached scsi %sdisk %s at: ",
+	       sdp->removable ? "removable " : "", gd->disk_name);
+	scsi_paths_printk(sdp, "; ", "scsi%d, channel %d, id %d, lun %d");
+	printk("\n");
 	return 0;
 }
 
@@ -1448,9 +1456,9 @@
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
--- a/drivers/scsi/sg.c	Fri Oct 25 11:26:47 2002
+++ b/drivers/scsi/sg.c	Fri Oct 25 11:26:47 2002
@@ -250,6 +250,7 @@
 	Sg_fd *sfp;
 	int res;
 	int retval = -EBUSY;
+	struct Scsi_Host * shp;
 
 	SCSI_LOG_TIMEOUT(3, printk("sg_open: dev=%d, flags=0x%x\n", dev, flags));
 	sdp = sg_get_dev(dev);
@@ -260,8 +261,11 @@
 
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
@@ -302,7 +306,7 @@
 	}
 	if (!sdp->headfp) {	/* no existing opens on this device */
 		sdp->sgdebug = 0;
-		sdp->sg_tablesize = sdp->device->host->sg_tablesize;
+		sdp->sg_tablesize = shp->sg_tablesize;
 	}
 	if ((sfp = sg_add_sfp(sdp, dev)))
 		filp->private_data = sfp;
@@ -316,8 +320,8 @@
 
       error_out:
 	sdp->device->access_count--;
-	if ((!sdp->detached) && sdp->device->host->hostt->module)
-		__MOD_DEC_USE_COUNT(sdp->device->host->hostt->module);
+	if ((!sdp->detached) && shp->hostt->module)
+		__MOD_DEC_USE_COUNT(shp->hostt->module);
 	return retval;
 }
 
@@ -327,6 +331,7 @@
 {
 	Sg_device *sdp;
 	Sg_fd *sfp;
+	struct Scsi_Host * shp;
 
 	if ((!(sfp = (Sg_fd *) filp->private_data)) || (!(sdp = sfp->parentdp)))
 		return -ENXIO;
@@ -334,10 +339,10 @@
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
@@ -750,6 +755,8 @@
 	Sg_fd *sfp;
 	Sg_request *srp;
 	unsigned long iflags;
+	struct Scsi_Host * shp;
+	struct scsi_path_id scsi_path;
 
 	if ((!(sfp = (Sg_fd *) filp->private_data)) || (!(sdp = sfp->parentdp)))
 		return -ENXIO;
@@ -823,7 +830,10 @@
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
@@ -839,14 +849,15 @@
 
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
 			__put_user((short) sdp->device->new_queue_depth,
 				   &sg_idp->d_queue_depth);
@@ -962,12 +973,18 @@
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
@@ -1228,6 +1245,7 @@
 	Sg_device *sdp = NULL;
 	Sg_fd *sfp;
 	Sg_request *srp = NULL;
+	struct Scsi_Host * shp;
 
 	if (SCpnt && (SRpnt = SCpnt->sc_request))
 		srp = (Sg_request *) SRpnt->upper_private_data;
@@ -1303,8 +1321,9 @@
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
@@ -1439,6 +1458,7 @@
 	Sg_device *sdp = NULL;
 	unsigned long iflags;
 	int k;
+	struct Scsi_Host * shp;
 
 	write_lock_irqsave(&sg_dev_arr_lock, iflags);
 	if (sg_template.nr_dev >= sg_template.dev_max) {	/* try to resize */
@@ -1470,11 +1490,10 @@
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
 		if (NULL != sdp)
 			vfree((char *) sdp);
 		return 1;
@@ -1504,7 +1523,8 @@
 	sdp->exclude = 0;
 	sdp->sgdebug = 0;
 	sdp->detached = 0;
-	sdp->sg_tablesize = scsidp->host ? scsidp->host->sg_tablesize : 0;
+	shp = scsi_get_host(sdp->device);
+	sdp->sg_tablesize = shp ? shp->sg_tablesize : 0;
 	sdp->i_rdev = mk_kdev(SCSI_GENERIC_MAJOR, k);
 
 	memset(&sdp->sg_driverfs_dev, 0, sizeof (struct device));
@@ -1534,11 +1554,10 @@
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
@@ -1553,6 +1572,7 @@
 	Sg_request *srp;
 	Sg_request *tsrp;
 	int k, delay;
+	struct Scsi_Host * shp;
 
 	if (NULL == sg_dev_arr)
 		return;
@@ -1575,10 +1595,10 @@
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
@@ -1607,7 +1627,7 @@
 		sdp->de = NULL;
 		device_remove_file(&sdp->sg_driverfs_dev, &dev_attr_type);
 		device_remove_file(&sdp->sg_driverfs_dev, &dev_attr_kdev);
-		put_device(&sdp->sg_driverfs_dev);
+		device_unregister(&sdp->sg_driverfs_dev);
 		if (NULL == sdp->headfp)
 			vfree((char *) sdp);
 	}
@@ -1668,13 +1688,17 @@
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
@@ -2459,6 +2483,7 @@
 {
 	Sg_fd *sfp;
 	unsigned long iflags;
+	struct Scsi_Host * shp;
 
 	sfp = (Sg_fd *) sg_page_malloc(sizeof (Sg_fd), 0, 0);
 	if (!sfp)
@@ -2470,8 +2495,9 @@
 	sfp->timeout = SG_DEFAULT_TIMEOUT;
 	sfp->timeout_user = SG_DEFAULT_TIMEOUT_USER;
 	sfp->force_packid = SG_DEF_FORCE_PACK_ID;
+	shp = scsi_get_host(sdp->device);
 	sfp->low_dma = (SG_DEF_FORCE_LOW_DMA == 0) ?
-	    sdp->device->host->unchecked_isa_dma : 1;
+	    ((shp == NULL) ? 1 : shp->unchecked_isa_dma) : 1;
 	sfp->cmd_q = SG_DEF_COMMAND_Q;
 	sfp->keep_orphan = SG_DEF_KEEP_ORPHAN;
 	sfp->parentdp = sdp;
@@ -2531,6 +2557,7 @@
 	Sg_request *tsrp;
 	int dirty = 0;
 	int res = 0;
+	struct Scsi_Host * shp;
 
 	for (srp = sfp->headrp; srp; srp = tsrp) {
 		tsrp = srp->nextrp;
@@ -2564,8 +2591,9 @@
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
@@ -2995,13 +3023,25 @@
 				PRINT_PROC(" >>> device=sg%d ", dev);
 				if (sdp->detached)
 					PRINT_PROC("detached pending close ");
+#if 0
 				else
+					/* 
+					 * FIXME multi-path print all
+					 * paths. Ideally, something like:
+					 */
+					foo = scsi_paths_proc_print_paths(scd,
+						buffer + bar, 
+						"scsi%d chan=%d id=%d lun=%d\n");
+				/*
+				 * Previous code:
+				 */
 					PRINT_PROC
 					    ("scsi%d chan=%d id=%d lun=%d   em=%d",
 					     scsidp->host->host_no,
 					     scsidp->channel, scsidp->id,
 					     scsidp->lun,
 					     scsidp->host->hostt->emulated);
+#endif
 				PRINT_PROC(" sg_tablesize=%d excl=%d\n",
 					   sdp->sg_tablesize, sdp->exclude);
 			}
@@ -3031,13 +3071,15 @@
 	for (j = 0; j < max_dev; ++j) {
 		sdp = sg_get_dev(j);
 		if (sdp && (scsidp = sdp->device) && (!sdp->detached))
-			PRINT_PROC("%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n",
-				   scsidp->host->host_no, scsidp->channel,
-				   scsidp->id, scsidp->lun, (int) scsidp->type,
-				   (int) scsidp->access_count,
-				   (int) scsidp->new_queue_depth,
-				   (int) scsidp->device_busy,
-				   (int) scsidp->online);
+			/* 
+			 * FIXME multi-path to print all paths.
+			 */
+			PRINT_PROC("%d\t%d\t%d\t%d\t%d\n",
+				(int)scsidp->type,
+				(int)scsidp->access_count,
+				(int)scsidp->new_queue_depth,
+				(int)scsidp->device_busy,
+				(int)scsidp->online);
 		else
 			PRINT_PROC("-1\t-1\t-1\t-1\t-1\t-1\t-1\t-1\t-1\n");
 	}
diff -Nru a/drivers/scsi/sr.c b/drivers/scsi/sr.c
--- a/drivers/scsi/sr.c	Fri Oct 25 11:26:47 2002
+++ b/drivers/scsi/sr.c	Fri Oct 25 11:26:47 2002
@@ -97,13 +97,15 @@
 
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
@@ -428,6 +430,7 @@
 
 static int sr_open(struct cdrom_device_info *cdi, int purpose)
 {
+	struct Scsi_Host *shp;
 	Scsi_CD *cd = cdi->handle;
 
 	if (!cd->device)
@@ -440,8 +443,9 @@
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
 
@@ -491,8 +495,9 @@
 	if (sr_template.nr_dev > sr_template.dev_max)
 		panic("scsi_devices corrupt (sr)");
 
-	printk("Attached scsi CD-ROM %s at scsi%d, channel %d, id %d, lun %d\n",
-	       scsi_CDs[i].cdi.name, SDp->host->host_no, SDp->channel, SDp->id, SDp->lun);
+	printk("Attached scsi CD-ROM %s at: ", scsi_CDs[i].cdi.name);
+	scsi_paths_printk(SDp, "; ", "scsi%d, channel %d, id %d, lun %d");
+	printk("\n");
 	return 0;
 }
 
@@ -707,7 +712,6 @@
 		cgc->timeout = IOCTL_TIMEOUT;
 
 	sr_do_ioctl(cdi->handle, cgc);
-
 	return cgc->stat;
 }
 
diff -Nru a/drivers/scsi/sr_ioctl.c b/drivers/scsi/sr_ioctl.c
--- a/drivers/scsi/sr_ioctl.c	Fri Oct 25 11:26:48 2002
+++ b/drivers/scsi/sr_ioctl.c	Fri Oct 25 11:26:48 2002
@@ -79,6 +79,7 @@
 	Scsi_Request *SRpnt;
 	Scsi_Device *SDev;
         struct request *req;
+	struct Scsi_Host *SHpnt;
 	int result, err = 0, retries = 0;
 	char *bounce_buffer;
 
@@ -93,7 +94,8 @@
 
 	/* use ISA DMA buffer if necessary */
 	SRpnt->sr_request->buffer = cgc->buffer;
-	if (cgc->buffer && SRpnt->sr_host->unchecked_isa_dma &&
+	SHpnt = scsi_get_host(SDev);
+	if (cgc->buffer && SHpnt && SHpnt->unchecked_isa_dma &&
 	    (virt_to_phys(cgc->buffer) + cgc->buflen - 1 > ISA_DMA_THRESHOLD)) {
 		bounce_buffer = (char *) kmalloc(cgc->buflen, GFP_DMA);
 		if (bounce_buffer == NULL) {
diff -Nru a/drivers/scsi/st.c b/drivers/scsi/st.c
--- a/drivers/scsi/st.c	Fri Oct 25 11:26:47 2002
+++ b/drivers/scsi/st.c	Fri Oct 25 11:26:48 2002
@@ -975,6 +975,7 @@
 	Scsi_Tape *STp;
 	ST_partstat *STps;
 	int dev = TAPE_NR(inode->i_rdev);
+	struct Scsi_Host *SHpnt;
 
 	write_lock(&st_dev_arr_lock);
 	if (dev >= st_template.dev_max || scsi_tapes == NULL ||
@@ -992,8 +993,11 @@
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
@@ -1036,8 +1040,8 @@
 	normalize_buffer(STp->buffer);
 	STp->in_use = 0;
 	STp->device->access_count--;
-	if (STp->device->host->hostt->module)
-	    __MOD_DEC_USE_COUNT(STp->device->host->hostt->module);
+	if (SHpnt->hostt->module)
+	    __MOD_DEC_USE_COUNT(SHpnt->hostt->module);
 	return retval;
 
 }
@@ -1172,6 +1176,7 @@
 {
 	int result = 0;
 	Scsi_Tape *STp;
+	struct Scsi_Host *SHpnt;
 
 	kdev_t devt = inode->i_rdev;
 	int dev;
@@ -1189,8 +1194,9 @@
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
@@ -3683,22 +3689,26 @@
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
@@ -3775,7 +3785,7 @@
 	tpnt->dirty = 0;
 	tpnt->in_use = 0;
 	tpnt->drv_buffer = 1;	/* Try buffering if no mode sense */
-	tpnt->restr_dma = (SDp->host)->unchecked_isa_dma;
+	tpnt->restr_dma = SHpnt->unchecked_isa_dma;
 	tpnt->use_pf = (SDp->scsi_level >= SCSI_2);
 	tpnt->density = 0;
 	tpnt->do_auto_lock = ST_AUTO_LOCK;
@@ -3793,17 +3803,17 @@
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
@@ -3889,9 +3899,9 @@
 	}
 	devfs_register_tape (tpnt->de_r[0]);
 
-	printk(KERN_WARNING
-	"Attached scsi tape st%d at scsi%d, channel %d, id %d, lun %d\n",
-	       dev_num, SDp->host->host_no, SDp->channel, SDp->id, SDp->lun);
+	printk(KERN_WARNING "Attached scsi tape st%d at ", dev_num);
+	scsi_paths_printk(SDp, KERN_WARNING "\t",
+			  "scsi%d, channel %d, id %d, lun %d\n");
 	printk(KERN_WARNING "st%d: try direct i/o: %s, max page reachable by HBA %lu\n",
 	       dev_num, tpnt->try_dio ? "yes" : "no", tpnt->max_pfn);
 
