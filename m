Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263262AbTKQPd7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 10:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263310AbTKQPd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 10:33:59 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:19638 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263262AbTKQPd5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 10:33:57 -0500
Date: Mon, 17 Nov 2003 15:33:23 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
Cc: linux-kernel@vger.kernel.org, Manfred Spraul <manfred@colorfullife.com>,
       Urlich Drepper <drepper@redhat.com>,
       Michal Wronski <wrona@mat.uni.torun.pl>
Subject: Re: [PATCH] POSIX message queues - syscalls & SIGEV_THREAD
Message-ID: <20031117153323.GA18523@mail.shareable.org>
References: <Pine.GSO.4.58.0311161546260.25475@Juliusz> <20031117064832.GA16597@mail.shareable.org> <Pine.GSO.4.58.0311171236420.29330@Juliusz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0311171236420.29330@Juliusz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Benedyczak wrote:
> > Please can you describe your "intuitive solution" using FUTEX_FD more clearly?
> 
> Sure. To make things more clear I will omit issue with adding a new
> notification. So let assume that we have some message queues and we want
> to wait on notification on them. In userspace we can assign one futex to
> every such a queue and pass it to kernel in mq_notify syscall. Then we can
> use FUTEX_FD to get file descriptors of all futexes and wait on them with
> poll(). On the kernel side it notification have to be triggered we change
> futex value and do FUTEX_WAKE.
> 
> The whole idea was to have one "manager" thread which will spawn
> SIGEV_THREAD notification thread just when notification will _occur_ (the
> simple current solution spawns this thread ahead during setting
> notification).

To be honest I don't understand the purpose of this manager thread,
but then I know very little about POSIX message queues.

> > I don't quite understand what you wrote, but there are flaws(*) in the
> > current FUTEX_FD implementation which I would like to fix anyway.
> 
> Now I'm not sure if we are talking about the same flaw. In our case: the
> problem is that after returning from poll we do some work (create thread
> etc.) and after a while we return to poll(). If some notification will
> occur then - ups we will miss it.

You said something about cancellation, is this the same thing?

> > Perhaps we can improve async futexes in a way which is useful for you?
> 
> Maybe something like poll which would have just one difference. It would
> have to check if all of futexes given as parameter have the same value as
> given parameters. If not - it should return immediately with EWOULDBLOCK.
> In another words some hybrid of poll and FUTEX_WAIT. Or even simplier:
> MULTIPLE_FUTEX_WAIT.

You don't need any futex change.  You can do this already in userspace on top
of FUTEX_FD:

    1. In userspace, check all the futexes against the values.
    2. If any are different, return "did not sleep".

1. and 2. are just an optimisation; if that case is rare, they aren't needed.

    3. Call FUTEX_FD for each futex and store the fds.
    4. Check all the futexes against the values.
    5. If any are different, close() the fds and return "did not sleep".
    6. Call poll() on the list of fds to wait until one becomes ready.
    7. close() the fds and return "woken".

Note that this is not necessarily the most efficient implementation
for your purpose, but it would work.

There is a problem if you depend on the "token passing" property of
futexes to keep track of the exact number of wakeups: between poll()
and close() you may lose wakeups which a waker thinks it sent.  This
is because async futex "test and remove" is not atomic if the test
says there was no wakeup, unlike sync futex.  This is the flaw I would
like to fix for async futexes, but it is not necessarily relevant to
your problem.

-- Jamie
