Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264010AbSJ3GKT>; Wed, 30 Oct 2002 01:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264021AbSJ3GKT>; Wed, 30 Oct 2002 01:10:19 -0500
Received: from air-2.osdl.org ([65.172.181.6]:37312 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S264010AbSJ3GKQ>;
	Wed, 30 Oct 2002 01:10:16 -0500
Date: Tue, 29 Oct 2002 22:12:59 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Christoph Hellwig <hch@infradead.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] use seq_file for /proc/swaps
In-Reply-To: <20021029121319.A19590@infradead.org>
Message-ID: <Pine.LNX.4.33L2.0210292145270.16850-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2002, Christoph Hellwig wrote:

| On Mon, Oct 28, 2002 at 09:36:44PM -0800, Randy.Dunlap wrote:
| >
| > Hi,
| >
| > This patch to 2.5.44 converts /proc/swaps to use seq_file.
| >
| > It's basically the same patch that I posted a few days ago
| > with locking added [using swap_list_lock() and
| > swap_list_unlock(), as directed by Al].
| >
| > Any comments on this version?
|
| Looks fine.  Any chance you could move proc_swaps_operations and
| the entry creating to swapfile.c so when uclinux makes this file
| conditional on CONFIG_SWAP we don't need ifdefs in proc_misc.c?

Are you and/or Greg U. going to do a CONFIG_SWAP option?

Sure, some (small) chance of moving it.  I just tried that exercise,
and the results aren't very interesting, at least not to me, and
here's why.

I moved the proc_swaps_operations to swapfile.c like you asked.
I like that part of this patch.
But it makes more sense to me to move the create_seq_entry() call
to mm/swap.c:: in its __init swap_setup() function
(or add another __init function in swapfile.c to do this ?).
That meant that I had to duplicate create_seq_entry() or
export it.  For now I have duplicated it, and that would make
3 copies of it in the kernel -- and that's bad IMO, so it would
need to be exported (but I didn't do that for now).

And then there's the issue of do we want to keep the
/proc misc entries closely located (in source code) or not...
I kinda like having them in one place.

And there's the question of __init ordering: when will the __init
function mm/swap.c::swap_setup(), calling create_seq_entry(),
happen in relation to create_proc_entry() being ready to work?
I.e., is there a chance that create_seq_entry() could fail
even though it shouldn't?  This should be solvable by using
initcall levels (subsystem levels), but I didn't look closely
at that yet.

So yeah, it's do-able.  I just don't see that it's worth it.

Patch below (to previous patch, which is already in BK) compiles.
Not tested.

-- 
~Randy




--- ./fs/proc/proc_misc.c%swap2	Mon Oct 21 20:11:48 2002
+++ ./fs/proc/proc_misc.c	Tue Oct 29 20:17:11 2002
@@ -295,18 +295,6 @@
 	.release	= seq_release,
 };

-extern struct seq_operations swaps_op;
-static int swaps_open(struct inode *inode, struct file *file)
-{
-	return seq_open(file, &swaps_op);
-}
-static struct file_operations proc_swaps_operations = {
-	.open		= swaps_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
 #ifdef CONFIG_MODULES
 extern struct seq_operations modules_op;
 static int modules_open(struct inode *inode, struct file *file)
@@ -636,7 +624,6 @@
 		entry->proc_fops = &proc_kmsg_operations;
 	create_seq_entry("cpuinfo", 0, &proc_cpuinfo_operations);
 	create_seq_entry("partitions", 0, &proc_partitions_operations);
-	create_seq_entry("swaps", 0, &proc_swaps_operations);
 #if !defined(CONFIG_ARCH_S390)
 	create_seq_entry("interrupts", 0, &proc_interrupts_operations);
 #endif
--- ./mm/swapfile.c%swap2	Mon Oct 28 20:56:06 2002
+++ ./mm/swapfile.c	Tue Oct 29 20:38:18 2002
@@ -6,6 +6,7 @@
  */

 #include <linux/config.h>
+#include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/kernel_stat.h>
@@ -1127,6 +1128,18 @@
 	.stop =		swap_stop,
 	.show =		swap_show
 };
+
+static int swaps_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &swaps_op);
+}
+struct file_operations proc_swaps_operations = {
+	.open		= swaps_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+EXPORT_SYMBOL(proc_swaps_operations);
 #endif

 /*
--- ./mm/swap.c%swap2	Fri Oct 18 21:01:49 2002
+++ ./mm/swap.c	Tue Oct 29 20:36:53 2002
@@ -13,6 +13,7 @@
  * Buffermem limits added 12.3.98, Rik van Riel.
  */

+#include <linux/config.h>
 #include <linux/mm.h>
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
@@ -22,6 +23,7 @@
 #include <linux/mm_inline.h>
 #include <linux/buffer_head.h>
 #include <linux/prefetch.h>
+#include <linux/proc_fs.h>

 /* How many pages do we try to swap or page in/out together? */
 int page_cluster;
@@ -269,6 +271,18 @@
 	return pagevec_count(pvec);
 }

+#ifdef CONFIG_PROC_FS
+static void __init create_seq_entry(char *name, mode_t mode, struct file_operations *f)
+{
+	struct proc_dir_entry *entry;
+	entry = create_proc_entry(name, mode, NULL);
+	if (entry)
+		entry->proc_fops = f;
+}
+
+extern struct file_operations proc_swaps_operations;
+#endif
+
 /*
  * Perform any setup for the swap system
  */
@@ -285,4 +299,7 @@
 	 * Right now other parts of the system means that we
 	 * _really_ don't want to cluster much more
 	 */
+#ifdef CONFIG_PROC_FS
+	create_seq_entry("swaps", 0, &proc_swaps_operations);
+#endif
 }
--- ./mm/Makefile%swap2	Fri Oct 18 21:02:00 2002
+++ ./mm/Makefile	Tue Oct 29 20:39:20 2002
@@ -2,7 +2,8 @@
 # Makefile for the linux memory manager.
 #

-export-objs := shmem.o filemap.o mempool.o page_alloc.o page-writeback.o
+export-objs := shmem.o filemap.o mempool.o page_alloc.o page-writeback.o \
+		swapfile.o

 obj-y	 := memory.o mmap.o filemap.o mprotect.o mlock.o mremap.o \
 	    vmalloc.o slab.o bootmem.o swap.o vmscan.o page_io.o \

