Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274243AbRJBOZz>; Tue, 2 Oct 2001 10:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275044AbRJBOZp>; Tue, 2 Oct 2001 10:25:45 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32519 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274243AbRJBOZd>; Tue, 2 Oct 2001 10:25:33 -0400
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
To: greearb@candelatech.com (Ben Greear)
Date: Tue, 2 Oct 2001 15:30:19 +0100 (BST)
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <3BB8F346.B7B9CD96@candelatech.com> from "Ben Greear" at Oct 01, 2001 03:50:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15oQYt-0004r1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm all for anything that speeds up (and makes more reliable) high network
> speeds, but I often run with 8+ ethernet devices, so IRQs have to be shared,
> and a 10ms lockdown on an interface could lose lots of packets.  Although
> it's not a perfect solution, maybe you could (in the kernel) multiple the
> max by the number of things using that IRQ?  For example, if you have four
> ethernet drivers on one IRQ, then let that IRQ fire 4 times faster than
> normal before putting it in lockdown...

What you really care about is limiting the total amount of CPU time used for
interrupt processing so that usermode progress is made. The network layer
shows this up paticularly badly because (and its kind of hard to avoid this)
it frees resources on the hardware before userspace has processed them. 

Silencing a specific target cannot be done by IRQ masking, you have to 
ask the controller to shut up. It may be the default "shut up" handler
is disable_irq but that is non optimal.

Having driver callbacks as part of the irq handler also massively improves
the effect of the event, because faced with an IRQ storm a card can

-	decide if it is the guily party

If so

-	consider switching to polled mode
-	change its ring buffer size to reduce IRQ load and up latency
	as a tradeoff
-	anything else magical the hardware has (like retuning irq
	mitigation registers)

Alan

	
