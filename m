Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161095AbWJXQoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161095AbWJXQoZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 12:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030424AbWJXQkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 12:40:42 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:2037 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030423AbWJXQkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 12:40:07 -0400
Message-Id: <20061024163814.209789000@arndb.de>
References: <20061024163113.694643000@arndb.de>
User-Agent: quilt/0.45-1
Date: Tue, 24 Oct 2006 18:31:19 +0200
From: arnd@arndb.de
To: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, paulus@samba.org
Subject: [PATCH 06/16] spufs: Add isolated-mode SPE recycling support
Content-Disposition: inline; filename=spufs-recycle-isolated.diff
Cc: Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd.bergmann@de.ibm.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Kerr <jeremy@au1.ibm.com>

When in isolated mode, SPEs have access to an area of persistent
storage, which is per-SPE. In order for isolated-mode apps to
communicate arbitrary data through this storage, we need to ensure that
isolated physical SPEs can be reused for subsequent applications.

Add a file ("recycle") in a spethread dir to enable isolated-mode
recycling. By writing to this file, the kernel will reload the
isolated-mode loader kernel, allowing a new app to be run on the same
physical SPE.

This requires the spu_acquire_exclusive function to enforce exclusive
access to the SPE while the loader is initialised.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---
Update: clarify locking, remove unnecessary yield, require >0 bytes
        when writing to recycle file.

 arch/powerpc/platforms/cell/spufs/context.c |   27 +++++++++++++++++++++++
 arch/powerpc/platforms/cell/spufs/file.c    |   32 ++++++++++++++++++++++++++++
 arch/powerpc/platforms/cell/spufs/inode.c   |   23 +++++++++++++-------
 arch/powerpc/platforms/cell/spufs/spufs.h   |    7 ++++++
 4 files changed, 81 insertions(+), 8 deletions(-)

Index: linux-2.6/arch/powerpc/platforms/cell/spufs/context.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/context.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/context.c
@@ -120,6 +120,33 @@ void spu_unmap_mappings(struct spu_conte
 		unmap_mapping_range(ctx->signal2, 0, 0x4000, 1);
 }
 
+int spu_acquire_exclusive(struct spu_context *ctx)
+{
+       int ret = 0;
+
+       down_write(&ctx->state_sema);
+       /* ctx is about to be freed, can't acquire any more */
+       if (!ctx->owner) {
+               ret = -EINVAL;
+               goto out;
+       }
+
+       if (ctx->state == SPU_STATE_SAVED) {
+               ret = spu_activate(ctx, 0);
+               if (ret)
+                       goto out;
+               ctx->state = SPU_STATE_RUNNABLE;
+       } else {
+               /* We need to exclude userspace access to the context. */
+               spu_unmap_mappings(ctx);
+       }
+
+out:
+       if (ret)
+               up_write(&ctx->state_sema);
+       return ret;
+}
+
 int spu_acquire_runnable(struct spu_context *ctx)
 {
 	int ret = 0;
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/file.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
@@ -1343,6 +1343,37 @@ static struct file_operations spufs_mfc_
 	.mmap	 = spufs_mfc_mmap,
 };
 
+
+static int spufs_recycle_open(struct inode *inode, struct file *file)
+{
+	file->private_data = SPUFS_I(inode)->i_ctx;
+	return nonseekable_open(inode, file);
+}
+
+static ssize_t spufs_recycle_write(struct file *file,
+		const char __user *buffer, size_t size, loff_t *pos)
+{
+	struct spu_context *ctx = file->private_data;
+	int ret;
+
+	if (!(ctx->flags & SPU_CREATE_ISOLATE))
+		return -EINVAL;
+
+	if (size < 1)
+		return -EINVAL;
+
+	ret = spu_recycle_isolated(ctx);
+
+	if (ret)
+		return ret;
+	return size;
+}
+
+static struct file_operations spufs_recycle_fops = {
+	.open	 = spufs_recycle_open,
+	.write	 = spufs_recycle_write,
+};
+
 static void spufs_npc_set(void *data, u64 val)
 {
 	struct spu_context *ctx = data;
@@ -1551,5 +1582,6 @@ struct tree_descr spufs_dir_nosched_cont
 	{ "psmap", &spufs_psmap_fops, 0666, },
 	{ "phys-id", &spufs_id_ops, 0666, },
 	{ "object-id", &spufs_object_id_ops, 0666, },
+	{ "recycle", &spufs_recycle_fops, 0222, },
 	{},
 };
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/inode.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/inode.c
@@ -248,7 +248,7 @@ static int spu_setup_isolated(struct spu
 	if (!isolated_loader)
 		return -ENODEV;
 
-	if ((ret = spu_acquire_runnable(ctx)) != 0)
+	if ((ret = spu_acquire_exclusive(ctx)) != 0)
 		return ret;
 
 	mfc_cntl = &ctx->spu->priv2->mfc_control_RW;
@@ -314,10 +314,16 @@ out_drop_priv:
 	spu_mfc_sr1_set(ctx->spu, sr1);
 
 out_unlock:
-	up_write(&ctx->state_sema);
+	spu_release_exclusive(ctx);
 	return ret;
 }
 
+int spu_recycle_isolated(struct spu_context *ctx)
+{
+	ctx->ops->runcntl_stop(ctx);
+	return spu_setup_isolated(ctx);
+}
+
 static int
 spufs_mkdir(struct inode *dir, struct dentry *dentry, unsigned int flags,
 		int mode)
@@ -341,12 +347,6 @@ spufs_mkdir(struct inode *dir, struct de
 		goto out_iput;
 
 	ctx->flags = flags;
-	if (flags & SPU_CREATE_ISOLATE) {
-		ret = spu_setup_isolated(ctx);
-		if (ret)
-			goto out_iput;
-	}
-
 	inode->i_op = &spufs_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
 	if (flags & SPU_CREATE_NOSCHED)
@@ -432,6 +432,13 @@ static int spufs_create_context(struct i
 out_unlock:
 	mutex_unlock(&inode->i_mutex);
 out:
+	if (ret >= 0 && (flags & SPU_CREATE_ISOLATE)) {
+		int setup_err = spu_setup_isolated(
+				SPUFS_I(dentry->d_inode)->i_ctx);
+		if (setup_err)
+			ret = setup_err;
+	}
+
 	dput(dentry);
 	return ret;
 }
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/spufs.h
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/spufs.h
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/spufs.h
@@ -163,6 +163,12 @@ void spu_acquire(struct spu_context *ctx
 void spu_release(struct spu_context *ctx);
 int spu_acquire_runnable(struct spu_context *ctx);
 void spu_acquire_saved(struct spu_context *ctx);
+int spu_acquire_exclusive(struct spu_context *ctx);
+
+static inline void spu_release_exclusive(struct spu_context *ctx)
+{
+	up_write(&ctx->state_sema);
+}
 
 int spu_activate(struct spu_context *ctx, u64 flags);
 void spu_deactivate(struct spu_context *ctx);
@@ -170,6 +176,7 @@ void spu_yield(struct spu_context *ctx);
 int __init spu_sched_init(void);
 void __exit spu_sched_exit(void);
 
+int spu_recycle_isolated(struct spu_context *ctx);
 /*
  * spufs_wait
  * 	Same as wait_event_interruptible(), except that here

--

