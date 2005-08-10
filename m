Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965076AbVHJLMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965076AbVHJLMO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 07:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965068AbVHJLMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 07:12:14 -0400
Received: from witte.sonytel.be ([80.88.33.193]:16878 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S965069AbVHJLMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 07:12:12 -0400
Date: Wed, 10 Aug 2005 13:11:53 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christoph Lameter <clameter@sgi.com>, Linus Torvalds <torvalds@osdl.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix ide-disk.c oops caused by hwif == NULL
In-Reply-To: <200508100459.j7A4xTn7016128@hera.kernel.org>
Message-ID: <Pine.LNX.4.62.0508101310300.18940@numbat.sonytel.be>
References: <200508100459.j7A4xTn7016128@hera.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Aug 2005, Linux Kernel Mailing List wrote:
> tree 518f62158f0923573decb8f072ac7282fb7575cb
> parent aeb3f76350e78aba90653b563de6677b442d21d6
> author Christoph Lameter <christoph@lameter.com> Wed, 10 Aug 2005 09:59:21 -0700
> committer Linus Torvalds <torvalds@g5.osdl.org> Wed, 10 Aug 2005 10:21:31 -0700
> 
> [PATCH] Fix ide-disk.c oops caused by hwif == NULL

How can this patch fix that? It still dereferences hwif without checking for a
NULL pointer.

> 1. Move hwif_to_node to ide.h
> 
> 2. Use hwif_to_node in ide-disk.c
> 
> Signed-off-by: Christoph Lameter <clameter@sgi.com>
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
>  drivers/ide/ide-disk.c  |    2 +-
>  drivers/ide/ide-probe.c |    9 ---------
>  include/linux/ide.h     |    6 ++++++
>  3 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
> --- a/drivers/ide/ide-disk.c
> +++ b/drivers/ide/ide-disk.c
> @@ -1220,7 +1220,7 @@ static int ide_disk_probe(struct device 
>  		goto failed;
>  
>  	g = alloc_disk_node(1 << PARTN_BITS,
> -			pcibus_to_node(drive->hwif->pci_dev->bus));
> +			hwif_to_node(drive->hwif));
>  	if (!g)
>  		goto out_free_idkp;
>  
> diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
> --- a/drivers/ide/ide-probe.c
> +++ b/drivers/ide/ide-probe.c
> @@ -960,15 +960,6 @@ static void save_match(ide_hwif_t *hwif,
>  }
>  #endif /* MAX_HWIFS > 1 */
>  
> -static inline int hwif_to_node(ide_hwif_t *hwif)
> -{
> -	if (hwif->pci_dev)
> -		return pcibus_to_node(hwif->pci_dev->bus);
> -	else
> -		/* Add ways to determine the node of other busses here */
> -		return -1;
> -}
> -
>  /*
>   * init request queue
>   */
> diff --git a/include/linux/ide.h b/include/linux/ide.h
> --- a/include/linux/ide.h
> +++ b/include/linux/ide.h
> @@ -1501,4 +1501,10 @@ extern struct bus_type ide_bus_type;
>  #define ide_id_has_flush_cache_ext(id)	\
>  	(((id)->cfs_enable_2 & 0x2400) == 0x2400)
>  
> +static inline int hwif_to_node(ide_hwif_t *hwif)
> +{
> +	struct pci_dev *dev = hwif->pci_dev;
                              ^^^^^^^^^^^^^
> +	return dev ? pcibus_to_node(dev->bus) : -1;
> +}
> +
>  #endif /* _IDE_H */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
