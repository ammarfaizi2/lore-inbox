Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261482AbTCJT4J>; Mon, 10 Mar 2003 14:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261486AbTCJT4J>; Mon, 10 Mar 2003 14:56:09 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:37263 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261482AbTCJTzt>; Mon, 10 Mar 2003 14:55:49 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 10 Mar 2003 12:15:25 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Hanna Linder <hannal@us.ibm.com>, Janet Morgan <janetmor@us.ibm.com>,
       Marius Aamodt Eriksen <marius@citi.umich.edu>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       Niels Provos <provos@citi.umich.edu>
Subject: [patch, rfc] lt-epoll ( level triggered epoll ) ...
Message-ID: <Pine.LNX.4.50.0303101139520.1922-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


During the last three months I spent considerable amount of time explainig
developers how edge triggered APIs works, and how to use epoll inside
their apps. It's time for me to face the reality, that is that :

1) developers not quite understand ET APIs
2) most existing apps are written using LT APIs

To briefly explain the difference between an Edge Triggered and an Level
Triggered interface, suppose this sequence :

1) Pipe writer writes 2Kb of data on the write side
2) Pipe reader read 1Kb
3) Pipe reader calls epoll_wait()

With an ET API, since the I/O space is not exhausted, the application will
hang on 3) because to trasition 0->1 won't be possible. With an LT API the
application will receive the EPOLLIN event, like if it was using poll().
Thanks to Niels and Marius to have convinced me to try to implement epoll
as LT API during the last weekend. This is the patch that implements the
epoll interface as LT API, against the 2.5.64 kernel. Because of the way
the original design was architected, it really took a few bits to be
changed. Tests on my machine ( UP ) looks fine and performance are aligned
to the ET epoll ( on UP ). IMHO there are two major values in adoptiong an
LT epoll :

1) Developers uderstand it better than ET APIs and will very likely use it
	in a more widespread way
2) Existing apps using poll/select can easily be ported usinf LT epoll

The LT epoll is by all means the fastest poll available and can be used
wherever poll can be used. To test it I also ported thttpd to LT
epoll and, so far, it didn't puke on my face. Niels and Marius also wrote
a nice event library :

http://monkey.org/~provos/libevent/

that uses LT epoll, as long as poll and select. The usage pattern of an LT
epoll is slightly different from the ET epoll. Where with the ET epoll you
very likely registered the EPOLLIN|EPOLLOUT during the insertion of the fd
inside the interface, and you left the edge behaviour of the interface
itself to filter events, with LT epoll you simply use epoll_ctl(EPOLL_CTL_MOD)
to switch between EPOLLIN and EPOLLOUT. In front of this considerations we
have three options that I can think :

1) We leave epoll as is ( ET )
2) We apply the patch that will make epoll LT
3) We add a parameter to epoll_create() to fix the interface behaviour at
	creation time ( small change on the current patch )

With 2) and 3) there are also man pages to be reviewed to be posted to
Andries.
Comments ?




- Davide




fs/eventpoll.c            |  216 +++++++++++++++++++++++++++++++---------------
include/linux/eventpoll.h |    2
2 files changed, 150 insertions, 68 deletions





diff -Nru linux-2.5.64.vanilla/fs/eventpoll.c linux-2.5.64.epoll/fs/eventpoll.c
--- linux-2.5.64.vanilla/fs/eventpoll.c	Tue Mar  4 19:29:16 2003
+++ linux-2.5.64.epoll/fs/eventpoll.c	Sun Mar  9 13:59:00 2003
@@ -1,6 +1,6 @@
 /*
  *  fs/eventpoll.c ( Efficent event polling implementation )
- *  Copyright (C) 2001,...,2002	 Davide Libenzi
+ *  Copyright (C) 2001,...,2003	 Davide Libenzi
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -117,11 +117,6 @@
  */
 #define EP_MAX_BUF_EVENTS 32

-/*
- * Used to optimize ready items collection by reducing the irqlock/irqunlock
- * switching rate. This is kept in stack too, so do not go wild with this number.
- */
-#define EP_MAX_COLLECT_ITEMS 64


 /*
@@ -223,6 +218,15 @@

 	/* List header used to link this item to the "struct file" items list */
 	struct list_head fllink;
+
+	/* List header used to link the item to the transfer list */
+	struct list_head txlink;
+
+	/*
+	 * This is used during the collection/transfer of events to userspace
+	 * to pin items empty events set.
+	 */
+	unsigned int revents;
 };

 /* Wrapper struct used by poll queueing */
@@ -256,9 +260,10 @@
 static int ep_poll_callback(wait_queue_t *wait, unsigned mode, int sync);
 static int ep_eventpoll_close(struct inode *inode, struct file *file);
 static unsigned int ep_eventpoll_poll(struct file *file, poll_table *wait);
-static int ep_collect_ready_items(struct eventpoll *ep, struct epitem **aepi, int maxepi);
-static int ep_send_events(struct eventpoll *ep, struct epitem **aepi, int nepi,
+static int ep_collect_ready_items(struct eventpoll *ep, struct list_head *txlist, int maxevents);
+static int ep_send_events(struct eventpoll *ep, struct list_head *txlist,
 			  struct epoll_event *events);
+static void ep_reinject_items(struct eventpoll *ep, struct list_head *txlist);
 static int ep_events_transfer(struct eventpoll *ep, struct epoll_event *events, int maxevents);
 static int ep_poll(struct eventpoll *ep, struct epoll_event *events, int maxevents,
 		   long timeout);
@@ -340,13 +345,14 @@
 	unsigned long flags;
 	task_t *this_task = current;
 	struct list_head *lsthead = &psw->wake_task_list, *lnk;
+	struct wake_task_node *tncur;
 	struct wake_task_node tnode;

 	spin_lock_irqsave(&psw->lock, flags);

 	/* Try to see if the current task is already inside this wakeup call */
 	list_for_each(lnk, lsthead) {
-		struct wake_task_node *tncur = list_entry(lnk, struct wake_task_node, llink);
+		tncur = list_entry(lnk, struct wake_task_node, llink);

 		if (tncur->task == this_task) {
 			if (tncur->wq == wq || ++wake_nests > EP_MAX_POLLWAKE_NESTS) {
@@ -830,6 +836,7 @@
 {
 	unsigned int i, hsize;
 	struct list_head *lsthead, *lnk;
+	struct epitem *epi;

 	/*
 	 * We need to lock this because we could be hit by
@@ -844,7 +851,7 @@
 		lsthead = ep_hash_entry(ep, i);

 		list_for_each(lnk, lsthead) {
-			struct epitem *epi = list_entry(lnk, struct epitem, llink);
+			epi = list_entry(lnk, struct epitem, llink);

 			ep_unregister_pollwait(ep, epi);
 		}
@@ -860,7 +867,7 @@
 		lsthead = ep_hash_entry(ep, i);

 		while (!list_empty(lsthead)) {
-			struct epitem *epi = list_entry(lsthead->next, struct epitem, llink);
+			epi = list_entry(lsthead->next, struct epitem, llink);

 			ep_remove(ep, epi);
 		}
@@ -971,6 +978,7 @@
 	INIT_LIST_HEAD(&epi->llink);
 	INIT_LIST_HEAD(&epi->rdllink);
 	INIT_LIST_HEAD(&epi->fllink);
+	INIT_LIST_HEAD(&epi->txlink);
 	INIT_LIST_HEAD(&epi->pwqlist);
 	epi->ep = ep;
 	epi->file = tfile;
@@ -1077,16 +1085,28 @@
 	/* Copy the data member from inside the lock */
 	epi->event.data = event->data;

-	/* If the file is already "ready" we drop it inside the ready list */
-	if ((revents & event->events) && EP_IS_LINKED(&epi->llink) &&
-	    !EP_IS_LINKED(&epi->rdllink)) {
-		list_add_tail(&epi->rdllink, &ep->rdllist);
-
-		/* Notify waiting tasks that events are available */
-		if (waitqueue_active(&ep->wq))
-			wake_up(&ep->wq);
-		if (waitqueue_active(&ep->poll_wait))
-			pwake++;
+	/*
+	 * If the item is not linked to the hash it means that it's on its
+	 * way toward the removal. Do nothing in this case.
+	 */
+	if (EP_IS_LINKED(&epi->llink)) {
+		/*
+		 * If the item is "hot" and it is not registered inside the ready
+		 * list, push it inside. If the item is not "hot" and it is currently
+		 * registered inside the ready list, unlink it.
+		 */
+		if (revents & event->events) {
+			if (!EP_IS_LINKED(&epi->rdllink)) {
+				list_add_tail(&epi->rdllink, &ep->rdllist);
+
+				/* Notify waiting tasks that events are available */
+				if (waitqueue_active(&ep->wq))
+					wake_up(&ep->wq);
+				if (waitqueue_active(&ep->poll_wait))
+					pwake++;
+			}
+		} else if (EP_IS_LINKED(&epi->rdllink))
+			EP_LIST_DEL(&epi->rdllink);
 	}

 	write_unlock_irqrestore(&ep->lock, flags);
@@ -1113,8 +1133,7 @@
 	/* This is called without locks, so we need the atomic exchange */
 	nwait = xchg(&epi->nwait, 0);

-	if (nwait)
-	{
+	if (nwait) {
 		while (!list_empty(lsthead)) {
 			pwq = list_entry(lsthead->next, struct eppoll_entry, llink);

@@ -1295,28 +1314,45 @@
  * during the f_op->poll() call, we try to collect the maximum number of items
  * by reducing the irqlock/irqunlock switching rate.
  */
-static int ep_collect_ready_items(struct eventpoll *ep, struct epitem **aepi, int maxepi)
+static int ep_collect_ready_items(struct eventpoll *ep, struct list_head *txlist, int maxevents)
 {
 	int nepi;
 	unsigned long flags;
-	struct list_head *lsthead = &ep->rdllist;
+	struct list_head *lsthead = &ep->rdllist, *lnk;
+	struct epitem *epi;

 	write_lock_irqsave(&ep->lock, flags);

-	for (nepi = 0; nepi < maxepi && !list_empty(lsthead);) {
-		struct epitem *epi = list_entry(lsthead->next, struct epitem, rdllink);
+	for (nepi = 0, lnk = lsthead->next; lnk != lsthead && nepi < maxevents;) {
+		epi = list_entry(lnk, struct epitem, rdllink);

-		/* Remove the item from the ready list */
-		EP_LIST_DEL(&epi->rdllink);
+		lnk = lnk->next;

-		/*
-		 * We need to increase the usage count of the "struct epitem" because
-		 * another thread might call EPOLL_CTL_DEL on this target and make the
-		 * object to vanish underneath our nose.
-		 */
-		ep_use_epitem(epi);
+		/* If this file is already in the ready list we exit soon */
+		if (!EP_IS_LINKED(&epi->txlink)) {
+			/*
+			 * We need to increase the usage count of the "struct epitem" because
+			 * another thread might call EPOLL_CTL_DEL on this target and make the
+			 * object to vanish underneath our nose.
+			 */
+			ep_use_epitem(epi);

-		aepi[nepi++] = epi;
+			/*
+			 * This is initialized in this way so that the default
+			 * behaviour of the reinjecting code will be to push back
+			 * the item inside the ready list.
+			 */
+			epi->revents = epi->event.events;
+
+			/* Link the ready item into the transfer list */
+			list_add(&epi->txlink, txlist);
+			nepi++;
+
+			/*
+			 * Unlink the item from the ready list.
+			 */
+			EP_LIST_DEL(&epi->rdllink);
+		}
 	}

 	write_unlock_irqrestore(&ep->lock, flags);
@@ -1330,36 +1366,40 @@
  * __copy_to_user() might sleep, and also f_op->poll() might reenable the IRQ
  * because of the way poll() is traditionally implemented in Linux.
  */
-static int ep_send_events(struct eventpoll *ep, struct epitem **aepi, int nepi,
+static int ep_send_events(struct eventpoll *ep, struct list_head *txlist,
 			  struct epoll_event *events)
 {
-	int i, eventcnt, eventbuf, revents;
+	int eventcnt = 0, eventbuf = 0;
+	unsigned int revents;
+	struct list_head *lnk;
 	struct epitem *epi;
 	struct epoll_event event[EP_MAX_BUF_EVENTS];

-	for (i = 0, eventcnt = 0, eventbuf = 0; i < nepi; i++, aepi++) {
-		epi = *aepi;
+	list_for_each(lnk, txlist) {
+		epi = list_entry(lnk, struct epitem, txlink);

 		/* Get the ready file event set */
 		revents = epi->file->f_op->poll(epi->file, NULL);

-		if (revents & epi->event.events) {
+		/*
+		 * Set the return event set for the current file descriptor.
+		 * Note that only the task task was successfully able to link
+		 * the item to its "txlist" will write this field.
+		 */
+		epi->revents = revents & epi->event.events;
+
+		if (epi->revents) {
 			event[eventbuf] = epi->event;
 			event[eventbuf].events &= revents;
 			eventbuf++;
 			if (eventbuf == EP_MAX_BUF_EVENTS) {
 				if (__copy_to_user(&events[eventcnt], event,
-						   eventbuf * sizeof(struct epoll_event))) {
-					for (; i < nepi; i++, aepi++)
-						ep_release_epitem(*aepi);
+						   eventbuf * sizeof(struct epoll_event)))
 					return -EFAULT;
-				}
 				eventcnt += eventbuf;
 				eventbuf = 0;
 			}
 		}
-
-		ep_release_epitem(epi);
 	}

 	if (eventbuf) {
@@ -1374,12 +1414,66 @@


 /*
+ * Walk through the transfer list we collected with ep_collect_ready_items()
+ * and, if 1) the item is still "alive" 2) its event set is not empty 3) it's
+ * not already linked, links it to the ready list.
+ */
+static void ep_reinject_items(struct eventpoll *ep, struct list_head *txlist)
+{
+	int ricnt = 0, pwake = 0;
+	unsigned long flags;
+	struct epitem *epi;
+
+	write_lock_irqsave(&ep->lock, flags);
+
+	while (!list_empty(txlist)) {
+		epi = list_entry(txlist->next, struct epitem, txlink);
+
+		/* Unlink the current item from the transfer list */
+		EP_LIST_DEL(&epi->txlink);
+
+		/*
+		 * If the item is no more linked to the interest set, we don't
+		 * have to push it inside the ready list because the following
+		 * ep_release_epitem() is going to drop it.
+		 */
+		if (EP_IS_LINKED(&epi->llink) && (epi->revents & epi->event.events) &&
+		    !EP_IS_LINKED(&epi->rdllink)) {
+			list_add_tail(&epi->rdllink, &ep->rdllist);
+			ricnt++;
+		}
+
+		ep_release_epitem(epi);
+	}
+
+	if (ricnt) {
+		/*
+		 * Wake up ( if active ) both the eventpoll wait list and the ->poll()
+		 * wait list.
+		 */
+		if (waitqueue_active(&ep->wq))
+			wake_up(&ep->wq);
+		if (waitqueue_active(&ep->poll_wait))
+			pwake++;
+	}
+
+	write_unlock_irqrestore(&ep->lock, flags);
+
+	/* We have to call this outside the lock */
+	if (pwake)
+		ep_poll_safewake(&psw, &ep->poll_wait);
+}
+
+
+/*
  * Perform the transfer of events to user space.
  */
 static int ep_events_transfer(struct eventpoll *ep, struct epoll_event *events, int maxevents)
 {
-	int eventcnt, nepi, sepi, maxepi;
-	struct epitem *aepi[EP_MAX_COLLECT_ITEMS];
+	int eventcnt = 0;
+	struct list_head txlist;
+
+	INIT_LIST_HEAD(&txlist);

 	/*
 	 * We need to lock this because we could be hit by
@@ -1392,25 +1486,13 @@
 	 */
 	down_read(&epsem);

-	for (eventcnt = 0; eventcnt < maxevents;) {
-		/* Maximum items we can extract this time */
-		maxepi = min(EP_MAX_COLLECT_ITEMS, maxevents - eventcnt);
-
-		/* Collect/extract ready items */
-		nepi = ep_collect_ready_items(ep, aepi, maxepi);
-
-		if (nepi) {
-			/* Send events to userspace */
-			sepi = ep_send_events(ep, aepi, nepi, &events[eventcnt]);
-			if (sepi < 0) {
-				up_read(&epsem);
-				return sepi;
-			}
-			eventcnt += sepi;
-		}
+	/* Collect/extract ready items */
+	if (ep_collect_ready_items(ep, &txlist, maxevents)) {
+		/* Build result set in userspace */
+		eventcnt = ep_send_events(ep, &txlist, events);

-		if (nepi < maxepi)
-			break;
+		/* Reinject ready items into the ready list */
+		ep_reinject_items(ep, &txlist);
 	}

 	up_read(&epsem);
diff -Nru linux-2.5.64.vanilla/include/linux/eventpoll.h linux-2.5.64.epoll/include/linux/eventpoll.h
--- linux-2.5.64.vanilla/include/linux/eventpoll.h	Tue Mar  4 19:29:17 2003
+++ linux-2.5.64.epoll/include/linux/eventpoll.h	Sun Mar  9 09:09:23 2003
@@ -1,6 +1,6 @@
 /*
  *  include/linux/eventpoll.h ( Efficent event polling implementation )
- *  Copyright (C) 2001,...,2002	 Davide Libenzi
+ *  Copyright (C) 2001,...,2003	 Davide Libenzi
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
