Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbUBTOll (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 09:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbUBTOll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 09:41:41 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:43404 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S261214AbUBTOlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 09:41:36 -0500
Date: Fri, 20 Feb 2004 15:40:42 +0100
From: Miquel van Smoorenburg <miquels@cistron.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <piggin@cyberone.com.au>, miquels@cistron.nl, axboe@suse.de,
       linux-lvm@sistina.com, linux-kernel@vger.kernel.org,
       thornber@redhat.com
Subject: [PATCH] bdi_congestion_funp (was: Re: [PATCH] per process request limits (was Re: IO scheduler, queue depth, nr_requests))
Message-ID: <20040220144042.GC20917@traveler.cistron.net>
References: <20040218182628.7eb63d57.akpm@osdl.org> <20040219101519.GG30621@drinkel.cistron.nl> <20040219101915.GJ27190@suse.de> <20040219205907.GE32263@drinkel.cistron.nl> <40353E30.6000105@cyberone.com.au> <20040219235303.GI32263@drinkel.cistron.nl> <40355F03.9030207@cyberone.com.au> <20040219172656.77c887cf.akpm@osdl.org> <40356599.3080001@cyberone.com.au> <20040219183218.2b3c4706.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040219183218.2b3c4706.akpm@osdl.org> (from akpm@osdl.org on Fri, Feb 20, 2004 at 03:32:18 +0100)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004.02.20 03:32, Andrew Morton wrote:
> Nick Piggin <piggin@cyberone.com.au> wrote:
> >
> > 
> > 
> > Andrew Morton wrote:
> > 
> > >Nick Piggin <piggin@cyberone.com.au> wrote:
> > >
> > >>Even with this patch, it might still be a good idea to allow
> > >>pdflush to disregard the limits...
> > >>
> > >
> > >Has it been confirmed that pdflush is blocking in get_request_wait()?  I
> > >guess that can happen very occasionally because we don't bother with any
> > >locking around there but if it's happening a lot then something is bust.
> > >
> > >
> > 
> > Miquel's analysis is pretty plausible, but I'm not sure if
> > he's confirmed it or not, Miquel?

Yes, I've added current->comm to my debug printk's, and it's dd/pdflush
that both block in get_request_wait (alternating between the two).

> > Even if it isn't happening
> > a lot, and something isn't bust it might be a good idea to
> > do this.
> 
> Seems OK from a quick check.  pdflush will block in get_request_wait()
> occasionally, but not at all often.  Perhaps we could move the
> write_congested test into the mpage_writepages() inner loop but it hardly
> seems worth the risk.
> 
> Maybe things are different on Miquel's clockwork controller.

I haven't tested it yet because of the "This patch isn't actually so good"
comment, but I found another explanation.

>  drivers/block/ll_rw_blk.c |    2 ++
>  fs/fs-writeback.c         |    2 ++
>  2 files changed, 4 insertions(+)

*Lightbulb on* .. I just read fs-writeback.c. As I said, this happens with an
LVM device. Could it be that because LVM and the actual device have different struct
request_queue's things go awry ?

In fs-writeback.c, your're looking at the LVM device (and its request_queue, and
its backing_dev_info). In__make_request, you're looking at the SCSI device.

So that's why I saw "dd" and pdflush fighting over get_request. pdflush isn't
supposed to run when the blockdev is congested, but ofcourse the LVM device
is never marked as congested.

The same can happen with MD devices, I think. Here's another proof-of-concept
patch that fixes things for LVM. With this patch applied, I never see pdflush
running when the queue is congested. You'll probably mark it as "horrible",
but hey, it shows the problem clear enough..

This patch adds a function pointer to the backing_dev_info struct that can
be called to check on the congestion if it's anything other than a simple device.
Dm.c now sets this pointer to a function defined in dm-table.c that checks
the congestion bits on all devices part of the logical volume.

I'm not sure if it should be the other way around (ll_rw_blk setting the
congested bit in the LVM device instead). Also if any queue of any device
under LVM is congested, pdflush won't run on the whole device - but I think
that harms less than running on a device with a congested queue.

bdi-congestion-funp.patch

--- linux-2.6.3/include/linux/backing-dev.h.ORIG	2004-02-04 04:43:38.000000000 +0100
+++ linux-2.6.3/include/linux/backing-dev.h	2004-02-20 15:17:52.000000000 +0100
@@ -24,6 +24,8 @@
 	unsigned long ra_pages;	/* max readahead in PAGE_CACHE_SIZE units */
 	unsigned long state;	/* Always use atomic bitops on this */
 	int memory_backed;	/* Cannot clean pages with writepage */
+	int (*congested)(int, void *); /* Function pointer if device is md/dm */
+	void *aux;		/* Pointer to aux data for congested func */
 };
 
 extern struct backing_dev_info default_backing_dev_info;
@@ -34,11 +36,15 @@
 
 static inline int bdi_read_congested(struct backing_dev_info *bdi)
 {
+	if (bdi->congested)
+		return bdi->congested(BDI_read_congested, bdi->aux);
 	return test_bit(BDI_read_congested, &bdi->state);
 }
 
 static inline int bdi_write_congested(struct backing_dev_info *bdi)
 {
+	if (bdi->congested)
+		return bdi->congested(BDI_write_congested, bdi->aux);
 	return test_bit(BDI_write_congested, &bdi->state);
 }
 
--- linux-2.6.3/drivers/md/dm.h.ORIG	2004-02-20 15:15:16.000000000 +0100
+++ linux-2.6.3/drivers/md/dm.h	2004-02-20 15:12:30.000000000 +0100
@@ -115,6 +115,7 @@
 int dm_table_get_mode(struct dm_table *t);
 void dm_table_suspend_targets(struct dm_table *t);
 void dm_table_resume_targets(struct dm_table *t);
+int dm_table_any_congested(int bdi_state, void *aux);
 
 /*-----------------------------------------------------------------
  * A registry of target types.
--- linux-2.6.3/drivers/md/dm-table.c.ORIG	2004-02-04 04:44:59.000000000 +0100
+++ linux-2.6.3/drivers/md/dm-table.c	2004-02-20 15:14:35.000000000 +0100
@@ -857,6 +857,30 @@
 	}
 }
 
+/*
+ *	See if any device in the logical volume has a queue
+ *	that is congested - in that case, pdflush skips it.
+ */
+int dm_table_any_congested(int bdi_state, void *aux)
+{
+	struct mapped_device *md = aux;
+	struct dm_table *t;
+	struct list_head *d, *devices;
+	int r = 0;
+										
+	if ((t = dm_get_table(md)) == NULL)
+		return 0;
+										
+	devices = dm_table_get_devices(t);
+	for (d = devices->next; d != devices; d = d->next) {
+		struct dm_dev *dd = list_entry(d, struct dm_dev, list);
+		request_queue_t *q = bdev_get_queue(dd->bdev);
+		r |= test_bit(bdi_state, &(q->backing_dev_info.state));
+	}
+	dm_table_put(t);
+										
+	return r;
+}
 
 EXPORT_SYMBOL(dm_get_device);
 EXPORT_SYMBOL(dm_put_device);
--- linux-2.6.3/drivers/md/dm.c.ORIG	2004-02-20 15:15:02.000000000 +0100
+++ linux-2.6.3/drivers/md/dm.c	2004-02-20 15:14:51.000000000 +0100
@@ -608,6 +608,8 @@
 	}
 
 	md->queue->queuedata = md;
+	md->queue->backing_dev_info.congested = dm_table_any_congested;
+	md->queue->backing_dev_info.aux = md;
 	blk_queue_make_request(md->queue, dm_request);
 
 	md->io_pool = mempool_create(MIN_IOS, mempool_alloc_slab,
