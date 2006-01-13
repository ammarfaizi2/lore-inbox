Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161449AbWAMHDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161449AbWAMHDL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 02:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161480AbWAMHDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 02:03:11 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:48109 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1161449AbWAMHDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 02:03:09 -0500
Date: Fri, 13 Jan 2006 09:03:03 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, vandrove@vc.cvut.cz
Subject: [PATCH]: ncpfs: remove kmalloc wrapper
Message-ID: <Pine.LNX.4.58.0601130901570.17253@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch removes remaining kmalloc wrapper bits from fs/ncpfs/.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 fs/ncpfs/inode.c       |   17 ++---------------
 fs/ncpfs/ioctl.c       |   20 +++++++++++---------
 include/linux/ncp_fs.h |   28 ----------------------------
 3 files changed, 13 insertions(+), 52 deletions(-)

Index: 2.6/include/linux/ncp_fs.h
===================================================================
--- 2.6.orig/include/linux/ncp_fs.h
+++ 2.6/include/linux/ncp_fs.h
@@ -201,34 +201,6 @@ static inline struct ncp_inode_info *NCP
 	return container_of(inode, struct ncp_inode_info, vfs_inode);
 }
 
-#ifdef DEBUG_NCP_MALLOC
-
-#include <linux/slab.h>
-
-extern int ncp_malloced;
-extern int ncp_current_malloced;
-
-static inline void *
- ncp_kmalloc(unsigned int size, int priority)
-{
-	ncp_malloced += 1;
-	ncp_current_malloced += 1;
-	return kmalloc(size, priority);
-}
-
-static inline void ncp_kfree_s(void *obj, int size)
-{
-	ncp_current_malloced -= 1;
-	kfree(obj);
-}
-
-#else				/* DEBUG_NCP_MALLOC */
-
-#define ncp_kmalloc(s,p) kmalloc(s,p)
-#define ncp_kfree_s(o,s) kfree(o)
-
-#endif				/* DEBUG_NCP_MALLOC */
-
 /* linux/fs/ncpfs/inode.c */
 int ncp_notify_change(struct dentry *, struct iattr *);
 struct inode *ncp_iget(struct super_block *, struct ncp_entry_info *);
Index: 2.6/fs/ncpfs/inode.c
===================================================================
--- 2.6.orig/fs/ncpfs/inode.c
+++ 2.6/fs/ncpfs/inode.c
@@ -716,10 +716,8 @@ static void ncp_put_super(struct super_b
 	fput(server->ncp_filp);
 	kill_proc(server->m.wdog_pid, SIGTERM, 1);
 
-	if (server->priv.data) 
-		ncp_kfree_s(server->priv.data, server->priv.len);
-	if (server->auth.object_name)
-		ncp_kfree_s(server->auth.object_name, server->auth.object_name_len);
+	kfree(server->priv.data);
+	kfree(server->auth.object_name);
 	vfree(server->packet);
 	sb->s_fs_info = NULL;
 	kfree(server);
@@ -958,11 +956,6 @@ out:
 	return result;
 }
 
-#ifdef DEBUG_NCP_MALLOC
-int ncp_malloced;
-int ncp_current_malloced;
-#endif
-
 static struct super_block *ncp_get_sb(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data)
 {
@@ -981,10 +974,6 @@ static int __init init_ncp_fs(void)
 	int err;
 	DPRINTK("ncpfs: init_module called\n");
 
-#ifdef DEBUG_NCP_MALLOC
-	ncp_malloced = 0;
-	ncp_current_malloced = 0;
-#endif
 	err = init_inodecache();
 	if (err)
 		goto out1;
@@ -1003,10 +992,6 @@ static void __exit exit_ncp_fs(void)
 	DPRINTK("ncpfs: cleanup_module called\n");
 	unregister_filesystem(&ncp_fs_type);
 	destroy_inodecache();
-#ifdef DEBUG_NCP_MALLOC
-	PRINTK("ncp_malloced: %d\n", ncp_malloced);
-	PRINTK("ncp_current_malloced: %d\n", ncp_current_malloced);
-#endif
 }
 
 module_init(init_ncp_fs)
Index: 2.6/fs/ncpfs/ioctl.c
===================================================================
--- 2.6.orig/fs/ncpfs/ioctl.c
+++ 2.6/fs/ncpfs/ioctl.c
@@ -517,10 +517,11 @@ outrel:			
 			if (user.object_name_len > NCP_OBJECT_NAME_MAX_LEN)
 				return -ENOMEM;
 			if (user.object_name_len) {
-				newname = ncp_kmalloc(user.object_name_len, GFP_USER);
-				if (!newname) return -ENOMEM;
+				newname = kmalloc(user.object_name_len, GFP_USER);
+				if (!newname)
+					return -ENOMEM;
 				if (copy_from_user(newname, user.object_name, user.object_name_len)) {
-					ncp_kfree_s(newname, user.object_name_len);
+					kfree(newname);
 					return -EFAULT;
 				}
 			} else {
@@ -539,8 +540,8 @@ outrel:			
 			server->priv.len = 0;
 			server->priv.data = NULL;
 			/* leave critical section */
-			if (oldprivate) ncp_kfree_s(oldprivate, oldprivatelen);
-			if (oldname) ncp_kfree_s(oldname, oldnamelen);
+			kfree(oldprivate);
+			kfree(oldname);
 			return 0;
 		}
 	case NCP_IOC_GETPRIVATEDATA:
@@ -580,10 +581,11 @@ outrel:			
 			if (user.len > NCP_PRIVATE_DATA_MAX_LEN)
 				return -ENOMEM;
 			if (user.len) {
-				new = ncp_kmalloc(user.len, GFP_USER);
-				if (!new) return -ENOMEM;
+				new = kmalloc(user.len, GFP_USER);
+				if (!new)
+					return -ENOMEM;
 				if (copy_from_user(new, user.data, user.len)) {
-					ncp_kfree_s(new, user.len);
+					kfree(new);
 					return -EFAULT;
 				}
 			} else {
@@ -595,7 +597,7 @@ outrel:			
 			server->priv.len = user.len;
 			server->priv.data = new;
 			/* leave critical section */
-			if (old) ncp_kfree_s(old, oldlen);
+			kfree(old);
 			return 0;
 		}
 
