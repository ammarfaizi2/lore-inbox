Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276147AbRI1QLw>; Fri, 28 Sep 2001 12:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276150AbRI1QLn>; Fri, 28 Sep 2001 12:11:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37138 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S276147AbRI1QLb>; Fri, 28 Sep 2001 12:11:31 -0400
Date: Fri, 28 Sep 2001 09:11:35 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Padraig Brady <padraig@antefacto.com>, <linux-kernel@vger.kernel.org>
Subject: Re: CPU frequency shifting "problems"
In-Reply-To: <20010928095509.A11996@kushida.degree2.com>
Message-ID: <Pine.LNX.4.33.0109280902250.1682-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Sep 2001, Jamie Lokier wrote:
>
> On a Transmeta chip, does the TSC clock advance _exactly_ uniformly, or
> is there a cumulative error due to speed changes?
>
> I'll clarify.  I imagine that the internal clocks are driven by PLLs,
> DLLs or something similar.  Unless multiple oscillators are used, this
> means that speed switching is gradual, over several hundred or many more
> clock cycles.

Basically, there's the "slow" timer, and the fast one. The slow one always
runs, and fast one gives the precision but runs at CPU speed.

So yes, there are multiple oscillators, and no, they should not drift on
frequency shifting, because the slow and constant one is used to scale the
fast one. So no cumulative errors.

HOWEVER, anybody who believes that TSC is a "truly accurate clock" will be
sadly mistaken on any machine. Even PLL's drift over time, and as
mentioned, Intel already broke the "you can use TSC as wall time" in their
SpeedStep implementation. Who knows what their future CPU's will do..

> I can now use `rdtsc' to measure time in userspace, rather more
> accurately than gettimeofday(). (In fact I have worked with programs
> that do this, for network traffic injection.).  I can do this over a
> period of minutes, expecting the clock to match "wall clock" time
> reasonably accurately.

It will work on Crusoe.

> (One hardware implementation that doesn't have this problem is to run a
> small counter, say 3 or 4 bits, at the nominal clock speed all the time,
> and have the slower core sample that.  But it may use a little more
> power, and your note about FP scaling tells me you don't do that).

We do that, but the other way around. The thing is, the "nominal clock
speed" doesn't even _exist_ when running normally.

What does exist is the bus clock (well, a multiple of it, but you get the
idea), and that one is stable. I bet PCI devices don't like to be randomly
driven at frequencies "somewhere between 12 and 33MHz" depending on load ;)

But because the stable frequency is the _slow_ one, you can't just scale
that up (well, you could - you could just run your cycle counter at 66MHz
all the time, and you couldn't measure smaller intervals, and people would
be really disappointed). So you need the scaling of the fast one..

		Linus

