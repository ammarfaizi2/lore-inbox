Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbUCCDGU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 22:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbUCCDGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 22:06:20 -0500
Received: from science.horizon.com ([192.35.100.1]:15947 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261703AbUCCDGH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 22:06:07 -0500
Date: 3 Mar 2004 03:06:04 -0000
Message-ID: <20040303030604.23256.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org, root@chaos.analogic.com
Subject: Re: poll() in 2.6 and beyond
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm talking about the driver! When a open fd called poll() or select(),
> in user-mode code, the driver's poll() was called, and the driver's poll()
> would call poll_wait().  Poll_wait() used to NOT return until the driver
> executed wake_up_interruptible() on that wait-queue. When poll_wait()
> returned, the driver would return to the caller with the new poll-
> status.

poll_wait has ALWAYS, since it was introduces during the select/poll
changeover in 2.1 development, been a non-sleeping, immediately returning
function.

Its predecessor, select_wait(), has been a non-sleeping function since 1.0.

> So, if the poll_wait isn't a wait-function, but just some add-wakeup
> to the queue function, then its name probably should have been
> changed when it changed. At one time it did, truly, wait until
> it was awakened with wake_up_interruptible.

There is no "when it changed".  It has never changed.  Go look at
the 2.2.20 code on http://lxr.linux.no/.

    ***************************************************************
    *                                                             *
    *  poll_wait:                                                 *
    *  - DOES NOT sleep.                                          *
    *  - NEVER HAS slept, in any kernel version, EVER.            *
    *  - WOULD NOT WORK if it did sleep, for reasons that are     *
    *    so BLATANTLY OBVIOUS that arguing about it after it's    *
    *    been REPEATEDLY pointed out is a sign that the person    *
    *    arguing needs to go and visit the rest home with those   *
    *    nice, young men in their clean, white coats.             *
    *                                                             *
    ***************************************************************

It has aways, since select_wait in Linux 1.0, been nothing more than
an "add-wakeup-to-the-queue" function.  The last time the code changed
significantly was the select/poll changeover in 2.1.x, and even then it
was very similar.

When a particular filp's poll method is called, there are two things
that have to get done:
1) Check if the wakeup conditions are already satisfied
   (the "no-wait" case), and
2) Schedule the task for wakeup when the filp's condition changes
   (the "wait" case)

Now, 2) only has to be done if 1) fails, but we can't do things in that
order because there's a race condition. if the condition changed between
the two steps, but doesn't change after that, we'll never wake up.

So we have to do 2), and THEN check for 1).  This is the fundamental
race condition of sleeping until a condition becomes true, so anyone who
entertains the remotest channce of ever writing functioning kernel code
should be excruciatingly familiar with it, and its solution.


For the terminally dim, everyone hold hands and follow me.  Remember
when we read Kernighan & Ritchie aloud and don't get lost...

In the 2.2.20 kernel, pollwait is defined (include/linux/poll.h) as:

14 struct poll_table_entry {
15         struct file * filp;
16         struct wait_queue wait;
17         struct wait_queue ** wait_address;
18 };
19 
20 typedef struct poll_table_struct {
21         struct poll_table_struct * next;
22         unsigned int nr;
23         struct poll_table_entry * entry;
24 } poll_table;
25 
26 #define __MAX_POLL_TABLE_ENTRIES ((PAGE_SIZE - sizeof (poll_table)) / sizeof (struct poll_table_entry))
27 
28 extern void __pollwait(struct file * filp, struct wait_queue ** wait_address, poll_table *p);
29 
30 extern inline void poll_wait(struct file * filp, struct wait_queue ** wait_address, poll_table *p)
31 {
32         if (p && wait_address)
33                 __pollwait(filp, wait_address, p);
34 }

This ia a trivial wrapper around __pollwait().  Nothing else in the
function could possibly take more than a few clock cycles.

__pollwait is defined (fs/select.c) as:

 94 void __pollwait(struct file * filp, struct wait_queue ** wait_address, poll_table *p)
 95 {
 96         for (;;) {
 97                 if (p->nr < __MAX_POLL_TABLE_ENTRIES) {
 98                         struct poll_table_entry * entry;
 99                         entry = p->entry + p->nr;
100                         entry->filp = filp;
101                         filp->f_count++;
102                         entry->wait_address = wait_address;
103                         entry->wait.task = current;
104                         entry->wait.next = NULL;
105                         add_wait_queue(wait_address,&entry->wait);
106                         p->nr++;
107                         return;
108                 }
109                 p = p->next;
110         }
111 }

This does a little bit of bookkeeping and calls add_wait_queue().
Nothing else in the function could possibly take more than a few dozen
clock cycles.

Now look at add_wait_queue(), which is defined (include/linux/sched.h) as
nothing more than calls to three other functions:

745 extern inline void __add_wait_queue(struct wait_queue ** p, struct wait_queue * wait)
746 {
747         wait->next = *p ? : WAIT_QUEUE_HEAD(p);
748         *p = wait;
749 }
750 
751 extern rwlock_t waitqueue_lock;
752 
753 extern inline void add_wait_queue(struct wait_queue ** p, struct wait_queue * wait)
754 {
755         unsigned long flags;
756 
757         write_lock_irqsave(&waitqueue_lock, flags);
758         __add_wait_queue(p, wait);
759         write_unlock_irqrestore(&waitqueue_lock, flags);
760 }

write_lock_irqsave() and write_unlock_irqsave() can get a little
bit complicated, so pay careful attention.

We're going to consider just the i386, non-SMP case.  SMP locking is
for big boys and girls who did all their homework and got As on their
tests.

They are defined (include/asm-i386/spinlock.h) as:
115 #define write_lock_irqsave(lock, flags) \
116         do { save_flags(flags); cli(); } while (0)
117 #define write_unlock_irqrestore(lock, flags) \
118         restore_flags(flags)

These, in turn, go through some wrappers in include/asm-i386/system.h:
198 #define cli() __cli()
199 #define sti() __sti()
200 #define save_flags(x) __save_flags(x)
201 #define restore_flags(x) __restore_flags(x)

and end up calling the primitive assembly routines in the same file:

176 /* interrupt control.. */
177 #define __sti() __asm__ __volatile__ ("sti": : :"memory")
178 #define __cli() __asm__ __volatile__ ("cli": : :"memory")
179 #define __save_flags(x) \
180 __asm__ __volatile__("pushfl ; popl %0":"=g" (x): /* no input */ :"memory")
181 #define __restore_flags(x) \
182 __asm__ __volatile__("pushl %0 ; popfl": /* no output */ :"g" (x):"memory")

These are one or two machine instructions each.

Finally, _add__wait_queue, above, is just two assignments.  Just to
be absolutely sure we've explored every function-like thing that
the most deluded paranoid could think might sleep, I'll mention that
WAIT_QUEUE_HEAD is defined in include/linux/wait.h as:

22 #define WAIT_QUEUE_HEAD(x) ((struct wait_queue *)((x)-1))

This, also, cannot possibly sleep.



To recap, looking back in the wayback machine to 2.2.20, the complete
call/macro graph of poll_wait is:

poll_wait
    __pollwait
        add_wait_queue
            write_lock_irqsave
                save_flags
                    __save_flags
                cli
                    __cli
            __add_wait_queue
                WAIT_QUEUE_HEAD
            write_unlock_irqrestore
                restore_flags
                    __restore_flags

and NONE OF THESE FUNCTIONS SLEEP.  Therefore, poll_wait DID NOT USED TO
SLEEP.

2.4 and later allocate the poll_table pages on demand (with GFP_KERNEL)
rather than preallocating everything, so *that* part can sleep, but it
doesn't depend on the filp being polled, and the rest CANNOT.
