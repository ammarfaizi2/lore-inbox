Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751442AbWACQoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbWACQoZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 11:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWACQoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 11:44:25 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:49901 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751442AbWACQoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 11:44:24 -0500
Message-ID: <43BABBB8.402E96A3@tv-sign.ru>
Date: Tue, 03 Jan 2006 21:00:24 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Nicolas Pitre <nico@cam.org>, Jes Sorensen <jes@trained-monkey.org>,
       Al Viro <viro@ftp.linux.org.uk>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 08/19] mutex subsystem, core
References: <20060103100807.GH23289@elte.hu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> mutex implementation, core files: just the basic subsystem, no users of it.
>

(on top of this patch)

'add_to_head' always declared and used along with 'struct waiter'.
I think it is better to hide 'add_to_head' in that struct.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- K/include/linux/mutex.h~1_HEAD	2006-01-03 22:35:10.000000000 +0300
+++ K/include/linux/mutex.h	2006-01-03 23:06:49.000000000 +0300
@@ -61,6 +61,7 @@ struct mutex {
  * which resides on the blocked task's kernel stack:
  */
 struct mutex_waiter {
+	int			add_to_head;
 	struct list_head	list;
 	struct thread_info	*ti;
 #ifdef CONFIG_DEBUG_MUTEXES
--- K/kernel/mutex.c~1_HEAD	2006-01-03 22:35:10.000000000 +0300
+++ K/kernel/mutex.c	2006-01-03 23:36:30.000000000 +0300
@@ -28,13 +28,19 @@
 # include <asm/mutex.h>
 #endif
 
+static inline void mutex_init_waiter(struct mutex_waiter *waiter)
+{
+	/* first time queue the waiter as FIFO: */
+	waiter->add_to_head = 0;
+}
+
 /*
  * Block on a lock - add ourselves to the list of waiters.
  * Called with lock->wait_lock held.
  */
 static inline void
 add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
-	   struct thread_info *ti, int add_to_head __IP_DECL__)
+	   struct thread_info *ti __IP_DECL__)
 {
 	debug_mutex_add_waiter(lock, waiter, ti, ip);
 
@@ -44,10 +50,12 @@ add_waiter(struct mutex *lock, struct mu
 	 * Add waiting tasks to the end of the waitqueue (FIFO),
 	 * but add repeat waiters to the head (LIFO):
 	 */
-	if (add_to_head)
+	if (waiter->add_to_head)
 		list_add(&waiter->list, &lock->wait_list);
 	else
 		list_add_tail(&waiter->list, &lock->wait_list);
+
+	waiter->add_to_head = 1;
 }
 
 /*
@@ -74,8 +82,8 @@ mutex_wakeup_waiter(struct mutex *lock _
  */
 static inline int
 __mutex_lock_common(struct mutex *lock, struct mutex_waiter *waiter,
-		    struct thread_info *ti, unsigned long task_state,
-		    const int add_to_head __IP_DECL__)
+		    struct thread_info *ti, unsigned long task_state
+		    __IP_DECL__)
 {
 	struct task_struct *task = ti->task;
 	unsigned int old_val;
@@ -115,7 +123,7 @@ __mutex_lock_common(struct mutex *lock, 
 		return 1;
 	}
 
-	add_waiter(lock, waiter, ti, add_to_head __IP__);
+	add_waiter(lock, waiter, ti __IP__);
 	__set_task_state(task, task_state);
 
 	/*
@@ -133,19 +141,17 @@ static inline void __mutex_lock_nonatomi
 {
 	struct thread_info *ti = current_thread_info();
 	struct mutex_waiter waiter;
-	/* first time queue the waiter as FIFO: */
-	int add_to_head = 0;
 
 	debug_mutex_init_waiter(&waiter);
 
+	mutex_init_waiter(&waiter);
+
 	spin_lock_mutex(&lock->wait_lock);
 
 	/* releases the internal lock: */
 	while (!__mutex_lock_common(lock, &waiter, ti,
-			TASK_UNINTERRUPTIBLE, add_to_head __IP__)) {
+			TASK_UNINTERRUPTIBLE __IP__)) {
 
-		/* start queueing the waiter as LIFO: */
-		add_to_head = 1;
 		/* wait to be woken up: */
 		schedule();
 
@@ -162,23 +168,23 @@ __mutex_lock_interruptible_nonatomic(str
 {
 	struct thread_info *ti = current_thread_info();
 	struct mutex_waiter waiter;
-	int add_to_head = 0;
 
 	debug_mutex_init_waiter(&waiter);
 
+	mutex_init_waiter(&waiter);
+
 	spin_lock_mutex(&lock->wait_lock);
 
 	for (;;) {
 		/* releases the internal lock: */
 		if (__mutex_lock_common(lock, &waiter, ti,
-				TASK_INTERRUPTIBLE, add_to_head __IP__))
+				TASK_INTERRUPTIBLE __IP__))
 			return 0;
 
 		/* break out on a signal: */
 		if (unlikely(signal_pending(ti->task)))
 			break;
 
-		add_to_head = 1;
 		/* wait to be woken up: */
 		schedule();
