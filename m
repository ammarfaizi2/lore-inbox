Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262099AbSJFRVC>; Sun, 6 Oct 2002 13:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262078AbSJFRUv>; Sun, 6 Oct 2002 13:20:51 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55044 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262099AbSJFRRk>; Sun, 6 Oct 2002 13:17:40 -0400
Subject: PATCH: 2.5.40 Fix stupid scsi setup bug in 53c406, fix addressing
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Sun, 6 Oct 2002 18:14:35 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yEzE-0001sk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.40/drivers/scsi/NCR53c406a.c linux.2.5.40-ac5/drivers/scsi/NCR53c406a.c
--- linux.2.5.40/drivers/scsi/NCR53c406a.c	2002-10-02 21:32:55.000000000 +0100
+++ linux.2.5.40-ac5/drivers/scsi/NCR53c406a.c	2002-10-04 16:07:01.000000000 +0100
@@ -459,7 +459,7 @@
 
 int  __init 
 NCR53c406a_detect(Scsi_Host_Template * tpnt){
-    struct Scsi_Host *shpnt;
+    struct Scsi_Host *shpnt = NULL;
 #ifndef PORT_BASE
     int i;
 #endif
@@ -535,11 +535,20 @@
 #endif
     
     DEB(printk("NCR53c406a: using port_base %x\n", port_base));
+
+    tpnt->present = 1;
+    tpnt->proc_name = "NCR53c406a";
+    
+    shpnt = scsi_register(tpnt, 0);
+    if (!shpnt) {
+            printk("NCR53c406a: Unable to register host, giving up.\n");
+            goto err_release;
+    }
     
     if(irq_level > 0) {
         if(request_irq(irq_level, do_NCR53c406a_intr, 0, "NCR53c406a", shpnt)){
             printk("NCR53c406a: unable to allocate IRQ %d\n", irq_level);
-            goto err_release;
+            goto err_free_scsi;
         }
         tpnt->can_queue = 1;
         DEB(printk("NCR53c406a: allocated IRQ %d\n", irq_level));
@@ -549,32 +558,24 @@
         DEB(printk("NCR53c406a: No interrupts detected\n"));
 #if USE_DMA
         printk("NCR53c406a: No interrupts found and DMA mode defined. Giving up.\n");
-        goto err_release;
+        goto err_free_scsi;
 #endif /* USE_DMA */
     }
     else {
         DEB(printk("NCR53c406a: Shouldn't get here!\n"));
-        goto err_free_irq;
+        goto err_free_scsi;
     }
     
 #if USE_DMA
     dma_chan = DMA_CHAN;
     if(request_dma(dma_chan, "NCR53c406a") != 0){
         printk("NCR53c406a: unable to allocate DMA channel %d\n", dma_chan);
-        goto err_release;
+        goto err_free_irq;
     }
     
     DEB(printk("Allocated DMA channel %d\n", dma_chan));
 #endif /* USE_DMA */
     
-    tpnt->present = 1;
-    tpnt->proc_name = "NCR53c406a";
-    
-    shpnt = scsi_register(tpnt, 0);
-    if (!shpnt) {
-            printk("NCR53c406a: Unable to register host, giving up.\n");
-            goto err_free_dma;
-    }
     shpnt->irq = irq_level;
     shpnt->io_port = port_base;
     shpnt->n_io_port = 0x10;
@@ -592,13 +593,13 @@
     
     return (tpnt->present);
 
-
- err_free_dma:
 #if USE_DMA
-    free_dma(dma_chan);
-#endif
  err_free_irq:
-    free_irq(irq_level, do_NCR53c406a_intr);
+    if(irq_level)
+    	free_irq(irq_level, shpnt);
+#endif    	
+ err_free_scsi:
+    scsi_unregister(shpnt);
  err_release:
     release_region(port_base, 0x10);
     return 0;
@@ -896,7 +897,7 @@
                 sgcount = current_SC->use_sg;
                 sglist = current_SC->request_buffer;
                 while( sgcount-- ) {
-                    NCR53c406a_pio_write(sglist->address, sglist->length);
+                    NCR53c406a_pio_write(page_address(sglist->page) + sglist->offset, sglist->length);
                     sglist++;
                 }
             }
@@ -925,7 +926,7 @@
                 sgcount = current_SC->use_sg;
                 sglist = current_SC->request_buffer;
                 while( sgcount-- ) {
-                    NCR53c406a_pio_read(sglist->address, sglist->length);
+                    NCR53c406a_pio_read(page_address(sglist->page) + sglist->offset, sglist->length);
                     sglist++;
                 }
             }
