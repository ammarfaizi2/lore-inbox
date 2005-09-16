Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161075AbVIPHCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161075AbVIPHCK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 03:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161072AbVIPHBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 03:01:51 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:53988 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161075AbVIPHBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 03:01:15 -0400
Message-Id: <20050916123314.863192000@localhost>
References: <20050916121646.387617000@localhost>
Date: Fri, 16 Sep 2005 08:16:57 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: ppc64-dev <linuxppc64-dev@ozlabs.org>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       jordi_caubet@es.ibm.com, Hiroyuki Machida <machida@sm.sony.co.jp>,
       Geoff Levand <geoffrey.levand@am.sony.com>
Subject: [patch 11/11] spufs: remove old user interfaces
Content-Disposition: inline; filename=spufs-remove-legacy-2.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes support for the old interfaces that we have
been using up to this point. With this patch, the run
file will not be provided any more, and it is no longer
possible to create or remove files or directories in
the spufs.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

--

 arch/ppc64/kernel/spu_base.c |   10 --
 fs/spufs/context.c           |   25 -----
 fs/spufs/file.c              |   97 +----------------------
 fs/spufs/inode.c             |   68 ----------------
 fs/spufs/spufs.h             |    1 
 fs/spufs/syscalls.c          |   10 --
 6 files changed, 15 insertions(+), 196 deletions(-)

Index: linux-cg/fs/spufs/syscalls.c
===================================================================
--- linux-cg.orig/fs/spufs/syscalls.c
+++ linux-cg/fs/spufs/syscalls.c
@@ -36,7 +36,7 @@ long do_spu_run(struct file *filp, __u32
 	u32 npc, status;
 
 	ret = -EFAULT;
-	if (get_user(npc, unpc))
+	if (get_user(npc, unpc) || get_user(status, ustatus))
 		goto out;
 
 	ret = -EINVAL;
@@ -46,13 +46,7 @@ long do_spu_run(struct file *filp, __u32
 	i = SPUFS_I(filp->f_dentry->d_inode);
 	ret = spufs_run_spu(filp, i->i_ctx, &npc, &status);
 
-	if (ret ==-EAGAIN || ret == -EIO)
-		ret = status;
-
-	if (put_user(npc, unpc))
-		ret = -EFAULT;
-
-	if (ustatus && put_user(status, ustatus))
+	if (put_user(npc, unpc) || put_user(status, ustatus))
 		ret = -EFAULT;
 out:
 	return ret;
Index: linux-cg/arch/ppc64/kernel/spu_base.c
===================================================================
--- linux-cg.orig/arch/ppc64/kernel/spu_base.c
+++ linux-cg/arch/ppc64/kernel/spu_base.c
@@ -521,11 +521,7 @@ int spu_run(struct spu *spu)
 			|| (in_be64(&priv1->mfc_dsisr_RW) & MFC_DSISR_PTE_NOT_FOUND)
 			|| spu->class_0_pending);
 
-		if (status & SPU_STATUS_STOPPED_BY_STOP)
-			ret = -EAGAIN;
-		else if (status & SPU_STATUS_STOPPED_BY_HALT)
-			ret = -EIO;
-		else if (in_be64(&priv1->mfc_dsisr_RW) & MFC_DSISR_PTE_NOT_FOUND)
+		if (in_be64(&priv1->mfc_dsisr_RW) & MFC_DSISR_PTE_NOT_FOUND)
 			ret = spu_handle_pte_fault(spu);
 
 		if (spu->class_0_pending)
@@ -534,7 +530,9 @@ int spu_run(struct spu *spu)
 		if (!ret && signal_pending(current))
 			ret = -ERESTARTSYS;
 
-	} while (!ret);
+	} while (!ret && !(status &
+			   (SPU_STATUS_STOPPED_BY_STOP |
+			    SPU_STATUS_STOPPED_BY_HALT)));
 
 	/* Ensure SPU is stopped.  */
 	out_be32(&prob->spu_runcntl_RW, SPU_RUNCNTL_STOP);
Index: linux-cg/fs/spufs/context.c
===================================================================
--- linux-cg.orig/fs/spufs/context.c
+++ linux-cg/fs/spufs/context.c
@@ -98,31 +98,6 @@ static void spu_unmap_mappings(struct sp
 	unmap_mapping_range(ctx->local_store, 0, LS_SIZE, 1);
 }
 
-int spu_acquire_runnable_nonblock(struct spu_context *ctx)
-{
-	int ret = 0;
-
-	if (!down_read_trylock(&ctx->state_sema))
-		return -EAGAIN;
-	if (ctx->state == SPU_STATE_RUNNABLE
-	    || ctx->state == SPU_STATE_LOCKED)
-		return 0;
-	up_read(&ctx->state_sema);
-
-	if (!down_write_trylock(&ctx->state_sema))
-		return -EAGAIN;
-	if (ctx->state == SPU_STATE_SAVED) {
-		spu_unmap_mappings(ctx);
-		ret = spu_activate(ctx, 0);
-		ctx->state = SPU_STATE_RUNNABLE;
-	}
-	downgrade_write(&ctx->state_sema);
-	if (ret)
-		/* Release here, to simplify calling code. */
-		spu_release(ctx);
-	return ret;
-}
-
 int spu_acquire_runnable(struct spu_context *ctx)
 {
 	int ret = 0;
Index: linux-cg/fs/spufs/file.c
===================================================================
--- linux-cg.orig/fs/spufs/file.c
+++ linux-cg/fs/spufs/file.c
@@ -578,23 +578,21 @@ static struct file_operations spufs_wbox
 };
 
 long spufs_run_spu(struct file *file, struct spu_context *ctx,
-		u32 *npc, u32 *status)
+				u32 *npc, u32 *status)
 {
 	int ret;
 
-	if (file->f_flags & O_NONBLOCK) {
-		ret = spu_acquire_runnable_nonblock(ctx);
-	} else {
-		ret = spu_acquire_runnable(ctx);
-	}
-	if (ret != 0)
+	ret = spu_acquire_runnable(ctx);
+	if (ret)
 		return ret;
 
 	ctx->ops->npc_write(ctx, *npc);
 
 	ret = spu_run(ctx->spu);
 
-	*status = ctx->ops->status_read(ctx);
+	if (!ret)
+		ret = ctx->ops->status_read(ctx);
+
 	*npc = ctx->ops->npc_read(ctx);
 
 	spu_release(ctx);
@@ -602,88 +600,6 @@ long spufs_run_spu(struct file *file, st
 	return ret;
 }
 
-struct spufs_run_arg {
-	u32 npc;    /* inout: Next Program Counter */
-	u32 status; /* out:   SPU status */
-};
-
-static ssize_t spufs_run_read(struct file *file, char __user *buf,
-			size_t len, loff_t *pos)
-{
-	struct spu_context *ctx;
-	struct spufs_run_arg arg;
-	int ret;
-
-	ctx = file->private_data;
-
-	ret = -EINVAL;
-	if (len < 8)
-		goto out;
-
-	if (file->f_flags & O_NONBLOCK) {
-		ret = spu_acquire_runnable_nonblock(ctx);
-	} else {
-		ret = spu_acquire_runnable(ctx);
-	}
-	if (ret != 0)
-		return ret;
-
-	ret = spu_run(ctx->spu);
-	if (ret == -EAGAIN)
-		ret = 0;
-
-	arg.status = ctx->ops->status_read(ctx);
-	arg.npc = ctx->ops->npc_read(ctx);
-
-	if ((arg.status & 0xffff0002) == 0x21000002) {
-		/* library callout */
-		u32 npc = arg.npc;
-		arg.npc = *(u32*) (ctx->spu->local_store + npc);
-		npc += 4;
-		out_be32(&ctx->spu->problem->spu_npc_RW, npc);
-	}
-
-	spu_release(ctx);
-	if (ret)
-		goto out;
-
-	ret = 8;
-	if (copy_to_user(buf, &arg, 8))
-		ret = -EFAULT;
-
-out:
-	return ret;
-}
-
-/* either this ioctl function or the system call needs to die! */
-static long spufs_run_ioctl(struct file *file, unsigned int num,
-						unsigned long arg)
-{
-	struct spufs_run_arg data;
-	int ret;
-
-	if (num != _IOWR('s', 0, struct spufs_run_arg))
-		return -EINVAL;
-
-	if (copy_from_user(&data, (void __user *)arg, sizeof data))
-		return -EFAULT;
-
-	ret = spufs_run_spu(file, file->private_data,
-				&data.npc, &data.status);
-
-	if (copy_to_user((void __user *)arg, &data, sizeof data))
-		ret = -EFAULT;
-
-	return ret;
-}
-
-static struct file_operations spufs_run_fops = {
-	.open		= spufs_pipe_open,
-	.unlocked_ioctl	= spufs_run_ioctl,
-	.compat_ioctl	= spufs_run_ioctl,
-	.read		= spufs_run_read,
-};
-
 static ssize_t spufs_signal1_read(struct file *file, char __user *buf,
 			size_t len, loff_t *pos)
 {
@@ -956,7 +872,6 @@ DEFINE_SIMPLE_ATTRIBUTE(spufs_srr0_ops, 
 struct tree_descr spufs_dir_contents[] = {
 	{ "mem",  &spufs_mem_fops,  0666, },
 	{ "regs", &spufs_regs_fops,  0666, },
-	{ "run",  &spufs_run_fops,  0444, },
 	{ "mbox", &spufs_mbox_fops, 0444, },
 	{ "ibox", &spufs_ibox_fops, 0444, },
 	{ "wbox", &spufs_wbox_fops, 0222, },
Index: linux-cg/fs/spufs/inode.c
===================================================================
--- linux-cg.orig/fs/spufs/inode.c
+++ linux-cg/fs/spufs/inode.c
@@ -41,24 +41,6 @@
 
 static kmem_cache_t *spufs_inode_cache;
 
-/* Information about the backing dev, same as ramfs */
-#if 0
-static struct backing_dev_info spufs_backing_dev_info = {
-	.ra_pages       = 0,    /* No readahead */
-	.capabilities	= BDI_CAP_NO_ACCT_DIRTY | BDI_CAP_NO_WRITEBACK |
-	  BDI_CAP_MAP_DIRECT | BDI_CAP_MAP_COPY | BDI_CAP_READ_MAP |
-	  BDI_CAP_WRITE_MAP,
-};
-
-static struct address_space_operations spufs_aops = {
-	.readpage       = simple_readpage,
-	.prepare_write  = simple_prepare_write,
-	.commit_write   = simple_commit_write,
-};
-#endif
-
-/* Inode operations */
-
 static struct inode *
 spufs_alloc_inode(struct super_block *sb)
 {
@@ -111,9 +93,6 @@ spufs_setattr(struct dentry *dentry, str
 {
 	struct inode *inode = dentry->d_inode;
 
-/*	dump_stack();
-	pr_debug("ia_size %lld, i_size:%lld\n", attr->ia_size, inode->i_size);
-*/
 	if ((attr->ia_valid & ATTR_SIZE) &&
 	    (attr->ia_size != inode->i_size))
 		return -EINVAL;
@@ -127,9 +106,7 @@ spufs_new_file(struct super_block *sb, s
 		struct spu_context *ctx)
 {
 	static struct inode_operations spufs_file_iops = {
-		.getattr = simple_getattr,
 		.setattr = spufs_setattr,
-		.unlink  = simple_unlink,
 	};
 	struct inode *inode;
 	int ret;
@@ -142,43 +119,12 @@ spufs_new_file(struct super_block *sb, s
 	ret = 0;
 	inode->i_op = &spufs_file_iops;
 	inode->i_fop = fops;
-//	inode->i_mapping->a_ops = &spufs_aops;
-//	inode->i_mapping->backing_dev_info = &spufs_backing_dev_info;
 	inode->u.generic_ip = SPUFS_I(inode)->i_ctx = get_spu_context(ctx);
 	d_add(dentry, inode);
 out:
 	return ret;
 }
 
-static int
-spufs_create(struct inode *dir, struct dentry *dentry,
-		int mode, struct nameidata *nd)
-{
-	struct tree_descr *descr;
-	struct spu_context *ctx;
-	int ret;
-
-	descr = spufs_dir_contents;
-
-	/* search spufs_dir_contents for a file with the name we are
-	   trying to create */
-	ret = -EINVAL;
-	while (strcmp(descr->name, dentry->d_name.name) != 0) {
-		descr++;
-		if (!descr->name || !descr->name[0])
-			goto out;
-	}
-
-	ctx = SPUFS_I(dir)->i_ctx;
-	mode &= descr->mode;
-
-	ret = spufs_new_file(dir->i_sb, dentry, descr->ops, mode, ctx);
-	/* get an extra reference to pin the dentry */
-	dget(dentry);
-out:
-	return ret;
-}
-
 static void
 spufs_delete_inode(struct inode *inode)
 {
@@ -253,8 +199,6 @@ static int spufs_dir_close(struct inode 
 
 struct inode_operations spufs_dir_inode_operations = {
 	.lookup = simple_lookup,
-	.unlink = simple_unlink,
-	.create = spufs_create,
 };
 
 struct file_operations spufs_autodelete_dir_operations = {
@@ -401,14 +345,8 @@ spufs_parse_options(char *options, struc
 }
 
 static int
-spufs_create_root(struct super_block *sb, void *data) {
-	static struct inode_operations spufs_root_inode_operations = {
-		.lookup		= simple_lookup,
-		.mkdir		= spufs_mkdir,
-		.rmdir		= spufs_rmdir,
-//		.rename		= simple_rename, // XXX maybe
-	};
-
+spufs_create_root(struct super_block *sb, void *data)
+{
 	struct inode *inode;
 	int ret;
 
@@ -417,7 +355,7 @@ spufs_create_root(struct super_block *sb
 	if (!inode)
 		goto out;
 
-	inode->i_op = &spufs_root_inode_operations;
+	inode->i_op = &spufs_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
 	SPUFS_I(inode)->i_ctx = NULL;
 
Index: linux-cg/fs/spufs/spufs.h
===================================================================
--- linux-cg.orig/fs/spufs/spufs.h
+++ linux-cg/fs/spufs/spufs.h
@@ -101,7 +101,6 @@ int put_spu_context(struct spu_context *
 void spu_acquire(struct spu_context *ctx);
 void spu_release(struct spu_context *ctx);
 int spu_acquire_runnable(struct spu_context *ctx);
-int spu_acquire_runnable_nonblock(struct spu_context *ctx);
 void spu_acquire_saved(struct spu_context *ctx);
 
 int spu_activate(struct spu_context *ctx, u64 flags);

--

