Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267647AbTAHQ7P>; Wed, 8 Jan 2003 11:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267648AbTAHQ7P>; Wed, 8 Jan 2003 11:59:15 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:13070 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S267647AbTAHQ7O>; Wed, 8 Jan 2003 11:59:14 -0500
Subject: Re: [Linux-fbdev-devel] rotation.
From: Antonino Daplas <adaplas@pol.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
In-Reply-To: <Pine.LNX.4.44.0301072240530.17129-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0301072240530.17129-100000@phoenix.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1042044916.1003.144.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 09 Jan 2003 00:56:11 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-08 at 06:44, James Simmons wrote:
> 
> I'm about to implement rotation which is needed for devices like the ipaq. 
> The question is do we flip the xres and yres values depending on the 
> rotation or do we just alter the data that will be drawn to make the 
> screen appear to rotate. How does hardware rotate view the x and y axis?
> Are they rotated or does just the data get rotated? 
> 

If the graphics card has hardware support for rotation, then there is
nothing to be done.  It's the job of the driver if it wants to rotate
the display or not.  This is similar to video overlay mirroring.  What
the user app sees is the framebuffer in "normal" orientation, but what
gets displayed is mirrored.

However, as Geert mentioned, if you want to support rotation
generically, then you have to do it in the fbcon level.  The driver need
not know if the display is rotated or not.  All it needs to do is fill a
region with color, color expand a bitmap and move blocks of data, and
optionally 'pan' the window.  Fbcon will pass the correct (ie, oriented)
information for the driver.

This will not be too processor intensive as long as some data is
prepared beforehand, like a rotated fontdata.

The main difficulty with this approach is how do you tell the console to
rotate the display?  We cannot use fbset because the changes will not be
visible to fbcon. 

I submitted a patch before (see fbdev archives for "Console Rotation"
thread) that rotates the console this way.  I had vga16fb, vesafb, and
i810fb rotate the display without any driver code change. Display
panning was also supported.

However, because we use mmap to expose the framebuffer memory, we will
not be able to completely support rotation for user applications.  They
have to do it on their own.


Tony



