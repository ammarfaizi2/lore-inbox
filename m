Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267995AbUHFAzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267995AbUHFAzO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 20:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268037AbUHFAzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 20:55:14 -0400
Received: from fmr06.intel.com ([134.134.136.7]:52882 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S267995AbUHFAzA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 20:55:00 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Automatically enable bigsmp on big HP machines
Date: Thu, 5 Aug 2004 17:54:25 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB600289B2DC@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Automatically enable bigsmp on big HP machines
Thread-Index: AcR66flDYTVLjPMsQYGaRkvx6V4WkwAYBhrA
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Andi Kleen" <ak@suse.de>, <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Aug 2004 00:54:27.0211 (UTC) FILETIME=[EC6855B0:01C47B4F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Instead of handling these individually for particular systems, 
can't we just switch to bigsmp whenever we see more than 8 CPU 
in the CPU enumeration and no other subarchitecture is selected by 
any dmi override.

I had some patch that does soemthing like this, a while back. If 
you are OK with the idea, I can dig out that patch and send it. 

Thanks,
Venki

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Andi Kleen
>Sent: Thursday, August 05, 2004 5:39 AM
>To: akpm@osdl.org
>Cc: linux-kernel@vger.kernel.org
>Subject: [PATCH] Automatically enable bigsmp on big HP machines
>
>
>This enables apic=bigsmp automatically on some big HP machines 
>that need it. 
>This makes them boot without kernel parameters on a generic 
>arch kernel.
>
>Also it removes an unnecessary panic in the same area.
>
>-Andi
>
>diff -u linux-2.6.7/arch/i386/kernel/dmi_scan.c-HP 
>linux-2.6.7/arch/i386/kernel/dmi_scan.c
>--- linux-2.6.7/arch/i386/kernel/dmi_scan.c-HP	2004-08-05 
>14:00:29.325072566 +0200
>+++ linux-2.6.7/arch/i386/kernel/dmi_scan.c	2004-08-05 
>14:19:57.058593500 +0200
>@@ -272,6 +272,16 @@
> }  
> #endif
> 
>+static __init int hp_ht_bigsmp(struct dmi_blacklist *d) 
>+{ 
>+#ifdef CONFIG_X86_GENERICARCH
>+ 	extern int dmi_bigsmp;
>+ 	printk(KERN_NOTICE "%s detected: force use of 
>apic=bigsmp\n", d->ident);
>+ 	dmi_bigsmp = 1;
>+#endif
>+ 	return 0;
>+} 
>+
> /*
>  *	Process the DMI blacklists
>  */
>@@ -460,6 +455,17 @@
> #endif	// CONFIG_ACPI_BOOT
> 
> #ifdef	CONFIG_ACPI_PCI
>+
>+	{ hp_ht_bigsmp, "HP ProLiant DL760 G2", {
>+			MATCH(DMI_BIOS_VENDOR, "HP"),
>+			MATCH(DMI_BIOS_VERSION, "P44-"),
>+			NO_MATCH, NO_MATCH }},
>+
>+	{ hp_ht_bigsmp, "HP ProLiant DL740", {
>+			MATCH(DMI_BIOS_VENDOR, "HP"),
>+			MATCH(DMI_BIOS_VERSION, "P47-"),
>+			NO_MATCH, NO_MATCH }},
>+
> 	/*
> 	 *	Boxes that need ACPI PCI IRQ routing disabled
> 	 */
>diff -u linux-2.6.7/arch/i386/kernel/io_apic.c-HP 
>linux-2.6.7/arch/i386/kernel/io_apic.c
>--- linux-2.6.7/arch/i386/kernel/io_apic.c-HP	2004-08-05 
>14:00:29.328072077 +0200
>+++ linux-2.6.7/arch/i386/kernel/io_apic.c	2004-08-05 
>14:17:49.595383418 +0200
>@@ -1714,7 +1714,7 @@
> 		reg_00.raw = io_apic_read(apic, 0);
> 		spin_unlock_irqrestore(&ioapic_lock, flags);
> 		if (reg_00.bits.ID != mp_ioapics[apic].mpc_apicid)
>-			panic("could not set ID!\n");
>+			printk(" could not set ID!\n");
> 		else
> 			printk(" ok.\n");
> 	}
>-
>To unsubscribe from this list: send the line "unsubscribe 
>linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
