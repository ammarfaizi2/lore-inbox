Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274100AbRIXRv0>; Mon, 24 Sep 2001 13:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274096AbRIXRvJ>; Mon, 24 Sep 2001 13:51:09 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:53765 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S274095AbRIXRuz>; Mon, 24 Sep 2001 13:50:55 -0400
Date: Mon, 24 Sep 2001 19:51:11 +0200
From: Jan Kara <jack@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Quota usecount
Message-ID: <20010924195111.A4275@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

  I'm sending you a patch which changes a bit handling of usecounts
in quota code. As a result no filesystem io can be called from
DQUOT_ALLOC/FREE_INODE/BLOCK/SPACE() and so it simplifies a few
things for some filesystems. I already sent you this patch but
it didn't seem to get into your kernel... Please apply.
  The patch is against -ac11 but should apply well also on older
kernels.

							Honza

--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quotalocks.diff"

diff -ru -X /home/jack/.kerndiffexclude linux-2.4.9-ac11/fs/dquot.c linux-2.4.9-ac11-locks/fs/dquot.c
--- linux-2.4.9-ac11/fs/dquot.c	Thu Sep 20 11:28:15 2001
+++ linux-2.4.9-ac11-locks/fs/dquot.c	Sun Sep 23 13:38:02 2001
@@ -35,7 +35,7 @@
  *		Jan Kara, <jack@suse.cz>, sponsored by SuSE CR, 10-11/99
  *
  *		Used struct list_head instead of own list struct
- *		Invalidation of dquots with dq_count > 0 no longer possible
+ *		Invalidation of referenced dquots is no longer possible
  *		Improved free_dquots list management
  *		Quota and i_blocks are now updated in one place to avoid races
  *		Warnings are now delayed so we won't block in critical section
@@ -145,6 +145,26 @@
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
+static inline void get_dquot_dup_ref(struct dquot *dquot)
+{
+	dquot->dq_dup_ref++;
+}
+
+static inline void put_dquot_dup_ref(struct dquot *dquot)
+{
+	dquot->dq_dup_ref--;
+}
+
 static inline int const hashfn(kdev_t dev, unsigned int id, short type)
 {
 	return((HASHDEV(dev) ^ id) * (MAXQUOTAS - type)) % NR_DQHASH;
@@ -198,12 +218,6 @@
 
 static inline void remove_free_dquot(struct dquot *dquot)
 {
-#ifdef __DQUOT_PARANOIA
-	if (list_empty(&dquot->dq_free)) {
-		printk("remove_free_dquot: dquot not on the free list??\n");
-		return;		/* J.K. Just don't do anything */
-	}
-#endif
 	list_del(&dquot->dq_free);
 	INIT_LIST_HEAD(&dquot->dq_free);
 	nr_free_dquots--;
@@ -256,6 +270,7 @@
 	wake_up(&dquot->dq_wait_lock);
 }
 
+/* Wait for dquot to be unused */
 static void __wait_dquot_unused(struct dquot *dquot)
 {
 	DECLARE_WAITQUEUE(wait, current);
@@ -271,6 +286,22 @@
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
  *	IO operations on file
  */
@@ -940,6 +971,7 @@
 			continue;
 		if (dquot->dq_type != type)
 			continue;
+		dquot->dq_flags |= DQ_INVAL;
 		if (dquot->dq_count)
 			/*
 			 *  Wait for any users of quota. As we have already cleared the flags in
@@ -972,8 +1004,10 @@
 			continue;
 		if (!(dquot->dq_flags & (DQ_MOD | DQ_LOCKED)))
 			continue;
-		/* Raise use count so quota won't be invalidated. We can't use dqduplicate() as it does too many tests */
-		dquot->dq_count++;
+		/* Get reference to quota so it won't be invalidated. get_dquot_ref()
+		 * is enough since if dquot is locked/modified it can't be
+		 * on the free list */
+		get_dquot_ref(dquot);
 		if (dquot->dq_flags & DQ_LOCKED)
 			wait_on_dquot(dquot);
 		if (dquot->dq_flags & DQ_MOD)
@@ -1009,11 +1043,15 @@
 	kmem_cache_shrink(dquot_cachep);
 }
 
-/* NOTE: If you change this function please check whether dqput_blocks() works right... */
+/*
+ * Put reference to dquot
+ * NOTE: If you change this function please check whether dqput_blocks() works right...
+ */
 static void dqput(struct dquot *dquot)
 {
 	if (!dquot)
 		return;
+#ifdef __DQUOT_PARANOIA
 	if (!dquot->dq_count) {
 		printk("VFS: dqput: trying to free free dquot\n");
 		printk("VFS: device %s, dquot of %s %d\n",
@@ -1021,12 +1059,17 @@
 			dquot->dq_id);
 		return;
 	}
+#endif
 
 	dqstats.drops++;
 we_slept:
+	if (dquot->dq_dup_ref && dquot->dq_count - dquot->dq_dup_ref <= 1) {	/* Last unduplicated reference? */
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
@@ -1037,13 +1080,15 @@
 #ifdef __DQUOT_PARANOIA
 	if (!list_empty(&dquot->dq_free)) {
 		printk(KERN_ERR "dqput: dquot already on free list??\n");
-		dquot->dq_count--;	/* J.K. Just decrementing use count seems safer... */
+		put_dquot_ref(dquot);
 		return;
 	}
 #endif
-	dquot->dq_count--;
-	/* Place at end of LRU free queue */
-	put_dquot_last(dquot);
+	put_dquot_ref(dquot);
+	/* Don't put dquot on free list if it will be invalidated (to avoid races between invalidate_dquots() and prune_dqcache()) */
+	if (!(dquot->dq_flags & DQ_INVAL))
+		/* Place at end of LRU free queue */
+		put_dquot_last(dquot);
 	wake_up(&dquot->dq_wait_free);
 }
 
@@ -1096,8 +1141,9 @@
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
@@ -1117,25 +1163,42 @@
 	return dquot;
 }
 
+/* Duplicate reference to dquot got from inode */
 static struct dquot *dqduplicate(struct dquot *dquot)
 {
 	if (dquot == NODQUOT)
 		return NODQUOT;
-	dquot->dq_count++;
+	get_dquot_ref(dquot);
 #ifdef __DQUOT_PARANOIA
 	if (!dquot->dq_sb) {
 		printk(KERN_ERR "VFS: dqduplicate(): Invalidated quota to be duplicated!\n");
-		dquot->dq_count--;
+		put_dquot_ref(dquot);
 		return NODQUOT;
 	}
 	if (dquot->dq_flags & DQ_LOCKED)
 		printk(KERN_ERR "VFS: dqduplicate(): Locked quota to be duplicated!\n");
 #endif
+	get_dquot_dup_ref(dquot);
 	dquot->dq_referenced++;
 	dqstats.lookups++;
 	return dquot;
 }
 
+/* Put duplicated reference */
+static void dqputduplicate(struct dquot *dquot)
+{
+#ifdef __DQUOT_PARANOIA
+	if (!dquot->dq_dup_ref) {
+		printk(KERN_ERR "VFS: dqputduplicate(): Duplicated dquot put without duplicate reference.\n");
+		return;
+	}
+#endif
+	put_dquot_dup_ref(dquot);
+	if (!dquot->dq_dup_ref)
+		wake_up(&dquot->dq_wait_free);
+	put_dquot_ref(dquot);
+	dqstats.drops++;
+}
 
 static int dqinit_needed(struct inode *inode, short type)
 {
@@ -1181,7 +1244,7 @@
 /* Return 0 if dqput() won't block (note that 1 doesn't necessarily mean blocking) */
 static inline int dqput_blocks(struct dquot *dquot)
 {
-	if (dquot->dq_count == 1)
+	if (dquot->dq_dup_ref && dquot->dq_count - dquot->dq_dup_ref <= 1)
 		return 1;
 	return 0;
 }
@@ -1647,7 +1710,7 @@
 	flush_warnings(dquot, warntype);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
 		if (dquot[cnt] != NODQUOT)
-			dqput(dquot[cnt]);
+			dqputduplicate(dquot[cnt]);
 	return ret;
 }
 
@@ -1684,7 +1747,7 @@
 	flush_warnings(dquot, warntype);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
 		if (dquot[cnt] != NODQUOT)
-			dqput(dquot[cnt]);
+			dqputduplicate(dquot[cnt]);
 	return ret;
 }
 
@@ -1702,7 +1765,7 @@
 		if (dquot == NODQUOT)
 			continue;
 		dquot_decr_space(dquot, number);
-		dqput(dquot);
+		dqputduplicate(dquot);
 	}
 	inode_sub_bytes(inode, number);
 	/* NOBLOCK End */
@@ -1722,7 +1785,7 @@
 		if (dquot == NODQUOT)
 			continue;
 		dquot_decr_inodes(dquot, number);
-		dqput(dquot);
+		dqputduplicate(dquot);
 	}
 	/* NOBLOCK End */
 }
@@ -1809,7 +1872,7 @@
 	flush_warnings(transfer_to, warntype);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		if (transfer_to[cnt] != NODQUOT)
-			dqput(transfer_to[cnt]);
+			dqputduplicate(transfer_to[cnt]);
 		if (transfer_from[cnt] != NODQUOT)
 			dqput(transfer_from[cnt]);
 	}
diff -ru -X /home/jack/.kerndiffexclude linux-2.4.9-ac11/include/linux/quota.h linux-2.4.9-ac11-locks/include/linux/quota.h
--- linux-2.4.9-ac11/include/linux/quota.h	Thu Sep 20 11:28:29 2001
+++ linux-2.4.9-ac11-locks/include/linux/quota.h	Sun Sep 23 13:32:34 2001
@@ -220,6 +220,7 @@
 #define DQ_BLKS       0x10	/* uid/gid has been warned about blk limit */
 #define DQ_INODES     0x20	/* uid/gid has been warned about inode limit */
 #define DQ_FAKE       0x40	/* no limits only usage */
+#define DQ_INVAL      0x80	/* dquot is going to be invalidated */
 
 struct dquot {
 	struct list_head dq_hash;	/* Hash list in memory */
@@ -227,7 +228,8 @@
 	struct list_head dq_free;	/* Free list element */
 	wait_queue_head_t dq_wait_lock;	/* Pointer to waitqueue on dquot lock */
 	wait_queue_head_t dq_wait_free;	/* Pointer to waitqueue for quota to be unused */
-	int dq_count;			/* Reference count */
+	int dq_count;			/* Use count */
+	int dq_dup_ref;			/* Number of duplicated refences */
 
 	/* fields after this point are cleared when invalidating */
 	struct super_block *dq_sb;	/* superblock this applies to */

--7JfCtLOvnd9MIVvH--
