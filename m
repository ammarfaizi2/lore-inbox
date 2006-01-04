Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965280AbWADT6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965280AbWADT6m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 14:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965279AbWADT6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 14:58:20 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:1780 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965280AbWADT5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 14:57:34 -0500
Message-Id: <20060104194501.915556000@localhost>
References: <20060104193120.050539000@localhost>
Date: Wed, 04 Jan 2006 20:31:31 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>, Mark Nutter <mnutter@us.ibm.com>,
       Arnd Bergmann <arndb@de.ibm.com>
Subject: [PATCH 11/13] spufs: fix sparse warnings
Content-Disposition: inline; filename=spufs-sparse-fixes.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One local variable is missing an __iomem modifier,
in another place, we pass a completely unused argument
with a missing __user modifier.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spu_base.c
@@ -357,7 +357,7 @@ static void spu_init_channels(struct spu
 		{ 0x17, 1, }, { 0x18, 0, }, { 0x19, 0, }, { 0x1b, 0, },
 		{ 0x1c, 1, }, { 0x1d, 0, }, { 0x1e, 1, },
 	};
-	struct spu_priv2 *priv2;
+	struct spu_priv2 __iomem *priv2;
 	int i;
 
 	priv2 = spu->priv2;
Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/spufs.h
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/spufs/spufs.h
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/spufs.h
@@ -101,7 +101,7 @@ extern struct tree_descr spufs_dir_conte
 /* system call implementation */
 long spufs_run_spu(struct file *file,
 		   struct spu_context *ctx, u32 *npc, u32 *status);
-long spufs_create_thread(struct nameidata *nd, const char *name,
+long spufs_create_thread(struct nameidata *nd,
 			 unsigned int flags, mode_t mode);
 extern struct file_operations spufs_context_fops;
 
Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/spufs/inode.c
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/inode.c
@@ -293,9 +293,8 @@ out:
 
 static struct file_system_type spufs_type;
 
-long
-spufs_create_thread(struct nameidata *nd, const char *name,
-			unsigned int flags, mode_t mode)
+long spufs_create_thread(struct nameidata *nd,
+			 unsigned int flags, mode_t mode)
 {
 	struct dentry *dentry;
 	int ret;
Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/syscalls.c
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/spufs/syscalls.c
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/syscalls.c
@@ -85,7 +85,7 @@ asmlinkage long sys_spu_create(const cha
 		ret = path_lookup(tmp, LOOKUP_PARENT|
 				LOOKUP_OPEN|LOOKUP_CREATE, &nd);
 		if (!ret) {
-			ret = spufs_create_thread(&nd, pathname, flags, mode);
+			ret = spufs_create_thread(&nd, flags, mode);
 			path_release(&nd);
 		}
 		putname(tmp);

--

