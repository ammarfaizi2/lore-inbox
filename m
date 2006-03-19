Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbWCSClm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWCSClm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 21:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWCSCef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 21:34:35 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:40642 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751273AbWCSCec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 21:34:32 -0500
Message-Id: <20060319023452.955648000@localhost.localdomain>
References: <20060319023413.305977000@localhost.localdomain>
Date: Sun, 19 Mar 2006 10:34:22 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, J?rn Engel <joern@wohnheim.fh-wedel.de>,
       Ingo Oeser <ioe-lkml@rameria.de>
Subject: [PATCH 09/23] readahead: events accounting
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
# echo 2 > /debug/readahead/debug_level # show verbose printk traces
## do one benchmark/task
# echo 0 > /debug/readahead/debug_level # revert to normal value
cp /debug/readahead/events readahead-events-`date +'%F_%R'`
# bzip2 -c /var/log/kern.log > kern.log-`date +'%F_%R'`.bz2

The commented out commands can uncover more detailed file accesses,
which are useful sometimes. Note that the log file can grow huge!

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/readahead.c |  270 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 269 insertions(+), 1 deletion(-)

--- linux-2.6.16-rc6-mm2.orig/mm/readahead.c
+++ linux-2.6.16-rc6-mm2/mm/readahead.c
@@ -26,6 +26,261 @@
 #define next_page(pg) (list_entry((pg)->lru.prev, struct page, lru))
 #define prev_page(pg) (list_entry((pg)->lru.next, struct page, lru))
 
+#ifdef CONFIG_ADAPTIVE_READAHEAD
+/*
+ * Detailed classification of read-ahead behaviors.
+ */
+#define RA_CLASS_SHIFT 4
+#define RA_CLASS_MASK  ((1 << RA_CLASS_SHIFT) - 1)
+enum ra_class {
+	RA_CLASS_ALL,
+	RA_CLASS_NEWFILE,
+	RA_CLASS_STATE,
+	RA_CLASS_CONTEXT,
+	RA_CLASS_CONTEXT_AGGRESSIVE,
+	RA_CLASS_BACKWARD,
+	RA_CLASS_THRASHING,
+	RA_CLASS_SEEK,
+	RA_CLASS_END,
+};
+#endif /* CONFIG_ADAPTIVE_READAHEAD */
+
+/*
+ * Read-ahead events accounting.
+ */
+#ifdef CONFIG_DEBUG_READAHEAD
+#include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+
+/* Read-ahead events to be accounted. */
+enum ra_event {
+	RA_EVENT_CACHE_MISS,		/* read cache misses */
+	RA_EVENT_READRANDOM,		/* random reads */
+	RA_EVENT_IO_CONGESTION,		/* io congestion */
+	RA_EVENT_IO_CACHE_HIT,		/* canceled io due to cache hit */
+	RA_EVENT_IO_BLOCK,		/* read on locked page */
+
+	RA_EVENT_READAHEAD,		/* read-ahead issued */
+	RA_EVENT_READAHEAD_HIT,		/* read-ahead page hit */
+	RA_EVENT_LOOKAHEAD,		/* look-ahead issued */
+	RA_EVENT_LOOKAHEAD_HIT,		/* look-ahead mark hit */
+	RA_EVENT_LOOKAHEAD_NOACTION,	/* look-ahead mark ignored */
+	RA_EVENT_READAHEAD_MMAP,	/* read-ahead for memory mapped file */
+	RA_EVENT_READAHEAD_EOF,		/* read-ahead reaches EOF */
+	RA_EVENT_READAHEAD_SHRINK,	/* ra_size under previous la_size */
+	RA_EVENT_READAHEAD_THRASHING,	/* read-ahead thrashing happened */
+	RA_EVENT_READAHEAD_MUTILATE,	/* read-ahead request mutilated */
+	RA_EVENT_READAHEAD_RESCUE,	/* read-ahead rescued */
+
+	RA_EVENT_END
+};
+
+static const char * const ra_event_name[] = {
+	"cache_miss",
+	"read_random",
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
+	"readahead_rescue",
+};
+
+static const char * const ra_class_name[] = {
+	"total",
+	"newfile",
+	"state",
+	"context",
+	"contexta",
+	"backward",
+	"onthrash",
+	"onraseek",
+	"none",
+};
+
+static unsigned long ra_events[RA_CLASS_END+1][RA_EVENT_END+1][2];
+
+static inline void ra_account(struct file_ra_state *ra,
+					enum ra_event e, int pages)
+{
+	enum ra_class c;
+
+	if (e == RA_EVENT_READAHEAD_HIT && pages < 0) {
+		c = (ra->flags >> RA_CLASS_SHIFT) & RA_CLASS_MASK;
+		pages = -pages;
+	} else if (ra)
+		c = ra->flags & RA_CLASS_MASK;
+	else
+		c = RA_CLASS_END;
+
+	if (!c)
+		c = RA_CLASS_END;
+
+	ra_events[c][e][0] += 1;
+	ra_events[c][e][1] += pages;
+
+	if (e == RA_EVENT_READAHEAD)
+		ra_events[c][RA_EVENT_END][1] += pages * pages;
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
+		for (e = 0; e <= RA_EVENT_END; e++) {
+			ra_events[0][e][i] = 0;
+			for (c = 1; c < RA_CLASS_END; c++)
+				ra_events[0][e][i] += ra_events[c][e][i];
+		}
+
+		seq_printf(s, event_fmt, table_name[i]);
+		for (c = 0; c <= RA_CLASS_END; c++)
+			seq_printf(s, class_fmt, ra_class_name[c]);
+		seq_puts(s, "\n");
+
+		for (e = 0; e < RA_EVENT_END; e++) {
+			if (e == RA_EVENT_READAHEAD_HIT && i == 0)
+				continue;
+			if (e == RA_EVENT_IO_BLOCK && i == 1)
+				continue;
+
+			seq_printf(s, event_fmt, ra_event_name[e]);
+			for (c = 0; c <= RA_CLASS_END; c++)
+				seq_printf(s, item_fmt, ra_events[c][e][i]);
+			seq_puts(s, "\n");
+		}
+		seq_puts(s, "\n");
+	}
+
+	seq_printf(s, event_fmt, table_name[2]);
+	for (c = 0; c <= RA_CLASS_END; c++)
+		seq_printf(s, class_fmt, ra_class_name[c]);
+	seq_puts(s, "\n");
+
+	seq_printf(s, event_fmt, "random_rate");
+	for (c = 0; c <= RA_CLASS_END; c++)
+		seq_printf(s, percent_format,
+			(ra_events[c][RA_EVENT_READRANDOM][0] * 100) /
+			((ra_events[c][RA_EVENT_READRANDOM][0] +
+			  ra_events[c][RA_EVENT_READAHEAD][0]) | 1));
+	seq_puts(s, "\n");
+
+	seq_printf(s, event_fmt, "ra_hit_rate");
+	for (c = 0; c <= RA_CLASS_END; c++)
+		seq_printf(s, percent_format,
+			(ra_events[c][RA_EVENT_READAHEAD_HIT][1] * 100) /
+			(ra_events[c][RA_EVENT_READAHEAD][1] | 1));
+	seq_puts(s, "\n");
+
+	seq_printf(s, event_fmt, "la_hit_rate");
+	for (c = 0; c <= RA_CLASS_END; c++)
+		seq_printf(s, percent_format,
+			(ra_events[c][RA_EVENT_LOOKAHEAD_HIT][0] * 100) /
+			(ra_events[c][RA_EVENT_LOOKAHEAD][0] | 1));
+	seq_puts(s, "\n");
+
+	seq_printf(s, event_fmt, "var_ra_size");
+	for (c = 0; c <= RA_CLASS_END; c++)
+		seq_printf(s, item_fmt,
+			(ra_events[c][RA_EVENT_END][1] -
+			 ra_events[c][RA_EVENT_READAHEAD][1] *
+			(ra_events[c][RA_EVENT_READAHEAD][1] /
+			(ra_events[c][RA_EVENT_READAHEAD][0] | 1))) /
+			(ra_events[c][RA_EVENT_READAHEAD][0] | 1));
+	seq_puts(s, "\n");
+
+	seq_printf(s, event_fmt, "avg_ra_size");
+	for (c = 0; c <= RA_CLASS_END; c++)
+		seq_printf(s, item_fmt,
+			(ra_events[c][RA_EVENT_READAHEAD][1] +
+			 ra_events[c][RA_EVENT_READAHEAD][0] / 2) /
+			(ra_events[c][RA_EVENT_READAHEAD][0] | 1));
+	seq_puts(s, "\n");
+
+	seq_printf(s, event_fmt, "avg_la_size");
+	for (c = 0; c <= RA_CLASS_END; c++)
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
+u32 readahead_debug_level = 0;
+u32 disable_stateful_method = 0;
+
+static int __init readahead_init(void)
+{
+	struct dentry *root;
+
+	root = debugfs_create_dir("readahead", NULL);
+
+	debugfs_create_file("events", 0644, root, NULL, &ra_events_fops);
+
+	debugfs_create_u32("debug_level", 0644, root, &readahead_debug_level);
+	debugfs_create_bool("disable_stateful_method", 0644, root,
+			    &disable_stateful_method);
+
+	return 0;
+}
+
+module_init(readahead_init)
+#else
+#define ra_account(ra, e, pages)	do { } while (0)
+#define readahead_debug_level 		(0)
+#define disable_stateful_method		(0)
+#endif /* CONFIG_DEBUG_READAHEAD */
+
+#define dprintk(args...) \
+	do { if (readahead_debug_level >= 1) printk(KERN_DEBUG args); } while(0)
+#define ddprintk(args...) \
+	do { if (readahead_debug_level >= 2) printk(KERN_DEBUG args); } while(0)
+
+
 void default_unplug_io_fn(struct backing_dev_info *bdi, struct page *page)
 {
 }
@@ -368,6 +623,9 @@ int force_page_cache_readahead(struct ad
 		offset += this_chunk;
 		nr_to_read -= this_chunk;
 	}
+
+	ra_account(NULL, RA_EVENT_READAHEAD, ret);
+
 	return ret;
 }
 
@@ -403,10 +661,16 @@ static inline int check_ra_success(struc
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
@@ -428,6 +692,10 @@ blockable_page_cache_readahead(struct ad
 
 	actual = __do_page_cache_readahead(mapping, filp, offset, nr_to_read, 0);
 
+	ra_account(NULL, RA_EVENT_READAHEAD, actual);
+	dprintk("blockable-readahead(ino=%lu, ra=%lu+%lu) = %d\n",
+			mapping->host->i_ino, offset, nr_to_read, actual);
+
 	return check_ra_success(ra, nr_to_read, actual);
 }
 

--
