Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbUEWKjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbUEWKjR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 06:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbUEWKjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 06:39:17 -0400
Received: from cantor.suse.de ([195.135.220.2]:1931 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262029AbUEWKjP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 06:39:15 -0400
Date: Sun, 23 May 2004 12:37:18 +0200
From: Kurt Garloff <garloff@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Lorenzo Allegrucci <l_allegrucci@despammed.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm5 oops mounting ext3 or reiserfs with -o barrier
Message-ID: <20040523103717.GA5253@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Jens Axboe <axboe@suse.de>,
	Lorenzo Allegrucci <l_allegrucci@despammed.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200405222107.55505.l_allegrucci@despammed.com> <20040523082728.GH1952@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20040523082728.GH1952@suse.de>
X-Operating-System: Linux 2.6.5-12-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On Sun, May 23, 2004 at 10:27:28AM +0200, Jens Axboe wrote:
> @@ -1729,8 +1723,29 @@ static void idedisk_setup (ide_drive_t *
> =20
>  	write_cache(drive, 1);
> =20
> -	blk_queue_ordered(drive->queue, 1);
> -	blk_queue_issue_flush_fn(drive->queue, idedisk_issue_flush);
> +	/*
> +	 * decide if we can sanely support flushes and barriers on
> +	 * this drive
> +	 */
> +	if (drive->addressing =3D=3D 1) {
> +		/*
> +		 * if capacity is over 2^28 sectors, drive must support
> +		 * FLUSH_CACHE_EXT
> +		 */
> +		if (ide_id_has_flush_cache_ext(id))
> +			barrier =3D 1;
> +		else if (capacity <=3D (1ULL << 28))
> +			barrier =3D 1;
> +		else
> +			printk("%s: drive is buggy, no support for FLUSH_CACHE_EXT with lba48=
\n", drive->name);

So, for drives with LBA48, you enable barriers either if report to
support it or if their capacity is _smaller_ than 2^28. If neither
is the case, it's left disabled and the kernel complains.
Is it safe to enable for=20
(addressing =3D=3D 1 && !ide_id_has_flush_cache_ext() && capacity <=3D 1<<2=
8)
?
Shouldn't we check ide_has_flush_cache() then, as for the non-
LBA48 drives?

> +	} else if (ide_id_has_flush_cache(id))
> +		barrier =3D 1;

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                            Cologne, DE=20
SUSE LINUX AG / Novell, Nuernberg, DE               Director SUSE Labs

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAsH7dxmLh6hyYd04RAqnBAJ9hfqH4MUeAorykh6QdkgROW5LfbQCdE+tL
h1/XOui4DJ1EXvCuuIKEJQg=
=iF84
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
