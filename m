Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030569AbWBPTJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030569AbWBPTJd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 14:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030619AbWBPTJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 14:09:33 -0500
Received: from master.altlinux.org ([62.118.250.235]:19984 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1030569AbWBPTJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 14:09:33 -0500
Date: Wed, 15 Feb 2006 23:54:01 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Davi Arnaut <davi.arnaut@gmail.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] strndup_user, v2
Message-Id: <20060215235401.381eea7c.vsu@altlinux.ru>
In-Reply-To: <20060215182258.03505613.davi.arnaut@gmail.com>
References: <20060215182258.03505613.davi.arnaut@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__15_Feb_2006_23_54_01_+0300_Lb0Jh6IqptVOjJC5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__15_Feb_2006_23_54_01_+0300_Lb0Jh6IqptVOjJC5
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Feb 2006 18:22:58 -0300 Davi Arnaut wrote:

> This patch series creates a strndup_user() function in order to avoid dup=
licated
> and error-prone (userspace modifying the string after the strlen_user()) =
code.
>=20
> v2: Inline strdup_user and fixed a bogus strdup_user usage.
>=20
> The diffstat:
>=20
>  include/linux/string.h |    7 ++
>  kernel/module.c        |   19 +-------
>  mm/util.c              |   37 +++++++++++++++
>  security/keys/keyctl.c |  116 ++++++++++--------------------------------=
-------
>  4 files changed, 72 insertions(+), 107 deletions(-)
>=20
>=20
> Signed-off-by: Davi Arnaut <davi.arnaut@gmail.com>
> --
>=20
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 369be32..8fbf139 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -18,6 +18,13 @@ extern char * strsep(char **,const char=20
>  extern __kernel_size_t strspn(const char *,const char *);
>  extern __kernel_size_t strcspn(const char *,const char *);
> =20
> +extern char *strndup_user(const char __user *, long);
> +
> +static inline char *strdup_user(const char __user *s)
> +{
> +	return strndup_user(s, 4096);

PAGE_SIZE ?

> +}
> +
>  /*
>   * Include machine specific inline routines
>   */
> diff --git a/mm/util.c b/mm/util.c
> index 5f4bb59..09c2c3b 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -1,6 +1,8 @@
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/module.h>
> +#include <linux/err.h>
> +#include <asm/uaccess.h>
> =20
>  /**
>   * kzalloc - allocate memory. The memory is set to zero.
> @@ -37,3 +39,38 @@ char *kstrdup(const char *s, gfp_t gfp)
>  	return buf;
>  }
>  EXPORT_SYMBOL(kstrdup);
> +
> +/*
> + * strndup_user - duplicate an existing string from user space
> + *
> + * @s: The string to duplicate
> + * @n: Maximum number of bytes to copy, including the trailing NUL.
> + */
> +char *strndup_user(const char __user *s, long n)
> +{
> +	char *p;
> +	long length;
> +
> +	length =3D strlen_user(s);

This should be strnlen_user(s, n) - no need to look at the whole
potentially huge string if you already have the limit.

> +
> +	if (!length)
> +		return ERR_PTR(-EFAULT);
> +
> +	if (length > n)
> +		length =3D n;

This silently truncates a too long string, which might not be proper
behavior (in fact, your patch #2 changes the behavior of keyctl
functions, which were rejecting too long strings with -EINVAL - this is
not good).

> +
> +	p =3D kmalloc(length, GFP_KERNEL);
> +
> +	if (!p)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (strncpy_from_user(p, s, length) < 0) {

This can be plain copy_from_user() - you already have the length, and
even if someone sneaks a NUL byte in the middle, copying bytes past it
will not matter.

> +		kfree(p);
> +		return ERR_PTR(-EFAULT);
> +	}
> +
> +	p[length - 1] =3D '\0';
> +
> +	return p;
> +}
> +EXPORT_SYMBOL(strndup_user);

--Signature=_Wed__15_Feb_2006_23_54_01_+0300_Lb0Jh6IqptVOjJC5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.17 (GNU/Linux)

iD8DBQFD85TsW82GfkQfsqIRAmiPAJ9uz1rylC4shXERhl2noUWy/CR7RgCfWjMS
/cT+vI28+W/7DbyMcF7oSiE=
=5DyM
-----END PGP SIGNATURE-----

--Signature=_Wed__15_Feb_2006_23_54_01_+0300_Lb0Jh6IqptVOjJC5--
