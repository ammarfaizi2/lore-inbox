Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132775AbQLHVTN>; Fri, 8 Dec 2000 16:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132756AbQLHVSy>; Fri, 8 Dec 2000 16:18:54 -0500
Received: from grace.speakeasy.org ([216.254.0.2]:41231 "HELO
	grace.speakeasy.org") by vger.kernel.org with SMTP
	id <S132610AbQLHVSn>; Fri, 8 Dec 2000 16:18:43 -0500
Date: Fri, 8 Dec 2000 15:48:45 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
To: <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>
cc: Pete Zaitcev <zaitcev@metabyte.com>, Jaroslav Kysela <perex@suse.cz>
Subject: [PATCH] for ymf_sb (YMF PCI legacy driver)
Message-ID: <Pine.LNX.4.30.0012081536210.4923-100000@fonzie.nine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I just found two serious bugs in the YMF PCI legacy driver (i.e. the
driver that puts it to the Sound Blaster compatible mode).

pci_unregister_driver() was not called from the cleanup routine, which
caused a recoverable oops while running /sbin/lspci.

Also some module parameters were OR'd with 0x03 _after_ shifting them.
Those parameters were ignored while setting up the card.

For example, "modprobe ymf_sb io=0x240" didn't work - it would set up the
card to 0x220 but the sb driver would be told to check 0x240 for the Sound
Blaster.

For your convenience, the patch is also available at
http://www.red-bean.com/~proski/ymf_sb.patch

Regards,
Pavel Roskin

_____________________________
--- linux.orig/drivers/sound/ymf_sb.c
+++ linux/drivers/sound/ymf_sb.c
@@ -436,7 +436,7 @@
 	printk(PFX "set DMA address at 0x%x\n",sb_data[cards].dma);
 #endif

-	v = 0x0000 | ((dma<<6)&0x03) | 0x003f;
+	v = 0x0000 | ((dma & 0x03) << 6) | 0x003f;
 	pci_write_config_word(pcidev, YMFSB_PCIR_LEGCTRL, v);
 #ifdef YMF_DEBUG
 	printk(PFX "LEGCTRL: 0x%x\n",v);
@@ -446,7 +446,9 @@
 	case PCI_DEVICE_ID_YMF740:
 	case PCI_DEVICE_ID_YMF724F:
 	case PCI_DEVICE_ID_YMF740C:
-		v = 0x8800 | ((mpuio<<4)&0x03) | ((sbio<<2)&0x03) | (oplio&0x03);
+		v = 0x8800 | ((mpuio & 0x03) << 4)
+			   | ((sbio & 0x03) << 2)
+			   | (oplio & 0x03);
 		pci_write_config_word(pcidev, YMFSB_PCIR_ELEGCTRL, v);
 #ifdef YMF_DEBUG
 		printk(PFX "ELEGCTRL: 0x%x\n",v);
@@ -843,6 +845,7 @@
 	}

 	free_iomaps();
+	pci_unregister_driver(&ymf7xxsb_driver);

 }

_____________________________

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
