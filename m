Return-Path: <linux-kernel-owner+w=401wt.eu-S932153AbXAOJjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbXAOJjx (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 04:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbXAOJjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 04:39:52 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:35332 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932153AbXAOJjw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 04:39:52 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dWJdVwi58+w5fIa5a1oC/AhYEGfDO6CjRd6/TGdgoFVWA+u2DwzMHuWPdDXeQU5gN4XKYy/lHjRyZFIoyLqzwviKWM6bsBew1OSeWHvsjnD+VIFadEpHg0om9p8MCepjYbLIWJNXDmzKQfflAU6AmhVYqxk05GjJJs1VcpMpV/8=
Message-ID: <afe668f90701150139q26e41720lf06d6ee445a917b0@mail.gmail.com>
Date: Mon, 15 Jan 2007 17:39:46 +0800
From: "Roy Huang" <royhuang9@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Provide an interface to limit total page cache.
Cc: aubreylee@gmail.com, nickpiggin@yahoo.com.au, torvalds@osdl.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A patch provide a interface to limit total page cache in
/proc/sys/vm/pagecache_ratio. The default value is 90 percent. Any
feedback is appreciated.

-Roy

diff -urp a/include/linux/pagemap.h b/include/linux/pagemap.h
--- a/include/linux/pagemap.h	2006-11-30 05:57:37.000000000 +0800
+++ b/include/linux/pagemap.h	2007-01-15 17:03:09.000000000 +0800
@@ -12,6 +12,12 @@
 #include <asm/uaccess.h>
 #include <linux/gfp.h>

+extern int pagecache_ratio;
+extern long pagecache_limit;
+
+int pagecache_ratio_sysctl_handler(struct ctl_table *, int,
+			struct file *, void __user *, size_t *, loff_t *);
+
 /*
  * Bits in mapping->flags.  The lower __GFP_BITS_SHIFT bits are the page
  * allocation mode flags.
diff -urp a/include/linux/sysctl.h b/include/linux/sysctl.h
--- a/include/linux/sysctl.h	2007-01-15 17:18:46.000000000 +0800
+++ b/include/linux/sysctl.h	2007-01-15 17:03:09.000000000 +0800
@@ -202,6 +202,7 @@ enum
 	VM_PANIC_ON_OOM=33,	/* panic at out-of-memory */
 	VM_VDSO_ENABLED=34,	/* map VDSO into new processes? */
 	VM_MIN_SLAB=35,		 /* Percent pages ignored by zone reclaim */
+	VM_PAGECACHE_RATIO=36,  /* Percent memory is used as page cache */
 };


diff -urp a/kernel/sysctl.c b/kernel/sysctl.c
--- a/kernel/sysctl.c	2007-01-15 17:18:46.000000000 +0800
+++ b/kernel/sysctl.c	2007-01-15 17:03:09.000000000 +0800
@@ -1035,6 +1035,15 @@ static ctl_table vm_table[] = {
 		.extra1		= &zero,
 	},
 #endif
+	{
+		.ctl_name	= VM_PAGECACHE_RATIO,
+		.procname	= "pagecache_ratio",
+		.data		= &pagecache_ratio,
+		.maxlen		= sizeof(pagecache_ratio),
+		.mode		= 0644,
+		.proc_handler	= &pagecache_ratio_sysctl_handler,
+		.strategy	= &sysctl_intvec,
+	},
 	{ .ctl_name = 0 }
 };

diff -urp a/mm/filemap.c b/mm/filemap.c
--- a/mm/filemap.c	2007-01-15 17:18:46.000000000 +0800
+++ b/mm/filemap.c	2007-01-15 17:03:09.000000000 +0800
@@ -30,6 +30,7 @@
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/cpuset.h>
+#include <linux/sysctl.h>
 #include "filemap.h"
 #include "internal.h"

@@ -108,6 +109,48 @@ generic_file_direct_IO(int rw, struct ki
  */

 /*
+ * Start release pagecache (via kswapd) at the percentage.
+ */
+int pagecache_ratio __read_mostly = 90;
+
+long pagecache_limit = 0;
+
+int setup_pagecache_limit(void)
+{
+	pagecache_limit = pagecache_ratio * nr_free_pagecache_pages() / 100;
+	return 0;
+}
+
+int pagecache_ratio_sysctl_handler(ctl_table *table, int write,
+	struct file *file, void __user *buffer, size_t *length, loff_t *ppos)
+{
+	proc_dointvec_minmax(table, write, file, buffer, length, ppos);
+	setup_pagecache_limit();
+	return 0;
+}
+
+static inline int balance_pagecache(void)
+{
+	if (global_page_state(NR_FILE_PAGES) > pagecache_limit) {
+		int nid, j;
+		pg_data_t *pgdat;
+		struct zone *zone;
+
+		for_each_online_node(nid) {
+			pgdat = NODE_DATA(nid);
+			for (j = 0; j < MAX_NR_ZONES; j++) {
+				zone = pgdat->node_zones + j;
+				wakeup_kswapd(zone, 0);
+			}
+		}
+	}
+
+	return 0;
+}
+
+module_init(setup_pagecache_limit)
+
+/*
  * Remove a page from the page cache and free it. Caller has to make
  * sure the page is locked and that nobody else uses it - or that usage
  * is safe.  The caller must hold a write_lock on the mapping's tree_lock.
@@ -1085,6 +1128,8 @@ out:
 		page_cache_release(cached_page);
 	if (filp)
 		file_accessed(filp);
+
+	balance_pagecache();
 }
 EXPORT_SYMBOL(do_generic_mapping_read);

@@ -2212,6 +2257,8 @@ zero_length_segment:
 		status = filemap_write_and_wait(mapping);

 	pagevec_lru_add(&lru_pvec);
+	balance_pagecache();
+
 	return written ? written : status;
 }
 EXPORT_SYMBOL(generic_file_buffered_write);
diff -urp a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c	2007-01-15 17:18:46.000000000 +0800
+++ b/mm/vmscan.c	2007-01-15 17:03:09.000000000 +0800
@@ -1316,6 +1316,7 @@ static int kswapd(void *p)
 	order = 0;
 	for ( ; ; ) {
 		unsigned long new_order;
+		long over_limit;

 		try_to_freeze();

@@ -1335,6 +1336,9 @@ static int kswapd(void *p)
 		finish_wait(&pgdat->kswapd_wait, &wait);

 		balance_pgdat(pgdat, order);
+		over_limit = global_page_state(NR_FILE_PAGES) - pagecache_limit;
+		if (over_limit > 0)
+			shrink_all_memory(over_limit);
 	}
 	return 0;
 }
@@ -1350,8 +1354,10 @@ void wakeup_kswapd(struct zone *zone, in
 		return;

 	pgdat = zone->zone_pgdat;
-	if (zone_watermark_ok(zone, order, zone->pages_low, 0, 0))
-		return;
+	if (zone_watermark_ok(zone, order, zone->pages_low, 0, 0)) {
+		if (global_page_state(NR_FILE_PAGES) < pagecache_limit)
+			return;
+	}
 	if (pgdat->kswapd_max_order < order)
 		pgdat->kswapd_max_order = order;
 	if (!cpuset_zone_allowed_hardwall(zone, GFP_KERNEL))
@@ -1361,7 +1367,6 @@ void wakeup_kswapd(struct zone *zone, in
 	wake_up_interruptible(&pgdat->kswapd_wait);
 }

-#ifdef CONFIG_PM
 /*
  * Helper function for shrink_all_memory().  Tries to reclaim 'nr_pages' pages
  * from LRU lists system-wide, for given pass and priority, and returns the
@@ -1510,7 +1515,6 @@ out:

 	return ret;
 }
-#endif

 /* It's optimal to keep kswapds on the same CPUs as their memory, but
    not required for correctness.  So if the last cpu in a node goes
