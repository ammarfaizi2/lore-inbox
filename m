Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266652AbSLDOaY>; Wed, 4 Dec 2002 09:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266675AbSLDOaY>; Wed, 4 Dec 2002 09:30:24 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:28943 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S266652AbSLDO3Z>; Wed, 4 Dec 2002 09:29:25 -0500
Subject: Re: [Linux-fbdev-devel] [PATCH] FBDev: vga16fb port
From: Antonino Daplas <adaplas@pol.net>
To: Sven Luther <luther@dpt-info.u-strasbg.fr>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021204102820.GA1841@iliana>
References: <Pine.LNX.4.44.0212022027510.18805-100000@phoenix.infradead.org>
	<1038917280.1228.7.camel@localhost.localdomain>
	<20021204073218.GA1025@iliana>
	<1039003565.1079.67.camel@localhost.localdomain> 
	<20021204102820.GA1841@iliana>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1039020239.1093.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Dec 2002 22:27:21 +0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-04 at 15:28, Sven Luther wrote:
> > 
> > Most cards with a VGA core needs to disable the VGA output before going
> > to graphics mode.  Disabling VGA output is hardware specific, and is
> > usually automatic when you go to graphics mode.
> 
> So there is no common zqy of doing this, my docs say something about a
> vga control register zhich is accesses trough the sequencer regs. Does
> vgafb (or textmode or whatever) not call this when giving the hand to
> the fbdev ?
No, when a video card goes to graphics mode, it's up to the driver to
program the registers.  vgacon/vga16fb only touches the standard VGA
registers (crtc[25], attr[21], seq[5], gfx[9], misc[1]). Usage is pretty
much uniform across all hardware. Any registers past those indices are
considered extended registers and usage is hardware specific.  In
graphics mode, you will probably use both the standard and the extended
registers, and disabling the VGA mode/enabling graphics mode is most
probably in one of the extended registers.
> 
> > Because James wrote the fb framework to be very modular, then you must
> > be careful to save/restore the initial video state  when loading or
> > unloading.  Theoretically, a driver should load, but not go to graphics
> > mode immediately.  Only upon a call to xxxfb_set_par() should the driver
> > do so.  Before going to graphics mode, that's were you save the initial
> > state.  Have a reference count or something to keep track of the number
> > of users, and when this reference count becomes zero, restore the
> > initial state.  You should be able to do this by hooking these routines
> > in fb_open() and fb_release().
> 
> Mmm, what about interaction with X ? X also does a save/restore of the
> previous (text) mode, when a X driver is _not_ fbdev aware, it will
> save/restore the things twice, right ?
> 
Not twice just the current mode it was in when X launched, although it
always assumes text mode.  Same thing for fbdev, it should only restore
the state when reference count becomes zero. If the framebuffer console
is loaded, the reference count will never be zero unless it is
unloaded.  If the framebuffer console is not loaded, the only time you
will save and restore the state is when some fb-based application
attempts to open/close /dev/fbx.

> > The one I submitted (and a revised one I'm going to submit soon) should
> > be able to restore the VGA text/graphics mode.  Complement this with
> > your hardware's extended state save and restore routines and you should
> > be able to load/use/unload your driver repeatedly :-).
> 
> Ok, i will try.

This is optional though.  You can still adopt the 2.4 method of always
setting the video mode.  Just take note that fbdev can be loaded without
fbcon, and if you get into graphics mode without fbcon, you just messed
up your user's console.  I think this can be avoided by munging the
configuration file (ie, always depend on fbcon and make your module
unsafe to unload).

Tony

