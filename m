Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932559AbWBDUPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbWBDUPU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 15:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbWBDUPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 15:15:20 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53949 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1946080AbWBDUPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 15:15:19 -0500
Date: Sat, 4 Feb 2006 21:15:03 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: chroot in swsusp userland interface (was: Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060204201503.GE3909@elf.ucw.cz>
References: <200602030918.07006.nigel@suspend2.net> <200602041451.45232.rjw@sisk.pl> <20060204192123.GB3909@elf.ucw.cz> <200602042057.45369.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602042057.45369.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Are we going to chroot from the kernel level (eg. the atomic snapshot
> > > ioctl()) or from within the suspending utility?
> > > 
> > > I think the kernel level would protect some people from bugs in their own
> > > suspending utilities, but then we'd have to mount the tmpfs from the kernel
> > > level as well.
> > 
> > What about this (untested)?
> 
> So you think we should chroot from the user space.  Fine.

Yes, sorry that I was not explicit.

> >  	}
> > +	/*
> > +	 * From now on, system is frozen; any filesystem access may mean data corruption.
> > +	 * Prevent accidental filesystem accesses by chrooting somewhere where little
> > +	 * damage can be done.
> > +	 */
> > +	chroot("/sys/power");
> 
> We are on an initrd here. :-)

Oops, right, forget that.

> > Index: suspend.c
> > ===================================================================
> > RCS file: /cvsroot/suspend/suspend/suspend.c,v
> > retrieving revision 1.5
> > diff -u -u -r1.5 suspend.c
> > --- suspend.c	3 Feb 2006 22:39:24 -0000	1.5
> > +++ suspend.c	4 Feb 2006 19:19:51 -0000
> > @@ -360,6 +360,12 @@
> >  		goto Close;
> >  	}
> >  	go_to_console();
> > +	/*
> > +	 * From now on, system is frozen; any filesystem access may mean data corruption.
> > +	 * Prevent accidental filesystem accesses by chrooting somewhere where little
> > +	 * damage can be done.
> > +	 */
> > +	chroot("/sys/power");
> 
> This won't be enough if /sys/power is on a frozen ext2 and the suspending
> utility calls open("file", O_CREAT) "by accident".

...well, we rely on sysfs files to work... at least for
suspend-to-RAM, ok, no argument here. I doubt anyone really does mount
anything but sysfs on /sys...

> I think we should do as Olivier said: Mount tmpfs with limited size somewhere
> and chroot to it (IMO this won't affect the underlying filesystem).  Then, create
> device files for the console and vt on it and open them from there.  This should
> be 100% safe.

Looks unneccessarily complex to me. We'd have to umount that tmpfs,
and playing with mounts inside system suspend seems wrong to me.

Perhaps we can chroot into /proc...  almost everyone has /proc
mounted, right? 

Is it possible to move console/vt open before freeze? That should be
enough.
								Pavel
-- 
Thanks, Sharp!
