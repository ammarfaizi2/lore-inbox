Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263188AbSK0PrK>; Wed, 27 Nov 2002 10:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263270AbSK0PrK>; Wed, 27 Nov 2002 10:47:10 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:53258 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S263188AbSK0Pqg>; Wed, 27 Nov 2002 10:46:36 -0500
Date: Wed, 27 Nov 2002 16:53:53 +0100
From: Jan Kara <jack@suse.cz>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Quota SMP locks
Message-ID: <20021127155352.GA16082@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi Linus,

  I'm resending you the patch with new quota SMP locking. The patch
removes BKL and replaces it with two spinlocks protecting quota lists
and data stored in dquot structures. Also non-SMP locking was changed a
bit make SMP locking easier (eg. we got rid of not very nice dq_dup_ref
counters). The patch is against 2.5.48 but applies well also to 2.5.49.
Would you please apply the patch?

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs


diff -ruNX /home/jack/.kerndiffexclude linux-2.5.48/fs/dquot.c linux-2.5.48-1-smplocks/fs/dquot.c
--- linux-2.5.48/fs/dquot.c	Tue Nov 26 22:31:51 2002
+++ linux-2.5.48-1-smplocks/fs/dquot.c	Tue Nov 26 22:38:50 2002
@@ -49,6 +49,9 @@
  *		formats registering.
  *		Jan Kara, <jack@suse.cz>, 2001,2002
  *
+ *		New SMP locking.
+ *		Jan Kara, <jack@suse.cz>, 10/2002
+ *
  * (C) Copyright 1994 - 1997 Marco van Wieringen 
  */
 
@@ -73,15 +76,32 @@
 
 #include <asm/uaccess.h>
 
+#define __DQUOT_PARANOIA
+
+/*
+ * There are two quota SMP locks. dq_list_lock protects all lists with quotas
+ * and quota formats and also dqstats structure containing statistics about the
+ * lists. dq_data_lock protects data from dq_dqb and also mem_dqinfo structures
+ * and also guards consistency of dquot->dq_dqb with inode->i_blocks, i_bytes.
+ * Note that we don't have to do the locking of i_blocks and i_bytes when the
+ * quota is disabled - i_sem should serialize the access. dq_data_lock should
+ * be always grabbed before dq_list_lock.
+ *
+ * Note that some things (eg. sb pointer, type, id) doesn't change during
+ * the life of the dquot structure and so needn't to be protected by a lock
+ */
+spinlock_t dq_list_lock = SPIN_LOCK_UNLOCKED;
+spinlock_t dq_data_lock = SPIN_LOCK_UNLOCKED;
+
 static char *quotatypes[] = INITQFNAMES;
 static struct quota_format_type *quota_formats;	/* List of registered formats */
 
 int register_quota_format(struct quota_format_type *fmt)
 {
-	lock_kernel();
+	spin_lock(&dq_list_lock);
 	fmt->qf_next = quota_formats;
 	quota_formats = fmt;
-	unlock_kernel();
+	spin_unlock(&dq_list_lock);
 	return 0;
 }
 
@@ -89,22 +109,22 @@
 {
 	struct quota_format_type **actqf;
 
-	lock_kernel();
+	spin_lock(&dq_list_lock);
 	for (actqf = &quota_formats; *actqf && *actqf != fmt; actqf = &(*actqf)->qf_next);
 	if (*actqf)
 		*actqf = (*actqf)->qf_next;
-	unlock_kernel();
+	spin_unlock(&dq_list_lock);
 }
 
 static struct quota_format_type *find_quota_format(int id)
 {
 	struct quota_format_type *actqf;
 
-	lock_kernel();
+	spin_lock(&dq_list_lock);
 	for (actqf = quota_formats; actqf && actqf->qf_fmt_id != id; actqf = actqf->qf_next);
 	if (actqf && !try_inc_mod_count(actqf->qf_owner))
 		actqf = NULL;
-	unlock_kernel();
+	spin_unlock(&dq_list_lock);
 	return actqf;
 }
 
@@ -136,18 +156,20 @@
  */
 
 /*
- * Note that any operation which operates on dquot data (ie. dq_dqb) mustn't
- * block while it's updating/reading it. Otherwise races would occur.
+ * Note that any operation which operates on dquot data (ie. dq_dqb) must
+ * hold dq_data_lock.
  *
- * Locked dquots might not be referenced in inodes - operations like
- * add_dquot_space() does dqduplicate() and would complain. Currently
- * dquot it locked only once in its existence - when it's being read
- * to memory on first dqget() and at that time it can't be referenced
- * from inode. Write operations on dquots don't hold dquot lock as they
- * copy data to internal buffers before writing anyway and copying as well
- * as any data update should be atomic. Also nobody can change used
- * entries in dquot structure as this is done only when quota is destroyed
- * and invalidate_dquots() waits for dquot to have dq_count == 0.
+ * Any operation working with dquots must hold dqoff_sem. If operation is
+ * just reading pointers from inodes than read lock is enough. If pointers
+ * are altered function must hold write lock.
+ *
+ * Locked dquots might not be referenced in inodes. Currently dquot it locked
+ * only once in its existence - when it's being read to memory on first dqget()
+ * and at that time it can't be referenced from inode. Write operations on
+ * dquots don't hold dquot lock as they copy data to internal buffers before
+ * writing anyway and copying as well as any data update should be atomic. Also
+ * nobody can change used entries in dquot structure as this is done only when
+ * quota is destroyed and invalidate_dquots() is called only when dq_count == 0.
  */
 
 static LIST_HEAD(inuse_list);
@@ -156,34 +178,14 @@
 
 struct dqstats dqstats;
 
-static void dqput(struct dquot *);
-static struct dquot *dqduplicate(struct dquot *);
-
-static inline void get_dquot_ref(struct dquot *dquot)
-{
-	dquot->dq_count++;
-}
-
-static inline void put_dquot_ref(struct dquot *dquot)
-{
-	dquot->dq_count--;
-}
-
-static inline void get_dquot_dup_ref(struct dquot *dquot)
-{
-	dquot->dq_dup_ref++;
-}
-
-static inline void put_dquot_dup_ref(struct dquot *dquot)
-{
-	dquot->dq_dup_ref--;
-}
-
 static inline int const hashfn(struct super_block *sb, unsigned int id, int type)
 {
 	return((((unsigned long)sb>>L1_CACHE_SHIFT) ^ id) * (MAXQUOTAS - type)) % NR_DQHASH;
 }
 
+/*
+ * Following list functions expect dq_list_lock to be held
+ */
 static inline void insert_dquot_hash(struct dquot *dquot)
 {
 	struct list_head *head = dquot_hash + hashfn(dquot->dq_sb, dquot->dq_id, dquot->dq_type);
@@ -208,13 +210,6 @@
 	return NODQUOT;
 }
 
-/* Add a dquot to the head of the free list */
-static inline void put_dquot_head(struct dquot *dquot)
-{
-	list_add(&dquot->dq_free, &free_dquots);
-	dqstats.free_dquots++;
-}
-
 /* Add a dquot to the tail of the free list */
 static inline void put_dquot_last(struct dquot *dquot)
 {
@@ -222,13 +217,6 @@
 	dqstats.free_dquots++;
 }
 
-/* Move dquot to the head of free list (it must be already on it) */
-static inline void move_dquot_head(struct dquot *dquot)
-{
-	list_del(&dquot->dq_free);
-	list_add(&dquot->dq_free, &free_dquots);
-}
-
 static inline void remove_free_dquot(struct dquot *dquot)
 {
 	if (list_empty(&dquot->dq_free))
@@ -251,69 +239,10 @@
 	list_del(&dquot->dq_inuse);
 }
 
-static void __wait_on_dquot(struct dquot *dquot)
-{
-	DECLARE_WAITQUEUE(wait, current);
-
-	add_wait_queue(&dquot->dq_wait_lock, &wait);
-repeat:
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	if (dquot->dq_flags & DQ_LOCKED) {
-		schedule();
-		goto repeat;
-	}
-	remove_wait_queue(&dquot->dq_wait_lock, &wait);
-	current->state = TASK_RUNNING;
-}
-
-static inline void wait_on_dquot(struct dquot *dquot)
-{
-	if (dquot->dq_flags & DQ_LOCKED)
-		__wait_on_dquot(dquot);
-}
-
-static inline void lock_dquot(struct dquot *dquot)
-{
-	wait_on_dquot(dquot);
-	dquot->dq_flags |= DQ_LOCKED;
-}
-
-static inline void unlock_dquot(struct dquot *dquot)
-{
-	dquot->dq_flags &= ~DQ_LOCKED;
-	wake_up(&dquot->dq_wait_lock);
-}
-
-/* Wait for dquot to be unused */
-static void __wait_dquot_unused(struct dquot *dquot)
-{
-	DECLARE_WAITQUEUE(wait, current);
-
-	add_wait_queue(&dquot->dq_wait_free, &wait);
-repeat:
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	if (dquot->dq_count) {
-		schedule();
-		goto repeat;
-	}
-	remove_wait_queue(&dquot->dq_wait_free, &wait);
-	current->state = TASK_RUNNING;
-}
-
-/* Wait for all duplicated dquot references to be dropped */
-static void __wait_dup_drop(struct dquot *dquot)
+static void wait_on_dquot(struct dquot *dquot)
 {
-	DECLARE_WAITQUEUE(wait, current);
-
-	add_wait_queue(&dquot->dq_wait_free, &wait);
-repeat:
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	if (dquot->dq_dup_ref) {
-		schedule();
-		goto repeat;
-	}
-	remove_wait_queue(&dquot->dq_wait_free, &wait);
-	current->state = TASK_RUNNING;
+	down(&dquot->dq_lock);
+	up(&dquot->dq_lock);
 }
 
 static int read_dqblk(struct dquot *dquot)
@@ -321,11 +250,11 @@
 	int ret;
 	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
 
-	lock_dquot(dquot);
+	down(&dquot->dq_lock);
 	down(&dqopt->dqio_sem);
 	ret = dqopt->ops[dquot->dq_type]->read_dqblk(dquot);
 	up(&dqopt->dqio_sem);
-	unlock_dquot(dquot);
+	up(&dquot->dq_lock);
 	return ret;
 }
 
@@ -340,36 +269,35 @@
 	return ret;
 }
 
-/* Invalidate all dquots on the list, wait for all users. Note that this function is called
- * after quota is disabled so no new quota might be created. As we only insert to the end of
- * inuse list, we don't have to restart searching... */
+/* Invalidate all dquots on the list. Note that this function is called after
+ * quota is disabled so no new quota might be created. Because we hold dqoff_sem
+ * for writing and pointers were already removed from inodes we actually know that
+ * no quota for this sb+type should be held. */
 static void invalidate_dquots(struct super_block *sb, int type)
 {
 	struct dquot *dquot;
 	struct list_head *head;
 
-restart:
-	list_for_each(head, &inuse_list) {
+	spin_lock(&dq_list_lock);
+	for (head = inuse_list.next; head != &inuse_list;) {
 		dquot = list_entry(head, struct dquot, dq_inuse);
+		head = head->next;
 		if (dquot->dq_sb != sb)
 			continue;
 		if (dquot->dq_type != type)
 			continue;
-		dquot->dq_flags |= DQ_INVAL;
-		if (dquot->dq_count)
-			/*
-			 *  Wait for any users of quota. As we have already cleared the flags in
-			 *  superblock and cleared all pointers from inodes we are assured
-			 *  that there will be no new users of this quota.
-			 */
-			__wait_dquot_unused(dquot);
+#ifdef __DQUOT_PARANOIA	
+		/* There should be no users of quota - we hold dqoff_sem for writing */
+		if (atomic_read(&dquot->dq_count))
+			BUG();
+#endif
 		/* Quota now have no users and it has been written on last dqput() */
 		remove_dquot_hash(dquot);
 		remove_free_dquot(dquot);
 		remove_inuse(dquot);
 		kmem_cache_free(dquot_cachep, dquot);
-		goto restart;
 	}
+	spin_unlock(&dq_list_lock);
 }
 
 static int vfs_quota_sync(struct super_block *sb, int type)
@@ -379,7 +307,14 @@
 	struct quota_info *dqopt = sb_dqopt(sb);
 	int cnt;
 
+	down_read(&dqopt->dqoff_sem);
 restart:
+	/* At this point any dirty dquot will definitely be written so we can clear
+	   dirty flag from info */
+	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
+		if ((cnt == type || type == -1) && sb_has_quota_enabled(sb, cnt))
+			clear_bit(DQF_ANY_DQUOT_DIRTY_B, &dqopt->info[cnt].dqi_flags);
+	spin_lock(&dq_list_lock);
 	list_for_each(head, &inuse_list) {
 		dquot = list_entry(head, struct dquot, dq_inuse);
 		if (sb && dquot->dq_sb != sb)
@@ -388,26 +323,24 @@
 			continue;
 		if (!dquot->dq_sb)	/* Invalidated? */
 			continue;
-		if (!dquot_dirty(dquot) && !(dquot->dq_flags & DQ_LOCKED))
+		if (!dquot_dirty(dquot))
 			continue;
-		/* Get reference to quota so it won't be invalidated. get_dquot_ref()
-		 * is enough since if dquot is locked/modified it can't be
-		 * on the free list */
-		get_dquot_ref(dquot);
-		if (dquot->dq_flags & DQ_LOCKED)
-			wait_on_dquot(dquot);
-		if (dquot_dirty(dquot))
-			commit_dqblk(dquot);
-		dqput(dquot);
+		spin_unlock(&dq_list_lock);
+		commit_dqblk(dquot);
 		goto restart;
 	}
+	spin_unlock(&dq_list_lock);
+
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
-		if ((cnt == type || type == -1) && sb_has_quota_enabled(sb, cnt))
-			dqopt->info[cnt].dqi_flags &= ~DQF_ANY_DQUOT_DIRTY;
-	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
-		if ((cnt == type || type == -1) && sb_has_quota_enabled(sb, cnt) && info_dirty(&dqopt->info[cnt]))
+		if ((cnt == type || type == -1) && sb_has_quota_enabled(sb, cnt) && info_dirty(&dqopt->info[cnt])) {
+			down(&dqopt->dqio_sem);
 			dqopt->ops[cnt]->write_file_info(sb, cnt);
+			up(&dqopt->dqio_sem);
+		}
+	spin_lock(&dq_list_lock);
 	dqstats.syncs++;
+	spin_unlock(&dq_list_lock);
+	up_read(&dqopt->dqoff_sem);
 
 	return 0;
 }
@@ -424,7 +357,7 @@
 
 		for (cnt = 0, dirty = 0; cnt < MAXQUOTAS; cnt++)
 			if ((type == cnt || type == -1) && sb_has_quota_enabled(sb, cnt)
-			    && sb_dqopt(sb)->info[cnt].dqi_flags & DQF_ANY_DQUOT_DIRTY)
+			    && info_any_dquot_dirty(&sb_dqopt(sb)->info[cnt]))
 				dirty = 1;
 		if (!dirty)
 			continue;
@@ -444,17 +377,13 @@
 void sync_dquots(struct super_block *sb, int type)
 {
 	if (sb) {
-		lock_kernel();
 		if (sb->s_qcop->quota_sync)
 			sb->s_qcop->quota_sync(sb, type);
-		unlock_kernel();
 	}
 	else {
 		while ((sb = get_super_to_sync(type))) {
-			lock_kernel();
 			if (sb->s_qcop->quota_sync)
 				sb->s_qcop->quota_sync(sb, type);
-			unlock_kernel();
 			drop_super(sb);
 		}
 	}
@@ -485,60 +414,60 @@
 
 static int shrink_dqcache_memory(int nr, unsigned int gfp_mask)
 {
-	if (nr) {
-		lock_kernel();
+	int ret;
+
+	spin_lock(&dq_list_lock);
+	if (nr)
 		prune_dqcache(nr);
-		unlock_kernel();
-	}
-	return dqstats.allocated_dquots;
+	ret = dqstats.allocated_dquots;
+	spin_unlock(&dq_list_lock);
+	return ret;
 }
 
 /*
  * Put reference to dquot
  * NOTE: If you change this function please check whether dqput_blocks() works right...
+ * MUST be called with dqoff_sem held
  */
 static void dqput(struct dquot *dquot)
 {
 	if (!dquot)
 		return;
 #ifdef __DQUOT_PARANOIA
-	if (!dquot->dq_count) {
+	if (!atomic_read(&dquot->dq_count)) {
 		printk("VFS: dqput: trying to free free dquot\n");
 		printk("VFS: device %s, dquot of %s %d\n",
 			dquot->dq_sb->s_id,
 			quotatypes[dquot->dq_type],
 			dquot->dq_id);
-		return;
+		BUG();
 	}
 #endif
-
+	
+	spin_lock(&dq_list_lock);
 	dqstats.drops++;
+	spin_unlock(&dq_list_lock);
 we_slept:
-	if (dquot->dq_dup_ref && dquot->dq_count - dquot->dq_dup_ref <= 1) {	/* Last unduplicated reference? */
-		__wait_dup_drop(dquot);
-		goto we_slept;
-	}
-	if (dquot->dq_count > 1) {
-		/* We have more than one user... We can simply decrement use count */
-		put_dquot_ref(dquot);
+	spin_lock(&dq_list_lock);
+	if (atomic_read(&dquot->dq_count) > 1) {
+		/* We have more than one user... nothing to do */
+		atomic_dec(&dquot->dq_count);
+		spin_unlock(&dq_list_lock);
 		return;
 	}
 	if (dquot_dirty(dquot)) {
+		spin_unlock(&dq_list_lock);
 		commit_dqblk(dquot);
 		goto we_slept;
 	}
-
+	atomic_dec(&dquot->dq_count);
+#ifdef __DQUOT_PARANOIA
 	/* sanity check */
-	if (!list_empty(&dquot->dq_free)) {
-		printk(KERN_ERR "dqput: dquot already on free list??\n");
-		put_dquot_ref(dquot);
-		return;
-	}
-	put_dquot_ref(dquot);
-	/* If dquot is going to be invalidated invalidate_dquots() is going to free it so */
-	if (!(dquot->dq_flags & DQ_INVAL))
-		put_dquot_last(dquot);	/* Place at end of LRU free queue */
-	wake_up(&dquot->dq_wait_free);
+	if (!list_empty(&dquot->dq_free))
+		BUG();
+#endif
+	put_dquot_last(dquot);
+	spin_unlock(&dq_list_lock);
 }
 
 static struct dquot *get_empty_dquot(struct super_block *sb, int type)
@@ -550,99 +479,66 @@
 		return NODQUOT;
 
 	memset((caddr_t)dquot, 0, sizeof(struct dquot));
-	init_waitqueue_head(&dquot->dq_wait_free);
-	init_waitqueue_head(&dquot->dq_wait_lock);
+	sema_init(&dquot->dq_lock, 1);
 	INIT_LIST_HEAD(&dquot->dq_free);
 	INIT_LIST_HEAD(&dquot->dq_inuse);
 	INIT_LIST_HEAD(&dquot->dq_hash);
 	dquot->dq_sb = sb;
 	dquot->dq_type = type;
-	dquot->dq_count = 1;
-	/* all dquots go on the inuse_list */
-	put_inuse(dquot);
+	atomic_set(&dquot->dq_count, 1);
 
 	return dquot;
 }
 
+/*
+ * Get reference to dquot
+ * MUST be called with dqoff_sem held
+ */
 static struct dquot *dqget(struct super_block *sb, unsigned int id, int type)
 {
 	unsigned int hashent = hashfn(sb, id, type);
 	struct dquot *dquot, *empty = NODQUOT;
-	struct quota_info *dqopt = sb_dqopt(sb);
 
+        if (!sb_has_quota_enabled(sb, type))
+		return NODQUOT;
 we_slept:
-        if (!is_enabled(dqopt, type)) {
-		if (empty)
-			dqput(empty);
-                return NODQUOT;
-	}
-
+	spin_lock(&dq_list_lock);
 	if ((dquot = find_dquot(hashent, sb, id, type)) == NODQUOT) {
 		if (empty == NODQUOT) {
+			spin_unlock(&dq_list_lock);
 			if ((empty = get_empty_dquot(sb, type)) == NODQUOT)
 				schedule();	/* Try to wait for a moment... */
 			goto we_slept;
 		}
 		dquot = empty;
 		dquot->dq_id = id;
+		/* all dquots go on the inuse_list */
+		put_inuse(dquot);
 		/* hash it first so it can be found */
 		insert_dquot_hash(dquot);
+		dqstats.lookups++;
+		spin_unlock(&dq_list_lock);
 		read_dqblk(dquot);
 	} else {
-		if (!dquot->dq_count)
+		if (!atomic_read(&dquot->dq_count))
 			remove_free_dquot(dquot);
-		get_dquot_ref(dquot);
+		atomic_inc(&dquot->dq_count);
 		dqstats.cache_hits++;
+		dqstats.lookups++;
+		spin_unlock(&dq_list_lock);
 		wait_on_dquot(dquot);
 		if (empty)
-			dqput(empty);
-	}
-
-	if (!dquot->dq_sb) {	/* Has somebody invalidated entry under us? */
-		printk(KERN_ERR "VFS: dqget(): Quota invalidated in dqget()!\n");
-		dqput(dquot);
-		return NODQUOT;
+			kmem_cache_free(dquot_cachep, empty);
 	}
-	++dquot->dq_referenced;
-	dqstats.lookups++;
 
-	return dquot;
-}
-
-/* Duplicate reference to dquot got from inode */
-static struct dquot *dqduplicate(struct dquot *dquot)
-{
-	if (dquot == NODQUOT)
-		return NODQUOT;
-	get_dquot_ref(dquot);
-	if (!dquot->dq_sb) {
-		printk(KERN_ERR "VFS: dqduplicate(): Invalidated quota to be duplicated!\n");
-		put_dquot_ref(dquot);
-		return NODQUOT;
-	}
-	if (dquot->dq_flags & DQ_LOCKED)
-		printk(KERN_ERR "VFS: dqduplicate(): Locked quota to be duplicated!\n");
-	get_dquot_dup_ref(dquot);
-	dquot->dq_referenced++;
-	dqstats.lookups++;
+#ifdef __DQUOT_PARANOIA
+	if (!dquot->dq_sb)	/* Has somebody invalidated entry under us? */
+		BUG();
+#endif
 
 	return dquot;
 }
 
-/* Put duplicated reference */
-static void dqputduplicate(struct dquot *dquot)
-{
-	if (!dquot->dq_dup_ref) {
-		printk(KERN_ERR "VFS: dqputduplicate(): Duplicated dquot put without duplicate reference.\n");
-		return;
-	}
-	put_dquot_dup_ref(dquot);
-	if (!dquot->dq_dup_ref)
-		wake_up(&dquot->dq_wait_free);
-	put_dquot_ref(dquot);
-	dqstats.drops++;
-}
-
 static int dqinit_needed(struct inode *inode, int type)
 {
 	int cnt;
@@ -657,6 +553,7 @@
 	return 0;
 }
 
+/* This routine is guarded by dqoff_sem semaphore */
 static void add_dquot_ref(struct super_block *sb, int type)
 {
 	struct list_head *p;
@@ -683,14 +580,13 @@
 /* Return 0 if dqput() won't block (note that 1 doesn't necessarily mean blocking) */
 static inline int dqput_blocks(struct dquot *dquot)
 {
-	if (dquot->dq_dup_ref && dquot->dq_count - dquot->dq_dup_ref <= 1)
-		return 1;
-	if (dquot->dq_count <= 1 && dquot->dq_flags & DQ_MOD)
+	if (atomic_read(&dquot->dq_count) <= 1 && dquot_dirty(dquot))
 		return 1;
 	return 0;
 }
 
 /* Remove references to dquots from inode - add dquot to list for freeing if needed */
+/* We can't race with anybody because we hold dqoff_sem for writing... */
 int remove_inode_dquot_ref(struct inode *inode, int type, struct list_head *tofree_head)
 {
 	struct dquot *dquot = inode->i_dquot[type];
@@ -706,9 +602,13 @@
 put_it:
 	if (dquot != NODQUOT) {
 		if (dqput_blocks(dquot)) {
-			if (dquot->dq_count != 1)
-				printk(KERN_WARNING "VFS: Adding dquot with dq_count %d to dispose list.\n", dquot->dq_count);
+#ifdef __DQUOT_PARANOIA
+			if (atomic_read(&dquot->dq_count) != 1)
+				printk(KERN_WARNING "VFS: Adding dquot with dq_count %d to dispose list.\n", atomic_read(&dquot->dq_count));
+#endif
+			spin_lock(&dq_list_lock);
 			list_add(&dquot->dq_free, tofree_head);	/* As dquot must have currently users it can't be on the free list... */
+			spin_unlock(&dq_list_lock);
 			return 1;
 		}
 		else
@@ -718,12 +618,12 @@
 }
 
 /* Free list of dquots - called from inode.c */
+/* dquots are removed from inodes, no new references can be got so we are the only ones holding reference */
 void put_dquot_list(struct list_head *tofree_head)
 {
 	struct list_head *act_head;
 	struct dquot *dquot;
 
-	lock_kernel();
 	act_head = tofree_head->next;
 	/* So now we have dquots on the list... Just free them */
 	while (act_head != tofree_head) {
@@ -732,7 +632,6 @@
 		list_del_init(&dquot->dq_free);	/* Remove dquot from the list so we won't have problems... */
 		dqput(dquot);
 	}
-	unlock_kernel();
 }
 
 static inline void dquot_incr_inodes(struct dquot *dquot, unsigned long number)
@@ -755,7 +654,7 @@
 		dquot->dq_dqb.dqb_curinodes = 0;
 	if (dquot->dq_dqb.dqb_curinodes < dquot->dq_dqb.dqb_isoftlimit)
 		dquot->dq_dqb.dqb_itime = (time_t) 0;
-	dquot->dq_flags &= ~DQ_INODES;
+	clear_bit(DQ_INODES_B, &dquot->dq_flags);
 	mark_dquot_dirty(dquot);
 }
 
@@ -767,17 +666,17 @@
 		dquot->dq_dqb.dqb_curspace = 0;
 	if (toqb(dquot->dq_dqb.dqb_curspace) < dquot->dq_dqb.dqb_bsoftlimit)
 		dquot->dq_dqb.dqb_btime = (time_t) 0;
-	dquot->dq_flags &= ~DQ_BLKS;
+	clear_bit(DQ_BLKS_B, &dquot->dq_flags);
 	mark_dquot_dirty(dquot);
 }
 
-static inline int need_print_warning(struct dquot *dquot, int flag)
+static inline int need_print_warning(struct dquot *dquot)
 {
 	switch (dquot->dq_type) {
 		case USRQUOTA:
-			return current->fsuid == dquot->dq_id && !(dquot->dq_flags & flag);
+			return current->fsuid == dquot->dq_id;
 		case GRPQUOTA:
-			return in_group_p(dquot->dq_id) && !(dquot->dq_flags & flag);
+			return in_group_p(dquot->dq_id);
 	}
 	return 0;
 }
@@ -795,12 +694,11 @@
 static void print_warning(struct dquot *dquot, const char warntype)
 {
 	char *msg = NULL;
-	int flag = (warntype == BHARDWARN || warntype == BSOFTLONGWARN) ? DQ_BLKS :
-	  ((warntype == IHARDWARN || warntype == ISOFTLONGWARN) ? DQ_INODES : 0);
+	int flag = (warntype == BHARDWARN || warntype == BSOFTLONGWARN) ? DQ_BLKS_B :
+	  ((warntype == IHARDWARN || warntype == ISOFTLONGWARN) ? DQ_INODES_B : 0);
 
-	if (!need_print_warning(dquot, flag))
+	if (!need_print_warning(dquot) || (flag && test_and_set_bit(flag, &dquot->dq_flags)))
 		return;
-	dquot->dq_flags |= flag;
 	tty_write_message(current->tty, dquot->dq_sb->s_id);
 	if (warntype == ISOFTWARN || warntype == BSOFTWARN)
 		tty_write_message(current->tty, ": warning, ");
@@ -847,10 +745,11 @@
 	    (info->dqi_format->qf_fmt_id != QFMT_VFS_OLD || !(info->dqi_flags & V1_DQF_RSQUASH));
 }
 
+/* needs dq_data_lock */
 static int check_idq(struct dquot *dquot, ulong inodes, char *warntype)
 {
 	*warntype = NOWARN;
-	if (inodes <= 0 || dquot->dq_flags & DQ_FAKE)
+	if (inodes <= 0 || test_bit(DQ_FAKE_B, &dquot->dq_flags))
 		return QUOTA_OK;
 
 	if (dquot->dq_dqb.dqb_ihardlimit &&
@@ -878,10 +777,11 @@
 	return QUOTA_OK;
 }
 
+/* needs dq_data_lock */
 static int check_bdq(struct dquot *dquot, qsize_t space, int prealloc, char *warntype)
 {
 	*warntype = 0;
-	if (space <= 0 || dquot->dq_flags & DQ_FAKE)
+	if (space <= 0 || test_bit(DQ_FAKE_B, &dquot->dq_flags))
 		return QUOTA_OK;
 
 	if (dquot->dq_dqb.dqb_bhardlimit &&
@@ -926,19 +826,19 @@
  */
 void dquot_initialize(struct inode *inode, int type)
 {
-	struct dquot *dquot[MAXQUOTAS];
 	unsigned int id = 0;
 	int cnt;
 
-	if (IS_NOQUOTA(inode))
+	down_write(&sb_dqopt(inode->i_sb)->dqoff_sem);
+	/* Having dqoff lock we know NOQUOTA flags can't be altered... */
+	if (IS_NOQUOTA(inode)) {
+		up_write(&sb_dqopt(inode->i_sb)->dqoff_sem);
 		return;
-	/* Build list of quotas to initialize... We can block here */
+	}
+	/* Build list of quotas to initialize... */
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		dquot[cnt] = NODQUOT;
 		if (type != -1 && cnt != type)
 			continue;
-		if (!sb_has_quota_enabled(inode->i_sb, cnt))
-			continue;
 		if (inode->i_dquot[cnt] == NODQUOT) {
 			switch (cnt) {
 				case USRQUOTA:
@@ -948,22 +848,12 @@
 					id = inode->i_gid;
 					break;
 			}
-			dquot[cnt] = dqget(inode->i_sb, id, cnt);
+			inode->i_dquot[cnt] = dqget(inode->i_sb, id, cnt);
+			if (inode->i_dquot[cnt])
+				inode->i_flags |= S_QUOTA;
 		}
 	}
-	/* NOBLOCK START: Here we shouldn't block */
-	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		if (dquot[cnt] == NODQUOT || !sb_has_quota_enabled(inode->i_sb, cnt) || inode->i_dquot[cnt] != NODQUOT)
-			continue;
-		inode->i_dquot[cnt] = dquot[cnt];
-		dquot[cnt] = NODQUOT;
-		inode->i_flags |= S_QUOTA;
-	}
-	/* NOBLOCK END */
-	/* Put quotas which we didn't use */
-	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
-		if (dquot[cnt] != NODQUOT)
-			dqput(dquot[cnt]);
+	up_write(&sb_dqopt(inode->i_sb)->dqoff_sem);
 }
 
 /*
@@ -971,57 +861,56 @@
  *
  * Note: this is a blocking operation.
  */
-void dquot_drop(struct inode *inode)
+static void dquot_drop_nolock(struct inode *inode)
 {
-	struct dquot *dquot;
 	int cnt;
 
 	inode->i_flags &= ~S_QUOTA;
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		if (inode->i_dquot[cnt] == NODQUOT)
 			continue;
-		dquot = inode->i_dquot[cnt];
+		dqput(inode->i_dquot[cnt]);
 		inode->i_dquot[cnt] = NODQUOT;
-		dqput(dquot);
 	}
 }
 
+void dquot_drop(struct inode *inode)
+{
+	down_write(&sb_dqopt(inode->i_sb)->dqoff_sem);
+	dquot_drop_nolock(inode);
+	up_write(&sb_dqopt(inode->i_sb)->dqoff_sem);
+}
+
 /*
  * This operation can block, but only after everything is updated
  */
 int dquot_alloc_space(struct inode *inode, qsize_t number, int warn)
 {
 	int cnt, ret = NO_QUOTA;
-	struct dquot *dquot[MAXQUOTAS];
 	char warntype[MAXQUOTAS];
 
-	lock_kernel();
-	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		dquot[cnt] = NODQUOT;
+	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
 		warntype[cnt] = NOWARN;
-	}
-	/* NOBLOCK Start */
+
+	down_read(&sb_dqopt(inode->i_sb)->dqoff_sem);
+	spin_lock(&dq_data_lock);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		dquot[cnt] = dqduplicate(inode->i_dquot[cnt]);
-		if (dquot[cnt] == NODQUOT)
+		if (inode->i_dquot[cnt] == NODQUOT)
 			continue;
-		if (check_bdq(dquot[cnt], number, warn, warntype+cnt) == NO_QUOTA)
+		if (check_bdq(inode->i_dquot[cnt], number, warn, warntype+cnt) == NO_QUOTA)
 			goto warn_put_all;
 	}
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		if (dquot[cnt] == NODQUOT)
+		if (inode->i_dquot[cnt] == NODQUOT)
 			continue;
-		dquot_incr_space(dquot[cnt], number);
+		dquot_incr_space(inode->i_dquot[cnt], number);
 	}
 	inode_add_bytes(inode, number);
-	/* NOBLOCK End */
 	ret = QUOTA_OK;
 warn_put_all:
-	flush_warnings(dquot, warntype);
-	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
-		if (dquot[cnt] != NODQUOT)
-			dqputduplicate(dquot[cnt]);
-	unlock_kernel();
+	spin_unlock(&dq_data_lock);
+	flush_warnings(inode->i_dquot, warntype);
+	up_read(&sb_dqopt(inode->i_sb)->dqoff_sem);
 	return ret;
 }
 
@@ -1031,36 +920,29 @@
 int dquot_alloc_inode(const struct inode *inode, unsigned long number)
 {
 	int cnt, ret = NO_QUOTA;
-	struct dquot *dquot[MAXQUOTAS];
 	char warntype[MAXQUOTAS];
 
-	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		dquot[cnt] = NODQUOT;
+	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
 		warntype[cnt] = NOWARN;
-	}
-	/* NOBLOCK Start */
-	lock_kernel();
+	down_read(&sb_dqopt(inode->i_sb)->dqoff_sem);
+	spin_lock(&dq_data_lock);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		dquot[cnt] = dqduplicate(inode -> i_dquot[cnt]);
-		if (dquot[cnt] == NODQUOT)
+		if (inode->i_dquot[cnt] == NODQUOT)
 			continue;
-		if (check_idq(dquot[cnt], number, warntype+cnt) == NO_QUOTA)
+		if (check_idq(inode->i_dquot[cnt], number, warntype+cnt) == NO_QUOTA)
 			goto warn_put_all;
 	}
 
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		if (dquot[cnt] == NODQUOT)
+		if (inode->i_dquot[cnt] == NODQUOT)
 			continue;
-		dquot_incr_inodes(dquot[cnt], number);
+		dquot_incr_inodes(inode->i_dquot[cnt], number);
 	}
-	/* NOBLOCK End */
 	ret = QUOTA_OK;
 warn_put_all:
-	flush_warnings(dquot, warntype);
-	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
-		if (dquot[cnt] != NODQUOT)
-			dqputduplicate(dquot[cnt]);
-	unlock_kernel();
+	spin_unlock(&dq_data_lock);
+	flush_warnings((struct dquot **)inode->i_dquot, warntype);
+	up_read(&sb_dqopt(inode->i_sb)->dqoff_sem);
 	return ret;
 }
 
@@ -1070,20 +952,17 @@
 void dquot_free_space(struct inode *inode, qsize_t number)
 {
 	unsigned int cnt;
-	struct dquot *dquot;
 
-	/* NOBLOCK Start */
-	lock_kernel();
+	down_read(&sb_dqopt(inode->i_sb)->dqoff_sem);
+	spin_lock(&dq_data_lock);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		dquot = dqduplicate(inode->i_dquot[cnt]);
-		if (dquot == NODQUOT)
+		if (inode->i_dquot[cnt] == NODQUOT)
 			continue;
-		dquot_decr_space(dquot, number);
-		dqputduplicate(dquot);
+		dquot_decr_space(inode->i_dquot[cnt], number);
 	}
 	inode_sub_bytes(inode, number);
-	unlock_kernel();
-	/* NOBLOCK End */
+	spin_unlock(&dq_data_lock);
+	up_read(&sb_dqopt(inode->i_sb)->dqoff_sem);
 }
 
 /*
@@ -1092,19 +971,16 @@
 void dquot_free_inode(const struct inode *inode, unsigned long number)
 {
 	unsigned int cnt;
-	struct dquot *dquot;
 
-	/* NOBLOCK Start */
-	lock_kernel();
+	down_read(&sb_dqopt(inode->i_sb)->dqoff_sem);
+	spin_lock(&dq_data_lock);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		dquot = dqduplicate(inode->i_dquot[cnt]);
-		if (dquot == NODQUOT)
+		if (inode->i_dquot[cnt] == NODQUOT)
 			continue;
-		dquot_decr_inodes(dquot, number);
-		dqputduplicate(dquot);
+		dquot_decr_inodes(inode->i_dquot[cnt], number);
 	}
-	unlock_kernel();
-	/* NOBLOCK End */
+	spin_unlock(&dq_data_lock);
+	up_read(&sb_dqopt(inode->i_sb)->dqoff_sem);
 }
 
 /*
@@ -1126,10 +1002,11 @@
 		transfer_to[cnt] = transfer_from[cnt] = NODQUOT;
 		warntype[cnt] = NOWARN;
 	}
+	down_write(&sb_dqopt(inode->i_sb)->dqoff_sem);
+	if (IS_NOQUOTA(inode))	/* File without quota accounting? */
+		goto warn_put_all;
 	/* First build the transfer_to list - here we can block on reading of dquots... */
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		if (!sb_has_quota_enabled(inode->i_sb, cnt))
-			continue;
 		switch (cnt) {
 			case USRQUOTA:
 				if (!chuid)
@@ -1143,16 +1020,13 @@
 				break;
 		}
 	}
-	/* NOBLOCK START: From now on we shouldn't block */
+	spin_lock(&dq_data_lock);
 	space = inode_get_bytes(inode);
 	/* Build the transfer_from list and check the limits */
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		/* The second test can fail when quotaoff is in progress... */
-		if (transfer_to[cnt] == NODQUOT || !sb_has_quota_enabled(inode->i_sb, cnt))
-			continue;
-		transfer_from[cnt] = dqduplicate(inode->i_dquot[cnt]);
-		if (transfer_from[cnt] == NODQUOT)	/* Can happen on quotafiles (quota isn't initialized on them)... */
+		if (transfer_to[cnt] == NODQUOT)
 			continue;
+		transfer_from[cnt] = inode->i_dquot[cnt];
 		if (check_idq(transfer_to[cnt], 1, warntype+cnt) == NO_QUOTA ||
 		    check_bdq(transfer_to[cnt], space, 0, warntype+cnt) == NO_QUOTA)
 			goto warn_put_all;
@@ -1163,9 +1037,9 @@
 	 */
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		/*
-		 * Skip changes for same uid or gid or for non-existing quota-type.
+		 * Skip changes for same uid or gid or for turned off quota-type.
 		 */
-		if (transfer_from[cnt] == NODQUOT || transfer_to[cnt] == NODQUOT)
+		if (transfer_to[cnt] == NODQUOT)
 			continue;
 
 		dquot_decr_inodes(transfer_from[cnt], 1);
@@ -1174,26 +1048,17 @@
 		dquot_incr_inodes(transfer_to[cnt], 1);
 		dquot_incr_space(transfer_to[cnt], space);
 
-		if (inode->i_dquot[cnt] == NODQUOT)
-			BUG();
 		inode->i_dquot[cnt] = transfer_to[cnt];
-		/*
-		 * We've got to release transfer_from[] twice - once for dquot_transfer() and
-		 * once for inode. We don't want to release transfer_to[] as it's now placed in inode
-		 */
-		transfer_to[cnt] = transfer_from[cnt];
 	}
-	/* NOBLOCK END. From now on we can block as we wish */
 	ret = QUOTA_OK;
 warn_put_all:
+	spin_unlock(&dq_data_lock);
 	flush_warnings(transfer_to, warntype);
-	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		/* First we must put duplicate - otherwise we might deadlock */
-		if (transfer_to[cnt] != NODQUOT)
-			dqputduplicate(transfer_to[cnt]);
+	
+	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
 		if (transfer_from[cnt] != NODQUOT)
 			dqput(transfer_from[cnt]);
-	}
+	up_write(&sb_dqopt(inode->i_sb)->dqoff_sem);
 	return ret;
 }
 
@@ -1245,24 +1110,30 @@
 	int cnt;
 	struct quota_info *dqopt = sb_dqopt(sb);
 
-	lock_kernel();
 	if (!sb)
 		goto out;
 
 	/* We need to serialize quota_off() for device */
-	down(&dqopt->dqoff_sem);
+	down_write(&dqopt->dqoff_sem);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		if (type != -1 && cnt != type)
 			continue;
-		if (!is_enabled(dqopt, cnt))
+		if (!sb_has_quota_enabled(sb, cnt))
 			continue;
 		reset_enable_flags(dqopt, cnt);
 
 		/* Note: these are blocking operations */
 		remove_dquot_ref(sb, cnt);
 		invalidate_dquots(sb, cnt);
-		if (info_dirty(&dqopt->info[cnt]))
+		/*
+		 * Now all dquots should be invalidated, all writes done so we should be only
+		 * users of the info. No locks needed.
+		 */
+		if (info_dirty(&dqopt->info[cnt])) {
+			down(&dqopt->dqio_sem);
 			dqopt->ops[cnt]->write_file_info(sb, cnt);
+			up(&dqopt->dqio_sem);
+		}
 		if (dqopt->ops[cnt]->free_file_info)
 			dqopt->ops[cnt]->free_file_info(sb, cnt);
 		put_quota_format(dqopt->info[cnt].dqi_format);
@@ -1274,15 +1145,14 @@
 		dqopt->info[cnt].dqi_bgrace = 0;
 		dqopt->ops[cnt] = NULL;
 	}
-	up(&dqopt->dqoff_sem);
+	up_write(&dqopt->dqoff_sem);
 out:
-	unlock_kernel();
 	return 0;
 }
 
 int vfs_quota_on(struct super_block *sb, int type, int format_id, char *path)
 {
-	struct file *f = NULL;
+	struct file *f;
 	struct inode *inode;
 	struct quota_info *dqopt = sb_dqopt(sb);
 	struct quota_format_type *fmt = find_quota_format(format_id);
@@ -1290,19 +1160,11 @@
 
 	if (!fmt)
 		return -ESRCH;
-	if (is_enabled(dqopt, type)) {
-		error = -EBUSY;
+	f = filp_open(path, O_RDWR, 0600);
+	if (IS_ERR(f)) {
+		error = PTR_ERR(f);
 		goto out_fmt;
 	}
-
-	down(&dqopt->dqoff_sem);
-
-	f = filp_open(path, O_RDWR, 0600);
-
-	error = PTR_ERR(f);
-	if (IS_ERR(f))
-		goto out_lock;
-	dqopt->files[type] = f;
 	error = -EIO;
 	if (!f->f_op || !f->f_op->read || !f->f_op->write)
 		goto out_f;
@@ -1313,30 +1175,41 @@
 	error = -EACCES;
 	if (!S_ISREG(inode->i_mode))
 		goto out_f;
+
+	down_write(&dqopt->dqoff_sem);
+	if (sb_has_quota_enabled(sb, type)) {
+		error = -EBUSY;
+		goto out_lock;
+	}
+	dqopt->files[type] = f;
 	error = -EINVAL;
 	if (!fmt->qf_ops->check_quota_file(sb, type))
-		goto out_f;
+		goto out_lock;
 	/* We don't want quota on quota files */
-	dquot_drop(inode);
+	dquot_drop_nolock(inode);
 	inode->i_flags |= S_NOQUOTA;
 
 	dqopt->ops[type] = fmt->qf_ops;
 	dqopt->info[type].dqi_format = fmt;
-	if ((error = dqopt->ops[type]->read_file_info(sb, type)) < 0)
-		goto out_f;
+	down(&dqopt->dqio_sem);
+	if ((error = dqopt->ops[type]->read_file_info(sb, type)) < 0) {
+		up(&dqopt->dqio_sem);
+		goto out_lock;
+	}
+	up(&dqopt->dqio_sem);
 	set_enable_flags(dqopt, type);
 
 	add_dquot_ref(sb, type);
 
-	up(&dqopt->dqoff_sem);
+	up_write(&dqopt->dqoff_sem);
 	return 0;
 
-out_f:
-	if (f)
-		filp_close(f, NULL);
-	dqopt->files[type] = NULL;
 out_lock:
-	up(&dqopt->dqoff_sem);
+	inode->i_flags &= ~S_NOQUOTA;
+	dqopt->files[type] = NULL;
+	up_write(&dqopt->dqoff_sem);
+out_f:
+	filp_close(f, NULL);
 out_fmt:
 	put_quota_format(fmt);
 
@@ -1348,6 +1221,7 @@
 {
 	struct mem_dqblk *dm = &dquot->dq_dqb;
 
+	spin_lock(&dq_data_lock);
 	di->dqb_bhardlimit = dm->dqb_bhardlimit;
 	di->dqb_bsoftlimit = dm->dqb_bsoftlimit;
 	di->dqb_curspace = dm->dqb_curspace;
@@ -1357,16 +1231,21 @@
 	di->dqb_btime = dm->dqb_btime;
 	di->dqb_itime = dm->dqb_itime;
 	di->dqb_valid = QIF_ALL;
+	spin_unlock(&dq_data_lock);
 }
 
 int vfs_get_dqblk(struct super_block *sb, int type, qid_t id, struct if_dqblk *di)
 {
-	struct dquot *dquot = dqget(sb, id, type);
+	struct dquot *dquot;
 
-	if (!dquot)
-		return -EINVAL;
+	down_read(&sb_dqopt(sb)->dqoff_sem);
+	if (!(dquot = dqget(sb, id, type))) {
+		up_read(&sb_dqopt(sb)->dqoff_sem);
+		return -ESRCH;
+	}
 	do_get_dqblk(dquot, di);
 	dqput(dquot);
+	up_read(&sb_dqopt(sb)->dqoff_sem);
 	return 0;
 }
 
@@ -1376,6 +1255,7 @@
 	struct mem_dqblk *dm = &dquot->dq_dqb;
 	int check_blim = 0, check_ilim = 0;
 
+	spin_lock(&dq_data_lock);
 	if (di->dqb_valid & QIF_SPACE) {
 		dm->dqb_curspace = di->dqb_curspace;
 		check_blim = 1;
@@ -1402,7 +1282,7 @@
 	if (check_blim) {
 		if (!dm->dqb_bsoftlimit || toqb(dm->dqb_curspace) < dm->dqb_bsoftlimit) {
 			dm->dqb_btime = 0;
-			dquot->dq_flags &= ~DQ_BLKS;
+			clear_bit(DQ_BLKS_B, &dquot->dq_flags);
 		}
 		else if (!(di->dqb_valid & QIF_BTIME))	/* Set grace only if user hasn't provided his own... */
 			dm->dqb_btime = get_seconds() + sb_dqopt(dquot->dq_sb)->info[dquot->dq_type].dqi_bgrace;
@@ -1410,46 +1290,67 @@
 	if (check_ilim) {
 		if (!dm->dqb_isoftlimit || dm->dqb_curinodes < dm->dqb_isoftlimit) {
 			dm->dqb_itime = 0;
-			dquot->dq_flags &= ~DQ_INODES;
+			clear_bit(DQ_INODES_B, &dquot->dq_flags);
 		}
 		else if (!(di->dqb_valid & QIF_ITIME))	/* Set grace only if user hasn't provided his own... */
 			dm->dqb_itime = get_seconds() + sb_dqopt(dquot->dq_sb)->info[dquot->dq_type].dqi_igrace;
 	}
 	if (dm->dqb_bhardlimit || dm->dqb_bsoftlimit || dm->dqb_ihardlimit || dm->dqb_isoftlimit)
-		dquot->dq_flags &= ~DQ_FAKE;
+		clear_bit(DQ_FAKE_B, &dquot->dq_flags);
 	else
-		dquot->dq_flags |= DQ_FAKE;
-	dquot->dq_flags |= DQ_MOD;
+		set_bit(DQ_FAKE_B, &dquot->dq_flags);
+	mark_dquot_dirty(dquot);
+	spin_unlock(&dq_data_lock);
 }
 
 int vfs_set_dqblk(struct super_block *sb, int type, qid_t id, struct if_dqblk *di)
 {
-	struct dquot *dquot = dqget(sb, id, type);
+	struct dquot *dquot;
 
-	if (!dquot)
-		return -EINVAL;
+	down_read(&sb_dqopt(sb)->dqoff_sem);
+	if (!(dquot = dqget(sb, id, type))) {
+		up_read(&sb_dqopt(sb)->dqoff_sem);
+		return -ESRCH;
+	}
 	do_set_dqblk(dquot, di);
 	dqput(dquot);
+	up_read(&sb_dqopt(sb)->dqoff_sem);
 	return 0;
 }
 
 /* Generic routine for getting common part of quota file information */
 int vfs_get_dqinfo(struct super_block *sb, int type, struct if_dqinfo *ii)
 {
-	struct mem_dqinfo *mi = sb_dqopt(sb)->info + type;
-
+	struct mem_dqinfo *mi;
+  
+	down_read(&sb_dqopt(sb)->dqoff_sem);
+	if (!sb_has_quota_enabled(sb, type)) {
+		up_read(&sb_dqopt(sb)->dqoff_sem);
+		return -ESRCH;
+	}
+	mi = sb_dqopt(sb)->info + type;
+	spin_lock(&dq_data_lock);
 	ii->dqi_bgrace = mi->dqi_bgrace;
 	ii->dqi_igrace = mi->dqi_igrace;
 	ii->dqi_flags = mi->dqi_flags & DQF_MASK;
 	ii->dqi_valid = IIF_ALL;
+	spin_unlock(&dq_data_lock);
+	up_read(&sb_dqopt(sb)->dqoff_sem);
 	return 0;
 }
 
 /* Generic routine for setting common part of quota file information */
 int vfs_set_dqinfo(struct super_block *sb, int type, struct if_dqinfo *ii)
 {
-	struct mem_dqinfo *mi = sb_dqopt(sb)->info + type;
+	struct mem_dqinfo *mi;
 
+	down_read(&sb_dqopt(sb)->dqoff_sem);
+	if (!sb_has_quota_enabled(sb, type)) {
+		up_read(&sb_dqopt(sb)->dqoff_sem);
+		return -ESRCH;
+	}
+	mi = sb_dqopt(sb)->info + type;
+	spin_lock(&dq_data_lock);
 	if (ii->dqi_valid & IIF_BGRACE)
 		mi->dqi_bgrace = ii->dqi_bgrace;
 	if (ii->dqi_valid & IIF_IGRACE)
@@ -1457,6 +1358,8 @@
 	if (ii->dqi_valid & IIF_FLAGS)
 		mi->dqi_flags = (mi->dqi_flags & ~DQF_MASK) | (ii->dqi_flags & DQF_MASK);
 	mark_info_dirty(mi);
+	spin_unlock(&dq_data_lock);
+	up_read(&sb_dqopt(sb)->dqoff_sem);
 	return 0;
 }
 
@@ -1502,7 +1405,7 @@
 	register_sysctl_table(sys_table, 0);
 	for (i = 0; i < NR_DQHASH; i++)
 		INIT_LIST_HEAD(dquot_hash + i);
-	printk(KERN_NOTICE "VFS: Disk quotas v%s\n", __DQUOT_VERSION__);
+	printk(KERN_NOTICE "VFS: Disk quotas %s\n", __DQUOT_VERSION__);
 
 	dquot_cachep = kmem_cache_create("dquot", 
 			sizeof(struct dquot), sizeof(unsigned long) * 4,
@@ -1519,3 +1422,5 @@
 EXPORT_SYMBOL(register_quota_format);
 EXPORT_SYMBOL(unregister_quota_format);
 EXPORT_SYMBOL(dqstats);
+EXPORT_SYMBOL(dq_list_lock);
+EXPORT_SYMBOL(dq_data_lock);
diff -ruNX /home/jack/.kerndiffexclude linux-2.5.48/fs/inode.c linux-2.5.48-1-smplocks/fs/inode.c
--- linux-2.5.48/fs/inode.c	Tue Nov 26 22:31:52 2002
+++ linux-2.5.48-1-smplocks/fs/inode.c	Tue Nov 26 22:33:33 2002
@@ -1136,9 +1136,8 @@
 
 	if (!sb->dq_op)
 		return;	/* nothing to do */
-	/* We have to be protected against other CPUs */
-	lock_kernel();		/* This lock is for quota code */
 	spin_lock(&inode_lock);	/* This lock is for inodes code */
+	/* We don't have to lock against quota code - test IS_QUOTAINIT is just for speedup... */
  
 	list_for_each(act_head, &inode_in_use) {
 		inode = list_entry(act_head, struct inode, i_list);
@@ -1161,7 +1160,6 @@
 			remove_inode_dquot_ref(inode, type, &tofree_head);
 	}
 	spin_unlock(&inode_lock);
-	unlock_kernel();
 
 	put_dquot_list(&tofree_head);
 }
diff -ruNX /home/jack/.kerndiffexclude linux-2.5.48/fs/quota.c linux-2.5.48-1-smplocks/fs/quota.c
--- linux-2.5.48/fs/quota.c	Sat Oct 12 06:22:45 2002
+++ linux-2.5.48-1-smplocks/fs/quota.c	Tue Nov 26 22:33:33 2002
@@ -84,6 +84,7 @@
 		case Q_SETINFO:
 		case Q_SETQUOTA:
 		case Q_GETQUOTA:
+			/* This is just informative test so we are satisfied without a lock */
 			if (!sb_has_quota_enabled(sb, type))
 				return -ESRCH;
 	}
@@ -151,7 +152,13 @@
 		case Q_GETFMT: {
 			__u32 fmt;
 
+			down_read(&sb_dqopt(sb)->dqoff_sem);
+			if (!sb_has_quota_enabled(sb, type)) {
+				up_read(&sb_dqopt(sb)->dqoff_sem);
+				return -ESRCH;
+			}
 			fmt = sb_dqopt(sb)->info[type].dqi_format->qf_fmt_id;
+			up_read(&sb_dqopt(sb)->dqoff_sem);
 			if (copy_to_user(addr, &fmt, sizeof(fmt)))
 				return -EFAULT;
 			return 0;
@@ -244,7 +251,6 @@
 	struct super_block *sb = NULL;
 	int ret = -EINVAL;
 
-	lock_kernel();
 	cmds = cmd >> SUBCMDSHIFT;
 	type = cmd & SUBCMDMASK;
 
@@ -259,6 +265,5 @@
 out:
 	if (sb)
 		drop_super(sb);
-	unlock_kernel();
 	return ret;
 }
diff -ruNX /home/jack/.kerndiffexclude linux-2.5.48/fs/super.c linux-2.5.48-1-smplocks/fs/super.c
--- linux-2.5.48/fs/super.c	Tue Nov 26 22:31:55 2002
+++ linux-2.5.48-1-smplocks/fs/super.c	Tue Nov 26 22:33:33 2002
@@ -68,7 +68,7 @@
 		atomic_set(&s->s_active, 1);
 		sema_init(&s->s_vfs_rename_sem,1);
 		sema_init(&s->s_dquot.dqio_sem, 1);
-		sema_init(&s->s_dquot.dqoff_sem, 1);
+		init_rwsem(&s->s_dquot.dqoff_sem);
 		s->s_maxbytes = MAX_NON_LFS;
 		s->dq_op = sb_dquot_ops;
 		s->s_qcop = sb_quotactl_ops;
diff -ruNX /home/jack/.kerndiffexclude linux-2.5.48/include/linux/quota.h linux-2.5.48-1-smplocks/include/linux/quota.h
--- linux-2.5.48/include/linux/quota.h	Sat Oct 12 06:22:15 2002
+++ linux-2.5.48-1-smplocks/include/linux/quota.h	Tue Nov 26 22:33:33 2002
@@ -37,6 +37,7 @@
 
 #include <linux/errno.h>
 #include <linux/types.h>
+#include <linux/spinlock.h>
 
 #define __DQUOT_VERSION__	"dquot_6.5.1"
 #define __DQUOT_NUM_VERSION__	6*10000+5*100+1
@@ -44,6 +45,9 @@
 typedef __kernel_uid32_t qid_t; /* Type in which we store ids in memory */
 typedef __u64 qsize_t;          /* Type in which we store sizes */
 
+extern spinlock_t dq_list_lock;
+extern spinlock_t dq_data_lock;
+
 /* Size of blocks in which are counted size limits */
 #define QUOTABLOCK_BITS 10
 #define QUOTABLOCK_SIZE (1 << QUOTABLOCK_BITS)
@@ -155,7 +159,7 @@
 
 struct mem_dqinfo {
 	struct quota_format_type *dqi_format;
-	int dqi_flags;
+	unsigned long dqi_flags;
 	unsigned int dqi_bgrace;
 	unsigned int dqi_igrace;
 	union {
@@ -165,18 +169,19 @@
 };
 
 #define DQF_MASK 0xffff		/* Mask for format specific flags */
-#define DQF_INFO_DIRTY 0x10000  /* Is info dirty? */
-#define DQF_ANY_DQUOT_DIRTY 0x20000	/* Is any dquot dirty? */
+#define DQF_INFO_DIRTY_B 16
+#define DQF_ANY_DQUOT_DIRTY_B 17
+#define DQF_INFO_DIRTY (1 << DQF_INFO_DIRTY_B)	/* Is info dirty? */
+#define DQF_ANY_DQUOT_DIRTY (1 << DQF_ANY_DQUOT_DIRTY B)	/* Is any dquot dirty? */
 
 extern inline void mark_info_dirty(struct mem_dqinfo *info)
 {
-	info->dqi_flags |= DQF_INFO_DIRTY;
+	set_bit(DQF_INFO_DIRTY_B, &info->dqi_flags);
 }
 
-#define info_dirty(info) ((info)->dqi_flags & DQF_INFO_DIRTY)
-
-#define info_any_dirty(info) ((info)->dqi_flags & DQF_INFO_DIRTY ||\
-			      (info)->dqi_flags & DQF_ANY_DQUOT_DIRTY)
+#define info_dirty(info) test_bit(DQF_INFO_DIRTY_B, &(info)->dqi_flags)
+#define info_any_dquot_dirty(info) test_bit(DQF_ANY_DQUOT_DIRTY_B, &(info)->dqi_flags)
+#define info_any_dirty(info) (info_dirty(info) || info_any_dquot_dirty(info))
 
 #define sb_dqopt(sb) (&(sb)->s_dquot)
 
@@ -195,30 +200,29 @@
 
 #define NR_DQHASH 43            /* Just an arbitrary number */
 
-#define DQ_LOCKED     0x01	/* dquot under IO */
-#define DQ_MOD        0x02	/* dquot modified since read */
-#define DQ_BLKS       0x10	/* uid/gid has been warned about blk limit */
-#define DQ_INODES     0x20	/* uid/gid has been warned about inode limit */
-#define DQ_FAKE       0x40	/* no limits only usage */
-#define DQ_INVAL      0x80	/* dquot is going to be invalidated */
+#define DQ_MOD_B	0
+#define DQ_BLKS_B	1
+#define DQ_INODES_B	2
+#define DQ_FAKE_B	3
+
+#define DQ_MOD        (1 << DQ_MOD_B)	/* dquot modified since read */
+#define DQ_BLKS       (1 << DQ_BLKS_B)	/* uid/gid has been warned about blk limit */
+#define DQ_INODES     (1 << DQ_INODES_B)	/* uid/gid has been warned about inode limit */
+#define DQ_FAKE       (1 << DQ_FAKE_B)	/* no limits only usage */
 
 struct dquot {
 	struct list_head dq_hash;	/* Hash list in memory */
 	struct list_head dq_inuse;	/* List of all quotas */
 	struct list_head dq_free;	/* Free list element */
-	wait_queue_head_t dq_wait_lock;	/* Pointer to waitqueue on dquot lock */
-	wait_queue_head_t dq_wait_free;	/* Pointer to waitqueue for quota to be unused */
-	int dq_count;			/* Use count */
-	int dq_dup_ref;			/* Number of duplicated refences */
+	struct semaphore dq_lock;	/* dquot IO lock */
+	atomic_t dq_count;		/* Use count */
 
 	/* fields after this point are cleared when invalidating */
 	struct super_block *dq_sb;	/* superblock this applies to */
 	unsigned int dq_id;		/* ID this applies to (uid, gid) */
 	loff_t dq_off;			/* Offset of dquot on disk */
+	unsigned long dq_flags;		/* See DQ_* */
 	short dq_type;			/* Type of quota */
-	short dq_flags;			/* See DQ_* */
-	unsigned long dq_referenced;	/* Number of times this dquot was 
-					   referenced during its lifetime */
 	struct mem_dqblk dq_dqb;	/* Diskquota usage */
 };
 
@@ -276,7 +280,7 @@
 struct quota_info {
 	unsigned int flags;			/* Flags for diskquotas on this device */
 	struct semaphore dqio_sem;		/* lock device while I/O in progress */
-	struct semaphore dqoff_sem;		/* serialize quota_off() and quota_on() on device */
+	struct rw_semaphore dqoff_sem;		/* serialize quota_off() and quota_on() on device and ops using quota_info struct, pointers from inode to dquots */
 	struct file *files[MAXQUOTAS];		/* fp's to quotafiles */
 	struct mem_dqinfo info[MAXQUOTAS];	/* Information for each quota type */
 	struct quota_format_ops *ops[MAXQUOTAS];	/* Operations for each type */
@@ -284,26 +288,17 @@
 
 /* Inline would be better but we need to dereference super_block which is not defined yet */
 #define mark_dquot_dirty(dquot) do {\
-	dquot->dq_flags |= DQ_MOD;\
-	sb_dqopt(dquot->dq_sb)->info[dquot->dq_type].dqi_flags |= DQF_ANY_DQUOT_DIRTY;\
+	set_bit(DQF_ANY_DQUOT_DIRTY_B, &(sb_dqopt((dquot)->dq_sb)->info[(dquot)->dq_type].dqi_flags));\
+	set_bit(DQ_MOD_B, &(dquot)->dq_flags);\
 } while (0)
 
-#define dquot_dirty(dquot) ((dquot)->dq_flags & DQ_MOD)
-
-static inline int is_enabled(struct quota_info *dqopt, int type)
-{
-	switch (type) {
-		case USRQUOTA:
-			return dqopt->flags & DQUOT_USR_ENABLED;
-		case GRPQUOTA:
-			return dqopt->flags & DQUOT_GRP_ENABLED;
-	}
-	return 0;
-}
+#define dquot_dirty(dquot) test_bit(DQ_MOD_B, &(dquot)->dq_flags)
 
-#define sb_any_quota_enabled(sb) (is_enabled(sb_dqopt(sb), USRQUOTA) | is_enabled(sb_dqopt(sb), GRPQUOTA))
+#define sb_has_quota_enabled(sb, type) ((type)==USRQUOTA ? \
+	(sb_dqopt(sb)->flags & DQUOT_USR_ENABLED) : (sb_dqopt(sb)->flags & DQUOT_GRP_ENABLED))
 
-#define sb_has_quota_enabled(sb, type) (is_enabled(sb_dqopt(sb), type))
+#define sb_any_quota_enabled(sb) (sb_has_quota_enabled(sb, USRQUOTA) | \
+				  sb_has_quota_enabled(sb, GRPQUOTA))
 
 int register_quota_format(struct quota_format_type *fmt);
 void unregister_quota_format(struct quota_format_type *fmt);
diff -ruNX /home/jack/.kerndiffexclude linux-2.5.48/include/linux/quotaops.h linux-2.5.48-1-smplocks/include/linux/quotaops.h
--- linux-2.5.48/include/linux/quotaops.h	Sat Oct 12 06:21:36 2002
+++ linux-2.5.48-1-smplocks/include/linux/quotaops.h	Tue Nov 26 22:33:33 2002
@@ -46,36 +46,31 @@
 {
 	if (!inode->i_sb)
 		BUG();
-	lock_kernel();
 	if (sb_any_quota_enabled(inode->i_sb) && !IS_NOQUOTA(inode))
 		inode->i_sb->dq_op->initialize(inode, -1);
-	unlock_kernel();
 }
 
 static __inline__ void DQUOT_DROP(struct inode *inode)
 {
-	lock_kernel();
 	if (IS_QUOTAINIT(inode)) {
 		if (!inode->i_sb)
 			BUG();
 		inode->i_sb->dq_op->drop(inode);	/* Ops must be set when there's any quota... */
 	}
-	unlock_kernel();
 }
 
 static __inline__ int DQUOT_PREALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
 {
-	lock_kernel();
 	if (sb_any_quota_enabled(inode->i_sb)) {
 		/* Used space is updated in alloc_space() */
-		if (inode->i_sb->dq_op->alloc_space(inode, nr, 1) == NO_QUOTA) {
-			unlock_kernel();
+		if (inode->i_sb->dq_op->alloc_space(inode, nr, 1) == NO_QUOTA)
 			return 1;
-		}
 	}
-	else
+	else {
+		spin_lock(&dq_data_lock);
 		inode_add_bytes(inode, nr);
-	unlock_kernel();
+		spin_unlock(&dq_data_lock);
+	}
 	return 0;
 }
 
@@ -89,17 +84,16 @@
 
 static __inline__ int DQUOT_ALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
 {
-	lock_kernel();
 	if (sb_any_quota_enabled(inode->i_sb)) {
 		/* Used space is updated in alloc_space() */
-		if (inode->i_sb->dq_op->alloc_space(inode, nr, 0) == NO_QUOTA) {
-			unlock_kernel();
+		if (inode->i_sb->dq_op->alloc_space(inode, nr, 0) == NO_QUOTA)
 			return 1;
-		}
 	}
-	else
+	else {
+		spin_lock(&dq_data_lock);
 		inode_add_bytes(inode, nr);
-	unlock_kernel();
+		spin_unlock(&dq_data_lock);
+	}
 	return 0;
 }
 
@@ -113,26 +107,23 @@
 
 static __inline__ int DQUOT_ALLOC_INODE(struct inode *inode)
 {
-	lock_kernel();
 	if (sb_any_quota_enabled(inode->i_sb)) {
 		DQUOT_INIT(inode);
-		if (inode->i_sb->dq_op->alloc_inode(inode, 1) == NO_QUOTA) {
-			unlock_kernel();
+		if (inode->i_sb->dq_op->alloc_inode(inode, 1) == NO_QUOTA)
 			return 1;
-		}
 	}
-	unlock_kernel();
 	return 0;
 }
 
 static __inline__ void DQUOT_FREE_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
 {
-	lock_kernel();
 	if (sb_any_quota_enabled(inode->i_sb))
 		inode->i_sb->dq_op->free_space(inode, nr);
-	else
+	else {
+		spin_lock(&dq_data_lock);
 		inode_sub_bytes(inode, nr);
-	unlock_kernel();
+		spin_unlock(&dq_data_lock);
+	}
 }
 
 static __inline__ void DQUOT_FREE_SPACE(struct inode *inode, qsize_t nr)
@@ -143,23 +134,17 @@
 
 static __inline__ void DQUOT_FREE_INODE(struct inode *inode)
 {
-	lock_kernel();
 	if (sb_any_quota_enabled(inode->i_sb))
 		inode->i_sb->dq_op->free_inode(inode, 1);
-	unlock_kernel();
 }
 
 static __inline__ int DQUOT_TRANSFER(struct inode *inode, struct iattr *iattr)
 {
-	lock_kernel();
 	if (sb_any_quota_enabled(inode->i_sb) && !IS_NOQUOTA(inode)) {
 		DQUOT_INIT(inode);
-		if (inode->i_sb->dq_op->transfer(inode, iattr) == NO_QUOTA) {
-			unlock_kernel();
+		if (inode->i_sb->dq_op->transfer(inode, iattr) == NO_QUOTA)
 			return 1;
-		}
 	}
-	unlock_kernel();
 	return 0;
 }
 
@@ -169,10 +154,8 @@
 {
 	int ret = -ENOSYS;
 
-	lock_kernel();
 	if (sb->s_qcop && sb->s_qcop->quota_off)
 		ret = sb->s_qcop->quota_off(sb, -1);
-	unlock_kernel();
 	return ret;
 }
 
@@ -192,9 +175,7 @@
 #define DQUOT_TRANSFER(inode, iattr)		(0)
 extern __inline__ int DQUOT_PREALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
 {
-	lock_kernel();
 	inode_add_bytes(inode, nr);
-	unlock_kernel();
 	return 0;
 }
 
@@ -207,9 +188,7 @@
 
 extern __inline__ int DQUOT_ALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
 {
-	lock_kernel();
 	inode_add_bytes(inode, nr);
-	unlock_kernel();
 	return 0;
 }
 
@@ -222,9 +201,7 @@
 
 extern __inline__ void DQUOT_FREE_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
 {
-	lock_kernel();
 	inode_sub_bytes(inode, nr);
-	unlock_kernel();
 }
 
 extern __inline__ void DQUOT_FREE_SPACE(struct inode *inode, qsize_t nr)
