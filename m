Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbVBODiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbVBODiU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 22:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbVBODiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 22:38:20 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:8933 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261611AbVBODhe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 22:37:34 -0500
Date: Mon, 14 Feb 2005 19:37:04 -0800
From: Paul Jackson <pj@sgi.com>
To: Martin Hicks <mort@wildopensource.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, raybry@sgi.com
Subject: Re: [PATCH/RFC] A method for clearing out page cache
Message-Id: <20050214193704.00d47c9f.pj@sgi.com>
In-Reply-To: <20050214154431.GS26705@localhost>
References: <20050214154431.GS26705@localhost>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Questions concerning this page cache patch that Martin submitted,
as a merge of something originally written by Ray Bryant.

The following patch is not really a patch.  It is a few questions, a
couple minor space tweaks, and a never compiled nor tested rewrite of
proc_do_toss_page_cache_nodes() to try to make it look a little
prettier.

Some of the issues are cosmetic, but some I suspect warrant competent
response by Martin or Ray, before this goes into *-mm, such as some
questions as to whether locking is adequate, or a kmalloc() size might
be forced huge by the user.  And my suggested rewrite changes the kernel
API in one error case, so better to decide that matter before it is
too widely used.

Specifically:

  1) A couple of kmalloc's are done using lengths that
     so far as I could tell, came straight from user land.
     Never let the user size a kernel malloc without limit,
     as it makes it way too easy to ask for something huge,
     and give the kernel indigestion.  If the lengths in
     question are actually limited, then nevermind (or comment
     in a terse one-liner, for worry warts such as myself).

  2) Beware that this patch depends on the cpuset patch:
	new-bitmap-list-format-for-cpusets.patch
     which is still in *-mm only, for the routines
     bitmap_scnlistprintf/bitmap_parselist.

  3) Should the maxlen of a nodemask for the sysctl
     handler for proc_do_toss_page_cache_nodes be the byte
     length of the kernels internal binary nodemask, or
     a reasonable upper bound on the max length of the
     ascii representation thereof, which is about the value:
		100 + 6 * MAX_NUMNODES
     when using the bitmap_scnlistprintf/bitmap_parselist
     format.

  4) A couple of existing blank lines were nuked by this
     patch - I restored them.  I though them to be nice blank lines ;).

  5) The requirement to read the string in one read(2) syscall
     seemed like it might be draconian.  If the available
     apparatus supports it, better to allocate the ascii buffer
     on the open for read, let the reads (and seeks) feast on
     that buffer, using f_pos as it should be used, and freeing
     the buffer on the close.  Mind you, I have no idea if the
     sysctl.c apparatus conveniently supports this.

  6) The kernel header bitops.h is no longer needed by sysctl.c,
     following my (uncompiled, untested) rewrite.

  7) Instead of two counters to track how many threads remained
     to be waited for, toss_done and nodes_to_toss, my rewrite
     just has one: num_toss_threads_active.  It bumps that value
     once each kthread it starts, decrements it as each thread
     finishes, and waits for it to get back to zero in the loop.

  8) Several changes in the rewrite of proc_do_toss_page_cache_nodes():
	- rename 'retval' to 'ret' (more common, shorter)
	- nuke bitmap and use nodemask routines
	- dont error if some nodes offline (general idea is to
	    either do something useful and claim success, or do
	    nothing at all, and complain of error, but dont both
	    do something useful and complain.)
	- convert to a single return, at bottom of function
	- XXX Comment: doesn't this code require locking node_online_map?
	- Remove unused 'started'
	- Remove no longer used 'i'
	- Remove no longer used 'errors'
	- Replace 3 line bitop for loop with one line for_each_node_mask
	- Replace 15 lines of 'validity checking' with one line check
	  for node being online

  9) Comment - dont we need to protect the kernel global variable
     toss_page_cache_nodes from simulaneous access by two tasks?

Index: 2.6.11-rc4/include/linux/sysctl.h
===================================================================
--- 2.6.11-rc4.orig/include/linux/sysctl.h	2005-02-14 18:26:28.000000000 -0800
+++ 2.6.11-rc4/include/linux/sysctl.h	2005-02-14 18:27:31.000000000 -0800
@@ -803,6 +803,7 @@ extern int proc_doulongvec_ms_jiffies_mi
 				      struct file *, void __user *, size_t *, loff_t *);
 extern int proc_dobitmap_list(ctl_table *table, int, struct file *,
 			      void __user *, size_t *, loff_t *);
+
 extern int do_sysctl (int __user *name, int nlen,
 		      void __user *oldval, size_t __user *oldlenp,
 		      void __user *newval, size_t newlen);
Index: 2.6.11-rc4/kernel/sysctl.c
===================================================================
--- 2.6.11-rc4.orig/kernel/sysctl.c	2005-02-14 18:26:28.000000000 -0800
+++ 2.6.11-rc4/kernel/sysctl.c	2005-02-14 18:27:46.000000000 -0800
@@ -42,7 +42,6 @@
 #include <linux/dcache.h>
 #include <linux/syscalls.h>
 #include <linux/bitmap.h>
-#include <linux/bitops.h>
 #include <linux/nodemask.h>
 
 #include <asm/uaccess.h>
@@ -839,6 +838,8 @@ static ctl_table vm_table[] = {
 		.ctl_name	= VM_TOSS_PAGE_CACHE_NODES,
 		.procname	= "toss_page_cache_nodes",
 		.data		= &toss_page_cache_nodes,
+/* XXX Should this be the length of the binary nodemask,
+   or of its ascii representation? */
 		.maxlen		= sizeof(nodemask_t),
 		.mode		= 0644,
 		.proc_handler	= &proc_do_toss_page_cache_nodes,
@@ -1993,6 +1994,9 @@ int proc_dobitmap_list(ctl_table *table,
 	if (write) {
 		if (!table->maxlen || !table->data)
 			return -EPERM;
+/* XXX If this *lenp is direct from user space, it needs to be
+ * bounded to avoid a denial of service attack - asking for
+ * a huge buffer. */
 		if ((buff = kmalloc(*lenp + 1, GFP_KERNEL)) == 0)
 			return -ENOMEM;
 		if (copy_from_user(buff, buffer, *lenp))
@@ -2005,8 +2009,14 @@ int proc_dobitmap_list(ctl_table *table,
 	} else {
 		if (!table->maxlen || !table->data)
 			return -EPERM;
+/* XXX The following requirement seems draconian.  Shouldn't this
+ * buffer be allocated on the open, read using normal f_pos
+ * arithmetic, and free'd on the close? */
 		/* we require the user to read the string in one operation */
 		if (filp->f_pos == 0) {
+/* XXX If this *lenp is direct from user space, it needs to be
+ * bounded to avoid a denial of service attack - asking for
+ * a huge buffer. */
 			if ((buff = kmalloc(*lenp, GFP_KERNEL)) == 0)
 				return -ENOMEM;
 			retval = bitmap_scnlistprintf(buff, (*lenp)-1, 
@@ -2085,6 +2095,7 @@ int proc_doulongvec_ms_jiffies_minmax(ct
     return -ENOSYS;
 }
 
+
 #endif /* CONFIG_PROC_FS */
 
 
Index: 2.6.11-rc4/mm/vmscan.c
===================================================================
--- 2.6.11-rc4.orig/mm/vmscan.c	2005-02-14 18:26:28.000000000 -0800
+++ 2.6.11-rc4/mm/vmscan.c	2005-02-14 18:41:07.000000000 -0800
@@ -904,7 +904,7 @@ void toss_page_cache_pages_node(int node
 	return;
 }
 
-static atomic_t toss_done;
+static atomic_t num_toss_threads_active;
 
 int toss_pages_thread(void *arg)
 {
@@ -912,10 +912,11 @@ int toss_pages_thread(void *arg)
 
 	if (node_online(node))
 		toss_page_cache_pages_node(node);
-	atomic_inc(&toss_done);
+	atomic_dec(&num_toss_threads_active);
 	do_exit(0);
 }
 
+/* XXX What protects toss_page_cache_nodes from simultaneous access? */
 nodemask_t toss_page_cache_nodes = NODE_MASK_NONE;
 
 /*
@@ -927,68 +928,39 @@ nodemask_t toss_page_cache_nodes = NODE_
 int proc_do_toss_page_cache_nodes(ctl_table *table, int write, struct file *filep,
 				  void __user *buffer, size_t *lenp, loff_t *ppos)
 {
-	int i, errors=0;
-	int retval, node, started, nodes_to_toss;
-	/*
-	 * grumble.  so many bitmap routines, so many different types,
-	 * such a fussy C-compiler that likes to warn you about these.
-	 */
-	union {
-		volatile void	*vv;
-		const unsigned long *cu;
-	} bitmap;
-
-	retval = proc_dobitmap_list(table, write, filep, buffer, lenp, ppos);
-	if (retval < 0)
-		return retval;
+	int ret, node;
+
+	ret = proc_dobitmap_list(table, write, filep, buffer, lenp, ppos);
+	if (ret < 0)
+		goto done;
+	ret = 0;
 
 	if (!write)
-		return 0;
+		goto done;
 
-	/* do some validity checking */
-	bitmap.vv = (volatile void *) &toss_page_cache_nodes;
-	for (i = 0; i < num_online_nodes(); i++) {
-		if (test_bit(i, bitmap.vv) && !node_online(i)) {
-			errors++;
-			clear_bit(i, bitmap.vv);
-		}
-	}
-	if (num_online_nodes() < MAX_NUMNODES) {
-		for (i = num_online_nodes(); i < MAX_NUMNODES; i++) {
-			if (test_bit(i, bitmap.vv)) {
-				errors++;
-				clear_bit(i, bitmap.vv);
-			}
-		}
+/* XXX Dont we need to lock node_online_map here somehow? */
+	/* if no online nodes specified - error */
+	if (!nodes_intersect(toss_page_cache_nodes, node_online_map)) {
+		ret = -EINVAL;
+		goto done;
 	}
 
 	/* create kernel threads to go toss the page cache pages */
-	atomic_set(&toss_done, 0);
-	nodes_to_toss = bitmap_weight(bitmap.cu, MAX_NUMNODES);
-	started = 0;
-	for (node = find_first_bit(bitmap.cu, MAX_NUMNODES);
-	     node < MAX_NUMNODES;
-	     node = find_next_bit(bitmap.cu, MAX_NUMNODES, node+1)) {
-		kthread_run(&toss_pages_thread, (void *)(long)node,
-			    "toss_thread");
-		started++;
+	atomic_set(&num_toss_threads_active, 0);
+	for_each_node_mask(node, toss_page_cache_nodes) {
+		if (node_online(node)) {
+			kthread_run(&toss_pages_thread, node, "toss_thread");
+			atomic_inc(&num_toss_threads_active);
+		}
 	}
 
 	/* wait for the kernel threads to complete */
-	while (atomic_read(&toss_done) < nodes_to_toss) {
+	while (atomic_read(&num_toss_threads_active) > 0) {
 		__set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(10);
 	}
- 
-	/*
-	 * if user just did "echo 0-31 > /proc/sys/vm/toss_page_cache_nodes"
-	 * but fewer nodes than that exist, there is no good way to get the error
-	 * code back to them anyway, so let the page cache toss occur
-	 * on nodes that do exist and return -EINVAL afterwards.
-	 */
-	if (errors)
-		return -EINVAL;
-	return 0;
+done:
+	return ret;
 }
 #endif
 


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
