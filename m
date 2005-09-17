Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbVIQTMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbVIQTMA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 15:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbVIQTMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 15:12:00 -0400
Received: from master.altlinux.ru ([62.118.250.235]:59152 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1751189AbVIQTL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 15:11:59 -0400
Date: Sat, 17 Sep 2005 23:10:58 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Manu Abraham <manu@linuxtv.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: free free irq and Oops on cat /proc/interrupts (2)
Message-ID: <20050917191058.GJ11302@procyon.home>
References: <432C344D.1030604@linuxtv.org> <20050917215646.78a05044.vsu@altlinux.ru> <432C5F93.80506@linuxtv.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2VXyA7JGja7B50zs"
Content-Disposition: inline
In-Reply-To: <432C5F93.80506@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2VXyA7JGja7B50zs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 17, 2005 at 10:25:23PM +0400, Manu Abraham wrote:
[skip]
> static int __devinit mantis_pci_probe(struct pci_dev *pdev,
> 				const struct pci_device_id *mantis_pci_table)
> {
> 	u8 revision, latency;
> 	struct mantis_pci *mantis;
>=20
> 	mantis =3D (struct mantis_pci *)
> 				kmalloc(sizeof (struct mantis_pci), GFP_KERNEL);
> 	if (mantis =3D=3D NULL) {
> 		dprintk(verbose, MANTIS_ERROR, 1, "Out of memory");
> 		return -ENOMEM;
> 	}
> 	if (pci_enable_device(pdev)) {
> 		dprintk(verbose, MANTIS_ERROR, 1, "Mantis PCI enable failed");
> 		goto err;
> 	}
> 	dprintk(verbose, MANTIS_ERROR, 1, "<2:>IRQ=3D%d", pdev->irq);
>=20
> 	dprintk(verbose, MANTIS_ERROR, 1, "Got a device");
> 	if (request_irq(pdev->irq, mantis_pci_irq, SA_SHIRQ | SA_INTERRUPT,=20
> 						DRIVER_NAME, mantis) < 0) {

Some code is obviously missing here...

> 	dprintk(verbose, MANTIS_DEBUG, 1, "We got an IRQ");
> 	return 0;
>=20
> err:
> 	dprintk(verbose, MANTIS_DEBUG, 1, "<freak out>");
> 	kfree(mantis);
> 	return -ENODEV;
> }
>=20
>=20
>=20
> static void __devexit mantis_pci_remove(struct pci_dev *pdev)
> {
> 	free_irq(pdev->irq, pdev);

Here is the next problem - you must give free_irq() the same pointer
that you have passed to request_irq().  So you need a way to get from
a struct pci_dev for your device to the corresponding struct
mantis_pci.  This is done as follows:

1) In your mantis_pci_probe(), when you have initialized the device
successfully, put the pointer to you data structure into the PCI
device structure:

	pci_set_drvdata(pdev, mantis);

2) In mantis_pci_remove() (and later in other PCI driver functions,
like suspend/resume) get this pointer back:

	struct mantis_pci *mantis =3D pci_get_drvdata(pdev);

Then use that pointer where you need it (e.g., in free_irq()).

3) mantis_pci_remove() should also clear out the pointer to the driver
data:

	pci_set_drvdata(pdev, NULL);

> 	pci_disable_device(pdev);
> }

--2VXyA7JGja7B50zs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDLGpCW82GfkQfsqIRArPfAJwNvMCTEYlYTYt+kyzuNP9n6ET45wCfUEDh
CNdr5ZBNAcZKf3X29+BKTCc=
=H2ed
-----END PGP SIGNATURE-----

--2VXyA7JGja7B50zs--
