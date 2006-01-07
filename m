Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752567AbWAGQUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbWAGQUb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 11:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752569AbWAGQUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 11:20:31 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:30889 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1752567AbWAGQUb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 11:20:31 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] 2.6.15: via-rhine + link loss + autoneg off == trouble
Date: Sat, 7 Jan 2006 18:20:15 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Ap+vD+7No9UiV+z"
Message-Id: <200601071820.16092.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_Ap+vD+7No9UiV+z
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

2.6.15 still exhibits the via rhine "no tx" syndrome.

Again, the recipe:
* have via-rhine NIC
* unplug network cable
* reboot box
* force HDX (I do in with ethtool -s if autoneg off duplex half)
* plug cable back
* kernel still thinks that carrier is off despite "ethtool if"
=A0 saying that link is detected.

Why:

=2E..
=A0 =A0 =A0 =A0 if (intr_status & IntrLinkChange)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rhine_check_media(dev, 0);
=2E..

static void rhine_check_media(struct net_device *dev, unsigned int init_med=
ia)
{
=A0 =A0 =A0 =A0 struct rhine_private *rp =3D netdev_priv(dev);
=A0 =A0 =A0 =A0 void __iomem *ioaddr =3D rp->base;

=A0 =A0 =A0 =A0 mii_check_media(&rp->mii_if, debug, init_media);
=2E..

unsigned int mii_check_media (struct mii_if_info *mii,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int ok=
_to_print,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int in=
it_media)
{
=A0 =A0 =A0 =A0 unsigned int old_carrier, new_carrier;
=A0 =A0 =A0 =A0 int advertise, lpa, media, duplex;
=A0 =A0 =A0 =A0 int lpa2 =3D 0;

=A0 =A0 =A0 =A0 /* if forced media, go no further */
=A0 =A0 =A0 =A0 if (mii->force_media) =A0 <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D HERE
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0; /* duplex did not change */

=A0 =A0 =A0 =A0 /* check current and old link status */
=A0 =A0 =A0 =A0 old_carrier =3D netif_carrier_ok(mii->dev) ? 1 : 0;
=A0 =A0 =A0 =A0 new_carrier =3D (unsigned int) mii_link_ok(mii);

=A0 =A0 =A0 =A0 /* if carrier state did not change, this is a "bounce",
=A0 =A0 =A0 =A0 =A0* just exit as everything is already set correctly
=A0 =A0 =A0 =A0 =A0*/
=A0 =A0 =A0 =A0 if ((!init_media) && (old_carrier =3D=3D new_carrier))
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0; /* duplex did not change */

=A0 =A0 =A0 =A0 /* no carrier, nothing much to do */
=A0 =A0 =A0 =A0 if (!new_carrier) {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 netif_carrier_off(mii->dev);
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ok_to_print)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "%s: link =
down\n", mii->dev->name);
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0; /* duplex did not change */
=A0 =A0 =A0 =A0 }

=A0 =A0 =A0 =A0 /*
=A0 =A0 =A0 =A0 =A0* we have carrier, see who's on the other end
=A0 =A0 =A0 =A0 =A0*/
=A0 =A0 =A0 =A0 netif_carrier_on(mii->dev);
=2E..

We can never reach netif_carrier_on if mii->force_media is true!

> On Friday 11 November 2005 13:32, Jeff Garzik wrote:
> > As I've explained many times at this point, force_media means that link=
=20
> > is always on, and mii_link_ok() should not be called.
>=20
> Sorry, seems like I missed your mails...
> =20
> > The only bug, it seems, is that the "if (mii->force_media)" branch=20
> > should make sure to call netif_carrier_on()
>=20
> Should also work.

Please find patch attached.
=2D-
vda

--Boundary-00=_Ap+vD+7No9UiV+z
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="linux-2.6.15.fix_no_tx_syndrome.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux-2.6.15.fix_no_tx_syndrome.diff"

--- linux-2.6.15.org/drivers/net/mii.c	Fri Dec 30 14:17:47 2005
+++ linux-2.6.15/drivers/net/mii.c	Sat Jan  7 18:15:27 2006
@@ -267,8 +267,10 @@ unsigned int mii_check_media (struct mii
 	int lpa2 = 0;
 
 	/* if forced media, go no further */
-	if (mii->force_media)
+	if (mii->force_media) {
+		netif_carrier_on(mii->dev);
 		return 0; /* duplex did not change */
+	}
 
 	/* check current and old link status */
 	old_carrier = netif_carrier_ok(mii->dev) ? 1 : 0;

--Boundary-00=_Ap+vD+7No9UiV+z--
