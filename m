Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266846AbUFYTNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266846AbUFYTNe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 15:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266847AbUFYTNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 15:13:33 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:44765 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S266846AbUFYTM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 15:12:56 -0400
Date: Fri, 25 Jun 2004 13:12:53 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Goldwyn Rodrigues <goldwyn_r@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Breaking ext2 file size limit of 2TB
Message-ID: <20040625191253.GG31203@schnapps.adilger.int>
Mail-Followup-To: Goldwyn Rodrigues <goldwyn_r@myrealbox.com>,
	linux-kernel@vger.kernel.org
References: <1088168646.d642871cgoldwyn_r@myrealbox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kgh2FNDOY+603hGA"
Content-Disposition: inline
In-Reply-To: <1088168646.d642871cgoldwyn_r@myrealbox.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Kgh2FNDOY+603hGA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 25, 2004  18:34 +0530, Goldwyn Rodrigues wrote:
> I have made a patch to enable file creation greater than 2TB. I tested it
> using sparse files and it works good.
>=20
> Working:
> The file size limit of the ext3 filesystem is limited to 2TB because of
> i_blocks, a variable which stores the number of 512 blocks in the inode.
> i_blocks is a 32 which limits the number it can hold. The patch makes
> use of l_i_reserved1 field to keep the higher order bits of i_blocks.

Do you have a real demand for doing this?  Given that block devices are
limited to 16TB on 32-bit architectures (page size * long), and ext3
files themselves are limited to 4TB+ (i386 page size again) because of
the triple-indirect block limit this isn't much of a win until we go to
something like extents.  Are you using a non-i386 architecture?

If we started using larger blocksizes for systems that have larger than
4kB pages (i.e. not i386) this would become an issue.  At some point
having giant files w/o extents is pointless (performance is too bad),
so we could also put the high blocks count in as part of the extent data
(e.g. i_blocks[14]) since the format would be gratuitously incompatible
anyways.

> @@ -1003,9 +1003,9 @@
>  	res +=3D 1LL << (bits-2);
>  	res +=3D 1LL << (2*(bits-2));
>  	res +=3D 1LL << (3*(bits-2));
> -	res <<=3D bits;
> -	if (res > (512LL << 32) - (1 << bits))
> -		res =3D (512LL << 32) - (1 << bits);
> +	/* Since another block is added, we add the same number again */
> +	res +=3D 1LL << (3*(bits-2));
> +	res <<=3Dbits;

This is incorrect.  All that this change does is remove the extra
"res > (512LL << 32) - (1 << bits)" limit.  Even that could be removed
for sparse files without any of these changes if we wanted to check
at block allocation time whether we would overflow the i_blocks limit.

>  struct buffer_head *ext3_bread(handle_t *handle, struct inode * inode,
> -                              int block, int create, int *err)
> +                              sector_t block, int create, int *err)
> {
>         struct buffer_head * bh;
> -       int prev_blocks;
> +       sector_t prev_blocks;

This is a good fix regardless (at least change it to long from int).

> This has been developed and tested on kernel version 2.6.5 using sparse f=
iles.

That isn't really a test of anything, since a sparse file will not use=20
more than 2^32 blocks.

> #define i_blocks_high		osd1.linux1.l_i_reserved1

If we really wanted to avoid being incompatible with Hurd (I personally
don't care about that, but someone who knows more should comment on how
badly this will screw things for it) we could use one of the other fields in
the inode like m_i_frag + m_i_fsize, or i_faddr as none of them is actually
used.  We also only really need 24 bits of this word before we hit the
64-bit byte i_size limit so we may as well be prudent and mask off the high
byte for later use.

Does anyone know if Hurd actually use both i_translator (i_reserved1) and
i_mode_high field (i_pad1)?

In any case, we need to wrap this with some sort of COMPAT flag in the
superblock, and probably a per-inode flag as well, so we know to trust
this value.

> --- linux-2.6.5-orig/include/linux/fs.h	2004-04-04 09:06:52.000000000 +05=
30
> +++ linux-2.6.5-4TB/include/linux/fs.h	2004-06-23 12:18:43.000000000 +0530
> @@ -393,7 +393,11 @@
>  	unsigned int		i_blkbits;
>  	unsigned long		i_blksize;
>  	unsigned long		i_version;
> +#if !defined(CONFIG_EXT3_LARGE_FILE_SUPPORT) || defined(CONFIG_64BIT)
>  	unsigned long		i_blocks;
> +#else
> +	unsigned long long	i_blocks;
> +#endif /* CONFIG_EXT3_LARGE_FILE_SUPPORT */

Why not just declare this as sector_t?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--Kgh2FNDOY+603hGA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFA3Hk1pIg59Q01vtYRAuw5AKC7JHU5oJCxImI4WiounI8KHCU3rQCeOx07
7yjH/AJGuMNQUMVpoCptz3Y=
=MX/2
-----END PGP SIGNATURE-----

--Kgh2FNDOY+603hGA--
