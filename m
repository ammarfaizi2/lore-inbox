Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270178AbRHXHcq>; Fri, 24 Aug 2001 03:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270577AbRHXHch>; Fri, 24 Aug 2001 03:32:37 -0400
Received: from ltgp.iram.es ([150.214.224.138]:1408 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id <S270178AbRHXHc0>;
	Fri, 24 Aug 2001 03:32:26 -0400
Date: Fri, 24 Aug 2001 09:32:31 +0200 (CEST)
From: Gabriel Paubert <paubert@iram.es>
To: Paul Mackerras <paulus@samba.org>
cc: Chris Friesen <cfriesen@nortelnetworks.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (comments requested) adding finer-grained timing to PPC
  add_timer_randomness()
In-Reply-To: <15236.63384.489975.150804@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.21.0108240856370.1353-100000@ltgp.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Aug 2001, Paul Mackerras wrote:

> Gabriel Paubert writes:
> 
> > Reading the PVR is probably faster in this case, since you avoid a
> > potential cache miss.
> 
> Yep.
> 
> > As I said in an earlier message the __USE_RTC macro
> > should be made dependent on whether the kernel supports 601 or not.
> 
> We don't have USE_RTC in 2.2.  The proposed patch was for 2.2.19.

Ok, I looked at the wrong tree in my small forest :-) My 2.2 tree has the
timing/clock changes of 2.4 since it's actually where I first wrote them
when chasing why NTP's PLL frequency error estimate varied according to
system load. Nevertheless, Chris needs something similar to USE_RTC.

> 
> > No, this is not what they are trying to capture. Furthermore the 7 LSB of
> > the decrementer on a 601 are not random (but they don't seem to be 0
> > always despite the documentation) so you would have to shift the result
> 
> Don't you mean that the 7 LSB of RTCL aren't random and are supposed
> to be 0?  The decrementer should decrement by 1 at a rate of 7.8125MHz
> and all the bits should be implemented.

No, both the RTC and the decrementer count nanoseconds, except that the 7
LSB are not implemented because the timebase clock should have a period of
128 ns (7.8125 MHz, but according to Takashi Oe, many 601 systems did not
bother to provide the exact frequency and are off by 11 parts in 4096 or
so). As such the LSB can't be used to estimate randomness and the value
must be shifted right by 7. So you need some conditional code (or boot
time patching). At this point you can throw in the high order part
(RTCU/TBU) for additional randomization (RTCU changes much faster on 601,
once per second, than on the other processors). 

Nitpicking: because RTCL wraps around at 1e9, only the 2 LSB after right
shifting have equal probabilities of being 0 or 1. The bias is probably
not that serious (provided we underestimate what people insist in calling
entropy), but I have not carefully checked its effect.

This nanosecond counting was the specification for the Power architecture.
However, once again according to Takashi, the 7 LSB of the DEC or RTC do
not always read as zeroes. Checking the 601 doc, rather fuzzy in this
area, the RTC should return 0, in the 7 LSB, but the DEC might return what
was last written). However, AFAIR Takashi found that even the RTC could
return junk in the LSB.


	Gabriel.

P.S: basic rule, on all Power/PPC processors I have seen so far: 
(RTCL or TBL) + DEC = constant (modulo wraparounds).

