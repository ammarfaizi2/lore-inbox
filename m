Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbVJYP6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbVJYP6R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 11:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbVJYP6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 11:58:17 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:30993 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750891AbVJYP6R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 11:58:17 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20051025154440.GA12149@elte.hu>
References: <20051019111943.GA31410@elte.hu> <1129835571.14374.11.camel@cmn3.stanford.edu> <20051020191620.GA21367@elte.hu> <1129852531.5227.4.camel@cmn3.stanford.edu> <20051021080504.GA5088@elte.hu> <1129937138.5001.4.camel@cmn3.stanford.edu> <20051022035851.GC12751@elte.hu> <1130182121.4983.7.camel@cmn3.stanford.edu> <1130182717.4637.2.camel@cmn3.stanford.edu> <1130183199.27168.296.camel@cog.beaverton.ibm.com> <20051025154440.GA12149@elte.hu>
X-OriginalArrivalTime: 25 Oct 2005 15:58:14.0928 (UTC) FILETIME=[E8780900:01C5D97C]
Content-class: urn:content-classes:message
Subject: Re: 2.6.14-rc4-rt7
Date: Tue, 25 Oct 2005 11:58:12 -0400
Message-ID: <Pine.LNX.4.61.0510251148210.2448@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.14-rc4-rt7
Thread-Index: AcXZfOiBt8DJArLtR9yWhAZO+HB7WQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: "john stultz" <johnstul@us.ibm.com>,
       "Fernando Lopez-Lezcano" <nando@ccrma.Stanford.EDU>,
       "Mark Knecht" <markknecht@gmail.com>,
       "Rui Nuno Capela" <rncbc@rncbc.org>,
       "Steven Rostedt" <rostedt@goodmis.org>,
       "david singleton" <dsingleton@mvista.com>,
       "Thomas Gleixner" <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
       <cc@ccrma.Stanford.EDU>, "William Weston" <weston@lysdexia.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 25 Oct 2005, Ingo Molnar wrote:

>
> John
>
> i found one source of timekeeping bugs on SMP boxes, it's the
> non-monotonicity of the TSC:
>
> ... time warped from 1270809453 to 1270808096.
> ... MTSC warped from 0000000a731a8c3c [0] to 0000000a731a899c [2].
> ... MTSC warped from 0000000a7c93baec [0] to 0000000a7c93b7a8 [3].
> ... MTSC warped from 0000000a881d6afc [0] to 0000000a881d67d0 [2].
> ... MTSC warped from 0000000a924217a0 [0] to 0000000a924216ac [3].
> ... MTSC warped from 0000000a9c592788 [0] to 0000000a9c59232c [2].
> ... MTSC warped from 0000000aa7aa95c8 [0] to 0000000aa7aa9338 [3].
> ... MTSC warped from 0000000b33206d60 [0] to 0000000b33206a48 [3].
> ... time warped from 26699635824 to 26699633144.
> ... MTSC warped from 00000013f379cb88 [0] to 00000013f379c7e0 [3].
> ... MTSC warped from 0000001413df8660 [0] to 0000001413df8200 [3].
> ... MTSC warped from 00000014194f5360 [1] to 00000014194f51b0 [2].
> ... time warped from 60775269225 to 60775266727.
>
> the number in square brackets is the CPU#. I.e. CPUs on this 4-CPU box
> have small TSC differences, which ends up leaking into the generic TOD
> code, causing real time warps, which causes ktimer weirdnesses (timers
> failed to expire, etc.).
>
> (the above output tracks TSC results globally, under a spinlock. It also
> detects time-warps that propagate into the monotonic clock output.)
>
> unfortunately, there's no easy solution for this. We could make
> cycle_last per-CPU, but that again brings up the question of how to set
> up the per-CPU 'TSC offset' values - those would need similar technique
> that the current clear-all-TSCs-on-all-CPUs code does - which as we can
> see failed ...
>
> 	Ingo

Anything that uses the CPU clock is going to fail in the long-run.
Many motherboards are now shipped with "spread-spectrum" clocks
that can't be disabled. This means that the frequency will no
longer be constant. This is particularly horrible when some
boards sweep the clock on only one direction!

FYI, the spread-spectrum method of cheating on the FCC part 15
rules will eventually catch up with manufacturers. There has been
about 10 years of idiocy where the observed interference is simply
smeared by the spectrum analyzer filters to seem like it's 20 dB
or so lower than it really is. The increased interference from
electronic equipment that use such fundamental cheating is only
now beginning to be recognized by th FCC. The DOC (Canada) has
been complaining about this for many years.

Maybe the RTC chip should be used as a RTC instead of a gravitational
clamp used once upon startup and once upon shutdown?

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
