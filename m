Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263100AbTC1S6X>; Fri, 28 Mar 2003 13:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263101AbTC1S6X>; Fri, 28 Mar 2003 13:58:23 -0500
Received: from pine.compass.com.ph ([202.70.96.37]:8970 "HELO
	pine.compass.com.ph") by vger.kernel.org with SMTP
	id <S263100AbTC1S6V>; Fri, 28 Mar 2003 13:58:21 -0500
Subject: Re: [Linux-fbdev-devel] 2.5.66 fbdev performance (was Re: Re:
	FBdev updates)
From: Antonino Daplas <adaplas@pol.net>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <20030328141928.GB2051@vana.vc.cvut.cz>
References: <Pine.LNX.4.44.0302200108090.20350-100000@phoenix.infradead.org>
	<20030220150201.GD13507@codemonkey.org.uk>
	<20030220182941.GK14445@vana.vc.cvut.cz>
	<1045787031.2051.9.camel@localhost.localdomain>
	<20030303203500.GA2916@vana.vc.cvut.cz> 
	<20030328141928.GB2051@vana.vc.cvut.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1048877364.1000.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 29 Mar 2003 02:50:08 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-28 at 22:19, Petr Vandrovec wrote:
> 
> Problem is in the new pixmap handling, especially
> pixbuf.output - so now instead of memcpy we
> call some function for copying each byte from
> font to temporary buffer. As you can see,
> "constant" portion of time, independent of
> color depth, increased by 1sec for unaccelerated
> and by 0.75sec for accelerated putcs.
> It is 5% to 25% slowdown (5% for 32bpp unaccelerated,
> 25% for 8bpp accelerated).
> 

Actually, the slowdown is caused not just by the overhead of the
read/write methods, but also due to the extra work padding and aligning
the bitmaps according to requirements of the hardware.  This was because
James wanted support for buffers located not just in system memory but
also graphics/dma memory.

The result is that unaccelerated imageblit will slow down while properly
written accelerated imageblit will experience some speed up (not much,
probably around 5%).

We can:

1. partially reverse the code so it behaves similarly to 2.5.63. 
Support for writing to graphics/dma memory will go away.  

2. split the code path:  one will go to the '2.5.63' path, the other
will go to the '2.5.66' path, depending on the setting of info->pixmap.

3. keep the code as is

Personally, I prefer #1, but it's up to James/Geert.

Tony




