Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131139AbQLUUAw>; Thu, 21 Dec 2000 15:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131342AbQLUUAm>; Thu, 21 Dec 2000 15:00:42 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:19273 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S131139AbQLUUA0>; Thu, 21 Dec 2000 15:00:26 -0500
Date: Thu, 21 Dec 2000 13:30:03 -0600 (CST)
From: Paul Cassella <pwc@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Semaphores used for daemon wakeup
In-Reply-To: <3A42380B.6E9291D1@sgi.com>
Message-ID: <Pine.SGI.3.96.1001221130859.8463C-100000@fsgi626.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The mechanism being developed here seems a lot like synchronization
variables (aka condition variables), which are a part of the "monitor"
synchronization construct.  There is a simple implementation of them in
the xfs patch.  I've been working on a more general version in order to
aid porting some other stuff, which I have appended to this post.

I had been holding off on posting about it since I didn't have any code
that used it ready, and probably wouldn't until 2.5 anyway, but due to
this thread, I think bringing it up now might be helpful.


Daniel Phillips wrote:
> Tim Wright wrote:


> > p_sema_v_lock(&sema, priority, &lock);  /* atomically release the lock AND */
> >                         /* go to sleep on the semaphore */

This in particular looks like sv_wait(), which atomically releases a
lock and goes to sleep.

The style is somewhat different, as a sync variable (sv) is not really a
lock, but is still something that a process can block on.  A process goes
to sleep by calling sv_wait(sv), and is woken up by another process
calling sv_signal(sv) (wake one) or sv_broadcast(sv) (wake all).  If there
is no process sleeping in sv_wait, signals and broadcasts have no effect;
they do not affect any process which subsequently calls sv_wait(). 

Each sync variable is associated with another lock, which provides mutual
exclusion guarantees.  This lock must be held to call sv_wait(), and is
dropped atomically with the process going to sleep.  This lock must also
be held to call sv_signal() or sv_broadcast().  Currently, this lock can
be a spinlock or a semaphore; other types of locks could be added if
necessary. 

The sync variable version of the dmabuf code snippet (assuming the
dmabuf_mutex is never acquired from an interrupt) would look like this: 


    dmabuf_init(...);
    {
            ...
            spin_lock_init(&dmabuf_spin);
            sv_init(&dmabuf_sv, &dmabuf_spin, SV_MON_SPIN);
            ...
    }

    dmabuf_alloc(...)
    {

            ...
            while (1) {
                    spin_lock(&dmabuf_spin);
                    attempt to grab a free buffer;
                    if (success){
                            spin_unlock(&dmabuf_spin);
                            return;
                    } else {
                            sv_wait(&dmabuf_sv);
                    }
            }
    }

    dmabuf_free(...)
    {
            ...
            spin_lock(&dmabuf_spin);
            free up buffer;
            sv_broadcast(&dmabuf_sv);
            spin_unlock(&dmabuf_spin);
    }

If dmabuf_free() could be called from an interrupt, this would be modified
by passing the SV_INTS flag to sv_init(), using spin_lock_irq() in
dmabuf_alloc, and spin_lock_irqsave/restore in dmabuf_free().

> > As you can see, the spinlocks ensure no races, and the key is the atomicity
> > of p_sema_v_lock(). No-one can race in and sleep on dmabuf_wait, because
> > they have to hold dmabuf_mutex to do so. Exactly the same mechanism would
> > work for the bdflush problem.

The same protections are in place here, as the two methods are basically
the same. 


> described.  The main difference between this situation and bdflush is
> that dmabuf_free isn't really waiting on dmabuf_alloc to fullfill a
> condition (other than to get out of its exclusion region) while bdflush
> can have n waiters.

This could be done with two sv's.  After all, there are two conditions:
"someone needs bdflush to run", and "bdflush is done". 


> int atomic_read_and_clear(atomic_t *p)
> {
>         int n = atomic_read(p);
>         atomic_sub(p, n);
>         return n;
> }

I don't think this will work; consider two callers doing the atomic_read() 
at the same time, or someone else doing an atomic_dec() after the
atomic_read(). 


> the more involved wake_up_process().  What's clear is, they are all
> plenty fast enough for this application, and what I'm really trying for
> is readability.

I think sv's are pretty readable and clear, but I'd like to find out what
other people think.

If anyone finds this useful or finds any bugs, or has any questions or
suggestions, please let me know.  I'll be reading the list, but I'm going
on vacation tomorrow, so I'd appreciate a Cc: so I have a better chance of
answering before then.  Thanks.


-- 
Paul Cassella
pwc@sgi.com


And now, the code.

include/linux/sv.h:

/*
This is the version I'm using with a test8-pre1 kernel, so it uses the
old TASK_EXCLUSIVE semantics; it should be trivial to make it work with
new kernels.  I haven't yet done so, since we're going to be using the
test8-pre1 kernel for a few more weeks yet. 

In the interests of brevity, I've taken out most of the debugging code,
some typecasting, and some other things like the wrapper functions for
up() and spin_unlock(), which are needed because we need a function
pointer, and these may be macros or inline fuctions. 

This was originally based on the version Steve Lord did for the xfs port. 
This version had no problems when put into the xfs tree an run through a
stress test.  I don't remember what kernel version that tree was, but it
was before the TASK_EXCLUSIVE change..
*/

typedef void sv_mon_lock_t;
typedef void (*sv_mon_unlock_func_t)(sv_mon_lock_t *lock);

/* sv_flags values: */

#define SV_ORDER_FIFO        0x001
#define SV_ORDER_FILO        0x002

/* If at some point one order becomes preferable to others, we can
   use that order when sv_init() isn't given an order. */
#define SV_ORDER_DEFAULT     SV_ORDER_FIFO

#define SV_ORDER_MASK        0x00f


#define SV_MON_SEMA          0x010
#define SV_MON_SPIN          0x020

#define SV_MON_MASK          0x0f0


/*
   Set if the monitor lock can be aquired from interrupts.  Note that this
   is a superset of the cases in which the sv itself can be touched from
   interrupts.

   This is only valid when the monitor lock is a spinlock.

   If this is used, sv_wait(), sv_signal(), and sv_broadcast() must all be
   called with interrupts disabled, which had to have happened anyway to
   have acuired the monitor spinlock. 
 */
#define SV_INTS              0x100


/* sv_wait_flag values: */

/* Allow sv_wait() to be interrupted by a signal */
#define SV_WAIT_SIG          0x001

typedef struct sv_s {
	wait_queue_head_t sv_waiters;
        /* Lock held to ensure exclusive access to monitor. */
	sv_mon_lock_t *sv_mon_lock;
	sv_mon_unlock_func_t sv_mon_unlock_func;
	spinlock_t sv_lock;  /* Spinlock protecting the sv itself. */
	int sv_flags;
} sv_t;

#define DECLARE_SYNC_VARIABLE(sv, l, f) sv_t sv = sv_init(&sv, l, f)




kernel/sv.c:


static inline void sv_lock(sv_t *sv) {
	spin_lock(&sv->sv_lock);
}

static inline void sv_unlock(sv_t *sv) {
	spin_unlock(&sv->sv_lock);
}


/* up() and spin_unlock() may be inline or macros; the real version
   uses wrappers for them. */

static inline void sv_set_mon_type(sv_t *sv, int type) {
	switch (type) {
	case SV_MON_SPIN:
		sv->sv_mon_unlock_func = spin_unlock;
		break;
	case SV_MON_SEMA:
		sv->sv_mon_unlock_func = up;
		if(sv->sv_flags & SV_INTS) {
			printk(KERN_ERR "sv_set_mon_type: The monitor lock "
			       "cannot be shared with interrupts if it is a "
			       "semaphore!\n");
			BUG();
		}
		break;

	default:
		BUG();
	}
	sv->sv_flags |= type;
}

static inline void sv_set_ord(sv_t *sv, int ord) {
	if (!ord)
		ord = SV_ORDER_DEFAULT;

	if (ord != SV_ORDER_FIFO && ord != SV_ORDER_LIFO) {
		BUG();
	}

	sv->sv_flags |= ord;
}

/*
 * sv            the sync variable to initialize
 * monitor_lock  the lock enforcing exclusive running in the monitor
 * flags         one of
 *   SV_MON_SEMA monitor_lock is a semaphore
 *   SV_MON_SPIN monitor_lock is a spinlock
 * and a bitwise or of some subset of
 *   SV_INTS - the monitor lock can be acquired from interrupts (and
 *             hence, whenever we hold it, interrupts are disabled (or
 *             we're in an interrupt.))  This is only valid when the sv
 *             is of type SV_MON_SPIN.
 */
void sv_init(sv_t *sv, sv_mon_lock_t *lock, int flags) 
{
	int ord = flags & SV_ORDER_MASK;
	int type = flags & SV_MON_MASK;

	/* Copy all non-order, non-type flags */
	sv->sv_flags = flags & ~(SV_ORDER_MASK | SV_MON_MASK);

	sv_set_ord(sv, ord);
	sv_set_mon_type(sv, type);

	sv->sv_mon_lock = lock;

	spin_lock_init(&sv->sv_lock);
	init_waitqueue_head(&sv->sv_waiters);
}

/*
 * The associated lock must be locked on entry.  It is unlocked on return.
 *
 * Set SV_WAIT_SIG in sv_wait_flags to let the sv_wait be interrupted
 * by signals.
 *
 * timeout is how long to wait before giving up, or 0 to wait
 * indefinately.  It is given in jiffies, and is relative.
 *
 * Return values:
 *
 * n < 0 : interrupted,  -n jiffies remaining on timeout, or -1 if timeout == 0
 * n = 0 : timeout expired
 * n > 0 : sv_signal()'d, n jiffies remaining on timeout, or 1 if timeout == 0
 */
signed long sv_wait(sv_t *sv, int sv_wait_flags, unsigned long timeout) 
{
	DECLARE_WAITQUEUE( wait, current );
	signed long ret = 0;

	sv_lock(sv);

	sv->sv_mon_unlock_func(sv->sv_mon_lock);

	/* Add ourselves to the wait queue and set the state before
           releasing the sv_lock so as to avoid racing with wake_up in
           sv_signal() and sv_broadcast. */
	switch(sv->sv_flags & SV_ORDER_MASK) {
	case SV_ORDER_FIFO:
		add_wait_queue_exclusive(&sv->sv_waiters, &wait);
		break;
	case SV_ORDER_FILO:
		add_wait_queue(&sv->sv_waiters, &wait);
		break;
	default:
		BUG();
	}

	if(sv_wait_flags & SV_WAIT_SIG)
		set_current_state(TASK_EXCLUSIVE | TASK_INTERRUPTIBLE  );
	else
		set_current_state(TASK_EXCLUSIVE | TASK_UNINTERRUPTIBLE);

	if(sv->sv_flags & SV_INTS)
		spin_unlock_irq(&sv->sv_lock);
	else
		spin_unlock(&sv->sv_lock);

	if (timeout)
		ret = schedule_timeout(timeout);
	else
		schedule();

	if(current->state != TASK_RUNNING) /* XXX Is this possible? */ {
		printk(KERN_ERR "sv_wait: state not TASK_RUNNING after "
		       "schedule().\n");
		set_current_state(TASK_RUNNING);
	}

	remove_wait_queue(&sv->sv_waiters, &wait);

	/* Return cases:
	   - woken by a sv_signal/sv_broadcast
	   - woken by a signal
	   - woken by timeout expiring
	*/

	/* FIXME: This isn't really accurate; we may have been woken
           before the signal anyway.... */
	if(signal_pending(current))
		return timeout ? -ret : -1;
	return timeout ? ret : 1;
}


void sv_signal(sv_t *sv) 
{
	/* If interrupts can acquire this lock, they can also acquire the
	   sv_mon_lock, which must be held to have called this, so
	   interrupts must be disabled already.  If interrupts cannot
	   contend for this lock, we don't have to disable them. */

	sv_lock(sv);
	wake_up(&sv->sv_waiters);
	sv_unlock(sv);
}

void sv_broadcast(sv_t *sv) 
{
	sv_lock(sv);
	wake_up_all(&sv->sv_waiters);
	sv_unlock(sv);
}


/*
 * These files are subject to the terms and conditions of the GNU General Public
 * License.
 *
 * Copyright (C) 2000 Silicon Graphics, Inc.  All rights reserved.
 *
 * Paul Cassella <pwc@sgi.com>
 */

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
