Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131482AbRCNR3I>; Wed, 14 Mar 2001 12:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131480AbRCNR3A>; Wed, 14 Mar 2001 12:29:00 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:50428 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S131476AbRCNR2p>; Wed, 14 Mar 2001 12:28:45 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103141726.f2EHQoj09856@webber.adilger.int>
Subject: Re: (struct dentry *)->vfsmnt;
In-Reply-To: <Pine.GSO.4.21.0103140146590.2506-100000@weyl.math.psu.edu> from
 Alexander Viro at "Mar 14, 2001 01:50:41 am"
To: Alexander Viro <viro@math.psu.edu>
Date: Wed, 14 Mar 2001 10:26:50 -0700 (MST)
CC: Andreas Dilger <adilger@turbolinux.com>,
        Linux kernel development list <linux-kernel@vger.kernel.org>,
        Linux FS development list <linux-fsdevel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al writes:
> On Tue, 13 Mar 2001, Andreas Dilger wrote:
> 
> > On AIX, it is possible to import a volume group, and it automatically
> > builds /etc/fstab entries from information stored in the fs.  Having the
> > "last mounted on" would have the mount point info, and of course LVM
> > would hold the device names.
> 
> Wait a minute. What happens if you bring /home from one box to another,
> that already has /home? Corrupted /etc/fstab?

The AIX vgimport will not corrupt /etc/fstab with duplicate mounts, nor for
that matter with duplicate LV names (AIX has a single namespace for all LVs).
If a conflict is found with an LV name, a new name like "lv01" is used (the
LV names are not that important anyways).  I'm not sure what would
happen with a duplicate mount point (whether it would pick a new name, or
simply leave it out of /etc/fstab), but it isn't too hard to think of
easy ways to fix this (e.g. /home01 or /mnt/vgname/home or whatever).

It was really useful (i.e. easy to manage) to be able to move a bunch of
disks (making a whole volume group) from one system to another, import it,
and then not have to mount each filesystem to figure out what the contents
are before editing /etc/fstab to set up the correct mount point.  In 99.9%
of the cases, the mountpoints were correct.  I don't think you can ever
have a system that is 100% correct all of the time.

For AIX, the base filesystems in the rootvg (/, /usr, /var, /tmp, /home,
/boot, and swap) all moved as a single unit (sometimes /home was moved
out for systems that served lots of users).  For data or application
specific filesystems, the normal practise was to put them into their own
volume group for backup, failover, etc.  This made it easy to upgrade
systems, or move a critical application to another server in case of
hardware problems (whether manual or via HA auto failover).

> Let me put it that way: I don't understand why (if it is useful at all)
> it is done in the fs. Looks like a wrong level...

For the same reason that the UUID and LABEL are stored in the superblock:
you want this infomation kept with the filesystem and not anywhere else,
otherwise it will quickly get out-of-date.  Wherever you mounted the
filesystem last is where it would be mounted if you import the VG on
another system.  You can obviously edit /etc/fstab afterwards if it is
wrong, and then remount the filesystem(s), and this will store the
correct mountpoint into the filesystem for the next vgimport.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
