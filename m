Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264808AbSJOUwA>; Tue, 15 Oct 2002 16:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264809AbSJOUwA>; Tue, 15 Oct 2002 16:52:00 -0400
Received: from relay1.pair.com ([209.68.1.20]:59402 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S264808AbSJOUv6>;
	Tue, 15 Oct 2002 16:51:58 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3DAC840E.A601C318@kegel.com>
Date: Tue, 15 Oct 2002 14:09:34 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: John Gardiner Myers <jgmyers@netscape.com>
CC: Benjamin LaHaise <bcrl@redhat.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
References: <3DAB46FD.9010405@watson.ibm.com>
	 <20021015110501.B11395@redhat.com> <3DAC4B0E.EBB3A2AB@kegel.com>
	 <3DAC59ED.2070405@watson.ibm.com> <3DAC643C.86A016B4@kegel.com>
	 <20021015145731.J14596@redhat.com> <3DAC79D3.2010908@netscape.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Gardiner Myers wrote:
> 
> Benjamin LaHaise wrote:
> 
> >If you look at how /dev/epoll does it, the collapsing of readiness
> >events is very elegant: a given fd is only allowed to report a change
> >in its state once per run through the event loop.
> >
> And the way /dev/epoll does it has a key flaw: it only works with single
> threaded callers.  If you have multiple threads simultaneously trying to
> get events, then race conditions abound.

Delaying the "get next batch of readiness events" call as long as
possible 
increases the amount of event collapsing possible, which is important
because 
the network stack seems to generate lots of spurious events.  Thus I
suspect 
you don't want multiple threads all calling the "get next batch of
events"
entry point frequently.
The most effective way to use something like /dev/epoll in a
multithreaded 
program might be to have one thread call "get next batch of events",
then divvy up the events across multiple threads.  
Thus I disagree that the way /dev/epoll does it is flawed.

> I certainly hope /dev/epoll itself doesn't get accepted into the kernel,
> the interface is error prone.  Registering interest in a condition when
> the condition is already true should immediately generate an event, the
> epoll interface did not do that last time I saw it discussed.  This
> deficiency in the interface requires callers to include more complex
> workaround code and is likely to result in subtle, hard to diagnose bugs.

With queued readiness notification schemes like SIGIO and /dev/epoll,
it's safest to allow readiness notifications from the kernel
to be wrong sometimes; this happens at least in the case of accept
readiness,
and possibly other places.  Once you allow that, it's easy to handle the
condition you're worried about by generating a spurious readiness
indication when registering a fd.  That's what I do in my wrapper
library.  

Also, because /dev/epoll and friends are single-shot notifications of
*changes* in readiness, there is little reason to register interest in
this or that event, and change that interest over time; instead,
apps should simply register interest in any event they might ever
be interested in.  The number of extra events they then have to ignore
is very
small, since if you take no action on a 'read ready' event, no more
of those events will occur.

So I pretty much disagree all around :-) but I do understand where
you're
coming from.  I used to feel similarly until I figured out the
'right' way to use one-shot readiness notification systems
(sometime last week :-)

- Dan
