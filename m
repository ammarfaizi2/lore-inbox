Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbTHZDT5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 23:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbTHZDT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 23:19:57 -0400
Received: from dp.samba.org ([66.70.73.150]:48851 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262499AbTHZDTk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 23:19:40 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@zip.com.au, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Futex non-page-pinning fix
Date: Tue, 26 Aug 2003 13:12:14 +1000
Message-Id: <20030826031940.0CDDD2C243@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Ingo,

	Ingo was (rightfully) concerned about the amount of memory
which could be pinned using FUTEX_FD.  This solution doesn't keep
pages pinned any more: it hashes on mapping + offset, or for anonomous
pages, uses a callback to move them out and back into the hash table
as they are swapped out and in.

	Searching the (256-bucket) hash table to find potential pages
is fairly slow, but we're swapping anyway, so it's lost in the noise.
The hash table is usually fairly empty.

	My only concern is for a race between swapping a page in and
it being accessed, but I think I have the callbacks in the right place
in the swap code: more VM-aware eyes welcome.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Futexes without pinning pages
Author: Rusty Russell
Status: Tested on 2.6.0-test4-bk2
Depends: Misc/futex-minor-tweaks.patch.gz
Depends: Misc/qemu-page-offset.patch.gz

D: Avoid pinning pages with futexes in them, to resolve FUTEX_FD DoS.
D: For file-backed mappings, change hash to use page->mapping and
D: page->index, which should uniquely identify each one.  For
D: anonymous mappings, insert callbacks in swap code to unhash them
D: when they are swapped out and rehash them when they are swapped
D: back in.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24048-2.6.0-test4-bk2-futex-swap.pre/include/linux/futex.h .24048-2.6.0-test4-bk2-futex-swap/include/linux/futex.h
--- .24048-2.6.0-test4-bk2-futex-swap.pre/include/linux/futex.h	2003-05-27 15:02:21.000000000 +1000
+++ .24048-2.6.0-test4-bk2-futex-swap/include/linux/futex.h	2003-08-26 12:43:19.000000000 +1000
@@ -17,4 +17,7 @@ asmlinkage long sys_futex(u32 __user *ua
 long do_futex(unsigned long uaddr, int op, int val,
 		unsigned long timeout, unsigned long uaddr2, int val2);
 
+/* For mm/page_io.c to tell us about swapping of (anonymous) pages. */
+extern void futex_swap_out(struct page *page);
+extern void futex_swap_in(struct page *page);
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24048-2.6.0-test4-bk2-futex-swap.pre/kernel/futex.c .24048-2.6.0-test4-bk2-futex-swap/kernel/futex.c
--- .24048-2.6.0-test4-bk2-futex-swap.pre/kernel/futex.c	2003-08-26 12:43:18.000000000 +1000
+++ .24048-2.6.0-test4-bk2-futex-swap/kernel/futex.c	2003-08-26 12:43:19.000000000 +1000
@@ -52,14 +52,17 @@ struct futex_q {
 	/* the virtual => physical COW-safe cache */
 	vcache_t vcache;
 
+	/* When anonymous memory swapped out, this stores the index. */
+	unsigned long swap_index;
+
 	/* For fd, sigio sent using these. */
 	int fd;
 	struct file *filp;
 };
 
-/* The key for the hash is the address + index + offset within page */
 static struct list_head futex_queues[1<<FUTEX_HASHBITS];
 static spinlock_t futex_lock = SPIN_LOCK_UNLOCKED;
+static LIST_HEAD(futex_swapped);
 
 extern void send_sigio(struct fown_struct *fown, int fd, int band);
 
@@ -84,13 +87,62 @@ static inline void unlock_futex_mm(void)
 	spin_unlock(&current->mm->page_table_lock);
 }
 
-/*
- * The physical page is shared, so we can hash on its address:
+/* For pages which are file backed, we can simply hash by mapping and
+ * index.  For anonymous regions, we hash by the actual struct page *,
+ * and move them in and out of the hash if they are swapped out.
  */
 static inline struct list_head *hash_futex(struct page *page, int offset)
 {
-	return &futex_queues[hash_long((unsigned long)page + offset,
-							FUTEX_HASHBITS)];
+	unsigned long hashin;
+	if (page->mapping)
+		hashin = (unsigned long)page->mapping + page->index;
+	else
+		hashin = (unsigned long)page;
+
+	return &futex_queues[hash_long(hashin+offset, FUTEX_HASHBITS)];
+}
+
+/* Called when we're going to swap this page out. */
+void futex_swap_out(struct page *page)
+{
+	unsigned int i;
+
+	/* It should have the mapping (== &swapper_space) and index
+	 * set by now */
+ 	BUG_ON(!page->mapping);
+
+	spin_lock(&futex_lock);
+	for (i = 0; i < 1 << FUTEX_HASHBITS; i++) {
+		struct list_head *l, *next;
+		list_for_each_safe(l, next, &futex_queues[i]) {
+			struct futex_q *q = list_entry(l, struct futex_q,list);
+			if (q->page == page) {
+				list_del(&q->list);
+				q->swap_index = page->index;
+				q->page = NULL;
+				list_add(&q->list, &futex_swapped);
+			}
+		}
+	}
+	spin_unlock(&futex_lock);
+}
+
+/* Called when we're going to swap this page in. */
+void futex_swap_in(struct page *page)
+{
+	struct list_head *l, *next;
+
+	spin_lock(&futex_lock);
+	list_for_each_safe(l, next, &futex_swapped) {
+		struct futex_q *q = list_entry(l, struct futex_q, list);
+
+		if (q->swap_index == page->index) {
+			list_del(&q->list);
+			q->page = page;
+			list_add(&q->list, hash_futex(q->page, q->offset));
+		}
+	}
+	spin_unlock(&futex_lock);
 }
 
 /*
@@ -201,10 +253,8 @@ static void futex_vcache_callback(vcache
 	spin_lock(&futex_lock);
 
 	if (!list_empty(&q->list)) {
-		put_page(q->page);
-		q->page = new_page;
-		__pin_page_atomic(new_page);
 		list_del(&q->list);
+		q->page = new_page;
 		list_add_tail(&q->list, head);
 	}
 
@@ -246,8 +296,6 @@ static inline int futex_requeue(unsigned
 					send_sigio(&this->filp->f_owner,
 							this->fd, POLL_IN);
 			} else {
-				put_page(this->page);
-				__pin_page_atomic (page2);
 				list_add_tail(i, head2);
 				__attach_vcache(&this->vcache, uaddr2,
 					current->mm, futex_vcache_callback);
@@ -331,18 +379,19 @@ static inline int futex_wait(unsigned lo
 	 */
 	if (get_user(curval, (int *)uaddr) != 0) {
 		ret = -EFAULT;
-		goto unlock;
+		goto putpage;
 	}
 		
 	if (curval != val) {
 		ret = -EWOULDBLOCK;
-		goto unlock;
+		goto putpage;
 	}
 
 	__queue_me(&q, page, uaddr, offset, -1, NULL);
 	add_wait_queue(&q.waiters, &wait);
 	set_current_state(TASK_INTERRUPTIBLE);
 	unlock_futex_mm();
+	put_page(page);
 
 	time = schedule_timeout(time);
 
@@ -361,9 +410,10 @@ static inline int futex_wait(unsigned lo
 	else
 		ret = -EINTR;
 
-	put_page(q.page);
 	return ret;
 
+putpage:
+	put_page(page);
 unlock:
 	unlock_futex_mm();
 	return ret;
@@ -374,7 +424,6 @@ static int futex_close(struct inode *ino
 	struct futex_q *q = filp->private_data;
 
 	unqueue_me(q);
-	put_page(q->page);
 	kfree(filp->private_data);
 	return 0;
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24048-2.6.0-test4-bk2-futex-swap.pre/mm/page_io.c .24048-2.6.0-test4-bk2-futex-swap/mm/page_io.c
--- .24048-2.6.0-test4-bk2-futex-swap.pre/mm/page_io.c	2003-02-07 19:18:58.000000000 +1100
+++ .24048-2.6.0-test4-bk2-futex-swap/mm/page_io.c	2003-08-26 12:43:19.000000000 +1000
@@ -19,6 +19,7 @@
 #include <linux/buffer_head.h>	/* for block_sync_page() */
 #include <linux/mpage.h>
 #include <linux/writeback.h>
+#include <linux/futex.h>
 #include <asm/pgtable.h>
 
 static struct bio *
@@ -77,6 +78,7 @@ static int end_swap_bio_read(struct bio 
 		ClearPageUptodate(page);
 	} else {
 		SetPageUptodate(page);
+		futex_swap_in(page);
 	}
 	unlock_page(page);
 	bio_put(bio);
@@ -105,6 +107,7 @@ int swap_writepage(struct page *page, st
 	}
 	inc_page_state(pswpout);
 	SetPageWriteback(page);
+	futex_swap_out(page);
 	unlock_page(page);
 	submit_bio(WRITE, bio);
 out:
