Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267836AbRG0INN>; Fri, 27 Jul 2001 04:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267844AbRG0IMy>; Fri, 27 Jul 2001 04:12:54 -0400
Received: from schiele.swm.uni-mannheim.de ([134.155.20.124]:11651 "EHLO
	schiele.swm.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S267836AbRG0IMr>; Fri, 27 Jul 2001 04:12:47 -0400
Date: Fri, 27 Jul 2001 10:12:41 +0200
From: Robert Schiele <rschiele@uni-mannheim.de>
To: Steven Cole <elenstev@mesatop.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: 2.4.8-pre1 build error in drivers/parport/parport_pc.c
Message-ID: <20010727101241.A15014@schiele.swm.uni-mannheim.de>
In-Reply-To: <01072619531103.06728@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <01072619531103.06728@localhost.localdomain>; from elenstev@mesatop.com on Thu, Jul 26, 2001 at 07:53:11PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 26, 2001 at 07:53:11PM -0600, Steven Cole wrote:
> I got the following errors building 2.4.8-pre1.
>=20
> parport_pc.c:257: redefinition of `parport_pc_write_data'
> /usr/src/linux-2.4.8-pre1/include/linux/parport_pc.h:45: `parport_pc_writ=
e_data' previously defined here
> parport_pc.c:262: redefinition of `parport_pc_read_data'
> /usr/src/linux-2.4.8-pre1/include/linux/parport_pc.h:53: `parport_pc_read=
_data' previously defined here
> ...
> make[3]: *** [parport_pc.o] Error 1
> make[3]: Leaving directory `/usr/src/linux-2.4.8-pre1/drivers/parport'

Hmm, these functions are multiply defined, namely in the c source and
in it's header file. I see no reason why someone should do this. The
problem was hidden in older kernel releases by the fact that these
functions were declared "extern __inline__" which is absolutely
nonsense in my opinion. So the solution should be to just remove these
inline functions from the c source file, which can be done with the
following simple and stupid patch.

This should be the correct solution, or did I miss the vital point?

Robert

diff -u --recursive --new-file v2.4.7/linux/drivers/parport/parport_pc.c li=
nux/drivers/parport/parport_pc.c
--- v2.4.7/linux/drivers/parport/parport_pc.c	Wed Jul 11 01:07:46 2001
+++ linux/drivers/parport/parport_pc.c	Fri Jul 27 09:24:50 2001
@@ -253,94 +253,6 @@
 	parport_generic_irq(irq, (struct parport *) dev_id, regs);
 }
=20
-void parport_pc_write_data(struct parport *p, unsigned char d)
-{
-	outb (d, DATA (p));
-}
-
-unsigned char parport_pc_read_data(struct parport *p)
-{
-	return inb (DATA (p));
-}
-
-void parport_pc_write_control(struct parport *p, unsigned char d)
-{
-	const unsigned char wm =3D (PARPORT_CONTROL_STROBE |
-				  PARPORT_CONTROL_AUTOFD |
-				  PARPORT_CONTROL_INIT |
-				  PARPORT_CONTROL_SELECT);
-
-	/* Take this out when drivers have adapted to the newer interface. */
-	if (d & 0x20) {
-		printk (KERN_DEBUG "%s (%s): use data_reverse for this!\n",
-			p->name, p->cad->name);
-		parport_pc_data_reverse (p);
-	}
-
-	__parport_pc_frob_control (p, wm, d & wm);
-}
-
-unsigned char parport_pc_read_control(struct parport *p)
-{
-	const unsigned char wm =3D (PARPORT_CONTROL_STROBE |
-				  PARPORT_CONTROL_AUTOFD |
-				  PARPORT_CONTROL_INIT |
-				  PARPORT_CONTROL_SELECT);
-	const struct parport_pc_private *priv =3D p->physport->private_data;
-	return priv->ctr & wm; /* Use soft copy */
-}
-
-unsigned char parport_pc_frob_control (struct parport *p, unsigned char ma=
sk,
-				       unsigned char val)
-{
-	const unsigned char wm =3D (PARPORT_CONTROL_STROBE |
-				  PARPORT_CONTROL_AUTOFD |
-				  PARPORT_CONTROL_INIT |
-				  PARPORT_CONTROL_SELECT);
-
-	/* Take this out when drivers have adapted to the newer interface. */
-	if (mask & 0x20) {
-		printk (KERN_DEBUG "%s (%s): use data_%s for this!\n",
-			p->name, p->cad->name,
-			(val & 0x20) ? "reverse" : "forward");
-		if (val & 0x20)
-			parport_pc_data_reverse (p);
-		else
-			parport_pc_data_forward (p);
-	}
-
-	/* Restrict mask and val to control lines. */
-	mask &=3D wm;
-	val &=3D wm;
-
-	return __parport_pc_frob_control (p, mask, val);
-}
-
-unsigned char parport_pc_read_status(struct parport *p)
-{
-	return inb (STATUS (p));
-}
-
-void parport_pc_disable_irq(struct parport *p)
-{
-	__parport_pc_frob_control (p, 0x10, 0);
-}
-
-void parport_pc_enable_irq(struct parport *p)
-{
-	__parport_pc_frob_control (p, 0x10, 0x10);
-}
-
-void parport_pc_data_forward (struct parport *p)
-{
-	__parport_pc_frob_control (p, 0x20, 0);
-}
-
-void parport_pc_data_reverse (struct parport *p)
-{
-	__parport_pc_frob_control (p, 0x20, 0x20);
-}
-
 void parport_pc_init_state(struct pardevice *dev, struct parport_state *s)
 {
 	s->u.pc.ctr =3D 0xc | (dev->irq_func ? 0x10 : 0x0);

--=20
Robert Schiele			mailto:rschiele@uni-mannheim.de
Tel./Fax: +49-621-10059		http://webrum.uni-mannheim.de/math/rschiele/

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iQEVAwUBO2EieMQAnns5HcHpAQEauQgAnt5SQ7xfdoKb10EUnX0ycNKz8JOLBm6K
nYG/pMimAnHVgWhQ48593aK13CGjCR/EEjty3btpzKoWRADCFuLysmrkIAozlRta
GFj3w6EG2Qz/UJff0DquI0E76z4nBEvs8SkbofaJfokwKqw9Dercxib69REcHjwx
qdB9I5aoCRfIjnaYukbDTL1eE4HcXPX7vN1qxz3bvWGp1Rq9NqCtShDvbmRqwIPA
F2aj5AdGiBLcmfcySiMtQ8VjXjkhJ5WIktaZoUg0J1llr1fN3BnjNBt1uQhwWX02
vY81FMfE+G4E67YFA7HQ8oL2RHNyTSX7UhKXyfkdPs4vh0qb5rdGAw==
=wS0n
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
