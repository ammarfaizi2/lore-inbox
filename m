Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132636AbREFD7k>; Sat, 5 May 2001 23:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132686AbREFD7a>; Sat, 5 May 2001 23:59:30 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:58818 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132636AbREFD7T>;
	Sat, 5 May 2001 23:59:19 -0400
Date: Sat, 5 May 2001 23:59:17 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Wedgwood <cw@f00f.org>
cc: Andrea Arcangeli <andrea@suse.de>, Jens Axboe <axboe@suse.de>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, volodya@mindspring.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <20010506153218.A11911@tapu.f00f.org>
Message-ID: <Pine.GSO.4.21.0105052338580.26799-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 6 May 2001, Chris Wedgwood wrote:

>     It's not exactly "kernel-based fsck". What I've been talking about
>     is secondary filesystem providing coherent access to primary fs
>     metadata.  I.e. mount -t ext2meta -o master=/usr none /mnt and
>     then access through /mnt/super, /mnt/block_bitmap, etc.
> 
> Call me stupid --- but what exactly does the above actually achieve?
> Why would you do this?

Coherent access to metadata? Well, for one thing, it allows stuff like
tunefs and friends on mounted fs. What's more useful, it allows to
do things like access to boot code, which is _not_ safe to do through
device access - usually you have superblock in vicinity and no warranties
about the things that will be overwritten on umount. Same for debugging
stuff, IO stats, etc. - access through secondary tree is much saner
than inventing tons of ioctls for dealing with that. Moreover, it allows
fsck and friends to get rid of code duplication - while the repair
logics, etc. stays in userland (where it belongs) layout information
is already handled in the kernel. No need to duplicate it in userland...

Besides, with moving bitmaps, etc. into pagecache it becomes trivial
to implement.

BTW, we have another ugly chunk of code - duplicated between kernel
and userland and nasty in both incarnations. I mean handling of the
partition tables. Kernel should be able to read and parse them -
otherwise they are useless, right? Now, we have a bunch of userland
utilities that do the same. Various fdisks, that is. If you look
how they work you'll see that on the read side they duplicate
kernel code and on the write side... To put it quite mildly, they are
not doing it in graceful way. They write relevant sectors to disk and
use BLKRRPART to tell the kernel that ti should forget about all partitions
on that disk and reread the partition tables. _Not_ a nice thing to do,
since creation of new partition out of unused space on /dev/sda becomes
an interesting task when your root lives on /dev/sda1. Ditto for destroying
a single partition (not mounted/used by swap/etc.) while you have some
other partition in use. IWBNI we had a decent API for handling partition
tables...

