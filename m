Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261356AbSKNCag>; Wed, 13 Nov 2002 21:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261370AbSKNCag>; Wed, 13 Nov 2002 21:30:36 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:22670 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261356AbSKNCaZ>; Wed, 13 Nov 2002 21:30:25 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 13 Nov 2002 18:37:37 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] epoll bits 0.46 ...
Message-ID: <Pine.LNX.4.44.0211131826560.986-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

this is a patch on top of 2.5.47, you should remove the few bits you
merged to successfully apply this one ( or let me know the baseline from
where you need this ). Changes :

- A more uniform poll queueing interface with tips from Manfred

- The f_op->poll() is done outside the irqlock to maintain compatibility
	with existing drivers that assume to be called with irq enabled

- Moved event mask setting inside ep_modify() with tips from John

- Fixed locking to fit the new "poll() outside the lock" approach

- Bufferd userspace event delivery to reduce irq_lock/irq_unlock switching
	rate and to reduce the number of __copy_to_user()

- Comments plus




- Davide



fs/eventpoll.c       |  372 +++++++++++++++++++++++++++++++++------------------
fs/select.c          |   11 -
include/linux/poll.h |   28 ++-
kernel/ksyms.c       |    2
4 files changed, 265 insertions, 148 deletions




diff -Nru linux-2.5.47.vanilla/fs/eventpoll.c linux-2.5.47.epoll/fs/eventpoll.c
--- linux-2.5.47.vanilla/fs/eventpoll.c	Mon Nov 11 10:26:11 2002
+++ linux-2.5.47.epoll/fs/eventpoll.c	Wed Nov 13 18:14:19 2002
@@ -27,6 +27,7 @@
 #include <linux/list.h>
 #include <linux/hash.h>
 #include <linux/spinlock.h>
+#include <linux/rwsem.h>
 #include <linux/wait.h>
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
@@ -65,13 +66,6 @@
 /* Minimum size of the hash in bits ( 2^N ) */
 #define EP_MIN_HASH_BITS 9

-/*
- * Event buffer dimension used to cache events before sending them in
- * userspace with a __copy_to_user(). The event buffer is in stack,
- * so keep this size fairly small.
- */
-#define EP_EVENT_BUFF_SIZE 32
-
 /* Maximum number of wait queue we can attach to */
 #define EP_MAX_POLL_QUEUE 2

@@ -107,7 +101,20 @@
 /* Get the "struct epitem" from a wait queue pointer */
 #define EP_ITEM_FROM_WAIT(p) ((struct epitem *) container_of(p, struct eppoll_entry, wait)->base)

+/* Get the "struct epitem" from an epoll queue wrapper */
+#define EP_ITEM_FROM_EPQUEUE(p) (container_of(p, struct ep_pqueue, pt)->dpi)

+/*
+ * This is used to optimize the event transfer to userspace. Since this
+ * is kept on stack, it should be pretty small.
+ */
+#define EP_MAX_BUF_EVENTS 32
+
+/*
+ * Used to optimize ready items collection by reducing the irqlock/irqunlock
+ * switching rate. This is kept in stack too, so do not go wild with this number.
+ */
+#define EP_MAX_COLLECT_ITEMS 64



@@ -187,6 +194,12 @@
 	atomic_t usecnt;
 };

+/* Wrapper struct used by poll queueing */
+struct ep_pqueue {
+	poll_table pt;
+	struct epitem *dpi;
+};
+


 static unsigned int ep_get_hash_bits(unsigned int hintsize);
@@ -201,14 +214,18 @@
 static struct epitem *ep_find(struct eventpoll *ep, struct file *file);
 static void ep_use_epitem(struct epitem *dpi);
 static void ep_release_epitem(struct epitem *dpi);
-static void ep_ptable_queue_proc(void *priv, wait_queue_head_t *whead);
+static void ep_ptable_queue_proc(struct file *file, wait_queue_head_t *whead, poll_table *pt);
 static int ep_insert(struct eventpoll *ep, struct pollfd *pfd, struct file *tfile);
 static int ep_modify(struct eventpoll *ep, struct epitem *dpi, unsigned int events);
+static void ep_unregister_pollwait(struct eventpoll *ep, struct epitem *dpi);
 static int ep_unlink(struct eventpoll *ep, struct epitem *dpi);
 static int ep_remove(struct eventpoll *ep, struct epitem *dpi);
 static int ep_poll_callback(wait_queue_t *wait, unsigned mode, int sync);
 static int ep_eventpoll_close(struct inode *inode, struct file *file);
 static unsigned int ep_eventpoll_poll(struct file *file, poll_table *wait);
+static int ep_collect_ready_items(struct eventpoll *ep, struct epitem **adpi, int maxdpi);
+static int ep_send_events(struct eventpoll *ep, struct epitem **adpi, int ndpi,
+			  struct pollfd *events);
 static int ep_events_transfer(struct eventpoll *ep, struct pollfd *events, int maxevents);
 static int ep_poll(struct eventpoll *ep, struct pollfd *events, int maxevents,
 		   int timeout);
@@ -219,11 +236,21 @@



-/* Use to link togheter all the "struct eventpoll" */
+/*
+ * Use to link togheter all the "struct eventpoll". We need to link
+ * all the available eventpoll structures to be able to perform proper
+ * cleanup in case a file that is stored inside epoll is closed without
+ * previously being removed.
+ */
 static struct list_head eplist;

-/* Serialize the access to "eplist" */
-static rwlock_t eplock;
+/*
+ * Serialize the access to "eplist" and also to ep_notify_file_close().
+ * It is read-held when we want to be sure that a given file will not
+ * vanish while we're doing f_op->poll(). When "ep->lock" is taken,
+ * it will nest inside this semaphore.
+ */
+struct rw_semaphore epsem;

 /* Slab cache used to allocate "struct epitem" */
 static kmem_cache_t *dpi_cache;
@@ -275,21 +302,24 @@
  */
 void ep_notify_file_close(struct file *file)
 {
-	unsigned long flags;
 	struct list_head *lnk;
 	struct eventpoll *ep;
 	struct epitem *dpi;

-	read_lock_irqsave(&eplock, flags);
+	down_write(&epsem);
 	list_for_each(lnk, &eplist) {
 		ep = list_entry(lnk, struct eventpoll, llink);

+		/*
+		 * The ep_find() function increases the "struct epitem" usage count
+		 * so we have to do an ep_remove() + ep_release_epitem().
+		 */
 		while ((dpi = ep_find(ep, file))) {
 			ep_remove(ep, dpi);
 			ep_release_epitem(dpi);
 		}
 	}
-	read_unlock_irqrestore(&eplock, flags);
+	up_write(&epsem);
 }


@@ -430,14 +460,14 @@
 	if (dpi)
 		ep_release_epitem(dpi);

-	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_ctl(%d, %d, %d, %u) = %d\n",
-		     current, epfd, op, fd, events, error));
-
 eexit_3:
 	fput(tfile);
 eexit_2:
 	fput(file);
 eexit_1:
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_ctl(%d, %d, %d, %u) = %d\n",
+		     current, epfd, op, fd, events, error));
+
 	return error;
 }

@@ -487,12 +517,12 @@
 	/* Time to fish for events ... */
 	error = ep_poll(ep, events, maxevents, timeout);

-	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_wait(%d, %p, %d, %d) = %d\n",
-		     current, epfd, events, maxevents, timeout, error));
-
 eexit_2:
 	fput(file);
 eexit_1:
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_wait(%d, %p, %d, %d) = %d\n",
+		     current, epfd, events, maxevents, timeout, error));
+
 	return error;
 }

@@ -608,7 +638,6 @@
 static int ep_file_init(struct file *file, unsigned int hashbits)
 {
 	int error;
-	unsigned long flags;
 	struct eventpoll *ep;

 	if (!(ep = kmalloc(sizeof(struct eventpoll), GFP_KERNEL)))
@@ -625,9 +654,9 @@
 	file->private_data = ep;

 	/* Add the structure to the linked list that links "struct eventpoll" */
-	write_lock_irqsave(&eplock, flags);
+	down_write(&epsem);
 	list_add(&ep->llink, &eplist);
-	write_unlock_irqrestore(&eplock, flags);
+	up_write(&epsem);

 	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ep_file_init() ep=%p\n",
 		     current, ep));
@@ -686,44 +715,47 @@
 static void ep_free(struct eventpoll *ep)
 {
 	unsigned int i, hsize;
-	unsigned long flags;
-	struct list_head *lsthead;
+	struct list_head *lsthead, *lnk;

 	/*
-	 * Walks through the whole hash by unregistering file callbacks and
-	 * freeing each "struct epitem".
+	 * We need to lock this because we could be hit by
+	 * ep_notify_file_close() while we're freeing the
+	 * "struct eventpoll".
+	 */
+	down_write(&epsem);
+
+	/*
+	 * Walks through the whole hash by unregistering poll callbacks.
 	 */
 	for (i = 0, hsize = 1 << ep->hashbits; i < hsize; i++) {
 		lsthead = ep_hash_entry(ep, i);

-		/*
-		 * We need to lock this because we could be hit by
-		 * ep_notify_file_close() while we're freeing this.
-		 */
-		write_lock_irqsave(&ep->lock, flags);
+		list_for_each(lnk, lsthead) {
+			struct epitem *dpi = list_entry(lnk, struct epitem, llink);

-		while (!list_empty(lsthead)) {
-			struct epitem *dpi = list_entry(lsthead->next, struct epitem, llink);
-
-			/* The function ep_unlink() must be called with held lock */
-			ep_unlink(ep, dpi);
+			ep_unregister_pollwait(ep, dpi);
+		}
+	}

-			/* We release the lock before releasing the "struct epitem" */
-			write_unlock_irqrestore(&ep->lock, flags);
+	/*
+	 * Walks through the whole hash by freeing each "struct epitem". At this
+	 * point we are sure no poll callbacks will be lingering around, so we can
+	 * avoid the lock on "ep->lock".
+	 */
+	for (i = 0, hsize = 1 << ep->hashbits; i < hsize; i++) {
+		lsthead = ep_hash_entry(ep, i);

-			ep_release_epitem(dpi);
+		while (!list_empty(lsthead)) {
+			struct epitem *dpi = list_entry(lsthead->next, struct epitem, llink);

-			/* And then we reaquire the lock ... */
-			write_lock_irqsave(&ep->lock, flags);
+			ep_remove(ep, dpi);
 		}
-
-		write_unlock_irqrestore(&ep->lock, flags);
 	}

 	/* Remove the structure to the linked list that links "struct eventpoll" */
-	write_lock_irqsave(&eplock, flags);
 	EP_LIST_DEL(&ep->llink);
-	write_unlock_irqrestore(&eplock, flags);
+
+	up_write(&epsem);

 	/* Free hash pages */
 	ep_free_pages(ep->hpages, EP_HASH_PAGES(ep->hashbits));
@@ -791,9 +823,9 @@
  * This is the callback that is used to add our wait queue to the
  * target file wakeup lists.
  */
-static void ep_ptable_queue_proc(void *priv, wait_queue_head_t *whead)
+static void ep_ptable_queue_proc(struct file *file, wait_queue_head_t *whead, poll_table *pt)
 {
-	struct epitem *dpi = priv;
+	struct epitem *dpi = EP_ITEM_FROM_EPQUEUE(pt);

 	/* No more than EP_MAX_POLL_QUEUE wait queue are supported */
 	if (dpi->nwait < EP_MAX_POLL_QUEUE) {
@@ -809,7 +841,7 @@
 	int error, i, revents;
 	unsigned long flags;
 	struct epitem *dpi;
-	poll_table pt;
+	struct ep_pqueue epq;

 	error = -ENOMEM;
 	if (!(dpi = DPI_MEM_ALLOC()))
@@ -830,7 +862,17 @@
 	}

 	/* Initialize the poll table using the queue callback */
-	poll_initwait_ex(&pt, 1, ep_ptable_queue_proc, dpi);
+	epq.dpi = dpi;
+	poll_initwait_ex(&epq.pt, ep_ptable_queue_proc, NULL);
+
+	/*
+	 * Attach the item to the poll hooks and get current event bits.
+	 * We can safely use the file* here because its usage count has
+	 * been increased by the caller of this function.
+	 */
+	revents = tfile->f_op->poll(tfile, &epq.pt);
+
+	poll_freewait(&epq.pt);

 	/* We have to drop the new item inside our item list to keep track of it */
 	write_lock_irqsave(&ep->lock, flags);
@@ -838,9 +880,6 @@
 	/* Add the current item to the hash table */
 	list_add(&dpi->llink, ep_hash_entry(ep, ep_hash_index(ep, tfile)));

-	/* Attach the item to the poll hooks and get current event bits */
-	revents = tfile->f_op->poll(tfile, &pt);
-
 	/* If the file is already "ready" we drop it inside the ready list */
 	if ((revents & pfd->events) && !EP_IS_LINKED(&dpi->rdllink)) {
 		list_add_tail(&dpi->rdllink, &ep->rdllist);
@@ -854,8 +893,6 @@

 	write_unlock_irqrestore(&ep->lock, flags);

-	poll_freewait(&pt);
-
 	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ep_insert(%p, %d)\n",
 		     current, ep, pfd->fd));

@@ -874,23 +911,22 @@
 {
 	unsigned int revents;
 	unsigned long flags;
-	poll_table pt;

 	/*
-	 * This is a special poll table initialization that will
-	 * make poll_wait() to not perform any wait queue insertion when
-	 * called by file->f_op->poll(). This is a fast way to retrieve
-	 * file events with perform any queue insertion, hence saving CPU cycles.
+	 * Set the new event interest mask before calling f_op->poll(), otherwise
+	 * a potential race might occur. In fact if we do this operation inside
+	 * the lock, an event might happen between the f_op->poll() call and the
+	 * new event set registering.
 	 */
-	poll_initwait_ex(&pt, 0, NULL, NULL);
-
-	write_lock_irqsave(&ep->lock, flags);
+	dpi->pfd.events = events;

-	/* Get current event bits */
-	revents = dpi->file->f_op->poll(dpi->file, &pt);
+	/*
+	 * Get current event bits. We can safely use the file* here because
+	 * its usage count has been increased by the caller of this function.
+	 */
+	revents = dpi->file->f_op->poll(dpi->file, NULL);

-	/* Set the new event interest mask */
-	dpi->pfd.events = events;
+	write_lock_irqsave(&ep->lock, flags);

 	/* If the file is already "ready" we drop it inside the ready list */
 	if ((revents & events) && EP_IS_LINKED(&dpi->llink) &&
@@ -906,26 +942,43 @@

 	write_unlock_irqrestore(&ep->lock, flags);

-	poll_freewait(&pt);
-
 	return 0;
 }


 /*
+ * This function unregister poll callbacks from the associated file descriptor.
+ * Since this must be called without holding "ep->lock" the atomic exchange trick
+ * will protect us from multiple unregister.
+ */
+static void ep_unregister_pollwait(struct eventpoll *ep, struct epitem *dpi)
+{
+	int i, nwait;
+
+	/* This is called without locks, so we need the atomic exchange */
+	nwait = xchg(&dpi->nwait, 0);
+
+	/* Removes poll wait queue hooks */
+	for (i = 0; i < nwait; i++)
+		remove_wait_queue(dpi->wait[i].whead, &dpi->wait[i].wait);
+}
+
+
+/*
  * Unlink the "struct epitem" from all places it might have been hooked up.
  * This function must be called with write IRQ lock on "ep->lock".
  */
 static int ep_unlink(struct eventpoll *ep, struct epitem *dpi)
 {
-	int i;
+	int error;

 	/*
 	 * It can happen that this one is called for an item already unlinked.
 	 * The check protect us from doing a double unlink ( crash ).
 	 */
+	error = -ENOENT;
 	if (!EP_IS_LINKED(&dpi->llink))
-		goto not_linked;
+		goto eexit_1;

 	/*
 	 * At this point is safe to do the job, unlink the item from our list.
@@ -934,10 +987,6 @@
 	 */
 	EP_LIST_DEL(&dpi->llink);

-	/* Removes poll wait queue hooks */
-	for (i = 0; i < dpi->nwait; i++)
-		remove_wait_queue(dpi->wait[i].whead, &dpi->wait[i].wait);
-
 	/*
 	 * If the item we are going to remove is inside the ready file descriptors
 	 * we want to remove it from this list to avoid stale events.
@@ -945,12 +994,13 @@
 	if (EP_IS_LINKED(&dpi->rdllink))
 		EP_LIST_DEL(&dpi->rdllink);

-not_linked:
+	error = 0;
+eexit_1:

-	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ep_unlink(%p, %d)\n",
-		     current, ep, dpi->pfd.fd));
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ep_unlink(%p, %d) = %d\n",
+		     current, ep, dpi->pfd.fd, error));

-	return 0;
+	return error;
 }


@@ -963,6 +1013,16 @@
 	int error;
 	unsigned long flags;

+	/*
+	 * Removes poll wait queue hooks. We _have_ to do this without holding
+	 * the "ep->lock" otherwise a deadlock might occur. This because of the
+	 * sequence of the lock acquisition. Here we do "ep->lock" then the wait
+	 * queue head lock when unregistering the wait queue. The wakeup callback
+	 * will run by holding the wait queue head lock and will call our callback
+	 * that will try to get "ep->lock".
+	 */
+	ep_unregister_pollwait(ep, dpi);
+
 	/* We need to acquire the write IRQ lock before calling ep_unlink() */
 	write_lock_irqsave(&ep->lock, flags);

@@ -974,14 +1034,14 @@
 	if (error)
 		goto eexit_1;

-	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ep_remove(%p, %d)\n",
-		     current, ep, dpi->pfd.fd));
-
 	/* At this point it is safe to free the eventpoll item */
 	ep_release_epitem(dpi);

 	error = 0;
 eexit_1:
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ep_remove(%p, %d) = %d\n",
+		     current, ep, dpi->pfd.fd, error));
+
 	return error;
 }

@@ -1057,28 +1117,19 @@


 /*
- * Perform the transfer of events to user space. Optimize the copy by
- * caching EP_EVENT_BUFF_SIZE events at a time and then copying it to user space.
+ * Since we have to release the lock during the __copy_to_user() operation and
+ * during the f_op->poll() call, we try to collect the maximum number of items
+ * by reducing the irqlock/irqunlock switching rate.
  */
-static int ep_events_transfer(struct eventpoll *ep, struct pollfd *events, int maxevents)
+static int ep_collect_ready_items(struct eventpoll *ep, struct epitem **adpi, int maxdpi)
 {
-	int eventcnt, ebufcnt, revents;
+	int ndpi;
 	unsigned long flags;
 	struct list_head *lsthead = &ep->rdllist;
-	struct pollfd eventbuf[EP_EVENT_BUFF_SIZE];
-	poll_table pt;
-
-	/*
-	 * This is a special poll table initialization that will
-	 * make poll_wait() to not perform any wait queue insertion when
-	 * called by file->f_op->poll(). This is a fast way to retrieve
-	 * file events with perform any queue insertion, hence saving CPU cycles.
-	 */
-	poll_initwait_ex(&pt, 0, NULL, NULL);

 	write_lock_irqsave(&ep->lock, flags);

-	for (eventcnt = 0, ebufcnt = 0; (eventcnt + ebufcnt) < maxevents && !list_empty(lsthead);) {
+	for (ndpi = 0; ndpi < maxdpi && !list_empty(lsthead);) {
 		struct epitem *dpi = list_entry(lsthead->next, struct epitem, rdllink);

 		/* Remove the item from the ready list */
@@ -1092,44 +1143,111 @@
 		if (!EP_IS_LINKED(&dpi->llink))
 			continue;

-		/* Fetch event bits from the signaled file */
-		revents = dpi->file->f_op->poll(dpi->file, &pt);
+		/*
+		 * We need to increase the usage count of the "struct epitem" because
+		 * another thread might call EP_CTL_DEL on this target and make the
+		 * object to vanish underneath our nose.
+		 */
+		ep_use_epitem(dpi);
+
+		adpi[ndpi++] = dpi;
+	}
+
+	write_unlock_irqrestore(&ep->lock, flags);
+
+	return ndpi;
+}
+
+
+/*
+ * This function is called without holding the "ep->lock" since the call to
+ * __copy_to_user() might sleep, and also f_op->poll() might reenable the IRQ
+ * because of the way poll() is traditionally implemented in Linux.
+ */
+static int ep_send_events(struct eventpoll *ep, struct epitem **adpi, int ndpi,
+			  struct pollfd *events)
+{
+	int i, eventcnt, eventbuf, revents;
+	struct epitem *dpi;
+	struct pollfd pfd[EP_MAX_BUF_EVENTS];
+
+	for (i = 0, eventcnt = 0, eventbuf = 0; i < ndpi; i++, adpi++) {
+		dpi = *adpi;
+
+		/* Get the ready file event set */
+		revents = dpi->file->f_op->poll(dpi->file, NULL);

 		if (revents & dpi->pfd.events) {
-			eventbuf[ebufcnt] = dpi->pfd;
-			eventbuf[ebufcnt].revents = revents & eventbuf[ebufcnt].events;
-			ebufcnt++;
-
-			/* If our buffer page is full we need to flush it to user space */
-			if (ebufcnt == EP_EVENT_BUFF_SIZE) {
-				/*
-				 * We need to drop the irqlock before using the function
-				 * __copy_to_user() because it might fault.
-				 */
-				write_unlock_irqrestore(&ep->lock, flags);
-				if (__copy_to_user(&events[eventcnt], eventbuf,
-						   ebufcnt * sizeof(struct pollfd))) {
-					poll_freewait(&pt);
+			pfd[eventbuf] = dpi->pfd;
+			pfd[eventbuf].revents = revents & pfd[eventbuf].events;
+			eventbuf++;
+			if (eventbuf == EP_MAX_BUF_EVENTS) {
+				if (__copy_to_user(&events[eventcnt], pfd,
+						   eventbuf * sizeof(struct pollfd))) {
+					for (; i < ndpi; i++, adpi++)
+						ep_release_epitem(*adpi);
 					return -EFAULT;
 				}
-				eventcnt += ebufcnt;
-				ebufcnt = 0;
-				write_lock_irqsave(&ep->lock, flags);
+				eventcnt += eventbuf;
+				eventbuf = 0;
 			}
 		}
+
+		ep_release_epitem(dpi);
 	}
-	write_unlock_irqrestore(&ep->lock, flags);

-	/* There might be still something inside our event buffer */
-	if (ebufcnt) {
-		if (__copy_to_user(&events[eventcnt], eventbuf,
-				   ebufcnt * sizeof(struct pollfd)))
-			eventcnt = -EFAULT;
-		else
-			eventcnt += ebufcnt;
+	if (eventbuf) {
+		if (__copy_to_user(&events[eventcnt], pfd,
+				   eventbuf * sizeof(struct pollfd)))
+			return -EFAULT;
+		eventcnt += eventbuf;
+	}
+
+	return eventcnt;
+}
+
+
+/*
+ * Perform the transfer of events to user space.
+ */
+static int ep_events_transfer(struct eventpoll *ep, struct pollfd *events, int maxevents)
+{
+	int eventcnt, ndpi, sdpi, maxdpi;
+	struct epitem *adpi[EP_MAX_COLLECT_ITEMS];
+
+	/*
+	 * We need to lock this because we could be hit by
+	 * ep_notify_file_close() while we're transfering
+	 * events to userspace. Read-holding "epsem" will lock
+	 * out  ep_notify_file_close() during the whole
+	 * transfer loop and this will garantie us that the
+	 * file will not vanish underneath our nose when
+	 * we will call f_op->poll() from ep_send_events().
+	 */
+	down_read(&epsem);
+
+	for (eventcnt = 0; eventcnt < maxevents;) {
+		/* Maximum items we can extract this time */
+		maxdpi = min(EP_MAX_COLLECT_ITEMS, maxevents - eventcnt);
+
+		/* Collect/extract ready items */
+		ndpi = ep_collect_ready_items(ep, adpi, maxdpi);
+
+		if (ndpi) {
+			/* Send events to userspace */
+			sdpi = ep_send_events(ep, adpi, ndpi, &events[eventcnt]);
+			if (sdpi < 0) {
+				up_read(&epsem);
+				return sdpi;
+			}
+			eventcnt += sdpi;
+		}
+
+		if (ndpi < maxdpi)
+			break;
 	}

-	poll_freewait(&pt);
+	up_read(&epsem);

 	return eventcnt;
 }
@@ -1254,8 +1372,8 @@
 	/* Initialize the list that will link "struct eventpoll" */
 	INIT_LIST_HEAD(&eplist);

-	/* Initialize the rwlock used to access "eplist" */
-	rwlock_init(&eplock);
+	/* Initialize the rwsem used to access "eplist" */
+	init_rwsem(&epsem);

 	/* Allocates slab cache used to allocate "struct epitem" items */
 	error = -ENOMEM;
diff -Nru linux-2.5.47.vanilla/fs/select.c linux-2.5.47.epoll/fs/select.c
--- linux-2.5.47.vanilla/fs/select.c	Mon Nov  4 15:45:35 2002
+++ linux-2.5.47.epoll/fs/select.c	Mon Nov 11 17:03:08 2002
@@ -54,7 +54,7 @@
  * poll table.
  */

-void poll_freewait(poll_table* pt)
+void __pollfreewait(poll_table* pt)
 {
 	struct poll_table_page * p = pt->table;
 	while (p) {
@@ -77,14 +77,6 @@
 {
 	struct poll_table_page *table = p->table;

-	if (!p->queue)
-		return;
-
-	if (p->qproc) {
-		p->qproc(p->priv, wait_address);
-		return;
-	}
-
 	if (!table || POLL_TABLE_FULL(table)) {
 		struct poll_table_page *new_table;

@@ -111,6 +103,7 @@
 		add_wait_queue(wait_address,&entry->wait);
 	}
 }
+

 #define __IN(fds, n)		(fds->in + n)
 #define __OUT(fds, n)		(fds->out + n)
diff -Nru linux-2.5.47.vanilla/include/linux/poll.h linux-2.5.47.epoll/include/linux/poll.h
--- linux-2.5.47.vanilla/include/linux/poll.h	Mon Nov 11 10:26:13 2002
+++ linux-2.5.47.epoll/include/linux/poll.h	Mon Nov 11 17:03:08 2002
@@ -11,30 +11,31 @@
 #include <asm/uaccess.h>

 struct poll_table_page;
+struct poll_table_struct;
+
+typedef void (*poll_queue_proc)(struct file *, wait_queue_head_t *, struct poll_table_struct *);
+typedef void (*poll_free_proc)(struct poll_table_struct *);

 typedef struct poll_table_struct {
-	int queue;
-	void *priv;
-	void (*qproc)(void *, wait_queue_head_t *);
+	poll_queue_proc qproc;
+	poll_free_proc fproc;
 	int error;
 	struct poll_table_page * table;
 } poll_table;

 extern void __pollwait(struct file * filp, wait_queue_head_t * wait_address, poll_table *p);
+extern void __pollfreewait(poll_table* pt);

 static inline void poll_wait(struct file * filp, wait_queue_head_t * wait_address, poll_table *p)
 {
 	if (p && wait_address)
-		__pollwait(filp, wait_address, p);
+		p->qproc(filp, wait_address, p);
 }

-static inline void poll_initwait_ex(poll_table* pt, int queue,
-				    void (*qproc)(void *, wait_queue_head_t *),
-				    void *priv)
+static inline void poll_initwait_ex(poll_table* pt, poll_queue_proc qproc, poll_free_proc fproc)
 {
-	pt->queue = queue;
 	pt->qproc = qproc;
-	pt->priv = priv;
+	pt->fproc = fproc;
 	pt->error = 0;
 	pt->table = NULL;
 }
@@ -42,10 +43,15 @@
 static inline void poll_initwait(poll_table* pt)
 {

-	poll_initwait_ex(pt, 1, NULL, NULL);
+	poll_initwait_ex(pt, __pollwait, __pollfreewait);
 }

-extern void poll_freewait(poll_table* pt);
+static inline void poll_freewait(poll_table* pt)
+{
+
+	if (pt && pt->fproc)
+		pt->fproc(pt);
+}


 /*
diff -Nru linux-2.5.47.vanilla/kernel/ksyms.c linux-2.5.47.epoll/kernel/ksyms.c
--- linux-2.5.47.vanilla/kernel/ksyms.c	Mon Nov 11 10:26:13 2002
+++ linux-2.5.47.epoll/kernel/ksyms.c	Mon Nov 11 17:03:08 2002
@@ -277,7 +277,7 @@
 EXPORT_SYMBOL(remote_llseek);
 EXPORT_SYMBOL(no_llseek);
 EXPORT_SYMBOL(__pollwait);
-EXPORT_SYMBOL(poll_freewait);
+EXPORT_SYMBOL(__pollfreewait);
 EXPORT_SYMBOL(ROOT_DEV);
 EXPORT_SYMBOL(find_get_page);
 EXPORT_SYMBOL(find_lock_page);


