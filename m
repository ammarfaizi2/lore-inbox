Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbVIRVWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbVIRVWW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 17:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbVIRVWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 17:22:22 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:17134 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S932207AbVIRVWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 17:22:21 -0400
Date: Sun, 18 Sep 2005 23:22:18 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Omnikey CardMan 4000 update
Message-ID: <20050918212217.GA18339@sunbeam.de.gnumonks.org>
References: <20050913155333.GZ29695@sunbeam.de.gnumonks.org> <20050914022314.35eab48d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <20050914022314.35eab48d.akpm@osdl.org>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 14, 2005 at 02:23:14AM -0700, Andrew Morton wrote:
> Harald Welte <laforge@gnumonks.org> wrote:
> >
> > Add new Omnikey Cardman 4000 smartcard reader driver
>=20
> - All the open-coded mdelays() are wrong:
>=20
>   #define	T_10MSEC	msecs_to_jiffies(10)
>   ...
> 		mdelay(T_10MSEC);
>=20
>   mdelay() already takes a jiffies argument.
>=20
> - terminate_monitor() should use del_timer_sync().
>=20

Plaease see the patch below (against -rc1-mm1):

[CM4000] CardMan 4000 Driver Update

* use milliseconds as parameter for mdelay, not jiffies
* clarify that dev->mdelay parameter is in jiffies
* use del_timer_sync() instead of del_timer()

Signed-off-by: Harald Welte <laforge@gnumonks.org>

--- a/drivers/char/pcmcia/cm4000_cs.c	2005-09-18 18:56:29.000000000 +0200
+++ b/drivers/char/pcmcia/cm4000_cs.c	2005-09-18 21:39:31.000000000 +0200
@@ -131,7 +131,7 @@
 	unsigned char cwarn;	/* slow down warning */
 	unsigned char flags0;	/* cardman IO-flags 0 */
 	unsigned char flags1;	/* cardman IO-flags 1 */
-	unsigned int mdelay;	/* variable monitor speeds */
+	unsigned int mdelay;	/* variable monitor speeds, in jiffies */
=20
 	unsigned int baudv;	/* baud value for speed */
 	unsigned char ta1;
@@ -564,7 +564,7 @@
 			DEBUGP(5, dev, "NumRecBytes is valid\n");
 			break;
 		}
-		mdelay(T_10MSEC);
+		mdelay(10);
 	}
 	if (i =3D=3D 100) {
 		DEBUGP(5, dev, "Timeout waiting for NumRecBytes getting "
@@ -580,7 +580,7 @@
 			DEBUGP(2, dev, "NumRecBytes =3D %i\n", num_bytes_read);
 			break;
 		}
-		mdelay(T_10MSEC);
+		mdelay(10);
 	}
=20
 	/* check whether it is a short PTS reply? */
@@ -678,7 +678,7 @@
 		msleep(25);
=20
 	DEBUGP(5, dev, "Delete timer\n");
-	del_timer(&dev->timer);
+	del_timer_sync(&dev->timer);
 #ifdef PCMCIA_DEBUG
 	dev->monitor_running =3D 0;
 #endif
--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDLdqJXaXGVTD0i/8RArSoAJ4tH6RbXDjf7C3b5wv3OT/deP7sFgCfRuJ4
W0TzXTjgsKAGffhrPHjUIyc=
=JLt/
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
