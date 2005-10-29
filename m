Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbVJ2Fs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbVJ2Fs2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 01:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbVJ2FsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 01:48:07 -0400
Received: from ns.ustc.edu.cn ([202.38.64.1]:31115 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751340AbVJ2Fr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 01:47:29 -0400
Message-Id: <20051029060240.373342000@localhost.localdomain>
References: <20051029060216.159380000@localhost.localdomain>
Date: Sat, 29 Oct 2005 14:02:23 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 07/13] readahead: tunable parameters
Content-Disposition: inline; filename=readahead-parameter.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- new entry in /proc/sys/vm/readahead_ratio;
- limit loopdev file read-ahead size to 32kb;
- limit mmap read-around size to 256kb;
- dynamic read-ahead min/max bound.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 Documentation/sysctl/vm.txt |   14 ++++++++++++++
 drivers/block/loop.c        |    5 +++++
 include/linux/mm.h          |    5 ++++-
 include/linux/sysctl.h      |    1 +
 kernel/sysctl.c             |   11 +++++++++++
 mm/filemap.c                |    7 +++++++
 mm/readahead.c              |   31 +++++++++++++++++++++++++++++++
 7 files changed, 73 insertions(+), 1 deletion(-)

--- linux-2.6.14-rc5-mm1.orig/Documentation/sysctl/vm.txt
+++ linux-2.6.14-rc5-mm1/Documentation/sysctl/vm.txt
@@ -27,6 +27,7 @@ Currently, these files are in /proc/sys/
 - laptop_mode
 - block_dump
 - swap_prefetch
+- readahead_ratio
 
 ==============================================================
 
@@ -114,3 +115,16 @@ except when laptop_mode is enabled and t
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
+_future_ read-ahead request size. So you should set it to a low
+value if you have not enough memory to counteract the I/O load
+fluctuation.
+
+The default value is 50.
--- linux-2.6.14-rc5-mm1.orig/include/linux/mm.h
+++ linux-2.6.14-rc5-mm1/include/linux/mm.h
@@ -927,11 +927,14 @@ extern int filemap_populate(struct vm_ar
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
 			unsigned long offset, unsigned long nr_to_read);
 int force_page_cache_readahead(struct address_space *mapping, struct file *filp,
--- linux-2.6.14-rc5-mm1.orig/include/linux/sysctl.h
+++ linux-2.6.14-rc5-mm1/include/linux/sysctl.h
@@ -182,6 +182,7 @@ enum
 	VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space layout */
 	VM_SWAP_TOKEN_TIMEOUT=28, /* default time for token time out */
 	VM_SWAP_PREFETCH=29,	/* int: amount to swap prefetch */
+	VM_READAHEAD_RATIO=30, /* percent of read-ahead size to thrashing-threshold */
 };
 
 
--- linux-2.6.14-rc5-mm1.orig/kernel/sysctl.c
+++ linux-2.6.14-rc5-mm1/kernel/sysctl.c
@@ -67,6 +67,7 @@ extern int min_free_kbytes;
 extern int printk_ratelimit_jiffies;
 extern int printk_ratelimit_burst;
 extern int pid_max_min, pid_max_max;
+extern int readahead_ratio;
 
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 int unknown_nmi_panic;
@@ -869,6 +870,16 @@ static ctl_table vm_table[] = {
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
 	{ .ctl_name = 0 }
 };
 
--- linux-2.6.14-rc5-mm1.orig/drivers/block/loop.c
+++ linux-2.6.14-rc5-mm1/drivers/block/loop.c
@@ -768,6 +768,11 @@ static int loop_set_fd(struct loop_devic
 
 	mapping = file->f_mapping;
 	inode = mapping->host;
+	/*
+	 * The upper layer should already do proper read-ahead,
+	 * unlimited read-ahead here only ruins the cache hit rate.
+	 */
+	file->f_ra.ra_pages = 32 >> (PAGE_CACHE_SHIFT - 10);
 
 	if (!(file->f_mode & FMODE_WRITE))
 		lo_flags |= LO_FLAGS_READ_ONLY;
--- linux-2.6.14-rc5-mm1.orig/mm/filemap.c
+++ linux-2.6.14-rc5-mm1/mm/filemap.c
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
--- linux-2.6.14-rc5-mm1.orig/mm/readahead.c
+++ linux-2.6.14-rc5-mm1/mm/readahead.c
@@ -15,6 +15,13 @@
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
 
+/* Set look-ahead size to 1/8 of the thrashing-threshold. */
+#define LOOKAHEAD_RATIO 8
+
+/* Set read-ahead size to ##% of the thrashing-threshold. */
+int readahead_ratio = 0;
+EXPORT_SYMBOL(readahead_ratio);
+
 /* Detailed classification of read-ahead behaviors. */
 #define RA_CLASS_SHIFT 3
 #define RA_CLASS_MASK  ((1 << RA_CLASS_SHIFT) - 1)
@@ -742,6 +749,30 @@ out:
 }
 
 /*
+ * ra_size is mainly determined by:
+ * 1. sequential-start: min(KB(16 + mem_mb/16), KB(64))
+ * 2. sequential-max:	min(KB(64 + mem_mb*64), KB(2048))
+ * 3. sequential:	(thrashing-threshold) * readahead_ratio / 100
+ *
+ * Table of concrete numbers for 4KB page size:
+ *  (inactive + free) (in MB):    4   8   16   32   64  128  256  512 1024
+ *    initial ra_size (in KB):   16  16   16   16   20   24   32   48   64
+ *	  max ra_size (in KB):  320 576 1088 2048 2048 2048 2048 2048 2048
+ */
+static inline void get_readahead_bounds(struct file_ra_state *ra,
+					unsigned long *ra_min,
+					unsigned long *ra_max)
+{
+	unsigned long mem_mb;
+
+#define KB(size)	(((size) * 1024) / PAGE_CACHE_SIZE)
+	mem_mb = nr_free_inactive() * PAGE_CACHE_SIZE / 1024 / 1024;
+	*ra_max = min(min(KB(64 + mem_mb*64), KB(2048)), ra->ra_pages);
+	*ra_min = min(min(KB(VM_MIN_READAHEAD + mem_mb/16), KB(128)), *ra_max/2);
+#undef KB
+}
+
+/*
  * This is the entry point of the adaptive read-ahead logic.
  *
  * It is only called on two conditions:

--
