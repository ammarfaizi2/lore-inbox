Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131492AbRCNTQr>; Wed, 14 Mar 2001 14:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131495AbRCNTQi>; Wed, 14 Mar 2001 14:16:38 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:7165 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S131483AbRCNTQZ>; Wed, 14 Mar 2001 14:16:25 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103141914.f2EJEVN10163@webber.adilger.int>
Subject: Re: (struct dentry *)->vfsmnt;
In-Reply-To: <Pine.GSO.4.21.0103141254000.4468-100000@weyl.math.psu.edu> from
 Alexander Viro at "Mar 14, 2001 01:11:05 pm"
To: Alexander Viro <viro@math.psu.edu>
Date: Wed, 14 Mar 2001 12:14:31 -0700 (MST)
CC: Andreas Dilger <adilger@turbolinux.com>,
        Linux kernel development list <linux-kernel@vger.kernel.org>,
        Linux FS development list <linux-fsdevel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al writes:
> On Wed, 14 Mar 2001, Andreas Dilger wrote:
> > The AIX vgimport will not corrupt /etc/fstab with duplicate mounts, nor for
> > that matter with duplicate LV names (AIX has a single namespace for all LVs).
> > If a conflict is found with an LV name, a new name like "lv01" is used (the
> > LV names are not that important anyways).  I'm not sure what would
> > happen with a duplicate mount point (whether it would pick a new name, or
> > simply leave it out of /etc/fstab), but it isn't too hard to think of
> > easy ways to fix this (e.g. /home01 or /mnt/vgname/home or whatever).
> 
> Excuse me, but doesn't it scream "userland"? IOW, is there any reason to
> do that in the kernel? If you want to spread /etc/fstab all over the
> place storing bits in relevant filesystems - fine, you even don't
> need to bother with superblocks. Just teach mount(8) to put the
> mountpoint into /.last.mounted and be done with that...

Obviously, the whole vgimport stuff is going to be in userland.  The only
part that needs to go in the kernel is storing the mountpoint in the
filesystem superblock.  It is _not_ OK to just put it in /.last.mounted.
Quite often a data/application VG is moved independent of the root filesystem.
The info needs to stay with the filesystem itself.

> 	It's a policy question - if somebody wants to play with such
> schemes he can do it in the place where policy stuff belongs.
> I.e. in userland.

Yes, the policy for resolving conflicts and such will be in userland.
Yes, the policy for determining the initial mountpoints is done in
userland.  The only thing I want to do in kernel space is store the
mountpoint in the "last mounted" field in the superblock.  It also
will help InterMezzo to know this information.

> Since the reading side contains a bunch of heuristics
> (obviously depending on the local naming policy for temp. mountpoints,
> for one thing) you don't need anything special on the writing side...

The writing side can't be done in userland without basically making
mount(8) know about the superblock layout of each and every filesystem:

- you create a new filesystem
- you mount it

When can we update the superblock?

At filesystem creation time    -> not guaranteed to stay up-to-date.
With mount(8)                  -> needs superblock format of each filesystem.
Inside fs-specific kernel code -> about 2 lines of code, if we could just
                                  call d_path() or have mountpoint as param.

The information is already inside the kernel.  I would _actually_ rather
just get dir_name from do_mount() down inside *_read_super.  However, AFAICT
this it is easier (i.e. doesn't change the VFS interface) to pass the d_dir
dentry in the generic superblock to *_read_super.  If calling d_path() is the
wrong thing to do, then I would be happy to hear another way of getting
dir_name to *_read_super() without breaking the VFS interface.

Cheers, Andreas

PS - in 2.2 I can do this with < 10 lines of code (including ext2-specific
     code).  I'm just asking for some _help_ to understand what needs to
     be done for 2.4.
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
