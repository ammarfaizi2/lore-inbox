Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030436AbWGNMvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030436AbWGNMvJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 08:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030437AbWGNMvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 08:51:09 -0400
Received: from mivlgu.ru ([81.18.140.87]:55449 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S1030436AbWGNMvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 08:51:08 -0400
Date: Fri, 14 Jul 2006 16:51:00 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Daniel Drake <dsd@gentoo.org>
Cc: Jeff Garzik <jeff@garzik.org>, greg@kroah.com, akpm@osdl.org, cw@f00f.org,
       harmon@ksu.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add SATA device to VIA IRQ quirk fixup list
Message-Id: <20060714165100.6950813a.vsu@altlinux.ru>
In-Reply-To: <44B78AFA.80806@gentoo.org>
References: <20060714095233.5678A8B6253@zog.reactivated.net>
	<44B77B1A.6060502@garzik.org>
	<44B78294.1070308@gentoo.org>
	<44B78538.6030909@garzik.org>
	<44B78AFA.80806@gentoo.org>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.17; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__14_Jul_2006_16_51_00_+0400_86m53lwEboeZXuZf"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__14_Jul_2006_16_51_00_+0400_86m53lwEboeZXuZf
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Jul 2006 13:15:54 +0100 Daniel Drake wrote:

> Jeff Garzik wrote:
> > Same rationale, but the VIA SATA PCI ID had been submitted before, as=20
> > well...
>=20
> OK. So what's the realistic solution?
>=20
> The best I can think of is something like this (see attachment).
>=20
> It's not perfect, because if someone inserts a VIA PCI card into a=20
> VIA-based motherboard, the quirk will also run on that VIA PCI card.

I still do not understand what will break in this case - won't the
external device just ignore the value which the quirk will write into
its PCI_INTERRUPT_LINE register?

Can someone point me at examples of breakage caused by the original
quirk matching non-builtin devices?  The examples of breakage caused by
missing devices are everywhere now :(

> Is there a way we can realistically say "this is an on-board device" vs=20
> "this is a PCI card"?

I thought about limiting to some range of PCI device numbers on the same
bus as the VIA southbridge, but this range does not seem to be
well-defined even for V-Link devices, and old PCI chips like 82C686 had
an external IDSEL# input and could end up on any device number (they had
only a single multifunction PCI device, however).

> This is untested but I'll happily test and work on it further if it=20
> doesn't get shot down :)
> I have only added the southbridges for my own hardware and the one=20
> listed on the Gentoo bug. I guess there will be more. I also wonder if=20
> listing the southbridges is the most sensible approach or if other=20
> devices (e.g. the host bridge at 00:00.0) would be more appropriate?

Using the host bridge as a trigger definitely does not look correct
(e.g., 82C686 looks like a normal PCI device and could be used in
systems with non-VIA host bridges).

> Daniel

> [PATCH] Add SATA device to VIA IRQ quirk fixup list
>=20
> Gentoo users at http://bugs.gentoo.org/138036 reported a 2.6.16.17 regres=
sion:
> new kernels will not boot their system from their VIA SATA hardware.
>=20
> The solution is just to add the SATA device to the fixup list.
> This should also fix the same problem reported by Scott J. Harmon on LKML.

Now this changelog is obviously wrong...

> Signed-off-by: Daniel Drake <dsd@gentoo.org>
>=20
> Index: linux/drivers/pci/quirks.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/drivers/pci/quirks.c
> +++ linux/drivers/pci/quirks.c
> @@ -648,10 +648,31 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_V
>   * Some of the on-chip devices are actually '586 devices' so they are
>   * listed here.
>   */
> +
> +static int via_irq_fixup_needed =3D -1;
> +
> +/*
> + * As some VIA hardware is available in PCI-card form, we need to restri=
ct
> + * this quirk to VIA PCI hardware built onto VIA-based motherboards only.
> + * This table lists southbridges on motherboards where this quirk needs =
to
> + * be run.
> + */
> +static const struct pci_device_id via_irq_fixup_tbl[] =3D {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8233A) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8237) },

This table is even more incomplete than the original.  I found these ISA
bridge IDs from VIA in my copy of pci.ids:

        0586  VT82C586/A/B PCI-to-ISA [Apollo VP]
        0596  VT82C596 ISA [Mobile South]
        0686  VT82C686 [Apollo Super South]
        3074  VT8233 PCI to ISA Bridge
        3109  VT8233C PCI to ISA Bridge
        3147  VT8233A ISA Bridge
        3177  VT8235 ISA Bridge
        3227  VT8237 ISA bridge [KT600/K8T800/K8T890 South]
        3287  VT8251 PCI to ISA Bridge
        3337  VT8237A PCI to ISA Bridge
        8231  VT8231 [PCI-to-ISA Bridge]

The major problem with this approach is that this PCI ID list will
inevitably get stale, and there will be no easy way to boot the kernel
on a newer system.  And there is no sign that VIA turns away from their
habit of using PCI_INTERRUPT_LINE for IRQ routing...

However, what about triggering the quirk on any ISA bridge from VIA:

	{
		.vendor 	=3D PCI_VENDOR_ID_VIA,
		.device		=3D PCI_ANY_ID,
		.subvendor	=3D PCI_ANY_ID,
		.subdevice	=3D PCI_ANY_ID,
		.class		=3D PCI_CLASS_BRIDGE_ISA << 8,
		.class_mask	=3D 0xffff00,
	}

> +	{ 0, },
> +};
> +
>  static void quirk_via_irq(struct pci_dev *dev)
>  {
>  	u8 irq, new_irq;
> =20
> +	if (via_irq_fixup_needed =3D=3D -1)
> +		via_irq_fixup_needed =3D pci_dev_present(via_irq_fixup_tbl);
> +
> +	if (!via_irq_fixup_needed)
> +		return;
> +
>  	new_irq =3D dev->irq & 0xf;
>  	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
>  	if (new_irq !=3D irq) {
> @@ -661,13 +682,7 @@ static void quirk_via_irq(struct pci_dev
>  		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
>  	}
>  }
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_0, =
quirk_via_irq);
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1, =
quirk_via_irq);
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_2, =
quirk_via_irq);
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_3, =
quirk_via_irq);
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, qu=
irk_via_irq);
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4, =
quirk_via_irq);
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5, =
quirk_via_irq);
> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);
> =20
>  /*
>   * VIA VT82C598 has its device ID settable and many BIOSes
>=20

--Signature=_Fri__14_Jul_2006_16_51_00_+0400_86m53lwEboeZXuZf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.17 (GNU/Linux)

iD8DBQFEt5M0W82GfkQfsqIRAhgGAJ9QdCRY0vgazJFErUR5k2VhrXt9HQCeOVVK
vJ64h9t/AELrvt97/BQg0Is=
=xRqr
-----END PGP SIGNATURE-----

--Signature=_Fri__14_Jul_2006_16_51_00_+0400_86m53lwEboeZXuZf--
