Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264271AbUAIXFJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 18:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264245AbUAIXFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 18:05:09 -0500
Received: from postfix4-2.free.fr ([213.228.0.176]:29641 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S264271AbUAIXEz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 18:04:55 -0500
Date: Sat, 10 Jan 2004 00:04:52 +0100
From: cheuche+lkml@free.fr
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm1 - nforce2 timer patch sum up
Message-ID: <20040109230452.GA8320@localnet>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040109014003.3d925e54.akpm@osdl.org> <3FFED73D.8020502@gmx.de> <20040109132038.2dfaef02.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040109132038.2dfaef02.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 09, 2004 at 01:20:38PM -0800, Andrew Morton wrote:
> "Prakash K. Cheemplavam" <PrakashKC@gmx.de> wrote:
> >
> > Hi,
> > 
> > could it be that you took out /or forgot to insterst the work-around for 
> > nforce2+apic? At least I did a test with cpu disconnect on and booted 
> > kernel and it hang. (I also couldn't find the work-around in the 
> > sources.) I remember an earlier mm kernel had that workaround inside.
> > 
> 
> I discussed it with Bart and he felt that it was not a good way of fixing
> the problem.  I'm not sure if he has a better fix in the works though..

One of the fixes was about getting timer interrupts on apic. It was a
quick hack from me and definitely wrong. Furthermore, it does
unfortunately nothing against these hangs.

I will try to summarize this problem.

Back in the 2.5 series, timer configuration was :

..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...
..... (found pin 0) ...works.

and interrupt 0 in /proc/interrupts was IO-APIC-edge.

A fix in mp_override_legacy_irq() in arch/i386/kernel/mpparse.c changes
this behavior to :

..TIMER: vector=0x31 pin1=2 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... failed.
...trying to set up timer as ExtINT IRQ... works.

and interrupt 0 went to XT-PIC mode, and spurious interrupts on IRQ7
appeared !

It seems that there is no timer connected to pin 2 on the nforce2 apic
when linux tries to find it (MP-BIOS bug with pin1=2). Maybe it is not
connected at all on (all ?) nforce2 motherboards.
However, this configuration information (pin1=2) comes from :

ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)

that is, from the BIOS. This is confusing because if the timer is not
connected to this pin, why the bios tells it is ? OK, this won't be the
first broken bios out there.

After some experimentation, I came across with an interesting result
when I change the INT_SRC_OVR's global_irq to 0 (timer connecter to 
pin 0, not 2), all I have is :

..TIMER: vector=0x31 pin1=0 pin2=-1

and everything is working great, no spurious or streams of IRQ7, not
even a small drift I noticed with other configurations between LOC count
and IRQ0 count in /proc/interrupts. nmi_watchdog=1 doesn't work however
(well it never worked anyway). Others on lkml achieved more or less the
same result with force-setting the timer on pin 0 with
io_apic_set_pci_routing() and nmi_watchdog=1 works this way.

To sum up about the problem :

 - timer is not on pin 2 (or something needs to be done ?)
 - bios lies about it in its INT_SRC_OVR (or expect something to be
   done ?)
 - timer works well on pin 0, through the 8259A or via a hacked
   INT_SRC_OVR or a io_apic_set_pci_routing()
 - timer on ExtINT or timer in lapic+noapic mode leads to spurious IRQ7

But I cannot see a proper fix. Maybe nvidia or motherboard makers could
tell us why there is an INT_SRC_OVR for the timer telling the kernel to 
find it on pin 2 where there is nothing. Intel apic documentation says
this is the correct pin to connect the timer but it does not work on
nforce2 apic. Note that if motherboard makers release a bios with
timer's INT_SRC_OVR on pin 0, this problem magically goes away...
But that would not removes the spurious IRQ7 with local apic but noapic,
since the acpi override would not be looked at, so there might be
another problem.

And this is just the timer problem, the cpu disconnect one is still an
other story. Maybe they are related but the connection is far from
being obvious.

I hope this sum up about one of these two nforce patches helps.

Mathieu
