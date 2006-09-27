Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965400AbWI0H1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965400AbWI0H1l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 03:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965425AbWI0H1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 03:27:41 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:23478 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S965400AbWI0H1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 03:27:40 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] x86[-64] PCI domain support
Date: Wed, 27 Sep 2006 09:28:17 +0200
User-Agent: KMail/1.9.4
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Jim Paradis <jparadis@redhat.com>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
References: <20060926191508.GA6350@havoc.gtf.org>
In-Reply-To: <20060926191508.GA6350@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1404408.e8jz3LH4Yv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609270928.18378.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1404408.e8jz3LH4Yv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Jeff Garzik wrote:

> diff --git a/arch/i386/pci/acpi.c b/arch/i386/pci/acpi.c
> index b33aea8..e4f4828 100644
> --- a/arch/i386/pci/acpi.c
> +++ b/arch/i386/pci/acpi.c
> @@ -8,20 +8,37 @@ #include "pci.h"
>  struct pci_bus * __devinit pci_acpi_scan_root(struct acpi_device *device,
> int domain, int busnum) {
>  	struct pci_bus *bus;
> +	struct pci_sysdata *sd;
>
> +	/* Allocate per-root-bus (not per bus) arch-specific data.
> +	 * TODO: leak; this memory is never freed.
> +	 * It's arguable whether it's worth the trouble to care.
> +	 */
> +	sd =3D kzalloc(sizeof(*sd), GFP_KERNEL);
> +	if (!sd) {
> +		printk(KERN_ERR "PCI: OOM, not probing PCI bus %02x\n", busnum);
> +		return NULL;
> +	}
> +
> +#ifdef CONFIG_PCI_DOMAINS
> +	sd->domain =3D domain;
> +#else
>  	if (domain !=3D 0) {
>  		printk(KERN_WARNING "PCI: Multiple domains not supported\n");

kfree(sd);


>  		return NULL;
>  	}
> +#endif /* CONFIG_PCI_DOMAINS */

I would move this check to be done before the memory is allocated so we don=
't=20
need to free it.

Eike

--nextPart1404408.e8jz3LH4Yv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFGigSXKSJPmm5/E4RAsDfAJ466KHe3/AYeR0X1oEGOpg2fXa7lwCffkPV
CcT1LfDeRzXIK8NV8PVh4MI=
=PNmq
-----END PGP SIGNATURE-----

--nextPart1404408.e8jz3LH4Yv--
