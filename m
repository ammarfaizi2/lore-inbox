Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWFABhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWFABhj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 21:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbWFABhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 21:37:39 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:16342 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751234AbWFABhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 21:37:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fEC+YVac3qaKU5aIKGc4Hqr+Pc9pfqruiZBQl3y+iCwuo9itVd4IAtf0prvRF01b/l88MTqvw/nLqTB6XD5JQK1d+MokROFJZIFCXk36FRUmZGhqeXt1cK5JCYgI5heb3dkjSjntnS75kmsCg72fIZthOFLBNuXJ5x4M1ng1Zog=
Message-ID: <9e4733910605311837w97316c8q3ac13798f74cb211@mail.gmail.com>
Date: Wed, 31 May 2006 21:37:28 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "D. Hazelton" <dhazelton@enter.net>, "Dave Airlie" <airlied@gmail.com>,
       "Pavel Machek" <pavel@ucw.cz>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <447E39DD.7000007@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605302314.25957.dhazelton@enter.net>
	 <9e4733910605302116s5a47f5a3kf0f941980ff17e8@mail.gmail.com>
	 <200605310026.01610.dhazelton@enter.net>
	 <9e4733910605302139t4f10766ap86f78e50ee62f102@mail.gmail.com>
	 <447E39DD.7000007@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> A minimal framebuffer driver is nothing but a pointer to a structure
> (struct fb_info) which contains a pointer to a memory and the description
> of the layout of this memory. There is nothing there that absolutely
> requires the services of the kernel, nor requires touching the hardware.
> If you look at vesafb, the only time it touches the hardware is in
> setcolreg (only if in pseudocolor), and pan_display, which is an optional
> function.
>
> The point here is that you can do the mode setting anywhere, including in
> userland.  Describe this mode as struct fb_info and register it to
> the framebuffer core, you already have a working driver and a working
> console.
>
> So, it should be easy enough to write a kernel framebuffer module that
> listens to userland, waiting for a struct fb_info to arrive. The userland
> driver can be anything, it can be a simple driver that executes a few VBE
> function calls, or a driver that uses a library, such as svgalib or Xorg.
> Add a few user API's for setcolreg and pan_display, and it will be a complete
> driver. Optionally, to fully accelerate the console, we only need these in X:
>
> ScreenToScreenCopy
> SolidFill
> CPUToScreenColorExpand
>
> Once the X library is used for this userland driver, we have eliminated the
> problem of fbdev conflicting with X or DRM. (This assumes that we can load
> an X instance at bare minimum, ie, without capturing the keyboard or the mouse).
>
> I believe that there will be problems that I haven't foreseen (trustworthiness
> of this driver?), but personally it's the best way to go, as we can work on
> one subsystem without affecting the others and without breaking compatibility.
> It should also be easy to work on, as the framebuffer layer has the simplest
> architecture among the three.

I'm with most of this it's when you get to the 'everything' in user
space part that I have concerns.

1) I think we have to maintain a device node and something like an
IOCTL interface. This allows a normal user to control the device
without needing root. I'm fine with the idea of the kernel driver
calling out to user space helpers. Not needing root to run the main X
server is a big issue for me.

2) I'd prefer the model of calling out to helper apps that exit
instead of having persistent daemons. Daemons can die and there is
difficulty in telling if they are unresponsive and need to be
restarted. I also think the callouts will be infrequent so why keep a
daemon hanging around. This implies a few things need to be cached in
the kernel driver, like the list of legal modes and the altered ROM
image.

3) fbdev, DRM and EXA are all programming the acceleration hardware.
This needs to move to a single interface. I'd suggest using DRM to
achieve acceleration and then modify the other two subsystems to call
it.

4) Some things are so tiny it is pointless to move them to user space
and they need root to work. Things like screen blank, set the hardware
cursor, set the cmap, etc. I think these are best implemented as
additions to the DRM driver.

5) All of this has to be small enough to fit into initramfs if we're
going to have a boot console on non-VGA systems.

6) There is no need to require a bounce out to user space and back for
these calls: ScreenToScreenCopy, SolidFill, CPUToScreenColorExpand.
DRM can optionally implement in-kernel entry points for these.

7) Since there isn't much left to a device specific fbdev driver after
you push mode setting out to user space, I would just add the
remaining functions to the device specific DRM driver. But that would
be 'evil' since it merges fbdev and DRM.

-- 
Jon Smirl
jonsmirl@gmail.com
