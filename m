Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422927AbWBCUUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422927AbWBCUUw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 15:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422929AbWBCUUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 15:20:51 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:39069 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1422927AbWBCUUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 15:20:50 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] pktcdvd: Don't waste kernel memory
References: <m3bqxoci5g.fsf@telia.com> <m37j8cci2r.fsf@telia.com>
	<m33bj0ci0b.fsf_-_@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 03 Feb 2006 21:20:41 +0100
In-Reply-To: <m33bj0ci0b.fsf_-_@telia.com>
Message-ID: <m3y80sb3dy.fsf_-_@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate memory for read-gathering at open time, when it is known just
how much memory is needed.  This avoids wasting kernel memory when the
real packet size is smaller than the maximum packet size supported by
the driver.  This is always the case when using DVD discs.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 drivers/block/Kconfig   |    4 ++--
 drivers/block/pktcdvd.c |   53 +++++++++++++++++++++++++----------------------
 include/linux/pktcdvd.h |    4 ++--
 3 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index db6818f..8b13316 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -433,8 +433,8 @@ config CDROM_PKTCDVD_BUFFERS
 	  This controls the maximum number of active concurrent packets. More
 	  concurrent packets can increase write performance, but also require
 	  more memory. Each concurrent packet will require approximately 64Kb
-	  of non-swappable kernel memory, memory which will be allocated at
-	  pktsetup time.
+	  of non-swappable kernel memory, memory which will be allocated when
+	  a disc is opened for writing.
 
 config CDROM_PKTCDVD_WCACHE
 	bool "Enable write caching (EXPERIMENTAL)"
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 01f070a..18d5979 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -130,7 +130,7 @@ static struct bio *pkt_bio_alloc(int nr_
 /*
  * Allocate a packet_data struct
  */
-static struct packet_data *pkt_alloc_packet_data(void)
+static struct packet_data *pkt_alloc_packet_data(int frames)
 {
 	int i;
 	struct packet_data *pkt;
@@ -139,11 +139,12 @@ static struct packet_data *pkt_alloc_pac
 	if (!pkt)
 		goto no_pkt;
 
-	pkt->w_bio = pkt_bio_alloc(PACKET_MAX_SIZE);
+	pkt->frames = frames;
+	pkt->w_bio = pkt_bio_alloc(frames);
 	if (!pkt->w_bio)
 		goto no_bio;
 
-	for (i = 0; i < PAGES_PER_PACKET; i++) {
+	for (i = 0; i < frames / FRAMES_PER_PAGE; i++) {
 		pkt->pages[i] = alloc_page(GFP_KERNEL|__GFP_ZERO);
 		if (!pkt->pages[i])
 			goto no_page;
@@ -151,7 +152,7 @@ static struct packet_data *pkt_alloc_pac
 
 	spin_lock_init(&pkt->lock);
 
-	for (i = 0; i < PACKET_MAX_SIZE; i++) {
+	for (i = 0; i < frames; i++) {
 		struct bio *bio = pkt_bio_alloc(1);
 		if (!bio)
 			goto no_rd_bio;
@@ -161,14 +162,14 @@ static struct packet_data *pkt_alloc_pac
 	return pkt;
 
 no_rd_bio:
-	for (i = 0; i < PACKET_MAX_SIZE; i++) {
+	for (i = 0; i < frames; i++) {
 		struct bio *bio = pkt->r_bios[i];
 		if (bio)
 			bio_put(bio);
 	}
 
 no_page:
-	for (i = 0; i < PAGES_PER_PACKET; i++)
+	for (i = 0; i < frames / FRAMES_PER_PAGE; i++)
 		if (pkt->pages[i])
 			__free_page(pkt->pages[i]);
 	bio_put(pkt->w_bio);
@@ -185,12 +186,12 @@ static void pkt_free_packet_data(struct 
 {
 	int i;
 
-	for (i = 0; i < PACKET_MAX_SIZE; i++) {
+	for (i = 0; i < pkt->frames; i++) {
 		struct bio *bio = pkt->r_bios[i];
 		if (bio)
 			bio_put(bio);
 	}
-	for (i = 0; i < PAGES_PER_PACKET; i++)
+	for (i = 0; i < pkt->frames / FRAMES_PER_PAGE; i++)
 		__free_page(pkt->pages[i]);
 	bio_put(pkt->w_bio);
 	kfree(pkt);
@@ -205,17 +206,17 @@ static void pkt_shrink_pktlist(struct pk
 	list_for_each_entry_safe(pkt, next, &pd->cdrw.pkt_free_list, list) {
 		pkt_free_packet_data(pkt);
 	}
+	INIT_LIST_HEAD(&pd->cdrw.pkt_free_list);
 }
 
 static int pkt_grow_pktlist(struct pktcdvd_device *pd, int nr_packets)
 {
 	struct packet_data *pkt;
 
-	INIT_LIST_HEAD(&pd->cdrw.pkt_free_list);
-	INIT_LIST_HEAD(&pd->cdrw.pkt_active_list);
-	spin_lock_init(&pd->cdrw.active_list_lock);
+	BUG_ON(!list_empty(&pd->cdrw.pkt_free_list));
+
 	while (nr_packets > 0) {
-		pkt = pkt_alloc_packet_data();
+		pkt = pkt_alloc_packet_data(pd->settings.size >> 2);
 		if (!pkt) {
 			pkt_shrink_pktlist(pd);
 			return 0;
@@ -950,7 +951,7 @@ try_next_bio:
 
 	pd->current_sector = zone + pd->settings.size;
 	pkt->sector = zone;
-	pkt->frames = pd->settings.size >> 2;
+	BUG_ON(pkt->frames != pd->settings.size >> 2);
 	pkt->write_size = 0;
 
 	/*
@@ -1986,8 +1987,14 @@ static int pkt_open_dev(struct pktcdvd_d
 	if ((ret = pkt_set_segment_merging(pd, q)))
 		goto out_unclaim;
 
-	if (write)
+	if (write) {
+		if (!pkt_grow_pktlist(pd, CONFIG_CDROM_PKTCDVD_BUFFERS)) {
+			printk("pktcdvd: not enough memory for buffers\n");
+			ret = -ENOMEM;
+			goto out_unclaim;
+		}
 		printk("pktcdvd: %lukB available on disc\n", lba << 1);
+	}
 
 	return 0;
 
@@ -2013,6 +2020,8 @@ static void pkt_release_dev(struct pktcd
 	pkt_set_speed(pd, MAX_SPEED, MAX_SPEED);
 	bd_release(pd->bdev);
 	blkdev_put(pd->bdev);
+
+	pkt_shrink_pktlist(pd);
 }
 
 static struct pktcdvd_device *pkt_find_dev_from_minor(int dev_minor)
@@ -2378,12 +2387,6 @@ static int pkt_new_dev(struct pktcdvd_de
 	/* This is safe, since we have a reference from open(). */
 	__module_get(THIS_MODULE);
 
-	if (!pkt_grow_pktlist(pd, CONFIG_CDROM_PKTCDVD_BUFFERS)) {
-		printk("pktcdvd: not enough memory for buffers\n");
-		ret = -ENOMEM;
-		goto out_mem;
-	}
-
 	pd->bdev = bdev;
 	set_blocksize(bdev, CD_FRAMESIZE);
 
@@ -2394,7 +2397,7 @@ static int pkt_new_dev(struct pktcdvd_de
 	if (IS_ERR(pd->cdrw.thread)) {
 		printk("pktcdvd: can't start kernel thread\n");
 		ret = -ENOMEM;
-		goto out_thread;
+		goto out_mem;
 	}
 
 	proc = create_proc_entry(pd->name, 0, pkt_proc);
@@ -2405,8 +2408,6 @@ static int pkt_new_dev(struct pktcdvd_de
 	DPRINTK("pktcdvd: writer %s mapped to %s\n", pd->name, bdevname(bdev, b));
 	return 0;
 
-out_thread:
-	pkt_shrink_pktlist(pd);
 out_mem:
 	blkdev_put(bdev);
 	/* This is safe: open() is still holding a reference. */
@@ -2502,6 +2503,10 @@ static int pkt_setup_dev(struct pkt_ctrl
 		goto out_mem;
 	pd->disk = disk;
 
+	INIT_LIST_HEAD(&pd->cdrw.pkt_free_list);
+	INIT_LIST_HEAD(&pd->cdrw.pkt_active_list);
+	spin_lock_init(&pd->cdrw.active_list_lock);
+
 	spin_lock_init(&pd->lock);
 	spin_lock_init(&pd->iosched.lock);
 	sprintf(pd->name, "pktcdvd%d", idx);
@@ -2566,8 +2571,6 @@ static int pkt_remove_dev(struct pkt_ctr
 
 	blkdev_put(pd->bdev);
 
-	pkt_shrink_pktlist(pd);
-
 	remove_proc_entry(pd->name, pkt_proc);
 	DPRINTK("pktcdvd: writer %s unmapped\n", pd->name);
 
diff --git a/include/linux/pktcdvd.h b/include/linux/pktcdvd.h
index d1c9c4a..1623da8 100644
--- a/include/linux/pktcdvd.h
+++ b/include/linux/pktcdvd.h
@@ -170,7 +170,7 @@ struct packet_iosched
 #error "PAGE_SIZE must be a multiple of CD_FRAMESIZE"
 #endif
 #define PACKET_MAX_SIZE		32
-#define PAGES_PER_PACKET	(PACKET_MAX_SIZE * CD_FRAMESIZE / PAGE_SIZE)
+#define FRAMES_PER_PAGE		(PAGE_SIZE / CD_FRAMESIZE)
 #define PACKET_MAX_SECTORS	(PACKET_MAX_SIZE * CD_FRAMESIZE >> 9)
 
 enum packet_data_state {
@@ -219,7 +219,7 @@ struct packet_data
 	atomic_t		io_errors;	/* Number of read/write errors during IO */
 
 	struct bio		*r_bios[PACKET_MAX_SIZE]; /* bios to use during data gathering */
-	struct page		*pages[PAGES_PER_PACKET];
+	struct page		*pages[PACKET_MAX_SIZE / FRAMES_PER_PAGE];
 
 	int			cache_valid;	/* If non-zero, the data for the zone defined */
 						/* by the sector variable is completely cached */

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
