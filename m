Return-Path: <linux-kernel-owner+w=401wt.eu-S1751375AbXAFMWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbXAFMWp (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 07:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbXAFMWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 07:22:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:51326 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbXAFMWo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 07:22:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=q4SEcJsiy2VMQS65/cukTI5FbmaIRdGPMcSX2n5feXMMw8/M05E6iS6ovf42zdB71zWB3pfFVqtmSRVwRojseDso88j7MycwVwTNxfwmLarq9RNxgjjO4GsIg6vB8TBs51/0sFgJiWplywlgfUTBIAgW/kv2lJkdAaQ8cjVKk24=
Message-ID: <5767b9100701060422p1abd1d21x606b758220815551@mail.gmail.com>
Date: Sat, 6 Jan 2007 20:22:43 +0800
From: "Conke Hu" <conke.hu@gmail.com>
To: "Linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Greg KH" <greg@kroah.com>
Subject: [PATCH 3/3] atiixp.c: add cable detection support for ATI IDE
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IDE HDD does not work if it uses a 40-pin PATA cable on ATI chipset.
This patch fixes the bug.

Signed-off-by: Conke Hu <conke.hu@amd.com>
-----------------------
--- linux-2.6.20-rc3-git4/drivers/ide/pci/atiixp.c.2	2007-01-06
19:19:35.000000000 +0800
+++ linux-2.6.20-rc3-git4/drivers/ide/pci/atiixp.c	2007-01-06
19:22:34.000000000 +0800
@@ -289,8 +289,12 @@ fast_ata_pio:

 static void __devinit init_hwif_atiixp(ide_hwif_t *hwif)
 {
+	u8 udma_mode = 0;
+	u8 ch = hwif->channel;
+	struct pci_dev *pdev = hwif->pci_dev;
+
 	if (!hwif->irq)
-		hwif->irq = hwif->channel ? 15 : 14;
+		hwif->irq = ch ? 15 : 14;

 	hwif->autodma = 0;
 	hwif->tuneproc = &atiixp_tuneproc;
@@ -306,8 +310,12 @@ static void __devinit init_hwif_atiixp(i
 	hwif->mwdma_mask = 0x06;
 	hwif->swdma_mask = 0x04;

-	/* FIXME: proper cable detection needed */
-	hwif->udma_four = 1;
+	pci_read_config_byte(pdev, ATIIXP_IDE_UDMA_MODE + ch, &udma_mode);
+	if ((udma_mode & 0x07) >= 0x04 || (udma_mode & 0x70) >= 0x40)
+		hwif->udma_four = 1;
+	else
+		hwif->udma_four = 0;
+
 	hwif->ide_dma_host_on = &atiixp_ide_dma_host_on;
 	hwif->ide_dma_host_off = &atiixp_ide_dma_host_off;
 	hwif->ide_dma_check = &atiixp_dma_check;
