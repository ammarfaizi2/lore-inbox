Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945928AbWJSAnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945928AbWJSAnT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 20:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945929AbWJSAnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 20:43:19 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:58401 "EHLO
	pd5mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1945928AbWJSAnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 20:43:18 -0400
Date: Wed, 18 Oct 2006 18:42:02 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: ASUS M2NPV-VM APIC/ACPI Bug (patched)
In-reply-to: <fa.1/QTOTFQC91cwKwinVDxrePnGHo@ifi.uio.no>
To: Len Brown <lenb@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Daniel Mierswa <impulze@impulze.org>, Andi Kleen <ak@suse.de>,
       Andy Currid <acurrid@nvidia.com>
Message-id: <4536C9DA.4060704@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-15; format=flowed
Content-transfer-encoding: 7bit
References: <fa.09mXx81eXfIStK3wap/U1OZn+kg@ifi.uio.no>
 <fa.1/QTOTFQC91cwKwinVDxrePnGHo@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown wrote:
> On Wednesday 18 October 2006 02:44, Daniel Mierswa wrote:
>> Some people have deeper problems with the Asus M2NPV-VM mainboard
>> (rather the chipset of the mainboard).
>> A google for "Asus M2NPV-VM apic" shows that. I'm one of them,
>> desperately searching a way to fix that, using that board with an AMD
>> Athlon64 X2 3800+ Dual Core Processor.
>> It wouldn't boot because of APIC and ACPI errors. There were "kind of"
>> workarounds by passing acpi=off/noirq and noapic to the kernel which
>> resulted in sometimes bad internal clock. I for myself had the same
>> problem and due to the error with my internal system clock all
>> applications and drivers gone mad, including
>> sound,video,graphics,usb,etc.. I googled around and saw the following:
>> http://lkml.org/lkml/2006/8/13/25
>> Actually that was a patch created for the 2.6.18-rc4 kernel. I tried
>> several kernels all with the same results. Some of them are
>> 2.6.18-mm3, 2.6.19-rc2, 2.6.17, 2.6.18, 2.6.18.1, some gentoo patched
>> sources and what not. All will hang after the io scheduler gets loaded,
>> passing acpi=off/noirq to the kernel will workaround that one. Then it
>> will boot on and finally reach the ochi_hcd driver which will not load
>> because of shared IRQ problems, passing nousb to the kernel will
>> workaround that. It will boot more and come to the dhcp client, where it
>> fails because of an Interrupt error.
>> Some people passing noapic acpi=off/noirq to the kernel got later sound
>> problems, they fixed that by passing "snd-hda-intel model=3stack
>> position_fix=1" which worked around that interrupt problem. So with the
>> patch provided on http://lkml.org/lkml/2006/8/13/25 it all works out.
>> The internal system clock works just fine, the drivers load
>>  all fine, no need to patch the sound,graphics or anything at all. No
>> need for kernel parameters either. Here's the patch again, created by
>> diff -ur on the current 2.6.18.1 kernel:
>>
>> --- io_apic.c.orig	2006-10-18 08:02:50.000000000 +0200
>> +++ io_apic.c	2006-10-18 07:40:48.000000000 +0200
>> @@ -337,12 +337,12 @@
>>  					nvidia_hpet_detected = 0;
>>  					acpi_table_parse(ACPI_HPET,
>>  							nvidia_hpet_check);
>> -					if (nvidia_hpet_detected == 0) {
>> +/*					if (nvidia_hpet_detected == 0) {
>>  						acpi_skip_timer_override = 1;
>>  						printk(KERN_INFO "Nvidia board "
>>  						    "detected. Ignoring ACPI "
>>  						    "timer override.\n");
>> -					}
>> +					}*/
>>  #endif
> 
> I recall quite clearly that Nvidia told us that that acpi_skip_timer_override
> was necessary in NFORCE2 days.  I don't remember the HPET qualification to
> that statement -- I guess that came later.
> Unfortunately, my NFORCE2 board is dead, so I can't really test this out directly.
> 
> Perhaps checking for PCI_VENDOR_ID_NVIDIA is too broad and the workaround
> is counter-productive on their newer NVIDIA chip-sets?
> 
> -Len
> 
> ps.
> One (other) problem with this code is that it checks for an HPET table,
> but doesn't check that the kernel has HPET support enabled.

I think the intent of the HPET check was that the quirk wasn't needed on 
chipsets new enough to have an HPET. Unfortunately, even if the chipset 
has an HPET it isn't always enabled by the BIOS.

Clearly this quirk is too broad, it should likely be only triggering on 
known chipset revisions with the bad timer overrides and not on all 
NVIDIA chipsets. What I am wondering is how these boards manage to work 
fine in Windows, (presumably) without any such chipset-specific tweaks..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

