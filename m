Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266243AbTB0TRV>; Thu, 27 Feb 2003 14:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266257AbTB0TRV>; Thu, 27 Feb 2003 14:17:21 -0500
Received: from mailin.zma.compaq.com ([161.114.64.102]:17676 "EHLO
	zmamail02.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S266243AbTB0TRL>; Thu, 27 Feb 2003 14:17:11 -0500
Date: Thu, 27 Feb 2003 13:30:02 +0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.63 cciss fix unlikely startup problem
Message-ID: <20030227073002.GA1342@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another cciss patch:

Make cciss driver retry 3rd party bus reset aborted commands up to 3 times.
(ported to 2.5 by me, original patch by Charles White)

This is needed for a multi port storage box that can have
multiple hosts connected to it, or be used in a multipath
configuration.  In certain configurations SCSI bus resets 
initiated by one host may affect another host.

-- steve


--- linux-2.5.63/drivers/block/cciss.c~retry_aborted	2003-02-27 13:11:18.000000000 +0600
+++ linux-2.5.63-scameron/drivers/block/cciss.c	2003-02-27 13:11:18.000000000 +0600
@@ -102,6 +102,9 @@ static struct board_type products[] = {
 #define MAX_CONFIG_WAIT 30000 
 #define MAX_IOCTL_CONFIG_WAIT 1000
 
+/*define how many times we will try a command because of bus resets */
+#define MAX_CMD_RETRIES 3
+
 #define READ_AHEAD 	 128
 #define NR_CMDS		 384 /* #commands that can be outstanding */
 #define MAX_CTLR 8
@@ -934,6 +937,7 @@ static int sendcmd_withirq(__u8	cmd,
 		c->SG[0].Len = size;
 		c->SG[0].Ext = 0;  // we are not chaining
 	}
+resend_cmd2:
 	c->waiting = &wait;
 	
 	/* Put the request on the tail of the queue and send it */
@@ -945,10 +949,6 @@ static int sendcmd_withirq(__u8	cmd,
 	
 	wait_for_completion(&wait);
 
-	/* unlock the buffers from DMA */
-        pci_unmap_single( h->pdev, (dma_addr_t) buff_dma_handle.val,
-                	size, PCI_DMA_BIDIRECTIONAL);
-
 	if(c->err_info->CommandStatus != 0) 
 	{ /* an error has occurred */ 
 		switch(c->err_info->CommandStatus)
@@ -1000,11 +1000,22 @@ case CMD_HARDWARE_ERR:
 				return_status = IO_ERROR;
 			break;
 			case CMD_UNSOLICITED_ABORT:
-				printk(KERN_WARNING "cciss: cmd %p aborted "
-					"do to an unsolicited abort\n", c);
+				printk(KERN_WARNING 
+					"cciss%d: unsolicited abort %p\n",
+					ctlr, c);
+				if (c->retry_count < MAX_CMD_RETRIES) {
+					printk(KERN_WARNING 
+						"cciss%d: retrying %p\n", 
+						ctlr, c);
+					c->retry_count++;
+					/* erase the old error information */
+					memset(c->err_info, 0,
+						sizeof(ErrorInfo_struct));
+					return_status = IO_OK;
+					INIT_COMPLETION(wait);
+					goto resend_cmd2;
+				}
 				return_status = IO_ERROR;
-
-
 			break;
 			default:
 				printk(KERN_WARNING "cciss: cmd %p returned "
@@ -1013,6 +1024,9 @@ case CMD_HARDWARE_ERR:
 				return_status = IO_ERROR;
 		}
 	}	
+	/* unlock the buffers from DMA */
+	pci_unmap_single( h->pdev, (dma_addr_t) buff_dma_handle.val,
+			size, PCI_DMA_BIDIRECTIONAL);
 	cmd_free(h, c, 0);
         return(return_status);
 
@@ -1283,6 +1297,7 @@ static int sendcmd(
 	unsigned long complete;
 	ctlr_info_t *info_p= hba[ctlr];
 	u64bit buff_dma_handle;
+	int status = IO_OK;
 
 	c = cmd_alloc(info_p, 1);
 	if (c == NULL)
@@ -1396,6 +1411,7 @@ static int sendcmd(
 		c->SG[0].Len = size;
 		c->SG[0].Ext = 0;  // we are not chaining
 	}
+resend_cmd1:
 	/*
          * Disable interrupt
          */
@@ -1428,9 +1444,6 @@ static int sendcmd(
 	printk(KERN_DEBUG "cciss: command completed\n");
 #endif /* CCISS_DEBUG */
 
-	/* unlock the data buffer from DMA */
-	pci_unmap_single(info_p->pdev, (dma_addr_t) buff_dma_handle.val,
-                                size, PCI_DMA_BIDIRECTIONAL);
 	if (complete != 1) {
 		if ( (complete & CISS_ERROR_BIT)
 		     && (complete & ~CISS_ERROR_BIT) == c->busaddr)
@@ -1448,8 +1461,30 @@ static int sendcmd(
 			 	))
 			{
 				complete = c->busaddr;
-			} else
-			{
+			} else {
+				if (c->err_info->CommandStatus ==
+						CMD_UNSOLICITED_ABORT) {
+					printk(KERN_WARNING "cciss%d: "
+						"unsolicited abort %p\n",
+						ctlr, c);
+					if (c->retry_count < MAX_CMD_RETRIES) {
+						printk(KERN_WARNING
+						   "cciss%d: retrying %p\n",
+						   ctlr, c);
+						c->retry_count++;
+						/* erase the old error */
+						/* information */
+						memset(c->err_info, 0,
+						   sizeof(ErrorInfo_struct));
+						goto resend_cmd1;
+					} else {
+						printk(KERN_WARNING
+						   "cciss%d: retried %p too "
+						   "many times\n", ctlr, c);
+						status = IO_ERROR;
+						goto cleanup1;
+					}
+				}
 				printk(KERN_WARNING "ciss ciss%d: sendcmd"
 				" Error %x \n", ctlr, 
 					c->err_info->CommandStatus); 
@@ -1459,27 +1494,31 @@ static int sendcmd(
 				  c->err_info->MoreErrInfo.Invalid_Cmd.offense_size,
 				  c->err_info->MoreErrInfo.Invalid_Cmd.offense_num,
 				  c->err_info->MoreErrInfo.Invalid_Cmd.offense_value);
-				cmd_free(info_p,c, 1);
-				return(IO_ERROR);
+				status = IO_ERROR;
+				goto cleanup1;
 			}
 		}
                 if (complete != c->busaddr) {
                         printk( KERN_WARNING "cciss cciss%d: SendCmd "
                       "Invalid command list address returned! (%lx)\n",
                                 ctlr, complete);
-                        cmd_free(info_p, c, 1);
-                        return (IO_ERROR);
+			status = IO_ERROR;
+			goto cleanup1;
                 }
         } else {
                 printk( KERN_WARNING
                         "cciss cciss%d: SendCmd Timeout out, "
                         "No command list address returned!\n",
                         ctlr);
-                cmd_free(info_p, c, 1);
-                return (IO_ERROR);
+		status = IO_ERROR;
         }
+		
+cleanup1:	
+	/* unlock the data buffer from DMA */
+	pci_unmap_single(info_p->pdev, (dma_addr_t) buff_dma_handle.val,
+				size, PCI_DMA_BIDIRECTIONAL);
 	cmd_free(info_p, c, 1);
-        return (IO_OK);
+	return (status);
 } 
 /*
  * Map (physical) PCI mem into (virtual) kernel space
@@ -1563,27 +1602,35 @@ static inline void complete_buffers(stru
 	}
 
 } 
+/* Assumes that CCISS_LOCK(h->ctlr) is held. */
+/* Zeros out the error record and then resends the command back */
+/* to the controller */
+static inline void resend_cciss_cmd( ctlr_info_t *h, CommandList_struct *c)
+{
+	/* erase the old error information */
+	memset(c->err_info, 0, sizeof(ErrorInfo_struct));
+
+	/* add it to software queue and then send it to the controller */
+	addQ(&(h->reqQ),c);
+	h->Qdepth++;
+	if(h->Qdepth > h->maxQsinceinit)
+		h->maxQsinceinit = h->Qdepth;
+
+	start_io(h);
+}
 /* checks the status of the job and calls complete buffers to mark all 
  * buffers for the completed job. 
  */ 
-static inline void complete_command( CommandList_struct *cmd, int timeout)
+static inline void complete_command( ctlr_info_t *h, CommandList_struct *cmd,
+		int timeout)
 {
 	int status = 1;
 	int i;
+	int retry_cmd = 0;
 	u64bit temp64;
 		
 	if (timeout)
 		status = 0; 
-	/* unmap the DMA mapping for all the scatter gather elements */
-	for(i=0; i<cmd->Header.SGList; i++)
-	{
-		temp64.val32.lower = cmd->SG[i].Addr.lower;
-		temp64.val32.upper = cmd->SG[i].Addr.upper;
-		pci_unmap_page(hba[cmd->ctlr]->pdev,
-			temp64.val, cmd->SG[i].Len, 
-			(cmd->Request.Type.Direction == XFER_READ) ? 
-				PCI_DMA_FROMDEVICE : PCI_DMA_TODEVICE);
-	}
 
 	if(cmd->err_info->CommandStatus != 0) 
 	{ /* an error has occurred */ 
@@ -1657,8 +1704,18 @@ static inline void complete_command( Com
 				status=0;
 			break;
 			case CMD_UNSOLICITED_ABORT:
-				printk(KERN_WARNING "cciss: cmd %p aborted "
-					"do to an unsolicited abort\n", cmd);
+				printk(KERN_WARNING "cciss%d: unsolicited "
+					"abort %p\n", h->ctlr, cmd);
+				if (cmd->retry_count < MAX_CMD_RETRIES) {
+					retry_cmd=1;
+					printk(KERN_WARNING
+						"cciss%d: retrying %p\n",
+						h->ctlr, cmd);
+					cmd->retry_count++;
+				} else
+					printk(KERN_WARNING
+						"cciss%d: %p retried too "
+						"many times\n", h->ctlr, cmd);
 				status=0;
 			break;
 			case CMD_TIMEOUT:
@@ -1673,7 +1730,21 @@ static inline void complete_command( Com
 				status=0;
 		}
 	}
-
+	/* We need to return this command */
+	if(retry_cmd) {
+		resend_cciss_cmd(h,cmd);
+		return;
+	}	
+	/* command did not need to be retried */
+	/* unmap the DMA mapping for all the scatter gather elements */
+	for(i=0; i<cmd->Header.SGList; i++) {
+		temp64.val32.lower = cmd->SG[i].Addr.lower;
+		temp64.val32.upper = cmd->SG[i].Addr.upper;
+		pci_unmap_page(hba[cmd->ctlr]->pdev,
+			temp64.val, cmd->SG[i].Len,
+			(cmd->Request.Type.Direction == XFER_READ) ?
+				PCI_DMA_FROMDEVICE : PCI_DMA_TODEVICE);
+	}
 	complete_buffers(cmd->rq->bio, status);
 
 #ifdef CCISS_DEBUG
@@ -1681,6 +1752,7 @@ static inline void complete_command( Com
 #endif /* CCISS_DEBUG */ 
 
 	end_that_request_last(cmd->rq);
+	cmd_free(h,cmd,1);
 }
 
 /* 
@@ -1827,8 +1899,7 @@ static void do_cciss_intr(int irq, void 
 			 if (c->busaddr == a) {
 				removeQ(&h->cmpQ, c);
 				if (c->cmd_type == CMD_RWREQ) {
-					complete_command(c, 0);
-					cmd_free(h, c, 1);
+					complete_command(h, c, 0);
 				} else if (c->cmd_type == CMD_IOCTL_PEND) {
 					complete(c->waiting);
 				}
--- linux-2.5.63/drivers/block/cciss_cmd.h~retry_aborted	2003-02-27 13:11:18.000000000 +0600
+++ linux-2.5.63-scameron/drivers/block/cciss_cmd.h	2003-02-27 13:11:18.000000000 +0600
@@ -240,6 +240,7 @@ typedef struct _CommandList_struct {
   struct _CommandList_struct *next;
   struct request *	   rq;
   struct completion *waiting;
+  int	 retry_count;
 #ifdef CONFIG_CISS_SCSI_TAPE
   void * scsi_cmd;
 #endif

_
