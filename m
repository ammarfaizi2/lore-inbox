Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264920AbSKJPxH>; Sun, 10 Nov 2002 10:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264919AbSKJPxH>; Sun, 10 Nov 2002 10:53:07 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:28638 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264922AbSKJPws>;
	Sun, 10 Nov 2002 10:52:48 -0500
Date: Sun, 10 Nov 2002 16:58:51 +0100
From: Jens Axboe <axboe@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: 2.5.46-mm2
Message-ID: <20021110155851.GL31134@suse.de>
References: <3DCDD9AC.C3FB30D9@digeo.com> <20021110143208.GJ31134@suse.de> <20021110145203.GH23425@holomorphy.com> <20021110145757.GK31134@suse.de> <20021110150626.GI23425@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021110150626.GI23425@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10 2002, William Lee Irwin III wrote:
> On Sun, Nov 10, 2002 at 03:32:08PM +0100, Jens Axboe wrote:
> >>> I've attached a small document describing the deadline io scheduler
> >>> tunables. stream_unit is not in Andrew's version, yet, it uses a hard
> >>> defined 128KiB. Also, Andrew didn't apply the rbtree patch only the
> >>> tunable patch. So it uses the same insertion algorithm as the default
> >>> kernel, two linked lists.
> 
> On Sun, Nov 10 2002, William Lee Irwin III wrote:
> >> Okay, then I'll want the rbtree code for benchmarking.
> 
> On Sun, Nov 10, 2002 at 03:57:57PM +0100, Jens Axboe wrote:
> > Sure, I want to talk akpm into merging the rbtree code for real. Or I
> > can just drop you my current version, if you want.
> 
> Go for it, I'm just trying to get tiobench to actually run (seems to
> have new/different "die from too many threads" behavior wrt. --threads).
> Dropping me a fresh kernel shouldn't slow anything down.

Complete diff against 2.5.46-BK current attached.

> P.S.:	elvtune gets hung for a long time, it says:
> 	ioctl get: Inappropriate ioctl for device
> 	did it schedule with something held and get out of deadlock free?

BLKELVGET and SET are not defined anymore, however it's weird that it
doesn't just return -ENOTTY immediately. That ioctl interface was a
mistake from the beginning. Can you see where it is hanging? It could
just be Andrew's patch, it looked somewhat incomplete.

===== arch/mips64/kernel/ioctl32.c 1.8 vs edited =====
--- 1.8/arch/mips64/kernel/ioctl32.c	Thu Oct 31 16:05:56 2002
+++ edited/arch/mips64/kernel/ioctl32.c	Fri Nov  8 17:17:44 2002
@@ -759,8 +759,6 @@
 	IOCTL32_HANDLER(BLKSECTGET, w_long),
 	IOCTL32_DEFAULT(BLKSSZGET),
 	IOCTL32_HANDLER(BLKPG, blkpg_ioctl_trans),
-	IOCTL32_DEFAULT(BLKELVGET),
-	IOCTL32_DEFAULT(BLKELVSET),
 	IOCTL32_DEFAULT(BLKBSZGET),
 	IOCTL32_DEFAULT(BLKBSZSET),
 
===== arch/parisc/kernel/ioctl32.c 1.1 vs edited =====
--- 1.1/arch/parisc/kernel/ioctl32.c	Mon Oct 28 11:32:58 2002
+++ edited/arch/parisc/kernel/ioctl32.c	Fri Nov  8 17:17:32 2002
@@ -3468,9 +3468,6 @@
 COMPATIBLE_IOCTL(DRM_IOCTL_UNLOCK)
 COMPATIBLE_IOCTL(DRM_IOCTL_FINISH)
 #endif /* DRM */
-/* elevator */
-COMPATIBLE_IOCTL(BLKELVGET)
-COMPATIBLE_IOCTL(BLKELVSET)
 /* Big R */
 COMPATIBLE_IOCTL(RNDGETENTCNT)
 COMPATIBLE_IOCTL(RNDADDTOENTCNT)
===== arch/ppc64/kernel/ioctl32.c 1.14 vs edited =====
--- 1.14/arch/ppc64/kernel/ioctl32.c	Fri Nov  8 09:04:15 2002
+++ edited/arch/ppc64/kernel/ioctl32.c	Sun Nov 10 10:51:41 2002
@@ -3617,22 +3617,10 @@
 }	
 
 /* Fix sizeof(sizeof()) breakage */
-#define BLKELVGET_32	_IOR(0x12,106,int)
-#define BLKELVSET_32	_IOW(0x12,107,int)
 #define BLKBSZGET_32	_IOR(0x12,112,int)
 #define BLKBSZSET_32	_IOW(0x12,113,int)
 #define BLKGETSIZE64_32	_IOR(0x12,114,int)
 
-static int do_blkelvget(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	return sys_ioctl(fd, BLKELVGET, arg);
-}
-
-static int do_blkelvset(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	return sys_ioctl(fd, BLKELVSET, arg);
-}
-
 static int do_blkbszget(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
 	return sys_ioctl(fd, BLKBSZGET, arg);
@@ -4464,9 +4452,6 @@
 HANDLE_IOCTL(USBDEVFS_REAPURBNDELAY32, do_usbdevfs_reapurb),
 HANDLE_IOCTL(USBDEVFS_DISCSIGNAL32, do_usbdevfs_discsignal),
 /* take care of sizeof(sizeof()) breakage */
-/* elevator */
-HANDLE_IOCTL(BLKELVGET_32, do_blkelvget),
-HANDLE_IOCTL(BLKELVSET_32, do_blkelvset),
 /* block stuff */
 HANDLE_IOCTL(BLKBSZGET_32, do_blkbszget),
 HANDLE_IOCTL(BLKBSZSET_32, do_blkbszset),
===== arch/s390x/kernel/ioctl32.c 1.8 vs edited =====
--- 1.8/arch/s390x/kernel/ioctl32.c	Thu Oct 31 16:05:57 2002
+++ edited/arch/s390x/kernel/ioctl32.c	Fri Nov  8 17:17:03 2002
@@ -802,9 +802,6 @@
 	IOCTL32_DEFAULT(BLKBSZGET),
 	IOCTL32_DEFAULT(BLKGETSIZE64),
 
-	IOCTL32_DEFAULT(BLKELVGET),
-	IOCTL32_DEFAULT(BLKELVSET),
-
 	IOCTL32_HANDLER(HDIO_GETGEO, hd_geometry_ioctl),
 
 	IOCTL32_DEFAULT(TCGETA),
===== arch/sparc64/kernel/ioctl32.c 1.44 vs edited =====
--- 1.44/arch/sparc64/kernel/ioctl32.c	Sat Nov  2 11:08:42 2002
+++ edited/arch/sparc64/kernel/ioctl32.c	Fri Nov  8 17:16:50 2002
@@ -4248,22 +4248,10 @@
 }	
 
 /* Fix sizeof(sizeof()) breakage */
-#define BLKELVGET_32	_IOR(0x12,106,int)
-#define BLKELVSET_32	_IOW(0x12,107,int)
 #define BLKBSZGET_32	_IOR(0x12,112,int)
 #define BLKBSZSET_32	_IOW(0x12,113,int)
 #define BLKGETSIZE64_32	_IOR(0x12,114,int)
 
-static int do_blkelvget(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	return sys_ioctl(fd, BLKELVGET, arg);
-}
-
-static int do_blkelvset(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	return sys_ioctl(fd, BLKELVSET, arg);
-}
-
 static int do_blkbszget(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
 	return sys_ioctl(fd, BLKBSZGET, arg);
@@ -5212,9 +5200,6 @@
 HANDLE_IOCTL(USBDEVFS_REAPURBNDELAY32, do_usbdevfs_reapurb)
 HANDLE_IOCTL(USBDEVFS_DISCSIGNAL32, do_usbdevfs_discsignal)
 /* take care of sizeof(sizeof()) breakage */
-/* elevator */
-HANDLE_IOCTL(BLKELVGET_32, do_blkelvget)
-HANDLE_IOCTL(BLKELVSET_32, do_blkelvset)
 /* block stuff */
 HANDLE_IOCTL(BLKBSZGET_32, do_blkbszget)
 HANDLE_IOCTL(BLKBSZSET_32, do_blkbszset)
===== arch/x86_64/ia32/ia32_ioctl.c 1.11 vs edited =====
--- 1.11/arch/x86_64/ia32/ia32_ioctl.c	Sat Oct 19 05:19:36 2002
+++ edited/arch/x86_64/ia32/ia32_ioctl.c	Fri Nov  8 17:16:27 2002
@@ -3566,22 +3566,10 @@
 } 
 
 /* Fix sizeof(sizeof()) breakage */
-#define BLKELVGET_32   _IOR(0x12,106,int)
-#define BLKELVSET_32   _IOW(0x12,107,int)
 #define BLKBSZGET_32   _IOR(0x12,112,int)
 #define BLKBSZSET_32   _IOW(0x12,113,int)
 #define BLKGETSIZE64_32        _IOR(0x12,114,int)
 
-static int do_blkelvget(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-       return sys_ioctl(fd, BLKELVGET, arg);
-}
-
-static int do_blkelvset(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-       return sys_ioctl(fd, BLKELVSET, arg);
-}
-
 static int do_blkbszget(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
        return sys_ioctl(fd, BLKBSZGET, arg);
@@ -5005,9 +4993,6 @@
 HANDLE_IOCTL(USBDEVFS_REAPURBNDELAY32, do_usbdevfs_reapurb)
 HANDLE_IOCTL(USBDEVFS_DISCSIGNAL32, do_usbdevfs_discsignal)
 /* take care of sizeof(sizeof()) breakage */
-/* elevator */
-HANDLE_IOCTL(BLKELVGET_32, do_blkelvget)
-HANDLE_IOCTL(BLKELVSET_32, do_blkelvset)
 /* block stuff */
 HANDLE_IOCTL(BLKBSZGET_32, do_blkbszget)
 HANDLE_IOCTL(BLKBSZSET_32, do_blkbszset)
===== drivers/block/deadline-iosched.c 1.12 vs edited =====
--- 1.12/drivers/block/deadline-iosched.c	Sun Nov 10 10:50:14 2002
+++ edited/drivers/block/deadline-iosched.c	Sun Nov 10 15:53:29 2002
@@ -17,23 +17,22 @@
 #include <linux/init.h>
 #include <linux/compiler.h>
 #include <linux/hash.h>
+#include <linux/rbtree.h>
 
 /*
- * feel free to try other values :-). read_expire value is the timeout for
- * reads, our goal is to start a request "around" the time when it expires.
- * fifo_batch is how many steps along the sorted list we will take when the
- * front fifo request expires.
+ * See Documentation/deadline-iosched.txt
  */
-static int read_expire = HZ / 2;	/* 500ms start timeout */
+static int read_expire = HZ / 2;
+static int writes_starved = 2;
 static int fifo_batch = 16;
-static int seek_cost = 16;		/* seek is 16 times more expensive */
 
 /*
- * how many times reads are allowed to starve writes
+ * the below could be a "disk-profile" type of thing
  */
-static int writes_starved = 2;
+static int seek_cost = 16;
+static int stream_unit = 256;
 
-static const int deadline_hash_shift = 8;
+static const int deadline_hash_shift = 10;
 #define DL_HASH_BLOCK(sec)	((sec) >> 3)
 #define DL_HASH_FN(sec)		(hash_long(DL_HASH_BLOCK((sec)), deadline_hash_shift))
 #define DL_HASH_ENTRIES		(1 << deadline_hash_shift)
@@ -48,7 +47,7 @@
 	/*
 	 * run time data
 	 */
-	struct list_head sort_list[2];	/* sorted listed */
+	struct rb_root rb_list[2];
 	struct list_head read_fifo;	/* fifo list */
 	struct list_head *dispatch;	/* driver dispatch queue */
 	struct list_head *hash;		/* request hash */
@@ -59,20 +58,36 @@
 	/*
 	 * settings that change how the i/o scheduler behaves
 	 */
-	unsigned int fifo_batch;
-	unsigned long read_expire;
-	unsigned int seek_cost;
-	unsigned int writes_starved;
+	int fifo_batch;
+	int read_expire;
+	int seek_cost;
+	int stream_unit;
+	int writes_starved;
+	int front_merges;
 };
 
 /*
  * pre-request data.
  */
 struct deadline_rq {
-	struct list_head fifo;
+	/*
+	 * rbtree index, key is the starting offset
+	 */
+	struct rb_node rb_node;
+	sector_t rb_key;
+
+	struct request *request;
+
+	/*
+	 * request hash, key is the ending offset (for back merge lookup)
+	 */
 	struct list_head hash;
 	unsigned long hash_valid_count;
-	struct request *request;
+
+	/*
+	 * expire fifo
+	 */
+	struct list_head fifo;
 	unsigned long expires;
 };
 
@@ -81,23 +96,23 @@
 #define RQ_DATA(rq)	((struct deadline_rq *) (rq)->elevator_private)
 
 /*
- * rq hash
+ * the back merge hash support functions
  */
-static inline void __deadline_del_rq_hash(struct deadline_rq *drq)
+static inline void __deadline_hash_del(struct deadline_rq *drq)
 {
 	drq->hash_valid_count = 0;
 	list_del_init(&drq->hash);
 }
 
 #define ON_HASH(drq)	(drq)->hash_valid_count
-static inline void deadline_del_rq_hash(struct deadline_rq *drq)
+static inline void deadline_hash_del(struct deadline_rq *drq)
 {
 	if (ON_HASH(drq))
-		__deadline_del_rq_hash(drq);
+		__deadline_hash_del(drq);
 }
 
 static inline void
-deadline_add_rq_hash(struct deadline_data *dd, struct deadline_rq *drq)
+deadline_hash_add(struct deadline_data *dd, struct deadline_rq *drq)
 {
 	struct request *rq = drq->request;
 
@@ -109,33 +124,30 @@
 
 #define list_entry_hash(ptr)	list_entry((ptr), struct deadline_rq, hash)
 static struct request *
-deadline_find_hash(struct deadline_data *dd, sector_t offset)
+deadline_hash_find(struct deadline_data *dd, sector_t offset)
 {
 	struct list_head *hash_list = &dd->hash[DL_HASH_FN(offset)];
 	struct list_head *entry, *next = hash_list->next;
-	struct deadline_rq *drq;
-	struct request *rq = NULL;
 
 	while ((entry = next) != hash_list) {
+		struct deadline_rq *drq = list_entry_hash(entry);
+		struct request *__rq = drq->request;
+
 		next = entry->next;
 		
-		drq = list_entry_hash(entry);
+		BUG_ON(!ON_HASH(drq));
 
-		BUG_ON(!drq->hash_valid_count);
-
-		if (!rq_mergeable(drq->request)
+		if (!rq_mergeable(__rq)
 		    || drq->hash_valid_count != dd->hash_valid_count) {
-			__deadline_del_rq_hash(drq);
+			__deadline_hash_del(drq);
 			continue;
 		}
 
-		if (drq->request->sector + drq->request->nr_sectors == offset) {
-			rq = drq->request;
-			break;
-		}
+		if (__rq->sector + __rq->nr_sectors == offset)
+			return __rq;
 	}
 
-	return rq;
+	return NULL;
 }
 
 static sector_t deadline_get_last_sector(struct deadline_data *dd)
@@ -154,86 +166,135 @@
 	return last_sec;
 }
 
+/*
+ * rb tree support functions
+ */
+#define RB_NONE		(2)
+#define RB_EMPTY(root)	((root)->rb_node == NULL)
+#define ON_RB(node)	((node)->rb_color != RB_NONE)
+#define RB_CLEAR(node)	((node)->rb_color = RB_NONE)
+#define deadline_rb_entry(node)	rb_entry((node), struct deadline_rq, rb_node)
+#define DRQ_RB_ROOT(dd, drq)	(&(dd)->rb_list[rq_data_dir((drq)->request)])
+
+static inline int
+__deadline_rb_add(struct deadline_data *dd, struct deadline_rq *drq)
+{
+	struct rb_node **p = &DRQ_RB_ROOT(dd, drq)->rb_node;
+	struct rb_node *parent = NULL;
+	struct deadline_rq *__drq;
+
+	while (*p) {
+		parent = *p;
+		__drq = deadline_rb_entry(parent);
+
+		if (drq->rb_key < __drq->rb_key)
+			p = &(*p)->rb_left;
+		else if (drq->rb_key > __drq->rb_key)
+			p = &(*p)->rb_right;
+		else
+			return 1;
+	}
+
+	rb_link_node(&drq->rb_node, parent, p);
+	return 0;
+}
+
+static void deadline_rb_add(struct deadline_data *dd, struct deadline_rq *drq)
+{
+	drq->rb_key = drq->request->sector;
+
+	if (!__deadline_rb_add(dd, drq)) {
+		rb_insert_color(&drq->rb_node, DRQ_RB_ROOT(dd, drq));
+		return;
+	}
+
+	/*
+	 * this cannot happen
+	 */
+	blk_dump_rq_flags(drq->request, "deadline_rb_add alias");
+	list_add_tail(&drq->request->queuelist, dd->dispatch);
+}
+
+static inline void
+deadline_rb_del(struct deadline_data *dd, struct deadline_rq *drq)
+{
+	if (ON_RB(&drq->rb_node)) {
+		rb_erase(&drq->rb_node, DRQ_RB_ROOT(dd, drq));
+		RB_CLEAR(&drq->rb_node);
+	}
+}
+
+static struct request *
+deadline_rb_find(struct deadline_data *dd, sector_t sector, int data_dir)
+{
+	struct rb_node *n = dd->rb_list[data_dir].rb_node;
+	struct deadline_rq *drq;
+
+	while (n) {
+		drq = deadline_rb_entry(n);
+
+		if (sector < drq->rb_key)
+			n = n->rb_left;
+		else if (sector > drq->rb_key)
+			n = n->rb_right;
+		else
+			return drq->request;
+	}
+
+	return NULL;
+}
+
 static int
 deadline_merge(request_queue_t *q, struct list_head **insert, struct bio *bio)
 {
 	struct deadline_data *dd = q->elevator.elevator_data;
-	const int data_dir = bio_data_dir(bio);
-	struct list_head *entry, *sort_list;
 	struct request *__rq;
-	int ret = ELEVATOR_NO_MERGE;
+	int ret;
 
 	/*
 	 * try last_merge to avoid going to hash
 	 */
 	ret = elv_try_last_merge(q, bio);
 	if (ret != ELEVATOR_NO_MERGE) {
-		*insert = q->last_merge;
-		goto out;
+		__rq = list_entry_rq(q->last_merge);
+		goto out_insert;
 	}
 
 	/*
 	 * see if the merge hash can satisfy a back merge
 	 */
-	if ((__rq = deadline_find_hash(dd, bio->bi_sector))) {
+	__rq = deadline_hash_find(dd, bio->bi_sector);
+	if (__rq) {
 		BUG_ON(__rq->sector + __rq->nr_sectors != bio->bi_sector);
 
 		if (elv_rq_merge_ok(__rq, bio)) {
-			*insert = &__rq->queuelist;
 			ret = ELEVATOR_BACK_MERGE;
 			goto out;
 		}
 	}
 
 	/*
-	 * scan list from back to find insertion point.
+	 * check for front merge
 	 */
-	entry = sort_list = &dd->sort_list[data_dir];
-	while ((entry = entry->prev) != sort_list) {
-		__rq = list_entry_rq(entry);
-
-		BUG_ON(__rq->flags & REQ_STARTED);
+	if (dd->front_merges) {
+		sector_t rb_key = bio->bi_sector + bio_sectors(bio);
 
-		if (!(__rq->flags & REQ_CMD))
-			continue;
-
-		/*
-		 * it's not necessary to break here, and in fact it could make
-		 * us loose a front merge. emperical evidence shows this to
-		 * be a big waste of cycles though, so quit scanning
-		 */
-		if (!*insert && bio_rq_in_between(bio, __rq, sort_list)) {
-			*insert = &__rq->queuelist;
-			break;
-		}
-
-		if (__rq->flags & (REQ_SOFTBARRIER | REQ_HARDBARRIER))
-			break;
-
-		/*
-		 * checking for a front merge, hash will miss those
-		 */
-		if (__rq->sector - bio_sectors(bio) == bio->bi_sector) {
-			ret = elv_try_merge(__rq, bio);
-			if (ret != ELEVATOR_NO_MERGE) {
-				*insert = &__rq->queuelist;
-				break;
+		__rq = deadline_rb_find(dd, rb_key, bio_data_dir(bio));
+		if (__rq) {
+			BUG_ON(rb_key != __rq->sector);
+
+			if (elv_rq_merge_ok(__rq, bio)) {
+				ret = ELEVATOR_FRONT_MERGE;
+				goto out;
 			}
 		}
 	}
 
-	/*
-	 * no insertion point found, check the very front
-	 */
-	if (!*insert && !list_empty(sort_list)) {
-		__rq = list_entry_rq(sort_list->next);
-
-		if (bio->bi_sector + bio_sectors(bio) < __rq->sector &&
-		    bio->bi_sector > deadline_get_last_sector(dd))
-			*insert = sort_list;
-	}
-
+	return ELEVATOR_NO_MERGE;
 out:
+	q->last_merge = &__rq->queuelist;
+out_insert:
+	*insert = &__rq->queuelist;
 	return ret;
 }
 
@@ -242,8 +303,19 @@
 	struct deadline_data *dd = q->elevator.elevator_data;
 	struct deadline_rq *drq = RQ_DATA(req);
 
-	deadline_del_rq_hash(drq);
-	deadline_add_rq_hash(dd, drq);
+	/*
+	 * hash always needs to be repositioned, key is end sector
+	 */
+	deadline_hash_del(drq);
+	deadline_hash_add(dd, drq);
+
+	/*
+	 * if the merge was a front merge, we need to reposition request
+	 */
+	if (req->sector != drq->rb_key) {
+		deadline_rb_del(dd, drq);
+		deadline_rb_add(dd, drq);
+	}
 
 	q->last_merge = &req->queuelist;
 }
@@ -258,11 +330,16 @@
 	BUG_ON(!drq);
 	BUG_ON(!dnext);
 
-	deadline_del_rq_hash(drq);
-	deadline_add_rq_hash(dd, drq);
+	deadline_hash_del(drq);
+	deadline_hash_add(dd, drq);
+
+	if (req->sector != drq->rb_key) {
+		deadline_rb_del(dd, drq);
+		deadline_rb_add(dd, drq);
+	}
 
 	/*
-	 * if dnext expires before drq, assign it's expire time to drq
+	 * if dnext expires before drq, assign its expire time to drq
 	 * and move into dnext position (dnext will be deleted) in fifo
 	 */
 	if (!list_empty(&drq->fifo) && !list_empty(&dnext->fifo)) {
@@ -274,53 +351,57 @@
 }
 
 /*
- * move request from sort list to dispatch queue. maybe remove from rq hash
- * here too?
+ * move request from sort list to dispatch queue.
  */
 static inline void
-deadline_move_to_dispatch(struct deadline_data *dd, struct request *rq)
+deadline_move_to_dispatch(struct deadline_data *dd, struct deadline_rq *drq)
 {
-	struct deadline_rq *drq = RQ_DATA(rq);
-
-	list_move_tail(&rq->queuelist, dd->dispatch);
+	deadline_rb_del(dd, drq);
 	list_del_init(&drq->fifo);
+	list_add_tail(&drq->request->queuelist, dd->dispatch);
 }
 
 /*
- * move along sort list and move entries to dispatch queue, starting from rq
+ * move along sort list and move entries to dispatch queue, starting from drq
  */
-static void deadline_move_requests(struct deadline_data *dd, struct request *rq)
+static void deadline_move_requests(struct deadline_data *dd, struct deadline_rq *drq)
 {
-	struct list_head *sort_head = &dd->sort_list[rq_data_dir(rq)];
 	sector_t last_sec = deadline_get_last_sector(dd);
+	const int stream_unit = dd->stream_unit << 1;
 	int batch_count = dd->fifo_batch;
 
 	do {
-		struct list_head *nxt = rq->queuelist.next;
+		struct rb_node *rbnext = rb_next(&drq->rb_node);
+		struct deadline_rq *dnext = NULL;
+		struct request *__rq;
 		int this_rq_cost;
 
+		if (rbnext)
+			dnext = deadline_rb_entry(rbnext);
+
 		/*
 		 * take it off the sort and fifo list, move
 		 * to dispatch queue
 		 */
-		deadline_move_to_dispatch(dd, rq);
+		deadline_move_to_dispatch(dd, drq);
 
 		/*
 		 * if this is the last entry, don't bother doing accounting
 		 */
-		if (nxt == sort_head)
+		if (dnext == NULL)
 			break;
 
+		__rq = drq->request;
 		this_rq_cost = dd->seek_cost;
-		if (rq->sector == last_sec)
-			this_rq_cost = (rq->nr_sectors + 255) >> 8;
+		if (__rq->sector == last_sec)
+			this_rq_cost = (__rq->nr_sectors + stream_unit - 1) / stream_unit;
 
 		batch_count -= this_rq_cost;
 		if (batch_count <= 0)
 			break;
 
-		last_sec = rq->sector + rq->nr_sectors;
-		rq = list_entry_rq(nxt);
+		last_sec = __rq->sector + __rq->nr_sectors;
+		drq = dnext;
 	} while (1);
 }
 
@@ -343,25 +424,10 @@
 	return 0;
 }
 
-static struct request *deadline_next_request(request_queue_t *q)
+static int deadline_dispatch_requests(struct deadline_data *dd)
 {
-	struct deadline_data *dd = q->elevator.elevator_data;
+	const int writes = !RB_EMPTY(&dd->rb_list[WRITE]);
 	struct deadline_rq *drq;
-	struct list_head *nxt;
-	struct request *rq;
-	int writes;
-
-	/*
-	 * if still requests on the dispatch queue, just grab the first one
-	 */
-	if (!list_empty(&q->queue_head)) {
-dispatch:
-		rq = list_entry_rq(q->queue_head.next);
-		dd->last_sector = rq->sector + rq->nr_sectors;
-		return rq;
-	}
-
-	writes = !list_empty(&dd->sort_list[WRITE]);
 
 	/*
 	 * if we have expired entries on the fifo list, move some to dispatch
@@ -370,19 +436,18 @@
 		if (writes && (dd->starved++ >= dd->writes_starved))
 			goto dispatch_writes;
 
-		nxt = dd->read_fifo.next;
-		drq = list_entry_fifo(nxt);
-		deadline_move_requests(dd, drq->request);
-		goto dispatch;
+		drq = list_entry_fifo(dd->read_fifo.next);
+dispatch_requests:
+		deadline_move_requests(dd, drq);
+		return 1;
 	}
 
-	if (!list_empty(&dd->sort_list[READ])) {
+	if (!RB_EMPTY(&dd->rb_list[READ])) {
 		if (writes && (dd->starved++ >= dd->writes_starved))
 			goto dispatch_writes;
 
-		nxt = dd->sort_list[READ].next;
-		deadline_move_requests(dd, list_entry_rq(nxt));
-		goto dispatch;
+		drq = deadline_rb_entry(rb_first(&dd->rb_list[READ]));
+		goto dispatch_requests;
 	}
 
 	/*
@@ -391,14 +456,40 @@
 	 */
 	if (writes) {
 dispatch_writes:
-		nxt = dd->sort_list[WRITE].next;
-		deadline_move_requests(dd, list_entry_rq(nxt));
 		dd->starved = 0;
-		goto dispatch;
+
+		drq = deadline_rb_entry(rb_first(&dd->rb_list[WRITE]));
+		goto dispatch_requests;
 	}
 
-	BUG_ON(!list_empty(&dd->sort_list[READ]));
-	BUG_ON(writes);
+	return 0;
+}
+
+static struct request *deadline_next_request(request_queue_t *q)
+{
+	struct deadline_data *dd = q->elevator.elevator_data;
+	struct request *rq;
+
+	/*
+	 * if there are still requests on the dispatch queue, grab the first one
+	 */
+	if (!list_empty(dd->dispatch)) {
+dispatch:
+		rq = list_entry_rq(dd->dispatch->next);
+		dd->last_sector = rq->sector + rq->nr_sectors;
+		return rq;
+	}
+
+	if (deadline_dispatch_requests(dd))
+		goto dispatch;
+
+	/*
+	 * if we have entries on the read or write sorted list, its a bug
+	 * if deadline_dispatch_requests() didn't move any
+	 */
+	BUG_ON(!RB_EMPTY(&dd->rb_list[READ]));
+	BUG_ON(!RB_EMPTY(&dd->rb_list[WRITE]));
+
 	return NULL;
 }
 
@@ -409,32 +500,28 @@
 	struct deadline_rq *drq = RQ_DATA(rq);
 	const int data_dir = rq_data_dir(rq);
 
-	/*
-	 * flush hash on barrier insert, as not to allow merges before a
-	 * barrier.
-	 */
 	if (unlikely(rq->flags & REQ_HARDBARRIER)) {
 		DL_INVALIDATE_HASH(dd);
 		q->last_merge = NULL;
 	}
 
-	/*
-	 * add to sort list
-	 */
-	if (!insert_here)
-		insert_here = dd->sort_list[data_dir].prev;
-
-	list_add(&rq->queuelist, insert_here);
+	if (unlikely(!(rq->flags & REQ_CMD))) {
+		if (!insert_here)
+			insert_here = dd->dispatch->prev;
 
-	if (unlikely(!(rq->flags & REQ_CMD)))
+		list_add(&rq->queuelist, insert_here);
 		return;
+	}
+
+	deadline_rb_add(dd, drq);
 
 	if (rq_mergeable(rq)) {
-		deadline_add_rq_hash(dd, drq);
+		deadline_hash_add(dd, drq);
 
 		if (!q->last_merge)
 			q->last_merge = &rq->queuelist;
-	}
+	} else
+		blk_dump_rq_flags(rq, "not mergeable");
 
 	if (data_dir == READ) {
 		/*
@@ -450,8 +537,11 @@
 	struct deadline_rq *drq = RQ_DATA(rq);
 
 	if (drq) {
+		struct deadline_data *dd = q->elevator.elevator_data;
+
 		list_del_init(&drq->fifo);
-		deadline_del_rq_hash(drq);
+		deadline_hash_del(drq);
+		deadline_rb_del(dd, drq);
 	}
 }
 
@@ -459,9 +549,9 @@
 {
 	struct deadline_data *dd = q->elevator.elevator_data;
 
-	if (!list_empty(&dd->sort_list[WRITE]) ||
-	    !list_empty(&dd->sort_list[READ]) ||
-	    !list_empty(&q->queue_head))
+	if (!RB_EMPTY(&dd->rb_list[WRITE]) ||
+	    !RB_EMPTY(&dd->rb_list[READ]) ||
+	    !list_empty(dd->dispatch))
 		return 0;
 
 	BUG_ON(!list_empty(&dd->read_fifo));
@@ -473,7 +563,7 @@
 {
 	struct deadline_data *dd = q->elevator.elevator_data;
 
-	return &dd->sort_list[rq_data_dir(rq)];
+	return dd->dispatch;
 }
 
 static void deadline_exit(request_queue_t *q, elevator_t *e)
@@ -484,8 +574,8 @@
 	int i;
 
 	BUG_ON(!list_empty(&dd->read_fifo));
-	BUG_ON(!list_empty(&dd->sort_list[READ]));
-	BUG_ON(!list_empty(&dd->sort_list[WRITE]));
+	BUG_ON(!RB_EMPTY(&dd->rb_list[READ]));
+	BUG_ON(!RB_EMPTY(&dd->rb_list[WRITE]));
 
 	for (i = READ; i <= WRITE; i++) {
 		struct request_list *rl = &q->rq[i];
@@ -538,14 +628,16 @@
 		INIT_LIST_HEAD(&dd->hash[i]);
 
 	INIT_LIST_HEAD(&dd->read_fifo);
-	INIT_LIST_HEAD(&dd->sort_list[READ]);
-	INIT_LIST_HEAD(&dd->sort_list[WRITE]);
+	dd->rb_list[READ] = RB_ROOT;
+	dd->rb_list[WRITE] = RB_ROOT;
 	dd->dispatch = &q->queue_head;
 	dd->fifo_batch = fifo_batch;
 	dd->read_expire = read_expire;
 	dd->seek_cost = seek_cost;
+	dd->stream_unit = stream_unit;
 	dd->hash_valid_count = 1;
 	dd->writes_starved = writes_starved;
+	dd->front_merges = 1;
 	e->elevator_data = dd;
 
 	for (i = READ; i <= WRITE; i++) {
@@ -567,6 +659,7 @@
 			memset(drq, 0, sizeof(*drq));
 			INIT_LIST_HEAD(&drq->fifo);
 			INIT_LIST_HEAD(&drq->hash);
+			RB_CLEAR(&drq->rb_node);
 			drq->request = rq;
 			rq->elevator_private = drq;
 		}
@@ -578,6 +671,149 @@
 	return ret;
 }
 
+/*
+ * sysfs parts below
+ */
+struct deadline_fs_entry {
+	struct attribute attr;
+	ssize_t (*show)(struct deadline_data *, char *, size_t, loff_t);
+	ssize_t (*store)(struct deadline_data *, const char *, size_t, loff_t);
+};
+
+static ssize_t
+deadline_var_show(unsigned int var, char *page, size_t count, loff_t off)
+{
+	if (off)
+		return 0;
+
+	return sprintf(page, "%d\n", var);
+}
+
+static ssize_t
+deadline_var_store(unsigned int *var, const char *page, size_t count,
+		   loff_t off)
+{
+	char *p = (char *) page;
+
+	if (off)
+		return 0;
+
+	*var = simple_strtoul(p, &p, 10);
+	return count;
+}
+
+#define SHOW_FUNCTION(__FUNC, __VAR)					\
+static ssize_t __FUNC(struct deadline_data *dd, char *page, size_t cnt,	\
+		      loff_t off) 					\
+{									\
+	return deadline_var_show(__VAR, (page), (cnt), (off));		\
+}
+SHOW_FUNCTION(deadline_fifo_show, dd->fifo_batch);
+SHOW_FUNCTION(deadline_readexpire_show, dd->read_expire);
+SHOW_FUNCTION(deadline_seekcost_show, dd->seek_cost);
+SHOW_FUNCTION(deadline_streamunit_show, dd->stream_unit);
+SHOW_FUNCTION(deadline_writesstarved_show, dd->writes_starved);
+SHOW_FUNCTION(deadline_frontmerges_show, dd->front_merges);
+#undef SHOW_FUNCTION
+
+#define STORE_FUNCTION(__FUNC, __PTR, MIN, MAX)				\
+static ssize_t __FUNC(struct deadline_data *dd, const char *page, size_t cnt, loff_t off)								\
+{									\
+	int ret = deadline_var_store(__PTR, (page), (cnt), (off));	\
+	if (*(__PTR) < (MIN))						\
+		*(__PTR) = (MIN);					\
+	else if (*(__PTR) > (MAX))					\
+		*(__PTR) = (MAX);					\
+	return ret;							\
+}
+STORE_FUNCTION(deadline_fifo_store, &dd->fifo_batch, 0, INT_MAX);
+STORE_FUNCTION(deadline_readexpire_store, &dd->read_expire, 0, INT_MAX);
+STORE_FUNCTION(deadline_seekcost_store, &dd->seek_cost, 0, INT_MAX);
+STORE_FUNCTION(deadline_streamunit_store, &dd->stream_unit, 0, INT_MAX);
+STORE_FUNCTION(deadline_writesstarved_store, &dd->writes_starved, INT_MIN, INT_MAX);
+STORE_FUNCTION(deadline_frontmerges_store, &dd->front_merges, 0, 1);
+#undef STORE_FUNCTION
+
+static struct deadline_fs_entry deadline_fifo_entry = {
+	.attr = {.name = "fifo_batch", .mode = S_IRUGO | S_IWUSR },
+	.show = deadline_fifo_show,
+	.store = deadline_fifo_store,
+};
+static struct deadline_fs_entry deadline_readexpire_entry = {
+	.attr = {.name = "read_expire", .mode = S_IRUGO | S_IWUSR },
+	.show = deadline_readexpire_show,
+	.store = deadline_readexpire_store,
+};
+static struct deadline_fs_entry deadline_seekcost_entry = {
+	.attr = {.name = "seek_cost", .mode = S_IRUGO | S_IWUSR },
+	.show = deadline_seekcost_show,
+	.store = deadline_seekcost_store,
+};
+static struct deadline_fs_entry deadline_streamunit_entry = {
+	.attr = {.name = "stream_unit", .mode = S_IRUGO | S_IWUSR },
+	.show = deadline_streamunit_show,
+	.store = deadline_streamunit_store,
+};
+static struct deadline_fs_entry deadline_writesstarved_entry = {
+	.attr = {.name = "writes_starved", .mode = S_IRUGO | S_IWUSR },
+	.show = deadline_writesstarved_show,
+	.store = deadline_writesstarved_store,
+};
+static struct deadline_fs_entry deadline_frontmerges_entry = {
+	.attr = {.name = "front_merges", .mode = S_IRUGO | S_IWUSR },
+	.show = deadline_frontmerges_show,
+	.store = deadline_frontmerges_store,
+};
+
+static struct attribute *default_attrs[] = {
+	&deadline_fifo_entry.attr,
+	&deadline_readexpire_entry.attr,
+	&deadline_seekcost_entry.attr,
+	&deadline_streamunit_entry.attr,
+	&deadline_writesstarved_entry.attr,
+	&deadline_frontmerges_entry.attr,
+	NULL,
+};
+
+#define to_deadline(atr) container_of((atr), struct deadline_fs_entry, attr)
+
+static ssize_t deadline_attr_show(struct kobject *kobj, struct attribute *attr,
+				  char *page, size_t count, loff_t off)
+{
+	elevator_t *e = container_of(kobj, elevator_t, kobj);
+	struct deadline_fs_entry *entry = to_deadline(attr);
+
+	if (!entry->show)
+		return 0;
+
+	return entry->show(e->elevator_data, page, count, off);
+}
+
+static ssize_t deadline_attr_store(struct kobject *kobj, struct attribute *attr,
+				   const char *page, size_t count, loff_t off)
+{
+	elevator_t *e = container_of(kobj, elevator_t, kobj);
+	struct deadline_fs_entry *entry = to_deadline(attr);
+
+	if (!entry->store)
+		return -EINVAL;
+
+	return entry->store(e->elevator_data, page, count, off);
+}
+
+static struct sysfs_ops deadline_sysfs_ops = {
+	.show	= &deadline_attr_show,
+	.store	= &deadline_attr_store,
+};
+
+extern struct subsystem block_subsys;
+
+struct subsystem deadline_subsys = {
+	.parent		= &block_subsys,
+	.sysfs_ops	= &deadline_sysfs_ops,
+	.default_attrs	= default_attrs,
+};
+
 static int __init deadline_slab_setup(void)
 {
 	drq_pool = kmem_cache_create("deadline_drq", sizeof(struct deadline_rq),
@@ -586,6 +822,7 @@
 	if (!drq_pool)
 		panic("deadline: can't init slab pool\n");
 
+	subsystem_register(&deadline_subsys);
 	return 0;
 }
 
@@ -602,6 +839,8 @@
 	.elevator_get_sort_head_fn =	deadline_get_sort_head,
 	.elevator_init_fn =		deadline_init,
 	.elevator_exit_fn =		deadline_exit,
+
+	.elevator_subsys =		&deadline_subsys,
 };
 
 EXPORT_SYMBOL(iosched_deadline);
===== drivers/block/elevator.c 1.36 vs edited =====
--- 1.36/drivers/block/elevator.c	Sun Nov 10 10:50:14 2002
+++ edited/drivers/block/elevator.c	Sun Nov 10 10:51:41 2002
@@ -381,6 +381,38 @@
 	return &q->queue_head;
 }
 
+int elv_register_fs(struct gendisk *disk)
+{
+	request_queue_t *q = disk->queue;
+	elevator_t *e;
+
+	if (!q)
+		return -ENXIO;
+
+	e = &q->elevator;
+
+	kobject_init(&e->kobj);
+
+	e->kobj.parent = kobject_get(&disk->kobj);
+	if (!e->kobj.parent)
+		return -EBUSY;
+
+	snprintf(e->kobj.name, KOBJ_NAME_LEN, "%s", "iosched");
+	e->kobj.subsys = e->elevator_subsys;
+
+	return kobject_register(&e->kobj);
+}
+
+void elv_unregister_fs(struct gendisk *disk)
+{
+	request_queue_t *q = disk->queue;
+	elevator_t *e = &q->elevator;
+
+	kobject_get(&e->kobj);
+	kobject_unregister(&e->kobj);
+	kobject_put(&disk->kobj);
+}
+
 elevator_t elevator_noop = {
 	.elevator_merge_fn		= elevator_noop_merge,
 	.elevator_next_req_fn		= elevator_noop_next_request,
===== drivers/block/genhd.c 1.58 vs edited =====
--- 1.58/drivers/block/genhd.c	Mon Oct 21 09:53:07 2002
+++ edited/drivers/block/genhd.c	Fri Nov  8 12:56:16 2002
@@ -119,6 +119,7 @@
 	blk_register_region(MKDEV(disk->major, disk->first_minor), disk->minors,
 			NULL, exact_match, exact_lock, disk);
 	register_disk(disk);
+	elv_register_fs(disk);
 }
 
 EXPORT_SYMBOL(add_disk);
===== drivers/block/ioctl.c 1.51 vs edited =====
--- 1.51/drivers/block/ioctl.c	Mon Oct 28 20:57:58 2002
+++ edited/drivers/block/ioctl.c	Fri Nov  8 17:14:32 2002
@@ -128,10 +128,6 @@
 	int ret, n;
 
 	switch (cmd) {
-	case BLKELVGET:
-	case BLKELVSET:
-		/* deprecated, use the /proc/iosched interface instead */
-		return -ENOTTY;
 	case BLKRAGET:
 	case BLKFRAGET:
 		if (!arg)
===== drivers/block/ll_rw_blk.c 1.140 vs edited =====
--- 1.140/drivers/block/ll_rw_blk.c	Sun Nov 10 10:50:14 2002
+++ edited/drivers/block/ll_rw_blk.c	Sun Nov 10 10:51:41 2002
@@ -73,7 +73,7 @@
 {
 	int ret;
 
-	ret = queue_nr_requests / 4 - 1;
+	ret = queue_nr_requests / 8 - 1;
 	if (ret < 0)
 		ret = 1;
 	return ret;
@@ -86,7 +86,7 @@
 {
 	int ret;
 
-	ret = queue_nr_requests / 4 + 1;
+	ret = queue_nr_requests / 8 + 1;
 	if (ret > queue_nr_requests)
 		ret = queue_nr_requests;
 	return ret;
@@ -700,31 +700,22 @@
 	seg_size = nr_phys_segs = nr_hw_segs = 0;
 	bio_for_each_segment(bv, bio, i) {
 		if (bvprv && cluster) {
-			int phys, seg;
-
-			if (seg_size + bv->bv_len > q->max_segment_size) {
-				nr_phys_segs++;
+			if (seg_size + bv->bv_len > q->max_segment_size)
 				goto new_segment;
-			}
-
-			phys = BIOVEC_PHYS_MERGEABLE(bvprv, bv);
-			seg = BIOVEC_SEG_BOUNDARY(q, bvprv, bv);
-			if (!phys || !seg)
-				nr_phys_segs++;
-			if (!seg)
+			if (!BIOVEC_PHYS_MERGEABLE(bvprv, bv))
 				goto new_segment;
-
-			if (!BIOVEC_VIRT_MERGEABLE(bvprv, bv))
+			if (!BIOVEC_SEG_BOUNDARY(q, bvprv, bv))
 				goto new_segment;
 
 			seg_size += bv->bv_len;
 			bvprv = bv;
 			continue;
-		} else {
-			nr_phys_segs++;
 		}
 new_segment:
-		nr_hw_segs++;
+		if (!bvprv || !BIOVEC_VIRT_MERGEABLE(bvprv, bv))
+			nr_hw_segs++;
+
+		nr_phys_segs++;
 		bvprv = bv;
 		seg_size = bv->bv_len;
 	}
@@ -1621,7 +1612,7 @@
 	struct list_head *next = rq->queuelist.next;
 	struct list_head *sort_head = elv_get_sort_head(q, rq);
 
-	if (next != sort_head)
+	if (next != sort_head && next != &rq->queuelist)
 		attempt_merge(q, rq, list_entry_rq(next));
 }
 
@@ -1630,7 +1621,7 @@
 	struct list_head *prev = rq->queuelist.prev;
 	struct list_head *sort_head = elv_get_sort_head(q, rq);
 
-	if (prev != sort_head)
+	if (prev != sort_head && prev != &rq->queuelist)
 		attempt_merge(q, list_entry_rq(prev), rq);
 }
 
@@ -2180,8 +2171,8 @@
 	queue_nr_requests = (total_ram >> 9) & ~7;
 	if (queue_nr_requests < 16)
 		queue_nr_requests = 16;
-	if (queue_nr_requests > 128)
-		queue_nr_requests = 128;
+	if (queue_nr_requests > 1024)
+		queue_nr_requests = 1024;
 
 	batch_requests = queue_nr_requests / 8;
 	if (batch_requests > 8)
===== fs/partitions/check.c 1.83 vs edited =====
--- 1.83/fs/partitions/check.c	Fri Nov  8 18:14:38 2002
+++ edited/fs/partitions/check.c	Sun Nov 10 10:51:41 2002
@@ -521,6 +521,7 @@
 		invalidate_device(devp, 1);
 		delete_partition(disk, p);
 	}
+	elv_unregister_fs(disk);
 	devp = mk_kdev(disk->major,disk->first_minor);
 	invalidate_device(devp, 1);
 	disk->capacity = 0;
===== fs/sysfs/inode.c 1.59 vs edited =====
--- 1.59/fs/sysfs/inode.c	Wed Oct 30 21:27:35 2002
+++ edited/fs/sysfs/inode.c	Fri Nov  8 14:33:59 2002
@@ -243,7 +243,7 @@
 	if (kobj && kobj->subsys)
 		ops = kobj->subsys->sysfs_ops;
 	if (!ops || !ops->store)
-		return 0;
+		return -EINVAL;
 
 	page = (char *)__get_free_page(GFP_KERNEL);
 	if (!page)
===== include/linux/elevator.h 1.17 vs edited =====
--- 1.17/include/linux/elevator.h	Mon Oct 28 18:51:57 2002
+++ edited/include/linux/elevator.h	Fri Nov  8 17:15:20 2002
@@ -35,6 +35,9 @@
 	elevator_exit_fn *elevator_exit_fn;
 
 	void *elevator_data;
+
+	struct kobject kobj;
+	struct subsystem *elevator_subsys;
 };
 
 /*
@@ -49,6 +52,8 @@
 extern void elv_remove_request(request_queue_t *, struct request *);
 extern int elv_queue_empty(request_queue_t *);
 extern inline struct list_head *elv_get_sort_head(request_queue_t *, struct request *);
+extern int elv_register_fs(struct gendisk *);
+extern void elv_unregister_fs(struct gendisk *);
 
 #define __elv_add_request_pos(q, rq, pos)	\
 	(q)->elevator.elevator_add_req_fn((q), (rq), (pos))
@@ -63,18 +68,6 @@
  * starvation
  */
 extern elevator_t iosched_deadline;
-
-/*
- * use the /proc/iosched interface, all the below is history ->
- */
-typedef struct blkelv_ioctl_arg_s {
-	int queue_ID;
-	int read_latency;
-	int write_latency;
-	int max_bomb_segments;
-} blkelv_ioctl_arg_t;
-#define BLKELVGET   _IOR(0x12,106,sizeof(blkelv_ioctl_arg_t))
-#define BLKELVSET   _IOW(0x12,107,sizeof(blkelv_ioctl_arg_t))
 
 extern int elevator_init(request_queue_t *, elevator_t *);
 extern void elevator_exit(request_queue_t *);

-- 
Jens Axboe

