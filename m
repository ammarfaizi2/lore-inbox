Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276249AbRI1TX5>; Fri, 28 Sep 2001 15:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276252AbRI1TXr>; Fri, 28 Sep 2001 15:23:47 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:26635 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S276249AbRI1TXl>;
	Fri, 28 Sep 2001 15:23:41 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200109281923.XAA05208@ms2.inr.ac.ru>
Subject: Re: [patch] softirq performance fixes, cleanups, 2.4.10.
To: mingo@elte.hu
Date: Fri, 28 Sep 2001 23:23:49 +0400 (MSK DST)
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk, bcrl@redhat.com, andrea@suse.de
In-Reply-To: <Pine.LNX.4.33.0109281956200.9978-100000@localhost.localdomain> from "Ingo Molnar" at Sep 28, 1 08:28:59 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> this problem has not been solved. hardirqs have properties unlike to
> softirqs that make it harder to overload them.

What properties do you mean? I see the only property, they are "hard",
and hence they should be harder to tame. :-) :-)

[ No matter. It is out of topic, but it were you who said about this.
  Did you ever hear about "interrupt mitigation", "hw flowcontrol",
  "polling" eventually? All the schemes work.
]


> they are *not*. The old code deliberately ignores newly pending softirqs.

I tell you that net_rx_action() already LOOPs so much that it is silly
to loop even more. You multiplied an infinity with 10 and dare to state
that this infinity became larger. I am sorry, it is not.


> net_rx_action is 'small' in code, but not small in terms of cachemisses
> and other, unavoidable overhead. It goes over device-side skbs which can
> and will take several microseconds per packet.

Big news for me. :-) And how is it related to the issue?



> > If this logic is wrong, you should explain why it is wrong. Looping
> > dozen of times may look like cure, but for me it still looks rather
> > like steroids.
> 
> the fundamental issue here that makes looping inevitable is the following
> one. (not that looping itself is anything bad.) We enable hardirqs during
> the processing of softirqs. We also guarantee exclusivity of softirq
> processing. We also have multiple 'queues of work'. Ie. if a hardirq adds
> some new work while we were off doing other work, then we have no choice
> but look at this other work as well.  Ie. we have to loop. q.e.d.

If irq adds new work it is processed immedately without any new hacks.
Look into net_rx_action(). 


>  - do not use split softirqs, use one global (but per-cpu) 'work to be
>    done' queue, that lists multiple things. The downside: no 'priority'
>    between softirqs.
> 
> (sidenote: i do think that priority of softirqs is overdesign

Where did you find priority there? As soon as you see something is enumerated,
it still does not mean that low numbers have some priority.

Argh... I see, what you mean. It is not priority, it is bug introduced
in 2.4.7. (By you? :-)) It was not present before, all the softirq
were processed each round.

Well, just restore old net_rx_action() from 2.4.6.

OK, now I understand your point. You mean that net_rx_action()
is not started immediately, when irq arrives while net_tx_action()
or a timer or something is running. Yes, it is really bad.

But it still does not allow you to restart net_rx_action() 10 times in row.


> unless you have strong arguments against this approach, i will start
> coding this.

I am sorry, I do not find anything new in this approach.
Seems, all that you propose is to replace single bit in single word
to some struct. It will take sense when we have more than one real
softirq. :-)


> queued. This has to be embedded into skbs and bh-handling structs. What do
> you think?

I think that you should change subject to discuss this. :-)

It is not related to the problem.

Alexey
