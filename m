Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbTGVCX3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 22:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbTGVCX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 22:23:29 -0400
Received: from www.13thfloor.AT ([212.16.59.250]:18402 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S262439AbTGVCWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 22:22:41 -0400
Date: Tue, 22 Jul 2003 04:37:51 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@ucw.cz>, linux-kernel@vger.kernel.org,
       "BRETT, PAUL" <paul.brett@intel.com>
Subject: Bind VFS Mount Quota (2.4.22)
Message-ID: <20030722023751.GA21009@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@ucw.cz>, linux-kernel@vger.kernel.org,
	"BRETT, PAUL" <paul.brett@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline


Hi Everyone!

This patch is based on the Quota Hash Abstraction patch
and considered a simple foundation for further per mount
point quota development.

for now, it only supports ext2 and simple propagation,
although support for other filesystems should be trivial 
and straight forward (only one unused 32bit field is 
required to make it work)

also there are currently no tools available to get/set
the quota information, but quotactl is extended to work
on mountpoints as well as devices ...

enjoy,
Herbert

PS: if you have any questions regarding this patch, feel
    free to contact me ...

--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="linux-2.4.22-pre7-mq0.06-bq0.02.diff"
Content-Transfer-Encoding: 8bit

;
; Bind VFS Mount Quota
;
; utilizing the quota hash abstraction done in mq-0.06
; this patch adds per vfsmount (--bind) quota for ext2.
;
; how it works: 
; each bind mount of type quota, creates his own quota domain, 
; which is propagated down from the mnt_root to each entry
; below (currently not on lookup, only on create)
;
; # mount -t quota --bind /mnt/somedir /mnt/somedir
;
; for now only ext2 is supported, but support for other
; filesystems should be trivial and straight forward.
;
; (C) 2003 Herbert Pötzl <herbert@13thfloor.at>
;
; Changelog:  
;
;   0.02  - first public release
;
; this patch is free software; you can redistribute it and/or
; modify it under the terms of the GNU General Public License
; as published by the Free Software Foundation; either version 2
; of the License, or (at your option) any later version.
; 
; this patch is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
; 

diff -NurP --minimal linux-2.4.22-pre7-mq0.06/drivers/char/sysrq.c linux-2.4.22-pre7-mq0.06-bq0.02/drivers/char/sysrq.c
--- linux-2.4.22-pre7-mq0.06/drivers/char/sysrq.c	2003-07-21 04:58:04.000000000 +0200
+++ linux-2.4.22-pre7-mq0.06-bq0.02/drivers/char/sysrq.c	2003-07-22 00:56:05.000000000 +0200
@@ -146,6 +146,7 @@
 	if (remount_flag) { /* Remount R/O */
 		int ret, flags;
 		struct list_head *p;
+		struct dqhash *dqh;
 
 		if (sb->s_flags & MS_RDONLY) {
 			printk("R/O\n");
@@ -161,6 +162,8 @@
 		}
 		file_list_unlock();
 		DQUOT_OFF(sb->s_dqh);
+		list_for_each_entry(dqh, &sb->s_dqhashes, dqh_list)
+		    	DQUOT_OFF(dqh);
 		fsync_dev(sb->s_dev);
 		flags = MS_RDONLY;
 		if (sb->s_op && sb->s_op->remount_fs) {
diff -NurP --minimal linux-2.4.22-pre7-mq0.06/fs/buffer.c linux-2.4.22-pre7-mq0.06-bq0.02/fs/buffer.c
--- linux-2.4.22-pre7-mq0.06/fs/buffer.c	2003-07-21 04:58:04.000000000 +0200
+++ linux-2.4.22-pre7-mq0.06-bq0.02/fs/buffer.c	2003-07-22 00:56:05.000000000 +0200
@@ -331,12 +331,15 @@
 
 int fsync_super(struct super_block *sb)
 {
+	struct dqhash *dqh;
 	kdev_t dev = sb->s_dev;
 	sync_buffers(dev, 0);
 
 	lock_kernel();
 	sync_inodes_sb(sb);
 	DQUOT_SYNC_DQH(sb->s_dqh);
+	list_for_each_entry(dqh, &sb->s_dqhashes, dqh_list)
+	    	DQUOT_SYNC_DQH(dqh);
 	lock_super(sb);
 	if (sb->s_dirt && sb->s_op && sb->s_op->write_super)
 		sb->s_op->write_super(sb);
diff -NurP --minimal linux-2.4.22-pre7-mq0.06/fs/dquot.c linux-2.4.22-pre7-mq0.06-bq0.02/fs/dquot.c
--- linux-2.4.22-pre7-mq0.06/fs/dquot.c	2003-07-22 03:29:06.000000000 +0200
+++ linux-2.4.22-pre7-mq0.06-bq0.02/fs/dquot.c	2003-07-22 00:59:05.000000000 +0200
@@ -177,7 +177,7 @@
 
 static inline int const hashfn(unsigned int id, int type)
 {
-	return (id * (MAXQUOTAS - type)) % NR_DQHASH;
+	return ((id + 42) * (MAXQUOTAS - type)) % NR_DQHASH;
 }
 
 static inline void insert_dquot_hash(struct dqhash *hash, struct dquot *dquot)
@@ -377,10 +377,10 @@
 
 /* Dquota Hash Management Functions */
 
-static LIST_HEAD(dqhash_list);
+static unsigned int dqhash_id = 0; 
 
 
-struct dqhash *new_dqhash(struct super_block *sb, unsigned int id)
+struct dqhash *new_dqhash(struct super_block *sb, unsigned long dqdom)
 {
 	struct dqhash *hash;
 	int i;
@@ -390,7 +390,9 @@
 	    	return ERR_PTR(-ENOMEM);
 
  	memset(hash, 0, sizeof(struct dqhash));
- 	hash->dqh_id = id;
+ 	hash->dqh_id = dqhash_id++;
+ 	hash->dqh_dqdom = dqdom;
+ 	hash->dqh_count = 1;
  	INIT_LIST_HEAD(&hash->dqh_list);
  	for (i = 0; i < NR_DQHASH; i++)
  		INIT_LIST_HEAD(hash->dqh_hash + i);
@@ -398,15 +400,17 @@
  	sema_init(&hash->dqh_dqopt.dqoff_sem, 1);
  	hash->dqh_qop = &dquot_operations;
  	hash->dqh_qcop = &vfs_quotactl_ops;
- 	hash->dqh_sb = sb;
+	hash->dqh_sb = sb;
 
 	lock_kernel();
-	list_add(&hash->dqh_list, &dqhash_list);
+	list_add_tail(&hash->dqh_list, &sb->s_dqhashes);
 	unlock_kernel();
 	dprintk ("··· new_dqhash: %p [#%d,#0x%lx]\n", hash, hash->dqh_id, hash->dqh_dqdom);
 	return hash;
 }
 
+extern void remove_dqhash_ref(struct dqhash *hash);
+
 void destroy_dqhash(struct dqhash *hash)
 {
 	int cnt;
@@ -417,25 +421,37 @@
 	unlock_kernel();
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
 		invalidate_dquots(hash, cnt);
+	hash->dqh_dqdom = -1;
 	kfree(hash);
 }
 
-
-struct dqhash *find_dqhash(unsigned int id)
+struct dqhash *get_existing_dqhash(struct super_block *sb, unsigned long dqdom)
 {
-	struct list_head *head;
 	struct dqhash *hash;
 
 	lock_kernel();
-	list_for_each(head, &dqhash_list) {
-		hash = list_entry(head, struct dqhash, dqh_list);
-		if (hash->dqh_id == id)
+	list_for_each_entry(hash, &sb->s_dqhashes, dqh_list)
+		if (hash->dqh_dqdom == dqdom)
 			goto dqh_found;
-	}
-	hash = NULL;
+    	/* sorry no hash found */
+	unlock_kernel();
+	return NULL;
 	
 dqh_found:
 	unlock_kernel();
+	return dqhget(hash);
+}
+
+
+struct dqhash *get_dqhash(struct super_block *sb, unsigned long dqdom)
+{
+	struct dqhash *hash;
+
+    	if (!sb)
+	    	BUG();	
+	hash = get_existing_dqhash(sb, dqdom);
+    	if (!hash)
+	    	hash = new_dqhash(sb, dqdom);
 	return hash;
 }
 
@@ -1023,7 +1039,7 @@
 void dquot_initialize(struct inode *inode, int type)
 {
 	struct dquot *dquot[MAXQUOTAS];
-	struct dqhash *dqh = inode->i_sb->s_dqh;
+	struct dqhash *dqh = inode->i_dqh;
 	unsigned int id = 0;
 	int cnt;
 
@@ -1198,19 +1214,28 @@
 
 /*
  * Transfer the number of inode and blocks from one diskquota to an other.
- *
+ * If requested this, is also done from one quota hash to another.
  * This operation can block, but only after everything is updated
  */
-int dquot_transfer(struct inode *inode, struct iattr *iattr)
+int __dquot_transfer(struct inode *inode, struct iattr *iattr, struct dqhash *hash)
 {
 	qsize_t space;
 	struct dquot *transfer_from[MAXQUOTAS];
 	struct dquot *transfer_to[MAXQUOTAS];
-    	struct dqhash *dqh = inode->i_sb->s_dqh;
-	int cnt, ret = NO_QUOTA, chuid = (iattr->ia_valid & ATTR_UID) && inode->i_uid != iattr->ia_uid,
-	    chgid = (iattr->ia_valid & ATTR_GID) && inode->i_gid != iattr->ia_gid;
+    	struct dqhash *dqh = inode->i_dqh;
+	uid_t new_uid = (iattr->ia_valid & ATTR_UID) ? iattr->ia_uid : inode->i_uid;
+	gid_t new_gid = (iattr->ia_valid & ATTR_GID) ? iattr->ia_gid : inode->i_gid;
+	int cnt, chuid, chgid;
 	char warntype[MAXQUOTAS];
 
+    	if (hash == dqh) {
+	    	chuid = (iattr->ia_valid & ATTR_UID) && inode->i_uid != iattr->ia_uid;
+	    	chgid = (iattr->ia_valid & ATTR_GID) && inode->i_gid != iattr->ia_gid;
+	}
+    	/* transfer between quota hashes */
+	else 
+	    	chuid = chgid = 1;
+
 	/* Clear the arrays */
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		transfer_to[cnt] = transfer_from[cnt] = NODQUOT;
@@ -1218,18 +1244,18 @@
 	}
 	/* First build the transfer_to list - here we can block on reading of dquots... */
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		if (!dqh_has_quota_enabled(dqh, cnt))
+		if (!dqh_has_quota_enabled(hash, cnt))
 			continue;
 		switch (cnt) {
 			case USRQUOTA:
 				if (!chuid)
 					continue;
-				transfer_to[cnt] = dqget(dqh, iattr->ia_uid, cnt);
+				transfer_to[cnt] = dqget(hash, new_uid, cnt);
 				break;
 			case GRPQUOTA:
 				if (!chgid)
 					continue;
-				transfer_to[cnt] = dqget(dqh, iattr->ia_gid, cnt);
+				transfer_to[cnt] = dqget(hash, new_gid, cnt);
 				break;
 		}
 	}
@@ -1237,12 +1263,16 @@
 	space = inode_get_bytes(inode);
 	/* Build the transfer_from list and check the limits */
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		/* The second test can fail when quotaoff is in progress... */
-		if (transfer_to[cnt] == NODQUOT || !dqh_has_quota_enabled(dqh, cnt))
-			continue;
+	    	if (!dqh_has_quota_enabled(dqh, cnt))
+		    	/* transfer from noquota domain ... */
+		    	continue;
 		transfer_from[cnt] = dqduplicate(inode->i_dquot[cnt]);
-		if (transfer_from[cnt] == NODQUOT)	/* Can happen on quotafiles (quota isn't initialized on them)... */
+		if (transfer_from[cnt] == NODQUOT)	
+		    	/* Can happen on quotafiles (quota isn't initialized on them)... */
 			continue;
+		if (transfer_to[cnt] == NODQUOT || !dqh_has_quota_enabled(hash, cnt))
+		    	/* transfer to noquota domain ... */
+		    	continue;
 		if (check_idq(transfer_to[cnt], 1, warntype+cnt) == NO_QUOTA ||
 		    check_bdq(transfer_to[cnt], space, 0, warntype+cnt) == NO_QUOTA)
 			goto warn_put_all;
@@ -1252,29 +1282,34 @@
 	 * Finally perform the needed transfer from transfer_from to transfer_to
 	 */
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		/*
-		 * Skip changes for same uid or gid or for non-existing quota-type.
-		 */
-		if (transfer_from[cnt] == NODQUOT || transfer_to[cnt] == NODQUOT)
+		if (transfer_from[cnt] == NODQUOT && transfer_to[cnt] == NODQUOT)
+		    	/* nothing to transfer ... */
 			continue;
 
-		dquot_decr_inodes(transfer_from[cnt], 1);
-		dquot_decr_space(transfer_from[cnt], space);
+    	    	if (transfer_from[cnt] != NODQUOT) {
+			dquot_decr_inodes(transfer_from[cnt], 1);
+			dquot_decr_space(transfer_from[cnt], space);
+    	    	}
 
-		dquot_incr_inodes(transfer_to[cnt], 1);
-		dquot_incr_space(transfer_to[cnt], space);
+    	    	if (transfer_to[cnt] != NODQUOT) {
+			dquot_incr_inodes(transfer_to[cnt], 1);
+			dquot_incr_space(transfer_to[cnt], space);
+    	    	}
 
-		if (inode->i_dquot[cnt] == NODQUOT)
-			BUG();
 		inode->i_dquot[cnt] = transfer_to[cnt];
-		/*
-		 * We've got to release transfer_from[] twice - once for dquot_transfer() and
-		 * once for inode. We don't want to release transfer_to[] as it's now placed in inode
-		 */
-		transfer_to[cnt] = transfer_from[cnt];
 	}
 	/* NOBLOCK END. From now on we can block as we wish */
-	ret = QUOTA_OK;
+
+	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
+		/* First we must put duplicate - otherwise we might deadlock */
+		if (transfer_from[cnt] != NODQUOT) {
+			dqputduplicate(transfer_from[cnt]);
+			/* release for inode */
+			dqput(transfer_from[cnt]);
+    	    	}
+	}
+	return QUOTA_OK;
+
 warn_put_all:
 	flush_warnings(transfer_to, warntype);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
@@ -1284,6 +1319,25 @@
 		if (transfer_to[cnt] != NODQUOT)
 			dqput(transfer_to[cnt]);
 	}
+	return NO_QUOTA;
+}
+
+int dquot_transfer(struct inode *inode, struct iattr *iattr)
+{
+    	return __dquot_transfer(inode, iattr, inode->i_dqh);
+}
+
+int dqhash_transfer(struct inode *inode, struct dqhash *hash)
+{
+    	struct iattr iattr;
+	int ret = 0;
+	
+	if (hash == inode->i_dqh)
+	    	return ret;
+    	dprintk("··· dqhash_transfer: %p [#0x%lx], hash: %p->%p\n",
+	    	inode, inode->i_dqdom, inode->i_dqh, hash);
+	iattr.ia_valid = 0;
+    	ret = __dquot_transfer(inode, &iattr, hash);
 	return ret;
 }
 
diff -NurP --minimal linux-2.4.22-pre7-mq0.06/fs/ext2/ialloc.c linux-2.4.22-pre7-mq0.06-bq0.02/fs/ext2/ialloc.c
--- linux-2.4.22-pre7-mq0.06/fs/ext2/ialloc.c	2003-06-13 16:51:37.000000000 +0200
+++ linux-2.4.22-pre7-mq0.06-bq0.02/fs/ext2/ialloc.c	2003-07-22 00:56:05.000000000 +0200
@@ -392,6 +392,8 @@
 	inode->u.ext2_i.i_block_group = group;
 	ext2_set_inode_flags(inode);
 	insert_inode_hash(inode);
+	
+	dqdom_cond_modify(inode, dir->i_dqdom); /* is this wise? */
 	inode->i_generation = event++;
 	mark_inode_dirty(inode);
 
diff -NurP --minimal linux-2.4.22-pre7-mq0.06/fs/ext2/inode.c linux-2.4.22-pre7-mq0.06-bq0.02/fs/ext2/inode.c
--- linux-2.4.22-pre7-mq0.06/fs/ext2/inode.c	2003-06-13 16:51:37.000000000 +0200
+++ linux-2.4.22-pre7-mq0.06-bq0.02/fs/ext2/inode.c	2003-07-22 00:56:05.000000000 +0200
@@ -969,6 +969,7 @@
 	inode->i_blksize = PAGE_SIZE;	/* This is the optimal IO size (for stat), not the fs block size */
 	inode->i_blocks = le32_to_cpu(raw_inode->i_blocks);
 	inode->i_version = ++event;
+    	inode->i_dqdom = le32_to_cpu(raw_inode->i_raw_dqdom);
 	inode->u.ext2_i.i_flags = le32_to_cpu(raw_inode->i_flags);
 	inode->u.ext2_i.i_faddr = le32_to_cpu(raw_inode->i_faddr);
 	inode->u.ext2_i.i_frag_no = raw_inode->i_frag;
@@ -1091,6 +1092,7 @@
 		raw_inode->i_uid_high = 0;
 		raw_inode->i_gid_high = 0;
 	}
+	raw_inode->i_raw_dqdom = cpu_to_le32(inode->i_dqdom);
 	raw_inode->i_links_count = cpu_to_le16(inode->i_nlink);
 	raw_inode->i_size = cpu_to_le32(inode->i_size);
 	raw_inode->i_atime = cpu_to_le32(inode->i_atime);
diff -NurP --minimal linux-2.4.22-pre7-mq0.06/fs/ext2/ioctl.c linux-2.4.22-pre7-mq0.06-bq0.02/fs/ext2/ioctl.c
--- linux-2.4.22-pre7-mq0.06/fs/ext2/ioctl.c	2003-06-13 16:51:37.000000000 +0200
+++ linux-2.4.22-pre7-mq0.06-bq0.02/fs/ext2/ioctl.c	2003-07-22 00:56:05.000000000 +0200
@@ -70,6 +70,9 @@
 		inode->i_ctime = CURRENT_TIME;
 		mark_inode_dirty(inode);
 		return 0;
+	case EXT2_IOC_GETDQDOM:
+		/* fixme: if stealth, return -ENOTTY */
+		return put_user(inode->i_dqdom, (int *) arg);
 	default:
 		return -ENOTTY;
 	}
diff -NurP --minimal linux-2.4.22-pre7-mq0.06/fs/inode.c linux-2.4.22-pre7-mq0.06-bq0.02/fs/inode.c
--- linux-2.4.22-pre7-mq0.06/fs/inode.c	2003-07-22 02:51:57.000000000 +0200
+++ linux-2.4.22-pre7-mq0.06-bq0.02/fs/inode.c	2003-07-22 00:56:05.000000000 +0200
@@ -95,7 +95,6 @@
 		struct address_space * const mapping = &inode->i_data;
 
 		inode->i_sb = sb;
-		inode->i_dqh = sb->s_dqh;   	/* this is the default */
 		inode->i_dev = sb->s_dev;
 		inode->i_blkbits = sb->s_blocksize_bits;
 		inode->i_flags = 0;
@@ -113,6 +112,8 @@
 		inode->i_pipe = NULL;
 		inode->i_bdev = NULL;
 		inode->i_cdev = NULL;
+		inode->i_dqh = dqhget(sb->s_dqh);   /* this is the default */
+		inode->i_dqdom = 0;
 
 		mapping->a_ops = &empty_aops;
 		mapping->host = inode;
@@ -124,6 +125,8 @@
 
 static void destroy_inode(struct inode *inode) 
 {
+    	if (inode->i_dqh)
+	    	dqhput(inode->i_dqh);
 	if (inode_has_buffers(inode))
 		BUG();
 	if (inode->i_sb->s_op->destroy_inode)
diff -NurP --minimal linux-2.4.22-pre7-mq0.06/fs/namei.c linux-2.4.22-pre7-mq0.06-bq0.02/fs/namei.c
--- linux-2.4.22-pre7-mq0.06/fs/namei.c	2003-06-13 16:51:37.000000000 +0200
+++ linux-2.4.22-pre7-mq0.06-bq0.02/fs/namei.c	2003-07-22 00:56:05.000000000 +0200
@@ -306,6 +306,7 @@
 				dput(dentry);
 			else
 				result = dentry;
+			dqdom_lookup_update(dir, dentry);
 		}
 		up(&dir->i_sem);
 		return result;
@@ -974,6 +975,8 @@
 	DQUOT_INIT(dir);
 	lock_kernel();
 	error = dir->i_op->create(dir, dentry, mode);
+	if (!error)
+		dqdom_cond_update(dir, dentry);
 	unlock_kernel();
 exit_lock:
 	up(&dir->i_zombie);
@@ -1481,6 +1484,8 @@
 			else {
 				lock_kernel();
 				error = dir->i_op->unlink(dir, dentry);
+				if (!error)
+					dqdom_unlink_update(dir, dentry); /* special? */
 				unlock_kernel();
 				if (!error)
 					d_delete(dentry);
@@ -1551,6 +1556,8 @@
 	DQUOT_INIT(dir);
 	lock_kernel();
 	error = dir->i_op->symlink(dir, dentry, oldname);
+	if (!error)
+		dqdom_cond_update(dir, dentry);  /* not portable? */
 	unlock_kernel();
 
 exit_lock:
@@ -1624,6 +1631,8 @@
 	DQUOT_INIT(dir);
 	lock_kernel();
 	error = dir->i_op->link(old_dentry, dir, new_dentry);
+	if (!error)
+		dqdom_cond_update(dir, new_dentry);
 	unlock_kernel();
 
 exit_lock:
@@ -1899,6 +1908,8 @@
 	lock_kernel();
 	error = vfs_rename(old_dir->d_inode, old_dentry,
 				   new_dir->d_inode, new_dentry);
+	if (!error)
+		dqdom_cond_update(new_dir->d_inode, old_dentry);
 	unlock_kernel();
 
 	dput(new_dentry);
diff -NurP --minimal linux-2.4.22-pre7-mq0.06/fs/namespace.c linux-2.4.22-pre7-mq0.06-bq0.02/fs/namespace.c
--- linux-2.4.22-pre7-mq0.06/fs/namespace.c	2003-07-21 04:58:04.000000000 +0200
+++ linux-2.4.22-pre7-mq0.06-bq0.02/fs/namespace.c	2003-07-22 00:56:05.000000000 +0200
@@ -140,6 +140,7 @@
 		mnt->mnt_flags = old->mnt_flags;
 		atomic_inc(&sb->s_active);
 		mnt->mnt_sb = sb;
+		mnt->mnt_dqh = dqhget(sb->s_dqh);
 		mnt->mnt_root = dget(root);
 		mnt->mnt_mountpoint = mnt->mnt_root;
 		mnt->mnt_parent = mnt;
@@ -150,6 +151,7 @@
 void __mntput(struct vfsmount *mnt)
 {
 	struct super_block *sb = mnt->mnt_sb;
+    	dqhput(mnt->mnt_dqh);
 	dput(mnt->mnt_root);
 	free_vfsmnt(mnt);
 	kill_super(sb);
@@ -270,6 +272,7 @@
 		list_add(&p->mnt_list, &kill);
 	}
 
+	DQUOT_OFF(mnt->mnt_dqh);
 	while (!list_empty(&kill)) {
 		mnt = list_entry(kill.next, struct vfsmount, mnt_list);
 		list_del_init(&mnt->mnt_list);
@@ -337,7 +340,7 @@
 		/* last instance - try to be smart */
 		spin_unlock(&dcache_lock);
 		lock_kernel();
-		DQUOT_OFF(sb->s_dqh);
+		DQUOT_OFF(mnt->mnt_dqh);
 		acct_auto_close(sb->s_dev);
 		unlock_kernel();
 		spin_lock(&dcache_lock);
@@ -476,6 +479,7 @@
 		err = 0;
 	}
 	spin_unlock(&dcache_lock);
+	/* do we need something here? */
 out_unlock:
 	up(&nd->dentry->d_inode->i_zombie);
 	return err;
@@ -484,7 +488,7 @@
 /*
  * do loopback mount.
  */
-static int do_loopback(struct nameidata *nd, char *old_name, int recurse)
+static int do_loopback(struct nameidata *nd, char *old_name, char *type, int recurse)
 {
 	struct nameidata old_nd;
 	struct vfsmount *mnt = NULL;
@@ -508,6 +512,16 @@
 	}
 
 	if (mnt) {
+		char *dom_info = strstr(type, "quota");
+		unsigned long dqdom = 0;
+		
+		/* disable if not capable? */
+		if (dom_info) { /* start new quota domain */
+		    	dqdom = mnt->mnt_mountpoint->d_inode->i_ino;
+			dqhput(mnt->mnt_dqh);
+			mnt->mnt_dqh = get_dqhash(mnt->mnt_sb, dqdom);
+	    	    	dqdom_modify(mnt->mnt_root->d_inode, dqdom);
+		}
 		err = graft_tree(mnt, nd);
 		if (err) {
 			spin_lock(&dcache_lock);
@@ -733,7 +747,7 @@
 		retval = do_remount(&nd, flags & ~MS_REMOUNT, mnt_flags,
 				    data_page);
 	else if (flags & MS_BIND)
-		retval = do_loopback(&nd, dev_name, flags & MS_REC);
+		retval = do_loopback(&nd, dev_name, type_page, flags & MS_REC);
 	else if (flags & MS_MOVE)
 		retval = do_move_mount(&nd, dev_name);
 	else
diff -NurP --minimal linux-2.4.22-pre7-mq0.06/fs/quota.c linux-2.4.22-pre7-mq0.06-bq0.02/fs/quota.c
--- linux-2.4.22-pre7-mq0.06/fs/quota.c	2003-07-22 02:51:57.000000000 +0200
+++ linux-2.4.22-pre7-mq0.06-bq0.02/fs/quota.c	2003-07-22 02:20:07.000000000 +0200
@@ -133,6 +133,35 @@
 	return ERR_PTR(ret);
 }
 
+/* Resolve mount pathname to dqhash */
+static struct dqhash *resolve_mnt(const char *path)
+{
+	int ret;
+	mode_t mode;
+	struct nameidata nd;
+	kdev_t dev;
+	struct dqhash *dqh;
+
+	ret = user_path_walk(path, &nd);
+	if (ret)
+		goto out;
+
+	dev = nd.dentry->d_inode->i_rdev;
+	mode = nd.dentry->d_inode->i_mode;
+	path_release(&nd);
+
+	ret = -ENOTBLK;
+	if (!S_ISDIR(mode))
+		goto out;
+	ret = -ENODEV;	/* compatible, but correct? */
+	dqh = nd.dentry->d_inode->i_dqh;
+	if (!dqh)
+		goto out;
+	return dqh;
+out:
+	return ERR_PTR(ret);
+}
+
 /* Copy parameters and call proper function */
 static int do_quotactl(struct dqhash *hash, int type, int cmd, qid_t id, caddr_t addr)
 {
@@ -472,7 +501,11 @@
 	if (cmds != Q_V1_GETSTATS && cmds != Q_V2_GETSTATS && IS_ERR(sb = resolve_dev(special))) {
 		ret = PTR_ERR(sb);
 		sb = NULL;
-		goto out;
+		/* maybe only a mountpoint was specified? */
+		if (IS_ERR(dqh = resolve_mnt(special))) {
+		    	ret = PTR_ERR(dqh);
+	    	    	goto out;
+		}
 	}
 	else if (sb)
 	    	dqh = sb->s_dqh;
diff -NurP --minimal linux-2.4.22-pre7-mq0.06/fs/super.c linux-2.4.22-pre7-mq0.06-bq0.02/fs/super.c
--- linux-2.4.22-pre7-mq0.06/fs/super.c	2003-07-22 03:09:17.000000000 +0200
+++ linux-2.4.22-pre7-mq0.06-bq0.02/fs/super.c	2003-07-22 00:56:05.000000000 +0200
@@ -271,6 +271,7 @@
 		INIT_LIST_HEAD(&s->s_locked_inodes);
 		INIT_LIST_HEAD(&s->s_files);
 		INIT_LIST_HEAD(&s->s_instances);
+		INIT_LIST_HEAD(&s->s_dqhashes);
 		init_rwsem(&s->s_umount);
 		sema_init(&s->s_lock, 1);
 		down_write(&s->s_umount);
@@ -280,8 +281,7 @@
 		sema_init(&s->s_nfsd_free_path_sem,1);
 		s->s_maxbytes = MAX_NON_LFS;
 		s->s_op = &empty_sops;
-   	    	/* quick hack to make dqhash id unique, sufficient for now */
-		s->s_dqh = new_dqhash(s, (unsigned int)s);
+		s->s_dqh = new_dqhash(s, 0);
 	}
 	return s;
 }
@@ -294,7 +294,10 @@
  */
 static inline void destroy_super(struct super_block *s)
 {
-    	destroy_dqhash(s->s_dqh);
+    	dqhput(s->s_dqh);
+	
+	if (!list_empty(&s->s_dqhashes))
+	    	BUG();
 	kfree(s);
 }
 
@@ -810,6 +813,7 @@
 	if (type->fs_flags & FS_NOMOUNT)
 		sb->s_flags |= MS_NOUSER;
 	mnt->mnt_sb = sb;
+	mnt->mnt_dqh = dqhget(sb->s_dqh);
 	mnt->mnt_root = dget(sb->s_root);
 	mnt->mnt_mountpoint = sb->s_root;
 	mnt->mnt_parent = mnt;
diff -NurP --minimal linux-2.4.22-pre7-mq0.06/include/linux/ext2_fs.h linux-2.4.22-pre7-mq0.06-bq0.02/include/linux/ext2_fs.h
--- linux-2.4.22-pre7-mq0.06/include/linux/ext2_fs.h	2003-07-22 02:56:01.000000000 +0200
+++ linux-2.4.22-pre7-mq0.06-bq0.02/include/linux/ext2_fs.h	2003-07-22 01:05:03.000000000 +0200
@@ -210,6 +210,7 @@
 #define	EXT2_IOC_SETFLAGS		_IOW('f', 2, long)
 #define	EXT2_IOC_GETVERSION		_IOR('v', 1, long)
 #define	EXT2_IOC_SETVERSION		_IOW('v', 2, long)
+#define	EXT2_IOC_GETDQDOM               _IOR('d', 1, long)
 
 /*
  * Structure of an inode on the disk
@@ -249,7 +250,7 @@
 			__u16	i_pad1;
 			__u16	l_i_uid_high;	/* these 2 fields    */
 			__u16	l_i_gid_high;	/* were reserved2[0] */
-			__u32	l_i_reserved2;
+			__u32	l_i_dqdom;
 		} linux2;
 		struct {
 			__u8	h_i_frag;	/* Fragment number */
@@ -278,7 +279,7 @@
 #define i_gid_low	i_gid
 #define i_uid_high	osd2.linux2.l_i_uid_high
 #define i_gid_high	osd2.linux2.l_i_gid_high
-#define i_reserved2	osd2.linux2.l_i_reserved2
+#define i_raw_dqdom	osd2.linux2.l_i_dqdom
 #endif
 
 #ifdef	__hurd__
diff -NurP --minimal linux-2.4.22-pre7-mq0.06/include/linux/fs.h linux-2.4.22-pre7-mq0.06-bq0.02/include/linux/fs.h
--- linux-2.4.22-pre7-mq0.06/include/linux/fs.h	2003-07-22 03:12:14.000000000 +0200
+++ linux-2.4.22-pre7-mq0.06-bq0.02/include/linux/fs.h	2003-07-22 02:04:23.000000000 +0200
@@ -477,6 +477,7 @@
 	struct block_device	*i_bdev;
 	struct char_device	*i_cdev;
 
+	unsigned long		i_dqdom;          /* last diskquota domain */
 	unsigned long		i_dnotify_mask; /* Directory notify events */
 	struct dnotify_struct	*i_dnotify; /* for directory notifications */
 
@@ -759,7 +760,8 @@
 
 	struct block_device	*s_bdev;
 	struct list_head	s_instances;
-	struct dqhash	    	*s_dqh;	    	/* Diskquota hash */
+	struct dqhash	    	*s_dqh;
+	struct list_head	s_dqhashes;   	/* Diskquota hashes */
 
 	union {
 		struct minix_sb_info	minix_sb;
diff -NurP --minimal linux-2.4.22-pre7-mq0.06/include/linux/quota.h linux-2.4.22-pre7-mq0.06-bq0.02/include/linux/quota.h
--- linux-2.4.22-pre7-mq0.06/include/linux/quota.h	2003-07-22 03:11:31.000000000 +0200
+++ linux-2.4.22-pre7-mq0.06-bq0.02/include/linux/quota.h	2003-07-22 02:04:11.000000000 +0200
@@ -314,19 +314,35 @@
 struct dqhash {
 	struct list_head dqh_list;	/* List of all quota hashes */
 	unsigned int dqh_id;		/* ID for hash */
+	int dqh_count;			/* Use count */
 	struct quota_info dqh_dqopt;	/* Diskquota specific options */
 	struct dquot_operations	*dqh_qop;
 	struct quotactl_ops *dqh_qcop;
     	struct super_block *dqh_sb; 	/* super block */
     	struct list_head dqh_hash[NR_DQHASH];
+	unsigned long dqh_dqdom;	/* Diskquota domain */
 };
 
 #if defined(CONFIG_QUOTA)
 
-
-struct dqhash *new_dqhash(struct super_block *, unsigned int);
+struct dqhash *new_dqhash(struct super_block *, unsigned long);
+struct dqhash *get_dqhash(struct super_block *, unsigned long);
+struct dqhash *get_existing_dqhash(struct super_block *, unsigned long);
 void destroy_dqhash(struct dqhash *);
-struct dqhash *find_dqhash(unsigned int);
+
+static inline void dqhput(struct dqhash *hash)
+{
+	if (--hash->dqh_count > 0)
+	    	return;
+    	destroy_dqhash(hash);
+}
+
+static inline struct dqhash *dqhget(struct dqhash *hash)
+{
+	hash->dqh_count++;
+    	return hash; 
+}
+
 
 static inline void mark_dquot_dirty(struct dquot *dq)
 {
@@ -337,9 +353,12 @@
 #else /* CONFIG_QUOTA */
 
 #define new_dqhash(sb, dqdom)		(0)
-#define find_dqhash(dqdom)		(0)
+#define get_dqhash(sb, dqdom)		(0)
 #define destroy_dqhash(hash)		do { } while(0)
 
+#define dqhput(hash)			do { } while(0)
+#define dqhget(hash)			(hash)
+
 #endif /* CONFIG_QUOTA */
 
 #else
diff -NurP --minimal linux-2.4.22-pre7-mq0.06/include/linux/quotaops.h linux-2.4.22-pre7-mq0.06-bq0.02/include/linux/quotaops.h
--- linux-2.4.22-pre7-mq0.06/include/linux/quotaops.h	2003-07-22 03:23:13.000000000 +0200
+++ linux-2.4.22-pre7-mq0.06-bq0.02/include/linux/quotaops.h	2003-07-22 02:21:13.000000000 +0200
@@ -35,6 +35,7 @@
 extern void dquot_free_inode(const struct inode *inode, unsigned long number);
 
 extern int  dquot_transfer(struct inode *inode, struct iattr *iattr);
+extern int  dqhash_transfer(struct inode *inode, struct dqhash *hash);
 
 /*
  * Operations supported for diskquotas.
@@ -177,6 +178,74 @@
 	return ret;
 }
 
+static __inline__ void dqdom_modify(struct inode *inode, unsigned long dqdom)
+{
+    	struct dqhash *new_dqh;
+
+	new_dqh = get_existing_dqhash(inode->i_sb, dqdom);
+	if (!new_dqh)
+	    	/* fallback to superblock hash */
+		new_dqh = dqhget(inode->i_sb->s_dqh);
+	    	
+	dqhash_transfer(inode, new_dqh);
+	dqhput(inode->i_dqh);
+	inode->i_dqh = new_dqh;
+	inode->i_dqdom = new_dqh->dqh_dqdom;
+	mark_inode_dirty(inode);
+}
+
+static __inline__ void dqdom_cond_modify(struct inode *inode, unsigned long dqdom)
+{
+	if (inode->i_dqdom != dqdom)
+    	    	dqdom_modify(inode, dqdom);
+}
+
+static __inline__ void dqdom_unlink(struct inode *dir, struct inode *inode)
+{
+	if (inode->i_nlink == 0)
+	    	return;
+	/* inode from other dir? */
+    	if (inode->i_dqdom != dir->i_dqdom)
+		return;
+	/* inode still referenced ... */
+	if (!inode->i_dqdom)
+	    	return;
+	/* transfer back to superblock hash */
+	dqdom_modify(inode, 0);
+}
+
+
+static __inline__ void dqdom_update(struct inode *dir, struct dentry *dentry)
+{
+    	if (!dentry->d_inode)
+	    	BUG();
+    	if (dentry->d_inode->i_dqdom == dir->i_dqdom)
+	    	BUG();
+	dqdom_modify(dentry->d_inode, dir->i_dqdom);
+}
+
+static __inline__ void dqdom_cond_update(struct inode *dir, struct dentry *dentry)
+{
+    	if (!dentry->d_inode)
+	    	BUG();
+	if (dentry->d_inode->i_dqdom != dir->i_dqdom)
+	    	dqdom_modify(dentry->d_inode, dir->i_dqdom);
+}
+
+static __inline__ void dqdom_lookup_update(struct inode *dir, struct dentry *dentry)
+{
+    	if (!dentry->d_inode)
+	    	return; /* negative pathwalk */
+	dqdom_cond_update(dir, dentry);
+}
+
+static __inline__ void dqdom_unlink_update(struct inode *dir, struct dentry *dentry)
+{
+    	if (!dentry->d_inode)
+	    	BUG();
+	dqdom_unlink(dir, dentry->d_inode);
+}
+
 #else
 
 /*
@@ -192,6 +263,17 @@
 #define DQUOT_OFF(sb)				do { } while(0)
 #define DQUOT_TRANSFER(inode, iattr)		(0)
 
+#define dqdom_lookup_update(inode, dentry)	do { } while(0)
+#define dqdom_unlink_update(inode, dentry)	do { } while(0)
+#define dqdom_cond_update(inode, dentry)	do { } while(0)
+
+#define dqdom_modify(inode, dqdom)		do { } while(0)
+#define dqdom_cond_modify(inode, dqdom)		do { } while(0)
+
+#define new_dqhash(sb, dqdom)			(0)
+#define get_dqhash(sb, dqdom)			(0)
+#define destroy_dqhash(hash)			do { } while(0)
+
 extern __inline__ int DQUOT_PREALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
 {
 	lock_kernel();

--fUYQa+Pmc3FrFX/N--
