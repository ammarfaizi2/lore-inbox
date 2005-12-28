Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbVL1Dzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbVL1Dzu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 22:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbVL1Dzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 22:55:50 -0500
Received: from waste.org ([64.81.244.121]:3212 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932411AbVL1Dzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 22:55:50 -0500
Date: Tue, 27 Dec 2005 21:52:32 -0600
From: Matt Mackall <mpm@selenic.com>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, hch@infradead.org
Subject: Re: [PATCH 1 of 3] Introduce __memcpy_toio32
Message-ID: <20051228035231.GA3356@waste.org>
References: <patchbomb.1135726914@eng-12.pathscale.com> <7b7b442a4d6338ae8ca7.1135726915@eng-12.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b7b442a4d6338ae8ca7.1135726915@eng-12.pathscale.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2005 at 03:41:55PM -0800, Bryan O'Sullivan wrote:
> +/*
> + * MMIO copy routines.  These are guaranteed to operate in units denoted
> + * by their names.  This style of operation is required by some devices.
> + */

Using kdoc style for new code is nice.

> +extern void fastcall __memcpy_toio32(volatile void __iomem *to, const void *from, size_t count);
> +

Minor rant: extern is always redundant for function prototypes in C.
I'd prefer that we adopt a standard of not using extern for functions,
as it would make use of extern for variables (almost always
inappropriate, especially in C files) stick out more.

While people claim this has some documentation value ("I _meant_ for
this to be exported"), I think it actually has a net negative effect,
as quite a number of people actually think the "extern" keyword does
some unspecified magic here and ignore the namespace pollution of their
theoretically "un-externed" but not explicitly static functions.

There isn't any sort of consensus on this point as far as I know, so
this is just me venting.

>  /* Create a virtual mapping cookie for an IO port range */
>  extern void __iomem *ioport_map(unsigned long port, unsigned int nr);
>  extern void ioport_unmap(void __iomem *);
> diff -r 789a24638663 -r 7b7b442a4d63 lib/iomap.c
> --- a/lib/iomap.c	Tue Dec 27 09:27:10 2005 +0800
> +++ b/lib/iomap.c	Tue Dec 27 15:41:48 2005 -0800
> @@ -187,6 +187,22 @@
>  EXPORT_SYMBOL(iowrite16_rep);
>  EXPORT_SYMBOL(iowrite32_rep);
>  
> +/*
> + * Copy data to an MMIO region.  MMIO space accesses are performed
> + * in the sizes indicated in each function's name.
> + */
> +void fastcall __memcpy_toio32(volatile void __iomem *d, const void *s, size_t count)
> +{
> +	volatile u32 __iomem *dst = d;
> +	const u32 *src = s;
> +
> +	while (--count >= 0) {
> +		__raw_writel(*src++, dst++);
> +}

Suspicious use of volatile - writel is doing the actual write, this
function never does a dereference. As you've already got private
copies of the pointers already in s and d, it's perfectily reasonable
and idiomatic to do:

	while (--count >= 0)
		__raw_writel(*s++, d++);

I'd personally write this as:

	while (count--)
		__raw_writel(*s++, d++);

And as you appear to be using the __raw.. version to avoid repeated
mb()s, you probably ought to tack one on at the end.

-- 
Mathematics is the supreme nostalgia of our time.
