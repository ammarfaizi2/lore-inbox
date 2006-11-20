Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965913AbWKTP2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965913AbWKTP2N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 10:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965914AbWKTP2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 10:28:13 -0500
Received: from h155.mvista.com ([63.81.120.155]:51653 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S965913AbWKTP2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 10:28:12 -0500
Message-ID: <4561C9EC.3020506@ru.mvista.com>
Date: Mon, 20 Nov 2006 18:29:48 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, dwalker@mvista.com
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
 type IRQ handlers
References: <200611192243.34850.sshtylyov@ru.mvista.com> <1163966437.5826.99.camel@localhost.localdomain> <20061119200650.GA22949@elte.hu> <1163967590.5826.104.camel@localhost.localdomain> <20061119202348.GA27649@elte.hu> <1163985380.5826.139.camel@localhost.localdomain> <20061120100144.GA27812@elte.hu>
In-Reply-To: <20061120100144.GA27812@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Ingo Molnar wrote:

> i.e. Sergei's patch tweaking the irqchip data structures is wrong - the 
> correct approach is what i do for i386/x86_64: install a different 
> "threaded" flow handler.

    Let me remind you that the patch was following *your* change in 
handle_fasteoi_irq(). Do not present it as my own invention.

> I prefer this to tweaking the existing 
> 'fasteoi' handler, to make the act of supporting a threaded flow design 

    You do, indeed? :-)

> explicit. (and to allow a mixed threaded/non-threaded flow setup) I 
> didnt take Daniel's prior patch for that reason: he tried to tweak the 
> fasteoi flow handler - which is an almost good approach but not good 
> enough :-)

    Yeah, your way was *really* better. :-/

> on PPC64, 'get the vector' initiates an ACK as well - is that done 
> before handle_irq() is done?

    Exactly. How else do_IRQ() would know the vector?

>>So by doing a mask followed by an eoi, you essentially mask the 
>>interrupt preventing further delivery of that interrupt and lower the 
>>CPU priority in the PIC thus allowing processing of further 
>>interrupts.

> correct, that's what should happen.

    eoi() would be a more proper name than ack() then.

>>Are there other fasteoi controllers than the ones I have on powerpc 
>>anyway ?

> well, if you mean the x86 APICs, there you get the vector 'for free' as 
> part of the IRQ entry call sequence, and there's an EOI register in the 
> local APIC that notifies the IRQ hardware, lowers the CPU priority, etc. 
> We have that as an ->eoi handler right now.

    Yes. And my perception from that fragment of RT patch was that fasteoi was 
targeted only at SMP interrupt controllers which like IOAPIC are sensible 
enough to not trouble the other CPUs with an interrupt that's already been 
taken by a certain CPU for handling, i.e. that interrupt being effectively 
masked off until EOI arrives (well, that's so for the level triggered but not 
the edge-triggered IRQs, if I don't mistake), so there's no need for explicit 
masking and at the same time that interrupt isn't hindering the delivery of 
the lower-priority interrupts to any CPU (unlike that would be happening with 
8259)...
    Now it turns out that my understading was wrong, and fasteoi could even 
fit for 8259 (according to Ben)?

> 	Ingo

WBR, Sergei
