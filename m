Return-Path: <linux-kernel-owner+w=401wt.eu-S964971AbWL1I3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbWL1I3w (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 03:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbWL1I3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 03:29:51 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:50125 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964971AbWL1I3u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 03:29:50 -0500
Date: Thu, 28 Dec 2006 14:04:14 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, akpm@osdl.org, drepper@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       jakub@redhat.com, mingo@elte.hu
Subject: [FSAIO][PATCH 1/6] Add a wait queue parameter to the wait_bit action routine
Message-ID: <20061228083413.GA6971@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20061227153855.GA25898@in.ibm.com> <20061228082308.GA4476@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228082308.GA4476@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add a wait queue parameter to the action routine called by 
__wait_on_bit to allow it to determine whether to block or
not.

Signed-off-by: Suparna Bhattacharya <suparna@in.ibm.com>
Acked-by: Ingo Molnar <mingo@elte.hu>
---

 linux-2.6.20-rc1-root/fs/buffer.c                  |    2 +-
 linux-2.6.20-rc1-root/fs/inode.c                   |    2 +-
 linux-2.6.20-rc1-root/fs/nfs/inode.c               |    2 +-
 linux-2.6.20-rc1-root/fs/nfs/nfs4proc.c            |    2 +-
 linux-2.6.20-rc1-root/fs/nfs/pagelist.c            |    2 +-
 linux-2.6.20-rc1-root/include/linux/sunrpc/sched.h |    3 ++-
 linux-2.6.20-rc1-root/include/linux/wait.h         |   18 ++++++++++++------
 linux-2.6.20-rc1-root/include/linux/writeback.h    |    2 +-
 linux-2.6.20-rc1-root/kernel/wait.c                |   14 ++++++++------
 linux-2.6.20-rc1-root/mm/filemap.c                 |    2 +-
 linux-2.6.20-rc1-root/net/sunrpc/sched.c           |    5 +++--
 11 files changed, 32 insertions(+), 22 deletions(-)

diff -puN fs/buffer.c~modify-wait-bit-action-args fs/buffer.c
--- linux-2.6.20-rc1/fs/buffer.c~modify-wait-bit-action-args	2006-12-21 08:45:34.000000000 +0530
+++ linux-2.6.20-rc1-root/fs/buffer.c	2006-12-21 08:45:34.000000000 +0530
@@ -55,7 +55,7 @@ init_buffer(struct buffer_head *bh, bh_e
 	bh->b_private = private;
 }
 
-static int sync_buffer(void *word)
+static int sync_buffer(void *word, wait_queue_t *wait)
 {
 	struct block_device *bd;
 	struct buffer_head *bh
diff -puN fs/inode.c~modify-wait-bit-action-args fs/inode.c
--- linux-2.6.20-rc1/fs/inode.c~modify-wait-bit-action-args	2006-12-21 08:45:34.000000000 +0530
+++ linux-2.6.20-rc1-root/fs/inode.c	2006-12-21 08:45:34.000000000 +0530
@@ -1279,7 +1279,7 @@ void remove_dquot_ref(struct super_block
 
 #endif
 
-int inode_wait(void *word)
+int inode_wait(void *word, wait_queue_t *wait)
 {
 	schedule();
 	return 0;
diff -puN include/linux/wait.h~modify-wait-bit-action-args include/linux/wait.h
--- linux-2.6.20-rc1/include/linux/wait.h~modify-wait-bit-action-args	2006-12-21 08:45:34.000000000 +0530
+++ linux-2.6.20-rc1-root/include/linux/wait.h	2006-12-28 09:32:57.000000000 +0530
@@ -145,11 +145,15 @@ void FASTCALL(__wake_up(wait_queue_head_
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
@@ -427,7 +431,8 @@ int wake_bit_function(wait_queue_t *wait
  * but has no intention of setting it.
  */
 static inline int wait_on_bit(void *word, int bit,
-				int (*action)(void *), unsigned mode)
+				int (*action)(void *, wait_queue_t *),
+				unsigned mode)
 {
 	if (!test_bit(bit, word))
 		return 0;
@@ -451,7 +456,8 @@ static inline int wait_on_bit(void *word
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
--- linux-2.6.20-rc1/include/linux/writeback.h~modify-wait-bit-action-args	2006-12-21 08:45:34.000000000 +0530
+++ linux-2.6.20-rc1-root/include/linux/writeback.h	2006-12-21 08:45:34.000000000 +0530
@@ -66,7 +66,7 @@ struct writeback_control {
  */	
 void writeback_inodes(struct writeback_control *wbc);
 void wake_up_inode(struct inode *inode);
-int inode_wait(void *);
+int inode_wait(void *, wait_queue_t *);
 void sync_inodes_sb(struct super_block *, int wait);
 void sync_inodes(int wait);
 
diff -puN kernel/wait.c~modify-wait-bit-action-args kernel/wait.c
--- linux-2.6.20-rc1/kernel/wait.c~modify-wait-bit-action-args	2006-12-21 08:45:34.000000000 +0530
+++ linux-2.6.20-rc1-root/kernel/wait.c	2006-12-28 09:32:57.000000000 +0530
@@ -159,14 +159,14 @@ EXPORT_SYMBOL(wake_bit_function);
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
@@ -174,7 +174,8 @@ __wait_on_bit(wait_queue_head_t *wq, str
 EXPORT_SYMBOL(__wait_on_bit);
 
 int __sched fastcall out_of_line_wait_on_bit(void *word, int bit,
-					int (*action)(void *), unsigned mode)
+					int (*action)(void *, wait_queue_t *),
+					unsigned mode)
 {
 	wait_queue_head_t *wq = bit_waitqueue(word, bit);
 	DEFINE_WAIT_BIT(wait, word, bit);
@@ -185,14 +186,14 @@ EXPORT_SYMBOL(out_of_line_wait_on_bit);
 
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
@@ -202,7 +203,8 @@ __wait_on_bit_lock(wait_queue_head_t *wq
 EXPORT_SYMBOL(__wait_on_bit_lock);
 
 int __sched fastcall out_of_line_wait_on_bit_lock(void *word, int bit,
-					int (*action)(void *), unsigned mode)
+				int (*action)(void *, wait_queue_t *wait),
+				unsigned mode)
 {
 	wait_queue_head_t *wq = bit_waitqueue(word, bit);
 	DEFINE_WAIT_BIT(wait, word, bit);
diff -puN mm/filemap.c~modify-wait-bit-action-args mm/filemap.c
--- linux-2.6.20-rc1/mm/filemap.c~modify-wait-bit-action-args	2006-12-21 08:45:34.000000000 +0530
+++ linux-2.6.20-rc1-root/mm/filemap.c	2006-12-28 09:33:02.000000000 +0530
@@ -133,7 +133,7 @@ void remove_from_page_cache(struct page 
 	write_unlock_irq(&mapping->tree_lock);
 }
 
-static int sync_page(void *word)
+static int sync_page(void *word, wait_queue_t *wait)
 {
 	struct address_space *mapping;
 	struct page *page;
diff -puN fs/nfs/inode.c~modify-wait-bit-action-args fs/nfs/inode.c
--- linux-2.6.20-rc1/fs/nfs/inode.c~modify-wait-bit-action-args	2006-12-21 08:45:34.000000000 +0530
+++ linux-2.6.20-rc1-root/fs/nfs/inode.c	2006-12-21 08:45:34.000000000 +0530
@@ -380,7 +380,7 @@ void nfs_setattr_update_inode(struct ino
 	}
 }
 
-static int nfs_wait_schedule(void *word)
+static int nfs_wait_schedule(void *word, wait_queue_t *wait)
 {
 	if (signal_pending(current))
 		return -ERESTARTSYS;
diff -puN fs/nfs/nfs4proc.c~modify-wait-bit-action-args fs/nfs/nfs4proc.c
--- linux-2.6.20-rc1/fs/nfs/nfs4proc.c~modify-wait-bit-action-args	2006-12-21 08:45:34.000000000 +0530
+++ linux-2.6.20-rc1-root/fs/nfs/nfs4proc.c	2006-12-21 08:45:34.000000000 +0530
@@ -2738,7 +2738,7 @@ nfs4_async_handle_error(struct rpc_task 
 	return 0;
 }
 
-static int nfs4_wait_bit_interruptible(void *word)
+static int nfs4_wait_bit_interruptible(void *word, wait_queue_t *wait)
 {
 	if (signal_pending(current))
 		return -ERESTARTSYS;
diff -puN fs/nfs/pagelist.c~modify-wait-bit-action-args fs/nfs/pagelist.c
--- linux-2.6.20-rc1/fs/nfs/pagelist.c~modify-wait-bit-action-args	2006-12-21 08:45:34.000000000 +0530
+++ linux-2.6.20-rc1-root/fs/nfs/pagelist.c	2006-12-21 08:45:34.000000000 +0530
@@ -183,7 +183,7 @@ nfs_release_request(struct nfs_page *req
 	nfs_page_free(req);
 }
 
-static int nfs_wait_bit_interruptible(void *word)
+static int nfs_wait_bit_interruptible(void *word, wait_queue_t *wait)
 {
 	int ret = 0;
 
diff -puN net/sunrpc/sched.c~modify-wait-bit-action-args net/sunrpc/sched.c
--- linux-2.6.20-rc1/net/sunrpc/sched.c~modify-wait-bit-action-args	2006-12-21 08:45:34.000000000 +0530
+++ linux-2.6.20-rc1-root/net/sunrpc/sched.c	2006-12-21 08:45:34.000000000 +0530
@@ -258,7 +258,7 @@ void rpc_init_wait_queue(struct rpc_wait
 }
 EXPORT_SYMBOL(rpc_init_wait_queue);
 
-static int rpc_wait_bit_interruptible(void *word)
+static int rpc_wait_bit_interruptible(void *word, wait_queue_t *wait)
 {
 	if (signal_pending(current))
 		return -ERESTARTSYS;
@@ -294,7 +294,8 @@ static void rpc_mark_complete_task(struc
 /*
  * Allow callers to wait for completion of an RPC call
  */
-int __rpc_wait_for_completion_task(struct rpc_task *task, int (*action)(void *))
+int __rpc_wait_for_completion_task(struct rpc_task *task, int (*action)(
+			void *, wait_queue_t *wait))
 {
 	if (action == NULL)
 		action = rpc_wait_bit_interruptible;
diff -puN include/linux/sunrpc/sched.h~modify-wait-bit-action-args include/linux/sunrpc/sched.h
--- linux-2.6.20-rc1/include/linux/sunrpc/sched.h~modify-wait-bit-action-args	2006-12-21 08:45:34.000000000 +0530
+++ linux-2.6.20-rc1-root/include/linux/sunrpc/sched.h	2006-12-21 08:45:34.000000000 +0530
@@ -268,7 +268,8 @@ void *		rpc_malloc(struct rpc_task *, si
 void		rpc_free(struct rpc_task *);
 int		rpciod_up(void);
 void		rpciod_down(void);
-int		__rpc_wait_for_completion_task(struct rpc_task *task, int (*)(void *));
+int		__rpc_wait_for_completion_task(struct rpc_task *task,
+				int (*)(void *, wait_queue_t *wait));
 #ifdef RPC_DEBUG
 void		rpc_show_tasks(void);
 #endif
_
-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

