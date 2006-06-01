Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965180AbWFAB4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965180AbWFAB4q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 21:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965275AbWFAB4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 21:56:46 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:1124 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965180AbWFAB4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 21:56:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=L0vEOarjeZlvuGLmSmH9qhuIk0WtyGtTGDUOrvJRl0Gv6sbUJxu7o+diJNwaz82cEWmZk3fos028pzxt8qUaXZv5UlMAmY8YcDJVH8aQNQG4QZeP89jre6eJgKfwmdLIxy0oKdCj+riyKiDJQIRZ0qxQvhhbEs/e2/P0Ja/X4VM=
Message-ID: <447E493E.1090808@gmail.com>
Date: Thu, 01 Jun 2006 09:56:14 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: "D. Hazelton" <dhazelton@enter.net>, Dave Airlie <airlied@gmail.com>,
       Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>	 <200605302314.25957.dhazelton@enter.net>	 <9e4733910605302116s5a47f5a3kf0f941980ff17e8@mail.gmail.com>	 <200605310026.01610.dhazelton@enter.net>	 <9e4733910605302139t4f10766ap86f78e50ee62f102@mail.gmail.com>	 <447E39DD.7000007@gmail.com> <9e4733910605311837w97316c8q3ac13798f74cb211@mail.gmail.com>
In-Reply-To: <9e4733910605311837w97316c8q3ac13798f74cb211@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On 5/31/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> A minimal framebuffer driver is nothing but a pointer to a structure
>> (struct fb_info) which contains a pointer to a memory and the description
>> of the layout of this memory. There is nothing there that absolutely
>> requires the services of the kernel, nor requires touching the hardware.
>> If you look at vesafb, the only time it touches the hardware is in
>> setcolreg (only if in pseudocolor), and pan_display, which is an optional
>> function.
>>
>> The point here is that you can do the mode setting anywhere, including in
>> userland.  Describe this mode as struct fb_info and register it to
>> the framebuffer core, you already have a working driver and a working
>> console.
>>
>> So, it should be easy enough to write a kernel framebuffer module that
>> listens to userland, waiting for a struct fb_info to arrive. The userland
>> driver can be anything, it can be a simple driver that executes a few VBE
>> function calls, or a driver that uses a library, such as svgalib or Xorg.
>> Add a few user API's for setcolreg and pan_display, and it will be a
>> complete
>> driver. Optionally, to fully accelerate the console, we only need
>> these in X:
>>
>> ScreenToScreenCopy
>> SolidFill
>> CPUToScreenColorExpand
>>
>> Once the X library is used for this userland driver, we have
>> eliminated the
>> problem of fbdev conflicting with X or DRM. (This assumes that we can
>> load
>> an X instance at bare minimum, ie, without capturing the keyboard or
>> the mouse).
>>
>> I believe that there will be problems that I haven't foreseen
>> (trustworthiness
>> of this driver?), but personally it's the best way to go, as we can
>> work on
>> one subsystem without affecting the others and without breaking
>> compatibility.
>> It should also be easy to work on, as the framebuffer layer has the
>> simplest
>> architecture among the three.
> 
> I'm with most of this it's when you get to the 'everything' in user
> space part that I have concerns.
> 
> 1) I think we have to maintain a device node and something like an
> IOCTL interface. This allows a normal user to control the device
> without needing root. I'm fine with the idea of the kernel driver
> calling out to user space helpers. Not needing root to run the main X
> server is a big issue for me.
> 
> 2) I'd prefer the model of calling out to helper apps that exit
> instead of having persistent daemons. Daemons can die and there is
> difficulty in telling if they are unresponsive and need to be
> restarted. I also think the callouts will be infrequent so why keep a
> daemon hanging around. This implies a few things need to be cached in
> the kernel driver, like the list of legal modes and the altered ROM
> image.

Does not matter.
 
> 
> 3) fbdev, DRM and EXA are all programming the acceleration hardware.
> This needs to move to a single interface. I'd suggest using DRM to
> achieve acceleration and then modify the other two subsystems to call
> it.

Programming 2D is entirely optional in terms of fbdev.  It's only user
is fbcon.  You can leave 2D to DRM or X if you want.

> 
> 4) Some things are so tiny it is pointless to move them to user space
> and they need root to work. Things like screen blank, set the hardware
> cursor, set the cmap, etc. I think these are best implemented as
> additions to the DRM driver.

These small things (cmap, blanking) are sometimes difficult to do, and
the driver is not always right about that. A user helper may be needed.
vesafb in x86_64 may not be able to set the cmap properly without calling
out to the BIOS.

> 
> 5) All of this has to be small enough to fit into initramfs if we're
> going to have a boot console on non-VGA systems.

We can always leave fbdev drivers in the kernel for architectures where
they're the only ones available.

> 
> 6) There is no need to require a bounce out to user space and back for
> these calls: ScreenToScreenCopy, SolidFill, CPUToScreenColorExpand.
> DRM can optionally implement in-kernel entry points for these.

Agree, fbdev does not require acceleration to be fast.  This is something
we can leave out. As mentioned in another thread, an unaccelerated fbdev
driver can have comparable performance with a pure text mode driver.

> 
> 7) Since there isn't much left to a device specific fbdev driver after
> you push mode setting out to user space, I would just add the
> remaining functions to the device specific DRM driver. But that would
> be 'evil' since it merges fbdev and DRM.
> 

Actually, there's no need for a merge as there is nothing in DRM that
is absolutely needed by fbdev or the other way around, as long as
console acceleration is disabled. In-kernel fbdev drivers may not even
be necessary.

Tony
