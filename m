Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261778AbRESLlA>; Sat, 19 May 2001 07:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261775AbRESLku>; Sat, 19 May 2001 07:40:50 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:63534 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S261767AbRESLkj>; Sat, 19 May 2001 07:40:39 -0400
To: Ben LaHaise <bcrl@redhat.com>
Cc: <torvalds@transmeta.com>, <viro@math.psu.edu>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code in userspace
In-Reply-To: <Pine.LNX.4.33.0105190138150.6079-100000@toomuch.toronto.redhat.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 May 2001 05:37:42 -0600
In-Reply-To: Ben LaHaise's message of "Sat, 19 May 2001 02:23:59 -0400 (EDT)"
Message-ID: <m14ruhin7d.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben LaHaise <bcrl@redhat.com> writes:

> Hey folks,
> 
> The work-in-progress patch for-demonstration-purposes-only below consists
> of 3 major components, and is meant to start discussion about the future
> direction of device naming and its interaction block layer.  The main
> motivations here are the wasting of minor numbers for partitions, and the
> duplication of code between user and kernel space in areas such as
> partition detection, uuid location, lvm setup, mount by label, journal
> replay, and so on...

> 
> 1. Generic lookup method and argument parsiing (fs/lookupargs.c)
> 
> 	This code implements a lookup function which is for demonstration
> 	purposes used in fs/block_dev.c.  The general idea is to pass
> 	additional parameters to device drivers on open via a comma
> 	seperated list of options following the device's name.  Sample
> 	uses:
> 
> 		/dev/sda/raw		-> open sda in raw mode.
> 		/dev/sda/limit=102400	-> open sda with a limit of 100K
> 		/dev/sda/offset=1024,limit=2048
> 			-> open a device that gives a view of sda at an
> 			   offset of 1KB to 2KB

GAhh!!!!!!

Ben please think /proc/sys.  One value per ``file''.

> 3. Userspace partition code proposal
> 
> 	Given the above two bits, here's a brief explaination of a
> 	proposal to move management of the partitioning scheme into
> 	userspace, along with portions of raid startup, lvm, uuid and
> 	mount by label code needed for mounting the root filesystem.
> 
> 	Consider that the device node currently known as /dev/hda5 can
> 	also be viewed as /dev/hda at offset 512000 with a limit of 10GB.
> 	With the extensions in fs/block_dev.c, you could replace /dev/hda5
> 	with /dev/hda/offset=512000,limit=10240000000.  Now, by putting
> 	the partition parsing code into a libpart and binding mount to a
> 	libpart, the root filesystem mounting code can be run out of an
> 	initrd image.  The use of mount gives us the ability to mount
> 	filesystems by UUID, by label or other exotic schemes without
> 	having to add any additional code to the kernel.

But you need to use uclibc or a similar library to get the code size down
small enough, so you don't quadruple the size of your boot image.

As for wasting minors.  If you are going to rework partitions they
should have dynamic device numbers.  That are assigned when the
partition is discovered by the system.   I admit a hot-plug partition
sounds incongruous but it should be fairly simple to implement.

If your real root is on a ``hot-plug'' device then it does look
like you need an initrd to help select your root partition.  Hmm. the
code is simple enough code in the kernel shouldn't be bad.  And the
interface can be simple as well.

Have:
/dev/sda/partitions/1
/dev/sda/partitions/2
/dev/sda/partitions/3
/dev/sda/partitions/4
/dev/sda/partitions/5
and also
/dev/sda/partitions/1/uuid
/dev/sda/partitions/1/label
/dev/sda/partitions/1/offset
/dev/sda/partitions/1/limit

To expose what the kernel found it's initial scan of the partitions.

For creating partitions you might want to do:
cat 1024 2048 > /dev/sda/newpartition
Though if you could do it with create that would be nicer, and writes
to offset and limit, that would be a little nicer.

Al would it work to have the lookup method for /dev/sda automatically
mount an instance of scsifs on /dev/hda (from an internal mount), and
then have dput drop that mount.  I skimmed the code and it looks
possible.  

Soft mounting a fs isn't strictly necessary but for the case above but
it looks simplest to keep the list of partitions permanently in the
dcache.  We would also need to modify permission to take a vfsmnt
argument so your permissions to a device file could vary depending on
which device file you start with.

Eric



