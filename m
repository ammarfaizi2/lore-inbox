Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270224AbRIGA6j>; Thu, 6 Sep 2001 20:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270154AbRIGA6a>; Thu, 6 Sep 2001 20:58:30 -0400
Received: from blount.mail.mindspring.net ([207.69.200.226]:6948 "EHLO
	blount.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S270224AbRIGA6S>; Thu, 6 Sep 2001 20:58:18 -0400
Subject: Re: [PATCH] (Updated) Preemptible Kernel
From: Robert Love <rml@tech9.net>
To: psusi@cfl.rr.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200109070046.f870kEM06465@smtp-server2.tampabay.rr.com>
In-Reply-To: <999813729.2039.9.camel@phantasy> 
	<200109070046.f870kEM06465@smtp-server2.tampabay.rr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.05.07.08 (Preview Release)
Date: 06 Sep 2001 20:58:35 -0400
Message-Id: <999824322.2429.10.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-09-06 at 16:39, Phillip Susi wrote:
> This sounds interesting, but am I correct in assuming that this only allows 
> preemption during code that is called from user space?  For instance, it 
> would be bad to preempt an ISR or BH, right?  Actually... what happens if 
> say, the kernel called from user space is holding a lock, and gets preempted? 
>  Is there a mechanism to disable preemption while holding locks or at other 
> resources that need to be freed before another task is run?
> 
> By the way, are there any other 'modes of execution' for lack of a better 
> word, besides IRS, B, and.... 'called from user space', also for lack of a 
> better word.  Forgive me, I'm not that familiar with the Linux kernel yet.

The SMP locking mechanisms (spinlocks, readlocks, writelocks) are used
to prevent preemption for reentrancy or data validity reasons (this is
the same reason we do this for SMP).  So, there is no worry about
holding locks and whatnot.

We also don't allow preemption during interrupt handling, bottom halves,
or during execution of the scheduler itself.  So, you are correct again,
no preemption during ISRs or BHs.

At all other times, preemption is allowed.  It occurs when another task
comes due for execution -- now, even if in kernel space, we will yield
execution to the new process.  Please give the patch a try, enable
preemption, and see what you think.

Some other changes were made, too.  Certain conditions were prevented
(ie, dont return to user with a pending soft interrupt).  A preemption
counter is maintained, and the locks now modify it.  A new
TASK_PREEMPTING flag was created.

To answer your question, besides system calls (ie, `on behalf of a
process') you have ISRs, BHs, wait-queued routines (a growing number of
these), and other kernel threads (keventd, ksoftirqd, kswapd, etc) which
are typically timer/queued events anyhow.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

