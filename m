Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281690AbRKQIl6>; Sat, 17 Nov 2001 03:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281714AbRKQIls>; Sat, 17 Nov 2001 03:41:48 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:27387 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S281690AbRKQIln>; Sat, 17 Nov 2001 03:41:43 -0500
Message-ID: <3BF622AB.8EEF8D9D@mvista.com>
Date: Sat, 17 Nov 2001 00:41:15 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
CC: kravetz@us.ibm.com, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [Lse-tech] Re: Real Time Runqueue
In-Reply-To: <200111162241.QAA98422@tomcat.admin.navo.hpc.mil>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard wrote:
> 
> Mike Kravetz <kravetz@us.ibm.com>:
> >
> > As you may know, a few of us are experimenting with multi-runqueue
> > scheduler implementations.  One area of concern is where to place
> > realtime tasks.  It has been my assumption, that POSIX RT semantics
> > require a specific ordering of tasks such as SCHED_FIFO and SCHED_RR.
> > To accommodate this ordering, I further believe that the simplest
> > solution is to ensure that all realtime tasks reside on the same
> > runqueue.  In our MQ scheduler we have a separate runqueue for all
> > realtime tasks.  The problem is that maintaining a separate realtime
> > runqueue is a pain and results in some fairly complex/ugly code.
> >
> > Since I'm not a realtime expert, I would like to ask if my assumption
> > about strict ordering of RT tasks is accurate.  Also, is anyone aware
> > of other ways to approach this problem?
> 
> I used to do real-time (seismic survey navigation - sea, land and aircraft
> based systems). I've always admired some of the approaches used by the old
> VAX system (we did an adaptation for PDP-11/73 systems).
> 
> The operation provided a mixed environment of RR and fixed priority operation.
> The core scheduler is based on a bit vector of no larger than 64 fixed priority
> queues. Each queue could then be handled in a FIFO or RR manner. Selection
> of the queue was done by a "first bit set" selection. This identified the
> queue that the process was to be selected. Each queue had a selection fuction
> that could implement any choses scheduling algorithm, but we only used FIFO
> and RR. Several properties were required:
> 
> 1. Only runnable processes are permitted to exist in the queues.
> 2. An empty queue had the corresponding bit value of zero.
> 3. Any queue with pending processes had the corresponding bit set to 1.
> 
> Our adaption took the bit vector, converted it to floating point, and
> subtracted the exponent bias from the exponent. This gave us the "first bit
> set" in the vector. This index can then be used to select the queue and
> the selection algorithim. The return value is always the process to run.
> If the current process matches the original value, then return to the
> already loaded context; otherwise a context swich was called for. Also note
> that the current context contained the queue identifier. This makes it
> simple to save the current context. Of course, if the vector were zero then
> the idle task was invoked.

Take a look at http://sourceforge.net/projects/rtsched/ to see a linux
scheduler that uses very much this same thing.  No floating point, but
there are find first bit instructions on most machines.


> 
~snip
-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
