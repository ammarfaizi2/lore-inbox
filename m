Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315388AbSIHV44>; Sun, 8 Sep 2002 17:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315413AbSIHV4z>; Sun, 8 Sep 2002 17:56:55 -0400
Received: from [63.209.4.196] ([63.209.4.196]:518 "EHLO neon-gw.transmeta.com")
	by vger.kernel.org with ESMTP id <S315388AbSIHV4y>;
	Sun, 8 Sep 2002 17:56:54 -0400
Date: Sun, 8 Sep 2002 15:01:02 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Zwane Mwaikambo <zwane@mwaikambo.name>
cc: Ingo Molnar <mingo@elte.hu>, Robert Love <rml@tech9.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] per isr in_progress markers
In-Reply-To: <Pine.LNX.4.44.0209081700460.1096-100000@linux-box.realnet.co.sz>
Message-ID: <Pine.LNX.4.44.0209081453010.1293-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 8 Sep 2002, Zwane Mwaikambo wrote:
>
> Here is a newer (untested) patch incorporating Ingo's suggestions as well 
> as adding an extra request_irq flag so that isrs can use isr_unmask_irq() 
> to enable their interrupt lines.

Hmm.. I really don't get the point of what this is supposed to actually 
help.

Clearly, if the device doesn't share the irq line, this doesn't matter. 
Similarly, it shouldn't matter if there is just one device that is active 
(ie irq line sharing with some slow device where the interrupt happens 
fairly seldom).

As far as I can tell, the only time when this might be an advantage is an 
SMP machine with multiple devices sharing an extremely busy irq line. Then 
the per-isr in-progress bit allows multiple CPU's to actively handle 
several of the devices at the same time.

Or is there some other case where this is helpful?

The reason I don't much like this is:

 - bigger SMP machines don't tend to share all that many interrupts
   anyway, since they all use IO-APICs and tend to have fairly sparse irq
   setups (as opposed to most laptops, which often seem to put every PCI
   device on the same irq)

 - if both devices really _are_ that actively pushing a lot of interrupts, 
   it sounds like you actually want to keep the caches hot on one CPU
   instead of randomly taking the irq on various CPU's. Have you actually 
   got performance numbers to show otherwise? That irq lock is going to 
   bounce back and forth a _lot_, quite possibly undoing any advantage of 
   the patch.

 - on all the cases where this _doesn't_ help, it just potentially makes 
   the stack depth even deeper.

So I'd really like to understand what the upsides are..

		Linus

