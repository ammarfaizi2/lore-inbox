Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbVBNPov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVBNPov (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 10:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVBNPov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 10:44:51 -0500
Received: from galileo.bork.org ([134.117.69.57]:36037 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S261450AbVBNPob (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 10:44:31 -0500
Date: Mon, 14 Feb 2005 10:44:31 -0500
From: Martin Hicks <mort@wildopensource.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ray Bryant <raybry@sgi.com>
Subject: [PATCH/RFC] A method for clearing out page cache
Message-ID: <20050214154431.GS26705@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This patch introduces a new sysctl for NUMA systems that tries to drop
as much of the page cache as possible from a set of nodes.  The
motivation for this patch is for setting up High Performance Computing
jobs, where initial memory placement is very important to overall
performance.
 
Currently if a job is started and there is page cache lying around on a
particular node then allocations will spill onto remote nodes and page
cache won't be reclaimed until the whole system is short on memory.
This can result in a signficiant performance hit for HPC applications
that planned on that memory being allocated locally.

This patch is intended to be used to clean out the entire page cache before
starting a new job.  Ideally, we would like to only clear as much page
cache as is required to avoid non-local memory allocation.  Patches
to do this can be built on top of this patch, so this patch should
be regarded as the first step in that direction. The long term goal is to
have some mechanism that would better control the page cache (and other
memory caches) for machines that put a higher priority on memory
placement than maintaining big caches.

It allows you to clear page cache on nodes in the following manner:

echo 1,3,9-12 > /proc/sys/vm/toss_page_cache_nodes

The patch was written by Ray Bryant <raybry@sgi.com> and forward ported
by me, Martin Hicks <mort@wildopensource.com>, to 2.6.11-rc3-mm2.

Could we get this included in -mm Andrew?

mh

-- 
Martin Hicks                Wild Open Source Inc.
mort@wildopensource.com     613-266-2296




This patch introduces a new sysctl for NUMA systems that tries to drop
as much of the page cache as possible from a set of nodes.  The
motivation for this patch is for setting up High Performance Computing
jobs, where initial memory placement is very important to overall
performance.

It allows you to clear page cache on nodes in the following manner:

echo 1,3,9-12 > /proc/sys/vm/toss_page_cache_nodes



Signed-off-by: Martin Hicks <mort@wildopensource.com>
Signed-off-by: Ray Bryant <raybry@sgi.com>


[mort@tomahawk patches]$ diffstat toss_page_cache_nodes.patch
 include/linux/sysctl.h |    4 +
 kernel/sysctl.c        |   82 +++++++++++++++++++++++++++++++
 mm/vmscan.c            |  128 ++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 211 insertions(+), 3 deletions(-)


Index: linux-2.6.10/include/linux/sysctl.h
===================================================================
--- linux-2.6.10.orig/include/linux/sysctl.h	2005-02-11 10:54:13.000000000 -0800
+++ linux-2.6.10/include/linux/sysctl.h	2005-02-11 10:54:14.000000000 -0800
@@ -170,6 +170,7 @@
 	VM_VFS_CACHE_PRESSURE=26, /* dcache/icache reclaim pressure */
 	VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space layout */
 	VM_SWAP_TOKEN_TIMEOUT=28, /* default time for token time out */
+	VM_TOSS_PAGE_CACHE_NODES=29, /* nodemask_t: nodes to free page cache on */
 };
 
 
@@ -803,7 +804,8 @@
 				  void __user *, size_t *, loff_t *);
 extern int proc_doulongvec_ms_jiffies_minmax(ctl_table *table, int,
 				      struct file *, void __user *, size_t *, loff_t *);
-
+extern int proc_dobitmap_list(ctl_table *table, int, struct file *,
+			      void __user *, size_t *, loff_t *);
 extern int do_sysctl (int __user *name, int nlen,
 		      void __user *oldval, size_t __user *oldlenp,
 		      void __user *newval, size_t newlen);
Index: linux-2.6.10/kernel/sysctl.c
===================================================================
--- linux-2.6.10.orig/kernel/sysctl.c	2005-02-11 10:54:14.000000000 -0800
+++ linux-2.6.10/kernel/sysctl.c	2005-02-11 10:54:14.000000000 -0800
@@ -41,6 +41,9 @@
 #include <linux/limits.h>
 #include <linux/dcache.h>
 #include <linux/syscalls.h>
+#include <linux/bitmap.h>
+#include <linux/bitops.h>
+#include <linux/nodemask.h>
 
 #include <asm/uaccess.h>
 #include <asm/processor.h>
@@ -72,6 +75,12 @@
 				  void __user *, size_t *, loff_t *);
 #endif
 
+#ifdef CONFIG_NUMA
+extern nodemask_t toss_page_cache_nodes;
+extern int proc_do_toss_page_cache_nodes(ctl_table *, int, struct file *,
+					 void __user *, size_t *, loff_t *);
+#endif
+
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
 static int minolduid;
@@ -836,6 +845,16 @@
 		.strategy	= &sysctl_jiffies,
 	},
 #endif
+#ifdef CONFIG_NUMA
+	{
+		.ctl_name	= VM_TOSS_PAGE_CACHE_NODES,
+		.procname	= "toss_page_cache_nodes",
+		.data		= &toss_page_cache_nodes,
+		.maxlen		= sizeof(nodemask_t),
+		.mode		= 0644,
+		.proc_handler	= &proc_do_toss_page_cache_nodes,
+	},
+#endif
 	{ .ctl_name = 0 }
 };
 
@@ -2071,6 +2090,68 @@
 		    	    do_proc_dointvec_userhz_jiffies_conv,NULL);
 }
 
+/**
+ * proc_dobitmap_list -- read/write a bitmap list in ascii format
+ * @table: the sysctl table
+ * @write: %TRUE if this is a write to the sysctl file
+ * @filp: the file structure
+ * @buffer: the user buffer
+ * @lenp: the size of the user buffer
+ *
+ * Reads/writes a bitmap specified in "list" format.  That is
+ * reads a list of comma separated items, where each item is
+ * either a bit number, or a range of bit numbers separated by
+ * a "-".  E. g., 3,5-12,14.  Converts this to a bitmap where
+ * each of the specified bits is set.
+ *
+ * Restrictions:  user is required to read output string in one
+ * read operation.
+ *
+ * Returns 0 on success (write) or number of chars returned (read)
+ */
+int proc_dobitmap_list(ctl_table *table, int write, struct file *filp,
+		       void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	char *buff;
+	int retval;
+
+	if (write) {
+		if (!table->maxlen || !table->data)
+			return -EPERM;
+		if ((buff = kmalloc(*lenp + 1, GFP_KERNEL)) == 0)
+			return -ENOMEM;
+		if (copy_from_user(buff, buffer, *lenp))
+			return -EFAULT;
+		buff[*lenp] = 0;        /* nul-terminate */
+		retval = bitmap_parselist(buff, (unsigned long *)table->data, 
+					  table->maxlen*8);
+		kfree(buff);
+		return retval;
+	} else {
+		if (!table->maxlen || !table->data)
+			return -EPERM;
+		/* we require the user to read the string in one operation */
+		if (filp->f_pos == 0) {
+			if ((buff = kmalloc(*lenp, GFP_KERNEL)) == 0)
+				return -ENOMEM;
+			retval = bitmap_scnlistprintf(buff, (*lenp)-1, 
+				(const unsigned long *) table->data, 
+						      table->maxlen*8);
+			buff[retval++] = '\n';
+			if (copy_to_user(buffer, buff, retval))
+				return -EFAULT;
+			*lenp = retval;
+			filp->f_pos += retval;
+			kfree(buff);
+			return 0;
+		} else {
+			/* subsequent reads return 0 chars */
+			*lenp = 0;
+			return 0;
+		}
+	}
+}
+
 #else /* CONFIG_PROC_FS */
 
 int proc_dostring(ctl_table *table, int write, struct file *filp,
@@ -2136,7 +2217,6 @@
     return -ENOSYS;
 }
 
-
 #endif /* CONFIG_PROC_FS */
 
 
Index: linux-2.6.10/mm/vmscan.c
===================================================================
--- linux-2.6.10.orig/mm/vmscan.c	2005-02-11 10:54:14.000000000 -0800
+++ linux-2.6.10/mm/vmscan.c	2005-02-11 10:54:14.000000000 -0800
@@ -33,6 +33,8 @@
 #include <linux/cpuset.h>
 #include <linux/notifier.h>
 #include <linux/rwsem.h>
+#include <linux/sysctl.h>
+#include <linux/kthread.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -66,6 +68,9 @@
 	/* How many pages shrink_cache() should reclaim */
 	int nr_to_reclaim;
 
+	/* Can we reclaim mapped pages? */
+	int may_reclaim_mapped;
+
 	/* Ask shrink_caches, or shrink_zone to scan at this priority */
 	unsigned int priority;
 
@@ -384,6 +389,9 @@
 		if (page_mapped(page) || PageSwapCache(page))
 			sc->nr_scanned++;
 
+		if (page_mapped(page) && !sc->may_reclaim_mapped)
+			goto keep;
+
 		if (PageWriteback(page))
 			goto keep_locked;
 
@@ -725,7 +733,7 @@
 	 * Now use this metric to decide whether to start moving mapped memory
 	 * onto the inactive list.
 	 */
-	if (swap_tendency >= 100)
+	if (swap_tendency >= 100 && sc->may_reclaim_mapped)
 		reclaim_mapped = 1;
 
 	while (!list_empty(&l_hold)) {
@@ -889,7 +897,123 @@
 		shrink_zone(zone, sc);
 	}
 }
+
+#ifdef CONFIG_NUMA
+/*
+ * Scan this node and release all clean page cache pages
+ */
+void toss_page_cache_pages_node(int node)
+{
+	int i;
+	struct scan_control sc;
+	struct zone *z;
+
+	sc.gfp_mask = 0;
+	sc.may_reclaim_mapped = 0;
+	sc.priority = DEF_PRIORITY;
+	for (i = 0; i < MAX_NR_ZONES; i++) {
+		z = &NODE_DATA(node)->node_zones[i];
+		if (!z->present_pages)
+			continue;
+		sc.nr_to_scan = z->nr_active + z->nr_inactive;
+		sc.nr_mapped = read_page_state(nr_mapped);
+		sc.nr_scanned = 0;
+		sc.nr_reclaimed = 0;
+
+		refill_inactive_zone(z, &sc);
+		shrink_cache(z, &sc);
+	}
+	return;
+}
+
+static atomic_t toss_done;
+
+int toss_pages_thread(void *arg)
+{
+	int node = (int)(long)arg;
+
+	if (node_online(node))
+		toss_page_cache_pages_node(node);
+	atomic_inc(&toss_done);
+	do_exit(0);
+}
+
+nodemask_t toss_page_cache_nodes = NODE_MASK_NONE;
+
+/*
+ * wrapper routine for proc_dobitmap_list that also calls
+ * toss_page_cache_pages_node() for each node set in bitmap
+ * (when called for a write operation).  Read operations
+ * don't do anything beyond what proc_dobitmap_list() does.
+ */
+int proc_do_toss_page_cache_nodes(ctl_table *table, int write, struct file *filep,
+				  void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	int i, errors=0;
+	int retval, node, started, nodes_to_toss;
+	/*
+	 * grumble.  so many bitmap routines, so many different types,
+	 * such a fussy C-compiler that likes to warn you about these.
+	 */
+	union {
+		volatile void	*vv;
+		const unsigned long *cu;
+	} bitmap;
+
+	retval = proc_dobitmap_list(table, write, filep, buffer, lenp, ppos);
+	if (retval < 0)
+		return retval;
+
+	if (!write)
+		return 0;
+
+	/* do some validity checking */
+	bitmap.vv = (volatile void *) &toss_page_cache_nodes;
+	for (i = 0; i < num_online_nodes(); i++) {
+		if (test_bit(i, bitmap.vv) && !node_online(i)) {
+			errors++;
+			clear_bit(i, bitmap.vv);
+		}
+	}
+	if (num_online_nodes() < MAX_NUMNODES) {
+		for (i = num_online_nodes(); i < MAX_NUMNODES; i++) {
+			if (test_bit(i, bitmap.vv)) {
+				errors++;
+				clear_bit(i, bitmap.vv);
+			}
+		}
+	}
+
+	/* create kernel threads to go toss the page cache pages */
+	atomic_set(&toss_done, 0);
+	nodes_to_toss = bitmap_weight(bitmap.cu, MAX_NUMNODES);
+	started = 0;
+	for (node = find_first_bit(bitmap.cu, MAX_NUMNODES);
+	     node < MAX_NUMNODES;
+	     node = find_next_bit(bitmap.cu, MAX_NUMNODES, node+1)) {
+		kthread_run(&toss_pages_thread, (void *)(long)node,
+			    "toss_thread");
+		started++;
+	}
+
+	/* wait for the kernel threads to complete */
+	while (atomic_read(&toss_done) < nodes_to_toss) {
+		__set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(10);
+	}
  
+	/*
+	 * if user just did "echo 0-31 > /proc/sys/vm/toss_page_cache_nodes"
+	 * but fewer nodes than that exist, there is no good way to get the error
+	 * code back to them anyway, so let the page cache toss occur
+	 * on nodes that do exist and return -EINVAL afterwards.
+	 */
+	if (errors)
+		return -EINVAL;
+	return 0;
+}
+#endif
+
 /*
  * This is the main entry point to direct page reclaim.
  *
@@ -915,6 +1039,7 @@
 	int i;
 
 	sc.gfp_mask = gfp_mask;
+	sc.may_reclaim_mapped = 1;
 	sc.may_writepage = 0;
 
 	inc_page_state(allocstall);
@@ -1014,6 +1139,7 @@
 	total_scanned = 0;
 	total_reclaimed = 0;
 	sc.gfp_mask = GFP_KERNEL;
+	sc.may_reclaim_mapped = 1;
 	sc.may_writepage = 0;
 	sc.nr_mapped = read_page_state(nr_mapped);
 
