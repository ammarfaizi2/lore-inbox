Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268779AbTCCUYu>; Mon, 3 Mar 2003 15:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268780AbTCCUYu>; Mon, 3 Mar 2003 15:24:50 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:9088 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S268779AbTCCUYr>;
	Mon, 3 Mar 2003 15:24:47 -0500
Date: Mon, 3 Mar 2003 21:35:00 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Re: FBdev updates.
Message-ID: <20030303203500.GA2916@vana.vc.cvut.cz>
References: <Pine.LNX.4.44.0302200108090.20350-100000@phoenix.infradead.org> <20030220150201.GD13507@codemonkey.org.uk> <20030220182941.GK14445@vana.vc.cvut.cz> <1045787031.2051.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045787031.2051.9.camel@localhost.localdomain>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 08:24:17AM +0800, Antonino Daplas wrote:
> On Fri, 2003-02-21 at 02:29, Petr Vandrovec wrote:
> > 
> > I was for five weeks in U.S., so I did not do anything with
> > matroxfb during that time. I plan to use fillrect and copyrect
> > from generic code (although it means unnecessary multiply on
> > generic side, and division in matroxfb, but well, if we gave
> > up on reasonable speed for fbdev long ago...). But I simply
> > want loadfont and putcs hooks for character painting. And if 
> > fbdev maintainer does not want to give me them, well, then 
> > matroxfb and fbdev are not compatible.
> 
> Petr,
> 
> I submitted the Tile Blitting patch to James some time ago, it has
> tilefill, tilecopy and tileblit hooks.  These hooks should eliminate the
> "multiply in fbcon, divide in driver" bottleneck.
>
> It should result in the same behavior as you would expect in the the 2.4
> API, so you can use text mode with your matroxfb driver.  These same
> hooks will also help optimize drawing if we need to use fonts like
> 12x22.

Hi,
  while waiting on these updates I updated matroxfb a bit
(ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/matroxfb-2.5.63.gz),
so that it now uses fb_* for cfb modes, and putcs/... hooks for
text mode. I have still dozen of changes in fbcon.c which I have
to eliminate (mainly logo painting and cursor handling - for now
I still use revc method, mainly because of I did not make into it yet).

  But main thing is that I'd like to apologize to James - character
painting is much faster for 8x16 fonts under 2.5.x than it was under 2.4.x,
8bpp unaccelerated 8x16 under 2.5.x is even faster than accelerated
under 2.4.x.

  Algorithm for obtaining times was same as described in 
Documentation/fb/matroxfb.txt, with two differences: (1) hardware is 
G550 in P4/1.6GHz, and (2) there was 30MBps video stream feed to 
secondary G550 head of G550 during 2.4.19-pre6 tests, so I made 2.5.x 
tests twice, once with fbtv running and once without.

  My main concern now is 12x22 font... Accelerator setup
is so costly for each separate painted character that for 8bpp 
accelerated version is even slower than unaccelerated one :-(
(and almost twice as slow when compared with 2.4.x).

  And one (or two...) generic questions: why is not pseudo_palette
u32* pseudo_palette, or even directly u32 pseudo_palette[17] ?
And why we do not fill this pseudo_palette with
i * 0x01010101U for 8bpp pseudocolor and i * 0x11111111U for 4bpp
pseudocolor? This allowed me to remove couple of switches and tests
from acceleration fastpaths (and from cfb_imageblit and cfb_fillrect,
but I did not changed these two in my benchmarks below).

						Best regards,
							Petr Vandrovec
							vandrove@vc.cvut.cz


NOACCEL, 8x16
	2.4.19+fbtv	2.5.63+fbtv	2.5.63
8bpp	10.02		 6.96		 5.62
16bpp	20.05		13.25		10.62
24bpp	30.03		19.05		15.13
32bpp	45.00		25.74		20.54

ACCEL, 8x16
	2.4.19+fbtv	2.5.63+fbtv	2.5.63
8bpp	 7.48		 3.38		 3.00
16bpp	 7.50		 3.38		 3.01
24bpp	 7.53		 3.56		 3.53
32bpp	 8.95		 4.37		 4.33

NOACCEL, 12x22
	2.4.19+fbtv	2.5.63+fbtv	2.5.63
8bpp	11.54		13.35		10.93
16bpp	20.00		22.02		18.03
24bpp	30.03		35.83		29.53
32bpp	40.12		44.48		36.75

ACCEL, 12x22
	2.4.19+fbtv	2.5.63+fbtv	2.5.63
8bpp	 8.57		14.87		12.90
16bpp	 8.57		14.93		12.92
24bpp	 8.56		15.13		13.10
32bpp	 8.56		15.52		13.76


