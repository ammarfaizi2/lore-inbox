Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262553AbTI1NSc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 09:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbTI1NHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 09:07:30 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:30022 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S262575AbTI1NG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 09:06:26 -0400
Date: Sun, 28 Sep 2003 14:55:39 +0200
Message-Id: <200309281255.h8SCtdat005660@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 332] Amiga GVP-II SCSI fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GVP-II SCSI: Fix compilation by getting rid of the obsolete SCSI host instance
loop and using per-card interrupt handlers instead.

--- linux-2.6.0-test6/drivers/scsi/Kconfig	Fri Sep 19 15:28:40 2003
+++ linux-m68k-2.6.0-test6/drivers/scsi/Kconfig	Sat Sep 27 15:31:23 2003
@@ -1562,7 +1562,7 @@
 
 config GVP11_SCSI
 	tristate "GVP Series II WD33C93A support"
-	depends on ZORRO && SCSI && BROKEN
+	depends on ZORRO && SCSI
 	---help---
 	  If you have a Great Valley Products Series II SCSI controller,
 	  answer Y. Also say Y if you have a later model of GVP SCSI
--- linux-2.6.0-test6/drivers/scsi/gvp11.c	Tue Jul 29 18:19:09 2003
+++ linux-m68k-2.6.0-test6/drivers/scsi/gvp11.c	Sat Sep 27 15:18:12 2003
@@ -25,29 +25,20 @@
 #define DMA(ptr) ((gvp11_scsiregs *)((ptr)->base))
 #define HDATA(ptr) ((struct WD33C93_hostdata *)((ptr)->hostdata))
 
-static struct Scsi_Host *first_instance = NULL;
-static Scsi_Host_Template *gvp11_template;
-
-static irqreturn_t gvp11_intr (int irq, void *dummy, struct pt_regs *fp)
+static irqreturn_t gvp11_intr (int irq, void *_instance, struct pt_regs *fp)
 {
     unsigned long flags;
     unsigned int status;
-    struct Scsi_Host *instance;
-    int handled = 0;
-
-    for (instance = first_instance; instance &&
-	 instance->hostt == gvp11_template; instance = instance->next)
-    {
-	status = DMA(instance)->CNTR;
-	if (!(status & GVP11_DMAC_INT_PENDING))
-	    continue;
+    struct Scsi_Host *instance = (struct Scsi_Host *)_instance;
 
-	spin_lock_irqsave(instance->host_lock, flags);
-	wd33c93_intr (instance);
-	spin_unlock_irqrestore(instance->host_lock, flags);
-	handled = 1;
-    }
-    return IRQ_RETVAL(handled);
+    status = DMA(instance)->CNTR;
+    if (!(status & GVP11_DMAC_INT_PENDING))
+	return IRQ_NONE;
+
+    spin_lock_irqsave(instance->host_lock, flags);
+    wd33c93_intr(instance);
+    spin_unlock_irqrestore(instance->host_lock, flags);
+    return IRQ_HANDLED;
 }
 
 static int gvp11_xfer_mask = 0;
@@ -177,8 +168,6 @@
     }
 }
 
-static int num_gvp11 = 0;
-
 #define CHECK_WD33C93
 
 int __init gvp11_detect(Scsi_Host_Template *tpnt)
@@ -190,6 +179,7 @@
     struct zorro_dev *z = NULL;
     unsigned int default_dma_xfer_mask;
     wd33c93_regs regs;
+    int num_gvp11 = 0;
 #ifdef CHECK_WD33C93
     volatile unsigned char *sasr_3393, *scmd_3393;
     unsigned char save_sasr;
@@ -339,13 +329,10 @@
 		     (epc & GVP_SCSICLKMASK) ? WD33C93_FS_8_10
 					     : WD33C93_FS_12_15);
 
-	if (num_gvp11++ == 0) {
-		first_instance = instance;
-		gvp11_template = instance->hostt;
-		request_irq(IRQ_AMIGA_PORTS, gvp11_intr, SA_SHIRQ,
-			    "GVP11 SCSI", gvp11_intr);
-	}
+	request_irq(IRQ_AMIGA_PORTS, gvp11_intr, SA_SHIRQ, "GVP11 SCSI",
+		    instance);
 	DMA(instance)->CNTR = GVP11_DMAC_INT_ENABLE;
+	num_gvp11++;
 	continue;
 
 release:
@@ -391,8 +378,7 @@
 #ifdef MODULE
     DMA(instance)->CNTR = 0;
     release_mem_region(ZTWO_PADDR(instance->base), 256);
-    if (--num_gvp11 == 0)
-	    free_irq(IRQ_AMIGA_PORTS, gvp11_intr);
+    free_irq(IRQ_AMIGA_PORTS, instance);
     wd33c93_release();
 #endif
     return 1;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
