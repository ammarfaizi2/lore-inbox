Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318228AbSHKHnF>; Sun, 11 Aug 2002 03:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318211AbSHKH0k>; Sun, 11 Aug 2002 03:26:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30214 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317898AbSHKHYx>;
	Sun, 11 Aug 2002 03:24:53 -0400
Message-ID: <3D561478.F5173015@zip.com.au>
Date: Sun, 11 Aug 2002 00:38:32 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 3/21] scaled writeback throttling levels
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(resend)

get_page_state() is showing up on profiles on some big machines.  It is
a quite expensive function and it is being called too often.

The patch replaces the hardwired RATELIMIT_PAGES with a calculated
amount based on the amount of memory in the machine and the number of
CPUs.



 page-writeback.c |   65 ++++++++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 55 insertions(+), 10 deletions(-)

--- 2.5.31/mm/page-writeback.c~ratelimit-scaling	Sat Aug 10 23:29:36 2002
+++ 2.5.31-akpm/mm/page-writeback.c	Sat Aug 10 23:29:36 2002
@@ -22,6 +22,8 @@
 #include <linux/sysrq.h>
 #include <linux/backing-dev.h>
 #include <linux/mpage.h>
+#include <linux/notifier.h>
+#include <linux/smp.h>
 
 /*
  * The maximum number of pages to writeout in a single bdflush/kupdate
@@ -34,10 +36,9 @@
 
 /*
  * After a CPU has dirtied this many pages, balance_dirty_pages_ratelimited
- * will look to see if it needs to force writeback or throttling.  Probably
- * should be scaled by memory size.
+ * will look to see if it needs to force writeback or throttling.
  */
-#define RATELIMIT_PAGES		((512 * 1024) / PAGE_SIZE)
+static int ratelimit_pages = 32;
 
 /*
  * When balance_dirty_pages decides that the caller needs to perform some
@@ -45,8 +46,10 @@
  * It should be somewhat larger than RATELIMIT_PAGES to ensure that reasonably
  * large amounts of I/O are submitted.
  */
-#define SYNC_WRITEBACK_PAGES	((RATELIMIT_PAGES * 3) / 2)
-
+static inline int sync_writeback_pages(void)
+{
+	return ratelimit_pages + ratelimit_pages / 2;
+}
 
 /* The following parameters are exported via /proc/sys/vm */
 
@@ -119,12 +122,12 @@ void balance_dirty_pages(struct address_
 	bdi = mapping->backing_dev_info;
 
 	if (dirty_and_writeback > sync_thresh) {
-		int nr_to_write = SYNC_WRITEBACK_PAGES;
+		int nr_to_write = sync_writeback_pages();
 
 		writeback_backing_dev(bdi, &nr_to_write, WB_SYNC_LAST, NULL);
 		get_page_state(&ps);
 	} else if (dirty_and_writeback > async_thresh) {
-		int nr_to_write = SYNC_WRITEBACK_PAGES;
+		int nr_to_write = sync_writeback_pages();
 
 		writeback_backing_dev(bdi, &nr_to_write, WB_SYNC_NONE, NULL);
 		get_page_state(&ps);
@@ -153,7 +156,7 @@ void balance_dirty_pages_ratelimited(str
 	int cpu;
 
 	cpu = get_cpu();
-	if (ratelimits[cpu].count++ >= RATELIMIT_PAGES) {
+	if (ratelimits[cpu].count++ >= ratelimit_pages) {
 		ratelimits[cpu].count = 0;
 		put_cpu();
 		balance_dirty_pages(mapping);
@@ -247,16 +250,56 @@ static void wb_timer_fn(unsigned long un
 
 }
 
-static int __init wb_timer_init(void)
+/*
+ * If ratelimit_pages is too high then we can get into dirty-data overload
+ * if a large number of processes all perform writes at the same time.
+ * If it is too low then SMP machines will call the (expensive) get_page_state
+ * too often.
+ *
+ * Here we set ratelimit_pages to a level which ensures that when all CPUs are
+ * dirtying in parallel, we cannot go more than 3% (1/32) over the dirty memory
+ * thresholds before writeback cuts in.
+ *
+ * But the limit should not be set too high.  Because it also controls the
+ * amount of memory which the balance_dirty_pages() caller has to write back.
+ * If this is too large then the caller will block on the IO queue all the
+ * time.  So limit it to four megabytes - the balance_dirty_pages() caller
+ * will write six megabyte chunks, max.
+ */
+
+static void set_ratelimit(void)
+{
+	ratelimit_pages = nr_free_pagecache_pages() / (num_online_cpus() * 32);
+	if (ratelimit_pages < 16)
+		ratelimit_pages = 16;
+	if (ratelimit_pages * PAGE_CACHE_SIZE > 4096 * 1024)
+		ratelimit_pages = (4096 * 1024) / PAGE_CACHE_SIZE;
+}
+
+static int
+ratelimit_handler(struct notifier_block *self, unsigned long u, void *v)
+{
+	set_ratelimit();
+	return 0;
+}
+
+static struct notifier_block ratelimit_nb = {
+	.notifier_call	= ratelimit_handler,
+	.next		= NULL,
+};
+
+static int __init page_writeback_init(void)
 {
 	init_timer(&wb_timer);
 	wb_timer.expires = jiffies + (dirty_writeback_centisecs * HZ) / 100;
 	wb_timer.data = 0;
 	wb_timer.function = wb_timer_fn;
 	add_timer(&wb_timer);
+	set_ratelimit();
+	register_cpu_notifier(&ratelimit_nb);
 	return 0;
 }
-module_init(wb_timer_init);
+module_init(page_writeback_init);
 
 /*
  * A library function, which implements the vm_writeback a_op.  It's fairly
@@ -481,3 +524,5 @@ int __set_page_dirty_nobuffers(struct pa
 	return ret;
 }
 EXPORT_SYMBOL(__set_page_dirty_nobuffers);
+
+

.
