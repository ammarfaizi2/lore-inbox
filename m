Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266627AbUHBQtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266627AbUHBQtU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 12:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266630AbUHBQtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 12:49:19 -0400
Received: from ozlabs.org ([203.10.76.45]:24726 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266627AbUHBQsk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 12:48:40 -0400
Date: Tue, 3 Aug 2004 02:44:48 +1000
From: Anton Blanchard <anton@samba.org>
To: sfr@ozlabs.org
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org
Subject: [PATCH] [ppc64] watch IOMMU virtual merging
Message-ID: <20040802164448.GN30253@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Heres a quick patch to watch IOMMU virtual merging on ppc64. The column
on the left is the SG list before virtual merging and the one on the
right is after virtual merging.

Also attached is a sample of a dd from a disk. One interesting thing to
note is that the merging is worse than on earlier 2.6 kernels. The dd
test would show only 1 segment SG lists on the way out, now we have a
range of 1-8 segment SG lists.

I think the change in the page allocator to attempt to allocate memory
in increasing addresses (which improves physical merging a lot) is
causing this. In doing so we end up with some really large SG entries
(greater than 15 pages) and the largealloc path in the ppc64 IOMMU code
kicks in and allocates it in another region of TCE space. This makes it
impossible to merge with a smaller allocation either before or after it.

The other problem with large SG list entries is that IOMMU space
exhaustion could prevent it from being mapped, while it would fit if no
physical merging had taken place. One option is to disable physical
merging for ppc64 but there are trade offs (eg physical merging allows
us to allocate smaller SG lists).

We have discussed these issues before, but its interesting to have some
data to analyse.

Anton

size    count in        count out
1       377     120491
2       12759   16470
3       13161   80265
4       63989   40421
5       88581   5140
6       10081   1167
7       7128    144
8       5715    14
9       5709    0
10      3256    0
11      2970    0
12      2974    0
13      2659    0
14      2719    0
15      2716    0
16      3229    0
17      3076    0
18      2769    0
19      2390    0
20      2321    0
21      2159    0
22      2306    0
23      2204    0
24      2273    0
25      1794    0
26      1600    0
27      1548    0
28      1349    0
29      1247    0
30      1082    0
31      839     0
32      1375    0
33      812     0
34      590     0
35      560     0
36      508     0
37      409     0
38      338     0
39      297     0
40      207     0
41      202     0
42      173     0
43      123     0
44      88      0
45      63      0
46      65      0
47      47      0
48      31      0
49      43      0
50      23      0
51      20      0
52      20      0
53      14      0
54      13      0
55      20      0
56      15      0
57      15      0
58      19      0
59      8       0
60      7       0
61      13      0
62      22      0
63      20      0
64      1146    0

diff -puN arch/ppc64/kernel/iSeries_iommu.c~watch_merging arch/ppc64/kernel/iSeries_iommu.c
diff -puN arch/ppc64/kernel/iommu.c~watch_merging arch/ppc64/kernel/iommu.c
--- gr_work/arch/ppc64/kernel/iommu.c~watch_merging	2004-05-21 10:01:05.998130746 -0500
+++ gr_work-anton/arch/ppc64/kernel/iommu.c	2004-05-21 10:01:06.073118868 -0500
@@ -225,6 +225,54 @@ static void iommu_free(struct iommu_tabl
 	spin_unlock_irqrestore(&(tbl->it_lock), flags);
 }
 
+#define BUCKETS 128
+static DEFINE_PER_CPU(unsigned long, sglist_in[BUCKETS]);
+static DEFINE_PER_CPU(unsigned long, sglist_out[BUCKETS]);
+
+static int proc_iommu_show(struct seq_file *m, void *v)
+{
+	int i, cpu;
+	unsigned long in, out;
+
+	seq_printf(m, "size\tcount in\tcount out\n");
+
+	for (i = 0; i < BUCKETS; i++) {
+		in = out = 0;
+		for_each_cpu(cpu) {
+			in += per_cpu(sglist_in[i], cpu);
+			out += per_cpu(sglist_out[i], cpu);
+		}
+		if (in || out)
+			seq_printf(m, "%d\t%ld\t%ld\n", i+1, in, out);
+	}
+
+        return 0;
+}
+
+static int proc_iommu_open(struct inode *inode, struct file *file)
+{
+        return single_open(file, proc_iommu_show, NULL);
+}
+
+static struct file_operations proc_iommu_operations = {
+        .open           = proc_iommu_open,
+        .read           = seq_read,
+        .llseek         = seq_lseek,
+        .release        = single_release,
+};
+
+static int __init proc_iommu_init(void)
+{
+        struct proc_dir_entry *e;
+                              
+        e = create_proc_entry("ppc64/iommu", 0, NULL);
+        if (e)
+                e->proc_fops = &proc_iommu_operations;
+
+        return 0;
+}
+__initcall(proc_iommu_init);
+
 int iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 		struct scatterlist *sglist, int nelems,
 		enum dma_data_direction direction)
@@ -234,6 +282,7 @@ int iommu_map_sg(struct device *dev, str
 	struct scatterlist *s, *outs, *segstart;
 	int outcount;
 	unsigned long handle;
+	unsigned long tmp;
 
 	BUG_ON(direction == DMA_NONE);
 
@@ -251,6 +300,11 @@ int iommu_map_sg(struct device *dev, str
 
 	spin_lock_irqsave(&(tbl->it_lock), flags);
 
+	tmp = nelems;
+	if (tmp > BUCKETS)
+		tmp = BUCKETS;
+	__get_cpu_var(sglist_in[tmp-1])++;
+
 	for (s = outs; nelems; nelems--, s++) {
 		unsigned long vaddr, npages, entry, slen;
 
@@ -321,6 +375,11 @@ int iommu_map_sg(struct device *dev, str
 	if (ppc_md.tce_flush)
 		ppc_md.tce_flush(tbl);
 
+	tmp = outcount;
+	if (tmp > BUCKETS)
+		tmp = BUCKETS;
+	__get_cpu_var(sglist_out[tmp-1])++;
+
 	spin_unlock_irqrestore(&(tbl->it_lock), flags);
 
 	/* Make sure updates are seen by hardware */
