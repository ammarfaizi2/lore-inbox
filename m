Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965185AbWADT5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965185AbWADT5c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 14:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965280AbWADT5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 14:57:32 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:19191 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965185AbWADT5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 14:57:31 -0500
Message-Id: <20060104194500.522025000@localhost>
References: <20060104193120.050539000@localhost>
Date: Wed, 04 Jan 2006 20:31:23 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>, Mark Nutter <mnutter@us.ibm.com>,
       Arnd Bergmann <arndb@de.ibm.com>
Subject: [PATCH 03/13] spufs: check for proper file pointer in sys_spu_run
Content-Disposition: inline; filename=spufs-run-check-fd.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Only checking for SPUFS_MAGIC is not reliable, because
it might not be unique in theory. Worse than that,
we accidentally allow spu_run to be performed on
any file in spufs, not just those returned from
spu_create as intended.

Noticed by Al Viro.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/spufs/inode.c
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/inode.c
@@ -212,7 +212,7 @@ struct inode_operations spufs_dir_inode_
 	.lookup = simple_lookup,
 };
 
-struct file_operations spufs_autodelete_dir_operations = {
+struct file_operations spufs_context_fops = {
 	.open		= dcache_dir_open,
 	.release	= spufs_dir_close,
 	.llseek		= dcache_dir_lseek,
@@ -301,7 +301,7 @@ spufs_create_thread(struct nameidata *nd
 		put_unused_fd(ret);
 		ret = PTR_ERR(filp);
 	} else {
-		filp->f_op = &spufs_autodelete_dir_operations;
+		filp->f_op = &spufs_context_fops;
 		fd_install(ret, filp);
 	}
 
Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/spufs.h
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/spufs/spufs.h
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/spufs.h
@@ -103,6 +103,7 @@ long spufs_run_spu(struct file *file,
 		   struct spu_context *ctx, u32 *npc, u32 *status);
 long spufs_create_thread(struct nameidata *nd, const char *name,
 			 unsigned int flags, mode_t mode);
+extern struct file_operations spufs_context_fops;
 
 /* context management */
 struct spu_context * alloc_spu_context(struct address_space *local_store);
Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/syscalls.c
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/spufs/syscalls.c
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/syscalls.c
@@ -39,8 +39,9 @@ long do_spu_run(struct file *filp, __u32
 	if (get_user(npc, unpc) || get_user(status, ustatus))
 		goto out;
 
+	/* check if this file was created by spu_create */
 	ret = -EINVAL;
-	if (filp->f_vfsmnt->mnt_sb->s_magic != SPUFS_MAGIC)
+	if (filp->f_op != &spufs_context_fops)
 		goto out;
 
 	i = SPUFS_I(filp->f_dentry->d_inode);

--

