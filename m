Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315218AbSGYQoL>; Thu, 25 Jul 2002 12:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315259AbSGYQoL>; Thu, 25 Jul 2002 12:44:11 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:26194 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S315218AbSGYQoK>; Thu, 25 Jul 2002 12:44:10 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 'select' failure or signal should not update timeout
References: <Pine.LNX.4.33.0207241142320.2117-100000@penguin.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 Jul 2002 10:35:28 -0600
In-Reply-To: <Pine.LNX.4.33.0207241142320.2117-100000@penguin.transmeta.com>
Message-ID: <m1eldrix4f.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On Wed, 24 Jul 2002, Jamie Lokier wrote:
> > 
> > Typical soft real-time code looks a bit like this pseudo-code (excuse
> > the bugs :-):
> 
> Yup, looks familiar.
> 
> The thing is, we cannot change existing select semantics, and the question 
> is whether what most soft-realtime wants is actually select, or whether 
> people really want a "waittimeofday()".
> 
> Like your example, the only uses I've had personally (DVD playback) have
> really had an empty select, so it wasn't really select itself that was 
> horribly important.

Baring minor quibbles waittimeofday is essentially what we have
today.  Fixing up the interface to take an absolute time, from an
absolute timer cleans up some races but doesn't attack the fundamental
problem.

There are two fundamental problems with the current interface.  The
timer granularity is much to large, and we don't know the granularity
that user space cares about.  

The posted wait_for_time implementation had one very interesting
aspect the timer granularity of the kernel (HZ) was known to the
application, and it very deliberately rounded the sleep interval down
based on the kernel timer granularity, so it could busy wait all by
itself for the rest.  Problem, user space applications can only get
what they want through busy waiting.  But they can tell when they have
gotten what they want because the gettimeofday resolution is much
better than the kernel timer resolution.

There are two states a unix box can be in. cpu load_average < 1.  In
this state multiple processes run per scheduler quantum.  They run for
short periods of time and then go back to sleep.  Latency is very good
because the other processes get out of the way, and sleeping process
can count on running at the next timer tick.  cpu load_average > 1.
In this state one or several processes run for their full cpu
quantum. Latency is bad, and opportunistically the timer resolution
does not get better.

When we have a cpu load average < 1, it is trivial to increase the
timer granularity to something resembling the gettimeofday resolution 
simply by internally doing gettimeofday when schedule is called, and
adding those processes that have just become runnable to the run
queue.  To get the most out of this the idle task would need to busy
wait looking for timer events, when we have an event scheduled before
the next timer tick.

The goal is twofold, to remove the need for user space applications to
busy wait, so sometimes the system can get something done another
process is waiting, and to increase the internal kernel timer
granularity to the point where user space doesn't care anymore.  With
the only timer we sleep past the desired time is when the kernel
decides there is some higher priority task to run.

On the timer queue I would use either microseconds (the resolution of
struct timeval), or the natural resolution of the timer, instead of
something artificial like HZ.  This allows faster machines under the
same load as slower machines to become more precise, with the same
code.  Polling for timers only in schedule and the idle task means
that when the load is low the kernel offers more precision than when
the load is high.  The frequency of timer interrupts would have to up,
at some point to handle some loads, but just keeping the load light
would allow the program to work as expected even without a kernel
recompile.

Having user space know HZ and use it for their internal calculations
is dangerous because HZ will change as time goes by.  But having user
space specify it's desired timer resolution to the kernel will allow
the kernel to round the time to a place where it can efficiently
handle the timer, and still meet the user space deadline.

The most interesting use I have seen is a high performance local area
data transfer utility, that would do short sleeps in between sending
packets to avoid pushing the switch to the point where it would drop
packets.  But it was perfectly fine if a new packet came in before it
was done waiting for the old packet to go out the wire.

Eric
