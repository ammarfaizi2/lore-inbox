Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129250AbQKSBnS>; Sat, 18 Nov 2000 20:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129234AbQKSBnI>; Sat, 18 Nov 2000 20:43:08 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:51113 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129250AbQKSBnD>; Sat, 18 Nov 2000 20:43:03 -0500
Message-ID: <3A172918.BD09CA9@uow.edu.au>
Date: Sun, 19 Nov 2000 12:12:56 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Rohland <cr@sap.com>
CC: David Mansfield <lkml@dm.ultramaster.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] semaphore fairness patch against test11-pre6
In-Reply-To: <3A15D4F5.B39D61BD@dm.ultramaster.com>,
			David Mansfield's message of "Fri, 17 Nov 2000 20:01:41 -0500" <m3bsvdd36k.fsf@linux.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Rohland wrote:
> 
> Hi David,
> 
> David Mansfield <lkml@dm.ultramaster.com> writes:
> > If you can find the time to check this out more completely, I recommend
> > it, because it seems like a great improvement to be able to accurately
> > see vmstat numbers in times of system load.  I hope the other side
> > effects are beneficial as well :-)
> 
> I wanted to point out that there may be some performance impacts by
> this: We had exactly the new behaviour on SYSV semaphores. It led to
> very bad behaviour in high load situations since for high frequency,
> short critical paths this led to very high context switch rates
> instead of using the available time slice for the program.
> 
> We changed the behaviour of SYSV semaphores to the current kernel sem
> behaviour and never had problems with that change.
> 
> I still think that your change is right since this is kernel space and
> you do not have the notion of a time slice.

Has anyone tried it on SMP?  I get fairly repeatable instances of immortal
`D'-state processes with this patch.

The patch isn't right - it allows `sleepers' to increase without bound.
But it's a boolean!

If you cut out the unnecessary code and the incorrect comments from
__down() it looks like this:


void __down(struct semaphore * sem)
{
        struct task_struct *tsk = current;
        DECLARE_WAITQUEUE(wait, tsk);
        tsk->state = TASK_UNINTERRUPTIBLE;
        add_wait_queue_exclusive(&sem->wait, &wait);

        spin_lock_irq(&semaphore_lock);
        for (;;) {
                /*
                 * Effectively:
                 *
                 *      if (sem->sleepers)
                 *              sem->count++
                 *      if (sem->count >= 0)
                 *              sem->sleepers = 0;
                 *              break;
                 */
                if (!atomic_add_negative(sem->sleepers, &sem->count)) {
                        sem->sleepers = 0;
                        break;
                }
                sem->sleepers = 1;
                spin_unlock_irq(&semaphore_lock);

                schedule();
                tsk->state = TASK_UNINTERRUPTIBLE;
                spin_lock_irq(&semaphore_lock);
        }
        spin_unlock_irq(&semaphore_lock);
        remove_wait_queue(&sem->wait, &wait);
        tsk->state = TASK_RUNNING;
        wake_up(&sem->wait);
}

I spent a couple of hours trying to get "fairness" working right
and have not been able to come up with a non-racy solution.  That
semaphore algorithm is amazing.  I'm really impressed.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
