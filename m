Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbTKIJAf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 04:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbTKIJAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 04:00:35 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:30399 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262225AbTKIJAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 04:00:30 -0500
Message-ID: <3FAE0223.7070402@colorfullife.com>
Date: Sun, 09 Nov 2003 10:00:19 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: prepare_wait / finish_wait question
Content-Type: multipart/mixed;
 boundary="------------020404070006040900030103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020404070006040900030103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ingo,

sysv semaphores show the same problem you've fixed for wait queue with 
finish_wait:
one thread wakes up a blocked thread and must hold a spinlock for the 
wakeup. The blocked thread immediately tries to acquire that spinlock, 
because it must figure out what happened. Result: noticable cache line 
trashing on an 4xXeon with postgres.
autoremove_wake_function first calls wake_up, then list_del_init. Did 
you test that the woken up thread is not too fast and acquires the 
spinlock before list_del_init had a chance to reset the list?
I wrote a patch for sysv sem and on a 4x Pentium 3, 99.9% of the calls 
hit the fast path, but I'm a bit afraid that monitor/mwait could be so 
fast that the fast path is not chosen.

I'm thinking about a two-stage algorithm - what's your opinion?

--
    Manfred
P.S.: the patch to slab.c is intentional - or is there a better approach 
to export random stuff from an stp run?


--------------020404070006040900030103
Content-Type: text/plain;
 name="patch-stat"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-stat"

--- 2.6/ipc/sem.c	2003-09-30 19:42:29.000000000 +0200
+++ build-2.6/ipc/sem.c	2003-11-09 09:33:45.000000000 +0100
@@ -59,6 +59,8 @@
  * (c) 1999 Manfred Spraul <manfreds@colorfullife.com>
  * Enforced range limit on SEM_UNDO
  * (c) 2001 Red Hat Inc <alan@redhat.com>
+ * Lockless wakeup
+ * (c) 2003 Manfred Spraul <manfred@colorfullife.com>
  */
 
 #include <linux/config.h>
@@ -118,6 +120,40 @@
 #endif
 }
 
+/*
+ * Lockless wakeup algorithm:
+ * Without the check/retry algorithm a lockless wakeup is possible:
+ * - queue.status is initialized to -EINTR before blocking.
+ * - wakeup is performed by
+ *	* unlinking the queue entry from sma->sem_pending
+ *	* setting queue.status to IN_WAKEUP
+ *	  This is the notification for the blocked thread that a
+ *	  result value is imminent.
+ *	* call wake_up_process
+ *	* set queue.status to the final value.
+ * - the previously blocked thread checks queue.status:
+ *   	* if it's IN_WAKEUP, then it must wait until the value changes
+ *   	* if it's not -EINTR, then the operation was completed by
+ *   	  update_queue. semtimedop can return queue.status without
+ *   	  performing any operation on the semaphore array.
+ *   	* otherwise it must acquire the spinlock and check what's up.
+ *
+ * The two-stage algorithm is necessary to protect against the following
+ * races:
+ * - if queue.status is set after wake_up_process, then the woken up idle
+ *   thread could race forward and try (and fail) to acquire sma->lock
+ *   before update_queue had a chance to set queue.status
+ * - if queue.status is written before wake_up_process and if the
+ *   blocked process is woken up by a signal between writing
+ *   queue.status and the wake_up_process, then the woken up
+ *   process could return from semtimedop and die by calling
+ *   sys_exit before wake_up_process is called. Then wake_up_process
+ *   will oops, because the task structure is already invalid.
+ *   (yes, this happened on s390 with sysv msg).
+ *
+ */
+#define IN_WAKEUP	1
+
 static int newary (key_t key, int nsems, int semflg)
 {
 	int id;
@@ -331,16 +367,25 @@
 	int error;
 	struct sem_queue * q;
 
-	for (q = sma->sem_pending; q; q = q->next) {
-			
+	q = sma->sem_pending;
+	while(q) {
 		error = try_atomic_semop(sma, q->sops, q->nsops,
 					 q->undo, q->pid);
 
 		/* Does q->sleeper still need to sleep? */
 		if (error <= 0) {
-			q->status = error;
+			struct sem_queue *n;
 			remove_from_queue(sma,q);
+			n = q->next;
+			q->status = IN_WAKEUP;
 			wake_up_process(q->sleeper);
+			/* hands-off: q will disappear immediately after
+			 * writing q->status.
+			 */
+			q->status = error;
+			q = n;
+		} else {
+			q = q->next;
 		}
 	}
 }
@@ -409,10 +454,16 @@
 		un->semid = -1;
 
 	/* Wake up all pending processes and let them fail with EIDRM. */
-	for (q = sma->sem_pending; q; q = q->next) {
-		q->status = -EIDRM;
+	q = sma->sem_pending;
+	while(q) {
+		struct sem_queue *n;
+		/* lazy remove_from_queue: we are killing the whole queue */
 		q->prev = NULL;
+		n = q->next;
+		q->status = IN_WAKEUP;
 		wake_up_process(q->sleeper); /* doesn't sleep */
+		q->status = -EIDRM;	/* hands-off q */
+		q = n;
 	}
 
 	/* Remove the semaphore set from the ID array*/
@@ -965,6 +1016,9 @@
 	return sys_semtimedop(semid, tsops, nsops, NULL);
 }
 
+atomic_t fast_path = ATOMIC_INIT(0);
+atomic_t slow_path = ATOMIC_INIT(0);
+
 asmlinkage long sys_semtimedop(int semid, struct sembuf __user *tsops,
 			unsigned nsops, const struct timespec __user *timeout)
 {
@@ -1083,6 +1137,19 @@
 	else
 		schedule();
 
+	error = queue.status;
+	while(unlikely(error == IN_WAKEUP)) {
+		cpu_relax();
+		error = queue.status;
+	}
+
+	if (error != -EINTR) {
+		/* fast path: update_queue already obtained all requested
+		 * resources */
+atomic_inc(&fast_path);
+		goto out_free;
+	}
+
 	sma = sem_lock(semid);
 	if(sma==NULL) {
 		if(queue.prev != NULL)
@@ -1095,7 +1162,8 @@
 	 * If queue.status != -EINTR we are woken up by another process
 	 */
 	error = queue.status;
-	if (queue.status != -EINTR) {
+	if (error != -EINTR) {
+atomic_inc(&slow_path);
 		goto out_unlock_free;
 	}
 
--- 2.6/mm/slab.c	2003-10-25 22:51:37.000000000 +0200
+++ build-2.6/mm/slab.c	2003-11-08 18:56:29.000000000 +0100
@@ -2527,6 +2527,8 @@
 
 #ifdef CONFIG_PROC_FS
 
+extern atomic_t fast_path;
+extern atomic_t slow_path;
 static void *s_start(struct seq_file *m, loff_t *pos)
 {
 	loff_t n = *pos;
@@ -2538,6 +2540,8 @@
 		 * Output format version, so at least we can change it
 		 * without _too_ many complaints.
 		 */
+		seq_printf(m, "fast path %d slow path %d\n", atomic_read(&fast_path), atomic_read(&slow_path));
+
 #if STATS
 		seq_puts(m, "slabinfo - version: 2.0 (statistics)\n");
 #else

--------------020404070006040900030103--

