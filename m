Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263752AbUD0D7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbUD0D7z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 23:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263754AbUD0D7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 23:59:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:31360 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263752AbUD0D7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 23:59:48 -0400
Date: Mon, 26 Apr 2004 20:59:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: sgoel01@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc{1,2} bad VM/NFS interaction in case of dirty page
 writeback
Message-Id: <20040426205928.58d76dbc.akpm@osdl.org>
In-Reply-To: <1083035471.3710.65.camel@lade.trondhjem.org>
References: <20040427011237.33342.qmail@web12824.mail.yahoo.com>
	<20040426191512.69485c42.akpm@osdl.org>
	<1083035471.3710.65.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> On Mon, 2004-04-26 at 22:15, Andrew Morton wrote:
> > WRITEPAGE_ACTIVATE is a bit of a hack to fix up specific peculiarities of
> > the interaction between tmpfs and page reclaim.
> > 
> > Trond, the changelog for that patch does not explain what is going on in
> > there - can you help out?
> 
> As far as I understand, the WRITEPAGE_ACTIVATE hack is supposed to allow
> filesystems to defer actually starting the I/O until the call to
> ->writepages(). This is indeed beneficial to NFS, since most servers
> will work more efficiently if we cluster NFS write requests into "wsize"
> sized chunks.

No, it's purely used by tmpfs when we discover the page was under mlock or
we've run out of swapspace.

Yes, single-page writepage off the LRU is inefficient and we want
writepages() to do most of the work.  For most workloads, this is the case.
It's only the whacky mmap-based test which should encounter significant
amounts of vmscan.c writepage activity.  If you're seeing much traffic via
that route I'd be interested in knowing what the workload is.

There's one scenario in which we _do_ do too much writepage off the LRU,
and that's on 1G ia32 highmem boxes: the tiny highmem zone is smaller than
dirty_ratio and vmscan ends up doing work which balance_dirty_pages()
should have done.  Hard to fix, apart from reducing the dirty memory
limits.

> > Also, what's the theory behind the handling of BDI_write_congested and
> > nfs_wait_on_write_congestion() in nfs_writepages()?  From a quick peek it
> > looks like NFS should be waking the sleepers in blk_congestion_wait()
> > rather than doing it privately?
> 
> The idea is mainly to prevent tasks from scheduling new writes if we are
> in the situation of wanting to reclaim or otherwise flush out dirty
> pages. IOW: I am assuming that the writepages() method is usually called
> only when we are low on memory and/or if pdflush() was triggered.

writepages() is called by pdflush when the dirty memory exceeds
dirty_background_ratio and it is called by the write(2) caller when dirty
memory exceeds dirty_ratio.

balance_dirty_pages() will throttle the write(2) caller when we hit
dirty_ratio.  balance_dirty_pages() attempts to prevent amount of dirty
memory from exceeding dirty_ratio by blocking the write(2) caller.

> > yup.  We should be able to handle the throttling and writeback scheduling
> > from within core VFS/VM.  NFS should set and clear the backing_dev
> > congestion state appropriately and the VFS should take care of the rest. 
> > The missing bit is the early blk_congestion_wait() termination.
> 
> Err... I appear to be missing something here. What is it you mean by
> *early* blk_congestion_wait() termination?

In the various places where the VM/VFS decides "gee, we need to wait for
some write I/O to terminate" it will call blk_congestion_wait() (the
function is seriously misnamed nowadays).  blk_congestion_wait() will wait
for a certain number of milliseconds, but that wait will terminate earlier
if the block layer completes some write requests.  So if writes are being
retired quickly, the sleeps are shorter.

What we've never had, and which I expected we'd need a year ago was a
connection between network filesytems and blk_congestion_wait().  At
present, if someone calls blk_congestion_wait(HZ/20) when the only write
I/O in flight is NFS, they will sleep for 50 milliseconds no matter what's
going on.  What we should do is to deliver a wakeup from within NFS to the
blk_congestion_wait() sleepers when write I/O has completed.  


Throttling of NFS writers should be working OK in 2.6.5.  The only problem
of which I am aware is that the callers of try_to_free_pages() and
balance_dirty_pages() may be sleeping for too long in
blk_congestion_wait().  We can address that by calling into
clear_backing_dev_congested() (see below) from the place in NFS where we
determine that writes have completed.  Of course there may be additional
problems of which I'm unaware.






---

 25-akpm/drivers/block/ll_rw_blk.c |   20 +++++++++++++-------
 25-akpm/include/linux/writeback.h |    1 +
 2 files changed, 14 insertions(+), 7 deletions(-)

diff -puN drivers/block/ll_rw_blk.c~clear_baking_dev_congested drivers/block/ll_rw_blk.c
--- 25/drivers/block/ll_rw_blk.c~clear_baking_dev_congested	2004-04-26 20:52:05.752041120 -0700
+++ 25-akpm/drivers/block/ll_rw_blk.c	2004-04-26 20:54:20.997480688 -0700
@@ -95,22 +95,28 @@ static inline int queue_congestion_off_t
 	return ret;
 }
 
-/*
- * A queue has just exitted congestion.  Note this in the global counter of
- * congested queues, and wake up anyone who was waiting for requests to be
- * put back.
- */
-static void clear_queue_congested(request_queue_t *q, int rw)
+void clear_backing_dev_congested(struct backing_dev_info *bdi, int rw)
 {
 	enum bdi_state bit;
 	wait_queue_head_t *wqh = &congestion_wqh[rw];
 
 	bit = (rw == WRITE) ? BDI_write_congested : BDI_read_congested;
-	clear_bit(bit, &q->backing_dev_info.state);
+	clear_bit(bit, &bdi->state);
 	smp_mb__after_clear_bit();
 	if (waitqueue_active(wqh))
 		wake_up(wqh);
 }
+EXPORT_SYMBOL(clear_backing_dev_congested);
+
+/*
+ * A queue has just exitted congestion.  Note this in the global counter of
+ * congested queues, and wake up anyone who was waiting for requests to be
+ * put back.
+ */
+static void clear_queue_congested(request_queue_t *q, int rw)
+{
+	clear_backing_dev_congested(&q->backing_dev_info, rw);
+}
 
 /*
  * A queue has just entered congestion.  Flag that in the queue's VM-visible
diff -puN include/linux/writeback.h~clear_baking_dev_congested include/linux/writeback.h
--- 25/include/linux/writeback.h~clear_baking_dev_congested	2004-04-26 20:53:19.680802240 -0700
+++ 25-akpm/include/linux/writeback.h	2004-04-26 20:53:36.333270680 -0700
@@ -97,5 +97,6 @@ int do_writepages(struct address_space *
 extern int nr_pdflush_threads;	/* Global so it can be exported to sysctl
 				   read-only. */
 
+void clear_backing_dev_congested(struct backing_dev_info *bdi, int rw);
 
 #endif		/* WRITEBACK_H */

_

