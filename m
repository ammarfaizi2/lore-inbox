Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbVDEQ7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbVDEQ7t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 12:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbVDEQuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 12:50:11 -0400
Received: from mail.kroah.org ([69.55.234.183]:61849 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261815AbVDEQsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 12:48:38 -0400
Date: Tue, 5 Apr 2005 09:47:43 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: dhowells@redhat.com, pbadari@us.ibm.com
Subject: [06/08] rwsem fix
Message-ID: <20050405164743.GG17299@kroah.com>
References: <20050405164539.GA17299@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405164539.GA17299@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

We should merge this backport - it's needed to prevent deadlocks when
dio_complete() does up_read() from IRQ context.  And perhaps other places.

From: David Howells <dhowells@redhat.com>

[PATCH] rwsem: Make rwsems use interrupt disabling spinlocks

The attached patch makes read/write semaphores use interrupt disabling
spinlocks in the slow path, thus rendering the up functions and trylock
functions available for use in interrupt context.  This matches the
regular semaphore behaviour.

I've assumed that the normal down functions must be called with interrupts
enabled (since they might schedule), and used the irq-disabling spinlock
variants that don't save the flags.

Signed-Off-By: David Howells <dhowells@redhat.com>
Tested-by: Badari Pulavarty <pbadari@us.ibm.com>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff -Nru a/lib/rwsem-spinlock.c b/lib/rwsem-spinlock.c
--- a/lib/rwsem-spinlock.c	2005-04-01 23:22:40 -08:00
+++ b/lib/rwsem-spinlock.c	2005-04-01 23:22:40 -08:00
@@ -140,12 +140,12 @@
 
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
 
@@ -160,7 +160,7 @@
 	list_add_tail(&waiter.list, &sem->wait_list);
 
 	/* we don't need to touch the semaphore struct anymore */
-	spin_unlock(&sem->wait_lock);
+	spin_unlock_irq(&sem->wait_lock);
 
 	/* wait to be given the lock */
 	for (;;) {
@@ -181,10 +181,12 @@
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
@@ -192,7 +194,7 @@
 		ret = 1;
 	}
 
-	spin_unlock(&sem->wait_lock);
+	spin_unlock_irqrestore(&sem->wait_lock, flags);
 
 	rwsemtrace(sem, "Leaving __down_read_trylock");
 	return ret;
@@ -209,12 +211,12 @@
 
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
 
@@ -229,7 +231,7 @@
 	list_add_tail(&waiter.list, &sem->wait_list);
 
 	/* we don't need to touch the semaphore struct anymore */
-	spin_unlock(&sem->wait_lock);
+	spin_unlock_irq(&sem->wait_lock);
 
 	/* wait to be given the lock */
 	for (;;) {
@@ -250,10 +252,12 @@
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
@@ -261,7 +265,7 @@
 		ret = 1;
 	}
 
-	spin_unlock(&sem->wait_lock);
+	spin_unlock_irqrestore(&sem->wait_lock, flags);
 
 	rwsemtrace(sem, "Leaving __down_write_trylock");
 	return ret;
@@ -272,14 +276,16 @@
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
@@ -289,15 +295,17 @@
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
@@ -308,15 +316,17 @@
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
diff -Nru a/lib/rwsem.c b/lib/rwsem.c
--- a/lib/rwsem.c	2005-04-01 23:22:40 -08:00
+++ b/lib/rwsem.c	2005-04-01 23:22:40 -08:00
@@ -150,7 +150,7 @@
 	set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 
 	/* set up my own style of waitqueue */
-	spin_lock(&sem->wait_lock);
+	spin_lock_irq(&sem->wait_lock);
 	waiter->task = tsk;
 	get_task_struct(tsk);
 
@@ -163,7 +163,7 @@
 	if (!(count & RWSEM_ACTIVE_MASK))
 		sem = __rwsem_do_wake(sem, 0);
 
-	spin_unlock(&sem->wait_lock);
+	spin_unlock_irq(&sem->wait_lock);
 
 	/* wait to be given the lock */
 	for (;;) {
@@ -219,15 +219,17 @@
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
 
@@ -241,15 +243,17 @@
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

