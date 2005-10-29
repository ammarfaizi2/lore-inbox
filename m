Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbVJ2Fuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbVJ2Fuo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 01:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbVJ2Frv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 01:47:51 -0400
Received: from ns.ustc.edu.cn ([202.38.64.1]:39307 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751356AbVJ2Frd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 01:47:33 -0400
Message-Id: <20051029060243.472505000@localhost.localdomain>
References: <20051029060216.159380000@localhost.localdomain>
Date: Sat, 29 Oct 2005 14:02:28 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, J?rn Engel <joern@wohnheim.fh-wedel.de>,
       Ingo Oeser <ioe-lkml@rameria.de>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 12/13] readahead: events accounting
Content-Disposition: inline; filename=readahead-account-events.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A debugfs file named `readahead' is created according to advices from
J?rn Engel, Andrew Morton and Ingo Oeser. It yields to much better
readability than the preious /proc/vmstat interface :)

It reveals various read-ahead activities/events, and is vital to the testing.

This is a trimmed down output on my PC:
# cat /debugfs/readahead
[table requests]      total    newfile      state    context   contexta
cache_miss              234         50         10         54          0
read_random             116         37          4         21          0
io_congestion             0          0          0          0          0
io_cache_hit             61          0         14         37          0
io_block               4994       1576        232        120          2
readahead              1812       1522        171        107          2
lookahead               596        442         76         78          0
lookahead_hit           214         89         70         32          1
readahead_eof          1208       1080         95         21          2
readahead_shrink          0          0          0          0          0
readahead_thrash          0          0          0          0          0
readahead_rescue       1275          0          0          0          0

[table pages]         total    newfile      state    context   contexta
cache_miss              401         98         50         87          0
read_random             120         37          4         21          0
io_congestion             0          0          0          0          0
io_cache_hit            872          0        412        448          0
io_block              22833       3857      12177       3680         21
readahead             15081       3827       9683       1484         21
readahead_hit         12684       3441       8164       1001         22
lookahead              8191        936       6926        329          0
lookahead_hit          8140        230       6368       1542          0
readahead_eof          5192       1955       2777        373         21
readahead_shrink          0          0          0          0          0
readahead_thrash          0          0          0          0          0
readahead_rescue      13656          0          0          0          0

[table summary]       total    newfile      state    context   contexta
random_rate              6%         2%         2%        16%         0%
ra_hit_rate             84%        89%        84%        67%       100%
la_hit_rate             35%        20%        90%        40%       100%
avg_ra_size               8          3         56         14          7
avg_la_size              14          2         90          4          0

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/readahead.c |  194 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 192 insertions(+), 2 deletions(-)

--- linux-2.6.14-rc5-mm1.orig/mm/readahead.c
+++ linux-2.6.14-rc5-mm1/mm/readahead.c
@@ -47,6 +47,9 @@ enum ra_class {
 enum ra_event {
 	RA_EVENT_CACHE_MISS,		/* read cache misses */
 	RA_EVENT_READRANDOM,		/* random reads */
+	RA_EVENT_IO_CONGESTION,		/* io congestion */
+	RA_EVENT_IO_CACHE_HIT,		/* canceled io due to cache hit */
+	RA_EVENT_IO_BLOCK,		/* read on locked page */
 
 	RA_EVENT_READAHEAD,		/* read-ahead issued */
 	RA_EVENT_READAHEAD_HIT,		/* read-ahead page hit */
@@ -65,6 +68,177 @@ enum ra_event {
  */
 #define DEBUG_READAHEAD
 #ifdef DEBUG_READAHEAD
+#include <linux/jiffies.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <linux/init.h>
+
+static char *ra_class_name[] = {
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
+static char *ra_event_name[] = {
+	"cache_miss",
+	"read_random",
+	"io_congestion",
+	"io_cache_hit",
+	"io_block",
+	"readahead",
+	"readahead_hit",
+	"lookahead",
+	"lookahead_hit",
+	"readahead_eof",
+	"readahead_shrink",
+	"readahead_thrash",
+	"readahead_rescue",
+};
+
+static unsigned long ra_event_count[RA_CLASS_END+1][RA_EVENT_END][2];
+
+static inline void ra_account(struct file_ra_state *ra,
+				enum ra_event e, int pages)
+{
+	enum ra_class c;
+
+	c = (ra ? ra->flags & RA_CLASS_MASK : RA_CLASS_END);
+	if (e == RA_EVENT_READAHEAD_HIT && pages < 0) {
+		c = (ra->flags >> RA_CLASS_SHIFT) & RA_CLASS_MASK;
+		pages = -pages;
+	}
+	if (!c)
+		c = RA_CLASS_END;
+	BUG_ON(c > RA_CLASS_END);
+
+	ra_event_count[c][e][0] += 1;
+	ra_event_count[c][e][1] += pages;
+}
+
+static int ra_account_show(struct seq_file *s, void *_)
+{
+	int i;
+	int c;
+	int e;
+	static char event_fmt[] = "%-16s";
+	static char class_fmt[] = "%11s";
+	static char item_fmt[] = "%11lu";
+	static char percent_format[] = "%10lu%%";
+	static char *table_name[] = {
+		"[table requests]",
+		"[table pages]",
+		"[table summary]"};
+
+	for (i = 0; i <= 1; i++) {
+		for (e = 0; e < RA_EVENT_END; e++) {
+			ra_event_count[0][e][i] = 0;
+			for (c = 1; c <= RA_CLASS_END; c++)
+				ra_event_count[0][e][i] +=
+							ra_event_count[c][e][i];
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
+
+			seq_printf(s, event_fmt, ra_event_name[e]);
+			for (c = 0; c <= RA_CLASS_END; c++)
+				seq_printf(s, item_fmt,
+						ra_event_count[c][e][i]);
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
+			(ra_event_count[c][RA_EVENT_READRANDOM][0] * 100) /
+			(ra_event_count[c][RA_EVENT_READRANDOM][0] +
+			 ra_event_count[c][RA_EVENT_READAHEAD][0] + 1));
+	seq_puts(s, "\n");
+
+	seq_printf(s, event_fmt, "ra_hit_rate");
+	for (c = 0; c <= RA_CLASS_END; c++)
+		seq_printf(s, percent_format,
+			(ra_event_count[c][RA_EVENT_READAHEAD_HIT][1] * 100) /
+			(ra_event_count[c][RA_EVENT_READAHEAD][1] + 1));
+	seq_puts(s, "\n");
+
+	seq_printf(s, event_fmt, "la_hit_rate");
+	for (c = 0; c <= RA_CLASS_END; c++)
+		seq_printf(s, percent_format,
+			(ra_event_count[c][RA_EVENT_LOOKAHEAD_HIT][0] * 100) /
+			(ra_event_count[c][RA_EVENT_LOOKAHEAD][0] + 1));
+	seq_puts(s, "\n");
+
+	seq_printf(s, event_fmt, "avg_ra_size");
+	for (c = 0; c <= RA_CLASS_END; c++)
+		seq_printf(s, item_fmt,
+			(ra_event_count[c][RA_EVENT_READAHEAD][1] +
+			 ra_event_count[c][RA_EVENT_READAHEAD][0] / 2) /
+			(ra_event_count[c][RA_EVENT_READAHEAD][0] + 1));
+	seq_puts(s, "\n");
+
+	seq_printf(s, event_fmt, "avg_la_size");
+	for (c = 0; c <= RA_CLASS_END; c++)
+		seq_printf(s, item_fmt,
+			(ra_event_count[c][RA_EVENT_LOOKAHEAD][1] +
+			 ra_event_count[c][RA_EVENT_LOOKAHEAD][0] / 2) /
+			(ra_event_count[c][RA_EVENT_LOOKAHEAD][0] + 1));
+	seq_puts(s, "\n");
+
+	return 0;
+}
+
+static struct dentry *readahead_dentry;
+
+static int ra_debug_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, ra_account_show, NULL);
+}
+
+static ssize_t ra_debug_write(struct file *file, const char __user *buf,
+				size_t size, loff_t *offset)
+{
+	if (file->f_dentry == readahead_dentry)
+		memset(ra_event_count, 0, sizeof(ra_event_count));
+	return 1;
+}
+
+static struct file_operations ra_debug_fops = {
+	.owner		= THIS_MODULE,
+	.open		= ra_debug_open,
+	.write		= ra_debug_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int __init readahead_init(void)
+{
+	readahead_dentry = debugfs_create_file("readahead",
+					0644, NULL, NULL, &ra_debug_fops);
+	return 0;
+}
+
+module_init(readahead_init)
 
 #define dprintk(args...) \
 	if (readahead_ratio & 1) printk(KERN_DEBUG args)
@@ -73,6 +247,10 @@ enum ra_event {
 
 #else /* DEBUG_READAHEAD */
 
+static inline void ra_account(struct file_ra_state *ra,
+				enum ra_event e, int pages)
+{
+}
 #define dprintk(args...)     do {} while(0)
 #define ddprintk(args...)    do {} while(0)
 
@@ -945,6 +1123,8 @@ static int ra_dispatch(struct file_ra_st
 		ra_account(ra, RA_EVENT_READAHEAD_EOF, actual);
 	if (la_size)
 		ra_account(ra, RA_EVENT_LOOKAHEAD, la_size);
+	if (ra_size > actual)
+		ra_account(ra, RA_EVENT_IO_CACHE_HIT, ra_size - actual);
 	ra_account(ra, RA_EVENT_READAHEAD, actual);
 
 	dprintk("readahead-%s(ino=%lu, index=%lu, ra=%lu+%lu-%lu) = %d\n",
@@ -1577,8 +1757,11 @@ page_cache_readahead_adaptive(struct add
 	if (page) {
 		if(!TestClearPageReadahead(page))
 			return 0;
-		if (bdi_read_congested(mapping->backing_dev_info))
+		if (bdi_read_congested(mapping->backing_dev_info)) {
+			ra_account(ra, RA_EVENT_IO_CONGESTION,
+							end_index - index);
 			return 0;
+		}
 	}
 
 	if (page)
@@ -1665,8 +1848,15 @@ void fastcall ra_access(struct file_ra_s
 			   (1 << PG_referenced)))
 		return;
 
-	if (!ra_has_index(ra, page->index))
+	if (ra_has_index(ra, page->index)) {
+		if (PageLocked(page))
+			ra_account(ra, RA_EVENT_IO_BLOCK,
+					ra->readahead_index - page->index);
+	} else {
+		if (PageLocked(page))
+			ra_account(0, RA_EVENT_IO_BLOCK, 1);
 		return;
+	}
 
 	ra->cache_hit++;
 

--
