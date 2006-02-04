Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932568AbWBDUqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568AbWBDUqm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 15:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbWBDUqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 15:46:42 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:28066 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932568AbWBDUqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 15:46:42 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: chroot in swsusp userland interface (was: Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Sat, 4 Feb 2006 21:45:42 +0100
User-Agent: KMail/1.9.1
Cc: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
References: <200602030918.07006.nigel@suspend2.net> <200602042057.45369.rjw@sisk.pl> <20060204201503.GE3909@elf.ucw.cz>
In-Reply-To: <20060204201503.GE3909@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602042145.43308.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday 04 February 2006 21:15, Pavel Machek wrote:
}-- snip --{
> > > Index: suspend.c
> > > ===================================================================
> > > RCS file: /cvsroot/suspend/suspend/suspend.c,v
> > > retrieving revision 1.5
> > > diff -u -u -r1.5 suspend.c
> > > --- suspend.c	3 Feb 2006 22:39:24 -0000	1.5
> > > +++ suspend.c	4 Feb 2006 19:19:51 -0000
> > > @@ -360,6 +360,12 @@
> > >  		goto Close;
> > >  	}
> > >  	go_to_console();
> > > +	/*
> > > +	 * From now on, system is frozen; any filesystem access may mean data corruption.
> > > +	 * Prevent accidental filesystem accesses by chrooting somewhere where little
> > > +	 * damage can be done.
> > > +	 */
> > > +	chroot("/sys/power");
> > 
> > This won't be enough if /sys/power is on a frozen ext2 and the suspending
> > utility calls open("file", O_CREAT) "by accident".
> 
> ...well, we rely on sysfs files to work... at least for
> suspend-to-RAM, ok, no argument here. I doubt anyone really does mount
> anything but sysfs on /sys...
> 
> > I think we should do as Olivier said: Mount tmpfs with limited size somewhere
> > and chroot to it (IMO this won't affect the underlying filesystem).  Then, create
> > device files for the console and vt on it and open them from there.  This should
> > be 100% safe.
> 
> Looks unneccessarily complex to me. We'd have to umount that tmpfs,
> and playing with mounts inside system suspend seems wrong to me.
> 
> Perhaps we can chroot into /proc...  almost everyone has /proc
> mounted, right? 
> 
> Is it possible to move console/vt open before freeze?

No, because freeze sets the active vt for us.  How about that: mount the
tmpfs before freeze, put there what we'll need, open device files from
there instead of /dev, and chroot() after atomic_snapshot?  Then, after
resume we won't be chrooted and we'll be able to unmount the tmpfs
safely.

Greetings,
Rafael
