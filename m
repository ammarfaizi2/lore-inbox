Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263966AbTDNVpZ (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263950AbTDNVnu (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:43:50 -0400
Received: from users.ccur.com ([208.248.32.211]:17837 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S263949AbTDNVnT (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 17:43:19 -0400
Date: Mon, 14 Apr 2003 17:54:10 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Andrew Morton <akpm@digeo.com>, Robert Love <rml@tech9.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC] 2.5 TASK_INTERRUPTIBLE preemption race
Message-ID: <20030414215410.GA18922@rudolph.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Robert, Alan, Everyone,
 The following 2.5 code fragment seems unsafe in a preempt
environment.  A preemption could occur between the time when
TASK_UNINTERRUPTIBLE is set and the `spin_lock_irqsave'.  This would
cause the task to switch out and never come back, as it would have
been switched away while in TASK_UNINTERRUPTIBLE without yet having
put itself onto the semaphore wait queue, where it could be found
later by a wakeup service.

    void __down(struct semaphore * sem)
    {
	struct task_struct *tsk = current;
	DECLARE_WAITQUEUE(wait, tsk);
	unsigned long flags;

	tsk->state = TASK_UNINTERRUPTIBLE;
	spin_lock_irqsave(&sem->wait.lock, flags);
	add_wait_queue_exclusive_locked(&sem->wait, &wait);
	....
    }

Is this analysis correct?  If it is, perhaps there is an alternative
to fixing these cases individually: make the TASK_INTERRUPTIBLE/
TASK_UNINTERRUPTIBLE states block preemption.  In which case the
'set_current_state(TASK_RUNNING)' macro would need to include the
same preemption check as 'preemption_enable'.

I suspect there is already some mechanism in place to prevent this
problem, as I have never seen this lockup happen on any of my
2.4-preempt systems.

Joe

PS: here is an example where the preemption race appears harmless.
If a preemption happens between the 'set_current_state' and
'schedule', it only causes the 'schedule' to NOP: the preemption, on
return, would have changed the state from TASK_UNINTERRUPTIBLE back
to TASK_RUNNING.

void __wait_on_inode(struct inode *inode)
{
	DECLARE_WAITQUEUE(wait, current);
	wait_queue_head_t *wq = i_waitq_head(inode);

	add_wait_queue(wq, &wait);
repeat:
	set_current_state(TASK_UNINTERRUPTIBLE);
	if (inode->i_state & I_LOCK) {
		schedule();
		goto repeat;
	}
	remove_wait_queue(wq, &wait);
	__set_current_state(TASK_RUNNING);
}

PPS: the above may need a 'mb()' between the 'add_wait_queue' and
'set_current_state' regardless.
