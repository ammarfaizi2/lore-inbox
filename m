Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263871AbTLOSxE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 13:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263903AbTLOSxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 13:53:04 -0500
Received: from cpe.atm2-0-1071046.0x50a5258e.abnxx8.customer.tele.dk ([80.165.37.142]:58555
	"EHLO starbattle.com") by vger.kernel.org with ESMTP
	id S263871AbTLOSwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 13:52:50 -0500
From: Daniel Tram Lux <daniel@starbattle.com>
Date: Mon, 15 Dec 2003 19:52:47 +0100
To: linux-kernel@vger.kernel.org
Subject: [2.6.0-test11][patch] no DRQ after issuing WRITE
Message-ID: <20031215185247.GA801@starbattle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I had the following problem:


hda: no DRQ after issuing WRITE
ide0: reset: success
hda: status timeout: status=0xd0 { Busy }

hda: no DRQ after issuing WRITE
ide0: reset: success 


the following patch cured this problem...

Regards

Daniel Lux

--- linux-2.6.0-test11.org/drivers/ide/ide-iops.c       2003-10-08 21:24:04.000000000 +0200
+++ linux-2.6.0-test11/drivers/ide/ide-iops.c   2003-12-15 19:36:02.000000000 +0100
@@ -645,12 +645,22 @@
        if ((stat = hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) {
                local_irq_set(flags);
                timeout += jiffies;
-               while ((stat = hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) {
+               stat = hwif->INB(IDE_STATUS_REG);
+               while (stat & BUSY_STAT) {
                        if (time_after(jiffies, timeout)) {
-                               local_irq_restore(flags);
-                               *startstop = DRIVER(drive)->error(drive, "status timeout", stat);
-                               return 1;
+                               /*
+                                * do one more status read in case we were interrupted between last
+                                * stat = hwif->INB(IDE_STATUS_REG) and time_after(jiffies, timeout)
+                                * in wich case the timeout might have been shorter than specified.
+                                */
+                               if ((stat = hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) {
+                                       local_irq_restore(flags);
+                                       *startstop = DRIVER(drive)->error(drive, "status timeout", stat);
+                                       return 1;
+                               }
                        }
+                       else
+                               stat = hwif->INB(IDE_STATUS_REG);
                }
                local_irq_restore(flags);
        }
