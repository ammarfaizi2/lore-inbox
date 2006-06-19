Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWFSIX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWFSIX7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 04:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWFSIX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 04:23:59 -0400
Received: from iona.labri.fr ([147.210.8.143]:37805 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S932315AbWFSIX5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 04:23:57 -0400
Date: Mon, 19 Jun 2006 10:23:55 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com,
       linux-hotplug-devel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.17
Message-ID: <20060619082355.GE4253@implementation.labri.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
	greg@kroah.com, linux-hotplug-devel@vger.kernel.org
References: <20060618221343.GA20277@kroah.com> <20060618230041.GG4744@bouh.residence.ens-lyon.fr> <20060618231204.GB2212@suse.de> <20060618233508.GH4744@bouh.residence.ens-lyon.fr> <20060619032259.GB4651@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060619032259.GB4651@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Greg KH, le Sun 18 Jun 2006 20:22:59 -0700, a écrit :
> > No hardware correspond to the uinput driver.
> 
> I'm not familiar with the uinput driver, but you might want to look at
> how all of the other input drivers are autoloaded by udev based on
> module aliases and see if that will work for you too.

They're autoloaded because they correspond to real hardware. uinput
doesn't.

> Or just tell your users to make sure that they have the uinput driver
> loaded,

They can't, since without it they can't even type things.

> > > and if not, simply add it to the list of modules that need to be
> > > loaded every boot (each distro has a different place to put this
> > > list), and you should be fine.
> > 
> > I can't ask the users of my program to do that either (actually, they
> > can't even do this, since they need uinput for just being able to type
> > things on the console...)
> 
> I'm not aware of what your program is,

It's a daemon for letting blind user use their braille device
as output device and keyboard. And for beginners this is
yet-another-difficult-thing-to-remember-to-do-after-installation.

> but why not do it for them in your program startup logic (yes, it
> requires root access, but that's a requirement).

That's what we actually do. The root requirement is not a problem since
the program needs to be able to read the console anyway.

But the root requirement _is_ a problem for other cases. When I want
to use a soft synthesizer (qsynth) for midi applications for instance
(because my soundboard has no synth), I have to modprobe snd-seq-dummy
as root, which is tedious (yes I could have it always auto-loaded),
while I could very well have configured an alias between /dev/snd/seq
and snd-seq-dummy, so that just running qsynth as user would just work.

> > > Please realize that the method of loading a module based on the device
> > > node number is very restrictive, and only works for a small minority of
> > > drivers.
> > 
> > Agreed. But here, what is best? To explicitely load a "uinput" module or
> > to explicitely open "/dev/input/uinput" ?
> 
> Well as trying to open /dev/input/uinput will not cause anything to load
> anymore (due to devfs not doing this, and udev systems not allowing this
> to happen), I suggest loading the uinput module.

That's what we ended up to do. In this case, this is fine (since
only one module provides the uinput facility), but in the "seq" case
explained above, this can't work (the qsynth application can't know
whether it should load alsa's dummy device or oss's or...)

> > > > The same situation holds for other virtual devices (loop, snd-seq-dummy,
> > > > ...).
> > > 
> > > Yes, look at how the distros do this today for loop, they merely load it
> > > at boot time and everyone's happy.
> > 
> > So distributions should load every possible virtual device?
> 
> Within reason, it seems like they do at times.

I can see at least dummy_hcd, loop, snd-seq-dummy, snd-dummy, dummy (net
driver), dummycon, and uinput. This might put quite a lot of confusion
in user's mind ("Oh? I have a USB host?!").

> > In the debian case, it doesn't, but udev has a links.conf script that
> > creates a /dev/loop/0 entry, which losetup can open when looking for
> > loop block devices, and hence the loop module gets auto-loaded. This is
> > the behavior I'd expect.
> 
> Perhaps you can just create a uinput script that does this.

That's fine for me, but as I said this is considered hacky (the header
of links.conf is "This file does not exist. Please do not ask the debian
maintainer about it. You may use it to do strange and wonderful things,
at your risk.")

Samuel
