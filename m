Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753132AbWKCS7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753132AbWKCS7O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 13:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753422AbWKCS7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 13:59:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58510 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753132AbWKCS7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 13:59:13 -0500
Date: Fri, 3 Nov 2006 10:58:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Franck <vagabon.xyz@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       adaplas@pol.net, gregkh@suse.de
Subject: Re: [PATCH] fbcon: Re-fix little-endian bogosity in
 slow_imageblit()
Message-Id: <20061103105857.874f566c.akpm@osdl.org>
In-Reply-To: <454B5866.6000207@innova-card.com>
References: <454B5866.6000207@innova-card.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Nov 2006 15:55:34 +0100
Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:

> From: Franck Bui-Huu <fbuihuu@gmail.com>
> 
> This bug has been introduced by commit:
> 
> 	a536093a2f07007aa572e922752b7491b9ea8ff2
> 
> This commit fixed the big-endian case but broke the little-endian one.
> This patch revert the previous change and swap the definition of
> FB_BIT_NR() macro between big and little endian. It should work for
> both endianess now.
> 

I get worried when I see the word "should" in a changelog.

> ---
> 
>  This is the most obvious fix for me although it's a bit weird
>  that bit ordering depend on platform endianess. I don't know
>  fb code so I prefer submitting this trivial fix rather than
>  breaking every thing else ;)
> 
>  drivers/video/cfbimgblt.c |    4 ++--
>  include/linux/fb.h        |    2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/cfbimgblt.c b/drivers/video/cfbimgblt.c
> index 51d3538..8f47bf4 100644
> --- a/drivers/video/cfbimgblt.c
> +++ b/drivers/video/cfbimgblt.c
> @@ -168,7 +168,7 @@ static inline void slow_imageblit(const
>  
>  		while (j--) {
>  			l--;
> -			color = (*s & (1 << l)) ? fgcolor : bgcolor;
> +			color = (*s & (1 << FB_BIT_NR(l))) ? fgcolor : bgcolor;
>  			val |= FB_SHIFT_HIGH(color, shift);

So that takes us back to the pre-March 31 code, which was allegedly broken
on big-endian.


> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -854,10 +854,12 @@ #define fb_memset memset
>  #endif
>  
>  #if defined (__BIG_ENDIAN)
> +#define FB_BIT_NR(b)              (b)
>  #define FB_LEFT_POS(bpp)          (32 - bpp)
>  #define FB_SHIFT_HIGH(val, bits)  ((val) >> (bits))
>  #define FB_SHIFT_LOW(val, bits)   ((val) << (bits))
>  #else
> +#define FB_BIT_NR(b)              (7 - (b))
>  #define FB_LEFT_POS(bpp)          (0)
>  #define FB_SHIFT_HIGH(val, bits)  ((val) << (bits))
>  #define FB_SHIFT_LOW(val, bits)   ((val) >> (bits))

And that swaps the little-endian and bit-endian implementations of
FB_BIT_NR().  So if it was previously broken on big-endian and was working
on little-endian then it's presumably now broken on little-endian and
working on big-endian.  Or something.


