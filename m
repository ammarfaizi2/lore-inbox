Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316500AbSHJA5h>; Fri, 9 Aug 2002 20:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316499AbSHJA5Y>; Fri, 9 Aug 2002 20:57:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22290 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316500AbSHJAzv>;
	Fri, 9 Aug 2002 20:55:51 -0400
Message-ID: <3D5464ED.67E1DBC5@zip.com.au>
Date: Fri, 09 Aug 2002 17:57:17 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 8/12] reduced buffer layer locking
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



lockmeter instrumentation shows that during a 60-second write to four
disks the kernel takes 12,000,000 spinlocks.  It wrote 1,000,000 pages.

The kernel is taking a spinlock once per 10,000 instructions.  That
seems to be quite a lot.  And it's not counting the 7,000,000 rwlocks. 
And lockmeter doesn't count the buslocked operations which arise from
semaphores or bitops.

3,000,000 of those spinlocks are pagemap_lru_lock.  The patches which
I'm working on against that lock reduce its count to 90,000.

Of the remaining 9,000,000 spinlockings, 3,000,000 are in
__find_get_block (getblk).

This patch removes the locking from __find_get_blocks(), so we're down
to 6,000,000.

The locking in __find_get_block() is only needed to protect against
invalidate_bh_lrus(), which is called at unmount and ioctl(BLKFLSBUF).

Remove the spinlocks and use a cross-CPU call to perform the
invalidate.  Protect against that with a local_irq_disable() in the
fastpath.

This assumes that local_irq_disable() is cheaper than a lock.

This code assumes that local_irq_save() provides protection from an
smp_call_function() handler.  This is OK in 2.5 but is not supported in
2.4.  Because sparc32 IPIs are not blocked by local_irq_disable() in
2.4.

On uniprocessor we don't need any of this locking - a preempt_disable()
in the invalidate path is sufficient.

The code assumes that find_get_block(), getblk() and bread() are never
called with interrupts disabled.  There is an x86 bugcheck for that. 
If it trips I'll need to fix the caller or replace local_irq_disable()
with local_irq_save().

The remaining piggy spinlocks are:

rmqueue(): 1,000,000

    One per page.  I'll be doing gang allocation for readahead, but
    for write(2) and anonymous pagefaults we'll need a per-cpu page
    buffer.  I have a patch for that but it's hacky.

__free_pages_ok(): 1,000,000

    gang-free is close, and will reduce this to 70,000-odd.

try_to_free_buffers(): 1,000,000
create_empty_buffers(): 1,000,000

    That's life with buffers.  A delayed-allocate ext2 would bring
    these to zero.

kmem_cache_reap: 270,000

    This one is interesting not because of the lock, but because of
    the semaphore.  The rwlock inside cache_chain_sem is 25% contended.

    What's happening is that each caller into page reclaim runs
    kmem_cache_reap: take the semaphore, futz around doing nothing for
    a while, then release the sempahore and go do page reclaim.

    This has the effect of serialising entry into the page reclaim
    and accidentally decreases contention on pagemap_lru_lock.




 buffer.c |   75 ++++++++++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 48 insertions, 27 deletions

--- 2.5.30/fs/buffer.c~buffer-lru-lock	Fri Aug  9 17:36:45 2002
+++ 2.5.30-akpm/fs/buffer.c	Fri Aug  9 17:36:45 2002
@@ -1277,15 +1277,32 @@ __bread_slow(struct block_device *bdev, 
  *
  * This is a transparent caching front-end to sb_bread(), sb_getblk() and
  * sb_find_get_block().
+ *
+ * The LRUs themselves only need locking against invalidate_bh_lrus.  We use
+ * a local interrupt disable for that.
  */
 
-#define BH_LRU_SIZE	7
+#define BH_LRU_SIZE	8
 
 static struct bh_lru {
-	spinlock_t lock;
 	struct buffer_head *bhs[BH_LRU_SIZE];
 } ____cacheline_aligned_in_smp bh_lrus[NR_CPUS];
 
+#ifdef CONFIG_SMP
+#define bh_lru_lock()	local_irq_disable()
+#define bh_lru_unlock()	local_irq_enable()
+#else
+#define bh_lru_lock()	preempt_disable()
+#define bh_lru_unlock()	preempt_enable()
+#endif
+
+static inline void check_irqs_on(void)
+{
+#ifdef irqs_disabled
+	BUG_ON(irqs_disabled());
+#endif
+}
+
 /*
  * The LRU management algorithm is dopey-but-simple.  Sorry.
  */
@@ -1297,8 +1314,9 @@ static void bh_lru_install(struct buffer
 	if (bh == NULL)
 		return;
 
-	lru = &bh_lrus[get_cpu()];
-	spin_lock(&lru->lock);
+	check_irqs_on();
+	bh_lru_lock();
+	lru = &bh_lrus[smp_processor_id()];
 	if (lru->bhs[0] != bh) {
 		struct buffer_head *bhs[BH_LRU_SIZE];
 		int in;
@@ -1324,8 +1342,7 @@ static void bh_lru_install(struct buffer
 			bhs[out++] = NULL;
 		memcpy(lru->bhs, bhs, sizeof(bhs));
 	}
-	spin_unlock(&lru->lock);
-	put_cpu();
+	bh_lru_unlock();
 
 	if (evictee) {
 		touch_buffer(evictee);
@@ -1340,8 +1357,9 @@ lookup_bh(struct block_device *bdev, sec
 	struct bh_lru *lru;
 	int i;
 
-	lru = &bh_lrus[get_cpu()];
-	spin_lock(&lru->lock);
+	check_irqs_on();
+	bh_lru_lock();
+	lru = &bh_lrus[smp_processor_id()];
 	for (i = 0; i < BH_LRU_SIZE; i++) {
 		struct buffer_head *bh = lru->bhs[i];
 
@@ -1359,8 +1377,7 @@ lookup_bh(struct block_device *bdev, sec
 			break;
 		}
 	}
-	spin_unlock(&lru->lock);
-	put_cpu();
+	bh_lru_unlock();
 	return ret;
 }
 
@@ -1407,26 +1424,33 @@ __bread(struct block_device *bdev, secto
 EXPORT_SYMBOL(__bread);
 
 /*
- * This is called rarely - at unmount.
+ * invalidate_bh_lrus() is called rarely - at unmount.  Because it is only for
+ * unmount it only needs to ensure that all buffers from the target device are
+ * invalidated on return and it doesn't need to worry about new buffers from
+ * that device being added - the unmount code has to prevent that.
  */
-static void invalidate_bh_lrus(void)
+static void invalidate_bh_lru(void *arg)
 {
-	int cpu_idx;
+	const int cpu = get_cpu();
+	int i;
 
-	for (cpu_idx = 0; cpu_idx < NR_CPUS; cpu_idx++)
-		spin_lock(&bh_lrus[cpu_idx].lock);
-	for (cpu_idx = 0; cpu_idx < NR_CPUS; cpu_idx++) {
-		int i;
-
-		for (i = 0; i < BH_LRU_SIZE; i++) {
-			brelse(bh_lrus[cpu_idx].bhs[i]);
-			bh_lrus[cpu_idx].bhs[i] = NULL;
-		}
+	for (i = 0; i < BH_LRU_SIZE; i++) {
+		brelse(bh_lrus[cpu].bhs[i]);
+		bh_lrus[cpu].bhs[i] = NULL;
 	}
-	for (cpu_idx = 0; cpu_idx < NR_CPUS; cpu_idx++)
-		spin_unlock(&bh_lrus[cpu_idx].lock);
+	put_cpu();
+}
+	
+static void invalidate_bh_lrus(void)
+{
+	preempt_disable();
+	invalidate_bh_lru(NULL);
+	smp_call_function(invalidate_bh_lru, NULL, 1, 1);
+	preempt_enable();
 }
 
+
+
 void set_bh_page(struct buffer_head *bh,
 		struct page *page, unsigned long offset)
 {
@@ -2560,9 +2584,6 @@ static void bh_mempool_free(void *elemen
 void __init buffer_init(void)
 {
 	int i;
-
-	for (i = 0; i < NR_CPUS; i++)
-		spin_lock_init(&bh_lrus[i].lock);
 
 	bh_cachep = kmem_cache_create("buffer_head",
 			sizeof(struct buffer_head), 0,

.
