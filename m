Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317772AbSIJUt0>; Tue, 10 Sep 2002 16:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318113AbSIJUt0>; Tue, 10 Sep 2002 16:49:26 -0400
Received: from mail.libertysurf.net ([213.36.80.91]:7456 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S317772AbSIJUtZ> convert rfc822-to-8bit; Tue, 10 Sep 2002 16:49:25 -0400
Date: Wed, 11 Sep 2002 00:37:55 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: groudier@localhost.my.domain
To: Ingo Molnar <mingo@elte.hu>
cc: Zwane Mwaikambo <zwane@mwaikambo.name>,
       Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] per isr in_progress markers
In-Reply-To: <Pine.LNX.4.44.0209092122030.4648-100000@localhost.localdomain>
Message-ID: <20020911000220.F4042-100000@localhost.my.domain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 9 Sep 2002, Ingo Molnar wrote:

>
> On Mon, 9 Sep 2002, Zwane Mwaikambo wrote:
>
> > As an aside, i just had an idea for another way to improve interrupt
> > handling latency. Instead of walking through all the isrs in the chain,
> > we can have an isr flag wether it was the source of the irq, and if so
> > we stop right there and not walk through the other isrs. Obviously
> > taking into account that some devices are dumb and have no real way of
> > determining.
>
> this is something i have a 0.5 MB patch for that touches a few hundred
> drivers. I can dust it off if there's demand - it will break almost
> nothing because i've done the hard work of adding the default 'no work was
> done' bit to every driver's IRQ handler.

Level-triggerred (aka level-sensitive) interrupt is a condition. No matter
which device raises the condition first when, in fact, more than one
device did so. IMO, the heuristics that try to associate a CPU interrupt
to a single device source are broken when level triggerred is the concern,
for the simple reason they just rely on false assumptions. (The same
way, 'no work was done' for a device does not means that it is 100% sure
IRQ wasn't triggerred by this device).

Prior to improve something, we should want to estimate if there is really
room for improvement. For example, does Linux have to handle far more
interrupts than really needed ? The 'no work was done' you suggest can
help maintaining such stats and see if the kernel is good or bad in this
area. When applied in a per device manner, it might be accurate on low IRQ
load, but may significantly lie in high IRQ load situation, IMO.

Only having driver isr's returning some 'no work was done' is not enough
to optimize interrupts, in my opinion. What we want to know is if we got
too many interrupts or not. We need more information for this. For
example, drivers could also tell the kernel about the number of real
completions or some number of interrupts that can be considered useful.
For example, if a driver expects 1 interrupt per IOs, it might export to
the kernel the number of completed IOs ...

  Gérard.

