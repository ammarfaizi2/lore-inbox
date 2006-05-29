Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWE2EFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWE2EFO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 00:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWE2EFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 00:05:14 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:16628 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751162AbWE2EFM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 00:05:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kPapIvMbh747b8dhZoFQc4ngYRSfSRVuBAx6uhBJwouWeU2ir5LUiqQ0lRXzXN4YcHmF5z0XAjffoK+31NGDnvqXPi1u5QejZC/QxTrAzQMDvq1yr22kfAYY/SVXrdYNND5J90RtNbfDKlj58ekYYNhFHw+iGBVzYOhwTdjyPWY=
Message-ID: <9e4733910605282105t656b7c11i3809105cf261741@mail.gmail.com>
Date: Mon, 29 May 2006 00:05:11 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "D. Hazelton" <dhazelton@enter.net>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Dave Airlie" <airlied@gmail.com>, "Pavel Machek" <pavel@ucw.cz>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <200605282316.50916.dhazelton@enter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605280112.01639.dhazelton@enter.net>
	 <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com>
	 <200605282316.50916.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/06, D. Hazelton <dhazelton@enter.net> wrote:
> Okay. That means the intel fbdev drivers will advance significantly through
> the process of having the DRM drivers rely on the fbdev driver as a lower
> layer. I've already started work on this and find that the current fbdev code
> does things in a strange manner, not even using the PCI bus mechanisms in the
> kernel to find the hardware.

Most of the fbdev drivers use the PCI bus mechanism to find their
hardware. Some of the ones that don't run in boxes that don't have a
PCI bus. I don't know of any PCI based fbdev drivers not using the PCI
support, what is an example of one?

> > b) loading fbdev drivers breaks X in a lot of cases, we need to be
> > a bit more careful.
>
> Unlike what Jon says about this being a problem with X, I happen to feel this
> is more likely a problem with the way only 2 (of 60 or so) fbdev drivers find
> and bind to the hardware.

It a problem with X because shouldn't be messing with hardware
controlled by a device driver loaded by the kernel. My choice of
kernel device drivers I have loaded should not break X if X was
obeying the rules.

> Yes, this is a strange thing to do, relying on finding the ROM of a card at a
> specific location and requiring said ROM to have certain signatures. An
> easier method is to use PCI bus discovery - pci_get_subsys() and
> pci_dev_get() - for locating the cards.

The DRM modules don't use PCI support for locating their cards.
Instead they use a convoluted scheme where the X server tell them
which cards to bind to. The fbdev drivers should be using the normal
PCI system.

Look in include/pci.h, there is an API for accessing the ROMs. The
signature is verified just to make sure that the right ROM was found.
That check only fails when your hardware is messed up. There are three
(sti, matrox, sis) fbdev drivers directly manipulating their ROM when
they should be using the ROM API.
http://bugzilla.kernel.org/show_bug.cgi?id=6572 Look at the radeon
driver for an example.

Don't use the code in DRM CVS that loops over the PCI devices checking
to see if they are bound or not. That code was only there as a way to
work around fbdev, merging with fbdev eliminates the need for it.

> In such a case as where a DRM chip driver and an fbdev chip driver both exist
> for a piece of hardware, the DRM driver will use facilities exposed in the
> fbdev chip driver to function. Yes, binding the DRM chip driver like that
> will force distro's to support the fbdev system, but the conflicts you
> mention above will disappear because the systems now know the other exists
> and don't do things that the other doesn't know about.

This is accurate, the problems are caused by the various drivers
conflicting. Get rid of multiple drivers and the conflicts go away.

> I'm sure any patches I produce will get NACK'd by you because of some arcane
> kernel politics, but after witnessing this shitstorm and letting myself get
> talked into the work after just tossing out a few ideas I really could care
> less. Something needs to be done, has been needed to be done since the
> fbdev/DRM split appeared and nobody is doing it.

Historically fbdev existed first and DRM came along later so they have
always been split. The OS independent model of X and DRM made sense in
the 90s, but now Linux has advanced to the point where this no longer
makes sense. It's time to update our thinking on how video works.

> I've got a hell of a lot of free time right now, I'm so totally bored wityh my
> private projects it's not funny and this is something to keep me busy for a
> long time. You fdon't like it? Fine - but at least look at it for the code
> and it's merits - because I don't deal with people that will let their
> personal feelings get in the way of their judgement.

There is plenty of work to do on graphics and lots of flame wars too.

-- 
Jon Smirl
jonsmirl@gmail.com
