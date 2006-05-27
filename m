Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751569AbWE0PxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569AbWE0PxK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 11:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbWE0Pwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 11:52:34 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:6108 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751569AbWE0Pvd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 11:51:33 -0400
Message-ID: <348745090.16246@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060527155131.200177171@localhost.localdomain>
References: <20060527154849.927021763@localhost.localdomain>
Date: Sat, 27 May 2006 23:49:00 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 11/32] readahead: sysctl parameters
Content-Disposition: inline; filename=readahead-parameter-sysctl-variables.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add new sysctl entries in /proc/sys/vm:

- readahead_ratio = 50
	i.e. set read-ahead size to <=(readahead_ratio%) thrashing threshold
- readahead_hit_rate = 1
	i.e. read-ahead hit ratio >=(1/readahead_hit_rate) is deemed ok

readahead_ratio also provides a way to select read-ahead logic at runtime:

	condition			    action
==========================================================================
readahead_ratio == 0		disable read-ahead
readahead_ratio <= 9		select the (old) stock read-ahead logic
readahead_ratio >= 10		select the (new) adaptive read-ahead logic

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 Documentation/sysctl/vm.txt |   37 +++++++++++++++++++++++++++++++++++++
 include/linux/mm.h          |   11 +++++++++++
 include/linux/sysctl.h      |    2 ++
 kernel/sysctl.c             |   28 ++++++++++++++++++++++++++++
 mm/readahead.c              |   17 +++++++++++++++++
 5 files changed, 95 insertions(+)

--- linux-2.6.17-rc4-mm3.orig/include/linux/mm.h
+++ linux-2.6.17-rc4-mm3/include/linux/mm.h
@@ -1029,6 +1029,17 @@ void handle_ra_miss(struct address_space
 		    struct file_ra_state *ra, pgoff_t offset);
 unsigned long max_sane_readahead(unsigned long nr);
 
+#ifdef CONFIG_ADAPTIVE_READAHEAD
+extern int readahead_ratio;
+#else
+#define readahead_ratio 1
+#endif /* CONFIG_ADAPTIVE_READAHEAD */
+
+static inline int prefer_adaptive_readahead(void)
+{
+	return readahead_ratio >= 10;
+}
+
 /* Do stack extension */
 extern int expand_stack(struct vm_area_struct *vma, unsigned long address);
 #ifdef CONFIG_IA64
--- linux-2.6.17-rc4-mm3.orig/mm/readahead.c
+++ linux-2.6.17-rc4-mm3/mm/readahead.c
@@ -26,6 +26,23 @@
 #define MIN_RA_PAGES	DIV_ROUND_UP(VM_MIN_READAHEAD*1024, PAGE_CACHE_SIZE)
 
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
+EXPORT_SYMBOL_GPL(readahead_ratio);
+
+/* Readahead as long as cache hit ratio keeps above 1/##. */
+int readahead_hit_rate = 1;
+
+/*
  * Detailed classification of read-ahead behaviors.
  */
 #define RA_CLASS_SHIFT 4
--- linux-2.6.17-rc4-mm3.orig/include/linux/sysctl.h
+++ linux-2.6.17-rc4-mm3/include/linux/sysctl.h
@@ -194,6 +194,8 @@ enum
 	VM_ZONE_RECLAIM_INTERVAL=32, /* time period to wait after reclaim failure */
 	VM_PANIC_ON_OOM=33,	/* panic at out-of-memory */
 	VM_SWAP_PREFETCH=34,	/* swap prefetch */
+	VM_READAHEAD_RATIO=35,	/* percent of read-ahead size to thrashing-threshold */
+	VM_READAHEAD_HIT_RATE=36, /* one accessed page legitimizes so many read-ahead pages */
 };
 
 /* CTL_NET names: */
--- linux-2.6.17-rc4-mm3.orig/kernel/sysctl.c
+++ linux-2.6.17-rc4-mm3/kernel/sysctl.c
@@ -77,6 +77,12 @@ extern int percpu_pagelist_fraction;
 extern int compat_log;
 extern int print_fatal_signals;
 
+#if defined(CONFIG_ADAPTIVE_READAHEAD)
+extern int readahead_ratio;
+extern int readahead_hit_rate;
+static int one = 1;
+#endif
+
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 int unknown_nmi_panic;
 int nmi_watchdog_enabled;
@@ -987,6 +993,28 @@ static ctl_table vm_table[] = {
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
 
--- linux-2.6.17-rc4-mm3.orig/Documentation/sysctl/vm.txt
+++ linux-2.6.17-rc4-mm3/Documentation/sysctl/vm.txt
@@ -31,6 +31,8 @@ Currently, these files are in /proc/sys/
 - zone_reclaim_interval
 - panic_on_oom
 - swap_prefetch
+- readahead_ratio
+- readahead_hit_rate
 
 ==============================================================
 
@@ -202,3 +204,38 @@ copying back pages from swap into the sw
 practice it can take many minutes before the vm is idle enough.
 
 The default value is 1.
+
+==============================================================
+
+readahead_ratio
+
+This limits readahead size to percent of the thrashing threshold.
+The thrashing threshold is dynamicly estimated from the _history_ read
+speed and system load, to deduce the _future_ readahead request size.
+
+Set it to a smaller value if you have not enough memory for all the
+concurrent readers, or the I/O loads fluctuate a lot. But if there's
+plenty of memory(>2MB per reader), a bigger value may help performance.
+
+readahead_ratio also selects the readahead logic:
+	VALUE	CODE PATH
+	-------------------------------------------
+	    0	disable readahead totally
+	  1-9	select the stock readahead logic
+	10-inf	select the adaptive readahead logic
+
+The default value is 50.  Reasonable values would be [50, 100].
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
+Larger values help catch more sparse access patterns. Be aware that
+readahead of the sparse patterns sacrifices memory for speed.
+
+The default value is 1.  It is recommended to keep the value below 16.

--
