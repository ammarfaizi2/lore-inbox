Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262344AbVBKV20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbVBKV20 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 16:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbVBKV20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 16:28:26 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:7659 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S262344AbVBKV1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 16:27:39 -0500
Date: Fri, 11 Feb 2005 14:27:36 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       "Theodore Ts'o" <tytso@mit.edu>, Alex Tomas <alex@clusterfs.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Ext2/3 32-bit stat() wrap for ~2TB files
Message-ID: <20050211212736.GD16520@schnapps.adilger.int>
Mail-Followup-To: "Stephen C. Tweedie" <sct@redhat.com>,
	"ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
	Theodore Ts'o <tytso@mit.edu>, Alex Tomas <alex@clusterfs.com>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <1108155135.1944.196.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qrgsu6vtpU/OV/zm"
Content-Disposition: inline
In-Reply-To: <1108155135.1944.196.camel@sisko.sctweedie.blueyonder.co.uk>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qrgsu6vtpU/OV/zm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Feb 11, 2005  20:52 +0000, Stephen C. Tweedie wrote:
> /*
>  * Maximal file size.  There is a direct, and {,double-,triple-}indirect
>  * block limit, and also a limit of (2^32 - 1) 512-byte sectors in i_bloc=
ks.
>  * We need to be 1 filesystem block less than the 2^32 sector limit.
>  */
>=20
> Trouble is, that limit *should* be an i_blocks limit, because i_blocks
> is still 32-bits, and (more importantly) is multiplied by the fs
> blocksize / 512 in stat(2) to return st_blocks in 512-byte chunks.=20
> Overflow 2^32 sectors in i_blocks and stat(2) wraps.

I agree.  The problem AFAIR is that the i_blocks accounting is done in
the quota code, so it was a challenge to get it right, and the i_size
limit was easier to do.  Until now I don't think anyone has created
dense 2TB files, so the sparse limit was enough.

Fixing this to count i_blocks correctly would also allow us to have
larger sparse files (up to the indirect limit).

Note also that there was a patch to extend i_blocks floating around
(pretty small hack to use one of the reserved fields), and it might make
sense to get this into the kernel before we actually need it.

> But i_blocks includes indirect blocks as well as data, so for a
> non-sparse file we wrap stat(2) st_blocks well before the file is
> 2^32*512 bytes long.  Yet ext3_max_size() doesn't understand this:
> it simply caps the size with
>=20
> 	if (res > (512LL << 32) - (1 << bits))
> 		res =3D (512LL << 32) - (1 << bits);

So, for the quick fix we could reduce this by the number of expected
[td]indirect blocks and submit that to 2.4 also.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--Qrgsu6vtpU/OV/zm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFCDSNIpIg59Q01vtYRArUQAJoCtuDNhckQdcQz3qY0nvFgB3rklACg3jsc
/1xEplsxTdfR5lIKL6YV9fw=
=jElD
-----END PGP SIGNATURE-----

--Qrgsu6vtpU/OV/zm--
