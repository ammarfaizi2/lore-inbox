Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312558AbSDJJlB>; Wed, 10 Apr 2002 05:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312559AbSDJJlA>; Wed, 10 Apr 2002 05:41:00 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:46862 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id <S312558AbSDJJlA>; Wed, 10 Apr 2002 05:41:00 -0400
Date: Wed, 10 Apr 2002 10:40:55 +0100
To: benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radeon frame buffer driver
Message-ID: <20020410094055.GA789@berserk.demon.co.uk>
Mail-Followup-To: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
In-Reply-To: <20020410001249.GA2010@berserk.demon.co.uk> <20020410090638.1550@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Peter Horton <pdh@berserk.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2002 at 11:06:38AM +0200, benh@kernel.crashing.org wrote:
> >Another installment of the Radeon frame buffer driver patch (still
> >against 2.4.19-pre2).
> >
> >* All colour modes > 8bpp are now DIRECTCOLOR (Geert inspired).
> >
> >* Driver now uses 'ypan' to speed up scrolling even further.
> >
> >* Fix CRTC pitch to match accelerator pitch (800x600x256 works again).
> >
> >Driver seems okay now, plays nicely with X etc. etc. Please test if you
> >can
> >
> >P.
> 
> I really don't like all the hacks related to the palette in 15/16/32bpp 
> mode. You shouldn't affect whatever palette gets passed from userland or
> apps that rely on full access to the gamma table will fail. Also, iirc,
> the chip's palette in 16 bits mode is 64 entries and 32 in 15 bpp, you
> can verify this by seeing how much entries get passed by xfbdev when
> it configures the 1:1 color ramp. The old code worked except for the
> cursor in console mode which tends to have crazy colors, I think due to
> fbdev code brokenness but I'm too sure about that last one.
> 

Please look at code.

In 32bpp mode user space can set all 256 palette indices.

In 15 bit mode user space can set all 32 palette indices.

In 16bpp mode user space can set all 32 palette indices for red and
blue, and all 64 palette indices for green.

The reason 16bpp mode fails when using "fbtv" is that "fbtv" only
initialises the first 32 palette indices for green, but the captured
video uses all 64 values. I patched "fbtv" to initialise all 64 indices
and it worked fine. I think this is a bug in "fbtv" (and other such
apps).

There is a hack in the code to support "fbtv" in 16bpp mode, but it is
only used if you pass the driver the "fb16fix" flag, and it limits the
green component to 5 bits. I used it for testing but it doesn't need to
live any longer. If people want to use "fbtv" they should use 15 or 32
bit mode.

Test it, in all modes, I have.

The other hack is one that sets the top indices in the palette to white
when palette index 0 is set. This is needed for the soft cursor to work
as the soft cursor just flips all the bits in each pixel, which doesn't
work in DIRECTCOLOR modes. Other drivers do similiar things. I've
started to look at using the accelerator engine for flipping the cursor
but there are locking issues involved which I want to get right.

P.
