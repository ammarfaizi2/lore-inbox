Return-Path: <linux-kernel-owner+w=401wt.eu-S932105AbWLOAhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWLOAhs (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 19:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751736AbWLOAhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 19:37:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55327 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751617AbWLOAhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 19:37:46 -0500
Subject: Re: [RFC: 2.6 patch] simplify drivers/md/md.c:update_size()
From: Doug Ledford <dledford@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Neil Brown <neilb@suse.de>, mingo@redhat.com, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061215001902.GR3388@stusta.de>
References: <20061215001902.GR3388@stusta.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-0EJbScvIlitLX4BgxUB5"
Organization: Red Hat, Inc.
Date: Thu, 14 Dec 2006 19:36:35 -0500
Message-Id: <1166142995.2745.319.camel@fc6.xsintricity.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0EJbScvIlitLX4BgxUB5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-12-15 at 01:19 +0100, Adrian Bunk wrote:
> While looking at commit 8ddeeae51f2f197b4fafcba117ee8191b49d843e,
> I got the impression that this commit couldn't fix anything, since the=20
> "size" variable can't be changed before "fit" gets used.
>=20
> Is there any big thinko, or is the patch below that slightly simplifies=20
> update_size() semantically equivalent to the current code?

No, this patch is broken.  Where it fails is specifically the case where
you want to autofit the largest possible size, you have different size
devices, and the first device is not the smallest.  When you hit the
first device, you will set size, then as you repeat the ITERATE_RDEV
loop, when you hit the smaller device, size will be non-0 and you'll
then trigger the later if and return -ENOSPC.  In the case of autofit,
you have to preserve the fit variable instead of looking at size so you
know whether or not to modify the size when you hit a smaller device
later in the list.

> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>=20
> ---
>=20
>  drivers/md/md.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> --- linux-2.6.19-mm1/drivers/md/md.c.old	2006-12-15 00:57:05.000000000 +0=
100
> +++ linux-2.6.19-mm1/drivers/md/md.c	2006-12-15 00:57:42.000000000 +0100
> @@ -4039,57 +4039,56 @@
>  	 * Generate a 128 bit UUID
>  	 */
>  	get_random_bytes(mddev->uuid, 16);
> =20
>  	mddev->new_level =3D mddev->level;
>  	mddev->new_chunk =3D mddev->chunk_size;
>  	mddev->new_layout =3D mddev->layout;
>  	mddev->delta_disks =3D 0;
> =20
>  	mddev->dead =3D 0;
>  	return 0;
>  }
> =20
>  static int update_size(mddev_t *mddev, unsigned long size)
>  {
>  	mdk_rdev_t * rdev;
>  	int rv;
>  	struct list_head *tmp;
> -	int fit =3D (size =3D=3D 0);
> =20
>  	if (mddev->pers->resize =3D=3D NULL)
>  		return -EINVAL;
>  	/* The "size" is the amount of each device that is used.
>  	 * This can only make sense for arrays with redundancy.
>  	 * linear and raid0 always use whatever space is available
>  	 * We can only consider changing the size if no resync
>  	 * or reconstruction is happening, and if the new size
>  	 * is acceptable. It must fit before the sb_offset or,
>  	 * if that is <data_offset, it must fit before the
>  	 * size of each device.
>  	 * If size is zero, we find the largest size that fits.
>  	 */
>  	if (mddev->sync_thread)
>  		return -EBUSY;
>  	ITERATE_RDEV(mddev,rdev,tmp) {
>  		sector_t avail;
>  		avail =3D rdev->size * 2;
> =20
> -		if (fit && (size =3D=3D 0 || size > avail/2))
> +		if (size =3D=3D 0)
>  			size =3D avail/2;
>  		if (avail < ((sector_t)size << 1))
>  			return -ENOSPC;
>  	}
>  	rv =3D mddev->pers->resize(mddev, (sector_t)size *2);
>  	if (!rv) {
>  		struct block_device *bdev;
> =20
>  		bdev =3D bdget_disk(mddev->gendisk, 0);
>  		if (bdev) {
>  			mutex_lock(&bdev->bd_inode->i_mutex);
>  			i_size_write(bdev->bd_inode, (loff_t)mddev->array_size << 10);
>  			mutex_unlock(&bdev->bd_inode->i_mutex);
>  			bdput(bdev);
>  		}
>  	}
>  	return rv;
>  }
--=20
Doug Ledford <dledford@redhat.com>
              GPG KeyID: CFBFF194
              http://people.redhat.com/dledford

Infiniband specific RPMs available at
              http://people.redhat.com/dledford/Infiniband

--=-0EJbScvIlitLX4BgxUB5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFge4TTzP9PM7pjw8RAid6AJsGdZ8+3+MFJazsRdFF6VMR6OeXiACeJBsM
996JRaHM7wGCzkEpS6Q7RC4=
=Hdrn
-----END PGP SIGNATURE-----

--=-0EJbScvIlitLX4BgxUB5--

