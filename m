Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262898AbTI2Ilc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 04:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbTI2IkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 04:40:03 -0400
Received: from amsfep16-int.chello.nl ([213.46.243.26]:57130 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S262901AbTI2Ihy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 04:37:54 -0400
Date: Mon, 29 Sep 2003 10:39:11 +0200
Message-Id: <200309290839.h8T8dB2R003700@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 331] Amiga A2091 SCSI fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A2091 SCSI: Fix compilation by getting rid of the obsolete SCSI host instance
loop and using per-card interrupt handlers instead.

--- linux-2.6.0-test6/drivers/scsi/Kconfig	Fri Sep 19 15:28:40 2003
+++ linux-m68k-2.6.0-test6/drivers/scsi/Kconfig	Sat Sep 27 15:31:23 2003
@@ -1552,7 +1552,7 @@
 
 config A2091_SCSI
 	tristate "A2091/A590 WD33C93A support"
-	depends on ZORRO && SCSI && BROKEN
+	depends on ZORRO && SCSI
 	help
 	  If you have a Commodore A2091 SCSI controller, say Y. Otherwise,
 	  say N. This driver is also available as a module ( = code which can
--- linux-2.6.0-test6/drivers/scsi/a2091.c	Tue Jul 29 18:19:05 2003
+++ linux-m68k-2.6.0-test6/drivers/scsi/a2091.c	Sat Sep 27 15:17:28 2003
@@ -25,31 +25,20 @@
 #define DMA(ptr) ((a2091_scsiregs *)((ptr)->base))
 #define HDATA(ptr) ((struct WD33C93_hostdata *)((ptr)->hostdata))
 
-static struct Scsi_Host *first_instance = NULL;
-static Scsi_Host_Template *a2091_template;
-
-static irqreturn_t a2091_intr (int irq, void *dummy, struct pt_regs *fp)
+static irqreturn_t a2091_intr (int irq, void *_instance, struct pt_regs *fp)
 {
     unsigned long flags;
     unsigned int status;
-    struct Scsi_Host *instance;
-    int handled = 0;
+    struct Scsi_Host *instance = (struct Scsi_Host *)_instance;
 
-    for (instance = first_instance; instance &&
-	 instance->hostt == a2091_template; instance = instance->next)
-    {
-	status = DMA(instance)->ISTR;
-	if (!(status & (ISTR_INT_F|ISTR_INT_P)))
-		continue;
-
-	if (status & ISTR_INTS) {
-		spin_lock_irqsave(instance->host_lock, flags);
-		wd33c93_intr (instance);
-		spin_unlock_irqrestore(instance->host_lock, flags);
-		handled = 1;
-	}
-    }
-    return IRQ_RETVAL(handled);
+    status = DMA(instance)->ISTR;
+    if (!(status & (ISTR_INT_F|ISTR_INT_P)) || !(status & ISTR_INTS))
+	return IRQ_NONE;
+
+    spin_lock_irqsave(instance->host_lock, flags);
+    wd33c93_intr(instance);
+    spin_unlock_irqrestore(instance->host_lock, flags);
+    return IRQ_HANDLED;
 }
 
 static int dma_setup (Scsi_Cmnd *cmd, int dir_in)
@@ -184,8 +173,6 @@
     }
 }
 
-static int num_a2091 = 0;
-
 int __init a2091_detect(Scsi_Host_Template *tpnt)
 {
     static unsigned char called = 0;
@@ -193,6 +180,7 @@
     unsigned long address;
     struct zorro_dev *z = NULL;
     wd33c93_regs regs;
+    int num_a2091 = 0;
 
     if (!MACH_IS_AMIGA || called)
 	return 0;
@@ -221,13 +209,10 @@
 	regs.SASR = &(DMA(instance)->SASR);
 	regs.SCMD = &(DMA(instance)->SCMD);
 	wd33c93_init(instance, regs, dma_setup, dma_stop, WD33C93_FS_8_10);
-	if (num_a2091++ == 0) {
-	    first_instance = instance;
-	    a2091_template = instance->hostt;
-	    request_irq(IRQ_AMIGA_PORTS, a2091_intr, SA_SHIRQ, "A2091 SCSI",
-			a2091_intr);
-	}
+	request_irq(IRQ_AMIGA_PORTS, a2091_intr, SA_SHIRQ, "A2091 SCSI",
+		    instance);
 	DMA(instance)->CNTR = CNTR_PDMD | CNTR_INTEN;
+	num_a2091++;
     }
 
     return num_a2091;
@@ -266,8 +251,7 @@
 #ifdef MODULE
 	DMA(instance)->CNTR = 0;
 	release_mem_region(ZTWO_PADDR(instance->base), 256);
-	if (--num_a2091 == 0)
-		free_irq(IRQ_AMIGA_PORTS, a2091_intr);
+	free_irq(IRQ_AMIGA_PORTS, instance);
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
