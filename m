Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965017AbWE1COK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965017AbWE1COK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 22:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbWE1COJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 22:14:09 -0400
Received: from smtp.enter.net ([216.193.128.24]:9225 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S965017AbWE1COI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 22:14:08 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Date: Sat, 27 May 2006 22:13:57 +0000
User-Agent: KMail/1.8.1
Cc: "Pavel Machek" <pavel@ucw.cz>, "Dave Airlie" <airlied@gmail.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200605271801.36942.dhazelton@enter.net> <9e4733910605271703p5f9de85dw74bc97d86d9a3cd7@mail.gmail.com>
In-Reply-To: <9e4733910605271703p5f9de85dw74bc97d86d9a3cd7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605272213.58015.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 28 May 2006 00:03, Jon Smirl wrote:
> On 5/27/06, D. Hazelton <dhazelton@enter.net> wrote:
> > On Friday 26 May 2006 17:39, Pavel Machek wrote:
> > > Could fb and drm simply be 'merged' into one driver (at least as far
> > > as rest of system is concerned)? That should have no driver model
> > > issues...?
> > >                                                       Pavel
> >
> > And such was my original idea. However I've been informed that doing such
> > would either constitute "Breaking working systems" or "introducing a
> > third and unneeded driver".
> >
> > For that reason I've begun doing a bit of research and planning... it
> > might show fruit in a couple of days.
>
> The simplest solution to starting a DRM/fbdev merge is to declare
> fbdev the bottom layer that binds to the hardware. Doing this is easy
> since the fbdev drivers already contain code for binding to the
> hardware. If you don't do this and instead create a new bottom layer
> that binds, you are forced into modifying the 60 existing fbdev
> drivers to remove their binding code and to use the new layer. I don't
> see anyone volunteering to edit 60 fbdev drivers.

Okay. This, at least, sounds like a system that should work. I was thinking of 
similar, but after the shitstorm that I saw over the idea I decided to wait 
and do some research.

> DRM drivers currently works in stealth mode. They use the graphics
> hardware without attaching to it like a normal PCI driver would. Using
> hardware in stealth mode is a bad design, but DRM can't be modified to
> attach to the PCI device because it would conflict with the fbdev
> driver that is already attached.

Yes, I noticed this while studying the DRM code. Part of me doing this, 
actually, will also be updating the DRM in kernel to the latest release. 
(Doing such provides at least one new DRM driver that already has it's X 
counterpart in the 6.8.2 tree)

> So, the easiest way to fix this is to change the eight DRM drivers in
> the kernel so that they are linked to their corresponding fbdev
> driver. After these changes you would not be able to load the DRM
> drivers without also loading their corresponding base fbdev driver.
> The embedded people are still happy since they can load fbdev and
> ignore DRM. Note that you can use symbols to create a dependency
> without changing the existing functions of either driver.

Okay. Sounds easy enough. Just need to have DRM reliant on symbols in the 
fbdev code. And you are correct about the embedded people - I'd actually 
forgotten about them when I originally made the proposal of merging DRM with 
fbdev.

> Making the drivers dependent starts us down the path of a full merge
> and having one driver in control of the hardware. As part of the basic
> merge patch I would also move the drm directory from drivers/char/drm
> to drivers/video/drm. After this very basic linkage is established you
> can start making real changes.

Fully merging fbdev with DRM would really create some problems for the 
embedded people. If the design of using the fbdev driver as a base layer and 
the DRM drivers as an acceleration layer works then that's all that's truly 
needed. Merging the DRM and fbdev code bases would create a situation where 
the embedded people would have to configure *out* the DRM code that has been 
merged into the fbdev drivers. Not only would such a thing create potential 
bugs in the system, it is a step that could create problems with people 
maintaining the .config's for those systems.

> BTW, I have already submitted a patch that does this and it was
> rejected. I might be able to find it somewhere, but the dependency
> code is not very hard to write.

If you can find it Jon, I'd appreciate it. If not, then I'll have to dive into 
the code head first and hope I don't drown in it.

DRH
