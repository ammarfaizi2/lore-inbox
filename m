Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281908AbRLFSOe>; Thu, 6 Dec 2001 13:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281916AbRLFSOP>; Thu, 6 Dec 2001 13:14:15 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:32518 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S281915AbRLFSON>; Thu, 6 Dec 2001 13:14:13 -0500
Date: Thu, 6 Dec 2001 10:25:17 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Ingo Molnar <mingo@elte.hu>
cc: Mike Kravetz <kravetz@us.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler Cleanup
In-Reply-To: <Pine.LNX.4.33.0112061123230.2778-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.40.0112061021080.1603-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2001, Ingo Molnar wrote:

>
> On Wed, 5 Dec 2001, Mike Kravetz wrote:
>
> > One thing to note is that possible acquisition of the runqueue lock
> > was reintroduced in sys_sched_yield().  From looking at the code, it
> > seems the purpose was to ?add fairness? in the case of multiple
> > yielders.  Is that correct Ingo?
>
> yes, it's to add fairness. You might remember that i did this
> sched_yield() optimization originally to help Volanomark performance. But
> it turned out that it's very unfair not to move yielded processes to the
> end of the runqueue - it might even cause livelocks in user-space
> spinlocks which use sched_yield(). (since the POLICY_YIELD bit prevents
> the process from running only *once*, so it will handle a two-process lock
> situation right, but if multiple processes are racing for the lock then
> they might exclude the real owner of the spinlock for a *long* time.)
>
> (plus the change also broke sched_yield() for RT-FIFO processes.)

What about decreasing counter by 1 for each sched_yield() call ?
Is this case we achieve ( expecially with the counter decay patch ) a
correct task recycling w/out lock acquiring inside the system call.



> while i see the point that the multiqueue scheduler improves performance
> visibly, i'm quite sure you could get an *order of magnitude* faster if
> the basic threading model (and any possible underlying mechanizm, such as
> LinuxThreads) was fixed. The current Linux scheduler just magnifies these
> userspace design problems. LinuxThreads was done when there werent many
> good mechanizms within the kernel to help threading. Things have changed
> by today - but if something still cannot be done cleanly and efficiently
> (such as userspace spinlocks or semaphores) then please let us know so we
> can fix things, instead of trying to work around the symptoms. But this is
> just a suggestion.

Ingo, you've to admit that having separate run queue with separate locks
is just more than a benchmark fix, it's matter of sane design.




- Davide


