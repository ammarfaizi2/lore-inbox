Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264853AbSKJMGt>; Sun, 10 Nov 2002 07:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264850AbSKJMGr>; Sun, 10 Nov 2002 07:06:47 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:2722 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S264839AbSKJMGa>;
	Sun, 10 Nov 2002 07:06:30 -0500
Message-ID: <3DCE435D.10604@colorfullife.com>
Date: Sun, 10 Nov 2002 12:30:37 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Davide Libenzi <davidel@xmailserver.org>
Subject: [RFC,PATCH] poll cleanup 2/3
Content-Type: multipart/mixed;
 boundary="------------010601020005090005040509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010601020005090005040509
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Change 2:
split the poll_table structure into 2 parts:
One global part with just a function pointer and a priv variable.
The 2nd part is user specific:
for __pollwait: the poll table and the error variable
for ep_ptable_queue_proc: the pointer to the eventpoll data.

This change is a prerequisite for the next patch, that embedds a few 
waitqueues in the __pollwait specific part of the poll structure.

--
    Manfred

--------------010601020005090005040509
Content-Type: text/plain;
 name="patch-poll-2-funcptr"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-poll-2-funcptr"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 5
//  SUBLEVEL = 46
//  EXTRAVERSION =
--- 2.5/include/linux/poll.h	2002-11-10 12:19:10.000000000 +0100
+++ build-2.5/include/linux/poll.h	2002-11-10 12:18:40.000000000 +0100
@@ -10,44 +10,28 @@
 #include <linux/mm.h>
 #include <asm/uaccess.h>
 
-struct poll_table_page;
+typedef struct poll_table_struct poll_table;
 
-typedef struct poll_table_struct {
+struct poll_table_struct {
+	void (*qproc)(void * priv, struct file * filp, wait_queue_head_t * wait_address);
 	void *priv;
-	void (*qproc)(void *, wait_queue_head_t *);
+};
+
+struct poll_wrapper {
+	poll_table pt;
 	int error;
 	struct poll_table_page * table;
-} poll_table;
+};
 
-extern void __pollwait(struct file * filp, wait_queue_head_t * wait_address, poll_table *p);
+void poll_initwait(struct poll_wrapper* pt);
+void poll_freewait(struct poll_wrapper* pt);
 
 static inline void poll_wait(struct file * filp, wait_queue_head_t * wait_address, poll_table *p)
 {
 	if (p && wait_address)
-		__pollwait(filp, wait_address, p);
+		p->qproc(p->priv, filp, wait_address);
 }
 
-static inline void poll_initwait(poll_table* pt)
-{
-	pt->qproc = NULL;
-	pt->priv = NULL;
-	pt->error = 0;
-	pt->table = NULL;
-}
-
-static inline void poll_initwait_ex(poll_table* pt,
-				    void (*qproc)(void *, wait_queue_head_t *),
-				    void *priv)
-{
-	pt->qproc = qproc;
-	pt->priv = priv;
-	pt->error = 0;
-	pt->table = NULL;
-}
-
-extern void poll_freewait(poll_table* pt);
-
-
 /*
  * Scaleable version of the fd_set.
  */
--- 2.5/fs/select.c	2002-11-10 12:19:10.000000000 +0100
+++ build-2.5/fs/select.c	2002-11-10 12:18:40.000000000 +0100
@@ -54,7 +54,7 @@
  * poll table.
  */
 
-void poll_freewait(poll_table* pt)
+void poll_freewait(struct poll_wrapper* pt)
 {
 	struct poll_table_page * p = pt->table;
 	while (p) {
@@ -73,15 +73,11 @@
 	}
 }
 
-void __pollwait(struct file * filp, wait_queue_head_t * wait_address, poll_table *p)
+static void __pollwait(void *priv, struct file * filp, wait_queue_head_t * wait_address)
 {
+	struct poll_wrapper *p = priv;
 	struct poll_table_page *table = p->table;
 
-	if (p->qproc) {
-		p->qproc(p->priv, wait_address);
-		return;
-	}
-
 	if (!table || POLL_TABLE_FULL(table)) {
 		struct poll_table_page *new_table;
 
@@ -109,6 +105,14 @@
 	}
 }
 
+void poll_initwait(struct poll_wrapper* pt)
+{
+	pt->pt.qproc = __pollwait;
+	pt->pt.priv = pt;
+	pt->error = 0;
+	pt->table = NULL;
+}
+
 #define __IN(fds, n)		(fds->in + n)
 #define __OUT(fds, n)		(fds->out + n)
 #define __EX(fds, n)		(fds->ex + n)
@@ -169,7 +173,8 @@
 
 int do_select(int n, fd_set_bits *fds, long *timeout)
 {
-	poll_table table, *wait;
+	struct poll_wrapper table;
+	poll_table *wait;
 	int retval, i, off;
 	long __timeout = *timeout;
 
@@ -182,7 +187,7 @@
 	n = retval;
 
 	poll_initwait(&table);
-	wait = &table;
+	wait = &table.pt;
 	if (!__timeout)
 		wait = NULL;
 	retval = 0;
@@ -389,10 +394,13 @@
 }
 
 static int do_poll(unsigned int nfds, unsigned int nchunks, unsigned int nleft, 
-	struct pollfd *fds[], poll_table *wait, long timeout)
+	struct pollfd *fds[], struct poll_wrapper *pw, long timeout)
 {
 	int count;
-	poll_table* pt = wait;
+	poll_table* pt = &pw->pt;
+
+	if (!timeout)
+		pt = NULL;
 
 	for (;;) {
 		unsigned int i;
@@ -406,7 +414,7 @@
 		pt = NULL;
 		if (count || !timeout || signal_pending(current))
 			break;
-		count = wait->error;
+		count = pw->error;
 		if (count)
 			break;
 		timeout = schedule_timeout(timeout);
@@ -419,7 +427,7 @@
 {
 	int i, j, fdcount, err;
 	struct pollfd **fds;
-	poll_table table, *wait;
+	struct poll_wrapper table;
 	int nchunks, nleft;
 
 	/* Do a sanity check on nfds ... */
@@ -435,9 +443,6 @@
 	}
 
 	poll_initwait(&table);
-	wait = &table;
-	if (!timeout)
-		wait = NULL;
 
 	err = -ENOMEM;
 	fds = NULL;
@@ -474,7 +479,7 @@
 			goto out_fds1;
 	}
 
-	fdcount = do_poll(nfds, nchunks, nleft, fds, wait, timeout);
+	fdcount = do_poll(nfds, nchunks, nleft, fds, &table, timeout);
 
 	/* OK, now copy the revents fields back to user space. */
 	for(i=0; i < nchunks; i++)
--- 2.5/fs/eventpoll.c	2002-11-10 12:19:10.000000000 +0100
+++ build-2.5/fs/eventpoll.c	2002-11-10 12:18:25.000000000 +0100
@@ -199,7 +199,7 @@
 static struct epitem *ep_find(struct eventpoll *ep, struct file *file);
 static void ep_use_epitem(struct epitem *dpi);
 static void ep_release_epitem(struct epitem *dpi);
-static void ep_ptable_queue_proc(void *priv, wait_queue_head_t *whead);
+static void ep_ptable_queue_proc(void * priv, struct file * filp, wait_queue_head_t * whead);
 static int ep_insert(struct eventpoll *ep, struct pollfd *pfd, struct file *tfile);
 static unsigned int ep_get_file_events(struct file *file);
 static int ep_modify(struct eventpoll *ep, struct epitem *dpi, unsigned int events);
@@ -784,14 +784,19 @@
 		DPI_MEM_FREE(dpi);
 }
 
+struct epoll_wrapper {
+	poll_table pt;
+	struct epitem *dpi;
+};
 
 /*
  * This is the callback that is used to add our wait queue to the
  * target file wakeup lists.
  */
-static void ep_ptable_queue_proc(void *priv, wait_queue_head_t *whead)
+static void ep_ptable_queue_proc(void * priv, struct file * filp, wait_queue_head_t * whead)
 {
-	struct epitem *dpi = priv;
+	struct epoll_wrapper *ew = priv;
+	struct epitem *dpi = ew->dpi;
 
 	/* No more than EP_MAX_POLL_QUEUE wait queue are supported */
 	if (dpi->nwait < EP_MAX_POLL_QUEUE) {
@@ -801,13 +806,20 @@
 	}
 }
 
+static inline void epoll_table_init(struct epoll_wrapper* ew,
+				    struct epitem *dpi)
+{
+	ew->pt.qproc = ep_ptable_queue_proc;
+	ew->pt.priv = ew;
+	ew->dpi = dpi;
+}
 
 static int ep_insert(struct eventpoll *ep, struct pollfd *pfd, struct file *tfile)
 {
 	int error, i, revents;
 	unsigned long flags;
 	struct epitem *dpi;
-	poll_table pt;
+	struct epoll_wrapper ew;
 
 	error = -ENOMEM;
 	if (!(dpi = DPI_MEM_ALLOC()))
@@ -828,9 +840,8 @@
 	}
 
 	/* Attach the item to the poll hooks */
-	poll_initwait_ex(&pt, ep_ptable_queue_proc, dpi);
-	revents = tfile->f_op->poll(tfile, &pt);
-	poll_freewait(&pt);
+	epoll_table_init(&ew, dpi);
+	revents = tfile->f_op->poll(tfile, &ew.pt);
 
 	/* We have to drop the new item inside our item list to keep track of it */
 	write_lock_irqsave(&ep->lock, flags);
@@ -854,7 +865,8 @@
 
 
 /*
- * Returns the current events of the given file.
+ * Returns the current events of the given file. 
+ * poll_table set to NULL to avoid any poll queue insertion.
  */
 static unsigned int ep_get_file_events(struct file *file)
 {
--- 2.5/arch/sparc64/solaris/timod.c	2002-11-10 12:19:10.000000000 +0100
+++ build-2.5/arch/sparc64/solaris/timod.c	2002-11-10 12:15:16.000000000 +0100
@@ -651,10 +651,11 @@
 		SOLD("LISTEN done");
 	}
 	if (!(filp->f_flags & O_NONBLOCK)) {
-		poll_table wait_table, *wait;
+		struct poll_wrapper wait_table;
+		poll_table *wait;
 
 		poll_initwait(&wait_table);
-		wait = &wait_table;
+		wait = &wait_table.pt;
 		for(;;) {
 			SOLD("loop");
 			set_current_state(TASK_INTERRUPTIBLE);
--- 2.5/kernel/ksyms.c	2002-11-10 12:19:10.000000000 +0100
+++ build-2.5/kernel/ksyms.c	2002-11-10 12:15:16.000000000 +0100
@@ -276,7 +276,7 @@
 EXPORT_SYMBOL(generic_file_llseek);
 EXPORT_SYMBOL(remote_llseek);
 EXPORT_SYMBOL(no_llseek);
-EXPORT_SYMBOL(__pollwait);
+EXPORT_SYMBOL(poll_initwait);
 EXPORT_SYMBOL(poll_freewait);
 EXPORT_SYMBOL(ROOT_DEV);
 EXPORT_SYMBOL(find_get_page);

--------------010601020005090005040509--


