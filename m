Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130119AbRCBAKy>; Thu, 1 Mar 2001 19:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130124AbRCBAKp>; Thu, 1 Mar 2001 19:10:45 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:12890 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S130119AbRCBAKg>; Thu, 1 Mar 2001 19:10:36 -0500
Message-ID: <3A9EE4D5.73A28296@sgi.com>
Date: Thu, 01 Mar 2001 16:09:57 -0800
From: Rajagopal Ananthanarayanan <ananth@sgi.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16-4SGI_20smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IO Clustering & Delayed allocation
Content-Type: multipart/mixed;
 boundary="------------3016BB8D9446DEFF6F7E03BC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------3016BB8D9446DEFF6F7E03BC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Below is a partial patch to provide hooks so
that IO clustering can be performed by the file-system.
As presented, the same code is used to perform delayed allocation.
There has also been a lot of talk about implementing delayed
allocation. To be clear, delayed allocation means not
immediately allocating disk space on writing the data,
say during a sys_write. Instead, allocation of disk blocks
to logical blocks is done at the time the logical block
needs to be written out.

In the end, it looks like taking care of delayed-allocation
at writepage() is the best way to go. Following is a patch
where buffer-based routines will employ writepage() to do
such conversions. In addition to allocating blocks for a single
buffer or page, extent based filesystems would allocate blocks
for all delayed allocate blocks for the entire extent. These
same hooks can be used for clustering (i.e. pushing out
contiguous on-disk) as well.

Comments, suggestions welcome.

ananth.

-- 
--------------------------------------------------------------------------
Rajagopal Ananthanarayanan ("ananth")
Member Technical Staff, SGI.
--------------------------------------------------------------------------
--------------3016BB8D9446DEFF6F7E03BC
Content-Type: text/plain; charset=us-ascii;
 name="delay-buffer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="delay-buffer.patch"

--- ../../linux-2.4.2/linux/fs/buffer.c	Fri Feb  9 11:29:44 2001
+++ fs/buffer.c	Thu Mar  1 11:02:01 2001
@@ -161,6 +161,40 @@
 	atomic_dec(&bh->b_count);
 }
 
+
+#define buffer_delay_busy(bh) \
+	(test_bit(BH_Delay, &bh->b_state) && bh->b_page && PageLocked(bh->b_page))
+	
+static void
+_write_buffer(struct buffer_head *bh)
+{
+	struct page *page = bh->b_page;
+
+	if (!page || TryLockPage(page)) {
+		if (current->need_resched)
+			schedule();
+		return;
+	}
+	/*
+	 * Raced with someone?
+	 */
+	if (page->buffers != bh || !buffer_delay(bh) || !buffer_dirty(bh)) {
+		UnlockPage(page);
+		return;
+	}
+	page->mapping->a_ops->writepage(page);
+}
+
+static inline void
+write_buffer(struct buffer_head *bh)
+{
+	if (!buffer_delay(bh))
+		ll_rw_block(WRITE, 1, &bh);
+	else
+		_write_buffer(bh);
+}
+
+
 /* Call sync_buffers with wait!=0 to ensure that the call does not
  * return until all buffer writes have completed.  Sync() may return
  * before the writes have finished; fsync() may not.
@@ -232,7 +266,7 @@
 
 			atomic_inc(&bh->b_count);
 			spin_unlock(&lru_list_lock);
-			ll_rw_block(WRITE, 1, &bh);
+			write_buffer(bh);
 			atomic_dec(&bh->b_count);
 			retry = 1;
 			goto repeat;
@@ -507,6 +541,8 @@
 	struct bh_free_head *head = &free_list[BUFSIZE_INDEX(bh->b_size)];
 	struct buffer_head **bhp = &head->list;
 
+	if (test_bit(BH_Delay, &bh->b_state))
+		BUG();
 	bh->b_state = 0;
 
 	spin_lock(&head->lock);
@@ -879,7 +915,7 @@
 			if (buffer_dirty(bh)) {
 				atomic_inc(&bh->b_count);
 				spin_unlock(&lru_list_lock);
-				ll_rw_block(WRITE, 1, &bh);
+				write_buffer(bh);
 				brelse(bh);
 				spin_lock(&lru_list_lock);
 			}
@@ -1394,6 +1430,11 @@
 
 	head = page->buffers;
 	bh = head;
+
+	if (buffer_delay(bh)) {
+		page->mapping->a_ops->writepage_nounlock(page);
+		return 0; /* just started I/O ... likely didn't complete */
+	}
 	do {
 		unsigned int next_off = curr_off + bh->b_size;
 		next = bh->b_this_page;
@@ -2334,7 +2375,7 @@
 			if (wait > 1)
 				__wait_on_buffer(p);
 		} else if (buffer_dirty(p))
-			ll_rw_block(WRITE, 1, &p);
+			write_buffer(p);
 	} while (tmp != bh);
 }
 
@@ -2361,6 +2402,11 @@
 	int index = BUFSIZE_INDEX(bh->b_size);
 	int loop = 0;
 
+	if (buffer_delay(bh)) {
+		if (wait)
+			page->mapping->a_ops->writepage_nounlock(page);
+		return 0; /* just started I/O ... likely didn't complete */
+	}
 cleaned_buffers_try_again:
 	spin_lock(&lru_list_lock);
 	write_lock(&hash_table_lock);
@@ -2562,7 +2608,7 @@
 			__refile_buffer(bh);
 			continue;
 		}
-		if (buffer_locked(bh))
+		if (buffer_locked(bh) || buffer_delay_busy(bh))
 			continue;
 
 		if (check_flushtime) {
@@ -2580,7 +2626,7 @@
 		/* OK, now we are committed to write it out. */
 		atomic_inc(&bh->b_count);
 		spin_unlock(&lru_list_lock);
-		ll_rw_block(WRITE, 1, &bh);
+		write_buffer(bh);
 		atomic_dec(&bh->b_count);
 
 		if (current->need_resched)

--------------3016BB8D9446DEFF6F7E03BC--

