Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWEQWWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWEQWWH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWEQWWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:22:07 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:54571 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751248AbWEQWWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 18:22:05 -0400
Date: Wed, 17 May 2006 15:21:51 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [git patches] ocfs2 fixes
Message-ID: <20060517222151.GV21588@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Oracle
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, sending this patch set again. It seems to have fallen off the
stack, probably because my timing sucked, and I mailed it out just
after -rc4 was released :/

Some OCFS2 bug fixes, and a couple configfs ones. All of them are issues
that folks have actually hit.

Please pull from 'upstream-linus' branch of
git://oss.oracle.com/home/sourcebo/git/ocfs2.git

to receive the following updates:

 fs/Makefile           |    2 
 fs/configfs/dir.c     |  137 +++++++++++++++++++++++++++++++++++---------------
 fs/ocfs2/aops.c       |   46 ++++++++++++++--
 fs/ocfs2/aops.h       |    4 -
 fs/ocfs2/extent_map.c |    6 +-
 fs/ocfs2/file.c       |   86 ++++++++++++++++++++++---------
 fs/ocfs2/journal.c    |    8 +-
 fs/ocfs2/uptodate.c   |    4 -
 fs/ocfs2/vote.c       |    6 +-
 9 files changed, 213 insertions(+), 86 deletions(-)

Joel Becker:
      configfs: Fix a reference leak in configfs_mkdir().
      configfs: configfs_mkdir() failed to cleanup linkage.
      configfs: Make sure configfs_init() is called before consumers.

Mark Fasheh:
      ocfs2: take data locks around extend
      ocfs2: take meta data lock in ocfs2_file_aio_read()
      ocfs2: Don't populate uptodate cache in ocfs2_force_read_journal()

Sunil Mushran:
      ocfs2: fix gfp mask in some file system paths

diff --git a/fs/Makefile b/fs/Makefile
index 83bf478..078d3d1 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_DNOTIFY)		+= dnotify.o
 obj-$(CONFIG_PROC_FS)		+= proc/
 obj-y				+= partitions/
 obj-$(CONFIG_SYSFS)		+= sysfs/
+obj-$(CONFIG_CONFIGFS_FS)	+= configfs/
 obj-y				+= devpts/
 
 obj-$(CONFIG_PROFILING)		+= dcookies.o
@@ -100,5 +101,4 @@ obj-$(CONFIG_BEFS_FS)		+= befs/
 obj-$(CONFIG_HOSTFS)		+= hostfs/
 obj-$(CONFIG_HPPFS)		+= hppfs/
 obj-$(CONFIG_DEBUG_FS)		+= debugfs/
-obj-$(CONFIG_CONFIGFS_FS)	+= configfs/
 obj-$(CONFIG_OCFS2_FS)		+= ocfs2/
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 5638c8f..5f95218 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -505,13 +505,15 @@ static int populate_groups(struct config
 	int i;
 
 	if (group->default_groups) {
-		/* FYI, we're faking mkdir here
+		/*
+		 * FYI, we're faking mkdir here
 		 * I'm not sure we need this semaphore, as we're called
 		 * from our parent's mkdir.  That holds our parent's
 		 * i_mutex, so afaik lookup cannot continue through our
 		 * parent to find us, let alone mess with our tree.
 		 * That said, taking our i_mutex is closer to mkdir
-		 * emulation, and shouldn't hurt. */
+		 * emulation, and shouldn't hurt.
+		 */
 		mutex_lock(&dentry->d_inode->i_mutex);
 
 		for (i = 0; group->default_groups[i]; i++) {
@@ -546,20 +548,34 @@ static void unlink_obj(struct config_ite
 
 		item->ci_group = NULL;
 		item->ci_parent = NULL;
+
+		/* Drop the reference for ci_entry */
 		config_item_put(item);
 
+		/* Drop the reference for ci_parent */
 		config_group_put(group);
 	}
 }
 
 static void link_obj(struct config_item *parent_item, struct config_item *item)
 {
-	/* Parent seems redundant with group, but it makes certain
-	 * traversals much nicer. */
+	/*
+	 * Parent seems redundant with group, but it makes certain
+	 * traversals much nicer.
+	 */
 	item->ci_parent = parent_item;
+
+	/*
+	 * We hold a reference on the parent for the child's ci_parent
+	 * link.
+	 */
 	item->ci_group = config_group_get(to_config_group(parent_item));
 	list_add_tail(&item->ci_entry, &item->ci_group->cg_children);
 
+	/*
+	 * We hold a reference on the child for ci_entry on the parent's
+	 * cg_children
+	 */
 	config_item_get(item);
 }
 
@@ -684,6 +700,10 @@ static void client_drop_item(struct conf
 	type = parent_item->ci_type;
 	BUG_ON(!type);
 
+	/*
+	 * If ->drop_item() exists, it is responsible for the
+	 * config_item_put().
+	 */
 	if (type->ct_group_ops && type->ct_group_ops->drop_item)
 		type->ct_group_ops->drop_item(to_config_group(parent_item),
 						item);
@@ -694,23 +714,28 @@ static void client_drop_item(struct conf
 
 static int configfs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
 {
-	int ret;
+	int ret, module_got = 0;
 	struct config_group *group;
 	struct config_item *item;
 	struct config_item *parent_item;
 	struct configfs_subsystem *subsys;
 	struct configfs_dirent *sd;
 	struct config_item_type *type;
-	struct module *owner;
+	struct module *owner = NULL;
 	char *name;
 
-	if (dentry->d_parent == configfs_sb->s_root)
-		return -EPERM;
+	if (dentry->d_parent == configfs_sb->s_root) {
+		ret = -EPERM;
+		goto out;
+	}
 
 	sd = dentry->d_parent->d_fsdata;
-	if (!(sd->s_type & CONFIGFS_USET_DIR))
-		return -EPERM;
+	if (!(sd->s_type & CONFIGFS_USET_DIR)) {
+		ret = -EPERM;
+		goto out;
+	}
 
+	/* Get a working ref for the duration of this function */
 	parent_item = configfs_get_config_item(dentry->d_parent);
 	type = parent_item->ci_type;
 	subsys = to_config_group(parent_item)->cg_subsys;
@@ -719,15 +744,16 @@ static int configfs_mkdir(struct inode *
 	if (!type || !type->ct_group_ops ||
 	    (!type->ct_group_ops->make_group &&
 	     !type->ct_group_ops->make_item)) {
-		config_item_put(parent_item);
-		return -EPERM;  /* What lack-of-mkdir returns */
+		ret = -EPERM;  /* Lack-of-mkdir returns -EPERM */
+		goto out_put;
 	}
 
 	name = kmalloc(dentry->d_name.len + 1, GFP_KERNEL);
 	if (!name) {
-		config_item_put(parent_item);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out_put;
 	}
+
 	snprintf(name, dentry->d_name.len + 1, "%s", dentry->d_name.name);
 
 	down(&subsys->su_sem);
@@ -748,40 +774,67 @@ static int configfs_mkdir(struct inode *
 
 	kfree(name);
 	if (!item) {
-		config_item_put(parent_item);
-		return -ENOMEM;
+		/*
+		 * If item == NULL, then link_obj() was never called.
+		 * There are no extra references to clean up.
+		 */
+		ret = -ENOMEM;
+		goto out_put;
 	}
 
-	ret = -EINVAL;
+	/*
+	 * link_obj() has been called (via link_group() for groups).
+	 * From here on out, errors must clean that up.
+	 */
+
 	type = item->ci_type;
-	if (type) {
-		owner = type->ct_owner;
-		if (try_module_get(owner)) {
-			if (group) {
-				ret = configfs_attach_group(parent_item,
-							    item,
-							    dentry);
-			} else {
-				ret = configfs_attach_item(parent_item,
-							   item,
-							   dentry);
-			}
+	if (!type) {
+		ret = -EINVAL;
+		goto out_unlink;
+	}
 
-			if (ret) {
-				down(&subsys->su_sem);
-				if (group)
-					unlink_group(group);
-				else
-					unlink_obj(item);
-				client_drop_item(parent_item, item);
-				up(&subsys->su_sem);
+	owner = type->ct_owner;
+	if (!try_module_get(owner)) {
+		ret = -EINVAL;
+		goto out_unlink;
+	}
 
-				config_item_put(parent_item);
-				module_put(owner);
-			}
-		}
+	/*
+	 * I hate doing it this way, but if there is
+	 * an error,  module_put() probably should
+	 * happen after any cleanup.
+	 */
+	module_got = 1;
+
+	if (group)
+		ret = configfs_attach_group(parent_item, item, dentry);
+	else
+		ret = configfs_attach_item(parent_item, item, dentry);
+
+out_unlink:
+	if (ret) {
+		/* Tear down everything we built up */
+		down(&subsys->su_sem);
+		if (group)
+			unlink_group(group);
+		else
+			unlink_obj(item);
+		client_drop_item(parent_item, item);
+		up(&subsys->su_sem);
+
+		if (module_got)
+			module_put(owner);
 	}
 
+out_put:
+	/*
+	 * link_obj()/link_group() took a reference from child->parent,
+	 * so the parent is safely pinned.  We can drop our working
+	 * reference.
+	 */
+	config_item_put(parent_item);
+
+out:
 	return ret;
 }
 
@@ -801,6 +854,7 @@ static int configfs_rmdir(struct inode *
 	if (sd->s_type & CONFIGFS_USET_DEFAULT)
 		return -EPERM;
 
+	/* Get a working ref until we have the child */
 	parent_item = configfs_get_config_item(dentry->d_parent);
 	subsys = to_config_group(parent_item)->cg_subsys;
 	BUG_ON(!subsys);
@@ -817,6 +871,7 @@ static int configfs_rmdir(struct inode *
 		return ret;
 	}
 
+	/* Get a working ref for the duration of this function */
 	item = configfs_get_config_item(dentry);
 
 	/* Drop reference from above, item already holds one. */
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 0d858d0..47152bf 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -276,13 +276,29 @@ static int ocfs2_writepage(struct page *
 	return ret;
 }
 
+/* This can also be called from ocfs2_write_zero_page() which has done
+ * it's own cluster locking. */
+int ocfs2_prepare_write_nolock(struct inode *inode, struct page *page,
+			       unsigned from, unsigned to)
+{
+	int ret;
+
+	down_read(&OCFS2_I(inode)->ip_alloc_sem);
+
+	ret = block_prepare_write(page, from, to, ocfs2_get_block);
+
+	up_read(&OCFS2_I(inode)->ip_alloc_sem);
+
+	return ret;
+}
+
 /*
  * ocfs2_prepare_write() can be an outer-most ocfs2 call when it is called
  * from loopback.  It must be able to perform its own locking around
  * ocfs2_get_block().
  */
-int ocfs2_prepare_write(struct file *file, struct page *page,
-			unsigned from, unsigned to)
+static int ocfs2_prepare_write(struct file *file, struct page *page,
+			       unsigned from, unsigned to)
 {
 	struct inode *inode = page->mapping->host;
 	int ret;
@@ -295,11 +311,7 @@ int ocfs2_prepare_write(struct file *fil
 		goto out;
 	}
 
-	down_read(&OCFS2_I(inode)->ip_alloc_sem);
-
-	ret = block_prepare_write(page, from, to, ocfs2_get_block);
-
-	up_read(&OCFS2_I(inode)->ip_alloc_sem);
+	ret = ocfs2_prepare_write_nolock(inode, page, from, to);
 
 	ocfs2_meta_unlock(inode, 0);
 out:
@@ -625,11 +637,31 @@ static ssize_t ocfs2_direct_IO(int rw,
 	int ret;
 
 	mlog_entry_void();
+
+	/*
+	 * We get PR data locks even for O_DIRECT.  This allows
+	 * concurrent O_DIRECT I/O but doesn't let O_DIRECT with
+	 * extending and buffered zeroing writes race.  If they did
+	 * race then the buffered zeroing could be written back after
+	 * the O_DIRECT I/O.  It's one thing to tell people not to mix
+	 * buffered and O_DIRECT writes, but expecting them to
+	 * understand that file extension is also an implicit buffered
+	 * write is too much.  By getting the PR we force writeback of
+	 * the buffered zeroing before proceeding.
+	 */
+	ret = ocfs2_data_lock(inode, 0);
+	if (ret < 0) {
+		mlog_errno(ret);
+		goto out;
+	}
+	ocfs2_data_unlock(inode, 0);
+
 	ret = blockdev_direct_IO_no_locking(rw, iocb, inode,
 					    inode->i_sb->s_bdev, iov, offset,
 					    nr_segs, 
 					    ocfs2_direct_IO_get_blocks,
 					    ocfs2_dio_end_io);
+out:
 	mlog_exit(ret);
 	return ret;
 }
diff --git a/fs/ocfs2/aops.h b/fs/ocfs2/aops.h
index d40456d..e88c3f0 100644
--- a/fs/ocfs2/aops.h
+++ b/fs/ocfs2/aops.h
@@ -22,8 +22,8 @@
 #ifndef OCFS2_AOPS_H
 #define OCFS2_AOPS_H
 
-int ocfs2_prepare_write(struct file *file, struct page *page,
-			unsigned from, unsigned to);
+int ocfs2_prepare_write_nolock(struct inode *inode, struct page *page,
+			       unsigned from, unsigned to);
 
 struct ocfs2_journal_handle *ocfs2_start_walk_page_trans(struct inode *inode,
 							 struct page *page,
diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
index 4601fc2..1a5c690 100644
--- a/fs/ocfs2/extent_map.c
+++ b/fs/ocfs2/extent_map.c
@@ -569,7 +569,7 @@ static int ocfs2_extent_map_insert(struc
 
 	ret = -ENOMEM;
 	ctxt.new_ent = kmem_cache_alloc(ocfs2_em_ent_cachep,
-					GFP_KERNEL);
+					GFP_NOFS);
 	if (!ctxt.new_ent) {
 		mlog_errno(ret);
 		return ret;
@@ -583,14 +583,14 @@ static int ocfs2_extent_map_insert(struc
 		if (ctxt.need_left && !ctxt.left_ent) {
 			ctxt.left_ent =
 				kmem_cache_alloc(ocfs2_em_ent_cachep,
-						 GFP_KERNEL);
+						 GFP_NOFS);
 			if (!ctxt.left_ent)
 				break;
 		}
 		if (ctxt.need_right && !ctxt.right_ent) {
 			ctxt.right_ent =
 				kmem_cache_alloc(ocfs2_em_ent_cachep,
-						 GFP_KERNEL);
+						 GFP_NOFS);
 			if (!ctxt.right_ent)
 				break;
 		}
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 581eb45..a9559c8 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -613,7 +613,8 @@ leave:
 
 /* Some parts of this taken from generic_cont_expand, which turned out
  * to be too fragile to do exactly what we need without us having to
- * worry about recursive locking in ->commit_write(). */
+ * worry about recursive locking in ->prepare_write() and
+ * ->commit_write(). */
 static int ocfs2_write_zero_page(struct inode *inode,
 				 u64 size)
 {
@@ -641,7 +642,7 @@ static int ocfs2_write_zero_page(struct 
 		goto out;
 	}
 
-	ret = ocfs2_prepare_write(NULL, page, offset, offset);
+	ret = ocfs2_prepare_write_nolock(inode, page, offset, offset);
 	if (ret < 0) {
 		mlog_errno(ret);
 		goto out_unlock;
@@ -695,13 +696,26 @@ out:
 	return ret;
 }
 
+/* 
+ * A tail_to_skip value > 0 indicates that we're being called from
+ * ocfs2_file_aio_write(). This has the following implications:
+ *
+ * - we don't want to update i_size
+ * - di_bh will be NULL, which is fine because it's only used in the
+ *   case where we want to update i_size.
+ * - ocfs2_zero_extend() will then only be filling the hole created
+ *   between i_size and the start of the write.
+ */
 static int ocfs2_extend_file(struct inode *inode,
 			     struct buffer_head *di_bh,
-			     u64 new_i_size)
+			     u64 new_i_size,
+			     size_t tail_to_skip)
 {
 	int ret = 0;
 	u32 clusters_to_add;
 
+	BUG_ON(!tail_to_skip && !di_bh);
+
 	/* setattr sometimes calls us like this. */
 	if (new_i_size == 0)
 		goto out;
@@ -714,27 +728,44 @@ static int ocfs2_extend_file(struct inod
 		OCFS2_I(inode)->ip_clusters;
 
 	if (clusters_to_add) {
-		ret = ocfs2_extend_allocation(inode, clusters_to_add);
+		/* 
+		 * protect the pages that ocfs2_zero_extend is going to
+		 * be pulling into the page cache.. we do this before the
+		 * metadata extend so that we don't get into the situation
+		 * where we've extended the metadata but can't get the data
+		 * lock to zero.
+		 */
+		ret = ocfs2_data_lock(inode, 1);
 		if (ret < 0) {
 			mlog_errno(ret);
 			goto out;
 		}
 
-		ret = ocfs2_zero_extend(inode, new_i_size);
+		ret = ocfs2_extend_allocation(inode, clusters_to_add);
 		if (ret < 0) {
 			mlog_errno(ret);
-			goto out;
+			goto out_unlock;
 		}
-	} 
 
-	/* No allocation required, we just use this helper to
-	 * do a trivial update of i_size. */
-	ret = ocfs2_simple_size_update(inode, di_bh, new_i_size);
-	if (ret < 0) {
-		mlog_errno(ret);
-		goto out;
+		ret = ocfs2_zero_extend(inode, (u64)new_i_size - tail_to_skip);
+		if (ret < 0) {
+			mlog_errno(ret);
+			goto out_unlock;
+		}
+	}
+
+	if (!tail_to_skip) {
+		/* We're being called from ocfs2_setattr() which wants
+		 * us to update i_size */
+		ret = ocfs2_simple_size_update(inode, di_bh, new_i_size);
+		if (ret < 0)
+			mlog_errno(ret);
 	}
 
+out_unlock:
+	if (clusters_to_add) /* this is the only case in which we lock */
+		ocfs2_data_unlock(inode, 1);
+
 out:
 	return ret;
 }
@@ -793,7 +824,7 @@ #define OCFS2_VALID_ATTRS (ATTR_ATIME | 
 		if (i_size_read(inode) > attr->ia_size)
 			status = ocfs2_truncate_file(inode, bh, attr->ia_size);
 		else
-			status = ocfs2_extend_file(inode, bh, attr->ia_size);
+			status = ocfs2_extend_file(inode, bh, attr->ia_size, 0);
 		if (status < 0) {
 			if (status != -ENOSPC)
 				mlog_errno(status);
@@ -1049,21 +1080,12 @@ static ssize_t ocfs2_file_aio_write(stru
 		if (!clusters)
 			break;
 
-		ret = ocfs2_extend_allocation(inode, clusters);
+		ret = ocfs2_extend_file(inode, NULL, newsize, count);
 		if (ret < 0) {
 			if (ret != -ENOSPC)
 				mlog_errno(ret);
 			goto out;
 		}
-
-		/* Fill any holes which would've been created by this
-		 * write. If we're O_APPEND, this will wind up
-		 * (correctly) being a noop. */
-		ret = ocfs2_zero_extend(inode, (u64) newsize - count);
-		if (ret < 0) {
-			mlog_errno(ret);
-			goto out;
-		}
 		break;
 	}
 
@@ -1146,6 +1168,22 @@ static ssize_t ocfs2_file_aio_read(struc
 		ocfs2_iocb_set_rw_locked(iocb);
 	}
 
+	/*
+	 * We're fine letting folks race truncates and extending
+	 * writes with read across the cluster, just like they can
+	 * locally. Hence no rw_lock during read.
+	 * 
+	 * Take and drop the meta data lock to update inode fields
+	 * like i_size. This allows the checks down below
+	 * generic_file_aio_read() a chance of actually working. 
+	 */
+	ret = ocfs2_meta_lock(inode, NULL, NULL, 0);
+	if (ret < 0) {
+		mlog_errno(ret);
+		goto bail;
+	}
+	ocfs2_meta_unlock(inode, 0);
+
 	ret = generic_file_aio_read(iocb, buf, count, iocb->ki_pos);
 	if (ret == -EINVAL)
 		mlog(ML_ERROR, "generic_file_aio_read returned -EINVAL\n");
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index 6a610ae..eebc3cf 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -117,7 +117,7 @@ struct ocfs2_journal_handle *ocfs2_alloc
 {
 	struct ocfs2_journal_handle *retval = NULL;
 
-	retval = kcalloc(1, sizeof(*retval), GFP_KERNEL);
+	retval = kcalloc(1, sizeof(*retval), GFP_NOFS);
 	if (!retval) {
 		mlog(ML_ERROR, "Failed to allocate memory for journal "
 		     "handle!\n");
@@ -870,9 +870,11 @@ #define CONCURRENT_JOURNAL_FILL 32
 		if (p_blocks > CONCURRENT_JOURNAL_FILL)
 			p_blocks = CONCURRENT_JOURNAL_FILL;
 
+		/* We are reading journal data which should not
+		 * be put in the uptodate cache */
 		status = ocfs2_read_blocks(OCFS2_SB(inode->i_sb),
 					   p_blkno, p_blocks, bhs, 0,
-					   inode);
+					   NULL);
 		if (status < 0) {
 			mlog_errno(status);
 			goto bail;
@@ -982,7 +984,7 @@ static void ocfs2_queue_recovery_complet
 {
 	struct ocfs2_la_recovery_item *item;
 
-	item = kmalloc(sizeof(struct ocfs2_la_recovery_item), GFP_KERNEL);
+	item = kmalloc(sizeof(struct ocfs2_la_recovery_item), GFP_NOFS);
 	if (!item) {
 		/* Though we wish to avoid it, we are in fact safe in
 		 * skipping local alloc cleanup as fsck.ocfs2 is more
diff --git a/fs/ocfs2/uptodate.c b/fs/ocfs2/uptodate.c
index 04a684d..b8a00a7 100644
--- a/fs/ocfs2/uptodate.c
+++ b/fs/ocfs2/uptodate.c
@@ -337,7 +337,7 @@ static void __ocfs2_set_buffer_uptodate(
 	     (unsigned long long)oi->ip_blkno,
 	     (unsigned long long)block, expand_tree);
 
-	new = kmem_cache_alloc(ocfs2_uptodate_cachep, GFP_KERNEL);
+	new = kmem_cache_alloc(ocfs2_uptodate_cachep, GFP_NOFS);
 	if (!new) {
 		mlog_errno(-ENOMEM);
 		return;
@@ -349,7 +349,7 @@ static void __ocfs2_set_buffer_uptodate(
 		 * has no way of tracking that. */
 		for(i = 0; i < OCFS2_INODE_MAX_CACHE_ARRAY; i++) {
 			tree[i] = kmem_cache_alloc(ocfs2_uptodate_cachep,
-						   GFP_KERNEL);
+						   GFP_NOFS);
 			if (!tree[i]) {
 				mlog_errno(-ENOMEM);
 				goto out_free;
diff --git a/fs/ocfs2/vote.c b/fs/ocfs2/vote.c
index 53049a2..ee42765 100644
--- a/fs/ocfs2/vote.c
+++ b/fs/ocfs2/vote.c
@@ -586,7 +586,7 @@ static struct ocfs2_net_wait_ctxt *ocfs2
 {
 	struct ocfs2_net_wait_ctxt *w;
 
-	w = kcalloc(1, sizeof(*w), GFP_KERNEL);
+	w = kcalloc(1, sizeof(*w), GFP_NOFS);
 	if (!w) {
 		mlog_errno(-ENOMEM);
 		goto bail;
@@ -749,7 +749,7 @@ static struct ocfs2_vote_msg * ocfs2_new
 
 	BUG_ON(!ocfs2_is_valid_vote_request(type));
 
-	request = kcalloc(1, sizeof(*request), GFP_KERNEL);
+	request = kcalloc(1, sizeof(*request), GFP_NOFS);
 	if (!request) {
 		mlog_errno(-ENOMEM);
 	} else {
@@ -1129,7 +1129,7 @@ static int ocfs2_handle_vote_message(str
 	struct ocfs2_super *osb = data;
 	struct ocfs2_vote_work *work;
 
-	work = kmalloc(sizeof(struct ocfs2_vote_work), GFP_KERNEL);
+	work = kmalloc(sizeof(struct ocfs2_vote_work), GFP_NOFS);
 	if (!work) {
 		status = -ENOMEM;
 		mlog_errno(status);
