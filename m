Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267115AbSLDWFe>; Wed, 4 Dec 2002 17:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267116AbSLDWFe>; Wed, 4 Dec 2002 17:05:34 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:8719 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S267115AbSLDWFb>; Wed, 4 Dec 2002 17:05:31 -0500
Subject: Re: [Linux-fbdev-devel] [PATCH] FBDev: vga16fb port
From: Antonino Daplas <adaplas@pol.net>
To: Sven Luther <luther@dpt-info.u-strasbg.fr>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021204164746.GA4261@iliana>
References: <Pine.LNX.4.44.0212022027510.18805-100000@phoenix.infradead.org>
	<1038917280.1228.7.camel@localhost.localdomain>
	<20021204073218.GA1025@iliana>
	<1039003565.1079.67.camel@localhost.localdomain>
	<20021204102820.GA1841@iliana>
	<1039020239.1093.61.camel@localhost.localdomain> 
	<20021204164746.GA4261@iliana>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1039050178.1075.82.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Dec 2002 06:04:52 +0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-04 at 21:47, Sven Luther wrote:
> > > So there is no common zqy of doing this, my docs say something about a
> > > vga control register zhich is accesses trough the sequencer regs. Does
> > > vgafb (or textmode or whatever) not call this when giving the hand to
> > > the fbdev ?
> > No, when a video card goes to graphics mode, it's up to the driver to
> > program the registers.  vgacon/vga16fb only touches the standard VGA
> 
> So we will have a repeat of the exact same code snipplet in all the
> drivers ? I thought the new API was about having all the common code in
> common and not duplicated in all the drivers. Could we have at least a
> gen_disable_vga function or something such that we could call ?

Not exactly.  Different hardware programs those registers differently.
Ie, vga will probably program the crtc regs for 640x400@60.  Your
hardware can probably do better than that. So the code cannot be
shared.  However, saving and restoring the standard VGA regs can be
common.

> 
> > registers (crtc[25], attr[21], seq[5], gfx[9], misc[1]). Usage is pretty
> 
> Well, i need to disable the vga output in seq[5], more exactly bit 3
> called "enable VGA display", need to be reset.
> 
[...]
> 
> Err, it is seq[5], called VGAControlRegister, so it is beyond the
> standard seq registers (seq[0] to seq[5]), right ?

I meant seq[0] to seq[4] are standard VGA regs.  So seq[5] is extended. 
It's VGAControlRegister in your hardware, it's not used in mine.

> 
[...]
> > > Mmm, what about interaction with X ? X also does a save/restore of the
> > > previous (text) mode, when a X driver is _not_ fbdev aware, it will
> > > save/restore the things twice, right ?
> > > 
> > Not twice just the current mode it was in when X launched, although it
> > always assumes text mode.  Same thing for fbdev, it should only restore
> 
> Well, but fbdev will save its state and X will save it again, so the
> saving done in the X driver is not all that important, and i could
> ignore it at first if i already have an fbdev.

If X is running  in native mode then it has to save the register state. 
Otherwise you cannot switch to a console.  If X is running on top of
fbdev, then state restore/saves are done using fb_set_var and
fb_get_var.  The registers are not touched, that's the purpose of fbdev.

If you are running vgacon, fbdev, and native X, then yes, fbdev and X
has to do a save of their initial state.

> 
> Does this also apply to vesafb ?
Not too sure about this. vesa requires real-mode initialization.  Either
you do this at boot time, or fake a real-mode environment like what X
does.

> 
> > the state when reference count becomes zero. If the framebuffer console
> > is loaded, the reference count will never be zero unless it is
> > unloaded.  If the framebuffer console is not loaded, the only time you
> > will save and restore the state is when some fb-based application
> > attempts to open/close /dev/fbx.
> 
> Ok, ...
> 
[...]

Tony

