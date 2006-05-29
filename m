Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWE2E0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWE2E0D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 00:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWE2E0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 00:26:03 -0400
Received: from smtp.enter.net ([216.193.128.24]:60686 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1751166AbWE2E0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 00:26:01 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Date: Mon, 29 May 2006 00:25:49 +0000
User-Agent: KMail/1.8.1
Cc: "Dave Airlie" <airlied@gmail.com>, "Pavel Machek" <pavel@ucw.cz>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200605282316.50916.dhazelton@enter.net> <9e4733910605282105t656b7c11i3809105cf261741@mail.gmail.com>
In-Reply-To: <9e4733910605282105t656b7c11i3809105cf261741@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605290025.50100.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 May 2006 04:05, Jon Smirl wrote:
> On 5/28/06, D. Hazelton <dhazelton@enter.net> wrote:
> > Okay. That means the intel fbdev drivers will advance significantly
> > through the process of having the DRM drivers rely on the fbdev driver as
> > a lower layer. I've already started work on this and find that the
> > current fbdev code does things in a strange manner, not even using the
> > PCI bus mechanisms in the kernel to find the hardware.
>
> Most of the fbdev drivers use the PCI bus mechanism to find their
> hardware. Some of the ones that don't run in boxes that don't have a
> PCI bus. I don't know of any PCI based fbdev drivers not using the PCI
> support, what is an example of one?


Radeon, Riva, Nvidia... Shall I continue? I've only found 2 that actually use 
the PCI binding calls like "pci_get_subsys()" and "pci_dev_get()"

> > > b) loading fbdev drivers breaks X in a lot of cases, we need to be
> > > a bit more careful.
> >
> > Unlike what Jon says about this being a problem with X, I happen to feel
> > this is more likely a problem with the way only 2 (of 60 or so) fbdev
> > drivers find and bind to the hardware.
>
> It a problem with X because shouldn't be messing with hardware
> controlled by a device driver loaded by the kernel. My choice of
> kernel device drivers I have loaded should not break X if X was
> obeying the rules.

As noted above, only 2 of the fbdev drivers (that I've grepped the soruce of) 
actually use the PCI subsystem calls such as "pci_get_subsys()" and 
"pci_dev_get()"

> > Yes, this is a strange thing to do, relying on finding the ROM of a card
> > at a specific location and requiring said ROM to have certain signatures.
> > An easier method is to use PCI bus discovery - pci_get_subsys() and
> > pci_dev_get() - for locating the cards.
>
> The DRM modules don't use PCI support for locating their cards.
> Instead they use a convoluted scheme where the X server tell them
> which cards to bind to. The fbdev drivers should be using the normal
> PCI system.

Incorrect. In the DRI code currently in the 2.6.16.18 kernel the DRM modules 
use "pci_find_subsys()" and "pci_dev_get()" to locate the devices in a 
system.

> Look in include/pci.h, there is an API for accessing the ROMs. The
> signature is verified just to make sure that the right ROM was found.
> That check only fails when your hardware is messed up. There are three
> (sti, matrox, sis) fbdev drivers directly manipulating their ROM when
> they should be using the ROM API.
> http://bugzilla.kernel.org/show_bug.cgi?id=6572 Look at the radeon
> driver for an example.
>
> Don't use the code in DRM CVS that loops over the PCI devices checking
> to see if they are bound or not. That code was only there as a way to
> work around fbdev, merging with fbdev eliminates the need for it.
>
> > In such a case as where a DRM chip driver and an fbdev chip driver both
> > exist for a piece of hardware, the DRM driver will use facilities exposed
> > in the fbdev chip driver to function. Yes, binding the DRM chip driver
> > like that will force distro's to support the fbdev system, but the
> > conflicts you mention above will disappear because the systems now know
> > the other exists and don't do things that the other doesn't know about.
>
> This is accurate, the problems are caused by the various drivers
> conflicting. Get rid of multiple drivers and the conflicts go away.

Same difference, Jon.

> > I'm sure any patches I produce will get NACK'd by you because of some
> > arcane kernel politics, but after witnessing this shitstorm and letting
> > myself get talked into the work after just tossing out a few ideas I
> > really could care less. Something needs to be done, has been needed to be
> > done since the fbdev/DRM split appeared and nobody is doing it.
>
> Historically fbdev existed first and DRM came along later so they have
> always been split. The OS independent model of X and DRM made sense in
> the 90s, but now Linux has advanced to the point where this no longer
> makes sense. It's time to update our thinking on how video works.

I know, but I wasn't going to point this out to people on LKML who should 
already know things like this.

> > I've got a hell of a lot of free time right now, I'm so totally bored
> > wityh my private projects it's not funny and this is something to keep me
> > busy for a long time. You fdon't like it? Fine - but at least look at it
> > for the code and it's merits - because I don't deal with people that will
> > let their personal feelings get in the way of their judgement.
>
> There is plenty of work to do on graphics and lots of flame wars too.

Not by me. I give up - nothing I might do stands a smowballs chance in hell of 
surviving in a recognizable form  through the web of kernel politics.

DRH
