Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbVHaRPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbVHaRPm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 13:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbVHaRPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 13:15:42 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:6893 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964888AbVHaRPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 13:15:41 -0400
Date: Wed, 31 Aug 2005 19:15:24 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Knut Petersen <Knut_Petersen@t-online.de>
cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net,
       "Antonino A. Daplas" <adaplas@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Jochen Hein <jochen@jochen.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] [PATCH 1/1 2.6.13] framebuffer: bit_putcs()
 optimization for 8x* fonts
In-Reply-To: <4315A6AB.5090108@t-online.de>
Message-ID: <Pine.LNX.4.61.0508311750140.3728@scrub.home>
References: <43148610.70406@t-online.de> <Pine.LNX.4.62.0508301814470.6045@numbat.sonytel.be>
 <43149E5B.7040006@t-online.de> <Pine.LNX.4.61.0508302039160.3743@scrub.home>
 <4314DD2E.7060901@t-online.de> <Pine.LNX.4.61.0508310159290.3728@scrub.home>
 <4315A6AB.5090108@t-online.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 31 Aug 2005, Knut Petersen wrote:

> +static inline void __fb_pad_aligned_buffer(u8 *dst, u32 d_pitch, u8 *src, +
> u32 s_pitch, u32 height)
> +{
> +	int i, j;
> +
> +	if (likely(s_pitch==1))
> +		for(i=0; i < height; i++)
> +			dst[d_pitch*i] = src[i];
> +	else if (s_pitch==2)
> +		for(i=0; i < height; i++) {
> +			*(u16 *)dst = ((u16 *)src)[i];
> +			dst += d_pitch;
> +		}
> +	else {
> +		d_pitch -= s_pitch;
> +		for (i = height; i--; ) {
> +			for (j = 0; j < s_pitch; j++)
> +				*dst++ = *src++;
> +			dst += d_pitch;
> +		}
> +	}
> +}

Why did you add the multiply back?
You have now 3 slightly different variants of the same, which isn't really 
an improvement. In my example I showed you how to generate the first and 
last version from the same source.
If you also want to optimize for other sizes, you might want to always 
inline the function, if the function call overhead is the largest part 
anyway, the special case for 2 bytes might not be needed anymore.

BTW this version saves another condition:

static inline void __fb_pad_aligned_buffer(u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch, u32 height)
{
	int i, j;

	d_pitch -= s_pitch;
	i = height;
	do {
		/* s_pitch is a few bytes at the most, memcpy is suboptimal */
		j = s_pitch;
		do
			*dst++ = *src++;
		while (--j > 0);
		dst += d_pitch;
	} while (--i > 0);
}

bye, Roman

