Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268934AbRHLDK6>; Sat, 11 Aug 2001 23:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268936AbRHLDKs>; Sat, 11 Aug 2001 23:10:48 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:50190 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S268934AbRHLDKl>; Sat, 11 Aug 2001 23:10:41 -0400
Message-ID: <3B75F3A8.24C56BDA@zip.com.au>
Date: Sat, 11 Aug 2001 20:10:32 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8-ac1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@uni-koblenz.de>
CC: "ext3-users@redhat.com" <ext3-users@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: ext3-2.4-0.9.6
In-Reply-To: <3B75DE86.EEDFAFFB@zip.com.au>,
		<3B75DE86.EEDFAFFB@zip.com.au>; from akpm@zip.com.au on Sat, Aug 11, 2001 at 06:40:22PM -0700 <20010812043841.B8413@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Baechle wrote:
> 
> On Sat, Aug 11, 2001 at 06:40:22PM -0700, Andrew Morton wrote:
> 
> > - ext3 has for a long time had developer code which allows the target device
> >   to be turned read-only at the disk device driver level a certain number
> >   of jiffies after the fs was mounted.  This is to allow scripted testing
> >   of crash recovery.  This facility has been extended to support two devices;
> >   one for the filesystem and one for the external journal device.
> 
> Would this facility also be able to deal with parts of a device becoming
> read-only unexpectedly?  Some of the disks I have in RAIDs have the
> nice habit of disabling write access when overheating.  That's an
> interesting failure scenario in a RAID system.

Well, that facility is purely for development purposes.  The obvious
way of testing recovery is to hit the reset button at strategic
times, which rather sucks.  So what the above IDE driver trick does
is adds a new mount option `ro-after=3000'.  When this is provided,
a kernel timer fires 30 seconds after mount and the IDE driver starts
silently ignoring writes to the underlying device.  It also provides
a special ioctl() which blocks the caller until the timer has fired.

So we have scripts which do:

1: mount fs, set to go read-only in 30 seconds
2: start some filesystem activity
3: Block on the timer
4: wake up, kill off the filesystem activity
5: unmount the fs
6: mount the fs (this will run recovery)
7: unmount the fs
8: fsck it
9: repeat with a different read-only interval.

I also have a hacked-on version of dbench which writes
known-but-variable info into the files, so we can check that
the contents of whatever files survived the "crash" are correct.

This setup has allowed me to run crash+recovery many thousands
of times with varying workloads - I'm pretty confident about recovery
because of this.  The one thing it doesn't cover is the effects
of disk write caching.

As for the RAID problem: if the filesystem has magically turned
read-only then all you need to do is to unmount it (often hard
to do, if it's in use), then make it writable and then mount it or
run fsck against it.  ext3 will perform recovery and all should
be peachy, until next time...

-
