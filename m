Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313711AbSDPPFv>; Tue, 16 Apr 2002 11:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313712AbSDPPFv>; Tue, 16 Apr 2002 11:05:51 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:17818 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S313711AbSDPPFs>;
	Tue, 16 Apr 2002 11:05:48 -0400
Message-ID: <3CBC3DB5.7020709@us.ibm.com>
Date: Tue, 16 Apr 2002 08:05:25 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] fix ips driver compile problems
Content-Type: multipart/mixed;
 boundary="------------000504030501090608070402"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000504030501090608070402
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus,
   This patch has been floating inside IBM for a bit, but it appears 
that no one passed it back up to you, yet.  I don't know who wrote it, 
but it applies to 2.5.8 and the ServeRAID driver works just fine with it 
applied.  Without it, the driver fails to compile.
-- 
Dave Hansen
haveblue@us.ibm.com

--------------000504030501090608070402
Content-Type: text/plain;
 name="ips-am-2.5.6.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ips-am-2.5.6.patch"

diff -u --new-file --recursive --exclude-from /home/andmike/views/dontdiff linux-256/drivers/scsi/ips.c linux-256-ips/drivers/scsi/ips.c
--- linux-256/drivers/scsi/ips.c	Mon Mar 18 17:31:49 2002
+++ linux-256-ips/drivers/scsi/ips.c	Thu Mar 21 00:06:47 2002
@@ -140,7 +140,6 @@
  * ioctlsize            - Initial size of the IOCTL buffer
  */
  
-#error Please convert me to Documentation/DMA-mapping.txt
 
 #include <asm/io.h>
 #include <asm/byteorder.h>
@@ -848,6 +848,13 @@
          /* found a controller */
          sh = scsi_register(SHT, sizeof(ips_ha_t));
 
+         /*
+          * Set pci_dev and dma_mask
+          */
+         pci_set_dma_mask(dev[i], (u64) 0xffffffff);
+   
+         scsi_set_pci_device(sh, dev[i]);
+
          if (sh == NULL) {
             printk(KERN_WARNING "(%s%d) Unable to register controller with SCSI subsystem - skipping controller\n",
                    ips_name, ips_next_controller);
@@ -1178,6 +1185,8 @@
       sh = ips_sh[i];
 
       if (!ha->active) {
+         printk(KERN_WARNING "(%s%d) controller not active\n",
+                ips_name, i);
          scsi_unregister(sh);
          ips_ha[i] = NULL;
          ips_sh[i] = NULL;
@@ -2833,7 +2842,7 @@
 
    /* FIX stuff that might be wrong */
    scb->sg_list = sg_list;
-   scb->scb_busaddr = VIRT_TO_BUS(scb);
+   scb->scb_busaddr = virt_to_phys(scb);
    scb->bus = scb->scsi_cmd->channel;
    scb->target_id = scb->scsi_cmd->target;
    scb->lun = scb->scsi_cmd->lun;
@@ -2852,13 +2861,13 @@
       return (0);
 
    if (pt->CmdBSize) {
-      scb->data_busaddr = VIRT_TO_BUS(scb->scsi_cmd->request_buffer + sizeof(ips_passthru_t));
+      scb->data_busaddr = virt_to_phys(scb->scsi_cmd->request_buffer + sizeof(ips_passthru_t));
    } else {
       scb->data_busaddr = 0L;
    }
 
    if (scb->cmd.dcdb.op_code == IPS_CMD_DCDB)
-      scb->cmd.dcdb.dcdb_address = cpu_to_le32(VIRT_TO_BUS(&scb->dcdb));
+      scb->cmd.dcdb.dcdb_address = cpu_to_le32(virt_to_phys(&scb->dcdb));
 
    if (pt->CmdBSize) {
       if (scb->cmd.dcdb.op_code == IPS_CMD_DCDB)
@@ -2916,7 +2925,7 @@
 
    /* FIX stuff that might be wrong */
    scb->sg_list = sg_list;
-   scb->scb_busaddr = VIRT_TO_BUS(scb);
+   scb->scb_busaddr = virt_to_phys(scb);
    scb->bus = scb->scsi_cmd->channel;
    scb->target_id = scb->scsi_cmd->target;
    scb->lun = scb->scsi_cmd->lun;
@@ -2959,7 +2968,7 @@
 
       }
 
-      scb->data_busaddr = VIRT_TO_BUS(ha->ioctl_data);
+      scb->data_busaddr = virt_to_phys(ha->ioctl_data);
 
       /* Attempt to copy in the data */
       user_area = *((char **) &scb->scsi_cmd->cmnd[4]);
@@ -2978,7 +2987,7 @@
    }
 
    if (scb->cmd.dcdb.op_code == IPS_CMD_DCDB)
-      scb->cmd.dcdb.dcdb_address = cpu_to_le32(VIRT_TO_BUS(&scb->dcdb));
+      scb->cmd.dcdb.dcdb_address = cpu_to_le32(virt_to_phys(&scb->dcdb));
 
    if (pt->CmdBSize) {
       if (scb->cmd.dcdb.op_code == IPS_CMD_DCDB)
@@ -3393,7 +3402,7 @@
       scb->cmd.flashfw.type = 1;
       scb->cmd.flashfw.direction = 0;
       scb->cmd.flashfw.count = cpu_to_le32(0x800);
-      scb->cmd.flashfw.buffer_addr = cpu_to_le32(VIRT_TO_BUS(buffer));
+      scb->cmd.flashfw.buffer_addr = cpu_to_le32(virt_to_phys(buffer));
       scb->cmd.flashfw.total_packets = 1;
       scb->cmd.flashfw.packet_num = 0;
 
@@ -3569,7 +3578,7 @@
    Scsi_Cmnd            *p;
    Scsi_Cmnd            *q;
    ips_copp_wait_item_t *item;
-   int                   ret;
+   int                   ret, sg_entries = 0;
    int                   intr_status;
    unsigned long         cpu_flags;
    unsigned long         cpu_flags2;
@@ -3771,6 +3780,7 @@
          int                 i;
 
          sg = SC->request_buffer;
+	sg_entries = pci_map_sg(ha->pcidev, sg, SC->use_sg, scsi_to_pci_dma_dir(SC->sc_data_direction));
 
          if (SC->use_sg == 1) {
             if (sg[0].length > ha->max_xfer) {
@@ -3780,12 +3790,12 @@
                scb->data_len = sg[0].length;
 
             scb->dcdb.transfer_length = scb->data_len;
-            scb->data_busaddr = VIRT_TO_BUS(sg[0].address);
+	    scb->data_busaddr = sg_dma_address(&sg[0]);
             scb->sg_len = 0;
          } else {
             /* Check for the first Element being bigger than MAX_XFER */
             if (sg[0].length > ha->max_xfer) {
-               scb->sg_list[0].address = cpu_to_le32(VIRT_TO_BUS(sg[0].address));
+               scb->sg_list[0].address = cpu_to_le32(sg_dma_address(&sg[0]));
                scb->sg_list[0].length = ha->max_xfer;
                scb->data_len = ha->max_xfer;
                scb->breakup = 0; 
@@ -3794,7 +3804,7 @@
             }
             else {
                for (i = 0; i < SC->use_sg; i++) {
-                  scb->sg_list[i].address = cpu_to_le32(VIRT_TO_BUS(sg[i].address));
+                  scb->sg_list[i].address = cpu_to_le32(sg_dma_address(&sg[i]));
                   scb->sg_list[i].length = cpu_to_le32(sg[i].length);
             
                   if (scb->data_len + sg[i].length > ha->max_xfer) {
@@ -3809,13 +3819,13 @@
                }
 
                if (!scb->breakup)
-                  scb->sg_len = SC->use_sg;
+                  scb->sg_len = sg_entries;
                else
                   scb->sg_len = scb->breakup;
             }
 
             scb->dcdb.transfer_length = scb->data_len;
-            scb->data_busaddr = VIRT_TO_BUS(scb->sg_list);
+            scb->data_busaddr = virt_to_phys(scb->sg_list);
          }
       } else {
          if (SC->request_bufflen) {
@@ -3830,7 +3840,7 @@
             }
 
             scb->dcdb.transfer_length = scb->data_len;
-            scb->data_busaddr = VIRT_TO_BUS(SC->request_buffer);
+            scb->data_busaddr = virt_to_phys(SC->request_buffer);
             scb->sg_len = 0;
          } else {
             scb->data_busaddr = 0L;
@@ -4469,11 +4479,11 @@
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
@@ -4490,7 +4500,7 @@
                /* pointed to by bk_save                                             */
                if (scb->sg_break) {
                   scb->sg_len = 1;
-        			   scb->sg_list[0].address = VIRT_TO_BUS(sg[bk_save].address+ha->max_xfer*scb->sg_break);
+        			   scb->sg_list[0].address = sg_dma_address(&sg[bk_save] + ha->max_xfer*scb->sg_break);
                   if (ha->max_xfer > sg[bk_save].length-ha->max_xfer * scb->sg_break) 
                      scb->sg_list[0].length = sg[bk_save].length-ha->max_xfer * scb->sg_break;
                   else 
@@ -4508,7 +4518,7 @@
                } else {
 			         /* ( sg_break == 0 ), so this is our first look at a new sg piece */
                   if (sg[bk_save].length > ha->max_xfer) {
-			            scb->sg_list[0].address = cpu_to_le32(VIRT_TO_BUS(sg[bk_save].address));
+			            scb->sg_list[0].address = cpu_to_le32(sg_dma_address(&sg[bk_save]));
 				         scb->sg_list[0].length = ha->max_xfer;
 				         scb->breakup = bk_save;
 				         scb->sg_break = 1;
@@ -4521,7 +4531,7 @@
       			      scb->sg_break = 0;
                      /*   We're only doing full units here */
 				         for (i = bk_save; i < scb->scsi_cmd->use_sg; i++) {
-					         scb->sg_list[i - bk_save].address = cpu_to_le32(VIRT_TO_BUS(sg[i].address));
+					         scb->sg_list[i - bk_save].address = cpu_to_le32(sg_dma_address(&sg[i]));
 				            scb->sg_list[i - bk_save].length = cpu_to_le32(sg[i].length);
                         if (scb->data_len + sg[i].length > ha->max_xfer) {
 					            scb->breakup = i;  /* sneaky, if not more work, than breakup is 0 */
@@ -4536,7 +4546,7 @@
                /* Also, we need to be sure we don't queue work ( breakup != 0 )
                   if no more sg units for next time */
                scb->dcdb.transfer_length = scb->data_len;
-               scb->data_busaddr = VIRT_TO_BUS(scb->sg_list);
+               scb->data_busaddr = virt_to_phys(scb->sg_list);
             }
                                               
              } else {
@@ -4544,11 +4554,11 @@
             if ((scb->scsi_cmd->request_bufflen - (bk_save * ha->max_xfer)) > ha->max_xfer) {
                /* Further breakup required */
                scb->data_len = ha->max_xfer;
-               scb->data_busaddr = VIRT_TO_BUS(scb->scsi_cmd->request_buffer + (bk_save * ha->max_xfer));
+               scb->data_busaddr = virt_to_phys(scb->scsi_cmd->request_buffer + (bk_save * ha->max_xfer));
                scb->breakup = bk_save + 1;
             } else {
                scb->data_len = scb->scsi_cmd->request_bufflen - (bk_save * ha->max_xfer);
-               scb->data_busaddr = VIRT_TO_BUS(scb->scsi_cmd->request_buffer + (bk_save * ha->max_xfer));
+               scb->data_busaddr = virt_to_phys(scb->scsi_cmd->request_buffer + (bk_save * ha->max_xfer));
             }
 
             scb->dcdb.transfer_length = scb->data_len;
@@ -4589,6 +4599,8 @@
             break;
          } /* end case */
 
+	pci_unmap_sg(ha->pcidev, (struct scatterlist *)scb->scsi_cmd->request_buffer, scb->sg_len, 
+		scsi_to_pci_dma_dir(scb->scsi_cmd->sc_data_direction));
          return ;
       }
 #ifndef NO_IPS_CMDLINE
@@ -4851,7 +4863,7 @@
          } else {
             scb->cmd.logical_info.op_code = IPS_CMD_GET_LD_INFO;
             scb->cmd.logical_info.command_id = IPS_COMMAND_ID(ha, scb);
-            scb->cmd.logical_info.buffer_addr = cpu_to_le32(VIRT_TO_BUS(&ha->adapt->logical_drive_info));
+            scb->cmd.logical_info.buffer_addr = cpu_to_le32(virt_to_phys(&ha->adapt->logical_drive_info));
             scb->cmd.logical_info.reserved = 0;
             scb->cmd.logical_info.reserved2 = 0;
             ret = IPS_SUCCESS;
@@ -4944,14 +4956,14 @@
       case MODE_SENSE:
          scb->cmd.basic_io.op_code = IPS_CMD_ENQUIRY;
          scb->cmd.basic_io.command_id = IPS_COMMAND_ID(ha, scb);
-         scb->cmd.basic_io.sg_addr = cpu_to_le32(VIRT_TO_BUS(ha->enq));
+         scb->cmd.basic_io.sg_addr = cpu_to_le32(virt_to_phys(ha->enq));
          ret = IPS_SUCCESS;
          break;
 
       case READ_CAPACITY:
          scb->cmd.logical_info.op_code = IPS_CMD_GET_LD_INFO;
          scb->cmd.logical_info.command_id = IPS_COMMAND_ID(ha, scb);
-         scb->cmd.logical_info.buffer_addr = cpu_to_le32(VIRT_TO_BUS(&ha->adapt->logical_drive_info));
+         scb->cmd.logical_info.buffer_addr = cpu_to_le32(virt_to_phys(&ha->adapt->logical_drive_info));
          scb->cmd.logical_info.reserved = 0;
          scb->cmd.logical_info.reserved2 = 0;
          scb->cmd.logical_info.reserved3 = 0;
@@ -5007,7 +5019,7 @@
 
       ha->dcdb_active[scb->bus-1] |= (1 << scb->target_id);
       scb->cmd.dcdb.command_id = IPS_COMMAND_ID(ha, scb);
-      scb->cmd.dcdb.dcdb_address = cpu_to_le32(VIRT_TO_BUS(&scb->dcdb));
+      scb->cmd.dcdb.dcdb_address = cpu_to_le32(virt_to_phys(&scb->dcdb));
       scb->cmd.dcdb.reserved = 0;
       scb->cmd.dcdb.reserved2 = 0;
       scb->cmd.dcdb.reserved3 = 0;
@@ -5532,16 +5544,16 @@
 
    /* Initialize dummy command bucket */
    ha->dummy->op_code = 0xFF;
-   ha->dummy->ccsar = cpu_to_le32(VIRT_TO_BUS(ha->dummy));
+   ha->dummy->ccsar = cpu_to_le32(virt_to_phys(ha->dummy));
    ha->dummy->command_id = IPS_MAX_CMDS;
 
    /* set bus address of scb */
-   scb->scb_busaddr = VIRT_TO_BUS(scb);
+   scb->scb_busaddr = virt_to_phys(scb);
    scb->sg_list = sg_list;
 
    /* Neptune Fix */
    scb->cmd.basic_io.cccr = cpu_to_le32((u_int32_t) IPS_BIT_ILE);
-   scb->cmd.basic_io.ccsar = cpu_to_le32(VIRT_TO_BUS(ha->dummy));
+   scb->cmd.basic_io.ccsar = cpu_to_le32(virt_to_phys(ha->dummy));
 }
 
 /****************************************************************************/
@@ -6151,7 +6163,7 @@
    ha->adapt->p_status_end = ha->adapt->status + IPS_MAX_CMDS;
    ha->adapt->p_status_tail = ha->adapt->status;
 
-   phys_status_start = VIRT_TO_BUS(ha->adapt->status);
+   phys_status_start = virt_to_phys(ha->adapt->status);
    outl(cpu_to_le32(phys_status_start), ha->io_addr + IPS_REG_SQSR);
    outl(cpu_to_le32(phys_status_start + IPS_STATUS_Q_SIZE), ha->io_addr + IPS_REG_SQER);
    outl(cpu_to_le32(phys_status_start + IPS_STATUS_SIZE), ha->io_addr + IPS_REG_SQHR);
@@ -6180,7 +6192,7 @@
    ha->adapt->p_status_end = ha->adapt->status + IPS_MAX_CMDS;
    ha->adapt->p_status_tail = ha->adapt->status;
 
-   phys_status_start = VIRT_TO_BUS(ha->adapt->status);
+   phys_status_start = virt_to_phys(ha->adapt->status);
    writel(cpu_to_le32(phys_status_start), ha->mem_ptr + IPS_REG_SQSR);
    writel(cpu_to_le32(phys_status_start + IPS_STATUS_Q_SIZE), ha->mem_ptr + IPS_REG_SQER);
    writel(cpu_to_le32(phys_status_start + IPS_STATUS_SIZE), ha->mem_ptr + IPS_REG_SQHR);
@@ -6734,7 +6746,7 @@
    scb->cmd.basic_io.op_code = IPS_CMD_ENQUIRY;
    scb->cmd.basic_io.command_id = IPS_COMMAND_ID(ha, scb);
    scb->cmd.basic_io.sg_count = 0;
-   scb->cmd.basic_io.sg_addr = cpu_to_le32(VIRT_TO_BUS(ha->enq));
+   scb->cmd.basic_io.sg_addr = cpu_to_le32(virt_to_phys(ha->enq));
    scb->cmd.basic_io.lba = 0;
    scb->cmd.basic_io.sector_count = 0;
    scb->cmd.basic_io.log_drv = 0;
@@ -6775,7 +6787,7 @@
    scb->cmd.basic_io.op_code = IPS_CMD_GET_SUBSYS;
    scb->cmd.basic_io.command_id = IPS_COMMAND_ID(ha, scb);
    scb->cmd.basic_io.sg_count = 0;
-   scb->cmd.basic_io.sg_addr = cpu_to_le32(VIRT_TO_BUS(ha->subsys));
+   scb->cmd.basic_io.sg_addr = cpu_to_le32(virt_to_phys(ha->subsys));
    scb->cmd.basic_io.lba = 0;
    scb->cmd.basic_io.sector_count = 0;
    scb->cmd.basic_io.log_drv = 0;
@@ -6820,7 +6832,7 @@
 
    scb->cmd.basic_io.op_code = IPS_CMD_READ_CONF;
    scb->cmd.basic_io.command_id = IPS_COMMAND_ID(ha, scb);
-   scb->cmd.basic_io.sg_addr = cpu_to_le32(VIRT_TO_BUS(ha->conf));
+   scb->cmd.basic_io.sg_addr = cpu_to_le32(virt_to_phys(ha->conf));
 
    /* send command */
    if (((ret = ips_send_wait(ha, scb, ips_cmd_timeout, intr)) == IPS_FAILURE) ||
@@ -6866,7 +6878,7 @@
    scb->cmd.nvram.command_id = IPS_COMMAND_ID(ha, scb);
    scb->cmd.nvram.page = 5;
    scb->cmd.nvram.write = write;
-   scb->cmd.nvram.buffer_addr = cpu_to_le32(VIRT_TO_BUS(ha->nvram));
+   scb->cmd.nvram.buffer_addr = cpu_to_le32(virt_to_phys(ha->nvram));
    scb->cmd.nvram.reserved = 0;
    scb->cmd.nvram.reserved2 = 0;
 
diff -u --new-file --recursive --exclude-from /home/andmike/views/dontdiff linux-256/drivers/scsi/ips.h linux-256-ips/drivers/scsi/ips.h
--- linux-256/drivers/scsi/ips.h	Mon Mar 18 17:32:06 2002
+++ linux-256-ips/drivers/scsi/ips.h	Wed Mar 20 16:56:35 2002
@@ -443,7 +443,8 @@
     present : 0,                          \
     unchecked_isa_dma : 0,                \
     use_clustering : ENABLE_CLUSTERING,   \
-    use_new_eh_code : 1                   \
+    use_new_eh_code : 1,                  \
+    highmem_io : 1                        \
 }
 #else
  #define IPS {                            \

--------------000504030501090608070402--

