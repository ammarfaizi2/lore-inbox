Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262760AbSJHTHl>; Tue, 8 Oct 2002 15:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263247AbSJHTGO>; Tue, 8 Oct 2002 15:06:14 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17168 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262760AbSJHTBf>; Tue, 8 Oct 2002 15:01:35 -0400
Subject: PATCH: bring I2O roughly back into line
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 19:58:12 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yzYa-0004sT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are some bits left to do but this folds in all the main stuff from
2.4 and 2.5 including Al's recent change

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/message/i2o/i2o_block.c linux.2.5.41-ac1/drivers/message/i2o/i2o_block.c
--- linux.2.5.41/drivers/message/i2o/i2o_block.c	2002-10-07 22:12:24.000000000 +0100
+++ linux.2.5.41-ac1/drivers/message/i2o/i2o_block.c	2002-10-06 00:07:01.000000000 +0100
@@ -1,7 +1,7 @@
 /*
  * I2O Random Block Storage Class OSM
  *
- * (C) Copyright 1999 Red Hat Software
+ * (C) Copyright 1999-2002 Red Hat
  *	
  * Written by Alan Cox, Building Number Three Ltd
  *
@@ -10,6 +10,16 @@
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
  *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * For the purpose of avoiding doubt the preferred form of the work
+ * for making modifications shall be a standards compliant form such
+ * gzipped tar and not one requiring a proprietary or patent encumbered
+ * tool to unpack.
+ *
  * This is a beta test release. Most of the good code was taken
  * from the nbd driver by Pavel Machek, who in turn took some of it
  * from loop.c. Isn't free software great for reusability 8)
@@ -21,6 +31,11 @@
  *	Alan Cox:	
  *		FC920 has an rmw bug. Dont or in the end marker.
  *		Removed queue walk, fixed for 64bitness.
+ *		Rewrote much of the code over time
+ *		Added indirect block lists
+ *		Handle 64K limits on many controllers
+ *		Don't use indirects on the Promise (breaks)
+ *		Heavily chop down the queue depths
  *	Deepak Saxena:
  *		Independent queues per IOP
  *		Support for dynamic device creation/deletion
@@ -45,7 +60,7 @@
 #include <linux/major.h>
 
 #include <linux/module.h>
-
+#include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/fs.h>
 #include <linux/stat.h>
@@ -73,13 +88,12 @@
 #include <linux/wait.h>
 
 #define MAJOR_NR I2O_MAJOR
-#define DEVICE_NR(device) (minor(device)>>4)
 
 #include <linux/blk.h>
 
 #define MAX_I2OB	16
 
-#define MAX_I2OB_DEPTH	128
+#define MAX_I2OB_DEPTH	8
 #define MAX_I2OB_RETRIES 4
 
 //#define DRIVERDEBUG
@@ -125,7 +139,10 @@
  *	Some of these can be made smaller later
  */
 
+static int i2ob_blksizes[MAX_I2OB<<4];
+static int i2ob_sizes[MAX_I2OB<<4];
 static int i2ob_media_change_flag[MAX_I2OB];
+static u32 i2ob_max_sectors[MAX_I2OB<<4];
 
 static int i2ob_context;
 
@@ -143,9 +160,12 @@
 	struct request *head, *tail;
 	request_queue_t *req_queue;
 	int max_segments;
+	int max_direct;		/* Not yet used properly */
 	int done_flag;
-	int constipated;
 	int depth;
+	int rcache;
+	int wcache;
+	int power;
 };
 
 /*
@@ -153,6 +173,7 @@
  *	We should cache align these to avoid ping-ponging lines on SMP
  *	boxes under heavy I/O load...
  */
+
 struct i2ob_request
 {
 	struct i2ob_request *next;
@@ -177,8 +198,6 @@
 	spinlock_t lock;
 };
 static struct i2ob_iop_queue *i2ob_queues[MAX_I2O_CONTROLLERS];
-static struct i2ob_request *i2ob_backlog[MAX_I2O_CONTROLLERS];
-static struct i2ob_request *i2ob_backlog_tail[MAX_I2O_CONTROLLERS];
 
 /*
  *	Each I2O disk is one of these.
@@ -186,7 +205,7 @@
 
 static struct i2ob_device i2ob_dev[MAX_I2OB<<4];
 static int i2ob_dev_count = 0;
-static struct gendisk *i2o_disk[MAX_I2OB];
+static struct gendisk *i2ob_disk[MAX_I2OB];
 
 /*
  * Mutex and spin lock for event handling synchronization
@@ -195,10 +214,7 @@
 static DECLARE_MUTEX_LOCKED(i2ob_evt_sem);
 static DECLARE_COMPLETION(i2ob_thread_dead);
 static spinlock_t i2ob_evt_lock = SPIN_LOCK_UNLOCKED;
-static u32 evt_msg[MSG_FRAME_SIZE>>2];
-
-static struct timer_list i2ob_timer;
-static int i2ob_timer_started = 0;
+static u32 evt_msg[MSG_FRAME_SIZE];
 
 static void i2o_block_reply(struct i2o_handler *, struct i2o_controller *,
 	 struct i2o_message *);
@@ -208,7 +224,6 @@
 static int i2ob_install_device(struct i2o_controller *, struct i2o_device *, int);
 static void i2ob_end_request(struct request *);
 static void i2ob_request(request_queue_t *);
-static int i2ob_backlog_request(struct i2o_controller *, struct i2ob_device *);
 static int i2ob_init_iop(unsigned int);
 static request_queue_t* i2ob_get_queue(kdev_t);
 static int i2ob_query_device(struct i2ob_device *, int, int, void*, int);
@@ -232,8 +247,12 @@
 	I2O_CLASS_RANDOM_BLOCK_STORAGE
 };
 
-/*
- *	Get a message
+/**
+ *	i2ob_get	-	Get an I2O message
+ *	@dev:  I2O block device
+ *
+ *	Get a message from the FIFO used for this block device. The message is returned
+ *	or the I2O 'no message' value of 0xFFFFFFFF if nothing is available.
  */
 
 static u32 i2ob_get(struct i2ob_device *dev)
@@ -242,10 +261,23 @@
    	return I2O_POST_READ32(c);
 }
  
-/*
- *	Turn a Linux block request into an I2O block read/write.
+/**
+ *	i2ob_send		-	Turn a request into a message and send it
+ *	@m: Message offset
+ *	@dev: I2O device
+ *	@ireq: Request structure
+ *	@unit: Device identity
+ *
+ *	Generate an I2O BSAREAD request. This interface function is called for devices that
+ *	appear to explode when they are fed indirect chain pointers (notably right now this
+ *	appears to afflict Promise hardwre, so be careful what you feed the hardware
+ *
+ *	No cleanup is done by this interface. It is done on the interrupt side when the
+ *	reply arrives
+ *
+ *	To Fix: Generate PCI maps of the buffers
  */
-
+ 
 static int i2ob_send(u32 m, struct i2ob_device *dev, struct i2ob_request *ireq, int unit)
 {
 	struct i2o_controller *c = dev->controller;
@@ -256,7 +288,7 @@
 	struct request *req = ireq->req;
 	struct bio *bio = req->bio;
 	int count = req->nr_sectors<<9;
-	unsigned long last = ~0UL;
+	unsigned long last = 0;
 	unsigned short size = 0;
 
 	// printk(KERN_INFO "i2ob_send called\n");
@@ -266,9 +298,9 @@
 	/*
 	 * Build the message based on the request.
 	 */
-	__raw_writel(i2ob_context|(unit<<8), msg+8);
-	__raw_writel(ireq->num, msg+12);
-	__raw_writel(req->nr_sectors << 9, msg+20);
+	i2o_raw_writel(i2ob_context|(unit<<8), msg+8);
+	i2o_raw_writel(ireq->num, msg+12);
+	i2o_raw_writel(req->nr_sectors << 9, msg+20);
 
 	/* 
 	 * Mask out partitions from now on
@@ -278,69 +310,77 @@
 	/* This can be optimised later - just want to be sure its right for
 	   starters */
 	offset = ((u64)req->sector) << 9;
-	__raw_writel( offset & 0xFFFFFFFF, msg+24);
-	__raw_writel(offset>>32, msg+28);
+	i2o_raw_writel( offset & 0xFFFFFFFF, msg+24);
+	i2o_raw_writel(offset>>32, msg+28);
 	mptr=msg+32;
 	
 	if(req->cmd == READ)
 	{
-		__raw_writel(I2O_CMD_BLOCK_READ<<24|HOST_TID<<12|tid, msg+4);
-		while(bio)
+		DEBUG("READ\n");
+		i2o_raw_writel(I2O_CMD_BLOCK_READ<<24|HOST_TID<<12|tid, msg+4);
+		while(bio!=NULL)
 		{
-			if (bio_to_phys(bio) == last) {
+			if(bio_to_phys(bio) == last) {
 				size += bio->bi_size;
 				last += bio->bi_size;
 				if(bio->bi_next)
-					__raw_writel(0x14000000|(size), mptr-8);
+					i2o_raw_writel(0x10000000|(size), mptr-8);
 				else
-					__raw_writel(0xD4000000|(size), mptr-8);
+					__raw_writel(0xD0000000|(size), mptr-8);
 			}
 			else
 			{
 				if(bio->bi_next)
-					__raw_writel(0x10000000|bio->bi_size, mptr);
+					i2o_raw_writel(0x10000000|bio->bi_size, mptr);
 				else
-					__raw_writel(0xD0000000|bio->bi_size, mptr);
-				__raw_writel(bio_to_phys(bio), mptr+4);
+					i2o_raw_writel(0xD0000000|bio->bi_size, mptr);
+				i2o_raw_writel(bio_to_phys(bio), mptr+4);
 				mptr += 8;	
 				size = bio->bi_size;
-				last = bio_to_phys(bio) + bio->bi_size;
+				last = bio_to_phys(bio) + size;
 			}
 
 			count -= bio->bi_size;
 			bio = bio->bi_next;
 		}
-		/*
-		 *	Heuristic for now since the block layer doesnt give
-		 *	us enough info. If its a big write assume sequential
-		 *	readahead on controller. If its small then don't read
-		 *	ahead but do use the controller cache.
-		 */
-		if(size >= 8192)
-			__raw_writel((8<<24)|(1<<16)|8, msg+16);
-		else
-			__raw_writel((8<<24)|(1<<16)|4, msg+16);
+		switch(dev->rcache)
+		{
+			case CACHE_NULL:
+				i2o_raw_writel(0, msg+16);break;
+			case CACHE_PREFETCH:
+				i2o_raw_writel(0x201F0008, msg+16);break;
+			case CACHE_SMARTFETCH:
+				if(req->nr_sectors > 16)
+					i2o_raw_writel(0x201F0008, msg+16);
+				else
+					i2o_raw_writel(0x001F0000, msg+16);
+				break;
+		}				
+				
+//		printk("Reading %d entries %d bytes.\n",
+//			mptr-msg-8, req->nr_sectors<<9);
 	}
 	else if(req->cmd == WRITE)
 	{
-		__raw_writel(I2O_CMD_BLOCK_WRITE<<24|HOST_TID<<12|tid, msg+4);
-		while(bio)
+		DEBUG("WRITE\n");
+		i2o_raw_writel(I2O_CMD_BLOCK_WRITE<<24|HOST_TID<<12|tid, msg+4);
+		while(bio!=NULL)
 		{
-			if (bio_to_phys(bio) == last) {
+			if(bio_to_phys(bio) == last) {
 				size += bio->bi_size;
 				last += bio->bi_size;
 				if(bio->bi_next)
-					__raw_writel(0x14000000|(size), mptr-8);
+					i2o_raw_writel(0x14000000|(size), mptr-8);
 				else
-					__raw_writel(0xD4000000|(size), mptr-8);
+					i2o_raw_writel(0xD4000000|(size), mptr-8);
 			}
 			else
 			{
 				if(bio->bi_next)
-					__raw_writel(0x14000000|bio->bi_size, mptr);
+					i2o_raw_writel(0x14000000|(bio->bi_size), mptr);
 				else
-					__raw_writel(0xD4000000|bio->bi_size, mptr);
-				__raw_writel(bio_to_phys(bio), mptr+4);
+					i2o_raw_writel(0xD4000000|(bio->bi_size), mptr);
+				i2o_raw_writel(bio_to_phys(bio), mptr+4);
 				mptr += 8;	
 				size = bio->bi_size;
 				last = bio_to_phys(bio) + bio->bi_size;
@@ -350,30 +390,31 @@
 			bio = bio->bi_next;
 		}
 
-		if(c->battery)
-		{
-			
-			if(size>16384)
-				__raw_writel(4, msg+16);
-			else
-				/* 
-				 * Allow replies to come back once data is cached in the controller
-				 * This allows us to handle writes quickly thus giving more of the
-				 * queue to reads.
-				 */
-				__raw_writel(16, msg+16);
-		}
-		else
+		switch(dev->wcache)
 		{
-			/* Large write, don't cache */
-			if(size>8192)
-				__raw_writel(4, msg+16);
-			else
-			/* write through */
-				__raw_writel(8, msg+16);
+			case CACHE_NULL:
+				i2o_raw_writel(0, msg+16);break;
+			case CACHE_WRITETHROUGH:
+				i2o_raw_writel(0x001F0008, msg+16);break;
+			case CACHE_WRITEBACK:
+				i2o_raw_writel(0x001F0010, msg+16);break;
+			case CACHE_SMARTBACK:
+				if(req->nr_sectors > 16)
+					i2o_raw_writel(0x001F0004, msg+16);
+				else
+					i2o_raw_writel(0x001F0010, msg+16);
+				break;
+			case CACHE_SMARTTHROUGH:
+				if(req->nr_sectors > 16)
+					i2o_raw_writel(0x001F0004, msg+16);
+				else
+					i2o_raw_writel(0x001F0010, msg+16);
 		}
+				
+//		printk("Writing %d entries %d bytes.\n",
+//			mptr-msg-8, req->nr_sectors<<9);
 	}
-	__raw_writel(I2O_MESSAGE_SIZE(mptr-msg)>>2 | SGL_OFFSET_8, msg);
+	i2o_raw_writel(I2O_MESSAGE_SIZE(mptr-msg)>>2 | SGL_OFFSET_8, msg);
 	
 	if(count != 0)
 	{
@@ -405,47 +446,23 @@
  
 static inline void i2ob_end_request(struct request *req)
 {
+	/* FIXME  - pci unmap the request */
+
 	/*
 	 * Loop until all of the buffers that are linked
 	 * to this request have been marked updated and
 	 * unlocked.
 	 */
 
-	while (end_that_request_first(req, !req->errors, req->hard_cur_sectors))
-		;
+	while (end_that_request_first( req, !req->errors, req->hard_cur_sectors ));
 
 	/*
 	 * It is now ok to complete the request.
 	 */
 	end_that_request_last( req );
+	DEBUG("IO COMPLETED\n");
 }
 
-static int i2ob_flush(struct i2o_controller *c, struct i2ob_device *d, int unit)
-{
-	unsigned long msg;
-	u32 m = i2ob_get(d);
-	
-	if(m == 0xFFFFFFFF)
-		return -1;
-		
-	msg = c->mem_offset + m;
-
-	/*
-	 *	Ask the controller to write the cache back. This sorts out
-	 *	the supertrak firmware flaw and also does roughly the right
-	 *	thing for other cases too.
-	 */
-	 	
-	__raw_writel(FIVE_WORD_MSG_SIZE|SGL_OFFSET_0, msg);
-	__raw_writel(I2O_CMD_BLOCK_CFLUSH<<24|HOST_TID<<12|d->tid, msg+4);
-	__raw_writel(i2ob_context|(unit<<8), msg+8);
-	__raw_writel(0, msg+12);
-	__raw_writel(60<<16, msg+16);
-	
-	i2o_post_message(c,m);
-	return 0;
-}
-			
 /*
  *	OSM reply handler. This gets all the message replies
  */
@@ -464,12 +481,13 @@
 	 */
 	if(m[0] & (1<<13))
 	{
+		DEBUG("FAIL");
 		/*
 		 * FAILed message from controller
 		 * We increment the error count and abort it
 		 *
 		 * In theory this will never happen.  The I2O block class
-		 * speficiation states that block devices never return
+		 * specification states that block devices never return
 		 * FAILs but instead use the REQ status field...but
 		 * better be on the safe side since no one really follows
 		 * the spec to the book :)
@@ -499,17 +517,6 @@
 		return;
 	}
 
-	if(msg->function == I2O_CMD_BLOCK_CFLUSH)
-	{
-		spin_lock_irqsave(I2O_LOCK(c->unit), flags);
-		dev->constipated=0;
-		DEBUG(("unconstipated\n"));
-		if(i2ob_backlog_request(c, dev)==0)
-			i2ob_request(dev->req_queue);
-		spin_unlock_irqrestore(I2O_LOCK(c->unit), flags);
-		return;
-	}
-
 	if(!dev->i2odev)
 	{
 		/*
@@ -567,64 +574,12 @@
 		 *	The second is that you have a SuperTrak 100 and the
 		 *	firmware got constipated. Unlike standard i2o card
 		 *	setups the supertrak returns an error rather than
-		 *	blocking for the timeout in these cases.
+		 *	blocking for the timeout in these cases. 
+		 *
+		 *	Don't stick a supertrak100 into cache aggressive modes
 		 */
 		 
 		
-		spin_lock_irqsave(I2O_LOCK(c->unit), flags);
-		if(err==4)
-		{
-			/*
-			 *	Time to uncork stuff
-			 */
-			
-			if(!dev->constipated)
-			{
-				dev->constipated = 1;
-				DEBUG(("constipated\n"));
-				/* Now pull the chain */
-				if(i2ob_flush(c, dev, unit)<0)
-				{
-					DEBUG(("i2ob: Unable to queue flush. Retrying I/O immediately.\n"));
-					dev->constipated=0;
-				}
-				DEBUG(("flushing\n"));
-			}
-			
-			/*
-			 *	Recycle the request
-			 */
-			 
-//			i2ob_unhook_request(ireq, c->unit);
-			
-			/*
-			 *	Place it on the recycle queue
-			 */
-			 
-			ireq->next = NULL;
-			if(i2ob_backlog_tail[c->unit]!=NULL)
-				i2ob_backlog_tail[c->unit]->next = ireq;
-			else
-				i2ob_backlog[c->unit] = ireq;			
-			i2ob_backlog_tail[c->unit] = ireq;
-			
-			atomic_dec(&i2ob_queues[c->unit]->queue_depth);
-
-			/*
-			 *	If the constipator flush failed we want to
-			 *	poke the queue again. 
-			 */
-			 
-			i2ob_request(dev->req_queue);
-			spin_unlock_irqrestore(I2O_LOCK(c->unit), flags);
-			
-			/*
-			 *	and out
-			 */
-			 
-			return;	
-		}
-		spin_unlock_irqrestore(I2O_LOCK(c->unit), flags);
 		printk(KERN_ERR "\n/dev/%s error: %s", dev->i2odev->dev_name, 
 			bsa_errors[m[4]&0XFFFF]);
 		if(m[4]&0x00FF0000)
@@ -639,19 +594,17 @@
 	 *	Dequeue the request. We use irqsave locks as one day we
 	 *	may be running polled controllers from a BH...
 	 */
-
+	
 	spin_lock_irqsave(I2O_LOCK(c->unit), flags);
 	i2ob_unhook_request(ireq, c->unit);
 	i2ob_end_request(ireq->req);
 	atomic_dec(&i2ob_queues[c->unit]->queue_depth);
-
+	
 	/*
 	 *	We may be able to do more I/O
 	 */
-
-	if(i2ob_backlog_request(c, dev)==0)
-		i2ob_request(dev->req_queue);
-
+	 
+	i2ob_request(dev->req_queue);
 	spin_unlock_irqrestore(I2O_LOCK(c->unit), flags);
 }
 
@@ -672,6 +625,7 @@
 		u32 evt_indicator;
 		u8 ASC;
 		u8 ASCQ;
+		u16 pad;
 		u8 data[16];
 		} *evt_local;
 
@@ -702,8 +656,8 @@
 		evt_local = (struct i2o_reply *)evt_msg;
 		spin_unlock_irqrestore(&i2ob_evt_lock, flags);
 
-		unit = evt_local->header[3];
-		evt = evt_local->evt_indicator;
+		unit = le32_to_cpu(evt_local->header[3]);
+		evt = le32_to_cpu(evt_local->evt_indicator);
 
 		switch(evt)
 		{
@@ -715,7 +669,7 @@
 			 */
 			case I2O_EVT_IND_BSA_VOLUME_LOAD:
 			{
-				struct gendisk *p = i2o_disk[unit>>4];
+				struct gendisk *p = i2ob_disk[unit>>4];
 				i2ob_install_device(i2ob_dev[unit].i2odev->controller, 
 					i2ob_dev[unit].i2odev, unit);
 				add_disk(p);
@@ -730,7 +684,7 @@
 			 */
 			case I2O_EVT_IND_BSA_VOLUME_UNLOAD:
 			{
-				struct gendisk *p = i2o_disk[unit>>4];
+				struct gendisk *p = i2ob_disk[unit>>4];
 				del_gendisk(p);
 				for(i = unit; i <= unit+15; i++)
 					blk_queue_max_sectors(i2ob_dev[i].req_queue, 0);
@@ -762,7 +716,8 @@
 					i2ob_query_device(&i2ob_dev[unit], 0x0000, 4, &size, 8);
 
 				spin_lock_irqsave(I2O_LOCK(unit), flags);	
-				set_capacity(i2o_disk[unit>>4], size>>9);
+				i2ob_sizes[unit] = (int)(size>>10);
+				set_capacity(i2ob_disk[unit>>4], size>>9);
 				spin_unlock_irqrestore(I2O_LOCK(unit), flags);	
 				break;
 			}
@@ -795,8 +750,17 @@
 			 * An event we didn't ask for.  Call the card manufacturer
 			 * and tell them to fix their firmware :)
 			 */
+			 
+			case 0x20:
+				/*
+				 * If a promise card reports 0x20 event then the brown stuff
+				 * hit the fan big time. The card seems to recover but loses
+				 * the pending writes. Deeply ungood except for testing fsck
+				 */
+				if(i2ob_dev[unit].i2odev->controller->bus.pci.promise)
+					panic("I2O controller firmware failed. Reboot and force a filesystem check.\n");
 			default:
-				printk(KERN_INFO "%s: Received event %d we didn't register for\n"
+				printk(KERN_INFO "%s: Received event 0x%X we didn't register for\n"
 					KERN_INFO "   Blame the I2O card manufacturer 8)\n", 
 					i2ob_dev[unit].i2odev->dev_name, evt);
 				break;
@@ -808,69 +772,6 @@
 }
 
 /*
- * The timer handler will attempt to restart requests 
- * that are queued to the driver.  This handler
- * currently only gets called if the controller
- * had no more room in its inbound fifo.  
- */
-
-static void i2ob_timer_handler(unsigned long q)
-{
-	request_queue_t *req_queue = (request_queue_t *) q;
-	unsigned long flags;
-
-	/*
-	 * We cannot touch the request queue or the timer
-         * flag without holding the queue_lock
-	 */
-	spin_lock_irqsave(req_queue->queue_lock,flags);
-
-	/* 
-	 * Clear the timer started flag so that 
-	 * the timer can be queued again.
-	 */
-	i2ob_timer_started = 0;
-
-	/* 
-	 * Restart any requests.
-	 */
-	i2ob_request(req_queue);
-
-	/* 
-	 * Free the lock.
-	 */
-	spin_unlock_irqrestore(req_queue->queue_lock,flags);
-}
-
-static int i2ob_backlog_request(struct i2o_controller *c, struct i2ob_device *dev)
-{
-	u32 m;
-	struct i2ob_request *ireq;
-	
-	while((ireq=i2ob_backlog[c->unit])!=NULL)
-	{
-		int unit;
-
-		if(atomic_read(&i2ob_queues[c->unit]->queue_depth) > dev->depth/4)
-			break;
-
-		m = i2ob_get(dev);
-		if(m == 0xFFFFFFFF)
-			break;
-
-		i2ob_backlog[c->unit] = ireq->next;
-		if(i2ob_backlog[c->unit] == NULL)
-			i2ob_backlog_tail[c->unit] = NULL;
-			
-		unit = minor(ireq->req->rq_dev);
-		i2ob_send(m, dev, ireq, unit);
-	}
-	if(i2ob_backlog[c->unit])
-		return 1;
-	return 0;
-}
-
-/*
  *	The I2O block driver is listed as one of those that pulls the
  *	front entry off the queue before processing it. This is important
  *	to remember here. If we drop the io lock then CURRENT will change
@@ -886,8 +787,7 @@
 	struct i2ob_device *dev;
 	u32 m;
 	
-	
-	while (!blk_queue_empty(q)) {
+	while (blk_queue_empty(q)) {
 		/*
 		 *	On an IRQ completion if there is an inactive
 		 *	request on the queue head it means it isnt yet
@@ -909,49 +809,15 @@
 		if(atomic_read(&i2ob_queues[dev->unit]->queue_depth) >= dev->depth)
 			break;
 		
-		/*
-		 *	Is the channel constipated ?
-		 */
-
-		if(i2ob_backlog[dev->unit]!=NULL)
-			break;
-			
 		/* Get a message */
 		m = i2ob_get(dev);
 
 		if(m==0xFFFFFFFF)
 		{
-			/* 
-			 * See if the timer has already been queued.
-			 */
-			if (!i2ob_timer_started)
-			{
-				DEBUG((KERN_ERR "i2ob: starting timer\n"));
-
-				/*
-				 * Set the timer_started flag to insure
-				 * that the timer is only queued once.
-				 * Queing it more than once will corrupt
-				 * the timer queue.
-				 */
-				i2ob_timer_started = 1;
-
-				/* 
-				 * Set up the timer to expire in
-				 * 500ms.
-				 */
-				i2ob_timer.expires = jiffies + (HZ >> 1);
-				i2ob_timer.data = (unsigned int)q;
-
-				/*
-				 * Start it.
-				 */
-				 
-				add_timer(&i2ob_timer);
-				return;
-			}
+			if(atomic_read(&i2ob_queues[dev->unit]->queue_depth) == 0)
+				printk(KERN_ERR "i2o_block: message queue and request queue empty!!\n");
+			break;
 		}
-
 		/*
 		 * Everything ok, so pull from kernel queue onto our queue
 		 */
@@ -1031,19 +897,47 @@
 static int i2ob_ioctl(struct inode *inode, struct file *file,
 		     unsigned int cmd, unsigned long arg)
 {
-	struct hd_geometry g;
-	int u = minor(inode->i_rdev) >> 4;
+	struct i2ob_device *dev;
+	int minor;
+
 	/* Anyone capable of this syscall can do *real bad* things */
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
-
-	if (cmd != HDIO_GETGEO)
+	if (!inode)
 		return -EINVAL;
-	i2o_block_biosparam(get_capacity(i2o_disk[u]),
-				&g.cylinders, &g.heads, &g.sectors);
-	g.start = get_start_sect(inode->i_bdev);
-	return copy_to_user((void *)arg, &g, sizeof(g)) ? -EFAULT : 0;
+	minor = minor(inode->i_rdev);
+	if (minor >= (MAX_I2OB<<4))
+		return -ENODEV;
+
+	dev = &i2ob_dev[minor];
+	switch (cmd) {
+		case HDIO_GETGEO:
+		{
+			struct hd_geometry g;
+			int u=minor >> 4;
+			i2o_block_biosparam(get_capacity(i2ob_disk[u]), 
+						&g.cylinders, &g.heads, &g.sectors);
+			g.start = get_start_sect(inode->i_bdev);
+			return copy_to_user((void *)arg,&g, sizeof(g))?-EFAULT:0;
+		}
+		
+		case BLKI2OGRSTRAT:
+			return put_user(dev->rcache, (int *)arg);
+		case BLKI2OGWSTRAT:
+			return put_user(dev->wcache, (int *)arg);
+		case BLKI2OSRSTRAT:
+			if(arg<0||arg>CACHE_SMARTFETCH)
+				return -EINVAL;
+			dev->rcache = arg;
+			break;
+		case BLKI2OSWSTRAT:
+			if(arg!=0 && (arg<CACHE_WRITETHROUGH || arg>CACHE_SMARTBACK))
+				return -EINVAL;
+			dev->wcache = arg;
+			break;
+	}
+	return -ENOTTY;
 }
 
 /*
@@ -1081,7 +975,7 @@
 		 */
 		u32 msg[5];
 		int *query_done = &dev->done_flag;
-		msg[0] = FIVE_WORD_MSG_SIZE|SGL_OFFSET_0;
+		msg[0] = (FIVE_WORD_MSG_SIZE|SGL_OFFSET_0);
 		msg[1] = I2O_CMD_BLOCK_CFLUSH<<24|HOST_TID<<12|dev->tid;
 		msg[2] = i2ob_context|0x40000000;
 		msg[3] = (u32)query_done;
@@ -1100,7 +994,17 @@
 		DEBUG("Unlocking...");
 		i2o_post_wait(dev->controller, msg, 20, 2);
 		DEBUG("Unlocked.\n");
-	
+
+		msg[0] = FOUR_WORD_MSG_SIZE|SGL_OFFSET_0;
+		msg[1] = I2O_CMD_BLOCK_POWER<<24 | HOST_TID << 12 | dev->tid;
+		if(dev->flags & (1<<3|1<<4))	/* Removable */
+			msg[4] = 0x21 << 24;
+		else
+			msg[4] = 0x24 << 24;
+
+		if(i2o_post_wait(dev->controller, msg, 20, 60)==0)
+			dev->power = 0x24;
+
 		/*
  		 * Now unclaim the device.
 		 */
@@ -1144,7 +1048,19 @@
 			return -EBUSY;
 		}
 		DEBUG("Claimed ");
-		
+		/*
+	 	 *	Power up if needed
+	 	 */
+
+		if(dev->power > 0x1f)
+		{
+			msg[0] = FOUR_WORD_MSG_SIZE|SGL_OFFSET_0;
+			msg[1] = I2O_CMD_BLOCK_POWER<<24 | HOST_TID << 12 | dev->tid;
+			msg[4] = 0x02 << 24;
+			if(i2o_post_wait(dev->controller, msg, 20, 60) == 0)
+				dev->power = 0x02;
+		}
+
 		/*
 		 *	Mount the media if needed. Note that we don't use
 		 *	the lock bit. Since we have to issue a lock if it
@@ -1191,8 +1107,8 @@
 {
 	u64 size;
 	u32 blocksize;
-	u32 limit;
 	u8 type;
+	u16 power;
 	u32 flags, status;
 	struct i2ob_device *dev=&i2ob_dev[unit];
 	int i;
@@ -1214,35 +1130,40 @@
 		i2ob_query_device(dev, 0x0000, 4, &size, 8);
 	}
 	
+	if(i2ob_query_device(dev, 0x0000, 2, &power, 2)!=0)
+		power = 0;
 	i2ob_query_device(dev, 0x0000, 5, &flags, 4);
 	i2ob_query_device(dev, 0x0000, 6, &status, 4);
-	set_capacity(i2o_disk[unit>>4], size>>9);
-
-	/* Set limit based on inbound frame size */
-	limit = (d->controller->status_block->inbound_frame_size - 8)/2;
-	limit = limit<<9;
+	i2ob_sizes[unit] = (int)(size>>10);
+	set_capacity(i2ob_disk[unit>>4], size>>9);
 
 	/*
 	 * Max number of Scatter-Gather Elements
 	 */	
+
+	i2ob_dev[unit].power = power;	/* Save power state in device proper */
+	i2ob_dev[unit].flags = flags;
+
 	for(i=unit;i<=unit+15;i++)
 	{
 		request_queue_t *q = i2ob_dev[unit].req_queue;
+		
+		i2ob_dev[i].power = power;	/* Save power state */
+		i2ob_dev[unit].flags = flags;	/* Keep the type info */
+		
+		blk_queue_max_sectors(q, 96);	/* 256 might be nicer but many controllers 
+						   explode on 65536 or higher */
+		blk_queue_max_phys_segments(q, (d->controller->status_block->inbound_frame_size - 7) / 2);
+		blk_queue_max_hw_segments(q, (d->controller->status_block->inbound_frame_size - 7) / 2);
+		
+		i2ob_dev[i].rcache = CACHE_SMARTFETCH;
+		i2ob_dev[i].wcache = CACHE_WRITETHROUGH;
+		
+		if(d->controller->battery == 0)
+			i2ob_dev[i].wcache = CACHE_WRITETHROUGH;
 
-		blk_queue_max_sectors(q, 256);
-		blk_queue_max_phys_segments(q, (d->controller->status_block->inbound_frame_size - 8)/2);
-		blk_queue_max_hw_segments(q, (d->controller->status_block->inbound_frame_size - 8)/2);
-
-		if(d->controller->type == I2O_TYPE_PCI && d->controller->bus.pci.queue_buggy == 2)
-			i2ob_dev[i].depth = 32;
-
-		if(d->controller->type == I2O_TYPE_PCI && d->controller->bus.pci.queue_buggy == 1)
-		{
-			blk_queue_max_sectors(q, 32);
-			blk_queue_max_phys_segments(q, 8);
-			blk_queue_max_hw_segments(q, 8);
-			i2ob_dev[i].depth = 4;
-		}
+		if(d->controller->type == I2O_TYPE_PCI && d->controller->bus.pci.promise)
+			i2ob_dev[i].wcache = CACHE_WRITETHROUGH;
 
 		if(d->controller->type == I2O_TYPE_PCI && d->controller->bus.pci.short_req)
 		{
@@ -1252,11 +1173,10 @@
 		}
 	}
 
-
-	strcpy(d->dev_name, i2o_disk[unit>>4]->disk_name);
+	strcpy(d->dev_name, i2ob_disk[unit>>4]->disk_name);
 
 	printk(KERN_INFO "%s: Max segments %d, queue depth %d, byte limit %d.\n",
-		 d->dev_name, i2ob_dev[unit].max_segments, i2ob_dev[unit].depth, limit);
+		 d->dev_name, i2ob_dev[unit].max_segments, i2ob_dev[unit].depth, i2ob_max_sectors[unit]<<9);
 
 	i2ob_query_device(dev, 0x0000, 0, &type, 1);
 
@@ -1272,14 +1192,19 @@
 	}
 	if(status&(1<<10))
 		printk("(RAID)");
-	if(((flags & (1<<3)) && !(status & (1<<3))) ||
-	   ((flags & (1<<4)) && !(status & (1<<4))))
+
+	if((flags^status)&(1<<4|1<<3))	/* Missing media or device */
 	{
 		printk(KERN_INFO " Not loaded.\n");
-		return 1;
+		/* Device missing ? */
+		if((flags^status)&(1<<4))
+			return 1;
+	}
+	else
+	{
+		printk(": %dMB, %d byte sectors",
+			(int)(size>>20), blocksize);
 	}
-	printk(": %dMB, %d byte sectors",
-		(int)(size>>20), blocksize);
 	if(status&(1<<0))
 	{
 		u32 cachesize;
@@ -1289,11 +1214,10 @@
 			printk(", %dMb cache", cachesize>>10);
 		else
 			printk(", %dKb cache", cachesize);
-		
 	}
 	printk(".\n");
 	printk(KERN_INFO "%s: Maximum sectors/read set to %d.\n", 
-		d->dev_name, i2ob_dev[unit].req_queue->max_sectors);
+		d->dev_name, i2ob_max_sectors[unit]);
 
 	/* 
 	 * If this is the first I2O block device found on this IOP,
@@ -1313,14 +1237,17 @@
 	 */
 	dev->req_queue = &i2ob_queues[c->unit]->req_queue;
 
+	/* Register a size before we register for events - otherwise we
+	   might miss and overwrite an event */
+	set_capacity(i2ob_disk[unit>>4], size>>9);
+
 	/*
 	 * Register for the events we're interested in and that the
 	 * device actually supports.
 	 */
+
 	i2o_event_register(c, d->lct_data.tid, i2ob_context, unit, 
 		(I2OB_EVENT_MASK & d->lct_data.event_capabilities));
-
-	set_capacity(i2o_disk[unit>>4], size>>9);
 	return 0;
 }
 
@@ -1332,22 +1259,18 @@
 {
 	int i;
 
-	i2ob_queues[unit] = (struct i2ob_iop_queue*)
-		kmalloc(sizeof(struct i2ob_iop_queue), GFP_ATOMIC);
+	i2ob_queues[unit] = (struct i2ob_iop_queue *) kmalloc(sizeof(struct i2ob_iop_queue), GFP_ATOMIC);
 	if(!i2ob_queues[unit])
 	{
-		printk(KERN_WARNING
-			"Could not allocate request queue for I2O block device!\n");
+		printk(KERN_WARNING "Could not allocate request queue for I2O block device!\n");
 		return -1;
 	}
 
 	for(i = 0; i< MAX_I2OB_DEPTH; i++)
 	{
-		i2ob_queues[unit]->request_queue[i].next = 
-			&i2ob_queues[unit]->request_queue[i+1];
+		i2ob_queues[unit]->request_queue[i].next =  &i2ob_queues[unit]->request_queue[i+1];
 		i2ob_queues[unit]->request_queue[i].num = i;
 	}
-	i2ob_queues[unit]->lock = SPIN_LOCK_UNLOCKED;
 	
 	/* Queue is MAX_I2OB + 1... */
 	i2ob_queues[unit]->request_queue[i].next = NULL;
@@ -1368,8 +1291,6 @@
 	return I2O_UNIT(dev).req_queue;
 }
 
-
-
 /*
  * Probe the I2O subsytem for block class devices
  */
@@ -1389,34 +1310,34 @@
 		if(c==NULL)
 			continue;
 
-	/*
-	 *    The device list connected to the I2O Controller is doubly linked
-	 * Here we traverse the end of the list , and start claiming devices
-	 * from that end. This assures that within an I2O controller atleast
-	 * the newly created volumes get claimed after the older ones, thus
-	 * mapping to same major/minor (and hence device file name) after 
-	 * every reboot.
-	 * The exception being: 
-	 * 1. If there was a TID reuse.
-	 * 2. There was more than one I2O controller. 
-	 */
-
-	if(!bios)
-	{
-		for (d=c->devices;d!=NULL;d=d->next)
-		if(d->next == NULL)
-			b = d;
-	}
-	else
-		b = c->devices;
+		/*
+		 *    The device list connected to the I2O Controller is doubly linked
+		 * Here we traverse the end of the list , and start claiming devices
+		 * from that end. This assures that within an I2O controller atleast
+		 * the newly created volumes get claimed after the older ones, thus
+		 * mapping to same major/minor (and hence device file name) after 
+		 * every reboot.
+		 * The exception being: 
+		 * 1. If there was a TID reuse.
+		 * 2. There was more than one I2O controller. 
+		 */
 
-	while(b != NULL)
-	{
-		d=b;
-		if(bios)
-			b = b->next;
+		if(!bios)
+		{
+			for (d=c->devices;d!=NULL;d=d->next)
+			if(d->next == NULL)
+				b = d;
+		}
 		else
-			b = b->prev;
+			b = c->devices;
+
+		while(b != NULL)
+		{
+			d=b;
+			if(bios)
+				b = b->next;
+			else
+				b = b->prev;
 
 			if(d->lct_data.class_id!=I2O_CLASS_RANDOM_BLOCK_STORAGE)
 				continue;
@@ -1534,8 +1455,7 @@
 
 	if(i2o_claim_device(d, &i2o_block_handler))
 	{
-		printk(KERN_INFO 
-			"i2o_block: Unable to claim device. Installation aborted\n");
+		printk(KERN_INFO "i2o_block: Unable to claim device. Installation aborted\n");
 		return;
 	}
 
@@ -1599,7 +1519,7 @@
 	 * This will force errors when i2ob_get_queue() is called
 	 * by the kenrel.
 	 */
-	del_gendisk(i2o_disk[unit>>4]);
+	del_gendisk(i2ob_disk[unit>>4]);
 	i2ob_dev[unit].req_queue = NULL;
 	for(i = unit; i <= unit+15; i++)
 	{
@@ -1709,7 +1629,7 @@
  *  (Just smiley confuses emacs :-)
  */
 
-static int __init i2o_block_init(void)
+static int i2o_block_init(void)
 {
 	int i;
 
@@ -1725,10 +1645,11 @@
 		       MAJOR_NR);
 		return -EIO;
 	}
+
 	for (i = 0; i < MAX_I2OB; i++) {
 		struct gendisk *disk = alloc_disk();
 		if (!disk)
-			goto Enomem;
+			goto oom;
 		i2o_disk[i] = disk;
 	}
 #ifdef MODULE
@@ -1740,7 +1661,7 @@
 	 */
 	 
 	blk_dev[MAJOR_NR].queue = i2ob_get_queue;
-	
+
 	for (i = 0; i < MAX_I2OB << 4; i++) {
 		i2ob_dev[i].refcnt = 0;
 		i2ob_dev[i].flags = 0;
@@ -1750,10 +1671,12 @@
 		i2ob_dev[i].head = NULL;
 		i2ob_dev[i].tail = NULL;
 		i2ob_dev[i].depth = MAX_I2OB_DEPTH;
+		i2ob_blksizes[i] = 1024;
+		i2ob_max_sectors[i] = 2;
 	}
-
+	
 	for (i = 0; i < MAX_I2OB; i++) {
-		struct gendisk *disk = i2o_disk[i];
+		struct gendisk *disk = i2ob_disk + i;
 		disk->major = MAJOR_NR;
 		disk->first_minor = i<<4;
 		disk->minor_shift = 4;
@@ -1770,14 +1693,6 @@
 	}
 
 	/*
-	 *	Timers
-	 */
-	 
-	init_timer(&i2ob_timer);
-	i2ob_timer.function = i2ob_timer_handler;
-	i2ob_timer.data = 0;
-	
-	/*
 	 *	Register the OSM handler as we will need this to probe for
 	 *	drives, geometry and other goodies.
 	 */
@@ -1785,6 +1700,7 @@
 	if(i2o_install_handler(&i2o_block_handler)<0)
 	{
 		unregister_blkdev(MAJOR_NR, "i2o_block");
+		blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
 		printk(KERN_ERR "i2o_block: unable to register OSM.\n");
 		return -EINVAL;
 	}
@@ -1803,21 +1719,19 @@
 		return 0;
 	}
 
-	/*
-	 *	Finally see what is actually plugged in to our controllers
-	 */
-
 	i2ob_probe();
 
 	return 0;
-Enomem:
+
+oom:
 	while (i--)
 		put_disk(i2o_disk[i]);
 	unregister_blkdev(MAJOR_NR, "i2o_block");
 	return -ENOMEM;
 }
 
-static void __exit i2o_block_exit(void)
+
+static void i2o_block_exit(void)
 {
 	int i;
 	
@@ -1863,10 +1777,10 @@
 	 */
 
 	i2o_remove_handler(&i2o_block_handler);
-
+		 
 	for (i = 0; i < MAX_I2OB; i++)
 		put_disk(i2o_disk[i]);
- 
+
 	/*
 	 *	Return the block device
 	 */
@@ -1874,9 +1788,9 @@
 		printk("i2o_block: cleanup_module failed\n");
 }
 
-MODULE_AUTHOR("Red Hat Software");
+MODULE_AUTHOR("Red Hat");
 MODULE_DESCRIPTION("I2O Block Device OSM");
 MODULE_LICENSE("GPL");
 
-module_init(i2o_block_init)
-module_exit(i2o_block_exit)
+module_init(i2o_block_init);
+module_exit(i2o_block_exit);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/message/i2o/i2o_core.c linux.2.5.41-ac1/drivers/message/i2o/i2o_core.c
--- linux.2.5.41/drivers/message/i2o/i2o_core.c	2002-10-02 21:33:16.000000000 +0100
+++ linux.2.5.41-ac1/drivers/message/i2o/i2o_core.c	2002-10-08 00:39:59.000000000 +0100
@@ -42,11 +42,11 @@
 #include <linux/wait.h>
 #include <linux/delay.h>
 #include <linux/timer.h>
-#include <linux/tqueue.h>
 #include <linux/interrupt.h>
 #include <linux/sched.h>
 #include <asm/semaphore.h>
 #include <linux/completion.h>
+#include <linux/workqueue.h>
 
 #include <asm/io.h>
 #include <linux/reboot.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/message/i2o/i2o_proc.c linux.2.5.41-ac1/drivers/message/i2o/i2o_proc.c
--- linux.2.5.41/drivers/message/i2o/i2o_proc.c	2002-10-02 21:33:16.000000000 +0100
+++ linux.2.5.41-ac1/drivers/message/i2o/i2o_proc.c	2002-10-08 00:42:09.000000000 +0100
@@ -45,9 +45,9 @@
 #include <linux/proc_fs.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/tqueue.h>
 #include <linux/errno.h>
 #include <linux/spinlock.h>
+#include <linux/workqueue.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/message/i2o/i2o_scsi.c linux.2.5.41-ac1/drivers/message/i2o/i2o_scsi.c
--- linux.2.5.41/drivers/message/i2o/i2o_scsi.c	2002-10-02 21:32:55.000000000 +0100
+++ linux.2.5.41-ac1/drivers/message/i2o/i2o_scsi.c	2002-10-05 22:29:21.000000000 +0100
@@ -1,13 +1,18 @@
 /* 
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2, or (at your option) any
- *  later version.
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
  *
- *  This program is distributed in the hope that it will be useful, but
- *  WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * For the purpose of avoiding doubt the preferred form of the work
+ * for making modifications shall be a standards compliant form such
+ * gzipped tar and not one requiring a proprietary or patent encumbered
+ * tool to unpack.
  *
  *  Complications for I2O scsi
  *
@@ -56,7 +61,7 @@
 #include "../../scsi/sd.h"
 #include "i2o_scsi.h"
 
-#define VERSION_STRING        "Version 0.0.1"
+#define VERSION_STRING        "Version 0.1.0"
 
 #define dprintk(x)
 
@@ -77,6 +82,7 @@
 static u32 *retry[32];
 static struct i2o_controller *retry_ctrl[32];
 static struct timer_list retry_timer;
+static spinlock_t retry_lock;
 static int retry_ct = 0;
 
 static atomic_t queue_depth;
@@ -121,14 +127,11 @@
 	int i;
 	unsigned long flags;
 	
-	save_flags(flags);
-	cli();
-
+	spin_lock_irqsave(&retry_lock, flags);
 	for(i=0;i<retry_ct;i++)
 		i2o_post_message(retry_ctrl[i], virt_to_bus(retry[i]));
 	retry_ct=0;
-	
-	restore_flags(flags);
+	spin_unlock_irqrestore(&retry_lock, flags);
 }
 
 static void flush_pending(void)
@@ -136,9 +139,7 @@
 	int i;
 	unsigned long flags;
 	
-	save_flags(flags);
-	cli();
-
+	spin_lock_irqsave(&retry_lock, flags);
 	for(i=0;i<retry_ct;i++)
 	{
 		retry[i][0]&=~0xFFFFFF;
@@ -146,8 +147,7 @@
 		i2o_post_message(retry_ctrl[i],virt_to_bus(retry[i]));
 	}
 	retry_ct=0;
-	
-	restore_flags(flags);
+	spin_unlock_irqrestore(&retry_lock, flags);
 }
 
 static void i2o_scsi_reply(struct i2o_handler *h, struct i2o_controller *c, struct i2o_message *msg)
@@ -156,6 +156,7 @@
 	spinlock_t *lock;
 	u32 *m = (u32 *)msg;
 	u8 as,ds,st;
+	unsigned long flags;
 
 	if(m[0] & (1<<13))
 	{
@@ -177,6 +178,9 @@
 		m=(u32 *)bus_to_virt(m[7]);
 		printk("Failing message is %p.\n", m);
 		
+		/* This isnt a fast path .. */
+		spin_lock_irqsave(&retry_lock, flags);
+		
 		if((m[4]&(1<<18)) && retry_ct < 32)
 		{
 			retry_ctrl[retry_ct]=c;
@@ -186,18 +190,20 @@
 				retry_timer.expires=jiffies+1;
 				add_timer(&retry_timer);
 			}
+			spin_unlock_irqrestore(&retry_lock, flags);
 		}
 		else
 		{
+			spin_unlock_irqrestore(&retry_lock, flags);
 			/* Create a scsi error for this */
 			current_command = (Scsi_Cmnd *)m[3];
-			lock = &current_command->host->host_lock;
+			lock = current_command->host->host_lock;
 			printk("Aborted %ld\n", current_command->serial_number);
 
-			spin_lock_irq(lock);
+			spin_lock_irqsave(lock, flags);
 			current_command->result = DID_ERROR << 16;
 			current_command->scsi_done(current_command);
-			spin_unlock_irq(lock);
+			spin_unlock_irqrestore(lock, flags);
 			
 			/* Now flush the message by making it a NOP */
 			m[0]&=0x00FFFFFF;
@@ -214,9 +220,9 @@
 	 *	Low byte is device status, next is adapter status,
 	 *	(then one byte reserved), then request status.
 	 */
-	ds=(u8)m[4]; 
-	as=(u8)(m[4]>>8);
-	st=(u8)(m[4]>>24);
+	ds=(u8)le32_to_cpu(m[4]);
+	as=(u8)le32_to_cpu(m[4]>>8);
+	st=(u8)le32_to_cpu(m[4]>>24);
 	
 	dprintk(("i2o got a scsi reply %08X: ", m[0]));
 	dprintk(("m[2]=%08X: ", m[2]));
@@ -233,7 +239,10 @@
 		printk(KERN_ERR "i2o_scsi: bus reset reply.\n");
 		return;
 	}
-	
+	/*
+ 	 *	FIXME: 64bit breakage
+	 */
+
 	current_command = (Scsi_Cmnd *)m[3];
 	
 	/*
@@ -254,11 +263,11 @@
 	
 	if(st == 0x06)
 	{
-		if(m[5] < current_command->underflow)
+		if(le32_to_cpu(m[5]) < current_command->underflow)
 		{
 			int i;
 			printk(KERN_ERR "SCSI: underflow 0x%08X 0x%08X\n",
-				m[5], current_command->underflow);
+				le32_to_cpu(m[5]), current_command->underflow);
 			printk("Cmd: ");
 			for(i=0;i<15;i++)
 				printk("%02X ", current_command->cmnd[i]);
@@ -286,10 +295,10 @@
 		 *	It worked maybe ?
 		 */		
 		current_command->result = DID_OK << 16 | ds;
-	lock = &current_command->host->host_lock;
-	spin_lock(lock);
+	lock = current_command->host->host_lock;
+	spin_lock_irqsave(lock, flags);
 	current_command->scsi_done(current_command);
-	spin_unlock(lock);
+	spin_unlock_irqrestore(lock, flags);
 	return;
 }
 
@@ -322,7 +331,7 @@
 	return 0;
 }
 
-void i2o_scsi_init(struct i2o_controller *c, struct i2o_device *d, struct Scsi_Host *shpnt)
+static void i2o_scsi_init(struct i2o_controller *c, struct i2o_device *d, struct Scsi_Host *shpnt)
 {
 	struct i2o_device *unit;
 	struct i2o_scsi_host *h =(struct i2o_scsi_host *)shpnt->hostdata;
@@ -382,7 +391,7 @@
 	}		
 }
 
-int i2o_scsi_detect(Scsi_Host_Template * tpnt)
+static int i2o_scsi_detect(Scsi_Host_Template * tpnt)
 {
 	unsigned long flags;
 	struct Scsi_Host *shpnt = NULL;
@@ -476,7 +485,7 @@
 	return count;
 }
 
-int i2o_scsi_release(struct Scsi_Host *host)
+static int i2o_scsi_release(struct Scsi_Host *host)
 {
 	if(--i2o_scsi_hosts==0)
 	{
@@ -493,45 +502,14 @@
 }
 
 
-const char *i2o_scsi_info(struct Scsi_Host *SChost)
+static const char *i2o_scsi_info(struct Scsi_Host *SChost)
 {
 	struct i2o_scsi_host *hostdata;
-
 	hostdata = (struct i2o_scsi_host *)SChost->hostdata;
-
 	return(&hostdata->controller->name[0]);
 }
 
-
-/*
- * From the wd93 driver:
- * Returns true if there will be a DATA_OUT phase with this command, 
- * false otherwise.
- * (Thanks to Joerg Dorchain for the research and suggestion.)
- *
- */
-static int is_dir_out(Scsi_Cmnd *cmd)
-{
-	switch (cmd->cmnd[0]) 
-	{
-     		case WRITE_6:           case WRITE_10:          case WRITE_12:
-      		case WRITE_LONG:        case WRITE_SAME:        case WRITE_BUFFER:
-      		case WRITE_VERIFY:      case WRITE_VERIFY_12:      
-      		case COMPARE:           case COPY:              case COPY_VERIFY:
-      		case SEARCH_EQUAL:      case SEARCH_HIGH:       case SEARCH_LOW:
-      		case SEARCH_EQUAL_12:   case SEARCH_HIGH_12:    case SEARCH_LOW_12:      
-      		case FORMAT_UNIT:       case REASSIGN_BLOCKS:   case RESERVE:
-      		case MODE_SELECT:       case MODE_SELECT_10:    case LOG_SELECT:
-      		case SEND_DIAGNOSTIC:   case CHANGE_DEFINITION: case UPDATE_BLOCK:
-      		case SET_WINDOW:        case MEDIUM_SCAN:       case SEND_VOLUME_TAG:
-      		case 0xea:
-        		return 1;
-		default:
-        		return 0;
-	}
-}
-
-int i2o_scsi_queuecommand(Scsi_Cmnd * SCpnt, void (*done) (Scsi_Cmnd *))
+static int i2o_scsi_queuecommand(Scsi_Cmnd * SCpnt, void (*done) (Scsi_Cmnd *))
 {
 	int i;
 	int tid;
@@ -597,9 +575,10 @@
 	do
 	{
 		mb();
-		m = I2O_POST_READ32(c);
+		m = le32_to_cpu(I2O_POST_READ32(c));
 	}
 	while(m==0xFFFFFFFF);
+
 	msg = (u32 *)(c->mem_offset + m);
 	
 	/*
@@ -609,28 +588,29 @@
 	len = SCpnt->request_bufflen;
 	direction = 0x00000000;			// SGL IN  (osm<--iop)
 	
-	/*
-	 *	The scsi layer should be handling this stuff
-	 */
-	
-	scsidir = 0x00000000;			// DATA NO XFER
-	if(len)
+	if(SCpnt->sc_data_direction == SCSI_DATA_NONE)
+		scsidir = 0x00000000;			// DATA NO XFER
+	else if(SCpnt->sc_data_direction == SCSI_DATA_WRITE)
 	{
-		if(is_dir_out(SCpnt))
-		{
-			direction=0x04000000;	// SGL OUT  (osm-->iop)
-			scsidir  =0x80000000;	// DATA OUT (iop-->dev)
-		}
-		else
-		{
-			scsidir  =0x40000000;	// DATA IN  (iop<--dev)
-		}
+		direction=0x04000000;	// SGL OUT  (osm-->iop)
+		scsidir  =0x80000000;	// DATA OUT (iop-->dev)
+	}
+	else if(SCpnt->sc_data_direction == SCSI_DATA_READ)
+	{
+		scsidir  =0x40000000;	// DATA IN  (iop<--dev)
+	}
+	else
+	{
+		/* Unknown - kill the command */
+		SCpnt->result = DID_NO_CONNECT << 16;
+		done(SCpnt);
+		return 0;
 	}
 	
-	__raw_writel(I2O_CMD_SCSI_EXEC<<24|HOST_TID<<12|tid, &msg[1]);
-	__raw_writel(scsi_context, &msg[2]);	/* So the I2O layer passes to us */
+	i2o_raw_writel(I2O_CMD_SCSI_EXEC<<24|HOST_TID<<12|tid, &msg[1]);
+	i2o_raw_writel(scsi_context, &msg[2]);	/* So the I2O layer passes to us */
 	/* Sorry 64bit folks. FIXME */
-	__raw_writel((u32)SCpnt, &msg[3]);	/* We want the SCSI control block back */
+	i2o_raw_writel((u32)SCpnt, &msg[3]);	/* We want the SCSI control block back */
 
 	/* LSI_920_PCI_QUIRK
 	 *
@@ -673,7 +653,7 @@
 	}
 
 	/* Direction, disconnect ok, tag, CDBLen */
-	__raw_writel(scsidir|0x20000000|SCpnt->cmd_len|tag, &msg[4]);
+	i2o_raw_writel(scsidir|0x20000000|SCpnt->cmd_len|tag, &msg[4]);
 
 	mptr=msg+5;
 
@@ -708,8 +688,8 @@
 			/*
 			 *	Need to chain!
 			 */
-			__raw_writel(direction|0xB0000000|(SCpnt->use_sg*2*4), mptr++);
-			__raw_writel(virt_to_bus(sg_chain_pool + sg_chain_tag), mptr);
+			i2o_raw_writel(direction|0xB0000000|(SCpnt->use_sg*2*4), mptr++);
+			i2o_raw_writel(virt_to_bus(sg_chain_pool + sg_chain_tag), mptr);
 			mptr = (u32*)(sg_chain_pool + sg_chain_tag);
 			if (SCpnt->use_sg > max_sg_len)
 			{
@@ -723,7 +703,7 @@
 			{
 				*mptr++=direction|0x10000000|sg->length;
 				len+=sg->length;
-				*mptr++=virt_to_bus(sg->address);
+				*mptr++=virt_to_bus(page_address(sg->page)+sg->offset);
 				sg++;
 			}
 			mptr[-2]=direction|0xD0000000|(sg-1)->length;
@@ -732,22 +712,22 @@
 		{		
 			for(i = 0 ; i < SCpnt->use_sg; i++)
 			{
-				__raw_writel(direction|0x10000000|sg->length, mptr++);
+				i2o_raw_writel(direction|0x10000000|sg->length, mptr++);
 				len+=sg->length;
-				__raw_writel(virt_to_bus(sg->address), mptr++);
+				i2o_raw_writel(virt_to_bus(page_address(sg->page) + sg->offset), mptr++);
 				sg++;
 			}
 
 			/* Make this an end of list. Again evade the 920 bug and
 			   unwanted PCI read traffic */
 		
-			__raw_writel(direction|0xD0000000|(sg-1)->length, &mptr[-2]);
+			i2o_raw_writel(direction|0xD0000000|(sg-1)->length, &mptr[-2]);
 		}
 		
 		if(!chain)
 			reqlen = mptr - msg;
 		
-		__raw_writel(len, lenptr);
+		i2o_raw_writel(len, lenptr);
 		
 		if(len != SCpnt->underflow)
 			printk("Cmd len %08X Cmd underflow %08X\n",
@@ -757,15 +737,15 @@
 	{
 		dprintk(("non sg for %p, %d\n", SCpnt->request_buffer,
 				SCpnt->request_bufflen));
-		__raw_writel(len = SCpnt->request_bufflen, lenptr);
+		i2o_raw_writel(len = SCpnt->request_bufflen, lenptr);
 		if(len == 0)
 		{
 			reqlen = 9;
 		}
 		else
 		{
-			__raw_writel(0xD0000000|direction|SCpnt->request_bufflen, mptr++);
-			__raw_writel(virt_to_bus(SCpnt->request_buffer), mptr++);
+			i2o_raw_writel(0xD0000000|direction|SCpnt->request_bufflen, mptr++);
+			i2o_raw_writel(virt_to_bus(SCpnt->request_buffer), mptr++);
 		}
 	}
 	
@@ -773,7 +753,7 @@
 	 *	Stick the headers on 
 	 */
 
-	__raw_writel(reqlen<<16 | SGL_OFFSET_10, msg);
+	i2o_raw_writel(reqlen<<16 | SGL_OFFSET_10, msg);
 	
 	/* Queue the message */
 	i2o_post_message(c,m);
@@ -797,7 +777,7 @@
 	SCpnt->SCp.Status++;
 }
 
-int i2o_scsi_command(Scsi_Cmnd * SCpnt)
+static int i2o_scsi_command(Scsi_Cmnd * SCpnt)
 {
 	i2o_scsi_queuecommand(SCpnt, internal_done);
 	SCpnt->SCp.Status = 0;
@@ -811,7 +791,7 @@
 	struct i2o_controller *c;
 	struct Scsi_Host *host;
 	struct i2o_scsi_host *hostdata;
-	u32 *msg;
+	unsigned long msg;
 	u32 m;
 	int tid;
 	
@@ -835,30 +815,30 @@
 	do
 	{
 		mb();
-		m = I2O_POST_READ32(c);
+		m = le32_to_cpu(I2O_POST_READ32(c));
 	}
 	while(m==0xFFFFFFFF);
-	msg = (u32 *)(c->mem_offset + m);
+	msg = c->mem_offset + m;
 	
-	__raw_writel(FIVE_WORD_MSG_SIZE, &msg[0]);
-	__raw_writel(I2O_CMD_SCSI_ABORT<<24|HOST_TID<<12|tid, &msg[1]);
-	__raw_writel(scsi_context, &msg[2]);
-	__raw_writel(0, &msg[3]);	/* Not needed for an abort */
-	__raw_writel((u32)SCpnt, &msg[4]);	
+	i2o_raw_writel(FIVE_WORD_MSG_SIZE, msg);
+	i2o_raw_writel(I2O_CMD_SCSI_ABORT<<24|HOST_TID<<12|tid, msg+4);
+	i2o_raw_writel(scsi_context, msg+8);
+	i2o_raw_writel(0, msg+12);	/* Not needed for an abort */
+	i2o_raw_writel((u32)SCpnt, msg+16);	
 	wmb();
 	i2o_post_message(c,m);
 	wmb();
 	return SCSI_ABORT_PENDING;
 }
 
-int i2o_scsi_reset(Scsi_Cmnd * SCpnt, unsigned int reset_flags)
+static int i2o_scsi_reset(Scsi_Cmnd * SCpnt, unsigned int reset_flags)
 {
 	int tid;
 	struct i2o_controller *c;
 	struct Scsi_Host *host;
 	struct i2o_scsi_host *hostdata;
 	u32 m;
-	u32 *msg;
+	unsigned long msg;
 
 	/*
 	 *	Find the TID for the bus
@@ -877,7 +857,7 @@
 	 *	possibly ?
 	 */
 	 
-	m = I2O_POST_READ32(c);
+	m = le32_to_cpu(I2O_POST_READ32(c));
 	
 	/*
 	 *	No free messages, try again next time - no big deal
@@ -886,13 +866,13 @@
 	if(m == 0xFFFFFFFF)
 		return SCSI_RESET_PUNT;
 	
-	msg = (u32 *)(c->mem_offset + m);
-	__raw_writel(FOUR_WORD_MSG_SIZE|SGL_OFFSET_0, &msg[0]);
-	__raw_writel(I2O_CMD_SCSI_BUSRESET<<24|HOST_TID<<12|tid, &msg[1]);
-	__raw_writel(scsi_context|0x80000000, &msg[2]);
+	msg = c->mem_offset + m;
+	i2o_raw_writel(FOUR_WORD_MSG_SIZE|SGL_OFFSET_0, msg);
+	i2o_raw_writel(I2O_CMD_SCSI_BUSRESET<<24|HOST_TID<<12|tid, msg+4);
+	i2o_raw_writel(scsi_context|0x80000000, msg+8);
 	/* We use the top bit to split controller and unit transactions */
 	/* Now store unit,tid so we can tie the completion back to a specific device */
-	__raw_writel(c->unit << 16 | tid, &msg[3]);
+	__raw_writel(c->unit << 16 | tid, msg+12);
 	wmb();
 	i2o_post_message(c,m);
 	return SCSI_RESET_PENDING;
@@ -902,7 +882,7 @@
  *	This is anyones guess quite frankly.
  */
  
-int i2o_scsi_bios_param(Disk * disk, struct block_device *dev, int *ip)
+static int i2o_scsi_bios_param(Disk * disk, struct block_device *dev, int *ip)
 {
 	int size;
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/message/i2o/i2o_scsi.h linux.2.5.41-ac1/drivers/message/i2o/i2o_scsi.h
--- linux.2.5.41/drivers/message/i2o/i2o_scsi.h	2002-10-02 21:32:55.000000000 +0100
+++ linux.2.5.41-ac1/drivers/message/i2o/i2o_scsi.h	2002-10-05 22:07:06.000000000 +0100
@@ -14,15 +14,14 @@
 #define I2O_SCSI_CAN_QUEUE 4
 #define I2O_SCSI_CMD_PER_LUN 6
 
-extern int i2o_scsi_detect(Scsi_Host_Template *);
-extern const char *i2o_scsi_info(struct Scsi_Host *);
-extern int i2o_scsi_command(Scsi_Cmnd *);
-extern int i2o_scsi_queuecommand(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
-extern int i2o_scsi_abort(Scsi_Cmnd *);
-extern int i2o_scsi_reset(Scsi_Cmnd *, unsigned int);
-extern int i2o_scsi_bios_param(Disk *, struct block_device *, int *);
-extern void i2o_scsi_setup(char *str, int *ints);
-extern int i2o_scsi_release(struct Scsi_Host *host);
+static int i2o_scsi_detect(Scsi_Host_Template *);
+static const char *i2o_scsi_info(struct Scsi_Host *);
+static int i2o_scsi_command(Scsi_Cmnd *);
+static int i2o_scsi_queuecommand(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
+static int i2o_scsi_abort(Scsi_Cmnd *);
+static int i2o_scsi_reset(Scsi_Cmnd *, unsigned int);
+static int i2o_scsi_bios_param(Disk *, struct block_device *, int *);
+static int i2o_scsi_release(struct Scsi_Host *host);
 
 #define I2OSCSI {                                          \
 		  next: NULL,				    \
