Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031709AbWLASgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031709AbWLASgW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 13:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031711AbWLASgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 13:36:22 -0500
Received: from cattelan-host202.dsl.visi.com ([208.42.117.202]:20453 "EHLO
	slurp.thebarn.com") by vger.kernel.org with ESMTP id S1031709AbWLASgW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 13:36:22 -0500
Subject: Re: [GFS2] Remove unused function from inode.c [50/70]
From: Russell Cattelan <cattelan@thebarn.com>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <1164889273.3752.405.camel@quoit.chygwyn.com>
References: <1164889273.3752.405.camel@quoit.chygwyn.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-nPz7w/BdnXxkdF2P025l"
Date: Fri, 01 Dec 2006 12:35:58 -0600
Message-Id: <1164998159.1194.54.camel@xenon.msp.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1-1mdv2007.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nPz7w/BdnXxkdF2P025l
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-11-30 at 12:21 +0000, Steven Whitehouse wrote:
> >From dcd2479959c79d44f5dd77e71672e70f1f8b1f06 Mon Sep 17 00:00:00 2001
> From: Steven Whitehouse <swhiteho@redhat.com>
> Date: Thu, 16 Nov 2006 11:08:16 -0500
> Subject: [PATCH] [GFS2] Remove unused function from inode.c
>=20
> The gfs2_glock_nq_m_atime function is unused in so far as its only
> ever called with num_gh =3D 1, and this falls through to the
> gfs2_glock_nq_atime function, so we might as well call that directly.

does gfs support a noatime type of option?

I seems like reason for the split was to allow for that
possibility?

>=20
> Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
> ---
>  fs/gfs2/inode.c       |   86 -------------------------------------------=
------
>  fs/gfs2/inode.h       |    4 --
>  fs/gfs2/ops_address.c |    8 ++---
>  fs/gfs2/ops_file.c    |    2 +
>  4 files changed, 5 insertions(+), 95 deletions(-)
>=20
> diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> index ea9ca23..ce7f833 100644
> --- a/fs/gfs2/inode.c
> +++ b/fs/gfs2/inode.c
> @@ -1234,92 +1234,6 @@ fail:
>  	return error;
>  }
> =20
> -/**
> - * glock_compare_atime - Compare two struct gfs2_glock structures for so=
rt
> - * @arg_a: the first structure
> - * @arg_b: the second structure
> - *
> - * Returns: 1 if A > B
> - *         -1 if A < B
> - *          0 if A =3D=3D B
> - */
> -
> -static int glock_compare_atime(const void *arg_a, const void *arg_b)
> -{
> -	const struct gfs2_holder *gh_a =3D *(const struct gfs2_holder **)arg_a;
> -	const struct gfs2_holder *gh_b =3D *(const struct gfs2_holder **)arg_b;
> -	const struct lm_lockname *a =3D &gh_a->gh_gl->gl_name;
> -	const struct lm_lockname *b =3D &gh_b->gh_gl->gl_name;
> -
> -	if (a->ln_number > b->ln_number)
> -		return 1;
> -	if (a->ln_number < b->ln_number)
> -		return -1;
> -	if (gh_a->gh_state =3D=3D LM_ST_SHARED && gh_b->gh_state =3D=3D LM_ST_E=
XCLUSIVE)
> -		return 1;
> -	if (gh_a->gh_state =3D=3D LM_ST_SHARED && (gh_b->gh_flags & GL_ATIME))
> -		return 1;
> -
> -	return 0;
> -}
> -
> -/**
> - * gfs2_glock_nq_m_atime - acquire multiple glocks where one may need an
> - *      atime update
> - * @num_gh: the number of structures
> - * @ghs: an array of struct gfs2_holder structures
> - *
> - * Returns: 0 on success (all glocks acquired),
> - *          errno on failure (no glocks acquired)
> - */
> -
> -int gfs2_glock_nq_m_atime(unsigned int num_gh, struct gfs2_holder *ghs)
> -{
> -	struct gfs2_holder **p;
> -	unsigned int x;
> -	int error =3D 0;
> -
> -	if (!num_gh)
> -		return 0;
> -
> -	if (num_gh =3D=3D 1) {
> -		ghs->gh_flags &=3D ~(LM_FLAG_TRY | GL_ASYNC);
> -		if (ghs->gh_flags & GL_ATIME)
> -			error =3D gfs2_glock_nq_atime(ghs);
> -		else
> -			error =3D gfs2_glock_nq(ghs);
> -		return error;
> -	}
> -
> -	p =3D kcalloc(num_gh, sizeof(struct gfs2_holder *), GFP_KERNEL);
> -	if (!p)
> -		return -ENOMEM;
> -
> -	for (x =3D 0; x < num_gh; x++)
> -		p[x] =3D &ghs[x];
> -
> -	sort(p, num_gh, sizeof(struct gfs2_holder *), glock_compare_atime,NULL)=
;
> -
> -	for (x =3D 0; x < num_gh; x++) {
> -		p[x]->gh_flags &=3D ~(LM_FLAG_TRY | GL_ASYNC);
> -
> -		if (p[x]->gh_flags & GL_ATIME)
> -			error =3D gfs2_glock_nq_atime(p[x]);
> -		else
> -			error =3D gfs2_glock_nq(p[x]);
> -
> -		if (error) {
> -			while (x--)
> -				gfs2_glock_dq(p[x]);
> -			break;
> -		}
> -	}
> -
> -	kfree(p);
> -	return error;
> -}
> -
> -
>  static int
>  __gfs2_setattr_simple(struct gfs2_inode *ip, struct iattr *attr)
>  {
> diff --git a/fs/gfs2/inode.h b/fs/gfs2/inode.h
> index 46917ed..b57f448 100644
> --- a/fs/gfs2/inode.h
> +++ b/fs/gfs2/inode.h
> @@ -50,12 +50,8 @@ int gfs2_unlink_ok(struct gfs2_inode *di
>  		   struct gfs2_inode *ip);
>  int gfs2_ok_to_move(struct gfs2_inode *this, struct gfs2_inode *to);
>  int gfs2_readlinki(struct gfs2_inode *ip, char **buf, unsigned int *len)=
;
> -
>  int gfs2_glock_nq_atime(struct gfs2_holder *gh);
> -int gfs2_glock_nq_m_atime(unsigned int num_gh, struct gfs2_holder *ghs);
> -
>  int gfs2_setattr_simple(struct gfs2_inode *ip, struct iattr *attr);
> -
>  struct inode *gfs2_lookup_simple(struct inode *dip, const char *name);
> =20
>  #endif /* __INODE_DOT_H__ */
> diff --git a/fs/gfs2/ops_address.c b/fs/gfs2/ops_address.c
> index 2f7ef98..8676c39 100644
> --- a/fs/gfs2/ops_address.c
> +++ b/fs/gfs2/ops_address.c
> @@ -217,7 +217,7 @@ static int gfs2_readpage(struct file *fi
>  		}
>  		gfs2_holder_init(ip->i_gl, LM_ST_SHARED, GL_ATIME|LM_FLAG_TRY_1CB, &gh=
);
>  		do_unlock =3D 1;
> -		error =3D gfs2_glock_nq_m_atime(1, &gh);
> +		error =3D gfs2_glock_nq_atime(&gh);
>  		if (unlikely(error))
>  			goto out_unlock;
>  	}
> @@ -282,7 +282,7 @@ static int gfs2_readpages(struct file *f
>  		gfs2_holder_init(ip->i_gl, LM_ST_SHARED,
>  				 LM_FLAG_TRY_1CB|GL_ATIME, &gh);
>  		do_unlock =3D 1;
> -		ret =3D gfs2_glock_nq_m_atime(1, &gh);
> +		ret =3D gfs2_glock_nq_atime(&gh);
>  		if (ret =3D=3D GLR_TRYFAILED)
>  			goto out_noerror;
>  		if (unlikely(ret))
> @@ -354,7 +354,7 @@ static int gfs2_prepare_write(struct fil
> =20
>=20
>  	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, GL_ATIME|LM_FLAG_TRY_1CB, &=
ip->i_gh);
> -	error =3D gfs2_glock_nq_m_atime(1, &ip->i_gh);
> +	error =3D gfs2_glock_nq_atime(&ip->i_gh);
>  	if (unlikely(error)) {
>  		if (error =3D=3D GLR_TRYFAILED)
>  			error =3D AOP_TRUNCATED_PAGE;
> @@ -609,7 +609,7 @@ static ssize_t gfs2_direct_IO(int rw, st
>  	 * on this path. All we need change is atime.
>  	 */
>  	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, GL_ATIME, &gh);
> -	rv =3D gfs2_glock_nq_m_atime(1, &gh);
> +	rv =3D gfs2_glock_nq_atime(&gh);
>  	if (rv)
>  		goto out;
> =20
> diff --git a/fs/gfs2/ops_file.c b/fs/gfs2/ops_file.c
> index eabf6c6..c2be216 100644
> --- a/fs/gfs2/ops_file.c
> +++ b/fs/gfs2/ops_file.c
> @@ -253,7 +253,7 @@ static int gfs2_get_flags(struct file *f
>  	u32 fsflags;
> =20
>  	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, GL_ATIME, &gh);
> -	error =3D gfs2_glock_nq_m_atime(1, &gh);
> +	error =3D gfs2_glock_nq_atime(&gh);
>  	if (error)
>  		return error;
> =20
--=20
Russell Cattelan <cattelan@thebarn.com>

--=-nPz7w/BdnXxkdF2P025l
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFcHYONRmM+OaGhBgRAqzrAJ41/F5PXqIDJpACadAYWE+jcGE41wCdG/zA
L6TBN3VZhJIOFpEOJc65Kto=
=CaZi
-----END PGP SIGNATURE-----

--=-nPz7w/BdnXxkdF2P025l--

