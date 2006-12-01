Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031679AbWLAS0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031679AbWLAS0V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 13:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031684AbWLAS0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 13:26:21 -0500
Received: from cattelan-host202.dsl.visi.com ([208.42.117.202]:53700 "EHLO
	slurp.thebarn.com") by vger.kernel.org with ESMTP id S1031679AbWLAS0U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 13:26:20 -0500
Subject: Re: [GFS2] Shrink gfs2_inode (8) - i_vn [28/70]
From: Russell Cattelan <cattelan@thebarn.com>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <1164889002.3752.360.camel@quoit.chygwyn.com>
References: <1164889002.3752.360.camel@quoit.chygwyn.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-fI6RmWap8OyJZ7pKQ/VP"
Date: Fri, 01 Dec 2006 12:25:30 -0600
Message-Id: <1164997530.1194.52.camel@xenon.msp.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1-1mdv2007.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fI6RmWap8OyJZ7pKQ/VP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-11-30 at 12:16 +0000, Steven Whitehouse wrote:
> >From bfded27ba010d1c3b0aa3843f97dc9b80de751be Mon Sep 17 00:00:00 2001
> From: Steven Whitehouse <swhiteho@redhat.com>
> Date: Wed, 1 Nov 2006 16:05:38 -0500
> Subject: [PATCH] [GFS2] Shrink gfs2_inode (8) - i_vn
>=20
> This shrinks the size of the gfs2_inode by 8 bytes by
> replacing the version counter with a one bit valid/invalid
> flag.
What is the version number used for?
It seems like anything that was specifically carving a 64 container
has a more specific reason that just ON/OFF?



>=20
> Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
> ---
>  fs/gfs2/glops.c     |    5 +++--
>  fs/gfs2/incore.h    |    2 +-
>  fs/gfs2/inode.c     |    4 ++--
>  fs/gfs2/ops_inode.c |    2 +-
>  4 files changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
> index aad45b7..9c20337 100644
> --- a/fs/gfs2/glops.c
> +++ b/fs/gfs2/glops.c
> @@ -305,8 +305,9 @@ static void inode_go_inval(struct gfs2_g
>  	int data =3D (flags & DIO_DATA);
> =20
>  	if (meta) {
> +		struct gfs2_inode *ip =3D gl->gl_object;
>  		gfs2_meta_inval(gl);
> -		gl->gl_vn++;
> +		set_bit(GIF_INVALID, &ip->i_flags);
>  	}
>  	if (data)
>  		gfs2_page_inval(gl);
> @@ -351,7 +352,7 @@ static int inode_go_lock(struct gfs2_hol
>  	if (!ip)
>  		return 0;
> =20
> -	if (ip->i_vn !=3D gl->gl_vn) {
> +	if (test_bit(GIF_INVALID, &ip->i_flags)) {
>  		error =3D gfs2_inode_refresh(ip);
>  		if (error)
>  			return error;
> diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
> index c0a8c3b..227a74d 100644
> --- a/fs/gfs2/incore.h
> +++ b/fs/gfs2/incore.h
> @@ -217,6 +217,7 @@ struct gfs2_alloc {
>  };
> =20
>  enum {
> +	GIF_INVALID		=3D 0,
>  	GIF_QD_LOCKED		=3D 1,
>  	GIF_PAGED		=3D 2,
>  	GIF_SW_PAGED		=3D 3,
> @@ -228,7 +229,6 @@ struct gfs2_inode {
> =20
>  	unsigned long i_flags;		/* GIF_... */
> =20
> -	u64 i_vn;
>  	struct gfs2_dinode_host i_di; /* To be replaced by ref to block */
> =20
>  	struct gfs2_glock *i_gl; /* Move into i_gh? */
> diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> index f6177fc..e467780 100644
> --- a/fs/gfs2/inode.c
> +++ b/fs/gfs2/inode.c
> @@ -145,7 +145,7 @@ struct inode *gfs2_inode_lookup(struct s
>  		if (unlikely(error))
>  			goto fail_put;
> =20
> -		ip->i_vn =3D ip->i_gl->gl_vn - 1;
> +		set_bit(GIF_INVALID, &ip->i_flags);
>  		error =3D gfs2_glock_nq_init(io_gl, LM_ST_SHARED, GL_EXACT, &ip->i_iop=
en_gh);
>  		if (unlikely(error))
>  			goto fail_iopen;
> @@ -242,7 +242,7 @@ int gfs2_inode_refresh(struct gfs2_inode
> =20
>  	error =3D gfs2_dinode_in(ip, dibh->b_data);
>  	brelse(dibh);
> -	ip->i_vn =3D ip->i_gl->gl_vn;
> +	clear_bit(GIF_INVALID, &ip->i_flags);
> =20
>  	return error;
>  }
> diff --git a/fs/gfs2/ops_inode.c b/fs/gfs2/ops_inode.c
> index 0e4eade..b247f25 100644
> --- a/fs/gfs2/ops_inode.c
> +++ b/fs/gfs2/ops_inode.c
> @@ -844,7 +844,7 @@ static int gfs2_permission(struct inode=20
>  	struct gfs2_holder i_gh;
>  	int error;
> =20
> -	if (ip->i_vn =3D=3D ip->i_gl->gl_vn)
> +	if (!test_bit(GIF_INVALID, &ip->i_flags))
>  		return generic_permission(inode, mask, gfs2_check_acl);
> =20
>  	error =3D gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_ANY, &i_gh=
);
--=20
Russell Cattelan <cattelan@thebarn.com>

--=-fI6RmWap8OyJZ7pKQ/VP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFcHOaNRmM+OaGhBgRAgfDAJ4jdSZUhueQ/iVyjXi9M3DK8jJlJgCggnaw
IyKU/Hv1kWhpFCMinEpbAf0=
=fJz5
-----END PGP SIGNATURE-----

--=-fI6RmWap8OyJZ7pKQ/VP--

