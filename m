Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265275AbTLaWzq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 17:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265277AbTLaWzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 17:55:46 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33770 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265275AbTLaWzo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 17:55:44 -0500
Date: Wed, 31 Dec 2003 22:55:36 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Rob Love <rml@ximian.com>
Cc: Nathan Conrad <lk@bungled.net>, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20031231225536.GP4176@parcelfarce.linux.theplanet.co.uk>
References: <18Cz7-7Ep-7@gated-at.bofh.it> <E1AbWgJ-0000aT-00@neptune.local> <20031231192306.GG25389@kroah.com> <1072901961.11003.14.camel@fur> <20031231220107.GC11032@bungled.net> <1072909218.11003.24.camel@fur>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072909218.11003.24.camel@fur>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 31, 2003 at 05:20:18PM -0500, Rob Love wrote:
> On Wed, 2003-12-31 at 17:01, Nathan Conrad wrote:
> 
> > One thing that I'm confused about with respect to device files is how
> > kernel arguments are supposed to work. Now, we _seem_ to have a
> > mish-mash of different ways to tell the kernel which device to open as
> > a console, which device to use as a suspend device, etc.... Now, all
> > of the device names are being migrated to userland. How is the kernel
> > supposed to determine which device to use when it is told use
> > /dev/hda3 or /dev/ide/host0/something/part3 as the suspend partition?
> > The kernel no longer knows to which device this string this device is
> > connected.
> 
> Uh, Unix systems (Linux included) do not use the filename of the device
> node at all.  Those are just names for you, the user.
> 
> The kernel uses the device number to understand what device user-space
> is trying to access.  The kernel associates the device with a device
> number.  Normally that number is static, and known a priori, so we just
> create a huge /dev directory with all possible devices and their
> assigned numbers (you can see these numbers with ls -la).
> 
> But if the kernel _tells_ user-space what the device number is, for each
> device as it is created, we do not need a static /dev directory.  We can
> assemble the directory on the fly and device numbers really no longer
> matter.  This is what udev does.

I think you've missed a point here.  There are several places where kernel
deals with device identification.
	a) when normal pathname lookup results in a device node on filesystem.
That's the regular way.
	b) when we create a new device node; device number is passed to
->mknod() and new device node is created.  Also a normal codepath.
	c) when late-boot code mounts the final root.  It used to be black
magic, but these days it's done by regular syscalls.  Namely, we parse the
"device name" (most of the work is done by lookups in sysfs), do mknod(2)
and mount(2).  It's still done from the kernel mode, but it could be moved
to userland.  Should be, actually.
	d) when kernel deals with resume/suspend stuff.  Currently - black
magic.  Should be moved to early userland (same parser as for final root
name + mknod on rootfs + open() to get the device in question).
	e) in several pathological syscalls we pass device number to
identify a device.  ustat(2) and its ilk - bad API that can't die.
	f) /dev/raw passes device number to bind raw device to block device.
Bad API; we probably ought to replace it with saner one at some point.
	g) RAID setup - mix of both pathologies; should be done in userland
and interfaces are in bad need of cleanup.
	h) nfsd uses device number as a substitute for export ID if said
ID is not given explicitly.  That, BTW, is a big problem for crackpipe
dreams about random device numbers - export ID _must_ be stable across
reboots.
	i) mtdblk parses "device name" on boot; should be take to early
userland, same as RAID et.al.

	Eventually name_to_dev_t() should be gone from kernel mode
completely - all callers should be shifted to early userland.  But
that will take a lot of work - currently we have a big mess in that
area.
