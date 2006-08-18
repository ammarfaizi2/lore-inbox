Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWHRHSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWHRHSP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 03:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWHRHSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 03:18:14 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:61149 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1750875AbWHRHSN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 03:18:13 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][CHAR] Return better error codes if drivers/char/raw.c module init fails
Date: Fri, 18 Aug 2006 09:18:30 +0200
User-Agent: KMail/1.9.4
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2417681.Cme2DcPV5G";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200608180918.30483.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2417681.Cme2DcPV5G
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Currently this module just returns 1 if anything on module init fails. Store
the error code of the different function calls and return their error on
problems.

I'm not sure if this doesn't need even more cleanup, for example kobj_put()=
=20
is called only in one error case.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

=2D--
commit f6272846a16df0c7acb5c1701c0acdee0b472047
tree 441e29883ce4f449ca269b571e901ab617e0733c
parent 2cb2450818804edcbcb1486a4df0db06e5d49969
author Rolf Eike Beer <eike-kernel@sf-tec.de> Fri, 18 Aug 2006 09:13:03 +02=
00
committer Rolf Eike Beer <beer@siso-eb-i34d.silicon-software.de> Fri, 18 Au=
g 2006 09:13:03 +0200

 drivers/char/raw.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/char/raw.c b/drivers/char/raw.c
index 579868a..5938e6b 100644
=2D-- a/drivers/char/raw.c
+++ b/drivers/char/raw.c
@@ -288,31 +288,35 @@ static struct cdev raw_cdev =3D {
 static int __init raw_init(void)
 {
 	dev_t dev =3D MKDEV(RAW_MAJOR, 0);
+	int ret;
=20
=2D	if (register_chrdev_region(dev, MAX_RAW_MINORS, "raw"))
+	ret =3D register_chrdev_region(dev, MAX_RAW_MINORS, "raw");
+	if (ret)
 		goto error;
=20
 	cdev_init(&raw_cdev, &raw_fops);
=2D	if (cdev_add(&raw_cdev, dev, MAX_RAW_MINORS)) {
+	ret =3D cdev_add(&raw_cdev, dev, MAX_RAW_MINORS);=20
+	if (ret) {
+		printk(KERN_ERR "error register raw device\n");
 		kobject_put(&raw_cdev.kobj);
=2D		unregister_chrdev_region(dev, MAX_RAW_MINORS);
=2D		goto error;
+		goto error_region;
 	}
=20
 	raw_class =3D class_create(THIS_MODULE, "raw");
 	if (IS_ERR(raw_class)) {
 		printk(KERN_ERR "Error creating raw class.\n");
 		cdev_del(&raw_cdev);
=2D		unregister_chrdev_region(dev, MAX_RAW_MINORS);
=2D		goto error;
+		ret =3D PTR_ERR(raw_class);
+		goto error_region;
 	}
 	class_device_create(raw_class, NULL, MKDEV(RAW_MAJOR, 0), NULL, "rawctl");
=20
 	return 0;
=20
+error_region:
+	unregister_chrdev_region(dev, MAX_RAW_MINORS);
 error:
=2D	printk(KERN_ERR "error register raw device\n");
=2D	return 1;
+	return ret;
 }
=20
 static void __exit raw_exit(void)

--nextPart2417681.Cme2DcPV5G
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBE5WnGXKSJPmm5/E4RAg/dAKCCU5UaD0HSFArqHtJeQXE6gLFSmQCgg+QB
gWpCABqPtgqBgcVCXYc2EQs=
=6xl8
-----END PGP SIGNATURE-----

--nextPart2417681.Cme2DcPV5G--
