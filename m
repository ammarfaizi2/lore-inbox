Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131486AbRCNSJ2>; Wed, 14 Mar 2001 13:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131488AbRCNSJT>; Wed, 14 Mar 2001 13:09:19 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:54524 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S131480AbRCNSJO>; Wed, 14 Mar 2001 13:09:14 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103141806.f2EI6K209984@webber.adilger.int>
Subject: Re: (struct dentry *)->vfsmnt;
In-Reply-To: <20010314174031.A12200@parcelfarce.linux.theplanet.co.uk> from Matthew
 Wilcox at "Mar 14, 2001 05:40:31 pm"
To: Matthew Wilcox <matthew@wil.cx>
Date: Wed, 14 Mar 2001 11:06:20 -0700 (MST)
CC: Andreas Dilger <adilger@turbolinux.com>,
        Alexander Viro <viro@math.psu.edu>,
        Linux kernel development list <linux-kernel@vger.kernel.org>,
        Linux FS development list <linux-fsdevel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You write:
> > For the same reason that the UUID and LABEL are stored in the superblock:
> > you want this infomation kept with the filesystem and not anywhere else,
> > otherwise it will quickly get out-of-date.  Wherever you mounted the
> > filesystem last is where it would be mounted if you import the VG on
> > another system.  You can obviously edit /etc/fstab afterwards if it is
> > wrong, and then remount the filesystem(s), and this will store the
> > correct mountpoint into the filesystem for the next vgimport.
> 
> Al is saying `why not do this in mount(8) instead of mount(2)?'  I haven't
> seen you answer that yet.

Because this is totally filesystem specific - why put extra knowledge
of filesystem internals into mount?  I personally don't want it writing
into the ext2 or ext3 superblock.  How can it possibly know what to do,
without embedding a lot of knowledge there?  Yes, mount(8) can _read_
the UUID and LABEL for ext2 filesystems, but I would rather not have it
_write_ into the superblock.  Also, InterMezzo and SnapFS have the same
on-disk format as ext2, but would mount(8) know that?

There are other filesystems (at least IBM JFS) that could also take
advantage of this feature, should we make mount(8) have code for each
and every filesystem?  Yuck.  Sort of ruins the whole modularity thing.
Yes, I know mount(8) does funny stuff for SMB and NFS, but that is a
reason to _not_ put more filesystem-specific information into mount(8).

Actually, one more reason to have this in the kernel is for InterMezzo
(distributed filesystem which uses ext3 for on-disk storage).  Currently,
the mount point is passed as a mount parameter (yuck) because it is
needed internally to the InterMezzo kernel code.  If the filesystem
could extract this information at mount time, it would remove the need
for the mount parameter.

The benefit of doing all of this in *_read_super() (probably would be in
ext2_setup_super() for ext2) is that filesystems which can use this feature
will do so, and others will not.  It is a matter of a single "d_path()"
call at mount (or remount for R/O mounted filesystems), so it is not like
it's going to slow down the system a lot.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
