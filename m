Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266255AbUBQPeO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 10:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266256AbUBQPeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 10:34:14 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:24741 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266255AbUBQPeF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 10:34:05 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Martin Diehl <lists@mdiehl.de>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.3-rc4
Date: Tue, 17 Feb 2004 16:39:54 +0100
User-Agent: KMail/1.5.3
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0402170946140.31216-100000@notebook.home.mdiehl.de>
In-Reply-To: <Pine.LNX.4.44.0402170946140.31216-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402171639.54791.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 of February 2004 09:54, Martin Diehl wrote:
> On Mon, 16 Feb 2004, Linus Torvalds wrote:
> > Bartlomiej Zolnierkiewicz:
> >   o make __ide_dma_off() generic and remove ide_hwif_t->ide_dma_off
>
> doesn't build for me:
>
> drivers/built-in.o(.text+0x3aa33): In function `set_using_dma':
> : undefined reference to `__ide_dma_off'
>
> drivers/built-in.o(.text+0x401bc): In function `check_dma_crc':
> : undefined reference to `__ide_dma_off'
>
> make: *** [.tmp_vmlinux1] Error 1

Thanks for spotting this, here's a fix (Linus, please apply).
As a bonus it should decrease your kernel's size by a few bytes ;-).

[PATCH] fix build with CONFIG_BLK_DEV_IDEDMA=n (once again)

My "__ide_dma_off()" cleanup uncovered some code that shouldn't be compiled
when CONFIG_BLK_DEV_IDEDMA=n.  Fix it and kill a warning in setup-pci.c.

Noticed by Martin Diehl <lists@mdiehl.de>.

 linux-2.6.3-rc3-root/drivers/ide/ide-iops.c  |    7 ++++---
 linux-2.6.3-rc3-root/drivers/ide/ide.c       |    4 ++++
 linux-2.6.3-rc3-root/drivers/ide/setup-pci.c |    3 +++
 linux-2.6.3-rc3-root/include/linux/ide.h     |    3 +++
 4 files changed, 14 insertions(+), 3 deletions(-)

diff -puN drivers/ide/ide.c~ide_dma_off_fix drivers/ide/ide.c
--- linux-2.6.3-rc3/drivers/ide/ide.c~ide_dma_off_fix	2004-02-17 15:49:14.572521328 +0100
+++ linux-2.6.3-rc3-root/drivers/ide/ide.c	2004-02-17 15:51:12.985519816 +0100
@@ -1320,6 +1320,7 @@ static int set_io_32bit(ide_drive_t *dri
 
 static int set_using_dma (ide_drive_t *drive, int arg)
 {
+#ifdef CONFIG_BLK_DEV_IDEDMA
 	if (!drive->id || !(drive->id->capability & 1))
 		return -EPERM;
 	if (HWIF(drive)->ide_dma_check == NULL)
@@ -1332,6 +1333,9 @@ static int set_using_dma (ide_drive_t *d
 			return -EIO;
 	}
 	return 0;
+#else
+	return -EPERM;
+#endif
 }
 
 static int set_pio_mode (ide_drive_t *drive, int arg)
diff -puN drivers/ide/ide-iops.c~ide_dma_off_fix drivers/ide/ide-iops.c
--- linux-2.6.3-rc3/drivers/ide/ide-iops.c~ide_dma_off_fix	2004-02-17 15:51:33.898340584 +0100
+++ linux-2.6.3-rc3-root/drivers/ide/ide-iops.c	2004-02-17 15:59:43.264945552 +0100
@@ -1125,16 +1125,17 @@ static ide_startstop_t reset_pollfunc (i
 	return ide_stopped;
 }
 
-void check_dma_crc (ide_drive_t *drive)
+static void check_dma_crc(ide_drive_t *drive)
 {
+#ifdef CONFIG_BLK_DEV_IDEDMA
 	if (drive->crc_count) {
 		(void) HWIF(drive)->ide_dma_off_quietly(drive);
 		ide_set_xfer_rate(drive, ide_auto_reduce_xfer(drive));
 		if (drive->current_speed >= XFER_SW_DMA_0)
 			(void) HWIF(drive)->ide_dma_on(drive);
-	} else {
+	} else
 		(void)__ide_dma_off(drive);
-	}
+#endif
 }
 
 void pre_reset (ide_drive_t *drive)
diff -puN drivers/ide/setup-pci.c~ide_dma_off_fix drivers/ide/setup-pci.c
--- linux-2.6.3-rc3/drivers/ide/setup-pci.c~ide_dma_off_fix	2004-02-17 16:08:16.775880024 +0100
+++ linux-2.6.3-rc3-root/drivers/ide/setup-pci.c	2004-02-17 16:09:58.969344256 +0100
@@ -150,6 +150,8 @@ static int ide_setup_pci_baseregs (struc
 	return 0;
 }
 
+#ifdef CONFIG_BLK_DEV_IDEDMA_PCI
+
 #ifdef CONFIG_BLK_DEV_IDEDMA_FORCED
 /*
  * Long lost data from 2.0.34 that is now in 2.0.39
@@ -279,6 +281,7 @@ second_chance_to_dma:
 	}
 	return dma_base;
 }
+#endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
 
 void ide_setup_pci_noise (struct pci_dev *dev, ide_pci_device_t *d)
 {
diff -puN include/linux/ide.h~ide_dma_off_fix include/linux/ide.h
--- linux-2.6.3-rc3/include/linux/ide.h~ide_dma_off_fix	2004-02-17 16:19:28.044831632 +0100
+++ linux-2.6.3-rc3-root/include/linux/ide.h	2004-02-17 16:26:07.364125872 +0100
@@ -1626,6 +1626,9 @@ extern ide_startstop_t __ide_dma_queued_
 extern ide_startstop_t __ide_dma_queued_write(ide_drive_t *drive);
 extern ide_startstop_t __ide_dma_queued_start(ide_drive_t *drive);
 #endif
+
+#else
+static inline int __ide_dma_off(ide_drive_t *drive) { return 0; }
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 
 #ifndef CONFIG_BLK_DEV_IDEDMA_PCI

_

