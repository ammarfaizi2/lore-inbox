Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262744AbRE0EZQ>; Sun, 27 May 2001 00:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262745AbRE0EZG>; Sun, 27 May 2001 00:25:06 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:31665 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262744AbRE0EYu>;
	Sun, 27 May 2001 00:24:50 -0400
Date: Sun, 27 May 2001 00:24:46 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Gavin <glang02@dingoblue.net.au>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: [FIX] Re: umount segfault on shutdown
In-Reply-To: <20010526224846.0b1df420.glang02@dingoblue.net.au>
Message-ID: <Pine.GSO.4.21.0105270023140.1945-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 May 2001, Gavin wrote:

> Hi,
> Hope this is enough info :P
> 
> Unmounting file systems: journal_begin called without kernel lock held
> kernel BUG at journal.c:423!


--- fs/super.c	Fri May 25 21:51:14 2001
+++ fs/super.c.new	Sun May 27 00:21:53 2001
@@ -873,6 +873,7 @@
 	}
 	spin_unlock(&dcache_lock);
 	down_write(&sb->s_umount);
+	lock_kernel();
 	sb->s_root = NULL;
 	/* Need to clean after the sucker */
 	if (fs->fs_flags & FS_LITTER)
@@ -901,6 +902,7 @@
 	put_filesystem(fs);
 	sb->s_type = NULL;
 	unlock_super(sb);
+	unlock_kernel();
 	up_write(&sb->s_umount);
 	if (bdev) {
 		blkdev_put(bdev, BDEV_FS);

