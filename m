Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136169AbRA1Rl3>; Sun, 28 Jan 2001 12:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136222AbRA1RlT>; Sun, 28 Jan 2001 12:41:19 -0500
Received: from colorfullife.com ([216.156.138.34]:62986 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S136169AbRA1RlC>;
	Sun, 28 Jan 2001 12:41:02 -0500
Message-ID: <3A7459AA.84CDCF7B@colorfullife.com>
Date: Sun, 28 Jan 2001 18:40:58 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Kernel Janitor's TODO list
In-Reply-To: <Pine.LNX.4.30.0101281653020.26076-100000@imladris.demon.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> 
> TIOCMIWAIT does restore_flags() before interruptible_sleep_on(). It's
> broken too.
>
Yes, and I found a second bug: it doesn't sti() immediately after
interruptible_sleep_on(), thus cli() doesn't reacquire the global irq
lock --> the atomic copy won't be atomic on SMP.


And one more point for the Janitor's list:
Get rid of superflous irqsave()/irqrestore()'s - in 90% of the cases
either spin_lock_irq() or spin_lock() is sufficient. That's both faster
and better readable.

spin_lock_irq(): you know that the function is called with enabled
interrupts.
spin_lock(): can be used in hardware interrupt handlers when only one
hardware interrupt uses that spinlocks (most hardware drivers), or when
all hardware interrupt handler set the SA_INTERRUPT flag (e.g. rtc and
timer interrupt)

There is one more rule when you can use spin_lock_irq():
if you know that the function might sleep. E.g. compare make_request
from 2.2.18 and __make_request() from 2.4.
Since __get_request_wait() can sleep, the callers of make_request()
cannot rely on disabled interrupts, thus spin_lock_irq instead of
spin_lock_irqsave().

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
