Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136104AbREJMJT>; Thu, 10 May 2001 08:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136135AbREJMJI>; Thu, 10 May 2001 08:09:08 -0400
Received: from zeus.kernel.org ([209.10.41.242]:61671 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S136145AbREJMDQ>;
	Thu, 10 May 2001 08:03:16 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105100721.f4A7LoN9021455@webber.adilger.int>
Subject: Re: [PATCH][CFT] (updated) ext2 directories in pagecache
In-Reply-To: "from (env: adilger) at May 9, 2001 03:22:10 pm"
To: phillips@bonn-fries.net
Date: Thu, 10 May 2001 01:21:50 -0600 (MDT)
CC: Linux kernel development list <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I previously wrote:
> I was looking at the new patch, and I saw something that puzzles me.
> Why do you set the EXT2_INDEX_FL on a new (empty) directory, rather
> than only setting it when the dx_root index is created?
> 
> Setting the flag earlier than that makes it mostly useless, since it
> will be set on basically every directory.  Not setting it would also
> make your is_dx() check simply a check for the EXT2_INDEX_FL bit (no
> need to also check size).
> 
> Also no need to set EXT2_COMPAT_DIR_INDEX until such a time that we have
> a (real) directory with an index, to avoid gratuitous incompatibility
> with e2fsck.

I have changed the code to do the following:
- If the COMPAT_DIR_INDEX flag is set at mount/remount time, set the
  INDEX mount option (the same as "mount -o index").  This removes
  the need to specify the "-o index" option each time for filesystems
  which already have indexed directories.
- New directories NEVER have the INDEX flag set on them.
- If the INDEX mount option is set, then when directories grow past 1
  block (and have the index added) they will get the directory INDEX
  flag set and turn on the superblock COMPAT_DIR_INDEX flag (if off).

This means that you can have common code for indexed and non-indexed ext2
filesystems, and the admin either needs to explicitly set COMPAT_DIR_INDEX
in the superblock or mount with "-o index" (and create a directory > 1 block).

I have also added some tricks to ext2_inc_count() and ext2_dec_count() so
that indexed directories are not subject to the EXT2_LINK_MAX.  I've done
the same as reiserfs, and set i_nlink = 1 if we overflow EXT2_LINK_MAX
(which has been increased to 65500 for indexed directories). Apparently
i_nlink = 1 is the right think to do w.r.t. find and other user tools.

Patches need some light testing before being posted.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
