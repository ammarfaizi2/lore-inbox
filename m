Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbTESJWn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 05:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbTESJWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 05:22:43 -0400
Received: from mx1.elte.hu ([157.181.1.137]:39601 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id S261827AbTESJWi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 05:22:38 -0400
Date: Mon, 19 May 2003 11:31:51 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       Ulrich Drepper <drepper@redhat.com>
Subject: [patch] futex requeueing feature, futex-requeue-2.5.69-D3
Message-ID: <Pine.LNX.4.44.0305191103500.5653-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch addresses a futex related SMP scalability problem of
glibc. A number of regressions have been reported to the NTPL mailing list
when going to many CPUs, for applications that use condition variables and
the pthread_cond_broadcast() API call. Using this functionality, testcode
shows a slowdown from 0.12 seconds runtime to over 237 seconds (!)  
runtime, on 4-CPU systems.

pthread condition variables use two futex-backed mutex-alike locks: an
internal one for the glibc CV state itself, and a user-supplied mutex
which the API guarantees to take in certain codepaths. (Unfortunately the
user-supplied mutex cannot be used to protect the CV state, so we've got
to deal with two locks.)

The cause of the slowdown is a 'swarm effect': if lots of threads are
blocked on a condition variable, and pthread_cond_broadcast() is done,
then glibc first does a FUTEX_WAKE on the cv-internal mutex, then down a
mutex_down() on the user-supplied mutex. Ie. a swarm of threads is created
which all race to serialize on the user-supplied mutex. The more threads
are used, the more likely it becomes that the scheduler will balance them
over to other CPUs - where they just schedule, try to lock the mutex, and
go to sleep. This 'swarm effect' is purely technical, a side-effect of
glibc's use of futexes, and the imperfect coupling of the two locks.

the solution to this problem is to not wake up the swarm of threads, but
'requeue' them from the CV-internal mutex to the user-supplied mutex. The
attached patch adds the FUTEX_REQUEUE feature FUTEX_REQUEUE requeues N
threads from futex address A to futex address B:

	sys_futex(uaddr, FUTEX_REQUEUE, nr_wake, NULL, uaddr2);

the 'val' parameter to sys_futex (nr_wake) is the # of woken up threads.  
This way glibc can wake up a single thread (which will take the
user-mutex), and can requeue the rest, with a single system-call.

Ulrich Drepper has implemented FUTEX_REQUEUE support in glibc, and a
number of people have tested it over the past couple of weeks. Here are
the measurements done by Saurabh Desai:

System: 4xPIII 700MHz

 ./cond-perf -r 100 -n 200:        1p       2p         4p
 Default NPTL:                 0.120s   0.211s   237.407s
 requeue NPTL:                 0.124s   0.156s     0.040s

 ./cond-perf -r 1000 -n 100:
 Default NPTL:                 0.276s   0.412s     0.530s
 requeue NPTL:                 0.349s   0.503s     0.550s

 ./pp -v -n 128 -i 1000 -S 32768:
 Default NPTL: 128 games in    1.111s   1.270s    16.894s
 requeue NPTL: 128 games in    1.111s   1.959s     2.426s

 ./pp -v -n 1024 -i 10 -S 32768:
 Default NPTL: 1024 games in   0.181s   0.394s     incompleted 2m+
 requeue NPTL: 1024 games in   0.166s   0.254s     0.341s

the speedup with increasing number of threads is quite significant, in the
128 threads, case it's more than 8 times. In the cond-perf test, on 4 CPUs
it's almost infinitely faster than the 'swarm of threads' catastrophy
triggered by the old code.

there's a slowdown on UP, which is expected: on UP the O(1) scheduler
implicitly serializes all active threads on the runqueue, and doesnt
degrade under lots of threads. On SMP the 'point of breakdown' depends on
the precise amount of time needed for the threads to become rated as
'cache-cold' by the load-balancer.

(the patch adds a new futex syscall parameter (uaddr2), which is a
compatible extension of sys_futex. Old NPTL applications will continue to
work without any impact, only the FUTEX_REQUEUE codepath uses the new
parameter.)

	Ingo

--- linux/include/linux/futex.h.orig	
+++ linux/include/linux/futex.h	
@@ -5,7 +5,8 @@
 #define FUTEX_WAIT (0)
 #define FUTEX_WAKE (1)
 #define FUTEX_FD (2)
+#define FUTEX_REQUEUE (3)
 
-extern asmlinkage long sys_futex(u32 __user *uaddr, int op, int val, struct timespec __user *utime);
+extern asmlinkage long sys_futex(u32 __user *uaddr, int op, int val, struct timespec __user *utime, u32 __user *uaddr2);
 
 #endif
--- linux/kernel/fork.c.orig	
+++ linux/kernel/fork.c	
@@ -457,7 +457,7 @@ void mm_release(struct task_struct *tsk,
 		 * not set up a proper pointer then tough luck.
 		 */
 		put_user(0, tidptr);
-		sys_futex(tidptr, FUTEX_WAKE, 1, NULL);
+		sys_futex(tidptr, FUTEX_WAKE, 1, NULL, NULL);
 	}
 }
 
--- linux/kernel/compat.c.orig	
+++ linux/kernel/compat.c	
@@ -214,7 +214,7 @@ asmlinkage long compat_sys_sigprocmask(i
 extern long do_futex(unsigned long, int, int, unsigned long);
 
 asmlinkage long compat_sys_futex(u32 *uaddr, int op, int val,
-		struct compat_timespec *utime)
+		struct compat_timespec *utime, u32 *uaddr2)
 {
 	struct timespec t;
 	unsigned long timeout = MAX_SCHEDULE_TIMEOUT;
@@ -224,7 +224,7 @@ asmlinkage long compat_sys_futex(u32 *ua
 			return -EFAULT;
 		timeout = timespec_to_jiffies(&t) + 1;
 	}
-	return do_futex((unsigned long)uaddr, op, val, timeout);
+	return do_futex((unsigned long)uaddr, op, val, timeout, (unsigned long)uaddr2);
 }
 
 asmlinkage long sys_setrlimit(unsigned int resource, struct rlimit *rlim);
--- linux/kernel/futex.c.orig	
+++ linux/kernel/futex.c	
@@ -2,6 +2,9 @@
  *  Fast Userspace Mutexes (which I call "Futexes!").
  *  (C) Rusty Russell, IBM 2002
  *
+ *  Generalized futexes, futex requeueing, misc fixes by Ingo Molnar
+ *  (C) Copyright 2003 Red Hat Inc, All Rights Reserved
+ *
  *  Thanks to Ben LaHaise for yelling "hashed waitqueues" loudly
  *  enough at me, Linus for the original (flawed) idea, Matthew
  *  Kirkwood for proof-of-concept implementation.
@@ -9,9 +12,6 @@
  *  "The futexes are also cursed."
  *  "But they come in a choice of three flavours!"
  *
- *  Generalized futexes for every mapping type, Ingo Molnar, 2002
- *
- *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
  *  the Free Software Foundation; either version 2 of the License, or
@@ -216,6 +216,61 @@ static void futex_vcache_callback(vcache
 	spin_unlock(&futex_lock);
 }
 
+/*
+ * Requeue all waiters hashed on one physical page to another
+ * physical page.
+ */
+static int futex_requeue(unsigned long uaddr1, int offset1, unsigned long uaddr2, int offset2, int num)
+{
+	struct list_head *i, *next, *head1, *head2;
+	struct page *page1, *page2;
+	int ret = 0;
+
+	lock_futex_mm();
+
+	page1 = __pin_page(uaddr1 - offset1);
+	if (!page1) {
+		unlock_futex_mm();
+		return -EFAULT;
+	}
+	page2 = __pin_page(uaddr2 - offset2);
+	if (!page2) {
+		unlock_futex_mm();
+		return -EFAULT;
+	}
+
+	head1 = hash_futex(page1, offset1);
+	head2 = hash_futex(page2, offset2);
+
+	list_for_each_safe(i, next, head1) {
+		struct futex_q *this = list_entry(i, struct futex_q, list);
+
+		if (this->page == page1 && this->offset == offset1) {
+			list_del_init(i);
+			__detach_vcache(&this->vcache);
+			if (++ret <= num) {
+				wake_up_all(&this->waiters);
+				if (this->filp)
+					send_sigio(&this->filp->f_owner, this->fd, POLL_IN);
+			} else {
+				unpin_page(this->page);
+				__pin_page_atomic (page2);
+				list_add_tail(i, head2);
+				__attach_vcache(&this->vcache, uaddr2, current->mm, futex_vcache_callback);
+				this->offset = offset2;
+				this->page = page2;
+			}
+		}
+	}
+
+	unlock_futex_mm();
+
+	unpin_page(page1);
+	unpin_page(page2);
+
+	return ret;
+}
+
 static inline void __queue_me(struct futex_q *q, struct page *page,
 				unsigned long uaddr, int offset,
 				int fd, struct file *filp)
@@ -425,9 +480,9 @@ out:
 	return ret;
 }
 
-long do_futex(unsigned long uaddr, int op, int val, unsigned long timeout)
+long do_futex(unsigned long uaddr, int op, int val, unsigned long timeout, unsigned long uaddr2)
 {
-	unsigned long pos_in_page;
+	unsigned long pos_in_page, pos_in_page2;
 	int ret;
 
 	pos_in_page = uaddr % PAGE_SIZE;
@@ -443,6 +498,14 @@ long do_futex(unsigned long uaddr, int o
 	case FUTEX_WAKE:
 		ret = futex_wake(uaddr, pos_in_page, val);
 		break;
+	case FUTEX_REQUEUE:
+		pos_in_page2 = uaddr2 % PAGE_SIZE;
+
+		/* Must be "naturally" aligned */
+		if (pos_in_page2 % sizeof(u32))
+			return -EINVAL;
+		ret = futex_requeue(uaddr, pos_in_page, uaddr2, pos_in_page2, val);
+		break;
 	case FUTEX_FD:
 		/* non-zero val means F_SETOWN(getpid()) & F_SETSIG(val) */
 		ret = futex_fd(uaddr, pos_in_page, val);
@@ -453,7 +516,7 @@ long do_futex(unsigned long uaddr, int o
 	return ret;
 }
 
-asmlinkage long sys_futex(u32 __user *uaddr, int op, int val, struct timespec __user *utime)
+asmlinkage long sys_futex(u32 __user *uaddr, int op, int val, struct timespec __user *utime, u32 __user *uaddr2)
 {
 	struct timespec t;
 	unsigned long timeout = MAX_SCHEDULE_TIMEOUT;
@@ -463,7 +526,7 @@ asmlinkage long sys_futex(u32 __user *ua
 			return -EFAULT;
 		timeout = timespec_to_jiffies(&t) + 1;
 	}
-	return do_futex((unsigned long)uaddr, op, val, timeout);
+	return do_futex((unsigned long)uaddr, op, val, timeout, (unsigned long)uaddr2);
 }
 
 static struct super_block *


