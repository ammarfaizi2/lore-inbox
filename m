Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbVILOhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbVILOhP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 10:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbVILOhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:37:15 -0400
Received: from palrel11.hp.com ([156.153.255.246]:38039 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S1751082AbVILOhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:37:12 -0400
Date: Mon, 12 Sep 2005 09:36:53 -0500
From: mike.miller@hp.com
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 3/8] cciss: new disk register/deregister routines
Message-ID: <20050912143653.GI4616@beardog.cca.cpqcorp.net>
Reply-To: mikem@beardog.cca.cpqcorp.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 3 of 8

The spinlock is in place because the same variable is used in the interrupt
handler. During testing we found it was possible for the interrupt handler
to fire and try to do some work on a disk that was being deleted. Only happens 
on SMP systems.
Replaced kmalloc/memset with kzalloc.
Replaced spaces with tabs, everything looks right now. Apologies.

Signed-off-by: Mike Miller <mike.miller@hp.com>

 cciss.c |  515 ++++++++++++++++++++++++++++++++++++++++------------------------
 cciss.h |    8
 2 files changed, 333 insertions(+), 190 deletions(-)
--------------------------------------------------------------------------------
diff -burNp lx2613-p002/drivers/block/cciss.c lx2613-p003/drivers/block/cciss.c
--- lx2613-p002/drivers/block/cciss.c	2005-09-12 09:19:31.089301440 -0500
+++ lx2613-p003/drivers/block/cciss.c	2005-09-12 09:13:16.489249304 -0500
@@ -155,15 +155,24 @@ static int cciss_ioctl(struct inode *ino
 
 static int revalidate_allvol(ctlr_info_t *host);
 static int cciss_revalidate(struct gendisk *disk);
-static int deregister_disk(struct gendisk *disk);
-static int register_new_disk(ctlr_info_t *h);
+static int rebuild_lun_table(ctlr_info_t *h, struct gendisk *del_disk);
+static int deregister_disk(struct gendisk *disk, drive_info_struct *drv, int clear_all);
 
+static void cciss_read_capacity(int ctlr, int logvol, ReadCapdata_struct *buf,
+	int withirq, unsigned int *total_size, unsigned int *block_size);
+static void cciss_geometry_inquiry(int ctlr, int logvol,
+			int withirq, unsigned int total_size,
+			unsigned int block_size, InquiryData_struct *inq_buff,
+			drive_info_struct *drv);
 static void cciss_getgeometry(int cntl_num);
 
 static void start_io( ctlr_info_t *h);
 static int sendcmd( __u8 cmd, int ctlr, void *buff, size_t size,
 	unsigned int use_unit_num, unsigned int log_unit, __u8 page_code,
 	unsigned char *scsi3addr, int cmd_type);
+static int sendcmd_withirq(__u8	cmd, int ctlr, void *buff, size_t size,
+	unsigned int use_unit_num, unsigned int log_unit, __u8	page_code,
+	int cmd_type);
 
 #ifdef CONFIG_PROC_FS
 static int cciss_proc_get_info(char *buffer, char **start, off_t offset, 
@@ -280,7 +289,7 @@ static int cciss_proc_get_info(char *buf
 	for(i=0; i<=h->highest_lun; i++) {
 
                 drv = &h->drv[i];
-		if (drv->block_size == 0)
+		if (drv->heads == 0)
 			continue;
 
 		vol_sz = drv->nr_blocks;
@@ -471,6 +480,8 @@ static int cciss_open(struct inode *inod
 	if (host->busy_initializing)
 		return -EBUSY;
 
+	if (host->busy_initializing || drv->busy_configuring)
+		return -EBUSY;
 	/*
 	 * Root is allowed to open raw volume zero even if it's not configured
 	 * so array config can still work. Root is also allowed to open any
@@ -814,10 +825,10 @@ static int cciss_ioctl(struct inode *ino
  		return(0);
  	}
 	case CCISS_DEREGDISK:
-		return deregister_disk(disk);
+		return rebuild_lun_table(host, disk);
 
 	case CCISS_REGNEWD:
-		return register_new_disk(host);
+		return rebuild_lun_table(host, NULL);
 
 	case CCISS_PASSTHRU:
 	{
@@ -1161,48 +1172,323 @@ static int revalidate_allvol(ctlr_info_t
         return 0;
 }
 
-static int deregister_disk(struct gendisk *disk)
+/* This function will check the usage_count of the drive to be updated/added.
+ * If the usage_count is zero then the drive information will be updated and
+ * the disk will be re-registered with the kernel.  If not then it will be
+ * left alone for the next reboot.  The exception to this is disk 0 which
+ * will always be left registered with the kernel since it is also the
+ * controller node.  Any changes to disk 0 will show up on the next
+ * reboot.
+*/
+static void cciss_update_drive_info(int ctlr, int drv_index)
+  {
+	ctlr_info_t *h = hba[ctlr];
+	struct gendisk *disk;
+	ReadCapdata_struct *size_buff = NULL;
+	InquiryData_struct *inq_buff = NULL;
+	unsigned int block_size;
+	unsigned int total_size;
+	unsigned long flags = 0;
+	int ret = 0;
+
+	/* if the disk already exists then deregister it before proceeding*/
+	if (h->drv[drv_index].raid_level != -1){
+		spin_lock_irqsave(CCISS_LOCK(h->ctlr), flags);
+		h->drv[drv_index].busy_configuring = 1;
+		spin_unlock_irqrestore(CCISS_LOCK(h->ctlr), flags);
+		ret = deregister_disk(h->gendisk[drv_index], 
+			&h->drv[drv_index], 0);
+		h->drv[drv_index].busy_configuring = 0;
+	}
+
+	/* If the disk is in use return */
+	if (ret)
+		return;
+	
+
+	/* Get information about the disk and modify the driver sturcture */
+	size_buff = kmalloc(sizeof( ReadCapdata_struct), GFP_KERNEL);
+        if (size_buff == NULL)
+		goto mem_msg;
+	inq_buff = kmalloc(sizeof( InquiryData_struct), GFP_KERNEL);
+	if (inq_buff == NULL)
+		goto mem_msg;
+
+	cciss_read_capacity(ctlr, drv_index, size_buff, 1,
+		&total_size, &block_size);
+	cciss_geometry_inquiry(ctlr, drv_index, 1, total_size, block_size,
+		inq_buff, &h->drv[drv_index]);
+
+	++h->num_luns;
+	disk = h->gendisk[drv_index];
+	set_capacity(disk, h->drv[drv_index].nr_blocks);
+
+	
+	/* if it's the controller it's already added */
+	if (drv_index){
+		disk->queue = blk_init_queue(do_cciss_request, &h->lock);
+
+		/* Set up queue information */
+		disk->queue->backing_dev_info.ra_pages = READ_AHEAD;
+		blk_queue_bounce_limit(disk->queue, hba[ctlr]->pdev->dma_mask);
+
+		/* This is a hardware imposed limit. */
+		blk_queue_max_hw_segments(disk->queue, MAXSGENTRIES);
+
+		/* This is a limit in the driver and could be eliminated. */
+		blk_queue_max_phys_segments(disk->queue, MAXSGENTRIES);
+
+		blk_queue_max_sectors(disk->queue, 512);
+
+		disk->queue->queuedata = hba[ctlr];
+
+		blk_queue_hardsect_size(disk->queue, 
+			hba[ctlr]->drv[drv_index].block_size);
+		
+		h->drv[drv_index].queue = disk->queue;
+		add_disk(disk);
+	}
+
+freeret:
+	kfree(size_buff);
+	kfree(inq_buff);
+	return;
+mem_msg:
+	printk(KERN_ERR "cciss: out of memory\n");
+	goto freeret;
+}
+
+/* This function will find the first index of the controllers drive array
+ * that has a -1 for the raid_level and will return that index.  This is
+ * where new drives will be added.  If the index to be returned is greater
+ * than the highest_lun index for the controller then highest_lun is set
+ * to this new index.  If there are no available indexes then -1 is returned.
+*/
+static int cciss_find_free_drive_index(int ctlr)
+{
+	int i;
+
+	for (i=0; i < CISS_MAX_LUN; i++){
+		if (hba[ctlr]->drv[i].raid_level == -1){
+			if (i > hba[ctlr]->highest_lun)
+				hba[ctlr]->highest_lun = i;
+			return i;
+		}
+	}
+	return -1;
+}
+
+/* This function will add and remove logical drives from the Logical
+ * drive array of the controller and maintain persistancy of ordering
+ * so that mount points are preserved until the next reboot.  This allows
+ * for the removal of logical drives in the middle of the drive array
+ * without a re-ordering of those drives.
+ * INPUT
+ * h		= The controller to perform the operations on
+ * del_disk	= The disk to remove if specified.  If the value given
+ *		  is NULL then no disk is removed.
+*/
+static int rebuild_lun_table(ctlr_info_t *h, struct gendisk *del_disk)
 {
+	int ctlr = h->ctlr;
+	int num_luns;
+	ReportLunData_struct *ld_buff = NULL;
+	drive_info_struct *drv = NULL;
+	int return_code;
+	int listlength = 0;
+	int i;
+	int drv_found;
+	int drv_index = 0;
+	__u32 lunid = 0;
 	unsigned long flags;
+
+	/* Set busy_configuring flag for this operation */
+	spin_lock_irqsave(CCISS_LOCK(h->ctlr), flags);
+	if (h->num_luns >= CISS_MAX_LUN){
+		spin_unlock_irqrestore(CCISS_LOCK(h->ctlr), flags);
+		return -EINVAL;
+	}
+
+	if (h->busy_configuring){
+		spin_unlock_irqrestore(CCISS_LOCK(h->ctlr), flags);
+		return -EBUSY;
+	}
+	h->busy_configuring = 1;
+
+	/* if del_disk is NULL then we are being called to add a new disk
+	 * and update the logical drive table.  If it is not NULL then
+	 * we will check if the disk is in use or not.
+	 */
+	if (del_disk != NULL){
+		drv = get_drv(del_disk);
+		drv->busy_configuring = 1;
+		spin_unlock_irqrestore(CCISS_LOCK(h->ctlr), flags);
+		return_code = deregister_disk(del_disk, drv, 1);
+		drv->busy_configuring = 0;
+		h->busy_configuring = 0;
+		return return_code;
+	} else {
+		spin_unlock_irqrestore(CCISS_LOCK(h->ctlr), flags);
+		if (!capable(CAP_SYS_RAWIO))
+			return -EPERM;
+
+		ld_buff = kzmalloc(sizeof(ReportLunData_struct), GFP_KERNEL);
+		if (ld_buff == NULL)
+			goto mem_msg;
+
+		return_code = sendcmd_withirq(CISS_REPORT_LOG, ctlr, ld_buff,
+				sizeof(ReportLunData_struct), 0, 0, 0,
+				TYPE_CMD);
+
+		if (return_code == IO_OK){
+			listlength |= (0xff & (unsigned int)(ld_buff->LUNListLength[0])) << 24;
+			listlength |= (0xff & (unsigned int)(ld_buff->LUNListLength[1])) << 16;
+			listlength |= (0xff & (unsigned int)(ld_buff->LUNListLength[2])) << 8;	
+			listlength |= 0xff & (unsigned int)(ld_buff->LUNListLength[3]);
+		} else{ /* reading number of logical volumes failed */
+			printk(KERN_WARNING "cciss: report logical volume"
+				" command failed\n");
+			listlength = 0;
+			goto freeret;
+		}
+
+		num_luns = listlength / 8;	/* 8 bytes per entry */
+		if (num_luns > CISS_MAX_LUN){
+			num_luns = CISS_MAX_LUN;
+			printk(KERN_WARNING "cciss: more luns configured"
+				" on controller than can be handled by"
+				" this driver.\n");
+		}
+
+		/* Compare controller drive array to drivers drive array.
+	 	* Check for updates in the drive information and any new drives
+	 	* on the controller.
+	 	*/
+		for (i=0; i < num_luns; i++){
+			int j;
+
+			drv_found = 0;
+
+	  		lunid = (0xff & 
+				(unsigned int)(ld_buff->LUN[i][3])) << 24;
+        		lunid |= (0xff & 
+				(unsigned int)(ld_buff->LUN[i][2])) << 16;
+        		lunid |= (0xff & 
+				(unsigned int)(ld_buff->LUN[i][1])) << 8;
+        		lunid |= 0xff & 
+				(unsigned int)(ld_buff->LUN[i][0]);
+
+			/* Find if the LUN is already in the drive array
+			 * of the controller.  If so then update its info
+			 * if not is use.  If it does not exist then find
+			 * the first free index and add it.
+			*/
+			for (j=0; j <= h->highest_lun; j++){
+				if (h->drv[j].LunID == lunid){
+					drv_index = j;
+					drv_found = 1;
+				}
+			}
+		
+			/* check if the drive was found already in the array */
+			if (!drv_found){
+				drv_index = cciss_find_free_drive_index(ctlr);
+				if (drv_index == -1)
+					goto freeret;
+
+			}
+			h->drv[drv_index].LunID = lunid;
+			cciss_update_drive_info(ctlr, drv_index);
+		} /* end for */
+	} /* end else */
+
+freeret:
+	kfree(ld_buff);
+	h->busy_configuring = 0;
+	/* We return -1 here to tell the ACU that we have registered/updated
+	 * all of the drives that we can and to keep it from calling us 
+	 * additional times.
+	*/
+	return -1;
+mem_msg:
+	printk(KERN_ERR "cciss: out of memory\n");
+	goto freeret;
+}
+
+/* This function will deregister the disk and it's queue from the
+ * kernel.  It must be called with the controller lock held and the
+ * drv structures busy_configuring flag set.  It's parameters are:
+ * 
+ * disk = This is the disk to be deregistered
+ * drv  = This is the drive_info_struct associated with the disk to be
+ *        deregistered.  It contains information about the disk used 
+ *        by the driver.
+ * clear_all = This flag determines whether or not the disk information
+ *             is going to be completely cleared out and the highest_lun
+ *             reset.  Sometimes we want to clear out information about
+ *             the disk in preperation for re-adding it.  In this case
+ *             the highest_lun should be left unchanged and the LunID
+ *             should not be cleared.
+*/
+static int deregister_disk(struct gendisk *disk, drive_info_struct *drv,
+			   int clear_all)
+{
 	ctlr_info_t *h = get_host(disk);
-	drive_info_struct *drv = get_drv(disk);
-	int ctlr = h->ctlr;
 
 	if (!capable(CAP_SYS_RAWIO))
 		return -EPERM;
 
-	spin_lock_irqsave(CCISS_LOCK(ctlr), flags);
 	/* make sure logical volume is NOT is use */
-	if( drv->usage_count > 1) {
-		spin_unlock_irqrestore(CCISS_LOCK(ctlr), flags);
+	if(clear_all || (h->gendisk[0] == disk)) {
+	if (drv->usage_count > 1)
                 return -EBUSY;
 	}
-	drv->usage_count++;
-	spin_unlock_irqrestore(CCISS_LOCK(ctlr), flags);
+        else
+        	if( drv->usage_count > 0 )
+                	return -EBUSY;
 
-	/* invalidate the devices and deregister the disk */ 
-	if (disk->flags & GENHD_FL_UP)
+	/* invalidate the devices and deregister the disk.  If it is disk
+	 * zero do not deregister it but just zero out it's values.  This
+	 * allows us to delete disk zero but keep the controller registered.
+	*/
+	if (h->gendisk[0] != disk){
+		if (disk->flags & GENHD_FL_UP){
+			blk_cleanup_queue(disk->queue);
 		del_gendisk(disk);
+			drv->queue = NULL;
+		}
+	}
+
+	--h->num_luns;
+	/* zero out the disk size info */ 
+	drv->nr_blocks = 0;
+	drv->block_size = 0;
+	drv->heads = 0;
+	drv->sectors = 0;
+	drv->cylinders = 0;
+	drv->raid_level = -1;	/* This can be used as a flag variable to
+				 * indicate that this element of the drive
+				 * array is free.
+				*/
+
+	if (clear_all){
 	/* check to see if it was the last disk */
 	if (drv == h->drv + h->highest_lun) {
 		/* if so, find the new hightest lun */
 		int i, newhighest =-1;
 		for(i=0; i<h->highest_lun; i++) {
 			/* if the disk has size > 0, it is available */
-			if (h->drv[i].nr_blocks)
+				if (h->drv[i].heads)
 				newhighest = i;
 		}
 		h->highest_lun = newhighest;
-				
 	}
-	--h->num_luns;
-	/* zero out the disk size info */ 
-	drv->nr_blocks = 0;
-	drv->block_size = 0;
-	drv->cylinders = 0;
+
 	drv->LunID = 0;
+	}
 	return(0);
 }
+
 static int fill_cmd(CommandList_struct *c, __u8 cmd, int ctlr, void *buff,
 	size_t size,
 	unsigned int use_unit_num, /* 0: address the controller,
@@ -1513,164 +1799,6 @@ cciss_read_capacity(int ctlr, int logvol
 	return;
 }
 
-static int register_new_disk(ctlr_info_t *h)
-{
-        struct gendisk *disk;
-	int ctlr = h->ctlr;
-        int i;
-	int num_luns;
-	int logvol;
-	int new_lun_found = 0;
-	int new_lun_index = 0;
-	int free_index_found = 0;
-	int free_index = 0;
-	ReportLunData_struct *ld_buff = NULL;
-	ReadCapdata_struct *size_buff = NULL;
-	InquiryData_struct *inq_buff = NULL;
-	int return_code;
-	int listlength = 0;
-	__u32 lunid = 0;
-	unsigned int block_size;
-	unsigned int total_size;
-
-        if (!capable(CAP_SYS_RAWIO))
-                return -EPERM;
-	/* if we have no space in our disk array left to add anything */
-	if(  h->num_luns >= CISS_MAX_LUN)
-		return -EINVAL;
-	
-	ld_buff = kmalloc(sizeof(ReportLunData_struct), GFP_KERNEL);
-	if (ld_buff == NULL)
-		goto mem_msg;
-	memset(ld_buff, 0, sizeof(ReportLunData_struct));
-	size_buff = kmalloc(sizeof( ReadCapdata_struct), GFP_KERNEL);
-        if (size_buff == NULL)
-		goto mem_msg;
-	inq_buff = kmalloc(sizeof( InquiryData_struct), GFP_KERNEL);
-        if (inq_buff == NULL)
-		goto mem_msg;
-	
-	return_code = sendcmd_withirq(CISS_REPORT_LOG, ctlr, ld_buff, 
-			sizeof(ReportLunData_struct), 0, 0, 0, TYPE_CMD);
-
-	if( return_code == IO_OK)
-	{
-		
-		// printk("LUN Data\n--------------------------\n");
-
-		listlength |= (0xff & (unsigned int)(ld_buff->LUNListLength[0])) << 24;
-		listlength |= (0xff & (unsigned int)(ld_buff->LUNListLength[1])) << 16;
-		listlength |= (0xff & (unsigned int)(ld_buff->LUNListLength[2])) << 8;	
-		listlength |= 0xff & (unsigned int)(ld_buff->LUNListLength[3]);
-	} else /* reading number of logical volumes failed */
-	{
-		printk(KERN_WARNING "cciss: report logical volume"
-			" command failed\n");
-		listlength = 0;
-		goto free_err;
-	}
-	num_luns = listlength / 8; // 8 bytes pre entry
-	if (num_luns > CISS_MAX_LUN)
-	{
-		num_luns = CISS_MAX_LUN;
-	}
-#ifdef CCISS_DEBUG
-	printk(KERN_DEBUG "Length = %x %x %x %x = %d\n", ld_buff->LUNListLength[0],
-		ld_buff->LUNListLength[1], ld_buff->LUNListLength[2],
-		ld_buff->LUNListLength[3],  num_luns);
-#endif 
-	for(i=0; i<  num_luns; i++)
-	{
-		int j;
-		int lunID_found = 0;
-
-	  	lunid = (0xff & (unsigned int)(ld_buff->LUN[i][3])) << 24;
-        	lunid |= (0xff & (unsigned int)(ld_buff->LUN[i][2])) << 16;
-        	lunid |= (0xff & (unsigned int)(ld_buff->LUN[i][1])) << 8;
-        	lunid |= 0xff & (unsigned int)(ld_buff->LUN[i][0]);
-		
- 		/* check to see if this is a new lun */ 
-		for(j=0; j <= h->highest_lun; j++)
-		{
-#ifdef CCISS_DEBUG
-			printk("Checking %d %x against %x\n", j,h->drv[j].LunID,
-						lunid);
-#endif /* CCISS_DEBUG */
-			if (h->drv[j].LunID == lunid)
-			{
-				lunID_found = 1;
-				break;
-			}
-			
-		}
-		if( lunID_found == 1)
-			continue;
-		else
-		{	/* It is the new lun we have been looking for */
-#ifdef CCISS_DEBUG
-			printk("new lun found at %d\n", i);
-#endif /* CCISS_DEBUG */
-			new_lun_index = i;
-			new_lun_found = 1;
-			break;	
-		}
-	 }
-	 if (!new_lun_found)
-	 {
-		printk(KERN_WARNING "cciss:  New Logical Volume not found\n");
-		goto free_err;
-	 }
-	 /* Now find the free index 	*/
-	for(i=0; i <CISS_MAX_LUN; i++)
-	{
-#ifdef CCISS_DEBUG
-		printk("Checking Index %d\n", i);
-#endif /* CCISS_DEBUG */
-		if(h->drv[i].LunID == 0)
-		{
-#ifdef CCISS_DEBUG
-			printk("free index found at %d\n", i);
-#endif /* CCISS_DEBUG */
-			free_index_found = 1;
-			free_index = i;
-			break;
-		}
-	}
-	if (!free_index_found)
-	{
-		printk(KERN_WARNING "cciss: unable to find free slot for disk\n");
-		goto free_err;
-         }
-
-	logvol = free_index;
-	h->drv[logvol].LunID = lunid;
-		/* there could be gaps in lun numbers, track hightest */
-	if(h->highest_lun < lunid)
-		h->highest_lun = logvol;
-	cciss_read_capacity(ctlr, logvol, size_buff, 1,
-		&total_size, &block_size);
-	cciss_geometry_inquiry(ctlr, logvol, 1, total_size, block_size,
-			inq_buff, &h->drv[logvol]);
-	h->drv[logvol].usage_count = 0;
-	++h->num_luns;
-	/* setup partitions per disk */
-        disk = h->gendisk[logvol];
-	set_capacity(disk, h->drv[logvol].nr_blocks);
-	/* if it's the controller it's already added */
-	if(logvol)
-		add_disk(disk);
-freeret:
-	kfree(ld_buff);
-	kfree(size_buff);
-	kfree(inq_buff);
-	return (logvol);
-mem_msg:
-	printk(KERN_ERR "cciss: out of memory\n");
-free_err:
-	logvol = -1;
-	goto freeret;
-}
-
 static int cciss_revalidate(struct gendisk *disk)
 {
 	ctlr_info_t *h = get_host(disk);
@@ -2653,12 +2781,16 @@ static void cciss_getgeometry(int cntl_n
 #endif /* CCISS_DEBUG */
 
 	hba[cntl_num]->highest_lun = hba[cntl_num]->num_luns-1;
-	for(i=0; i<  hba[cntl_num]->num_luns; i++)
+//	for(i=0; i<  hba[cntl_num]->num_luns; i++)
+	for(i=0; i < CISS_MAX_LUN; i++)
 	{
-
-	  	lunid = (0xff & (unsigned int)(ld_buff->LUN[i][3])) << 24;
-        	lunid |= (0xff & (unsigned int)(ld_buff->LUN[i][2])) << 16;
-        	lunid |= (0xff & (unsigned int)(ld_buff->LUN[i][1])) << 8;
+		if (i < hba[cntl_num]->num_luns){
+		  	lunid = (0xff & (unsigned int)(ld_buff->LUN[i][3]))
+				 << 24;
+        		lunid |= (0xff & (unsigned int)(ld_buff->LUN[i][2]))
+				 << 16;
+        		lunid |= (0xff & (unsigned int)(ld_buff->LUN[i][1]))
+				 << 8;
         	lunid |= 0xff & (unsigned int)(ld_buff->LUN[i][0]);
 		
 		hba[cntl_num]->drv[i].LunID = lunid;
@@ -2666,13 +2798,18 @@ static void cciss_getgeometry(int cntl_n
 
 #ifdef CCISS_DEBUG
 	  	printk(KERN_DEBUG "LUN[%d]:  %x %x %x %x = %x\n", i, 
-		ld_buff->LUN[i][0], ld_buff->LUN[i][1],ld_buff->LUN[i][2], 
-		ld_buff->LUN[i][3], hba[cntl_num]->drv[i].LunID);
+			ld_buff->LUN[i][0], ld_buff->LUN[i][1],
+			ld_buff->LUN[i][2], ld_buff->LUN[i][3], 
+			hba[cntl_num]->drv[i].LunID);
 #endif /* CCISS_DEBUG */
 		cciss_read_capacity(cntl_num, i, size_buff, 0,
 			&total_size, &block_size);
-		cciss_geometry_inquiry(cntl_num, i, 0, total_size, block_size,
-			inq_buff, &hba[cntl_num]->drv[i]);
+			cciss_geometry_inquiry(cntl_num, i, 0, total_size, 
+				block_size, inq_buff, &hba[cntl_num]->drv[i]);
+		} else {
+			/* initialize raid_level to indicate a free space */
+			hba[cntl_num]->drv[i].raid_level = -1;
+		}
 	}
 	kfree(ld_buff);
 	kfree(size_buff);
diff -burNp lx2613-p002/drivers/block/cciss.h lx2613-p003/drivers/block/cciss.h
--- lx2613-p002/drivers/block/cciss.h	2005-09-12 09:19:31.090301288 -0500
+++ lx2613-p003/drivers/block/cciss.h	2005-09-12 09:08:50.456692400 -0500
@@ -35,7 +35,13 @@ typedef struct _drive_info_struct
 	int 	heads;
 	int	sectors;
 	int 	cylinders;
-	int	raid_level;
+	int	raid_level; /* set to -1 to indicate that 
+			     * the drive is not in use/configured
+			    */
+	int	busy_configuring; /*This is set when the drive is being removed
+				   *to prevent it from being opened or it's queue
+				   *from being started.
+				  */
 } drive_info_struct;
 
 struct ctlr_info 
