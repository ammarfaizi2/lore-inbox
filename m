Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264375AbRGRXgu>; Wed, 18 Jul 2001 19:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264432AbRGRXgl>; Wed, 18 Jul 2001 19:36:41 -0400
Received: from suntan.tandem.com ([192.216.221.8]:15515 "EHLO
	suntan.tandem.com") by vger.kernel.org with ESMTP
	id <S264375AbRGRXgd>; Wed, 18 Jul 2001 19:36:33 -0400
Message-ID: <3B561A50.A1B35FBC@compaq.com>
Date: Wed, 18 Jul 2001 16:22:56 -0700
From: "Brian J. Watson" <Brian.J.Watson@compaq.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] read/write semaphore trylock routines - 2.4.6
In-Reply-To: <16572.994750374@warthog.cambridge.redhat.com> <3B4BC60E.85C12357@compaq.com>
Content-Type: multipart/mixed;
 boundary="------------1041FCAF84C2F5569B11DAC7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1041FCAF84C2F5569B11DAC7
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

"Brian J. Watson" wrote:
> I've added the generic spinlock versions. I've also renamed the i386
> versions to __down_*_trylock() and added stubs to
> include/linux/rwsem.h, as you did for the up_*() and down_*()
> routines.
> 
> The generic versions were compiled but not tested. Probably not a big
> deal since I snagged most of the code from your __down_*() routines.
> 

David-

Is this patch ready to go into the kernel? Is there anything else I
should do to get it ready? I noticed it didn't make it into
2.4.7-pre7.

-- 
Brian Watson             | "The common people of England... so 
Linux Kernel Developer   |  jealous of their liberty, but like the 
Open SSI Clustering Lab  |  common people of most other countries 
Compaq Computer Corp     |  never rightly considering wherein it 
Los Angeles, CA          |  consists..."
                         |      -Adam Smith, Wealth of Nations, 1776

mailto:Brian.J.Watson@compaq.com
http://opensource.compaq.com/
--------------1041FCAF84C2F5569B11DAC7
Content-Type: text/plain; charset=us-ascii;
 name="patch-rwsem-trylock"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-rwsem-trylock"

diff -ur linux/include/asm-i386/rwsem.h rwsem_trylock/include/asm-i386/rwsem.h
--- linux/include/asm-i386/rwsem.h	Fri Apr 27 15:48:24 2001
+++ rwsem_trylock/include/asm-i386/rwsem.h	Tue Jul 10 19:32:05 2001
@@ -117,6 +117,24 @@
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
@@ -141,6 +159,19 @@
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
diff -ur linux/include/linux/rwsem-spinlock.h rwsem_trylock/include/linux/rwsem-spinlock.h
--- linux/include/linux/rwsem-spinlock.h	Wed Jul  4 14:20:44 2001
+++ rwsem_trylock/include/linux/rwsem-spinlock.h	Tue Jul 10 19:32:05 2001
@@ -54,7 +54,9 @@
 
 extern void FASTCALL(init_rwsem(struct rw_semaphore *sem));
 extern void FASTCALL(__down_read(struct rw_semaphore *sem));
+extern int FASTCALL(__down_read_trylock(struct rw_semaphore *sem));
 extern void FASTCALL(__down_write(struct rw_semaphore *sem));
+extern int FASTCALL(__down_write_trylock(struct rw_semaphore *sem));
 extern void FASTCALL(__up_read(struct rw_semaphore *sem));
 extern void FASTCALL(__up_write(struct rw_semaphore *sem));
 
diff -ur linux/include/linux/rwsem.h rwsem_trylock/include/linux/rwsem.h
--- linux/include/linux/rwsem.h	Wed Jul  4 14:20:44 2001
+++ rwsem_trylock/include/linux/rwsem.h	Tue Jul 10 19:32:05 2001
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
diff -ur linux/lib/rwsem-spinlock.c rwsem_trylock/lib/rwsem-spinlock.c
--- linux/lib/rwsem-spinlock.c	Wed Apr 25 13:31:03 2001
+++ rwsem_trylock/lib/rwsem-spinlock.c	Tue Jul 10 18:59:24 2001
@@ -149,6 +149,28 @@
 }
 
 /*
+ * trylock for reading -- returns 1 if successful, 0 if contention
+ */
+int __down_read_trylock(struct rw_semaphore *sem)
+{
+	int ret = 0;
+
+	rwsemtrace(sem,"Entering __down_read_trylock");
+
+	spin_lock(&sem->wait_lock);
+
+	if (sem->activity>=0 && list_empty(&sem->wait_list)) {
+		/* granted */
+		sem->activity++;
+		spin_unlock(&sem->wait_lock);
+		ret = 1;
+	}
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
+
+	rwsemtrace(sem,"Entering __down_write_trylock");
+
+	spin_lock(&sem->wait_lock);
+
+	if (sem->activity==0 && list_empty(&sem->wait_list)) {
+		/* granted */
+		sem->activity = -1;
+		spin_unlock(&sem->wait_lock);
+		ret = 1;
+	}
+
+	rwsemtrace(sem,"Leaving __down_write_trylock");
+	return ret;
 }
 
 /*

--------------1041FCAF84C2F5569B11DAC7--

