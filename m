Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129555AbQK3OGS>; Thu, 30 Nov 2000 09:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129866AbQK3OGI>; Thu, 30 Nov 2000 09:06:08 -0500
Received: from bacchus.veritas.com ([204.177.156.37]:32175 "EHLO
        bacchus-int.veritas.com") by vger.kernel.org with ESMTP
        id <S129555AbQK3OFt>; Thu, 30 Nov 2000 09:05:49 -0500
Date: Thu, 30 Nov 2000 19:02:56 +0530 (IST)
From: V Ganesh <ganesh@veritas.com>
Message-Id: <200011301332.TAA00277@vxindia.veritas.com>
To: linux-kernel@vger.kernel.org
Subject: beware of add_waitqueue/waitqueue_active
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

there's a very subtle race with using add_waitqueue() as a barrier,
in the __find_lock_page() which used to exist in test9. it seems to be fixed
in test11, but I thought I should mention this just in case it's ever used in
a similar manner elsewhere.

the race manifests itself as a lost wakeup. the process is stuck in schedule()
in __find_lock_page(), with TASK_UNINTERRUPTIBLE, but on examining the struct
page * it was waiting for, page->flags is 72, indicating that it's unlocked.
page->wait shows this process in the waitqueue.

looking at the code for __find_lock_page...

                __set_task_state(tsk, TASK_UNINTERRUPTIBLE);
                add_wait_queue(&page->wait, &wait);

                if (PageLocked(page)) {
                        schedule();
                }
                __set_task_state(tsk, TASK_RUNNING);
		remove_wait_queue(...)

and that of UnlockPage(),
#define UnlockPage(page)        do { \
          smp_mb__before_clear_bit(); \
          clear_bit(PG_locked, &(page)->flags); \
          smp_mb__after_clear_bit(); \
          if (waitqueue_active(&page->wait)) \
                  wake_up(&page->wait); \
} while (0)

now assuming that everyone in the system uses UnlockPage() and no one
directly does a clear_bit(PG_locked) (which I'm absolutely certain of),
a possible sequence of events which could lead to this is:
1. __set_task_state(tsk, TASK_UNINT...)
2. add_wait_queue is called. takes spinlock. this is serializing.
3. add_wait_queue adds this process to the waitqueue. but all the writes
   are in write-buffers and have not gone down to cache/memory yet.
4. PageLocked() finds that the page is locked.
5. UnlockPage is called from another CPU from interrupt context. it clears
   bit, waitqueue_active() decides that there's no waiting process
   (because the add_waitqueue() changes haven't gone to cache yet) and 
   returns. note that waitqueue_active() doesn't take the waitqueue spinlock.
   if it did, it would have been obliged to wait until the spin_unlock (and
   therefore the preceding writes) hit cache, and would have found a nonempty
   list.
6. schedule() is called, never to return.

another thing which could increase the race window is speculative execution
of PageLocked() even before add_wait_queue returns, since the return
address might have been predicted by the RSB.

I've attached a simple module which reproduces the problem (at least on my
4 * 550 MHz PIII(Katmai), model 7, stepping 3). compile with
gcc -O2 -D__SMP__ -fno-strength-reduce -g -fno-omit-frame-pointer -fno-strict-aliasing -c -g race.c
insmod race.o
it will printk appropriately on termination.
basically it consists of two threads moving in lockstep. one locks a page-like
structure, the other unlocks. if the unlocker detects that the locker hasn't
locked in 5 seconds it concludes that a wakeup is lost.

one solution is not to presume add_wait_queue() acts as a barrier if we have a
conditional schedule and the wakeup path makes use of waitqueue_active(). we can
use 
add_wait_queue(...);
set_current_state(...); /* serializes */
if (condition) schedule();

__find_lock_page() no longer uses the racy mechanism in test11 and a cursory
examination of the rest of the kernel doesn't show any prominent offenders.
so this is just an interesting postmortem of an obsolete corpse...

ganesh

#define __KERNEL__
#define MODULE
#include <linux/autoconf.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/sched.h>
#include <linux/wait.h>
#include <asm/delay.h>


struct foo {
	int state;
	wait_queue_head_t wait;
} foo;

#define ITER			(1 << 30)
#define LockFoo(foop)		set_bit(0, &(foop)->state)
#define FooLocked(foop)		test_bit(0, &(foop)->state)
#define UnlockFoo(foop)	{				\
	smp_mb__before_clear_bit();			\
	clear_bit(0, &(foop)->state);			\
	smp_mb__after_clear_bit();			\
	if (waitqueue_active(&(foop)->wait)) {		\
		wake_up(&(foop)->wait);			\
	}						\
}

static int race_exit = 0;

int locker(void *tmp)
{
	struct task_struct *tsk = current;
	unsigned int n = 0;
	DECLARE_WAITQUEUE(wait, tsk);

	exit_files(current);
	daemonize();
	while (1) {
		LockFoo(&foo);

		__set_task_state(tsk, TASK_UNINTERRUPTIBLE);
		add_wait_queue(&foo.wait, &wait);

		if (FooLocked(&foo)) {
			schedule();
		}
		__set_task_state(tsk, TASK_RUNNING);
		remove_wait_queue(&foo.wait, &wait);
		if (race_exit) {
			printk("locker looped %u times\n", n);
			return 1;
		}
		n++;
	}
}

int unlocker(void *tmp)
{
	int counter = 0;
	unsigned int n = 0;

	exit_files(current);
	daemonize();
	while (n < ITER) {
		counter = jiffies;
		while(!FooLocked(&foo)) {
			if (counter + HZ * 5 < jiffies) {
				printk("RACE !\n");
				race_exit = 1;
				wake_up(&foo.wait);
				return 1;
			}
		}
		UnlockFoo(&foo);
		n++;
	}
	while(!test_bit(0, &foo.state));
	printk("no race\n");
	race_exit = 1;
	wake_up(&foo.wait);
	return 0;
}

static int __init init_race(void)
{
	foo.state = 0;
	init_waitqueue_head(&foo.wait);
	kernel_thread(locker, NULL, SIGCHLD);
	kernel_thread(unlocker, NULL, SIGCHLD);
	return 0;
}

static void __exit exit_race(void)
{
}

module_init(init_race);
module_exit(exit_race);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
