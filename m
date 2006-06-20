Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965035AbWFTBQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965035AbWFTBQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 21:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbWFTBQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 21:16:56 -0400
Received: from ozlabs.org ([203.10.76.45]:51172 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965035AbWFTBQz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 21:16:55 -0400
Subject: Re: [patch 07/20] spufs: fix deadlock in spu_create error path
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: arnd@arndb.de
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060619183404.966781000@klappe.arndb.de>
References: <20060619183315.653672000@klappe.arndb.de>
	 <20060619183404.966781000@klappe.arndb.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Mg4JLy10LVMJl5qC7VfC"
Date: Tue, 20 Jun 2006 11:16:52 +1000
Message-Id: <1150766213.7054.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Mg4JLy10LVMJl5qC7VfC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-06-19 at 20:33 +0200, arnd@arndb.de wrote:
> plain text document attachment (spufs-rmdir-3.diff)
> From: Michael Ellerman <michael@ellerman.id.au>
>=20
> spufs_rmdir tries to acquire the spufs root
> i_mutex, which is already held by spufs_create_thread.
>=20
> This was tracked as Bug #H9512.
>=20
> Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

I should have signed this off when I sent it .. but FWIW:

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

> ---
>=20
> Index: powerpc.git/arch/powerpc/platforms/cell/spufs/inode.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- powerpc.git.orig/arch/powerpc/platforms/cell/spufs/inode.c
> +++ powerpc.git/arch/powerpc/platforms/cell/spufs/inode.c
> @@ -157,20 +157,12 @@ static void spufs_prune_dir(struct dentr
>  	mutex_unlock(&dir->d_inode->i_mutex);
>  }
> =20
> +/* Caller must hold root->i_mutex */
>  static int spufs_rmdir(struct inode *root, struct dentry *dir_dentry)
>  {
> -	struct spu_context *ctx;
> -
>  	/* remove all entries */
> -	mutex_lock(&root->i_mutex);
>  	spufs_prune_dir(dir_dentry);
> -	mutex_unlock(&root->i_mutex);
> =20
> -	/* We have to give up the mm_struct */
> -	ctx =3D SPUFS_I(dir_dentry->d_inode)->i_ctx;
> -	spu_forget(ctx);
> -
> -	/* XXX Do we need to hold i_mutex here ? */
>  	return simple_rmdir(root, dir_dentry);
>  }
> =20
> @@ -199,16 +191,23 @@ out:
> =20
>  static int spufs_dir_close(struct inode *inode, struct file *file)
>  {
> +	struct spu_context *ctx;
>  	struct inode *dir;
>  	struct dentry *dentry;
>  	int ret;
> =20
>  	dentry =3D file->f_dentry;
>  	dir =3D dentry->d_parent->d_inode;
> +	ctx =3D SPUFS_I(dentry->d_inode)->i_ctx;
> =20
> +	mutex_lock(&dir->i_mutex);
>  	ret =3D spufs_rmdir(dir, dentry);
> +	mutex_unlock(&dir->i_mutex);
>  	WARN_ON(ret);
> =20
> +	/* We have to give up the mm_struct */
> +	spu_forget(ctx);
> +
>  	return dcache_dir_close(inode, file);
>  }
> =20
> @@ -324,8 +323,13 @@ long spufs_create_thread(struct nameidat
>  	 * in error path of *_open().
>  	 */
>  	ret =3D spufs_context_open(dget(dentry), mntget(nd->mnt));
> -	if (ret < 0)
> -		spufs_rmdir(nd->dentry->d_inode, dentry);
> +	if (ret < 0) {
> +		WARN_ON(spufs_rmdir(nd->dentry->d_inode, dentry));
> +		mutex_unlock(&nd->dentry->d_inode->i_mutex);
> +		spu_forget(SPUFS_I(dentry->d_inode)->i_ctx);
> +		dput(dentry);
> +		goto out;
> +	}
> =20
>  out_dput:
>  	dput(dentry);


--=-Mg4JLy10LVMJl5qC7VfC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEl0yEdSjSd0sB4dIRAqlHAJ9k3i+l85JaEuVk1A3g1qFXuhJDOwCeJd+y
Yxli+z6VU7a0XVB97YwIGqs=
=JOH9
-----END PGP SIGNATURE-----

--=-Mg4JLy10LVMJl5qC7VfC--

