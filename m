Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267364AbUHDR7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267364AbUHDR7j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 13:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267365AbUHDR7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 13:59:39 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:56259 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S267364AbUHDR7f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 13:59:35 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: rusty@rustcorp.com.au
Subject: [PATCH] fix reading string module parameters in sysfs
Date: Wed, 4 Aug 2004 19:58:46 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_WPSEBeZDwkDatL5";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408041958.46589.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_WPSEBeZDwkDatL5
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Reading the contents of a module_param_string through sysfs currently
oopses because the param_get_charp() function cannot operate on a
kparam_string struct. This introduces the required param_get_string.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

=3D=3D=3D=3D=3D include/linux/moduleparam.h 1.8 vs edited =3D=3D=3D=3D=3D
=2D-- 1.8/include/linux/moduleparam.h	Fri May 21 09:50:15 2004
+++ edited/include/linux/moduleparam.h	Wed Aug  4 16:16:23 2004
@@ -73,7 +73,7 @@
 #define module_param_string(name, string, len, perm)			\
 	static struct kparam_string __param_string_##name		\
 		=3D { len, string };					\
=2D	module_param_call(name, param_set_copystring, param_get_charp,	\
+	module_param_call(name, param_set_copystring, param_get_string,	\
 		   &__param_string_##name, perm)
=20
 /* Called on module insert or kernel boot */
@@ -140,6 +140,7 @@
 extern int param_array_get(char *buffer, struct kernel_param *kp);
=20
 extern int param_set_copystring(const char *val, struct kernel_param *kp);
+extern int param_get_string(char *buffer, struct kernel_param *kp);
=20
 int param_array(const char *name,
 		const char *val,
=3D=3D=3D=3D=3D kernel/params.c 1.8 vs edited =3D=3D=3D=3D=3D
=2D-- 1.8/kernel/params.c	Fri May  7 23:22:37 2004
+++ edited/kernel/params.c	Wed Aug  4 16:23:59 2004
@@ -339,6 +339,12 @@
 	return 0;
 }
=20
+int param_get_string(char *buffer, struct kernel_param *kp)
+{
+	struct kparam_string *kps =3D kp->arg;
+	return strlcpy(buffer, kps->string, kps->maxlen);
+}
+
 EXPORT_SYMBOL(param_set_short);
 EXPORT_SYMBOL(param_get_short);
 EXPORT_SYMBOL(param_set_ushort);
@@ -360,3 +366,4 @@
 EXPORT_SYMBOL(param_array_set);
 EXPORT_SYMBOL(param_array_get);
 EXPORT_SYMBOL(param_set_copystring);
+EXPORT_SYMBOL(param_get_string);

--Boundary-02=_WPSEBeZDwkDatL5
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBESPW5t5GS2LDRf4RAhN3AJwMJFAOLeNxt28imDXRmzBu9ULBjACeLoLy
bKlKUuKPllDpicM2Wy+2YxQ=
=4MA+
-----END PGP SIGNATURE-----

--Boundary-02=_WPSEBeZDwkDatL5--
