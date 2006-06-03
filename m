Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751514AbWFCFZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbWFCFZc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 01:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWFCFZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 01:25:32 -0400
Received: from smtp.enter.net ([216.193.128.24]:51205 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1751514AbWFCFZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 01:25:31 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: OpenGL-based framebuffer concepts
Date: Sat, 3 Jun 2006 01:25:19 +0000
User-Agent: KMail/1.8.1
Cc: Jon Smirl <jonsmirl@gmail.com>, Dave Airlie <airlied@gmail.com>,
       Ondrej Zajicek <santiago@mail.cz>, Pavel Machek <pavel@ucw.cz>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, adaplas@gmail.com
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <9e4733910606011918vc53bbag4ac5e353a3e5299a@mail.gmail.com> <24BBD756-4658-48A7-AD4D-1D25124A946B@mac.com>
In-Reply-To: <24BBD756-4658-48A7-AD4D-1D25124A946B@mac.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606030125.20907.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 June 2006 03:21, Kyle Moffett wrote:
> On Jun 1, 2006, at 22:18:07, Jon Smirl wrote:
> > On 6/1/06, Dave Airlie <airlied@gmail.com> wrote:
> >> of course, but that doesn't mean it can't re-use X's code, they
> >> are the best drivers we have. you forget everytime that the kernel
> >> fbdev drivers aren't even close, I mean not by a long long way
> >> apart from maybe radeon.
> >
> > I am aware that X has the best mode setting code and it would be
> > foolish to ignore it.
>
> You're kidding, right?  I've never been able to get X to get the
> modes right on my damn flatpanel.  Hell, it can't even match DDC
> channels to VGA ports without hand-holding in the config file.  To
> contrast, the fbdev layer gets it right every time on the whole
> variety of hardware that I've got.  Likewise the only way that I've
> ever gotten X to even set a vaguely functional mode on another card
> is by loading the framebuffer module first and specifying Option
> "UseFBDev" "true".  Anything else and the monitor goes off mode and
> there's no getting it back.

We'll use the best modesetting code we can find. Currently X refuses to do DDC 
via VESA on any modern card - I've seen this problem myself. The solution for 
the kernel graphics side of things would be to have it do all the probing in 
the userspace side (save where drmcon is concerned) and not limit that 
probing to just the EDID and i2c probing like X does.

As for the acceleration side of things... I'm not familiar enough with the X 
code to be able to pinpoint what the problem is, but part of it is definately 
the way DRM accesses the hardware. Apparently with any framebuffer driver 
loaded DRM can't give X full acceleration.

> >>> 9) there needs to be a way to control the mode on each head,
> >>> merged fb should also work. Monitor hotplug should work. Video
> >>> card hot plug should work. These should all work for console and
> >>> the display servers.
> >>
> >> Of course, have you got drivers for these written? this is mostly
> >> in the realms of the driver developer, the modesetting API is
> >> going to have to deal with all these concepts.
> >
> > This needs to be considered in the design stage. For example, if
> > both heads are mapped through a single device node they can't be
> > independently controlled by two different user IDs. We need to make
> > sure we leave the path open to building this.
>
> I kind of agree, but on the other hand there needs to be a way to
> specify multiple viewports in a single framebuffer like MergedFB on
> my radeon.  I would be quite happy to tinker with my little C-based
> framebuffer graphics apps in the console except that I can't
> manipulate the second display's view in the same framebuffer with fbset.

This is something that has been considered and marked as "TODO" on my list. 
It's not high up on that list because it's better to get the foundation for 
the system layed out before adding all the bells and whistles.

> > I meant support for Korean, Chinese, etc. You can't draw some of
> > the complex scripts without using something like Pango. Do we want
> > to build a system where people can use console in their native
> > language?  You can use these languages from xterm but not console
> > today. I have no strong opinion on this point other that I believe
> > it should be discussed and input from non-English speakers should
> > be considered. No one on this list has a problem with this area
> > since we all speak English.
>
> IMHO the best way to do this is leave basic 7-bit or 8-bit fonts in
> the kernel where they are now and do the rest from a little userspace
> framebuffer console.  With a secure-attention-key to revert to the
> native console for emergency debugging and such, set up so it can
> display panics, I think the rest would be much better handled with
> the flexibility and locale support of userspace.

I hadn't thought of using the SAK to pull up a "crash" console. Should be 
possible if we implement a safe console system like Jon has talked about, 
where all VT switching and such is handled totally in userspace. (I don't 
think it can be completely handled in userspace, just because of a few minor 
issues, but...)

> >> 14) backwards compatible, an old X server should still run on a
> >> new kernel. I will allow for new options to be enabled at run-time
> >> so that this isn't possible, but just booting a kernel and
> >> starting X should work.
> >
> > I'm not sure we want to continue supporting every X server released
> > in the last 25 years. But we should definitely support any X server
> > released in a 2.6 based kernel distribution. What are reasonable
> > limits?
>
> IMHO X is currently broken enough on much of my hardware that I'd be
> completely happy to be forced to upgrade.  My LCD has diagonal red
> scrolling when in X (works fine on the kernel console though) and X
> can't seem to hardware accelerate at all, even on this RV200 chip.

If only everyone felt like that. I know quite a few people that refuse to 
upgrade until there is something they want to do that the software or 
hardware doesn't allow.

> >> 16) secure - no direct IO or MMIO access, modesetting is slow
> >> anyways having the kernel checking the mmio access won't make it
> >> much slower.
> >
> > This needs some expansion. Secure is good, but it's not clear what
> > you are requiring with this point.
> >
> > For me security means reducing the privileged code to an absolute
> > minimum and then inspecting it closely to make sure there are no
> > holes. Everything that is passed in needs to be checked and
> > regarded with suspicion. But you can go too far with the reduction,
> > if you provide a generic IOCTL to poke an IO port with an arbitrary
> > value you now have to verify that it is safe to pass in every
> > possible value. Instead if the IOCTL implements a specific function
> > that pokes the port with a single fixed value it is easier to say
> > that it is secure.
>
> I'd personally rather not see any IOCTLs for poking of ports, I kinda
> like being able to script framebuffer drawing with a little bit of
> Perl or some hastily written C.  Calling FBIOGET_VSCREENINFO is fine,
> calling FBIO_POKE_OBSCURE_PORT is kinda iffy.  I realize there's no
> black and white but it would be nice to maintain some clarity of
> interface; make simple things simple and hard things possible.
>
> Cheers,
> Kyle Moffett

I feel the same way Kyle. I don't think direct access to the hardware should 
be allowed from outside the drm daemon. Route all acceleration through the 
drm daemon and it handles the tough stuff. Yes there will be a very minor 
performance hit, but it should be fine.

The reason Jon is so hot on having direct access like that is he feels that 
modesetting and a few other simple tasks should be handled by helpers and 
acceleration itself should be handled by userspace libraries, without the drm 
daemon at all.

DRH
