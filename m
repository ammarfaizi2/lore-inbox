Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317422AbSHTWI4>; Tue, 20 Aug 2002 18:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317427AbSHTWI4>; Tue, 20 Aug 2002 18:08:56 -0400
Received: from krynn.axis.se ([193.13.178.10]:26817 "EHLO krynn.axis.se")
	by vger.kernel.org with ESMTP id <S317422AbSHTWIz>;
	Tue, 20 Aug 2002 18:08:55 -0400
From: johan.adolfsson@axis.com
Message-ID: <05fe01c24897$5e0a7380$b9b270d5@homeip.net>
Reply-To: <johan.adolfsson@axis.com>
To: "Oliver Xymoron" <oxymoron@waste.org>, <johan.adolfsson@axis.com>
Cc: <linux-kernel@vger.kernel.org>
References: <01a301c2482c$51a00e40$b9b270d5@homeip.net> <20020820140346.GC19225@waste.org> <03f401c24867$2d5260c0$b9b270d5@homeip.net> <20020820170601.GD19225@waste.org> <050b01c2486f$c6701880$b9b270d5@homeip.net> <20020820180257.GF19225@waste.org> <05da01c2487e$b2321120$b9b270d5@homeip.net> <20020820193408.GG19225@waste.org>
Subject: Re: [RFC] Improved add_timer_randomness for __CRIS__ (instead of rdtsc())
Date: Wed, 21 Aug 2002 00:17:26 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > No, the high order bits aren't very interesting at all. Don't worry
> > > about that bit, it's just cuteness.
> >
> > ok:-)
> > But if the the timestamp doesn't have to be entirely accurate
> > the name should perhaps reflect that, since at least on the cris arch
> > you can save some cycles if you can accept a glitch now and then.
>
> Describe this glitch again? Bear in mind that resolution is a very
> different matter than accuracy. Jiffies are not accurate in any
> absolute sense, but they are monotonic. And unless you've got
> interrupts shut off, even get_cycles can only giving you the time
> when it stores the timestamp in the register, which may have little to
> do with the time the next instruction that uses it executes.

I'l try...
timer0 counts from 250 down to 1 and generates the timer interrupt
at 100Hz and starts counting from 250 again.
It's value can be read to find out when in a jiffie you are with 40 us
resolution.
The prescaler is running at 25 MHz and counting from 1000 to 1
and is used as clock input to timer0.

When reading timer0, it might have wrapped before jiffies is updated
causing the time to go back unless handled.
Unfortunatly the prescaler value is in a different register then
timer0 so that value can wrap as well compared to the timer0 value.
It's possible to solve but it takes some extra code which might be
bad to have in e.g. the network interrupt path.
So my idea was to shift the jiffies value 8 bits, add/or the 8 bit (0-250)
from the timer0 register and perhaps also 10 bits (0-1000) from
the prescaler value to get 40 ns resolution (the CPU runs at 100MHz)
and ignore the proper math to scale it and the wraps as well.
In a way the wraps will only add uncertainty anyway so I thought
it would be okey.

I just compared the generated asm:
Accurate timestamp scaled to ns: 45 instructions (resolution actually 40 ns)
Approximate 40 ns resolution: 21 instructions
Approximate 40 us resolution: 9 instructions
For comparison one syscall path (gettimeofday()) is approx 400 instructions
and the add_timer_randomness() function that only uses jiffies is 76
instructions, so mayby I'm microoptimising here?
Is it worth the cycles to get 40 ns resolution instead of 40us ?

> > We want to be able to separate it from similar functions used
> > for high-res timers etc. which need a more accurate function.
>
> Bear in mind that most arches won't have this sort of difficulty so in
> the bigger picture, this might be overkill. Put a comment next to the
> generic function that says "might not be accurate" and when a user of
> the interface comes along that actually cares about accuracy, the
> situation can be reevaluated.

Perhaps, but if some (most) architectures has a cheap accurate
implementation
my bet is that those will be assumed to be accurate for all archs and
get used all over the place and then we're in trouble...;-)

/Johan


