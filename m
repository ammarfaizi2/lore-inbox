Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277483AbRJEQme>; Fri, 5 Oct 2001 12:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277488AbRJEQmO>; Fri, 5 Oct 2001 12:42:14 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:31753 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S277483AbRJEQmF>;
	Fri, 5 Oct 2001 12:42:05 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200110051642.UAA21823@ms2.inr.ac.ru>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
To: mingo@elte.hu
Date: Fri, 5 Oct 2001 20:42:12 +0400 (MSK DST)
Cc: hadi@cyberus.ca, linux-kernel@vger.kernel.org, Robert.Olsson@data.slu.se,
        bcrl@redhat.com, netdev@oss.sgi.com, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk
In-Reply-To: <Pine.LNX.4.33.0110040831020.1727-100000@localhost.localdomain> from "Ingo Molnar" at Oct 4, 1 08:35:02 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> i'm asking the following thing. dev->quota, as i read the patch now, can
> cause extra calls to ->poll() even though the RX ring of that particular
> device is empty and the driver has indicated it's done processing RX
> packets. (i'm now assuming that the extra-polling-for-a-jiffy line in the
> current patch is removed - that one is a showstopper to begin with.) Is
> this claim of mine correct?

No.

If ring is empty, device is removed from poll list and dev->poll is not called
more.

dev->quota is to preempt service when ring does not want to clear.
In this case work remains for the next round after all the rest
of interfaces are served. Well, it is to allow to give user control
on distribution cpu time between interfaces, when cpu is 100% utilized
and we have to drop something. Devices with lower weights will get
less service.


> packets. (i'm now assuming that the extra-polling-for-a-jiffy line in the

It is not so bogus with current kernel with working ksoftirqd.

The goal was to check what happens really when we enforce polling
even when machine is generally happy. For me it is not evident apriori:
more cpu is eaten uselessly or less due to absent irqs.
Note, that on dedicated router it is pretty normal to spin in context
of ksoftirqd switching to control tasks when it is required.
And, actually, it is amazing feature of the scheme, that it is so easy
to add such option.

Anyway, to all that I remember, the question remained unanswered. :-)
Robert even observed that only 9% of cpu is eaten, which is surely
cannot be true. :-)

Alexey
