Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275350AbTHGOuT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 10:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275364AbTHGOuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 10:50:19 -0400
Received: from choke.semantico.com ([212.74.15.98]:46842 "EHLO semantico.com")
	by vger.kernel.org with ESMTP id S275350AbTHGOtt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 10:49:49 -0400
Message-ID: <3F326709.5090805@buttersideup.com>
Date: Thu, 07 Aug 2003 15:49:45 +0100
From: Tim Small <tim@buttersideup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030513
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Roskin <proski@gnu.org>,
       linux-pcmcia@lists.infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: TI yenta-alikes
References: <200308062025.08861.daniel.ritz@gmx.ch> <20030806194430.D16116@flint.arm.linux.org.uk> <Pine.LNX.4.56.0308061452310.3849@marabou.research.att.com> <20030806203217.F16116@flint.arm.linux.org.uk> <Pine.LNX.4.56.0308061554480.4178@marabou.research.att.com> <3F317FD7.6020209@buttersideup.com> <Pine.LNX.4.56.0308062301550.1995@marabou.research.att.com> <20030807100211.A17690@flint.arm.linux.org.uk> <1060258695.3123.36.camel@dhcp22.swansea.linux.org.uk> <3F324DDE.3040409@buttersideup.com> <20030807141650.C25908@flint.arm.linux.org.uk>
In-Reply-To: <20030807141650.C25908@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>On Thu, Aug 07, 2003 at 02:02:22PM +0100, Tim Small wrote:
>  
>
>>"device control register bits2,1:  R/W, Interrupt mode.
>>Bits 2 1 select the interrupt mode used by the PCI1031. Bits 2 1 are 
>>encoded as: 00 = No interrupts enabled (default) 01 = ISA 10 = 
>>Serialized IRQ type interrupt scheme 11 = Reserved"
>>    
>>
>
>When you look at some other TI device, you'll notice that these bits
>have a similar meaning, but, for instance 10 will be reserved (because
>the device doesn't support Serialised ISA IRQs) but supports 11 (serial
>PCI IRQs.)  00 means PCI IRQ mode only on some TI devices, and is a
>valid setting.
>
OK, but you could check various registers to see if the device is in the 
default power-on state, and only then probe.  This will make sure that 
it Just Works for devices which are already correctly configured - which 
should be the majority.  It may turn out to be possible to probe for the 
correct settings on some bridge chips, and not others, but this would 
still be better than nothing..

>You can do what you're suggesting as long as you take account of the
>device itself.  However, once you've decided the device isn't setup,
>how can the kernel determine exactly what the _correct_ setup of the
>device is?  You can't say "well, its a PCI1031 device, therefore I'll
>select ISA interrupt mode" because you don't know if it has been
>wired up that way.
>  
>
I think you can assume that a parallel ISA interrupt wiring scheme, or 
an IRQSER wiring scheme is not possible for an add-in device (i.e. one 
that the system BIOS is unaware of), because there are no pins for these 
signals on a standard PCI slot, making these schemes physically 
impossible  (unless an ISA 'paddle board', or similar was used - I've 
never see such a device, but I suppose it would be possible to build 
one).  Does this also cover the hotplug cases?  What about ACPI resume?

If not, you could probably probe for the valid method, by forcing card 
status events, and seeing if the interrupts get delivered.  Of course, 
the trick is to do this in a way which will not cause trouble, and 
potentially lock up the system by triggering incorrect interrupts etc. 
.  On the PCI1031, you'd need to do this:

. Set up the bridge for parallel ISA IRQ delivery, and see if IRQ 
delivery works by generating a status event (skip this test and quit 
here with a useful error message* with a warning if no safe IRQs 
available for this test (5,12,14 - not a particularly hopeful list, I 
grant you, but possibly, you could also probe IRQ3, IRQ4 in this manner, 
and you'd get PCI interrupts generated if the bridge is wired for 
parallel PCI IRQs))
 - if this fails, it must be wired either IRQSER, or parallel PCI 
interrupts:
. Set up the bridge for parallel PCI IRQ delivery, and see if IRQ 
delivery works by generating a status event
 - if this fails, it must be wired for IRQSER interrupts:
. Set up the bridge for IRQSER delivery, and see if IRQ delivery works 
by generating a status event
 - if this doesn't work, disable interrupts again, and print a message 
stating that interrupts failed (you could still use memory devices, as 
Pavel suggested).


* The error message could say that we were unable to probe interrupts 
because no safe interrupts were available, and say which ones we wanted 
so that the user could make them available by making sure the yenta 
driver was loaded before other drivers and/or disabling devices which 
are already on these IRQs and/or telling the BIOS to reserve them, or 
maybe we could grab these interrupts if available, or tell the user to 
load the module with the module option "yenta_ti_unsafeIRQprobe" enabled.

I am just brainstorming here, so please forgive me if I'm talking bollox ;-)

Tim.

