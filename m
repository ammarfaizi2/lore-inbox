Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318706AbSH1EXa>; Wed, 28 Aug 2002 00:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318696AbSH1EXa>; Wed, 28 Aug 2002 00:23:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3602 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318706AbSH1EX1>;
	Wed, 28 Aug 2002 00:23:27 -0400
Message-ID: <3D6C53ED.32044CAD@zip.com.au>
Date: Tue, 27 Aug 2002 21:39:09 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] adjustments to dirty memory thresholds
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Writeback parameter tuning.  Somewhat experimental, but heading in the
right direction, I hope.

- Allowing 40% of physical memory to be dirtied on massive ia32 boxes
  is unreasonable.  It pins too many buffer_heads and contribues to
  page reclaim latency.

The patch changes the initial value of
/proc/sys/vm/dirty_background_ratio, dirty_async_ratio and (the
presently non-functional) dirty_sync_ratio so that they are reduced
when the highmem:lowmem ratio exceeds 4:1.

These ratios are scaled so that as the highmem:lowmem ratio goes
beyond 4:1, the maximum amount of allowed dirty memory ceases to
increase.  It is clamped at the amount of memory which a 4:1 machine
is allowed to use.

- Aggressive reduction in the dirty memory threshold at which
  background writeback cuts in.  2.4 uses 30% of ZONE_NORMAL.  2.5 uses
  40% of total memory.  This patch changes it to 10% of total memory
  (if total memory <= 4G.  Even less otherwise - see above).

This means that:

- Much more writeback is performed by pdflush.

- When the application is generating dirty data at a moderate
  rate, background writeback cuts in much earlier, so memory is
  cleaned more promptly.

- Reduces the risk of user applications getting stalled by writeback.

- Will damage dbench numbers.  So bite me.

  (It turns out that the damage is fairly small)

- Moderate reduction in the dirty level at which the write(2) caller
  is forced to perform writeback (throttling).  Was 40% of total
  memory.  Is now 30% of total memory (if total memory <= 4G, less
  otherwise).

  This is to reduce page reclaim latency, and generally because
  allowing processes to flood the machine with dirty data is a bad
  thing in mixed workloads.




 page-writeback.c |   50 ++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 38 insertions(+), 12 deletions(-)

--- 2.5.32/mm/page-writeback.c~writeback-thresholds	Tue Aug 27 21:35:27 2002
+++ 2.5.32-akpm/mm/page-writeback.c	Tue Aug 27 21:35:27 2002
@@ -38,7 +38,12 @@
  * After a CPU has dirtied this many pages, balance_dirty_pages_ratelimited
  * will look to see if it needs to force writeback or throttling.
  */
-static int ratelimit_pages = 32;
+static long ratelimit_pages = 32;
+
+/*
+ * The total number of pagesin the machine.
+ */
+static long total_pages;
 
 /*
  * When balance_dirty_pages decides that the caller needs to perform some
@@ -60,17 +65,17 @@ static inline int sync_writeback_pages(v
 /*
  * Start background writeback (via pdflush) at this level
  */
-int dirty_background_ratio = 40;
+int dirty_background_ratio = 10;
 
 /*
  * The generator of dirty data starts async writeback at this level
  */
-int dirty_async_ratio = 50;
+int dirty_async_ratio = 40;
 
 /*
  * The generator of dirty data performs sync writeout at this level
  */
-int dirty_sync_ratio = 60;
+int dirty_sync_ratio = 50;
 
 /*
  * The interval between `kupdate'-style writebacks, in centiseconds
@@ -107,18 +112,17 @@ static void background_writeout(unsigned
  */
 void balance_dirty_pages(struct address_space *mapping)
 {
-	const int tot = nr_free_pagecache_pages();
 	struct page_state ps;
-	int background_thresh, async_thresh, sync_thresh;
+	long background_thresh, async_thresh, sync_thresh;
 	unsigned long dirty_and_writeback;
 	struct backing_dev_info *bdi;
 
 	get_page_state(&ps);
 	dirty_and_writeback = ps.nr_dirty + ps.nr_writeback;
 
-	background_thresh = (dirty_background_ratio * tot) / 100;
-	async_thresh = (dirty_async_ratio * tot) / 100;
-	sync_thresh = (dirty_sync_ratio * tot) / 100;
+	background_thresh = (dirty_background_ratio * total_pages) / 100;
+	async_thresh = (dirty_async_ratio * total_pages) / 100;
+	sync_thresh = (dirty_sync_ratio * total_pages) / 100;
 	bdi = mapping->backing_dev_info;
 
 	if (dirty_and_writeback > sync_thresh) {
@@ -171,13 +175,14 @@ void balance_dirty_pages_ratelimited(str
  */
 static void background_writeout(unsigned long _min_pages)
 {
-	const int tot = nr_free_pagecache_pages();
-	const int background_thresh = (dirty_background_ratio * tot) / 100;
 	long min_pages = _min_pages;
+	long background_thresh;
 	int nr_to_write;
 
 	CHECK_EMERGENCY_SYNC
 
+	background_thresh = (dirty_background_ratio * total_pages) / 100;
+
 	do {
 		struct page_state ps;
 
@@ -269,7 +274,7 @@ static void wb_timer_fn(unsigned long un
 
 static void set_ratelimit(void)
 {
-	ratelimit_pages = nr_free_pagecache_pages() / (num_online_cpus() * 32);
+	ratelimit_pages = total_pages / (num_online_cpus() * 32);
 	if (ratelimit_pages < 16)
 		ratelimit_pages = 16;
 	if (ratelimit_pages * PAGE_CACHE_SIZE > 4096 * 1024)
@@ -288,8 +293,29 @@ static struct notifier_block ratelimit_n
 	.next		= NULL,
 };
 
+/*
+ * If the machine has a large highmem:lowmem ratio then scale back the default
+ * dirty memory thresholds: allowing too much dirty highmem pins an excessive
+ * number of buffer_heads.
+ */
 static int __init page_writeback_init(void)
 {
+	long buffer_pages = nr_free_buffer_pages();
+	long correction;
+
+	total_pages = nr_free_pagecache_pages();
+
+	correction = (100 * 4 * buffer_pages) / total_pages;
+
+	if (correction < 100) {
+		dirty_background_ratio *= correction;
+		dirty_background_ratio /= 100;
+		dirty_async_ratio *= correction;
+		dirty_async_ratio /= 100;
+		dirty_sync_ratio *= correction;
+		dirty_sync_ratio /= 100;
+	}
+
 	init_timer(&wb_timer);
 	wb_timer.expires = jiffies + (dirty_writeback_centisecs * HZ) / 100;
 	wb_timer.data = 0;

.
