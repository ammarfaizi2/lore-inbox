Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbUKHJ4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbUKHJ4N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 04:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbUKHJ4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 04:56:13 -0500
Received: from witte.sonytel.be ([80.88.33.193]:41676 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261704AbUKHJ4A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 04:56:00 -0500
Date: Mon, 8 Nov 2004 10:55:44 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: Fix IO access in rivafb
In-Reply-To: <200411081706.55261.adaplas@hotpop.com>
Message-ID: <Pine.GSO.4.61.0411081053520.4130@waterleaf.sonytel.be>
References: <200411080521.iA85LbG6025914@hera.kernel.org>
 <1099893447.10262.154.camel@gaston> <200411081706.55261.adaplas@hotpop.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Nov 2004, Antonino A. Daplas wrote:
> On Monday 08 November 2004 13:57, Benjamin Herrenschmidt wrote:
> > You probably broke ppc versions here. The driver enables "big endian"
> > register access, but readw/writew/l functions do byteswap, which will
> > lead to incorrect results.
> >
> > The fix would be to probably just remove the code that puts the chip
> > registers into big endian mode, this isn't necessary nor a very good
> > idea actually.
> >
> 
> How about this patch?  This is almost the original macro in riva_hw.h,
> with the __force annotation.
> 
> Signed-off-by: Antonino Daplas <adaplas@pol.net>
> ---
> 
> diff -Nru a/drivers/video/riva/riva_hw.h b/drivers/video/riva/riva_hw.h
> --- a/drivers/video/riva/riva_hw.h	2004-11-06 12:42:19 +08:00
> +++ b/drivers/video/riva/riva_hw.h	2004-11-08 16:59:34 +08:00
> @@ -77,14 +77,18 @@
>  #include <asm/io.h>
>  #define NV_WR08(p,i,d)	out_8(p+i, d)
>  #define NV_RD08(p,i)	in_8(p+i)
> +#define NV_WR16(p,i,d)  (((volatile u16 __force *)(p))[(i)/2]=(d))
> +#define NV_RD16(p,i)    (((volatile u16 __force *)(p))[(i)/2])
> +#define NV_WR32(p,i,d)  (((volatile u32 __force *)(p))[(i)/4]=(d))
> +#define NV_RD32(p,i)    (((volatile u32 __force *)(p))[(i)/4])
>  #else
>  #define NV_WR08(p,i,d)  (writeb((d), (u8 __iomem *)(p) + (i)))
>  #define NV_RD08(p,i)    (readb((u8 __iomem *)(p) + (i)))
> -#endif
>  #define NV_WR16(p,i,d)  (writew((d), (u16 __iomem *)(p) + (i)/2))
>  #define NV_RD16(p,i)    (readw((u16 __iomem *)(p) + (i)/2))
>  #define NV_WR32(p,i,d)  (writel((d), (u32 __iomem *)(p) + (i)/4))
>  #define NV_RD32(p,i)    (readl((u32 __iomem *)(p) + (i)/4))
> +#endif
>  #define VGA_WR08(p,i,d) NV_WR08(p,i,d)
>  #define VGA_RD08(p,i)   NV_RD08(p,i)

PPC also has nice {out,in}_be{16,32}() operations.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
