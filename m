Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbTKRMsG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 07:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbTKRMsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 07:48:06 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:44470 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262558AbTKRMsE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 07:48:04 -0500
Date: Tue, 18 Nov 2003 12:47:54 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] POSIX message queues - syscalls & SIGEV_THREAD
Message-ID: <20031118124754.GA23333@mail.shareable.org>
References: <Pine.GSO.4.58.0311161546260.25475@Juliusz> <20031117064832.GA16597@mail.shareable.org> <Pine.GSO.4.58.0311171236420.29330@Juliusz> <20031117153323.GA18523@mail.shareable.org> <Pine.GSO.4.58.0311181254490.27011@Juliusz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0311181254490.27011@Juliusz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Benedyczak wrote:
> I'm afraid not ;-). In our case there can happen two situations after
> setting notification: 1) (normal) notification event that have to be
> serviced 2) cancellation of notification - when thread which some time ago
> set notification resigns from it. In general it is only important that we
> need a possibility to "signal" userspace with 2 different values.

You can just store the different values in userspace before signalling
the futex wakeup, can't you?

> >     5. If any are different, close() the fds and return "did not sleep".
> ------>hole
> >     6. Call poll() on the list of fds to wait until one becomes ready.
> >     7. close() the fds and return "woken".
> 
> If I understand you in the right way - yes it is important. The very
> simple situation - we have two futexes. One wakeup on first
> futex happen between 5. and 6. On the futex number 2 never. Or after an
> hour.

You are setting the first futex's word in userspace prior to the first
futex wakeup, right?  Either 5 will detect that and return
immediately, or it will reach 6 and the poll() returns immediately.
No hole there.

( The async token passing flaw is that the _waker_ loses track of how
many succesful wakeups it has sent; this is used by some
implementations of fair semaphores, among other things.  That might be
relevant to POSIX message queues but I do not see that it's relevant
to the two futex problem you described. )

-- Jamie
