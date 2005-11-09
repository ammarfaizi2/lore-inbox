Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbVKIOOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbVKIOOw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 09:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbVKIOOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 09:14:36 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:2285 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750827AbVKIOOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 09:14:20 -0500
Message-Id: <20051109141505.231474000@localhost.localdomain>
References: <20051109134938.757187000@localhost.localdomain>
Date: Wed, 09 Nov 2005 21:49:45 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 07/16] readahead: tunable parameters
Content-Disposition: inline; filename=readahead-parameter.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- new entry in /proc/sys/vm/readahead_ratio with default value of 50;
- new entry in /proc/sys/vm/readahead_hit_rate with default value of 2;
- new entry in /proc/sys/vm/readahead_live_chunk with default value of 2M;
- limit mmap read-around size to 256kb;
- dynamic minimal/initial read-ahead size.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 Documentation/sysctl/vm.txt |   51 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mm.h          |    5 +++-
 include/linux/sysctl.h      |    3 ++
 kernel/sysctl.c             |   34 +++++++++++++++++++++++++++++
 mm/filemap.c                |    7 ++++++
 mm/readahead.c              |   41 ++++++++++++++++++++++++++++++++++-
 6 files changed, 139 insertions(+), 2 deletions(-)

--- linux-2.6.14-mm1.orig/Documentation/sysctl/vm.txt
+++ linux-2.6.14-mm1/Documentation/sysctl/vm.txt
@@ -27,6 +27,9 @@ Currently, these files are in /proc/sys/
 - laptop_mode
 - block_dump
 - swap_prefetch
+- readahead_ratio
+- readahead_hit_rate
+- readahead_live_chunk
 
 ==============================================================
 
@@ -114,3 +117,51 @@ except when laptop_mode is enabled and t
 Setting it to 0 disables prefetching entirely.
 
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
+to a larger value might help increase read speed. Also note that a
+value >= 80 activates mandatory thrashing protection(see
+readahead_live_chunk).
+
+The default value is 50.
+
+==============================================================
+
+readahead_hit_rate
+
+This is the max allowed value of (read-ahead-pages : accessed-pages).
+If the previous read-ahead request has bad hit rate, kernel will be
+very conservative to issue the next read-ahead.
+
+A large value helps speedup some sparse access patterns, at the cost
+of more memory consumption. It is recommended to keep the value below
+(max-readahead-pages / 8).
+
+The default value is 2.
+
+==============================================================
+
+readahead_live_chunk
+
+In a file server, there are typically one or more sequential
+readers working on a file. The kernel can detect most live
+chunks(a sequence of pages to be accessed by an active reader),
+and save them for their imminent readers. This is called
+mandatory thrashing protection, and is only in effect when
+(readahead_ratio >= 80).
+
+This parameter controls the max allowed chunk size, i.e. the max
+number of pages pinned for an active reader.
+
+The default value is 2MB size of pages. That is 512 on most archs.
+Increase it if you have enough memory.
--- linux-2.6.14-mm1.orig/include/linux/mm.h
+++ linux-2.6.14-mm1/include/linux/mm.h
@@ -968,11 +968,14 @@ extern int filemap_populate(struct vm_ar
 int write_one_page(struct page *page, int wait);
 
 /* readahead.c */
-#define VM_MAX_READAHEAD	128	/* kbytes */
+#define VM_MAX_READAHEAD	1024	/* kbytes */
 #define VM_MIN_READAHEAD	16	/* kbytes (includes current page) */
 #define VM_MAX_CACHE_HIT    	256	/* max pages in a row in cache before
 					 * turning readahead off */
 
+/* turn on read-ahead thrashing protection if (readahead_ratio >= ##) */
+#define VM_READAHEAD_PROTECT_RATIO	80
+
 int do_page_cache_readahead(struct address_space *mapping, struct file *filp,
 			pgoff_t offset, unsigned long nr_to_read);
 int force_page_cache_readahead(struct address_space *mapping, struct file *filp,
--- linux-2.6.14-mm1.orig/include/linux/sysctl.h
+++ linux-2.6.14-mm1/include/linux/sysctl.h
@@ -182,6 +182,9 @@ enum
 	VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space layout */
 	VM_SWAP_TOKEN_TIMEOUT=28, /* default time for token time out */
 	VM_SWAP_PREFETCH=29,	/* int: amount to swap prefetch */
+	VM_READAHEAD_RATIO=30, /* percent of read-ahead size to thrashing-threshold */
+	VM_READAHEAD_HIT_RATE=31, /* one accessed page legitimizes so many read-ahead pages */
+	VM_READAHEAD_LIVE_CHUNK=32, /* pin no more than that many pages for a live reader */
 };
 
 
--- linux-2.6.14-mm1.orig/kernel/sysctl.c
+++ linux-2.6.14-mm1/kernel/sysctl.c
@@ -67,6 +67,9 @@ extern int min_free_kbytes;
 extern int printk_ratelimit_jiffies;
 extern int printk_ratelimit_burst;
 extern int pid_max_min, pid_max_max;
+extern int readahead_ratio;
+extern int readahead_hit_rate;
+extern int readahead_live_chunk;
 
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 int unknown_nmi_panic;
@@ -670,6 +673,7 @@ static ctl_table kern_table[] = {
 /* Constants for minimum and maximum testing in vm_table.
    We use these as one-element integer vectors. */
 static int zero;
+static int one = 1;
 static int one_hundred = 100;
 
 
@@ -869,6 +873,36 @@ static ctl_table vm_table[] = {
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
+	{
+		.ctl_name	= VM_READAHEAD_LIVE_CHUNK,
+		.procname	= "readahead_live_chunk",
+		.data		= &readahead_live_chunk,
+		.maxlen		= sizeof(readahead_live_chunk),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+	},
 	{ .ctl_name = 0 }
 };
 
--- linux-2.6.14-mm1.orig/mm/filemap.c
+++ linux-2.6.14-mm1/mm/filemap.c
@@ -1312,6 +1312,13 @@ retry_find:
 		if (ra_pages) {
 			pgoff_t start = 0;
 
+			/*
+			 * Max read-around should be much smaller than
+			 * max read-ahead.
+			 * How about adding a tunable parameter for this?
+			 */
+			if (ra_pages > 64)
+				ra_pages = 64;
 			if (pgoff > ra_pages / 2)
 				start = pgoff - ra_pages / 2;
 			do_page_cache_readahead(mapping, file, start, ra_pages);
--- linux-2.6.14-mm1.orig/mm/readahead.c
+++ linux-2.6.14-mm1/mm/readahead.c
@@ -15,11 +15,29 @@
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
 
-/* The default max/min read-ahead pages. */
+/* The default number of max/min read-ahead pages. */
 #define KB(size)	(((size)*1024 + PAGE_CACHE_SIZE-1) / PAGE_CACHE_SIZE)
 #define MAX_RA_PAGES	KB(VM_MAX_READAHEAD)
 #define MIN_RA_PAGES	KB(VM_MIN_READAHEAD)
 
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
+/* Scan backward ## pages to find a live reader. */
+int readahead_live_chunk = 2 * MAX_RA_PAGES;
+EXPORT_SYMBOL(readahead_live_chunk);
+
 /* Detailed classification of read-ahead behaviors. */
 #define RA_CLASS_SHIFT 3
 #define RA_CLASS_MASK  ((1 << RA_CLASS_SHIFT) - 1)
@@ -771,6 +789,27 @@ out:
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
+	pages = nr_free_inactive();
+	*ra_max = min(min(pages/2, 0xFFFFUL), ra->ra_pages);
+	*ra_min = min(min(MIN_RA_PAGES + (pages>>14), KB(128)), *ra_max/2);
+}
+
+/*
  * This is the entry point of the adaptive read-ahead logic.
  *
  * It is only called on two conditions:

--
