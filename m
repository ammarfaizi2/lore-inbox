Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131665AbRDSSE3>; Thu, 19 Apr 2001 14:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131669AbRDSSET>; Thu, 19 Apr 2001 14:04:19 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:4826 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131665AbRDSSEG>;
	Thu, 19 Apr 2001 14:04:06 -0400
Date: Thu, 19 Apr 2001 14:02:03 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Dilger <adilger@turbolinux.com>
cc: linux-kernel@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
Subject: Re: ext2 inode size (on-disk)
In-Reply-To: <200104191741.f3JHfaMZ013988@webber.adilger.int>
Message-ID: <Pine.GSO.4.21.0104191345400.16930-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Apr 2001, Andreas Dilger wrote:

> Al, you write:
> > 	Erm... Folks, can ->s_inode_size be not a power of 2? Both
> > libext2fs and kernel break in that case. Example:
> > 
> > dd if=/dev/zero of=foo bs=1024 count=20480
> > mkfs -I 192 foo
> 
> I had always assumed that it would be a power-of-two size, but since it
> is an undocumented option to mke2fs, I suppose it was never really
> intended to be used.  It appears, however, that the mke2fs code
> doesn't do ANY checking on the parameter, so you could concievably make
> the inode size SMALLER than the current size, and this would DEFINITELY
> be bad as well.

In some sense it does - it dies if you've passed it not a power of two ;-)
I don't think that segfault is a good way to report the problem, though...

Problem with mkfs is obvious, but kernel side is also shady - we could
have cleaner code if we assumed that inode size is power of 2. As it
is, we have a code in read_super() that checks for size == 128 _and_
code that was apparently writen in assumption that it can be not a
power of 2. However, if that was the really the goal, we fail - code
in ext2_read_inode() actually would break with such sizes.

In other words, the real question is what the hell are we trying to
do there. If we want code that deals with sizes that are not powers of 2
we need to change ext2_read_inode() and friends. It wouldn't be
hard. OTOH, if we guarantee that inode size will always remain a power of
2 we can simplify the thing. In any case current situation doesn't
make much sense. The only question is direction of fix.

Could those who introduced ->s_inode_size tell what use had been intended?

> mke2fs will always set up the filesystem this way, and there is no real
> reason NOT to do that.  If you are using a filesystem block for the inode
> table, it is pointless to leave part of it empty, because you can't use
> it for anything else anyways.

It's not that simple - if you need 160 bytes per inode rounding it up
to the next power of two will lose a lot. On 4Kb fs it will be
16 inodes per block instead of 25 - 36% loss...

