Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264965AbUD2Ubo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264965AbUD2Ubo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 16:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264969AbUD2Ubi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 16:31:38 -0400
Received: from [213.133.118.2] ([213.133.118.2]:22929 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S264965AbUD2U2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 16:28:00 -0400
Message-ID: <40916624.3040502@shadowconnect.com>
Date: Thu, 29 Apr 2004 22:31:32 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] I2O subsystem fixing and cleanup for 2.6 - i2o_block-cleanup.patch
Content-Type: multipart/mixed;
 boundary="------------050403080302040407040903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050403080302040407040903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------050403080302040407040903
Content-Type: text/plain;
 name="i2o_block-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2o_block-cleanup.patch"

--- a/drivers/message/i2o/i2o_block.c	2004-04-03 17:37:37.000000000 -1000
+++ b/drivers/message/i2o/i2o_block.c	2004-04-23 02:13:24.132931000 -1000
@@ -83,7 +83,6 @@
 #include <asm/semaphore.h>
 #include <linux/completion.h>
 #include <asm/io.h>
-#include <asm/atomic.h>
 #include <linux/smp_lock.h>
 #include <linux/wait.h>
 
@@ -111,16 +110,12 @@
 				 I2O_EVT_IND_BSA_SCSI_SMART )
 
 
-#define I2O_LOCK(unit)	(i2ob_dev[(unit)].req_queue->queue_lock)
-
 /*
  *	Some of these can be made smaller later
  */
 
-static int i2ob_media_change_flag[MAX_I2OB];
-static u32 i2ob_max_sectors[MAX_I2OB<<4];
-
 static int i2ob_context;
+static struct block_device_operations i2ob_fops;
 
 /*
  * I2O Block device descriptor 
@@ -143,6 +138,9 @@
 	int wcache;
 	int power;
 	int index;
+	int media_change_flag;
+	u32 max_sectors;
+	struct gendisk *gd;
 };
 
 /*
@@ -162,16 +160,16 @@
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
  */
 struct i2ob_iop_queue
 {
-	atomic_t queue_depth;
+	unsigned int queue_depth;
 	struct i2ob_request request_queue[MAX_I2OB_DEPTH];
 	struct i2ob_request *i2ob_qhead;
 	request_queue_t *req_queue;
@@ -183,9 +181,8 @@
  *	Each I2O disk is one of these.
  */
 
-static struct i2ob_device i2ob_dev[MAX_I2OB<<4];
+static struct i2ob_device i2ob_dev[MAX_I2OB];
 static int i2ob_dev_count = 0;
-static struct gendisk *i2ob_disk[MAX_I2OB];
 
 /*
  * Mutex and spin lock for event handling synchronization
@@ -312,7 +309,6 @@
 	/* 
 	 * Mask out partitions from now on
 	 */
-	unit &= 0xF0;
 		
 	/* This can be optimised later - just want to be sure its right for
 	   starters */
@@ -402,7 +398,7 @@
 	}
 
 	i2o_post_message(c,m);
-	atomic_inc(&i2ob_queues[c->unit]->queue_depth);
+	i2ob_queues[c->unit]->queue_depth ++;
 
 	return 0;
 }
@@ -453,8 +449,8 @@
 	struct i2ob_request *ireq = NULL;
 	u8 st;
 	u32 *m = (u32 *)msg;
-	u8 unit = (m[2]>>8)&0xF0;	/* low 4 bits are partition */
-	struct i2ob_device *dev = &i2ob_dev[(unit&0xF0)];
+	u8 unit = m[2]>>8;
+	struct i2ob_device *dev = &i2ob_dev[unit];
 
 	/*
 	 * FAILed message
@@ -475,10 +471,10 @@
 		ireq=&i2ob_queues[c->unit]->request_queue[m[3]];
 		ireq->req->errors++;
 
-		spin_lock_irqsave(I2O_LOCK(c->unit), flags);
+		spin_lock_irqsave(dev->req_queue->queue_lock, flags);
 		i2ob_unhook_request(ireq, c->unit);
 		i2ob_end_request(ireq->req);
-		spin_unlock_irqrestore(I2O_LOCK(c->unit), flags);
+		spin_unlock_irqrestore(dev->req_queue->queue_lock, flags);
 	
 		/* Now flush the message by making it a NOP */
 		m[0]&=0x00FFFFFF;
@@ -509,10 +505,10 @@
 		ireq=&i2ob_queues[c->unit]->request_queue[m[3]];
 		ireq->req->errors++;
 		printk(KERN_WARNING "I2O Block: Data transfer to deleted device!\n");
-		spin_lock_irqsave(I2O_LOCK(c->unit), flags);
+		spin_lock_irqsave(dev->req_queue->queue_lock, flags);
 		i2ob_unhook_request(ireq, c->unit);
 		i2ob_end_request(ireq->req);
-		spin_unlock_irqrestore(I2O_LOCK(c->unit), flags);
+		spin_unlock_irqrestore(dev->req_queue->queue_lock, flags);
 		return;
 	}	
 
@@ -576,17 +572,17 @@
 	 */
 	
 	i2ob_free_sglist(dev, ireq);
-	spin_lock_irqsave(I2O_LOCK(c->unit), flags);
+	spin_lock_irqsave(dev->req_queue->queue_lock, flags);
 	i2ob_unhook_request(ireq, c->unit);
 	i2ob_end_request(ireq->req);
-	atomic_dec(&i2ob_queues[c->unit]->queue_depth);
+	i2ob_queues[c->unit]->queue_depth --;
 	
 	/*
 	 *	We may be able to do more I/O
 	 */
 	 
-	i2ob_request(dev->req_queue);
-	spin_unlock_irqrestore(I2O_LOCK(c->unit), flags);
+	i2ob_request(dev->gd->queue);
+	spin_unlock_irqrestore(dev->req_queue->queue_lock, flags);
 }
 
 /* 
@@ -598,8 +594,8 @@
 {
 	unsigned int evt;
 	unsigned long flags;
+	struct i2ob_device *dev;
 	int unit;
-	int i;
 	//The only event that has data is the SCSI_SMART event.
 	struct i2o_reply {
 		u32 header[4];
@@ -638,6 +634,7 @@
 		unit = le32_to_cpu(evt_local->header[3]);
 		evt = le32_to_cpu(evt_local->evt_indicator);
 
+		dev = &i2ob_dev[unit];
 		switch(evt)
 		{
 			/*
@@ -648,10 +645,9 @@
 			 */
 			case I2O_EVT_IND_BSA_VOLUME_LOAD:
 			{
-				struct gendisk *p = i2ob_disk[unit>>4];
-				i2ob_install_device(i2ob_dev[unit].i2odev->controller, 
-					i2ob_dev[unit].i2odev, unit);
-				add_disk(p);
+				i2ob_install_device(dev->i2odev->controller, 
+					dev->i2odev, unit);
+				add_disk(dev->gd);
 				break;
 			}
 
@@ -663,17 +659,18 @@
 			 */
 			case I2O_EVT_IND_BSA_VOLUME_UNLOAD:
 			{
-				struct gendisk *p = i2ob_disk[unit>>4];
+				struct gendisk *p = dev->gd;
+				blk_queue_max_sectors(dev->gd->queue, 0);
 				del_gendisk(p);
-				for(i = unit; i <= unit+15; i++)
-					blk_queue_max_sectors(i2ob_dev[i].req_queue, 0);
-				i2ob_media_change_flag[unit] = 1;
+				put_disk(p);
+				dev->gd = NULL;
+				dev->media_change_flag = 1;
 				break;
 			}
 
 			case I2O_EVT_IND_BSA_VOLUME_UNLOAD_REQ:
 				printk(KERN_WARNING "%s: Attempt to eject locked media\n", 
-					i2ob_dev[unit].i2odev->dev_name);
+					dev->i2odev->dev_name);
 				break;
 
 			/*
@@ -691,12 +688,12 @@
 			{
 				u64 size;
 
-	  			if(i2ob_query_device(&i2ob_dev[unit], 0x0004, 0, &size, 8) !=0 )
-					i2ob_query_device(&i2ob_dev[unit], 0x0000, 4, &size, 8);
+	  			if(i2ob_query_device(dev, 0x0004, 0, &size, 8) !=0 )
+					i2ob_query_device(dev, 0x0000, 4, &size, 8);
 
-				spin_lock_irqsave(I2O_LOCK(unit), flags);	
-				set_capacity(i2ob_disk[unit>>4], size>>9);
-				spin_unlock_irqrestore(I2O_LOCK(unit), flags);	
+				spin_lock_irqsave(dev->req_queue->queue_lock, flags);	
+				set_capacity(dev->gd, size>>9);
+				spin_unlock_irqrestore(dev->req_queue->queue_lock, flags);	
 				break;
 			}
 
@@ -708,7 +705,7 @@
 			case I2O_EVT_IND_BSA_SCSI_SMART:
 			{
 				char buf[16];
-				printk(KERN_INFO "I2O Block: %s received a SCSI SMART Event\n",i2ob_dev[unit].i2odev->dev_name);
+				printk(KERN_INFO "I2O Block: %s received a SCSI SMART Event\n",dev->i2odev->dev_name);
 				evt_local->data[16]='\0';
 				sprintf(buf,"%s",&evt_local->data[0]);
 				printk(KERN_INFO "      Disk Serial#:%s\n",buf);
@@ -735,12 +732,12 @@
 				 * hit the fan big time. The card seems to recover but loses
 				 * the pending writes. Deeply ungood except for testing fsck
 				 */
-				if(i2ob_dev[unit].i2odev->controller->promise)
+				if(dev->i2odev->controller->promise)
 					panic("I2O controller firmware failed. Reboot and force a filesystem check.\n");
 			default:
 				printk(KERN_INFO "%s: Received event 0x%X we didn't register for\n"
 					KERN_INFO "   Blame the I2O card manufacturer 8)\n", 
-					i2ob_dev[unit].i2odev->dev_name, evt);
+					dev->i2odev->dev_name, evt);
 				break;
 		}
 	};
@@ -765,14 +762,6 @@
 	u32 m;
 	
 	while ((req = elv_next_request(q)) != NULL) {
-		/*
-		 *	On an IRQ completion if there is an inactive
-		 *	request on the queue head it means it isnt yet
-		 *	ready to dispatch.
-		 */
-		if(req->rq_status == RQ_INACTIVE)
-			return;
-
 		dev = req->rq_disk->private_data;
 
 		/* 
@@ -780,7 +769,7 @@
 		 *	generic IOP commit control. Certainly it's not right 
 		 *	its global!  
 		 */
-		if(atomic_read(&i2ob_queues[dev->unit]->queue_depth) >= dev->depth)
+		if(i2ob_queues[dev->unit]->queue_depth >= dev->depth)
 			break;
 		
 		/* Get a message */
@@ -788,7 +777,7 @@
 
 		if(m==0xFFFFFFFF)
 		{
-			if(atomic_read(&i2ob_queues[dev->unit]->queue_depth) == 0)
+			if(i2ob_queues[dev->unit]->queue_depth == 0)
 				printk(KERN_ERR "i2o_block: message queue and request queue empty!!\n");
 			break;
 		}
@@ -797,13 +786,12 @@
 		 */
 		req->errors = 0;
 		blkdev_dequeue_request(req);	
-		req->waiting = NULL;
 		
 		ireq = i2ob_queues[dev->unit]->i2ob_qhead;
 		i2ob_queues[dev->unit]->i2ob_qhead = ireq->next;
 		ireq->req = req;
 
-		i2ob_send(m, dev, ireq, (dev->unit&0xF0));
+		i2ob_send(m, dev, ireq, dev->index);
 	}
 }
 
@@ -1065,7 +1053,10 @@
 	u16 power;
 	u32 flags, status;
 	struct i2ob_device *dev=&i2ob_dev[unit];
-	int i;
+	struct gendisk *disk;
+	request_queue_t *q;
+	int segments;
+
 
 	/*
 	 * For logging purposes...
@@ -1079,21 +1070,35 @@
 	 * before any I/O can be performed. If it fails, this
 	 * device is useless.
 	 */
-	if(!i2ob_queues[unit]) {
-		if(i2ob_init_iop(unit))
+	if(!i2ob_queues[c->unit]) {
+		if(i2ob_init_iop(c->unit))
 			return 1;
 	}
 
+	q = i2ob_queues[c->unit]->req_queue;
+
 	/*
 	 * This will save one level of lookup/indirection in critical
 	 * code so that we can directly get the queue ptr from the
 	 * device instead of having to go the IOP data structure.
 	 */
-	dev->req_queue = i2ob_queues[unit]->req_queue;
+	dev->req_queue = q;
 
+	/*
+	 * Allocate a gendisk structure and initialize it
+	 */
+	disk = alloc_disk(16);
+	if (!disk)
+		return 1;
+
+	dev->gd = disk;
 	/* initialize gendik structure */
-	i2ob_disk[unit>>4]->private_data = dev;
-	i2ob_disk[unit>>4]->queue = dev->req_queue;
+	disk->major = MAJOR_NR;
+	disk->first_minor = unit<<4;
+	disk->queue = q;
+	disk->fops = &i2ob_fops;
+	sprintf(disk->disk_name, "i2o/hd%c", 'a' + unit);
+	disk->private_data = dev;
 
 	/*
 	 *	Ask for the current media data. If that isn't supported
@@ -1110,53 +1115,49 @@
 		power = 0;
 	i2ob_query_device(dev, 0x0000, 5, &flags, 4);
 	i2ob_query_device(dev, 0x0000, 6, &status, 4);
-	set_capacity(i2ob_disk[unit>>4], size>>9);
+	set_capacity(disk, size>>9);
 
 	/*
 	 * Max number of Scatter-Gather Elements
 	 */	
 
-	i2ob_dev[unit].power = power;	/* Save power state in device proper */
-	i2ob_dev[unit].flags = flags;
+	dev->power = power;	/* Save power state in device proper */
+	dev->flags = flags;
 
-	for(i=unit;i<=unit+15;i++)
-	{
-		request_queue_t *q = i2ob_dev[unit].req_queue;
-		int segments = (d->controller->status_block->inbound_frame_size - 7) / 2;
+	segments = (d->controller->status_block->inbound_frame_size - 7) / 2;
 
-		if(segments > 16)
-			segments = 16;
-					
-		i2ob_dev[i].power = power;	/* Save power state */
-		i2ob_dev[unit].flags = flags;	/* Keep the type info */
+	if(segments > 16)
+		segments = 16;
+				
+	dev->power = power;	/* Save power state */
+	dev->flags = flags;	/* Keep the type info */
 		
-		blk_queue_max_sectors(q, 96);	/* 256 might be nicer but many controllers 
+	blk_queue_max_sectors(q, 96);	/* 256 might be nicer but many controllers 
 						   explode on 65536 or higher */
-		blk_queue_max_phys_segments(q, segments);
-		blk_queue_max_hw_segments(q, segments);
+	blk_queue_max_phys_segments(q, segments);
+	blk_queue_max_hw_segments(q, segments);
 		
-		i2ob_dev[i].rcache = CACHE_SMARTFETCH;
-		i2ob_dev[i].wcache = CACHE_WRITETHROUGH;
+	dev->rcache = CACHE_SMARTFETCH;
+	dev->wcache = CACHE_WRITETHROUGH;
 		
-		if(d->controller->battery == 0)
-			i2ob_dev[i].wcache = CACHE_WRITETHROUGH;
+	if(d->controller->battery == 0)
+		dev->wcache = CACHE_WRITETHROUGH;
 
-		if(d->controller->promise)
-			i2ob_dev[i].wcache = CACHE_WRITETHROUGH;
+	if(d->controller->promise)
+		dev->wcache = CACHE_WRITETHROUGH;
 
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
+	strcpy(d->dev_name, disk->disk_name);
+	strcpy(disk->devfs_name, disk->disk_name);
 
 	printk(KERN_INFO "%s: Max segments %d, queue depth %d, byte limit %d.\n",
-		 d->dev_name, i2ob_dev[unit].max_segments, i2ob_dev[unit].depth, i2ob_max_sectors[unit]<<9);
+		 d->dev_name, dev->max_segments, dev->depth, dev->max_sectors<<9);
 
 	i2ob_query_device(dev, 0x0000, 0, &type, 1);
 
@@ -1197,7 +1198,7 @@
 	}
 	printk(".\n");
 	printk(KERN_INFO "%s: Maximum sectors/read set to %d.\n", 
-		d->dev_name, i2ob_max_sectors[unit]);
+		d->dev_name, dev->max_sectors);
 
 	/*
 	 * Register for the events we're interested in and that the
@@ -1233,7 +1234,7 @@
 	/* Queue is MAX_I2OB + 1... */
 	i2ob_queues[unit]->request_queue[i].next = NULL;
 	i2ob_queues[unit]->i2ob_qhead = &i2ob_queues[unit]->request_queue[0];
-	atomic_set(&i2ob_queues[unit]->queue_depth, 0);
+	i2ob_queues[unit]->queue_depth = 0;
 
 	i2ob_queues[unit]->lock = SPIN_LOCK_UNLOCKED;
 	i2ob_queues[unit]->req_queue = blk_init_queue(i2ob_request, &i2ob_queues[unit]->lock);
@@ -1257,7 +1258,6 @@
 
 	struct i2o_device *d, *b=NULL;
 	struct i2o_controller *c;
-	struct i2ob_device *dev;
 		
 	for(i=0; i< MAX_I2O_CONTROLLERS; i++)
 	{
@@ -1313,44 +1313,12 @@
 					continue; /*Already claimed on pass 1 */
 			}
 
-			if(i2o_claim_device(d, &i2o_block_handler))
-			{
-				printk(KERN_WARNING "i2o_block: Controller %d, TID %d\n", c->unit,
-					d->lct_data.tid);
-				printk(KERN_WARNING "\t%sevice refused claim! Skipping installation\n", bios?"Boot d":"D");
-				continue;
-			}
-
-			i2o_release_device(d, &i2o_block_handler);
-
-			if(scan_unit<MAX_I2OB<<4)
-			{
- 				/*
-				 * Get the device and fill in the
-				 * Tid and controller.
-				 */
-				dev=&i2ob_dev[scan_unit];
-				dev->i2odev = d; 
-				dev->controller = c;
-				dev->unit = c->unit;
-				dev->tid = d->lct_data.tid;
-
-				if(i2ob_install_device(c,d,scan_unit))
-					printk(KERN_WARNING "Could not install I2O block device\n");
-				else
-				{
-					add_disk(i2ob_disk[scan_unit>>4]);
-					scan_unit+=16;
-					i2ob_dev_count++;
-
-					/* We want to know when device goes away */
-					i2o_device_notify_on(d, &i2o_block_handler);
-				}
-			}
+			if(scan_unit<MAX_I2OB)
+				i2ob_new_device(c, d);
 			else
 			{
 				if(!warned++)
-					printk(KERN_WARNING "i2o_block: too many device, registering only %d.\n", scan_unit>>4);
+					printk(KERN_WARNING "i2o_block: too many device, registering only %d.\n", scan_unit);
 			}
 		}
 		i2o_unlock_controller(c);
@@ -1399,12 +1367,12 @@
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
@@ -1420,18 +1388,20 @@
 	dev->i2odev = d; 
 	dev->controller = c;
 	dev->tid = d->lct_data.tid;
+	dev->unit = c->unit;
 
-	if(i2ob_install_device(c,d,unit))
+	if(i2ob_install_device(c,d,unit)) {
+		i2o_release_device(d, &i2o_block_handler);
 		printk(KERN_ERR "i2o_block: Could not install new device\n");
+	}
 	else	
 	{
-		add_disk(i2ob_disk[unit>>4]);
+		i2o_release_device(d, &i2o_block_handler);
+		add_disk(dev->gd);
 		i2ob_dev_count++;
 		i2o_device_notify_on(d, &i2o_block_handler);
 	}
 
-	i2o_release_device(d, &i2o_block_handler);
- 
 	return;
 }
 
@@ -1443,64 +1413,58 @@
 void i2ob_del_device(struct i2o_controller *c, struct i2o_device *d)
 {	
 	int unit = 0;
-	int i = 0;
 	unsigned long flags;
+	struct i2ob_device *dev;
 
-	spin_lock_irqsave(I2O_LOCK(c->unit), flags);
-
-	/*
-	 * Need to do this...we somtimes get two events from the IRTOS
-	 * in a row and that causes lots of problems.
-	 */
-	i2o_device_notify_off(d, &i2o_block_handler);
-
-	printk(KERN_INFO "I2O Block Device Deleted\n");
-
-	for(unit = 0; unit < MAX_I2OB<<4; unit += 16)
+	for(unit = 0; unit < MAX_I2OB; unit ++)
 	{
-		if(i2ob_dev[unit].i2odev == d)
+		dev = &i2ob_dev[unit];
+		if(dev->i2odev == d)
 		{
 			printk(KERN_INFO "  /dev/%s: Controller %d Tid %d\n", 
 				d->dev_name, c->unit, d->lct_data.tid);
 			break;
 		}
 	}
-	if(unit >= MAX_I2OB<<4)
+
+	printk(KERN_INFO "I2O Block Device Deleted\n");
+
+	if(unit >= MAX_I2OB)
 	{
 		printk(KERN_ERR "i2ob_del_device called, but not in dev table!\n");
-		spin_unlock_irqrestore(I2O_LOCK(c->unit), flags);
 		return;
 	}
 
+	spin_lock_irqsave(dev->req_queue->queue_lock, flags);
+
+	/*
+	 * Need to do this...we somtimes get two events from the IRTOS
+	 * in a row and that causes lots of problems.
+	 */
+	i2o_device_notify_off(d, &i2o_block_handler);
+
 	/* 
 	 * This will force errors when i2ob_get_queue() is called
 	 * by the kenrel.
 	 */
-	del_gendisk(i2ob_disk[unit>>4]);
-	i2ob_dev[unit].req_queue = NULL;
-	for(i = unit; i <= unit+15; i++)
-	{
-		i2ob_dev[i].i2odev = NULL;
-		blk_queue_max_sectors(i2ob_dev[i].req_queue, 0);
-	}
-	spin_unlock_irqrestore(I2O_LOCK(c->unit), flags);
-
-	/*
-	 * Decrease usage count for module
-	 */	
-
-	while(i2ob_dev[unit].refcnt--)
-		MOD_DEC_USE_COUNT;
-
-	i2ob_dev[unit].refcnt = 0;
-	
-	i2ob_dev[i].tid = 0;
+	if(dev->gd) {
+		struct gendisk *gd = dev->gd;
+		gd->queue = NULL;
+		del_gendisk(gd);
+		put_disk(gd);
+		dev->gd = NULL;
+	}
+	spin_unlock_irqrestore(dev->req_queue->queue_lock, flags);
+	dev->req_queue = NULL;
+	dev->i2odev = NULL;
+	dev->refcnt = 0;
+	dev->tid = 0;
 
 	/* 
 	 * Do we need this?
 	 * The media didn't really change...the device is just gone
 	 */
-	i2ob_media_change_flag[unit] = 1;
+	dev->media_change_flag = 1;
 
 	i2ob_dev_count--;	
 }
@@ -1511,10 +1475,9 @@
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
@@ -1523,7 +1486,7 @@
 static int i2ob_revalidate(struct gendisk *disk)
 {
 	struct i2ob_device *p = disk->private_data;
-	return i2ob_install_device(p->controller, p->i2odev, p->index<<4);
+	return i2ob_install_device(p->controller, p->i2odev, p->index);
 }
 
 /*
@@ -1536,7 +1499,7 @@
 	
 	for(i=0;i<MAX_I2OB;i++)
 	{
-		struct i2ob_device *dev=&i2ob_dev[(i<<4)];
+		struct i2ob_device *dev=&i2ob_dev[i];
 		
 		if(dev->refcnt!=0)
 		{
@@ -1598,51 +1561,36 @@
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
+		i2ob_queues[i] = NULL;
+
+	/*
 	 *	Now fill in the boiler plate
 	 */
 	 
-	for (i = 0; i < MAX_I2OB << 4; i++) {
-		i2ob_dev[i].refcnt = 0;
-		i2ob_dev[i].flags = 0;
-		i2ob_dev[i].controller = NULL;
-		i2ob_dev[i].i2odev = NULL;
-		i2ob_dev[i].tid = 0;
-		i2ob_dev[i].head = NULL;
-		i2ob_dev[i].tail = NULL;
-		i2ob_dev[i].depth = MAX_I2OB_DEPTH;
-		i2ob_max_sectors[i] = 2;
-	}
-	
 	for (i = 0; i < MAX_I2OB; i++) {
-		struct gendisk *disk = i2ob_disk[i];
-		disk->major = MAJOR_NR;
-		disk->first_minor = i<<4;
-		disk->fops = &i2ob_fops;
-		sprintf(disk->disk_name, "i2o/hd%c", 'a' + i);
+		struct i2ob_device *dev = &i2ob_dev[i];
+		dev->index = i;
+		dev->refcnt = 0;
+		dev->flags = 0;
+		dev->controller = NULL;
+		dev->i2odev = NULL;
+		dev->tid = 0;
+		dev->head = NULL;
+		dev->tail = NULL;
+		dev->depth = MAX_I2OB_DEPTH;
+		dev->max_sectors = 2;
+		dev->gd = NULL;
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
@@ -1671,9 +1619,6 @@
 
 	return 0;
 
-oom:
-	while (i--)
-		put_disk(i2ob_disk[i]);
 	unregister_blkdev(MAJOR_NR, "i2o_block");
 	return -ENOMEM;
 }
@@ -1701,11 +1646,8 @@
 	if(i2ob_dev_count) {
 		struct i2o_device *d;
 		for(i = 0; i < MAX_I2OB; i++)
-		if((d=i2ob_dev[i<<4].i2odev)) {
-			i2o_device_notify_off(d, &i2o_block_handler);
-			i2o_event_register(d->controller, d->lct_data.tid, 
-				i2ob_context, i<<4, 0);
-		}
+			if((d = i2ob_dev[i].i2odev))
+				i2ob_del_device(d->controller, d);
 	}
 	
 	/*
@@ -1725,15 +1667,21 @@
 	 */
 
 	i2o_remove_handler(&i2o_block_handler);
-		 
-	for (i = 0; i < MAX_I2OB; i++)
-		put_disk(i2ob_disk[i]);
 
 	/*
 	 *	Return the block device
 	 */
 	if (unregister_blkdev(MAJOR_NR, "i2o_block") != 0)
 		printk("i2o_block: cleanup_module failed\n");
+
+	/*
+	 *	release request queue
+	 */
+	for (i = 0; i < MAX_I2O_CONTROLLERS; i ++)
+		if(i2ob_queues[i]) {
+			blk_cleanup_queue(i2ob_queues[i]->req_queue);
+			kfree(i2ob_queues[i]);
+		}
 }
 
 MODULE_AUTHOR("Red Hat");

--------------050403080302040407040903--
