Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262371AbSKHUpO>; Fri, 8 Nov 2002 15:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262372AbSKHUpO>; Fri, 8 Nov 2002 15:45:14 -0500
Received: from pat.uio.no ([129.240.130.16]:58262 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S262371AbSKHUpL>;
	Fri, 8 Nov 2002 15:45:11 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15820.9187.255107.827997@charged.uio.no>
Date: Fri, 8 Nov 2002 21:51:47 +0100
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] add an NFS memory pool
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ensure that we can still flush out a minimum number of read, write,
and commit requests if memory gets low.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.46-04-radix_tree/fs/nfs/nfs3proc.c linux-2.5.46-05-mempool/fs/nfs/nfs3proc.c
--- linux-2.5.46-04-radix_tree/fs/nfs/nfs3proc.c	2002-10-12 19:56:07.000000000 -0400
+++ linux-2.5.46-05-mempool/fs/nfs/nfs3proc.c	2002-11-08 15:40:48.000000000 -0500
@@ -811,7 +811,7 @@
 	rpc_init_task(task, NFS_CLIENT(inode), nfs3_commit_done, flags);
 	task->tk_calldata = data;
 	/* Release requests */
-	task->tk_release = nfs_writedata_release;
+	task->tk_release = nfs_commit_release;
 	
 	msg.rpc_proc = NFS3PROC_COMMIT;
 	msg.rpc_argp = &data->u.v3.args;
diff -u --recursive --new-file linux-2.5.46-04-radix_tree/fs/nfs/nfs4proc.c linux-2.5.46-05-mempool/fs/nfs/nfs4proc.c
--- linux-2.5.46-04-radix_tree/fs/nfs/nfs4proc.c	2002-10-14 10:03:48.000000000 -0400
+++ linux-2.5.46-05-mempool/fs/nfs/nfs4proc.c	2002-11-08 15:40:48.000000000 -0500
@@ -1481,7 +1481,7 @@
 	rpc_init_task(task, NFS_CLIENT(inode), nfs4_commit_done, flags);
 	task->tk_calldata = data;
 	/* Release requests */
-	task->tk_release = nfs_writedata_release;
+	task->tk_release = nfs_commit_release;
 	
 	rpc_call_setup(task, &msg, 0);	
 }
diff -u --recursive --new-file linux-2.5.46-04-radix_tree/fs/nfs/read.c linux-2.5.46-05-mempool/fs/nfs/read.c
--- linux-2.5.46-04-radix_tree/fs/nfs/read.c	2002-11-07 12:33:01.000000000 -0500
+++ linux-2.5.46-05-mempool/fs/nfs/read.c	2002-11-08 15:40:48.000000000 -0500
@@ -24,6 +24,7 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/pagemap.h>
+#include <linux/mempool.h>
 #include <linux/sunrpc/clnt.h>
 #include <linux/nfs_fs.h>
 #include <linux/nfs_page.h>
@@ -37,11 +38,14 @@
 static int nfs_pagein_one(struct list_head *, struct inode *);
 
 static kmem_cache_t *nfs_rdata_cachep;
+static mempool_t *nfs_rdata_mempool;
+
+#define MIN_POOL_READ	(32)
 
 static __inline__ struct nfs_read_data *nfs_readdata_alloc(void)
 {
 	struct nfs_read_data   *p;
-	p = kmem_cache_alloc(nfs_rdata_cachep, SLAB_NOFS);
+	p = (struct nfs_read_data *)mempool_alloc(nfs_rdata_mempool, SLAB_NOFS);
 	if (p) {
 		memset(p, 0, sizeof(*p));
 		INIT_LIST_HEAD(&p->pages);
@@ -51,7 +55,7 @@
 
 static __inline__ void nfs_readdata_free(struct nfs_read_data *p)
 {
-	kmem_cache_free(nfs_rdata_cachep, p);
+	mempool_free(p, nfs_rdata_mempool);
 }
 
 void nfs_readdata_release(struct rpc_task *task)
@@ -417,11 +421,19 @@
 	if (nfs_rdata_cachep == NULL)
 		return -ENOMEM;
 
+	nfs_rdata_mempool = mempool_create(MIN_POOL_READ,
+					   mempool_alloc_slab,
+					   mempool_free_slab,
+					   nfs_rdata_cachep);
+	if (nfs_rdata_mempool == NULL)
+		return -ENOMEM;
+
 	return 0;
 }
 
 void nfs_destroy_readpagecache(void)
 {
+	mempool_destroy(nfs_rdata_mempool);
 	if (kmem_cache_destroy(nfs_rdata_cachep))
 		printk(KERN_INFO "nfs_read_data: not all structures were freed\n");
 }
diff -u --recursive --new-file linux-2.5.46-04-radix_tree/fs/nfs/write.c linux-2.5.46-05-mempool/fs/nfs/write.c
--- linux-2.5.46-04-radix_tree/fs/nfs/write.c	2002-11-08 14:21:21.000000000 -0500
+++ linux-2.5.46-05-mempool/fs/nfs/write.c	2002-11-08 15:40:48.000000000 -0500
@@ -62,9 +62,13 @@
 #include <linux/nfs_page.h>
 #include <asm/uaccess.h>
 #include <linux/smp_lock.h>
+#include <linux/mempool.h>
 
 #define NFSDBG_FACILITY		NFSDBG_PAGECACHE
 
+#define MIN_POOL_WRITE		(32)
+#define MIN_POOL_COMMIT		(4)
+
 /*
  * Local function declarations
  */
@@ -74,11 +78,13 @@
 static void	nfs_strategy(struct inode *inode);
 
 static kmem_cache_t *nfs_wdata_cachep;
+static mempool_t *nfs_wdata_mempool;
+static mempool_t *nfs_commit_mempool;
 
 static __inline__ struct nfs_write_data *nfs_writedata_alloc(void)
 {
 	struct nfs_write_data	*p;
-	p = kmem_cache_alloc(nfs_wdata_cachep, SLAB_NOFS);
+	p = (struct nfs_write_data *)mempool_alloc(nfs_wdata_mempool, SLAB_NOFS);
 	if (p) {
 		memset(p, 0, sizeof(*p));
 		INIT_LIST_HEAD(&p->pages);
@@ -88,7 +94,7 @@
 
 static __inline__ void nfs_writedata_free(struct nfs_write_data *p)
 {
-	kmem_cache_free(nfs_wdata_cachep, p);
+	mempool_free(p, nfs_wdata_mempool);
 }
 
 void nfs_writedata_release(struct rpc_task *task)
@@ -97,6 +103,28 @@
 	nfs_writedata_free(wdata);
 }
 
+static __inline__ struct nfs_write_data *nfs_commit_alloc(void)
+{
+	struct nfs_write_data	*p;
+	p = (struct nfs_write_data *)mempool_alloc(nfs_commit_mempool, SLAB_NOFS);
+	if (p) {
+		memset(p, 0, sizeof(*p));
+		INIT_LIST_HEAD(&p->pages);
+	}
+	return p;
+}
+
+static __inline__ void nfs_commit_free(struct nfs_write_data *p)
+{
+	mempool_free(p, nfs_commit_mempool);
+}
+
+void nfs_commit_release(struct rpc_task *task)
+{
+	struct nfs_write_data	*wdata = (struct nfs_write_data *)task->tk_calldata;
+	nfs_commit_free(wdata);
+}
+
 /*
  * This function will be used to simulate weak cache consistency
  * under NFSv2 when the NFSv3 attribute patch is included.
@@ -1093,7 +1121,7 @@
 	struct nfs_page         *req;
 	sigset_t		oldset;
 
-	data = nfs_writedata_alloc();
+	data = nfs_commit_alloc();
 
 	if (!data)
 		goto out_bad;
@@ -1237,11 +1265,27 @@
 	if (nfs_wdata_cachep == NULL)
 		return -ENOMEM;
 
+	nfs_wdata_mempool = mempool_create(MIN_POOL_WRITE,
+					   mempool_alloc_slab,
+					   mempool_free_slab,
+					   nfs_wdata_cachep);
+	if (nfs_wdata_mempool == NULL)
+		return -ENOMEM;
+
+	nfs_commit_mempool = mempool_create(MIN_POOL_COMMIT,
+					   mempool_alloc_slab,
+					   mempool_free_slab,
+					   nfs_wdata_cachep);
+	if (nfs_commit_mempool == NULL)
+		return -ENOMEM;
+
 	return 0;
 }
 
 void nfs_destroy_writepagecache(void)
 {
+	mempool_destroy(nfs_commit_mempool);
+	mempool_destroy(nfs_wdata_mempool);
 	if (kmem_cache_destroy(nfs_wdata_cachep))
 		printk(KERN_INFO "nfs_write_data: not all structures were freed\n");
 }
diff -u --recursive --new-file linux-2.5.46-04-radix_tree/include/linux/nfs_fs.h linux-2.5.46-05-mempool/include/linux/nfs_fs.h
--- linux-2.5.46-04-radix_tree/include/linux/nfs_fs.h	2002-11-08 14:21:21.000000000 -0500
+++ linux-2.5.46-05-mempool/include/linux/nfs_fs.h	2002-11-08 15:42:57.000000000 -0500
@@ -327,6 +327,7 @@
 extern void nfs_writedata_release(struct rpc_task *task);
 
 #if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
+extern void nfs_commit_release(struct rpc_task *task);
 extern void nfs_commit_done(struct rpc_task *);
 #endif
 
