Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264838AbSKJMGb>; Sun, 10 Nov 2002 07:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264848AbSKJMGb>; Sun, 10 Nov 2002 07:06:31 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:1698 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S264838AbSKJMG0>;
	Sun, 10 Nov 2002 07:06:26 -0500
Message-ID: <3DCE421F.8000802@colorfullife.com>
Date: Sun, 10 Nov 2002 12:25:19 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Davide Libenzi <davidel@xmailserver.org>
Subject: [RFC,PATCH] poll cleanups 1/3
Content-Type: multipart/mixed;
 boundary="------------050905010103040001020202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050905010103040001020202
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Change 1:
Davide added a 'queue' variable into the poll_table, to indicate that no 
wait queue operations should happen.
This is not needed: setting the poll table to NULL achieves the same 
effect, and is used by select/poll to implement syscalls with a 0 timeout.

Patch vs 2.5.46, untested.

--
    Manfred

--------------050905010103040001020202
Content-Type: text/plain;
 name="patch-poll-1-NULL"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-poll-1-NULL"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 5
//  SUBLEVEL = 46
//  EXTRAVERSION =
--- 2.5/include/linux/poll.h	2002-11-10 11:54:59.000000000 +0100
+++ build-2.5/include/linux/poll.h	2002-11-10 11:57:39.000000000 +0100
@@ -13,7 +13,6 @@
 struct poll_table_page;
 
 typedef struct poll_table_struct {
-	int queue;
 	void *priv;
 	void (*qproc)(void *, wait_queue_head_t *);
 	int error;
@@ -30,18 +29,16 @@
 
 static inline void poll_initwait(poll_table* pt)
 {
-	pt->queue = 1;
 	pt->qproc = NULL;
 	pt->priv = NULL;
 	pt->error = 0;
 	pt->table = NULL;
 }
 
-static inline void poll_initwait_ex(poll_table* pt, int queue,
+static inline void poll_initwait_ex(poll_table* pt,
 				    void (*qproc)(void *, wait_queue_head_t *),
 				    void *priv)
 {
-	pt->queue = queue;
 	pt->qproc = qproc;
 	pt->priv = priv;
 	pt->error = 0;
--- 2.5/fs/select.c	2002-11-10 11:54:59.000000000 +0100
+++ build-2.5/fs/select.c	2002-11-10 11:58:24.000000000 +0100
@@ -77,9 +77,6 @@
 {
 	struct poll_table_page *table = p->table;
 
-	if (!p->queue)
-		return;
-
 	if (p->qproc) {
 		p->qproc(p->priv, wait_address);
 		return;
--- 2.5/fs/eventpoll.c	2002-11-10 11:54:59.000000000 +0100
+++ build-2.5/fs/eventpoll.c	2002-11-10 11:57:17.000000000 +0100
@@ -828,7 +828,7 @@
 	}
 
 	/* Attach the item to the poll hooks */
-	poll_initwait_ex(&pt, 1, ep_ptable_queue_proc, dpi);
+	poll_initwait_ex(&pt, ep_ptable_queue_proc, dpi);
 	revents = tfile->f_op->poll(tfile, &pt);
 	poll_freewait(&pt);
 
@@ -854,25 +854,14 @@
 
 
 /*
- * Returns the current events of the given file. It uses the special
- * poll table initialization to avoid any poll queue insertion.
+ * Returns the current events of the given file.
  */
 static unsigned int ep_get_file_events(struct file *file)
 {
 	unsigned int revents;
-	poll_table pt;
 
-	/*
-	 * This is a special poll table initialization that will
-	 * make poll_wait() to not perform any wait queue insertion when
-	 * called by file->f_op->poll(). This is a fast way to retrieve
-	 * file events with perform any queue insertion, hence saving CPU cycles.
-	 */
-	poll_initwait_ex(&pt, 0, NULL, NULL);
-
-	revents = file->f_op->poll(file, &pt);
+	revents = file->f_op->poll(file, NULL);
 
-	poll_freewait(&pt);
 	return revents;
 }
 
@@ -1056,15 +1045,6 @@
 	unsigned long flags;
 	struct list_head *lsthead = &ep->rdllist;
 	struct pollfd eventbuf[EP_EVENT_BUFF_SIZE];
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
 
@@ -1075,7 +1055,7 @@
 		EP_LIST_DEL(&dpi->rdllink);
 
 		/* Fetch event bits from the signaled file */
-		revents = dpi->file->f_op->poll(dpi->file, &pt);
+		revents = dpi->file->f_op->poll(dpi->file, NULL);
 
 		if (revents & dpi->pfd.events) {
 			eventbuf[ebufcnt] = dpi->pfd;
@@ -1091,7 +1071,6 @@
 				write_unlock_irqrestore(&ep->lock, flags);
 				if (__copy_to_user(&events[eventcnt], eventbuf,
 						   ebufcnt * sizeof(struct pollfd))) {
-					poll_freewait(&pt);
 					return -EFAULT;
 				}
 				eventcnt += ebufcnt;
@@ -1111,8 +1090,6 @@
 			eventcnt += ebufcnt;
 	}
 
-	poll_freewait(&pt);
-
 	return eventcnt;
 }
 

--------------050905010103040001020202--


