Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbUCBLGn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 06:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbUCBLGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 06:06:42 -0500
Received: from [213.133.118.5] ([213.133.118.5]:62626 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S261376AbUCBLGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 06:06:18 -0500
Message-ID: <40446CCC.5070102@shadowconnect.com>
Date: Tue, 02 Mar 2004 12:15:24 +0100
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
Organization: Shadow Connect GmbH
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: alan@lxorguk.ukuu.org.uk, wtogami@redhat.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] i2o subsystem minor bugfixes to work with 2.6.3 kernel
Content-Type: multipart/mixed;
 boundary="------------070901080504030201030202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070901080504030201030202
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

here is the patch against 2.6.3 kernel to fix the I2O subsystem for the 2.6 
kernel.

If someone found a bug, please feel free to contact me.


Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com


--------------070901080504030201030202
Content-Type: text/plain;
 name="patch-2.6.3"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="patch-2.6.3"

diff -ur a/drivers/message/i2o/i2o_block.c b/drivers/message/i2o/i2o_block.c
--- a/drivers/message/i2o/i2o_block.c	2004-02-04 04:44:05.000000000 +0100
+++ b/drivers/message/i2o/i2o_block.c	2004-02-17 10:05:57.487986976 +0100
@@ -50,9 +50,11 @@
  *		Properly attach/detach I2O gendisk structure from the system
  *		gendisk list. The I2O block devices now appear in 
  * 		/proc/partitions.
+ *	Markus Lidel <Markus.Lidel@shadowconnect.com>:
+ *		Minor bugfixes for 2.6.
  *
- *	To do:
- *		Serial number scanning to find duplicates for FC multipathing
+ * To do:
+ *	Serial number scanning to find duplicates for FC multipathing
  */
 
 #include <linux/major.h>
@@ -109,25 +109,6 @@
 				 I2O_EVT_IND_BSA_SCSI_SMART )
 
 
-/*
- * I2O Block Error Codes - should be in a header file really...
- */
-#define I2O_BSA_DSC_SUCCESS             0x0000
-#define I2O_BSA_DSC_MEDIA_ERROR         0x0001
-#define I2O_BSA_DSC_ACCESS_ERROR        0x0002
-#define I2O_BSA_DSC_DEVICE_FAILURE      0x0003
-#define I2O_BSA_DSC_DEVICE_NOT_READY    0x0004
-#define I2O_BSA_DSC_MEDIA_NOT_PRESENT   0x0005
-#define I2O_BSA_DSC_MEDIA_LOCKED        0x0006
-#define I2O_BSA_DSC_MEDIA_FAILURE       0x0007
-#define I2O_BSA_DSC_PROTOCOL_FAILURE    0x0008
-#define I2O_BSA_DSC_BUS_FAILURE         0x0009
-#define I2O_BSA_DSC_ACCESS_VIOLATION    0x000A
-#define I2O_BSA_DSC_WRITE_PROTECTED     0x000B
-#define I2O_BSA_DSC_DEVICE_RESET        0x000C
-#define I2O_BSA_DSC_VOLUME_CHANGED      0x000D
-#define I2O_BSA_DSC_TIMEOUT             0x000E
-
 #define I2O_LOCK(unit)	(i2ob_dev[(unit)].req_queue->queue_lock)
 
 /*
@@ -1089,6 +1070,28 @@
 	 */
 	printk(KERN_INFO "i2ob: Installing tid %d device at unit %d\n", 
 			d->lct_data.tid, unit);	
+	
+	/* 
+	 * If this is the first I2O block device found on this IOP,
+	 * we need to initialize all the queue data structures
+	 * before any I/O can be performed. If it fails, this
+	 * device is useless.
+	 */
+	if(!i2ob_queues[unit]) {
+		if(i2ob_init_iop(unit))
+			return 1;
+	}
+
+	/* 
+	 * This will save one level of lookup/indirection in critical 
+	 * code so that we can directly get the queue ptr from the
+	 * device instead of having to go the IOP data structure.
+	 */
+	dev->req_queue = i2ob_queues[unit]->req_queue;
+
+	/* initialize gendik structure */
+	i2ob_disk[unit>>4]->private_data = dev;
+	i2ob_disk[unit>>4]->queue = dev->req_queue;
 
 	/*
 	 *	Ask for the current media data. If that isn't supported
@@ -1148,6 +1151,7 @@
 	}
 
 	strcpy(d->dev_name, i2ob_disk[unit>>4]->disk_name);
+	strcpy(i2ob_disk[unit>>4]->devfs_name, i2ob_disk[unit>>4]->disk_name);
 
 	printk(KERN_INFO "%s: Max segments %d, queue depth %d, byte limit %d.\n",
 		 d->dev_name, i2ob_dev[unit].max_segments, i2ob_dev[unit].depth, i2ob_max_sectors[unit]<<9);
@@ -1193,28 +1197,6 @@
 	printk(KERN_INFO "%s: Maximum sectors/read set to %d.\n", 
 		d->dev_name, i2ob_max_sectors[unit]);
 
-	/* 
-	 * If this is the first I2O block device found on this IOP,
-	 * we need to initialize all the queue data structures
-	 * before any I/O can be performed. If it fails, this
-	 * device is useless.
-	 */
-	if(!i2ob_queues[c->unit]) {
-		if(i2ob_init_iop(c->unit))
-			return 1;
-	}
-
-	/* 
-	 * This will save one level of lookup/indirection in critical 
-	 * code so that we can directly get the queue ptr from the
-	 * device instead of having to go the IOP data structure.
-	 */
-	dev->req_queue = i2ob_queues[c->unit]->req_queue;
-
-	/* Register a size before we register for events - otherwise we
-	   might miss and overwrite an event */
-	set_capacity(i2ob_disk[unit>>4], size>>9);
-
 	/*
 	 * Register for the events we're interested in and that the
 	 * device actually supports.
@@ -1251,6 +1235,7 @@
 	i2ob_queues[unit]->i2ob_qhead = &i2ob_queues[unit]->request_queue[0];
 	atomic_set(&i2ob_queues[unit]->queue_depth, 0);
 
+	i2ob_queues[unit]->lock = SPIN_LOCK_UNLOCKED;
 	i2ob_queues[unit]->req_queue = blk_init_queue(i2ob_request, &i2ob_queues[unit]->lock);
 	if (!i2ob_queues[unit]->req_queue) {
 		kfree(i2ob_queues[unit]);
@@ -1336,6 +1318,8 @@
 				continue;
 			}
 
+			i2o_release_device(d, &i2o_block_handler);
+
 			if(scan_unit<MAX_I2OB<<4)
 			{
  				/*
@@ -1365,7 +1349,6 @@
 				if(!warned++)
 					printk(KERN_WARNING "i2o_block: too many device, registering only %d.\n", scan_unit>>4);
 			}
-			i2o_release_device(d, &i2o_block_handler);
 		}
 		i2o_unlock_controller(c);
 	}
@@ -1699,9 +1682,9 @@
 	
 	if(evt_running) {
 		printk(KERN_INFO "Killing I2O block threads...");
-		i = kill_proc(evt_pid, SIGTERM, 1);
+		i = kill_proc(evt_pid, SIGKILL, 1);
 		if(!i) {
-			printk("waiting...");
+			printk("waiting...\n");
 		}
 		/* Be sure it died */
 		wait_for_completion(&i2ob_thread_dead);
diff -ur a/drivers/message/i2o/i2o_core.c b/drivers/message/i2o/i2o_core.c
--- a/drivers/message/i2o/i2o_core.c	2004-02-04 04:43:57.000000000 +0100
+++ b/drivers/message/i2o/i2o_core.c	2004-02-17 10:12:19.682840797 +0100
@@ -13,15 +13,16 @@
  * A lot of the I2O message side code from this is taken from the 
  * Red Creek RCPCI45 adapter driver by Red Creek Communications 
  * 
- * Fixes by: 
- *		Philipp Rumpf 
- *		Juha Sievänen <Juha.Sievanen@cs.Helsinki.FI> 
- *		Auvo Häkkinen <Auvo.Hakkinen@cs.Helsinki.FI> 
- *		Deepak Saxena <deepak@plexity.net> 
- *		Boji T Kannanthanam <boji.t.kannanthanam@intel.com>
- *
- * Ported to Linux 2.5 by
- *		Alan Cox	<alan@redhat.com>
+ * Fixes/additions:
+ *	Philipp Rumpf 
+ *	Juha Sievänen <Juha.Sievanen@cs.Helsinki.FI> 
+ *	Auvo Häkkinen <Auvo.Hakkinen@cs.Helsinki.FI> 
+ *	Deepak Saxena <deepak@plexity.net> 
+ *	Boji T Kannanthanam <boji.t.kannanthanam@intel.com>
+ *	Alan Cox <alan@redhat.com>:
+ *		Ported to Linux 2.5.
+ *	Markus Lidel <Markus.Lidel@shadowconnect.com>:
+ *		Minor fixes for 2.6.
  * 
  */
 
@@ -502,6 +502,7 @@
 			c->unit = i;
 			c->page_frame = NULL;
 			c->hrt = NULL;
+			c->hrt_len = 0;
 			c->lct = NULL;
 			c->status_block = NULL;
 			sprintf(c->name, "i2o/iop%d", i);
@@ -564,7 +565,7 @@
 	 * If this is shutdown time, the thread's already been killed
 	 */
 	if(c->lct_running) {
-		stat = kill_proc(c->lct_pid, SIGTERM, 1);
+		stat = kill_proc(c->lct_pid, SIGKILL, 1);
 		if(!stat) {
 			int count = 10 * 100;
 			while(c->lct_running && --count) {
@@ -1861,31 +1862,36 @@
 {
 	u32 msg[6];
 	int ret, size = sizeof(i2o_hrt);
+	int loops = 3;	/* we only try 3 times to get the HRT, this should be
+			   more then enough. Worst case should be 2 times.*/
 
 	/* First read just the header to figure out the real size */
 
 	do  {
+		/* first we allocate the memory for the HRT */
 		if (c->hrt == NULL) {
 			c->hrt=pci_alloc_consistent(c->pdev, size, &c->hrt_phys);
 			if (c->hrt == NULL) {
 				printk(KERN_CRIT "%s: Hrt Get failed; Out of memory.\n", c->name);
 				return -ENOMEM;
 			}
+			c->hrt_len = size;
 		}
 
 		msg[0]= SIX_WORD_MSG_SIZE| SGL_OFFSET_4;
 		msg[1]= I2O_CMD_HRT_GET<<24 | HOST_TID<<12 | ADAPTER_TID;
 		msg[3]= 0;
-		msg[4]= (0xD0000000 | size);	/* Simple transaction */
+		msg[4]= (0xD0000000 | c->hrt_len);	/* Simple transaction */
 		msg[5]= c->hrt_phys;		/* Dump it here */
 
-		ret = i2o_post_wait_mem(c, msg, sizeof(msg), 20, c->hrt, NULL, c->hrt_phys, 0, size, 0);
+		ret = i2o_post_wait_mem(c, msg, sizeof(msg), 20, c->hrt, NULL, c->hrt_phys, 0, c->hrt_len, 0);
 		
 		if(ret == -ETIMEDOUT)
 		{
 			/* The HRT block we used is in limbo somewhere. When the iop wakes up
 			   we will recover it */
 			c->hrt = NULL;
+			c->hrt_len = 0;
 			return ret;
 		}
 		
@@ -1896,13 +1902,20 @@
 			return ret;
 		}
 
-		if (c->hrt->num_entries * c->hrt->entry_len << 2 > size) {
-			int new_size = c->hrt->num_entries * c->hrt->entry_len << 2;
-			pci_free_consistent(c->pdev, size, c->hrt, c->hrt_phys);
-			size = new_size;
+		if (c->hrt->num_entries * c->hrt->entry_len << 2 > c->hrt_len) {
+			size = c->hrt->num_entries * c->hrt->entry_len << 2;
+			pci_free_consistent(c->pdev, c->hrt_len, c->hrt, c->hrt_phys);
+			c->hrt_len = 0;
 			c->hrt = NULL;
 		}
-	} while (c->hrt == NULL);
+		loops --;
+	} while (c->hrt == NULL && loops > 0);
+
+	if(c->hrt == NULL)
+	{
+		printk(KERN_ERR "%s: Unable to get HRT after three tries, giving up\n", c->name);
+		return -1;
+	}
 
 	i2o_parse_hrt(c); // just for debugging
 
@@ -3628,8 +3642,6 @@
 	return 0;	
 }
 
-static int dpt;
-
 /**
  *	i2o_pci_scan	-	Scan the pci bus for controllers
  *	
@@ -3654,14 +3666,7 @@
 	{
 		if((dev->class>>8)!=PCI_CLASS_INTELLIGENT_I2O)
 			continue;
-		if(dev->vendor == PCI_VENDOR_ID_DPT && !dpt)
-		{
-			if(dev->device == 0xA501 || dev->device == 0xA511)
-			{
-				printk(KERN_INFO "i2o: Skipping Adaptec/DPT I2O raid with preferred native driver.\n");
-				continue;
-			}
-		}
+
 		if((dev->class&0xFF)>1)
 		{
 			printk(KERN_INFO "i2o: I2O Controller found but does not support I2O 1.5 (skipping).\n");
@@ -3735,22 +3740,19 @@
 	 */
 	if(evt_running) {
 		printk("Terminating i2o threads...");
-		stat = kill_proc(evt_pid, SIGTERM, 1);
+		stat = kill_proc(evt_pid, SIGKILL, 1);
 		if(!stat) {
-			printk("waiting...");
+			printk("waiting...\n");
 			wait_for_completion(&evt_dead);
 		}
 		printk("done.\n");
 	}
 	i2o_remove_handler(&i2o_core_handler);
-	unregister_reboot_notifier(&i2o_reboot_notifier);
 }
 
 module_init(i2o_core_init);
 module_exit(i2o_core_exit);
 
-MODULE_PARM(dpt, "i");
-MODULE_PARM_DESC(dpt, "Set this if you want to drive DPT cards normally handled by dpt_i2o");
 MODULE_PARM(verbose, "i");
 MODULE_PARM_DESC(verbose, "Verbose diagnostics");
 
diff -ur a/drivers/message/i2o/i2o_scsi.c b/drivers/message/i2o/i2o_scsi.c
--- a/drivers/message/i2o/i2o_scsi.c	2004-02-04 04:44:17.000000000 +0100
+++ b/drivers/message/i2o/i2o_scsi.c	2004-02-17 09:02:20.910448951 +0100
@@ -29,12 +29,15 @@
  *	In general the firmware wants to help. Where its help isn't performance
  *	useful we just ignore the aid. Its not worth the code in truth.
  *
- *	Fixes:
- *		Steve Ralston	:	Scatter gather now works
+ * Fixes/additions:
+ *	Steve Ralston:
+ *		Scatter gather now works
+ *	Markus Lidel <Markus.Lidel@shadowconnect.com>:
+ *		Minor fixes for 2.6.
  *
- *	To Do
- *		64bit cleanups
- *		Fix the resource management problems.
+ * To Do:
+ *	64bit cleanups
+ *	Fix the resource management problems.
  */
 
 
@@ -66,7 +66,13 @@
 
 #define VERSION_STRING        "Version 0.1.2"
 
-#define dprintk(x)
+//#define DRIVERDEBUG
+
+#ifdef DRIVERDEBUG
+#define dprintk(s, args...) printk(s, ## args)
+#else
+#define dprintk(s, args...)
+#endif
 
 #define I2O_SCSI_CAN_QUEUE	4
 #define MAXHOSTS		32
@@ -252,15 +258,15 @@
 	as=(u8)le32_to_cpu(m[4]>>8);
 	st=(u8)le32_to_cpu(m[4]>>24);
 	
-	dprintk(("i2o got a scsi reply %08X: ", m[0]));
-	dprintk(("m[2]=%08X: ", m[2]));
-	dprintk(("m[4]=%08X\n", m[4]));
+	dprintk(KERN_INFO "i2o got a scsi reply %08X: ", m[0]);
+	dprintk(KERN_INFO "m[2]=%08X: ", m[2]);
+	dprintk(KERN_INFO "m[4]=%08X\n", m[4]);
  
 	if(m[2]&0x80000000)
 	{
 		if(m[2]&0x40000000)
 		{
-			dprintk(("Event.\n"));
+			dprintk(KERN_INFO "Event.\n");
 			lun_done=1;
 			return;
 		}
@@ -280,12 +286,12 @@
 	if(current_command==NULL)
 	{
 		if(st)
-			dprintk(("SCSI abort: %08X", m[4]));
-		dprintk(("SCSI abort completed.\n"));
+			dprintk(KERN_WARNING "SCSI abort: %08X", m[4]);
+		dprintk(KERN_INFO "SCSI abort completed.\n");
 		return;
 	}
 	
-	dprintk(("Completed %ld\n", current_command->serial_number));
+	dprintk(KERN_INFO "Completed %ld\n", current_command->serial_number);
 	
 	atomic_dec(&queue_depth);
 	
@@ -308,7 +314,7 @@
 	{
 		/* An error has occurred */
 
-		dprintk((KERN_DEBUG "SCSI error %08X", m[4]));
+		dprintk(KERN_WARNING "SCSI error %08X", m[4]);
 			
 		if (as == 0x0E) 
 			/* SCSI Reset */
@@ -368,7 +374,7 @@
 
 	*lun=reply[1];
 
-	dprintk(("SCSI (%d,%d)\n", *target, *lun));
+	dprintk(KERN_INFO "SCSI (%d,%d)\n", *target, *lun);
 	return 0;
 }
 
@@ -401,8 +407,8 @@
 			
 	for(unit=c->devices;unit!=NULL;unit=unit->next)
 	{
-		dprintk(("Class %03X, parent %d, want %d.\n",
-			unit->lct_data.class_id, unit->lct_data.parent_tid, d->lct_data.tid));
+		dprintk(KERN_INFO "Class %03X, parent %d, want %d.\n",
+			unit->lct_data.class_id, unit->lct_data.parent_tid, d->lct_data.tid);
 			
 		/* Only look at scsi and fc devices */
 		if (    (unit->lct_data.class_id != I2O_CLASS_SCSI_PERIPHERAL)
@@ -411,19 +417,19 @@
 			continue;
 
 		/* On our bus ? */
-		dprintk(("Found a disk (%d).\n", unit->lct_data.tid));
+		dprintk(KERN_INFO "Found a disk (%d).\n", unit->lct_data.tid);
 		if ((unit->lct_data.parent_tid == d->lct_data.tid)
 		     || (unit->lct_data.parent_tid == d->lct_data.parent_tid)
 		   )
 		{
 			u16 limit;
-			dprintk(("Its ours.\n"));
+			dprintk(KERN_INFO "Its ours.\n");
 			if(i2o_find_lun(c, unit, &target, &lun)==-1)
 			{
 				printk(KERN_ERR "i2o_scsi: Unable to get lun for tid %d.\n", unit->lct_data.tid);
 				continue;
 			}
-			dprintk(("Found disk %d %d.\n", target, lun));
+			dprintk(KERN_INFO "Found disk %d %d.\n", target, lun);
 			h->task[target][lun]=unit->lct_data.tid;
 			h->tagclock[target][lun]=jiffies;
 
@@ -439,8 +445,8 @@
 			
 			shpnt->sg_tablesize = limit;
 
-			dprintk(("i2o_scsi: set scatter-gather to %d.\n", 
-				shpnt->sg_tablesize));
+			dprintk(KERN_INFO "i2o_scsi: set scatter-gather to %d.\n", 
+				shpnt->sg_tablesize);
 		}
 	}		
 }
@@ -558,6 +564,9 @@
 		del_timer(&retry_timer);
 		i2o_remove_handler(&i2o_scsi_handler);
 	}
+
+	scsi_unregister(host);
+
 	return 0;
 }
 
@@ -624,7 +633,7 @@
 	
 	tid = hostdata->task[SCpnt->device->id][SCpnt->device->lun];
 	
-	dprintk(("qcmd: Tid = %d\n", tid));
+	dprintk(KERN_INFO "qcmd: Tid = %d\n", tid);
 	
 	current_command = SCpnt;		/* set current command                */
 	current_command->scsi_done = done;	/* set ptr to done function           */
@@ -641,7 +650,7 @@
 		return 0;
 	}
 	
-	dprintk(("Real scsi messages.\n"));
+	dprintk(KERN_INFO "Real scsi messages.\n");
 
 	/*
 	 *	Obtain an I2O message. If there are none free then 
@@ -821,8 +830,8 @@
 	}
 	else
 	{
-		dprintk(("non sg for %p, %d\n", SCpnt->request_buffer,
-				SCpnt->request_bufflen));
+		dprintk(KERN_INFO "non sg for %p, %d\n", SCpnt->request_buffer,
+				SCpnt->request_bufflen);
 		i2o_raw_writel(len = SCpnt->request_bufflen, lenptr);
 		if(len == 0)
 		{
@@ -861,7 +870,7 @@
 	}
 	
 	mb();
-	dprintk(("Issued %ld\n", current_command->serial_number));
+	dprintk(KERN_INFO "Issued %ld\n", current_command->serial_number);
 	
 	return 0;
 }
diff -ur a/include/linux/i2o-dev.h b/include/linux/i2o-dev.h
--- a/include/linux/i2o-dev.h	2004-02-04 04:43:12.000000000 +0100
+++ b/include/linux/i2o-dev.h	2004-02-17 09:02:20.913448392 +0100
@@ -182,7 +182,7 @@
 {
 	u32	adapter_id;
 	u32	parent_tid:12;
-	u32 	tate:4;
+	u32 	state:4;
 	u32	bus_num:8;
 	u32	bus_type:8;
 	union
diff -ur a/include/linux/i2o.h b/include/linux/i2o.h
--- a/include/linux/i2o.h	2004-02-04 04:43:18.000000000 +0100
+++ b/include/linux/i2o.h	2004-02-17 09:13:17.322256849 +0100
@@ -544,6 +544,25 @@
 #define I2O_DSC_DEVICE_BUSY                    0x001B
 #define I2O_DSC_DEVICE_NOT_AVAILABLE           0x001C
 
+/* DetailedStatusCode defines for Block Storage Operation: Table 6-7 Detailed
+   Status Codes.*/
+
+#define I2O_BSA_DSC_SUCCESS               0x0000
+#define I2O_BSA_DSC_MEDIA_ERROR           0x0001
+#define I2O_BSA_DSC_ACCESS_ERROR          0x0002
+#define I2O_BSA_DSC_DEVICE_FAILURE        0x0003
+#define I2O_BSA_DSC_DEVICE_NOT_READY      0x0004
+#define I2O_BSA_DSC_MEDIA_NOT_PRESENT     0x0005
+#define I2O_BSA_DSC_MEDIA_LOCKED          0x0006
+#define I2O_BSA_DSC_MEDIA_FAILURE         0x0007
+#define I2O_BSA_DSC_PROTOCOL_FAILURE      0x0008
+#define I2O_BSA_DSC_BUS_FAILURE           0x0009
+#define I2O_BSA_DSC_ACCESS_VIOLATION      0x000A
+#define I2O_BSA_DSC_WRITE_PROTECTED       0x000B
+#define I2O_BSA_DSC_DEVICE_RESET          0x000C
+#define I2O_BSA_DSC_VOLUME_CHANGED        0x000D
+#define I2O_BSA_DSC_TIMEOUT               0x000E
+
 /* FailureStatusCodes, Table 3-3 Message Failure Codes */
 
 #define I2O_FSC_TRANSPORT_SERVICE_SUSPENDED             0x81
diff -ur a/drivers/message/i2o/Kconfig b/drivers/message/i2o/Kconfig
--- a/drivers/message/i2o/Kconfig	2004-02-04 04:43:07.000000000 +0100
+++ b/drivers/message/i2o/Kconfig	2004-02-17 12:17:16.250408674 +0100
@@ -39,7 +39,10 @@
 	depends on I2O
 	help
 	  Include support for the I2O Block OSM. The Block OSM presents disk
-	  and other structured block devices to the operating system.
+	  and other structured block devices to the operating system. If you
+	  are using an RAID controller, you could access the array only by
+	  the Block OSM driver. But it is possible to access the single disks
+	  by the SCSI OSM driver, for example to monitor the disks.
 
 	  To compile this support as a module, choose M here: the
 	  module will be called i2o_block.
@@ -50,7 +53,8 @@
 	help
 	  Allows direct SCSI access to SCSI devices on a SCSI or FibreChannel
 	  I2O controller. You can use both the SCSI and Block OSM together if
-	  you wish.
+	  you wish. To access a RAID array, you must use the Block OSM driver.
+	  But you could use the SCSI OSM driver to monitor the single disks.
 
 	  To compile this support as a module, choose M here: the
 	  module will be called i2o_scsi.

--------------070901080504030201030202--
