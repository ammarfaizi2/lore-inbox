Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267656AbUHaVJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267656AbUHaVJM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 17:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269162AbUHaVGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 17:06:48 -0400
Received: from holomorphy.com ([207.189.100.168]:59327 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269190AbUHaVDw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 17:03:52 -0400
Date: Tue, 31 Aug 2004 14:03:46 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Eric Valette <eric.valette@free.fr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [1/2] move wait ops' contention case completely out of line
Message-ID: <20040831210346.GT5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, Eric Valette <eric.valette@free.fr>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <41343136.6080208@free.fr> <20040831080916.GK5492@holomorphy.com> <20040831081456.GL5492@holomorphy.com> <20040831084458.GM5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040831084458.GM5492@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 01:44:58AM -0700, William Lee Irwin III wrote:
> Incremental atop the fastcall fix:
> wait_on_bit_lock() needs to test_and_set_bit() in the fastpath, not
> test_bit().

Move the slow paths of wait_on_bit() and wait_on_bit_lock() out of line.
Also uninline wake_up_bit() to reduce the number of callsites
generated, and adjust loop startup in  __wait_on_bit_lock() to properly
reflect its usage in the contention case.

Incremental atop the fastcall and wait_on_bit_lock()/test_and_set_bit() fixes.
Successfully tested on x86-64.


Index: mm2-2.6.9-rc1/include/linux/wait.h
===================================================================
--- mm2-2.6.9-rc1.orig/include/linux/wait.h	2004-08-31 01:38:34.670946376 -0700
+++ mm2-2.6.9-rc1/include/linux/wait.h	2004-08-31 01:50:40.947535552 -0700
@@ -142,23 +142,11 @@
 void FASTCALL(__wake_up_bit(wait_queue_head_t *, void *, int));
 int FASTCALL(__wait_on_bit(wait_queue_head_t *, struct wait_bit_queue *, void *, int, int (*)(void *), unsigned));
 int FASTCALL(__wait_on_bit_lock(wait_queue_head_t *, struct wait_bit_queue *, void *, int, int (*)(void *), unsigned));
+void FASTCALL(wake_up_bit(void *, int));
+int FASTCALL(out_of_line_wait_on_bit(void *, int, int (*)(void *), unsigned));
+int FASTCALL(out_of_line_wait_on_bit_lock(void *, int, int (*)(void *), unsigned));
 wait_queue_head_t *FASTCALL(bit_waitqueue(void *, int));
 
-/**
- * wake_up_bit - wake up a waiter on a bit
- * @word: the word being waited on, a kernel virtual address
- * @bit: the bit of the word being waited on
- *
- * There is a standard hashed waitqueue table for generic use. This
- * is the part of the hashtable's accessor API that wakes up waiters
- * on a bit. For instance, if one were to have waiters on a bitflag,
- * one would call wake_up_bit() after clearing the bit.
- */
-static inline void wake_up_bit(void *word, int bit)
-{
-	__wake_up_bit(bit_waitqueue(word, bit), word, bit);
-}
-
 #define wake_up(x)			__wake_up(x, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1, NULL)
 #define wake_up_nr(x, nr)		__wake_up(x, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, nr, NULL)
 #define wake_up_all(x)			__wake_up(x, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 0, NULL)
@@ -356,14 +344,9 @@
 static inline int wait_on_bit(void *word, int bit,
 				int (*action)(void *), unsigned mode)
 {
-	DEFINE_WAIT_BIT(q, word, bit);
-	wait_queue_head_t *wqh;
-
 	if (!test_bit(bit, word))
 		return 0;
-
-	wqh = bit_waitqueue(word, bit);
-	return __wait_on_bit(wqh, &q, word, bit, action, mode);
+	return out_of_line_wait_on_bit(word, bit, action, mode);
 }
 
 /**
@@ -385,14 +368,9 @@
 static inline int wait_on_bit_lock(void *word, int bit,
 				int (*action)(void *), unsigned mode)
 {
-	DEFINE_WAIT_BIT(q, word, bit);
-	wait_queue_head_t *wqh;
-
 	if (!test_and_set_bit(bit, word))
 		return 0;
-
-	wqh = bit_waitqueue(word, bit);
-	return __wait_on_bit_lock(wqh, &q, word, bit, action, mode);
+	return out_of_line_wait_on_bit_lock(word, bit, action, mode);
 }
 	
 #endif /* __KERNEL__ */
Index: mm2-2.6.9-rc1/kernel/wait.c
===================================================================
--- mm2-2.6.9-rc1.orig/kernel/wait.c	2004-08-31 01:10:49.805044464 -0700
+++ mm2-2.6.9-rc1/kernel/wait.c	2004-08-31 01:51:18.966755752 -0700
@@ -164,24 +164,44 @@
 }
 EXPORT_SYMBOL(__wait_on_bit);
 
+int __sched fastcall out_of_line_wait_on_bit(void *word, int bit,
+					int (*action)(void *), unsigned mode)
+{
+	wait_queue_head_t *wq = bit_waitqueue(word, bit);
+	DEFINE_WAIT_BIT(wait, word, bit);
+
+	return __wait_on_bit(wq, &wait, word, bit, action, mode);
+}
+EXPORT_SYMBOL(out_of_line_wait_on_bit);
+
 int __sched fastcall __wait_on_bit_lock(wait_queue_head_t *wq,
 			struct wait_bit_queue *q, void *word, int bit,
 			int (*action)(void *), unsigned mode)
 {
 	int ret = 0;
 
-	while (test_and_set_bit(bit, word)) {
+	do {
 		prepare_to_wait_exclusive(wq, &q->wait, mode);
 		if (test_bit(bit, word)) {
 			if ((ret = (*action)(word)))
 				break;
 		}
-	}
+	} while (test_and_set_bit(bit, word));
 	finish_wait(wq, &q->wait);
 	return ret;
 }
 EXPORT_SYMBOL(__wait_on_bit_lock);
 
+int __sched fastcall out_of_line_wait_on_bit_lock(void *word, int bit,
+					int (*action)(void *), unsigned mode)
+{
+	wait_queue_head_t *wq = bit_waitqueue(word, bit);
+	DEFINE_WAIT_BIT(wait, word, bit);
+
+	return __wait_on_bit_lock(wq, &wait, word, bit, action, mode);
+}
+EXPORT_SYMBOL(out_of_line_wait_on_bit_lock);
+
 void fastcall __wake_up_bit(wait_queue_head_t *wq, void *word, int bit)
 {
 	struct wait_bit_key key = __WAIT_BIT_KEY_INITIALIZER(word, bit);
@@ -190,6 +210,22 @@
 }
 EXPORT_SYMBOL(__wake_up_bit);
 
+/**
+ * wake_up_bit - wake up a waiter on a bit
+ * @word: the word being waited on, a kernel virtual address
+ * @bit: the bit of the word being waited on
+ *
+ * There is a standard hashed waitqueue table for generic use. This
+ * is the part of the hashtable's accessor API that wakes up waiters
+ * on a bit. For instance, if one were to have waiters on a bitflag,
+ * one would call wake_up_bit() after clearing the bit.
+ */
+void fastcall wake_up_bit(void *word, int bit)
+{
+	__wake_up_bit(bit_waitqueue(word, bit), word, bit);
+}
+EXPORT_SYMBOL(wake_up_bit);
+
 wait_queue_head_t * fastcall bit_waitqueue(void *word, int bit)
 {
 	const int shift = BITS_PER_LONG == 32 ? 5 : 6;
