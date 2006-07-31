Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751509AbWGaKdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbWGaKdv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 06:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbWGaKdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 06:33:50 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:34720 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751341AbWGaKdt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 06:33:49 -0400
Date: Mon, 31 Jul 2006 14:33:22 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Zach Brown <zach.brown@oracle.com>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC 1/4] kevent: core files.
Message-ID: <20060731103322.GA1898@2ka.mipt.ru>
References: <44C91192.4090303@oracle.com> <20060727200655.GA4586@2ka.mipt.ru> <44C930D5.9020704@oracle.com> <20060728052312.GB11210@2ka.mipt.ru> <44CA586C.4010205@oracle.com> <20060728184445.GA10797@2ka.mipt.ru> <44CA613F.9080806@oracle.com> <44CAD81A.9060401@redhat.com> <20060729154401.GA25926@2ka.mipt.ru> <44CB8A67.3060801@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44CB8A67.3060801@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 31 Jul 2006 14:33:24 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2006 at 09:18:47AM -0700, Ulrich Drepper (drepper@redhat.com) wrote:
> Evgeniy Polyakov wrote:
> > Btw, why do we want mapped ring of ready events?
> > If user requestd some event, he definitely wants to get them back when
> > they are ready, and not to check and then get them?
> > Could you please explain more on this issue?
> 
> If of course makes no sense to enter the kernel to actually get the
> event.  This should be done by storing the event in the ring buffer.
> I.e., there are two ways to get an event:
> 
> - with a syscall.  This can report as many events at once as the caller
>   provides space for.  And no event which is reported in the run buffer
>   should be reported this way
> 
> - if there is space, report it in the ring buffer.  Yes, the buffer
>   can be optional, then all events are reported by the system call.

That requires a copy, which can neglect syscall overhead.
Do we really want it to be done?
 
> So the use case would be like this:
> 
> 
> wait_and_get_event:
> 
>   is buffer empty ?
> 
>     yes -> make syscall
> 
>     no -> get event from buffer
> 
> 
> To avoid races, the syscall needs to take a parameter indicating the
> last event checked out from the buffer.  If in the meantime the kernel
> put another event in the buffer the syscall immediately returns.
> Similar to what we do in the futex syscall.

And how "misordering" between queue and buffer is going to be managed?
I.e. when buffer is full and events are placed into queue, so syscall
could get them, and then syscall is called to get events from the queue
but not from the buffer - we can endup taking events from buffer while
old are placed in the queue.
And how waiting will be done without syscalls? Will glibc take care of
it?

> The question is how to best represent the ring buffer.  Zach and some
> others had some ready responses in Ottawa.  The important thing is to
> avoid cache line ping pong when possible.
> 
> Is the ring buffer absolutely necessary?  Probably not.  But it has the
> potential to help quite a bit.  Don't look at the problem to solve in
> the context of heavy I/O operations when another syscall here and there
> doesn't matter.  With this single event mechanism for every possible
> event the kernel can generate programming can look quite different.
> E.g., every read() call can implicitly we changed into an async read
> call followed by a user-level reschedule.  This rescheduling allows
> another thread of execution to run while the read request is processed.
>  I.e., it's basically a setjmp() followed by a goto into the inner loop
> to get the next event.  And now suddenly the event notification
> mechanism really should be as fast as possible.  If we submit basically
> every request asynchronously and are not creating dedicated threads for
> specific tasks anymore we
> 
> a) have a lot more event notifications
> 
> b) the probability of an event being reported when we want the receive
>    the next one if higher (i.e., the case where no syscall vs syscall
>    makes a difference)
> 
> Yes, all this will require changes in the way programs a written but we
> shouldn't limit the way we can write programs unnecessarily.  I think
> that given increasing discrepancies in relative speed/latency of the
> peripherals and the CPU this is one possible solution to keep the CPUs
> busy without resorting to a gazillion separate threads in each program.

Ok, let's do it in the following way:
I present new version of kevent with new syscalls and fixed issues mentioned
before, while people look at it we can end up with mapped buffer design.
Is it ok?

> -- 
> ➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
> 



-- 
	Evgeniy Polyakov
