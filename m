Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbTHSUDI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 16:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbTHSUCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 16:02:47 -0400
Received: from zmamail04.zma.compaq.com ([161.114.64.104]:6931 "EHLO
	zmamail04.zma.compaq.com") by vger.kernel.org with ESMTP
	id S261458AbTHSUBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 16:01:09 -0400
Date: Tue, 19 Aug 2003 15:05:35 -0500
From: mike.miller@hp.com
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss update for 2.4.22-rc2 [1 of 2]
Message-ID: <20030819200535.GA12376@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying a different mailer this. Let me know if the inline is messed up.
This patch was previously submitted against the 2.4.22-pre9 kernel. This patch adds failover support to the cciss driver when used along with the md driver.
It adds:
1. Detects when a card is not responding by sending a no-op periodically. The no-op should return within a few seconds.
2. Adds a deadline to extend the amount of time for the no-op to return. Useful for heavily loaded systems.
3. Adds a heartbeat timer for the special case of a PCI master abort.

Also moved the global declaration of the heartbeat_timer variable to inside the monitor thread ifdef. This cleaned up a compiler warning if the monitor thread is not enabled.

Thanks,
mikem

-------------------------------------------------------------------------------

diff -burN lx2422rc2.orig/Documentation/cciss.txt lx2422rc2-detect/Documentation/cciss.txt
--- lx2422rc2.orig/Documentation/cciss.txt	2003-08-12 13:22:22.000000000 -0500
+++ lx2422rc2-detect/Documentation/cciss.txt	2003-08-12 13:37:02.000000000 -0500
@@ -127,3 +127,55 @@
 access these devices too, as if the array controller were merely a SCSI 
 controller in the same way that we are allowing it to access SCSI tape drives.
 
+Monitor Threads
+---------------
+
+For multipath configurations (acheived via a higher level driver, such
+as the "md" driver) it is important that failure of a controller is detected.
+Ordinarily, the driver is entirely interrupt driven.  If a failure occurs
+in such a way that the processor cannot receive interrupts from an adapter,
+the driver will wait forever for i/o's to complete.  In a multipath
+configuration this is undesirable, as the md driver relies on i/o's being
+reported as failed by the low level driver to trigger failing over to an 
+alternate controller.  The monitor threads allow the driver to detect such 
+situations and report outstanding i/o's as having failed so that recovery 
+actions such switching to an alternate controller can occur.  The monitor 
+threads periodically sends a trivial "no-operation" command down to 
+the controllers and expect them to complete within a a reasonable (short)
+time period.  The firmware on the adapter is designed such that no matter
+how busy the adapter is serving i/o, it can respond quickly to a
+"no-operation" command.  In the event that a deadline elapses before a no 
+operation command completes, all outstanding commands on that controller 
+are reported back to the upper layers as having failed, and any new commands 
+sent to the controller are immediately reported back as failed. 
+
+To enable the monitor threads, the compile time option must be enabled
+(via the usual linux kernel configuration) and the monitor thread must
+be enabled at runtime as well.  A system may have many adapters, but 
+perhaps only a single pair operating in a multipath configuration.  
+In this way, it is possible to run monitoring threads only for those 
+adapters which require it.
+
+To start a monitoring thread on the first cciss adapter, "cciss0" with
+a polling interval of 30 seconds, execute the following command:
+
+	echo "monitor 30" > /proc/driver/cciss/cciss0
+
+To change the polling interval, to say, 60 seconds:
+
+	echo "monitor 60" > /proc/driver/cciss/cciss0
+
+(Note, the change will not take effect until the previous polling 
+interval elapses.)
+
+To disable the monitoring thread, set the polling interval to 0 seconds:
+
+	echo "monitor 0" > /proc/driver/cciss/cciss0
+
+(Again, the monitoring thread will not exit until the previous polling
+interval elapses.)
+
+The minimum monitoring period is 10 seconds, and the maximum monitoring
+period is 3600 seconds (1 hour).  The no-operation command must complete
+with 5 seconds of submission in all cases or the controller will be presumed
+failed.
diff -burN lx2422rc2.orig/Documentation/Configure.help lx2422rc2-detect/Documentation/Configure.help
--- lx2422rc2.orig/Documentation/Configure.help	2003-08-12 13:22:22.000000000 -0500
+++ lx2422rc2-detect/Documentation/Configure.help	2003-08-12 13:37:02.000000000 -0500
@@ -6813,7 +6813,7 @@
 CONFIG_CISS_SCSI_TAPE
   When enabled (Y), this option allows SCSI tape drives and SCSI medium
   changers (tape robots) to be accessed via a Compaq 5xxx array
-  controller.  (See Documentation/cciss.txt for more details.)
+  controller.  (See <file:Documentation/cciss.txt> for more details.)
 
   "SCSI support" and "SCSI tape support" must also be enabled for this
   option to work.
@@ -6821,6 +6821,15 @@
   When this option is disabled (N), the SCSI portion of the driver
   is not compiled.
 
+Enable monitor thread
+CONFIG_CISS_MONITOR_THREAD
+  Intended for use with multipath configurations (see the md driver).
+  This option allows a per-adapter monitoring thread to periodically
+  poll the adapter to detect failure modes in which the processor
+  is unable to receive interrupts from the adapter, thus enabling 
+  fail-over to an alternate adapter in such situations.  See 
+  <file:Documentation/cciss.txt> for more details.
+
 QuickNet Internet LineJack/PhoneJack support
 CONFIG_PHONE_IXJ
   Say M if you have a telephony card manufactured by Quicknet
diff -burN lx2422rc2.orig/drivers/block/cciss.c lx2422rc2-detect/drivers/block/cciss.c
--- lx2422rc2.orig/drivers/block/cciss.c	2003-08-12 13:22:26.000000000 -0500
+++ lx2422rc2-detect/drivers/block/cciss.c	2003-08-12 13:38:55.000000000 -0500
@@ -38,6 +38,7 @@
 #include <linux/spinlock.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
+#include <linux/smp_lock.h>
 
 #include <linux/blk.h>
 #include <linux/blkdev.h>
@@ -109,6 +110,16 @@
 
 #define CCISS_DMA_MASK 0xFFFFFFFFFFFFFFFF /* 64 bit DMA */
 
+#ifdef CONFIG_CISS_MONITOR_THREAD
+static int cciss_monitor(void *ctlr);
+static int start_monitor_thread(ctlr_info_t *h, unsigned char *cmd, 
+		unsigned long count, int (*cciss_monitor)(void *), int *rc);
+static u32 heartbeat_timer = 0;
+#else
+#define cciss_monitor(x)
+#define kill_monitor_thead(x)
+#endif
+
 static ctlr_info_t *hba[MAX_CTLR];
 
 static struct proc_dir_entry *proc_cciss;
@@ -188,7 +199,11 @@
  		"Current # commands on controller: %d\n"
  		"Max Q depth since init: %d\n"
 		"Max # commands on controller since init: %d\n"
-		"Max SG entries since init: %d\n\n",
+		"Max SG entries since init: %d\n"
+		MONITOR_PERIOD_PATTERN 
+		MONITOR_DEADLINE_PATTERN
+		MONITOR_STATUS_PATTERN 
+		"\n",
   		h->devname,
   		h->product_name,
   		(unsigned long)h->board_id,
@@ -196,7 +211,10 @@
   		(unsigned int)h->intr,
   		h->num_luns, 
   		h->Qdepth, h->commands_outstanding,
-  		h->maxQsinceinit, h->max_outstanding, h->maxSG);
+		h->maxQsinceinit, h->max_outstanding, h->maxSG,
+		MONITOR_PERIOD_VALUE(h),
+		MONITOR_DEADLINE_VALUE(h),
+		CTLR_STATUS(h));
   
 	pos += size; len += size;
 	cciss_proc_tape_report(ctlr, buffer, &pos, &len);
@@ -231,10 +249,8 @@
 {
 	unsigned char cmd[80];
 	int len;
-#ifdef CONFIG_CISS_SCSI_TAPE
 	ctlr_info_t *h = (ctlr_info_t *) data;
 	int rc;
-#endif
 
 	if (count > sizeof(cmd)-1) 
 		return -EINVAL;
@@ -244,6 +260,7 @@
 	len = strlen(cmd);	
 	if (cmd[len-1] == '\n')
 		cmd[--len] = '\0';
+
 #	ifdef CONFIG_CISS_SCSI_TAPE
 		if (strcmp("engage scsi", cmd)==0) {
 			rc = cciss_engage_scsi(h->ctlr);
@@ -254,6 +271,10 @@
 		/* might be nice to have "disengage" too, but it's not
 		   safely possible. (only 1 module use count, lock issues.) */
 #	endif
+
+	if (START_MONITOR_THREAD(h, cmd, count, cciss_monitor, &rc) == 0)
+		return rc;
+	
 	return -EINVAL;
 }
 
@@ -407,7 +428,7 @@
 	printk(KERN_DEBUG "cciss_open %x (%x:%x)\n", inode->i_rdev, ctlr, dsk);
 #endif /* CCISS_DEBUG */ 
 
-	if (ctlr > MAX_CTLR || hba[ctlr] == NULL)
+	if (ctlr > MAX_CTLR || hba[ctlr] == NULL || !CTLR_IS_ALIVE(hba[ctlr]))
 		return -ENXIO;
 	/*
 	 * Root is allowed to open raw volume zero even if its not configured
@@ -1107,7 +1128,8 @@
 	size_t	size,
 	unsigned int use_unit_num,
 	unsigned int log_unit,
-	__u8	page_code )
+	__u8	page_code,
+	__u8 cmdtype)
 {
 	ctlr_info_t *h = hba[ctlr];
 	CommandList_struct *c;
@@ -1131,6 +1153,9 @@
 	}
 	c->Header.Tag.lower = c->busaddr;  /* tag is phys addr of cmd */
 	/* Fill in Request block */
+	c->Request.CDB[0] = cmd;
+	c->Request.Type.Type = cmdtype;
+	if (cmdtype == TYPE_CMD) {
 	switch (cmd) {
 		case  CISS_INQUIRY:
 			/* If the logical unit number is 0 then, this is going
@@ -1150,11 +1175,9 @@
 				c->Request.CDB[2] = page_code;
 			}
 			c->Request.CDBLen = 6;
-			c->Request.Type.Type =  TYPE_CMD;
 			c->Request.Type.Attribute = ATTR_SIMPLE;
 			c->Request.Type.Direction = XFER_READ; /* Read */
 			c->Request.Timeout = 0; /* Don't time out */
-			c->Request.CDB[0] =  CISS_INQUIRY;
 			c->Request.CDB[4] = size  & 0xFF;
 		break;
 		case CISS_REPORT_LOG:
@@ -1163,11 +1186,9 @@
 				So we have nothing to write.
 			*/
 			c->Request.CDBLen = 12;
-			c->Request.Type.Type =  TYPE_CMD;
 			c->Request.Type.Attribute = ATTR_SIMPLE;
 			c->Request.Type.Direction = XFER_READ; /* Read */
 			c->Request.Timeout = 0; /* Don't time out */
-			c->Request.CDB[0] = CISS_REPORT_LOG;
 			c->Request.CDB[6] = (size >> 24) & 0xFF;  /* MSB */
 			c->Request.CDB[7] = (size >> 16) & 0xFF;
 			c->Request.CDB[8] = (size >> 8) & 0xFF;
@@ -1178,18 +1199,38 @@
 				hba[ctlr]->drv[log_unit].LunID;
 			c->Header.LUN.LogDev.Mode = 1;
 			c->Request.CDBLen = 10;
-			c->Request.Type.Type =  TYPE_CMD; /* It is a command. */
 			c->Request.Type.Attribute = ATTR_SIMPLE;
 			c->Request.Type.Direction = XFER_READ; /* Read */
 			c->Request.Timeout = 0; /* Don't time out */
-			c->Request.CDB[0] = CCISS_READ_CAPACITY;
 		break;
 		default:
 			printk(KERN_WARNING
 				"cciss:  Unknown Command 0x%x sent attempted\n",				cmd);
 			cmd_free(h, c, 1);
 			return IO_ERROR;
-	};
+		}
+	} else if (cmdtype == TYPE_MSG) {
+		switch (cmd) {
+		case 3: /* No-Op message */
+			c->Request.CDBLen = 1;
+			c->Request.Type.Attribute = ATTR_SIMPLE;
+			c->Request.Type.Direction = XFER_WRITE;
+			c->Request.Timeout = 0;
+			c->Request.CDB[0] = cmd;
+			break;
+		default:
+			printk(KERN_WARNING
+				"cciss%d: unknown message type %d\n",
+					ctlr, cmd);
+			cmd_free(h, c, 1);
+			return IO_ERROR;
+		}
+	} else {
+		printk(KERN_WARNING
+			"cciss%d: unknown command type %d\n", ctlr, cmdtype);
+		cmd_free(h, c, 1);
+		return IO_ERROR;
+	}
 
 	/* Fill in the scatter gather information */
 	if (size > 0) {
@@ -1352,7 +1393,7 @@
 	}
 
 	return_code = sendcmd_withirq(CISS_REPORT_LOG, ctlr, ld_buff,
-			sizeof(ReportLunData_struct), 0, 0, 0 );
+			sizeof(ReportLunData_struct), 0, 0, 0, TYPE_CMD);
 
 	if (return_code == IO_OK) {
 		listlength = be32_to_cpu(*((__u32 *) &ld_buff->LUNListLength[0]));
@@ -1451,7 +1492,7 @@
 	memset(size_buff, 0, sizeof(ReadCapdata_struct));
 	return_code = sendcmd_withirq(CCISS_READ_CAPACITY, ctlr,
 			size_buff, sizeof(ReadCapdata_struct), 1,
-			logvol, 0 );
+			logvol, 0, TYPE_CMD);
 	if (return_code == IO_OK) {
 		total_size = (0xff &
 			(unsigned int) size_buff->total_size[0]) << 24;
@@ -1482,7 +1523,7 @@
 	/* Execute the command to read the disk geometry */
 	memset(inq_buff, 0, sizeof(InquiryData_struct));
 	return_code = sendcmd_withirq(CISS_INQUIRY, ctlr, inq_buff,
-		sizeof(InquiryData_struct), 1, logvol ,0xC1 );
+		sizeof(InquiryData_struct), 1, logvol ,0xC1, TYPE_CMD);
 	if (return_code == IO_OK) {
 		if (inq_buff->data_byte[8] == 0xFF) {
 			printk(KERN_WARNING
@@ -1590,7 +1631,8 @@
 	}
 	memset(size_buff, 0, sizeof(ReadCapdata_struct));
 	return_code = sendcmd_withirq(CCISS_READ_CAPACITY, ctlr, size_buff,
-				sizeof( ReadCapdata_struct), 1, logvol, 0 );
+				sizeof( ReadCapdata_struct), 1, logvol, 0, 
+				TYPE_CMD);
 	if (return_code == IO_OK) {
 		total_size = (0xff &
 			(unsigned int)(size_buff->total_size[0])) << 24;
@@ -1619,7 +1661,7 @@
 	/* Execute the command to read the disk geometry */
 	memset(inq_buff, 0, sizeof(InquiryData_struct));
 	return_code = sendcmd_withirq(CISS_INQUIRY, ctlr, inq_buff,
-			sizeof(InquiryData_struct), 1, logvol ,0xC1 );
+			sizeof(InquiryData_struct), 1, logvol ,0xC1, TYPE_CMD);
 	if (return_code == IO_OK) {
 		if (inq_buff->data_byte[8] == 0xFF) {
 			printk(KERN_WARNING "cciss: reading geometry failed, "
@@ -2236,6 +2278,15 @@
 		goto startio;
         }
 
+	/* make sure controller is alive. */
+	if (!CTLR_IS_ALIVE(h)) {
+                printk(KERN_WARNING "cciss%d: I/O quit ", h->ctlr);
+                blkdev_dequeue_request(creq);
+                complete_buffers(creq->bh, 0);
+		end_that_request_last(creq);
+		return;
+	}
+
 	if (( c = cmd_alloc(h, 1)) == NULL)
 		goto startio;
 
@@ -2833,7 +2884,174 @@
 	kfree(hba[i]);
 	hba[i]=NULL;
 }
+#ifdef CONFIG_CISS_MONITOR_THREAD
+static void fail_all_cmds(unsigned long ctlr)
+{
+	/* If we get here, the board is apparently dead. */
+	ctlr_info_t *h = hba[ctlr];
+	CommandList_struct *c;
+	unsigned long flags;
+
+	printk(KERN_WARNING "cciss%d: controller not responding.\n", h->ctlr);
+	h->alive = 0;	/* the controller apparently died... */ 
+
+	spin_lock_irqsave(&io_request_lock, flags);
+
+	pci_disable_device(h->pdev); /* Make sure it is really dead. */
+
+	/* move everything off the request queue onto the completed queue */
+	while( (c = h->reqQ) != NULL ) {
+		removeQ(&(h->reqQ), c);
+		h->Qdepth--;
+		addQ (&(h->cmpQ), c); 
+	}
+
+	/* Now, fail everything on the completed queue with a HW error */
+	while( (c = h->cmpQ) != NULL ) {
+		removeQ(&h->cmpQ, c);
+		c->err_info->CommandStatus = CMD_HARDWARE_ERR;
+		if (c->cmd_type == CMD_RWREQ) {
+			complete_command(h, c, 0);
+		} else if (c->cmd_type == CMD_IOCTL_PEND)
+			complete(c->waiting);
+#		ifdef CONFIG_CISS_SCSI_TAPE
+			else if (c->cmd_type == CMD_SCSI)
+				complete_scsi_command(c, 0, 0);
+#		endif
+	}
+	spin_unlock_irqrestore(&io_request_lock, flags);
+	return;
+}
+static int cciss_monitor(void *ctlr)
+{
+	/* If the board fails, we ought to detect that.  So we periodically 
+	send down a No-Op message and expect it to complete quickly.  If it 
+	doesn't, then we assume the board is dead, and fail all commands.  
+	This is useful mostly in a multipath configuration, so that failover
+	will happen. */
+
+	int rc;
+	ctlr_info_t *h = (ctlr_info_t *) ctlr;
+	unsigned long flags;
+	u32 current_timer;
+
+	daemonize();
+	exit_files(current);
+	reparent_to_init();
+
+	printk("cciss%d: Monitor thread starting.\n", h->ctlr); 
+
+	/* only listen to signals if the HA was loaded as a module.  */
+#define SHUTDOWN_SIGS   (sigmask(SIGKILL)|sigmask(SIGINT)|sigmask(SIGTERM))
+	siginitsetinv(&current->blocked, SHUTDOWN_SIGS);
+	sprintf(current->comm, "ccissmon%d", h->ctlr);
+	h->monitor_thread = current;
+
+	init_timer(&h->watchdog); 
+	h->watchdog.function = fail_all_cmds;
+	h->watchdog.data = (unsigned long) h->ctlr;
+	while (1) {
+  		/* check heartbeat timer */
+                current_timer = readl(&h->cfgtable->HeartBeat);
+  		current_timer &= 0x0fffffff;
+  		if (heartbeat_timer == current_timer) {
+  			fail_all_cmds(h->ctlr);
+  			break;
+  		}
+  		else
+  			heartbeat_timer = current_timer;
+
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(h->monitor_period * HZ);
+		h->watchdog.expires = jiffies + HZ * h->monitor_deadline;
+		add_timer(&h->watchdog);
+		/* send down a trivial command (no op message) to ctlr */
+		rc = sendcmd_withirq(3, h->ctlr, NULL, 0, 0, 0, 0, TYPE_MSG);
+		del_timer(&h->watchdog);
+		if (!CTLR_IS_ALIVE(h))
+			break;
+		if (signal_pending(current)) {
+			printk(KERN_WARNING "%s received signal.\n",
+				current->comm);
+			break;
+		}
+		if (h->monitor_period == 0) /* zero period means exit thread */
+			break;
+	}
+	printk(KERN_INFO "%s exiting.\n", current->comm);
+	spin_lock_irqsave(&io_request_lock, flags);
+	h->monitor_started = 0;
+	h->monitor_thread = NULL;
+	spin_unlock_irqrestore(&io_request_lock, flags);
+	return 0;
+}
+static int start_monitor_thread(ctlr_info_t *h, unsigned char *cmd, 
+		unsigned long count, int (*cciss_monitor)(void *), int *rc)
+{
+	unsigned long flags;
+	unsigned int new_period, old_period, new_deadline, old_deadline;
+
+	if (strncmp("monitor", cmd, 7) == 0) {
+		new_period = simple_strtol(cmd + 8, NULL, 10);
+		spin_lock_irqsave(&io_request_lock, flags);
+		new_deadline = h->monitor_deadline;
+		spin_unlock_irqrestore(&io_request_lock, flags);
+	} else if (strncmp("deadline", cmd, 8) == 0) {
+		new_deadline = simple_strtol(cmd + 9, NULL, 10);
+		spin_lock_irqsave(&io_request_lock, flags);
+		new_period = h->monitor_period;
+		spin_unlock_irqrestore(&io_request_lock, flags);
+	} else
+		return -1;
+	if (new_period != 0 && new_period < CCISS_MIN_PERIOD)
+		new_period = CCISS_MIN_PERIOD;
+	if (new_period > CCISS_MAX_PERIOD)
+		new_period = CCISS_MAX_PERIOD;
+	if (new_deadline >= new_period) {
+		new_deadline = new_period - 5;
+		printk(KERN_INFO "setting deadline to %d\n", new_deadline);
+	}
+	spin_lock_irqsave(&io_request_lock, flags);
+	if (h->monitor_started != 0)  {
+		old_period = h->monitor_period;
+		old_deadline = h->monitor_deadline;
+		h->monitor_period = new_period;
+		h->monitor_deadline = new_deadline;
+		spin_unlock_irqrestore(&io_request_lock, flags);
+		if (new_period == 0) {
+			printk(KERN_INFO "cciss%d: stopping monitor thread\n",
+				h->ctlr);
+			*rc = count;
+			return 0;
+		}
+		if (new_period != old_period) 
+			printk(KERN_INFO "cciss%d: adjusting monitor thread "
+				"period from %d to %d seconds\n",
+				h->ctlr, old_period, new_period);
+		if (new_deadline != old_deadline) 
+			printk(KERN_INFO "cciss%d: adjusting monitor thread "
+				"deadline from %d to %d seconds\n",
+				h->ctlr, old_deadline, new_deadline);
+		*rc = count;
+		return 0;
+	}
+	h->monitor_started = 1;
+	h->monitor_period = new_period;
+	h->monitor_deadline = new_deadline;
+	spin_unlock_irqrestore(&io_request_lock, flags);
+	kernel_thread(cciss_monitor, h, 0);
+	*rc = count;
+	return 0;
+}
 
+static void kill_monitor_thread(ctlr_info_t *h)
+{
+	if (h->monitor_thread)
+		send_sig(SIGKILL, h->monitor_thread, 1);
+}
+#else
+#define kill_monitor_thread(h)
+#endif
 /*
  *  This is it.  Find all the controllers and register them.  I really hate
  *  stealing all these major device numbers.
@@ -2861,6 +3079,7 @@
 	sprintf(hba[i]->devname, "cciss%d", i);
 	hba[i]->ctlr = i;
 	hba[i]->pdev = pdev;
+	ASSERT_CTLR_ALIVE(hba[i]);
 
 	if (register_blkdev(MAJOR_NR+i, hba[i]->devname, &cciss_fops)) {
 		printk(KERN_ERR "cciss:  Unable to get major number "
@@ -2993,14 +3212,17 @@
 			"already be removed \n");
 		return;
 	}
- 	/* Turn board interrupts off  and send the flush cache command */
- 	/* sendcmd will turn off interrupt, and send the flush...
- 	 * To write all data in the battery backed cache to disks */
+	kill_monitor_thread(hba[i]);
+	/* no sense in trying to flush a dead board's cache. */
+	if (CTLR_IS_ALIVE(hba[i])) {
+		/* Turn board interrupts off and flush the cache */
+		/* write all data in the battery backed cache to disks */
  	memset(flush_buf, 0, 4);
- 	return_code = sendcmd(CCISS_CACHE_FLUSH, i, flush_buf, 4,0,0,0, NULL);
- 	if (return_code != IO_OK) {
+		return_code = sendcmd(CCISS_CACHE_FLUSH, i, flush_buf,
+					4, 0, 0, 0, NULL);
+		if (return_code != IO_OK)
  		printk(KERN_WARNING 
-			"Error Flushing cache on controller %d\n", i);
+				"cciss%d: Error flushing cache\n", i);
  	}
 	free_irq(hba[i]->intr, hba[i]);
 	pci_set_drvdata(pdev, NULL);
diff -burN lx2422rc2.orig/drivers/block/cciss.h lx2422rc2-detect/drivers/block/cciss.h
--- lx2422rc2.orig/drivers/block/cciss.h	2003-08-12 13:22:26.000000000 -0500
+++ lx2422rc2-detect/drivers/block/cciss.h	2003-08-12 13:37:02.000000000 -0500
@@ -91,6 +91,40 @@
 #ifdef CONFIG_CISS_SCSI_TAPE
 	void *scsi_ctlr; /* ptr to structure containing scsi related stuff */
 #endif
+#ifdef CONFIG_CISS_MONITOR_THREAD
+	struct timer_list watchdog;
+	struct task_struct *monitor_thread; 
+	unsigned int monitor_period;
+	unsigned int monitor_deadline;
+	unsigned char alive;
+	unsigned char monitor_started;
+#define CCISS_MIN_PERIOD 10
+#define CCISS_MAX_PERIOD 3600 
+#define CTLR_IS_ALIVE(h) (h->alive)
+#define ASSERT_CTLR_ALIVE(h) {	h->alive = 1; \
+				h->monitor_period = 0; \
+				h->monitor_started = 0; }
+#define MONITOR_STATUS_PATTERN "Status: %s\n"
+#define CTLR_STATUS(h) CTLR_IS_ALIVE(h) ? "operational" : "failed"
+#define MONITOR_PERIOD_PATTERN "Monitor thread period: %d\n"
+#define MONITOR_PERIOD_VALUE(h) (h->monitor_period)
+#define MONITOR_DEADLINE_PATTERN "Monitor thread deadline: %d\n"
+#define MONITOR_DEADLINE_VALUE(h) (h->monitor_deadline)
+#define START_MONITOR_THREAD(h, cmd, count, cciss_monitor, rc) \
+	start_monitor_thread(h, cmd, count, cciss_monitor, rc)
+#else
+
+#define MONITOR_PERIOD_PATTERN "%s"
+#define MONITOR_PERIOD_VALUE(h) ""
+#define MONITOR_DEADLINE_PATTERN "%s"
+#define MONITOR_DEADLINE_VALUE(h) ""
+#define MONITOR_STATUS_PATTERN "%s\n"
+#define CTLR_STATUS(h) ""
+#define CTLR_IS_ALIVE(h) (1)
+#define ASSERT_CTLR_ALIVE(h)
+#define START_MONITOR_THREAD(a,b,c,d,rc) (*rc == 0)
+
+#endif
 };
 
 /*  Defining the diffent access_menthods */
diff -burN lx2422rc2.orig/drivers/block/Config.in lx2422rc2-detect/drivers/block/Config.in
--- lx2422rc2.orig/drivers/block/Config.in	2002-11-28 17:53:12.000000000 -0600
+++ lx2422rc2-detect/drivers/block/Config.in	2003-08-12 13:37:02.000000000 -0500
@@ -36,6 +36,7 @@
 dep_tristate 'Compaq SMART2 support' CONFIG_BLK_CPQ_DA $CONFIG_PCI
 dep_tristate 'Compaq Smart Array 5xxx support' CONFIG_BLK_CPQ_CISS_DA $CONFIG_PCI 
 dep_mbool '       SCSI tape drive support for Smart Array 5xxx' CONFIG_CISS_SCSI_TAPE $CONFIG_BLK_CPQ_CISS_DA $CONFIG_SCSI
+dep_mbool '       Enable monitor thread' CONFIG_CISS_MONITOR_THREAD $CONFIG_BLK_CPQ_CISS_DA
 dep_tristate 'Mylex DAC960/DAC1100 PCI RAID Controller support' CONFIG_BLK_DEV_DAC960 $CONFIG_PCI
 dep_tristate 'Micro Memory MM5415 Battery Backed RAM support (EXPERIMENTAL)' CONFIG_BLK_DEV_UMEM $CONFIG_PCI $CONFIG_EXPERIMENTAL
 
