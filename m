Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274832AbTHFWXq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 18:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274955AbTHFWXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 18:23:46 -0400
Received: from mail.digitalbrain.com ([217.154.108.126]:11693 "EHLO
	blackfriars.digitalbrain.com") by vger.kernel.org with ESMTP
	id S274832AbTHFWXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 18:23:22 -0400
Message-ID: <3F317FD7.6020209@buttersideup.com>
Date: Wed, 06 Aug 2003 23:23:19 +0100
From: Tim Small <tim@buttersideup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030513
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Pavel Roskin <proski@gnu.org>
Cc: rmk@arm.linux.org.uk, linux-pcmcia@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: TI yenta-alikes (was: ToPIC specific init for yenta_socket)
References: <200308062025.08861.daniel.ritz@gmx.ch>	<20030806194430.D16116@flint.arm.linux.org.uk>	<Pine.LNX.4.56.0308061452310.3849@marabou.research.att.com>	<20030806203217.F16116@flint.arm.linux.org.uk> <Pine.LNX.4.56.0308061554480.4178@marabou.research.att.com>
In-Reply-To: <Pine.LNX.4.56.0308061554480.4178@marabou.research.att.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Roskin wrote:

>>It's fairly complex.  Let's just summarize it as "yenta texas
>>instruments IRQ routing fucked up" 8)  The chip has a bunch of registers
>>to control what signals get routed to which physical pins, and it seems
>>that between June 2002 and today, some bad changes happened.  I'm
>>currently trying to track down each one, but, as there have been several
>>levels of patching going on, it isn't simple.
>>    
>>
>
>I thought you mean something more fundamental.  This problem really should
>not stand in the way of changes unrelated to the TI bridges, such as the
>ToPIC patch.
>
>TI bridges have 3 different interrupt routing methods.  The i82365 manual
>from pcmcia-cs lists all three - PCI interrupts, ISA interrupts and ISA
>interrupts routed via an external serial interrupt controller.
>  
>
>PCI cards without an additional ISA connector always use PCI interrupts.
>  
>
>PowerPC architecture also requires PCI interrupts.  Laptops may use any of
>three routing methods, but some of those methods may not work.
>
>The i82365 driver from pcmcia-cs used the preexisting configuration by
>default, which was OK for most laptops, but not for standalone PCI cards.
>
>2.5 kernels introduced a device table to determine the interrupt delivery
>method.  I criticized this approach, and wrote a patch that would turn on
>ISA interrupts if the PCI interrupt delivery failed.  This patch was
>applied by Alan Cox to the 2.4 tree.
>
>Unfortunately, I forgot about bridges using external serial interrupt
>controllers (I have no idea what it means).  It was reported that such
>bridges were also probed for PCI interrupts, and after failing that,
>reconfigured to the normal ISA interrupt delivery, which didn't work
>either.
>  
>
I think that the chip used on my card at least (TI PCI1031), has an 
option of delivering ISA IRQs via the IRQSER (I think this is the same 
as PCI SERRn/SERIRQ signals).

 From what I can gather (I might be totally wrong), I think this is 
likely to be used on some laptops, as the PCI SERRn/SERIRQ signal was a 
proposed standard, and never actually made it's way onto a standard PCI 
slot, however some pci host bridges implement this (e.g. Intel PIIX, I 
think), so I'd guess quite a few laptops may have their PCI1xxx chips 
wired to the PCI host bridge like this, as this would be the cheapest 
and most flexible option if it is available ("parallel" ISA IRQ delivery 
uses more PCB traces, and PCI interrupts pose driver compatibility 
problems).

The alternative way of using IRQSER interrupts appears to be to have an 
external TI PCI950 chip do the serial to parallel IRQ conversion, 
although I've no idea why you'd want to bother with this, when the 
PCI1xxx chips can do this already, with the caveat, that they can only 
deliver ISA IRQs 3,4,5,7,9,10,11,12,14,15.

I'm willing to hack on this code a bit, as I got my PCI1031 PCI card 
working under 2.4, with some patching.  This card (SCM Microsystems 
"Swapbox") implements PCI interrupts only, and has two slots.  
Interestingly, this card seems to work OK under win9x, so I suppose they 
figured out how to do it on that code base, but under w2k, you have to 
tweak a registry setting to tell it to use PCI irqs...

>The problem with TI bridges is that there are at least 3 types of them
>that needs to be tested, and I only have one of them.
>  
>
Well, I have a spare PCI1031 PCI card, which I can test, and hack on.  
We could certainly use some more testers, but this is a start...

>If there is a desire to do it right this time, and if the problem is
>considered serious to spend some time on it, here's how I would do it.
>
>- Never trust preexisting configuration.  Always probe the interrupts.
>- Use PCI ID only to disable access to unsupported registers, not to
>  find the best IRQ routing.
>- Cache the probe results until yenta_socket is unloaded.  Probe
>  interrupts once per socket (i.e. 2 times for two-socket cards).
>- Probe PCI interrupts first.
>- Probe ISA interrupts next, only if there are free interrupts and the
>  architecture allows ISA interrupts.
>- Probe serial ISA interrupts under the same conditions.
>- If all probes fail, deny interrupt requests from clients.  This would
>  allow some memory cards.
>
>I can write this code, but I only have a PCI card to test.
>
Sounds good...  However, one possible gotcha might be that the physical 
IRQ pins are shared, and operate differently in different modes so it 
may be possible to make a mess if you configure the chip wrong:

e.g. PCI1031

pin   function
154   IRQ3/PCI INTA
155   IRQ4/PCI INTB
157   IRQ7/PCDMAREQ
158   IRQ9/IRQSER
159   IRQ10/CLKRUN
160   IRQ11/PCDMAGNT
163   IRQ15/RI_OUT

So maybe (not sure) if you put the chip in PCI interrupt mode first, it 
will spray the ISA interrupts pins, if the system is wired up this way 
(I know nearly nothing about ISA and PCI from an electrical point of 
view, so I've no idea if this would happen in practice, but it at least 
seems possible)?

Maybe:

- Probe for parallel ISA IRQs first (maybe on non shared pins if poss - 
on the PCI1031, IRQs 5,12,14 have their own dedicated pin)
- Next, probe for serial ISA IRQs
- Finally, probe for PCI IRQs

If probing seems impossible or unsafe, I suppose the only way to do it 
would be module/kernel options.

There are some TI PCI1xxx data sheets here:

http://www.mit.edu/afs/sipb/contrib/doc/specs/ic/bridge/

my (unfinished, but WorksForMe (tm)) 2.4 / TI PCI1031 patch is here:

http://buttersideup.com/kernel_patches/ti-pci1031.patch

Some evidence for IRQSER / PIIX possiblity:

http://groups.google.com/groups?threadm=SGTxgPhJ9GA.185%40newsgroups.intel.com

Cheers,

Tim.

