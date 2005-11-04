Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbVKDSax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbVKDSax (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 13:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVKDSax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 13:30:53 -0500
Received: from ccerelbas01.cce.hp.com ([161.114.21.104]:27528 "EHLO
	ccerelbas01.cce.hp.com") by vger.kernel.org with ESMTP
	id S1750797AbVKDSau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 13:30:50 -0500
Date: Fri, 4 Nov 2005 12:30:37 -0600
From: mike.miller@hp.com
To: jgarzik@pobox.com, axboe@suse.de
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       steve.cameron@hp.com
Subject: [PATCH 1/1] cciss: scsi error handling
Message-ID: <20051104183037.GA8527@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PATCH 1 of 1

This patch adds SCSI error handling code to the SCSI portion 
of the cciss driver.

Signed-off-by: Stephen M. Cameron <steve.cameron@hp.com>
Acked-by: Mike Miller <mike.miller@hp.com>


 Documentation/cciss.txt    |   29 ++++++
 drivers/block/cciss.c      |  188 ++++++++++++++++++++++++++++++++++++++-------
 drivers/block/cciss.h      |   11 ++
 drivers/block/cciss_scsi.c |   82 +++++++++++++++++++
 4 files changed, 283 insertions(+), 27 deletions(-)

--- linux-2.6.14/Documentation/cciss.txt~cciss_scsi_error	2005-10-28 12:19:08.959011488 -0500
+++ linux-2.6.14-scameron/Documentation/cciss.txt	2005-10-28 12:19:08.971009664 -0500
@@ -133,3 +133,32 @@ hardware and it is important to prevent 
 access these devices too, as if the array controller were merely a SCSI 
 controller in the same way that we are allowing it to access SCSI tape drives.
 
+SCSI error handling for tape drives and medium changers
+-------------------------------------------------------
+
+The linux SCSI mid layer provides an error handling protocol which
+kicks into gear whenever a SCSI command fails to complete within a
+certain amount of time (which can vary depending on the command).
+The cciss driver participates in this protocol to some extent.  The
+normal protocol is a four step process.  First the device is told
+to abort the command.  If that doesn't work, the device is reset.
+If that doesn't work, the SCSI bus is reset.  If that doesn't work
+the host bus adapter is reset.  Because the cciss driver is a block
+driver as well as a SCSI driver and only the tape drives and medium
+changers are presented to the SCSI mid layer, and unlike more 
+straightforward SCSI drivers, disk i/o continues through the block
+side during the SCSI error recovery process, the cciss driver only
+implements the first two of these actions, aborting the command, and
+resetting the device.  Additionally, most tape drives will not oblige 
+in aborting commands, and sometimes it appears they will not even 
+obey a reset coommand, though in most circumstances they will.  In
+the case that the command cannot be aborted and the device cannot be 
+reset, the device will be set offline.
+
+In the event the error handling code is triggered and a tape drive is
+successfully reset or the tardy command is successfully aborted, the 
+tape drive may still not allow i/o to continue until some command
+is issued which positions the tape to a known position.  Typically you
+must rewind the tape (by issuing "mt -f /dev/st0 rewind" for example)
+before i/o can proceed again to a tape drive which was reset.
+
--- linux-2.6.14/drivers/block/cciss.c~cciss_scsi_error	2005-10-28 12:19:08.964010728 -0500
+++ linux-2.6.14-scameron/drivers/block/cciss.c	2005-10-28 12:21:49.010679936 -0500
@@ -148,6 +148,7 @@ static struct board_type products[] = {
 static ctlr_info_t *hba[MAX_CTLR];
 
 static void do_cciss_request(request_queue_t *q);
+static irqreturn_t do_cciss_intr(int irq, void *dev_id, struct pt_regs *regs);
 static int cciss_open(struct inode *inode, struct file *filep);
 static int cciss_release(struct inode *inode, struct file *filep);
 static int cciss_ioctl(struct inode *inode, struct file *filep, 
@@ -1586,6 +1587,24 @@ static int fill_cmd(CommandList_struct *
 		}
 	} else if (cmd_type == TYPE_MSG) {
 		switch (cmd) {
+		case 0: /* ABORT message */
+			c->Request.CDBLen = 12;
+			c->Request.Type.Attribute = ATTR_SIMPLE;
+			c->Request.Type.Direction = XFER_WRITE;
+			c->Request.Timeout = 0;
+			c->Request.CDB[0] = cmd; /* abort */
+			c->Request.CDB[1] = 0;   /* abort a command */
+			/* buff contains the tag of the command to abort */
+			memcpy(&c->Request.CDB[4], buff, 8);
+			break;
+		case 1: /* RESET message */
+			c->Request.CDBLen = 12;
+			c->Request.Type.Attribute = ATTR_SIMPLE;
+			c->Request.Type.Direction = XFER_WRITE;
+			c->Request.Timeout = 0;
+			memset(&c->Request.CDB[0], 0, sizeof(c->Request.CDB));
+			c->Request.CDB[0] = cmd;  /* reset */
+			c->Request.CDB[1] = 0x04; /* reset a LUN */
 		case 3:	/* No-Op message */
 			c->Request.CDBLen = 1;
 			c->Request.Type.Attribute = ATTR_SIMPLE;
@@ -1872,6 +1891,52 @@ static unsigned long pollcomplete(int ct
 	/* Invalid address to tell caller we ran out of time */
 	return 1;
 }
+
+static int add_sendcmd_reject(__u8 cmd, int ctlr, unsigned long complete)
+{
+	/* We get in here if sendcmd() is polling for completions
+	   and gets some command back that it wasn't expecting -- 
+	   something other than that which it just sent down.  
+	   Ordinarily, that shouldn't happen, but it can happen when 
+	   the scsi tape stuff gets into error handling mode, and
+	   starts using sendcmd() to try to abort commands and 
+	   reset tape drives.  In that case, sendcmd may pick up
+	   completions of commands that were sent to logical drives
+	   through the block i/o system, or cciss ioctls completing, etc. 
+	   In that case, we need to save those completions for later
+	   processing by the interrupt handler.
+	*/
+
+#ifdef CONFIG_CISS_SCSI_TAPE
+	struct sendcmd_reject_list *srl = &hba[ctlr]->scsi_rejects;	
+
+	/* If it's not the scsi tape stuff doing error handling, (abort */
+	/* or reset) then we don't expect anything weird. */
+	if (cmd != CCISS_RESET_MSG && cmd != CCISS_ABORT_MSG) {
+#endif
+		printk( KERN_WARNING "cciss cciss%d: SendCmd "
+		      "Invalid command list address returned! (%lx)\n",
+			ctlr, complete);
+		/* not much we can do. */
+#ifdef CONFIG_CISS_SCSI_TAPE
+		return 1;
+	}
+
+	/* We've sent down an abort or reset, but something else
+	   has completed */
+	if (srl->ncompletions >= (NR_CMDS + 2)) {
+		/* Uh oh.  No room to save it for later... */
+		printk(KERN_WARNING "cciss%d: Sendcmd: Invalid command addr, "
+			"reject list overflow, command lost!\n", ctlr);
+		return 1;
+	}
+	/* Save it for later */
+	srl->complete[srl->ncompletions] = complete;
+	srl->ncompletions++;
+#endif
+	return 0;
+}
+
 /*
  * Send a command to the controller, and wait for it to complete.  
  * Only used at init time. 
@@ -1894,7 +1959,7 @@ static int sendcmd(
 	unsigned long complete;
 	ctlr_info_t *info_p= hba[ctlr];
 	u64bit buff_dma_handle;
-	int status;
+	int status, done = 0;
 
 	if ((c = cmd_alloc(info_p, 1)) == NULL) {
 		printk(KERN_WARNING "cciss: unable to get memory");
@@ -1916,7 +1981,9 @@ resend_cmd1:
         info_p->access.set_intr_mask(info_p, CCISS_INTR_OFF);
 	
 	/* Make sure there is room in the command FIFO */
-        /* Actually it should be completely empty at this time. */
+        /* Actually it should be completely empty at this time */
+	/* unless we are in here doing error handling for the scsi */
+	/* tape side of the driver. */
         for (i = 200000; i > 0; i--) 
 	{
 		/* if fifo isn't full go */
@@ -1933,13 +2000,25 @@ resend_cmd1:
          * Send the cmd
          */
         info_p->access.submit_command(info_p, c);
-        complete = pollcomplete(ctlr);
+	done = 0;
+	do {
+		complete = pollcomplete(ctlr);
 
 #ifdef CCISS_DEBUG
-	printk(KERN_DEBUG "cciss: command completed\n");
+		printk(KERN_DEBUG "cciss: command completed\n");
 #endif /* CCISS_DEBUG */
 
-	if (complete != 1) {
+		if (complete == 1) {
+			printk( KERN_WARNING
+				"cciss cciss%d: SendCmd Timeout out, "
+				"No command list address returned!\n",
+				ctlr);
+			status = IO_ERROR;
+			done = 1;
+			break;
+		}
+
+		/* This will need to change for direct lookup completions */
 		if ( (complete & CISS_ERROR_BIT)
 		     && (complete & ~CISS_ERROR_BIT) == c->busaddr)
 		     {
@@ -1979,6 +2058,10 @@ resend_cmd1:
 						status = IO_ERROR;
 						goto cleanup1;
 					}
+				} else if (c->err_info->CommandStatus == CMD_UNABORTABLE) {
+					printk(KERN_WARNING "cciss%d: command could not be aborted.\n", ctlr);
+					status = IO_ERROR;
+					goto cleanup1;
 				}
 				printk(KERN_WARNING "ciss ciss%d: sendcmd"
 				" Error %x \n", ctlr, 
@@ -1993,20 +2076,15 @@ resend_cmd1:
 				goto cleanup1;
 			}
 		}
+		/* This will need changing for direct lookup completions */
                 if (complete != c->busaddr) {
-                        printk( KERN_WARNING "cciss cciss%d: SendCmd "
-                      "Invalid command list address returned! (%lx)\n",
-                                ctlr, complete);
-			status = IO_ERROR;
-			goto cleanup1;
-                }
-        } else {
-                printk( KERN_WARNING
-                        "cciss cciss%d: SendCmd Timeout out, "
-                        "No command list address returned!\n",
-                        ctlr);
-		status = IO_ERROR;
-        }
+			if (add_sendcmd_reject(cmd, ctlr, complete) != 0) {
+				BUG(); /* we are pretty much hosed if we get here. */
+			}
+			continue;
+                } else
+			done = 1;
+        } while (!done);
 		
 cleanup1:	
 	/* unlock the data buffer from DMA */
@@ -2014,6 +2092,11 @@ cleanup1:	
 	buff_dma_handle.val32.upper = c->SG[0].Addr.upper;
 	pci_unmap_single(info_p->pdev, (dma_addr_t) buff_dma_handle.val,
 				c->SG[0].Len, PCI_DMA_BIDIRECTIONAL);
+#ifdef CONFIG_CISS_SCSI_TAPE
+	/* if we saved some commands for later, process them now. */
+	if (info_p->scsi_rejects.ncompletions > 0)
+		do_cciss_intr(0, info_p, NULL);
+#endif
 	cmd_free(info_p, c, 1);
 	return (status);
 } 
@@ -2338,6 +2421,48 @@ startio:
 	start_io(h);
 }
 
+static inline unsigned long get_next_completion(ctlr_info_t *h)
+{
+#ifdef CONFIG_CISS_SCSI_TAPE
+	/* Any rejects from sendcmd() lying around? Process them first */
+	if (h->scsi_rejects.ncompletions == 0)
+		return h->access.command_completed(h);
+	else {
+		struct sendcmd_reject_list *srl;
+		int n;
+		srl = &h->scsi_rejects;
+		n = --srl->ncompletions;
+		/* printk("cciss%d: processing saved reject\n", h->ctlr); */
+		printk("p");
+		return srl->complete[n];
+	}
+#else
+	return h->access.command_completed(h);
+#endif
+}
+
+static inline int interrupt_pending(ctlr_info_t *h)
+{
+#ifdef CONFIG_CISS_SCSI_TAPE
+	return ( h->access.intr_pending(h) 
+		|| (h->scsi_rejects.ncompletions > 0));
+#else
+	return h->access.intr_pending(h);
+#endif
+}
+
+static inline long interrupt_not_for_us(ctlr_info_t *h)
+{
+#ifdef CONFIG_CISS_SCSI_TAPE
+	return (((h->access.intr_pending(h) == 0) || 
+		 (h->interrupts_enabled == 0)) 
+	      && (h->scsi_rejects.ncompletions == 0));
+#else
+	return (((h->access.intr_pending(h) == 0) || 
+		 (h->interrupts_enabled == 0)));
+#endif
+}
+
 static irqreturn_t do_cciss_intr(int irq, void *dev_id, struct pt_regs *regs)
 {
 	ctlr_info_t *h = dev_id;
@@ -2347,19 +2472,15 @@ static irqreturn_t do_cciss_intr(int irq
 	int j;
 	int start_queue = h->next_to_run;
 
-	/* Is this interrupt for us? */
-	if (( h->access.intr_pending(h) == 0) || (h->interrupts_enabled == 0))
+	if (interrupt_not_for_us(h))
 		return IRQ_NONE;
-
 	/*
 	 * If there are completed commands in the completion queue,
 	 * we had better do something about it.
 	 */
 	spin_lock_irqsave(CCISS_LOCK(h->ctlr), flags);
-	while( h->access.intr_pending(h))
-	{
-		while((a = h->access.command_completed(h)) != FIFO_EMPTY) 
-		{
+	while (interrupt_pending(h)) {
+		while((a = get_next_completion(h)) != FIFO_EMPTY) {
 			a1 = a;
 			if ((a & 0x04)) {
 				a2 = (a >> 3);
@@ -2966,7 +3087,15 @@ static int __devinit cciss_init_one(stru
                 printk( KERN_ERR "cciss: out of memory");
 		goto clean4;
 	}
-
+#ifdef CONFIG_CISS_SCSI_TAPE
+	hba[i]->scsi_rejects.complete = 
+		kmalloc(sizeof(hba[i]->scsi_rejects.complete[0]) * 
+			(NR_CMDS + 5), GFP_KERNEL);
+	if (hba[i]->scsi_rejects.complete == NULL) {
+                printk( KERN_ERR "cciss: out of memory");
+		goto clean4;
+	}
+#endif
 	spin_lock_init(&hba[i]->lock);
 
 	/* Initialize the pdev driver private data. 
@@ -3034,6 +3163,10 @@ static int __devinit cciss_init_one(stru
 	return(1);
 
 clean4:
+#ifdef CONFIG_CISS_SCSI_TAPE
+	if(hba[i]->scsi_rejects.complete)
+		kfree(hba[i]->scsi_rejects.complete);
+#endif
 	if(hba[i]->cmd_pool_bits)
                	kfree(hba[i]->cmd_pool_bits);
 	if(hba[i]->cmd_pool)
@@ -3107,6 +3240,9 @@ static void __devexit cciss_remove_one (
 	pci_free_consistent(hba[i]->pdev, NR_CMDS * sizeof( ErrorInfo_struct),
 		hba[i]->errinfo_pool, hba[i]->errinfo_pool_dhandle);
 	kfree(hba[i]->cmd_pool_bits);
+#ifdef CONFIG_CISS_SCSI_TAPE
+	kfree(hba[i]->scsi_rejects.complete);
+#endif
  	release_io_mem(hba[i]);
 	free_hba(i);
 }	
--- linux-2.6.14/drivers/block/cciss.h~cciss_scsi_error	2005-10-28 12:19:08.966010424 -0500
+++ linux-2.6.14-scameron/drivers/block/cciss.h	2005-10-28 12:19:08.985007536 -0500
@@ -44,6 +44,14 @@ typedef struct _drive_info_struct
 				  */
 } drive_info_struct;
 
+#ifdef CONFIG_CISS_SCSI_TAPE
+
+struct sendcmd_reject_list {
+	int ncompletions;
+	unsigned long *complete; /* array of NR_CMDS tags */
+};
+
+#endif
 struct ctlr_info 
 {
 	int	ctlr;
@@ -100,6 +108,9 @@ struct ctlr_info 
 	struct gendisk   *gendisk[NWD];
 #ifdef CONFIG_CISS_SCSI_TAPE
 	void *scsi_ctlr; /* ptr to structure containing scsi related stuff */
+	/* list of block side commands the scsi error handling sucked up */
+	/* and saved for later processing */
+	struct sendcmd_reject_list scsi_rejects;
 #endif
 	unsigned char alive;
 };
--- linux-2.6.14/drivers/block/cciss_scsi.c~cciss_scsi_error	2005-10-28 12:19:08.968010120 -0500
+++ linux-2.6.14-scameron/drivers/block/cciss_scsi.c	2005-10-28 12:19:08.987007232 -0500
@@ -38,6 +38,9 @@
 
 #include "cciss_scsi.h"
 
+#define CCISS_ABORT_MSG 0x00
+#define CCISS_RESET_MSG 0x01
+
 /* some prototypes... */ 
 static int sendcmd(
 	__u8	cmd,
@@ -63,6 +66,8 @@ static int cciss_scsi_proc_info(
 
 static int cciss_scsi_queue_command (struct scsi_cmnd *cmd,
 		void (* done)(struct scsi_cmnd *));
+static int cciss_eh_device_reset_handler(struct scsi_cmnd *);
+static int cciss_eh_abort_handler(struct scsi_cmnd *);
 
 static struct cciss_scsi_hba_t ccissscsi[MAX_CTLR] = {
 	{ .name = "cciss0", .ndevices = 0 },
@@ -86,6 +91,9 @@ static struct scsi_host_template cciss_d
 	.sg_tablesize		= MAXSGENTRIES,
 	.cmd_per_lun		= 1,
 	.use_clustering		= DISABLE_CLUSTERING,
+	/* Can't have eh_bus_reset_handler or eh_host_reset_handler for cciss */
+	.eh_device_reset_handler= cciss_eh_device_reset_handler,
+	.eh_abort_handler	= cciss_eh_abort_handler,
 };
 
 #pragma pack(1)
@@ -243,7 +251,7 @@ scsi_cmd_stack_free(int ctlr)
 #define DEVICETYPE(n) (n<0 || n>MAX_SCSI_DEVICE_CODE) ? \
 	"Unknown" : scsi_device_types[n]
 
-#if 0
+#if 1
 static int xmargin=8;
 static int amargin=60;
 
@@ -1444,6 +1452,78 @@ cciss_proc_tape_report(int ctlr, unsigne
 	*pos += size; *len += size;
 }
 
+/* Need at least one of these error handlers to keep ../scsi/hosts.c from 
+ * complaining.  Doing a host- or bus-reset can't do anything good here. 
+ * Despite what it might say in scsi_error.c, there may well be commands
+ * on the controller, as the cciss driver registers twice, once as a block
+ * device for the logical drives, and once as a scsi device, for any tape
+ * drives.  So we know there are no commands out on the tape drives, but we
+ * don't know there are no commands on the controller, and it is likely 
+ * that there probably are, as the cciss block device is most commonly used
+ * as a boot device (embedded controller on HP/Compaq systems.)
+*/
+
+static int cciss_eh_device_reset_handler(struct scsi_cmnd *scsicmd)
+{
+	int rc;
+	CommandList_struct *cmd_in_trouble;
+	ctlr_info_t **c;
+	int ctlr;
+
+	/* find the controller to which the command to be aborted was sent */
+	c = (ctlr_info_t **) &scsicmd->device->host->hostdata[0];	
+	if (c == NULL) /* paranoia */
+		return FAILED;
+	ctlr = (*c)->ctlr;
+	printk(KERN_WARNING "cciss%d: resetting tape drive or medium changer.\n", ctlr);
+
+	/* find the command that's giving us trouble */
+	cmd_in_trouble = (CommandList_struct *) scsicmd->host_scribble;
+	if (cmd_in_trouble == NULL) { /* paranoia */
+		return FAILED;
+	}
+	/* send a reset to the SCSI LUN which the command was sent to */
+	rc = sendcmd(CCISS_RESET_MSG, ctlr, NULL, 0, 2, 0, 0, 
+		(unsigned char *) &cmd_in_trouble->Header.LUN.LunAddrBytes[0], 
+		TYPE_MSG);
+	/* sendcmd turned off interrputs on the board, turn 'em back on. */
+	(*c)->access.set_intr_mask(*c, CCISS_INTR_ON);
+	if (rc == 0)
+		return SUCCESS;
+	printk(KERN_WARNING "cciss%d: resetting device failed.\n", ctlr);
+	return FAILED;
+}
+
+static int  cciss_eh_abort_handler(struct scsi_cmnd *scsicmd)
+{
+	int rc;
+	CommandList_struct *cmd_to_abort;
+	ctlr_info_t **c;
+	int ctlr;
+
+	/* find the controller to which the command to be aborted was sent */
+	c = (ctlr_info_t **) &scsicmd->device->host->hostdata[0];	
+	if (c == NULL) /* paranoia */
+		return FAILED;
+	ctlr = (*c)->ctlr;
+	printk(KERN_WARNING "cciss%d: aborting tardy SCSI cmd\n", ctlr);
+
+	/* find the command to be aborted */
+	cmd_to_abort = (CommandList_struct *) scsicmd->host_scribble;
+	if (cmd_to_abort == NULL) /* paranoia */
+		return FAILED;
+	rc = sendcmd(CCISS_ABORT_MSG, ctlr, &cmd_to_abort->Header.Tag, 
+		0, 2, 0, 0, 
+		(unsigned char *) &cmd_to_abort->Header.LUN.LunAddrBytes[0], 
+		TYPE_MSG);
+	/* sendcmd turned off interrputs on the board, turn 'em back on. */
+	(*c)->access.set_intr_mask(*c, CCISS_INTR_ON);
+	if (rc == 0)
+		return SUCCESS;
+	return FAILED;
+
+}
+
 #else /* no CONFIG_CISS_SCSI_TAPE */
 
 /* If no tape support, then these become defined out of existence */

_
