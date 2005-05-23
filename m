Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbVEWSYC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVEWSYC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 14:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbVEWSYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 14:24:02 -0400
Received: from mailhub3.nextra.sk ([195.168.1.146]:30219 "EHLO
	mailhub3.nextra.sk") by vger.kernel.org with ESMTP id S261351AbVEWSXw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 14:23:52 -0400
Message-ID: <42921FE3.4050401@rainbow-software.org>
Date: Mon, 23 May 2005 20:24:35 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>
CC: Karsten Keil <kkeil@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com
Subject: Re: [PATCH] bug in VIA PCI IRQ routing
References: <0EF82802ABAA22479BC1CE8E2F60E8C31B4894@scl-exch2k3.phoenix.com>
In-Reply-To: <0EF82802ABAA22479BC1CE8E2F60E8C31B4894@scl-exch2k3.phoenix.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aleksey Gorelov wrote:
>>-----Original Message-----
>>From: Karsten Keil [mailto:kkeil@suse.de] 
>>Sent: Monday, May 23, 2005 5:59 AM
>>To: linux-kernel@vger.kernel.org
>>Cc: Andrew Morton; Aleksey Gorelov
>>Subject: [PATCH] bug in VIA PCI IRQ routing
>>
>>Hi,
>>
>>during certification of some systems with VIA 82C586_0 chipset
>>we found that the PCI IRQ routing of PIRQD line goes wrong and 
>>the system
>>will get stuck because of unacknowledged IRQs.
>>It seems that the special case for PIRQD (pirq 4) is not needed for all
>>VIA versions. With this patch, the IRQ routing on these systems works
>>again (It did work with older 2.4 kernel versions prior the 
>>PIRQD change)
> 
> 
>  Does anybody have 82C586 datasheet to verify 0x57 register ? 
> For all I can say, both 82C686 & 8231 DO need special handling for
> PIRQD, 
> since PIRQD routing is setup via bits 7-4 in 0x57 (see datasheets from
> VIA 
> website). It seems like 82C586 might be different...
> 
> Aleks.
> 

This is from 82C586B datasheet (the 82C586A datasheet shows the same 
register layout):

Note: The definitions of the fields of the following three
registers were incorrectly documented in some earlier
revisions of this document. The silicon has not changed
and the following definition should be used for all silicon
revisions:

Offset 55 - PNP IRQ Routing 1 ....................................... RW
These bits control routing for external IRQ inputs MIRQ0-1.
7-4 PIRQD# Routing (see PnP IRQ routing table)
3-0 MIRQ0 Routing (see PnP IRQ routing table)

Offset 56 - PNP IRQ Routing 2 ....................................... RW
7-4 PIRQA# Routing (see PnP IRQ routing table)
3-0 PIRQB# Routing (see PnP IRQ routing table)

Offset 57 - PNP IRQ Routing 3 ....................................... RW
7-4 PIRQC# Routing (see PnP IRQ routing table)
3-0 MIRQ1 Routing (see PnP IRQ routing table)

Note: these bits must be set to 0 if Rx48[4]=1 and
Rx59[1]=1 (input IRQ8# on MIRQ1 pin 106)

PnP IRQ Routing Table
0000 Disabled................................................. default
0001 IRQ1
0010 Reserved
0011 IRQ3
0100 IRQ4
0101 IRQ5
0110 IRQ6
0111 IRQ7
1000 Reserved
1001 IRQ9
1010 IRQ10
1011 IRQ11
1100 IRQ12
1101 Reserved
1110 IRQ14
1111 IRQ15


> 
>>diff -urN linux-2.6.12-rc4-git7.org/arch/i386/pci/irq.c 
>>linux-2.6.12-rc4-git7/arch/i386/pci/irq.c
>>--- linux-2.6.12-rc4-git7.org/arch/i386/pci/irq.c	
>>2005-05-23 13:35:48.562759583 +0200
>>+++ linux-2.6.12-rc4-git7/arch/i386/pci/irq.c	2005-05-23 
>>13:41:47.349473060 +0200
>>@@ -26,6 +26,7 @@
>>
>>static int broken_hp_bios_irq9;
>>static int acer_tm360_irqrouting;
>>+static int via_pirq_patch_value = 5;
>>
>>static struct irq_routing_table *pirq_table;
>>
>>@@ -217,12 +218,12 @@
>> */
>>static int pirq_via_get(struct pci_dev *router, struct 
>>pci_dev *dev, int pirq)
>>{
>>-	return read_config_nybble(router, 0x55, pirq == 4 ? 5 : pirq);
>>+	return read_config_nybble(router, 0x55, pirq == 4 ? 
>>via_pirq_patch_value : pirq);
>>}
>>
>>static int pirq_via_set(struct pci_dev *router, struct 
>>pci_dev *dev, int pirq, int irq)
>>{
>>-	write_config_nybble(router, 0x55, pirq == 4 ? 5 : pirq, irq);
>>+	write_config_nybble(router, 0x55, pirq == 4 ? 
>>via_pirq_patch_value : pirq, irq);
>>	return 1;
>>}
>>
>>@@ -512,6 +513,7 @@
>>	switch(device)
>>	{
>>		case PCI_DEVICE_ID_VIA_82C586_0:
>>+			via_pirq_patch_value = 4;
>>		case PCI_DEVICE_ID_VIA_82C596:
>>		case PCI_DEVICE_ID_VIA_82C686:
>>		case PCI_DEVICE_ID_VIA_8231:
>>
>>-- 
>>Karsten Keil
>>SuSE Labs
>>ISDN development
>>
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Ondrej Zary
