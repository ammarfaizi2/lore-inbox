Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276543AbRI2Qgw>; Sat, 29 Sep 2001 12:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276544AbRI2Qge>; Sat, 29 Sep 2001 12:36:34 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:15632 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S276543AbRI2QgV>;
	Sat, 29 Sep 2001 12:36:21 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200109291635.UAA17377@ms2.inr.ac.ru>
Subject: Re: [patch] softirq performance fixes, cleanups, 2.4.10.
To: mingo@elte.hu
Date: Sat, 29 Sep 2001 20:35:03 +0400 (MSK DST)
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk, bcrl@redhat.com, andrea@suse.de
In-Reply-To: <Pine.LNX.4.33.0109282125520.11136-100000@localhost.localdomain> from "Ingo Molnar" at Sep 28, 1 09:48:15 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

[ Well, Ingo, you may go directly to the end of the mail, snipping
  historical comments. :-) ]

> (sure it works. but Linux boxes still effectively locks up if bombarded
> with UDP packets - ie. the problem has not been solved.
...
> different topic - i think i understand that you meant 'has been solved',
> as 'solved theoretically'.

For me it is solved in practice. I cannot cause hardirq lockup
either with tulip or with acenic. If you mean eepro100, you may fix it,
implementing f.e. hw flowcontrol, which should be easy with any hardware.

BTW I cannot cause softirq lockup with current kernels as well.


> to inaccurate in specifying what i meant to say. Issue closed?)

Yes. I do not know why you started to talk about this. "I do this nasty,
because other nasty exists" is never good argument. Though I also use
it sometimes. :-)


> i found no functional concept of priority there. But i had to react to the
> following, largely bogus claim by Andrea:

Andrea speaks not about priority in fact. He speaks rather about fairness.
Essentially, talking in your terms we have a small amount of events,
encoded in bits of mask and instead of queueing them in strict order, we
used to process all of them each round. In fact, it is equivalent to fifo
with small reordering (as soon as amount of events is small).

:-) Two letter "HI" was my invention, and I bet I did not mean
that it is high priority. Actually, it is just random name.
It is diffucult to say why I selected this name: combined from
"higher than BH", sparc assembly, which I had to hack that time,
and... yes, _that_ time it was important that it is processed
before NET_*, because timers and BH_IMMEDIATE produce net softirq.
It is not important more.

> good :)

Listen, let us try to make this right yet.

Essentially, if we invent some real condition when softirq loop must be
stopped, we win. Now it is "stop after all events pending at start are
processed". OK, it is wrong. You propose: "10 rounds". It is even worse
because it is against plain logic. (pardon :-)).

If we invent right condition, we may improve things really significantly
almost without changes to the rest. (F.e. killing of internal restart
in net_rx_action() would be great win, it is in one row with your
event queue, by the way. Ideal scheme must not fail even if
each net_rx_action() processes single packet, leaving the rest queued.
Each skb is an event. :-))

I am sure, taming is very easy, if to strain brains a bit.
Essentially, your 10 must be replaced with some simple time characteristics
Seems, it is possible to do this correctly, f.e. using small deadline
scheduler with two participants: softirq and all the rest.
Policy sort of: softirq may execute for 1/HZ, if they insist on this,
but if they force to starve some processes, they lose low latency guarantee,
but get latency _not_ worse than 10msec and do not eat more than
some share (half) of cpu in this case. At least for UP I know
how to do this exactly forming trivial deadline scheduler
with two participants: run_queue and softirq pending.
With SMP this can be the same... only run_queue is shared and dumb extension
has bad effects, sort of throttling softirq on cpu0,
when process is scheduled really on cpu0. No doubts, it should be easy.

Alexey
