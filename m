Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262046AbTCHPkw>; Sat, 8 Mar 2003 10:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262047AbTCHPkw>; Sat, 8 Mar 2003 10:40:52 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:2102 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S262046AbTCHPkt>; Sat, 8 Mar 2003 10:40:49 -0500
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Roman Zippel <zippel@linux-m68k.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
References: <Pine.LNX.4.44.0303072121180.5042-100000@serv>
	<Pine.LNX.4.44.0303071459260.1309-100000@home.transmeta.com>
	<20030307233916.Q17492@flint.arm.linux.org.uk>
	<m1d6l2lih9.fsf@frodo.biederman.org>
	<20030308100359.A27153@flint.arm.linux.org.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 08 Mar 2003 08:50:48 -0700
In-Reply-To: <20030308100359.A27153@flint.arm.linux.org.uk>
Message-ID: <m18yvpluw7.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk> writes:

> On Fri, Mar 07, 2003 at 07:06:42PM -0700, Eric W. Biederman wrote:
> > I agree ipconfig.c works well for development.  Last time I played with
> > something like this it should not be hard to get the entire initrd
> > binary down to 30K-40K.   I think you can probably do it in 16K but...
> > 
> > As far as equivalent functionality there is already a dhcp client and
> > a mount client in busybox.  So in the worst case someone it will
> > take just a bit of glue to put these things together.
> 
> You didn't read my previous emails on this very subject.  When you try to
> separate the dhcp client and mount client, you need some way to pass the
> information about which NFS server and path to mount to mount from dhcp.
> I have yet to find any DHCP client which allows this without the use of
> a shell and some parsing, which pushes the initrd through the roof.

I agree they both the dhcp client and the nfs mount need to be in the
same binary.  With busybox they already are so it should just take
some glue code to have the magic work.

The last time I worked on something like this I put a dhcp client, and
a tftp client in a single binary, my compressed initrd was only 16K on
x86.  And I had a complete network boot loader using the linux kernel.

Now the kernel is so big and bloated it has not been practical to use
it.  So my effort has mostly been concentrated on etherboot.  Which
is essentially a mini-kernel that just focuses on being a network boot
loader.  And with etherboot I can get a udp/ip stack. With dhcp and
tftp support, and an eepro100 nic driver into 38K on an Itanium (The
platform with possible the most bloated binaries known to man).  On x86
with an eepro100 driver I can usually get it down to around 16K.  (All
sizes represent self decompressing executables).

And in etherboot there is support for mounting a nfs filesystem, and
reading a kernel off of that.  Which makes it extremely relevant for
the question of how small can you get when replacing ipconfig.c

In truth putting the dhcp and mount clients in separate binaries
never occurred to me as a practical strategy.

> > > klibc provided a way, but if that isn't going to be merged and this stuff
> > > made to work for 2.6, then I think we must keep ipconfig.c and
> > > nfsroot.c.
> > 
> > Either klibc or alternative user space implementation.  There is no
> > reason that magic has to happen in the kernel.  The only thing has
> > to be implemented is a way to smush a kernel and an initrd together.
> 
> klibc is a user space C library, which incidentally supports ARM Thumb
> binaries natively.  Here's some of the klibc ARM (non-thumb) executable
> sizes:
> 
> -rwxrwxr-x    1 root     root         784 Oct 21 16:22 bin/chroot
> -rwxrwxr-x    1 root     root        4288 Oct 21 16:22 bin/dd
> -rwxrwxr-x    1 root     root        1892 Oct 21 16:22 bin/fstype
> -rwxrwxr-x    1 root     root       21348 Oct 21 16:22 bin/gzip
> -rwxr-xr-x    1 root     root        1340 Oct 21 16:22 bin/init
> -rwxrwxr-x    1 root     root       55396 Oct 21 16:22 bin/ip
> -rwxrwxr-x    1 root     root        9260 Oct 21 16:22 bin/ipconfig
> -rwxrwxr-x    1 root     root        2340 Oct 21 16:22 bin/mkdir
> -rwxrwxr-x    1 root     root        1956 Oct 21 16:22 bin/mkfifo
> -rwxrwxr-x    1 root     root        1988 Oct 21 16:22 bin/mount
> -rwxrwxr-x    1 root     root         732 Oct 21 16:22 bin/pivot_root
> -rwxrwxr-x    1 root     root       61412 Oct 21 16:22 bin/sh
> -rwxrwxr-x    1 root     root         900 Oct 21 16:22 bin/umount
> -rwxrwxr-x 1 root root 54996 Oct 21 16:22 lib/klibc-0kmXIFHd5q4HQkCE6r3itw.so
> 
> 
> Note: all these utilities have been written to be as small as possible,
> and not all of these are absolutely required for a single-configuration
> system.  There is very little code shared between these utilities.
> 
> Even gzip has had lots of crap removed from it to shrink it down to size.
> `ip' is a hugely bloated way to configure IP networking - that binary
> only supports link, addr, and route functions.
> 
> I challenge anyone to find binaries that are smaller than these, but
> contain the same functionality (ie, no surprises that something doesn't
> work the way it should do.)  Note: busybox is not functionally the same.
> Been there already.

I'm lost.  Why is there a complete userspace here?  I guess this
explains why klibc is not useful yet.  This is definitely not a route
for what is required to just replace the kernel pieces like ipconfig.c

I knew something was fishy when we got beyond having a single
executable.  This is where I mumble that it was once possible to
run unix in 64K. (32K kernel 32K user space)  So why can't we get
small binaries anymore?

> Things the current klibc setup is able to do:
> 
> - bringing up networking.
> - detecting a local filesystem type.
> - mounting a _local_ filesystem.
> - gunzipping a ramdisk image from a device and loading it into a ramdisk.
> 
> Things klibc stuff can't do at present:
> 
> - be configurable from the kernel command line.  If something goes wrong
>   with the boot, you need to rebuild the early userspace image to do
>   something different.
> - mount NFS-root filesystems.
> - be as small as the current kernel solution.  Current early userspace
>   weighs in at 220K (uncompressed) on ARM, or a 97K gzipped ext2fs image.
 
That is definitely still a heavy weight.  Not to bad for a general
purpose setup but not really good either.

> A solution for the first requires all the existing infrastructure in
> the kernel (which traps things like "ro", "root=" and so forth) to
> be removed.

Or a different set of option names be used in the interim.

> A solution for the final point is possible - you combine everything
> together into one large image, get rid of the shell, and produce one
> honking monolitic kitchen sink that couldn't care whether you have
> NFS support in the kernel or not.

Exactly.  And you build it for the specific purpose of just
configuring the system.  And by not handling the general case you
should be able to get another significant size reduction.

> Please note - I have a working setup here which:
> 
> - decompresses the initramfs ext2 image from a MTD flash partition
> - sets up networking using dhcp
> - decompresses the real root ramdisk into another ramdisk
> - detects the type of the filesystem
> - mounts the filesystem
> - pivot-root's to the root filesystem
> - starts init
> 
> This works for me.  Others milage will vary drastically because klibc
> needs more work.
> 
> Oh, I may seem to be enthusiastic about klibc.  I haven't worked on it
> since October last year, mainly because it didn't seem to be going anywhere
> fast (like, into the kernel.)  I'm not intending spending anymore time
> on it until there's some improvement in this area, which would allow more
> stuff to happen in klibc.

Reasonable I guess.

Eric
