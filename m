Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262092AbVBUTdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbVBUTdj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 14:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVBUTbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 14:31:47 -0500
Received: from galileo.bork.org ([134.117.69.57]:61366 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S262082AbVBUT1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 14:27:21 -0500
Date: Mon, 21 Feb 2005 14:27:21 -0500
From: Martin Hicks <mort@wildopensource.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, raybry@sgi.com
Subject: Re: [PATCH/RFC] A method for clearing out page cache
Message-ID: <20050221192721.GB26705@localhost>
References: <20050214154431.GS26705@localhost> <20050214193704.00d47c9f.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050214193704.00d47c9f.pj@sgi.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I've made a bunch of changes that Paul suggested.  I've also responded
to his concerns further down.  Paul correctly pointed out that this
patch uses some helper functions that are part of the cpusets patch.  I
should have mentioned this before.

The major changes are:

- Cleanup proc_dobitmask_list() a bit more, including adding bounds
  checking on *lenp.

- An important bugfix in vmscan.c around line 390.  Go to the
  keep_locked label, not the "keep" label.

- Add locking in proc_do_toss_page_cache_nodes() to protect the global
  nodemask_t from getting corrupted.

- Change a few functions to "static"

- Paul Jackson's suggested changes to greatly simplify
  proc_do_toss_page_cache_nodes()

The patch is inlined at the end of the mail.


On Mon, Feb 14, 2005 at 07:37:04PM -0800, Paul Jackson wrote:
> 
>   1) A couple of kmalloc's are done using lengths that
>      so far as I could tell, came straight from user land.

Okay, I've stuck in maximums that are based on MAX_NUMNODES.

> 
>   2) Beware that this patch depends on the cpuset patch:
> 	new-bitmap-list-format-for-cpusets.patch
>      which is still in *-mm only, for the routines
>      bitmap_scnlistprintf/bitmap_parselist.

Thanks.  I hadn't realized that.

>   3) Should the maxlen of a nodemask for the sysctl
>      handler for proc_do_toss_page_cache_nodes be the byte
>      length of the kernels internal binary nodemask, or

It is the byte length of the kernel's bitmask struct.

>   5) The requirement to read the string in one read(2) syscall
>      seemed like it might be draconian.  If the available

But that's the way the rest of the sysctl read functions work.  There's
no safe way that I can see to ensure that the data doesn't change in
between two consecutive read calls.

>   9) Comment - dont we need to protect the kernel global variable
>      toss_page_cache_nodes from simulaneous access by two tasks?

yes, I protected this with a semaphore.

mh

-- 
Martin Hicks                Wild Open Source Inc.
mort@wildopensource.com     613-266-2296



This patch introduces a new sysctl for NUMA systems that tries to drop
as much of the page cache as possible from a set of nodes.  The
motivation for this patch is for setting up High Performance Computing
jobs, where initial memory placement is very important to overall
performance.

Signed-off-by: Martin Hicks <mort@wildopensource.com>
Signed-off-by: Ray Bryant <raybry@sgi.com>

[mort@tomahawk patches]$ diffstat toss_page_cache_nodes_v2.patch 
 include/linux/sysctl.h |    3 +
 kernel/sysctl.c        |   95 ++++++++++++++++++++++++++++++++++++++++++++
 mm/vmscan.c            |  105 ++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 201 insertions(+), 2 deletions(-)


Index: linux-2.6.10/include/linux/sysctl.h
===================================================================
--- linux-2.6.10.orig/include/linux/sysctl.h	2005-02-16 12:43:19.000000000 -0800
+++ linux-2.6.10/include/linux/sysctl.h	2005-02-19 10:36:41.000000000 -0800
@@ -170,6 +170,7 @@
 	VM_VFS_CACHE_PRESSURE=26, /* dcache/icache reclaim pressure */
 	VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space layout */
 	VM_SWAP_TOKEN_TIMEOUT=28, /* default time for token time out */
+	VM_TOSS_PAGE_CACHE_NODES=29, /* nodemask_t: nodes to free page cache on */
 };
 
 
@@ -803,6 +804,8 @@
 				  void __user *, size_t *, loff_t *);
 extern int proc_doulongvec_ms_jiffies_minmax(ctl_table *table, int,
 				      struct file *, void __user *, size_t *, loff_t *);
+extern int proc_dobitmap_list(ctl_table *table, int, struct file *,
+			      void __user *, size_t *, loff_t *);
 
 extern int do_sysctl (int __user *name, int nlen,
 		      void __user *oldval, size_t __user *oldlenp,
Index: linux-2.6.10/kernel/sysctl.c
===================================================================
--- linux-2.6.10.orig/kernel/sysctl.c	2005-02-16 12:43:19.000000000 -0800
+++ linux-2.6.10/kernel/sysctl.c	2005-02-21 10:49:18.000000000 -0800
@@ -41,6 +41,8 @@
 #include <linux/limits.h>
 #include <linux/dcache.h>
 #include <linux/syscalls.h>
+#include <linux/bitmap.h>
+#include <linux/nodemask.h>
 
 #include <asm/uaccess.h>
 #include <asm/processor.h>
@@ -72,6 +74,12 @@
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
@@ -836,6 +844,16 @@
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
 
@@ -2071,6 +2089,83 @@
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
+ * If the bitmap is being read by the user process, it is copied
+ * and a newline '\n' is added.  It is truncated if the buffer is
+ * not large enough.
+ *
+ * Returns 0 on success.
+ */
+int proc_dobitmap_list(ctl_table *table, int write, struct file *filp,
+		       void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	char *buf;
+	int retval;
+	int len;
+
+	if (!table->maxlen || !table->data || !*lenp ||
+	    (*ppos && !write)) {
+		*lenp = 0;
+		return 0;
+	}
+
+	if (write) {
+		/* This is a generous upper bound on the size of the
+		 * ascii text input length */
+		if (*lenp > 4*MAX_NUMNODES)
+			return -EMSGSIZE;
+		len = *lenp + 1;
+	} else {
+		len = 4*MAX_NUMNODES;
+	}
+
+	buf = kmalloc(len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	if (write) {
+		if (copy_from_user(buf, buffer, *lenp))
+			return -EFAULT;
+		buf[len] = 0;        /* nul-terminate */
+		retval = bitmap_parselist(buf, (unsigned long *)table->data, 
+					  table->maxlen*sizeof(unsigned long));
+	} else {
+		/* parse the bitmap but leave room for '\n' */
+		len = bitmap_scnlistprintf(buf, len-1,
+				(const unsigned long *) table->data, 
+				table->maxlen*sizeof(unsigned long));
+		/* Insert '\n' if we have something to return */
+		if (len)
+			buf[len++] = '\n';
+		/* the length requested is less than what's available */
+		if (*lenp < len)
+			len = *lenp;
+		if (copy_to_user(buffer, buf, len))
+			return -EFAULT;
+		*ppos += len;
+		*lenp = len;
+		retval = 0;
+	}
+	kfree(buf);
+	return retval;
+}
+
 #else /* CONFIG_PROC_FS */
 
 int proc_dostring(ctl_table *table, int write, struct file *filp,
Index: linux-2.6.10/mm/vmscan.c
===================================================================
--- linux-2.6.10.orig/mm/vmscan.c	2005-02-16 12:43:19.000000000 -0800
+++ linux-2.6.10/mm/vmscan.c	2005-02-21 10:39:36.000000000 -0800
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
+			goto keep_locked;
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
@@ -889,7 +897,98 @@
 		shrink_zone(zone, sc);
 	}
 }
- 
+
+#ifdef CONFIG_NUMA
+/*
+ * Scan this node and release all clean page cache pages
+ */
+static void toss_page_cache_pages_node(int node)
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
+static DECLARE_MUTEX(toss_page_cache_nodes_sem);
+nodemask_t toss_page_cache_nodes;
+static atomic_t num_toss_threads_active;
+
+static int toss_pages_thread(void *arg)
+{
+	int node = (int)(long)arg;
+
+	if (node_online(node))
+		toss_page_cache_pages_node(node);
+	atomic_dec(&num_toss_threads_active);
+	do_exit(0);
+}
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
+	int ret, node;
+
+	down_interruptible(&toss_page_cache_nodes_sem);
+	ret = proc_dobitmap_list(table, write, filep, buffer, lenp, ppos);
+	if (ret < 0)
+		goto done;
+	ret = 0;
+
+	if (!write)
+		goto done;
+
+	/* if no online nodes specified - error */
+	if (!nodes_intersects(toss_page_cache_nodes, node_online_map)) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	/* create kernel threads to go toss the page cache pages */
+	atomic_set(&num_toss_threads_active, 0);
+	for_each_node_mask(node, toss_page_cache_nodes) {
+		if (node_online(node)) {
+			kthread_run(&toss_pages_thread, (void *)(long)node,
+				    "toss_thread");
+			atomic_inc(&num_toss_threads_active);
+		} else {
+			node_clear(node, toss_page_cache_nodes);
+		}
+	}
+
+	/* wait for the kernel threads to complete */
+	while (atomic_read(&num_toss_threads_active) > 0) {
+		__set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(10);
+	}
+done:
+	up(&toss_page_cache_nodes_sem);
+	return ret;
+}
+#endif
+
 /*
  * This is the main entry point to direct page reclaim.
  *
@@ -915,6 +1014,7 @@
 	int i;
 
 	sc.gfp_mask = gfp_mask;
+	sc.may_reclaim_mapped = 1;
 	sc.may_writepage = 0;
 
 	inc_page_state(allocstall);
@@ -1014,6 +1114,7 @@
 	total_scanned = 0;
 	total_reclaimed = 0;
 	sc.gfp_mask = GFP_KERNEL;
+	sc.may_reclaim_mapped = 1;
 	sc.may_writepage = 0;
 	sc.nr_mapped = read_page_state(nr_mapped);
 
