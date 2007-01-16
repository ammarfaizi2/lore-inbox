Return-Path: <linux-kernel-owner+w=401wt.eu-S932393AbXAPFsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbXAPFsc (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 00:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbXAPFs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 00:48:28 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:40796 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932393AbXAPFsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 00:48:15 -0500
Date: Mon, 15 Jan 2007 21:47:59 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Paul Menage <menage@google.com>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Paul Jackson <pj@sgi.com>,
       Dave Chinner <dgc@sgi.com>, Christoph Lameter <clameter@sgi.com>
Message-Id: <20070116054759.15358.98106.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 3/8] Add a nodemask to pdflush functions
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pdflush: Allow the passing of a nodemask parameter

If we want to support nodeset specific writeout then we need a way
to communicate the set of nodes that an operation should affect.

So add a nodemask_t parameter to the pdflush functions and also
store the nodemask in the pdflush control structure.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.20-rc5/include/linux/writeback.h
===================================================================
--- linux-2.6.20-rc5.orig/include/linux/writeback.h	2007-01-15 21:34:38.564104333 -0600
+++ linux-2.6.20-rc5/include/linux/writeback.h	2007-01-15 21:34:43.135798088 -0600
@@ -81,7 +81,7 @@ static inline void wait_on_inode(struct 
 /*
  * mm/page-writeback.c
  */
-int wakeup_pdflush(long nr_pages);
+int wakeup_pdflush(long nr_pages, nodemask_t *nodes);
 void laptop_io_completion(void);
 void laptop_sync_completion(void);
 void throttle_vm_writeout(void);
@@ -109,7 +109,8 @@ balance_dirty_pages_ratelimited(struct a
 	balance_dirty_pages_ratelimited_nr(mapping, 1);
 }
 
-int pdflush_operation(void (*fn)(unsigned long), unsigned long arg0);
+int pdflush_operation(void (*fn)(unsigned long, nodemask_t *nodes),
+		unsigned long arg0, nodemask_t *nodes);
 extern int generic_writepages(struct address_space *mapping,
 			      struct writeback_control *wbc);
 int do_writepages(struct address_space *mapping, struct writeback_control *wbc);
Index: linux-2.6.20-rc5/mm/page-writeback.c
===================================================================
--- linux-2.6.20-rc5.orig/mm/page-writeback.c	2007-01-15 21:34:38.573870823 -0600
+++ linux-2.6.20-rc5/mm/page-writeback.c	2007-01-15 21:34:43.150447823 -0600
@@ -101,7 +101,7 @@ EXPORT_SYMBOL(laptop_mode);
 /* End of sysctl-exported parameters */
 
 
-static void background_writeout(unsigned long _min_pages);
+static void background_writeout(unsigned long _min_pages, nodemask_t *nodes);
 
 /*
  * Work out the current dirty-memory clamping and background writeout
@@ -244,7 +244,7 @@ static void balance_dirty_pages(struct a
 	 */
 	if ((laptop_mode && pages_written) ||
 	     (!laptop_mode && (nr_reclaimable > background_thresh)))
-		pdflush_operation(background_writeout, 0);
+		pdflush_operation(background_writeout, 0, NULL);
 }
 
 void set_page_dirty_balance(struct page *page)
@@ -325,7 +325,7 @@ void throttle_vm_writeout(void)
  * writeback at least _min_pages, and keep writing until the amount of dirty
  * memory is less than the background threshold, or until we're all clean.
  */
-static void background_writeout(unsigned long _min_pages)
+static void background_writeout(unsigned long _min_pages, nodemask_t *unused)
 {
 	long min_pages = _min_pages;
 	struct writeback_control wbc = {
@@ -365,12 +365,12 @@ static void background_writeout(unsigned
  * the whole world.  Returns 0 if a pdflush thread was dispatched.  Returns
  * -1 if all pdflush threads were busy.
  */
-int wakeup_pdflush(long nr_pages)
+int wakeup_pdflush(long nr_pages, nodemask_t *nodes)
 {
 	if (nr_pages == 0)
 		nr_pages = global_page_state(NR_FILE_DIRTY) +
 				global_page_state(NR_UNSTABLE_NFS);
-	return pdflush_operation(background_writeout, nr_pages);
+	return pdflush_operation(background_writeout, nr_pages, nodes);
 }
 
 static void wb_timer_fn(unsigned long unused);
@@ -394,7 +394,7 @@ static DEFINE_TIMER(laptop_mode_wb_timer
  * older_than_this takes precedence over nr_to_write.  So we'll only write back
  * all dirty pages if they are all attached to "old" mappings.
  */
-static void wb_kupdate(unsigned long arg)
+static void wb_kupdate(unsigned long arg, nodemask_t *unused)
 {
 	unsigned long oldest_jif;
 	unsigned long start_jif;
@@ -454,18 +454,18 @@ int dirty_writeback_centisecs_handler(ct
 
 static void wb_timer_fn(unsigned long unused)
 {
-	if (pdflush_operation(wb_kupdate, 0) < 0)
+	if (pdflush_operation(wb_kupdate, 0, NULL) < 0)
 		mod_timer(&wb_timer, jiffies + HZ); /* delay 1 second */
 }
 
-static void laptop_flush(unsigned long unused)
+static void laptop_flush(unsigned long unused, nodemask_t *unused2)
 {
 	sys_sync();
 }
 
 static void laptop_timer_fn(unsigned long unused)
 {
-	pdflush_operation(laptop_flush, 0);
+	pdflush_operation(laptop_flush, 0, NULL);
 }
 
 /*
Index: linux-2.6.20-rc5/mm/pdflush.c
===================================================================
--- linux-2.6.20-rc5.orig/mm/pdflush.c	2007-01-15 21:34:38.582660664 -0600
+++ linux-2.6.20-rc5/mm/pdflush.c	2007-01-15 21:34:43.161190961 -0600
@@ -83,10 +83,12 @@ static unsigned long last_empty_jifs;
  */
 struct pdflush_work {
 	struct task_struct *who;	/* The thread */
-	void (*fn)(unsigned long);	/* A callback function */
+	void (*fn)(unsigned long, nodemask_t *); /* A callback function */
 	unsigned long arg0;		/* An argument to the callback */
 	struct list_head list;		/* On pdflush_list, when idle */
 	unsigned long when_i_went_to_sleep;
+	int have_nodes;			/* Nodes were specified */
+	nodemask_t nodes;		/* Nodes of interest */
 };
 
 static int __pdflush(struct pdflush_work *my_work)
@@ -123,7 +125,8 @@ static int __pdflush(struct pdflush_work
 		}
 		spin_unlock_irq(&pdflush_lock);
 
-		(*my_work->fn)(my_work->arg0);
+		(*my_work->fn)(my_work->arg0,
+			my_work->have_nodes ? &my_work->nodes : NULL);
 
 		/*
 		 * Thread creation: For how long have there been zero
@@ -197,7 +200,8 @@ static int pdflush(void *dummy)
  * Returns zero if it indeed managed to find a worker thread, and passed your
  * payload to it.
  */
-int pdflush_operation(void (*fn)(unsigned long), unsigned long arg0)
+int pdflush_operation(void (*fn)(unsigned long, nodemask_t *),
+			unsigned long arg0, nodemask_t *nodes)
 {
 	unsigned long flags;
 	int ret = 0;
@@ -217,6 +221,11 @@ int pdflush_operation(void (*fn)(unsigne
 			last_empty_jifs = jiffies;
 		pdf->fn = fn;
 		pdf->arg0 = arg0;
+		if (nodes) {
+			pdf->nodes = *nodes;
+			pdf->have_nodes = 1;
+		} else
+			pdf->have_nodes = 0;
 		wake_up_process(pdf->who);
 		spin_unlock_irqrestore(&pdflush_lock, flags);
 	}
Index: linux-2.6.20-rc5/mm/vmscan.c
===================================================================
--- linux-2.6.20-rc5.orig/mm/vmscan.c	2007-01-15 21:34:38.592427153 -0600
+++ linux-2.6.20-rc5/mm/vmscan.c	2007-01-15 21:34:43.173887398 -0600
@@ -1065,7 +1065,7 @@ unsigned long try_to_free_pages(struct z
 		 */
 		if (total_scanned > sc.swap_cluster_max +
 					sc.swap_cluster_max / 2) {
-			wakeup_pdflush(laptop_mode ? 0 : total_scanned);
+			wakeup_pdflush(laptop_mode ? 0 : total_scanned, NULL);
 			sc.may_writepage = 1;
 		}
 
Index: linux-2.6.20-rc5/fs/buffer.c
===================================================================
--- linux-2.6.20-rc5.orig/fs/buffer.c	2007-01-15 21:34:38.601216994 -0600
+++ linux-2.6.20-rc5/fs/buffer.c	2007-01-15 21:34:43.195373675 -0600
@@ -357,7 +357,7 @@ static void free_more_memory(void)
 	struct zone **zones;
 	pg_data_t *pgdat;
 
-	wakeup_pdflush(1024);
+	wakeup_pdflush(1024, NULL);
 	yield();
 
 	for_each_online_pgdat(pgdat) {
Index: linux-2.6.20-rc5/fs/super.c
===================================================================
--- linux-2.6.20-rc5.orig/fs/super.c	2007-01-15 21:34:38.610983483 -0600
+++ linux-2.6.20-rc5/fs/super.c	2007-01-15 21:34:43.208070111 -0600
@@ -618,7 +618,7 @@ int do_remount_sb(struct super_block *sb
 	return 0;
 }
 
-static void do_emergency_remount(unsigned long foo)
+static void do_emergency_remount(unsigned long foo, nodemask_t *bar)
 {
 	struct super_block *sb;
 
@@ -646,7 +646,7 @@ static void do_emergency_remount(unsigne
 
 void emergency_remount(void)
 {
-	pdflush_operation(do_emergency_remount, 0);
+	pdflush_operation(do_emergency_remount, 0, NULL);
 }
 
 /*
Index: linux-2.6.20-rc5/fs/sync.c
===================================================================
--- linux-2.6.20-rc5.orig/fs/sync.c	2007-01-15 21:34:38.622703271 -0600
+++ linux-2.6.20-rc5/fs/sync.c	2007-01-15 21:34:43.217836601 -0600
@@ -21,9 +21,9 @@
  * sync everything.  Start out by waking pdflush, because that writes back
  * all queues in parallel.
  */
-static void do_sync(unsigned long wait)
+static void do_sync(unsigned long wait, nodemask_t *unused)
 {
-	wakeup_pdflush(0);
+	wakeup_pdflush(0, NULL);
 	sync_inodes(0);		/* All mappings, inodes and their blockdevs */
 	DQUOT_SYNC(NULL);
 	sync_supers();		/* Write the superblocks */
@@ -38,13 +38,13 @@ static void do_sync(unsigned long wait)
 
 asmlinkage long sys_sync(void)
 {
-	do_sync(1);
+	do_sync(1, NULL);
 	return 0;
 }
 
 void emergency_sync(void)
 {
-	pdflush_operation(do_sync, 0);
+	pdflush_operation(do_sync, 0, NULL);
 }
 
 /*
