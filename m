Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266212AbUHBBgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266212AbUHBBgf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 21:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266214AbUHBBgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 21:36:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57227 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266212AbUHBBgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 21:36:22 -0400
Date: Sun, 1 Aug 2004 21:36:15 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp030.home.surriel.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-mm@kvack.org, sjiang@cs.wm.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] token based thrashing control
In-Reply-To: <20040801175618.711a3aac.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0408012132030.13053@dhcp030.home.surriel.com>
References: <Pine.LNX.4.58.0407301730440.9228@dhcp030.home.surriel.com>
 <Pine.LNX.4.58.0408010856240.13053@dhcp030.home.surriel.com>
 <20040801175618.711a3aac.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Aug 2004, Andrew Morton wrote:
> Rik van Riel <riel@redhat.com> wrote:

> >  However, for make -j 60 there's a dramatic difference between
> >  a kernel with the token based swapout and a kernel without.
> > 
> >  normal 2.6.8-rc2:	1h20m runtime / ~26% CPU use average
> >  2.6.8-rc2 + token:	  42m runtime / ~52% CPU use average
> 
> OK.  My test is usually around 50-60% CPU occupancy so we're not gaining
> in the moderate swapping range.

I wonder if measuring minor faults too would help here ...

Btw, here's a slightly updated patch.  It's got the definition
for put_swap_token fixed for !CONFIG_SWAP and calls put_swap_token
before mmput.

I also cut the 4G/4G split line out of the mm/Makefile patch chunk,
so that should now apply better.

It doesn't have any functional changes I'm aware of.

--- linux-2.6.7/include/linux/swap.h.token	2004-07-30 13:22:17.000000000 -0400
+++ linux-2.6.7/include/linux/swap.h	2004-08-01 21:28:29.411274311 -0400
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
+#define put_swap_token(x) do { } while(0)
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
+++ linux-2.6.7/kernel/fork.c	2004-08-01 20:44:50.000000000 -0400
@@ -36,6 +36,7 @@
 #include <linux/mount.h>
 #include <linux/audit.h>
 #include <linux/rmap.h>
+#include <linux/swap.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -462,6 +463,7 @@
 		spin_unlock(&mmlist_lock);
 		exit_aio(mm);
 		exit_mmap(mm);
+		put_swap_token(mm);
 		mmdrop(mm);
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
+++ linux-2.6.7/mm/thrash.c	2004-07-31 01:54:26.000000000 -0400
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
+			unsigned long eligible = jiffies;
+			if (reason == SWAP_TOKEN_TIMED_OUT) {
+				eligible += SWAP_TOKEN_TIMEOUT;
+			}
+			mm->swap_token_time = eligible;
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
+	if (likely(mm == swap_token_mm)) {
+		swap_token_mm = &init_mm;
+		swap_token_check = jiffies;
+	}
+	spin_unlock(&swap_token_lock);
+}
--- linux-2.6.7/mm/rmap.c.token	2004-07-30 13:22:24.000000000 -0400
+++ linux-2.6.7/mm/rmap.c	2004-08-01 21:15:29.861020222 -0400
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
@@ -12,6 +12,6 @@
 			   readahead.o slab.o swap.o truncate.o vmscan.o \
 			   $(mmu-y)
 
-obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o
+obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
