Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965017AbVHOWbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965017AbVHOWbR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 18:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965018AbVHOWbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 18:31:17 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:29590 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S965017AbVHOWbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 18:31:16 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [PATCH,RFC] quirks for VIA VT8237 southbridge
Date: Mon, 15 Aug 2005 16:31:07 -0600
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
References: <200508131710.38569.annabellesgarden@yahoo.de>
In-Reply-To: <200508131710.38569.annabellesgarden@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508151631.07717.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 13 August 2005 9:10 am, Karsten Wiese wrote:
> this fixes the 'doubled ioapic level interrupt rate' issue I've been
> seeing on a K8T800/AMD64 mainboard.
> It also switches off quirk_via_irq() for the VT8237 southbridge.

These patches seem unrelated except that they both contain the
text "via", so I think you should at least split them.

> + * Devices part of the VIA VT8237 don't need quirk_via_irq().
> + * They also don't get confused by it, but dmesg gets quiter
> + * with this 'anti'-quirk.
> + * Here we are overly paranoic:
> + * we assume there might also exist via devices not part of the VT8237
> + * needing quirk_via_irq().
> + * This might never be the case in reality, when there is a VT8237.

This quirk_via_irq() change seems like an awful lot of work to
get rid of a few log messages.  In my opinion, it's just not
worth it, because it's so hard to debug problems in that area
already.

> +static unsigned int vt8237_devfn[] = {
> +       PCI_DEVFN(15, 0),
> +       PCI_DEVFN(15, 1),
> +       PCI_DEVFN(16, 0),
> +       PCI_DEVFN(16, 1),
> +       PCI_DEVFN(16, 2),
> +       PCI_DEVFN(16, 3),
> +       PCI_DEVFN(16, 4),
> +       PCI_DEVFN(16, 5),
> +       PCI_DEVFN(17, 5),
> +       PCI_DEVFN(17, 6),
> +       PCI_DEVFN(18, 0)
> +};
> +static struct pci_dev *quirk_via_irq_not[ARRAY_SIZE(vt8237_devfn)];
> +static void quirk_via_irq_not_for_8237(struct pci_dev *dev)
> +{
> +       // Make sure we do this only once
> +       if (quirk_via_irq_not[0] != NULL)
> +               return;
> +
> +       if (dev->devfn == PCI_DEVFN(0x11, 0)) {
> +               int i, j;
> +               for (i = 0, j = 0; i < ARRAY_SIZE(vt8237_devfn); i++) {
> +                       struct pci_dev * d;
> +                       d = pci_find_slot(dev->bus->number, vt8237_devfn[i]);
> +                       if (d != NULL)
> +                               quirk_via_irq_not[j++] = d;
> +               }
> +       }
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8237, quirk_via_irq_not_for_8237);
> +
> +/*
>   * Via 686A/B:  The PCI_INTERRUPT_LINE register for the on-chip
>   * devices, USB0/1, AC97, MC97, and ACPI, has an unusual feature:
>   * when written, it makes an internal connection to the PIC.
> @@ -499,8 +559,14 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_V
>   */
>  static void quirk_via_irq(struct pci_dev *dev)
>  {
> +       int i;
>         u8 irq, new_irq;
> 
> +       for (i = 0; i < ARRAY_SIZE(vt8237_devfn); i++)
> +               if (quirk_via_irq_not[i] == dev)
> +                       return;
> +
> +
>         new_irq = dev->irq & 0xf;
>         pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
>         if (new_irq != irq) {
