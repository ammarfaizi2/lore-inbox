Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263442AbUDMHAG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 03:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbUDMHAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 03:00:05 -0400
Received: from gizmo09ps.bigpond.com ([144.140.71.19]:6349 "HELO
	gizmo09ps.bigpond.com") by vger.kernel.org with SMTP
	id S263442AbUDMG7z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 02:59:55 -0400
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: Len Brown <len.brown@intel.com>
Subject: Re: IO-APIC on nforce2
Date: Tue, 13 Apr 2004 17:03:09 +1000
User-Agent: KMail/1.5.1
Cc: christian.kroener@tu-harburg.de, linux-kernel@vger.kernel.org,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
References: <200404131117.31306.ross@datscreative.com.au> <1081832914.2253.623.camel@dhcppc4>
In-Reply-To: <1081832914.2253.623.camel@dhcppc4>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200404131703.09572.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 April 2004 15:08, Len Brown wrote:
> On Mon, 2004-04-12 at 21:17, Ross Dickson wrote:
> 
> > I am working with 2.4.26-rc2 and have noticed a change with the the recent acpi?
> > update. The recent fix to stop unnecessary ioapic irq routing entries puts the 
> > following if statement into io_apic.c, io_apic_set_pci_routing()
> > 
> > 	/*
> > 	 * IRQs < 16 are already in the irq_2_pin[] map
> > 	 */
> > 	if (irq >= 16)
> > 		add_pin_to_irq(irq, ioapic, pin);
> > 
> > which prevents my io-apic patch from using that function to reprogram the
> > io-apic pin on irq0 from pin2 to pin0. 
> > 
> > As a quick fix you could drop the "if (irq >= 16)".
> > I don't know what harm if any that would do other than create unwanted
> > irq mapping entries as in the past.
> 
> I made that change -- sorry I broke your patch.
> No, I doubt it would matter if you hacked out "if (irq >=16)"
> for the time being.

Thanks Len, my patch was a bit of a quick hack anyway.

> 
> I haven't been following this thread closely, but
> http://bugme.osdl.org/show_bug.cgi?id=1203 says I should;-)
> 
> I understand that these boards have the timer attached to pin0
> in APIC mode, but that the BIOS says it is connected to pin2:
> 
> ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0]
> trigger[0x0])
> 
> Wouldn't it be a simpler patch to recognize this board and simply
> disable this bogus BIOS INT_SRC_OVR?

I will go with you on this one as I have read the intel spec docs 
but have not yet learnt the acpi code base. 

Maciej forwarded me some an override patch he developed for another
architecture where one could spec MP info as kernel args and that worked but
we still had no nmi_debug=1 with the timer_ack=1 situation, which he then
fixed in 2.6.3-mm3 but it got pulled for 2.6.4

Maciej, is that override code good to go on latest kernels? I am a novice to 
acpi parsing etc.

Also some users reported clock skew with timer routed via io-apic pin0.
We never got to the bottom of that so I don't know if doing a pci quirk
on nforce2 would satisfy all for widespread use.

> 
> Also, what is the symptom of the XT-PIC timer?  Is it the source
> of the nForce2 hangs, or something else?  The latest message
> suggested that it caused a backround load on the system, but
> I don't recall hearing that one on this thread before.

Christian could we have more detail on "hi-load" XTPIC please?

Source of nforce2 hang is officially not commented on by Nvidia or 
AMD. 

>From what I know it appears now to be an Athlon to chipset problem as it has
also occured on an SIS-740 board. It seems to have less to do with the 
interrupt routing and everything to do with the timing of back to back C1 
disconnect cycles when those cycles are occuring at a high rate.

Unfortunately spurious interrupts contribute to disconnect rate - and there
are lots of those in XT-PIC mode. I hacked the proc/interrupts code to view
them on irq7 and it was really bad if I used local apic without io-apic.

What I think the mechanism is...
After C1 cycle has occured, if the HLT instruction (to disconnect again) is
executed sooner than about 1us after the interrupt that pulled cpu out
of the C1 cycle occured then likely -we die. The probability of this happening
greatly increases with the rate of C1 cycles. Evident by 1000Hz timer ticks
of 2.6 showing problem up more than 100Hz 2.4. 

Also acpi support for nforce2 in apic with io-apic mode is not widespread 
amongst major 2.4 distros to my knowledge - they stick with
XTPIC on install. Also in XTPIC mode the southbridge accesses provide
the delay time needed for stability in most cases but of course NVIDIA to my
knowledge have not published PCI irq routing registers to be able to manually 
route irqs so devices get stuck unnecessarily sharing a single irq in XTPIC 
mode. I tried a kernel hacked with the AMD 76x registers but they were 
obviously different. 

I think this is going to be a major headache when 2.6 is the main stream distro
as there is a lot of cheap nforce2 out there.
Judging from the silence from AMD hardware vendors- they seem prepared to
wait it out - maybe hoping everyone will go 64bit before it hits the fan?

-Ross.

> 
> thanks,
> -Len
> 
> 
> 
> 
> 

