Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbTFBURV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 16:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbTFBURU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 16:17:20 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:61834 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261887AbTFBUQ5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 16:16:57 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 2 Jun 2003 13:27:57 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>
Subject: [patch] epoll race fix for 2.5 ...
Message-ID: <Pine.LNX.4.55.0305311458260.11255@bigblue.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The was a race triggered by heavy MT usage that could have caused
processes in D state. Bad Davide, bad ...
Also, the semaphore is now per-epoll-fd and not global. Plus some comment
adjustment.
Updated patches for 2.4.{20,21-rc6} are here :

http://www.xmailserver.org/linux-patches/nio-improve.html#patches



- Davide



eventpoll.c |  132 +++++++++++++++++++++++++-----------------------------------
1 files changed, 55 insertions(+), 77 deletions(-)




diff -Nru linux-2.5.69.vanilla/fs/eventpoll.c linux-2.5.69.epoll/fs/eventpoll.c
--- linux-2.5.69.vanilla/fs/eventpoll.c	2003-05-04 16:53:13.000000000 -0700
+++ linux-2.5.69.epoll/fs/eventpoll.c	2003-06-02 12:38:07.000000000 -0700
@@ -150,6 +150,14 @@
 	/* Protect the this structure access */
 	rwlock_t lock;

+	/*
+	 * This semaphore is used to ensure that files are not removed
+	 * while epoll is using them. This is read-held during the event
+	 * collection loop and it is write-held during the file cleanup
+	 * path, the epoll file exit code and the ctl operations.
+	 */
+	struct rw_semaphore sem;
+
 	/* Wait queue used by sys_epoll_wait() */
 	wait_queue_head_t wq;

@@ -276,16 +284,6 @@
 /* Safe wake up implementation */
 static struct poll_safewake psw;

-/*
- * This semaphore is used to ensure that files are not removed
- * while epoll is using them. Namely the f_op->poll(), since
- * it has to be called from outside the lock, must be protected.
- * This is read-held during the event transfer loop to userspace
- * and it is write-held during the file cleanup path and the epoll
- * file exit code.
- */
-static struct rw_semaphore epsem;
-
 /* Slab cache used to allocate "struct epitem" */
 static kmem_cache_t *epi_cache;

@@ -354,15 +352,14 @@
 	list_for_each(lnk, lsthead) {
 		tncur = list_entry(lnk, struct wake_task_node, llink);

-		if (tncur->task == this_task) {
-			if (tncur->wq == wq || ++wake_nests > EP_MAX_POLLWAKE_NESTS) {
-				/*
-				 * Ops ... loop detected or maximum nest level reached.
-				 * We abort this wake by breaking the cycle itself.
-				 */
-				spin_unlock_irqrestore(&psw->lock, flags);
-				return;
-			}
+		if (tncur->wq == wq ||
+		    (tncur->task == this_task && ++wake_nests > EP_MAX_POLLWAKE_NESTS)) {
+			/*
+			 * Ops ... loop detected or maximum nest level reached.
+			 * We abort this wake by breaking the cycle itself.
+			 */
+			spin_unlock_irqrestore(&psw->lock, flags);
+			return;
 		}
 	}

@@ -434,14 +431,15 @@
 	 * The only hit might come from ep_free() but by holding the semaphore
 	 * will correctly serialize the operation.
 	 */
-	down_write(&epsem);
+
 	while (!list_empty(lsthead)) {
 		epi = list_entry(lsthead->next, struct epitem, fllink);

 		EP_LIST_DEL(&epi->fllink);
+		down_write(&epi->ep->sem);
 		ep_remove(epi->ep, epi);
+		up_write(&epi->ep->sem);
 	}
-	up_write(&epsem);
 }


@@ -565,9 +563,18 @@
 			error = -EEXIST;
 		break;
 	case EPOLL_CTL_DEL:
-		if (epi)
+		if (epi) {
+			/*
+			 * We need to protect the remove operation because another
+			 * thread might be doing an epoll_wait() and using the
+			 * target file.
+			 */
+			down_write(&ep->sem);
+
 			error = ep_remove(ep, epi);
-		else
+
+			up_write(&ep->sem);
+		} else
 			error = -ENOENT;
 		break;
 	case EPOLL_CTL_MOD:
@@ -700,10 +707,6 @@
 	file->f_vfsmnt = mntget(eventpoll_mnt);
 	file->f_dentry = dget(dentry);

-	/*
-	 * Initialize the file as read/write because it could be used
-	 * with write() to add/remove/change interest sets.
-	 */
 	file->f_pos = 0;
 	file->f_flags = O_RDONLY;
 	file->f_op = &eventpoll_fops;
@@ -812,6 +815,7 @@
 	unsigned int i, hsize;

 	rwlock_init(&ep->lock);
+	init_rwsem(&ep->sem);
 	init_waitqueue_head(&ep->wq);
 	init_waitqueue_head(&ep->poll_wait);
 	INIT_LIST_HEAD(&ep->rdllist);
@@ -838,11 +842,15 @@
 	struct list_head *lsthead, *lnk;
 	struct epitem *epi;

+	/* We need to release all tasks waiting for these file */
+	if (waitqueue_active(&ep->poll_wait))
+		ep_poll_safewake(&psw, &ep->poll_wait);
+
 	/*
 	 * We need to lock this because we could be hit by
 	 * eventpoll_release() while we're freeing the "struct eventpoll".
 	 */
-	down_write(&epsem);
+	down_write(&ep->sem);

 	/*
 	 * Walks through the whole hash by unregistering poll callbacks.
@@ -860,7 +868,7 @@
 	/*
 	 * Walks through the whole hash by freeing each "struct epitem". At this
 	 * point we are sure no poll callbacks will be lingering around, and also by
-	 * write-holding "epsem" we can be sure that no file cleanup code will hit
+	 * write-holding "sem" we can be sure that no file cleanup code will hit
 	 * us during this operation. So we can avoid the lock on "ep->lock".
 	 */
 	for (i = 0, hsize = 1 << ep->hashbits; i < hsize; i++) {
@@ -873,7 +881,7 @@
 		}
 	}

-	up_write(&epsem);
+	up_write(&ep->sem);

 	/* Free hash pages */
 	ep_free_pages(ep->hpages, EP_HASH_PAGES(ep->hashbits));
@@ -1335,20 +1343,6 @@
 		/* If this file is already in the ready list we exit soon */
 		if (!EP_IS_LINKED(&epi->txlink)) {
 			/*
-			 * We need to increase the usage count of the "struct epitem" because
-			 * another thread might call EPOLL_CTL_DEL on this target and make the
-			 * object to vanish underneath our nose.
-			 */
-			ep_use_epitem(epi);
-
-			/*
-			 * We need to increase the usage count of the "struct file" because
-			 * another thread might call close() on this target and make the file
-			 * to vanish before we will be able to call f_op->poll().
-			 */
-			get_file(epi->file);
-
-			/*
 			 * This is initialized in this way so that the default
 			 * behaviour of the reinjecting code will be to push back
 			 * the item inside the ready list.
@@ -1386,19 +1380,21 @@
 	struct epitem *epi;
 	struct epoll_event event[EP_MAX_BUF_EVENTS];

+	/*
+	 * We can loop without lock because this is a task private list.
+	 * The test done during the collection loop will guarantee us that
+	 * another task will not try to collect this file. Also, items
+	 * cannot vanish during the loop because we are holding "sem".
+	 */
 	list_for_each(lnk, txlist) {
 		epi = list_entry(lnk, struct epitem, txlink);

-		/* Get the ready file event set */
-		revents = epi->file->f_op->poll(epi->file, NULL);
-
 		/*
-		 * Release the file usage before checking the event mask.
-		 * In case this call will lead to the file removal, its
-		 * ->event.events member has been already set to zero and
-		 * this will make the event to be dropped.
+		 * Get the ready file event set. We can safely use the file
+		 * because we are holding the "sem" in read and this will
+		 * guarantee that both the file and the item will not vanish.
 		 */
-		fput(epi->file);
+		revents = epi->file->f_op->poll(epi->file, NULL);

 		/*
 		 * Set the return event set for the current file descriptor.
@@ -1413,17 +1409,8 @@
 			eventbuf++;
 			if (eventbuf == EP_MAX_BUF_EVENTS) {
 				if (__copy_to_user(&events[eventcnt], event,
-						   eventbuf * sizeof(struct epoll_event))) {
-					/*
-					 * We need to complete the loop to decrement the file
-					 * usage before returning from this function.
-					 */
-					for (lnk = lnk->next; lnk != txlist; lnk = lnk->next) {
-						epi = list_entry(lnk, struct epitem, txlink);
-						fput(epi->file);
-					}
+						   eventbuf * sizeof(struct epoll_event)))
 					return -EFAULT;
-				}
 				eventcnt += eventbuf;
 				eventbuf = 0;
 			}
@@ -1444,7 +1431,8 @@
 /*
  * Walk through the transfer list we collected with ep_collect_ready_items()
  * and, if 1) the item is still "alive" 2) its event set is not empty 3) it's
- * not already linked, links it to the ready list.
+ * not already linked, links it to the ready list. Same as above, we are holding
+ * "sem" so items cannot vanish underneath our nose.
  */
 static void ep_reinject_items(struct eventpoll *ep, struct list_head *txlist)
 {
@@ -1472,8 +1460,6 @@
 			list_add_tail(&epi->rdllink, &ep->rdllist);
 			ricnt++;
 		}
-
-		ep_release_epitem(epi);
 	}

 	if (ricnt) {
@@ -1507,17 +1493,12 @@

 	/*
 	 * We need to lock this because we could be hit by
-	 * eventpoll_release() while we're transfering
-	 * events to userspace. Read-holding "epsem" will lock
-	 * out eventpoll_release() during the whole
-	 * transfer loop and this will garantie us that the
-	 * file will not vanish underneath our nose when
-	 * we will call f_op->poll() from ep_send_events().
+	 * eventpoll_release() and epoll_ctl(EPOLL_CTL_DEL).
 	 */
-	down_read(&epsem);
+	down_read(&ep->sem);

 	/* Collect/extract ready items */
-	if (ep_collect_ready_items(ep, &txlist, maxevents)) {
+	if (ep_collect_ready_items(ep, &txlist, maxevents) > 0) {
 		/* Build result set in userspace */
 		eventcnt = ep_send_events(ep, &txlist, events);

@@ -1525,7 +1506,7 @@
 		ep_reinject_items(ep, &txlist);
 	}

-	up_read(&epsem);
+	up_read(&ep->sem);

 	return eventcnt;
 }
@@ -1649,9 +1630,6 @@
 {
 	int error;

-	/* Initialize the semaphore used to syncronize the file cleanup code */
-	init_rwsem(&epsem);
-
 	/* Initialize the structure used to perform safe poll wait head wake ups */
 	ep_poll_safewake_init(&psw);

