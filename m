Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWICPLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWICPLR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 11:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWICPLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 11:11:17 -0400
Received: from master.altlinux.org ([62.118.250.235]:25864 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1750865AbWICPLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 11:11:16 -0400
Date: Sun, 3 Sep 2006 19:11:08 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Jan Kara <jack@suse.cz>
Cc: Ben Fennema <bfennema@falcon.csc.calpoly.edu>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: UDF 1GB file size limit after CVE-2006-4145 fix
Message-ID: <20060903151108.GA27102@procyon.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

On Tue, Aug 15, 2006 at 01:56:26PM +0200, Jan Kara wrote:
> UDF code is not really ready to handle extents larger that 1GB. This is
> the easy way to forbid creating those.
>=20
> Also truncation code did not count with the case when there are no
> extents in the file and we are extending the file.
>=20
> Signed-off-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> ---
>  fs/udf/super.c    |    2 +-
>  fs/udf/truncate.c |   64 ++++++++++++++++++++++++++++++++---------------=
------
>  2 files changed, 40 insertions(+), 26 deletions(-)
>=20
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index 7de172e..fcce1a2 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -1659,7 +1659,7 @@ #endif
>  		iput(inode);
>  		goto error_out;
>  	}
> -	sb->s_maxbytes =3D MAX_LFS_FILESIZE;
> +	sb->s_maxbytes =3D 1<<30;
[... rest of patch skipped ...]

After this change the size of files which can be created on an UDF
filesystem becomes limited to 1GB.  This is very unfortunate - in
particular, it means that there will be no way to write a file larger
than 4GB to a DVD under Linux (mkisofs -udf does not support files
larger than 4GB, so the typical workaround was to use mkudffs and
mount -o loop).  In fact, this change may be considered as a
regression - large files on UDF seemed to work before (at least in
simple cases), and now they are forbidden.

Files larger than 1GB can be read even after this patch (because
s_maxbytes is not checked in read paths, and udf does not use
generic_file_lseek()), so old disks at least can be read.

What issues with files larger than 1GB have been found in the code?
Is someone working to fix these problems?

--=20
Sergey Vlasov

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE+vCMW82GfkQfsqIRAv9kAJ9/C1KuNz8vaahMi0xTYz1p87Ek+QCePUSd
udIQCa7gfeoNTW3/1sht4ks=
=puOu
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--

-- 
VGER BF report: U 0.506496
