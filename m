Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965137AbVLOBDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965137AbVLOBDS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 20:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965139AbVLOBDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 20:03:18 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:23801 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S965137AbVLOBDR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 20:03:17 -0500
In-Reply-To: <20051214223912.GA4716@in.ibm.com>
References: <20051214223912.GA4716@in.ibm.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9175126B-6D06-11DA-AA1B-000A959BB91E@mvista.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
From: david singleton <dsingleton@mvista.com>
Subject: Re: Recursion bug in -rt
Date: Wed, 14 Dec 2005 17:03:13 -0800
To: dino@in.ibm.com
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar,
	you may be correct, since reverting the change in down_futex seems to 
work.
However, I'm  wondering if you've hit  a bug that Dave Carlson is 
reporting that
he's tracked down to an inline in the glibc patch.

	I'll explain what the kernel code is intending to do and you can let me
know what you think.

	The changes to the latest robust futex patch are to close an
SMP race condition that Dave Carlson reported.  The changes
were intended to make the robust wait/wake code behave like
the regular futex_wait/wake code, which doesn't see this race condition.

	The change allowed the library to pass in the value that it
saw in the lock when it tried to lock the pthread_mutex.  The kernel
then locks the mmap_sem and robust_sem to protect the kernel
lock and checks the value in the pthread_mutex again.

	If the value has not changed since the time the library
saw it then the kernel continues to wait for the lock.

	Reverting the check in down_futex would mean that the library
saw that the thread trying to lock the lock actually owned the lock in
user space and still tried to wait for the lock.

	The library then passed this value into the kernel which checked
to see if the value had changed since the kernel acquired its locks.

	The kernel determined that the value had not changed
and called down_futex to block  for the lock.

	The down futex code used the value in the lock to
find the owning task.  The task it found was the current task!

	Now there are two problems I see with the reversion:

1) Why did the library call into the kernel if the calling thread
owned the lock?

2) The reversion would have the kernel pass back EAGAIN
if it found that the the thread trying to lock the lock was
in fact the owning thread.   EAGAIN would cause the
library to retry to lock the lock it already owns!

	So I'm wondering if the error you're seeing is caused
by a bug in the library.   I'm trying to get a glibc patch from Dave
Carlson that he says fixes his problem.

	 Can you run strace and see if you are getting any EAGAINs
back from mutex_lock?  EAGAINs passed to user space is an
error,  the library should try again as long as
the value it got back from wait_robust is EAGAIN.

	What do you think?

David

On Dec 14, 2005, at 2:39 PM, Dinakar Guniguntala wrote:

> Hi David,
>
> I hit this bug with -rt22-rf11
>
> ==========================================
> [ BUG: lock recursion deadlock detected! |
> ------------------------------------------
> already locked:  [f7abbc94] {futex}
> .. held by:          testpi-3: 4595 [f7becdd0,  59]
> ... acquired at:               futex_wait_robust+0x142/0x1f3
> ------------------------------
> | showing all locks held by: |  (testpi-3/4595 [f7becdd0,  59]):
> ------------------------------
>
> #001:             [f7abbc94] {futex}
> ... acquired at:               futex_wait_robust+0x142/0x1f3
>
> -{current task's backtrace}----------------->
>  [<c0103e04>] dump_stack+0x1e/0x20 (20)
>  [<c0136bc2>] check_deadlock+0x2d7/0x334 (44)
>  [<c01379bc>] task_blocks_on_lock+0x2c/0x224 (36)
>  [<c03f29c5>] __down_interruptible+0x37c/0x95d (160)
>  [<c013aebf>] down_futex+0xa3/0xe7 (40)
>  [<c013ebc5>] futex_wait_robust+0x142/0x1f3 (72)
>  [<c013f35c>] do_futex+0x9a/0x109 (40)
>  [<c013f4dd>] sys_futex+0x112/0x11e (68)
>  [<c0102f03>] sysenter_past_esp+0x54/0x75 (-8116)
> ------------------------------
> | showing all locks held by: |  (testpi-3/4595 [f7becdd0,  59]):
> ------------------------------
>
> #001:             [f7abbc94] {futex}
> ... acquired at:               futex_wait_robust+0x142/0x1f3
>
> ---------------------------------------------------------------------
>
> futex.c -> futex_wait_robust
>
>         if ((curval & FUTEX_PID) == current->pid) {
>                 ret = -EAGAIN;
>                 goto out_unlock;
>         }
>
> rt.c    -> down_futex
>
>         if (!owner_task || owner_task == current) {
>                 up(sem);
>                 up_read(&current->mm->mmap_sem);
>                 return -EAGAIN;
>         }
>
> I noticed that both the above checks below have been removed in your
> patch. I do understand that the futex_wait_robust path has been
> made similar to the futex_wait path, but I think we are not taking
> PI into consideration. Basically it looks like we still need to check
> if the current task has become owner. or are we missing a lock 
> somewhere ?
>
> I added the down_futex check above and my test has been
> running for hours without the oops. Without this check it
> used to oops within minutes.
>
> Patch that works for me attached below.  Thoughts?
>
>         -Dinakar
>
>
> <check_current.patch>

