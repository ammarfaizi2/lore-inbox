Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264717AbSIQW6c>; Tue, 17 Sep 2002 18:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264743AbSIQW5s>; Tue, 17 Sep 2002 18:57:48 -0400
Received: from mx2.elte.hu ([157.181.151.9]:15232 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S264717AbSIQWyH>;
	Tue, 17 Sep 2002 18:54:07 -0400
Date: Wed, 18 Sep 2002 01:06:11 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, <linux-kernel@vger.kernel.org>
Subject: [patch] lockless, scalable get_pid(), for_each_process() elimination,
 2.5.35-BK
Message-ID: <Pine.LNX.4.44.0209180024090.30913-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch is yet another step towards world-class threading
support.

the biggest known load-test of the new threading code so far was 1 million
concurrent kernel threads (!) running on Anton's 2.5.34 Linux box. On my
testsystem i was able to test 100,000 concurrent kernel threads, which can
be started and stopped within 2 seconds.

While even the biggest internet servers are not quite at 1 million
parallel users yet, even a much smaller 10,000 threads workload causes the
O(N^2) get_pid() algorithm to explode, if consecutive PID ranges are taken
and the PID value overflows and reaches the lower end of the PID range.

With 100,000 or more threads get_pid() causes catastrophic, many minutes
silent 'lockup' of the system. Plus the current get_pid() implementation
iterates through *every* thread in the system if it reaches a PID that was
used up before - which can happen quite often if the rate of thread
creation/destruction is sufficiently high. Besides being slow, the
algorithm also touches lots of unrelated cachelines, effectively flushing
the CPU cache. Eg. for the default pid_max value of 32K threads/processes,
if there are only 10% processes (3200), statistically we will flush the
cache for every 10 threads created. This is unacceptable.

there are a number of patches floating around that try to improve the
worst-case scenario of get_pid(), but the best they can achieve is a
runtime construction of a bitmap and then searching it => this still sucks
performance-wise, destroys the cache and is generally a very ugly
approach.

the underlying problem is very hard - since get_pid() not only has to take
PIDs into account, but TGIDs, session IDs and process groups as well.

then i found one of wli's older patches for 2.5.23 [grr, it was not
announced anywhere, i almost started coding the same problem], which
provides the right (and much harder to implement) approach: it cleans up
PID-space allocation to provide a generic hash for PIDs, session IDs,
process group IDs and TGIDs, properly allocated and freed. This approach,
besides paving the way for a scalable and time-bounded get_pid()
implementation, also got rid of roughly half of for_each_process()
(do_each_thread()) iterations done in the kernel, which alone is worth the
effort. Now we can cleanly iterate through all processes in a session
group or process group.

i took the patch, adopted it to the recent ->ptrace_children and threading
related changes, fixed a couple of bugs and made it work. It really worked
well, nice work William!

I also wrote a new alloc_pid()/free_pid() implementation from scratch,
which provides lockless, time-bounded PID allocation. This new PID
allocator has a worst-case latency of 10 microseconds on a cache-cold P4,
the cache-hot worst-case latency is 2 usecs, if pid_max is set to 1
million.

Ie. even in the most hopeless situation, if there are 999,999 PIDs
allocated already, it takes less than 10 usecs to find and allocate the
remaining one PID. The common fastpath is a couple of instructions only.  
The overhead of skipping over continuous regions of allocated PIDs scales
gracefully with the number of bits to be skipped, from 0 to 10 usecs.

(In the fastpath, both the alloc_pid() and free_pid() function falls
through to a 'ret' instruction if compiled with gcc 3.2 on x86.)

i tested the new PID allocation functions under heavy thread creation
workloads, and the new functions just do not show up in the kernel
profiler ...

[ on SMP the new PID allocator has a small window to not follow the
'monotonic forward allocation of PIDs' semantics provided by the previous
implementation - but it's not like we can guarantee any PID allocation
sequence to user-space even with the current get_pid() allocation. The new
allocator still follows the last_pid semantics in the typical case. The
reserved PID range is protected as well. ]

memory footprint of the new PID allocator scales dynamically with
/proc/sys/kernel/pid_max: the default 32K PIDs cause a 4K allocation, a
pid_max of 1 million causes a 128K footprint. The current absolute limit
for pid_max is 4 million PIDs - this does not cause any allocation in the
kernel, the bitmaps are demand-allocated runtime. The pidmap table takes
up 512 bytes.

and as an added bonus, the new PID allocator fails in fork() properly if
the whole PID space is used up. BK-curr's get_pid() still didnt do this
properly.

i have tested the patch on BK-curr, on x86 UP and SMP boxes - it compiles,
boots and works just fine. X and the other session/pgrp-intensive
applications appear to work just fine as well.

	Ingo

--- linux/drivers/char/tty_io.c.orig	Wed Sep 18 00:16:42 2002
+++ linux/drivers/char/tty_io.c	Wed Sep 18 00:18:06 2002
@@ -430,8 +430,9 @@
 {
 	struct tty_struct *tty = (struct tty_struct *) data;
 	struct file * cons_filp = NULL;
-	struct task_struct *p;
-	struct list_head *l;
+	task_t *task;
+	struct list_head *l, *elem;
+	struct idtag *idtag;
 	int    closecount = 0, n;
 
 	if (!tty)
@@ -494,20 +495,33 @@
 						"error %d\n", -i);
 		}
 	}
-	
+
+	if (tty->session <= 0)
+		goto breakout;
+
 	read_lock(&tasklist_lock);
- 	for_each_process(p) {
-		if ((tty->session > 0) && (p->session == tty->session) &&
-		    p->leader) {
-			send_sig(SIGHUP,p,1);
-			send_sig(SIGCONT,p,1);
-			if (tty->pgrp > 0)
-				p->tty_old_pgrp = tty->pgrp;
-		}
-		if (p->tty == tty)
-			p->tty = NULL;
+	idtag = find_get_tag(IDTAG_SID, tty->session);
+	if (!idtag)
+		goto breakout_unlock;
+
+	list_for_each(elem, &idtag->task_list) {
+		task = idtag_task(elem, IDTAG_SID);
+
+		if (task->tty == tty)
+			task->tty = NULL;
+
+		if (!task->leader)
+			continue;
+
+		send_sig(SIGHUP, task, 1);
+		send_sig(SIGCONT, task, 1);
+		if (tty->pgrp > 0)
+			task->tty_old_pgrp = tty->pgrp;
 	}
+	put_tag(idtag);
+breakout_unlock:
 	read_unlock(&tasklist_lock);
+breakout:
 
 	tty->flags = 0;
 	tty->session = 0;
@@ -570,7 +584,9 @@
 void disassociate_ctty(int on_exit)
 {
 	struct tty_struct *tty = current->tty;
-	struct task_struct *p;
+	task_t *task;
+	struct list_head *elem;
+	struct idtag *idtag;
 	int tty_pgrp = -1;
 
 	lock_kernel();
@@ -598,9 +614,17 @@
 	tty->pgrp = -1;
 
 	read_lock(&tasklist_lock);
-	for_each_process(p)
-	  	if (p->session == current->session)
-			p->tty = NULL;
+	idtag = find_get_tag(IDTAG_SID, current->session);
+
+	if (!idtag)
+		goto out_unlock;
+
+	list_for_each(elem, &idtag->task_list) {
+		task = idtag_task(elem, IDTAG_SID);
+		task->tty = NULL;
+	}
+	put_tag(idtag);
+out_unlock:
 	read_unlock(&tasklist_lock);
 	unlock_kernel();
 }
@@ -1220,15 +1244,32 @@
 	 * tty.  Also, clear redirect if it points to either tty.
 	 */
 	if (tty_closing || o_tty_closing) {
-		struct task_struct *p;
+		task_t *task;
+		struct list_head *elem;
+		struct idtag *idtag;
 
 		read_lock(&tasklist_lock);
-		for_each_process(p) {
-			if (p->tty == tty || (o_tty && p->tty == o_tty))
-				p->tty = NULL;
+		idtag = find_get_tag(IDTAG_SID, tty->session);
+		if (!idtag)
+			goto detach_o_tty;
+		list_for_each(elem, &idtag->task_list) {
+			task = idtag_task(elem, IDTAG_SID);
+			task->tty = NULL;
+		}
+		put_tag(idtag);
+detach_o_tty:
+		if (!o_tty)
+			goto out_unlock;
+		idtag = find_get_tag(IDTAG_SID, o_tty->session);
+		if (!idtag)
+			goto out_unlock;
+		list_for_each(elem, &idtag->task_list) {
+			task = idtag_task(elem, IDTAG_SID);
+			task->tty = NULL;
 		}
+		put_tag(idtag);
+out_unlock:
 		read_unlock(&tasklist_lock);
-
 		if (redirect == tty || (o_tty && redirect == o_tty))
 			redirect = NULL;
 	}
@@ -1540,6 +1581,10 @@
 
 static int tiocsctty(struct tty_struct *tty, int arg)
 {
+	task_t *task;
+	struct list_head *elem;
+	struct idtag *idtag;
+
 	if (current->leader &&
 	    (current->session == tty->session))
 		return 0;
@@ -1549,25 +1594,34 @@
 	 */
 	if (!current->leader || current->tty)
 		return -EPERM;
-	if (tty->session > 0) {
+
+	if (tty->session <= 0)
+		goto out_no_detach;
+
+	/*
+	 * This tty is already the controlling
+	 * tty for another session group!
+	 */
+	if ((arg == 1) && capable(CAP_SYS_ADMIN)) {
 		/*
-		 * This tty is already the controlling
-		 * tty for another session group!
+		 * Steal it away
 		 */
-		if ((arg == 1) && capable(CAP_SYS_ADMIN)) {
-			/*
-			 * Steal it away
-			 */
-			struct task_struct *p;
-
-			read_lock(&tasklist_lock);
-			for_each_process(p)
-				if (p->tty == tty)
-					p->tty = NULL;
-			read_unlock(&tasklist_lock);
-		} else
-			return -EPERM;
-	}
+
+		read_lock(&tasklist_lock);
+		idtag = find_get_tag(IDTAG_SID, tty->session);
+		if (!idtag)
+			goto out_unlock;
+
+		list_for_each(elem, &idtag->task_list) {
+			task = idtag_task(elem, IDTAG_SID);
+			task->tty = NULL;
+		}
+		put_tag(idtag);
+out_unlock:
+		read_unlock(&tasklist_lock);
+	} else
+		return -EPERM;
+out_no_detach:
 	task_lock(current);
 	current->tty = tty;
 	task_unlock(current);
--- linux/include/linux/idtag.h.orig	Wed Sep 18 00:18:06 2002
+++ linux/include/linux/idtag.h	Wed Sep 18 00:18:06 2002
@@ -0,0 +1,57 @@
+#ifndef _LINUX_IDTAG_H
+#define _LINUX_IDTAG_H
+
+#include <linux/list.h>
+
+struct task_struct;
+
+enum idtag_type
+{
+	IDTAG_PID,
+	IDTAG_PGID,
+	IDTAG_SID,
+	IDTAG_TGID,
+	IDTAG_MAX
+};
+
+struct idtag
+{
+	unsigned long tag;
+	enum idtag_type type;
+	atomic_t count;
+	struct list_head idtag_hash_chain;
+	struct list_head task_list;
+};
+
+struct idtag_link
+{
+	unsigned long tag;
+	struct list_head idtag_chain;
+	struct idtag *idtag;
+};
+
+#define idtag_task(elem, tagtype) \
+	list_entry(elem, struct task_struct, idtags[(int)(tagtype)].idtag_chain)
+
+/*
+ * attach_tag() must be called without the tasklist_lock.
+ */
+extern int attach_tag(struct task_struct *, enum idtag_type, unsigned long);
+
+/*
+ * detach_tag() must be called with the tasklist_lock held.
+ */
+extern int detach_tag(struct task_struct *task, enum idtag_type);
+
+/*
+ * Quick & dirty hash table lookup.
+ */
+extern struct idtag *FASTCALL(get_tag(enum idtag_type, unsigned long));
+extern struct idtag *FASTCALL(find_get_tag(enum idtag_type, unsigned long));
+extern void put_tag(struct idtag *);
+extern int idtag_unused(unsigned long);
+
+extern int alloc_pid(void);
+extern void free_pid(unsigned long);
+
+#endif /* _LINUX_IDTAG_H */
--- linux/include/linux/init_task.h.orig	Wed Sep 18 00:16:43 2002
+++ linux/include/linux/init_task.h	Wed Sep 18 00:18:06 2002
@@ -75,6 +75,7 @@
 	.parent		= &tsk,						\
 	.children	= LIST_HEAD_INIT(tsk.children),			\
 	.sibling	= LIST_HEAD_INIT(tsk.sibling),			\
+	.user_task_list = LIST_HEAD_INIT(tsk.user_task_list),		\
 	.group_leader	= &tsk,						\
 	.thread_group	= LIST_HEAD_INIT(tsk.thread_group),		\
 	.wait_chldexit	= __WAIT_QUEUE_HEAD_INITIALIZER(tsk.wait_chldexit),\
--- linux/include/linux/sched.h.orig	Wed Sep 18 00:17:43 2002
+++ linux/include/linux/sched.h	Wed Sep 18 00:18:06 2002
@@ -28,6 +28,7 @@
 #include <linux/fs_struct.h>
 #include <linux/compiler.h>
 #include <linux/completion.h>
+#include <linux/idtag.h>
 
 struct exec_domain;
 
@@ -259,6 +260,9 @@
 	/* Hash table maintenance information */
 	struct list_head uidhash_list;
 	uid_t uid;
+
+	rwlock_t lock;
+	struct list_head task_list;
 };
 
 #define get_current_user() ({ 				\
@@ -266,6 +270,8 @@
 	atomic_inc(&__user->__count);			\
 	__user; })
 
+extern struct user_struct *find_user(uid_t);
+
 extern struct user_struct root_user;
 #define INIT_USER (&root_user)
 
@@ -329,6 +335,10 @@
 	/* PID hash table linkage. */
 	struct task_struct *pidhash_next;
 	struct task_struct **pidhash_pprev;
+
+	struct idtag_link idtags[IDTAG_MAX];
+
+	struct list_head user_task_list;
 
 	wait_queue_head_t wait_chldexit;	/* for wait4() */
 	struct completion *vfork_done;		/* for vfork() */
--- linux/include/linux/threads.h.orig	Wed Sep 18 00:16:42 2002
+++ linux/include/linux/threads.h	Wed Sep 18 00:18:06 2002
@@ -17,8 +17,13 @@
 #define MIN_THREADS_LEFT_FOR_ROOT 4
 
 /*
- * This controls the maximum pid allocated to a process
+ * This controls the default maximum pid allocated to a process
  */
-#define DEFAULT_PID_MAX 0x8000
+#define PID_MAX_DEFAULT 0x8000
+
+/*
+ * A maximum of 4 million PIDs should be enough for a while:
+ */
+#define PID_MAX_LIMIT (4*1024*1024)
 
 #endif
--- linux/include/asm-i386/bitops.h.orig	Sun Jun  9 07:30:40 2002
+++ linux/include/asm-i386/bitops.h	Wed Sep 18 00:18:06 2002
@@ -401,6 +401,20 @@
 }
 
 /**
+ * lg - integer logarithm base 2
+ * @n - integer to take log base 2 of
+ *
+ * undefined if 0
+ */
+static inline unsigned long lg(unsigned long n)
+{
+        asm("bsrl %1,%0"
+                :"=r" (n)
+                :"r" (n));
+        return n;
+}
+
+/**
  * __ffs - find first bit in word.
  * @word: The word to search
  *
--- linux/include/asm-i386/types.h.orig	Sun Jun  9 07:26:52 2002
+++ linux/include/asm-i386/types.h	Wed Sep 18 00:18:06 2002
@@ -41,7 +41,8 @@
 typedef signed long long s64;
 typedef unsigned long long u64;
 
-#define BITS_PER_LONG 32
+#define BITS_PER_LONG_SHIFT	5
+#define BITS_PER_LONG		(1 << BITS_PER_LONG_SHIFT)
 
 /* DMA addresses come in generic and 64-bit flavours.  */
 
--- linux/fs/fcntl.c.orig	Wed Sep 18 00:16:43 2002
+++ linux/fs/fcntl.c	Wed Sep 18 00:18:06 2002
@@ -480,7 +480,9 @@
 
 void send_sigio(struct fown_struct *fown, int fd, int band)
 {
-	struct task_struct * p;
+	struct task_struct *task;
+	struct list_head *elem;
+	struct idtag *idtag;
 	int pid;
 	
 	read_lock(&fown->lock);
@@ -489,18 +491,23 @@
 		goto out_unlock_fown;
 	
 	read_lock(&tasklist_lock);
-	if ( (pid > 0) && (p = find_task_by_pid(pid)) ) {
-		send_sigio_to_task(p, fown, fd, band);
+	if (pid > 0) {
+		task = find_task_by_pid(pid);
+		if (task)
+			send_sigio_to_task(task, fown, fd, band);
 		goto out_unlock_task;
 	}
-	for_each_process(p) {
-		int match = p->pid;
-		if (pid < 0)
-			match = -p->pgrp;
-		if (pid != match)
-			continue;
-		send_sigio_to_task(p, fown, fd, band);
+ 
+	idtag = find_get_tag(IDTAG_PGID, -pid);
+	if (!idtag)
+		goto out_unlock_task;
+ 
+	list_for_each(elem, &idtag->task_list) {
+		task = idtag_task(elem, IDTAG_PGID);
+
+		send_sigio_to_task(task, fown, fd, band);
 	}
+	put_tag(idtag);
 out_unlock_task:
 	read_unlock(&tasklist_lock);
 out_unlock_fown:
--- linux/kernel/Makefile.orig	Wed Sep 18 00:16:37 2002
+++ linux/kernel/Makefile	Wed Sep 18 00:18:28 2002
@@ -15,7 +15,8 @@
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o futex.o platform.o
+	    signal.o sys.o kmod.o context.o futex.o platform.o \
+	    pid.o idtag.o
 
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o
--- linux/kernel/exit.c.orig	Wed Sep 18 00:17:43 2002
+++ linux/kernel/exit.c	Wed Sep 18 00:18:06 2002
@@ -34,6 +34,13 @@
 	struct dentry *proc_dentry;
 	nr_threads--;
 	unhash_pid(p);
+	detach_tag(p, IDTAG_PID);
+	if (thread_group_leader(p)) {
+		detach_tag(p, IDTAG_TGID);
+		detach_tag(p, IDTAG_PGID);
+		detach_tag(p, IDTAG_SID);
+	}
+
 	REMOVE_LINKS(p);
 	p->pid = 0;
 	proc_dentry = p->proc_dentry;
@@ -57,7 +64,12 @@
 		BUG();
 	if (p != current)
 		wait_task_inactive(p);
+	write_lock(&p->user->lock);
 	atomic_dec(&p->user->processes);
+	if (list_empty(&p->user_task_list))
+		BUG();
+	list_del(&p->user_task_list);
+	write_unlock(&p->user->lock);
 	security_ops->task_free_security(p);
 	free_uid(p->user);
 	if (unlikely(p->ptrace)) {
@@ -108,23 +120,28 @@
  */
 int session_of_pgrp(int pgrp)
 {
-	struct task_struct *p;
-	int fallback;
+	task_t *task;
+	struct list_head *elem;
+	struct idtag *idtag;
+	int sid = -1;
 
-	fallback = -1;
 	read_lock(&tasklist_lock);
-	for_each_process(p) {
- 		if (p->session <= 0)
- 			continue;
-		if (p->pgrp == pgrp) {
-			fallback = p->session;
-			break;
+	idtag = find_get_tag(IDTAG_PGID, pgrp);
+	if (!idtag)
+		goto out;
+
+	list_for_each(elem, &idtag->task_list) {
+		task = idtag_task(elem, IDTAG_PGID);
+
+		if (task->session > 0) {
+			sid = task->session;
+			goto out;
 		}
-		if (p->pid == pgrp)
-			fallback = p->session;
 	}
+	put_tag(idtag);
+out:
 	read_unlock(&tasklist_lock);
-	return fallback;
+	return sid;
 }
 
 /*
@@ -135,21 +152,55 @@
  *
  * "I ask you, have you ever known what it is to be an orphan?"
  */
-static int __will_become_orphaned_pgrp(int pgrp, struct task_struct * ignored_task)
+static int __will_become_orphaned_pgrp(int pgrp, task_t *ignored_task)
 {
-	struct task_struct *p;
-
-	for_each_process(p) {
-		if ((p == ignored_task) || (p->pgrp != pgrp) ||
-		    (p->state == TASK_ZOMBIE) ||
-		    (p->parent->pid == 1))
+	task_t *task;
+	struct idtag *idtag;
+	struct list_head *elem;
+	int ret = 1;
+
+	idtag = find_get_tag(IDTAG_PGID, pgrp);
+	if (!idtag)
+		goto out;
+	list_for_each(elem, &idtag->task_list) {
+		task = idtag_task(elem, IDTAG_PGID);
+		if (task == ignored_task
+				|| task->state == TASK_ZOMBIE 
+				|| task->parent->pid == 1)
 			continue;
-		if ((p->parent->pgrp != pgrp) &&
-		    (p->parent->session == p->session)) {
- 			return 0;
+		if (task->parent->pgrp != pgrp
+				&& task->parent->session == task->session) {
+			ret = 0;
+			goto out;
 		}
 	}
-	return 1;	/* (sighing) "Often!" */
+	put_tag(idtag);
+out:
+	return ret;	/* (sighing) "Often!" */
+}
+
+static inline int __has_stopped_jobs(int pgrp)
+{
+	int retval = 0;
+	task_t *task;
+	struct list_head *elem;
+	struct idtag *idtag;
+
+	idtag = find_get_tag(IDTAG_PGID, pgrp);
+	if (!idtag)
+		goto out;
+	list_for_each(elem, &idtag->task_list) {
+		task = idtag_task(elem, IDTAG_PGID);
+
+		if (task->state != TASK_STOPPED)
+			continue;
+
+		retval = 1;
+		goto out;
+	}
+	put_tag(idtag);
+out:
+	return retval;
 }
 
 static int will_become_orphaned_pgrp(int pgrp, struct task_struct * ignored_task)
@@ -166,22 +217,6 @@
 int is_orphaned_pgrp(int pgrp)
 {
 	return will_become_orphaned_pgrp(pgrp, 0);
-}
-
-static inline int __has_stopped_jobs(int pgrp)
-{
-	int retval = 0;
-	struct task_struct * p;
-
-	for_each_process(p) {
-		if (p->pgrp != pgrp)
-			continue;
-		if (p->state != TASK_STOPPED)
-			continue;
-		retval = 1;
-		break;
-	}
-	return retval;
 }
 
 static inline int has_stopped_jobs(int pgrp)
--- linux/kernel/idtag.c.orig	Wed Sep 18 00:18:06 2002
+++ linux/kernel/idtag.c	Wed Sep 18 00:18:06 2002
@@ -0,0 +1,177 @@
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+#include <linux/idtag.h>
+#include <linux/slab.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+
+/*
+ * idtags for tasks
+ * (C) 2002 William Irwin, IBM
+ * idtags are backing objects for tasks sharing a given ID to chain
+ * against. There is very little to them aside from hashing them and
+ * parking tasks using given ID's on a list.
+ *
+ * TODO: use per-bucket locks.
+ */
+
+static kmem_cache_t *idtag_cache;
+
+#define IDHASH_SIZE 4096
+static struct list_head idtag_hash[IDTAG_MAX][IDHASH_SIZE];
+
+static spinlock_t idtag_lock = SPIN_LOCK_UNLOCKED;
+
+static inline unsigned idtag_hashfn(unsigned long tag)
+{
+	return ((tag >> 8) ^ tag) & (IDHASH_SIZE - 1);
+}
+
+static inline struct idtag *idtag_alloc(void)
+{
+	return kmem_cache_alloc(idtag_cache, SLAB_KERNEL);
+}
+
+static inline void idtag_free(struct idtag *idtag)
+{
+	kmem_cache_free(idtag_cache, idtag);
+}
+
+static inline void init_idtag(	struct idtag *idtag,
+				enum idtag_type type,
+				unsigned long tag)
+{
+	INIT_LIST_HEAD(&idtag->task_list);
+	atomic_set(&idtag->count, 0);
+	idtag->type = type;
+	idtag->tag  = tag;
+	list_add(&idtag->idtag_hash_chain,
+			&idtag_hash[type][idtag_hashfn(tag)]);
+}
+
+struct idtag *find_tag(enum idtag_type type, unsigned long tag)
+{
+	struct list_head *bucket, *elem;
+	struct idtag *idtag;
+
+	bucket = &idtag_hash[type][idtag_hashfn(tag)];
+
+	list_for_each(elem, bucket) {
+		idtag = list_entry(elem, struct idtag, idtag_hash_chain);
+		if (idtag->tag == tag)
+			return idtag;
+	}
+	return NULL;
+}
+
+int idtag_unused(unsigned long tag)
+{
+	enum idtag_type type;
+
+	for (type = 0; type < IDTAG_MAX; ++type)
+		if (find_tag(type, tag))
+			return 0;
+
+	return 1;
+}
+
+void __init idtag_hash_init(void)
+{
+	int i, j;
+
+	for (i = 0; i < IDTAG_MAX; ++i)
+		for (j = 0; j < IDHASH_SIZE; ++j)
+			INIT_LIST_HEAD(&idtag_hash[i][j]);
+}
+
+void __init idtag_init(void)
+{
+	idtag_cache = kmem_cache_create("idtag_cache",
+					sizeof(struct idtag),
+					0,
+					SLAB_HWCACHE_ALIGN,
+					NULL,
+					NULL);
+}
+
+struct idtag *find_get_tag(enum idtag_type type, unsigned long tag)
+{
+	struct idtag *idtag;
+	spin_lock(&idtag_lock);
+	idtag = find_tag(type, tag);
+	if (idtag)
+		atomic_inc(&idtag->count);
+	spin_unlock(&idtag_lock);
+	return idtag;
+}
+
+struct idtag *get_tag(enum idtag_type type, unsigned long tag)
+{
+	struct idtag *idtag;
+
+	spin_lock(&idtag_lock);
+	idtag = find_tag(type, tag);
+
+	if (!idtag) {
+		struct idtag *raced_tag;
+		spin_unlock(&idtag_lock);
+		idtag = idtag_alloc();
+		spin_lock(&idtag_lock);
+		raced_tag = find_tag(type, tag);
+		if (!raced_tag) {
+			init_idtag(idtag, type, tag);
+			goto out_inc;
+		}
+		idtag_free(idtag);
+		idtag = raced_tag;
+	}
+
+	if (!idtag)
+		goto out;
+out_inc:
+	atomic_inc(&idtag->count);
+out:
+	spin_unlock(&idtag_lock);
+	return idtag;
+}
+
+void put_tag(struct idtag *idtag)
+{
+	unsigned long tag;
+	if (!atomic_dec_and_lock(&idtag->count, &idtag_lock))
+		return;
+
+	tag = idtag->tag;
+	list_del(&idtag->idtag_hash_chain);
+	idtag_free(idtag);
+	if (idtag_unused(tag))
+		free_pid(tag);
+	spin_unlock(&idtag_lock);
+}
+
+int attach_tag(task_t *task, enum idtag_type type, unsigned long tag)
+{
+	struct idtag *idtag;
+
+	idtag = get_tag(type, tag);
+
+	if (!idtag)
+		return -ENOMEM;
+
+	spin_lock(&idtag_lock);
+	list_add(&task->idtags[type].idtag_chain, &idtag->task_list);
+	task->idtags[type].tag = tag;
+	task->idtags[type].idtag = idtag;
+	spin_unlock(&idtag_lock);
+
+	return 0;
+}
+
+int detach_tag(task_t *task, enum idtag_type type)
+{
+	spin_lock(&idtag_lock);
+	list_del(&task->idtags[type].idtag_chain);
+	spin_unlock(&idtag_lock);
+	put_tag(task->idtags[type].idtag);
+	return 0;
+}
--- linux/kernel/kmod.c.orig	Wed Sep 18 00:16:39 2002
+++ linux/kernel/kmod.c	Wed Sep 18 00:18:06 2002
@@ -124,11 +124,19 @@
 	/* Drop the "current user" thing */
 	{
 		struct user_struct *user = curtask->user;
+
+		write_lock(&user->lock);
+		atomic_dec(&user->processes);
+		list_del(&curtask->user_task_list);
+		write_unlock(&user->lock);
+		free_uid(user);
+
+		write_lock(&INIT_USER->lock);
 		curtask->user = INIT_USER;
 		atomic_inc(&INIT_USER->__count);
 		atomic_inc(&INIT_USER->processes);
-		atomic_dec(&user->processes);
-		free_uid(user);
+		list_add(&curtask->user_task_list, &INIT_USER->task_list);
+		write_unlock(&INIT_USER->lock);
 	}
 
 	/* Give kmod all effective privileges.. */
--- linux/kernel/pid.c.orig	Wed Sep 18 00:18:06 2002
+++ linux/kernel/pid.c	Wed Sep 18 00:18:06 2002
@@ -0,0 +1,137 @@
+/*
+ * Scalable, lockless, time-bounded PID allocator
+ *
+ * (C) 2002 Ingo Molnar, Red Hat
+ *
+ * We have a list of bitmap pages, which bitmaps represent the PID space.
+ * Allocating and freeing PIDs is completely lockless. The worst-case
+ * allocation scenario when all but one out of 1 million PIDs possible are
+ * allocated already: the scanning of 32 list entries and at most PAGE_SIZE
+ * bytes. The typical fastpath is a single successful setbit. Freeing is O(1).
+ */
+
+#include <linux/mm.h>
+#include <linux/bootmem.h>
+
+int pid_max = PID_MAX_DEFAULT;
+int last_pid;
+
+#define RESERVED_PIDS		300
+
+#define PIDMAP_ENTRIES		(PID_MAX_LIMIT/PAGE_SIZE/8)
+#define BITS_PER_PAGE		(PAGE_SIZE*8)
+#define BITS_PER_PAGE_MASK	(BITS_PER_PAGE-1)
+
+/*
+ * PID-map pages start out as NULL, they get allocated upon
+ * first use and are never deallocated. This way a low pid_max
+ * value does not cause lots of bitmaps to be allocated, but
+ * the scheme scales to up to 4 million PIDs, runtime.
+ */
+typedef struct pidmap {
+	atomic_t nr_free;
+	void *page;
+} pidmap_t;
+
+static pidmap_t pidmap_array[PIDMAP_ENTRIES] =
+	 { [ 0 ... PIDMAP_ENTRIES-1 ] = { ATOMIC_INIT(BITS_PER_PAGE), NULL } };
+
+static pidmap_t *map_limit = pidmap_array + PIDMAP_ENTRIES;
+
+void free_pid(unsigned long pid)
+{
+	pidmap_t *map = pidmap_array + pid / BITS_PER_PAGE;
+	int offset = pid & BITS_PER_PAGE_MASK;
+
+	if (!test_and_clear_bit(offset, map->page))
+		BUG();
+	atomic_inc(&map->nr_free);
+}
+
+/*
+ * Here we search for the next map that has free bits left.
+ * Normally the next map has free PIDs.
+ */
+static inline pidmap_t *next_free_map(pidmap_t *map, int *max_steps)
+{
+	while (--*max_steps) {
+		if (++map == map_limit)
+			map = pidmap_array;
+		if (unlikely(!map->page)) {
+			unsigned long page = get_zeroed_page(GFP_KERNEL);
+			/*
+			 * Free the page if someone raced with us
+			 * installing it:
+			 */
+			if (cmpxchg(&map->page, NULL, page))
+				free_page(page);
+			if (!map->page)
+				break;
+		}
+		if (atomic_read(&map->nr_free))
+			return map;
+	}
+	return NULL;
+}
+
+int alloc_pid(void)
+{
+	int pid, offset, max_steps = PIDMAP_ENTRIES + 1;
+	pidmap_t *map;
+
+	pid = last_pid + 1;
+	if (pid >= pid_max)
+		pid = RESERVED_PIDS;
+
+	offset = pid & BITS_PER_PAGE_MASK;
+	map = pidmap_array + pid / BITS_PER_PAGE;
+
+	if (likely(map->page && !test_and_set_bit(offset, map->page))) {
+		/*
+		 * There is a small window for last_pid updates to race,
+		 * but in that case the next allocation will go into the
+		 * slowpath and that fixes things up.
+		 */
+return_pid:
+		atomic_dec(&map->nr_free);
+		last_pid = pid;
+		return pid;
+	}
+	
+	if (!offset || !atomic_read(&map->nr_free)) {
+next_map:
+		map = next_free_map(map, &max_steps);
+		if (!map)
+			goto failure;
+		offset = 0;
+	}
+	/*
+	 * Find the next zero bit:
+	 */
+scan_more:
+	offset = find_next_zero_bit(map->page, BITS_PER_PAGE, offset);
+	if (offset == BITS_PER_PAGE)
+		goto next_map;
+	if (test_and_set_bit(offset, map->page))
+		goto scan_more;
+
+	/* we got the PID: */
+	pid = (map - pidmap_array) * BITS_PER_PAGE + offset;
+	goto return_pid;
+
+failure:
+	return -1;
+}
+
+void __init pid_init(void)
+{
+	pidmap_t *map = pidmap_array;
+
+	/*
+	 * Allocate PID 0:
+	 */
+	map->page = alloc_bootmem(PAGE_SIZE);
+	set_bit(0, map->page);
+	atomic_dec(&map->nr_free);
+}
+
--- linux/kernel/sched.c.orig	Wed Sep 18 00:16:43 2002
+++ linux/kernel/sched.c	Wed Sep 18 00:18:06 2002
@@ -2099,6 +2099,8 @@
 {
 	runqueue_t *rq;
 	int i, j, k;
+	extern void idtag_hash_init(void);
+	extern void pid_init(void);
 
 	for (i = 0; i < NR_CPUS; i++) {
 		prio_array_t *array;
@@ -2139,5 +2141,8 @@
 	 */
 	atomic_inc(&init_mm.mm_count);
 	enter_lazy_tlb(&init_mm, current, smp_processor_id());
+
+	idtag_hash_init();
+	pid_init();
 }
 
--- linux/kernel/signal.c.orig	Wed Sep 18 00:16:43 2002
+++ linux/kernel/signal.c	Wed Sep 18 00:18:06 2002
@@ -943,19 +943,31 @@
 
 int __kill_pg_info(int sig, struct siginfo *info, pid_t pgrp)
 {
-	int retval = -EINVAL;
-	if (pgrp > 0) {
-		struct task_struct *p;
-
-		retval = -ESRCH;
-		for_each_process(p) {
-			if (p->pgrp == pgrp) {
-				int err = send_sig_info(sig, info, p);
-				if (retval)
-					retval = err;
-			}
-		}
+	task_t *task;
+	struct list_head *elem;
+	struct idtag *idtag;
+	int err, retval = -EINVAL;
+
+	if (pgrp <= 0)
+		goto out;
+
+	retval = -ESRCH;
+	idtag = find_get_tag(IDTAG_PGID, pgrp);
+	if (!idtag)
+		goto out;
+
+	list_for_each(elem, &idtag->task_list) {
+		task = idtag_task(elem, IDTAG_PGID);
+
+		if (!thread_group_leader(task))
+			continue;
+
+		err = send_sig_info(sig, info, task);
+		if (retval)
+			retval = err;
 	}
+	put_tag(idtag);
+out:
 	return retval;
 }
 
@@ -977,42 +989,65 @@
  * the connection is lost.
  */
 
+
 int
-kill_sl_info(int sig, struct siginfo *info, pid_t sess)
+kill_sl_info(int sig, struct siginfo *info, pid_t sid)
 {
-	int retval = -EINVAL;
-	if (sess > 0) {
-		struct task_struct *p;
-
-		retval = -ESRCH;
-		read_lock(&tasklist_lock);
-		for_each_process(p) {
-			if (p->leader && p->session == sess) {
-				int err = send_sig_info(sig, info, p);
-				if (retval)
-					retval = err;
-			}
-		}
-		read_unlock(&tasklist_lock);
+	int err, retval = -EINVAL;
+	struct idtag *idtag;
+	struct list_head *elem;
+	task_t *task;
+
+	if (sid <= 0)
+		goto out;
+
+	retval = -ESRCH;
+	read_lock(&tasklist_lock);
+	idtag = find_get_tag(IDTAG_SID, sid);
+	if (!idtag)
+		goto out_unlock;
+	list_for_each(elem, &idtag->task_list) {
+		task = idtag_task(elem, IDTAG_SID);
+		if (!task->leader)
+			continue;
+
+		err = send_sig_info(sig, info, task);
+		if (retval)
+			retval = err;
 	}
+	put_tag(idtag);
+out_unlock:
+	read_unlock(&tasklist_lock);
+out:
 	return retval;
 }
 
-inline int
+int
 kill_proc_info(int sig, struct siginfo *info, pid_t pid)
 {
 	int error;
-	struct task_struct *p;
+	task_t *task;
+	task_t *tgrp_leader;
 
 	read_lock(&tasklist_lock);
-	p = find_task_by_pid(pid);
+	task = find_task_by_pid(pid);
 	error = -ESRCH;
-	if (p)
-		error = send_sig_info(sig, info, p);
+	if (!task)
+		goto out_unlock;
+
+	if (thread_group_leader(task))
+		goto out_send_sig;
+
+	tgrp_leader = find_task_by_pid(task->tgid);
+	if (tgrp_leader)
+		task = tgrp_leader;
+out_send_sig:
+	error = send_sig_info(sig, info, task);
+out_unlock:
 	read_unlock(&tasklist_lock);
+
 	return error;
 }
-
 
 /*
  * kill_something_info() interprets pid in interesting ways just like kill(2).
--- linux/kernel/sys.c.orig	Wed Sep 18 00:16:43 2002
+++ linux/kernel/sys.c	Wed Sep 18 00:18:06 2002
@@ -203,35 +203,34 @@
 cond_syscall(sys_quotactl)
 cond_syscall(sys_acct)
 
-static int proc_sel(struct task_struct *p, int which, int who)
+static int set_one_prio(task_t *task, int niceval, int error)
 {
-	if(p->pid)
-	{
-		switch (which) {
-			case PRIO_PROCESS:
-				if (!who && p == current)
-					return 1;
-				return(p->pid == who);
-			case PRIO_PGRP:
-				if (!who)
-					who = current->pgrp;
-				return(p->pgrp == who);
-			case PRIO_USER:
-				if (!who)
-					who = current->uid;
-				return(p->uid == who);
-		}
+	if (task->uid != current->euid &&
+		task->uid != current->uid && !capable(CAP_SYS_NICE)) {
+		error = -EPERM;
+		goto out;
 	}
-	return 0;
+
+	if (error == -ESRCH)
+		error = 0;
+	if (niceval < task_nice(task) && !capable(CAP_SYS_NICE))
+		error = -EACCES;
+	else
+		set_user_nice(task, niceval);
+out:
+	return error;
 }
 
 asmlinkage long sys_setpriority(int which, int who, int niceval)
 {
-	struct task_struct *g, *p;
-	int error;
+	task_t *task;
+	struct user_struct *user;
+	struct idtag *idtag;
+	struct list_head *elem;
+	int error = -EINVAL;
 
 	if (which > 2 || which < 0)
-		return -EINVAL;
+		goto out;
 
 	/* normalize: avoid signed division (rounding problems) */
 	error = -ESRCH;
@@ -241,31 +240,53 @@
 		niceval = 19;
 
 	read_lock(&tasklist_lock);
-	do_each_thread(g, p) {
-		int no_nice;
-		if (!proc_sel(p, which, who))
-			continue;
-		if (p->uid != current->euid &&
-			p->uid != current->uid && !capable(CAP_SYS_NICE)) {
-			error = -EPERM;
-			continue;
-		}
-		if (error == -ESRCH)
-			error = 0;
-		if (niceval < task_nice(p) && !capable(CAP_SYS_NICE)) {
-			error = -EACCES;
-			continue;
-		}
-		no_nice = security_ops->task_setnice(p, niceval);
-		if (no_nice) {
-			error = no_nice;
-			continue;
-		}
-		set_user_nice(p, niceval);
-	} while_each_thread(g, p);
-
+	switch (which) {
+		case PRIO_PROCESS:
+			if (!who)
+				who = current->pid;
+			idtag = find_get_tag(IDTAG_PID, who);
+			if (!idtag)
+				goto out_unlock;
+
+			list_for_each(elem, &idtag->task_list) {
+				task = idtag_task(elem, IDTAG_PID);
+				error = set_one_prio(task, niceval, error);
+			}
+			put_tag(idtag);
+			break;
+		case PRIO_PGRP:
+			if (!who)
+				who = current->pgrp;
+			idtag = find_get_tag(IDTAG_PGID, who);
+			if (!idtag)
+				goto out_unlock;
+
+			list_for_each(elem, &idtag->task_list) {
+				task = idtag_task(elem, IDTAG_PGID);
+				error = set_one_prio(task, niceval, error);
+			}
+			put_tag(idtag);
+			break;
+		case PRIO_USER:
+			if (!who)
+				user = current->user;
+			else
+				user = find_user(who);
+
+			if (!user)
+				goto out_unlock;
+
+			read_lock(&user->lock);
+			list_for_each(elem, &user->task_list) {
+				task = list_entry(elem, task_t, user_task_list);
+				error = set_one_prio(task, niceval, error);
+			}
+			read_unlock(&user->lock);
+			break;
+	}
+out_unlock:
 	read_unlock(&tasklist_lock);
-
+out:
 	return error;
 }
 
@@ -277,21 +298,67 @@
  */
 asmlinkage long sys_getpriority(int which, int who)
 {
-	struct task_struct *g, *p;
-	long retval = -ESRCH;
+	task_t *task;
+	struct list_head *elem;
+	struct idtag *idtag;
+	struct user_struct *user;
+	long niceval, retval = -ESRCH;
 
 	if (which > 2 || which < 0)
 		return -EINVAL;
 
 	read_lock(&tasklist_lock);
-	do_each_thread(g, p) {
-		long niceval;
-		if (!proc_sel(p, which, who))
-			continue;
-		niceval = 20 - task_nice(p);
-		if (niceval > retval)
-			retval = niceval;
-	} while_each_thread(g, p);
+	switch (which) {
+		case PRIO_PROCESS:
+			if (!who)
+				who = current->pid;
+			idtag = find_get_tag(IDTAG_PID, who);
+			if (!idtag)
+				goto out_unlock;
+
+			list_for_each(elem, &idtag->task_list) {
+				task = idtag_task(elem, IDTAG_PID);
+				niceval = 20 - task_nice(task);
+				if (niceval > retval)
+					retval = niceval;
+			}
+			put_tag(idtag);
+			break;
+		case PRIO_PGRP:
+			if (!who)
+				who = current->pgrp;
+			idtag = find_get_tag(IDTAG_PGID, who);
+			if (!idtag)
+				goto out_unlock;
+
+			list_for_each(elem, &idtag->task_list) {
+				task = idtag_task(elem, IDTAG_PGID);
+				niceval = 20 - task_nice(task);
+				if (niceval > retval)
+					retval = niceval;
+			}
+			put_tag(idtag);
+			break;
+		case PRIO_USER:
+			if (!who)
+				user = current->user;
+			else
+				user = find_user(who);
+
+			if (!user)
+				goto out_unlock;
+
+			read_lock(&user->lock);
+			list_for_each(elem, &user->task_list) {
+				task = list_entry(elem, task_t, user_task_list);
+				niceval = 20 - task_nice(task);
+				if (niceval > retval)
+					retval = niceval;
+			}
+			read_unlock(&user->lock);
+			break;
+	}
+out_unlock:
 	read_unlock(&tasklist_lock);
 
 	return retval;
@@ -524,16 +591,24 @@
 	if (!new_user)
 		return -EAGAIN;
 	old_user = current->user;
+
+	write_lock(&old_user->lock);
 	atomic_dec(&old_user->processes);
+	list_del(&current->user_task_list);
+	write_unlock(&old_user->lock);
+
+	write_lock(&new_user->lock);
 	atomic_inc(&new_user->processes);
+	list_add(&current->user_task_list, &new_user->task_list);
+	current->uid = new_ruid;
+	current->user = new_user;
+	write_unlock(&new_user->lock);
 
 	if(dumpclear)
 	{
 		current->mm->dumpable = 0;
 		wmb();
 	}
-	current->uid = new_ruid;
-	current->user = new_user;
 	free_uid(old_user);
 	return 0;
 }
@@ -849,7 +924,7 @@
 
 asmlinkage long sys_setpgid(pid_t pid, pid_t pgid)
 {
-	struct task_struct * p;
+	task_t *p;
 	int err = -EINVAL;
 
 	if (!pid)
@@ -868,6 +943,9 @@
 	p = find_task_by_pid(pid);
 	if (!p)
 		goto out;
+	err = -EINVAL;
+	if (!thread_group_leader(p))
+		goto out;
 
 	if (p->parent == current || p->real_parent == current) {
 		err = -EPERM;
@@ -882,21 +960,28 @@
 	if (p->leader)
 		goto out;
 	if (pgid != pid) {
-		struct task_struct *g, *tmp;
-		do_each_thread(g, tmp) {
-			if (tmp->pgrp == pgid &&
-			    tmp->session == current->session)
+		task_t * task;
+		struct idtag *idtag;
+		struct list_head *elem;
+
+		idtag = find_get_tag(IDTAG_PGID, pgid);
+		if (!idtag)
+			goto out;
+
+		list_for_each(elem, &idtag->task_list) {
+			task = idtag_task(elem, IDTAG_PGID);
+
+			if (task->session == current->session)
 				goto ok_pgid;
-		} while_each_thread(g, tmp);
+		}
+		put_tag(idtag);
 		goto out;
 	}
 
 ok_pgid:
-	err = security_ops->task_setpgid(p, pgid);
-	if (err)
-		goto out;
-
+	detach_tag(p, IDTAG_PGID);
 	p->pgrp = pgid;
+	attach_tag(p, IDTAG_PGID, pgid);
 	err = 0;
 out:
 	/* All paths lead to here, thus we are safe. -DaveM */
@@ -956,17 +1041,27 @@
 
 asmlinkage long sys_setsid(void)
 {
-	struct task_struct *g, *p;
+	struct idtag *idtag;
 	int err = -EPERM;
 
+	if (!thread_group_leader(current))
+		return -EINVAL;
+
 	read_lock(&tasklist_lock);
-	do_each_thread(g, p)
-		if (p->pgrp == current->pid)
-			goto out;
-	while_each_thread(g, p);
+
+	idtag = find_get_tag(IDTAG_PGID, current->pid);
+
+	if (idtag) {
+		put_tag(idtag);
+		goto out;
+	}
 
 	current->leader = 1;
+	detach_tag(current, IDTAG_PGID);
+	detach_tag(current, IDTAG_SID);
 	current->session = current->pgrp = current->pid;
+	attach_tag(current, IDTAG_PGID, current->pid);
+	attach_tag(current, IDTAG_SID, current->pid);
 	current->tty = NULL;
 	current->tty_old_pgrp = 0;
 	err = current->pgrp;
--- linux/kernel/fork.c.orig	Wed Sep 18 00:16:43 2002
+++ linux/kernel/fork.c	Wed Sep 18 00:18:06 2002
@@ -47,15 +47,6 @@
 int max_threads;
 unsigned long total_forks;	/* Handle normal Linux uptimes. */
 
-/*
- * Protects next_safe, last_pid and pid_max:
- */
-spinlock_t lastpid_lock = SPIN_LOCK_UNLOCKED;
-
-static int next_safe = DEFAULT_PID_MAX;
-int pid_max = DEFAULT_PID_MAX;
-int last_pid;
-
 struct task_struct *pidhash[PIDHASH_SZ];
 
 rwlock_t tasklist_lock __cacheline_aligned = RW_LOCK_UNLOCKED;  /* outer */
@@ -84,7 +75,6 @@
 	}
 }
 
-/* Protects next_safe and last_pid. */
 void add_wait_queue(wait_queue_head_t *q, wait_queue_t * wait)
 {
 	unsigned long flags;
@@ -159,52 +149,6 @@
 	return tsk;
 }
 
-static int get_pid(unsigned long flags)
-{
-	struct task_struct *g, *p;
-	int pid;
-
-	if (flags & CLONE_IDLETASK)
-		return 0;
-
-	spin_lock(&lastpid_lock);
-	if (++last_pid > pid_max) {
-		last_pid = 300;		/* Skip daemons etc. */
-		goto inside;
-	}
-
-	if (last_pid >= next_safe) {
-inside:
-		next_safe = pid_max;
-		read_lock(&tasklist_lock);
-	repeat:
-		do_each_thread(g, p) {
-			if (p->pid == last_pid	||
-			   p->pgrp == last_pid	||
-			   p->session == last_pid) {
-				if (++last_pid >= next_safe) {
-					if (last_pid >= pid_max)
-						last_pid = 300;
-					next_safe = pid_max;
-				}
-				goto repeat;
-			}
-			if (p->pid > last_pid && next_safe > p->pid)
-				next_safe = p->pid;
-			if (p->pgrp > last_pid && next_safe > p->pgrp)
-				next_safe = p->pgrp;
-			if (p->session > last_pid && next_safe > p->session)
-				next_safe = p->session;
-		} while_each_thread(g, p);
-
-		read_unlock(&tasklist_lock);
-	}
-	pid = last_pid;
-	spin_unlock(&lastpid_lock);
-
-	return pid;
-}
-
 static inline int dup_mmap(struct mm_struct * mm)
 {
 	struct vm_area_struct * mpnt, *tmp, **pprev;
@@ -696,8 +640,11 @@
 			goto bad_fork_free;
 	}
 
+	write_lock(&p->user->lock);
 	atomic_inc(&p->user->__count);
 	atomic_inc(&p->user->processes);
+	list_add(&p->user_task_list, &p->user->task_list);
+	write_unlock(&p->user->lock);
 
 	/*
 	 * Counter increases are protected by
@@ -724,7 +671,13 @@
 	p->state = TASK_UNINTERRUPTIBLE;
 
 	copy_flags(clone_flags, p);
-	p->pid = get_pid(clone_flags);
+	if (clone_flags & CLONE_IDLETASK)
+		p->pid = 0;
+	else {
+		p->pid = alloc_pid();
+		if (p->pid == -1)
+			goto bad_fork_cleanup;
+	}
 	p->proc_dentry = NULL;
 
 	INIT_LIST_HEAD(&p->run_list);
@@ -887,9 +840,16 @@
 	SET_LINKS(p);
 	if (p->ptrace & PT_PTRACED)
 		__ptrace_link(p, current->parent);
+	attach_tag(p, IDTAG_PID, p->pid);
+	if (thread_group_leader(p)) {
+		attach_tag(p, IDTAG_TGID, p->tgid);
+		attach_tag(p, IDTAG_PGID, p->pgrp);
+		attach_tag(p, IDTAG_SID, p->session);
+	}
 	hash_pid(p);
 	nr_threads++;
 	write_unlock_irq(&tasklist_lock);
+
 	retval = 0;
 
 fork_out:
@@ -912,6 +872,8 @@
 bad_fork_cleanup_security:
 	security_ops->task_free_security(p);
 bad_fork_cleanup:
+	if (p->pid > 0)
+		free_pid(p->pid);
 	put_exec_domain(p->thread_info->exec_domain);
 	if (p->binfmt && p->binfmt->module)
 		__MOD_DEC_USE_COUNT(p->binfmt->module);
--- linux/kernel/user.c.orig	Wed Sep 18 00:16:36 2002
+++ linux/kernel/user.c	Wed Sep 18 00:18:06 2002
@@ -30,6 +30,8 @@
 struct user_struct root_user = {
 	.__count	= ATOMIC_INIT(1),
 	.processes	= ATOMIC_INIT(1),
+	.lock		= RW_LOCK_UNLOCKED,
+	.task_list	= LIST_HEAD_INIT(root_user.task_list),
 	.files		= ATOMIC_INIT(0)
 };
 
@@ -64,6 +66,11 @@
 	return NULL;
 }
 
+struct user_struct *find_user(uid_t uid)
+{
+	return uid_hash_find(uid, uidhashentry(uid));
+}
+
 void free_uid(struct user_struct *up)
 {
 	if (up && atomic_dec_and_lock(&up->__count, &uidhash_lock)) {
@@ -92,6 +99,8 @@
 		atomic_set(&new->__count, 1);
 		atomic_set(&new->processes, 0);
 		atomic_set(&new->files, 0);
+		INIT_LIST_HEAD(&new->task_list);
+		rwlock_init(&new->lock);
 
 		/*
 		 * Before adding this, check whether we raced
--- linux/init/main.c.orig	Wed Sep 18 00:16:43 2002
+++ linux/init/main.c	Wed Sep 18 00:18:06 2002
@@ -66,6 +66,7 @@
 extern void sysctl_init(void);
 extern void signals_init(void);
 extern void buffer_init(void);
+extern void idtag_init(void);
 extern void pte_chain_init(void);
 extern void radix_tree_init(void);
 extern void free_initmem(void);
@@ -432,6 +433,7 @@
 #endif
 	mem_init();
 	kmem_cache_sizes_init();
+	idtag_init();
 	pgtable_cache_init();
 	pte_chain_init();
 	fork_init(num_physpages);

