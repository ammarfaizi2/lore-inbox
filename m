Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266135AbRGLWcS>; Thu, 12 Jul 2001 18:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266263AbRGLWcI>; Thu, 12 Jul 2001 18:32:08 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:19961 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S266135AbRGLWbz>; Thu, 12 Jul 2001 18:31:55 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107122229.f6CMTdji028251@webber.adilger.int>
Subject: Re: [PATCH] ext2 cleanups
In-Reply-To: <E15Kl6L-0006Zk-00@the-village.bc.nu> "from Alan Cox at Jul 12,
 2001 07:22:13 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 12 Jul 2001 16:29:39 -0600 (MDT)
CC: Andreas Dilger <adilger@turbolinux.com>, torvalds@transmeta.com,
        Linux kernel development list <linux-kernel@vger.kernel.org>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan writes:
> > This patch cleans up the ext2 code in various places.  It is mostly cosmetic
> > changes to comments, avoiding lines > 80 columns, removing redundant #ifdef
> > lines, etc.  It also adds the new COMPAT flags from the current e2fsprogs
> > into include/linux/ext2_fs.h.
> 
> Any reason for not delaying this until 2.5.0 ? (ie any bug fixes)

No, it is cosmetic only (OK, the wrong block is reported as being cleared
if there is an error in ext2_free_blocks(), but that isn't much of a bug.

Neither is the 4 bytes wasted in ext2_inode_info by not_used_1, but in
the -ac kernels ext2 is the largest inode struct now that NFS is out
(AFAIK), so if you remove ext2 not_used_1, i_new_inode, i_osync, and put
i_prealloc_count into the 16 bits freed by i_osync, along with removing
i_attr_flags you can pack 10 struct inodes into a page instead of 9.
Note that the current patch does not do all of that yet.

Having 10% fewer pages for inodes would save me 142*4k = 568kB of RAM
on the system I'm writing this on, and frequently more as you can get
a LOT of cached inodes when running updatedb or a tar or similar.

<rant>
For that matter, there is a lot of cruft in struct inode that could be
in a union (e.g. you can't truncate, or have quotas on a pipe, block,
or char dev, and you don't need i_blocks in this case either, and you
only need i_dnotify for directories (I think i_zombie also), i_flock
for files, etc).  That is too much for 2.4, however, and will wait for
2.5 if there is support for this.  This would go along with fs-private
data in slab cache so that you don't need to pay a penalty for the worst
filesystem even if you don't use it.
</rant>

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
