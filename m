Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263954AbTDNV2M (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263955AbTDNV2M (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:28:12 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:4874 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id S263954AbTDNV1i (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 17:27:38 -0400
Date: Mon, 14 Apr 2003 23:39:23 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: linux-kernel@vger.kernel.org
Subject: [RFC] char device management
Message-ID: <Pine.LNX.4.44.0304142246590.5042-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Below is an experimental patch, which adds a similar interface for the 
character devices as we have for block devices.
(Patch bases on the earlier char device patches, complete patch is at 
http://www.xs4all.nl/~zippel/cdev.diff)
I used the sg driver to demonstrate how it makes char device management a 
lot simpler, I mostly just had to remove code and as a bonus I fixed a few 
races. The first 256 devices appear under the normal major number, the 
rest is allocated dynamically and is already exported via sysfs.
There still is a bit to do, but I hope it helps to understand that there 
is more to do than just a larger dev_t.

bye, Roman

diff -ur linux-2.5.67-cdev4/drivers/scsi/sg.c linux-2.5.67-cdev5/drivers/scsi/sg.c
--- linux-2.5.67-cdev4/drivers/scsi/sg.c	2003-03-19 02:16:32.000000000 +0100
+++ linux-2.5.67-cdev5/drivers/scsi/sg.c	2003-04-14 20:41:31.000000000 +0200
@@ -107,13 +107,14 @@
 #define SG_SECTOR_SZ 512
 #define SG_SECTOR_MSK (SG_SECTOR_SZ - 1)
 
-#define SG_DEV_ARR_LUMP 6	/* amount to over allocate sg_dev_arr by */
-
 static int sg_attach(Scsi_Device *);
 static void sg_detach(Scsi_Device *);
 
 static Scsi_Request *dummy_cmdp;	/* only used for sizeof */
 
+#define SG_MINORS	256
+static unsigned long sg_index_bits[SG_MINORS / BITS_PER_LONG];
+static LIST_HEAD(sg_devlist);
 static rwlock_t sg_dev_arr_lock = RW_LOCK_UNLOCKED;	/* Also used to lock
 							   file descriptor list for device */
 
@@ -177,6 +178,7 @@
 } Sg_fd;
 
 typedef struct sg_device { /* holds the state of each scsi generic device */
+	struct list_head list;
 	struct Scsi_Device_Template *driver;
 	Scsi_Device *device;
 	wait_queue_head_t o_excl_wait;	/* queue open() when O_EXCL in use */
@@ -187,7 +189,7 @@
 	volatile char exclude;	/* opened for exclusive access */
 	char sgdebug;		/* 0->off, 1->sense, 9->dump dev, 10-> all devs */
 	struct device sg_driverfs_dev;
-	struct gendisk *disk;
+	struct char_device *cdev;
 } Sg_device;
 
 static int sg_fasync(int fd, struct file *filp, int mode);
@@ -214,7 +216,7 @@
 static void sg_unlink_reserve(Sg_fd * sfp, Sg_request * srp);
 static char *sg_page_malloc(int rqSz, int lowDma, int *retSzp);
 static void sg_page_free(char *buff, int size);
-static Sg_fd *sg_add_sfp(Sg_device * sdp, int dev);
+static Sg_fd *sg_add_sfp(struct char_device *cdev);
 static int sg_remove_sfp(Sg_device * sdp, Sg_fd * sfp);
 static void __sg_remove_sfp(Sg_device * sdp, Sg_fd * sfp);
 static Sg_request *sg_get_rq_mark(Sg_fd * sfp, int pack_id);
@@ -226,14 +228,8 @@
 static int sg_allow_access(unsigned char opcode, char dev_type);
 static int sg_build_direct(Sg_request * srp, Sg_fd * sfp, int dxfer_len);
 // static void sg_unmap_and(Sg_scatter_hold * schp, int free_also);
-static Sg_device *sg_get_dev(int dev);
 static inline unsigned char *sg_scatg2virt(const struct scatterlist *sclp);
-#ifdef CONFIG_PROC_FS
-static int sg_last_dev(void);
-#endif
 
-static Sg_device **sg_dev_arr = NULL;
-static int sg_dev_max;
 static int sg_nr_dev;
 
 #define SZ_SG_HEADER sizeof(struct sg_header)
@@ -244,25 +240,23 @@
 static int
 sg_open(struct inode *inode, struct file *filp)
 {
-	int dev = minor(inode->i_rdev);
 	int flags = filp->f_flags;
 	Sg_device *sdp;
 	Sg_fd *sfp;
 	int res;
 	int retval = -EBUSY;
 
-	SCSI_LOG_TIMEOUT(3, printk("sg_open: dev=%d, flags=0x%x\n", dev, flags));
-	sdp = sg_get_dev(dev);
-	if ((!sdp) || (!sdp->device))
-		return -ENXIO;
-	if (sdp->detached)
-		return -ENODEV;
+	SCSI_LOG_TIMEOUT(3, printk("sg_open: dev=%lx, flags=0x%x\n", inode->i_cdev->cd_dev, flags));
+	sfp = sg_add_sfp(inode->i_cdev);
+	if (IS_ERR(sfp))
+		return PTR_ERR(sfp);
+	sdp = inode->i_cdev->cd_data;
 
 	/* This driver's module count bumped by fops_get in <linux/fs.h> */
 	/* Prevent the device driver from vanishing while we sleep */
 	retval = scsi_device_get(sdp->device);
 	if (retval)
-		return retval;
+		goto error_free;
 
 	if (!((flags & O_NONBLOCK) ||
 	      scsi_block_when_processing_errors(sdp->device))) {
@@ -296,26 +290,13 @@
 			goto error_out;
 		}
 	}
-	if (sdp->detached) {
-		retval = -ENODEV;
-		goto error_out;
-	}
-	if (!sdp->headfp) {	/* no existing opens on this device */
-		sdp->sgdebug = 0;
-		sdp->sg_tablesize = sdp->device->host->sg_tablesize;
-	}
-	if ((sfp = sg_add_sfp(sdp, dev)))
-		filp->private_data = sfp;
-	else {
-		if (flags & O_EXCL)
-			sdp->exclude = 0;	/* undo if error */
-		retval = -ENOMEM;
-		goto error_out;
-	}
+	filp->private_data = sfp;
 	return 0;
 
       error_out:
 	scsi_device_put(sdp->device);
+      error_free:
+	sg_remove_sfp(sdp, sfp);
 	return retval;
 }
 
@@ -328,7 +309,7 @@
 
 	if ((!(sfp = (Sg_fd *) filp->private_data)) || (!(sdp = sfp->parentdp)))
 		return -ENXIO;
-	SCSI_LOG_TIMEOUT(3, printk("sg_release: %s\n", sdp->disk->disk_name));
+	SCSI_LOG_TIMEOUT(3, printk("sg_release: %s\n", sdp->cdev->cd_name));
 	sg_fasync(-1, filp, 0);	/* remove filp from async notification list */
 	if (0 == sg_remove_sfp(sdp, sfp)) {	/* Returns 1 when sdp gone */
 		if (!sdp->detached) {
@@ -355,7 +336,7 @@
 	if ((!(sfp = (Sg_fd *) filp->private_data)) || (!(sdp = sfp->parentdp)))
 		return -ENXIO;
 	SCSI_LOG_TIMEOUT(3, printk("sg_read: %s, count=%d\n",
-				   sdp->disk->disk_name, (int) count));
+				   sdp->cdev->cd_name, (int) count));
 	if (ppos != &filp->f_pos) ;	/* FIXME: Hmm.  Seek to the right place, or fail?  */
 	if ((k = verify_area(VERIFY_WRITE, buf, count)))
 		return k;
@@ -508,7 +489,7 @@
 	if ((!(sfp = (Sg_fd *) filp->private_data)) || (!(sdp = sfp->parentdp)))
 		return -ENXIO;
 	SCSI_LOG_TIMEOUT(3, printk("sg_write: %s, count=%d\n",
-				   sdp->disk->disk_name, (int) count));
+				   sdp->cdev->cd_name, (int) count));
 	if (sdp->detached)
 		return -ENODEV;
 	if (!((filp->f_flags & O_NONBLOCK) ||
@@ -695,7 +676,6 @@
 
 	srp->my_cmdp = SRpnt;
 	q = SRpnt->sr_device->request_queue;
-	SRpnt->sr_request->rq_disk = sdp->disk;
 	SRpnt->sr_sense_buffer[0] = 0;
 	SRpnt->sr_cmd_len = hp->cmd_len;
 	SRpnt->sr_use_sg = srp->data.k_use_sg;
@@ -747,7 +727,7 @@
 	if ((!(sfp = (Sg_fd *) filp->private_data)) || (!(sdp = sfp->parentdp)))
 		return -ENXIO;
 	SCSI_LOG_TIMEOUT(3, printk("sg_ioctl: %s, cmd=0x%x\n",
-				   sdp->disk->disk_name, (int) cmd_in));
+				   sdp->cdev->cd_name, (int) cmd_in));
 	read_only = (O_RDWR != (filp->f_flags & O_ACCMODE));
 
 	switch (cmd_in) {
@@ -1050,7 +1030,7 @@
 	} else if (count < SG_MAX_QUEUE)
 		res |= POLLOUT | POLLWRNORM;
 	SCSI_LOG_TIMEOUT(3, printk("sg_poll: %s, res=0x%x\n",
-				   sdp->disk->disk_name, (int) res));
+				   sdp->cdev->cd_name, (int) res));
 	return res;
 }
 
@@ -1064,7 +1044,7 @@
 	if ((!(sfp = (Sg_fd *) filp->private_data)) || (!(sdp = sfp->parentdp)))
 		return -ENXIO;
 	SCSI_LOG_TIMEOUT(3, printk("sg_fasync: %s, mode=%d\n",
-				   sdp->disk->disk_name, mode));
+				   sdp->cdev->cd_name, mode));
 
 	retval = fasync_helper(fd, filp, mode, &sfp->async_qp);
 	return (retval < 0) ? retval : 0;
@@ -1256,7 +1236,7 @@
 	srp->done = 1;
 
 	SCSI_LOG_TIMEOUT(4, printk("sg_cmd_done: %s, pack_id=%d, res=0x%x\n",
-		sdp->disk->disk_name, srp->header.pack_id, (int) SRpnt->sr_result));
+		sdp->cdev->cd_name, srp->header.pack_id, (int) SRpnt->sr_result));
 	srp->header.resid = SCpnt->resid;
 	/* N.B. unit of duration changes here from jiffies to millisecs */
 	srp->header.duration =
@@ -1331,8 +1311,7 @@
 sg_device_kdev_read(struct device *driverfs_dev, char *page)
 {
 	Sg_device *sdp = list_entry(driverfs_dev, Sg_device, sg_driverfs_dev);
-	return sprintf(page, "%x\n", MKDEV(sdp->disk->major,
-					   sdp->disk->first_minor));
+	return sprintf(page, "%lx\n", (long)sdp->cdev->cd_dev);
 }
 static DEVICE_ATTR(kdev,S_IRUGO,sg_device_kdev_read,NULL);
 
@@ -1347,70 +1326,30 @@
 static int
 sg_attach(Scsi_Device * scsidp)
 {
-	struct gendisk *disk;
+	struct char_device *cdev;
 	Sg_device *sdp = NULL;
+	dev_t dev;
 	unsigned long iflags;
 	int k, error;
 
-	disk = alloc_disk(1);
-	if (!disk)
-		return -ENOMEM;
+	write_lock_irqsave(&sg_dev_arr_lock, iflags);
+	k = find_first_zero_bit(sg_index_bits, SG_MINORS);
+	if (k < SG_MINORS) {
+		__set_bit(k, sg_index_bits);
+		dev = MKDEV(SCSI_GENERIC_MAJOR, k);
+	} else
+		dev = 0;
+	write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
+	cdev = alloc_chrdev(dev);
+	if (!cdev)
+		return -EBUSY;
 
 	error = scsi_slave_attach(scsidp);
 	if (error)
 		goto out_put;
-		
-	write_lock_irqsave(&sg_dev_arr_lock, iflags);
-	if (sg_nr_dev >= sg_dev_max) {	/* try to resize */
-		Sg_device **tmp_da;
-		int tmp_dev_max = sg_nr_dev + SG_DEV_ARR_LUMP;
-
-		write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
-		tmp_da = (Sg_device **)vmalloc(
-				tmp_dev_max * sizeof(Sg_device *));
-		if (NULL == tmp_da) {
-			printk(KERN_ERR
-			       "sg_attach: device array cannot be resized\n");
-			error = -ENOMEM;
-			goto out_detach;
-		}
-		write_lock_irqsave(&sg_dev_arr_lock, iflags);
-		memset(tmp_da, 0, tmp_dev_max * sizeof (Sg_device *));
-		memcpy(tmp_da, sg_dev_arr,
-		       sg_dev_max * sizeof (Sg_device *));
-		vfree((char *) sg_dev_arr);
-		sg_dev_arr = tmp_da;
-		sg_dev_max = tmp_dev_max;
-	}
 
-find_empty_slot:
-	for (k = 0; k < sg_dev_max; k++)
-		if (!sg_dev_arr[k])
-			break;
-	if (k > SG_MAX_DEVS_MASK) {
-		write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
-		printk(KERN_WARNING
-		       "Unable to attach sg device <%d, %d, %d, %d>"
-		       " type=%d, minor number exceed %d\n",
-		       scsidp->host->host_no, scsidp->channel, scsidp->id,
-		       scsidp->lun, scsidp->type, SG_MAX_DEVS_MASK);
-		if (NULL != sdp)
-			vfree((char *) sdp);
-		error = -ENODEV;
-		goto out_detach;
-	}
-	if (k < sg_dev_max) {
-		if (NULL == sdp) {
-			write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
-			sdp = (Sg_device *)vmalloc(sizeof(Sg_device));
-			write_lock_irqsave(&sg_dev_arr_lock, iflags);
-			if (!sg_dev_arr[k])
-				goto find_empty_slot;
-		}
-	} else
-		sdp = NULL;
+	sdp = kmalloc(sizeof(Sg_device), GFP_KERNEL);
 	if (NULL == sdp) {
-		write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
 		printk(KERN_ERR "sg_attach: Sg_device cannot be allocated\n");
 		error = -ENOMEM;
 		goto out_detach;
@@ -1419,11 +1358,8 @@
 	SCSI_LOG_TIMEOUT(3, printk("sg_attach: dev=%d \n", k));
 	memset(sdp, 0, sizeof(*sdp));
 	sdp->driver = &sg_template;
-	disk->private_data = &sdp->driver;
-	sprintf(disk->disk_name, "sg%d", k);
-	disk->major = SCSI_GENERIC_MAJOR;
-	disk->first_minor = k;
-	sdp->disk = disk;
+	cdev->cd_data = sdp;
+	sdp->cdev = cdev;
 	sdp->device = scsidp;
 	init_waitqueue_head(&sdp->o_excl_wait);
 	sdp->headfp = NULL;
@@ -1440,15 +1376,19 @@
 	sdp->sg_driverfs_dev.parent = &scsidp->sdev_driverfs_dev;
 	sdp->sg_driverfs_dev.bus = scsidp->sdev_driverfs_dev.bus;
 
+	error = add_chrdev(cdev, &sg_fops);
+	if (error)
+		goto out_free_sdp;
+	write_lock_irqsave(&sg_dev_arr_lock, iflags);
+	list_add(&sdp->list, &sg_devlist);
 	sg_nr_dev++;
-	sg_dev_arr[k] = sdp;
 	write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
 
 	device_register(&sdp->sg_driverfs_dev);
 	device_create_file(&sdp->sg_driverfs_dev, &dev_attr_type);
 	device_create_file(&sdp->sg_driverfs_dev, &dev_attr_kdev);
 	sdp->de = devfs_register(scsidp->de, "generic", DEVFS_FL_DEFAULT,
-				 SCSI_GENERIC_MAJOR, k,
+				 MAJOR(cdev->cd_dev), MINOR(cdev->cd_dev),
 				 S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP,
 				 &sg_fops, sdp);
 	switch (scsidp->type) {
@@ -1467,10 +1407,12 @@
 	}
 	return 0;
 
+out_free_sdp:
+	kfree(sdp);
 out_detach:
 	scsi_slave_detach(scsidp);
 out_put:
-	put_disk(disk);
+	del_chrdev(cdev);
 	return error;
 }
 
@@ -1483,16 +1425,13 @@
 	Sg_fd *tsfp;
 	Sg_request *srp;
 	Sg_request *tsrp;
-	int k, delay;
+	int delay;
 
-	if (NULL == sg_dev_arr)
-		return;
 	delay = 0;
 	write_lock_irqsave(&sg_dev_arr_lock, iflags);
-	for (k = 0; k < sg_dev_max; k++) {
-		sdp = sg_dev_arr[k];
-		if ((NULL == sdp) || (sdp->device != scsidp))
-			continue;	/* dirty but lowers nesting */
+	list_for_each_entry(sdp, &sg_devlist, list) {
+		if (sdp->device != scsidp)
+			continue;
 		if (sdp->headfp) {
 			sdp->detached = 1;
 			for (sfp = sdp->headfp; sfp; sfp = tsfp) {
@@ -1512,13 +1451,12 @@
 						    POLL_HUP);
 				}
 			}
-			SCSI_LOG_TIMEOUT(3, printk("sg_detach: dev=%d, dirty\n", k));
-			if (NULL == sdp->headfp) {
-				sg_dev_arr[k] = NULL;
-			}
+			SCSI_LOG_TIMEOUT(3, printk("sg_detach: dev=%s, dirty\n", sdp->cdev->cd_name));
+			if (NULL == sdp->headfp)
+				list_del(&sdp->list);
 		} else {	/* nothing active, simple case */
-			SCSI_LOG_TIMEOUT(3, printk("sg_detach: dev=%d\n", k));
-			sg_dev_arr[k] = NULL;
+			SCSI_LOG_TIMEOUT(3, printk("sg_detach: dev=%s\n", sdp->cdev->cd_name));
+			list_del(&sdp->list);
 		}
 		scsi_slave_detach(scsidp);
 		sg_nr_dev--;
@@ -1532,10 +1470,12 @@
 		device_remove_file(&sdp->sg_driverfs_dev, &dev_attr_type);
 		device_remove_file(&sdp->sg_driverfs_dev, &dev_attr_kdev);
 		device_unregister(&sdp->sg_driverfs_dev);
-		put_disk(sdp->disk);
-		sdp->disk = NULL;
+		if (MAJOR(sdp->cdev->cd_dev) == SCSI_GENERIC_MAJOR)
+			clear_bit(MINOR(sdp->cdev->cd_dev), sg_index_bits);
+		del_chrdev(sdp->cdev);
+		sdp->cdev = NULL;
 		if (NULL == sdp->headfp)
-			vfree((char *) sdp);
+			kfree(sdp);
 	}
 
 	if (delay)
@@ -1643,11 +1583,6 @@
 #endif				/* CONFIG_PROC_FS */
 	scsi_unregister_device(&sg_template);
 	unregister_chrdev(SCSI_GENERIC_MAJOR, "sg");
-	if (sg_dev_arr != NULL) {
-		vfree((char *) sg_dev_arr);
-		sg_dev_arr = NULL;
-	}
-	sg_dev_max = 0;
 }
 
 static int
@@ -2447,14 +2382,15 @@
 #endif
 
 static Sg_fd *
-sg_add_sfp(Sg_device * sdp, int dev)
+sg_add_sfp(struct char_device *cdev)
 {
+	Sg_device *sdp;
 	Sg_fd *sfp;
 	unsigned long iflags;
 
 	sfp = (Sg_fd *) sg_page_malloc(sizeof (Sg_fd), 0, 0);
 	if (!sfp)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	memset(sfp, 0, sizeof (Sg_fd));
 	init_waitqueue_head(&sfp->read_wait);
 	sfp->rq_list_lock = RW_LOCK_UNLOCKED;
@@ -2462,15 +2398,25 @@
 	sfp->timeout = SG_DEFAULT_TIMEOUT;
 	sfp->timeout_user = SG_DEFAULT_TIMEOUT_USER;
 	sfp->force_packid = SG_DEF_FORCE_PACK_ID;
-	sfp->low_dma = (SG_DEF_FORCE_LOW_DMA == 0) ?
-	    sdp->device->host->unchecked_isa_dma : 1;
 	sfp->cmd_q = SG_DEF_COMMAND_Q;
 	sfp->keep_orphan = SG_DEF_KEEP_ORPHAN;
-	sfp->parentdp = sdp;
+
 	write_lock_irqsave(&sg_dev_arr_lock, iflags);
-	if (!sdp->headfp)
+	sdp = cdev->cd_data;
+	if (!sdp || !sdp->device || sdp->detached) {
+		write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
+		sg_page_free((char *) sfp, sizeof (Sg_fd));
+		return ERR_PTR(-ENODEV);
+	}
+	sfp->parentdp = sdp;
+	sfp->low_dma = (SG_DEF_FORCE_LOW_DMA == 0) ?
+	    sdp->device->host->unchecked_isa_dma : 1;
+
+	if (!sdp->headfp) {	/* no existing opens on this device */
 		sdp->headfp = sfp;
-	else {			/* add to tail of existing list */
+		sdp->sgdebug = 0;
+		sdp->sg_tablesize = sdp->device->host->sg_tablesize;
+	} else {		/* add to tail of existing list */
 		Sg_fd *pfp = sdp->headfp;
 		while (pfp->nextfp)
 			pfp = pfp->nextfp;
@@ -2537,16 +2483,8 @@
 		write_lock_irqsave(&sg_dev_arr_lock, iflags);
 		__sg_remove_sfp(sdp, sfp);
 		if (sdp->detached && (NULL == sdp->headfp)) {
-			int k, maxd;
-
-			maxd = sg_dev_max;
-			for (k = 0; k < maxd; ++k) {
-				if (sdp == sg_dev_arr[k])
-					break;
-			}
-			if (k < maxd)
-				sg_dev_arr[k] = NULL;
-			vfree((char *) sdp);
+			list_del(&sdp->list);
+			kfree(sdp);
 			res = 1;
 		}
 		write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
@@ -2662,37 +2600,6 @@
 }
 
 #ifdef CONFIG_PROC_FS
-static int
-sg_last_dev()
-{
-	int k;
-	unsigned long iflags;
-
-	read_lock_irqsave(&sg_dev_arr_lock, iflags);
-	for (k = sg_dev_max - 1; k >= 0; --k)
-		if (sg_dev_arr[k] && sg_dev_arr[k]->device)
-			break;
-	read_unlock_irqrestore(&sg_dev_arr_lock, iflags);
-	return k + 1;		/* origin 1 */
-}
-#endif
-
-static Sg_device *
-sg_get_dev(int dev)
-{
-	Sg_device *sdp = NULL;
-	unsigned long iflags;
-
-	if (sg_dev_arr && (dev >= 0)) {
-		read_lock_irqsave(&sg_dev_arr_lock, iflags);
-		if (dev < sg_dev_max)
-			sdp = sg_dev_arr[dev];
-		read_unlock_irqrestore(&sg_dev_arr_lock, iflags);
-	}
-	return sdp;
-}
-
-#ifdef CONFIG_PROC_FS
 
 static struct proc_dir_entry *sg_proc_sgp = NULL;
 
@@ -2951,45 +2858,38 @@
 		   off_t offset, int size)
 {
 	Sg_device *sdp;
-	int j, max_dev;
+	unsigned long iflags;
 
-	if (NULL == sg_dev_arr) {
-		PRINT_PROC("sg_dev_arr NULL, driver not initialized\n");
-		return 1;
-	}
-	max_dev = sg_last_dev();
-	PRINT_PROC("dev_max(currently)=%d max_active_device=%d (origin 1)\n",
-		   sg_dev_max, max_dev);
 	PRINT_PROC(" def_reserved_size=%d\n", sg_big_buff);
-	for (j = 0; j < max_dev; ++j) {
-		if ((sdp = sg_get_dev(j))) {
-			struct scsi_device *scsidp = sdp->device;
-
-			if (NULL == scsidp) {
-				PRINT_PROC("device %d detached ??\n", j);
-				continue;
-			}
+	read_lock_irqsave(&sg_dev_arr_lock, iflags);
+	list_for_each_entry(sdp, &sg_devlist, list) {
+		struct scsi_device *scsidp = sdp->device;
 
-			if (sg_get_nth_sfp(sdp, 0)) {
-				PRINT_PROC(" >>> device=%s ",
-					sdp->disk->disk_name);
-				if (sdp->detached)
-					PRINT_PROC("detached pending close ");
-				else
-					PRINT_PROC
-					    ("scsi%d chan=%d id=%d lun=%d   em=%d",
-					     scsidp->host->host_no,
-					     scsidp->channel, scsidp->id,
-					     scsidp->lun,
-					     scsidp->host->hostt->emulated);
-				PRINT_PROC(" sg_tablesize=%d excl=%d\n",
-					   sdp->sg_tablesize, sdp->exclude);
-			}
-			if (0 == sg_proc_debug_helper(buffer, len, begin,
-						      offset, size, sdp))
-				return 0;
+		if (NULL == scsidp) {
+			PRINT_PROC("device %s detached ??\n", sdp->cdev->cd_name);
+			continue;
 		}
+
+		if (sg_get_nth_sfp(sdp, 0)) {
+			PRINT_PROC(" >>> device=%s ",
+				sdp->cdev->cd_name);
+			if (sdp->detached)
+				PRINT_PROC("detached pending close ");
+			else
+				PRINT_PROC
+				    ("scsi%d chan=%d id=%d lun=%d   em=%d",
+				     scsidp->host->host_no,
+				     scsidp->channel, scsidp->id,
+				     scsidp->lun,
+				     scsidp->host->hostt->emulated);
+			PRINT_PROC(" sg_tablesize=%d excl=%d\n",
+				   sdp->sg_tablesize, sdp->exclude);
+		}
+		if (0 == sg_proc_debug_helper(buffer, len, begin,
+					      offset, size, sdp))
+			return 0;
 	}
+	read_unlock_irqrestore(&sg_dev_arr_lock, iflags);
 	return 1;
 }
 
@@ -3004,13 +2904,12 @@
 sg_proc_dev_info(char *buffer, int *len, off_t * begin, off_t offset, int size)
 {
 	Sg_device *sdp;
-	int j, max_dev;
 	struct scsi_device *scsidp;
+	unsigned long iflags;
 
-	max_dev = sg_last_dev();
-	for (j = 0; j < max_dev; ++j) {
-		sdp = sg_get_dev(j);
-		if (sdp && (scsidp = sdp->device) && (!sdp->detached))
+	read_lock_irqsave(&sg_dev_arr_lock, iflags);
+	list_for_each_entry(sdp, &sg_devlist, list) {
+		if ((scsidp = sdp->device) && !sdp->detached)
 			PRINT_PROC("%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n",
 				   scsidp->host->host_no, scsidp->channel,
 				   scsidp->id, scsidp->lun, (int) scsidp->type,
@@ -3021,6 +2920,7 @@
 		else
 			PRINT_PROC("-1\t-1\t-1\t-1\t-1\t-1\t-1\t-1\t-1\n");
 	}
+	read_unlock_irqrestore(&sg_dev_arr_lock, iflags);
 	return 1;
 }
 
@@ -3051,18 +2951,18 @@
 		     off_t offset, int size)
 {
 	Sg_device *sdp;
-	int j, max_dev;
 	struct scsi_device *scsidp;
+	unsigned long iflags;
 
-	max_dev = sg_last_dev();
-	for (j = 0; j < max_dev; ++j) {
-		sdp = sg_get_dev(j);
-		if (sdp && (scsidp = sdp->device) && (!sdp->detached))
+	read_lock_irqsave(&sg_dev_arr_lock, iflags);
+	list_for_each_entry(sdp, &sg_devlist, list) {
+		if ((scsidp = sdp->device) && !sdp->detached)
 			PRINT_PROC("%8.8s\t%16.16s\t%4.4s\n",
 				   scsidp->vendor, scsidp->model, scsidp->rev);
 		else
 			PRINT_PROC("<no active device>\n");
 	}
+	read_unlock_irqrestore(&sg_dev_arr_lock, iflags);
 	return 1;
 }
 
diff -ur linux-2.5.67-cdev4/fs/char_dev.c linux-2.5.67-cdev5/fs/char_dev.c
--- linux-2.5.67-cdev4/fs/char_dev.c	2003-04-14 13:11:24.000000000 +0200
+++ linux-2.5.67-cdev5/fs/char_dev.c	2003-04-14 20:41:31.000000000 +0200
@@ -125,6 +125,61 @@
 	}
 }
 
+#define CHRDEV_NR	32768
+
+static unsigned long char_index_bits[CHRDEV_NR / BITS_PER_LONG];
+static spinlock_t char_index_lock = SPIN_LOCK_UNLOCKED;
+
+struct char_device *alloc_chrdev(dev_t dev)
+{
+	if (!dev) {
+		int index;
+
+		spin_lock(&char_index_lock);
+		index = find_first_zero_bit(char_index_bits, CHRDEV_NR);
+		if (index == CHRDEV_NR) {
+			spin_unlock(&char_index_lock);
+			return NULL;
+		}
+		__set_bit(index, char_index_bits);
+		spin_unlock(&char_index_lock);
+		dev = 0x10000 + index;
+	}
+	return cdget(dev);
+}
+
+int add_chrdev(struct char_device *cdev, struct file_operations *fops)
+{
+	int res = 0;
+
+	down(&cdev->cd_sem);
+	if (!cdev->cd_fops)
+		cdev->cd_fops = fops;
+	else
+		res = -EBUSY;
+	up(&cdev->cd_sem);
+
+	return res;
+}
+
+void unlink_chrdev(struct char_device *cdev)
+{
+	cdev->cd_fops = NULL;
+}
+
+void del_chrdev(struct char_device *cdev)
+{
+	int i = cdev->cd_dev - 0x10000;
+
+	unlink_chrdev(cdev);
+	if (cdev->cd_dev >= 0x10000 && i < CHRDEV_NR) {
+		spin_lock(&char_index_lock);
+		clear_bit(i, char_index_bits);
+		spin_unlock(&char_index_lock);
+	}
+	cdput(cdev);
+}
+
 int get_chrdev_list(char *page)
 {
 	struct char_device *cdev;
@@ -277,7 +332,7 @@
 
 	cdev = cdget(kdev_t_to_nr(dev));
 	down(&cdev->cd_sem);
-	sprintf(buffer, "%s(%d,%d)", cdev->cd_name ? cdev->cd_name : "unknown-char", major(dev), minor(dev));
+	sprintf(buffer, "%s(%ld,%ld)", cdev->cd_name ? cdev->cd_name : "unknown-char", major(dev), minor(dev));
 	up(&cdev->cd_sem);
 
 	return buffer;
diff -ur linux-2.5.67-cdev4/include/linux/fs.h linux-2.5.67-cdev5/include/linux/fs.h
--- linux-2.5.67-cdev4/include/linux/fs.h	2003-04-13 22:46:52.000000000 +0200
+++ linux-2.5.67-cdev5/include/linux/fs.h	2003-04-14 20:41:32.000000000 +0200
@@ -1072,6 +1072,10 @@
 extern int chrdev_open(struct inode *, struct file *);
 extern struct char_device *cdget(dev_t);
 extern void cdput(struct char_device *);
+extern struct char_device *alloc_chrdev(dev_t);
+extern int add_chrdev(struct char_device *, struct file_operations *);
+extern void unlink_chrdev(struct char_device *);
+extern void del_chrdev(struct char_device *);
 
 #define cdget_major(maj)	cdget(MKDEV(0, maj))
 

