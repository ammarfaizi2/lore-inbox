Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbULDVXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbULDVXY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 16:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbULDVXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 16:23:24 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:39881 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S261164AbULDVXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 16:23:13 -0500
Subject: [PATCH] Fix ALSA resume
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Yb+sBuFF9+nL/pfZTqCZ"
Message-Id: <1102195391.1560.65.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 04 Dec 2004 22:23:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Yb+sBuFF9+nL/pfZTqCZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Some time ago, a patch was merged that removed pci_save_state() and
pci_restore_state() from various ALSA drivers. That patch also added
pci_restore_state() to sound/core/init.c but didn't add pci_save_state()
anywhere. This is needed since the core pci handling doesn't do this for
us anymore.

My laptop doesn't resume (gets what I assume is an ACPI timeout and
hangs solid) without this small obvious patch.

Signed-off-by: Martin Josefsson <gandalf@wlug.westbo.se>
Fixed-by: Takashi Iwai <tiwai@suse.de>

--- linux/sound/core/init.c	8 Nov 2004 11:37:08 -0000	1.48
+++ linux/sound/core/init.c	12 Nov 2004 13:56:32 -0000
@@ -782,12 +782,15 @@<br>
 int snd_card_pci_suspend(struct pci_dev *dev, u32 state)
 {
 	snd_card_t *card =3D pci_get_drvdata(dev);
+	int err;
 	if (! card || ! card->pm_suspend)
 		return 0;
 	if (card->power_state =3D=3D SNDRV_CTL_POWER_D3hot)
 		return 0;
 	/* FIXME: correct state value? */
-	return card->pm_suspend(card, 0);
+	err =3D card->pm_suspend(card, 0);
+	pci_save_state(dev);
+	return err;
 }

 int snd_card_pci_resume(struct pci_dev *dev)


--=20
/Martin

--=-Yb+sBuFF9+nL/pfZTqCZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBsiq/Wm2vlfa207ERAmu6AKCnZNYz8AVjtzJqwf3dewqGwjaXoACeM7Nq
RScRzj85nBFkkMgizGgPeAk=
=mSD4
-----END PGP SIGNATURE-----

--=-Yb+sBuFF9+nL/pfZTqCZ--
