Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261715AbTCZOhj>; Wed, 26 Mar 2003 09:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261732AbTCZOhj>; Wed, 26 Mar 2003 09:37:39 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:3289 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S261715AbTCZOhg>; Wed, 26 Mar 2003 09:37:36 -0500
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Thomas Molina <tmolina@cox.net>, jsimmons@infradead.org
Subject: Re: fbcon sleeping function call from illegal context
Date: Wed, 26 Mar 2003 15:48:25 +0100
User-Agent: KMail/1.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0303260821590.944-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0303260821590.944-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_N3bg+J5+4ueKIn3";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200303261548.45370.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_N3bg+J5+4ueKIn3
Content-Type: multipart/mixed;
  boundary="Boundary-01=_52bg+V2uX9rqqEU"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

--Boundary-01=_52bg+V2uX9rqqEU
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: body text
Content-Disposition: inline

Am Mittwoch, 26. M=E4rz 2003 15:31 schrieb Thomas Molina:
> One hunk applied with fuzz and two hunks were rejected when applied both=
=20
> to 2.5.66 stock and bk-latest.  I fixed up the rejects by hand and=20
> compiled a new kernel against bk-latest.  I am running with that version=
=20
> now, which doesn't emit the string of messages I reported originally.  Th=
e=20
> only minor anomaly I note is the cursor is a three-segment underscore=20
> rather than a solid underscore. =20

I had the same problems patching my 2.5.66 and so applied the patch by hand=
,=20
too. The problem with the wrong shaped cursor was here, too, I solved it wi=
th=20
the attached patch. The 'data' area was not initialized correctly. The patc=
h=20
also uses 'memset()' to generate the 'mask' instead of writing the bytes by=
=20
hand...

I hope this helps you,too!

   Thomas Schlichter
--Boundary-01=_52bg+V2uX9rqqEU
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="fbcon.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="fbcon.patch"

=2D-- linux-2.5.66/drivers/video/console/fbcon.c.patched	Wed Mar 26 15:16:4=
1 2003
+++ linux-2.5.66/drivers/video/console/fbcon.c	Wed Mar 26 15:27:15 2003
@@ -1001,7 +1001,7 @@
 	int bgshift =3D (vc->vc_hi_font_mask) ? 13 : 12;
 	int fgshift =3D (vc->vc_hi_font_mask) ? 9 : 8;
 	int height, width, size, c;
=2D	int w, cur_height, i =3D 0;
+	int w, cur_height;
 	char *font, *mask, *data;
 =09
 	if (cursor->set & FB_CUR_SETCUR)
@@ -1021,7 +1021,8 @@
 		cursor->set |=3D FB_CUR_SETSIZE;
 	}=09
=20
=2D	size =3D ((width + 7) >> 3) * height;
+	w =3D (width + 7) >> 3;
+	size =3D w * height;
=20
 	data =3D kmalloc(size, GFP_KERNEL);
=20
@@ -1034,10 +1035,7 @@
 		return;
 	}
=20
=2D	if (cursor->set & FB_CUR_SETSIZE) {
=2D		memset(data, 0xff, size);
=2D		cursor->set |=3D FB_CUR_SETSHAPE;
=2D	}
+	memset(data, 0xff, size);
=20
 	c =3D scr_readw((u16 *) vc->vc_pos);
=20
@@ -1053,8 +1051,6 @@
 		cursor->set |=3D FB_CUR_SETDEST;
 	}
=20
=2D	w =3D (width + 7) >> 3;
=2D
 	switch (vc->vc_cursor_type & 0x0f) {
 		case CUR_NONE:
 			cur_height =3D 0;
@@ -1078,13 +1074,15 @@
 	}
=20
 	size =3D (height - cur_height) * w;
=2D	while (size--)
=2D		mask[i++] =3D 0;
=2D	size =3D cur_height * w;
=2D	while (size--)
=2D		mask[i++] =3D 0xff;
=20
=2D	if (!info->cursor.mask ||  (memcmp(mask, info->cursor.mask, w*height)))
+	if (size)
+		memset(mask, 0x00, size);
+
+	if (cur_height)
+		memset(mask + size, 0xff, cur_height * w);
+
+	if ((cursor->set & FB_CUR_SETSIZE) || !info->cursor.mask ||
+	    memcmp(mask, info->cursor.mask, w*height))
 		cursor->set |=3D FB_CUR_SETSHAPE;
=20
 	cursor->image.width =3D width;

--Boundary-01=_52bg+V2uX9rqqEU--

--Boundary-03=_N3bg+J5+4ueKIn3
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+gb3NYAiN+WRIZzQRAnRVAKCvyOMOCrUwOqvLtBwOxDTKedvOaQCfQ6rm
4aTHcOqrJjXMbKbdtc6caQU=
=3qsr
-----END PGP SIGNATURE-----

--Boundary-03=_N3bg+J5+4ueKIn3--

