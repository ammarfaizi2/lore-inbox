Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129270AbRB1UaT>; Wed, 28 Feb 2001 15:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129271AbRB1UaK>; Wed, 28 Feb 2001 15:30:10 -0500
Received: from zeus.kernel.org ([209.10.41.242]:39127 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129270AbRB1U36>;
	Wed, 28 Feb 2001 15:29:58 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200102281714.f1SHEAO12060@webber.adilger.net>
Subject: Re: PROBLEM: Kernel bug in inode.c:885 when floppy disk removed
In-Reply-To: <3A9D2953.D4681F43@colorfullife.com> from Manfred Spraul at "Feb
 28, 2001 05:37:39 pm"
To: Manfred Spraul <manfred@colorfullife.com>
Date: Wed, 28 Feb 2001 10:14:10 -0700 (MST)
CC: viro@math.psu.edu, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul writes:
> Alexander Viro wrote:
> > 
> > - Doctor, it hurts when I do it! 
> > - Don't do it, then. 
> >
> Interesting bugfix:
> have you checked which BUG was triggered?
> 
> It's a bug in ext2_free_inode(): 
> if a io error occurs, then clear_inode() is not called, but
> super_operation.delete_inode() must call clear_inode() before returning.

Here is a patch I sent to Alan and Linus to fix this exact problem last
week.

Cheers, Andreas
==========================================================================

> The below patch adds some extra sanity checks to the root inode when
> mounting an ext2 filesystem.  This came about when someone mounted
> a corrupted ext2/RAID partition and subsequently got a kernel BUG
> (see http://marc.theaimsgroup.com/?l=linux-kernel&m=98097024832479&w=4).

> Basically, the first chunk (super.c) checks that the root inode is a
> directory, and has blocks and a size.  This would have prevented the
> corrupt filesystem from being mounted in the first place.

> However, the problem that actually caused the BUG is fixed in the
> second chunk (ialloc.c).  The BUG was triggered because ext2_free_inode()
> returned without clearing (and setting I_CLEAR) for the inode, hence
> BUG in inode.c:884.  We always call clear_inode() now, regardless of
> any other error conditions.

> Cheers, Andreas
===========================================================================
diff -ru linux-2.4.2p4/fs/ext2/super.c linux-2.4.2p4-aed/fs/ext2/super.c
--- linux-2.4.2p4/fs/ext2/super.c	Fri Dec 29 15:36:44 2000
+++ linux-2.4.2p4-aed/fs/ext2/super.c	Thu Feb 22 11:13:49 2001
@@ -628,13 +625,19 @@
 	 */
 	sb->s_op = &ext2_sops;
 	sb->s_root = d_alloc_root(iget(sb, EXT2_ROOT_INO));
-	if (!sb->s_root) {
+	if (!sb->s_root || !S_ISDIR(sb->s_root->d_inode->i_mode) ||
+	    !sb->s_root->d_inode->i_blocks || !sb->s_root->d_inode->i_size) {
+		if (sb->s_root) {
+			dput(sb->s_root);
+			sb->s_root = NULL;
+			printk("EXT2-fs: corrupt root inode, run e2fsck\n");
+		} else
+			printk("EXT2-fs: get root inode failed\n");
 		for (i = 0; i < db_count; i++)
 			if (sb->u.ext2_sb.s_group_desc[i])
 				brelse (sb->u.ext2_sb.s_group_desc[i]);
 		kfree(sb->u.ext2_sb.s_group_desc);
 		brelse (bh);
-		printk ("EXT2-fs: get root inode failed\n");
 		return NULL;
 	}
 	ext2_setup_super (sb, es, sb->s_flags & MS_RDONLY);
diff -ru linux-2.4.2p4/fs/ext2/ialloc.c linux-2.4.2p4-aed/fs/ext2/ialloc.c
--- linux-2.4.2p4/fs/ext2/ialloc.c	Fri Dec  8 18:35:54 2000
+++ linux-2.4.2p4-aed/fs/ext2/ialloc.c	Thu Feb 22 11:59:19 2001
@@ -199,10 +199,15 @@
 
 	lock_super (sb);
 	es = sb->u.ext2_sb.s_es;
+	is_directory = S_ISDIR(inode->i_mode);
+
+	/* Do this BEFORE marking the inode not in use */
+	clear_inode(inode);
+
 	if (ino < EXT2_FIRST_INO(sb) || 
 	    ino > le32_to_cpu(es->s_inodes_count)) {
-		ext2_error (sb, "free_inode",
-			    "reserved inode or nonexistent inode");
+		ext2_error (sb, __FUNCTION__,
+			    "reserved or nonexistent inode %ld", ino);
 		goto error_return;
 	}
 	block_group = (ino - 1) / EXT2_INODES_PER_GROUP(sb);
@@ -210,13 +215,8 @@
 	bitmap_nr = load_inode_bitmap (sb, block_group);
 	if (bitmap_nr < 0)
 		goto error_return;
-	
+
 	bh = sb->u.ext2_sb.s_inode_bitmap[bitmap_nr];
-
-	is_directory = S_ISDIR(inode->i_mode);
-
-	/* Do this BEFORE marking the inode not in use */
-	clear_inode (inode);
 
 	/* Ok, now we can actually update the inode bitmaps.. */
 	if (!ext2_clear_bit (bit, bh->b_data))
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
