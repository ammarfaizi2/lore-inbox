Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312488AbSDJGjc>; Wed, 10 Apr 2002 02:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312489AbSDJGjb>; Wed, 10 Apr 2002 02:39:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33547 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312488AbSDJGj3>;
	Wed, 10 Apr 2002 02:39:29 -0400
Message-ID: <3CB3DE1E.5F811D77@zip.com.au>
Date: Tue, 09 Apr 2002 23:39:26 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] writeback daemons
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements a gang-of-threads which are designed to
be used for dirty data writeback. "pdflush" -> dirty page
flush, or something.

The number of threads is dynamically managed by a simple
demand-driven algorithm.

"Oh no, more kernel threads".  Don't worry, kupdate and
bdflush disappear later.

The intent is that no two pdflush threads are ever performing
writeback against the same request queue at the same time. 
It would be wasteful to do that.  My current patches don't
quite achieve this; I need to move the state into the request 
queue itself...

The driver for implementing the thread pool was to avoid the
possibility where bdflush gets stuck on one device's get_request_wait()
queue while lots of other disks sit idle.  Also generality,
abstraction, and the need to have something in place to perform
the address_space-based writeback when the buffer_head-based
writeback disappears.

There is no provision inside the pdflush code itself to prevent
many threads from working against the same device.  That's
the responsibility of the caller.

The main API function, `pdflush_operation()' attempts to find
a thread to do some work for you.  It is not reliable - it may
return -1 and say "sorry, I didn't do that".  This happens if
all threads are busy.

One _could_ extend pdflush_operation() to queue the work so that
it is guaranteed to happen.  If there's a need, that additional
minor complexity can be added.

Patch is against 2.5.8-pre3+ratcache+readahead+pageprivate


=====================================

--- 2.5.8-pre3/include/linux/mm.h~dallocbase-40-pdflush	Tue Apr  9 23:29:41 2002
+++ 2.5.8-pre3-akpm/include/linux/mm.h	Tue Apr  9 23:29:41 2002
@@ -589,6 +589,9 @@ static inline struct vm_area_struct * fi
 
 extern struct vm_area_struct *find_extend_vma(struct mm_struct *mm, unsigned long addr);
 
+extern int pdflush_operation(void (*fn)(unsigned long), unsigned long arg0);
+extern int pdflush_flush(unsigned long nr_pages);
+
 extern struct page * vmalloc_to_page(void *addr);
 
 #endif /* __KERNEL__ */
--- 2.5.8-pre3/include/linux/sched.h~dallocbase-40-pdflush	Tue Apr  9 23:29:41 2002
+++ 2.5.8-pre3-akpm/include/linux/sched.h	Tue Apr  9 23:29:41 2002
@@ -368,6 +368,7 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_MEMDIE	0x00001000	/* Killed for out-of-memory */
 #define PF_FREE_PAGES	0x00002000	/* per process page freeing */
 #define PF_NOIO		0x00004000	/* avoid generating further I/O */
+#define PF_FLUSHER	0x00008000	/* responsible for disk writeback */
 
 /*
  * Ptrace flags
--- /dev/null	Thu Aug 30 13:30:55 2001
+++ 2.5.8-pre3-akpm/mm/pdflush.c	Tue Apr  9 23:33:41 2002
@@ -0,0 +1,216 @@
+/*
+ * mm/pdflush.c - worker threads for writing back filesystem data
+ *
+ * Copyright (C) 2002, Linus Torvalds.
+ *
+ * 09Apr2002	akpm@zip.com.au
+ *		Initial version
+ */
+
+#include <linux/sched.h>
+#include <linux/list.h>
+#include <linux/signal.h>
+#include <linux/spinlock.h>
+#include <linux/gfp.h>
+#include <linux/init.h>
+#include <linux/module.h>
+
+
+/*
+ * Minimum and maximum number of pdflush instances
+ */
+#define MIN_PDFLUSH_THREADS	2
+#define MAX_PDFLUSH_THREADS	8
+
+static void start_one_pdflush_thread(void);
+
+
+/*
+ * The pdflush threads are worker threads for writing back dirty data.
+ * Ideally, we'd like one thread per active disk spindle.  But the disk
+ * topology is very hard to divine at this level.   Instead, we take
+ * care in various places to prevent more than one pdflush thread from
+ * performing writeback against a single filesystem.  pdflush threads
+ * have the PF_FLUSHER flag set in current->flags to aid in this.
+ */
+
+/*
+ * All the pdflush threads.  Protected by pdflush_lock
+ */
+static LIST_HEAD(pdflush_list);
+static spinlock_t pdflush_lock = SPIN_LOCK_UNLOCKED;
+
+/*
+ * The count of currently-running pdflush threads.  Protected
+ * by pdflush_lock.
+ */
+static int nr_pdflush_threads = 0;
+
+/*
+ * The time at which the pdflush thread pool last went empty
+ */
+static unsigned long last_empty_jifs;
+
+/*
+ * The pdflush thread.
+ *
+ * Thread pool management algorithm:
+ * 
+ * - The minumum and maximum number of pdflush instances are bound
+ *   by MIN_PDFLUSH_THREADS and MAX_PDFLUSH_THREADS.
+ * 
+ * - If there have been no idle pdflush instances for 1 second, create
+ *   a new one.
+ * 
+ * - If the least-recently-went-to-sleep pdflush thread has been asleep
+ *   for more than one second, terminate a thread.
+ */
+
+/*
+ * A structure for passing work to a pdflush thread.  Also for passing
+ * state information between pdflush threads.  Protected by pdflush_lock.
+ */
+struct pdflush_work {
+	struct task_struct *who;	/* The thread */
+	void (*fn)(unsigned long);	/* A callback function for pdflush to work on */
+	unsigned long arg0;		/* An argument to the callback function */
+	struct list_head list;		/* On pdflush_list, when the thread is idle */
+	unsigned long when_i_went_to_sleep;
+};
+
+/*
+ * preemption is disabled in pdflush.  There was a bug in preempt
+ * which was causing pdflush to get flipped into state TASK_RUNNING
+ * when it performed a spin_unlock.  That bug is probably fixed,
+ * but play it safe.  The preempt-off paths are very short.
+ */
+static int __pdflush(struct pdflush_work *my_work)
+{
+	daemonize();
+	reparent_to_init();
+	strcpy(current->comm, "pdflush");
+
+	/* interruptible sleep, so block all signals */
+	spin_lock_irq(&current->sigmask_lock);
+	siginitsetinv(&current->blocked, 0);
+	recalc_sigpending();
+	spin_unlock_irq(&current->sigmask_lock);
+
+	current->flags |= PF_FLUSHER;
+	my_work->fn = NULL;
+	my_work->who = current;
+
+	preempt_disable();
+	spin_lock_irq(&pdflush_lock);
+	nr_pdflush_threads++;
+	for ( ; ; ) {
+		struct pdflush_work *pdf;
+
+		list_add(&my_work->list, &pdflush_list);
+		my_work->when_i_went_to_sleep = jiffies;
+		set_current_state(TASK_INTERRUPTIBLE);
+		spin_unlock_irq(&pdflush_lock);
+
+		schedule();
+
+		preempt_enable();
+		(*my_work->fn)(my_work->arg0);
+		preempt_disable();
+
+		/*
+		 * Thread creation: For how long have there been zero
+		 * available threads?
+		 */
+		if (jiffies - last_empty_jifs > 1 * HZ) {
+			/* unlocked list_empty() test is OK here */
+			if (list_empty(&pdflush_list)) {
+				/* unlocked nr_pdflush_threads test is OK here */
+				if (nr_pdflush_threads < MAX_PDFLUSH_THREADS)
+					start_one_pdflush_thread();
+			}
+		}
+
+		spin_lock_irq(&pdflush_lock);
+
+		/*
+		 * Thread destruction: For how long has the sleepiest
+		 * thread slept?
+		 */
+		if (list_empty(&pdflush_list))
+			continue;
+		if (nr_pdflush_threads <= MIN_PDFLUSH_THREADS)
+			continue;
+		pdf = list_entry(pdflush_list.prev, struct pdflush_work, list);
+		if (jiffies - pdf->when_i_went_to_sleep > 1 * HZ) {
+			pdf->when_i_went_to_sleep = jiffies;	/* Limit exit rate */
+			break;					/* exeunt */
+		}
+	}
+	nr_pdflush_threads--;
+	spin_unlock_irq(&pdflush_lock);
+	preempt_enable();
+	return 0;
+}
+
+/*
+ * Of course, my_work wants to be just a local in __pdflush().  It is
+ * separated out in this manner to hopefully prevent the compiler from
+ * performing unfortunate optimisations agains the auto variables.  Because
+ * there are visible to other tasks and CPUs.  (No problem has actually
+ * been observed.  This is just paranoia).
+ */
+static int pdflush(void *dummy)
+{
+	struct pdflush_work my_work;
+	return __pdflush(&my_work);
+}
+
+/*
+ * Attempt to wake up a pdflush thread, and get it to do some work for you.
+ * Returns zero if it indeed managed to find a worker thread, and passed your
+ * payload to it.
+ */
+int pdflush_operation(void (*fn)(unsigned long), unsigned long arg0)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	if (fn == NULL)
+		BUG();		/* Hard to diagnose if it's deferred */
+
+	spin_lock_irqsave(&pdflush_lock, flags);
+	if (list_empty(&pdflush_list)) {
+		spin_unlock_irqrestore(&pdflush_lock, flags);
+		ret = -1;
+	} else {
+		struct pdflush_work *pdf;
+
+		pdf = list_entry(pdflush_list.next, struct pdflush_work, list);
+		list_del_init(&pdf->list);
+		if (list_empty(&pdflush_list))
+			last_empty_jifs = jiffies;
+		spin_unlock_irqrestore(&pdflush_lock, flags);
+		pdf->fn = fn;
+		pdf->arg0 = arg0;
+		wmb();			/* ? */
+		wake_up_process(pdf->who);
+	}
+	return ret;
+}
+
+static void start_one_pdflush_thread(void)
+{
+	kernel_thread(pdflush, NULL,
+			CLONE_FS | CLONE_FILES | CLONE_SIGNAL);
+}
+
+static int __init pdflush_init(void)
+{
+	int i;
+
+	for (i = 0; i < MIN_PDFLUSH_THREADS; i++)
+		start_one_pdflush_thread();
+	return 0;
+}
+
+module_init(pdflush_init);
--- 2.5.8-pre3/mm/Makefile~dallocbase-40-pdflush	Tue Apr  9 23:29:41 2002
+++ 2.5.8-pre3-akpm/mm/Makefile	Tue Apr  9 23:29:41 2002
@@ -14,6 +14,7 @@ export-objs := shmem.o filemap.o mempool
 obj-y	 := memory.o mmap.o filemap.o mprotect.o mlock.o mremap.o \
 	    vmalloc.o slab.o bootmem.o swap.o vmscan.o page_io.o \
 	    page_alloc.o swap_state.o swapfile.o numa.o oom_kill.o \
-	    shmem.o highmem.o mempool.o msync.o mincore.o readahead.o
+	    shmem.o highmem.o mempool.o msync.o mincore.o readahead.o \
+	    pdflush.o
 
 include $(TOPDIR)/Rules.make


-
