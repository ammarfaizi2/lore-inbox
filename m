Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264397AbTEHBcC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 21:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264399AbTEHBcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 21:32:02 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:54705 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S264397AbTEHBb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 21:31:58 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@digeo.com>
Date: Thu, 8 May 2003 11:44:32 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16057.46720.778667.845306@notabene.cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: PATCH - Don't remove inode from hash until filesystem has
   deleted it.
X-Mailer: VM 7.14 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew,
 I wonder if you would consider including this patch in -mm so that it
 gets some testing and review.

Thanks,
NeilBrown


------------------------------------------------------
Don't remove inode from hash until filesystem has deleted it.

There is a small race with knfsd using iget to get an inode
that is currently being deleted.  This is because it is removed
from the hash table *before* the filesystem gets to delete it.
If nfsd does an iget in this window it will cause a read_inode which
will return an apparently valid inode.  However that inode will
shortly be deleted from disc without knfsd noticing... until
it is too late.

With this patch, the inode being deleted is left on the hash table,
and if a lookup find an inode being freed in the hashtable, it waits
in the inode waitqueue for the inode to be fully deleted.

 ----------- Diffstat output ------------
 ./fs/fs-writeback.c |    3 ++-
 ./fs/inode.c        |   31 ++++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 2 deletions(-)

diff ./fs/fs-writeback.c~current~ ./fs/fs-writeback.c
--- ./fs/fs-writeback.c~current~	2003-05-02 16:41:32.000000000 +1000
+++ ./fs/fs-writeback.c	2003-05-02 16:41:33.000000000 +1000
@@ -90,7 +90,8 @@ void __mark_inode_dirty(struct inode *in
 		 * Only add valid (hashed) inodes to the superblock's
 		 * dirty list.  Add blockdev inodes as well.
 		 */
-		if (hlist_unhashed(&inode->i_hash) && !S_ISBLK(inode->i_mode))
+		if ((hlist_unhashed(&inode->i_hash) || (inode->i_state & (I_FREEING|I_CLEAR)))
+		    && !S_ISBLK(inode->i_mode))
 			goto out;
 
 		/*

diff ./fs/inode.c~current~ ./fs/inode.c
--- ./fs/inode.c~current~	2003-05-02 16:41:32.000000000 +1000
+++ ./fs/inode.c	2003-05-02 16:41:33.000000000 +1000
@@ -466,6 +466,7 @@ static int shrink_icache_memory(int nr, 
 	return inodes_stat.nr_unused;
 }
 
+void __wait_on_freeing_inode(struct inode *inode);
 /*
  * Called with the inode lock held.
  * NOTE: we are not increasing the inode-refcount, you must call __iget()
@@ -484,6 +485,11 @@ static struct inode * find_inode(struct 
 			continue;
 		if (!test(inode, data))
 			continue;
+		if (inode->i_state & (I_FREEING|I_CLEAR)) {
+			__wait_on_freeing_inode(inode);
+			node = head->first;
+			continue;
+		}
 		break;
 	}
 	return node ? inode : NULL;
@@ -505,6 +511,11 @@ static struct inode * find_inode_fast(st
 			continue;
 		if (inode->i_sb != sb)
 			continue;
+		if (inode->i_state & (I_FREEING|I_CLEAR)) {
+			__wait_on_freeing_inode(inode);
+			node = head->first;
+			continue;
+		}
 		break;
 	}
 	return node ? inode : NULL;
@@ -937,7 +948,6 @@ void generic_delete_inode(struct inode *
 {
 	struct super_operations *op = inode->i_sb->s_op;
 
-	hlist_del_init(&inode->i_hash);
 	list_del_init(&inode->i_list);
 	inode->i_state|=I_FREEING;
 	inodes_stat.nr_inodes--;
@@ -956,6 +966,10 @@ void generic_delete_inode(struct inode *
 		delete(inode);
 	} else
 		clear_inode(inode);
+	spin_lock(&inode_lock);
+	hlist_del_init(&inode->i_hash);
+	spin_unlock(&inode_lock);
+	wake_up_inode(inode);
 	if (inode->i_state != I_CLEAR)
 		BUG();
 	destroy_inode(inode);
@@ -1229,6 +1243,21 @@ repeat:
 	__set_current_state(TASK_RUNNING);
 }
 
+void __wait_on_freeing_inode(struct inode *inode)
+{
+	DECLARE_WAITQUEUE(wait, current);
+	wait_queue_head_t *wq = i_waitq_head(inode);
+
+	add_wait_queue(wq, &wait);
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	spin_unlock(&inode_lock);
+	schedule();
+	remove_wait_queue(wq, &wait);
+	current->state = TASK_RUNNING;
+	spin_lock(&inode_lock);
+}
+
+
 void wake_up_inode(struct inode *inode)
 {
 	wait_queue_head_t *wq = i_waitq_head(inode);
