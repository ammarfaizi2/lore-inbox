Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264076AbUFKP3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264076AbUFKP3y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 11:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264067AbUFKP3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 11:29:54 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:24281 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S264076AbUFKP2H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 11:28:07 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] sparse: __user annotations for ipc compat code
Date: Fri, 11 Jun 2004 17:27:30 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_j9cyA0s8CyEuxnK";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406111727.31160.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_j9cyA0s8CyEuxnK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Add a few __user annotations to the ipc/compat* code.

 compat.c    |   12 ++++++------
 compat_mq.c |   12 ++++++++----
 2 files changed, 14 insertions(+), 10 deletions(-)

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

=3D=3D=3D=3D=3D ipc/compat.c 1.2 vs edited =3D=3D=3D=3D=3D
=2D-- 1.2/ipc/compat.c	Sat May 29 11:12:55 2004
+++ edited/ipc/compat.c	Sun Jun  6 23:03:35 2004
@@ -279,7 +279,7 @@
=20
 	case IPC_STAT:
 	case SEM_STAT:
=2D		fourth.__pad =3D &s64;
+		fourth.__pad =3D (void __user *)&s64;
 		err =3D do_semctl(first, second, third, fourth);
 		if (err < 0)
 			break;
@@ -302,7 +302,7 @@
 		if (err)
 			break;
=20
=2D		fourth.__pad =3D &s64;
+		fourth.__pad =3D (void __user *)&s64;
 		err =3D do_semctl(first, second, third, fourth);
 		break;
=20
@@ -335,7 +335,7 @@
 		goto out;
 	old_fs =3D get_fs();
 	set_fs(KERNEL_DS);
=2D	err =3D sys_msgsnd(first, p, second, third);
+	err =3D sys_msgsnd(first, (struct msgbuf __user *)p, second, third);
 	set_fs(old_fs);
 out:
 	kfree(p);
@@ -374,7 +374,7 @@
 		goto out;
 	old_fs =3D get_fs();
 	set_fs(KERNEL_DS);
=2D	err =3D sys_msgrcv(first, p, second, msgtyp, third);
+	err =3D sys_msgrcv(first, (struct msgbuf __user *)p, second, msgtyp, thir=
d);
 	set_fs(old_fs);
 	if (err < 0)
 		goto free_then_out;
@@ -457,7 +457,7 @@
=20
 	old_fs =3D get_fs();
 	set_fs(KERNEL_DS);
=2D	err =3D sys_msgctl(first, second, buf);
+	err =3D sys_msgctl(first, second, (struct msqid_ds __user *)buf);
 	set_fs(old_fs);
=20
 	return err;
@@ -630,7 +630,7 @@
=20
 	old_fs =3D get_fs();
 	set_fs(KERNEL_DS);
=2D	err =3D sys_shmctl(shmid, cmd, buf);
+	err =3D sys_shmctl(shmid, cmd, (struct shmid_ds __user *)buf);
 	set_fs(old_fs);
=20
 	return err;
=3D=3D=3D=3D=3D ipc/compat_mq.c 1.2 vs edited =3D=3D=3D=3D=3D
=2D-- 1.2/ipc/compat_mq.c	Sat May 29 11:12:55 2004
+++ edited/ipc/compat_mq.c	Sun Jun  6 23:15:29 2004
@@ -67,7 +67,8 @@
=20
 	oldfs =3D get_fs();
 	set_fs(KERNEL_DS);
=2D	ret =3D sys_mq_open(name, oflag, mode, &attr);
+	ret =3D sys_mq_open((char __user *)name, oflag, mode,
+			(struct mq_attr __user *)&attr);
 	set_fs(oldfs);
=20
 	putname(name);
@@ -86,7 +87,7 @@
 	u_ts =3D compat_alloc_user_space(sizeof(*u_ts));
 	if (get_compat_timespec(&ts, u_abs_timeout)
 		|| copy_to_user(u_ts, &ts, sizeof(*u_ts)))
=2D		return ERR_PTR(-EFAULT);
+		return (void __user *)ERR_PTR(-EFAULT);
=20
 	return u_ts;
 }
@@ -161,7 +162,8 @@
=20
 	oldfs =3D get_fs();
 	set_fs(KERNEL_DS);
=2D	ret =3D sys_mq_notify(mqdes, &notification);
+	ret =3D sys_mq_notify(mqdes,
+		(const struct sigevent __user *)&notification);
 	set_fs(oldfs);
=20
 	return ret;
@@ -187,7 +189,9 @@
=20
 	oldfs =3D get_fs();
 	set_fs(KERNEL_DS);
=2D	ret =3D sys_mq_getsetattr(mqdes, p_mqstat, p_omqstat);
+	ret =3D sys_mq_getsetattr(mqdes,
+		(const struct mq_attr __user *)p_mqstat,
+		(struct mq_attr __user *)p_omqstat);
 	set_fs(oldfs);
=20
 	if (ret)

--Boundary-02=_j9cyA0s8CyEuxnK
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAyc9j5t5GS2LDRf4RAkECAJ9gB25gvvIo8/q/jYXBAplb68SeZQCgiolh
3V3OCsfdMEdxdnpKA3wFHDw=
=8+Qy
-----END PGP SIGNATURE-----

--Boundary-02=_j9cyA0s8CyEuxnK--
