Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131308AbRCNF7h>; Wed, 14 Mar 2001 00:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131310AbRCNF71>; Wed, 14 Mar 2001 00:59:27 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:14587 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S131308AbRCNF7I>; Wed, 14 Mar 2001 00:59:08 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103140558.f2E5w8P06685@webber.adilger.int>
Subject: Re: ln -l says symlink has size 281474976710666
In-Reply-To: <20010314022236.D18554@grulic.org.ar> from John R Lenton at "Mar
 14, 2001 02:22:36 am"
To: John R Lenton <john@grulic.org.ar>
Date: Tue, 13 Mar 2001 22:58:08 -0700 (MST)
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Lenton writes:
> burocracia:~# debugfs /dev/hda2
> debugfs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
> debugfs:  stat <404176>
> Inode: 404176   Type: symlink    Mode:  0777   Flags: 0x0   Generation: 2457884131
> User:     0   Group:     0   Size: 281474976710666
> Fast_link_dest: imlib-base
> debugfs:  stat <404192>
> Inode: 404192   Type: symlink    Mode:  0777   Flags: 0x0   Generation: 1796859698
> User:     0   Group:     0   Size: 281474976710669
> Fast_link_dest: /proc/self/fd

So it is garbage in the "i_size_high" field (=i_dir_acl) in the inode.

> this is after an e2fsck, after a reboot, after restart. Nothing
> in the logs. The inodes are as old as the system, which isn't all
> that old (circa the first release with reiserfs).

Luckily, after the symlink is created it ignores the size, and only uses
the i_blocks count to determine if the symlink is stored in the inode
itself or in another block (the fast symlink will be NUL terminated).
It could well have been corruption from a long time ago, and only with
2.4.x and LFS you have noticed it.

Probably e2fsck needs to be updated to check for and fix this problem -
it is impossible for a symlink to be larger than a single block, so
the i_size_high field should always be zero.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
