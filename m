Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315171AbSGDXrV>; Thu, 4 Jul 2002 19:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315239AbSGDXq4>; Thu, 4 Jul 2002 19:46:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37133 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315171AbSGDXqA>;
	Thu, 4 Jul 2002 19:46:00 -0400
Message-ID: <3D24E02E.82839D0@zip.com.au>
Date: Thu, 04 Jul 2002 16:54:22 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 11/27] add new list_splice_init()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



A little cleanup: Most callers of list_splice() immediately
reinitialise the source list_head after calling list_splice().

So create a new list_splice_init() which does all that.




 drivers/block/ll_rw_blk.c        |    3 +--
 drivers/ieee1394/ieee1394_core.c |    3 +--
 fs/fs-writeback.c                |   14 +++++---------
 fs/jfs/jfs_txnmgr.c              |    5 +----
 fs/mpage.c                       |   14 +++++---------
 fs/nfs/write.c                   |    3 +--
 include/linux/list.h             |   36 ++++++++++++++++++++++++++++--------
 7 files changed, 42 insertions(+), 36 deletions(-)

--- 2.5.24/drivers/block/ll_rw_blk.c~list_splice_init	Thu Jul  4 16:17:16 2002
+++ 2.5.24-akpm/drivers/block/ll_rw_blk.c	Thu Jul  4 16:17:16 2002
@@ -964,8 +964,7 @@ void blk_run_queues(void)
 		return;
 	}
 
-	list_splice(&blk_plug_list, &local_plug_list);
-	INIT_LIST_HEAD(&blk_plug_list);
+	list_splice_init(&blk_plug_list, &local_plug_list);
 	spin_unlock_irq(&blk_plug_lock);
 	
 	while (!list_empty(&local_plug_list)) {
--- 2.5.24/drivers/ieee1394/ieee1394_core.c~list_splice_init	Thu Jul  4 16:17:16 2002
+++ 2.5.24-akpm/drivers/ieee1394/ieee1394_core.c	Thu Jul  4 16:17:16 2002
@@ -740,8 +740,7 @@ void abort_requests(struct hpsb_host *ho
         host->ops->devctl(host, CANCEL_REQUESTS, 0);
 
         spin_lock_irqsave(&host->pending_pkt_lock, flags);
-        list_splice(&host->pending_packets, &llist);
-        INIT_LIST_HEAD(&host->pending_packets);
+        list_splice_init(&host->pending_packets, &llist);
         spin_unlock_irqrestore(&host->pending_pkt_lock, flags);
 
         list_for_each(lh, &llist) {
--- 2.5.24/fs/fs-writeback.c~list_splice_init	Thu Jul  4 16:17:16 2002
+++ 2.5.24-akpm/fs/fs-writeback.c	Thu Jul  4 16:17:16 2002
@@ -220,8 +220,7 @@ static void sync_sb_inodes(struct super_
 	struct list_head *head;
 	const unsigned long start = jiffies;	/* livelock avoidance */
 
-	list_splice(&sb->s_dirty, &sb->s_io);
-	INIT_LIST_HEAD(&sb->s_dirty);
+	list_splice_init(&sb->s_dirty, &sb->s_io);
 	head = &sb->s_io;
 	while ((tmp = head->prev) != head) {
 		struct inode *inode = list_entry(tmp, struct inode, i_list);
@@ -262,13 +261,10 @@ static void sync_sb_inodes(struct super_
 			break;
 	}
 out:
-	if (!list_empty(&sb->s_io)) {
-		/*
-		 * Put the rest back, in the correct order.
-		 */
-		list_splice(&sb->s_io, sb->s_dirty.prev);
-		INIT_LIST_HEAD(&sb->s_io);
-	}
+	/*
+	 * Put the rest back, in the correct order.
+	 */
+	list_splice_init(&sb->s_io, sb->s_dirty.prev);
 	return;
 }
 
--- 2.5.24/fs/mpage.c~list_splice_init	Thu Jul  4 16:17:16 2002
+++ 2.5.24-akpm/fs/mpage.c	Thu Jul  4 16:22:10 2002
@@ -490,8 +490,7 @@ mpage_writepages(struct address_space *m
 
 	write_lock(&mapping->page_lock);
 
-	list_splice(&mapping->dirty_pages, &mapping->io_pages);
-	INIT_LIST_HEAD(&mapping->dirty_pages);
+	list_splice_init(&mapping->dirty_pages, &mapping->io_pages);
 
         while (!list_empty(&mapping->io_pages) && !done) {
 		struct page *page = list_entry(mapping->io_pages.prev,
@@ -538,13 +537,10 @@ mpage_writepages(struct address_space *m
 		page_cache_release(page);
 		write_lock(&mapping->page_lock);
 	}
-	if (!list_empty(&mapping->io_pages)) {
-		/*
-		 * Put the rest back, in the correct order.
-		 */
-		list_splice(&mapping->io_pages, mapping->dirty_pages.prev);
-		INIT_LIST_HEAD(&mapping->io_pages);
-	}
+	/*
+	 * Put the rest back, in the correct order.
+	 */
+	list_splice_init(&mapping->io_pages, mapping->dirty_pages.prev);
 	write_unlock(&mapping->page_lock);
 	if (bio)
 		mpage_bio_submit(WRITE, bio);
--- 2.5.24/fs/jfs/jfs_txnmgr.c~list_splice_init	Thu Jul  4 16:17:16 2002
+++ 2.5.24-akpm/fs/jfs/jfs_txnmgr.c	Thu Jul  4 16:17:16 2002
@@ -2975,10 +2975,7 @@ int jfs_sync(void)
 			}
 		}
 		/* Add anon_list2 back to anon_list */
-		if (!list_empty(&TxAnchor.anon_list2)) {
-			list_splice(&TxAnchor.anon_list2, &TxAnchor.anon_list);
-			INIT_LIST_HEAD(&TxAnchor.anon_list2);
-		}
+		list_splice_init(&TxAnchor.anon_list2, &TxAnchor.anon_list);
 		add_wait_queue(&jfs_sync_thread_wait, &wq);
 		set_current_state(TASK_INTERRUPTIBLE);
 		TXN_UNLOCK();
--- 2.5.24/fs/nfs/write.c~list_splice_init	Thu Jul  4 16:17:16 2002
+++ 2.5.24-akpm/fs/nfs/write.c	Thu Jul  4 16:17:16 2002
@@ -1110,8 +1110,7 @@ nfs_commit_rpcsetup(struct list_head *he
 	/* Set up the RPC argument and reply structs
 	 * NB: take care not to mess about with data->commit et al. */
 
-	list_splice(head, &data->pages);
-	INIT_LIST_HEAD(head);
+	list_splice_init(head, &data->pages);
 	first = nfs_list_entry(data->pages.next);
 	last = nfs_list_entry(data->pages.prev);
 	inode = first->wb_inode;
--- 2.5.24/include/linux/list.h~list_splice_init	Thu Jul  4 16:17:16 2002
+++ 2.5.24-akpm/include/linux/list.h	Thu Jul  4 16:17:16 2002
@@ -136,6 +136,19 @@ static inline int list_empty(list_t *hea
 	return head->next == head;
 }
 
+static inline void __list_splice(list_t *list, list_t *head)
+{
+	list_t *first = list->next;
+	list_t *last = list->prev;
+	list_t *at = head->next;
+
+	first->prev = head;
+	head->next = first;
+
+	last->next = at;
+	at->prev = last;
+}
+
 /**
  * list_splice - join two lists
  * @list: the new list to add.
@@ -145,15 +158,22 @@ static inline void list_splice(list_t *l
 {
 	list_t *first = list->next;
 
-	if (first != list) {
-		list_t *last = list->prev;
-		list_t *at = head->next;
-
-		first->prev = head;
-		head->next = first;
+	if (first != list)
+		__list_splice(list, head);
+}
 
-		last->next = at;
-		at->prev = last;
+/**
+ * list_splice_init - join two lists and reinitialise the emptied list.
+ * @list: the new list to add.
+ * @head: the place to add it in the first list.
+ *
+ * The list at @list is reinitialised
+ */
+static inline void list_splice_init(list_t *list, list_t *head)
+{
+	if (!list_empty(list)) {
+		__list_splice(list, head);
+		INIT_LIST_HEAD(list);
 	}
 }
 

-
