Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130434AbRCGIX0>; Wed, 7 Mar 2001 03:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130435AbRCGIXG>; Wed, 7 Mar 2001 03:23:06 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:47856 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S130434AbRCGIW4>; Wed, 7 Mar 2001 03:22:56 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103070820.f278KpD04486@webber.adilger.net>
Subject: Re: RAID, 2.4.2 and Buslogic
In-Reply-To: <Pine.LNX.4.33.0103061015130.1695-100000@twinlark.arctic.org> from
 Jauder Ho at "Mar 6, 2001 11:53:07 pm"
To: Jauder Ho <jauderho@carumba.com>
Date: Wed, 7 Mar 2001 01:20:51 -0700 (MST)
CC: lnz@dandelion.com, alan@www.linux.org.uk, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jauder Ho writes:
> My story is somewhat similar to what Dick Johnson has encountered except
> this is with 2.4.2 running on a pentium 200.
> 
> EXT2-fs error (device md(9,0)): ext2_add_entry: bad entry in directory
> #343396:
> inode out of bounds - offset=0, inode=343396, rec_len=12, name_len=1
> EXT2-fs error (device md(9,0)): ext2_write_inode: bad inode number: 12
> 
> EXT2-fs error (device md(9,0)): free_inode: reserved inode or nonexistent
> inode
> kernel BUG at inode.c:885!

Inode 12 is a perfectly valid inode number for any filesystem, so your
ext2 superblock must have been corrupt (or zeroed out) at this point.
The value for sb->u.ext2_sb.s_es->s_inodes_count must have been < 12
(likely zero), which would explain all of these errors.  Strange.

I have posted (twice) a patch which would prevent the BUG from happening.
Granted, it won't help your RAID/SCSI corruption problem (*).  Please see

  [PATCH] sanity checks for ext2 root inode

in l-k archives.  I don't think this is in either Linus' or Alan's tree.

Cheers, Andreas

(*) in normal cases this prevents a small filesystem corruption from
    halting the system, but in your case, the BUG may have prevented
    larger corruption by halting the system before more damage was done?
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
