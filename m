Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265146AbUASPUn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 10:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265223AbUASPUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 10:20:43 -0500
Received: from [213.133.118.5] ([213.133.118.5]:19945 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S265146AbUASPTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 10:19:52 -0500
Message-ID: <400BF755.6070201@shadowconnect.com>
Date: Mon, 19 Jan 2004 16:27:17 +0100
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
Organization: Shadow Connect GmbH
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] i2o_core.c, i2o_scsi.c minor bugfixes
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

after using the i2o modules (i2o_core and i2o_scsi), i found that there seems to be some minor problems in the 2.6.1 kernel
version. So i have created a patch, which resolves the following issues:


i2o-cleanup.patch:
------------------
drivers/modules/i2o/i2o_core.c:
	- i2oevtd doesn't exit, if module is removed cause of SIGKILL/SIGTERM mismatch.
	- cleaup of HRT does result in Segfault, because the length of HRT is not stored in structure.

drivers/modules/i2o/i2o_scsi.c:
	- converted dprintk calling style like the one in i2o_core.c
	- scsi_unregister() is not called, if module is removed

include/linux/i2o-dev.h:
	- fixed a typo in struct _i2o_hrt_entry


i2o-cleanup.patch:
------------------
diff -ur drivers/message/i2o.old/i2o_core.c drivers/message/i2o/i2o_core.c
--- drivers/message/i2o.old/i2o_core.c	2004-01-17 22:47:00.000000000 +0100
+++ drivers/message/i2o/i2o_core.c	2004-01-17 23:34:43.866973586 +0100
@@ -502,6 +502,7 @@
  			c->unit = i;
  			c->page_frame = NULL;
  			c->hrt = NULL;
+			c->hrt_len = 0;
  			c->lct = NULL;
  			c->status_block = NULL;
  			sprintf(c->name, "i2o/iop%d", i);
@@ -885,7 +885,7 @@
  	unsigned long flags;

  	daemonize("i2oevtd");
-	allow_signal(SIGKILL);
+	allow_signal(SIGTERM);

  	evt_running = 1;

@@ -1052,7 +1052,7 @@
  	void *tmp;

  	daemonize("iop%d_lctd", c->unit);
-	allow_signal(SIGKILL);
+	allow_signal(SIGTERM);

  	c->lct_running = 1;

@@ -1861,31 +1862,39 @@
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
-			/* The HRT block we used is in limbo somewhere. When the iop wakes up
-			   we will recover it */
+			/* The HRT block we used is in limbo somewhere. When the
+			   iop wakes up we will recover it */
+			/* FIX: shouldn't we cleanup the memory?
+			pci_free_consistent(c->pdev, c->hrt_len, c->hrt, c->hrt_phys);
+			*/
  			c->hrt = NULL;
+			c->hrt_len = 0;
  			return ret;
  		}
  		
@@ -1896,13 +1905,20 @@
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

@@ -3737,13 +3737,12 @@
  		printk("Terminating i2o threads...");
  		stat = kill_proc(evt_pid, SIGTERM, 1);
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
diff -ur drivers/message/i2o.old/i2o_scsi.c drivers/message/i2o/i2o_scsi.c
--- drivers/message/i2o.old/i2o_scsi.c	2004-01-17 22:47:00.000000000 +0100
+++ drivers/message/i2o/i2o_scsi.c	2004-01-17 23:33:25.323830216 +0100
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
@@ -252,15 +259,15 @@
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
@@ -280,12 +287,12 @@
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
  	
@@ -308,7 +315,7 @@
  	{
  		/* An error has occurred */

-		dprintk((KERN_DEBUG "SCSI error %08X", m[4]));
+		dprintk(KERN_WARNING "SCSI error %08X", m[4]);
  			
  		if (as == 0x0E)
  			/* SCSI Reset */
@@ -368,7 +375,7 @@

  	*lun=reply[1];

-	dprintk(("SCSI (%d,%d)\n", *target, *lun));
+	dprintk(KERN_INFO "SCSI (%d,%d)\n", *target, *lun);
  	return 0;
  }

@@ -401,8 +408,8 @@
  			
  	for(unit=c->devices;unit!=NULL;unit=unit->next)
  	{
-		dprintk(("Class %03X, parent %d, want %d.\n",
-			unit->lct_data.class_id, unit->lct_data.parent_tid, d->lct_data.tid));
+		dprintk(KERN_INFO "Class %03X, parent %d, want %d.\n",
+			unit->lct_data.class_id, unit->lct_data.parent_tid, d->lct_data.tid);
  			
  		/* Only look at scsi and fc devices */
  		if (    (unit->lct_data.class_id != I2O_CLASS_SCSI_PERIPHERAL)
@@ -411,19 +418,19 @@
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

@@ -439,8 +446,8 @@
  			
  			shpnt->sg_tablesize = limit;

-			dprintk(("i2o_scsi: set scatter-gather to %d.\n",
-				shpnt->sg_tablesize));
+			dprintk(KERN_INFO "i2o_scsi: set scatter-gather to %d.\n",
+				shpnt->sg_tablesize);
  		}
  	}		
  }
@@ -558,6 +565,9 @@
  		del_timer(&retry_timer);
  		i2o_remove_handler(&i2o_scsi_handler);
  	}
+
+	scsi_unregister(host);
+
  	return 0;
  }

@@ -624,7 +634,7 @@
  	
  	tid = hostdata->task[SCpnt->device->id][SCpnt->device->lun];
  	
-	dprintk(("qcmd: Tid = %d\n", tid));
+	dprintk(KERN_INFO "qcmd: Tid = %d\n", tid);
  	
  	current_command = SCpnt;		/* set current command                */
  	current_command->scsi_done = done;	/* set ptr to done function           */
@@ -641,7 +651,7 @@
  		return 0;
  	}
  	
-	dprintk(("Real scsi messages.\n"));
+	dprintk(KERN_INFO "Real scsi messages.\n");

  	/*
  	 *	Obtain an I2O message. If there are none free then
@@ -821,8 +831,8 @@
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
@@ -861,7 +871,7 @@
  	}
  	
  	mb();
-	dprintk(("Issued %ld\n", current_command->serial_number));
+	dprintk(KERN_INFO "Issued %ld\n", current_command->serial_number);
  	
  	return 0;
  }
--- include/linux/i2o-dev.h.old	2004-01-17 23:36:50.000000000 +0100
+++ include/linux/i2o-dev.h	2004-01-17 23:37:29.591626358 +0100
@@ -182,7 +182,7 @@
  {
  	u32	adapter_id;
  	u32	parent_tid:12;
-	u32 	tate:4;
+	u32 	state:4;
  	u32	bus_num:8;
  	u32	bus_type:8;
  	union

Also i found that the resource management in i2o_scsi is static, so i tried to make things a little bit dynamic by
allocating the mapping tables at module insertion (not included in this e-mail). Because i don't saw a maintainer
for those module, i wrote to the kernel mailing list. Can anybody tell me, who i can contact to verify if my changes
are of any value? I want to contribute some more code, because on my system the i2o_block doesn't work too. But before,
i want to be sure that my code is needed and also is good enough to be included into the kernel.

Thank you very much.

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

