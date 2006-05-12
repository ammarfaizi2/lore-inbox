Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbWELGIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbWELGIV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 02:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbWELGIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 02:08:19 -0400
Received: from ns1.suse.de ([195.135.220.2]:48546 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750942AbWELGHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 02:07:54 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 12 May 2006 16:07:36 +1000
Message-Id: <1060512060736.8006@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       Paul Clements <paul.clements@steeleye.com>
Subject: [PATCH 002 of 8] md/bitmap: Remove bitmap writeback daemon.
References: <20060512160121.7872.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


md/bitmap currently has a separate thread to wait for writes
to the bitmap file to complete (as we cannot get a callback
on that action).
However this isn't needed as bitmap_unplug is called from 
process context and waits for the writeback thread to do it's
work.  The same result can be achieved by doing the waiting
directly in bitmap_unplug.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/bitmap.c         |  115 ++----------------------------------------
 ./include/linux/raid/bitmap.h |    6 --
 2 files changed, 8 insertions(+), 113 deletions(-)

diff ./drivers/md/bitmap.c~current~ ./drivers/md/bitmap.c
--- ./drivers/md/bitmap.c~current~	2006-05-12 15:49:10.000000000 +1000
+++ ./drivers/md/bitmap.c	2006-05-12 15:55:37.000000000 +1000
@@ -7,7 +7,6 @@
  * additions, Copyright (C) 2003-2004, Paul Clements, SteelEye Technology, Inc.:
  * - added disk storage for bitmap
  * - changes to allow various bitmap chunk sizes
- * - added bitmap daemon (to asynchronously clear bitmap bits from disk)
  */
 
 /*
@@ -330,14 +329,13 @@ static int write_page(struct bitmap *bit
 	set_page_dirty(page); /* force it to be written out */
 
 	if (!wait) {
-		/* add to list to be waited for by daemon */
+		/* add to list to be waited for */
 		struct page_list *item = mempool_alloc(bitmap->write_pool, GFP_NOIO);
 		item->page = page;
 		get_page(page);
 		spin_lock(&bitmap->write_lock);
 		list_add(&item->list, &bitmap->complete_pages);
 		spin_unlock(&bitmap->write_lock);
-		md_wakeup_thread(bitmap->writeback_daemon);
 	}
 	return write_one_page(page, wait);
 }
@@ -621,8 +619,6 @@ static void bitmap_file_unmap(struct bit
 	safe_put_page(sb_page);
 }
 
-static void bitmap_stop_daemon(struct bitmap *bitmap);
-
 /* dequeue the next item in a page list -- don't call from irq context */
 static struct page_list *dequeue_page(struct bitmap *bitmap)
 {
@@ -648,8 +644,6 @@ static void drain_write_queues(struct bi
 		put_page(item->page);
 		mempool_free(item, bitmap->write_pool);
 	}
-
-	wake_up(&bitmap->write_wait);
 }
 
 static void bitmap_file_put(struct bitmap *bitmap)
@@ -663,8 +657,6 @@ static void bitmap_file_put(struct bitma
 	bitmap->file = NULL;
 	spin_unlock_irqrestore(&bitmap->lock, flags);
 
-	bitmap_stop_daemon(bitmap);
-
 	drain_write_queues(bitmap);
 
 	bitmap_file_unmap(bitmap);
@@ -770,6 +762,8 @@ static void bitmap_file_set_bit(struct b
 
 }
 
+static void bitmap_writeback(struct bitmap *bitmap);
+
 /* this gets called when the md device is ready to unplug its underlying
  * (slave) device queues -- before we let any writes go down, we need to
  * sync the dirty pages of the bitmap file to disk */
@@ -812,13 +806,9 @@ int bitmap_unplug(struct bitmap *bitmap)
 		}
 	}
 	if (wait) { /* if any writes were performed, we need to wait on them */
-		if (bitmap->file) {
-			spin_lock_irq(&bitmap->write_lock);
-			wait_event_lock_irq(bitmap->write_wait,
-					    list_empty(&bitmap->complete_pages), bitmap->write_lock,
-					    wake_up_process(bitmap->writeback_daemon->tsk));
-			spin_unlock_irq(&bitmap->write_lock);
-		} else
+		if (bitmap->file)
+			bitmap_writeback(bitmap);
+		else
 			md_super_wait(bitmap->mddev);
 	}
 	return 0;
@@ -1126,41 +1116,12 @@ int bitmap_daemon_work(struct bitmap *bi
 	return err;
 }
 
-static void daemon_exit(struct bitmap *bitmap, mdk_thread_t **daemon)
+static void bitmap_writeback(struct bitmap *bitmap)
 {
-	mdk_thread_t *dmn;
-	unsigned long flags;
-
-	/* if no one is waiting on us, we'll free the md thread struct
-	 * and exit, otherwise we let the waiter clean things up */
-	spin_lock_irqsave(&bitmap->lock, flags);
-	if ((dmn = *daemon)) { /* no one is waiting, cleanup and exit */
-		*daemon = NULL;
-		spin_unlock_irqrestore(&bitmap->lock, flags);
-		kfree(dmn);
-		complete_and_exit(NULL, 0); /* do_exit not exported */
-	}
-	spin_unlock_irqrestore(&bitmap->lock, flags);
-}
-
-static void bitmap_writeback_daemon(mddev_t *mddev)
-{
-	struct bitmap *bitmap = mddev->bitmap;
 	struct page *page;
 	struct page_list *item;
 	int err = 0;
 
-	if (signal_pending(current)) {
-		printk(KERN_INFO
-		       "%s: bitmap writeback daemon got signal, exiting...\n",
-		       bmname(bitmap));
-		err = -EINTR;
-		goto out;
-	}
-	if (bitmap == NULL)
-		/* about to be stopped. */
-		return;
-
 	PRINTK("%s: bitmap writeback daemon woke up...\n", bmname(bitmap));
 	/* wait on bitmap page writebacks */
 	while ((item = dequeue_page(bitmap))) {
@@ -1177,59 +1138,9 @@ static void bitmap_writeback_daemon(mdde
 			       "failed (page %lu): %d\n",
 			       bmname(bitmap), page->index, err);
 			bitmap_file_kick(bitmap);
-			goto out;
+			break;
 		}
 	}
- out:
-	wake_up(&bitmap->write_wait);
-	if (err) {
-		printk(KERN_INFO "%s: bitmap writeback daemon exiting (%d)\n",
-		       bmname(bitmap), err);
-		daemon_exit(bitmap, &bitmap->writeback_daemon);
-	}
-}
-
-static mdk_thread_t *bitmap_start_daemon(struct bitmap *bitmap,
-				void (*func)(mddev_t *), char *name)
-{
-	mdk_thread_t *daemon;
-	char namebuf[32];
-
-#ifdef INJECT_FATAL_FAULT_2
-	daemon = NULL;
-#else
-	sprintf(namebuf, "%%s_%s", name);
-	daemon = md_register_thread(func, bitmap->mddev, namebuf);
-#endif
-	if (!daemon) {
-		printk(KERN_ERR "%s: failed to start bitmap daemon\n",
-			bmname(bitmap));
-		return ERR_PTR(-ECHILD);
-	}
-
-	md_wakeup_thread(daemon); /* start it running */
-
-	PRINTK("%s: %s daemon (pid %d) started...\n",
-		bmname(bitmap), name, daemon->tsk->pid);
-
-	return daemon;
-}
-
-static void bitmap_stop_daemon(struct bitmap *bitmap)
-{
-	/* the daemon can't stop itself... it'll just exit instead... */
-	if (bitmap->writeback_daemon && ! IS_ERR(bitmap->writeback_daemon) &&
-	    current->pid != bitmap->writeback_daemon->tsk->pid) {
-		mdk_thread_t *daemon;
-		unsigned long flags;
-
-		spin_lock_irqsave(&bitmap->lock, flags);
-		daemon = bitmap->writeback_daemon;
-		bitmap->writeback_daemon = NULL;
-		spin_unlock_irqrestore(&bitmap->lock, flags);
-		if (daemon && ! IS_ERR(daemon))
-			md_unregister_thread(daemon); /* destroy the thread */
-	}
 }
 
 static bitmap_counter_t *bitmap_get_counter(struct bitmap *bitmap,
@@ -1553,7 +1464,6 @@ int bitmap_create(mddev_t *mddev)
 
 	spin_lock_init(&bitmap->write_lock);
 	INIT_LIST_HEAD(&bitmap->complete_pages);
-	init_waitqueue_head(&bitmap->write_wait);
 	bitmap->write_pool = mempool_create_kmalloc_pool(WRITE_POOL_SIZE,
 						sizeof(struct page_list));
 	err = -ENOMEM;
@@ -1613,15 +1523,6 @@ int bitmap_create(mddev_t *mddev)
 
 	mddev->bitmap = bitmap;
 
-	if (file)
-		/* kick off the bitmap writeback daemon */
-		bitmap->writeback_daemon =
-			bitmap_start_daemon(bitmap,
-					    bitmap_writeback_daemon,
-					    "bitmap_wb");
-
-	if (IS_ERR(bitmap->writeback_daemon))
-		return PTR_ERR(bitmap->writeback_daemon);
 	mddev->thread->timeout = bitmap->daemon_sleep * HZ;
 
 	return bitmap_update_sb(bitmap);

diff ./include/linux/raid/bitmap.h~current~ ./include/linux/raid/bitmap.h
--- ./include/linux/raid/bitmap.h~current~	2006-05-12 15:49:10.000000000 +1000
+++ ./include/linux/raid/bitmap.h	2006-05-12 15:55:37.000000000 +1000
@@ -244,13 +244,7 @@ struct bitmap {
 	unsigned long daemon_lastrun; /* jiffies of last run */
 	unsigned long daemon_sleep; /* how many seconds between updates? */
 
-	/*
-	 * bitmap_writeback_daemon waits for file-pages that have been written,
-	 * as there is no way to get a call-back when a page write completes.
-	 */
-	mdk_thread_t *writeback_daemon;
 	spinlock_t write_lock;
-	wait_queue_head_t write_wait;
 	struct list_head complete_pages;
 	mempool_t *write_pool;
 };
