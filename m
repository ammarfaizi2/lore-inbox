Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264061AbUGBQdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264061AbUGBQdW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 12:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264717AbUGBQc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 12:32:28 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:15075 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264723AbUGBQaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 12:30:22 -0400
Date: Fri, 2 Jul 2004 22:09:46 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Cc: linux-osdl@osdl.org
Subject: Re: [PATCH 20/22] AIO poll
Message-ID: <20040702163946.GJ3450@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20040702130030.GA4256@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040702130030.GA4256@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2004 at 06:30:30PM +0530, Suparna Bhattacharya wrote:
> The patchset contains modifications and fixes to the AIO core
> to support the full retry model, an implementation of AIO
> support for buffered filesystem AIO reads and O_SYNC writes
> (the latter courtesy O_SYNC speedup changes from Andrew Morton),
> an implementation of AIO reads and writes to pipes (from
> Chris Mason) and AIO poll (again from Chris Mason).
> 
> Full retry infrastructure and fixes
> [1] aio-retry.patch
> [2] 4g4g-aio-hang-fix.patch
> [3] aio-retry-elevated-refcount.patch
> [4] aio-splice-runlist.patch
> 
> FS AIO read
> [5] aio-wait-page.patch
> [6] aio-fs_read.patch
> [7] aio-upfront-readahead.patch
> 
> AIO for pipes
> [8] aio-cancel-fix.patch
> [9] aio-read-immediate.patch
> [10] aio-pipe.patch
> [11] aio-context-switch.patch
> 
> Concurrent O_SYNC write speedups using radix-tree walks
> [12] writepages-range.patch
> [13] fix-writeback-range.patch
> [14] fix-writepages-range.patch
> [15] fdatawrite-range.patch
> [16] O_SYNC-speedup.patch
> 
> AIO O_SYNC write
> [17] aio-wait_on_page_writeback_range.patch
> [18] aio-O_SYNC.patch
> [19] O_SYNC-write-fix.patch
> 
> AIO poll
> [20] aio-poll.patch
> 

Todo: fixup to merge with recent kiocb->private changes

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India
---------------------------------------------------

From: Chris Mason

AIO poll support
 
I've attached the patch, it's not quite as obvious as the pipe code, but
not too bad.  I'm not sure if I'm using struct kiocb->private the way it
was intended, but I don't see any other code touching it, so it should
be ok.

On Mon 2004-02-23 at 14:05, Suparna Bhattacharya wrote:
> I was wondering if a particular fop->poll routine, could possibly
> invoke __pollwait for more than one wait queue (I don't know if such
> a case even exists). That kind of a thing would work OK with the existing
> poll logic, but not in our case, because we'd end up queueing the same
> wait queue on two queues which would be a problem.

Oh, I see what you mean.  I looked at a few of the poll_wait callers,
and it seems safe, but there are too many for a full audit right now.
The attached patch fixes the page allocation problem and adds a check to
make sure we don't abuse current->io_wait.  An oops is better than
random corruption at least.
                                                                                
I ran it through my basic test and pipetest, the pipetest results are
below.  The pipetest epoll usage needs updating, so I can only compare
against regular poll.
                                                                                
./pipetest --aio-poll 10000 1 5
using 10000 pipe pairs, 1 message threads, 5 generations, 12 bufsize
Ok! Mode aio-poll: 5 passes in 0.000073 seconds
passes_per_sec: 68493.15
coffee:/usr/src/aio # ./pipetest 10000 1 5
using 10000 pipe pairs, 1 message threads, 5 generations, 12 bufsize
Ok! Mode poll: 5 passes in 0.083066 seconds
passes_per_sec: 60.19

Here are some optimizations.  aio-poll-3 avoids wake_up when it can use
finish_wait instead, and adds a fast path to aio-poll for when data is
already available.
                                                                                

 fs/aio.c                |   17 +++++++
 fs/select.c             |  104 +++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/aio.h     |    1 
 include/linux/aio_abi.h |    2 
 4 files changed, 122 insertions(+), 2 deletions(-)

--- aio/fs/aio.c	2004-06-21 10:58:18.206817768 -0700
+++ aio-poll/fs/aio.c	2004-06-21 10:58:39.700550224 -0700
@@ -1361,6 +1361,16 @@ static ssize_t aio_fsync(struct kiocb *i
 }
 
 /*
+ * Retry method for aio_poll (also used for first time submit)
+ * Responsible for updating iocb state as retries progress
+ */
+static ssize_t aio_poll(struct kiocb *iocb)
+{
+	unsigned events = (unsigned)(iocb->ki_buf);
+	return generic_aio_poll(iocb, events);
+}
+
+/*
  * aio_setup_iocb:
  *	Performs the initial checks and aio retry method
  *	setup for the kiocb at the time of io submission.
@@ -1405,6 +1415,13 @@ ssize_t aio_setup_iocb(struct kiocb *kio
 		if (file->f_op->aio_fsync)
 			kiocb->ki_retry = aio_fsync;
 		break;
+	case IOCB_CMD_POLL:
+		ret = -EINVAL;
+		if (file->f_op->poll) {
+			memset(kiocb->private, 0, sizeof(kiocb->private));
+			kiocb->ki_retry = aio_poll;
+		}
+		break;
 	default:
 		dprintk("EINVAL: io_submit: no operation provided\n");
 		ret = -EINVAL;
--- aio/fs/select.c	2004-06-15 22:18:54.000000000 -0700
+++ aio-poll/fs/select.c	2004-06-21 10:58:39.702549920 -0700
@@ -21,6 +21,7 @@
 #include <linux/personality.h> /* for STICKY_TIMEOUTS */
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/aio.h>
 
 #include <asm/uaccess.h>
 
@@ -39,6 +40,12 @@ struct poll_table_page {
 	struct poll_table_entry entries[0];
 };
 
+struct aio_poll_table {
+	int init;
+	struct poll_wqueues wq;
+	struct poll_table_page table;
+};
+
 #define POLL_TABLE_FULL(table) \
 	((unsigned long)((table)->entry+1) > PAGE_SIZE + (unsigned long)(table))
 
@@ -109,12 +116,34 @@ void __pollwait(struct file *filp, wait_
 	/* Add a new entry */
 	{
 		struct poll_table_entry * entry = table->entry;
+		wait_queue_t *wait;
+		wait_queue_t *aio_wait = current->io_wait;
+
+		if (aio_wait) {
+			/* for aio, there can only be one wait_address.
+			 * we might be adding it again via a retry call
+			 * if so, just return.
+			 * if not, bad things are happening
+			 */
+			if (table->entry != table->entries) {
+				if (table->entries[0].wait_address != wait_address)
+					BUG();
+				return;
+			}
+		}
+
 		table->entry = entry+1;
 	 	get_file(filp);
 	 	entry->filp = filp;
 		entry->wait_address = wait_address;
 		init_waitqueue_entry(&entry->wait, current);
-		add_wait_queue(wait_address,&entry->wait);
+
+		/* if we're in aioland, use current->io_wait */
+		if (aio_wait)
+			wait = aio_wait;
+		else
+			wait = &entry->wait;
+		add_wait_queue(wait_address,wait);
 	}
 }
 
@@ -533,3 +562,76 @@ out_fds:
 	poll_freewait(&table);
 	return err;
 }
+
+static void aio_poll_freewait(struct aio_poll_table *ap, struct kiocb *iocb)
+{
+	struct poll_table_page * p = ap->wq.table;
+	if (p) {
+		struct poll_table_entry * entry = p->entry;
+		if (entry > p->entries) {
+			/*
+			 * there is only one entry for aio polls
+			 */
+			entry = p->entries;
+			if (iocb)
+				finish_wait(entry->wait_address,&iocb->ki_wait);
+			else
+				wake_up(entry->wait_address);
+			fput(entry->filp);
+		}
+	}
+	ap->init = 0;
+}
+
+static int
+aio_poll_cancel(struct kiocb *iocb, struct io_event *evt)
+{
+	struct aio_poll_table *aio_table;
+	aio_table = (struct aio_poll_table *)iocb->private;
+	
+	evt->obj = (u64)(unsigned long)iocb-> ki_obj.user;
+	evt->data = iocb->ki_user_data;
+	evt->res = iocb->ki_nbytes - iocb->ki_left;
+	if (evt->res == 0)
+	        evt->res = -EINTR;
+	evt->res2 = 0;
+	if (aio_table->init)
+		aio_poll_freewait(aio_table, NULL);
+	aio_put_req(iocb);
+	return 0;
+}
+
+ssize_t generic_aio_poll(struct kiocb *iocb, unsigned events)
+{
+	struct aio_poll_table *aio_table;
+	unsigned mask;
+	struct file *file = iocb->ki_filp;
+	aio_table = (struct aio_poll_table *)iocb->private;
+
+	/* fast path */
+	mask = file->f_op->poll(file, NULL);
+	mask &= events | POLLERR | POLLHUP;
+	if (mask)
+		return mask;
+
+	if ((sizeof(*aio_table) + sizeof(struct poll_table_entry)) >
+	    sizeof(iocb->private))
+		BUG();
+
+	if (!aio_table->init) {
+		aio_table->init = 1;
+		poll_initwait(&aio_table->wq);
+		aio_table->wq.table = &aio_table->table;
+		aio_table->table.next = NULL;
+		aio_table->table.entry = aio_table->table.entries;
+	}
+	iocb->ki_cancel = aio_poll_cancel;
+
+	mask = file->f_op->poll(file, &aio_table->wq.pt);
+	mask &= events | POLLERR | POLLHUP;
+	if (mask) {
+		aio_poll_freewait(aio_table, iocb);
+		return mask;
+	}
+	return -EIOCBRETRY;
+}
--- aio/include/linux/aio.h	2004-06-21 10:58:18.206817768 -0700
+++ aio-poll/include/linux/aio.h	2004-06-21 10:58:39.702549920 -0700
@@ -201,4 +201,5 @@ static inline struct kiocb *list_kiocb(s
 extern atomic_t aio_nr;
 extern unsigned aio_max_nr;
 
+extern ssize_t generic_aio_poll(struct kiocb *, unsigned);
 #endif /* __LINUX__AIO_H */
--- aio/include/linux/aio_abi.h	2004-06-15 22:18:58.000000000 -0700
+++ aio-poll/include/linux/aio_abi.h	2004-06-21 10:58:39.703549768 -0700
@@ -38,8 +38,8 @@ enum {
 	IOCB_CMD_FDSYNC = 3,
 	/* These two are experimental.
 	 * IOCB_CMD_PREADX = 4,
-	 * IOCB_CMD_POLL = 5,
 	 */
+	IOCB_CMD_POLL = 5,
 	IOCB_CMD_NOOP = 6,
 };
 
