Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280029AbRKVQzW>; Thu, 22 Nov 2001 11:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280043AbRKVQzN>; Thu, 22 Nov 2001 11:55:13 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:16395 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S280042AbRKVQzC>; Thu, 22 Nov 2001 11:55:02 -0500
Date: Thu, 22 Nov 2001 17:54:57 +0100
From: Jan Kara <jack@suse.cz>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Quota SMP race fix
Message-ID: <20011122175456.A13397@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

  I'm sending you a patch which should fix an SMP quota race (it also contains
minor removal of dead code). Patch is against 2.4.15-pre7. Please apply.

								Honza

diff -ruX /home/jack/.kerndiffexclude linux-2.4.15-pre7/fs/dquot.c linux-2.4.15-pre7-locksfix/fs/dquot.c
--- linux-2.4.15-pre7/fs/dquot.c	Wed Nov 21 21:24:36 2001
+++ linux-2.4.15-pre7-locksfix/fs/dquot.c	Wed Nov 21 21:50:09 2001
@@ -189,11 +189,8 @@
 
 static inline void remove_free_dquot(struct dquot *dquot)
 {
-	/* sanity check */
-	if (list_empty(&dquot->dq_free)) {
-		printk("remove_free_dquot: dquot not on the free list??\n");
-		return;		/* J.K. Just don't do anything */
-	}
+	if (list_empty(&dquot->dq_free))
+		return;
 	list_del(&dquot->dq_free);
 	INIT_LIST_HEAD(&dquot->dq_free);
 	nr_free_dquots--;
@@ -330,24 +327,6 @@
 	unlock_dquot(dquot);
 }
 
-/*
- * Unhash and selectively clear the dquot structure,
- * but preserve the use count, list pointers, and
- * wait queue.
- */
-void clear_dquot(struct dquot *dquot)
-{
-	/* unhash it first */
-	remove_dquot_hash(dquot);
-	dquot->dq_sb = NULL;
-	dquot->dq_id = 0;
-	dquot->dq_dev = NODEV;
-	dquot->dq_type = -1;
-	dquot->dq_flags = 0;
-	dquot->dq_referenced = 0;
-	memset(&dquot->dq_dqb, 0, sizeof(struct dqblk));
-}
-
 /* Invalidate all dquots on the list, wait for all users. Note that this function is called
  * after quota is disabled so no new quota might be created. As we only insert to the end of
  * inuse list, we don't have to restart searching... */
@@ -363,6 +342,7 @@
 			continue;
 		if (dquot->dq_type != type)
 			continue;
+		dquot->dq_flags |= DQ_INVAL;
 		if (dquot->dq_count)
 			/*
 			 *  Wait for any users of quota. As we have already cleared the flags in
@@ -384,6 +364,7 @@
 	struct list_head *head;
 	struct dquot *dquot;
 
+	lock_kernel();
 restart:
 	for (head = inuse_list.next; head != &inuse_list; head = head->next) {
 		dquot = list_entry(head, struct dquot, dq_inuse);
@@ -405,6 +386,7 @@
 		goto restart;
 	}
 	dqstats.syncs++;
+	unlock_kernel();
 	return 0;
 }
 
@@ -428,7 +410,9 @@
 
 int shrink_dqcache_memory(int priority, unsigned int gfp_mask)
 {
+	lock_kernel();
 	prune_dqcache(nr_free_dquots / (priority + 1));
+	unlock_kernel();
 	kmem_cache_shrink(dquot_cachep);
 	return 0;
 }
@@ -465,12 +449,13 @@
 		return;
 	}
 	dquot->dq_count--;
-	/* Place at end of LRU free queue */
-	put_dquot_last(dquot);
+	/* If dquot is going to be invalidated invalidate_dquots() is going to free it so */
+	if (!(dquot->dq_flags & DQ_INVAL))
+		put_dquot_last(dquot);	/* Place at end of LRU free queue */
 	wake_up(&dquot->dq_wait_free);
 }
 
-struct dquot *get_empty_dquot(void)
+static struct dquot *get_empty_dquot(void)
 {
 	struct dquot *dquot;
 
@@ -633,9 +618,11 @@
 /* Free list of dquots - called from inode.c */
 void put_dquot_list(struct list_head *tofree_head)
 {
-	struct list_head *act_head = tofree_head->next;
+	struct list_head *act_head;
 	struct dquot *dquot;
 
+	lock_kernel();
+	act_head = tofree_head->next;
 	/* So now we have dquots on the list... Just free them */
 	while (act_head != tofree_head) {
 		dquot = list_entry(act_head, struct dquot, dq_free);
@@ -644,6 +631,7 @@
 		INIT_LIST_HEAD(&dquot->dq_free);
 		dqput(dquot);
 	}
+	unlock_kernel();
 }
 
 static inline void dquot_incr_inodes(struct dquot *dquot, unsigned long number)
@@ -1289,6 +1277,7 @@
 	short cnt;
 	struct quota_mount_options *dqopt = sb_dqopt(sb);
 
+	lock_kernel();
 	if (!sb)
 		goto out;
 
@@ -1313,6 +1302,7 @@
 	}	
 	up(&dqopt->dqoff_sem);
 out:
+	unlock_kernel();
 	return 0;
 }
 
diff -ruX /home/jack/.kerndiffexclude linux-2.4.15-pre7/fs/inode.c linux-2.4.15-pre7-locksfix/fs/inode.c
--- linux-2.4.15-pre7/fs/inode.c	Wed Nov 21 21:36:18 2001
+++ linux-2.4.15-pre7-locksfix/fs/inode.c	Wed Nov 21 21:50:09 2001
@@ -1210,9 +1210,9 @@
 
 	if (!sb->dq_op)
 		return;	/* nothing to do */
-
 	/* We have to be protected against other CPUs */
-	spin_lock(&inode_lock);
+	lock_kernel();		/* This lock is for quota code */
+	spin_lock(&inode_lock);	/* This lock is for inodes code */
  
 	list_for_each(act_head, &inode_in_use) {
 		inode = list_entry(act_head, struct inode, i_list);
@@ -1235,6 +1235,7 @@
 			remove_inode_dquot_ref(inode, type, &tofree_head);
 	}
 	spin_unlock(&inode_lock);
+	unlock_kernel();
 
 	put_dquot_list(&tofree_head);
 }
diff -ruX /home/jack/.kerndiffexclude linux-2.4.15-pre7/include/linux/quota.h linux-2.4.15-pre7-locksfix/include/linux/quota.h
--- linux-2.4.15-pre7/include/linux/quota.h	Wed Oct 31 23:46:55 2001
+++ linux-2.4.15-pre7-locksfix/include/linux/quota.h	Wed Nov 21 21:50:09 2001
@@ -154,6 +154,7 @@
 #define DQ_BLKS       0x10	/* uid/gid has been warned about blk limit */
 #define DQ_INODES     0x20	/* uid/gid has been warned about inode limit */
 #define DQ_FAKE       0x40	/* no limits only usage */
+#define DQ_INVAL      0x80	/* dquot is going to be invalidated */
 
 struct dquot {
 	struct list_head dq_hash;	/* Hash list in memory */
