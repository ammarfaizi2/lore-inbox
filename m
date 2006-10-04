Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161564AbWJDQfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161564AbWJDQfF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161559AbWJDQfC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:35:02 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:64219 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161540AbWJDQaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:30:55 -0400
Message-Id: <20061004161500.314144000@arndb.de>
References: <20061004152610.151599000@dyn-9-152-242-103.boeblingen.de.ibm.com>
User-Agent: quilt/0.45-1
Date: Wed, 04 Oct 2006 17:26:15 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 05/14] spufs: Add infrastructure needed for gang scheduling
Content-Disposition: inline; filename=spufs-gang-2.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the concept of a gang to spufs as a new type of object.
So far, this has no impact whatsover on scheduling, but makes
it possible to add that later.

A new type of object in spufs is now a spu_gang. It is created
with the spu_create system call with the flags argument set
to SPU_CREATE_GANG (0x2). Inside of a spu_gang, it
is then possible to create spu_context objects, which until
now was only possible at the root of spufs.

There is a new member in struct spu_context pointing to
the spu_gang it belongs to, if any. The spu_gang maintains
a list of spu_context structures that are its children.
This information can then be used in the scheduler in the
future.

There is still a bug that needs to be resolved in this
basic infrastructure regarding the order in which objects
are removed. When the spu_gang file descriptor is closed
before the spu_context descriptors, we leak the dentry
and inode for the gang. Any ideas how to cleanly solve
this are appreciated.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/Makefile
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/Makefile
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/Makefile
@@ -2,7 +2,7 @@ obj-y += switch.o
 
 obj-$(CONFIG_SPU_FS) += spufs.o
 spufs-y += inode.o file.o context.o syscalls.o
-spufs-y += sched.o backing_ops.o hw_ops.o run.o
+spufs-y += sched.o backing_ops.o hw_ops.o run.o gang.o
 
 # Rules to build switch.o with the help of SPU tool chain
 SPU_CROSS	:= spu-
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/context.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/context.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/context.c
@@ -27,7 +27,7 @@
 #include <asm/spu_csa.h>
 #include "spufs.h"
 
-struct spu_context *alloc_spu_context(void)
+struct spu_context *alloc_spu_context(struct spu_gang *gang)
 {
 	struct spu_context *ctx;
 	ctx = kzalloc(sizeof *ctx, GFP_KERNEL);
@@ -51,6 +51,8 @@ struct spu_context *alloc_spu_context(vo
 	ctx->state = SPU_STATE_SAVED;
 	ctx->ops = &spu_backing_ops;
 	ctx->owner = get_task_mm(current);
+	if (gang)
+		spu_gang_add_ctx(gang, ctx);
 	goto out;
 out_free:
 	kfree(ctx);
@@ -67,6 +69,8 @@ void destroy_spu_context(struct kref *kr
 	spu_deactivate(ctx);
 	up_write(&ctx->state_sema);
 	spu_fini_csa(&ctx->csa);
+	if (ctx->gang)
+		spu_gang_remove_ctx(ctx->gang, ctx);
 	kfree(ctx);
 }
 
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/gang.c
===================================================================
--- /dev/null
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/gang.c
@@ -0,0 +1,81 @@
+/*
+ * SPU file system
+ *
+ * (C) Copyright IBM Deutschland Entwicklung GmbH 2005
+ *
+ * Author: Arnd Bergmann <arndb@de.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/list.h>
+#include <linux/slab.h>
+
+#include "spufs.h"
+
+struct spu_gang *alloc_spu_gang(void)
+{
+	struct spu_gang *gang;
+
+	gang = kzalloc(sizeof *gang, GFP_KERNEL);
+	if (!gang)
+		goto out;
+
+	kref_init(&gang->kref);
+	mutex_init(&gang->mutex);
+	INIT_LIST_HEAD(&gang->list);
+
+out:
+	return gang;
+}
+
+static void destroy_spu_gang(struct kref *kref)
+{
+	struct spu_gang *gang;
+	gang = container_of(kref, struct spu_gang, kref);
+	WARN_ON(gang->contexts || !list_empty(&gang->list));
+	kfree(gang);
+}
+
+struct spu_gang *get_spu_gang(struct spu_gang *gang)
+{
+	kref_get(&gang->kref);
+	return gang;
+}
+
+int put_spu_gang(struct spu_gang *gang)
+{
+	return kref_put(&gang->kref, &destroy_spu_gang);
+}
+
+void spu_gang_add_ctx(struct spu_gang *gang, struct spu_context *ctx)
+{
+	mutex_lock(&gang->mutex);
+	ctx->gang = get_spu_gang(gang);
+	list_add(&ctx->gang_list, &gang->list);
+	gang->contexts++;
+	mutex_unlock(&gang->mutex);
+}
+
+void spu_gang_remove_ctx(struct spu_gang *gang, struct spu_context *ctx)
+{
+	mutex_lock(&gang->mutex);
+	WARN_ON(ctx->gang != gang);
+	list_del_init(&ctx->gang_list);
+	gang->contexts--;
+	mutex_unlock(&gang->mutex);
+
+	put_spu_gang(gang);
+}
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/inode.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/inode.c
@@ -50,6 +50,10 @@ spufs_alloc_inode(struct super_block *sb
 	ei = kmem_cache_alloc(spufs_inode_cache, SLAB_KERNEL);
 	if (!ei)
 		return NULL;
+
+	ei->i_gang = NULL;
+	ei->i_ctx = NULL;
+
 	return &ei->vfs_inode;
 }
 
@@ -128,14 +132,19 @@ out:
 static void
 spufs_delete_inode(struct inode *inode)
 {
-	if (SPUFS_I(inode)->i_ctx)
-		put_spu_context(SPUFS_I(inode)->i_ctx);
+	struct spufs_inode_info *ei = SPUFS_I(inode);
+
+	if (ei->i_ctx)
+		put_spu_context(ei->i_ctx);
+	if (ei->i_gang)
+		put_spu_gang(ei->i_gang);
 	clear_inode(inode);
 }
 
 static void spufs_prune_dir(struct dentry *dir)
 {
 	struct dentry *dentry, *tmp;
+
 	mutex_lock(&dir->d_inode->i_mutex);
 	list_for_each_entry_safe(dentry, tmp, &dir->d_subdirs, d_u.d_child) {
 		spin_lock(&dcache_lock);
@@ -156,13 +165,13 @@ static void spufs_prune_dir(struct dentr
 	mutex_unlock(&dir->d_inode->i_mutex);
 }
 
-/* Caller must hold root->i_mutex */
-static int spufs_rmdir(struct inode *root, struct dentry *dir_dentry)
+/* Caller must hold parent->i_mutex */
+static int spufs_rmdir(struct inode *parent, struct dentry *dir)
 {
 	/* remove all entries */
-	spufs_prune_dir(dir_dentry);
+	spufs_prune_dir(dir);
 
-	return simple_rmdir(root, dir_dentry);
+	return simple_rmdir(parent, dir);
 }
 
 static int spufs_fill_dir(struct dentry *dir, struct tree_descr *files,
@@ -191,17 +200,17 @@ out:
 static int spufs_dir_close(struct inode *inode, struct file *file)
 {
 	struct spu_context *ctx;
-	struct inode *dir;
-	struct dentry *dentry;
+	struct inode *parent;
+	struct dentry *dir;
 	int ret;
 
-	dentry = file->f_dentry;
-	dir = dentry->d_parent->d_inode;
-	ctx = SPUFS_I(dentry->d_inode)->i_ctx;
-
-	mutex_lock(&dir->i_mutex);
-	ret = spufs_rmdir(dir, dentry);
-	mutex_unlock(&dir->i_mutex);
+	dir = file->f_dentry;
+	parent = dir->d_parent->d_inode;
+	ctx = SPUFS_I(dir->d_inode)->i_ctx;
+
+	mutex_lock(&parent->i_mutex);
+	ret = spufs_rmdir(parent, dir);
+	mutex_unlock(&parent->i_mutex);
 	WARN_ON(ret);
 
 	/* We have to give up the mm_struct */
@@ -240,7 +249,7 @@ spufs_mkdir(struct inode *dir, struct de
 		inode->i_gid = dir->i_gid;
 		inode->i_mode &= S_ISGID;
 	}
-	ctx = alloc_spu_context();
+	ctx = alloc_spu_context(SPUFS_I(dir)->i_gang); /* XXX gang */
 	SPUFS_I(inode)->i_ctx = ctx;
 	if (!ctx)
 		goto out_iput;
@@ -292,24 +301,177 @@ out:
 	return ret;
 }
 
+static int spufs_create_context(struct inode *inode,
+			struct dentry *dentry,
+			struct vfsmount *mnt, int flags, int mode)
+{
+	int ret;
+
+	ret = spufs_mkdir(inode, dentry, flags, mode & S_IRWXUGO);
+	if (ret)
+		goto out_unlock;
+
+	/*
+	 * get references for dget and mntget, will be released
+	 * in error path of *_open().
+	 */
+	ret = spufs_context_open(dget(dentry), mntget(mnt));
+	if (ret < 0) {
+		WARN_ON(spufs_rmdir(inode, dentry));
+		mutex_unlock(&inode->i_mutex);
+		spu_forget(SPUFS_I(dentry->d_inode)->i_ctx);
+		goto out;
+	}
+
+out_unlock:
+	mutex_unlock(&inode->i_mutex);
+out:
+	dput(dentry);
+	return ret;
+}
+
+static int spufs_rmgang(struct inode *root, struct dentry *dir)
+{
+	/* FIXME: this fails if the dir is not empty,
+	          which causes a leak of gangs. */
+	return simple_rmdir(root, dir);
+}
+
+static int spufs_gang_close(struct inode *inode, struct file *file)
+{
+	struct inode *parent;
+	struct dentry *dir;
+	int ret;
+
+	dir = file->f_dentry;
+	parent = dir->d_parent->d_inode;
+
+	ret = spufs_rmgang(parent, dir);
+	WARN_ON(ret);
+
+	return dcache_dir_close(inode, file);
+}
+
+struct file_operations spufs_gang_fops = {
+	.open		= dcache_dir_open,
+	.release	= spufs_gang_close,
+	.llseek		= dcache_dir_lseek,
+	.read		= generic_read_dir,
+	.readdir	= dcache_readdir,
+	.fsync		= simple_sync_file,
+};
+
+static int
+spufs_mkgang(struct inode *dir, struct dentry *dentry, int mode)
+{
+	int ret;
+	struct inode *inode;
+	struct spu_gang *gang;
+
+	ret = -ENOSPC;
+	inode = spufs_new_inode(dir->i_sb, mode | S_IFDIR);
+	if (!inode)
+		goto out;
+
+	ret = 0;
+	if (dir->i_mode & S_ISGID) {
+		inode->i_gid = dir->i_gid;
+		inode->i_mode &= S_ISGID;
+	}
+	gang = alloc_spu_gang();
+	SPUFS_I(inode)->i_ctx = NULL;
+	SPUFS_I(inode)->i_gang = gang;
+	if (!gang)
+		goto out_iput;
+
+	inode->i_op = &spufs_dir_inode_operations;
+	inode->i_fop = &simple_dir_operations;
+
+	d_instantiate(dentry, inode);
+	dget(dentry);
+	dir->i_nlink++;
+	dentry->d_inode->i_nlink++;
+	return ret;
+
+out_iput:
+	iput(inode);
+out:
+	return ret;
+}
+
+static int spufs_gang_open(struct dentry *dentry, struct vfsmount *mnt)
+{
+	int ret;
+	struct file *filp;
+
+	ret = get_unused_fd();
+	if (ret < 0) {
+		dput(dentry);
+		mntput(mnt);
+		goto out;
+	}
+
+	filp = dentry_open(dentry, mnt, O_RDONLY);
+	if (IS_ERR(filp)) {
+		put_unused_fd(ret);
+		ret = PTR_ERR(filp);
+		goto out;
+	}
+
+	filp->f_op = &spufs_gang_fops;
+	fd_install(ret, filp);
+out:
+	return ret;
+}
+
+static int spufs_create_gang(struct inode *inode,
+			struct dentry *dentry,
+			struct vfsmount *mnt, int mode)
+{
+	int ret;
+
+	ret = spufs_mkgang(inode, dentry, mode & S_IRWXUGO);
+	if (ret)
+		goto out;
+
+	/*
+	 * get references for dget and mntget, will be released
+	 * in error path of *_open().
+	 */
+	ret = spufs_gang_open(dget(dentry), mntget(mnt));
+	if (ret < 0)
+		WARN_ON(spufs_rmgang(inode, dentry));
+
+out:
+	mutex_unlock(&inode->i_mutex);
+	dput(dentry);
+	return ret;
+}
+
+
 static struct file_system_type spufs_type;
 
-long spufs_create_thread(struct nameidata *nd,
-			 unsigned int flags, mode_t mode)
+long spufs_create(struct nameidata *nd, unsigned int flags, mode_t mode)
 {
 	struct dentry *dentry;
 	int ret;
 
-	/* need to be at the root of spufs */
 	ret = -EINVAL;
-	if (nd->dentry->d_sb->s_type != &spufs_type ||
-	    nd->dentry != nd->dentry->d_sb->s_root)
+	/* check if we are on spufs */
+	if (nd->dentry->d_sb->s_type != &spufs_type)
 		goto out;
 
-	/* all flags are reserved */
+	/* don't accept undefined flags */
 	if (flags & (~SPU_CREATE_FLAG_ALL))
 		goto out;
 
+	/* only threads can be underneath a gang */
+	if (nd->dentry != nd->dentry->d_sb->s_root) {
+		if ((flags & SPU_CREATE_GANG) ||
+		    !SPUFS_I(nd->dentry->d_inode)->i_gang)
+			goto out;
+	}
+
 	dentry = lookup_create(nd, 1);
 	ret = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
@@ -320,22 +482,13 @@ long spufs_create_thread(struct nameidat
 		goto out_dput;
 
 	mode &= ~current->fs->umask;
-	ret = spufs_mkdir(nd->dentry->d_inode, dentry, flags, mode & S_IRWXUGO);
-	if (ret)
-		goto out_dput;
 
-	/*
-	 * get references for dget and mntget, will be released
-	 * in error path of *_open().
-	 */
-	ret = spufs_context_open(dget(dentry), mntget(nd->mnt));
-	if (ret < 0) {
-		WARN_ON(spufs_rmdir(nd->dentry->d_inode, dentry));
-		mutex_unlock(&nd->dentry->d_inode->i_mutex);
-		spu_forget(SPUFS_I(dentry->d_inode)->i_ctx);
-		dput(dentry);
-		goto out;
-	}
+	if (flags & SPU_CREATE_GANG)
+		return spufs_create_gang(nd->dentry->d_inode,
+					dentry, nd->mnt, mode);
+	else
+		return spufs_create_context(nd->dentry->d_inode,
+					dentry, nd->mnt, flags, mode);
 
 out_dput:
 	dput(dentry);
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/spufs.h
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/spufs.h
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/spufs.h
@@ -39,6 +39,8 @@ struct spu_context_ops;
 
 #define SPU_CONTEXT_PREEMPT          0UL
 
+struct spu_gang;
+
 struct spu_context {
 	struct spu *spu;		  /* pointer to a physical SPU */
 	struct spu_state csa;		  /* SPU context save area. */
@@ -68,6 +70,16 @@ struct spu_context {
 	struct work_struct reap_work;
 	unsigned long flags;
 	unsigned long event_return;
+
+	struct list_head gang_list;
+	struct spu_gang *gang;
+};
+
+struct spu_gang {
+	struct list_head list;
+	struct mutex mutex;
+	struct kref kref;
+	int contexts;
 };
 
 struct mfc_dma_command {
@@ -115,6 +127,7 @@ extern struct spu_context_ops spu_backin
 
 struct spufs_inode_info {
 	struct spu_context *i_ctx;
+	struct spu_gang *i_gang;
 	struct inode vfs_inode;
 };
 #define SPUFS_I(inode) \
@@ -125,12 +138,19 @@ extern struct tree_descr spufs_dir_conte
 /* system call implementation */
 long spufs_run_spu(struct file *file,
 		   struct spu_context *ctx, u32 *npc, u32 *status);
-long spufs_create_thread(struct nameidata *nd,
+long spufs_create(struct nameidata *nd,
 			 unsigned int flags, mode_t mode);
 extern struct file_operations spufs_context_fops;
 
+/* gang management */
+struct spu_gang *alloc_spu_gang(void);
+struct spu_gang *get_spu_gang(struct spu_gang *gang);
+int put_spu_gang(struct spu_gang *gang);
+void spu_gang_remove_ctx(struct spu_gang *gang, struct spu_context *ctx);
+void spu_gang_add_ctx(struct spu_gang *gang, struct spu_context *ctx);
+
 /* context management */
-struct spu_context * alloc_spu_context(void);
+struct spu_context * alloc_spu_context(struct spu_gang *gang);
 void destroy_spu_context(struct kref *kref);
 struct spu_context * get_spu_context(struct spu_context *ctx);
 int put_spu_context(struct spu_context *ctx);
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/syscalls.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/syscalls.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/syscalls.c
@@ -90,7 +90,7 @@ asmlinkage long sys_spu_create(const cha
 		ret = path_lookup(tmp, LOOKUP_PARENT|
 				LOOKUP_OPEN|LOOKUP_CREATE, &nd);
 		if (!ret) {
-			ret = spufs_create_thread(&nd, flags, mode);
+			ret = spufs_create(&nd, flags, mode);
 			path_release(&nd);
 		}
 		putname(tmp);
Index: linux-2.6/include/asm-powerpc/spu.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/spu.h
+++ linux-2.6/include/asm-powerpc/spu.h
@@ -181,7 +181,10 @@ extern struct spufs_calls {
  * Flags for sys_spu_create.
  */
 #define SPU_CREATE_EVENTS_ENABLED	0x0001
-#define SPU_CREATE_FLAG_ALL		0x0001 /* mask of all valid flags */
+#define SPU_CREATE_GANG			0x0002
+
+#define SPU_CREATE_FLAG_ALL		0x0003 /* mask of all valid flags */
+
 
 #ifdef CONFIG_SPU_FS_MODULE
 int register_spu_syscalls(struct spufs_calls *calls);

--

