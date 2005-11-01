Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbVKACDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbVKACDc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 21:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbVKACDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 21:03:32 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:6358 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S964932AbVKACDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 21:03:31 -0500
From: Ian Wienand <ianw@gelato.unsw.edu.au>
To: linux-kernel@vger.kernel.org
Date: Tue, 1 Nov 2005 13:03:29 +1100
Subject: [PATCH] Convert dmasound_awacs to dynamic input_dev allocation
Message-ID: <20051101020329.GA7773@cse.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

This patch converts sound/oss/dmasound/dmasound_awacs.c to use dynamic
input_dev allocation, stopping an oops on boot with the latest
kernels.

Thanks,

-i

Signed-off-by: Ian Wienand <ianw@gelato.unsw.edu.au>

---
diff --git a/sound/oss/dmasound/dmasound_awacs.c b/sound/oss/dmasound/dmasound_awacs.c
--- a/sound/oss/dmasound/dmasound_awacs.c
+++ b/sound/oss/dmasound/dmasound_awacs.c
@@ -2805,16 +2805,7 @@ __init setup_beep(void)
 	return 0 ;
 }
 
-static struct input_dev awacs_beep_dev = {
-	.evbit		= { BIT(EV_SND) },
-	.sndbit		= { BIT(SND_BELL) | BIT(SND_TONE) },
-	.event		= awacs_beep_event,
-	.name		= "dmasound beeper",
-	.phys		= "macio/input0", /* what the heck is this?? */
-	.id		= {
-		.bustype	= BUS_HOST,
-	},
-};
+static struct input_dev *awacs_beep_dev;
 
 int __init dmasound_awacs_init(void)
 {
@@ -3140,14 +3131,22 @@ printk("dmasound_pmac: Awacs/Screamer Co
 	 * XXX: we should handle errors here, but that would mean
 	 * rewriting the whole init code.  later..
 	 */
-	input_register_device(&awacs_beep_dev);
+	awacs_beep_dev = input_allocate_device();
+	awacs_beep_dev->name = "dmasound beeper";
+	awacs_beep_dev->phys = "macio/input0";
+	awacs_beep_dev->id.bustype = BUS_HOST;
+	awacs_beep_dev->event = awacs_beep_event;
+	awacs_beep_dev->sndbit[0] = BIT(SND_BELL) | BIT(SND_TONE);
+	awacs_beep_dev->evbit[0] = BIT(EV_SND);
+
+	input_register_device(awacs_beep_dev);
 
 	return dmasound_init();
 }
 
 static void __exit dmasound_awacs_cleanup(void)
 {
-	input_unregister_device(&awacs_beep_dev);
+	input_unregister_device(awacs_beep_dev);
 
 	switch (awacs_revision) {
 		case AWACS_TUMBLER:

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDZszxWDlSU/gp6ecRAqcjAKCdivbHyU5x4ZoRji29Lrr179wELACghpFE
3XabLt7233Lt+MsJD+92p0w=
=86FA
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
