Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262876AbSKRQIk>; Mon, 18 Nov 2002 11:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262887AbSKRQIj>; Mon, 18 Nov 2002 11:08:39 -0500
Received: from ppp-217-133-216-163.dialup.tiscali.it ([217.133.216.163]:24714
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S262876AbSKRQIh>; Mon, 18 Nov 2002 11:08:37 -0500
Subject: [PATCH] dup_mmap tiny optimization
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-VjG8IfptYwcgTUKvlMct"
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Nov 2002 17:15:28 +0100
Message-Id: <1037636128.1774.154.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VjG8IfptYwcgTUKvlMct
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This patch moves retval =3D -ENOMEM out of the vma loop and after the
fail_nomem label.
The fail label is added and is used when retval is already set.

--- linux-2.5.48_ldb/kernel/fork.c~	2002-11-18 05:29:22.000000000 +0100
+++ linux-2.5.48_ldb/kernel/fork.c	2002-11-18 17:08:55.000000000 +0100
@@ -238,7 +238,6 @@ static inline int dup_mmap(struct mm_str
 	for (mpnt =3D current->mm->mmap ; mpnt ; mpnt =3D mpnt->vm_next) {
 		struct file *file;
=20
-		retval =3D -ENOMEM;
 		if(mpnt->vm_flags & VM_DONTCOPY)
 			continue;
 		if (mpnt->vm_flags & VM_ACCOUNT) {
@@ -283,7 +282,7 @@ static inline int dup_mmap(struct mm_str
 			tmp->vm_ops->open(tmp);
=20
 		if (retval)
-			goto fail_nomem;
+			goto fail;
 	}
 	retval =3D 0;
 	build_mmap_rb(mm);
@@ -293,6 +292,8 @@ out:
 	up_write(&oldmm->mmap_sem);
 	return retval;
 fail_nomem:
+	retval =3D -ENOMEM;
+  fail:
 	vm_unacct_memory(charge);
 	goto out;
 }


--=-VjG8IfptYwcgTUKvlMct
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA92RIfdjkty3ft5+cRAoDxAKCy87TgdRc2Ps16H4dKvVyNI+DwrACggHjr
O9W5b6pFCi1hEWYoM7Pi0So=
=Pddj
-----END PGP SIGNATURE-----

--=-VjG8IfptYwcgTUKvlMct--
