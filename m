Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278768AbRJ3XaP>; Tue, 30 Oct 2001 18:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278755AbRJ3XaE>; Tue, 30 Oct 2001 18:30:04 -0500
Received: from mta05ps.bigpond.com ([144.135.25.137]:43762 "EHLO
	mta05ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S278769AbRJ3X3x>; Tue, 30 Oct 2001 18:29:53 -0500
Date: Wed, 31 Oct 2001 10:25:59 +1100
Message-Id: <200110302325.f9UNPxF03897@mobilix.atnf.CSIRO.AU>
From: Richard Gooch <rgooch@atnf.csiro.au>
To: Johannes Kloos <j.kloos@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Deadlock in current devfs with nested symlinks
In-Reply-To: <20011027190117.A13417@gandalf.yadha.dnsalias.net>
In-Reply-To: <20011027190117.A13417@gandalf.yadha.dnsalias.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Apologies for not responding to your earlier email, but I've been
travelling, moving house and caught the 'flu]
Johannes Kloos writes:
> I have found a deadlock in the current version of devfs.
> It can be reproduced like this on a system with an IDE CD-ROM drive:
> 0. Make sure devfs is mounted on /dev and devfsd is running with
>    MKOLDCOMPAT and MKNEWCOMPAT enabled.
> 1. Create a symlink from /dev/cdroms/cdrom0 to /dev/cdrom
> 2. rmmod ide-cd
> 3a. mount /dev/cdrom /mnt
> or
> 3b. file -L /dev/cdrom
> 
> I've traced this bug to the symlink semaphore in devfs.
> As far as I can tell, the following events lead to a deadlock:
> 1. file -L tries to stat(2) /dev/cdrom. stat will follow the symlinks
>    and acquires symlink_rwsem for reading.
> 2. /dev/cdroms/cdrom0 doesn't exist, so the kernel tells devfsd
>    to look up /dev/cdroms/cdrom0.
> 3. devfsd loads ide-cd.o. Then, it will try to create the appropriate
>    symlinks in /dev.
> 4. devfs_do_symlink tries to acquire symlink_rwsem for writing - deadlock.

Sigh. There's just no clean way of fixing this with the current
code. I'll probably just do what I've been avoiding, which is to
allocate temporary buffer space in the readlink() and follow_link()
methods, and free it prior to return. However, I'll be travelling for
the next couple of days, and will be out of 'net contact. But feel
free to code up a patch along these lines :-)

After this, I really want to avoid band-aid fixes and instead
concentrate on getting the new code to a usable state, since so many
of these problems are not there in the new code.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
