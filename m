Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbTEIWPa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 18:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263542AbTEIWPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 18:15:30 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:53576 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263540AbTEIWP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 18:15:27 -0400
Date: Fri, 9 May 2003 15:24:10 -0700
From: Andrew Morton <akpm@digeo.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH - Don't remove inode from hash until filesystem has
 deleted it.
Message-Id: <20030509152410.39ede4b0.akpm@digeo.com>
In-Reply-To: <16057.46720.778667.845306@notabene.cse.unsw.edu.au>
References: <16057.46720.778667.845306@notabene.cse.unsw.edu.au>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 May 2003 22:28:01.0545 (UTC) FILETIME=[40339790:01C3167A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@cse.unsw.edu.au> wrote:
>
> 
> There is a small race with knfsd using iget to get an inode
> that is currently being deleted.  This is because it is removed
> from the hash table *before* the filesystem gets to delete it.
> If nfsd does an iget in this window it will cause a read_inode which
> will return an apparently valid inode.  However that inode will
> shortly be deleted from disc without knfsd noticing... until
> it is too late.

Cannot nfsd use igrab()?

> With this patch, the inode being deleted is left on the hash table,
> and if a lookup find an inode being freed in the hashtable, it waits
> in the inode waitqueue for the inode to be fully deleted.

Few things:

- Why the tests for I_CLEAR as well?

- There are lots of paths which set I_FREEING, and lots of paths which
  unhash inodes.  But only one path in which a waiter on
  __wait_on_freeing_inode() gets woken up.

  Are you sure there is sufficient coverage here?  That there are no
  paths by which someone goes to sleep on a freeing inode but never gets
  woken up?

- wart: when a task gets woken in __wait_on_freeing_inode(), it doesn't
  know that it got woken on behalf of the correct inode (hash collision). 
  So the inode can still be in state I_FREEING when
  __wait_on_freeing_inode() returns.

  Yeah, it happens that this is OK because the caller will just repeat the
  search, but that sort of subtlety needs to be covered in commentary.

- Cleanups:

 25-akpm/fs/inode.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff -puN fs/inode.c~inode-unhashing-fix-cleanups fs/inode.c
--- 25/fs/inode.c~inode-unhashing-fix-cleanups	Fri May  9 15:19:22 2003
+++ 25-akpm/fs/inode.c	Fri May  9 15:20:20 2003
@@ -478,6 +478,7 @@ static struct inode * find_inode(struct 
 	struct hlist_node *node;
 	struct inode * inode = NULL;
 
+repeat:
 	hlist_for_each (node, head) { 
 		prefetch(node->next);
 		inode = hlist_entry(node, struct inode, i_hash);
@@ -487,8 +488,7 @@ static struct inode * find_inode(struct 
 			continue;
 		if (inode->i_state & (I_FREEING|I_CLEAR)) {
 			__wait_on_freeing_inode(inode);
-			node = head->first;
-			continue;
+			goto repeat;
 		}
 		break;
 	}
@@ -504,6 +504,7 @@ static struct inode * find_inode_fast(st
 	struct hlist_node *node;
 	struct inode * inode = NULL;
 
+repeat:
 	hlist_for_each (node, head) {
 		prefetch(node->next);
 		inode = list_entry(node, struct inode, i_hash);
@@ -513,8 +514,7 @@ static struct inode * find_inode_fast(st
 			continue;
 		if (inode->i_state & (I_FREEING|I_CLEAR)) {
 			__wait_on_freeing_inode(inode);
-			node = head->first;
-			continue;
+			goto repeat;
 		}
 		break;
 	}
@@ -1253,11 +1253,9 @@ void __wait_on_freeing_inode(struct inod
 	spin_unlock(&inode_lock);
 	schedule();
 	remove_wait_queue(wq, &wait);
-	current->state = TASK_RUNNING;
 	spin_lock(&inode_lock);
 }
 
-
 void wake_up_inode(struct inode *inode)
 {
 	wait_queue_head_t *wq = i_waitq_head(inode);

_

