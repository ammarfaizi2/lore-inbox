Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVBGURN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVBGURN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 15:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVBGUPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 15:15:37 -0500
Received: from alog0414.analogic.com ([208.224.222.190]:18304 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261301AbVBGUOP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 15:14:15 -0500
Date: Mon, 7 Feb 2005 15:12:20 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: bjorn.helgaas@hp.com
cc: rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [SERIAL] add TP560 data/fax/modem support
In-Reply-To: <1107805182.8074.35.camel@piglet>
Message-ID: <Pine.LNX.4.61.0502071508130.24378@chaos.analogic.com>
References: <1107805182.8074.35.camel@piglet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I thought somebody promised to add a pci_route_irq(dev) or some
such so that the device didn't have to be enabled before
the IRQ was correct.

I first reported this bad IRQ problem back in December of 2004.
Has the new function been added?


On Mon, 7 Feb 2005, Bjorn Helgaas wrote:

> Claim Topic TP560 data/fax/voice modem.  This device reports as class 0x0780,
> so we don't claim it by default:
>
> 	00:0d.0 Class 0780: 151f:0000
> 		Subsystem: 151f:0000
> 		Interrupt: pin A routed to IRQ 11
> 		Region 0: I/O ports at a400 [size=8]
> 	00: 1f 15 00 00 01 00 00 02 00 00 80 07 00 00 00 00
> 	10: 01 a4 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 	20: 00 00 00 00 00 00 00 00 00 00 00 00 1f 15 00 00
> 	30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 00
>
> Some rc.serial scripts extract IRQ and I/O port information from
> /proc/pci and stuff it into an unused port using setserial.  That
> doesn't work reliably anymore because pci_enable_device() is never
> called, so the IRQ may not be enabled.
>
> Thanks to Evan Clarke for reporting and helping debug this problem.
>
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
>
> ===== drivers/serial/8250_pci.c 1.48 vs edited =====
> --- 1.48/drivers/serial/8250_pci.c	2004-11-21 23:42:29 -07:00
> +++ edited/drivers/serial/8250_pci.c	2005-02-07 12:00:32 -07:00
> @@ -2212,6 +2212,13 @@
> 		0, pbn_exar_XR17C158 },
>
> 	/*
> +	 * Topic TP560 Data/Fax/Voice 56k modem (reported by Evan Clarke)
> +	 */
> +	{	PCI_VENDOR_ID_TOPIC, PCI_DEVICE_ID_TOPIC_TP560,
> +		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +		pbn_b0_1_115200 },
> +
> +	/*
> 	 * These entries match devices with class COMMUNICATION_SERIAL,
> 	 * COMMUNICATION_MODEM or COMMUNICATION_MULTISERIAL
> 	 */
> ===== include/linux/pci_ids.h 1.200 vs edited =====
> --- 1.200/include/linux/pci_ids.h	2005-01-30 23:33:43 -07:00
> +++ edited/include/linux/pci_ids.h	2005-02-07 11:56:14 -07:00
> @@ -1972,6 +1972,9 @@
> #define PCI_DEVICE_ID_BCM4401		0x4401
> #define PCI_DEVICE_ID_BCM4401B0		0x4402
>
> +#define PCI_VENDOR_ID_TOPIC		0x151f
> +#define PCI_DEVICE_ID_TOPIC_TP560	0x0000
> +
> #define PCI_VENDOR_ID_ENE		0x1524
> #define PCI_DEVICE_ID_ENE_1211		0x1211
> #define PCI_DEVICE_ID_ENE_1225		0x1225
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
