Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbVASLr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbVASLr4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 06:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbVASLrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 06:47:47 -0500
Received: from verein.lst.de ([213.95.11.210]:60884 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261697AbVASLrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 06:47:22 -0500
Date: Wed, 19 Jan 2005 12:47:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: jejb@steeleye.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cosmetic jazz_esp updates
Message-ID: <20050119114718.GD11133@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -3.849 () BAYES_00,DOMAIN_BODY
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

small changes from Linux/MIPS CVS and typedef removal from me


--- 1.12/drivers/scsi/jazz_esp.c	2004-08-27 12:34:15 +02:00
+++ edited/drivers/scsi/jazz_esp.c	2005-01-19 12:33:09 +01:00
@@ -6,6 +6,7 @@
  * jazz_esp is based on David S. Miller's ESP driver and cyber_esp
  */
 
+#include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/types.h>
@@ -27,7 +28,7 @@
 #include <asm/pgtable.h>
 
 static int  dma_bytes_sent(struct NCR_ESP *esp, int fifo_count);
-static int  dma_can_transfer(struct NCR_ESP *esp, Scsi_Cmnd *sp);
+static int  dma_can_transfer(struct NCR_ESP *esp, struct scsi_cmnd *sp);
 static void dma_dump_state(struct NCR_ESP *esp);
 static void dma_init_read(struct NCR_ESP *esp, __u32 vaddress, int length);
 static void dma_init_write(struct NCR_ESP *esp, __u32 vaddress, int length);
@@ -36,11 +37,11 @@
 static int  dma_irq_p(struct NCR_ESP *esp);
 static int  dma_ports_p(struct NCR_ESP *esp);
 static void dma_setup(struct NCR_ESP *esp, __u32 addr, int count, int write);
-static void dma_mmu_get_scsi_one (struct NCR_ESP *esp, Scsi_Cmnd *sp);
-static void dma_mmu_get_scsi_sgl (struct NCR_ESP *esp, Scsi_Cmnd *sp);
-static void dma_mmu_release_scsi_one (struct NCR_ESP *esp, Scsi_Cmnd *sp);
-static void dma_mmu_release_scsi_sgl (struct NCR_ESP *esp, Scsi_Cmnd *sp);
-static void dma_advance_sg (Scsi_Cmnd *sp);
+static void dma_mmu_get_scsi_one (struct NCR_ESP *esp, struct scsi_cmnd *sp);
+static void dma_mmu_get_scsi_sgl (struct NCR_ESP *esp, struct scsi_cmnd *sp);
+static void dma_mmu_release_scsi_one (struct NCR_ESP *esp, struct scsi_cmnd *sp);
+static void dma_mmu_release_scsi_sgl (struct NCR_ESP *esp, struct scsi_cmnd *sp);
+static void dma_advance_sg (struct scsi_cmnd *sp);
 static void dma_led_off(struct NCR_ESP *);
 static void dma_led_on(struct NCR_ESP *);
 
@@ -52,7 +53,7 @@
 				 */
 
 /***************************************************************** Detection */
-int jazz_esp_detect(Scsi_Host_Template *tpnt)
+static int jazz_esp_detect(struct scsi_host_template *tpnt)
 {
     struct NCR_ESP *esp;
     struct ConfigDev *esp_dev;
@@ -115,7 +116,7 @@
 	esp->esp_command = (volatile unsigned char *)cmd_buffer;
 	
 	/* get virtual dma address for command buffer */
-	esp->esp_command_dvma = vdma_alloc(PHYSADDR(cmd_buffer), sizeof (cmd_buffer));
+	esp->esp_command_dvma = vdma_alloc(CPHYSADDR(cmd_buffer), sizeof (cmd_buffer));
 	
 	esp->irq = JAZZ_SCSI_IRQ;
 	request_irq(JAZZ_SCSI_IRQ, esp_intr, SA_INTERRUPT, "JAZZ SCSI",
@@ -157,7 +158,7 @@
     return fifo_count;
 }
 
-static int dma_can_transfer(struct NCR_ESP *esp, Scsi_Cmnd *sp)
+static int dma_can_transfer(struct NCR_ESP *esp, struct scsi_cmnd *sp)
 {
     /*
      * maximum DMA size is 1MB
@@ -230,43 +231,43 @@
     }
 }
 
-static void dma_mmu_get_scsi_one (struct NCR_ESP *esp, Scsi_Cmnd *sp)
+static void dma_mmu_get_scsi_one (struct NCR_ESP *esp, struct scsi_cmnd *sp)
 {
-    sp->SCp.have_data_in = vdma_alloc(PHYSADDR(sp->SCp.buffer), sp->SCp.this_residual);
+    sp->SCp.have_data_in = vdma_alloc(CPHYSADDR(sp->SCp.buffer), sp->SCp.this_residual);
     sp->SCp.ptr = (char *)((unsigned long)sp->SCp.have_data_in);
 }
 
-static void dma_mmu_get_scsi_sgl (struct NCR_ESP *esp, Scsi_Cmnd *sp)
+static void dma_mmu_get_scsi_sgl (struct NCR_ESP *esp, struct scsi_cmnd *sp)
 {
     int sz = sp->SCp.buffers_residual;
-    struct mmu_sglist *sg = (struct mmu_sglist *) sp->SCp.buffer;
+    struct scatterlist *sg = (struct scatterlist *) sp->SCp.buffer;
     
     while (sz >= 0) {
-	sg[sz].dvma_addr = vdma_alloc(PHYSADDR(sg[sz].addr), sg[sz].len);
+	sg[sz].dma_address = vdma_alloc(CPHYSADDR(page_address(sg[sz].page) + sg[sz].offset), sg[sz].length);
 	sz--;
     }
-    sp->SCp.ptr=(char *)((unsigned long)sp->SCp.buffer->dvma_address);
+    sp->SCp.ptr=(char *)(sp->SCp.buffer->dma_address);
 }    
 
-static void dma_mmu_release_scsi_one (struct NCR_ESP *esp, Scsi_Cmnd *sp)
+static void dma_mmu_release_scsi_one (struct NCR_ESP *esp, struct scsi_cmnd *sp)
 {
     vdma_free(sp->SCp.have_data_in);
 }
 
-static void dma_mmu_release_scsi_sgl (struct NCR_ESP *esp, Scsi_Cmnd *sp)
+static void dma_mmu_release_scsi_sgl (struct NCR_ESP *esp, struct scsi_cmnd *sp)
 {
     int sz = sp->use_sg - 1;
-    struct mmu_sglist *sg = (struct mmu_sglist *)sp->buffer;
+    struct scatterlist *sg = (struct scatterlist *)sp->buffer;
 			
     while(sz >= 0) {
-	vdma_free(sg[sz].dvma_addr);
+	vdma_free(sg[sz].dma_address);
 	sz--;
     }
 }
 
-static void dma_advance_sg (Scsi_Cmnd *sp)
+static void dma_advance_sg (struct scsi_cmnd *sp)
 {
-    sp->SCp.ptr = (char *)((unsigned long)sp->SCp.buffer->dvma_address);
+    sp->SCp.ptr = (char *)(sp->SCp.buffer->dma_address);
 }
 
 #define JAZZ_HDC_LED   0xe000d100 /* FIXME, find correct address */
@@ -285,9 +286,9 @@
 #endif    
 }
 
-static Scsi_Host_Template driver_template = {
+static struct scsi_host_template driver_template = {
 	.proc_name		= "jazz_esp",
-	.proc_info		= &esp_proc_info,
+	.proc_info		= esp_proc_info,
 	.name			= "ESP 100/100a/200",
 	.detect			= jazz_esp_detect,
 	.slave_alloc		= esp_slave_alloc,
@@ -303,4 +304,4 @@
 	.cmd_per_lun		= 1,
 	.use_clustering		= DISABLE_CLUSTERING,
 };
-
+#include "scsi_module.c"
