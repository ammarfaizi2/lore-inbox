Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282270AbRKWWft>; Fri, 23 Nov 2001 17:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282274AbRKWWfl>; Fri, 23 Nov 2001 17:35:41 -0500
Received: from f05s15.cac.psu.edu ([128.118.141.58]:63135 "EHLO
	f05n15.cac.psu.edu") by vger.kernel.org with ESMTP
	id <S282271AbRKWWfg>; Fri, 23 Nov 2001 17:35:36 -0500
Subject: Re: [PATCH][CFT] Re: 2.4.15-pre9 breakage (inode.c)
From: Phil Sorber <aafes@psu.edu>
To: Alexander Viro <viro@math.psu.edu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <Pine.GSO.4.21.0111231701440.2422-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0111231701440.2422-100000@weyl.math.psu.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-Wqnhz8G008RDkY9QV3AT"
X-Mailer: Evolution/0.16 (Preview Release)
Date: 23 Nov 2001 17:35:34 -0500
Message-Id: <1006554935.511.11.camel@praetorian>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Wqnhz8G008RDkY9QV3AT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

does this affect non-ext2 systems? the only complaints i have seen on
here were related to ext2, i am running reiserfs, should i have to be
worried as well?

On Fri, 2001-11-23 at 17:06, Alexander Viro wrote:
>=20
>=20
> On Fri, 23 Nov 2001, Alexander Viro wrote:
>=20
> > 	Untested fix follows.  And please, pass the brown paperbag... ;-/
>=20
> ... and now for something that really builds:
>=20
> diff -urN S15/fs/inode.c S15-fix/fs/inode.c
> --- S15/fs/inode.c	Fri Nov 23 06:45:43 2001
> +++ S15-fix/fs/inode.c	Fri Nov 23 17:04:05 2001
> @@ -1065,24 +1065,27 @@
>  			if (inode->i_state !=3D I_CLEAR)
>  				BUG();
>  		} else {
> -			if (!list_empty(&inode->i_hash) && sb && sb->s_root) {
> +			if (!list_empty(&inode->i_hash)) {
>  				if (!(inode->i_state & (I_DIRTY|I_LOCK))) {
>  					list_del(&inode->i_list);
>  					list_add(&inode->i_list, &inode_unused);
>  				}
>  				inodes_stat.nr_unused++;
>  				spin_unlock(&inode_lock);
> -				return;
> -			} else {
> -				list_del_init(&inode->i_list);
> +				if (!sb || sb->s_flags & MS_ACTIVE)
> +					return;
> +				write_inode_now(inode, 1);
> +				spin_lock(&inode_lock);
> +				inodes_stat.nr_unused--;
>  				list_del_init(&inode->i_hash);
> -				inode->i_state|=3DI_FREEING;
> -				inodes_stat.nr_inodes--;
> -				spin_unlock(&inode_lock);
> -				if (inode->i_data.nrpages)
> -					truncate_inode_pages(&inode->i_data, 0);
> -				clear_inode(inode);
>  			}
> +			list_del_init(&inode->i_list);
> +			inode->i_state|=3DI_FREEING;
> +			inodes_stat.nr_inodes--;
> +			spin_unlock(&inode_lock);
> +			if (inode->i_data.nrpages)
> +				truncate_inode_pages(&inode->i_data, 0);
> +			clear_inode(inode);
>  		}
>  		destroy_inode(inode);
>  	}
> diff -urN S15/fs/super.c S15-fix/fs/super.c
> --- S15/fs/super.c	Fri Nov 23 06:45:43 2001
> +++ S15-fix/fs/super.c	Fri Nov 23 16:56:50 2001
> @@ -462,6 +462,7 @@
>  	lock_super(s);
>  	if (!type->read_super(s, data, flags & MS_VERBOSE ? 1 : 0))
>  		goto out_fail;
> +	s->s_flags |=3D MS_ACTIVE;
>  	unlock_super(s);
>  	/* tell bdcache that we are going to keep this one */
>  	if (bdev)
> @@ -614,6 +615,7 @@
>  	lock_super(s);
>  	if (!fs_type->read_super(s, data, flags & MS_VERBOSE ? 1 : 0))
>  		goto out_fail;
> +	s->s_flags |=3D MS_ACTIVE;
>  	unlock_super(s);
>  	get_filesystem(fs_type);
>  	path_release(&nd);
> @@ -695,6 +697,7 @@
>  		lock_super(s);
>  		if (!fs_type->read_super(s, data, flags & MS_VERBOSE ? 1 : 0))
>  			goto out_fail;
> +		s->s_flags |=3D MS_ACTIVE;
>  		unlock_super(s);
>  		get_filesystem(fs_type);
>  		return s;
> @@ -739,6 +742,7 @@
>  	dput(root);
>  	fsync_super(sb);
>  	lock_super(sb);
> +	sb->s_flags &=3D ~MS_ACTIVE;
>  	invalidate_inodes(sb);	/* bad name - it should be evict_inodes() */
>  	if (sop) {
>  		if (sop->write_super && sb->s_dirt)
> diff -urN S15/include/linux/fs.h S15-fix/include/linux/fs.h
> --- S15/include/linux/fs.h	Fri Nov 23 06:45:44 2001
> +++ S15-fix/include/linux/fs.h	Fri Nov 23 17:01:18 2001
> @@ -110,6 +110,7 @@
>  #define MS_BIND		4096
>  #define MS_REC		16384
>  #define MS_VERBOSE	32768
> +#define MS_ACTIVE	(1<<30)
>  #define MS_NOUSER	(1<<31)
> =20
>  /*
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20
--=20
Phil Sorber
AIM: PSUdaemon
IRC: irc.openprojects.net #psulug PSUdaemon
GnuPG: keyserver - pgp.mit.edu

--=-Wqnhz8G008RDkY9QV3AT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA7/s82Xm6Gwek+iaQRAgY4AKCb4XSZ/QTb/QU4gRa4WSSqdODnEwCcDbmt
OO/pX/BB7DCZfCQbgM3+3Ig=
=lrMZ
-----END PGP SIGNATURE-----

--=-Wqnhz8G008RDkY9QV3AT--

