Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317308AbSG1UXs>; Sun, 28 Jul 2002 16:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317314AbSG1UXs>; Sun, 28 Jul 2002 16:23:48 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:31638 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S317308AbSG1UXq>; Sun, 28 Jul 2002 16:23:46 -0400
Date: Sun, 28 Jul 2002 23:22:07 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.29 sound/oss/trident.c [2/2] remove cli/sti calls
Message-ID: <20020728202207.GB10499@alhambra.actcom.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,=20

This patch replaces the cli/sti calls in the trident.c driver with
spin_lock_irqsave/spin_unlock_irqrestore.

Patch is against 2.5.29 (latest bitkeeper), compiled and
tested. Please apply.=20

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.480   -> 1.481 =20
#	 sound/oss/trident.c	1.23    -> 1.24  =20
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/28	mulix@alhambra.merseine.nu	1.481
# get rid of cli/sti
# --------------------------------------------
#
diff -Nru a/sound/oss/trident.c b/sound/oss/trident.c
--- a/sound/oss/trident.c	Sun Jul 28 23:09:05 2002
+++ b/sound/oss/trident.c	Sun Jul 28 23:09:05 2002
@@ -768,9 +768,8 @@
  	 *	Keep interrupts off for the configure - we don't want to
  	 *	clash with another cyberpro config event
  	 */
-=20
-	save_flags(flags);
-	cli();
+ =09
+	spin_lock_irqsave(&card->lock, flags);=20
 	portDat =3D cyber_inidx(CYBER_PORT_AUDIO, CYBER_IDX_AUDIO_ENABLE);
 	/* enable, if it was disabled */
 	if( (portDat & CYBER_BMSK_AUENZ) !=3D CYBER_BMSK_AUENZ_ENABLE ) {
@@ -795,7 +794,7 @@
 		cyber_outidx( CYBER_PORT_AUDIO, 0xb3, 0x06 );
 		cyber_outidx( CYBER_PORT_AUDIO, 0xbf, 0x00 );
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&card->lock, flags);=20
 	return ret;
 }
=20
@@ -3502,9 +3501,8 @@
 	unsigned long flags;
 	int i, j;
=20
-	save_flags(flags);=20
-	cli();
-=09
+	spin_lock_irqsave(&card->lock, flags);=20
+
 	ali_registers.global_regs[0x2c] =3D inl(TRID_REG(card,T4D_MISCINT));
 	//ali_registers.global_regs[0x20] =3D inl(TRID_REG(card,T4D_START_A));=09
 	ali_registers.global_regs[0x21] =3D inl(TRID_REG(card,T4D_STOP_A));
@@ -3532,7 +3530,7 @@
 	//Stop all HW channel
 	outl(ALI_STOP_ALL_CHANNELS, TRID_REG(card, T4D_STOP_A));
=20
-	restore_flags(flags);
+	spin_unlock_irqrestore(&card->lock, flags);=20
 }
=20
 static void ali_restore_regs(struct trident_card *card)
@@ -3540,8 +3538,7 @@
 	unsigned long flags;
 	int i, j;
=20
-	save_flags(flags);=20
-	cli();
+	spin_lock_irqsave(&card->lock, flags);=20
 =09
 	for (i =3D 1; i < ALI_MIXER_REGS; i++)
 		ali_ac97_write(card->ac97_codec[0], i*2, ali_registers.mixer_regs[i]);
@@ -3564,6 +3561,8 @@
 	outl(ali_registers.global_regs[0x20], TRID_REG(card,T4D_START_A));
 	//restore IRQ enable bits
 	outl(ali_registers.global_regs[0x2c], TRID_REG(card,T4D_MISCINT));
+
+	spin_unlock_irqrestore(&card->lock, flags);=20
 =09
 	restore_flags(flags);
 }

--=20
http://vipe.technion.ac.il/~mulix/
http://syscalltrack.sf.net/

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9RFJvKRs727/VN8sRAudEAKCxNKY+sEQOpy2OfoGM8Ou75EhmzQCfX3/Z
jagChCqPOthNTZV25iR/xgc=
=kGF9
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
