Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbTFDEll (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 00:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262830AbTFDEll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 00:41:41 -0400
Received: from mail.webmaster.com ([216.152.64.131]:43963 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S262827AbTFDElh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 00:41:37 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Bill Davidsen" <davidsen@tmr.com>, "Mike Galbraith" <efault@gmx.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [Linux-ia64] Re: web page on O(1) scheduler
Date: Tue, 3 Jun 2003 21:55:03 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKKELGDGAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <Pine.LNX.3.96.1030603234616.16495B-100000@gatekeeper.tmr.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> No, it works usefully without threads at all, with processes sharing a
> spinlock in shared memory. If the lock is closed process does a
> sched_yeild() to allow whoever has the lock to run. Yes to all comments
> WRT order of running, if you care you don't do this, clearly. But in the
> case where a process forks to a feeder and consumer it's faster than
> semaphores, signal, etc.
>
> All that's needed is to put the yeild process on the end of the
> appropriate run queue and reschedule. Doing anything else results in bad
> performance and no gain to anything else.
>
> --
> bill davidsen <davidsen@tmr.com>
>   CTO, TMR Associates, Inc
> Doing interesting things with little computers since 1979.

	I've found sched_yield to be most useful in a case where you can't afford
to wait for a lock, but your processing will be much more efficient if you
have that lock. So you do this:

bool TryYieldLock(lock *f)
{
 if(TryLock(f)) return true;
 sched_yield();
 return TryLock(f);
}

	And you use it like this:

if(TryYieldLock(f))
{ /* great, we got the lock, just do it */
 DoItNow(x);
 Unlock(f);
}
else
{ /* oh well, we didn't get the lock */
 schedule_thread(DoItLater, f);
}

	In other words, you try a bit harder than the usual 'trylock' function but
not as hard as waiting for the lock. If you don't get the lock, you have to
process it a more expensive way (perhaps scheduling another thread to come
around later and wait for the lock).

	Consider a 'free' function for a custom allocator. If there's contention,
you might be willing to do a sched_yield to free it immediately. But you
really don't want to block while some other thread tries to do some
expensive coalescing, in that case you'd rather schedule another thread to
come around later and free it.

	This is much less useful on an MP machine though. It's unlikely that
'sched_yield()' will give the other thread enough time to release the lock
since odds are it's running on the other CPU.

	DS


