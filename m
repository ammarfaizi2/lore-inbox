Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131492AbRAaTnX>; Wed, 31 Jan 2001 14:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131984AbRAaTnN>; Wed, 31 Jan 2001 14:43:13 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:55538 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S131492AbRAaTnJ>; Wed, 31 Jan 2001 14:43:09 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200101311942.f0VJgSD23675@webber.adilger.net>
Subject: Re: kernel BUG at inode.c:889!
In-Reply-To: <Pine.LNX.4.30.0101312023170.1186-100000@limbo.null.fi> from Timo
 Jantunen at "Jan 31, 2001 08:44:31 pm"
To: Timo Jantunen <jeti@iki.fi>
Date: Wed, 31 Jan 2001 12:42:27 -0700 (MST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timo Jantunen writes:
> While I was looking unused partitions to be used for ReiserFS testing
> (paranoia is a way of life when dealing with my data ;-), I did
> 
> mount /dev/hda5 /mnt/tmp
> 
> to a partition which I thought to be unused (just to be sure). This resulted
> in a Really Weird(tm) /mnt/tmp _file_ which didn't have any permissions to
> anyone. When checking kernel messages, I found "EXT2-fs warning: checktime
> reached, running e2fsck is recommended" line. Then I tried to unmount the
> partition. It checkfaulted. Messages had following entries.

It could be that the root inode was cleared out, and we don't check the
mode bits, so it was a file instead of a directory.  This would be worth
checking to avoid getting into a situation like this in the first place.

> Jan 31 19:46:30 limbo kernel: EXT2-fs error (device ide0(3,5)): free_inode: reserved inode or nonexistent inode
> Jan 31 19:46:30 limbo kernel: kernel BUG at inode.c:889!

It looks like it was trying to delete the root inode because it has a link
count of zero.  This would be consistent with the above mode issue, if
the root inode was corrupt.  It is (somewhat) surprising that you had this
corruption, yet still managed to mount the filesystem, given the number of
other checks in ext2_read_super().

Your OOPS trace shows dput() and iput() being called.  This will call
ext2_delete_inode() if i_nlink == 0, which calls ext2_update_inode()
and ext2_free_inode() (which is where the EXT2-fs error is coming from.
If it were another inode, you would have gotten an invalid inode error
from ext2_update_inode() instead.  In any case, ext2_free_inode() exits
without setting inode->i_state = I_CLEAR, hence the BUG in inode.c.

One way to fix this is to set inode->i_state = I_CLEAR before jumping to
error_return in ext2_free_inode().  It _may_ also be possible to call
clear_inode() from within the error path, expecially since ext2 doesn't
have a clear_inode method.  In any case, something has to be done, because
we can't just get a BUG whenever we try to free an invalid inode number.

Below is a patch which should fix this.  It _should_ prevent you from
mounting this filesystem in the first place, and should also stop the BUG
in inode.c.  I'm not 100% sure of correctness, however:
- is calling clear_inode() in these error cases OK?
- is calling dput() the right thing to do for the root dentry?  This
  is what kill_super() does when cleaning up the filesystem.

Cheers, Andreas
============================================================================
--- fs/ext2/ialloc.c.orig	Tue Jan 23 17:22:19 2001
+++ fs/ext2/ialloc.c	Wed Jan 31 12:14:04 2001
@@ -202,15 +202,18 @@
 	if (ino < EXT2_FIRST_INO(sb) || 
 	    ino > le32_to_cpu(es->s_inodes_count)) {
 		ext2_error (sb, "free_inode",
-			    "reserved inode or nonexistent inode");
+			    "reserved inode or nonexistent inode %d", ino);
+		clear_inode(inode);
 		goto error_return;
 	}
 	block_group = (ino - 1) / EXT2_INODES_PER_GROUP(sb);
 	bit = (ino - 1) % EXT2_INODES_PER_GROUP(sb);
 	bitmap_nr = load_inode_bitmap (sb, block_group);
-	if (bitmap_nr < 0)
+	if (bitmap_nr < 0) {
+		clear_inode(inode);
 		goto error_return;
-	
+	}
+
 	bh = sb->u.ext2_sb.s_inode_bitmap[bitmap_nr];
 
 	is_directory = S_ISDIR(inode->i_mode);
--- fs/ext2/super.c.orig	Tue Jan 23 17:24:45 2001
+++ fs/ext2/super.c	Wed Jan 31 12:27:25 2001
@@ -628,13 +628,19 @@
 	 */
 	sb->s_op = &ext2_sops;
 	sb->s_root = d_alloc_root(iget(sb, EXT2_ROOT_INO));
-	if (!sb->s_root) {
+	if (!sb->s_root || !S_ISDIR(sb->s_root->d_inode) ||
+	    !sb->s_root->d_inode->i_blocks || !sb->s_root->d_inode->i_size) {
+		if (sb->s_root) {
+			dput(sb->s_root);
+			sb->s_root = NULL;
+			printk ("EXT2-fs: corrupt root inode, run e2fsck\n");
+		} else
+			printk ("EXT2-fs: get root inode failed\n");
 		for (i = 0; i < db_count; i++)
 			if (sb->u.ext2_sb.s_group_desc[i])
 				brelse (sb->u.ext2_sb.s_group_desc[i]);
 		kfree(sb->u.ext2_sb.s_group_desc);
 		brelse (bh);
-		printk ("EXT2-fs: get root inode failed\n");
 		return NULL;
 	}
 	ext2_setup_super (sb, es, sb->s_flags & MS_RDONLY);
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
