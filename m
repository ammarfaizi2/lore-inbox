Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135682AbRAVXj1>; Mon, 22 Jan 2001 18:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135675AbRAVXjS>; Mon, 22 Jan 2001 18:39:18 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:22609
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S135605AbRAVXhZ>; Mon, 22 Jan 2001 18:37:25 -0500
Date: Tue, 23 Jan 2001 00:37:18 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-apus-devel@lists.sourceforge.net
Subject: [PATCH] make drivers/scsi/fastlane.c check return code of request_irq (241p9)
Message-ID: <20010123003718.K602@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

(I have not been able to find a maintainer for this code.)

The following patch makes drivers/scsi/fastlane.c check the return
code of request_irq and converts (some) error paths to use forward
gotos.

It applies cleanly against ac10 and 241p9.

Comments?


--- linux-ac10-clean/drivers/scsi/fastlane.c	Mon Oct 16 21:51:16 2000
+++ linux-ac10/drivers/scsi/fastlane.c	Sun Jan 21 20:27:17 2001
@@ -96,9 +96,7 @@
 		 * this ID value. Fortunately only Fastlane maps in Z3 space
 		 */
 		if (board < 0x1000000) {
-			release_mem_region(board+FASTLANE_ESP_ADDR,
-					   sizeof(struct ESP_regs));
-			return 0;
+			goto err_release;
 		}
 		esp = esp_allocate(tpnt, (void *)board+FASTLANE_ESP_ADDR);
 
@@ -146,10 +144,7 @@
 
 		if(!address){
 			printk("Could not remap Fastlane controller memory!");
-			scsi_unregister (esp->ehost);
-			release_mem_region(board+FASTLANE_ESP_ADDR,
-					   sizeof(struct ESP_regs));
-			return 0;
+			goto err_unregister;
 		}
 
 
@@ -171,8 +166,11 @@
 
 		esp->irq = IRQ_AMIGA_PORTS;
 		esp->slot = board+FASTLANE_ESP_ADDR;
-		request_irq(IRQ_AMIGA_PORTS, esp_intr, SA_SHIRQ,
-			    "Fastlane SCSI", esp_intr);
+		if (request_irq(IRQ_AMIGA_PORTS, esp_intr, SA_SHIRQ,
+				"Fastlane SCSI", esp_intr)) {
+			printk(KERN_WARNING "Fastlane: Could not get IRQ%d, aborting.\n", esp_intr);
+			goto err_unmap;
+		}			
 
 		/* Controller ID */
 		esp->scsi_id = 7;
@@ -188,6 +186,15 @@
 		return esps_in_use;
 	    }
 	}
+	return 0;
+
+ err_unmap:
+	iounmap(board, z->resource.end-board+1);
+ err_unregister:
+	scsi_unregister (esp->ehost);
+ err_release:
+	release_mem_region(board+FASTLANE_ESP_ADDR,
+			   sizeof(struct ESP_regs));
 	return 0;
 }
 

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

"No man is genuinely happy, married, who has to drink worse whiskey than he
used to drink when he was single." H.L. Mencken
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
