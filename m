Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbVJBMMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbVJBMMO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 08:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbVJBMMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 08:12:14 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:1740 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1751088AbVJBMMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 08:12:13 -0400
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [2.6.13] pktcdvd: IO-errors
References: <Pine.LNX.4.60.0509242057001.4899@poirot.grange>
	<m3slvtzf72.fsf@telia.com>
	<Pine.LNX.4.60.0509252026290.3089@poirot.grange>
	<m34q873ccc.fsf@telia.com>
	<Pine.LNX.4.60.0509262122450.4031@poirot.grange>
	<m3slvr1ugx.fsf@telia.com>
	<Pine.LNX.4.60.0509262358020.6722@poirot.grange>
	<m3hdc4ucrt.fsf@telia.com>
	<Pine.LNX.4.60.0509292116260.11615@poirot.grange>
From: Peter Osterlund <petero2@telia.com>
Date: 02 Oct 2005 14:11:47 +0200
In-Reply-To: <Pine.LNX.4.60.0509292116260.11615@poirot.grange>
Message-ID: <m3k6gw86f0.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guennadi Liakhovetski <g.liakhovetski@gmx.de> writes:

> On Wed, 28 Sep 2005, Peter Osterlund wrote:
> 
> > That patch changes the logic that decides when the driver should
> > change between reading and writing. However, the read/write/sync
> > sequence that makes your drive fail in 2.6.13 could theoretically
> > happen in 2.6.12 as well if you are unlucky.
> 
> Well, I didn't test it extensively - it was the first time I tried it 
> under 2.6.13.
> 
> > I think some trial and error will be required to figure out what
> > causes your drive to fail. If you apply this patch to 2.6.12, does it
> > still work?
> 
> Yes, it does...

OK, in that case this patch for 2.6.12 should work as well, because
all it does compared to the previous patch is to remove the now unused
high_prio_read variables. Can you confirm that it works?

(Continue reading, more after this patch.)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -467,14 +467,12 @@ static int pkt_set_speed(struct pktcdvd_
  * Queue a bio for processing by the low-level CD device. Must be called
  * from process context.
  */
-static void pkt_queue_bio(struct pktcdvd_device *pd, struct bio *bio, int high_prio_read)
+static void pkt_queue_bio(struct pktcdvd_device *pd, struct bio *bio)
 {
 	spin_lock(&pd->iosched.lock);
 	if (bio_data_dir(bio) == READ) {
 		pkt_add_list_last(bio, &pd->iosched.read_queue,
 				  &pd->iosched.read_queue_tail);
-		if (high_prio_read)
-			pd->iosched.high_prio_read = 1;
 	} else {
 		pkt_add_list_last(bio, &pd->iosched.write_queue,
 				  &pd->iosched.write_queue_tail);
@@ -490,15 +488,16 @@ static void pkt_queue_bio(struct pktcdvd
  * requirements for CDRW drives:
  * - A cache flush command must be inserted before a read request if the
  *   previous request was a write.
- * - Switching between reading and writing is slow, so don't it more often
+ * - Switching between reading and writing is slow, so don't do it more often
  *   than necessary.
+ * - Optimize for throughput at the expense of latency. This means that streaming
+ *   writes will never be interrupted by a read, but if the drive has to seek
+ *   before the next write, switch to reading instead if there are any pending
+ *   read requests.
  * - Set the read speed according to current usage pattern. When only reading
  *   from the device, it's best to use the highest possible read speed, but
  *   when switching often between reading and writing, it's better to have the
  *   same read and write speeds.
- * - Reads originating from user space should have higher priority than reads
- *   originating from pkt_gather_data, because some process is usually waiting
- *   on reads of the first kind.
  */
 static void pkt_iosched_process_queue(struct pktcdvd_device *pd)
 {
@@ -512,21 +511,18 @@ static void pkt_iosched_process_queue(st
 
 	for (;;) {
 		struct bio *bio;
-		int reads_queued, writes_queued, high_prio_read;
+		int reads_queued, writes_queued;
 
 		spin_lock(&pd->iosched.lock);
 		reads_queued = (pd->iosched.read_queue != NULL);
 		writes_queued = (pd->iosched.write_queue != NULL);
-		if (!reads_queued)
-			pd->iosched.high_prio_read = 0;
-		high_prio_read = pd->iosched.high_prio_read;
 		spin_unlock(&pd->iosched.lock);
 
 		if (!reads_queued && !writes_queued)
 			break;
 
 		if (pd->iosched.writing) {
-			if (high_prio_read || (!writes_queued && reads_queued)) {
+			if (!writes_queued && reads_queued) {
 				if (atomic_read(&pd->cdrw.pending_bios) > 0) {
 					VPRINTK("pktcdvd: write, waiting\n");
 					break;
@@ -559,8 +555,9 @@ static void pkt_iosched_process_queue(st
 
 		if (bio_data_dir(bio) == READ)
 			pd->iosched.successive_reads += bio->bi_size >> 10;
-		else
+		else {
 			pd->iosched.successive_reads = 0;
+		}
 		if (pd->iosched.successive_reads >= HI_SPEED_SWITCH) {
 			if (pd->read_speed == pd->write_speed) {
 				pd->read_speed = MAX_SPEED;
@@ -765,7 +762,7 @@ static void pkt_gather_data(struct pktcd
 
 		atomic_inc(&pkt->io_wait);
 		bio->bi_rw = READ;
-		pkt_queue_bio(pd, bio, 0);
+		pkt_queue_bio(pd, bio);
 		frames_read++;
 	}
 
@@ -1062,7 +1059,7 @@ static void pkt_start_write(struct pktcd
 
 	atomic_set(&pkt->io_wait, 1);
 	pkt->w_bio->bi_rw = WRITE;
-	pkt_queue_bio(pd, pkt->w_bio, 0);
+	pkt_queue_bio(pd, pkt->w_bio);
 }
 
 static void pkt_finish_packet(struct packet_data *pkt, int uptodate)
@@ -2120,7 +2117,7 @@ static int pkt_make_request(request_queu
 		cloned_bio->bi_private = psd;
 		cloned_bio->bi_end_io = pkt_end_io_read_cloned;
 		pd->stats.secs_r += bio->bi_size >> 9;
-		pkt_queue_bio(pd, cloned_bio, 1);
+		pkt_queue_bio(pd, cloned_bio);
 		return 0;
 	}
 
diff --git a/include/linux/pktcdvd.h b/include/linux/pktcdvd.h
--- a/include/linux/pktcdvd.h
+++ b/include/linux/pktcdvd.h
@@ -159,7 +159,6 @@ struct packet_iosched
 	struct bio		*read_queue_tail;
 	struct bio		*write_queue;
 	struct bio		*write_queue_tail;
-	int			high_prio_read;	/* An important read request has been queued */
 	int			successive_reads;
 };
 

With that patch for 2.6.12, the diff compared to 2.6.13 now looks like
below. Can you confirm that reverse applying this patch for 2.6.13
also works?

--- linux-2612/drivers/block/pktcdvd.c	2005-10-02 13:52:22.000000000 +0200
+++ /home/petero/ftp/kernel/2.6/linux/drivers/block/pktcdvd.c	2005-10-01 13:31:50.000000000 +0200
@@ -522,7 +522,13 @@
 			break;
 
 		if (pd->iosched.writing) {
-			if (!writes_queued && reads_queued) {
+			int need_write_seek = 1;
+			spin_lock(&pd->iosched.lock);
+			bio = pd->iosched.write_queue;
+			spin_unlock(&pd->iosched.lock);
+			if (bio && (bio->bi_sector == pd->iosched.last_write))
+				need_write_seek = 0;
+			if (need_write_seek && reads_queued) {
 				if (atomic_read(&pd->cdrw.pending_bios) > 0) {
 					VPRINTK("pktcdvd: write, waiting\n");
 					break;
@@ -557,6 +563,7 @@
 			pd->iosched.successive_reads += bio->bi_size >> 10;
 		else {
 			pd->iosched.successive_reads = 0;
+			pd->iosched.last_write = bio->bi_sector + bio_sectors(bio);
 		}
 		if (pd->iosched.successive_reads >= HI_SPEED_SWITCH) {
 			if (pd->read_speed == pd->write_speed) {
@@ -1244,8 +1251,7 @@
 			VPRINTK("kcdrwd: wake up\n");
 
 			/* make swsusp happy with our thread */
-			if (current->flags & PF_FREEZE)
-				refrigerator(PF_FREEZE);
+			try_to_freeze();
 
 			list_for_each_entry(pkt, &pd->cdrw.pkt_active_list, list) {
 				if (!pkt->sleep_time)
--- linux-2612/include/linux/pktcdvd.h	2005-10-02 13:47:21.000000000 +0200
+++ /home/petero/ftp/kernel/2.6/linux/include/linux/pktcdvd.h	2005-10-01 13:32:08.000000000 +0200
@@ -159,6 +159,7 @@
 	struct bio		*read_queue_tail;
 	struct bio		*write_queue;
 	struct bio		*write_queue_tail;
+	sector_t		last_write;	/* The sector where the last write ended */
 	int			successive_reads;
 };
 

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
