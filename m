Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbWFACgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWFACgi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 22:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWFACgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 22:36:38 -0400
Received: from smtp.enter.net ([216.193.128.24]:41990 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1751273AbWFACgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 22:36:37 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Date: Wed, 31 May 2006 22:36:26 +0000
User-Agent: KMail/1.8.1
Cc: "Antonino A. Daplas" <adaplas@gmail.com>,
       "Dave Airlie" <airlied@gmail.com>, "Pavel Machek" <pavel@ucw.cz>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <447E493E.1090808@gmail.com> <9e4733910605311919x2cd1847cx90b5353cf6b325f6@mail.gmail.com>
In-Reply-To: <9e4733910605311919x2cd1847cx90b5353cf6b325f6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605312236.27690.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 June 2006 02:19, Jon Smirl wrote:
> On 5/31/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> > > 4) Some things are so tiny it is pointless to move them to user space
> > > and they need root to work. Things like screen blank, set the hardware
> > > cursor, set the cmap, etc. I think these are best implemented as
> > > additions to the DRM driver.
> >
> > These small things (cmap, blanking) are sometimes difficult to do, and
> > the driver is not always right about that. A user helper may be needed.
> > vesafb in x86_64 may not be able to set the cmap properly without calling
> > out to the BIOS.
>
> Call out to user space if it is complex. But it only takes few lines
> of code to to these things on a radeon.

I'll be working with Tony on a lot of the fbdev side of things. Hopefully we 
won't run into problems providing for backwards compatability.

> > > 7) Since there isn't much left to a device specific fbdev driver after
> > > you push mode setting out to user space, I would just add the
> > > remaining functions to the device specific DRM driver. But that would
> > > be 'evil' since it merges fbdev and DRM.
> >
> > Actually, there's no need for a merge as there is nothing in DRM that
> > is absolutely needed by fbdev or the other way around, as long as
> > console acceleration is disabled. In-kernel fbdev drivers may not even
> > be necessary.
>
> Something needs to bind to the hardware, that code is in the device
> specific fbdev drivers currently. The fbdev drivers also contain those
> small functions I mentioned like cmap, cursor, etc. Some of the fbdev
> drivers also contain initialization code.
>
> If fbdev is eliminated the DRM code will need to provide a compatible
> fbdev device in user space for legacy apps. It makes sense to get that
> code from fbdev.

I've been talking with Tony and this seems to be the direction he'd like to 
take the Kernel. While I'd like to keep the full complement of fbdev drivers 
in the kernel for the embedded people to use (or not) as they please, this 
might not be a good idea.

> Any concerns about having two device nodes for a single piece of
> hardware, fb0 and dri0? Since dri0 has a single user it may be
> possible to rework its IOCTLs to use the fb0 device.
>
> As part of multiuser support you need to make one device per head
> instead of one device per card. Each independent user needs their own
> deivce to control.

I was thinking that the dri? nodes could redirect fb specific IOCTL's 
internally and still maintain the two device nodes. This is actually part of 
not breaking anything, since a lot of legacy apps will look for the dri* or 
fb* nodes.

And yes, providing a device per head is something that needs to happen, if 
just to make things like a multi-head Radeon easier to configure and bring up 
both heads on under X.

As to having seperate devices per user - the only cases this would be really 
required are:
1) Multiple users logged onto different VT's
2) Remote users doing server-side acceleration of graphics

For #1 there is no need for seperate devices, since both users are using the 
same display and input methods (unless configured different - say with 
multiple heads and input devices, in which case the second head would already 
have a node available for it).

For #2 I have no real solution. Personally I think that most of the drawing 
commands that can be accelerated should be left to the remote client. As far 
as a remote client wanting sever side rendering and acceleration... This can 
use the same device node and a seperate rendering buffer.The driver itself 
*should* be able to handle accelerating offscreen and oinscreen rendering at 
the same time.

DRH
