Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263833AbTETRq1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 13:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263848AbTETRqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 13:46:24 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:5252 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S263833AbTETRqW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 13:46:22 -0400
Date: Tue, 20 May 2003 18:59:22 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] futex API cleanups, futex-api-cleanup-2.5.69-A2
Message-ID: <20030520175922.GA19094@mail.jlokier.co.uk>
References: <20030520010913.3300F2C05E@lists.samba.org> <Pine.LNX.4.55.0305191813240.6565@bigblue.dev.mcafeelabs.com> <20030520014403.GA14851@mail.jlokier.co.uk> <Pine.LNX.4.55.0305200947460.3636@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0305200947460.3636@bigblue.dev.mcafeelabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> > Yes, they do and it should work (I haven't tried, though).
> >
> > There is a practical problem when waiting on a futex in multiple
> > threads using epoll: you need a separate fd per waiter, rather than an
> > fd per waited-on futex.  This is because some uses of futexes depend
> > on waiters being woken in the exact order that they were queued.
> 
> Not really Jamie. See a Futex event is not much different from a network
> one. When the event shows up, one thread will pick it up (epoll_wait) and
> will handle it. A futex event will very likely be a green light for some
> sort of resource usage that whatever thread can pick up and handle.

That is true when a futex represents some item of work to do, or
readiness such as data coming in or going it.  Then it is quite
reasonable to think of it like a pollable fd.

But futexes are also used to represent contention for shared
resources, and the properties needed for this are quite different.

See futex_up_fair() in Rusty's futex-2.2 library.  That depends
crucially on getting exactly the right number of wakeup tokens passed,
and in the order the waiters blocked.

To pick an example, consider a dynamic web server which is
occasionally asked to render complex images, but where most of the
content is easily generated.  You might have 30 concurrent page
serving threads, but want to limit the number of threads which are
generating a particularly complex response to 3 at a time because of
memory constraints.

You cannot program this as putting things on a work queue and having
arbitrary threads pick them off, unless you are prepared to represent
the problem as an explicit state machine, where the intermediate
states can be represented as a data structure.  If the state is too
complex for that, which is often a reason for using threads in the
first place, that is not an option.

So it is important that _those_ kind of waiting threads are woken in
something approximating the order they went to sleep.  Otherwise there
is a danger of certain requests being starved unfairly.

To implement this you can use a simple futex, or a significantly more
complex, and slower, queue structure.

Using the futex, you either need an fd per waiter to get this
fairness, when the waiters are using epoll to listen for more than one
event, _or_ you need epoll to be clever and preserve the sleep-to-wake
ordering over a single futex.  I favour that last solution.

-- Jamie

