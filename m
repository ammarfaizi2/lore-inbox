Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262511AbRE0WXE>; Sun, 27 May 2001 18:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262514AbRE0WWz>; Sun, 27 May 2001 18:22:55 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:64252 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262511AbRE0WWl>;
	Sun, 27 May 2001 18:22:41 -0400
Date: Sun, 27 May 2001 18:22:23 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: svbj@online.no
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: BUG?: 2.4.5 breaks reiserfs (kernel BUG)
In-Reply-To: <3B113742.518984CD@bjerkeset.com>
Message-ID: <Pine.GSO.4.21.0105271813320.3848-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 27 May 2001, Bjerkeset, Svein Olav wrote:

> Hi,
> 
> Today I downloaded kernel 2.4.5 and compiled it. The kernel worked fine
> until
> I tried to halt the computer. When trying to unmount the reiserfs
> filesystems,
> the system freezes with the following output:
> 
> journal_begin called without kernel lock held
> kernel BUG at journal.c:423!

	Yes. My fault - badly merged patch in -pre6, actually.
Details:
	* kill_super() gets called without BKL, but doesn't grab BKL around
the calls of ->write_super() and ->put_super()
	* by the time when it calls these methods filesystem is quiet. I.e.
nothing else has a chance to touch its data structures. So actually only
reiserfs (which checks that we hold BKL) had noticed.
	* It _is_ a bug - changing locking rules is for 2.5.

Fix:
--- fs/super.c	Fri May 25 21:51:14 2001
+++ fs/super.c	Sun May 27 00:21:53 2001
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

