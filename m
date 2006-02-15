Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030580AbWBPTJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030580AbWBPTJe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 14:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030619AbWBPTJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 14:09:34 -0500
Received: from master.altlinux.org ([62.118.250.235]:19728 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1030580AbWBPTJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 14:09:33 -0500
Date: Wed, 15 Feb 2006 23:57:25 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Davi Arnaut <davi.arnaut@gmail.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] strndup_user, convert (module)
Message-Id: <20060215235725.15d54441.vsu@altlinux.ru>
In-Reply-To: <20060215182306.d26a4121.davi.arnaut@gmail.com>
References: <20060215182306.d26a4121.davi.arnaut@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__15_Feb_2006_23_57_25_+0300__HD.vStMtr0koZzR"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__15_Feb_2006_23_57_25_+0300__HD.vStMtr0koZzR
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Feb 2006 18:23:06 -0300 Davi Arnaut wrote:

> Convert kernel/module.c string duplication to strdup_user()
>=20
> Signed-off-by: Davi Arnaut <davi.arnaut@gmail.com>
> --
>=20
> diff --git a/kernel/module.c b/kernel/module.c
> index 5aad477..d7d428d 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -1538,7 +1538,6 @@ static struct module *load_module(void _
>  	unsigned int i, symindex =3D 0, strindex =3D 0, setupindex, exindex,
>  		exportindex, modindex, obsparmindex, infoindex, gplindex,
>  		crcindex, gplcrcindex, versindex, pcpuindex;
> -	long arglen;
>  	struct module *mod;
>  	long err =3D 0;
>  	void *percpu =3D NULL, *ptr =3D NULL; /* Stops spurious gcc warning */
> @@ -1655,23 +1654,11 @@ static struct module *load_module(void _
>  	}
> =20
>  	/* Now copy in args */
> -	arglen =3D strlen_user(uargs);
> -	if (!arglen) {
> -		err =3D -EFAULT;
> -		goto free_hdr;
> -	}
> -	args =3D kmalloc(arglen, GFP_KERNEL);
> -	if (!args) {
> -		err =3D -ENOMEM;
> +	args =3D strdup_user(uargs);

Before your changes the args string was limited by the maximum size
supported by kmalloc(); you have changed the limit to 4096 hardcoded
inside strdup_user(), which is much lower.

> +	if (IS_ERR(args)) {
> +		err =3D PTR_ERR(args);
>  		goto free_hdr;
>  	}
> -	if (copy_from_user(args, uargs, arglen) !=3D 0) {
> -		err =3D -EFAULT;
> -		goto free_mod;
> -	}
> -
> -	/* Userspace could have altered the string after the strlen_user() */
> -	args[arglen - 1] =3D '\0';
> =20
>  	if (find_module(mod->name)) {
>  		err =3D -EEXIST;

--Signature=_Wed__15_Feb_2006_23_57_25_+0300__HD.vStMtr0koZzR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.17 (GNU/Linux)

iD8DBQFD85W1W82GfkQfsqIRAv6aAJwIpLqkDi46AVrqyEjLpP8TnwS/FgCfbGTK
7aExdRdW4h59GcDn8VNwiVI=
=FJcU
-----END PGP SIGNATURE-----

--Signature=_Wed__15_Feb_2006_23_57_25_+0300__HD.vStMtr0koZzR--
