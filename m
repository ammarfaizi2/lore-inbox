Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbULOLLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbULOLLc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 06:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbULOLLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 06:11:32 -0500
Received: from macedonia.mhl.tuc.gr ([147.27.3.60]:12250 "HELO
	macedonia.mhl.tuc.gr") by vger.kernel.org with SMTP id S262322AbULOLL1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 06:11:27 -0500
Subject: Re: PCI interrupt lost
From: Dimitris Lampridis <labis@mhl.tuc.gr>
To: linux-os@analogic.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0412131141480.4429@chaos.analogic.com>
References: <1102941933.3415.14.camel@naousa.mhl.tuc.gr>
	 <Pine.LNX.4.61.0412130755290.22212@montezuma.fsmlabs.com>
	 <Pine.LNX.4.61.0412131141480.4429@chaos.analogic.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-pwyqKVU5pZwqXBPzmlje"
Date: Wed, 15 Dec 2004 13:11:24 +0200
Message-Id: <1103109084.3565.13.camel@naousa.mhl.tuc.gr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pwyqKVU5pZwqXBPzmlje
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-12-13 at 12:08 -0500, linux-os wrote:
> Also, PCI interrupts __must__ be level. It's in the PCI specification.
> If this IRQ level is raised, the kernel will call the registered=20
> interrupts. It has no choice and if it didn't work nobody would
> be able to boot. The only  possibility is that somebody else is
> using the interrupt and hasn't allocated it shared, or your
> code has bug(s).
>=20
OK, so level triggered, active low it is.
The interrupt line is not shared by anyone else (right now. in the past
it did but only with other pci devices) as I can see
in /proc/interrupts, but also request_irq() is returning with success.
So no problem there. Therefore, I must agree with you, my code has
bug(s).

> Also, returning IRQ_NONE will force your ISR to be called repeatedly
> until the kernel is forced to shut off the ISR. It should return
> IRQ_DONE. You need to allocate the interrupt specified in the
> "dev" structure and not attempt to out-think anything. You should
> never even care what the raw configuration settings are. If your
> code looks at that stuff, it's broken.
>=20
Why returning IRQ_NONE is wrong? if it is not my interrupt but for
another driver for a device sharing the interrupt line, I should leave
it to him to return IRQ_HANDLED. No?

>      struct pci_dev *pdev;
>      pdev =3D PCI_FIND_DEVICE(PCI_ID, PCI_DEV, pdev);
>=20
>      // use ioremap_nocache() for BARS.
>=20
>      request_irq(pdev->irq, my_isr, SA_INTERRUPT|SA_SHIRQ, "device",=20
> pointer_to_your_stuff);
>      pci_set_drvdata(pdev, NULL);	// Not necessary
>      pci_set_power_state(pdev, 0);	// Now mandatory
>      pci_set_master(pdev);		// PLX is a master
>      pci_set_dma_mask(pdev, 0xffffffffULL);	// Future needs on ix86
>      pci_set_mwi(pdev);			// If you want
>      pci_enable_device(pdev);		// Remember to do this
>=20
>=20
> This __will__ initialize the PLX chip, but you still have to
> set/unmask its interrupt registers to get an interrupt.
>=20
> Both the PLX chip and the kernel code will properly handle an
> interrupt. We use these extensively here, so it's just some
> bug(s) in your code.
>=20
The only thing that didn't already exist in my code was
pci_set_power_state(pdev, 0), but it did not make any difference. the
problem persists. Do you think that there is a problem if I request the
irq line after calling pci_enable_device()? I cannot think of anything
else. Everything that you mentioned is already in my code, and yet I can
see no interrupt. Maybe it has something to do with my HW / BIOS?

Thanks a lot,
=20
Dimitris Lampridis <labis@mhl.tuc.gr>

--=-pwyqKVU5pZwqXBPzmlje
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBwBvbgMArLfy6HHMRAks4AJ9JPvTALzYdNa723Nt3DQy9tfkFEwCeITTB
NvuDBhvG9Ecjtr6MGrIRhag=
=qllz
-----END PGP SIGNATURE-----

--=-pwyqKVU5pZwqXBPzmlje--

