Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031684AbWLATFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031684AbWLATFv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 14:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031700AbWLATFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 14:05:51 -0500
Received: from cattelan-host202.dsl.visi.com ([208.42.117.202]:13027 "EHLO
	slurp.thebarn.com") by vger.kernel.org with ESMTP id S1031684AbWLATFu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 14:05:50 -0500
Subject: Re: [GFS2] Tidy up bmap & fix boundary bug [48/70]
From: Russell Cattelan <cattelan@thebarn.com>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <1164889259.3752.401.camel@quoit.chygwyn.com>
References: <1164889259.3752.401.camel@quoit.chygwyn.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-S4Fz5j0/ImUSGAR9YdnB"
Date: Fri, 01 Dec 2006 13:05:36 -0600
Message-Id: <1164999936.1194.79.camel@xenon.msp.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1-1mdv2007.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-S4Fz5j0/ImUSGAR9YdnB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-11-30 at 12:20 +0000, Steven Whitehouse wrote:
> >From 4cf1ed8144e740de27c6146c25d5d7ea26679cc5 Mon Sep 17 00:00:00 2001
> From: Steven Whitehouse <swhiteho@redhat.com>
> Date: Wed, 15 Nov 2006 15:21:06 -0500
> Subject: [PATCH] [GFS2] Tidy up bmap & fix boundary bug
>=20
> This moves the locking for bmap into the bmap function itself
> rather than using a wrapper function. It also fixes a bug where
> the boundary flag was set on the wrong bh.
does boundary buffers even make sense for gfs?

They might increase cluster contention, and probably serve to
just chop up io to the fiber-channel raids/disks that have really
good caches and queuing algorithms.

>  Also the flags on
> the mapped bh are reset earlier in the function to ensure that
> they are 100% correct on the error path.
>=20
> Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
> ---
>  fs/gfs2/bmap.c |  117 ++++++++++++++++++++++++++------------------------=
------
>  1 files changed, 54 insertions(+), 63 deletions(-)
>=20
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index 06e3447..8240c1f 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -423,12 +423,29 @@ static int lookup_block(struct gfs2_inod
>  	return 0;
>  }
> =20
> +static inline void bmap_lock(struct inode *inode, int create)
> +{
> +	struct gfs2_inode *ip =3D GFS2_I(inode);
> +	if (create)
> +		down_write(&ip->i_rw_mutex);
> +	else
> +		down_read(&ip->i_rw_mutex);
> +}
> +
> +static inline void bmap_unlock(struct inode *inode, int create)
> +{
> +	struct gfs2_inode *ip =3D GFS2_I(inode);
> +	if (create)
> +		up_write(&ip->i_rw_mutex);
> +	else
> +		up_read(&ip->i_rw_mutex);
> +}
> +
>  /**
> - * gfs2_block_pointers - Map a block from an inode to a disk block
> + * gfs2_block_map - Map a block from an inode to a disk block
>   * @inode: The inode
>   * @lblock: The logical block number
> - * @map_bh: The bh to be mapped
> - * @mp: metapath to use
> + * @bh_map: The bh to be mapped
>   *
>   * Find the block number on the current device which corresponds to an
>   * inode's block. If the block had to be created, "new" will be set.
> @@ -436,8 +453,8 @@ static int lookup_block(struct gfs2_inod
>   * Returns: errno
>   */
> =20
> -static int gfs2_block_pointers(struct inode *inode, u64 lblock, int crea=
te,
> -			       struct buffer_head *bh_map, struct metapath *mp)
> +int gfs2_block_map(struct inode *inode, u64 lblock, int create,
> +		   struct buffer_head *bh_map)
>  {
>  	struct gfs2_inode *ip =3D GFS2_I(inode);
>  	struct gfs2_sbd *sdp =3D GFS2_SB(inode);
> @@ -451,51 +468,55 @@ static int gfs2_block_pointers(struct in
>  	u64 dblock =3D 0;
>  	int boundary;
>  	unsigned int maxlen =3D bh_map->b_size >> inode->i_blkbits;
> +	struct metapath mp;
> +	u64 size;
> =20
>  	BUG_ON(maxlen =3D=3D 0);
> =20
>  	if (gfs2_assert_warn(sdp, !gfs2_is_stuffed(ip)))
>  		return 0;
> =20
> +	bmap_lock(inode, create);
> +	clear_buffer_mapped(bh_map);
> +	clear_buffer_new(bh_map);
> +	clear_buffer_boundary(bh_map);
>  	bsize =3D gfs2_is_dir(ip) ? sdp->sd_jbsize : sdp->sd_sb.sb_bsize;
> -
> -	height =3D calc_tree_height(ip, (lblock + 1) * bsize);
> -	if (ip->i_di.di_height < height) {
> -		if (!create)
> -			return 0;
> -
> -		error =3D build_height(inode, height);
> -		if (error)
> -			return error;
> +	size =3D (lblock + 1) * bsize;
> +
> +	if (size > ip->i_di.di_size) {
> +		height =3D calc_tree_height(ip, size);
> +		if (ip->i_di.di_height < height) {
> +			if (!create)
> +				goto out_ok;
> +=09
> +			error =3D build_height(inode, height);
> +			if (error)
> +				goto out_fail;
> +		}
>  	}
> =20
> -	find_metapath(ip, lblock, mp);
> +	find_metapath(ip, lblock, &mp);
>  	end_of_metadata =3D ip->i_di.di_height - 1;
> -
>  	error =3D gfs2_meta_inode_buffer(ip, &bh);
>  	if (error)
> -		return error;
> +		goto out_fail;
> =20
>  	for (x =3D 0; x < end_of_metadata; x++) {
> -		lookup_block(ip, bh, x, mp, create, &new, &dblock);
> +		lookup_block(ip, bh, x, &mp, create, &new, &dblock);
>  		brelse(bh);
>  		if (!dblock)
> -			return 0;
> +			goto out_ok;
> =20
>  		error =3D gfs2_meta_indirect_buffer(ip, x+1, dblock, new, &bh);
>  		if (error)
> -			return error;
> +			goto out_fail;
>  	}
> =20
> -	boundary =3D lookup_block(ip, bh, end_of_metadata, mp, create, &new, &d=
block);
> -	clear_buffer_mapped(bh_map);
> -	clear_buffer_new(bh_map);
> -	clear_buffer_boundary(bh_map);
> -
> +	boundary =3D lookup_block(ip, bh, end_of_metadata, &mp, create, &new, &=
dblock);
>  	if (dblock) {
>  		map_bh(bh_map, inode->i_sb, dblock);
>  		if (boundary)
> -			set_buffer_boundary(bh);
> +			set_buffer_boundary(bh_map);
>  		if (new) {
>  			struct buffer_head *dibh;
>  			error =3D gfs2_meta_inode_buffer(ip, &dibh);
> @@ -510,8 +531,8 @@ static int gfs2_block_pointers(struct in
>  		while(--maxlen && !buffer_boundary(bh_map)) {
>  			u64 eblock;
> =20
> -			mp->mp_list[end_of_metadata]++;
> -			boundary =3D lookup_block(ip, bh, end_of_metadata, mp, 0, &new, &eblo=
ck);
> +			mp.mp_list[end_of_metadata]++;
> +			boundary =3D lookup_block(ip, bh, end_of_metadata, &mp, 0, &new, &ebl=
ock);
>  			if (eblock !=3D ++dblock)
>  				break;
>  			bh_map->b_size +=3D (1 << inode->i_blkbits);
> @@ -521,43 +542,15 @@ static int gfs2_block_pointers(struct in
>  	}
>  out_brelse:
>  	brelse(bh);
> -	return 0;
> -}
> -
> -
> -static inline void bmap_lock(struct inode *inode, int create)
> -{
> -	struct gfs2_inode *ip =3D GFS2_I(inode);
> -	if (create)
> -		down_write(&ip->i_rw_mutex);
> -	else
> -		down_read(&ip->i_rw_mutex);
> -}
> -
> -static inline void bmap_unlock(struct inode *inode, int create)
> -{
> -	struct gfs2_inode *ip =3D GFS2_I(inode);
> -	if (create)
> -		up_write(&ip->i_rw_mutex);
> -	else
> -		up_read(&ip->i_rw_mutex);
> -}
> -
> -int gfs2_block_map(struct inode *inode, u64 lblock, int create,
> -		   struct buffer_head *bh)
> -{
> -	struct metapath mp;
> -	int ret;
> -
> -	bmap_lock(inode, create);
> -	ret =3D gfs2_block_pointers(inode, lblock, create, bh, &mp);
> +out_ok:
> +	error =3D 0;
> +out_fail:
>  	bmap_unlock(inode, create);
> -	return ret;
> +	return error;
>  }
> =20
>  int gfs2_extent_map(struct inode *inode, u64 lblock, int *new, u64 *dblo=
ck, unsigned *extlen)
>  {
> -	struct metapath mp;
>  	struct buffer_head bh =3D { .b_state =3D 0, .b_blocknr =3D 0 };
>  	int ret;
>  	int create =3D *new;
> @@ -567,9 +560,7 @@ int gfs2_extent_map(struct inode *inode,
>  	BUG_ON(!new);
> =20
>  	bh.b_size =3D 1 << (inode->i_blkbits + 5);
> -	bmap_lock(inode, create);
> -	ret =3D gfs2_block_pointers(inode, lblock, create, &bh, &mp);
> -	bmap_unlock(inode, create);
> +	ret =3D gfs2_block_map(inode, lblock, create, &bh);
>  	*extlen =3D bh.b_size >> inode->i_blkbits;
>  	*dblock =3D bh.b_blocknr;
>  	if (buffer_new(&bh))
--=20
Russell Cattelan <cattelan@thebarn.com>

--=-S4Fz5j0/ImUSGAR9YdnB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFcHz/NRmM+OaGhBgRApg1AJwJDPyb16/HRVFQ+vlr36x4C7rTWQCfVrHv
ktbsgXw1hDRowFAlHFyYcXE=
=l10g
-----END PGP SIGNATURE-----

--=-S4Fz5j0/ImUSGAR9YdnB--

