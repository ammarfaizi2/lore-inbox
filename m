Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266989AbSLWWWT>; Mon, 23 Dec 2002 17:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266991AbSLWWWT>; Mon, 23 Dec 2002 17:22:19 -0500
Received: from smtp.hotbox.ru ([80.68.244.50]:64013 "EHLO smtp.hotbox.ru")
	by vger.kernel.org with ESMTP id <S266989AbSLWWWS>;
	Mon, 23 Dec 2002 17:22:18 -0500
Date: Tue, 24 Dec 2002 01:35:19 +0300
From: Nikolai Zhubr <s001@hotbox.ru>
Message-ID: <1876003973.20021224013519@hotbox.ru>
To: linux-kernel@vger.kernel.org
CC: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] 2.4.20/drivers/ide/pdc202xx.c
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this patch fixes misdetection of 80-pin vs 40-pin IDE cable
connected to Promise 202xx IDE controller (kernel 2.4.20). The original
code used hwif->dma_base field which is yet unset upon the call,
therefore some random value was returned. The patch came out of reading
2.5.xx code. I've tested it with both 40pin and 80pin cables, pdc20276
controller. I'm not subscribed, please CC me if necessary. Thank you.

diff -u --recursive linux-2.4.20/drivers/ide/pdc202xx.c linux-2.4.20-zh/drivers/ide/pdc202xx.c
--- linux-2.4.20/drivers/ide/pdc202xx.c Sat Aug  3 04:39:44 2002
+++ linux-2.4.20-zh/drivers/ide/pdc202xx.c      Mon Dec 23 21:32:53 2002
@@ -1121,6 +1121,10 @@
 {
        unsigned short mask = (hwif->channel) ? (1<<11) : (1<<10);
        unsigned short CIS;
+       struct pci_dev *dev     = hwif->pci_dev;
+       unsigned long high_16   = pci_resource_start(dev, 4);
+       unsigned long indexreg  = high_16 + (hwif->channel ? 0x09 : 0x01);
+       unsigned long datareg   = (indexreg + 2);
 
                switch(hwif->pci_dev->device) {
                case PCI_DEVICE_ID_PROMISE_20276:
@@ -1128,8 +1132,8 @@
                case PCI_DEVICE_ID_PROMISE_20269:
                case PCI_DEVICE_ID_PROMISE_20268:
                case PCI_DEVICE_ID_PROMISE_20270:
-                       OUT_BYTE(0x0b, (hwif->dma_base + 1));
-                       return (!(IN_BYTE((hwif->dma_base + 3)) & 0x04));
+                       OUT_BYTE(0x0b, indexreg);
+                       return (!(IN_BYTE(datareg) & 0x04));
                        /* check 80pin cable */
                default:
                        pci_read_config_word(hwif->pci_dev, 0x50, &CIS);
-- 
Best regards,
 Nikolai Zhubr


