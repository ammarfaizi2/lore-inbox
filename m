Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVCIMNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVCIMNi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 07:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVCIMNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 07:13:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17063 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261264AbVCIMNN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 07:13:13 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050309032832.159e58a4.akpm@osdl.org> 
References: <20050309032832.159e58a4.akpm@osdl.org>  <20050308170107.231a145c.akpm@osdl.org> <1110327267.24286.139.camel@dyn318077bld.beaverton.ibm.com> <18744.1110364438@redhat.com> <20050309110404.GA4088@in.ibm.com> <1110366469.6280.84.camel@laptopd505.fenrus.org> 
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, suparna@in.ibm.com,
       pbadari@us.ibm.com, linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rwsem: Make rwsems use interrupt disabling spinlocks
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Wed, 09 Mar 2005 12:12:23 +0000
Message-ID: <4175.1110370343@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch makes read/write semaphores use interrupt disabling
spinlocks, thus rendering the up functions and trylock functions available for
use in interrupt context.

I've assumed that the normal down functions must be called with interrupts
enabled (since they might schedule), and used the irq-disabling spinlock
variants that don't save the flags.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 rwsem-irqspin-2611mm2.diff
 lib/rwsem-spinlock.c |   42 ++++++++++++++++++++++++++----------------
 lib/rwsem.c          |   16 ++++++++++------
 2 files changed, 36 insertions(+), 22 deletions(-)

diff -uNrp linux-2.6.11-mm2/lib/rwsem.c linux-2.6.11-mm2-rwsem/lib/rwsem.c
--- linux-2.6.11-mm2/lib/rwsem.c	2004-10-19 10:42:19.000000000 +0100
+++ linux-2.6.11-mm2-rwsem/lib/rwsem.c	2005-03-09 10:45:16.000000000 +0000
@@ -150,7 +150,7 @@ rwsem_down_failed_common(struct rw_semap
 	set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 
 	/* set up my own style of waitqueue */
-	spin_lock(&sem->wait_lock);
+	spin_lock_irq(&sem->wait_lock);
 	waiter->task = tsk;
 	get_task_struct(tsk);
 
@@ -163,7 +163,7 @@ rwsem_down_failed_common(struct rw_semap
 	if (!(count & RWSEM_ACTIVE_MASK))
 		sem = __rwsem_do_wake(sem, 0);
 
-	spin_unlock(&sem->wait_lock);
+	spin_unlock_irq(&sem->wait_lock);
 
 	/* wait to be given the lock */
 	for (;;) {
@@ -219,15 +219,17 @@ rwsem_down_write_failed(struct rw_semaph
  */
 struct rw_semaphore fastcall *rwsem_wake(struct rw_semaphore *sem)
 {
+	unsigned long flags;
+
 	rwsemtrace(sem, "Entering rwsem_wake");
 
-	spin_lock(&sem->wait_lock);
+	spin_lock_irqsave(&sem->wait_lock, flags);
 
 	/* do nothing if list empty */
 	if (!list_empty(&sem->wait_list))
 		sem = __rwsem_do_wake(sem, 0);
 
-	spin_unlock(&sem->wait_lock);
+	spin_unlock_irqrestore(&sem->wait_lock, flags);
 
 	rwsemtrace(sem, "Leaving rwsem_wake");
 
@@ -241,15 +243,17 @@ struct rw_semaphore fastcall *rwsem_wake
  */
 struct rw_semaphore fastcall *rwsem_downgrade_wake(struct rw_semaphore *sem)
 {
+	unsigned long flags;
+
 	rwsemtrace(sem, "Entering rwsem_downgrade_wake");
 
-	spin_lock(&sem->wait_lock);
+	spin_lock_irqsave(&sem->wait_lock, flags);
 
 	/* do nothing if list empty */
 	if (!list_empty(&sem->wait_list))
 		sem = __rwsem_do_wake(sem, 1);
 
-	spin_unlock(&sem->wait_lock);
+	spin_unlock_irqrestore(&sem->wait_lock, flags);
 
 	rwsemtrace(sem, "Leaving rwsem_downgrade_wake");
 	return sem;
diff -uNrp linux-2.6.11-mm2/lib/rwsem-spinlock.c linux-2.6.11-mm2-rwsem/lib/rwsem-spinlock.c
--- linux-2.6.11-mm2/lib/rwsem-spinlock.c	2004-09-16 12:06:23.000000000 +0100
+++ linux-2.6.11-mm2-rwsem/lib/rwsem-spinlock.c	2005-03-09 10:43:47.000000000 +0000
@@ -140,12 +140,12 @@ void fastcall __sched __down_read(struct
 
 	rwsemtrace(sem, "Entering __down_read");
 
-	spin_lock(&sem->wait_lock);
+	spin_lock_irq(&sem->wait_lock);
 
 	if (sem->activity >= 0 && list_empty(&sem->wait_list)) {
 		/* granted */
 		sem->activity++;
-		spin_unlock(&sem->wait_lock);
+		spin_unlock_irq(&sem->wait_lock);
 		goto out;
 	}
 
@@ -160,7 +160,7 @@ void fastcall __sched __down_read(struct
 	list_add_tail(&waiter.list, &sem->wait_list);
 
 	/* we don't need to touch the semaphore struct anymore */
-	spin_unlock(&sem->wait_lock);
+	spin_unlock_irq(&sem->wait_lock);
 
 	/* wait to be given the lock */
 	for (;;) {
@@ -181,10 +181,12 @@ void fastcall __sched __down_read(struct
  */
 int fastcall __down_read_trylock(struct rw_semaphore *sem)
 {
+	unsigned long flags;
 	int ret = 0;
+
 	rwsemtrace(sem, "Entering __down_read_trylock");
 
-	spin_lock(&sem->wait_lock);
+	spin_lock_irqsave(&sem->wait_lock, flags);
 
 	if (sem->activity >= 0 && list_empty(&sem->wait_list)) {
 		/* granted */
@@ -192,7 +194,7 @@ int fastcall __down_read_trylock(struct 
 		ret = 1;
 	}
 
-	spin_unlock(&sem->wait_lock);
+	spin_unlock_irqrestore(&sem->wait_lock, flags);
 
 	rwsemtrace(sem, "Leaving __down_read_trylock");
 	return ret;
@@ -209,12 +211,12 @@ void fastcall __sched __down_write(struc
 
 	rwsemtrace(sem, "Entering __down_write");
 
-	spin_lock(&sem->wait_lock);
+	spin_lock_irq(&sem->wait_lock);
 
 	if (sem->activity == 0 && list_empty(&sem->wait_list)) {
 		/* granted */
 		sem->activity = -1;
-		spin_unlock(&sem->wait_lock);
+		spin_unlock_irq(&sem->wait_lock);
 		goto out;
 	}
 
@@ -229,7 +231,7 @@ void fastcall __sched __down_write(struc
 	list_add_tail(&waiter.list, &sem->wait_list);
 
 	/* we don't need to touch the semaphore struct anymore */
-	spin_unlock(&sem->wait_lock);
+	spin_unlock_irq(&sem->wait_lock);
 
 	/* wait to be given the lock */
 	for (;;) {
@@ -250,10 +252,12 @@ void fastcall __sched __down_write(struc
  */
 int fastcall __down_write_trylock(struct rw_semaphore *sem)
 {
+	unsigned long flags;
 	int ret = 0;
+
 	rwsemtrace(sem, "Entering __down_write_trylock");
 
-	spin_lock(&sem->wait_lock);
+	spin_lock_irqsave(&sem->wait_lock, flags);
 
 	if (sem->activity == 0 && list_empty(&sem->wait_list)) {
 		/* granted */
@@ -261,7 +265,7 @@ int fastcall __down_write_trylock(struct
 		ret = 1;
 	}
 
-	spin_unlock(&sem->wait_lock);
+	spin_unlock_irqrestore(&sem->wait_lock, flags);
 
 	rwsemtrace(sem, "Leaving __down_write_trylock");
 	return ret;
@@ -272,14 +276,16 @@ int fastcall __down_write_trylock(struct
  */
 void fastcall __up_read(struct rw_semaphore *sem)
 {
+	unsigned long flags;
+
 	rwsemtrace(sem, "Entering __up_read");
 
-	spin_lock(&sem->wait_lock);
+	spin_lock_irqsave(&sem->wait_lock, flags);
 
 	if (--sem->activity == 0 && !list_empty(&sem->wait_list))
 		sem = __rwsem_wake_one_writer(sem);
 
-	spin_unlock(&sem->wait_lock);
+	spin_unlock_irqrestore(&sem->wait_lock, flags);
 
 	rwsemtrace(sem, "Leaving __up_read");
 }
@@ -289,15 +295,17 @@ void fastcall __up_read(struct rw_semaph
  */
 void fastcall __up_write(struct rw_semaphore *sem)
 {
+	unsigned long flags;
+
 	rwsemtrace(sem, "Entering __up_write");
 
-	spin_lock(&sem->wait_lock);
+	spin_lock_irqsave(&sem->wait_lock, flags);
 
 	sem->activity = 0;
 	if (!list_empty(&sem->wait_list))
 		sem = __rwsem_do_wake(sem, 1);
 
-	spin_unlock(&sem->wait_lock);
+	spin_unlock_irqrestore(&sem->wait_lock, flags);
 
 	rwsemtrace(sem, "Leaving __up_write");
 }
@@ -308,15 +316,17 @@ void fastcall __up_write(struct rw_semap
  */
 void fastcall __downgrade_write(struct rw_semaphore *sem)
 {
+	unsigned long flags;
+
 	rwsemtrace(sem, "Entering __downgrade_write");
 
-	spin_lock(&sem->wait_lock);
+	spin_lock_irqsave(&sem->wait_lock, flags);
 
 	sem->activity = 1;
 	if (!list_empty(&sem->wait_list))
 		sem = __rwsem_do_wake(sem, 0);
 
-	spin_unlock(&sem->wait_lock);
+	spin_unlock_irqrestore(&sem->wait_lock, flags);
 
 	rwsemtrace(sem, "Leaving __downgrade_write");
 }
