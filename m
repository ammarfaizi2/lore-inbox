Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271796AbRHWJrE>; Thu, 23 Aug 2001 05:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271799AbRHWJqy>; Thu, 23 Aug 2001 05:46:54 -0400
Received: from ltgp.iram.es ([150.214.224.138]:2688 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id <S271796AbRHWJql>;
	Thu, 23 Aug 2001 05:46:41 -0400
Date: Thu, 23 Aug 2001 11:46:47 +0200 (CEST)
From: Gabriel Paubert <paubert@iram.es>
To: Paul Mackerras <paulus@samba.org>
cc: Chris Friesen <cfriesen@nortelnetworks.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (comments requested) adding finer-grained timing to PPC
  add_timer_randomness()
In-Reply-To: <15236.23943.260421.31691@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.21.0108231137080.2015-100000@ltgp.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Aug 2001, Paul Mackerras wrote:

> Chris Friesen writes:
> 
> > > +extern int have_timebase;
> > >   ...
> > 
> > > Am I missing something, or should at least one of these not be extern?
> > 
> > 
> > Okay, I feel dumb.  You're right of course. I guess I must have missed the
> > compiler warning.
> 
> I accidently deleted the message with the patch, but my comment would
> be that the way we have tended to handle this sort of thing is by
> reading the PVR register (processor version register) each time rather
> than by setting a flag in memory and testing that, since I expect that
> reading a special-purpose register in the CPU should be faster than
> doing a load from memory.
> 
> In the 2.4 tree we have code that works out a cpu features word from
> the PVR value.  The cpu features word has bits for things like does
> the cpu have the TB register, does the MMU use a hash table, does the
> cpu have separate I and D caches, etc.

Reading the PVR is probably faster in this case, since you avoid a
potential cache miss. As I said in an earlier message the __USE_RTC macro
should be made dependent on whether the kernel supports 601 or not.


> The other thing you could consider is using the value in the
> decrementer register rather than the TB or RTC.  The timer interrupt
> is signalled when the DEC transitions from 0 to -1, and the DEC keeps
> decrementing (at the same rate that the TB increments, on cpus which
> have a TB).  I assume that the source of randomness that you are
> trying to capture is the jitter in the timer (decrementer) interrupt
> latency.  AFAICS you could get that from DEC just as well as from the
> TB/RTC and it would have the advantage that you would not need a
> conditional on the processor version.

No, this is not what they are trying to capture. Furthermore the 7 LSB of
the decrementer on a 601 are not random (but they don't seem to be 0
always despite the documentation) so you would have to shift the result
right by 7. Because you need this test, it's better taking the time base
or RTC and adding some salt from the upper half while we are at it.

	Gabriel.

