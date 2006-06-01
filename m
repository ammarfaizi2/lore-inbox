Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbWFAKDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbWFAKDO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 06:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964923AbWFAKCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 06:02:55 -0400
Received: from mail.suse.de ([195.135.220.2]:53135 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964903AbWFAKCs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 06:02:48 -0400
Message-Id: <20060601100135.261998000@hasse.suse.de>
References: <20060601095125.773684000@hasse.suse.de>
User-Agent: quilt/0.44-16
Date: Thu, 01 Jun 2006 11:51:29 +0200
From: jblunck@suse.de
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, viro@zeniv.linux.org.uk,
       dgc@sgi.com, balbir@in.ibm.com
Subject: [patch 4/5] vfs: per superblock dentry stats
Content-Disposition: inline; filename=patches.jbl/vfs-per-sb-dentry_stat.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds per superblock dentry statistics about unused and absolute
number of dentries.

Signed-off-by: Jan Blunck <jblunck@suse.de>
---
 fs/dcache.c            |   47 ++++++++++++++++++++++++++---------------------
 fs/super.c             |    1 +
 include/linux/dcache.h |   21 +++++++++++++++++----
 include/linux/fs.h     |    1 +
 kernel/sysctl.c        |    2 +-
 5 files changed, 46 insertions(+), 26 deletions(-)

Index: work-2.6/fs/dcache.c
===================================================================
--- work-2.6.orig/fs/dcache.c
+++ work-2.6/fs/dcache.c
@@ -64,7 +64,7 @@ static struct hlist_head *dentry_hashtab
 static LIST_HEAD(dentry_unused);
 
 /* Statistics gathering. */
-struct dentry_stat_t dentry_stat = {
+struct dentry_stat global_dentry_stat = {
 	.age_limit = 45,
 };
 
@@ -173,7 +173,7 @@ repeat:
 	if (list_empty(&dentry->d_lru)) {
 		dentry->d_flags |= DCACHE_REFERENCED;
 		list_add(&dentry->d_lru, &dentry_unused);
-		dentry_stat.nr_unused++;
+		dentry_stat_inc(dentry->d_sb, nr_unused);
 	}
 	spin_unlock(&dentry->d_lock);
 	spin_unlock(&dcache_lock);
@@ -190,11 +190,13 @@ kill_it: {
 		 */
 		if (!list_empty(&dentry->d_lru)) {
 			list_del(&dentry->d_lru);
-			dentry_stat.nr_unused--;
+			dentry_stat_dec(dentry->d_sb, nr_unused);
 		}
 		list_del(&dentry->d_u.d_child);
-		dentry_stat.nr_dentry--;	/* For d_free, below */
-		/*drops the locks, at that point nobody can reach this dentry */
+		/* For d_free, below */
+		dentry_stat_dec(dentry->d_sb, nr_dentry);
+		/* drops the locks, at that point nobody can reach this
+		 * dentry anymore */
 		dentry_iput(dentry);
 		parent = dentry->d_parent;
 		d_free(dentry);
@@ -268,7 +270,7 @@ static inline struct dentry * __dget_loc
 {
 	atomic_inc(&dentry->d_count);
 	if (!list_empty(&dentry->d_lru)) {
-		dentry_stat.nr_unused--;
+		dentry_stat_dec(dentry->d_sb, nr_unused);
 		list_del_init(&dentry->d_lru);
 	}
 	return dentry;
@@ -370,7 +372,7 @@ static inline void prune_one_dentry(stru
 
 	__d_drop(dentry);
 	list_del(&dentry->d_u.d_child);
-	dentry_stat.nr_dentry--;	/* For d_free, below */
+	dentry_stat_dec(dentry->d_sb, nr_dentry);	/* For d_free, below */
 	dentry_iput(dentry);
 	parent = dentry->d_parent;
 	d_free(dentry);
@@ -403,10 +405,10 @@ static void prune_dcache(int count)
 		tmp = dentry_unused.prev;
 		if (tmp == &dentry_unused)
 			break;
-		list_del_init(tmp);
 		prefetch(dentry_unused.prev);
-		dentry_stat.nr_unused--;
 		dentry = list_entry(tmp, struct dentry, d_lru);
+		dentry_stat_dec(dentry->d_sb, nr_unused);
+		list_del_init(&dentry->d_lru);
 
 		spin_lock(&dentry->d_lock);
 		/*
@@ -422,7 +424,7 @@ static void prune_dcache(int count)
 		if (dentry->d_flags & DCACHE_REFERENCED) {
 			dentry->d_flags &= ~DCACHE_REFERENCED;
 			list_add(&dentry->d_lru, &dentry_unused);
-			dentry_stat.nr_unused++;
+			dentry_stat_inc(dentry->d_sb, nr_unused);
 			spin_unlock(&dentry->d_lock);
 			continue;
 		}
@@ -444,7 +446,7 @@ static void select_anon(struct super_blo
 	spin_lock(&dcache_lock);
 	hlist_for_each_entry(dentry, lp, &sb->s_anon, d_hash) {
 		if (!list_empty(&dentry->d_lru)) {
-			dentry_stat.nr_unused--;
+			dentry_stat_dec(sb, nr_unused);
 			list_del_init(&dentry->d_lru);
 		}
 
@@ -455,7 +457,7 @@ static void select_anon(struct super_blo
 		spin_lock(&dentry->d_lock);
 		if (!atomic_read(&dentry->d_count)) {
 			list_add(&dentry->d_lru, &dentry_unused);
-			dentry_stat.nr_unused++;
+			dentry_stat_inc(sb, nr_unused);
 		}
 		spin_unlock(&dentry->d_lock);
 	}
@@ -519,7 +521,7 @@ repeat:
 		dentry = list_entry(tmp, struct dentry, d_lru);
 		if (dentry->d_sb != sb)
 			continue;
-		dentry_stat.nr_unused--;
+		dentry_stat_dec(sb, nr_unused);
 		list_del_init(tmp);
 		spin_lock(&dentry->d_lock);
 		if (atomic_read(&dentry->d_count)) {
@@ -615,7 +617,7 @@ resume:
 		next = tmp->next;
 
 		if (!list_empty(&dentry->d_lru)) {
-			dentry_stat.nr_unused--;
+			dentry_stat_dec(dentry->d_sb, nr_unused);
 			list_del_init(&dentry->d_lru);
 		}
 		/*
@@ -624,7 +626,7 @@ resume:
 		 */
 		if (!atomic_read(&dentry->d_count)) {
 			list_add(&dentry->d_lru, dentry_unused.prev);
-			dentry_stat.nr_unused++;
+			dentry_stat_inc(dentry->d_sb, nr_unused);
 			found++;
 		}
 
@@ -691,7 +693,7 @@ static int shrink_dcache_memory(int nr, 
 			return -1;
 		prune_dcache(nr);
 	}
-	return (dentry_stat.nr_unused / 100) * sysctl_vfs_cache_pressure;
+	return (global_dentry_stat.nr_unused / 100) * sysctl_vfs_cache_pressure;
 }
 
 /**
@@ -756,7 +758,7 @@ struct dentry *d_alloc(struct dentry * p
 	spin_lock(&dcache_lock);
 	if (parent)
 		list_add(&dentry->d_u.d_child, &parent->d_subdirs);
-	dentry_stat.nr_dentry++;
+	dentry_stat_inc(dentry->d_sb, nr_dentry);
 	spin_unlock(&dcache_lock);
 
 	return dentry;
@@ -932,6 +934,9 @@ struct dentry * d_alloc_anon(struct inod
 		tmp = NULL;
 		spin_lock(&res->d_lock);
 		res->d_sb = inode->i_sb;
+		/* Add to the sb dentry_stat here only,
+		 * the global data is updated in d_alloc */
+		res->d_sb->s_dentry_stat.nr_dentry++;
 		res->d_parent = res;
 		res->d_inode = inode;
 		res->d_flags |= DCACHE_DISCONNECTED;
@@ -1613,23 +1618,23 @@ resume:
 			goto repeat;
 		}
 		if (!list_empty(&dentry->d_lru)) {
-			dentry_stat.nr_unused--;
+			dentry_stat_dec(dentry->d_sb, nr_unused);
 			list_del_init(&dentry->d_lru);
 		}
 		if (atomic_dec_and_test(&dentry->d_count)) {
 			list_add(&dentry->d_lru, dentry_unused.prev);
-			dentry_stat.nr_unused++;
+			dentry_stat_inc(dentry->d_sb, nr_unused);
 		}
 	}
 	if (this_parent != root) {
 		next = this_parent->d_u.d_child.next;
 		if (!list_empty(&this_parent->d_lru)) {
-			dentry_stat.nr_unused--;
+			dentry_stat_dec(this_parent->d_sb, nr_unused);
 			list_del_init(&this_parent->d_lru);
 		}
 		if (atomic_dec_and_test(&this_parent->d_count)) {
 			list_add(&this_parent->d_lru, dentry_unused.prev);
-			dentry_stat.nr_unused++;
+			dentry_stat_inc(this_parent->d_sb, nr_unused);
 		}
 		this_parent = this_parent->d_parent;
 		goto resume;
Index: work-2.6/fs/super.c
===================================================================
--- work-2.6.orig/fs/super.c
+++ work-2.6/fs/super.c
@@ -71,6 +71,7 @@ static struct super_block *alloc_super(v
 		INIT_LIST_HEAD(&s->s_instances);
 		INIT_HLIST_HEAD(&s->s_anon);
 		INIT_LIST_HEAD(&s->s_inodes);
+		s->s_dentry_stat.age_limit = 45;
 		init_rwsem(&s->s_umount);
 		mutex_init(&s->s_lock);
 		down_write(&s->s_umount);
Index: work-2.6/include/linux/dcache.h
===================================================================
--- work-2.6.orig/include/linux/dcache.h
+++ work-2.6/include/linux/dcache.h
@@ -36,14 +36,27 @@ struct qstr {
 	const unsigned char *name;
 };
 
-struct dentry_stat_t {
+struct dentry_stat {
 	int nr_dentry;
 	int nr_unused;
-	int age_limit;          /* age in seconds */
-	int want_pages;         /* pages requested by system */
+	int age_limit;		/* age in seconds */
 	int dummy[2];
 };
-extern struct dentry_stat_t dentry_stat;
+extern struct dentry_stat global_dentry_stat;
+
+#define dentry_stat_inc(sb, x)		\
+do {					\
+	global_dentry_stat.x++;		\
+	if (likely(sb))			\
+		(sb)->s_dentry_stat.x++;\
+} while(0)
+
+#define dentry_stat_dec(sb, x)		\
+do {					\
+	global_dentry_stat.x--;		\
+	if (likely(sb))			\
+		(sb)->s_dentry_stat.x--;\
+} while(0)
 
 /* Name hashing routines. Initial hash value */
 /* Hash courtesy of the R5 hash in reiserfs modulo sign bits */
Index: work-2.6/include/linux/fs.h
===================================================================
--- work-2.6.orig/include/linux/fs.h
+++ work-2.6/include/linux/fs.h
@@ -847,6 +847,7 @@ struct super_block {
 	struct list_head	s_io;		/* parked for writeback */
 	struct hlist_head	s_anon;		/* anonymous dentries for (nfs) exporting */
 	struct list_head	s_files;
+	struct dentry_stat	s_dentry_stat;
 
 	struct block_device	*s_bdev;
 	struct list_head	s_instances;
Index: work-2.6/kernel/sysctl.c
===================================================================
--- work-2.6.orig/kernel/sysctl.c
+++ work-2.6/kernel/sysctl.c
@@ -958,7 +958,7 @@ static ctl_table fs_table[] = {
 	{
 		.ctl_name	= FS_DENTRY,
 		.procname	= "dentry-state",
-		.data		= &dentry_stat,
+		.data		= &global_dentry_stat,
 		.maxlen		= 6*sizeof(int),
 		.mode		= 0444,
 		.proc_handler	= &proc_dointvec,

