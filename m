Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131651AbRCOFUF>; Thu, 15 Mar 2001 00:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131652AbRCOFTz>; Thu, 15 Mar 2001 00:19:55 -0500
Received: from harrier.prod.itd.earthlink.net ([207.217.121.12]:62441 "EHLO
	harrier.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S131651AbRCOFTi>; Thu, 15 Mar 2001 00:19:38 -0500
Date: Wed, 14 Mar 2001 13:20:05 -0800 (PST)
From: James Simmons <jsimmons@linux-fbdev.org>
X-X-Sender: <jsimmons@linux.local>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] [RFC] fbdev & power management
Message-ID: <Pine.LNX.4.31.0103141251590.779-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>I'd go for a fallback to dummycon. It's of no use to waste power on
>>creating graphical images of the text console when asleep. And the
>>fallback to dummycon is needed anyway while a fbdev is opened (in
>>2.5.x).
>
>We do already have the backup image since we need to backup & restore the
>framebuffer content.

  What he is talking about is in 2.5.X when you explictly open /dev/fb it
will call take_over_console with dummy con. This allows for several
things. One is with this approach their is no chance of a conflict between
X/DRI and fbdev. Especially when we will have fbdev drivers using DMA
internally to preform console operations. For some hardware using DMA is
the only way fbdev can work and on some platforms fbcon is the only
choice. So things going into /dev/ttyX will not have a chance to interfere
with X.  The second reason is for security. It is possible to have a
program to open /dev/fb and see what is being typed on the fore ground
console. I sealed up those holes using the dummy con approach and some
test to see if the current process is local.
  Now for fbcon its simpler. Things get writing to the shadow buffer
(vc_screenbuf). When the console gets woken up update_screen is called.
While power down the shadow buffer can be written to which is much faster
than saving a image of the framebuffer. Of course if you still want to do
this such in the case of the X server then copy the image of the
framebuffer to regular ram. Then power down /dev/fb using some ioctl calls
provide.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@linux-fbdev.org]               ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

