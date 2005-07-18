Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbVGRHMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVGRHMH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 03:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbVGRHK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 03:10:28 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:37768 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261574AbVGRHHQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 03:07:16 -0400
Message-Id: <20050718070702.299756000@localhost>
References: <20050718065311.210001000@localhost>
Date: Sun, 17 Jul 2005 23:53:19 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       mike@waychison.com, Miklos Szeredi <miklos@szeredi.hu>,
       bfields@fieldses.org, Andrew Morton <akpm@osdl.org>,
       penberg@cs.helsinki.fi
Subject: [RFC-2 PATCH 8/8] shared subtree
Content-Type: text/x-patch; name=pnode_opt.patch
Content-Disposition: inline; filename=pnode_opt.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	code Optimization for pnode.c


 fs/pnode.c |  478 ++++++++++++++++++++++++++++---------------------------------
 1 files changed, 224 insertions(+), 254 deletions(-)

Index: 2.6.12.work1/fs/pnode.c
===================================================================
--- 2.6.12.work1.orig/fs/pnode.c
+++ 2.6.12.work1/fs/pnode.c
@@ -26,6 +26,7 @@
 #include <asm/unistd.h>
 #include <stdarg.h>
 
+
 enum pnode_vfs_type {
 	PNODE_MEMBER_VFS = 0x01,
 	PNODE_SLAVE_VFS = 0x02
@@ -34,7 +35,7 @@ enum pnode_vfs_type {
 static kmem_cache_t * pnode_cachep;
 
 /* spinlock for pnode related operations */
-  __cacheline_aligned_in_smp DEFINE_SPINLOCK(vfspnode_lock);
+__cacheline_aligned_in_smp DEFINE_SPINLOCK(vfspnode_lock);
 
 
 void __init pnode_init(unsigned long mempages)
@@ -58,7 +59,7 @@ struct vfspnode * pnode_alloc(void)
 	return pnode;
 }
 
-void pnode_free(struct vfspnode *pnode)
+void inline pnode_free(struct vfspnode *pnode)
 {
 	kmem_cache_free(pnode_cachep, pnode);
 }
@@ -147,7 +148,6 @@ static int pnode_next(struct pcontext *c
 	return 1;
 }
 
-
 static void inline pnode_add_mnt(struct vfspnode *pnode,
 		struct vfsmount *mnt, int slave)
 {
@@ -180,6 +180,111 @@ void pnode_add_slave_mnt(struct vfspnode
 	pnode_add_mnt(pnode, mnt, 1);
 }
 
+/*
+ * traverse the pnode tree and at each pnode encountered, execute the
+ * pnode_fnc(). For each vfsmount encountered call the vfs_fnc().
+ *
+ * @pnode: pnode tree to be traversed
+ * @in_data: input data
+ * @out_data: output data
+ * @pnode_func: function to be called when a new pnode is encountered.
+ * @vfs_func: function to be called on each slave and member vfs belonging
+ * 		to the pnode.
+ */
+static int pnode_traverse(struct vfspnode *pnode,
+		void *in_data,
+		void **out_data,
+		int (*pnode_pre_func)(struct vfspnode *,
+			void *, void **, va_list),
+		int (*pnode_post_func)(struct vfspnode *,
+			void *, va_list),
+		int (*vfs_func)(struct vfsmount *,
+			enum pnode_vfs_type, void *,  va_list),
+		...)
+{
+	va_list args;
+	int ret = 0, level;
+	void *my_data, *data_from_master;
+     	struct vfspnode *master_pnode;
+     	struct vfsmount *slave_mnt, *member_mnt, *t_m;
+	struct pcontext context;
+	static void *p_array[PNODE_MAX_SLAVE_LEVEL];
+
+	context.start = pnode;
+	context.pnode = NULL;
+	/*
+	 * determine whether to process vfs first or the
+	 * slave pnode first
+	 */
+	while (pnode_next(&context)) {
+		level = context.level;
+		pnode = context.pnode;
+		master_pnode = context.master_pnode;
+
+		if (master_pnode) {
+			data_from_master = p_array[level-1];
+			my_data = NULL;
+		} else {
+			data_from_master = NULL;
+			my_data = in_data;
+		}
+
+		if (pnode_pre_func) {
+			va_start(args, vfs_func);
+			if((ret = pnode_pre_func(pnode,
+				data_from_master, &my_data, args)))
+				goto error;
+			va_end(args);
+		}
+
+		// traverse member vfsmounts
+		spin_lock(&vfspnode_lock);
+		list_for_each_entry_safe(member_mnt,
+			t_m, &pnode->pnode_vfs, mnt_pnode_mntlist) {
+
+			spin_unlock(&vfspnode_lock);
+			va_start(args, vfs_func);
+			if ((ret = vfs_func(member_mnt,
+				PNODE_MEMBER_VFS, my_data, args)))
+				goto error;
+			va_end(args);
+			spin_lock(&vfspnode_lock);
+		}
+		list_for_each_entry_safe(slave_mnt, t_m,
+			&pnode->pnode_slavevfs, mnt_pnode_mntlist) {
+
+			spin_unlock(&vfspnode_lock);
+			va_start(args, vfs_func);
+			if ((ret = vfs_func(slave_mnt, PNODE_SLAVE_VFS,
+				my_data, args)))
+				goto error;
+			va_end(args);
+			spin_lock(&vfspnode_lock);
+		}
+		spin_unlock(&vfspnode_lock);
+
+		if (pnode_post_func) {
+			va_start(args, vfs_func);
+			if((ret = pnode_post_func(pnode,
+				my_data, args)))
+				goto error;
+			va_end(args);
+		}
+
+		p_array[level] = my_data;
+	}
+out:
+	if (out_data)
+		*out_data = p_array[0];
+	return ret;
+error:
+	va_end(args);
+	if (out_data)
+		*out_data = NULL;
+	goto out;
+}
+
+
 void pnode_add_slave_pnode(struct vfspnode *pnode,
 		struct vfspnode *slave_pnode)
 {
@@ -219,6 +324,7 @@ void pnode_del_member_mnt(struct vfsmoun
 	CLEAR_MNT_SHARED(mnt);
 }
 
+
 void pnode_disassociate_mnt(struct vfsmount *mnt)
 {
 	if (!mnt)
@@ -228,6 +334,7 @@ void pnode_disassociate_mnt(struct vfsmo
 	CLEAR_MNT_SLAVE(mnt);
 }
 
+
 // merge pnode into peer_pnode and get rid of pnode
 int pnode_merge_pnode(struct vfspnode *pnode, struct vfspnode *peer_pnode)
 {
@@ -268,15 +375,18 @@ int pnode_merge_pnode(struct vfspnode *p
 	 * with some cost.
 	 */
 	for (i=0 ; i <count; i++)
-		put_pnode_unlocked(pnode);
+		put_pnode_locked(pnode);
 	spin_unlock(&vfspnode_lock);
 	return 0;
 }
 
-static int vfs_busy(struct vfsmount *mnt, struct dentry *dentry,
-		struct dentry *rootdentry, struct vfsmount *origmnt,
-		int refcnt)
+static int vfs_busy(struct vfsmount *mnt, enum pnode_vfs_type flag,
+		void *indata, va_list args)
 {
+	struct dentry *dentry = va_arg(args, struct dentry *);
+	struct dentry *rootdentry = va_arg(args, struct dentry *);
+	struct vfsmount *origmnt = va_arg(args, struct vfsmount *);
+	int    refcnt = va_arg(args, int);
 	struct vfsmount *child_mnt;
 	int ret=0;
 
@@ -290,7 +400,7 @@ static int vfs_busy(struct vfsmount *mnt
 	if (list_empty(&child_mnt->mnt_mounts)) {
 		if (origmnt == child_mnt)
 			ret = do_refcount_check(child_mnt, refcnt+1);
-  		else
+		else
 			ret = do_refcount_check(child_mnt, refcnt);
 	}
 	mntput(child_mnt);
@@ -300,52 +410,32 @@ static int vfs_busy(struct vfsmount *mnt
 int pnode_mount_busy(struct vfspnode *pnode, struct dentry *mntpt,
 		struct dentry *root, struct vfsmount *mnt, int refcnt)
 {
-	int ret=0;
-     	struct vfsmount *slave_mnt, *member_mnt, *t_m;
-	struct pcontext context;
-
-	context.start = pnode;
-	context.pnode = NULL;
-	while (pnode_next(&context)) {
-		pnode = context.pnode;
-
-		// traverse member vfsmounts
-		spin_lock(&vfspnode_lock);
-		list_for_each_entry_safe(member_mnt,
-			t_m, &pnode->pnode_vfs, mnt_pnode_mntlist) {
-			spin_unlock(&vfspnode_lock);
-			if ((ret = vfs_busy(member_mnt, mntpt,
-					root, mnt)))
-				goto out;
-			spin_lock(&vfspnode_lock);
-		}
-		list_for_each_entry_safe(slave_mnt, t_m,
-			&pnode->pnode_slavevfs, mnt_pnode_mntlist) {
-			spin_unlock(&vfspnode_lock);
-			if ((ret = vfs_busy(slave_mnt, mntpt,
-					root, mnt)))
-				goto out;
-			spin_lock(&vfspnode_lock);
-		}
-		spin_unlock(&vfspnode_lock);
-	}
-out:
-	return ret;
+	return pnode_traverse(pnode, NULL, NULL,
+			NULL, NULL, vfs_busy, mntpt, root, mnt, refcnt);
 }
 
-int vfs_umount(struct vfsmount *mnt, struct dentry *dentry,
-		struct dentry *rootdentry)
+
+int vfs_umount(struct vfsmount *mnt, enum pnode_vfs_type flag,
+		void *indata, va_list args)
 {
 	struct vfsmount *child_mnt;
+	struct dentry *dentry, *rootdentry;
+
+
+	dentry = va_arg(args, struct dentry *);
+	rootdentry = va_arg(args, struct dentry *);
 
 	spin_unlock(&vfsmount_lock);
 	child_mnt = __lookup_mnt(mnt, dentry, rootdentry);
 	spin_lock(&vfsmount_lock);
 	mntput(child_mnt);
 	if (child_mnt && list_empty(&child_mnt->mnt_mounts)) {
-		do_detach_mount(child_mnt);
-		if (child_mnt->mnt_pnode)
+		if (IS_MNT_SHARED(child_mnt) ||
+				IS_MNT_SLAVE(child_mnt)) {
+			BUG_ON(!child_mnt->mnt_pnode);
 			pnode_disassociate_mnt(child_mnt);
+		}
+		do_detach_mount(child_mnt);
 	}
 	return 0;
 }
@@ -353,34 +443,54 @@ int vfs_umount(struct vfsmount *mnt, str
 int pnode_umount(struct vfspnode *pnode, struct dentry *dentry,
 			struct dentry *rootdentry)
 {
+	return pnode_traverse(pnode, NULL, (void *)NULL,
+			NULL, NULL, vfs_umount, dentry, rootdentry);
+}
+
+
+int pnode_mount_func(struct vfspnode *pnode, void *indata,
+		void **outdata, va_list args)
+{
+	struct vfspnode *pnode_slave, *pnode_master;
 	int ret=0;
-     	struct vfsmount *slave_mnt, *member_mnt, *t_m;
-	struct pcontext context;
 
-	context.start = pnode;
-	context.pnode = NULL;
-	while (pnode_next(&context)) {
-		pnode = context.pnode;
-		// traverse member vfsmounts
-		spin_lock(&vfspnode_lock);
-		list_for_each_entry_safe(member_mnt,
-			t_m, &pnode->pnode_vfs, mnt_pnode_mntlist) {
-			spin_unlock(&vfspnode_lock);
-			if ((ret = vfs_umount(member_mnt,
-					dentry, rootdentry)))
-				goto out;
-			spin_lock(&vfspnode_lock);
-		}
-		list_for_each_entry_safe(slave_mnt, t_m,
-			&pnode->pnode_slavevfs, mnt_pnode_mntlist) {
-			spin_unlock(&vfspnode_lock);
-			if ((ret = vfs_umount(slave_mnt,
-					dentry, rootdentry)))
-				goto out;
-			spin_lock(&vfspnode_lock);
-		}
-		spin_unlock(&vfspnode_lock);
+	pnode_master = indata;
+
+	if (*outdata)
+		pnode_slave = *outdata;
+	else if (!(pnode_slave = pnode_alloc()))
+		return -ENOMEM;
+
+	*outdata = pnode_slave;
+
+	if (pnode_slave && pnode_master)
+		pnode_add_slave_pnode(pnode_master, pnode_slave);
+	return ret;
+}
+
+int vfs_make_mounted_func(struct vfsmount *mnt, enum pnode_vfs_type flag,
+		void *indata, va_list args)
+{
+	struct dentry *target_dentry;
+	int ret=0;
+	struct vfsmount *child_mount;
+	struct vfspnode *pnode;
+
+	target_dentry = va_arg(args, struct dentry *);
+	if (!(child_mount = do_make_mounted(mnt, target_dentry))) {
+		ret = -ENOMEM;
+		goto out;
 	}
+	pnode = (struct vfspnode *)indata;
+	switch (flag) {
+	case PNODE_SLAVE_VFS :
+		pnode_add_slave_mnt(pnode, child_mount);
+		break;
+	case PNODE_MEMBER_VFS :
+		pnode_add_member_mnt(pnode, child_mount);
+		break;
+	}
+
 out:
 	return ret;
 }
@@ -399,72 +509,17 @@ struct vfsmount *pnode_make_mounted(stru
 		struct vfsmount *mnt, struct dentry *dentry)
 {
 	struct vfsmount *child_mnt;
-	int ret=0, level;
-   	struct vfspnode *master_pnode;
-	struct vfspnode *child_pnode, *master_child_pnode;
-    	struct vfsmount *slave_mnt, *member_mnt, *t_m;
-	struct pcontext context;
-	static struct vfspnode *p_array[PNODE_MAX_SLAVE_LEVEL];
-
-	context.start = pnode;
-	context.pnode = NULL;
-
-	while (pnode_next(&context)) {
-		level = context.level;
-		pnode = context.pnode;
-		master_pnode = context.master_pnode;
-
-		if (master_pnode)
-			master_child_pnode = p_array[level-1];
-		else
-			master_child_pnode = NULL;
-
-		if (!(child_pnode = pnode_alloc())) {
-			ret = -ENOMEM;
-			goto out;
-		}
-
-		if (child_pnode && master_child_pnode)
-			pnode_add_slave_pnode(master_child_pnode,
-					child_pnode);
-
-		p_array[level] = child_pnode;
-
-		spin_lock(&vfspnode_lock);
-		list_for_each_entry_safe(member_mnt,
-			t_m, &pnode->pnode_vfs, mnt_pnode_mntlist) {
-			spin_unlock(&vfspnode_lock);
-			if (!(child_mnt = do_make_mounted(member_mnt,
-					dentry))) {
-				ret = -ENOMEM;
-				goto out;
-			}
-			spin_lock(&vfspnode_lock);
-			pnode_add_member_mnt(child_pnode, child_mnt);
-		}
-		list_for_each_entry_safe(slave_mnt, t_m,
-			&pnode->pnode_slavevfs, mnt_pnode_mntlist) {
-			spin_unlock(&vfspnode_lock);
-			if (!(child_mnt = do_make_mounted(slave_mnt,
-					dentry))) {
-				ret = -ENOMEM;
-				goto out;
-			}
-			spin_lock(&vfspnode_lock);
-			pnode_add_slave_mnt(child_pnode, child_mnt);
-		}
-		spin_unlock(&vfspnode_lock);
-	}
-out:
-	if (ret)
-		return NULL;
+	if(pnode_traverse(pnode, NULL, (void *)NULL,
+			pnode_mount_func, NULL, vfs_make_mounted_func,
+			(void *)dentry))
+  		return NULL;
 
 	child_mnt = __lookup_mnt(mnt, dentry, dentry);
 	mntput(child_mnt);
 	return child_mnt;
 }
 
-int vfs_make_unmounted(struct vfsmount *mnt)
+int vfs_make_unmounted_func(struct vfsmount *mnt)
 {
 	struct vfspnode *pnode;
 	int ret=0;
@@ -473,58 +528,36 @@ int vfs_make_unmounted(struct vfsmount *
 		ret = 1;
 		goto out;
 	}
+
 	pnode = mnt->mnt_pnode;
+	spin_lock(&vfspnode_lock);
 	list_del_init(&mnt->mnt_pnode_mntlist);
-	put_pnode(pnode);
+	put_pnode_locked(pnode);
+	spin_unlock(&vfspnode_lock);
 out:
 	return ret;
 }
 
 int pnode_make_unmounted(struct vfspnode *pnode)
 {
-	int ret=0;
-     	struct vfsmount *slave_mnt, *member_mnt, *t_m;
-	struct pcontext context;
-
-	context.start = pnode;
-	context.pnode = NULL;
-	while (pnode_next(&context)) {
-		pnode = context.pnode;
-		// traverse member vfsmounts
-		spin_lock(&vfspnode_lock);
-		list_for_each_entry_safe(member_mnt,
-			t_m, &pnode->pnode_vfs, mnt_pnode_mntlist) {
-			spin_unlock(&vfspnode_lock);
-			if ((ret = vfs_make_unmounted(member_mnt)))
-				goto out;
-			spin_lock(&vfspnode_lock);
-		}
-		list_for_each_entry_safe(slave_mnt, t_m,
-			&pnode->pnode_slavevfs, mnt_pnode_mntlist) {
-			spin_unlock(&vfspnode_lock);
-			if ((ret = vfs_make_unmounted(slave_mnt)))
-				goto out;
-			spin_lock(&vfspnode_lock);
-		}
-		spin_unlock(&vfspnode_lock);
-	}
-out:
-	return ret;
+	return pnode_traverse(pnode, NULL, (void *)NULL,
+			NULL, NULL, vfs_make_unmounted_func);
 }
 
 int vfs_prepare_mount_func(struct vfsmount *mnt, enum pnode_vfs_type flag,
-		struct vfspnode *pnode,
-		struct vfsmount *source_mnt,
-		struct dentry *mountpoint_dentry,
-		struct vfsmount *p_mnt)
-
+		void *indata, va_list args)
 {
-	struct vfsmount *child_mnt;
+	struct vfsmount *source_mnt, *child_mnt, *p_mnt;
+	struct dentry *mountpoint_dentry;
+	struct vfspnode *pnode = (struct vfspnode *)indata;
+
+	source_mnt = va_arg(args, struct vfsmount * );
+	mountpoint_dentry =  va_arg(args, struct dentry *);
+	p_mnt =  va_arg(args, struct vfsmount *);
 
 	if ((p_mnt != mnt) || (source_mnt == source_mnt->mnt_parent)) {
 		child_mnt = do_attach_prepare_mnt(mnt, mountpoint_dentry,
 				source_mnt, (p_mnt != mnt));
-
 		if (!child_mnt)
 			return -ENOMEM;
 
@@ -546,71 +579,43 @@ int vfs_prepare_mount_func(struct vfsmou
 }
 
 int pnode_prepare_mount(struct vfspnode *pnode,
-		struct vfspnode *my_pnode,
+		struct vfspnode *master_child_pnode,
 		struct dentry *mountpoint_dentry,
 		struct vfsmount *source_mnt,
 		struct vfsmount *mnt)
 {
-	int ret=0, level;
-     	struct vfspnode *master_pnode, *child_pnode, *master_child_pnode;
-     	struct vfsmount *slave_mnt, *member_mnt, *t_m;
-	struct pcontext context;
-	static struct vfspnode *p_array[PNODE_MAX_SLAVE_LEVEL];
-
-	context.start = pnode;
-	context.pnode = NULL;
-	while (pnode_next(&context)) {
-		level = context.level;
-		pnode = context.pnode;
-		master_pnode = context.master_pnode;
-
-		if (master_pnode) {
-			master_child_pnode = p_array[level];
-			child_pnode = NULL;
-		} else {
-			master_child_pnode = NULL;
-			child_pnode = my_pnode;
-		}
-
-		if (!(child_pnode = pnode_alloc()))
-			return -ENOMEM;
-
-		if (master_child_pnode && child_pnode)
-			pnode_add_slave_pnode(master_child_pnode,
-					child_pnode);
-		p_array[level] = child_pnode;
+	return  pnode_traverse(pnode,
+			master_child_pnode,
+			(void *)NULL,
+			pnode_mount_func,
+			NULL,
+			vfs_prepare_mount_func,
+			source_mnt,
+			mountpoint_dentry,
+			mnt);
+}
 
+int pnode_real_mount_post_func(struct vfspnode *pnode, void *indata,
+		va_list args)
+{
+	if (va_arg(args, int)) {
 		spin_lock(&vfspnode_lock);
-		list_for_each_entry_safe(member_mnt,
-			t_m, &pnode->pnode_vfs, mnt_pnode_mntlist) {
-			spin_unlock(&vfspnode_lock);
-			if((ret=vfs_prepare_mount_func(member_mnt,
-				PNODE_MEMBER_VFS, child_pnode,
-				source_mnt, mountpoint_dentry, mnt)))
-				goto out;
-			spin_lock(&vfspnode_lock);
-		}
-		list_for_each_entry_safe(slave_mnt,
-			t_m, &pnode->pnode_slavevfs,
-			mnt_pnode_mntlist) {
-			spin_unlock(&vfspnode_lock);
-			if((ret = vfs_prepare_mount_func(slave_mnt,
-				PNODE_SLAVE_VFS, child_pnode,
-				source_mnt, mountpoint_dentry, mnt)))
-					goto out;
-			spin_lock(&vfspnode_lock);
-		}
+		BUG_ON(!list_empty(&pnode->pnode_vfs));
+		BUG_ON(!list_empty(&pnode->pnode_slavevfs));
+		BUG_ON(!list_empty(&pnode->pnode_slavepnode));
+		list_del_init(&pnode->pnode_peer_slave);
+		put_pnode_locked(pnode);
 		spin_unlock(&vfspnode_lock);
 	}
-out:
-	return ret;
+	return 0;
 }
 
-int vfs_real_mount_func(struct vfsmount *mnt, int delflag)
+int vfs_real_mount_func(struct vfsmount *mnt, enum pnode_vfs_type flag,
+		void *indata, va_list args)
 {
 	BUG_ON(mnt == mnt->mnt_parent);
 	do_attach_real_mnt(mnt);
-	if (delflag) {
+	if (va_arg(args, int)) {
 		spin_lock(&vfspnode_lock);
 		list_del_init(&mnt->mnt_pnode_mntlist);
 		put_pnode_locked(mnt->mnt_pnode);
@@ -628,42 +633,7 @@ int vfs_real_mount_func(struct vfsmount 
  */
 int pnode_real_mount(struct vfspnode *pnode, int flag)
 {
-	int ret=0;
-     	struct vfsmount *slave_mnt, *member_mnt, *t_m;
-	struct pcontext context;
-
-	context.start = pnode;
-	context.pnode = NULL;
-	while (pnode_next(&context)) {
-		pnode = context.pnode;
-		// traverse member vfsmounts
-		spin_lock(&vfspnode_lock);
-		list_for_each_entry_safe(member_mnt,
-			t_m, &pnode->pnode_vfs, mnt_pnode_mntlist) {
-			spin_unlock(&vfspnode_lock);
-			if ((ret = vfs_real_mount_func(member_mnt,
-							flag)))
-				goto out;
-			spin_lock(&vfspnode_lock);
-		}
-		list_for_each_entry_safe(slave_mnt, t_m,
-			&pnode->pnode_slavevfs, mnt_pnode_mntlist) {
-			spin_unlock(&vfspnode_lock);
-			if ((ret = vfs_real_mount_func(slave_mnt,
-							flag)))
-				goto out;
-			spin_lock(&vfspnode_lock);
-		}
-
-		if (flag) {
-			BUG_ON(!list_empty(&pnode->pnode_vfs));
-			BUG_ON(!list_empty(&pnode->pnode_slavevfs));
-			BUG_ON(!list_empty(&pnode->pnode_slavepnode));
-			list_del_init(&pnode->pnode_peer_slave);
-			put_pnode_locked(pnode);
-		}
-		spin_unlock(&vfspnode_lock);
-	}
-out:
-	return ret;
+	return  pnode_traverse(pnode,
+			NULL, (void *)NULL, NULL, pnode_real_mount_post_func,
+			vfs_real_mount_func, flag);
 }
