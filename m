Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290593AbSBGPkc>; Thu, 7 Feb 2002 10:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289646AbSBGPkY>; Thu, 7 Feb 2002 10:40:24 -0500
Received: from gw.sp.op.dlr.de ([129.247.188.16]:49583 "EHLO n13.sp.op.dlr.de")
	by vger.kernel.org with ESMTP id <S289581AbSBGPkI>;
	Thu, 7 Feb 2002 10:40:08 -0500
Message-ID: <3C629F91.2869CB1F@dlr.de>
Date: Thu, 07 Feb 2002 16:38:57 +0100
From: Martin Wirth <Martin.Wirth@dlr.de>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akpm@zip.com.au, torvalds@transmet.com, mingo@elte.hu, rml@tech9.net,
        nigel@nrg.org
Subject: [RFC] New locking primitive for 2.5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a request for comment on a new locking primitive
called a combilock.

The goal of this development is:

1. To allow for a better SMP scalability of semaphores used as Mutex
2. As a replacement for long held spinlocks in an preemptible kernel

The new lock uses a combination of a spinlock and a (mutex-)semaphore.
You can lock it for short-term issues in a spin-lock mode:

        combi_spin_lock(struct combilock *x)
        combi_spin_unlock(struct combilock *x)

and for longer lasting tasks in a sleeping mode by:

        combi_mutex_lock(struct combilock *x)
        combi_mutex_unlock(struct combilock *x)

If a spin_lock request is blocked by a mutex_lock call, the spin_lock
attempt also sleeps i.e. behaves like a semaphore.
If you gained ownership of the lock, you can switch between spin-mode
and mutex-(ie.e sleeping) mode by calling:

        combi_to_mutex_mode(struct combilock *x)
        combi_to_spin_mode(struct combilock *x)

without loosing the lock. So you may start with a spin-lock and relax
to a sleeping lock if for example you need to call a non-atomic kmalloc.

This approach is less automatic than a first_spin_then_sleep mutex,
but normally the programmer knows better if he is going to do quick
things, or maybe unbounded stuff.



Note: For a preemptible kernel this approach could lead to much less
scheduling ping-pong also for UP if a spinlock is replaced by a
combilock instead of a semaphore.


Limitations:
  1. In the current implementation the combilock is not irq-save

  2. Although the combilock shares some advantages with a
  spin-lock (no unnecessary scheduling for short time locking) it may
  behave like a semaphore on entry also if you call combi_spin_lock.
  For example

        spin_lock(&slock);
        combi_spin_lock(&clock);

  is a BUG because combi_spin_lock may sleep while holding slock!


Open questions:

  * Does it make sense to also provide irq-save versions of the
    locking functions? This means you could use the unlock functions
    from interrupt context. But the main use in this situation is
    completion handling and there are already (new) completion handlers
    available. So I don't think this is a must have.

  * I there any need to provide non exclusive versions of the waiting
    functions? For real-time applications this would lead to an
    automatic selection of the highest priority task that's waiting
    for the lock. But on the other hand it leads to a lot of unnecessary
    scheduling and I doubt it's really worth it. But maybe there are
    other good reasons to wakeup all waiters.

Possible optimizations:

    If a further extension to a priority inheritance scheme is discarded
    the owner may be replace by a simple flag. And if this is done,
    one possibly could group together the owner flag and the waitqueue
    spinlock to a single 3-state lock. But on architectures without a
    cmpxchg command this may give no real performance win. And also on
    i386 this would need a tweaking of the waitqueue code.

To really take any benefit from a preemptible kernel a lot of spin locks
will have to be replaced by mutex locks. The combi-lock approach may
convince more people who typically fear the higher scheduling pressure
of sleeping locks to do so, if they can decide on each instance which
approach (spin of sleep) will be taken.



Here comes the code:

diff -ruP linux-2.5.3/include/linux/combilock.h
linux/include/linux/combilock.h
--- linux-2.5.3/include/linux/combilock.h	Thu Jan  1 01:00:00 1970
+++ linux/include/linux/combilock.h	Wed Feb  6 14:09:23 2002
@@ -0,0 +1,86 @@
+#ifndef __LINUX_COMBILOCK_H
+#define __LINUX_COMBILOCK_H
+
+/*
+* combilock data structure.
+* See kernel/sched.c for details.
+*/
+
+
+#include <linux/wait.h>
+#include <asm/current.h>
+
+struct combilock {
+	struct task_struct volatile   *owner;
+	wait_queue_head_t             wait;
+};
+
+#define COMBILOCK_INITIALIZER(work) \
+	{ NULL, __WAIT_QUEUE_HEAD_INITIALIZER((work).wait) }
+
+#define DECLARE_COMBILOCK(work) \
+	struct combilock work = COMBILOCK_INITIALIZER(work)
+
+static inline void init_combilock(struct combilock *x)
+{
+	x->owner = NULL;
+	init_waitqueue_head(&x->wait);
+}
+
+extern int  FASTCALL(combi_mutex_trylock(struct combilock *x));
+extern void FASTCALL(combi_mutex_lock(struct combilock *x));
+extern int  FASTCALL(combi_mutex_lock_interruptible(struct combilock
*x));
+extern void FASTCALL(combi_mutex_unlock(struct combilock *x));
+extern void FASTCALL(__combi_wait(struct combilock *x));
+
+static inline struct task_struct volatile *combi_owner(struct combilock
*x)
+{
+	return x->owner;
+}
+
+static inline void combi_spin_lock(struct combilock *x)
+{
+	spin_lock(&x->wait.lock);
+	if (unlikely(x->owner))
+		__combi_wait(x);
+}
+
+static inline int combi_spin_trylock(struct combilock *x)
+{
+	if (unlikely(spin_trylock(&x->wait.lock)))
+		return 1;
+	if (unlikely(x->owner))
+		__combi_wait(x);
+	return 0;
+}
+
+static inline void combi_spin_unlock(struct combilock *x)
+{
+	spin_unlock(&x->wait.lock);
+}
+
+static inline void combi_to_mutex_mode(struct combilock *x)
+{
+	if (likely(!x->owner)) {
+		x->owner=current;
+		spin_unlock(&x->wait.lock);
+	}
+}
+
+static inline void combi_to_spin_mode(struct combilock *x)
+{
+	if (likely(x->owner)) {
+		spin_lock(&x->wait.lock);
+		x->owner=NULL;
+	}
+}
+
+static inline void combi_generic_unlock(struct combilock *x)
+{
+	if (likely(!x->owner))
+		combi_spin_unlock(x);
+	else
+		combi_mutex_unlock(x);
+}
+
+#endif
diff -ruP -X /home/adlex/linuxdiffpattern.txt linux-2.5.3/kernel/ksyms.c
linux/kernel/ksyms.c
--- linux-2.5.3/kernel/ksyms.c	Tue Jan 29 19:47:10 2002
+++ linux/kernel/ksyms.c	Wed Feb  6 15:35:26 2002
@@ -46,6 +46,7 @@
 #include <linux/tty.h>
 #include <linux/in6.h>
 #include <linux/completion.h>
+#include <linux/combilock.h>
 #include <linux/seq_file.h>
 #include <asm/checksum.h>

@@ -371,6 +372,13 @@
 /* completion handling */
 EXPORT_SYMBOL(wait_for_completion);
 EXPORT_SYMBOL(complete);
+
+/* combilock non-inline functions */
+EXPORT_SYMBOL(combi_mutex_trylock);
+EXPORT_SYMBOL(combi_mutex_lock);
+EXPORT_SYMBOL(combi_mutex_lock_interruptible);
+EXPORT_SYMBOL(combi_mutex_unlock);
+EXPORT_SYMBOL(__combi_wait);

 /* The notion of irq probe/assignment is foreign to S/390 */

diff -ruP -X /home/adlex/linuxdiffpattern.txt linux-2.5.3/kernel/sched.c
linux/kernel/sched.c
--- linux-2.5.3/kernel/sched.c	Tue Jan 29 00:12:47 2002
+++ linux/kernel/sched.c	Wed Feb  6 13:36:19 2002
@@ -19,6 +19,7 @@
 #include <linux/smp_lock.h>
 #include <linux/interrupt.h>
 #include <asm/mmu_context.h>
+#include <linux/combilock.h>

 #define BITMAP_SIZE ((((MAX_PRIO+7)/8)+sizeof(long)-1)/sizeof(long))

@@ -782,6 +783,89 @@
 	x->done--;
 	spin_unlock_irq(&x->wait.lock);
 }
+
+
+
+
+
+
+/*
+ *  Helper functions assume we hold x->wait.lock
+ */
+void __combi_wait(struct combilock *x)
+{
+	DECLARE_WAITQUEUE(wait, current);
+
+	wait.flags |= WQ_FLAG_EXCLUSIVE;
+	__add_wait_queue_tail(&x->wait, &wait);
+	do {
+	__set_current_state(TASK_UNINTERRUPTIBLE);
+		spin_unlock(&x->wait.lock);
+		schedule();
+		spin_lock(&x->wait.lock);
+	} while (x->owner);
+	__remove_wait_queue(&x->wait, &wait);
+}
+
+int combi_mutex_lock_interruptible(struct combilock *x)
+{
+	int res=0;
+	spin_lock(&x->wait.lock);
+	if (unlikely(x->owner)) {
+		DECLARE_WAITQUEUE(wait, current);
+
+		wait.flags |= WQ_FLAG_EXCLUSIVE;
+		__add_wait_queue_tail(&x->wait, &wait);
+		for (;;) {
+			__set_current_state(TASK_INTERRUPTIBLE);
+			spin_unlock(&x->wait.lock);
+			schedule();
+			spin_lock(&x->wait.lock);
+			if (likely(!x->owner)) {
+				x->owner=current;
+				break;
+			}
+			if (unlikely(signal_pending(current))) {
+				res=1;
+				break;
+			}
+		}
+		__remove_wait_queue(&x->wait, &wait);
+	}
+	spin_unlock(&x->wait.lock);
+	return res;
+}
+
+int combi_mutex_trylock(struct combilock *x)
+{
+	spin_lock(&x->wait.lock);
+	if (unlikely(x->owner)) {
+		spin_unlock(&x->wait.lock);
+		return 1;
+	}
+	x->owner=current;
+	spin_unlock(&x->wait.lock);
+	return 0;
+}
+
+void combi_mutex_lock(struct combilock *x)
+{
+	spin_lock(&x->wait.lock);
+	if (unlikely(x->owner))
+		__combi_wait(x);
+	x->owner=current;
+	spin_unlock(&x->wait.lock);
+}
+
+void combi_mutex_unlock(struct combilock *x)
+{
+	spin_lock(&x->wait.lock);
+	x->owner=NULL;
+	__wake_up_common(&x->wait, TASK_UNINTERRUPTIBLE |
TASK_INTERRUPTIBLE,1, 0);
+	spin_unlock(&x->wait.lock);
+}
+
+

 #define	SLEEP_ON_VAR				\
 	unsigned long flags;			\
