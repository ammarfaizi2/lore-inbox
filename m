Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130553AbQKDFHn>; Sat, 4 Nov 2000 00:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131697AbQKDFHe>; Sat, 4 Nov 2000 00:07:34 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:41974 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129353AbQKDFHN>; Sat, 4 Nov 2000 00:07:13 -0500
Message-ID: <3A039978.939DC41C@uow.edu.au>
Date: Sat, 04 Nov 2000 16:07:04 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: kumon@flab.fujitsu.co.jp
CC: linux-kernel@vger.kernel.org,
        dean gaudet <dean-list-linux-kernel@arctic.org>
Subject: Re: [PATCH] Re: Negative scalability by removal of lock_kernel()?(Was: 
 Strange performance behavior of 2.4.0-test9)
In-Reply-To: <39FEE701.CAC21AE5@uow.edu.au>,
					<39F957BC.4289FF10@uow.edu.au>
					<39F92187.A7621A09@timpanogas.org>
					<Pine.GSO.4.21.0010270257550.18660-100000@weyl.math.psu.edu>
					<20001027094613.A18382@gruyere.muc.suse.de>
					<200010271257.VAA24374@asami.proc.flab.fujitsu.co.jp>
					<39FEE701.CAC21AE5@uow.edu.au> <200011021109.UAA24021@asami.proc.flab.fujitsu.co.jp>
Content-Type: multipart/mixed;
 boundary="------------61C81DFEA7CAC54F95C02656"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------61C81DFEA7CAC54F95C02656
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

kumon@flab.fujitsu.co.jp wrote:
> 
> Andrew Morton writes:
>  > This patch is a moderate rewrite of __wake_up_common.  I'd be
>  > interested in seeing how much difference it makes to the
>  > performance of Apache when the file-locking serialisation is
>  > disabled.
>  > - It implements last-in/first-out semantics for waking
>  >   TASK_EXCLUSIVE tasks.
>  > - It fixes what was surely a bug wherein __wake_up_common
>  >   scans the entire wait queue even when it has found the
>  >   task which it wants to run.
> 
> We've measured Apache w/ and w/o serialize_accept on
> several kernel configurations.
> 
> Apache compilation settings are those two:
>         * without option (conventional setting)
>           (w/ serialize)
>         * with -DSINGLE_LISTEN_UNSERIALIZED_ACCEPT
>           (w/o serialize)
> 
> We compared the performance of distributed binary and our binary with
> default setting, the performance is almost equivalent. All following
> data are based on our binaries.
> 
>                         w/ serialize    w/o serialize
> 2.40-t10-pre5           2237            5358
> 2.40-t10-pre5+P2        5253            5355**
> 2.40-t10-pre5+P3        ---             NG
> 
> ** with this configuration, once we observed the machine completely
> deadlocked with the following message:
> 
> Unable to handle kernel NULL pointer dereferenceNMI watchdog detected LOCKUP on CPU1.

That's not good.  `P2' just puts a couple of lock_kernel's into
the file locking code, and apache wasn't using that code when
your machine died.  So it looks like dropping the serialisation
has tickled a problem in test10-pre5.

> 
> 2.4.0-test10-pre5 with the LIFO patch (P3), we can't get the values.
> It always deadlock with same manner.  Perhaps, it failed to get
> console lock then deadlock.

mm..  Relying on the task_struct.state value in __wake_up_common() is
tricky - I guess you hit some races.  Sorry.  I ended up having to
rewrite the guts of the waitqueue and wakeup code to be able to
reliably avoid scanning the entire wait queue every time we wake an
exclusive task.

There are two patches attached here.

flock.patch: this simply puts the lock_kernel calls around the
file locking code.  We already have figures for that (it doubles
Apache's connection rate on uniprocessor, but it's still
_terrible_ when you have 100 servers).

task_exclusive.patch:  this is a redesign of the current waitqueue
and wakeup code.  Again, it provides LIFO handling of exclusive
tasks and avoids a scan of the entire waitqueue.  Hopefully it won't
lock up your machine this time!

I'd be interested in seeing the results on both serialised and
unserialised Apache when these are applied, please.

Here are my numbers.  This is with
httperf --num-conns=2000 --num-calls=1 --uri=/index.html
Basically, there's not a lot of difference here because
the test machine only has 2 CPUs.

   #Servers            unpatched       patched
                       conn/sec        conn/sec

2xCPU, serialised

    3                     938.0         956.2
    10                                  943.2
    30                    697.1         737.9
    150                   99.9          196.2            (sic)

2xCPU, unserialised

    3                     1049.0        1117.4
    10                     968.8        1118.6
    30                    1040.2        1105.6
    150                   1091.4        1077.1
--------------61C81DFEA7CAC54F95C02656
Content-Type: text/plain; charset=us-ascii;
 name="flock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="flock.patch"

--- linux-2.4.0-test10-pre5/fs/fcntl.c	Sun Oct 15 01:27:45 2000
+++ linux-akpm/fs/fcntl.c	Fri Nov  3 20:42:47 2000
@@ -254,11 +254,15 @@
 			unlock_kernel();
 			break;
 		case F_GETLK:
+			lock_kernel();
 			err = fcntl_getlk(fd, (struct flock *) arg);
+			unlock_kernel();
 			break;
 		case F_SETLK:
 		case F_SETLKW:
+			lock_kernel();
 			err = fcntl_setlk(fd, cmd, (struct flock *) arg);
+			unlock_kernel();
 			break;
 		case F_GETOWN:
 			/*




--------------61C81DFEA7CAC54F95C02656
Content-Type: text/plain; charset=us-ascii;
 name="task_exclusive.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="task_exclusive.patch"

--- linux-2.4.0-test10-pre5/include/linux/wait.h	Sun Oct 15 01:27:46 2000
+++ linux-akpm/include/linux/wait.h	Fri Nov  3 21:14:30 2000
@@ -14,45 +14,24 @@
 #include <linux/list.h>
 #include <linux/stddef.h>
 #include <linux/spinlock.h>
+#include <linux/cache.h>
 
 #include <asm/page.h>
 #include <asm/processor.h>
 
 /*
- * Temporary debugging help until all code is converted to the new
- * waitqueue usage.
+ * Debugging control.  Slow and useful.
  */
 #define WAITQUEUE_DEBUG 0
 
-#if WAITQUEUE_DEBUG
-extern int printk(const char *fmt, ...);
-#define WQ_BUG() do { \
-	printk("wq bug, forcing oops.\n"); \
-	BUG(); \
-} while (0)
-
-#define CHECK_MAGIC(x) if (x != (long)&(x)) \
-	{ printk("bad magic %lx (should be %lx), ", (long)x, (long)&(x)); WQ_BUG(); }
-
-#define CHECK_MAGIC_WQHEAD(x) do { \
-	if (x->__magic != (long)&(x->__magic)) { \
-		printk("bad magic %lx (should be %lx, creator %lx), ", \
-			x->__magic, (long)&(x->__magic), x->__creator); \
-		WQ_BUG(); \
-	} \
-} while (0)
-#endif
-
-struct __wait_queue {
-	unsigned int compiler_warning;
-	struct task_struct * task;
-	struct list_head task_list;
-#if WAITQUEUE_DEBUG
-	long __magic;
-	long __waker;
+/*
+ * Used for ifdef reduction
+ */
+#ifdef CONFIG_SMP
+# define WQ_SMP	1
+#else
+# define WQ_SMP	0
 #endif
-};
-typedef struct __wait_queue wait_queue_t;
 
 /*
  * 'dual' spinlock architecture. Can be switched between spinlock_t and
@@ -88,38 +67,105 @@
 # define wq_write_unlock spin_unlock
 #endif
 
+/*
+ * Data types
+ */
+
+struct __wait_queue {
+	struct task_struct * task;
+	struct list_head tasklist;
+#if WAITQUEUE_DEBUG
+	long __magic;
+	long __waker;
+#endif
+} ____cacheline_aligned;
+typedef struct __wait_queue wait_queue_t;
+
 struct __wait_queue_head {
 	wq_lock_t lock;
-	struct list_head task_list;
+	struct list_head tasklist;
+	struct list_head separator;
 #if WAITQUEUE_DEBUG
 	long __magic;
 	long __creator;
 #endif
-};
+} ____cacheline_aligned;
 typedef struct __wait_queue_head wait_queue_head_t;
 
+/*
+ * Debugging macros.  We eschew `do { } while (0)' because gcc can generate
+ * spurious .aligns.
+ */
 #if WAITQUEUE_DEBUG
-# define __WAITQUEUE_DEBUG_INIT(name) \
-		, (long)&(name).__magic, 0
-# define __WAITQUEUE_HEAD_DEBUG_INIT(name) \
-		, (long)&(name).__magic, (long)&(name).__magic
+#define WQ_BUG()	BUG()
+#define CHECK_MAGIC(x)								\
+	do {									\
+		if ((x) != (long)&(x)) {					\
+			printk("bad magic %lx (should be %lx), ",		\
+				(long)x, (long)&(x));				\
+			WQ_BUG();						\
+		}								\
+	} while (0)
+#define CHECK_MAGIC_WQHEAD(x)							\
+	do {									\
+		if ((x)->__magic != (long)&((x)->__magic)) {			\
+			printk("bad magic %lx (should be %lx, creator %lx), ",	\
+			(x)->__magic, (long)&((x)->__magic), (x)->__creator);	\
+			WQ_BUG();						\
+		}								\
+	} while (0)
+#define WQ_CHECK_LIST_HEAD(list) 						\
+	do {									\
+		if (!list->next || !list->prev)					\
+			WQ_BUG();						\
+	} while(0)
+#define WQ_NOTE_WAKER(tsk)							\
+	do {									\
+		tsk->__waker = (long)__builtin_return_address(0);		\
+	} while (0)
+#else
+#define WQ_BUG()
+#define CHECK_MAGIC(x)
+#define CHECK_MAGIC_WQHEAD(x)
+#define WQ_CHECK_LIST_HEAD(list)
+#define WQ_NOTE_WAKER(tsk)
+#define check_wq_sanity(q)
+#endif
+
+/*
+ * Macros for declaration and initialisaton of the datatypes
+ */
+
+#if WAITQUEUE_DEBUG
+# define __WAITQUEUE_DEBUG_INIT(name) (long)&(name).__magic, 0
+# define __WAITQUEUE_HEAD_DEBUG_INIT(name) (long)&(name).__magic, (long)&(name).__magic
 #else
 # define __WAITQUEUE_DEBUG_INIT(name)
 # define __WAITQUEUE_HEAD_DEBUG_INIT(name)
 #endif
 
-#define __WAITQUEUE_INITIALIZER(name,task) \
-	{ 0x1234567, task, { NULL, NULL } __WAITQUEUE_DEBUG_INIT(name)}
-#define DECLARE_WAITQUEUE(name,task) \
-	wait_queue_t name = __WAITQUEUE_INITIALIZER(name,task)
-
-#define __WAIT_QUEUE_HEAD_INITIALIZER(name) \
-{ WAITQUEUE_RW_LOCK_UNLOCKED, { &(name).task_list, &(name).task_list } \
-		__WAITQUEUE_HEAD_DEBUG_INIT(name)}
+#define __WAITQUEUE_INITIALIZER(name, tsk) {				\
+	task:		tsk,						\
+	tasklist:	{ NULL, NULL },					\
+			 __WAITQUEUE_DEBUG_INIT(name)}
+
+#define DECLARE_WAITQUEUE(name, tsk)					\
+	wait_queue_t name = __WAITQUEUE_INITIALIZER(name, tsk)
+
+#define __WAIT_QUEUE_HEAD_INITIALIZER(name) {				\
+	lock:		WAITQUEUE_RW_LOCK_UNLOCKED,			\
+	tasklist:	{ &(name).separator, &(name).separator },	\
+	separator:	{ &(name).tasklist, &(name).tasklist },		\
+			__WAITQUEUE_HEAD_DEBUG_INIT(name)}
 
 #define DECLARE_WAIT_QUEUE_HEAD(name) \
 	wait_queue_head_t name = __WAIT_QUEUE_HEAD_INITIALIZER(name)
 
+
+/*
+ * Inline functions
+ */
+
 static inline void init_waitqueue_head(wait_queue_head_t *q)
 {
 #if WAITQUEUE_DEBUG
@@ -127,7 +173,10 @@
 		WQ_BUG();
 #endif
 	q->lock = WAITQUEUE_RW_LOCK_UNLOCKED;
-	INIT_LIST_HEAD(&q->task_list);
+	q->tasklist.next = &q->separator;
+	q->tasklist.prev = &q->separator;
+	q->separator.next = &q->tasklist;
+	q->separator.prev = &q->tasklist;
 #if WAITQUEUE_DEBUG
 	q->__magic = (long)&q->__magic;
 	q->__creator = (long)current_text_addr();
@@ -155,7 +204,7 @@
 	CHECK_MAGIC_WQHEAD(q);
 #endif
 
-	return !list_empty(&q->task_list);
+	return q->tasklist.next != q->tasklist.prev;
 }
 
 static inline void __add_wait_queue(wait_queue_head_t *head, wait_queue_t *new)
@@ -165,10 +214,12 @@
 		WQ_BUG();
 	CHECK_MAGIC_WQHEAD(head);
 	CHECK_MAGIC(new->__magic);
-	if (!head->task_list.next || !head->task_list.prev)
+	if (!head->tasklist.next || !head->tasklist.prev)
+		WQ_BUG();
+	if (!head->separator.next || !head->separator.prev)
 		WQ_BUG();
 #endif
-	list_add(&new->task_list, &head->task_list);
+	list_add(&new->tasklist, &head->tasklist);
 }
 
 /*
@@ -182,10 +233,12 @@
 		WQ_BUG();
 	CHECK_MAGIC_WQHEAD(head);
 	CHECK_MAGIC(new->__magic);
-	if (!head->task_list.next || !head->task_list.prev)
+	if (!head->tasklist.next || !head->tasklist.prev)
+		WQ_BUG();
+	if (!head->separator.next || !head->separator.prev)
 		WQ_BUG();
 #endif
-	list_add_tail(&new->task_list, &head->task_list);
+	list_add_tail(&new->tasklist, &head->tasklist);
 }
 
 static inline void __remove_wait_queue(wait_queue_head_t *head,
@@ -196,7 +249,8 @@
 		WQ_BUG();
 	CHECK_MAGIC(old->__magic);
 #endif
-	list_del(&old->task_list);
+	list_del(&old->tasklist);
+	old->task = 0;			/* AKPM: this is temporary */
 }
 
 #endif /* __KERNEL__ */
--- linux-2.4.0-test10-pre5/kernel/sched.c	Sun Oct 15 01:27:46 2000
+++ linux-akpm/kernel/sched.c	Fri Nov  3 20:26:23 2000
@@ -697,78 +697,166 @@
 	return;
 }
 
+#if WAITQUEUE_DEBUG
+static void dump_wq(wait_queue_head_t *q)
+{
+	struct list_head *probe, *head, *separator;
+	int i = 0;
+
+	head = &q->tasklist;
+	separator = &q->separator;
+	probe = head->next;
+	while (probe != head) {
+		if (probe == separator) {
+			printk("%d: separator\n", i);
+		} else {
+			wait_queue_t *curr = list_entry(probe, wait_queue_t, tasklist);
+			struct task_struct *tsk = curr->task;
+			printk("%d: pid=%d, state=0x%lx\n", i, tsk->pid, tsk->state);
+		}
+		probe = probe->next;
+		i++;
+	}
+}
+
+/*
+ * Check that the wait queue is in the correct order:
+ *  !TASK_EXCLUSIVE at the head
+ *  TASK_EXCLUSIVE at the tail
+ *  We know that the list is locked.
+ *  This function generates bogus results because of harmless races elsewhere.
+ */
+
+static void check_wq_sanity(wait_queue_head_t *q)
+{
+	struct list_head *probe, *head, *separator;
+
+	head = &q->tasklist;
+	separator = &q->separator;
+	probe = head->next;
+	while (probe != head) {
+		if (probe != separator) {
+			wait_queue_t *curr = list_entry(probe, wait_queue_t, tasklist);
+			if (curr->task->state & TASK_EXCLUSIVE)
+				break;
+		}
+		probe = probe->next;
+	}
+	while (probe != head) {
+		if (probe != separator) {
+			wait_queue_t *curr = list_entry(probe, wait_queue_t, tasklist);
+			if (!(curr->task->state & TASK_EXCLUSIVE)) {
+				printk("check_wq_sanity: mangled wait queue\n");
+#ifdef CONFIG_X86
+				show_stack(0);
+#endif
+				dump_wq(q);
+			}
+		}
+		probe = probe->next;
+	}
+}
+#endif	/* WAITQUEUE_DEBUG */
+	
+/*
+ * Wake up some tasks which are on *q.
+ *
+ * All tasks which are non-exclusive are woken.
+ * Only one exclusive task is woken.
+ * The non-eclusive tasks start at q->tasklist.next and end at q->separator
+ * The exclusive tasks start at q->tasklist.prev and end at q->separator
+ *
+ * When waking an exclusive task we search backward,
+ * so we find the most-recently-added task (it will have the
+ * hottest cache)
+ */
+
 static inline void __wake_up_common (wait_queue_head_t *q, unsigned int mode,
 						const int sync)
 {
-	struct list_head *tmp, *head;
-	struct task_struct *p, *best_exclusive;
+	struct list_head *tmp, *head, *separator;
+	struct task_struct *p;
 	unsigned long flags;
 	int best_cpu, irq;
+	unsigned int exclusive_mode;
 
         if (!q)
 		goto out;
 
-	best_cpu = smp_processor_id();
-	irq = in_interrupt();
-	best_exclusive = NULL;
+	if (WQ_SMP) {
+		best_cpu = smp_processor_id();
+		irq = in_interrupt();
+	}
+	exclusive_mode = mode & TASK_EXCLUSIVE;
+	mode &= ~TASK_EXCLUSIVE;
+
 	wq_write_lock_irqsave(&q->lock, flags);
 
-#if WAITQUEUE_DEBUG
+	check_wq_sanity(q);
 	CHECK_MAGIC_WQHEAD(q);
-#endif
 
-	head = &q->task_list;
-#if WAITQUEUE_DEBUG
-        if (!head->next || !head->prev)
-                WQ_BUG();
-#endif
+	head = &q->tasklist;
+	separator = &q->separator;
+	WQ_CHECK_LIST_HEAD(head);
+
+	/*
+	 * Wake all the !TASK_EXCLUSIVE tasks 
+	 */
 	tmp = head->next;
-	while (tmp != head) {
-		unsigned int state;
-                wait_queue_t *curr = list_entry(tmp, wait_queue_t, task_list);
+	while (tmp != separator) {
+                wait_queue_t *curr = list_entry(tmp, wait_queue_t, tasklist);
 
 		tmp = tmp->next;
+		CHECK_MAGIC(curr->__magic);
+		p = curr->task;
+		if (p->state & mode) {
+			WQ_NOTE_WAKER(curr);
+			if (sync)
+				wake_up_process_synchronous(p);
+			else
+				wake_up_process(p);
+		}
+	}
 
-#if WAITQUEUE_DEBUG
+	/*
+	 * If (mode & TASK_EXCLUSIVE) we wake one exclusive task.
+	 * If !(mode & TASK_EXCLUSIVE) we wake all exclusive tasks.
+	 *
+	 * If waking up exclusively from an interrupt context then
+	 * prefer tasks which are affine to this CPU.
+	 * If we can't find an affine task then wake up the
+	 * least-recently queued one.
+	 */
+	tmp = head->prev;
+	while (tmp != separator) {
+                wait_queue_t *curr = list_entry(tmp, wait_queue_t, tasklist);
+
+		tmp = tmp->prev;
 		CHECK_MAGIC(curr->__magic);
-#endif
 		p = curr->task;
-		state = p->state;
-		if (state & (mode & ~TASK_EXCLUSIVE)) {
-#if WAITQUEUE_DEBUG
-			curr->__waker = (long)__builtin_return_address(0);
-#endif
-			/*
-			 * If waking up from an interrupt context then
-			 * prefer processes which are affine to this
-			 * CPU.
-			 */
-			if (irq && (state & mode & TASK_EXCLUSIVE)) {
-				if (!best_exclusive)
-					best_exclusive = p;
-				else if ((p->processor == best_cpu) &&
-					(best_exclusive->processor != best_cpu))
-						best_exclusive = p;
+		if (p->state & mode) {
+			struct task_struct *to_wake = NULL;
+
+			if (WQ_SMP && exclusive_mode && irq) {
+				if (p->processor == best_cpu || tmp == separator)
+					to_wake = p;
 			} else {
+				to_wake = p;
+			}
+
+			if (to_wake) {
 				if (sync)
-					wake_up_process_synchronous(p);
+					wake_up_process_synchronous(to_wake);
 				else
-					wake_up_process(p);
-				if (state & mode & TASK_EXCLUSIVE)
+					wake_up_process(to_wake);
+
+				if (exclusive_mode)
 					break;
 			}
 		}
 	}
-	if (best_exclusive)
-		best_exclusive->state = TASK_RUNNING;
-	wq_write_unlock_irqrestore(&q->lock, flags);
 
-	if (best_exclusive) {
-		if (sync)
-			wake_up_process_synchronous(best_exclusive);
-		else
-			wake_up_process(best_exclusive);
-	}
+	wq_write_unlock_irqrestore(&q->lock, flags);
 out:
 	return;
 }




--------------61C81DFEA7CAC54F95C02656--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
