Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265887AbUJNOl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265887AbUJNOl3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 10:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265697AbUJNOix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 10:38:53 -0400
Received: from zcamail04.zca.compaq.com ([161.114.32.104]:33286 "EHLO
	zcamail04.zca.compaq.com") by vger.kernel.org with ESMTP
	id S265207AbUJNOgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 10:36:53 -0400
Date: Thu, 14 Oct 2004 09:36:26 -0500
From: mike.miller@hp.com
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [patch 1/2] cciss: SCSI API updates
Message-ID: <20041014143626.GB21960@beardog.cca.cpqcorp.net>
Reply-To: mikem@beardog.cca.cpqcorp.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 of 2
This patch updates our SCSI support to no longer use deprecated APIs. I've
also cleaned up the more controversial parts (read mistakes).
Please consider this for inclusion.

Thanks,
mikem

 cciss_scsi.c |   53 ++++++++++++++++++++++-------------------------------
 1 files changed, 22 insertions(+), 31 deletions(-)
-------------------------------------------------------------------------------
diff -burNp lx269-rc4.orig/drivers/block/cciss_scsi.c lx269-rc4/drivers/block/cciss_scsi.c
--- lx269-rc4.orig/drivers/block/cciss_scsi.c	2004-08-14 00:36:32.000000000 -0500
+++ lx269-rc4/drivers/block/cciss_scsi.c	2004-10-14 09:15:25.056956264 -0500
@@ -28,7 +28,9 @@
    through the array controller.  Note in particular, neither 
    physical nor logical disks are presented through the scsi layer. */
 
-#include "../scsi/scsi.h" 
+#include <scsi/scsi.h> 
+#include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_device.h>
 #include <scsi/scsi_host.h> 
 #include <asm/atomic.h>
 #include <linux/timer.h>
@@ -61,15 +63,8 @@ int cciss_scsi_proc_info(
 		int length, 	   /* length of data in buffer */
 		int func);	   /* 0 == read, 1 == write */
 
-int cciss_scsi_queue_command (Scsi_Cmnd *cmd, void (* done)(Scsi_Cmnd *));
-#if 0
-int cciss_scsi_abort(Scsi_Cmnd *cmd);
-#if defined SCSI_RESET_SYNCHRONOUS && defined SCSI_RESET_ASYNCHRONOUS
-int cciss_scsi_reset(Scsi_Cmnd *cmd, unsigned int reset_flags);
-#else
-int cciss_scsi_reset(Scsi_Cmnd *cmd);
-#endif
-#endif
+int cciss_scsi_queue_command (struct scsi_cmnd *cmd, 
+		void (* done)(struct scsi_cmnd *));
 
 static struct cciss_scsi_hba_t ccissscsi[MAX_CTLR] = {
 	{ .name = "cciss0", .ndevices = 0 },
@@ -82,7 +77,7 @@ static struct cciss_scsi_hba_t ccissscsi
 	{ .name = "cciss7", .ndevices = 0 },
 };
 
-static Scsi_Host_Template cciss_driver_template = {
+static struct scsi_host_template cciss_driver_template = {
 	.module			= THIS_MODULE,
 	.name			= "cciss",
 	.proc_name		= "cciss",
@@ -552,7 +547,7 @@ cciss_scsi_setup(int cntl_num)
 static void
 complete_scsi_command( CommandList_struct *cp, int timeout, __u32 tag)
 {
-	Scsi_Cmnd *cmd;
+	struct scsi_cmnd *cmd;
 	ctlr_info_t *ctlr;
 	u64bit addr64;
 	ErrorInfo_struct *ei;
@@ -565,7 +560,7 @@ complete_scsi_command( CommandList_struc
 		return;
 	}
 
-	cmd = (Scsi_Cmnd *) cp->scsi_cmd;	
+	cmd = (struct scsi_cmnd *) cp->scsi_cmd;	
 	ctlr = hba[cp->ctlr];
 
 	/* undo the DMA mappings */
@@ -573,14 +568,14 @@ complete_scsi_command( CommandList_struc
 	if (cmd->use_sg) {
 		pci_unmap_sg(ctlr->pdev,
 			cmd->buffer, cmd->use_sg,
-				scsi_to_pci_dma_dir(cmd->sc_data_direction)); 
+				cmd->sc_data_direction); 
 	}
 	else if (cmd->request_bufflen) {
 		addr64.val32.lower = cp->SG[0].Addr.lower;
                 addr64.val32.upper = cp->SG[0].Addr.upper;
                 pci_unmap_single(ctlr->pdev, (dma_addr_t) addr64.val,
                 	cmd->request_bufflen, 
-				scsi_to_pci_dma_dir(cmd->sc_data_direction));
+				cmd->sc_data_direction);
 	}
 
 	cmd->result = (DID_OK << 16); 		/* host byte */
@@ -783,9 +778,8 @@ cciss_scsi_do_simple_cmd(ctlr_info_t *c,
 	cp->Request.Type.Direction = direction;
 
 	/* Fill in the SG list and do dma mapping */
-	cciss_map_one(c->pdev, cp, 
-			(unsigned char *) buf, bufsize,
-			scsi_to_pci_dma_dir(SCSI_DATA_READ)); 
+	cciss_map_one(c->pdev, cp, (unsigned char *) buf,
+			bufsize, DMA_FROM_DEVICE); 
 
 	cp->waiting = &wait;
 
@@ -799,9 +793,7 @@ cciss_scsi_do_simple_cmd(ctlr_info_t *c,
 	wait_for_completion(&wait);
 
 	/* undo the dma mapping */
-	cciss_unmap_one(c->pdev, cp, bufsize,
-				scsi_to_pci_dma_dir(SCSI_DATA_READ)); 
-
+	cciss_unmap_one(c->pdev, cp, bufsize, DMA_FROM_DEVICE);
 	return(0);
 }
 
@@ -1180,14 +1172,14 @@ cciss_scsi_info(struct Scsi_Host *sa)
 }
 
 
-/* cciss_scatter_gather takes a Scsi_Cmnd, (cmd), and does the pci 
+/* cciss_scatter_gather takes a struct scsi_cmnd, (cmd), and does the pci 
    dma mapping  and fills in the scatter gather entries of the 
    cciss command, cp. */
 
 static void
 cciss_scatter_gather(struct pci_dev *pdev, 
 		CommandList_struct *cp,	
-		Scsi_Cmnd *cmd)
+		struct scsi_cmnd *cmd)
 {
 	unsigned int use_sg, nsegs=0, len;
 	struct scatterlist *scatter = (struct scatterlist *) cmd->buffer;
@@ -1200,7 +1192,7 @@ cciss_scatter_gather(struct pci_dev *pde
 			addr64 = (__u64) pci_map_single(pdev, 
 				cmd->request_buffer, 
 				cmd->request_bufflen, 
-				scsi_to_pci_dma_dir(cmd->sc_data_direction)); 
+				cmd->sc_data_direction); 
 	
 			cp->SG[0].Addr.lower = 
 			  (__u32) (addr64 & (__u64) 0x00000000FFFFFFFF);
@@ -1213,7 +1205,7 @@ cciss_scatter_gather(struct pci_dev *pde
 	else if (cmd->use_sg <= MAXSGENTRIES) {	/* not too many addrs? */
 
 		use_sg = pci_map_sg(pdev, cmd->buffer, cmd->use_sg, 
-			scsi_to_pci_dma_dir(cmd->sc_data_direction));
+			cmd->sc_data_direction);
 
 		for (nsegs=0; nsegs < use_sg; nsegs++) {
 			addr64 = (__u64) sg_dma_address(&scatter[nsegs]);
@@ -1234,7 +1226,7 @@ cciss_scatter_gather(struct pci_dev *pde
 
 
 int 
-cciss_scsi_queue_command (Scsi_Cmnd *cmd, void (* done)(Scsi_Cmnd *))
+cciss_scsi_queue_command (struct scsi_cmnd *cmd, void (* done)(struct scsi_cmnd *))
 {
 	ctlr_info_t **c;
 	int ctlr, rc;
@@ -1302,11 +1294,10 @@ cciss_scsi_queue_command (Scsi_Cmnd *cmd
 	cp->Request.Type.Attribute = ATTR_SIMPLE;
 	switch(cmd->sc_data_direction)
 	{
-	  case SCSI_DATA_WRITE: cp->Request.Type.Direction = XFER_WRITE; break;
-	  case SCSI_DATA_READ: cp->Request.Type.Direction = XFER_READ; break;
-	  case SCSI_DATA_NONE: cp->Request.Type.Direction = XFER_NONE; break;
-
-	  case SCSI_DATA_UNKNOWN:
+	  case DMA_TO_DEVICE: cp->Request.Type.Direction = XFER_WRITE; break;
+	  case DMA_FROM_DEVICE: cp->Request.Type.Direction = XFER_READ; break;
+	  case DMA_NONE: cp->Request.Type.Direction = XFER_NONE; break;
+	  case DMA_BIDIRECTIONAL:
 		// This can happen if a buggy application does a scsi passthru
 		// and sets both inlen and outlen to non-zero. ( see
 		// ../scsi/scsi_ioctl.c:scsi_ioctl_send_command() )
