Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUGLTVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUGLTVI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 15:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUGLTVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 15:21:08 -0400
Received: from mail.ccur.com ([208.248.32.212]:23044 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S261375AbUGLTVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 15:21:00 -0400
Date: Mon, 12 Jul 2004 15:20:59 -0400
From: Joe Korty <joe.korty@ccur.com>
To: akpm@osdl.org, marcelo.tosatti@cyclades.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.[46] Fix double reset in aic7xxx driver
Message-ID: <20040712192059.GA7660@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix occasional PCI bus parity errors on the Dell PowerEdge 4600 during
boot.

Symptoms: The LCD display would turn orange and display "PCI SYSTEM
E13F5", and the following message would appear in /var/log/dmesg:
"Uhhuh. NMI received. Dazed and confused, but trying to continue".

By inserting a PCI card with a PDC20268 IDE controller and attaching to
that a Sony DRU-510A DVD RW burner with an unloaded tray, the failure
can be made to happen on every boot.

Cause: The aic7xxx driver was resetting the onboard AIC7891 SCSI controller
while waiting for a previous reset to complete.  This second reset confuses
the controller causing it to put bad data onto the PCI bus.

This is a backport of a RedHat 2.4.21-15.ELsmp fix.  A letter discussing
this problem, or one very close to it, may be found at:

   http://lists.us.dell.com/pipermail/linux-poweredge/2003-May/025010.html

Against 2.6.7 and 2.4.26.

Regards,
Joe


diff -ura base/drivers/scsi/aic7xxx/aic79xx_pci.c new/drivers/scsi/aic7xxx/aic79xx_pci.c
--- base/drivers/scsi/aic7xxx/aic79xx_pci.c	2004-06-16 01:19:22.000000000 -0400
+++ new/drivers/scsi/aic7xxx/aic79xx_pci.c	2004-07-12 12:50:11.000000000 -0400
@@ -452,8 +452,10 @@
 	 * or read prefetching could be initiated by the
 	 * CPU or host bridge.  Our device does not support
 	 * either, so look for data corruption and/or flaged
-	 * PCI errors.
+	 * PCI errors.  First pause without causing another
+	 * chip reset.
 	 */
+	hcntrl &= ~CHIPRST;
 	ahd_outb(ahd, HCNTRL, hcntrl|PAUSE);
 	while (ahd_is_paused(ahd) == 0)
 		;
diff -ura base/drivers/scsi/aic7xxx/aic7xxx_pci.c new/drivers/scsi/aic7xxx/aic7xxx_pci.c
--- base/drivers/scsi/aic7xxx/aic7xxx_pci.c	2004-06-16 01:18:57.000000000 -0400
+++ new/drivers/scsi/aic7xxx/aic7xxx_pci.c	2004-07-12 12:50:11.000000000 -0400
@@ -1284,8 +1284,10 @@
 	 * or read prefetching could be initiated by the
 	 * CPU or host bridge.  Our device does not support
 	 * either, so look for data corruption and/or flagged
-	 * PCI errors.
+	 * PCI errors.  First pause without causing another
+	 * chip reset.
 	 */
+	hcntrl &= ~CHIPRST;
 	ahc_outb(ahc, HCNTRL, hcntrl|PAUSE);
 	while (ahc_is_paused(ahc) == 0)
 		;

