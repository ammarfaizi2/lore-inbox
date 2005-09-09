Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030601AbVIIWGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030601AbVIIWGf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 18:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030607AbVIIWGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 18:06:34 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:25554 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1030601AbVIIWGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 18:06:32 -0400
Date: Fri, 9 Sep 2005 17:06:09 -0500
From: mike.miller@hp.com
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 4/8] cciss: direct lookup for command completions
Message-ID: <20050909220609.GD4616@beardog.cca.cpqcorp.net>
Reply-To: mikem@beardog.cca.cpqcorp.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 4 of 8
This patch changes the way we complete commands. In the old method when we
got a completion we searched our command list from the top until we find it.
This method uses a tag associated with each command (not SCSI command tagging)
to index us directly to the completed command. This helps performance.
Please consider this for inclusion.

Signed-off-by: Don Brace <dab@hp.com>
Signed-off-by: Mike Miller <mike.miller@hp.com>

 cciss.c      |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 cciss.h      |    1
 cciss_cmd.h  |    8 +++++-
 cciss_scsi.c |    1
 4 files changed, 73 insertions(+), 7 deletions(-)
--------------------------------------------------------------------------------
diff -burNp lx2613-p003/drivers/block/cciss.c lx2613/drivers/block/cciss.c
--- lx2613-p003/drivers/block/cciss.c	2005-09-07 14:40:02.852611000 -0500
+++ lx2613/drivers/block/cciss.c	2005-09-07 14:55:12.831273680 -0500
@@ -174,6 +174,8 @@ static int sendcmd_withirq(__u8	cmd, int
 	unsigned int use_unit_num, unsigned int log_unit, __u8	page_code,
 	int cmd_type);
 
+static void fail_all_cmds(unsigned long ctlr);
+
 #ifdef CONFIG_PROC_FS
 static int cciss_proc_get_info(char *buffer, char **start, off_t offset, 
 		int length, int *eof, void *data);
@@ -387,6 +389,8 @@ static CommandList_struct * cmd_alloc(ct
                  	return NULL;
 		memset(c, 0, sizeof(CommandList_struct));
 
+		c->cmdindex = -1;
+
 		c->err_info = (ErrorInfo_struct *)pci_alloc_consistent(
 					h->pdev, sizeof(ErrorInfo_struct), 
 					&err_dma_handle);
@@ -417,6 +421,8 @@ static CommandList_struct * cmd_alloc(ct
 		err_dma_handle = h->errinfo_pool_dhandle 
 					+ i*sizeof(ErrorInfo_struct);
                 h->nr_allocs++;
+
+		c->cmdindex = i;
         }
 
 	c->busaddr = (__u32) cmd_dma_handle;
@@ -2259,7 +2265,11 @@ queue:
 	/* fill in the request */ 
 	drv = creq->rq_disk->private_data;
 	c->Header.ReplyQueue = 0;  // unused in simple mode
-	c->Header.Tag.lower = c->busaddr;  // use the physical address the cmd block for tag
+	/* got command from pool, so use the command block index instead */
+	/* for direct lookups. */
+	/* The first 2 bits are reserved for controller error reporting. */
+	c->Header.Tag.lower = (c->cmdindex << 3);
+	c->Header.Tag.lower |= 0x04; /* flag for direct lookup. */
 	c->Header.LUN.LogDev.VolId= drv->LunID;
 	c->Header.LUN.LogDev.Mode = 1;
 	c->Request.CDBLen = 10; // 12 byte commands not in FW yet;
@@ -2334,7 +2344,7 @@ static irqreturn_t do_cciss_intr(int irq
 	ctlr_info_t *h = dev_id;
 	CommandList_struct *c;
 	unsigned long flags;
-	__u32 a, a1;
+	__u32 a, a1, a2;
 	int j;
 	int start_queue = h->next_to_run;
 
@@ -2352,10 +2362,21 @@ static irqreturn_t do_cciss_intr(int irq
 		while((a = h->access.command_completed(h)) != FIFO_EMPTY) 
 		{
 			a1 = a;
+			if ((a & 0x04)) {
+				a2 = (a >> 3);
+				if (a2 >= NR_CMDS) {
+					printk(KERN_WARNING "cciss: controller cciss%d failed, stopping.\n", h->ctlr);
+					fail_all_cmds(h->ctlr);
+					return IRQ_HANDLED;
+				}
+
+				c = h->cmd_pool + a2;
+				a = c->busaddr;
+
+			} else {
 			a &= ~3;
-			if ((c = h->cmpQ) == NULL)
-			{  
-				printk(KERN_WARNING "cciss: Completion of %08lx ignored\n", (unsigned long)a1);
+				if ((c = h->cmpQ) == NULL) {  
+					printk(KERN_WARNING "cciss: Completion of %08x ignored\n", a1);
 				continue;	
 			} 
 			while(c->busaddr != a) {
@@ -2363,6 +2384,7 @@ static irqreturn_t do_cciss_intr(int irq
 				if (c == h->cmpQ) 
 					break;
 			}
+			}
 			/*
 			 * If we've found the command, take it off the
 			 * completion Q and free it
@@ -3126,5 +3148,43 @@ static void __exit cciss_cleanup(void)
 	remove_proc_entry("cciss", proc_root_driver);
 }
 
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
+	spin_lock_irqsave(CCISS_LOCK(ctlr), flags);
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
+#ifdef CONFIG_CISS_SCSI_TAPE
+			else if (c->cmd_type == CMD_SCSI)
+				complete_scsi_command(c, 0, 0);
+#endif
+	}
+	spin_unlock_irqrestore(CCISS_LOCK(ctlr), flags);
+	return;
+}
+
 module_init(cciss_init);
 module_exit(cciss_cleanup);
diff -burNp lx2613-p003/drivers/block/cciss.h lx2613/drivers/block/cciss.h
--- lx2613-p003/drivers/block/cciss.h	2005-09-07 14:40:02.852611000 -0500
+++ lx2613/drivers/block/cciss.h	2005-09-07 14:55:12.833273376 -0500
@@ -101,6 +101,7 @@ struct ctlr_info 
 #ifdef CONFIG_CISS_SCSI_TAPE
 	void *scsi_ctlr; /* ptr to structure containing scsi related stuff */
 #endif
+	unsigned char alive;
 };
 
 /*  Defining the diffent access_menthods */
diff -burNp lx2613-p003/drivers/block/cciss_cmd.h lx2613/drivers/block/cciss_cmd.h
--- lx2613-p003/drivers/block/cciss_cmd.h	2005-08-28 18:41:01.000000000 -0500
+++ lx2613/drivers/block/cciss_cmd.h	2005-09-07 14:55:12.832273528 -0500
@@ -226,6 +226,10 @@ typedef struct _ErrorInfo_struct {
 #define CMD_MSG_DONE	0x04
 #define CMD_MSG_TIMEOUT 0x05
 
+/* This structure needs to be divisible by 8 for new
+ * indexing method.
+ */
+#define PADSIZE (sizeof(long) - 4)
 typedef struct _CommandList_struct {
   CommandListHeader_struct Header;
   RequestBlock_struct      Request;
@@ -236,14 +240,14 @@ typedef struct _CommandList_struct {
   ErrorInfo_struct * 	   err_info; /* pointer to the allocated mem */ 
   int			   ctlr;
   int			   cmd_type; 
+  long			   cmdindex;
   struct _CommandList_struct *prev;
   struct _CommandList_struct *next;
   struct request *	   rq;
   struct completion *waiting;
   int	 retry_count;
-#ifdef CONFIG_CISS_SCSI_TAPE
   void * scsi_cmd;
-#endif
+  char   pad[PADSIZE];
 } CommandList_struct;
 
 //Configuration Table Structure
diff -burNp lx2613-p003/drivers/block/cciss_scsi.c lx2613/drivers/block/cciss_scsi.c
--- lx2613-p003/drivers/block/cciss_scsi.c	2005-08-28 18:41:01.000000000 -0500
+++ lx2613/drivers/block/cciss_scsi.c	2005-09-07 14:55:12.834273224 -0500
@@ -93,6 +93,7 @@ struct cciss_scsi_cmd_stack_elem_t {
 	CommandList_struct cmd;
 	ErrorInfo_struct Err;
 	__u32 busaddr;
+	__u32 pad;
 };
 
 #pragma pack()
