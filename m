Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276329AbRJUQJW>; Sun, 21 Oct 2001 12:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276330AbRJUQJN>; Sun, 21 Oct 2001 12:09:13 -0400
Received: from warande3094.warande.uu.nl ([131.211.123.94]:62573 "EHLO
	xar.sliepen.oi") by vger.kernel.org with ESMTP id <S276329AbRJUQJC>;
	Sun, 21 Oct 2001 12:09:02 -0400
Date: Sun, 21 Oct 2001 18:09:29 +0200
From: Guus Sliepen <guus@warande3094.warande.uu.nl>
To: linux-kernel@vger.kernel.org
Cc: Maxim Krasnyansky <max_mk@yahoo.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] [RFC] dev_alloc_name() requirement of %d and the 100 names limit
Message-ID: <20011021180929.A29733@sliepen.warande.net>
Mail-Followup-To: Guus Sliepen <guus@sliepen.warande.net>,
	linux-kernel@vger.kernel.org, Maxim Krasnyansky <max_mk@yahoo.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-oi: oi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xXmbgvnjoT4axfJE
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Somewhere between 2.4.10 and 2.4.12 the dev_alloc_name() function was
changed to explicitly check for a %d in the name of a to-be allocated
network interface. The idea is that this function returns a unique name
or bails out.

The recent change broke at least tinc (a userspace VPN daemon), because
it tries to alloc a tun/tap device and gives it a name, but does not require
that the %d must be present (the documentation of the tun/tap driver nor
the example code in Documentation/ make any mention of that). I don't
see why the %d would have to be mandatory, so the attached patch allows
device names without a %d to work as well.

A comment in that function says that if anyone would need more than 100
devices the algorithm should be fixed. The patch does this, allowing a
virtually unlimitted amount of names, in O(log(n)) time, n being the
number of already allocated names.

I stresstested the patched, I was able to allocate 1901 network devices
using "test%d" as the name. After that my system claimed it didn't have
any file descriptors left.

--=20
Met vriendelijke groet / with kind regards,
  Guus Sliepen <guus@sliepen.warande.net>

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch_dev_alloc_name
Content-Transfer-Encoding: quoted-printable

--- dev.c.old	Sun Oct 21 15:39:44 2001
+++ dev.c	Sun Oct 21 17:45:11 2001
@@ -550,30 +550,65 @@
=20
 int dev_alloc_name(struct net_device *dev, const char *name)
 {
-	int i;
-	char buf[32];
+	int i, j, k;
+	char buf[IFNAMSIZ];
 	char *p;
=20
 	/*
 	 * Verify the string as this thing may have come from
-	 * the user.  There must be one "%d" and no other "%"
+	 * the user.  There may only be one "%d" and no other "%"
 	 * characters.
 	 */
 	p =3D strchr(name, '%');
-	if (!p || p[1] !=3D 'd' || strchr(p+2, '%'))
+	if (!p)
+	{
+		snprintf(buf,sizeof(buf),name);
+		if (__dev_get_by_name(buf) =3D=3D NULL) {
+			strcpy(dev->name, buf);
+			return 0;
+		}
+		else
+			return -ENFILE;
+	}
+
+	if (p[1] !=3D 'd' || strchr(p+2, '%'))
 		return -EINVAL;
=20
 	/*
-	 * If you need over 100 please also fix the algorithm...
+	 * New algorithm that works in O(log(n)) worst case time, where
+	 * n is the number of already allocated devices with the
+	 * same base name.
+	 *
+	 * The algorithm works by trying a device number j between i and k,
+	 * and changes i and k depending on whether it was allocated or not.
+	 *
+	 * i is the lower bound of already allocated devices,
+	 * k is the upper bound of already allocated devices,
+	 * k =3D 0 means k is infinite.
 	 */
-	for (i =3D 0; i < 100; i++) {
-		snprintf(buf,sizeof(buf),name,i);
+	i =3D j =3D k =3D 0;
+	for (;;)
+	{
+		snprintf(buf,sizeof(buf),name,j);
 		if (__dev_get_by_name(buf) =3D=3D NULL) {
-			strcpy(dev->name, buf);
-			return i;
+			if (j =3D=3D i || j =3D=3D i + 1)
+			{
+				strcpy(dev->name, buf);
+				return j;
+			}
+			else
+				k =3D j;
 		}
+		else
+			i =3D j;
+
+		if (k)
+			j =3D (i + k) / 2;
+		else
+			j *=3D 2;
+		if (j =3D=3D i)
+			j++;
 	}
-	return -ENFILE;	/* Over 100 of the things .. bail out! */
 }
=20
 /**

--cWoXeonUoKmBZSoM--

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE70vM4AxLow12M2nsRAnaFAJ9fJO/0C0hlT5f1jnzg9Cqe7w8aJgCdGK2r
ep+HOwDyjHI/CRzybNjGiJs=
=RAAh
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--
