Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132980AbRANSt6>; Sun, 14 Jan 2001 13:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132981AbRANSts>; Sun, 14 Jan 2001 13:49:48 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:44920
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S132980AbRANStn>; Sun, 14 Jan 2001 13:49:43 -0500
Date: Sun, 14 Jan 2001 19:49:35 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] make drivers/scsi/a3000.c check request_irq (240p3)
Message-ID: <20010114194935.A602@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

(I cannot seem to find a maintainer for this code.)

The following patch makes drivers/scsi/a3000.c check the return from
request_irq. Applies cleanly against 2.4.0 and ac9.

Comments?


--- linux-ac9/drivers/scsi/a3000.c.org	Sun Jan 14 13:47:32 2001
+++ linux-ac9/drivers/scsi/a3000.c	Sun Jan 14 14:04:52 2001
@@ -194,8 +194,11 @@
     DMA(a3000_host)->DAWR = DAWR_A3000;
     wd33c93_init(a3000_host, (wd33c93_regs *)&(DMA(a3000_host)->SASR),
 		 dma_setup, dma_stop, WD33C93_FS_12_15);
-    request_irq(IRQ_AMIGA_PORTS, a3000_intr, SA_SHIRQ, "A3000 SCSI",
-		a3000_intr);
+    if (!request_irq(IRQ_AMIGA_PORTS, a3000_intr, SA_SHIRQ, "A3000 SCSI",
+		     a3000_intr)) {
+	release_mem_region(0xDD0000, 256);
+    	return 0;
+    }	    
     DMA(a3000_host)->CNTR = CNTR_PDMD | CNTR_INTEN;
     called = 1;
 

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

"No man is genuinely happy, married, who has to drink worse whiskey than he
used to drink when he was single." H.L. Mencken
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
