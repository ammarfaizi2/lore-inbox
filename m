Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264749AbSJ3RVq>; Wed, 30 Oct 2002 12:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264757AbSJ3RVq>; Wed, 30 Oct 2002 12:21:46 -0500
Received: from ns.suse.de ([213.95.15.193]:26894 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S264749AbSJ3RVn>;
	Wed, 30 Oct 2002 12:21:43 -0500
Date: Wed, 30 Oct 2002 18:28:05 +0100 (CET)
From: Bernhard Kaindl <bk@suse.de>
To: <linux-kernel@vger.kernel.org>
Cc: Ulrich Weigand <weigand@informatik.uni-erlangen.de>,
       Neale Ferguson <Neale.Ferguson@SoftwareAG-USA.com>
Subject: [PATCH] IPC SMP race: msgrcv may not return before msgsnd is done
Message-ID: <Pine.LNX.4.33.0210301800150.2930-100000@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this is targeted to System V message queue Experts and people who
use System V message queues quite extensively in SMP environments.

It contains descriptions of a SMP race in sys_msgrcv, a fix for
it and some questions about the code in question(maybe there is
a better fix, but I think the proposed one is ok)

I've already a short feedback from Andi Kleen, he told me that
the Description and patch seem to be correct as far as he can see.

Neale Ferguson from Software AG debugged a SMP race in the message
queue implementation of the 2.4 Kernel.

The race was triggered in a time frame of 20 minutes to 14 hours after
starting a complex application stress test which uses message queues
quite extensively.

The race could have been triggered as follows:

	CPU 1			CPU 2

	sys_msgrcv()
	(sleeps for messsage)

				sys_msgsnd()
				pipelined_send()
	                        wake_up_process()
	(wakes up the process)
	sys_msgrcv gets the
	message and exits
				pipelined_send() is still
				using the linked list with
				the receivers, but the
				receiver element from the
				process that just received
				the message is freed now
				because it is a stack variable
				of the sys_msgrcv which just
				exited.
	schedules some random
	new process which calls
	the kernel and uses the
	stack freed by sys_msgrcv
	again
				pipelined_send now tries to
				dereference a pointer which
				has been initalized on CPU1
				by the random process

--------------------------------------------------------------------

The resulting oops in wake_up_process which is called within
pipelined_send has been reproduced on the i386 and s390 architectures
with 2.4.7, 2.4.17 and 2.4.19 kernels.

Now the patch part:

-------------------------------------------------------------------------
Symptom:	jump to zero in kernel/wake_up_process causes Kernel oops
Description:	sys_msgscv may return without waiting for the lock of
		sys_msgsnd which causes that a stack variable may be
		overwritten
Solution:	Don't try to return in sys_msgscv before the lock is
		released by sys_msgsnd.

Short description of the problem:

 After schedule returns, sys_msgrcv needs to reacquire the lock to make
 sure noone still uses a temporary pointer to the msg_receiver which is
 on the stack of sys_msgrcv before it exits.

Detailed description of the problem:

In sys_msgrcv, msr_d is defined on the stack:
> 728 asmlinkage long sys_msgrcv (int msqid, struct msgbuf *msgp, size_t msgsz,
and then added to the list:
> 803                 list_add_tail(&msr_d.r_list,&msq->q_receivers);
now we wait until wakeup because someone sent the message we are waiting for:
> 815                 schedule();
When we return, we check for success and go out before checking for the lock
which may be still hold and needed by pipelined_send within sys_msgsnd:
> 818                 msg = (struct msg_msg*) msr_d.r_msg;
> 819                 if(!IS_ERR(msg))
> 820                         goto out_success;

<patch description>

While attempting an initial patch I've noticed that the first

               msg = (struct msg_msg*) msr_d.r_msg;
               if(!IS_ERR(msg))
                       goto out_success;

can be just omitted and the rest should be just what we need,
because the next is reaquiriing the lock, the exact code we
need after the schedule in which we were waiting for the wake
up called by msgsnd because it just send us a message we can
process now:

                t = msg_lock(msqid);
                if(t==NULL)
                        msqid=-1;
                msg = (struct msg_msg*)msr_d.r_msg;
                if(!IS_ERR(msg)) {
                        /* our message arived while we waited for
                         * the spinlock. Process it.
                         */
                        if(msqid!=-1)
                                msg_unlock(msqid);
                        goto out_success;
                }

</patch description>

So this is the proposed patch:

--- linux-2.4.19/ipc/msg.c
+++ linux-2.4.19/ipc/msg.c
@@ -806,28 +806,24 @@
 		msr_d.r_mode = mode;
 		if(msgflg & MSG_NOERROR)
 			msr_d.r_maxsize = INT_MAX;
 		 else
 		 	msr_d.r_maxsize = msgsz;
 		msr_d.r_msg = ERR_PTR(-EAGAIN);
 		current->state = TASK_INTERRUPTIBLE;
 		msg_unlock(msqid);

 		schedule();
 		current->state = TASK_RUNNING;

-		msg = (struct msg_msg*) msr_d.r_msg;
-		if(!IS_ERR(msg))
-			goto out_success;
-
 		t = msg_lock(msqid);
 		if(t==NULL)
 			msqid=-1;
 		msg = (struct msg_msg*)msr_d.r_msg;
 		if(!IS_ERR(msg)) {
 			/* our message arived while we waited for
 			 * the spinlock. Process it.
 			 */
 			if(msqid!=-1)
 				msg_unlock(msqid);
 			goto out_success;
 		}

Question part:

The question we have is why this first check was there in the first place,
the only explanation we could understand is that this was some attempt to
improve performance (if the contention at this lock is high).

Maybe someone can think of a better fix, but as long there is none,
correctness is more important than performance the patch should be
fine as bug-fix.

Acknowledgements:
-----------------
Analysis was done using lcrash and VM tracing on s390 by Neale Ferguson(SAG)
Very helpful directions and explanations provided by Ulrich Weigand(IBM)

--
Best Regards,
Bernhard Kaindl
SuSE Linux and United Linux Development

