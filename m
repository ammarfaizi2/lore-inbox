Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288060AbSANH6Z>; Mon, 14 Jan 2002 02:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288090AbSANH6Q>; Mon, 14 Jan 2002 02:58:16 -0500
Received: from mx2.elte.hu ([157.181.151.9]:6027 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288060AbSANH6N>;
	Mon, 14 Jan 2002 02:58:13 -0500
Date: Mon, 14 Jan 2002 10:55:37 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Jeff Dike <jdike@karaya.com>, Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: The O(1) scheduler breaks UML
In-Reply-To: <Pine.LNX.4.40.0201131853550.937-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33.0201141043320.2248-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 13 Jan 2002, Davide Libenzi wrote:

> > So, is it possible to enable IRQs across the call to _switch_to?
>
> Yes, this should work :
>
>     if (likely(prev != next)) {
>         rq->nr_switches++;
>         rq->curr = next;
>         next->cpu = prev->cpu;
>         spin_unlock_irq(&rq->lock);
>         context_switch(prev, next);
>     } else
>         spin_unlock_irq(&rq->lock);

this change is incredibly broken on SMP - eg. what protects 'prev' from
being executed on another CPU prematurely. It's even broken on UP:
interrupt context that changes current->need_resched needs to be aware of
nonatomic context switches. See my previous mail.

> and there's no need for barrier() and rq reload in this way.

we can remove the barrier(), but for a different reason: the asm volatile
definition of the switch_to macro is a compilation barrier in itself
already. I've removed the barrier() from my tree, the change will be in
the -H8 patch. The rq = this_rq() reload is still necessery.

	Ingo

