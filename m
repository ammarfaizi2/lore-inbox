Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271191AbTHCOIZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 10:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271194AbTHCOIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 10:08:25 -0400
Received: from AMarseille-201-1-2-252.w193-253.abo.wanadoo.fr ([193.253.217.252]:4648
	"EHLO gaston") by vger.kernel.org with ESMTP id S271191AbTHCOIX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 10:08:23 -0400
Subject: [PATCH] ppc32: Fix PowerMac mediabay driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059919678.3519.128.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 03 Aug 2003 16:07:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo !

The mediabay driver for PowerMac (hotswap IDE bay) got broken in 2.4.21
by the switch of ide pmac to mmio, this fixes it along with a longstanding
bug where the timeout waiting for the drive to be ready
was actually infinite.

Please apply. Note that proper operations for this driver requires
the other patch I just sent that fixes proper keeping of the "hold"
flag in hwif during ide_unregister() call.

Ben.

diff -urN linux-2.4/drivers/macintosh/mediabay.c linuxppc_benh_devel/drivers/macintosh/mediabay.c
--- linux-2.4/drivers/macintosh/mediabay.c	2003-07-08 10:50:26.000000000 +0200
+++ linuxppc_benh_devel/drivers/macintosh/mediabay.c	2003-08-03 15:12:31.000000000 +0200
@@ -109,7 +109,7 @@
 #ifdef CONFIG_BLK_DEV_IDE
 /* check the busy bit in the media-bay ide interface
    (assumes the media-bay contains an ide device) */
-#define MB_IDE_READY(i)	((inb(media_bays[i].cd_base + 0x70) & 0x80) == 0)
+#define MB_IDE_READY(i)	((readb(media_bays[i].cd_base + 0x70) & 0x80) == 0)
 #endif
 
 /* Note: All delays are not in milliseconds and converted to HZ relative
@@ -577,7 +577,8 @@
 				MBDBG("mediabay %d IDE ready\n", i);
 			}
 			break;
-	    	}
+	    	} else if (bay->timer > 0)
+	    		bay->timer--;
 	    	if (bay->timer == 0) {
 			printk("\nIDE Timeout in bay %d !\n", i);
 			MBDBG("mediabay%d: nIDE Timeout !\n", i);
@@ -756,7 +757,7 @@
 		struct media_bay_info* bay = &media_bays[n];
 		if (!np->parent || np->n_addrs == 0 || !request_OF_resource(np, 0, NULL)) {
 			np = np->next;
-			printk(KERN_ERR "media-bay: Can't request IO resource !\n");
+			printk(KERN_ERR "mediabay: Can't request IO resource !\n");
 			continue;
 		}
 		bay->mb_type = mb_ohare;
@@ -771,7 +772,7 @@
 			bay->mb_type = mb_ohare;
 			bay->ops = &ohare_mb_ops;
 		} else {
-			printk(KERN_ERR "mediabay: Unknown bay type !\n");
+			printk(KERN_ERR "media-bay: Unknown bay type !\n");
 			np = np->next;
 			continue;
 		}
@@ -782,7 +783,7 @@
 			MB_BIS(bay, KEYLARGO_MBCR, KL_MBCR_MB0_ENABLE);
 #ifdef MB_USE_INTERRUPTS
 		if (np->n_intrs == 0) {
-			printk(KERN_ERR "media bay %d has no irq\n",n);
+			printk(KERN_ERR "media-bay %d has no irq\n",n);
 			np = np->next;
 			continue;
 		}
@@ -823,8 +824,9 @@
 		pmu_register_sleep_notifier(&mb_sleep_notifier);
 #endif /* CONFIG_PMAC_PBOOK */
 
-		kernel_thread(media_bay_task, NULL,
-			      CLONE_FS | CLONE_FILES | CLONE_SIGHAND);
+		if (kernel_thread(media_bay_task, NULL,
+			      CLONE_FS | CLONE_FILES | CLONE_SIGHAND) < 0)
+			printk(KERN_ERR "media-bay: Cannot create polling thread !\n");
 	}
 }
 

