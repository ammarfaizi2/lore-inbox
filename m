Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280572AbRKSSd1>; Mon, 19 Nov 2001 13:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280586AbRKSSdQ>; Mon, 19 Nov 2001 13:33:16 -0500
Received: from peace.netnation.com ([204.174.223.2]:61658 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP
	id <S280556AbRKSSb6>; Mon, 19 Nov 2001 13:31:58 -0500
Date: Mon, 19 Nov 2001 10:31:56 -0800
From: Simon Kirby <sim@netnation.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: VM-related Oops: 2.4.15pre1
Message-ID: <20011119103156.A23091@netnation.com>
In-Reply-To: <20011119095631.A24617@netnation.com> <Pine.LNX.4.33.0111190958230.8205-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.33.0111190958230.8205-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Nov 19, 2001 at 10:03:34AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii

On Mon, Nov 19, 2001 at 10:03:34AM -0800, Linus Torvalds wrote:

> I suspect that your earlier oopses left something in a stale state - this
> is the same machine that you've reported others oopses for, no?

I have in the past reported one Oops for this machine, I think, yes.
I think it was explained by previous kernel bugs (it was running 2.4.12).
On this kernel version, we've only seen the single BUG() message
regarding page->mapping, and the associated forced Oops/backtrace thing. 
Every BUG() and backtrace has been the same except for a few registers,
including the first backtrace.

> It looks like it's a bog-standard page, that was just free'd (probably
> because of page->count corruption) while it was still in the page cache.
> Now, how that page->count corruption actually happened, I have no idea,
> which is why I suspect you had other earlier oopses that left the machine
> in an inconsistent state.
> 
> There _is_ a known race in 2.4.15pre1, where we simply test a condition
> that isn't true any more and that can cause spurious oopses (not this one,
> though) under the right circumstances. Such an oops might have left
> something in the VM in a half-way state...

Right, but there were no other Oopses on this machine since 2.4.15pre1
was put on (up 5 days).  Previously, with 2.4.12, it Oopsed in some
memory freeing function (I think it was __free_pages_ok or something),
but I didn't have a serial console on it at the time and it was locked
up.

> Can you reproduce this on pre6, for example? And if so, what's the load?

Will pre6 eat my filesystem? :)  It's a production box (I just used pre1
because I read through it and saw there were no serious changes, just
a simple race fix and a few other things).

The box is a heavily-hit shared hosting web server running the usual
collection of Apache, Perl, php, and other programs.

I wonder if the quota stuff (which is also used heavily on this box, but
probably not tested anywhere near as widely elsewhere) is the culprit. 
Jan Kara has sent me this patch to test (but I have not yet had the
chance to try it on some production servers).  It looks like he's wrapped
some memory freeing functions with lock_kernel.  Currently, 2.4.14 Oopses
all over the place if quotacheck is run on an active filesystem with
quota turned on (which is broken to begin with, yes, but shouldn't cause
Oopses).

Attached is Jan's patch.  See anything interesting?  He said he has not
yet submitted it because he hasn't had a chance to test it on an SMP box.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]

--ReaqsoxgOBHFXBhH
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

--ReaqsoxgOBHFXBhH--
