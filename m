Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317355AbSFRIGq>; Tue, 18 Jun 2002 04:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317359AbSFRIGp>; Tue, 18 Jun 2002 04:06:45 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:27533 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317355AbSFRIGk>; Tue, 18 Jun 2002 04:06:40 -0400
Date: Tue, 18 Jun 2002 10:06:21 +0200
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] poll/select fast path
Message-ID: <20020618100621.A27548@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch streamlines poll and select by adding fast paths for a 
small number of descriptors passed. The majority of polls/selects
seem to be of this nature. The main saving comes from not allocating
two pages for wait queue and table, but from using stack allocation
(upto 256bytes) when only a few descriptors are needed. This makes
it as fast again as 2.0 and even a bit faster because the wait queue
page allocation is avoided too (except when the drivers overflow it) 

select also skips a lot faster over big holes and avoids the separate
pass of determining the max. number of descriptors in the bitmap.

a typical linux system saves a considerable amount of unswappable memory 
with this patch, because it usually has 10+ daemons hanging around in poll or 
select with each two pages allocated for data and wait queue.

Some other cleanups.

Patch for 2.5.22.

-Andi


--- linux/include/linux/poll.h	Mon Jun 17 06:25:51 2002
+++ linux-2.5.22-work/include/linux/poll.h	Mon Jun 17 08:32:05 2002
@@ -10,13 +10,32 @@
 #include <linux/mm.h>
 #include <asm/uaccess.h>
 
-struct poll_table_page;
+#define POLL_INLINE_BYTES 256
+#define FAST_SELECT_MAX  128
+#define FAST_POLL_MAX    128
+#define POLL_INLINE_ENTRIES (1+(POLL_INLINE_BYTES / sizeof(struct poll_table_entry)))
+
+struct poll_table_entry {
+	struct file * filp;
+	wait_queue_t wait;
+	wait_queue_head_t * wait_address;
+};
+
+struct poll_table_page {
+	struct poll_table_page * next;
+	struct poll_table_entry * entry;
+	struct poll_table_entry entries[0];
+};
 
 typedef struct poll_table_struct {
 	int error;
 	struct poll_table_page * table;
+	struct poll_table_page inline_page; 
+	struct poll_table_entry inline_table[POLL_INLINE_ENTRIES]; 
 } poll_table;
 
+#define POLL_INLINE_TABLE_LEN (sizeof(poll_table) - offsetof(poll_table, inline_page))
+
 extern void __pollwait(struct file * filp, wait_queue_head_t * wait_address, poll_table *p);
 
 static inline void poll_wait(struct file * filp, wait_queue_head_t * wait_address, poll_table *p)
@@ -30,6 +49,7 @@
 	pt->error = 0;
 	pt->table = NULL;
 }
+
 extern void poll_freewait(poll_table* pt);
 
 
@@ -49,38 +69,11 @@
 #define FDS_LONGS(nr)	(((nr)+FDS_BITPERLONG-1)/FDS_BITPERLONG)
 #define FDS_BYTES(nr)	(FDS_LONGS(nr)*sizeof(long))
 
-/*
- * We do a VERIFY_WRITE here even though we are only reading this time:
- * we'll write to it eventually..
- *
- * Use "unsigned long" accesses to let user-mode fd_set's be long-aligned.
- */
-static inline
-int get_fd_set(unsigned long nr, void *ufdset, unsigned long *fdset)
-{
-	nr = FDS_BYTES(nr);
-	if (ufdset) {
-		int error;
-		error = verify_area(VERIFY_WRITE, ufdset, nr);
-		if (!error && __copy_from_user(fdset, ufdset, nr))
-			error = -EFAULT;
-		return error;
-	}
-	memset(fdset, 0, nr);
-	return 0;
-}
-
 static inline
 void set_fd_set(unsigned long nr, void *ufdset, unsigned long *fdset)
 {
 	if (ufdset)
 		__copy_to_user(ufdset, fdset, FDS_BYTES(nr));
-}
-
-static inline
-void zero_fd_set(unsigned long nr, unsigned long *fdset)
-{
-	memset(fdset, 0, FDS_BYTES(nr));
 }
 
 extern int do_select(int n, fd_set_bits *fds, long *timeout);
--- linux/fs/select.c	Mon Jun 17 06:25:40 2002
+++ linux-2.5.22-work/fs/select.c	Tue Jun 18 09:58:44 2002
@@ -12,6 +12,9 @@
  *  24 January 2000
  *     Changed sys_poll()/do_poll() to use PAGE_SIZE chunk-based allocation 
  *     of fds to overcome nfds < 16390 descriptors limit (Tigran Aivazian).
+ * 
+ *  Dec 2001
+ *     Stack allocation and fast path (Andi Kleen) 
  */
 
 #include <linux/slab.h>
@@ -26,21 +29,6 @@
 #define ROUND_UP(x,y) (((x)+(y)-1)/(y))
 #define DEFAULT_POLLMASK (POLLIN | POLLOUT | POLLRDNORM | POLLWRNORM)
 
-struct poll_table_entry {
-	struct file * filp;
-	wait_queue_t wait;
-	wait_queue_head_t * wait_address;
-};
-
-struct poll_table_page {
-	struct poll_table_page * next;
-	struct poll_table_entry * entry;
-	struct poll_table_entry entries[0];
-};
-
-#define POLL_TABLE_FULL(table) \
-	((unsigned long)((table)->entry+1) > PAGE_SIZE + (unsigned long)(table))
-
 /*
  * Ok, Peter made a complicated, but straightforward multiple_wait() function.
  * I have rewritten this, taking some shortcuts: This code may not be easy to
@@ -62,30 +50,39 @@
 		struct poll_table_page *old;
 
 		entry = p->entry;
-		do {
+		while (entry > p->entries) {
 			entry--;
 			remove_wait_queue(entry->wait_address,&entry->wait);
 			fput(entry->filp);
-		} while (entry > p->entries);
+		}
 		old = p;
 		p = p->next;
-		free_page((unsigned long) old);
+		if (old != &pt->inline_page) 
+			free_page((unsigned long) old);
 	}
 }
 
 void __pollwait(struct file * filp, wait_queue_head_t * wait_address, poll_table *p)
 {
 	struct poll_table_page *table = p->table;
+	struct poll_table_page *new_table = NULL;
+	int sz;
 
-	if (!table || POLL_TABLE_FULL(table)) {
-		struct poll_table_page *new_table;
-
-		new_table = (struct poll_table_page *) __get_free_page(GFP_KERNEL);
-		if (!new_table) {
-			p->error = -ENOMEM;
-			__set_current_state(TASK_RUNNING);
-			return;
+	if (!table) { 
+		new_table = &p->inline_page; 
+	} else { 
+		sz = (table == &p->inline_page) ? POLL_INLINE_TABLE_LEN : PAGE_SIZE; 
+		if ((char*)table->entry >= (char*)table + sz) {
+			new_table = (struct poll_table_page *)__get_free_page(GFP_KERNEL);
+			if (!new_table) {
+				p->error = -ENOMEM;
+				__set_current_state(TASK_RUNNING);
+				return;
+			}
 		}
+	} 
+
+	if (new_table) { 
 		new_table->entry = new_table->entries;
 		new_table->next = table;
 		p->table = new_table;
@@ -113,48 +110,6 @@
 
 #define BITS(fds, n)		(*__IN(fds, n)|*__OUT(fds, n)|*__EX(fds, n))
 
-static int max_select_fd(unsigned long n, fd_set_bits *fds)
-{
-	unsigned long *open_fds;
-	unsigned long set;
-	int max;
-
-	/* handle last in-complete long-word first */
-	set = ~(~0UL << (n & (__NFDBITS-1)));
-	n /= __NFDBITS;
-	open_fds = current->files->open_fds->fds_bits+n;
-	max = 0;
-	if (set) {
-		set &= BITS(fds, n);
-		if (set) {
-			if (!(set & ~*open_fds))
-				goto get_max;
-			return -EBADF;
-		}
-	}
-	while (n) {
-		open_fds--;
-		n--;
-		set = BITS(fds, n);
-		if (!set)
-			continue;
-		if (set & ~*open_fds)
-			return -EBADF;
-		if (max)
-			continue;
-get_max:
-		do {
-			max++;
-			set >>= 1;
-		} while (set);
-		max += n * __NFDBITS;
-	}
-
-	return max;
-}
-
-#define BIT(i)		(1UL << ((i)&(__NFDBITS-1)))
-#define MEM(i,m)	((m)+(unsigned)(i)/__NFDBITS)
 #define ISSET(i,m)	(((i)&*(m)) != 0)
 #define SET(i,m)	(*(m) |= (i))
 
@@ -165,56 +120,71 @@
 int do_select(int n, fd_set_bits *fds, long *timeout)
 {
 	poll_table table, *wait;
-	int retval, i, off;
+	int retval, off, max, maxoff;
 	long __timeout = *timeout;
 
- 	read_lock(&current->files->file_lock);
-	retval = max_select_fd(n, fds);
-	read_unlock(&current->files->file_lock);
-
-	if (retval < 0)
-		return retval;
-	n = retval;
-
 	poll_initwait(&table);
 	wait = &table;
 	if (!__timeout)
 		wait = NULL;
+	
 	retval = 0;
+	maxoff = n/BITS_PER_LONG; 
+	max = 0; 
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
-		for (i = 0 ; i < n; i++) {
-			unsigned long bit = BIT(i);
-			unsigned long mask;
-			struct file *file;
+		for (off = 0; off <= maxoff; off++) { 
+			unsigned long val = BITS(fds, off); 
 
-			off = i / __NFDBITS;
-			if (!(bit & BITS(fds, off)))
+			if (!val) 
 				continue;
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
+			while (val) { 
+				int k = ffz(~val); 
+				unsigned long mask, bit;
+				struct file *file;
+
+				if (k > n%BITS_PER_LONG) 
+					break;
+
+				bit = (1UL << k); 
+				val &= ~bit; 
+
+				file = fget((off * BITS_PER_LONG) + k);
+				mask = POLLNVAL;
+				if (file) {
+					mask = DEFAULT_POLLMASK;
+					if (file->f_op && file->f_op->poll)
+						mask = file->f_op->poll(file, wait);
+					fput(file);
+				} else { 
+					/* This error will shadow all other results. 
+					 * This matches previous linux behaviour */
+					retval = -EBADF; 
+					goto out; 
+				} 
+				if ((mask & POLLIN_SET) && ISSET(bit, __IN(fds,off))) {
+					SET(bit, __RES_IN(fds,off));
+					retval++;
+					wait = NULL;
+				}
+				if ((mask& POLLOUT_SET) && ISSET(bit,__OUT(fds,off))) {
+					SET(bit, __RES_OUT(fds,off));
+					retval++;
+					wait = NULL;
+				}
+				if ((mask & POLLEX_SET) && ISSET(bit, __EX(fds,off))) {
+					SET(bit, __RES_EX(fds,off));
+					retval++;
+					wait = NULL;
+				}
+
+				if (!(val &= ~bit))
+					break;
 			}
 		}
+
+		
+		maxoff = max; 
 		wait = NULL;
 		if (retval || !__timeout || signal_pending(current))
 			break;
@@ -224,25 +194,43 @@
 		}
 		__timeout = schedule_timeout(__timeout);
 	}
+
+out:	
 	current->state = TASK_RUNNING;
 
 	poll_freewait(&table);
 
 	/*
-	 * Up-to-date the caller timeout.
+	 * Update the caller timeout.
 	 */
 	*timeout = __timeout;
 	return retval;
 }
 
-static void *select_bits_alloc(int size)
-{
-	return kmalloc(6 * size, GFP_KERNEL);
-}
+/*
+ * We do a VERIFY_WRITE here even though we are only reading this time:
+ * we'll write to it eventually..
+ */
 
-static void select_bits_free(void *bits, int size)
+static int get_fd_set(unsigned long nr, void *ufdset, unsigned long *fdset)
 {
-	kfree(bits);
+	unsigned long rounded = FDS_BYTES(nr), mask; 
+	if (ufdset) {
+		int error = verify_area(VERIFY_WRITE, ufdset, rounded);
+		if (!error && __copy_from_user(fdset, ufdset, rounded))
+			error = -EFAULT;
+		if (nr % __NFDBITS == 0) 
+			mask = 0;
+		else { 
+			/* This includes one bit too much according to SU;
+			   but without this some programs hang. */ 
+			mask = ~(~0UL << (nr%__NFDBITS)); 
+		} 
+		fdset[nr/__NFDBITS] &= mask; 
+		return error;
+	}
+	memset(fdset, 0, rounded);
+	return 0;
 }
 
 /*
@@ -263,6 +251,7 @@
 	char *bits;
 	long timeout;
 	int ret, size, max_fdset;
+	char stack_bits[FDS_BYTES(FAST_SELECT_MAX) * 6]; 
 
 	timeout = MAX_SCHEDULE_TIMEOUT;
 	if (tvp) {
@@ -297,11 +286,16 @@
 	 * since we used fdset we need to allocate memory in units of
 	 * long-words. 
 	 */
-	ret = -ENOMEM;
 	size = FDS_BYTES(n);
-	bits = select_bits_alloc(size);
-	if (!bits)
-		goto out_nofds;
+	if (n < FAST_SELECT_MAX) { 
+		bits = stack_bits;
+	} else { 
+		ret = -ENOMEM;
+		bits = kmalloc(6*size, GFP_KERNEL);
+		if (!bits)
+			goto out_nofds;
+	} 
+
 	fds.in      = (unsigned long *)  bits;
 	fds.out     = (unsigned long *) (bits +   size);
 	fds.ex      = (unsigned long *) (bits + 2*size);
@@ -313,9 +307,7 @@
 	    (ret = get_fd_set(n, outp, fds.out)) ||
 	    (ret = get_fd_set(n, exp, fds.ex)))
 		goto out;
-	zero_fd_set(n, fds.res_in);
-	zero_fd_set(n, fds.res_out);
-	zero_fd_set(n, fds.res_ex);
+	memset(fds.res_in, 0, 3*size); 
 
 	ret = do_select(n, &fds, &timeout);
 
@@ -326,8 +318,8 @@
 			usec = timeout % HZ;
 			usec *= (1000000/HZ);
 		}
-		put_user(sec, &tvp->tv_sec);
-		put_user(usec, &tvp->tv_usec);
+		__put_user(sec, &tvp->tv_sec);
+		__put_user(usec, &tvp->tv_usec);
 	}
 
 	if (ret < 0)
@@ -344,8 +336,10 @@
 	set_fd_set(n, exp, fds.res_ex);
 
 out:
-	select_bits_free(bits, size);
+	if (n >= FAST_SELECT_MAX) 
+		kfree(bits);
 out_nofds:
+
 	return ret;
 }
 
@@ -410,12 +404,42 @@
 	return count;
 }
 
+static int fast_poll(poll_table *table, poll_table *wait, struct pollfd *ufds, 
+		     unsigned int nfds, long timeout)
+{ 
+	poll_table *pt = wait; 
+	struct pollfd fds[FAST_POLL_MAX];
+	int count, i; 
+
+	if (copy_from_user(fds, ufds, nfds * sizeof(struct pollfd)))
+		return -EFAULT; 
+	for (;;) { 
+		set_current_state(TASK_INTERRUPTIBLE);
+		count = 0; 
+		do_pollfd(nfds, fds, &pt, &count); 
+		pt = NULL;
+		if (count || !timeout || signal_pending(current))
+			break;
+		count = wait->error; 
+		if (count) 
+			break; 		
+		timeout = schedule_timeout(timeout);
+	} 
+	current->state = TASK_RUNNING;
+	for (i = 0; i < nfds; i++) 
+		__put_user(fds[i].revents, &ufds[i].revents);
+	poll_freewait(table);	
+	if (!count && signal_pending(current)) 
+		return -EINTR; 
+	return count; 
+} 
+
 asmlinkage long sys_poll(struct pollfd * ufds, unsigned int nfds, long timeout)
 {
-	int i, j, fdcount, err;
+	int i, j, err, fdcount;
 	struct pollfd **fds;
 	poll_table table, *wait;
-	int nchunks, nleft;
+	int nchunks, nleft; 
 
 	/* Do a sanity check on nfds ... */
 	if (nfds > NR_OPEN)
@@ -429,43 +453,45 @@
 			timeout = MAX_SCHEDULE_TIMEOUT;
 	}
 
+
 	poll_initwait(&table);
 	wait = &table;
 	if (!timeout)
 		wait = NULL;
 
-	err = -ENOMEM;
-	fds = NULL;
-	if (nfds != 0) {
-		fds = (struct pollfd **)kmalloc(
-			(1 + (nfds - 1) / POLLFD_PER_PAGE) * sizeof(struct pollfd *),
-			GFP_KERNEL);
-		if (fds == NULL)
-			goto out;
-	}
+	if (nfds < FAST_POLL_MAX) 
+		return fast_poll(&table, wait, ufds, nfds, timeout); 
 
+	err = -ENOMEM;
+	fds = (struct pollfd **)kmalloc(
+		(1 + (nfds - 1) / POLLFD_PER_PAGE) * sizeof(struct pollfd *),
+		GFP_KERNEL);
+	if (fds == NULL)
+		goto out;
+	
 	nchunks = 0;
 	nleft = nfds;
-	while (nleft > POLLFD_PER_PAGE) { /* allocate complete PAGE_SIZE chunks */
+	while (nleft > POLLFD_PER_PAGE) { 
 		fds[nchunks] = (struct pollfd *)__get_free_page(GFP_KERNEL);
 		if (fds[nchunks] == NULL)
 			goto out_fds;
 		nchunks++;
 		nleft -= POLLFD_PER_PAGE;
 	}
-	if (nleft) { /* allocate last PAGE_SIZE chunk, only nleft elements used */
+	if (nleft) { 
 		fds[nchunks] = (struct pollfd *)__get_free_page(GFP_KERNEL);
 		if (fds[nchunks] == NULL)
 			goto out_fds;
-	}
-
+	} 
+	
 	err = -EFAULT;
 	for (i=0; i < nchunks; i++)
 		if (copy_from_user(fds[i], ufds + i*POLLFD_PER_PAGE, PAGE_SIZE))
 			goto out_fds1;
+	
 	if (nleft) {
 		if (copy_from_user(fds[nchunks], ufds + nchunks*POLLFD_PER_PAGE, 
-				nleft * sizeof(struct pollfd)))
+				   nleft * sizeof(struct pollfd)))
 			goto out_fds1;
 	}
 
@@ -489,8 +515,7 @@
 out_fds:
 	for (i=0; i < nchunks; i++)
 		free_page((unsigned long)(fds[i]));
-	if (nfds != 0)
-		kfree(fds);
+	kfree(fds);
 out:
 	poll_freewait(&table);
 	return err;
