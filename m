Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318245AbSGXHRQ>; Wed, 24 Jul 2002 03:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318246AbSGXHRQ>; Wed, 24 Jul 2002 03:17:16 -0400
Received: from mx1.elte.hu ([157.181.1.137]:47752 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318245AbSGXHRP>;
	Wed, 24 Jul 2002 03:17:15 -0400
Date: Wed, 24 Jul 2002 09:19:15 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] big IRQ lock removal, 2.5.27-G0
In-Reply-To: <3D3DFC3B.677AFDD7@tv-sign.ru>
Message-ID: <Pine.LNX.4.44.0207240916220.2193-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Jul 2002, Oleg Nesterov wrote:

> > okay - i've fixed irq_exit() once more in -G4
> 
> found G5, your forgot to add preempt_disable() in irq_exit()
> 
>  #define irq_exit()
>  do {
> +               preempt_disable();
>                 preempt_count() -= IRQ_EXIT_OFFSET;
>                 if (!in_interrupt() && softirq_pending(smp_processor_id()))
> 
> Oleg.

nope, it's tricky, check out the define of IRQ_EXIT_OFFSET, it has the
plus 1 count added already.

using preempt_disable() has the problem of putting a barrier() between the
++ and the -IRQ_OFFSET, causing one more instruction to be generated.

but there was another (not too critical) bug here - irq_enter() needs to
have a barrier() after manipulating the preemption count, irq_exit() needs
to have a barrier() before. Fixed in my tree.

	Ingo

