Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbVJSAN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbVJSAN1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 20:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbVJSAN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 20:13:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45457 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932189AbVJSAN1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 20:13:27 -0400
Date: Tue, 18 Oct 2005 17:13:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, mason@suse.com
Subject: Re: [PATCH] fix nr_unused accounting, and avoid recursing in iput
 with I_WILL_FREE set
Message-Id: <20051018171335.3b308b3e.akpm@osdl.org>
In-Reply-To: <20051018082609.GC15717@x30.random>
References: <20051018082609.GC15717@x30.random>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> Hello,
> 
> @@ -183,6 +183,7 @@ __sync_single_inode(struct inode *inode,
>  			list_move(&inode->i_list, &inode_in_use);
>  		} else {
>  			list_move(&inode->i_list, &inode_unused);
> +			inodes_stat.nr_unused++;
>  		}
>  	}
>  	wake_up_inode(inode);
> 
> Are you sure the above diff is correct? It was added somewhere between
> 2.6.5 and 2.6.8. I think it's wrong.
> 
> The only way I can imagine the i_count to be zero in the above path, is
> that I_WILL_FREE is set. And if I_WILL_FREE is set, then we must not
> increase nr_unused. So I believe the above change is buggy and it will
> definitely overstate the number of unused inodes and it should be backed
> out.

Well according to my assertion (below), the inode in __sync_single_inode()
cannot have a zero refcount, so the whole if() statement is never executed.

The thinking behind that increment is that __sync_single_inode() has just
taken a dirty, zero-refcount inode and has cleaned it.  A dirty inode
cannot have previously been on inode_unused, hence we now are newly moving
it to inode_unused.

I'll stick a WARN_ON in there for now, wait and see if anyone can hit it.

> Note that __writeback_single_inode before calling __sync_single_inode, can
> drop the spinlock and we can have both the dirty and locked bitflags
> clear here:
> 
> 		spin_unlock(&inode_lock);
> 		__wait_on_inode(inode);
> 		iput(inode);
> XXXXXXX
> 		spin_lock(&inode_lock);
> 	}
> 	use inode again here
> 
> a construct like the above makes zero sense from a reference counting
> standpoint.
> 
> Either we don't ever use the inode again after the iput, or the
> inode_lock should be taken _before_ executing the iput (i.e. a __iput
> would be required). Taking the inode_lock after iput means the iget was
> useless if we keep using the inode after the iput.
> 
> So the only chance the 2.6 was safe to call __writeback_single_inode
> with the i_count == 0, is that I_WILL_FREE is set (I_WILL_FREE will
> prevent the VM to free the inode in XXXXX).
> 
> Potentially calling the above iput with I_WILL_FREE was also wrong
> because it would recurse in iput_final (the second mainline bug).
>
> The below (untested) patch fixes the nr_unused accounting, avoids
> recursing in iput when I_WILL_FREE is set and makes sure (with the
> BUG_ON) that we don't corrupt memory and that all holders that don't set
> I_WILL_FREE, keeps a reference on the inode!
> 

That's something which Bill snuck in there during some waitqueue rework.

I agree that the iget/iput is unneeded: all callers to
__writeback_single_inode() already have a ref on the inode: either via
sync_sb_inodes()'s iget() or via syscall(fd, ...).

So the BUG_ON() in __writeback_single_inode() becomes
BUG_ON(!atomic_read(&inode->i_count)); - I'll make it WARN_ON for now coz
I'm not so sure any more ;)

So...  With updated comments:


diff -puN fs/fs-writeback.c~fix-nr_unused-accounting-and-avoid-recursing-in-iput-with-i_will_free-set fs/fs-writeback.c
--- 25/fs/fs-writeback.c~fix-nr_unused-accounting-and-avoid-recursing-in-iput-with-i_will_free-set	Tue Oct 18 17:07:49 2005
+++ 25-akpm/fs/fs-writeback.c	Tue Oct 18 17:12:53 2005
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
@@ -238,14 +238,16 @@ __sync_single_inode(struct inode *inode,
 }
 
 /*
- * Write out an inode's dirty pages.  Called under inode_lock.
+ * Write out an inode's dirty pages.  Called under inode_lock.  The caller has
+ * ref on the inode (either via __iget or via syscall against an fd).
  */
 static int
-__writeback_single_inode(struct inode *inode,
-			struct writeback_control *wbc)
+__writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 {
 	wait_queue_head_t *wqh;
 
+	WARN_ON(!atomic_read(&inode->i_count));
+
 	if ((wbc->sync_mode != WB_SYNC_ALL) && (inode->i_state & I_LOCK)) {
 		list_move(&inode->i_list, &inode->i_sb->s_dirty);
 		return 0;
@@ -259,11 +261,9 @@ __writeback_single_inode(struct inode *i
 
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
@@ -541,14 +541,15 @@ void sync_inodes(int wait)
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
+ * The caller must have a ref on the inode.
  */
- 
 int write_inode_now(struct inode *inode, int sync)
 {
 	int ret;
_

