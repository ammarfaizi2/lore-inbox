Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWEGPWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWEGPWO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 11:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWEGPWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 11:22:14 -0400
Received: from master.altlinux.org ([62.118.250.235]:54538 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP id S932175AbWEGPWN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 11:22:13 -0400
Date: Sun, 7 May 2006 19:22:06 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Michael Buesch <mb@bu3sch.de>
Cc: akpm@osdl.org, Deepak Saxena <dsaxena@plexity.net>,
       bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/6] New Generic HW RNG (#2)
Message-ID: <20060507152206.GC14704@procyon.home>
References: <20060507143806.465264000@pc1> <20060507144257.311084000@pc1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ABTtc+pdwF7KHXCz"
Content-Disposition: inline
In-Reply-To: <20060507144257.311084000@pc1>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ABTtc+pdwF7KHXCz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 07, 2006 at 04:38:09PM +0200, Michael Buesch wrote:
> Add a driver for the x86 RNG.
> This driver is ported from the old hw_random.c
>=20
[skip]
> +static int __init intel_init(struct hwrng *rng)

Cannot be __init anymore - now rng->init could be called at any time.

Also, there is another problem with putting this function into
rng->init - if another RNG has been registered when this module is
loaded, ->init will not be called during hwrng_register(), so the
module load will succeed even if the chipset does not have RNG
hardware.

> +{
> +	void __iomem *rng_mem;
> +	int rc;
> +	u8 hw_status;
> +
> +	DPRINTK ("ENTER\n");
> +
> +	rng_mem =3D ioremap (INTEL_RNG_ADDR, INTEL_RNG_ADDR_LEN);
> +	if (rng_mem =3D=3D NULL) {
> +		printk (KERN_ERR PFX "cannot ioremap RNG Memory\n");
> +		rc =3D -EBUSY;
> +		goto err_out;
> +	}
> +	rng->priv =3D (unsigned long)rng_mem;
> +
> +	/* Check for Intel 82802 */
> +	hw_status =3D intel_hwstatus (rng_mem);
> +	if ((hw_status & INTEL_RNG_PRESENT) =3D=3D 0) {
> +		printk (KERN_ERR PFX "RNG not detected\n");
> +		rc =3D -ENODEV;
> +		goto err_out_free_map;
> +	}
> +
> +	/* turn RNG h/w on, if it's off */
> +	if ((hw_status & INTEL_RNG_ENABLED) =3D=3D 0)
> +		hw_status =3D intel_hwstatus_set (rng_mem, hw_status | INTEL_RNG_ENABL=
ED);
> +	if ((hw_status & INTEL_RNG_ENABLED) =3D=3D 0) {
> +		printk (KERN_ERR PFX "cannot enable RNG, aborting\n");
> +		rc =3D -EIO;
> +		goto err_out_free_map;
> +	}
> +
> +	DPRINTK ("EXIT, returning 0\n");
> +	return 0;
> +
> +err_out_free_map:
> +	iounmap (rng_mem);
> +err_out:
> +	DPRINTK ("EXIT, returning %d\n", rc);
> +	return rc;
> +}
> +
[skip]
> +static int __init amd_init(struct hwrng *rng)

Again, __init is wrong.

[skip]
> +static int __init via_init(struct hwrng *rng)

This __init is wrong too.

[skip]

--ABTtc+pdwF7KHXCz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEXhCeW82GfkQfsqIRAo1UAJ4wy+p7BjthUrr69SxLMolmNwdilgCfVdWb
zqH2Qkdv22ySiHOMpIMn3hg=
=oD6p
-----END PGP SIGNATURE-----

--ABTtc+pdwF7KHXCz--
