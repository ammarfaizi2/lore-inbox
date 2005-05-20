Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVETQer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVETQer (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 12:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261480AbVETQer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 12:34:47 -0400
Received: from usbb-lacimss1.unisys.com ([192.63.108.51]:15885 "EHLO
	usbb-lacimss1.unisys.com") by vger.kernel.org with ESMTP
	id S261382AbVETQe0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 12:34:26 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 1/1] Proposed: Let's not waste precious IRQs...
Date: Fri, 20 May 2005 11:34:04 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04B9E@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 1/1] Proposed: Let's not waste precious IRQs...
Thread-Index: AcVdQkS5h/thlQ19RRub6cKOsEc5VwAFPVYg
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Ashok Raj" <ashok.raj@intel.com>
Cc: <akpm@osdl.org>, <ak@suse.de>, <zwane@arm.linux.org.uk>,
       "Brown, Len" <len.brown@intel.com>, <bjorn.helgaas@hp.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 May 2005 16:34:05.0282 (UTC) FILETIME=[BCE98420:01C55D59]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Hi Natalie,
> 
> have you taken a look a the Vector Sharing Patch posted by 
> Kaneshige for IA64?
> 
> Cheers,
> ashok

Ashok,
I did initial testing of Zwane's IA-32 vector sharing patch, which
worked beautifully for the test case I mentioned. Here is the IRQ
snapshot on the same system booted as IA-32 with Zwane's patch applied:
zorro-tb2:~ # cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3       CPU4       CPU5
CPU6       CPU7
  0:      21287      95050          0          0          0          0
0          0    IO-APIC-edge  timer
  4:         35          0          0          0          0          0
0          0    IO-APIC-edge  serial
  8:          2          0          0          0          0          0
0          0    IO-APIC-edge  rtc
  9:          1          0          0          0          0          0
0          0   IO-APIC-level  acpi
 14:         42          0          0          0          0          0
0          0    IO-APIC-edge  ide0
 16:        166          0          0          0          0          0
0          0   IO-APIC-level  uhci_hcd:usb1
 18:          0          0          0          0          0          0
0          0   IO-APIC-level  uhci_hcd:usb3
 19:         13          0          0          0          0          0
0          0   IO-APIC-level  uhci_hcd:usb2
 22:          3          0          0          0          0          0
0          0   IO-APIC-level  ohci1394
 23:          3          0          0          0          0          0
0          0   IO-APIC-level  ehci_hcd:usb4
 96:       4531          0          0          0          0          0
0          0   IO-APIC-level  aic7xxx
 97:         15          0          0          0          0          0
0          0   IO-APIC-level  aic7xxx
192:        319          0          0          0          0          0
0          0   IO-APIC-level  eth0
480:        197          0          0          0          0          0
0          0   IO-APIC-level  eth1
NMI:          0          0          0          0          0          0
0          0
LOC:     112387     113275     108500     112878     113213     113158
113272     113249
ERR:          0
MIS:          0

After I applied my patch on top of his patch, the picture became:

zorro-tb2:~ # cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3       CPU4       CPU5
CPU6       CPU7
  0:      21339      82235          0          0          0          0
0          0    IO-APIC-edge  timer
  4:         13          0          0          0          0          0
0          0    IO-APIC-edge  serial
  8:          2          0          0          0          0          0
0          0    IO-APIC-edge  rtc
  9:          1          0          0          0          0          0
0          0   IO-APIC-level  acpi
 14:         42          0          0          0          0          0
0          0    IO-APIC-edge  ide0
 16:          0          0          0          0          0          0
0          0   IO-APIC-level  uhci_hcd:usb3
 17:       4533          0          0          0          0          0
0          0   IO-APIC-level  aic7xxx
 18:         15          0          0          0          0          0
0          0   IO-APIC-level  aic7xxx
 21:        172          0          0          0          0          0
0          0   IO-APIC-level  uhci_hcd:usb1
 22:         13          0          0          0          0          0
0          0   IO-APIC-level  uhci_hcd:usb2
 23:          3          0          0          0          0          0
0          0   IO-APIC-level  ehci_hcd:usb4
 24:          3          0          0          0          0          0
0          0   IO-APIC-level  ohci1394
 25:        252          0          0          0          0          0
0          0   IO-APIC-level  eth0
 26:        115          0          0          0          0          0
0          0   IO-APIC-level  eth1
NMI:          0          0          0          0          0          0
0          0
LOC:      99762     100508      95782     100288     100309     100517
100550     100349
ERR:          0
MIS:          0

So, there is no conflict between the two, and when it's fully
implemented, tested, and incorporated into the source (and into x86_64),
well, we still will have IRQs numbers utilized better per node.
Thanks,
--Natalie

I actually tested the code I'm offering with Zwane's IA-32 vector
sharing patch. By the way, I tested hi 
> On Thu, May 19, 2005 at 04:06:13AM -0700, 
> Natalie.Protasevich@unisys.com wrote:
> > 
> >    I  suggest  to  change  the  way  IRQs  are handed out 
> to PCI devices.
> >    Currently, each I/O APIC pin gets associated with an 
> IRQ, no matter if
> >    the  pin  is used or not. It is expected that each pin 
> can potentually
> >    be  engaged  by  a  device  inserted  into the 
> corresponding PCI slot.
> >    However,  this  imposes severe limitation on systems 
> that have designs
> >    that employ many  I/O APICs, only utilizing couple lines 
> of each, such
> >    as P64H2 chipset. It is used in ES7000, and currently, 
> there is no way
> >    to boot the system with more that 9 I/O APICs. The 
> simple change below
> >    allows  to  boot  a  system  with  say  64  (or  more) 
> I/O APICs, each
> >    providing  1  slot, which otherwise impossible because 
> of the IRQ gaps
> >    created  for  unused  lines  on each I/O APIC. It does 
> not resolve the
> >    problem  with  number of devices that exceeds number of 
> possible IRQs,
> >    but  eases  up a tension for IRQs on any large system 
> with potentually
> >    large  number  of  devices. I only implemented this for 
> the ACPI boot,
> >    since if the system is this big and .. deleted...
> 
