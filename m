Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWDELW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWDELW3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 07:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWDELW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 07:22:28 -0400
Received: from www.osadl.org ([213.239.205.134]:24486 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751211AbWDELW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 07:22:28 -0400
Subject: Re: [PATCH 0/5] clocksource patches
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Roman Zippel <zippel@linux-m68k.org>
Cc: johnstul@us.ibm.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.64.0604041218250.32445@scrub.home>
References: <Pine.LNX.4.64.0604031431220.25825@scrub.home>
	 <1144126422.5344.418.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0604041218250.32445@scrub.home>
Content-Type: text/plain
Date: Wed, 05 Apr 2006 13:22:47 +0200
Message-Id: <1144236167.5344.581.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman,

> Thomas, I would really appreciate if you actually started to argue your 
> point instead of just disagreeing with me every time. I have no problem to 
> admit that I'm wrong, but it takes a bit more than you just saying it is 
> so.

I on my side would appreciate, if you would stop to take every line I
write as a personal offense.

> For example above you bascially only state that your clock event source 
> is superior and the correct way of doing this without any explanation why 
> (and the "No, thanks." doesn't exactly imply that you're even interested 
> in alternatives). 

The question arises, who is not interested in alternatives. You are well
aware about the efforts others made, but you don't even think about
working together with them. Do you really expect people to jump on your
train, when you entirely ignore their work and efforts and just propose
your own view of the world? 

I did nowhere say that I'm not interested in alternative solutions. You
interpret it into my words for whatever reason.

Your way to rip out a single statement of its context and making your
argument on that is simply annoying.

Thats the original quote:
> How should a combo solution allow to add special hardware, which
> provides only one of the services ? By using "something else
> internally" ? No, thanks.

It is entirely clear, that "No thanks" is related to "something else
internally".

Thats the point I made further up in my first reply. It was your
proposal to combine clock sources and clock events. This works nice
where both are in the same hardware device, but its not a compulsory
argument for a combined abstraction layer. You said that in case there
is one element missing (e.g. TSC has no clock event source) it should
internally use "something else".

That's excatly the point I'm referring to. Do you think that "Use
something else" is a real good and convincing technical argument? No,
such a statement is simply the evidence that your design is flawed.


I assume we agree that we want abstraction of clock soures (read time)
and clock event sources (periodic / next event interrupts).

Why are those seperate items ?

Looking at the various hardware implementations there are three types of
devices:

1. Read only devices (e.g. TSC)
2. Next interrupt only devices (e.g. various timer implementations on
SoC CPUs)
3. Devices which combine both functions

Building an abstraction layer which handles all device types requires
either 

- that e.g. a read only device needs to be combined with a next
interrupt device in some way. This introduces artifical combos of
functionality which can and should be handled completely seperate.

or 

- to handle all the corner cases where a device has to be handled which
only provides one of the functionalies. Also the selection of different
combinations of devices will introduce extra handling code.

Futhermore the functionalites of clock sources and clock event source
can be used completely independent. In case of a periodic event there is
no interaction with the clock source at all. The readout of the clock
source is independent of any kind of event.

So we have two functional domains, which provide a high level interface:

The clock source abstraction provides:
- gettimeofday()
- getmonotonic()
- settimeofday()
- clock skew adjustment functions()

The clock event source abstraction provides:
- setup periodic events()
- setup one shot events()
- associate services (function to call on an event) to a clock event
source

This is a clear seperation and there is no combined functionality.

The availability of devices which combine both functions is not changing
the clear functional seperation of clock sources and clock event sources
at all.

Programming one shot events might need information from the clock source
layer e.g. to calculate the delta to the next event, but it does not
need this information on a low level base. The information is read from
the high level interface. Moving this to the low level interfaces would
enforce particular combinations of clock sources and clock event sources
and remove the flexibility to use arbitrary combinations on a best fit
selection.

Back to your questions:

> Why? In order to program a clock event you have to be able to read the
> clock somehow. In many systems it's the same hardware.

Yes, it is the same hardware. It is not the same level of abstraction.

The next event is defined by a absolute time in human units (i.e.
nanoseconds). The delta to the next event is calculated by

	delta  = next_event - now

Then delta is converted to the time units of the underlying hardware
device.

You might argue, that you also can convert the next_event time to the
time units of the underlying hardware first and then caclulate the delta
for the next event interrupt hardware.

This is only true, when those devices are combined and it results in
different handling of the same problem for different combinations of
hardware or even restricts the possible combinations depending on the
implementation details. Thats why I said it violates the basic rule of
abstraction.

> Why and what "basic rule of abstraction"?

Whats abstraction ? The generic way to access a functional domain to
allow users of the functional domain to be hardware agnostic.

As I showed above there are two functional domains:
clock sources and clock event sources

The high level interfaces of the functional domains use an hardware
independent representation of time, i.e. human time units (nano
seconds). Any interaction between the functional domains also uses the
hardware independent representation. 

This is the basic guarantee, that such abstraction layers are flexible
and of general use. 

Interaction or interdependencies of functional domains are not a reason
to combine them into one "handle it all" domain.

	tglx


