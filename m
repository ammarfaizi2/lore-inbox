Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbTKRMVD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 07:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbTKRMVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 07:21:03 -0500
Received: from leon-2.mat.uni.torun.pl ([158.75.2.64]:32959 "EHLO
	leon-2.mat.uni.torun.pl") by vger.kernel.org with ESMTP
	id S262129AbTKRMU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 07:20:59 -0500
Date: Tue, 18 Nov 2003 13:20:49 +0100 (CET)
From: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
X-X-Sender: golbi@Juliusz
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] POSIX message queues - syscalls & SIGEV_THREAD
In-Reply-To: <20031117153323.GA18523@mail.shareable.org>
Message-ID: <Pine.GSO.4.58.0311181254490.27011@Juliusz>
References: <Pine.GSO.4.58.0311161546260.25475@Juliusz>
 <20031117064832.GA16597@mail.shareable.org> <Pine.GSO.4.58.0311171236420.29330@Juliusz>
 <20031117153323.GA18523@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Nov 2003, Jamie Lokier wrote:

> Krzysztof Benedyczak wrote:
> > > Please can you describe your "intuitive solution" using FUTEX_FD more clearly?
> >
[cut]
>
> To be honest I don't understand the purpose of this manager thread,
> but then I know very little about POSIX message queues.

Oh, I it think it doesn't matter much anyway...

>
> > > I don't quite understand what you wrote, but there are flaws(*) in the
> > > current FUTEX_FD implementation which I would like to fix anyway.
> >
> > Now I'm not sure if we are talking about the same flaw. In our case: the
> > problem is that after returning from poll we do some work (create thread
> > etc.) and after a while we return to poll(). If some notification will
> > occur then - ups we will miss it.
>
> You said something about cancellation, is this the same thing?

I'm afraid not ;-). In our case there can happen two situations after
setting notification: 1) (normal) notification event that have to be
serviced 2) cancellation of notification - when thread which some time ago
set notification resigns from it. In general it is only important that we
need a possibility to "signal" userspace with 2 different values.

> > > Perhaps we can improve async futexes in a way which is useful for you?
> >
> > Maybe something like poll which would have just one difference. It would
> > have to check if all of futexes given as parameter have the same value as
> > given parameters. If not - it should return immediately with EWOULDBLOCK.
> > In another words some hybrid of poll and FUTEX_WAIT. Or even simplier:
> > MULTIPLE_FUTEX_WAIT.
>
> You don't need any futex change.  You can do this already in userspace on top
> of FUTEX_FD:
>
>     1. In userspace, check all the futexes against the values.
>     2. If any are different, return "did not sleep".
>
> 1. and 2. are just an optimisation; if that case is rare, they aren't needed.
>
>     3. Call FUTEX_FD for each futex and store the fds.
>     4. Check all the futexes against the values.
>     5. If any are different, close() the fds and return "did not sleep".
------>hole
>     6. Call poll() on the list of fds to wait until one becomes ready.
>     7. close() the fds and return "woken".
>
> Note that this is not necessarily the most efficient implementation
> for your purpose, but it would work.
>
> There is a problem if you depend on the "token passing" property of
> futexes to keep track of the exact number of wakeups: between poll()
> and close() you may lose wakeups which a waker thinks it sent.  This
> is because async futex "test and remove" is not atomic if the test
> says there was no wakeup, unlike sync futex.  This is the flaw I would
> like to fix for async futexes, but it is not necessarily relevant to
> your problem.

If I understand you in the right way - yes it is important. The very
simple situation - we have two futexes. One wakeup on first
futex happen between 5. and 6. On the futex number 2 never. Or after an
hour.


Thanks,
Krzysiek

