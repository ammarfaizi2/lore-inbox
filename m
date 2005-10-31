Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbVJaM3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbVJaM3w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 07:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbVJaM3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 07:29:52 -0500
Received: from host-84-9-201-132.bulldogdsl.com ([84.9.201.132]:24705 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S932395AbVJaM3w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 07:29:52 -0500
Date: Mon, 31 Oct 2005 12:29:50 +0000
From: Ben Dooks <ben-linux@fluff.org>
To: linux-kernel@vger.kernel.org
Cc: trond.myklebust@fys.uio.no
Subject: fs/nfs - cleanup function declarations
Message-ID: <20051031122950.GA12009@home.fluff.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Cleanup sparse warnings from fs/nfs, mainly
due to undeclared functions or missing static
from functions.

This patch does the following:

1) place static on both the nfs_llseek_dir and
   nfs_fsync_dir in dir.c as they where earlier
   declared static

2) add shared.h, and put declarations of the
   init functions into it.

3) use inline to remove DIRECTIO initialisation
   support to cleanup the init/exit code paths

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

diff -urpN -X ../dontdiff linux-2.6.14-git3/fs/nfs/dir.c linux-2.6.14-git3-bjd1/fs/nfs/dir.c
--- linux-2.6.14-git3/fs/nfs/dir.c	2005-10-31 11:17:07.000000000 +0000
+++ linux-2.6.14-git3-bjd1/fs/nfs/dir.c	2005-10-31 11:39:27.000000000 +0000
@@ -571,7 +571,7 @@ static int nfs_readdir(struct file *filp
 	return 0;
 }
 
-loff_t nfs_llseek_dir(struct file *filp, loff_t offset, int origin)
+static loff_t nfs_llseek_dir(struct file *filp, loff_t offset, int origin)
 {
 	down(&filp->f_dentry->d_inode->i_sem);
 	switch (origin) {
@@ -597,7 +597,7 @@ out:
  * All directory operations under NFS are synchronous, so fsync()
  * is a dummy operation.
  */
-int nfs_fsync_dir(struct file *filp, struct dentry *dentry, int datasync)
+static int nfs_fsync_dir(struct file *filp, struct dentry *dentry, int datasync)
 {
 	return 0;
 }
diff -urpN -X ../dontdiff linux-2.6.14-git3/fs/nfs/direct.c linux-2.6.14-git3-bjd1/fs/nfs/direct.c
--- linux-2.6.14-git3/fs/nfs/direct.c	2005-09-01 21:02:38.000000000 +0100
+++ linux-2.6.14-git3-bjd1/fs/nfs/direct.c	2005-10-31 12:20:25.000000000 +0000
@@ -54,6 +54,8 @@
 #include <asm/uaccess.h>
 #include <asm/atomic.h>
 
+#include "shared.h"
+
 #define NFSDBG_FACILITY		NFSDBG_VFS
 #define MAX_DIRECTIO_SIZE	(4096UL << PAGE_SHIFT)
 
diff -urpN -X ../dontdiff linux-2.6.14-git3/fs/nfs/inode.c linux-2.6.14-git3-bjd1/fs/nfs/inode.c
--- linux-2.6.14-git3/fs/nfs/inode.c	2005-10-31 11:17:07.000000000 +0000
+++ linux-2.6.14-git3-bjd1/fs/nfs/inode.c	2005-10-31 12:19:40.000000000 +0000
@@ -41,6 +41,7 @@
 
 #include "nfs4_fs.h"
 #include "delegation.h"
+#include "shared.h"
 
 #define NFSDBG_FACILITY		NFSDBG_VFS
 #define NFS_PARANOIA 1
@@ -2047,17 +2048,6 @@ static struct file_system_type nfs4_fs_t
 #define unregister_nfs4fs()
 #endif
 
-extern int nfs_init_nfspagecache(void);
-extern void nfs_destroy_nfspagecache(void);
-extern int nfs_init_readpagecache(void);
-extern void nfs_destroy_readpagecache(void);
-extern int nfs_init_writepagecache(void);
-extern void nfs_destroy_writepagecache(void);
-#ifdef CONFIG_NFS_DIRECTIO
-extern int nfs_init_directcache(void);
-extern void nfs_destroy_directcache(void);
-#endif
-
 static kmem_cache_t * nfs_inode_cachep;
 
 static struct inode *nfs_alloc_inode(struct super_block *sb)
@@ -2144,11 +2134,9 @@ static int __init init_nfs_fs(void)
 	if (err)
 		goto out1;
 
-#ifdef CONFIG_NFS_DIRECTIO
 	err = nfs_init_directcache();
 	if (err)
 		goto out0;
-#endif
 
 #ifdef CONFIG_PROC_FS
 	rpc_proc_register(&nfs_rpcstat);
@@ -2164,10 +2152,8 @@ out:
 	rpc_proc_unregister("nfs");
 #endif
 	nfs_destroy_writepagecache();
-#ifdef CONFIG_NFS_DIRECTIO
 out0:
 	nfs_destroy_directcache();
-#endif
 out1:
 	nfs_destroy_readpagecache();
 out2:
diff -urpN -X ../dontdiff linux-2.6.14-git3/fs/nfs/pagelist.c linux-2.6.14-git3-bjd1/fs/nfs/pagelist.c
--- linux-2.6.14-git3/fs/nfs/pagelist.c	2005-09-01 21:02:38.000000000 +0100
+++ linux-2.6.14-git3-bjd1/fs/nfs/pagelist.c	2005-10-31 12:06:59.000000000 +0000
@@ -19,6 +19,8 @@
 #include <linux/nfs_fs.h>
 #include <linux/nfs_mount.h>
 
+#include "shared.h"
+
 #define NFS_PARANOIA 1
 
 static kmem_cache_t *nfs_page_cachep;
diff -urpN -X ../dontdiff linux-2.6.14-git3/fs/nfs/read.c linux-2.6.14-git3-bjd1/fs/nfs/read.c
--- linux-2.6.14-git3/fs/nfs/read.c	2005-10-31 11:17:07.000000000 +0000
+++ linux-2.6.14-git3-bjd1/fs/nfs/read.c	2005-10-31 12:08:50.000000000 +0000
@@ -31,6 +31,8 @@
 
 #include <asm/system.h>
 
+#include "shared.h"
+
 #define NFSDBG_FACILITY		NFSDBG_PAGECACHE
 
 static int nfs_pagein_one(struct list_head *, struct inode *);
diff -urpN -X ../dontdiff linux-2.6.14-git3/fs/nfs/shared.h linux-2.6.14-git3-bjd1/fs/nfs/shared.h
--- linux-2.6.14-git3/fs/nfs/shared.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-git3-bjd1/fs/nfs/shared.h	2005-10-31 12:20:11.000000000 +0000
@@ -0,0 +1,29 @@
+/* fs/nfs/shared.h
+ *
+ * common declarations for items shared in fs/nfs
+ *	(c) 2005 Ben Dooks <ben-linux@fluff.org), GPLv2 License
+*/
+
+/* read.c */
+extern int nfs_init_readpagecache(void);
+extern void nfs_destroy_readpagecache(void);
+
+/* write.c */
+extern int nfs_init_writepagecache(void);
+extern void nfs_destroy_writepagecache(void);
+
+/* pagelist.c */
+extern int nfs_init_nfspagecache(void);
+extern void nfs_destroy_nfspagecache(void);
+
+#ifdef CONFIG_NFS_DIRECTIO
+extern int nfs_init_directcache(void);
+extern void nfs_destroy_directcache(void);
+#else
+static inline int nfs_init_directcache(void)
+{
+	return 0;
+}
+
+static inline void nfs_destroy_directcache(void) { }
+#endif
diff -urpN -X ../dontdiff linux-2.6.14-git3/fs/nfs/write.c linux-2.6.14-git3-bjd1/fs/nfs/write.c
--- linux-2.6.14-git3/fs/nfs/write.c	2005-10-31 11:17:07.000000000 +0000
+++ linux-2.6.14-git3-bjd1/fs/nfs/write.c	2005-10-31 12:08:49.000000000 +0000
@@ -63,6 +63,7 @@
 #include <linux/smp_lock.h>
 
 #include "delegation.h"
+#include "shared.h"
 
 #define NFSDBG_FACILITY		NFSDBG_PAGECACHE
 

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2614-nfs-common-decl.patch"

diff -urpN -X ../dontdiff linux-2.6.14-git3/fs/nfs/dir.c linux-2.6.14-git3-bjd1/fs/nfs/dir.c
--- linux-2.6.14-git3/fs/nfs/dir.c	2005-10-31 11:17:07.000000000 +0000
+++ linux-2.6.14-git3-bjd1/fs/nfs/dir.c	2005-10-31 11:39:27.000000000 +0000
@@ -571,7 +571,7 @@ static int nfs_readdir(struct file *filp
 	return 0;
 }
 
-loff_t nfs_llseek_dir(struct file *filp, loff_t offset, int origin)
+static loff_t nfs_llseek_dir(struct file *filp, loff_t offset, int origin)
 {
 	down(&filp->f_dentry->d_inode->i_sem);
 	switch (origin) {
@@ -597,7 +597,7 @@ out:
  * All directory operations under NFS are synchronous, so fsync()
  * is a dummy operation.
  */
-int nfs_fsync_dir(struct file *filp, struct dentry *dentry, int datasync)
+static int nfs_fsync_dir(struct file *filp, struct dentry *dentry, int datasync)
 {
 	return 0;
 }
diff -urpN -X ../dontdiff linux-2.6.14-git3/fs/nfs/direct.c linux-2.6.14-git3-bjd1/fs/nfs/direct.c
--- linux-2.6.14-git3/fs/nfs/direct.c	2005-09-01 21:02:38.000000000 +0100
+++ linux-2.6.14-git3-bjd1/fs/nfs/direct.c	2005-10-31 12:20:25.000000000 +0000
@@ -54,6 +54,8 @@
 #include <asm/uaccess.h>
 #include <asm/atomic.h>
 
+#include "shared.h"
+
 #define NFSDBG_FACILITY		NFSDBG_VFS
 #define MAX_DIRECTIO_SIZE	(4096UL << PAGE_SHIFT)
 
diff -urpN -X ../dontdiff linux-2.6.14-git3/fs/nfs/inode.c linux-2.6.14-git3-bjd1/fs/nfs/inode.c
--- linux-2.6.14-git3/fs/nfs/inode.c	2005-10-31 11:17:07.000000000 +0000
+++ linux-2.6.14-git3-bjd1/fs/nfs/inode.c	2005-10-31 12:19:40.000000000 +0000
@@ -41,6 +41,7 @@
 
 #include "nfs4_fs.h"
 #include "delegation.h"
+#include "shared.h"
 
 #define NFSDBG_FACILITY		NFSDBG_VFS
 #define NFS_PARANOIA 1
@@ -2047,17 +2048,6 @@ static struct file_system_type nfs4_fs_t
 #define unregister_nfs4fs()
 #endif
 
-extern int nfs_init_nfspagecache(void);
-extern void nfs_destroy_nfspagecache(void);
-extern int nfs_init_readpagecache(void);
-extern void nfs_destroy_readpagecache(void);
-extern int nfs_init_writepagecache(void);
-extern void nfs_destroy_writepagecache(void);
-#ifdef CONFIG_NFS_DIRECTIO
-extern int nfs_init_directcache(void);
-extern void nfs_destroy_directcache(void);
-#endif
-
 static kmem_cache_t * nfs_inode_cachep;
 
 static struct inode *nfs_alloc_inode(struct super_block *sb)
@@ -2144,11 +2134,9 @@ static int __init init_nfs_fs(void)
 	if (err)
 		goto out1;
 
-#ifdef CONFIG_NFS_DIRECTIO
 	err = nfs_init_directcache();
 	if (err)
 		goto out0;
-#endif
 
 #ifdef CONFIG_PROC_FS
 	rpc_proc_register(&nfs_rpcstat);
@@ -2164,10 +2152,8 @@ out:
 	rpc_proc_unregister("nfs");
 #endif
 	nfs_destroy_writepagecache();
-#ifdef CONFIG_NFS_DIRECTIO
 out0:
 	nfs_destroy_directcache();
-#endif
 out1:
 	nfs_destroy_readpagecache();
 out2:
diff -urpN -X ../dontdiff linux-2.6.14-git3/fs/nfs/pagelist.c linux-2.6.14-git3-bjd1/fs/nfs/pagelist.c
--- linux-2.6.14-git3/fs/nfs/pagelist.c	2005-09-01 21:02:38.000000000 +0100
+++ linux-2.6.14-git3-bjd1/fs/nfs/pagelist.c	2005-10-31 12:06:59.000000000 +0000
@@ -19,6 +19,8 @@
 #include <linux/nfs_fs.h>
 #include <linux/nfs_mount.h>
 
+#include "shared.h"
+
 #define NFS_PARANOIA 1
 
 static kmem_cache_t *nfs_page_cachep;
diff -urpN -X ../dontdiff linux-2.6.14-git3/fs/nfs/read.c linux-2.6.14-git3-bjd1/fs/nfs/read.c
--- linux-2.6.14-git3/fs/nfs/read.c	2005-10-31 11:17:07.000000000 +0000
+++ linux-2.6.14-git3-bjd1/fs/nfs/read.c	2005-10-31 12:08:50.000000000 +0000
@@ -31,6 +31,8 @@
 
 #include <asm/system.h>
 
+#include "shared.h"
+
 #define NFSDBG_FACILITY		NFSDBG_PAGECACHE
 
 static int nfs_pagein_one(struct list_head *, struct inode *);
diff -urpN -X ../dontdiff linux-2.6.14-git3/fs/nfs/shared.h linux-2.6.14-git3-bjd1/fs/nfs/shared.h
--- linux-2.6.14-git3/fs/nfs/shared.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-git3-bjd1/fs/nfs/shared.h	2005-10-31 12:20:11.000000000 +0000
@@ -0,0 +1,29 @@
+/* fs/nfs/shared.h
+ *
+ * common declarations for items shared in fs/nfs
+ *	(c) 2005 Ben Dooks <ben-linux@fluff.org), GPLv2 License
+*/
+
+/* read.c */
+extern int nfs_init_readpagecache(void);
+extern void nfs_destroy_readpagecache(void);
+
+/* write.c */
+extern int nfs_init_writepagecache(void);
+extern void nfs_destroy_writepagecache(void);
+
+/* pagelist.c */
+extern int nfs_init_nfspagecache(void);
+extern void nfs_destroy_nfspagecache(void);
+
+#ifdef CONFIG_NFS_DIRECTIO
+extern int nfs_init_directcache(void);
+extern void nfs_destroy_directcache(void);
+#else
+static inline int nfs_init_directcache(void)
+{
+	return 0;
+}
+
+static inline void nfs_destroy_directcache(void) { }
+#endif
diff -urpN -X ../dontdiff linux-2.6.14-git3/fs/nfs/write.c linux-2.6.14-git3-bjd1/fs/nfs/write.c
--- linux-2.6.14-git3/fs/nfs/write.c	2005-10-31 11:17:07.000000000 +0000
+++ linux-2.6.14-git3-bjd1/fs/nfs/write.c	2005-10-31 12:08:49.000000000 +0000
@@ -63,6 +63,7 @@
 #include <linux/smp_lock.h>
 
 #include "delegation.h"
+#include "shared.h"
 
 #define NFSDBG_FACILITY		NFSDBG_PAGECACHE
 

--VbJkn9YxBvnuCH5J--
