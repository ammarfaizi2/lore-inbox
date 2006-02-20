Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932605AbWBTM4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605AbWBTM4v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 07:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932611AbWBTM4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 07:56:50 -0500
Received: from mivlgu.ru ([81.18.140.87]:16556 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S932605AbWBTM4u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 07:56:50 -0500
Date: Mon, 20 Feb 2006 15:56:38 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Willy Tarreau <willy@w.ods.org>
Cc: Greg KH <greg@kroah.com>, Stephen Hemminger <shemminger@osdl.org>,
       Brian Hall <brihall@pcisys.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Help: DGE-560T not recognized by Linux
Message-ID: <20060220125638.GA26440@master.mivlgu.local>
References: <20060217222720.a08a2bc1.brihall@pcisys.net> <20060217222428.3cf33f25.akpm@osdl.org> <20060218003622.30a2b501.brihall@pcisys.net> <20060217234841.5f2030ec.akpm@osdl.org> <20060218100126.198d86c3.brihall@pcisys.net> <20060218222946.4da27618.vsu@altlinux.ru> <20060218163555.39fa3b4a@localhost.localdomain> <20060219010441.GA5810@kroah.com> <20060220114341.GA7710@w.ods.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <20060220114341.GA7710@w.ods.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2006 at 12:43:41PM +0100, Willy Tarreau wrote:
> Today, I had the *exact* same problem on one server equipped with the same
> card. I tried the patch above which did not change anything. However, I
> finally fixed it by simply enabling ACPI. Then it always works with and
> without the patch above. I could not test marvell's driver because it does
> not build on 2.6.16-rc4, but strangely my previous kernel on this machine
> was a 2.6.12-rc4-mm2 patched with marvell's driver and with ACPI disabled.
>=20
> So it seems that marvell's driver on 2.6.12 was able to access config spa=
ce
> even without ACPI while sky2 on 2.6.16-rc4 cannot. I have no idea why,
> unfortunately.

Apparently Marvell's driver accesses PCIE configuration registers through
I/O ports specific to their hardware:

/*
 *	Macro PCI_C()
 *
 *	Use this macro to access PCI config register from the I/O space.
 *
 * para:
 *	pAC		Pointer to adapter context
 *	Addr	PCI configuration register to access.
 *			Values:	PCI_VENDOR_ID ... PCI_VPD_ADR_REG,
 *
 * usage	SK_IN16(IoC, PCI_C(pAC, PCI_VENDOR_ID), pVal);
 */
#define PCI_C(p, Addr)		\
	(((CHIP_ID_YUKON_2(p)) ? Y2_CFG_SPC : B7_CFG_SPC) + (Addr))

=2E..

			/* clear any PEX errors */
			SK_OUT32(IoC, PCI_C(pAC, PEX_UNC_ERR_STAT), 0xffffffffUL);

			SK_IN16(IoC, PCI_C(pAC, PEX_LNK_STAT), &Word);

			pAC->GIni.GIPexWidth =3D (SK_U8)((Word & PEX_LS_LINK_WI_MSK) >> 4);

=2E..

			SK_OUT8(IoC, B2_TST_CTRL1, TST_CFG_WRITE_ON);

			SK_OUT16(IoC, PCI_C(pAC, PEX_DEV_CTRL), Word);

			SK_OUT8(IoC, B2_TST_CTRL1, TST_CFG_WRITE_OFF);

=2E..

		/* clear the interrupt */
		SK_OUT32(IoC, B2_TST_CTRL1, TST_CFG_WRITE_ON);
		SK_OUT32(IoC, PCI_C(pAC, PEX_UNC_ERR_STAT), 0xffffffffUL);
		SK_OUT32(IoC, B2_TST_CTRL1, TST_CFG_WRITE_OFF);

But sky2 uses standard pci_read_config_*, pci_write_config_* functions,
which require working MMCONFIG access.  Maybe sky2 should be changed to
use I/O space for access to PCIE-specific configuration registers.

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFD+byGW82GfkQfsqIRAn7BAJ48ul6EbvmdW0vS+IFlg9bWzp/gCgCeJSqC
8ZZVQ36F7eyAAmNYEcmoD3I=
=Mccn
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
