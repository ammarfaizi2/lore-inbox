Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262505AbVAEQR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262505AbVAEQR6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 11:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbVAEQQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 11:16:05 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:42634 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261207AbVAEQOn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 11:14:43 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: [discuss] Re: unregister_ioctl32_conversion and modules. ioct l32 revisited.
Date: Wed, 5 Jan 2005 17:07:38 +0100
User-Agent: KMail/1.6.2
Cc: discuss@x86-64.org, Chris Wedgwood <cw@f00f.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, pavel@suse.cz, gordon.jin@intel.com,
       Christoph Hellwig <hch@infradead.org>
References: <200412262349.24856.arnd@arndb.de> <20050105152511.GB19758@mellanox.co.il>
In-Reply-To: <20050105152511.GB19758@mellanox.co.il>
MIME-Version: 1.0
Message-Id: <200501051707.38960.arnd@arndb.de>
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_KDB3B416MXDVc/h";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_KDB3B416MXDVc/h
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Middeweken 05 Januar 2005 16:25, Michael S. Tsirkin wrote:
> You mean like this?

Yes, except that

> Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
> --- linux-2.6.10/fs/ioctl.c.ok =A02005-01-05 21:13:46.165718632 +0200
> +++ linux-2.6.10/fs/ioctl.c =A0 =A0 2005-01-05 21:14:09.341195424 +0200
> @@ -162,7 +162,7 @@ asmlinkage long sys_ioctl(unsigned int f
> =A0out:
> =A0 =A0 =A0 =A0 fput_light(filp, fput_needed);
> =A0out2:
> - =A0 =A0 =A0 return error;
> + =A0 =A0 =A0 return error=3D=3D-ENOIOCTLCMD?-ENOTTY:error;
> =A0}
>=20
> =A0/*

=2D Spacing is broken.
=2D I think the convention would be to use EINVAL here. ENOTTY mean 'this
  device does not support ioctl', while EINVAL is used for 'ioctl is
  supported, but not this number'.
=2D I would put the conversion only in the place that calls ->native_ioctl
  in order to make clearer why it is done.

> --- linux-2.6.10/fs/compat.c.ok 2005-01-05 21:15:34.221291688 +0200
> +++ linux-2.6.10/fs/compat.c =A0 =A02005-01-05 21:16:04.922624376 +0200
> @@ -476,7 +476,7 @@ asmlinkage long compat_sys_ioctl(unsigne
> =A0out:
> =A0 =A0 =A0 =A0 fput_light(filp, fput_needed);
> =A0out2:
> - =A0 =A0 =A0 return error;
> + =A0 =A0 =A0 return error=3D=3D-ENOIOCTLCMD?-ENOTTY:error;
> =A0}
>=20
> =A0static int get_compat_flock(struct flock *kfl, struct compat_flock __u=
ser *ufl)

I don't think it's needed for the compat case, as we are already
handling ENOIOCTLCMD here by doing to hash lookup.

I'd also prefer the code to be based on Christophs version, which=20
unfortunately is lacking handling for ENOIOCTLCMD from compat_ioctl,
but otherwise looks better.

	Arnd <><

--Boundary-02=_KDB3B416MXDVc/h
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD4DBQBB3BDK5t5GS2LDRf4RAoHbAKCZsllv//+mdndjvV4xTno5tXh2GwCYkgcz
2elZe+/ITt3rpFFxqLiF2A==
=kdnk
-----END PGP SIGNATURE-----

--Boundary-02=_KDB3B416MXDVc/h--
