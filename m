Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVBMR24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVBMR24 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 12:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbVBMR2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 12:28:55 -0500
Received: from smtp.etmail.cz ([160.218.43.220]:61583 "EHLO smtp.etmail.cz")
	by vger.kernel.org with ESMTP id S261286AbVBMR2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 12:28:51 -0500
Date: Sun, 13 Feb 2005 18:28:38 +0100
To: Luca <kronos@kronoz.cjb.net>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Steve Frenchs <french@samba.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6] Check return value of copy_to_user in fs/cifs/file.c [Re: Linux 2.6.11-rc4]
Message-ID: <20050213172838.GA7829@penguin.localdomain>
Mail-Followup-To: Luca <kronos@kronoz.cjb.net>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
	Steve Frenchs <french@samba.org>, Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.58.0502121928590.19649@ppc970.osdl.org> <20050213154416.GA26396@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <20050213154416.GA26396@dreamland.darkstar.lan>
User-Agent: Mutt/1.5.6+20040907i
From: sebek64@post.cz (Marcel Sebek)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 13, 2005 at 04:44:16PM +0100, Luca wrote:
> Linus Torvalds <torvalds@osdl.org> ha scritto:
> > this is hopefully the last -rc kernel before the real 2.6.11, so please=
=20
> > give it a whirl, and complain loudly about anything broken.
>=20
> The following patch against 2.6.11-rc4 fixes this compile time warning:
>=20
>  CC [M]  fs/cifs/file.o
> fs/cifs/file.c: In function `cifs_user_read':
> fs/cifs/file.c:1168: warning: ignoring return value of
> `copy_to_user', declared with attribute warn_unused_result
>=20
> I also added an explicit check for errors other than -EAGAIN, since
> CIFSSMBRead may return -ENOMEM if it's unable to allocate smb_com_read_rs=
p;
> in that case we don't want to call copy_to_user with a NULL pointer.
>=20
> Signed-off-by: Luca Tettamanti <kronoz@kronoz.cjb.net>
>=20
> --- a/fs/cifs/file.c	2005-02-03 17:58:07.000000000 +0100
> +++ b/fs/cifs/file.c	2005-02-03 18:17:37.000000000 +0100
> @@ -1151,7 +1151,7 @@
>  		current_read_size =3D min_t(const int,read_size - total_read,cifs_sb->=
rsize);
>  		rc =3D -EAGAIN;
>  		smb_read_data =3D NULL;
> -		while(rc =3D=3D -EAGAIN) {
> +		while(1) {
>  			if ((open_file->invalidHandle) && (!open_file->closePend)) {
>  				rc =3D cifs_reopen_file(file->f_dentry->d_inode,
>  					file,TRUE);
> @@ -1164,13 +1164,22 @@
>  				 current_read_size, *poffset,
>  				 &bytes_read, &smb_read_data);
> =20
> +			if (rc =3D=3D -EAGAIN)
> +				continue;
> +			else
> +				break;
> +
>  			pSMBr =3D (struct smb_com_read_rsp *)smb_read_data;
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Perhaps this line and the following lines are never executed with your
patch, am I right?

> -			copy_to_user(current_offset,smb_read_data + 4/* RFC1001 hdr*/
> +			rc =3D copy_to_user(current_offset,smb_read_data + 4/* RFC1001 hdr*/
>  				+ le16_to_cpu(pSMBr->DataOffset), bytes_read);
>  			if(smb_read_data) {
>  				cifs_buf_release(smb_read_data);
>  				smb_read_data =3D NULL;
>  			}
> +			if (rc) {
> +				FreeXid(xid);
> +				return -EFAULT;
> +			}
>  		}
>  		if (rc || (bytes_read =3D=3D 0)) {
>  			if (total_read) {
>=20
>=20

--=20
Marcel Sebek
jabber: sebek@jabber.cz                     ICQ: 279852819
linux user number: 307850                 GPG ID: 5F88735E
GPG FP: 0F01 BAB8 3148 94DB B95D  1FCA 8B63 CA06 5F88 735E


--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCD45Gi2PKBl+Ic14RAgYEAKDav72otMWCu7Z2qyGLzClGjyS5HQCg43Pp
0/grVG2HKHH9QYIl+19XVYg=
=cbxL
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
