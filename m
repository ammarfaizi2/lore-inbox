Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbVLMThp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbVLMThp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 14:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbVLMTho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 14:37:44 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:58965
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S932246AbVLMTho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 14:37:44 -0500
Date: Tue, 13 Dec 2005 20:37:35 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Hugh Dickins <hugh@veritas.com>
Subject: smp race fix between invalidate_inode_pages* and do_no_page
Message-ID: <20051213193735.GE3092@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to the debugging checks in the sles9 kernel (wrongly removed by
somebody while integrating the objrmap/anon-vma code into mainline) I
identified a race condition between the pagecache invalidate and
do_no_page.

A similar race condition existed with truncate too, and it was fixed by
relaying on the i_size shrinking first with proper memory barriers.

But with the cache invalidates (including the old cache invalidates,
before I added the more aggressive invalidate_inode_pages2 for O_DIRECT)
the i_size doesn't shrink. So we can end up with stale contents mapped
in userland with page->mapping = NULL. The page_mapped check before
removing the page from the pagecache is worthless without my fix because
do_no_page may be running from under us.

I resurrected at least one warn-on in mainline that should allow
catching those conditions. I had two bugons triggering in sles9, one is
this one that I resurrected, the other one was in objrmap. It was
triggering the first that noticed the problem depending on the timings.

The basic issue is that locking down the page is totally useless to
block do_no_page, do_no_page will find the page in the cache regardless
of the page lock and it will map it in the address space of the task
while remove_from_page_cache is running.

To fix the smp race without being able to use the i_size shrinking on
truncate side and being read on the ->nopage side, I added a new data
structure that tracks if invalidates are being run under us. It's the
same as the seqlock but it allows scheduling inside the write critical
section. So I called it seqschedlock.

The patch is untested (I only checked it boots) and it will be tested
soon in the real world scenario that triggered the race condition, but
in the meantime I'd like to hear comments about this approach or if
you've ideas on simpler way to fix it.

Clearly taking the page lock in do_no_page would fix it too, but it
would destroy the scalability of page faults. The seqschedlock instead
is 100% smp scalable in the fast path (exactly like RCU and seqlocks),
and it's lightweight in the write path too and it doesn't introducing
latencies in freeing memory.

My main concern is the yield() instead of a waitqueue but perhaps that
can be improved somehow (I didn't think much about it yet). Not sure if
a waitqueue would be better off inside or outside the seqschedlock, but
I believe these are secondary matters, in practice it should never
trigger.

One could argue that it's not a bug if an invalidate leaves stale
orhpaned pagecache mapped in userspace but I believe it's a bug or at
the very least it breaks Andrew's efforts to make O_DIRECT fully
coherency at the mmap level. It's true the very single racy page fault
that happens at the same time of O_DIRECT deserves to see the old data,
but all the following ones (once the read/write O_DIRECT call returned)
definitely should not see the old data anymore. So either we give up on
trying to make invalidate_inode_pages2 mmap coherent (and we resurrect
my code that only cleared the uptodate bitflag and we allow
not-up-to-date pages to be mapped in userland) or we should fix this
race too IMHO (this way or in some other way).

Thanks!

Signed-off-by: Andrea Arcangeli <andrea@suse.de>

diff -r 48eb6d55cbd3 fs/inode.c
--- a/fs/inode.c	Tue Dec 13 08:48:29 2005 +0800
+++ b/fs/inode.c	Tue Dec 13 20:30:19 2005 +0100
@@ -197,6 +197,7 @@
 	INIT_RADIX_TREE(&inode->i_data.page_tree, GFP_ATOMIC);
 	rwlock_init(&inode->i_data.tree_lock);
 	spin_lock_init(&inode->i_data.i_mmap_lock);
+	seqschedlock_init(&inode->i_data.invalidate_lock);
 	INIT_LIST_HEAD(&inode->i_data.private_list);
 	spin_lock_init(&inode->i_data.private_lock);
 	INIT_RAW_PRIO_TREE_ROOT(&inode->i_data.i_mmap);
diff -r 48eb6d55cbd3 include/linux/fs.h
--- a/include/linux/fs.h	Tue Dec 13 08:48:29 2005 +0800
+++ b/include/linux/fs.h	Tue Dec 13 20:30:19 2005 +0100
@@ -10,6 +10,7 @@
 #include <linux/limits.h>
 #include <linux/ioctl.h>
 #include <linux/rcuref.h>
+#include <linux/seqschedlock.h>
 
 /*
  * It's silly to have NR_OPEN bigger than NR_FILE, but you can change
@@ -349,6 +350,7 @@
 	struct list_head	i_mmap_nonlinear;/*list VM_NONLINEAR mappings */
 	spinlock_t		i_mmap_lock;	/* protect tree, count, list */
 	unsigned int		truncate_count;	/* Cover race condition with truncate */
+	seqschedlock_t		invalidate_lock;/* Cover race condition between ->nopage and invalidate_inode_pages2 */
 	unsigned long		nrpages;	/* number of total pages */
 	pgoff_t			writeback_index;/* writeback starts here */
 	struct address_space_operations *a_ops;	/* methods */
diff -r 48eb6d55cbd3 mm/filemap.c
--- a/mm/filemap.c	Tue Dec 13 08:48:29 2005 +0800
+++ b/mm/filemap.c	Tue Dec 13 20:30:19 2005 +0100
@@ -116,6 +116,9 @@
 	page->mapping = NULL;
 	mapping->nrpages--;
 	pagecache_acct(-1);
+
+	/* mapped pagecache can't be dropped! */
+	WARN_ON(page_mapped(page) && !PageSwapCache(page));
 }
 
 void remove_from_page_cache(struct page *page)
diff -r 48eb6d55cbd3 mm/memory.c
--- a/mm/memory.c	Tue Dec 13 08:48:29 2005 +0800
+++ b/mm/memory.c	Tue Dec 13 20:30:19 2005 +0100
@@ -2006,6 +2006,7 @@
 	struct address_space *mapping = NULL;
 	pte_t entry;
 	unsigned int sequence = 0;
+	unsigned int invalidate_lock;
 	int ret = VM_FAULT_MINOR;
 	int anon = 0;
 
@@ -2014,10 +2015,24 @@
 
 	if (vma->vm_file) {
 		mapping = vma->vm_file->f_mapping;
+	retry:
 		sequence = mapping->truncate_count;
-		smp_rmb(); /* serializes i_size against truncate_count */
-	}
-retry:
+		/* Implicit smb_rmb() serializes i_size against truncate_count */
+
+		switch (read_seqschedlock(&mapping->invalidate_lock,
+					  &invalidate_lock)) {
+		default:
+			BUG();
+		case SEQSCHEDLOCK_WRITER_RUNNING:
+			yield();
+			/* fall through */
+		case SEQSCHEDLOCK_WRITER_RACE:
+			cond_resched();
+			goto retry;
+		case SEQSCHEDLOCK_SUCCESS:
+			;
+		}
+	}
 	new_page = vma->vm_ops->nopage(vma, address & PAGE_MASK, &ret);
 	/*
 	 * No smp_rmb is needed here as long as there's a full
@@ -2056,13 +2071,26 @@
 	 * invalidated this page.  If unmap_mapping_range got called,
 	 * retry getting the page.
 	 */
-	if (mapping && unlikely(sequence != mapping->truncate_count)) {
-		pte_unmap_unlock(page_table, ptl);
-		page_cache_release(new_page);
-		cond_resched();
-		sequence = mapping->truncate_count;
-		smp_rmb();
-		goto retry;
+	if (likely(mapping)) {
+		if (unlikely(sequence != mapping->truncate_count)) {
+		race_failure:
+			pte_unmap_unlock(page_table, ptl);
+			page_cache_release(new_page);
+			cond_resched();
+			goto retry;
+		}
+		switch (read_seqschedunlock(&mapping->invalidate_lock,
+					    invalidate_lock)) {
+		default:
+			BUG();
+		case SEQSCHEDLOCK_WRITER_RUNNING:
+			yield();
+			/* fall through */
+		case SEQSCHEDLOCK_WRITER_RACE:
+			goto race_failure;
+		case SEQSCHEDLOCK_SUCCESS:
+			;
+		}
 	}
 
 	/*
diff -r 48eb6d55cbd3 mm/truncate.c
--- a/mm/truncate.c	Tue Dec 13 08:48:29 2005 +0800
+++ b/mm/truncate.c	Tue Dec 13 20:30:19 2005 +0100
@@ -210,9 +210,13 @@
 			next++;
 			if (PageDirty(page) || PageWriteback(page))
 				goto unlock;
+
+			write_seqschedlock(&mapping->invalidate_lock);
 			if (page_mapped(page))
 				goto unlock;
 			ret += invalidate_complete_page(mapping, page);
+			write_seqschedunlock(&mapping->invalidate_lock);
+
 unlock:
 			unlock_page(page);
 			if (next > end)
@@ -276,6 +280,8 @@
 				break;
 			}
 			wait_on_page_writeback(page);
+
+			write_seqschedlock(&mapping->invalidate_lock);
 			while (page_mapped(page)) {
 				if (!did_range_unmap) {
 					/*
@@ -302,6 +308,8 @@
 					set_page_dirty(page);
 				ret = -EIO;
 			}
+			write_seqschedunlock(&mapping->invalidate_lock);
+
 			unlock_page(page);
 		}
 		pagevec_release(&pvec);
diff -r 48eb6d55cbd3 include/linux/seqschedlock.h
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/include/linux/seqschedlock.h	Tue Dec 13 20:30:19 2005 +0100
@@ -0,0 +1,129 @@
+/*
+ * Like the seqlock but allows scheduling inside the write critical section.
+ * Copyright (c) 2005 Novell, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, contact Novell, Inc.
+ *
+ * Started by Andrea Arcangeli to fix the SMP race between
+ * invalidate_inode_pages2() and do_no_page().
+ */
+
+#include <linux/config.h>
+
+#ifndef __LINUX_SEQSCHEDLOCK_H
+#define __LINUX_SEQSCHEDLOCK_H
+
+#define SEQSCHEDLOCK_WRITER_RUNNING	2	/* big collision */
+#define SEQSCHEDLOCK_WRITER_RACE	1	/* minor collision */
+#define SEQSCHEDLOCK_SUCCESS		0
+
+#ifdef CONFIG_SMP
+
+typedef struct seqschedlock_s {
+	atomic_t writers;
+	atomic_t sequence;
+} seqschedlock_t;
+
+#define SEQSCHEDLOCK_UNLOCKED	{ ATOMIC_INIT(0), ATOMIC_INIT(0), }
+
+static inline void write_seqschedlock(seqschedlock_t * sl)
+{
+	atomic_inc(&sl->writers);
+	smp_wmb();
+}
+
+static inline void write_seqschedunlock(seqschedlock_t * sl)
+{
+	smp_wmb();
+	atomic_inc(&sl->sequence);
+	smp_wmb();
+	atomic_dec(&sl->writers);
+}
+
+/*
+ * Perhaps this should be changed to wait in some waitqueue
+ * automatically instead of asking the caller to handle
+ * the race condition.
+ */
+static inline int read_seqschedlock(const seqschedlock_t * sl,
+				    unsigned int * sequence)
+{
+	unsigned int writers, sequence1, sequence2;
+
+	sequence1 = atomic_read(&sl->sequence);
+	smp_rmb();
+	writers = atomic_read(&sl->writers);
+	smp_rmb();
+	sequence2 = atomic_read(&sl->sequence);
+	smp_rmb();
+
+	if (unlikely(writers))
+		return SEQSCHEDLOCK_WRITER_RUNNING;
+	else if (unlikely(sequence1 != sequence2))
+		return SEQSCHEDLOCK_WRITER_RACE;
+	else {
+		*sequence = sequence1;
+		return SEQSCHEDLOCK_SUCCESS;
+	}
+}
+
+static inline int read_seqschedunlock(const seqschedlock_t * sl,
+				      unsigned int prev_sequence)
+{
+	unsigned int writers, sequence;
+
+	smp_rmb();
+	writers = atomic_read(&sl->writers);
+	smp_rmb();
+	sequence = atomic_read(&sl->sequence);
+
+	if (unlikely(writers))
+		return SEQSCHEDLOCK_WRITER_RUNNING;
+	else if (unlikely(sequence != prev_sequence))
+		return SEQSCHEDLOCK_WRITER_RACE;
+	else
+		return SEQSCHEDLOCK_SUCCESS;
+}
+
+#else /* CONFIG_SMP */
+
+typedef struct seqschedlock_s {
+} seqschedlock_t;
+
+#define SEQSCHEDLOCK_UNLOCKED	{ }
+
+static inline void write_seqschedlock(seqschedlock_t * sl)
+{
+}
+
+static inline void write_seqschedunlock(seqschedlock_t * sl)
+{
+}
+
+static inline int read_seqschedlock(const seqschedlock_t * sl,
+				    unsigned int * sequence)
+{
+	return SEQSCHEDLOCK_SUCCESS;
+}
+
+static inline int read_seqschedunlock(const seqschedlock_t * sl,
+				      unsigned int prev_sequence)
+{
+	return SEQSCHEDLOCK_SUCCESS;
+}
+
+#endif  /* CONFIG_SMP */
+
+#define seqschedlock_init(x)	do { *(x) = (seqschedlock_t) SEQSCHEDLOCK_UNLOCKED; } while (0)
+
+#endif /* __LINUX_SEQSCHEDLOCK_H */
