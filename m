Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262983AbTC1OIk>; Fri, 28 Mar 2003 09:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262985AbTC1OIk>; Fri, 28 Mar 2003 09:08:40 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:10112 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S262983AbTC1OIj>;
	Fri, 28 Mar 2003 09:08:39 -0500
Date: Fri, 28 Mar 2003 15:19:28 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: 2.5.66 fbdev performance (was Re: Re: FBdev updates)
Message-ID: <20030328141928.GB2051@vana.vc.cvut.cz>
References: <Pine.LNX.4.44.0302200108090.20350-100000@phoenix.infradead.org> <20030220150201.GD13507@codemonkey.org.uk> <20030220182941.GK14445@vana.vc.cvut.cz> <1045787031.2051.9.camel@localhost.localdomain> <20030303203500.GA2916@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030303203500.GA2916@vana.vc.cvut.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  I see a problem with new pixmap based code...
There is 25% slowdown for 8x16 8bpp videomode 
after upgrading from 2.5.63 to 2.5.66 :-(

Setup as usual, 1024x768, 100Hz, secondary
head doing nothing (i.e. no fbtv...), CPU
doing nothing except running this test.
P4 1.6GHz, MGA G550. Shown value is system
time in seconds needed to repaint screen 1000
times (avg. from 3 tests) (you can treat it 
as time in milliseconds needed to repaint 
screen once).

Although speedup for 12x22 font is very nice,
it looks to me that we paid too much for it.

Problem is in the new pixmap handling, especially
pixbuf.output - so now instead of memcpy we
call some function for copying each byte from
font to temporary buffer. As you can see,
"constant" portion of time, independent of
color depth, increased by 1sec for unaccelerated
and by 0.75sec for accelerated putcs.
It is 5% to 25% slowdown (5% for 32bpp unaccelerated,
25% for 8bpp accelerated).

And while we are still faster than 2.4.x, we were
even better...
				Petr

NOACCEL, 8x16
        2.4.19+fbtv  2.5.63+fbtv  2.5.63  2.5.66
8bpp    10.02         6.96         5.62    6.62
16bpp   20.05        13.25        10.62   11.63
24bpp   30.03        19.05        15.13   16.07
32bpp   45.00        25.74        20.54   21.62

ACCEL, 8x16
        2.4.19+fbtv  2.5.63+fbtv  2.5.63  2.5.66
8bpp     7.48         3.38         3.00    3.75
16bpp    7.50         3.38         3.01    3.76
24bpp    7.53         3.56         3.53    4.23
32bpp    8.95         4.37         4.33    5.05

NOACCEL, 12x22
        2.4.19+fbtv  2.5.63+fbtv  2.5.63  2.5.66
8bpp    11.54        13.35        10.93    8.96
16bpp   20.00        22.02        18.03   13.61
24bpp   30.03        35.83        29.53   18.07
32bpp   40.12        44.48        36.75   23.22

ACCEL, 12x22
        2.4.19+fbtv  2.5.63+fbtv  2.5.63  2.5.66
8bpp     8.57        14.87        12.90    5.72
16bpp    8.57        14.93        12.92    5.72
24bpp    8.56        15.13        13.10    6.20
32bpp    8.56        15.52        13.76    6.98


