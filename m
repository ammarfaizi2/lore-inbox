Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318949AbSH1UgK>; Wed, 28 Aug 2002 16:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318951AbSH1UgK>; Wed, 28 Aug 2002 16:36:10 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23048 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318949AbSH1UgJ>; Wed, 28 Aug 2002 16:36:09 -0400
Date: Wed, 28 Aug 2002 13:43:08 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dominik Brodowski <devel@brodo.de>
cc: <cpufreq@www.linux.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
In-Reply-To: <20020828221947.A816@brodo.de>
Message-ID: <Pine.LNX.4.33.0208281331020.8978-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 28 Aug 2002, Dominik Brodowski wrote:
>
> Do these CPUs need kernel support? E.g. do udelay() calls work as
> expected?

Crusoe CPU's do not.

But Intel CPU's _do_ need this, for example (since they change the TSC
frequency).

And Intel CPU's do _not_ want to have user mode telling them what to do 
several times a second - yet it's entirely reasonable to have a kernel 
timer function that estimates processor load at every timer tick, and 
reacts to that a few times a second.

Which is why such a CPU needs to be passed in a _policy_. Which is my 
whole argument.

Let's put it another way, because I've seen people at Transmeta scramble
when Microsoft thought it was a good idea to have the OS tell what
frequency the CPU should run at, and trust me, they got it wrong. From my
contacts at Intel, I can promise you that they got it wrong wrt Intel's
chips too, so this is not a Transmeta-only issue.

All I'm saying is that instead of a frequency, you should take more of a
"what is the goal of this" approach, and pass in _that_. Then, in user 
land, you might have a situation where you know that "the goal is to run 
at 300MHz, and nothing else". That may sometimes be the right goal, but 
quite often it isn't.

And THAT IS MY POINT. If you have a more policy-oriented interface,
everybody can work with it. If you have a strict "this frequency"  
approach, some people literally _cannot_ live with it, and will end up
throttling behind your back.

The goals may be:
 - "low power" vs "high performance"
	Obvious. "Aggressive power management" vs "Power management with 
	performance as the primary goal"

 - "strive for max 20% idle" 

	The kernel may slow down the clock if the timer tick shows lots of 
	idle time. Tell the rest of the system when you do so.

 - "RT latency - 300MHz minimum"
	The idle loop might drop the frequency, but not past a certain 
	point.

 - "run at exactly 500 MHz"

Notice how only the _last_ goal is expressible in the "frequency" space. 
Everything else needs at least one additional piece of information, ie the 
policy the kernel/CPU should take wrt the power management.

		Linus

