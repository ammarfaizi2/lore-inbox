Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264795AbUHNTNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264795AbUHNTNp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 15:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264826AbUHNTNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 15:13:45 -0400
Received: from av1-1-sn4.m-sp.skanova.net ([81.228.10.116]:19154 "EHLO
	av1-1-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S264795AbUHNTNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 15:13:30 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Speed up the cdrw packet writing driver
From: Peter Osterlund <petero2@telia.com>
Date: 14 Aug 2004 21:13:26 +0200
Message-ID: <m33c2py1m1.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch replaces the pd->bio_queue linked list with an rbtree.  The
list can get very long (>200000 entries on a 1GB machine), so keeping
it sorted with a naive algorithm is far too expensive.

This patch also improves write performance when writing lots of data,
because the old code gave up on sorting if the queue became longer
than 10000 entries.  This caused unnecessary seeks.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 linux-petero/drivers/block/pktcdvd.c |  193 +++++++++++++++++++++++------------
 linux-petero/include/linux/pktcdvd.h |   14 ++
 2 files changed, 143 insertions(+), 64 deletions(-)

diff -puN drivers/block/pktcdvd.c~packet-rbtree drivers/block/pktcdvd.c
--- linux/drivers/block/pktcdvd.c~packet-rbtree	2004-08-14 11:35:42.000000000 +0200
+++ linux-petero/drivers/block/pktcdvd.c	2004-08-14 19:26:50.612757536 +0200
@@ -254,6 +254,89 @@ static int pkt_grow_pktlist(struct pktcd
 	return 1;
 }
 
+static void *pkt_rb_alloc(int gfp_mask, void *data)
+{
+	return kmalloc(sizeof(struct pkt_rb_node), gfp_mask);
+}
+
+static void pkt_rb_free(void *ptr, void *data)
+{
+	kfree(ptr);
+}
+
+static inline struct pkt_rb_node *pkt_rbtree_next(struct pkt_rb_node *node)
+{
+	struct rb_node *n = rb_next(&node->rb_node);
+	if (!n)
+		return NULL;
+	return rb_entry(n, struct pkt_rb_node, rb_node);
+}
+
+static inline void pkt_rbtree_erase(struct pktcdvd_device *pd, struct pkt_rb_node *node)
+{
+	rb_erase(&node->rb_node, &pd->bio_queue);
+	mempool_free(node, pd->rb_pool);
+	pd->bio_queue_size--;
+	BUG_ON(pd->bio_queue_size < 0);
+}
+
+/*
+ * Find the first node in the pd->bio_queue rb tree with a starting sector >= s.
+ */
+static struct pkt_rb_node *pkt_rbtree_find(struct pktcdvd_device *pd, sector_t s)
+{
+	struct rb_node *n = pd->bio_queue.rb_node;
+	struct rb_node *next;
+	struct pkt_rb_node *tmp;
+
+	if (!n) {
+		BUG_ON(pd->bio_queue_size > 0);
+		return NULL;
+	}
+
+	for (;;) {
+		tmp = rb_entry(n, struct pkt_rb_node, rb_node);
+		if (s <= tmp->bio->bi_sector)
+			next = n->rb_left;
+		else
+			next = n->rb_right;
+		if (!next)
+			break;
+		n = next;
+	}
+
+	if (s > tmp->bio->bi_sector) {
+		tmp = pkt_rbtree_next(tmp);
+		if (!tmp)
+			return NULL;
+	}
+	BUG_ON(s > tmp->bio->bi_sector);
+	return tmp;
+}
+
+/*
+ * Insert a node into the pd->bio_queue rb tree.
+ */
+static void pkt_rbtree_insert(struct pktcdvd_device *pd, struct pkt_rb_node *node)
+{
+	struct rb_node **p = &pd->bio_queue.rb_node;
+	struct rb_node *parent = NULL;
+	sector_t s = node->bio->bi_sector;
+	struct pkt_rb_node *tmp;
+
+	while (*p) {
+		parent = *p;
+		tmp = rb_entry(parent, struct pkt_rb_node, rb_node);
+		if (s < tmp->bio->bi_sector)
+			p = &(*p)->rb_left;
+		else
+			p = &(*p)->rb_right;
+	}
+	rb_link_node(&node->rb_node, parent, p);
+	rb_insert_color(&node->rb_node, &pd->bio_queue);
+	pd->bio_queue_size++;
+}
+
 /*
  * Add a bio to a single linked list defined by its head and tail pointers.
  */
@@ -839,8 +922,10 @@ static inline void pkt_set_state(struct 
 static int pkt_handle_queue(struct pktcdvd_device *pd)
 {
 	struct packet_data *pkt, *p;
-	struct bio *bio, *prev, *next;
+	struct bio *bio = NULL;
 	sector_t zone = 0; /* Suppress gcc warning */
+	struct pkt_rb_node *node, *first_node;
+	struct rb_node *n;
 
 	VPRINTK("handle_queue\n");
 
@@ -855,14 +940,30 @@ static int pkt_handle_queue(struct pktcd
 	 * Try to find a zone we are not already working on.
 	 */
 	spin_lock(&pd->lock);
-	for (bio = pd->bio_queue; bio; bio = bio->bi_next) {
+	first_node = pkt_rbtree_find(pd, pd->current_sector);
+	if (!first_node) {
+		n = rb_first(&pd->bio_queue);
+		if (n)
+			first_node = rb_entry(n, struct pkt_rb_node, rb_node);
+	}
+	node = first_node;
+	while (node) {
+		bio = node->bio;
 		zone = ZONE(bio->bi_sector, pd);
 		list_for_each_entry(p, &pd->cdrw.pkt_active_list, list) {
 			if (p->sector == zone)
 				goto try_next_bio;
 		}
 		break;
-try_next_bio: ;
+try_next_bio:
+		node = pkt_rbtree_next(node);
+		if (!node) {
+			n = rb_first(&pd->bio_queue);
+			if (n)
+				node = rb_entry(n, struct pkt_rb_node, rb_node);
+		}
+		if (node == first_node)
+			node = NULL;
 	}
 	spin_unlock(&pd->lock);
 	if (!bio) {
@@ -873,6 +974,7 @@ try_next_bio: ;
 	pkt = pkt_get_packet_data(pd, zone);
 	BUG_ON(!pkt);
 
+	pd->current_sector = zone + pd->settings.size;
 	pkt->sector = zone;
 	pkt->frames = pd->settings.size >> 2;
 	BUG_ON(pkt->frames > PACKET_MAX_SIZE);
@@ -883,35 +985,18 @@ try_next_bio: ;
 	 * to this packet.
 	 */
 	spin_lock(&pd->lock);
-	prev = NULL;
 	VPRINTK("pkt_handle_queue: looking for zone %llx\n", (unsigned long long)zone);
-	bio = pd->bio_queue;
-	while (bio) {
+	while ((node = pkt_rbtree_find(pd, zone)) != NULL) {
+		bio = node->bio;
 		VPRINTK("pkt_handle_queue: found zone=%llx\n",
 			(unsigned long long)ZONE(bio->bi_sector, pd));
-		if (ZONE(bio->bi_sector, pd) == zone) {
-			if (prev) {
-				prev->bi_next = bio->bi_next;
-			} else {
-				pd->bio_queue = bio->bi_next;
-			}
-			if (bio == pd->bio_queue_tail)
-				pd->bio_queue_tail = prev;
-			next = bio->bi_next;
-			spin_lock(&pkt->lock);
-			pkt_add_list_last(bio, &pkt->orig_bios,
-					  &pkt->orig_bios_tail);
-			pkt->write_size += bio->bi_size / CD_FRAMESIZE;
-			if (pkt->write_size >= pkt->frames) {
-				VPRINTK("pkt_handle_queue: pkt is full\n");
-				next = NULL; /* Stop searching if the packet is full */
-			}
-			spin_unlock(&pkt->lock);
-			bio = next;
-		} else {
-			prev = bio;
-			bio = bio->bi_next;
-		}
+		if (ZONE(bio->bi_sector, pd) != zone)
+			break;
+		pkt_rbtree_erase(pd, node);
+		spin_lock(&pkt->lock);
+		pkt_add_list_last(bio, &pkt->orig_bios, &pkt->orig_bios_tail);
+		pkt->write_size += bio->bi_size / CD_FRAMESIZE;
+		spin_unlock(&pkt->lock);
 	}
 	spin_unlock(&pd->lock);
 
@@ -2032,6 +2117,7 @@ static int pkt_make_request(request_queu
 	sector_t zone;
 	struct packet_data *pkt;
 	int was_empty, blocked_bio;
+	struct pkt_rb_node *node;
 
 	pd = q->queuedata;
 	if (!pd) {
@@ -2119,39 +2205,13 @@ static int pkt_make_request(request_queu
 	/*
 	 * No matching packet found. Store the bio in the work queue.
 	 */
+	node = mempool_alloc(pd->rb_pool, GFP_NOIO);
+	BUG_ON(!node);
+	node->bio = bio;
 	spin_lock(&pd->lock);
-	if (pd->bio_queue == NULL) {
-		was_empty = 1;
-		bio->bi_next = NULL;
-		pd->bio_queue = bio;
-		pd->bio_queue_tail = bio;
-	} else {
-		struct bio *bio2, *insert_after;
-		int distance, z, cnt;
-
-		was_empty = 0;
-		z = ZONE(pd->bio_queue_tail->bi_sector, pd);
-		distance = (zone >= z ? zone - z : INT_MAX);
-		insert_after = pd->bio_queue_tail;
-		if (distance > pd->settings.size) {
-			for (bio2 = pd->bio_queue, cnt = 0; bio2 && (cnt < 10000);
-			     bio2 = bio2->bi_next, cnt++) {
-				int d2;
-				z = ZONE(bio2->bi_sector, pd);
-				d2 = (zone >= z ? zone - z : INT_MAX);
-				if (d2 < distance) {
-					distance = d2;
-					insert_after = bio2;
-					if (distance == 0)
-						break;
-				}
-			}
-		}
-		bio->bi_next = insert_after->bi_next;
-		insert_after->bi_next = bio;
-		if (insert_after == pd->bio_queue_tail)
-			pd->bio_queue_tail = bio;
-	}
+	BUG_ON(pd->bio_queue_size < 0);
+	was_empty = (pd->bio_queue_size == 0);
+	pkt_rbtree_insert(pd, node);
 	spin_unlock(&pd->lock);
 
 	/*
@@ -2254,7 +2314,8 @@ static int pkt_seq_show(struct seq_file 
 	seq_printf(m, "\tmode page offset:\t%u\n", pd->mode_offset);
 
 	seq_printf(m, "\nQueue state:\n");
-	seq_printf(m, "\tbios queued:\t\t%s\n", pd->bio_queue ? "yes" : "no");
+	seq_printf(m, "\tbios queued:\t\t%d\n", pd->bio_queue_size);
+	seq_printf(m, "\tcurrent sector:\t\t0x%llx\n", (unsigned long long)pd->current_sector);
 
 	pkt_count_states(pd, states);
 	seq_printf(m, "\tstate:\t\t\ti:%d ow:%d rw:%d ww:%d rec:%d fin:%d\n",
@@ -2427,6 +2488,10 @@ static int pkt_setup_dev(struct pkt_ctrl
 		return ret;
 	memset(pd, 0, sizeof(struct pktcdvd_device));
 
+	pd->rb_pool = mempool_create(PKT_RB_POOL_SIZE, pkt_rb_alloc, pkt_rb_free, NULL);
+	if (!pd->rb_pool)
+		goto out_mem;
+
 	disk = alloc_disk(1);
 	if (!disk)
 		goto out_mem;
@@ -2436,6 +2501,7 @@ static int pkt_setup_dev(struct pkt_ctrl
 	spin_lock_init(&pd->iosched.lock);
 	sprintf(pd->name, "pktcdvd%d", idx);
 	init_waitqueue_head(&pd->wqueue);
+	pd->bio_queue = RB_ROOT;
 
 	disk->major = pkt_major;
 	disk->first_minor = idx;
@@ -2462,6 +2528,8 @@ out_new_dev:
 out_mem2:
 	put_disk(disk);
 out_mem:
+	if (pd->rb_pool)
+		mempool_destroy(pd->rb_pool);
 	kfree(pd);
 	return ret;
 }
@@ -2503,6 +2571,7 @@ static int pkt_remove_dev(struct pkt_ctr
 	put_disk(pd->disk);
 
 	pkt_devs[idx] = NULL;
+	mempool_destroy(pd->rb_pool);
 	kfree(pd);
 
 	/* This is safe: open() is still holding a reference. */
diff -puN include/linux/pktcdvd.h~packet-rbtree include/linux/pktcdvd.h
--- linux/include/linux/pktcdvd.h~packet-rbtree	2004-08-14 11:35:42.000000000 +0200
+++ linux-petero/include/linux/pktcdvd.h	2004-08-14 19:35:10.822714064 +0200
@@ -21,6 +21,8 @@
 
 #define	MAX_WRITERS		8
 
+#define PKT_RB_POOL_SIZE	512
+
 /*
  * How long we should hold a non-full packet before starting data gathering.
  */
@@ -224,6 +226,11 @@ struct packet_data
 	struct pktcdvd_device	*pd;
 };
 
+struct pkt_rb_node {
+	struct rb_node		rb_node;
+	struct bio		*bio;
+};
+
 struct pktcdvd_device
 {
 	struct block_device	*bdev;		/* dev attached */
@@ -245,10 +252,13 @@ struct pktcdvd_device
 	wait_queue_head_t	wqueue;
 
 	spinlock_t		lock;		/* Serialize access to bio_queue */
-	struct bio		*bio_queue;	/* Work queue of bios we need to handle */
-	struct bio		*bio_queue_tail;
+	struct rb_root		bio_queue;	/* Work queue of bios we need to handle */
+	int			bio_queue_size;	/* Number of nodes in bio_queue */
+	sector_t		current_sector;	/* Keep track of where the elevator is */
 	atomic_t		scan_queue;	/* Set to non-zero when pkt_handle_queue */
 						/* needs to be run. */
+	mempool_t		*rb_pool;	/* mempool for pkt_rb_node allocations */
+
 	struct packet_iosched   iosched;
 	struct gendisk		*disk;
 };
_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
