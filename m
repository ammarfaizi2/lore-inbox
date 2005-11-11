Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbVKKKOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbVKKKOL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 05:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbVKKKOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 05:14:11 -0500
Received: from nproxy.gmail.com ([64.233.182.204]:28405 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751261AbVKKKOK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 05:14:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s0LsvF4a5p8CX1zElRlKrzsmt80wOE0HKcLvr5q67rIGX5N51xBxDshHx96sNtmMjT4wSQym1gWeoPTGZQaFyy0g555Z9iVcxQJD+Mf1dlN/uy1GUTZjdtBrUxVa9gFLx5SWBwXQ6TA71Gdw0ZzTI8tLodjyTazI4zQKtS5Ny9Q=
Message-ID: <58cb370e0511110214i33792f33y1b44410d3006fd5f@mail.gmail.com>
Date: Fri, 11 Nov 2005 11:14:08 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH 14/15] misc: Configurable number of supported IDE interfaces
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <15.282480653@selenic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <14.282480653@selenic.com> <15.282480653@selenic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You are duplicating functionality of CONFIG_IDE_MAX_HWIFS,
please find a way to use it for EMBEDDED.

Also please cc: linux-ide on IDE related patches.

On 11/11/05, Matt Mackall <mpm@selenic.com> wrote:
> Configurable number of supported IDE interfaces
>
> This overrides the default limit (which may be set per arch with
> CONFIG_IDE_MAX_HWIFS). This is the result of setting interfaces to 1:
>
>    text    data     bss     dec     hex filename
> 3330172  529036  190556 4049764  3dcb64 vmlinux-baseline
> 3329352  528928  172124 4030404  3d7fc4 vmlinux
>
> Signed-off-by: Matt Mackall <mpm@selenic.com>
>
> Index: 2.6.14-misc/drivers/ide/setup-pci.c
> ===================================================================
> --- 2.6.14-misc.orig/drivers/ide/setup-pci.c    2005-10-27 17:02:08.000000000 -0700
> +++ 2.6.14-misc/drivers/ide/setup-pci.c 2005-11-09 11:27:23.000000000 -0800
> @@ -102,7 +102,7 @@ static ide_hwif_t *ide_match_hwif(unsign
>                                 return hwif;    /* pick an unused entry */
>                 }
>         }
> -       for (h = 0; h < 2; ++h) {
> +       for (h = 0; h < 2 && h < MAX_HWIFS; ++h) {
>                 hwif = ide_hwifs + h;
>                 if (hwif->chipset == ide_unknown)
>                         return hwif;    /* pick an unused entry */
> Index: 2.6.14-misc/include/linux/ide.h
> ===================================================================
> --- 2.6.14-misc.orig/include/linux/ide.h        2005-11-01 10:54:33.000000000 -0800
> +++ 2.6.14-misc/include/linux/ide.h     2005-11-09 11:27:23.000000000 -0800
> @@ -309,6 +309,11 @@ static inline void ide_init_hwif_ports(h
>  }
>  #endif /* IDE_ARCH_OBSOLETE_INIT */
>
> +#if defined(CONFIG_IDE_HWIFS) && CONFIG_IDE_HWIFS > 0
> +#undef MAX_HWIFS
> +#define MAX_HWIFS CONFIG_IDE_HWIFS
> +#endif
> +
>  /* Currently only m68k, apus and m8xx need it */
>  #ifndef IDE_ARCH_ACK_INTR
>  # define ide_ack_intr(hwif) (1)
> Index: 2.6.14-misc/init/Kconfig
> ===================================================================
> --- 2.6.14-misc.orig/init/Kconfig       2005-11-09 11:27:20.000000000 -0800
> +++ 2.6.14-misc/init/Kconfig    2005-11-09 11:27:23.000000000 -0800
> @@ -457,6 +457,15 @@ config CC_ALIGN_JUMPS
>           no dummy operations need be executed.
>           Zero means use compiler's default.
>
> +config IDE_HWIFS
> +       depends IDE
> +       int "Number of IDE hardware interfaces (0 for default)" if EMBEDDED
> +       range 0 20
> +       default 0
> +       help
> +         Select the maximum number of IDE interfaces (0 for default).
> +          Saves up to 14k.
> +
>  endmenu                # General setup
>
>  config TINY_SHMEM
