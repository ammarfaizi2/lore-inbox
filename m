Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129763AbRAQWOX>; Wed, 17 Jan 2001 17:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129771AbRAQWON>; Wed, 17 Jan 2001 17:14:13 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:28216
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129763AbRAQWOF>; Wed, 17 Jan 2001 17:14:05 -0500
Date: Wed, 17 Jan 2001 23:13:53 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: jskov@cygnus.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] make drivers/scsi/blz1230.c check request_irq return (240p3)
Message-ID: <20010117231353.A602@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch makes drivers/scsi/blz1230.c check request_irq's
return code. It applies cleanly against 240p3 and ac9.

It also swaps two lines in an existing error path (esp_deallocate/
scsi_unregister) since this seems wrong.

Comments?


--- linux-ac9/drivers/scsi/blz1230.c.org	Sun Jan 14 19:58:47 2001
+++ linux-ac9/drivers/scsi/blz1230.c	Wed Jan 17 23:09:45 2001
@@ -88,13 +88,8 @@
 
 		esp_write(eregs->esp_cfg1, (ESP_CONFIG1_PENABLE | 7));
 		udelay(5);
-		if(esp_read(eregs->esp_cfg1) != (ESP_CONFIG1_PENABLE | 7)){
-			esp_deallocate(esp);
-			scsi_unregister(esp->ehost);
-			release_mem_region(board+REAL_BLZ1230_ESP_ADDR,
-					   sizeof(struct ESP_regs));
-			return 0; /* Bail out if address did not hold data */
-		}
+		if(esp_read(eregs->esp_cfg1) != (ESP_CONFIG1_PENABLE | 7))
+			goto err_out;
 
 		/* Do command transfer with programmed I/O */
 		esp->do_pio_cmds = 1;
@@ -140,8 +135,9 @@
 
 		esp->irq = IRQ_AMIGA_PORTS;
 		esp->slot = board+REAL_BLZ1230_ESP_ADDR;
-		request_irq(IRQ_AMIGA_PORTS, esp_intr, SA_SHIRQ,
-			    "Blizzard 1230 SCSI IV", esp_intr);
+		if (request_irq(IRQ_AMIGA_PORTS, esp_intr, SA_SHIRQ,
+				 "Blizzard 1230 SCSI IV", esp_intr))
+			goto err_out;
 
 		/* Figure out our scsi ID on the bus */
 		esp->scsi_id = 7;
@@ -156,6 +152,13 @@
 		return esps_in_use;
 	    }
 	}
+	return 0;
+ 
+ err_out:
+	scsi_unregister(esp->ehost);
+	esp_deallocate(esp);
+	release_mem_region(board+REAL_BLZ1230_ESP_ADDR,
+			   sizeof(struct ESP_regs));
 	return 0;
 }
 
-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

Half this game is ninety percent mental.
-Philadelphia Phillies manager Danny Ozark
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
