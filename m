Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263215AbUDZTAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263215AbUDZTAX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 15:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263324AbUDZTAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 15:00:23 -0400
Received: from linux.us.dell.com ([143.166.224.162]:30816 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S263215AbUDZS77
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 14:59:59 -0400
Date: Mon, 26 Apr 2004 13:57:58 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: akpm@osdl.org, Matt Tolentino <metolent@snoqualmie.dp.intel.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/3] efivars driver update and move
Message-ID: <20040426185758.GA32755@lists.us.dell.com>
References: <200404221732.i3MHWJcc023373@snoqualmie.dp.intel.com> <20040423222945.GA9594@lists.us.dell.com> <20040424034109.GA15589@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <20040424034109.GA15589@lists.us.dell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Patch below fixes three small bugs in efivars.c as posted by Matt
Tolentino last week and included in the latest -mm.  Aside from this
small patch, I'm quite pleased with Matt T's work, thanks!=20

* dummy() used for reading write-only sysfs files should return
  -ENODEV to indicate failure, not 0.
* efivar_create() should return the number of bytes written on
  success, not zero. =20
* efivar_delete() should return the number of bytes written on
  success, not zero.

Compiled, tested with efibootmgr-0.5.0-test3.  The anomolies I noted
late Friday night are resolved by this kernel patch - efibootmgr was
actually testing the values returned by writes.

--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

--- linux-2.6.5.orig/drivers/firmware/efivars.c	2004-04-24 06:58:08.0000000=
00 -0400
+++ linux-2.6.5/drivers/firmware/efivars.c	2004-04-27 03:48:33.037318467 -0=
400
@@ -1,7 +1,7 @@
 /*
  * EFI Variables - efivars.c
  *
- * Copyright (C) 2001,2003 Dell <Matt_Domsch@dell.com>
+ * Copyright (C) 2001,2003,2004 Dell <Matt_Domsch@dell.com>
  * Copyright (C) 2004 Intel Corporation <matthew.e.tolentino@intel.com>
  *
  * This code takes all variables accessible from EFI runtime and
@@ -23,6 +23,9 @@
  *
  * Changelog:
  *
+ *  26 Apr 2004 - Matt Domsch <Matt_Domsch@dell.com>
+ *   minor bug fixes
+ *
  *  21 Apr 2004 - Matt Tolentino <matthew.e.tolentino@intel.com)
  *   converted driver to export variable information via sysfs
  *   and moved to drivers/firmware directory
@@ -78,7 +81,7 @@ MODULE_AUTHOR("Matt Domsch <Matt_Domsch@
 MODULE_DESCRIPTION("sysfs interface to EFI Variables");
 MODULE_LICENSE("GPL");
=20
-#define EFIVARS_VERSION "0.07 2003-Aug-29"
+#define EFIVARS_VERSION "0.07 2004-Apr-26"
=20
 /*
  * efivars_lock protects two things:
@@ -408,7 +411,7 @@ static struct kobj_type ktype_efivar =3D {
 static ssize_t
 dummy(struct subsystem *sub, char *buf)
 {
-	return 0;
+	return -ENODEV;
 }
=20
 static inline void
@@ -472,7 +475,10 @@ efivar_create(struct subsystem *sub, con
 	/* Create the entry in sysfs.  Locking is not required here */
 	status =3D efivar_create_sysfs_entry(utf8_strsize(new_var->VariableName,
 			1024), new_var->VariableName, &new_var->VendorGuid);
-	return status;
+	if (status) {
+		printk(KERN_WARNING "efivars: variable created, but sysfs entry wasn't.\=
n");
+	}
+	return count;
 }
=20
 static ssize_t
@@ -532,7 +538,7 @@ efivar_delete(struct subsystem *sub, con
 	efivar_unregister(search_efivar);
=20
 	/* It's dead Jim.... */
-	return status;
+	return count;
 }
=20
 static VAR_SUBSYS_ATTR(new_var, 0200, dummy, efivar_create);

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAjVu2Iavu95Lw/AkRAk/MAJ9rRM3jXZIi+pr36KktlPEW1xKc+wCggwRJ
gZ8AK8N/CjhyeQLaNlgwDPo=
=NxIW
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
