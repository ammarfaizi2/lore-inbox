Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262092AbSIYT7B>; Wed, 25 Sep 2002 15:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262093AbSIYT7B>; Wed, 25 Sep 2002 15:59:01 -0400
Received: from thunk.org ([140.239.227.29]:159 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S262092AbSIYT7A>;
	Wed, 25 Sep 2002 15:59:00 -0400
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] Add ext3 indexed directory (htree) support
From: tytso@mit.edu
Phone: (781) 391-3464
Message-Id: <E17uINs-0003bG-00@think.thunk.org>
Date: Wed, 25 Sep 2002 16:03:44 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This changeset contains Daniel Phillip's indexed directory changes,
ported to 2.5 by Christopher Li and Andrew Morton, and then extensively
cleaned up by me.  I also implemented the enhanced dx_readdir code which
returns files would be returned in hash order.  This was necessary so
that concurrent tree splits would not result in filenames to be
erroneously returned twice or not at all when the b-tree splits
reorganized the directory out from underneath readdir().

This patch significantly increases the speed of using large directories.
Creating 100,000 files in a single directory took 38 minutes without
directory indexing... and 11 seconds with the directory indexing turned on.

I've given this code a good bit of testing, under both 2.4 and 2.5
kernels, and believe that it is ready for prime-time.  Please pull it
from:

	bk://extfs.bkbits.net/for-linus-htree-2.5

In order to use the new directory indexing feature, please update your
e2fsprogs to 1.29.  Existing filesystem can be updated to use directory
indexing using the command "tune2fs -O dir_index /dev/hdXXX".  This can
be done while the filesystem is mounted, and subsequent new directories
or directories fit within a single block will be use the new (backwards
compatible) dirctory indexing format when they grow beyond a single
block.

Existing large directories on the filesystem can be converted to use the
new indexed directory format by running the following command on an
unmounted filesystem "e2fsck -fD /dev/hdXXX".  

							- Ted

 fs/ext3/Makefile           |    2 
 fs/ext3/dir.c              |  298 ++++++++++
 fs/ext3/file.c             |    3 
 fs/ext3/hash.c             |  215 +++++++
 fs/ext3/namei.c            | 1305 ++++++++++++++++++++++++++++++++++++++++-----
 fs/ext3/super.c            |    6 
 include/linux/ext3_fs.h    |   86 ++
 include/linux/ext3_fs_sb.h |    2 
 include/linux/ext3_jbd.h   |    2 
 include/linux/rbtree.h     |    1 
 lib/rbtree.c               |   16 
 11 files changed, 1797 insertions(+), 139 deletions(-)

(The changes to rbtree.c were to add a new function rb_first(), which
returns the first node in the rbtree.)
