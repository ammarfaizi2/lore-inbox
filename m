Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbTLJMbq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 07:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbTLJMbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 07:31:46 -0500
Received: from xavier.comcen.com.au ([203.23.236.73]:53778 "EHLO
	xavier.etalk.net.au") by vger.kernel.org with ESMTP id S262729AbTLJMbk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 07:31:40 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: Mikael Pettersson <mikpe@csd.uu.se>, Jesse Allen <the3dfxdude@hotmail.com>
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
Date: Wed, 10 Dec 2003 18:40:54 +1000
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, AMartin@nvidia.com,
       Ian Kumlien <pomac@vapor.com>
References: <200312072312.01013.ross@datscreative.com.au> <20031210033906.GA176@tesore.local> <16342.61127.717756.446723@alkaid.it.uu.se>
In-Reply-To: <16342.61127.717756.446723@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200312101759.16781.ross@datscreative.com.au>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 December 2003 20:00, Mikael Pettersson wrote:
> Jesse Allen writes:
>  > --- linux/arch/i386/kernel/apic.c	2003-10-25 11:44:59.000000000 -0700
>  > +++ linux-jla/arch/i386/kernel/apic.c	2003-12-09 19:07:19.000000000 -0700
>  > @@ -1089,6 +1089,16 @@
>  >  	 */
>  >  	irq_stat[cpu].apic_timer_irqs++;
>  >  
>  > +#ifdef CONFIG_MK7 && CONFIG_BLK_DEV_AMD74XX
>  > +
>  > +	/*
>  > +	 * on 2200XP & nforce2 chipset we need at least 500ns delay here
>  > +	 * to stop lockups with udma100 drive. try to scale delay time
>  > +	 * with cpu speed. Ross Dickson.
>  > +	 */
>  > +	ndelay((cpu_khz >> 12)+200 ); /* don't ack too soon or hard lockup */
>  > +#endif
>  > +
>  >  	/*
>  >  	 * NOTE! We'd better ACK the irq immediately,
>  >  	 * because timer handling can be slow.
> 
> This is too much of a kludge. APIC timer ACKing is supposed to be fast.
> Please try without this delay but with the disconnect PCI quirk.
> 
> If the delay is still needed even when disconnect is disabled, _then_
> can discuss how to do the delay properly.
> 
> /Mikael
> 
> 
> 

Thanks Mikael, I think the more heads on this problem the better.

I don't like timing kludges either such as this existing one in ide-iops.c
in kernel 2.4.23

	hwif->OUTBSYNC(drive, cmd, IDE_COMMAND_REG);
	/* Drive takes 400nS to respond, we must avoid the IRQ being
	   serviced before that.

	   FIXME: we could skip this delay with care on non shared
	   devices

	   For DMA transfers highpoint have a neat trick we could
	   use. When they take an IRQ they check STS but also that
	   the DMA count is not zero (see hpt's own driver)
	*/
	ndelay(400);
	spin_unlock_irqrestore(&io_request_lock, flags);
}

But does anyone exactly know what nvidia and the bios writer are doing - why the 
cpu-disconnect is an issue for the nforce2 boards?

Is it technically correct in their view to turn off features that some pci or
other device they have made may expect? I wonder about their
ram devices because I note after some more testing that without any 
lockup fixes the lockups were spaced a lot further apart in time when I used 
a pair of KINGMAX 256MB DDR-333 then when I used a pair of SEITEC 256MB 
DDR-400 memory. The cpu used XP2500 has a 333 fsb. Is the ram driver chip core
enforcing the disconnect for a reason?

When using the ack delay, lockups with both memory types ceased - as they may 
also cease with the disconnect patch. So the disconnect cycles seem related 
to the nforce2 ram driver circuitry. (See Ian's take towards end of this email)

The reason why I put the ack delay in only the apic timer servicing path is that
I think it is the only commonly traversed path which acks the apic so quickly. If
we end up stuck with a delay then we could probably make it more accurate by
reading the apic timer withinin the delay and using the counts down from the reload
value because if our irq was already pre delayed then no additional delay would 
be required. I am sure many clever programmers can improve on it - not that we
want it at all.

I note the following comments in 2.2.23 io_apic.c
/*
 * Level triggered interrupts can just be masked,
 * and shutting down and starting up the interrupt
 * is the same as enabling and disabling them -- except
 * with a startup need to return a "was pending" value.
 *
 * Level triggered interrupts are special because we
 * do not touch any IO-APIC register while handling
 * them. We ack the APIC in the end-IRQ handler, not
 * in the start-IRQ-handler. Protection against reentrance
 * from the same interrupt is still provided, both by the
 * generic IRQ layer and by the fact that an unacked local
 * APIC does not accept IRQs.
 */
If I am reading this correctly then PCI interrupts which are level 
triggered are processed with the equivalent of a global (maskable) hardware 
interrupt disable (on a uniprocessor machine) if all hardware interrupts
are routed via the APIC. Chances are that we have more than 500ns irq off
times occurring with these servicing routines especially if several handlers
are chained on the one pirq.

Another clue may have just come to light, does the ack in this routine (io_apic.c)
usually get done within the 500ns or so from its activation? If it does then either the
mask_IO_APIC_irq() has a positive effect on the lockups or alternately the 
problem is synchronous with, or inherent to the apic timer.

/*
 * Once we have recorded IRQ_PENDING already, we can mask the
 * interrupt for real. This prevents IRQ storms from unhandled
 * devices.
 */
static void ack_edge_ioapic_irq(unsigned int irq)
{
	if ((irq_desc[irq].status & (IRQ_PENDING | IRQ_DISABLED))
					== (IRQ_PENDING | IRQ_DISABLED))
		mask_IO_APIC_irq(irq);
	ack_APIC_irq();
}


How slow can timer handling be?
When I was debugging with my CRO on the LPT port and turning a bit on
going into the smp_apic_timer_interrupt() routine and turning the bit off
when exiting I saw times of greater than 0.5ms for the routine to complete.
Thats milliseconds!. I certainly agree with the comment regarding the ack 
immediately and think it means before 0.5ms instead of after 0.5ms 
because 0.5ms is an eternity to have interrupts disabled in a hardware 
interrupt context.
 /*
  * NOTE! We'd better ACK the irq immediately,
  * because timer handling can be slow.
I am not too crazy about having them off for 500ns to 1000ns either but until I 
know for certain that the cpu disconnect issue is a non issue then I will
choose to suffer a time hit, and leave the hardware run as the maker intended.

BIG HINT TO THOSE IN THE KNOW.
If we had the docs from nvidia regarding the unknown pci devices?

00:00.0 Host bridge: nVidia Corporation: Unknown device 01e0 (rev a2)
00:00.1 RAM memory: nVidia Corporation: Unknown device 01eb (rev a2)
00:00.2 RAM memory: nVidia Corporation: Unknown device 01ee (rev a2)
00:00.3 RAM memory: nVidia Corporation: Unknown device 01ed (rev a2)
00:00.4 RAM memory: nVidia Corporation: Unknown device 01ec (rev a2)
00:00.5 RAM memory: nVidia Corporation: Unknown device 01ef (rev a2)

then perhaps the underlying cause would present itself. Then we could properly
deal with the issue because we would know why we should do whatever it
is we should do. If the disconnect should be left on then hopefully we could test
a register somewhere to know when it is safe to ack or not - something like
that.

I think Ian is heading in the right direction with his comments:

On Wednesday 10 December 2003 11:20, Ian Kumlien wrote:
> Hi, again.
> 
> I did some reading on amd's site, and if the disconnect + apic fixed the
> same problem as the ~500ns delay, then it could be as i suspect...
> 
> I suspect that something goes wrong with apic ack when the cpu is
> disconnected and according to the amd docs we could check the
> Northbridge's CLKFWDRST or isn't that avail on the outside?
> (It would be interesting to see if that fixes the problem as well.)
> 
> http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/26237.PDF
> 
> I don't really have the knowledge but it would sure be nicer to fix this
> by checking this than to just disable it. I dunno if there is something
> we could do from within the kernel aswell with the sending of HLT but i
> doubt it.
> 
> Anyways, we need a generalized patch that does better checking on the
> NMI bit (like Ross' patch). 
> 
> PS. Anyone that can point me to northbridge tech docks? and CC
> 
> -- 
> Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net
> 

Regards
Ross.
