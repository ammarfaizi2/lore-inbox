Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751514AbVJSBQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbVJSBQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 21:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbVJSBQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 21:16:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2983 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751514AbVJSBQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 21:16:27 -0400
Date: Tue, 18 Oct 2005 18:15:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Mason <mason@suse.com>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix nr_unused accounting, and avoid recursing in iput
 with I_WILL_FREE set
Message-Id: <20051018181548.760dbf8c.akpm@osdl.org>
In-Reply-To: <20051019004018.GZ1027@watt.suse.com>
References: <20051018082609.GC15717@x30.random>
	<20051018171335.3b308b3e.akpm@osdl.org>
	<20051019004018.GZ1027@watt.suse.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason <mason@suse.com> wrote:
>
> On Tue, Oct 18, 2005 at 05:13:35PM -0700, Andrew Morton wrote:
> > Andrea Arcangeli <andrea@suse.de> wrote:
> > >
> > > Hello,
> > > 
> > > @@ -183,6 +183,7 @@ __sync_single_inode(struct inode *inode,
> > >  			list_move(&inode->i_list, &inode_in_use);
> > >  		} else {
> > >  			list_move(&inode->i_list, &inode_unused);
> > > +			inodes_stat.nr_unused++;
> > >  		}
> > >  	}
> > >  	wake_up_inode(inode);
> > > 
> > > Are you sure the above diff is correct? It was added somewhere between
> > > 2.6.5 and 2.6.8. I think it's wrong.
> > > 
> > > The only way I can imagine the i_count to be zero in the above path, is
> > > that I_WILL_FREE is set. And if I_WILL_FREE is set, then we must not
> > > increase nr_unused. So I believe the above change is buggy and it will
> > > definitely overstate the number of unused inodes and it should be backed
> > > out.
> > 
> > Well according to my assertion (below), the inode in __sync_single_inode()
> > cannot have a zero refcount, so the whole if() statement is never executed.
> 
> generic_forget_inode->write_inode_now->__writeback_single_inode->
> __sync_single_inode

oshit.

> We do have I_WILL_FREE, but i_count will be zero.

yup.

> > 
> > The thinking behind that increment is that __sync_single_inode() has just
> > taken a dirty, zero-refcount inode and has cleaned it.  A dirty inode
> > cannot have previously been on inode_unused, hence we now are newly moving
> > it to inode_unused.
> 
> nr_unused doesn't seem to count the number of inodes on the unused list.
> It is actually counting the number of inodes whose i_count is 0.  See
> generic_forget_inode and invalidate_list to see what I mean.

hm, OK.  It'd be nice to make that more explicit.  Something like this?

--- devel/fs/inode.c~generic_forget_inode-nr_unused-cleanup	2005-10-18 18:13:22.000000000 -0700
+++ devel-akpm/fs/inode.c	2005-10-18 18:13:57.000000000 -0700
@@ -1067,8 +1067,8 @@ static void generic_forget_inode(struct 
 	if (!hlist_unhashed(&inode->i_hash)) {
 		if (!(inode->i_state & (I_DIRTY|I_LOCK)))
 			list_move(&inode->i_list, &inode_unused);
-		inodes_stat.nr_unused++;
 		if (!sb || (sb->s_flags & MS_ACTIVE)) {
+			inodes_stat.nr_unused++;  /* One more 0-ref inode */
 			spin_unlock(&inode_lock);
 			return;
 		}
@@ -1077,7 +1077,6 @@ static void generic_forget_inode(struct 
 		write_inode_now(inode, 1);
 		spin_lock(&inode_lock);
 		inode->i_state &= ~I_WILL_FREE;
-		inodes_stat.nr_unused--;
 		hlist_del_init(&inode->i_hash);
 	}
 	list_del_init(&inode->i_list);
_

> generic_forget_inode took care of incrementing the unused count when
> i_count went to zero. So, I don't think we need to worry about the
> unused count in __writeback_single_inode.
> 

How about this for now?


diff -puN fs/fs-writeback.c~fix-nr_unused-accounting-and-avoid-recursing-in-iput-with-i_will_free-set fs/fs-writeback.c
--- devel/fs/fs-writeback.c~fix-nr_unused-accounting-and-avoid-recursing-in-iput-with-i_will_free-set	2005-10-18 18:02:51.000000000 -0700
+++ devel-akpm/fs/fs-writeback.c	2005-10-18 18:05:22.000000000 -0700
@@ -229,8 +229,8 @@ __sync_single_inode(struct inode *inode,
 			/*
 			 * The inode is clean, unused
 			 */
+			WARN_ON(1);
 			list_move(&inode->i_list, &inode_unused);
-			inodes_stat.nr_unused++;
 		}
 	}
 	wake_up_inode(inode);
@@ -238,14 +238,20 @@ __sync_single_inode(struct inode *inode,
 }
 
 /*
- * Write out an inode's dirty pages.  Called under inode_lock.
+ * Write out an inode's dirty pages.  Called under inode_lock.  Either the
+ * caller has ref on the inode (either via __iget or via syscall against an fd)
+ * or the inode has I_WILL_FREE set (via generic_forget_inode)
  */
 static int
-__writeback_single_inode(struct inode *inode,
-			struct writeback_control *wbc)
+__writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 {
 	wait_queue_head_t *wqh;
 
+	if (!atomic_read(&inode->i_count))
+		WARN_ON(!(inode->i_flags & I_WILL_FREE));
+	else
+		WARN_ON(inode->i_flags & I_WILL_FREE);
+
 	if ((wbc->sync_mode != WB_SYNC_ALL) && (inode->i_state & I_LOCK)) {
 		list_move(&inode->i_list, &inode->i_sb->s_dirty);
 		return 0;
@@ -259,11 +265,9 @@ __writeback_single_inode(struct inode *i
 
 		wqh = bit_waitqueue(&inode->i_state, __I_LOCK);
 		do {
-			__iget(inode);
 			spin_unlock(&inode_lock);
 			__wait_on_bit(wqh, &wq, inode_wait,
 							TASK_UNINTERRUPTIBLE);
-			iput(inode);
 			spin_lock(&inode_lock);
 		} while (inode->i_state & I_LOCK);
 	}
@@ -541,14 +545,15 @@ void sync_inodes(int wait)
 }
 
 /**
- *	write_inode_now	-	write an inode to disk
- *	@inode: inode to write to disk
- *	@sync: whether the write should be synchronous or not
+ * write_inode_now	-	write an inode to disk
+ * @inode: inode to write to disk
+ * @sync: whether the write should be synchronous or not
+ *
+ * This function commits an inode to disk immediately if it is dirty. This is
+ * primarily needed by knfsd.
  *
- *	This function commits an inode to disk immediately if it is
- *	dirty. This is primarily needed by knfsd.
+ * The caller must either have a ref on the inode or must have set I_WILL_FREE.
  */
- 
 int write_inode_now(struct inode *inode, int sync)
 {
 	int ret;
_

