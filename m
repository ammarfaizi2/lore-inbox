Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317484AbSGTTxh>; Sat, 20 Jul 2002 15:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317488AbSGTTxh>; Sat, 20 Jul 2002 15:53:37 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:1042 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317484AbSGTTxe>; Sat, 20 Jul 2002 15:53:34 -0400
Date: Sat, 20 Jul 2002 16:56:26 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: [PATCH][2/2] rlimit rss enforcement
Message-ID: <Pine.LNX.4.44L.0207201652590.12241-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the following patch, against 2.5.27, implements rlimit rss
enforcement. It's not quite as smooth as it is in the rmap
VM with page aging, but it does seem to work right.

The explicit pausing in rss_free_pages() isn't very nice so
I tried to remove it, but then the rss limited process still
manages to kick other processes out of RAM in its own favor,
so it appears this code is really needed.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

 include/linux/init_task.h |    1 +
 include/linux/sched.h     |    2 +-
 include/linux/swap.h      |    1 +
 kernel/sys.c              |    6 ++++++
 mm/memory.c               |    7 +++++++
 mm/rmap.c                 |   43 +++++++++++++++++++++++++++++++++++++++++++
 mm/vmscan.c               |   42 ++++++++++++++++++++++++++++++++++++++++--
 7 files changed, 99 insertions(+), 3 deletions(-)

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.660   -> 1.661
#	include/linux/swap.h	1.48    -> 1.49
#	include/linux/init_task.h	1.11    -> 1.12
#	include/linux/sched.h	1.71    -> 1.72
#	        kernel/sys.c	1.20    -> 1.21
#	         mm/vmscan.c	1.85    -> 1.86
#	         mm/memory.c	1.76    -> 1.77
#	           mm/rmap.c	1.3     -> 1.4
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/20	riel@imladris.surriel.com	1.661
# ulimit rss enforcement
# --------------------------------------------
#
diff -Nru a/include/linux/init_task.h b/include/linux/init_task.h
--- a/include/linux/init_task.h	Sat Jul 20 16:29:20 2002
+++ b/include/linux/init_task.h	Sat Jul 20 16:29:20 2002
@@ -27,6 +27,7 @@
 	mmap_sem:	__RWSEM_INITIALIZER(name.mmap_sem), \
 	page_table_lock: SPIN_LOCK_UNLOCKED, 		\
 	mmlist:		LIST_HEAD_INIT(name.mmlist),	\
+	rlimit_rss:	RLIM_INFINITY,			\
 }

 #define INIT_SIGNALS {	\
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Sat Jul 20 16:29:20 2002
+++ b/include/linux/sched.h	Sat Jul 20 16:29:20 2002
@@ -189,7 +189,7 @@
 	unsigned long rss, total_vm, locked_vm;
 	unsigned long def_flags;
 	unsigned long cpu_vm_mask;
-	unsigned long swap_address;
+	unsigned long rlimit_rss;

 	unsigned dumpable:1;

diff -Nru a/include/linux/swap.h b/include/linux/swap.h
--- a/include/linux/swap.h	Sat Jul 20 16:29:20 2002
+++ b/include/linux/swap.h	Sat Jul 20 16:29:20 2002
@@ -167,6 +167,7 @@
 /* linux/mm/vmscan.c */
 extern wait_queue_head_t kswapd_wait;
 extern int FASTCALL(try_to_free_pages(zone_t *, unsigned int, unsigned int));
+extern void rss_free_pages(void);

 /* linux/mm/page_io.c */
 int swap_readpage(struct file *file, struct page *page);
diff -Nru a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c	Sat Jul 20 16:29:20 2002
+++ b/kernel/sys.c	Sat Jul 20 16:29:20 2002
@@ -1166,6 +1166,12 @@
 	if (resource == RLIMIT_NOFILE) {
 		if (new_rlim.rlim_cur > NR_OPEN || new_rlim.rlim_max > NR_OPEN)
 			return -EPERM;
+	} else if (resource == RLIMIT_RSS && current->mm) {
+		/* convert rlimit from bytes to pages */
+		unsigned long pages = RLIM_INFINITY;
+		if (new_rlim.rlim_cur != RLIM_INFINITY)
+			pages = new_rlim.rlim_cur >> PAGE_SHIFT;
+		current->mm->rlimit_rss = pages;
 	}

 	retval = security_ops->task_setrlimit(resource, &new_rlim);
diff -Nru a/mm/memory.c b/mm/memory.c
--- a/mm/memory.c	Sat Jul 20 16:29:20 2002
+++ b/mm/memory.c	Sat Jul 20 16:29:20 2002
@@ -1421,6 +1421,13 @@
 	current->state = TASK_RUNNING;
 	pgd = pgd_offset(mm, address);

+	/*
+	 * If we are over our RSS limit and the system is low on free
+	 * memory we'll help free memory and throttle ourselves a bit.
+	 */
+	if (mm->rlimit_rss && mm->rss > mm->rlimit_rss)
+		rss_free_pages();
+
 	KERNEL_STAT_INC(pgfault);
 	/*
 	 * We need the page table lock to synchronize with kswapd
diff -Nru a/mm/rmap.c b/mm/rmap.c
--- a/mm/rmap.c	Sat Jul 20 16:29:20 2002
+++ b/mm/rmap.c	Sat Jul 20 16:29:20 2002
@@ -351,6 +351,49 @@
 }

 /**
+ * page_over_rsslimit - is the process the page belongs to over its RSS limit ?
+ * @page - page to test
+ *
+ * This function returns true if the processes owning this page
+ * is over their RSS (resident set size) limits.  For shared pages
+ * we only return true if all processes sharing this page are over
+ * their RSS limit.
+ * The caller needs to hold the page's pte_chain_lock.
+ */
+int page_over_rsslimit(struct page * page)
+{
+	struct pte_chain * pte_chain = page->pte.chain;
+	struct mm_struct * mm;
+	pte_t * ptep;
+
+	/* No process is using the page. */
+	if (!pte_chain)
+		return 0;
+
+	if (PageDirect(page)) {
+		mm = ptep_to_mm(page->pte.direct);
+
+		/* No rss limit or process is under the limit. */
+		if (!mm->rlimit_rss || mm->rss <= mm->rlimit_rss)
+			return 0;
+	} else {
+		do {
+			ptep = pte_chain->ptep;
+			mm = ptep_to_mm(ptep);
+
+			/* Stop when we find a process under its limit. */
+			if(!mm->rlimit_rss || mm->rss <= mm->rlimit_rss)
+				return 0;
+
+			pte_chain = pte_chain->next;
+		} while (pte_chain);
+	}
+
+	/* The process is over its RSS limit. */
+	return 1;
+}
+
+/**
  ** No more VM stuff below this comment, only pte_chain helper
  ** functions.
  **/
diff -Nru a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c	Sat Jul 20 16:29:20 2002
+++ b/mm/vmscan.c	Sat Jul 20 16:29:20 2002
@@ -138,7 +138,8 @@
 		 * the active list.
 		 */
 		pte_chain_lock(page);
-		if (page_referenced(page) && page_mapping_inuse(page)) {
+		if (page_referenced(page) && page_mapping_inuse(page) &&
+				!page_over_rsslimit(page)) {
 			del_page_from_inactive_list(page);
 			add_page_to_active_list(page);
 			pte_chain_unlock(page);
@@ -346,7 +347,8 @@
 		KERNEL_STAT_INC(pgscan);

 		pte_chain_lock(page);
-		if (page->pte.chain && page_referenced(page)) {
+		if (page->pte.chain && page_referenced(page) &&
+				!page_over_rsslimit(page)) {
 			list_del(&page->lru);
 			list_add(&page->lru, &active_list);
 			pte_chain_unlock(page);
@@ -502,6 +504,42 @@
 	} while ((pgdat = pgdat->node_next));

 	return 1;
+}
+
+/**
+ * rss_free_pages - run part of the pageout code and slow down a bit
+ * @gfp_mask: mask of things the pageout code is allowed to do
+ *
+ * This function is called when a task is over its RSS limit and has
+ * a page fault.  Its goal is to slow down the memory hog and free
+ * some memory, if free memory is low.  This is done so the hog doesn't
+ * slow down the well behaved programs in the system.
+ */
+void rss_free_pages(void)
+{
+	int pause = 0;
+
+	if (current->flags & PF_MEMALLOC)
+		return;
+
+	/* The system has enough free memory. */
+	if (kswapd_can_sleep())
+		return;
+
+	current->flags |= PF_MEMALLOC;
+
+	do {
+		kswapd_balance();
+
+		/* Slow down a bit, needed to make RSS limits reliable. */
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(pause);
+		set_current_state(TASK_RUNNING);
+		pause++;
+	} while (!kswapd_can_sleep());
+
+	current->flags &= ~PF_MEMALLOC;
+	return;
 }

 /*

