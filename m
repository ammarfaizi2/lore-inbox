Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281234AbRKUNbB>; Wed, 21 Nov 2001 08:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281050AbRKUNav>; Wed, 21 Nov 2001 08:30:51 -0500
Received: from uucp.cistron.nl ([195.64.68.38]:63239 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S280998AbRKUNaj>;
	Wed, 21 Nov 2001 08:30:39 -0500
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: block_dev.c: fsync() on close() considered harmful
Date: Wed, 21 Nov 2001 13:30:38 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9tga9u$62i$1@ncc1701.cistron.net>
X-Trace: ncc1701.cistron.net 1006349438 6226 195.64.65.67 (21 Nov 2001 13:30:38 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running an INN usenet news server that uses raw partitions for
storage. I.e. it opens /dev/sda7 etc. and mmap()s [which finally
works in 2.4, hurray]

Even though the server is keeping those devices open, when a utility
program opens that file/device and closes() it the close() causes
a fsync() on the device, something that is not wanted.

I applied the following patch which fixes it for me, it prevents
the sync-after-close if it was close() calling blkdev_put()
and we're not the last one to call blkdev_put().

That means fsync() will still be done on unmounts or when the
last user of the device closes it, but not otherwise.

Is this correct or am I overlooking something?

--- linux-2.4.15-pre8/fs/block_dev.c.orig	Thu Oct 25 22:58:35 2001
+++ linux-2.4.15-pre8/fs/block_dev.c	Wed Nov 21 13:32:16 2001
@@ -603,7 +603,7 @@
 
 	down(&bdev->bd_sem);
 	lock_kernel();
-	if (kind == BDEV_FILE)
+	if (kind == BDEV_FILE && bdev->bd_openers == 1)
 		__block_fsync(bd_inode);
 	else if (kind == BDEV_FS)
 		fsync_no_super(rdev);



Mike.
-- 
"Only two things are infinite, the universe and human stupidity,
 and I'm not sure about the former" -- Albert Einstein.

