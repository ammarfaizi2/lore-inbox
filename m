Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273141AbRJPGsS>; Tue, 16 Oct 2001 02:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273305AbRJPGsI>; Tue, 16 Oct 2001 02:48:08 -0400
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:25351 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S273141AbRJPGsB>; Tue, 16 Oct 2001 02:48:01 -0400
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: "David L. Mills" <mills@udel.edu>
Date: Tue, 16 Oct 2001 08:48:22 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [ntp:hackers] Linux feature
Message-ID: <3BCBF450.1611.2836C3@localhost>
In-Reply-To: <3BCB4401.E2E84470@udel.edu>
X-mailer: Pegasus Mail for Win32 (v3.12c)
X-Content-Conformance: HerringScan-0.9/Sophos-3.50+2.6+2.03.079+01 October 2001+68125@20011016.063655Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Oct 2001, at 21:16, David L. Mills wrote:

> Guys,
> 
> My Linux test box backroom.udel.edu has gone nuts. The clock frequency
> is pegged at 500 PPM and the offset swings wildly from peg to peg at 900
> s intervals. Sound familiar?
> 
> I found a bit of apparently misguided sleaze that explains a lot. The
> initial conditions happened to be a time error of about 600 ms and a
> frequency error of 500 PPM (from the ntp.drift file). This triggers a
> clock transition to state 3 on the assumption the frequency error is
> very, very large (which it is). After the 900-s stepout threshold, the
> time is reset and the frequency recalulated. Ordinarily, this corrects
> the errors right away and good timekeeping continues eventually to state
> 4. However, the step correction requested is only partially implemented
> by the Linux kernel, so the frequency correction is in error. This makes

Can you elaborate on that? I think in standard Linux a running 
adjtime() continues even after setting the time, and MOD_OFFSET and 
adjtime() both use the same variable, so don't expect the other to 
finish once you have used one of both. Is that the problem?

You could (to send me some flames) try a PPSkit patched kernel instead. 
The latest offer (not officially released is for kernel 2.4.7). Works 
at home for some weeks now...

> the problem worse and operation continues in simulate-pinball mode
> forever. Restarting the daemon with ntp.drift set to zero does not fix
> the problem.
> 
> Additional evidence suggests the ntpdate program reports a step
> correction, but the step is not implemented immediately; in fact, it
> takes maybe twenty seconds to complete. I expect this is whey a wait

Odd, very odd! Can you track it down to a system call?

> interval is implemented in some startup scripts. Note the ntpdate
> documentation (not written by me):
> 
> -B 
>     Force the time to always be slewed using the adjtime() system call,
> even if the measured offset is greater than +-128 ms. The default is to
> step the time using settimeofday() if the offset is greater than +-128
> ms. Note that, if the offset is much greater than +-128 ms in this case,
> that it can take a long time (hours) to slew the clock to the correct
> value. During this time. the host should not be used to synchronize
> clients.

That's how adjtime() works.

>  
> -b 
>     Force the time to be stepped using the settimeofday() system call,
> rather than slewed (default) using the adjtime() system call. This
> option should be used when called from a startup file at boot time.
> 
> One would assume the time is always reset above 128 ms, unless the -B
> option is set, and always slewed below 128 ms, unless the -b option is
> set. This confirms the Linux kernel responds to a step request
> (settimeofday()) by slewing the clock anyway.

I don't believe that, but I believe that adjtime() simply continues 
after a settimeofday(). Of course I've fixed that in my patches a long 
time ago.

> 
> The Linux behavor is broken to the max and directly responsible for the
> above scenario. In other words, should some transient kick the clock
> time and/or frequency in a significant way, ntpd will become unstable
> and degenerate to pinball mode. This will also cause ntpd to break in
> ntpdate mode. I expect this problem is the origin of many reports about
> Linux time stability. One more example where Linux refuses to conform to
> conventional semantics. Game over.

Honestly, Dave, your sample kernel code completely leaves out the topic 
of adjtime() vs. settimeofday(). One has to guess with some sound 
reasoning what's probably the best to do.

> 
> Dave

Ulrich

P.S. BCC'd to linux-kernel, so maybe some new people will respond.

