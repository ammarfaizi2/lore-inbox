Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284264AbSBRUUb>; Mon, 18 Feb 2002 15:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285417AbSBRUUW>; Mon, 18 Feb 2002 15:20:22 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:54517 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S284264AbSBRUUI>; Mon, 18 Feb 2002 15:20:08 -0500
Subject: [PATCH] IPS Driver for Jens Axboe's Bounce Buffer Patch
To: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF7EB95438.1D0691B6-ON85256B64.005D62AB@raleigh.ibm.com>
From: "Peter Wong" <wpeter@us.ibm.com>
Date: Mon, 18 Feb 2002 14:20:03 -0600
X-MIMETrack: Serialize by Router on D04NM203/04/M/IBM(Release 5.0.9 |November 16, 2001) at
 02/18/2002 03:20:06 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens,

Your note on Nov. 16, 2001:

========================================================================
Hi,

Version #18 of the patch, the prepare-for-inclusion version. Changes:

- Drop IPS and megaraid changes, too problematic. If anyone has the
  hardware to really test this and do it properly (aimed at IPS), please
  do so and send it on. (me)
========================================================================

     Mike Anderson and Janet Morgan of IBM LTC fixed a few things in the
IPS driver. I applied your block-highmem-all-17 (for 2.4.13-pre4) to
2.4.16 and added their changes on top of that. I ran a very heavy database
workload for a few hours and did not have any problems. I think the driver
is very stable now. Thus, I would like to ask you to include the fixed IPS
driver back into your bounce buffer patch. The changes are as follows:

     (1) In ips_detect, Mike Anderson added

           /*
            * Set pci_dev and dma_mask
            */
           pci_set_dma_mask(dev[i], (u64) 0xffffffff);

           scsi_set_pci_device(sh, dev[i]);

         after

           /* found a controller */
           sh = scsi_register(SHT, sizeof(ips_ha_t));

     (2) Janet Morgan modified one line in ips_next:

            scb->data_busaddr = VIRT_TO_BUS(sg[0].address);

           by

            scb->data_busaddr = sg_dma_address(&sg[0]);

         I found that this change was on block-highmem-all-15 for 2.4.10,
         and in fact since 2.4.6. However, with a new IPS driver available
for
         2.4.11, the ported code missed this change.

The patch for the IPS is as follows:
========================================================================
--- linux-2.4.16/drivers/scsi/ips.c Mon Feb 18 12:12:17 2002
+++ linux-2.4.16-fixed/drivers/scsi/ips.c Mon Feb 18 12:06:55 2002
@@ -846,6 +846,13 @@
          /* found a controller */
          sh = scsi_register(SHT, sizeof(ips_ha_t));

+      /*
+       * Set pci_dev and dma_mask
+       */
+      pci_set_dma_mask(dev[i], (u64) 0xffffffff);
+
+      scsi_set_pci_device(sh, dev[i]);
+
          if (sh == NULL) {
             printk(KERN_WARNING "(%s%d) Unable to register controller with SCSI subsystem - skipping controller\n",
                    ips_name, ips_next_controller);
@@ -3568,7 +3575,7 @@
    Scsi_Cmnd            *p;
    Scsi_Cmnd            *q;
    ips_copp_wait_item_t *item;
-   int                   ret;
+   int                   ret, sg_entries = 0;
    int                   intr_status;
    unsigned long         cpu_flags;
    unsigned long         cpu_flags2;
@@ -3767,6 +3774,8 @@
          int                 i;

          sg = SC->request_buffer;
+      scb->org_sg_list = sg;
+     sg_entries = pci_map_sg(ha->pcidev, sg, SC->use_sg, ips_command_direction[scb->scsi_cmd->cmnd[0]]);

          if (SC->use_sg == 1) {
             if (sg[0].length > ha->max_xfer) {
@@ -3776,12 +3785,12 @@
                scb->data_len = sg[0].length;

             scb->dcdb.transfer_length = scb->data_len;
-            scb->data_busaddr = VIRT_TO_BUS(sg[0].address);
+            scb->data_busaddr = sg_dma_address(&sg[0]);
             scb->sg_len = 0;
          } else {
             /* Check for the first Element being bigger than MAX_XFER */
             if (sg[0].length > ha->max_xfer) {
-               scb->sg_list[0].address = cpu_to_le32(VIRT_TO_BUS(sg[0].address));
+               scb->sg_list[0].address = cpu_to_le32(sg_dma_address(&sg[0]));
                scb->sg_list[0].length = ha->max_xfer;
                scb->data_len = ha->max_xfer;
                scb->breakup = 0;
@@ -3790,7 +3799,7 @@
             }
             else {
                for (i = 0; i < SC->use_sg; i++) {
-                  scb->sg_list[i].address = cpu_to_le32(VIRT_TO_BUS(sg[i].address));
+                  scb->sg_list[i].address = cpu_to_le32(sg_dma_address(&sg[i]));
                   scb->sg_list[i].length = cpu_to_le32(sg[i].length);

                   if (scb->data_len + sg[i].length > ha->max_xfer) {
@@ -3805,7 +3814,7 @@
                }

                if (!scb->breakup)
-                  scb->sg_len = SC->use_sg;
+                  scb->sg_len = sg_entries;
                else
                   scb->sg_len = scb->breakup;
             }
@@ -4465,11 +4474,11 @@
                if (sg[0].length - (bk_save * ha->max_xfer) > ha->max_xfer) {
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
@@ -4486,7 +4495,7 @@
                /* pointed to by bk_save                                             */
                if (scb->sg_break) {
                   scb->sg_len = 1;
-                          scb->sg_list[0].address = VIRT_TO_BUS(sg[bk_save].address+ha->max_xfer*scb->sg_break);
+                          scb->sg_list[0].address = sg_dma_address(&sg[bk_save] + ha->max_xfer*scb->sg_break);
                   if (ha->max_xfer > sg[bk_save].length-ha->max_xfer * scb->sg_break)
                      scb->sg_list[0].length = sg[bk_save].length-ha->max_xfer * scb->sg_break;
                   else
@@ -4504,7 +4513,7 @@
                } else {
                           /* ( sg_break == 0 ), so this is our first look at a new sg piece */
                   if (sg[bk_save].length > ha->max_xfer) {
-                             scb->sg_list[0].address = cpu_to_le32(VIRT_TO_BUS(sg[bk_save].address));
+                             scb->sg_list[0].address = cpu_to_le32(sg_dma_address(&sg[bk_save]));
                                 scb->sg_list[0].length = ha->max_xfer;
                                 scb->breakup = bk_save;
                                 scb->sg_break = 1;
@@ -4517,7 +4526,7 @@
                              scb->sg_break = 0;
                      /*   We're only doing full units here */
                                 for (i = bk_save; i < scb->scsi_cmd->use_sg; i++) {
-                                      scb->sg_list[i - bk_save].address = cpu_to_le32(VIRT_TO_BUS(sg[i].address));
+                                      scb->sg_list[i - bk_save].address = cpu_to_le32(sg_dma_address(&sg[i]));
                                    scb->sg_list[i - bk_save].length = cpu_to_le32(sg[i].length);
                         if (scb->data_len + sg[i].length > ha->max_xfer) {
                                          scb->breakup = i;  /* sneaky, if not more work, than breakup is 0 */
@@ -4585,6 +4594,7 @@
             break;
          } /* end case */

+     pci_unmap_sg(ha->pcidev, scb->org_sg_list, scb->sg_len, ips_command_direction[scb->scsi_cmd->cmnd[0]]);
          return ;
       }
 #ifndef NO_IPS_CMDLINE

Thanks,
Peter

Wai Yee Peter Wong
IBM Linux Technology Center, Performance Analysis
email: wpeter@us.ibm.com

