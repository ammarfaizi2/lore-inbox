Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291241AbSBLXJf>; Tue, 12 Feb 2002 18:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291243AbSBLXJ0>; Tue, 12 Feb 2002 18:09:26 -0500
Received: from suntan.tandem.com ([192.216.221.8]:40111 "EHLO
	suntan.tandem.com") by vger.kernel.org with ESMTP
	id <S291241AbSBLXJQ>; Tue, 12 Feb 2002 18:09:16 -0500
From: bwatson@kahuna.cag.cpqcorp.net
Message-Id: <200202122257.g1CMv9W05368@kahuna.cag.cpqcorp.net>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, hch@caldera.de
Date: Tue, 12 Feb 2002 14:45 PST
Subject: [PATCH] 2.4.18-pre9, trylock for read/write semaphores
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo-

Attached is a patch that adds trylock routines for read/write 
semaphores. David Howells saw it last August and thought it was ready 
to be submitted then, but I became distracted and haven't taken the 
time to submit it until now. My motivation is that Christoph Hellwig 
says he needs it for JFS.

I hammered on this patch with a test kernel based on 2.4.18-pre7. The
test kernel put a read/write semaphore under heavy contention with a
mix of down_read(), down_write(), down_read_trylock(), and 
down_write_trylock() calls. I made sure no process got a lock when
it shouldn't, and that no deadlocks occurred. I also made sure it 
applies cleanly against 2.4.18-pre9. Considering that it does not 
affect the rest of the kernel (since no one calls it), I think it's 
safe to include in 2.4.18.


Brian Watson                | "Now I don't know, but I been told it's
Linux Kernel Developer      |  hard to run with the weight of gold,
Open SSI Clustering Project |  Other hand I heard it said, it's
Compaq Computer Corp        |  just as hard with the weight of lead."
Los Angeles, CA             |     -Robert Hunter, 1970

mailto:Brian.J.Watson@compaq.com
http://opensource.compaq.com/


diff -Naur linux-2.4.18-pre9/include/asm-i386/rwsem.h trylock-2.4.18-pre9/include/asm-i386/rwsem.h
--- linux-2.4.18-pre9/include/asm-i386/rwsem.h	Tue Feb 12 12:14:14 2002
+++ trylock-2.4.18-pre9/include/asm-i386/rwsem.h	Tue Feb 12 12:14:55 2002
@@ -121,6 +121,24 @@
 }
 
 /*
+ * trylock for reading -- returns 1 if successful, 0 if contention
+ */
+static inline int __down_read_trylock(struct rw_semaphore *sem)
+{
+	signed long old, new;
+
+repeat:
+	old = (volatile signed long)sem->count;
+	if (old < RWSEM_UNLOCKED_VALUE)
+		return 0;
+	new = old + RWSEM_ACTIVE_READ_BIAS;
+	if (cmpxchg(&sem->count, old, new) == old)
+		return 1;
+	else
+		goto repeat;
+}
+
+/*
  * lock for writing
  */
 static inline void __down_write(struct rw_semaphore *sem)
@@ -148,6 +166,19 @@
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
diff -Naur linux-2.4.18-pre9/include/linux/rwsem-spinlock.h trylock-2.4.18-pre9/include/linux/rwsem-spinlock.h
--- linux-2.4.18-pre9/include/linux/rwsem-spinlock.h	Thu Nov 22 11:46:19 2001
+++ trylock-2.4.18-pre9/include/linux/rwsem-spinlock.h	Tue Feb 12 12:14:55 2002
@@ -54,7 +54,9 @@
 
 extern void FASTCALL(init_rwsem(struct rw_semaphore *sem));
 extern void FASTCALL(__down_read(struct rw_semaphore *sem));
+extern int FASTCALL(__down_read_trylock(struct rw_semaphore *sem));
 extern void FASTCALL(__down_write(struct rw_semaphore *sem));
+extern int FASTCALL(__down_write_trylock(struct rw_semaphore *sem));
 extern void FASTCALL(__up_read(struct rw_semaphore *sem));
 extern void FASTCALL(__up_write(struct rw_semaphore *sem));
 
diff -Naur linux-2.4.18-pre9/include/linux/rwsem.h trylock-2.4.18-pre9/include/linux/rwsem.h
--- linux-2.4.18-pre9/include/linux/rwsem.h	Thu Nov 22 11:46:19 2001
+++ trylock-2.4.18-pre9/include/linux/rwsem.h	Tue Feb 12 12:14:55 2002
@@ -46,6 +46,18 @@
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
@@ -53,6 +65,18 @@
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
diff -Naur linux-2.4.18-pre9/lib/rwsem-spinlock.c trylock-2.4.18-pre9/lib/rwsem-spinlock.c
--- linux-2.4.18-pre9/lib/rwsem-spinlock.c	Wed Apr 25 13:31:03 2001
+++ trylock-2.4.18-pre9/lib/rwsem-spinlock.c	Tue Feb 12 12:14:55 2002
@@ -149,6 +149,28 @@
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
@@ -192,6 +214,28 @@
 
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
