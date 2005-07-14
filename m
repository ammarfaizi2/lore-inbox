Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261768AbVGNXSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbVGNXSM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 19:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVGNXSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 19:18:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63424 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262741AbVGNXPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 19:15:41 -0400
Date: Thu, 14 Jul 2005 16:13:57 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Vojtech Pavlik <vojtech@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       Lee Revell <rlrevell@joe-job.com>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mbligh@mbligh.org, diegocg@gmail.com, azarah@nosferatu.za.org,
       christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
In-Reply-To: <1121380637.3747.10.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0507141600540.19183@g5.osdl.org>
References: <d120d50005071312322b5d4bff@mail.gmail.com>  <1121286258.4435.98.camel@mindpipe>
 <20050713134857.354e697c.akpm@osdl.org>  <20050713211650.GA12127@taniwha.stupidest.org>
  <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org> 
 <20050714005106.GA16085@taniwha.stupidest.org> 
 <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org> 
 <1121304825.4435.126.camel@mindpipe>  <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org>
  <1121326938.3967.12.camel@laptopd505.fenrus.org>  <20050714121340.GA1072@ucw.cz>
  <Pine.LNX.4.58.0507140933150.19183@g5.osdl.org> <1121380637.3747.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Jul 2005, Alan Cox wrote:
>
> > just doesn't realize that the latter is a bit more complicated exactly 
> > because the latter is a hell of a lot more POWERFUL. Trying to get rid of 
> > jiffies for some religious reason is _stupid_.
> 
> Getting rid of jiffies in its current form is a huge win for very
> non-religious reasons. Jiffies is expensive in power management and
> virtualisation because you have to maintain it.

No, you're now confusing "interrupts" with "jiffies".

There is no conceptual 1:1 thing between those two.

It so happens that traditionally we've kept them 1:1, but there's nothing 
that says that we can't slow down the interrupt source and just increment 
jiffies by a factor of the slowdown when the interrupt _does_ happen.

But no, that does NOT mean that "jiffies" should just count nanoseconds, 
and the problem would be solved. The fact is, most users of jiffies only 
care about the low 32 bits on 32-bit architectures, and that's fine as 
long as jiffies are in the millisecond range, since it still leaves a 
useful timeout value for almost everything (and then only long-range stuff 
needs to use "u64" for their timeouts).

In other words, we want a clock that is _known_ to not be very accurate,
but that is easy to just read from a memory location, and that has some
relationship to a timer tick in the sense that it should be at least in
the order-of-magnitude range for what a timer tick can cause.

Anybody who asks for nanoseconds is confused. That just forces you to use 
a 64-bit value, where no such value is needed. Things like TCP 
retransmission timeouts would be totally _idiotic_ to be made in 
nanoseconds: it would just make the socket data structures larger, and it 
has zero relevance, since the actual timer tick doesn't have that kind of 
resolution _anyway_.

The current "jiffies" actually fits all of these problems _wonderfully_
well. Yes, it needs to be converted from "struct timeval" and friends, but
it needs to be converted exactly _because_ of the good properties it has,
namely that it fits in a word, and is _relevant_ to what a timer interrupt
ends up being.

Look at 99% of the use of jiffies: it uses _jiffies_. It doesn't use
"jiffies_64", even though that's actually what gets updated. And it does
that _exactly_ because almost _nobody_ cares to pay the price of 64 bit
issues (both structure memory usage, and atomicity costs on 32-bit
architectures).

And I claim that you _cannot_ do better.

But what you can do is to have HZ at some reasonably high value (ie in the 
kHz range), and then slow down the system clock to conserve energy, and 
increment jiffies by 16 or 32 when in "slow clock mode". And then, when 
there is a multimedia app or somethign that asks for high-precision 
timers, you speed the interrupts up again, and you increment jiffies by 1.

It's that simple. And it really _is_ simple. 

And guys, the fact is, jiffies works _today_. Making this change won't 
break anything, and won't introduce any new concepts, and won't break any 
existing drivers. In contrast, introducing _yet_ another timekeeping 
mechanism is not only going to be objectively _worse_ than jiffies from a 
technical standpoint, it's going to be a total disaster from a transition 
standpoint too. 

		Linus
