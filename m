Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131984AbRAPTFO>; Tue, 16 Jan 2001 14:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132422AbRAPTFE>; Tue, 16 Jan 2001 14:05:04 -0500
Received: from mail.valinux.com ([198.186.202.175]:40457 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S131984AbRAPTEz>;
	Tue, 16 Jan 2001 14:04:55 -0500
To: linux-kernel@vger.kernel.org
cc: alan@redhat.com, aviro@redhat.com
Subject: Locking problem in 2.2.18/19-pre7? (fs/inode.c and fs/dcache.c)
From: tytso@valinux.com
Phone: (781) 391-3464
Message-Id: <E14IbPR-0007Ye-00@beefcake.hdqt.valinux.com>
Date: Tue, 16 Jan 2001 11:04:45 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


HJ Lu recently pointed me at a potential locking problem
try_to_free_inodes(), and when I started proding at it, I found what
appears to be another set of SMP locking issues in the dcache code.
(But if that were the case, why aren't we seeing huge numbers of
complaints?  So I'm wondering if I'm missing something.)

Anyway, the first problem which HJ pointed out is in
try_to_free_inodes() which attempts to implement a mutual exclusion with
respect to itself as follows....

	if (block)
	{
		struct wait_queue __wait;

		__wait.task = current;
		add_wait_queue(&wait_inode_freeing, &__wait);
		for (;;)
		{
			/* NOTE: we rely only on the inode_lock to be sure
			   to not miss the unblock event */
			current->state = TASK_UNINTERRUPTIBLE;
			spin_unlock(&inode_lock);
			schedule();
			spin_lock(&inode_lock);
			if (!block)
				break;
		}
		remove_wait_queue(&wait_inode_freeing, &__wait);
		current->state = TASK_RUNNING;
	}
	block = 1;

Of course, this is utterly unsafe on an SMP machines, since access to
the "block" variable isn't protected at all.  So the first question is
why did whoever implemented this do it in this horribly complicated way
above, instead of something simple, say like this:

	static struct semaphore block = MUTEX;
	if (down_trylock(&block)) {
		spin_unlock(&inode_lock);
		down(&block);
		spin_lock(&inode_lock);
	}

(with the appropriate unlocking code at the end of the function).


Next question.... why was this there in the first place?  After all,
most of the time try_to_free_inodes() is called with the inode_lock
spinlock held, which would act as a automatic mutual exclusion anyway.
The only time this doesn't happen is when we call prune_dcache(), where
inode_lock is temporarily dropped.

So I took a look at prune_dcache(), and discovered that (a) it's called
from multiple places, and (b) it and shrink_dcache_sb() both iterate over
dentry_unused and among other things, tried to free dcache structures
without any kind of locking to prevent two kernel threads to
from mucking with the contents of dentry_unused at the same time, and
possibly having prune_one_dentry() being called by two processes on the
same dentry structure.  This should almost certainly cause problems.

So the following patch I think is definitely necessary, assuming that
the "block" mutual exclusion in try_to_free_inodes() needed to be there
in the first place.  I'm not so sure about needing a patch to protect
access to dentry_unused in fs/dentry.c, but unless there are some
other unstated locking hierarchy rules about when it's safe to call
prune_dcache() and shrink_dcache_sb(), I suspect we need to add a lock
to protect dentry_unused as well.  Comments?

						- Ted

--- fs/inode.c.old	Fri Sep 29 17:37:01 2000
+++ fs/inode.c	Tue Jan 16 09:29:06 2001
@@ -380,36 +380,19 @@
  */
 static void try_to_free_inodes(int goal)
 {
-	static int block;
-	static struct wait_queue * wait_inode_freeing;
+	static struct semaphore block = MUTEX;
 	LIST_HEAD(throw_away);
 	
 	/* We must make sure to not eat the inodes
 	   while the blocker task sleeps otherwise
 	   the blocker task may find none inode
 	   available. */
-	if (block)
-	{
-		struct wait_queue __wait;
-
-		__wait.task = current;
-		add_wait_queue(&wait_inode_freeing, &__wait);
-		for (;;)
-		{
-			/* NOTE: we rely only on the inode_lock to be sure
-			   to not miss the unblock event */
-			current->state = TASK_UNINTERRUPTIBLE;
-			spin_unlock(&inode_lock);
-			schedule();
-			spin_lock(&inode_lock);
-			if (!block)
-				break;
-		}
-		remove_wait_queue(&wait_inode_freeing, &__wait);
-		current->state = TASK_RUNNING;
+	if (down_trylock(&block)) {
+		spin_unlock(&inode_lock);
+		down(&block);
+		spin_lock(&inode_lock);
 	}
 
-	block = 1;
 	/*
 	 * First stry to just get rid of unused inodes.
 	 *
@@ -427,8 +410,7 @@
 	}
 	if (!list_empty(&throw_away))
 		dispose_list(&throw_away);
-	block = 0;
-	wake_up(&wait_inode_freeing);
+	up(&block);
 }
 
 /*
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
