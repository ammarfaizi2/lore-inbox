Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293544AbSCCJ44>; Sun, 3 Mar 2002 04:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293540AbSCCJ4r>; Sun, 3 Mar 2002 04:56:47 -0500
Received: from relay02.valueweb.net ([216.219.253.236]:63759 "EHLO
	relay02.valueweb.net") by vger.kernel.org with ESMTP
	id <S293539AbSCCJ4d>; Sun, 3 Mar 2002 04:56:33 -0500
Content-Type: text/plain; charset=US-ASCII
From: Craig Christophel <merlin@transgeek.com>
To: linux-kernel@vger.kernel.org
Subject: Quota patches for 2.5 - 1
Date: Sun, 3 Mar 2002 04:56:49 -0500
X-Mailer: KMail [version 1.3.1]
Cc: jack@suse.cz, Alexander Viro <viro@math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020303095610Z293039-31625+6@thor.valueweb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the first of 13 patches.

	This patch adds accounting for duplicated dquots instead of having 
dquot->dq_count doing all of the accounting.  It also adds the associated 
functions needed to manage this change.



diff -urN -X txt/diff-exclude linux-2.5-linus/fs/dquot.c linux-2.5/fs/dquot.c
--- linux-2.5-linus/fs/dquot.c	Sat Mar  2 16:40:20 2002
+++ linux-2.5/fs/dquot.c	Sat Mar  2 18:44:32 2002
@@ -35,7 +35,7 @@
  *		Jan Kara, <jack@suse.cz>, sponsored by SuSE CR, 10-11/99
  *
  *		Used struct list_head instead of own list struct
- *		Invalidation of dquots with dq_count > 0 no longer possible
+ *		Invalidation of referenced dquots is no longer possible
  *		Improved free_dquots list management
  *		Quota and i_blocks are now updated in one place to avoid races
  *		Warnings are now delayed so we won't block in critical section
@@ -136,6 +136,26 @@
 	return is_enabled(sb_dqopt(sb), type);
 }
 
+static inline void get_dquot_ref(struct dquot *dquot)
+{
+	dquot->dq_count++;
+}
+
+static inline void put_dquot_ref(struct dquot *dquot)
+{
+	dquot->dq_count--;
+}
+
+static inline void get_dquot_dup_ref(struct *dquot)
+{
+	dquot->dq_dup_ref++;
+}
+
+static inline void put_dquot_dup_ref(struct *dquot)
+{
+	dquot->dq_dup_ref--;
+}
+
 static inline int const hashfn(struct super_block *sb, unsigned int id, 
short type)
 {
 	return((HASHDEV(sb->s_dev) ^ id) * (MAXQUOTAS - type)) % NR_DQHASH;
@@ -243,6 +263,7 @@
 	wake_up(&dquot->dq_wait_lock);
 }
 
+/* Wait for dquot to be unused */
 static void __wait_dquot_unused(struct dquot *dquot)
 {
 	DECLARE_WAITQUEUE(wait, current);
@@ -258,6 +279,22 @@
 	current->state = TASK_RUNNING;
 }
 
+/* Wait for all duplicated dquot references to be dropped */
+static void __wait_dup_drop(struct dquot *dquot)
+{
+	DECLARE_WAITQUEUE(wait, current);
+
+	add_wait_queue(&dquot->dq_wait_free, &wait);
+repeat:
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	if (dquot->dq_dup_ref) {
+		schedule();
+		goto repeat;
+	}
+	remove_wait_queue(&dquot->dq_wait_free, &wait);
+	current->state = TASK_RUNNING;
+}
+
 /*
  *	We don't have to be afraid of deadlocks as we never have quotas on quota 
files...
  */
@@ -376,8 +413,10 @@
 			continue;
 		if (!(dquot->dq_flags & (DQ_MOD | DQ_LOCKED)))
 			continue;
-		/* Raise use count so quota won't be invalidated. We can't use 
dqduplicate() as it does too many tests */
-		dquot->dq_count++;
+		/* Get reference to quota so it won't be invalidated. get_dquot_ref()
+		 * is enough since if dquot is locked/modified it can't be
+		 * on the free list */
+		get_dquot_ref(dquot);
 		if (dquot->dq_flags & DQ_LOCKED)
 			wait_on_dquot(dquot);
 		if (dquot->dq_flags & DQ_MOD)
@@ -432,11 +471,15 @@
 	return 0;
 }
 
-/* NOTE: If you change this function please check whether dqput_blocks() 
works right... */
+/*
+ * Put reference to dquot
+ * NOTE: If you change this function please check whether dqput_blocks() 
works right...
+ */
 static void dqput(struct dquot *dquot)
 {
 	if (!dquot)
 		return;
+#ifdef __DQUOT_PARANOIA
 	if (!dquot->dq_count) {
 		printk("VFS: dqput: trying to free free dquot\n");
 		printk("VFS: device %s, dquot of %s %d\n",
@@ -445,12 +488,17 @@
 			dquot->dq_id);
 		return;
 	}
+#endif
 
 	dqstats.drops++;
 we_slept:
+	if (dquot->dq_dup_ref && dquot->dq_count - dquot->dq_dup_ref <= 1) {	/* 
Last unduplicated reference? */
+		__wait_dup_drop(dquot);
+		goto we_slept;
+	}
 	if (dquot->dq_count > 1) {
 		/* We have more than one user... We can simply decrement use count */
-		dquot->dq_count--;
+		put_dquot_ref(dquot);
 		return;
 	}
 	if (dquot->dq_flags & DQ_MOD) {
@@ -461,10 +509,10 @@
 	/* sanity check */
 	if (!list_empty(&dquot->dq_free)) {
 		printk(KERN_ERR "dqput: dquot already on free list??\n");
-		dquot->dq_count--;	/* J.K. Just decrementing use count seems safer... */
+		put_dquot_ref(dquot);
 		return;
 	}
-	dquot->dq_count--;
+	put_dquot_ref(dquot);
 	/* If dquot is going to be invalidated invalidate_dquots() is going to free 
it so */
 	if (!(dquot->dq_flags & DQ_INVAL))
 		put_dquot_last(dquot);	/* Place at end of LRU free queue */
@@ -519,8 +567,9 @@
 		insert_dquot_hash(dquot);
         	read_dquot(dquot);
 	} else {
-		if (!dquot->dq_count++)
+		if (!dquot->dq_count)
 			remove_free_dquot(dquot);
+		get_dquot_ref(dquot);
 		dqstats.cache_hits++;
 		wait_on_dquot(dquot);
 		if (empty)
@@ -538,23 +587,39 @@
 	return dquot;
 }
 
+/* Duplicate reference to dquot got from inode */
 static struct dquot *dqduplicate(struct dquot *dquot)
 {
 	if (dquot == NODQUOT)
 		return NODQUOT;
-	dquot->dq_count++;
+	get_dquot_ref(dquot);
 	if (!dquot->dq_sb) {
 		printk(KERN_ERR "VFS: dqduplicate(): Invalidated quota to be 
duplicated!\n");
-		dquot->dq_count--;
+		put_dquot_ref(dquot);
 		return NODQUOT;
 	}
 	if (dquot->dq_flags & DQ_LOCKED)
 		printk(KERN_ERR "VFS: dqduplicate(): Locked quota to be duplicated!\n");
+	get_dquot_dup_ref(dquot);
 	dquot->dq_referenced++;
 	dqstats.lookups++;
 	return dquot;
 }
 
+/* Put duplicated reference */
+static void dqputduplicate(struct dquot *dquot)
+{
+	if (!dquot->dq_dup_ref) {
+		printk(KERN_ERR "VFS: dqputduplicate(): Duplicated dquot put without 
duplicate reference.\n");
+		return;
+	}
+	put_dquot_dup_ref(dquot);
+	if (!dquot->dq_dup_ref)
+		wake_up(&dquot->dq_wait_free);
+	put_dquot_ref(dquot);
+	dqstats.drops++;
+}
+
 static int dqinit_needed(struct inode *inode, short type)
 {
 	int cnt;
@@ -598,7 +663,9 @@
 /* Return 0 if dqput() won't block (note that 1 doesn't necessarily mean 
blocking) */
 static inline int dqput_blocks(struct dquot *dquot)
 {
-	if (dquot->dq_count == 1)
+	if (dquot->dq_dup_ref && dquot->dq_count - dquot->dq_dup_ref <= 1)
+		return 1;
+	if (dquot->dq_count <= 1 && dquot->dq_flags & DQ_MOD)
 		return 1;
 	return 0;
 }
@@ -1064,7 +1131,7 @@
 	flush_warnings(dquot, warntype);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
 		if (dquot[cnt] != NODQUOT)
-			dqput(dquot[cnt]);
+			dqputduplicate(dquot[cnt]);
 	unlock_kernel();
 	return ret;
 }
@@ -1103,7 +1170,7 @@
 	flush_warnings(dquot, warntype);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
 		if (dquot[cnt] != NODQUOT)
-			dqput(dquot[cnt]);
+			dqputduplicate(dquot[cnt]);
 	unlock_kernel();
 	return ret;
 }
@@ -1123,7 +1190,7 @@
 		if (dquot == NODQUOT)
 			continue;
 		dquot_decr_blocks(dquot, number);
-		dqput(dquot);
+		dqputduplicate(dquot);
 	}
 	inode->i_blocks -= number << (BLOCK_SIZE_BITS - 9);
 	unlock_kernel();
@@ -1145,7 +1212,7 @@
 		if (dquot == NODQUOT)
 			continue;
 		dquot_decr_inodes(dquot, number);
-		dqput(dquot);
+		dqputduplicate(dquot);
 	}
 	unlock_kernel();
 	/* NOBLOCK End */
@@ -1232,8 +1299,9 @@
 warn_put_all:
 	flush_warnings(transfer_to, warntype);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
+		/* First we must put duplicate - otherwise we might deadlock */
 		if (transfer_to[cnt] != NODQUOT)
-			dqput(transfer_to[cnt]);
+			dqputduplicate(transfer_to[cnt]);
 		if (transfer_from[cnt] != NODQUOT)
 			dqput(transfer_from[cnt]);
 	}
diff -urN -X txt/diff-exclude linux-2.5-linus/include/linux/quota.h 
linux-2.5/include/linux/quota.h
--- linux-2.5-linus/include/linux/quota.h	Sat Mar  2 16:40:41 2002
+++ linux-2.5/include/linux/quota.h	Sat Mar  2 18:39:11 2002
@@ -41,6 +41,9 @@
 
 #include <linux/errno.h>
 
+#define __DQUOT_VERSION__	"dquot_6.5.1"
+#define __DQUOT_NUM_VERSION__	6*10000+5*100+1
+
 /*
  * Convert diskblocks to blocks and the other way around.
  */
@@ -162,7 +165,8 @@
 	struct list_head dq_free;	/* Free list element */
 	wait_queue_head_t dq_wait_lock;	/* Pointer to waitqueue on dquot lock */
 	wait_queue_head_t dq_wait_free;	/* Pointer to waitqueue for quota to be 
unused */
-	int dq_count;			/* Reference count */
+	int dq_count;			/* Use count */
+	int dq_dup_ref;			/* Number of duplicated refences */
 
 	/* fields after this point are cleared when invalidating */
 	struct super_block *dq_sb;	/* superblock this applies to */
