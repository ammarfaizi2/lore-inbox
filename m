Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317468AbSFMFwk>; Thu, 13 Jun 2002 01:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317473AbSFMFwj>; Thu, 13 Jun 2002 01:52:39 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:59596 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S317468AbSFMFwh>; Thu, 13 Jun 2002 01:52:37 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: mingo@elte.hu
Cc: Linus Torvalds <torvalds@transmeta.com>, dent@cosy.sbg.ac.at,
        adilger@clusterfs.com, da-x@gmx.net, patch@luckynet.dynu.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.21 - list.h cleanup 
In-Reply-To: Your message of "Wed, 12 Jun 2002 21:45:22 +0200."
             <Pine.LNX.4.44.0206122125210.17567-100000@elte.hu> 
Date: Thu, 13 Jun 2002 15:51:47 +1000
Message-Id: <E17INWO-0005RJ-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0206122125210.17567-100000@elte.hu> you write:
> On Tue, 11 Jun 2002, Rusty Russell wrote:
> > PS.  I blame Ingo: list_t indeed!
> 
> the reason why i added list_t to the scheduler code was mainly for
> aesthetic reasons. I'm still using 80x25 text consoles mainly, which are
> more sensitive to code length. Also, 'struct list_head' did not reflect
> the kind of lightweight list type we have, 'list_t' does that better. Eg.:

I agree calling it "struct list" or "struct dlist" would have been
nicer, but we're stuck with it now.

> but if typedefs create other problems then these arguments are secondary i
> guess. I'm completely against redefining base types for no particular
> reason, like counter_t.

Patch below.  There aren't many uses of list_t at all, but thousands
of "struct list_head" users.

> But i think it would be useful to introduce some sort of '_t convention',
> where _t always means a complex (or potentially complex - opaque) type. It
> makes code so much more compact and readable, and it does not hide
> anything - _t *always* means a complex type in the way i use it.

OTOH, I've thought of adding a kerrno_t which is an int, and only
useful for documentation purposes (meaning: I return 0 or -errno).
This conflicts with your _t definition 8(

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/include/linux/device.h tmp/include/linux/device.h
--- linux-2.5.21/include/linux/device.h	Mon Jun 10 16:03:55 2002
+++ tmp/include/linux/device.h	Thu Jun 13 15:44:58 2002
@@ -56,9 +56,9 @@
 	rwlock_t		lock;
 	atomic_t		refcount;
 
-	list_t			node;
-	list_t			devices;
-	list_t			drivers;
+	struct list_head	node;
+	struct list_head	devices;
+	struct list_head	drivers;
 
 	struct driver_dir_entry	dir;
 	struct driver_dir_entry	device_dir;
@@ -92,8 +92,8 @@
 	rwlock_t		lock;
 	atomic_t		refcount;
 
-	list_t			bus_list;
-	list_t			devices;
+	struct list_head	bus_list;
+	struct list_head	devices;
 
 	struct driver_dir_entry	dir;
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/include/linux/fs.h tmp/include/linux/fs.h
--- linux-2.5.21/include/linux/fs.h	Mon Jun 10 16:03:55 2002
+++ tmp/include/linux/fs.h	Thu Jun 13 15:44:01 2002
@@ -323,8 +323,8 @@
 	struct list_head	io_pages;	/* being prepared for I/O */
 	unsigned long		nrpages;	/* number of total pages */
 	struct address_space_operations *a_ops;	/* methods */
-	list_t			i_mmap;		/* list of private mappings */
-	list_t			i_mmap_shared;	/* list of private mappings */
+	struct list_head	i_mmap;		/* list of private mappings */
+	struct list_head	i_mmap_shared;	/* list of private mappings */
 	spinlock_t		i_shared_lock;  /* and spinlock protecting it */
 	unsigned long		dirtied_when;	/* jiffies of first page dirtying */
 	int			gfp_mask;	/* how to allocate the pages */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/include/linux/list.h tmp/include/linux/list.h
--- linux-2.5.21/include/linux/list.h	Mon Jun  3 12:21:28 2002
+++ tmp/include/linux/list.h	Thu Jun 13 15:44:13 2002
@@ -19,8 +19,6 @@
 	struct list_head *next, *prev;
 };
 
-typedef struct list_head list_t;
-
 #define LIST_HEAD_INIT(name) { &(name), &(name) }
 
 #define LIST_HEAD(name) \
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/include/linux/mm.h tmp/include/linux/mm.h
--- linux-2.5.21/include/linux/mm.h	Fri Jun  7 13:59:08 2002
+++ tmp/include/linux/mm.h	Thu Jun 13 15:44:09 2002
@@ -61,7 +61,7 @@
 	 * one of the address_space->i_mmap{,shared} lists,
 	 * for shm areas, the list of attaches, otherwise unused.
 	 */
-	list_t shared;
+	struct list_head shared;
 
 	/* Function pointers to deal with this struct. */
 	struct vm_operations_struct * vm_ops;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/include/linux/sched.h tmp/include/linux/sched.h
--- linux-2.5.21/include/linux/sched.h	Mon Jun 10 16:03:55 2002
+++ tmp/include/linux/sched.h	Thu Jun 13 15:43:48 2002
@@ -259,7 +259,7 @@
 	int lock_depth;		/* Lock depth */
 
 	int prio, static_prio;
-	list_t run_list;
+	struct list_head run_list;
 	prio_array_t *array;
 
 	unsigned long sleep_avg;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/kernel/sched.c tmp/kernel/sched.c
--- linux-2.5.21/kernel/sched.c	Mon Jun 10 16:03:56 2002
+++ tmp/kernel/sched.c	Thu Jun 13 15:45:44 2002
@@ -123,7 +123,7 @@
 struct prio_array {
 	int nr_active;
 	unsigned long bitmap[BITMAP_SIZE];
-	list_t queue[MAX_PRIO];
+	struct list_head queue[MAX_PRIO];
 };
 
 /*
@@ -142,7 +142,7 @@
 	prio_array_t *active, *expired, arrays[2];
 	int prev_nr_running[NR_CPUS];
 	task_t *migration_thread;
-	list_t migration_queue;
+	struct list_head migration_queue;
 } ____cacheline_aligned;
 
 static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
@@ -499,7 +499,7 @@
 	task_t *next = this_rq->idle, *tmp;
 	runqueue_t *busiest, *rq_src;
 	prio_array_t *array;
-	list_t *head, *curr;
+	struct list_head *head, *curr;
 
 	/*
 	 * We search all runqueues to find the most busy one.
@@ -759,7 +759,7 @@
 	task_t *prev, *next;
 	runqueue_t *rq;
 	prio_array_t *array;
-	list_t *queue;
+	struct list_head *queue;
 	int idx;
 
 	if (unlikely(in_interrupt()))
@@ -1652,7 +1652,7 @@
  */
 
 typedef struct {
-	list_t list;
+	struct list_head list;
 	task_t *task;
 	struct semaphore sem;
 } migration_req_t;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/mm/memory.c tmp/mm/memory.c
--- linux-2.5.21/mm/memory.c	Mon Jun  3 12:21:28 2002
+++ tmp/mm/memory.c	Thu Jun 13 15:43:23 2002
@@ -1028,11 +1028,11 @@
 	return -1;
 }
 
-static void vmtruncate_list(list_t *head, unsigned long pgoff)
+static void vmtruncate_list(struct list_head *head, unsigned long pgoff)
 {
 	unsigned long start, end, len, diff;
 	struct vm_area_struct *vma;
-	list_t *curr;
+	struct list_head *curr;
 
 	list_for_each(curr, head) {
 		vma = list_entry(curr, struct vm_area_struct, shared);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/mm/page_alloc.c tmp/mm/page_alloc.c
--- linux-2.5.21/mm/page_alloc.c	Mon Jun 10 16:03:56 2002
+++ tmp/mm/page_alloc.c	Thu Jun 13 15:43:29 2002
@@ -235,7 +235,7 @@
         zone_t *zone = page_zone(page);
         unsigned long flags;
 	int order;
-	list_t *curr;
+	struct list_head *curr;
 
 	/*
 	 * Should not matter as we need quiescent system for
