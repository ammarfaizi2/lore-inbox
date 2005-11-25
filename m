Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161114AbVKYPJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161114AbVKYPJj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 10:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161115AbVKYPI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 10:08:56 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:61057 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1161105AbVKYPIw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 10:08:52 -0500
Message-Id: <20051125151707.508235000@localhost.localdomain>
References: <20051125151210.993109000@localhost.localdomain>
Date: Fri, 25 Nov 2005 23:12:25 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 15/19] readahead: page aging accounting
Content-Disposition: inline; filename=readahead-account-aging.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The accuracy of stateful thrashing-threshold estimation depends largely on the
measurement of cold page aging speed.

A file named `page_aging' is created in debugfs to monitor the trace of two
measurement variables: per-zone `aging_total' and per-cpu `readahead_aging'.
Their values and the jiffies are recorded each time one of them has a delta
of 1, 1/2, 1/4, 1/16, 1/256, 1/4096 (nr_inactive + nr_free).

Sample series of collected data shows that smooth_aging is more stable in
small sampling granularity:

  time         dt         page_aging8       smooth_aging8
872765         26     520056       33     653782      163
872791         12     520089      132     653945       51
872803          4     520221      132     653996       66
872807         17     520353      165     654062      107
872824         22     520518       99     654169       74
872846        372     520617       99     654243       78
873218        294     520716       99     654321       73
873512        196     520815       99     654394      130
873708         15     520914      231     654524       28
873723         15     521145      198     654552        9
873738        881     521343       99     654561      182
874619        700     521442        0     654743      198
875319        384     521442       66     654941      110
875703       2119     521508       99     655051     1632
877822       3960     521607        0     656683      980
881782        904     521607        0     657663      216

  time         dt         page_aging1       smooth_aging1
-90822      12418       5775    12999      33302    10767
-78404      17510      18774    10303      44069    10345
-60894      24757      29077     9871      54414    14615
-36137      19194      38948    10404      69029    13726
-16943      19636      49352    10440      82755    12865
  2693      16299      59792    12453      95620    10734
 18992      19851      72245    10073     106354    15960
 38843      16099      82318    10767     122314    14059
 54942      16094      93085    10041     136373    12117
 71036      19888     103126    12595     148490    16155
 90924      18452     115721     9782     164645    11705
109376      22395     125503    10214     176350    13679
131771      19310     135717    10759     190029    11843
151081      20793     146476    10699     201872    12595
171874      22308     157175    10321     214467    13157
194182      17954     167496    10773     227624    14803
212136      19946     178269    10554     242427    13391
232082      21051     188823    11179     255818    11783

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/readahead.c |  155 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 154 insertions(+), 1 deletion(-)

--- linux-2.6.15-rc1-mm2.orig/mm/readahead.c
+++ linux-2.6.15-rc1-mm2/mm/readahead.c
@@ -108,6 +108,9 @@ u32 debug_disable_stateful_method;
 static struct dentry *readahead_events_dentry;
 extern struct file_operations ra_debug_fops;
 
+static struct dentry *page_aging_dentry;
+extern struct file_operations aginginfo_fops;
+
 static int __init readahead_init(void)
 {
 	struct dentry *root;
@@ -120,6 +123,8 @@ static int __init readahead_init(void)
 
 	readahead_events_dentry = debugfs_create_file("events",
 					0644, root, NULL, &ra_debug_fops);
+	page_aging_dentry = debugfs_create_file("page_aging",
+					0644, root, NULL, &aginginfo_fops);
 
 	return 0;
 }
@@ -281,9 +286,14 @@ static int ra_account_show(struct seq_fi
 	return 0;
 }
 
+extern struct seq_operations aginginfo_ops;
+
 static int ra_debug_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, ra_account_show, NULL);
+	if (file->f_dentry == readahead_events_dentry)
+		return single_open(file, ra_account_show, NULL);
+	else
+		return seq_open(file, &aginginfo_ops);
 }
 
 static ssize_t ra_debug_write(struct file *file, const char __user *buf,
@@ -312,6 +322,146 @@ static inline void ra_account(struct fil
 
 #endif /* DEBUG_READAHEAD */
 
+/*
+ * Measure the aging progress of cold pages over time.
+ */
+#ifdef DEBUG_READAHEAD
+
+#define AGING_INFO_SIZE	(1 << 8)
+#define AGING_INFO_MASK	(AGING_INFO_SIZE - 1)
+static int aging_info_shift[] = {0, 1, 2, 4, 8, 12};
+#define AGING_INFO_SHIFTS	(sizeof(aging_info_shift)/\
+				 sizeof(aging_info_shift[0]))
+static int aging_info_index[AGING_INFO_SHIFTS];
+static unsigned long aging_info[AGING_INFO_SIZE][AGING_INFO_SHIFTS*3];
+static spinlock_t aging_info_lock = SPIN_LOCK_UNLOCKED;
+
+static unsigned long node_free_and_cold_pages(void);
+static unsigned long node_readahead_aging(void);
+
+/*
+ * The accumulated count of pages pushed into inactive_list(s).
+ */
+static unsigned long aging_total(void)
+{
+	unsigned int i;
+	unsigned long sum = 0;
+	struct zone *zones = NODE_DATA(numa_node_id())->node_zones;
+
+	for (i = 0; i < MAX_NR_ZONES; i++)
+		sum += zones[i].aging_total;
+
+	return sum;
+}
+
+static void collect_aging_info(void)
+{
+	int i;
+	unsigned long mem;
+	unsigned long page_aging;
+	unsigned long smooth_aging;
+
+	mem = node_free_and_cold_pages();
+	page_aging = aging_total();
+	smooth_aging = node_readahead_aging();
+
+	spin_lock_irq(&aging_info_lock);
+
+	for (i = AGING_INFO_SHIFTS - 1; i >= 0; i--) {
+		if (smooth_aging - aging_info[aging_info_index[i]][i*3+2] +
+		      page_aging - aging_info[aging_info_index[i]][i*3+1] >
+					2 * (mem >> aging_info_shift[i])) {
+			aging_info_index[i]++;
+			aging_info_index[i] &= AGING_INFO_MASK;
+			aging_info[aging_info_index[i]][i*3] = jiffies;
+			aging_info[aging_info_index[i]][i*3+1] = page_aging;
+			aging_info[aging_info_index[i]][i*3+2] = smooth_aging;
+		} else
+			break;
+	}
+
+	spin_unlock_irq(&aging_info_lock);
+}
+
+static void *aginginfo_start(struct seq_file *s, loff_t *pos)
+{
+	int n = *pos;
+	int i;
+
+	spin_lock_irq(&aging_info_lock);
+
+	if (!n) {
+		for (i = 0; i < AGING_INFO_SHIFTS; i++) {
+			seq_printf(s, "%12s %10s %18s%d %18s%d\t", "time","dt",
+                                        "page_aging", aging_info_shift[i],
+                                        "smooth_aging", aging_info_shift[i]);
+		}
+		seq_puts(s, "\n");
+	}
+
+	if (++n < AGING_INFO_SIZE)
+		return (void *)n;
+	else
+		return NULL;
+}
+
+static void *aginginfo_next(struct seq_file *s, void *p, loff_t *pos)
+{
+	int n = (int)p;
+
+	++*pos;
+	return (void *)(++n < AGING_INFO_SIZE ? n : 0);
+}
+
+static void aginginfo_stop(struct seq_file *s, void *p)
+{
+	spin_unlock_irq(&aging_info_lock);
+}
+
+static int aginginfo_show(struct seq_file *s, void *p)
+{
+	int n = (int)p;
+	int i;
+	int index0;
+	int index1;
+	long time;
+	unsigned long nr1;
+	unsigned long nr2;
+
+	for (i = 0; i < AGING_INFO_SHIFTS; i++) {
+		index0 = aging_info_index[i] + n;
+		index1 = aging_info_index[i] + n + 1;
+		index0 &= AGING_INFO_MASK;
+		index1 &= AGING_INFO_MASK;
+		time = aging_info[index0][i*3];
+		nr1 = aging_info[index1][i*3+1] - aging_info[index0][i*3+1];
+		nr2 = aging_info[index1][i*3+2] - aging_info[index0][i*3+2];
+		seq_printf(s, "%12ld %10lu %10lu %8lu %10lu %8lu\t",
+				time,  aging_info[index1][i*3] - time,
+				aging_info[index0][i*3+1], nr1,
+				aging_info[index0][i*3+2], nr2);
+	}
+	seq_puts(s, "\n");
+
+	return 0;
+}
+
+
+static struct seq_operations aginginfo_ops = {
+	.start	= aginginfo_start,
+	.next	= aginginfo_next,
+	.stop	= aginginfo_stop,
+	.show	= aginginfo_show,
+};
+
+static struct file_operations aginginfo_fops = {
+	.open		= ra_debug_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
+#endif /* DEBUG_READAHEAD */
 
 void default_unplug_io_fn(struct backing_dev_info *bdi, struct page *page)
 {
@@ -1298,6 +1448,9 @@ static inline unsigned long compute_thra
 	else
 		*remain = 0;
 
+#ifdef DEBUG_READAHEAD
+	collect_aging_info();
+#endif
 	ddprintk("compute_thrashing_threshold: "
 			"ra=%lu=%lu*%lu/%lu, remain %lu for %lu\n",
 			ra_size, stream_shift, global_size, global_shift,

--
