Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262196AbSJ0A72>; Sat, 26 Oct 2002 20:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262207AbSJ0A72>; Sat, 26 Oct 2002 20:59:28 -0400
Received: from c-24-99-36-145.atl.client2.attbi.com ([24.99.36.145]:40714 "HELO
	babylon.d2dc.net") by vger.kernel.org with SMTP id <S262196AbSJ0A70>;
	Sat, 26 Oct 2002 20:59:26 -0400
Date: Sat, 26 Oct 2002 21:05:38 -0400
From: "Zephaniah E\. Hull" <warp@babylon.d2dc.net>
To: vojtech@suse.cz
Cc: linux-kernel@vger.kernel.org
Subject: [patch] Problem with mousedev.c
Message-ID: <20021027010538.GA1690@babylon.d2dc.net>
Mail-Followup-To: vojtech@suse.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NMuMz9nt05w80d4+
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

To make a long story short, mousedev.c does not properly implement the
EXPS/2 protocol, specificly dealing with the wheel.

The lower 8 bits of the 4th byte are supposed to be 0x1 or 0xf to
indicate movement of the first wheel, and 0x2 or 0xe for the second
wheel.

Attached is a patch to correct this.

This does not get my two wheel mouse working perfectly yet, sadly that
will take a bit of a hack, and I'm not sure where the best place to put
it is yet, but this gets it back to generating correct data.

Zephaniah E. Hull.
(Debian GPM maintainer.)

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

  Yes, Java is so bulletproofed that to a C programmer it feels like
being in a straightjacket, but it's a really comfy and warm
straightjacket, and the world would be a safer place if everyone was
straightjacketed most of the time.        -- Overheard in the SDM.

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hid.diff"
Content-Transfer-Encoding: quoted-printable

diff -ur linux/drivers/input/mousedev.c linux.mine/drivers/input/mousedev.c
--- linux/drivers/input/mousedev.c	2001-09-30 15:26:05.000000000 -0400
+++ linux.mine/drivers/input/mousedev.c	2002-10-26 18:20:19.000000000 -0400
@@ -62,7 +62,7 @@
 	struct fasync_struct *fasync;
 	struct mousedev *mousedev;
 	struct mousedev_list *next;
-	int dx, dy, dz, oldx, oldy;
+	int dw, dx, dy, dz, oldx, oldy;
 	signed char ps2[6];
 	unsigned long buttons;
 	unsigned char ready, buffer, bufsiz;
@@ -117,6 +117,7 @@
 						case REL_X:	list->dx +=3D value; break;
 						case REL_Y:	list->dy -=3D value; break;
 						case REL_WHEEL:	if (list->mode) list->dz -=3D value; break;
+						case REL_HWHEEL: if (list->mode =3D=3D 2) list->dw -=3D value; break;
 					}
 					break;
=20
@@ -260,9 +261,22 @@
 	list->bufsiz =3D off + 3;
=20
 	if (list->mode =3D=3D 2) {
-		list->ps2[off + 3] =3D (list->dz > 7 ? 7 : (list->dz < -7 ? -7 : list->d=
z));
-		list->dz -=3D list->ps2[off + 3];
-		list->ps2[off + 3] =3D (list->ps2[off + 3] & 0x0f) | ((list->buttons & 0=
x18) << 1);
+		if (!list->dz && !list->dw) {
+			list->ps2[off + 3] =3D 0;
+		} else if (list->dw > 0) {
+			list->ps2[off + 3] =3D 0x2;
+			list->dw--;
+		} else if (list->dw < 0) {
+			list->ps2[off + 3] =3D 0xe;
+			list->dw++;
+		} else if (list->dz > 0) {
+			list->ps2[off + 3] =3D 0x1;
+			list->dz--;
+		} else if (list->dz < 0) {
+			list->ps2[off + 3] =3D 0xf;
+			list->dz++;
+		}
+		list->ps2[off + 3] |=3D (list->buttons & 0x18) << 1;
 		list->bufsiz++;
 	}
 =09
@@ -272,7 +286,7 @@
 		list->bufsiz++;
 	}
=20
-	if (!list->dx && !list->dy && (!list->mode || !list->dz)) list->ready =3D=
 0;
+	if (!list->dx && !list->dy && (!list->mode || !list->dz) && ((list->mode =
!=3D 2) || !list->dw)) list->ready =3D 0;
 	list->buffer =3D list->bufsiz;
 }
=20

--XsQoSWH+UP9D9v3l--

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE9uzviRFMAi+ZaeAERAvWWAJ9o0tc1wW184rxhOh8u+2YN+U4ucACgqUlL
5ExJmkVRWU4Eb3CqtbXxen8=
=y1Rj
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
