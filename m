Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270453AbTGMXiP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 19:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270454AbTGMXiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 19:38:15 -0400
Received: from mail9.speakeasy.net ([216.254.0.209]:21197 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP id S270453AbTGMXiG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 19:38:06 -0400
To: "David Schwartz" <davids@webmaster.com>
Cc: "Davide Libenzi" <davidel@xmailserver.org>,
       "Eric Varsanyi" <e0206@foo21.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch][RFC] epoll and half closed TCP connections
References: <MDEHLPKNGKAHNMBLJOLKGEFKEFAA.davids@webmaster.com>
From: Entrope <entrope@gamesnet.net>
Date: Sun, 13 Jul 2003 19:52:51 -0400
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKGEFKEFAA.davids@webmaster.com> (David
 Schwartz's message of "Sun, 13 Jul 2003 16:05:38 -0700")
Message-ID: <877k6m6l2k.fsf@sanosuke.troilus.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David Schwartz" <davids@webmaster.com> writes:

>	This is really just due to bad coding in 'poll', or more precisely very bad
> for this case. For example, why is it allocating a wait queue buffer if the
> odds that it will need to wait are basically zero? Why is it adding file
> descriptors to the wait queue before it has determined that it needs to
> wait?
>
> 	As load increases, more and more calls to 'poll' require no waiting. Yet
> 'poll' is heavily optimized for the 'no or low load' case. That's why 'poll'
> doesn't scale on Linux.

Your argument is bogus.  My first-hand experience is with IRC servers,
which customarily have thousands of connections at once, with a very
few percent active in a given check.  The scaling problem is not with
the length of waiting or how poll() is optimized -- it is with the
overhead *inherent* to processing poll().  Common IRC servers spend
100% of CPU when using poll() for only a few thousand clients.  Those
same servers, using FreeBSD's kqueue()/kevent() API, use well under
10% of the CPU.

Yes, the amount of time spent doing useful work increases as the
poll() load increases -- but the time wasted setting up and checking
activity for poll() is something you can never reclaim, and which only
goes up as your CPU gets faster.  epoll() makes you pay the cost of
updating the interest list only when the list changes; poll() makes
you pay the cost every time you call it.

Empirically, four of the five biggest IRC networks run server software
that prefers kqueue() on FreeBSD.  kqueue() did not cause them to be
large, but using kqueue() addresses specific concerns.  On the network
I can speak for, we look forward to having epoll() on Linux for the
same reason.

>> Yes, of course. The time spent inside poll/select becomes a PITA when you
>> start dealing with huge number of fds. And this is kernel time. This does
>> not obviously mean that if epoll is 10 times faster than poll under load,
>> and you switch your app on epoll, it'll be ten times faster. It means that
>> the kernel time spent inside poll will be 1/10. And many of the operations
>> done by poll require IRQ locks and this increase the time the kernel
>> spend with disabled IRQs, that is never a good thing.
>
> 	My experience has been that this is a huge problem with Linux but not with
> any other OS. It can be solved in user-space with some other penalities by
> an adaptive sleep before each call to 'poll' and polling with a zero timeout
> (thus avoiding the wait queue pain). But all the deficiencies in the 'poll'
> implementation in the world won't show anything except that 'poll' is badly
> implemented.

Your experience must be unique, because many people have seen poll()'s
inactive-client overhead cause CPU wastage problems on non-Linux OSes
(for me, FreeBSD and Solaris).

poll() may be badly implemented on Linux or not, but it shares a
design flaw with select(): that the application must specify the list
of FDs for each system call, no matter how few change per call.  That
is the design flaw that epoll() addresses.  If you truly believe that
poll()'s implementation is so flawed, please provide an improved
implementation.

To put it another way, all the optimizations in the world for a 'poll'
implementation won't sustain it unless you understand the flaw in its
specification.  The specification requires inefficient use of CPU for
very common situations.

Michael Poole
