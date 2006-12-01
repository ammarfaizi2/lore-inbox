Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031686AbWLASue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031686AbWLASue (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 13:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031699AbWLASue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 13:50:34 -0500
Received: from cattelan-host202.dsl.visi.com ([208.42.117.202]:39620 "EHLO
	slurp.thebarn.com") by vger.kernel.org with ESMTP id S1031686AbWLASuc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 13:50:32 -0500
Subject: Re: [GFS2] Reduce number of arguments to meta_io.c:getbuf() [58/70]
From: Russell Cattelan <cattelan@thebarn.com>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <1164889331.3752.421.camel@quoit.chygwyn.com>
References: <1164889331.3752.421.camel@quoit.chygwyn.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LzwKca/zS9cgmJXHEpbv"
Date: Fri, 01 Dec 2006 12:50:19 -0600
Message-Id: <1164999019.1194.66.camel@xenon.msp.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1-1mdv2007.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LzwKca/zS9cgmJXHEpbv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-11-30 at 12:22 +0000, Steven Whitehouse wrote:
> >From cb4c03131836a55bf95e1c165409244ac6b4f39f Mon Sep 17 00:00:00 2001
> From: Steven Whitehouse <swhiteho@redhat.com>
> Date: Thu, 23 Nov 2006 11:16:32 -0500
> Subject: [PATCH] [GFS2] Reduce number of arguments to meta_io.c:getbuf()
>=20
> Since the superblock and the address_space are determined by the
> glock, we might as well just pass that as the argument since all
> the callers already have that available.

This taking a poorly named function with a questionable api=20
and making is worse.
If getbuf does not have a need for a glock structure then
there is no point in passing it in.
Simply reducing the number of arguments in this case serves
no purpose.

The existing parameters seem correct but the function=20
should probably be named something like gfs2_get_bh.


>=20
> Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
> ---
>  fs/gfs2/meta_io.c |   26 ++++++++++++--------------
>  1 files changed, 12 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
> index fbeba81..0e34d99 100644
> --- a/fs/gfs2/meta_io.c
> +++ b/fs/gfs2/meta_io.c
> @@ -127,17 +127,17 @@ void gfs2_meta_sync(struct gfs2_glock *g
> =20
>  /**
>   * getbuf - Get a buffer with a given address space
> - * @sdp: the filesystem
> - * @aspace: the address space
> + * @gl: the glock
>   * @blkno: the block number (filesystem scope)
>   * @create: 1 if the buffer should be created
>   *
>   * Returns: the buffer
>   */
> =20
> -static struct buffer_head *getbuf(struct gfs2_sbd *sdp, struct inode *as=
pace,
> -				  u64 blkno, int create)
> +static struct buffer_head *getbuf(struct gfs2_glock *gl, u64 blkno, int =
create)
>  {
> +	struct address_space *mapping =3D gl->gl_aspace->i_mapping;
> +	struct gfs2_sbd *sdp =3D gl->gl_sbd;
>  	struct page *page;
>  	struct buffer_head *bh;
>  	unsigned int shift;
> @@ -150,13 +150,13 @@ static struct buffer_head *getbuf(struct
> =20
>  	if (create) {
>  		for (;;) {
> -			page =3D grab_cache_page(aspace->i_mapping, index);
> +			page =3D grab_cache_page(mapping, index);
>  			if (page)
>  				break;
>  			yield();
>  		}
>  	} else {
> -		page =3D find_lock_page(aspace->i_mapping, index);
> +		page =3D find_lock_page(mapping, index);
>  		if (!page)
>  			return NULL;
>  	}
> @@ -202,7 +202,7 @@ static void meta_prep_new(struct buffer_
>  struct buffer_head *gfs2_meta_new(struct gfs2_glock *gl, u64 blkno)
>  {
>  	struct buffer_head *bh;
> -	bh =3D getbuf(gl->gl_sbd, gl->gl_aspace, blkno, CREATE);
> +	bh =3D getbuf(gl, blkno, CREATE);
>  	meta_prep_new(bh);
>  	return bh;
>  }
> @@ -220,7 +220,7 @@ struct buffer_head *gfs2_meta_new(struct
>  int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, int flags,
>  		   struct buffer_head **bhp)
>  {
> -	*bhp =3D getbuf(gl->gl_sbd, gl->gl_aspace, blkno, CREATE);
> +	*bhp =3D getbuf(gl, blkno, CREATE);
>  	if (!buffer_uptodate(*bhp))
>  		ll_rw_block(READ_META, 1, bhp);
>  	if (flags & DIO_WAIT) {
> @@ -379,11 +379,10 @@ void gfs2_unpin(struct gfs2_sbd *sdp, st
>  void gfs2_meta_wipe(struct gfs2_inode *ip, u64 bstart, u32 blen)
>  {
>  	struct gfs2_sbd *sdp =3D GFS2_SB(&ip->i_inode);
> -	struct inode *aspace =3D ip->i_gl->gl_aspace;
>  	struct buffer_head *bh;
> =20
>  	while (blen) {
> -		bh =3D getbuf(sdp, aspace, bstart, NO_CREATE);
> +		bh =3D getbuf(ip->i_gl, bstart, NO_CREATE);
>  		if (bh) {
>  			struct gfs2_bufdata *bd =3D bh->b_private;
> =20
> @@ -484,7 +483,7 @@ int gfs2_meta_indirect_buffer(struct gfs
>  	spin_unlock(&ip->i_spin);
> =20
>  	if (!bh)
> -		bh =3D getbuf(gl->gl_sbd, gl->gl_aspace, num, CREATE);
> +		bh =3D getbuf(gl, num, CREATE);
> =20
>  	if (!bh)
>  		return -ENOBUFS;
> @@ -535,7 +534,6 @@ err:
>  struct buffer_head *gfs2_meta_ra(struct gfs2_glock *gl, u64 dblock, u32 =
extlen)
>  {
>  	struct gfs2_sbd *sdp =3D gl->gl_sbd;
> -	struct inode *aspace =3D gl->gl_aspace;
>  	struct buffer_head *first_bh, *bh;
>  	u32 max_ra =3D gfs2_tune_get(sdp, gt_max_readahead) >>
>  			  sdp->sd_sb.sb_bsize_shift;
> @@ -547,7 +545,7 @@ struct buffer_head *gfs2_meta_ra(struct=20
>  	if (extlen > max_ra)
>  		extlen =3D max_ra;
> =20
> -	first_bh =3D getbuf(sdp, aspace, dblock, CREATE);
> +	first_bh =3D getbuf(gl, dblock, CREATE);
> =20
>  	if (buffer_uptodate(first_bh))
>  		goto out;
> @@ -558,7 +556,7 @@ struct buffer_head *gfs2_meta_ra(struct=20
>  	extlen--;
> =20
>  	while (extlen) {
> -		bh =3D getbuf(sdp, aspace, dblock, CREATE);
> +		bh =3D getbuf(gl, dblock, CREATE);
> =20
>  		if (!buffer_uptodate(bh) && !buffer_locked(bh))
>  			ll_rw_block(READA, 1, &bh);
> --=20
> 1.4.1
>=20
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
Russell Cattelan <cattelan@thebarn.com>

--=-LzwKca/zS9cgmJXHEpbv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFcHlrNRmM+OaGhBgRAhmaAJkBr10vopMlhvU6vk6NODcNjOJdCgCfZ/Kp
yAn0knv9zTFlm8t3pZBP2o8=
=f0Jg
-----END PGP SIGNATURE-----

--=-LzwKca/zS9cgmJXHEpbv--

