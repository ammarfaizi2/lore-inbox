Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269639AbRHTWHL>; Mon, 20 Aug 2001 18:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269641AbRHTWHB>; Mon, 20 Aug 2001 18:07:01 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:8170 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S269639AbRHTWG6>;
	Mon, 20 Aug 2001 18:06:58 -0400
Importance: Normal
Subject: Performance gain of 40% using Jens Axboe's bounce buffer patch with IPS
To: linux-kernel@vger.kernel.org, lse_tech@lists.sourceforge.net
Cc: Jens Axboe <axboe@suse.de>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFF37F5BF0.1CF87142-ON85256AAE.0077A7D2@raleigh.ibm.com>
From: "Peter Wong" <wpeter@us.ibm.com>
Date: Mon, 20 Aug 2001 17:06:25 -0500
X-MIMETrack: Serialize by Router on D04NM203/04/M/IBM(Release 5.0.6 |December 14, 2000) at
 08/20/2001 06:06:43 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To make use of Jens Axboe's bounce buffer patch, the ServeRAID device
driver
(based on the 2.4.5 kernel) was modified in the following way:

(1) Add "can_dma_32:1" in ips.h to indicate its capability of 32-bit DMA;

(2) Use pci_map_sg to get the dma address of the I/O operations. The
    existing 2.4.5 code for pci_map_sg only performs a simple direction
    check. The new code added by Jens computes the dma address of the I/O
    operations;

(3) For the mapping of the scatter-gather buffers from the SCSI command
    to the ServeRAID command, use sg_dma_address to get the dma address
    instead of using VIRT_TO_BUS.

With these three changes and Jens' bounce buffer patch, we observed a
significant performance gain for a database workload running on a 4-way
machine. The total elapsed time for processing the queries was cut by 40%.

Jens added that pci_map_page could be used depending on the way the device
driver is written.

The device drivers under drivers/block were modified differently by Jens.
You can examine the changes for cciss and cpqarray for modifying your
own driver.

Jens's bounce buffer patch for 2.4.5 is block-highmem-all-4.gz at
http://www.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.5.


The IPS patch is attached here:

-----------------------------------------------------------------------------------------
--- linux/drivers/scsi/ips.c  Sun Aug 19 08:09:14 2001
+++ linux_ips/drivers/scsi/ips.c   Sun Aug 19 08:11:33 2001
@@ -3741,8 +3741,11 @@
       if (SC->use_sg) {
          struct scatterlist *sg;
          int                 i;
+         int                 tmp;

          sg = SC->request_buffer;
+         tmp = pci_map_sg(ha->pcidev, sg, SC->use_sg,
+                     ips_command_direction[scb->scsi_cmd->cmnd[0]]);

          if (SC->use_sg == 1) {
             if (sg[0].length > ha->max_xfer) {
@@ -3752,12 +3755,12 @@
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
@@ -3766,7 +3769,7 @@
              }
             else {
                for (i = 0; i < SC->use_sg; i++) {
-                  scb->sg_list[i].address = VIRT_TO_BUS(sg[i].address);
+                  scb->sg_list[i].address = sg_dma_address(&sg[i]);
                   scb->sg_list[i].length = sg[i].length;

                   if (scb->data_len + sg[i].length > ha->max_xfer) {
@@ -4441,11 +4444,11 @@
                if (sg[0].length - (bk_save * ha->max_xfer)) {
                   /* Further breakup required */
                   scb->data_len = ha->max_xfer;
-                  scb->data_busaddr = VIRT_TO_BUS(sg[0].address + (bk_save * ha->max_xfer));
+                  scb->data_busaddr = sg_dma_address(&sg[0]) + (bk_save * ha->max_xfer);
                   scb->breakup = bk_save + 1;
                } else {
                   scb->data_len = sg[0].length - (bk_save * ha->max_xfer);
-                  scb->data_busaddr = VIRT_TO_BUS(sg[0].address + (bk_save * ha->max_xfer));
+                  scb->data_busaddr = sg_dma_address(&sg[0]) + (bk_save * ha->max_xfer);
                }

                scb->dcdb.transfer_length = scb->data_len;
@@ -4462,7 +4465,7 @@
                /* pointed to by bk_save                                             */
                if (scb->sg_break) {
                   scb->sg_len = 1;
-                      scb->sg_list[0].address = VIRT_TO_BUS(sg[bk_save].address+ha->max_xfer*scb->sg_break);
+                  scb->sg_list[0].address = sg_dma_address(&sg[bk_save])+ha->max_xfer*scb->sg_break;
                   if (ha->max_xfer > sg[bk_save].length-ha->max_xfer * scb->sg_break)
                      scb->sg_list[0].length = sg[bk_save].length-ha->max_xfer * scb->sg_break;
                   else
@@ -4480,7 +4483,7 @@
                } else {
                        /* ( sg_break == 0 ), so this is our first look at a new sg piece */
                   if (sg[bk_save].length > ha->max_xfer) {
-                          scb->sg_list[0].address = VIRT_TO_BUS(sg[bk_save].address);
+                          scb->sg_list[0].address = sg_dma_address(&sg[bk_save]);
                             scb->sg_list[0].length = ha->max_xfer;
                             scb->breakup = bk_save;
                             scb->sg_break = 1;
@@ -4493,7 +4496,7 @@
                          scb->sg_break = 0;
                      /*   We're only doing full units here */
                             for (i = bk_save; i < scb->scsi_cmd->use_sg; i++) {
-                                 scb->sg_list[i - bk_save].address = VIRT_TO_BUS(sg[i].address);
+                                 scb->sg_list[i - bk_save].address = sg_dma_address(&sg[i]);
                                scb->sg_list[i - bk_save].length = sg[i].length;
                         if (scb->data_len + sg[i].length > ha->max_xfer) {
                                     scb->breakup = i;  /* sneaky, if not more work, than breakup is 0 */
@@ -4559,6 +4562,9 @@
          default:
             break;
          } /* end case */
+
+         pci_unmap_sg(ha->pcidev, scb->sg_list, scb->scsi_cmd->use_sg,
+                     ips_command_direction[scb->scsi_cmd->cmnd[0]]);

          return ;
       }
--- linux/drivers/scsi/ips.h  Sun Aug 19 08:09:19 2001
+++ linux_ips/drivers/scsi/ips.h   Sun Aug 19 08:11:47 2001
@@ -419,7 +419,8 @@
     present : 0,                          \
     unchecked_isa_dma : 0,                \
     use_clustering : ENABLE_CLUSTERING,   \
-    use_new_eh_code : 1                   \
+    use_new_eh_code : 1,                  \
+    can_dma_32 : 1                        \
 }
 #endif
-----------------------------------------------------------------------------------------

Wai Yee Peter Wong
IBM Linux Technology Center, Performance Analysis
email: wpeter@us.ibm.com
Office: (512) 838-9272, T/L 678-9272; Fax: (512) 838-4663

