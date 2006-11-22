Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753942AbWKVMLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942AbWKVMLR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 07:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753945AbWKVMLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 07:11:17 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:11463 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1753942AbWKVMLQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 07:11:16 -0500
Date: Wed, 22 Nov 2006 15:09:34 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Alexander Viro <aviro@redhat.com>
Subject: Re: [take24 0/6] kevent: Generic event handling mechanism.
Message-ID: <20061122120933.GA32681@2ka.mipt.ru>
References: <11630606361046@2ka.mipt.ru> <45564EA5.6020607@redhat.com> <20061113105458.GA8182@2ka.mipt.ru> <4560F07B.10608@redhat.com> <20061120082500.GA25467@2ka.mipt.ru> <4562102B.5010503@redhat.com> <20061121095302.GA15210@2ka.mipt.ru> <45633049.2000209@redhat.com> <20061121174334.GA25518@2ka.mipt.ru> <4563FD53.7030307@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <4563FD53.7030307@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 22 Nov 2006 15:09:37 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2006 at 11:33:39PM -0800, Ulrich Drepper (drepper@redhat.com) wrote:
> Evgeniy Polyakov wrote:
> >Threads are parked in syscalls - which one should be interrupted?
> 
> It doesn't matter, use the same policy you use when waking a thread in 
> case of an event.  This is not about waking a specific thread, it's 
> about not dropping the event notification.
> 
> 
> >And what if there were no threads waiting in syscalls?
> 
> This is fine, do nothing.  It means that the other threads are about to 
> read the ring buffer and will pick up the event.
> 
> 
> The case which must be avoided is that of all threads being in the 
> kernel, one threads gets woken, and then is canceled.  Without notifying 
> the kernel about the cancellation and in the absence of further events 
> notifications the process is deadlocked.
> 
> A second case which should be avoided is that there is a thread waiting 
> when a thread gets canceled and there are one or more addition threads 
> around, but not in the kernel.  But those other threads might not get to 
> the ring buffer anytime soon, so handling the event is unnecessarily 
> delayed.

Ok, to solve the problem in the way which should be good for both I
decided to implement additional syscall which will allow to mark any
event as ready and thus wake up appropriate threads. If userspace will
request zero events to be marked as ready, syscall will just
interrupt/wakeup one of the listeners parked in syscall.

Piece?

-- 
	Evgeniy Polyakov
