Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293488AbSBZCWD>; Mon, 25 Feb 2002 21:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293489AbSBZCV5>; Mon, 25 Feb 2002 21:21:57 -0500
Received: from dsl-65-185-109-125.telocity.com ([65.185.109.125]:42370 "EHLO
	ohdarn.net") by vger.kernel.org with ESMTP id <S293488AbSBZCVq>;
	Mon, 25 Feb 2002 21:21:46 -0500
Date: Mon, 25 Feb 2002 21:21:48 -0500
From: Michael Cohen <me@ohdarn.net>
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br
Subject: Submissions for 2.4.19-pre [Pollselect Speedups (Manfred Spraul)]
Message-Id: <20020225212148.3bb0925a.me@ohdarn.net>
Organization: OhDarn.net
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the seventh of several mails containing patches to be included
in 2.4.19. Some are worthy of dicussion prior to inclusion and have been
marked as such.  The majority of these patches were found on lkml; the
remaining ones have URLs listed.

This one was found on lkml.

------
Michael Cohen
OhDarn.net


diff -Nur linux-2.4.17-mjc2-pre2/fs/select.c linux-2.4.17-mjc2-pre2.1/fs/select.c
--- linux-2.4.17-mjc2-pre2/fs/select.c	Mon Sep 10 22:04:33 2001
+++ linux-2.4.17-mjc2-pre2.1/fs/select.c	Wed Jan  2 02:23:55 2002
@@ -25,12 +25,6 @@
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
@@ -53,11 +47,36 @@
  * poll table.
  */
 
+/*
+ * Memory free and alloc took a significant part of the total
+ * sys_poll()/sys_select() execution time, thus I moved several
+ * structures on the stack:
+ * - sys_select has a 192 byte (enough for 256 fds) buffer on the stack.
+ *   Please avoid selecting more than 5000 descriptors
+ *   (kmalloc > 4096 bytes), and you can't select
+ *   more than 170.000 fds (kmalloc > 128 kB)
+ * - sys_poll stores the first 24 file descriptors on the
+ *   stack. If more than 24 descriptors are polled, then
+ *   additional memory is allocated, but the first 24 descriptors
+ *   always lie on the stack.
+ * - the poll table contains 8 wait queue entries. This means that no dynamic
+ *   memory allocation is necessary for the wait queues if one of the first
+ *   8 file descriptors has new data.
+ * <manfred@colorfullife.com>
+ */
+
 void poll_freewait(poll_table* pt)
 {
 	struct poll_table_page * p = pt->table;
+	struct poll_table_entry * entry;
+	entry = pt->internal + pt->nr;
+	while(pt->nr > 0) {
+		pt->nr--;
+		entry--;
+		remove_wait_queue(entry->wait_address,&entry->wait);
+		fput(entry->filp);
+	}
 	while (p) {
-		struct poll_table_entry * entry;
 		struct poll_table_page *old;
 
 		entry = p->entry;
@@ -68,39 +87,42 @@
 		} while (entry > p->entries);
 		old = p;
 		p = p->next;
-		free_page((unsigned long) old);
+		kfree(old);
 	}
 }
 
 void __pollwait(struct file * filp, wait_queue_head_t * wait_address, poll_table *p)
 {
-	struct poll_table_page *table = p->table;
-
-	if (!table || POLL_TABLE_FULL(table)) {
-		struct poll_table_page *new_table;
+	struct poll_table_entry * entry;
 
-		new_table = (struct poll_table_page *) __get_free_page(GFP_KERNEL);
-		if (!new_table) {
-			p->error = -ENOMEM;
-			__set_current_state(TASK_RUNNING);
-			return;
+	if(p->nr < POLL_TABLE_INTERNAL) {
+		entry = p->internal+p->nr++;
+	} else {
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
-	}
-
-	/* Add a new entry */
-	{
-		struct poll_table_entry * entry = table->entry;
+		entry = table->entry;
 		table->entry = entry+1;
-	 	get_file(filp);
-	 	entry->filp = filp;
-		entry->wait_address = wait_address;
-		init_waitqueue_entry(&entry->wait, current);
-		add_wait_queue(wait_address,&entry->wait);
 	}
+	/* Add a new entry */
+	get_file(filp);
+	entry->filp = filp;
+	entry->wait_address = wait_address;
+	init_waitqueue_entry(&entry->wait, current);
+	add_wait_queue(wait_address,&entry->wait);
 }
 
 #define __IN(fds, n)		(fds->in + n)
@@ -234,14 +256,18 @@
 	return retval;
 }
 
-static void *select_bits_alloc(int size)
+#define SELECT_INLINE_BYTES	32
+static inline void *select_bits_alloc(int size, void* internal)
 {
+	if(size <= SELECT_INLINE_BYTES)
+		return internal;
 	return kmalloc(6 * size, GFP_KERNEL);
 }
 
-static void select_bits_free(void *bits, int size)
+static inline void select_bits_free(void *bits, void* internal)
 {
-	kfree(bits);
+	if(bits != internal)
+		kfree(bits);
 }
 
 /*
@@ -255,10 +281,12 @@
 #define MAX_SELECT_SECONDS \
 	((unsigned long) (MAX_SCHEDULE_TIMEOUT / HZ)-1)
 
+
 asmlinkage long
 sys_select(int n, fd_set *inp, fd_set *outp, fd_set *exp, struct timeval *tvp)
 {
 	fd_set_bits fds;
+	char ibuf[6*SELECT_INLINE_BYTES];
 	char *bits;
 	long timeout;
 	int ret, size, max_fdset;
@@ -298,7 +326,7 @@
 	 */
 	ret = -ENOMEM;
 	size = FDS_BYTES(n);
-	bits = select_bits_alloc(size);
+	bits = select_bits_alloc(size, ibuf);
 	if (!bits)
 		goto out_nofds;
 	fds.in      = (unsigned long *)  bits;
@@ -343,12 +371,18 @@
 	set_fd_set(n, exp, fds.res_ex);
 
 out:
-	select_bits_free(bits, size);
+	select_bits_free(bits, ibuf);
 out_nofds:
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
@@ -382,39 +416,44 @@
 	}
 }
 
-static int do_poll(unsigned int nfds, unsigned int nchunks, unsigned int nleft, 
-	struct pollfd *fds[], poll_table *wait, long timeout)
+static int do_poll(int nfds, struct poll_list *list,
+			poll_table *wait, long timeout)
 {
-	int count;
+	int count = 0;
 	poll_table* pt = wait;
-
+ 
 	for (;;) {
-		unsigned int i;
-
+		struct poll_list* walk;
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
 		count = wait->error;
 		if (count)
 			break;
+
 		timeout = schedule_timeout(timeout);
 	}
 	current->state = TASK_RUNNING;
 	return count;
 }
 
+#define INLINE_POLL_COUNT	24
 asmlinkage long sys_poll(struct pollfd * ufds, unsigned int nfds, long timeout)
 {
-	int i, j, fdcount, err;
-	struct pollfd **fds;
+	int fdcount, err;
+	unsigned int i;
+	struct poll_list *pollwalk;
+	struct {
+		struct poll_list head;
+		struct pollfd entries[INLINE_POLL_COUNT];
+	} polldata;
 	poll_table table, *wait;
-	int nchunks, nleft;
 
 	/* Do a sanity check on nfds ... */
 	if (nfds > NR_OPEN)
@@ -434,63 +473,65 @@
 		wait = NULL;
 
 	err = -ENOMEM;
-	fds = NULL;
-	if (nfds != 0) {
-		fds = (struct pollfd **)kmalloc(
-			(1 + (nfds - 1) / POLLFD_PER_PAGE) * sizeof(struct pollfd *),
-			GFP_KERNEL);
-		if (fds == NULL)
-			goto out;
-	}
+	polldata.head.next = NULL;
+	polldata.head.len = INLINE_POLL_COUNT;
+	if(nfds <= INLINE_POLL_COUNT)
+		polldata.head.len = nfds;
 
-	nchunks = 0;
-	nleft = nfds;
-	while (nleft > POLLFD_PER_PAGE) { /* allocate complete PAGE_SIZE chunks */
-		fds[nchunks] = (struct pollfd *)__get_free_page(GFP_KERNEL);
-		if (fds[nchunks] == NULL)
+	pollwalk = &polldata.head;
+	i = nfds;
+	err = -ENOMEM;
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
+		
+	fdcount = do_poll(nfds, &polldata.head,
+			wait, timeout);
 
+	/* OK, now copy the revents fields back to user space. */
+	i = nfds;
+	pollwalk = &polldata.head;
 	err = -EFAULT;
-	for (i=0; i < nchunks; i++)
-		if (copy_from_user(fds[i], ufds + i*POLLFD_PER_PAGE, PAGE_SIZE))
-			goto out_fds1;
-	if (nleft) {
-		if (copy_from_user(fds[nchunks], ufds + nchunks*POLLFD_PER_PAGE, 
-				nleft * sizeof(struct pollfd)))
-			goto out_fds1;
+	while(pollwalk != NULL) {
+		struct pollfd * fds = pollwalk->entries;
+		int j;
+
+		for (j=0; j < pollwalk->len; j++, ufds++) {
+			if(__put_user(fds[j].revents, &ufds->revents))
+				goto out_fds;
+		}
+		i -= pollwalk->len;
+		pollwalk = pollwalk->next;
 	}
-
-	fdcount = do_poll(nfds, nchunks, nleft, fds, wait, timeout);
-
-	/* OK, now copy the revents fields back to user space. */
-	for(i=0; i < nchunks; i++)
-		for (j=0; j < POLLFD_PER_PAGE; j++, ufds++)
-			__put_user((fds[i] + j)->revents, &ufds->revents);
-	if (nleft)
-		for (j=0; j < nleft; j++, ufds++)
-			__put_user((fds[nchunks] + j)->revents, &ufds->revents);
-
 	err = fdcount;
 	if (!fdcount && signal_pending(current))
 		err = -EINTR;
 
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
diff -Nur linux-2.4.17-mjc2-pre2/include/linux/poll.h linux-2.4.17-mjc2-pre2.1/include/linux/poll.h
--- linux-2.4.17-mjc2-pre2/include/linux/poll.h	Thu Nov 22 20:46:26 2001
+++ linux-2.4.17-mjc2-pre2.1/include/linux/poll.h	Wed Jan  2 02:23:55 2002
@@ -12,9 +12,18 @@
 
 struct poll_table_page;
 
+struct poll_table_entry {
+	struct file * filp;
+	wait_queue_t wait;
+	wait_queue_head_t * wait_address;
+};
+
+#define POLL_TABLE_INTERNAL	8
 typedef struct poll_table_struct {
 	int error;
+	int nr;
 	struct poll_table_page * table;
+	struct poll_table_entry internal[POLL_TABLE_INTERNAL];
 } poll_table;
 
 extern void __pollwait(struct file * filp, wait_queue_head_t * wait_address, poll_table *p);
@@ -28,6 +37,7 @@
 static inline void poll_initwait(poll_table* pt)
 {
 	pt->error = 0;
+	pt->nr = 0;
 	pt->table = NULL;
 }
 extern void poll_freewait(poll_table* pt);


