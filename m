Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265508AbUGNUGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265508AbUGNUGA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 16:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265545AbUGNUGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 16:06:00 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:21637 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S265508AbUGNUF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 16:05:58 -0400
Date: Wed, 14 Jul 2004 14:05:54 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: ext3: bump mount count on journal replay
Message-ID: <20040714200554.GR23346@schnapps.adilger.int>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net
References: <20040714131525.GA1369@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="90wTzOiXAbbhNsuN"
Content-Disposition: inline
In-Reply-To: <20040714131525.GA1369@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--90wTzOiXAbbhNsuN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 14, 2004  15:15 +0200, Pavel Machek wrote:
> Currently, you get fsck "just to be sure" once every ~30 clean
> mounts or ~30 hard shutdowns. I believe that hard shutdown is way more
> likely to cause some disk corruption, so it would make sense to fsck
> more often when system is hit by hard shutdown.
>=20
> What about this patch?
>
> @@ -1484,9 +1485,11 @@
>  	 * root first: it may be modified in the journal!
>  	 */
>  	if (!test_opt(sb, NOLOAD) &&
> -	    EXT3_HAS_COMPAT_FEATURE(sb, EXT3_FEATURE_COMPAT_HAS_JOURNAL)) {
> -		if (ext3_load_journal(sb, es))
> -			goto failed_mount2;
> +	    EXT3_HAS_COMPAT_FEATURE(sb, EXT3_FEATURE_COMPAT_HAS_JOURNAL)) { {
> +		    mount_cost =3D 5;
> +		    if (ext3_load_journal(sb, es))
> +			    goto failed_mount2;
> +	    }

AFAICS, this just means that if you have an ext3 filesystem
(i.e. has_journal) that you will fsck 5x as often, not so great.  You
should instead check for INCOMPAT_RECOVER instead of HAS_JOURNAL.

Instead, you could change this to only increment the mount count after
a clean unmount 20% of the time (randomly).  Since most people bitch
about the full fsck anyways this is probably the better choice than
increasing the frequency of checks and forcing the users to change the
check interval to get the old behaviour.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--90wTzOiXAbbhNsuN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFA9ZIipIg59Q01vtYRAqwwAJ0azmgvzL/ma5NLMOa7upxJlYoK4gCg8VOm
7TeRlD5qDzMPDvTNfdBVDJQ=
=xaCK
-----END PGP SIGNATURE-----

--90wTzOiXAbbhNsuN--
