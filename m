Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136254AbRD0XeB>; Fri, 27 Apr 2001 19:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132568AbRD0Xdx>; Fri, 27 Apr 2001 19:33:53 -0400
Received: from [63.231.122.81] ([63.231.122.81]:46679 "EHLO lynx.turbolabs.com")
	by vger.kernel.org with ESMTP id <S136253AbRD0Xdg>;
	Fri, 27 Apr 2001 19:33:36 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200104272330.RAA06373@lynx.turbolabs.com>
Subject: Re: [patch] linux likes to kill bad inodes
To: torvalds@transmeta.com
Date: Fri, 27 Apr 2001 17:30:28 -0600 (MDT)
Cc: pavel@suse.cz (Pavel Machek), mason@suse.com (Chris Mason),
        viro@math.psu.edu, linux-kernel@vger.kernel.org (kernel list),
        jack@atrey.karlin.mff.cuni.cz
In-Reply-To: <no.id> from "adilger" at Apr 27, 2001 04:08:01 PM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I previously wrote:
> I will post a patch separately which handles a couple of cases where
> *_delete_inode() does not call clear_inode() in all cases.

OK, here it is.  The ext2_delete_inode() change isn't exactly a bug fix,
but rather a "performance" change.  No need to hold BLK to check status
or call clear_inode() (we call clear_inode() outside BLK in VFS if
delete_inode() method does not exist).

Cheers, Andreas
=======================================================================
diff -ru linux-2.4.4p1.orig/fs/ext2/inode.c linux/fs/ext2/inode.c
--- linux-2.4.4p1.orig/fs/ext2/inode.c	Tue Apr 10 16:44:49 2001
+++ linux/fs/ext2/inode.c	Fri Apr 27 13:51:15 2001
@@ -44,12 +47,12 @@
  */
 void ext2_delete_inode (struct inode * inode)
 {
-	lock_kernel();
-
 	if (is_bad_inode(inode) ||
 	    inode->i_ino == EXT2_ACL_IDX_INO ||
 	    inode->i_ino == EXT2_ACL_DATA_INO)
 		goto no_delete;
+
+	lock_kernel();
 	inode->u.ext2_i.i_dtime	= CURRENT_TIME;
 	mark_inode_dirty(inode);
 	ext2_update_inode(inode, IS_SYNC(inode));
@@ -59,9 +62,7 @@
 	ext2_free_inode (inode);
 
 	unlock_kernel();
 	return;
 no_delete:
-	unlock_kernel();
 	clear_inode(inode);	/* We must guarantee clearing of inode... */
 }
 
diff -ru linux-2.4.4p1.orig/fs/bfs/inode.c linux/fs/bfs/inode.c
--- linux-2.4.4p1.orig/fs/bfs/inode.c	Tue Apr 10 16:44:49 2001
+++ linux/fs/bfs/inode.c	Fri Apr 27 15:45:31 2001
@@ -145,7 +145,7 @@
 	if (is_bad_inode(inode) || inode->i_ino < BFS_ROOT_INO ||
 	    inode->i_ino > inode->i_sb->su_lasti) {
 		printf("invalid ino=%08lx\n", inode->i_ino);
-		return;
+		goto bad_inode;
 	}
 	
 	inode->i_size = 0;
@@ -155,8 +156,7 @@
 	bh = bread(dev, block, BFS_BSIZE);
 	if (!bh) {
 		printf("Unable to read inode %s:%08lx\n", bdevname(dev), ino);
-		unlock_kernel();
-		return;
+		goto bad_unlock;
 	}
 	off = (ino - BFS_ROOT_INO)%BFS_INODES_PER_BLOCK;
 	di = (struct bfs_inode *)bh->b_data + off;
@@ -178,7 +178,9 @@
 		s->su_lf_eblk = inode->iu_sblock - 1;
 		mark_buffer_dirty(s->su_sbh);
 	}
+bad_unlock:
 	unlock_kernel();
+bad_inode:
 	clear_inode(inode);
 }
 
diff -ru linux-2.4.4p1.orig/fs/ufs/ialloc.c linux/fs/ufs/ialloc.c
--- linux-2.4.4p1.orig/fs/ufs/ialloc.c	Thu Nov 16 14:18:26 2000
+++ linux/fs/ufs/ialloc.c	Fri Apr 27 15:53:26 2001
@@ -82,6 +82,7 @@
 	if (!((ino > 1) && (ino < (uspi->s_ncg * uspi->s_ipg )))) {
 		ufs_warning(sb, "ufs_free_inode", "reserved inode or nonexistent inode %u\n", ino);
 		unlock_super (sb);
+		clear_inode (inode);
 		return;
 	}
 	
@@ -90,6 +91,7 @@
 	ucpi = ufs_load_cylinder (sb, cg);
 	if (!ucpi) {
 		unlock_super (sb);
+		clear_inode (inode);
 		return;
 	}
 	ucg = ubh_get_ucg(UCPI_UBH);
-- 
Andreas Dilger                               TurboLabs filesystem development
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/
