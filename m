Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316997AbSG1SVd>; Sun, 28 Jul 2002 14:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317005AbSG1SVd>; Sun, 28 Jul 2002 14:21:33 -0400
Received: from verein.lst.de ([212.34.181.86]:11781 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S316997AbSG1SVa>;
	Sun, 28 Jul 2002 14:21:30 -0400
Date: Sun, 28 Jul 2002 20:24:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: dhowells@redhat.com, adam@yggdrasil.com, linux-kernel@vger.kernel.org
Subject: [PATCH] missing rwsem bits
Message-ID: <20020728202419.A24944@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	dhowells@redhat.com, adam@yggdrasil.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

when David send you the last rwsem patch he included the bits done by
Brian and me (1) in the description, but not in the patch.  This BK
patch adds the missing bits (already reviewed by David).


(1) that is: down_read_trylock/down_write_trylock and the generic
spinlock implementation of write_downgrade.

--
You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.477, 2002-07-28 21:18:19+02:00, hch@sb.bsdonline.org
  Implement down_read_trylock() and down_write_trylock() and add a
  generic spinlock implementation for downgrade_write().


 include/asm-i386/rwsem.h       |   36 ++++++++++++++++
 include/linux/rwsem-spinlock.h |    3 +
 include/linux/rwsem.h          |   25 +++++++++++
 lib/rwsem-spinlock.c           |   89 ++++++++++++++++++++++++++++++++++++++---
 4 files changed, 146 insertions, 7 deletions


diff -Nru a/include/asm-i386/rwsem.h b/include/asm-i386/rwsem.h
--- a/include/asm-i386/rwsem.h	Sun Jul 28 21:19:16 2002
+++ b/include/asm-i386/rwsem.h	Sun Jul 28 21:19:16 2002
@@ -118,6 +118,29 @@
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
@@ -142,6 +165,19 @@
 		: "=m"(sem->count), "=d"(tmp)
 		: "a"(sem), "1"(tmp), "m"(sem->count)
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
diff -Nru a/include/linux/rwsem-spinlock.h b/include/linux/rwsem-spinlock.h
--- a/include/linux/rwsem-spinlock.h	Sun Jul 28 21:19:16 2002
+++ b/include/linux/rwsem-spinlock.h	Sun Jul 28 21:19:16 2002
@@ -54,9 +54,12 @@
 
 extern void FASTCALL(init_rwsem(struct rw_semaphore *sem));
 extern void FASTCALL(__down_read(struct rw_semaphore *sem));
+extern int FASTCALL(__down_read_trylock(struct rw_semaphore *sem));
 extern void FASTCALL(__down_write(struct rw_semaphore *sem));
+extern int FASTCALL(__down_write_trylock(struct rw_semaphore *sem));
 extern void FASTCALL(__up_read(struct rw_semaphore *sem));
 extern void FASTCALL(__up_write(struct rw_semaphore *sem));
+extern void FASTCALL(__downgrade_write(struct rw_semaphore *sem));
 
 #endif /* __KERNEL__ */
 #endif /* _LINUX_RWSEM_SPINLOCK_H */
diff -Nru a/include/linux/rwsem.h b/include/linux/rwsem.h
--- a/include/linux/rwsem.h	Sun Jul 28 21:19:16 2002
+++ b/include/linux/rwsem.h	Sun Jul 28 21:19:16 2002
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
@@ -56,6 +68,18 @@
 }
 
 /*
+ * trylock for writing -- returns 1 if successful, 0 if contention
+ */
+static inline int down_write_trylock(struct rw_semaphore *sem)
+{
+	int ret;
+	rwsemtrace(sem,"Entering down_write_trylock");
+	ret = __down_write_trylock(sem);
+	rwsemtrace(sem,"Leaving down_write_trylock");
+	return ret;
+}
+
+/*
  * release a read lock
  */
 static inline void up_read(struct rw_semaphore *sem)
@@ -84,7 +108,6 @@
 	__downgrade_write(sem);
 	rwsemtrace(sem,"Leaving downgrade_write");
 }
-
 
 #endif /* __KERNEL__ */
 #endif /* _LINUX_RWSEM_H */
diff -Nru a/lib/rwsem-spinlock.c b/lib/rwsem-spinlock.c
--- a/lib/rwsem-spinlock.c	Sun Jul 28 21:19:16 2002
+++ b/lib/rwsem-spinlock.c	Sun Jul 28 21:19:16 2002
@@ -46,8 +46,9 @@
  *   - the 'waiting count' is non-zero
  * - the spinlock must be held by the caller
  * - woken process blocks are discarded from the list after having flags zeroised
+ * - writers are only woken if wakewrite is non-zero
  */
-static inline struct rw_semaphore *__rwsem_do_wake(struct rw_semaphore *sem)
+static inline struct rw_semaphore *__rwsem_do_wake(struct rw_semaphore *sem, int wakewrite)
 {
 	struct rwsem_waiter *waiter;
 	int woken;
@@ -56,7 +57,14 @@
 
 	waiter = list_entry(sem->wait_list.next,struct rwsem_waiter,list);
 
-	/* try to grant a single write lock if there's a writer at the front of the queue
+	if (!wakewrite) {
+		if (waiter->flags & RWSEM_WAITING_FOR_WRITE)
+			goto out;
+		goto dont_wake_writers;
+	}
+
+	/* if we are allowed to wake writers try to grant a single write lock if there's a
+	 * writer at the front of the queue
 	 * - we leave the 'waiting count' incremented to signify potential contention
 	 */
 	if (waiter->flags & RWSEM_WAITING_FOR_WRITE) {
@@ -68,16 +76,19 @@
 	}
 
 	/* grant an infinite number of read locks to the readers at the front of the queue */
+ dont_wake_writers:
 	woken = 0;
-	do {
+	while (waiter->flags&RWSEM_WAITING_FOR_READ) {
+		struct list_head *next = waiter->list.next;
+
 		list_del(&waiter->list);
 		waiter->flags = 0;
 		wake_up_process(waiter->task);
 		woken++;
 		if (list_empty(&sem->wait_list))
 			break;
-		waiter = list_entry(sem->wait_list.next,struct rwsem_waiter,list);
-	} while (waiter->flags&RWSEM_WAITING_FOR_READ);
+		waiter = list_entry(next,struct rwsem_waiter,list);
+	}
 
 	sem->activity += woken;
 
@@ -149,6 +160,28 @@
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
@@ -195,6 +228,28 @@
 }
 
 /*
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
+}
+
+/*
  * release a read lock on the semaphore
  */
 void __up_read(struct rw_semaphore *sem)
@@ -222,18 +277,40 @@
 
 	sem->activity = 0;
 	if (!list_empty(&sem->wait_list))
-		sem = __rwsem_do_wake(sem);
+		sem = __rwsem_do_wake(sem, 1);
 
 	spin_unlock(&sem->wait_lock);
 
 	rwsemtrace(sem,"Leaving __up_write");
 }
 
+/*
+ * downgrade a write lock into a read lock
+ * - just wake up any readers at the front of the queue
+ */
+void __downgrade_write(struct rw_semaphore *sem)
+{
+	rwsemtrace(sem,"Entering __rwsem_downgrade");
+
+	spin_lock(&sem->wait_lock);
+
+	sem->activity = 1;
+	if (!list_empty(&sem->wait_list))
+		sem = __rwsem_do_wake(sem,0);
+
+	spin_unlock(&sem->wait_lock);
+
+	rwsemtrace(sem,"Leaving __rwsem_downgrade");
+}
+
 EXPORT_SYMBOL(init_rwsem);
 EXPORT_SYMBOL(__down_read);
+EXPORT_SYMBOL(__down_read_trylock);
 EXPORT_SYMBOL(__down_write);
+EXPORT_SYMBOL(__down_write_trylock);
 EXPORT_SYMBOL(__up_read);
 EXPORT_SYMBOL(__up_write);
+EXPORT_SYMBOL(__downgrade_write);
 #if RWSEM_DEBUG
 EXPORT_SYMBOL(rwsemtrace);
 #endif

===================================================================


This BitKeeper patch contains the following changesets:
1.477
## Wrapped with gzip_uu ##


begin 664 bkpatch9967
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
-W/.T?P%XL2Z'3AL`````
`
end
