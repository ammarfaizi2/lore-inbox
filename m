Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129811AbRAWWLC>; Tue, 23 Jan 2001 17:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129983AbRAWWKw>; Tue, 23 Jan 2001 17:10:52 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:51797
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129811AbRAWWKe>; Tue, 23 Jan 2001 17:10:34 -0500
Date: Tue, 23 Jan 2001 23:10:27 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-apus-devel@lists.sourceforge.net
Subject: Re: [PATCH] make drivers/scsi/fastlane.c check return code of request_irq (241p9)
Message-ID: <20010123231027.E607@jaquet.dk>
In-Reply-To: <20010123003718.K602@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20010123003718.K602@jaquet.dk>; from rasmus@jaquet.dk on Tue, Jan 23, 2001 at 12:37:18AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 23, 2001 at 12:37:18AM +0100, Rasmus Andersen wrote:

Hi.

This is an updated patch since I messed the one from yesterday up. The
comments still apply, though. Apologies for the extra mails.


--- linux-ac10-clean/drivers/scsi/fastlane.c	Mon Oct 16 21:51:16 2000
+++ linux-ac10/drivers/scsi/fastlane.c	Tue Jan 23 22:14:52 2001
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
+			printk(KERN_WARNING "Fastlane: Could not get IRQ%d, aborting.\n", IRQ_AMIGA_PORTS);
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
+	iounmap((void *)address);
+ err_unregister:
+	scsi_unregister (esp->ehost);
+ err_release:
+	release_mem_region(z->resource.start+FASTLANE_ESP_ADDR,
+			   sizeof(struct ESP_regs));
 	return 0;
 }
 

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

"God prevent we should ever be twenty years without a revolution." 
  -- Thomas Jefferson
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
