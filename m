Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317893AbSHKHYv>; Sun, 11 Aug 2002 03:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317898AbSHKHYv>; Sun, 11 Aug 2002 03:24:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29446 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317893AbSHKHYs>;
	Sun, 11 Aug 2002 03:24:48 -0400
Message-ID: <3D561473.40A53C0D@zip.com.au>
Date: Sun, 11 Aug 2002 00:38:27 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 2/21] reduced locking in buffer.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Resend.  Replace the buffer lru spinlock protection with
local_irq_disable and a cross-CPU call to invalidate them.



 buffer.c |   75 ++++++++++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 48 insertions(+), 27 deletions(-)

--- 2.5.31/fs/buffer.c~buffer-lru-lock	Sat Aug 10 23:27:26 2002
+++ 2.5.31-akpm/fs/buffer.c	Sat Aug 10 23:27:26 2002
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
@@ -2554,9 +2578,6 @@ void __init buffer_init(void)
 {
 	int i;
 
-	for (i = 0; i < NR_CPUS; i++)
-		spin_lock_init(&bh_lrus[i].lock);
-
 	bh_cachep = kmem_cache_create("buffer_head",
 			sizeof(struct buffer_head), 0,
 			SLAB_HWCACHE_ALIGN, init_buffer_head, NULL);

.
