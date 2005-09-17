Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbVIQTuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbVIQTuj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 15:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbVIQTuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 15:50:39 -0400
Received: from master.altlinux.ru ([62.118.250.235]:61961 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1751187AbVIQTui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 15:50:38 -0400
Date: Sat, 17 Sep 2005 23:49:40 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Manu Abraham <manu@linuxtv.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: free free irq and Oops on cat /proc/interrupts (2)
Message-ID: <20050917194940.GK11302@procyon.home>
References: <432C344D.1030604@linuxtv.org> <20050917215646.78a05044.vsu@altlinux.ru> <432C5F93.80506@linuxtv.org> <20050917191058.GJ11302@procyon.home> <432C6E67.7030602@linuxtv.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mPOSj6iWmtyhwOMz"
Content-Disposition: inline
In-Reply-To: <432C6E67.7030602@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mPOSj6iWmtyhwOMz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 17, 2005 at 11:28:39PM +0400, Manu Abraham wrote:
> >Here is the next problem - you must give free_irq() the same pointer
> >that you have passed to request_irq().  So you need a way to get from
> >a struct pci_dev for your device to the corresponding struct
> >mantis_pci.  This is done as follows:
> >
> >1) In your mantis_pci_probe(), when you have initialized the device
> >successfully, put the pointer to you data structure into the PCI
> >device structure:
> >
> >	pci_set_drvdata(pdev, mantis);
> >
> >2) In mantis_pci_remove() (and later in other PCI driver functions,
> >like suspend/resume) get this pointer back:
> >
> >	struct mantis_pci *mantis =3D pci_get_drvdata(pdev);
> >=20
> >
> I had already done this ..

Yes...

> >Then use that pointer where you need it (e.g., in free_irq()).

But not this - which is what really causes the problem.

> static void __devexit mantis_pci_remove(struct pci_dev *pdev)
> {
> 	struct mantis_pci *mantis =3D pci_get_drvdata(pdev);
> 	if (mantis =3D=3D NULL) {
> 		dprintk(verbose, MANTIS_ERROR, 1, "Aeio, MAntis NULL ptr");
> 		return;
> 	}
> 	dprintk(verbose, MANTIS_ERROR, 1, "Removing -->Mantis irq: %d, \
> 		latency: %d\n memory: 0x%lx, mmio: 0x%p",
> 		pdev->irq, mantis->latency, mantis->mantis_addr,
> 		mantis->mantis_mmio);
>=20
> 	free_irq(pdev->irq, pdev);

This should be

	free_irq(pdev->irq, mantis);

> //	release_mem_region(pci_resource_start(pdev, 0),
> //		pci_resource_len(pdev, 0));
> 	pci_release_regions(pdev);
> 	pci_set_drvdata(pdev, NULL);
> 	pci_disable_device(pdev);
> 	kfree(mantis);
> }

--mPOSj6iWmtyhwOMz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD4DBQFDLHNUW82GfkQfsqIRArTHAJikTpB2PskRg1kTZ0n1N3wNkMdEAJ41kL3o
3OsXgZc4HWM/RerPfK4OMw==
=sTDh
-----END PGP SIGNATURE-----

--mPOSj6iWmtyhwOMz--
