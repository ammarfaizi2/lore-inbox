Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270309AbUJTMQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270309AbUJTMQd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 08:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270122AbUJTMMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 08:12:20 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:16902 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S267668AbUJTMKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 08:10:03 -0400
Date: Wed, 20 Oct 2004 14:09:30 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.6.9-rc4-mm1: compile error with BLK_DEV_IDEDMA=n
Message-ID: <20041020120930.GA14071@stusta.de>
References: <20041011032502.299dc88d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041011032502.299dc88d.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 03:25:02AM -0700, Andrew Morton wrote:
>...
> All 741 patches
>...
> bk-ide-dev.patch
>...


This patch causes the following compile error with 
CONFIG_BLK_DEV_IDEDMA=n:


<--  snip  -->

...
  CC      drivers/ide/ide-lib.o
drivers/ide/ide-lib.c: In function `ide_use_dma':
drivers/ide/ide-lib.c:78: warning: implicit declaration of function `__ide_dma_bad_drive'
drivers/ide/ide-lib.c:96: warning: implicit declaration of function `__ide_dma_good_drive'
...
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x26c4bf): In function `ide_use_dma':
: undefined reference to `__ide_dma_bad_drive'
drivers/built-in.o(.text+0x26c50c): In function `ide_use_dma':
: undefined reference to `__ide_dma_good_drive'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


The following patch fixes this problem:


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.9-rc4-mm1/include/linux/ide.h	2004-10-20 13:29:37.000000000 +0200
+++ linux-2.6.9-rc4-mm1-full/include/linux/ide.h	2004-10-20 13:26:54.000000000 +0200
@@ -1534,8 +1534,13 @@
 	hwif->hwif_data = data;
 }
 
+
 /* ide-lib.c */
+
+#ifdef CONFIG_BLK_DEV_IDEDMA
 int ide_use_dma(ide_drive_t *);
+#endif
+
 extern u8 ide_dma_speed(ide_drive_t *drive, u8 mode);
 extern u8 ide_rate_filter(u8 mode, u8 speed); 
 extern int ide_dma_enable(ide_drive_t *drive);
--- linux-2.6.9-rc4-mm1-full/drivers/ide/ide-lib.c.old	2004-10-20 02:02:13.000000000 +0200
+++ linux-2.6.9-rc4-mm1-full/drivers/ide/ide-lib.c	2004-10-20 13:26:20.000000000 +0200
@@ -69,6 +69,7 @@
 
 EXPORT_SYMBOL(ide_xfer_verbose);
 
+#ifdef CONFIG_BLK_DEV_IDEDMA
 int ide_use_dma(ide_drive_t *drive)
 {
 	struct hd_driveid *id = drive->id;
@@ -100,6 +101,7 @@
 }
 
 EXPORT_SYMBOL_GPL(ide_use_dma);
+#endif /* CONFIG_BLK_DEV_IDEDMA */
 
 /**
  *	ide_dma_speed	-	compute DMA speed


