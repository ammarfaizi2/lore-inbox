Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286712AbSBKCzZ>; Sun, 10 Feb 2002 21:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286821AbSBKCzR>; Sun, 10 Feb 2002 21:55:17 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45065 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286712AbSBKCzH>; Sun, 10 Feb 2002 21:55:07 -0500
Subject: I2O patches
To: linux-kernel@vger.kernel.org
Date: Mon, 11 Feb 2002 03:08:51 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16a6po-0005Ht-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just seperated this out quickly for anyone with I2O afflictions who wants
to give it a spin. It also fixes the ASUS board problem where I2O and many
other devices will fail or corrupt disk/mem due to stupid BIOS settings

--- linux.18p8/drivers/pci/quirks.c	Wed Feb  6 06:44:36 2002
+++ linux.18p8-ac1/drivers/pci/quirks.c	Sun Feb 10 19:41:26 2002
@@ -444,13 +444,15 @@
 static void __init quirk_amd_ordering(struct pci_dev *dev)
 {
 	u32 pcic;
-	
-	pci_read_config_dword(dev, 0x42, &pcic);
-	if((pcic&2)==0)
+	pci_read_config_dword(dev, 0x4C, &pcic);
+	if((pcic&6)!=6)
 	{
-		pcic |= 2;
-		printk(KERN_WARNING "BIOS disabled PCI ordering compliance, so we enabled it again.\n");
-		pci_write_config_dword(dev, 0x42, pcic);		
+		pcic |= 6;
+		printk(KERN_WARNING "BIOS failed to enable PCI standards compliance, fixing this error.\n");
+		pci_write_config_dword(dev, 0x4C, pcic);
+		pci_read_config_dword(dev, 0x84, &pcic);
+		pcic |= (1<<23);	/* Required in this mode */
+		pci_write_config_dword(dev, 0x84, pcic);
 	}
 }
 
--- linux.18p8/drivers/message/i2o/i2o_block.c	Wed Feb  6 06:45:01 2002
+++ linux.18p8-ac1/drivers/message/i2o/i2o_block.c	Sun Feb 10 18:11:42 2002
@@ -282,6 +282,7 @@
 	
 	if(req->cmd == READ)
 	{
+		DEBUG("READ\n");
 		__raw_writel(I2O_CMD_BLOCK_READ<<24|HOST_TID<<12|tid, msg+4);
 		while(bh!=NULL)
 		{
@@ -321,6 +322,7 @@
 	}
 	else if(req->cmd == WRITE)
 	{
+		DEBUG("WRITE\n");
 		__raw_writel(I2O_CMD_BLOCK_WRITE<<24|HOST_TID<<12|tid, msg+4);
 		while(bh!=NULL)
 		{
@@ -415,6 +417,7 @@
 	 * It is now ok to complete the request.
 	 */
 	end_that_request_last( req );
+	DEBUG("IO COMPLETED\n");
 }
 
 /*
@@ -493,7 +496,7 @@
 	__raw_writel(i2ob_context|(unit<<8), msg+8);
 	__raw_writel(0, msg+12);
 	__raw_writel(60<<16, msg+16);
-	
+	DEBUG("FLUSH");
 	i2o_post_message(c,m);
 	return 0;
 }
@@ -522,6 +525,7 @@
 	 */
 	if(m[0] & (1<<13))
 	{
+		DEBUG("FAIL");
 		/*
 		 * FAILed message from controller
 		 * We increment the error count and abort it
@@ -561,7 +565,7 @@
 	{
 		spin_lock_irqsave(&io_request_lock, flags);
 		dev->constipated=0;
-		DEBUG(("unconstipated\n"));
+		DEBUG("unconstipated\n");
 		if(i2ob_backlog_request(c, dev)==0)
 			i2ob_request(dev->req_queue);
 		spin_unlock_irqrestore(&io_request_lock, flags);
@@ -861,7 +865,7 @@
 			 * and tell them to fix their firmware :)
 			 */
 			default:
-				printk(KERN_INFO "%s: Received event %d we didn't register for\n"
+				printk(KERN_INFO "%s: Received event 0x%X we didn't register for\n"
 					KERN_INFO "   Blame the I2O card manufacturer 8)\n", 
 					i2ob_dev[unit].i2odev->dev_name, evt);
 				break;
@@ -1205,9 +1209,6 @@
 	if(!dev->i2odev)
 		return 0;
 
-	/* Sync the device so we don't get errors */
-	fsync_dev(inode->i_rdev);
-
 	if (dev->refcnt <= 0)
 		printk(KERN_ALERT "i2ob_release: refcount(%d) <= 0\n", dev->refcnt);
 	dev->refcnt--;
@@ -1470,19 +1471,16 @@
 {
 	int i;
 
-	i2ob_queues[unit] = (struct i2ob_iop_queue*)
-		kmalloc(sizeof(struct i2ob_iop_queue), GFP_ATOMIC);
+	i2ob_queues[unit] = (struct i2ob_iop_queue*) kmalloc(sizeof(struct i2ob_iop_queue), GFP_ATOMIC);
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
 	
@@ -1507,7 +1505,6 @@
 static request_queue_t* i2ob_get_queue(kdev_t dev)
 {
 	int unit = MINOR(dev)&0xF0;
-
 	return i2ob_dev[unit].req_queue;
 }
 
@@ -1530,34 +1527,34 @@
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
--- linux.18p8/drivers/message/i2o/i2o_core.c	Wed Feb  6 06:47:16 2002
+++ linux.18p8-ac1/drivers/message/i2o/i2o_core.c	Sun Feb 10 17:39:23 2002
@@ -208,7 +208,7 @@
  
 static DECLARE_MUTEX(evt_sem);
 static DECLARE_COMPLETION(evt_dead);
-DECLARE_WAIT_QUEUE_HEAD(evt_wait);
+static DECLARE_WAIT_QUEUE_HEAD(evt_wait);
 
 static struct notifier_block i2o_reboot_notifier =
 {
@@ -2559,6 +2559,7 @@
 int i2o_post_wait_mem(struct i2o_controller *c, u32 *msg, int len, int timeout, void *mem1, void *mem2)
 {
 	DECLARE_WAIT_QUEUE_HEAD(wq_i2o_post);
+	DECLARE_WAITQUEUE(wait, current);
 	int complete = 0;
 	int status;
 	unsigned long flags = 0;
@@ -2599,12 +2600,19 @@
 	 *	complete will be zero.  From the point post_this returns
 	 *	the wait_data may have been deleted.
 	 */
+
+	add_wait_queue(&wq_i2o_post, &wait);
+	set_current_state(TASK_INTERRUPTIBLE);
 	if ((status = i2o_post_this(c, msg, len))==0) {
-		sleep_on_timeout(&wq_i2o_post, HZ * timeout);
+		schedule_timeout(HZ * timeout);
 	}  
 	else
+	{
+		remove_wait_queue(&wq_i2o_post, &wait);
 		return -EIO;
-		
+	}
+	remove_wait_queue(&wq_i2o_post, &wait);
+
 	if(signal_pending(current))
 		status = -EINTR;
 		
--- linux.18p8/include/linux/i2o.h	Wed Feb  6 06:43:46 2002
+++ linux.18p8-ac1/include/linux/i2o.h	Sun Feb 10 18:17:21 2002
@@ -252,34 +252,34 @@
  */
 static inline u32 I2O_POST_READ32(struct i2o_controller *c)
 {
-	return *c->post_port;
+	return readl(c->post_port);
 }
 
-static inline void I2O_POST_WRITE32(struct i2o_controller *c, u32 Val)
+static inline void I2O_POST_WRITE32(struct i2o_controller *c, u32 val)
 {
-	*c->post_port = Val;
+	writel(val, c->post_port);
 }
 
 
 static inline u32 I2O_REPLY_READ32(struct i2o_controller *c)
 {
-	return *c->reply_port;
+	return readl(c->reply_port);
 }
 
-static inline void I2O_REPLY_WRITE32(struct i2o_controller *c, u32 Val)
+static inline void I2O_REPLY_WRITE32(struct i2o_controller *c, u32 val)
 {
-	*c->reply_port = Val;
+	writel(val, c->reply_port);
 }
 
 
 static inline u32 I2O_IRQ_READ32(struct i2o_controller *c)
 {
-	return *c->irq_mask;
+	return readl(c->irq_mask);
 }
 
-static inline void I2O_IRQ_WRITE32(struct i2o_controller *c, u32 Val)
+static inline void I2O_IRQ_WRITE32(struct i2o_controller *c, u32 val)
 {
-	*c->irq_mask = Val;
+	writel(val, c->irq_mask);
 }
 
 
