Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262838AbSKTWxY>; Wed, 20 Nov 2002 17:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262875AbSKTWxY>; Wed, 20 Nov 2002 17:53:24 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:16270 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S262838AbSKTWxI>;
	Wed, 20 Nov 2002 17:53:08 -0500
Message-ID: <3DDC13F8.2030805@colorfullife.com>
Date: Thu, 21 Nov 2002 00:00:08 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC] 6 sys_poll/sys_select performance patches
Content-Type: multipart/mixed;
 boundary="------------060507000103040608070802"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060507000103040608070802
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Attached are 6 patches that try to improve the performance of sys_poll 
and sys_select:

- avoid dynamic memory allocations, stack storage is sufficient for most 
callers and faster.
- use the wakeup callbacks and use that info to speed up the 2nd scan 
for new events.

What do you think? Are there any apps/tests/benchmarks that stress 
sys_poll or sys_select?

The first 3 patches replace dynamic memory allocations with stack storage.
The 4th and 5th patch use wait queue callbacks for a more efficient 2nd 
scan.
The 6th patch merges common code.

The patch is against 2.5.48 - they do boot on my laptop, but that's all 
I can guarantee.

--
    Manfred

--------------060507000103040608070802
Content-Type: text/plain;
 name="patch-poll-1-wqalloc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-poll-1-wqalloc"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 5
//  SUBLEVEL = 48
//  EXTRAVERSION =
--- 2.5/include/linux/poll.h	2002-11-19 23:07:35.000000000 +0100
+++ build-2.5/include/linux/poll.h	2002-11-19 23:12:11.000000000 +0100
@@ -35,10 +35,20 @@
 /*
  * Structures and helpers for sys_poll/sys_poll
  */
+struct poll_table_entry {
+	struct file *filp;
+	wait_queue_t wait;
+	wait_queue_head_t *wait_address;
+};
+
+#define POLL_TABLE_INTERNAL	6
+
 struct poll_wqueues {
 	poll_table pt;
-	struct poll_table_page * table;
 	int error;
+	int nr;
+	struct poll_table_entry internal[POLL_TABLE_INTERNAL];
+	struct poll_table_page *table;
 };
 
 extern void poll_initwait(struct poll_wqueues *pwq);
--- 2.5/fs/select.c	2002-11-19 23:07:35.000000000 +0100
+++ build-2.5/fs/select.c	2002-11-19 23:10:50.000000000 +0100
@@ -26,12 +26,6 @@
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
@@ -53,18 +47,36 @@
  * as all select/poll functions have to call it to add an entry to the
  * poll table.
  */
-void __pollwait(struct file *filp, wait_queue_head_t *wait_address, poll_table *p);
+static void __pollwait(struct file *filp, wait_queue_head_t *wait_address, poll_table *p);
 
 void poll_initwait(struct poll_wqueues *pwq)
 {
 	init_poll_funcptr(&pwq->pt, __pollwait);
 	pwq->error = 0;
+	pwq->nr = 0;
 	pwq->table = NULL;
 }
+/*
+ * Dynamic memory allocation is expensive, avoid it by
+ * saving a few bytes on the stack:
+ * - the poll table contains 6 wait queue entries. This means that no dynamic
+ *   memory allocation is necessary for the wait queues if one of the first
+ *   6 file descriptors has new data.
+ * <manfred@colorfullife.com>
+ */
 
 void poll_freewait(struct poll_wqueues *pwq)
 {
 	struct poll_table_page * p = pwq->table;
+	struct poll_table_entry *entry;
+
+	entry = pwq->internal + pwq->nr;
+	while(pwq->nr > 0) {
+		pwq->nr--;
+		entry--;
+		remove_wait_queue(entry->wait_address,&entry->wait);
+		fput(entry->filp);
+	}
 	while (p) {
 		struct poll_table_entry * entry;
 		struct poll_table_page *old;
@@ -77,43 +89,46 @@
 		} while (entry > p->entries);
 		old = p;
 		p = p->next;
-		free_page((unsigned long) old);
+		kfree(old);
 	}
 }
 
-void __pollwait(struct file *filp, wait_queue_head_t *wait_address, poll_table *_p)
+static void __pollwait(struct file *filp, wait_queue_head_t *wait_address, poll_table *_p)
 {
 	struct poll_wqueues *p = container_of(_p, struct poll_wqueues, pt);
-	struct poll_table_page *table = p->table;
-
-	if (!table || POLL_TABLE_FULL(table)) {
-		struct poll_table_page *new_table;
-
-		new_table = (struct poll_table_page *) __get_free_page(GFP_KERNEL);
-		if (!new_table) {
-			p->error = -ENOMEM;
-			__set_current_state(TASK_RUNNING);
-			return;
+	struct poll_table_entry *entry;
+  
+ 	if(p->nr < POLL_TABLE_INTERNAL) {
+ 		entry = p->internal+p->nr++;
+ 	} else {
+		struct poll_table_page *table = p->table;
+
+		if (!table || POLL_TABLE_FULL(table)) {
+			struct poll_table_page *new_table;
+
+			new_table = kmalloc(PAGE_SIZE, GFP_KERNEL);
+			if (!new_table) {
+				p->error = -ENOMEM;
+				__set_current_state(TASK_RUNNING);
+				return;
+			}
+			new_table->entry = new_table->entries;
+			new_table->next = table;
+			p->table = new_table;
+			table = new_table;
 		}
-		new_table->entry = new_table->entries;
-		new_table->next = table;
-		p->table = new_table;
-		table = new_table;
+		entry = table->entry;
+		table->entry = entry+1;
 	}
 
 	/* Add a new entry */
-	{
-		struct poll_table_entry * entry = table->entry;
-		table->entry = entry+1;
-	 	get_file(filp);
-	 	entry->filp = filp;
-		entry->wait_address = wait_address;
-		init_waitqueue_entry(&entry->wait, current);
-		add_wait_queue(wait_address,&entry->wait);
-	}
+	get_file(filp);
+	entry->filp = filp;
+	entry->wait_address = wait_address;
+	init_waitqueue_entry(&entry->wait, current);
+	add_wait_queue(wait_address,&entry->wait);
 }
 
-
 #define __IN(fds, n)		(fds->in + n)
 #define __OUT(fds, n)		(fds->out + n)
 #define __EX(fds, n)		(fds->ex + n)

--------------060507000103040608070802
Content-Type: text/plain;
 name="patch-poll-2-selectalloc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-poll-2-selectalloc"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 5
//  SUBLEVEL = 48
//  EXTRAVERSION =
--- 2.5/fs/select.c	2002-11-20 19:08:58.000000000 +0100
+++ build-2.5/fs/select.c	2002-11-20 19:00:11.000000000 +0100
@@ -62,6 +62,7 @@
  * - the poll table contains 6 wait queue entries. This means that no dynamic
  *   memory allocation is necessary for the wait queues if one of the first
  *   6 file descriptors has new data.
+ * - sys_select saves 192 bytes on the stack, enough for 256 file descriptors.
  * <manfred@colorfullife.com>
  */
 
@@ -261,14 +262,18 @@
 	return retval;
 }
 
-static void *select_bits_alloc(int size)
+#define SELECT_INLINE_BYTES	32
+static inline void *select_bits_alloc(int size, void *internal)
 {
+	if(size <= SELECT_INLINE_BYTES)
+		return internal;
 	return kmalloc(6 * size, GFP_KERNEL);
 }
 
-static void select_bits_free(void *bits, int size)
+static inline void select_bits_free(void *bits, void *internal)
 {
-	kfree(bits);
+	if(bits != internal)
+		kfree(bits);
 }
 
 /*
@@ -286,6 +291,7 @@
 sys_select(int n, fd_set *inp, fd_set *outp, fd_set *exp, struct timeval *tvp)
 {
 	fd_set_bits fds;
+	char ibuf[6*SELECT_INLINE_BYTES];
 	char *bits;
 	long timeout;
 	int ret, size, max_fdset;
@@ -325,7 +331,7 @@
 	 */
 	ret = -ENOMEM;
 	size = FDS_BYTES(n);
-	bits = select_bits_alloc(size);
+	bits = select_bits_alloc(size, ibuf);
 	if (!bits)
 		goto out_nofds;
 	fds.in      = (unsigned long *)  bits;
@@ -370,7 +376,7 @@
 	set_fd_set(n, exp, fds.res_ex);
 
 out:
-	select_bits_free(bits, size);
+	select_bits_free(bits, ibuf);
 out_nofds:
 	return ret;
 }

--------------060507000103040608070802
Content-Type: text/plain;
 name="patch-poll-3-alloc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-poll-3-alloc"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 5
//  SUBLEVEL = 48
//  EXTRAVERSION =
--- 2.5/fs/select.c	2002-11-20 00:32:46.000000000 +0100
+++ build-2.5/fs/select.c	2002-11-20 00:33:46.000000000 +0100
@@ -63,6 +63,7 @@
  *   memory allocation is necessary for the wait queues if one of the first
  *   6 file descriptors has new data.
  * - sys_select saves 192 bytes on the stack, enough for 256 file descriptors.
+ * - sys_poll saves 190 byte of user space buffers on the stack.
  * <manfred@colorfullife.com>
  */
 
@@ -381,7 +382,13 @@
 	return ret;
 }
 
-#define POLLFD_PER_PAGE  ((PAGE_SIZE) / sizeof(struct pollfd))
+struct poll_list {
+	struct poll_list *next;
+	int len;
+	struct pollfd entries[0];
+};
+
+#define POLLFD_PER_PAGE  ((PAGE_SIZE-sizeof(struct poll_list)) / sizeof(struct pollfd))
 
 static void do_pollfd(unsigned int num, struct pollfd * fdpage,
 	poll_table ** pwait, int *count)
@@ -415,21 +422,23 @@
 	}
 }
 
-static int do_poll(unsigned int nfds, unsigned int nchunks, unsigned int nleft, 
-	struct pollfd *fds[], struct poll_wqueues *wait, long timeout)
+static int do_poll(unsigned int nfds,  struct poll_list *list,
+			struct poll_wqueues *wait, long timeout)
 {
-	int count;
+	int count = 0;
 	poll_table* pt = &wait->pt;
 
+	if (!timeout)
+		pt = NULL;
+ 
 	for (;;) {
-		unsigned int i;
-
+		struct poll_list *walk;
 		set_current_state(TASK_INTERRUPTIBLE);
-		count = 0;
-		for (i=0; i < nchunks; i++)
-			do_pollfd(POLLFD_PER_PAGE, fds[i], &pt, &count);
-		if (nleft)
-			do_pollfd(nleft, fds[nchunks], &pt, &count);
+		walk = list;
+		while(walk != NULL) {
+			do_pollfd( walk->len, walk->entries, &pt, &count);
+			walk = walk->next;
+		}
 		pt = NULL;
 		if (count || !timeout || signal_pending(current))
 			break;
@@ -442,12 +451,17 @@
 	return count;
 }
 
+#define INLINE_POLL_COUNT	((190+sizeof(struct pollfd))/sizeof(struct pollfd))
 asmlinkage long sys_poll(struct pollfd * ufds, unsigned int nfds, long timeout)
 {
-	int i, j, fdcount, err;
-	struct pollfd **fds;
-	struct poll_wqueues table, *wait;
-	int nchunks, nleft;
+	struct poll_wqueues table;
+ 	int fdcount, err;
+ 	unsigned int i;
+	struct {
+		struct poll_list head;
+		struct pollfd entries[INLINE_POLL_COUNT];
+	} polldata;
+ 	struct poll_list *pollwalk;
 
 	/* Do a sanity check on nfds ... */
 	if (nfds > NR_OPEN)
@@ -462,68 +476,60 @@
 	}
 
 	poll_initwait(&table);
-	wait = &table;
-	if (!timeout)
-		wait = NULL;
+	polldata.head.next = NULL;
+	polldata.head.len = INLINE_POLL_COUNT;
+	if(nfds <= INLINE_POLL_COUNT)
+		polldata.head.len = nfds;
 
+	pollwalk = &polldata.head;
+	i = nfds;
 	err = -ENOMEM;
-	fds = NULL;
-	if (nfds != 0) {
-		fds = (struct pollfd **)kmalloc(
-			(1 + (nfds - 1) / POLLFD_PER_PAGE) * sizeof(struct pollfd *),
-			GFP_KERNEL);
-		if (fds == NULL)
-			goto out;
-	}
-
-	nchunks = 0;
-	nleft = nfds;
-	while (nleft > POLLFD_PER_PAGE) { /* allocate complete PAGE_SIZE chunks */
-		fds[nchunks] = (struct pollfd *)__get_free_page(GFP_KERNEL);
-		if (fds[nchunks] == NULL)
+	goto start;
+	while(i!=0) {
+		struct poll_list *pp;
+		pp = kmalloc(sizeof(struct poll_list)+
+				sizeof(struct pollfd)*
+				(i>POLLFD_PER_PAGE?POLLFD_PER_PAGE:i),
+					GFP_KERNEL);
+		if(pp==NULL)
 			goto out_fds;
-		nchunks++;
-		nleft -= POLLFD_PER_PAGE;
-	}
-	if (nleft) { /* allocate last PAGE_SIZE chunk, only nleft elements used */
-		fds[nchunks] = (struct pollfd *)__get_free_page(GFP_KERNEL);
-		if (fds[nchunks] == NULL)
+		pp->next=NULL;
+		pp->len = (i>POLLFD_PER_PAGE?POLLFD_PER_PAGE:i);
+		pollwalk->next = pp;
+		pollwalk = pp;
+start:
+		if (copy_from_user(pollwalk+1, ufds + nfds-i, 
+				sizeof(struct pollfd)*pollwalk->len)) {
+			err = -EFAULT;
 			goto out_fds;
+		}
+		i -= pollwalk->len;
 	}
-
-	err = -EFAULT;
-	for (i=0; i < nchunks; i++)
-		if (copy_from_user(fds[i], ufds + i*POLLFD_PER_PAGE, PAGE_SIZE))
-			goto out_fds1;
-	if (nleft) {
-		if (copy_from_user(fds[nchunks], ufds + nchunks*POLLFD_PER_PAGE, 
-				nleft * sizeof(struct pollfd)))
-			goto out_fds1;
-	}
-
-	fdcount = do_poll(nfds, nchunks, nleft, fds, wait, timeout);
+	fdcount = do_poll(nfds, &polldata.head,	&table, timeout);
 
 	/* OK, now copy the revents fields back to user space. */
-	for(i=0; i < nchunks; i++)
-		for (j=0; j < POLLFD_PER_PAGE; j++, ufds++)
-			__put_user((fds[i] + j)->revents, &ufds->revents);
-	if (nleft)
-		for (j=0; j < nleft; j++, ufds++)
-			__put_user((fds[nchunks] + j)->revents, &ufds->revents);
-
+	pollwalk = &polldata.head;
+	err = -EFAULT;
+	while(pollwalk != NULL) {
+		struct pollfd *fds = pollwalk->entries;
+		int j;
+
+		for (j=0; j < pollwalk->len; j++, ufds++) {
+			if(__put_user(fds[j].revents, &ufds->revents))
+				goto out_fds;
+		}
+		pollwalk = pollwalk->next;
+  	}
 	err = fdcount;
 	if (!fdcount && signal_pending(current))
 		err = -EINTR;
-
-out_fds1:
-	if (nleft)
-		free_page((unsigned long)(fds[nchunks]));
 out_fds:
-	for (i=0; i < nchunks; i++)
-		free_page((unsigned long)(fds[i]));
-	if (nfds != 0)
-		kfree(fds);
-out:
+	pollwalk = polldata.head.next;
+	while(pollwalk!=NULL) {
+		struct poll_list *pp = pollwalk->next;
+		kfree(pollwalk);
+		pollwalk = pp;
+	}
 	poll_freewait(&table);
 	return err;
 }

--------------060507000103040608070802
Content-Type: text/plain;
 name="patch-poll-4-fast-select"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-poll-4-fast-select"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 5
//  SUBLEVEL = 48
//  EXTRAVERSION =
--- 2.5/include/linux/poll.h	2002-11-20 22:58:18.000000000 +0100
+++ build-2.5/include/linux/poll.h	2002-11-20 22:51:15.000000000 +0100
@@ -37,6 +37,8 @@
  */
 struct poll_table_entry {
 	struct file *filp;
+	int woken;
+	void *handle;
 	wait_queue_t wait;
 	wait_queue_head_t *wait_address;
 };
@@ -47,8 +49,10 @@
 	poll_table pt;
 	int error;
 	int nr;
+	void *handle;
 	struct poll_table_entry internal[POLL_TABLE_INTERNAL];
 	struct poll_table_page *table;
+	struct poll_table_page *last;
 };
 
 extern void poll_initwait(struct poll_wqueues *pwq);
--- 2.5/fs/select.c	2002-11-20 22:58:18.000000000 +0100
+++ build-2.5/fs/select.c	2002-11-20 22:58:01.000000000 +0100
@@ -55,6 +55,7 @@
 	pwq->error = 0;
 	pwq->nr = 0;
 	pwq->table = NULL;
+	pwq->last = NULL;
 }
 /*
  * Dynamic memory allocation is expensive, avoid it by
@@ -95,6 +96,15 @@
 	}
 }
 
+static int poll_wake_func(wait_queue_t *wait, unsigned mode, int sync)
+{
+	struct poll_table_entry *entry = container_of(wait, struct poll_table_entry, wait);
+	entry->woken = 1;
+	mb();
+	wake_up_process(wait->task);
+	return 0;
+}
+
 static void __pollwait(struct file *filp, wait_queue_head_t *wait_address, poll_table *_p)
 {
 	struct poll_wqueues *p = container_of(_p, struct poll_wqueues, pt);
@@ -103,7 +113,7 @@
  	if(p->nr < POLL_TABLE_INTERNAL) {
  		entry = p->internal+p->nr++;
  	} else {
-		struct poll_table_page *table = p->table;
+		struct poll_table_page *table = p->last;
 
 		if (!table || POLL_TABLE_FULL(table)) {
 			struct poll_table_page *new_table;
@@ -115,8 +125,12 @@
 				return;
 			}
 			new_table->entry = new_table->entries;
-			new_table->next = table;
-			p->table = new_table;
+			new_table->next = NULL;
+			if (table)
+				table->next = new_table;
+			else
+				p->table = new_table;
+			p->last = new_table;
 			table = new_table;
 		}
 		entry = table->entry;
@@ -127,7 +141,10 @@
 	get_file(filp);
 	entry->filp = filp;
 	entry->wait_address = wait_address;
-	init_waitqueue_entry(&entry->wait, current);
+	entry->woken = 0;
+	entry->handle = p->handle;
+	init_waitqueue_func_entry(&entry->wait, poll_wake_func);
+	entry->wait.task = current;
 	add_wait_queue(wait_address,&entry->wait);
 }
 
@@ -189,6 +206,51 @@
 #define POLLOUT_SET (POLLWRBAND | POLLWRNORM | POLLOUT | POLLERR)
 #define POLLEX_SET (POLLPRI)
 
+static int parse_mask(fd_set_bits *fds, unsigned long mask, unsigned long off, unsigned long bit)
+{
+	int retval = 0;
+
+	if ((mask & POLLIN_SET) && ISSET(bit, __IN(fds,off))) {
+		SET(bit, __RES_IN(fds,off));
+		retval++;
+	}
+	if ((mask & POLLOUT_SET) && ISSET(bit, __OUT(fds,off))) {
+		SET(bit, __RES_OUT(fds,off));
+		retval++;
+	}
+	if ((mask & POLLEX_SET) && ISSET(bit, __EX(fds,off))) {
+		SET(bit, __RES_EX(fds,off));
+		retval++;
+	}
+	return retval;
+}
+
+static int scan_entries(fd_set_bits *fds, struct poll_table_entry *entries, int size, int *prev)
+{
+	int i;
+	int retval = 0;
+	for (i=0;i<size;i++) {
+		unsigned long mask;
+		int fd;
+		if (!entries[i].woken)
+	       		continue;
+		entries[i].woken = 0;
+		mb();
+		/* drivers are permitted to use multiple waitqueues, but we must
+		 * not double-account that in the return value
+		 */
+		fd = (int)entries[i].handle;
+		if (fd == *prev)
+			continue;
+		*prev = fd;
+		mask = DEFAULT_POLLMASK;
+		if (entries[i].filp->f_op && entries[i].filp->f_op->poll)
+			mask = entries[i].filp->f_op->poll(entries[i].filp, NULL);
+		retval += parse_mask(fds, mask, fd/__NFDBITS, BIT(fd));
+	}
+	return retval;
+}
+
 int do_select(int n, fd_set_bits *fds, long *timeout)
 {
 	struct poll_wqueues table;
@@ -209,41 +271,35 @@
 	if (!__timeout)
 		wait = NULL;
 	retval = 0;
-	for (;;) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		for (i = 0 ; i < n; i++) {
-			unsigned long bit = BIT(i);
-			unsigned long mask;
-			struct file *file;
-
-			off = i / __NFDBITS;
-			if (!(bit & BITS(fds, off)))
-				continue;
-			file = fget(i);
-			mask = POLLNVAL;
-			if (file) {
-				mask = DEFAULT_POLLMASK;
-				if (file->f_op && file->f_op->poll)
-					mask = file->f_op->poll(file, wait);
-				fput(file);
-			}
-			if ((mask & POLLIN_SET) && ISSET(bit, __IN(fds,off))) {
-				SET(bit, __RES_IN(fds,off));
-				retval++;
-				wait = NULL;
-			}
-			if ((mask & POLLOUT_SET) && ISSET(bit, __OUT(fds,off))) {
-				SET(bit, __RES_OUT(fds,off));
-				retval++;
-				wait = NULL;
-			}
-			if ((mask & POLLEX_SET) && ISSET(bit, __EX(fds,off))) {
-				SET(bit, __RES_EX(fds,off));
-				retval++;
-				wait = NULL;
-			}
+	/* step one: build the wait table */
+	set_current_state(TASK_INTERRUPTIBLE);
+	for (i = 0 ; i < n; i++) {
+		unsigned long bit = BIT(i);
+		unsigned long mask;
+		struct file *file;
+
+		off = i / __NFDBITS;
+		if (!(bit & BITS(fds, off)))
+			continue;
+		file = fget(i);
+		mask = POLLNVAL;
+		if (file) {
+			mask = DEFAULT_POLLMASK;
+			table.handle = (void*)i;
+			if (file->f_op && file->f_op->poll)
+				mask = file->f_op->poll(file, wait);
+			fput(file);
 		}
-		wait = NULL;
+		retval += parse_mask(fds, mask, off, bit);
+		if (retval)
+			wait = NULL;
+	}
+	wait = NULL;
+	/* step two: now scan through the wait queues, that's faster
+	 * than the bit lookup */
+	for (;;) {
+		struct poll_table_page *pg;
+		int prev;
 		if (retval || !__timeout || signal_pending(current))
 			break;
 		if(table.error) {
@@ -251,6 +307,14 @@
 			break;
 		}
 		__timeout = schedule_timeout(__timeout);
+		set_current_state(TASK_INTERRUPTIBLE);
+		prev = -1;
+		retval += scan_entries(fds, table.internal, table.nr, &prev);
+		pg = table.table;
+		while (pg) {
+			retval += scan_entries(fds, pg->entries, pg->entry-pg->entries, &prev);
+			pg = pg->next;
+		}
 	}
 	current->state = TASK_RUNNING;
 

--------------060507000103040608070802
Content-Type: text/plain;
 name="patch-poll-5-fast-poll"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-poll-5-fast-poll"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 5
//  SUBLEVEL = 48
//  EXTRAVERSION =
--- 2.5/fs/select.c	2002-11-20 22:59:34.000000000 +0100
+++ build-2.5/fs/select.c	2002-11-20 22:59:25.000000000 +0100
@@ -225,7 +225,7 @@
 	return retval;
 }
 
-static int scan_entries(fd_set_bits *fds, struct poll_table_entry *entries, int size, int *prev)
+static int scan_select_entries(fd_set_bits *fds, struct poll_table_entry *entries, int size, int *prev)
 {
 	int i;
 	int retval = 0;
@@ -294,7 +294,6 @@
 		if (retval)
 			wait = NULL;
 	}
-	wait = NULL;
 	/* step two: now scan through the wait queues, that's faster
 	 * than the bit lookup */
 	for (;;) {
@@ -309,10 +308,10 @@
 		__timeout = schedule_timeout(__timeout);
 		set_current_state(TASK_INTERRUPTIBLE);
 		prev = -1;
-		retval += scan_entries(fds, table.internal, table.nr, &prev);
+		retval = scan_select_entries(fds, table.internal, table.nr, &prev);
 		pg = table.table;
 		while (pg) {
-			retval += scan_entries(fds, pg->entries, pg->entry-pg->entries, &prev);
+			retval += scan_select_entries(fds, pg->entries, pg->entry-pg->entries, &prev);
 			pg = pg->next;
 		}
 	}
@@ -455,7 +454,7 @@
 #define POLLFD_PER_PAGE  ((PAGE_SIZE-sizeof(struct poll_list)) / sizeof(struct pollfd))
 
 static void do_pollfd(unsigned int num, struct pollfd * fdpage,
-	poll_table ** pwait, int *count)
+	struct poll_wqueues **pwait, int *count)
 {
 	int i;
 
@@ -471,9 +470,11 @@
 			struct file * file = fget(fd);
 			mask = POLLNVAL;
 			if (file != NULL) {
+				if (*pwait)
+					(*pwait)->handle = fdp;
 				mask = DEFAULT_POLLMASK;
 				if (file->f_op && file->f_op->poll)
-					mask = file->f_op->poll(file, *pwait);
+					mask = file->f_op->poll(file, &(*pwait)->pt);
 				mask &= fdp->events | POLLERR | POLLHUP;
 				fput(file);
 			}
@@ -486,30 +487,74 @@
 	}
 }
 
+static int scan_poll_entries(struct poll_table_entry *entries, int size, void **prev)
+{
+	int retval = 0;
+	int i;
+
+	for (i=0;i<size;i++) {
+		unsigned long mask;
+		struct pollfd *fdp;
+
+		if (!entries[i].woken)
+	       		continue;
+		entries[i].woken = 0;
+		mb();
+		/* drivers are permitted to use multiple waitqueues, but we must
+		 * not double-account that in the return value
+		 */
+		fdp = entries[i].handle;
+		if (fdp == *prev)
+			continue;
+		*prev = fdp;
+		mask = DEFAULT_POLLMASK;
+		if (entries[i].filp->f_op && entries[i].filp->f_op->poll)
+			mask = entries[i].filp->f_op->poll(entries[i].filp, NULL);
+		mask &= fdp->events | POLLERR | POLLHUP;
+		if (mask) {
+			retval++;
+			fdp->revents = mask;
+		}
+	}
+	return retval;
+}
+
 static int do_poll(unsigned int nfds,  struct poll_list *list,
 			struct poll_wqueues *wait, long timeout)
 {
+	struct poll_list *walk;
 	int count = 0;
-	poll_table* pt = &wait->pt;
+	struct poll_wqueues *pt = wait;
 
 	if (!timeout)
 		pt = NULL;
- 
+
+	set_current_state(TASK_INTERRUPTIBLE);
+	walk = list;
+	while(walk != NULL) {
+		do_pollfd( walk->len, walk->entries, &pt, &count);
+		walk = walk->next;
+	}
+	pt = NULL;
 	for (;;) {
-		struct poll_list *walk;
-		set_current_state(TASK_INTERRUPTIBLE);
-		walk = list;
-		while(walk != NULL) {
-			do_pollfd( walk->len, walk->entries, &pt, &count);
-			walk = walk->next;
-		}
-		pt = NULL;
+		struct poll_table_page *pg;
+		void *prev;
+
 		if (count || !timeout || signal_pending(current))
 			break;
 		count = wait->error;
 		if (count)
 			break;
 		timeout = schedule_timeout(timeout);
+
+		set_current_state(TASK_INTERRUPTIBLE);
+		prev = NULL;
+		count = scan_poll_entries(wait->internal, wait->nr, &prev);
+		pg = wait->table;
+		while (pg) {
+			count += scan_poll_entries(pg->entries, pg->entry-pg->entries, &prev);
+			pg = pg->next;
+		}
 	}
 	current->state = TASK_RUNNING;
 	return count;

--------------060507000103040608070802
Content-Type: text/plain;
 name="patch-poll-6-merge"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-poll-6-merge"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 5
//  SUBLEVEL = 48
//  EXTRAVERSION =
--- 2.5/fs/select.c	2002-11-20 23:25:46.000000000 +0100
+++ build-2.5/fs/select.c	2002-11-20 23:21:51.000000000 +0100
@@ -225,13 +225,16 @@
 	return retval;
 }
 
-static int scan_select_entries(fd_set_bits *fds, struct poll_table_entry *entries, int size, int *prev)
+static int scan_entries(struct poll_table_entry *entries, int size, void **prev,
+				int (*actor)(void *priv, void *handle, unsigned long mask), void *priv)
 {
-	int i;
 	int retval = 0;
+	int i;
+
 	for (i=0;i<size;i++) {
 		unsigned long mask;
-		int fd;
+		void *handle;
+
 		if (!entries[i].woken)
 	       		continue;
 		entries[i].woken = 0;
@@ -239,18 +242,51 @@
 		/* drivers are permitted to use multiple waitqueues, but we must
 		 * not double-account that in the return value
 		 */
-		fd = (int)entries[i].handle;
-		if (fd == *prev)
+		handle = entries[i].handle;
+		if (handle == *prev)
 			continue;
-		*prev = fd;
+		*prev = handle;
 		mask = DEFAULT_POLLMASK;
 		if (entries[i].filp->f_op && entries[i].filp->f_op->poll)
 			mask = entries[i].filp->f_op->poll(entries[i].filp, NULL);
-		retval += parse_mask(fds, mask, fd/__NFDBITS, BIT(fd));
+		retval += actor(priv, handle, mask);
+
 	}
 	return retval;
 }
 
+static int wait_for_events(struct poll_wqueues *wait, long *timeout,
+				int (*actor)(void *priv, void *handle, unsigned long mask), void *priv)
+{
+	int count = 0;
+	for (;;) {
+		struct poll_table_page *pg;
+		void *prev;
+		if (count || !(*timeout) || signal_pending(current))
+			break;
+		count = wait->error;
+		if (count)
+			break;
+		*timeout = schedule_timeout(*timeout);
+
+		set_current_state(TASK_INTERRUPTIBLE);
+		prev = NULL;
+		count = scan_entries(wait->internal, wait->nr, &prev, actor, priv);
+		pg = wait->table;
+		while (pg) {
+			count += scan_entries(pg->entries, pg->entry-pg->entries, &prev, actor, priv);
+			pg = pg->next;
+		}
+	}
+	return count;
+}
+
+static int select_actor(void *priv, void *handle, unsigned long mask)
+{
+	int fd = (int)handle;
+	return parse_mask(priv, mask, fd/__NFDBITS, BIT(fd));
+}
+
 int do_select(int n, fd_set_bits *fds, long *timeout)
 {
 	struct poll_wqueues table;
@@ -294,27 +330,8 @@
 		if (retval)
 			wait = NULL;
 	}
-	/* step two: now scan through the wait queues, that's faster
-	 * than the bit lookup */
-	for (;;) {
-		struct poll_table_page *pg;
-		int prev;
-		if (retval || !__timeout || signal_pending(current))
-			break;
-		if(table.error) {
-			retval = table.error;
-			break;
-		}
-		__timeout = schedule_timeout(__timeout);
-		set_current_state(TASK_INTERRUPTIBLE);
-		prev = -1;
-		retval = scan_select_entries(fds, table.internal, table.nr, &prev);
-		pg = table.table;
-		while (pg) {
-			retval += scan_select_entries(fds, pg->entries, pg->entry-pg->entries, &prev);
-			pg = pg->next;
-		}
-	}
+	if (!retval && __timeout)
+		retval = wait_for_events(&table, &__timeout, select_actor, fds);
 	current->state = TASK_RUNNING;
 
 	poll_freewait(&table);
@@ -487,36 +504,16 @@
 	}
 }
 
-static int scan_poll_entries(struct poll_table_entry *entries, int size, void **prev)
+int poll_actor(void *priv, void *handle, unsigned long mask)
 {
-	int retval = 0;
-	int i;
-
-	for (i=0;i<size;i++) {
-		unsigned long mask;
-		struct pollfd *fdp;
+	struct pollfd *fdp = handle;
 
-		if (!entries[i].woken)
-	       		continue;
-		entries[i].woken = 0;
-		mb();
-		/* drivers are permitted to use multiple waitqueues, but we must
-		 * not double-account that in the return value
-		 */
-		fdp = entries[i].handle;
-		if (fdp == *prev)
-			continue;
-		*prev = fdp;
-		mask = DEFAULT_POLLMASK;
-		if (entries[i].filp->f_op && entries[i].filp->f_op->poll)
-			mask = entries[i].filp->f_op->poll(entries[i].filp, NULL);
-		mask &= fdp->events | POLLERR | POLLHUP;
-		if (mask) {
-			retval++;
-			fdp->revents = mask;
-		}
+	mask &= fdp->events | POLLERR | POLLHUP;
+	if (mask) {
+		fdp->revents = mask;
+		return 1;
 	}
-	return retval;
+	return 0;
 }
 
 static int do_poll(unsigned int nfds,  struct poll_list *list,
@@ -535,27 +532,8 @@
 		do_pollfd( walk->len, walk->entries, &pt, &count);
 		walk = walk->next;
 	}
-	pt = NULL;
-	for (;;) {
-		struct poll_table_page *pg;
-		void *prev;
-
-		if (count || !timeout || signal_pending(current))
-			break;
-		count = wait->error;
-		if (count)
-			break;
-		timeout = schedule_timeout(timeout);
-
-		set_current_state(TASK_INTERRUPTIBLE);
-		prev = NULL;
-		count = scan_poll_entries(wait->internal, wait->nr, &prev);
-		pg = wait->table;
-		while (pg) {
-			count += scan_poll_entries(pg->entries, pg->entry-pg->entries, &prev);
-			pg = pg->next;
-		}
-	}
+	if (!count && timeout)
+		count = wait_for_events(wait, &timeout, poll_actor, NULL);
 	current->state = TASK_RUNNING;
 	return count;
 }

--------------060507000103040608070802--

