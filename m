Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274540AbRITPo6>; Thu, 20 Sep 2001 11:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274541AbRITPos>; Thu, 20 Sep 2001 11:44:48 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:54693
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S274540AbRITPob>; Thu, 20 Sep 2001 11:44:31 -0400
Date: Thu, 20 Sep 2001 11:44:48 -0400
From: Chris Mason <mason@suse.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <703500000.1001000688@tiny>
In-Reply-To: <Pine.GSO.4.21.0109201046270.3498-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0109201046270.3498-100000@weyl.math.psu.edu>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, September 20, 2001 10:50:16 AM -0400 Alexander Viro
<viro@math.psu.edu> wrote:

>> The biggest exception is blkdev_writepage directly submits the io instead
>> of marking the buffers dirty.  This means the buffers won't be on
>> the locked/dirty list, and they won't get waited on.  Similar problem
>> for direct io.
> 
> <nod>  And if you add Andrea's (perfectly valid) observation re having no
> need to sync any fs structures we might have for that device, you get
> __block_fsync().  After that it's easy to merge blkdev_close() code into
> blkdev_put().
> 
>

Ok, __block_fsync is much better than just fsync_dev.

Are there other parts of blkdev_close you want merged into 
blkdev_put? Without changing the reread blocks on last close 
semantics, I think this is all we can do.

As far as I can tell, bdev->bd_inode is valid to send 
to __block_fsync, am I missing something?

--- linux/fs/block_dev.c	Mon Sep 17 11:28:56 2001
+++ linux/fs/block_dev.c	Thu Sep 20 11:21:39 2001
@@ -704,10 +704,9 @@
 	kdev_t rdev = to_kdev_t(bdev->bd_dev); /* this should become bdev */
 	down(&bdev->bd_sem);
 	lock_kernel();
-	if (kind == BDEV_FILE)
-		fsync_dev(rdev);
-	else if (kind == BDEV_FS)
-		fsync_no_super(rdev);
+
+	__block_fsync(bdev->bd_inode) ;
+
 	/* only filesystems uses buffer cache for the metadata these days */
 	if (kind == BDEV_FS)
 		invalidate_buffers(rdev);

