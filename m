Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292601AbSBZBTe>; Mon, 25 Feb 2002 20:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292611AbSBZBTT>; Mon, 25 Feb 2002 20:19:19 -0500
Received: from relay01.valueweb.net ([216.219.253.235]:38926 "EHLO
	relay01.valueweb.net") by vger.kernel.org with ESMTP
	id <S292601AbSBZBTH>; Mon, 25 Feb 2002 20:19:07 -0500
From: Craig Christophel <merlin@transgeek.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] alpha -- quota locking -- rfh
Date: Mon, 25 Feb 2002 20:19:43 -0500
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_V094AB25YE0CK55VG3KR"
Message-Id: <20020226011851Z289189-18099+56@thor.valueweb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_V094AB25YE0CK55VG3KR
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Ok,

	I have changed the quota locking schematics.  dquot_lock is now used to 
protect all of the non-blocking operations.  lock_kernel is reduced to 
inode->i_blocks coverage.  Be warned this patch is very alpha, but any extra 
eyes on the source are very welcome.  

here is the overview / development notes.

They spell out the path taken to protect the dquot sections.

shrink_dqcache_memory:
	locks dquot_lock
	calls prune_dqcache
	unlocks dquot_lock
prune_dqcache:
	unlocks dquot_lock
	calls kmem_cache_free
	locks dquot_lock
DQ_INIT:
	takes dquot_lock
	calls dquot_initialize
	unlocks dquot_lock
DQ_DROP:
	locks dquot_lock
	calls dquot_drop
	unlocks dquot_lock
DQUOT_PREALLOC_BLOCK_NODIRTY:
	locks dquot_lock
	calls dquot_alloc_block
	unlocks dquot_lock
DQUOT_PREALLOC_BLOCK:
	calls DQUOT_PREALLOC_BLOCK_NODIRTY
	calls mark_inode_dirty
DQUOT_ALLOC_BLOCK_NODIRTY:
	locks dquot_lock
	calls dquot_alloc_block
	unlocks dquot_lock
DQUOT_ALLOC_BLOCK:
	calls DQUOT_ALLOC_BLOCK_NODIRTY
	calls mark_inode_dirty
DQUOT_ALLOC_INODE:
	locks dquot_lock
	unlocks dquot_lock
	calls DQUOT_INIT
	locks dquot_lock
	calls dquot_alloc_inode
	unlocks dquot_lock
DQUOT_FREE_BLOCK_NODIRTY:
	locks dquot_lock
	calls dquot_free_block
	unlocks dquot_lock
DQUOT_FREE_BLOCK:
	calls DQUOT_FREE_BLOCK_NODIRY
	calls mark_inode_dirty
DQUOT_FREE_INODE:
	locks dquot_lock
	calls dquot_free_inode
	unlocks dquot_lock
DQUOT_TRANSFER:
	locks dquot_lock
	unlocks dquot_lock
	calls DQUOT_INIT
	locks dquot_lock
	calls dquot_transfer
	unlocks dquot_lock
sys_quotactl:
	locks dquot_lock
	calls quota_on
	calls quota_off
	calls get_quota
	calls sync_dquots
	calls get_stats
	calls quota_root_squash
	unlocks dquot_lock
quota_on:
	unlocks dquot_lock
	downs dqoff_sem
	locks dquot_lock
	calls dquot_drop
	calls dqget
	calls dqput
	calls add_dquot_ref
	unlocks dquot_lock
	ups dqoff_sem
	locks dquot_lock
quota_off:
	unlocks dquot_lock
	downs dqoff_sem
	locks dquot_lock
	calls remove_dquot_ref
	calls invalidate_dquots
	unlocks dquot_lock
	ups dqoff_sem
	locks dquot_lock
get_quota:
	calls dqget
	calls dqput
	unlocks dquot_lock
	calls copy_to_user
	locks dquot_lock
synv_dquots:
	unlocks dquot_lock
	calls wait_on_dquot
	locks dquot_lock
	calls write_dquot
	calls dqput
get_stats:
	unlocks dquot_lock
	calls copy_to_user
	locks dquot_lock
quota_root_squash:
	unlocks dquot_lock
	calls copy_from_user
	locks dquot_lock
invalidate_dquots:
	unlocks dquot_lock
	calls __wait_dquot_unused
	locks dquot_lock
	unlocks dquot_lock
	calls kmem_cache_free
	locks dquot_lock
add_dquot_ref:
	unlocks dquot_lock
	locks the file_list
	unlocks the file_list
	locks dquot_lock
	calls dquot_initialize
	calls dqput
	unlocks dquot_lock
	locks dquot_lock
dquot_drop:
	calls dqput
remove_dquot_ref:
	locks dquot_lock
	calls remove_inode_dquot_ref
	unlocks dquot_lock
	calls put_dquot_list
remove_inode_dquot_ref:
	calls dqput
put_dquot_list:
	locks dquot_lock
	calls dqput
	unlocks dquot_lock
dquot_transfer:
	calls dqget
	calls dqduplicate
	calls dquot_decr_inodes
	calls dquot_incr_inodes
	calls flush_warnings
	calls dqput
dquot_free_inode:
	calls dqduplicate
	calls dquot_decr_inodes
	calls dqput
dquot_free_block:
	calls dqduplicate
	calls dquot_decr_blocks
	calls dqput
dquot_alloc_inode:
	calls check_idq
	calls dquot_incr_inodes
	calls flush_warnings
	calls dqput
dquot_alloc_block:
	calls dqduplicate
	calls check_bdq
	calls dquot_incr_blocks
	calls flush_warnings
flush_warnings:
	calls print_warning
print_warning:
	calls need_print_warning
	unlocks dquot_lock
	calls tty_write_message
	locks dquot_lock
need_print_warning:
dquot_incr_blocks:
dquot_incr_inodes:
check_bdq:
dqduplicate:
dquot_drop:
	calls dqput

dquot_initialize:
	calls dqget

dqget:
	unlocks dquot_lock
	calls schedule
	locks dquot_lock
	calls read_dquot
----
	unlocks dquot_lock
	calls wait_on_dquot
	calls dqput
read_dquot:
	unlocks dquot_lock
	calls lock_dquot
	locks dqio_sem
	unlocks dqio_sem
	locks dquot_lock
	unlocks dquot_lock

lock_dquot:
dqput:
	calls write_dquot
	unlocks dquot_lock
	calls wake_up on dq_wait_free
	locks dquot_lock
write_dquot:
	unlocks dquot_lock
	downs dqio_sem
	locks dquot_lock
	unlocks dquot_lock
	ups dqio_sem
	locks dquot_lock


--------------Boundary-00=_V094AB25YE0CK55VG3KR
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="quotalock.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="quotalock.diff"

===== fs/dquot.c 1.23 vs edited =====
--- 1.23/fs/dquot.c	Tue Feb 12 00:52:32 2002
+++ edited/fs/dquot.c	Mon Feb 25 20:05:57 2002
@@ -117,6 +117,8 @@
 
 static struct dqstats dqstats;
 
+spinlock_t dquot_lock;
+
 static void dqput(struct dquot *);
 static struct dquot *dqduplicate(struct dquot *);
 
@@ -271,8 +273,12 @@
 	struct semaphore *sem = &dquot->dq_sb->s_dquot.dqio_sem;
 	struct dqblk dqbuf;
 
-	down(sem);
 	filp = dquot->dq_sb->s_dquot.files[type];
+	if(filp == (struct file *)NULL)
+		return;
+	spin_unlock(&dquot_lock);
+
+	down(sem);
 	offset = dqoff(dquot->dq_id);
 	fs = get_fs();
 	set_fs(KERNEL_DS);
@@ -282,10 +288,11 @@
 	 * so we don't loop forever on failure.
 	 */
 	memcpy(&dqbuf, &dquot->dq_dqb, sizeof(struct dqblk));
+	spin_lock(&dquot_lock);
 	dquot->dq_flags &= ~DQ_MOD;
+	spin_unlock(&dquot_lock);
 	ret = 0;
-	if (filp)
-		ret = filp->f_op->write(filp, (char *)&dqbuf, 
+	ret = filp->f_op->write(filp, (char *)&dqbuf, 
 					sizeof(struct dqblk), &offset);
 	if (ret != sizeof(struct dqblk))
 		printk(KERN_WARNING "VFS: dquota write failed on dev %s\n",
@@ -293,6 +300,7 @@
 
 	set_fs(fs);
 	up(sem);
+	spin_lock(&dquot_lock);
 	dqstats.writes++;
 }
 
@@ -307,6 +315,7 @@
 	if (filp == (struct file *)NULL)
 		return;
 
+	spin_unlock(&dquot_lock);
 	lock_dquot(dquot);
 	if (!dquot->dq_sb)	/* Invalidated quota? */
 		goto out_lock;
@@ -319,10 +328,12 @@
 	up(&dquot->dq_sb->s_dquot.dqio_sem);
 	set_fs(fs);
 
+	spin_lock(&dquot_lock);
 	if (dquot->dq_bhardlimit == 0 && dquot->dq_bsoftlimit == 0 &&
 	    dquot->dq_ihardlimit == 0 && dquot->dq_isoftlimit == 0)
 		dquot->dq_flags |= DQ_FAKE;
 	dqstats.reads++;
+	spin_unlock(&dquot_lock);
 out_lock:
 	unlock_dquot(dquot);
 }
@@ -343,18 +354,23 @@
 		if (dquot->dq_type != type)
 			continue;
 		dquot->dq_flags |= DQ_INVAL;
-		if (dquot->dq_count)
+		if (dquot->dq_count) {
+			spin_unlock(&dquot_lock);
 			/*
 			 *  Wait for any users of quota. As we have already cleared the flags in
 			 *  superblock and cleared all pointers from inodes we are assured
 			 *  that there will be no new users of this quota.
 			 */
 			__wait_dquot_unused(dquot);
+			spin_lock(&dquot_lock);
+		}
 		/* Quota now have no users and it has been written on last dqput() */
 		remove_dquot_hash(dquot);
 		remove_free_dquot(dquot);
 		remove_inuse(dquot);
+		spin_unlock(&dquot_lock);
 		kmem_cache_free(dquot_cachep, dquot);
+		spin_lock(&dquot_lock);
 		goto restart;
 	}
 }
@@ -364,7 +380,6 @@
 	struct list_head *head;
 	struct dquot *dquot;
 
-	lock_kernel();
 restart:
 	for (head = inuse_list.next; head != &inuse_list; head = head->next) {
 		dquot = list_entry(head, struct dquot, dq_inuse);
@@ -378,15 +393,17 @@
 			continue;
 		/* Raise use count so quota won't be invalidated. We can't use dqduplicate() as it does too many tests */
 		dquot->dq_count++;
-		if (dquot->dq_flags & DQ_LOCKED)
+		if (dquot->dq_flags & DQ_LOCKED) {
+			spin_unlock(&dquot_lock);
 			wait_on_dquot(dquot);
+			spin_lock(&dquot_lock);
+		}
 		if (dquot->dq_flags & DQ_MOD)
 			write_dquot(dquot);
 		dqput(dquot);
 		goto restart;
 	}
 	dqstats.syncs++;
-	unlock_kernel();
 	return 0;
 }
 
@@ -402,7 +419,9 @@
 		remove_dquot_hash(dquot);
 		remove_free_dquot(dquot);
 		remove_inuse(dquot);
+		spin_unlock(&dquot_lock);
 		kmem_cache_free(dquot_cachep, dquot);
+		spin_lock(&dquot_lock);
 		count--;
 		head = free_dquots.prev;
 	}
@@ -423,11 +442,10 @@
 int shrink_dqcache_memory(int priority, unsigned int gfp_mask)
 {
 	int count = 0;
-
-	lock_kernel();
+	spin_lock(&dquot_lock);
 	count = nr_free_dquots / priority;
 	prune_dqcache(count);
-	unlock_kernel();
+	spin_unlock(&dquot_lock);
 	kmem_cache_shrink(dquot_cachep);
 	return 0;
 }
@@ -468,7 +486,9 @@
 	/* If dquot is going to be invalidated invalidate_dquots() is going to free it so */
 	if (!(dquot->dq_flags & DQ_INVAL))
 		put_dquot_last(dquot);	/* Place at end of LRU free queue */
+	spin_unlock(&dquot_lock);
 	wake_up(&dquot->dq_wait_free);
+	spin_lock(&dquot_lock);
 }
 
 static struct dquot *get_empty_dquot(void)
@@ -507,8 +527,11 @@
 
 	if ((dquot = find_dquot(hashent, sb, id, type)) == NODQUOT) {
 		if (empty == NODQUOT) {
-			if ((empty = get_empty_dquot()) == NODQUOT)
+			if ((empty = get_empty_dquot()) == NODQUOT) {
+				spin_unlock(&dquot_lock);
 				schedule();	/* Try to wait for a moment... */
+				spin_lock(&dquot_lock);
+			}
 			goto we_slept;
 		}
 		dquot = empty;
@@ -518,11 +541,14 @@
 		/* hash it first so it can be found */
 		insert_dquot_hash(dquot);
         	read_dquot(dquot);
+		spin_lock(&dquot_lock);
 	} else {
 		if (!dquot->dq_count++)
 			remove_free_dquot(dquot);
 		dqstats.cache_hits++;
+		spin_unlock(&dquot_lock);
 		wait_on_dquot(dquot);
+		spin_lock(&dquot_lock);
 		if (empty)
 			dqput(empty);
 	}
@@ -576,6 +602,7 @@
 	if (!sb->dq_op)
 		return;	/* nothing to do */
 
+	spin_unlock(&dquot_lock);
 restart:
 	file_list_lock();
 	for (p = sb->s_files.next; p != &sb->s_files; p = p->next) {
@@ -585,14 +612,17 @@
 			struct vfsmount *mnt = mntget(filp->f_vfsmnt);
 			struct dentry *dentry = dget(filp->f_dentry);
 			file_list_unlock();
+			spin_lock(&dquot_lock);
 			sb->dq_op->initialize(inode, type);
 			dput(dentry);
+			spin_unlock(&dquot_lock);
 			mntput(mnt);
 			/* As we may have blocked we had better restart... */
 			goto restart;
 		}
 	}
 	file_list_unlock();
+	spin_lock(&dquot_lock);
 }
 
 /* Return 0 if dqput() won't block (note that 1 doesn't necessarily mean blocking) */
@@ -636,7 +666,7 @@
 	struct list_head *act_head;
 	struct dquot *dquot;
 
-	lock_kernel();
+	spin_lock(&dquot_lock);
 	act_head = tofree_head->next;
 	/* So now we have dquots on the list... Just free them */
 	while (act_head != tofree_head) {
@@ -646,7 +676,7 @@
 		INIT_LIST_HEAD(&dquot->dq_free);
 		dqput(dquot);
 	}
-	unlock_kernel();
+	spin_unlock(&dquot_lock);
 }
 
 static inline void dquot_incr_inodes(struct dquot *dquot, unsigned long number)
@@ -709,18 +739,21 @@
 static void print_warning(struct dquot *dquot, const char warntype)
 {
 	char *msg = NULL;
+	char *dq_sid = dquot->dq_sb->s_id;
+	char *dq_type = quotatypes[dquot->dq_type];
 	int flag = (warntype == BHARDWARN || warntype == BSOFTLONGWARN) ? DQ_BLKS :
 	  ((warntype == IHARDWARN || warntype == ISOFTLONGWARN) ? DQ_INODES : 0);
 
 	if (!need_print_warning(dquot, flag))
 		return;
 	dquot->dq_flags |= flag;
-	tty_write_message(current->tty, dquot->dq_sb->s_id);
+	spin_unlock(&dquot_lock);
+	tty_write_message(current->tty, dq_sid);
 	if (warntype == ISOFTWARN || warntype == BSOFTWARN)
 		tty_write_message(current->tty, ": warning, ");
 	else
 		tty_write_message(current->tty, ": write failed, ");
-	tty_write_message(current->tty, quotatypes[dquot->dq_type]);
+	tty_write_message(current->tty, dq_type);
 	switch (warntype) {
 		case IHARDWARN:
 			msg = " file limit reached.\n";
@@ -742,6 +775,7 @@
 			break;
 	}
 	tty_write_message(current->tty, msg);
+	spin_lock(&dquot_lock);
 }
 
 static inline void flush_warnings(struct dquot **dquots, char *warntype)
@@ -901,8 +935,10 @@
 	memcpy(&data, &dquot->dq_dqb, sizeof(struct dqblk));        /* We copy data to preserve them from changing */
 	dqput(dquot);
 	error = -EFAULT;
+	spin_unlock(&dquot_lock);
 	if (dqblk && !copy_to_user(dqblk, &data, sizeof(struct dqblk)))
 		error = 0;
+	spin_lock(&dquot_lock);
 out:
 	return error;
 }
@@ -917,8 +953,10 @@
 
 	/* make a copy, in case we page-fault in user space */
 	memcpy(&stats, &dqstats, sizeof(struct dqstats));
+	spin_unlock(&dquot_lock);
 	if (!copy_to_user(addr, &stats, sizeof(struct dqstats)))
 		error = 0;
+	spin_lock(&dquot_lock);
 	return error;
 }
 
@@ -930,10 +968,13 @@
 		return(-ENODEV);
 
 	error = -EFAULT;
+	spin_unlock(&dquot_lock);
 	if (!copy_from_user(&new_value, addr, sizeof(int))) {
+		spin_lock(&dquot_lock);
 		sb_dqopt(sb)->rsquash[type] = new_value;
 		error = 0;
-	}
+	} else 
+		spin_lock(&dquot_lock);
 	return error;
 }
 
@@ -1039,7 +1080,6 @@
 	struct dquot *dquot[MAXQUOTAS];
 	char warntype[MAXQUOTAS];
 
-	lock_kernel();
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		dquot[cnt] = NODQUOT;
 		warntype[cnt] = NOWARN;
@@ -1057,7 +1097,9 @@
 			continue;
 		dquot_incr_blocks(dquot[cnt], number);
 	}
+	lock_kernel();
 	inode->i_blocks += number << (BLOCK_SIZE_BITS - 9);
+	unlock_kernel();
 	/* NOBLOCK End */
 	ret = QUOTA_OK;
 warn_put_all:
@@ -1065,7 +1107,6 @@
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
 		if (dquot[cnt] != NODQUOT)
 			dqput(dquot[cnt]);
-	unlock_kernel();
 	return ret;
 }
 
@@ -1083,7 +1124,6 @@
 		warntype[cnt] = NOWARN;
 	}
 	/* NOBLOCK Start */
-	lock_kernel();
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		dquot[cnt] = dqduplicate(inode -> i_dquot[cnt]);
 		if (dquot[cnt] == NODQUOT)
@@ -1104,7 +1144,6 @@
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
 		if (dquot[cnt] != NODQUOT)
 			dqput(dquot[cnt]);
-	unlock_kernel();
 	return ret;
 }
 
@@ -1117,7 +1156,6 @@
 	struct dquot *dquot;
 
 	/* NOBLOCK Start */
-	lock_kernel();
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		dquot = dqduplicate(inode->i_dquot[cnt]);
 		if (dquot == NODQUOT)
@@ -1125,6 +1163,7 @@
 		dquot_decr_blocks(dquot, number);
 		dqput(dquot);
 	}
+	lock_kernel();
 	inode->i_blocks -= number << (BLOCK_SIZE_BITS - 9);
 	unlock_kernel();
 	/* NOBLOCK End */
@@ -1139,7 +1178,6 @@
 	struct dquot *dquot;
 
 	/* NOBLOCK Start */
-	lock_kernel();
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		dquot = dqduplicate(inode->i_dquot[cnt]);
 		if (dquot == NODQUOT)
@@ -1147,7 +1185,6 @@
 		dquot_decr_inodes(dquot, number);
 		dqput(dquot);
 	}
-	unlock_kernel();
 	/* NOBLOCK End */
 }
 
@@ -1188,7 +1225,9 @@
 		}
 	}
 	/* NOBLOCK START: From now on we shouldn't block */
+	lock_kernel();
 	blocks = (inode->i_blocks >> 1);
+	unlock_kernel();
 	/* Build the transfer_from list and check the limits */
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		/* The second test can fail when quotaoff is in progress... */
@@ -1244,8 +1283,10 @@
 {
 	int i;
 
+	spin_lock(&dquot_lock);
 	for (i = 0; i < NR_DQHASH; i++)
 		INIT_LIST_HEAD(dquot_hash + i);
+	spin_unlock(&dquot_lock);
 	printk(KERN_NOTICE "VFS: Diskquotas version %s initialized\n", __DQUOT_VERSION__);
 	return 0;
 }
@@ -1300,12 +1341,13 @@
 	short cnt;
 	struct quota_mount_options *dqopt = sb_dqopt(sb);
 
-	lock_kernel();
 	if (!sb)
 		goto out;
 
+	spin_unlock(&dquot_lock);
 	/* We need to serialize quota_off() for device */
 	down(&dqopt->dqoff_sem);
+	spin_lock(&dquot_lock);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		if (type != -1 && cnt != type)
 			continue;
@@ -1313,19 +1355,22 @@
 			continue;
 		reset_enable_flags(dqopt, cnt);
 
+		spin_unlock(&dquot_lock);
 		/* Note: these are blocking operations */
 		remove_dquot_ref(sb, cnt);
+		spin_lock(&dquot_lock);
 		invalidate_dquots(sb, cnt);
 
 		filp = dqopt->files[cnt];
 		dqopt->files[cnt] = (struct file *)NULL;
 		dqopt->inode_expire[cnt] = 0;
 		dqopt->block_expire[cnt] = 0;
+		spin_unlock(&dquot_lock);
 		fput(filp);
 	}	
 	up(&dqopt->dqoff_sem);
 out:
-	unlock_kernel();
+	spin_lock(&dquot_lock);
 	return 0;
 }
 
@@ -1349,6 +1394,7 @@
 	if (is_enabled(dqopt, type))
 		return -EBUSY;
 
+	spin_unlock(&dquot_lock);
 	down(&dqopt->dqoff_sem);
 	tmp = getname(path);
 	error = PTR_ERR(tmp);
@@ -1372,6 +1418,7 @@
 	if (inode->i_size == 0 || !check_quotafile_size(inode->i_size))
 		goto out_f;
 	/* We don't want quota on quota files */
+	spin_lock(&dquot_lock);
 	dquot_drop(inode);
 	inode->i_flags |= S_NOQUOTA;
 
@@ -1386,14 +1433,16 @@
 
 	add_dquot_ref(sb, type);
 
+	spin_unlock(&dquot_lock);
 	up(&dqopt->dqoff_sem);
+	spin_lock(&dquot_lock);
 	return 0;
 
 out_f:
 	filp_close(f, NULL);
 out_lock:
 	up(&dqopt->dqoff_sem);
-
+	spin_lock(&dquot_lock);
 	return error; 
 }
 
@@ -1410,7 +1459,6 @@
 	struct super_block *sb = NULL;
 	int ret = -EINVAL;
 
-	lock_kernel();
 	cmds = cmd >> SUBCMDSHIFT;
 	type = cmd & SUBCMDMASK;
 
@@ -1459,6 +1507,7 @@
 	}
 
 	ret = -EINVAL;
+	spin_lock(&dquot_lock);
 	switch (cmds) {
 		case Q_QUOTAON:
 			ret = quota_on(sb, type, (char *) addr);
@@ -1494,9 +1543,9 @@
 	ret = -ENODEV;
 	if (sb && sb_has_quota_enabled(sb, type))
 		ret = set_dqblk(sb, id, type, flags, (struct dqblk *) addr);
+	spin_unlock(&dquot_lock);
 out:
 	if (sb)
 		drop_super(sb);
-	unlock_kernel();
 	return ret;
 }
===== fs/inode.c 1.37 vs edited =====
--- 1.37/fs/inode.c	Mon Feb 11 14:26:32 2002
+++ edited/fs/inode.c	Mon Feb 25 19:51:57 2002
@@ -1213,6 +1213,7 @@
 /* Functions back in dquot.c */
 void put_dquot_list(struct list_head *);
 int remove_inode_dquot_ref(struct inode *, short, struct list_head *);
+extern spinlock_t dquot_lock;
 
 void remove_dquot_ref(struct super_block *sb, short type)
 {
@@ -1225,6 +1226,7 @@
 	/* We have to be protected against other CPUs */
 	lock_kernel();		/* This lock is for quota code */
 	spin_lock(&inode_lock);	/* This lock is for inodes code */
+	spin_lock(&dquot_lock);
  
 	list_for_each(act_head, &inode_in_use) {
 		inode = list_entry(act_head, struct inode, i_list);
@@ -1246,6 +1248,7 @@
 		if (IS_QUOTAINIT(inode))
 			remove_inode_dquot_ref(inode, type, &tofree_head);
 	}
+	spin_unlock(&dquot_lock);
 	spin_unlock(&inode_lock);
 	unlock_kernel();
 
===== include/linux/quotaops.h 1.7 vs edited =====
--- 1.7/include/linux/quotaops.h	Fri Feb  8 22:10:55 2002
+++ edited/include/linux/quotaops.h	Mon Feb 25 20:04:35 2002
@@ -33,6 +33,7 @@
 
 extern int  dquot_transfer(struct inode *inode, struct iattr *iattr);
 
+extern spinlock_t dquot_lock;
 /*
  * Operations supported for diskquotas.
  */
@@ -42,36 +43,39 @@
 {
 	if (!inode->i_sb)
 		BUG();
-	lock_kernel();
+	spin_lock(&dquot_lock);
 	if (sb_any_quota_enabled(inode->i_sb) && !IS_NOQUOTA(inode))
 		inode->i_sb->dq_op->initialize(inode, -1);
-	unlock_kernel();
+	spin_unlock(&dquot_lock);
 }
 
 static __inline__ void DQUOT_DROP(struct inode *inode)
 {
-	lock_kernel();
+	spin_lock(&dquot_lock);
 	if (IS_QUOTAINIT(inode)) {
 		if (!inode->i_sb)
 			BUG();
 		inode->i_sb->dq_op->drop(inode);	/* Ops must be set when there's any quota... */
 	}
-	unlock_kernel();
+	spin_unlock(&dquot_lock);
 }
 
 static __inline__ int DQUOT_PREALLOC_BLOCK_NODIRTY(struct inode *inode, int nr)
 {
-	lock_kernel();
+	spin_lock(&dquot_lock);
 	if (sb_any_quota_enabled(inode->i_sb)) {
 		/* Number of used blocks is updated in alloc_block() */
 		if (inode->i_sb->dq_op->alloc_block(inode, fs_to_dq_blocks(nr, inode->i_sb->s_blocksize), 1) == NO_QUOTA) {
-			unlock_kernel();
+			spin_unlock(&dquot_lock);
 			return 1;
 		}
 	}
-	else
+	else {
+		lock_kernel();
 		inode->i_blocks += nr << (inode->i_sb->s_blocksize_bits - 9);
-	unlock_kernel();
+		unlock_kernel();
+	}
+	spin_unlock(&dquot_lock);
 	return 0;
 }
 
@@ -85,17 +89,20 @@
 
 static __inline__ int DQUOT_ALLOC_BLOCK_NODIRTY(struct inode *inode, int nr)
 {
-	lock_kernel();
+	spin_lock(&dquot_lock);
 	if (sb_any_quota_enabled(inode->i_sb)) {
 		/* Number of used blocks is updated in alloc_block() */
 		if (inode->i_sb->dq_op->alloc_block(inode, fs_to_dq_blocks(nr, inode->i_sb->s_blocksize), 0) == NO_QUOTA) {
-			unlock_kernel();
+			spin_unlock(&dquot_lock);
 			return 1;
 		}
 	}
-	else
+	else {
+		lock_kernel();
 		inode->i_blocks += nr << (inode->i_sb->s_blocksize_bits - 9);
-	unlock_kernel();
+		unlock_kernel();
+	}
+	spin_unlock(&dquot_lock);
 	return 0;
 }
 
@@ -109,26 +116,31 @@
 
 static __inline__ int DQUOT_ALLOC_INODE(struct inode *inode)
 {
-	lock_kernel();
+	spin_lock(&dquot_lock);
 	if (sb_any_quota_enabled(inode->i_sb)) {
+		spin_unlock(&dquot_lock);
 		DQUOT_INIT(inode);
+		spin_lock(&dquot_lock);
 		if (inode->i_sb->dq_op->alloc_inode(inode, 1) == NO_QUOTA) {
-			unlock_kernel();
+			spin_unlock(&dquot_lock);
 			return 1;
 		}
 	}
-	unlock_kernel();
+	spin_unlock(&dquot_lock);
 	return 0;
 }
 
 static __inline__ void DQUOT_FREE_BLOCK_NODIRTY(struct inode *inode, int nr)
 {
-	lock_kernel();
+	spin_lock(&dquot_lock);
 	if (sb_any_quota_enabled(inode->i_sb))
 		inode->i_sb->dq_op->free_block(inode, fs_to_dq_blocks(nr, inode->i_sb->s_blocksize));
-	else
+	else {
+		lock_kernel();
 		inode->i_blocks -= nr << (inode->i_sb->s_blocksize_bits - 9);
-	unlock_kernel();
+		unlock_kernel();
+	}
+	spin_unlock(&dquot_lock);
 }
 
 static __inline__ void DQUOT_FREE_BLOCK(struct inode *inode, int nr)
@@ -139,23 +151,23 @@
 
 static __inline__ void DQUOT_FREE_INODE(struct inode *inode)
 {
-	lock_kernel();
+	spin_lock(&dquot_lock);
 	if (sb_any_quota_enabled(inode->i_sb))
 		inode->i_sb->dq_op->free_inode(inode, 1);
-	unlock_kernel();
+	spin_unlock(&dquot_lock);
 }
 
 static __inline__ int DQUOT_TRANSFER(struct inode *inode, struct iattr *iattr)
 {
-	lock_kernel();
+	spin_lock(&dquot_lock);
 	if (sb_any_quota_enabled(inode->i_sb) && !IS_NOQUOTA(inode)) {
 		DQUOT_INIT(inode);
 		if (inode->i_sb->dq_op->transfer(inode, iattr) == NO_QUOTA) {
-			unlock_kernel();
+			spin_unlock(&dquot_lock);
 			return 1;
 		}
 	}
-	unlock_kernel();
+	spin_unlock(&dquot_lock);
 	return 0;
 }
 

--------------Boundary-00=_V094AB25YE0CK55VG3KR--
