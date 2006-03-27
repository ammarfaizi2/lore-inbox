Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWC0LBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWC0LBe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 06:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWC0LBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 06:01:34 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:18156 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1750854AbWC0LBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 06:01:33 -0500
Date: Mon, 27 Mar 2006 13:01:32 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-fbdev-devel@lists.sourceforge.net,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: funny framebuffer fonts on PowerBook with radeonfb
Message-ID: <20060327110131.GA16409@MAIL.13thfloor.at>
Mail-Followup-To: "Antonino A. Daplas" <adaplas@gmail.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-fbdev-devel@lists.sourceforge.net,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20060327004741.GA19187@MAIL.13thfloor.at> <44273DBB.9070207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44273DBB.9070207@gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2006 at 09:19:55AM +0800, Antonino A. Daplas wrote:
> Herbert Poetzl wrote:
> > Hey Ben!
> > 
> > 2.6.16 and 2.6.15-something show a funny behaviour
> > when using the radeonfb driver (for text mode), they
> > kind of twist and break the fonts in various places
> > some characters or parts seem to be mirrored like
> > '[' becoming ']' but not on character boundary but
> > more on N pixels, colors seem to be correct for the
> > characters, and sometimes the font is perfectly fine
> > for larger runs, e.g. I can read the logon prompt
> > fine, but everything I type is garbled ...
> > 
> > just for an example, when I type 'echo "Test"' then
> > all characters are mirrored and cut off on the right
> > side but the locations are as shown above, on enter
> > the T is only a few pixels wide, but the est part is
> > written perfectly fine ... this is a new behaviour
> > and going back to 2.6.13.3 doesn't show this ...
> > 
> > if there is some testing I can do for you, or when
> > you need more info, please let me know. here a few
> > details for the machine:
> > 
> 
> What font are you using? I presume the dimensions are
> not divisible by 8.  

precisely!

> Can you try this patch?

yes, I did, and I can confirm this one fixes it for me
thanks a lot for the fast response and the quite
accurate fix!

best,
Herbert

it's obvious, but if you can make use of that:

Acked-by: Herbert Poetzl <herbert@13thfloor.at>

> Tony
> 
> diff --git a/drivers/video/cfbimgblt.c b/drivers/video/cfbimgblt.c
> index 910e233..8ba6152 100644
> --- a/drivers/video/cfbimgblt.c
> +++ b/drivers/video/cfbimgblt.c
> @@ -169,7 +169,7 @@ static inline void slow_imageblit(const 
>  
>  		while (j--) {
>  			l--;
> -			color = (*s & 1 << (FB_BIT_NR(l))) ? fgcolor : bgcolor;
> +			color = (*s & (1 << l)) ? fgcolor : bgcolor;
>  			val |= FB_SHIFT_HIGH(color, shift);
>  			
>  			/* Did the bitshift spill bits to the next long? */
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index 17fc771..4fe1d2d 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -841,12 +841,10 @@ struct fb_info {
>  #define FB_LEFT_POS(bpp)          (32 - bpp)
>  #define FB_SHIFT_HIGH(val, bits)  ((val) >> (bits))
>  #define FB_SHIFT_LOW(val, bits)   ((val) << (bits))
> -#define FB_BIT_NR(b)              (7 - (b))
>  #else
>  #define FB_LEFT_POS(bpp)          (0)
>  #define FB_SHIFT_HIGH(val, bits)  ((val) << (bits))
>  #define FB_SHIFT_LOW(val, bits)   ((val) >> (bits))
> -#define FB_BIT_NR(b)              (b)
>  #endif
>  
>      /*
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
