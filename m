Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265911AbUBJPTB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 10:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265918AbUBJPTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 10:19:01 -0500
Received: from witte.sonytel.be ([80.88.33.193]:63372 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265911AbUBJPSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 10:18:54 -0500
Date: Tue, 10 Feb 2004 16:18:49 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: Linux 2.6.3-rc2
In-Reply-To: <200402101558.59344.bzolnier@elka.pw.edu.pl>
Message-ID: <Pine.GSO.4.58.0402101617370.2261@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0402091914040.2128@home.osdl.org>
 <Pine.GSO.4.58.0402101352320.2261@waterleaf.sonytel.be>
 <200402101558.59344.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Feb 2004, Bartlomiej Zolnierkiewicz wrote:
> On Tuesday 10 of February 2004 13:59, Geert Uytterhoeven wrote:
> > On Mon, 9 Feb 2004, Linus Torvalds wrote:
> > > Bartlomiej Zolnierkiewicz:
> > >   o fix duplication of DMA {black,white}list in icside.c
> > This change makes compilation fail if CONFIG_BLK_DEV_IDEDMA is not set
> > (e.g. on
>
> Doh.
>
> > m68k), because the dummy ide_release_dma() is no longer defined:
> > | drivers/ide/ide.c: In function `ide_unregister':
> > | drivers/ide/ide.c:768: warning: implicit declaration of function
> > | `ide_release_dma'
> >
> > This patch fixes that, but I'm not sure it's 100% correct.
>
> It is not ;-), it will break for CONFIG_BLK_DEV_IDEDMA_{ICSIDE,PMAC}=y.
>
> > --- linux-2.6.3-rc2/include/linux/ide.h	2004-02-10 11:15:26.000000000 +0100
> > +++ linux-m68k-2.6.3-rc2/include/linux/ide.h	2004-02-10 13:45:35.000000000
> > +0100 @@ -1635,10 +1635,10 @@
> >  extern ide_startstop_t __ide_dma_queued_start(ide_drive_t *drive);
> >  #endif
> >
> > -#else
> > -static inline void ide_release_dma(ide_hwif_t *drive) {;}
> >  #endif
> >
> > +#else
> > +static inline void ide_release_dma(ide_hwif_t *drive) {;}
> >  #endif /* CONFIG_BLK_DEV_IDEDMA */
> >
> >  extern int ide_hwif_request_regions(ide_hwif_t *hwif);
>
> Here is a correct one, Linus please apply:
>
> [PATCH] fix build for CONFIG_BLK_DEV_IDEDMA=n
>
> "fix duplication of DMA {black,white}list in icside.c" patch broke it.
>
> Noticed by Geert Uytterhoeven <geert@linux-m68k.org>.
>
>  linux-2.6.3-rc1-bk1-root/include/linux/ide.h |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
>
> diff -puN include/linux/ide.h~ide_release_dma_fix include/linux/ide.h
> --- linux-2.6.3-rc1-bk1/include/linux/ide.h~ide_release_dma_fix	2004-02-10 15:47:05.478683288 +0100
> +++ linux-2.6.3-rc1-bk1-root/include/linux/ide.h	2004-02-10 15:48:14.888131448 +0100
> @@ -1634,13 +1634,12 @@ extern ide_startstop_t __ide_dma_queued_
>  extern ide_startstop_t __ide_dma_queued_write(ide_drive_t *drive);
>  extern ide_startstop_t __ide_dma_queued_start(ide_drive_t *drive);
>  #endif
> +#endif /* CONFIG_BLK_DEV_IDEDMA */
>
> -#else
> +#ifndef CONFIG_BLK_DEV_IDEDMA_PCI
>  static inline void ide_release_dma(ide_hwif_t *drive) {;}
>  #endif
>
> -#endif /* CONFIG_BLK_DEV_IDEDMA */
> -
>  extern int ide_hwif_request_regions(ide_hwif_t *hwif);
>  extern void ide_hwif_release_regions(ide_hwif_t* hwif);
>  extern void ide_unregister (unsigned int index);

It fails with `unterminated `#if' conditional'.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
