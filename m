Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262347AbREZAxp>; Fri, 25 May 2001 20:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262355AbREZAxg>; Fri, 25 May 2001 20:53:36 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:52317 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S262347AbREZAxW>; Fri, 25 May 2001 20:53:22 -0400
Date: Fri, 25 May 2001 20:52:50 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: [with-PATCH-really] highmem deadlock removal, balancing & cleanup
In-Reply-To: <20010526024230.K9634@athlon.random>
Message-ID: <Pine.LNX.4.33.0105252044170.3806-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 May 2001, Andrea Arcangeli wrote:

> Please merge this one in 2.4 for now (originally from Ingo, I only
> improved it), this is a real definitive fix and there's no nicer way to
> handle that unless you want to generalize an API for people to generate
> private anti-deadlock ("make sure to always make a progress") memory
> pools:

Alternatively, the following might be more interesting...

		-ben

diff --exclude=.* --exclude=*.[^ch]* -urN kernel-2.4.3-works/linux.orig/arch/i386/kernel/irq.c linux-toolbox-current/arch/i386/kernel/irq.c
--- kernel-2.4.3-works/linux.orig/arch/i386/kernel/irq.c	Thu May 10 16:04:39 2001
+++ linux-toolbox-current/arch/i386/kernel/irq.c	Thu May 10 12:16:21 2001
@@ -32,6 +32,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/irq.h>
 #include <linux/proc_fs.h>
+#include <linux/mm/reservation.h>

 #include <asm/atomic.h>
 #include <asm/io.h>
@@ -576,7 +577,10 @@
 	irq_desc_t *desc = irq_desc + irq;
 	struct irqaction * action;
 	unsigned int status;
+	struct page_reservation *saved_irq_rsv;

+	saved_irq_rsv = current->page_reservations;
+	current->page_reservations = &irq_rsv;
 	kstat.irqs[cpu][irq]++;
 	spin_lock(&desc->lock);
 	desc->handler->ack(irq);
@@ -638,6 +642,7 @@

 	if (softirq_active(cpu) & softirq_mask(cpu))
 		do_softirq();
+	current->page_reservations = saved_irq_rsv;
 	return 1;
 }

diff --exclude=.* --exclude=*.[^ch]* -urN kernel-2.4.3-works/linux.orig/arch/i386/mm/fault.c linux-toolbox-current/arch/i386/mm/fault.c
--- kernel-2.4.3-works/linux.orig/arch/i386/mm/fault.c	Thu May 10 16:04:40 2001
+++ linux-toolbox-current/arch/i386/mm/fault.c	Mon May 14 13:26:57 2001
@@ -196,6 +196,7 @@
 	if (in_interrupt() || !mm)
 		goto no_context;

+	atomic_inc(&mm->in_fault_count);
 	down_read(&mm->mmap_sem);

 	vma = find_vma(mm, address);
@@ -269,6 +270,7 @@
 		if (bit < 32)
 			tsk->thread.screen_bitmap |= 1 << bit;
 	}
+	atomic_dec(&mm->in_fault_count);
 	up_read(&mm->mmap_sem);
 	return;

@@ -277,6 +279,7 @@
  * Fix it, but check if it's kernel or user first..
  */
 bad_area:
+	atomic_dec(&mm->in_fault_count);
 	up_read(&mm->mmap_sem);

 bad_area_nosemaphore:
@@ -339,6 +342,7 @@
  * us unable to handle the page fault gracefully.
  */
 out_of_memory:
+	atomic_dec(&mm->in_fault_count);
 	up_read(&mm->mmap_sem);
 	printk("VM: killing process %s\n", tsk->comm);
 	if (error_code & 4)
@@ -346,6 +350,7 @@
 	goto no_context;

 do_sigbus:
+	atomic_dec(&mm->in_fault_count);
 	up_read(&mm->mmap_sem);

 	/*
diff --exclude=.* --exclude=*.[^ch]* -urN kernel-2.4.3-works/linux.orig/fs/buffer.c linux-toolbox-current/fs/buffer.c
--- kernel-2.4.3-works/linux.orig/fs/buffer.c	Thu May 10 16:07:27 2001
+++ linux-toolbox-current/fs/buffer.c	Fri May 11 16:42:19 2001
@@ -45,6 +45,7 @@
 #include <linux/quotaops.h>
 #include <linux/iobuf.h>
 #include <linux/highmem.h>
+#include <linux/mm/reservation.h>

 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -2735,6 +2736,7 @@
  */
 int bdflush(void *sem)
 {
+	static struct page_reservation rsv;
 	struct task_struct *tsk = current;
 	int flushed;
 	/*
@@ -2748,6 +2750,12 @@
 	strcpy(tsk->comm, "bdflush");
 	bdflush_tsk = tsk;

+	init_page_reservation(&rsv, RSV_MULTISHOT, ZONE_NORMAL);
+	if (reserve_pages(&rsv, GFP_KERNEL, 64))
+		panic("bdflush unable to reserve emergency pages!\n");
+	tsk->page_reservations = &rsv;
+
+
 	/* avoid getting signals */
 	spin_lock_irq(&tsk->sigmask_lock);
 	flush_signals(tsk);
@@ -2778,6 +2786,8 @@
 		   the next schedule will block. */
 		__set_current_state(TASK_RUNNING);
 	}
+
+	destroy_page_reservation(&rsv);
 }

 /*
@@ -2788,6 +2798,7 @@
  */
 int kupdate(void *sem)
 {
+	static struct page_reservation rsv;
 	struct task_struct * tsk = current;
 	int interval;

@@ -2795,6 +2806,11 @@
 	tsk->pgrp = 1;
 	strcpy(tsk->comm, "kupdated");

+	init_page_reservation(&rsv, RSV_MULTISHOT, ZONE_NORMAL);
+	if (reserve_pages(&rsv, GFP_KERNEL, 32))
+		panic("bdflush unable to reserve emergency pages!\n");
+	tsk->page_reservations = &rsv;
+
 	/* sigstop and sigcont will stop and wakeup kupdate */
 	spin_lock_irq(&tsk->sigmask_lock);
 	sigfillset(&tsk->blocked);
@@ -2833,6 +2849,7 @@
 #endif
 		sync_old_buffers();
 	}
+	destroy_page_reservation(&rsv);
 }

 static int __init bdflush_init(void)
diff --exclude=.* --exclude=*.[^ch]* -urN kernel-2.4.3-works/linux.orig/include/linux/mm/reservation.h linux-toolbox-current/include/linux/mm/reservation.h
--- kernel-2.4.3-works/linux.orig/include/linux/mm/reservation.h	Wed Dec 31 19:00:00 1969
+++ linux-toolbox-current/include/linux/mm/reservation.h	Thu May 10 12:16:21 2001
@@ -0,0 +1,48 @@
+#ifndef __LINUX__MM__RESERVATION_H
+#define __LINUX__MM__RESERVATION_H
+/* inclinde/linux/mm/reservation.h
+ *	written by Benjamin LaHaise
+ *
+ *	Copyright 2001 Red Hat, Inc.
+ *
+ *	This program is free software; you can redistribute it and/or modify
+ *	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation; either version 2 of the License, or
+ *	(at your option) any later version.
+ *
+ *	This program is distributed in the hope that it will be useful,
+ *	but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *	GNU General Public License for more details.
+ *
+ *	You should have received a copy of the GNU General Public License
+ *	along with this program; if not, write to the Free Software
+ *	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ *	based in part on ideas/code from Arjan Van de Ven and Stephen Tweedie.
+ */
+
+#define RSV_ONESHOT	0x00
+#define RSV_MULTISHOT	0x01	/* reservation will replenish itself */
+
+struct page_reservation {
+	struct list_head	list;
+	unsigned		avail, used;
+	int			flags;
+	zone_t			*zone;
+};
+
+extern struct page_reservation irq_rsv;
+
+extern void init_page_reservation(struct page_reservation *rsv, int flags, int zone);
+extern void destroy_page_reservation(struct page_reservation *rsv);
+
+/* Reservation is an all or nothing thing.  A successful reservation
+ * returns 0.  Anything else is a failure.
+ */
+extern int reserve_pages(struct page_reservation *rsv, int gfp_mask, unsigned count);
+
+/* Release a previously reserved amount of memory. */
+extern void put_reserved_pages(struct page_reservation *rsv, unsigned count);
+
+#endif
diff --exclude=.* --exclude=*.[^ch]* -urN kernel-2.4.3-works/linux.orig/include/linux/mm.h linux-toolbox-current/include/linux/mm.h
--- kernel-2.4.3-works/linux.orig/include/linux/mm.h	Thu May 10 16:04:40 2001
+++ linux-toolbox-current/include/linux/mm.h	Mon May 14 13:33:43 2001
@@ -528,7 +528,7 @@


 #define GFP_BOUNCE	(__GFP_HIGH | __GFP_FAIL)
-#define GFP_BUFFER	(__GFP_HIGH | __GFP_WAIT)
+#define GFP_BUFFER	(__GFP_HIGH | __GFP_WAIT | __GFP_FAIL)
 #define GFP_ATOMIC	(__GFP_HIGH)
 #define GFP_USER	(             __GFP_WAIT | __GFP_IO)
 #define GFP_HIGHUSER	(             __GFP_WAIT | __GFP_IO | __GFP_HIGHMEM)
diff --exclude=.* --exclude=*.[^ch]* -urN kernel-2.4.3-works/linux.orig/include/linux/mmzone.h linux-toolbox-current/include/linux/mmzone.h
--- kernel-2.4.3-works/linux.orig/include/linux/mmzone.h	Thu May 10 16:07:27 2001
+++ linux-toolbox-current/include/linux/mmzone.h	Fri May 11 20:46:13 2001
@@ -50,6 +50,10 @@
 	unsigned long		inactive_dirty_pages;
 	unsigned long		pages_min, pages_low, pages_high;

+	/* Page reservation */
+	unsigned long		reserved_pages;
+	struct list_head	depleted_rsv_list;
+
 	/*
 	 * free areas of different sizes
 	 */
diff --exclude=.* --exclude=*.[^ch]* -urN kernel-2.4.3-works/linux.orig/include/linux/sched.h linux-toolbox-current/include/linux/sched.h
--- kernel-2.4.3-works/linux.orig/include/linux/sched.h	Thu May 10 16:07:27 2001
+++ linux-toolbox-current/include/linux/sched.h	Mon May 14 13:23:55 2001
@@ -210,6 +210,7 @@
 	pgd_t * pgd;
 	atomic_t mm_users;			/* How many users with user space? */
 	atomic_t mm_count;			/* How many references to "struct mm_struct" (users count as 1) */
+	atomic_t in_fault_count;		/* number of in progress page faults */
 	int map_count;				/* number of VMAs */
 	struct rw_semaphore mmap_sem;
 	spinlock_t page_table_lock;		/* Protects task page tables and mm->rss */
@@ -241,6 +242,7 @@
 	pgd:		swapper_pg_dir, 		\
 	mm_users:	ATOMIC_INIT(2), 		\
 	mm_count:	ATOMIC_INIT(1), 		\
+	in_fault_count:	ATOMIC_INIT(0), 		\
 	map_count:	1, 				\
 	mmap_sem:	__RWSEM_INITIALIZER(name.mmap_sem), \
 	page_table_lock: SPIN_LOCK_UNLOCKED, 		\
@@ -406,6 +408,8 @@
    	u32 self_exec_id;
 /* Protection of (de-)allocation: mm, files, fs, tty */
 	spinlock_t alloc_lock;
+
+	struct page_reservation  *page_reservations;
 };

 /*
@@ -486,7 +490,8 @@
     sig:		&init_signals,					\
     pending:		{ NULL, &tsk.pending.head, {{0}}},		\
     blocked:		{{0}},						\
-    alloc_lock:		SPIN_LOCK_UNLOCKED				\
+    alloc_lock:		SPIN_LOCK_UNLOCKED,				\
+    page_reservations:	NULL,						\
 }


diff --exclude=.* --exclude=*.[^ch]* -urN kernel-2.4.3-works/linux.orig/init/main.c linux-toolbox-current/init/main.c
--- kernel-2.4.3-works/linux.orig/init/main.c	Thu May 10 16:04:39 2001
+++ linux-toolbox-current/init/main.c	Thu May 10 21:00:20 2001
@@ -28,6 +28,7 @@
 #include <linux/iobuf.h>
 #include <linux/bootmem.h>
 #include <linux/tty.h>
+#include <linux/mm/reservation.h>

 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -88,6 +89,9 @@

 static int init(void *);

+extern struct page_reservation atomic_rsv;
+extern struct page_reservation swap_rsv;
+
 extern void init_IRQ(void);
 extern void init_modules(void);
 extern void sock_init(void);
@@ -654,6 +658,13 @@
 	proc_root_init();
 #endif
 	mempages = num_physpages;
+
+	if (reserve_pages(&irq_rsv, GFP_KERNEL, mempages >> 9))
+		panic("unable to reserve irq memory.\n");
+	if (reserve_pages(&swap_rsv, GFP_KERNEL, mempages >> 9))
+		panic("unable to reserve swap memory.\n");
+	if (reserve_pages(&atomic_rsv, GFP_KERNEL, mempages >> 10))
+		panic("unable to reserve atomic memory.\n");

 	fork_init(mempages);
 	proc_caches_init();
diff --exclude=.* --exclude=*.[^ch]* -urN kernel-2.4.3-works/linux.orig/kernel/exit.c linux-toolbox-current/kernel/exit.c
--- kernel-2.4.3-works/linux.orig/kernel/exit.c	Thu May 10 16:07:27 2001
+++ linux-toolbox-current/kernel/exit.c	Thu May 10 12:15:34 2001
@@ -10,6 +10,7 @@
 #include <linux/smp_lock.h>
 #include <linux/module.h>
 #include <linux/tty.h>
+#include <linux/mm/reservation.h>
 #ifdef CONFIG_BSD_PROCESS_ACCT
 #include <linux/acct.h>
 #endif
@@ -422,6 +423,11 @@
 NORET_TYPE void do_exit(long code)
 {
 	struct task_struct *tsk = current;
+
+	if (tsk->page_reservations) {
+		destroy_page_reservation(tsk->page_reservations);
+		tsk->page_reservations = NULL;
+	}

 	if (in_interrupt())
 		panic("Aiee, killing interrupt handler!");
diff --exclude=.* --exclude=*.[^ch]* -urN kernel-2.4.3-works/linux.orig/kernel/fork.c linux-toolbox-current/kernel/fork.c
--- kernel-2.4.3-works/linux.orig/kernel/fork.c	Thu May 10 16:07:27 2001
+++ linux-toolbox-current/kernel/fork.c	Mon May 14 13:24:45 2001
@@ -203,6 +203,7 @@
 {
 	atomic_set(&mm->mm_users, 1);
 	atomic_set(&mm->mm_count, 1);
+	atomic_set(&mm->in_fault_count, 0);
 	init_rwsem(&mm->mmap_sem);
 	mm->page_table_lock = SPIN_LOCK_UNLOCKED;
 	mm->pgd = pgd_alloc();
@@ -630,6 +631,7 @@
 	p->tty_old_pgrp = 0;
 	p->times.tms_utime = p->times.tms_stime = 0;
 	p->times.tms_cutime = p->times.tms_cstime = 0;
+	p->page_reservations = 0;
 #ifdef CONFIG_SMP
 	{
 		int i;
diff --exclude=.* --exclude=*.[^ch]* -urN kernel-2.4.3-works/linux.orig/mm/page_alloc.c linux-toolbox-current/mm/page_alloc.c
--- kernel-2.4.3-works/linux.orig/mm/page_alloc.c	Thu May 10 16:07:27 2001
+++ linux-toolbox-current/mm/page_alloc.c	Fri May 11 15:52:54 2001
@@ -18,7 +18,31 @@
 #include <linux/pagemap.h>
 #include <linux/bootmem.h>
 #include <linux/slab.h>
+#include <linux/mm/reservation.h>

+extern int
+	page_launder_calls,
+	page_launder_scans,
+	page_launder_scanned_pages,
+	page_launder_scanned_not_dirty,
+	page_launder_scanned_active,
+	page_launder_scanned_skipped,
+	page_launder_scanned_dirty,
+	page_launder_scanned_dirty_skip,
+	page_launder_scanned_dirty_nolaunder,
+	page_launder_scanned_dirty_swapcache,
+	page_launder_scanned_buffers,
+	page_launder_scanned_buffers_refiled,
+	page_launder_scanned_buffers_freed_buffer,
+	page_launder_scanned_buffers_active,
+	page_launder_scanned_buffers_cleaned,
+	page_launder_scanned_buffers_released,
+	page_launder_scanned_mapped_clean,
+	page_launder_scanned_still_active
+;
+struct page_reservation atomic_rsv;
+struct page_reservation swap_rsv;
+struct page_reservation irq_rsv;
 int nr_swap_pages;
 int nr_active_pages;
 int nr_inactive_dirty_pages;
@@ -99,7 +123,7 @@

 	page->flags &= ~((1<<PG_referenced) | (1<<PG_dirty));
 	page->age = PAGE_AGE_START;
-
+
 	zone = page->zone;

 	mask = (~0UL) << order;
@@ -115,7 +139,8 @@

 	__save_flags(flags);
 	__cli();
-	if (!order && (per_cpu->nr_pages < per_cpu->max_nr_pages)) {
+	if (!order && (per_cpu->nr_pages < per_cpu->max_nr_pages) && list_empty(&zone->depleted_rsv_list)) {
+static int foo; if (foo++ < 5) printk("freeing per-cpu page\n");
 		list_add(&page->list, &per_cpu->head);
 		per_cpu->nr_pages++;
 		__restore_flags(flags);
@@ -124,6 +149,20 @@

 	spin_lock(&zone->lock);

+	/* Check if we need to replenish any of this zone's reservations. */
+	if (!list_empty(&zone->depleted_rsv_list)) {
+		struct page_reservation *rsv = list_entry(zone->depleted_rsv_list.next, struct page_reservation, list);
+static int foo; if (foo++ < 5) printk("updating reserve: %p %u %u\n", rsv, rsv->avail, rsv->used);
+		if (!rsv->used)
+			BUG();
+		rsv->avail++;
+		rsv->used--;
+
+		list_del_init(&rsv->list);
+		if (rsv->used)
+			list_add(&rsv->list, zone->depleted_rsv_list.prev);
+	}
+
 	zone->free_pages -= mask;

 	while (mask + (1 << (MAX_ORDER-1))) {
@@ -190,12 +229,13 @@
 }


-static FASTCALL(struct page * rmqueue(zone_t *zone, unsigned long order));
-static struct page * rmqueue(zone_t *zone, unsigned long order)
+static FASTCALL(struct page * rmqueue(zone_t *zone, unsigned long order, struct page_reservation *rsv));
+static struct page * rmqueue(zone_t *zone, unsigned long order, struct page_reservation *rsv)
 {
 	per_cpu_t *per_cpu = zone->cpu_pages + smp_processor_id();
 	free_area_t * area = zone->free_area + order;
 	unsigned long curr_order = order;
+	unsigned long free_pages;
 	struct list_head *head, *curr;
 	unsigned long flags;
 	struct page *page;
@@ -216,7 +256,15 @@
 	}

 	spin_lock(&zone->lock);
-	do {
+
+	free_pages = zone->free_pages;
+	free_pages -= zone->reserved_pages;
+
+	/* Using a reservation? */
+	if (rsv)
+		free_pages += rsv->avail;
+
+	if (free_pages >= (1 << order)) do {
 		head = &area->free_list;
 		curr = memlist_next(head);

@@ -232,6 +280,16 @@
 			zone->free_pages -= 1 << order;

 			page = expand(zone, page, index, order, curr_order, area);
+			if (rsv && (rsv->avail >= (1 << order))) {
+static int foo; if (foo++ < 5) printk("alloc from reserv: %p %u %u\n", rsv, rsv->avail, rsv->used);
+				if (!rsv->used && (rsv->flags & RSV_MULTISHOT)) {
+static int foo; if (foo++ < 5) printk("multishot reserv: %p\n", rsv);
+					list_add(&rsv->list, &zone->depleted_rsv_list);
+				rsv->avail -= 1 << order;
+				rsv->used += 1 << order;
+}
+				zone->reserved_pages--;
+			}
 			spin_unlock_irqrestore(&zone->lock, flags);

 			set_page_count(page, 1);
@@ -265,6 +323,7 @@
 	for (;;) {
 		zone_t *z = *(zone++);
 		unsigned long water_mark;
+		unsigned long free_pages;

 		if (!z)
 			break;
@@ -275,6 +334,8 @@
 		 * We allocate if the number of free + inactive_clean
 		 * pages is above the watermark.
 		 */
+		free_pages = z->free_pages - z->reserved_pages;
+
 		switch (limit) {
 			default:
 			case PAGES_MIN:
@@ -287,14 +348,14 @@
 				water_mark = z->pages_high;
 		}

-		if (z->free_pages + z->inactive_clean_pages > water_mark) {
+		if (free_pages + z->inactive_clean_pages > water_mark) {
 			struct page *page = NULL;
 			/* If possible, reclaim a page directly. */
-			if (direct_reclaim && z->free_pages < z->pages_min + 8)
+			if (direct_reclaim && free_pages < z->pages_min + 8)
 				page = reclaim_page(z);
 			/* If that fails, fall back to rmqueue. */
 			if (!page)
-				page = rmqueue(z, order);
+				page = rmqueue(z, order, NULL);
 			if (page)
 				return page;
 		}
@@ -304,6 +365,8 @@
 	return NULL;
 }

+extern struct page *get_reserved_page (void);
+

 /*
  * This is the 'heart' of the zoned buddy allocator:
@@ -320,7 +383,7 @@
 	 * Allocations put pressure on the VM subsystem.
 	 */
 	memory_pressure++;
-
+
 	/*
 	 * (If anyone calls gfp from interrupts nonatomically then it
 	 * will sooner or later tripped up by a schedule().)
@@ -351,11 +414,11 @@
 		if (!z->size)
 			BUG();

-		if (z->free_pages >= z->pages_low) {
-			page = rmqueue(z, order);
+		if (z->free_pages - z->reserved_pages >= z->pages_low) {
+			page = rmqueue(z, order, NULL);
 			if (page)
-				return page;
-		} else if (z->free_pages < z->pages_min &&
+				goto out_success;
+		} else if (z->free_pages - z->reserved_pages < z->pages_min &&
 					waitqueue_active(&kreclaimd_wait)) {
 				wake_up_interruptible(&kreclaimd_wait);
 		}
@@ -371,7 +434,7 @@
 	 */
 	page = __alloc_pages_limit(zonelist, order, PAGES_HIGH, direct_reclaim);
 	if (page)
-		return page;
+		goto out_success;

 	/*
 	 * Then try to allocate a page from a zone with more
@@ -383,7 +446,7 @@
 	 */
 	page = __alloc_pages_limit(zonelist, order, PAGES_LOW, direct_reclaim);
 	if (page)
-		return page;
+		goto out_success;

 	/*
 	 * OK, none of the zones on our zonelist has lots
@@ -418,8 +481,42 @@
 	 */
 	page = __alloc_pages_limit(zonelist, order, PAGES_MIN, direct_reclaim);
 	if (page)
-		return page;
+		goto out_success;

+	/* Memory reservation hook.  Note: memory reservations are
+	 * attempted after all other normal means of allocations have
+	 * failed.  Give it a try with the memory reservation and see
+	 * what happens.
+	 * TODO: with memory reservations in place, much of the code
+	 * below is completely bogus.  Clean this up!  -ben
+	 */
+	if (current->page_reservations || (gfp_mask & __GFP_HIGH)) {
+		struct page_reservation *rsv;
+
+		if (gfp_mask & __GFP_HIGH)
+			rsv = &atomic_rsv;
+		else
+			rsv = current->page_reservations;
+
+		do {
+			zone = zonelist->zones;
+			for (;;) {
+				zone_t *z = *(zone++);
+				if (!z)
+					break;
+
+				if (z == rsv->zone) {
+static int foo; if (foo++ < 5) printk("trying reservation: %p\n", current->page_reservations);
+					page = rmqueue(z, order, rsv);
+					if (page)
+						goto out_success;
+					break;
+				}
+			}
+		} while (rsv == &atomic_rsv &&
+			 (rsv = current->page_reservations));
+	}
+
 	/*
 	 *	If we dont want to try too hard then we can give up
 	 *	now
@@ -465,9 +562,9 @@
 						break;
 					__free_page(page);
 					/* Try if the allocation succeeds. */
-					page = rmqueue(z, order);
+					page = rmqueue(z, order, NULL);
 					if (page)
-						return page;
+						goto out_success;
 				}
 			}
 		}
@@ -485,6 +582,11 @@
 			memory_pressure++;
 			try_to_free_pages(gfp_mask);
 			wakeup_bdflush(0);
+			if ((gfp_mask & __GFP_WAIT) && !(current->flags & PF_ATOMICALLOC)) {
+				__set_current_state(TASK_RUNNING);
+				current->policy |= SCHED_YIELD;
+				schedule();
+			}
 			goto try_again;
 		}
 	}
@@ -511,31 +613,25 @@
 		if (direct_reclaim) {
 			page = reclaim_page(z);
  			if (page)
-				return page;
+				goto out_success;
 		}

 		/* XXX: is pages_min/4 a good amount to reserve for this? */
-		if (z->free_pages < z->pages_min / 4 &&
+		if (z->free_pages - z->reserved_pages < z->pages_min / 4 &&
 		    !((current->flags & PF_MEMALLOC) &&
 		      (gfp_mask & __GFP_WAIT)))
 			continue;
-		page = rmqueue(z, order);
+		page = rmqueue(z, order, NULL);
 		if (page)
-			return page;
+			goto out_success;
 	}

-	// okay - we are in trouble, lets go to the DMA pool directly:
-
-	{
-		zone_t *z = pgdat_list->node_zones;
-
-		page = rmqueue(z, order);
-		if (page)
-			return page;
-	}
 	/* No luck.. */
 	printk(KERN_INFO "__alloc_pages: %lu-order allocation failed.\n", order);
 	return NULL;
+
+out_success:
+	return page;
 }

 /*
@@ -588,7 +684,7 @@
 	sum = 0;
 	while (pgdat) {
 		for (zone = pgdat->node_zones; zone < pgdat->node_zones + MAX_NR_ZONES; zone++)
-			sum += zone->free_pages;
+			sum += zone->free_pages - zone->reserved_pages;
 		pgdat = pgdat->node_next;
 	}
 	return sum;
@@ -605,7 +701,8 @@
 	sum = 0;
 	pgdat = pgdat_list;
 	while (pgdat) {
-		sum += (pgdat->node_zones+zone_type)->free_pages;
+		zone_t *z = pgdat->node_zones+zone_type;
+		sum += z->free_pages - z->reserved_pages;
 		pgdat = pgdat->node_next;
 	}
 	return sum;
@@ -694,6 +791,7 @@

 	while (pgdat) {
 		pages += pgdat->node_zones[ZONE_HIGHMEM].free_pages;
+		pages -= pgdat->node_zones[ZONE_HIGHMEM].reserved_pages;
 		pgdat = pgdat->node_next;
 	}
 	return pages;
@@ -723,13 +821,37 @@
 		freepages.low,
 		freepages.high);

+	printk(	"%8u %8u %8u %8u %8u %8u\n"
+		"%8u %8u %8u %8u %8u %8u\n"
+		"%8u %8u %8u %8u %8u %8u\n",
+	page_launder_calls,
+	page_launder_scans,
+	page_launder_scanned_pages,
+	page_launder_scanned_not_dirty,
+	page_launder_scanned_active,
+	page_launder_scanned_skipped,
+	page_launder_scanned_dirty,
+	page_launder_scanned_dirty_skip,
+	page_launder_scanned_dirty_nolaunder,
+	page_launder_scanned_dirty_swapcache,
+	page_launder_scanned_buffers,
+	page_launder_scanned_buffers_refiled,
+	page_launder_scanned_buffers_freed_buffer,
+	page_launder_scanned_buffers_active,
+	page_launder_scanned_buffers_cleaned,
+	page_launder_scanned_buffers_released,
+	page_launder_scanned_mapped_clean,
+	page_launder_scanned_still_active
+);
+
 	for (type = 0; type < MAX_NR_ZONES; type++) {
 		struct list_head *head, *curr;
 		zone_t *zone = pgdat->node_zones + type;
- 		unsigned long nr, total, flags;
+ 		unsigned long nr, total, flags, reserved;

-		total = 0;
+		reserved = total = 0;
 		if (zone->size) {
+			printk("Zone %s: ", zone->name);
 			spin_lock_irqsave(&zone->lock, flags);
 		 	for (order = 0; order < MAX_ORDER; order++) {
 				head = &(zone->free_area + order)->free_list;
@@ -745,9 +867,10 @@
 				printk("%lu*%lukB ", nr,
 						(PAGE_SIZE>>10) << order);
 			}
+			reserved = zone->reserved_pages;
 			spin_unlock_irqrestore(&zone->lock, flags);
 		}
-		printk("= %lukB)\n", total * (PAGE_SIZE>>10));
+		printk("= %lukB)  Reserved: %lukB\n", total * (PAGE_SIZE>>10), reserved * (PAGE_SIZE>>10));
 	}

 #ifdef SWAP_CACHE_INFO
@@ -901,8 +1024,11 @@
 		zone->lock = SPIN_LOCK_UNLOCKED;
 		zone->zone_pgdat = pgdat;
 		zone->free_pages = 0;
+		zone->reserved_pages = 0;
 		zone->inactive_clean_pages = 0;
 		zone->inactive_dirty_pages = 0;
+		zone->reserved_pages = 0;
+		INIT_LIST_HEAD(&zone->depleted_rsv_list);
 		memlist_init(&zone->inactive_clean_list);
 		if (!size)
 			continue;
@@ -914,7 +1040,7 @@
 			mask = zone_balance_min[j];
 		else if (mask > zone_balance_max[j])
 			mask = zone_balance_max[j];
-		zone->pages_min = mask;
+		zone->pages_min = 0;
 		zone->pages_low = mask*2;
 		zone->pages_high = mask*3;
 		/*
@@ -928,7 +1054,7 @@
 		 * for people who require it to catch load spikes in eg.
 		 * gigabit ethernet routing...
 		 */
-		freepages.min += mask;
+		freepages.min = 0;
 		freepages.low += mask*2;
 		freepages.high += mask*3;
 		zone->zone_mem_map = mem_map + offset;
@@ -955,12 +1081,16 @@
 			bitmap_size = size >> i;
 			bitmap_size = (bitmap_size + 7) >> 3;
 			bitmap_size = LONG_ALIGN(bitmap_size);
-			bitmap_size *= 2;
+			bitmap_size *= 1;
 			zone->free_area[i].map =
 			  (unsigned int *) alloc_bootmem_node(pgdat, bitmap_size);
 		}
 	}
 	build_zonelists(pgdat);
+
+	init_page_reservation(&irq_rsv, RSV_MULTISHOT, ZONE_NORMAL);
+	init_page_reservation(&swap_rsv, RSV_MULTISHOT, ZONE_NORMAL);
+	init_page_reservation(&atomic_rsv, RSV_MULTISHOT, ZONE_NORMAL);
 }

 void __init free_area_init(unsigned long *zones_size)
@@ -977,6 +1107,101 @@
 	for (j = 0; j < MAX_NR_ZONES; j++) printk("%d  ", zone_balance_ratio[j]);
 	printk("\n");
 	return 1;
+}
+
+void init_page_reservation(struct page_reservation *rsv, int flags, int zone)
+{
+static int foo; if (foo++ < 5) printk("init_page_reservation(%p, %d, %d)\n", rsv, flags, zone);
+	INIT_LIST_HEAD(&rsv->list);
+	rsv->avail = 0;
+	rsv->used = 0;
+	rsv->flags = flags;
+
+	/* FIXME: This doesn't work properly on NUMA or multizoned setups.
+	 */
+	rsv->zone = pgdat_list->node_zones + zone;
+}
+
+void destroy_page_reservation(struct page_reservation *rsv)
+{
+	unsigned long flags;
+	zone_t *zone = rsv->zone;
+static int foo; if (foo++ < 5) printk("destroy_page_reservation(%p)\n", rsv);
+
+	spin_lock_irqsave(&zone->lock, flags);
+	zone->reserved_pages -= rsv->avail;
+	list_del_init(&rsv->list);	/* This relies on list_del_init being used */
+	spin_unlock_irqrestore(&zone->lock, flags);
+	memset(rsv, 0x57, sizeof(*rsv));
+}
+
+int reserve_pages(struct page_reservation *rsv, int gfp_mask, unsigned count)
+{
+	unsigned long flags, free_pages;
+	zone_t *zone = rsv->zone;
+	unsigned orig = count;
+	int tries = 5;
+static int foo; if (foo++ < 5) printk("reserve_pages(%p, %d, %u)\n", rsv, gfp_mask, count);
+
+	spin_lock_irqsave(&zone->lock, flags);
+	free_pages = zone->free_pages - zone->reserved_pages;
+	if (free_pages > count)
+		free_pages = count;
+	count -= free_pages;
+	zone->reserved_pages += free_pages;
+
+	rsv->used += count;
+	if (count)
+		zone->pages_min++;
+	list_del_init(&rsv->list);
+	if (rsv->used)
+		list_add(&rsv->list, zone->depleted_rsv_list.prev);
+
+	spin_unlock_irqrestore(&zone->lock, flags);
+
+	while (--tries && rsv->used) {
+		try_to_free_pages(gfp_mask);
+		if ((gfp_mask & __GFP_WAIT) && !(current->flags & PF_ATOMICALLOC)) {
+			__set_current_state(TASK_RUNNING);
+			current->policy |= SCHED_YIELD;
+			schedule();
+		}
+	}
+
+	if (count) {
+		spin_lock_irqsave(&zone->lock, flags);
+		zone->pages_min--;
+		spin_unlock_irqrestore(&zone->lock, flags);
+	}
+
+	if (!rsv->used)
+		return 0;
+
+	put_reserved_pages(rsv, orig);
+	return -ENOMEM;
+}
+
+void put_reserved_pages(struct page_reservation *rsv, unsigned count)
+{
+	unsigned long flags;
+	zone_t *zone = rsv->zone;
+static int foo; if (foo++ < 5) printk("put_reserved_pages(%p, %u)\n", rsv, count);
+	spin_lock_irqsave(&zone->lock, flags);
+
+	if (rsv->used <= count) {
+		count -= rsv->used;
+		rsv->used = 0;
+	} else {
+		rsv->used -= count;
+		count = 0;
+	}
+
+	if (count > rsv->avail)
+		BUG();
+
+	rsv->avail -= count;
+	zone->reserved_pages -= count;
+	spin_unlock_irqrestore(&zone->lock, flags);
 }

 __setup("memfrac=", setup_mem_frac);
diff --exclude=.* --exclude=*.[^ch]* -urN kernel-2.4.3-works/linux.orig/mm/vmscan.c linux-toolbox-current/mm/vmscan.c
--- kernel-2.4.3-works/linux.orig/mm/vmscan.c	Thu May 10 16:07:27 2001
+++ linux-toolbox-current/mm/vmscan.c	Mon May 14 13:30:26 2001
@@ -21,9 +21,32 @@
 #include <linux/init.h>
 #include <linux/highmem.h>
 #include <linux/file.h>
+#include <linux/mm/reservation.h>

 #include <asm/pgalloc.h>

+extern struct page_reservation swap_rsv;
+
+int	page_launder_calls,
+	page_launder_scans,
+	page_launder_scanned_pages,
+	page_launder_scanned_not_dirty,
+	page_launder_scanned_active,
+	page_launder_scanned_skipped,
+	page_launder_scanned_dirty,
+	page_launder_scanned_dirty_skip,
+	page_launder_scanned_dirty_nolaunder,
+	page_launder_scanned_dirty_swapcache,
+	page_launder_scanned_buffers,
+	page_launder_scanned_buffers_refiled,
+	page_launder_scanned_buffers_freed_buffer,
+	page_launder_scanned_buffers_active,
+	page_launder_scanned_buffers_cleaned,
+	page_launder_scanned_buffers_released,
+	page_launder_scanned_mapped_clean,
+	page_launder_scanned_still_active
+;
+
 /*
  * The swap-out function returns 1 if it successfully
  * scanned all the pages it was asked to (`count').
@@ -230,6 +253,14 @@
 {
 	unsigned long address;
 	struct vm_area_struct* vma;
+	unsigned long min_rss = atomic_read(&mm->in_fault_count);
+
+	min_rss *= 64;
+	if (min_rss > 256)
+		min_rss = 256;
+
+	if (mm->rss <= min_rss)
+		return;

 	/*
 	 * Go through process' page directory.
@@ -466,11 +497,18 @@
 	flushed_pages = 0;
 	freed_pages = 0;

+	spin_lock(&pagemap_lru_lock);
+	page_launder_calls++;
+	spin_unlock(&pagemap_lru_lock);
+
 dirty_page_rescan:
 	spin_lock(&pagemap_lru_lock);
+	page_launder_scans++;
+
 	maxscan = nr_inactive_dirty_pages;
 	while ((page_lru = inactive_dirty_list.prev) != &inactive_dirty_list &&
 				maxscan-- > 0) {
+		page_launder_scanned_pages++;

 		page = list_entry(page_lru, struct page, lru);
 		zone = page->zone;
@@ -481,6 +519,7 @@
 			list_del(page_lru);
 			nr_inactive_dirty_pages--;
 			zone->inactive_dirty_pages--;
+			page_launder_scanned_not_dirty++;
 			continue;
 		}

@@ -490,6 +529,7 @@
 		     page_ramdisk(page)) {
 			del_page_from_inactive_dirty_list(page);
 			add_page_to_active_list(page);
+			page_launder_scanned_active++;
 			continue;
 		}

@@ -505,7 +545,7 @@
 		if (launder_loop && !maxlaunder)
 			break;
 		if (launder_loop && zone->inactive_clean_pages +
-				zone->free_pages > zone->pages_high)
+				zone->free_pages - zone->reserved_pages > zone->pages_high)
 			goto skip_page;

 		/*
@@ -514,6 +554,7 @@
 		 */
 		if (TryLockPage(page)) {
 skip_page:
+			page_launder_scanned_skipped++;
 			list_del(page_lru);
 			list_add(page_lru, &inactive_dirty_list);
 			continue;
@@ -524,13 +565,19 @@
 		 * last copy..
 		 */
 		if (PageDirty(page)) {
+			struct page_reservation *saved_rsv;
 			int (*writepage)(struct page *) = page->mapping->a_ops->writepage;

-			if (!writepage || !can_get_io_locks)
+			page_launder_scanned_dirty++;
+
+			if (!writepage || !can_get_io_locks) {
+				page_launder_scanned_dirty_skip++;
 				goto page_active;
+			}

 			/* First time through? Move it to the back of the list */
 			if (!launder_loop) {
+				page_launder_scanned_dirty_nolaunder++;
 				list_del(page_lru);
 				list_add(page_lru, &inactive_dirty_list);
 				UnlockPage(page);
@@ -542,10 +589,16 @@
 			page_cache_get(page);
 			spin_unlock(&pagemap_lru_lock);

+			saved_rsv = current->page_reservations;
+			current->page_reservations = &swap_rsv;
 			writepage(page);
+			current->page_reservations = saved_rsv;
+
 			/* XXX: all ->writepage()s should use nr_async_pages */
 			if (!PageSwapCache(page))
 				flushed_pages++;
+			else
+				page_launder_scanned_dirty_swapcache++;
 			maxlaunder--;
 			page_cache_release(page);

@@ -565,6 +618,7 @@
 		 */
 		if (page->buffers) {
 			int wait, clearedbuf;
+			page_launder_scanned_buffers++;
 			/*
 			 * Since we might be doing disk IO, we have to
 			 * drop the spinlock and take an extra reference
@@ -594,21 +648,25 @@

 			/* The buffers were not freed. */
 			if (!clearedbuf) {
+				page_launder_scanned_buffers_refiled++;
 				add_page_to_inactive_dirty_list(page);
 				if (wait)
 					flushed_pages++;

 			/* The page was only in the buffer cache. */
 			} else if (!page->mapping) {
+				page_launder_scanned_buffers_freed_buffer++;
 				atomic_dec(&buffermem_pages);
 				freed_pages++;

 			/* The page has more users besides the cache and us. */
 			} else if (page_count(page) > 2) {
+				page_launder_scanned_buffers_active++;
 				add_page_to_active_list(page);

 			/* OK, we "created" a freeable page. */
 			} else /* page->mapping && page_count(page) == 2 */ {
+				page_launder_scanned_buffers_cleaned++;
 				add_page_to_inactive_clean_list(page);
 				freed_pages++;
 			}
@@ -618,10 +676,12 @@
 			 * We can only do it here because we are accessing
 			 * the page struct above.
 			 */
+			page_launder_scanned_buffers_released++;
 			UnlockPage(page);
 			page_cache_release(page);

 		} else if (page->mapping && !PageDirty(page)) {
+			page_launder_scanned_mapped_clean++;
 			/*
 			 * If a page had an extra reference in
 			 * deactivate_page(), we will find it here.
@@ -634,6 +694,7 @@
 			freed_pages++;

 		} else {
+			page_launder_scanned_still_active++;
 page_active:
 			/*
 			 * OK, we don't know what to do with the page.
@@ -660,6 +721,13 @@
 	 */
 	shortage = free_shortage();
 	if (can_get_io_locks && !launder_loop && shortage) {
+		if (gfp_mask & __GFP_WAIT) {
+			__set_current_state(TASK_RUNNING);
+			current->policy |= SCHED_YIELD;
+			schedule();
+		}
+
+		shortage = free_shortage();
 		launder_loop = 1;

 		/*
@@ -835,10 +903,11 @@
 		for(i = 0; i < MAX_NR_ZONES; i++) {
 			zone_t *zone = pgdat->node_zones+ i;
 			if (zone->size && (zone->inactive_clean_pages +
-					zone->free_pages < zone->pages_min+1)) {
+					zone->free_pages - zone->reserved_pages < zone->pages_min+1)) {
 				/* + 1 to have overlap with alloc_pages() !! */
 				sum += zone->pages_min + 1;
 				sum -= zone->free_pages;
+				sum += zone->reserved_pages;
 				sum -= zone->inactive_clean_pages;
 			}
 		}
@@ -881,6 +950,7 @@
 			zone_shortage -= zone->inactive_dirty_pages;
 			zone_shortage -= zone->inactive_clean_pages;
 			zone_shortage -= zone->free_pages;
+			zone_shortage += zone->reserved_pages;
 			if (zone_shortage > 0)
 				shortage += zone_shortage;
 		}
@@ -1009,6 +1079,7 @@

 int kswapd(void *unused)
 {
+	static struct page_reservation kswapd_rsv;
 	struct task_struct *tsk = current;

 	tsk->session = 1;
@@ -1016,6 +1087,11 @@
 	strcpy(tsk->comm, "kswapd");
 	sigfillset(&tsk->blocked);
 	kswapd_task = tsk;
+
+	init_page_reservation(&kswapd_rsv, RSV_MULTISHOT, ZONE_NORMAL);
+	if (reserve_pages(&kswapd_rsv, GFP_KERNEL, 32))
+		panic("kswapd unable to reserve emergency pages!\n");
+	tsk->page_reservations = &kswapd_rsv;

 	/*
 	 * Tell the memory management that we're a "memory allocator",
@@ -1086,6 +1162,8 @@
 			oom_kill();
 		}
 	}
+
+	destroy_page_reservation(&kswapd_rsv);
 }

 void wakeup_kswapd(void)
@@ -1102,6 +1180,10 @@
 int try_to_free_pages(unsigned int gfp_mask)
 {
 	int ret = 1;
+	struct page_reservation *rsv = current->page_reservations;
+
+	if (!rsv)
+		current->page_reservations = &swap_rsv;

 	if (gfp_mask & __GFP_WAIT) {
 		unsigned long caller_memalloc = current->flags & PF_MEMALLOC;
@@ -1111,6 +1193,8 @@
 		current->flags |= caller_memalloc;
 	}

+	current->page_reservations = rsv;
+
 	return ret;
 }

@@ -1151,7 +1235,7 @@
 				if (!zone->size)
 					continue;

-				while (zone->free_pages < zone->pages_low) {
+				while (zone->free_pages - zone->reserved_pages < zone->pages_low) {
 					struct page * page;
 					page = reclaim_page(zone);
 					if (!page)

