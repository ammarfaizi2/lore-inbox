Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267553AbUHYOUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267553AbUHYOUa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 10:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267576AbUHYOUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 10:20:30 -0400
Received: from smtp07.web.de ([217.72.192.225]:12525 "EHLO smtp07.web.de")
	by vger.kernel.org with ESMTP id S267553AbUHYOUU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 10:20:20 -0400
Message-ID: <412CA001.70502@web.de>
Date: Wed, 25 Aug 2004 16:19:45 +0200
From: Artyom Tarasenko <alt-x@web.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040421
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, andre@linux-ide.org
Subject: [patch] getting back udma3 on BX chipset for 2.4.27
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

some time between 2.4.18 and 2.4.22 the support of udma3 (aka UDMA-44) 
was lost. Here is a trivial patch to get it back (if someone is 
interested I can make it cleaner). Having IBM-DTLA-307030 and SAMSUNG 
SV1604N drives I got significant advantage of using udma3 (23M/s vs 30M/s).

Regards,
Artyom Tarasenko.

--- drivers/ide/ide-lib.orig.c  Wed Aug 25 14:47:42 2004
+++ drivers/ide/ide-lib.c       Wed Aug 25 14:59:29 2004
@@ -107,6 +107,10 @@
                        if ((id->dma_ultra & 0x0008) &&
                            (id->dma_ultra & hwif->ultra_mask))
                                { speed = XFER_UDMA_3; break; }
+                case 0x05:
+                        if ((id->dma_ultra & 0x0008) &&
+                            (id->dma_ultra & hwif->ultra_mask))
+                                { speed = XFER_UDMA_3; break; }
                case 0x01:
                        if ((id->dma_ultra & 0x0004) &&
                            (id->dma_ultra & hwif->ultra_mask))
@@ -161,13 +165,13 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA
        static u8 speed_max[] = {
                XFER_MW_DMA_2, XFER_UDMA_2, XFER_UDMA_4,
-               XFER_UDMA_5, XFER_UDMA_6
+               XFER_UDMA_5, XFER_UDMA_6,XFER_UDMA_3
        };
 
 //     printk("%s: mode 0x%02x, speed 0x%02x\n", __FUNCTION__, mode, 
speed);
 
        /* So that we remember to update this if new modes appear */
-       if (mode > 4)
+       if (mode > 5)
                BUG();
        return min(speed, speed_max[mode]);
 #else /* !CONFIG_BLK_DEV_IDEDMA */

--- drivers/ide/pci/piix.orig.c Sun Aug  8 01:26:04 2004
+++ drivers/ide/pci/piix.c      Wed Aug 25 16:15:49 2004
@@ -301,8 +301,11 @@
                case PCI_DEVICE_ID_INTEL_82372FB_1:
                        mode = 2;
                        break;
-               /* UDMA 33 capable */
+               /* UDMA 44 capable */
                case PCI_DEVICE_ID_INTEL_82371AB:
+                       mode = 5;
+                       break;
+               /* UDMA 33 capable */
                case PCI_DEVICE_ID_INTEL_82443MX_1:
                case PCI_DEVICE_ID_INTEL_82451NX:
                case PCI_DEVICE_ID_INTEL_82801AB_1:

