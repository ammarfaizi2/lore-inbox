Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbVKIORj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbVKIORj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 09:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750875AbVKIORe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 09:17:34 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:15232 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750831AbVKIOOy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 09:14:54 -0500
Message-Id: <20051109141538.140634000@localhost.localdomain>
References: <20051109134938.757187000@localhost.localdomain>
Date: Wed, 09 Nov 2005 21:49:51 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 13/16] readahead: page aging accounting
Content-Disposition: inline; filename=readahead-account-aging.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The accuracy of stateful thrashing-threshold estimation depends largely on the
measurement of cold page aging speed.

A file named `pageaging' is created in debugfs to monitor the trace of two
measurement variables: per-zone `nr_page_aging' and per-cpu `smooth_aging'.
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

 mm/readahead.c |  148 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 147 insertions(+), 1 deletion(-)

--- linux-2.6.14-mm1.orig/mm/readahead.c
+++ linux-2.6.14-mm1/mm/readahead.c
@@ -230,11 +230,144 @@ static int ra_account_show(struct seq_fi
 	return 0;
 }
 
+/*
+ * Measure the aging progress of cold pages over time.
+ */
+#define AGING_INFO_SIZE	(1 << 8)
+#define AGING_INFO_MASK	(AGING_INFO_SIZE - 1)
+static int aging_info_shift[] = {0, 1, 2, 4, 8, 12};
+#define AGING_INFO_SHIFTS	(sizeof(aging_info_shift)/\
+				 sizeof(aging_info_shift[0]))
+static int aging_info_index[AGING_INFO_SHIFTS];
+static unsigned long aging_info[AGING_INFO_SIZE][AGING_INFO_SHIFTS*3];
+static spinlock_t aging_info_lock = SPIN_LOCK_UNLOCKED;
+
+static unsigned long nr_free_inactive(void);
+static unsigned long nr_smooth_aging(void);
+
+/*
+ * The accumulated count of pages pushed into inactive_list(s).
+ */
+static unsigned long nr_page_aging(void)
+{
+	unsigned int i;
+	unsigned long sum = 0;
+	struct zone *zones = NODE_DATA(numa_node_id())->node_zones;
+
+	for (i = 0; i < MAX_NR_ZONES; i++)
+		sum += zones[i].nr_page_aging;
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
+	mem = nr_free_inactive();
+	page_aging = nr_page_aging();
+	smooth_aging = nr_smooth_aging();
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
 static struct dentry *readahead_dentry;
+static struct dentry *pageaging_dentry;
+
+struct seq_operations aginginfo_ops = {
+	.start	= aginginfo_start,
+	.next	= aginginfo_next,
+	.stop	= aginginfo_stop,
+	.show	= aginginfo_show,
+};
 
 static int ra_debug_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, ra_account_show, NULL);
+	if (file->f_dentry == readahead_dentry)
+		return single_open(file, ra_account_show, NULL);
+	else
+		return seq_open(file, &aginginfo_ops);
 }
 
 static ssize_t ra_debug_write(struct file *file, const char __user *buf,
@@ -254,10 +387,20 @@ static struct file_operations ra_debug_f
 	.release	= single_release,
 };
 
+static struct file_operations aginginfo_fops = {
+	.open		= ra_debug_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
+
 static int __init readahead_init(void)
 {
 	readahead_dentry = debugfs_create_file("readahead",
 					0644, NULL, NULL, &ra_debug_fops);
+	pageaging_dentry = debugfs_create_file("pageaging",
+					0644, NULL, NULL, &aginginfo_fops);
 	return 0;
 }
 
@@ -1265,6 +1408,9 @@ static inline unsigned long compute_thra
 	else
 		*remain = 0;
 
+#ifdef DEBUG_READAHEAD
+	collect_aging_info();
+#endif
 	ddprintk("compute_thrashing_threshold: "
 			"ra=%lu=%lu*%lu/%lu, remain %lu for %lu\n",
 			ra_size, stream_shift, global_size, global_shift,

--
