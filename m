Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbUDTAnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbUDTAnE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 20:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbUDTAnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 20:43:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37003 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261396AbUDTAmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 20:42:18 -0400
Message-ID: <408471E2.8060201@redhat.com>
Date: Mon, 19 Apr 2004 14:42:10 -1000
From: Warren Togami <wtogami@redhat.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040418)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: axboe@suse.de
CC: Arjan van de Ven <arjanv@redhat.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] i2o_block Fix, possible CFQ elevator problem?
References: <4083BA03.1090606@redhat.com> <20040419121225.GT1966@suse.de>
In-Reply-To: <20040419121225.GT1966@suse.de>
Content-Type: multipart/mixed;
 boundary="------------070000070407020006070902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070000070407020006070902
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jens Axboe wrote:
>>
>>http://togami.com/~warren/archive/2004/i2o_cfq_quad_bonnie.jpg
>>
>>I noticed that the call trace contained "cfq_next_request", so I was
>>curious what would happened if we changed to the deadline scheduler.
>>Booted with the same kernel but with "elevator=deadline". To our
>>surprise, bonnie++ ran simultaneously on all four I2O block devices
>>without crashing the server. For another test we tried "elevator=as"
>>and it too remained stable.
>>
>>Possible CFQ I/O scheduler problem?
> 
> 
> That looks pretty damn strange. Any chance you can capture a full oops,
> with a serial console or similar?

Fedora Core 2 x86_64 SMP (2 x Opteron) with kernel-2.6.5-1.326 (based on
2.6.6-rc1)
gcc-3.3.3-7 plus attached patch.  This panic was captured by netconsole.

http://togami.com/~warren/archive/2004/i2o_cfq_quad_bonnie.txt
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at cfq_iosched:407
invalid operand: 0000 [1] SMP
CPU 0
Pid: 1523, comm: bonnie++ Not tainted 2.6.5-1.326custom
RIP: 0010:[<ffffffff80234f93>] <ffffffff80234f93>{cfq_next_request+66}
RSP: 0000:ffffffff804a9048  EFLAGS: 00010016
RAX: 000001006cebf578 RBX: 000001007f3f1e00 RCX: 000001006ceb6340
RDX: 000001006cebf540 RSI: 0000000000000001 RDI: 000001007a225000
RBP: 000001007a225000 R08: ffffffff804a8ec8 R09: 0000000000000000
R10: 000001000289cb60 R11: 0000000000000000 R12: 000001007a225000
R13: 000001007a225000 R14: 000001001703bf58 R15: 0000000000509010
FS:  0000002a9555f360(0000) GS:ffffffff804a4e80(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000002a95558000 CR3: 0000000000101000 CR4: 00000000000006e0
Process bonnie++ (pid: 1523, stackpage=1007fd5e1c0)
Stack: 000001007aa01118 000001007d95abc0 000001007aa01118 ffffffff8022b444
         000001007d95abc0 000001007aa01118 ffffffffa0137bc0 ffffffffa0133b82
         0000000000000001 000001007d95abc0
Call Trace:<IRQ> <ffffffff8022b444>{elv_next_request+238}
<ffffffffa0133b82>{:i2o_block:i2ob_request+233}
         <ffffffffa013370e>{:i2o_block:i2o_block_reply+1162}
         <ffffffff80113d85>{handle_IRQ_event+44}
<ffffffffa00893ac>{:tg3:tg3_enable_ints+23}
         <ffffffff8013e7f9>{update_wall_time+12}
<ffffffffa002908a>{:i2o_core:i2o_run_queue+124}
         <ffffffffa002b60e>{:i2o_core:i2o_pci_interrupt+9}
<ffffffff80113d85>{handle_IRQ_event+44}
         <ffffffff801140b8>{do_IRQ+285} <ffffffff8013a894>{__do_softirq+76}
         <ffffffff8011185f>{ret_from_intr+0}  <EOI>

Code: 0f 0b 74 3a 32 80 ff ff ff ff 97 01 48 89 c8 eb 0e 48 89 de
RIP <ffffffff80234f93>{cfq_next_request+66} RSP <ffffffff804a9048>
   <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
   <0>Rebooting in 5 seconds..Badness in panic at kernel/panic.c:87

Call Trace:<IRQ> <ffffffff80136024>{panic+416}
<ffffffff8011411d>{do_IRQ+386}
         <ffffffff8011185f>{ret_from_intr+0} <ffffffff80138cd3>{do_exit+87}
         <ffffffff80112ab5>{oops_end+80} <ffffffff80112bc5>{do_trap+0}
         <ffffffff80112cc2>{do_trap+253}
<ffffffff80112f45>{do_invalid_op+145}
         <ffffffff80234f93>{cfq_next_request+66}
<ffffffff8012ff68>{recalc_task_prio+343}
         <ffffffff8012ff68>{recalc_task_prio+343}
<ffffffff80111d31>{error_exit+0}
         <ffffffff80234f93>{cfq_next_request+66}
<ffffffff80156bea>{mempool_free+227}
         <ffffffff8022b444>{elv_next_request+238}
<ffffffffa0133b82>{:i2o_block:i2ob_request+233}
         <ffffffffa013370e>{:i2o_block:i2o_block_reply+1162}
         <ffffffff80113d85>{handle_IRQ_event+44}
<ffffffffa00893ac>{:tg3:tg3_enable_ints+23}
         <ffffffff8013e7f9>{update_wall_time+12}
<ffffffffa002908a>{:i2o_core:i2o_run_queue+124}
         <ffffffffa002b60e>{:i2o_core:i2o_pci_interrupt+9}
<ffffffff80113d85>{handle_IRQ_event+44}
         <ffffffff801140b8>{do_IRQ+285} <ffffffff8013a894>{__do_softirq+76}
         <ffffffff8011185f>{ret_from_intr+0}  <EOI>


> 
> A quick look at i2o_block doesn't show anything that should cause this.
> There are a number of request handling badnesses in there, though:
> 
> - kill check fo RQ_INACTIVE, it's pointless. even if it wasn't, the
>   inactive check return is buggy.
> 
> - you must not just clear req->waiting! remove that code.
> 
> - ->queue_depth should not be an expensive atomic type, you have the
>   device lock when you look at/inc/dec it.
> 
> 
>> 	/*
>>+	 *	Set up the queue
>>+	 */
>>+	for(i = 0; i < MAX_I2O_CONTROLLERS; i++)
>>+	{
>>+		i2ob_queues[i] = NULL;
>>+		i2ob_init_iop(i);
>>+	}
> 
> 
> Only initialize queues that will be used. Each allocated but unusued
> queues wastes memory.
> 

Markus implemented all of your recommendations except the atomic part,
which seemed to cause a kernel panic while loading the i2o_block driver.
   Attached is the latest i2o_block.c cleanup, while at this below URL is
his attempt of removing the atomic type.  He is not sure if he
implemented it properly.

http://i2o.shadowconnect.com/i2o_block-cleanup.patch-broke

Your recommendations would be greatly appreciated!

Thank you,
Warren Togami
wtogami@redhat.com
Markus Lidel
Markus.Lidel@shadowconnect.com

--------------070000070407020006070902
Content-Type: text/x-patch;
 name="i2o_block-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2o_block-cleanup.patch"

--- /root/linux-2.6.5-1.322/drivers/message/i2o/i2o_block.c.old	2004-04-15 12:05:05.000000000 -1000
+++ i2o_block.c	2004-04-20 12:46:38.000000000 -1000
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
@@ -765,14 +761,6 @@
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
@@ -797,13 +785,12 @@
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
 
@@ -1065,7 +1052,8 @@
 	u16 power;
 	u32 flags, status;
 	struct i2ob_device *dev=&i2ob_dev[unit];
-	int i;
+	request_queue_t *q;
+	int segments;
 
 	/*
 	 * For logging purposes...
@@ -1079,8 +1067,8 @@
 	 * before any I/O can be performed. If it fails, this
 	 * device is useless.
 	 */
-	if(!i2ob_queues[unit]) {
-		if(i2ob_init_iop(unit))
+	if(!i2ob_queues[c->unit]) {
+		if(i2ob_init_iop(c->unit))
 			return 1;
 	}
 
@@ -1089,11 +1077,11 @@
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
@@ -1110,7 +1098,7 @@
 		power = 0;
 	i2ob_query_device(dev, 0x0000, 5, &flags, 4);
 	i2ob_query_device(dev, 0x0000, 6, &status, 4);
-	set_capacity(i2ob_disk[unit>>4], size>>9);
+	set_capacity(i2ob_disk[unit], size>>9);
 
 	/*
 	 * Max number of Scatter-Gather Elements
@@ -1119,44 +1107,41 @@
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
 
@@ -1197,7 +1182,7 @@
 	}
 	printk(".\n");
 	printk(KERN_INFO "%s: Maximum sectors/read set to %d.\n", 
-		d->dev_name, i2ob_max_sectors[unit]);
+		d->dev_name, i2ob_dev[unit].max_sectors);
 
 	/*
 	 * Register for the events we're interested in and that the
@@ -1323,7 +1308,7 @@
 
 			i2o_release_device(d, &i2o_block_handler);
 
-			if(scan_unit<MAX_I2OB<<4)
+			if(scan_unit<MAX_I2OB)
 			{
  				/*
 				 * Get the device and fill in the
@@ -1339,8 +1324,8 @@
 					printk(KERN_WARNING "Could not install I2O block device\n");
 				else
 				{
-					add_disk(i2ob_disk[scan_unit>>4]);
-					scan_unit+=16;
+					add_disk(i2ob_disk[scan_unit]);
+					scan_unit++;
 					i2ob_dev_count++;
 
 					/* We want to know when device goes away */
@@ -1350,7 +1335,7 @@
 			else
 			{
 				if(!warned++)
-					printk(KERN_WARNING "i2o_block: too many device, registering only %d.\n", scan_unit>>4);
+					printk(KERN_WARNING "i2o_block: too many device, registering only %d.\n", scan_unit);
 			}
 		}
 		i2o_unlock_controller(c);
@@ -1399,12 +1384,12 @@
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
@@ -1425,7 +1410,7 @@
 		printk(KERN_ERR "i2o_block: Could not install new device\n");
 	else	
 	{
-		add_disk(i2ob_disk[unit>>4]);
+		add_disk(i2ob_disk[unit]);
 		i2ob_dev_count++;
 		i2o_device_notify_on(d, &i2o_block_handler);
 	}
@@ -1443,7 +1428,6 @@
 void i2ob_del_device(struct i2o_controller *c, struct i2o_device *d)
 {	
 	int unit = 0;
-	int i = 0;
 	unsigned long flags;
 
 	spin_lock_irqsave(I2O_LOCK(c->unit), flags);
@@ -1456,7 +1440,7 @@
 
 	printk(KERN_INFO "I2O Block Device Deleted\n");
 
-	for(unit = 0; unit < MAX_I2OB<<4; unit += 16)
+	for(unit = 0; unit < MAX_I2OB; unit ++)
 	{
 		if(i2ob_dev[unit].i2odev == d)
 		{
@@ -1465,7 +1449,7 @@
 			break;
 		}
 	}
-	if(unit >= MAX_I2OB<<4)
+	if(unit >= MAX_I2OB)
 	{
 		printk(KERN_ERR "i2ob_del_device called, but not in dev table!\n");
 		spin_unlock_irqrestore(I2O_LOCK(c->unit), flags);
@@ -1476,13 +1460,10 @@
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
@@ -1493,14 +1474,13 @@
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
@@ -1511,10 +1491,9 @@
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
@@ -1523,7 +1502,7 @@
 static int i2ob_revalidate(struct gendisk *disk)
 {
 	struct i2ob_device *p = disk->private_data;
-	return i2ob_install_device(p->controller, p->i2odev, p->index<<4);
+	return i2ob_install_device(p->controller, p->i2odev, p->index);
 }
 
 /*
@@ -1536,7 +1515,7 @@
 	
 	for(i=0;i<MAX_I2OB;i++)
 	{
-		struct i2ob_device *dev=&i2ob_dev[(i<<4)];
+		struct i2ob_device *dev=&i2ob_dev[i];
 		
 		if(dev->refcnt!=0)
 		{
@@ -1598,23 +1577,32 @@
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
@@ -1623,26 +1614,10 @@
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
@@ -1701,10 +1676,10 @@
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
 	
@@ -1726,14 +1701,27 @@
 
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
+	for (i = 0; i < MAX_I2O_CONTROLLERS; i ++)
+		if(i2ob_queues[i]) {
+			blk_cleanup_queue(i2ob_queues[i]->req_queue);
+			kfree(i2ob_queues[i]);
+		}
 }
 
 MODULE_AUTHOR("Red Hat");

--------------070000070407020006070902--
