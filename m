Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264462AbTDXE7c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 00:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264464AbTDXE7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 00:59:31 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:47351 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264462AbTDXE7X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 00:59:23 -0400
Date: Thu, 24 Apr 2003 10:46:25 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: bcrl@redhat.com, akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-aio@kvack.org,
       linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/7] Filesystem AIO rdwr - async down (x86)
Message-ID: <20030424104625.D2288@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20030424102221.A2166@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030424102221.A2166@in.ibm.com>; from suparna@in.ibm.com on Thu, Apr 24, 2003 at 10:22:22AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 10:22:22AM +0530, Suparna Bhattacharya wrote:
> Here is a revised version of the filesystem AIO patches
> for 2.5.68.
> 
> 04down_wq-86.patch 	: An asynchronous semaphore down
> 		     	implementation (currently x86 
> 			only)

The semaphore wait seems to be embedded deep in arch 
specific code (am not sure that really needed to be
arch specific, though the asm wrappers would have still
been needed for every arch). 

So I've done this for x86 only at present. Need to
extend this to other archs (if we see good performance 
gains) for put in compat definitions to avoid breaking 
any arch.

04aiodown_wq-x86.patch
......................
 arch/i386/kernel/i386_ksyms.c |    2 +-
 arch/i386/kernel/semaphore.c  |   30 ++++++++++++++++++++----------
 include/asm-i386/semaphore.h  |   27 ++++++++++++++++++---------
 3 files changed, 39 insertions(+), 20 deletions(-)


diff -ur -X /home/kiran/dontdiff linux-2.5.68/arch/i386/kernel/i386_ksyms.c linux-aio-2568/arch/i386/kernel/i386_ksyms.c
--- linux-2.5.68/arch/i386/kernel/i386_ksyms.c	Mon Apr 21 23:30:26 2003
+++ linux-aio-2568/arch/i386/kernel/i386_ksyms.c	Mon Apr 21 17:26:55 2003
@@ -98,7 +98,7 @@
 EXPORT_SYMBOL(__io_virt_debug);
 #endif
 
-EXPORT_SYMBOL_NOVERS(__down_failed);
+EXPORT_SYMBOL_NOVERS(__down_failed_wq);
 EXPORT_SYMBOL_NOVERS(__down_failed_interruptible);
 EXPORT_SYMBOL_NOVERS(__down_failed_trylock);
 EXPORT_SYMBOL_NOVERS(__up_wakeup);
diff -ur -X /home/kiran/dontdiff linux-2.5.68/arch/i386/kernel/semaphore.c linux-aio-2568/arch/i386/kernel/semaphore.c
--- linux-2.5.68/arch/i386/kernel/semaphore.c	Tue Mar 25 03:30:20 2003
+++ linux-aio-2568/arch/i386/kernel/semaphore.c	Tue Apr 22 01:29:29 2003
@@ -15,6 +15,7 @@
 #include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/err.h>
+#include <linux/errno.h>
 #include <asm/semaphore.h>
 
 /*
@@ -53,15 +54,20 @@
 	wake_up(&sem->wait);
 }
 
-void __down(struct semaphore * sem)
+int __down_wq(struct semaphore * sem, wait_queue_t *wait)
 {
 	struct task_struct *tsk = current;
-	DECLARE_WAITQUEUE(wait, tsk);
+	DECLARE_WAITQUEUE(local_wait, tsk);
 	unsigned long flags;
 
-	tsk->state = TASK_UNINTERRUPTIBLE;
+	if (is_sync_wait(wait))
+		tsk->state = TASK_UNINTERRUPTIBLE;
+	if (!wait) {
+		wait = &local_wait;
+	}
+
 	spin_lock_irqsave(&sem->wait.lock, flags);
-	add_wait_queue_exclusive_locked(&sem->wait, &wait);
+	add_wait_queue_exclusive_locked(&sem->wait, wait);
 
 	sem->sleepers++;
 	for (;;) {
@@ -79,17 +85,23 @@
 		sem->sleepers = 1;	/* us - see -1 above */
 		spin_unlock_irqrestore(&sem->wait.lock, flags);
 
+		if (!is_sync_wait(wait))
+			return -EIOCBRETRY;
+
 		schedule();
 
 		spin_lock_irqsave(&sem->wait.lock, flags);
 		tsk->state = TASK_UNINTERRUPTIBLE;
 	}
-	remove_wait_queue_locked(&sem->wait, &wait);
+	if (is_sync_wait(wait) || !list_empty(&wait->task_list))
+		remove_wait_queue_locked(&sem->wait, wait);
 	wake_up_locked(&sem->wait);
 	spin_unlock_irqrestore(&sem->wait.lock, flags);
 	tsk->state = TASK_RUNNING;
+	return 0;
 }
 
+
 int __down_interruptible(struct semaphore * sem)
 {
 	int retval = 0;
@@ -189,19 +201,17 @@
 asm(
 ".text\n"
 ".align 4\n"
-".globl __down_failed\n"
-"__down_failed:\n\t"
+".globl __down_failed_wq\n"
+"__down_failed_wq:\n\t"
 #if defined(CONFIG_FRAME_POINTER)
 	"pushl %ebp\n\t"
 	"movl  %esp,%ebp\n\t"
 #endif
-	"pushl %eax\n\t"
 	"pushl %edx\n\t"
 	"pushl %ecx\n\t"
-	"call __down\n\t"
+	"call __down_wq\n\t"
 	"popl %ecx\n\t"
 	"popl %edx\n\t"
-	"popl %eax\n\t"
 #if defined(CONFIG_FRAME_POINTER)
 	"movl %ebp,%esp\n\t"
 	"popl %ebp\n\t"
diff -ur -X /home/kiran/dontdiff linux-2.5.68/include/asm-i386/semaphore.h linux-aio-2568/include/asm-i386/semaphore.h
--- linux-2.5.68/include/asm-i386/semaphore.h	Tue Mar 25 03:30:11 2003
+++ linux-aio-2568/include/asm-i386/semaphore.h	Wed Apr 16 17:57:05 2003
@@ -96,39 +96,48 @@
 	sema_init(sem, 0);
 }
 
-asmlinkage void __down_failed(void /* special register calling convention */);
+asmlinkage int __down_failed_wq(void /* special register calling convention */);
 asmlinkage int  __down_failed_interruptible(void  /* params in registers */);
 asmlinkage int  __down_failed_trylock(void  /* params in registers */);
 asmlinkage void __up_wakeup(void /* special register calling convention */);
 
-asmlinkage void __down(struct semaphore * sem);
+asmlinkage int __down_wq(struct semaphore * sem, wait_queue_t *wait);
 asmlinkage int  __down_interruptible(struct semaphore * sem);
 asmlinkage int  __down_trylock(struct semaphore * sem);
 asmlinkage void __up(struct semaphore * sem);
 
 /*
  * This is ugly, but we want the default case to fall through.
- * "__down_failed" is a special asm handler that calls the C
+ * "__down_failed_wq" is a special asm handler that calls the C
  * routine that actually waits. See arch/i386/kernel/semaphore.c
  */
-static inline void down(struct semaphore * sem)
+static inline int down_wq(struct semaphore * sem, wait_queue_t *wait)
 {
+	int result;
+
 #ifdef WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
 	might_sleep();
 	__asm__ __volatile__(
 		"# atomic down operation\n\t"
-		LOCK "decl %0\n\t"     /* --sem->count */
-		"js 2f\n"
+		LOCK "decl %1\n\t"     /* --sem->count */
+		"js 2f\n\t"
+		"xorl %0,%0\n"
 		"1:\n"
 		LOCK_SECTION_START("")
-		"2:\tcall __down_failed\n\t"
+		"2:\tcall __down_failed_wq\n\t"
 		"jmp 1b\n"
 		LOCK_SECTION_END
-		:"=m" (sem->count)
-		:"c" (sem)
+		:"=a" (result), "=m" (sem->count)
+		:"c" (sem), "d" (wait)
 		:"memory");
+	return result;
+}
+
+static inline void down(struct semaphore * sem)
+{
+	down_wq(sem, NULL);	
 }
 
 /*

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

