Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274004AbRISGAn>; Wed, 19 Sep 2001 02:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274005AbRISGAd>; Wed, 19 Sep 2001 02:00:33 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:52218 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S274004AbRISGAX>; Wed, 19 Sep 2001 02:00:23 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Wed, 19 Sep 2001 00:00:40 -0600
To: Mark Swanson <swansma@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Request: removal of fs/fs.h/super_block.u to enable partition locking
Message-ID: <20010919000040.G14526@turbolinux.com>
Mail-Followup-To: Mark Swanson <swansma@yahoo.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3BA7FF92.D6477904@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BA7FF92.D6477904@yahoo.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 18, 2001  22:14 -0400, Mark Swanson wrote:
> Why?
> 
> So I can write and distribute a GPL'd 'inuse' filesystem module
> that essentially registers a partition as in-use.

I have often thought of the same thing.  In fact, for ext3 journals
which live on their own partition, I ended up creating a filesystem
for them for this reason, among others.  The other benefits of a
filesystem for the journal device is that it could be used to get/set
parameters for the journal daemon via read/write (e.g. (un)registering
or showing journal clients (ext3 filesystems), setting the flush
interval or other tuning parameters, etc).

> I am writing an application that uses raw I/O and I need
> some way of locking a partition. The only
> way I know of (sortof) doing this is by registering a filesystem
> for the partition so system utilities won't overwrite the partition
> because they will see it is busy by examining /proc/partitions.

Do you mean /proc/mounts here instead of /proc/partitions?  The latter
doesn't tell you anything about whether it is in use or not, only if
it has a recognised partition type.  Also, /proc/mounts is only useful
if the device is actually mounted.

> lockf()
> on /dev/hda1 doesn't stop root from mounting the partition
> as a swap partition or accidentally formatting it
> even though the root partition was mounted with 'mand' to 
> enable mandatory locking and a 'chmod 2660 /dev/hda1' was done 
> to enable mandatory locking on the file.

I don't know what the intended semantics of lockf() on a block device
are.  I suppose you could make the kernel/mount check for such locks
when trying to mount a filesystem, but that doesn't prevent mkfs from
killing it unless open() of the device is also blocked by this lock.

I guess if a patch to do this is clean enough it may make it into the
kernel, but AFAIK the POSIX locking code is rather convoluted.  It
would also be the case that the locks are only valid while the program
that locked them is running, so if it dies or is never started, the
devices could be overwritten at that time as well, but at least you
are safe most of the time.

> I'm trying to look out for tired sys-admins who might 
> destroy my application's partition not knowing
> what a particular empty-looking partition is used for.

A real danger, of course.  However, in the end you can't protect users
from destroying things if they want to.  If it is too fool-proof, it
will likely also cause people who DO know what they are doing grief
(e.g. they want to stop using a disk for your app, or there is a real
problem and they need to fix it but can't, like restoring a backup).

One (kind of convoluted) option is to use IBM's EVMS code (which is a
virtual volume manager like LVM) and create a module which recognises
partitions from your application, and then does not export them out to
the users.  They would need to use the EVMS user interface (or you could
integrate your application to the EVMS user tools) in order to unregister
a partition/disk from your app.  This assumes the users have EVMS (which
is slim to none so far).

IBM is also worried about such things as users shooting themselves
in the foot.  However, it would likely still be possible for users to
access the "raw" device inode (e.g. /dev/hda) and overwrite the data.
At one point we discussed EVMS hooking into the block device struct
and preventing it from being written to directly if it was registered
to a higher layer in EVMS, but I doubt that is currently implemented.
This was intended to prevent, for example, writing directly to
/dev/hda1 when that is actually part of an LV or RAID device.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

