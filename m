Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285062AbRLFIv5>; Thu, 6 Dec 2001 03:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285063AbRLFIvr>; Thu, 6 Dec 2001 03:51:47 -0500
Received: from mx2.elte.hu ([157.181.151.9]:25283 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S285062AbRLFIvn>;
	Thu, 6 Dec 2001 03:51:43 -0500
Date: Thu, 6 Dec 2001 11:38:29 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler Cleanup
In-Reply-To: <20011205154618.B24407@w-mikek2.des.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.33.0112061123230.2778-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 5 Dec 2001, Mike Kravetz wrote:

> One thing to note is that possible acquisition of the runqueue lock
> was reintroduced in sys_sched_yield().  From looking at the code, it
> seems the purpose was to ?add fairness? in the case of multiple
> yielders.  Is that correct Ingo?

yes, it's to add fairness. You might remember that i did this
sched_yield() optimization originally to help Volanomark performance. But
it turned out that it's very unfair not to move yielded processes to the
end of the runqueue - it might even cause livelocks in user-space
spinlocks which use sched_yield(). (since the POLICY_YIELD bit prevents
the process from running only *once*, so it will handle a two-process lock
situation right, but if multiple processes are racing for the lock then
they might exclude the real owner of the spinlock for a *long* time.)

(plus the change also broke sched_yield() for RT-FIFO processes.)

(nevertheless i'm sure we can add any invariant optimizations or fixes to
sys_sched_yield(), but this one - no matter how nice it was to this
particular benchmark, was neither invariant, nor a fix.)

the pure fact that your workload is so sensitive to sched_yield() LIFO vs.
FIFO yielding of runnable threads shows that there is some serious locking
design problem. It shows that there are 1) too many threads running 2)
only a small subset of those runnable threads are doing the real work, and
the rest is only runnable for some unknown reason.

i think the user-space locking mechanizm the IBM JVM uses should *not* be
based on sched_yield(). [is it using LinuxThreads? LinuxThreads have some
serious design problems IMO.] One thing i remember from running Volanomark
was the huge amount of signal related, mostly bogus wakeups. This i
believe is mainly due to the manager thread design of LinuxThreads. That
aspect should be fixed i think, i believe it can be correctly done (we can
get rid of the manager thread) via the latest 2.4 kernel.

while i see the point that the multiqueue scheduler improves performance
visibly, i'm quite sure you could get an *order of magnitude* faster if
the basic threading model (and any possible underlying mechanizm, such as
LinuxThreads) was fixed. The current Linux scheduler just magnifies these
userspace design problems. LinuxThreads was done when there werent many
good mechanizms within the kernel to help threading. Things have changed
by today - but if something still cannot be done cleanly and efficiently
(such as userspace spinlocks or semaphores) then please let us know so we
can fix things, instead of trying to work around the symptoms. But this is
just a suggestion.

	Ingo

