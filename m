Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280215AbRJaNrQ>; Wed, 31 Oct 2001 08:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280217AbRJaNrH>; Wed, 31 Oct 2001 08:47:07 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:42767 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S280215AbRJaNrE>; Wed, 31 Oct 2001 08:47:04 -0500
Date: Wed, 31 Oct 2001 14:47:37 +0100
From: Jan Kara <jack@suse.cz>
To: Simon Kirby <sim@netnation.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops: Quota race in 2.4.12?
Message-ID: <20011031144737.A4068@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20011028215818.A7887@netnation.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <20011028215818.A7887@netnation.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hi,

> Some of our dual CPU web servers with 2.4.12 are Oopsing while running
> quotacheck.  They don't seem to die immediately, but oops many times and
> eventually break.  The old tools didn't warn about quotachecking on a
> live file system, so some of our servers were set up to run quotacheck
> nightly.  The new tools still allow you to do it, but warn that it may
> not be consistent.  We didn't have any problems with 2.2 kernels.
> 
> First oops, as already processed (grumble) by klogd:
> 
> Oct 28 04:22:32 pro kernel: remove_free_dquot: dquot not on the free list??
> Oct 28 04:22:32 pro last message repeated 90 times
> Oct 28 04:22:32 pro kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
> ...dates stripped:
  <snip>

  Attached is the patch against 2.4.13 which should solve some SMP races...  Can you try
it if it fixes your problems? I know also about one possible race during quotaoff()
which I'll fix tonight but that shouldn't be your case :).
										Honza

--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quota-fix-2.4.13.diff"

diff -ruX /home/jack/.kerndiffexclude linux-2.4.13/fs/dquot.c linux-2.4.13-locksfix/fs/dquot.c
--- linux-2.4.13/fs/dquot.c	Thu Oct 11 00:08:48 2001
+++ linux-2.4.13-locksfix/fs/dquot.c	Wed Oct 31 00:20:17 2001
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
@@ -384,6 +366,7 @@
 	struct list_head *head;
 	struct dquot *dquot;
 
+	lock_kernel();
 restart:
 	for (head = inuse_list.next; head != &inuse_list; head = head->next) {
 		dquot = list_entry(head, struct dquot, dq_inuse);
@@ -405,6 +388,7 @@
 		goto restart;
 	}
 	dqstats.syncs++;
+	unlock_kernel();
 	return 0;
 }
 
@@ -428,7 +412,9 @@
 
 int shrink_dqcache_memory(int priority, unsigned int gfp_mask)
 {
+	lock_kernel();
 	prune_dqcache(nr_free_dquots / (priority + 1));
+	unlock_kernel();
 	kmem_cache_shrink(dquot_cachep);
 	return 0;
 }
@@ -470,7 +456,7 @@
 	wake_up(&dquot->dq_wait_free);
 }
 
-struct dquot *get_empty_dquot(void)
+static struct dquot *get_empty_dquot(void)
 {
 	struct dquot *dquot;
 
@@ -633,9 +619,11 @@
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
@@ -644,6 +632,7 @@
 		INIT_LIST_HEAD(&dquot->dq_free);
 		dqput(dquot);
 	}
+	unlock_kernel();
 }
 
 static inline void dquot_incr_inodes(struct dquot *dquot, unsigned long number)
@@ -1289,6 +1278,7 @@
 	short cnt;
 	struct quota_mount_options *dqopt = sb_dqopt(sb);
 
+	lock_kernel();
 	if (!sb)
 		goto out;
 
@@ -1313,6 +1303,7 @@
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

--opJtzjQTFsWo+cga--
