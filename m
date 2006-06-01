Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWFBCem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWFBCem (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 22:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWFBCem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 22:34:42 -0400
Received: from smtp.enter.net ([216.193.128.24]:60426 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1751149AbWFBCel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 22:34:41 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Date: Thu, 1 Jun 2006 22:34:30 +0000
User-Agent: KMail/1.8.1
Cc: "Dave Airlie" <airlied@gmail.com>, "Ondrej Zajicek" <santiago@mail.cz>,
       "Pavel Machek" <pavel@ucw.cz>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, adaplas@gmail.com
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <21d7e9970606011815y226ebb86ob42ec0421072cf07@mail.gmail.com> <9e4733910606011918vc53bbag4ac5e353a3e5299a@mail.gmail.com>
In-Reply-To: <9e4733910606011918vc53bbag4ac5e353a3e5299a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606012234.31566.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 June 2006 02:18, Jon Smirl wrote:
> On 6/1/06, Dave Airlie <airlied@gmail.com> wrote:
> > > Without specifying a design here are a few requirements I would have:
> > >
> > > 1) The kernel subsystem should be agnostic of the display server. The
> > > solution should not be X specific. Any display system should be able
> > > to use it, SDL, Y Windows, Fresco, etc...
> >
> > of course, but that doesn't mean it can't re-use X's code, they are
> > the best drivers we have. you forget everytime that the kernel fbdev
> > drivers aren't even close, I mean not by a long long way apart from
> > maybe radeon.
>
> This requirement means that stuff like mode setting has to be broken
> out into an independent library. For example it would not be ok to say
> that Fresco has to install X to get mode setting. No comment was made
> on where the code comes from, you are reading in something that isn't
> in the requirement.. I am aware that X has the best mode setting code
> and it would be foolish to ignore it.
>
> Both you and I both know what a pain it is to extract this type of
> code from X. Let's not repeat X's problems in this area. Let's make
> the new library standalone and easy to work with in any environment.
> No all encompassing typedef systems this time.

Jon, I've already discussed this with Dave. Part of providing a "drmcon" will 
involve having libraries that currently almost always rely on X being loaded 
modified to allow for use whether or not X is running. To this end I plan on 
working on the current set of userspace drivers (the DRI side of the DRM/DRI 
pair) in X to make them usable by the drmcon system.

> > > 2) State inside the hardware is maintained by a single driver. No
> > > hooks for state swapping (ie, save your state, now I'll load mine,
> > > ...).
> >
> > We still have to do state swapping, we just don't expose it,
> > suspend/resume places state swapping as a requirement.
>
> I don't consider suspend/resume state swapping, it is state save and
> restore. The same state is loaded back in.
>
> Other than suspend/resume why would the driver need to do state swapping?

VT switch to a VT where X is running. X will still require a VT and assume it 
has good access to the graphics system. While currently it has no problems, 
when drmcon becomes a reality there will have to be a state switch between 
the consoles settings and the setting for the VT running X.

> > > 9) there needs to be a way to control the mode on each head, merged fb
> > > should also work. Monitor hotplug should work. Video card hot plug
> > > should work. These should all work for console and the display
> > > servers.
> >
> > Of course, have you got drivers for these written? this is mostly in
> > the realms of the driver developer, the modesetting API is going to
> > have to deal with all these concepts.
>
> This needs to be considered in the design stage. For example, if both
> heads are mapped through a single device node they can't be
> independently controlled by two different user IDs. We need to make
> sure we leave the path open to building this.

Exactly. This is part of keeping the kernel as secure as possible.

> > > 10) Console support for complex scripts should get consideration.
> >
> > not really necessary.. nor should it be... fbset works, something like
> > it would be good enough..
>
> I meant support for Korean, Chinese, etc. You can't draw some of the
> complex scripts without using something like Pango. Do we want to
> build a system where people can use console in their native language?
> You can use these languages from xterm but not console today. I have
> no strong opinion on this point other that I believe it should be
> discussed and input from non-English speakers should be considered. No
> one on this list has a problem with this area since we all speak
> English.

At current the best direction forward would be to just use the code from 
directfb-gtk to get Pango running for drmcon. Once that happens there is time 
for the coders to work out a complete solution that is seperate from PANGO 
and all other libraries if it's felt that it's still needed.

> > 14) backwards compatible, an old X server should still run on a new
> > kernel. I will allow for new options to be enabled at run-time so that
> > this isn't possible, but just booting a kernel and starting X should
> > work.
>
> I'm not sure we want to continue supporting every X server released in
> the last 25 years. But we should definitely support any X server
> released in a 2.6 based kernel distribution. What are reasonable
> limits?

This is not a supportable position, Jon. I haven't seen it myself, but I'm 
willing to bet there are still a few systems out there running X5 but have a 
recent kernel. Since X version prior to 6 are no longer in wide use, however, 
this is something that could be done with little damage to anyone.

But it still breaks the spirit of Linus' directive to "break nothing"

> > 15) re-use as much of the X drivers as possible, otherwise it will KGI.
>
> I would broaden this to use the best code where ever it is found. Of
> course X is a major source.
>
> > 16) secure - no direct IO or MMIO access, modesetting is slow anyways
> > having the kernel checking the mmio access won't make it much slower.
>
> This needs some expansion. Secure is good, but it's not clear what you
> are requiring with this point.
>
> For me security means reducing the privileged code to an absolute
> minimum and then inspecting it closely to make sure there are no
> holes. Everything that is passed in needs to be checked and regarded
> with suspicion. But you can go too far with the reduction, if you
> provide a generic IOCTL to poke an IO port with an arbitrary value you
> now have to verify that it is safe to pass in every possible value.
> Instead if the IOCTL implements a specific function that pokes the
> port with a single fixed value it is easier to say that it is secure.

At this poitn Dave has done a good job of keeping the DRM thats in kernel 
secure. I'll be working on the same with him as work on drmcon progresses. 
Doing the type of bounds-checking you mention at the end isn't really 
necessary, as there are only a few valid values - the code can and will check 
for those and reject ones that are invalid.

DRH
