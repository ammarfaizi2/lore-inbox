Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268829AbTGOQ2O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 12:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268790AbTGOQ2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 12:28:13 -0400
Received: from www.13thfloor.AT ([212.16.59.250]:36539 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S268586AbTGOQZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 12:25:53 -0400
Date: Tue, 15 Jul 2003 18:40:49 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Quota Hash Abstraction 2.4.22-pre6
Message-ID: <20030715164049.GA27550@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@ucw.cz>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline


Hi All!

I did some quota hash abstraction, which basically
replaces the one-and-only quota hash, referenced by
each and every super block (where quota enabled), 
with a dynamic, per super_block quota hash ...

this is the first step, and it is neither tuned for
performance nor the final implementation, it's just 
a in-between step to some future quota enhancements 
like the folowing ...

 - faster and smaller quota hashes
 - not only per super_block hashes, maybe per vfsmount?
 - not hardcoded user/group quota ...
 - better interface for quota extensions

please, if somebody has any quota tests, which he/she
is willing to do on this code, or just want to do some 
testing with this code, do it and send me the results ...

I'm not interested in getting this into 2.4 without
good reasons and extensive testing.

TIA,
Herbert


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="patch-2.4.22-pre6-mq0.04.diff"
Content-Transfer-Encoding: 8bit

;
; Quota Hash Abstraction 
;
; separate quota hashes per superblock to speed up
; hash lookups and generalize the quota hash interface.
;
; (C) 2003 Herbert Pötzl <herbert@13thfloor.at>
;
; Changelog:  
;
;   0.04  - first public release
;
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

diff -NurbP --minimal linux-2.4.22-pre6/fs/dquot.c linux-2.4.22-pre6-mq0.04/fs/dquot.c
--- linux-2.4.22-pre6/fs/dquot.c	2003-07-15 18:08:31.000000000 +0200
+++ linux-2.4.22-pre6-mq0.04/fs/dquot.c	2003-07-15 18:14:38.000000000 +0200
@@ -150,7 +152,6 @@
 
 static LIST_HEAD(inuse_list);
 static LIST_HEAD(free_dquots);
-static struct list_head dquot_hash[NR_DQHASH];
 
 static void dqput(struct dquot *);
 static struct dquot *dqduplicate(struct dquot *);
@@ -175,31 +176,33 @@
 	dquot->dq_dup_ref--;
 }
 
-static inline int const hashfn(struct super_block *sb, unsigned int id, int type)
+static inline int const hashfn(unsigned int id, int type)
 {
-	return((HASHDEV(sb->s_dev) ^ id) * (MAXQUOTAS - type)) % NR_DQHASH;
+	return (id * (MAXQUOTAS - type)) % NR_DQHASH;
 }
 
-static inline void insert_dquot_hash(struct dquot *dquot)
+static inline void insert_dquot_hash(struct dqhash *hash, struct dquot *dquot)
 {
-	struct list_head *head = dquot_hash + hashfn(dquot->dq_sb, dquot->dq_id, dquot->dq_type);
+	struct list_head *head = hash->dqh_hash + hashfn(dquot->dq_id, dquot->dq_type);
 	list_add(&dquot->dq_hash, head);
+	dquot->dq_dqh = hash;
 }
 
 static inline void remove_dquot_hash(struct dquot *dquot)
 {
 	list_del(&dquot->dq_hash);
 	INIT_LIST_HEAD(&dquot->dq_hash);
+	dquot->dq_dqh = NULL;
 }
 
-static inline struct dquot *find_dquot(unsigned int hashent, struct super_block *sb, unsigned int id, int type)
+static inline struct dquot *find_dquot(struct dqhash *hash, unsigned int hashent, unsigned int id, int type)
 {
 	struct list_head *head;
 	struct dquot *dquot;
 
-	for (head = dquot_hash[hashent].next; head != dquot_hash+hashent; head = head->next) {
+	for (head = hash->dqh_hash[hashent].next; head != hash->dqh_hash+hashent; head = head->next) {
 		dquot = list_entry(head, struct dquot, dq_hash);
-		if (dquot->dq_sb == sb && dquot->dq_id == id && dquot->dq_type == type)
+		if (dquot->dq_id == id && dquot->dq_type == type)
 			return dquot;
 	}
 	return NODQUOT;
@@ -317,7 +320,7 @@
 static int read_dqblk(struct dquot *dquot)
 {
 	int ret;
-	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
+	struct quota_info *dqopt = dqh_dqopt(dquot->dq_dqh);
 
 	lock_dquot(dquot);
 	down(&dqopt->dqio_sem);
@@ -330,7 +333,7 @@
 static int commit_dqblk(struct dquot *dquot)
 {
 	int ret;
-	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
+	struct quota_info *dqopt = dqh_dqopt(dquot->dq_dqh);
 
 	down(&dqopt->dqio_sem);
 	ret = dqopt->ops[dquot->dq_type]->commit_dqblk(dquot);
@@ -341,15 +344,16 @@
 /* Invalidate all dquots on the list, wait for all users. Note that this function is called
  * after quota is disabled so no new quota might be created. As we only insert to the end of
  * inuse list, we don't have to restart searching... */
-static void invalidate_dquots(struct super_block *sb, int type)
+static void invalidate_dquots(struct dqhash *hash, int type)
 {
 	struct dquot *dquot;
 	struct list_head *head;
 
 restart:
+    	/* this could be optimized! (easily?) */
 	list_for_each(head, &inuse_list) {
 		dquot = list_entry(head, struct dquot, dq_inuse);
-		if (dquot->dq_sb != sb)
+		if (dquot->dq_dqh != hash)
 			continue;
 		if (dquot->dq_type != type)
 			continue;
@@ -366,25 +370,82 @@
 		remove_free_dquot(dquot);
 		remove_inuse(dquot);
 		kmem_cache_free(dquot_cachep, dquot);
+		/* hmm, somebody changed his mind? */
 		goto restart;
 	}
 }
 
-static int vfs_quota_sync(struct super_block *sb, int type)
+/* Dquota Hash Management Functions */
+
+static LIST_HEAD(dqhash_list);
+
+
+struct dqhash *new_dqhash(unsigned int id)
+{
+        struct dqhash *hash;
+	int i;
+    	
+	hash = kmalloc(sizeof(struct dqhash),  GFP_USER);
+	if (hash) {
+		memset(hash, 0, sizeof(struct dqhash));
+		hash->dqh_id = id;
+		INIT_LIST_HEAD(&hash->dqh_list);
+		for (i = 0; i < NR_DQHASH; i++)
+			INIT_LIST_HEAD(hash->dqh_hash + i);
+		sema_init(&hash->dqh_dquot.dqio_sem, 1);
+		sema_init(&hash->dqh_dquot.dqoff_sem, 1);
+	}
+	list_add(&hash->dqh_list, &dqhash_list);
+	// printk ("new dqhash %p\n", hash);
+	return hash;
+}
+
+void destroy_dqhash(struct dqhash *hash)
+{
+	int cnt;
+
+	// printk ("destroy dqhash %p\n", hash);
+	list_del(&hash->dqh_list);
+	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
+		invalidate_dquots(hash, cnt);
+	kfree(hash);
+}
+
+
+struct dqhash *find_dqhash(unsigned int id)
+{
+	struct list_head *head;
+	struct dqhash *hash;
+
+	lock_kernel();
+	list_for_each(head, &dqhash_list) {
+		hash = list_entry(head, struct dqhash, dqh_list);
+		if (hash->dqh_id == id)
+			goto dqh_found;
+	}
+	hash = NULL;
+	
+dqh_found:
+	unlock_kernel();
+	return hash;
+}
+
+
+static int vfs_quota_sync(struct dqhash *hash, int type)
 {
 	struct list_head *head;
 	struct dquot *dquot;
-	struct quota_info *dqopt = sb_dqopt(sb);
+	struct quota_info *dqopt = dqh_dqopt(hash);
 	int cnt;
 
 restart:
 	list_for_each(head, &inuse_list) {
 		dquot = list_entry(head, struct dquot, dq_inuse);
-		if (sb && dquot->dq_sb != sb)
+		if (hash && dquot->dq_dqh != hash)
 			continue;
                 if (type != -1 && dquot->dq_type != type)
 			continue;
-		if (!dquot->dq_sb)	/* Invalidated? */
+		if (!dquot->dq_dqh)	/* Invalidated? */
 			continue;
 		if (!dquot_dirty(dquot) && !(dquot->dq_flags & DQ_LOCKED))
 			continue;
@@ -400,11 +461,11 @@
 		goto restart;
 	}
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
-		if ((cnt == type || type == -1) && sb_has_quota_enabled(sb, cnt))
+		if ((cnt == type || type == -1) && dqh_has_quota_enabled(hash, cnt))
 			dqopt->info[cnt].dqi_flags &= ~DQF_ANY_DQUOT_DIRTY;
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
-		if ((cnt == type || type == -1) && sb_has_quota_enabled(sb, cnt) && info_dirty(&dqopt->info[cnt]))
-			dqopt->ops[cnt]->write_file_info(sb, cnt);
+		if ((cnt == type || type == -1) && dqh_has_quota_enabled(hash, cnt) && info_dirty(&dqopt->info[cnt]))
+			dqopt->ops[cnt]->write_file_info(hash, cnt);
 	dqstats.syncs++;
 
 	return 0;
@@ -447,7 +508,7 @@
 		if ((sb = get_super(dev))) {
 			lock_kernel();
 			if (sb->s_qcop->quota_sync)
-				sb->s_qcop->quota_sync(sb, type);
+				sb->s_qcop->quota_sync(sb->s_dqh, type);
 			unlock_kernel();
 			drop_super(sb);
 		}
@@ -456,7 +517,7 @@
 		while ((sb = get_super_to_sync(type))) {
 			lock_kernel();
 			if (sb->s_qcop->quota_sync)
-				sb->s_qcop->quota_sync(sb, type);
+				sb->s_qcop->quota_sync(sb->s_dqh, type);
 			unlock_kernel();
 			drop_super(sb);
 		}
@@ -467,7 +528,7 @@
 {
 	lock_kernel();
 	if (sb->s_qcop->quota_sync)
-		sb->s_qcop->quota_sync(sb, type);
+		sb->s_qcop->quota_sync(sb->s_dqh, type);
 	unlock_kernel();
 }
 
@@ -559,7 +620,7 @@
 	wake_up(&dquot->dq_wait_free);
 }
 
-static struct dquot *get_empty_dquot(struct super_block *sb, int type)
+static struct dquot *get_empty_dquot(struct dqhash *hash, int type)
 {
 	struct dquot *dquot;
 
@@ -573,8 +634,9 @@
 	INIT_LIST_HEAD(&dquot->dq_free);
 	INIT_LIST_HEAD(&dquot->dq_inuse);
 	INIT_LIST_HEAD(&dquot->dq_hash);
-	dquot->dq_sb = sb;
-	dquot->dq_dev = sb->s_dev;
+	dquot->dq_dqh = hash;
+	if (hash->dqh_sb)
+	    	dquot->dq_dev = hash->dqh_sb->s_dev;
 	dquot->dq_type = type;
 	dquot->dq_count = 1;
 	/* all dquots go on the inuse_list */
@@ -583,11 +645,11 @@
 	return dquot;
 }
 
-static struct dquot *dqget(struct super_block *sb, unsigned int id, int type)
+static struct dquot *dqget(struct dqhash *hash, unsigned int id, int type)
 {
-	unsigned int hashent = hashfn(sb, id, type);
+	unsigned int hashent = hashfn(id, type);
 	struct dquot *dquot, *empty = NODQUOT;
-	struct quota_info *dqopt = sb_dqopt(sb);
+	struct quota_info *dqopt = dqh_dqopt(hash);
 
 we_slept:
         if (!is_enabled(dqopt, type)) {
@@ -596,16 +658,16 @@
                 return NODQUOT;
 	}
 
-	if ((dquot = find_dquot(hashent, sb, id, type)) == NODQUOT) {
+	if ((dquot = find_dquot(hash, hashent, id, type)) == NODQUOT) {
 		if (empty == NODQUOT) {
-			if ((empty = get_empty_dquot(sb, type)) == NODQUOT)
+			if ((empty = get_empty_dquot(hash, type)) == NODQUOT)
 				schedule();	/* Try to wait for a moment... */
 			goto we_slept;
 		}
 		dquot = empty;
 		dquot->dq_id = id;
 		/* hash it first so it can be found */
-		insert_dquot_hash(dquot);
+		insert_dquot_hash(hash, dquot);
 		read_dqblk(dquot);
 	} else {
 		if (!dquot->dq_count)
@@ -617,7 +679,7 @@
 			dqput(empty);
 	}
 
-	if (!dquot->dq_sb) {	/* Has somebody invalidated entry under us? */
+	if (!dquot->dq_dqh) {	/* Has somebody invalidated entry under us? */
 		printk(KERN_ERR "VFS: dqget(): Quota invalidated in dqget()!\n");
 		dqput(dquot);
 		return NODQUOT;
@@ -634,7 +696,7 @@
 	if (dquot == NODQUOT)
 		return NODQUOT;
 	get_dquot_ref(dquot);
-	if (!dquot->dq_sb) {
+	if (!dquot->dq_dqh) {
 		printk(KERN_ERR "VFS: dqduplicate(): Invalidated quota to be duplicated!\n");
 		put_dquot_ref(dquot);
 		return NODQUOT;
@@ -676,9 +738,11 @@
 	return 0;
 }
 
-static void add_dquot_ref(struct super_block *sb, int type)
+/*when, where and why is this called? */
+static void add_dquot_ref(struct dqhash *hash, int type)
 {
 	struct list_head *p;
+	struct super_block *sb = hash->dqh_sb;
 
 restart:
 	file_list_lock();
@@ -821,7 +885,7 @@
 	if (!need_print_warning(dquot, flag))
 		return;
 	dquot->dq_flags |= flag;
-	tty_write_message(current->tty, (char *)bdevname(dquot->dq_sb->s_dev));
+	tty_write_message(current->tty, (char *)bdevname(dquot->dq_dqh->dqh_sb->s_dev));
 	if (warntype == ISOFTWARN || warntype == BSOFTWARN)
 		tty_write_message(current->tty, ": warning, ");
 	else
@@ -861,7 +925,7 @@
 
 static inline char ignore_hardlimit(struct dquot *dquot)
 {
-	struct mem_dqinfo *info = &sb_dqopt(dquot->dq_sb)->info[dquot->dq_type];
+	struct mem_dqinfo *info = &dqh_dqopt(dquot->dq_dqh)->info[dquot->dq_type];
 
 	return capable(CAP_SYS_RESOURCE) &&
 	    (info->dqi_format->qf_fmt_id != QFMT_VFS_OLD || !(info->dqi_flags & V1_DQF_RSQUASH));
@@ -892,7 +956,7 @@
 	   (dquot->dq_dqb.dqb_curinodes + inodes) > dquot->dq_dqb.dqb_isoftlimit &&
 	    dquot->dq_dqb.dqb_itime == 0) {
 		*warntype = ISOFTWARN;
-		dquot->dq_dqb.dqb_itime = CURRENT_TIME + sb_dqopt(dquot->dq_sb)->info[dquot->dq_type].dqi_igrace;
+		dquot->dq_dqb.dqb_itime = CURRENT_TIME + dqh_dqopt(dquot->dq_dqh)->info[dquot->dq_type].dqi_igrace;
 	}
 
 	return QUOTA_OK;
@@ -926,7 +990,7 @@
 	    dquot->dq_dqb.dqb_btime == 0) {
 		if (!prealloc) {
 			*warntype = BSOFTWARN;
-			dquot->dq_dqb.dqb_btime = CURRENT_TIME + sb_dqopt(dquot->dq_sb)->info[dquot->dq_type].dqi_bgrace;
+			dquot->dq_dqb.dqb_btime = CURRENT_TIME + dqh_dqopt(dquot->dq_dqh)->info[dquot->dq_type].dqi_bgrace;
 		}
 		else
 			/*
@@ -947,6 +1011,7 @@
 void dquot_initialize(struct inode *inode, int type)
 {
 	struct dquot *dquot[MAXQUOTAS];
+	struct dqhash *dqh = inode->i_sb->s_dqh;
 	unsigned int id = 0;
 	int cnt;
 
@@ -957,7 +1022,7 @@
 		dquot[cnt] = NODQUOT;
 		if (type != -1 && cnt != type)
 			continue;
-		if (!sb_has_quota_enabled(inode->i_sb, cnt))
+		if (!dqh_has_quota_enabled(dqh, cnt))
 			continue;
 		if (inode->i_dquot[cnt] == NODQUOT) {
 			switch (cnt) {
@@ -968,12 +1033,12 @@
 					id = inode->i_gid;
 					break;
 			}
-			dquot[cnt] = dqget(inode->i_sb, id, cnt);
+			dquot[cnt] = dqget(dqh, id, cnt);
 		}
 	}
 	/* NOBLOCK START: Here we shouldn't block */
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		if (dquot[cnt] == NODQUOT || !sb_has_quota_enabled(inode->i_sb, cnt) || inode->i_dquot[cnt] != NODQUOT)
+		if (dquot[cnt] == NODQUOT || !dqh_has_quota_enabled(dqh, cnt) || inode->i_dquot[cnt] != NODQUOT)
 			continue;
 		inode->i_dquot[cnt] = dquot[cnt];
 		dquot[cnt] = NODQUOT;
@@ -1129,6 +1194,7 @@
 	qsize_t space;
 	struct dquot *transfer_from[MAXQUOTAS];
 	struct dquot *transfer_to[MAXQUOTAS];
+    	struct dqhash *dqh = inode->i_sb->s_dqh;
 	int cnt, ret = NO_QUOTA, chuid = (iattr->ia_valid & ATTR_UID) && inode->i_uid != iattr->ia_uid,
 	    chgid = (iattr->ia_valid & ATTR_GID) && inode->i_gid != iattr->ia_gid;
 	char warntype[MAXQUOTAS];
@@ -1140,18 +1206,18 @@
 	}
 	/* First build the transfer_to list - here we can block on reading of dquots... */
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		if (!sb_has_quota_enabled(inode->i_sb, cnt))
+		if (!dqh_has_quota_enabled(dqh, cnt))
 			continue;
 		switch (cnt) {
 			case USRQUOTA:
 				if (!chuid)
 					continue;
-				transfer_to[cnt] = dqget(inode->i_sb, iattr->ia_uid, cnt);
+				transfer_to[cnt] = dqget(dqh, iattr->ia_uid, cnt);
 				break;
 			case GRPQUOTA:
 				if (!chgid)
 					continue;
-				transfer_to[cnt] = dqget(inode->i_sb, iattr->ia_gid, cnt);
+				transfer_to[cnt] = dqget(dqh, iattr->ia_gid, cnt);
 				break;
 		}
 	}
@@ -1160,7 +1226,7 @@
 	/* Build the transfer_from list and check the limits */
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		/* The second test can fail when quotaoff is in progress... */
-		if (transfer_to[cnt] == NODQUOT || !sb_has_quota_enabled(inode->i_sb, cnt))
+		if (transfer_to[cnt] == NODQUOT || !dqh_has_quota_enabled(dqh, cnt))
 			continue;
 		transfer_from[cnt] = dqduplicate(inode->i_dquot[cnt]);
 		if (transfer_from[cnt] == NODQUOT)	/* Can happen on quotafiles (quota isn't initialized on them)... */
@@ -1254,19 +1320,17 @@
 }
 
 /* Function in inode.c - remove pointers to dquots in icache */
-extern void remove_dquot_ref(struct super_block *, int);
+extern void remove_dquot_ref(struct dqhash *, int);
 
 /*
  * Turn quota off on a device. type == -1 ==> quotaoff for all types (umount)
  */
-int vfs_quota_off(struct super_block *sb, int type)
+int vfs_quota_off(struct dqhash *hash, int type)
 {
 	int cnt;
-	struct quota_info *dqopt = sb_dqopt(sb);
+	struct quota_info *dqopt = dqh_dqopt(hash);
 
 	lock_kernel();
-	if (!sb)
-		goto out;
 
 	/* We need to serialize quota_off() for device */
 	down(&dqopt->dqoff_sem);
@@ -1278,12 +1342,12 @@
 		reset_enable_flags(dqopt, cnt);
 
 		/* Note: these are blocking operations */
-		remove_dquot_ref(sb, cnt);
-		invalidate_dquots(sb, cnt);
+		remove_dquot_ref(hash, cnt);
+		invalidate_dquots(hash, cnt);
 		if (info_dirty(&dqopt->info[cnt]))
-			dqopt->ops[cnt]->write_file_info(sb, cnt);
+			dqopt->ops[cnt]->write_file_info(hash, cnt);
 		if (dqopt->ops[cnt]->free_file_info)
-			dqopt->ops[cnt]->free_file_info(sb, cnt);
+			dqopt->ops[cnt]->free_file_info(hash, cnt);
 		put_quota_format(dqopt->info[cnt].dqi_format);
 
 		fput(dqopt->files[cnt]);
@@ -1299,11 +1363,11 @@
 	return 0;
 }
 
-int vfs_quota_on(struct super_block *sb, int type, int format_id, char *path)
+int vfs_quota_on(struct dqhash *hash, int type, int format_id, char *path)
 {
 	struct file *f = NULL;
 	struct inode *inode;
-	struct quota_info *dqopt = sb_dqopt(sb);
+	struct quota_info *dqopt = dqh_dqopt(hash);
 	struct quota_format_type *fmt = find_quota_format(format_id);
 	int error;
 
@@ -1330,7 +1394,7 @@
 	if (!S_ISREG(inode->i_mode))
 		goto out_f;
 	error = -EINVAL;
-	if (!fmt->qf_ops->check_quota_file(sb, type))
+	if (!fmt->qf_ops->check_quota_file(hash, type))
 		goto out_f;
 	/* We don't want quota on quota files */
 	dquot_drop(inode);
@@ -1338,11 +1402,11 @@
 
 	dqopt->ops[type] = fmt->qf_ops;
 	dqopt->info[type].dqi_format = fmt;
-	if ((error = dqopt->ops[type]->read_file_info(sb, type)) < 0)
+	if ((error = dqopt->ops[type]->read_file_info(hash, type)) < 0)
 		goto out_f;
 	set_enable_flags(dqopt, type);
 
-	add_dquot_ref(sb, type);
+	add_dquot_ref(hash, type);
 
 	up(&dqopt->dqoff_sem);
 	return 0;
@@ -1375,9 +1439,9 @@
 	di->dqb_valid = QIF_ALL;
 }
 
-int vfs_get_dqblk(struct super_block *sb, int type, qid_t id, struct if_dqblk *di)
+int vfs_get_dqblk(struct dqhash *hash, int type, qid_t id, struct if_dqblk *di)
 {
-	struct dquot *dquot = dqget(sb, id, type);
+	struct dquot *dquot = dqget(hash, id, type);
 
 	if (!dquot)
 		return -EINVAL;
@@ -1421,7 +1485,7 @@
 			dquot->dq_flags &= ~DQ_BLKS;
 		}
 		else if (!(di->dqb_valid & QIF_BTIME))	/* Set grace only if user hasn't provided his own... */
-			dm->dqb_btime = CURRENT_TIME + sb_dqopt(dquot->dq_sb)->info[dquot->dq_type].dqi_bgrace;
+			dm->dqb_btime = CURRENT_TIME + dqh_dqopt(dquot->dq_dqh)->info[dquot->dq_type].dqi_bgrace;
 	}
 	if (check_ilim) {
 		if (!dm->dqb_isoftlimit || dm->dqb_curinodes < dm->dqb_isoftlimit) {
@@ -1429,7 +1493,7 @@
 			dquot->dq_flags &= ~DQ_INODES;
 		}
 		else if (!(di->dqb_valid & QIF_ITIME))	/* Set grace only if user hasn't provided his own... */
-			dm->dqb_itime = CURRENT_TIME + sb_dqopt(dquot->dq_sb)->info[dquot->dq_type].dqi_igrace;
+			dm->dqb_itime = CURRENT_TIME + dqh_dqopt(dquot->dq_dqh)->info[dquot->dq_type].dqi_igrace;
 	}
 	if (dm->dqb_bhardlimit || dm->dqb_bsoftlimit || dm->dqb_ihardlimit || dm->dqb_isoftlimit)
 		dquot->dq_flags &= ~DQ_FAKE;
@@ -1438,9 +1502,9 @@
 	dquot->dq_flags |= DQ_MOD;
 }
 
-int vfs_set_dqblk(struct super_block *sb, int type, qid_t id, struct if_dqblk *di)
+int vfs_set_dqblk(struct dqhash *hash, int type, qid_t id, struct if_dqblk *di)
 {
-	struct dquot *dquot = dqget(sb, id, type);
+	struct dquot *dquot = dqget(hash, id, type);
 
 	if (!dquot)
 		return -EINVAL;
@@ -1450,9 +1514,9 @@
 }
 
 /* Generic routine for getting common part of quota file information */
-int vfs_get_dqinfo(struct super_block *sb, int type, struct if_dqinfo *ii)
+int vfs_get_dqinfo(struct dqhash *hash, int type, struct if_dqinfo *ii)
 {
-	struct mem_dqinfo *mi = sb_dqopt(sb)->info + type;
+	struct mem_dqinfo *mi = dqh_dqopt(hash)->info + type;
 
 	ii->dqi_bgrace = mi->dqi_bgrace;
 	ii->dqi_igrace = mi->dqi_igrace;
@@ -1462,9 +1526,9 @@
 }
 
 /* Generic routine for setting common part of quota file information */
-int vfs_set_dqinfo(struct super_block *sb, int type, struct if_dqinfo *ii)
+int vfs_set_dqinfo(struct dqhash *hash, int type, struct if_dqinfo *ii)
 {
-	struct mem_dqinfo *mi = sb_dqopt(sb)->info + type;
+	struct mem_dqinfo *mi = dqh_dqopt(hash)->info + type;
 
 	if (ii->dqi_valid & IIF_BGRACE)
 		mi->dqi_bgrace = ii->dqi_bgrace;
@@ -1510,11 +1574,7 @@
 
 static int __init dquot_init(void)
 {
-	int i;
-
 	register_sysctl_table(sys_table, 0);
-	for (i = 0; i < NR_DQHASH; i++)
-		INIT_LIST_HEAD(dquot_hash + i);
 	printk(KERN_NOTICE "VFS: Disk quotas v%s\n", __DQUOT_VERSION__);
 
 	return 0;
diff -NurbP --minimal linux-2.4.22-pre6/fs/inode.c linux-2.4.22-pre6-mq0.04/fs/inode.c
--- linux-2.4.22-pre6/fs/inode.c	2003-07-15 18:08:31.000000000 +0200
+++ linux-2.4.22-pre6-mq0.04/fs/inode.c	2003-07-15 18:14:38.000000000 +0200
@@ -1205,13 +1205,15 @@
 void put_dquot_list(struct list_head *);
 int remove_inode_dquot_ref(struct inode *, short, struct list_head *);
 
-void remove_dquot_ref(struct super_block *sb, short type)
+void remove_dquot_ref(struct dqhash *hash, short type)
 {
 	struct inode *inode;
 	struct list_head *act_head;
+    	struct super_block *sb = hash->dqh_sb;
 	LIST_HEAD(tofree_head);
 
-	if (!sb->dq_op)
+    	/* fix this later!!, we need dq_op here? */
+	if (sb && !sb->dq_op)
 		return;	/* nothing to do */
 	/* We have to be protected against other CPUs */
 	lock_kernel();		/* This lock is for quota code */
diff -NurbP --minimal linux-2.4.22-pre6/fs/quota.c linux-2.4.22-pre6-mq0.04/fs/quota.c
--- linux-2.4.22-pre6/fs/quota.c	2003-07-15 18:08:32.000000000 +0200
+++ linux-2.4.22-pre6-mq0.04/fs/quota.c	2003-07-15 18:14:38.000000000 +0200
@@ -136,6 +136,7 @@
 /* Copy parameters and call proper function */
 static int do_quotactl(struct super_block *sb, int type, int cmd, qid_t id, caddr_t addr)
 {
+    	struct dqhash *dqh = sb->s_dqh;
 	int ret;
 
 	switch (cmd) {
@@ -144,17 +145,17 @@
 
 			if (IS_ERR(pathname = getname(addr)))
 				return PTR_ERR(pathname);
-			ret = sb->s_qcop->quota_on(sb, type, id, pathname);
+			ret = sb->s_qcop->quota_on(dqh, type, id, pathname);
 			putname(pathname);
 			return ret;
 		}
 		case Q_QUOTAOFF:
-			return sb->s_qcop->quota_off(sb, type);
+			return sb->s_qcop->quota_off(dqh, type);
 
 		case Q_GETFMT: {
 			__u32 fmt;
 
-			fmt = sb_dqopt(sb)->info[type].dqi_format->qf_fmt_id;
+			fmt = dqh_dqopt(dqh)->info[type].dqi_format->qf_fmt_id;
 			if (copy_to_user(addr, &fmt, sizeof(fmt)))
 				return -EFAULT;
 			return 0;
@@ -162,7 +163,7 @@
 		case Q_GETINFO: {
 			struct if_dqinfo info;
 
-			if ((ret = sb->s_qcop->get_info(sb, type, &info)))
+			if ((ret = sb->s_qcop->get_info(dqh, type, &info)))
 				return ret;
 			if (copy_to_user(addr, &info, sizeof(info)))
 				return -EFAULT;
@@ -173,12 +174,12 @@
 
 			if (copy_from_user(&info, addr, sizeof(info)))
 				return -EFAULT;
-			return sb->s_qcop->set_info(sb, type, &info);
+			return sb->s_qcop->set_info(dqh, type, &info);
 		}
 		case Q_GETQUOTA: {
 			struct if_dqblk idq;
 
-			if ((ret = sb->s_qcop->get_dqblk(sb, type, id, &idq)))
+			if ((ret = sb->s_qcop->get_dqblk(dqh, type, id, &idq)))
 				return ret;
 			if (copy_to_user(addr, &idq, sizeof(idq)))
 				return -EFAULT;
@@ -189,11 +190,11 @@
 
 			if (copy_from_user(&idq, addr, sizeof(idq)))
 				return -EFAULT;
-			return sb->s_qcop->set_dqblk(sb, type, id, &idq);
+			return sb->s_qcop->set_dqblk(dqh, type, id, &idq);
 		}
 		case Q_SYNC:
 			if (sb)
-				return sb->s_qcop->quota_sync(sb, type);
+				return sb->s_qcop->quota_sync(dqh, type);
 			sync_dquots_dev(NODEV, type);
 			return 0;
 		case Q_XQUOTAON:
@@ -320,18 +321,20 @@
 static int v1_set_rsquash(struct super_block *sb, int type, int flag)
 {
 	struct if_dqinfo info;
+	struct dqhash *dqh = sb->s_dqh;
 
 	info.dqi_valid = IIF_FLAGS;
 	info.dqi_flags = flag ? V1_DQF_RSQUASH : 0;
-	return sb->s_qcop->set_info(sb, type, &info);
+	return sb->s_qcop->set_info(dqh, type, &info);
 }
 
 static int v1_get_dqblk(struct super_block *sb, int type, qid_t id, struct v1c_mem_dqblk *mdq)
 {
 	struct if_dqblk idq;
+	struct dqhash *dqh = sb->s_dqh;
 	int ret;
 
-	if ((ret = sb->s_qcop->get_dqblk(sb, type, id, &idq)) < 0)
+	if ((ret = sb->s_qcop->get_dqblk(dqh, type, id, &idq)) < 0)
 		return ret;
 	mdq->dqb_ihardlimit = idq.dqb_ihardlimit;
 	mdq->dqb_isoftlimit = idq.dqb_isoftlimit;
@@ -344,7 +347,7 @@
 	if (id == 0) {	/* Times for id 0 are in fact grace times */
 		struct if_dqinfo info;
 
-		if ((ret = sb->s_qcop->get_info(sb, type, &info)) < 0)
+		if ((ret = sb->s_qcop->get_info(dqh, type, &info)) < 0)
 			return ret;
 		mdq->dqb_btime = info.dqi_bgrace;
 		mdq->dqb_itime = info.dqi_igrace;
@@ -355,6 +358,7 @@
 static int v1_set_dqblk(struct super_block *sb, int type, int cmd, qid_t id, struct v1c_mem_dqblk *mdq)
 {
 	struct if_dqblk idq;
+	struct dqhash *dqh = sb->s_dqh;
 	int ret;
 
 	idq.dqb_valid = 0;
@@ -370,14 +374,14 @@
 		idq.dqb_curspace = ((qsize_t)mdq->dqb_curblocks) << QUOTABLOCK_BITS;
 		idq.dqb_valid |= QIF_USAGE;
 	}
-	ret = sb->s_qcop->set_dqblk(sb, type, id, &idq);
+	ret = sb->s_qcop->set_dqblk(dqh, type, id, &idq);
 	if (!ret && id == 0 && cmd == Q_V1_SETQUOTA) {	/* Times for id 0 are in fact grace times */
 		struct if_dqinfo info;
 
 		info.dqi_bgrace = mdq->dqb_btime;
 		info.dqi_igrace = mdq->dqb_itime;
 		info.dqi_valid = IIF_BGRACE | IIF_IGRACE;
-		ret = sb->s_qcop->set_info(sb, type, &info);
+		ret = sb->s_qcop->set_info(dqh, type, &info);
 	}
 	return ret;
 }
@@ -390,23 +394,31 @@
 /* Handle requests to old interface */
 static int do_compat_quotactl(struct super_block *sb, int type, int cmd, qid_t id, caddr_t addr)
 {
+	struct dqhash *dqh;
 	int ret;
 
+    	if (sb)
+	    	dqh = sb->s_dqh;
+	else {	
+	    	printk("sb == NULL"); /* is this possible? */
+	    	dqh = NULL;
+	}
+		
 	switch (cmd) {
 		case Q_COMP_QUOTAON: {
 			char *pathname;
 
 			if (IS_ERR(pathname = getname(addr)))
 				return PTR_ERR(pathname);
-			ret = sb->s_qcop->quota_on(sb, type, QFMT_VFS_OLD, pathname);
+			ret = sb->s_qcop->quota_on(dqh, type, QFMT_VFS_OLD, pathname);
 			putname(pathname);
 			return ret;
 		}
 		case Q_COMP_QUOTAOFF:
-			return sb->s_qcop->quota_off(sb, type);
+			return sb->s_qcop->quota_off(dqh, type);
 		case Q_COMP_SYNC:
 			if (sb)
-				return sb->s_qcop->quota_sync(sb, type);
+				return sb->s_qcop->quota_sync(dqh, type);
 			sync_dquots_dev(NODEV, type);
 			return 0;
 		case Q_V1_RSQUASH: {
diff -NurbP --minimal linux-2.4.22-pre6/fs/quota_v1.c linux-2.4.22-pre6-mq0.04/fs/quota_v1.c
--- linux-2.4.22-pre6/fs/quota_v1.c	2003-07-15 18:08:32.000000000 +0200
+++ linux-2.4.22-pre6-mq0.04/fs/quota_v1.c	2003-07-15 18:14:38.000000000 +0200
@@ -42,7 +42,7 @@
 	loff_t offset;
 	struct v1_disk_dqblk dqblk;
 
-	filp = sb_dqopt(dquot->dq_sb)->files[type];
+	filp = dqh_dqopt(dquot->dq_dqh)->files[type];
 	if (filp == (struct file *)NULL)
 		return -EINVAL;
 
@@ -71,7 +71,7 @@
 	ssize_t ret;
 	struct v1_disk_dqblk dqblk;
 
-	filp = sb_dqopt(dquot->dq_sb)->files[type];
+	filp = dqh_dqopt(dquot->dq_dqh)->files[type];
 	offset = v1_dqoff(dquot->dq_id);
 	fs = get_fs();
 	set_fs(KERNEL_DS);
@@ -83,8 +83,8 @@
 	v1_mem2disk_dqblk(&dqblk, &dquot->dq_dqb);
 	dquot->dq_flags &= ~DQ_MOD;
 	if (dquot->dq_id == 0) {
-		dqblk.dqb_btime = sb_dqopt(dquot->dq_sb)->info[type].dqi_bgrace;
-		dqblk.dqb_itime = sb_dqopt(dquot->dq_sb)->info[type].dqi_igrace;
+		dqblk.dqb_btime = dqh_dqopt(dquot->dq_dqh)->info[type].dqi_bgrace;
+		dqblk.dqb_itime = dqh_dqopt(dquot->dq_dqh)->info[type].dqi_igrace;
 	}
 	ret = 0;
 	if (filp)
@@ -117,9 +117,9 @@
 	__u32 dqh_version;      /* File version */
 };
 
-static int v1_check_quota_file(struct super_block *sb, int type)
+static int v1_check_quota_file(struct dqhash *hash, int type)
 {
-	struct file *f = sb_dqopt(sb)->files[type];
+	struct file *f = dqh_dqopt(hash)->files[type];
 	struct inode *inode = f->f_dentry->d_inode;
 	ulong blocks;
 	size_t off; 
@@ -144,13 +144,13 @@
 		return 1;	/* Probably not new format */
 	if (le32_to_cpu(dqhead.dqh_magic) != quota_magics[type])
 		return 1;	/* Definitely not new format */
-	printk(KERN_INFO "VFS: %s: Refusing to turn on old quota format on given file. It probably contains newer quota format.\n", kdevname(sb->s_dev));
+	printk(KERN_INFO "VFS: %s: Refusing to turn on old quota format on given file. It probably contains newer quota format.\n", kdevname(hash->dqh_sb->s_dev));
         return 0;		/* Seems like a new format file -> refuse it */
 }
 
-static int v1_read_file_info(struct super_block *sb, int type)
+static int v1_read_file_info(struct dqhash *hash, int type)
 {
-	struct quota_info *dqopt = sb_dqopt(sb);
+	struct quota_info *dqopt = dqh_dqopt(hash);
 	mm_segment_t fs;
 	loff_t offset;
 	struct file *filp = dqopt->files[type];
@@ -175,9 +175,9 @@
 	return ret;
 }
 
-static int v1_write_file_info(struct super_block *sb, int type)
+static int v1_write_file_info(struct dqhash *hash, int type)
 {
-	struct quota_info *dqopt = sb_dqopt(sb);
+	struct quota_info *dqopt = dqh_dqopt(hash);
 	mm_segment_t fs;
 	struct file *filp = dqopt->files[type];
 	struct v1_disk_dqblk dqblk;
diff -NurbP --minimal linux-2.4.22-pre6/fs/quota_v2.c linux-2.4.22-pre6-mq0.04/fs/quota_v2.c
--- linux-2.4.22-pre6/fs/quota_v2.c	2003-07-15 18:08:32.000000000 +0200
+++ linux-2.4.22-pre6-mq0.04/fs/quota_v2.c	2003-07-15 18:14:38.000000000 +0200
@@ -22,10 +22,10 @@
 #define GETENTRIES(buf) ((struct v2_disk_dqblk *)(((char *)buf)+sizeof(struct v2_disk_dqdbheader)))
 
 /* Check whether given file is really vfsv0 quotafile */
-static int v2_check_quota_file(struct super_block *sb, int type)
+static int v2_check_quota_file(struct dqhash *hash, int type)
 {
 	struct v2_disk_dqheader dqhead;
-	struct file *f = sb_dqopt(sb)->files[type];
+	struct file *f = dqh_dqopt(hash)->files[type];
 	mm_segment_t fs;
 	ssize_t size;
 	loff_t offset = 0;
@@ -45,12 +45,12 @@
 }
 
 /* Read information header from quota file */
-static int v2_read_file_info(struct super_block *sb, int type)
+static int v2_read_file_info(struct dqhash *hash, int type)
 {
 	mm_segment_t fs;
 	struct v2_disk_dqinfo dinfo;
-	struct mem_dqinfo *info = sb_dqopt(sb)->info+type;
-	struct file *f = sb_dqopt(sb)->files[type];
+	struct mem_dqinfo *info = dqh_dqopt(hash)->info+type;
+	struct file *f = dqh_dqopt(hash)->files[type];
 	ssize_t size;
 	loff_t offset = V2_DQINFOOFF;
 
@@ -73,12 +73,12 @@
 }
 
 /* Write information header to quota file */
-static int v2_write_file_info(struct super_block *sb, int type)
+static int v2_write_file_info(struct dqhash *hash, int type)
 {
 	mm_segment_t fs;
 	struct v2_disk_dqinfo dinfo;
-	struct mem_dqinfo *info = sb_dqopt(sb)->info+type;
-	struct file *f = sb_dqopt(sb)->files[type];
+	struct mem_dqinfo *info = dqh_dqopt(hash)->info+type;
+	struct file *f = dqh_dqopt(hash)->files[type];
 	ssize_t size;
 	loff_t offset = V2_DQINFOOFF;
 
@@ -281,8 +281,8 @@
 /* Find space for dquot */
 static uint find_free_dqentry(struct dquot *dquot, int *err)
 {
-	struct file *filp = sb_dqopt(dquot->dq_sb)->files[dquot->dq_type];
-	struct mem_dqinfo *info = sb_dqopt(dquot->dq_sb)->info+dquot->dq_type;
+	struct file *filp = dqh_dqopt(dquot->dq_dqh)->files[dquot->dq_type];
+	struct mem_dqinfo *info = dqh_dqopt(dquot->dq_dqh)->info+dquot->dq_type;
 	uint blk, i;
 	struct v2_disk_dqdbheader *dh;
 	struct v2_disk_dqblk *ddquot;
@@ -342,8 +342,8 @@
 /* Insert reference to structure into the trie */
 static int do_insert_tree(struct dquot *dquot, uint *treeblk, int depth)
 {
-	struct file *filp = sb_dqopt(dquot->dq_sb)->files[dquot->dq_type];
-	struct mem_dqinfo *info = sb_dqopt(dquot->dq_sb)->info + dquot->dq_type;
+	struct file *filp = dqh_dqopt(dquot->dq_dqh)->files[dquot->dq_type];
+	struct mem_dqinfo *info = dqh_dqopt(dquot->dq_dqh)->info + dquot->dq_type;
 	dqbuf_t buf;
 	int ret = 0, newson = 0, newact = 0;
 	u32 *ref;
@@ -416,7 +416,7 @@
 			printk(KERN_ERR "VFS: Error %d occured while creating quota.\n", ret);
 			return ret;
 		}
-	filp = sb_dqopt(dquot->dq_sb)->files[type];
+	filp = dqh_dqopt(dquot->dq_dqh)->files[type];
 	offset = dquot->dq_off;
 	mem2diskdqb(&ddquot, &dquot->dq_dqb, dquot->dq_id);
 	fs = get_fs();
@@ -437,8 +437,8 @@
 /* Free dquot entry in data block */
 static int free_dqentry(struct dquot *dquot, uint blk)
 {
-	struct file *filp = sb_dqopt(dquot->dq_sb)->files[dquot->dq_type];
-	struct mem_dqinfo *info = sb_dqopt(dquot->dq_sb)->info + dquot->dq_type;
+	struct file *filp = dqh_dqopt(dquot->dq_dqh)->files[dquot->dq_type];
+	struct mem_dqinfo *info = dqh_dqopt(dquot->dq_dqh)->info + dquot->dq_type;
 	struct v2_disk_dqdbheader *dh;
 	dqbuf_t buf = getdqbuf();
 	int ret = 0;
@@ -486,8 +486,8 @@
 /* Remove reference to dquot from tree */
 static int remove_tree(struct dquot *dquot, uint *blk, int depth)
 {
-	struct file *filp = sb_dqopt(dquot->dq_sb)->files[dquot->dq_type];
-	struct mem_dqinfo *info = sb_dqopt(dquot->dq_sb)->info + dquot->dq_type;
+	struct file *filp = dqh_dqopt(dquot->dq_dqh)->files[dquot->dq_type];
+	struct mem_dqinfo *info = dqh_dqopt(dquot->dq_dqh)->info + dquot->dq_type;
 	dqbuf_t buf = getdqbuf();
 	int ret = 0;
 	uint newblk;
@@ -536,7 +536,7 @@
 /* Find entry in block */
 static loff_t find_block_dqentry(struct dquot *dquot, uint blk)
 {
-	struct file *filp = sb_dqopt(dquot->dq_sb)->files[dquot->dq_type];
+	struct file *filp = dqh_dqopt(dquot->dq_dqh)->files[dquot->dq_type];
 	dqbuf_t buf = getdqbuf();
 	loff_t ret = 0;
 	int i;
@@ -573,7 +573,7 @@
 /* Find entry for given id in the tree */
 static loff_t find_tree_dqentry(struct dquot *dquot, uint blk, int depth)
 {
-	struct file *filp = sb_dqopt(dquot->dq_sb)->files[dquot->dq_type];
+	struct file *filp = dqh_dqopt(dquot->dq_dqh)->files[dquot->dq_type];
 	dqbuf_t buf = getdqbuf();
 	loff_t ret = 0;
 	u32 *ref = (u32 *)buf;
@@ -612,10 +612,10 @@
 	struct v2_disk_dqblk ddquot;
 	int ret = 0;
 
-	filp = sb_dqopt(dquot->dq_sb)->files[type];
+	filp = dqh_dqopt(dquot->dq_dqh)->files[type];
 
 #ifdef __QUOTA_V2_PARANOIA
-	if (!filp || !dquot->dq_sb) {	/* Invalidated quota? */
+	if (!filp || !dquot->dq_dqh) {	/* Invalidated quota? */
 		printk(KERN_ERR "VFS: Quota invalidated while reading!\n");
 		return -EIO;
 	}
diff -NurbP --minimal linux-2.4.22-pre6/fs/super.c linux-2.4.22-pre6-mq0.04/fs/super.c
--- linux-2.4.22-pre6/fs/super.c	2003-07-15 18:08:32.000000000 +0200
+++ linux-2.4.22-pre6-mq0.04/fs/super.c	2003-07-15 18:14:38.000000000 +0200
@@ -278,12 +278,13 @@
 		atomic_set(&s->s_active, 1);
 		sema_init(&s->s_vfs_rename_sem,1);
 		sema_init(&s->s_nfsd_free_path_sem,1);
-		sema_init(&s->s_dquot.dqio_sem, 1);
-		sema_init(&s->s_dquot.dqoff_sem, 1);
 		s->s_maxbytes = MAX_NON_LFS;
 		s->s_op = &empty_sops;
 		s->dq_op = sb_dquot_ops;
 		s->s_qcop = sb_quotactl_ops;
+   	    	/* quick hack to make dqhash id unique, sufficient for now */
+		s->s_dqh = new_dqhash((unsigned int)s);
+		s->s_dqh->dqh_sb = s;
 	}
 	return s;
 }
@@ -296,6 +297,7 @@
  */
 static inline void destroy_super(struct super_block *s)
 {
+    	destroy_dqhash(s->s_dqh);
 	kfree(s);
 }
 
diff -NurbP --minimal linux-2.4.22-pre6/include/linux/fs.h linux-2.4.22-pre6-mq0.04/include/linux/fs.h
--- linux-2.4.22-pre6/include/linux/fs.h	2003-07-15 18:08:40.000000000 +0200
+++ linux-2.4.22-pre6-mq0.04/include/linux/fs.h	2003-07-15 18:14:38.000000000 +0200
@@ -759,7 +759,7 @@
 
 	struct block_device	*s_bdev;
 	struct list_head	s_instances;
-	struct quota_info	s_dquot;	/* Diskquota specific options */
+	struct dqhash	    	*s_dqh;	    	/* Diskquota hash */
 
 	union {
 		struct minix_sb_info	minix_sb;
diff -NurbP --minimal linux-2.4.22-pre6/include/linux/mount.h linux-2.4.22-pre6-mq0.04/include/linux/mount.h
--- linux-2.4.22-pre6/include/linux/mount.h	2001-10-05 22:05:55.000000000 +0200
+++ linux-2.4.22-pre6-mq0.04/include/linux/mount.h	2003-07-15 18:14:38.000000000 +0200
@@ -29,6 +29,7 @@
 	int mnt_flags;
 	char *mnt_devname;		/* Name of device e.g. /dev/dsk/hda1 */
 	struct list_head mnt_list;
+    	struct dqhash *mnt_dqh;     	/* Diskquota hash for mount */
 };
 
 static inline struct vfsmount *mntget(struct vfsmount *mnt)
diff -NurbP --minimal linux-2.4.22-pre6/include/linux/quota.h linux-2.4.22-pre6-mq0.04/include/linux/quota.h
--- linux-2.4.22-pre6/include/linux/quota.h	2003-07-15 18:08:41.000000000 +0200
+++ linux-2.4.22-pre6-mq0.04/include/linux/quota.h	2003-07-15 18:14:38.000000000 +0200
@@ -182,7 +182,9 @@
 #define info_any_dirty(info) ((info)->dqi_flags & DQF_INFO_DIRTY ||\
 			      (info)->dqi_flags & DQF_ANY_DQUOT_DIRTY)
 
-#define sb_dqopt(sb) (&(sb)->s_dquot)
+#define sb_dqopt(sb) (dqh_dqopt((sb)->s_dqh))
+
+#define dqh_dqopt(dqh) (&(dqh)->dqh_dquot)
 
 struct dqstats {
 	int lookups;
@@ -216,7 +218,7 @@
 	int dq_dup_ref;			/* Number of duplicated refences */
 
 	/* fields after this point are cleared when invalidating */
-	struct super_block *dq_sb;	/* superblock this applies to */
+	struct dqhash *dq_dqh;		/* quota hash backpointer */
 	unsigned int dq_id;		/* ID this applies to (uid, gid) */
 	kdev_t dq_dev;			/* Device this applies to */
 	loff_t dq_off;			/* Offset of dquot on disk */
@@ -234,12 +236,12 @@
 
 /* Operations which must be implemented by each quota format */
 struct quota_format_ops {
-	int (*check_quota_file)(struct super_block *sb, int type);	/* Detect whether file is in our format */
-	int (*read_file_info)(struct super_block *sb, int type);	/* Read main info about file - called on quotaon() */
-	int (*write_file_info)(struct super_block *sb, int type);	/* Write main info about file */
-	int (*free_file_info)(struct super_block *sb, int type);	/* Called on quotaoff() */
-	int (*read_dqblk)(struct dquot *dquot);		/* Read structure for one user */
-	int (*commit_dqblk)(struct dquot *dquot);	/* Write (or delete) structure for one user */
+	int (*check_quota_file)(struct dqhash *, int);	/* Detect whether file is in our format */
+	int (*read_file_info)(struct dqhash *, int);	/* Read main info about file - called on quotaon() */
+	int (*write_file_info)(struct dqhash *, int);	/* Write main info about file */
+	int (*free_file_info)(struct dqhash *, int);	/* Called on quotaoff() */
+	int (*read_dqblk)(struct dquot *);		/* Read structure for one user */
+	int (*commit_dqblk)(struct dquot *);	    	/* Write (or delete) structure for one user */
 };
 
 /* Operations working with dquots */
@@ -256,13 +258,13 @@
 
 /* Operations handling requests from userspace */
 struct quotactl_ops {
-	int (*quota_on)(struct super_block *, int, int, char *);
-	int (*quota_off)(struct super_block *, int);
-	int (*quota_sync)(struct super_block *, int);
-	int (*get_info)(struct super_block *, int, struct if_dqinfo *);
-	int (*set_info)(struct super_block *, int, struct if_dqinfo *);
-	int (*get_dqblk)(struct super_block *, int, qid_t, struct if_dqblk *);
-	int (*set_dqblk)(struct super_block *, int, qid_t, struct if_dqblk *);
+	int (*quota_on)(struct dqhash *, int, int, char *);
+	int (*quota_off)(struct dqhash *, int);
+	int (*quota_sync)(struct dqhash *, int);
+	int (*get_info)(struct dqhash *, int, struct if_dqinfo *);
+	int (*set_info)(struct dqhash *, int, struct if_dqinfo *);
+	int (*get_dqblk)(struct dqhash *, int, qid_t, struct if_dqblk *);
+	int (*set_dqblk)(struct dqhash *, int, qid_t, struct if_dqblk *);
 	int (*get_xstate)(struct super_block *, struct fs_quota_stat *);
 	int (*set_xstate)(struct super_block *, unsigned int, int);
 	int (*get_xquota)(struct super_block *, int, qid_t, struct fs_disk_quota *);
@@ -288,11 +290,6 @@
 	struct quota_format_ops *ops[MAXQUOTAS];	/* Operations for each type */
 };
 
-/* Inline would be better but we need to dereference super_block which is not defined yet */
-#define mark_dquot_dirty(dquot) do {\
-	dquot->dq_flags |= DQ_MOD;\
-	sb_dqopt(dquot->dq_sb)->info[dquot->dq_type].dqi_flags |= DQF_ANY_DQUOT_DIRTY;\
-} while (0)
 
 #define dquot_dirty(dquot) ((dquot)->dq_flags & DQ_MOD)
 
@@ -311,10 +308,33 @@
 
 #define sb_has_quota_enabled(sb, type) (is_enabled(sb_dqopt(sb), type))
 
+#define dqh_any_quota_enabled(hash) (is_enabled(dqh_dqopt(hash), USRQUOTA)  \
+    	| is_enabled(dqh_dqopt(hash), GRPQUOTA))
+
+#define dqh_has_quota_enabled(hash, type) (is_enabled(dqh_dqopt(hash), type))
+
 int register_quota_format(struct quota_format_type *fmt);
 void unregister_quota_format(struct quota_format_type *fmt);
 void init_dquot_operations(struct dquot_operations *fsdqops);
 
+struct dqhash {
+	unsigned int dqh_id;		/* ID for hash */
+	struct quota_info dqh_dquot;	/* Diskquota specific options */
+	struct list_head dqh_list;	/* List of all quota hashes */
+    	struct super_block *dqh_sb; 	/* super block if applicable */
+    	struct list_head dqh_hash[NR_DQHASH];
+};
+
+struct dqhash *new_dqhash(unsigned int);
+void destroy_dqhash(struct dqhash *);
+struct dqhash *find_dqhash(unsigned int);
+
+static inline void mark_dquot_dirty(struct dquot *dq)
+{
+    	dq->dq_flags |= DQ_MOD;
+	dqh_dqopt(dq->dq_dqh)->info[dq->dq_type].dqi_flags |= DQF_ANY_DQUOT_DIRTY;
+}
+
 #else
 
 # /* nodep */ include <sys/cdefs.h>
diff -NurbP --minimal linux-2.4.22-pre6/include/linux/quotaops.h linux-2.4.22-pre6-mq0.04/include/linux/quotaops.h
--- linux-2.4.22-pre6/include/linux/quotaops.h	2003-07-15 18:08:41.000000000 +0200
+++ linux-2.4.22-pre6-mq0.04/include/linux/quotaops.h	2003-07-15 18:14:38.000000000 +0200
@@ -47,6 +47,8 @@
 {
 	if (!inode->i_sb)
 		out_of_line_bug();
+	if (!inode->i_sb->s_dqh)
+		out_of_line_bug();
 	lock_kernel();
 	if (sb_any_quota_enabled(inode->i_sb) && !IS_NOQUOTA(inode))
 		inode->i_sb->dq_op->initialize(inode, -1);
@@ -59,6 +61,8 @@
 	if (IS_QUOTAINIT(inode)) {
 		if (!inode->i_sb)
 			out_of_line_bug();
+		if (!inode->i_sb->s_dqh)
+			out_of_line_bug();
 		inode->i_sb->dq_op->drop(inode);	/* Ops must be set when there's any quota... */
 	}
 	unlock_kernel();
@@ -173,7 +177,7 @@
 
 	lock_kernel();
 	if (sb->s_qcop && sb->s_qcop->quota_off)
-		ret = sb->s_qcop->quota_off(sb, -1);
+		ret = sb->s_qcop->quota_off(sb->s_dqh, -1);
 	unlock_kernel();
 	return ret;
 }

--bp/iNruPH9dso1Pn--
