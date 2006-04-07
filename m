Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbWDGNgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbWDGNgl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 09:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbWDGNgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 09:36:41 -0400
Received: from mivlgu.ru ([81.18.140.87]:62115 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S964787AbWDGNgk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 09:36:40 -0400
Date: Fri, 7 Apr 2006 17:36:28 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: stable@kernel.org
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>,
       David Liontooth <liontooth@cogweb.net>, linux-kernel@vger.kernel.org,
       video4linux-list@redhat.com, Brian Marete <bgmarete@gmail.com>,
       Ricardo Cerqueira <v4l@cerqueira.org>
Subject: Re: [2.6.16] saa7134 disable_ir oops
Message-ID: <20060407133628.GG10864@master.mivlgu.local>
References: <44246C0E.3080306@cogweb.net> <20060406202016.05db1eca.vsu@altlinux.ru> <1144415771.28307.13.camel@praia>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RDS4xtyBfx+7DiaI"
Content-Disposition: inline
In-Reply-To: <1144415771.28307.13.camel@praia>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RDS4xtyBfx+7DiaI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 07, 2006 at 10:16:10AM -0300, Mauro Carvalho Chehab wrote:
> Em Qui, 2006-04-06 ?s 20:20 +0400, Sergey Vlasov escreveu:
> > On Fri, 24 Mar 2006 14:00:46 -0800 David Liontooth wrote:
>=20
> > Does the following patch fix things?
> >=20
> Applied at v4l-dvb tree. Thanks.

IMHO this patch should also be added to 2.6.16-stable - it fixes oops in
configurations which worked fine with older kernels.

-----------------------------------------------------------------------

saa7134: Fix oops with disable_ir=3D1

When disable_ir=3D1 parameter is used, or when saa7134_input_init1()
fails for any other reason, dev->remote will remain NULL, and the
driver will oops in saa7134_hwinit2().  Therefore dev->remote must be
checked before dereferencing.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>

--- linux-2.6.16.orig/drivers/media/video/saa7134/saa7134-core.c	2006-03-20=
 08:53:29 +0300
+++ linux-2.6.16/drivers/media/video/saa7134/saa7134-core.c	2006-04-06 20:0=
0:56 +0400
@@ -543,6 +543,8 @@ static irqreturn_t saa7134_irq(int irq,=20
 		if (report & SAA7134_IRQ_REPORT_GPIO16) {
 			switch (dev->has_remote) {
 				case SAA7134_REMOTE_GPIO:
+					if (!dev->remote)
+						break;
 					if  (dev->remote->mask_keydown & 0x10000) {
 						saa7134_input_irq(dev);
 					}
@@ -559,6 +561,8 @@ static irqreturn_t saa7134_irq(int irq,=20
 		if (report & SAA7134_IRQ_REPORT_GPIO18) {
 			switch (dev->has_remote) {
 				case SAA7134_REMOTE_GPIO:
+					if (!dev->remote)
+						break;
 					if ((dev->remote->mask_keydown & 0x40000) ||
 					    (dev->remote->mask_keyup & 0x40000)) {
 						saa7134_input_irq(dev);
@@ -671,7 +675,7 @@ static int saa7134_hwinit2(struct saa713
 		SAA7134_IRQ2_INTE_PE      |
 		SAA7134_IRQ2_INTE_AR;
=20
-	if (dev->has_remote =3D=3D SAA7134_REMOTE_GPIO) {
+	if (dev->has_remote =3D=3D SAA7134_REMOTE_GPIO && dev->remote) {
 		if (dev->remote->mask_keydown & 0x10000)
 			irq2_mask |=3D SAA7134_IRQ2_INTE_GPIO16;
 		else if (dev->remote->mask_keydown & 0x40000)


--RDS4xtyBfx+7DiaI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFENmrcW82GfkQfsqIRAgcDAJ0QEpPzu6A2iE6QRRCMaPJafz3eRACeNDHE
5JugTCEYt7pws7Uwgm+txcc=
=CjyE
-----END PGP SIGNATURE-----

--RDS4xtyBfx+7DiaI--
