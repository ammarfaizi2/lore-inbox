Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275042AbRJFGqg>; Sat, 6 Oct 2001 02:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275043AbRJFGq0>; Sat, 6 Oct 2001 02:46:26 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:45321 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S275042AbRJFGqO>; Sat, 6 Oct 2001 02:46:14 -0400
Message-ID: <3BBEA8CF.D2A4BAA8@zip.com.au>
Date: Fri, 05 Oct 2001 23:46:39 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: low-latency patches
In-Reply-To: <20011006010519.A749@draal.physics.wisc.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob McElrath wrote:
> 
> It seems there are two low-latency projects out there.  The one by Robert Love:
>     http://tech9.net/rml/linux/
> and the original one:
>     http://www.uow.edu.au/~andrewm/linux/schedlat.html
> 
> Correct me if I'm wrong, but the former uses spinlocks to know when it can
> preempt the kernel, and the latter just tries to reduce latency by adding
> (un)conditional_schedule and placing it at key places in the kernel?

Pretty much.  The second one also reorganises various areas of the
kernel which can traverse very long lists when under spinlocks.

> My questions are:
> 1) Which of these two projects has better latency performance?  Has anyone
>     benchmarked them against each other?

I haven't seen any rigorous latency measurements on Rob's stuff, and
I haven't seriously measured the reschedule-based patch for months.  But
I would expect the preempt patch to perform significantly worse because
it doesn't attempt to break up the abovementioned long-held locks.  (It can
do so, though - a straightforward adaptation of the reschedule patch's
changes will fix it).

> 2) Will either of these ever be merged into Linus' kernel (2.5?)

Controversial.  My vague feeling is that they shouldn't.  Here's
why:

The great majority of users and applications really only need
a mostly-better-than-ten-millisecond latency.  This gives good
responsiveness for user interfaces and media streaming.  This
can trivially be achieved with the current kernel via a thirty line
patch (which _should_ be applied to 2.4.x.  I need to get off my
butt).

But the next rank of applications - instrumentation, control systems,
media production sytems, etc require 500-1000 usec latencies, and
the group of people who require this is considerably smaller.  And their
requirements are quite aggressive.  And maintaining that performance
with either approach is a fair bit of work and impacts (by definition)
the while kernel.  That's all an argument for keeping it offstream.

> 3) Is there a possibility that either of these will make it to non-x86
>     platforms?  (for me: alpha)  The second patch looks like it would
>     straightforwardly work on any arch, but the config.in for it is only in
>     arch/i386.  Robert Love's patches would need some arch-specific asm...
> 

The rescheduling patch should work fine on any architecture - just copy
the arch/i386/config.in changes.

-
