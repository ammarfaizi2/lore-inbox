Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbTERJQg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 05:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbTERJQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 05:16:36 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:33262 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S261863AbTERJQe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 05:16:34 -0400
Subject: Re: [patch] support 64 bit pci_alloc_consistent
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Jes Sorensen <jes@wildopensource.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "David S. Miller" <davem@redhat.com>, James.Bottomley@steeleye.com,
       Grant Grundler <grundler@dsl2.external.hp.com>,
       Colin Ngam <cngam@sgi.com>, Jeremy Higdon <jeremy@sgi.com>,
       linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org, wildos@sgi.com
In-Reply-To: <16071.1892.811622.257847@trained-monkey.org>
References: <16071.1892.811622.257847@trained-monkey.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-0c7yDvAUspW93r7FLMOK"
Organization: Red Hat, Inc.
Message-Id: <1053250142.1300.8.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 18 May 2003 11:29:02 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0c7yDvAUspW93r7FLMOK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-05-18 at 06:09, Jes Sorensen wrote:
> Hi Linus,
>=20
> This is patch which provides support for 64 bit address allocations from
> pci_alloc_consistent(), based on the address mask set through
> pci_set_consistent_dma_mask(). This is necessary on some platforms which
> are unable to provide physical memory in the lower 4GB block and do not
> provide IOMMU support for cards operating in certain bus modes, such as
> PCI-X on the SGI SN2.

I rather see a slightly different interface for this all together.
Right now the template for doing this is that the driver needs to check
the return value of the "set to 64 bit" operation and itself fall back
to 32 bit etc. What the driver really wants to achieve is to announce
device capabilities. The current interface is sort of also used to
retrieve the capability as well, which is a whole different thing.

An interface like

#define PCI_DMA_64BIT 0xffffffffffffffffULL
#define PCI_DMA_32BIT 0xffffffffULL

void pci_set_dma_capabilities(device,=20
               u64 streaming_mask, u64 persistent_mask);
u64 pci_get_effective_streaming_mask(device);
u64 pci_get_effective_persistent_mask(device);

if for some reason the architecture PCI code needs or wants to reduce
the DMA mask (for example on non-PAE36 x86 kernels) it now doesn't need
to return failure for the 64 bit mask (and maybe even the 32 bit one)
but it can just do it. All places in drivers that actually care about
the resulting, effective DMA mask now have an interface to get this.=20
Why this interface? I think it fits closer to what drivers use it for;
uncomplicated announcing of the hardware's capabilities and independent
checking of the effective mask, for example for the decision about what
DMA descriptor model to use in some communications ringbuffer.

Greetings,
   Arjan van de Ven

--=-0c7yDvAUspW93r7FLMOK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+x1JdxULwo51rQBIRAq3NAKCmG/bNGJ9a/bRHe5J1cxGVl+g+OwCfSKRa
oAI1Nf+7x7nWRwcgp3H7OhY=
=OY5f
-----END PGP SIGNATURE-----

--=-0c7yDvAUspW93r7FLMOK--
