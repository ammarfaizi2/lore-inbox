Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbVL1PTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbVL1PTK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 10:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbVL1PTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 10:19:09 -0500
Received: from witte.sonytel.be ([80.88.33.193]:16038 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S964839AbVL1PTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 10:19:08 -0500
Date: Wed, 28 Dec 2005 16:18:45 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Matt Mackall <mpm@selenic.com>
cc: "Bryan O'Sullivan" <bos@pathscale.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1 of 3] Introduce __memcpy_toio32
In-Reply-To: <20051228035231.GA3356@waste.org>
Message-ID: <Pine.LNX.4.62.0512281617190.10103@pademelon.sonytel.be>
References: <patchbomb.1135726914@eng-12.pathscale.com>
 <7b7b442a4d6338ae8ca7.1135726915@eng-12.pathscale.com> <20051228035231.GA3356@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Dec 2005, Matt Mackall wrote:
> On Tue, Dec 27, 2005 at 03:41:55PM -0800, Bryan O'Sullivan wrote:
> >  /* Create a virtual mapping cookie for an IO port range */
> >  extern void __iomem *ioport_map(unsigned long port, unsigned int nr);
> >  extern void ioport_unmap(void __iomem *);
> > diff -r 789a24638663 -r 7b7b442a4d63 lib/iomap.c
> > --- a/lib/iomap.c	Tue Dec 27 09:27:10 2005 +0800
> > +++ b/lib/iomap.c	Tue Dec 27 15:41:48 2005 -0800
> > @@ -187,6 +187,22 @@
> >  EXPORT_SYMBOL(iowrite16_rep);
> >  EXPORT_SYMBOL(iowrite32_rep);
> >  
> > +/*
> > + * Copy data to an MMIO region.  MMIO space accesses are performed
> > + * in the sizes indicated in each function's name.
> > + */
> > +void fastcall __memcpy_toio32(volatile void __iomem *d, const void *s, size_t count)
> > +{
> > +	volatile u32 __iomem *dst = d;
> > +	const u32 *src = s;
> > +
> > +	while (--count >= 0) {
> > +		__raw_writel(*src++, dst++);
> > +}
> 
> Suspicious use of volatile - writel is doing the actual write, this
> function never does a dereference. As you've already got private
> copies of the pointers already in s and d, it's perfectily reasonable
> and idiomatic to do:
> 
> 	while (--count >= 0)
> 		__raw_writel(*s++, d++);
> 
> I'd personally write this as:
> 
> 	while (count--)
> 		__raw_writel(*s++, d++);

Indeed.

BTW, does the original loop really work? Size size_t is unsigned, >= 0 is
always true and we have a nice infinite loop?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
