Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265866AbUBJM75 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 07:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265865AbUBJM75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 07:59:57 -0500
Received: from witte.sonytel.be ([80.88.33.193]:6030 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265856AbUBJM7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 07:59:52 -0500
Date: Tue, 10 Feb 2004 13:59:40 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: Linux 2.6.3-rc2
In-Reply-To: <Pine.LNX.4.58.0402091914040.2128@home.osdl.org>
Message-ID: <Pine.GSO.4.58.0402101352320.2261@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0402091914040.2128@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Feb 2004, Linus Torvalds wrote:
> Bartlomiej Zolnierkiewicz:
>   o fix duplication of DMA {black,white}list in icside.c

| --- linux-2.6.2/include/linux/ide.h~ide_dma_drive_lists	2004-02-04 16:27:52.778869912 +0100
| +++ linux-2.6.2-root/include/linux/ide.h	2004-02-04 16:27:52.787868544 +0100
| @@ -1626,6 +1626,10 @@ extern void ide_setup_pci_devices(struct
|  #define BAD_DMA_DRIVE		0
|  #define GOOD_DMA_DRIVE		1
|
| +#ifdef CONFIG_BLK_DEV_IDEDMA
| +int __ide_dma_bad_drive(ide_drive_t *);
| +int __ide_dma_good_drive(ide_drive_t *);
| +
|  #ifdef CONFIG_BLK_DEV_IDEDMA_PCI
|  extern int ide_build_sglist(ide_drive_t *, struct request *);
|  extern int ide_raw_build_sglist(ide_drive_t *, struct request *);
| @@ -1647,8 +1651,6 @@ extern int __ide_dma_write(ide_drive_t *
|  extern int __ide_dma_begin(ide_drive_t *);
|  extern int __ide_dma_end(ide_drive_t *);
|  extern int __ide_dma_test_irq(ide_drive_t *);
| -extern int __ide_dma_bad_drive(ide_drive_t *);
| -extern int __ide_dma_good_drive(ide_drive_t *);
|  extern int __ide_dma_count(ide_drive_t *);
|  extern int __ide_dma_verbose(ide_drive_t *);
|  extern int __ide_dma_retune(ide_drive_t *);
| @@ -1677,6 +1679,8 @@ static inline int __ide_dma_queued_off(i
|  static inline void ide_release_dma(ide_hwif_t *drive) {;}
|  #endif
|
| +#endif /* CONFIG_BLK_DEV_IDEDMA */
| +
|  extern int ide_hwif_request_regions(ide_hwif_t *hwif);
|  extern void ide_hwif_release_regions(ide_hwif_t* hwif);
|  extern void ide_unregister (unsigned int index);

This change makes compilation fail if CONFIG_BLK_DEV_IDEDMA is not set (e.g. on
m68k), because the dummy ide_release_dma() is no longer defined:

| drivers/ide/ide.c: In function `ide_unregister':
| drivers/ide/ide.c:768: warning: implicit declaration of function `ide_release_dma'

This patch fixes that, but I'm not sure it's 100% correct.

--- linux-2.6.3-rc2/include/linux/ide.h	2004-02-10 11:15:26.000000000 +0100
+++ linux-m68k-2.6.3-rc2/include/linux/ide.h	2004-02-10 13:45:35.000000000 +0100
@@ -1635,10 +1635,10 @@
 extern ide_startstop_t __ide_dma_queued_start(ide_drive_t *drive);
 #endif

-#else
-static inline void ide_release_dma(ide_hwif_t *drive) {;}
 #endif

+#else
+static inline void ide_release_dma(ide_hwif_t *drive) {;}
 #endif /* CONFIG_BLK_DEV_IDEDMA */

 extern int ide_hwif_request_regions(ide_hwif_t *hwif);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
