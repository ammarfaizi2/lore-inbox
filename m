Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271185AbVBFHnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271185AbVBFHnx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 02:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271178AbVBFHnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 02:43:52 -0500
Received: from gateway.ottawa.transgaming.com ([209.217.80.34]:14034 "HELO
	ottawa.transgaming.com") by vger.kernel.org with SMTP
	id S272790AbVBFHmv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 02:42:51 -0500
Subject: Re: PATCH: SysV semaphore race vs SIGSTOP
From: Ove Kaaven <ovek@transgaming.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <420485B1.5030103@colorfullife.com>
References: <420485B1.5030103@colorfullife.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Organization: TransGaming Technologies Inc
Date: Sun, 06 Feb 2005 02:42:49 -0500
Message-Id: <1107675769.20835.48.camel@renegade>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lør, 05,.02.2005 kl. 09.37 +0100, skrev Manfred Spraul:
> Hi Ove,
> 
> >As I mentioned in an earlier mail, there is a race when SIGSTOP-ing a
> >process waiting for a SysV semaphore, where if a process holding a
> >semaphore suspends another process waiting on the semaphore and then
> >releases the semaphore, 
> >
> Your patch looks correct (for 2.4 - 2.6 uses a different approach), but 

Actually I myself don't think the patch I sent is 100% correct. The most
glaring problem is of course that it only handles SIGSTOP and nothing
else, but I wasn't sure how to handle anything else. Also, I've since
found that the "continue" in there made it impossible to attach
debuggers or the like to a process blocked in semop. Finally, it would
occasionally continue to loop after the condition is satisfied, e.g.
when the semop is 0.

So, the if check in my patch is more correct as

+               if (is_stopping(current) && queue.status == 1)
+                       /* Could either EINTR out or continue.
+                        * I suppose EINTR is the robust choice. */
+                       queue.status = -EINTR;

but that still doesn't handle all signals. I'm thinking that if the
SIGSTOP problem can be solved simply by returning EINTR (and let the
userspace code deal with that by retrying), then perhaps that can be
done for all signals.

Summarily, my "perfect" patch for 2.4 might simply look like this
(assuming signal_pending does the right thing, which I haven't
verified):

--- ipc/sem.c.original	2005-01-31 18:17:17.000000000 -0500
+++ ipc/sem.c	2005-02-06 01:52:01.000000000 -0500
@@ -961,6 +961,9 @@
 			error = -EIDRM;
 			goto out_free;
 		}
+		if (signal_pending(current) && queue.status == 1)
+			queue.status = -EINTR;
+
 		/*
 		 * If queue.status == 1 we where woken up and
 		 * have to retry else we simply return.


As for 2.6, yes, the 2.6 code does seem to be harder to make a simple
patch for. Then again, we're thinking of using futexes instead of
semaphores if a 2.6 kernel is detected, so if futexes don't have this
problem, I guess we can use them to work around this semaphore flaw.

> I'm not certain that it's needed:
> You assume that signals have an immediate effect.

I don't necessarily need it to have an "immediate" effect. Only that
pending signals are taken into consideration when the process returns
from certain blocking system calls dealing with atomic synchronization
primitives such as semaphores. I want to be able to think that
synchronization primitives are there to *protect* me against the effects
of implementation details such as delayed signal delivery, not that they
have their own synchronization issues. After all, the man page for
"semop" states that

* The calling process catches a signal: the value of semzcnt is
decremented and semop() fails, with errno set to EINTR.

and I want to be able to expect this to always actually happen. Because
semop is supposed to be an *atomic* operation, I don't expect it to
*both* catch a signal *and* succeed within the same semop system call
(knowing that the signal *must* have been sent by the time the semaphore
condition was fulfilled). See where I'm coming from?

> Linux ignores that - it delays signal processing under some 
> circumstances. If a syscall can be completed without blocking, then the 
> syscall is handled, regardless of any pending signals. The signal is 
> handled at the syscall return, i.e. after completing the syscall.
> That's not just in SysV semaphore - at least pipes are identical:

Perhaps. But at least read() doesn't claim to be an atomic
synchronization primitive like semop() does. Though I suppose it's
occasionally used that way...

> pipe_read first check if there is data. If there is some, then it 
> returns the data. Signals are only checked if there is no pending data.
> I'm not sure if this is a bug. But if it's one, then far more than just 
> sysv sem must be updated.

I'd probably only concern myself with things that are supposed to be
atomic, really.

Anyway, thanks a lot for answering.

