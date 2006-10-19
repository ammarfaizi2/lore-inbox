Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751502AbWJSMlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbWJSMlV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 08:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWJSMlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 08:41:21 -0400
Received: from ns.suse.de ([195.135.220.2]:5860 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751502AbWJSMlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 08:41:20 -0400
From: Andi Kleen <ak@suse.de>
To: Len Brown <lenb@kernel.org>
Subject: Re: ASUS M2NPV-VM APIC/ACPI Bug (patched)
Date: Thu, 19 Oct 2006 14:41:07 +0200
User-Agent: KMail/1.9.3
Cc: Daniel Mierswa <impulze@impulze.org>, Andy Currid <acurrid@nvidia.com>,
       linux-kernel@vger.kernel.org
References: <4535CD32.2010502@impulze.org> <200610180330.52565.len.brown@intel.com>
In-Reply-To: <200610180330.52565.len.brown@intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610191441.07468.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 October 2006 09:30, Len Brown wrote:
> On Wednesday 18 October 2006 02:44, Daniel Mierswa wrote:
> > Some people have deeper problems with the Asus M2NPV-VM mainboard
> > (rather the chipset of the mainboard).
> > A google for "Asus M2NPV-VM apic" shows that. I'm one of them,
> > desperately searching a way to fix that, using that board with an AMD
> > Athlon64 X2 3800+ Dual Core Processor.
> > It wouldn't boot because of APIC and ACPI errors. There were "kind of"
> > workarounds by passing acpi=off/noirq and noapic to the kernel which
> > resulted in sometimes bad internal clock. I for myself had the same
> > problem and due to the error with my internal system clock all
> > applications and drivers gone mad, including
> > sound,video,graphics,usb,etc.. I googled around and saw the following:
> > http://lkml.org/lkml/2006/8/13/25
> > Actually that was a patch created for the 2.6.18-rc4 kernel. I tried
> > several kernels all with the same results. Some of them are
> > 2.6.18-mm3, 2.6.19-rc2, 2.6.17, 2.6.18, 2.6.18.1, some gentoo patched
> > sources and what not. All will hang after the io scheduler gets loaded,
> > passing acpi=off/noirq to the kernel will workaround that one. Then it
> > will boot on and finally reach the ochi_hcd driver which will not load
> > because of shared IRQ problems, passing nousb to the kernel will
> > workaround that. It will boot more and come to the dhcp client, where it
> > fails because of an Interrupt error.
> > Some people passing noapic acpi=off/noirq to the kernel got later sound
> > problems, they fixed that by passing "snd-hda-intel model=3stack
> > position_fix=1" which worked around that interrupt problem. So with the
> > patch provided on http://lkml.org/lkml/2006/8/13/25 it all works out.
> > The internal system clock works just fine, the drivers load
> >  all fine, no need to patch the sound,graphics or anything at all. No
> > need for kernel parameters either. Here's the patch again, created by
> > diff -ur on the current 2.6.18.1 kernel:
> > 
> > --- io_apic.c.orig	2006-10-18 08:02:50.000000000 +0200
> > +++ io_apic.c	2006-10-18 07:40:48.000000000 +0200
> > @@ -337,12 +337,12 @@
> >  					nvidia_hpet_detected = 0;
> >  					acpi_table_parse(ACPI_HPET,
> >  							nvidia_hpet_check);
> > -					if (nvidia_hpet_detected == 0) {
> > +/*					if (nvidia_hpet_detected == 0) {
> >  						acpi_skip_timer_override = 1;
> >  						printk(KERN_INFO "Nvidia board "
> >  						    "detected. Ignoring ACPI "
> >  						    "timer override.\n");
> > -					}
> > +					}*/
> >  #endif
> 
> I recall quite clearly that Nvidia told us that that acpi_skip_timer_override
> was necessary in NFORCE2 days.  I don't remember the HPET qualification to
> that statement -- I guess that came later.
> Unfortunately, my NFORCE2 board is dead, so I can't really test this out directly.
> 
> Perhaps checking for PCI_VENDOR_ID_NVIDIA is too broad and the workaround
> is counter-productive on their newer NVIDIA chip-sets?

I suppose Asus just "forgot" again to enable the HPET in their NF5 BIOS.
In general they seem to hate ACPI tables -- near all their mcfg tables are broken 
too. Maybe we need to define the ASUS subset of ACPI (just kidding) @) 

Anyways, I suppose we'll need a list of all unique PCI IDs for NF3,NF4 to key this 
workaround on. Andy do you have a complete list?

>ps.
>One (other) problem with this code is that it checks for an HPET table,
>but doesn't check that the kernel has HPET support enabled.

Keying on PCI-IDs would fix that too.

-Andi
