Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129109AbQJ3Ahh>; Sun, 29 Oct 2000 19:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129223AbQJ3Ah1>; Sun, 29 Oct 2000 19:37:27 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:63897 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S129109AbQJ3AhT>; Sun, 29 Oct 2000 19:37:19 -0500
Date: Sun, 29 Oct 2000 16:37:12 -0800
From: Dan Kegel <dank@alumni.caltech.edu>
Subject: Readiness vs. completion (was: Re: Linux's implementation of poll()
 not scalable?)
To: linux-kernel@vger.kernel.org, John Gardiner Myers <jgmyers@netscape.com>
Reply-to: dank@alumni.caltech.edu
Message-id: <39FCC2B8.DA281B4C@alumni.caltech.edu>
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Gardiner Myers <jgmyers@netscape.com> wrote:
> Your proposed interface suffers from most of the same problems as the 
> other Unix event interfaces I've seen. Key among the problems are 
> inherent race conditions when the interface is used by multithreaded 
> applications. 
> 
> The "stickiness" of the event binding can cause race conditions where 
> two threads simultaneously attempt to handle the same event. For 
> example, consider a socket becomes writeable, delivering a writable 
> event to one of the multiple threads calling get_events(). While the 
> callback for that event is running, it writes to the socket, causing the 
> socket to become non-writable and then writeable again. That in turn 
> can cause another writable event to be delivered to some other thread. 
> ...
> In the async I/O library I work with, this problem is addressed by 
> having delivery of the event atomically remove the binding. If the 
> event needs to be bound after the callback is finished, then it is the 
> responsibility for the callback to rebind the event. 

IMHO you're describing a situation where a 'completion notification event'
(as with aio) would be more appropriate than a 'readiness notification event'
(as with poll).

With completion notification, one naturally expects 'edge triggered',
'one shot' behavior from the notification system, with no event coalescing,
and there is no need to remove or reestablish bindings.

> There are three performance issues that need to be addressed by the 
> implementation of get_events(). One is that events preferably be given 
> to threads that are the same CPU as bound the event. That allows the 
> event's context to remain in the CPU's cache. 
> 
> Two is that of threads on a given CPU, events should wake threads in 
> LIFO order. This allows excess worker threads to be paged out. 
> 
> Three is that the event queue should limit the number of worker threads 
> contending with each other for CPU. If an event is triggered while 
> there are enough worker threads in runnable state, it is better to wait 
> for one of those threads to block before delivering the event. 

That describes NT's 'completion port / thread pooling' scheme, I think
(which incidentally is a 'completion notification' rather than a 'readiness
notification' - based scheme).

I suspect readiness notification using edge triggering is a
strange beast, not often seen in the wild, and hard to define precisely.

I'm going to risk generalizing, and categorizing the existing base
of application software into two groups.  Would it be going to far to say 
the following:

  Readiness notification, like that provided by traditional poll(),
  fits naturally with level-triggered events with event coalescing,
  and a large body of traditional Unix software exists that uses this paradigm.

  Completion notification, like that provided by aio and NT's networking,
  fits naturally with edge-triggered events with no event coalescing,
  and a large body of win32 software exists that uses this paradigm.

And, come to think of it, network programmers usually can be categorized
into the same two groups :-)  Each style of programming is an acquired taste.

IMHO if Linux is to be maximally popular with software developers
(desirable if we want to boost the number of apps available for Linux),
it would help to cater to both flavors of network programming.

So I'd like to see both a high-performance level-triggered readiness
notification API with event coalescing, and a high-performance edge-triggered
completion API with no event coalescing.  With luck, they'll be the
same API, but with slightly different flag values.

- Dan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
