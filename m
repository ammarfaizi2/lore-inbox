Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137012AbRAHS15>; Mon, 8 Jan 2001 13:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137141AbRAHS1s>; Mon, 8 Jan 2001 13:27:48 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:18189 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S137012AbRAHS1e>; Mon, 8 Jan 2001 13:27:34 -0500
Date: Mon, 8 Jan 2001 10:27:11 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David L. Parsley" <parsley@linuxjedi.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Adam J. Richter" <adam@yggdrasil.com>, parsley@roanoke.edu,
        linux-kernel@vger.kernel.org
Subject: Re: Patch (repost): cramfs memory corruption fix
In-Reply-To: <3A58D418.32111AD@linuxjedi.org>
Message-ID: <Pine.LNX.4.10.10101081012150.3750-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Jan 2001, David L. Parsley wrote:
> 
> 2.4.0 ramfs with the one-liner does it's job for me already; what I'd
> really love to fool with is _cramfs_. ;-)  In case you missed the
> beginning of this thread: all my cramfs initrd's fail to mount as
> /dev/ram0 with 'wrong magic'; their romfs counterparts work fine.  I did
> manage to pivot_root into a cramfs root, but it blew up pretty quick
> with 'attempt to access beyond end of device', and killed my init
> shell.  Then there's the wierdness where cramfs compiled in the kernel
> corrupts the romfs.  Adam's one-liner (bforget -> brelse on superblock)
> didn't fix this.

Uhhuh. I've never used cramfs on a ramdisk, but I have a guess: cramfs
_really_ wants to have 4kB blocks. I bet your ramdisk has 1kB blocks (the
default).

Have you tried using 

	ramdisk_blocksize=4096

as a boot option?

> The cramfs docs are contradictory btw; the kernel help says 'doesn't
> support hardlinks', and Documentation/filesystems/cramfs.txt says
> 'Hardlinks are supported, but...'.  I made my cramfs with and without
> hardlinks (to busybox); but that didn't affect whether it mounted.  I
> haven't tested whether this fixes the 'access beyond end of device'
> problems.

The documentation is right. cramfs does not support hardlinks.

HOWEVER, cramfs gives you the _effect_ of hardlinks by having mkcramfs
notice that two files are the same (whether hardlinked or not), and
re-using the data block pointer. This gives you all the space savings of
hard links, with a twist: you can actually have two separate files, with
separate permissions and owners etc, and they will be "linked" in the data
linking meaning if the contents are the same.

So you could think of the cramfs links as being a superset of hardlinks.
Or a "corruption" of hardlinks. The file shows up as two different files
as far as unix tools are concerned (nlink == 1, different inode numbers
etc), but becasue of the data sharing they have the disk usage pattern of
a hardlink.

The reason you don't have (and cannot have) _true_ hardlinks is obvious:
ramfs does not have inodes. It only has directory entries with enough
information to fill in a linux inode structure. Kind of like FAT, in that
respect.

This, btw, also means that it's counterproductive to try to save space on
the source tree that is crammed by trying to find identical files and
hardlinking them - mkcramfs will do the same thing regardless.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
