Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268689AbUHTTGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268689AbUHTTGy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 15:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266003AbUHTTDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 15:03:48 -0400
Received: from fmr05.intel.com ([134.134.136.6]:42695 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S268679AbUHTTAr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 15:00:47 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: [ACPI] [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
Date: Fri, 20 Aug 2004 12:00:18 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB6002A934AC@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
Thread-Index: AcSG1B8NKA/yvNTfSIKG2utFIIsxDgAEsBHQ
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <stefandoesinger@gmx.at>, "Nathan Bryant" <nbryant@optonline.net>
Cc: <acpi-devel@lists.sourceforge.net>, "Brown, Len" <len.brown@intel.com>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Li, Shaohua" <shaohua.li@intel.com>
X-OriginalArrivalTime: 20 Aug 2004 19:00:17.0406 (UTC) FILETIME=[EEBBA9E0:01C486E7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




>-----Original Message-----
>From: acpi-devel-admin@lists.sourceforge.net 
>[mailto:acpi-devel-admin@lists.sourceforge.net] On Behalf Of 
>Stefan Dösinger
>Sent: Friday, August 20, 2004 9:36 AM
>To: Nathan Bryant
>Cc: acpi-devel@lists.sourceforge.net; Brown, Len; Linux Kernel 
>list; Li, Shaohua
>Subject: Re: [ACPI] [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
>
>Am Freitag, 20. August 2004 14:18 schrieb Nathan Bryant:
>> Stefan -
>>
>> Also - did suspend/resume for the ipw2100 ever work under any kernel
>> version?
>Yes, it works with acpi=noirq at least up to 2.6.7(not tested 
>with later 
>versions, but I'm sure it does)
>It works with 2.6.8-rc2 and 2.6.8-rc4 and 2.6.8.1 with acpi IRQs and a 
>modified dsdt which forces LNKE to IRQ 10. I attached a dmesg 
>output of a 
>successful resume.
>
>Cheers,
>Stefan

This seems to be the same resume order issue, that Shaohua is hitting.

On my system the resume order looks like this:
Resuming System Devices
Resuming type 'cpu':
 cpu0
aux driver resume 0xc010e410 (mtrr_restore)
aux driver resume 0xc03365f0 (cpufreq_resume)
Resuming type 'i8259':
 i82590
Resuming type 'timer':
 timer0
Resuming type 'pit':
 pit0
Resuming type 'lapic':
 lapic0
Resuming type 'irqrouter':
 irqrouter0
Resuming type 'i8042':
 i80420

The current theory I have for this issue is we resume pci_link driver
A bit too late, which is causing this problem.

Say a particular device doesn't do anything for suspend and resume.
So, as soon as we resume this particular device can start  
generating interrupts. Once we have PIC enabled, it starts sending 
interrupts and no one handles that original IRQ. As pci_link that 
resumes later is reprogramming the device to different IRQ, where the 
driver is handling the device.

That's probably the reason why it works with acpi=noirq or 
modified DSDT. Does it make sense?

I think we have to resume pci_link device before PIC. 
We should be able to achieve this my changing the makefile orders.

Thanks,
Venki
 
