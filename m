Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267785AbUH1UWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267785AbUH1UWj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 16:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268041AbUH1UUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 16:20:42 -0400
Received: from holomorphy.com ([207.189.100.168]:937 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267785AbUH1UIn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 16:08:43 -0400
Date: Sat, 28 Aug 2004 13:08:41 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [2/5] consolidate bit waiting code patterns
Message-ID: <20040828200841.GT5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20040828200549.GR5492@holomorphy.com> <20040828200659.GS5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828200659.GS5492@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 01:06:59PM -0700, William Lee Irwin III wrote:
> Move waitqueue -related functions not needing static functions in
> sched.c to kernel/wait.c

Eliminate specialized page and bh waitqueue hashing structures in favor
of a standardized structure, using wake_up_bit() to wake waiters using
the standardized wait_bit_key structure.

Index: wait-2.6.9-rc1-mm1/fs/buffer.c
===================================================================
--- wait-2.6.9-rc1-mm1.orig/fs/buffer.c	2004-08-28 09:43:30.305969176 -0700
+++ wait-2.6.9-rc1-mm1/fs/buffer.c	2004-08-28 09:47:21.232862952 -0700
@@ -43,26 +43,6 @@
 
 #define BH_ENTRY(list) list_entry((list), struct buffer_head, b_assoc_buffers)
 
-struct bh_wait_queue {
-	struct buffer_head *bh;
-	wait_queue_t wait;
-};
-
-#define __DEFINE_BH_WAIT(name, b, f)					\
-	struct bh_wait_queue name = {					\
-		.bh	= b,						\
-		.wait	= {						\
-				.task	= current,			\
-				.flags	= f,				\
-				.func	= bh_wake_function,		\
-				.task_list =				\
-					LIST_HEAD_INIT(name.wait.task_list),\
-			},						\
-	}
-#define DEFINE_BH_WAIT(name, bh)	__DEFINE_BH_WAIT(name, bh, 0)
-#define DEFINE_BH_WAIT_EXCLUSIVE(name, bh) \
-		__DEFINE_BH_WAIT(name, bh, WQ_FLAG_EXCLUSIVE)
-
 /*
  * Hashed waitqueue_head's for wait_on_buffer()
  */
@@ -93,24 +73,10 @@
 	wait_queue_head_t *wq = bh_waitq_head(bh);
 
 	smp_mb();
-	if (waitqueue_active(wq))
-		__wake_up(wq, TASK_INTERRUPTIBLE|TASK_UNINTERRUPTIBLE, 1, bh);
+	__wake_up_bit(wq, &bh->b_state, BH_Lock);
 }
 EXPORT_SYMBOL(wake_up_buffer);
 
-static int bh_wake_function(wait_queue_t *wait, unsigned mode,
-				int sync, void *key)
-{
-	struct buffer_head *bh = key;
-	struct bh_wait_queue *wq;
-
-	wq = container_of(wait, struct bh_wait_queue, wait);
-	if (wq->bh != bh || buffer_locked(bh))
-		return 0;
-	else
-		return autoremove_wake_function(wait, mode, sync, key);
-}
-
 static void sync_buffer(struct buffer_head *bh)
 {
 	struct block_device *bd;
@@ -124,7 +90,7 @@
 void fastcall __lock_buffer(struct buffer_head *bh)
 {
 	wait_queue_head_t *wqh = bh_waitq_head(bh);
-	DEFINE_BH_WAIT_EXCLUSIVE(wait, bh);
+	DEFINE_WAIT_BIT(wait, &bh->b_state, BH_Lock);
 
 	do {
 		prepare_to_wait_exclusive(wqh, &wait.wait,
@@ -153,15 +119,13 @@
 void __wait_on_buffer(struct buffer_head * bh)
 {
 	wait_queue_head_t *wqh = bh_waitq_head(bh);
-	DEFINE_BH_WAIT(wait, bh);
+	DEFINE_WAIT_BIT(wait, &bh->b_state, BH_Lock);
 
-	do {
-		prepare_to_wait(wqh, &wait.wait, TASK_UNINTERRUPTIBLE);
-		if (buffer_locked(bh)) {
-			sync_buffer(bh);
-			io_schedule();
-		}
-	} while (buffer_locked(bh));
+	prepare_to_wait(wqh, &wait.wait, TASK_UNINTERRUPTIBLE);
+	if (buffer_locked(bh)) {
+		sync_buffer(bh);
+		io_schedule();
+	}
 	finish_wait(wqh, &wait.wait);
 }
 
Index: wait-2.6.9-rc1-mm1/kernel/wait.c
===================================================================
--- wait-2.6.9-rc1-mm1.orig/kernel/wait.c	2004-08-28 09:46:45.808248312 -0700
+++ wait-2.6.9-rc1-mm1/kernel/wait.c	2004-08-28 09:47:21.247860672 -0700
@@ -127,3 +127,26 @@
 	return ret;
 }
 EXPORT_SYMBOL(autoremove_wake_function);
+
+int wake_bit_function(wait_queue_t *wait, unsigned mode, int sync, void *arg)
+{
+	struct wait_bit_key *key = arg;
+	struct wait_bit_queue *wait_bit
+		= container_of(wait, struct wait_bit_queue, wait);
+
+	if (wait_bit->key.flags != key->flags ||
+			wait_bit->key.bit_nr != key->bit_nr ||
+			test_bit(key->bit_nr, key->flags))
+		return 0;
+	else
+		return autoremove_wake_function(wait, mode, sync, key);
+}
+EXPORT_SYMBOL(wake_bit_function);
+
+void fastcall __wake_up_bit(wait_queue_head_t *wq, void *word, int bit)
+{
+	struct wait_bit_key key = __WAIT_BIT_KEY_INITIALIZER(word, bit);
+	if (waitqueue_active(wq))
+		__wake_up(wq, TASK_INTERRUPTIBLE|TASK_UNINTERRUPTIBLE, 1, &key);
+}
+EXPORT_SYMBOL(__wake_up_bit);
Index: wait-2.6.9-rc1-mm1/mm/filemap.c
===================================================================
--- wait-2.6.9-rc1-mm1.orig/mm/filemap.c	2004-08-28 09:43:39.875514384 -0700
+++ wait-2.6.9-rc1-mm1/mm/filemap.c	2004-08-28 09:47:21.244861128 -0700
@@ -355,40 +355,6 @@
  * at a cost of "thundering herd" phenomena during rare hash
  * collisions.
  */
-struct page_wait_queue {
-	struct page *page;
-	int bit;
-	wait_queue_t wait;
-};
-
-static int page_wake_function(wait_queue_t *wait, unsigned mode, int sync, void *key)
-{
-	struct page *page = key;
-	struct page_wait_queue *wq;
-
-	wq = container_of(wait, struct page_wait_queue, wait);
-	if (wq->page != page || test_bit(wq->bit, &page->flags))
-		return 0;
-	else
-		return autoremove_wake_function(wait, mode, sync, NULL);
-}
-
-#define __DEFINE_PAGE_WAIT(name, p, b, f)				\
-	struct page_wait_queue name = {					\
-		.page	= p,						\
-		.bit	= b,						\
-		.wait	= {						\
-			.task	= current,				\
-			.func	= page_wake_function,			\
-			.flags	= f,					\
-			.task_list = LIST_HEAD_INIT(name.wait.task_list),\
-		},							\
-	}
-
-#define DEFINE_PAGE_WAIT(name, p, b)	__DEFINE_PAGE_WAIT(name, p, b, 0)
-#define DEFINE_PAGE_WAIT_EXCLUSIVE(name, p, b)				\
-		__DEFINE_PAGE_WAIT(name, p, b, WQ_FLAG_EXCLUSIVE)
-
 static wait_queue_head_t *page_waitqueue(struct page *page)
 {
 	const struct zone *zone = page_zone(page);
@@ -396,27 +362,16 @@
 	return &zone->wait_table[hash_ptr(page, zone->wait_table_bits)];
 }
 
-static void wake_up_page(struct page *page)
-{
-	const unsigned int mode = TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE;
-	wait_queue_head_t *waitqueue = page_waitqueue(page);
-
-	if (waitqueue_active(waitqueue))
-		__wake_up(waitqueue, mode, 1, page);
-}
-
 void fastcall wait_on_page_bit(struct page *page, int bit_nr)
 {
 	wait_queue_head_t *waitqueue = page_waitqueue(page);
-	DEFINE_PAGE_WAIT(wait, page, bit_nr);
+	DEFINE_WAIT_BIT(wait, &page->flags, bit_nr);
 
-	do {
-		prepare_to_wait(waitqueue, &wait.wait, TASK_UNINTERRUPTIBLE);
-		if (test_bit(bit_nr, &page->flags)) {
-			sync_page(page);
-			io_schedule();
-		}
-	} while (test_bit(bit_nr, &page->flags));
+	prepare_to_wait(waitqueue, &wait.wait, TASK_UNINTERRUPTIBLE);
+	if (test_bit(bit_nr, &page->flags)) {
+		sync_page(page);
+		io_schedule();
+	}
 	finish_wait(waitqueue, &wait.wait);
 }
 
@@ -443,7 +398,7 @@
 	if (!TestClearPageLocked(page))
 		BUG();
 	smp_mb__after_clear_bit(); 
-	wake_up_page(page);
+	__wake_up_bit(page_waitqueue(page), &page->flags, PG_locked);
 }
 
 EXPORT_SYMBOL(unlock_page);
@@ -459,7 +414,7 @@
 			BUG();
 		smp_mb__after_clear_bit();
 	}
-	wake_up_page(page);
+	__wake_up_bit(page_waitqueue(page), &page->flags, PG_writeback);
 }
 
 EXPORT_SYMBOL(end_page_writeback);
@@ -475,7 +430,7 @@
 void fastcall __lock_page(struct page *page)
 {
 	wait_queue_head_t *wqh = page_waitqueue(page);
-	DEFINE_PAGE_WAIT_EXCLUSIVE(wait, page, PG_locked);
+	DEFINE_WAIT_BIT(wait, &page->flags, PG_locked);
 
 	while (TestSetPageLocked(page)) {
 		prepare_to_wait_exclusive(wqh, &wait.wait, TASK_UNINTERRUPTIBLE);
Index: wait-2.6.9-rc1-mm1/include/linux/wait.h
===================================================================
--- wait-2.6.9-rc1-mm1.orig/include/linux/wait.h	2004-08-28 09:43:13.546517000 -0700
+++ wait-2.6.9-rc1-mm1/include/linux/wait.h	2004-08-28 09:47:21.236862344 -0700
@@ -37,6 +37,16 @@
 	struct list_head task_list;
 };
 
+struct wait_bit_key {
+	void *flags;
+	int bit_nr;
+};
+
+struct wait_bit_queue {
+	struct wait_bit_key key;
+	wait_queue_t wait;
+};
+
 struct __wait_queue_head {
 	spinlock_t lock;
 	struct list_head task_list;
@@ -63,6 +73,9 @@
 #define DECLARE_WAIT_QUEUE_HEAD(name) \
 	wait_queue_head_t name = __WAIT_QUEUE_HEAD_INITIALIZER(name)
 
+#define __WAIT_BIT_KEY_INITIALIZER(word, bit)				\
+	{ .flags = word, .bit_nr = bit, }
+
 static inline void init_waitqueue_head(wait_queue_head_t *q)
 {
 	q->lock = SPIN_LOCK_UNLOCKED;
@@ -125,6 +138,7 @@
 void FASTCALL(__wake_up(wait_queue_head_t *q, unsigned int mode, int nr, void *key));
 extern void FASTCALL(__wake_up_locked(wait_queue_head_t *q, unsigned int mode));
 extern void FASTCALL(__wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr));
+void FASTCALL(__wake_up_bit(wait_queue_head_t *, void *, int));
 
 #define wake_up(x)			__wake_up(x, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1, NULL)
 #define wake_up_nr(x, nr)		__wake_up(x, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, nr, NULL)
@@ -277,6 +291,7 @@
 				wait_queue_t *wait, int state));
 void FASTCALL(finish_wait(wait_queue_head_t *q, wait_queue_t *wait));
 int autoremove_wake_function(wait_queue_t *wait, unsigned mode, int sync, void *key);
+int wake_bit_function(wait_queue_t *wait, unsigned mode, int sync, void *key);
 
 #define DEFINE_WAIT(name)						\
 	wait_queue_t name = {						\
@@ -287,6 +302,17 @@
 				},					\
 	}
 
+#define DEFINE_WAIT_BIT(name, word, bit)				\
+	struct wait_bit_queue name = {					\
+		.key = __WAIT_BIT_KEY_INITIALIZER(word, bit),		\
+		.wait	= {						\
+			.task		= current,			\
+			.func		= wake_bit_function,		\
+			.task_list	=				\
+				LIST_HEAD_INIT(name.wait.task_list),	\
+		},							\
+	}
+
 #define init_wait(wait)							\
 	do {								\
 		wait->task = current;					\
