Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVEWRkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVEWRkw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 13:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVEWRkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 13:40:35 -0400
Received: from scl-ims.phoenix.com ([216.148.212.222]:2013 "EHLO
	scl-exch2k.phoenix.com") by vger.kernel.org with ESMTP
	id S261937AbVEWRe3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 13:34:29 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] bug in VIA PCI IRQ routing
Date: Mon, 23 May 2005 10:34:01 -0700
Message-ID: <0EF82802ABAA22479BC1CE8E2F60E8C31B4894@scl-exch2k3.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] bug in VIA PCI IRQ routing
Thread-Index: AcVflzBsWrTZuh9zQ82pQgNN3eJeLAAJWKGQ
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: "Karsten Keil" <kkeil@suse.de>, <linux-kernel@vger.kernel.org>
Cc: "Andrew Morton" <akpm@osdl.org>, <jgarzik@pobox.com>
X-OriginalArrivalTime: 23 May 2005 17:34:27.0131 (UTC) FILETIME=[AAF110B0:01C55FBD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Karsten Keil [mailto:kkeil@suse.de] 
>Sent: Monday, May 23, 2005 5:59 AM
>To: linux-kernel@vger.kernel.org
>Cc: Andrew Morton; Aleksey Gorelov
>Subject: [PATCH] bug in VIA PCI IRQ routing
>
>Hi,
>
>during certification of some systems with VIA 82C586_0 chipset
>we found that the PCI IRQ routing of PIRQD line goes wrong and 
>the system
>will get stuck because of unacknowledged IRQs.
>It seems that the special case for PIRQD (pirq 4) is not needed for all
>VIA versions. With this patch, the IRQ routing on these systems works
>again (It did work with older 2.4 kernel versions prior the 
>PIRQD change)

 Does anybody have 82C586 datasheet to verify 0x57 register ? 
For all I can say, both 82C686 & 8231 DO need special handling for
PIRQD, 
since PIRQD routing is setup via bits 7-4 in 0x57 (see datasheets from
VIA 
website). It seems like 82C586 might be different...

Aleks.

>
>diff -urN linux-2.6.12-rc4-git7.org/arch/i386/pci/irq.c 
>linux-2.6.12-rc4-git7/arch/i386/pci/irq.c
>--- linux-2.6.12-rc4-git7.org/arch/i386/pci/irq.c	
>2005-05-23 13:35:48.562759583 +0200
>+++ linux-2.6.12-rc4-git7/arch/i386/pci/irq.c	2005-05-23 
>13:41:47.349473060 +0200
>@@ -26,6 +26,7 @@
> 
> static int broken_hp_bios_irq9;
> static int acer_tm360_irqrouting;
>+static int via_pirq_patch_value = 5;
> 
> static struct irq_routing_table *pirq_table;
> 
>@@ -217,12 +218,12 @@
>  */
> static int pirq_via_get(struct pci_dev *router, struct 
>pci_dev *dev, int pirq)
> {
>-	return read_config_nybble(router, 0x55, pirq == 4 ? 5 : pirq);
>+	return read_config_nybble(router, 0x55, pirq == 4 ? 
>via_pirq_patch_value : pirq);
> }
> 
> static int pirq_via_set(struct pci_dev *router, struct 
>pci_dev *dev, int pirq, int irq)
> {
>-	write_config_nybble(router, 0x55, pirq == 4 ? 5 : pirq, irq);
>+	write_config_nybble(router, 0x55, pirq == 4 ? 
>via_pirq_patch_value : pirq, irq);
> 	return 1;
> }
> 
>@@ -512,6 +513,7 @@
> 	switch(device)
> 	{
> 		case PCI_DEVICE_ID_VIA_82C586_0:
>+			via_pirq_patch_value = 4;
> 		case PCI_DEVICE_ID_VIA_82C596:
> 		case PCI_DEVICE_ID_VIA_82C686:
> 		case PCI_DEVICE_ID_VIA_8231:
>
>-- 
>Karsten Keil
>SuSE Labs
>ISDN development
>

