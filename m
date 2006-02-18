Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWBRTaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWBRTaO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 14:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWBRTaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 14:30:14 -0500
Received: from master.altlinux.org ([62.118.250.235]:20998 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP id S932118AbWBRTaM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 14:30:12 -0500
Date: Sat, 18 Feb 2006 22:29:46 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Brian Hall <brihall@pcisys.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       shemminger@osdl.org
Subject: Re: Help: DGE-560T not recognized by Linux
Message-Id: <20060218222946.4da27618.vsu@altlinux.ru>
In-Reply-To: <20060218100126.198d86c3.brihall@pcisys.net>
References: <20060217222720.a08a2bc1.brihall@pcisys.net>
	<20060217222428.3cf33f25.akpm@osdl.org>
	<20060218003622.30a2b501.brihall@pcisys.net>
	<20060217234841.5f2030ec.akpm@osdl.org>
	<20060218100126.198d86c3.brihall@pcisys.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sat__18_Feb_2006_22_29_46_+0300_PfMNxkCWixPDpoo1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sat__18_Feb_2006_22_29_46_+0300_PfMNxkCWixPDpoo1
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 18 Feb 2006 10:01:26 -0700 Brian Hall wrote:

> On Fri, 17 Feb 2006 23:48:41 -0800
> Andrew Morton <akpm@osdl.org> wrote:
> > Brian Hall <brihall@pcisys.net> wrote:
> > >  I see that the sky2 driver in 2.6.16rc4 lists my card, but for some
> > >  reason it fails to access the card, maybe because I have an ULi
> > > chipset?
> > >=20
> > >  Feb 17 23:18:46 syrinx sky2 0000:02:00.0: can't access PCI config
> > > space
> >=20
> > Looks like something died way down in the PCI bus config space
> > read/write operations.  I don't know what would cause that.  You
> > could perhaps play with `pci=3Dconf1', `pci=3Dconf2', etc as per
> > Documentation/kernel-parameters.txt.
>=20
> OK, I tried all these pci=3D options, plus acpi=3Doff, to no effect:
> conf1, conf2, nommconf, biosirq, noacpi, routeirq, nosort, rom,
> lastbus=3D2, assign-busses, usepirqmask acpi=3Doff
>=20
> Also tried adjusting PCIe-related stuff in the BIOS (underclocking PCIe
> from 100 to 70 and adjusting Northbridge options). No change.

Most likely it fails here:

		err =3D pci_write_config_dword(hw->pdev, PEX_UNC_ERR_STAT,
						 0xffffffffUL);
		if (err)
			goto pci_err;

PEX_UNC_ERR_STAT is 0x104; this register is outside of the standard
256-byte PCI configuration space, and is reachable only via the MMCONFIG
access mechanism.  Seems that kernel is not using MMCONFIG for some
reason; you mentioned that you have CONFIG_PCI_MMCONFIG=3Dy in kernel
config, so it looks like your BIOS does not provide proper MCFG table.
Full dmesg output might give some clues.

--Signature=_Sat__18_Feb_2006_22_29_46_+0300_PfMNxkCWixPDpoo1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.17 (GNU/Linux)

iD8DBQFD93WuW82GfkQfsqIRAuxnAJwLclAj2H2Jh7ThZSpBMGDQhw0aVgCfUXBa
npmIhimG75v8RZv8uSd6ykU=
=+2pm
-----END PGP SIGNATURE-----

--Signature=_Sat__18_Feb_2006_22_29_46_+0300_PfMNxkCWixPDpoo1--
