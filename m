Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262477AbVGHKoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262477AbVGHKoc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 06:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262485AbVGHK1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 06:27:39 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:23765 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262477AbVGHK0N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 06:26:13 -0400
Subject: [RFC PATCH 8/8] pnode.c optimization
From: Ram <linuxram@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       Andrew Morton <akpm@osdl.org>, mike@waychison.com, bfields@fieldses.org,
       Miklos Szeredi <miklos@szeredi.hu>
In-Reply-To: <1120817846.30164.56.camel@localhost>
References: <1120816072.30164.10.camel@localhost>
	 <1120816229.30164.13.camel@localhost> <1120816355.30164.16.camel@localhost>
	 <1120816436.30164.19.camel@localhost> <1120816521.30164.22.camel@localhost>
	 <1120816600.30164.25.camel@localhost> <1120816720.30164.28.camel@localhost>
	 <1120816835.30164.31.camel@localhost> <1120817846.30164.56.camel@localhost>
Content-Type: multipart/mixed; boundary="=-asRb6m8XEVbjZkyJLA9U"
Organization: IBM 
Message-Id: <1120817913.30164.58.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 08 Jul 2005 03:26:08 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-asRb6m8XEVbjZkyJLA9U
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Optimizes lots of redundant pnode propogation code.
RP


--=-asRb6m8XEVbjZkyJLA9U
Content-Disposition: attachment; filename=pnode_opt.patch
Content-Type: text/x-patch; name=pnode_opt.patch
Content-Transfer-Encoding: 7bit

Optimizes lots of redundant pnode propogation code.
RP


Index: 2.6.12/fs/pnode.c
===================================================================
--- 2.6.12.orig/fs/pnode.c
+++ 2.6.12/fs/pnode.c
@@ -204,34 +204,144 @@ out:
 }
 
 
-static void inline
-pnode_add_mnt(struct vfspnode *pnode, struct vfsmount *mnt, int slave)
+/*
+ * traverse the pnode tree and at each pnode encountered, execute the
+ * pnode_fnc(). For each vfsmount encountered call the vfs_fnc().
+ *
+ * @pnode: pnode tree to be traversed
+ * @in_data: input data
+ * @out_data: output data
+ * @pnode_pre_func: function to be called when a new pnode is encountered
+ * 		the first time. (PNODE_DOWN)
+ * @pnode_post_func: function to be called when a new pnode is encountered
+ * 		each time a child pnode is done processing with.(PNODE_MID)
+ * @vfs_func: function to be called on each slave and member vfs belonging
+ * 		to the pnode. Called when the pnode is done processing with.
+ */
+static int
+pnode_traverse(struct vfspnode *pnode,
+		void *in_data,
+		void **out_data,
+		int (*pnode_pre_func)(struct vfspnode *, void *, void **,
+			void **, va_list ),
+		int (*pnode_post_func)(struct vfspnode *, void *, void *, va_list),
+		int (*vfs_func)(struct vfsmount *, int, void *,  va_list),
+		...)
 {
-	if (!pnode || !mnt)
-		return;
-	spin_lock(&vfspnode_lock);
-	mnt->mnt_pnode = pnode;
-	if (slave) {
-		SET_MNT_SLAVE(mnt);
-		list_add(&mnt->mnt_pnode_mntlist, &pnode->pnode_slavevfs);
-	} else {
-		SET_MNT_SHARED(mnt);
-		list_add(&mnt->mnt_pnode_mntlist, &pnode->pnode_vfs);
+	va_list args;
+	int ret=0,traversal,level;
+	void *my_data, *data_from_master, *data_for_slave, *data_from_slave;
+     	struct vfspnode *slave_pnode, *master_pnode;
+     	struct vfsmount *slave_mnt, *member_mnt, *t_m;
+	struct pcontext context;
+	static struct inoutdata p_array[PNODE_MAX_SLAVE_LEVEL];
+
+
+	context.start = pnode;
+	context.pnode = NULL;
+
+	/*
+	 * determine whether to process vfs first or the
+	 * slave pnode first
+	 */
+	while(pnode_next(&context)) {
+		traversal = context.traversal;
+		level = context.level;
+		pnode = context.pnode;
+		slave_pnode = context.slave_pnode;
+		master_pnode = context.master_pnode;
+
+		if (traversal == PNODE_DOWN ) {
+			if (master_pnode) {
+				data_from_master = p_array[level-1].in_data;
+			} else {
+				data_from_master = in_data;
+			}
+
+			if (pnode_pre_func) {
+				va_start(args, vfs_func);
+				if((ret = pnode_pre_func(pnode, data_from_master,
+						&my_data, &data_for_slave, args))) {
+					goto error;
+				}
+				va_end(args);
+			} else {
+				my_data = data_from_master;
+				data_for_slave = NULL;
+			}
+			p_array[level].my_data = my_data;
+			p_array[level].in_data = data_for_slave;
+
+		} else if(traversal == PNODE_MID) {
+
+			my_data = p_array[level].my_data;
+			if (slave_pnode) {
+				data_from_slave = p_array[level+1].out_data;
+			} else {
+				data_from_slave = NULL;
+			}
+			if (pnode_post_func) {
+				va_start(args, vfs_func);
+				if((ret = pnode_post_func(pnode, my_data,
+						data_from_slave, args))) {
+					goto error;
+				}
+				va_end(args);
+			}
+
+		} else if(traversal == PNODE_UP) {
+
+			my_data = p_array[level].my_data;
+
+			// traverse member vfsmounts
+
+			spin_lock(&vfspnode_lock);
+			list_for_each_entry_safe(member_mnt,
+				t_m, &pnode->pnode_vfs, mnt_pnode_mntlist) {
+				spin_unlock(&vfspnode_lock);
+				va_start(args, vfs_func);
+				if ((ret = vfs_func(member_mnt, PNODE_MEMBER_VFS,
+					my_data, args))) {
+					goto error;
+				}
+				va_end(args);
+				spin_lock(&vfspnode_lock);
+			}
+			list_for_each_entry_safe(slave_mnt,
+				t_m, &pnode->pnode_slavevfs, mnt_pnode_mntlist) {
+				spin_unlock(&vfspnode_lock);
+				va_start(args, vfs_func);
+				if ((ret = vfs_func(slave_mnt, PNODE_SLAVE_VFS,
+					my_data, args))) {
+					goto error;
+				}
+				va_end(args);
+				spin_lock(&vfspnode_lock);
+			}
+			spin_unlock(&vfspnode_lock);
+			p_array[level].out_data = my_data;
+		}
 	}
-	get_pnode(pnode);
-	spin_unlock(&vfspnode_lock);
-}
 
-void
-pnode_add_member_mnt(struct vfspnode *pnode, struct vfsmount *mnt)
-{
-	pnode_add_mnt(pnode, mnt, 0);
+out:
+	if (out_data)
+		*out_data = p_array[0].my_data;
+	return ret;
+error:
+	va_end(args);
+	if (out_data)
+		*out_data = NULL;
+	goto out;
 }
 
+
 static int
-vfs_busy(struct vfsmount *mnt, struct dentry *dentry, struct dentry *rootdentry,
-		struct vfsmount *origmnt, int refcnt)
+vfs_busy(struct vfsmount *mnt, int flag, void *indata,  va_list args)
 {
+	struct dentry *dentry = va_arg(args, struct dentry *);
+	struct dentry *rootdentry = va_arg(args, struct dentry *);
+	struct vfsmount *origmnt = va_arg(args, struct vfsmount *);
+	int    refcnt = va_arg(args, int);
 	struct vfsmount *child_mnt;
 	int ret=0;
 
@@ -256,52 +366,32 @@ int
 pnode_mount_busy(struct vfspnode *pnode, struct dentry *mntpt, struct dentry *root,
 			struct vfsmount *mnt, int refcnt)
 {
-	int ret=0,traversal;
-     	struct vfsmount *slave_mnt, *member_mnt, *t_m;
-	struct pcontext context;
-
-	context.start = pnode;
-	context.pnode = NULL;
-	while(pnode_next(&context)) {
-		traversal = context.traversal;
-		pnode = context.pnode;
-		if(traversal == PNODE_UP) {
-			// traverse member vfsmounts
-			spin_lock(&vfspnode_lock);
-			list_for_each_entry_safe(member_mnt,
-				t_m, &pnode->pnode_vfs, mnt_pnode_mntlist) {
-				spin_unlock(&vfspnode_lock);
-				if ((ret = vfs_busy(member_mnt, mntpt, root, mnt, refnt)))
-					goto out;
-				spin_lock(&vfspnode_lock);
-			}
-			list_for_each_entry_safe(slave_mnt,
-				t_m, &pnode->pnode_slavevfs, mnt_pnode_mntlist) {
-				spin_unlock(&vfspnode_lock);
-				if ((ret = vfs_busy(slave_mnt, mntpt, root, mnt, refcnt)))
-					goto out;
-				spin_lock(&vfspnode_lock);
-			}
-			spin_unlock(&vfspnode_lock);
-		}
-	}
-out:
-	return ret;
+	return pnode_traverse(pnode, NULL, NULL,
+			NULL, NULL, vfs_busy, mntpt, root, mnt, refcnt);
 }
 
+
 int
-vfs_umount(struct vfsmount *mnt, struct dentry *dentry, struct dentry *rootdentry)
+vfs_umount(struct vfsmount *mnt, int flag, void *indata, va_list args)
 {
 	struct vfsmount *child_mnt;
+	struct dentry *dentry, *rootdentry;
+
+
+	dentry = va_arg(args, struct dentry *);
+	rootdentry = va_arg(args, struct dentry *);
 
 	spin_unlock(&vfsmount_lock);
 	child_mnt = lookup_mnt(mnt, dentry, rootdentry);
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
@@ -310,41 +400,33 @@ int
 pnode_umount(struct vfspnode *pnode, struct dentry *dentry,
 			struct dentry *rootdentry)
 {
-	int ret=0,traversal;
-     	struct vfsmount *slave_mnt, *member_mnt, *t_m;
-	struct pcontext context;
+	return pnode_traverse(pnode, NULL, (void *)NULL,
+			NULL, NULL, vfs_umount, dentry, rootdentry);
+}
 
-	context.start = pnode;
-	context.pnode = NULL;
-	while(pnode_next(&context)) {
-		traversal = context.traversal;
-		pnode = context.pnode;
-		if(traversal == PNODE_UP) {
-			// traverse member vfsmounts
-			spin_lock(&vfspnode_lock);
-			list_for_each_entry_safe(member_mnt,
-				t_m, &pnode->pnode_vfs, mnt_pnode_mntlist) {
-				spin_unlock(&vfspnode_lock);
-				if ((ret = vfs_umount(member_mnt,
-						dentry, rootdentry)))
-					goto out;
-				spin_lock(&vfspnode_lock);
-			}
-			list_for_each_entry_safe(slave_mnt,
-				t_m, &pnode->pnode_slavevfs, mnt_pnode_mntlist) {
-				spin_unlock(&vfspnode_lock);
-				if ((ret = vfs_umount(slave_mnt,
-						dentry, rootdentry)))
-					goto out;
-				spin_lock(&vfspnode_lock);
-			}
-			spin_unlock(&vfspnode_lock);
-		}
+static void inline
+pnode_add_mnt(struct vfspnode *pnode, struct vfsmount *mnt, int slave)
+{
+	if (!pnode || !mnt)
+		return;
+	spin_lock(&vfspnode_lock);
+	mnt->mnt_pnode = pnode;
+	if (slave) {
+		SET_MNT_SLAVE(mnt);
+		list_add(&mnt->mnt_pnode_mntlist, &pnode->pnode_slavevfs);
+	} else {
+		SET_MNT_SHARED(mnt);
+		list_add(&mnt->mnt_pnode_mntlist, &pnode->pnode_vfs);
 	}
-out:
-	return ret;
+	get_pnode(pnode);
+	spin_unlock(&vfspnode_lock);
 }
 
+void
+pnode_add_member_mnt(struct vfspnode *pnode, struct vfsmount *mnt)
+{
+	pnode_add_mnt(pnode, mnt, 0);
+}
 
 void
 pnode_add_slave_mnt(struct vfspnode *pnode, struct vfsmount *mnt)
@@ -405,6 +487,7 @@ pnode_disassociate_mnt(struct vfsmount *
 	mnt->mnt_flags &= ~MNT_SHARED;
 }
 
+
 // merge pnode into peer_pnode and get rid of pnode
 int
 pnode_merge_pnode(struct vfspnode *pnode, struct vfspnode *peer_pnode)
@@ -451,82 +534,84 @@ pnode_merge_pnode(struct vfspnode *pnode
 	return 0;
 }
 
-struct vfsmount *
-pnode_make_mounted(struct vfspnode *pnode, struct vfsmount *mnt, struct dentry *dentry)
+int
+pnode_mount_pre_func(struct vfspnode *pnode, void *indata,
+		void **outdata, void **out_slavedata, va_list args)
 {
-	struct vfsmount *child_mnt;
-	int ret=0,traversal,level;
-     	struct vfspnode *slave_pnode, *master_pnode, *child_pnode, *slave_child_pnode;
-     	struct vfsmount *slave_mnt, *member_mnt, *t_m;
-	struct pcontext context;
-	static struct inoutdata p_array[PNODE_MAX_SLAVE_LEVEL];
+	struct vfspnode *pnode_child=NULL;
+	int ret=0;
 
-	context.start = pnode;
-	context.pnode = NULL;
+	*out_slavedata = *outdata = NULL;
 
-	while(pnode_next(&context)) {
-		traversal = context.traversal;
-		level = context.level;
-		pnode = context.pnode;
-		slave_pnode = context.slave_pnode;
-		master_pnode = context.master_pnode;
+	if(indata) {
+		*outdata = indata;
+		goto out;
+	}
 
-		if (traversal == PNODE_DOWN ) {
-			if (master_pnode) {
-				child_pnode = (struct vfspnode *)p_array[level-1].in_data;
-			} else {
-				child_pnode = NULL;
-			}
-			while (!(child_pnode = pnode_alloc()))
-				schedule();
-			p_array[level].my_data = (void *)child_pnode;
-			p_array[level].in_data = NULL;
+	while (!(pnode_child = pnode_alloc()))
+		schedule();
 
-		} else if(traversal == PNODE_MID) {
+	*outdata = (void *)pnode_child;
+out:
+	return ret;
+}
 
-			child_pnode = (struct vfspnode *)p_array[level].my_data;
-			slave_child_pnode = p_array[level+1].out_data;
-			pnode_add_slave_pnode(child_pnode, slave_child_pnode);
+int
+pnode_mount_post_func(struct vfspnode *pnode, void *indata, void *outdata, va_list args)
+{
+	struct vfspnode *pnode_child, *slave_child_pnode;
 
-		} else if(traversal == PNODE_UP) {
-			child_pnode = p_array[level].my_data;
-			spin_lock(&vfspnode_lock);
-			list_for_each_entry_safe(member_mnt,
-				t_m, &pnode->pnode_vfs, mnt_pnode_mntlist) {
-				spin_unlock(&vfspnode_lock);
-				if (!(child_mnt = do_make_mounted(mnt, dentry))) {
-					ret = -ENOMEM;
-					goto out;
-				}
-				spin_lock(&vfspnode_lock);
-				pnode_add_member_mnt(child_pnode, child_mnt);
-			}
-			list_for_each_entry_safe(slave_mnt,
-				t_m, &pnode->pnode_slavevfs, mnt_pnode_mntlist) {
-				spin_unlock(&vfspnode_lock);
-				if (!(child_mnt = do_make_mounted(mnt, dentry))) {
-					ret = -ENOMEM;
-					goto out;
-				}
-				spin_lock(&vfspnode_lock);
-				pnode_add_slave_mnt(child_pnode, child_mnt);
-			}
-			spin_unlock(&vfspnode_lock);
-			p_array[level].out_data = child_pnode;
-		}
+	pnode_child = (struct vfspnode *)indata;
+	slave_child_pnode = (struct vfspnode *)outdata;
+
+	if (pnode_child && slave_child_pnode)
+		pnode_add_slave_pnode(pnode_child, slave_child_pnode);
+
+	return 0;
+}
+
+int
+vfs_make_mounted_func(struct vfsmount *mnt, int flag, void *indata, va_list args)
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
+	}
+	pnode = (struct vfspnode *)indata;
+	switch (flag) {
+	case PNODE_SLAVE_VFS :
+		pnode_add_slave_mnt(pnode, child_mount);
+		break;
+	case PNODE_MEMBER_VFS :
+		pnode_add_member_mnt(pnode, child_mount);
+		break;
 	}
 
 out:
-	if (ret)
-		return NULL;
+	return ret;
+}
 
+struct vfsmount *
+pnode_make_mounted(struct vfspnode *pnode, struct vfsmount *mnt, struct dentry *dentry)
+{
+	struct vfsmount *child_mnt;
+	if(pnode_traverse(pnode, NULL, (void *)NULL,
+			pnode_mount_pre_func, pnode_mount_post_func,
+			vfs_make_mounted_func, (void *)dentry))
+		return NULL;
 	child_mnt = lookup_mnt(mnt, dentry, dentry);
 	mntput(child_mnt);
 	return child_mnt;
 }
 
 int
-vfs_make_unmounted(struct vfsmount *mnt)
+vfs_make_unmounted_func(struct vfsmount *mnt, int flag, void *indata,  va_list args)
 {
 	struct vfspnode *pnode;
 	int ret=0;
@@ -535,8 +620,11 @@ vfs_make_unmounted(struct vfsmount *mnt)
 		ret = 1;
 		goto out;
 	}
+
 	pnode = mnt->mnt_pnode;
+	spin_lock(&vfspnode_lock);
 	list_del_init(&mnt->mnt_pnode_mntlist);
+	spin_unlock(&vfspnode_lock);
 	put_pnode(pnode);
 out:
 	return ret;
@@ -545,49 +633,20 @@ out:
 int
 pnode_make_unmounted(struct vfspnode *pnode)
 {
-	int ret=0,traversal;
-     	struct vfsmount *slave_mnt, *member_mnt, *t_m;
-	struct pcontext context;
-
-	context.start = pnode;
-	context.pnode = NULL;
-	while(pnode_next(&context)) {
-		traversal = context.traversal;
-		pnode = context.pnode;
-		if(traversal == PNODE_UP) {
-			// traverse member vfsmounts
-			spin_lock(&vfspnode_lock);
-			list_for_each_entry_safe(member_mnt,
-				t_m, &pnode->pnode_vfs, mnt_pnode_mntlist) {
-				spin_unlock(&vfspnode_lock);
-				if ((ret = vfs_make_unmounted(member_mnt)))
-					goto out;
-				spin_lock(&vfspnode_lock);
-			}
-			list_for_each_entry_safe(slave_mnt,
-				t_m, &pnode->pnode_slavevfs, mnt_pnode_mntlist) {
-				spin_unlock(&vfspnode_lock);
-				if ((ret = vfs_make_unmounted(slave_mnt)))
-					goto out;
-				spin_lock(&vfspnode_lock);
-			}
-			spin_unlock(&vfspnode_lock);
-		}
-	}
-
-out:
-	return ret;
+	return pnode_traverse(pnode, NULL, (void *)NULL,
+			NULL, NULL, vfs_make_unmounted_func);
 }
 
-
 int
-vfs_prepare_mount_func(struct vfsmount *mnt, int flag, struct vfspnode *pnode,
-		struct vfsmount *source_mnt,
-		struct dentry *mountpoint_dentry,
-		struct vfsmount *p_mnt)
-
+vfs_prepare_mount_func(struct vfsmount *mnt, int flag, void *indata, va_list args)
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
@@ -610,6 +669,7 @@ vfs_prepare_mount_func(struct vfsmount *
 }
 
 
+
 int
 pnode_prepare_mount(struct vfspnode *pnode,
 		struct vfspnode *master_child_pnode,
@@ -617,78 +677,42 @@ pnode_prepare_mount(struct vfspnode *pno
 		struct vfsmount *source_mnt,
 		struct vfsmount *mnt)
 {
-	int ret=0,traversal,level;
-     	struct vfspnode *slave_pnode, *master_pnode, *slave_child_pnode, *child_pnode;
-     	struct vfsmount *slave_mnt, *member_mnt, *t_m;
-	struct pcontext context;
-	static struct inoutdata p_array[PNODE_MAX_SLAVE_LEVEL];
-
-	context.start = pnode;
-	context.pnode = NULL;
-	while(pnode_next(&context)) {
-		traversal = context.traversal;
-		level = context.level;
-		pnode = context.pnode;
-		slave_pnode = context.slave_pnode;
-		master_pnode = context.master_pnode;
-
-		if (traversal == PNODE_DOWN ) {
-
-			child_pnode = NULL;
-			if (!master_pnode)
-				child_pnode = master_child_pnode;
-
-			while (!(child_pnode = pnode_alloc()))
-				schedule();
-
-			p_array[level].my_data = child_pnode;
-
-		} else if(traversal == PNODE_MID) {
-
-			child_pnode = (struct vfspnode *)p_array[level].my_data;
-			slave_child_pnode = p_array[level+1].out_data;
-			pnode_add_slave_pnode(child_pnode, slave_child_pnode);
-
-		} else if(traversal == PNODE_UP) {
-
-			child_pnode = p_array[level].my_data;
-			spin_lock(&vfspnode_lock);
-			list_for_each_entry_safe(member_mnt,
-				t_m, &pnode->pnode_vfs, mnt_pnode_mntlist) {
-				spin_unlock(&vfspnode_lock);
-				if((ret=vfs_prepare_mount_func(member_mnt,
-					PNODE_MEMBER_VFS, child_pnode, source_mnt,
-					mountpoint_dentry, mnt)))
-					goto out;
-				spin_lock(&vfspnode_lock);
-			}
-			list_for_each_entry_safe(slave_mnt,
-				t_m, &pnode->pnode_slavevfs, mnt_pnode_mntlist) {
-				spin_unlock(&vfspnode_lock);
-				if((ret = vfs_prepare_mount_func(slave_mnt,
-					PNODE_SLAVE_VFS, child_pnode, source_mnt,
-					mountpoint_dentry, mnt)))
-					goto out;
-				spin_lock(&vfspnode_lock);
-			}
-			spin_unlock(&vfspnode_lock);
-			p_array[level].out_data = child_pnode;
+	return  pnode_traverse(pnode,
+			master_child_pnode,
+			(void *)NULL,
+			pnode_mount_pre_func,
+			pnode_mount_post_func,
+			vfs_prepare_mount_func,
+			source_mnt,
+			mountpoint_dentry,
+			mnt);
+}
 
-		}
+int
+pnode_real_mount_post_func(struct vfspnode *pnode, void *indata,
+		void *outdata, va_list args)
+{
+	if (va_arg(args, int)) {
+		spin_lock(&vfspnode_lock);
+		BUG_ON(!list_empty(&pnode->pnode_vfs));
+		BUG_ON(!list_empty(&pnode->pnode_slavevfs));
+		BUG_ON(!list_empty(&pnode->pnode_slavepnode));
+		list_del_init(&pnode->pnode_peer_slave);
+		spin_unlock(&vfspnode_lock);
+		put_pnode(pnode);
 	}
-
-out:
-	return ret;
+	return 0;
 }
 
-
 int
-vfs_real_mount_func(struct vfsmount *mnt, int delflag)
+vfs_real_mount_func(struct vfsmount *mnt, int flag, void *indata, va_list args)
 {
 	BUG_ON(mnt == mnt->mnt_parent);
 	do_attach_real_mnt(mnt);
-	if (delflag) {
+	if (va_arg(args, int)) {
+		spin_lock(&vfspnode_lock);
 		list_del_init(&mnt->mnt_pnode_mntlist);
+		spin_unlock(&vfspnode_lock);
 		mnt->mnt_pnode = NULL;
 		SET_MNT_PRIVATE(mnt);
 	}
@@ -704,43 +728,7 @@ vfs_real_mount_func(struct vfsmount *mnt
 int
 pnode_real_mount(struct vfspnode *pnode, int flag)
 {
-	int ret=0,traversal;
-     	struct vfsmount *slave_mnt, *member_mnt, *t_m;
-	struct pcontext context;
-
-	context.start = pnode;
-	context.pnode = NULL;
-	while(pnode_next(&context)) {
-		traversal = context.traversal;
-		pnode = context.pnode;
-		if(traversal == PNODE_MID) {
-			if (flag) {
-				BUG_ON(!list_empty(&pnode->pnode_vfs));
-				BUG_ON(!list_empty(&pnode->pnode_slavevfs));
-				BUG_ON(!list_empty(&pnode->pnode_slavepnode));
-				list_del_init(&pnode->pnode_peer_slave);
-				put_pnode(pnode);
-			}
-		} else if(traversal == PNODE_UP) {
-			// traverse member vfsmounts
-			spin_lock(&vfspnode_lock);
-			list_for_each_entry_safe(member_mnt,
-				t_m, &pnode->pnode_vfs, mnt_pnode_mntlist) {
-				spin_unlock(&vfspnode_lock);
-				if ((ret = vfs_real_mount_func(member_mnt, flag)))
-					goto out;
-			}
-			list_for_each_entry_safe(slave_mnt,
-				t_m, &pnode->pnode_slavevfs, mnt_pnode_mntlist) {
-				spin_unlock(&vfspnode_lock);
-				if ((ret = vfs_real_mount_func(slave_mnt, flag)))
-					goto out;
-				spin_lock(&vfspnode_lock);
-			}
-			spin_unlock(&vfspnode_lock);
-		}
-	}
-
-out:
-	return ret;
+	return  pnode_traverse(pnode,
+			NULL, (void *)NULL, NULL, pnode_real_mount_post_func,
+			vfs_real_mount_func, flag);
 }

--=-asRb6m8XEVbjZkyJLA9U--

