Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVFTQLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVFTQLs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 12:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVFTQLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 12:11:48 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:41135 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261327AbVFTQLi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 12:11:38 -0400
Date: Mon, 20 Jun 2005 21:50:54 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org
Cc: linux-kernel@vger.kernel.org, bcrl@kvack.org, wli@holomorphy.com,
       zab@zabbo.net, mason@suse.com
Subject: Re: [PATCH 1/6] Add a wait queue argument to wait_bit action()
Message-ID: <20050620162054.GA5380@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20050620120154.GA4810@in.ibm.com> <20050620160126.GA5271@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050620160126.GA5271@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 09:31:26PM +0530, Suparna Bhattacharya wrote:

> Here is a little bit of background on the motivation behind this set of
> patches to update AIO for filtered wakeups:
> 
> (a) Since the introduction of filtered wakeups support and 
>     the wait_bit_queue infrastructure in mainline, it is no longer
>     sufficient to just embed a wait queue entry in the kiocb
>     for AIO operations involving filtered wakeups.
> (b) Given that filesystem reads/writes use filtered wakeups underlying
>     wait_on_page_bit, fixing this becomes a pre-req for buffered
>     filesystem AIO.
> (c) The wait_bit_queue infrastructure actually enables a cleaner
>     implementation of filesystem AIO because it already provides
>     for an action routine intended to allow both blocking and
>     non-blocking or asynchronous behaviour.
> 
>> Updated to apply to 2.6.12-rc6.

Add a wait queue parameter to the action routine called by 
__wait_on_bit to allow it to determine whether to block or
not.

Signed-off-by: Suparna Bhattacharya <suparna@in.ibm.com>


 fs/buffer.c   |    2 +-
 kernel/wait.c |   14 ++++++++------
 mm/filemap.c  |    2 +-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff -puN kernel/wait.c~modify-wait-bit-action-args kernel/wait.c
--- linux-2.6.9-rc1-mm4/kernel/wait.c~modify-wait-bit-action-args	2004-09-10 16:52:04.000000000 +0530
+++ linux-2.6.9-rc1-mm4-suparna/kernel/wait.c	2004-09-10 16:52:04.000000000 +0530
@@ -152,14 +152,14 @@ EXPORT_SYMBOL(wake_bit_function);
  */
 int __sched fastcall
 __wait_on_bit(wait_queue_head_t *wq, struct wait_bit_queue *q,
-			int (*action)(void *), unsigned mode)
+			int (*action)(void *, wait_queue_t *), unsigned mode)
 {
 	int ret = 0;
 
	do {
 		prepare_to_wait(wq, &q->wait, mode);
 		if (test_bit(q->key.bit_nr, q->key.flags))
-			ret = (*action)(q->key.flags);
+			ret = (*action)(q->key.flags, &q->wait);
	} while (test_bit(q->key.bit_nr, q->key.flags) && !ret);
 	finish_wait(wq, &q->wait);
 	return ret;
@@ -167,7 +167,8 @@ EXPORT_SYMBOL(__wait_on_bit);
 EXPORT_SYMBOL(__wait_on_bit);
 
 int __sched fastcall out_of_line_wait_on_bit(void *word, int bit,
-					int (*action)(void *), unsigned mode)
+					int (*action)(void *, wait_queue_t *),
+					unsigned mode)
 {
 	wait_queue_head_t *wq = bit_waitqueue(word, bit);
 	DEFINE_WAIT_BIT(wait, word, bit);
@@ -178,14 +179,14 @@ EXPORT_SYMBOL(out_of_line_wait_on_bit);
 
 int __sched fastcall
 __wait_on_bit_lock(wait_queue_head_t *wq, struct wait_bit_queue *q,
-			int (*action)(void *), unsigned mode)
+			int (*action)(void *, wait_queue_t *), unsigned mode)
 {
 	int ret = 0;
 
 	do {
 		prepare_to_wait_exclusive(wq, &q->wait, mode);
 		if (test_bit(q->key.bit_nr, q->key.flags)) {
-			if ((ret = (*action)(q->key.flags)))
+			if ((ret = (*action)(q->key.flags, &q->wait)))
 				break;
 		}
 	} while (test_and_set_bit(q->key.bit_nr, q->key.flags));
@@ -195,7 +196,8 @@ __wait_on_bit_lock(wait_queue_head_t *wq
 EXPORT_SYMBOL(__wait_on_bit_lock);
 
 int __sched fastcall out_of_line_wait_on_bit_lock(void *word, int bit,
-					int (*action)(void *), unsigned mode)
+				int (*action)(void *, wait_queue_t *wait),
+				unsigned mode)
 {
 	wait_queue_head_t *wq = bit_waitqueue(word, bit);
 	DEFINE_WAIT_BIT(wait, word, bit);
diff -puN mm/filemap.c~modify-wait-bit-action-args mm/filemap.c
--- linux-2.6.9-rc1-mm4/mm/filemap.c~modify-wait-bit-action-args	2004-09-10 16:52:04.000000000 +0530
+++ linux-2.6.9-rc1-mm4-suparna/mm/filemap.c	2004-09-10 16:52:04.000000000 +0530
@@ -133,7 +133,7 @@ void remove_from_page_cache(struct page 
 }
 EXPORT_SYMBOL(remove_from_page_cache);
 
-static int sync_page(void *word)
+static int sync_page(void *word, wait_queue_t *wait)
 {
 	struct address_space *mapping;
 	struct page *page;
diff -puN fs/buffer.c~modify-wait-bit-action-args fs/buffer.c
--- linux-2.6.9-rc1-mm4/fs/buffer.c~modify-wait-bit-action-args	2004-09-10 16:52:04.000000000 +0530
+++ linux-2.6.9-rc1-mm4-suparna/fs/buffer.c	2004-09-10 16:52:04.000000000 +0530
@@ -52,7 +52,7 @@ void wake_up_buffer(struct buffer_head *
	bh->b_private = private;
 }

-static int sync_buffer(void *word)
+static int sync_buffer(void *word, wait_queue_t *wait)
 {
 	struct block_device *bd;
 	struct buffer_head *bh

_
diff -urp linux-2.6.9-rc3/include/linux/wait.h linux-2.6.9-rc3-mm2/include/linux/wait.h
--- linux-2.6.9-rc3/include/linux/wait.h	2004-10-07 13:19:09.000000000 +0530
+++ linux-2.6.9-rc3-mm2/include/linux/wait.h	2004-10-07 12:04:17.000000000 +0530
@@ -140,11 +151,15 @@ void FASTCALL(__wake_up(wait_queue_head_
 extern void FASTCALL(__wake_up_locked(wait_queue_head_t *q, unsigned int mode));
 extern void FASTCALL(__wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr));
 void FASTCALL(__wake_up_bit(wait_queue_head_t *, void *, int));
-int FASTCALL(__wait_on_bit(wait_queue_head_t *, struct wait_bit_queue *, int (*)(void *), unsigned));
-int FASTCALL(__wait_on_bit_lock(wait_queue_head_t *, struct wait_bit_queue *, int (*)(void *), unsigned));
+int FASTCALL(__wait_on_bit(wait_queue_head_t *, struct wait_bit_queue *,
+	int (*)(void *, wait_queue_t *), unsigned));
+int FASTCALL(__wait_on_bit_lock(wait_queue_head_t *, struct wait_bit_queue *,
+	int (*)(void *, wait_queue_t *), unsigned));
 void FASTCALL(wake_up_bit(void *, int));
-int FASTCALL(out_of_line_wait_on_bit(void *, int, int (*)(void *), unsigned));
-int FASTCALL(out_of_line_wait_on_bit_lock(void *, int, int (*)(void *), unsigned));
+int FASTCALL(out_of_line_wait_on_bit(void *, int, int (*)(void *,
+	wait_queue_t *), unsigned));
+int FASTCALL(out_of_line_wait_on_bit_lock(void *, int, int (*)(void *,
+	wait_queue_t *), unsigned));
 wait_queue_head_t *FASTCALL(bit_waitqueue(void *, int));
 
 #define wake_up(x)			__wake_up(x, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1, NULL)
@@ -364,7 +392,8 @@ int wake_bit_function(wait_queue_t *wait
  * but has no intention of setting it.
  */
 static inline int wait_on_bit(void *word, int bit,
-				int (*action)(void *), unsigned mode)
+				int (*action)(void *, wait_queue_t *),
+				unsigned mode)
 {
 	if (!test_bit(bit, word))
 		return 0;
@@ -388,7 +417,8 @@ static inline int wait_on_bit(void *word
  * clear with the intention of setting it, and when done, clearing it.
  */
 static inline int wait_on_bit_lock(void *word, int bit,
-				int (*action)(void *), unsigned mode)
+				int (*action)(void *, wait_queue_t *),
+				unsigned mode)
 {
 	if (!test_and_set_bit(bit, word))
 		return 0;
diff -urp linux-2.6.9-rc3/include/linux/writeback.h linux-2.6.9-rc3-mm2/include/linux/writeback.h
--- linux-2.6.9-rc3/include/linux/writeback.h	2004-10-07 13:19:09.000000000 +0530
+++ linux-2.6.9-rc3-mm2/include/linux/writeback.h	2004-10-07 12:05:30.000000000 +0530
@@ -68,7 +68,7 @@ struct writeback_control {
  */	
 void writeback_inodes(struct writeback_control *wbc);
 void wake_up_inode(struct inode *inode);
-int inode_wait(void *);
+int inode_wait(void *, wait_queue_t *);
 void sync_inodes_sb(struct super_block *, int wait);
 void sync_inodes(int wait);
 
diff -urp linux-2.6.9-rc3/fs/inode.c linux-2.6.9-rc3-mm2/fs/inode.c
--- linux-2.6.9-rc3/fs/inode.c	2004-10-07 13:19:03.000000000 +0530
+++ linux-2.6.9-rc3-mm2/fs/inode.c	2004-10-07 12:06:07.000000000 +0530
@@ -1264,7 +1264,7 @@ void remove_dquot_ref(struct super_block
 
 #endif
 
-int inode_wait(void *word)
+int inode_wait(void *word, wait_queue_t *wait)
 {
 	schedule();
 	return 0;

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

