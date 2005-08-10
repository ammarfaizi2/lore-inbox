Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030266AbVHJVFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbVHJVFE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 17:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030270AbVHJVFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 17:05:04 -0400
Received: from usbb-lacimss1.unisys.com ([192.63.108.51]:11537 "EHLO
	usbb-lacimss1.unisys.com") by vger.kernel.org with ESMTP
	id S1030266AbVHJVFB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 17:05:01 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC][2.6.12.3] IRQ compression/sharing patch
Date: Wed, 10 Aug 2005 16:03:48 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04CAE@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC][2.6.12.3] IRQ compression/sharing patch
Thread-Index: AcWYwtkd/Zlfo6SRSWqiJSpKuNovzQFJbWRg
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: <jamesclv@us.ibm.com>, "Andi Kleen" <ak@suse.de>
Cc: "Brown, Len" <len.brown@intel.com>, <zwane@arm.linux.org.uk>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Aug 2005 21:03:50.0854 (UTC) FILETIME=[02234E60:01C59DEF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Due to some device driver issues, I built this iteration of 
> the patch vs. 2.6.12.3.
> 
> (Sorry about the attachment, but KMail is still word wrapping inserted
> files.)
> 
> Background:
> 
> Here's a patch that builds on Natalie Protasevich's IRQ 
> compression patch and tries to work for MPS boots as well as 
> ACPI.  It is meant for a 4-node IBM x460 NUMA box, which was 
> dying because it had interrupt pins with GSI numbers > 
> NR_IRQS and thus overflowed irq_desc.
> 
> The problem is that this system has 280 GSIs (which are 1:1 
> mapped with I/O APIC RTEs) and an 8-node box would have 560.  
> This is much bigger than NR_IRQS (224 for both i386 and 
> x86_64).  Also, there aren't enough vectors to go around.  
> There are about 190 usable vectors, not counting the reserved 
> ones and the unused vectors at 0x20 to 0x2F.  So, my patch 
> attempts to compress the GSI range and share vectors by sharing IRQs.
> 
Hi James, 
I tested your patch today (sorry it took a while, was out of town), and
in general it worked just fine. It was a small system with 3 IO-APICs,
will hopefully try it on a large partition with 64 of them tonight.
One thing I noticed: I think the patch is going for shared vectors way
before exhausting available NR_IRQS, so I suggest a small modification
to it, in gsi_irq_sharing():
int gsi_irq_sharing(int gsi)
{
        int i, irq, vector;

        BUG_ON(gsi >= NR_IRQ_VECTORS);

        if (platform_legacy_irq(gsi)) {
                gsi_2_irq[gsi] = gsi;
                return gsi;
        }

        if (gsi_2_irq[gsi] != 0xFF)
                return (int)gsi_2_irq[gsi];

        vector = assign_irq_vector(gsi);
// this part here==========
        if (gsi < 16) {
                irq = gsi;
                gsi_2_irq[gsi] = irq;
        } else {
                irq = next_irq++;
                gsi_2_irq[gsi] = irq;
        }
//====================
        IO_APIC_VECTOR(irq) = vector;
        printk(KERN_INFO "GSI %d assigned vector 0x%02X and IRQ %d\n",
                        gsi, vector, irq);

        return irq;
}

(I took out the vector sharing part for clarity, just to concentrate on
compression, and I didn't do any boundary checks). The (gsi<16) takes
care of the recent problem with my ACPI IRQ compression patch breaking
VIA chipset that doesn't tolerate PCI IRQ numbers above 15.

I think this way we are saving more IRQs and place them denser.
Here is back-to-back comparison of IRQ distribution with the original
and modified patch:

Original:
           CPU0       CPU1       CPU2       CPU3
  0:      18758      20011      20008      28294    IO-APIC-edge  timer
  1:         97         18         79         16    IO-APIC-edge  i8042
  2:          0          0          0          0          XT-PIC
cascade
  8:          1          0          0          1    IO-APIC-edge  rtc
  9:          0          0          0          0    IO-APIC-edge  acpi
 12:          0        708          0        110    IO-APIC-edge  i8042
 15:          4          0          0         39    IO-APIC-edge  ide1
 16:          0          0          0          0   IO-APIC-level
uhci_hcd:usb1, uhci_hcd:usb4
 17:          0          0          0          3   IO-APIC-level
ohci1394
 18:        670       2253        836       1981   IO-APIC-level
libata, uhci_hcd:usb3
 19:          0          0          0          0   IO-APIC-level
uhci_hcd:usb2
 23:          0          0          0          0   IO-APIC-level
ehci_hcd:usb5
 48:        212          0          0          4   IO-APIC-level  eth0
<== gap on the 3nd io-apic
NMI:        117         71         73         51
LOC:      87020      86997      86975      86952
ERR:          3
MIS:          0

<7>IRQ to pin mappings:
<7>IRQ0 -> 0:2
<7>IRQ1 -> 0:1
<7>IRQ3 -> 0:3
<7>IRQ4 -> 0:4
<7>IRQ5 -> 0:5
<7>IRQ6 -> 0:6
<7>IRQ7 -> 0:7
<7>IRQ8 -> 0:8
<7>IRQ9 -> 0:9
<7>IRQ10 -> 0:10
<7>IRQ11 -> 0:11
<7>IRQ12 -> 0:12
<7>IRQ14 -> 0:14
<7>IRQ15 -> 0:15
<7>IRQ16 -> 0:16
<7>IRQ17 -> 0:17
<7>IRQ18 -> 0:18
<7>IRQ19 -> 0:19
<7>IRQ20 -> 0:20
<7>IRQ23 -> 0:23
<7>IRQ26 -> 1:2 <=======jump on the 2nd io-apic
<7>IRQ27 -> 1:3
<7>IRQ28 -> 1:4
<7>IRQ29 -> 1:5
<7>IRQ48 -> 2:0 <=======jump on the 3rd io-apic
<7>IRQ49 -> 2:1
<7>IRQ50 -> 2:2
<7>IRQ51 -> 2:3
<7>IRQ52 -> 2:4
<7>IRQ53 -> 2:5
<7>IRQ54 -> 2:6
<7>IRQ55 -> 2:7
<7>IRQ56 -> 2:8

Modified:
           CPU0       CPU1       CPU2       CPU3
  0:      15125      17509      17507      25592    IO-APIC-edge  timer
  1:        187         66        280        140    IO-APIC-edge  i8042
  2:          0          0          0          0          XT-PIC
cascade
  8:          1          0          0          1    IO-APIC-edge  rtc
  9:          0          0          0          0    IO-APIC-edge  acpi
 12:          0          0          0        110    IO-APIC-edge  i8042
 15:          4          0          0         39    IO-APIC-edge  ide1
 16:          0          0          0          0   IO-APIC-level
uhci_hcd:usb1, uhci_hcd:usb4
 17:          0          0          0          2   IO-APIC-level
ohci1394
 18:        753       2070        925       2035   IO-APIC-level
libata, uhci_hcd:usb3
 19:          0          0          0          0   IO-APIC-level
uhci_hcd:usb2
 21:          0          0          0          0   IO-APIC-level
ehci_hcd:usb5
 26:        164          0          0          4   IO-APIC-level  eth0
NMI:        117         72         73         52
LOC:      75682      75659      75638      75615
ERR:          3
MIS:          0

<7>IRQ to pin mappings:
<7>IRQ0 -> 0:2
<7>IRQ1 -> 0:1
<7>IRQ3 -> 0:3
<7>IRQ4 -> 0:4
<7>IRQ5 -> 0:5
<7>IRQ6 -> 0:6
<7>IRQ7 -> 0:7
<7>IRQ8 -> 0:8
<7>IRQ9 -> 0:9
<7>IRQ10 -> 0:10
<7>IRQ11 -> 0:11
<7>IRQ12 -> 0:12
<7>IRQ14 -> 0:14
<7>IRQ15 -> 0:15
<7>IRQ16 -> 0:16
<7>IRQ17 -> 0:17
<7>IRQ18 -> 0:18
<7>IRQ19 -> 0:19
<7>IRQ20 -> 0:20
<7>IRQ21 -> 0:23
<7>IRQ22 -> 1:2
<7>IRQ23 -> 1:3
<7>IRQ24 -> 1:4
<7>IRQ25 -> 1:5
<7>IRQ26 -> 2:0
<7>IRQ27 -> 2:1
<7>IRQ28 -> 2:2
<7>IRQ29 -> 2:3
<7>IRQ30 -> 2:4
<7>IRQ31 -> 2:5
<7>IRQ32 -> 2:6
<7>IRQ33 -> 2:7
<7>IRQ34 -> 2:8

Unfortunately, I cannot test the vector sharing part properly, since on
our systems we are just about to use up all 224 interrupts, but not
quiet. 
I have to mention that as far as I know Zwane is about to release his
vector sharing mechanism, he had it implemented and working for i386 (I
tested it on ES7000 successfully, by itself and combined with
compression patch too), and was planning implementing it for x86_64. I
am officially volunteering for testing it in its present state, for both
i386 and x86_64 (I can still do this on our systems by removing the IRQ
compression code :), hope this will help Zwane and Andi to release it as
soon as possible.

Regards,
--Natalie
