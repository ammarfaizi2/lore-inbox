Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267090AbTAFSuw>; Mon, 6 Jan 2003 13:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267094AbTAFSuv>; Mon, 6 Jan 2003 13:50:51 -0500
Received: from eamail1-out.unisys.com ([192.61.61.99]:44964 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S267090AbTAFSuu>; Mon, 6 Jan 2003 13:50:50 -0500
Message-ID: <3FAD1088D4556046AEC48D80B47B478C022BD8BA@usslc-exch-4.slc.unisys.com>
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Cc: "'William Lee Irwin III'" <wli@holomorphy.com>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'James Cleverdon'" <jamesclv@us.ibm.com>,
       "'Pallipadi, Venkatesh'" <venkatesh.pallipadi@intel.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "'Martin Bligh'" <mbligh@us.ibm.com>,
       "'John Stultz'" <johnstul@us.ibm.com>,
       "'Nakajima, Jun'" <jun.nakajima@intel.com>,
       "'Mallick, Asit K'" <asit.k.mallick@intel.com>,
       "'Saxena, Sunil'" <sunil.saxena@intel.com>,
       "Van Maren, Kevin" <kevin.vanmaren@UNISYS.com>,
       "'Andi Kleen'" <ak@suse.de>, "'Hubert Mantel'" <mantel@suse.de>
Subject: RE: [PATCH][2.4]  generic cluster APIC support for systems with m
	 ore than 8 CPUs
Date: Mon, 6 Jan 2003 12:58:47 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>One thing I will say. Your code would be a hell of a lot saner for
>merging if you mapped the ISA/Legacy IRQ's as 0-15 (to software) and the
>PCI ones to 16+ like everyone else does. That would kill a _lot_ of
>ifdefs and the IRQ0 corner case

Alan,

You were right: my new IRQ overwrite code (done the way you suggested) is
getting much smaller now.
I got it down to ... one line :-)! 

I have to say, that either the Linux code got greatly perfected or our
numerous BIOS changes helped (one or the other, maybe  both) but in earlier
days I couldn't boot the system with generic SMP kernel past the first delay
calibration (off of the PIC). That's why I had to tinker with the IRQ0 and
do the rest of ugly IRQ transformations you noticed earlier. APIC and XTPR
issues  are still there (I will wait for Venkatesh's patch), but I am only
concentrating on interrupts this time. Now, it only stumbles on the IO-APIC
setup, which I can  fix with one line of code... Unfortunately, this line
cannot be justified without bringing up "knowledge of the platform". 

I am working with the MP table for now; the ACPI case gives me same results
but I haven't looked at it yet.

The problem is that current IRQ overwrite code handles everything perfectly
except it cannot handle PCI IRQ range being placed  over the ISA range:

static int pin_2_irq(int idx, int apic, int pin)
{
	.....
        switch (mp_bus_id_to_type[bus])
        {
                case MP_BUS_ISA: /* ISA pin */
                case MP_BUS_EISA:
                case MP_BUS_MCA:
                {
                        irq = mp_irqs[idx].mpc_srcbusirq;
                        break;
                }
                case MP_BUS_PCI: /* PCI pin */
                {
                        /*
                         * PCI IRQs are mapped in order
                         */
                        i = irq = 0;
                        while (i < apic)
                                irq += nr_ioapic_registers[i++];
//Here, it just takes the pin (0-16 in our case) and returns it as IRQ:
                        irq += pin;
//Knowing the above and the fact that our first IO-APIC has the ISA range, I
just shift it off the ISA range:
         ===>>          if (!apic) irq += 16; <<==== NBP - my line. Could be
"if (irq < 16)" instead
                        break;
                }
                default:
                {
	....


The original code is assumtious itself... but it is a question of how
generic I want to be to handle our case.
I guess I could:

1) place pin_2_irq and the one that fixes the ACPI case (and which I haven't
found yet) in our sub-arch making those routines platform defined
2) try to fit in the generic case which would take something like changing
mp_irqs on the platform basis or finding something that fixes every possible
case of this kind. For example: in the IA64 case, irq code was arranged
pretty smart: they made one to one correspondence between vectors and IRQs.
Then they set up ISA range within 0x20-0x2f, and all others go from 0x30 on,
this way they never mix up.(BTW, you mentioned x86 case once, but to me
their IRQ code looked identical to i386 case unless I missed something.)
3) ??? - what would you recommend? - ??? (Everyone's comments are VERY
welcome!)

This is a crucial issue for ES7000, since everything else seems to fit in
sub-arch. 
Another one that I am worried about is XTPR, hopefully someone is looking at
its implementation... 

Thanks,

--Natalie

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Wednesday, December 25, 2002 2:42 PM
To: Protasevich, Natalie
Cc: 'William Lee Irwin III'; 'Christoph Hellwig'; 'James Cleverdon';
'Pallipadi, Venkatesh'; 'Linux Kernel'; 'Martin Bligh'; 'John Stultz';
'Nakajima, Jun'; 'Mallick, Asit K'; 'Saxena, Sunil'; Van Maren, Kevin;
'Andi Kleen'; 'Hubert Mantel'
Subject: RE: [PATCH][2.4] generic cluster APIC support for systems with
m ore than 8 CPUs


One thing I will say. Your code would be a hell of a lot saner for
merging if you mapped the ISA/Legacy IRQ's as 0-15 (to software) and the
PCI ones to 16+ like everyone else does. That would kill a _lot_ of
ifdefs and the IRQ0 corner case

