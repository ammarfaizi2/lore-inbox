Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130496AbRCDMhR>; Sun, 4 Mar 2001 07:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130497AbRCDMhI>; Sun, 4 Mar 2001 07:37:08 -0500
Received: from smtp-rt-1.wanadoo.fr ([193.252.19.151]:26578 "EHLO
	anagyris.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S130496AbRCDMg5>; Sun, 4 Mar 2001 07:36:57 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Question about IRQ_PENDING/IRQ_REPLAY
Date: Sun, 4 Mar 2001 13:36:40 +0100
Message-Id: <19350127060824.22815@smtp.wanadoo.fr>
In-Reply-To: <Pine.LNX.4.10.10103030954060.17574-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10103030954060.17574-100000@penguin.transmeta.com>
X-Mailer: CTM PowerMail 3.0.6 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>In particular, if an edge-triggered interrupt comes in on an x86 IO-APIC
>while that interrupt is disabled, enabling the interrupt will have caused
>that irq to get dropped. And if it gets dropped, it will never ever happen
>again: the interrupt line is now active, and there will never be another
>edge again.

Ok, I see. We have a different issue with the old Apple IRQ controller that
can lose interrupts if they are active when re-enabled. We currently rely
on a hack to work aroud this that may re-send interrupts, but that involves
hacking into __sti() to check for lost interrupts, which is bad.

Basically, even a level interrupt, if active while re-enabled, will not be
sent by the pic to the CPU, and so further interrupts will be blocked too.
We have some code in enable_irq() that can detect this case, but re-triggering
the interrupt is not really simple and requires the __sti() hack for now. 

I beleive we may have a way to re-trigger the interrupt without having to
hack __sti() by using a fake timer interrupt. I'll look into this, but in
that case, the code can be mostly self-contained in enable_irq, we will
probably not need to play with IRQ_PENDING & IRQ_REPLAY flag at all.

>> I'd be glad if you could take the time to enlighten me about this as I'm
>> trying to make the PPC code as close as the i386, according to your
>> comment stating that it would be generic in 2.5, and I don't like having
>> code I don't fully understand ;)
>
>You likely don't have this problem at all. Most sane interrupt controllers
>are level-triggered, and won't show the problem. And others (like the
>i8259) will see a disabled->enabled transition as an edge if the interrupt
>is active (ie they have the edge-detection logic _after_ the disable
>logic), and again won't have this problem.

Well, Apple now uses OpenPICs, but all slightly older macs had a home-made
Apple controller that had the above issue :( In fact, it can happpen with
both and and level interrupts for us.

Regards,
Ben.
