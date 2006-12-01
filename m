Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031733AbWLATTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031733AbWLATTP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 14:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031736AbWLATTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 14:19:15 -0500
Received: from cattelan-host202.dsl.visi.com ([208.42.117.202]:49367 "EHLO
	slurp.thebarn.com") by vger.kernel.org with ESMTP id S1031733AbWLATTO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 14:19:14 -0500
Subject: Re: [GFS2] Change argument of gfs2_dinode_out [17/70]
From: Russell Cattelan <cattelan@thebarn.com>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <1164888933.3752.338.camel@quoit.chygwyn.com>
References: <1164888933.3752.338.camel@quoit.chygwyn.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/vcLrlE83T1254Z6B5ZX"
Date: Fri, 01 Dec 2006 13:19:04 -0600
Message-Id: <1165000744.1194.89.camel@xenon.msp.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1-1mdv2007.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/vcLrlE83T1254Z6B5ZX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-11-30 at 12:15 +0000, Steven Whitehouse wrote:
> >From 539e5d6b7ae8612c0393fe940d2da5b591318d3d Mon Sep 17 00:00:00 2001
> From: Steven Whitehouse <swhiteho@redhat.com>
> Date: Tue, 31 Oct 2006 15:07:05 -0500
> Subject: [PATCH] [GFS2] Change argument of gfs2_dinode_out
>=20
> Everywhere this was called, a struct gfs2_inode was available,
> but despite that, it was always called with a struct gfs2_dinode
> as an argument. By making this change it paves the way to start
> eliminating fields duplicated between the kernel's struct inode
> and the struct gfs2_dinode.
More pointless code churn.

This only makes sense once the file system is working=20
and we have time to do this type of cleanup on against
a stable and TESTED code base.

>=20
> Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
> ---
>  fs/gfs2/acl.c               |    2 +-
>  fs/gfs2/bmap.c              |   12 ++++++------
>  fs/gfs2/dir.c               |   20 ++++++++++----------
>  fs/gfs2/eattr.c             |   14 +++++++-------
>  fs/gfs2/inode.c             |    6 +++---
>  fs/gfs2/ondisk.c            |    5 ++++-
>  fs/gfs2/ops_file.c          |    2 +-
>  fs/gfs2/ops_inode.c         |   10 +++++-----
>  include/linux/gfs2_ondisk.h |    3 ++-
>  9 files changed, 39 insertions(+), 35 deletions(-)
>=20
> diff --git a/fs/gfs2/acl.c b/fs/gfs2/acl.c
> index 5f959b8..906e403 100644
> --- a/fs/gfs2/acl.c
> +++ b/fs/gfs2/acl.c
> @@ -201,7 +201,7 @@ static int munge_mode(struct gfs2_inode=20
>  				(ip->i_di.di_mode & S_IFMT) =3D=3D (mode & S_IFMT));
>  		ip->i_di.di_mode =3D mode;
>  		gfs2_trans_add_bh(ip->i_gl, dibh, 1);
> -		gfs2_dinode_out(&ip->i_di, dibh->b_data);
> +		gfs2_dinode_out(ip, dibh->b_data);
>  		brelse(dibh);
>  	}
> =20
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index 51f6356..8c092ab 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -498,7 +498,7 @@ static int gfs2_block_pointers(struct in
>  			error =3D gfs2_meta_inode_buffer(ip, &dibh);
>  			if (!error) {
>  				gfs2_trans_add_bh(ip->i_gl, dibh, 1);
> -				gfs2_dinode_out(&ip->i_di, dibh->b_data);
> +				gfs2_dinode_out(ip, dibh->b_data);
>  				brelse(dibh);
>  			}
>  			set_buffer_new(bh_map);
> @@ -780,7 +780,7 @@ static int do_strip(struct gfs2_inode *i
> =20
>  	ip->i_di.di_mtime =3D ip->i_di.di_ctime =3D get_seconds();
> =20
> -	gfs2_dinode_out(&ip->i_di, dibh->b_data);
> +	gfs2_dinode_out(ip, dibh->b_data);
> =20
>  	up_write(&ip->i_rw_mutex);
> =20
> @@ -860,7 +860,7 @@ static int do_grow(struct gfs2_inode *ip
>  		goto out_end_trans;
> =20
>  	gfs2_trans_add_bh(ip->i_gl, dibh, 1);
> -	gfs2_dinode_out(&ip->i_di, dibh->b_data);
> +	gfs2_dinode_out(ip, dibh->b_data);
>  	brelse(dibh);
> =20
>  out_end_trans:
> @@ -970,7 +970,7 @@ static int trunc_start(struct gfs2_inode
>  		ip->i_di.di_size =3D size;
>  		ip->i_di.di_mtime =3D ip->i_di.di_ctime =3D get_seconds();
>  		gfs2_trans_add_bh(ip->i_gl, dibh, 1);
> -		gfs2_dinode_out(&ip->i_di, dibh->b_data);
> +		gfs2_dinode_out(ip, dibh->b_data);
>  		gfs2_buffer_clear_tail(dibh, sizeof(struct gfs2_dinode) + size);
>  		error =3D 1;
> =20
> @@ -983,7 +983,7 @@ static int trunc_start(struct gfs2_inode
>  			ip->i_di.di_mtime =3D ip->i_di.di_ctime =3D get_seconds();
>  			ip->i_di.di_flags |=3D GFS2_DIF_TRUNC_IN_PROG;
>  			gfs2_trans_add_bh(ip->i_gl, dibh, 1);
> -			gfs2_dinode_out(&ip->i_di, dibh->b_data);
> +			gfs2_dinode_out(ip, dibh->b_data);
>  		}
>  	}
> =20
> @@ -1057,7 +1057,7 @@ static int trunc_end(struct gfs2_inode *
>  	ip->i_di.di_flags &=3D ~GFS2_DIF_TRUNC_IN_PROG;
> =20
>  	gfs2_trans_add_bh(ip->i_gl, dibh, 1);
> -	gfs2_dinode_out(&ip->i_di, dibh->b_data);
> +	gfs2_dinode_out(ip, dibh->b_data);
>  	brelse(dibh);
> =20
>  out:
> diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
> index 59dc823..0742761 100644
> --- a/fs/gfs2/dir.c
> +++ b/fs/gfs2/dir.c
> @@ -132,7 +132,7 @@ static int gfs2_dir_write_stuffed(struct
>  	if (ip->i_di.di_size < offset + size)
>  		ip->i_di.di_size =3D offset + size;
>  	ip->i_di.di_mtime =3D ip->i_di.di_ctime =3D get_seconds();
> -	gfs2_dinode_out(&ip->i_di, dibh->b_data);
> +	gfs2_dinode_out(ip, dibh->b_data);
> =20
>  	brelse(dibh);
> =20
> @@ -232,7 +232,7 @@ out:
>  	ip->i_di.di_mtime =3D ip->i_di.di_ctime =3D get_seconds();
> =20
>  	gfs2_trans_add_bh(ip->i_gl, dibh, 1);
> -	gfs2_dinode_out(&ip->i_di, dibh->b_data);
> +	gfs2_dinode_out(ip, dibh->b_data);
>  	brelse(dibh);
> =20
>  	return copied;
> @@ -907,7 +907,7 @@ static int dir_make_exhash(struct inode=20
>  	for (x =3D sdp->sd_hash_ptrs, y =3D -1; x; x >>=3D 1, y++) ;
>  	dip->i_di.di_depth =3D y;
> =20
> -	gfs2_dinode_out(&dip->i_di, dibh->b_data);
> +	gfs2_dinode_out(dip, dibh->b_data);
> =20
>  	brelse(dibh);
> =20
> @@ -1039,7 +1039,7 @@ static int dir_split_leaf(struct inode *
>  	error =3D gfs2_meta_inode_buffer(dip, &dibh);
>  	if (!gfs2_assert_withdraw(GFS2_SB(&dip->i_inode), !error)) {
>  		dip->i_di.di_blocks++;
> -		gfs2_dinode_out(&dip->i_di, dibh->b_data);
> +		gfs2_dinode_out(dip, dibh->b_data);
>  		brelse(dibh);
>  	}
> =20
> @@ -1119,7 +1119,7 @@ static int dir_double_exhash(struct gfs2
>  	error =3D gfs2_meta_inode_buffer(dip, &dibh);
>  	if (!gfs2_assert_withdraw(sdp, !error)) {
>  		dip->i_di.di_depth++;
> -		gfs2_dinode_out(&dip->i_di, dibh->b_data);
> +		gfs2_dinode_out(dip, dibh->b_data);
>  		brelse(dibh);
>  	}
> =20
> @@ -1517,7 +1517,7 @@ static int dir_new_leaf(struct inode *in
>  		return error;
>  	gfs2_trans_add_bh(ip->i_gl, bh, 1);
>  	ip->i_di.di_blocks++;
> -	gfs2_dinode_out(&ip->i_di, bh->b_data);
> +	gfs2_dinode_out(ip, bh->b_data);
>  	brelse(bh);
>  	return 0;
>  }
> @@ -1561,7 +1561,7 @@ int gfs2_dir_add(struct inode *inode, co
>  			gfs2_trans_add_bh(ip->i_gl, bh, 1);
>  			ip->i_di.di_entries++;
>  			ip->i_di.di_mtime =3D ip->i_di.di_ctime =3D get_seconds();
> -			gfs2_dinode_out(&ip->i_di, bh->b_data);
> +			gfs2_dinode_out(ip, bh->b_data);
>  			brelse(bh);
>  			error =3D 0;
>  			break;
> @@ -1647,7 +1647,7 @@ int gfs2_dir_del(struct gfs2_inode *dip,
>  	gfs2_trans_add_bh(dip->i_gl, bh, 1);
>  	dip->i_di.di_entries--;
>  	dip->i_di.di_mtime =3D dip->i_di.di_ctime =3D get_seconds();
> -	gfs2_dinode_out(&dip->i_di, bh->b_data);
> +	gfs2_dinode_out(dip, bh->b_data);
>  	brelse(bh);
>  	mark_inode_dirty(&dip->i_inode);
> =20
> @@ -1695,7 +1695,7 @@ int gfs2_dir_mvino(struct gfs2_inode *di
>  	}
> =20
>  	dip->i_di.di_mtime =3D dip->i_di.di_ctime =3D get_seconds();
> -	gfs2_dinode_out(&dip->i_di, bh->b_data);
> +	gfs2_dinode_out(dip, bh->b_data);
>  	brelse(bh);
>  	return 0;
>  }
> @@ -1875,7 +1875,7 @@ static int leaf_dealloc(struct gfs2_inod
>  		goto out_end_trans;
> =20
>  	gfs2_trans_add_bh(dip->i_gl, dibh, 1);
> -	gfs2_dinode_out(&dip->i_di, dibh->b_data);
> +	gfs2_dinode_out(dip, dibh->b_data);
>  	brelse(dibh);
> =20
>  out_end_trans:
> diff --git a/fs/gfs2/eattr.c b/fs/gfs2/eattr.c
> index 518f0c0..9b7bb56 100644
> --- a/fs/gfs2/eattr.c
> +++ b/fs/gfs2/eattr.c
> @@ -302,7 +302,7 @@ static int ea_dealloc_unstuffed(struct g
>  	if (!error) {
>  		ip->i_di.di_ctime =3D get_seconds();
>  		gfs2_trans_add_bh(ip->i_gl, dibh, 1);
> -		gfs2_dinode_out(&ip->i_di, dibh->b_data);
> +		gfs2_dinode_out(ip, dibh->b_data);
>  		brelse(dibh);
>  	}
> =20
> @@ -717,7 +717,7 @@ static int ea_alloc_skeleton(struct gfs2
>  		}
>  		ip->i_di.di_ctime =3D get_seconds();
>  		gfs2_trans_add_bh(ip->i_gl, dibh, 1);
> -		gfs2_dinode_out(&ip->i_di, dibh->b_data);
> +		gfs2_dinode_out(ip, dibh->b_data);
>  		brelse(dibh);
>  	}
> =20
> @@ -852,7 +852,7 @@ static int ea_set_simple_noalloc(struct=20
>  	}
>  	ip->i_di.di_ctime =3D get_seconds();
>  	gfs2_trans_add_bh(ip->i_gl, dibh, 1);
> -	gfs2_dinode_out(&ip->i_di, dibh->b_data);
> +	gfs2_dinode_out(ip, dibh->b_data);
>  	brelse(dibh);
>  out:
>  	gfs2_trans_end(GFS2_SB(&ip->i_inode));
> @@ -1132,7 +1132,7 @@ static int ea_remove_stuffed(struct gfs2
>  	if (!error) {
>  		ip->i_di.di_ctime =3D get_seconds();
>  		gfs2_trans_add_bh(ip->i_gl, dibh, 1);
> -		gfs2_dinode_out(&ip->i_di, dibh->b_data);
> +		gfs2_dinode_out(ip, dibh->b_data);
>  		brelse(dibh);
>  	}
> =20
> @@ -1287,7 +1287,7 @@ int gfs2_ea_acl_chmod(struct gfs2_inode=20
>  		gfs2_assert_warn(GFS2_SB(&ip->i_inode), !error);
>  		gfs2_inode_attr_out(ip);
>  		gfs2_trans_add_bh(ip->i_gl, dibh, 1);
> -		gfs2_dinode_out(&ip->i_di, dibh->b_data);
> +		gfs2_dinode_out(ip, dibh->b_data);
>  		brelse(dibh);
>  	}
> =20
> @@ -1397,7 +1397,7 @@ static int ea_dealloc_indirect(struct gf
>  	error =3D gfs2_meta_inode_buffer(ip, &dibh);
>  	if (!error) {
>  		gfs2_trans_add_bh(ip->i_gl, dibh, 1);
> -		gfs2_dinode_out(&ip->i_di, dibh->b_data);
> +		gfs2_dinode_out(ip, dibh->b_data);
>  		brelse(dibh);
>  	}
> =20
> @@ -1446,7 +1446,7 @@ static int ea_dealloc_block(struct gfs2_
>  	error =3D gfs2_meta_inode_buffer(ip, &dibh);
>  	if (!error) {
>  		gfs2_trans_add_bh(ip->i_gl, dibh, 1);
> -		gfs2_dinode_out(&ip->i_di, dibh->b_data);
> +		gfs2_dinode_out(ip, dibh->b_data);
>  		brelse(dibh);
>  	}
> =20
> diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> index fb96930..b861ddb 100644
> --- a/fs/gfs2/inode.c
> +++ b/fs/gfs2/inode.c
> @@ -338,7 +338,7 @@ int gfs2_change_nlink(struct gfs2_inode=20
>  	ip->i_inode.i_nlink =3D nlink;
> =20
>  	gfs2_trans_add_bh(ip->i_gl, dibh, 1);
> -	gfs2_dinode_out(&ip->i_di, dibh->b_data);
> +	gfs2_dinode_out(ip, dibh->b_data);
>  	brelse(dibh);
>  	mark_inode_dirty(&ip->i_inode);
> =20
> @@ -792,7 +792,7 @@ static int link_dinode(struct gfs2_inode
>  		goto fail_end_trans;
>  	ip->i_di.di_nlink =3D 1;
>  	gfs2_trans_add_bh(ip->i_gl, dibh, 1);
> -	gfs2_dinode_out(&ip->i_di, dibh->b_data);
> +	gfs2_dinode_out(ip, dibh->b_data);
>  	brelse(dibh);
>  	return 0;
> =20
> @@ -1349,7 +1349,7 @@ __gfs2_setattr_simple(struct gfs2_inode=20
>  		gfs2_inode_attr_out(ip);
> =20
>  		gfs2_trans_add_bh(ip->i_gl, dibh, 1);
> -		gfs2_dinode_out(&ip->i_di, dibh->b_data);
> +		gfs2_dinode_out(ip, dibh->b_data);
>  		brelse(dibh);
>  	}
>  	return error;
> diff --git a/fs/gfs2/ondisk.c b/fs/gfs2/ondisk.c
> index 2d1682d..2c50fa0 100644
> --- a/fs/gfs2/ondisk.c
> +++ b/fs/gfs2/ondisk.c
> @@ -15,6 +15,8 @@ #include <linux/buffer_head.h>
> =20
>  #include "gfs2.h"
>  #include <linux/gfs2_ondisk.h>
> +#include <linux/lm_interface.h>
> +#include "incore.h"
> =20
>  #define pv(struct, member, fmt) printk(KERN_INFO "  "#member" =3D "fmt"\=
n", \
>  				       struct->member);
> @@ -187,8 +189,9 @@ void gfs2_dinode_in(struct gfs2_dinode_h
> =20
>  }
> =20
> -void gfs2_dinode_out(const struct gfs2_dinode_host *di, void *buf)
> +void gfs2_dinode_out(const struct gfs2_inode *ip, void *buf)
>  {
> +	const struct gfs2_dinode_host *di =3D &ip->i_di;
>  	struct gfs2_dinode *str =3D buf;
> =20
>  	gfs2_meta_header_out(&di->di_header, buf);
> diff --git a/fs/gfs2/ops_file.c b/fs/gfs2/ops_file.c
> index 2fc8868..7ea4175 100644
> --- a/fs/gfs2/ops_file.c
> +++ b/fs/gfs2/ops_file.c
> @@ -336,7 +336,7 @@ static int do_gfs2_set_flags(struct file
>  		goto out_trans_end;
>  	gfs2_trans_add_bh(ip->i_gl, bh, 1);
>  	ip->i_di.di_flags =3D new_flags;
> -	gfs2_dinode_out(&ip->i_di, bh->b_data);
> +	gfs2_dinode_out(ip, bh->b_data);
>  	brelse(bh);
>  out_trans_end:
>  	gfs2_trans_end(sdp);
> diff --git a/fs/gfs2/ops_inode.c b/fs/gfs2/ops_inode.c
> index ef6e5ed..bd26885 100644
> --- a/fs/gfs2/ops_inode.c
> +++ b/fs/gfs2/ops_inode.c
> @@ -339,7 +339,7 @@ static int gfs2_symlink(struct inode *di
>  	error =3D gfs2_meta_inode_buffer(ip, &dibh);
> =20
>  	if (!gfs2_assert_withdraw(sdp, !error)) {
> -		gfs2_dinode_out(&ip->i_di, dibh->b_data);
> +		gfs2_dinode_out(ip, dibh->b_data);
>  		memcpy(dibh->b_data + sizeof(struct gfs2_dinode), symname,
>  		       size);
>  		brelse(dibh);
> @@ -414,7 +414,7 @@ static int gfs2_mkdir(struct inode *dir,
>  		gfs2_inum_out(&dip->i_num, &dent->de_inum);
>  		dent->de_type =3D cpu_to_be16(DT_DIR);
> =20
> -		gfs2_dinode_out(&ip->i_di, di);
> +		gfs2_dinode_out(ip, di);
> =20
>  		brelse(dibh);
>  	}
> @@ -541,7 +541,7 @@ static int gfs2_mknod(struct inode *dir,
>  	error =3D gfs2_meta_inode_buffer(ip, &dibh);
> =20
>  	if (!gfs2_assert_withdraw(sdp, !error)) {
> -		gfs2_dinode_out(&ip->i_di, dibh->b_data);
> +		gfs2_dinode_out(ip, dibh->b_data);
>  		brelse(dibh);
>  	}
> =20
> @@ -762,7 +762,7 @@ static int gfs2_rename(struct inode *odi
>  			goto out_end_trans;
>  		ip->i_di.di_ctime =3D get_seconds();
>  		gfs2_trans_add_bh(ip->i_gl, dibh, 1);
> -		gfs2_dinode_out(&ip->i_di, dibh->b_data);
> +		gfs2_dinode_out(ip, dibh->b_data);
>  		brelse(dibh);
>  	}
> =20
> @@ -949,7 +949,7 @@ static int setattr_chown(struct inode *i
>  	gfs2_inode_attr_out(ip);
> =20
>  	gfs2_trans_add_bh(ip->i_gl, dibh, 1);
> -	gfs2_dinode_out(&ip->i_di, dibh->b_data);
> +	gfs2_dinode_out(ip, dibh->b_data);
>  	brelse(dibh);
> =20
>  	if (ouid !=3D NO_QUOTA_CHANGE || ogid !=3D NO_QUOTA_CHANGE) {
> diff --git a/include/linux/gfs2_ondisk.h b/include/linux/gfs2_ondisk.h
> index 10a507d..550effa 100644
> --- a/include/linux/gfs2_ondisk.h
> +++ b/include/linux/gfs2_ondisk.h
> @@ -535,7 +535,8 @@ extern void gfs2_rgrp_in(struct gfs2_rgr
>  extern void gfs2_rgrp_out(const struct gfs2_rgrp_host *rg, void *buf);
>  extern void gfs2_quota_in(struct gfs2_quota_host *qu, const void *buf);
>  extern void gfs2_dinode_in(struct gfs2_dinode_host *di, const void *buf)=
;
> -extern void gfs2_dinode_out(const struct gfs2_dinode_host *di, void *buf=
);
> +struct gfs2_inode;
> +extern void gfs2_dinode_out(const struct gfs2_inode *ip, void *buf);
>  extern void gfs2_ea_header_in(struct gfs2_ea_header *ea, const void *buf=
);
>  extern void gfs2_ea_header_out(const struct gfs2_ea_header *ea, void *bu=
f);
>  extern void gfs2_log_header_in(struct gfs2_log_header_host *lh, const vo=
id *buf);
--=20
Russell Cattelan <cattelan@thebarn.com>

--=-/vcLrlE83T1254Z6B5ZX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFcIAoNRmM+OaGhBgRAq13AJ4ma45qL+eY66kMdAmhQtTTCoX0lwCdETJn
+TOQ7ZYiMoN+iWbPyEZVO68=
=tkqF
-----END PGP SIGNATURE-----

--=-/vcLrlE83T1254Z6B5ZX--

