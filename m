Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281290AbRKLH2w>; Mon, 12 Nov 2001 02:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281294AbRKLH2m>; Mon, 12 Nov 2001 02:28:42 -0500
Received: from main.sonytel.be ([195.0.45.167]:34938 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S281290AbRKLH2g>;
	Mon, 12 Nov 2001 02:28:36 -0500
Date: Mon, 12 Nov 2001 08:27:48 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Bakonyi Ferenc <fero@drama.obuda.kando.hu>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hgafb oopses
In-Reply-To: <Pine.LNX.4.40.0111091302580.16816-100000@drama.koli>
Message-ID: <Pine.GSO.4.21.0111120822550.11251-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Nov 2001, Bakonyi Ferenc wrote:
> Somebody submitted a patch against 2.4.13 which broke hgafb. That patch
> called isa_memset() and isa_writeb() with an _already_ mapped address.
> So that address was mapped twice -> oops.

Sorry... Anyway, the old code was broken too, since it wasn't portable.

(Why did no one told me? I did receive an additional patch to make hgafb work
 again after I posted the first version to linux-kernel, which I did
 incorporate in the final version).

> The patch below is against 2.4.15-pre1. It resolves the ISA address
> confusion, replaces scr_{read|write} functions with isa_{read|write},
> and elimiates a cosmetic compiler warning about suggested parens.

But it does some other Bad Things(TM): putting ISA memory _adresses_ and
_16_bit_ values in _unsigned_chars_ is not good for your health...

> --- linux-2.4.15-pre1/drivers/video/hgafb.c	Fri Nov  9 12:22:42 2001
> +++ linux/drivers/video/hgafb.c	Fri Nov  9 12:26:33 2001
> @@ -312,10 +312,10 @@
>  static int __init hga_card_detect(void)
>  {
>  	int count=0;
> -	u16 *p, p_save;
> -	u16 *q, q_save;
> +	unsigned char p, p_save;
> +	unsigned char q, q_save;
        ^^^^^^^^^^^^^
>
> -	hga_vram_base = VGA_MAP_MEM(0xb0000);
> +	hga_vram_base = 0xb0000;
>  	hga_vram_len  = 0x08000;
>
>  	if (request_region(0x3b0, 12, "hgafb"))
> @@ -325,14 +325,14 @@
>
>  	/* do a memory check */
>
> -	p = (u16 *) hga_vram_base;
> -	q = (u16 *) (hga_vram_base + 0x01000);
> +	p = hga_vram_base;
> +	q = hga_vram_base + 0x01000;
>
> -	p_save = scr_readw(p); q_save = scr_readw(q);
> +	p_save = isa_readw(p); q_save = isa_readw(q);
>
> -	scr_writew(0xaa55, p); if (scr_readw(p) == 0xaa55) count++;
> -	scr_writew(0x55aa, p); if (scr_readw(p) == 0x55aa) count++;
> -	scr_writew(p_save, p);
> +	isa_writew(0xaa55, p); if (isa_readw(p) == 0xaa55) count++;
> +	isa_writew(0x55aa, p); if (isa_readw(p) == 0x55aa) count++;
> +	isa_writew(p_save, p);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

