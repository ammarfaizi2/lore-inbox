Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130484AbRAQW1Y>; Wed, 17 Jan 2001 17:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129874AbRAQW1O>; Wed, 17 Jan 2001 17:27:14 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:16697
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S130484AbRAQW1D>; Wed, 17 Jan 2001 17:27:03 -0500
Date: Wed, 17 Jan 2001 23:26:53 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: andrewb@uab.edu
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] make drivers/scsi/sgiwd93.c check some more return codes (240p3)
Message-ID: <20010117232652.D602@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch makes drivers/scsi/sgiwd93.c check the return code
from request_irq and get_free_pages. It also removes a line already done
a bit higher up (the dma_cache_wback_inv one).

Please comment.



--- linux-ac9/drivers/scsi/sgiwd93.c.org	Sun Jan 14 21:33:29 2001
+++ linux-ac9/drivers/scsi/sgiwd93.c	Sun Jan 14 22:57:46 2001
@@ -281,6 +281,11 @@
 	sgiwd93_host->irq = SGI_WD93_0_IRQ;
 
 	buf = (uchar *) get_free_page(GFP_KERNEL);
+	if (!buf) {
+		printk(KERN_WARNING "sgiwd93: Could not allocate memory for host0 buffer.\n");
+		scsi_unregister(sgiwd93_host);
+		return 0;
+	}
 	init_hpc_chain(buf);
 	dma_cache_wback_inv((unsigned long) buf, PAGE_SIZE);
 	/* HPC_SCSI_REG0 | 0x03 | KSEG1 */
@@ -290,9 +295,14 @@
 	hdata = (struct WD33C93_hostdata *)sgiwd93_host->hostdata;
 	hdata->no_sync = 0;
 	hdata->dma_bounce_buffer = (uchar *) (KSEG1ADDR(buf));
-	dma_cache_wback_inv((unsigned long) buf, PAGE_SIZE);
 
-	request_irq(SGI_WD93_0_IRQ, sgiwd93_intr, 0, "SGI WD93", (void *) sgiwd93_host);
+	if (request_irq(SGI_WD93_0_IRQ, sgiwd93_intr, 0, "SGI WD93", (void *) sgiwd93_host)) {
+		printk(KERN_WARNING "sgiwd93: Could not register IRQ %d (for host 0).\n", sgiwd93_intr);
+		wd33c93_release();
+		free_page(buf);
+		scsi_unregister(sgiwd93_host);
+		return 0;
+	}
         /* set up second controller on the Indigo2 */
 	if(!sgi_guiness) {
 		sgiwd93_host1 = scsi_register(SGIblows, sizeof(struct WD33C93_hostdata));
@@ -302,6 +312,12 @@
 			sgiwd93_host1->irq = SGI_WD93_1_IRQ;
 	
 			buf = (uchar *) get_free_page(GFP_KERNEL);
+			if (!buf) {
+				printk(KERN_WARNING "sgiwd93: Could not allocate memory for host1 buffer.\n");
+				scsi_unregister(sgiwd93_host1);
+				called = 1;
+				return 1; /* We registered host0 so return success*/
+			}
 			init_hpc_chain(buf);
 			dma_cache_wback_inv((unsigned long) buf, PAGE_SIZE);
 			/* HPC_SCSI_REG1 | 0x03 | KSEG1 */
@@ -313,7 +329,13 @@
 			hdata1->dma_bounce_buffer = (uchar *) (KSEG1ADDR(buf));
 			dma_cache_wback_inv((unsigned long) buf, PAGE_SIZE);
 	
-			request_irq(SGI_WD93_1_IRQ, sgiwd93_intr, 0, "SGI WD93", (void *) sgiwd93_host1);
+			if (request_irq(SGI_WD93_1_IRQ, sgiwd93_intr, 0, "SGI WD93", (void *) sgiwd93_host1)) {
+				printk(KERN_WARNING "sgiwd93: Could not allocate irq %d (for host1).\n", sgiwd93_intr);
+				wd33c93_release();
+				free_page(buf);
+				scsi_unregister(sgiwd93_host1);
+				/* Fall through since host0 registered OK */
+			}
 		}
 	}
 	

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

Smoking kills. If you're killed, you've lost a very important part of your
life.  -Brooke Shields, during an interview to become spokesperson for a
federal anti-smoking campaign.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
