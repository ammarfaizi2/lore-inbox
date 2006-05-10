Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751476AbWEJPdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbWEJPdq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 11:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWEJPdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 11:33:46 -0400
Received: from 216-54-166-5.gen.twtelecom.net ([216.54.166.5]:34964 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S1751476AbWEJPdp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 11:33:45 -0400
Message-ID: <446207D6.2030602@compro.net>
Date: Wed, 10 May 2006 11:33:42 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: rt20 patch question
References: <446089CF.3050809@compro.net> <1147185483.21536.13.camel@c-67-180-134-207.hsd1.ca.comcast.net> <4460ADF8.4040301@compro.net> <Pine.LNX.4.58.0605100827500.3282@gandalf.stny.rr.com> <4461E53B.7050905@compro.net> <Pine.LNX.4.58.0605100938100.4503@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0605100938100.4503@gandalf.stny.rr.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Wed, 10 May 2006, Mark Hounschell wrote:
> 
>> Steven Rostedt wrote:
>>> (It is expected on LKML to not touch the CC list, and especially keep the
>>> one you are replying to)
>>>
>> Ok. I'm on so many it's hard to remember what each want.
> 
> :) I've read that in other lists it's impolite to CC others.  I still do
> it :}  I find that, espically if I'm on lots of lists, if I'm on a thread,
> I prefer to be emailed directly, that way I know about a topic that I
> might need to quickly respond to.  I never pay attention to policies
> abount stripping CC lists, because I don't ever want to be stripped from a
> thread I'm interested in.  The LKML has 300 to 700 emails a day, so you
> really do need to CC those, otherwise you'll be lost in the noise.
> 
> 
> [snip]
> 
>> Thank you. That is exactly what I wanted to know. I ask because when I
>> run my app in complete preemption mode I have random periods where the
>> machine stops for many seconds at a time. Only in complete preemption
>> mode does this happen. In Voluntary and Preempt modes this does not
>> occure. I'm having a hard time trying to determine if the problem is in
>> my application.
>>
> 
> OK, now you got my attention.  What do you mean by your machine stops?
> 
> Are you playing with priorities?  You might want to turn on latency
> tracing, although it could be a PI leak.  But I really need to know more,
> since I'm suspecting that your app isn't written properly to work with a
> true RT environment.
> 
> RT means that you can easily freeze the machine if you have a high prio
> task that runs more than you expect it to.  With this power comes great
> responsibility, as well as understanding.
> 
> Is this SMP or UP?
> 
> Could you explain you app a little and what tasks are RT?
> 
> Thanks,
> 
> -- Steve
> 
> 

Ok, I'll try to explain the application. It is an emulation of some old
legacy hardware (SEL-32) that ran a proprietary RTOS (MPX-32). We
emulate the hardware not the software. We have some specialized pci
cards that emulate some of that hardware. IE, a card that has some
timers and external interrupt capabilities (RTOM). All our drivers are
GPL BTW.

This app can only run in an SMP environment BTW. And the more power the
better.

Anyway the legacy CPU is the main thread/process and each legacy I/O
device, whether virtual or real, is emulated or driven by one or more
other threads. The most important part of this as far as Real-Time is
concerned is the determinism/latancy in the deliverance of interrupts
(external or timer) to the main CPU thread from the RTOM card.
Determinism of I/O operations is also important however. We achive the
best results by using both process and irq affinity.

The CPU thread/process and the irq of the RTOM pci card are bound to a
single processor and all other 'user' processes and irqs are forced off
that processor onto the other processor. The apps I/O threads are bound
to that other processor also.

The CPU process does not relinquish his processor. He is in a loop
fetching and executing legacy machine language instructions and only
comes out of that loop upon receiving an interrupt from the RTOM card or
some I/O completion event from one of the I/O threads. You know, kind of
like a real CPU would do.

The CPU process/thread in the past ran at FIFO prio 99 and the I/O
threads at lower FIFO or RR priorities. With rt20 all our priorities are
now set below the range used for hardirqs.

All this has worked well in the past as long as we control what else is
run on the system. We want to be able to use the machine for other
things and still have some reasonable determinism in the application. So
we are looking the the rt patch. We have some other tools that give us
an fairly good indication as to the determinism of any given box and can
see the rt patch in complete preempt mode does in fact make a difference.

So to my problem. What I mean by "the machine stops" is just that all
indications of the mouse, keyboard, and vidio stop. Then in a few
seconds will usually continue. At first I only saw problems when using
ethernet in the emulation. I would telnet into the emulation from the
linux box and do the equivalent of cat'ing a very large file. The
machine will always "stop" somewhere randomly along the display. Then
maybe continue on or maybe not. So I thought I might have a problem with
my ethernet module. Then I noticed similar things with the SCSI module
when accessing legacy scsi devices from within the emulation. Somtimes
the whole machine doesn't stop. It would appear that only somethings
have stopped. Like one or more of my I/O threads??

I can only say for sure that I do not have these "stops" when running
any other kernel or when running the rt20 kernel in any of the
non-complete preemption modes.

The only change that had to be made to this app for it to run at all on
the rt20 kernel was insuring that the RTOM irq thread was at a higher
priority than the CPU process/thread. Otherwise no signals were received
from the RTOM.

Mark
