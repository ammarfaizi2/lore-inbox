Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbVKIORj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbVKIORj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 09:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbVKIORc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 09:17:32 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:16512 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750875AbVKIOOy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 09:14:54 -0500
Message-Id: <20051109141532.592128000@localhost.localdomain>
References: <20051109134938.757187000@localhost.localdomain>
Date: Wed, 09 Nov 2005 21:49:50 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, J?rn Engel <joern@wohnheim.fh-wedel.de>,
       Ingo Oeser <ioe-lkml@rameria.de>
Subject: [PATCH 12/16] readahead: events accounting
Content-Disposition: inline; filename=readahead-account-events.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A debugfs file named `readahead' is created according to advices from
J?rn Engel, Andrew Morton and Ingo Oeser. It yields to much better
readability than the preious /proc/vmstat interface :)

It reveals various read-ahead activities/events, and is vital to the testing.
Compile with 'Kernel hacking  --->  Debug Filesystem' to enable it.

This is a trimmed down output on my PC:
# cat /debugfs/readahead
[table requests]      total    newfile      state    context      none
cache_miss              403         56         12         69       263
read_random             260         37          5         17       201
io_congestion             0          0          0          0         0
io_cache_hit             85          0         24         46         0
io_block               9796       5613        822        143      3203
readahead              5956       5418        383        139         0
lookahead               961        650        212         98         0
lookahead_hit           449        181        164         58        41
lookahead_ignore          0          0          0          0         0
readahead_eof          4981       4768        171         28         0
readahead_shrink          0          0          0          0         0
readahead_thrash          0          0          0          0         0
readahead_mutilt          0          0          0          0         0
readahead_rescue         45          0          0          0        45

[table pages]         total    newfile      state    context      none
cache_miss             5590         72       2506        181      2826
read_random             265         37          5         17       206
io_congestion             0          0          0          0         0
io_cache_hit           2440          0       1054       1366         0
io_block             165848      11117     147794       3668      3203
readahead             43080      11360      28949       2621         0
readahead_hit         38251      10716      25669       1818         9
lookahead             24013       1718      21641        647         0
lookahead_hit         20161        770      18679        712         0
lookahead_ignore          0          0          0          0         0
readahead_eof         15961       7924       7440        461         0
readahead_shrink          0          0          0          0         0
readahead_thrash          0          0          0          0         0
readahead_mutilt          0          0          0          0         0
readahead_rescue        240          0          0          0       240

[table summary]       total    newfile      state    context      none
random_rate              4%         0%         1%        10%       99%
ra_hit_rate             88%        94%        88%        69%      900%
la_hit_rate             46%        27%        76%        58%     4100%
avg_ra_size               7          2         75         19         0
avg_la_size              25          3        102          7         0

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/readahead.c |  193 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 191 insertions(+), 2 deletions(-)

--- linux-2.6.14-mm1.orig/mm/readahead.c
+++ linux-2.6.14-mm1/mm/readahead.c
@@ -89,6 +89,179 @@ enum ra_event {
 #endif
 
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
+	"lookahead_ignore",
+	"readahead_eof",
+	"readahead_shrink",
+	"readahead_thrash",
+	"readahead_mutilt",
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
@@ -97,6 +270,10 @@ enum ra_event {
 
 #else /* !DEBUG_READAHEAD */
 
+static inline void ra_account(struct file_ra_state *ra,
+				enum ra_event e, int pages)
+{
+}
 #define dprintk(args...)     do {} while(0)
 #define ddprintk(args...)    do {} while(0)
 
@@ -992,6 +1169,8 @@ static int ra_dispatch(struct file_ra_st
 		ra_account(ra, RA_EVENT_READAHEAD_EOF, actual);
 	if (la_size)
 		ra_account(ra, RA_EVENT_LOOKAHEAD, la_size);
+	if (ra_size > actual)
+		ra_account(ra, RA_EVENT_IO_CACHE_HIT, ra_size - actual);
 	ra_account(ra, RA_EVENT_READAHEAD, actual);
 
 	dprintk("readahead-%s(ino=%lu, index=%lu, ra=%lu+%lu-%lu) = %d\n",
@@ -1632,8 +1811,11 @@ page_cache_readahead_adaptive(struct add
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
@@ -1723,8 +1905,15 @@ void fastcall ra_access(struct file_ra_s
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
