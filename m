Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262803AbSKRPx6>; Mon, 18 Nov 2002 10:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262804AbSKRPx6>; Mon, 18 Nov 2002 10:53:58 -0500
Received: from ppp-217-133-216-163.dialup.tiscali.it ([217.133.216.163]:21386
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S262803AbSKRPx5>; Mon, 18 Nov 2002 10:53:57 -0500
Subject: [PATCH] Small futex improvement
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-KICrVPqCy/fj6x/IlzRa"
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Nov 2002 17:00:43 +0100
Message-Id: <1037635243.1774.149.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-KICrVPqCy/fj6x/IlzRa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This patch makes the futex code check utime only when waiting.
This makes it possible to do futex wakes without clearing the register
containing the utime parameter.
The code also becomes cleaner.

--- linux-2.5.47_ldb/kernel/futex.c~	2002-11-01 13:31:28.000000000 +0100
+++ linux-2.5.47_ldb/kernel/futex.c	2002-11-17 21:50:41.000000000 +0100
@@ -314,6 +314,23 @@ out:
 	return ret;
 }
=20
+static inline int futex_wait_utime(unsigned long uaddr,
+		      int offset,
+		      int val,
+		      struct timespec* utime)
+{
+	unsigned long time =3D MAX_SCHEDULE_TIMEOUT;
+
+	if (utime) {
+		struct timespec t;
+		if (copy_from_user(&t, utime, sizeof(t)) !=3D 0)
+			return -EFAULT;
+		time =3D timespec_to_jiffies(&t) + 1;
+	}
+
+	return futex_wait(uaddr, offset, val, time);
+}
+
 static int futex_close(struct inode *inode, struct file *filp)
 {
 	struct futex_q *q =3D filp->private_data;
@@ -421,17 +438,9 @@ out:
=20
 asmlinkage int sys_futex(unsigned long uaddr, int op, int val, struct time=
spec *utime)
 {
-	unsigned long time =3D MAX_SCHEDULE_TIMEOUT;
 	unsigned long pos_in_page;
 	int ret;
=20
-	if (utime) {
-		struct timespec t;
-		if (copy_from_user(&t, utime, sizeof(t)) !=3D 0)
-			return -EFAULT;
-		time =3D timespec_to_jiffies(&t) + 1;
-	}
-
 	pos_in_page =3D uaddr % PAGE_SIZE;
=20
 	/* Must be "naturally" aligned */
@@ -440,7 +449,7 @@ asmlinkage int sys_futex(unsigned long u
=20
 	switch (op) {
 	case FUTEX_WAIT:
-		ret =3D futex_wait(uaddr, pos_in_page, val, time);
+		ret =3D futex_wait_utime(uaddr, pos_in_page, val, utime);
 		break;
 	case FUTEX_WAKE:
 		ret =3D futex_wake(uaddr, pos_in_page, val);



--=-KICrVPqCy/fj6x/IlzRa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD4DBQA92Q6rdjkty3ft5+cRAqXXAJdhBCJLXNhUa8kzooX6UQifL8viAJ95kAKE
PBUTTBFMynpXfuJXtZ5d2g==
=PY6K
-----END PGP SIGNATURE-----

--=-KICrVPqCy/fj6x/IlzRa--
