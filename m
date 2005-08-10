Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965035AbVHJIFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965035AbVHJIFF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 04:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965043AbVHJIFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 04:05:05 -0400
Received: from nproxy.gmail.com ([64.233.182.203]:52190 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965035AbVHJIFE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 04:05:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=peRh4sKWik9RCjo/rhhi1stpGSfE6SjyhfKbZIox9ebmLafMGd7kxOHC73qb3QiNikYhuV7VerHdVOZopSSkmS1rdD6tlHucCJZNDMpNr+DGSzI1LYJJS/976umPY9vPq1bsZD/2O8+iAtLfId3nWdvvjAkx4A6phgzAWpXCMyM=
Message-ID: <58cb370e0508100105b03b3ec@mail.gmail.com>
Date: Wed, 10 Aug 2005 10:05:00 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Christoph Lameter <christoph@lameter.com>
Subject: Re: [PATCH] ide-disk oopses on boot
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org,
       kiran@scalex86.org, torvalds@osdl.org, akpm@osdl.org
In-Reply-To: <Pine.LNX.4.62.0508091953270.30717@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050809132725.GA20397@vana.vc.cvut.cz>
	 <Pine.LNX.4.62.0508090926150.12719@graphe.net>
	 <42F92A1F.9040901@vc.cvut.cz>
	 <Pine.LNX.4.62.0508091953270.30717@graphe.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why have you removed me from cc:?

On 8/10/05, Christoph Lameter <christoph@lameter.com> wrote:
> On Wed, 10 Aug 2005, Petr Vandrovec wrote:
> 
> > > Yes that was discussed extensively by Andi and me and finally fixed by
> > > Kiran's patch in 2.6.13-rc6.
> >
> > By which patch?  I hit it with post-2.6.13-rc6, exactly 2.6.13-rc6 with
> > checkin hash "commit 00dd1e433967872f3997a45d5adf35056fdf2f56".  So if it is
> > supposed to be fixed in 2.6.13-rc6, it is not.
> 
> Yes you are right there is one additional place where pcibus_to_node is
> used with the hwif that we did not cover. This better go into 2.6.13.

Yes.

> ---
> Fix ide-disk.c oops caused by hwif == NULL

This description is wrong, should be: hwif->pci_dev == NULL

> 1. Move hwif_to_node to ide.h
> 
> 2. Use hwif_to_node in ide-disk.c
> 
> Signed-off-by: Christoph Lameter <clameter@sgi.com>
> 
> Index: linux-2.6/drivers/ide/ide-disk.c
> ===================================================================
> --- linux-2.6.orig/drivers/ide/ide-disk.c       2005-07-27 18:29:17.000000000 -0700
> +++ linux-2.6/drivers/ide/ide-disk.c    2005-08-09 19:55:03.000000000 -0700
> @@ -1220,7 +1220,7 @@
>                 goto failed;
> 
>         g = alloc_disk_node(1 << PARTN_BITS,
> -                       pcibus_to_node(drive->hwif->pci_dev->bus));
> +                       hwif_to_node(drive->hwif));
>         if (!g)
>                 goto out_free_idkp;
> 
> Index: linux-2.6/drivers/ide/ide-probe.c
> ===================================================================
> --- linux-2.6.orig/drivers/ide/ide-probe.c      2005-08-04 15:47:15.000000000 -0700
> +++ linux-2.6/drivers/ide/ide-probe.c   2005-08-09 19:46:50.000000000 -0700
> @@ -960,15 +960,6 @@
>  }
>  #endif /* MAX_HWIFS > 1 */
> 
> -static inline int hwif_to_node(ide_hwif_t *hwif)
> -{
> -       if (hwif->pci_dev)
> -               return pcibus_to_node(hwif->pci_dev->bus);
> -       else
> -               /* Add ways to determine the node of other busses here */
> -               return -1;
> -}
> -
>  /*
>   * init request queue
>   */
> Index: linux-2.6/include/linux/ide.h
> ===================================================================
> --- linux-2.6.orig/include/linux/ide.h  2005-07-27 18:29:23.000000000 -0700
> +++ linux-2.6/include/linux/ide.h       2005-08-09 19:47:14.000000000 -0700
> @@ -1501,4 +1501,13 @@
>  #define ide_id_has_flush_cache_ext(id) \
>         (((id)->cfs_enable_2 & 0x2400) == 0x2400)
> 
> +static inline int hwif_to_node(ide_hwif_t *hwif)
> +{
> +       if (hwif->pci_dev)
> +               return pcibus_to_node(hwif->pci_dev->bus);
> +       else
> +               /* Add ways to determine the node of other busses here */
> +               return -1;
> +}
> +
>  #endif /* _IDE_H */
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
