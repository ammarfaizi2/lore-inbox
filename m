Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317600AbSGJUQz>; Wed, 10 Jul 2002 16:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317601AbSGJUQy>; Wed, 10 Jul 2002 16:16:54 -0400
Received: from [195.223.140.120] ([195.223.140.120]:2075 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317600AbSGJUQv>; Wed, 10 Jul 2002 16:16:51 -0400
Date: Wed, 10 Jul 2002 22:20:36 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, "Carter K. George" <carter@polyserve.com>,
       Don Norton <djn@polyserve.com>, "James S. Tybur" <jtybur@polyserve.com>
Subject: fsync fixes for 2.4
Message-ID: <20020710202036.GA1342@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At polyserve they found a severe problem with fsync in 2.4.

In short the write_buffer (ll_rw_block of mainline) is a noop if old I/O
is in flight. You know the buffer can be made dirty while I/O is in
flight, and in such case fsync would return without flushing the dirty
buffers at all. Their proposed fix is strightforward, just a
wait_on_buffer before the ll_rw_block will guarantee somebody marked the
bh locked _after_ we wrote to it. This may actually decrease performance
because we would wait in the middle of the flushes, but if the dirty
inodes are just getting written under us, probably bdflush/kupdate are
just keeping the I/O pipeline filled, and the wait_on_buffer blockage
shouldn't be a common case (don't see any difference in some basic
test, bandwitdth is fully used).  If it sorts out to be a problem with
my new infrastructure (see below) it should be easy to do the
ll_rw_block during the second pass.

The other part of the patch was related to the fact the whole fsync has
to be running inside the i_sem, so there cannot be writes, truncates or
other parallel fsyncs, but there can be writepages in background that
will mark the buffers dirty for example during get_block(create). So it
is also possible the buffer is marked dirty while it's in the private
tmp "fsync" list. The original patch according to the commentary was
trying to detect a dirty buffer during the second pass and to put it
back into the inode dirty list if it was dirty (using refile_buffer btw,
that won't do that and it was a noop in that sense), but that's not
needed because the insert_inode_queue functions are always reinserting
the bh into the inode, so as soon as the buffer will be marked dirty it
will go automatically back into the main inode dirty list. And as said
refile_buffer could do nothing like that anyways, so I just rejected
that part.

To make an example what will happen is that we flush the bh, so it's
only locked and we put it into the private local list. Then before we
wait on it in the second pass on the private local list, it is marked
dirty and it goes back into the inode list under us. but that's not a
problem because it's locked and we'll wait for it later in the expensive
third and last osync pass (this is also mentioned in the last commentary
for fsync_buffers_list). I guess either the osync third-pass or the
uncoditional rolling of the bh every time it's marked dirty are been
overlooked.

However I really didn't liked the unconditional rolling of the bh into
the inode list every time it is marked dirty, nor I liked the osync pass
that can generate indefinite wait of fsync, so I changed some bit in
that area also considering the bh->b_inode cannot change until somebody
runs remove_inode_queue(bh).

Now it should be a bit more efficient during writebacks (no cacheline
trahsing every time we overwrite a data or metadata bh just dirty in
cache) and we'll skip the osync pass. osync_buffers_list stays there in
case anybody will want to use it (even if it's not exported at this
time).  If "somebody" just submits the bh itself, so it only cares to
wait for locked buffers, and never to flush dirty buffers, he can use
the osync_buffers_list. See the inode.c comments in generic_osync_inode
to know why nobody is using it now (in short nobody is submitting the bh
directly, they just mark the bh dirty and then we write them during the
generic_osync_inode that calls ours fsync_buffers_list, that now is
smart enough not to need the expensive osync).

last but not the least while overviewing this code I also noticed fsync
writes the buffers backwards which is not the best for most harddisks.

All of this is fixed by this patch against 2.4.19rc1. 

Comments?

diff -urNp 2.4.19rc1/fs/buffer.c z/fs/buffer.c
--- 2.4.19rc1/fs/buffer.c	Fri Jul  5 12:20:47 2002
+++ z/fs/buffer.c	Wed Jul 10 20:52:41 2002
@@ -587,20 +587,20 @@ struct buffer_head * get_hash_table(kdev
 void buffer_insert_inode_queue(struct buffer_head *bh, struct inode *inode)
 {
 	spin_lock(&lru_list_lock);
-	if (bh->b_inode)
-		list_del(&bh->b_inode_buffers);
-	bh->b_inode = inode;
-	list_add(&bh->b_inode_buffers, &inode->i_dirty_buffers);
+	if (!bh->b_inode) {
+		bh->b_inode = inode;
+		list_add(&bh->b_inode_buffers, &inode->i_dirty_buffers);
+	}
 	spin_unlock(&lru_list_lock);
 }
 
 void buffer_insert_inode_data_queue(struct buffer_head *bh, struct inode *inode)
 {
 	spin_lock(&lru_list_lock);
-	if (bh->b_inode)
-		list_del(&bh->b_inode_buffers);
-	bh->b_inode = inode;
-	list_add(&bh->b_inode_buffers, &inode->i_dirty_data_buffers);
+	if (!bh->b_inode) {
+		bh->b_inode = inode;
+		list_add(&bh->b_inode_buffers, &inode->i_dirty_data_buffers);
+	}
 	spin_unlock(&lru_list_lock);
 }
 
@@ -819,37 +819,40 @@ inline void set_buffer_async_io(struct b
  * forever if somebody is actively writing to the file.
  *
  * Do this in two main stages: first we copy dirty buffers to a
- * temporary inode list, queueing the writes as we go.  Then we clean
+ * temporary list, queueing the writes as we go.  Then we clean
  * up, waiting for those writes to complete.
  * 
  * During this second stage, any subsequent updates to the file may end
- * up refiling the buffer on the original inode's dirty list again, so
- * there is a chance we will end up with a buffer queued for write but
- * not yet completed on that list.  So, as a final cleanup we go through
- * the osync code to catch these locked, dirty buffers without requeuing
- * any newly dirty buffers for write.
+ * up marking some of our private bh dirty, so we must refile them
+ * into the original inode's dirty list again during the second stage.
  */
 int fsync_buffers_list(struct list_head *list)
 {
 	struct buffer_head *bh;
-	struct inode tmp;
-	int err = 0, err2;
-	
-	INIT_LIST_HEAD(&tmp.i_dirty_buffers);
+	int err = 0;
 	
+	LIST_HEAD(tmp);
 	spin_lock(&lru_list_lock);
 
 	while (!list_empty(list)) {
-		bh = BH_ENTRY(list->next);
+		bh = BH_ENTRY(list->prev);
 		list_del(&bh->b_inode_buffers);
 		if (!buffer_dirty(bh) && !buffer_locked(bh))
 			bh->b_inode = NULL;
 		else {
-			bh->b_inode = &tmp;
-			list_add(&bh->b_inode_buffers, &tmp.i_dirty_buffers);
+			list_add(&bh->b_inode_buffers, &tmp);
 			if (buffer_dirty(bh)) {
 				get_bh(bh);
 				spin_unlock(&lru_list_lock);
+				/*
+				 * Wait I/O completion before submitting
+				 * the buffer, to be sure the write will
+				 * be effective on the latest data in
+				 * the buffer. (otherwise - if there's old
+				 * I/O in flight - write_buffer would become
+				 * a noop)
+				 */
+				wait_on_buffer(bh);
 				ll_rw_block(WRITE, 1, &bh);
 				brelse(bh);
 				spin_lock(&lru_list_lock);
@@ -857,9 +860,20 @@ int fsync_buffers_list(struct list_head 
 		}
 	}
 
-	while (!list_empty(&tmp.i_dirty_buffers)) {
-		bh = BH_ENTRY(tmp.i_dirty_buffers.prev);
-		remove_inode_queue(bh);
+	while (!list_empty(&tmp)) {
+		bh = BH_ENTRY(tmp.prev);
+		list_del(&bh->b_inode_buffers);
+		/*
+		 * If the buffer is been made dirty again
+		 * during the fsync (for example from a ->writepage
+		 * that doesn't take the i_sem), just make sure not
+		 * to lose track of it, put it back the buffer into
+		 * its inode queue.
+		 */
+		if (!buffer_dirty(bh))
+			bh->b_inode = NULL;
+		else
+			list_add(&bh->b_inode_buffers, &bh->b_inode->i_dirty_buffers);
 		get_bh(bh);
 		spin_unlock(&lru_list_lock);
 		wait_on_buffer(bh);
@@ -870,12 +884,8 @@ int fsync_buffers_list(struct list_head 
 	}
 	
 	spin_unlock(&lru_list_lock);
-	err2 = osync_buffers_list(list);
 
-	if (err)
-		return err;
-	else
-		return err2;
+	return err;
 }
 
 /*
@@ -887,6 +897,10 @@ int fsync_buffers_list(struct list_head 
  * you dirty the buffers, and then use osync_buffers_list to wait for
  * completion.  Any other dirty buffers which are not yet queued for
  * write will not be flushed to disk by the osync.
+ *
+ * Nobody uses this functionality right now because everybody marks the bh
+ * dirty and then use fsync_buffers_list() to first flush them and then
+ * wait completion on them. (see inode.c generic_osync_inode for more details)
  */
 static int osync_buffers_list(struct list_head *list)
 {

Andrea
