Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275761AbRJBB52>; Mon, 1 Oct 2001 21:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275758AbRJBB5S>; Mon, 1 Oct 2001 21:57:18 -0400
Received: from shell.cyberus.ca ([209.195.95.7]:12724 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S275757AbRJBB5J>;
	Mon, 1 Oct 2001 21:57:09 -0400
Date: Mon, 1 Oct 2001 21:54:49 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: <linux-kernel@vger.kernel.org>, <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>, Ingo Molnar <mingo@elte.hu>,
        <netdev@oss.sgi.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <20011001210445.D15341@redhat.com>
Message-ID: <Pine.GSO.4.30.0110012127410.28105-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 1 Oct 2001, Benjamin LaHaise wrote:

> On Mon, Oct 01, 2001 at 08:41:20PM -0400, jamal wrote:
> >
> > >The new mechanizm:
> > >
> > >- the irq handling code has been extended to support 'soft mitigation',
> > >  ie. to mitigate the rate of hardware interrupts, without support from
> > >  the actual hardware. There is a reasonable default, but the value can
> > >  also be decreased/increased on a per-irq basis via
> > > /proc/irq/NR/max_rate.
> >
> > I am sorry, but this is bogus. There is no _reasonable value_. Reasonable
> > value is dependent on system load and has never been and never
> > will be measured by interupt rates. Even in non-work conserving schemes
>
> It is not dependant on system load, but rather on the performance of the
> CPU and the number of interrupt sources in the system.

i am not sure what you are getting at. CPU load is of course a function of
the CPU capacity. assuming that interupts are the only source of system
load is just bad engineering.

>
> > There is already a feedback system that is built into 2.4 that
> > measures system load by the rate at which the system processes the backlog
> > queue. Look at netif_rx return values. The only driver that utilizes this
> > is currently the tulip. Look at the tulip code.
> > This in conjuction with h/ware flow control should give you sustainable
> > system.
>
> Not quite.  You're still ignoring the effect of interrupts on the users'
> ability to execute instructions during their timeslice.
>

And how does /proc/irq/NR/max_rate solve this?
I have a feeling you are trying to say that varying /proc/irq/NR/max_rate
gives opportunity for user processes to execute;
note, although that is bad logic, you could also modify the high and low
watermarks for when we have congestion in the backlog queue
(This is already doable via /proc)

> > [Granted that mitigation is a hardware specific solution; the scheme we
> > presented at the kernel summit is the next level to this and will be
> > non-dependednt on h/ware.]
> >
> > >(note that in case of shared interrupts, another 'innocent' device might
> > >stay disabled for some short amount of time as well - but this is not an
> > >issue because this mitigation does not make that device inoperable, it
> > >just delays its interrupt by up to 10 msecs. Plus, modern systems have
> > >properly distributed interrupts.)
> >
> > This is a _really bad_ idea. not just because you are punishing other
> > devices.
>
> I'm afraid I have to disagree with you on this statement.  What I will
> agree with is that 10msec is too much.
>

It is unfair to add any latency to a device that didnt cause or
contributre to the havoc.


> > Lets take network devices as examples: we dont want to disable interupts;
> > we want to disable offending actions within the device. For example, it is
> > ok to disable/mitigate receive interupts because they are overloading the
> > system but not transmit completion because that will add to the overall
> > latency.
>
> Wrong.  Let me introduce you to my 486DX/33.  It has PCI.  I'm putting my
> gige card into the poor beast.  transmitting full out, it can receive a
> sufficiently high number of tx done interrupts that it has no CPU cycles left
> to run, say, gated in userspace.
>

I think you missed my point. i am saying there is more than one source of
interupt for that same IRQ number that you are indiscrimately shutting
down in a network device.
So, assuming that tx complete interupts do actually shut you down
(although i doubt that very much given the classical Donald Becker tx
descriptor prunning) pick another interupt source; lets say MII link
status; why do you want to kill that when it is not causing any noise but
is a source of good asynchronous information (that could be used for
example in HA systems)?

> Falling back to polled operation is a well known technique in realtime and
> reliable systems.  By limiting the interrupt rate to a known safe limit,
> the system will remain responsive to non-interrupt tasks even under heavy
> interrupt loads.  This is the point at which a thruput graph on a slow
> machine shows a complete breakdown in performance, which is always possible
> on a slow enough CPU with a high performance device that takes input from
> a remotely controlled user.  This is *required*, and is not optional, and
> there is no way that a system can avoid it without making every interrupt
> a task, but that's a mess nobody wants to see in Linux.
>

and what is this "known safe limit"? ;->
What we are providing is actually a scheme to exactly measure that "known
safe limit" you are refering to without depending on someone having to
tell you "here's a good number for that 8 way xeon"
If there is system capacity available  why the fsck is it not being used?

cheers,
jamal

