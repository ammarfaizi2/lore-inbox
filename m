Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWE2DRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWE2DRD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 23:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWE2DRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 23:17:03 -0400
Received: from smtp.enter.net ([216.193.128.24]:40197 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1751117AbWE2DRC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 23:17:02 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: "Dave Airlie" <airlied@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Date: Sun, 28 May 2006 23:16:50 +0000
User-Agent: KMail/1.8.1
Cc: "Jon Smirl" <jonsmirl@gmail.com>, "Pavel Machek" <pavel@ucw.cz>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200605280112.01639.dhazelton@enter.net> <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com>
In-Reply-To: <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605282316.50916.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 28 May 2006 23:13, Dave Airlie wrote:
> > > For a specific DRM chip there are currently four modules:
> > > fbdev-core
> > > fbdev-chip depends on fbdev-core
> > > drm-core
> > > drm-chip depends on drm-core
> > > RIght now drm and fbdev can be loaded independently.
> > >
> > > I would always keep fbdev-core and drm-core as separate modules.  But
> > > drm-core may become dependent on fbdev-core.
>
> I've already pointed out to Jon the problems with this approach on
> numerous occasions and to be honest do not have the time to do so
> again,
>
> I will not accept patches to make DRM drivers rely on fbdev drivers in
> the kernel for many many many reasons, two quick ones :

So it's a personal thing? God, kernel politics are starting to sicken me.

> a) we don't always have a fully functional fbdev driver, see intel fb
> drivers. 

Okay. That means the intel fbdev drivers will advance significantly through 
the process of having the DRM drivers rely on the fbdev driver as a lower 
layer. I've already started work on this and find that the current fbdev code 
does things in a strange manner, not even using the PCI bus mechanisms in the 
kernel to find the hardware.

Yes, a few drivers do this, but by and large any system currently in use will 
have it's video card on the PCI or AGP bus, including all those cards now 
being manufactured for the PCI-E systems.

Furthermore, having DRM rely on fbdev for device discovery and memory 
allocation means that the kernel, via the fbdev layer, will gain the capacity 
to flip the video mode to something sane on an oops or panic and display the 
information.

While I feel it isn't exactly necessary for an oops, having the kernel able to 
tell the user what's going on when it panics is a good thing. Doubly so for 
those panics that happen when X is running - currently that's a silent death. 
I've had to rebuild my system twice because of panics during X that killed 
various bits.

> b) loading fbdev drivers breaks X in a lot of cases, we need to be 
> a bit more careful.

Unlike what Jon says about this being a problem with X, I happen to feel this 
is more likely a problem with the way only 2 (of 60 or so) fbdev drivers find 
and bind to the hardware.

Yes, this is a strange thing to do, relying on finding the ROM of a card at a 
specific location and requiring said ROM to have certain signatures. An 
easier method is to use PCI bus discovery - pci_get_subsys() and 
pci_dev_get() - for locating the cards.

Yes, there should be an alternate probe method for systems where this won't 
work. I can't argue against that, but the current method used in most of the 
drivers should be the alternate, not the other way around.

> c) Lots of distros don't use fbdev drivers, forcing this on them to
> use drm isn't an option.

what distro's? The only ones that don't are either the ones that hold the 
users hand or the ones where the user is meant to be able to quickly change 
and modify the system.

In the first case the user is likely not going to see much of the console. But 
having fbdev act as a low-level system for those DRM drivers that fbdev 
drivers exist for (sometimes doubled or tripled - like the case of DRM-CVS's 
nv driver and the nvidiafb and rivafb drivers and sometimes not) is a step 
towards fully modernizing the linux graphics system and bringing it back to a 
"one device, one driver" system that should exist.

> should I go on?
>
> I've made suggestions I've given you patches that start the work, I'm
> going to finish that work, but I've no timeline, I'd hope at KS/OLS
> this year to do it..
>
> Dave.

I'm using those patches and a lot of sweat as a guide for turning the fbdev 
core layer for graphics drivers. This solves a lot of the complexity of a 
middle-layer because the fbdev core layer is going to do nothing more than 
handle device discovery, device DMA and such things. The fbdev chip drivers 
and the DRM system will use it as the backbone and a way of 
cross-communicating.

In such a case as where a DRM chip driver and an fbdev chip driver both exist 
for a piece of hardware, the DRM driver will use facilities exposed in the 
fbdev chip driver to function. Yes, binding the DRM chip driver like that 
will force distro's to support the fbdev system, but the conflicts you 
mention above will disappear because the systems now know the other exists 
and don't do things that the other doesn't know about.

I'm sure any patches I produce will get NACK'd by you because of some arcane 
kernel politics, but after witnessing this shitstorm and letting myself get 
talked into the work after just tossing out a few ideas I really could care 
less. Something needs to be done, has been needed to be done since the 
fbdev/DRM split appeared and nobody is doing it.

I've got a hell of a lot of free time right now, I'm so totally bored wityh my 
private projects it's not funny and this is something to keep me busy for a 
long time. You fdon't like it? Fine - but at least look at it for the code 
and it's merits - because I don't deal with people that will let their 
personal feelings get in the way of their judgement.

DRH
(and yes, I am a bit pissed off. Deal with it.)
