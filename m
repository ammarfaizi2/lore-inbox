Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319603AbSIHNDV>; Sun, 8 Sep 2002 09:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319604AbSIHNDU>; Sun, 8 Sep 2002 09:03:20 -0400
Received: from netfinity.realnet.co.sz ([196.28.7.2]:35485 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S319603AbSIHNDU>; Sun, 8 Sep 2002 09:03:20 -0400
Date: Sun, 8 Sep 2002 15:31:01 +0200 (SAST)
From: Zwane Mwaikambo <zwane@mwaikambo.name>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Ingo Molnar <mingo@elte.hu>
Cc: Robert Love <rml@tech9.net>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][RFC] per isr in_progress markers
In-Reply-To: <Pine.LNX.4.44.0209080957410.17502-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209081507140.1096-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Sep 2002, Ingo Molnar wrote:

> if we didnt disable the IRQ line then an additional interrupt would be
> triggered when [*] is done.

We should be safe from that since ->end() is called after the handler at 
at that stage the irq line is still disabled due to us not ack'ing in 
->ack()

> it could perhaps be handled the following way:
> 
> 	disable IRQ line
> 	ack APIC
> 	-> call handler
> 	    while (work_left) {
> 		ack interrupt on the card            [*]
> 		enable IRQ line			     [**]
> 		[... full processing ...]
> 	    }
> 
> so after [**] is done we could accept new interrupts, and the amount of
> time we keep the irq line disabled should be small. Obviously this means
> driver level changes.

After looking at the code at bit more the following would still work for 
level triggered via ioapic. Due to that specific irq line being 
effectively disabled until we hit ->end.

desc->handler->ack();
action->handler()
while(work_to_do) {
	ack_interrupt_on_card();	<-- unmask_irq_line in here too
	do_isr_work();
}
...
desc->handler->end();

So it looks like your previous suggestion of driver modification still 
stands, would it be safe then to do a real ack in the isr (for the ioapic 
case)?

	Zwane

-- 
function.linuxpower.ca

