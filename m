Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759323AbWLASOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759323AbWLASOO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 13:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759324AbWLASOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 13:14:14 -0500
Received: from cattelan-host202.dsl.visi.com ([208.42.117.202]:27101 "EHLO
	slurp.thebarn.com") by vger.kernel.org with ESMTP id S1759323AbWLASON
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 13:14:13 -0500
Subject: Re: [GFS2] Shrink gfs2_inode (5) - di_nlink [25/70]
From: Russell Cattelan <cattelan@thebarn.com>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <1164888978.3752.354.camel@quoit.chygwyn.com>
References: <1164888978.3752.354.camel@quoit.chygwyn.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uaoxFNKYdHLdXLY9zEPl"
Date: Fri, 01 Dec 2006 12:14:03 -0600
Message-Id: <1164996843.1194.48.camel@xenon.msp.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1-1mdv2007.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uaoxFNKYdHLdXLY9zEPl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-11-30 at 12:16 +0000, Steven Whitehouse wrote:
> >From 4f56110a00af5fb2e22fbccfcaf944d62cae8fcf Mon Sep 17 00:00:00 2001
> From: Steven Whitehouse <swhiteho@redhat.com>
> Date: Wed, 1 Nov 2006 14:04:17 -0500
> Subject: [PATCH] [GFS2] Shrink gfs2_inode (5) - di_nlink
>=20
> Remove the di_nlink field in favour of inode->i_nlink and
> update the nlink handling to use the proper macros. This
> saves 4 bytes.

This patch seems like is one in a bigger series of patches
that should be done all at once?

While creating a patches on a per field basis is good
having partial changes checked in like this is confusing.
Since now the use of data structures is inconsistent.

What do -1 and -2 represent? I assume that is a special
state or the inode? maybe some comments or use of=20
descriptive macros.


>=20
> Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
> ---
>  fs/gfs2/inode.c             |   37 ++++++++++++++++++++++++-------------
>  fs/gfs2/ondisk.c            |    3 +--
>  fs/gfs2/ops_inode.c         |   12 ++++++------
>  include/linux/gfs2_ondisk.h |    1 -
>  4 files changed, 31 insertions(+), 22 deletions(-)
>=20
> diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> index 0de9b22..7112039 100644
> --- a/fs/gfs2/inode.c
> +++ b/fs/gfs2/inode.c
> @@ -51,7 +51,6 @@ void gfs2_inode_attr_in(struct gfs2_inod
>  	struct gfs2_dinode_host *di =3D &ip->i_di;
> =20
>  	inode->i_ino =3D ip->i_num.no_addr;
> -	inode->i_nlink =3D di->di_nlink;
>  	i_size_write(inode, di->di_size);
>  	inode->i_atime.tv_sec =3D di->di_atime;
>  	inode->i_mtime.tv_sec =3D di->di_mtime;
> @@ -214,7 +213,12 @@ static int gfs2_dinode_in(struct gfs2_in
> =20
>  	ip->i_inode.i_uid =3D be32_to_cpu(str->di_uid);
>  	ip->i_inode.i_gid =3D be32_to_cpu(str->di_gid);
> -	di->di_nlink =3D be32_to_cpu(str->di_nlink);
> +	/*
> +	 * We will need to review setting the nlink count here in the
> +	 * light of the forthcoming ro bind mount work. This is a reminder
> +	 * to do that.
> +	 */
> +	ip->i_inode.i_nlink =3D be32_to_cpu(str->di_nlink);
>  	di->di_size =3D be64_to_cpu(str->di_size);
>  	di->di_blocks =3D be64_to_cpu(str->di_blocks);
>  	di->di_atime =3D be64_to_cpu(str->di_atime);
> @@ -336,12 +340,12 @@ int gfs2_change_nlink(struct gfs2_inode=20
>  	u32 nlink;
>  	int error;
> =20
> -	BUG_ON(ip->i_di.di_nlink !=3D ip->i_inode.i_nlink);
> -	nlink =3D ip->i_di.di_nlink + diff;
> +	BUG_ON(diff !=3D 1 && diff !=3D -1);
> +	nlink =3D ip->i_inode.i_nlink + diff;
> =20
>  	/* If we are reducing the nlink count, but the new value ends up being
>  	   bigger than the old one, we must have underflowed. */
> -	if (diff < 0 && nlink > ip->i_di.di_nlink) {
> +	if (diff < 0 && nlink > ip->i_inode.i_nlink) {
>  		if (gfs2_consist_inode(ip))
>  			gfs2_dinode_print(ip);
>  		return -EIO;
> @@ -351,16 +355,19 @@ int gfs2_change_nlink(struct gfs2_inode=20
>  	if (error)
>  		return error;
> =20
> -	ip->i_di.di_nlink =3D nlink;
> +	if (diff > 0)
> +		inc_nlink(&ip->i_inode);
> +	else
> +		drop_nlink(&ip->i_inode);
> +
>  	ip->i_di.di_ctime =3D get_seconds();
> -	ip->i_inode.i_nlink =3D nlink;
> =20
>  	gfs2_trans_add_bh(ip->i_gl, dibh, 1);
>  	gfs2_dinode_out(ip, dibh->b_data);
>  	brelse(dibh);
>  	mark_inode_dirty(&ip->i_inode);
> =20
> -	if (ip->i_di.di_nlink =3D=3D 0) {
> +	if (ip->i_inode.i_nlink =3D=3D 0) {
>  		struct gfs2_rgrpd *rgd;
>  		struct gfs2_holder ri_gh, rg_gh;
> =20
> @@ -375,7 +382,6 @@ int gfs2_change_nlink(struct gfs2_inode=20
>  		if (error)
>  			goto out_norgrp;
> =20
> -		clear_nlink(&ip->i_inode);
>  		gfs2_unlink_di(&ip->i_inode); /* mark inode unlinked */
>  		gfs2_glock_dq_uninit(&rg_gh);
>  out_norgrp:
> @@ -586,7 +592,7 @@ static int create_ok(struct gfs2_inode *
>  		return error;
> =20
>  	/*  Don't create entries in an unlinked directory  */
> -	if (!dip->i_di.di_nlink)
> +	if (!dip->i_inode.i_nlink)
>  		return -EPERM;
> =20
>  	error =3D gfs2_dir_search(&dip->i_inode, name, NULL, NULL);
> @@ -602,7 +608,7 @@ static int create_ok(struct gfs2_inode *
> =20
>  	if (dip->i_di.di_entries =3D=3D (u32)-1)
>  		return -EFBIG;
> -	if (S_ISDIR(mode) && dip->i_di.di_nlink =3D=3D (u32)-1)
> +	if (S_ISDIR(mode) && dip->i_inode.i_nlink =3D=3D (u32)-1)
>  		return -EMLINK;
> =20
>  	return 0;
> @@ -808,7 +814,7 @@ static int link_dinode(struct gfs2_inode
>  	error =3D gfs2_meta_inode_buffer(ip, &dibh);
>  	if (error)
>  		goto fail_end_trans;
> -	ip->i_di.di_nlink =3D 1;
> +	ip->i_inode.i_nlink =3D 1;
>  	gfs2_trans_add_bh(ip->i_gl, dibh, 1);
>  	gfs2_dinode_out(ip, dibh->b_data);
>  	brelse(dibh);
> @@ -1016,7 +1022,12 @@ int gfs2_rmdiri(struct gfs2_inode *dip,=20
>  	if (error)
>  		return error;
> =20
> -	error =3D gfs2_change_nlink(ip, -2);
> +	/* It looks odd, but it really should be done twice */
> +	error =3D gfs2_change_nlink(ip, -1);
> +	if (error)
> +		return error;
> +
> +	error =3D gfs2_change_nlink(ip, -1);
>  	if (error)
>  		return error;
> =20
> diff --git a/fs/gfs2/ondisk.c b/fs/gfs2/ondisk.c
> index e224f6a..b4e354b 100644
> --- a/fs/gfs2/ondisk.c
> +++ b/fs/gfs2/ondisk.c
> @@ -164,7 +164,7 @@ void gfs2_dinode_out(const struct gfs2_i
>  	str->di_mode =3D cpu_to_be32(ip->i_inode.i_mode);
>  	str->di_uid =3D cpu_to_be32(ip->i_inode.i_uid);
>  	str->di_gid =3D cpu_to_be32(ip->i_inode.i_gid);
> -	str->di_nlink =3D cpu_to_be32(di->di_nlink);
> +	str->di_nlink =3D cpu_to_be32(ip->i_inode.i_nlink);
>  	str->di_size =3D cpu_to_be64(di->di_size);
>  	str->di_blocks =3D cpu_to_be64(di->di_blocks);
>  	str->di_atime =3D cpu_to_be64(di->di_atime);
> @@ -191,7 +191,6 @@ void gfs2_dinode_print(const struct gfs2
> =20
>  	gfs2_inum_print(&ip->i_num);
> =20
> -	pv(di, di_nlink, "%u");
>  	printk(KERN_INFO "  di_size =3D %llu\n", (unsigned long long)di->di_siz=
e);
>  	printk(KERN_INFO "  di_blocks =3D %llu\n", (unsigned long long)di->di_b=
locks);
>  	printk(KERN_INFO "  di_atime =3D %lld\n", (long long)di->di_atime);
> diff --git a/fs/gfs2/ops_inode.c b/fs/gfs2/ops_inode.c
> index efbcec3..06176de 100644
> --- a/fs/gfs2/ops_inode.c
> +++ b/fs/gfs2/ops_inode.c
> @@ -169,7 +169,7 @@ static int gfs2_link(struct dentry *old_
>  	}
> =20
>  	error =3D -EINVAL;
> -	if (!dip->i_di.di_nlink)
> +	if (!dip->i_inode.i_nlink)
>  		goto out_gunlock;
>  	error =3D -EFBIG;
>  	if (dip->i_di.di_entries =3D=3D (u32)-1)
> @@ -178,10 +178,10 @@ static int gfs2_link(struct dentry *old_
>  	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
>  		goto out_gunlock;
>  	error =3D -EINVAL;
> -	if (!ip->i_di.di_nlink)
> +	if (!ip->i_inode.i_nlink)
>  		goto out_gunlock;
>  	error =3D -EMLINK;
> -	if (ip->i_di.di_nlink =3D=3D (u32)-1)
> +	if (ip->i_inode.i_nlink =3D=3D (u32)-1)
>  		goto out_gunlock;
> =20
>  	alloc_required =3D error =3D gfs2_diradd_alloc_required(dir, &dentry->d=
_name);
> @@ -386,7 +386,7 @@ static int gfs2_mkdir(struct inode *dir,
> =20
>  	ip =3D ghs[1].gh_gl->gl_object;
> =20
> -	ip->i_di.di_nlink =3D 2;
> +	ip->i_inode.i_nlink =3D 2;
>  	ip->i_di.di_size =3D sdp->sd_sb.sb_bsize - sizeof(struct gfs2_dinode);
>  	ip->i_di.di_flags |=3D GFS2_DIF_JDATA;
>  	ip->i_di.di_payload_format =3D GFS2_FORMAT_DE;
> @@ -636,7 +636,7 @@ static int gfs2_rename(struct inode *odi
>  		};
> =20
>  		if (odip !=3D ndip) {
> -			if (!ndip->i_di.di_nlink) {
> +			if (!ndip->i_inode.i_nlink) {
>  				error =3D -EINVAL;
>  				goto out_gunlock;
>  			}
> @@ -645,7 +645,7 @@ static int gfs2_rename(struct inode *odi
>  				goto out_gunlock;
>  			}
>  			if (S_ISDIR(ip->i_inode.i_mode) &&
> -			    ndip->i_di.di_nlink =3D=3D (u32)-1) {
> +			    ndip->i_inode.i_nlink =3D=3D (u32)-1) {
>  				error =3D -EMLINK;
>  				goto out_gunlock;
>  			}
> diff --git a/include/linux/gfs2_ondisk.h b/include/linux/gfs2_ondisk.h
> index 896c7f8..c61517b 100644
> --- a/include/linux/gfs2_ondisk.h
> +++ b/include/linux/gfs2_ondisk.h
> @@ -322,7 +322,6 @@ struct gfs2_dinode {
>  };
> =20
>  struct gfs2_dinode_host {
> -	__u32 di_nlink;	/* number of links to this file */
>  	__u64 di_size;	/* number of bytes in file */
>  	__u64 di_blocks;	/* number of blocks in file */
>  	__u64 di_atime;	/* time last accessed */
--=20
Russell Cattelan <cattelan@thebarn.com>

--=-uaoxFNKYdHLdXLY9zEPl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFcHDrNRmM+OaGhBgRAujTAJ9lrcjVsceQ3LXjWaiic+vBOrGi7wCdEvMI
RjZbBzcDT6Gx6cQ21ro66uU=
=j85U
-----END PGP SIGNATURE-----

--=-uaoxFNKYdHLdXLY9zEPl--

