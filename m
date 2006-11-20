Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965394AbWKTKD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965394AbWKTKD3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 05:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965382AbWKTKD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 05:03:29 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:34971 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965418AbWKTKD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 05:03:28 -0500
Date: Mon, 20 Nov 2006 11:01:44 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, dwalker@mvista.com
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi type IRQ handlers
Message-ID: <20061120100144.GA27812@elte.hu>
References: <200611192243.34850.sshtylyov@ru.mvista.com> <1163966437.5826.99.camel@localhost.localdomain> <20061119200650.GA22949@elte.hu> <1163967590.5826.104.camel@localhost.localdomain> <20061119202348.GA27649@elte.hu> <1163985380.5826.139.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163985380.5826.139.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.4 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.5 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> If my understanding of "threaded handlers" is correct, that is 
> delaying the delivery of the interrupt to a thread while restoring the 
> ability to process further interrupts of the same or lower priority 
> immediately.

correct. It's basically a different type of 'flow' of handling an 
interrupt. It's a host-side genirq-level detail that should have no 
irqchip level impact at all.

The only detail is that sometimes a threaded flow /cannot/ be 
implemented if the irqchip lacks certain methods. (such as a 
mask/unmask)

i.e. Sergei's patch tweaking the irqchip data structures is wrong - the 
correct approach is what i do for i386/x86_64: install a different 
"threaded" flow handler. I prefer this to tweaking the existing 
'fasteoi' handler, to make the act of supporting a threaded flow design 
explicit. (and to allow a mixed threaded/non-threaded flow setup) I 
didnt take Daniel's prior patch for that reason: he tried to tweak the 
fasteoi flow handler - which is an almost good approach but not good 
enough :-)

> There is no such thing as an explicit "ack" on fasteoi controllers. 
> The ack is implicit with the reading of the vector (either via a 
> special cycle on the bus or via reading the intack register for 
> example on mpic).

well, even if it's coupled to the reading of the vector, there is an ack 
initiated by the host. This is not really a fundamental thing, it's API 
semantics of the hardware interface.

so the question is not 'is there an ACK' (all non-MSI-type-of IRQ 
delivery mechanisms have some sort of ACK mechanism), but what is the 
precise structure of ACK-ing an IRQ that the host recieves.

on PPC64, 'get the vector' initiates an ACK as well - is that done 
before handle_irq() is done?

> So by doing a mask followed by an eoi, you essentially mask the 
> interrupt preventing further delivery of that interrupt and lower the 
> CPU priority in the PIC thus allowing processing of further 
> interrupts.

correct, that's what should happen.

> Are there other fasteoi controllers than the ones I have on powerpc 
> anyway ?

well, if you mean the x86 APICs, there you get the vector 'for free' as 
part of the IRQ entry call sequence, and there's an EOI register in the 
local APIC that notifies the IRQ hardware, lowers the CPU priority, etc. 
We have that as an ->eoi handler right now.

	Ingo
