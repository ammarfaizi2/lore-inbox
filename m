Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316897AbSIBF2x>; Mon, 2 Sep 2002 01:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317359AbSIBF2x>; Mon, 2 Sep 2002 01:28:53 -0400
Received: from dp.samba.org ([66.70.73.150]:53646 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S316897AbSIBF22>;
	Mon, 2 Sep 2002 01:28:28 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: [TRIVIAL PATCH] Remove list_t infection.
Date: Mon, 02 Sep 2002 15:23:02 +1000
Message-Id: <20020902003318.7CB682C092@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This week, it spread to SCTP.

"struct list_head" isn't a great name, but having two names for
everything is yet another bar to reading kernel source.

Linus, please apply,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: list_t removal patch
Author: Rusty Russell
Section: Misc
Status: Trivial

D: This removes list_t, which is a gratuitous typedef for a "struct
D: list_head".  Unless there is good reason, the kernel doesn't usually
D: typedef, as typedefs cannot be predeclared unlike structs.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22733-linux-2.5.33/include/linux/device.h .22733-linux-2.5.33.updated/include/linux/device.h
--- .22733-linux-2.5.33/include/linux/device.h	2002-08-28 09:29:52.000000000 +1000
+++ .22733-linux-2.5.33.updated/include/linux/device.h	2002-09-02 15:15:09.000000000 +1000
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22733-linux-2.5.33/include/linux/fs.h .22733-linux-2.5.33.updated/include/linux/fs.h
--- .22733-linux-2.5.33/include/linux/fs.h	2002-08-28 09:29:52.000000000 +1000
+++ .22733-linux-2.5.33.updated/include/linux/fs.h	2002-09-02 15:15:09.000000000 +1000
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22733-linux-2.5.33/include/linux/list.h .22733-linux-2.5.33.updated/include/linux/list.h
--- .22733-linux-2.5.33/include/linux/list.h	2002-09-01 12:23:07.000000000 +1000
+++ .22733-linux-2.5.33.updated/include/linux/list.h	2002-09-02 15:15:09.000000000 +1000
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22733-linux-2.5.33/include/linux/mm.h .22733-linux-2.5.33.updated/include/linux/mm.h
--- .22733-linux-2.5.33/include/linux/mm.h	2002-09-01 12:23:07.000000000 +1000
+++ .22733-linux-2.5.33.updated/include/linux/mm.h	2002-09-02 15:15:09.000000000 +1000
@@ -61,7 +61,7 @@ struct vm_area_struct {
 	 * one of the address_space->i_mmap{,shared} lists,
 	 * for shm areas, the list of attaches, otherwise unused.
 	 */
-	list_t shared;
+	struct list_head shared;
 
 	/* Function pointers to deal with this struct. */
 	struct vm_operations_struct * vm_ops;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22733-linux-2.5.33/include/linux/sched.h .22733-linux-2.5.33.updated/include/linux/sched.h
--- .22733-linux-2.5.33/include/linux/sched.h	2002-09-01 12:23:07.000000000 +1000
+++ .22733-linux-2.5.33.updated/include/linux/sched.h	2002-09-02 15:15:09.000000000 +1000
@@ -264,7 +264,7 @@ struct task_struct {
 	int lock_depth;		/* Lock depth */
 
 	int prio, static_prio;
-	list_t run_list;
+	struct list_head run_list;
 	prio_array_t *array;
 
 	unsigned long sleep_avg;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22733-linux-2.5.33/include/net/sctp/structs.h .22733-linux-2.5.33.updated/include/net/sctp/structs.h
--- .22733-linux-2.5.33/include/net/sctp/structs.h	2002-09-01 12:23:08.000000000 +1000
+++ .22733-linux-2.5.33.updated/include/net/sctp/structs.h	2002-09-02 15:17:45.000000000 +1000
@@ -203,7 +203,7 @@ struct SCTP_protocol {
 	/* This is a list of groups of functions for each address
 	 * family that we support.
 	 */
-	list_t address_families;
+	struct list_head address_families;
 
 	/* This is the hash of all endpoints. */
 	int ep_hashsize;
@@ -225,7 +225,7 @@ struct SCTP_protocol {
 	 *
 	 * It is a list of struct sockaddr_storage_list.
 	 */
-	list_t local_addr_list;
+	struct list_head local_addr_list;
 	spinlock_t local_addr_lock;
 };
 
@@ -250,7 +250,7 @@ typedef struct sctp_func {
 	__u16		net_header_len;	
 	int		sockaddr_len;
 	sa_family_t	sa_family;
-	list_t          list;
+	struct list_head list;
 } sctp_func_t;
 
 sctp_func_t *sctp_get_af_specific(const sockaddr_storage_t *address);
@@ -494,7 +494,7 @@ const sockaddr_storage_t *sctp_source(co
  * sin_addr -- cast to either (struct in_addr) or (struct in6_addr)
  */
 struct sockaddr_storage_list {
-	list_t list;
+	struct list_head list;
 	sockaddr_storage_t a;
 };
 
@@ -582,7 +582,7 @@ void sctp_packet_free(sctp_packet_t *);
  */
 struct SCTP_transport {
 	/* A list of transports. */
-	list_t transports;
+	struct list_head transports;
 
 	/* Reference counting. */
 	atomic_t refcnt;
@@ -863,7 +863,7 @@ struct SCTP_bind_addr {
 	 *	has bound.  This information is passed to one's
 	 *	peer(s) in INIT and INIT ACK chunks.
 	 */
-	list_t address_list;
+	struct list_head address_list;
 
 	int malloced;        /* Are we kfree()able?  */
 };
@@ -988,7 +988,7 @@ struct SCTP_endpoint {
 	 *            is implemented.
 	 */
 	/* This is really a list of sctp_association_t entries. */
-	list_t asocs;
+	struct list_head asocs;
 
 	/* Secret Key: A secret key used by this endpoint to compute
 	 *            the MAC.  This SHOULD be a cryptographic quality
@@ -1070,7 +1070,7 @@ struct SCTP_association {
 	sctp_endpoint_common_t base;
 
 	/* Associations on the same socket. */
-	list_t asocs;
+	struct list_head asocs;
 
 	/* This is a signature that lets us know that this is a
 	 * sctp_association_t data structure.  Used for mapping an
@@ -1104,7 +1104,7 @@ struct SCTP_association {
 		 *
 		 * It is a list of SCTP_transport's.
 		 */
-		list_t transport_addr_list;
+		struct list_head transport_addr_list;
 
 		/* port
 		 *   The transport layer port number.
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22733-linux-2.5.33/kernel/exit.c .22733-linux-2.5.33.updated/kernel/exit.c
--- .22733-linux-2.5.33/kernel/exit.c	2002-09-01 12:23:08.000000000 +1000
+++ .22733-linux-2.5.33.updated/kernel/exit.c	2002-09-02 15:15:09.000000000 +1000
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22733-linux-2.5.33/kernel/sched.c .22733-linux-2.5.33.updated/kernel/sched.c
--- .22733-linux-2.5.33/kernel/sched.c	2002-09-01 12:23:08.000000000 +1000
+++ .22733-linux-2.5.33.updated/kernel/sched.c	2002-09-02 15:15:09.000000000 +1000
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
@@ -1899,7 +1899,7 @@ void __init init_idle(task_t *idle, int 
  */
 
 typedef struct {
-	list_t list;
+	struct list_head list;
 	task_t *task;
 	struct completion done;
 } migration_req_t;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22733-linux-2.5.33/mm/memory.c .22733-linux-2.5.33.updated/mm/memory.c
--- .22733-linux-2.5.33/mm/memory.c	2002-08-28 09:29:54.000000000 +1000
+++ .22733-linux-2.5.33.updated/mm/memory.c	2002-09-02 15:15:09.000000000 +1000
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22733-linux-2.5.33/mm/page_alloc.c .22733-linux-2.5.33.updated/mm/page_alloc.c
--- .22733-linux-2.5.33/mm/page_alloc.c	2002-09-01 12:23:08.000000000 +1000
+++ .22733-linux-2.5.33.updated/mm/page_alloc.c	2002-09-02 15:15:21.000000000 +1000
@@ -237,7 +237,7 @@ int is_head_of_free_region(struct page *
         struct zone *zone = page_zone(page);
         unsigned long flags;
 	int order;
-	list_t *curr;
+	struct list_head *curr;
 
 	/*
 	 * Should not matter as we need quiescent system for
@@ -652,7 +652,7 @@ void show_free_areas(void)
 
 	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->pgdat_next)
 		for (type = 0; type < MAX_NR_ZONES; type++) {
-			list_t *elem;
+			struct list_head *elem;
 			struct zone *zone = &pgdat->node_zones[type];
  			unsigned long nr, flags, order, total = 0;
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22733-linux-2.5.33/net/sctp/associola.c .22733-linux-2.5.33.updated/net/sctp/associola.c
--- .22733-linux-2.5.33/net/sctp/associola.c	2002-09-01 12:23:08.000000000 +1000
+++ .22733-linux-2.5.33.updated/net/sctp/associola.c	2002-09-02 15:18:21.000000000 +1000
@@ -296,7 +296,7 @@ void sctp_association_free(sctp_associat
 {
 	sctp_transport_t *transport;
 	sctp_endpoint_t *ep;
-	list_t *pos, *temp;
+	struct list_head *pos, *temp;
 	int i;
 
 	ep = asoc->ep;
@@ -482,7 +482,7 @@ sctp_transport_t *sctp_assoc_lookup_padd
 					  const sockaddr_storage_t *address)
 {
 	sctp_transport_t *t;
-	list_t *pos;
+	struct list_head *pos;
 
 	/* Cycle through all transports searching for a peer address. */
 
@@ -508,7 +508,7 @@ void sctp_assoc_control_transport(sctp_a
 	sctp_transport_t *first;
 	sctp_transport_t *second;
 	sctp_ulpevent_t *event;
-	list_t *pos;
+	struct list_head *pos;
 	int spc_state = 0;
 
 	/* Record the transition on the transport.  */
@@ -780,7 +780,7 @@ sctp_transport_t *sctp_assoc_lookup_tsn(
 {
 	sctp_transport_t *active;
 	sctp_transport_t *match;
-	list_t *entry, *pos;
+	struct list_head *entry, *pos;
 	sctp_transport_t *transport;
 	sctp_chunk_t *chunk;
 	__u32 key = htonl(tsn);
@@ -983,8 +983,8 @@ void sctp_assoc_update(sctp_association_
 sctp_transport_t *sctp_assoc_choose_shutdown_transport(sctp_association_t *asoc)
 {
 	sctp_transport_t *t, *next;
-	list_t *head = &asoc->peer.transport_addr_list;
-	list_t *pos;
+	struct list_head *head = &asoc->peer.transport_addr_list;
+	struct list_head *pos;
 
 	/* If this is the first time SHUTDOWN is sent, use the active
 	 * path.
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22733-linux-2.5.33/net/sctp/bind_addr.c .22733-linux-2.5.33.updated/net/sctp/bind_addr.c
--- .22733-linux-2.5.33/net/sctp/bind_addr.c	2002-09-01 12:23:08.000000000 +1000
+++ .22733-linux-2.5.33.updated/net/sctp/bind_addr.c	2002-09-02 15:18:29.000000000 +1000
@@ -65,7 +65,7 @@ int sctp_bind_addr_copy(sctp_bind_addr_t
 			sctp_scope_t scope, int priority, int flags)
 {
 	struct sockaddr_storage_list *addr;
-	list_t *pos;
+	struct list_head *pos;
 	int error = 0;
 
 	/* All addresses share the same port.  */
@@ -119,7 +119,7 @@ void sctp_bind_addr_init(sctp_bind_addr_
 static void sctp_bind_addr_clean(sctp_bind_addr_t *bp)
 {
 	struct sockaddr_storage_list *addr;
-	list_t *pos, *temp;
+	struct list_head *pos, *temp;
 
 	/* Empty the bind address list. */
 	list_for_each_safe(pos, temp, &bp->address_list) {
@@ -173,7 +173,7 @@ int sctp_add_bind_addr(sctp_bind_addr_t 
  */
 int sctp_del_bind_addr(sctp_bind_addr_t *bp, sockaddr_storage_t *del_addr)
 {
-	list_t *pos, *temp;
+	struct list_head *pos, *temp;
 	struct sockaddr_storage_list *addr;
 
 	list_for_each_safe(pos, temp, &bp->address_list) {
@@ -206,7 +206,7 @@ sctpParam_t sctp_bind_addrs_to_raw(const
 	sctpIpAddress_t rawaddr_space;
 	int len;
 	struct sockaddr_storage_list *addr;
-	list_t *pos;
+	struct list_head *pos;
 
 	retval.v = NULL;
 	addrparms_len = 0;
@@ -284,7 +284,7 @@ int sctp_raw_to_bind_addrs(sctp_bind_add
 int sctp_bind_addr_has_addr(sctp_bind_addr_t *bp, const sockaddr_storage_t *addr)
 {
 	struct sockaddr_storage_list *laddr;
-	list_t *pos;
+	struct list_head *pos;
 
 	list_for_each(pos, &bp->address_list) {
 		laddr = list_entry(pos, struct sockaddr_storage_list, list);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22733-linux-2.5.33/net/sctp/endpointola.c .22733-linux-2.5.33.updated/net/sctp/endpointola.c
--- .22733-linux-2.5.33/net/sctp/endpointola.c	2002-09-01 12:23:08.000000000 +1000
+++ .22733-linux-2.5.33.updated/net/sctp/endpointola.c	2002-09-02 15:18:39.000000000 +1000
@@ -257,7 +257,7 @@ sctp_association_t *__sctp_endpoint_look
 {
 	int rport;
 	sctp_association_t *asoc;
-	list_t *pos;
+	struct list_head *pos;
 
 	rport = paddr->v4.sin_port;
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22733-linux-2.5.33/net/sctp/outqueue.c .22733-linux-2.5.33.updated/net/sctp/outqueue.c
--- .22733-linux-2.5.33/net/sctp/outqueue.c	2002-09-01 12:23:09.000000000 +1000
+++ .22733-linux-2.5.33.updated/net/sctp/outqueue.c	2002-09-02 15:18:44.000000000 +1000
@@ -104,7 +104,7 @@ void sctp_outqueue_init(sctp_association
 void sctp_outqueue_teardown(sctp_outqueue_t *q)
 {
 	sctp_transport_t *transport;
-	list_t *lchunk, *pos;
+	struct list_head *lchunk, *pos;
 	sctp_chunk_t *chunk;
 
 	/* Throw away unacknowledged chunks. */
@@ -948,7 +948,7 @@ static void sctp_sack_update_unack_data(
 int sctp_sack_outqueue(sctp_outqueue_t *q, sctp_sackhdr_t *sack)
 {
 	sctp_chunk_t *tchunk;
-	list_t *lchunk, *transport_list, *pos;
+	struct list_head *lchunk, *transport_list, *pos;
 	__u32 tsn;
 	__u32 sack_ctsn;
 	__u32 ctsn;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22733-linux-2.5.33/net/sctp/protocol.c .22733-linux-2.5.33.updated/net/sctp/protocol.c
--- .22733-linux-2.5.33/net/sctp/protocol.c	2002-09-01 12:23:09.000000000 +1000
+++ .22733-linux-2.5.33.updated/net/sctp/protocol.c	2002-09-02 15:18:54.000000000 +1000
@@ -198,7 +198,7 @@ static void sctp_get_local_addr_list(sct
 static void __sctp_free_local_addr_list(sctp_protocol_t *proto)
 {
 	struct sockaddr_storage_list *addr;
-	list_t *pos, *temp;
+	struct list_head *pos, *temp;
 
 	list_for_each_safe(pos, temp, &proto->local_addr_list) {
 		addr = list_entry(pos, struct sockaddr_storage_list, list);
@@ -223,7 +223,7 @@ int sctp_copy_local_addr_list(sctp_proto
 {
 	struct sockaddr_storage_list *addr;
 	int error = 0;
-	list_t *pos;
+	struct list_head *pos;
 	long flags __attribute__ ((unused));
 
 	sctp_spin_lock_irqsave(&proto->local_addr_lock, flags);
@@ -327,7 +327,7 @@ int sctp_ctl_sock_init(void)
  */
 sctp_func_t *sctp_get_af_specific(const sockaddr_storage_t *address)
 {
-	list_t *pos;
+	struct list_head *pos;
 	sctp_protocol_t *proto = sctp_get_protocol();
 	sctp_func_t *retval, *af;
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22733-linux-2.5.33/net/sctp/sm_make_chunk.c .22733-linux-2.5.33.updated/net/sctp/sm_make_chunk.c
--- .22733-linux-2.5.33/net/sctp/sm_make_chunk.c	2002-09-01 12:23:09.000000000 +1000
+++ .22733-linux-2.5.33.updated/net/sctp/sm_make_chunk.c	2002-09-02 15:18:59.000000000 +1000
@@ -1417,7 +1417,7 @@ void sctp_process_init(sctp_association_
 	sctpParam_t param;
 	__u8 *end;
 	sctp_transport_t *transport;
-	list_t *pos, *temp;
+	struct list_head *pos, *temp;
 
 	/* We must include the address that the INIT packet came from.
 	 * This is the only address that matters for an INIT packet.
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22733-linux-2.5.33/net/sctp/sm_sideeffect.c .22733-linux-2.5.33.updated/net/sctp/sm_sideeffect.c
--- .22733-linux-2.5.33/net/sctp/sm_sideeffect.c	2002-09-01 12:23:09.000000000 +1000
+++ .22733-linux-2.5.33.updated/net/sctp/sm_sideeffect.c	2002-09-02 15:19:03.000000000 +1000
@@ -1053,7 +1053,7 @@ static void sctp_cmd_hb_timers_start(sct
 				     sctp_association_t *asoc)
 {
 	sctp_transport_t *t;
-	list_t *pos;
+	struct list_head *pos;
 
 	/* Start a heartbeat timer for each transport on the association.
 	 * hold a reference on the transport to make sure none of
@@ -1072,7 +1072,7 @@ static void sctp_cmd_hb_timers_start(sct
 void sctp_cmd_set_bind_addrs(sctp_cmd_seq_t *cmds, sctp_association_t *asoc,
 			     sctp_bind_addr_t *bp)
 {
-	list_t *pos, *temp;
+	struct list_head *pos, *temp;
 
 	list_for_each_safe(pos, temp, &bp->address_list) {
 		list_del_init(pos);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22733-linux-2.5.33/net/sctp/sm_statefuns.c .22733-linux-2.5.33.updated/net/sctp/sm_statefuns.c
--- .22733-linux-2.5.33/net/sctp/sm_statefuns.c	2002-09-01 12:23:09.000000000 +1000
+++ .22733-linux-2.5.33.updated/net/sctp/sm_statefuns.c	2002-09-02 15:19:11.000000000 +1000
@@ -1056,7 +1056,7 @@ static sctp_disposition_t sctp_sf_do_dup
 	sctp_ulpevent_t *ev;
 	sctp_chunk_t *repl;
 	sctp_transport_t *new_addr, *addr;
-	list_t *pos, *pos2, *temp;
+	struct list_head *pos, *pos2, *temp;
 	int found, error;
 
 	/* new_asoc is a brand-new association, so these are not yet
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22733-linux-2.5.33/net/sctp/socket.c .22733-linux-2.5.33.updated/net/sctp/socket.c
--- .22733-linux-2.5.33/net/sctp/socket.c	2002-09-01 12:23:09.000000000 +1000
+++ .22733-linux-2.5.33.updated/net/sctp/socket.c	2002-09-02 15:19:18.000000000 +1000
@@ -439,7 +439,7 @@ err_bindx_add:
 #if CONFIG_IP_SCTP_ADDIP
 	/* Add these addresses to all associations on this endpoint.  */
 	if (retval >= 0) {
-		list_t *pos;
+		struct list_head *pos;
 		sctp_endpoint_t *ep;
 		sctp_association_t *asoc;
 		ep = sctp_sk(sk)->ep;
@@ -560,7 +560,7 @@ err_bindx_rem:
 #if CONFIG_IP_SCTP_ADDIP
 	/* Remove these addresses from all associations on this endpoint.  */
 	if (retval >= 0) {
-		list_t *pos;
+		struct list_head *pos;
 		sctp_endpoint_t *ep;
 		sctp_association_t *asoc;
 
@@ -666,7 +666,7 @@ static void sctp_close(struct sock *sk, 
 {
 	sctp_endpoint_t *ep;
 	sctp_association_t *asoc;
-	list_t *pos, *temp;
+	struct list_head *pos, *temp;
 
 	SCTP_DEBUG_PRINTK("sctp_close(sk: 0x%p...)\n", sk);
 
@@ -1238,7 +1238,7 @@ static int sctp_setsockopt(struct sock *
 	int retval = 0;
 	char * tmp;
 	sctp_protocol_t *proto = sctp_get_protocol();
-	list_t *pos;
+	struct list_head *pos;
 	sctp_func_t *af;
 
 	SCTP_DEBUG_PRINTK("sctp_setsockopt(sk: %p... optname: %d)\n",
@@ -1661,7 +1661,7 @@ static int sctp_getsockopt(struct sock *
 	int retval = 0;
 	sctp_protocol_t *proto = sctp_get_protocol();
 	sctp_func_t *af;
-	list_t *pos;
+	struct list_head *pos;
 	int len;
 
 	SCTP_DEBUG_PRINTK("sctp_getsockopt(sk: %p, ...)\n", sk);
@@ -2649,7 +2649,7 @@ static void __sctp_write_space(sctp_asso
 void sctp_write_space(struct sock *sk)
 {
 	sctp_association_t *asoc;
-	list_t *pos;
+	struct list_head *pos;
 
 	/* Wake up the tasks in each wait queue.  */
 	list_for_each(pos, &((sctp_sk(sk))->ep->asocs)) {
