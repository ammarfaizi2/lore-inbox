Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbWBDT7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWBDT7A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 14:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWBDT7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 14:59:00 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:15266 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964819AbWBDT67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 14:58:59 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: chroot in swsusp userland interface (was: Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Sat, 4 Feb 2006 20:57:44 +0100
User-Agent: KMail/1.9.1
Cc: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
References: <200602030918.07006.nigel@suspend2.net> <200602041451.45232.rjw@sisk.pl> <20060204192123.GB3909@elf.ucw.cz>
In-Reply-To: <20060204192123.GB3909@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602042057.45369.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday 04 February 2006 20:21, Pavel Machek wrote:
> > > No, I do not want to deal with multiple processes. Chrome code is not
> > > *as* evil as you paint it... But yes, chroot is a nice idea. Doing
> > > chroot into nowhere after freezing system will prevent most stupid
> > > mistakes. Rest of userland is frozen, so it can not do anything really
> > > wrong (at most you deadlock), if you kill someone -- well, that's only
> > > as dangerous as any other code running as root.
> > 
> > I like the chroot idea too.
> > 
> > Are we going to chroot from the kernel level (eg. the atomic snapshot
> > ioctl()) or from within the suspending utility?
> > 
> > I think the kernel level would protect some people from bugs in their own
> > suspending utilities, but then we'd have to mount the tmpfs from the kernel
> > level as well.
> 
> What about this (untested)?

So you think we should chroot from the user space.  Fine.

> BTW we do some playing with consoles after freeze. Would it be
> possible to do it *before* freeze? Opening tty might change its
> access time...?

Yes, you are right, but please see below.

> Index: resume.c
> ===================================================================
> RCS file: /cvsroot/suspend/suspend/resume.c,v
> retrieving revision 1.4
> diff -u -u -r1.4 resume.c
> --- resume.c	3 Feb 2006 22:39:24 -0000	1.4
> +++ resume.c	4 Feb 2006 19:19:48 -0000
> @@ -227,6 +227,12 @@
>  		error = errno;
>  		goto Close;
>  	}
> +	/*
> +	 * From now on, system is frozen; any filesystem access may mean data corruption.
> +	 * Prevent accidental filesystem accesses by chrooting somewhere where little
> +	 * damage can be done.
> +	 */
> +	chroot("/sys/power");

We are on an initrd here. :-)

>  	atomic_restore(dev);
>  	unfreeze(dev);
>  Close:
> Index: suspend.c
> ===================================================================
> RCS file: /cvsroot/suspend/suspend/suspend.c,v
> retrieving revision 1.5
> diff -u -u -r1.5 suspend.c
> --- suspend.c	3 Feb 2006 22:39:24 -0000	1.5
> +++ suspend.c	4 Feb 2006 19:19:51 -0000
> @@ -360,6 +360,12 @@
>  		goto Close;
>  	}
>  	go_to_console();
> +	/*
> +	 * From now on, system is frozen; any filesystem access may mean data corruption.
> +	 * Prevent accidental filesystem accesses by chrooting somewhere where little
> +	 * damage can be done.
> +	 */
> +	chroot("/sys/power");

This won't be enough if /sys/power is on a frozen ext2 and the suspending
utility calls open("file", O_CREAT) "by accident".

I think we should do as Olivier said: Mount tmpfs with limited size somewhere
and chroot to it (IMO this won't affect the underlying filesystem).  Then, create
device files for the console and vt on it and open them from there.  This should
be 100% safe.

Greetings,
Rafael
