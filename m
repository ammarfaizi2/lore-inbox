Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755449AbWKNRVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755449AbWKNRVK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 12:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965844AbWKNRVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 12:21:10 -0500
Received: from mga03.intel.com ([143.182.124.21]:19217 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1755453AbWKNRVI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 12:21:08 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,421,1157353200"; 
   d="scan'208"; a="146068826:sNHT23650599"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: CONFIG_NO_HZ: missed ticks, stall (keyb IRQ required) [2.6.18-rc4-mm1]
Date: Tue, 14 Nov 2006 09:21:02 -0800
Message-ID: <EB12A50964762B4D8111D55B764A8454E0DBDE@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: CONFIG_NO_HZ: missed ticks, stall (keyb IRQ required) [2.6.18-rc4-mm1]
Thread-Index: AccHtpEuQIyk5TwATYiXFELns4lp4gAWB3cA
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Len Brown" <lenb@kernel.org>, "Ingo Molnar" <mingo@elte.hu>
Cc: "Andreas Mohr" <andi@rhlx01.fht-esslingen.de>,
       "Thomas Gleixner" <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
       "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
X-OriginalArrivalTime: 14 Nov 2006 17:21:04.0605 (UTC) FILETIME=[43AA50D0:01C70811]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>-----Original Message-----
>From: Len Brown [mailto:len.brown@intel.com] 
>Sent: Monday, November 13, 2006 10:34 PM
>To: Ingo Molnar
>Cc: Len Brown; Andreas Mohr; Thomas Gleixner; 
>linux-kernel@vger.kernel.org; Pallipadi, Venkatesh
>Subject: Re: CONFIG_NO_HZ: missed ticks, stall (keyb IRQ 
>required) [2.6.18-rc4-mm1]
>
>On Tuesday 07 November 2006 03:07, Ingo Molnar wrote:
>> > So given that C3 on every known system that has shipped to 
>date breaks 
>> > the LAPIC timer (and apparently this applies to C2 on these AMD 
>> > boxes), dynticks needs a solid story for co-existing with C3.
>> 
>> check out 2.6.19-rc4-mm2: it detects this breakage and works 
>it around 
>> by using the PIT as a clock-events source. That did the trick on my 
>> laptop which has this problem too. I agree with you that 
>degrading the 
>> powersaving mode is not an option.
>> 
>> we've got a question about HPET: it seems all recent 
>hardware has it, 
>> but the BIOS rarely mentions it, so the Linux driver does not enable 
>> HPET. Is there any chance to enable HPET (in the chipset?) - 
>this would 
>> probably be a higher-quality clock-events source than the PIT.
>
>If Windows enumerates and uses the HPET on a box, then Linux
>should be able to use the HPET on that box too.
>
>I belive that Venki has looked at some of the HPET enumeration issues,
>and maybe he has some suggestions.  Is there an example system
>on-hand where we know Windows works and Linux does not?
>

There are two things that can be happening when OS does not see HPET in
ACPI.
- BIOS did enable HPET in chipset and did not communicate it to OS.
- BIOS did nothing to enable HPET in chipset.

The quirk below tries to find the HPET base address in case 1. But in
case 2 this will also fail as HPTC will be 0 below (Probably we can
still assume default base address of 0xFED00000 and probe there. But I
am still checking on that). I just added couple of chipset ids that I
could test on...

On the systems that I tested, HPTC was zero (case 2 above) and patch
below did not really help.

I am building on this patch to enable HPET in late init stage based on
the the quirk information. Will be interesting to see what this patch
says on other ICH based systems that don't have HPET info in ACPI.

Thanks,
Venki

--------------

PCI quirk to force enable HPET, even when BIOS does not report it
to OS in traditional ACPI table way.

Only handles few PCI_IDS at the moment. If we need it for wider use, we
should add all ICH7, ICH8, ICH9 (may be ICH6 as well) IDs.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.19-rc-mm/arch/i386/kernel/quirks.c
===================================================================
--- linux-2.6.19-rc-mm.orig/arch/i386/kernel/quirks.c
+++ linux-2.6.19-rc-mm/arch/i386/kernel/quirks.c
@@ -48,3 +48,34 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_IN
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,
PCI_DEVICE_ID_INTEL_E7525_MCH,	quirk_intel_irqbalance);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,
PCI_DEVICE_ID_INTEL_E7520_MCH,	quirk_intel_irqbalance);
 #endif
+
+static void __init force_enable_hpet(struct pci_dev *dev)
+{
+	u32 val, rcba, addr;
+	void __iomem *base;
+
+	pci_read_config_dword(dev, 0xF0, &rcba);
+	/* use bits 31:14, 16 kB aligned */
+	base = ioremap_nocache(rcba & 0xFFFFC000, 0x4000);
+	printk("HPTC: RCBA Base is 0x%x\n", rcba & 0xFFFFC000);
+	if (base == NULL)
+		return;
+
+	/* read the Function Disable register, dword mode only */
+	val=readl(base + 0x3404);
+	printk("HPTC: RCBA 0x3404 is 0x%x\n", val);
+
+	if (!(val & 0x80))
+		return;
+
+	printk("HPTC: HPTC enabled\n");
+
+	val = val & 0x3;
+	addr = 0xFED00000 | (val << 12);
+	iounmap(base);
+	printk("HPTC: HPET located at 0x%x\n", addr);
+}
+
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,
PCI_DEVICE_ID_INTEL_ICH6_1,     force_enable_hpet);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,
PCI_DEVICE_ID_INTEL_ESB2_0,     force_enable_hpet);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,
PCI_DEVICE_ID_INTEL_ICH7_31,     force_enable_hpet);
