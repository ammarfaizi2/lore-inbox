Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276275AbRI1Tuj>; Fri, 28 Sep 2001 15:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276277AbRI1Tua>; Fri, 28 Sep 2001 15:50:30 -0400
Received: from chiara.elte.hu ([157.181.150.200]:50191 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S276275AbRI1TuW>;
	Fri, 28 Sep 2001 15:50:22 -0400
Date: Fri, 28 Sep 2001 21:48:15 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: <kuznet@ms2.inr.ac.ru>
Cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        <alan@lxorguk.ukuu.org.uk>, <bcrl@redhat.com>, <andrea@suse.de>
Subject: Re: [patch] softirq performance fixes, cleanups, 2.4.10.
In-Reply-To: <200109281923.XAA05208@ms2.inr.ac.ru>
Message-ID: <Pine.LNX.4.33.0109282125520.11136-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Sep 2001 kuznet@ms2.inr.ac.ru wrote:

> > this problem has not been solved. hardirqs have properties unlike to
> > softirqs that make it harder to overload them.
>
> What properties do you mean? I see the only property, they are "hard",
> and hence they should be harder to tame. :-) :-)

(they can be disabled at their source more easily. softirqs keep getting
new work queued via hardirqs, so it's harder to 'tame' them other than
dropping them or delaying them - both of which can cause additional
problems.)

> [ No matter. It is out of topic, but it were you who said about this.
>   Did you ever hear about "interrupt mitigation", "hw flowcontrol",
>   "polling" eventually? All the schemes work.
> ]

(sure it works. but Linux boxes still effectively locks up if bombarded
with UDP packets - ie. the problem has not been solved. But this is a
different topic - i think i understand that you meant 'has been solved',
as 'solved theoretically'. What i meant is that it's implemented in Linux,
for a number of cases, yet, and that Linux provides no automatic guarantee
against such overloads. I think we both agree and i was just too short and
to inaccurate in specifying what i meant to say. Issue closed?)

> > they are *not*. The old code deliberately ignores newly pending softirqs.
>
> I tell you that net_rx_action() already LOOPs so much that it is silly
> to loop even more. You multiplied an infinity with 10 and dare to
> state that this infinity became larger. I am sorry, it is not.

no matter how much rx_action is looping, if it's tx work that is queueing
up meanwhile and if we ignore that tx work after having finished rx
processing. How many times do i have to loop over this simple packet of a
fact to receive an ACK? :-)

> > net_rx_action is 'small' in code, but not small in terms of cachemisses
> > and other, unavoidable overhead. It goes over device-side skbs which can
> > and will take several microseconds per packet.
>
> Big news for me. :-) And how is it related to the issue?

it's very much related because it opens up a real window for other
softirqs to be re-activated. which is the basic situation my patch solves.

> > the fundamental issue here that makes looping inevitable is the following
> > one. (not that looping itself is anything bad.) We enable hardirqs during
> > the processing of softirqs. We also guarantee exclusivity of softirq
> > processing. We also have multiple 'queues of work'. Ie. if a hardirq adds
> > some new work while we were off doing other work, then we have no choice
> > but look at this other work as well.  Ie. we have to loop. q.e.d.
>
> If irq adds new work it is processed immedately without any new hacks.
> Look into net_rx_action().

it's not processed if we are on our way out eg. processing the LO softirq.
Or tx work does not get processed if we are in rx processing.

> >  - do not use split softirqs, use one global (but per-cpu) 'work to be
> >    done' queue, that lists multiple things. The downside: no 'priority'
> >    between softirqs.
> >
> > (sidenote: i do think that priority of softirqs is overdesign
>
> Where did you find priority there? [...]

i found no functional concept of priority there. But i had to react to the
following, largely bogus claim by Andrea:

----------->
> What you are missing is a property provided by the old method.
>
> We have the NET_RX_SOFTIRQ that floods very heavily, so far so good.
>
> Then we have HI_SOFTIRQ, incidentally HI_SOFTIRQ from irq wants to be
> executed with very low latency, with your patch it _can_ be postpone to
> ksoftirqd processing just because there's the NET_RX_SOFTIRQ cpu hog in
> background. With the old method it was guaranteed that the HI_SOFTIRQ
> was executed with very low latency within the irq, no matter of the
> NET_RX_SOFTIRQ flood.
<-----------

i was wrong to attribute this claim to you - sorry! I have hard time
multitasking between your and Andrea's arguments, so sometimes work
request and completion interrupt gets mixed up :-)


> As soon as you see something is enumerated, it still does not mean
> that low numbers have some priority.

yep.


> OK, now I understand your point. You mean that net_rx_action() is not
> started immediately, when irq arrives while net_tx_action() or a timer
> or something is running. Yes, it is really bad.

good :)

	Ingo

