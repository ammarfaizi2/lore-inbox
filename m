Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130191AbRAQWXy>; Wed, 17 Jan 2001 17:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130484AbRAQWXp>; Wed, 17 Jan 2001 17:23:45 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:64824
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S130191AbRAQWX3>; Wed, 17 Jan 2001 17:23:29 -0500
Date: Wed, 17 Jan 2001 23:23:20 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] make drivers/scsi/mvme147.c care about (some) return codes (240p3)
Message-ID: <20010117232320.C602@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

(I have not been able to find a maintainer for this code.)

The following patch makes drivers/scsi/mvme147.c check the return code
from request_irq and scsi_register. It applies cleanly against 240p3 
and ac9.

Please comment.


--- linux/drivers/scsi/mvme147.c	Tue Nov 28 02:57:34 2000
+++ linux-ac9/drivers/scsi/mvme147.c	Wed Jan 17 22:40:08 2001
@@ -74,13 +74,18 @@
     tpnt->proc_info = &wd33c93_proc_info;
 
     mvme147_host = scsi_register (tpnt, sizeof(struct WD33C93_hostdata));
+    if (!mvme147_host)
+	    goto err_out;
+
     mvme147_host->base = 0xfffe4000;
     mvme147_host->irq = MVME147_IRQ_SCSI_PORT;
     wd33c93_init(mvme147_host, (wd33c93_regs *)0xfffe4000,
 		 dma_setup, dma_stop, WD33C93_FS_8_10);
 
-    request_irq(MVME147_IRQ_SCSI_PORT, mvme147_intr, 0, "MVME147 SCSI PORT", mvme147_intr);
-    request_irq(MVME147_IRQ_SCSI_DMA, mvme147_intr, 0, "MVME147 SCSI DMA", mvme147_intr);
+    if (request_irq(MVME147_IRQ_SCSI_PORT, mvme147_intr, 0, "MVME147 SCSI PORT", mvme147_intr))
+	    goto err_unregister;
+    if (request_irq(MVME147_IRQ_SCSI_DMA, mvme147_intr, 0, "MVME147 SCSI DMA", mvme147_intr))
+	    goto err_free_irq;
 #if 0	/* Disabled; causes problems booting */
     m147_pcc->scsi_interrupt = 0x10;	/* Assert SCSI bus reset */
     udelay(100);
@@ -94,6 +99,14 @@
     m147_pcc->dma_intr = 0x89;		/* Ack and enable ints */
 
     return 1;
+
+ err_free_irq:
+    free_irq(MVME147_IRQ_SCSI_PORT, mvme147_intr);
+ err_unregister:
+    wd33c93_release();
+    scsi_unregister(mvme147_host);
+ err_out:
+    return 0;
 }
 
 #define HOSTS_C

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

"I begin by taking. I shall find scholars later to demonstrate my 
perfect right." - Frederick (II) the Great
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
