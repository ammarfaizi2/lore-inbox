Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265171AbSJRPtz>; Fri, 18 Oct 2002 11:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265188AbSJRPtz>; Fri, 18 Oct 2002 11:49:55 -0400
Received: from zmamail04.zma.compaq.com ([161.114.64.104]:43271 "EHLO
	zmamail04.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S265171AbSJRPtu>; Fri, 18 Oct 2002 11:49:50 -0400
Date: Fri, 18 Oct 2002 09:52:05 -0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: [PATCH] 2.5.43 cciss, retry 3rd-party aborted commands
Message-ID: <20021018095205.B856@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the cciss driver retry commands which failed
to an unsolicited abort (3rd party abort) up to 3 times.
Needed for certain configurations with multiple hosts attached
to a certain multiport storage box.  Applies to 2.5.43 after my
previous 10 cciss patches.

-- steve

diff -urN linux-2.5.43-j/drivers/block/cciss.c linux-2.5.43-k/drivers/block/cciss.c
--- linux-2.5.43-j/drivers/block/cciss.c	Thu Oct 17 13:28:23 2002
+++ linux-2.5.43-k/drivers/block/cciss.c	Thu Oct 17 13:35:26 2002
@@ -46,12 +46,12 @@
 #include <linux/completion.h>
 
 #define CCISS_DRIVER_VERSION(maj,min,submin) ((maj<<16)|(min<<8)|(submin))
-#define DRIVER_NAME "Compaq CISS Driver (v 2.5.1)"
-#define DRIVER_VERSION CCISS_DRIVER_VERSION(2,5,1)
+#define DRIVER_NAME "Compaq CISS Driver (v 2.5.2)"
+#define DRIVER_VERSION CCISS_DRIVER_VERSION(2,5,2)
 
 /* Embedded module documentation macros - see modules.h */
 MODULE_AUTHOR("Charles M. White III - Compaq Computer Corporation");
-MODULE_DESCRIPTION("Driver for Compaq Smart Array Controller 5xxx v. 2.5.1");
+MODULE_DESCRIPTION("Driver for Compaq Smart Array Controller 5xxx v. 2.5.2");
 MODULE_LICENSE("GPL");
 
 #include "cciss_cmd.h"
@@ -88,6 +88,9 @@
 /* How long to wait (in millesconds) for board to go into simple mode */
 #define MAX_CONFIG_WAIT 1000 
 
+/*define how many times we will try a command because of bus resets */
+#define MAX_CMD_RETRIES 3
+
 #define READ_AHEAD 	 128
 #define NR_CMDS		 384 /* #commands that can be outstanding */
 #define MAX_CTLR 8
@@ -955,6 +958,7 @@
 		c->SG[0].Len = size;
 		c->SG[0].Ext = 0;  // we are not chaining
 	}
+resend_cmd2:
 	c->waiting = &wait;
 	
 	/* Put the request on the tail of the queue and send it */
@@ -966,10 +970,6 @@
 	
 	wait_for_completion(&wait);
 
-	/* unlock the buffers from DMA */
-        pci_unmap_single( h->pdev, (dma_addr_t) buff_dma_handle.val,
-                	size, PCI_DMA_BIDIRECTIONAL);
-
 	if(c->err_info->CommandStatus != 0) 
 	{ /* an error has occurred */ 
 		switch(c->err_info->CommandStatus)
@@ -1023,6 +1023,16 @@
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
 
 
@@ -1034,6 +1044,9 @@
 				return_status = IO_ERROR;
 		}
 	}	
+	/* unlock the buffers from DMA */
+	pci_unmap_single( h->pdev, (dma_addr_t) buff_dma_handle.val,
+			size, PCI_DMA_BIDIRECTIONAL);
 	cmd_free(h, c, 0);
         return(return_status);
 
@@ -1357,6 +1370,7 @@
 	unsigned long complete;
 	ctlr_info_t *info_p= hba[ctlr];
 	u64bit buff_dma_handle;
+	int status = IO_OK;
 
 	c = cmd_alloc(info_p, 1);
 	if (c == NULL)
@@ -1470,6 +1484,7 @@
 		c->SG[0].Len = size;
 		c->SG[0].Ext = 0;  // we are not chaining
 	}
+resend_cmd1:
 	/*
          * Disable interrupt
          */
@@ -1502,9 +1517,6 @@
 	printk(KERN_DEBUG "cciss: command completed\n");
 #endif /* CCISS_DEBUG */
 
-	/* unlock the data buffer from DMA */
-	pci_unmap_single(info_p->pdev, (dma_addr_t) buff_dma_handle.val,
-                                size, PCI_DMA_BIDIRECTIONAL);
 	if (complete != 1) {
 		if ( (complete & CISS_ERROR_BIT)
 		     && (complete & ~CISS_ERROR_BIT) == c->busaddr)
@@ -1524,6 +1536,27 @@
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
@@ -1533,27 +1566,31 @@
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
@@ -1637,27 +1674,35 @@
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
@@ -1731,8 +1776,20 @@
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
@@ -1747,7 +1804,21 @@
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
@@ -1755,6 +1826,7 @@
 #endif /* CCISS_DEBUG */ 
 
 	end_that_request_last(cmd->rq);
+	cmd_free(h,cmd,1);
 }
 
 /* 
@@ -1910,8 +1982,7 @@
 			 if (c->busaddr == a) {
 				removeQ(&h->cmpQ, c);
 				if (c->cmd_type == CMD_RWREQ) {
-					complete_command(c, 0);
-					cmd_free(h, c, 1);
+					complete_command(h, c, 0);
 				} else if (c->cmd_type == CMD_IOCTL_PEND) {
 					complete(c->waiting);
 				}
diff -urN linux-2.5.43-j/drivers/block/cciss_cmd.h linux-2.5.43-k/drivers/block/cciss_cmd.h
--- linux-2.5.43-j/drivers/block/cciss_cmd.h	Tue Oct 15 21:27:19 2002
+++ linux-2.5.43-k/drivers/block/cciss_cmd.h	Thu Oct 17 13:35:26 2002
@@ -240,6 +240,7 @@
   struct _CommandList_struct *next;
   struct request *	   rq;
   struct completion *waiting;
+  int	 retry_count;
 #ifdef CONFIG_CISS_SCSI_TAPE
   void * scsi_cmd;
 #endif
