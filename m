Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317058AbSHJPcI>; Sat, 10 Aug 2002 11:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317066AbSHJPcH>; Sat, 10 Aug 2002 11:32:07 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:37390 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S317058AbSHJPcE>; Sat, 10 Aug 2002 11:32:04 -0400
Date: Sat, 10 Aug 2002 19:35:28 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>,
       Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.5.30] alpha: rwsem update [10/10]
Message-ID: <20020810193528.I20534@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- __down_[read,write]_trylock, __downgrade_write implemented;
- __builtin_expect replaced with unlikely().

Ivan.

--- 2.5.30/include/asm-alpha/rwsem.h	Fri Aug  2 01:16:35 2002
+++ linux/include/asm-alpha/rwsem.h	Thu Aug  8 19:28:02 2002
@@ -21,6 +21,7 @@ struct rwsem_waiter;
 extern struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem);
 extern struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem);
 extern struct rw_semaphore *rwsem_wake(struct rw_semaphore *);
+extern struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem);
 
 /*
  * the semaphore definition
@@ -83,10 +84,26 @@ static inline void __down_read(struct rw
 	:"=&r" (oldcount), "=m" (sem->count), "=&r" (temp)
 	:"Ir" (RWSEM_ACTIVE_READ_BIAS), "m" (sem->count) : "memory");
 #endif
-	if (__builtin_expect(oldcount < 0, 0))
+	if (unlikely(oldcount < 0))
 		rwsem_down_read_failed(sem);
 }
 
+/*
+ * trylock for reading -- returns 1 if successful, 0 if contention
+ */
+static inline int __down_read_trylock(struct rw_semaphore *sem)
+{
+	long res, tmp;
+
+	res = sem->count;
+	do {
+		tmp = res + RWSEM_ACTIVE_READ_BIAS;
+		if (tmp <= 0)
+			break;
+	} while (cmpxchg(&sem->count, res, tmp) != res);
+	return res >= 0 ? 1 : 0;
+}
+
 static inline void __down_write(struct rw_semaphore *sem)
 {
 	long oldcount;
@@ -107,10 +124,22 @@ static inline void __down_write(struct r
 	:"=&r" (oldcount), "=m" (sem->count), "=&r" (temp)
 	:"Ir" (RWSEM_ACTIVE_WRITE_BIAS), "m" (sem->count) : "memory");
 #endif
-	if (__builtin_expect(oldcount, 0))
+	if (unlikely(oldcount))
 		rwsem_down_write_failed(sem);
 }
 
+/*
+ * trylock for writing -- returns 1 if successful, 0 if contention
+ */
+static inline int __down_write_trylock(struct rw_semaphore *sem)
+{
+	long ret = cmpxchg(&sem->count, RWSEM_UNLOCKED_VALUE,
+			   RWSEM_ACTIVE_WRITE_BIAS);
+	if (ret == RWSEM_UNLOCKED_VALUE)
+		return 1;
+	return 0;
+}
+
 static inline void __up_read(struct rw_semaphore *sem)
 {
 	long oldcount;
@@ -131,7 +160,7 @@ static inline void __up_read(struct rw_s
 	:"=&r" (oldcount), "=m" (sem->count), "=&r" (temp)
 	:"Ir" (RWSEM_ACTIVE_READ_BIAS), "m" (sem->count) : "memory");
 #endif
-	if (__builtin_expect(oldcount < 0, 0)) 
+	if (unlikely(oldcount < 0))
 		if ((int)oldcount - RWSEM_ACTIVE_READ_BIAS == 0)
 			rwsem_wake(sem);
 }
@@ -157,9 +186,36 @@ static inline void __up_write(struct rw_
 	:"=&r" (count), "=m" (sem->count), "=&r" (temp)
 	:"Ir" (RWSEM_ACTIVE_WRITE_BIAS), "m" (sem->count) : "memory");
 #endif
-	if (__builtin_expect(count, 0))
+	if (unlikely(count))
 		if ((int)count == 0)
 			rwsem_wake(sem);
+}
+
+/*
+ * downgrade write lock to read lock
+ */
+static inline void __downgrade_write(struct rw_semaphore *sem)
+{
+	long oldcount;
+#ifndef	CONFIG_SMP
+	oldcount = sem->count;
+	sem->count -= RWSEM_WAITING_BIAS;
+#else
+	long temp;
+	__asm__ __volatile__(
+	"1:	ldq_l	%0,%1\n"
+	"	addq	%0,%3,%2\n"
+	"	stq_c	%2,%1\n"
+	"	beq	%2,2f\n"
+	"	mb\n"
+	".subsection 2\n"
+	"2:	br	1b\n"
+	".previous"
+	:"=&r" (oldcount), "=m" (sem->count), "=&r" (temp)
+	:"Ir" (-RWSEM_WAITING_BIAS), "m" (sem->count) : "memory");
+#endif
+	if (unlikely(oldcount < 0))
+		rwsem_downgrade_wake(sem);
 }
 
 static inline void rwsem_atomic_add(long val, struct rw_semaphore *sem)
