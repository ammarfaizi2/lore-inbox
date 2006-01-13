Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161481AbWAMHEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161481AbWAMHEs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 02:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161483AbWAMHEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 02:04:48 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:51437 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1161481AbWAMHEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 02:04:47 -0500
Date: Fri, 13 Jan 2006 09:04:41 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, urban@teststation.com
Subject: [PATCH] smbfs: remove kmalloc wrapper
Message-ID: <Pine.LNX.4.58.0601130903100.17253@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch remove the remaining kmalloc() wrapper bits from fs/smbfs/.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 fs/smbfs/Makefile      |    1 -
 fs/smbfs/inode.c       |   32 +++++++-------------------------
 fs/smbfs/request.c     |   13 +++++--------
 include/linux/smb_fs.h |   47 -----------------------------------------------
 4 files changed, 12 insertions(+), 81 deletions(-)

Index: 2.6/fs/smbfs/Makefile
===================================================================
--- 2.6.orig/fs/smbfs/Makefile
+++ 2.6/fs/smbfs/Makefile
@@ -13,7 +13,6 @@ smbfs-objs := proc.o dir.o cache.o sock.
 EXTRA_CFLAGS += -DSMBFS_PARANOIA
 #EXTRA_CFLAGS += -DSMBFS_DEBUG
 #EXTRA_CFLAGS += -DSMBFS_DEBUG_VERBOSE
-#EXTRA_CFLAGS += -DDEBUG_SMB_MALLOC
 #EXTRA_CFLAGS += -DDEBUG_SMB_TIMESTAMP
 #EXTRA_CFLAGS += -Werror
 
Index: 2.6/fs/smbfs/inode.c
===================================================================
--- 2.6.orig/fs/smbfs/inode.c
+++ 2.6/fs/smbfs/inode.c
@@ -487,11 +487,11 @@ smb_put_super(struct super_block *sb)
 	if (server->conn_pid)
 		kill_proc(server->conn_pid, SIGTERM, 1);
 
-	smb_kfree(server->ops);
+	kfree(server->ops);
 	smb_unload_nls(server);
 	sb->s_fs_info = NULL;
 	smb_unlock_server(server);
-	smb_kfree(server);
+	kfree(server);
 }
 
 static int smb_fill_super(struct super_block *sb, void *raw_data, int silent)
@@ -519,11 +519,10 @@ static int smb_fill_super(struct super_b
 	sb->s_op = &smb_sops;
 	sb->s_time_gran = 100;
 
-	server = smb_kmalloc(sizeof(struct smb_sb_info), GFP_KERNEL);
+	server = kzalloc(sizeof(struct smb_sb_info), GFP_KERNEL);
 	if (!server)
 		goto out_no_server;
 	sb->s_fs_info = server;
-	memset(server, 0, sizeof(struct smb_sb_info));
 
 	server->super_block = sb;
 	server->mnt = NULL;
@@ -542,8 +541,8 @@ static int smb_fill_super(struct super_b
 	/* FIXME: move these to the smb_sb_info struct */
 	VERBOSE("alloc chunk = %d\n", sizeof(struct smb_ops) +
 		sizeof(struct smb_mount_data_kernel));
-	mem = smb_kmalloc(sizeof(struct smb_ops) +
-			  sizeof(struct smb_mount_data_kernel), GFP_KERNEL);
+	mem = kmalloc(sizeof(struct smb_ops) +
+		      sizeof(struct smb_mount_data_kernel), GFP_KERNEL);
 	if (!mem)
 		goto out_no_mem;
 
@@ -621,12 +620,12 @@ out_no_root:
 out_no_smbiod:
 	smb_unload_nls(server);
 out_bad_option:
-	smb_kfree(mem);
+	kfree(mem);
 out_no_mem:
 	if (!server->mnt)
 		printk(KERN_ERR "smb_fill_super: allocation failure\n");
 	sb->s_fs_info = NULL;
-	smb_kfree(server);
+	kfree(server);
 	goto out_fail;
 out_wrong_data:
 	printk(KERN_ERR "smbfs: mount_data version %d is not supported\n", ver);
@@ -782,12 +781,6 @@ out:
 	return error;
 }
 
-#ifdef DEBUG_SMB_MALLOC
-int smb_malloced;
-int smb_current_kmalloced;
-int smb_current_vmalloced;
-#endif
-
 static struct super_block *smb_get_sb(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data)
 {
@@ -807,12 +800,6 @@ static int __init init_smb_fs(void)
 	int err;
 	DEBUG1("registering ...\n");
 
-#ifdef DEBUG_SMB_MALLOC
-	smb_malloced = 0;
-	smb_current_kmalloced = 0;
-	smb_current_vmalloced = 0;
-#endif
-
 	err = init_inodecache();
 	if (err)
 		goto out_inode;
@@ -837,11 +824,6 @@ static void __exit exit_smb_fs(void)
 	unregister_filesystem(&smb_fs_type);
 	smb_destroy_request_cache();
 	destroy_inodecache();
-#ifdef DEBUG_SMB_MALLOC
-	printk(KERN_DEBUG "smb_malloced: %d\n", smb_malloced);
-	printk(KERN_DEBUG "smb_current_kmalloced: %d\n",smb_current_kmalloced);
-	printk(KERN_DEBUG "smb_current_vmalloced: %d\n",smb_current_vmalloced);
-#endif
 }
 
 module_init(init_smb_fs)
Index: 2.6/fs/smbfs/request.c
===================================================================
--- 2.6.orig/fs/smbfs/request.c
+++ 2.6/fs/smbfs/request.c
@@ -68,7 +68,7 @@ static struct smb_request *smb_do_alloc_
 		goto out;
 
 	if (bufsize > 0) {
-		buf = smb_kmalloc(bufsize, GFP_NOFS);
+		buf = kmalloc(bufsize, GFP_NOFS);
 		if (!buf) {
 			kmem_cache_free(req_cachep, req);
 			return NULL;
@@ -124,9 +124,8 @@ static void smb_free_request(struct smb_
 {
 	atomic_dec(&req->rq_server->nr_requests);
 	if (req->rq_buffer && !(req->rq_flags & SMB_REQ_STATIC))
-		smb_kfree(req->rq_buffer);
-	if (req->rq_trans2buffer)
-		smb_kfree(req->rq_trans2buffer);
+		kfree(req->rq_buffer);
+	kfree(req->rq_trans2buffer);
 	kmem_cache_free(req_cachep, req);
 }
 
@@ -183,8 +182,7 @@ static int smb_setup_request(struct smb_
 	req->rq_err = 0;
 	req->rq_errno = 0;
 	req->rq_fragment = 0;
-	if (req->rq_trans2buffer)
-		smb_kfree(req->rq_trans2buffer);
+	kfree(req->rq_trans2buffer);
 
 	return 0;
 }
@@ -647,10 +645,9 @@ static int smb_recv_trans2(struct smb_sb
 			goto out_too_long;
 
 		req->rq_trans2bufsize = buf_len;
-		req->rq_trans2buffer = smb_kmalloc(buf_len, GFP_NOFS);
+		req->rq_trans2buffer = kzalloc(buf_len, GFP_NOFS);
 		if (!req->rq_trans2buffer)
 			goto out_no_mem;
-		memset(req->rq_trans2buffer, 0, buf_len);
 
 		req->rq_parm = req->rq_trans2buffer;
 		req->rq_data = req->rq_trans2buffer + parm_tot;
Index: 2.6/include/linux/smb_fs.h
===================================================================
--- 2.6.orig/include/linux/smb_fs.h
+++ 2.6/include/linux/smb_fs.h
@@ -58,53 +58,6 @@ static inline struct smb_inode_info *SMB
 /* where to find the base of the SMB packet proper */
 #define smb_base(buf) ((u8 *)(((u8 *)(buf))+4))
 
-#ifdef DEBUG_SMB_MALLOC
-
-#include <linux/slab.h>
-
-extern int smb_malloced;
-extern int smb_current_vmalloced;
-extern int smb_current_kmalloced;
-
-static inline void *
-smb_vmalloc(unsigned int size)
-{
-        smb_malloced += 1;
-        smb_current_vmalloced += 1;
-        return vmalloc(size);
-}
-
-static inline void
-smb_vfree(void *obj)
-{
-        smb_current_vmalloced -= 1;
-        vfree(obj);
-}
-
-static inline void *
-smb_kmalloc(size_t size, int flags)
-{
-	smb_malloced += 1;
-	smb_current_kmalloced += 1;
-	return kmalloc(size, flags);
-}
-
-static inline void
-smb_kfree(void *obj)
-{
-	smb_current_kmalloced -= 1;
-	kfree(obj);
-}
-
-#else /* DEBUG_SMB_MALLOC */
-
-#define smb_kmalloc(s,p)	kmalloc(s,p)
-#define smb_kfree(o)		kfree(o)
-#define smb_vmalloc(s)		vmalloc(s)
-#define smb_vfree(o)		vfree(o)
-
-#endif /* DEBUG_SMB_MALLOC */
-
 /*
  * Flags for the in-memory inode
  */
