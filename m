Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbVLPMpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbVLPMpx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 07:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbVLPMpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 07:45:52 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:33933 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932252AbVLPMpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 07:45:38 -0500
Message-Id: <20051216130859.559147000@localhost.localdomain>
References: <20051216130738.300284000@localhost.localdomain>
Date: Fri, 16 Dec 2005 21:07:42 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 04/12] readahead: parameters
Content-Disposition: inline; filename=readahead-parameters.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- new sysctl entries in /proc/sys/vm:
	- readahead_ratio = 1
	- readahead_hit_rate = 2
- dynamic minimal/initial read-ahead size.

For now, different ranges of readahead_ratio select different read-ahead
code path:

	condition			action
===========================================================
readahead_ratio == 0		disable read-ahead
readahead_ratio < 9		select old read-ahead logic
readahead_ratio >= 9		select new read-ahead logic

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 Documentation/sysctl/vm.txt |   38 ++++++++++++++++++++++++++++++++++++++
 include/linux/sysctl.h      |    2 ++
 kernel/sysctl.c             |   23 +++++++++++++++++++++++
 mm/readahead.c              |   35 +++++++++++++++++++++++++++++++++++
 4 files changed, 98 insertions(+)

--- linux.orig/Documentation/sysctl/vm.txt
+++ linux/Documentation/sysctl/vm.txt
@@ -28,6 +28,8 @@ Currently, these files are in /proc/sys/
 - block_dump
 - drop-caches
 - swap_prefetch
+- readahead_ratio
+- readahead_hit_rate
 
 ==============================================================
 
@@ -132,3 +134,39 @@ laptop_mode is enabled and then it is te
 disables prefetching entirely.
 
 The default value is dependant on ramsize.
+
+==============================================================
+
+readahead_ratio
+
+This limits read-ahead size to percent of the thrashing-threshold.
+The thrashing-threshold is dynamicly estimated according to the
+_history_ read speed and system load, and used to limit the
+_future_ read-ahead request size.
+
+Set it to a low value if you have not enough memory to counteract
+the I/O load fluctuations. But if there's plenty of memory, set it
+to a larger value might help speedup reads.
+
+readahead_ratio also selects the read-ahead logic:
+0:	disable read-ahead totally
+1-9:	select the well tested old read-ahead logic
+10-inf:	select the new adaptive read-ahead logic
+
+The default value is 1.
+For the new adaptive read-ahead, reasonable values would be 50-100.
+
+==============================================================
+
+readahead_hit_rate
+
+This is the max allowed value of (read-ahead-pages : accessed-pages).
+Useful only when (readahead_ratio >= 10). If the previous read-ahead
+request has bad hit rate, kernel will be very conservative to issue
+the next read-ahead.
+
+A large value helps speedup some sparse access patterns, at the cost
+of more memory consumption. It is recommended to keep the value below
+(max-readahead-pages / 8).
+
+The default value is 2.
--- linux.orig/include/linux/sysctl.h
+++ linux/include/linux/sysctl.h
@@ -184,6 +184,8 @@ enum
 	VM_DROP_PAGECACHE=29,	/* int: nuke lots of pagecache */
 	VM_PERCPU_PAGELIST_FRACTION=30,/* int: fraction of pages in each percpu_pagelist */
 	VM_SWAP_PREFETCH=31,	/* int: amount to swap prefetch */
+	VM_READAHEAD_RATIO=32, /* percent of read-ahead size to thrashing-threshold */
+	VM_READAHEAD_HIT_RATE=33, /* one accessed page legitimizes so many read-ahead pages */
 };
 
 /* CTL_NET names: */
--- linux.orig/kernel/sysctl.c
+++ linux/kernel/sysctl.c
@@ -70,6 +70,8 @@ extern int printk_ratelimit_burst;
 extern int pid_max_min, pid_max_max;
 extern int sysctl_drop_caches;
 extern int percpu_pagelist_fraction;
+extern int readahead_ratio;
+extern int readahead_hit_rate;
 
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 int unknown_nmi_panic;
@@ -671,6 +673,7 @@ static ctl_table kern_table[] = {
 /* Constants for minimum and maximum testing in vm_table.
    We use these as one-element integer vectors. */
 static int zero;
+static int one = 1;
 static int one_hundred = 100;
 
 
@@ -889,6 +892,26 @@ static ctl_table vm_table[] = {
 	},
 #endif
 #endif
+	{
+		.ctl_name	= VM_READAHEAD_RATIO,
+		.procname	= "readahead_ratio",
+		.data		= &readahead_ratio,
+		.maxlen		= sizeof(readahead_ratio),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+	},
+	{
+		.ctl_name	= VM_READAHEAD_HIT_RATE,
+		.procname	= "readahead_hit_rate",
+		.data		= &readahead_hit_rate,
+		.maxlen		= sizeof(readahead_hit_rate),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &one,
+	},
 	{ .ctl_name = 0 }
 };
 
--- linux.orig/mm/readahead.c
+++ linux/mm/readahead.c
@@ -20,6 +20,20 @@
 #define MAX_RA_PAGES	KB(VM_MAX_READAHEAD)
 #define MIN_RA_PAGES	KB(VM_MIN_READAHEAD)
 
+/* In laptop mode, poll delayed look-ahead on every ## pages read. */
+#define LAPTOP_POLL_INTERVAL 16
+
+/* Set look-ahead size to 1/# of the thrashing-threshold. */
+#define LOOKAHEAD_RATIO 8
+
+/* Set read-ahead size to ##% of the thrashing-threshold. */
+int readahead_ratio = 1;
+EXPORT_SYMBOL(readahead_ratio);
+
+/* Readahead as long as cache hit ratio keeps above 1/##. */
+int readahead_hit_rate = 2;
+EXPORT_SYMBOL(readahead_hit_rate);
+
 /* Detailed classification of read-ahead behaviors. */
 #define RA_CLASS_SHIFT 4
 #define RA_CLASS_MASK  ((1 << RA_CLASS_SHIFT) - 1)
@@ -794,6 +808,27 @@ out:
 }
 
 /*
+ * ra_size is mainly determined by:
+ * 1. sequential-start: min(MIN_RA_PAGES + (pages>>14), KB(128))
+ * 2. sequential-max:	min(ra->ra_pages, 0xFFFF)
+ * 3. sequential:	(thrashing-threshold) * readahead_ratio / 100
+ *
+ * Table of concrete numbers for 4KB page size:
+ *  (inactive + free) (in MB):    4   8   16   32   64  128  256  512 1024
+ *    initial ra_size (in KB):   16  16   16   16   20   24   32   48   64
+ */
+static inline void get_readahead_bounds(struct file_ra_state *ra,
+					unsigned long *ra_min,
+					unsigned long *ra_max)
+{
+	unsigned long pages;
+
+	pages = node_free_and_cold_pages();
+	*ra_max = min(min(pages/2, 0xFFFFUL), ra->ra_pages);
+	*ra_min = min(min(MIN_RA_PAGES + (pages>>14), KB(128)), *ra_max/2);
+}
+
+/*
  * This is the entry point of the adaptive read-ahead logic.
  *
  * It is only called on two conditions:

--
