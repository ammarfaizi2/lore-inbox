Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267433AbUHSVrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267433AbUHSVrz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 17:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267436AbUHSVrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 17:47:55 -0400
Received: from cantor.suse.de ([195.135.220.2]:9879 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267433AbUHSVrr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 17:47:47 -0400
Date: Thu, 19 Aug 2004 21:55:21 +0200
From: Kurt Garloff <garloff@suse.de>
To: Chris Mason <mason@suse.com>
Cc: Con Kolivas <kernel@kolivas.org>, Jens Axboe <axboe@suse.de>,
       Greg Afinogenov <antisthenes@inbox.ru>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] bio_uncopy_user mem leak
Message-ID: <20040819195521.GC12363@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Chris Mason <mason@suse.com>, Con Kolivas <kernel@kolivas.org>,
	Jens Axboe <axboe@suse.de>, Greg Afinogenov <antisthenes@inbox.ru>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <1092909598.8364.5.camel@localhost> <412489E5.7000806@kolivas.org> <1092923494.12138.1667.camel@watt.suse.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sr1nOIr3CvdE5hEN"
Content-Disposition: inline
In-Reply-To: <1092923494.12138.1667.camel@watt.suse.com>
X-Operating-System: Linux 2.6.8-1-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Thu, Aug 19, 2004 at 09:51:34AM -0400, Chris Mason wrote:
> On Thu, 2004-08-19 at 07:07, Con Kolivas wrote:
> > Ok I just tested this patch discretely and indeed the memory leak goes=
=20
> > away but it still produces coasters so something is still amuck. Just a=
s=20
> > a data point; burning DVDs and data cds is ok. Burning audio *and=20
> > videocds* is not.
>=20
> It might be the cold medicine talking, but I think we need something
> like this.  gcc tested it for me, beyond that I make no promises....
>=20
> --- l/fs/bio.c.1	2004-08-19 09:36:13.596858736 -0400
> +++ l/fs/bio.c	2004-08-19 09:47:46.392537784 -0400
> @@ -454,6 +454,7 @@
>  	 */
>  	if (!ret) {
>  		if (!write_to_vm) {
> +			unsigned long p =3D uaddr;
>  			bio->bi_rw |=3D (1 << BIO_RW);
>  			/*
>  	 		 * for a write, copy in data to kernel pages
> @@ -462,8 +463,9 @@
>  			bio_for_each_segment(bvec, bio, i) {
>  				char *addr =3D page_address(bvec->bv_page);
> =20
> -				if (copy_from_user(addr, (char *) uaddr, bvec->bv_len))
> +				if (copy_from_user(addr, (char *) p, bvec->bv_len))
>  					goto cleanup;
> +				p +=3D bvec->bv_len;
>  			}
>  		}
> =20

Hmm, that patch would make a lot of sense to me.

It matches the problem description; burning data CDs, we don't
use bounce buffers, so that does not use this code path. Here,
it looks like we copied the same userspace page again and again
into a multisegment BIO. Ouch!

Not yet tested either :-(

Regards,
--=20
Kurt Garloff, Director SUSE Labs, Novell Inc.

--Sr1nOIr3CvdE5hEN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBJQWpxmLh6hyYd04RAkZfAJ9OuFU0LHfje7KsTLPx5ffBCUluiwCgk2z3
d8fsGInAy0ctpN4b4Gxs9OE=
=pSXR
-----END PGP SIGNATURE-----

--Sr1nOIr3CvdE5hEN--
