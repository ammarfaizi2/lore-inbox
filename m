Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136240AbRD0WLP>; Fri, 27 Apr 2001 18:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136243AbRD0WLF>; Fri, 27 Apr 2001 18:11:05 -0400
Received: from [63.231.122.81] ([63.231.122.81]:24147 "EHLO lynx.turbolabs.com")
	by vger.kernel.org with ESMTP id <S136240AbRD0WK4>;
	Fri, 27 Apr 2001 18:10:56 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200104272207.QAA06020@lynx.turbolabs.com>
Subject: Re: [patch] linux likes to kill bad inodes
To: pavel@suse.cz (Pavel Machek)
Date: Fri, 27 Apr 2001 16:07:56 -0600 (MDT)
Cc: mason@suse.com (Chris Mason), viro@math.psu.edu,
        linux-kernel@vger.kernel.org (kernel list),
        jack@atrey.karlin.mff.cuni.cz, torvalds@transmeta.com
In-Reply-To: <20010427002853.A11426@bug.ucw.cz> from "Pavel Machek" at Apr 27, 2001 12:28:54 AM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel writes:
> [I'd really like to get patch it; killing user's data without good
> reason seems evil to me, and this did quite a lot of damage to my
> $HOME.]
> 
> 								Pavel
> PS: Only filesystem at use at time of problem was ext2, and it was
> ext2 iinode that got killed.

However, since make_bad_inode() only changes the file methods and not
the superblock, any of the put_inode(), delete_inode(), or write_inode()
methods can still be called.  While the write_inode() call is safe to
block in the VFS, I don't think it is safe to block *_put_inode() and
*_delete_inode() in the VFS because the filesystem may have allocated
memory or other things that need to be undone even for bad inodes.

The following patch fixes the VFS write_inode() (per Pavel's patch),
and ext2_put_inode(), bfs_delete_inode(), and udf_put_inode() to not
do anything with bad inodes.  I have bailed (with a FIXME) on
hpfs_delete_inode() and smb_delete_inode(), because I don't know what
(if anything) needs to be done to correctly clean up a bad inode.

I will post a patch separately which handles a couple of cases where
*_delete_inode() does not call clear_inode() in all cases.

Cheers, Andreas
=======================================================================
diff -ru linux-2.4.4p1.orig/fs/inode.c linux/fs/inode.c
--- linux-2.4.4p1.orig/fs/inode.c	Tue Apr 10 16:44:49 2001
+++ linux/fs/inode.c	Fri Apr 27 13:05:04 2001
@@ -179,6 +181,12 @@
 
 static inline void write_inode(struct inode *inode, int sync)
 {
+	if (is_bad_inode(inode)) {
+		printk(KERN_CRIT "Cowardly refusing to write bad inode %s:%d\n",+		       kdevname(inode->i_dev), inode->i_ino);
+		return;
+	}
+
 	if (inode->i_sb && inode->i_sb->s_op && inode->i_sb->s_op->write_inode)
 		inode->i_sb->s_op->write_inode(inode, sync);
 }
diff -ru linux-2.4.4p1.orig/fs/ext2/inode.c linux/fs/ext2/inode.c
--- linux-2.4.4p1.orig/fs/ext2/inode.c	Tue Apr 10 16:44:49 2001
+++ linux/fs/ext2/inode.c	Fri Apr 27 13:51:15 2001
@@ -36,6 +36,9 @@
  */
 void ext2_put_inode (struct inode * inode)
 {
+	if (is_bad_inode(inode))
+		return;
+
 	ext2_discard_prealloc (inode);
 }
 
diff -ru linux-2.4.4p1.orig/fs/bfs/inode.c linux/fs/bfs/inode.c
--- linux-2.4.4p1.orig/fs/bfs/inode.c	Tue Apr 10 16:44:49 2001
+++ linux/fs/bfs/inode.c	Fri Apr 27 15:45:31 2001
@@ -142,7 +142,8 @@
 
 	dprintf("ino=%08lx\n", inode->i_ino);
 
-	if (inode->i_ino < BFS_ROOT_INO || inode->i_ino > inode->i_sb->su_lasti) {
+	if (is_bad_inode(inode) || inode->i_ino < BFS_ROOT_INO ||
+	    inode->i_ino > inode->i_sb->su_lasti) {
 		printf("invalid ino=%08lx\n", inode->i_ino);
 		return;
 	}
diff -ru linux-2.4.4p1.orig/fs/udf/inode.c linux/fs/udf/inode.c
--- linux-2.4.4p1.orig/fs/udf/inode.c	Tue Apr 10 16:41:51 2001
+++ linux/fs/udf/inode.c	Fri Apr 27 14:03:49 2001
@@ -74,7 +74,7 @@
  */
 void udf_put_inode(struct inode * inode)
 {
-	if (!(inode->i_sb->s_flags & MS_RDONLY))
+	if (!(inode->i_sb->s_flags & MS_RDONLY) && !is_bad_inode(inode))
 	{
 		lock_kernel();
 		udf_discard_prealloc(inode);
diff -ru linux-2.4.4p1.orig/fs/hpfs/inode.c linux/fs/hpfs/inode.c
--- linux-2.4.4p1.orig/fs/hpfs/inode.c	Tue Apr 10 16:41:50 2001
+++ linux/fs/hpfs/inode.c	Fri Apr 27 13:57:12 2001
@@ -316,6 +304,7 @@
 
 void hpfs_delete_inode(struct inode *inode)
 {
+	/* FIXME: handle is_bad_inode??? */
 	lock_kernel();
 	hpfs_remove_fnode(inode->i_sb, inode->i_ino);
 	unlock_kernel();
diff -ru linux-2.4.4p1.orig/fs/smbfs/inode.c linux/fs/smbfs/inode.c
--- linux-2.4.4p1.orig/fs/smbfs/inode.c	Tue Apr 10 16:44:54 2001
+++ linux/fs/smbfs/inode.c	Fri Apr 27 14:01:33 2001
@@ -254,6 +254,7 @@
 smb_delete_inode(struct inode *ino)
 {
 	DEBUG1("ino=%ld\n", ino->i_ino);
+	/* FIXME: handle is_bad_inode() case??? */
 	lock_kernel();
 	if (smb_close(ino))
 		PARANOIA("could not close inode %ld\n", ino->i_ino);
-- 
Andreas Dilger                               TurboLabs filesystem development
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/
