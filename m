Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751838AbWJWIvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbWJWIvb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 04:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751839AbWJWIva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 04:51:30 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:16002 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1751838AbWJWIva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 04:51:30 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 1/4] Char: stallion, convert to pci probing
Date: Mon, 23 Oct 2006 10:51:16 +0200
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <242814652263746404@wsc.cz>
In-Reply-To: <242814652263746404@wsc.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6797289.lXtfugcSXk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610231051.16847.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart6797289.lXtfugcSXk
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Sonntag, 22. Oktober 2006 17:48 schrieb Jiri Slaby:
> stallion, convert to pci probing
>
> Convert stallion driver to pci probing instead of pci_dev_get iteration.
>
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
>
> ---
> commit c4a0f4d15661fe74b8c67b0258d5dfbcff57071b
> tree 5da405798c9d47c7a07b63868e9fec1748908b6b
> parent fcf3d1f86671d8e01a238935d906356442c92749
> author Jiri Slaby <ku@bellona.localdomain> Sun, 22 Oct 2006 16:40:25 +0159
> committer Jiri Slaby <ku@bellona.localdomain> Sun, 22 Oct 2006 16:40:25
> +0159
>
>  drivers/char/stallion.c |  165
> ++++++++++++++++++++++++----------------------- 1 files changed, 83
> insertions(+), 82 deletions(-)
>
> diff --git a/drivers/char/stallion.c b/drivers/char/stallion.c
> index d2cbdb7..592bd6e 100644
> --- a/drivers/char/stallion.c
> +++ b/drivers/char/stallion.c
> @@ -381,8 +381,6 @@ #define	STL_CLOSEDELAY		(5 * HZ / 10)
>
>=20
> /************************************************************************=
**
>***/
>
> -#ifdef CONFIG_PCI
> -
>  /*
>   *	Define the Stallion PCI vendor and device IDs.
>   */
> @@ -402,22 +400,19 @@ #endif
>  /*
>   *	Define structure to hold all Stallion PCI boards.
>   */
> -typedef struct stlpcibrd {
> -	unsigned short		vendid;
> -	unsigned short		devid;
> -	int			brdtype;
> -} stlpcibrd_t;
> -
> -static stlpcibrd_t	stl_pcibrds[] =3D {
> -	{ PCI_VENDOR_ID_STALLION, PCI_DEVICE_ID_ECHPCI864, BRD_ECH64PCI },
> -	{ PCI_VENDOR_ID_STALLION, PCI_DEVICE_ID_EIOPCI, BRD_EASYIOPCI },
> -	{ PCI_VENDOR_ID_STALLION, PCI_DEVICE_ID_ECHPCI832, BRD_ECHPCI },
> -	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_87410, BRD_ECHPCI },
> -};
>
> -static int	stl_nrpcibrds =3D ARRAY_SIZE(stl_pcibrds);
> -
> -#endif
> +static struct pci_device_id stl_pcibrds[] =3D {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_STALLION, PCI_DEVICE_ID_ECHPCI864),
> +		.driver_data =3D BRD_ECH64PCI },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_STALLION, PCI_DEVICE_ID_EIOPCI),
> +		.driver_data =3D BRD_EASYIOPCI },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_STALLION, PCI_DEVICE_ID_ECHPCI832),
> +		.driver_data =3D BRD_ECHPCI },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_87410),
> +		.driver_data =3D BRD_ECHPCI },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(pci, stl_pcibrds);
>
>=20
> /************************************************************************=
**
>***/
>
> @@ -2392,24 +2387,52 @@ static int __init stl_getbrdnr(void)
>  	return(-1);
>  }
>
> -/***********************************************************************=
**
>****/ +static void stl_cleanup_panels(struct stlbrd *brdp)
> +{
> +	struct stlpanel *panelp;
> +	struct stlport *portp;
> +	unsigned int j, k;
>
> -#ifdef	CONFIG_PCI
> +	for (j =3D 0; j < STL_MAXPANELS; j++) {
> +		panelp =3D brdp->panels[j];
> +		if (panelp =3D=3D NULL)
> +			continue;
> +		for (k =3D 0; k < STL_PORTSPERPANEL; k++) {
> +			portp =3D panelp->ports[k];
> +			if (portp =3D=3D NULL)
> +				continue;
> +			if (portp->tty !=3D NULL)
> +				stl_hangup(portp->tty);
> +			kfree(portp->tx.buf);
> +			kfree(portp);
> +		}
> +		kfree(panelp);
> +	}
> +}
>
> +/***********************************************************************=
**
>****/ /*
>   *	We have a Stallion board. Allocate a board structure and
>   *	initialize it. Read its IO and IRQ resources from PCI
>   *	configuration space.
>   */
>
> -static int __init stl_initpcibrd(int brdtype, struct pci_dev *devp)
> +static int __devinit stl_pciprobe(struct pci_dev *pdev,
> +		const struct pci_device_id *ent)
>  {
> -	struct stlbrd	*brdp;
> +	struct stlbrd *brdp;
> +	unsigned int brdtype =3D ent->driver_data;
>
>  	pr_debug("stl_initpcibrd(brdtype=3D%d,busnr=3D%x,devnr=3D%x)\n", brdtyp=
e,
> -		devp->bus->number, devp->devfn);
> +		pdev->bus->number, pdev->devfn);
> +
> +	if ((pdev->class >> 8) =3D=3D PCI_CLASS_STORAGE_IDE)
> +		return -ENODEV;
> +
> +	dev_info(&pdev->dev, "please, report this to LKML: %x/%x/%x\n",
> +			pdev->vendor, pdev->device, pdev->class);

I guess you wanted the dev_info _before_ the return? And why could this eve=
r=20
happen?

>
> -	if (pci_enable_device(devp))
> +	if (pci_enable_device(pdev))
>  		return(-EIO);
>  	if ((brdp =3D stl_allocbrd()) =3D=3D NULL)
>  		return(-ENOMEM);
> @@ -2425,8 +2448,8 @@ static int __init stl_initpcibrd(int brd
>   *	so set up io addresses based on board type.
>   */
>  	pr_debug("%s(%d): BAR[]=3D%Lx,%Lx,%Lx,%Lx IRQ=3D%x\n", __FILE__, __LINE=
__,
> -		pci_resource_start(devp, 0), pci_resource_start(devp, 1),
> -		pci_resource_start(devp, 2), pci_resource_start(devp, 3), devp->irq);
> +		pci_resource_start(pdev, 0), pci_resource_start(pdev, 1),
> +		pci_resource_start(pdev, 2), pci_resource_start(pdev, 3), pdev->irq);
>  /*
>   *	We have all resources from the board, so let's setup the actual

I would vote for deleting this completely. If someone wants to know lspci a=
nd=20
sysfs can tell the whole story.

> @@ -2434,63 +2457,52 @@ static int __init stl_initpcibrd(int brd
>   */
>  	switch (brdtype) {
>  	case BRD_ECHPCI:
> -		brdp->ioaddr2 =3D pci_resource_start(devp, 0);
> -		brdp->ioaddr1 =3D pci_resource_start(devp, 1);
> +		brdp->ioaddr2 =3D pci_resource_start(pdev, 0);
> +		brdp->ioaddr1 =3D pci_resource_start(pdev, 1);
>  		break;
>  	case BRD_ECH64PCI:
> -		brdp->ioaddr2 =3D pci_resource_start(devp, 2);
> -		brdp->ioaddr1 =3D pci_resource_start(devp, 1);
> +		brdp->ioaddr2 =3D pci_resource_start(pdev, 2);
> +		brdp->ioaddr1 =3D pci_resource_start(pdev, 1);
>  		break;
>  	case BRD_EASYIOPCI:
> -		brdp->ioaddr1 =3D pci_resource_start(devp, 2);
> -		brdp->ioaddr2 =3D pci_resource_start(devp, 1);
> +		brdp->ioaddr1 =3D pci_resource_start(pdev, 2);
> +		brdp->ioaddr2 =3D pci_resource_start(pdev, 1);
>  		break;

Is it really that important to name it pdev instead of devp? This causes to=
ns=20
of noise in the patch.


> +	release_region(brdp->ioaddr1, brdp->iosize1);
> +	if (brdp->iosize2 > 0)
> +		release_region(brdp->ioaddr2, brdp->iosize2);

pci_release_region() maybe? This would be a conversion that actually would=
=20
make the code more readable. Since this code path looks PCI only...

> -	return(0);
> +	stl_brds[brdp->brdnr] =3D NULL;
> +	kfree(brdp);
>  }
>
> -#endif
> +static struct pci_driver stl_pcidriver =3D {
> +	.name =3D "stallion",
> +	.id_table =3D stl_pcibrds,
> +	.probe =3D stl_pciprobe,
> +	.remove =3D __devexit_p(stl_pciremove)
> +};
>
>=20
> /************************************************************************=
**
>***/
>
> @@ -2537,9 +2549,6 @@ static int __init stl_initbrds(void)
>   *	line options or auto-detected on the PCI bus.
>   */
>  	stl_argbrds();
> -#ifdef CONFIG_PCI
> -	stl_findpcibrds();
> -#endif
>
>  	return(0);
>  }
> @@ -4778,7 +4787,7 @@ static void stl_sc26198otherisr(struct s
>   */
>  static int __init stallion_module_init(void)
>  {
> -	unsigned int i;
> +	unsigned int i, retval;
>
>  	printk(KERN_INFO "%s: version %s\n", stl_drvtitle, stl_drvversion);
>
> @@ -4787,6 +4796,10 @@ static int __init stallion_module_init(v
>
>  	stl_initbrds();
>
> +	retval =3D pci_register_driver(&stl_pcidriver);
> +	if (retval)
> +		goto err;
> +
>  	stl_serial =3D alloc_tty_driver(STL_MAXBRDS * STL_MAXPORTS);
>  	if (!stl_serial)

pci_unregister_driver() here?

>  		return -1;

Eike

--nextPart6797289.lXtfugcSXk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFPIKEXKSJPmm5/E4RAjPbAKCUcvsZnGYQXpWx4G9n1iUhlkJLwQCeMtcI
BlRCTPncmCx8Z3YHOGAbboQ=
=Pm4P
-----END PGP SIGNATURE-----

--nextPart6797289.lXtfugcSXk--
