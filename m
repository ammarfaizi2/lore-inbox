Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbUB1THE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 14:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbUB1THE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 14:07:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35486 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261903AbUB1TGv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 14:06:51 -0500
Date: Sat, 28 Feb 2004 19:06:49 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Maurice van der Stee <stee@planet.nl>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.4-rc1 oops on HPFS filesystem file rename
Message-ID: <20040228190649.GF16357@parcelfarce.linux.theplanet.co.uk>
References: <20040228171259.GA587@maurice.stee.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040228171259.GA587@maurice.stee.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 28, 2004 at 06:12:59PM +0100, Maurice van der Stee wrote:
> Thanks, looks like it fixes my problem.

BTW, while we are at it, patch below kills the hpfs_lock_{2,3}inodes()
monstrosities completely.  We can always use parents-first ordering
on the inodes, since these guys would only see contention with plain
hpfs_lock_inode() and never with each other (all inodes involved already
had semaphores held by callers in VFS).

See if that patch (on top of the previous one) works for you...

diff -urN RC4-rc1-hpfs1/fs/hpfs/buffer.c RC4-rc1-current/fs/hpfs/buffer.c
--- RC4-rc1-hpfs1/fs/hpfs/buffer.c	Sat Feb 28 13:55:26 2004
+++ RC4-rc1-current/fs/hpfs/buffer.c	Sat Feb 28 12:40:52 2004
@@ -60,74 +60,6 @@
 	}
 }
 
-void hpfs_lock_2inodes(struct inode *i1, struct inode *i2)
-{
-	if (!i2 || i1 == i2) {
-		hpfs_lock_inode(i1);
-	} else if (!i1) {
-		hpfs_lock_inode(i2);
-	} else {
-		struct hpfs_inode_info *hpfs_i1 = hpfs_i(i1);
-		struct hpfs_inode_info *hpfs_i2 = hpfs_i(i2);
-		if (i1->i_ino < i2->i_ino) {
-			down(&hpfs_i1->i_sem);
-			down(&hpfs_i2->i_sem);
-		} else {
-			down(&hpfs_i2->i_sem);
-			down(&hpfs_i1->i_sem);
-		}
-	}
-}
-
-void hpfs_unlock_2inodes(struct inode *i1, struct inode *i2)
-{
-	/* order of up() doesn't matter here */
-	hpfs_unlock_inode(i1);
-	hpfs_unlock_inode(i2);
-}
-
-void hpfs_lock_3inodes(struct inode *i1, struct inode *i2, struct inode *i3)
-{
-	if (!i1) { hpfs_lock_2inodes(i2, i3); return; }
-	if (!i2) { hpfs_lock_2inodes(i1, i3); return; }
-	if (!i3) { hpfs_lock_2inodes(i1, i2); return; }
-	if (i1->i_ino < i2->i_ino && i1->i_ino < i3->i_ino) {
-		struct hpfs_inode_info *hpfs_i1 = hpfs_i(i1);
-		down(&hpfs_i1->i_sem);
-		hpfs_lock_2inodes(i2, i3);
-	} else if (i2->i_ino < i1->i_ino && i2->i_ino < i3->i_ino) {
-		struct hpfs_inode_info *hpfs_i2 = hpfs_i(i2);
-		down(&hpfs_i2->i_sem);
-		hpfs_lock_2inodes(i1, i3);
-	} else if (i3->i_ino < i1->i_ino && i3->i_ino < i2->i_ino) {
-		struct hpfs_inode_info *hpfs_i3 = hpfs_i(i3);
-		down(&hpfs_i3->i_sem);
-		hpfs_lock_2inodes(i1, i2);
-	} else if (i1->i_ino != i2->i_ino) hpfs_lock_2inodes(i1, i2);
-	else hpfs_lock_2inodes(i1, i3);
-}
-		
-void hpfs_unlock_3inodes(struct inode *i1, struct inode *i2, struct inode *i3)
-{
-	if (!i1) { hpfs_unlock_2inodes(i2, i3); return; }
-	if (!i2) { hpfs_unlock_2inodes(i1, i3); return; }
-	if (!i3) { hpfs_unlock_2inodes(i1, i2); return; }
-	if (i1->i_ino < i2->i_ino && i1->i_ino < i3->i_ino) {
-		struct hpfs_inode_info *hpfs_i1 = hpfs_i(i1);
-		hpfs_unlock_2inodes(i2, i3);
-		up(&hpfs_i1->i_sem);
-	} else if (i2->i_ino < i1->i_ino && i2->i_ino < i3->i_ino) {
-		struct hpfs_inode_info *hpfs_i2 = hpfs_i(i2);
-		hpfs_unlock_2inodes(i1, i3);
-		up(&hpfs_i2->i_sem);
-	} else if (i3->i_ino < i1->i_ino && i3->i_ino < i2->i_ino) {
-		struct hpfs_inode_info *hpfs_i3 = hpfs_i(i3);
-		hpfs_unlock_2inodes(i1, i2);
-		up(&hpfs_i3->i_sem);
-	} else if (i1->i_ino != i2->i_ino) hpfs_unlock_2inodes(i1, i2);
-	else hpfs_unlock_2inodes(i1, i3);
-}
-
 /* Map a sector into a buffer and return pointers to it and to the buffer. */
 
 void *hpfs_map_sector(struct super_block *s, unsigned secno, struct buffer_head **bhp,
diff -urN RC4-rc1-hpfs1/fs/hpfs/hpfs_fn.h RC4-rc1-current/fs/hpfs/hpfs_fn.h
--- RC4-rc1-hpfs1/fs/hpfs/hpfs_fn.h	Thu Oct  9 17:34:47 2003
+++ RC4-rc1-current/fs/hpfs/hpfs_fn.h	Sat Feb 28 12:40:06 2004
@@ -196,10 +196,6 @@
 void hpfs_unlock_iget(struct super_block *);
 void hpfs_lock_inode(struct inode *);
 void hpfs_unlock_inode(struct inode *);
-void hpfs_lock_2inodes(struct inode *, struct inode *);
-void hpfs_unlock_2inodes(struct inode *, struct inode *);
-void hpfs_lock_3inodes(struct inode *, struct inode *, struct inode *);
-void hpfs_unlock_3inodes(struct inode *, struct inode *, struct inode *);
 void *hpfs_map_sector(struct super_block *, unsigned, struct buffer_head **, int);
 void *hpfs_get_sector(struct super_block *, unsigned, struct buffer_head **);
 void *hpfs_map_4sectors(struct super_block *, unsigned, struct quad_buffer_head *, int);
diff -urN RC4-rc1-hpfs1/fs/hpfs/namei.c RC4-rc1-current/fs/hpfs/namei.c
--- RC4-rc1-hpfs1/fs/hpfs/namei.c	Sat Sep 27 22:04:56 2003
+++ RC4-rc1-current/fs/hpfs/namei.c	Sat Feb 28 13:57:52 2004
@@ -340,39 +340,41 @@
 	fnode_secno fno;
 	int r;
 	int rep = 0;
+	int err;
 
 	lock_kernel();
 	hpfs_adjust_length((char *)name, &len);
 again:
-	hpfs_lock_2inodes(dir, inode);
-	if (!(de = map_dirent(dir, hpfs_i(dir)->i_dno, (char *)name, len, &dno, &qbh))) {
-		hpfs_unlock_2inodes(dir, inode);
-		unlock_kernel();
-		return -ENOENT;
-	}
-	if (de->first) {
-		hpfs_brelse4(&qbh);
-		hpfs_unlock_2inodes(dir, inode);
-		unlock_kernel();
-		return -EPERM;
-	}
-	if (de->directory) {
-		hpfs_brelse4(&qbh);
-		hpfs_unlock_2inodes(dir, inode);
-		unlock_kernel();
-		return -EISDIR;
-	}
+	hpfs_lock_inode(dir);
+	hpfs_lock_inode(inode);
+	de = map_dirent(dir, hpfs_i(dir)->i_dno, (char *)name, len, &dno, &qbh);
+	err = -ENOENT;
+	if (!de)
+		goto out;
+
+	err = -EPERM;
+	if (de->first)
+		goto out1;
+
+	err = -EISDIR;
+	if (de->directory)
+		goto out1;
+
 	fno = de->fnode;
-	if ((r = hpfs_remove_dirent(dir, dno, de, &qbh, 1)) == 1) hpfs_error(dir->i_sb, "there was error when removing dirent");
-	if (r != 2) {
-		inode->i_nlink--;
-		hpfs_unlock_2inodes(dir, inode);
-	} else {	/* no space for deleting, try to truncate file */
-		struct iattr newattrs;
-		int err;
-		hpfs_unlock_2inodes(dir, inode);
-		if (rep)
-			goto ret;
+	r = hpfs_remove_dirent(dir, dno, de, &qbh, 1);
+	switch (r) {
+	case 1:
+		hpfs_error(dir->i_sb, "there was error when removing dirent");
+		err = -EFSERROR;
+		break;
+	case 2:		/* no space for deleting, try to truncate file */
+
+		err = -ENOSPC;
+		if (rep++)
+			break;
+
+		hpfs_unlock_inode(inode);
+		hpfs_unlock_inode(dir);
 		d_drop(dentry);
 		spin_lock(&dentry->d_lock);
 		if (atomic_read(&dentry->d_count) > 1 ||
@@ -381,22 +383,32 @@
 		    get_write_access(inode)) {
 			spin_unlock(&dentry->d_lock);
 			d_rehash(dentry);
-			goto ret;
+		} else {
+			struct iattr newattrs;
+			spin_unlock(&dentry->d_lock);
+			/*printk("HPFS: truncating file before delete.\n");*/
+			newattrs.ia_size = 0;
+			newattrs.ia_valid = ATTR_SIZE | ATTR_CTIME;
+			err = notify_change(dentry, &newattrs);
+			put_write_access(inode);
+			if (!err)
+				goto again;
 		}
-		spin_unlock(&dentry->d_lock);
-		/*printk("HPFS: truncating file before delete.\n");*/
-		newattrs.ia_size = 0;
-		newattrs.ia_valid = ATTR_SIZE | ATTR_CTIME;
-		err = notify_change(dentry, &newattrs);
-		put_write_access(inode);
-		if (err)
-			goto ret;
-		rep = 1;
-		goto again;
+		unlock_kernel();
+		return -ENOSPC;
+	default:
+		inode->i_nlink--;
+		err = 0;
 	}
-ret:
+	goto out;
+
+out1:
+	hpfs_brelse4(&qbh);
+out:
+	hpfs_unlock_inode(inode);
+	hpfs_unlock_inode(dir);
 	unlock_kernel();
-	return r == 2 ? -ENOSPC : r == 1 ? -EFSERROR : 0;
+	return err;
 }
 
 int hpfs_rmdir(struct inode *dir, struct dentry *dentry)
@@ -409,44 +421,54 @@
 	dnode_secno dno;
 	fnode_secno fno;
 	int n_items = 0;
+	int err;
 	int r;
+
 	hpfs_adjust_length((char *)name, &len);
 	lock_kernel();
-	hpfs_lock_2inodes(dir, inode);
-	if (!(de = map_dirent(dir, hpfs_i(dir)->i_dno, (char *)name, len, &dno, &qbh))) {
-		hpfs_unlock_2inodes(dir, inode);
-		unlock_kernel();
-		return -ENOENT;
-	}	
-	if (de->first) {
-		hpfs_brelse4(&qbh);
-		hpfs_unlock_2inodes(dir, inode);
-		unlock_kernel();
-		return -EPERM;
-	}
-	if (!de->directory) {
-		hpfs_brelse4(&qbh);
-		hpfs_unlock_2inodes(dir, inode);
-		unlock_kernel();
-		return -ENOTDIR;
-	}
+	hpfs_lock_inode(dir);
+	hpfs_lock_inode(inode);
+	err = -ENOENT;
+	de = map_dirent(dir, hpfs_i(dir)->i_dno, (char *)name, len, &dno, &qbh);
+	if (!de)
+		goto out;
+
+	err = -EPERM;
+	if (de->first)
+		goto out1;
+
+	err = -ENOTDIR;
+	if (!de->directory)
+		goto out1;
+
 	hpfs_count_dnodes(dir->i_sb, hpfs_i(inode)->i_dno, NULL, NULL, &n_items);
-	if (n_items) {
-		hpfs_brelse4(&qbh);
-		hpfs_unlock_2inodes(dir, inode);
-		unlock_kernel();
-		return -ENOTEMPTY;
-	}
+	err = -ENOTEMPTY;
+	if (n_items)
+		goto out1;
+
 	fno = de->fnode;
-	if ((r = hpfs_remove_dirent(dir, dno, de, &qbh, 1)) == 1)
+	r = hpfs_remove_dirent(dir, dno, de, &qbh, 1);
+	switch (r) {
+	case 1:
 		hpfs_error(dir->i_sb, "there was error when removing dirent");
-	if (r != 2) {
+		err = -EFSERROR;
+		break;
+	case 2:
+		err = -ENOSPC;
+		break;
+	default:
 		dir->i_nlink--;
 		inode->i_nlink = 0;
-		hpfs_unlock_2inodes(dir, inode);
-	} else hpfs_unlock_2inodes(dir, inode);
+		err = 0;
+	}
+	goto out;
+out1:
+	hpfs_brelse4(&qbh);
+out:
+	hpfs_unlock_inode(inode);
+	hpfs_unlock_inode(dir);
 	unlock_kernel();
-	return r == 2 ? -ENOSPC : r == 1 ? -EFSERROR : 0;
+	return err;
 }
 
 int hpfs_symlink_readpage(struct file *file, struct page *page)
@@ -501,7 +523,10 @@
 	hpfs_adjust_length((char *)old_name, &old_len);
 
 	lock_kernel();
-	hpfs_lock_3inodes(old_dir, new_dir, i);
+	hpfs_lock_inode(old_dir);
+	if (new_dir != old_dir)
+		hpfs_lock_inode(new_dir);
+	hpfs_lock_inode(i);
 	
 	/* Erm? Moving over the empty non-busy directory is perfectly legal */
 	if (new_inode && S_ISDIR(new_inode->i_mode)) {
@@ -580,7 +605,10 @@
 	hpfs_i(i)->i_conv = hpfs_sb(i->i_sb)->sb_conv;
 	hpfs_decide_conv(i, (char *)new_name, new_len);
 	end1:
-	hpfs_unlock_3inodes(old_dir, new_dir, i);
+	hpfs_unlock_inode(i);
+	if (old_dir != new_dir)
+		hpfs_unlock_inode(new_dir);
+	hpfs_unlock_inode(old_dir);
 	unlock_kernel();
 	return err;
 }
