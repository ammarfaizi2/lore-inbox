Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262313AbSJIS1z>; Wed, 9 Oct 2002 14:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262298AbSJIS1y>; Wed, 9 Oct 2002 14:27:54 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35333 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262297AbSJIS0m>; Wed, 9 Oct 2002 14:26:42 -0400
Subject: PATCH: bring i2o_scsi further into line with 2.5
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Wed, 9 Oct 2002 19:23:56 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17zLUy-0006L8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/message/i2o/i2o_scsi.c linux.2.5.41-ac2/drivers/message/i2o/i2o_scsi.c
--- linux.2.5.41/drivers/message/i2o/i2o_scsi.c	2002-10-02 21:32:55.000000000 +0100
+++ linux.2.5.41-ac2/drivers/message/i2o/i2o_scsi.c	2002-10-09 18:44:32.000000000 +0100
@@ -1,13 +1,19 @@
 /* 
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2, or (at your option) any
- *  later version.
- *
- *  This program is distributed in the hope that it will be useful, but
- *  WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * For the avoidance of doubt the "preferred form" of this code is one which
+ * is in an open non patent encumbered format. Where cryptographic key signing
+ * forms part of the process of creating an executable the information
+ * including keys needed to generate an equivalently functional executable
+ * are deemed to be part of the source code.
  *
  *  Complications for I2O scsi
  *
@@ -56,7 +62,7 @@
 #include "../../scsi/sd.h"
 #include "i2o_scsi.h"
 
-#define VERSION_STRING        "Version 0.0.1"
+#define VERSION_STRING        "Version 0.1.1"
 
 #define dprintk(x)
 
@@ -77,6 +83,7 @@
 static u32 *retry[32];
 static struct i2o_controller *retry_ctrl[32];
 static struct timer_list retry_timer;
+static spinlock_t retry_lock;
 static int retry_ct = 0;
 
 static atomic_t queue_depth;
@@ -108,7 +115,10 @@
 static int sg_chain_tag = 0;
 static int sg_max_frags = SG_MAX_FRAGS;
 
-/*
+/**
+ *	i2o_retry_run		-	retry on timeout
+ *	@f: unused
+ *
  *	Retry congested frames. This actually needs pushing down into
  *	i2o core. We should only bother the OSM with this when we can't
  *	queue and retry the frame. Or perhaps we should call the OSM
@@ -121,24 +131,26 @@
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
 
+/**
+ *	flush_pending		-	empty the retry queue
+ *
+ *	Turn each of the pending commands into a NOP and post it back
+ *	to the controller to clear it.
+ */
+ 
 static void flush_pending(void)
 {
 	int i;
 	unsigned long flags;
 	
-	save_flags(flags);
-	cli();
-
+	spin_lock_irqsave(&retry_lock, flags);
 	for(i=0;i<retry_ct;i++)
 	{
 		retry[i][0]&=~0xFFFFFF;
@@ -146,16 +158,30 @@
 		i2o_post_message(retry_ctrl[i],virt_to_bus(retry[i]));
 	}
 	retry_ct=0;
-	
-	restore_flags(flags);
+	spin_unlock_irqrestore(&retry_lock, flags);
 }
 
+/**
+ *	i2o_scsi_reply		-	scsi message reply processor
+ *	@h: our i2o handler
+ *	@c: controller issuing the reply
+ *	@msg: the message from the controller (mapped)
+ *
+ *	Process reply messages (interrupts in normal scsi controller think).
+ *	We can get a variety of messages to process. The normal path is
+ *	scsi command completions. We must also deal with IOP failures,
+ *	the reply to a bus reset and the reply to a LUN query.
+ *
+ *	Locks: the queue lock is taken to call the completion handler
+ */
+
 static void i2o_scsi_reply(struct i2o_handler *h, struct i2o_controller *c, struct i2o_message *msg)
 {
 	Scsi_Cmnd *current_command;
 	spinlock_t *lock;
 	u32 *m = (u32 *)msg;
 	u8 as,ds,st;
+	unsigned long flags;
 
 	if(m[0] & (1<<13))
 	{
@@ -177,6 +203,9 @@
 		m=(u32 *)bus_to_virt(m[7]);
 		printk("Failing message is %p.\n", m);
 		
+		/* This isnt a fast path .. */
+		spin_lock_irqsave(&retry_lock, flags);
+		
 		if((m[4]&(1<<18)) && retry_ct < 32)
 		{
 			retry_ctrl[retry_ct]=c;
@@ -186,18 +215,20 @@
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
@@ -214,14 +245,14 @@
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
 	dprintk(("m[4]=%08X\n", m[4]));
-
+ 
 	if(m[2]&0x80000000)
 	{
 		if(m[2]&0x40000000)
@@ -230,10 +261,13 @@
 			lun_done=1;
 			return;
 		}
-		printk(KERN_ERR "i2o_scsi: bus reset reply.\n");
+		printk(KERN_INFO "i2o_scsi: bus reset completed.\n");
 		return;
 	}
-	
+	/*
+ 	 *	FIXME: 64bit breakage
+	 */
+
 	current_command = (Scsi_Cmnd *)m[3];
 	
 	/*
@@ -254,11 +288,11 @@
 	
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
@@ -286,10 +320,10 @@
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
 
@@ -304,6 +338,18 @@
 	I2O_CLASS_SCSI_PERIPHERAL
 };
 
+/**
+ *	i2o_find_lun		-	report the lun of an i2o device
+ *	@c: i2o controller owning the device
+ *	@d: i2o disk device
+ *	@target: filled in with target id
+ *	@lun: filled in with target lun
+ *
+ *	Query an I2O device to find out its SCSI lun and target numbering. We
+ *	don't currently handle some of the fancy SCSI-3 stuff although our
+ *	querying is sufficient to do so.
+ */
+ 
 static int i2o_find_lun(struct i2o_controller *c, struct i2o_device *d, int *target, int *lun)
 {
 	u8 reply[8];
@@ -322,7 +368,20 @@
 	return 0;
 }
 
-void i2o_scsi_init(struct i2o_controller *c, struct i2o_device *d, struct Scsi_Host *shpnt)
+/**
+ *	i2o_scsi_init		-	initialize an i2o device for scsi
+ *	@c: i2o controller owning the device
+ *	@d: scsi controller
+ *	@shpnt: scsi device we wish it to become
+ *
+ *	Enumerate the scsi peripheral/fibre channel peripheral class
+ *	devices that are children of the controller. From that we build
+ *	a translation map for the command queue code. Since I2O works on
+ *	its own tid's we effectively have to think backwards to get what
+ *	the midlayer wants
+ */
+ 
+static void i2o_scsi_init(struct i2o_controller *c, struct i2o_device *d, struct Scsi_Host *shpnt)
 {
 	struct i2o_device *unit;
 	struct i2o_scsi_host *h =(struct i2o_scsi_host *)shpnt->hostdata;
@@ -382,14 +441,24 @@
 	}		
 }
 
-int i2o_scsi_detect(Scsi_Host_Template * tpnt)
+/**
+ *	i2o_scsi_detect		-	probe for I2O scsi devices
+ *	@tpnt: scsi layer template
+ *
+ *	I2O is a little odd here. The I2O core already knows what the
+ *	devices are. It also knows them by disk and tape as well as
+ *	by controller. We register each I2O scsi class object as a
+ *	scsi controller and then let the enumeration fake up the rest
+ */
+ 
+static int i2o_scsi_detect(Scsi_Host_Template * tpnt)
 {
 	unsigned long flags;
 	struct Scsi_Host *shpnt = NULL;
 	int i;
 	int count;
 
-	printk("i2o_scsi.c: %s\n", VERSION_STRING);
+	printk(KERN_INFO "i2o_scsi.c: %s\n", VERSION_STRING);
 
 	if(i2o_install_handler(&i2o_scsi_handler)<0)
 	{
@@ -400,14 +469,14 @@
 	
 	if((sg_chain_pool = kmalloc(SG_CHAIN_POOL_SZ, GFP_KERNEL)) == NULL)
 	{
-		printk("i2o_scsi: Unable to alloc %d byte SG chain buffer pool.\n", SG_CHAIN_POOL_SZ);
-		printk("i2o_scsi: SG chaining DISABLED!\n");
+		printk(KERN_INFO "i2o_scsi: Unable to alloc %d byte SG chain buffer pool.\n", SG_CHAIN_POOL_SZ);
+		printk(KERN_INFO "i2o_scsi: SG chaining DISABLED!\n");
 		sg_max_frags = 11;
 	}
 	else
 	{
-		printk("  chain_pool: %d bytes @ %p\n", SG_CHAIN_POOL_SZ, sg_chain_pool);
-		printk("  (%d byte buffers X %d can_queue X %d i2o controllers)\n",
+		printk(KERN_INFO "  chain_pool: %d bytes @ %p\n", SG_CHAIN_POOL_SZ, sg_chain_pool);
+		printk(KERN_INFO "  (%d byte buffers X %d can_queue X %d i2o controllers)\n",
 				SG_CHAIN_BUF_SZ, I2O_SCSI_CAN_QUEUE, i2o_num_controllers);
 		sg_max_frags = SG_MAX_FRAGS;    // 64
 	}
@@ -447,14 +516,11 @@
 			shpnt = scsi_register(tpnt, sizeof(struct i2o_scsi_host));
 			if(shpnt==NULL)
 				continue;
-			save_flags(flags);
-			cli();
 			shpnt->unique_id = (u32)d;
 			shpnt->io_port = 0;
 			shpnt->n_io_port = 0;
 			shpnt->irq = 0;
 			shpnt->this_id = /* Good question */15;
-			restore_flags(flags);
 			i2o_scsi_init(c, d, shpnt);
 			count++;
 		}
@@ -476,7 +542,7 @@
 	return count;
 }
 
-int i2o_scsi_release(struct Scsi_Host *host)
+static int i2o_scsi_release(struct Scsi_Host *host)
 {
 	if(--i2o_scsi_hosts==0)
 	{
@@ -493,45 +559,28 @@
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
+/**
+ *	i2o_scsi_queuecommand	-	queue a SCSI command
+ *	@SCpnt: scsi command pointer
+ *	@done: callback for completion
+ *
+ *	Issue a scsi comamnd asynchronously. Return 0 on success or 1 if
+ *	we hit an error (normally message queue congestion). The only 
+ *	minor complication here is that I2O deals with the device addressing
+ *	so we have to map the bus/dev/lun back to an I2O handle as well
+ *	as faking absent devices ourself. 
+ *
+ *	Locks: takes the controller lock on error path only
+ */
+ 
+static int i2o_scsi_queuecommand(Scsi_Cmnd * SCpnt, void (*done) (Scsi_Cmnd *))
 {
 	int i;
 	int tid;
@@ -547,6 +596,7 @@
 	u32 len;
 	u32 reqlen;
 	u32 tag;
+	unsigned long flags;
 	
 	static int max_qd = 1;
 	
@@ -582,24 +632,23 @@
 	if(tid == -1)
 	{
 		SCpnt->result = DID_NO_CONNECT << 16;
+		spin_lock_irqsave(host->host_lock, flags);
 		done(SCpnt);
+		spin_unlock_irqrestore(host->host_lock, flags);
 		return 0;
 	}
 	
 	dprintk(("Real scsi messages.\n"));
 
-	
 	/*
-	 *	Obtain an I2O message. Right now we _have_ to obtain one
-	 *	until the scsi layer stuff is cleaned up.
+	 *	Obtain an I2O message. If there are none free then 
+	 *	throw it back to the scsi layer
 	 */	
 	 
-	do
-	{
-		mb();
-		m = I2O_POST_READ32(c);
-	}
-	while(m==0xFFFFFFFF);
+	m = le32_to_cpu(I2O_POST_READ32(c));
+	if(m==0xFFFFFFFF)
+		return 1;
+
 	msg = (u32 *)(c->mem_offset + m);
 	
 	/*
@@ -609,28 +658,33 @@
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
+		
+		/* We must lock the request queue while completing */
+		spin_lock_irqsave(host->host_lock, flags);
+		done(SCpnt);
+		spin_unlock_irqrestore(host->host_lock, flags);
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
@@ -673,7 +727,7 @@
 	}
 
 	/* Direction, disconnect ok, tag, CDBLen */
-	__raw_writel(scsidir|0x20000000|SCpnt->cmd_len|tag, &msg[4]);
+	i2o_raw_writel(scsidir|0x20000000|SCpnt->cmd_len|tag, &msg[4]);
 
 	mptr=msg+5;
 
@@ -708,8 +762,8 @@
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
@@ -723,7 +777,7 @@
 			{
 				*mptr++=direction|0x10000000|sg->length;
 				len+=sg->length;
-				*mptr++=virt_to_bus(sg->address);
+				*mptr++=virt_to_bus(page_address(sg->page)+sg->offset);
 				sg++;
 			}
 			mptr[-2]=direction|0xD0000000|(sg-1)->length;
@@ -732,22 +786,22 @@
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
@@ -757,15 +811,15 @@
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
 	
@@ -773,7 +827,7 @@
 	 *	Stick the headers on 
 	 */
 
-	__raw_writel(reqlen<<16 | SGL_OFFSET_10, msg);
+	i2o_raw_writel(reqlen<<16 | SGL_OFFSET_10, msg);
 	
 	/* Queue the message */
 	i2o_post_message(c,m);
@@ -792,12 +846,26 @@
 	return 0;
 }
 
+/**
+ *	internal_done	-	legacy scsi glue
+ *	@SCPnt: command
+ *
+ *	Completion function for a synchronous command
+ */
+
 static void internal_done(Scsi_Cmnd * SCpnt)
 {
 	SCpnt->SCp.Status++;
 }
 
-int i2o_scsi_command(Scsi_Cmnd * SCpnt)
+/**
+ *	i2o_scsi_command	-	issue a scsi command and wait
+ *	@SCPnt: command
+ *
+ *	Issue a SCSI command and wait for it to complete.
+ */
+ 
+static int i2o_scsi_command(Scsi_Cmnd * SCpnt)
 {
 	i2o_scsi_queuecommand(SCpnt, internal_done);
 	SCpnt->SCp.Status = 0;
@@ -806,65 +874,90 @@
 	return SCpnt->result;
 }
 
+/**
+ *	i2o_scsi_abort	-	abort a running command
+ *	@SCpnt: command to abort
+ *
+ *	Ask the I2O controller to abort a command. This is an asynchrnous
+ *	process and oru callback handler will see the command complete
+ *	with an aborted message if it succeeds. 
+ *
+ *	Locks: no locks are held or needed
+ */
+ 
 int i2o_scsi_abort(Scsi_Cmnd * SCpnt)
 {
 	struct i2o_controller *c;
 	struct Scsi_Host *host;
 	struct i2o_scsi_host *hostdata;
-	u32 *msg;
+	unsigned long msg;
 	u32 m;
 	int tid;
 	
-	printk("i2o_scsi: Aborting command block.\n");
+	printk(KERN_WARNING "i2o_scsi: Aborting command block.\n");
 	
 	host = SCpnt->host;
 	hostdata = (struct i2o_scsi_host *)host->hostdata;
 	tid = hostdata->task[SCpnt->target][SCpnt->lun];
 	if(tid==-1)
 	{
-		printk(KERN_ERR "impossible command to abort.\n");
-		return SCSI_ABORT_NOT_RUNNING;
+		printk(KERN_ERR "i2o_scsi: Impossible command to abort!\n");
+		return FAILED;
 	}
 	c = hostdata->controller;
 	
 	/*
 	 *	Obtain an I2O message. Right now we _have_ to obtain one
 	 *	until the scsi layer stuff is cleaned up.
+	 *
+	 *	FIXME: we are in error context so we could sleep retry
+	 * 	a bit and then bail in the improved scsi layer.
 	 */	
 	 
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
-	return SCSI_ABORT_PENDING;
+	return SUCCESS;
 }
 
-int i2o_scsi_reset(Scsi_Cmnd * SCpnt, unsigned int reset_flags)
+/**
+ *	i2o_scsi_bus_reset		-	Issue a SCSI reset
+ *	@SCpnt: the command that caused the reset
+ *
+ *	Perform a SCSI bus reset operation. In I2O this is just a message
+ *	we pass. I2O can do clever multi-initiator and shared reset stuff
+ *	but we don't support this.
+ *
+ *	Locks: called with no lock held, requires no locks.
+ */
+ 
+static int i2o_scsi_bus_reset(Scsi_Cmnd * SCpnt)
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
 	 */
 
-	printk("i2o_scsi: Attempting to reset the bus.\n");
+	printk(KERN_WARNING "i2o_scsi: Attempting to reset the bus.\n");
 	
 	host = SCpnt->host;
 	hostdata = (struct i2o_scsi_host *)host->hostdata;
@@ -877,7 +970,7 @@
 	 *	possibly ?
 	 */
 	 
-	m = I2O_POST_READ32(c);
+	m = le32_to_cpu(I2O_POST_READ32(c));
 	
 	/*
 	 *	No free messages, try again next time - no big deal
@@ -886,23 +979,55 @@
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
-	return SCSI_RESET_PENDING;
+	return SUCCESS;
 }
 
-/*
- *	This is anyones guess quite frankly.
+/**
+ *	i2o_scsi_host_reset	-	host reset callback
+ *	@SCpnt: command causing the reset
+ *
+ *	An I2O controller can be many things at once. While we can
+ *	reset a controller the potential mess from doing so is vast, and
+ *	it's better to simply hold on and pray
+ */
+ 
+static int i2o_scsi_host_reset(Scsi_Cmnd * SCpnt)
+{
+	return FAILED;
+}
+
+/**
+ *	i2o_scsi_device_reset	-	device reset callback
+ *	@SCpnt: command causing the reset
+ *
+ *	I2O does not (AFAIK) support doing a device reset
+ */
+ 
+static int i2o_scsi_device_reset(Scsi_Cmnd * SCpnt)
+{
+	return FAILED;
+}
+
+/**
+ *	i2o_scsi_bios_param	-	Invent disk geometry
+ *	@disk: device 
+ *	@dev: block layer device
+ *	@ip: geometry array
+ *
+ *	This is anyones guess quite frankly. We use the same rules everyone 
+ *	else appears to and hope. It seems to work.
  */
  
-int i2o_scsi_bios_param(Disk * disk, struct block_device *dev, int *ip)
+static int i2o_scsi_bios_param(Disk * disk, struct block_device *dev, int *ip)
 {
 	int size;
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/message/i2o/i2o_scsi.h linux.2.5.41-ac2/drivers/message/i2o/i2o_scsi.h
--- linux.2.5.41/drivers/message/i2o/i2o_scsi.h	2002-10-02 21:32:55.000000000 +0100
+++ linux.2.5.41-ac2/drivers/message/i2o/i2o_scsi.h	2002-10-09 18:39:58.000000000 +0100
@@ -1,12 +1,6 @@
 #ifndef _I2O_SCSI_H
 #define _I2O_SCSI_H
 
-#if !defined(LINUX_VERSION_CODE)
-#include <linux/version.h>
-#endif
-
-#define LinuxVersionCode(v, p, s) (((v)<<16)+((p)<<8)+(s))
-
 #include <linux/types.h>
 #include <linux/kdev_t.h>
 
@@ -14,34 +8,37 @@
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
-
-#define I2OSCSI {                                          \
-		  next: NULL,				    \
-                  proc_name:         "i2o_scsi",   \
-                  name:              "I2O SCSI Layer", 	    \
-                  detect:            i2o_scsi_detect,       \
-                  release:	     i2o_scsi_release,	    \
-                  info:              i2o_scsi_info,         \
-                  command:           i2o_scsi_command,      \
-                  queuecommand:      i2o_scsi_queuecommand, \
-                  abort:             i2o_scsi_abort,        \
-                  reset:             i2o_scsi_reset,        \
-                  bios_param:        i2o_scsi_bios_param,   \
-                  can_queue:         I2O_SCSI_CAN_QUEUE,    \
-                  this_id:           I2O_SCSI_ID,           \
-                  sg_tablesize:      8,                     \
-                  cmd_per_lun:       I2O_SCSI_CMD_PER_LUN,  \
-                  unchecked_isa_dma: 0,                     \
-                  use_clustering:    ENABLE_CLUSTERING     \
+static int i2o_scsi_detect(Scsi_Host_Template *);
+static const char *i2o_scsi_info(struct Scsi_Host *);
+static int i2o_scsi_command(Scsi_Cmnd *);
+static int i2o_scsi_queuecommand(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
+static int i2o_scsi_abort(Scsi_Cmnd *);
+static int i2o_scsi_bus_reset(Scsi_Cmnd *);
+static int i2o_scsi_host_reset(Scsi_Cmnd *);
+static int i2o_scsi_device_reset(Scsi_Cmnd *);
+static int i2o_scsi_bios_param(Disk *, struct block_device *, int *);
+static int i2o_scsi_release(struct Scsi_Host *host);
+
+#define I2OSCSI {                                       		\
+		  next: NULL,						\
+                  proc_name:         		"i2o_scsi",   		\
+                  name:              		"I2O SCSI Layer", 	\
+                  detect:            		i2o_scsi_detect,	\
+                  release:	     		i2o_scsi_release,	\
+                  info:              		i2o_scsi_info,		\
+                  command:           		i2o_scsi_command,	\
+                  queuecommand:      		i2o_scsi_queuecommand,	\
+                  eh_abort_handler:             i2o_scsi_abort,		\
+                  eh_bus_reset_handler:         i2o_scsi_bus_reset,	\
+                  eh_device_reset_handler:      i2o_scsi_device_reset,	\
+                  eh_host_reset_handler:	i2o_scsi_host_reset,	\
+  		  bios_param:        i2o_scsi_bios_param,   		\
+                  can_queue:         I2O_SCSI_CAN_QUEUE,    		\
+                  this_id:           I2O_SCSI_ID,           		\
+                  sg_tablesize:      8,                     		\
+                  cmd_per_lun:       I2O_SCSI_CMD_PER_LUN,  		\
+                  unchecked_isa_dma: 0,                     		\
+                  use_clustering:    ENABLE_CLUSTERING     		\
                   }
 
 #endif
