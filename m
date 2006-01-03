Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932528AbWACU6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbWACU6Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 15:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbWACU6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 15:58:24 -0500
Received: from mx1.suse.de ([195.135.220.2]:14225 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932467AbWACU6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 15:58:23 -0500
From: Andi Kleen <ak@suse.de>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH] [RFC] Optimize select/poll by putting small data sets on the stack
Date: Tue, 3 Jan 2006 21:58:13 +0100
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601032158.14057.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a RFC for now. I would be interested in testing
feedback. Patch is for 2.6.15.

Optimize select and poll by a using stack space for small fd sets

This brings back an old optimization from Linux 2.0. Using
the stack is faster than kmalloc. On a Intel P4 system
it speeds up a select of a single pty fd by about 13%
(~4000 cycles -> ~3500)

It also saves memory because a daemon hanging in select or poll
will usually save one or two less pages. This can add up - 
e.g. if you have 10 daemons blocking in poll/select you
save 40KB of memory.

I did a patch for this long ago, but it was never applied.
This version is a reimplementation of the old patch that
tries to be less intrusive. I only did the minimal changes
needed for the stack allocation.

The cut off point before external memory is allocated 
is currently at 832bytes.  The system calls always allocate
this much memory on the stack.

These 832 bytes are divided into 256 bytes frontend data (for the select
bitmaps of the pollfds) and the rest of the space for the wait queues used
by the low level drivers. There are some extreme 
cases where this won't work out for select and it falls back 
to allocating memory too early - especially with very sparse 
large select bitmaps -  but the majority of processes who only have a small
number of file descriptors should be ok.
[TBD: 832/256 might not be the best split for select or poll] 

I suspect more optimizations might be possible, but they would 
be more complicated. One way would be to cache the select/poll
context over multiple system calls because typically the
input values should be similar. Problem is when to flush
the file descriptors out though.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux-2.6.15rc7-work/fs/select.c
===================================================================
--- linux-2.6.15rc7-work.orig/fs/select.c
+++ linux-2.6.15rc7-work/fs/select.c
@@ -29,12 +29,6 @@
 #define ROUND_UP(x,y) (((x)+(y)-1)/(y))
 #define DEFAULT_POLLMASK (POLLIN | POLLOUT | POLLRDNORM | POLLWRNORM)
 
-struct poll_table_entry {
-	struct file * filp;
-	wait_queue_t wait;
-	wait_queue_head_t * wait_address;
-};
-
 struct poll_table_page {
 	struct poll_table_page * next;
 	struct poll_table_entry * entry;
@@ -64,13 +58,23 @@ void poll_initwait(struct poll_wqueues *
 	init_poll_funcptr(&pwq->pt, __pollwait);
 	pwq->error = 0;
 	pwq->table = NULL;
+	pwq->inline_index = 0;
 }
 
 EXPORT_SYMBOL(poll_initwait);
 
+static void free_poll_entry(struct poll_table_entry *entry)
+{
+	remove_wait_queue(entry->wait_address,&entry->wait);
+	fput(entry->filp);
+}
+
 void poll_freewait(struct poll_wqueues *pwq)
 {
 	struct poll_table_page * p = pwq->table;
+	int i;
+	for (i = 0; i < pwq->inline_index; i++)
+		free_poll_entry(pwq->inline_entries + i); 
 	while (p) {
 		struct poll_table_entry * entry;
 		struct poll_table_page *old;
@@ -78,8 +82,7 @@ void poll_freewait(struct poll_wqueues *
 		entry = p->entry;
 		do {
 			entry--;
-			remove_wait_queue(entry->wait_address,&entry->wait);
-			fput(entry->filp);
+			free_poll_entry(entry);
 		} while (entry > p->entries);
 		old = p;
 		p = p->next;
@@ -89,12 +92,14 @@ void poll_freewait(struct poll_wqueues *
 
 EXPORT_SYMBOL(poll_freewait);
 
-static void __pollwait(struct file *filp, wait_queue_head_t *wait_address,
-		       poll_table *_p)
-{
+static struct poll_table_entry *poll_get_entry(poll_table *_p) 
+{ 
 	struct poll_wqueues *p = container_of(_p, struct poll_wqueues, pt);
 	struct poll_table_page *table = p->table;
 
+	if (p->inline_index < N_INLINE_POLL_ENTRIES)
+		return p->inline_entries + p->inline_index++; 
+
 	if (!table || POLL_TABLE_FULL(table)) {
 		struct poll_table_page *new_table;
 
@@ -102,7 +107,7 @@ static void __pollwait(struct file *filp
 		if (!new_table) {
 			p->error = -ENOMEM;
 			__set_current_state(TASK_RUNNING);
-			return;
+			return NULL;
 		}
 		new_table->entry = new_table->entries;
 		new_table->next = table;
@@ -110,16 +115,21 @@ static void __pollwait(struct file *filp
 		table = new_table;
 	}
 
-	/* Add a new entry */
-	{
-		struct poll_table_entry * entry = table->entry;
-		table->entry = entry+1;
-	 	get_file(filp);
-	 	entry->filp = filp;
-		entry->wait_address = wait_address;
-		init_waitqueue_entry(&entry->wait, current);
-		add_wait_queue(wait_address,&entry->wait);
-	}
+	return table->entry++; 
+} 
+
+/* Add a new entry */
+static void __pollwait(struct file *filp, wait_queue_head_t *wait_address,
+		       poll_table *p)
+{
+	struct poll_table_entry *entry = poll_get_entry(p);
+	if (!entry) 
+		return;
+	get_file(filp);
+	entry->filp = filp;
+	entry->wait_address = wait_address;
+	init_waitqueue_entry(&entry->wait, current);
+	add_wait_queue(wait_address,&entry->wait);
 }
 
 #define FDS_IN(fds, n)		(fds->in + n)
@@ -274,16 +284,6 @@ int do_select(int n, fd_set_bits *fds, l
 	return retval;
 }
 
-static void *select_bits_alloc(int size)
-{
-	return kmalloc(6 * size, GFP_KERNEL);
-}
-
-static void select_bits_free(void *bits, int size)
-{
-	kfree(bits);
-}
-
 /*
  * We can actually return ERESTARTSYS instead of EINTR, but I'd
  * like to be certain this leads to no problems. So I return
@@ -303,6 +303,8 @@ sys_select(int n, fd_set __user *inp, fd
 	long timeout;
 	int ret, size, max_fdset;
 	struct fdtable *fdt;
+	/* Allocate small arguments on the stack to save memory and be faster */
+	char stack_fds[SELECT_STACK_ALLOC];
 
 	timeout = MAX_SCHEDULE_TIMEOUT;
 	if (tvp) {
@@ -344,7 +346,10 @@ sys_select(int n, fd_set __user *inp, fd
 	 */
 	ret = -ENOMEM;
 	size = FDS_BYTES(n);
-	bits = select_bits_alloc(size);
+	if (6*size < SELECT_STACK_ALLOC)
+		bits = stack_fds;
+	else
+		bits = kmalloc(6 * size, GFP_KERNEL);
 	if (!bits)
 		goto out_nofds;
 	fds.in      = (unsigned long *)  bits;
@@ -390,7 +395,8 @@ sys_select(int n, fd_set __user *inp, fd
 		ret = -EFAULT;
 
 out:
-	select_bits_free(bits, size);
+	if (bits != stack_fds)
+		kfree(bits);
 out_nofds:
 	return ret;
 }
@@ -464,6 +470,8 @@ static int do_poll(unsigned int nfds,  s
 	return count;
 }
 
+#define N_STACK_PPS ((sizeof(stack_pps) - sizeof(struct poll_list))  / sizeof(struct pollfd))
+
 asmlinkage long sys_poll(struct pollfd __user * ufds, unsigned int nfds, long timeout)
 {
 	struct poll_wqueues table;
@@ -473,6 +481,9 @@ asmlinkage long sys_poll(struct pollfd _
  	struct poll_list *walk;
 	struct fdtable *fdt;
 	int max_fdset;
+	/* Allocate small arguments on the stack to save memory and be faster */
+	char stack_pps[POLL_STACK_ALLOC];
+	struct poll_list *stack_pp = NULL;
 
 	/* Do a sanity check on nfds ... */
 	rcu_read_lock();
@@ -498,14 +509,23 @@ asmlinkage long sys_poll(struct pollfd _
 	err = -ENOMEM;
 	while(i!=0) {
 		struct poll_list *pp;
-		pp = kmalloc(sizeof(struct poll_list)+
-				sizeof(struct pollfd)*
-				(i>POLLFD_PER_PAGE?POLLFD_PER_PAGE:i),
-					GFP_KERNEL);
-		if(pp==NULL)
-			goto out_fds;
+		int num, size; 
+		if (stack_pp == NULL)
+			num = N_STACK_PPS;
+		else 
+			num = POLLFD_PER_PAGE;
+		if (num > i) 
+			num = i;
+		size = sizeof(struct poll_list) + sizeof(struct pollfd)*num;
+		if (!stack_pp)
+			stack_pp = pp = (struct poll_list *)stack_pps;
+		else {
+			pp = kmalloc(size, GFP_KERNEL);
+			if (!pp)
+				goto out_fds;
+		}
 		pp->next=NULL;
-		pp->len = (i>POLLFD_PER_PAGE?POLLFD_PER_PAGE:i);
+		pp->len = num;
 		if (head == NULL)
 			head = pp;
 		else
@@ -513,7 +533,7 @@ asmlinkage long sys_poll(struct pollfd _
 
 		walk = pp;
 		if (copy_from_user(pp->entries, ufds + nfds-i, 
-				sizeof(struct pollfd)*pp->len)) {
+				sizeof(struct pollfd)*num)) {
 			err = -EFAULT;
 			goto out_fds;
 		}
@@ -541,7 +561,8 @@ out_fds:
 	walk = head;
 	while(walk!=NULL) {
 		struct poll_list *pp = walk->next;
-		kfree(walk);
+		if (walk != stack_pp)
+			kfree(walk);
 		walk = pp;
 	}
 	poll_freewait(&table);
Index: linux-2.6.15rc7-work/include/linux/poll.h
===================================================================
--- linux-2.6.15rc7-work.orig/include/linux/poll.h
+++ linux-2.6.15rc7-work/include/linux/poll.h
@@ -11,6 +11,15 @@
 #include <linux/mm.h>
 #include <asm/uaccess.h>
 
+/* ~832 bytes of stack space used max in sys_select/sys_poll before allocating 
+   additional memory. */
+#define MAX_STACK_ALLOC 832
+#define FRONTEND_STACK_ALLOC  256
+#define SELECT_STACK_ALLOC    FRONTEND_STACK_ALLOC
+#define POLL_STACK_ALLOC      FRONTEND_STACK_ALLOC
+#define WQUEUES_STACK_ALLOC   (MAX_STACK_ALLOC - FRONTEND_STACK_ALLOC)
+#define N_INLINE_POLL_ENTRIES (WQUEUES_STACK_ALLOC / sizeof(struct poll_table_entry))
+
 struct poll_table_struct;
 
 /* 
@@ -33,13 +42,21 @@ static inline void init_poll_funcptr(pol
 	pt->qproc = qproc;
 }
 
+struct poll_table_entry {
+	struct file * filp;
+	wait_queue_t wait;
+	wait_queue_head_t * wait_address;
+};
+
 /*
  * Structures and helpers for sys_poll/sys_poll
  */
-struct poll_wqueues {
-	poll_table pt;
+struct poll_wqueues {	
+	poll_table pt;	
 	struct poll_table_page * table;
 	int error;
+	int inline_index; 
+	struct poll_table_entry inline_entries[N_INLINE_POLL_ENTRIES];
 };
 
 extern void poll_initwait(struct poll_wqueues *pwq);
