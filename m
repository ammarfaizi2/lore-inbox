Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263236AbTJPVmX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 17:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTJPVmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 17:42:22 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:58082 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263236AbTJPVj7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 17:39:59 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Torben Mathiasen <torben.mathiasen@hp.com>,
       Tomas Szepe <szepe@pinerecords.com>
Subject: [RFT][PATCH] fix ServerWorks PIO auto-tuning
Date: Thu, 16 Oct 2003 23:44:09 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310162344.09021.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I wonder if this patch fixes problems (reported back in 2.4.21 days)
with CSB5 IDE and Compaq Proliant machines.  Please test it if you can.

thanks,
--bartlomiej

[IDE] fix ServerWorks PIO auto-tuning

If PIO mode should be auto-tuned xferspeed argument for svwks_tune_chipset()
is equal to 255 (0xFF).  It is then passed to ide_rate_filter() which matches
desired mode with chipset capabilities.  Since 255 is greater than any of the
values used for transfer modes, ide_rate_filter() will always return the
highest mode supported by both device/chipset (which sometimes should not be
used ie. when host is a simplex one) and the wrong mode will be set.

 drivers/ide/pci/serverworks.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

diff -puN drivers/ide/pci/serverworks.c~ide-serverworks-fix drivers/ide/pci/serverworks.c
--- linux-2.6.0-test7/drivers/ide/pci/serverworks.c~ide-serverworks-fix	2003-10-16 23:03:11.844836632 +0200
+++ linux-2.6.0-test7-root/drivers/ide/pci/serverworks.c	2003-10-16 23:36:01.068469136 +0200
@@ -272,7 +272,7 @@ static int svwks_tune_chipset (ide_drive
 
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
-	u8 speed		= ide_rate_filter(svwks_ratemask(drive), xferspeed);
+	u8 speed;
 	u8 pio			= ide_get_best_pio_mode(drive, 255, 5, NULL);
 	u8 unit			= (drive->select.b.unit & 0x01);
 	u8 csb5			= svwks_csb_check(dev);
@@ -280,6 +280,11 @@ static int svwks_tune_chipset (ide_drive
 	u8 dma_timing		= 0, pio_timing = 0;
 	u16 csb5_pio		= 0;
 
+	if (xferspeed == 255)	/* PIO auto-tuning */
+		speed = XFER_PIO_0 + pio;
+	else
+		speed = ide_rate_filter(svwks_ratemask(drive), xferspeed);
+
 	/* If we are about to put a disk into UDMA mode we screwed up.
 	   Our code assumes we never _ever_ do this on an OSB4 */
 	   

_

