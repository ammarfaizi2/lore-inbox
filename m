Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265873AbSKBEB6>; Fri, 1 Nov 2002 23:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265875AbSKBEB5>; Fri, 1 Nov 2002 23:01:57 -0500
Received: from [203.167.79.9] ([203.167.79.9]:1291 "EHLO willow.compass.com.ph")
	by vger.kernel.org with ESMTP id <S265873AbSKBEB4>;
	Fri, 1 Nov 2002 23:01:56 -0500
Subject: Re: [Linux-fbdev-devel] [BK fbdev updates]
From: Antonino Daplas <adaplas@pol.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0211011524270.11313-100000@maxwell.earthlink.net>
References: <Pine.LNX.4.33.0211011524270.11313-100000@maxwell.earthlink.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1036209978.581.36.camel@daplas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 
Date: 02 Nov 2002 12:06:53 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-11-02 at 07:29, James Simmons wrote:
> 
> > James,
> >
> > I tried the patch, and it does produce a cleaner and smaller driver.
> > Overall, I like it. Some observations:
> >
> > 1. Without the fb_set_var() hook, switching from X messes up the
> > console.  I would guess this will be addressed by the console?
> 
> fbcon_switch has to be rewritten. I'm going threw the process of cleaning
> up the upper fbcon layer. Its such a mess. Yuck!!!
Thank goodness for this :)  I was already thinking of adding an 'Option
Usefbdev' for the xfree86 driver.
 
> 
> > 2. Console panning/wrapping does not work.  updatevar includes a check
> > "if (con == info->currcon)", and my guess is info->currcon is obsoleted
> > so the check always fails.
> 
> It worked before. Strange. Do you mean for you console panning doesn't
> work on the visiable VC or a non visible VC?
> 
I grepped the source for currcon, and did not see any instances where
it's being updated.  So, I removed the "if (con == info->currcon)" line
and panning worked again for the current console.  However, switching to
another console screws up the viewport again.  The viewport will be
restored if I scrolled past yres_virtual.

Perhaps, I should apply your console patches?  I haven't done that yet.

> > 3. fbdev can be loaded without taking over the console.  After running
> > an fb-based application, exiting fbdev messes up the vga console
> > (actually hangs the system).  Should the fbdev driver provide the
> > capability to restore the VGA state then, ie at info->fb_release?
> 
> Yes!!! Of course there is the issue is the framebuffer that actual one
> used for vgacon or is it independent, thinking multihead here.
> 
I was trying to confirm if vgacon should restore its own state or not.
 
But this one is neat :)  I added VGA save/restore state routines to
fb_open() and fb_release().  I was able to boot to a VGA console, fired
up XFBDev and DirectFB and exited back again to a VGA console.  DirectFB
came back without problems, XFBDev needed a console reset.  

I guess the save/restore state routines will only be needed for graphics
card with a VGA core.  I think multiple graphics card or multi-head
systems will not be affected since the driver will only be
saving/restoring its own hardware anyway.

> > 4. The initial font loaded is 8x8. It seems that 8x16 fonts are limited
> > for the SGI console console only.  Any reason why?
> 
> I have no idea why that is. You can select a differnt font.
You have this in Kconfig in the 'console' directory.

config FONT_8x16
	bool "VGA 8x16 font" if FBCON_FONTS   
	depends on FB && SGI_NEWPORT_CONSOLE=y

I changed the '&&' operator to '||' in my case.

> 
> > 5.  The cfb_* drawing functions still behave erratically, especially in
> > emacs.  Geert has made some versions that work correctly for me.  This
> > was discussed in a thread sometimes ago.
> 
> Where are the patchs. I like to incorporate them into BK.
The patch exceeded 40K uncompressed, so here's a link:

http://i810fb.sourceforge.net/draw_ops.diff.gz

The diff is against 2.5.45 plus your fbdev.diff.

Tony

