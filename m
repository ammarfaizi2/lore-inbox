Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbSLUDs2>; Fri, 20 Dec 2002 22:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261963AbSLUDs2>; Fri, 20 Dec 2002 22:48:28 -0500
Received: from pine.compass.com.ph ([202.70.96.37]:60681 "EHLO
	vhost.compass.com.ph") by vger.kernel.org with ESMTP
	id <S261934AbSLUDs1>; Fri, 20 Dec 2002 22:48:27 -0500
Subject: Re: [Linux-fbdev-devel] [PATCH] fix endian problem in
	color_imageblit
From: Antonino Daplas <adaplas@pol.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0212201932150.6471-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0212201932150.6471-100000@phoenix.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1040442194.1294.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Dec 2002 11:45:44 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-12-21 at 03:54, James Simmons wrote:
> 
> > Nice catch :-)  We also need a similar fix for slow_imageblit(), so
> > James can you apply the attached patch also:
> 
> Applied.
> 
> > Also, I noticed that some drivers load the pseudo_palette with entries
> > whose length matches the length of the pixel.  The cfb_* functions
> > always assume that each pseudo_palette entry is an "unsigned long", so
> > bpp16 will segfault, and so will bpp24/32 for 64-bit machines.
> 
> I just noticed that as well. Russell King pointed to it too. I fixed
> the unsigned long problem in color_imageblit. All the pseudo_palette
> in cfb_* are assumed u32. Is this safe for 16bpp or 8 bpp modes? I will

The pseudopalette will only matter for truecolor and directcolor as the
rest of the visuals bypasses the pseudopalette.  Typecasting to
"unsigned long" rather than "u32" is also safer (even for bpp16) since
in 64-bit machines, the drawing functions use fb_writeq instead of
fb_writel.  So, all drivers using the cfb_* functions should change from
"u32" to "unsigned long" _whatever_ the bit depth when loading the
pseudopalette.

Of course, drivers with their own drawing functions can use whatever
they want.

Tony 

PS:  cfb_fillrect is still limited to u32 though which can hopefully be
fixed in the future.


