Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130870AbRBTW6m>; Tue, 20 Feb 2001 17:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130869AbRBTW6d>; Tue, 20 Feb 2001 17:58:33 -0500
Received: from suntan.tandem.com ([192.216.221.8]:10944 "EHLO
	suntan.tandem.com") by vger.kernel.org with ESMTP
	id <S129475AbRBTW6U>; Tue, 20 Feb 2001 17:58:20 -0500
Message-ID: <3A92F616.7B4F3735@compaq.com>
Date: Tue, 20 Feb 2001 14:56:22 -0800
From: "Brian J. Watson" <Brian.J.Watson@compaq.com>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.2.12-20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ben LaHaise <bcrl@redhat.com>
CC: mingo@redhat.com, linux-kernel@vger.kernel.org,
        John Byrne <john.l.byrne@compaq.com>
Subject: Re: [PATCH] trylock for rw_semaphores: 2.4.1
In-Reply-To: <Pine.LNX.4.30.0102192346410.27247-100000@today.toronto.redhat.com>
Content-Type: multipart/mixed;
 boundary="------------73C433430E86EC67DA979A5F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------73C433430E86EC67DA979A5F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Ben LaHaise wrote:
> How about the following instead?  Warning: compiled, not tested.
> 
>                 -ben
> 
> +/* returns 1 if it successfully obtained the semaphore for write */
> +static inline int down_write_trylock(struct rw_semaphore *sem)
> +{
> +       int old = RW_LOCK_BIAS, new = 0;
> +       int res;
> +
> +       res = cmpxchg(&sem->count.counter, old, new);
> +       return (res == RW_LOCK_BIAS);
> +}

Excellent! This simplifies things greatly. :)

The reason I returned 0 for success and 1 for failure is because that's the
semantic of down_trylock(). IMO they should be consistent.

The only other thing this routine needs is the WAITQUEUE_DEBUG code, at least to
keep the readers and writers fields accurate.


> +
> +/* returns 1 if it successfully obtained the semaphore for read */
> +static inline int down_read_trylock(struct rw_semaphore *sem)
> +{
> +       int ret = 1;
> +       asm volatile(
> +               LOCK "subl $1,%0
> +               js 2f
> +       1:
> +               .section .text.lock,\"ax\"
> +       2:"     LOCK "inc %0
> +               subl %1,%1
> +               jmp 1b
> +               .previous"
> +               :"=m" (*(volatile int *)sem), "=r" (ret) : "1" (ret) : "memory");
> +       return ret;
> +}

There's a couple of races I can see here:

1) Task A holds the write lock and the count is at zero. Simultaneously, task B
calls down_read_trylock() and task C calls down_read(). Task B wins and
decrements the count to -1. Not long after, task C decrements it to -2, sees the
carry bit is clear, and calls down_read_failed(). Meanwhile, task B bumps the
count back up to -1 and returns. When task C calls __up_read(), it bumps the
count to zero, sees that the zero flag is set, calls __rwsem_wake(), who sets
the write_bias_granted field to 1.

Now task D comes along. It calls down_write(), which decrements the count to
-BIAS, sees that the zero bit is clear and the carry bit is set, and calls
down_write_failed_biased(). Here it sees that the write_bias_granted field is 1,
xchg's it for a 0, and continues on, blissfully unaware that both A and D hold
the write lock.

2) Task A holds the write lock, and task B is waiting to get the write lock. The
count is at -BIAS. Task C calls down_read_trylock(), who decrements the count to
-BIAS-1. At this moment, task A releases the write lock. It bumps the count to
-1, sees that the carry bit is clear, and continues along. Now task C bumps the
count to 0, and returns. Task B continues sleeping, unaware that the write lock
is available. The next task who tries to grab the lock will decrement the count
below zero. It'll join task B in the biased code where it'll fall into a
never-ending sleep, because no one is going to call __rwsem_wake(). Anyone else
who tries to grab the lock will fall into a similar deep, deep sleep.


Adapting from your down_write_trylock() code, I implemented a new
down_read_trylock() that avoids these races.

Same disclaimer: compiled, not tested.


-Brian
--------------73C433430E86EC67DA979A5F
Content-Type: text/plain; charset=us-ascii;
 name="patch-2.4.1-trylock"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-2.4.1-trylock"

diff -ru4 2.4.1/include/asm-i386/semaphore.h 2.4.1-ben/include/asm-i386/semaphore.h
--- 2.4.1/include/asm-i386/semaphore.h	Fri Feb 16 18:47:23 2001
+++ 2.4.1-ben/include/asm-i386/semaphore.h	Tue Feb 20 14:23:19 2001
@@ -381,6 +381,61 @@
 #endif
 	__up_write(sem);
 }
 
+/* returns 0 if it successfully obtained the semaphore for write */
+static inline int down_write_trylock(struct rw_semaphore *sem)
+{
+	int old = RW_LOCK_BIAS, new = 0;
+
+#if WAITQUEUE_DEBUG
+	if (sem->__magic != (long)&sem->__magic)
+		BUG();
+#endif
+	if (cmpxchg(&sem->count.counter, old, new) == RW_LOCK_BIAS) {
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
+	else
+		return 1;
+}
+
+/* returns 0 if it successfully obtained the semaphore for read */
+static inline int down_read_trylock(struct rw_semaphore *sem)
+{
+	int old, new;
+
+#if WAITQUEUE_DEBUG
+	if (sem->__magic != (long)&sem->__magic)
+		BUG();
+#endif
+repeat:
+	old = atomic_read(&sem->count);
+	if (old <= 0)
+		return 1;
+	new = old - 1;
+	if (cmpxchg(&sem->count.counter, old, new) == old) {
+#if WAITQUEUE_DEBUG
+		if (sem->write_bias_granted)
+			BUG();
+		if (atomic_read(&sem->writers))
+			BUG();
+		atomic_inc(&sem->readers);
+#endif
+		return 0;
+	}
+	else
+		goto repeat;
+}
+
 #endif
 #endif

--------------73C433430E86EC67DA979A5F--

