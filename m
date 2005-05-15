Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVEOUv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVEOUv5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 16:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVEOUv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 16:51:57 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:18408 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S261241AbVEOUuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 16:50:52 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Improve CD/DVD packet driver write performance
From: Peter Osterlund <petero2@telia.com>
Date: 15 May 2005 22:50:39 +0200
Message-ID: <m3ekc8nrhc.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch improves write performance for the CD/DVD packet writing
driver. The logic for switching between reading and writing has been
changed so that streaming writes are no longer interrupted by read
requests.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 linux-petero/drivers/block/pktcdvd.c |   36 +++++++++++++++++++----------------
 linux-petero/include/linux/pktcdvd.h |    2 -
 2 files changed, 21 insertions(+), 17 deletions(-)

diff -puN drivers/block/pktcdvd.c~packet-ioschedule drivers/block/pktcdvd.c
--- linux/drivers/block/pktcdvd.c~packet-ioschedule	2005-05-15 22:34:16.000000000 +0200
+++ linux-petero/drivers/block/pktcdvd.c	2005-05-15 22:37:45.000000000 +0200
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
@@ -512,21 +511,24 @@ static void pkt_iosched_process_queue(st
 
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
@@ -559,8 +561,10 @@ static void pkt_iosched_process_queue(st
 
 		if (bio_data_dir(bio) == READ)
 			pd->iosched.successive_reads += bio->bi_size >> 10;
-		else
+		else {
 			pd->iosched.successive_reads = 0;
+			pd->iosched.last_write = bio->bi_sector + bio_sectors(bio);
+		}
 		if (pd->iosched.successive_reads >= HI_SPEED_SWITCH) {
 			if (pd->read_speed == pd->write_speed) {
 				pd->read_speed = MAX_SPEED;
@@ -765,7 +769,7 @@ static void pkt_gather_data(struct pktcd
 
 		atomic_inc(&pkt->io_wait);
 		bio->bi_rw = READ;
-		pkt_queue_bio(pd, bio, 0);
+		pkt_queue_bio(pd, bio);
 		frames_read++;
 	}
 
@@ -1062,7 +1066,7 @@ static void pkt_start_write(struct pktcd
 
 	atomic_set(&pkt->io_wait, 1);
 	pkt->w_bio->bi_rw = WRITE;
-	pkt_queue_bio(pd, pkt->w_bio, 0);
+	pkt_queue_bio(pd, pkt->w_bio);
 }
 
 static void pkt_finish_packet(struct packet_data *pkt, int uptodate)
@@ -2114,7 +2118,7 @@ static int pkt_make_request(request_queu
 		cloned_bio->bi_private = psd;
 		cloned_bio->bi_end_io = pkt_end_io_read_cloned;
 		pd->stats.secs_r += bio->bi_size >> 9;
-		pkt_queue_bio(pd, cloned_bio, 1);
+		pkt_queue_bio(pd, cloned_bio);
 		return 0;
 	}
 
diff -puN include/linux/pktcdvd.h~packet-ioschedule include/linux/pktcdvd.h
--- linux/include/linux/pktcdvd.h~packet-ioschedule	2005-05-15 22:34:16.000000000 +0200
+++ linux-petero/include/linux/pktcdvd.h	2005-05-15 22:34:16.000000000 +0200
@@ -159,7 +159,7 @@ struct packet_iosched
 	struct bio		*read_queue_tail;
 	struct bio		*write_queue;
 	struct bio		*write_queue_tail;
-	int			high_prio_read;	/* An important read request has been queued */
+	sector_t		last_write;	/* The sector where the last write ended */
 	int			successive_reads;
 };
 
_

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
