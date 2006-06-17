Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbWFQV1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWFQV1q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 17:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbWFQV1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 17:27:46 -0400
Received: from 1wt.eu ([62.212.114.60]:48136 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1750938AbWFQV1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 17:27:45 -0400
Date: Sat, 17 Jun 2006 23:26:12 +0200
From: Willy Tarreau <w@1wt.eu>
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-kernel@vger.kernel.org, marcelo@kvack.org
Subject: Re: [PATCH 2.4.33-rc1] repair __ide_dma_no_op breakage
Message-ID: <20060617212612.GA25600@1wt.eu>
References: <200606172047.k5HKlrUU002902@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606172047.k5HKlrUU002902@harpo.it.uu.se>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikael,

On Sat, Jun 17, 2006 at 10:47:53PM +0200, Mikael Pettersson wrote:
> On Fri, 16 Jun 2006 15:14:19 -0300, Marcelo Tosatti wrote:
> >Summary of changes from v2.4.33-pre3 to v2.4.33-rc1
> ...
> >Willy TARREAU:
> ...
> >      ide: trying to enable DMA may cause an oops
> 
> This patch to ide-dma.c defines a function 'int __ide_dma_no_op(void)'
> and stores its address in function pointer fields with type
> 'int (*)(ide_drive_t*)'. Thus callers will call __ide_dma_no_op() with
> more parameters than it expects.
>
> This is invalid C and it will break horribly in some valid calling
> conventions (in particular, when parameters are passed on the stack
> and the callee not the caller pops them).

I 100% agree with your analysis and you fix, but just out of curiosity,
when could we encounter such circumstances ? On specific archs or when
functions are declared in a certain manner ? I've always learned that
in C, it's always the caller which pops, reason why var args are possible
and the args type checking is very loose.

> Furtunately the fix is simple: just define __ide_dma_no_op() with
> the correct prototype (taking an unused ide_drive_t* parameter),
> and drop the now redundant casts from the assignments. Also make
> __ide_dma_no_op() 'static' as it is local to ide-dma.c.

Thank you very much, I've queued it in -upstream. Marcelo, I've updated
the URL, please use http://git.1wt.eu/linux-2.4-upstream.git as of now.

Cheers,
Willy

> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
> 
> diff -rupN linux-2.4.33-rc1/drivers/ide/ide-dma.c linux-2.4.33-rc1.ide-dma-no-op-fix/drivers/ide/ide-dma.c
> --- linux-2.4.33-rc1/drivers/ide/ide-dma.c	2006-06-17 17:58:36.000000000 +0200
> +++ linux-2.4.33-rc1.ide-dma-no-op-fix/drivers/ide/ide-dma.c	2006-06-17 18:12:31.000000000 +0200
> @@ -572,7 +572,7 @@ static int dma_timer_expiry (ide_drive_t
>   *	This empty function prevents non-DMA controllers from causing an oops.
>   */
>  
> -int __ide_dma_no_op (void)
> +static int __ide_dma_no_op (ide_drive_t *ignored)
>  {
>  	return 0;
>  }
> @@ -1235,11 +1235,11 @@ EXPORT_SYMBOL_GPL(ide_setup_dma);
>  void ide_setup_no_dma (ide_hwif_t *hwif)
>  {
>  	if (!hwif->ide_dma_off_quietly)
> -		hwif->ide_dma_off_quietly = (int (*)(ide_drive_t *))&__ide_dma_no_op;
> +		hwif->ide_dma_off_quietly = &__ide_dma_no_op;
>  	if (!hwif->ide_dma_host_off)
> -		hwif->ide_dma_host_off = (int (*)(ide_drive_t *))&__ide_dma_no_op;
> +		hwif->ide_dma_host_off = &__ide_dma_no_op;
>  	if (!hwif->ide_dma_host_on)
> -		hwif->ide_dma_host_on = (int (*)(ide_drive_t *))&__ide_dma_no_op;
> +		hwif->ide_dma_host_on = &__ide_dma_no_op;
>  }
>  
>  EXPORT_SYMBOL_GPL(ide_setup_no_dma);
