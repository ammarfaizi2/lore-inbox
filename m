Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267443AbUH1KVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267443AbUH1KVi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 06:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264213AbUH1KTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 06:19:14 -0400
Received: from holomorphy.com ([207.189.100.168]:39845 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267415AbUH1JvN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 05:51:13 -0400
Date: Sat, 28 Aug 2004 02:51:04 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: oleg@tv-sign.ru, linux-kernel@vger.kernel.org
Subject: Re: [2/4] consolidate bit waiting code patterns
Message-ID: <20040828095104.GM5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, oleg@tv-sign.ru,
	linux-kernel@vger.kernel.org
References: <20040826014745.225d7a2c.akpm@osdl.org> <20040828052627.GA2793@holomorphy.com> <20040828053112.GB2793@holomorphy.com> <20040827231713.212245c5.akpm@osdl.org> <20040828063419.GA5492@holomorphy.com> <20040827234033.2b6e1525.akpm@osdl.org> <20040828064829.GB5492@holomorphy.com> <20040828092040.GH5492@holomorphy.com> <20040828092210.GJ5492@holomorphy.com> <20040828023436.4879983a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828023436.4879983a.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 02:34:36AM -0700, Andrew Morton wrote:
> Some comments over this thing would be nice.
> The `wait' argument seems to be misnamed.  It typically points at
> sync_page(), yes?   Maybe it should be called `action' or `kick' or
> something.
> If (*wait)() returns non-zero then it looks to me like the callers will get
> confused, thinking that the page did come unlocked?
> If (*wait)() returns non-zero then we need to run finish_wait(), no?

You're right, that should be a break; and return ret; with ret
initialized to 0. Mysteriously, I never hit this even in combination
testing with aio.

Index: mm1-2.6.9-rc1/kernel/fork.c
===================================================================
--- mm1-2.6.9-rc1.orig/kernel/fork.c	2004-08-28 01:23:05.410362856 -0700
+++ mm1-2.6.9-rc1/kernel/fork.c	2004-08-28 02:47:05.712120520 -0700
@@ -261,37 +261,40 @@
 }
 EXPORT_SYMBOL(__wake_up_bit);
 
+/*
+ * To allow interruptible waiting and asynchronous (i.e. nonblocking)
+ * waiting, the actions of __wait_on_bit() and __wait_on_bit_lock() are
+ * permitted return codes. Nonzero return codes halt waiting and return.
+ */
 int __sched __wait_on_bit(wait_queue_head_t *wq, struct wait_bit_queue *q,
 			void *word,
-			int bit, int (*wait)(void *), unsigned mode)
+			int bit, int (*action)(void *), unsigned mode)
 {
-	int ret;
+	int ret = 0;
 
 	prepare_to_wait(wq, &q->wait, mode);
-	if (test_bit(bit, word)) {
-		if ((ret = (*wait)(word)))
-			return ret;
-	}
+	if (test_bit(bit, word))
+		ret = (*action)(word);
 	finish_wait(wq, &q->wait);
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL(__wait_on_bit);
 
 int __sched __wait_on_bit_lock(wait_queue_head_t *wq, struct wait_bit_queue *q,
 			void *word, int bit,
-			int (*wait)(void *), unsigned mode)
+			int (*action)(void *), unsigned mode)
 {
-	int ret;
+	int ret = 0;
 
 	while (test_and_set_bit(bit, word)) {
 		prepare_to_wait_exclusive(wq, &q->wait, mode);
 		if (test_bit(bit, word)) {
-			if ((ret = (*wait)(word)))
-				return ret;
+			if ((ret = (*action)(word)))
+				break;
 		}
 	}
 	finish_wait(wq, &q->wait);
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL(__wait_on_bit_lock);
 
Index: mm1-2.6.9-rc1/include/linux/wait.h
===================================================================
--- mm1-2.6.9-rc1.orig/include/linux/wait.h	2004-08-28 01:44:13.448591744 -0700
+++ mm1-2.6.9-rc1/include/linux/wait.h	2004-08-28 02:45:22.458817408 -0700
@@ -343,7 +343,7 @@
  * wait_on_bit - wait for a bit to be cleared
  * @word: the word being waited on, a kernel virtual address
  * @bit: the bit of the word being waited on
- * @wait: the function used to sleep, which may take special actions
+ * @action: the function used to sleep, which may take special actions
  * @mode: the task state to sleep in
  *
  * There is a standard hashed waitqueue table for generic use. This
@@ -354,19 +354,19 @@
  * but has no intention of setting it.
  */
 static inline int wait_on_bit(void *word, int bit,
-				int (*wait)(void *), unsigned mode)
+				int (*action)(void *), unsigned mode)
 {
 	DEFINE_WAIT_BIT(q, word, bit);
 	wait_queue_head_t *wqh = bit_waitqueue(word, bit);
 
-	return __wait_on_bit(wqh, &q, word, bit, wait, mode);
+	return __wait_on_bit(wqh, &q, word, bit, action, mode);
 }
 
 /**
  * wait_on_bit_lock - wait for a bit to be cleared, when wanting to set it
  * @word: the word being waited on, a kernel virtual address
  * @bit: the bit of the word being waited on
- * @wait: the function used to sleep, which may take special actions
+ * @action: the function used to sleep, which may take special actions
  * @mode: the task state to sleep in
  *
  * There is a standard hashed waitqueue table for generic use. This
@@ -379,12 +379,12 @@
  * clear with the intention of setting it, and when done, clearing it.
  */
 static inline int wait_on_bit_lock(void *word, int bit,
-				int (*wait)(void *), unsigned mode)
+				int (*action)(void *), unsigned mode)
 {
 	DEFINE_WAIT_BIT(q, word, bit);
 	wait_queue_head_t *wqh = bit_waitqueue(word, bit);
 
-	return __wait_on_bit_lock(wqh, &q, word, bit, wait, mode);
+	return __wait_on_bit_lock(wqh, &q, word, bit, action, mode);
 }
 	
 #endif /* __KERNEL__ */
