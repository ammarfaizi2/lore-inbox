Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287634AbSAEJq6>; Sat, 5 Jan 2002 04:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287629AbSAEJqu>; Sat, 5 Jan 2002 04:46:50 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:62692 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S287634AbSAEJqf>; Sat, 5 Jan 2002 04:46:35 -0500
Date: Sat, 5 Jan 2002 01:46:34 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Patch: linux-2.5.2-pre6/drivers/message/i2o/i2o_block.c compilation fixes
Message-ID: <20020105014634.A22037@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	The following patch fixes various compilation errors in
linux-2.5.2-pre8/drivers/message/i2o/i2o_block.c, related to
kdev_t and the new spinlock parameter to blk_init_queue.
It might be a good idea for someone to look at the spinlocks
that I created for blk_init_queue in this patch and tell me if
I botched it.

	As is the case with the other patches that I have been
submitted for the past couple of days, I only know that this code
compiles.  It has not been otherwise tested.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="i2o.diff"

diff -u -r1.1.1.8 i2o_block.c
--- linux/drivers/message/i2o/i2o_block.c	2002/01/02 00:13:11	1.1.1.8
+++ linux/drivers/message/i2o/i2o_block.c	2002/01/05 09:41:00
@@ -114,7 +114,7 @@
 #define I2O_BSA_DSC_VOLUME_CHANGED      0x000D
 #define I2O_BSA_DSC_TIMEOUT             0x000E
 
-#define I2O_UNIT(dev)	(i2ob_dev[MINOR((dev)) & 0xf0])
+#define I2O_UNIT(dev)	(i2ob_dev[minor((dev)) & 0xf0])
 #define I2O_LOCK(unit)	(i2ob_dev[(unit)].req_queue->queue_lock)
 
 /*
@@ -172,6 +172,7 @@
 	struct i2ob_request request_queue[MAX_I2OB_DEPTH];
 	struct i2ob_request *i2ob_qhead;
 	request_queue_t req_queue;
+	spinlock_t queue_lock;
 };
 static struct i2ob_iop_queue *i2ob_queues[MAX_I2O_CONTROLLERS];
 static struct i2ob_request *i2ob_backlog[MAX_I2O_CONTROLLERS];
@@ -216,6 +217,7 @@
 static int evt_pid = 0;
 static int evt_running = 0;
 static int scan_unit = 0;
+static spinlock_t default_queue_lock = SPIN_LOCK_UNLOCKED;
 
 /*
  * I2O OSM registration structure...keeps getting bigger and bigger :)
@@ -320,7 +322,7 @@
 		else
 			__raw_writel((8<<24)|(1<<16)|4, msg+16);
 	}
-	else if(req->cmd == WRITE)
+	else
 	{
 		__raw_writel(I2O_CMD_BLOCK_WRITE<<24|HOST_TID<<12|tid, msg+4);
 		while(bio)
@@ -476,10 +478,10 @@
 		ireq=&i2ob_queues[c->unit]->request_queue[m[3]];
 		ireq->req->errors++;
 
-		spin_lock_irqsave(&I2O_LOCK(c->unit), flags);
+		spin_lock_irqsave(I2O_LOCK(c->unit), flags);
 		i2ob_unhook_request(ireq, c->unit);
 		i2ob_end_request(ireq->req);
-		spin_unlock_irqrestore(&I2O_LOCK(c->unit), flags);
+		spin_unlock_irqrestore(I2O_LOCK(c->unit), flags);
 	
 		/* Now flush the message by making it a NOP */
 		m[0]&=0x00FFFFFF;
@@ -500,12 +502,12 @@
 
 	if(msg->function == I2O_CMD_BLOCK_CFLUSH)
 	{
-		spin_lock_irqsave(&I2O_LOCK(c->unit), flags);
+		spin_lock_irqsave(I2O_LOCK(c->unit), flags);
 		dev->constipated=0;
 		DEBUG(("unconstipated\n"));
 		if(i2ob_backlog_request(c, dev)==0)
 			i2ob_request(dev->req_queue);
-		spin_unlock_irqrestore(&I2O_LOCK(c->unit), flags);
+		spin_unlock_irqrestore(I2O_LOCK(c->unit), flags);
 		return;
 	}
 
@@ -521,10 +523,10 @@
 		ireq=&i2ob_queues[c->unit]->request_queue[m[3]];
 		ireq->req->errors++;
 		printk(KERN_WARNING "I2O Block: Data transfer to deleted device!\n");
-		spin_lock_irqsave(&I2O_LOCK(c->unit), flags);
+		spin_lock_irqsave(I2O_LOCK(c->unit), flags);
 		i2ob_unhook_request(ireq, c->unit);
 		i2ob_end_request(ireq->req);
-		spin_unlock_irqrestore(&I2O_LOCK(c->unit), flags);
+		spin_unlock_irqrestore(I2O_LOCK(c->unit), flags);
 		return;
 	}	
 
@@ -570,7 +572,7 @@
 		 */
 		 
 		
-		spin_lock_irqsave(&I2O_LOCK(c->unit), flags);
+		spin_lock_irqsave(I2O_LOCK(c->unit), flags);
 		if(err==4)
 		{
 			/*
@@ -615,7 +617,7 @@
 			 */
 			 
 			i2ob_request(dev->req_queue);
-			spin_unlock_irqrestore(&I2O_LOCK(c->unit), flags);
+			spin_unlock_irqrestore(I2O_LOCK(c->unit), flags);
 			
 			/*
 			 *	and out
@@ -623,7 +625,7 @@
 			 
 			return;	
 		}
-		spin_unlock_irqrestore(&I2O_LOCK(c->unit), flags);
+		spin_unlock_irqrestore(I2O_LOCK(c->unit), flags);
 		printk(KERN_ERR "\n/dev/%s error: %s", dev->i2odev->dev_name, 
 			bsa_errors[m[4]&0XFFFF]);
 		if(m[4]&0x00FF0000)
@@ -639,7 +641,7 @@
 	 *	may be running polled controllers from a BH...
 	 */
 
-	spin_lock_irqsave(&I2O_LOCK(c->unit), flags);
+	spin_lock_irqsave(I2O_LOCK(c->unit), flags);
 	i2ob_unhook_request(ireq, c->unit);
 	i2ob_end_request(ireq->req);
 	atomic_dec(&i2ob_queues[c->unit]->queue_depth);
@@ -651,7 +653,7 @@
 	if(i2ob_backlog_request(c, dev)==0)
 		i2ob_request(dev->req_queue);
 
-	spin_unlock_irqrestore(&I2O_LOCK(c->unit), flags);
+	spin_unlock_irqrestore(I2O_LOCK(c->unit), flags);
 }
 
 /* 
@@ -758,17 +760,17 @@
 			{
 				u64 size;
 
-				if(do_i2ob_revalidate(MKDEV(MAJOR_NR, unit),0) != -EBUSY)
+				if(do_i2ob_revalidate(mk_kdev(MAJOR_NR, unit),0) != -EBUSY)
 					continue;
 
 	  			if(i2ob_query_device(&i2ob_dev[unit], 0x0004, 0, &size, 8) !=0 )
 					i2ob_query_device(&i2ob_dev[unit], 0x0000, 4, &size, 8);
 
-				spin_lock_irqsave(&I2O_LOCK(unit), flags);	
+				spin_lock_irqsave(I2O_LOCK(unit), flags);	
 				i2ob_sizes[unit] = (int)(size>>10);
 				i2ob_gendisk.part[unit].nr_sects = size>>9;
 				i2ob[unit].nr_sects = (int)(size>>9);
-				spin_unlock_irqrestore(&I2O_LOCK(unit), flags);	
+				spin_unlock_irqrestore(I2O_LOCK(unit), flags);	
 				break;
 			}
 
@@ -828,7 +830,7 @@
 	 * We cannot touch the request queue or the timer
          * flag without holding the queue_lock
 	 */
-	spin_lock_irqsave(&req_queue->queue_lock,flags);
+	spin_lock_irqsave(req_queue->queue_lock,flags);
 
 	/* 
 	 * Clear the timer started flag so that 
@@ -844,7 +846,7 @@
 	/* 
 	 * Free the lock.
 	 */
-	spin_unlock_irqrestore(&req_queue->queue_lock,flags);
+	spin_unlock_irqrestore(req_queue->queue_lock,flags);
 }
 
 static int i2ob_backlog_request(struct i2o_controller *c, struct i2ob_device *dev)
@@ -867,7 +869,7 @@
 		if(i2ob_backlog[c->unit] == NULL)
 			i2ob_backlog_tail[c->unit] = NULL;
 			
-		unit = MINOR(ireq->req->rq_dev);
+		unit = minor(ireq->req->rq_dev);
 		i2ob_send(m, dev, ireq, i2ob[unit].start_sect, unit);
 	}
 	if(i2ob_backlog[c->unit])
@@ -903,7 +905,7 @@
 		if(req->rq_status == RQ_INACTIVE)
 			return;
 			
-		unit = MINOR(req->rq_dev);
+		unit = minor(req->rq_dev);
 		dev = &i2ob_dev[(unit&0xF0)];
 
 		/* 
@@ -1036,22 +1038,22 @@
  
 static int do_i2ob_revalidate(kdev_t dev, int maxu)
 {
-	int minor=MINOR(dev);
+	int index=minor(dev);
 	int i;
-	
-	minor&=0xF0;
+
+	index&=0xF0;
 
-	i2ob_dev[minor].refcnt++;
-	if(i2ob_dev[minor].refcnt>maxu+1)
+	i2ob_dev[index].refcnt++;
+	if(i2ob_dev[index].refcnt>maxu+1)
 	{
-		i2ob_dev[minor].refcnt--;
+		i2ob_dev[index].refcnt--;
 		return -EBUSY;
 	}
 	
 	for( i = 15; i>=0 ; i--)
 	{
-		int m = minor+i;
-		invalidate_device(MKDEV(MAJOR_NR, m), 1);
+		int m = index+i;
+		invalidate_device(mk_kdev(MAJOR_NR, m), 1);
 		i2ob_gendisk.part[m].start_sect = 0;
 		i2ob_gendisk.part[m].nr_sects = 0;
 	}
@@ -1060,9 +1062,9 @@
 	 *	Do a physical check and then reconfigure
 	 */
 	 
-	i2ob_install_device(i2ob_dev[minor].controller, i2ob_dev[minor].i2odev,
-		minor);
-	i2ob_dev[minor].refcnt--;
+	i2ob_install_device(i2ob_dev[index].controller, i2ob_dev[index].i2odev,
+		index);
+	i2ob_dev[index].refcnt--;
 	return 0;
 }
 
@@ -1077,14 +1079,14 @@
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
-	if (!inode || !inode->i_rdev)
+	if (!inode || kdev_none(inode->i_rdev))
 		return -EINVAL;
 
 	switch (cmd) {
 		case HDIO_GETGEO:
 		{
 			struct hd_geometry g;
-			int u = MINOR(inode->i_rdev) & 0xF0;
+			int u = minor(inode->i_rdev) & 0xF0;
 			i2o_block_biosparam(i2ob_sizes[u]<<1, 
 				&g.cylinders, &g.heads, &g.sectors);
 			g.start = get_start_sect(inode->i_rdev);
@@ -1119,12 +1121,12 @@
 static int i2ob_release(struct inode *inode, struct file *file)
 {
 	struct i2ob_device *dev;
-	int minor;
+	int index;
 
-	minor = MINOR(inode->i_rdev);
-	if (minor >= (MAX_I2OB<<4))
+	index = minor(inode->i_rdev);
+	if (index >= (MAX_I2OB<<4))
 		return -ENODEV;
-	dev = &i2ob_dev[(minor&0xF0)];
+	dev = &i2ob_dev[(index&0xF0)];
 
 	/*
 	 * This is to deail with the case of an application
@@ -1188,15 +1190,15 @@
  
 static int i2ob_open(struct inode *inode, struct file *file)
 {
-	int minor;
+	int index;
 	struct i2ob_device *dev;
 	
 	if (!inode)
 		return -EINVAL;
-	minor = MINOR(inode->i_rdev);
-	if (minor >= MAX_I2OB<<4)
+	index = minor(inode->i_rdev);
+	if (index >= MAX_I2OB<<4)
 		return -ENODEV;
-	dev=&i2ob_dev[(minor&0xF0)];
+	dev=&i2ob_dev[(index&0xF0)];
 
 	if(!dev->i2odev)	
 		return -ENODEV;
@@ -1384,7 +1386,7 @@
 	 */
 	dev->req_queue = &i2ob_queues[c->unit]->req_queue;
 
-	grok_partitions(MKDEV(MAJOR_NR, unit), (long)(size>>9));
+	grok_partitions(mk_kdev(MAJOR_NR, unit), (long)(size>>9));
 
 	/*
 	 * Register for the events we're interested in and that the
@@ -1425,7 +1427,9 @@
 	i2ob_queues[unit]->i2ob_qhead = &i2ob_queues[unit]->request_queue[0];
 	atomic_set(&i2ob_queues[unit]->queue_depth, 0);
 
-	blk_init_queue(&i2ob_queues[unit]->req_queue, i2ob_request);
+	spin_lock_init(&i2ob_queues[unit]->queue_lock);
+	blk_init_queue(&i2ob_queues[unit]->req_queue, i2ob_request,
+		       &i2ob_queues[unit]->queue_lock);
 	i2ob_queues[unit]->req_queue.queuedata = &i2ob_queues[unit];
 
 	return 0;
@@ -1638,7 +1642,7 @@
 	int i = 0;
 	unsigned long flags;
 
-	spin_lock_irqsave(&I2O_LOCK(c->unit), flags);
+	spin_lock_irqsave(I2O_LOCK(c->unit), flags);
 
 	/*
 	 * Need to do this...we somtimes get two events from the IRTOS
@@ -1660,7 +1664,7 @@
 	if(unit >= MAX_I2OB<<4)
 	{
 		printk(KERN_ERR "i2ob_del_device called, but not in dev table!\n");
-		spin_unlock_irqrestore(&I2O_LOCK(c->unit), flags);
+		spin_unlock_irqrestore(I2O_LOCK(c->unit), flags);
 		return;
 	}
 
@@ -1677,7 +1681,7 @@
 		i2ob[i].nr_sects = 0;
 		i2ob_gendisk.part[i].nr_sects = 0;
 	}
-	spin_unlock_irqrestore(&I2O_LOCK(c->unit), flags);
+	spin_unlock_irqrestore(I2O_LOCK(c->unit), flags);
 
 	/*
 	 * Decrease usage count for module
@@ -1704,7 +1708,7 @@
  */
 static int i2ob_media_change(kdev_t dev)
 {
-	int i=MINOR(dev);
+	int i=minor(dev);
 	i>>=4;
 	if(i2ob_media_change_flag[i])
 	{
@@ -1822,7 +1826,8 @@
 	blk_size[MAJOR_NR] = i2ob_sizes;
 	blk_dev[MAJOR_NR].queue = i2ob_get_queue;
 	
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), i2ob_request);
+	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), i2ob_request,
+		       &default_queue_lock);
 
 	for (i = 0; i < MAX_I2OB << 4; i++) {
 		i2ob_dev[i].refcnt = 0;
@@ -1883,7 +1888,7 @@
 	 *	Finally see what is actually plugged in to our controllers
 	 */
 	for (i = 0; i < MAX_I2OB; i++)
-		register_disk(&i2ob_gendisk, MKDEV(MAJOR_NR,i<<4), 1<<4,
+		register_disk(&i2ob_gendisk, mk_kdev(MAJOR_NR,i<<4), 1<<4,
 			&i2ob_fops, 0);
 	i2ob_probe();
 

--uAKRQypu60I7Lcqm--
