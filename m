Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135324AbRANUB0>; Sun, 14 Jan 2001 15:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135344AbRANUBG>; Sun, 14 Jan 2001 15:01:06 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:41850
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S135324AbRANUBD>; Sun, 14 Jan 2001 15:01:03 -0500
Date: Sun, 14 Jan 2001 21:00:55 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make drivers/scsi/a3000.c check request_irq (240p3)
Message-ID: <20010114210055.E602@jaquet.dk>
In-Reply-To: <20010114194935.A602@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20010114194935.A602@jaquet.dk>; from rasmus@jaquet.dk on Sun, Jan 14, 2001 at 07:49:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2001 at 07:49:35PM +0100, Rasmus Andersen wrote:
> Comments?
> 

Well, Hans Grobler had some. the patch below tries to accommodate them by
adding scsi_unregister() and wd33c93_release() to the earlier patch.
Sorry for the multiple mailings.

(Any other) comments? :)


--- linux-ac9/drivers/scsi/a3000.c.org	Sun Jan 14 13:47:32 2001
+++ linux-ac9/drivers/scsi/a3000.c	Sun Jan 14 20:51:56 2001
@@ -194,8 +194,13 @@
     DMA(a3000_host)->DAWR = DAWR_A3000;
     wd33c93_init(a3000_host, (wd33c93_regs *)&(DMA(a3000_host)->SASR),
 		 dma_setup, dma_stop, WD33C93_FS_12_15);
-    request_irq(IRQ_AMIGA_PORTS, a3000_intr, SA_SHIRQ, "A3000 SCSI",
-		a3000_intr);
+    if (!request_irq(IRQ_AMIGA_PORTS, a3000_intr, SA_SHIRQ, "A3000 SCSI",
+		     a3000_intr)) {
+	wd33c93_release();
+	scsi_unregister(a3000_host);
+	release_mem_region(0xDD0000, 256);
+    	return 0;
+    }	    
     DMA(a3000_host)->CNTR = CNTR_PDMD | CNTR_INTEN;
     called = 1;
 

-- 
        Rasmus(rasmus@jaquet.dk)

A chicken and an egg are lying in bed. The chicken is smoking a
cigarette with a satisfied smile on it's face and the egg is frowning
and looking a bit pissed off. The egg mutters, to no-one in particular,
"Well, I guess we answered THAT question..."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
