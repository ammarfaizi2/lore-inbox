Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265923AbUBJOyb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 09:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265925AbUBJOyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 09:54:31 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:35539 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265923AbUBJOyT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 09:54:19 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.3-rc2
Date: Tue, 10 Feb 2004 15:58:59 +0100
User-Agent: KMail/1.5.3
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
References: <Pine.LNX.4.58.0402091914040.2128@home.osdl.org> <Pine.GSO.4.58.0402101352320.2261@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.58.0402101352320.2261@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402101558.59344.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 of February 2004 13:59, Geert Uytterhoeven wrote:
> On Mon, 9 Feb 2004, Linus Torvalds wrote:
> > Bartlomiej Zolnierkiewicz:
> >   o fix duplication of DMA {black,white}list in icside.c
> >
> | --- linux-2.6.2/include/linux/ide.h~ide_dma_drive_lists	2004-02-04
> | 16:27:52.778869912 +0100 +++
> | linux-2.6.2-root/include/linux/ide.h	2004-02-04 16:27:52.787868544 +0100
> | @@ -1626,6 +1626,10 @@ extern void ide_setup_pci_devices(struct
> |  #define BAD_DMA_DRIVE		0
> |  #define GOOD_DMA_DRIVE		1
> |
> | +#ifdef CONFIG_BLK_DEV_IDEDMA
> | +int __ide_dma_bad_drive(ide_drive_t *);
> | +int __ide_dma_good_drive(ide_drive_t *);
> | +
> |  #ifdef CONFIG_BLK_DEV_IDEDMA_PCI
> |  extern int ide_build_sglist(ide_drive_t *, struct request *);
> |  extern int ide_raw_build_sglist(ide_drive_t *, struct request *);
> | @@ -1647,8 +1651,6 @@ extern int __ide_dma_write(ide_drive_t *
> |  extern int __ide_dma_begin(ide_drive_t *);
> |  extern int __ide_dma_end(ide_drive_t *);
> |  extern int __ide_dma_test_irq(ide_drive_t *);
> | -extern int __ide_dma_bad_drive(ide_drive_t *);
> | -extern int __ide_dma_good_drive(ide_drive_t *);
> |  extern int __ide_dma_count(ide_drive_t *);
> |  extern int __ide_dma_verbose(ide_drive_t *);
> |  extern int __ide_dma_retune(ide_drive_t *);
> | @@ -1677,6 +1679,8 @@ static inline int __ide_dma_queued_off(i
> |  static inline void ide_release_dma(ide_hwif_t *drive) {;}
> |  #endif
> |
> | +#endif /* CONFIG_BLK_DEV_IDEDMA */
> | +
> |  extern int ide_hwif_request_regions(ide_hwif_t *hwif);
> |  extern void ide_hwif_release_regions(ide_hwif_t* hwif);
> |  extern void ide_unregister (unsigned int index);
>
> This change makes compilation fail if CONFIG_BLK_DEV_IDEDMA is not set
> (e.g. on

Doh.

> m68k), because the dummy ide_release_dma() is no longer defined:
> | drivers/ide/ide.c: In function `ide_unregister':
> | drivers/ide/ide.c:768: warning: implicit declaration of function
> | `ide_release_dma'
>
> This patch fixes that, but I'm not sure it's 100% correct.

It is not ;-), it will break for CONFIG_BLK_DEV_IDEDMA_{ICSIDE,PMAC}=y.

> --- linux-2.6.3-rc2/include/linux/ide.h	2004-02-10 11:15:26.000000000 +0100
> +++ linux-m68k-2.6.3-rc2/include/linux/ide.h	2004-02-10 13:45:35.000000000
> +0100 @@ -1635,10 +1635,10 @@
>  extern ide_startstop_t __ide_dma_queued_start(ide_drive_t *drive);
>  #endif
>
> -#else
> -static inline void ide_release_dma(ide_hwif_t *drive) {;}
>  #endif
>
> +#else
> +static inline void ide_release_dma(ide_hwif_t *drive) {;}
>  #endif /* CONFIG_BLK_DEV_IDEDMA */
>
>  extern int ide_hwif_request_regions(ide_hwif_t *hwif);

Here is a correct one, Linus please apply:

[PATCH] fix build for CONFIG_BLK_DEV_IDEDMA=n

"fix duplication of DMA {black,white}list in icside.c" patch broke it.

Noticed by Geert Uytterhoeven <geert@linux-m68k.org>.

 linux-2.6.3-rc1-bk1-root/include/linux/ide.h |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff -puN include/linux/ide.h~ide_release_dma_fix include/linux/ide.h
--- linux-2.6.3-rc1-bk1/include/linux/ide.h~ide_release_dma_fix	2004-02-10 15:47:05.478683288 +0100
+++ linux-2.6.3-rc1-bk1-root/include/linux/ide.h	2004-02-10 15:48:14.888131448 +0100
@@ -1634,13 +1634,12 @@ extern ide_startstop_t __ide_dma_queued_
 extern ide_startstop_t __ide_dma_queued_write(ide_drive_t *drive);
 extern ide_startstop_t __ide_dma_queued_start(ide_drive_t *drive);
 #endif
+#endif /* CONFIG_BLK_DEV_IDEDMA */
 
-#else
+#ifndef CONFIG_BLK_DEV_IDEDMA_PCI
 static inline void ide_release_dma(ide_hwif_t *drive) {;}
 #endif
 
-#endif /* CONFIG_BLK_DEV_IDEDMA */
-
 extern int ide_hwif_request_regions(ide_hwif_t *hwif);
 extern void ide_hwif_release_regions(ide_hwif_t* hwif);
 extern void ide_unregister (unsigned int index);

_


