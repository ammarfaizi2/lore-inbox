Return-Path: <linux-kernel-owner+w=401wt.eu-S1751111AbXADRWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbXADRWr (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 12:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbXADRWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 12:22:47 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56739 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751111AbXADRWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 12:22:46 -0500
Date: Thu, 4 Jan 2007 17:32:49 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: [PATCH] hpt37x: Two important bug fixes
Message-ID: <20070104173249.08d0ef41@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The HPT37x driver very carefully handles DMA completions and the needed
fixups are done on pci registers 0x50 and 0x52. This is unfortunate
because the actual registers are 0x50 and 0x54. Fixing this offset cures
the second channel problems reported.

Secondly there are some problems with the HPT370 and certain ATA drives.
The filter code however only filters ATAPI devices due to a
reversed type check.

Signed-off-by: Alan Cox <alan@redhat.com>


--- linux.vanilla-2.6.20-rc3/drivers/ata/pata_hpt37x.c	2007-01-01 21:43:27.000000000 +0000
+++ linux-2.6.20-rc3/drivers/ata/pata_hpt37x.c	2007-01-04 15:03:26.071994728 +0000
@@ -25,7 +25,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt37x"
-#define DRV_VERSION	"0.5.1"
+#define DRV_VERSION	"0.5.2"
 
 struct hpt_clock {
 	u8	xfer_speed;
@@ -416,7 +416,7 @@
 
 static unsigned long hpt370_filter(const struct ata_port *ap, struct ata_device *adev, unsigned long mask)
 {
-	if (adev->class != ATA_DEV_ATA) {
+	if (adev->class == ATA_DEV_ATA) {
 		if (hpt_dma_blacklisted(adev, "UDMA", bad_ata33))
 			mask &= ~ATA_MASK_UDMA;
 		if (hpt_dma_blacklisted(adev, "UDMA100", bad_ata100_5))
@@ -749,7 +749,7 @@
 {
 	struct ata_port *ap = qc->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	int mscreg = 0x50 + 2 * ap->port_no;
+	int mscreg = 0x50 + 4 * ap->port_no;
 	u8 bwsr_stat, msc_stat;
 
 	pci_read_config_byte(pdev, 0x6A, &bwsr_stat);
