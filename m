Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263098AbVBDRj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263098AbVBDRj2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 12:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265934AbVBDRe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 12:34:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47815 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265822AbVBDRbe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 12:31:34 -0500
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FRV: Semaphore implementation race fix
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Fri, 04 Feb 2005 17:31:26 +0000
Message-ID: <28733.1107538286@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch fixes a race in the FRV arch's semaphore implementation.
The same type of fixes were applied to the rw-semaphore implementations to fix
the same races there.

The race involved the on-stack record linked into the semaphore's queue by the
down() executed by a process now sleeping on the semaphore going away and the
sleeping task going away before the process that woke it up during up()
processing had finished with those structures.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 frv-semaphore-2611rc3.diff 
 arch/frv/kernel/semaphore.c |   26 ++++++++++++++++++++------
 1 files changed, 20 insertions(+), 6 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.11-rc3/arch/frv/kernel/semaphore.c linux-2.6.11-rc3-frv/arch/frv/kernel/semaphore.c
--- /warthog/kernels/linux-2.6.11-rc3/arch/frv/kernel/semaphore.c	2005-02-04 11:49:30.000000000 +0000
+++ linux-2.6.11-rc3-frv/arch/frv/kernel/semaphore.c	2005-02-04 12:34:46.000000000 +0000
@@ -43,17 +43,18 @@ void __down(struct semaphore *sem, unsig
 	struct task_struct *tsk = current;
 	struct sem_waiter waiter;
 
-	semtrace(sem,"Entering __down");
+	semtrace(sem, "Entering __down");
 
 	/* set up my own style of waitqueue */
-	waiter.task	= tsk;
+	waiter.task = tsk;
+	get_task_struct(tsk);
 
 	list_add_tail(&waiter.list, &sem->wait_list);
 
 	/* we don't need to touch the semaphore struct anymore */
 	spin_unlock_irqrestore(&sem->wait_lock, flags);
 
-	/* wait to be given the lock */
+	/* wait to be given the semaphore */
 	set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 
 	for (;;) {
@@ -64,7 +65,7 @@ void __down(struct semaphore *sem, unsig
 	}
 
 	tsk->state = TASK_RUNNING;
-	semtrace(sem,"Leaving __down");
+	semtrace(sem, "Leaving __down");
 }
 
 EXPORT_SYMBOL(__down);
@@ -83,6 +84,7 @@ int __down_interruptible(struct semaphor
 
 	/* set up my own style of waitqueue */
 	waiter.task = tsk;
+	get_task_struct(tsk);
 
 	list_add_tail(&waiter.list, &sem->wait_list);
 
@@ -91,7 +93,7 @@ int __down_interruptible(struct semaphor
 
 	spin_unlock_irqrestore(&sem->wait_lock, flags);
 
-	/* wait to be given the lock */
+	/* wait to be given the semaphore */
 	ret = 0;
 	for (;;) {
 		if (list_empty(&waiter.list))
@@ -116,6 +118,8 @@ int __down_interruptible(struct semaphor
 	}
 
 	spin_unlock_irqrestore(&sem->wait_lock, flags);
+	if (ret == -EINTR)
+		put_task_struct(current);
 	goto out;
 }
 
@@ -127,14 +131,24 @@ EXPORT_SYMBOL(__down_interruptible);
  */
 void __up(struct semaphore *sem)
 {
+	struct task_struct *tsk;
 	struct sem_waiter *waiter;
 
 	semtrace(sem,"Entering __up");
 
 	/* grant the token to the process at the front of the queue */
 	waiter = list_entry(sem->wait_list.next, struct sem_waiter, list);
+
+	/* We must be careful not to touch 'waiter' after we set ->task = NULL.
+	 * It is an allocated on the waiter's stack and may become invalid at
+	 * any time after that point (due to a wakeup from another source).
+	 */
 	list_del_init(&waiter->list);
-	wake_up_process(waiter->task);
+	tsk = waiter->task;
+	mb();
+	waiter->task = NULL;
+	wake_up_process(tsk);
+	put_task_struct(tsk);
 
 	semtrace(sem,"Leaving __up");
 }
