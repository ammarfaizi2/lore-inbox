Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267416AbUHWGEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267416AbUHWGEv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 02:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267443AbUHWGEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 02:04:51 -0400
Received: from fmr06.intel.com ([134.134.136.7]:23265 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S267416AbUHWGEq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 02:04:46 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: [ACPI] [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
Date: Mon, 23 Aug 2004 13:58:52 +0800
Message-ID: <B44D37711ED29844BEA67908EAF36F039EA6C2@pdsmsx401.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
Thread-Index: AcSG1B8NKA/yvNTfSIKG2utFIIsxDgAEsBHQAHtkvoA=
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       <stefandoesinger@gmx.at>, "Nathan Bryant" <nbryant@optonline.net>
Cc: "Brown, Len" <len.brown@intel.com>, <acpi-devel@lists.sourceforge.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 23 Aug 2004 06:03:43.0509 (UTC) FILETIME=[F1D87450:01C488D6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Right, this looks like the problem I encounter. My current test shows that the problem only occurs if ACPI changed LINK devices' IRQ. If ACPI use default LINK device IRQ, the problem went off.
Currently there are two workarounds:
1. comment one line in pci_link.c:acpi_pci_link_allocate, like below
	/*
	 * forget active IRQ that is not in possible list
	 */
	if (i == link->irq.possible_count) {
		if (acpi_strict)
			printk(KERN_WARNING PREFIX "_CRS %d not found"
				" in _PRS\n", link->irq.active);
+//		link->irq.active = 0;
	}
This disables rebalance IRQ, which fixes my problem.

2. change 'device_initcall(i8259A_init_sysfs);' to 'late_initcall(i8259A_init_sysfs);'
It seems that if OS changed BIOS IRQ router setting (like ACPI change Link device setting), IRQ router should resume before PIC. This possibly proves what Venki said.

PS. For the resume order, isn't it strange Local APIC resumes after PIT? I guess it should be the first device to resume.

Thanks,
Shaohua
>-----Original Message-----
>From: Pallipadi, Venkatesh
>Sent: Saturday, August 21, 2004 3:00 AM
>To: stefandoesinger@gmx.at; Nathan Bryant
>Cc: acpi-devel@lists.sourceforge.net; Brown, Len; Linux Kernel list; Li,
>Shaohua
>Subject: RE: [ACPI] [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
>
>
>
>
>>-----Original Message-----
>>From: acpi-devel-admin@lists.sourceforge.net
>>[mailto:acpi-devel-admin@lists.sourceforge.net] On Behalf Of
>>Stefan Dösinger
>>Sent: Friday, August 20, 2004 9:36 AM
>>To: Nathan Bryant
>>Cc: acpi-devel@lists.sourceforge.net; Brown, Len; Linux Kernel
>>list; Li, Shaohua
>>Subject: Re: [ACPI] [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
>>
>>Am Freitag, 20. August 2004 14:18 schrieb Nathan Bryant:
>>> Stefan -
>>>
>>> Also - did suspend/resume for the ipw2100 ever work under any kernel
>>> version?
>>Yes, it works with acpi=noirq at least up to 2.6.7(not tested
>>with later
>>versions, but I'm sure it does)
>>It works with 2.6.8-rc2 and 2.6.8-rc4 and 2.6.8.1 with acpi IRQs and a
>>modified dsdt which forces LNKE to IRQ 10. I attached a dmesg
>>output of a
>>successful resume.
>>
>>Cheers,
>>Stefan
>
>This seems to be the same resume order issue, that Shaohua is hitting.
>
>On my system the resume order looks like this:
>Resuming System Devices
>Resuming type 'cpu':
> cpu0
>aux driver resume 0xc010e410 (mtrr_restore)
>aux driver resume 0xc03365f0 (cpufreq_resume)
>Resuming type 'i8259':
> i82590
>Resuming type 'timer':
> timer0
>Resuming type 'pit':
> pit0
>Resuming type 'lapic':
> lapic0
>Resuming type 'irqrouter':
> irqrouter0
>Resuming type 'i8042':
> i80420
>
>The current theory I have for this issue is we resume pci_link driver
>A bit too late, which is causing this problem.
>
>Say a particular device doesn't do anything for suspend and resume.
>So, as soon as we resume this particular device can start
>generating interrupts. Once we have PIC enabled, it starts sending
>interrupts and no one handles that original IRQ. As pci_link that
>resumes later is reprogramming the device to different IRQ, where the
>driver is handling the device.
>
>That's probably the reason why it works with acpi=noirq or
>modified DSDT. Does it make sense?
>
>I think we have to resume pci_link device before PIC.
>We should be able to achieve this my changing the makefile orders.
>
>Thanks,
>Venki
>
