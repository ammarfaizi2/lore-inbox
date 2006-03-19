Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWCSCm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWCSCm7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 21:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWCSClq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 21:41:46 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:46530 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751291AbWCSCeg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 21:34:36 -0500
Message-Id: <20060319023453.867802000@localhost.localdomain>
References: <20060319023413.305977000@localhost.localdomain>
Date: Sun, 19 Mar 2006 10:34:24 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 11/23] readahead: sysctl parameters
Content-Disposition: inline; filename=readahead-parameter-sysctl-variables.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add new sysctl entries in /proc/sys/vm:

- readahead_ratio = 50
	i.e. set read-ahead size to <=50% thrashing threshold
- readahead_hit_rate = 2
	i.e. read-ahead hit ratio >=50% is deemed ok

readahead_ratio also provides a way to select read-ahead logic at runtime:

	condition			    action
==========================================================================
readahead_ratio == 0		disable read-ahead
readahead_ratio <= 9		select the (old) stock read-ahead logic
readahead_ratio >= 10		select the (new) adaptive read-ahead logic

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 Documentation/sysctl/vm.txt |   36 ++++++++++++++++++++++++++++++++++++
 include/linux/sysctl.h      |    2 ++
 kernel/sysctl.c             |   28 ++++++++++++++++++++++++++++
 mm/readahead.c              |   18 ++++++++++++++++++
 4 files changed, 84 insertions(+)

--- linux-2.6.16-rc6-mm2.orig/mm/readahead.c
+++ linux-2.6.16-rc6-mm2/mm/readahead.c
@@ -28,6 +28,24 @@
 
 #ifdef CONFIG_ADAPTIVE_READAHEAD
 /*
+ * Adaptive read-ahead parameters.
+ */
+
+/* In laptop mode, poll delayed look-ahead on every ## pages read. */
+#define LAPTOP_POLL_INTERVAL 16
+
+/* Set look-ahead size to 1/# of the thrashing-threshold. */
+#define LOOKAHEAD_RATIO 8
+
+/* Set read-ahead size to ##% of the thrashing-threshold. */
+int readahead_ratio = 50;
+EXPORT_SYMBOL(readahead_ratio);
+
+/* Readahead as long as cache hit ratio keeps above 1/##. */
+int readahead_hit_rate = 2;
+EXPORT_SYMBOL(readahead_hit_rate);
+
+/*
  * Detailed classification of read-ahead behaviors.
  */
 #define RA_CLASS_SHIFT 4
--- linux-2.6.16-rc6-mm2.orig/include/linux/sysctl.h
+++ linux-2.6.16-rc6-mm2/include/linux/sysctl.h
@@ -187,6 +187,8 @@ enum
 	VM_ZONE_RECLAIM_MODE=31, /* reclaim local zone memory before going off node */
 	VM_ZONE_RECLAIM_INTERVAL=32, /* time period to wait after reclaim failure */
 	VM_SWAP_PREFETCH=33,	/* swap prefetch */
+	VM_READAHEAD_RATIO=34,	/* percent of read-ahead size to thrashing-threshold */
+	VM_READAHEAD_HIT_RATE=35, /* one accessed page legitimizes so many read-ahead pages */
 };
 
 
--- linux-2.6.16-rc6-mm2.orig/kernel/sysctl.c
+++ linux-2.6.16-rc6-mm2/kernel/sysctl.c
@@ -74,6 +74,12 @@ extern int pid_max_min, pid_max_max;
 extern int sysctl_drop_caches;
 extern int percpu_pagelist_fraction;
 
+#if defined(CONFIG_ADAPTIVE_READAHEAD)
+extern int readahead_ratio;
+extern int readahead_hit_rate;
+static int one = 1;
+#endif
+
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 int unknown_nmi_panic;
 extern int proc_unknown_nmi_panic(ctl_table *, int, struct file *,
@@ -926,6 +932,28 @@ static ctl_table vm_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
+#ifdef CONFIG_ADAPTIVE_READAHEAD
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
+#endif
 	{ .ctl_name = 0 }
 };
 
--- linux-2.6.16-rc6-mm2.orig/Documentation/sysctl/vm.txt
+++ linux-2.6.16-rc6-mm2/Documentation/sysctl/vm.txt
@@ -30,6 +30,8 @@ Currently, these files are in /proc/sys/
 - zone_reclaim_mode
 - zone_reclaim_interval
 - swap_prefetch
+- readahead_ratio
+- readahead_hit_rate
 
 ==============================================================
 
@@ -189,3 +191,37 @@ copying back pages from swap into the sw
 practice it can take many minutes before the vm is idle enough.
 
 The default value is 1.
+
+==============================================================
+
+readahead_ratio
+
+This limits readahead size to percent of the thrashing-threshold,
+which is dynamicly estimated from the _history_ read speed and
+system load, to deduce the _future_ readahead request size.
+
+Set it to a smaller value if you have not enough memory for all the
+concurrent readers, or the I/O loads fluctuate a lot. But if there's
+plenty of memory(>2MB per reader), enlarge it may help speedup reads.
+
+readahead_ratio also selects the readahead logic:
+0:	disable readahead totally
+1-9:	select the stock readahead logic
+10-inf:	select the adaptive readahead logic
+
+The default value is 50; reasonable values would be 50-100.
+
+==============================================================
+
+readahead_hit_rate
+
+This is the max allowed value of (readahead-pages : accessed-pages).
+Useful only when (readahead_ratio >= 10). If the previous readahead
+request has bad hit rate, the kernel will be reluctant to do the next
+readahead.
+
+A larger value helps catch more sparse access patterns. Be aware that
+readahead of the sparse patterns sacrifices memory for speed.
+
+The default value is 2.
+It is recommended to keep the value below (max-readahead-pages / 8).

--
