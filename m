Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbUKCJGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbUKCJGO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 04:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbUKCJGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 04:06:13 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:24204 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261493AbUKCJFD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 04:05:03 -0500
Date: Wed, 3 Nov 2004 14:43:54 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       wli@holomorphy.com
Subject: Re: [PATCH 1/6] Add a wait queue arg to the wait_bit action() routine
Message-ID: <20041103091354.GA5737@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20041103091036.GA4041@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041103091036.GA4041@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 02:40:36PM +0530, Suparna Bhattacharya wrote:
> 
> The series of patches that follow integrate AIO with 
> William Lee Irwin's wait bit changes, to support asynchronous
> page waits.
> 
> [1] modify-wait-bit-action-args.patch
> 	Add a wait queue arg to the wait_bit action() routine
> 

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

-------------------------------------------------------

Add a wait queue parameter to the action routine called by 
__wait_on_bit to allow it to determine whether to block or
not.

Signed-off-by: Suparna Bhattacharya <suparna@in.ibm.com>

diff -puN kernel/wait.c~modify-wait-bit-action-args kernel/wait.c


 linux-2.6.10-rc1-suparna/fs/buffer.c               |    2 +-
 linux-2.6.10-rc1-suparna/fs/inode.c                |    2 +-
 linux-2.6.10-rc1-suparna/include/linux/wait.h      |   18 ++++++++++++------
 linux-2.6.10-rc1-suparna/include/linux/writeback.h |    2 +-
 linux-2.6.10-rc1-suparna/kernel/wait.c             |   14 ++++++++------
 linux-2.6.10-rc1-suparna/mm/filemap.c              |    2 +-
 6 files changed, 24 insertions(+), 16 deletions(-)

diff -puN fs/buffer.c~modify-wait-bit-action-args fs/buffer.c
--- linux-2.6.10-rc1/fs/buffer.c~modify-wait-bit-action-args	2004-11-03 14:34:15.000000000 +0530
+++ linux-2.6.10-rc1-suparna/fs/buffer.c	2004-11-03 14:34:15.000000000 +0530
@@ -52,7 +52,7 @@ init_buffer(struct buffer_head *bh, bh_e
 	bh->b_private = private;
 }
 
-static int sync_buffer(void *word)
+static int sync_buffer(void *word, wait_queue_t *wait)
 {
 	struct block_device *bd;
 	struct buffer_head *bh
diff -puN fs/inode.c~modify-wait-bit-action-args fs/inode.c
--- linux-2.6.10-rc1/fs/inode.c~modify-wait-bit-action-args	2004-11-03 14:34:15.000000000 +0530
+++ linux-2.6.10-rc1-suparna/fs/inode.c	2004-11-03 14:34:15.000000000 +0530
@@ -1264,7 +1264,7 @@ void remove_dquot_ref(struct super_block
 
 #endif
 
-int inode_wait(void *word)
+int inode_wait(void *word, wait_queue_t *wait)
 {
 	schedule();
 	return 0;
diff -puN include/linux/wait.h~modify-wait-bit-action-args include/linux/wait.h
--- linux-2.6.10-rc1/include/linux/wait.h~modify-wait-bit-action-args	2004-11-03 14:34:15.000000000 +0530
+++ linux-2.6.10-rc1-suparna/include/linux/wait.h	2004-11-03 14:34:15.000000000 +0530
@@ -140,11 +140,15 @@ void FASTCALL(__wake_up(wait_queue_head_
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
@@ -364,7 +368,8 @@ int wake_bit_function(wait_queue_t *wait
  * but has no intention of setting it.
  */
 static inline int wait_on_bit(void *word, int bit,
-				int (*action)(void *), unsigned mode)
+				int (*action)(void *, wait_queue_t *),
+				unsigned mode)
 {
 	if (!test_bit(bit, word))
 		return 0;
@@ -388,7 +393,8 @@ static inline int wait_on_bit(void *word
  * clear with the intention of setting it, and when done, clearing it.
  */
 static inline int wait_on_bit_lock(void *word, int bit,
-				int (*action)(void *), unsigned mode)
+				int (*action)(void *, wait_queue_t *),
+				unsigned mode)
 {
 	if (!test_and_set_bit(bit, word))
 		return 0;
diff -puN include/linux/writeback.h~modify-wait-bit-action-args include/linux/writeback.h
--- linux-2.6.10-rc1/include/linux/writeback.h~modify-wait-bit-action-args	2004-11-03 14:34:15.000000000 +0530
+++ linux-2.6.10-rc1-suparna/include/linux/writeback.h	2004-11-03 14:34:15.000000000 +0530
@@ -68,7 +68,7 @@ struct writeback_control {
  */	
 void writeback_inodes(struct writeback_control *wbc);
 void wake_up_inode(struct inode *inode);
-int inode_wait(void *);
+int inode_wait(void *, wait_queue_t *);
 void sync_inodes_sb(struct super_block *, int wait);
 void sync_inodes(int wait);
 
diff -puN kernel/wait.c~modify-wait-bit-action-args kernel/wait.c
--- linux-2.6.10-rc1/kernel/wait.c~modify-wait-bit-action-args	2004-11-03 14:34:15.000000000 +0530
+++ linux-2.6.10-rc1-suparna/kernel/wait.c	2004-11-03 14:34:15.000000000 +0530
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
@@ -167,7 +167,8 @@ __wait_on_bit(wait_queue_head_t *wq, str
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
--- linux-2.6.10-rc1/mm/filemap.c~modify-wait-bit-action-args	2004-11-03 14:34:15.000000000 +0530
+++ linux-2.6.10-rc1-suparna/mm/filemap.c	2004-11-03 14:34:15.000000000 +0530
@@ -131,7 +131,7 @@ void remove_from_page_cache(struct page 
 	spin_unlock_irq(&mapping->tree_lock);
 }
 
-static int sync_page(void *word)
+static int sync_page(void *word, wait_queue_t *wait)
 {
 	struct address_space *mapping;
 	struct page *page;

_
