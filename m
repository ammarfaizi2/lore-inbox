Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129757AbRAEN3B>; Fri, 5 Jan 2001 08:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbRAEN2v>; Fri, 5 Jan 2001 08:28:51 -0500
Received: from colorfullife.com ([216.156.138.34]:64007 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129387AbRAEN2l>;
	Fri, 5 Jan 2001 08:28:41 -0500
Message-ID: <3A55CC1B.602719B3@colorfullife.com>
Date: Fri, 05 Jan 2001 14:28:59 +0100
From: Manfred <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] up to 50% faster sys_poll()
Content-Type: multipart/mixed;
 boundary="------------B640E89F46A42E17A441425D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B640E89F46A42E17A441425D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

sys_poll spends around 1/2 of the execution time allocating / freeing a
few bytes temporary memory.

The attached patch tries to avoid these allocation by using the stack -
usually only a few bytes are needed, kmalloc is used for the rest.

The result: one poll of stdin is down from 1736 cpu ticks to 865 cpu
ticks (Pentium II/350 SMP, SMP kernel)

select() should also be faster, but I haven't written a micro-benchmark
for select.

Please test it,

--
	Manfred
--------------B640E89F46A42E17A441425D
Content-Type: text/plain; charset=us-ascii;
 name="patch-poll"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-poll"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 4
//  SUBLEVEL = 0
//  EXTRAVERSION =
--- 2.4/fs/select.c	Thu Nov 16 21:54:18 2000
+++ build-2.4/fs/select.c	Fri Jan  5 13:46:30 2001
@@ -24,12 +24,6 @@
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
@@ -52,11 +46,36 @@
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
@@ -73,33 +92,36 @@
 
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
@@ -233,14 +255,18 @@
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
@@ -254,10 +280,12 @@
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
 	int ret, size;
@@ -295,7 +323,7 @@
 	 */
 	ret = -ENOMEM;
 	size = FDS_BYTES(n);
-	bits = select_bits_alloc(size);
+	bits = select_bits_alloc(size, ibuf);
 	if (!bits)
 		goto out_nofds;
 	fds.in      = (unsigned long *)  bits;
@@ -340,12 +368,18 @@
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
@@ -379,39 +413,44 @@
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
 	if (nfds > current->files->max_fds)
@@ -431,63 +470,65 @@
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
--- 2.4/include/linux/poll.h	Thu Jan  4 23:51:10 2001
+++ build-2.4/include/linux/poll.h	Fri Jan  5 13:46:30 2001
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


--------------B640E89F46A42E17A441425D--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
