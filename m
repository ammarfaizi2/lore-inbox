Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265960AbUF3KWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265960AbUF3KWh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 06:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266577AbUF3KWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 06:22:37 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:56591 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S265960AbUF3KWe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 06:22:34 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: linville@redhat.com (John Linville)
Subject: Re: i810_audio MMIO patch
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Organization: Core
In-Reply-To: <200406292031.i5TKVgbX023358@savage.devel.redhat.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.26-1-686-smp (i686))
Message-Id: <E1BfcEI-0006y4-00@gondolin.me.apana.org.au>
Date: Wed, 30 Jun 2004 20:22:14 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Linville <linville@redhat.com> wrote:
> 
> @@ -452,12 +452,34 @@ struct i810_card {
> /* extract register offset from codec struct */
> #define IO_REG_OFF(codec) (((struct i810_card *) codec->private_data)->ac97_id_map[codec->id])
> 
> -#define GET_CIV(port) MODULOP2(inb((port) + OFF_CIV), SG_LEN)
> -#define GET_LVI(port) MODULOP2(inb((port) + OFF_LVI), SG_LEN)
> +#define I810_IOREAD(size, type, card, off)                             \
> +({                                                                     \
> +       type val;                                                       \
> +       if (card->use_mmio) val=read##size(card->iobase_mmio+off);      \
> +       else val=in##size(card->iobase+off);                            \
> +       val;                                                            \
> +})

Please indent I810_IOWRITE and this like normal code.
 
> @@ -716,9 +738,9 @@ static inline unsigned i810_get_dma_addr

How about making card a local variable where it's used over and over again
as in this function?

> @@ -2798,7 +2819,8 @@ static int i810_ac97_power_up_bus(struct
>         *      before we start doing DMA stuff
>         */     
>        /* see i810_ac97_init for the next 7 lines (jsaw) */
> -       inw(card->ac97base);
> +       if (card->use_mmio) readw(card->ac97base_mmio);
> +       else inw(card->ac97base);

Please indent these ones too.

> @@ -3141,6 +3162,11 @@ static int __devinit i810_probe(struct p
>                }
>        }
> 
> +       if (!(card->use_mmio) && !(card->iobase)) {
> +               printk(KERN_ERR "i810_audio: No I/O resources available.\n");
> +               goto out_mem;
> +       }
> +

To be safe we should check card->ac97base as well.

Otherwise the patch looks good.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
