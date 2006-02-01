Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWBAKeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWBAKeX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 05:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWBAKeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 05:34:23 -0500
Received: from uproxy.gmail.com ([66.249.92.200]:53519 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932397AbWBAKeW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 05:34:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ae+Ogy9tIsMwNO/3yodbvlpi47Pxi1b+TA34E0VCIQqqQ/4AuNBGLqj/bvpjrBhuXuGfRaXsl1kYfXW0/NgqQLjbMXb5Ihz8EKamIS6uADjHlDL++krpPB4ktNmBSohucWRjGbgLLGE2P+GPTBalgT+LdTIXTYxZE6fW1oLoTxU=
Message-ID: <58cb370e0602010234p62521a00h6d8920c84cac44d5@mail.gmail.com>
Date: Wed, 1 Feb 2006 11:34:18 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jes Sorensen <jes@sgi.com>
Subject: Re: [patch] SGIIOC4 limit request size
Cc: Alan Cox <alan@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Jeremy Higdon <jeremy@sgi.com>
In-Reply-To: <yq0vevzpi8r.fsf@jaguar.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <yq0vevzpi8r.fsf@jaguar.mkp.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 Feb 2006 03:59:16 -0500, Jes Sorensen <jes@sgi.com> wrote:
> Hi,

Hi,

> This one takes care of a problem with the SGI IOC4 driver where it
> hits DMA problems if the request grows too large.

Does this happen only for CONFIG_IA64_PAGE_SIZE_4KB=y
or CONFIG_IA64_PAGE_SIZE_8KB=y?

from sgiioc4.c:

/* Each Physical Region Descriptor Entry size is 16 bytes (2 * 64 bits) */
/* IOC4 has only 1 IDE channel */
#define IOC4_PRD_BYTES       16
#define IOC4_PRD_ENTRIES     (PAGE_SIZE /(4*IOC4_PRD_BYTES))

As limiting request size to 127 sectors punishes performance
wouldn't it be better to define IOC4_PRD_ENTRIES to 256
if this is possible (would need 4 pages for PAGE_SIZE=4096
and 2 for PAGE_SIZE=8192)?

Cheers.
Bartlomiej

> Cheers,
> Jes
>
> Avoid requests larger than the number of SG table entries, to avoid
> DMA timeouts.
>
> Signed-off-by: Jes Sorensen <jes@sgi.com>
>
> ----
>
>  drivers/ide/pci/sgiioc4.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletion(-)
>
> Index: linux-2.6/drivers/ide/pci/sgiioc4.c
> ===================================================================
> --- linux-2.6.orig/drivers/ide/pci/sgiioc4.c
> +++ linux-2.6/drivers/ide/pci/sgiioc4.c
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (c) 2003 Silicon Graphics, Inc.  All Rights Reserved.
> + * Copyright (C) 2003, 2006 Silicon Graphics, Inc.  All Rights Reserved.
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of version 2 of the GNU General Public License
> @@ -613,6 +613,12 @@
>         hwif->ide_dma_lostirq = &sgiioc4_ide_dma_lostirq;
>         hwif->ide_dma_timeout = &__ide_dma_timeout;
>         hwif->INB = &sgiioc4_INB;
> +
> +       /*
> +        * Limit the request size to avoid DMA timeouts when
> +        * requesting  more entries than goes in the sg table.
> +        */
> +       hwif->rqsize = 127;
>  }
>
>  static int __devinit
