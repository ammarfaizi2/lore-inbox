Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031729AbWLASno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031729AbWLASno (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 13:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031707AbWLASno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 13:43:44 -0500
Received: from cattelan-host202.dsl.visi.com ([208.42.117.202]:50160 "EHLO
	slurp.thebarn.com") by vger.kernel.org with ESMTP id S1031729AbWLASno
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 13:43:44 -0500
Subject: Re: [GFS2] Simplify glops functions [53/70]
From: Russell Cattelan <cattelan@thebarn.com>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <1164889293.3752.411.camel@quoit.chygwyn.com>
References: <1164889293.3752.411.camel@quoit.chygwyn.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PVSlZqoPIMqFTX2YodVx"
Date: Fri, 01 Dec 2006 12:43:35 -0600
Message-Id: <1164998615.1194.60.camel@xenon.msp.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1-1mdv2007.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PVSlZqoPIMqFTX2YodVx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-11-30 at 12:21 +0000, Steven Whitehouse wrote:
> >From 1a14d3a68f04527546121eb7b45187ff6af63151 Mon Sep 17 00:00:00 2001
> From: Steven Whitehouse <swhiteho@redhat.com>
> Date: Mon, 20 Nov 2006 10:37:45 -0500
> Subject: [PATCH] [GFS2] Simplify glops functions
>=20
> The go_sync callback took two flags, but one of them was set on every
> call, so this patch removes once of the flags and makes the previously
> conditional operations (on this flag), unconditional.
>=20
> The go_inval callback took three flags, each of which was set on every
> call to it. This patch removes the flags and makes the operations
> unconditional, which makes the logic rather more obvious.

I get really nervous about making these type of interfaces changes
until the problem is understood.

Given the the rather non-function and incomplete state of GFS2 it
seems premature to just remove flags states on the observation
that they are not CURRENTLY used.

>=20
> Two now unused flags are also removed from incore.h.
>=20
> Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
> ---
>  fs/gfs2/glock.c  |   10 +++++-----
>  fs/gfs2/glops.c  |   42 +++++++++++-------------------------------
>  fs/gfs2/incore.h |   25 +++++++++++--------------
>  fs/gfs2/super.c  |    2 +-
>  4 files changed, 28 insertions(+), 51 deletions(-)
>=20
> diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
> index edc21c8..b8ba4d5 100644
> --- a/fs/gfs2/glock.c
> +++ b/fs/gfs2/glock.c
> @@ -847,12 +847,12 @@ static void xmote_bh(struct gfs2_glock *
> =20
>  	if (prev_state !=3D LM_ST_UNLOCKED && !(ret & LM_OUT_CACHEABLE)) {
>  		if (glops->go_inval)
> -			glops->go_inval(gl, DIO_METADATA | DIO_DATA);
> +			glops->go_inval(gl, DIO_METADATA);
>  	} else if (gl->gl_state =3D=3D LM_ST_DEFERRED) {
>  		/* We might not want to do this here.
>  		   Look at moving to the inode glops. */
>  		if (glops->go_inval)
> -			glops->go_inval(gl, DIO_DATA);
> +			glops->go_inval(gl, 0);
>  	}
> =20
>  	/*  Deal with each possible exit condition  */
> @@ -954,7 +954,7 @@ void gfs2_glock_xmote_th(struct gfs2_glo
>  	gfs2_assert_warn(sdp, state !=3D gl->gl_state);
> =20
>  	if (gl->gl_state =3D=3D LM_ST_EXCLUSIVE && glops->go_sync)
> -		glops->go_sync(gl, DIO_METADATA | DIO_DATA | DIO_RELEASE);
> +		glops->go_sync(gl);
> =20
>  	gfs2_glock_hold(gl);
>  	gl->gl_req_bh =3D xmote_bh;
> @@ -995,7 +995,7 @@ static void drop_bh(struct gfs2_glock *g
>  	state_change(gl, LM_ST_UNLOCKED);
> =20
>  	if (glops->go_inval)
> -		glops->go_inval(gl, DIO_METADATA | DIO_DATA);
> +		glops->go_inval(gl, DIO_METADATA);
> =20
>  	if (gh) {
>  		spin_lock(&gl->gl_spin);
> @@ -1041,7 +1041,7 @@ void gfs2_glock_drop_th(struct gfs2_gloc
>  	gfs2_assert_warn(sdp, gl->gl_state !=3D LM_ST_UNLOCKED);
> =20
>  	if (gl->gl_state =3D=3D LM_ST_EXCLUSIVE && glops->go_sync)
> -		glops->go_sync(gl, DIO_METADATA | DIO_DATA | DIO_RELEASE);
> +		glops->go_sync(gl);
> =20
>  	gfs2_glock_hold(gl);
>  	gl->gl_req_bh =3D drop_bh;
> diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
> index b92de0a..60561ca 100644
> --- a/fs/gfs2/glops.c
> +++ b/fs/gfs2/glops.c
> @@ -173,23 +173,18 @@ static void gfs2_page_writeback(struct g
>  /**
>   * meta_go_sync - sync out the metadata for this glock
>   * @gl: the glock
> - * @flags: DIO_*
>   *
>   * Called when demoting or unlocking an EX glock.  We must flush
>   * to disk all dirty buffers/pages relating to this glock, and must not
>   * not return to caller to demote/unlock the glock until I/O is complete=
.
>   */
> =20
> -static void meta_go_sync(struct gfs2_glock *gl, int flags)
> +static void meta_go_sync(struct gfs2_glock *gl)
>  {
> -	if (!(flags & DIO_METADATA))
> -		return;
> -
>  	if (test_and_clear_bit(GLF_DIRTY, &gl->gl_flags)) {
>  		gfs2_log_flush(gl->gl_sbd, gl);
>  		gfs2_meta_sync(gl);
> -		if (flags & DIO_RELEASE)
> -			gfs2_ail_empty_gl(gl);
> +		gfs2_ail_empty_gl(gl);
>  	}
> =20
>  }
> @@ -264,31 +259,18 @@ static void inode_go_drop_th(struct gfs2
>  /**
>   * inode_go_sync - Sync the dirty data and/or metadata for an inode gloc=
k
>   * @gl: the glock protecting the inode
> - * @flags:
>   *
>   */
> =20
> -static void inode_go_sync(struct gfs2_glock *gl, int flags)
> +static void inode_go_sync(struct gfs2_glock *gl)
>  {
> -	int meta =3D (flags & DIO_METADATA);
> -	int data =3D (flags & DIO_DATA);
> -
>  	if (test_bit(GLF_DIRTY, &gl->gl_flags)) {
> -		if (meta && data) {
> -			gfs2_page_writeback(gl);
> -			gfs2_log_flush(gl->gl_sbd, gl);
> -			gfs2_meta_sync(gl);
> -			gfs2_page_wait(gl);
> -			clear_bit(GLF_DIRTY, &gl->gl_flags);
> -		} else if (meta) {
> -			gfs2_log_flush(gl->gl_sbd, gl);
> -			gfs2_meta_sync(gl);
> -		} else if (data) {
> -			gfs2_page_writeback(gl);
> -			gfs2_page_wait(gl);
> -		}
> -		if (flags & DIO_RELEASE)
> -			gfs2_ail_empty_gl(gl);
> +		gfs2_page_writeback(gl);
> +		gfs2_log_flush(gl->gl_sbd, gl);
> +		gfs2_meta_sync(gl);
> +		gfs2_page_wait(gl);
> +		clear_bit(GLF_DIRTY, &gl->gl_flags);
> +		gfs2_ail_empty_gl(gl);
>  	}
>  }
> =20
> @@ -302,15 +284,13 @@ static void inode_go_sync(struct gfs2_gl
>  static void inode_go_inval(struct gfs2_glock *gl, int flags)
>  {
>  	int meta =3D (flags & DIO_METADATA);
> -	int data =3D (flags & DIO_DATA);
> =20
>  	if (meta) {
>  		struct gfs2_inode *ip =3D gl->gl_object;
>  		gfs2_meta_inval(gl);
>  		set_bit(GIF_INVALID, &ip->i_flags);
>  	}
> -	if (data)
> -		gfs2_page_inval(gl);
> +	gfs2_page_inval(gl);
>  }
> =20
>  /**
> @@ -494,7 +474,7 @@ static void trans_go_xmote_bh(struct gfs
>  	if (gl->gl_state !=3D LM_ST_UNLOCKED &&
>  	    test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags)) {
>  		gfs2_meta_cache_flush(GFS2_I(sdp->sd_jdesc->jd_inode));
> -		j_gl->gl_ops->go_inval(j_gl, DIO_METADATA | DIO_DATA);
> +		j_gl->gl_ops->go_inval(j_gl, DIO_METADATA);
> =20
>  		error =3D gfs2_find_jhead(sdp->sd_jdesc, &head);
>  		if (error)
> diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
> index 227a74d..734421e 100644
> --- a/fs/gfs2/incore.h
> +++ b/fs/gfs2/incore.h
> @@ -14,8 +14,6 @@ #include <linux/fs.h>
> =20
>  #define DIO_WAIT	0x00000010
>  #define DIO_METADATA	0x00000020
> -#define DIO_DATA	0x00000040
> -#define DIO_RELEASE	0x00000080
>  #define DIO_ALL		0x00000100
> =20
>  struct gfs2_log_operations;
> @@ -103,18 +101,17 @@ struct gfs2_bufdata {
>  };
> =20
>  struct gfs2_glock_operations {
> -	void (*go_xmote_th) (struct gfs2_glock * gl, unsigned int state,
> -			     int flags);
> -	void (*go_xmote_bh) (struct gfs2_glock * gl);
> -	void (*go_drop_th) (struct gfs2_glock * gl);
> -	void (*go_drop_bh) (struct gfs2_glock * gl);
> -	void (*go_sync) (struct gfs2_glock * gl, int flags);
> -	void (*go_inval) (struct gfs2_glock * gl, int flags);
> -	int (*go_demote_ok) (struct gfs2_glock * gl);
> -	int (*go_lock) (struct gfs2_holder * gh);
> -	void (*go_unlock) (struct gfs2_holder * gh);
> -	void (*go_callback) (struct gfs2_glock * gl, unsigned int state);
> -	void (*go_greedy) (struct gfs2_glock * gl);
> +	void (*go_xmote_th) (struct gfs2_glock *gl, unsigned int state, int fla=
gs);
> +	void (*go_xmote_bh) (struct gfs2_glock *gl);
> +	void (*go_drop_th) (struct gfs2_glock *gl);
> +	void (*go_drop_bh) (struct gfs2_glock *gl);
> +	void (*go_sync) (struct gfs2_glock *gl);
> +	void (*go_inval) (struct gfs2_glock *gl, int flags);
> +	int (*go_demote_ok) (struct gfs2_glock *gl);
> +	int (*go_lock) (struct gfs2_holder *gh);
> +	void (*go_unlock) (struct gfs2_holder *gh);
> +	void (*go_callback) (struct gfs2_glock *gl, unsigned int state);
> +	void (*go_greedy) (struct gfs2_glock *gl);
>  	const int go_type;
>  };
> =20
> diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
> index 0ef8317..1408c5f 100644
> --- a/fs/gfs2/super.c
> +++ b/fs/gfs2/super.c
> @@ -517,7 +517,7 @@ int gfs2_make_fs_rw(struct gfs2_sbd *sdp
>  		return error;
> =20
>  	gfs2_meta_cache_flush(ip);
> -	j_gl->gl_ops->go_inval(j_gl, DIO_METADATA | DIO_DATA);
> +	j_gl->gl_ops->go_inval(j_gl, DIO_METADATA);
> =20
>  	error =3D gfs2_find_jhead(sdp->sd_jdesc, &head);
>  	if (error)
--=20
Russell Cattelan <cattelan@thebarn.com>

--=-PVSlZqoPIMqFTX2YodVx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFcHfXNRmM+OaGhBgRAhYFAJ9PyuE6u0qZY1IPaT4UEG/znihGwgCfSMil
+HdQyNkk+YJD6c/BVaCOmqs=
=ly3K
-----END PGP SIGNATURE-----

--=-PVSlZqoPIMqFTX2YodVx--

