Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129523AbQKHXMT>; Wed, 8 Nov 2000 18:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129265AbQKHXMJ>; Wed, 8 Nov 2000 18:12:09 -0500
Received: from gateway.sequent.com ([192.148.1.10]:18991 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S129584AbQKHXL5>; Wed, 8 Nov 2000 18:11:57 -0500
Date: Wed, 8 Nov 2000 15:11:49 -0800
From: Mike Kravetz <mkravetz@sequent.com>
To: linux-kernel@vger.kernel.org
Subject: test9: running tasks not in run-queue
Message-ID: <20001108151148.B25050@w-mikek.des.sequent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been playing around with the scheduler in the test9
kernel and noticed that it sometimes chooses tasks to run
that are not on the run-queue.  This may seem strange, but
here is how it happens

task A on processor 0, calls __lock_sock() which does the
following:

void __lock_sock(struct sock *sk)
{
        DECLARE_WAITQUEUE(wait, current);

        add_wait_queue_exclusive(&sk->lock.wq, &wait);
        for(;;) {
                current->state = TASK_EXCLUSIVE | TASK_UNINTERRUPTIBLE;
                spin_unlock_bh(&sk->lock.slock);
                schedule();
                spin_lock_bh(&sk->lock.slock);
                if(!sk->lock.users)
                        break;
        }
        current->state = TASK_RUNNING;
        remove_wait_queue(&sk->lock.wq, &wait);
}

Now when __lock_sock calls schedule, the task's state is set
as above and the following scheduler code removes the task from
the run-queue.

        switch (prev->state & ~TASK_EXCLUSIVE) {
                case TASK_INTERRUPTIBLE:
                        if (signal_pending(prev)) {
                                prev->state = TASK_RUNNING;
                                break;
                        }
                default:
                        del_from_runqueue(prev);
                case TASK_RUNNING:
        }

After the task is removed from the run-queue, an interrupt is
serviced on another CPU which ultimately calls __wake_up_common().
__wake_up_common() chooses task A to wakeup and best_exclusive is
is set to A.  The following code in __wake_up_common() is then
executed:

        if (best_exclusive)
                best_exclusive->state = TASK_RUNNING;
        wq_write_unlock_irqrestore(&q->lock, flags);

        if (best_exclusive) {
                if (sync)
                        wake_up_process_synchronous(best_exclusive);
                else
                        wake_up_process(best_exclusive);
        }

Note that the state of task A will then be set to TASK_RUNNING.
Now back on CPU 1 (where we are in the scheduler routine) we
perform the following test:

        if (prev->state == TASK_RUNNING)
                goto still_running;

Since the state of prev has been changed to TASK_RUNNING by the
__wake_up_common code, we set next = prev.  This means that we
potentially choose to continue running the current task, even
though the task has been deleted from the run-queue.

Now, what usually happens is that wake_up_process_synchronous or
wake_up_process will add the task back to the run-queue as soon
as the scheduler drops the run-queue lock.  Therefore, this does
not seem to cause any problems.

I'm curious, is this behavior by design OR are we just getting
lucky?

Thanks,
-- 
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center
15450 SW Koll Parkway
Beaverton, OR 97006-6063                     (503)578-3494
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
