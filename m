Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964973AbWKDJW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbWKDJW5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 04:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbWKDJW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 04:22:57 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:64637 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964973AbWKDJW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 04:22:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DiFK1Ge9llO1VRRWGiQUgNU//g/KKtTzWPeI1E34/hIrVRFt9rZlOjGDotrIipgd49YXqpwXN3AKIZjWllatt0otZvUyoxvroxt/vXteU0EbtmMjH3b5M/ur2atEKMDBgWc5QSR+LzNi/UtMBlKV4BKOjyFB3nM3X/0C/8bBFLE=
Message-ID: <cda58cb80611040122w6cf42014vf17f48edda97e797@mail.gmail.com>
Date: Sat, 4 Nov 2006 10:22:54 +0100
From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH] fbcon: Re-fix little-endian bogosity in slow_imageblit()
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       adaplas@pol.net, gregkh@suse.de
In-Reply-To: <20061103105857.874f566c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <454B5866.6000207@innova-card.com>
	 <20061103105857.874f566c.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/06, Andrew Morton <akpm@osdl.org> wrote:
> On Fri, 03 Nov 2006 15:55:34 +0100
> Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>
> > From: Franck Bui-Huu <fbuihuu@gmail.com>
> >
> > This bug has been introduced by commit:
> >
> >       a536093a2f07007aa572e922752b7491b9ea8ff2
> >
> > This commit fixed the big-endian case but broke the little-endian one.
> > This patch revert the previous change and swap the definition of
> > FB_BIT_NR() macro between big and little endian. It should work for
> > both endianess now.
> >
>
> I get worried when I see the word "should" in a changelog.
>

The change log is incorrect, sorry. I should have said:

"""
Commit a536093a2f07007aa572e922752b7491b9ea8ff2 fixed only the big
endian case but left the little endian one broken.

To fix this for both endianess, this patch reverts the previous change
and swaps the little-endian and bit-endian implementations of
FB_BIT_NR().
"""

I only tested this patch on a little endian machine only. But the code
is the same for big endian platform, so I presume that it's still
working. What make me doubt is the change log of the initial fix:

"""
This patch may deserve to go to the stable tree.  The code has already been
well tested in little-endian machines.  It's only in big-endian where there is
uncertainty and Herbert confirmed that this is the correct way to go.

It should not introduce regressions.
"""

It said that the code was well tested on little endian... On the other
hand if you look at the change log of commit
81d3e147ec9ffc6ef04b5f05afa4bef22487b32b, it said

"""
Fix possible endian bug(?) when bit testing in slow_imageblit().  This
function is rarely called (only if (width * bpp) % 32 != 0) thus the bug is
not triggered.
"""

Notice how it sounds unsure. Actually I don't know if it has been tested at all.

> > ---
> >
> >  This is the most obvious fix for me although it's a bit weird
> >  that bit ordering depend on platform endianess. I don't know
> >  fb code so I prefer submitting this trivial fix rather than
> >  breaking every thing else ;)
> >
> >  drivers/video/cfbimgblt.c |    4 ++--
> >  include/linux/fb.h        |    2 ++
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/video/cfbimgblt.c b/drivers/video/cfbimgblt.c
> > index 51d3538..8f47bf4 100644
> > --- a/drivers/video/cfbimgblt.c
> > +++ b/drivers/video/cfbimgblt.c
> > @@ -168,7 +168,7 @@ static inline void slow_imageblit(const
> >
> >               while (j--) {
> >                       l--;
> > -                     color = (*s & (1 << l)) ? fgcolor : bgcolor;
> > +                     color = (*s & (1 << FB_BIT_NR(l))) ? fgcolor : bgcolor;
> >                       val |= FB_SHIFT_HIGH(color, shift);
>
> So that takes us back to the pre-March 31 code, which was allegedly broken
> on big-endian.
>

yes exept definition of FB_BIT_NR() has changed as you noticed.

>
> > --- a/include/linux/fb.h
> > +++ b/include/linux/fb.h
> > @@ -854,10 +854,12 @@ #define fb_memset memset
> >  #endif
> >
> >  #if defined (__BIG_ENDIAN)
> > +#define FB_BIT_NR(b)              (b)
> >  #define FB_LEFT_POS(bpp)          (32 - bpp)
> >  #define FB_SHIFT_HIGH(val, bits)  ((val) >> (bits))
> >  #define FB_SHIFT_LOW(val, bits)   ((val) << (bits))
> >  #else
> > +#define FB_BIT_NR(b)              (7 - (b))
> >  #define FB_LEFT_POS(bpp)          (0)
> >  #define FB_SHIFT_HIGH(val, bits)  ((val) << (bits))
> >  #define FB_SHIFT_LOW(val, bits)   ((val) >> (bits))
>
> And that swaps the little-endian and bit-endian implementations of
> FB_BIT_NR().  So if it was previously broken on big-endian and was working
> on little-endian then it's presumably now broken on little-endian and
> working on big-endian.  Or something.
>

Sorry my own fault, the change log of this patch is not correct. See
above. Please tell me if you want me to resend this patch with the
change log fixed.

Thanks
-- 
               Franck
