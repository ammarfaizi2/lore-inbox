Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWH1C75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWH1C75 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 22:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWH1C75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 22:59:57 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:12736 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932372AbWH1C74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 22:59:56 -0400
Subject: Re: [take14 0/3] kevent: Generic event handling mechanism.
From: Nicholas Miell <nmiell@comcast.net>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>
In-Reply-To: <44F208A5.4050308@redhat.com>
References: <11564996832717@2ka.mipt.ru>  <44F208A5.4050308@redhat.com>
Content-Type: text/plain
Date: Sun, 27 Aug 2006 19:59:37 -0700
Message-Id: <1156733977.2358.31.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-08-27 at 14:03 -0700, Ulrich Drepper wrote:

[ note: there was lots of good stuff that I cut out because it was a
long email and I'm only replying to some of its points ]

> Events to wait for are basically all those with syscalls which can
> potentially block indefinitely:
> 
> - file descriptor
> - POSIX message queues (these are in fact file descriptors but
>   let's make it legitimate)
> - timer expiration
> - signals (just as sigwait, not normal delivery instead of a handler)

For some of them (like SIGTERM), delivery to a kevent queue would
actually make sense.

> The ring buffer interface is not described in Nicholas' description.

I wasn't even aware there was a ring-buffer interface in the proposed
patches. Another reason why the onus of documenting a patch is on the
originator: the random nobody who ends up doing the documenting may
screw it up.

> Which brings me to the second point about the current kevent_get_events
> syscall.  I don't think the min_nr parameter is useful.  Probably we
> should not even allow the kevent queue to be used with different max_nr
> parameters in different thread.  If you'd allow this, how would the
> event notification be handled?  A waiter with a smaller required number
> of events would always be woken first.  I think the number of required
> events should be a property of the kevent object.  Then the code would
> create different kevent object if the requirement is different.  At the
> very least I'd declare it an error if at any time there are two or more
> threads delayed which have different requirements on the number of
> events.  This could provide all the flexibility needed while preventing
> some of the mistakes one can make.

I was thinking about this, and it's even worse in the case where a
kevent fd is shared by different processes (either by forking or by
passing it via PF_UNIX sockets).

What happens when you queue an AIO completion to a shared kevent queue?
(The AIO read only happened in one address space, or did it? What if the
read was to a shared memory region? What if the memory region is shared,
but mapped at different addresses? What if not all of the processes
involved have that AIO fd open?)

Also complicated is the case where waiting threads have different
priorities, different timeouts, and different minimum event counts --
how do you decide which thread gets events first? What if the decisions
are different depending on whether you want to maximize throughput or
interactivity?

-- 
Nicholas Miell <nmiell@comcast.net>

