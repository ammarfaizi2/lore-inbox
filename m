Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316677AbSHOKeK>; Thu, 15 Aug 2002 06:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316682AbSHOKeJ>; Thu, 15 Aug 2002 06:34:09 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:55775 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S316677AbSHOKeI>; Thu, 15 Aug 2002 06:34:08 -0400
Date: Thu, 15 Aug 2002 13:32:47 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] further smplock.h cleanups against 2.5.31
Message-ID: <20020815103247.GA6772@alhambra.actcom.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch builds upon your smplock.h cleanup. It does the following:=20

- move various defines to static inline functions for type safety of parame=
ters.
- move __inline__ to inline.=20
- add kernel_locked_for_task(task) and make kernel_locked() used it.=20
- add do { } while (0) to macros

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.519   -> 1.521 =20
#	include/asm-i386/smplock.h	1.9     -> 1.11  =20
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/15	mulix@alhambra.merseine.nu	1.520
# further cleanups for smplock.h
# - move various defines to static inline functions for type safety of para=
meters.
# - move __inline__ to inline.=20
# - add kernel_locked_for_task(task) and make kernel_locked() used it.=20
# - add do { } while (0) to macros
# --------------------------------------------
# 02/08/15	mulix@alhambra.merseine.nu	1.521
# check if the kernel is locked when unlocking via the proper interface
# --------------------------------------------
#
diff -Nru a/include/asm-i386/smplock.h b/include/asm-i386/smplock.h
--- a/include/asm-i386/smplock.h	Thu Aug 15 13:30:43 2002
+++ b/include/asm-i386/smplock.h	Thu Aug 15 13:30:43 2002
@@ -10,29 +10,36 @@
=20
 extern spinlock_t kernel_flag;
=20
-#define kernel_locked()		(current->lock_depth >=3D 0)
+static inline int kernel_locked_for_task(struct task_struct* task)
+{
+	return (task->lock_depth >=3D 0);=20
+}
+
+static inline int kernel_locked(void)
+{
+	return kernel_locked_for_task(current);=20
+}
=20
-#define get_kernel_lock()	spin_lock(&kernel_flag)
-#define put_kernel_lock()	spin_unlock(&kernel_flag)
+#define get_kernel_lock()	do { spin_lock(&kernel_flag); } while (0)
+#define put_kernel_lock()	do { spin_unlock(&kernel_flag); } while (0)
=20
 /*
  * Release global kernel lock and global interrupt lock
  */
-#define release_kernel_lock(task)		\
-do {						\
-	if (unlikely(task->lock_depth >=3D 0))	\
-		put_kernel_lock();		\
-} while (0)
+static inline void release_kernel_lock(struct task_struct* task)
+{
+	if (unlikely(kernel_locked_for_task(task)))
+		put_kernel_lock();
+}
=20
 /*
  * Re-acquire the kernel lock
  */
-#define reacquire_kernel_lock(task)		\
-do {						\
-	if (unlikely(task->lock_depth >=3D 0))	\
-		get_kernel_lock();		\
-} while (0)
-
+static inline void reacquire_kernel_lock(struct task_struct* task)
+{
+	if (unlikely(kernel_locked_for_task(task)))
+		get_kernel_lock();=20
+}
=20
 /*
  * Getting the big kernel lock.
@@ -41,7 +48,7 @@
  * so we only need to worry about other
  * CPU's.
  */
-static __inline__ void lock_kernel(void)
+static inline void lock_kernel(void)
 {
 	int depth =3D current->lock_depth+1;
 	if (!depth)
@@ -49,9 +56,9 @@
 	current->lock_depth =3D depth;
 }
=20
-static __inline__ void unlock_kernel(void)
+static inline void unlock_kernel(void)
 {
-	if (current->lock_depth < 0)
+	if (!kernel_locked())
 		BUG();
 	if (--current->lock_depth < 0)
 		put_kernel_lock();


--=20
"Hmm.. Cache shrink failed - time to kill something?
 Mhwahahhaha! This is the part I really like. Giggle."
					 -- linux/mm/vmscan.c
http://vipe.technion.ac.il/~mulix/	http://syscalltrack.sf.net

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9W4NPKRs727/VN8sRAjnVAJ0evzU7di298RCPmvSeZk3hDsEU7wCfYYhm
OCc2Os/0Mpwlxiqb/fYV8Bg=
=mP+n
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
