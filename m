Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbTICNtS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 09:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbTICNtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 09:49:17 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:60657 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262365AbTICNs7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 09:48:59 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: LBA48 on PDC20265 (again and again...)
Date: Wed, 3 Sep 2003 15:49:52 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <BFC117A6765@vcnet.vc.cvut.cz> <200309031520.49352.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200309031520.49352.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309031549.52113.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 of September 2003 15:20, Bartlomiej Zolnierkiewicz wrote:
> Hi,
>
> There was a recent threads on this issue:
> "IDE bug - was: Re: uncorrectable ext2 errors"
> and "Promise IDE patches".
>
> One of conclusions was that there is no reason not to enable LBA48
> on PDC20265.  I will send Jan's patches to Linus.  Thanks for verifying
> this.

I've just sent patch removing these 2 lines to Linus and actually I was
thinking about Ross Biro's patch when writing this.  Can you test?


ide: fix for Promise 20265/20267 PIO Lockup

Orginal patch by Ross Biro:

Newer kernels will lock up when a drive command (SMART, hdparm -I, etc.)
is issued to a drive connected to a Promise 20265 or 20267 controller
while the controller is in DMA mode.  The problem appears to be that
tune_chipset incorrectly clears the high PIO bit thinking that it is a
"PIO force on" bit.  The documentation I have access to does not seem to
mention a PIO force bit.  Not changing that bit seems to fix the problem
with drive commands on a promise controller.

The documentation I have also says the values for the TB and TC
variables should be the same for all UDMA modes and they are not.
However the driver seems to work anyway, so I left them the way they are.

To reproduce this problem make sure your drive is set to a DMA mode, eg
hdparm -X 67 and then issue a drive command, e.g. hdparm -I.

This problem may also be present in the drivers for other Promise chips.

This change has only been minimally tested.

 drivers/ide/pci/pdc202xx_old.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletion(-)

diff -puN drivers/ide/pci/pdc202xx_old.c~ide-pdc-old-lockup drivers/ide/pci/pdc202xx_old.c
--- linux-2.6.0-test4-bk3/drivers/ide/pci/pdc202xx_old.c~ide-pdc-old-lockup	2003-09-03 15:28:07.872200152 +0200
+++ linux-2.6.0-test4-bk3-root/drivers/ide/pci/pdc202xx_old.c	2003-09-03 15:32:46.011916488 +0200
@@ -271,7 +271,15 @@ static int pdc202xx_tune_chipset (ide_dr
 		if ((BP & 0xF0) && (CP & 0x0F)) {
 			/* clear DMA modes of upper 842 bits of B Register */
 			/* clear PIO forced mode upper 1 bit of B Register */
-			pci_write_config_byte(dev, (drive_pci)|0x01, BP &~0xF0);
+			/*
+			 * The documentation I have access to says there
+			 * is no PIO forced mode bit. -- RAB 01/10/03
+			 */
+			if (dev->device == PCI_DEVICE_ID_PROMISE_20265 ||
+			    dev->device == PCI_DEVICE_ID_PROMISE_20267)
+				pci_write_config_byte(dev, (drive_pci)|0x01, BP &~0xE0);
+			else
+				pci_write_config_byte(dev, (drive_pci)|0x01, BP &~0xF0);
 			pci_read_config_byte(dev, (drive_pci)|0x01, &BP);
 
 			/* clear DMA modes of lower 8421 bits of C Register */

_

