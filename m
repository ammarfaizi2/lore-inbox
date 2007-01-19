Return-Path: <linux-kernel-owner+w=401wt.eu-S932803AbXASA1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932803AbXASA1z (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 19:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932799AbXASA1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 19:27:39 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:62361 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932803AbXASA1c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 19:27:32 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:date:message-id:in-reply-to:references:subject;
        b=a8U26W+KTkFZ4kTS28qgLY/VY6ENqIsyeBJ9cQc07TqjTh7avXvt7pBmjk6rkrn/KqP+zIvNcAqjqjl4aaAzr5pn7OoWERuqzhRgUUmWwPfLzA6e9IxbiFGgqKb4Pcm3fl9KiBzEJ6AAeKyCeGv56GzKHcR1SvIyEwHu9fUX02w=
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Date: Fri, 19 Jan 2007 01:31:31 +0100
Message-Id: <20070119003131.14846.31603.sendpatchset@localhost.localdomain>
In-Reply-To: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>
References: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>
Subject: [PATCH 5/15] hpt34x: hpt34x_tune_chipset() (->speedproc) fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] hpt34x: hpt34x_tune_chipset() (->speedproc) fix

* remember to clear reg2 bits for the current device before setting mode
* remove no longer needed hpt34x_clear_chipset()

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/pci/hpt34x.c |   17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

Index: b/drivers/ide/pci/hpt34x.c
===================================================================
--- a/drivers/ide/pci/hpt34x.c
+++ b/drivers/ide/pci/hpt34x.c
@@ -48,19 +48,6 @@ static u8 hpt34x_ratemask (ide_drive_t *
 	return 1;
 }
 
-static void hpt34x_clear_chipset (ide_drive_t *drive)
-{
-	struct pci_dev *dev	= HWIF(drive)->pci_dev;
-	u32 reg1 = 0, tmp1 = 0, reg2 = 0, tmp2 = 0;
-
-	pci_read_config_dword(dev, 0x44, &reg1);
-	pci_read_config_dword(dev, 0x48, &reg2);
-	tmp1 = ((0x00 << (3*drive->dn)) | (reg1 & ~(7 << (3*drive->dn))));
-	tmp2 = (reg2 & ~(0x11 << drive->dn));
-	pci_write_config_dword(dev, 0x44, tmp1);
-	pci_write_config_dword(dev, 0x48, tmp2);
-}
-
 static int hpt34x_tune_chipset (ide_drive_t *drive, u8 xferspeed)
 {
 	struct pci_dev *dev	= HWIF(drive)->pci_dev;
@@ -81,7 +68,7 @@ static int hpt34x_tune_chipset (ide_driv
 	pci_read_config_dword(dev, 0x44, &reg1);
 	pci_read_config_dword(dev, 0x48, &reg2);
 	tmp1 = ((lo_speed << (3*drive->dn)) | (reg1 & ~(7 << (3*drive->dn))));
-	tmp2 = ((hi_speed << drive->dn) | reg2);
+	tmp2 = ((hi_speed << drive->dn) | (reg2 & ~(0x11 << drive->dn)));
 	pci_write_config_dword(dev, 0x44, tmp1);
 	pci_write_config_dword(dev, 0x48, tmp2);
 
@@ -99,7 +86,6 @@ static int hpt34x_tune_chipset (ide_driv
 static void hpt34x_tune_drive (ide_drive_t *drive, u8 pio)
 {
 	pio = ide_get_best_pio_mode(drive, pio, 5, NULL);
-	hpt34x_clear_chipset(drive);
 	(void) hpt34x_tune_chipset(drive, (XFER_PIO_0 + pio));
 }
 
@@ -117,7 +103,6 @@ static int config_chipset_for_dma (ide_d
 	if (!(speed))
 		return 0;
 
-	hpt34x_clear_chipset(drive);
 	(void) hpt34x_tune_chipset(drive, speed);
 	return ide_dma_enable(drive);
 }
