Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267766AbUG3WPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267766AbUG3WPn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 18:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267855AbUG3WPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 18:15:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11964 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267766AbUG3WP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 18:15:28 -0400
X-Sieve: CMU Sieve 2.2
Date: Fri, 30 Jul 2004 17:37:18 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp030.home.surriel.com
To: linux-mm@kvack.org
cc: sjiang@cs.wm.edu
Subject: [PATCH] token based thrashing control
Message-ID: <Pine.LNX.4.58.0407301730440.9228@dhcp030.home.surriel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Loop: owner-majordomo@kvack.org
X-RedHat-Spam-Score: 0.001 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	
The following experimental patch implements token based thrashing
protection, using the algorithm described in:

	http://www.cs.wm.edu/~sjiang/token.htm

When there are pageins going on, a task can grab a token, that
protects the task from pageout (except by itself) until it is
no longer doing heavy pageins, or until the maximum hold time
of the token is over.

If the maximum hold time is exceeded, the task isn't eligable
to hold the token for a while more, since it wasn't doing it
much good anyway.

I have run a very unscientific benchmark on my system to test
the effectiveness of the patch, timing how a 230MB two-process
qsbench run takes, with and without the token thrashing
protection present.

normal 2.6.8-rc6:	6m45s
2.6.8-rc6 + token:	4m24s

This is a quick hack, implemented without having talked to the
inventor of the algorithm.  He's copied on the mail and I suspect
we'll be able to do better than my quick implementation ...

Please test this patch.

 include/linux/sched.h |    4 ++
 include/linux/swap.h  |   21 ++++++++++
 kernel/fork.c         |    2 +
 mm/Makefile           |    2 -
 mm/filemap.c          |    1 
 mm/memory.c           |    1 
 mm/rmap.c             |    3 +
 mm/thrash.c           |  100 ++++++++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 133 insertions(+), 1 deletion(-)

--- linux-2.6.7/include/linux/swap.h.token	2004-07-30 13:22:17.000000000 -0400
+++ linux-2.6.7/include/linux/swap.h	2004-07-30 16:39:27.000000000 -0400
@@ -204,6 +204,27 @@
 extern struct page * lookup_swap_cache(swp_entry_t);
 extern struct page * read_swap_cache_async(swp_entry_t, struct vm_area_struct *vma,
 					   unsigned long addr);
+/* linux/mm/thrash.c */
+#ifdef CONFIG_SWAP
+extern struct mm_struct * swap_token_mm;
+extern void grab_swap_token(void);
+extern void __put_swap_token(struct mm_struct *);
+
+static inline int has_swap_token(struct mm_struct * mm)
+{
+	return (mm == swap_token_mm);
+}
+
+static inline void put_swap_token(struct mm_struct * mm)
+{
+	if (has_swap_token(mm))
+		__put_swap_token(mm);
+}
+#else /* CONFIG_SWAP */
+#define put_swap_token do { } while(0)
+#define grab_swap_token  do { } while(0)
+#define has_swap_token 0
+#endif /* CONFIG_SWAP */
 
 /* linux/mm/swapfile.c */
 extern long total_swap_pages;
--- linux-2.6.7/include/linux/sched.h.token	2004-07-30 13:22:28.000000000 -0400
+++ linux-2.6.7/include/linux/sched.h	2004-07-30 13:22:29.000000000 -0400
@@ -239,6 +239,10 @@
 	/* Architecture-specific MM context */
 	mm_context_t context;
 
+	/* Token based thrashing protection. */
+	unsigned long swap_token_time;
+	char recent_pagein;
+
 	/* coredumping support */
 	int core_waiters;
 	struct completion *core_startup_done, core_done;
--- linux-2.6.7/kernel/fork.c.token	2004-07-30 13:22:27.000000000 -0400
+++ linux-2.6.7/kernel/fork.c	2004-07-30 13:22:29.000000000 -0400
@@ -36,6 +36,7 @@
 #include <linux/mount.h>
 #include <linux/audit.h>
 #include <linux/rmap.h>
+#include <linux/swap.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -463,6 +464,7 @@
 		exit_aio(mm);
 		exit_mmap(mm);
 		mmdrop(mm);
+		put_swap_token(mm);
 	}
 }
 
--- linux-2.6.7/mm/memory.c.token	2004-07-30 13:22:28.000000000 -0400
+++ linux-2.6.7/mm/memory.c	2004-07-30 13:22:29.000000000 -0400
@@ -1433,6 +1433,7 @@
 		/* Had to read the page from swap area: Major fault */
 		ret = VM_FAULT_MAJOR;
 		inc_page_state(pgmajfault);
+		grab_swap_token();
 	}
 
 	mark_page_accessed(page);
--- linux-2.6.7/mm/filemap.c.token	2004-07-30 13:22:28.000000000 -0400
+++ linux-2.6.7/mm/filemap.c	2004-07-30 13:22:29.000000000 -0400
@@ -1195,6 +1195,7 @@
 	 * effect.
 	 */
 	error = page_cache_read(file, pgoff);
+	grab_swap_token();
 
 	/*
 	 * The page we want has now been added to the page cache.
--- /dev/null	2003-09-15 09:40:47.000000000 -0400
+++ linux-2.6.7/mm/thrash.c	2004-07-30 16:55:00.000000000 -0400
@@ -0,0 +1,100 @@
+/*
+ * mm/thrash.c
+ *
+ * Copyright (C) 2004, Red Hat, Inc.
+ * Copyright (C) 2004, Rik van Riel <riel@redhat.com>
+ * Released under the GPL, see the file COPYING for details.
+ *
+ * Simple token based thrashing protection, using the algorithm
+ * described in:  http://www.cs.wm.edu/~sjiang/token.pdf
+ */
+#include <linux/jiffies.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/swap.h>
+
+static spinlock_t swap_token_lock = SPIN_LOCK_UNLOCKED;
+static unsigned long swap_token_timeout;
+unsigned long swap_token_check;
+struct mm_struct * swap_token_mm = &init_mm;
+
+#define SWAP_TOKEN_CHECK_INTERVAL (HZ * 2)
+#define SWAP_TOKEN_TIMEOUT (HZ * 300)
+
+/*
+ * Take the token away if the process had no page faults
+ * in the last interval, or if it has held the token for
+ * too long.
+ */
+#define SWAP_TOKEN_ENOUGH_RSS 1
+#define SWAP_TOKEN_TIMED_OUT 2
+static int should_release_swap_token(struct mm_struct * mm)
+{
+	int ret = 0;
+	if (!mm->recent_pagein)
+		ret = SWAP_TOKEN_ENOUGH_RSS;
+	else if (time_after(jiffies, swap_token_timeout))
+		ret = SWAP_TOKEN_TIMED_OUT;
+	mm->recent_pagein = 0;
+	return ret;
+}
+
+/*
+ * Try to grab the swapout protection token.  We only try to
+ * grab it once every TOKEN_CHECK_INTERVAL, both to prevent
+ * SMP lock contention and to check that the process that held
+ * the token before is no longer thrashing.
+ */
+void grab_swap_token(void)
+{
+	struct mm_struct * mm;
+	int reason;
+
+	/* We have the token. Let others know we still need it. */
+	if (has_swap_token(current->mm)) {
+		current->mm->recent_pagein = 1;
+		return;
+	}
+
+	if (time_after(jiffies, swap_token_check)) {
+
+		/* Can't get swapout protection if we exceed our RSS limit. */
+		// if (current->mm->rss > current->mm->rlimit_rss)
+		//	return;
+
+		/* ... or if we recently held the token. */
+		if (time_before(jiffies, current->mm->swap_token_time))
+			return;
+
+		if (!spin_trylock(&swap_token_lock))
+			return;
+
+		swap_token_check = jiffies + SWAP_TOKEN_CHECK_INTERVAL;
+
+		mm = swap_token_mm;
+		if ((reason = should_release_swap_token(mm))) {
+			unsigned long eligable = jiffies;
+			if (reason == SWAP_TOKEN_TIMED_OUT) {
+				eligable += SWAP_TOKEN_TIMEOUT;
+			}
+			mm->swap_token_time = eligable;
+			swap_token_timeout = jiffies + SWAP_TOKEN_TIMEOUT;
+			swap_token_mm = current->mm;
+			printk("Took swap token, pid %d (%s)\n",
+				 current->pid, current->comm);
+		}
+		spin_unlock(&swap_token_lock);
+	}
+	return;
+}
+
+/* Called on process exit. */
+void __put_swap_token(struct mm_struct * mm)
+{
+	spin_lock(&swap_token_lock);
+	if (mm == swap_token_mm) {
+		swap_token_mm = &init_mm;
+		swap_token_check = jiffies;
+	}
+	spin_unlock(&swap_token_lock);
+}
--- linux-2.6.7/mm/rmap.c.token	2004-07-30 13:22:24.000000000 -0400
+++ linux-2.6.7/mm/rmap.c	2004-07-30 13:22:29.000000000 -0400
@@ -230,6 +230,9 @@
 	if (ptep_clear_flush_young(vma, address, pte))
 		referenced++;
 
+	if (mm != current->mm && has_swap_token(mm))
+		referenced++;
+
 	(*mapcount)--;
 
 out_unmap:
--- linux-2.6.7/mm/Makefile.token	2004-07-30 13:22:27.000000000 -0400
+++ linux-2.6.7/mm/Makefile	2004-07-30 13:22:29.000000000 -0400
@@ -12,7 +12,7 @@
 			   readahead.o slab.o swap.o truncate.o vmscan.o \
 			   $(mmu-y)
 
-obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o
+obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
 obj-$(CONFIG_X86_4G)	+= usercopy.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"aart@kvack.org"> aart@kvack.org </a>
