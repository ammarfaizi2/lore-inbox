Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268392AbUIBPIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268392AbUIBPIN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 11:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268370AbUIBPIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 11:08:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8403 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268392AbUIBPG2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 11:06:28 -0400
Date: Thu, 2 Sep 2004 11:06:20 -0400
From: Alan Cox <alan@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Test Patch: Further I2O cleanups
Message-ID: <20040902150620.GA1123@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mix of some stuff I was sitting on pending Markus work and some other
newer stuff. This kills all but one virt_to_bus/bus_to_virt use, fixes some
writes to PCI ioremap space not done via writel, removes a chunk of code that
we can make the scsi layer do for us. It also has some further hackery to
try and get promise hw to work properly.

diff -u --new-file --recursive --exclude-from /usr/src/exclude -p linux.vanilla-2.6.9rc1/drivers/message/i2o/i2o_block.c linux-2.6.9rc1/drivers/message/i2o/i2o_block.c
--- linux.vanilla-2.6.9rc1/drivers/message/i2o/i2o_block.c	2004-08-31 15:04:54.000000000 +0100
+++ linux-2.6.9rc1/drivers/message/i2o/i2o_block.c	2004-09-01 17:28:13.000000000 +0100
@@ -422,8 +422,6 @@ static inline void i2ob_unhook_request(s
  
 static inline void i2ob_end_request(struct request *req)
 {
-	/* FIXME  - pci unmap the request */
-
 	/*
 	 * Loop until all of the buffers that are linked
 	 * to this request have been marked updated and
@@ -1134,7 +1132,8 @@ static int i2ob_install_device(struct i2
 	dev->flags = flags;	/* Keep the type info */
 		
 	blk_queue_max_sectors(q, 96);	/* 256 might be nicer but many controllers
-						   explode on 65536 or higher */
+					   explode on 65536 bytes or higher 
+					   as they don't know how to map them to scsi */
 	blk_queue_max_phys_segments(q, segments);
 	blk_queue_max_hw_segments(q, segments);
 		
@@ -1268,7 +1267,7 @@ static void i2ob_scan(int bios)
 			continue;
 
 		/*
-		 *    The device list connected to the I2O Controller is doubly linked
+		 * The device list connected to the I2O Controller is doubly linked
 		 * Here we traverse the end of the list , and start claiming devices
 		 * from that end. This assures that within an I2O controller atleast
 		 * the newly created volumes get claimed after the older ones, thus
diff -u --new-file --recursive --exclude-from /usr/src/exclude -p linux.vanilla-2.6.9rc1/drivers/message/i2o/i2o_config.c linux-2.6.9rc1/drivers/message/i2o/i2o_config.c
--- linux.vanilla-2.6.9rc1/drivers/message/i2o/i2o_config.c	2004-08-31 15:04:54.000000000 +0100
+++ linux-2.6.9rc1/drivers/message/i2o/i2o_config.c	2004-09-01 21:53:31.000000000 +0100
@@ -802,7 +802,7 @@ static int ioctl_evt_reg(unsigned long a
 	msg[0] = FOUR_WORD_MSG_SIZE|SGL_OFFSET_0;
 	msg[1] = I2O_CMD_UTIL_EVT_REGISTER<<24 | HOST_TID<<12 | kdesc.tid;
 	msg[2] = (u32)i2o_cfg_context;
-	msg[3] = (u32)fp->private_data;
+	msg[3] = (u32)(unsigned long)fp->private_data;
 	msg[4] = kdesc.evt_mask;
 
 	i2o_post_this(iop, msg, 20);
@@ -812,7 +812,7 @@ static int ioctl_evt_reg(unsigned long a
 
 static int ioctl_evt_get(unsigned long arg, struct file *fp)
 {
-	u32 id = (u32)fp->private_data;
+	u32 id = (u32)(unsigned long)fp->private_data;
 	struct i2o_cfg_info *p = NULL;
 	struct i2o_evt_get __user *uget = (void __user *)arg;
 	struct i2o_evt_get kget;
@@ -1016,7 +1016,7 @@ static int cfg_open(struct inode *inode,
 	file->private_data = (void*)(i2o_cfg_info_id++);
 	tmp->fp = file;
 	tmp->fasync = NULL;
-	tmp->q_id = (u32)file->private_data;
+	tmp->q_id = (u32)(unsigned long)file->private_data;
 	tmp->q_len = 0;
 	tmp->q_in = 0;
 	tmp->q_out = 0;
@@ -1032,7 +1032,7 @@ static int cfg_open(struct inode *inode,
 
 static int cfg_release(struct inode *inode, struct file *file)
 {
-	u32 id = (u32)file->private_data;
+	u32 id = (u32)(unsigned long)file->private_data;
 	struct i2o_cfg_info *p1, *p2;
 	unsigned long flags;
 
@@ -1066,7 +1066,7 @@ static int cfg_release(struct inode *ino
 
 static int cfg_fasync(int fd, struct file *fp, int on)
 {
-	u32 id = (u32)fp->private_data;
+	u32 id = (u32)(unsigned long)fp->private_data;
 	struct i2o_cfg_info *p;
 
 	for(p = open_files; p; p = p->next)
diff -u --new-file --recursive --exclude-from /usr/src/exclude -p linux.vanilla-2.6.9rc1/drivers/message/i2o/i2o_core.c linux-2.6.9rc1/drivers/message/i2o/i2o_core.c
--- linux.vanilla-2.6.9rc1/drivers/message/i2o/i2o_core.c	2004-08-31 15:04:54.000000000 +0100
+++ linux-2.6.9rc1/drivers/message/i2o/i2o_core.c	2004-09-01 21:48:24.000000000 +0100
@@ -354,7 +354,7 @@ static void i2o_core_reply(struct i2o_ha
 
 	if (msg[0] & MSG_FAIL) // Fail bit is set
 	{
-		u32 *preserved_msg = (u32*)(c->msg_virt + msg[7]);
+		u32 *preserved_msg = (u32*)i2o_send_to_virt(c, msg[7]);
 
 		i2o_report_status(KERN_INFO, "i2o_core", msg);
 		i2o_dump_message(preserved_msg);
@@ -1273,11 +1273,53 @@ static int i2o_dyn_lct(void *foo)
 		}
 		memcpy(c->lct, c->dlct, c->dlct->table_size<<2);
 	}
-
 	return 0;
 }
 
 /**
+ *	i2o_receive_to_virt	-	Turn an I2O message to a virtual address
+ *	@c: controller
+ *	@msg: message engine value
+ *
+ *	Turn a receive message from an I2O controller bus address into
+ *	a Linux virtual address. The shared page frame is a linear block
+ *	so we simply have to shift the offset. This function does not 
+ *	work for sender side messages as they are ioremap objects
+ *	provided by the I2O controller.
+ */
+ 
+void *i2o_receive_to_virt(struct i2o_controller *c, u32 msg)
+{
+	if(msg < c->page_frame_map || msg >= c->page_frame_map + MSG_POOL_SIZE)
+		BUG();
+	msg -= c->page_frame_map;
+	return c->page_frame + msg;
+}
+
+EXPORT_SYMBOL_GPL(i2o_receive_to_virt);
+
+/**
+ *	i2o_send_to_virt	-	Turn an I2O message to a virtual address
+ *	@c: controller
+ *	@msg: message engine value
+ *
+ *	Turn a send message from an I2O controller bus address into
+ *	a Linux virtual address. The shared page frame is a linear block
+ *	so we simply have to shift the offset. This function does not 
+ *	work for receive side messages as they are kmalloc objects
+ *	in a different pool.
+ */
+ 
+void *i2o_send_to_virt(struct i2o_controller *c, u32 msg)
+{
+	if(msg < 0 || msg >= MSG_POOL_SIZE)
+		BUG();
+	return c->msg_virt + msg;
+}
+
+EXPORT_SYMBOL_GPL(i2o_send_to_virt);
+
+/**
  *	i2o_run_queue	-	process pending events on a controller
  *	@c: controller to process
  *
@@ -1301,9 +1343,8 @@ void i2o_run_queue(struct i2o_controller
 	while(mv!=0xFFFFFFFF)
 	{
 		struct i2o_handler *i;
-		/* Map the message from the page frame map to kernel virtual */
-		/* m=(struct i2o_message *)(mv - (unsigned long)c->page_frame_map + (unsigned long)c->page_frame); */
-		m=(struct i2o_message *)bus_to_virt(mv);
+
+		m = i2o_receive_to_virt(c, mv);
 		msg=(u32*)m;
 
 		/*
@@ -1329,7 +1370,7 @@ void i2o_run_queue(struct i2o_controller
 		mb();
 
 		/* That 960 bug again... */	
-		if((mv=I2O_REPLY_READ32(c))==0xFFFFFFFF)
+		if((mv=I2O_REPLY_READ32(c))==0xFFFFFFFFUL)
 			mv=I2O_REPLY_READ32(c);
 	}		
 }
@@ -1783,38 +1824,37 @@ static int i2o_reset_controller(struct i
 	u32 m;
 	u8 *status;
 	dma_addr_t status_phys;
-	u32 *msg;
+	void *msg;
 	long time;
 
 	/* Quiesce all IOPs first */
 
 	for (iop = i2o_controller_chain; iop; iop = iop->next)
 	{
-		if(!iop->dpt)
+		if(!iop->dpt && !iop->promise)
 			i2o_quiesce_controller(iop);
 	}
 
 	m=i2o_wait_message(c, "AdapterReset");
-	if(m==0xFFFFFFFF)	
+	if(m==0xFFFFFFFFUL)	
 		return -ETIMEDOUT;
-	msg=(u32 *)(c->msg_virt+m);
+	msg = m + c->msg_virt;
 	
-	status = pci_alloc_consistent(c->pdev, 4, &status_phys);
+	status = pci_alloc_consistent(c->pdev, 8, &status_phys);
 	if(status == NULL) {
 		printk(KERN_ERR "IOP reset failed - no free memory.\n");
 		return -ENOMEM;
 	}
-	memset(status, 0, 4);
+	memset(status, 0, 8);
 	
-	msg[0]=EIGHT_WORD_MSG_SIZE|SGL_OFFSET_0;
-	msg[1]=I2O_CMD_ADAPTER_RESET<<24|HOST_TID<<12|ADAPTER_TID;
-	msg[2]=core_context;
-	msg[3]=0;
-	msg[4]=0;
-	msg[5]=0;
-	msg[6]=status_phys;
-	msg[7]=0;	/* 64bit host FIXME */
-
+	i2o_raw_writel(EIGHT_WORD_MSG_SIZE|SGL_OFFSET_0, msg);
+	i2o_raw_writel(I2O_CMD_ADAPTER_RESET<<24|HOST_TID<<12|ADAPTER_TID, msg+4);
+	i2o_raw_writel(core_context, msg+8);
+	i2o_raw_writel(0, msg + 12);
+	i2o_raw_writel(0, msg + 16);
+	i2o_raw_writel(0, msg + 20);
+	i2o_raw_writel(status_phys, msg + 24);
+	i2o_raw_writel(0, msg + 28);	/* We use 32bit DMA mask.. */
 	i2o_post_message(c,m);
 
 	/* Wait for a reply */
@@ -1823,12 +1863,18 @@ static int i2o_reset_controller(struct i
 	{
 		if((jiffies-time)>=20*HZ)
 		{
-			printk(KERN_ERR "IOP reset timeout.\n");
+			printk(KERN_ERR "i2o: IOP reset timeout.\n");
 			/* The controller still may respond and overwrite
 			 * status_phys, LEAK it to prevent memory corruption.
 			 */
 			return -ETIMEDOUT;
 		}
+		if( status[1] != 0)
+		{
+			printk(KERN_WARNING "i2o: IOP wrote wrong status word.\n");
+			*status = 0;
+			break;
+		}
 		schedule();
 		barrier();
 	}
@@ -1883,10 +1929,10 @@ static int i2o_reset_controller(struct i
 	/* Enable other IOPs */
 
 	for (iop = i2o_controller_chain; iop; iop = iop->next)
-		if (iop != c)
+		if (iop != c && !iop->dpt && !iop->promise)
 			i2o_enable_controller(iop);
 
-	pci_free_consistent(c->pdev, 4, status, status_phys);
+	pci_free_consistent(c->pdev, 8, status, status_phys);
 	return 0;
 }
 
@@ -1905,7 +1951,7 @@ int i2o_status_get(struct i2o_controller
 {
 	long time;
 	u32 m;
-	u32 *msg;
+	void *msg;
 	u8 *status_block;
 
 	if (c->status_block == NULL) 
@@ -1926,17 +1972,17 @@ int i2o_status_get(struct i2o_controller
 	m=i2o_wait_message(c, "StatusGet");
 	if(m==0xFFFFFFFF)
 		return -ETIMEDOUT;	
-	msg=(u32 *)(c->msg_virt+m);
+	msg=(void *)(c->msg_virt + m);
 
-	msg[0]=NINE_WORD_MSG_SIZE|SGL_OFFSET_0;
-	msg[1]=I2O_CMD_STATUS_GET<<24|HOST_TID<<12|ADAPTER_TID;
-	msg[2]=core_context;
-	msg[3]=0;
-	msg[4]=0;
-	msg[5]=0;
-	msg[6]=c->status_block_phys;
-	msg[7]=0;   /* 64bit host FIXME */
-	msg[8]=sizeof(i2o_status_block); /* always 88 bytes */
+	i2o_raw_writel(NINE_WORD_MSG_SIZE|SGL_OFFSET_0, msg);
+	i2o_raw_writel(I2O_CMD_STATUS_GET<<24|HOST_TID<<12|ADAPTER_TID, msg + 4);
+	i2o_raw_writel(core_context, msg + 8);
+	i2o_raw_writel(0, msg + 12);
+	i2o_raw_writel(0, msg + 16);
+	i2o_raw_writel(0, msg + 20);
+	i2o_raw_writel(c->status_block_phys, msg + 24);
+	i2o_raw_writel(0, msg + 28);
+	i2o_raw_writel(sizeof(i2o_status_block), msg + 32); /* always 88 bytes */
 
 	i2o_post_message(c,m);
 
@@ -2269,6 +2315,64 @@ static void i2o_sys_shutdown(void)
 }
 
 /**
+ *	i2o_send_nop		-	send a core NOP message
+ *	@c: controller
+ *	
+ *	Send a no-operation message with a reply set to cause no
+ *	action either. Needed for bringing up promise controllers
+ */
+ 
+static void i2o_send_nop(struct i2o_controller *c)
+{
+	u32 m = i2o_wait_message(c, "SendNop");
+	void *msg;
+	if(m == 0xFFFFFFFFUL)
+		return;
+	msg = m + c->msg_virt;
+	
+	i2o_raw_writel(THREE_WORD_MSG_SIZE|SGL_OFFSET_0, msg);
+	i2o_raw_writel(I2O_CMD_UTIL_NOP| HOST_TID << 12 | 0  , msg+4);
+	i2o_raw_writel(0, msg+8);
+	
+	i2o_post_message(c, m);
+}
+
+/**
+ *	i2o_activate_promise	-	activate Promise not quite I2O
+ *	@c: controller
+ *
+ *	Bring up and activate the Promise SX I2O controllers which don't
+ *	quite follow I2O and don't like an I2O boot at all.
+ */
+ 
+static int i2o_activate_promise(struct i2o_controller *iop)
+{
+	int ret = 0;
+	/* Beat up the hardware first of all */
+	struct pci_dev *i960 = pci_find_slot(iop->pdev->bus->number, PCI_DEVFN(PCI_SLOT(iop->pdev->devfn), 0));
+	if(i960)
+		pci_write_config_word(i960, 0x42, 0);
+		
+	/* Follow this sequence precisely or the controller
+	   ceases to perform useful functions until reboot */
+	i2o_send_nop(iop);
+	if(i2o_reset_controller(iop) < 0 ||
+	  (i2o_status_get(iop) < 0) ||
+	  (i2o_init_outbound_q(iop) < 0) ||
+	  (i2o_post_outbound_messages(iop) < 0))
+	  	ret = -1;
+	  	
+	i2o_send_nop(iop);
+
+	if(i2o_status_get(iop) < 0)
+		ret = -1 ;
+	if(i960)
+		pci_write_config_word(i960, 0x42, 0x3FF);
+	return ret;
+}
+
+
+/**
  *	i2o_activate_controller	-	bring controller up to HOLD
  *	@iop: controller
  *
@@ -2280,6 +2384,10 @@ static void i2o_sys_shutdown(void)
  
 int i2o_activate_controller(struct i2o_controller *iop)
 {
+
+	if(iop->promise)
+		return i2o_activate_promise(iop);
+		
 	/* In INIT state, Wait Inbound Q to initialize (in i2o_status_get) */
 	/* In READY state, Get status */
 
@@ -2325,8 +2433,6 @@ int i2o_activate_controller(struct i2o_c
 
 	return 0;
 }
-
-
 /**
  *	i2o_init_outbound_queue	- setup the outbound queue
  *	@c: controller
@@ -2340,14 +2446,14 @@ int i2o_init_outbound_q(struct i2o_contr
 	u8 *status;
 	dma_addr_t status_phys;
 	u32 m;
-	u32 *msg;
+	void *msg;
 	u32 time;
 
 	dprintk(KERN_INFO "%s: Initializing Outbound Queue...\n", c->name);
 	m=i2o_wait_message(c, "OutboundInit");
 	if(m==0xFFFFFFFF)
 		return -ETIMEDOUT;
-	msg=(u32 *)(c->msg_virt+m);
+	msg=(void *)(c->msg_virt+m);
 
 	status = pci_alloc_consistent(c->pdev, 4, &status_phys);
 	if (status==NULL) {
@@ -2357,15 +2463,15 @@ int i2o_init_outbound_q(struct i2o_contr
 	}
 	memset(status, 0, 4);
 
-	msg[0]= EIGHT_WORD_MSG_SIZE| TRL_OFFSET_6;
-	msg[1]= I2O_CMD_OUTBOUND_INIT<<24 | HOST_TID<<12 | ADAPTER_TID;
-	msg[2]= core_context;
-	msg[3]= 0x0106;				/* Transaction context */
-	msg[4]= 4096;				/* Host page frame size */
-	/* Frame size is in words. 256 bytes a frame for now */
-	msg[5]= MSG_FRAME_SIZE<<16|0x80;	/* Outbound msg frame size in words and Initcode */
-	msg[6]= 0xD0000004;			/* Simple SG LE, EOB */
-	msg[7]= status_phys;
+	i2o_raw_writel(EIGHT_WORD_MSG_SIZE| TRL_OFFSET_6, msg);
+	i2o_raw_writel(I2O_CMD_OUTBOUND_INIT<<24 | HOST_TID<<12 | ADAPTER_TID, msg + 4);;
+	i2o_raw_writel(core_context, msg + 8);
+	i2o_raw_writel(0x0106, msg + 12);	/* Transaction context */
+	i2o_raw_writel(4096, msg + 16);		/* Host page frame size */
+	/* Frame size is in words. 128 bytes a frame for now. SCSI assumes this */
+	i2o_raw_writel(MSG_FRAME_SIZE << 16|0x80, msg + 20);	/* Outbound msg frame size in words and Initcode */
+	i2o_raw_writel(0xD0000004, msg + 24);	/* Simple SG LE, EOB */
+	i2o_raw_writel(status_phys, msg + 28);
 
 	i2o_post_message(c,m);
 	
@@ -2436,6 +2542,8 @@ int i2o_post_outbound_messages(struct i2
 	for(i=0; i< NMBR_MSG_FRAMES; i++) {
 		I2O_REPLY_WRITE32(c,m);
 		mb();
+		if(c->promise)		/* May be overkill - check later */
+			udelay(1);
 		m += (MSG_FRAME_SIZE << 2);
 	}
 
@@ -2621,8 +2729,8 @@ static int i2o_build_sys_table(void)
 		sys_tbl->iops[count].last_changed = sys_tbl_ind - 1; // ??
 		sys_tbl->iops[count].iop_capabilities = 
 				iop->status_block->iop_capabilities;
-		sys_tbl->iops[count].inbound_low = (u32)iop->post_port;
-		sys_tbl->iops[count].inbound_high = 0;	// FIXME: 64-bit support
+		sys_tbl->iops[count].inbound_low = (u32)(unsigned long)iop->post_port;
+		sys_tbl->iops[count].inbound_high = 0;	/* We are using 32bit PCI masks */
 
 		count++;
 	}
@@ -3674,11 +3782,15 @@ int __init i2o_pci_install(struct pci_de
 		c->short_req = 1;
 		printk(KERN_INFO "I2O: Symbios FC920 workarounds activated.\n");
 	}
+	
+	/*
+	 *	Quirky in several ways.
+	 */
 
 	if(dev->subsystem_vendor == PCI_VENDOR_ID_PROMISE)
 	{
 		c->promise = 1;
-		printk(KERN_INFO "I2O: Promise workarounds activated.\n");
+		printk(KERN_INFO "I2O: Promise vaguely I2O mode activated.\n");
 	}
 
 	/*
@@ -3687,9 +3799,9 @@ int __init i2o_pci_install(struct pci_de
 	 */
 	 
 	if(dev->vendor == PCI_VENDOR_ID_DPT) {
-		c->dpt=1;
+		c->dpt = 1;
 		if(dev->device == 0xA511)
-			c->raptor=1;
+			c->raptor = 1;
 	}
 
 	for(i=0; i<6; i++)
@@ -3847,20 +3959,35 @@ int __init i2o_pci_scan(void)
 
 	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
 	{
-		if((dev->class>>8)!=PCI_CLASS_INTELLIGENT_I2O &&
-		   (dev->vendor!=PCI_VENDOR_ID_DPT || dev->device!=0xA511))
-			continue;
-
-		if((dev->class>>8)==PCI_CLASS_INTELLIGENT_I2O &&
-		   (dev->class&0xFF)>1)
+		if (dev->subsystem_vendor == PCI_VENDOR_ID_PROMISE &&
+		    dev->subsystem_device == 0x0000 &&
+		    dev->vendor == PCI_VENDOR_ID_INTEL)
 		{
-			printk(KERN_INFO "i2o: I2O Controller found but does not support I2O 1.5 (skipping).\n");
-			continue;
+			/* This is best described as quirky */
+			printk(KERN_INFO "i2o: Promise SuperTrak SX6000 series controller on bus %d at %d.\n",
+				dev->bus->number, dev->devfn);
 		}
+		else if(dev->vendor == PCI_VENDOR_ID_DPT &&
+			dev->device == 0xA511)
+		{
+			printk(KERN_INFO "i2o: DPT controller on bus %d at %d.\n",
+				dev->bus->number, dev->devfn);
+		}
+		else if (dev->class >> 8 == PCI_CLASS_INTELLIGENT_I2O)
+		{
+			if((dev->class & 0xFF) > 1)
+			{
+				printk(KERN_INFO "i2o: I2O Controller found but does not support I2O 1.5 (skipping).\n");
+				continue;
+			}
+			printk(KERN_INFO "i2o: I2O controller on bus %d at %d.\n",
+				dev->bus->number, dev->devfn);
+		}
+		else	/* Not I2O */
+			continue;
+			
 		if (pci_enable_device(dev))
 			continue;
-		printk(KERN_INFO "i2o: I2O controller on bus %d at %d.\n",
-			dev->bus->number, dev->devfn);
 		if(pci_set_dma_mask(dev, 0xffffffff))
 		{
 			printk(KERN_WARNING "I2O controller on bus %d at %d : No suitable DMA available\n", dev->bus->number, dev->devfn);
diff -u --new-file --recursive --exclude-from /usr/src/exclude -p linux.vanilla-2.6.9rc1/drivers/message/i2o/i2o_scsi.c linux-2.6.9rc1/drivers/message/i2o/i2o_scsi.c
--- linux.vanilla-2.6.9rc1/drivers/message/i2o/i2o_scsi.c	2004-08-31 15:04:54.000000000 +0100
+++ linux-2.6.9rc1/drivers/message/i2o/i2o_scsi.c	2004-09-01 21:49:00.000000000 +0100
@@ -91,12 +91,6 @@ static int scsi_context;
 static int lun_done;
 static int i2o_scsi_hosts;
 
-static u32 *retry[32];
-static struct i2o_controller *retry_ctrl[32];
-static struct timer_list retry_timer;
-static spinlock_t retry_lock = SPIN_LOCK_UNLOCKED;
-static int retry_ct = 0;
-
 static atomic_t queue_depth;
 
 /*
@@ -127,52 +121,6 @@ static int sg_chain_tag = 0;
 static int sg_max_frags = SG_MAX_FRAGS;
 
 /**
- *	i2o_retry_run		-	retry on timeout
- *	@f: unused
- *
- *	Retry congested frames. This actually needs pushing down into
- *	i2o core. We should only bother the OSM with this when we can't
- *	queue and retry the frame. Or perhaps we should call the OSM
- *	and its default handler should be this in the core, and this
- *	call a 2nd "I give up" handler in the OSM ?
- */
- 
-static void i2o_retry_run(unsigned long f)
-{
-	int i;
-	unsigned long flags;
-	
-	spin_lock_irqsave(&retry_lock, flags);
-	for(i=0;i<retry_ct;i++)
-		i2o_post_message(retry_ctrl[i], virt_to_bus(retry[i]));
-	retry_ct=0;
-	spin_unlock_irqrestore(&retry_lock, flags);
-}
-
-/**
- *	flush_pending		-	empty the retry queue
- *
- *	Turn each of the pending commands into a NOP and post it back
- *	to the controller to clear it.
- */
- 
-static void flush_pending(void)
-{
-	int i;
-	unsigned long flags;
-	
-	spin_lock_irqsave(&retry_lock, flags);
-	for(i=0;i<retry_ct;i++)
-	{
-		retry[i][0]&=~0xFFFFFF;
-		retry[i][0]|=I2O_CMD_UTIL_NOP<<24;
-		i2o_post_message(retry_ctrl[i],virt_to_bus(retry[i]));
-	}
-	retry_ct=0;
-	spin_unlock_irqrestore(&retry_lock, flags);
-}
-
-/**
  *	i2o_scsi_reply		-	scsi message reply processor
  *	@h: our i2o handler
  *	@c: controller issuing the reply
@@ -191,7 +139,8 @@ static void i2o_scsi_reply(struct i2o_ha
 	struct scsi_cmnd *current_command;
 	spinlock_t *lock;
 	u32 *m = (u32 *)msg;
-	u8 as,ds,st;
+	u32 *mr;
+	u8 as, ds, st;
 	unsigned long flags;
 
 	if(m[0] & (1<<13))
@@ -211,44 +160,32 @@ static void i2o_scsi_reply(struct i2o_ha
 		if(m[4]&(1<<18))
 			printk("Congestion.\n");
 		
-		m=(u32 *)bus_to_virt(m[7]);
-		printk("Failing message is %p.\n", m);
+		/*
+		 *	The reply includes the I2O view address of
+		 *	the message we sent. We need to convert this
+		 *	back into an ioremap space address
+		 */
+		mr = (u32 *)i2o_send_to_virt(c, m[7]);
+		printk("Failing message is %p.\n", mr);
 		
 		/* This isnt a fast path .. */
-		spin_lock_irqsave(&retry_lock, flags);
-		
-		if((m[4]&(1<<18)) && retry_ct < 32)
-		{
-			retry_ctrl[retry_ct]=c;
-			retry[retry_ct]=m;
-			if(!retry_ct++)
-			{
-				retry_timer.expires=jiffies+1;
-				add_timer(&retry_timer);
-			}
-			spin_unlock_irqrestore(&retry_lock, flags);
-		}
-		else
-		{
-			spin_unlock_irqrestore(&retry_lock, flags);
-			/* Create a scsi error for this */
-			current_command = (struct scsi_cmnd *)i2o_context_list_get(m[3], c);
-			if(!current_command)
-				return;
+		/* Create a scsi error for this */
+		current_command = (struct scsi_cmnd *)i2o_context_list_get(mr[3], c);
+		if(!current_command)
+			return;
 
-			lock = current_command->device->host->host_lock;
-			printk("Aborted %ld\n", current_command->serial_number);
+		lock = current_command->device->host->host_lock;
+		printk(KERN_WARNING "%s: Command %ld: controller busy.\n", c->name, current_command->serial_number);
 
-			spin_lock_irqsave(lock, flags);
-			current_command->result = DID_ERROR << 16;
-			current_command->scsi_done(current_command);
-			spin_unlock_irqrestore(lock, flags);
-			
-			/* Now flush the message by making it a NOP */
-			m[0]&=0x00FFFFFF;
-			m[0]|=(I2O_CMD_UTIL_NOP)<<24;
-			i2o_post_message(c,virt_to_bus(m));
-		}
+		spin_lock_irqsave(lock, flags);
+		/* In 2.6 we can let the SCSI layer do our homework */
+		current_command->result = DID_BUS_BUSY << 16;
+		current_command->scsi_done(current_command);
+		spin_unlock_irqrestore(lock, flags);
+		
+		/* Now flush the message by making it a NOP */
+		i2o_raw_writel((readl(mr) & 0x00FFFFFF) | (I2O_CMD_UTIL_NOP)<<24, mr);
+		i2o_post_message(c, m[7]);
 		return;
 	}
 	
@@ -275,6 +212,7 @@ static void i2o_scsi_reply(struct i2o_ha
 			lun_done=1;
 			return;
 		}
+		/* Should probably sleep/wakeup the reset func ? */
 		printk(KERN_INFO "i2o_scsi: bus reset completed.\n");
 		return;
 	}
@@ -487,22 +425,18 @@ static int i2o_scsi_detect(struct scsi_h
 	
 	if((sg_chain_pool = kmalloc(SG_CHAIN_POOL_SZ, GFP_KERNEL)) == NULL)
 	{
-		printk(KERN_INFO "i2o_scsi: Unable to alloc %d byte SG chain buffer pool.\n", SG_CHAIN_POOL_SZ);
+		printk(KERN_INFO "i2o_scsi: Unable to alloc %Zd byte SG chain buffer pool.\n", SG_CHAIN_POOL_SZ);
 		printk(KERN_INFO "i2o_scsi: SG chaining DISABLED!\n");
 		sg_max_frags = 11;
 	}
 	else
 	{
-		printk(KERN_INFO "  chain_pool: %d bytes @ %p\n", SG_CHAIN_POOL_SZ, sg_chain_pool);
-		printk(KERN_INFO "  (%d byte buffers X %d can_queue X %d i2o controllers)\n",
+		printk(KERN_INFO "  chain_pool: %Zd bytes @ %p\n", SG_CHAIN_POOL_SZ, sg_chain_pool);
+		printk(KERN_INFO "  (%Zd byte buffers X %d can_queue X %d i2o controllers)\n",
 				SG_CHAIN_BUF_SZ, I2O_SCSI_CAN_QUEUE, i2o_num_controllers);
 		sg_max_frags = SG_MAX_FRAGS;    // 64
 	}
 	
-	init_timer(&retry_timer);
-	retry_timer.data = 0UL;
-	retry_timer.function = i2o_retry_run;
-	
 //	printk("SCSI OSM at %d.\n", scsi_context);
 
 	for (count = 0, i = 0; i < MAX_I2O_CONTROLLERS; i++)
@@ -534,7 +468,7 @@ static int i2o_scsi_detect(struct scsi_h
 			shpnt = scsi_register(tpnt, sizeof(struct i2o_scsi_host));
 			if(shpnt==NULL)
 				continue;
-			shpnt->unique_id = (u32)d;
+			shpnt->unique_id = (u32)d;	/* FIXME: uniqueness for 64bit ?? */
 			shpnt->io_port = 0;
 			shpnt->n_io_port = 0;
 			shpnt->irq = 0;
@@ -552,8 +486,6 @@ static int i2o_scsi_detect(struct scsi_h
 			kfree(sg_chain_pool);
 			sg_chain_pool = NULL;
 		}
-		flush_pending();
-		del_timer(&retry_timer);
 		i2o_remove_handler(&i2o_scsi_handler);
 	}
 	
@@ -569,8 +501,6 @@ static int i2o_scsi_release(struct Scsi_
 			kfree(sg_chain_pool);
 			sg_chain_pool = NULL;
 		}
-		flush_pending();
-		del_timer(&retry_timer);
 		i2o_remove_handler(&i2o_scsi_handler);
 	}
 
@@ -761,7 +691,8 @@ static int i2o_scsi_queuecommand(struct 
 	 *
 	 *	FIXME: we need to set the sglist limits according to the 
 	 *	message size of the I2O controller. We might only have room
-	 *	for 6 or so worst case
+	 *	for 6 or so worst case. Right now its hard coded for 128
+	 *	byte message.
 	 */
 	
 	if(SCpnt->use_sg)
@@ -786,6 +717,8 @@ static int i2o_scsi_queuecommand(struct 
 			 *	Need to chain!
 			 */
 			i2o_raw_writel(direction|0xB0000000|(SCpnt->use_sg*2*4), mptr++);
+			/* FIXME: we need to map this but its shared across all devices
+			   so the proper fix is non-trivial */
 			i2o_raw_writel(virt_to_bus(sg_chain_pool + sg_chain_tag), mptr);
 			mptr = (u32*)(sg_chain_pool + sg_chain_tag);
 			if (SCpnt->use_sg > max_sg_len)
@@ -985,7 +918,7 @@ static int i2o_scsi_bus_reset(struct scs
 	i2o_raw_writel(scsi_context|0x80000000, msg+8);
 	/* We use the top bit to split controller and unit transactions */
 	/* Now store unit,tid so we can tie the completion back to a specific device */
-	__raw_writel(c->unit << 16 | tid, msg+12);
+	i2o_raw_writel(c->unit << 16 | tid, msg+12);
 	wmb();
 
 	/* We want the command to complete after we return */	
diff -u --new-file --recursive --exclude-from /usr/src/exclude -p linux.vanilla-2.6.9rc1/include/linux/i2o.h linux-2.6.9rc1/include/linux/i2o.h
--- linux.vanilla-2.6.9rc1/include/linux/i2o.h	2004-08-31 15:03:58.000000000 +0100
+++ linux-2.6.9rc1/include/linux/i2o.h	2004-09-01 21:47:33.000000000 +0100
@@ -341,6 +341,9 @@ extern int i2o_activate_controller(struc
 extern void i2o_run_queue(struct i2o_controller *);
 extern int i2o_delete_controller(struct i2o_controller *);
 
+extern void *i2o_send_to_virt(struct i2o_controller *, u32);
+extern void *i2o_receive_to_virt(struct i2o_controller *, u32);
+
 #if BITS_PER_LONG == 64
 extern u32 i2o_context_list_add(void *, struct i2o_controller *);
 extern void *i2o_context_list_get(u32, struct i2o_controller *);
@@ -679,7 +682,7 @@ static inline u32 i2o_context_list_remov
 #define ADAPTER_TID		0
 #define HOST_TID		1
 
-#define MSG_FRAME_SIZE		64	/* i2o_scsi assumes >= 32 */
+#define MSG_FRAME_SIZE		32	/* (dwords) i2o_scsi assumes >= 32 */
 #define REPLY_FRAME_SIZE	17
 #define SG_TABLESIZE		30
 #define NMBR_MSG_FRAMES		128
