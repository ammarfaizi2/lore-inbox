Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWBXPHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWBXPHu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 10:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWBXPHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 10:07:49 -0500
Received: from mout2.freenet.de ([194.97.50.155]:19424 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S932243AbWBXPHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 10:07:48 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: akpm@osdl.org
Subject: [PATCH] Uninline sys_mmap common code (reduce binary size)
Date: Fri, 24 Feb 2006 16:07:38 +0100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <200602241607.38732.mbuesch@freenet.de>
Content-Type: multipart/signed;
  boundary="nextPart10975491.uQKDxt7ZDv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart10975491.uQKDxt7ZDv
Content-Type: multipart/mixed;
  boundary="Boundary-01=_6Ey/D7DuSJfhC1v"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_6Ey/D7DuSJfhC1v
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This patch removes the inlinining of the new vs old mmap system
call common code.
This reduces the size of the resulting vmlinux for defconfig as follows:

mb@pc1:~/develop/git/linux-2.6$ size vmlinux.mmap*
   text    data     bss     dec     hex filename
3303749  521524  186564 4011837  3d373d vmlinux.mmapinline
3303557  521524  186564 4011645  3d367d vmlinux.mmapnoinline

The new sys_mmap2() has also one function call overhead removed, now.
(probably it was already optimized to a jmp before, but anyway...)


diff --git a/arch/i386/kernel/sys_i386.c b/arch/i386/kernel/sys_i386.c
index a4a6197..8fdb1fb 100644
=2D-- a/arch/i386/kernel/sys_i386.c
+++ b/arch/i386/kernel/sys_i386.c
@@ -40,14 +40,13 @@ asmlinkage int sys_pipe(unsigned long __
 	return error;
 }
=20
=2D/* common code for old and new mmaps */
=2Dstatic inline long do_mmap2(
=2D	unsigned long addr, unsigned long len,
=2D	unsigned long prot, unsigned long flags,
=2D	unsigned long fd, unsigned long pgoff)
+asmlinkage long sys_mmap2(unsigned long addr, unsigned long len,
+			  unsigned long prot, unsigned long flags,
+			  unsigned long fd, unsigned long pgoff)
 {
 	int error =3D -EBADF;
=2D	struct file * file =3D NULL;
+	struct file *file =3D NULL;
+	struct mm_struct *mm =3D current->mm;
=20
 	flags &=3D ~(MAP_EXECUTABLE | MAP_DENYWRITE);
 	if (!(flags & MAP_ANONYMOUS)) {
@@ -56,9 +55,9 @@ static inline long do_mmap2(
 			goto out;
 	}
=20
=2D	down_write(&current->mm->mmap_sem);
+	down_write(&mm->mmap_sem);
 	error =3D do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
=2D	up_write(&current->mm->mmap_sem);
+	up_write(&mm->mmap_sem);
=20
 	if (file)
 		fput(file);
@@ -66,13 +65,6 @@ out:
 	return error;
 }
=20
=2Dasmlinkage long sys_mmap2(unsigned long addr, unsigned long len,
=2D	unsigned long prot, unsigned long flags,
=2D	unsigned long fd, unsigned long pgoff)
=2D{
=2D	return do_mmap2(addr, len, prot, flags, fd, pgoff);
=2D}
=2D
 /*
  * Perform the select(nd, in, out, ex, tv) and mmap() system
  * calls. Linux/i386 didn't use to be able to handle more than
@@ -101,7 +93,8 @@ asmlinkage int old_mmap(struct mmap_arg_
 	if (a.offset & ~PAGE_MASK)
 		goto out;
=20
=2D	err =3D do_mmap2(a.addr, a.len, a.prot, a.flags, a.fd, a.offset >> PAGE=
_SHIFT);
+	err =3D sys_mmap2(a.addr, a.len, a.prot, a.flags,
+			a.fd, a.offset >> PAGE_SHIFT);
 out:
 	return err;
 }


=2D-=20
Greetings Michael.

--Boundary-01=_6Ey/D7DuSJfhC1v
Content-Type: text/x-diff;
  charset="us-ascii";
  name="uninline-mmap-common.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="uninline-mmap-common.patch"

diff --git a/arch/i386/kernel/sys_i386.c b/arch/i386/kernel/sys_i386.c
index a4a6197..8fdb1fb 100644
=2D-- a/arch/i386/kernel/sys_i386.c
+++ b/arch/i386/kernel/sys_i386.c
@@ -40,14 +40,13 @@ asmlinkage int sys_pipe(unsigned long __
 	return error;
 }
=20
=2D/* common code for old and new mmaps */
=2Dstatic inline long do_mmap2(
=2D	unsigned long addr, unsigned long len,
=2D	unsigned long prot, unsigned long flags,
=2D	unsigned long fd, unsigned long pgoff)
+asmlinkage long sys_mmap2(unsigned long addr, unsigned long len,
+			  unsigned long prot, unsigned long flags,
+			  unsigned long fd, unsigned long pgoff)
 {
 	int error =3D -EBADF;
=2D	struct file * file =3D NULL;
+	struct file *file =3D NULL;
+	struct mm_struct *mm =3D current->mm;
=20
 	flags &=3D ~(MAP_EXECUTABLE | MAP_DENYWRITE);
 	if (!(flags & MAP_ANONYMOUS)) {
@@ -56,9 +55,9 @@ static inline long do_mmap2(
 			goto out;
 	}
=20
=2D	down_write(&current->mm->mmap_sem);
+	down_write(&mm->mmap_sem);
 	error =3D do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
=2D	up_write(&current->mm->mmap_sem);
+	up_write(&mm->mmap_sem);
=20
 	if (file)
 		fput(file);
@@ -66,13 +65,6 @@ out:
 	return error;
 }
=20
=2Dasmlinkage long sys_mmap2(unsigned long addr, unsigned long len,
=2D	unsigned long prot, unsigned long flags,
=2D	unsigned long fd, unsigned long pgoff)
=2D{
=2D	return do_mmap2(addr, len, prot, flags, fd, pgoff);
=2D}
=2D
 /*
  * Perform the select(nd, in, out, ex, tv) and mmap() system
  * calls. Linux/i386 didn't use to be able to handle more than
@@ -101,7 +93,8 @@ asmlinkage int old_mmap(struct mmap_arg_
 	if (a.offset & ~PAGE_MASK)
 		goto out;
=20
=2D	err =3D do_mmap2(a.addr, a.len, a.prot, a.flags, a.fd, a.offset >> PAGE=
_SHIFT);
+	err =3D sys_mmap2(a.addr, a.len, a.prot, a.flags,
+			a.fd, a.offset >> PAGE_SHIFT);
 out:
 	return err;
 }

--Boundary-01=_6Ey/D7DuSJfhC1v--

--nextPart10975491.uQKDxt7ZDv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD/yE6lb09HEdWDKgRArwgAJ9YCEPtEniw8+OLgz0Z65AveVbVkwCeMpHP
giI6Gig4NDOCae9fWyigPK4=
=Eglr
-----END PGP SIGNATURE-----

--nextPart10975491.uQKDxt7ZDv--
