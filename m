Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268088AbTBWJ0g>; Sun, 23 Feb 2003 04:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268089AbTBWJ0f>; Sun, 23 Feb 2003 04:26:35 -0500
Received: from [144.139.35.78] ([144.139.35.78]:1158 "EHLO portal.frood.au")
	by vger.kernel.org with ESMTP id <S268088AbTBWJ0G>;
	Sun, 23 Feb 2003 04:26:06 -0500
Message-ID: <3E58960C.9060900@bigpond.com>
Date: Sun, 23 Feb 2003 20:36:12 +1100
From: James Harper <james.harper@bigpond.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: BUG? SA_INTERRUPT and shared IRQs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i'm having a problem with crashes which i think is to do with shared 
irq's. i have too many things hanging off my PCI bus... dammit.

on IRQ 19 i have:
wlan0 (prism2 based wireless card running hostap)
ens1371 (soundcard)
uhci-hcd (USB driver)

wlan0 and uhci-hcd call request_irq with SA_SHIRQ
ens1371 calles request_irq with SA_SHIRQ | SA_INTERRUPT

the code that calls the interrupt handlers appears to be: 
(arch/i386/kernel/irq.c)

int handle_IRQ_event(unsigned int irq, struct pt_regs * regs, struct 
irqaction * action)
{
        int status = 1; /* Force the "do bottom halves" bit */

        if (!(action->flags & SA_INTERRUPT))
                local_irq_enable();

        do {
                status |= action->flags;
                action->handler(irq, action->dev_id, regs);
                action = action->next;
        } while (action);
        if (status & SA_SAMPLE_RANDOM)
                add_interrupt_randomness(irq);
        local_irq_disable();

        return status;
}

which looks to me that interrupts are going to get enabled if the 
_first_ handler in the chain _doesn't_ have SA_INTERRUPT set, which 
isn't the behaviour i'd expect. a later handler might freak if it makes 
the assumption that interrupts are disabled (or maybe this doesn't 
happen)...

i'm not sure what the correct thing to do here is... is it okay to 
enable or disable interrupts for each handler depending on their own 
SA_INTERRUPT flag? if that's the case then the patch is trivial...

thanks

James


