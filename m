Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266192AbSKFWqR>; Wed, 6 Nov 2002 17:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266193AbSKFWqR>; Wed, 6 Nov 2002 17:46:17 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:39055 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S266192AbSKFWqJ>; Wed, 6 Nov 2002 17:46:09 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 6 Nov 2002 15:02:40 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] epoll bits 0.33 ...
Message-ID: <Pine.LNX.4.44.0211061457360.953-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Changes from 2.4.46 :

*) Some constant adjusted

*) Comments plus

*) Better hash initialization

*) Correct timeout setup

*) Added __KERNEL__ bypass to avoid userspace inclusion problems

*) Cleaned up locking

*) poll_init_wait() now calls poll_init_wait_ex()

*) event return fix ( Jay Vosburgh )




- Davide



fs/eventpoll.c            |  111 ++++++++++++++++++++++++++++------------------
include/linux/eventpoll.h |   14 +++--
include/linux/poll.h      |   15 ++----
3 files changed, 83 insertions, 57 deletions





diff -Nru linux-2.5.46.vanilla/fs/eventpoll.c linux-2.5.46.epoll/fs/eventpoll.c
--- linux-2.5.46.vanilla/fs/eventpoll.c	Mon Nov  4 15:45:35 2002
+++ linux-2.5.46.epoll/fs/eventpoll.c	Wed Nov  6 14:44:44 2002
@@ -61,8 +61,12 @@
 /* Maximum storage for the eventpoll interest set */
 #define EP_MAX_FDS_SIZE (1024 * 128)

-/* We don't want the hash to be smaller than this */
-#define EP_MIN_HASH_SIZE 101
+/*
+ * We don't want the hash to be smaller than this. This is basically
+ * the highest prime lower than (PAGE_SIZE / sizeof(struct list_head)).
+ */
+#define EP_MIN_HASH_SIZE 509
+
 /*
  * Event buffer dimension used to cache events before sending them in
  * userspace with a __copy_to_user(). The event buffer is in stack,
@@ -188,6 +192,7 @@


 static int ep_is_prime(int n);
+static int ep_size_hash(int hintsize);
 static int ep_getfd(int *efd, struct inode **einode, struct file **efile);
 static int ep_alloc_pages(char **pages, int numpages);
 static int ep_free_pages(char **pages, int numpages);
@@ -201,7 +206,6 @@
 static void ep_release_epitem(struct epitem *dpi);
 static void ep_ptable_queue_proc(void *priv, wait_queue_head_t *whead);
 static int ep_insert(struct eventpoll *ep, struct pollfd *pfd, struct file *tfile);
-static unsigned int ep_get_file_events(struct file *file);
 static int ep_modify(struct eventpoll *ep, struct epitem *dpi, unsigned int events);
 static int ep_unlink(struct eventpoll *ep, struct epitem *dpi);
 static int ep_remove(struct eventpoll *ep, struct epitem *dpi);
@@ -252,14 +256,14 @@



-/* Report if the number is prime. Needed to correctly size the hash  */
+/* Report if the number is prime. Needed to correctly size the hash */
 static int ep_is_prime(int n)
 {

 	if (n > 3) {
 		if (n & 1) {
 			int i, hn = n / 2;
-
+
 			for (i = 3; i < hn; i += 2)
 				if (!(n % i))
 					return 0;
@@ -296,9 +300,30 @@
 }


+static int ep_size_hash(int hintsize)
+{
+	int maxsize = (EP_MAX_HPAGES - 1) * EP_HENTRY_X_PAGE;
+
+	/*
+	 * Search the nearest prime number higher than "hintsize" and
+	 * smaller than "maxsize".
+	 */
+	for (; !ep_is_prime(hintsize); hintsize++);
+	if (hintsize < EP_MIN_HASH_SIZE)
+		hintsize = EP_MIN_HASH_SIZE;
+	else if (hintsize >= maxsize)
+		for (hintsize = maxsize - 1; !ep_is_prime(hintsize); hintsize--);
+
+	return hintsize;
+}
+
+
 /*
  * It opens an eventpoll file descriptor by suggesting a storage of "size"
- * file descriptors. It is the kernel part of the userspace epoll_create(2).
+ * file descriptors. The size parameter is just an hint about how to size
+ * data structures. It won't prevent the user to store more than "size"
+ * file descriptors inside the epoll interface. It is the kernel part of
+ * the userspace epoll_create(2).
  */
 asmlinkage int sys_epoll_create(int size)
 {
@@ -309,10 +334,8 @@
 	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_create(%d)\n",
 		     current, size));

-	/* Search the nearest prime number higher than "size" */
-	for (; !ep_is_prime(size); size++);
-	if (size < EP_MIN_HASH_SIZE)
-		size = EP_MIN_HASH_SIZE;
+	/* Correctly size the hash */
+	size = ep_size_hash(size);

 	/*
 	 * Creates all the items needed to setup an eventpoll file. That is,
@@ -457,6 +480,10 @@
 	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_wait(%d, %p, %d, %d)\n",
 		     current, epfd, events, maxevents, timeout));

+	/* The maximum number of event must be greater than zero */
+	if (maxevents <= 0)
+		return -EINVAL;
+
 	/* Verify that the area passed by the user is writeable */
 	if ((error = verify_area(VERIFY_WRITE, events, maxevents * sizeof(struct pollfd))))
 		goto eexit_1;
@@ -567,7 +594,7 @@
 eexit_2:
 	put_filp(file);
 eexit_1:
-	return error;
+	return error;
 }


@@ -723,8 +750,7 @@
 	write_unlock_irqrestore(&eplock, flags);

 	/* Free hash pages */
-	if (ep->nhpages > 0)
-		ep_free_pages(ep->hpages, ep->nhpages);
+	ep_free_pages(ep->hpages, ep->nhpages);
 }


@@ -827,22 +853,26 @@
 		dpi->wait[i].base = dpi;
 	}

-	/* Attach the item to the poll hooks */
+	/* Initialize the poll table using the queue callback */
 	poll_initwait_ex(&pt, 1, ep_ptable_queue_proc, dpi);
-	revents = tfile->f_op->poll(tfile, &pt);
-	poll_freewait(&pt);

 	/* We have to drop the new item inside our item list to keep track of it */
 	write_lock_irqsave(&ep->lock, flags);

+	/* Add the current item to the hash table */
 	list_add(&dpi->llink, ep_hash_entry(ep, ep_hash_index(ep, tfile)));

+	/* Attach the item to the poll hooks and get current event bits */
+	revents = tfile->f_op->poll(tfile, &pt);
+
 	/* If the file is already "ready" we drop it inside the ready list */
 	if ((revents & pfd->events) && !EP_IS_LINKED(&dpi->rdllink))
 		list_add(&dpi->rdllink, &ep->rdllist);

 	write_unlock_irqrestore(&ep->lock, flags);

+	poll_freewait(&pt);
+
 	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ep_insert(%p, %d)\n",
 		     current, ep, pfd->fd));

@@ -854,12 +884,13 @@


 /*
- * Returns the current events of the given file. It uses the special
- * poll table initialization to avoid any poll queue insertion.
+ * Modify the interest event mask by dropping an event if the new mask
+ * has a match in the current file status.
  */
-static unsigned int ep_get_file_events(struct file *file)
+static int ep_modify(struct eventpoll *ep, struct epitem *dpi, unsigned int events)
 {
 	unsigned int revents;
+	unsigned long flags;
 	poll_table pt;

 	/*
@@ -870,26 +901,12 @@
 	 */
 	poll_initwait_ex(&pt, 0, NULL, NULL);

-	revents = file->f_op->poll(file, &pt);
-
-	poll_freewait(&pt);
-	return revents;
-}
-
-
-/*
- * Modify the interest event mask by dropping an event if the new mask
- * has a match in the current file status.
- */
-static int ep_modify(struct eventpoll *ep, struct epitem *dpi, unsigned int events)
-{
-	unsigned int revents;
-	unsigned long flags;
-
-	revents = ep_get_file_events(dpi->file);
-
 	write_lock_irqsave(&ep->lock, flags);

+	/* Get current event bits */
+	revents = dpi->file->f_op->poll(dpi->file, &pt);
+
+	/* Set the new event interest mask */
 	dpi->pfd.events = events;

 	/* If the file is already "ready" we drop it inside the ready list */
@@ -898,6 +915,8 @@

 	write_unlock_irqrestore(&ep->lock, flags);

+	poll_freewait(&pt);
+
 	return 0;
 }

@@ -1068,12 +1087,20 @@

 	write_lock_irqsave(&ep->lock, flags);

-	for (eventcnt = 0, ebufcnt = 0; eventcnt < maxevents && !list_empty(lsthead);) {
+	for (eventcnt = 0, ebufcnt = 0; (eventcnt + ebufcnt) < maxevents && !list_empty(lsthead);) {
 		struct epitem *dpi = list_entry(lsthead->next, struct epitem, rdllink);

 		/* Remove the item from the ready list */
 		EP_LIST_DEL(&dpi->rdllink);

+		/*
+		 * If the item is not linked to the main has table this means that
+		 * it's on the way to be removed and we don't want to send events
+		 * to such file descriptor.
+		 */
+		if (!EP_IS_LINKED(&dpi->llink))
+			continue;
+
 		/* Fetch event bits from the signaled file */
 		revents = dpi->file->f_op->poll(dpi->file, &pt);

@@ -1126,12 +1153,10 @@
 	wait_queue_t wait;

 	/*
-	 * Calculate the timeout by checking for the "infinite" value ( -1 )
-	 * and the overflow condition ( > MAX_SCHEDULE_TIMEOUT / HZ ). The
-	 * passed timeout is in milliseconds, that why (t * HZ) / 1000.
+	 * Calculate the timeout by checking for the "infinite" value ( -1 ).
+	 * The passed timeout is in milliseconds, that why (t * HZ) / 1000.
 	 */
-	jtimeout = timeout == -1 || timeout > MAX_SCHEDULE_TIMEOUT / HZ ?
-		MAX_SCHEDULE_TIMEOUT: (timeout * HZ) / 1000;
+	jtimeout = timeout == -1 ? MAX_SCHEDULE_TIMEOUT: (timeout * HZ) / 1000;

 retry:
 	write_lock_irqsave(&ep->lock, flags);
diff -Nru linux-2.5.46.vanilla/include/linux/eventpoll.h linux-2.5.46.epoll/include/linux/eventpoll.h
--- linux-2.5.46.vanilla/include/linux/eventpoll.h	Mon Nov  4 15:45:36 2002
+++ linux-2.5.46.epoll/include/linux/eventpoll.h	Tue Nov  5 11:13:26 2002
@@ -14,10 +14,6 @@
 #ifndef _LINUX_EVENTPOLL_H
 #define _LINUX_EVENTPOLL_H

-/* Forward declarations to avoid compiler errors */
-struct file;
-struct pollfd;
-

 /* Valid opcodes to issue to sys_epoll_ctl() */
 #define EP_CTL_ADD 1
@@ -25,6 +21,13 @@
 #define EP_CTL_MOD 3


+#ifdef __KERNEL__
+
+/* Forward declarations to avoid compiler errors */
+struct file;
+struct pollfd;
+
+
 /* Kernel space functions implementing the user space "epoll" API */
 asmlinkage int sys_epoll_create(int size);
 asmlinkage int sys_epoll_ctl(int epfd, int op, int fd, unsigned int events);
@@ -34,6 +37,7 @@
 /* Used in fs/file_table.c:__fput() to unlink files from the eventpoll interface */
 void ep_notify_file_close(struct file *file);

+#endif /* #ifdef __KERNEL__ */

-#endif
+#endif /* #ifndef _LINUX_EVENTPOLL_H */

diff -Nru linux-2.5.46.vanilla/include/linux/poll.h linux-2.5.46.epoll/include/linux/poll.h
--- linux-2.5.46.vanilla/include/linux/poll.h	Mon Nov  4 15:45:37 2002
+++ linux-2.5.46.epoll/include/linux/poll.h	Wed Nov  6 10:44:10 2002
@@ -28,15 +28,6 @@
 		__pollwait(filp, wait_address, p);
 }

-static inline void poll_initwait(poll_table* pt)
-{
-	pt->queue = 1;
-	pt->qproc = NULL;
-	pt->priv = NULL;
-	pt->error = 0;
-	pt->table = NULL;
-}
-
 static inline void poll_initwait_ex(poll_table* pt, int queue,
 				    void (*qproc)(void *, wait_queue_head_t *),
 				    void *priv)
@@ -46,6 +37,12 @@
 	pt->priv = priv;
 	pt->error = 0;
 	pt->table = NULL;
+}
+
+static inline void poll_initwait(poll_table* pt)
+{
+
+	poll_initwait_ex(pt, 1, NULL, NULL);
 }

 extern void poll_freewait(poll_table* pt);


