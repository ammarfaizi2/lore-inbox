Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbUCLTw2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 14:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262485AbUCLTvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 14:51:10 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:20740 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262461AbUCLTqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 14:46:53 -0500
Date: Fri, 12 Mar 2004 22:46:49 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Marc Giger <gigerstyle@gmx.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4 on Alpha uninterruptible sleep of processes
Message-ID: <20040312224649.A750@den.park.msu.ru>
References: <20040312154613.7567adab@hdg.gigerstyle.ch> <20040312182754.A680@jurassic.park.msu.ru> <20040312184115.B680@jurassic.park.msu.ru> <20040312165907.626d4a08@hdg.gigerstyle.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040312165907.626d4a08@hdg.gigerstyle.ch>; from gigerstyle@gmx.ch on Fri, Mar 12, 2004 at 04:59:07PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 04:59:07PM +0100, Marc Giger wrote:
> Too late. Already applied, compiled and booted. Read your message and
> rebooted to 2.4:-)

Well, you can try the appended patch to see whether it's
a semaphore problem or not.
BTW, what alpha system do you have?

> Why is there no option to compile a preemptive kernel? Not possible on
> alpha or nobody interested to code or...?

The answer is here:
http://bugzilla.kernel.org/show_bug.cgi?id=397

> In 2.4.23 /prc/meminfo shows always 
> 
> Buffers:             0 kB
> 
> Is it normal on alpha? 2.6.4 showed a value > 0

No idea. In 2.4.25 I have a non-zero value as well:
Buffers:          7288 kB

Ivan.

--- 2.6.4/include/asm-alpha/semaphore.h	Thu Mar 11 05:55:43 2004
+++ linux/include/asm-alpha/semaphore.h	Fri Mar 12 22:43:04 2004
@@ -16,7 +16,10 @@
 #include <linux/rwsem.h>
 
 struct semaphore {
-	atomic_t count;
+	/* Careful, inline assembly knows about the position of these two.  */
+	atomic_t count __attribute__((aligned(8)));
+	atomic_t waking;		/* biased by -1 */
+
 	wait_queue_head_t wait;
 #if WAITQUEUE_DEBUG
 	long __magic;
@@ -30,18 +33,18 @@ struct semaphore {
 #endif
 
 #define __SEMAPHORE_INITIALIZER(name,count)		\
-	{ ATOMIC_INIT(count),				\
+	{ ATOMIC_INIT(count), ATOMIC_INIT(-1),		\
 	  __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 	  __SEM_DEBUG_INIT(name) }
 
-#define __MUTEX_INITIALIZER(name)			\
+#define __MUTEX_INITIALIZER(name) \
 	__SEMAPHORE_INITIALIZER(name,1)
 
-#define __DECLARE_SEMAPHORE_GENERIC(name,count)		\
+#define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
-#define DECLARE_MUTEX(name)		__DECLARE_SEMAPHORE_GENERIC(name,1)
-#define DECLARE_MUTEX_LOCKED(name)	__DECLARE_SEMAPHORE_GENERIC(name,0)
+#define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
+#define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
 
 static inline void sema_init(struct semaphore *sem, int val)
 {
@@ -52,6 +55,7 @@ static inline void sema_init(struct sema
 	 */
 
 	atomic_set(&sem->count, val);
+	atomic_set(&sem->waking, -1);
 	init_waitqueue_head(&sem->wait);
 #if WAITQUEUE_DEBUG
 	sem->__magic = (long)&sem->__magic;
@@ -103,42 +107,102 @@ static inline int __down_interruptible(s
 
 /*
  * down_trylock returns 0 on success, 1 if we failed to get the lock.
+ *
+ * We must manipulate count and waking simultaneously and atomically.
+ * Do this by using ll/sc on the pair of 32-bit words.
  */
 
-static inline int __down_trylock(struct semaphore *sem)
+static inline int __down_trylock(struct semaphore * sem)
 {
-	long ret;
+	long ret, tmp, tmp2, sub;
 
-	/* "Equivalent" C:
+	/* "Equivalent" C.  Note that we have to do this all without
+	   (taken) branches in order to be a valid ll/sc sequence.
 
 	   do {
-		ret = ldl_l;
-		--ret;
-		if (ret < 0)
-			break;
-		ret = stl_c = ret;
-	   } while (ret == 0);
+		tmp = ldq_l;
+		sub = 0x0000000100000000;	
+		ret = ((int)tmp <= 0);		// count <= 0 ?
+		// Note that if count=0, the decrement overflows into
+		// waking, so cancel the 1 loaded above.  Also cancel
+		// it if the lock was already free.
+		if ((int)tmp >= 0) sub = 0;	// count >= 0 ?
+		ret &= ((long)tmp < 0);		// waking < 0 ?
+		sub += 1;
+		if (ret) break;	
+		tmp -= sub;
+		tmp = stq_c = tmp;
+	   } while (tmp == 0);
 	*/
+
 	__asm__ __volatile__(
-		"1:	ldl_l	%0,%1\n"
-		"	subl	%0,1,%0\n"
-		"	blt	%0,2f\n"
-		"	stl_c	%0,%1\n"
-		"	beq	%0,3f\n"
-		"	mb\n"
-		"2:\n"
+		"1:	ldq_l	%1,%4\n"
+		"	lda	%3,1\n"
+		"	addl	%1,0,%2\n"
+		"	sll	%3,32,%3\n"
+		"	cmple	%2,0,%0\n"
+		"	cmovge	%2,0,%3\n"
+		"	cmplt	%1,0,%2\n"
+		"	addq	%3,1,%3\n"
+		"	and	%0,%2,%0\n"
+		"	bne	%0,2f\n"
+		"	subq	%1,%3,%1\n"
+		"	stq_c	%1,%4\n"
+		"	beq	%1,3f\n"
+		"2:	mb\n"
 		".subsection 2\n"
 		"3:	br	1b\n"
 		".previous"
-		: "=&r" (ret), "=m" (sem->count)
-		: "m" (sem->count));
+		: "=&r"(ret), "=&r"(tmp), "=&r"(tmp2), "=&r"(sub)
+		: "m"(*sem)
+		: "memory");
 
-	return ret < 0;
+	return ret;
 }
 
 static inline void __up(struct semaphore *sem)
 {
-	if (unlikely(atomic_inc_return(&sem->count) <= 0))
+	long ret, tmp, tmp2, tmp3;
+
+	/* We must manipulate count and waking simultaneously and atomically.
+	   Otherwise we have races between up and __down_failed_interruptible
+	   waking up on a signal.
+
+	   "Equivalent" C.  Note that we have to do this all without
+	   (taken) branches in order to be a valid ll/sc sequence.
+
+	   do {
+		tmp = ldq_l;
+		ret = (int)tmp + 1;			// count += 1;
+		tmp2 = tmp & 0xffffffff00000000;	// extract waking
+		if (ret <= 0)				// still sleepers?
+			tmp2 += 0x0000000100000000;	// waking += 1;
+		tmp = ret & 0x00000000ffffffff;		// insert count
+		tmp |= tmp2;				// insert waking;
+	       tmp = stq_c = tmp;
+	   } while (tmp == 0);
+	*/
+
+	__asm__ __volatile__(
+		"	mb\n"
+		"1:	ldq_l	%1,%4\n"
+		"	addl	%1,1,%0\n"
+		"	zapnot	%1,0xf0,%2\n"
+		"	addq	%2,%5,%3\n"
+		"	cmovle	%0,%3,%2\n"
+		"	zapnot	%0,0x0f,%1\n"
+		"	bis	%1,%2,%1\n"
+		"	stq_c	%1,%4\n"
+		"	beq	%1,3f\n"
+		"2:\n"
+		".subsection 2\n"
+		"3:	br	1b\n"
+		".previous"
+		: "=&r"(ret), "=&r"(tmp), "=&r"(tmp2), "=&r"(tmp3)
+		: "m"(*sem), "r"(0x0000000100000000)
+		: "memory");
+
+	if (unlikely(ret <= 0))
 		__up_wakeup(sem);
 }
 
--- 2.6.4/arch/alpha/kernel/semaphore.c	Thu Mar 11 05:55:27 2004
+++ linux/arch/alpha/kernel/semaphore.c	Fri Mar 12 22:43:04 2004
@@ -9,39 +9,31 @@
 #include <linux/sched.h>
 
 /*
- * This is basically the PPC semaphore scheme ported to use
- * the Alpha ll/sc sequences, so see the PPC code for
- * credits.
- */
-
-/*
- * Atomically update sem->count.
- * This does the equivalent of the following:
+ * Semaphores are implemented using a two-way counter:
+ * 
+ * The "count" variable is decremented for each process that tries to sleep,
+ * while the "waking" variable is incremented when the "up()" code goes to
+ * wake up waiting processes.
+ *
+ * Notably, the inline "up()" and "down()" functions can efficiently test
+ * if they need to do any extra work (up needs to do something only if count
+ * was negative before the increment operation.
+ *
+ * waking_non_zero() (from asm/semaphore.h) must execute atomically.
  *
- *	old_count = sem->count;
- *	tmp = MAX(old_count, 0) + incr;
- *	sem->count = tmp;
- *	return old_count;
+ * When __up() is called, the count was negative before incrementing it,
+ * and we need to wake up somebody.
+ *
+ * This routine adds one to the count of processes that need to wake up and
+ * exit.  ALL waiting processes actually wake up but only the one that gets
+ * to the "waking" field first will gate through and acquire the semaphore.
+ * The others will go back to sleep.
+ *
+ * Note that these functions are only called when there is contention on the
+ * lock, and as such all this is the "non-critical" part of the whole
+ * semaphore business. The critical part is the inline stuff in
+ * <asm/semaphore.h> where we want to avoid any extra jumps and calls.
  */
-static inline int __sem_update_count(struct semaphore *sem, int incr)
-{
-	long old_count, tmp = 0;
-
-	__asm__ __volatile__(
-	"1:	ldl_l	%0,%2\n"
-	"	cmovgt	%0,%0,%1\n"
-	"	addl	%1,%3,%1\n"
-	"	stl_c	%1,%2\n"
-	"	beq	%1,2f\n"
-	"	mb\n"
-	".subsection 2\n"
-	"2:	br	1b\n"
-	".previous"
-	: "=&r" (old_count), "=&r" (tmp), "=m" (sem->count)
-	: "Ir" (incr), "1" (tmp), "m" (sem->count));
-
-	return old_count;
-}
 
 /*
  * Perform the "down" function.  Return zero for semaphore acquired,
@@ -63,77 +55,134 @@ static inline int __sem_update_count(str
 void
 __down_failed(struct semaphore *sem)
 {
-	struct task_struct *tsk = current;
-	DECLARE_WAITQUEUE(wait, tsk);
+	DECLARE_WAITQUEUE(wait, current);
 
 #ifdef CONFIG_DEBUG_SEMAPHORE
 	printk("%s(%d): down failed(%p)\n",
-	       tsk->comm, tsk->pid, sem);
+	       current->comm, current->pid, sem);
 #endif
 
-	tsk->state = TASK_UNINTERRUPTIBLE;
+	current->state = TASK_UNINTERRUPTIBLE;
 	wmb();
 	add_wait_queue_exclusive(&sem->wait, &wait);
 
-	/*
-	 * Try to get the semaphore.  If the count is > 0, then we've
-	 * got the semaphore; we decrement count and exit the loop.
-	 * If the count is 0 or negative, we set it to -1, indicating
-	 * that we are asleep, and then sleep.
-	 */
-	while (__sem_update_count(sem, -1) <= 0) {
+	/* At this point we know that sem->count is negative.  In order
+	   to avoid racing with __up, we must check for wakeup before
+	   going to sleep the first time.  */
+
+	while (1) {
+		long ret, tmp;
+
+		/* An atomic conditional decrement of sem->waking.  */
+		__asm__ __volatile__(
+			"1:	ldl_l	%1,%2\n"
+			"	blt	%1,2f\n"
+			"	subl	%1,1,%0\n"
+			"	stl_c	%0,%2\n"
+			"	beq	%0,3f\n"
+			"2:\n"
+			".subsection 2\n"
+			"3:	br	1b\n"
+			".previous"
+			: "=r"(ret), "=&r"(tmp), "=m"(sem->waking)
+			: "0"(0));
+
+		if (ret)
+			break;
+
 		schedule();
-		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+		set_task_state(current, TASK_UNINTERRUPTIBLE);
 	}
-	remove_wait_queue(&sem->wait, &wait);
-	tsk->state = TASK_RUNNING;
 
-	/*
-	 * If there are any more sleepers, wake one of them up so
-	 * that it can either get the semaphore, or set count to -1
-	 * indicating that there are still processes sleeping.
-	 */
-	wake_up(&sem->wait);
+	remove_wait_queue(&sem->wait, &wait);
+	current->state = TASK_RUNNING;
 
 #ifdef CONFIG_DEBUG_SEMAPHORE
 	printk("%s(%d): down acquired(%p)\n",
-	       tsk->comm, tsk->pid, sem);
+	       current->comm, current->pid, sem);
 #endif
 }
 
 int
 __down_failed_interruptible(struct semaphore *sem)
 {
-	struct task_struct *tsk = current;
-	DECLARE_WAITQUEUE(wait, tsk);
-	long ret = 0;
+	DECLARE_WAITQUEUE(wait, current);
+	long ret;
 
 #ifdef CONFIG_DEBUG_SEMAPHORE
 	printk("%s(%d): down failed(%p)\n",
-	       tsk->comm, tsk->pid, sem);
+	       current->comm, current->pid, sem);
 #endif
 
-	tsk->state = TASK_INTERRUPTIBLE;
+	current->state = TASK_INTERRUPTIBLE;
 	wmb();
 	add_wait_queue_exclusive(&sem->wait, &wait);
 
-	while (__sem_update_count(sem, -1) <= 0) {
-		if (signal_pending(current)) {
-			/*
-			 * A signal is pending - give up trying.
-			 * Set sem->count to 0 if it is negative,
-			 * since we are no longer sleeping.
-			 */
-			__sem_update_count(sem, 0);
-			ret = -EINTR;
+	while (1) {
+		long tmp, tmp2, tmp3;
+
+		/* We must undo the sem->count down_interruptible decrement
+		   simultaneously and atomically with the sem->waking
+		   adjustment, otherwise we can race with __up.  This is
+		   accomplished by doing a 64-bit ll/sc on two 32-bit words.
+		
+		   "Equivalent" C.  Note that we have to do this all without
+		   (taken) branches in order to be a valid ll/sc sequence.
+
+		   do {
+		       tmp = ldq_l;
+		       ret = 0;
+		       if (tmp >= 0) {			// waking >= 0
+		           tmp += 0xffffffff00000000;	// waking -= 1
+		           ret = 1;
+		       }
+		       else if (pending) {
+			   // count += 1, but since -1 + 1 carries into the
+			   // high word, we have to be more careful here.
+			   tmp = (tmp & 0xffffffff00000000)
+				 | ((tmp + 1) & 0x00000000ffffffff);
+		           ret = -EINTR;
+		       }
+		       tmp = stq_c = tmp;
+		   } while (tmp == 0);
+		*/
+
+		__asm__ __volatile__(
+			"1:	ldq_l	%1,%4\n"
+			"	lda	%0,0\n"
+			"	cmovne	%5,%6,%0\n"
+			"	addq	%1,1,%2\n"
+			"	and	%1,%7,%3\n"
+			"	andnot	%2,%7,%2\n"
+			"	cmovge	%1,1,%0\n"
+			"	or	%3,%2,%2\n"
+			"	addq	%1,%7,%3\n"
+			"	cmovne	%5,%2,%1\n"
+			"	cmovge	%2,%3,%1\n"
+			"	stq_c	%1,%4\n"
+			"	beq	%1,3f\n"
+			"2:\n"
+			".subsection 2\n"
+			"3:	br	1b\n"
+			".previous"
+			: "=&r"(ret), "=&r"(tmp), "=&r"(tmp2),
+			  "=&r"(tmp3), "=m"(*sem)
+			: "r"(signal_pending(current)), "r"(-EINTR),
+			  "r"(0xffffffff00000000));
+
+		/* At this point we have ret
+		  	1	got the lock
+		  	0	go to sleep
+		  	-EINTR	interrupted  */
+		if (ret != 0)
 			break;
-		}
+
 		schedule();
-		set_task_state(tsk, TASK_INTERRUPTIBLE);
+		set_task_state(current, TASK_INTERRUPTIBLE);
 	}
 
 	remove_wait_queue(&sem->wait, &wait);
-	tsk->state = TASK_RUNNING;
+	current->state = TASK_RUNNING;
 	wake_up(&sem->wait);
 
 #ifdef CONFIG_DEBUG_SEMAPHORE
@@ -141,21 +190,14 @@ __down_failed_interruptible(struct semap
 	       current->comm, current->pid,
 	       (ret < 0 ? "interrupted" : "acquired"), sem);
 #endif
-	return ret;
+
+	/* Convert "got the lock" to 0==success.  */
+	return (ret < 0 ? ret : 0);
 }
 
 void
 __up_wakeup(struct semaphore *sem)
 {
-	/*
-	 * Note that we incremented count in up() before we came here,
-	 * but that was ineffective since the result was <= 0, and
-	 * any negative value of count is equivalent to 0.
-	 * This ends up setting count to 1, unless count is now > 0
-	 * (i.e. because some other cpu has called up() in the meantime),
-	 * in which case we just increment count.
-	 */
-	__sem_update_count(sem, 1);
 	wake_up(&sem->wait);
 }
 
