Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbUCFFNM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 00:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUCFFNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 00:13:12 -0500
Received: from mail.shareable.org ([81.29.64.88]:60039 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261601AbUCFFNK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 00:13:10 -0500
Date: Sat, 6 Mar 2004 05:12:56 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrea Arcangeli <andrea@suse.de>, Peter Zaitsev <peter@mysql.com>,
       Andrew Morton <akpm@osdl.org>, riel@redhat.com, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040306051256.GA9909@mail.shareable.org>
References: <20040229014357.GW8834@dualathlon.random> <1078370073.3403.759.camel@abyss.local> <20040303193343.52226603.akpm@osdl.org> <1078371876.3403.810.camel@abyss.local> <20040305103308.GA5092@elte.hu> <20040305141504.GY4922@dualathlon.random> <20040305143425.GA11604@elte.hu> <20040305145947.GA4922@dualathlon.random> <20040305150225.GA13237@elte.hu> <20040305201139.GA7254@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040305201139.GA7254@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> Ingo Molnar wrote:
> > if mysql in fact calls time() frequently, then it should rather start a
> > worker thread that updates a global time variable every second.
> 
> That has the same problem as discussed later in this thread with
> vsyscall-time: the worker thread may not run immediately it is woken,
> and also setitimer() and select() round up the delay a little more
> then expected, so sometimes the global time variable will be out of
> date and misordered.
>
> I don't know if such delays a problem for MySQL.

I still don't know about MySQL, but I have just encounted some code of
my own which does break if time() returns significantly out of date
values.

Any code which is structured like this will break:

	time_t timeout = time(0) + TIMEOUT_IN_SECONDS;

	do {
		/* Do some stuff which takes a little while. */
	} while (time(0) <= timeout);

It goes wrong when time() returns a value that is in the past, and
then jumps forward to the correct time suddenly.  The timeout of the
above code is reduced by the size of that jump.  If the jump is larger
than TIMEOUT_IN_SECONDS, the timeout mechanism is defeated completely.

That sort of code is a prime candidate for the method of using a
worker thread updating a global variable, so it's really important to
to take care when using it.

-- Jamie
