Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264369AbUDSLjQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 07:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264372AbUDSLjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 07:39:15 -0400
Received: from mx2.redhat.com ([66.187.237.31]:37293 "EHLO mx2.redhat.com")
	by vger.kernel.org with ESMTP id S264369AbUDSLhq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 07:37:46 -0400
Message-ID: <4083BA03.1090606@redhat.com>
Date: Mon, 19 Apr 2004 01:37:39 -1000
From: Warren Togami <wtogami@redhat.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040418)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>,
       Alan Cox <alan@redhat.com>
Subject: [PATCH] i2o_block Fix, possible CFQ elevator problem?
Content-Type: multipart/mixed;
 boundary="------------000303010908020805090400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000303010908020805090400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Test Systems:
x86 AMD Duron with PM3754 DPT controller, Two disks
x86-64 2x Opteron with ASR-3010S Adaptec controller, Four disks

Software:
Gentoo 1.4.3.13 x86 with gcc-3.3.2
Fedora Core 2 x86-64 development with gcc-3.3.3-7

The i2o_block driver currently in kernel-2.6.5 has a problem when there
is more than one logical block device on the I2O controller. Two or
more devices causes kernel memory corruption,[1] sometimes accompanied
by an oops, sometimes fatally in IRQ context and livelocks. In SMP mode
this tended to cause panic=5 reboot to fail.

http://lwn.net/Articles/58199/
Markus finally figured out what was going wrong when he read in this LWN
article that in the 2.6 kernel, the generic block layer handles
partition code and there is almost nothing the individual drivers have
to do. The attached patch from Markus removes this unused partition
logic and seemed to make things work extremely well.

After some testing we began to realize why the kernel memory corruption
that we saw with 2 or more block arrays was happening. The first array
always had a valid partition table, while second and more arrays never
did after they were split from the original single large array. The
unused partition logic was copying the corrupted partition table from
the 2nd and higher arrays into kernel memory, causing the trouble in
kernel-2.6.5.

Subsequent testing was going extremely well, with simultaneous heavy
disk usage on two I2O block devices with bonnie++ going stable. We then
chopped the controller into four I2O block devices, but unfortunately
this ran us into trouble. bonnie++ on three devices simultaneously
would panic. Below is a photo of the call trace from this panic.

http://togami.com/~warren/archive/2004/i2o_cfq_quad_bonnie.jpg

I noticed that the call trace contained "cfq_next_request", so I was
curious what would happened if we changed to the deadline scheduler.
Booted with the same kernel but with "elevator=deadline". To our
surprise, bonnie++ ran simultaneously on all four I2O block devices
without crashing the server. For another test we tried "elevator=as"
and it too remained stable.

Possible CFQ I/O scheduler problem?

This research has been a joint venture of Markus Lidel and Warren
Togami, with thanks to Mid-Pacific Institute for the loan of hardware.

Warren Togami
wtogami@redhat.com
Markus Lidel
Markus.Lidel@shadowconnect.com

[1]
With two block arrays, ls in the filesystem would sometimes have
corrupted looking characters as the directories and files, making the
system unusable. With four block arrays this happened, also with an
accompanying kernel oops.

--------------000303010908020805090400
Content-Type: text/x-patch;
 name="i2o_block-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2o_block-cleanup.patch"

--- i2o_block.c	2004-04-16 10:56:37.000000000 -1000
+++ i2o_block.c.new	2004-04-17 04:14:05.459068416 -1000
@@ -117,9 +117,6 @@
  *	Some of these can be made smaller later
  */
 
-static int i2ob_media_change_flag[MAX_I2OB];
-static u32 i2ob_max_sectors[MAX_I2OB<<4];
-
 static int i2ob_context;
 
 /*
@@ -143,6 +140,8 @@
 	int wcache;
 	int power;
 	int index;
+	int media_change_flag;
+	u32 max_sectors;
 };
 
 /*
@@ -162,9 +161,9 @@
 };
 
 /*
- * Per IOP requst queue information
+ * Per IOP request queue information
  *
- * We have a separate requeust_queue_t per IOP so that a heavilly
+ * We have a separate request_queue_t per IOP so that a heavilly
  * loaded I2O block device on an IOP does not starve block devices
  * across all I2O controllers.
  * 
@@ -183,7 +182,7 @@
  *	Each I2O disk is one of these.
  */
 
-static struct i2ob_device i2ob_dev[MAX_I2OB<<4];
+static struct i2ob_device i2ob_dev[MAX_I2OB];
 static int i2ob_dev_count = 0;
 static struct gendisk *i2ob_disk[MAX_I2OB];
 
@@ -312,7 +311,6 @@
 	/* 
 	 * Mask out partitions from now on
 	 */
-	unit &= 0xF0;
 		
 	/* This can be optimised later - just want to be sure its right for
 	   starters */
@@ -453,8 +451,8 @@
 	struct i2ob_request *ireq = NULL;
 	u8 st;
 	u32 *m = (u32 *)msg;
-	u8 unit = (m[2]>>8)&0xF0;	/* low 4 bits are partition */
-	struct i2ob_device *dev = &i2ob_dev[(unit&0xF0)];
+	u8 unit = m[2]>>8;
+	struct i2ob_device *dev = &i2ob_dev[unit];
 
 	/*
 	 * FAILed message
@@ -599,7 +597,6 @@
 	unsigned int evt;
 	unsigned long flags;
 	int unit;
-	int i;
 	//The only event that has data is the SCSI_SMART event.
 	struct i2o_reply {
 		u32 header[4];
@@ -648,7 +645,7 @@
 			 */
 			case I2O_EVT_IND_BSA_VOLUME_LOAD:
 			{
-				struct gendisk *p = i2ob_disk[unit>>4];
+				struct gendisk *p = i2ob_disk[unit];
 				i2ob_install_device(i2ob_dev[unit].i2odev->controller, 
 					i2ob_dev[unit].i2odev, unit);
 				add_disk(p);
@@ -663,11 +660,10 @@
 			 */
 			case I2O_EVT_IND_BSA_VOLUME_UNLOAD:
 			{
-				struct gendisk *p = i2ob_disk[unit>>4];
+				struct gendisk *p = i2ob_disk[unit];
 				del_gendisk(p);
-				for(i = unit; i <= unit+15; i++)
-					blk_queue_max_sectors(i2ob_dev[i].req_queue, 0);
-				i2ob_media_change_flag[unit] = 1;
+				blk_queue_max_sectors(i2ob_dev[unit].req_queue, 0);
+				i2ob_dev[unit].media_change_flag = 1;
 				break;
 			}
 
@@ -695,7 +691,7 @@
 					i2ob_query_device(&i2ob_dev[unit], 0x0000, 4, &size, 8);
 
 				spin_lock_irqsave(I2O_LOCK(unit), flags);	
-				set_capacity(i2ob_disk[unit>>4], size>>9);
+				set_capacity(i2ob_disk[unit], size>>9);
 				spin_unlock_irqrestore(I2O_LOCK(unit), flags);	
 				break;
 			}
@@ -803,7 +799,7 @@
 		i2ob_queues[dev->unit]->i2ob_qhead = ireq->next;
 		ireq->req = req;
 
-		i2ob_send(m, dev, ireq, (dev->unit&0xF0));
+		i2ob_send(m, dev, ireq, dev->index);
 	}
 }
 
@@ -1065,7 +1061,8 @@
 	u16 power;
 	u32 flags, status;
 	struct i2ob_device *dev=&i2ob_dev[unit];
-	int i;
+	request_queue_t *q;
+	int segments;
 
 	/*
 	 * For logging purposes...
@@ -1089,11 +1086,11 @@
 	 * code so that we can directly get the queue ptr from the
 	 * device instead of having to go the IOP data structure.
 	 */
-	dev->req_queue = i2ob_queues[unit]->req_queue;
+	dev->req_queue = i2ob_queues[c->unit]->req_queue;
 
 	/* initialize gendik structure */
-	i2ob_disk[unit>>4]->private_data = dev;
-	i2ob_disk[unit>>4]->queue = dev->req_queue;
+	i2ob_disk[unit]->private_data = dev;
+	i2ob_disk[unit]->queue = dev->req_queue;
 
 	/*
 	 *	Ask for the current media data. If that isn't supported
@@ -1110,7 +1107,7 @@
 		power = 0;
 	i2ob_query_device(dev, 0x0000, 5, &flags, 4);
 	i2ob_query_device(dev, 0x0000, 6, &status, 4);
-	set_capacity(i2ob_disk[unit>>4], size>>9);
+	set_capacity(i2ob_disk[unit], size>>9);
 
 	/*
 	 * Max number of Scatter-Gather Elements
@@ -1119,44 +1116,41 @@
 	i2ob_dev[unit].power = power;	/* Save power state in device proper */
 	i2ob_dev[unit].flags = flags;
 
-	for(i=unit;i<=unit+15;i++)
-	{
-		request_queue_t *q = i2ob_dev[unit].req_queue;
-		int segments = (d->controller->status_block->inbound_frame_size - 7) / 2;
+	q = i2ob_dev[unit].req_queue;
+	segments = (d->controller->status_block->inbound_frame_size - 7) / 2;
 
-		if(segments > 16)
-			segments = 16;
-					
-		i2ob_dev[i].power = power;	/* Save power state */
-		i2ob_dev[unit].flags = flags;	/* Keep the type info */
+	if(segments > 16)
+		segments = 16;
+				
+	i2ob_dev[unit].power = power;	/* Save power state */
+	i2ob_dev[unit].flags = flags;	/* Keep the type info */
 		
-		blk_queue_max_sectors(q, 96);	/* 256 might be nicer but many controllers 
+	blk_queue_max_sectors(q, 96);	/* 256 might be nicer but many controllers 
 						   explode on 65536 or higher */
-		blk_queue_max_phys_segments(q, segments);
-		blk_queue_max_hw_segments(q, segments);
+	blk_queue_max_phys_segments(q, segments);
+	blk_queue_max_hw_segments(q, segments);
 		
-		i2ob_dev[i].rcache = CACHE_SMARTFETCH;
-		i2ob_dev[i].wcache = CACHE_WRITETHROUGH;
+	i2ob_dev[unit].rcache = CACHE_SMARTFETCH;
+	i2ob_dev[unit].wcache = CACHE_WRITETHROUGH;
 		
-		if(d->controller->battery == 0)
-			i2ob_dev[i].wcache = CACHE_WRITETHROUGH;
+	if(d->controller->battery == 0)
+		i2ob_dev[unit].wcache = CACHE_WRITETHROUGH;
 
-		if(d->controller->promise)
-			i2ob_dev[i].wcache = CACHE_WRITETHROUGH;
+	if(d->controller->promise)
+		i2ob_dev[unit].wcache = CACHE_WRITETHROUGH;
 
-		if(d->controller->short_req)
-		{
-			blk_queue_max_sectors(q, 8);
-			blk_queue_max_phys_segments(q, 8);
-			blk_queue_max_hw_segments(q, 8);
-		}
+	if(d->controller->short_req)
+	{
+		blk_queue_max_sectors(q, 8);
+		blk_queue_max_phys_segments(q, 8);
+		blk_queue_max_hw_segments(q, 8);
 	}
 
-	strcpy(d->dev_name, i2ob_disk[unit>>4]->disk_name);
-	strcpy(i2ob_disk[unit>>4]->devfs_name, i2ob_disk[unit>>4]->disk_name);
+	strcpy(d->dev_name, i2ob_disk[unit]->disk_name);
+	strcpy(i2ob_disk[unit]->devfs_name, i2ob_disk[unit]->disk_name);
 
 	printk(KERN_INFO "%s: Max segments %d, queue depth %d, byte limit %d.\n",
-		 d->dev_name, i2ob_dev[unit].max_segments, i2ob_dev[unit].depth, i2ob_max_sectors[unit]<<9);
+		 d->dev_name, i2ob_dev[unit].max_segments, i2ob_dev[unit].depth, i2ob_dev[unit].max_sectors<<9);
 
 	i2ob_query_device(dev, 0x0000, 0, &type, 1);
 
@@ -1197,7 +1191,7 @@
 	}
 	printk(".\n");
 	printk(KERN_INFO "%s: Maximum sectors/read set to %d.\n", 
-		d->dev_name, i2ob_max_sectors[unit]);
+		d->dev_name, i2ob_dev[unit].max_sectors);
 
 	/*
 	 * Register for the events we're interested in and that the
@@ -1323,7 +1317,7 @@
 
 			i2o_release_device(d, &i2o_block_handler);
 
-			if(scan_unit<MAX_I2OB<<4)
+			if(scan_unit<MAX_I2OB)
 			{
  				/*
 				 * Get the device and fill in the
@@ -1339,8 +1333,8 @@
 					printk(KERN_WARNING "Could not install I2O block device\n");
 				else
 				{
-					add_disk(i2ob_disk[scan_unit>>4]);
-					scan_unit+=16;
+					add_disk(i2ob_disk[scan_unit]);
+					scan_unit++;
 					i2ob_dev_count++;
 
 					/* We want to know when device goes away */
@@ -1350,7 +1344,7 @@
 			else
 			{
 				if(!warned++)
-					printk(KERN_WARNING "i2o_block: too many device, registering only %d.\n", scan_unit>>4);
+					printk(KERN_WARNING "i2o_block: too many device, registering only %d.\n", scan_unit);
 			}
 		}
 		i2o_unlock_controller(c);
@@ -1399,12 +1393,12 @@
 	printk(KERN_INFO "   Controller %d Tid %d\n",c->unit, d->lct_data.tid);
 
 	/* Check for available space */
-	if(i2ob_dev_count>=MAX_I2OB<<4)
+	if(i2ob_dev_count>=MAX_I2OB)
 	{
 		printk(KERN_ERR "i2o_block: No more devices allowed!\n");
 		return;
 	}
-	for(unit = 0; unit < (MAX_I2OB<<4); unit += 16)
+	for(unit = 0; unit < MAX_I2OB; unit ++)
 	{
 		if(!i2ob_dev[unit].i2odev)
 			break;
@@ -1425,7 +1419,7 @@
 		printk(KERN_ERR "i2o_block: Could not install new device\n");
 	else	
 	{
-		add_disk(i2ob_disk[unit>>4]);
+		add_disk(i2ob_disk[unit]);
 		i2ob_dev_count++;
 		i2o_device_notify_on(d, &i2o_block_handler);
 	}
@@ -1443,7 +1437,6 @@
 void i2ob_del_device(struct i2o_controller *c, struct i2o_device *d)
 {	
 	int unit = 0;
-	int i = 0;
 	unsigned long flags;
 
 	spin_lock_irqsave(I2O_LOCK(c->unit), flags);
@@ -1456,7 +1449,7 @@
 
 	printk(KERN_INFO "I2O Block Device Deleted\n");
 
-	for(unit = 0; unit < MAX_I2OB<<4; unit += 16)
+	for(unit = 0; unit < MAX_I2OB; unit ++)
 	{
 		if(i2ob_dev[unit].i2odev == d)
 		{
@@ -1465,7 +1458,7 @@
 			break;
 		}
 	}
-	if(unit >= MAX_I2OB<<4)
+	if(unit >= MAX_I2OB)
 	{
 		printk(KERN_ERR "i2ob_del_device called, but not in dev table!\n");
 		spin_unlock_irqrestore(I2O_LOCK(c->unit), flags);
@@ -1476,13 +1469,10 @@
 	 * This will force errors when i2ob_get_queue() is called
 	 * by the kenrel.
 	 */
-	del_gendisk(i2ob_disk[unit>>4]);
+	del_gendisk(i2ob_disk[unit]);
 	i2ob_dev[unit].req_queue = NULL;
-	for(i = unit; i <= unit+15; i++)
-	{
-		i2ob_dev[i].i2odev = NULL;
-		blk_queue_max_sectors(i2ob_dev[i].req_queue, 0);
-	}
+	i2ob_dev[unit].i2odev = NULL;
+	blk_queue_max_sectors(i2ob_dev[unit].req_queue, 0);
 	spin_unlock_irqrestore(I2O_LOCK(c->unit), flags);
 
 	/*
@@ -1493,14 +1483,13 @@
 		MOD_DEC_USE_COUNT;
 
 	i2ob_dev[unit].refcnt = 0;
-	
-	i2ob_dev[i].tid = 0;
+	i2ob_dev[unit].tid = 0;
 
 	/* 
 	 * Do we need this?
 	 * The media didn't really change...the device is just gone
 	 */
-	i2ob_media_change_flag[unit] = 1;
+	i2ob_dev[unit].media_change_flag = 1;
 
 	i2ob_dev_count--;	
 }
@@ -1511,10 +1500,9 @@
 static int i2ob_media_change(struct gendisk *disk)
 {
 	struct i2ob_device *p = disk->private_data;
-	int i = p->index;
-	if(i2ob_media_change_flag[i])
+	if(p->media_change_flag)
 	{
-		i2ob_media_change_flag[i]=0;
+		p->media_change_flag=0;
 		return 1;
 	}
 	return 0;
@@ -1523,7 +1511,7 @@
 static int i2ob_revalidate(struct gendisk *disk)
 {
 	struct i2ob_device *p = disk->private_data;
-	return i2ob_install_device(p->controller, p->i2odev, p->index<<4);
+	return i2ob_install_device(p->controller, p->i2odev, p->index);
 }
 
 /*
@@ -1536,7 +1524,7 @@
 	
 	for(i=0;i<MAX_I2OB;i++)
 	{
-		struct i2ob_device *dev=&i2ob_dev[(i<<4)];
+		struct i2ob_device *dev=&i2ob_dev[i];
 		
 		if(dev->refcnt!=0)
 		{
@@ -1598,23 +1586,35 @@
 	if (register_blkdev(MAJOR_NR, "i2o_block"))
 		return -EIO;
 
-	for (i = 0; i < MAX_I2OB; i++) {
-		struct gendisk *disk = alloc_disk(16);
-		if (!disk)
-			goto oom;
-		i2ob_dev[i<<4].index = i;
-		disk->queue = i2ob_dev[i<<4].req_queue;
-		i2ob_disk[i] = disk;
-	}
 #ifdef MODULE
 	printk(KERN_INFO "i2o_block: registered device at major %d\n", MAJOR_NR);
 #endif
 
 	/*
+	 *	Set up the queue
+	 */
+	for(i = 0; i < MAX_I2O_CONTROLLERS; i++)
+	{
+		i2ob_queues[i] = NULL;
+		i2ob_init_iop(i);
+	}
+
+	/*
 	 *	Now fill in the boiler plate
 	 */
 	 
-	for (i = 0; i < MAX_I2OB << 4; i++) {
+	for (i = 0; i < MAX_I2OB; i++) {
+		struct gendisk *disk = alloc_disk(16);
+		if (!disk)
+			goto oom;
+		i2ob_disk[i] = disk;
+
+		disk->major = MAJOR_NR;
+		disk->first_minor = i<<4;
+		disk->fops = &i2ob_fops;
+		sprintf(disk->disk_name, "i2o/hd%c", 'a' + i);
+
+		i2ob_dev[i].index = i;
 		i2ob_dev[i].refcnt = 0;
 		i2ob_dev[i].flags = 0;
 		i2ob_dev[i].controller = NULL;
@@ -1623,26 +1623,10 @@
 		i2ob_dev[i].head = NULL;
 		i2ob_dev[i].tail = NULL;
 		i2ob_dev[i].depth = MAX_I2OB_DEPTH;
-		i2ob_max_sectors[i] = 2;
-	}
-	
-	for (i = 0; i < MAX_I2OB; i++) {
-		struct gendisk *disk = i2ob_disk[i];
-		disk->major = MAJOR_NR;
-		disk->first_minor = i<<4;
-		disk->fops = &i2ob_fops;
-		sprintf(disk->disk_name, "i2o/hd%c", 'a' + i);
+		i2ob_dev[i].max_sectors = 2;
 	}
 	
 	/*
-	 *	Set up the queue
-	 */
-	for(i = 0; i < MAX_I2O_CONTROLLERS; i++)
-	{
-		i2ob_queues[i] = NULL;
-	}
-
-	/*
 	 *	Register the OSM handler as we will need this to probe for
 	 *	drives, geometry and other goodies.
 	 */
@@ -1701,10 +1685,10 @@
 	if(i2ob_dev_count) {
 		struct i2o_device *d;
 		for(i = 0; i < MAX_I2OB; i++)
-		if((d=i2ob_dev[i<<4].i2odev)) {
+		if((d=i2ob_dev[i].i2odev)) {
 			i2o_device_notify_off(d, &i2o_block_handler);
 			i2o_event_register(d->controller, d->lct_data.tid, 
-				i2ob_context, i<<4, 0);
+				i2ob_context, i, 0);
 		}
 	}
 	
@@ -1726,14 +1710,26 @@
 
 	i2o_remove_handler(&i2o_block_handler);
 		 
-	for (i = 0; i < MAX_I2OB; i++)
+	for (i = 0; i < MAX_I2OB; i++) {
+		struct gendisk *disk = i2ob_disk[i];
+		if(disk->flags & GENHD_FL_UP)
+			del_gendisk(i2ob_disk[i]);
 		put_disk(i2ob_disk[i]);
+	}
 
 	/*
 	 *	Return the block device
 	 */
 	if (unregister_blkdev(MAJOR_NR, "i2o_block") != 0)
 		printk("i2o_block: cleanup_module failed\n");
+
+	/*
+	 *	release request queue
+	 */
+	for (i = 0; i < MAX_I2O_CONTROLLERS; i ++) {
+		blk_cleanup_queue(i2ob_queues[i]->req_queue);
+		kfree(i2ob_queues[i]);
+	}
 }
 
 MODULE_AUTHOR("Red Hat");


--------------000303010908020805090400--
