Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310538AbSCLJzF>; Tue, 12 Mar 2002 04:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310539AbSCLJy5>; Tue, 12 Mar 2002 04:54:57 -0500
Received: from slip-202-135-75-240.ca.au.prserv.net ([202.135.75.240]:10637
	"EHLO wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S310538AbSCLJyp>; Tue, 12 Mar 2002 04:54:45 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: frankeh@watson.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores) 
In-Reply-To: Your message of "Mon, 11 Mar 2002 14:45:49 -0800."
             <Pine.LNX.4.33.0203111441120.17864-100000@penguin.transmeta.com> 
Date: Tue, 12 Mar 2002 18:20:37 +1100
Message-Id: <E16kgaz-0007ry-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.33.0203111441120.17864-100000@penguin.transmeta.com> you
 write:
> 
> On Sat, 9 Mar 2002, Rusty Russell wrote:
> > > 
> > > So I would suggest making the size (and thus alignment check) of locks at
> > > least 8 bytes (and preferably 16). That makes it slightly harder to put
> > > locks on the stack, but gcc does support stack alignment, even if the cod
e
> > > sucks right now.
> > 
> > Actually, I disagree.
> > 
> > 1) We've left wiggle room in the second arg to sys_futex() to add rwsems
> >    later if required.
> > 2) Someone needs to implement them and prove they are superior to the
> >    pure userspace solution.
> 
> You've convinced me.

Damn.  Because now I've been playing with a different approach.

If we basically export "add_to_waitqueue", "del_from_waitqueue",
"wait_for_waitqueue" and "wakeup_waitqueue" syscalls, we have a more
powerful interface: the kernel need not touch userspace addresses at
all (no kmap/kunmap, no worried about spinlocks vs. rwlocks).

The problem is that this fundamentally requires at least two syscalls
in the slow path (add_to_waitqueue, try for lock, wait_for_waitqueue).
My tests here show it's about 6% slower than the solution you accepted
for tdbtorture (which means the slow path is significantly slower).  I
can't imagine shaving that much more off it.

There are variations on this: cookie could be replaces the page struct
and the offset, ala futexes.

Thoughts?
Rusty.

PS.  Kudos: it was Ben LaHaise's idea to export waitqueues, but I
     didn't see how to do it until Paul M made a bad joke about two
     syscalls....
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6/arch/i386/kernel/entry.S working-2.5.6-hwq/arch/i386/kernel/entry.S
--- linux-2.5.6/arch/i386/kernel/entry.S	Fri Mar  8 14:49:11 2002
+++ working-2.5.6-hwq/arch/i386/kernel/entry.S	Mon Mar 11 15:50:20 2002
@@ -717,6 +717,9 @@
 	.long SYMBOL_NAME(sys_fremovexattr)
 	.long SYMBOL_NAME(sys_tkill)
 	.long SYMBOL_NAME(sys_sendfile64)
+	.long SYMBOL_NAME(sys_uwaitq_add)	/* 240 */
+	.long SYMBOL_NAME(sys_uwaitq_wait)
+	.long SYMBOL_NAME(sys_uwaitq_wake)
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long SYMBOL_NAME(sys_ni_syscall)
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6/include/asm-i386/mman.h working-2.5.6-hwq/include/asm-i386/mman.h
--- linux-2.5.6/include/asm-i386/mman.h	Wed Mar 15 12:45:20 2000
+++ working-2.5.6-hwq/include/asm-i386/mman.h	Mon Mar 11 15:58:59 2002
@@ -5,6 +5,7 @@
 #define PROT_WRITE	0x2		/* page can be written */
 #define PROT_EXEC	0x4		/* page can be executed */
 #define PROT_NONE	0x0		/* page can not be accessed */
+#define PROT_SEM	0x8		/* page can contain semaphores */
 
 #define MAP_SHARED	0x01		/* Share changes */
 #define MAP_PRIVATE	0x02		/* Changes are private */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6/include/asm-i386/unistd.h working-2.5.6-hwq/include/asm-i386/unistd.h
--- linux-2.5.6/include/asm-i386/unistd.h	Fri Mar  8 14:49:28 2002
+++ working-2.5.6-hwq/include/asm-i386/unistd.h	Mon Mar 11 14:52:07 2002
@@ -244,6 +244,9 @@
 #define __NR_fremovexattr	237
 #define __NR_tkill		238
 #define __NR_sendfile64		239
+#define __NR_uwaitq_add		240
+#define __NR_uwaitq_wait	241
+#define __NR_uwaitq_wake	242
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6/include/linux/sched.h working-2.5.6-hwq/include/linux/sched.h
--- linux-2.5.6/include/linux/sched.h	Sat Mar  9 14:52:15 2002
+++ working-2.5.6-hwq/include/linux/sched.h	Tue Mar 12 13:54:15 2002
@@ -230,6 +230,11 @@
 
 typedef struct prio_array prio_array_t;
 
+struct uwaitq {
+	struct list_head list;
+	unsigned long /*long*/ cookie;
+};
+
 struct task_struct {
 	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
 	struct thread_info *thread_info;
@@ -344,6 +349,8 @@
 
 /* journalling filesystem info */
 	void *journal_info;
+/* user wait queue info */
+	struct uwaitq uwaitq;
 };
 
 extern void __put_task_struct(struct task_struct *tsk);
@@ -508,6 +515,13 @@
 extern int kill_proc(pid_t, int, int);
 extern int do_sigaction(int, const struct k_sigaction *, struct k_sigaction *);
 extern int do_sigaltstack(const stack_t *, stack_t *, unsigned long);
+
+extern void __uwaitq_unqueue(struct uwaitq *q);
+static inline void uwaitq_unqueue(struct uwaitq *q)
+{
+	if (q->cookie)
+		__uwaitq_unqueue(q);
+}
 
 /*
  * Re-calculate pending state from the set of locally pending
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6/kernel/Makefile working-2.5.6-hwq/kernel/Makefile
--- linux-2.5.6/kernel/Makefile	Wed Feb 20 17:56:17 2002
+++ working-2.5.6-hwq/kernel/Makefile	Mon Mar 11 14:50:49 2002
@@ -15,7 +15,7 @@
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
 	    sysctl.o acct.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o 
+	    signal.o sys.o kmod.o context.o uwaitq.o
 
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6/kernel/exit.c working-2.5.6-hwq/kernel/exit.c
--- linux-2.5.6/kernel/exit.c	Wed Feb 20 17:57:21 2002
+++ working-2.5.6-hwq/kernel/exit.c	Tue Mar 12 12:57:09 2002
@@ -502,7 +502,7 @@
 	acct_process(code);
 #endif
 	__exit_mm(tsk);
-
+	uwaitq_unqueue(&tsk->uwaitq);
 	lock_kernel();
 	sem_exit();
 	__exit_files(tsk);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6/kernel/fork.c working-2.5.6-hwq/kernel/fork.c
--- linux-2.5.6/kernel/fork.c	Fri Mar  8 14:49:30 2002
+++ working-2.5.6-hwq/kernel/fork.c	Tue Mar 12 12:52:27 2002
@@ -720,6 +720,8 @@
 	if (retval)
 		goto bad_fork_cleanup_namespace;
 	p->semundo = NULL;
+	INIT_LIST_HEAD(&p->uwaitq.list);
+	p->uwaitq.cookie = 0;
 	
 	/* Our parent execution domain becomes current domain
 	   These must match for thread signalling to apply */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6/kernel/uwaitq.c working-2.5.6-hwq/kernel/uwaitq.c
--- linux-2.5.6/kernel/uwaitq.c	Thu Jan  1 10:00:00 1970
+++ working-2.5.6-hwq/kernel/uwaitq.c	Tue Mar 12 14:06:58 2002
@@ -0,0 +1,153 @@
+/*
+ *  User-exported wait queues.
+ *  (C) Rusty Russell, IBM 2002
+ *
+ *  Thanks to Ben LaHaise for yelling "hashed waitqueues", and Paul
+ *  Mackerras for suggesting breaking it into multiple syscalls.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA */
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <asm/uaccess.h>
+
+/* Theory is simple:
+   1) If we are on a hash list, we are waiting to be woken up.
+   2) Otherwise, if cookie is not zero, we have just been woken up.
+   3) Otherwise, we are not involved in any userspace wait queues.
+*/
+/* FIXME: This may be way too small. --RR */
+#define UWAITQ_HASHBITS 6
+
+/* We use this instead of a normal wait_queue_t, so we can wake only
+   the relevent ones (hashed queues may be shared) */
+struct uwaitq_head
+{
+	struct list_head list;
+	spinlock_t lock;
+} ____cacheline_aligned;
+static struct uwaitq_head uwait_queues[1<<UWAITQ_HASHBITS] __cacheline_aligned;
+
+static inline struct uwaitq_head *hash_uwaitq(unsigned long /*long*/ cookie)
+{
+	return &uwait_queues[cookie & ((1<<UWAITQ_HASHBITS)-1)];
+}
+
+/* struct uwaitq is always embedded in a task struct. */
+static inline struct task_struct *uwaitq_to_task(struct uwaitq *q)
+{
+	return (void *)q - offsetof(struct task_struct, uwaitq);
+}
+
+/* Add at end to avoid starvation */
+static inline void queue_me(struct uwaitq_head *head)
+{
+	spin_lock(&head->lock);
+	list_add_tail(&current->uwaitq.list, &head->list);
+	spin_unlock(&head->lock);
+}
+
+/* Must be holding spinlock */
+static void wake_by_cookie(struct uwaitq_head *head, unsigned long /*long*/ cookie)
+{
+	struct list_head *i;
+
+	list_for_each(i, &head->list) {
+		struct uwaitq *this = list_entry(i, struct uwaitq, list);
+
+		if (cookie == this->cookie) {
+			list_del_init(&this->list);
+			wmb();
+			wake_up_process(uwaitq_to_task(this));
+			return;
+		}
+	}
+}
+
+void __uwaitq_unqueue(struct uwaitq *q)
+{
+	struct uwaitq_head *head;
+
+	head = hash_uwaitq(q->cookie);
+	spin_lock(&head->lock);
+	/* If we have been woken, we must wake someone else since we
+	   are no longer interested. */
+	if (list_empty(&q->list))
+		wake_by_cookie(head, q->cookie);
+	else
+		list_del_init(&q->list);
+	spin_unlock(&head->lock);
+}
+
+asmlinkage int sys_uwaitq_wake(unsigned long /*long*/ cookie)
+{
+	struct uwaitq_head *head;
+	
+	head = hash_uwaitq(cookie);
+	spin_lock(&head->lock);
+	wake_by_cookie(head, cookie);
+	spin_unlock(&head->lock);
+	return 0;
+}
+
+/* Add to the wait queue: 0 cookie means delete. */
+asmlinkage int sys_uwaitq_add(unsigned long /*long*/ cookie)
+{
+	/* Unqueue if is/was queued. */
+	uwaitq_unqueue(&current->uwaitq);
+
+	/* Set cookie. */
+	current->uwaitq.cookie = cookie;
+
+	/* If non-zero, requeue */
+	if (cookie)
+		queue_me(hash_uwaitq(cookie));
+	return 0;
+}
+
+/* Wait to be chucked off the queue. */
+asmlinkage int sys_uwaitq_wait(void)
+{
+	int retval = 0;
+
+	set_current_state(TASK_INTERRUPTIBLE);
+	while (!list_empty(&current->uwaitq.list)) {
+		if (signal_pending(current)) {
+			retval = -EINTR;
+			__uwaitq_unqueue(&current->uwaitq);
+			goto out;
+		}
+		schedule();
+		set_current_state(TASK_INTERRUPTIBLE);
+	}
+	/* Mark the fact that we were woken up. */
+	current->uwaitq.cookie = 0;
+ out:
+	set_current_state(TASK_RUNNING);
+	return retval;
+}
+
+static int __init init(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(uwait_queues); i++) {
+		INIT_LIST_HEAD(&uwait_queues[i].list);
+		spin_lock_init(&uwait_queues[i].lock);
+	}
+	return 0;
+}
+__initcall(init);
