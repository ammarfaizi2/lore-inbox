Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265261AbTGHSo3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 14:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267521AbTGHSo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 14:44:29 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:10377 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265261AbTGHSoZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 14:44:25 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 8 Jul 2003 11:51:25 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>
Subject: [patch] epoll-per-fd fix ...
Message-ID: <Pine.LNX.4.55.0307081147550.4792@bigblue.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew, this :

- Make epoll to allow to push multiple file descriptors sharing the same
	kernel's file*

Patch for 2.4.21 is here :

http://www.xmailserver.org/linux-patches/nio-improve.html#patches



- Davide


eventpoll.c |   41 +++++++++++++++++++++++++----------------
1 files changed, 25 insertions(+), 16 deletions(-)




diff -Nru linux-2.5.74.vanilla/fs/eventpoll.c linux-2.5.74.epoll/fs/eventpoll.c
--- linux-2.5.74.vanilla/fs/eventpoll.c	2003-07-07 15:22:37.000000000 -0700
+++ linux-2.5.74.epoll/fs/eventpoll.c	2003-07-07 15:40:44.000000000 -0700
@@ -245,6 +245,9 @@
 	/* The "container" of this item */
 	struct eventpoll *ep;

+	/* The file descriptor this item refers to */
+	int fd;
+
 	/* The file this item refers to */
 	struct file *file;

@@ -285,15 +288,17 @@
 static int ep_alloc_pages(char **pages, int numpages);
 static int ep_free_pages(char **pages, int numpages);
 static int ep_file_init(struct file *file, unsigned int hashbits);
-static unsigned int ep_hash_index(struct eventpoll *ep, struct file *file);
+static unsigned int ep_hash_index(struct eventpoll *ep, struct file *file, int fd);
 static struct list_head *ep_hash_entry(struct eventpoll *ep, unsigned int index);
 static int ep_init(struct eventpoll *ep, unsigned int hashbits);
 static void ep_free(struct eventpoll *ep);
-static struct epitem *ep_find(struct eventpoll *ep, struct file *file);
+static struct epitem *ep_find(struct eventpoll *ep, struct file *file, int fd);
 static void ep_use_epitem(struct epitem *epi);
 static void ep_release_epitem(struct epitem *epi);
-static void ep_ptable_queue_proc(struct file *file, wait_queue_head_t *whead, poll_table *pt);
-static int ep_insert(struct eventpoll *ep, struct epoll_event *event, struct file *tfile);
+static void ep_ptable_queue_proc(struct file *file, wait_queue_head_t *whead,
+				 poll_table *pt);
+static int ep_insert(struct eventpoll *ep, struct epoll_event *event,
+		     struct file *tfile, int fd);
 static int ep_modify(struct eventpoll *ep, struct epitem *epi, struct epoll_event *event);
 static void ep_unregister_pollwait(struct eventpoll *ep, struct epitem *epi);
 static int ep_unlink(struct eventpoll *ep, struct epitem *epi);
@@ -580,7 +585,7 @@
 	down_write(&ep->sem);

 	/* Try to lookup the file inside our hash table */
-	epi = ep_find(ep, tfile);
+	epi = ep_find(ep, tfile, fd);

 	error = -EINVAL;
 	switch (op) {
@@ -588,7 +593,7 @@
 		if (!epi) {
 			epds.events |= POLLERR | POLLHUP;

-			error = ep_insert(ep, &epds, tfile);
+			error = ep_insert(ep, &epds, tfile, fd);
 		} else
 			error = -EEXIST;
 		break;
@@ -814,10 +819,11 @@
 /*
  * Calculate the index of the hash relative to "file".
  */
-static unsigned int ep_hash_index(struct eventpoll *ep, struct file *file)
+static unsigned int ep_hash_index(struct eventpoll *ep, struct file *file, int fd)
 {
+	unsigned long ptr = (unsigned long) file ^ (fd << ep->hashbits);

-	return (unsigned int) hash_ptr(file, ep->hashbits);
+	return (unsigned int) hash_ptr((void *) ptr, ep->hashbits);
 }


@@ -920,7 +926,7 @@
  * the returned item, so the caller must call ep_release_epitem()
  * after finished using the "struct epitem".
  */
-static struct epitem *ep_find(struct eventpoll *ep, struct file *file)
+static struct epitem *ep_find(struct eventpoll *ep, struct file *file, int fd)
 {
 	unsigned long flags;
 	struct list_head *lsthead, *lnk;
@@ -928,11 +934,11 @@

 	read_lock_irqsave(&ep->lock, flags);

-	lsthead = ep_hash_entry(ep, ep_hash_index(ep, file));
+	lsthead = ep_hash_entry(ep, ep_hash_index(ep, file, fd));
 	list_for_each(lnk, lsthead) {
 		epi = list_entry(lnk, struct epitem, llink);

-		if (epi->file == file) {
+		if (epi->file == file && epi->fd == fd) {
 			ep_use_epitem(epi);
 			break;
 		}
@@ -976,7 +982,8 @@
  * This is the callback that is used to add our wait queue to the
  * target file wakeup lists.
  */
-static void ep_ptable_queue_proc(struct file *file, wait_queue_head_t *whead, poll_table *pt)
+static void ep_ptable_queue_proc(struct file *file, wait_queue_head_t *whead,
+				 poll_table *pt)
 {
 	struct epitem *epi = EP_ITEM_FROM_EPQUEUE(pt);
 	struct eppoll_entry *pwq;
@@ -995,7 +1002,8 @@
 }


-static int ep_insert(struct eventpoll *ep, struct epoll_event *event, struct file *tfile)
+static int ep_insert(struct eventpoll *ep, struct epoll_event *event,
+		     struct file *tfile, int fd)
 {
 	int error, revents, pwake = 0;
 	unsigned long flags;
@@ -1014,6 +1022,7 @@
 	INIT_LIST_HEAD(&epi->pwqlist);
 	epi->ep = ep;
 	epi->file = tfile;
+	epi->fd = fd;
 	epi->event = *event;
 	atomic_set(&epi->usecnt, 1);
 	epi->nwait = 0;
@@ -1046,7 +1055,7 @@
 	write_lock_irqsave(&ep->lock, flags);

 	/* Add the current item to the hash table */
-	list_add(&epi->llink, ep_hash_entry(ep, ep_hash_index(ep, tfile)));
+	list_add(&epi->llink, ep_hash_entry(ep, ep_hash_index(ep, tfile, fd)));

 	/* If the file is already "ready" we drop it inside the ready list */
 	if ((revents & event->events) && !EP_IS_LINKED(&epi->rdllink)) {
@@ -1065,8 +1074,8 @@
 	if (pwake)
 		ep_poll_safewake(&psw, &ep->poll_wait);

-	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ep_insert(%p, %p)\n",
-		     current, ep, tfile));
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ep_insert(%p, %p, %d)\n",
+		     current, ep, tfile, fd));

 	return 0;

