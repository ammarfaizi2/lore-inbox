Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966962AbWKUJpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966962AbWKUJpn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 04:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966963AbWKUJpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 04:45:43 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:32548 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S966962AbWKUJpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 04:45:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f+iThdCIOkjP921KxATBEafjhQgw0fdRnkDNSVLyVnrfLVrRZ38blVYjCJ6wvdyMsqjyMJ9kRFi4pTrBoLVEJdYBpAo/xnwdVLfs5wdAMcW1w7MBDKsErGCpT1v4Jr0C2GhHNQbYEuia3zeEOzMW1Q0CrKpz2oXGBHvwouG/xDI=
Message-ID: <cda58cb80611210145ic52001cr38aed6e38797e3a@mail.gmail.com>
Date: Tue, 21 Nov 2006 10:45:41 +0100
From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
To: "James Simmons" <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] fbmem: is bootup logo broken for monochrome LCD ?
Cc: "Linux Fbdev development list" 
	<linux-fbdev-devel@lists.sourceforge.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611201636500.17639@pentafluge.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45535C08.5020607@innova-card.com>
	 <Pine.LNX.4.64.0611122138030.9472@pentafluge.infradead.org>
	 <cda58cb80611130153n60579de0w2ebb59b050595b3b@mail.gmail.com>
	 <Pine.LNX.4.64.0611131415270.25397@pentafluge.infradead.org>
	 <cda58cb80611131027h5052bf80va06003c23b844fe@mail.gmail.com>
	 <Pine.LNX.4.64.0611131850410.2366@pentafluge.infradead.org>
	 <cda58cb80611140144q79718798p40f2762955c1d91@mail.gmail.com>
	 <Pine.LNX.4.64.0611171825520.32200@pentafluge.infradead.org>
	 <cda58cb80611171242sb40a53bvd02145364551b5a2@mail.gmail.com>
	 <Pine.LNX.4.64.0611201636500.17639@pentafluge.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/06, James Simmons <jsimmons@infradead.org> wrote:
>
> > On 11/17/06, James Simmons <jsimmons@infradead.org> wrote:
> > >
> > > Are those actually numbers? If they are the problem isn't byte reversal
> > > but bit shifting.
> > >
> > > 1010100 = 54
> > > 0101010 = 2A
> >
> > It's not byte reversal, but _bits_ of each bytes have been inversed
> > (bit7->bit0, bit6->bit1, bit5->bit2, bit4->bit3, bit3->bit4, ...)
> > after calling slow_imageblit(). Is it something expected ?
>
> Yipes!! Bit reversal. I have never seen that before. Is only the logo
> messed up? Slow_imageblit can be called if there is no dword alignment
> for the font bitmaps. So the question is do most if not all our fonts
> look okay?
>

No, it's not an only logo issue. Bit reversals happen for all images
which are passed to slow_imageblit() including all fonts.

Can it be a 'bit_per_pixel = 1' issue ? It seems that this config has
not been widely tested.

If you look at slow_imageblit() current implementation and for example
let's say that at the begining of the function we have:

	- __LITTLE_ENDIAN is defined
	- bpp = 1
	- fgcolor = 1
	- bgcolor = 0
	- start_index = 0

The function core can be simplified into:

	for (i = image->height; i--; ) {
		shift = val = 0;
		l = 8;
		j = image->width;
		dst = (u32 __iomem *) dst1;
		s = src;

		while (j--) {
			l--;
			color = (*s & (1 << l)) ? 1 : 0;
			val |= color << shift;
			
			/* Did the bitshift spill bits to the next long? */
			if (shift >= null_bits) {
				FB_WRITEL(val, dst++);
				val = (shift == null_bits) ? 0 :
					FB_SHIFT_LOW(color,32 - shift);
			}
			shift += 1;
			shift &= (32 - 1);
			if (!l) { l = 8; s++; };
		}

		[ ...]

Doesn't this bit of code do a bit reversal ? Specially these 2
following lines of code:

	color = (*s & (1 << l)) ? 1 : 0;
	val |= color << shift;


with 'l' taking values from 7 to 0, and 'shift' taking values from 0
to 31.

Thanks
		Franck
