Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289954AbSBSUfR>; Tue, 19 Feb 2002 15:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289877AbSBSUeL>; Tue, 19 Feb 2002 15:34:11 -0500
Received: from suntan.tandem.com ([192.216.221.8]:29168 "EHLO
	suntan.tandem.com") by vger.kernel.org with ESMTP
	id <S289876AbSBSUdh>; Tue, 19 Feb 2002 15:33:37 -0500
From: bwatson@kahuna.cag.cpqcorp.net
Message-Id: <200202192012.g1JKCOd15393@kahuna.cag.cpqcorp.net>
To: marcelo@conectiva.com.br, torvalds@transmeta.com
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org, hch@caldera.de
Date: Tue, 19 Feb 2002 11:52 PST
Subject: [PATCH] 2.4.18-rc1, trylock for read/write semaphores
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo, Linus-

Attached is a patch that adds trylock routines for read/write 
semaphores. David Howells recently reviewed it, and helped me make 
down_read_trylock() more efficient. He thinks it's ready to
be submitted. The Open SSI project needs the trylock routines for 
the Cluster Filesystem (CFS), and Christoph Hellwig says he needs 
them for JFS.

I hammered on this patch with a test kernel based on 2.4.18-rc1. 
The test kernel put a read/write semaphore under heavy contention 
with a mix of down_read(), down_write(), down_read_trylock(), and 
down_write_trylock() calls. I made sure no process got a lock when
it shouldn't, and that no deadlocks occurred. Considering that it 
does not affect the rest of the kernel (since no one calls it), I 
think it's safe to include in 2.4.18.


Brian Watson                | "Now I don't know, but I been told it's
Linux Kernel Developer      |  hard to run with the weight of gold,
Open SSI Clustering Project |  Other hand I heard it said, it's
Compaq Computer Corp        |  just as hard with the weight of lead."
Los Angeles, CA             |     -Robert Hunter, 1970

mailto:Brian.J.Watson@compaq.com
http://opensource.compaq.com/


diff -Naur linux-2.4.18-rc1/include/asm-i386/rwsem.h rwsem/include/asm-i386/rwsem.h
--- linux-2.4.18-rc1/include/asm-i386/rwsem.h	Mon Feb 18 11:01:43 2002
+++ rwsem/include/asm-i386/rwsem.h	Tue Feb 19 11:06:12 2002
@@ -4,6 +4,8 @@
  *
  * Derived from asm-i386/semaphore.h
  *
+ * Trylock by Brian Watson (Brian.J.Watson@compaq.com).
+ *
  *
  * The MSW of the count is the negated number of active writers and waiting
  * lockers, and the LSW is the total number of active locks
@@ -121,6 +123,29 @@
 }
 
 /*
+ * trylock for reading -- returns 1 if successful, 0 if contention
+ */
+static inline int __down_read_trylock(struct rw_semaphore *sem)
+{
+	__s32 result, tmp;
+	__asm__ __volatile__(
+		"# beginning __down_read_trylock\n\t"
+		"  movl      %0,%1\n\t"
+		"1:\n\t"
+		"  movl	     %1,%2\n\t"
+		"  addl      %3,%2\n\t"
+		"  jle	     2f\n\t"
+LOCK_PREFIX	"  cmpxchgl  %2,%0\n\t"
+		"  jnz	     1b\n\t"
+		"2:\n\t"
+		"# ending __down_read_trylock\n\t"
+		: "+m"(sem->count), "=&a"(result), "=&r"(tmp)
+		: "i"(RWSEM_ACTIVE_READ_BIAS)
+		: "memory", "cc");
+	return result>=0 ? 1 : 0;
+}
+
+/*
  * lock for writing
  */
 static inline void __down_write(struct rw_semaphore *sem)
@@ -148,6 +173,19 @@
 		: "+d"(tmp), "+m"(sem->count)
 		: "a"(sem)
 		: "memory", "cc");
+}
+
+/*
+ * trylock for writing -- returns 1 if successful, 0 if contention
+ */
+static inline int __down_write_trylock(struct rw_semaphore *sem)
+{
+	signed long ret = cmpxchg(&sem->count,
+				  RWSEM_UNLOCKED_VALUE, 
+				  RWSEM_ACTIVE_WRITE_BIAS);
+	if (ret == RWSEM_UNLOCKED_VALUE)
+		return 1;
+	return 0;
 }
 
 /*
diff -Naur linux-2.4.18-rc1/include/linux/rwsem-spinlock.h rwsem/include/linux/rwsem-spinlock.h
--- linux-2.4.18-rc1/include/linux/rwsem-spinlock.h	Thu Nov 22 11:46:19 2001
+++ rwsem/include/linux/rwsem-spinlock.h	Tue Feb 19 11:03:13 2002
@@ -3,6 +3,8 @@
  * Copyright (c) 2001   David Howells (dhowells@redhat.com).
  * - Derived partially from ideas by Andrea Arcangeli <andrea@suse.de>
  * - Derived also from comments by Linus
+ *
+ * Trylock by Brian Watson (Brian.J.Watson@compaq.com).
  */
 
 #ifndef _LINUX_RWSEM_SPINLOCK_H
@@ -54,7 +56,9 @@
 
 extern void FASTCALL(init_rwsem(struct rw_semaphore *sem));
 extern void FASTCALL(__down_read(struct rw_semaphore *sem));
+extern int FASTCALL(__down_read_trylock(struct rw_semaphore *sem));
 extern void FASTCALL(__down_write(struct rw_semaphore *sem));
+extern int FASTCALL(__down_write_trylock(struct rw_semaphore *sem));
 extern void FASTCALL(__up_read(struct rw_semaphore *sem));
 extern void FASTCALL(__up_write(struct rw_semaphore *sem));
 
diff -Naur linux-2.4.18-rc1/include/linux/rwsem.h rwsem/include/linux/rwsem.h
--- linux-2.4.18-rc1/include/linux/rwsem.h	Thu Nov 22 11:46:19 2001
+++ rwsem/include/linux/rwsem.h	Tue Feb 19 11:03:06 2002
@@ -2,6 +2,8 @@
  *
  * Written by David Howells (dhowells@redhat.com).
  * Derived from asm-i386/semaphore.h
+ *
+ * Trylock by Brian Watson (Brian.J.Watson@compaq.com).
  */
 
 #ifndef _LINUX_RWSEM_H
@@ -46,6 +48,18 @@
 }
 
 /*
+ * trylock for reading -- returns 1 if successful, 0 if contention
+ */
+static inline int down_read_trylock(struct rw_semaphore *sem)
+{
+	int ret;
+	rwsemtrace(sem,"Entering down_read_trylock");
+	ret = __down_read_trylock(sem);
+	rwsemtrace(sem,"Leaving down_read_trylock");
+	return ret;
+}
+
+/*
  * lock for writing
  */
 static inline void down_write(struct rw_semaphore *sem)
@@ -53,6 +67,18 @@
 	rwsemtrace(sem,"Entering down_write");
 	__down_write(sem);
 	rwsemtrace(sem,"Leaving down_write");
+}
+
+/*
+ * trylock for writing -- returns 1 if successful, 0 if contention
+ */
+static inline int down_write_trylock(struct rw_semaphore *sem)
+{
+	int ret;
+	rwsemtrace(sem,"Entering down_write_trylock");
+	ret = __down_write_trylock(sem);
+	rwsemtrace(sem,"Leaving down_write_trylock");
+	return ret;
 }
 
 /*
diff -Naur linux-2.4.18-rc1/lib/rwsem-spinlock.c rwsem/lib/rwsem-spinlock.c
--- linux-2.4.18-rc1/lib/rwsem-spinlock.c	Wed Apr 25 13:31:03 2001
+++ rwsem/lib/rwsem-spinlock.c	Tue Feb 19 11:05:42 2002
@@ -4,6 +4,8 @@
  * Copyright (c) 2001   David Howells (dhowells@redhat.com).
  * - Derived partially from idea by Andrea Arcangeli <andrea@suse.de>
  * - Derived also from comments by Linus
+ *
+ * Trylock by Brian Watson (Brian.J.Watson@compaq.com).
  */
 #include <linux/rwsem.h>
 #include <linux/sched.h>
@@ -149,6 +151,28 @@
 }
 
 /*
+ * trylock for reading -- returns 1 if successful, 0 if contention
+ */
+int __down_read_trylock(struct rw_semaphore *sem)
+{
+	int ret = 0;
+	rwsemtrace(sem,"Entering __down_read_trylock");
+
+	spin_lock(&sem->wait_lock);
+
+	if (sem->activity>=0 && list_empty(&sem->wait_list)) {
+		/* granted */
+		sem->activity++;
+		ret = 1;
+	}
+
+	spin_unlock(&sem->wait_lock);
+
+	rwsemtrace(sem,"Leaving __down_read_trylock");
+	return ret;
+}
+
+/*
  * get a write lock on the semaphore
  * - note that we increment the waiting count anyway to indicate an exclusive lock
  */
@@ -192,6 +216,28 @@
 
  out:
 	rwsemtrace(sem,"Leaving __down_write");
+}
+
+/*
+ * trylock for writing -- returns 1 if successful, 0 if contention
+ */
+int __down_write_trylock(struct rw_semaphore *sem)
+{
+	int ret = 0;
+	rwsemtrace(sem,"Entering __down_write_trylock");
+
+	spin_lock(&sem->wait_lock);
+
+	if (sem->activity==0 && list_empty(&sem->wait_list)) {
+		/* granted */
+		sem->activity = -1;
+		ret = 1;
+	}
+
+	spin_unlock(&sem->wait_lock);
+
+	rwsemtrace(sem,"Leaving __down_write_trylock");
+	return ret;
 }
 
 /*
