Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263330AbTDGIZe (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 04:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263333AbTDGIZa (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 04:25:30 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:32694 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263330AbTDGIZL (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 04:25:11 -0400
Date: Mon, 7 Apr 2003 14:11:43 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: akpm@digeo.com, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Sample aio wait patch using tsk->io_wait 
Message-ID: <20030407141143.A14149@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20030401215957.A1800@in.ibm.com> <20030401152713.B26513@redhat.com> <20030402154901.A1511@in.ibm.com> <20030403211221.A3411@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030403211221.A3411@in.ibm.com>; from suparna@in.ibm.com on Thu, Apr 03, 2003 at 09:12:21PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 09:12:21PM +0530, Suparna Bhattacharya wrote:
> On Wed, Apr 02, 2003 at 03:49:01PM +0530, Suparna Bhattacharya wrote:
> > On Tue, Apr 01, 2003 at 03:27:13PM -0500, Benjamin LaHaise wrote:
> > > On Tue, Apr 01, 2003 at 09:59:57PM +0530, Suparna Bhattacharya wrote:
> > > > I would really appreciate comments and review feedback 
> > > > from the perspective of fs developers especially on
> > > > the latter 2 patches in terms of whether this seems a 
> > > > sound approach or if I'm missing something very crucial
> > > > (which I just well might be)
> > > > Is this easy to do for other filesystems as well ?
> > > 
> > > I disagree with putting the iocb pointer in the task_struct: it feels 
> > > completely bogus as it modifies semantics behind the scenes without 
> > > fixing APIs.
> 
> I later remembered one more reason why I'd tried this out -- it
> enabled me to play with async handling of page faults (i.e. an
> async fault_in_pages .. or a retriable copy_xxx_user). I didn't
> want to inclue that code until/unless I saw some real gains, so its
> not an important consideration, but nevertheless it was an
> added flexibility.
> 
> BTW, does making this a wait queue entry pointer rather than iocb 
> pointer sound any better (i.e tsk->io_wait instead of tsk->iocb) ? The
> code turns out to be cleaner, and the semantics feels a little
> more natural ... (though maybe its just because I've become used
> to it :))
> 

OK, here's a sample of what I meant.

Regards
Suparna

diff -pur linux-2.5.66/include/linux/aio.h linux-2.5.66aio/include/linux/aio.h
--- linux-2.5.66/include/linux/aio.h	Tue Mar 25 03:29:54 2003
+++ linux-2.5.66aio/include/linux/aio.h	Thu Apr  3 17:14:08 2003
@@ -151,6 +161,14 @@ extern void FASTCALL(exit_aio(struct mm_
 #define get_ioctx(kioctx)	do { if (unlikely(atomic_read(&(kioctx)->users) <= 0)) BUG(); atomic_inc(&(kioctx)->users); } while (0)
 #define put_ioctx(kioctx)	do { if (unlikely(atomic_dec_and_test(&(kioctx)->users))) __put_ioctx(kioctx); else if (unlikely(atomic_read(&(kioctx)->users) < 0)) BUG(); } while (0)
 
+#define do_sync_op(op)		do { \
+	DEFINE_WAIT(sync_wait); \
+	wait_queue_t *wait = current->io_wait; \
+	current->io_wait = &sync_wait; \
+	op; \
+	current->io_wait = wait; \
+	} while (0);
+
 #include <linux/aio_abi.h>
 
 static inline struct kiocb *list_kiocb(struct list_head *h)
diff -pur linux-2.5.66/include/linux/init_task.h linux-2.5.66aio/include/linux/init_task.h
--- linux-2.5.66/include/linux/init_task.h	Tue Mar 25 03:30:00 2003
+++ linux-2.5.66aio/include/linux/init_task.h	Thu Apr  3 13:36:07 2003
@@ -103,6 +103,7 @@
 	.alloc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
 	.journal_info	= NULL,						\
+	.io_wait	= NULL,						\
 }
 
 
diff -pur linux-2.5.66/include/linux/sched.h linux-2.5.66aio/include/linux/sched.h
--- linux-2.5.66/include/linux/sched.h	Tue Mar 25 03:30:00 2003
+++ linux-2.5.66aio/include/linux/sched.h	Thu Apr  3 13:18:28 2003
@@ -438,6 +438,8 @@ struct task_struct {
 
 	unsigned long ptrace_message;
 	siginfo_t *last_siginfo; /* For ptrace use.  */
+/* current io wait handle */
+	wait_queue_t *io_wait;
 };
 
 extern void __put_task_struct(struct task_struct *tsk);
diff -pur linux-2.5.66/include/linux/wait.h linux-2.5.66aio/include/linux/wait.h
--- linux-2.5.66/include/linux/wait.h	Tue Mar 25 03:30:44 2003
+++ linux-2.5.66aio/include/linux/wait.h	Thu Apr  3 13:51:11 2003
@@ -80,6 +80,8 @@ static inline int waitqueue_active(wait_
 	return !list_empty(&q->task_list);
 }
 
+#define is_sync_wait(wait)	((wait)->task != NULL)
+
 extern void FASTCALL(add_wait_queue(wait_queue_head_t *q, wait_queue_t * wait));
 extern void FASTCALL(add_wait_queue_exclusive(wait_queue_head_t *q, wait_queue_t * wait));
 extern void FASTCALL(remove_wait_queue(wait_queue_head_t *q, wait_queue_t * wait));
diff -pur linux-2.5.66/kernel/fork.c linux-2.5.66aio/kernel/fork.c
--- linux-2.5.66/kernel/fork.c	Tue Mar 25 03:30:00 2003
+++ linux-2.5.66aio/kernel/fork.c	Thu Apr  3 13:35:21 2003
@@ -139,8 +139,9 @@ void remove_wait_queue(wait_queue_head_t
 void prepare_to_wait(wait_queue_head_t *q, wait_queue_t *wait, int state)
 {
 	unsigned long flags;
-
-	__set_current_state(state);
+	
+	if (is_sync_wait(wait))
+		__set_current_state(state);
 	wait->flags &= ~WQ_FLAG_EXCLUSIVE;
 	spin_lock_irqsave(&q->lock, flags);
 	if (list_empty(&wait->task_list))
@@ -153,7 +154,8 @@ prepare_to_wait_exclusive(wait_queue_hea
 {
 	unsigned long flags;
 
-	__set_current_state(state);
+	if (is_sync_wait(wait))
+		__set_current_state(state);
 	wait->flags |= WQ_FLAG_EXCLUSIVE;
 	spin_lock_irqsave(&q->lock, flags);
 	if (list_empty(&wait->task_list))
@@ -856,6 +858,7 @@ static struct task_struct *copy_process(
 	p->lock_depth = -1;		/* -1 = no lock */
 	p->start_time = get_jiffies_64();
 	p->security = NULL;
+	p->io_wait = NULL;
 
 	retval = -ENOMEM;
 	if (security_task_alloc(p))
diff -pur linux-2.5.66/mm/filemap.c linux-2.5.66aio/mm/filemap.c
--- linux-2.5.66/mm/filemap.c	Tue Mar 25 03:30:15 2003
+++ linux-2.5.66aio/mm/filemap.c	Thu Apr  3 16:54:33 2003
@@ -254,19 +254,29 @@ static wait_queue_head_t *page_waitqueue
 	return &zone->wait_table[hash_ptr(page, zone->wait_table_bits)];
 }
 
-void wait_on_page_bit(struct page *page, int bit_nr)
+int wait_on_page_bit_async(struct page *page, int bit_nr)
 {
 	wait_queue_head_t *waitqueue = page_waitqueue(page);
-	DEFINE_WAIT(wait);
-
+	wait_queue_t *wait = current->io_wait;
+		
 	do {
-		prepare_to_wait(waitqueue, &wait, TASK_UNINTERRUPTIBLE);
+		prepare_to_wait(waitqueue, wait, TASK_UNINTERRUPTIBLE);
 		if (test_bit(bit_nr, &page->flags)) {
 			sync_page(page);
+			if (!is_sync_wait(wait))
+				return -EIOCBQUEUED;
 			io_schedule();
 		}
 	} while (test_bit(bit_nr, &page->flags));
-	finish_wait(waitqueue, &wait);
+	finish_wait(waitqueue, wait);
+
+	return 0;
+}
+EXPORT_SYMBOL(wait_on_page_bit_async);
+
+void wait_on_page_bit(struct page *page, int bit_nr)
+{
+	do_sync_op(wait_on_page_bit_async(page, bit_nr));
 }
 EXPORT_SYMBOL(wait_on_page_bit);
 
