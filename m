Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbWGLS0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWGLS0m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 14:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWGLS0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 14:26:42 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:33695 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932324AbWGLSRR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 14:17:17 -0400
Subject: [RFC][PATCH 03/27] unlink: monitor i_nlink
To: viro@ftp.linux.org.uk
Cc: serue@us.ibm.com, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 12 Jul 2006 11:17:12 -0700
References: <20060712181709.5C1A4353@localhost.localdomain>
In-Reply-To: <20060712181709.5C1A4353@localhost.localdomain>
Message-Id: <20060712181712.EAFB1588@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When a filesystem decrements i_nlink to zero, it means that a
write must be performed in order to drop the inode from the
filesystem.

We're shortly going to have keep filesystems from being remounted
r/o between the time that this i_nlink decrement and that write
occurs.  

So, add a little helper function to do the decrements.  We'll
tie into it in a bit to note when i_nlink hits zero.  Should
we also be checking all of the places where i_nlink is explicitly
set to 0 in the unlink paths?

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/drivers/usb/core/inode.c |    4 ++--
 lxc-dave/fs/autofs/root.c         |    2 +-
 lxc-dave/fs/autofs4/root.c        |    2 +-
 lxc-dave/fs/bfs/dir.c             |    6 +++---
 lxc-dave/fs/cifs/inode.c          |   10 +++++-----
 lxc-dave/fs/coda/dir.c            |    4 ++--
 lxc-dave/fs/ext2/namei.c          |    2 +-
 lxc-dave/fs/ext3/namei.c          |   14 +++++++-------
 lxc-dave/fs/hfs/dir.c             |    2 +-
 lxc-dave/fs/hfsplus/dir.c         |    2 +-
 lxc-dave/fs/hpfs/namei.c          |    6 +++---
 lxc-dave/fs/jffs2/dir.c           |    6 +++---
 lxc-dave/fs/jfs/namei.c           |   12 ++++++------
 lxc-dave/fs/libfs.c               |   15 ++++++++++-----
 lxc-dave/fs/nfs/dir.c             |    6 +++---
 lxc-dave/fs/ocfs2/namei.c         |    4 ++--
 lxc-dave/fs/qnx4/namei.c          |    6 ++----
 lxc-dave/fs/reiserfs/namei.c      |    2 +-
 lxc-dave/fs/sysv/namei.c          |    2 +-
 lxc-dave/fs/udf/namei.c           |    6 +++---
 lxc-dave/fs/ufs/namei.c           |    2 +-
 lxc-dave/fs/vfat/namei.c          |    6 +++---
 lxc-dave/include/linux/fs.h       |    1 +
 lxc-dave/ipc/mqueue.c             |    2 +-
 lxc-dave/mm/shmem.c               |   10 +++++-----
 25 files changed, 69 insertions(+), 65 deletions(-)

diff -puN drivers/usb/core/inode.c~B-unlink-monitor-i_nlink-0 drivers/usb/core/inode.c
--- lxc/drivers/usb/core/inode.c~B-unlink-monitor-i_nlink-0	2006-07-12 11:09:16.000000000 -0700
+++ lxc-dave/drivers/usb/core/inode.c	2006-07-12 11:09:19.000000000 -0700
@@ -332,7 +332,7 @@ static int usbfs_unlink (struct inode *d
 {
 	struct inode *inode = dentry->d_inode;
 	mutex_lock(&inode->i_mutex);
-	dentry->d_inode->i_nlink--;
+	inode_drop_nlink(dentry->d_inode);
 	dput(dentry);
 	mutex_unlock(&inode->i_mutex);
 	d_delete(dentry);
@@ -350,7 +350,7 @@ static int usbfs_rmdir(struct inode *dir
 		dentry->d_inode->i_nlink -= 2;
 		dput(dentry);
 		inode->i_flags |= S_DEAD;
-		dir->i_nlink--;
+		inode_drop_nlink(dir);
 		error = 0;
 	}
 	mutex_unlock(&inode->i_mutex);
diff -puN fs/autofs/root.c~B-unlink-monitor-i_nlink-0 fs/autofs/root.c
--- lxc/fs/autofs/root.c~B-unlink-monitor-i_nlink-0	2006-07-12 11:09:16.000000000 -0700
+++ lxc-dave/fs/autofs/root.c	2006-07-12 11:09:19.000000000 -0700
@@ -414,7 +414,7 @@ static int autofs_root_rmdir(struct inod
 
 	dentry->d_time = (unsigned long)(struct autofs_dir_ent *)NULL;
 	autofs_hash_delete(ent);
-	dir->i_nlink--;
+	inode_drop_nlink(dir);
 	d_drop(dentry);
 	unlock_kernel();
 
diff -puN fs/autofs4/root.c~B-unlink-monitor-i_nlink-0 fs/autofs4/root.c
--- lxc/fs/autofs4/root.c~B-unlink-monitor-i_nlink-0	2006-07-12 11:09:16.000000000 -0700
+++ lxc-dave/fs/autofs4/root.c	2006-07-12 11:09:19.000000000 -0700
@@ -676,7 +676,7 @@ static int autofs4_dir_rmdir(struct inod
 	dentry->d_inode->i_nlink = 0;
 
 	if (dir->i_nlink)
-		dir->i_nlink--;
+		inode_drop_nlink(dir);
 
 	return 0;
 }
diff -puN fs/bfs/dir.c~B-unlink-monitor-i_nlink-0 fs/bfs/dir.c
--- lxc/fs/bfs/dir.c~B-unlink-monitor-i_nlink-0	2006-07-12 11:09:16.000000000 -0700
+++ lxc-dave/fs/bfs/dir.c	2006-07-12 11:09:19.000000000 -0700
@@ -117,7 +117,7 @@ static int bfs_create(struct inode * dir
 
 	err = bfs_add_entry(dir, dentry->d_name.name, dentry->d_name.len, inode->i_ino);
 	if (err) {
-		inode->i_nlink--;
+		inode_drop_nlink(inode);
 		mark_inode_dirty(inode);
 		iput(inode);
 		unlock_kernel();
@@ -196,7 +196,7 @@ static int bfs_unlink(struct inode * dir
 	mark_buffer_dirty(bh);
 	dir->i_ctime = dir->i_mtime = CURRENT_TIME_SEC;
 	mark_inode_dirty(dir);
-	inode->i_nlink--;
+	inode_drop_nlink(inode);
 	inode->i_ctime = dir->i_ctime;
 	mark_inode_dirty(inode);
 	error = 0;
@@ -249,7 +249,7 @@ static int bfs_rename(struct inode * old
 	old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME_SEC;
 	mark_inode_dirty(old_dir);
 	if (new_inode) {
-		new_inode->i_nlink--;
+		inode_drop_nlink(new_inode);
 		new_inode->i_ctime = CURRENT_TIME_SEC;
 		mark_inode_dirty(new_inode);
 	}
diff -puN fs/cifs/inode.c~B-unlink-monitor-i_nlink-0 fs/cifs/inode.c
--- lxc/fs/cifs/inode.c~B-unlink-monitor-i_nlink-0	2006-07-12 11:09:16.000000000 -0700
+++ lxc-dave/fs/cifs/inode.c	2006-07-12 11:09:19.000000000 -0700
@@ -591,7 +591,7 @@ int cifs_unlink(struct inode *inode, str
 
 	if (!rc) {
 		if (direntry->d_inode)
-			direntry->d_inode->i_nlink--;
+			inode_drop_nlink(direntry->d_inode);
 	} else if (rc == -ENOENT) {
 		d_drop(direntry);
 	} else if (rc == -ETXTBSY) {
@@ -610,7 +610,7 @@ int cifs_unlink(struct inode *inode, str
 						CIFS_MOUNT_MAP_SPECIAL_CHR);
 			CIFSSMBClose(xid, pTcon, netfid);
 			if (direntry->d_inode)
-				direntry->d_inode->i_nlink--;
+				inode_drop_nlink(direntry->d_inode);
 		}
 	} else if (rc == -EACCES) {
 		/* try only if r/o attribute set in local lookup data? */
@@ -664,7 +664,7 @@ int cifs_unlink(struct inode *inode, str
 						CIFS_MOUNT_MAP_SPECIAL_CHR);
 			if (!rc) {
 				if (direntry->d_inode)
-					direntry->d_inode->i_nlink--;
+					inode_drop_nlink(direntry->d_inode);
 			} else if (rc == -ETXTBSY) {
 				int oplock = FALSE;
 				__u16 netfid;
@@ -685,7 +685,7 @@ int cifs_unlink(struct inode *inode, str
 						    CIFS_MOUNT_MAP_SPECIAL_CHR);
 					CIFSSMBClose(xid, pTcon, netfid);
 					if (direntry->d_inode)
-			                        direntry->d_inode->i_nlink--;
+						inode_drop_nlink(direntry->d_inode);
 				}
 			/* BB if rc = -ETXTBUSY goto the rename logic BB */
 			}
@@ -817,7 +817,7 @@ int cifs_rmdir(struct inode *inode, stru
 			  cifs_sb->mnt_cifs_flags & CIFS_MOUNT_MAP_SPECIAL_CHR);
 
 	if (!rc) {
-		inode->i_nlink--;
+		inode_drop_nlink(inode);
 		i_size_write(direntry->d_inode,0);
 		direntry->d_inode->i_nlink = 0;
 	}
diff -puN fs/coda/dir.c~B-unlink-monitor-i_nlink-0 fs/coda/dir.c
--- lxc/fs/coda/dir.c~B-unlink-monitor-i_nlink-0	2006-07-12 11:09:16.000000000 -0700
+++ lxc-dave/fs/coda/dir.c	2006-07-12 11:09:19.000000000 -0700
@@ -367,7 +367,7 @@ int coda_unlink(struct inode *dir, struc
         }
 
 	coda_dir_changed(dir, 0);
-	de->d_inode->i_nlink--;
+	inode_drop_nlink(de->d_inode);
 	unlock_kernel();
 
         return 0;
@@ -394,7 +394,7 @@ int coda_rmdir(struct inode *dir, struct
         }
 
 	coda_dir_changed(dir, -1);
-	de->d_inode->i_nlink--;
+	inode_drop_nlink(de->d_inode);
 	d_delete(de);
 	unlock_kernel();
 
diff -puN fs/ext2/namei.c~B-unlink-monitor-i_nlink-0 fs/ext2/namei.c
--- lxc/fs/ext2/namei.c~B-unlink-monitor-i_nlink-0	2006-07-12 11:09:16.000000000 -0700
+++ lxc-dave/fs/ext2/namei.c	2006-07-12 11:09:19.000000000 -0700
@@ -326,7 +326,7 @@ static int ext2_rename (struct inode * o
 		ext2_set_link(new_dir, new_de, new_page, old_inode);
 		new_inode->i_ctime = CURRENT_TIME_SEC;
 		if (dir_de)
-			new_inode->i_nlink--;
+			inode_drop_nlink(new_inode);
 		inode_dec_link_count(new_inode);
 	} else {
 		if (dir_de) {
diff -puN fs/ext3/namei.c~B-unlink-monitor-i_nlink-0 fs/ext3/namei.c
--- lxc/fs/ext3/namei.c~B-unlink-monitor-i_nlink-0	2006-07-12 11:09:16.000000000 -0700
+++ lxc-dave/fs/ext3/namei.c	2006-07-12 11:09:19.000000000 -0700
@@ -1609,7 +1609,7 @@ static inline void ext3_inc_count(handle
 
 static inline void ext3_dec_count(handle_t *handle, struct inode *inode)
 {
-	inode->i_nlink--;
+	inode_drop_nlink(inode);
 }
 
 static int ext3_add_nondir(handle_t *handle,
@@ -1731,7 +1731,7 @@ retry:
 	inode->i_size = EXT3_I(inode)->i_disksize = inode->i_sb->s_blocksize;
 	dir_block = ext3_bread (handle, inode, 0, 1, &err);
 	if (!dir_block) {
-		inode->i_nlink--; /* is this nlink == 0? */
+		inode_drop_nlink(inode); /* is this nlink == 0? */
 		ext3_mark_inode_dirty(handle, inode);
 		iput (inode);
 		goto out_stop;
@@ -2041,7 +2041,7 @@ static int ext3_rmdir (struct inode * di
 	ext3_orphan_add(handle, inode);
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME_SEC;
 	ext3_mark_inode_dirty(handle, inode);
-	dir->i_nlink--;
+	inode_drop_nlink(dir);
 	ext3_update_dx_flag(dir);
 	ext3_mark_inode_dirty(handle, dir);
 
@@ -2092,7 +2092,7 @@ static int ext3_unlink(struct inode * di
 	dir->i_ctime = dir->i_mtime = CURRENT_TIME_SEC;
 	ext3_update_dx_flag(dir);
 	ext3_mark_inode_dirty(handle, dir);
-	inode->i_nlink--;
+	inode_drop_nlink(inode);
 	if (!inode->i_nlink)
 		ext3_orphan_add(handle, inode);
 	inode->i_ctime = dir->i_ctime;
@@ -2314,7 +2314,7 @@ static int ext3_rename (struct inode * o
 	}
 
 	if (new_inode) {
-		new_inode->i_nlink--;
+		inode_drop_nlink(new_inode);
 		new_inode->i_ctime = CURRENT_TIME_SEC;
 	}
 	old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME_SEC;
@@ -2325,9 +2325,9 @@ static int ext3_rename (struct inode * o
 		PARENT_INO(dir_bh->b_data) = cpu_to_le32(new_dir->i_ino);
 		BUFFER_TRACE(dir_bh, "call ext3_journal_dirty_metadata");
 		ext3_journal_dirty_metadata(handle, dir_bh);
-		old_dir->i_nlink--;
+		inode_drop_nlink(old_dir);
 		if (new_inode) {
-			new_inode->i_nlink--;
+			inode_drop_nlink(new_inode);
 		} else {
 			new_dir->i_nlink++;
 			ext3_update_dx_flag(new_dir);
diff -puN fs/hfs/dir.c~B-unlink-monitor-i_nlink-0 fs/hfs/dir.c
--- lxc/fs/hfs/dir.c~B-unlink-monitor-i_nlink-0	2006-07-12 11:09:16.000000000 -0700
+++ lxc-dave/fs/hfs/dir.c	2006-07-12 11:09:19.000000000 -0700
@@ -246,7 +246,7 @@ static int hfs_unlink(struct inode *dir,
 	if (res)
 		return res;
 
-	inode->i_nlink--;
+	inode_drop_nlink(inode);
 	hfs_delete_inode(inode);
 	inode->i_ctime = CURRENT_TIME_SEC;
 	mark_inode_dirty(inode);
diff -puN fs/hfsplus/dir.c~B-unlink-monitor-i_nlink-0 fs/hfsplus/dir.c
--- lxc/fs/hfsplus/dir.c~B-unlink-monitor-i_nlink-0	2006-07-12 11:09:16.000000000 -0700
+++ lxc-dave/fs/hfsplus/dir.c	2006-07-12 11:09:19.000000000 -0700
@@ -338,7 +338,7 @@ static int hfsplus_unlink(struct inode *
 		return res;
 
 	if (inode->i_nlink > 0)
-		inode->i_nlink--;
+		inode_drop_nlink(inode);
 	hfsplus_delete_inode(inode);
 	if (inode->i_ino != cnid && !inode->i_nlink) {
 		if (!atomic_read(&HFSPLUS_I(inode).opencnt)) {
diff -puN fs/hpfs/namei.c~B-unlink-monitor-i_nlink-0 fs/hpfs/namei.c
--- lxc/fs/hpfs/namei.c~B-unlink-monitor-i_nlink-0	2006-07-12 11:09:16.000000000 -0700
+++ lxc-dave/fs/hpfs/namei.c	2006-07-12 11:09:19.000000000 -0700
@@ -434,7 +434,7 @@ again:
 		unlock_kernel();
 		return -ENOSPC;
 	default:
-		inode->i_nlink--;
+		inode_drop_nlink(inode);
 		err = 0;
 	}
 	goto out;
@@ -494,7 +494,7 @@ static int hpfs_rmdir(struct inode *dir,
 		err = -ENOSPC;
 		break;
 	default:
-		dir->i_nlink--;
+		inode_drop_nlink(dir);
 		inode->i_nlink = 0;
 		err = 0;
 	}
@@ -636,7 +636,7 @@ static int hpfs_rename(struct inode *old
 	hpfs_i(i)->i_parent_dir = new_dir->i_ino;
 	if (S_ISDIR(i->i_mode)) {
 		new_dir->i_nlink++;
-		old_dir->i_nlink--;
+		inode_drop_nlink(old_dir);
 	}
 	if ((fnode = hpfs_map_fnode(i->i_sb, i->i_ino, &bh))) {
 		fnode->up = new_dir->i_ino;
diff -puN fs/jffs2/dir.c~B-unlink-monitor-i_nlink-0 fs/jffs2/dir.c
--- lxc/fs/jffs2/dir.c~B-unlink-monitor-i_nlink-0	2006-07-12 11:09:16.000000000 -0700
+++ lxc-dave/fs/jffs2/dir.c	2006-07-12 11:09:19.000000000 -0700
@@ -615,7 +615,7 @@ static int jffs2_rmdir (struct inode *di
 	}
 	ret = jffs2_unlink(dir_i, dentry);
 	if (!ret)
-		dir_i->i_nlink--;
+		inode_drop_nlink(dir_i);
 	return ret;
 }
 
@@ -823,7 +823,7 @@ static int jffs2_rename (struct inode *o
 
 	if (victim_f) {
 		/* There was a victim. Kill it off nicely */
-		new_dentry->d_inode->i_nlink--;
+		inode_drop_nlink(new_dentry->d_inode);
 		/* Don't oops if the victim was a dirent pointing to an
 		   inode which didn't exist. */
 		if (victim_f->inocache) {
@@ -862,7 +862,7 @@ static int jffs2_rename (struct inode *o
 	}
 
 	if (S_ISDIR(old_dentry->d_inode->i_mode))
-		old_dir_i->i_nlink--;
+		inode_drop_nlink(old_dir_i);
 
 	new_dir_i->i_mtime = new_dir_i->i_ctime = old_dir_i->i_mtime = old_dir_i->i_ctime = ITIME(now);
 
diff -puN fs/jfs/namei.c~B-unlink-monitor-i_nlink-0 fs/jfs/namei.c
--- lxc/fs/jfs/namei.c~B-unlink-monitor-i_nlink-0	2006-07-12 11:09:16.000000000 -0700
+++ lxc-dave/fs/jfs/namei.c	2006-07-12 11:09:19.000000000 -0700
@@ -393,7 +393,7 @@ static int jfs_rmdir(struct inode *dip, 
 	/* update parent directory's link count corresponding
 	 * to ".." entry of the target directory deleted
 	 */
-	dip->i_nlink--;
+	inode_drop_nlink(dip);
 	dip->i_ctime = dip->i_mtime = CURRENT_TIME;
 	mark_inode_dirty(dip);
 
@@ -515,7 +515,7 @@ static int jfs_unlink(struct inode *dip,
 	mark_inode_dirty(dip);
 
 	/* update target's inode */
-	ip->i_nlink--;
+	inode_drop_nlink(ip);
 	mark_inode_dirty(ip);
 
 	/*
@@ -835,7 +835,7 @@ static int jfs_link(struct dentry *old_d
 	rc = txCommit(tid, 2, &iplist[0], 0);
 
 	if (rc) {
-		ip->i_nlink--;
+		ip->i_nlink--; /* never instantiated */
 		iput(ip);
 	} else
 		d_instantiate(dentry, ip);
@@ -1155,9 +1155,9 @@ static int jfs_rename(struct inode *old_
 			      old_ip->i_ino, JFS_RENAME);
 		if (rc)
 			goto out4;
-		new_ip->i_nlink--;
+		inode_drop_nlink(new_ip);
 		if (S_ISDIR(new_ip->i_mode)) {
-			new_ip->i_nlink--;
+			inode_drop_nlink(new_ip);
 			if (new_ip->i_nlink) {
 				mutex_unlock(&JFS_IP(new_ip)->commit_mutex);
 				if (old_dir != new_dir)
@@ -1223,7 +1223,7 @@ static int jfs_rename(struct inode *old_
 		goto out4;
 	}
 	if (S_ISDIR(old_ip->i_mode)) {
-		old_dir->i_nlink--;
+		inode_drop_nlink(old_dir);
 		if (old_dir != new_dir) {
 			/*
 			 * Change inode number of parent for moved directory
diff -puN fs/libfs.c~B-unlink-monitor-i_nlink-0 fs/libfs.c
--- lxc/fs/libfs.c~B-unlink-monitor-i_nlink-0	2006-07-12 11:09:16.000000000 -0700
+++ lxc-dave/fs/libfs.c	2006-07-12 11:09:19.000000000 -0700
@@ -270,12 +270,17 @@ out:
 	return ret;
 }
 
+void inode_drop_nlink(struct inode *inode)
+{
+	inode->i_nlink--;
+}
+
 int simple_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = dentry->d_inode;
 
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
-	inode->i_nlink--;
+	inode_drop_nlink(inode);
 	dput(dentry);
 	return 0;
 }
@@ -285,9 +290,9 @@ int simple_rmdir(struct inode *dir, stru
 	if (!simple_empty(dentry))
 		return -ENOTEMPTY;
 
-	dentry->d_inode->i_nlink--;
+	inode_drop_nlink(dentry->d_inode);
 	simple_unlink(dir, dentry);
-	dir->i_nlink--;
+	inode_drop_nlink(dir);
 	return 0;
 }
 
@@ -303,9 +308,9 @@ int simple_rename(struct inode *old_dir,
 	if (new_dentry->d_inode) {
 		simple_unlink(new_dir, new_dentry);
 		if (they_are_dirs)
-			old_dir->i_nlink--;
+			inode_drop_nlink(old_dir);
 	} else if (they_are_dirs) {
-		old_dir->i_nlink--;
+		inode_drop_nlink(old_dir);
 		new_dir->i_nlink++;
 	}
 
diff -puN fs/nfs/dir.c~B-unlink-monitor-i_nlink-0 fs/nfs/dir.c
--- lxc/fs/nfs/dir.c~B-unlink-monitor-i_nlink-0	2006-07-12 11:09:16.000000000 -0700
+++ lxc-dave/fs/nfs/dir.c	2006-07-12 11:09:19.000000000 -0700
@@ -841,7 +841,7 @@ static void nfs_dentry_iput(struct dentr
 	nfs_inode_return_delegation(inode);
 	if (dentry->d_flags & DCACHE_NFSFS_RENAMED) {
 		lock_kernel();
-		inode->i_nlink--;
+		inode_drop_nlink(inode);
 		nfs_complete_unlink(dentry);
 		unlock_kernel();
 	}
@@ -1391,7 +1391,7 @@ static int nfs_safe_remove(struct dentry
 		error = NFS_PROTO(dir)->remove(dir, &dentry->d_name);
 		/* The VFS may want to delete this inode */
 		if (error == 0)
-			inode->i_nlink--;
+			inode_drop_nlink(inode);
 		nfs_mark_for_revalidate(inode);
 		nfs_end_data_update(inode);
 	} else
@@ -1595,7 +1595,7 @@ static int nfs_rename(struct inode *old_
 			goto out;
 		}
 	} else
-		new_inode->i_nlink--;
+		inode_drop_nlink(new_inode);
 
 go_ahead:
 	/*
diff -puN fs/ocfs2/namei.c~B-unlink-monitor-i_nlink-0 fs/ocfs2/namei.c
--- lxc/fs/ocfs2/namei.c~B-unlink-monitor-i_nlink-0	2006-07-12 11:09:16.000000000 -0700
+++ lxc-dave/fs/ocfs2/namei.c	2006-07-12 11:09:19.000000000 -0700
@@ -711,7 +711,7 @@ static int ocfs2_link(struct dentry *old
 	err = ocfs2_journal_dirty(handle, fe_bh);
 	if (err < 0) {
 		le16_add_cpu(&fe->i_links_count, -1);
-		inode->i_nlink--;
+		inode_drop_nlink(inode);
 		mlog_errno(err);
 		goto bail;
 	}
@@ -721,7 +721,7 @@ static int ocfs2_link(struct dentry *old
 			      parent_fe_bh, de_bh);
 	if (err) {
 		le16_add_cpu(&fe->i_links_count, -1);
-		inode->i_nlink--;
+		inode_drop_nlink(inode);
 		mlog_errno(err);
 		goto bail;
 	}
diff -puN fs/qnx4/namei.c~B-unlink-monitor-i_nlink-0 fs/qnx4/namei.c
--- lxc/fs/qnx4/namei.c~B-unlink-monitor-i_nlink-0	2006-07-12 11:09:16.000000000 -0700
+++ lxc-dave/fs/qnx4/namei.c	2006-07-12 11:09:19.000000000 -0700
@@ -189,8 +189,7 @@ int qnx4_rmdir(struct inode *dir, struct
 	inode->i_nlink = 0;
 	mark_inode_dirty(inode);
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME_SEC;
-	dir->i_nlink--;
-	mark_inode_dirty(dir);
+	inode_dec_link_count(dir);
 	retval = 0;
 
       end_rmdir:
@@ -234,9 +233,8 @@ int qnx4_unlink(struct inode *dir, struc
 	mark_buffer_dirty(bh);
 	dir->i_ctime = dir->i_mtime = CURRENT_TIME_SEC;
 	mark_inode_dirty(dir);
-	inode->i_nlink--;
 	inode->i_ctime = dir->i_ctime;
-	mark_inode_dirty(inode);
+	inode_dec_link_count(inode);
 	retval = 0;
 
 end_unlink:
diff -puN fs/reiserfs/namei.c~B-unlink-monitor-i_nlink-0 fs/reiserfs/namei.c
--- lxc/fs/reiserfs/namei.c~B-unlink-monitor-i_nlink-0	2006-07-12 11:09:16.000000000 -0700
+++ lxc-dave/fs/reiserfs/namei.c	2006-07-12 11:09:19.000000000 -0700
@@ -994,7 +994,7 @@ static int reiserfs_unlink(struct inode 
 		inode->i_nlink = 1;
 	}
 
-	inode->i_nlink--;
+	inode_drop_nlink(inode);
 
 	/*
 	 * we schedule before doing the add_save_link call, save the link
diff -puN fs/sysv/namei.c~B-unlink-monitor-i_nlink-0 fs/sysv/namei.c
--- lxc/fs/sysv/namei.c~B-unlink-monitor-i_nlink-0	2006-07-12 11:09:16.000000000 -0700
+++ lxc-dave/fs/sysv/namei.c	2006-07-12 11:09:19.000000000 -0700
@@ -250,7 +250,7 @@ static int sysv_rename(struct inode * ol
 		sysv_set_link(new_de, new_page, old_inode);
 		new_inode->i_ctime = CURRENT_TIME_SEC;
 		if (dir_de)
-			new_inode->i_nlink--;
+			inode_drop_nlink(new_inode);
 		inode_dec_link_count(new_inode);
 	} else {
 		if (dir_de) {
diff -puN fs/udf/namei.c~B-unlink-monitor-i_nlink-0 fs/udf/namei.c
--- lxc/fs/udf/namei.c~B-unlink-monitor-i_nlink-0	2006-07-12 11:09:16.000000000 -0700
+++ lxc-dave/fs/udf/namei.c	2006-07-12 11:09:19.000000000 -0700
@@ -923,7 +923,7 @@ static int udf_unlink(struct inode * dir
 		goto end_unlink;
 	dir->i_ctime = dir->i_mtime = current_fs_time(dir->i_sb);
 	mark_inode_dirty(dir);
-	inode->i_nlink--;
+	inode_drop_nlink(inode);
 	mark_inode_dirty(inode);
 	inode->i_ctime = dir->i_ctime;
 	retval = 0;
@@ -1101,7 +1101,7 @@ out:
 	return err;
 
 out_no_entry:
-	inode->i_nlink--;
+	inode_drop_nlink(inode);
 	mark_inode_dirty(inode);
 	iput(inode);
 	goto out;
@@ -1261,7 +1261,7 @@ static int udf_rename (struct inode * ol
 
 	if (new_inode)
 	{
-		new_inode->i_nlink--;
+		inode_drop_nlink(new_inode);
 		new_inode->i_ctime = current_fs_time(new_inode->i_sb);
 		mark_inode_dirty(new_inode);
 	}
diff -puN fs/ufs/namei.c~B-unlink-monitor-i_nlink-0 fs/ufs/namei.c
--- lxc/fs/ufs/namei.c~B-unlink-monitor-i_nlink-0	2006-07-12 11:09:16.000000000 -0700
+++ lxc-dave/fs/ufs/namei.c	2006-07-12 11:09:19.000000000 -0700
@@ -307,7 +307,7 @@ static int ufs_rename(struct inode *old_
 		ufs_set_link(new_dir, new_de, new_page, old_inode);
 		new_inode->i_ctime = CURRENT_TIME_SEC;
 		if (dir_de)
-			new_inode->i_nlink--;
+			inode_drop_nlink(new_inode);
 		inode_dec_link_count(new_inode);
 	} else {
 		if (dir_de) {
diff -puN fs/vfat/namei.c~B-unlink-monitor-i_nlink-0 fs/vfat/namei.c
--- lxc/fs/vfat/namei.c~B-unlink-monitor-i_nlink-0	2006-07-12 11:09:16.000000000 -0700
+++ lxc-dave/fs/vfat/namei.c	2006-07-12 11:09:19.000000000 -0700
@@ -782,7 +782,7 @@ static int vfat_rmdir(struct inode *dir,
 	err = fat_remove_entries(dir, &sinfo);	/* and releases bh */
 	if (err)
 		goto out;
-	dir->i_nlink--;
+	inode_drop_nlink(dir);
 
 	inode->i_nlink = 0;
 	inode->i_mtime = inode->i_atime = CURRENT_TIME_SEC;
@@ -930,7 +930,7 @@ static int vfat_rename(struct inode *old
 			if (err)
 				goto error_dotdot;
 		}
-		old_dir->i_nlink--;
+		inode_drop_nlink(old_dir);
 		if (!new_inode)
  			new_dir->i_nlink++;
 	}
@@ -950,7 +950,7 @@ static int vfat_rename(struct inode *old
 		if (is_dir)
 			new_inode->i_nlink -= 2;
 		else
-			new_inode->i_nlink--;
+			inode_drop_nlink(new_inode);
 		new_inode->i_ctime = ts;
 	}
 out:
diff -puN include/linux/fs.h~B-unlink-monitor-i_nlink-0 include/linux/fs.h
--- lxc/include/linux/fs.h~B-unlink-monitor-i_nlink-0	2006-07-12 11:09:16.000000000 -0700
+++ lxc-dave/include/linux/fs.h	2006-07-12 11:09:19.000000000 -0700
@@ -1876,6 +1876,7 @@ extern int simple_prepare_write(struct f
 			unsigned offset, unsigned to);
 extern int simple_commit_write(struct file *file, struct page *page,
 				unsigned offset, unsigned to);
+extern void inode_drop_nlink(struct inode *inode);
 
 extern struct dentry *simple_lookup(struct inode *, struct dentry *, struct nameidata *);
 extern ssize_t generic_read_dir(struct file *, char __user *, size_t, loff_t *);
diff -puN ipc/mqueue.c~B-unlink-monitor-i_nlink-0 ipc/mqueue.c
--- lxc/ipc/mqueue.c~B-unlink-monitor-i_nlink-0	2006-07-12 11:09:16.000000000 -0700
+++ lxc-dave/ipc/mqueue.c	2006-07-12 11:09:19.000000000 -0700
@@ -307,7 +307,7 @@ static int mqueue_unlink(struct inode *d
 
 	dir->i_ctime = dir->i_mtime = dir->i_atime = CURRENT_TIME;
 	dir->i_size -= DIRENT_SIZE;
-  	inode->i_nlink--;
+  	inode_drop_nlink(inode);
   	dput(dentry);
   	return 0;
 }
diff -puN mm/shmem.c~B-unlink-monitor-i_nlink-0 mm/shmem.c
--- lxc/mm/shmem.c~B-unlink-monitor-i_nlink-0	2006-07-12 11:09:16.000000000 -0700
+++ lxc-dave/mm/shmem.c	2006-07-12 11:09:19.000000000 -0700
@@ -1760,7 +1760,7 @@ static int shmem_unlink(struct inode *di
 
 	dir->i_size -= BOGO_DIRENT_SIZE;
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
-	inode->i_nlink--;
+	inode_drop_nlink(inode);
 	dput(dentry);	/* Undo the count from "create" - this does all the work */
 	return 0;
 }
@@ -1770,8 +1770,8 @@ static int shmem_rmdir(struct inode *dir
 	if (!simple_empty(dentry))
 		return -ENOTEMPTY;
 
-	dentry->d_inode->i_nlink--;
-	dir->i_nlink--;
+	inode_drop_nlink(dentry->d_inode);
+	inode_drop_nlink(dir);
 	return shmem_unlink(dir, dentry);
 }
 
@@ -1792,9 +1792,9 @@ static int shmem_rename(struct inode *ol
 	if (new_dentry->d_inode) {
 		(void) shmem_unlink(new_dir, new_dentry);
 		if (they_are_dirs)
-			old_dir->i_nlink--;
+			inode_drop_nlink(old_dir);
 	} else if (they_are_dirs) {
-		old_dir->i_nlink--;
+		inode_drop_nlink(old_dir);
 		new_dir->i_nlink++;
 	}
 
_
