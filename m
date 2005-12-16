Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbVLPMrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbVLPMrU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 07:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbVLPMrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 07:47:11 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:30862 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932253AbVLPMqq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 07:46:46 -0500
Message-Id: <20051216131001.485560000@localhost.localdomain>
References: <20051216130738.300284000@localhost.localdomain>
Date: Fri, 16 Dec 2005 21:07:46 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, J?rn Engel <joern@wohnheim.fh-wedel.de>,
       Ingo Oeser <ioe-lkml@rameria.de>
Subject: [PATCH 08/12] readahead: events accounting
Content-Disposition: inline; filename=readahead-account-events.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A debugfs file named `readahead/events' is created according to advices from
J?rn Engel, Andrew Morton and Ingo Oeser. It yields to much better
readability than the preious /proc/vmstat interface :)

It reveals various read-ahead activities/events, and is vital to the testing.

-------------------------------------------------------------------------
If you are experiencing performance problems, or want to help improve the
read-ahead logic, please send me the debug data. Thanks.

- Preparations

## Compile with CONFIG_DEBUG_FS('Kernel hacking  --->  Debug Filesystem')
mkdir /debug
mount -t debug none /debug

- For each session with distinct access pattern

echo > /debug/readahead/events # reset the counters
# echo > /var/log/kern.log # you may want to backup it first
# echo 5 > /debug/readahead/debug_level # show verbose printk traces
## do one benchmark/task
# echo 0 > /debug/readahead/debug_level # revert to normal value
cp /debug/readahead/events readahead-events-`date +'%F_%R'`
# bzip2 -c /var/log/kern.log > kern.log-`date +'%F_%R'`.bz2

The commented out commands can uncover the very detailed file accesses,
which are useful sometimes. But the log file will be rather huge.

-------------------------------------------------------------------------
This is a trimmed down output on my PC:
# cat /debug/readahead/events
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

 mm/readahead.c |  215 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 213 insertions(+), 2 deletions(-)

--- linux.orig/mm/readahead.c
+++ linux/mm/readahead.c
@@ -108,6 +108,9 @@ enum ra_event {
 u32 readahead_debug_level = 0;
 u32 debug_disable_stateful_method = 0;
 
+static struct dentry *readahead_events_dentry;
+extern struct file_operations ra_debug_fops;
+
 static int __init readahead_init(void)
 {
 	struct dentry *root;
@@ -118,6 +121,9 @@ static int __init readahead_init(void)
 	debugfs_create_bool("disable_stateful_method", 0644, root,
 						&debug_disable_stateful_method);
 
+	readahead_events_dentry = debugfs_create_file("events",
+					0644, root, NULL, &ra_debug_fops);
+
 	return 0;
 }
 
@@ -135,6 +141,196 @@ static inline int disable_stateful_metho
 	return 0;
 }
 
+#endif
+
+/*
+ * Read-ahead events accounting.
+ */
+#ifdef DEBUG_READAHEAD
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
+static unsigned long ra_event_count[RA_CLASS_END+1][RA_EVENT_END+1][2];
+
+static inline void ra_account(struct file_ra_state *ra,
+				enum ra_event e, int pages)
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
+	ra_event_count[c][e][0] += 1;
+	ra_event_count[c][e][1] += pages;
+
+	if (e == RA_EVENT_READAHEAD)
+		ra_event_count[c][RA_EVENT_END][1] += pages * pages;
+}
+
+static int ra_account_show(struct seq_file *s, void *_)
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
+			ra_event_count[0][e][i] = 0;
+			for (c = 1; c < RA_CLASS_END; c++)
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
+			if (e == RA_EVENT_IO_BLOCK && i == 1)
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
+			((ra_event_count[c][RA_EVENT_READRANDOM][0] +
+			  ra_event_count[c][RA_EVENT_READAHEAD][0]) | 1));
+	seq_puts(s, "\n");
+
+	seq_printf(s, event_fmt, "ra_hit_rate");
+	for (c = 0; c <= RA_CLASS_END; c++)
+		seq_printf(s, percent_format,
+			(ra_event_count[c][RA_EVENT_READAHEAD_HIT][1] * 100) /
+			(ra_event_count[c][RA_EVENT_READAHEAD][1] | 1));
+	seq_puts(s, "\n");
+
+	seq_printf(s, event_fmt, "la_hit_rate");
+	for (c = 0; c <= RA_CLASS_END; c++)
+		seq_printf(s, percent_format,
+			(ra_event_count[c][RA_EVENT_LOOKAHEAD_HIT][0] * 100) /
+			(ra_event_count[c][RA_EVENT_LOOKAHEAD][0] | 1));
+	seq_puts(s, "\n");
+
+	seq_printf(s, event_fmt, "var_ra_size");
+	for (c = 0; c <= RA_CLASS_END; c++)
+		seq_printf(s, item_fmt,
+			(ra_event_count[c][RA_EVENT_END][1] -
+			 ra_event_count[c][RA_EVENT_READAHEAD][1] *
+			(ra_event_count[c][RA_EVENT_READAHEAD][1] /
+			(ra_event_count[c][RA_EVENT_READAHEAD][0] | 1))) /
+			(ra_event_count[c][RA_EVENT_READAHEAD][0] | 1));
+	seq_puts(s, "\n");
+
+	seq_printf(s, event_fmt, "avg_ra_size");
+	for (c = 0; c <= RA_CLASS_END; c++)
+		seq_printf(s, item_fmt,
+			(ra_event_count[c][RA_EVENT_READAHEAD][1] +
+			 ra_event_count[c][RA_EVENT_READAHEAD][0] / 2) /
+			(ra_event_count[c][RA_EVENT_READAHEAD][0] | 1));
+	seq_puts(s, "\n");
+
+	seq_printf(s, event_fmt, "avg_la_size");
+	for (c = 0; c <= RA_CLASS_END; c++)
+		seq_printf(s, item_fmt,
+			(ra_event_count[c][RA_EVENT_LOOKAHEAD][1] +
+			 ra_event_count[c][RA_EVENT_LOOKAHEAD][0] / 2) /
+			(ra_event_count[c][RA_EVENT_LOOKAHEAD][0] | 1));
+	seq_puts(s, "\n");
+
+	return 0;
+}
+
+static int ra_debug_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, ra_account_show, NULL);
+}
+
+static ssize_t ra_debug_write(struct file *file, const char __user *buf,
+				size_t size, loff_t *offset)
+{
+	if (file->f_dentry == readahead_events_dentry)
+		memset(ra_event_count, 0, sizeof(ra_event_count));
+	return 1;
+}
+
+struct file_operations ra_debug_fops = {
+	.owner		= THIS_MODULE,
+	.open		= ra_debug_open,
+	.write		= ra_debug_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+#else /* !DEBUG_READAHEAD */
+
+static inline void ra_account(struct file_ra_state *ra,
+				enum ra_event e, int pages)
+{
+}
+
 #endif /* DEBUG_READAHEAD */
 
 
@@ -472,6 +668,9 @@ int force_page_cache_readahead(struct ad
 		offset += this_chunk;
 		nr_to_read -= this_chunk;
 	}
+
+	ra_account(NULL, RA_EVENT_READAHEAD, ret);
+
 	return ret;
 }
 
@@ -507,10 +706,16 @@ static inline int check_ra_success(struc
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
@@ -532,6 +737,7 @@ blockable_page_cache_readahead(struct ad
 
 	actual = __do_page_cache_readahead(mapping, filp, offset, nr_to_read, 0);
 
+	ra_account(NULL, RA_EVENT_READAHEAD, actual);
 	dprintk("blockable-readahead(ino=%lu, ra=%lu+%lu) = %d\n",
 			mapping->host->i_ino, offset, nr_to_read, actual);
 
@@ -1013,6 +1219,8 @@ static int ra_dispatch(struct file_ra_st
 		ra_account(ra, RA_EVENT_READAHEAD_EOF, actual);
 	if (la_size)
 		ra_account(ra, RA_EVENT_LOOKAHEAD, la_size);
+	if (ra_size > actual)
+		ra_account(ra, RA_EVENT_IO_CACHE_HIT, ra_size - actual);
 	ra_account(ra, RA_EVENT_READAHEAD, actual);
 
 	if (!ra->ra_index && filp->f_dentry->d_inode) {
@@ -1691,8 +1899,11 @@ page_cache_readahead_adaptive(struct add
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

--
