Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbTELA3V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 20:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbTELA3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 20:29:21 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:45464 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S261773AbTELA3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 20:29:10 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@digeo.com>
Date: Mon, 12 May 2003 10:41:37 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16062.60865.8518.954627@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH - Don't remove inode from hash until filesystem has
 deleted it.
In-Reply-To: message from Andrew Morton on Friday May 9
References: <16057.46720.778667.845306@notabene.cse.unsw.edu.au>
	<20030509152410.39ede4b0.akpm@digeo.com>
X-Mailer: VM 7.14 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday May 9, akpm@digeo.com wrote:
> Neil Brown <neilb@cse.unsw.edu.au> wrote:
> >
> > 
> > There is a small race with knfsd using iget to get an inode
> > that is currently being deleted.  This is because it is removed
> > from the hash table *before* the filesystem gets to delete it.
> > If nfsd does an iget in this window it will cause a read_inode which
> > will return an apparently valid inode.  However that inode will
> > shortly be deleted from disc without knfsd noticing... until
> > it is too late.
> 
> Cannot nfsd use igrab()?

That wouldn't help.  By the time nfsd gets the inode, and so has a
chance to use igrab, it is too late.

> 
> > With this patch, the inode being deleted is left on the hash table,
> > and if a lookup find an inode being freed in the hashtable, it waits
> > in the inode waitqueue for the inode to be fully deleted.
> 
> Few things:
> 
> - Why the tests for I_CLEAR as well?

Because the inode is unhashed (very) shortly *after* clear_inode is
called, which clears I_FREEING.
So instead of :
   unhash
   set I_FREEING
   call into filesystem
   change I_FREEING to I_CLEAR
   destroy

we now
   set I_FREEING
   call into filesystem
   change I_FREEING to I_CLEAR
   unhash
   destroy

so the inode is now still in the hash table while I_FREEING is set,
and momentarily while I_CLEAR is set as well.  We need to guard
against these posibilities.

> 
> - There are lots of paths which set I_FREEING, and lots of paths which
>   unhash inodes.  But only one path in which a waiter on
>   __wait_on_freeing_inode() gets woken up.
> 
>   Are you sure there is sufficient coverage here?  That there are no
>   paths by which someone goes to sleep on a freeing inode but never gets
>   woken up?

Yes (but please check my logic).

Sometimes we are Freeing and Clearing an inode because we aren't
interested in it any more and want to get it out of the cache.
Sometimes we are Freeing and Clearing because the inode is dead and is
to be completely forgotten.

In the first case we set I_FREEING atomically (via inode_lock) with
removing from the hash table.  In this case the inode will have always
been un-dirtied first so the filesystem storage device contains
up-to-date information.  If we go an read from disk instantly after
the unhas, we will get a valid inode.

It is only in the second case that an I_FREEING inode will ever appear
in the hash table.  In this case we set I_FREEING while the inode is
still potentially dirty.  The inode has been 'deleted' (link count +
ref count == 0) but the data on disc doesn't not yet reflect this.
It is in this case that we don't want to load an inode from disk
before the filesystem has completely finished with it, and so only in
this case that we need to wait.

So, the only time anyone will find an I_FREEING or I_CLEAR inode in
the hash table and so wait for it, is when that inode is being
deleted.

This only happens in the generic_delete_inode path and that one does
call wake_up_inode after unhashing.

> 
> - wart: when a task gets woken in __wait_on_freeing_inode(), it doesn't
>   know that it got woken on behalf of the correct inode (hash collision). 
>   So the inode can still be in state I_FREEING when
>   __wait_on_freeing_inode() returns.
> 
>   Yeah, it happens that this is OK because the caller will just repeat the
>   search, but that sort of subtlety needs to be covered in
>   commentary.

Fair comment.  I assume the "goto repeat" is partly to provide such
commentary?

> 
> - Cleanups:
> 
They all look good.  This makes the resives patch as below.

Thanks,
NeilBrown


---------------------------------------
Don't remove inode from hash until filesystem has deleted it.

There is a small race with knfsd using iget to get and inode
that is currently being deleted.  This is because it is removed
from the hash table *before* the filesystem gets to delete it.
If nfsd does an iget in this window it will cause a readinode which
will return an apparently valid inode.  However that inode will
shortly be deleted from disc without knfsd noticing... until
it is too late.

With this patch, the inode being deleted is left on the hash table,
and if a lookup find an inode being freed in the hashtable, it waits
in the inode waitqueue for the inode to be fully deleted.

 ----------- Diffstat output ------------
 ./fs/fs-writeback.c |    3 ++-
 ./fs/inode.c        |   29 ++++++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 2 deletions(-)

diff ./fs/fs-writeback.c~current~ ./fs/fs-writeback.c
--- ./fs/fs-writeback.c~current~	2003-05-09 15:52:31.000000000 +1000
+++ ./fs/fs-writeback.c	2003-05-12 10:36:27.000000000 +1000
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
--- ./fs/inode.c~current~	2003-05-09 15:52:31.000000000 +1000
+++ ./fs/inode.c	2003-05-12 10:37:06.000000000 +1000
@@ -466,6 +466,7 @@ static int shrink_icache_memory(int nr, 
 	return inodes_stat.nr_unused;
 }
 
+void __wait_on_freeing_inode(struct inode *inode);
 /*
  * Called with the inode lock held.
  * NOTE: we are not increasing the inode-refcount, you must call __iget()
@@ -477,6 +478,7 @@ static struct inode * find_inode(struct 
 	struct hlist_node *node;
 	struct inode * inode = NULL;
 
+repeat:
 	hlist_for_each (node, head) { 
 		prefetch(node->next);
 		inode = hlist_entry(node, struct inode, i_hash);
@@ -484,6 +486,10 @@ static struct inode * find_inode(struct 
 			continue;
 		if (!test(inode, data))
 			continue;
+		if (inode->i_state & (I_FREEING|I_CLEAR)) {
+			__wait_on_freeing_inode(inode);
+			goto repeat;
+		}
 		break;
 	}
 	return node ? inode : NULL;
@@ -498,6 +504,7 @@ static struct inode * find_inode_fast(st
 	struct hlist_node *node;
 	struct inode * inode = NULL;
 
+repeat:
 	hlist_for_each (node, head) {
 		prefetch(node->next);
 		inode = list_entry(node, struct inode, i_hash);
@@ -505,6 +512,10 @@ static struct inode * find_inode_fast(st
 			continue;
 		if (inode->i_sb != sb)
 			continue;
+		if (inode->i_state & (I_FREEING|I_CLEAR)) {
+			__wait_on_freeing_inode(inode);
+			goto repeat;
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
@@ -1229,6 +1243,19 @@ repeat:
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
+	spin_lock(&inode_lock);
+}
+
 void wake_up_inode(struct inode *inode)
 {
 	wait_queue_head_t *wq = i_waitq_head(inode);
