Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbUCHJPr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 04:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262317AbUCHJPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 04:15:47 -0500
Received: from fmr05.intel.com ([134.134.136.6]:45713 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S262298AbUCHJPF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 04:15:05 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] fix PCI interrupt setting for ia64
Date: Mon, 8 Mar 2004 17:14:58 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8401B1A019@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] fix PCI interrupt setting for ia64
Thread-Index: AcQE51Dlg+7v+nSiSlaAPiaCO7eOKwABiIQw
From: "Liu, Benjamin" <benjamin.liu@intel.com>
To: "Kenji Kaneshige" <kaneshige.kenji@jp.fujitsu.com>,
       <linux-ia64@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Mar 2004 09:14:59.0265 (UTC) FILETIME=[D487DB10:01C404ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the information, Kenji. But is there any reason to leave it unmasked in iosapic_register_intr(), iosapic_register_platform_intr(), iosapic_override_isa_irq(), given the fact that they would be unmasked finally in individual device drivers?

Thanks,
Pingping (Benjamin) Liu
Intel China Software Center


>-----Original Message-----
>From: Kenji Kaneshige [mailto:kaneshige.kenji@jp.fujitsu.com] 
>Sent: 2004年3月8日 16:31
>To: Liu, Benjamin; Kenji Kaneshige; linux-ia64@vger.kernel.org
>Cc: linux-kernel@vger.kernel.org
>Subject: RE: [PATCH] fix PCI interrupt setting for ia64
>
>
>Hi Liu,
>
>I think it is not converse.
>What I wanted to do was to mask (disable) IRQ in iosapic_enable_intr().
>I think PCI IRQ should be unmasked (enabled) by device driver, not by
>iosapic_enable_intr() at the boot time.
>
>Regards,
>Kenji Kaneshige
>
>> -----Original Message-----
>> From: linux-ia64-owner@vger.kernel.org
>> [mailto:linux-ia64-owner@vger.kernel.org]On Behalf Of Liu, Benjamin
>> Sent: Monday, March 08, 2004 4:34 PM
>> To: Kenji Kaneshige; linux-ia64@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Subject: RE: [PATCH] fix PCI interrupt setting for ia64
>>
>>
>> Hi, Kenji,
>>
>> I am a little bit confused with the patch:
>> Mask bit of RDL's low word indicates the interrupt is enabled
>> when it is zero, disabled when it is 1. But from the patch below,
>> it seems that Kenji enable interrupts in iosapic_register_intr(),
>> iosapic_register_platform_intr(), iosapic_override_isa_irq(), and
>> disable the interrupt in iosapic_enable_intr(). Is it converse?
>>
>> Thanks,
>> Pingping (Benjamin) Liu
>> Intel China Software Center
>>
>>
>> >-----Original Message-----
>> >From: linux-ia64-owner@vger.kernel.org
>> >[mailto:linux-ia64-owner@vger.kernel.org] On Behalf Of 
>Kenji Kaneshige
>> >Sent: 2004年3月8日 10:49
>> >To: linux-ia64@vger.kernel.org
>> >Cc: linux-kernel@vger.kernel.org
>> >Subject: [PATCH] fix PCI interrupt setting for ia64
>> >
>> >
>> >Hi,
>> >
>> >In ia64 kernel, IOSAPIC's RTEs for PCI interrupts are 
>unmasked at the
>> >boot time before installing device drivers. I think it is very
>> >dangerous.
>> >If some PCI devices without device driver generate interrupts,
>> >interrupts
>> >are generated repeatedly because these interrupt requests are never
>> >cleared. I think RTEs for PCI interrupts should be unmasked 
>by device
>> >driver.
>> >
>> >A following patch fixes this issue.
>> >
>> >Regards,
>> >Kenji Kaneshige
>> >
>> >
>> >diff -Naur linux-2.6.4-rc2/arch/ia64/kernel/iosapic.c
>> >linux-2.6.4-rc2-changed/arch/ia64/kernel/iosapic.c
>> >--- linux-2.6.4-rc2/arch/ia64/kernel/iosapic.c  2004-03-05
>> >15:13:53.155237277 +0900
>> >+++ linux-2.6.4-rc2-changed/arch/ia64/kernel/iosapic.c  2004-03-05
>> >16:48:31.856142526 +0900
>> >@@ -170,7 +170,7 @@
>> > }
>> >
>> > static void
>> >-set_rte (unsigned int vector, unsigned int dest)
>> >+set_rte (unsigned int vector, unsigned int dest, int mask)
>> > {
>> >        unsigned long pol, trigger, dmode;
>> >        u32 low32, high32;
>> >@@ -205,6 +205,7 @@
>> >        low32 = ((pol << IOSAPIC_POLARITY_SHIFT) |
>> >                 (trigger << IOSAPIC_TRIGGER_SHIFT) |
>> >                 (dmode << IOSAPIC_DELIVERY_SHIFT) |
>> >+                ((mask ? 1 : 0) << IOSAPIC_MASK_SHIFT) |
>> >                 vector);
>> >
>> >        /* dest contains both id and eid */
>> >@@ -509,7 +510,7 @@
>> >               (trigger == IOSAPIC_EDGE ? "edge" : "level"),
>> >dest, vector);
>> >
>> >        /* program the IOSAPIC routing table */
>> >-       set_rte(vector, dest);
>> >+       set_rte(vector, dest, 0);
>> >        return vector;
>> > }
>> >
>> >@@ -557,7 +558,7 @@
>> >               (trigger == IOSAPIC_EDGE ? "edge" : "level"),
>> >dest, vector);
>> >
>> >        /* program the IOSAPIC routing table */
>> >-       set_rte(vector, dest);
>> >+       set_rte(vector, dest, 0);
>> >        return vector;
>> > }
>> >
>> >@@ -583,7 +584,7 @@
>> >            trigger == IOSAPIC_EDGE ? "edge" : "level", 
>dest, vector);
>> >
>> >        /* program the IOSAPIC routing table */
>> >-       set_rte(vector, dest);
>> >+       set_rte(vector, dest, 0);
>> > }
>> >
>> > void __init
>> >@@ -669,7 +670,7 @@
>> >        /* direct the interrupt vector to the running cpu id */
>> >        dest = (ia64_getreg(_IA64_REG_CR_LID) >> 16) & 0xffff;
>> > #endif
>> >-       set_rte(vector, dest);
>> >+       set_rte(vector, dest, 1);
>> >
>> >        printk(KERN_INFO "IOSAPIC: vector %d -> CPU 0x%04x, 
>enabled\n",
>> >               vector, dest);
>> >
>> >-
>> >To unsubscribe from this list: send the line "unsubscribe
>> >linux-ia64" in
>> >the body of a message to majordomo@vger.kernel.org
>> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>linux-ia64" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
