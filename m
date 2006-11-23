Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757377AbWKWOxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757377AbWKWOxT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 09:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757378AbWKWOxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 09:53:18 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:10680 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1757377AbWKWOxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 09:53:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eXKIDBmn1iOgnNDRHr4uop1wOo1Q1ggiizCUAKxiBShKF077AT4bXDuBnRCDTi50mU73KRRWuvyvJbNxXLzjNta0haVXI5EIM/zVzRJYFG2S2WpUaMSflgXCT1ev4+7aAxT0W9TLXTAn7MvgRhwrWWTFAUfUrMCeIp5r/leAvxM=
Message-ID: <cda58cb80611230653x2951d9d8x41b193f0101f9fdf@mail.gmail.com>
Date: Thu, 23 Nov 2006 15:53:16 +0100
From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
To: "James Simmons" <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] fbmem: is bootup logo broken for monochrome LCD ?
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Linux Fbdev development list" 
	<linux-fbdev-devel@lists.sourceforge.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0611222101220.14604@pentafluge.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45535C08.5020607@innova-card.com>
	 <Pine.LNX.4.64.0611131850410.2366@pentafluge.infradead.org>
	 <cda58cb80611140144q79718798p40f2762955c1d91@mail.gmail.com>
	 <Pine.LNX.4.64.0611171825520.32200@pentafluge.infradead.org>
	 <cda58cb80611171242sb40a53bvd02145364551b5a2@mail.gmail.com>
	 <Pine.LNX.4.64.0611201636500.17639@pentafluge.infradead.org>
	 <cda58cb80611210145ic52001cr38aed6e38797e3a@mail.gmail.com>
	 <Pine.LNX.4.64.0611211507290.32103@pentafluge.infradead.org>
	 <cda58cb80611220048p73bb54e3w414f1c0a5ce178d3@mail.gmail.com>
	 <Pine.LNX.4.64.0611222101220.14604@pentafluge.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/06, James Simmons <jsimmons@infradead.org> wrote:
> Replace the below line in my patch I sent
>
> > >                     val |= color << shift;
>
> with
>                         val <<= shift;
>                         val |= color;

I think it can't work since shift is 0 to 31, you'll end up with 'val
<<= 31' which I don't think is what you want.

doing
                         val <<= 1;

make it works but it's still very fragile. Code which deals with
trailing bit seems bogus since new value of 'val' is simply discarded
here.

                /* write trailing bits */
                if (shift) {
                        u32 end_mask = (~(u32)0 << shift);

                        val = FB_READL(dst1);
                        val &= end_mask;
                        FB_WRITEL(val, dst1);
                }

Another thing is that I don't see how very small images (for example
when image->width = 4) will be handled.

> > >                    /* Did the bitshift spill bits to the next long? */
> > >                        if (shift >= 31) {
> > >                                FB_WRITEL(val, dst++);
> > >                                val = (shift == 31) ? 0 :(color >> (32 - shift));
> > >                        }
> > >                        shift += 1;
> > >                        shift &= (32 - 1);
> > >                }
> > >
> > >                [ ...]
>
> Let me know if that works.

I'm wondering if working with 32 bits words really worth... I mean the
code is quite hard to follow because it needs to deal with endianess,
heading bits, trailings bits whereas working with 8 bits would be so
much easier, wouldn't it ? Are writings in video RAM very long ?

-- 
               Franck
