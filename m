Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751455AbWFISKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbWFISKR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 14:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWFISKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 14:10:17 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:30644 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1750721AbWFISKP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 14:10:15 -0400
Date: Fri, 9 Jun 2006 12:10:20 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alex Tomas <alex@clusterfs.com>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609181020.GB5964@schatzie.adilger.int>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Alex Tomas <alex@clusterfs.com>, Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@osdl.org>,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, cmm@us.ibm.com,
	linux-fsdevel@vger.kernel.org
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int> <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org> <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net> <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 09, 2006  09:25  -700, Linus Torvalds wrote:
> So two separate filesystems are _less_ to maintain than one big one. Even
> if there's a lot of code that -could- be shared.

That is true if people are willing to maintain both trees.  I think that
even with the current ext2/ext3 split there are continually fixes that are
missing from one filesystem or another.

> Just as an example: ext3 _sucks_ in many ways. It has huge inodes that
> take up way too much space in memory. It has absolutely disgusting code to
> handle directory reading and writing (buffer heads! In 2006!).

My point exactly!  The ext2 directory code was moved from buffer heads to
page cache by Al after ext3 was forked and the code was never fixed in ext3.

I don't see this getting any better if there is an ext4 filesystem and all
of the ext3 developers are only interested in maintaining ext4.  Look at
reiserfs - it is completely abandoned by Hans in favour of reiser4 (the
entry in MAINTAINERS notwithstanding) except for Chris Mason at SuSE.

Having a single codebase for everyone means that it is continually maintained
and users of ext3 aren't left out in the cold.

On Jun 09, 2006  09:54 -0700, Linus Torvalds wrote:
> Btw, I'm not kidding you on this one.
> 
> THE NUMBER ONE MEMORY USAGE ON A LOT OF LOADS IS EXT3 INODES IN MEMORY!

Do you think that would be any different with a new filesystem?

> And you know what? 2TB files are totally uninteresting to 99.9999% of all 
> people. Most people find it _much_ more interesting to have hundreds of 
> thousands of _smaller_ files instead.
> 
> So do this:
> 
> 	cat /proc/slabinfo | grep ext3

# head -2 /proc/slabinfo
slabinfo - version: 2.1
name       <active_objs> <num_objs> <objsize> <objperslab>

# grep ext2 /proc/slabinfo
ext2_inode_cache       0          0       572            7
ext2_xattr             0          0        48           81

# grep ext3 /proc/slabinfo

ext3_inode_cache   30207      41418       616            6
ext3_xattr             0          0        48           81

# grep xfs /proc/slabinfo
xfs_ili             2558       2576       140           28
xfs_inode           2558       2565       448            9

# grep jfs /proc/slabinfo
jfs_ip                 0          0      1048            3

So, the ext3 inode could grow another ~50 bytes without changing the
slab allocation size ;-), and in fact other filesystem aren't noticably
different.

> and be absolutely disgusted and horrified by the size of those inodes 
> already, and ask yourself whether extending the block size to 48 bits will 
> help or further hurt one of the biggest problems of ext3 right now?

This is then the biggest problem of all filesystems.

> (And yes, I realize that block numbers are just a small part of it. The 
> "vfs_inode" is also a real problem - it's got _way_ too many large 
> list-heads that explode on a 64-bit kernel, for example. Oh, well.

On a 32-bit system the vfs_inode is more than half of the size of the ext3
inode, it is worse on 64-bit systems.

> My point is that things like this can make a very real issue _worse_ for all 
> the people who don't care one whit about it)

The current group of changes will be a no-op if CONFIG_LBD isn't enabled,
and I think I argued fairly strongly to also have a CONFIG_ flag to allow
larger than 2TB file support only for those users that want it.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

