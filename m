Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132992AbRAVXah>; Mon, 22 Jan 2001 18:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131022AbRAVXaS>; Mon, 22 Jan 2001 18:30:18 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:18257
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S135533AbRAVXaC>; Mon, 22 Jan 2001 18:30:02 -0500
Date: Tue, 23 Jan 2001 00:29:54 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: normunds@fi.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] general cleanup of drivers/scsi/NCR53c406a.c (241p9)
Message-ID: <20010123002954.F602@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

(I hope you are the NCR53c406a maintainer. If not, I apologize for
the inconvenience and hope you can redirect me.)

The following patch makes drivers/scsi/NCR53c406a.c use the return
code of request_region instead of check_region and makes it release
the proper resources in its error paths.

It applies cleanly against ac10 and 241p9.

Comments?


--- linux-ac10-clean/drivers/scsi/NCR53c406a.c	Mon Sep 18 22:36:24 2000
+++ linux-ac10/drivers/scsi/NCR53c406a.c	Sun Jan 21 23:31:40 2001
@@ -184,13 +184,13 @@
 /* ================================================================= */
 
 #if USE_BIOS
-static void *bios_base = (void *)0;
+static void *bios_base;
 #endif
 
 #if PORT_BASE
 static int   port_base = PORT_BASE;
 #else
-static int   port_base = 0;
+static int   port_base;
 #endif
 
 #if IRQ_LEV
@@ -200,16 +200,16 @@
 #endif
 
 #if USE_DMA
-static int   dma_chan = 0;
+static int   dma_chan;
 #endif
 
 #if USE_PIO
 static int   fast_pio = USE_FAST_PIO;
 #endif
 
-static Scsi_Cmnd         *current_SC       = NULL;
-static volatile int internal_done_flag = 0;
-static volatile int internal_done_errcode = 0;
+static Scsi_Cmnd         *current_SC;
+static volatile int internal_done_flag;
+static volatile int internal_done_errcode;
 static char info_msg[256];
 
 /* ================================================================= */
@@ -484,17 +484,17 @@
 #endif USE_BIOS
     
 #ifdef PORT_BASE
-    if (check_region(port_base, 0x10)) /* ports already snatched */
+    if (!request_region(port_base, 0x10, "NCR53c406a")) /* ports already snatched */
         port_base = 0;
     
 #else  /* autodetect */
     if (port_base) {		/* LILO override */
-        if (check_region(port_base, 0x10))
+        if (!request_region(port_base, 0x10, "NCR53c406a"))
             port_base = 0;
     }
     else {
         for(i=0;  i<PORT_COUNT && !port_base; i++){
-            if(check_region(ports[i], 0x10)){
+            if(!request_region(ports[i], 0x10, "NCR53c406a")){
                 DEB(printk("NCR53c406a: port %x in use\n", ports[i]));
             }
             else {
@@ -503,9 +503,10 @@
                 if(   (inb(ports[i] + 0x0e) ^ inb(ports[i] + 0x0e)) == 7
                    && (inb(ports[i] + 0x0e) ^ inb(ports[i] + 0x0e)) == 7
                    && (inb(ports[i] + 0x0e) & 0xf8) == 0x58 ) {
+                    port_base = ports[i];
                     VDEB(printk("NCR53c406a: Sig register valid\n"));
                     VDEB(printk("port_base=%x\n", port_base));
-                    port_base = ports[i];
+                    break;
                 }
             }
         }
@@ -527,18 +528,17 @@
         irq_level=irq_probe();
         if (irq_level < 0) {		/* Trouble */
             printk("NCR53c406a: IRQ problem, irq_level=%d, giving up\n", irq_level);
-            return 0;
+            goto err_release;
         }
     }
 #endif
     
     DEB(printk("NCR53c406a: using port_base %x\n", port_base));
-    request_region(port_base, 0x10, "NCR53c406a");
     
     if(irq_level > 0) {
         if(request_irq(irq_level, do_NCR53c406a_intr, 0, "NCR53c406a", NULL)){
             printk("NCR53c406a: unable to allocate IRQ %d\n", irq_level);
-            return 0;
+            goto err_release;
         }
         tpnt->can_queue = 1;
         DEB(printk("NCR53c406a: allocated IRQ %d\n", irq_level));
@@ -548,19 +548,19 @@
         DEB(printk("NCR53c406a: No interrupts detected\n"));
 #if USE_DMA
         printk("NCR53c406a: No interrupts found and DMA mode defined. Giving up.\n");
-        return 0;
+        goto err_release;
 #endif USE_DMA
     }
     else {
         DEB(printk("NCR53c406a: Shouldn't get here!\n"));
-        return 0;
+        goto err_release;
     }
     
 #if USE_DMA
     dma_chan = DMA_CHAN;
     if(request_dma(dma_chan, "NCR53c406a") != 0){
         printk("NCR53c406a: unable to allocate DMA channel %d\n", dma_chan);
-        return 0;
+        goto err_release;
     }
     
     DEB(printk("Allocated DMA channel %d\n", dma_chan));
@@ -570,6 +570,10 @@
     tpnt->proc_name = "NCR53c406a";
     
     shpnt = scsi_register(tpnt, 0);
+    if (!shpnt) {
+            printk("NCR53c406a: Unable to register host, giving up.\n");
+            goto err_free_dma;
+    }
     shpnt->irq = irq_level;
     shpnt->io_port = port_base;
     shpnt->n_io_port = 0x10;
@@ -586,6 +590,17 @@
 #endif
     
     return (tpnt->present);
+
+
+ err_free_dma:
+#ifdef USE_DMA
+    free_dma(dma_chan);
+#endif
+ err_free_irq:
+    free_irq(irq_level, do_NCR53c406a_intr);
+ err_release:
+    release_region(port_base, 0x10);
+    return 0;
 }
 
 /* called from init/main.c */

-- 
        Rasmus(rasmus@jaquet.dk)

That lowdown scoundrel deserves to be kicked to death by a jackass, and
I'm just the one to do it. -A congressional candidate in Texas
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
