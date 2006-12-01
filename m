Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031734AbWLATRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031734AbWLATRN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 14:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031736AbWLATRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 14:17:13 -0500
Received: from cattelan-host202.dsl.visi.com ([208.42.117.202]:45533 "EHLO
	slurp.thebarn.com") by vger.kernel.org with ESMTP id S1031734AbWLATRM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 14:17:12 -0500
Subject: Re: [GFS2] Move gfs2_meta_syncfs() into log.c [57/70]
From: Russell Cattelan <cattelan@thebarn.com>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <1164889320.3752.419.camel@quoit.chygwyn.com>
References: <1164889320.3752.419.camel@quoit.chygwyn.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-bMgpic93SbhwW4pnzpwg"
Date: Fri, 01 Dec 2006 13:16:17 -0600
Message-Id: <1165000577.1194.87.camel@xenon.msp.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1-1mdv2007.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bMgpic93SbhwW4pnzpwg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-11-30 at 12:22 +0000, Steven Whitehouse wrote:
> >From a25311c8e0b7071b129ca9a9e49e22eeaf620864 Mon Sep 17 00:00:00 2001
> From: Steven Whitehouse <swhiteho@redhat.com>
> Date: Thu, 23 Nov 2006 11:06:35 -0500
> Subject: [PATCH] [GFS2] Move gfs2_meta_syncfs() into log.c
>=20
> By moving gfs2_meta_syncfs() into log.c, gfs2_ail1_start()
> can be made static.
While this is not a incorrect change as it stands.
This kind of pointless code curn is making it harder
to stabilize GFS2.

>=20
> Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
> ---
>  fs/gfs2/log.c     |   21 ++++++++++++++++++++-
>  fs/gfs2/log.h     |    2 +-
>  fs/gfs2/meta_io.c |   17 -----------------
>  fs/gfs2/meta_io.h |    1 -
>  4 files changed, 21 insertions(+), 20 deletions(-)
>=20
> diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
> index 6456fc3..7713d59 100644
> --- a/fs/gfs2/log.c
> +++ b/fs/gfs2/log.c
> @@ -15,6 +15,7 @@ #include <linux/buffer_head.h>
>  #include <linux/gfs2_ondisk.h>
>  #include <linux/crc32.h>
>  #include <linux/lm_interface.h>
> +#include <linux/delay.h>
> =20
>  #include "gfs2.h"
>  #include "incore.h"
> @@ -142,7 +143,7 @@ static int gfs2_ail1_empty_one(struct gf
>  	return list_empty(&ai->ai_ail1_list);
>  }
> =20
> -void gfs2_ail1_start(struct gfs2_sbd *sdp, int flags)
> +static void gfs2_ail1_start(struct gfs2_sbd *sdp, int flags)
>  {
>  	struct list_head *head =3D &sdp->sd_ail1_list;
>  	u64 sync_gen;
> @@ -689,3 +690,21 @@ void gfs2_log_shutdown(struct gfs2_sbd *
>  	up_write(&sdp->sd_log_flush_lock);
>  }
> =20
> +
> +/**
> + * gfs2_meta_syncfs - sync all the buffers in a filesystem
> + * @sdp: the filesystem
> + *
> + */
> +
> +void gfs2_meta_syncfs(struct gfs2_sbd *sdp)
> +{
> +	gfs2_log_flush(sdp, NULL);
> +	for (;;) {
> +		gfs2_ail1_start(sdp, DIO_ALL);
> +		if (gfs2_ail1_empty(sdp, DIO_ALL))
> +			break;
> +		msleep(10);
> +	}
> +}
> +
> diff --git a/fs/gfs2/log.h b/fs/gfs2/log.h
> index 7f5737d..8e7aa0f 100644
> --- a/fs/gfs2/log.h
> +++ b/fs/gfs2/log.h
> @@ -48,7 +48,6 @@ static inline void gfs2_log_pointers_ini
>  unsigned int gfs2_struct2blk(struct gfs2_sbd *sdp, unsigned int nstruct,
>  			    unsigned int ssize);
> =20
> -void gfs2_ail1_start(struct gfs2_sbd *sdp, int flags);
>  int gfs2_ail1_empty(struct gfs2_sbd *sdp, int flags);
> =20
>  int gfs2_log_reserve(struct gfs2_sbd *sdp, unsigned int blks);
> @@ -61,5 +60,6 @@ void gfs2_log_flush(struct gfs2_sbd *sdp
>  void gfs2_log_commit(struct gfs2_sbd *sdp, struct gfs2_trans *trans);
> =20
>  void gfs2_log_shutdown(struct gfs2_sbd *sdp);
> +void gfs2_meta_syncfs(struct gfs2_sbd *sdp);
> =20
>  #endif /* __LOG_DOT_H__ */
> diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
> index 939a09f..fbeba81 100644
> --- a/fs/gfs2/meta_io.c
> +++ b/fs/gfs2/meta_io.c
> @@ -574,20 +574,3 @@ out:
>  	return first_bh;
>  }
> =20
> -/**
> - * gfs2_meta_syncfs - sync all the buffers in a filesystem
> - * @sdp: the filesystem
> - *
> - */
> -
> -void gfs2_meta_syncfs(struct gfs2_sbd *sdp)
> -{
> -	gfs2_log_flush(sdp, NULL);
> -	for (;;) {
> -		gfs2_ail1_start(sdp, DIO_ALL);
> -		if (gfs2_ail1_empty(sdp, DIO_ALL))
> -			break;
> -		msleep(10);
> -	}
> -}
> -
> diff --git a/fs/gfs2/meta_io.h b/fs/gfs2/meta_io.h
> index 3ec939e..e037425 100644
> --- a/fs/gfs2/meta_io.h
> +++ b/fs/gfs2/meta_io.h
> @@ -67,7 +67,6 @@ static inline int gfs2_meta_inode_buffer
>  }
> =20
>  struct buffer_head *gfs2_meta_ra(struct gfs2_glock *gl, u64 dblock, u32 =
extlen);
> -void gfs2_meta_syncfs(struct gfs2_sbd *sdp);
> =20
>  #define buffer_busy(bh) \
>  ((bh)->b_state & ((1ul << BH_Dirty) | (1ul << BH_Lock) | (1ul << BH_Pinn=
ed)))
--=20
Russell Cattelan <cattelan@thebarn.com>

--=-bMgpic93SbhwW4pnzpwg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFcH+ANRmM+OaGhBgRAqZsAJwJar7tFuNu/Xuu/HthdaHRZdOkmwCePWJb
QYhr5yFwRTUIsIubt2tFlKw=
=C44C
-----END PGP SIGNATURE-----

--=-bMgpic93SbhwW4pnzpwg--

