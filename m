Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLAOtT>; Fri, 1 Dec 2000 09:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129226AbQLAOtJ>; Fri, 1 Dec 2000 09:49:09 -0500
Received: from odo.scot.redhat.com ([195.89.149.241]:4847 "EHLO
	spock.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S129183AbQLAOs4>; Fri, 1 Dec 2000 09:48:56 -0500
Date: Fri, 1 Dec 2000 14:16:59 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Alexander Viro <viro@math.psu.edu>, Jonathan Hudson <jonathan@daria.co.uk>,
        linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: corruption
Message-ID: <20001201141659.A4562@redhat.com>
In-Reply-To: <b09.3a269edc.6bd12@trespassersw.daria.co.uk> <Pine.GSO.4.21.0011301400290.20801-100000@weyl.math.psu.edu> <3A26C82D.26267202@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A26C82D.26267202@uow.edu.au>; from andrewm@uow.edu.au on Fri, Dec 01, 2000 at 08:35:41AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Dec 01, 2000 at 08:35:41AM +1100, Andrew Morton wrote:
> 
> I bet this'll catch it:
> 
>  static __inline__ void list_del(struct list_head *entry)
>  {
>  	__list_del(entry->prev, entry->next);
> +	entry->next = entry->prev = 0;
>  }

No, because the buffer hash list is never referenced unless
buffer->b_inode is non-null, so we can't ever do a double-list_del on
the buffer.

The patch below should fix it.  It has been sent to Linus.  The
important part is the first hunk of the inode.c diff.

Cheers,
 Stephen

fsync-fix2.diff:
--- fs/buffer.c.~1~	Wed Nov 29 15:16:43 2000
+++ fs/buffer.c	Fri Dec  1 00:41:28 2000
@@ -871,10 +871,11 @@
 		else {
 			bh->b_inode = &tmp;
 			list_add(&bh->b_inode_buffers, &tmp.i_dirty_buffers);
-			atomic_inc(&bh->b_count);
 			if (buffer_dirty(bh)) {
+				atomic_inc(&bh->b_count);
 				spin_unlock(&lru_list_lock);
 				ll_rw_block(WRITE, 1, &bh);
+				brelse(bh);
 				spin_lock(&lru_list_lock);
 			}
 		}
@@ -883,6 +884,7 @@
 	while (!list_empty(&tmp.i_dirty_buffers)) {
 		bh = BH_ENTRY(tmp.i_dirty_buffers.prev);
 		remove_inode_queue(bh);
+		atomic_inc(&bh->b_count);
 		spin_unlock(&lru_list_lock);
 		wait_on_buffer(bh);
 		if (!buffer_uptodate(bh))
@@ -929,9 +931,9 @@
 			atomic_inc(&bh->b_count);
 			spin_unlock(&lru_list_lock);
 			wait_on_buffer(bh);
-			brelse(bh);
 			if (!buffer_uptodate(bh))
 				err = -EIO;
+			brelse(bh);
 			spin_lock(&lru_list_lock);
 			goto repeat;
 		}
--- fs/inode.c.~1~	Wed Nov 29 15:16:43 2000
+++ fs/inode.c	Fri Dec  1 00:40:26 2000
@@ -77,7 +77,13 @@
 
 #define alloc_inode() \
 	 ((struct inode *) kmem_cache_alloc(inode_cachep, SLAB_KERNEL))
-#define destroy_inode(inode) kmem_cache_free(inode_cachep, (inode))
+static void destroy_inode(struct inode *inode) 
+{
+	if (!list_empty(&inode->i_dirty_buffers))
+		BUG();
+	kmem_cache_free(inode_cachep, (inode));
+}
+
 
 /*
  * These are initializations that only need to be done
@@ -348,6 +354,12 @@
  
 void clear_inode(struct inode *inode)
 {
+	if (!list_empty(&inode->i_dirty_buffers)) {
+		if (inode->i_nlink)
+			BUG();
+		invalidate_inode_buffers(inode);
+	}
+       
 	if (inode->i_data.nrpages)
 		BUG();
 	if (!(inode->i_state & I_FREEING))
@@ -407,6 +419,7 @@
 		inode = list_entry(tmp, struct inode, i_list);
 		if (inode->i_sb != sb)
 			continue;
+		invalidate_inode_buffers(inode);
 		if (!atomic_read(&inode->i_count)) {
 			list_del(&inode->i_hash);
 			INIT_LIST_HEAD(&inode->i_hash);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
