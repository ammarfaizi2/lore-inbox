Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265058AbSJWPfU>; Wed, 23 Oct 2002 11:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265060AbSJWPeW>; Wed, 23 Oct 2002 11:34:22 -0400
Received: from mailout.zma.compaq.com ([161.114.64.104]:35852 "EHLO
	zmamail04.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S265058AbSJWPd2>; Wed, 23 Oct 2002 11:33:28 -0400
Date: Wed, 23 Oct 2002 09:35:50 -0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] 2.5.44 cciss retry aborted commands
Message-ID: <20021023093550.J14917@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patch 10 of 10
The whole set can be grabbed via anonymous cvs (empty password):
cvs -d:pserver:anonymous@cvs.cciss.sourceforge.net:/cvsroot/cciss login
cvs -z3 -d:pserver:anonymous@cvs.cciss.sourceforge.net:/cvsroot/cciss co 2.5.44

DESC
Make cciss driver retry 3rd party bus reset aborted commands up to 3 times.


 drivers/block/cciss.c     |  131 +++++++++++++++++++++++++++++++++++-----------
 drivers/block/cciss_cmd.h |    1 
 2 files changed, 102 insertions, 30 deletions

--- linux-2.5.44/drivers/block/cciss.c~retry_aborted	Tue Oct 22 13:22:26 2002
+++ linux-2.5.44-root/drivers/block/cciss.c	Tue Oct 22 13:22:26 2002
@@ -88,6 +88,9 @@ static struct board_type products[] = {
 /* How long to wait (in millesconds) for board to go into simple mode */
 #define MAX_CONFIG_WAIT 1000 
 
+/*define how many times we will try a command because of bus resets */
+#define MAX_CMD_RETRIES 3
+
 #define READ_AHEAD 	 128
 #define NR_CMDS		 384 /* #commands that can be outstanding */
 #define MAX_CTLR 8
@@ -940,6 +943,7 @@ static int sendcmd_withirq(__u8	cmd,
 		c->SG[0].Len = size;
 		c->SG[0].Ext = 0;  // we are not chaining
 	}
+resend_cmd2:
 	c->waiting = &wait;
 	
 	/* Put the request on the tail of the queue and send it */
@@ -951,10 +955,6 @@ static int sendcmd_withirq(__u8	cmd,
 	
 	wait_for_completion(&wait);
 
-	/* unlock the buffers from DMA */
-        pci_unmap_single( h->pdev, (dma_addr_t) buff_dma_handle.val,
-                	size, PCI_DMA_BIDIRECTIONAL);
-
 	if(c->err_info->CommandStatus != 0) 
 	{ /* an error has occurred */ 
 		switch(c->err_info->CommandStatus)
@@ -1008,6 +1008,16 @@ case CMD_HARDWARE_ERR:
 			case CMD_UNSOLICITED_ABORT:
 				printk(KERN_WARNING "cciss: cmd %p aborted "
 					"do to an unsolicited abort\n", c);
+				if (c->retry_count < MAX_CMD_RETRIES) {
+					printk(KERN_WARNING "retrying cmd\n");
+					c->retry_count++;
+					/* erase the old error information */
+					memset(c->err_info, 0,
+						sizeof(ErrorInfo_struct));
+					return_status = IO_OK;
+					INIT_COMPLETION(wait);
+					goto resend_cmd2;
+				}
 				return_status = IO_ERROR;
 
 
@@ -1019,6 +1029,9 @@ case CMD_HARDWARE_ERR:
 				return_status = IO_ERROR;
 		}
 	}	
+	/* unlock the buffers from DMA */
+	pci_unmap_single( h->pdev, (dma_addr_t) buff_dma_handle.val,
+			size, PCI_DMA_BIDIRECTIONAL);
 	cmd_free(h, c, 0);
         return(return_status);
 
@@ -1296,6 +1309,7 @@ static int sendcmd(
 	unsigned long complete;
 	ctlr_info_t *info_p= hba[ctlr];
 	u64bit buff_dma_handle;
+	int status = IO_OK;
 
 	c = cmd_alloc(info_p, 1);
 	if (c == NULL)
@@ -1409,6 +1423,7 @@ static int sendcmd(
 		c->SG[0].Len = size;
 		c->SG[0].Ext = 0;  // we are not chaining
 	}
+resend_cmd1:
 	/*
          * Disable interrupt
          */
@@ -1441,9 +1456,6 @@ static int sendcmd(
 	printk(KERN_DEBUG "cciss: command completed\n");
 #endif /* CCISS_DEBUG */
 
-	/* unlock the data buffer from DMA */
-	pci_unmap_single(info_p->pdev, (dma_addr_t) buff_dma_handle.val,
-                                size, PCI_DMA_BIDIRECTIONAL);
 	if (complete != 1) {
 		if ( (complete & CISS_ERROR_BIT)
 		     && (complete & ~CISS_ERROR_BIT) == c->busaddr)
@@ -1463,6 +1475,27 @@ static int sendcmd(
 				complete = c->busaddr;
 			} else
 			{
+				if (c->err_info->CommandStatus ==
+						CMD_UNSOLICITED_ABORT) {
+					printk(KERN_WARNING "cciss: "
+						"cmd %p aborted do "
+					"to an unsolicited abort \n", c);
+					if (c->retry_count < MAX_CMD_RETRIES) {
+						printk(KERN_WARNING
+						   "retrying cmd\n");
+						c->retry_count++;
+						/* erase the old error */
+						/* information */
+						memset(c->err_info, 0,
+						   sizeof(ErrorInfo_struct));
+						goto resend_cmd1;
+					} else {
+						printk(KERN_WARNING
+						   "retried to many times\n");
+						status = IO_ERROR;
+						goto cleanup1;
+					}
+				}
 				printk(KERN_WARNING "ciss ciss%d: sendcmd"
 				" Error %x \n", ctlr, 
 					c->err_info->CommandStatus); 
@@ -1472,27 +1505,31 @@ static int sendcmd(
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
@@ -1576,27 +1613,35 @@ static inline void complete_buffers(stru
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
@@ -1670,8 +1715,20 @@ static inline void complete_command( Com
 				status=0;
 			break;
 			case CMD_UNSOLICITED_ABORT:
-				printk(KERN_WARNING "cciss: cmd %p aborted "
-					"do to an unsolicited abort\n", cmd);
+				printk(KERN_WARNING "cciss: cmd %p aborted do "
+					"to an unsolicited abort \n",
+				       	cmd);
+				if (cmd->retry_count < MAX_CMD_RETRIES)
+				{
+					retry_cmd=1;
+					printk(KERN_WARNING
+						"retrying cmd\n");
+					cmd->retry_count++;
+				} else
+				{
+					printk(KERN_WARNING
+					"retried to many times\n");
+				}
 				status=0;
 			break;
 			case CMD_TIMEOUT:
@@ -1686,7 +1743,21 @@ static inline void complete_command( Com
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
@@ -1694,6 +1765,7 @@ static inline void complete_command( Com
 #endif /* CCISS_DEBUG */ 
 
 	end_that_request_last(cmd->rq);
+	cmd_free(h,cmd,1);
 }
 
 /* 
@@ -1840,8 +1912,7 @@ static void do_cciss_intr(int irq, void 
 			 if (c->busaddr == a) {
 				removeQ(&h->cmpQ, c);
 				if (c->cmd_type == CMD_RWREQ) {
-					complete_command(c, 0);
-					cmd_free(h, c, 1);
+					complete_command(h, c, 0);
 				} else if (c->cmd_type == CMD_IOCTL_PEND) {
 					complete(c->waiting);
 				}
--- linux-2.5.44/drivers/block/cciss_cmd.h~retry_aborted	Tue Oct 22 13:22:26 2002
+++ linux-2.5.44-root/drivers/block/cciss_cmd.h	Tue Oct 22 13:22:26 2002
@@ -240,6 +240,7 @@ typedef struct _CommandList_struct {
   struct _CommandList_struct *next;
   struct request *	   rq;
   struct completion *waiting;
+  int	 retry_count;
 #ifdef CONFIG_CISS_SCSI_TAPE
   void * scsi_cmd;
 #endif

.
