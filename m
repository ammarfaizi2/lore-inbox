Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269191AbUHaVJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269191AbUHaVJK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 17:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269029AbUHaVIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 17:08:34 -0400
Received: from holomorphy.com ([207.189.100.168]:61375 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269192AbUHaVFu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 17:05:50 -0400
Date: Tue, 31 Aug 2004 14:05:42 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Eric Valette <eric.valette@free.fr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2/2] reduce number of parameters to __wait_on_bit() and __wait_on_bit_lock()
Message-ID: <20040831210542.GU5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, Eric Valette <eric.valette@free.fr>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <41343136.6080208@free.fr> <20040831080916.GK5492@holomorphy.com> <20040831081456.GL5492@holomorphy.com> <20040831084458.GM5492@holomorphy.com> <20040831210346.GT5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040831210346.GT5492@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 02:03:46PM -0700, William Lee Irwin III wrote:
> Move the slow paths of wait_on_bit() and wait_on_bit_lock() out of line.
> Also uninline wake_up_bit() to reduce the number of callsites
> generated, and adjust loop startup in  __wait_on_bit_lock() to properly
> reflect its usage in the contention case.
> Incremental atop the fastcall and wait_on_bit_lock()/test_and_set_bit() fixes.
> Successfully tested on x86-64.

Some of the parameters to __wait_on_bit() and __wait_on_bit_lock() are
redundant, as the wait_bit_queue parameter holds the flags word and the
bit number. This patch updates __wait_on_bit() and __wait_on_bit_lock()
to fetch that information from the wait_bit_queue passed to them and so
reduce the number of parameters so that -mregparm may be more effective.

Incremental atop the complete out-of-lining of the contention cases and
the fastcall and wait_on_bit_lock()/test_and_set_bit() fixes.

Successfully tested on x86-64.


Index: mm2-2.6.9-rc1/fs/fs-writeback.c
===================================================================
--- mm2-2.6.9-rc1.orig/fs/fs-writeback.c	2004-08-31 01:06:56.824462896 -0700
+++ mm2-2.6.9-rc1/fs/fs-writeback.c	2004-08-31 01:57:17.099311328 -0700
@@ -257,8 +257,8 @@
 		do {
 			__iget(inode);
 			spin_unlock(&inode_lock);
-			__wait_on_bit(wqh, &wq, &inode->i_state, __I_LOCK,
-					inode_wait, TASK_UNINTERRUPTIBLE);
+			__wait_on_bit(wqh, &wq, inode_wait,
+							TASK_UNINTERRUPTIBLE);
 			iput(inode);
 			spin_lock(&inode_lock);
 		} while (inode->i_state & I_LOCK);
Index: mm2-2.6.9-rc1/include/linux/wait.h
===================================================================
--- mm2-2.6.9-rc1.orig/include/linux/wait.h	2004-08-31 01:50:40.947535552 -0700
+++ mm2-2.6.9-rc1/include/linux/wait.h	2004-08-31 01:54:33.867126392 -0700
@@ -140,8 +140,8 @@
 extern void FASTCALL(__wake_up_locked(wait_queue_head_t *q, unsigned int mode));
 extern void FASTCALL(__wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr));
 void FASTCALL(__wake_up_bit(wait_queue_head_t *, void *, int));
-int FASTCALL(__wait_on_bit(wait_queue_head_t *, struct wait_bit_queue *, void *, int, int (*)(void *), unsigned));
-int FASTCALL(__wait_on_bit_lock(wait_queue_head_t *, struct wait_bit_queue *, void *, int, int (*)(void *), unsigned));
+int FASTCALL(__wait_on_bit(wait_queue_head_t *, struct wait_bit_queue *, int (*)(void *), unsigned));
+int FASTCALL(__wait_on_bit_lock(wait_queue_head_t *, struct wait_bit_queue *, int (*)(void *), unsigned));
 void FASTCALL(wake_up_bit(void *, int));
 int FASTCALL(out_of_line_wait_on_bit(void *, int, int (*)(void *), unsigned));
 int FASTCALL(out_of_line_wait_on_bit_lock(void *, int, int (*)(void *), unsigned));
Index: mm2-2.6.9-rc1/kernel/wait.c
===================================================================
--- mm2-2.6.9-rc1.orig/kernel/wait.c	2004-08-31 01:51:18.966755752 -0700
+++ mm2-2.6.9-rc1/kernel/wait.c	2004-08-31 02:00:10.430960912 -0700
@@ -151,14 +151,14 @@
  * permitted return codes. Nonzero return codes halt waiting and return.
  */
 int __sched fastcall __wait_on_bit(wait_queue_head_t *wq,
-			struct wait_bit_queue *q, void *word,
-			int bit, int (*action)(void *), unsigned mode)
+			struct wait_bit_queue *q,
+			int (*action)(void *), unsigned mode)
 {
 	int ret = 0;
 
 	prepare_to_wait(wq, &q->wait, mode);
-	if (test_bit(bit, word))
-		ret = (*action)(word);
+	if (test_bit(q->key.bit_nr, q->key.flags))
+		ret = (*action)(q->key.flags);
 	finish_wait(wq, &q->wait);
 	return ret;
 }
@@ -170,23 +170,23 @@
 	wait_queue_head_t *wq = bit_waitqueue(word, bit);
 	DEFINE_WAIT_BIT(wait, word, bit);
 
-	return __wait_on_bit(wq, &wait, word, bit, action, mode);
+	return __wait_on_bit(wq, &wait, action, mode);
 }
 EXPORT_SYMBOL(out_of_line_wait_on_bit);
 
 int __sched fastcall __wait_on_bit_lock(wait_queue_head_t *wq,
-			struct wait_bit_queue *q, void *word, int bit,
+			struct wait_bit_queue *q,
 			int (*action)(void *), unsigned mode)
 {
 	int ret = 0;
 
 	do {
 		prepare_to_wait_exclusive(wq, &q->wait, mode);
-		if (test_bit(bit, word)) {
-			if ((ret = (*action)(word)))
+		if (test_bit(q->key.bit_nr, q->key.flags)) {
+			if ((ret = (*action)(q->key.flags)))
 				break;
 		}
-	} while (test_and_set_bit(bit, word));
+	} while (test_and_set_bit(q->key.bit_nr, q->key.flags));
 	finish_wait(wq, &q->wait);
 	return ret;
 }
@@ -198,7 +198,7 @@
 	wait_queue_head_t *wq = bit_waitqueue(word, bit);
 	DEFINE_WAIT_BIT(wait, word, bit);
 
-	return __wait_on_bit_lock(wq, &wait, word, bit, action, mode);
+	return __wait_on_bit_lock(wq, &wait, action, mode);
 }
 EXPORT_SYMBOL(out_of_line_wait_on_bit_lock);
 
Index: mm2-2.6.9-rc1/mm/filemap.c
===================================================================
--- mm2-2.6.9-rc1.orig/mm/filemap.c	2004-08-31 01:06:56.779469736 -0700
+++ mm2-2.6.9-rc1/mm/filemap.c	2004-08-31 01:59:36.716086352 -0700
@@ -377,8 +377,8 @@
 	DEFINE_WAIT_BIT(wait, &page->flags, bit_nr);
 
 	if (test_bit(bit_nr, &page->flags))
-		__wait_on_bit(page_waitqueue(page), &wait, wait.key.flags,
-				bit_nr, sync_page, TASK_UNINTERRUPTIBLE);
+		__wait_on_bit(page_waitqueue(page), &wait, sync_page,
+							TASK_UNINTERRUPTIBLE);
 }
 EXPORT_SYMBOL(wait_on_page_bit);
 
@@ -436,8 +436,8 @@
 {
 	DEFINE_WAIT_BIT(wait, &page->flags, PG_locked);
 
-	__wait_on_bit_lock(page_waitqueue(page), &wait, wait.key.flags,
-				PG_locked, sync_page, TASK_UNINTERRUPTIBLE);
+	__wait_on_bit_lock(page_waitqueue(page), &wait, sync_page,
+							TASK_UNINTERRUPTIBLE);
 }
 EXPORT_SYMBOL(__lock_page);
 
