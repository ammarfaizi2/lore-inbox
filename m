Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbUBYDPt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 22:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbUBYDPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 22:15:49 -0500
Received: from guug.org ([168.234.203.30]:47750 "EHLO guug.galileo.edu")
	by vger.kernel.org with ESMTP id S262313AbUBYDPb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 22:15:31 -0500
Date: Tue, 24 Feb 2004 21:15:53 -0600
To: James Simmons <jsimmons@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] fbdv/fbcon pending problems
Message-ID: <20040225031553.GC17390@guug.org>
References: <20040224214106.GA17390@guug.org> <Pine.LNX.4.44.0402250118210.24952-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402250118210.24952-100000@phoenix.infradead.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Otto Solares <solca@guug.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 01:21:39AM +0000, James Simmons wrote:
> > On the other side i see a lot of effort in the fbdev acceleration,
> > it is nice but that effort should be better spent on fixing the layer,
> > imo, the only user for acceleration is fbcon, any userland app that
> > use fbdev disables that acceleration so it can map the vmem and ioregs,
> > and do it's own voodoo if it wants acceleration.  That acceleration
> > is not "exported" to user space.  I am working in a open source project
> > that uses mesa-solo with fbdev and many limitations from the layer
> > itself have been seen.
> 
> That is true so far for fillrect and copyarea functions. Imageblit will be 
> used for read and writes on /dev/fbX. Also it is used for software 
> cursors. 

But if acceleration is not disabled you can't map the vmem and io regions.

> > By 'fixing the layer' i mean some simple things that could make fbdev
> > a real graphics solution for linux in the long term:
> > 
> > - fbdev_core (will handle the fbdev/sysfs registration, shared by all
> >               drivers, most important is the modes handling interface).
> 
> Pretty much done.
> 
> > - fbdev_xxx  (driver for specific hw, it will only export the interesting
> >               bits like vmem, ioregs, will handle mmap stuff and ioctl's,
> >               video modes, no accel of any kind).
> 
> Have it.
> 
> > - fbdev_xxx_accel (acceleration hooks if any for xxx driver, optional module)
> 
> We need it for the above reasons.
> 
> > - fbdev_con  (handle console -- already modular in 2.6, will use accel hooks
> >               if not NULL, optional).
> 
> We always need the accel hooks. Some how we have to draw the fonts.

Ok, i get your point about accel.  My point is that accel for userland is
already there in Mesa-solo with the DRI accelerated drivers or with directfb,
we just need the basic linux graphics infrastructure with the following
functionality so specialized libraries (like the above) integrate nicely with
the fbdev.

In summary:

1. Card identification.
	A simple bus_id will do this hopefully on any platform.
2. Port identification.
	I don't think exists a form to determine this with the current
	functionality, MacOSx excells in this area.
3. Modes list supported by the card per graphics port.
	As BenH noted, filtered by constraints like mem bandwitdh, etc.
	hopefully using EDID or any other monitor info present.
4. Memory mappings.
	We can currently map the vmem and io regions in userspace.  It
	current exists problems with highmem but in short it simply works
	for dumb chips or programable chips so specialized libs (like
	mesa-solo) can do a decent job.
5. sysfs interface.
	So we can control the behavior with libsysfs to change video modes, get
	card/monitor info, etc.
6. DRM or card's command queue.
	For use in the mentioned DRI drivers or any other project based on that.
7) read/write/other_fs_ops/ioctl.
	So current fbdev software works without problems.
8) Graphics console.

1) is trivial.
2) 3) 5) and 6) is what needs work or is lacking currently.
4) and 7) 8) are already done and was a major step for graphics on linux in
   its time.

I am by no means a graphics expert like you or BenH but i think the mentioned
above should express general userland needs.

> > We have now with 2.6 a good input and sound layers.  Just by fixing
> > the graphics layer many interesting userland projects could be born.
> 
> I agree. The graphics layer is the last frontier.

Yes, it will bring Linux on the Desktop an unavoidable reality, being part
this basic functionality of the kernel is what one expects from a modern system
but many could argument that is job for userland libs, probably true, anyway
we need a (preferably graphics) console early in the boot process.

-otto

