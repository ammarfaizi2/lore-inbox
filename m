Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278959AbRKSOFH>; Mon, 19 Nov 2001 09:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279064AbRKSOEs>; Mon, 19 Nov 2001 09:04:48 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:18953 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S278959AbRKSOEn>; Mon, 19 Nov 2001 09:04:43 -0500
Date: Mon, 19 Nov 2001 15:04:02 +0100
From: Jan Kara <jack@suse.cz>
To: Marcus Grando <marcus@big.univali.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: remove_free_dquot: dquot not on the free list??
Message-ID: <20011119150402.B12808@atrey.karlin.mff.cuni.cz>
In-Reply-To: <5.1.0.14.1.20011119091745.00a99b90@mail.big.univali.br>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <5.1.0.14.1.20011119091745.00a99b90@mail.big.univali.br>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hi,

>         This problem occours in 2.4.15-pre5.
> 
>         Some ideas to solve this problem?
  Any info about system? I suppose it's multiprocessor system. Can
you please try attached patch? It adds a few forgotten lock_kernel()...
Once I get at least one possitive report that it fixes the things I'll
submit it to Linus :)

								Honza

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quota-fix-2.4.13-1.diff"

diff -ruX /home/jack/.kerndiffexclude linux-2.4.13/fs/dquot.c linux-2.4.13-locksfix/fs/dquot.c
--- linux-2.4.13/fs/dquot.c	Thu Oct 11 00:08:48 2001
+++ linux-2.4.13-locksfix/fs/dquot.c	Wed Oct 31 23:44:36 2001
@@ -330,24 +330,6 @@
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
@@ -363,6 +345,7 @@
 			continue;
 		if (dquot->dq_type != type)
 			continue;
+		dquot->dq_flags |= DQ_INVAL;
 		if (dquot->dq_count)
 			/*
 			 *  Wait for any users of quota. As we have already cleared the flags in
@@ -384,6 +367,7 @@
 	struct list_head *head;
 	struct dquot *dquot;
 
+	lock_kernel();
 restart:
 	for (head = inuse_list.next; head != &inuse_list; head = head->next) {
 		dquot = list_entry(head, struct dquot, dq_inuse);
@@ -405,6 +389,7 @@
 		goto restart;
 	}
 	dqstats.syncs++;
+	unlock_kernel();
 	return 0;
 }
 
@@ -428,7 +413,9 @@
 
 int shrink_dqcache_memory(int priority, unsigned int gfp_mask)
 {
+	lock_kernel();
 	prune_dqcache(nr_free_dquots / (priority + 1));
+	unlock_kernel();
 	kmem_cache_shrink(dquot_cachep);
 	return 0;
 }
@@ -465,12 +452,13 @@
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
 
@@ -633,9 +621,11 @@
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
@@ -644,6 +634,7 @@
 		INIT_LIST_HEAD(&dquot->dq_free);
 		dqput(dquot);
 	}
+	unlock_kernel();
 }
 
 static inline void dquot_incr_inodes(struct dquot *dquot, unsigned long number)
@@ -1289,6 +1280,7 @@
 	short cnt;
 	struct quota_mount_options *dqopt = sb_dqopt(sb);
 
+	lock_kernel();
 	if (!sb)
 		goto out;
 
@@ -1313,6 +1305,7 @@
 	}	
 	up(&dqopt->dqoff_sem);
 out:
+	unlock_kernel();
 	return 0;
 }
 
diff -ruX /home/jack/.kerndiffexclude linux-2.4.13/fs/inode.c linux-2.4.13-locksfix/fs/inode.c
--- linux-2.4.13/fs/inode.c	Tue Oct 30 22:54:35 2001
+++ linux-2.4.13-locksfix/fs/inode.c	Tue Oct 30 22:56:18 2001
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
diff -ruX /home/jack/.kerndiffexclude linux-2.4.13/include/linux/quota.h linux-2.4.13-locksfix/include/linux/quota.h
--- linux-2.4.13/include/linux/quota.h	Wed Oct 31 23:46:55 2001
+++ linux-2.4.13-locksfix/include/linux/quota.h	Wed Oct 31 23:47:12 2001
@@ -154,6 +154,7 @@
 #define DQ_BLKS       0x10	/* uid/gid has been warned about blk limit */
 #define DQ_INODES     0x20	/* uid/gid has been warned about inode limit */
 #define DQ_FAKE       0x40	/* no limits only usage */
+#define DQ_INVAL      0x80	/* dquot is going to be invalidated */
 
 struct dquot {
 	struct list_head dq_hash;	/* Hash list in memory */

--vtzGhvizbBRQ85DL--
