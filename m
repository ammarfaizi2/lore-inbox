Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbWFSDZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWFSDZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 23:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWFSDZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 23:25:56 -0400
Received: from cantor.suse.de ([195.135.220.2]:49125 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751194AbWFSDZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 23:25:55 -0400
Date: Sun, 18 Jun 2006 20:22:59 -0700
From: Greg KH <gregkh@suse.de>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [GIT PATCH] Remove devfs from 2.6.17
Message-ID: <20060619032259.GB4651@suse.de>
References: <20060618221343.GA20277@kroah.com> <20060618230041.GG4744@bouh.residence.ens-lyon.fr> <20060618231204.GB2212@suse.de> <20060618233508.GH4744@bouh.residence.ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060618233508.GH4744@bouh.residence.ens-lyon.fr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 01:35:08AM +0200, Samuel Thibault wrote:
> Hi,
> 
> Greg KH, le Sun 18 Jun 2006 16:12:04 -0700, a ?crit :
> > On Mon, Jun 19, 2006 at 01:00:41AM +0200, Samuel Thibault wrote:
> > > - With udev, this just cannot work. As explained in an earlier thread,
> > >   even using a special filesystem that would report the opening attempt
> > >   to udevd wouldn't work fine since udevd takes time for creating the
> > >   device, and hence the original program needs to be notified ; this
> > >   becomes racy.
> > > 
> > > So what is the correct way to do it? I can see two approaches:
> > 
> > You forgot:
> >   - use a static /dev if you want this.
> > No one is forcing you to use udev :)
> 
> I can't choose the preference of the users of my program.
> 
> > > Neither solution looks good to me... Just opening /dev/input/uinput
> > > should be sufficient, and udev doesn't let that for now.
> > 
> > No, just do what the distros that use udev do today, load the needed
> > modules at boot time, based on the hardware that is present in the
> > system.  This should work just fine for the uinput driver,
> 
> No hardware correspond to the uinput driver.

I'm not familiar with the uinput driver, but you might want to look at
how all of the other input drivers are autoloaded by udev based on
module aliases and see if that will work for you too.

Or just tell your users to make sure that they have the uinput driver
loaded, and look into the distro's documentation for how to have it
automatically loaded at boot time (they all provide this functionality
for modules that don't have a hardware backing device.)

> > and if not, simply add it to the list of modules that need to be
> > loaded every boot (each distro has a different place to put this
> > list), and you should be fine.
> 
> I can't ask the users of my program to do that either (actually, they
> can't even do this, since they need uinput for just being able to type
> things on the console...)

I'm not aware of what your program is, but why not do it for them in
your program startup logic (yes, it requires root access, but that's a
requirement).

> > Please realize that the method of loading a module based on the device
> > node number is very restrictive, and only works for a small minority of
> > drivers.
> 
> Agreed. But here, what is best? To explicitely load a "uinput" module or
> to explicitely open "/dev/input/uinput" ?

Well as trying to open /dev/input/uinput will not cause anything to load
anymore (due to devfs not doing this, and udev systems not allowing this
to happen), I suggest loading the uinput module.

> > > The same situation holds for other virtual devices (loop, snd-seq-dummy,
> > > ...).
> > 
> > Yes, look at how the distros do this today for loop, they merely load it
> > at boot time and everyone's happy.
> 
> So distributions should load every possible virtual device?

Within reason, it seems like they do at times.

> In the debian case, it doesn't, but udev has a links.conf script that
> creates a /dev/loop/0 entry, which losetup can open when looking for
> loop block devices, and hence the loop module gets auto-loaded. This is
> the behavior I'd expect.

Perhaps you can just create a uinput script that does this.

Or just add that device node to the /lib/udev/devices/ directory, and it
will be restored at every boot, then when your user opens it, the proper
module will be automatically loaded.  That is what that directory is
there for (as well as for device nodes that don't play nice with udev or
can't for whatever reason.)

> > And this whole thing has nothing to do with devfs, as you stated above
> > :)
> 
> Ok, but devfs had let me some hope that it would work, and udev doesn't
> so much (the abovementioned links.conf file is considered hacky).

As devfs has not been maintained in over 4 years, I don't see how not
removing it will help this situation out at all for you, sorry.

I suggest taking this topic to the linux-hotplug-devel mailing list if
you still have issues loading the uinput module at boot time for your
systems that run udev.

thanks,

greg k-h
