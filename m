Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131117AbQLVAgI>; Thu, 21 Dec 2000 19:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130509AbQLVAf7>; Thu, 21 Dec 2000 19:35:59 -0500
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:6409 "EHLO
	anduin.gondor.com") by vger.kernel.org with ESMTP
	id <S131117AbQLVAfr>; Thu, 21 Dec 2000 19:35:47 -0500
Date: Fri, 22 Dec 2000 01:03:35 +0100
From: Jan Niehusmann <jan@gondor.com>
To: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
        adilger@turbolinux.com, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Re: fs corruption with invalidate_buffers()
Message-ID: <20001222010334.A984@gondor.com>
In-Reply-To: <3A300933.29813DE8@Hell.WH8.TU-Dresden.De> <Pine.GSO.4.21.0012071718330.22281-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0012071718330.22281-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Dec 07, 2000 at 05:26:46PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The file corruption I reported on Dec 6 is still there in test13-pre3.
(I can only reproduce it easily with the ext2 online resizing patches,
but I really don't think it is caused by them)

The corruption happens if invalidate_buffers calls put_last_free() on
buffers that belong to mapped pages. These pages remain valid and may 
get used later, while the buffers are marked free and may be reused
by something completely different, immediately causing corruption.

I changed my patch for the problem according to the following advice by
Al Viro:

On Thu, Dec 07, 2000 at 05:26:46PM -0500, Alexander Viro wrote:
> That invalidate_buffers() should leave the unhashed ones alone. If it can't
> be found via getblk() - just leave it as is.
> 
> IOW, let it skip bh if (bh->b_next == NULL && !destroy_dirty_buffers).
> No warnings needed - it's a normal situation.

This is the result - against test12-pre7, but works well with 
test13-pre3:


--- linux-2.4.0-test12-pre7-jn/fs/buffer.c.orig	Fri Dec  8 14:59:28 2000
+++ linux-2.4.0-test12-pre7-jn/fs/buffer.c	Fri Dec  8 15:05:11 2000
@@ -502,6 +502,10 @@
 	struct bh_free_head *head = &free_list[BUFSIZE_INDEX(bh->b_size)];
 	struct buffer_head **bhp = &head->list;
 
+	if(bh->b_page && bh->b_page->mapping) {
+		panic("put_last_free() on mapped buffer!");
+	}
+
 	bh->b_state = 0;
 
 	spin_lock(&head->lock);
@@ -652,7 +656,8 @@
 
 			write_lock(&hash_table_lock);
 			if (!atomic_read(&bh->b_count) &&
-			    (destroy_dirty_buffers || !buffer_dirty(bh))) {
+			    (destroy_dirty_buffers || 
+			      (!buffer_dirty(bh) && bh->b_next!=0) )) {
 				remove_inode_queue(bh);
 				__remove_from_queues(bh);
 				put_last_free(bh);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
