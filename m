Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267779AbUH2MSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267779AbUH2MSQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 08:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267786AbUH2MSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 08:18:15 -0400
Received: from av5-1-sn1.fre.skanova.net ([81.228.11.111]:23749 "EHLO
	av5-1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S267779AbUH2MRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 08:17:43 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Speed up the cdrw packet writing driver
References: <m33c2py1m1.fsf@telia.com> <20040823114329.GI2301@suse.de>
	<m3llg5dein.fsf@telia.com> <20040824202951.GA24280@suse.de>
	<m3hdqsckoo.fsf@telia.com> <20040825065055.GA2321@suse.de>
	<m3u0unwplj.fsf@telia.com> <20040828130757.GA2397@suse.de>
	<m3zn4ff6jy.fsf@telia.com> <20040828124519.0caf23bf.akpm@osdl.org>
	<m3vff3f0a3.fsf@telia.com> <20040828142332.4bbce4fc.akpm@osdl.org>
From: Peter Osterlund <petero2@telia.com>
Date: 29 Aug 2004 14:17:34 +0200
Message-ID: <m3isb2dtpd.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Peter Osterlund <petero2@telia.com> wrote:
> >
> >  OK, this should make sure that dirty data is flushed as fast as the
> >  disks can handle, but is there anything that makes sure there will be
> >  enough dirty data to flush for each disk?
> 
> Page allocation is fairly decoupled from the dirty memory thresholds.  The
> process which wants to write to the fast disk will skirt around the pages
> which are dirty against the slow disk and will reclaim clean pagecache
> instead.  So the writer to the fast disk _should_ be able to allocate pages
> sufficiently quickly.
> 
> The balance_dirty_pages() logic doesn't care (or know) about whether the
> pages are dirty against a slow device of a fast one - it just keeps the
> queues full while clamping the amount of dirty memory.  I do think that
> it's possible for the writer to the fast device to get blocked in
> balance_dirty_pages() due to there being lots of dirty pages against a slow
> device.
> 
> Or not - the fact that the fast device retires writes more quickly will
> cause waiters in balance_dirty_pages() to unblock promptly.
> 
> Or not not - we'll probably get into the situation where almost all of the
> dirty pages are dirty against the slower device.
> 
> hm.  It needs some verification testing.

I ran some more tests with the patch below, which marks the queue
congested as Jens suggested. I started a dd process writing to the DVD
and got a stable 5.3MB/s writing speed. Then I waited until 400MB
memory was dirty and started a second dd process writing to the hard
disk. This dd process now writes at 45MB/s. The bio queue in the
packet driver stays at ~4000 entries during the test, so I think this
proves that the VM *can* handle two devices well even though they have
very different write bandwidths.

However, all is not well, because write performance on the DVD goes to
~200kb/s when I start the second dd process (because of lots of read
gathering in the packet driver) and as I noted in an earlier mail,
write performance is also bad if many files are written, even when
there are no concurrent writes to the hard disk.

If I dd directly to /dev/pktcdvd/0 instead of a file on a udf or ext2
filesystem, I don't see the DVD write speed slowdown when I start the
second dd process that writes to the hard disk. For some reason, dirty
data is flushed in a suboptimal order when the udf or ext2 filesystems
are involved.

---

 linux-petero/drivers/block/ll_rw_blk.c |    6 ++++--
 linux-petero/drivers/block/pktcdvd.c   |    8 ++++++++
 linux-petero/include/linux/blkdev.h    |    2 ++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff -puN drivers/block/pktcdvd.c~packet-congest drivers/block/pktcdvd.c
--- linux/drivers/block/pktcdvd.c~packet-congest	2004-08-28 10:18:48.000000000 +0200
+++ linux-petero/drivers/block/pktcdvd.c	2004-08-29 13:21:20.000000000 +0200
@@ -981,6 +981,9 @@ try_next_bio:
 	}
 	spin_unlock(&pd->lock);
 
+	if (pd->bio_queue_size < 3600)
+		clear_queue_congested(pd->disk->queue, WRITE);
+
 	pkt->sleep_time = max(PACKET_WAIT_TIME, 1);
 	pkt_set_state(pkt, PACKET_WAITING_STATE);
 	atomic_set(&pkt->run_sm, 1);
@@ -2159,6 +2162,11 @@ static int pkt_make_request(request_queu
 		goto end_io;
 	}
 
+	if (pd->bio_queue_size >= 4096)
+		set_queue_congested(q, WRITE);
+	while (pd->bio_queue_size >= 4200)
+		blk_congestion_wait(WRITE, HZ / 10);
+
 	blk_queue_bounce(q, &bio);
 
 	zone = ZONE(bio->bi_sector, pd);
diff -puN drivers/block/ll_rw_blk.c~packet-congest drivers/block/ll_rw_blk.c
--- linux/drivers/block/ll_rw_blk.c~packet-congest	2004-08-28 19:27:46.000000000 +0200
+++ linux-petero/drivers/block/ll_rw_blk.c	2004-08-28 19:28:31.000000000 +0200
@@ -111,7 +111,7 @@ static void blk_queue_congestion_thresho
  * congested queues, and wake up anyone who was waiting for requests to be
  * put back.
  */
-static void clear_queue_congested(request_queue_t *q, int rw)
+void clear_queue_congested(request_queue_t *q, int rw)
 {
 	enum bdi_state bit;
 	wait_queue_head_t *wqh = &congestion_wqh[rw];
@@ -122,18 +122,20 @@ static void clear_queue_congested(reques
 	if (waitqueue_active(wqh))
 		wake_up(wqh);
 }
+EXPORT_SYMBOL(clear_queue_congested);
 
 /*
  * A queue has just entered congestion.  Flag that in the queue's VM-visible
  * state flags and increment the global gounter of congested queues.
  */
-static void set_queue_congested(request_queue_t *q, int rw)
+void set_queue_congested(request_queue_t *q, int rw)
 {
 	enum bdi_state bit;
 
 	bit = (rw == WRITE) ? BDI_write_congested : BDI_read_congested;
 	set_bit(bit, &q->backing_dev_info.state);
 }
+EXPORT_SYMBOL(set_queue_congested);
 
 /**
  * blk_get_backing_dev_info - get the address of a queue's backing_dev_info
diff -puN include/linux/blkdev.h~packet-congest include/linux/blkdev.h
--- linux/include/linux/blkdev.h~packet-congest	2004-08-29 13:08:50.000000000 +0200
+++ linux-petero/include/linux/blkdev.h	2004-08-29 13:11:30.000000000 +0200
@@ -518,6 +518,8 @@ extern void blk_recount_segments(request
 extern int blk_phys_contig_segment(request_queue_t *q, struct bio *, struct bio *);
 extern int blk_hw_contig_segment(request_queue_t *q, struct bio *, struct bio *);
 extern int scsi_cmd_ioctl(struct file *, struct gendisk *, unsigned int, void __user *);
+extern void clear_queue_congested(request_queue_t *q, int rw);
+extern void set_queue_congested(request_queue_t *q, int rw);
 extern void blk_start_queue(request_queue_t *q);
 extern void blk_stop_queue(request_queue_t *q);
 extern void __blk_stop_queue(request_queue_t *q);
_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
