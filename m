Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276894AbRJCGmb>; Wed, 3 Oct 2001 02:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276891AbRJCGmY>; Wed, 3 Oct 2001 02:42:24 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:13566 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S276888AbRJCGmJ>; Wed, 3 Oct 2001 02:42:09 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Wed, 3 Oct 2001 00:41:39 -0600
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Neil Brown <neilb@cse.unsw.edu.au>, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.4.11-pre2 fs/buffer.c: invalidate: busy buffer
Message-ID: <20011003004139.B8954@turbolinux.com>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
	Ingo Molnar <mingo@elte.hu>
In-Reply-To: <9pe345$8ic$1@penguin.transmeta.com> <Pine.GSO.4.21.0110030014270.21861-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0110030014270.21861-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 03, 2001  00:21 -0400, Alexander Viro wrote:
> AFAICS, md.c also doesn't play nice with buffe cache.
> 
>         fsync_dev(dev);
>         set_blocksize(dev, MD_SB_BYTES);
>         bh = getblk(dev, sb_offset / MD_SB_BLOCKS, MD_SB_BYTES);
>         if (!bh) {
>                 printk(GETBLK_FAILED, partition_name(dev));
>                 return 1;
>         }
>         memset(bh->b_data,0,bh->b_size);
>         sb = (mdp_super_t *) bh->b_data;
>         memcpy(sb, rdev->sb, MD_SB_BYTES);
> 
>         mark_buffer_uptodate(bh, 1);
>         mark_buffer_dirty(bh);
>         ll_rw_block(WRITE, 1, &bh);
>         wait_on_buffer(bh);
>         brelse(bh);
>         fsync_dev(dev);
> 
> is not a good thing to do (write_disk_sb()).  Not to mention the fact that
> set_blocksize() looks bogus, the code is obviously racy.  Think what will
> happen if somebody is reading from device at that moment.

This is especially true since I think this function is called not only
during startup and shutdown of a device, but also whenever there is a
problem with a disk (e.g. hot_remove_disk(), md_do_recovery(), raid1/5
errors, etc).  Maybe people don't notice it much because MD_SB_BYTES=4096
is the default blocksize of ext2/ext3 for devices > 500MB (i.e. most
RAID devices), and the only blocksize for reiserfs.

Three possibilities:
1) Save the blocksize and restore it afterwards (ugly, not 100% fix)
2) Do I/O in the current blocksize, which adds slight complication to
   this function, but not too much (loop on the number of blocks to
   write, normally only one).  I don't know what impact this has
   on superblock consistency, but in theory none because you can't
   guarantee larger than single-sector I/O anyways, although there
   _may_ be a slightly increased chance of not getting a bh in OOM.
   Compiled but untested patch below.  I had also looked at the read
   path, but it is only used for new disks so no harm in setting blocksize.
3) Rewrite to do I/O directly via pagecache?

Cheers, Andreas

PS - Neil and Ingo CC'd
==========================================================================
--- linux.orig/drivers/md/md.c	Tue Jul 10 17:05:24 2001
+++ linux/drivers/md/md.c	Wed Oct  3 00:19:23 2001
@@ -913,10 +913,10 @@
 
 static int write_disk_sb(mdk_rdev_t * rdev)
 {
-	struct buffer_head *bh;
+	struct buffer_head *bh[MD_SB_BYTES/512];
 	kdev_t dev;
 	unsigned long sb_offset, size;
-	mdp_super_t *sb;
+	int blocksize, sb_chunks, i;
 
 	if (!rdev->sb) {
 		MD_BUG();
@@ -950,21 +950,30 @@
 
 	printk("(write) %s's sb offset: %ld\n", partition_name(dev), sb_offset);
 	fsync_dev(dev);
-	set_blocksize(dev, MD_SB_BYTES);
-	bh = getblk(dev, sb_offset / MD_SB_BLOCKS, MD_SB_BYTES);
-	if (!bh) {
-		printk(GETBLK_FAILED, partition_name(dev));
-		return 1;
+	blocksize = blksize_size[MAJOR(dev)][MINOR(dev)];
+	if (blocksize == 0)
+		blocksize = BLOCK_SIZE;
+	sb_chunks = blocksize >= MD_SB_BYTES ? 1 : MD_SB_BYTES / blocksize;
+	for (i = 0; i < sb_chunks; i++) {
+		bh[i] = getblk(dev, sb_offset / blocksize + i, blocksize);
+		if (!bh[i]) {
+			printk(GETBLK_FAILED, partition_name(dev));
+			while (i--)
+				brelse(bh[i]);
+			return 1;
+		}
+		if (blocksize > MD_SB_BYTES)
+			memset(bh[i]->b_data, 0, bh[i]->b_size);
+		memcpy(bh[i]->b_data, (char*)rdev->sb + i*blocksize, blocksize);
+
+		mark_buffer_uptodate(bh[i], 1);
+		mark_buffer_dirty(bh[i]);
+	}
+	ll_rw_block(WRITE, sb_chunks, bh);
+	while (i--) {
+		wait_on_buffer(bh[i]);
+		brelse(bh[i]);
 	}
-	memset(bh->b_data,0,bh->b_size);
-	sb = (mdp_super_t *) bh->b_data;
-	memcpy(sb, rdev->sb, MD_SB_BYTES);
-
-	mark_buffer_uptodate(bh, 1);
-	mark_buffer_dirty(bh);
-	ll_rw_block(WRITE, 1, &bh);
-	wait_on_buffer(bh);
-	brelse(bh);
 	fsync_dev(dev);
 skip:
 	return 0;
@@ -2745,7 +2764,7 @@
 		}
 
 		default:
-			printk(KERN_WARNING "md: %s(pid %d) used obsolete MD ioctl, upgrade your software to use new ictls.\n", current->comm, current->pid);
+			printk(KERN_WARNING "md: %s(pid %d) used obsolete MD ioctl, upgrade your software to use new ioctls.\n", current->comm, current->pid);
 			err = -EINVAL;
 			goto abort_unlock;
 	}
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

