Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135882AbRAMAQ2>; Fri, 12 Jan 2001 19:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135880AbRAMAQT>; Fri, 12 Jan 2001 19:16:19 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:26895 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135850AbRAMAQJ>; Fri, 12 Jan 2001 19:16:09 -0500
Date: Fri, 12 Jan 2001 16:15:37 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Frank de Lange <frank@unternet.org>
cc: Ingo Molnar <mingo@elte.hu>, Manfred Spraul <manfred@colorfullife.com>,
        dwmw2@infradead.org, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardwarerelated?
In-Reply-To: <20010112214642.A27809@unternet.org>
Message-ID: <Pine.LNX.4.10.10101121610050.8097-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Jan 2001, Frank de Lange wrote:
> 
> Gentleman, this (the patch to 8390.c) seems to fix the problem.

The problem with this patch is that anybody with a slow ISA ne2000 clone
will basically have absolutely _horrible_ interrupt latency because we
hold the irq lock over some quite expensive operations.

The spin_lock_irqsave() is absolutely my preferred fix, and if I remember
correctly this is in fact how some early 2.1.x code fixed the ne2000
driver when the original irq scalability stuff happened (for some time
during development we did not have a working "disable_irq()" AT ALL
because the irq-disabling counters etc logic hadn't been done).

The spinlock was changed to "disable_irq()" by a patch from Alan, if I
remember correctly, exactly because people couldn't access serial lines at
any kind of high speeds otherwise - even on "reasonable" hardware.

Alan may remember details better. The fact is that as a general design
principle we should _not_ be using "disable_irq/enable_irq" anyway. BUT
that there are some real-world concerns that make the "better" spinlock
handling have some problems too.

So yes, I bet the spinlock fixes it. But..

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
