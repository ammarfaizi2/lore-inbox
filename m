Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754600AbWKHRW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754600AbWKHRW2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 12:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753271AbWKHRW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 12:22:28 -0500
Received: from mivlgu.ru ([81.18.140.87]:9372 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S1754600AbWKHRW1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 12:22:27 -0500
Date: Wed, 8 Nov 2006 20:22:18 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>, akpm@osdl.org,
       Wilco Beekhuizen <wilcobeekhuizen@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: VIA IRQ quirk missing PCI ids since 2.6.16.17
Message-Id: <20061108202218.8f542fbf.vsu@altlinux.ru>
In-Reply-To: <1162847625.10086.36.camel@localhost.localdomain>
References: <6c4c86470611060338j7f216e26od93e35b4b061890e@mail.gmail.com>
	<1162817254.5460.4.camel@localhost.localdomain>
	<1162847625.10086.36.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.2; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__8_Nov_2006_20_22_18_+0300_6w5s8_3IQ3YaFFcO"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__8_Nov_2006_20_22_18_+0300_6w5s8_3IQ3YaFFcO
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 06 Nov 2006 21:13:45 +0000 Alan Cox wrote:

> Ar Llu, 2006-11-06 am 12:47 +0000, ysgrifennodd Sergio Monteiro Basto:
> > this is the latest patch
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm1/broken-out/via-irq-quirk-behaviour-change.patch
> > about this issue please try it and report the experience :)
>
> There are several minor problems with this patch:
>
> - V-Link which is what we are dealing with is only found in the VIA 8233
> and later devices and early stuff should not be touched
> - It whacks external devices
>
> I think something like this (untested) would be better
>
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc4-mm1/drivers/pci/quirks.c linux-2.6.19-rc4-mm1/drivers/pci/quirks.c
> --- linux.vanilla-2.6.19-rc4-mm1/drivers/pci/quirks.c	2006-10-31 21:11:49.000000000 +0000
> +++ linux-2.6.19-rc4-mm1/drivers/pci/quirks.c	2006-11-06 20:39:03.026705152 +0000
> @@ -641,48 +641,42 @@
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_via_acpi );
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_via_acpi );
>
> -/*
> - * Via 686A/B:  The PCI_INTERRUPT_LINE register for the on-chip
> - * devices, USB0/1, AC97, MC97, and ACPI, has an unusual feature:
> - * when written, it makes an internal connection to the PIC.
> - * For these devices, this register is defined to be 4 bits wide.
> - * Normally this is fine.  However for IO-APIC motherboards, or
> - * non-x86 architectures (yes Via exists on PPC among other places),
> - * we must mask the PCI_INTERRUPT_LINE value versus 0xf to get
> - * interrupts delivered properly.
> - *
> - * Some of the on-chip devices are actually '586 devices' so they are
> - * listed here.
> - */
> -
> -static int via_irq_fixup_needed = -1;
>
>  /*
> - * As some VIA hardware is available in PCI-card form, we need to restrict
> - * this quirk to VIA PCI hardware built onto VIA-based motherboards only.
> - * We try to locate a VIA southbridge before deciding whether the quirk
> - * should be applied.
> - */
> -static const struct pci_device_id via_irq_fixup_tbl[] = {
> -	{
> -		.vendor 	= PCI_VENDOR_ID_VIA,
> -		.device		= PCI_ANY_ID,
> -		.subvendor	= PCI_ANY_ID,
> -		.subdevice	= PCI_ANY_ID,
> -		.class		= PCI_CLASS_BRIDGE_ISA << 8,
> -		.class_mask	= 0xffff00,
> -	},
> + *	VIA bridges which have VLink
> + */
> +
> +static const struct pci_device_id via_vlink_fixup_tbl[] = {
> +	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_8233_0), 17},
> +	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_8233A), 17 },
> +	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_8233C_0), 17 },
> +	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_8235), 16 },

Hmm, the old comment mentions 686A/B explicitly - seems that these old
chips also use PCI_INTERRUPT_LINE to control interrupt routing.  Is it
correct to ignore them here?  Yes, that chips used PCI and not VLink,
but they also had an internal PIC (and even internal IO-APIC).

Unfortunately, I no longer have such hardware available.

> +	/* May not be needed for the 8237 */
> +	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_8237), 15 },
> +	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_8237A), 15 },

8237 definitely uses PCI_INTERRUPT_LINE to control interrupt routing in
PIC mode - tested with the audio part by writing bogus values with
setpci and checking whether interrupts are delivered.

>  	{ 0, },
>  };
>
> -static void quirk_via_irq(struct pci_dev *dev)
> +/**
> + *	quirk_via_vlink		-	VIA VLink IRQ number update
> + *	@dev: PCI device
> + *
> + *	If the device we are dealing with is on a PIC IRQ we need to
> + *	ensure that the IRQ line register which usually is not relevant
> + *	for PCI cards, is actually written so that interrupts get sent
> + *	to the right place
> + */
> +
> +static void quirk_via_vlink(struct pci_dev *dev)
>  {
> +	static struct pci_device_id *via_vlink_fixup = NULL;
>  	u8 irq, new_irq;
>
> -	if (via_irq_fixup_needed == -1)
> -		via_irq_fixup_needed = pci_dev_present(via_irq_fixup_tbl);
> -
> -	if (!via_irq_fixup_needed)
> +	/* Check if we have VLink and cache the result */
> +
> +	if (via_vlink_fixup == NULL)
> +		via_vlink_fixup = pci_find_present(via_irq_fixup_tbl);
> +	if (via_vlink_fixup == NULL)
>  		return;

If there is no VIA ISA bridge in the system, this won't cache anything.

>
>  	new_irq = dev->irq;
> @@ -691,9 +685,17 @@
>  	if (!new_irq || new_irq > 15)
>  		return;
>
> +	/* Internal device ? */
> +	if (pdev->bus->number != 0 || PCI_FUNC(dev->devfn) > 18 ||
> +		PCI_FUNC(dev->devfn) < via_vlink_fixup->driver_data)
> +		return;
> +
> +	/* This is an internal VLink device on a PIC interrupt. The BIOS
> +	   ought to have set this but may not have, so we redo it */
> +
>  	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
>  	if (new_irq != irq) {
> -		printk(KERN_INFO "PCI: VIA IRQ fixup for %s, from %d to %d\n",
> +		printk(KERN_INFO "PCI: VIA VLink IRQ fixup for %s, from %d to %d\n",
>  			pci_name(dev), irq, new_irq);
>  		udelay(15);	/* unknown if delay really needed */
>  		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc4-mm1/drivers/pci/search.c linux-2.6.19-rc4-mm1/drivers/pci/search.c
> --- linux.vanilla-2.6.19-rc4-mm1/drivers/pci/search.c	2006-10-31 21:11:31.000000000 +0000
> +++ linux-2.6.19-rc4-mm1/drivers/pci/search.c	2006-11-06 20:30:55.548813056 +0000
> @@ -413,30 +413,17 @@
>  	return dev;
>  }
>
> -/**
> - * pci_dev_present - Returns 1 if device matching the device list is present, 0 if not.
> - * @ids: A pointer to a null terminated list of struct pci_device_id structures
> - * that describe the type of PCI device the caller is trying to find.
> - *
> - * Obvious fact: You do not have a reference to any device that might be found
> - * by this function, so if that device is removed from the system right after
> - * this function is finished, the value will be stale.  Use this function to
> - * find devices that are usually built into a system, or for a general hint as
> - * to if another device happens to be present at this specific moment in time.
> - */
> -int pci_dev_present(const struct pci_device_id *ids)
> +struct pci_device_id *pci_find_present(const struct pci_device_id *ids)

New API without proper refcounting?  Ewww.

[...]

--Signature=_Wed__8_Nov_2006_20_22_18_+0300_6w5s8_3IQ3YaFFcO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFUhJNW82GfkQfsqIRAtMDAKCT2UTDklfC8inxWc50aYh+0RVzBgCeMJqz
amaeVdzq3UJXDevms4mXRwA=
=rVMS
-----END PGP SIGNATURE-----

--Signature=_Wed__8_Nov_2006_20_22_18_+0300_6w5s8_3IQ3YaFFcO--
