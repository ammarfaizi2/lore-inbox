Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269260AbUI3Pns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269260AbUI3Pns (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 11:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269303AbUI3Pns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 11:43:48 -0400
Received: from hqemgate00.nvidia.com ([216.228.112.144]:41995 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S269260AbUI3Pno convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 11:43:44 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: nforce2 bugs?
Date: Thu, 30 Sep 2004 08:43:05 -0700
Message-ID: <8E5ACAE05E6B9E44A2903C693A5D4E8A01C45A1C@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: nforce2 bugs?
Thread-Index: AcSm+fCDlx0QMyC8TaKjTkFKPDWxVwACHM5g
From: "Andy Currid" <ACurrid@nvidia.com>
To: "Maciej W. Rozycki" <macro@linux-mips.org>,
       "Prakash K. Cheemplavam" <prakashkc@gmx.de>,
       "Allen Martin" <AMartin@nvidia.com>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "white phoenix" <white.phoenix@gmail.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 Sep 2004 15:43:02.0746 (UTC) FILETIME=[2BA99BA0:01C4A704]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm taking a look at the patches discussed in other recent emails on the
list, but I'm curious about the timer issue that Maciej notes here. In
systems running in IOAPIC mode where this problem has been observed, is
ACPI enabled?

I strongly suspect that it is. Some BIOSes on nForce systems contain an
incorrect INT override for the timer interrupt in their ACPI tables,
indicating that in IOAPIC mode the timer interrupts on IRQ2 rather than
IRQ0. The kernel honors the override, then notices the timer interrupt
isn't working and subsequently rescues the situation by configuring the
timer in ExtInt mode. That recovers the timer interrupt but I suspect
that configuration may be responsible for the "noisy" behavior (it's a
faulty configuration).

The workaround for the faulty override in IOAPIC/ACPI mode is to specify
acpi_skip_timer_override as a boot parameter.

If anyone has a system that is exhibiting the noisy behavior, I'd be
interested to hear if this workaround addresses the problem. I haven't
seen this specific behavior on my own nForce2 systems.

Regards

Andy
--
Andy Currid, NVIDIA Corporation 
acurrid@nvidia.com   408 566 6743


> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Maciej W. Rozycki
> Sent: Thursday, September 30, 2004 07:24
> To: Prakash K. Cheemplavam; Allen Martin
> Cc: Alan Cox; white phoenix; Linux Kernel Mailing List
> Subject: Re: nforce2 bugs?
> 
> 
> On Thu, 30 Sep 2004, Prakash K. Cheemplavam wrote:
> 
> > The only problem is the apic timer thing. It just gets 
> activated if the
> > correct BIOS Version is found (see the dmi scan thingie). 
> So I just pass
> > acpi_skip_timer_override to the kernel to be sure.
> 
>  There appears to be another timer problem, too -- at least for some
> boards the system timer (the 8254 PIT) has a noisy output.  
> When routed to
> an I/O APIC input it makes the system time go fast enough the 
> NTP daemon
> isn't able to compensate (it's a few minutes per day fast).  
> The problem
> goes away when routing it to the 8259A PIC, presumably 
> because the 8259A
> inputs are not "sticky" in the edge-triggered mode -- at the worst you
> only get spurious interrupts reported in /proc/interrupts in the "ERR"
> counter.
> 
>  An nVidia feedback would be appreciated.  Allen?
> 
>   Maciej
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
