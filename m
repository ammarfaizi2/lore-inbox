Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275241AbTHGJSp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 05:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275242AbTHGJSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 05:18:45 -0400
Received: from choke.semantico.com ([212.74.15.98]:47866 "EHLO semantico.com")
	by vger.kernel.org with ESMTP id S275241AbTHGJSl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 05:18:41 -0400
Message-ID: <3F32196D.8070907@buttersideup.com>
Date: Thu, 07 Aug 2003 10:18:37 +0100
From: Tim Small <tim@buttersideup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030513
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Roskin <proski@gnu.org>
Cc: rmk@arm.linux.org.uk, linux-pcmcia@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: TI yenta-alikes
References: <200308062025.08861.daniel.ritz@gmx.ch> <20030806194430.D16116@flint.arm.linux.org.uk> <Pine.LNX.4.56.0308061452310.3849@marabou.research.att.com> <20030806203217.F16116@flint.arm.linux.org.uk> <Pine.LNX.4.56.0308061554480.4178@marabou.research.att.com> <3F317FD7.6020209@buttersideup.com> <Pine.LNX.4.56.0308062301550.1995@marabou.research.att.com>
In-Reply-To: <Pine.LNX.4.56.0308062301550.1995@marabou.research.att.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Roskin wrote:

>On Wed, 6 Aug 2003, Tim Small wrote:
>  
>
>>I think that the chip used on my card at least (TI PCI1031), has an
>>option of delivering ISA IRQs via the IRQSER (I think this is the same
>>as PCI SERRn/SERIRQ signals).
>>
>> From what I can gather (I might be totally wrong), I think this is
>>likely to be used on some laptops, as the PCI SERRn/SERIRQ signal was a
>>proposed standard, and never actually made it's way onto a standard PCI
>>slot, however some pci host bridges implement this (e.g. Intel PIIX, I
>>think), so I'd guess quite a few laptops may have their PCI1xxx chips
>>wired to the PCI host bridge like this, as this would be the cheapest
>>and most flexible option if it is available ("parallel" ISA IRQ delivery
>>uses more PCB traces, and PCI interrupts pose driver compatibility
>>problems).
>>    
>>
>
>Are you saying that you have a PCI card without any additional connectors,
>but it can use "serial" ISA interrupts thanks to the chipset support?  Or
>is it a laptop?
>  
>
No, my card is wired up for PCI interrupts only, and the SERIRQ signal 
is not available on a standard PCI slot, so no PCI add-in cards can use 
SERIRQ.  On a laptop (where the cardbus bridge is on the same PCB as the 
PCI host bridge), it could be used.  The SERIRQ pin can be used to 
deliver *both* ISA, and PCI interrupts, but I don't know for sure if the 
TI chips will do this.  I suppose I could get my soldering iron out and 
check for this, but perhaps I won't ;o).

>>The alternative way of using IRQSER interrupts appears to be to have an
>>external TI PCI950 chip do the serial to parallel IRQ conversion,
>>although I've no idea why you'd want to bother with this, when the
>>PCI1xxx chips can do this already, with the caveat, that they can only
>>deliver ISA IRQs 3,4,5,7,9,10,11,12,14,15.
>>    
>>
>
>As I understand it, "serial ISA" interrupts are available to PCI cards
>only on some chipsets.  If the chipset support is missing, PCI950 would be
>used on the motherboard.
>  
>
Yes, alternatively you could just wire up the ISA IRQ lines instead.  At 
least on the PCI1031, however, this means that you can't deliver PCI 
interrupts (as the physical pins are shared).

>>>I can write this code, but I only have a PCI card to test.
>>>
>>>      
>>>
>>Sounds good...  However, one possible gotcha might be that the physical
>>IRQ pins are shared, and operate differently in different modes so it
>>may be possible to make a mess if you configure the chip wrong:
>>
>>e.g. PCI1031
>>
>>pin   function
>>154   IRQ3/PCI INTA
>>155   IRQ4/PCI INTB
>>157   IRQ7/PCDMAREQ
>>158   IRQ9/IRQSER
>>159   IRQ10/CLKRUN
>>160   IRQ11/PCDMAGNT
>>163   IRQ15/RI_OUT
>>
>>So maybe (not sure) if you put the chip in PCI interrupt mode first, it
>>will spray the ISA interrupts pins, if the system is wired up this way
>>(I know nearly nothing about ISA and PCI from an electrical point of
>>view, so I've no idea if this would happen in practice, but it at least
>>seems possible)?
>>    
>>
>
>I have no idea, but I think it's an important consideration.  I wonder how
>it's possible to put IRQ3 and INTA on the same pin?  What if CSC uses INTA
>and the PCMCIA card uses IRQ3?  How does it get routed to different
>places?
>
You can't, as far as I know.  You must either wire this pin to PCI INTA, 
(and program the bridge registers to deliver PCI interrupts) or to IRQ3 
(and program the registers for ISA interrupts).  This is just on my 
bridge tho' (PCI1031), later bridges might not have this limitation..

>  I guess there should be some way to tell on the hardware level
>what mode the chip uses.
>
As far as I can tell, no, there isn't (short of probing for 
interrupts).  Once you program the registers up, the chip will treat the 
pins appropriately.  You can however read the registers to see what mode 
the BIOS has put the chip in, I suppose, of course, this is no good for 
PCI add-in cards, where the BIOS doesn't know about the bridge chip.

>>Maybe:
>>
>>- Probe for parallel ISA IRQs first (maybe on non shared pins if poss -
>>on the PCI1031, IRQs 5,12,14 have their own dedicated pin)
>>- Next, probe for serial ISA IRQs
>>- Finally, probe for PCI IRQs
>>    
>>
>
>I think there are some questions we need to answer before we decide.
>
>1) How important is it to provide the card with a non-shared ISA
>interrupt?  Shouldn't we rather update the drivers to deal with shared
>interrupts?  I can imagine that some old PCMCIA cards are designed without
>interrupt sharing in mind, i.e. it's hard to say if the interrupt was
>issued by that card or by some other device.  But how critical is that?
>Do we want to support really old hardware, broken by design?  And what
>exactly hardware is it?
>
Well, it's not really the card that would be broken by design, 16bit 
card hardware designers have a right to assume that they have access to 
ISA style interrupts, I think.  These might not work where the bridge 
chip is only wired for PCI interrupts.  I can't remember which drivers 
didn't work in this case (there was only one, I think).

>2) There is a risk of taking an interrupt from an ISA device that
>doesn't have its module loaded yet.  Do we care about it?
>  
>
Don't know enough about this, sorry!

>3) What is the risk of disabling the system by probing for parallel ISA
>interrupts?
>
Hmm, no risk if you only probe for IRQs which are on non-shared pins (5, 
12, 14), not sure what the risk is if you start driving ISA IRQs down 
lines which are wired up to the PCI bus, need to ask a hardware engineer 
;-).

>4) What is the risk of disabling the system by probing for serial ISA
>interrupts, especially on the motherboards without support for them?
>  
>
Should be no risk, I think, if you have established that the chip is not 
wired for parallel interrupts.

>>Some evidence for IRQSER / PIIX possibility:
>>
>>http://groups.google.com/groups?threadm=SGTxgPhJ9GA.185%40newsgroups.intel.com
>>    
>>
>
>Yes, but note this:
>
>"The serial interrupt interrupt register, SERIRQC, in section 4.1.11 of
>the PIIX4 datasheet has to be initialized before any of the serial
>interrupts to work. I believe this is done through BIOS if the BIOS
>supports it."
>
>SERIRQC is described here:
>http://www.intel.com/design/intarch/techinfo/440bx/bridgreg.htm
>
>I don't know if we should change this register.  It depends on how badly
>we want to give ISA interrupt to the cards.
>  
>
Well, I take it that as the card can only be wired this way if the 
pcmcia/cardbus bridge is on the main system board, that we should assume 
that the BIOS has already done this...

Tim.

