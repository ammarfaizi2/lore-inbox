Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135975AbRDTQzt>; Fri, 20 Apr 2001 12:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135977AbRDTQzn>; Fri, 20 Apr 2001 12:55:43 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:15947 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135976AbRDTQz3>; Fri, 20 Apr 2001 12:55:29 -0400
Date: Fri, 20 Apr 2001 19:17:10 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "D . W . Howells" <dhowells@astarte.free-online.co.uk>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: x86 rwsem in 2.4.4pre[234] are still buggy [was Re: rwsem benchmarks [Re: generic rwsem [Re: Alpha "process table hang"]]]
Message-ID: <20010420191710.A32159@athlon.random>
In-Reply-To: <01042000280900.01311@orion.ddi.co.uk> <20010420034215.K752@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010420034215.K752@athlon.random>; from andrea@suse.de on Fri, Apr 20, 2001 at 03:42:15AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2001 at 03:42:15AM +0200, Andrea Arcangeli wrote:
> I'm uncertain if I should drop the list_empty() check from the fast path and if

While dropping the list_empty check to speed up the fast path I faced the same
complexity of the 2.4.4pre4 lib/rwsem.c and so before reinventing the wheel I
read how the problem was solved in 2.4.4pre4.

I couldn't get convinced that all the subtle possible cases was handled
correctly so I tried to stress them. To do that I changed the 2.4.4pre4 rwsem
(compiled for PII SMP) as below patch shows in order to reproduce more easily
those corner cases (note my changes cannot be the cause of the deadlock, as far
I can tell they can _only_ change the timings, and the timings have to be
flexible because they can be randomly influenced by interrupt handlers machine
checks and whatever else in whatever hardware): 

--- rwsemref-1/lib/rwsem.c.~1~	Thu Apr 19 19:59:46 2001
+++ rwsemref-1/lib/rwsem.c	Fri Apr 20 17:13:05 2001
@@ -6,6 +6,7 @@
 #include <linux/rwsem.h>
 #include <linux/sched.h>
 #include <linux/module.h>
+#include <linux/delay.h>
 
 /*
  * wait for the read lock to be granted
@@ -18,6 +19,7 @@
 	DECLARE_WAITQUEUE(wait,tsk);
 	signed long count;
 
+	mdelay(1);
 	rwsemtrace(sem,"Entering rwsem_down_read_failed");
 
 	/* this waitqueue context flag will be cleared when we are granted the lock */
@@ -59,6 +61,7 @@
 	DECLARE_WAITQUEUE(wait,tsk);
 	signed long count;
 
+	mdelay(1);
 	rwsemtrace(sem,"Entering rwsem_down_write_failed");
 
 	/* this waitqueue context flag will be cleared when we are granted the lock */
@@ -115,6 +118,7 @@
 		goto out;
 	}
 
+	mdelay(1);
 	/* try to grant a single write lock if there's a writer at the front of the queue
 	 * - note we leave the 'active part' of the count incremented by 1 and the waiting part
 	 *   incremented by 0x00010000
@@ -122,6 +126,7 @@
 	if (wake_up_ctx(&sem->wait,1,-RWSEM_WAITING_FOR_WRITE)==1)
 		goto out;
 
+	mdelay(10);
 	/* grant an infinite number of read locks to the readers at the front of the queue
 	 * - note we increment the 'active part' of the count by the number of readers just woken,
 	 *   less one for the activity decrement we've already done
@@ -129,6 +134,7 @@
 	woken = wake_up_ctx(&sem->wait,65535,-RWSEM_WAITING_FOR_READ);
 	if (woken<=0)
 		goto counter_correction;
+	mdelay(1);
 
 	woken *= RWSEM_ACTIVE_BIAS-RWSEM_WAITING_BIAS;
 	woken -= RWSEM_ACTIVE_BIAS;

and I succeeded in deadlocking the 2.4.4pre[2345] rwsemaphores with kernel
looping forever in 2.4.4pre4/lib/rwsem.c:rwsem_wake() but at least the breakage
is 100% reproducible if you use the above patch.

All you have to do to reproduce is to apply the above patch and then to run the
rwsem proggy that I posted to the list two days ago (the one that shows my
latest -5/6 revisions to be just a bit faster in the slow path) that does the
mmap and page faults from different threads in loop, in another console you run
`while :; do ps xa; done`, then while `ps` is near the end of its run you kill
the parent thread of the rwsem testcase so that all thread-children gets killed
as well, and at that point `ps` deadlocks hard in R state unkillable (it keeps
looping forever in the try_again: counter_correction: paths).

[..]
  285 ?        SW     0:00 [rpciod]
  461 ?        S      0:00 /usr/sbin/inetd
  463 tty1     S      0:00 /sbin/mingetty --noclear tty1
  464 tty2     S      0:00 /sbin/mingetty tty2
  465 tty3     S      0:00 /sbin/mingetty tty3
  466 tty4     S      0:00 /sbin/mingetty tty4
  467 tty5     S      0:00 /sbin/mingetty tty5
  468 tty6     S      0:00 /sbin/mingetty tty6
  469 ?        S      0:00 in.rlogind
  470 pts/0    S      0:00 login -- andrea
  471 pts/0    S      0:00 -bash
  530 ?        S      0:00 in.rlogind
  531 pts/1    S      0:00 login -- andrea
  532 pts/1    S      0:00 -bash
  666 pts/1    R      0:00 ps xa
  667 pts/0    S      0:00 ./rwsem
  668 pts/0    R      0:00 ./rwsem
  669 pts/0    D      0:00 ./rwsem
  670 pts/0    D      0:00 ./rwsem
  671 pts/0    D      0:00 ./rwsem
  672 pts/0    D      0:00 ./rwsem
  673 pts/0    D      0:00 ./rwsem
  674 pts/0    D      0:00 ./rwsem
  675 pts/0    D      0:00 ./rwsem
  676 pts/0    D      0:00 ./rwsem
  677 pts/0    R      0:00 ./rwsem
  678 pts/0    D      0:00 ./rwsem
  679 pts/0    D      0:00 ./rwsem
  680 pts/0    D      0:00 ./rwsem
  681 pts/0    D      0:00 ./rwsem
  682 pts/0    D      0:00 ./rwsem
  683 pts/0    D      0:00 ./rwsem
  684 pts/0    D      0:00 ./rwsem
  685 pts/0    D      0:00 ./rwsem
  686 pts/0    D      0:00 ./rwsem
  687 pts/0    D      0:00 ./rwsem
  688 pts/0    R      0:00 ./rwsem
  689 pts/0    D      0:00 ./rwsem
  690 pts/0    D      0:00 ./rwsem
  691 pts/0    D      0:00 ./rwsem
  692 pts/0    D      0:00 ./rwsem
  693 pts/0    D      0:00 ./rwsem
  694 pts/0    D      0:00 ./rwsem
  695 pts/0    D      0:00 ./rwsem
  696 pts/0    D      0:00 ./rwsem
  697 pts/0    D      0:00 ./rwsem
  698 pts/0    D      0:00 ./rwsem
  699 pts/0    D      0:00 ./rwsem
  700 pts/0    D      0:00 ./rwsem
  701 pts/0    D      0:00 ./rwsem
  702 pts/0    D      0:00 ./rwsem
  703 pts/0    D      0:00 ./rwsem
[ hang here ]

from another terminal:

andrea@laser:~ > kill 666
andrea@laser:~ > kill 666
andrea@laser:~ > kill 666
andrea@laser:~ > kill 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > ps 666
  PID TTY      STAT   TIME COMMAND
  666 pts/1    R      0:31 ps xa
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > kill -9 666
andrea@laser:~ > ps 666
  PID TTY      STAT   TIME COMMAND
  666 pts/1    R     53:38 ps xa
andrea@laser:~ > 

At first I had a short look to check if this bug could be unrelated to the rwsem and
to be instead a race between the /proc filesystem and the do_exit path, but
after a short review of the interesting places the task_lock seems to serialize
correctly the accesses to the tsk->mm so the semaphore shouldn't go away under
rwsem_wake and furthmore it would be quite strange if the mm goes away under
the /proc filesystem that it only reproducibly fails in the same way in
rwsem_wake and I never get other system malfunctions for example while reading
the contents of the mm.

As further confirm this is a bug in the rwsemaphores I changed your benchmark
to be a little more aggressive:

--- rwsem-rw.c.orig	Thu Apr 19 22:37:27 2001
+++ rwsem-rw.c	Fri Apr 20 18:56:06 2001
@@ -71,9 +71,8 @@
 
 static inline void sched(void)
 {
-#ifdef SCHED
-	schedule();
-#endif
+	if (current->need_resched)
+		schedule();
 }
 
 int reader(void *arg)
@@ -86,8 +85,8 @@
 
 	while (atomic_read(&do_stuff)) {
 		dr();
-		ur();
 		sched();
+		ur();
 	}
 
 	atomic_dec(&runners);
@@ -105,8 +104,8 @@
 
 	while (atomic_read(&do_stuff)) {
 		dw();
-		uw();
 		sched();
+		uw();
 	}
 
 	atomic_dec(&runners);
@@ -125,22 +124,64 @@
 
 	init_rwsem(&rwsem_sem);
 	atomic_set(&do_stuff, 1);
+	wmb();
 
 #ifdef DEBUG_RWSEM
 	rwsem_to_monitor = &rwsem_sem;
 #endif
 	init_timer(&timer);
 	timer.function = stop_test;
-	timer.expires = jiffies + 5 * HZ;
+	timer.expires = jiffies + 50 * HZ;
 	add_timer(&timer);
 
-	kernel_thread(writer, "WriteA", 0);
-	kernel_thread(writer, "WriteB", 0);
-
-	kernel_thread(reader, "ReadA", 0);
-	kernel_thread(reader, "ReadB", 0);
-	kernel_thread(reader, "ReadC", 0);
-	kernel_thread(reader, "ReadD", 0);
+	kernel_thread(writer, "Write0", 0);
+	kernel_thread(writer, "Write1", 0);
+	kernel_thread(writer, "Write2", 0);
+	kernel_thread(writer, "Write3", 0);
+	kernel_thread(writer, "Write4", 0);
+	kernel_thread(writer, "Write5", 0);
+	kernel_thread(writer, "Write6", 0);
+	kernel_thread(writer, "Write7", 0);
+	kernel_thread(writer, "Write8", 0);
+	kernel_thread(writer, "Write9", 0);
+	kernel_thread(writer, "Write10", 0);
+	kernel_thread(writer, "Write11", 0);
+	kernel_thread(writer, "Write12", 0);
+	kernel_thread(writer, "Write13", 0);
+	kernel_thread(writer, "Write14", 0);
+	kernel_thread(writer, "Write15", 0);
+
+	kernel_thread(reader, "Read0", 0);
+	kernel_thread(reader, "Read1", 0);
+	kernel_thread(reader, "Read2", 0);
+	kernel_thread(reader, "Read3", 0);
+	kernel_thread(reader, "Read4", 0);
+	kernel_thread(reader, "Read5", 0);
+	kernel_thread(reader, "Read6", 0);
+	kernel_thread(reader, "Read7", 0);
+	kernel_thread(reader, "Read8", 0);
+	kernel_thread(reader, "Read9", 0);
+	kernel_thread(reader, "Read10", 0);
+	kernel_thread(reader, "Read11", 0);
+	kernel_thread(reader, "Read12", 0);
+	kernel_thread(reader, "Read13", 0);
+	kernel_thread(reader, "Read14", 0);
+	kernel_thread(reader, "Read15", 0);
+	kernel_thread(reader, "Read16", 0);
+	kernel_thread(reader, "Read17", 0);
+	kernel_thread(reader, "Read18", 0);
+	kernel_thread(reader, "Read19", 0);
+	kernel_thread(reader, "Read20", 0);
+	kernel_thread(reader, "Read21", 0);
+	kernel_thread(reader, "Read22", 0);
+	kernel_thread(reader, "Read23", 0);
+	kernel_thread(reader, "Read24", 0);
+	kernel_thread(reader, "Read25", 0);
+	kernel_thread(reader, "Read26", 0);
+	kernel_thread(reader, "Read27", 0);
+	kernel_thread(reader, "Read28", 0);
+	kernel_thread(reader, "Read29", 0);
+	kernel_thread(reader, "Read30", 0);
 
 	return 0;
 }
@@ -155,6 +196,8 @@
 		schedule();
 	printk("reads taken: %d\n", atomic_read(&reads_taken));
 	printk("writes taken: %d\n", atomic_read(&writes_taken));
+	printk("readers: %d\n", atomic_read(&readers));
+	printk("writers: %d\n", atomic_read(&writers));
 #ifdef DEBUG_RWSEM
 	rwsem_to_monitor = 0;
 #endif

and now also the benchmark deadlocked:

andrea@laser:~ > ps 669
  PID TTY      STAT   TIME COMMAND
  669 pts/0    R      6:25 [Read19]
andrea@laser:~ > su
root@laser:/home/andrea > rmmod rwsem-rw
[ hang here ]

Until we fix that bug I will keep running my rwsem-generic-6 patch to be 100%
sure to sit on rock solid rwsems.

BTW, this is the fix against pre4 for the 386+SMP rwsemaphores bug that I found
yesterday:

--- rwsemref-1/include/asm-i386/rwsem-spin.h.~1~	Fri Apr 20 05:03:59 2001
+++ rwsemref-1/include/asm-i386/rwsem-spin.h	Fri Apr 20 19:05:52 2001
@@ -93,9 +93,9 @@
 	__asm__ __volatile__(
 		"# beginning down_read\n\t"
 #ifdef CONFIG_SMP
+		"1:\n\t"
 LOCK_PREFIX	"  decb      "RWSEM_SPINLOCK_OFFSET_STR"(%%eax)\n\t" /* try to grab the spinlock */
 		"  js        3f\n" /* jump if failed */
-		"1:\n\t"
 #endif
 		"  incl      (%%eax)\n\t" /* adds 0x00000001, returns the old value */
 #ifdef CONFIG_SMP
@@ -132,9 +132,9 @@
 	__asm__ __volatile__(
 		"# beginning down_write\n\t"
 #ifdef CONFIG_SMP
+		"1:\n\t"
 LOCK_PREFIX	"  decb      "RWSEM_SPINLOCK_OFFSET_STR"(%%eax)\n\t" /* try to grab the spinlock */
 		"  js        3f\n" /* jump if failed */
-		"1:\n\t"
 #endif
 		"  xchg      %0,(%%eax)\n\t" /* retrieve the old value */
 		"  add       %0,(%%eax)\n\t" /* add 0xffff0001, result in memory */
@@ -173,9 +173,9 @@
 	__asm__ __volatile__(
 		"# beginning __up_read\n\t"
 #ifdef CONFIG_SMP
+		"1:\n\t"
 LOCK_PREFIX	"  decb      "RWSEM_SPINLOCK_OFFSET_STR"(%%eax)\n\t" /* try to grab the spinlock */
 		"  js        3f\n" /* jump if failed */
-		"1:\n\t"
 #endif
 		"  xchg      %0,(%%eax)\n\t" /* retrieve the old value */
 		"  addl      %0,(%%eax)\n\t" /* subtract 1, result in memory */
@@ -213,9 +213,9 @@
 	__asm__ __volatile__(
 		"# beginning __up_write\n\t"
 #ifdef CONFIG_SMP
+		"1:\n\t"
 LOCK_PREFIX	"  decb      "RWSEM_SPINLOCK_OFFSET_STR"(%%eax)\n\t" /* try to grab the spinlock */
 		"  js        3f\n" /* jump if failed */
-		"1:\n\t"
 #endif
 		"  addl      %3,(%%eax)\n\t" /* adds 0x00010001 */
 #ifdef CONFIG_SMP
@@ -251,9 +251,9 @@
 	__asm__ __volatile__(
 		"# beginning rwsem_atomic_update\n\t"
 #ifdef CONFIG_SMP
+		"1:\n\t"
 LOCK_PREFIX	"  decb      "RWSEM_SPINLOCK_OFFSET_STR"(%1)\n\t" /* try to grab the spinlock */
 		"  js        3f\n" /* jump if failed */
-		"1:\n\t"
 #endif
 		"  xchgl     %0,(%1)\n\t" /* retrieve the old value */
 		"  addl      %0,(%1)\n\t" /* add 0xffff0001, result in memory */
@@ -287,9 +287,9 @@
 	__asm__ __volatile__(
 		"# beginning rwsem_cmpxchgw\n\t"
 #ifdef CONFIG_SMP
+		"1:\n\t"
 LOCK_PREFIX	"  decb      "RWSEM_SPINLOCK_OFFSET_STR"(%3)\n\t" /* try to grab the spinlock */
 		"  js        3f\n" /* jump if failed */
-		"1:\n\t"
 #endif
 		"  cmpw      %w1,(%3)\n\t"
 		"  jne       4f\n\t" /* jump if old doesn't match sem->count LSW */

Andrea
