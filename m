Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270541AbTGNF7b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 01:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270540AbTGNF7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 01:59:31 -0400
Received: from mail.webmaster.com ([216.152.64.131]:60652 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S270541AbTGNF72
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 01:59:28 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Entrope" <entrope@gamesnet.net>
Cc: "Davide Libenzi" <davidel@xmailserver.org>,
       "Eric Varsanyi" <e0206@foo21.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [Patch][RFC] epoll and half closed TCP connections
Date: Sun, 13 Jul 2003 23:14:13 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKGEHGEFAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <877k6m6l2k.fsf@sanosuke.troilus.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Your argument is bogus.  My first-hand experience is with IRC servers,
> which customarily have thousands of connections at once, with a very
> few percent active in a given check.  The scaling problem is not with
> the length of waiting or how poll() is optimized -- it is with the
> overhead *inherent* to processing poll().  Common IRC servers spend
> 100% of CPU when using poll() for only a few thousand clients.  Those
> same servers, using FreeBSD's kqueue()/kevent() API, use well under
> 10% of the CPU.

	My argument is not bogus, you just don't understand it. Two algorithms can
scale at the same order and yet one can perform much better than the other.
Poll, for example, could use 10% of the CPU at 100 users and 100% at 1000
users. While kqueue/kevent could use .01% at 100 users and .2% at 1000
users. With these numbers, poll is much more scalable (its CPU usage went up
by a factor of 10 while kqueue went up by a factor of 20) yet kqueue will
outperform poll.

	I am specifically talking about scalability, in the compsci sense. I grant
that epoll will use less CPU than poll in every configuration.

> Yes, the amount of time spent doing useful work increases as the
> poll() load increases -- but the time wasted setting up and checking
> activity for poll() is something you can never reclaim, and which only
> goes up as your CPU gets faster.  epoll() makes you pay the cost of
> updating the interest list only when the list changes; poll() makes
> you pay the cost every time you call it.

	I know what epoll *is*.

> Empirically, four of the five biggest IRC networks run server software
> that prefers kqueue() on FreeBSD.  kqueue() did not cause them to be
> large, but using kqueue() addresses specific concerns.  On the network
> I can speak for, we look forward to having epoll() on Linux for the
> same reason.

	Wonderful, now please show me where the error in my argument is.

> > 	My experience has been that this is a huge problem with
> > Linux but not with
> > any other OS. It can be solved in user-space with some other
> > penalities by
> > an adaptive sleep before each call to 'poll' and polling with a
> > zero timeout
> > (thus avoiding the wait queue pain). But all the deficiencies
> > in the 'poll'
> > implementation in the world won't show anything except that
> > 'poll' is badly
> > implemented.

> Your experience must be unique, because many people have seen poll()'s
> inactive-client overhead cause CPU wastage problems on non-Linux OSes
> (for me, FreeBSD and Solaris).

	References please? And again, artificial cases where the number of active
descriptors were held constant while the number of inactive descriptors were
increased do not count.

> poll() may be badly implemented on Linux or not, but it shares a
> design flaw with select(): that the application must specify the list
> of FDs for each system call, no matter how few change per call.  That
> is the design flaw that epoll() addresses.

	I know that. What does that have to do with anything? Are you even reading
what I'm writing?

> If you truly believe that
> poll()'s implementation is so flawed, please provide an improved
> implementation.

	It's trivial to make the optimizations that my post very obviously
suggests. One would be to defer creating the wait queue until it's clear we
need to wait. The problem is, these optimizations would harm the low-load
and no-load cases and it's my understanding from the last time this was
discussed that changes that worsen the 'most common' case will be refused
even if they improve the 'high load' case.

> To put it another way, all the optimizations in the world for a 'poll'
> implementation won't sustain it unless you understand the flaw in its
> specification.  The specification requires inefficient use of CPU for
> very common situations.

	Fine, but show me how that flaw impacts scalability. Please read what I
said again, I understand that 'epoll' is superior to 'poll'. I'm
specifically disputing whether or not 'epoll' has a specific mathematical
characteristic.

	DS


