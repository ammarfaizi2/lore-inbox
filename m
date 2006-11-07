Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754189AbWKGL0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189AbWKGL0a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 06:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754194AbWKGL0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 06:26:30 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:9400 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1754189AbWKGL03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 06:26:29 -0500
Message-ID: <45506D51.30604@garzik.org>
Date: Tue, 07 Nov 2006 06:26:09 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [take21 0/4] kevent: Generic event handling mechanism.
References: <11619654014077@2ka.mipt.ru>
In-Reply-To: <11619654014077@2ka.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> Generic event handling mechanism.
> 
> Consider for inclusion.
> 
> Changes from 'take20' patchset:
>  * new ring buffer implementation
>  * removed artificial limit on possible number of kevents
> With this release and fixed userspace web server it was possible to 
> achive 3960+ req/s with client connection rate of 4000 con/s
> over 100 Mbit lan, data IO over network was about 10582.7 KB/s, which
> is too close to wire speed if we get into account headers and the like.

OK, now that ring buffer is here, I definitely like the direction this 
code is taking.  I just committed the patches to a local repo for a good 
in-depth review.

Could you write up a simple text file, documenting (a) your proposed 
syscalls and (b) your ring buffer design?


Overall I have a Linux "design wish", that I hope kevent can fulfill:

To develop completely async applications (generally network servers, in 
Linux-land) and increase the chance of zero-copy I/O, network and file 
I/O submission and completion should be as async as possible.

As such, syscalls themselves have come a serializing bottleneck that 
isn't strictly necessary.  A fully-async application should be able to 
submit file read, file write, and network write requests 
asynchronously... in batches.  Network reads, and file I/O completions 
should be received asynchronously, potentially in batches.

Even with epoll and AIO syscalls, Linux isn't quite up to the task.

So to me, the design of the userspace interface that solves this problem 
is a fundamental issue.

My best guess at a solution would be two classes of mmap'd ring buffers, 
request and response.  Let the app allocate one or more.  Then have two 
hooks, (a) kick the kernel to read the request ring, and (b) kick the 
app when one or more events have arrived on a ring.

But that's just thinking out loud.  I welcome any solution that gives 
userspace a fully-async submission/completion interface for both network 
and file I/O.

Setting the standard for a good interface here means Linux will kick ass 
for decades more to come ;-)  This is IMO a Big Deal(tm).

	Jeff


