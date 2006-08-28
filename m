Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWH1Ckx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWH1Ckx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 22:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbWH1Ckx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 22:40:53 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:12248 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932290AbWH1Ckw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 22:40:52 -0400
Subject: Re: [take14 0/3] kevent: Generic event handling mechanism.
From: Nicholas Miell <nmiell@comcast.net>
To: David Miller <davem@davemloft.net>
Cc: drepper@redhat.com, johnpol@2ka.mipt.ru, linux-kernel@vger.kernel.org,
       akpm@osdl.org, netdev@vger.kernel.org, zach.brown@oracle.com,
       hch@infradead.org, chase.venters@clientec.com
In-Reply-To: <20060827.185744.82374086.davem@davemloft.net>
References: <11564996832717@2ka.mipt.ru> <44F208A5.4050308@redhat.com>
	 <20060827.185744.82374086.davem@davemloft.net>
Content-Type: text/plain
Date: Sun, 27 Aug 2006 19:40:33 -0700
Message-Id: <1156732833.2358.13.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-08-27 at 18:57 -0700, David Miller wrote:
> From: Ulrich Drepper <drepper@redhat.com>
> Date: Sun, 27 Aug 2006 14:03:33 -0700
> 
> > The biggest problem I see so far is the integration into the existing
> > interfaces.  kevent notification *really* should be usable as a new
> > sigevent type.  Whether the POSIX interfaces are liked by kernel folks
> > or not, they are what the majority of the userlevel programmers use.
> > The mechanism is easily extensible.  I've described this in my paper.  I
> > cannot comment on the complexity of the kernel side but I'd imagine it's
> > not much more difficult, just different from what is implemented now.
> > Let's learn for a change from the mistakes of the past.  The new and
> > innovative AIO interfaces never took off because their implementation
> > differs so much from the POSIX interfaces.  People are interested in
> > portable code.  So, please, let's introduce SIGEV_KEVENT.  Then we
> > magically get timer notification etc for free.
> 
> I have to disagree with this.
> 
> SigEvent, and signals in general, are crap.  They are complex
> and userland gets it wrong more often than not.  Interfaces
> for userland should be simple, signals are not simple.  A core
> loop that says "give me events to process", on the other hand,
> is.  And this is what is most natural for userspace.
> 
> The user can say when he wants the process events.  In fact,
> ripping out the complex signal handling will be a welcome
> change for most server applications.
> 
> We are going to require the use of a new interface to register
> the events anyways, why keep holding onto the delivery baggage
> as well when we can break free of those limitations?

struct sigevent is the POSIX method for describing how event
notifications are delivered.

Two methods are specified in POSIX -- SIGEV_SIGNAL, which delivers a
signal to the process and SIGEV_THREAD which creates a new thread in the
process and calls a user-supplied function. In addition to these two
methods, Linux also implements SIGEV_THREAD_ID, which sends a signal to
a specific thread (this is used internally by glibc to implement
SIGEV_THREAD, but I imagine that would change on the addition of
SIGEV_KEVENT).

Ulrich is suggesting the addition of SIGEV_KEVENT, which causes the
event notification to be delivered to a specific kevent queue. This
would allow for event delivery to kevent queues from POSIX AIO
completions, POSIX message queues, POSIX timers, glibc's async name
resolution interface and anything else that might use a struct sigevent
in the future.

-- 
Nicholas Miell <nmiell@comcast.net>

