Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267044AbSLKHoL>; Wed, 11 Dec 2002 02:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267047AbSLKHoL>; Wed, 11 Dec 2002 02:44:11 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:14087 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S267044AbSLKHoK>; Wed, 11 Dec 2002 02:44:10 -0500
Subject: Re: [TRIVIAL PATCH] FBDEV: Small impact patch for fbdev
From: Antonino Daplas <adaplas@pol.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0212102155280.2617-100000@maxwell.earthlink.net>
References: <Pine.LNX.4.33.0212102155280.2617-100000@maxwell.earthlink.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1039603105.1084.73.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Dec 2002 15:45:36 +0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-11 at 10:59, James Simmons wrote:
> 
> > Here's a diff to correct several small things that escaped through the
> > cracks.
> 
> Ug. Now that a wider test base is being done and more drivers actually
> compile we are going to see more cracks.
> 
> > 1.  The YNOMOVE scrollmode for non-accelerated drivers is just very slow
> > because of a lot of block moves (leads to slow and jerky scrolling in
> > vesafb with ypanning enabled).  Depending on var->accel_flags, set the
> > scrollmode to either YREDRAW or YNOMOVE. For drivers with hardware
> > acceleration, set var->accel_flags to nonzero for max speed.
> 
I think the scrollmode is better determined on a case-to-case basis, but
the above should be a good enough differentiation.

> Thanks. I have had several emails complementing the speed improvements.
> Another speed boost will be a plus.
> 
Yes, probably not much at low pixel depths, but at high pixel depths and
resolutions, 2.5 should be much better than 2.4 (even 2-3x faster in
some cases).  And for drivers with hardware acceleration, whatever the
color depth, it will be much better because they were written
specifically for them. 

Personally, the performance gain is just a minor side-effect. The
greatest benefit in all this is the separation of the fbdev-fbcon
structure into components, where each component has a defined use and
function, and very much independent of each other.  This really makes it
easier to understand the code, port or write drivers too it, write
smaller and more efficient code, and even debug.  And you basically did
all this, so great job :-)  

 > > 2.  fb_pan_display() always returns an error.  User apps will
complain.
> 
> Fixed. Actually I used the following code.
> 
> int fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
> {
>         int xoffset = var->xoffset;
>         int yoffset = var->yoffset;
>         int err;
> 
>         if (xoffset < 0 || yoffset < 0 || info->fbops->fb_pan_display ||
>             xoffset + info->var.xres > info->var.xres_virtual ||
>             yoffset + info->var.yres > info->var.yres_virtual)
>                 return -EINVAL;
>         if ((err = info->fbops->fb_pan_display(var, info)))
>                 return err;
>         info->var.xoffset = var->xoffset;
>         info->var.yoffset = var->yoffset;
>         if (var->vmode & FB_VMODE_YWRAP)
> 
> instead. The reason is I didn't like the idea of xoffset and yoffset being
> changed even if the hardware panning function failed. Comments?
> 
Yes, I think thats better.

Tony

