Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbWAQG4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWAQG4y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 01:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWAQG4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 01:56:44 -0500
Received: from mail.suse.de ([195.135.220.2]:60844 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751236AbWAQG4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 01:56:31 -0500
From: NeilBrown <neilb@suse.de>
To: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 17 Jan 2006 17:56:24 +1100
Message-Id: <1060117065624.27855@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: [PATCH 003 of 5] md: Infrastructure to allow normal IO to continue while array is expanding.
References: <20060117174531.27739.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We need to allow that different stripes are of different effective sizes,
and use the appropriate size.
Also, when a stripe is being expanded, we must block any IO attempts
until the stripe is stable again.

Key elements in this change are:
 - each stripe_head gets a 'disk' field which is part of the key,
   thus there can sometimes be two stripe heads of the same area of
   the array, but covering different numbers of devices.  One of these
   will be marked STRIPE_EXPANDING and so won't accept new requests.
 - conf->expand_progress tracks how the expansion is progressing and
   is used to determine whether the target part of the array has been
   expanded yet or not.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid5.c         |   71 ++++++++++++++++++++++++-------------------
 ./include/linux/raid/raid5.h |    6 +++
 2 files changed, 47 insertions(+), 30 deletions(-)

diff ./drivers/md/raid5.c~current~ ./drivers/md/raid5.c
--- ./drivers/md/raid5.c~current~	2006-01-17 17:33:23.000000000 +1100
+++ ./drivers/md/raid5.c	2006-01-17 17:35:36.000000000 +1100
@@ -178,10 +178,10 @@ static int grow_buffers(struct stripe_he
 
 static void raid5_build_block (struct stripe_head *sh, int i);
 
-static void init_stripe(struct stripe_head *sh, sector_t sector, int pd_idx)
+static void init_stripe(struct stripe_head *sh, sector_t sector, int pd_idx, int disks)
 {
 	raid5_conf_t *conf = sh->raid_conf;
-	int disks = conf->raid_disks, i;
+	int i;
 
 	if (atomic_read(&sh->count) != 0)
 		BUG();
@@ -198,7 +198,9 @@ static void init_stripe(struct stripe_he
 	sh->pd_idx = pd_idx;
 	sh->state = 0;
 
-	for (i=disks; i--; ) {
+	sh->disks = disks;
+
+	for (i = sh->disks; i--; ) {
 		struct r5dev *dev = &sh->dev[i];
 
 		if (dev->toread || dev->towrite || dev->written ||
@@ -215,7 +217,7 @@ static void init_stripe(struct stripe_he
 	insert_hash(conf, sh);
 }
 
-static struct stripe_head *__find_stripe(raid5_conf_t *conf, sector_t sector)
+static struct stripe_head *__find_stripe(raid5_conf_t *conf, sector_t sector, int disks)
 {
 	struct stripe_head *sh;
 	struct hlist_node *hn;
@@ -223,7 +225,7 @@ static struct stripe_head *__find_stripe
 	CHECK_DEVLOCK();
 	PRINTK("__find_stripe, sector %llu\n", (unsigned long long)sector);
 	hlist_for_each_entry(sh, hn, stripe_hash(conf, sector), hash)
-		if (sh->sector == sector)
+		if (sh->sector == sector && sh->disks == disks)
 			return sh;
 	PRINTK("__stripe %llu not in cache\n", (unsigned long long)sector);
 	return NULL;
@@ -232,8 +234,8 @@ static struct stripe_head *__find_stripe
 static void unplug_slaves(mddev_t *mddev);
 static void raid5_unplug_device(request_queue_t *q);
 
-static struct stripe_head *get_active_stripe(raid5_conf_t *conf, sector_t sector,
-					     int pd_idx, int noblock) 
+static struct stripe_head *get_active_stripe(raid5_conf_t *conf, sector_t sector, int disks,
+					     int pd_idx, int noblock)
 {
 	struct stripe_head *sh;
 
@@ -245,7 +247,7 @@ static struct stripe_head *get_active_st
 		wait_event_lock_irq(conf->wait_for_stripe,
 				    conf->quiesce == 0,
 				    conf->device_lock, /* nothing */);
-		sh = __find_stripe(conf, sector);
+		sh = __find_stripe(conf, sector, disks);
 		if (!sh) {
 			if (!conf->inactive_blocked)
 				sh = get_free_stripe(conf);
@@ -263,7 +265,7 @@ static struct stripe_head *get_active_st
 					);
 				conf->inactive_blocked = 0;
 			} else
-				init_stripe(sh, sector, pd_idx);
+				init_stripe(sh, sector, pd_idx, disks);
 		} else {
 			if (atomic_read(&sh->count)) {
 				if (!list_empty(&sh->lru))
@@ -300,6 +302,7 @@ static int grow_one_stripe(raid5_conf_t 
 		kmem_cache_free(conf->slab_cache, sh);
 		return 0;
 	}
+	sh->disks = conf->raid_disks;
 	/* we just created an active stripe so... */
 	atomic_set(&sh->count, 1);
 	atomic_inc(&conf->active_stripes);
@@ -467,7 +470,7 @@ static int raid5_end_read_request(struct
 {
  	struct stripe_head *sh = bi->bi_private;
 	raid5_conf_t *conf = sh->raid_conf;
-	int disks = conf->raid_disks, i;
+	int disks = sh->disks, i;
 	int uptodate = test_bit(BIO_UPTODATE, &bi->bi_flags);
 
 	if (bi->bi_size)
@@ -565,7 +568,7 @@ static int raid5_end_write_request (stru
 {
  	struct stripe_head *sh = bi->bi_private;
 	raid5_conf_t *conf = sh->raid_conf;
-	int disks = conf->raid_disks, i;
+	int disks = sh->disks, i;
 	unsigned long flags;
 	int uptodate = test_bit(BIO_UPTODATE, &bi->bi_flags);
 
@@ -719,7 +722,7 @@ static sector_t raid5_compute_sector(sec
 static sector_t compute_blocknr(struct stripe_head *sh, int i)
 {
 	raid5_conf_t *conf = sh->raid_conf;
-	int raid_disks = conf->raid_disks, data_disks = raid_disks - 1;
+	int raid_disks = sh->disks, data_disks = raid_disks - 1;
 	sector_t new_sector = sh->sector, check;
 	int sectors_per_chunk = conf->chunk_size >> 9;
 	sector_t stripe;
@@ -820,8 +823,7 @@ static void copy_data(int frombio, struc
 
 static void compute_block(struct stripe_head *sh, int dd_idx)
 {
-	raid5_conf_t *conf = sh->raid_conf;
-	int i, count, disks = conf->raid_disks;
+	int i, count, disks = sh->disks;
 	void *ptr[MAX_XOR_BLOCKS], *p;
 
 	PRINTK("compute_block, stripe %llu, idx %d\n", 
@@ -851,7 +853,7 @@ static void compute_block(struct stripe_
 static void compute_parity(struct stripe_head *sh, int method)
 {
 	raid5_conf_t *conf = sh->raid_conf;
-	int i, pd_idx = sh->pd_idx, disks = conf->raid_disks, count;
+	int i, pd_idx = sh->pd_idx, disks = sh->disks, count;
 	void *ptr[MAX_XOR_BLOCKS];
 	struct bio *chosen;
 
@@ -1039,7 +1041,7 @@ static int add_stripe_bio(struct stripe_
 static void handle_stripe(struct stripe_head *sh)
 {
 	raid5_conf_t *conf = sh->raid_conf;
-	int disks = conf->raid_disks;
+	int disks = sh->disks;
 	struct bio *return_bi= NULL;
 	struct bio *bi;
 	int i;
@@ -1633,12 +1635,10 @@ static inline void raid5_plug_device(rai
 	spin_unlock_irq(&conf->device_lock);
 }
 
-static int make_request (request_queue_t *q, struct bio * bi)
+static int make_request(request_queue_t *q, struct bio * bi)
 {
 	mddev_t *mddev = q->queuedata;
 	raid5_conf_t *conf = mddev_to_conf(mddev);
-	const unsigned int raid_disks = conf->raid_disks;
-	const unsigned int data_disks = raid_disks - 1;
 	unsigned int dd_idx, pd_idx;
 	sector_t new_sector;
 	sector_t logical_sector, last_sector;
@@ -1662,20 +1662,31 @@ static int make_request (request_queue_t
 
 	for (;logical_sector < last_sector; logical_sector += STRIPE_SECTORS) {
 		DEFINE_WAIT(w);
+		int disks;
 		
-		new_sector = raid5_compute_sector(logical_sector,
-						  raid_disks, data_disks, &dd_idx, &pd_idx, conf);
-
+	retry:
+		if (conf->expand_progress == MaxSector)
+			disks = conf->raid_disks;
+		else {
+			spin_lock_irq(&conf->device_lock);
+			disks = conf->raid_disks;
+			if (logical_sector >= conf->expand_progress)
+				disks = conf->previous_raid_disks;
+			spin_unlock_irq(&conf->device_lock);
+		}
+ 		new_sector = raid5_compute_sector(logical_sector, disks, disks - 1,
+						  &dd_idx, &pd_idx, conf);
 		PRINTK("raid5: make_request, sector %llu logical %llu\n",
 			(unsigned long long)new_sector, 
 			(unsigned long long)logical_sector);
 
-	retry:
 		prepare_to_wait(&conf->wait_for_overlap, &w, TASK_UNINTERRUPTIBLE);
-		sh = get_active_stripe(conf, new_sector, pd_idx, (bi->bi_rw&RWA_MASK));
+		sh = get_active_stripe(conf, new_sector, disks, pd_idx, (bi->bi_rw&RWA_MASK));
 		if (sh) {
-			if (!add_stripe_bio(sh, bi, dd_idx, (bi->bi_rw&RW_MASK))) {
-				/* Add failed due to overlap.  Flush everything
+			if (test_bit(STRIPE_EXPANDING, &sh->state) ||
+			    !add_stripe_bio(sh, bi, dd_idx, (bi->bi_rw&RW_MASK))) {
+				/* Stripe is busy expanding or
+				 * add failed due to overlap.  Flush everything
 				 * and wait a while
 				 */
 				raid5_unplug_device(mddev->queue);
@@ -1687,7 +1698,6 @@ static int make_request (request_queue_t
 			raid5_plug_device(conf);
 			handle_stripe(sh);
 			release_stripe(sh);
-
 		} else {
 			/* cannot get stripe for read-ahead, just give-up */
 			clear_bit(BIO_UPTODATE, &bi->bi_flags);
@@ -1763,9 +1773,9 @@ static sector_t sync_request(mddev_t *md
 
 	first_sector = raid5_compute_sector((sector_t)stripe*data_disks*sectors_per_chunk
 		+ chunk_offset, raid_disks, data_disks, &dd_idx, &pd_idx, conf);
-	sh = get_active_stripe(conf, sector_nr, pd_idx, 1);
+	sh = get_active_stripe(conf, sector_nr, raid_disks, pd_idx, 1);
 	if (sh == NULL) {
-		sh = get_active_stripe(conf, sector_nr, pd_idx, 0);
+		sh = get_active_stripe(conf, sector_nr, raid_disks, pd_idx, 0);
 		/* make sure we don't swamp the stripe cache if someone else
 		 * is trying to get access 
 		 */
@@ -1982,6 +1992,7 @@ static int run(mddev_t *mddev)
 	conf->level = mddev->level;
 	conf->algorithm = mddev->layout;
 	conf->max_nr_stripes = NR_STRIPES;
+	conf->expand_progress = MaxSector;
 
 	/* device size must be a multiple of chunk size */
 	mddev->size &= ~(mddev->chunk_size/1024 -1);
@@ -2112,7 +2123,7 @@ static void print_sh (struct stripe_head
 	printk("sh %llu,  count %d.\n",
 		(unsigned long long)sh->sector, atomic_read(&sh->count));
 	printk("sh %llu, ", (unsigned long long)sh->sector);
-	for (i = 0; i < sh->raid_conf->raid_disks; i++) {
+	for (i = 0; i < sh->disks; i++) {
 		printk("(cache%d: %p %ld) ", 
 			i, sh->dev[i].page, sh->dev[i].flags);
 	}

diff ./include/linux/raid/raid5.h~current~ ./include/linux/raid/raid5.h
--- ./include/linux/raid/raid5.h~current~	2006-01-17 17:33:23.000000000 +1100
+++ ./include/linux/raid/raid5.h	2006-01-17 17:35:36.000000000 +1100
@@ -135,6 +135,7 @@ struct stripe_head {
 	atomic_t		count;			/* nr of active thread/requests */
 	spinlock_t		lock;
 	int			bm_seq;	/* sequence number for bitmap flushes */
+	int			disks;			/* disks in stripe */
 	struct r5dev {
 		struct bio	req;
 		struct bio_vec	vec;
@@ -174,6 +175,7 @@ struct stripe_head {
 #define	STRIPE_DELAYED		6
 #define	STRIPE_DEGRADED		7
 #define	STRIPE_BIT_DELAY	8
+#define	STRIPE_EXPANDING	9
 
 /*
  * Plugging:
@@ -211,6 +213,10 @@ struct raid5_private_data {
 	int			raid_disks, working_disks, failed_disks;
 	int			max_nr_stripes;
 
+	/* used during an expand */
+	sector_t		expand_progress;	/* MaxSector when no expand happening */
+	int			previous_raid_disks;
+
 	struct list_head	handle_list; /* stripes needing handling */
 	struct list_head	delayed_list; /* stripes that have plugged requests */
 	struct list_head	bitmap_list; /* stripes delaying awaiting bitmap update */
