Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319102AbSH2GCy>; Thu, 29 Aug 2002 02:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319106AbSH2GCy>; Thu, 29 Aug 2002 02:02:54 -0400
Received: from dp.samba.org ([66.70.73.150]:13476 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319102AbSH2GCu>;
	Thu, 29 Aug 2002 02:02:50 -0400
Date: Thu, 29 Aug 2002 16:03:58 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Christoph Hellwig <hch@lst.de>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] list.h update (resent again)
Message-Id: <20020829160358.30db26fb.rusty@rustcorp.com.au>
In-Reply-To: <20020829021616.A9715@lst.de>
References: <20020829021616.A9715@lst.de>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2002 02:16:16 +0200
Christoph Hellwig <hch@lst.de> wrote:

> This patch updates list.h to the 2.5 version, including
> 
>  - list_t typedef
>  - static inline insead of static __inline__
>  - list_move/list_move_tail
>  - list_splice_init

Don't apply it (at least, the first part is bad).

Linus, here's my patch to get rid of the usurper list_t in 2.5
(against 2.5.32, so might have some rejects).

Name: list_t removal patch
Author: Rusty Russell
Section: Misc
Status: Trivial

D: This removes list_t, which is a gratuitous typedef for a "struct
D: list_head".  Unless there is good reason, the kernel doesn't usually
D: typedef, as typedefs cannot be predeclared unlike structs.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31311-linux-2.5.32/include/linux/device.h .31311-linux-2.5.32.updated/include/linux/device.h
--- .31311-linux-2.5.32/include/linux/device.h	2002-08-28 09:29:52.000000000 +1000
+++ .31311-linux-2.5.32.updated/include/linux/device.h	2002-08-29 15:00:12.000000000 +1000
@@ -57,9 +57,9 @@ struct bus_type {
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31311-linux-2.5.32/include/linux/fs.h .31311-linux-2.5.32.updated/include/linux/fs.h
--- .31311-linux-2.5.32/include/linux/fs.h	2002-08-28 09:29:52.000000000 +1000
+++ .31311-linux-2.5.32.updated/include/linux/fs.h	2002-08-29 15:00:12.000000000 +1000
@@ -322,8 +322,8 @@ struct address_space {
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31311-linux-2.5.32/include/linux/list.h .31311-linux-2.5.32.updated/include/linux/list.h
--- .31311-linux-2.5.32/include/linux/list.h	2002-08-02 11:15:10.000000000 +1000
+++ .31311-linux-2.5.32.updated/include/linux/list.h	2002-08-29 15:08:52.000000000 +1000
@@ -19,12 +19,10 @@ struct list_head {
 	struct list_head *next, *prev;
 };
 
-typedef struct list_head list_t;
-
 #define LIST_HEAD_INIT(name) { &(name), &(name) }
 
 #define LIST_HEAD(name) \
-	list_t name = LIST_HEAD_INIT(name)
+	struct list_head name = LIST_HEAD_INIT(name)
 
 #define INIT_LIST_HEAD(ptr) do { \
 	(ptr)->next = (ptr); (ptr)->prev = (ptr); \
@@ -36,7 +34,9 @@ typedef struct list_head list_t;
  * This is only for internal list manipulation where we know
  * the prev/next entries already!
  */
-static inline void __list_add(list_t *new, list_t *prev, list_t *next)
+static inline void __list_add(struct list_head *new,
+			      struct list_head *prev,
+			      struct list_head *next)
 {
 	next->prev = new;
 	new->next = next;
@@ -52,7 +52,7 @@ static inline void __list_add(list_t *ne
  * Insert a new entry after the specified head.
  * This is good for implementing stacks.
  */
-static inline void list_add(list_t *new, list_t *head)
+static inline void list_add(struct list_head *new, struct list_head *head)
 {
 	__list_add(new, head, head->next);
 }
@@ -65,7 +65,7 @@ static inline void list_add(list_t *new,
  * Insert a new entry before the specified head.
  * This is useful for implementing queues.
  */
-static inline void list_add_tail(list_t *new, list_t *head)
+static inline void list_add_tail(struct list_head *new, struct list_head *head)
 {
 	__list_add(new, head->prev, head);
 }
@@ -77,7 +77,7 @@ static inline void list_add_tail(list_t 
  * This is only for internal list manipulation where we know
  * the prev/next entries already!
  */
-static inline void __list_del(list_t * prev, list_t * next)
+static inline void __list_del(struct list_head * prev, struct list_head * next)
 {
 	next->prev = prev;
 	prev->next = next;
@@ -88,7 +88,7 @@ static inline void __list_del(list_t * p
  * @entry: the element to delete from the list.
  * Note: list_empty on entry does not return true after this, the entry is in an undefined state.
  */
-static inline void list_del(list_t *entry)
+static inline void list_del(struct list_head *entry)
 {
 	__list_del(entry->prev, entry->next);
 	entry->next = (void *) 0;
@@ -99,7 +99,7 @@ static inline void list_del(list_t *entr
  * list_del_init - deletes entry from list and reinitialize it.
  * @entry: the element to delete from the list.
  */
-static inline void list_del_init(list_t *entry)
+static inline void list_del_init(struct list_head *entry)
 {
 	__list_del(entry->prev, entry->next);
 	INIT_LIST_HEAD(entry); 
@@ -110,7 +110,7 @@ static inline void list_del_init(list_t 
  * @list: the entry to move
  * @head: the head that will precede our entry
  */
-static inline void list_move(list_t *list, list_t *head)
+static inline void list_move(struct list_head *list, struct list_head *head)
 {
         __list_del(list->prev, list->next);
         list_add(list, head);
@@ -121,7 +121,8 @@ static inline void list_move(list_t *lis
  * @list: the entry to move
  * @head: the head that will follow our entry
  */
-static inline void list_move_tail(list_t *list, list_t *head)
+static inline void list_move_tail(struct list_head *list,
+				  struct list_head *head)
 {
         __list_del(list->prev, list->next);
         list_add_tail(list, head);
@@ -131,16 +132,17 @@ static inline void list_move_tail(list_t
  * list_empty - tests whether a list is empty
  * @head: the list to test.
  */
-static inline int list_empty(list_t *head)
+static inline int list_empty(struct list_head *head)
 {
 	return head->next == head;
 }
 
-static inline void __list_splice(list_t *list, list_t *head)
+static inline void __list_splice(struct list_head *list,
+				 struct list_head *head)
 {
-	list_t *first = list->next;
-	list_t *last = list->prev;
-	list_t *at = head->next;
+	struct list_head *first = list->next;
+	struct list_head *last = list->prev;
+	struct list_head *at = head->next;
 
 	first->prev = head;
 	head->next = first;
@@ -154,7 +156,7 @@ static inline void __list_splice(list_t 
  * @list: the new list to add.
  * @head: the place to add it in the first list.
  */
-static inline void list_splice(list_t *list, list_t *head)
+static inline void list_splice(struct list_head *list, struct list_head *head)
 {
 	if (!list_empty(list))
 		__list_splice(list, head);
@@ -167,7 +169,8 @@ static inline void list_splice(list_t *l
  *
  * The list at @list is reinitialised
  */
-static inline void list_splice_init(list_t *list, list_t *head)
+static inline void list_splice_init(struct list_head *list,
+				    struct list_head *head)
 {
 	if (!list_empty(list)) {
 		__list_splice(list, head);
@@ -177,7 +180,7 @@ static inline void list_splice_init(list
 
 /**
  * list_entry - get the struct for this entry
- * @ptr:	the &list_t pointer.
+ * @ptr:	the &struct list_head pointer.
  * @type:	the type of the struct this is embedded in.
  * @member:	the name of the list_struct within the struct.
  */
@@ -186,7 +189,7 @@ static inline void list_splice_init(list
 
 /**
  * list_for_each	-	iterate over a list
- * @pos:	the &list_t to use as a loop counter.
+ * @pos:	the &struct list_head to use as a loop counter.
  * @head:	the head for your list.
  */
 #define list_for_each(pos, head) \
@@ -194,7 +197,7 @@ static inline void list_splice_init(list
         	pos = pos->next, prefetch(pos->next))
 /**
  * list_for_each_prev	-	iterate over a list backwards
- * @pos:	the &list_t to use as a loop counter.
+ * @pos:	the &struct list_head to use as a loop counter.
  * @head:	the head for your list.
  */
 #define list_for_each_prev(pos, head) \
@@ -203,8 +206,8 @@ static inline void list_splice_init(list
         	
 /**
  * list_for_each_safe	-	iterate over a list safe against removal of list entry
- * @pos:	the &list_t to use as a loop counter.
- * @n:		another &list_t to use as temporary storage
+ * @pos:	the &struct list_head to use as a loop counter.
+ * @n:		another &struct list_head to use as temporary storage
  * @head:	the head for your list.
  */
 #define list_for_each_safe(pos, n, head) \
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31311-linux-2.5.32/include/linux/mm.h .31311-linux-2.5.32.updated/include/linux/mm.h
--- .31311-linux-2.5.32/include/linux/mm.h	2002-08-28 09:29:52.000000000 +1000
+++ .31311-linux-2.5.32.updated/include/linux/mm.h	2002-08-29 15:00:12.000000000 +1000
@@ -61,7 +61,7 @@ struct vm_area_struct {
 	 * one of the address_space->i_mmap{,shared} lists,
 	 * for shm areas, the list of attaches, otherwise unused.
 	 */
-	list_t shared;
+	struct list_head shared;
 
 	/* Function pointers to deal with this struct. */
 	struct vm_operations_struct * vm_ops;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31311-linux-2.5.32/include/linux/sched.h .31311-linux-2.5.32.updated/include/linux/sched.h
--- .31311-linux-2.5.32/include/linux/sched.h	2002-08-28 09:29:53.000000000 +1000
+++ .31311-linux-2.5.32.updated/include/linux/sched.h	2002-08-29 15:00:12.000000000 +1000
@@ -264,7 +264,7 @@ struct task_struct {
 	int lock_depth;		/* Lock depth */
 
 	int prio, static_prio;
-	list_t run_list;
+	struct list_head run_list;
 	prio_array_t *array;
 
 	unsigned long sleep_avg;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31311-linux-2.5.32/kernel/exit.c .31311-linux-2.5.32.updated/kernel/exit.c
--- .31311-linux-2.5.32/kernel/exit.c	2002-08-28 09:29:53.000000000 +1000
+++ .31311-linux-2.5.32.updated/kernel/exit.c	2002-08-29 15:07:22.000000000 +1000
@@ -407,7 +407,7 @@ void exit_mm(struct task_struct *tsk)
 static inline void forget_original_parent(struct task_struct * father)
 {
 	struct task_struct *p, *reaper;
-	list_t *_p;
+	struct list_head *_p;
 
 	read_lock(&tasklist_lock);
 
@@ -477,7 +477,7 @@ static inline void zap_thread(task_t *p,
 static void exit_notify(void)
 {
 	struct task_struct *t;
-	list_t *_p, *_n;
+	struct list_head *_p, *_n;
 
 	forget_original_parent(current);
 	/*
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31311-linux-2.5.32/kernel/sched.c .31311-linux-2.5.32.updated/kernel/sched.c
--- .31311-linux-2.5.32/kernel/sched.c	2002-08-28 09:29:54.000000000 +1000
+++ .31311-linux-2.5.32.updated/kernel/sched.c	2002-08-29 15:03:52.000000000 +1000
@@ -133,7 +133,7 @@ typedef struct runqueue runqueue_t;
 struct prio_array {
 	int nr_active;
 	unsigned long bitmap[BITMAP_SIZE];
-	list_t queue[MAX_PRIO];
+	struct list_head queue[MAX_PRIO];
 };
 
 /*
@@ -152,7 +152,7 @@ struct runqueue {
 	int prev_nr_running[NR_CPUS];
 
 	task_t *migration_thread;
-	list_t migration_queue;
+	struct list_head migration_queue;
 
 } ____cacheline_aligned;
 
@@ -739,7 +739,7 @@ static void load_balance(runqueue_t *thi
 	int imbalance, idx, this_cpu = smp_processor_id();
 	runqueue_t *busiest;
 	prio_array_t *array;
-	list_t *head, *curr;
+	struct list_head *head, *curr;
 	task_t *tmp;
 
 	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance);
@@ -937,7 +937,7 @@ asmlinkage void schedule(void)
 	task_t *prev, *next;
 	runqueue_t *rq;
 	prio_array_t *array;
-	list_t *queue;
+	struct list_head *queue;
 	int idx;
 
 	if (unlikely(in_interrupt()))
@@ -1898,7 +1898,7 @@ void __init init_idle(task_t *idle, int 
  */
 
 typedef struct {
-	list_t list;
+	struct list_head list;
 	task_t *task;
 	struct semaphore sem;
 } migration_req_t;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31311-linux-2.5.32/mm/memory.c .31311-linux-2.5.32.updated/mm/memory.c
--- .31311-linux-2.5.32/mm/memory.c	2002-08-28 09:29:54.000000000 +1000
+++ .31311-linux-2.5.32.updated/mm/memory.c	2002-08-29 15:00:12.000000000 +1000
@@ -1033,11 +1033,11 @@ no_mem:
 	return VM_FAULT_OOM;
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31311-linux-2.5.32/mm/page_alloc.c .31311-linux-2.5.32.updated/mm/page_alloc.c
--- .31311-linux-2.5.32/mm/page_alloc.c	2002-08-28 09:29:54.000000000 +1000
+++ .31311-linux-2.5.32.updated/mm/page_alloc.c	2002-08-29 15:07:36.000000000 +1000
@@ -239,7 +239,7 @@ int is_head_of_free_region(struct page *
         zone_t *zone = page_zone(page);
         unsigned long flags;
 	int order;
-	list_t *curr;
+	struct list_head *curr;
 
 	/*
 	 * Should not matter as we need quiescent system for
@@ -633,7 +633,7 @@ void show_free_areas(void)
 
 	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->pgdat_next)
 		for (type = 0; type < MAX_NR_ZONES; type++) {
-			list_t *elem;
+			struct list_head *elem;
 			zone_t *zone = &pgdat->node_zones[type];
  			unsigned long nr, flags, order, total = 0;
 

-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
