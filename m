Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964924AbWANPeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbWANPeE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 10:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbWANPeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 10:34:04 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:47317 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964924AbWANPeC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 10:34:02 -0500
Date: Sat, 14 Jan 2006 16:34:17 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       mikulas@artax.karlin.mff.cuni.cz
Subject: [patch 2.6.15-mm4] sem2mutex: HPFS
Message-ID: <20060114153417.GA29020@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.6 required=5.9 tests=AWL,ITS_LEGAL autolearn=no SpamAssassin version=3.0.3
	1.1 ITS_LEGAL              BODY: Claims to be Legal
	-0.5 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

semaphore to mutex conversion.

the conversion was generated via scripts, and the result was validated
automatically via a script as well.

build tested.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
----

 fs/hpfs/hpfs_fn.h |    5 ++--
 fs/hpfs/inode.c   |   10 ++++-----
 fs/hpfs/namei.c   |   60 +++++++++++++++++++++++++++---------------------------
 fs/hpfs/super.c   |    4 +--
 4 files changed, 40 insertions(+), 39 deletions(-)

Index: linux/fs/hpfs/hpfs_fn.h
===================================================================
--- linux.orig/fs/hpfs/hpfs_fn.h
+++ linux/fs/hpfs/hpfs_fn.h
@@ -9,6 +9,7 @@
 //#define DBG
 //#define DEBUG_LOCKS
 
+#include <linux/mutex.h>
 #include <linux/pagemap.h>
 #include <linux/buffer_head.h>
 #include <linux/hpfs_fs.h>
@@ -57,8 +58,8 @@ struct hpfs_inode_info {
 	unsigned i_ea_uid : 1;	/* file's uid is stored in ea */
 	unsigned i_ea_gid : 1;	/* file's gid is stored in ea */
 	unsigned i_dirty : 1;
-	struct semaphore i_sem;
-	struct semaphore i_parent;
+	struct mutex i_mutex;
+	struct mutex i_parent_mutex;
 	loff_t **i_rddir_off;
 	struct inode vfs_inode;
 };
Index: linux/fs/hpfs/inode.c
===================================================================
--- linux.orig/fs/hpfs/inode.c
+++ linux/fs/hpfs/inode.c
@@ -186,9 +186,9 @@ void hpfs_write_inode(struct inode *i)
 		kfree(hpfs_inode->i_rddir_off);
 		hpfs_inode->i_rddir_off = NULL;
 	}
-	down(&hpfs_inode->i_parent);
+	mutex_lock(&hpfs_inode->i_parent_mutex);
 	if (!i->i_nlink) {
-		up(&hpfs_inode->i_parent);
+		mutex_unlock(&hpfs_inode->i_parent_mutex);
 		return;
 	}
 	parent = iget_locked(i->i_sb, hpfs_inode->i_parent_dir);
@@ -199,14 +199,14 @@ void hpfs_write_inode(struct inode *i)
 			hpfs_read_inode(parent);
 			unlock_new_inode(parent);
 		}
-		down(&hpfs_inode->i_sem);
+		mutex_lock(&hpfs_inode->i_mutex);
 		hpfs_write_inode_nolock(i);
-		up(&hpfs_inode->i_sem);
+		mutex_unlock(&hpfs_inode->i_mutex);
 		iput(parent);
 	} else {
 		mark_inode_dirty(i);
 	}
-	up(&hpfs_inode->i_parent);
+	mutex_unlock(&hpfs_inode->i_parent_mutex);
 }
 
 void hpfs_write_inode_nolock(struct inode *i)
Index: linux/fs/hpfs/namei.c
===================================================================
--- linux.orig/fs/hpfs/namei.c
+++ linux/fs/hpfs/namei.c
@@ -60,7 +60,7 @@ static int hpfs_mkdir(struct inode *dir,
 	if (dee.read_only)
 		result->i_mode &= ~0222;
 
-	down(&hpfs_i(dir)->i_sem);
+	mutex_lock(&hpfs_i(dir)->i_mutex);
 	r = hpfs_add_dirent(dir, (char *)name, len, &dee, 0);
 	if (r == 1)
 		goto bail3;
@@ -101,11 +101,11 @@ static int hpfs_mkdir(struct inode *dir,
 		hpfs_write_inode_nolock(result);
 	}
 	d_instantiate(dentry, result);
-	up(&hpfs_i(dir)->i_sem);
+	mutex_unlock(&hpfs_i(dir)->i_mutex);
 	unlock_kernel();
 	return 0;
 bail3:
-	up(&hpfs_i(dir)->i_sem);
+	mutex_unlock(&hpfs_i(dir)->i_mutex);
 	iput(result);
 bail2:
 	hpfs_brelse4(&qbh0);
@@ -168,7 +168,7 @@ static int hpfs_create(struct inode *dir
 	result->i_data.a_ops = &hpfs_aops;
 	hpfs_i(result)->mmu_private = 0;
 
-	down(&hpfs_i(dir)->i_sem);
+	mutex_lock(&hpfs_i(dir)->i_mutex);
 	r = hpfs_add_dirent(dir, (char *)name, len, &dee, 0);
 	if (r == 1)
 		goto bail2;
@@ -193,12 +193,12 @@ static int hpfs_create(struct inode *dir
 		hpfs_write_inode_nolock(result);
 	}
 	d_instantiate(dentry, result);
-	up(&hpfs_i(dir)->i_sem);
+	mutex_unlock(&hpfs_i(dir)->i_mutex);
 	unlock_kernel();
 	return 0;
 
 bail2:
-	up(&hpfs_i(dir)->i_sem);
+	mutex_unlock(&hpfs_i(dir)->i_mutex);
 	iput(result);
 bail1:
 	brelse(bh);
@@ -254,7 +254,7 @@ static int hpfs_mknod(struct inode *dir,
 	result->i_blocks = 1;
 	init_special_inode(result, mode, rdev);
 
-	down(&hpfs_i(dir)->i_sem);
+	mutex_lock(&hpfs_i(dir)->i_mutex);
 	r = hpfs_add_dirent(dir, (char *)name, len, &dee, 0);
 	if (r == 1)
 		goto bail2;
@@ -271,12 +271,12 @@ static int hpfs_mknod(struct inode *dir,
 
 	hpfs_write_inode_nolock(result);
 	d_instantiate(dentry, result);
-	up(&hpfs_i(dir)->i_sem);
+	mutex_unlock(&hpfs_i(dir)->i_mutex);
 	brelse(bh);
 	unlock_kernel();
 	return 0;
 bail2:
-	up(&hpfs_i(dir)->i_sem);
+	mutex_unlock(&hpfs_i(dir)->i_mutex);
 	iput(result);
 bail1:
 	brelse(bh);
@@ -333,7 +333,7 @@ static int hpfs_symlink(struct inode *di
 	result->i_op = &page_symlink_inode_operations;
 	result->i_data.a_ops = &hpfs_symlink_aops;
 
-	down(&hpfs_i(dir)->i_sem);
+	mutex_lock(&hpfs_i(dir)->i_mutex);
 	r = hpfs_add_dirent(dir, (char *)name, len, &dee, 0);
 	if (r == 1)
 		goto bail2;
@@ -352,11 +352,11 @@ static int hpfs_symlink(struct inode *di
 
 	hpfs_write_inode_nolock(result);
 	d_instantiate(dentry, result);
-	up(&hpfs_i(dir)->i_sem);
+	mutex_unlock(&hpfs_i(dir)->i_mutex);
 	unlock_kernel();
 	return 0;
 bail2:
-	up(&hpfs_i(dir)->i_sem);
+	mutex_unlock(&hpfs_i(dir)->i_mutex);
 	iput(result);
 bail1:
 	brelse(bh);
@@ -382,8 +382,8 @@ static int hpfs_unlink(struct inode *dir
 	lock_kernel();
 	hpfs_adjust_length((char *)name, &len);
 again:
-	down(&hpfs_i(inode)->i_parent);
-	down(&hpfs_i(dir)->i_sem);
+	mutex_lock(&hpfs_i(inode)->i_parent_mutex);
+	mutex_lock(&hpfs_i(dir)->i_mutex);
 	err = -ENOENT;
 	de = map_dirent(dir, hpfs_i(dir)->i_dno, (char *)name, len, &dno, &qbh);
 	if (!de)
@@ -410,8 +410,8 @@ again:
 		if (rep++)
 			break;
 
-		up(&hpfs_i(dir)->i_sem);
-		up(&hpfs_i(inode)->i_parent);
+		mutex_unlock(&hpfs_i(dir)->i_mutex);
+		mutex_unlock(&hpfs_i(inode)->i_parent_mutex);
 		d_drop(dentry);
 		spin_lock(&dentry->d_lock);
 		if (atomic_read(&dentry->d_count) > 1 ||
@@ -442,8 +442,8 @@ again:
 out1:
 	hpfs_brelse4(&qbh);
 out:
-	up(&hpfs_i(dir)->i_sem);
-	up(&hpfs_i(inode)->i_parent);
+	mutex_unlock(&hpfs_i(dir)->i_mutex);
+	mutex_unlock(&hpfs_i(inode)->i_parent_mutex);
 	unlock_kernel();
 	return err;
 }
@@ -463,8 +463,8 @@ static int hpfs_rmdir(struct inode *dir,
 
 	hpfs_adjust_length((char *)name, &len);
 	lock_kernel();
-	down(&hpfs_i(inode)->i_parent);
-	down(&hpfs_i(dir)->i_sem);
+	mutex_lock(&hpfs_i(inode)->i_parent_mutex);
+	mutex_lock(&hpfs_i(dir)->i_mutex);
 	err = -ENOENT;
 	de = map_dirent(dir, hpfs_i(dir)->i_dno, (char *)name, len, &dno, &qbh);
 	if (!de)
@@ -502,8 +502,8 @@ static int hpfs_rmdir(struct inode *dir,
 out1:
 	hpfs_brelse4(&qbh);
 out:
-	up(&hpfs_i(dir)->i_sem);
-	up(&hpfs_i(inode)->i_parent);
+	mutex_unlock(&hpfs_i(dir)->i_mutex);
+	mutex_unlock(&hpfs_i(inode)->i_parent_mutex);
 	unlock_kernel();
 	return err;
 }
@@ -565,12 +565,12 @@ static int hpfs_rename(struct inode *old
 
 	lock_kernel();
 	/* order doesn't matter, due to VFS exclusion */
-	down(&hpfs_i(i)->i_parent);
+	mutex_lock(&hpfs_i(i)->i_parent_mutex);
 	if (new_inode)
-		down(&hpfs_i(new_inode)->i_parent);
-	down(&hpfs_i(old_dir)->i_sem);
+		mutex_lock(&hpfs_i(new_inode)->i_parent_mutex);
+	mutex_lock(&hpfs_i(old_dir)->i_mutex);
 	if (new_dir != old_dir)
-		down(&hpfs_i(new_dir)->i_sem);
+		mutex_lock(&hpfs_i(new_dir)->i_mutex);
 	
 	/* Erm? Moving over the empty non-busy directory is perfectly legal */
 	if (new_inode && S_ISDIR(new_inode->i_mode)) {
@@ -650,11 +650,11 @@ static int hpfs_rename(struct inode *old
 	hpfs_decide_conv(i, (char *)new_name, new_len);
 end1:
 	if (old_dir != new_dir)
-		up(&hpfs_i(new_dir)->i_sem);
-	up(&hpfs_i(old_dir)->i_sem);
-	up(&hpfs_i(i)->i_parent);
+		mutex_unlock(&hpfs_i(new_dir)->i_mutex);
+	mutex_unlock(&hpfs_i(old_dir)->i_mutex);
+	mutex_unlock(&hpfs_i(i)->i_parent_mutex);
 	if (new_inode)
-		up(&hpfs_i(new_inode)->i_parent);
+		mutex_unlock(&hpfs_i(new_inode)->i_parent_mutex);
 	unlock_kernel();
 	return err;
 }
Index: linux/fs/hpfs/super.c
===================================================================
--- linux.orig/fs/hpfs/super.c
+++ linux/fs/hpfs/super.c
@@ -181,8 +181,8 @@ static void init_once(void * foo, kmem_c
 
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR) {
-		init_MUTEX(&ei->i_sem);
-		init_MUTEX(&ei->i_parent);
+		mutex_init(&ei->i_mutex);
+		mutex_init(&ei->i_parent_mutex);
 		inode_init_once(&ei->vfs_inode);
 	}
 }
