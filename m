Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbULDVRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbULDVRZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 16:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbULDVRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 16:17:25 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:19657 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S261161AbULDVRP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 16:17:15 -0500
Subject: Re: Linux 2.6.10-rc3
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Alex Romosan <romosan@sycorax.lbl.gov>
Cc: Ari Pollak <aripollak@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <87eki66jx8.fsf@sycorax.lbl.gov>
References: <Pine.LNX.4.58.0412031611460.22796@ppc970.osdl.org>
	 <pan.2004.12.04.09.06.09.707940@nn7.de> <87oeha6lj1.fsf@sycorax.lbl.gov>
	 <cosrt1$j67$1@sea.gmane.org>  <87eki66jx8.fsf@sycorax.lbl.gov>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-fWNkZhe94iqcVKh7jGJN"
Message-Id: <1102195032.1560.58.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 04 Dec 2004 22:17:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fWNkZhe94iqcVKh7jGJN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-12-04 at 18:40, Alex Romosan wrote:
> Ari Pollak <aripollak@gmail.com> writes:
>=20
> > Alex Romosan wrote:
> >> well, it's still more than my thinkpad which doesn't want to wake up
> >> from sleep anymore.
> >
> > My thinkpad will resume fine if I remove the intel8x0 and intel8x0m
> > ALSA modules before going into suspend - works with both APM and ACPI,
> > though I don't really use ACPI suspend because the battery drains like
> > crazy.
>=20
> i saw there were some changes to alsa cvs having to do with the new
> pci device handling. i'll reconfigure the kernel with alsa as modules
> and try alsa cvs to see if that makes any difference. thanks.

This has been discussed in an earlier thread, I was hoping the ALSA
people would submit the patch but that hasn't happened.
I'll submit it in a separate mail.

Try the patch below, it should fix the problem.

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

--=-fWNkZhe94iqcVKh7jGJN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBsilXWm2vlfa207ERAuuUAJ9Tg5EeznLXQPHiLu6bYO/bWC+f1gCfYSrE
F0m219G+UEL/cvHgLPhCigk=
=tLD8
-----END PGP SIGNATURE-----

--=-fWNkZhe94iqcVKh7jGJN--
