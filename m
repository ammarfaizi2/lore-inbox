Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263999AbTICQUL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 12:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbTICQSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 12:18:50 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:34188 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263896AbTICQRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 12:17:49 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jens Axboe <axboe@suse.de>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <1062605698.1780.33.camel@gaston>
References: <1062605698.1780.33.camel@gaston>
Message-Id: <1062605863.1780.35.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 03 Sep 2003 18:17:43 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: [PATCH] IDE: Enable LED support for PowerMac
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-03 at 18:14, Benjamin Herrenschmidt wrote:
> Hi Bart !
> 
> Please submit that to Linus. It adds the Kconfig option for the
> PowerMac IDE driver "LED" feature (using the laptop's front LED
> as a disk activity indicator). It also adds a small bit to ide-probe.c
> that was missing from Jens patch when he added the activity function
> infrastructure. He did add the hwif field, but not the code to actually
> enable it.

OOOps, the patch had additional crap appended to it, here's a cleaned
up version, sorry:


diff -urN for-linus-ppc/drivers/ide/Kconfig linuxppc-2.5-benh/drivers/ide/Kconfig
--- for-linus-ppc/drivers/ide/Kconfig	2003-09-03 18:07:14.000000000 +0200
+++ linuxppc-2.5-benh/drivers/ide/Kconfig	2003-08-25 22:04:14.000000000 +0200
@@ -835,6 +835,13 @@
 	  to transfer data to and from memory.  Saying Y is safe and improves
 	  performance.
 
+config BLK_DEV_IDE_PMAC_BLINK
+	bool "Blink laptop LED on drive activity"
+	depends on BLK_DEV_IDE_PMAC && ADB_PMU
+	help
+	  This option enables the use of the sleep LED as a hard drive
+	  activity LED.
+
 config BLK_DEV_IDEDMA_PMAC_AUTO
 	bool "Use DMA by default"
 	depends on BLK_DEV_IDEDMA_PMAC
diff -urN for-linus-ppc/drivers/ide/ide-probe.c linuxppc-2.5-benh/drivers/ide/ide-probe.c
--- for-linus-ppc/drivers/ide/ide-probe.c	2003-09-03 18:07:14.000000000 +0200
+++ linuxppc-2.5-benh/drivers/ide/ide-probe.c	2003-09-03 18:05:12.000000000 +0200
@@ -958,6 +958,10 @@
 	/* needs drive->queue to be set */
 	ide_toggle_bounce(drive, 1);
 
+	/* enable led activity for disk drives only */
+	if (drive->media == ide_disk && hwif->led_act)
+		blk_queue_activity_fn(q, hwif->led_act, drive);
+
 	return 0;
 }
 


