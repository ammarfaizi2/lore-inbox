Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130580AbQLVSDc>; Fri, 22 Dec 2000 13:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130649AbQLVSDW>; Fri, 22 Dec 2000 13:03:22 -0500
Received: from spatula.llnl.gov ([134.9.11.86]:16911 "EHLO spatula.llnl.gov")
	by vger.kernel.org with ESMTP id <S130580AbQLVSDR>;
	Fri, 22 Dec 2000 13:03:17 -0500
Date: Fri, 22 Dec 2000 09:32:43 -0800
From: Brian Pomerantz <bapper@llnl.gov>
To: Paul Cassella <pwc@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Semaphores used for daemon wakeup
Message-ID: <20001222093243.A8469@spatula.llnl.gov>
In-Reply-To: <3A42380B.6E9291D1@sgi.com> <Pine.SGI.3.96.1001221130859.8463C-100000@fsgi626.americas.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.SGI.3.96.1001221130859.8463C-100000@fsgi626.americas.sgi.com>; from pwc@sgi.com on Thu, Dec 21, 2000 at 01:30:03PM -0600
X-homepage: http://www.piratehaven.org/~bapper/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii

On Thu, Dec 21, 2000 at 01:30:03PM -0600, Paul Cassella wrote:
> The mechanism being developed here seems a lot like synchronization
> variables (aka condition variables), which are a part of the "monitor"
> synchronization construct.  There is a simple implementation of them in
> the xfs patch.  I've been working on a more general version in order to
> aid porting some other stuff, which I have appended to this post.
> 
> I had been holding off on posting about it since I didn't have any code
> that used it ready, and probably wouldn't until 2.5 anyway, but due to
> this thread, I think bringing it up now might be helpful.
> 

We have a similar set of locks that were developed while porting the
Quadrics device drivers over to Linux from True64.  These are pretty
close to the way pthreads mutexes and condition variables work in user
space and are similar to primitives that exist in True64 kernel land
(thus the need to develop them to make the port easier).  They allow
for use of semaphores or spinlocks depending on whether you are going
to sleep while holding the mutex.  The only caveat with it is that it
requires that wake_up_process() be exported in kernel/ksyms.c in order
to use it in modules.  We're in the process of making a Linux web site
here at the lab that has papers as well as patches that we have made
to help Linux along in the high performance computing area.  Until
that is up, here are the two files that implement mutexes and
condition variables.


BAPper

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mutex.h"

/*
 *    Copyright (C) 2000  Regents of the University of California
 *
 *    This program is free software; you can redistribute it and/or modify
 *    it under the terms of the GNU General Public License as published by
 *    the Free Software Foundation; either version 2 of the License, or
 *    (at your option) any later version.
 *
 *    This program is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with this program; if not, write to the Free Software
 *    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 *    Mutex functions.  
 * 	MUTEX_SPIN      spinlock
 * 	MUTEX_SPIN_INTR spinlock with interrupts disabled
 * 	MUTEX_BLOCK     semaphore
 *
 *    Define -DDEBUG_MUTEX to get debugging spinlocks on alpha
 *    (will report file/line no. of stuck spinlocks)
 *
 *    Jim Garlick <garlick@llnl.gov>
 */

#if	!defined(_LINUX_MUTEX_H)
#define	_LINUX_MUTEX_H
#if	defined(__KERNEL__)

#if	defined(DEBUG_MUTEX) && defined(__alpha__) && !defined(DEBUG_SPINLOCK)
#define	DEBUG_SPINLOCK
#endif

#include <asm/smp.h>
#include <asm/spinlock.h>
#include <asm/semaphore.h>
#include <linux/debug.h>
#include <linux/interrupt.h>
#include <linux/version.h>

#if	!defined(DEBUG_SPINLOCK)
#define	debug_spin_lock(lock, file, line)	spin_lock(lock)
#define	debug_spin_trylock(lock, file, line)	spin_trylock(lock)
#endif

#define	mutex_trylock(l) debug_mutex_trylock(l, __BASE_FILE__, __LINE__)
#define	mutex_lock(l)	debug_mutex_lock(l, __BASE_FILE__, __LINE__)

#define PID_NONE	(PID_MAX + 1)
#define PID_INTR	(PID_MAX + 2 + smp_processor_id())	
#define MY_PID 		(in_interrupt() ? PID_INTR : current->pid)
#define MY_CPU		smp_processor_id()

#define MUTEX_MAX_NAME	16

typedef enum { MUTEX_SPIN, MUTEX_SPIN_INTR, MUTEX_BLOCK } lock_type_t;

typedef struct {
	lock_type_t	type;
	union {
		struct {
			spinlock_t		lock;
			unsigned long		flags;
		} spin;
		struct {
			struct semaphore	lock;
		} blocking;
	} mutex_u;
	pid_t		holder;
#if	defined(DEBUG_MUTEX)
	char		name[MUTEX_MAX_NAME];
#endif
} mutex_t;


/* binary semaphores */
#if	LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0)
#define BS_INIT(s)      (s) = MUTEX
#else
#define BS_INIT(s)      init_MUTEX(&(s))
#endif
#define BS_TRY(s)       (down_trylock(&(s)) == 0)
#define BS_LOCK(s)      down(&(s))
#define BS_UNLOCK(s)    up(&(s))


extern __inline__ void
mutex_init(mutex_t *l, char *name, lock_type_t type)
{
	l->type = type;
	switch(l->type) {
		case MUTEX_BLOCK:
			BS_INIT(l->mutex_u.blocking.lock);
			break;
		case MUTEX_SPIN:
		case MUTEX_SPIN_INTR:
			l->mutex_u.spin.lock = SPIN_LOCK_UNLOCKED;
			break;
	}
	l->holder = PID_NONE;
#if	defined(DEBUG_MUTEX)
	strncpy(l->name, name, MUTEX_MAX_NAME);
#endif
}

extern __inline__ void
mutex_destroy(mutex_t *l)
{
	ASSERT(l->holder == PID_NONE);
}

/* 
 * Return nonzero if lock is held by this thread.  
 */
extern __inline__ int 
mutex_held(mutex_t *l)
{
	return (l->holder == MY_PID);
}

/*
 * really we want to be using spin_lock_irqsave/spin_unlock_irqrestore -
 * however there's no trylock functional interface.
 */

#if	LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0)
#if	defined(__alpha__) || defined(__sparc__)
#define local_irq_save(x)	__save_and_cli(x)
#define local_irq_restore(x)	__restore_flags(x)
#elif	defined(__i386__)
#define local_irq_save(x)	__asm__ __volatile__("pushfl ; popl %0 ; cli":"=g" (x): /* no input */ :"memory")
#define local_irq_restore(x)	__asm__ __volatile__("pushl %0 ; popfl": /* no output */ :"g" (x):"memory")
#else
#error UNKNOWN ARCH.
#endif
#endif 

extern __inline__ void
debug_mutex_lock(mutex_t *l, char *file, int line)
{	
	unsigned long flags;

	ASSERT(!mutex_held(l));
	switch(l->type) {
		case MUTEX_BLOCK:
			ASSERT(!in_interrupt());
			BS_LOCK(l->mutex_u.blocking.lock);
			break;
		case MUTEX_SPIN_INTR:
			local_irq_save(flags);
			debug_spin_lock(&l->mutex_u.spin.lock, file, line);
			l->mutex_u.spin.flags = flags;
			break;
		case MUTEX_SPIN:
			debug_spin_lock(&l->mutex_u.spin.lock, file, line);
			break;
	}
	l->holder = MY_PID;
}

extern __inline__ void
mutex_unlock(mutex_t *l)
{
	unsigned long flags;

	ASSERT(mutex_held(l));
	l->holder = PID_NONE;
	switch(l->type) {
		case MUTEX_BLOCK:
			BS_UNLOCK(l->mutex_u.blocking.lock);
			break;
		case MUTEX_SPIN_INTR:
			flags = l->mutex_u.spin.flags;
			spin_unlock(&l->mutex_u.spin.lock);
			local_irq_restore(flags);
			break;
		case MUTEX_SPIN:
			spin_unlock(&l->mutex_u.spin.lock);
			break;
	}
}

/*
 * Unordered lock releasing - if a spinlock, we need to make sure we
 * when l1 is released, we __restore_flags() the value from l.
 * 
 * Usage:
 *   mutex_lock(l)
 *   mutex_lock(l1)
 *   mutex_unlock_unordered(l, l1)
 *   mutex_unlock(l1)
 */
extern __inline__ void
mutex_unlock_unordered(mutex_t *l, mutex_t *l1)
{
	unsigned long flags;

	ASSERT(mutex_held(l));
	ASSERT(mutex_held(l1));

	l->holder = PID_NONE;
	switch (l->type) {
		case MUTEX_BLOCK:
			BS_UNLOCK(l->mutex_u.blocking.lock);
			break;
		case MUTEX_SPIN_INTR:
			ASSERT(l1->type == MUTEX_SPIN_INTR);
			flags = l->mutex_u.spin.flags;
			spin_unlock(&l->mutex_u.spin.lock);
			local_irq_restore(l1->mutex_u.spin.flags);
			l1->mutex_u.spin.flags = flags;
			break;
		case MUTEX_SPIN:
			spin_unlock(&l->mutex_u.spin.lock);
			break;
	}
}

/* 
 * Returns nonzero if lock has been acquired.
 */
extern __inline__ int
debug_mutex_trylock(mutex_t *l, char *file, int line)
{
	int res;
	unsigned long flags;

	ASSERT(!mutex_held(l));
	switch(l->type) {
		case MUTEX_BLOCK:
			ASSERT(!in_interrupt());
			res = BS_TRY(l->mutex_u.blocking.lock);
			break;
		case MUTEX_SPIN_INTR:
			local_irq_save(flags);
			res = (debug_spin_trylock(&l->mutex_u.spin.lock, 
					file, line) != 0);
			if (res)
				l->mutex_u.spin.flags = flags;
			else
				local_irq_restore(flags);
			break;
		case MUTEX_SPIN:
			res = (debug_spin_trylock(&l->mutex_u.spin.lock, file, line) != 0);
			break;
	}
	if (res)
		l->holder = MY_PID;
	return res;
}

#endif /* __KERNEL__ */
#endif /* _LINUX_MUTEX_H */

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="condvar.h"

/*
 *    Copyright (C) 2000  Regents of the University of California
 *
 *    This program is free software; you can redistribute it and/or modify
 *    it under the terms of the GNU General Public License as published by
 *    the Free Software Foundation; either version 2 of the License, or
 *    (at your option) any later version.
 *
 *    This program is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with this program; if not, write to the Free Software
 *    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 *    Condition variables.
 *    Jim Garlick <garlick@llnl.gov>
 */

#if	!defined(_LINUX_CONDVAR_H)
#define	_LINUX_CONDVAR_H

#if 	defined(__KERNEL__)

#include <linux/list.h>
#include <linux/debug.h>
#include <linux/mutex.h>

#define CV_RET_SIGPENDING	0
#define CV_RET_TIMEOUT		(-1)
#define CV_RET_NORMAL		1

#define CV_MAX_NAME		16

struct cv_task {
	struct task_struct	*task;		/* need to wrap task in this */
	struct list_head	list;		/*   to thread as a list */
	int 			blocked;
};

typedef struct {
	struct list_head	task_list; 	/* list of cv_task's */
						/*   that are waiting on cv */
#if	defined(DEBUG_CV)
	char 			name[CV_MAX_NAME];
#endif
} condvar_t;

#if	defined(DEBUG_CV)
#define LOCK_NAME(c)		(c)->name
#else
#define	LOCK_NAME(c)		"<unknown>"
#endif

#define cv_wait(c,l)		debug_cv_wait(c, l, 0, 0, __BASE_FILE__, __LINE__)
#define cv_waitsig(c,l)		debug_cv_wait(c, l, 0, 1, __BASE_FILE__, __LINE__)
#define cv_timedwait(c,l,to) 	debug_cv_wait(c, l, to, 0, __BASE_FILE__, __LINE__)
#define cv_timedwaitsig(c,l,to) debug_cv_wait(c, l, to, 1, __BASE_FILE__, __LINE__)
#define cv_wakeup_one(c,l)	cv_wakeup(c, l, 0)
#define cv_wakeup_all(c,l) 	cv_wakeup(c, l, 1)
 
extern __inline__ void
cv_init(condvar_t *c, char *name)
{
	INIT_LIST_HEAD(&c->task_list);
#if	defined(DEBUG_CV)
	strncpy(c->name, name, CV_MAX_NAME);
#endif
}

extern __inline__ void
cv_destroy(condvar_t *c)
{
	ASSERT(list_empty(&c->task_list));
}

/*
 * We thread a struct cv_task, allocated on the stack, onto the condvar_t's
 * task_list, and take it off again when we wake up.
 * Note: the reason we avoid using TASK_UNINTERRUPTIBLE is that avenrun
 * computation treats it like TASK_RUNNABLE.  The cvt.blocked flag 
 * distinguishes a signal wakeup from a cv_wakeup.
 */
extern __inline__ int
debug_cv_wait(condvar_t *c, mutex_t *l, long tmo, int interruptible, 
	char *file, int line)
{
	struct cv_task cvt;
	int ret = CV_RET_NORMAL;

	ASSERT(!in_interrupt());		/* we can block */
	ASSERT(mutex_held(l));			/* enter holding lock */
	/*DBF("cv_wait:\tsleep %s %d:%d\n", LOCK_NAME(c), MY_PID, MY_CPU);*/
	cvt.task = current;
	cvt.blocked = 1;
	list_add(&cvt.list, &c->task_list);
	do {
		current->state = TASK_INTERRUPTIBLE;
		mutex_unlock(l);		/* drop lock for sleep */
		if (tmo) {
			if (tmo <= jiffies || !schedule_timeout(tmo - jiffies))
				ret = CV_RET_TIMEOUT;
		} else
			schedule();
		debug_mutex_lock(l, file, line); /* pick up lock again */
		if (interruptible && signal_pending(current))
			ret = CV_RET_SIGPENDING;
	} while (cvt.blocked && ret == CV_RET_NORMAL);
	list_del(&cvt.list);
	/*DBF("cv_wait:\tawake %s %d:%d %s\n", 
	    LOCK_NAME(c), MY_PID, MY_CPU, ret == CV_RET_TIMEOUT ? "timeout" : 
	    (ret == CV_RET_SIGPENDING) ? "sigpending" : "normal");*/
	return ret;				/* return holding lock */
}

extern __inline__ void
cv_wakeup(condvar_t *c, mutex_t *l, int wakeall)
{
	struct list_head *lp;
	struct cv_task *cvtp;

	ASSERT(mutex_held(l)); 			/* already holding lock */
	for (lp = c->task_list.next; lp != &c->task_list; lp = lp->next) {
		cvtp = list_entry(lp, struct cv_task, list);
		if (cvtp->blocked) {
			/*DBF("cv_wakeup:\twaking %s pid=%d %d:%d\n", 
			    LOCK_NAME(c), p->pid, MY_PID, MY_CPU);*/
			cvtp->blocked = 0;
			/* wake_up_process added to kernel/ksyms.c */
			wake_up_process(cvtp->task); 
			if (!wakeall)
				break;
		}
	}
}						/* return still holding lock */


#endif /* __KERNEL__ */
#endif /* _LINUX_CONDVAR_H */

--bp/iNruPH9dso1Pn--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
