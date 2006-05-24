Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932692AbWEXL2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932692AbWEXL2i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 07:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932685AbWEXL2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 07:28:21 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:51328 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932694AbWEXLTG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 07:19:06 -0400
Message-ID: <348469540.16036@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060524111901.581603095@localhost.localdomain>
References: <20060524111246.420010595@localhost.localdomain>
Date: Wed, 24 May 2006 19:12:55 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>,
       Ingo Oeser <ioe-lkml@rameria.de>
Subject: [PATCH 09/33] readahead: events accounting
Content-Disposition: inline; filename=readahead-events-accounting.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A debugfs file named `readahead/events' is created according to advises from
J?rn Engel, Andrew Morton and Ingo Oeser.

It reveals various read-ahead activities/events, and is vital to the testing.

---------------------------
If you are experiencing performance problems, or want to help improve the
read-ahead logic, please send me the debug data. Thanks.

- Preparations

## First compile kernel with CONFIG_DEBUG_READAHEAD
mkdir /debug
mount -t debug none /debug

- For each session with distinct access pattern

echo > /debug/readahead/events # reset the counters
# echo > /var/log/kern.log # you may want to backup it first
# echo 3 > /debug/readahead/debug_level # show verbose printk traces
## do one benchmark/task
# echo 1 > /debug/readahead/debug_level # revert to normal value
cp /debug/readahead/events readahead-events-`date +'%F_%R'`
# bzip2 -c /var/log/kern.log > kern.log-`date +'%F_%R'`.bz2

The commented out commands can uncover more detailed file accesses,
which are useful sometimes. Note that the log file can grow huge!

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/readahead.c |  293 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 292 insertions(+), 1 deletion(-)

--- linux-2.6.17-rc4-mm3.orig/mm/readahead.c
+++ linux-2.6.17-rc4-mm3/mm/readahead.c
@@ -19,12 +19,76 @@
 #include <linux/writeback.h>
 #include <linux/nfsd/const.h>
 
+/*
+ * Detailed classification of read-ahead behaviors.
+ */
+#define RA_CLASS_SHIFT 4
+#define RA_CLASS_MASK  ((1 << RA_CLASS_SHIFT) - 1)
+enum ra_class {
+	RA_CLASS_ALL,
+	RA_CLASS_INITIAL,
+	RA_CLASS_STATE,
+	RA_CLASS_CONTEXT,
+	RA_CLASS_CONTEXT_AGGRESSIVE,
+	RA_CLASS_BACKWARD,
+	RA_CLASS_THRASHING,
+	RA_CLASS_SEEK,
+	RA_CLASS_NONE,
+	RA_CLASS_COUNT
+};
+
+/* Read-ahead events to be accounted. */
+enum ra_event {
+	RA_EVENT_CACHE_MISS,		/* read cache misses */
+	RA_EVENT_RANDOM_READ,		/* random reads */
+	RA_EVENT_IO_CONGESTION,		/* i/o congestion */
+	RA_EVENT_IO_CACHE_HIT,		/* canceled i/o due to cache hit */
+	RA_EVENT_IO_BLOCK,		/* wait for i/o completion */
+
+	RA_EVENT_READAHEAD,		/* read-ahead issued */
+	RA_EVENT_READAHEAD_HIT,		/* read-ahead page hit */
+	RA_EVENT_LOOKAHEAD,		/* look-ahead issued */
+	RA_EVENT_LOOKAHEAD_HIT,		/* look-ahead mark hit */
+	RA_EVENT_LOOKAHEAD_NOACTION,	/* look-ahead mark ignored */
+	RA_EVENT_READAHEAD_MMAP,	/* read-ahead for mmap access */
+	RA_EVENT_READAHEAD_EOF,		/* read-ahead reaches EOF */
+	RA_EVENT_READAHEAD_SHRINK,	/* ra_size falls under previous la_size */
+	RA_EVENT_READAHEAD_THRASHING,	/* read-ahead thrashing happened */
+	RA_EVENT_READAHEAD_MUTILATE,	/* read-ahead mutilated by imbalanced aging */
+	RA_EVENT_READAHEAD_RESCUE,	/* read-ahead rescued */
+
+	RA_EVENT_READAHEAD_CUBE,
+	RA_EVENT_COUNT
+};
+
+#ifdef CONFIG_DEBUG_READAHEAD
+u32 initial_ra_hit;
+u32 initial_ra_miss;
+u32 debug_level = 1;
+u32 disable_stateful_method = 0;
+static const char * const ra_class_name[];
+static void ra_account(struct file_ra_state *ra, enum ra_event e, int pages);
+#  define debug_inc(var)		do { var++; } while (0)
+#  define debug_option(o)		(o)
+#else
+#  define ra_account(ra, e, pages)	do { } while (0)
+#  define debug_inc(var)		do { } while (0)
+#  define debug_option(o)		(0)
+#  define debug_level 			(0)
+#endif /* CONFIG_DEBUG_READAHEAD */
+
+#define dprintk(args...) \
+	do { if (debug_level >= 2) printk(KERN_DEBUG args); } while(0)
+#define ddprintk(args...) \
+	do { if (debug_level >= 3) printk(KERN_DEBUG args); } while(0)
+
 #define PAGES_BYTE(size) (((size) + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT)
 #define PAGES_KB(size)	 PAGES_BYTE((size)*1024)
 
 #define next_page(pg) (list_entry((pg)->lru.prev, struct page, lru))
 #define prev_page(pg) (list_entry((pg)->lru.next, struct page, lru))
 
+
 void default_unplug_io_fn(struct backing_dev_info *bdi, struct page *page)
 {
 }
@@ -365,6 +429,9 @@ int force_page_cache_readahead(struct ad
 		offset += this_chunk;
 		nr_to_read -= this_chunk;
 	}
+
+	ra_account(NULL, RA_EVENT_READAHEAD, ret);
+
 	return ret;
 }
 
@@ -400,10 +467,16 @@ static inline int check_ra_success(struc
 int do_page_cache_readahead(struct address_space *mapping, struct file *filp,
 			pgoff_t offset, unsigned long nr_to_read)
 {
+	unsigned long ret;
+
 	if (bdi_read_congested(mapping->backing_dev_info))
 		return -1;
 
-	return __do_page_cache_readahead(mapping, filp, offset, nr_to_read, 0);
+	ret = __do_page_cache_readahead(mapping, filp, offset, nr_to_read, 0);
+
+	ra_account(NULL, RA_EVENT_READAHEAD, ret);
+
+	return ret;
 }
 
 /*
@@ -425,6 +498,10 @@ blockable_page_cache_readahead(struct ad
 
 	actual = __do_page_cache_readahead(mapping, filp, offset, nr_to_read, 0);
 
+	ra_account(NULL, RA_EVENT_READAHEAD, actual);
+	dprintk("blockable-readahead(ino=%lu, ra=%lu+%lu) = %d\n",
+			mapping->host->i_ino, offset, nr_to_read, actual);
+
 	return check_ra_success(ra, nr_to_read, actual);
 }
 
@@ -604,3 +681,217 @@ unsigned long max_sane_readahead(unsigne
 	__get_zone_counts(&active, &inactive, &free, NODE_DATA(numa_node_id()));
 	return min(nr, (inactive + free) / 2);
 }
+
+/*
+ * Read-ahead events accounting.
+ */
+#ifdef CONFIG_DEBUG_READAHEAD
+
+#include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+
+static const char * const ra_class_name[] = {
+	"total",
+	"initial",
+	"state",
+	"context",
+	"contexta",
+	"backward",
+	"onthrash",
+	"onseek",
+	"none"
+};
+
+static const char * const ra_event_name[] = {
+	"cache_miss",
+	"random_read",
+	"io_congestion",
+	"io_cache_hit",
+	"io_block",
+	"readahead",
+	"readahead_hit",
+	"lookahead",
+	"lookahead_hit",
+	"lookahead_ignore",
+	"readahead_mmap",
+	"readahead_eof",
+	"readahead_shrink",
+	"readahead_thrash",
+	"readahead_mutilt",
+	"readahead_rescue"
+};
+
+static unsigned long ra_events[RA_CLASS_COUNT][RA_EVENT_COUNT][2];
+
+static void ra_account(struct file_ra_state *ra, enum ra_event e, int pages)
+{
+	enum ra_class c;
+
+	if (!debug_level)
+		return;
+
+	if (e == RA_EVENT_READAHEAD_HIT && pages < 0) {
+		c = (ra->flags >> RA_CLASS_SHIFT) & RA_CLASS_MASK;
+		pages = -pages;
+	} else if (ra)
+		c = ra->flags & RA_CLASS_MASK;
+	else
+		c = RA_CLASS_NONE;
+
+	if (!c)
+		c = RA_CLASS_NONE;
+
+	ra_events[c][e][0] += 1;
+	ra_events[c][e][1] += pages;
+
+	if (e == RA_EVENT_READAHEAD)
+		ra_events[c][RA_EVENT_READAHEAD_CUBE][1] += pages * pages;
+}
+
+static int ra_events_show(struct seq_file *s, void *_)
+{
+	int i;
+	int c;
+	int e;
+	static const char event_fmt[] = "%-16s";
+	static const char class_fmt[] = "%10s";
+	static const char item_fmt[] = "%10lu";
+	static const char percent_format[] = "%9lu%%";
+	static const char * const table_name[] = {
+		"[table requests]",
+		"[table pages]",
+		"[table summary]"};
+
+	for (i = 0; i <= 1; i++) {
+		for (e = 0; e < RA_EVENT_COUNT; e++) {
+			ra_events[RA_CLASS_ALL][e][i] = 0;
+			for (c = RA_CLASS_INITIAL; c < RA_CLASS_NONE; c++)
+				ra_events[RA_CLASS_ALL][e][i] += ra_events[c][e][i];
+		}
+
+		seq_printf(s, event_fmt, table_name[i]);
+		for (c = 0; c < RA_CLASS_COUNT; c++)
+			seq_printf(s, class_fmt, ra_class_name[c]);
+		seq_puts(s, "\n");
+
+		for (e = 0; e < RA_EVENT_COUNT; e++) {
+			if (e == RA_EVENT_READAHEAD_CUBE)
+				continue;
+			if (e == RA_EVENT_READAHEAD_HIT && i == 0)
+				continue;
+			if (e == RA_EVENT_IO_BLOCK && i == 1)
+				continue;
+
+			seq_printf(s, event_fmt, ra_event_name[e]);
+			for (c = 0; c < RA_CLASS_COUNT; c++)
+				seq_printf(s, item_fmt, ra_events[c][e][i]);
+			seq_puts(s, "\n");
+		}
+		seq_puts(s, "\n");
+	}
+
+	seq_printf(s, event_fmt, table_name[2]);
+	for (c = 0; c < RA_CLASS_COUNT; c++)
+		seq_printf(s, class_fmt, ra_class_name[c]);
+	seq_puts(s, "\n");
+
+	seq_printf(s, event_fmt, "random_rate");
+	for (c = 0; c < RA_CLASS_COUNT; c++)
+		seq_printf(s, percent_format,
+			(ra_events[c][RA_EVENT_RANDOM_READ][0] * 100) /
+			((ra_events[c][RA_EVENT_RANDOM_READ][0] +
+			  ra_events[c][RA_EVENT_READAHEAD][0]) | 1));
+	seq_puts(s, "\n");
+
+	seq_printf(s, event_fmt, "ra_hit_rate");
+	for (c = 0; c < RA_CLASS_COUNT; c++)
+		seq_printf(s, percent_format,
+			(ra_events[c][RA_EVENT_READAHEAD_HIT][1] * 100) /
+			(ra_events[c][RA_EVENT_READAHEAD][1] | 1));
+	seq_puts(s, "\n");
+
+	seq_printf(s, event_fmt, "la_hit_rate");
+	for (c = 0; c < RA_CLASS_COUNT; c++)
+		seq_printf(s, percent_format,
+			(ra_events[c][RA_EVENT_LOOKAHEAD_HIT][0] * 100) /
+			(ra_events[c][RA_EVENT_LOOKAHEAD][0] | 1));
+	seq_puts(s, "\n");
+
+	seq_printf(s, event_fmt, "var_ra_size");
+	for (c = 0; c < RA_CLASS_COUNT; c++)
+		seq_printf(s, item_fmt,
+			(ra_events[c][RA_EVENT_READAHEAD_CUBE][1] -
+			 ra_events[c][RA_EVENT_READAHEAD][1] *
+			(ra_events[c][RA_EVENT_READAHEAD][1] /
+			(ra_events[c][RA_EVENT_READAHEAD][0] | 1))) /
+			(ra_events[c][RA_EVENT_READAHEAD][0] | 1));
+	seq_puts(s, "\n");
+
+	seq_printf(s, event_fmt, "avg_ra_size");
+	for (c = 0; c < RA_CLASS_COUNT; c++)
+		seq_printf(s, item_fmt,
+			(ra_events[c][RA_EVENT_READAHEAD][1] +
+			 ra_events[c][RA_EVENT_READAHEAD][0] / 2) /
+			(ra_events[c][RA_EVENT_READAHEAD][0] | 1));
+	seq_puts(s, "\n");
+
+	seq_printf(s, event_fmt, "avg_la_size");
+	for (c = 0; c < RA_CLASS_COUNT; c++)
+		seq_printf(s, item_fmt,
+			(ra_events[c][RA_EVENT_LOOKAHEAD][1] +
+			 ra_events[c][RA_EVENT_LOOKAHEAD][0] / 2) /
+			(ra_events[c][RA_EVENT_LOOKAHEAD][0] | 1));
+	seq_puts(s, "\n");
+
+	return 0;
+}
+
+static int ra_events_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, ra_events_show, NULL);
+}
+
+static ssize_t ra_events_write(struct file *file, const char __user *buf,
+						size_t size, loff_t *offset)
+{
+	memset(ra_events, 0, sizeof(ra_events));
+	return 1;
+}
+
+struct file_operations ra_events_fops = {
+	.owner		= THIS_MODULE,
+	.open		= ra_events_open,
+	.write		= ra_events_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+#define READAHEAD_DEBUGFS_ENTRY_U32(var) \
+	debugfs_create_u32(__stringify(var), 0644, root, &var)
+
+#define READAHEAD_DEBUGFS_ENTRY_BOOL(var) \
+	debugfs_create_bool(__stringify(var), 0644, root, &var)
+
+static int __init readahead_init(void)
+{
+	struct dentry *root;
+
+	root = debugfs_create_dir("readahead", NULL);
+
+	debugfs_create_file("events", 0644, root, NULL, &ra_events_fops);
+
+	READAHEAD_DEBUGFS_ENTRY_U32(initial_ra_hit);
+	READAHEAD_DEBUGFS_ENTRY_U32(initial_ra_miss);
+
+	READAHEAD_DEBUGFS_ENTRY_U32(debug_level);
+	READAHEAD_DEBUGFS_ENTRY_BOOL(disable_stateful_method);
+
+	return 0;
+}
+
+module_init(readahead_init)
+
+#endif /* CONFIG_DEBUG_READAHEAD */

--
