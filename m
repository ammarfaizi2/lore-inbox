Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264854AbSKJMH4>; Sun, 10 Nov 2002 07:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264848AbSKJMHN>; Sun, 10 Nov 2002 07:07:13 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:3746 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S264842AbSKJMGe>;
	Sun, 10 Nov 2002 07:06:34 -0500
Message-ID: <3DCE4CB4.4080009@colorfullife.com>
Date: Sun, 10 Nov 2002 13:10:28 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Davide Libenzi <davidel@xmailserver.org>
Subject: [RFC,PATCH] poll cleanup 3/3
Content-Type: multipart/mixed;
 boundary="------------040208080708030805010700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040208080708030805010700
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch is performance improvement, not really a cleanup:

sys_poll performs at least 3 dynamic memory allocations, even if just 
one file descriptor is polled. The attached patch avoids that by using 
stack space if  possible.

This results in a 40 % performance improvement for sys_poll on one ready
file descriptor.

--
     Manfred


--------------040208080708030805010700
Content-Type: text/plain;
 name="patch-poll-3-alloc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-poll-3-alloc"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 5
//  SUBLEVEL = 46
//  EXTRAVERSION =
--- 2.5/include/linux/poll.h	2002-11-10 12:07:23.000000000 +0100
+++ build-2.5/include/linux/poll.h	2002-11-10 12:12:52.000000000 +0100
@@ -17,10 +17,19 @@
 	void *priv;
 };
 
+struct poll_table_entry {
+	struct file * filp;
+	wait_queue_t wait;
+	wait_queue_head_t * wait_address;
+};
+#define POLL_TABLE_INTERNAL	8
+ 
 struct poll_wrapper {
 	poll_table pt;
 	int error;
+	int nr;
 	struct poll_table_page * table;
+	struct poll_table_entry internal[POLL_TABLE_INTERNAL];
 };
 
 void poll_initwait(struct poll_wrapper* pt);
--- 2.5/fs/select.c	2002-11-10 12:07:23.000000000 +0100
+++ build-2.5/fs/select.c	2002-11-10 12:13:48.000000000 +0100
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
@@ -53,12 +47,36 @@
  * as all select/poll functions have to call it to add an entry to the
  * poll table.
  */
-
+/*
+ * Dynamic memory allocation is expensive, sys_poll() and sys_select()
+ * try to avoid it by storing a few bytes on the stack:
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
 void poll_freewait(struct poll_wrapper* pt)
 {
 	struct poll_table_page * p = pt->table;
-	while (p) {
-		struct poll_table_entry * entry;
+	struct poll_table_entry * entry;
+
+	entry = pt->internal + pt->nr;
+	while(pt->nr > 0) {
+		pt->nr--;
+		entry--;
+		remove_wait_queue(entry->wait_address,&entry->wait);
+		fput(entry->filp);
+	}
+ 	while (p) {
 		struct poll_table_page *old;
 
 		entry = p->entry;
@@ -69,40 +87,44 @@
 		} while (entry > p->entries);
 		old = p;
 		p = p->next;
-		free_page((unsigned long) old);
+		kfree(old);
 	}
 }
 
 static void __pollwait(void *priv, struct file * filp, wait_queue_head_t * wait_address)
 {
 	struct poll_wrapper *p = priv;
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
+ 	struct poll_table_entry * entry;
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
 
 void poll_initwait(struct poll_wrapper* pt)
@@ -110,6 +132,7 @@
 	pt->pt.qproc = __pollwait;
 	pt->pt.priv = pt;
 	pt->error = 0;
+	pt->nr = 0;
 	pt->table = NULL;
 }
 
@@ -245,14 +268,18 @@
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
@@ -266,10 +293,12 @@
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
@@ -309,7 +338,7 @@
 	 */
 	ret = -ENOMEM;
 	size = FDS_BYTES(n);
-	bits = select_bits_alloc(size);
+	bits = select_bits_alloc(size, ibuf);
 	if (!bits)
 		goto out_nofds;
 	fds.in      = (unsigned long *)  bits;
@@ -354,12 +383,18 @@
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
@@ -393,24 +428,23 @@
 	}
 }
 
-static int do_poll(unsigned int nfds, unsigned int nchunks, unsigned int nleft, 
-	struct pollfd *fds[], struct poll_wrapper *pw, long timeout)
+static int do_poll(int nfds, struct poll_list *list,
+			struct poll_wrapper *pw, long timeout)
 {
-	int count;
+	int count = 0;
 	poll_table* pt = &pw->pt;
 
 	if (!timeout)
 		pt = NULL;
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
@@ -423,13 +457,18 @@
 	return count;
 }
 
+#define INLINE_POLL_COUNT	24
 asmlinkage long sys_poll(struct pollfd * ufds, unsigned int nfds, long timeout)
 {
-	int i, j, fdcount, err;
-	struct pollfd **fds;
 	struct poll_wrapper table;
-	int nchunks, nleft;
-
+ 	int fdcount, err;
+ 	unsigned int i;
+	struct {
+		struct poll_list head;
+		struct pollfd entries[INLINE_POLL_COUNT];
+	} polldata;
+ 	struct poll_list *pollwalk;
+ 
 	/* Do a sanity check on nfds ... */
 	if (nfds > NR_OPEN)
 		return -EINVAL;
@@ -443,65 +482,61 @@
 	}
 
 	poll_initwait(&table);
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
-	fdcount = do_poll(nfds, nchunks, nleft, fds, &table, timeout);
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
+		struct pollfd * fds = pollwalk->entries;
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
+


--------------040208080708030805010700--


