Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271625AbRHUKD3>; Tue, 21 Aug 2001 06:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271627AbRHUKDT>; Tue, 21 Aug 2001 06:03:19 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:49677 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S271625AbRHUKDL>;
	Tue, 21 Aug 2001 06:03:11 -0400
Date: Tue, 21 Aug 2001 12:02:37 +0200
From: Jens Axboe <axboe@suse.de>
To: Peter Wong <wpeter@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, lse_tech@lists.sourceforge.net
Subject: Re: Performance gain of 40% using Jens Axboe's bounce buffer patch with IPS
Message-ID: <20010821120237.A731@suse.de>
In-Reply-To: <OFF37F5BF0.1CF87142-ON85256AAE.0077A7D2@raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFF37F5BF0.1CF87142-ON85256AAE.0077A7D2@raleigh.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20 2001, Peter Wong wrote:
> With these three changes and Jens' bounce buffer patch, we observed a
> significant performance gain for a database workload running on a 4-way
> machine. The total elapsed time for processing the queries was cut by 40%.

Excellent!

> Jens added that pci_map_page could be used depending on the way the device
> driver is written.

Yes, depending on whether you are mapping single entries or sg lists.

Your patch looks ok, almost.

> @@ -4559,6 +4562,9 @@
>           default:
>              break;
>           } /* end case */
> +
> +         pci_unmap_sg(ha->pcidev, scb->sg_list, scb->scsi_cmd->use_sg,
> +                     ips_command_direction[scb->scsi_cmd->cmnd[0]]);
> 
>           return ;
>        }

This is really nasty -- scb->sg_list is an IPS representation of the
scatter gather list, so you can't pass that back to the PCI DMA
interface. Here's a modified version of your patch that keeps the
original sg list, this is the patch I'll include.

--- /opt/kernel/linux-2.4.9/drivers/scsi/ips.c	Thu Aug 16 18:49:49 2001
+++ linux/drivers/scsi/ips.c	Tue Aug 21 11:54:28 2001
@@ -3743,6 +3743,8 @@
          int                 i;
 
          sg = SC->request_buffer;
+	 scb->org_sg_list = sg;
+	 (void) pci_map_sg(ha->pcidev, sg, SC->use_sg, ips_command_direction[scb->scsi_cmd->cmnd[0]]);
 
          if (SC->use_sg == 1) {
             if (sg[0].length > ha->max_xfer) {
@@ -3752,12 +3754,12 @@
                scb->data_len = sg[0].length;
 
             scb->dcdb.transfer_length = scb->data_len;
-            scb->data_busaddr = VIRT_TO_BUS(sg[0].address);
+            scb->data_busaddr = sg_dma_address(&sg[0]);
             scb->sg_len = 0;
          } else {
             /* Check for the first Element being bigger than MAX_XFER */
             if (sg[0].length > ha->max_xfer) {
-               scb->sg_list[0].address = VIRT_TO_BUS(sg[0].address);
+               scb->sg_list[0].address = sg_dma_address(&sg[0]);
                scb->sg_list[0].length = ha->max_xfer;
                scb->data_len = ha->max_xfer;
                scb->breakup = 0; 
@@ -3766,7 +3768,7 @@
 	         }
             else {
                for (i = 0; i < SC->use_sg; i++) {
-                  scb->sg_list[i].address = VIRT_TO_BUS(sg[i].address);
+                  scb->sg_list[i].address = sg_dma_address(&sg[i]);
                   scb->sg_list[i].length = sg[i].length;
             
                   if (scb->data_len + sg[i].length > ha->max_xfer) {
@@ -4441,11 +4443,11 @@
                if (sg[0].length - (bk_save * ha->max_xfer)) {
                   /* Further breakup required */
                   scb->data_len = ha->max_xfer;
-                  scb->data_busaddr = VIRT_TO_BUS(sg[0].address + (bk_save * ha->max_xfer));
+                  scb->data_busaddr = sg_dma_address(&sg[0] + (bk_save * ha->max_xfer));
                   scb->breakup = bk_save + 1;
                } else {
                   scb->data_len = sg[0].length - (bk_save * ha->max_xfer);
-                  scb->data_busaddr = VIRT_TO_BUS(sg[0].address + (bk_save * ha->max_xfer));
+                  scb->data_busaddr = sg_dma_address(&sg[0] + (bk_save * ha->max_xfer));
                }
 
                scb->dcdb.transfer_length = scb->data_len;
@@ -4462,7 +4464,7 @@
                /* pointed to by bk_save                                             */
                if (scb->sg_break) {
                   scb->sg_len = 1;
-        			   scb->sg_list[0].address = VIRT_TO_BUS(sg[bk_save].address+ha->max_xfer*scb->sg_break);
+        			   scb->sg_list[0].address = sg_dma_address(&sg[bk_save] + ha->max_xfer*scb->sg_break);
                   if (ha->max_xfer > sg[bk_save].length-ha->max_xfer * scb->sg_break) 
                      scb->sg_list[0].length = sg[bk_save].length-ha->max_xfer * scb->sg_break;
                   else 
@@ -4480,7 +4482,7 @@
                } else {
 			         /* ( sg_break == 0 ), so this is our first look at a new sg piece */
                   if (sg[bk_save].length > ha->max_xfer) {
-			            scb->sg_list[0].address = VIRT_TO_BUS(sg[bk_save].address);
+			            scb->sg_list[0].address = sg_dma_address(&sg[bk_save]);
 				         scb->sg_list[0].length = ha->max_xfer;
 				         scb->breakup = bk_save;
 				         scb->sg_break = 1;
@@ -4493,7 +4495,7 @@
       			      scb->sg_break = 0;
                      /*   We're only doing full units here */
 				         for (i = bk_save; i < scb->scsi_cmd->use_sg; i++) {
-					         scb->sg_list[i - bk_save].address = VIRT_TO_BUS(sg[i].address);
+					         scb->sg_list[i - bk_save].address = sg_dma_address(&sg[i]);
 				            scb->sg_list[i - bk_save].length = sg[i].length;
                         if (scb->data_len + sg[i].length > ha->max_xfer) {
 					            scb->breakup = i;  /* sneaky, if not more work, than breakup is 0 */
@@ -4560,6 +4562,7 @@
             break;
          } /* end case */
 
+	 pci_unmap_sg(ha->pcidev, scb->org_sg_list, scb->scsi_cmd->use_sg, ips_command_direction[scb->scsi_cmd->cmnd[0]]);
          return ;
       }
 #ifndef NO_IPS_CMDLINE
--- /opt/kernel/linux-2.4.9/drivers/scsi/ips.h	Fri Jul 20 06:08:13 2001
+++ linux/drivers/scsi/ips.h	Tue Aug 21 11:54:06 2001
@@ -419,7 +419,8 @@
     present : 0,                          \
     unchecked_isa_dma : 0,                \
     use_clustering : ENABLE_CLUSTERING,   \
-    use_new_eh_code : 1                   \
+    use_new_eh_code : 1,                  \
+    can_dma_32 : 1			  \
 }
 #endif
 
@@ -1026,6 +1027,7 @@
    u32               flags;
    u32               op_code;
    IPS_SG_LIST      *sg_list;
+   struct scatterlist *org_sg_list;
    Scsi_Cmnd        *scsi_cmd;
    struct ips_scb   *q_next;
    ips_scb_callback  callback;

-- 
Jens Axboe

