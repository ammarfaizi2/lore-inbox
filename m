Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbTD1Rgg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 13:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbTD1Rgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 13:36:36 -0400
Received: from hypatia.llnl.gov ([134.9.11.73]:20632 "EHLO hypatia.llnl.gov")
	by vger.kernel.org with ESMTP id S261221AbTD1Rgb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 13:36:31 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Dave Peterson <dsp@llnl.gov>
Organization: Lawrence Livermore National Laboratory
To: linux-kernel@vger.kernel.org
Subject: 2.4.20 patch to fix race condition in iput()
Date: Mon, 28 Apr 2003 10:48:39 -0700
User-Agent: KMail/1.4.1
Cc: viro@parcelfarce.linux.theplanet.co.uk, dsp@llnl.gov
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200304281048.39478.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found a race condition in the 2.4.20 kernel that involves
iput() and the syncing of inodes to disk when their reference
counts drop to 0.  The problem involves the temporary releasing
of inode_lock while the inode is being written to disk.  Once
the write is finished, inode_lock is again acquired with the
assumption that no other task has removed the inode from the
inode_unused list and started to destroy it. However, this
assumption may be violated if another task is executing
kill_super() while the write is in progress.  Here is a scenario
that demonstrates the problem:

    1.  Task A is inside kill_super().  It clears the MS_ACTIVE
        flag of the s_flags field of the super_block struct and
        calls invalidate_inodes().  In invalidate_inodes(), it
        attempts to acquire inode_lock and spins because task B,
        executing inside iput(), just decremented the reference
        count of some inode i to 0 and acquired inode_lock.

    2.  Then the "if (!inode->i_nlink)" test condition evaluates
        to false for task B so it executes the following chunk
        of code:

        01 } else {
        02         if (!list_empty(&inode->i_hash)) {
        03                 if (!(inode->i_state & (I_DIRTY|I_LOCK))) {
        04                         list_del(&inode->i_list);
        05                         list_add(&inode->i_list, &inode_unused);
        06                 }
        07                 inodes_stat.nr_unused++;
        08                 spin_unlock(&inode_lock);
        09                 if (!sb || (sb->s_flags & MS_ACTIVE))
        10                         return;
        11                 write_inode_now(inode, 1);
        12                 spin_lock(&inode_lock);
        13                 inodes_stat.nr_unused--;
        14                 list_del_init(&inode->i_hash);
        15         }
        16         list_del_init(&inode->i_list);
        17         inode->i_state|=I_FREEING;
        18         inodes_stat.nr_inodes--;
        19         spin_unlock(&inode_lock);
        20         if (inode->i_data.nrpages)
        21                 truncate_inode_pages(&inode->i_data, 0);
        22         clear_inode(inode);
        23 }
        24 destroy_inode(inode);

        Now the test condition on line 02 evaluates to true, so
        task B adds the inode to the inode_unused list and then
        releases inode_lock on line 08.

    3.  Now A acquires inode_lock and B spins on inode_lock inside
        write_inode_now();

    4.  Task A calls invalidate_list(), transferring inode i from
        the inode_unused list to its own private throw_away list.

    5.  Task A releases inode_lock, allowing B to acquire inode_lock
        and continue executing.

    6.  A attempts to destroy inode i inside dispose_list() while B
        simultaneously attempts to destroy i, potentially causing
        all sorts of bad things to happen.

To fix the problem, I have appended to this message a 2.4.20 kernel
patch for fs/inode.c.  It alters the behavior of iput() as follows:

    Move the "if (!sb || (sb->s_flags & MS_ACTIVE))" so that is
    evaluated while still holding inode_lock.  Then add the inode to
    the inode_unused list (provided that that the inode is neither
    locked nor dirty), release inode_lock, and return only if the
    test condition evaluates to true.  Otherwise do not add the
    inode to the inode_unused list.  Instead, remove the inode from
    its hash list so no other tasks can obtain references to it,
    call __iget() to increment the reference count back to 1 and
    add the inode to nodes_in_use, and then release inode_lock and
    write the inode to disk.  Since we have a reference to the inode,
    no other task can attempt to destroy it while the write is in
    progress.  Once the write finished, reacquire inode_lock, set the
    inode's reference count to 0, remove the inode from the
    nodes_in_use list, and destroy the inode.

In addition, the patch fixes a minor problem in which the bookkeeping
for inodes_stat.nr_unused was being done incorrectly.  It also
cleans up the function sync_one() which is shown here in its original
form:

    static inline void sync_one(struct inode *inode, int sync)
    {
            while (inode->i_state & I_LOCK) {
                    __iget(inode);
                    spin_unlock(&inode_lock);
                    __wait_on_inode(inode);
                    iput(inode);
                    spin_lock(&inode_lock);
            }

            __sync_one(inode, sync);
    }

The logic of this function is inherently flawed in the way that it
manipulates the reference count on the inode.  Presumably, __iget() is
called to prevent the inode from being destroyed after inode_lock is
released.  After __wait_on_inode() returns, iput() is called to release
the reference that was just acquired.  Then, inode_lock is acquired
again.  This is problematic because the call to iput() could cause the
reference count on the inode to drop to 0, resulting in a call to
__sync_one() on an inode that has been destroyed.  The assumption
should be that prior to calling sync_one(), the caller has obtained its
own reference to the inode.  After examining all callers of sync_one()
and verifying that this assumption does in fact hold, I have removed
the calls to __iget() and iput() from sync_one().


-Dave Peterson
 dsp@llnl.gov


P.S.  Please CC my email address when responding to this message.


----- START OF PATCH FOR fs/inode.c (kernel 2.4.20) --------------------------
--- inode.c.original	Fri Apr 25 16:49:08 2003
+++ inode.c	Fri Apr 25 17:04:49 2003
@@ -202,7 +202,6 @@
 		list_del(&inode->i_list);
 		list_add(&inode->i_list, &inode_in_use);
 	}
-	inodes_stat.nr_unused--;
 }
 
 static inline void __sync_one(struct inode *inode, int sync)
@@ -237,8 +236,10 @@
 			to = &inode->i_sb->s_dirty;
 		else if (atomic_read(&inode->i_count))
 			to = &inode_in_use;
-		else
+		else {
 			to = &inode_unused;
+			inodes_stat.nr_unused++;
+		}
 		list_del(&inode->i_list);
 		list_add(&inode->i_list, to);
 	}
@@ -248,10 +249,8 @@
 static inline void sync_one(struct inode *inode, int sync)
 {
 	while (inode->i_state & I_LOCK) {
-		__iget(inode);
 		spin_unlock(&inode_lock);
 		__wait_on_inode(inode);
-		iput(inode);
 		spin_lock(&inode_lock);
 	}
 
@@ -1065,18 +1064,25 @@
 				BUG();
 		} else {
 			if (!list_empty(&inode->i_hash)) {
-				if (!(inode->i_state & (I_DIRTY|I_LOCK))) {
-					list_del(&inode->i_list);
-					list_add(&inode->i_list, &inode_unused);
+				if (!sb || (sb->s_flags & MS_ACTIVE)) {
+					if (!(inode->i_state &
+					    (I_DIRTY|I_LOCK))) {
+						list_del(&inode->i_list);
+						list_add(&inode->i_list,
+							 &inode_unused);
+						inodes_stat.nr_unused++;
+					}
+
+					spin_unlock(&inode_lock);
+					return;
 				}
-				inodes_stat.nr_unused++;
+
+				list_del_init(&inode->i_hash);
+				__iget(inode);
 				spin_unlock(&inode_lock);
-				if (!sb || (sb->s_flags & MS_ACTIVE))
-					return;
 				write_inode_now(inode, 1);
 				spin_lock(&inode_lock);
-				inodes_stat.nr_unused--;
-				list_del_init(&inode->i_hash);
+				atomic_set(&inode->i_count, 0);
 			}
 			list_del_init(&inode->i_list);
 			inode->i_state|=I_FREEING;
----- END OF PATCH FOR fs/inode.c --------------------------------------------
