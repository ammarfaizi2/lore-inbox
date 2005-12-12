Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbVLLXsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbVLLXsh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 18:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbVLLXq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 18:46:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38563 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932247AbVLLXqW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 18:46:22 -0500
Date: Mon, 12 Dec 2005 23:45:47 GMT
Message-Id: <200512122345.jBCNjllF009033@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 4/19] MUTEX: FRV arch mutex
In-Reply-To: <dhowells1134431145@warthog.cambridge.redhat.com>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch renames the functions of the FRV traditional semaphore
implementation to include "_sem" in their names and to remove the MUTEX macros
that are now provided by the new mutex facility.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 mutex-frv-2615rc5.diff
 arch/frv/kernel/frv_ksyms.c |    2 +-
 arch/frv/kernel/semaphore.c |   24 ++++++++++++------------
 include/asm-frv/semaphore.h |   35 +++++++++++------------------------
 3 files changed, 24 insertions(+), 37 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/asm-frv/semaphore.h linux-2.6.15-rc5-mutex/include/asm-frv/semaphore.h
--- /warthog/kernels/linux-2.6.15-rc5/include/asm-frv/semaphore.h	2005-12-08 16:23:52.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/asm-frv/semaphore.h	2005-12-12 19:26:43.000000000 +0000
@@ -50,29 +50,16 @@ struct semaphore {
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
-#define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
-#define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
-
 static inline void sema_init (struct semaphore *sem, int val)
 {
 	*sem = (struct semaphore) __SEMAPHORE_INITIALIZER(*sem, val);
 }
 
-static inline void init_MUTEX (struct semaphore *sem)
-{
-	sema_init(sem, 1);
-}
-
-static inline void init_MUTEX_LOCKED (struct semaphore *sem)
-{
-	sema_init(sem, 0);
-}
-
-extern void __down(struct semaphore *sem, unsigned long flags);
-extern int  __down_interruptible(struct semaphore *sem, unsigned long flags);
-extern void __up(struct semaphore *sem);
+extern void __down_sem(struct semaphore *sem, unsigned long flags);
+extern int  __down_sem_interruptible(struct semaphore *sem, unsigned long flags);
+extern void __up_sem(struct semaphore *sem);
 
-static inline void down(struct semaphore *sem)
+static inline void down_sem(struct semaphore *sem)
 {
 	unsigned long flags;
 
@@ -86,11 +73,11 @@ static inline void down(struct semaphore
 		spin_unlock_irqrestore(&sem->wait_lock, flags);
 	}
 	else {
-		__down(sem, flags);
+		__down_sem(sem, flags);
 	}
 }
 
-static inline int down_interruptible(struct semaphore *sem)
+static inline int down_sem_interruptible(struct semaphore *sem)
 {
 	unsigned long flags;
 	int ret = 0;
@@ -105,16 +92,16 @@ static inline int down_interruptible(str
 		spin_unlock_irqrestore(&sem->wait_lock, flags);
 	}
 	else {
-		ret = __down_interruptible(sem, flags);
+		ret = __down_sem_interruptible(sem, flags);
 	}
 	return ret;
 }
 
 /*
- * non-blockingly attempt to down() a semaphore.
+ * non-blockingly attempt to down_sem() a semaphore.
  * - returns zero if we acquired it
  */
-static inline int down_trylock(struct semaphore *sem)
+static inline int down_sem_trylock(struct semaphore *sem)
 {
 	unsigned long flags;
 	int success = 0;
@@ -132,7 +119,7 @@ static inline int down_trylock(struct se
 	return !success;
 }
 
-static inline void up(struct semaphore *sem)
+static inline void up_sem(struct semaphore *sem)
 {
 	unsigned long flags;
 
@@ -142,7 +129,7 @@ static inline void up(struct semaphore *
 
 	spin_lock_irqsave(&sem->wait_lock, flags);
 	if (!list_empty(&sem->wait_list))
-		__up(sem);
+		__up_sem(sem);
 	else
 		sem->counter++;
 	spin_unlock_irqrestore(&sem->wait_lock, flags);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/arch/frv/kernel/frv_ksyms.c linux-2.6.15-rc5-mutex/arch/frv/kernel/frv_ksyms.c
--- /warthog/kernels/linux-2.6.15-rc5/arch/frv/kernel/frv_ksyms.c	2005-11-01 13:18:57.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/frv/kernel/frv_ksyms.c	2005-12-12 22:08:19.000000000 +0000
@@ -13,7 +13,7 @@
 #include <asm/pgalloc.h>
 #include <asm/irq.h>
 #include <asm/io.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/checksum.h>
 #include <asm/hardirq.h>
 #include <asm/current.h>
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/arch/frv/kernel/semaphore.c linux-2.6.15-rc5-mutex/arch/frv/kernel/semaphore.c
--- /warthog/kernels/linux-2.6.15-rc5/arch/frv/kernel/semaphore.c	2005-12-08 16:23:32.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/frv/kernel/semaphore.c	2005-12-12 19:26:25.000000000 +0000
@@ -38,12 +38,12 @@ void semtrace(struct semaphore *sem, con
  * wait for a token to be granted from a semaphore
  * - entered with lock held and interrupts disabled
  */
-void __down(struct semaphore *sem, unsigned long flags)
+void __down_sem(struct semaphore *sem, unsigned long flags)
 {
 	struct task_struct *tsk = current;
 	struct sem_waiter waiter;
 
-	semtrace(sem, "Entering __down");
+	semtrace(sem, "Entering __down_sem");
 
 	/* set up my own style of waitqueue */
 	waiter.task = tsk;
@@ -65,22 +65,22 @@ void __down(struct semaphore *sem, unsig
 	}
 
 	tsk->state = TASK_RUNNING;
-	semtrace(sem, "Leaving __down");
+	semtrace(sem, "Leaving __down_sem");
 }
 
-EXPORT_SYMBOL(__down);
+EXPORT_SYMBOL(__down_sem);
 
 /*
  * interruptibly wait for a token to be granted from a semaphore
  * - entered with lock held and interrupts disabled
  */
-int __down_interruptible(struct semaphore *sem, unsigned long flags)
+int __down_sem_interruptible(struct semaphore *sem, unsigned long flags)
 {
 	struct task_struct *tsk = current;
 	struct sem_waiter waiter;
 	int ret;
 
-	semtrace(sem,"Entering __down_interruptible");
+	semtrace(sem,"Entering __down_sem_interruptible");
 
 	/* set up my own style of waitqueue */
 	waiter.task = tsk;
@@ -106,7 +106,7 @@ int __down_interruptible(struct semaphor
 
  out:
 	tsk->state = TASK_RUNNING;
-	semtrace(sem, "Leaving __down_interruptible");
+	semtrace(sem, "Leaving __down_sem_interruptible");
 	return ret;
 
  interrupted:
@@ -123,18 +123,18 @@ int __down_interruptible(struct semaphor
 	goto out;
 }
 
-EXPORT_SYMBOL(__down_interruptible);
+EXPORT_SYMBOL(__down_sem_interruptible);
 
 /*
  * release a single token back to a semaphore
  * - entered with lock held and interrupts disabled
  */
-void __up(struct semaphore *sem)
+void __up_sem(struct semaphore *sem)
 {
 	struct task_struct *tsk;
 	struct sem_waiter *waiter;
 
-	semtrace(sem,"Entering __up");
+	semtrace(sem,"Entering __up_sem");
 
 	/* grant the token to the process at the front of the queue */
 	waiter = list_entry(sem->wait_list.next, struct sem_waiter, list);
@@ -150,7 +150,7 @@ void __up(struct semaphore *sem)
 	wake_up_process(tsk);
 	put_task_struct(tsk);
 
-	semtrace(sem,"Leaving __up");
+	semtrace(sem,"Leaving __up_sem");
 }
 
-EXPORT_SYMBOL(__up);
+EXPORT_SYMBOL(__up_sem);
