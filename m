Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbVIRVXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbVIRVXY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 17:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbVIRVXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 17:23:24 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:10624 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S932209AbVIRVXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 17:23:23 -0400
Date: Sun, 18 Sep 2005 23:23:21 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] New Omnikey Cardman 4040 driver
Message-ID: <20050918212321.GB18339@sunbeam.de.gnumonks.org>
References: <20050913155116.GY29695@sunbeam.de.gnumonks.org> <29495f1d050913090219cc44fa@mail.gmail.com> <20050913163951.GA29695@sunbeam.de.gnumonks.org> <20050914021943.681d8f05.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Content-Disposition: inline
In-Reply-To: <20050914021943.681d8f05.akpm@osdl.org>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 14, 2005 at 02:19:43AM -0700, Andrew Morton wrote:
> Harald Welte <laforge@gnumonks.org> wrote:
> >
> > Add new Omnikey Cardman 4040 smartcard reader driver
> >
>=20
> I see a timer, but I see no del_timer_sync() anywhere.  Cannot the timer =
be
> left pending after device shutdown or rmmod?

Please see the patch below (against -rc1-mm1):

[CM4040] CardMan 4040 Driver Update

* Don't initialize variable in bss
* Introduce and use function to stop polling timer
* Remove unneeded dev_info variable

Signed-off-by: Harald Welte <laforge@gnumonks.org>

--- a/drivers/char/pcmcia/cm4040_cs.c	2005-09-18 18:56:29.000000000 +0200
+++ b/drivers/char/pcmcia/cm4040_cs.c	2005-09-18 20:17:14.000000000 +0200
@@ -85,8 +85,7 @@
 	struct timer_list 	poll_timer;
 };
=20
-static dev_info_t dev_info =3D MODULE_NAME;
-static dev_link_t *dev_table[CM_MAX_DEV] =3D { NULL, };
+static dev_link_t *dev_table[CM_MAX_DEV];
=20
 #ifndef PCMCIA_DEBUG
 #define	xoutb	outb
@@ -138,6 +137,11 @@
 	mod_timer(&dev->poll_timer, jiffies + POLL_PERIOD);
 }
=20
+static void cm4040_stop_poll(struct reader_dev *dev)
+{
+	del_timer_sync(&dev->poll_timer);
+}
+
 static int wait_for_bulk_out_ready(struct reader_dev *dev)
 {
 	int i, rc;
@@ -485,6 +489,8 @@
 	if (link =3D=3D NULL)
 		return -ENODEV;
=20
+	cm4040_stop_poll(dev);
+
 	link->open =3D 0;
 	wake_up(&dev->devq);
=20
@@ -627,7 +633,7 @@
=20
 	link->state |=3D DEV_SUSPEND;
 	if (link->state & DEV_CONFIG)
-		pcmcia_release_configuration(link->handle);
+		pcmcia_release_configuration(p_dev);
=20
 	return 0;
 }
@@ -643,7 +649,6 @@
 	return 0;
 }
=20
-
 static void reader_release(dev_link_t *link)
 {
 	cm4040_reader_release(link->priv);
@@ -713,6 +718,8 @@
 	if (link->state & DEV_CONFIG)
 		reader_release(link);
=20
+	cm4040_stop_poll(dev);
+
 	dev_table[devno] =3D NULL;
 	kfree(dev);
=20
--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDLdrJXaXGVTD0i/8RAnJIAKCejbcV3wsLb4wU7nUkMz0phjfRjgCeNovF
p2q7zqCfH7bL5iqcJqeD/to=
=5hyf
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
