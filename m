Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVAaWHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVAaWHw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 17:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVAaWHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 17:07:39 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:1684 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261399AbVAaWGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 17:06:44 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: brking@us.ibm.com
Subject: Re: pci: Arch hook to determine config space size
Date: Mon, 31 Jan 2005 22:56:44 +0100
User-Agent: KMail/1.6.2
Cc: Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-pci@vger.kernel.org,
       linux-arch@vger.kernel.org, paulus@samba.org
References: <200501281456.j0SEuI12020454@d01av01.pok.ibm.com> <20050131192955.GJ31145@parcelfarce.linux.theplanet.co.uk> <41FEA4AA.1080407@us.ibm.com>
In-Reply-To: <41FEA4AA.1080407@us.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_cmq/BYwyTitJF1I";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200501312256.44692.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_cmq/BYwyTitJF1I
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Maandag 31 Januar 2005 22:35, Brian King wrote:
> Matthew Wilcox wrote:
> > Basically, ppc64's config ops are broken and need to check the offset
> > being read. =A0Here's i386:
> >=20
> > static int pci_conf1_write (int seg, int bus, int devfn, int reg, int l=
en, u32 v
> > alue)
> > {
> > =A0 =A0 =A0 =A0 unsigned long flags;
> >=20
> > =A0 =A0 =A0 =A0 if ((bus > 255) || (devfn > 255) || (reg > 255))=20
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>=20
> Here is a pure ppc64 implementation that does this.

Actually, it doesn't:

> +static int config_access_valid(struct device_node *dn, int where)
> +{
> +=A0=A0=A0=A0=A0=A0=A0struct device_node *hose_dn =3D dn->phb->arch_data;
> +
> +=A0=A0=A0=A0=A0=A0=A0if (where < 256 || hose_dn->pci_ext_config_space)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return 1;

This needs a check for (where < 4096) in case of PCIe or PCI-X.

> @@ -62,6 +72,8 @@ static int rtas_read_config(struct devic
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return PCIBIOS_DEVICE_NOT=
_FOUND;
> =A0=A0=A0=A0=A0=A0=A0=A0if (where & (size - 1))
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return PCIBIOS_BAD_REGIST=
ER_NUMBER;
> +=A0=A0=A0=A0=A0=A0=A0if (!config_access_valid(dn, where))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return PCIBIOS_BAD_REGISTER=
_NUMBER;
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0addr =3D (dn->busno << 16) | (dn->devfn << 8) | w=
here;

addr is still wrong, see my previous mail.

> @@ -110,6 +122,8 @@ static int rtas_write_config(struct devi
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return PCIBIOS_DEVICE_NOT=
_FOUND;
> =A0=A0=A0=A0=A0=A0=A0=A0if (where & (size - 1))
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return PCIBIOS_BAD_REGIST=
ER_NUMBER;
> +=A0=A0=A0=A0=A0=A0=A0if (!config_access_valid(dn, where))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return PCIBIOS_BAD_REGISTER=
_NUMBER;
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0addr =3D (dn->busno << 16) | (dn->devfn << 8) | w=
here;

same here

> @@ -285,6 +309,7 @@ static int __devinit setup_phb(struct de
> =A0=A0=A0=A0=A0=A0=A0=A0phb->arch_data =3D dev;
> =A0=A0=A0=A0=A0=A0=A0=A0phb->ops =3D &rtas_pci_ops;
> =A0=A0=A0=A0=A0=A0=A0=A0phb->buid =3D get_phb_buid(dev);
> +=A0=A0=A0=A0=A0=A0=A0get_phb_config_space_type(dev);
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0return 0;
> =A0}

Isn't the config space size a property of the PCI device instead of the
host bridge? For a PCI device behind a PCIe host bridge, this could
still lead to an incorrect config space accesses.

	Arnd <><

PS: I got a permanent fatal error from <linux-pci@vger.kernel.org>, does
that list actually exist?

--Boundary-02=_cmq/BYwyTitJF1I
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBB/qmc5t5GS2LDRf4RAhecAJ977PLjW2gsolIYtEygS06nEBfl9wCgl6cc
4rJ7+4PptxcgsSYPCceZUu0=
=5cMq
-----END PGP SIGNATURE-----

--Boundary-02=_cmq/BYwyTitJF1I--
