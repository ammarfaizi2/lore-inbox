Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131779AbRAaTQq>; Wed, 31 Jan 2001 14:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130881AbRAaTQg>; Wed, 31 Jan 2001 14:16:36 -0500
Received: from colorfullife.com ([216.156.138.34]:527 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131889AbRAaTQa>;
	Wed, 31 Jan 2001 14:16:30 -0500
Message-ID: <3A78645E.D336F44A@colorfullife.com>
Date: Wed, 31 Jan 2001 20:15:42 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: David Woodhouse <dwmw2@infradead.org>,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Kernel Janitor's TODO list
In-Reply-To: <E14O1Vp-0002mv-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > And one more point for the Janitor's list:
> > Get rid of superflous irqsave()/irqrestore()'s - in 90% of the cases
> > either spin_lock_irq() or spin_lock() is sufficient. That's both faster
> > and better readable.
> 
> Expect me to drop any submissions that do this. I'd rather take the two
> clock hit in most cases because the effect of spin_lock_irq() being used
> and people then changing which functions call each other and producing
> impossible to debug irq mishandling cases is unacceptable.
>

IMHO the main problem of spin_lock_irqsave is not the lost cpu cycles,
but readability:

void public_function()
{
	spin_lock_irqsave();
	if(rare_event)
		internal_function()
	spin_unlock_irqrestore();
}

static void internal_function()
{
	...
	spin_unlock_irq();
	kmalloc(GFP_KERNEL);
	spin_lock_irq();
}

IMHO functions that are not irq safe somewhere hidden in internal
functions should never use spin_lock_irqsave().
make_request() in 2.2 falls into that category, and the irqsave() was
removed.

Obviously spin_lock_irq() instead of spin_lock_irqsave() should only be
done if the implementation doesn't support disabled interrupts, not if
currently noone calls a function with disabled interrupts.

(make_request(), down(), smp_call_function()...)

> The original Linux network code did this with sti() not save/restore flags.
> I've been there before, I am not going to allow a rerun of that disaster for
> a few cycles

I hope that during 2.5 we can add debugging into spin_lock_irq():
BUG() if it's called with disabled interrupts.
It's not yet possible due to schedule() with disabled interrupts (I
tried it a few months ago)

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
