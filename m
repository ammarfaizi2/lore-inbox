Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbUBXVlL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 16:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262480AbUBXVlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 16:41:11 -0500
Received: from guug.org ([168.234.203.30]:34438 "EHLO guug.galileo.edu")
	by vger.kernel.org with ESMTP id S262476AbUBXVlF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 16:41:05 -0500
Date: Tue, 24 Feb 2004 15:41:06 -0600
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] fbdv/fbcon pending problems
Message-ID: <20040224214106.GA17390@guug.org>
References: <1077497593.5960.28.camel@gaston> <20040224023759.GA16499@guug.org> <Pine.GSO.4.58.0402240935090.3187@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0402240935090.3187@waterleaf.sonytel.be>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Otto Solares <solca@guug.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 09:35:35AM +0100, Geert Uytterhoeven wrote:
> On Mon, 23 Feb 2004, Otto Solares wrote:
> > On Mon, Feb 23, 2004 at 11:53:14AM +1100, Benjamin Herrenschmidt wrote:
> > - bus_id for each fbdev, so from userland became posible to identify
> >   to which card we are controlling.  I know it should be exported via
> >   sysfs but an ioctl should be really handy as when you program for
> >   fbdev anyway you have to use ioctl's, just to get the bus_is will
> >   be a pain use sysfs.
> 
> But the goal is to replace these ioctl()s by sysfs, too, isn't it?

Sure, hopefully fbdev drivers became more 'intelligent', with just a

echo "1024x768x16-75" > /sys/class/fbdev/0/geometry

they will compute internally the timings or get it from EDID and
glad the user with something correct for the hardware.

cat /sys/class/fbdev/0/modes

will give you the modes supported by the card.

On the other side i see a lot of effort in the fbdev acceleration,
it is nice but that effort should be better spent on fixing the layer,
imo, the only user for acceleration is fbcon, any userland app that
use fbdev disables that acceleration so it can map the vmem and ioregs,
and do it's own voodoo if it wants acceleration.  That acceleration
is not "exported" to user space.  I am working in a open source project
that uses mesa-solo with fbdev and many limitations from the layer
itself have been seen.

By 'fixing the layer' i mean some simple things that could make fbdev
a real graphics solution for linux in the long term:

- fbdev_core (will handle the fbdev/sysfs registration, shared by all
              drivers, most important is the modes handling interface).
- fbdev_xxx  (driver for specific hw, it will only export the interesting
              bits like vmem, ioregs, will handle mmap stuff and ioctl's,
              video modes, no accel of any kind).
- fbdev_xxx_accel (acceleration hooks if any for xxx driver, optional module)
- fbdev_con  (handle console -- already modular in 2.6, will use accel hooks
              if not NULL, optional).
- fbdev_xxx_drm (will handle the DRM for xxx using hooks from fbdev, so we
              could have just a single entity inside the kernel handling a
              specific device, and not the current mess within fbdev and
              drm, optional).

We have now with 2.6 a good input and sound layers.  Just by fixing
the graphics layer many interesting userland projects could be born.

-otto

