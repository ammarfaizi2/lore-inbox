Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbRBTDJL>; Mon, 19 Feb 2001 22:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129115AbRBTDJA>; Mon, 19 Feb 2001 22:09:00 -0500
Received: from suntan.tandem.com ([192.216.221.8]:62338 "EHLO
	suntan.tandem.com") by vger.kernel.org with ESMTP
	id <S129069AbRBTDIq>; Mon, 19 Feb 2001 22:08:46 -0500
Message-ID: <3A91DF45.593860E4@compaq.com>
Date: Mon, 19 Feb 2001 19:06:45 -0800
From: "Brian J. Watson" <Brian.J.Watson@compaq.com>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.2.12-20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@redhat.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] trylock for rw_semaphores: 2.4.1
Content-Type: multipart/mixed;
 boundary="------------9348CB6E3B91C2BB41661F08"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9348CB6E3B91C2BB41661F08
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Here is an x86 implementation of down_read_trylock() and down_write_trylock()
for read/write semaphores. As with down_trylock() for exclusive semaphores, they
don't block if they fail to get the lock. They just return 1, as opposed to 0 in
the success case.

The algorithm should be robust. It should be able to handle any race and clean
up properly if a task fails to get the lock, but I would appreciate comments if
anyone sees a flaw.

Admittedly, the code path for successfully grabbing the lock is longer than it
should be. I should have done the nested if tests in down_*_trylock() with js
and jc assembly instructions, rather than using sets and setc to copy the flags
to C variables. My excuse is that I'm unfamiliar with assembly programming, so I
took the path of least resistance.

I've only tested the code to make sure it compiles and works properly when the
lock is already held, but there are no waiters. This is the tricky case where it
has to weasel out of holding the bias. The success case and non-bias failure
case still need to be tested. Stress testing might also be a good idea. I don't
have the time to do this right now, but I thought I'd make the patch available
in case anyone else is interested the functionality.


Brian Watson
Compaq Computer
brian.j.watson@compaq.com
--------------9348CB6E3B91C2BB41661F08
Content-Type: text/plain; charset=us-ascii;
 name="patch-2.4.1-trylock"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-2.4.1-trylock"

diff -Nar -u4 2.4.1/arch/i386/kernel/semaphore.c 2.4.1-trylock/arch/i386/kernel/semaphore.c
--- 2.4.1/arch/i386/kernel/semaphore.c	Sat Nov 18 17:31:25 2000
+++ 2.4.1-trylock/arch/i386/kernel/semaphore.c	Fri Feb 16 18:13:16 2001
@@ -382,8 +382,41 @@
 
 	return sem;
 }
 
+/* We have the bias, but we can't sleep. We have to get rid of it
+ * as gracefully as we can.
+ *
+ * This routine does have the unfortunate side-effect that we could 
+ * spin for awhile if there's a lot of contention for this lock. If 
+ * that's the case, however, then it's less likely that we would hold 
+ * the bias and be running this code.
+ */
+void __up_biased(int val, struct rw_semaphore *sem)
+{
+	int count, newcount;
+repeat:
+	/* Does it look like we're racing with another contender? */
+	count = atomic_read(&sem->count);
+	newcount = count + val;
+	if (newcount < 0)
+		/* Yes: Try again. */
+		goto repeat;
+	else
+		/* No: Bump the count while no one's looking. Did we race? */
+		if (cmpxchg((volatile int *)&sem->count, count, newcount) 
+				!= count)
+			/* Yes: Try again. */
+			goto repeat;
+		else
+			/* No: Let the real waiters duke it out for the bias.
+			 * FIXME: This has the same potential stampede problem 
+			 * as down_write_failed_biased().
+			 */
+			if (atomic_read(&sem->count) >= 0)
+				wake_up(&sem->wait);
+}
+
 asm(
 "
 .align 4
 .globl __rwsem_wake
diff -Nar -u4 2.4.1/include/asm-i386/atomic.h 2.4.1-trylock/include/asm-i386/atomic.h
--- 2.4.1/include/asm-i386/atomic.h	Thu Jan  4 14:50:46 2001
+++ 2.4.1-trylock/include/asm-i386/atomic.h	Fri Feb 16 18:13:16 2001
@@ -52,8 +52,21 @@
 		:"ir" (i), "m" (v->counter) : "memory");
 	return c;
 }
 
+#define ATOMIC_SUB_SIGN_BIT	0x1
+#define ATOMIC_SUB_CARRY_BIT	0x2
+static __inline__ int atomic_sub_sign_and_carry(int i, atomic_t *v)
+{
+	unsigned char s, c;
+
+	__asm__ __volatile__(
+		LOCK "subl %3,%0; sets %1; setc %2"
+		:"=m" (v->counter), "=qm" (s), "=qm" (c)
+		:"ir" (i), "m" (v->counter) : "memory");
+	return s | c<<1;
+}
+
 static __inline__ void atomic_inc(atomic_t *v)
 {
 	__asm__ __volatile__(
 		LOCK "incl %0"
diff -Nar -u4 2.4.1/include/asm-i386/semaphore.h 2.4.1-trylock/include/asm-i386/semaphore.h
--- 2.4.1/include/asm-i386/semaphore.h	Thu Jan  4 14:50:46 2001
+++ 2.4.1-trylock/include/asm-i386/semaphore.h	Fri Feb 16 18:13:16 2001
@@ -381,6 +381,76 @@
 #endif
 	__up_write(sem);
 }
 
+extern void __up_biased(int val, struct rw_semaphore *sem);
+
+static inline int down_read_trylock(struct rw_semaphore *sem)
+{
+	int retval;
+#if WAITQUEUE_DEBUG
+	if (sem->__magic != (long)&sem->__magic)
+		BUG();
+#endif
+	retval = atomic_sub_sign_and_carry(1, &sem->count);
+	/* Did we get the lock? */
+	if (retval & ATOMIC_SUB_SIGN_BIT) {
+		/* No: Does someone else have the bias? */
+		if (retval & ATOMIC_SUB_CARRY_BIT)
+			/* No: Guess we have to do this the hard way. */
+			__up_biased(1, sem);
+		else
+			/* Yes: Fix the count and pretend nothing happened. */
+			__up_read(sem);
+		return 1;
+	}
+	else {
+		/* Yes: We got the lock!! */
+#if WAITQUEUE_DEBUG
+		if (sem->write_bias_granted)
+			BUG();
+		if (atomic_read(&sem->writers))
+			BUG();
+		atomic_inc(&sem->readers);
+#endif
+		return 0;
+	}
+}
+
+static inline int down_write_trylock(struct rw_semaphore *sem)
+{
+	int retval;
+#if WAITQUEUE_DEBUG
+	if (sem->__magic != (long)&sem->__magic)
+		BUG();
+#endif
+	retval = atomic_sub_sign_and_carry(RW_LOCK_BIAS, &sem->count);
+	/* Did we get the lock? */
+	if (retval & ATOMIC_SUB_SIGN_BIT) {
+		/* No: Does someone else have the bias? */
+		if (retval & ATOMIC_SUB_CARRY_BIT)
+			/* No: Guess we have to do this the hard way. */
+			__up_biased(RW_LOCK_BIAS, sem);
+		else
+			/* Yes: Fix the count and pretend nothing happened. */
+			__up_write(sem);
+		return 1;
+	}
+	else {
+		/* Yes: We got the lock!! */
+#if WAITQUEUE_DEBUG
+		if (atomic_read(&sem->writers))
+			BUG();
+		if (atomic_read(&sem->readers))
+			BUG();
+		if (sem->read_bias_granted)
+			BUG();
+		if (sem->write_bias_granted)
+			BUG();
+		atomic_inc(&sem->writers);
+#endif
+		return 0;
+	}
+}
+
 #endif
 #endif




--------------9348CB6E3B91C2BB41661F08--

