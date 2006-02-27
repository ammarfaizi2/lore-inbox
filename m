Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbWB0ToA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbWB0ToA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 14:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbWB0ToA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 14:44:00 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:4492 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1751441AbWB0Tn7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 14:43:59 -0500
Date: Mon, 27 Feb 2006 11:44:00 -0800
From: Greg KH <gregkh@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Greg KH <greg@kroah.com>, Kay Sievers <kay.sievers@vrfy.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Message-ID: <20060227194400.GB9991@suse.de>
References: <20060227190150.GA9121@kroah.com> <p7364n01tv3.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p7364n01tv3.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 08:31:28PM +0100, Andi Kleen wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > Hi all,
> > 
> > As has been noticed recently by a lot of different people, it seems like
> > we are breaking the userspace<->kernelspace interface a lot.  Well, in
> > looking back over time, we always have been doing this, but no one seems
> > to notice (proc files changing format and location, netlink library
> > bindings, etc.)
> 
> Ok, but how do you plan to address the basic practical problem?
> People cannot freely upgrade/downgrade kernels anymore since udev/hal
> are used widely in distributions.

I can freely upgrade/downgrade kernels on some distros[1] if I wish to,
as they support such things.  Just complain to your distro maker if you
have this issue :)

I'm worrying about documenting this stuff, and allowing a way for kernel
people to work with the userspace people that use these interfaces to
hopefully not break things in ways that are unexpected, and/or break
things at all.

> Does it imply you plan to change udev/hal to only use stable interfaces
> for now? I would applaud such a move, but I guess it would come
> at the cost of functionality.

It all depends on the type of interface, sysfs is still shaking itself
out as more and more people use it.  udev today can work with the
changes we have in store for sysfs in the future (see Kay's old patches
on lkml for the kernel for examples of where we are going), so udev
looks to work just fine.  But we want to know what other programs uses
these interfaces so they too can be prepared in case things happen.

And remember, HAL is there to handle all of the crap and flux in the
kernel api and hide it from all other userspace programs.  It is _much_
easier to work with one program to ensure that we don't break things and
test stuff out to see how they will work better, than have to run around
all of Gnome and KDE to touch up all of the different programs.  But
that's a topic that has nothing to do with this thread, sorry.

> If these applications are not changed then the documentation is likely
> useless because it won't help anyways - things will still break,
> kernel hackers and users will curse you all the time when they want to
> test kernels etc.

That's what the "Users:" lines are for, so that we can all work together
as one big happy team :)

> > --- /dev/null
> > +++ gregkh-2.6/Documentation/ABI/stable/syscalls
> > @@ -0,0 +1,10 @@
> > +What:		The kernel syscall interface
> > +Description:
> > +	This interface matches much of the POSIX interface and is based
> > +	on it and other Unix based interfaces.  It will only be added to
> > +	over time, and not have things removed from it.
> 
> Some ioctls and socket options unfortunately don't follow this. I
> guess you will need to document them separately.

Agreed.

> Could be ugly to have hundreds of files for ioctls though.
> Perhaps define core ioctls and then driver ioctls and define
> all the driver ioctls unstable by default? But that also
> would just mean the category stable would be useless
> because people always would need to use unstable interfaces
> too.

No, not many programs use ioctls.  And a lot of them are stable and have
not changed in years (tty, block, etc.) and should be explicitly
documented here.

These examples were just examples of things that go into the different
directories.  There is a lot more work ahead to document everything that
is currently implemented.

> > --- /dev/null
> > +++ gregkh-2.6/Documentation/ABI/testing/sysfs-class
> > @@ -0,0 +1,16 @@
> > +What:		/sys/class/
> > +Date:		Febuary 2006
> > +Contact:	Greg Kroah-Hartman <gregkh@suse.de>
> > +Description:
> > +		The /sys/class directory will consist of a group of
> > +		subdirectories describing individual classes of devices
> > +		in the kernel.  The individual directories will consist
> > +		of either subdirectories, or symlinks to other
> > +		directories.
> > +
> > +		All programs that use this directory tree must be able
> > +		to handle both subdirectories or symlinks in order to
> > +		work properly.
> 
> What good is it if you don't say anything about the stability of its contents?
> Looks far too vague to me.

The "contents" are merely symlinks back to the device (well, some are
symlinks, others are directories, in the end all will be symlinks.)

And yes, the individual classes need to also be documented to be
through, again, this was a first cut to provide examples, not to be
complete.  Patches are welcome to help flush it all out.

thanks,

greg k-h


[1] Gentoo for example works almost just fine[2] with udev with kernels
ranging from 2.6.9 to 2.6.16-rc4, I haven't tried older kernels than
that in a long time.

[2] cdrom symlinks don't get created on older kernels due to IDE
changes, but a simple rule change handles that, and could be added to
the main install if it becomes annoying.

