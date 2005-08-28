Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbVH1BbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbVH1BbH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 21:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbVH1BbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 21:31:06 -0400
Received: from ns1.osuosl.org ([140.211.166.130]:44519 "EHLO ns1.osuosl.org")
	by vger.kernel.org with ESMTP id S1751018AbVH1BbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 21:31:05 -0400
Message-ID: <431113D7.5040304@engr.orst.edu>
Date: Sat, 27 Aug 2005 18:31:03 -0700
From: Michael Marineau <marineam@engr.orst.edu>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050729)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, benh@kernel.crashing.org
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Radeon acpi vgapost
References: <43111298.80507@engr.orst.edu>
In-Reply-To: <43111298.80507@engr.orst.edu>
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig703B096C743505F1673C99B6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig703B096C743505F1673C99B6
Content-Type: multipart/mixed;
 boundary="------------020705010009020103070809"

This is a multi-part message in MIME format.
--------------020705010009020103070809
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Ben, do I have your blessing on this one?

Adds the video post method of resume for x86 to radeonfb to allow for
resuming after S3 acpi suspend.
-- 
Michael Marineau
marineam@engr.orst.edu
Oregon State University

--------------020705010009020103070809
Content-Type: text/x-patch;
 name="radeonfb-vgapost.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="radeonfb-vgapost.patch"

Index: linux-2.6.13-rc7/drivers/video/aty/radeon_pm.c
===================================================================
--- linux-2.6.13-rc7.orig/drivers/video/aty/radeon_pm.c
+++ linux-2.6.13-rc7/drivers/video/aty/radeon_pm.c
@@ -2403,6 +2403,15 @@ static void radeon_reinitialize_QW(struc
 
 #endif /* CONFIG_PPC_OF */
 
+#if defined(CONFIG_ACPI) && defined(CONFIG_X86)
+extern void acpi_vgapost (unsigned long slot);
+
+static void radeon_reinitialize_vgapost(struct radeonfb_info *rinfo)
+{
+	acpi_vgapost (rinfo->pdev->devfn);
+}
+#endif
+
 static void radeon_set_suspend(struct radeonfb_info *rinfo, int suspend)
 {
 	u16 pwr_cmd;
@@ -2657,6 +2666,8 @@ int radeonfb_pci_resume(struct pci_dev *
 		 */
 		else if (rinfo->pm_mode & radeon_pm_d2)
 			radeon_set_suspend(rinfo, 0);
+		if (rinfo->pm_mode & radeon_pm_post && rinfo->reinit_func != NULL)
+			rinfo->reinit_func(rinfo);
 
 		rinfo->asleep = 0;
 	} else
@@ -2777,6 +2788,13 @@ void radeonfb_pm_init(struct radeonfb_in
 #endif
 	}
 #endif /* defined(CONFIG_PM) && defined(CONFIG_PPC_OF) */
+
+#if defined(CONFIG_ACPI) && defined(CONFIG_X86)
+	if (rinfo->is_mobility && rinfo->pm_reg) {
+		rinfo->reinit_func = radeon_reinitialize_vgapost;
+		rinfo->pm_mode |= radeon_pm_post;
+	}
+#endif
 }
 
 void radeonfb_pm_exit(struct radeonfb_info *rinfo)
Index: linux-2.6.13-rc7/drivers/video/aty/radeonfb.h
===================================================================
--- linux-2.6.13-rc7.orig/drivers/video/aty/radeonfb.h
+++ linux-2.6.13-rc7/drivers/video/aty/radeonfb.h
@@ -271,6 +271,7 @@ enum radeon_pm_mode {
 	radeon_pm_none	= 0,		/* Nothing supported */
 	radeon_pm_d2	= 0x00000001,	/* Can do D2 state */
 	radeon_pm_off	= 0x00000002,	/* Can resume from D3 cold */
+	radeon_pm_post	= 0x00000004,	/* Resume with vgapost */
 };
 
 struct radeonfb_info {

--------------020705010009020103070809--

--------------enig703B096C743505F1673C99B6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDERPYiP+LossGzjARAifnAKCJDKcUgQmpF+jKf02IddwLjnr2oACdFbkH
i3q66kdPcSQHlo36ZebHmfo=
=mx9k
-----END PGP SIGNATURE-----

--------------enig703B096C743505F1673C99B6--
