Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317068AbSG1SFs>; Sun, 28 Jul 2002 14:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317096AbSG1SFs>; Sun, 28 Jul 2002 14:05:48 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:13317 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317068AbSG1SFj>; Sun, 28 Jul 2002 14:05:39 -0400
Date: Sun, 28 Jul 2002 19:08:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.5.29 __downgrade_write() for CONFIG_RWSEM_GENERIC_SPINLOCK
Message-ID: <20020728190851.A14392@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Adam J. Richter" <adam@yggdrasil.com>, dhowells@redhat.com,
	linux-kernel@vger.kernel.org
References: <200207281750.KAA19369@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200207281750.KAA19369@baldur.yggdrasil.com>; from adam@yggdrasil.com on Sun, Jul 28, 2002 at 10:50:58AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 10:50:58AM -0700, Adam J. Richter wrote:
> 	linux-2.5.29 lacks __downgrade_write() platforms that use
> CONFIG_RWSEM_GENERIC_SPINLOCK, such as i386 (as opposed to later x86
> processors).  This causes a compiler warnings for compilations
> of numerous files.

It was part of the patch I sent to David.  In fact that was the first
implementation of it at all..

The full patch I sent around is attached as reference.


Index: include/asm-i386/rwsem.h
===================================================================
RCS file: /cvs/linux-2.4-xfs/linux/include/asm-i386/rwsem.h,v
retrieving revision 1.3
diff -u -p -r1.3 rwsem.h
--- include/asm-i386/rwsem.h	2002/05/29 22:20:17	1.3
+++ include/asm-i386/rwsem.h	2002/07/28 10:07:35
@@ -46,6 +46,7 @@ struct rwsem_waiter;
 extern struct rw_semaphore *FASTCALL(rwsem_down_read_failed(struct rw_semaphore *sem));
 extern struct rw_semaphore *FASTCALL(rwsem_down_write_failed(struct rw_semaphore *sem));
 extern struct rw_semaphore *FASTCALL(rwsem_wake(struct rw_semaphore *));
+extern struct rw_semaphore *FASTCALL(rwsem_downgrade_write(struct rw_semaphore *sem));
 
 /*
  * the semaphore definition
@@ -117,6 +118,29 @@ LOCK_PREFIX	"  incl      (%%eax)\n\t" /*
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
@@ -144,6 +168,19 @@ LOCK_PREFIX	"  xadd      %0,(%%eax)\n\t"
 }
 
 /*
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
+}
+
+/*
  * unlock after reading
  */
 static inline void __up_read(struct rw_semaphore *sem)
@@ -184,6 +221,7 @@ LOCK_PREFIX	"  xaddl     %%edx,(%%eax)\n
 		"2:\n\t"
 		"  decw      %%dx\n\t" /* did the active count reduce to 0? */
 		"  jnz       1b\n\t" /* jump back if not */
+		"  pushl     $1\n\t"
 		"  pushl     %%ecx\n\t"
 		"  call      rwsem_wake\n\t"
 		"  popl      %%ecx\n\t"
@@ -194,6 +232,35 @@ LOCK_PREFIX	"  xaddl     %%edx,(%%eax)\n
 		: "a"(sem), "i"(-RWSEM_ACTIVE_WRITE_BIAS)
 		: "memory", "cc", "edx");
 }
+
+/*
+ * downgrade write lock to read lock
+ */
+static inline void __downgrade_write(struct rw_semaphore *sem)
+{
+	__asm__ __volatile__(
+		"# beginning __downgrade_write\n\t"
+LOCK_PREFIX	"  addl      %2,(%%eax)\n\t" /* transitions 0xZZZZ0001 -> 0xYYYY0001 */
+		"  js        2f\n\t" /* jump if the lock is being waited upon */
+		"1:\n\t"
+		LOCK_SECTION_START("")
+		"2:\n\t"
+		"  pushl     %%ecx\n\t"
+		"  pushl     %%edx\n\t"
+		"  call      rwsem_downgrade_wake\n\t"
+		"  popl      %%edx\n\t"
+		"  popl      %%ecx\n\t"
+		"  jmp       1b\n"
+		LOCK_SECTION_END
+		"# ending __downgrade_write\n"
+		: "=m"(sem->count)
+		: "a"(sem), "i"(-RWSEM_WAITING_BIAS), "m"(sem->count)
+		: "memory", "cc");
+}
+
+/*
+ * implement atomic add functionality
+ */
 
 /*
  * implement atomic add functionality
Index: include/linux/rwsem-spinlock.h
===================================================================
RCS file: /cvs/linux-2.4-xfs/linux/include/linux/rwsem-spinlock.h,v
retrieving revision 1.2
diff -u -p -r1.2 rwsem-spinlock.h
--- include/linux/rwsem-spinlock.h	2001/05/29 19:53:13	1.2
+++ include/linux/rwsem-spinlock.h	2002/07/28 10:07:37
@@ -54,9 +54,12 @@ struct rw_semaphore {
 
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
Index: include/linux/rwsem.h
===================================================================
RCS file: /cvs/linux-2.4-xfs/linux/include/linux/rwsem.h,v
retrieving revision 1.2
diff -u -p -r1.2 rwsem.h
--- include/linux/rwsem.h	2001/05/29 19:53:13	1.2
+++ include/linux/rwsem.h	2002/07/28 10:07:37
@@ -46,6 +46,18 @@ static inline void down_read(struct rw_s
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
@@ -56,6 +68,18 @@ static inline void down_write(struct rw_
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
@@ -73,6 +97,16 @@ static inline void up_write(struct rw_se
 	rwsemtrace(sem,"Entering up_write");
 	__up_write(sem);
 	rwsemtrace(sem,"Leaving up_write");
+}
+
+/*
+ * downgrade write lock to read lock
+ */
+static inline void downgrade_write(struct rw_semaphore *sem)
+{
+	rwsemtrace(sem,"Entering downgrade_write");
+	__downgrade_write(sem);
+	rwsemtrace(sem,"Leaving downgrade_write");
 }
 
 
Index: lib/rwsem-spinlock.c
===================================================================
RCS file: /cvs/linux-2.4-xfs/linux/lib/rwsem-spinlock.c,v
retrieving revision 1.1
diff -u -p -r1.1 rwsem-spinlock.c
--- lib/rwsem-spinlock.c	2001/05/02 06:22:13	1.1
+++ lib/rwsem-spinlock.c	2002/07/28 10:07:37
@@ -46,8 +46,9 @@ void init_rwsem(struct rw_semaphore *sem
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
@@ -56,7 +57,14 @@ static inline struct rw_semaphore *__rws
 
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
@@ -68,16 +76,19 @@ static inline struct rw_semaphore *__rws
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
 
@@ -149,6 +160,28 @@ void __down_read(struct rw_semaphore *se
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
@@ -195,6 +228,28 @@ void __down_write(struct rw_semaphore *s
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
@@ -222,18 +277,40 @@ void __up_write(struct rw_semaphore *sem
 
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
Index: lib/rwsem.c
===================================================================
RCS file: /cvs/linux-2.4-xfs/linux/lib/rwsem.c,v
retrieving revision 1.2
diff -u -p -r1.2 rwsem.c
--- lib/rwsem.c	2001/07/11 17:53:24	1.2
+++ lib/rwsem.c	2002/07/28 10:07:37
@@ -34,8 +34,9 @@ void rwsemtrace(struct rw_semaphore *sem
  *   - there must be someone on the queue
  * - the spinlock must be held by the caller
  * - woken process blocks are discarded from the list after having flags zeroised
+ * - writers are only woken if wakewrite is non-zero
  */
-static inline struct rw_semaphore *__rwsem_do_wake(struct rw_semaphore *sem)
+static inline struct rw_semaphore *__rwsem_do_wake(struct rw_semaphore *sem, int wakewrite)
 {
 	struct rwsem_waiter *waiter;
 	struct list_head *next;
@@ -44,6 +45,9 @@ static inline struct rw_semaphore *__rws
 
 	rwsemtrace(sem,"Entering __rwsem_do_wake");
 
+	if (!wakewrite)
+		goto dont_wake_writers;
+
 	/* only wake someone up if we can transition the active part of the count from 0 -> 1 */
  try_again:
 	oldcount = rwsem_atomic_update(RWSEM_ACTIVE_BIAS,sem) - RWSEM_ACTIVE_BIAS;
@@ -64,6 +68,12 @@ static inline struct rw_semaphore *__rws
 	wake_up_process(waiter->task);
 	goto out;
 
+	/* don't want to wake any writers */
+ dont_wake_writers:
+	waiter = list_entry(sem->wait_list.next,struct rwsem_waiter,list);
+	if (waiter->flags & RWSEM_WAITING_FOR_WRITE)
+		goto out;
+
 	/* grant an infinite number of read locks to the readers at the front of the queue
 	 * - note we increment the 'active part' of the count by the number of readers (less one
 	 *   for the activity decrement we've already done) before waking any processes up
@@ -132,7 +142,7 @@ static inline struct rw_semaphore *rwsem
 	 * - it might even be this process, since the waker takes a more active part
 	 */
 	if (!(count & RWSEM_ACTIVE_MASK))
-		sem = __rwsem_do_wake(sem);
+		sem = __rwsem_do_wake(sem,1);
 
 	spin_unlock(&sem->wait_lock);
 
@@ -193,7 +203,7 @@ struct rw_semaphore *rwsem_wake(struct r
 
 	/* do nothing if list empty */
 	if (!list_empty(&sem->wait_list))
-		sem = __rwsem_do_wake(sem);
+		sem = __rwsem_do_wake(sem,1);
 
 	spin_unlock(&sem->wait_lock);
 
@@ -202,9 +212,31 @@ struct rw_semaphore *rwsem_wake(struct r
 	return sem;
 }
 
+/*
+ * downgrade a write lock into a read lock
+ * - caller incremented waiting part of count, and discovered it to be still negative
+ * - just wake up any readers at the front of the queue
+ */
+struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
+{
+	rwsemtrace(sem,"Entering rwsem_downgrade_wake");
+
+	spin_lock(&sem->wait_lock);
+
+	/* do nothing if list empty */
+	if (!list_empty(&sem->wait_list))
+		sem = __rwsem_do_wake(sem,0);
+
+	spin_unlock(&sem->wait_lock);
+
+	rwsemtrace(sem,"Leaving rwsem_downgrade_wake");
+	return sem;
+}
+
 EXPORT_SYMBOL_NOVERS(rwsem_down_read_failed);
 EXPORT_SYMBOL_NOVERS(rwsem_down_write_failed);
 EXPORT_SYMBOL_NOVERS(rwsem_wake);
+EXPORT_SYMBOL_NOVERS(rwsem_downgrade_wake);
 #if RWSEM_DEBUG
 EXPORT_SYMBOL(rwsemtrace);
 #endif
